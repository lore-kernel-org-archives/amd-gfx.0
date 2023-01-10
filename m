Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9E2C54EBE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 15:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7511710E5F9;
	Tue, 10 Jan 2023 15:45:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D50C10E5F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 15:45:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdTJjSCWwJNqy6dBWxZZf9EsdKo/tuqEqpfPoVuii1tdqJ4QCg752sEtSsdnOZKApExa3LkMROdUzFutX0B0vM6lBfZK5CjhRrS8bjd8NJmmmjBiz7UbEwElIeJJCCWl14/dosWLKdPxXPotj9BeuE8nt5G6XaVXyYO7s46h4suMU1IQT/L5oWaReFEzAP+xaJgaJJyiUeGYeMc6ZBiS9kGP70PmVsmYd7NIw4b4p0OcUhN1LnA7JXuyd/TZ8YuFkRbwScZRmveR4FzdN/DbLZmuAYv0zjF2LnnYQDHrIiEonPJkTi16+1NKBLjFB97QjphnOmFKqBgnsHXireatYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sB9/oHeCdB4Q3xwKyLbqPQjiDA9ge6U4C0/kciV7B2I=;
 b=i/Rpy5WtKO+QimmDtPVC1yFAYAlVB5uVi0mUyVEaE6l+miBOR7KCy2yFFUS49/V2jQjc43U67QbeMsramzUzr/yxda8EqPcFwub+uF6KqOkUwPP7okQLniHDhEaujAEhaeNuG5VkkU4WSOSQmYfNKzAlscJIrpvyfUfWbvLv9U8FsuFlQfBfba8FirfI5DTiBAnVmRwJe1IFKrsII3TgXWb5PF1t7xvCWJdJFNxRK21lXQI5/6OgCuqU9+Iyztm5JsYzkt/JFPKEKyqGID1JbhLKcvTcXmysfM/1ZxRDHpfjv+Pvq+rW+gTzRdgGxYt0gqJtbUUOv/GaLgoYgkCAnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sB9/oHeCdB4Q3xwKyLbqPQjiDA9ge6U4C0/kciV7B2I=;
 b=dY2lLWesHAzNUb2HGEfrMffsoyckOLM3aadqZnYH3O8aY3S5/s1OUPDYO9fgX4pEnCGhzWBg8O74MOpZhE1mLupNnOtZVJZZHT+aw45WNz0dpqAUgAZtYinPdEBM3/NP/I9dMp1zLsd8wZcPX2kqKegkIGib+gKilSgiO5kFmyc=
