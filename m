Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00F9C46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 15:45:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78DEE10E5F5;
	Tue, 10 Jan 2023 15:45:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A9ED10E5F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 15:45:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIDeoChf06QAGxnFKqqsQvJTYNTqrCiHGhXRvX9fv9hmnNugCdreXY5+sJ1285qWWiELosnWdfInoXiaPweU/Q+cVF4eHIeYdplwFpV4kJ8Yw8CvleyI17MAYd5UNZEorVd5on36pU8Mmqg0LOo/Vs6B8qwn1kovJd4jZIPmpWYEsiAj0bl65OoE3lDvAeZ4Bo4Odd5OPJQkbLqpH3a4Nll3Ryhmd+kp/oeJKh1sfNtxZU2UkyYA6hf48zaSJ2HbvjnZsiVNYWNxYJJK3WMxvXz5X1TKROnfaEpElkLjK47gdmafb7QPcNwfUw7vAYD/H7F+JXGS4uRxFBuA5v0Ncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlf/Y5zTl19ro51ZsN5mGw8Ceo4ELkdrNQurpluCD6g=;
 b=I66iuRQgHmo1GsIitfbn8mByEac9qz4D40Ap7TQcxLa7Zk6LT5Rpp7WcUD+21X5YVWmAAD0uEj7s47CE5c8vQTX//zTNoo5nNwc6m2FbfgSXoTIPcO7Kgt08vGm8iPTPIAQST1KHrtQKKA/vXiHCrEedg7vnqnkk1n3hBh2VL5jN7VJpVcIHO4fgPEmDXCC7zjSlNeHKdYLIepik4sF33jqpQ90gcSot3Ll0+WswjiaECpb1syWOsShQV7CGzsXzjedMc7XZtJLE9F5ZafERByzzIRDSxRyDHJUW5QRfIYZNY4iK+tTqMOL7Hyk1Sp33xGr/RMPfH6IzTJfAN6cB+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlf/Y5zTl19ro51ZsN5mGw8Ceo4ELkdrNQurpluCD6g=;
 b=kP8mMTp9rc5p/QL2lUlMtAMLnol0in5EbmeD5Wagxa3O9NLmx7Ql2h464PO0DKpxhz4hnRtjm7Aq/kBeRhB+j0ilBGt5+pIWHuXGbnJMTdSAHRUVWVz4Y2ZvaAWMeXTz+ZdytJsDGzriRMGauHHb/teDqFxDCpDVmphFcub7EZs=
Received: from DM6PR13CA0052.namprd13.prod.outlook.com (2603:10b6:5:134::29)
 by MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 15:45:23 +0000
