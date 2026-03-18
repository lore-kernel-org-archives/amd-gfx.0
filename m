Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E7BFED9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9B1010E657;
	Wed, 18 Mar 2026 01:02:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dg+LlTbC";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010043.outbound.protection.outlook.com [52.101.61.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58BCC10E65A
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:02:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f72eyr5HoSk/7XrlLtn2iaaxUNEnPO7L1c5V9pT+RrPDKiL3norji1sIkT67K5fh1dumdfqIrxAhRM9eF8QednOYn8gUY3EPLbklvR9km49KOTQTViD+HG72wLImZZCnbtaIu5jT7QT3rkTITRNOKRqDabRhnNlbJXCX/AKwvuc2LWvbLHN6C5C8gboxVm6VruZFKE5sMklydySvxCS4EgW1lqL/1ZxEDfSqkqlVIu0xQhYI4GV4NZE7+qpz1NK6qaSZBvVRRxpeR5BeyUjk4qSqGFtLTZ6+MMf038iB2CVlc6Wo8uGmFb5Y8/aZkbu+Uo2CC5ex1ICdtLMLQqQzDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FhIM+s1hk+52L+guj7Xvzvu5r7GCvL7+CIOwKUNTvw=;
 b=EChhkncfAM5vbQCEUjMQgkLTskCNg2pVbsyfhjEwhl7teX9VObD2LFArjA0xTlAut5d4kDJ94RUpXU32GLedlVSex4MR9mdpjP44b5w4oaW9tzlw/NGnPi+wKQX6mYbDMySHYfTVK/SuHMPupWfrr3SO7llomW3Pw+HWXeQ8OZqaFc7pwfipCWN09DaEhIxV7y9/1sY7TXtxLcswS1LIYgkYOXnpyoqfsibXMoeZw77EJMPWsurPJZvIK7vrPvu6gNyPeW1X2uxrKYc8IwRDmf/lxOuzqQDVNk7k0z6TM+uOPLGo/SGenp0nx2zSAHIUwyN1DuDeQk/7w5FGlk1zVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FhIM+s1hk+52L+guj7Xvzvu5r7GCvL7+CIOwKUNTvw=;
 b=Dg+LlTbCp+or2zHPCo5EK9L7weVq7O6kLqOQ3asXcaWu0DdjIgDZfyMvE81AOR9hg5mfLBKClcPzGSYRC0Q0NK4GMW2nON8DiAgQYHOald7F3oJHotckmgVJSkrKtuRvmx0nGL48TVSG0R6Gs24JbF0l7dj8Cv70vHaThfJRXSQ=
Received: from PH8P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::13)
 by BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 01:02:40 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:348:cafe::8e) by PH8P220CA0029.outlook.office365.com
 (2603:10b6:510:348::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 01:02:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:02:39 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:02:34 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, ChunTao Tso <chuntao.tso@amd.com>, Leon Huang
 <leon.huang1@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 26/31] drm/amd/display: Agument live + capture with CVT case.
