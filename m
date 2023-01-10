Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28D5C54EBE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 15:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A6D210E5F1;
	Tue, 10 Jan 2023 15:45:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5287210E5F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 15:44:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFKB0Z0T7UoWlrhF2sfmKwk43bQA2UvYRBbI5wiTY3etQtf7q2HK0ODrSViEzsL2LGdIdAk3KesfAEY4JB6PRbGk40vzoRUu91ONRdTi662OIzgplTEGjjWGbCNLphbXFm0U4c4IesTHF9b0wLdN1kqsEgzKQxwJqWpD7FpUzYbA+pmhANIZU3pvUNAH/rasCmorR6bNp25ngtPvmnub7PSTjn8AP6Hsrt3LPXmaqNqHJEyyFPzNmgwsNPdd4fMhEd6RB9Uub+o3BCK8LzPPPQIlEAnbcU+B2+BFQzhyW/Ugp00mYVGWIfb1prR27kUGCj9kwYPVoi4gyqrt5pxgbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmdcianvROE3m/EvJsih6U+18PJtwioECeuBsCGhx8w=;
 b=dg4egL/2/hoqIs3osFnB9P2rTZ+daVAYZKafEVXCgLVdG2XerHYOBcoaeZP0ypdxI85hOgkPubWYV9CrUX6kh/wgEllnz/BIFPAG/nNopGExQQ/PZ9Nsot4k+b+Db+SzcSiD8/jetJjEFGflTZiOUXuKKTWc//NeISuRVPRbIJuvTAInynHmkM98FhgrC9wXJooz7YO+enXD+dsx1BcXficgcn7FP/hZ6+wVgFMweIx8b82Uod9BznHbum3dWk+WAFJUo+fVsEiKeZTXcYarQWr5fSj00lSEL25AO3xArD0Sec5nJGFeemhnPQkOjJJWoePqwkRN9Y0svUD9Q4rQEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmdcianvROE3m/EvJsih6U+18PJtwioECeuBsCGhx8w=;
 b=Jm+EI+amQ3w5bPMQ7hfRdEELJmipaEE/BUcIGhMH2Bti7i9LxFn4k4hNPcUjcUgZWiDtTdoWnh32eh0B1LBHCcQCvhKbrF6XUkW99lMBN0UEdl2iY7LJ+qg516R8i8ZlDS41BsE5WbVltXMcZDQNA7e6QlM7ZF5w6mRcvT9WRYI=
