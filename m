Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2A0C433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DEAF60724
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3DEAF60724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DD406E150;
	Sun, 24 Oct 2021 13:32:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29A2F89E3B
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dh9Gv//h46QHKr8qXeJavutO27lUqwSxrH+TH6aERdbR+TQxQj+xDSGb3R9VEnazBx+GYcNhrzWYeAOWrYfGRewumeu0bzhI6mLN7dd+qYnsxaPDCHGNiNESqlVr4bTecGk6AXnPLRoPmi4Eau6UJtc7U1mR0kb1JrLV/TTZeeRhTkDa2WaJOmFF8SVK+bzhZcroM6+BPXxzE8MGAY7dn5UsVTOGyFKuCyLaLuCgw1dGzHWdx4AKF8WlnMucwxFm/QKQsDBmG3VNkC1KDm5DDy1MGlksXOAfGlO1olqD8V390xxNS3i+sLvPgfgrTubAOTV5IFXUaBx1pBWxN4y/cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5haznmOVfMlrgCDeR1WOMrGIOVgsK3XlYDBopmeTp0=;
 b=l0GmvYkFLCO3GF99Bl485rMO6EtJq0BWJ9lUDCOvdCeOfnWYsZY1Ehomm0C9oVymVfMhZEvqL5DQKwbrkh0th+KFcrmBaHX6PSkK9LMXY+TTTeaUCmG+dCXZ75EPrzUq3xbpyaqdoCh9M1YLxzKImU3lJiVXMyrGU5Xu4dS+/frrR7BIxjpgCMbfbOuzr+D6zltz5G8RF5ray7V5YekdcWGC6XTc62EdzIyDdzfaVMwNPLDYRzPfXxRIHbyvU+hYVoFFfzgdGjnoun0ABy4qt4V05nckHtGUhngDE3vhuU1YrRsfIgEzIvgm8h1j6OujPM3R8LXzfgvmxbG4hMZI2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5haznmOVfMlrgCDeR1WOMrGIOVgsK3XlYDBopmeTp0=;
 b=bc5xBFfMZGi1Oql7gp7yHPdBwXnXADwROyI5jYDoS0gE2CXgYlvwnNr8u81tf7gp/IgR3lB6xy0OpCrLHgej9ZQ9cTbQ1NWPQPNyihhEyXDAJRfiFZYUxrw4sQKtnCDvxU3Rm5nbn2N7GeHHHBHhpOvxuHweAps9BPSaV2d+z4A=
Received: from MW4P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::33)
 by MW3PR12MB4393.namprd12.prod.outlook.com (2603:10b6:303:2c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Sun, 24 Oct
 2021 13:32:38 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::19) by MW4P223CA0028.outlook.office365.com
 (2603:10b6:303:80::33) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:37 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:35 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Jimmy Kizito <Jimmy.Kizito@amd.com>, Jun Lei
 <Jun.Lei@amd.com>
Subject: [PATCH 25/33] drm/amd/display: Add workaround flag for EDID read on
 certain docks
Date: Sun, 24 Oct 2021 09:31:33 -0400
Message-ID: <20211024133141.239861-26-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d26ff80e-c6e6-4f3e-c7f6-08d996f2beff
X-MS-TrafficTypeDiagnostic: MW3PR12MB4393:
X-Microsoft-Antispam-PRVS: <MW3PR12MB439385DD270846E30695A57998829@MW3PR12MB4393.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nsflpkYUUGElj7MK2poMA2db3tEniDZuLHqVc6PeSfztG1a4HjtiYXdPHptzmvaUwhdpTcluKHwM6MKOvp7aHJwQKlfWu1kShN8FF96edSxlej7LpeHL6XdcGLu0gqVKObip6K7Tv0T+krekFPS7Gm9cPnos+moZUIcEogtueqnmD2H2XIZ9P7SeAxLfPvY/I2QjQQ6hVbYk7Je/ryF3oyqcAf+JJepUrkx/n6puZKUzsemtFY81S8PAv3+OZadYgHiL1I8vhC5LUYnNjn/dCOVd5ZpTrCWF+uf3t7gPI75xPwSq8cR9Rd3syX4JEYG1s4EUNmpTOM8VfFkG3tVLWCjWyvDvfxQ7J1sT74aRlVZ1zFzZ7e2Lpss7zc8vWsmXivEWeJlPmn0CX9e2gAFSc24SC+c/zxL72mIngAdlCdbMOu4QvPcWIQlZKSr2tVs6N0tol5QwegwZz67l13hW0He74HtB+Hhw7mQAop8zHoo8/ADwUjActu53jKS5kRgl1TxBgjyis3nS2GUpA6yQ5jc0gUXwbxLkB5/252TDYYeJbJv4KEWk1g9xOoqaqPHb+sB/hBCVdZGxTBsWmBUVL8Jp+9NNvPVmA6Rfww+ugn/Tq9u19nNxjc6JyQqOr7x7TAW1CQiaE9o+V7LgnNWZx72KFHKGSnkkoqHUmDwiYU5y7Br+QgJRBgeqqHryQVh88scyb6Ullmq7CYgf6Tsufmash2obZNrxycbMmB6MPXs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(356005)(5660300002)(16526019)(186003)(8936002)(70206006)(70586007)(336012)(81166007)(316002)(4326008)(508600001)(8676002)(2906002)(54906003)(426003)(36860700001)(36756003)(86362001)(82310400003)(2616005)(1076003)(47076005)(26005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:37.8812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d26ff80e-c6e6-4f3e-c7f6-08d996f2beff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393
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

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
Certain docks appear to NAK I2C writes to the segment pointer with the
MOT (middle of transaction) bit clear. This behaviour can cause EDID
reads from higher segments to fail.

[How]
Add workaround flag for links which connect to docks exhibiting this
issue.

Cc: Wayne Lin <wayne.lin@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 +++
 drivers/gpu/drm/amd/display/dc/dc_link.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index b36678669283..e475fbd4d341 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1765,6 +1765,9 @@ static bool dc_link_construct_dpia(struct dc_link *link,
 
 	link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
 
+	/* Some docks seem to NAK I2C writes to segment pointer with mot=0. */
+	link->wa_flags.dp_mot_reset_segment = true;
+
 	return true;
 
 ddc_create_fail:
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index b975d1307eff..1327624548a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -190,6 +190,7 @@ struct dc_link {
 		bool dp_keep_receiver_powered;
 		bool dp_skip_DID2;
 		bool dp_skip_reset_segment;
+		bool dp_mot_reset_segment;
 	} wa_flags;
 	struct link_mst_stream_allocation_table mst_stream_alloc_table;
 
-- 
2.25.1