Date: Wed, 18 Mar 2026 08:59:35 +0800
Message-ID: <20260318010224.513094-27-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: d14405e8-e33b-48d1-15fb-08de848a0d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: SJjaQMBN/hsOonDSBUJ1H6nUkQMOvobCebwraTzhDZJuPZWBzFNZH0xwV5XV76k79CXUgs2rkFX3D5C47bVYzjiT1DIQ6967Y6TsXgrbMzgvn0vxYGXcLAkAmq3rrtRODPtAq7Q59AhU87a4XSD1q8WI6NGlOPSuhTDWgkxPbCXJtTN/r2ILuTTpQkHB3M+Ty8aAMiPx4o20c5BWZYpHCKT0fwPr5YVApVPRasEFIoZf14Jr+zHAVh0nAeQYWc6yREhXOwmCVFmCj5Y177//XaZXefQq35P9RekWELXZhhojqji09P+QcBOIJCLSCiyObNgfC9+6PIX42lfVjQ4wq5rW8CMfxBm1R96rDobd26O59RxIWdypcjxCEY7M/vz01aV9QFzfHZ57XF5ukSxqhFpUzaqn9kXGm2z1fxhw+oAu9yAE4eeeVcbJy7ARSHgcBmTHkvRLsiyVDLLo4TBn/jL1ZSP+4xBduHOHeW4wlcQYVoPdgddRkRoDdiwJMoS3iqvQQAViXGnZZihsGowODj20DYDsH6Mwt1yMsHyGV/Y5h7/nq2rt5jANG920198fooaq2eKT9Tl+gZc8JEoStvQ/TyS/1wGQ0um2S1tKm/WmkH/YMbT1sfpjwjBRGBZCp71XCHvmlXvOOgDEdlPBswNf8BBp1J/1r0CPWXNxOSE2n1PhYG5IZGY0eTsNOHofE/eimFH1SYw9ullDjnE3AZ0iCEHN302GYncABp341iE0xWfXvQOtXDGAhtVwWp59PshXEy4wLRqPxGyoloKpJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4XSBv16WLR5AgipgK5Wz2+9fotwg9kbJMDZvUPa1zDTP07Im4z75I0KFw3wTdnHLyw0zJ3UDfPuNvn7VaoAAU/epwObNeC9UoIosD2OD8yzmgcViuNZ4tKfDLIc+vtOhyd0mhepgGNubLG9pT2NFpb4QaGl0RIgM/CmSEur1JEJtV4+M6s1eUSerqV/gTbhS898T+9r8ypVXbNE+0Vjhrz+AlK4h4o+3g8tIY3RtJKx/B7dlryJzF6vbIiKjmjAHpxs09RfltOulpR7xYuXHT7afELw+YJK2RWdTM7ZIK20Q1mnqMFP+0HxXNIKA1S2WX25hrO5eXVP+xwsZyryhvDMgmr+hzm9ewwu49sR0ylJl1Ybnd/v1ECbR/n6np1XewU814fl0bVgO2vS0JTvDgh7ptGPhiT7wQUlZmOmskmG9zeR3RTCWigCcA2J2AwOB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:02:39.7996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d14405e8-e33b-48d1-15fb-08de848a0d67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132
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

From: ChunTao Tso <chuntao.tso@amd.com>

1. Add LIVE_CAPTURE_WITH_CVT bit (bit[2]) in union replay_optimization
   to control this feature via DalRegKey_ReplayOptimization.
2. Check the bit in mod_power_set_live_capture_with_cvt_activate function
   before enabling live capture with CVT.
3. Use LIVE_CAPTURE_WITH_CVT to control if Replay want to send CVT in
   live + capture or not.

Reviewed-by: Leon Huang <leon.huang1@amd.com>
Signed-off-by: ChunTao Tso <chuntao.tso@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h       | 8 ++++++--
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index e224077c8902..fd8ec1660312 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1144,10 +1144,12 @@ union replay_low_refresh_rate_enable_options {
 
 union replay_optimization {
 	struct {
-		//BIT[0-3]: Replay Teams Optimization
+		//BIT[0-1]: Replay Teams Optimization
 		unsigned int TEAMS_OPTIMIZATION_VER_1           :1;
 		unsigned int TEAMS_OPTIMIZATION_VER_2           :1;
-		unsigned int RESERVED_2_3                       :2;
+		//BIT[2]: Replay Live Capture with CVT
+		unsigned int LIVE_CAPTURE_WITH_CVT              :1;
+		unsigned int RESERVED_3                         :1;
 	} bits;
 
 	unsigned int raw;
@@ -1196,6 +1198,8 @@ struct replay_config {
 	bool frame_skip_supported;
 	/* Replay Received Frame Skipping Error HPD. */
 	bool received_frame_skipping_error_hpd;
+	/* Live capture with CVT is activated */
+	bool live_capture_with_cvt_activated;
 };
 
 /* Replay feature flags*/
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index e11e32afac6b..8fbd179a4c87 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -4437,6 +4437,7 @@ enum dmub_cmd_replay_general_subtype {
 	REPLAY_GENERAL_CMD_VIDEO_CONFERENCING,
 	REPLAY_GENERAL_CMD_SET_CONTINUOUSLY_RESYNC,
 	REPLAY_GENERAL_CMD_SET_COASTING_VTOTAL_WITHOUT_FRAME_UPDATE,
+	REPLAY_GENERAL_CMD_LIVE_CAPTURE_WITH_CVT,
 };
 
 struct dmub_alpm_auxless_data {
-- 
2.43.0