Received: from DM6PR13CA0056.namprd13.prod.outlook.com (2603:10b6:5:134::33)
 by BL1PR12MB5031.namprd12.prod.outlook.com (2603:10b6:208:31a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 15:44:53 +0000
Received: from DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::84) by DM6PR13CA0056.outlook.office365.com
 (2603:10b6:5:134::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12 via Frontend
 Transport; Tue, 10 Jan 2023 15:44:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT094.mail.protection.outlook.com (10.13.172.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.17 via Frontend Transport; Tue, 10 Jan 2023 15:44:53 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 09:44:48 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH 3/9] drm/amd/display: Move
 DCFCLKRequiredForPeakBandwidthPerPlane to UseMinimumDCFCLK_vars
Date: Tue, 10 Jan 2023 10:43:19 -0500
Message-ID: <20230110154325.3350916-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110154325.3350916-1-Rodrigo.Siqueira@amd.com>
References: <20230110154325.3350916-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT094:EE_|BL1PR12MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: 67705d19-3c12-460e-4260-08daf3219dd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbehJuDKhhCPDvLL8Tl5gnYP2MhNzoifF1yiIj1QArTsx4P89combpjkWjqjlFSTxRr/EKWq2OSvmShJLDsLe00pNrLOa6N350qB2vB8YmHf8Ub53OhCHWDTJOk1JyetOWiiqf2POCiQVZ+3CgXhOYtslhdI2tYnaeyUr6YHWs+mTVcVXIFdOy+oFRP0onglo6S45yXG4IXuIHkyzNPzRRulZjwNvSmX7FdAwcuYdGDY0ipLu2gsdXXwMlOqxp1oSAUIleDA6bGzdmX8g+uKtYQmFm1WXHWaRASscAyfNTh3hgfyntVg2EO8ab8z63TsYiLdJ8ra1V6WpzAjHYmdbuqxxUFtbHK5MKwQJq8yEg41lZtsxFFTJvI3ujtB8HBXqw8keRSJE5rmfYEFJWAioxFXK5RSKsxmtMh2xm2eFUsPK38MN7gWjXWwhxlSHrIleD0T8jG4kNrxFjyLQIwBFBaotgIWWlRPMWiSVsmc8juHVZxup1AtoDt5yW6YmyE+08KGDwARaKKlIhH9g7uX7dFXYDxzamMxgpb0gUnFTb5aqF0MbPe/lWIZVO0iI8Vc5+mYehhRQpssUiKBLmGQEJDmSzTk1lyOfMafc7erRKn+JEqvs0gjvTjIFA5XTPhQSSffA/OSEX3539k+JO2+v6MUJkC9ALJLcfnW0Mb367RbmcjNndstpUhqJB5ipKRtbnTUcuw4DKP/zGwctAPA9RHhEZSDh7op/IAzWRrcv13xmI4211I0WBMWFsR/8J/3tqDcrVMEghx2tAKgvpQBdomNqJ8BfmOT+AuC5IFZO4s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(2906002)(82310400005)(47076005)(66899015)(83380400001)(336012)(36860700001)(426003)(81166007)(16526019)(7696005)(2616005)(1076003)(5660300002)(40480700001)(6666004)(8936002)(26005)(186003)(36756003)(6636002)(478600001)(70586007)(110136005)(70206006)(54906003)(8676002)(41300700001)(356005)(19627235002)(86362001)(966005)(316002)(40460700003)(4326008)(82740400003)(213903007)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 15:44:53.3296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67705d19-3c12-460e-4260-08daf3219dd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5031
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
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <roman.li@amd.com>,
 amd-gfx@lists.freedesktop.org, Aurabindo
 Pillai <aurabindo.pillai@amd.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It was reported that on kernel v6.2-rc1, we have the following stack
size issue:

make[3]: *** [/kisskb/src/scripts/Makefile.build:504: drivers/media]
Error 2
[...]/display/dc/dml/dcn31/display_mode_vba_31.c: In function
'UseMinimumDCFCLK':
[...]/display/dc/dml/dcn31/display_mode_vba_31.c:7082:1: error: the
frame size of 2224 bytes is larger than 2048 bytes
[-Werror=frame-larger-than=]

This commit move DCFCLKRequiredForPeakBandwidthPerPlane from
UseMinimumDCFCLK to reduce the stack size.

Cc: Alex Deucher <alexdeucher@gmail.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/all/20221227082932.798359-1-geert@linux-m68k.org/
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../display/dc/dml/dcn31/display_mode_vba_31.c    | 15 +++++++--------
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.h |  1 +
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 28dcd46a28c0..8175f3603f00 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -6932,7 +6932,6 @@ static void UseMinimumDCFCLK(
 	NormalEfficiency = v->PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency / 100.0;
 	for (i = 0; i < v->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
-			double DCFCLKRequiredForPeakBandwidthPerPlane[DC__NUM_DPP__MAX];
 			double DynamicMetadataVMExtraLatency[DC__NUM_DPP__MAX];
 			double MinimumTWait;
 			double NonDPTEBandwidth;
@@ -7006,14 +7005,14 @@ static void UseMinimumDCFCLK(
 					double ExpectedVRatioPrefetch;
 					ExpectedVRatioPrefetch = v->UseMinimumDCFCLK_stack_reduction.PrefetchPixelLinesTime[k]
 							/ (PrefetchTime * v->UseMinimumDCFCLK_stack_reduction.PixelDCFCLKCyclesRequiredInPrefetch[k] / DCFCLKCyclesRequiredInPrefetch);
-					DCFCLKRequiredForPeakBandwidthPerPlane[k] = NoOfDPPState[k] * v->UseMinimumDCFCLK_stack_reduction.PixelDCFCLKCyclesRequiredInPrefetch[k] / v->UseMinimumDCFCLK_stack_reduction.PrefetchPixelLinesTime[k]
+					v->UseMinimumDCFCLK_stack_reduction.DCFCLKRequiredForPeakBandwidthPerPlane[k] = NoOfDPPState[k] * v->UseMinimumDCFCLK_stack_reduction.PixelDCFCLKCyclesRequiredInPrefetch[k] / v->UseMinimumDCFCLK_stack_reduction.PrefetchPixelLinesTime[k]
 							* dml_max(1.0, ExpectedVRatioPrefetch) * dml_max(1.0, ExpectedVRatioPrefetch / 4) * ExpectedPrefetchBWAcceleration;
 					if (v->HostVMEnable == true || v->ImmediateFlipRequirement[0] == dm_immediate_flip_required) {
-						DCFCLKRequiredForPeakBandwidthPerPlane[k] = DCFCLKRequiredForPeakBandwidthPerPlane[k]
+						v->UseMinimumDCFCLK_stack_reduction.DCFCLKRequiredForPeakBandwidthPerPlane[k] = v->UseMinimumDCFCLK_stack_reduction.DCFCLKRequiredForPeakBandwidthPerPlane[k]
 								+ NoOfDPPState[k] * DPTEBandwidth / NormalEfficiency / NormalEfficiency / v->ReturnBusWidth;
 					}
 				} else {
-					DCFCLKRequiredForPeakBandwidthPerPlane[k] = v->DCFCLKPerState[i];
+					v->UseMinimumDCFCLK_stack_reduction.DCFCLKRequiredForPeakBandwidthPerPlane[k] = v->DCFCLKPerState[i];
 				}
 				if (v->DynamicMetadataEnable[k] == true) {
 					double TSetupPipe;
@@ -7044,17 +7043,17 @@ static void UseMinimumDCFCLK(
 					AllowedTimeForUrgentExtraLatency = v->MaximumVStartup[i][j][k] * v->HTotal[k] / v->PixelClock[k] - MinimumTWait - TSetupPipe - TdmbfPipe - TdmecPipe
 							- TdmsksPipe - DynamicMetadataVMExtraLatency[k];
 					if (AllowedTimeForUrgentExtraLatency > 0) {
-						DCFCLKRequiredForPeakBandwidthPerPlane[k] = dml_max(
-								DCFCLKRequiredForPeakBandwidthPerPlane[k],
+						v->UseMinimumDCFCLK_stack_reduction.DCFCLKRequiredForPeakBandwidthPerPlane[k] = dml_max(
+								v->UseMinimumDCFCLK_stack_reduction.DCFCLKRequiredForPeakBandwidthPerPlane[k],
 								ExtraLatencyCycles / AllowedTimeForUrgentExtraLatency);
 					} else {
-						DCFCLKRequiredForPeakBandwidthPerPlane[k] = v->DCFCLKPerState[i];
+						v->UseMinimumDCFCLK_stack_reduction.DCFCLKRequiredForPeakBandwidthPerPlane[k] = v->DCFCLKPerState[i];
 					}
 				}
 			}
 			DCFCLKRequiredForPeakBandwidth = 0;
 			for (k = 0; k <= v->NumberOfActivePlanes - 1; ++k) {
-				DCFCLKRequiredForPeakBandwidth = DCFCLKRequiredForPeakBandwidth + DCFCLKRequiredForPeakBandwidthPerPlane[k];
+				DCFCLKRequiredForPeakBandwidth = DCFCLKRequiredForPeakBandwidth + v->UseMinimumDCFCLK_stack_reduction.DCFCLKRequiredForPeakBandwidthPerPlane[k];
 			}
 			MinimumTvmPlus2Tr0 = v->UrgLatency[i]
 					* (v->GPUVMEnable == true ?
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 733947be3737..4c5206bfad38 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -253,6 +253,7 @@ struct UseMinimumDCFCLK_vars {
 	double TotalMaxPrefetchFlipDPTERowBandwidth[DC__VOLTAGE_STATES][2];
 	double PixelDCFCLKCyclesRequiredInPrefetch[DC__NUM_DPP__MAX];
 	double PrefetchPixelLinesTime[DC__NUM_DPP__MAX];
+	double DCFCLKRequiredForPeakBandwidthPerPlane[DC__NUM_DPP__MAX];
 };
 
 struct dummy_vars {
-- 
2.39.0