Received: from DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::4a) by DM6PR13CA0052.outlook.office365.com
 (2603:10b6:5:134::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12 via Frontend
 Transport; Tue, 10 Jan 2023 15:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT094.mail.protection.outlook.com (10.13.172.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.17 via Frontend Transport; Tue, 10 Jan 2023 15:45:23 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 09:44:51 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH 6/9] drm/amd/display: Use PixelDCFCLKCyclesRequiredInPrefetch
 from struct
Date: Tue, 10 Jan 2023 10:43:22 -0500
Message-ID: <20230110154325.3350916-7-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT094:EE_|MN0PR12MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: 51839661-8b91-4a6c-5c6a-08daf321affd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMMwvGnrY1TvnxGy5UhM8Tt/Za6ojuFbWpMX1Ag2UpN29VILQk6uFVfzcdvz0GfXQE53jShTAAVD5x9HXeJO/0CrIHNmgk57VEG9/ts8+88oAym4Taj9iYBShGO1hDV+K0ajo50Sd32AtaNv/zBvXOqYE/RXisJWw7WHuQbsfzbPd6DjCWG+KZG4nRr47uta7+Jvty/r6IVudPniYOVOLteYtr27G68lR+vd/1s080Fmjv2G7rvxyyXzSvh5bfmqcPRHQvWUhzBJOVD81JihqaINcCbVRonsoEDEaBB9yCTgntTepgtSHqwJQpUehN9gUYjSoQJqTp4DkrLg6VjKmjGL8J3cP/CWf++f3A0mRXaEzouWN+R2ZiCiSDOWUQ39CA3nrYWFskgUv9QvHsbS1rIiJL9x0yTAmvmYcFmblXI6G7H+8KhL24acPbqeW6diHDafrjRaTant2gbpyB1omPISTnJ5/B9EAhIKfMUnuu1ePH7PgkXDWxCCWIeSjTprjNwOTh4Ez7ZA1HCJvJKHM1oLGL5gzZTKbGk/eQVA0UB7xkGB/1HNAXFqJVErKk2dLAcf7nJP7jlRY6jgpAroDZQu/TwsfSbrs/MezILKl4nXMKDyXnDj6TYt0ZskieTUIulM20fKlljyiMUzSpP3S18iCh5wCKIO6/li+8AT+ZCDNjifgtblhuCJ24/l8NHE5LiM9m86qP/7XLJM/S6qGTqIGYyEYh0V0LIzUisBZM3wdnPqfsrbCT7NvB/HAW4921lQwLrd1iHs578gODgGjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(6029001)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(82740400003)(6666004)(81166007)(2906002)(356005)(66899015)(478600001)(966005)(2616005)(1076003)(19627235002)(16526019)(26005)(7696005)(186003)(5660300002)(316002)(40480700001)(83380400001)(8936002)(82310400005)(36756003)(86362001)(40460700003)(47076005)(426003)(41300700001)(8676002)(336012)(110136005)(54906003)(70586007)(4326008)(6636002)(70206006)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 15:45:23.7652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51839661-8b91-4a6c-5c6a-08daf321affd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6101
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

This commit replaces the local PixelDCFCLKCyclesRequiredInPrefetch from
the same version in the UseMinimumDCFCLK_vars struct.

Cc: Alex Deucher <alexdeucher@gmail.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/all/20221227082932.798359-1-geert@linux-m68k.org/
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/dml/dcn314/display_mode_vba_314.c  | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 2ea89a26c6e8..8de1f7840b5a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -6976,7 +6976,6 @@ static void UseMinimumDCFCLK(
 	NormalEfficiency = v->PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency / 100.0;
 	for (i = 0; i < v->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
-			double PixelDCFCLKCyclesRequiredInPrefetch[DC__NUM_DPP__MAX];
 			double PrefetchPixelLinesTime[DC__NUM_DPP__MAX];
 			double DCFCLKRequiredForPeakBandwidthPerPlane[DC__NUM_DPP__MAX];
 			double DynamicMetadataVMExtraLatency[DC__NUM_DPP__MAX];
@@ -7029,12 +7028,12 @@ static void UseMinimumDCFCLK(
 				double ExpectedPrefetchBWAcceleration;
 				double PrefetchTime;
 
-				PixelDCFCLKCyclesRequiredInPrefetch[k] = (v->PrefetchLinesY[i][j][k] * v->swath_width_luma_ub_all_states[i][j][k] * v->BytePerPixelY[k]
+				v->UseMinimumDCFCLK_stack_reduction.PixelDCFCLKCyclesRequiredInPrefetch[k] = (v->PrefetchLinesY[i][j][k] * v->swath_width_luma_ub_all_states[i][j][k] * v->BytePerPixelY[k]
 						+ v->PrefetchLinesC[i][j][k] * v->swath_width_chroma_ub_all_states[i][j][k] * v->BytePerPixelC[k]) / NormalEfficiency / v->ReturnBusWidth;
 				DCFCLKCyclesRequiredInPrefetch = 2 * ExtraLatencyCycles / NoOfDPPState[k]
 						+ v->PDEAndMetaPTEBytesPerFrame[i][j][k] / NormalEfficiency / NormalEfficiency / v->ReturnBusWidth * (v->GPUVMMaxPageTableLevels > 2 ? 1 : 0)
 						+ 2 * v->DPTEBytesPerRow[i][j][k] / NormalEfficiency / NormalEfficiency / v->ReturnBusWidth
-						+ 2 * v->MetaRowBytes[i][j][k] / NormalEfficiency / v->ReturnBusWidth + PixelDCFCLKCyclesRequiredInPrefetch[k];
+						+ 2 * v->MetaRowBytes[i][j][k] / NormalEfficiency / v->ReturnBusWidth + v->UseMinimumDCFCLK_stack_reduction.PixelDCFCLKCyclesRequiredInPrefetch[k];
 				PrefetchPixelLinesTime[k] = dml_max(v->PrefetchLinesY[i][j][k], v->PrefetchLinesC[i][j][k]) * v->HTotal[k] / v->PixelClock[k];
 				ExpectedPrefetchBWAcceleration = (v->VActivePixelBandwidth[i][j][k] + v->VActiveCursorBandwidth[i][j][k])
 						/ (v->ReadBandwidthLuma[k] + v->ReadBandwidthChroma[k]);
@@ -7051,8 +7050,8 @@ static void UseMinimumDCFCLK(
 					double ExpectedVRatioPrefetch;
 
 					ExpectedVRatioPrefetch = PrefetchPixelLinesTime[k]
-							/ (PrefetchTime * PixelDCFCLKCyclesRequiredInPrefetch[k] / DCFCLKCyclesRequiredInPrefetch);
-					DCFCLKRequiredForPeakBandwidthPerPlane[k] = NoOfDPPState[k] * PixelDCFCLKCyclesRequiredInPrefetch[k] / PrefetchPixelLinesTime[k]
+							/ (PrefetchTime * v->UseMinimumDCFCLK_stack_reduction.PixelDCFCLKCyclesRequiredInPrefetch[k] / DCFCLKCyclesRequiredInPrefetch);
+					DCFCLKRequiredForPeakBandwidthPerPlane[k] = NoOfDPPState[k] * v->UseMinimumDCFCLK_stack_reduction.PixelDCFCLKCyclesRequiredInPrefetch[k] / PrefetchPixelLinesTime[k]
 							* dml_max(1.0, ExpectedVRatioPrefetch) * dml_max(1.0, ExpectedVRatioPrefetch / 4) * ExpectedPrefetchBWAcceleration;
 					if (v->HostVMEnable == true || v->ImmediateFlipRequirement[0] == dm_immediate_flip_required) {
 						DCFCLKRequiredForPeakBandwidthPerPlane[k] = DCFCLKRequiredForPeakBandwidthPerPlane[k]
@@ -7117,7 +7116,7 @@ static void UseMinimumDCFCLK(
 					DCFCLKRequiredForPeakBandwidth = dml_max3(
 							DCFCLKRequiredForPeakBandwidth,
 							2 * ExtraLatencyCycles / (MaximumTvmPlus2Tr0PlusTsw - MinimumTvmPlus2Tr0 - PrefetchPixelLinesTime[k] / 4),
-							(2 * ExtraLatencyCycles + PixelDCFCLKCyclesRequiredInPrefetch[k]) / (MaximumTvmPlus2Tr0PlusTsw - MinimumTvmPlus2Tr0));
+							(2 * ExtraLatencyCycles + v->UseMinimumDCFCLK_stack_reduction.PixelDCFCLKCyclesRequiredInPrefetch[k]) / (MaximumTvmPlus2Tr0PlusTsw - MinimumTvmPlus2Tr0));
 				}
 			}
 			v->DCFCLKState[i][j] = dml_min(v->DCFCLKPerState[i], 1.05 * dml_max(DCFCLKRequiredForAverageBandwidth, DCFCLKRequiredForPeakBandwidth));
-- 
2.39.0

