Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D8DC433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75CB060724
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 75CB060724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 066C26E139;
	Sun, 24 Oct 2021 13:32:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C796989E3B
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yv8TJjVDShuRriGcm3adoYMNs3Sd7E3WhFKFbRwleWSAzNGpv8N2VjAZ9gzSqPge1LuI9yhOhfjM0za/OTrtqucF5ohCLLO0pzGd6AK2uRExzaqVf0aepSzzMfUNuUXGRlTbVvqmL/4FCxzmUD0f4R6g5XlG3IQp12WAqpXmus1ymav0DQcQejVLPhablW7yE00jK4KanXgyiDXljbKDhRJ5z0fpp6rFfpaCohNLqeQwNO5ARmADosKFKaAC2w+J6LdtYP9kV1XZijhA462k2o2ANXyKWhIKnGXA/EnafwYP4Miv9TyIG/ris0rvB0cuVHz8+2tg7qeKt1uIRO1oBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tODCWcy+finE1V+cmCfu2cGDNVqPSgxiL0Usb0eM5F0=;
 b=gpx/N/DXhSJ3SXPbrwA3Vqm1DTsW1ylTV+F5Msq3cAtSvDNBvYlnfKTRE47yiBZWXmDGaNrUEltmewjVbfzzfCkbT3wwS7tRdhxEb0kFyVv3ACeJnxMUTeK8viGyyAxCXxi7syG8eQIto3SrW11265XXlfode4t9w+LTMlO+piD3omeR+dyQ8snGvqcwEcRk+pnf+sClNXGDkX3jZPRd/0ce1h7/ANHJwx3JBWgzH+qlEuomcJoENNP3ps+R7pJXVa60r+ko36hPGejbamhGxrwfm7kGU9W5alHF9Xy3R4JiER6A4K6LUJF8YLNDvmPVC4bL6HRVZ77ulHv/UWGWGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tODCWcy+finE1V+cmCfu2cGDNVqPSgxiL0Usb0eM5F0=;
 b=HAAI8fjlusuKDw66czAv70GrvpP7QJqZA3H/iDjMnXJVFhjCfk2QVv0ipbCnAKjRy5AIvpeDlKBwP7ENwUegSlqCriE7LEL5UPIUW9zUu7o4rrELuRasiJt3KIBvBPag4whvjVARPaws70OtiGcqqC3MR1/oixz1KWGa1oazhU4=
Received: from MW4P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::9)
 by BYAPR12MB2872.namprd12.prod.outlook.com (2603:10b6:a03:12e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Sun, 24 Oct
 2021 13:32:40 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::f2) by MW4P222CA0004.outlook.office365.com
 (2603:10b6:303:114::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:39 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:37 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito <Jimmy.Kizito@amd.com>
Subject: [PATCH 27/33] drm/amd/display: FEC configuration for dpia links in
 MST mode
Date: Sun, 24 Oct 2021 09:31:35 -0400
Message-ID: <20211024133141.239861-28-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22edd759-6490-4f85-d1ba-08d996f2c017
X-MS-TrafficTypeDiagnostic: BYAPR12MB2872:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2872A180654D1F5F9690CC4498829@BYAPR12MB2872.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C3RotvxphZnVum6aVgnAKpm8zEDjEvslnTPL6HpHy4YuosOxRjkTvYn3j5Wiyyk/7o6ZPl26oUp08r/+z7YCNY9YdaY00bmaO3+7HWiiqrXHTq2Gl4S3S4BkW5MJr4qKd1mstohhQFmi65pTLWrneBdueK+QhZg3+P43O4qkpctLlg08Ct9JNasIlG7WaHqD9Ee2ZI05KaL2sCAVW+YSoxDejdzbl7t2uy+mLc5+3vbPxwq3ygg39KHeM5h98i8fR6k31N3JKI5046mxLQQR3rCqVfdM91kHc8Yc/LhLh+BTLiI9lVSOum0Zl82brqEhvk5fgX4er9cAgodskrTa7lNSmhtQfsDnGQdtT7FlYFDdOS15jLKOYbwPt+zEXMvfUNS9AdIzjgyIxYcBGRjCskH81gjhW9Szilq/hLFU8lgSY74bAheTRrtDNlQSX9+T6ETVjuRAitp04b+uoQn7ZSTzG465XoBa/aoX1i+QgmQKgb0qXrAoL97G9BTLLeXykEiD+KkULjTqVtFIW7f6DM9ZlRAjhjArcfQdMz31yoT+tDYPsdS+VTgxSL3yYm95T3f8RbXUMAg2M/Bv6RzE6+33DKz4XXMn3hZ6ZEQp8LnDagvlgI/PPxGcTLU9E2gYKoKtDsZhLvMHsnokLNbJSADat26C6ckXbcEFf8DkFzGWuuq/yTqjQsYJiFqwlwMKmY9/rxwMpX1JeWiZLH/jH1hR+wu6dl7jsNWrL+9VXPI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(8936002)(6916009)(81166007)(36860700001)(16526019)(26005)(70586007)(316002)(4326008)(82310400003)(186003)(47076005)(508600001)(36756003)(1076003)(2906002)(86362001)(2616005)(336012)(356005)(83380400001)(426003)(8676002)(70206006)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:39.7165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22edd759-6490-4f85-d1ba-08d996f2c017
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2872
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
To fix the check condition for fec enable for dpia links in MST mode.

[How]
dc_link_should_enable_fec() to be used to check whether fec should be
enabled in MST mode.

Cc: Wayne Lin <wayne.lin@amd.com>
Reviewed-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
index 19b085d84b1f..ee6f13bef377 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
@@ -476,7 +476,7 @@ void dcn31_link_encoder_enable_dp_mst_output(
 
 		if (link) {
 			dpia_control.dpia_id = link->ddc_hw_inst;
-			dpia_control.fec_rdy = link->fec_state == dc_link_fec_ready ? 1 : 0;
+			dpia_control.fec_rdy = dc_link_should_enable_fec(link);
 		} else {
 			DC_LOG_ERROR("%s: Failed to execute DPIA enable DMUB command.\n", __func__);
 			BREAK_TO_DEBUGGER();
-- 
2.25.1

