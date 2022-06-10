Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16793C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 17:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E92310E249;
	Fri, 10 Jun 2022 17:26:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 779AF10E249
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 17:26:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ls4G5QKs/FL/adP3Vk93/wo7uw43ZqDjPTbXLIoSEc2F8O1NQAt2swqJCqTv4TeZeN4ZNwiuY3rlyBq9K3zLVE3vJAQqFcjZXQf8taxSefUJSQlVZLSLSxVtJnUW0vzByZll2Vs8J3KS8OfujOScZSjn7Je+BT17JzGt8RSdITvxTh4KXSN6/unsK46qrw0PchvSmlcqcYAgwb6H5Iz/TDN52WeWAXR3zvCRneV3FIZdBKNtpE3a2Zf8REd4UTChkspjcU8gdtP4F2m9yaBz22rrAHy87WQLRzAIPO6NDvP8clrL6y5psg13IUMnG8yLzB33IozL59fe1SU+Jgz1Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8s0kwOugJHtREL1rt8QMi4JrjOKdKCraZmY9MilRpI=;
 b=f9Q/KfD8fEWRTVBwuF67dCEpedx6labnAisFBa+u1l6E885ZthcEwX8IaBXAkRc86GqjKj3mFNy4e3HHMCdwA0LucTV5kfkBrH9gIf89kOMVwnHjs+Rwwc0djgkIfRriKa7PaEhT1Z6Ccj2sSglAs6bi0FD18YF/DgLRE2rnk64I++4EVBZ1oKnGeXA1sNW7K7w9Skz3pr1C6hj8qpcDnApQoB/BgkTt854jp5/vMxHmullTwXehNKZikIwU5n55VGsvp9Baqxdqh0ur54wYo4MZEpXYcaWo23d/1mc5/R3CLW19GnubFHsrdn/kZ3f0c97Uc+6yG+noAg+x04xW8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8s0kwOugJHtREL1rt8QMi4JrjOKdKCraZmY9MilRpI=;
 b=b4FJ7EtHlJiXqmnigNRIhN+xilHYgU/Tb58utMQI8cHlrgsjT7N9axx9qCKxyJSvFixMW+06i0rEH6dlmdJDctRiLIWg7iiwKYux384dqzhqTBetd1CRsLhbuPgoeyV+6Wc5Sr3ISeHgp1jqzUUsx4Xy11RZSrM7wUUFCudNoVk=
Received: from MW4PR04CA0160.namprd04.prod.outlook.com (2603:10b6:303:85::15)
 by DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Fri, 10 Jun
 2022 17:26:12 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::5e) by MW4PR04CA0160.outlook.office365.com
 (2603:10b6:303:85::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Fri, 10 Jun 2022 17:26:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 17:26:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 12:26:09 -0500
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Fri, 10 Jun 2022 12:26:09 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: dml: move some variables to heap
Date: Fri, 10 Jun 2022 13:26:03 -0400
Message-ID: <20220610172603.529561-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c05b73f-93d0-4872-75ca-08da4b065069
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2602E9848178241F285462288BA69@DM6PR12MB2602.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GU3t7pa2JcgfmRa6fxqJwt06GJcGMbYfNjGkTEDQtqb0isk28JCGXyTuABEwl8A2NjkN4L6smH1VYmUCHcvter7C2RLOw/G2gZ4arzLgJ9WrFJ3QrKZxbGxmgOFGW+f08FVUMDUqFxnShbjKrWwV4W7tEKGGK3xYmM8tj70Vpf/kVv7oGZjETyBskw3+sZ6z9Fk6t5bcHXCEgJKtz90N+xCXqwvlP/2PD3zSip0JBMf3KDXcekvmSJBv51w2pqNXsMt4eHI5J+R57uF+qyDCjDeLK3KskGTeW6Nt6PMPEo+i6TbsajzWaVADFm+D/ZamTqjdN7FS9Ldo0xLj6AQ+h8stxjY7MW0MRo0Q3eBPzf+74IyvCX1cyAxSofEZTM+x5gvodrIV2PvU3/tt6M3J69ACsMjeTVAcX9Cmnjqs7PmvlMuBQq9z/EmGhHCDRgqSO93oAF7AqePmA26Yh6qVZW1z80WLf95A0vamwIWUul58G+x7dSMM4OAkoq3rqrmQalkQ7iur9hpbhbnkbxACcMbhu7/YysIfwSGbmeVir1xRtBdxhfF7V9JjCiBE0dddi0jtJull+CoFYC/J63zf17LQJXPhrb/MoS0lG9DepJfkWKiMeKbEI7w9X6k3KhlF6GARrEe/cxvgiN1+75MRHdfjQI1xwTdOEbFLCjDDemyKXoTZOc/Ik+CtCJiWGSIqKkHdujJcs3MhX3+njRziC/Cx1pQviYnS/EIdfs9Xs/o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8936002)(83380400001)(2906002)(19627235002)(44832011)(6636002)(54906003)(36860700001)(316002)(110136005)(8676002)(86362001)(5660300002)(356005)(36756003)(508600001)(4326008)(81166007)(186003)(2616005)(70586007)(1076003)(70206006)(82310400005)(7696005)(47076005)(426003)(26005)(40460700003)(6666004)(336012)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 17:26:11.5447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c05b73f-93d0-4872-75ca-08da4b065069
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2602
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
Cc: rodrigo.siqueira@amd.com, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
To reduce stack usage, move some variables into heap in the DML function
dml32_ModeSupportAndSystemConfigurationFull()

