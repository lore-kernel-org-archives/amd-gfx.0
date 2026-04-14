Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00904F9D0F4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 19:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B048A10E656;
	Tue, 14 Apr 2026 19:46:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xLCmExi0";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012022.outbound.protection.outlook.com
 [40.107.200.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8081610E119
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 19:46:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9aYW7BewIIyVa5fr7cm7axsixVxk8xjF6wFnbDvjeccs0TccwLNJ2LpYrHxjrk2muLzI6PY7RSJmGyAzKUvTkzU5ftyQm1L18krG/hjkOYymM6aFZuVWaKe2P/x6pjBo59BFphmPZPTbKqJUQbYPnMVWTLNr+13UIoyrLTTuFNPvsex+s/o7anDuZ7zh/qtAFwHe/k9Eogv5uJ6mYG7wU6o+yWgR/u1zv1DxsY//lEBSAZrH3xBxHfVGPdbcfd45lhzHM9HQ3L+H8jGiblSFyrLvkoT5j4icZAnBm+0BCC+6RiFbcNxtWSUclyoum60RtdcDglO1X2xzsWcIhvFVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgMbAxZvhaUKXRNYzvDkT/V8QSKvdpBkdKstDEKqrYo=;
 b=Q5uopJoD6L4AWg4I6EqCbkviIBZnfssevC6kUGnZK0VxP82JGNXE0QL8GMm5fydvDa+uYxClAMAiUVHldIA8QvKQZlFDo8awb7X/ImWigErW0Shc1MuSe8/lXGisd9IOoHMbL9xLJXtw3H0rczwhp0a70//APEBq8cSY4qfBx3Zjp+nVDaTw1DzxbJe20l+J99APsO3dzWak2pUHFM9WEplPZvFHaTsu30Wanff+uJU5jgMJT/PA7sg2djis+YcCEgTr58pgu913kqyk9qcBuxkQa7UhFttIxD24hNVnhSlXCLWp+lPb326116Rtjw9Jyy3MxnBWdV0vE7oBMzcbPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgMbAxZvhaUKXRNYzvDkT/V8QSKvdpBkdKstDEKqrYo=;
 b=xLCmExi0LoT3RXuRqbman2FqOgldCmcgp2eSwgBnkZ0WoXx2YF3edkCduDjYmv+u+URZg/LyKxoP6H2P9E632mKvOupjh+zpPGSqzUkTilzTO5kFKRsbmONNNaNwvvBIlC8mBsNGQ4GX77YLqEpppEegHEE12hBGxG8wqEoMmro=
Received: from DM6PR05CA0049.namprd05.prod.outlook.com (2603:10b6:5:335::18)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 19:45:57 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:335:cafe::9c) by DM6PR05CA0049.outlook.office365.com
 (2603:10b6:5:335::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 19:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 19:45:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 14 Apr
 2026 14:45:56 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Apr
 2026 14:45:56 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 14:45:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amd/pm: Add mem temp to gpu metrics for smu_v15_0_8
Date: Tue, 14 Apr 2026 15:45:46 -0400
Message-ID: <20260414194547.2213525-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414194547.2213525-1-alexander.deucher@amd.com>
References: <20260414194547.2213525-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|DM6PR12MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: e31d184a-5578-4e3a-f8ee-08de9a5e727a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: bBR37mXkZlEsh/jvMv0nTAEA+xTnHa1zJo1/dU2sEC1LRdbjuCsBiEhOmj44NeIT4d0/+takqJsRMFpUrceQTS94/1pkCDJVaVjXF2MNEpAdHFByvArfqXo7ELGUgzrSwmQrT0mNoW5kWtSY6iSt+Q9Pwt2k5vuLWhUHK7ReOm/iKkzi6PolASYRfdRZJDA8nzj0+D8TzQvmMQYVc1i2TI0F8UC1k1M/Oq7QqsrYuGgobwMMaXFSleazAY6ovi2HsPiCqCPX2z4Ju11TII5gVRfMc5LWeEiD/hDigDsyeQroRAwh6Dc1xEkhlHXoZ4BgILu+Vnf1JTzrY0t/GBI4Ty9lOAGCrro1lLpEyneQDLyjXsFb70HfRiBHyeHQvNvwjaHZqQxY5FAfu8qskVmAP7Jde3Pf9aJ7THosMsE9QLTynXMfhUdkunpoB+U4UBiZHpiEMYTeJNTBIoOlWqUgPRGQitP0Q/Ow6wa5jHVKGQHyuTX33kB7eNhqdReEHS0sTquOaLbZ5Qk8Jb/FfbYdRBtGF1I5mIBV1pEfZ3lWuWlskBeBSWRzR0LHUyy9nCUn177OsvA5GJv9SAhg85JuXs0hozjePKI9pPUiV8NI7Ecni6JYT26mN8N0cnAZTprDuTGWw/oe4texcETtsUoqe7ESsp3kip7yjUkMCJhmJwxrZ3BsLX5U7ePPdrBZmbftXHXHpjQGSuzF6FOMcaft/2LbQM3dfdSLQGcqB3rOnlNT3+QePEeRdIaFQlAYqHVO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: axqySbdFs0krqxxJw/EHOUr6pWuV/Lb0XJBslRuYPbygF4L/cuVVHPx/lRi4RwWFdL+G1l4PTyvLDz3WOV8WNKXVfN3cA4M6YcBGtjzzOsoaZ8SKRsE7ivduJACx0RrvlKp3i0Y520RiJXv1/nsxpD5QunNi2MbMIV5w/vuPM8x29Aklf+5BCExf+eS63WI6T0w6x04oape+COsLudj3ZOTxVU8EYRFJdvZkIWPK7TkLzydDq/psJmsK4fMGgB0rqPreaSRDGeABnr/yvf9Sw8o4cMrYgDtUyGSiDlZBPR62MQFqY1N4Dzi3HwV2jg6vLgIXlA+a5wleGNwkWhXmegGuiG7v5NzCDri5pxZPRiyaVNIMSobGuU9SrrDcggBRO77OLRXD9+9LIg/X4TqWjkys/H+6t8CYP3tEcExKdquMlOCDRg1YE+FA3bC/wT0i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 19:45:57.0668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e31d184a-5578-4e3a-f8ee-08de9a5e727a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
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

From: Asad Kamal <asad.kamal@amd.com>

Add mem temp to gpu metrics as maximum hbm stack temperature
for smu_v15_0_8

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 288fab5ee5e53..e62494810b803 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -1696,17 +1696,23 @@ static ssize_t smu_v15_0_8_get_gpu_metrics(struct smu_context *smu, void **table
 	if (adev->umc.active_mask) {
 		u64 mask = adev->umc.active_mask;
 		int out_idx = 0;
+		u16 max_hbm_temp = 0;
 		int stack_idx;
 
-		if (unlikely(hweight64(mask)/4 > SMU_15_0_8_MAX_HBM_STACKS))
+		if (unlikely(hweight64(mask) / 4 > SMU_15_0_8_MAX_HBM_STACKS)) {
 			dev_warn(adev->dev, "Invalid umc mask %lld\n", mask);
-		else  {
+		} else  {
 			for_each_hbm_stack(stack_idx, mask) {
+				u16 temp;
+
 				if (!hbm_stack_mask_valid(mask))
 					continue;
-				gpu_metrics->temperature_hbm[out_idx++] =
-					SMUQ10_ROUND(metrics->HbmTemperature[stack_idx]);
+				temp = SMUQ10_ROUND(metrics->HbmTemperature[stack_idx]);
+				gpu_metrics->temperature_hbm[out_idx++] = temp;
+				if (temp > max_hbm_temp)
+					max_hbm_temp = temp;
 			}
+			gpu_metrics->temperature_mem = max_hbm_temp;
 		}
 	}
 
-- 
2.53.0