Received: from DM6PR13CA0070.namprd13.prod.outlook.com (2603:10b6:5:134::47)
 by MW4PR12MB6804.namprd12.prod.outlook.com (2603:10b6:303:20d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 15:45:26 +0000
Received: from DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::9) by DM6PR13CA0070.outlook.office365.com
 (2603:10b6:5:134::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12 via Frontend
 Transport; Tue, 10 Jan 2023 15:45:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT094.mail.protection.outlook.com (10.13.172.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.17 via Frontend Transport; Tue, 10 Jan 2023 15:45:25 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 09:45:24 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH 9/9] drm/amd/display: Use DynamicMetadataVMExtraLatency from
 struct
Date: Tue, 10 Jan 2023 10:43:25 -0500
Message-ID: <20230110154325.3350916-10-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT094:EE_|MW4PR12MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: a825973f-d448-401e-83ee-08daf321b12e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Df6aBJoMkjhRN55oSLMCdmpIFMx4EKdKKKFK/qdf3x+/bH7Ihp3Q46+szFJlqH95u9jNPJIMSq/6Py0jZtJSqON0a4PBoaV6Y9UPzXCfdINZikU1auRX6U87bqRwy0uDlzPZJKIIBxBsxCKzZCpX1R59KOcAa1QmsKV3t4mZMGKIVd5MNiMYRrGJUJxOSPhN1vyk7V6eD0FQ3uFvD0LeA8Y4+nqWGZYgyeyrmHkbcyyvGFnY8q96oTL2qfvznbaJEPQoI+esKfGckUUuTp/3mYr5XLLtPvLoBBApEE4kXr0L0CFfxAACCB/N9u/5uQTUonHu4ghZLsZYVyRal21ph8iTz5uHC3BmVKw9NUtmHfs2saCWnc6LgajREw2ZBCrkW0/5Dnkv8eNXGsk7rYfMcQnIVpZjbpN3X3XtkYaMMbZ7VJBN0c90QO5oNbCs11Ey1WRJo/KUXyUY78QjAMXZKMk31M94yXi+UlGUcob+Cb+14I9kvMPAck6aSYvjuvBWxCFaBqeY/WjW9N5y7sTNIV+URmg+aEYsBLKO2/53DrYOZ3jAcQ40FYyx2LawuXII9OCb72j7qUIJ7KZF5TPcJkHzqhVI4vnQrvpx/dGOOGZxvK8YfLmwVUU+BhB3x2iw+ynzlJ3dhZVPP/IMLT/oGhttpArSTI/doozxd85HwnSTTRrHgbycFSVJ8P8RfDw3KiF+wUQ9P2dspSSDQvssqIFGZsQXvEjwgXs1LO8T/2LsSj9fNPRch43b+fHBbzw6ICs6aGx+KVhNJWBlsO0antj6EwdmK1P9c7t3WOms3tI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(19627235002)(8676002)(186003)(1076003)(316002)(5660300002)(40480700001)(26005)(7696005)(966005)(478600001)(2616005)(16526019)(47076005)(426003)(41300700001)(40460700003)(70586007)(336012)(110136005)(54906003)(4326008)(6636002)(70206006)(8936002)(83380400001)(36756003)(82310400005)(86362001)(36860700001)(82740400003)(66899015)(356005)(2906002)(81166007)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 15:45:25.7495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a825973f-d448-401e-83ee-08daf321b12e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6804
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

This commit replaces the local DynamicMetadataVMExtraLatency the same
version in the UseMinimumDCFCLK_vars struct.

Cc: Alex Deucher <alexdeucher@gmail.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/all/20221227082932.798359-1-geert@linux-m68k.org/
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 0811b18c22c3..b5519e9d1a1e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -6976,7 +6976,6 @@ static void UseMinimumDCFCLK(
 	NormalEfficiency = v->PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency / 100.0;
 	for (i = 0; i < v->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
-			double DynamicMetadataVMExtraLatency[DC__NUM_DPP__MAX];
 			double MinimumTWait;
 			double NonDPTEBandwidth;
 			double DPTEBandwidth;
@@ -7035,14 +7034,14 @@ static void UseMinimumDCFCLK(
 				v->UseMinimumDCFCLK_stack_reduction.PrefetchPixelLinesTime[k] = dml_max(v->PrefetchLinesY[i][j][k], v->PrefetchLinesC[i][j][k]) * v->HTotal[k] / v->PixelClock[k];
 				ExpectedPrefetchBWAcceleration = (v->VActivePixelBandwidth[i][j][k] + v->VActiveCursorBandwidth[i][j][k])
 						/ (v->ReadBandwidthLuma[k] + v->ReadBandwidthChroma[k]);
-				DynamicMetadataVMExtraLatency[k] =
+				v->UseMinimumDCFCLK_stack_reduction.DynamicMetadataVMExtraLatency[k] =
 						(v->GPUVMEnable == true && v->DynamicMetadataEnable[k] == true && v->DynamicMetadataVMEnabled == true) ?
 								v->UrgLatency[i] * v->GPUVMMaxPageTableLevels * (v->HostVMEnable == true ? v->HostVMMaxNonCachedPageTableLevels + 1 : 1) : 0;
 				PrefetchTime = (v->MaximumVStartup[i][j][k] - 1) * v->HTotal[k] / v->PixelClock[k] - MinimumTWait
 						- v->UrgLatency[i]
 								* ((v->GPUVMMaxPageTableLevels <= 2 ? v->GPUVMMaxPageTableLevels : v->GPUVMMaxPageTableLevels - 2)
 										* (v->HostVMEnable == true ? v->HostVMMaxNonCachedPageTableLevels + 1 : 1) - 1)
-						- DynamicMetadataVMExtraLatency[k];
+						- v->UseMinimumDCFCLK_stack_reduction.DynamicMetadataVMExtraLatency[k];
 
 				if (PrefetchTime > 0) {
 					double ExpectedVRatioPrefetch;
@@ -7085,7 +7084,7 @@ static void UseMinimumDCFCLK(
 							&dummy2,
 							&dummy3);
 					AllowedTimeForUrgentExtraLatency = v->MaximumVStartup[i][j][k] * v->HTotal[k] / v->PixelClock[k] - MinimumTWait - TSetupPipe - TdmbfPipe - TdmecPipe
-							- TdmsksPipe - DynamicMetadataVMExtraLatency[k];
+							- TdmsksPipe - v->UseMinimumDCFCLK_stack_reduction.DynamicMetadataVMExtraLatency[k];
 					if (AllowedTimeForUrgentExtraLatency > 0) {
 						v->UseMinimumDCFCLK_stack_reduction.DCFCLKRequiredForPeakBandwidthPerPlane[k] = dml_max(
 								v->UseMinimumDCFCLK_stack_reduction.DCFCLKRequiredForPeakBandwidthPerPlane[k],
@@ -7107,7 +7106,7 @@ static void UseMinimumDCFCLK(
 			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
 				double MaximumTvmPlus2Tr0PlusTsw;
 
-				MaximumTvmPlus2Tr0PlusTsw = (v->MaximumVStartup[i][j][k] - 2) * v->HTotal[k] / v->PixelClock[k] - MinimumTWait - DynamicMetadataVMExtraLatency[k];
+				MaximumTvmPlus2Tr0PlusTsw = (v->MaximumVStartup[i][j][k] - 2) * v->HTotal[k] / v->PixelClock[k] - MinimumTWait - v->UseMinimumDCFCLK_stack_reduction.DynamicMetadataVMExtraLatency[k];
 				if (MaximumTvmPlus2Tr0PlusTsw <= MinimumTvmPlus2Tr0 + v->UseMinimumDCFCLK_stack_reduction.PrefetchPixelLinesTime[k] / 4) {
 					DCFCLKRequiredForPeakBandwidth = v->DCFCLKPerState[i];
 				} else {
-- 
2.39.0