Fixes: d03037269bf2d ("drm/amd/display: DML changes for DCN32/321")
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../display/dc/dml/dcn32/display_mode_vba_32.c  | 17 +++++++----------
 .../drm/amd/display/dc/dml/display_mode_vba.h   |  3 +++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 5828e60f291d..b9f5bfa67791 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -1675,9 +1675,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	bool FullFrameMALLPStateMethod;
 	bool SubViewportMALLPStateMethod;
 	bool PhantomPipeMALLPStateMethod;
-	double MaxTotalVActiveRDBandwidth;
-	double DSTYAfterScaler[DC__NUM_DPP__MAX];
-	double DSTXAfterScaler[DC__NUM_DPP__MAX];
 	unsigned int MaximumMPCCombine;
 
 #ifdef __DML_VBA_DEBUG__
@@ -3095,10 +3092,10 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	}
 
 	//Vertical Active BW support check
-	MaxTotalVActiveRDBandwidth = 0;
+	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaxTotalVActiveRDBandwidth = 0;
 
 	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
-		MaxTotalVActiveRDBandwidth = MaxTotalVActiveRDBandwidth + mode_lib->vba.ReadBandwidthLuma[k]
+		v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaxTotalVActiveRDBandwidth += mode_lib->vba.ReadBandwidthLuma[k]
 				+ mode_lib->vba.ReadBandwidthChroma[k];
 	}
 
@@ -3115,7 +3112,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					* mode_lib->vba.DRAMChannelWidth
 					* (i < 2 ? mode_lib->vba.MaxAveragePercentOfIdealDRAMBWDisplayCanUseInNormalSystemOperationSTROBE : mode_lib->vba.MaxAveragePercentOfIdealDRAMBWDisplayCanUseInNormalSystemOperation) / 100);
 
-			if (MaxTotalVActiveRDBandwidth
+			if (v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaxTotalVActiveRDBandwidth
 					<= mode_lib->vba.MaxTotalVerticalActiveAvailableBandwidth[i][j]) {
 				mode_lib->vba.TotalVerticalActiveBandwidthSupport[i][j] = true;
 			} else {
@@ -3281,8 +3278,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							mode_lib->vba.SwathHeightCThisState[k], mode_lib->vba.TWait,
 
 							/* Output */
-							&DSTXAfterScaler[k],
-							&DSTYAfterScaler[k],
+							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.DSTXAfterScaler[k],
+							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.DSTYAfterScaler[k],
 							&mode_lib->vba.LineTimesForPrefetch[k],
 							&mode_lib->vba.PrefetchBW[k],
 							&mode_lib->vba.LinesForMetaPTE[k],
@@ -3579,8 +3576,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 						mode_lib->vba.NoOfDPPThisState,
 						mode_lib->vba.BytePerPixelInDETY,
 						mode_lib->vba.BytePerPixelInDETC,
-						DSTXAfterScaler,
-						DSTYAfterScaler,
+						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.DSTXAfterScaler,
+						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.DSTYAfterScaler,
 						mode_lib->vba.WritebackEnable,
 						mode_lib->vba.WritebackPixelFormat,
 						mode_lib->vba.WritebackDestinationWidth,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 43e327080552..9ad49ad38814 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -204,6 +204,9 @@ struct dml32_ModeSupportAndSystemConfigurationFull {
 	SOCParametersList mSOCParameters;
 	unsigned int MaximumSwathWidthSupportLuma;
 	unsigned int MaximumSwathWidthSupportChroma;
+	double DSTYAfterScaler[DC__NUM_DPP__MAX];
+	double DSTXAfterScaler[DC__NUM_DPP__MAX];
+	double MaxTotalVActiveRDBandwidth;
 };
 
 struct dummy_vars {
-- 
2.36.1

