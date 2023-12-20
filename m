Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1976CC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 16:37:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94E9B10E5F5;
	Wed, 20 Dec 2023 16:37:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DAB210E5F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 16:37:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUBoiClT0+OuoIhj9IQrRRn9xn0l98M8yfHIqg2C6yBKftLeofuF89kuHOmN1S3a1ynWiFI7dhDDF3SOLAbxIlTsNq9viJjKyDjgguA+DgPCmWd/iOB9xIa+XtjVdLeGrEKEytUPHn8LheYRuEG1++4H7IKDSxbskM19YiImc25jR3jYpkbAYMUKuGqUmCs6zRIIyLC7LR9NKJ//qSzE0oHRBP1WM8fwyrV5X9pcKGGlue8tgRXXkP0v6Ck6AsFZNbrjNhCH1RxHeGpb/cg87TEBFGe85CHfjjvsPMXMHGAUzq34ex2BZQpnMsNVq0CGE/XmMMnNxmUwtX1FjywLUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4el/MuanPjaNiheO2t0x0gNU2kjD2gS/JN4fuV7go8=;
 b=deE5kDpfmXz8BS8gZTWzlyH0j8Hvp81UzrKOs+K/cuAvmsstDg2kJ5mKQ074mgK03ZqOON9NcAJOtqCOAFwiswj8BYPAaBJ5gRQFQdHbjEBtTz6hceGzUY72evpfImw0sZCnsD6PRY4U+Fa9NwlZiCUC4GR70kir72yavFkGkjqYLHAKMCCvdcSFSr4wv+mJh9wMN/g6F8MJvkuCF1tnf8ajtFc1oh/ZuSnrfmzp50JwO3CxpZDO3Qwmowg62tGc41PPai2/5JyaRBUl54rkcN78OHLzgzSzOGihTJmyFIm+DgjPKAPdLqsIdLmzxvDvwJC9wUQW86yqblusRUjJQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4el/MuanPjaNiheO2t0x0gNU2kjD2gS/JN4fuV7go8=;
 b=k4SbCVERKJ/jCYo0OkMfKlwdSor1tPfJe+QbTumWtaW7zj+9xGTqvcPqtq07uk3x6L8GcbSaasTyxbDFSNOcsZWXW5pb7IrGZdFbso9cJ3apTu2K39sQnjjgpJWBbTHzFmniNcnx+s2/tkhXFKtGG7q/HgtOIc4PtjY/Qt68C9g=
Received: from MN2PR16CA0044.namprd16.prod.outlook.com (2603:10b6:208:234::13)
 by MW4PR12MB6975.namprd12.prod.outlook.com (2603:10b6:303:20a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 16:37:09 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::e9) by MN2PR16CA0044.outlook.office365.com
 (2603:10b6:208:234::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Wed, 20 Dec 2023 16:37:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 16:37:08 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 10:37:02 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/20] drm/amd/display: Switch DMCUB notify idle command to
 NO_WAIT
Date: Wed, 20 Dec 2023 09:33:45 -0700
Message-ID: <20231220163538.1742834-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
References: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|MW4PR12MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b1b2440-76cc-49e0-087d-08dc0179e88b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YcHeyRIiTG0O6z8H+hmvSNB4ooAXD8et4qi+4OusM9/N1LmIlXgcMY/mxZK4zI/e0CbRdt8wRKzBRMfXniiePKOIFMshltG2SXQrs2ASwYWwixNnRYCJ1DYcFNO8ARF74iXdBqfr8qBz5p8mIJ9tjL9Cvm4jpDlpOqGbG7b0TWhFj1B7N7DVaM8EK2TU7kTu2O+MB8E5rKEq8RVBw9XxjBtHdo5fHUWXZBeDHBv6s0JMDrtIv3/1QpGtLNNHzu2trOICrIN6FqxBxIx4QX5LFSXrzcDSzBcY/V12KOuWE0EtC5XGArOSXCtbYgTdg6M4KCAtKYxFZLzq/WWUk/2ZEn+3jknJq39o133g4SLBjjoO/Q2KM8u7cx7/xp9jrbKg2MtK+nFmpBD4dBOEQsUkCVCcmDky/H0z7flCsrEuXfwyz4TpoIz28JOmSXZvtV6XmEb4sBxqHriDcYW5B+FNrYodwhn7nO5d8LMnu32LNqO0a19qYj5/U4oMpZ7lj0GgsscuudMP1a4k77pX/Gh1qEnVDxWVZ3cBOSYq+v2n1tw1ipTMoNiL/WaV2BHSgDtEYLp0tyOENIxNMD9D+E0alZrXoECN63IZJ70SOR2p42ZgPjc1u45vNX/cNBwui6jtV+0+Ozj0U/uou0Z9uve4mEbCuezYrxkjKIP6eXm2itaUpuRj+2jzL6ccPGUy8/E+yz1hvyr6TZNUtly5A6SZx8PO3iGIkHUca15fn4qW3jTHMRcWm8B+6OyVpTaf/aUkS1FG38B7wsIIdwPMHJe3nQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(82310400011)(451199024)(186009)(1800799012)(64100799003)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(336012)(1076003)(2616005)(16526019)(6666004)(426003)(26005)(83380400001)(82740400003)(81166007)(356005)(2906002)(36756003)(86362001)(478600001)(4326008)(41300700001)(8936002)(36860700001)(8676002)(5660300002)(47076005)(6916009)(54906003)(70586007)(316002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:37:08.3395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1b2440-76cc-49e0-087d-08dc0179e88b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6975
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 Sung joon Kim <sungjoon.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Race condition between notification of driver idle and the command being
processed. We could theoretically enter idle between the submission and
the wait for idle that occurs after.

[How]
Switch the notification to NO_WAIT to avoid the RPTR access.

Reviewed-by: Sung joon Kim <sungjoon.kim@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 7724dcadecba..dadeaa9c92dd 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1209,7 +1209,8 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 	}
 
 	/* NOTE: This does not use the "wake" interface since this is part of the wake path. */
-	dm_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+	/* We also do not perform a wait since DMCUB could enter idle after the notification. */
+	dm_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_NO_WAIT);
 }
 
 static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
-- 
2.42.0

