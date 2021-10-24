Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB749C433FE
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 835F560724
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 835F560724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1278E6E14B;
	Sun, 24 Oct 2021 13:32:47 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2061.outbound.protection.outlook.com [40.107.212.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37DB289E3B
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAH8ggu6EA96EO2M/G8vql+zdAUyyHVmbD6+cBYJ8Z825pygc4YcOv9zTmC5XbYRQcZcqt6SPgC1g1GJj42KZKeiifUO+xq/F6cQs0g/Jnwcuu69hBfRAK1ubq1K0dYwhdMP2tzKhTRk+QmTHHo9pQlLNyNtRgw904Kn/TG5D+5Fn7ctSG3l0mKTPAqTa/b68dNqhAiUGRP0EiATWRRpRR/4WeZkDGQwB0NZEbdD9NxEuHhJcyR0HdnrbT6erd+JzBSogs0A4avXt/tM2fhaB1pwNRcCbSv3zwRTD2fePGwbdxKfmGPL4WzIBO6ZGbRgJH3jBdEz2xn31VY/PtgDcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKPaCazM37A1b6KgAGi/dYm/8SMwFKZNPQkm9yQJFkc=;
 b=XYjbyzCNiwuMvAcC5KnvRSeF7GJtPDmJHT0Lj3UKyDY6KDhQZ2bRtgVXxgprf6ovxVz7uGj5E6YY1uhEjLZnPi8o3sYKfEmM6okPqkSZtBwjNlc5KVAlTUqaHX//uOlWm+DkkC9FTQW+pYMVqZMDIwA9AwH9uY9fjBe5PDjsCiZsc17QgSwZGFL7PBu0kbqr2RBgBtJ9rRB8Kdr2rvu48jnaDkDJA+RpqJyEmDMdpZ5P+jOWlEkYRdAnBf6HruZ93HtTYEfCec8/GcqnrPcyAYwonvXcoPsW1iKA39+cwhh7ShmIQMLk/xzVjDVzPDnwUWkF3A7FW9AtcBGnHyws+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKPaCazM37A1b6KgAGi/dYm/8SMwFKZNPQkm9yQJFkc=;
 b=XV1M/1e1mO3Bc+PxV4e67yBi106Ric4ZkH/GPTzFhzWAPxYJhjBO8uSjMe2JDPVWVBd6Na3wZWDvlAV3f0Jm0g/dNuyTt9FgxFKoXXc23IHD6u6jtilOjGceOTTiixuhZ0so+lv1D+J+6CsXU1yrBq1GfrsN52BEGBlKy0NQlu0=
Received: from MW4P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::23)
 by DM5PR1201MB0025.namprd12.prod.outlook.com (2603:10b6:4:53::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Sun, 24 Oct
 2021 13:32:38 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::e0) by MW4P223CA0018.outlook.office365.com
 (2603:10b6:303:80::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:38 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:36 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito <Jimmy.Kizito@amd.com>
Subject: [PATCH 26/33] drm/amd/display: FEC configuration for dpia links
Date: Sun, 24 Oct 2021 09:31:34 -0400
Message-ID: <20211024133141.239861-27-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 83010168-a7b4-403e-a89f-08d996f2bf4a
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0025:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00258DE3BF8E13FB1D0AFBA598829@DM5PR1201MB0025.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tqeI+/HJDE1UE2BN+ZuVwb09kuug/n169eNSxilg8ohErOkDEz6eivWvJpjXGXH/MfJ9r0ytEOPhhLUo3/rzA2dQ/ceaLK1DvFUbZOVrxPRmLtOqy66BDXOjiZq6E/+zFABjnoTLOtkyZo+ikUCVhKTDgqMfd+EXguHInGyVh3WbPl23lK44lAS+EKkY8rzJcaqzZhx939/JtGrMDF/kMSF+M9ywQpyJN1SyRZuC7sB0vFd8ItVcTe7VyGQ4pA298rqH0ZSL4BPOse9txZOeC+f9F+pNPPG9CRob1F31V+jXYixatB8iPzMYy48BtJXbPozwiYO9jNLo1VQ/wl4NiJrcka3ZmMWLy7V98H7/IHbUWMrIwiev1CY+cjBOpjcF6SiNEia67CkdR1+2e0sWrTatnkJjinLoMZ/Zb44N6HbQT1aHyYak6bGAkpX7U1OdHhJXMqq3skuGxqajM36Zhw1XlUQTnc2uhSNh9bLZNVl/FYg5ikr54GBbfLgieTAJblLWoC5cvV3wD9LDgzoaFlRw/eD9t00KjqeLRBZtmZuJZ7HgrzImHM67n53G/FtvKTjm6+WPfXfY2A0qofyX/oKzxw/MWzdzVD6UUCWW1VSGcp0LtM5xjj2ZMpcGbTtQyN4MNwUegcHLdUG06s2QqUU9mR7jAAY9AE/dr8vBJXOeQLa9FeulrV1k0m0DhsXqK59TorFB/JtYc9cwDc0ozpDh/sXqap2/josNdjckm30=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(186003)(16526019)(1076003)(8936002)(2616005)(508600001)(8676002)(26005)(316002)(5660300002)(356005)(83380400001)(81166007)(70206006)(4326008)(82310400003)(36860700001)(86362001)(36756003)(2906002)(47076005)(70586007)(54906003)(426003)(336012)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:38.3729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83010168-a7b4-403e-a89f-08d996f2bf4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0025
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
To fix the check condition for fec enable for dpia links.

[How]
dc_link_should_enable_fec() to be used to check whether fec should be
enabled.

Cc: Wayne Lin <wayne.lin@amd.com>
Reviewed-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
index 8f8eee475144..19b085d84b1f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
@@ -431,7 +431,7 @@ void dcn31_link_encoder_enable_dp_output(
 
 		if (link) {
 			dpia_control.dpia_id = link->ddc_hw_inst;
-			dpia_control.fec_rdy = link->fec_state == dc_link_fec_ready ? 1 : 0;
+			dpia_control.fec_rdy = dc_link_should_enable_fec(link);
 		} else {
 			DC_LOG_ERROR("%s: Failed to execute DPIA enable DMUB command.\n", __func__);
 			BREAK_TO_DEBUGGER();
-- 
2.25.1

