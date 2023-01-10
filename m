Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81360C54EBE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 15:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E253A10E5F6;
	Tue, 10 Jan 2023 15:45:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CB0A10E5F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 15:45:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJWJuWIp1aGol2F5Z8vk0IJIMmI5tkcc/klYD6sz39a3gc5cARUFGvBgEVvWsEhBReka6lTbsZYm2yolgPrSNZzZ5rziuGs+rgsdqM+QGgRKtmG8wPFhndD7aiev9JuEWpAS/Oq1r/BQMJaqVAy7tyPl0sWlS+ezORNRq408XR1LfRe5hkvbEtrSEnhho518EHCE58tS9ItSuMLILMKvZRG4gJCukypCLauBZVHOPIkANKY4JzkxyihE9hUkJS5L7moU+twWWpCDMZjgr/LigPek90s9yQ9Kmw3B0P/ve385vhRFaZ428ILKhfSnBEzgUWFnOjMf8xKR1ZNbtYOD8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+xnGqDi7wSJAqdceH5rWilU2tJmVWNnTAC/bBQV7dU=;
 b=KDGfzrGsPU30PG0M1Kvo3FvD0hrWPGbaHkdKmOmUTxUDmj6X4+Uw29phInc9uyucT/JuLggI4YTZ7weRZxnYC6W0M7KwKCRNgRAhFAZ1VG7LtEK8guu7BCVaS4a7pFSHT2gowE6HdPldH9W+o4BsNmM1gaIg0K6zAhnvxVLGrd9IcTJVmxrfz12wg6qTIVt7e8h4XPBheUi2iZcXzye0ke3/6wkxdX1mB3SbrbspmA19GHFI4TX5tSgP8JWmRctdb2OXAtIPAcjHJBmES+Jgl4Row73enKYSYHPsF7PeOQSfBk1yL9bQvHL2UR5mf1691IT/YB+xxYZx5lNPsYB5IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+xnGqDi7wSJAqdceH5rWilU2tJmVWNnTAC/bBQV7dU=;
 b=QFb6YRdZda0mQNqVwiQ6QcF0QX8uUfBkZmyMYauMKNzrwCQwHMnpgYbAjcTa5IaOi27ztS2HrMgzKqhyQi+D7AItORAwnK0n2O+lwxFg5V/SHSgZne83jBU8gTPdOj6I8xuvB1sUNLO3lK9JvYPrwfdT6uF6hqaFMBcnZkki6fQ=
Received: from DM6PR07CA0047.namprd07.prod.outlook.com (2603:10b6:5:74::24) by
 PH7PR12MB7259.namprd12.prod.outlook.com (2603:10b6:510:207::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 15:45:25 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::c3) by DM6PR07CA0047.outlook.office365.com
 (2603:10b6:5:74::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 15:45:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 15:45:25 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 09:45:23 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH 8/9] drm/amd/display: Use
 DCFCLKRequiredForPeakBandwidthPerPlane from struct
Date: Tue, 10 Jan 2023 10:43:24 -0500
Message-ID: <20230110154325.3350916-9-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT056:EE_|PH7PR12MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 972b6bf8-19bd-4057-1be4-08daf321b112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: opG/nEMFFsgsEOn+iYWyj893x4Nyq849jUMVSxpjJDZ200DNfF+OkSsu9bNQISSw1HebaDqYAivJfoF1de5R71kcyPVh00BLLRpgV6xJ9/iKxXRY59LZCU6NwvprbZHTuMQ0dR3o+P/OfMw8tctayLjQ3jszOvzy/38zBHPCyJ51V7dQWj8Xp4DQBGt2BfvOiYp4ItnFilT1GLXJOJuSVFfhwW6VnTeOhOlPPFGmRTC5IhmF314c2jlOitoPpqv7Mrm4r4RS2eLp4mRRJvB7ROSTXgPzV+pA1q14zcupECrynb3G6OMNECaOVsMS8mFk++CF4GBTcWG0nrHQltjLhVIzEpZ7EDAZGawdERhrgzruO/mcvxIDCE8s4osOj3dmfWaLx6qzWOaw4LVWaGfaHz+J5aevXvP1oPKtPxYlpxIY+v6fDNNvFsuYEQOg7ruLe9PJCR8G5cBjp4Eyxwy8EB5oQ5oNQPebIq9+9UeLvDFg65jRdiFFCMR27iUm281SmhLgzZszBfOVpjG9iCnxYYKlIwSgBp3Sp6hkl0vuuagK5z85tyM+Yvg86uaxoXjqDwLbBxHDP31RJmAXclEtBPdtkC8n8Wef63j4p+5JaL1lqI/BvKMi4IsVP0LEPFt3/8V7/qX1EMwbwGD1fOR3kN2axk4K+oIUgY4wz7PWo7g51RWllKgJTZTcjZX4xzLA4odvt14pqKtPz78bc6wm2qVdcQwD4dh7IzmzwiYQHxjUw20sI8V+QeOwo3hG+FvgiVFfXTUqA54DgAQOpFsqFjbLRGOgwQcSk4Ient6i/fsHdwWYCzLLari9zeX+lSyB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(19627235002)(16526019)(1076003)(316002)(40480700001)(5660300002)(26005)(7696005)(186003)(478600001)(966005)(2616005)(47076005)(426003)(40460700003)(41300700001)(6636002)(54906003)(70586007)(4326008)(70206006)(110136005)(336012)(8676002)(82310400005)(8936002)(83380400001)(86362001)(36756003)(36860700001)(82740400003)(2906002)(356005)(66899015)(81166007)(213903007)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 15:45:25.5164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 972b6bf8-19bd-4057-1be4-08daf321b112
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7259
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

[...]/display/dc/dml/dcn314/display_mode_vba_314.c: In function
'UseMinimumDCFCLK':
[...]/display/dc/dml/dcn314/display_mode_vba_314.c:7127:1: error: the
frame size of 2208 bytes is larger than 2048 bytes
[-Werror=frame-larger-than=]

This commit replaces the local DCFCLKRequiredForPeakBandwidthPerPlane
from the same version in the UseMinimumDCFCLK_vars struct.

Cc: Alex Deucher <alexdeucher@gmail.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/all/20221227082932.798359-1-geert@linux-m68k.org/
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../display/dc/dml/dcn314/display_mode_vba_314.c  | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index f51885d3dd2d..0811b18c22c3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -6976,7 +6976,6 @@ static void UseMinimumDCFCLK(
 	NormalEfficiency = v->PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency / 100.0;
 	for (i = 0; i < v->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
-			double DCFCLKRequiredForPeakBandwidthPerPlane[DC__NUM_DPP__MAX];
 			double DynamicMetadataVMExtraLatency[DC__NUM_DPP__MAX];
 			double MinimumTWait;
 			double NonDPTEBandwidth;
@@ -7050,14 +7049,14 @@ static void UseMinimumDCFCLK(
 
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
@@ -7088,17 +7087,17 @@ static void UseMinimumDCFCLK(
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
 			for (k = 0; k <= v->NumberOfActivePlanes - 1; ++k)
-				DCFCLKRequiredForPeakBandwidth = DCFCLKRequiredForPeakBandwidth + DCFCLKRequiredForPeakBandwidthPerPlane[k];
+				DCFCLKRequiredForPeakBandwidth = DCFCLKRequiredForPeakBandwidth + v->UseMinimumDCFCLK_stack_reduction.DCFCLKRequiredForPeakBandwidthPerPlane[k];
 
 			MinimumTvmPlus2Tr0 = v->UrgLatency[i]
 					* (v->GPUVMEnable == true ?
-- 
2.39.0

