Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF72C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 14:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD35610F155;
	Wed,  8 Jul 2026 14:57:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zDag+RSd";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011025.outbound.protection.outlook.com [52.101.57.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB32610F155
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 14:57:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqLqXHGzJZUdgqS/orroX+w+7wyxVTtwQ3lgFUshyDzwiR024bt+ulvg999fYsIP51tef+hI98ipsHyafFG1EpEr4+T+piYO9t60E2OWJuuRTbLrryD0WM0GfWbl0YIPXmuzVkTWNLdS5kkGOLsybwXL+32ZnGERtwDiPVzAfz89Bm8jti7lrr4HWfJANvo2G7GsX7ucRzgUBjyZoACNsKG+uuzyRB9ieBWaFh/fer5Q3SLWTmQ+NmdUAJJbdajo8tCpf0OroZvn0T/cMY19oRmjNMvLTtyFswI8g0uiwUePbLL4BHg1E3y3b53E5FFnJdCBmLcflEt/DF7ev/wttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHH7r+prw33YBUuMBpTno6OiWq4oMh1rveXmscYtVE4=;
 b=rZ1cqXQFX23MrxLU4AaWHvbtrDywidlMIEYz0lsL5KD3X43PyuV50tMhhQqOPQRzwIJHHtgEB5YPXrnfoU8oMk3e7mFPNySRVLYj2L4DW99Se8yHQtKlXZlVgPEtX83zTcso/x+x8dXWtRFub/taIQ2BO1UOYmmwJhu5tf5EO80vV+UubiSnH/h7RjfZZ/5DfapM2jeuJ/rECnGexOLmAjJmccriYPslXnXQvejwQByxSgQrkwQmuBlcwshAAB+HlhtfN8oJhV73kjjYorrtf3hOf9NGV3lfokBZni6fYPmKgyOLKgCK9T8foXXb7iApWyDcm3I+A4f3RUQJbNhiqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHH7r+prw33YBUuMBpTno6OiWq4oMh1rveXmscYtVE4=;
 b=zDag+RSdnrXInhlaLw/sAj7CYk2GhFuN9vV8fx1c1OWVTda9ZgJ5a/X4RCogDzpLxRgoeRJgJuBmFd0Ci5LjvnNOd+6T+Zqj/TbQbR9oSwPl92QTigspgraI36jBSBCNiTDpgfGpO5dRpYvwaPFbTXjKifXozS6IzVd9+doMBCU=
Received: from SJ0PR05CA0086.namprd05.prod.outlook.com (2603:10b6:a03:332::31)
 by PH7PR12MB5998.namprd12.prod.outlook.com (2603:10b6:510:1da::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 14:57:20 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::19) by SJ0PR05CA0086.outlook.office365.com
 (2603:10b6:a03:332::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.3 via Frontend Transport; Wed, 8
 Jul 2026 14:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 14:57:20 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 09:57:13 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/pm: add jpeg/vcn busy to smu_v15_0_8 gpu metrics
Date: Wed, 8 Jul 2026 22:56:49 +0800
Message-ID: <20260708145649.1587572-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|PH7PR12MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c3d9cd-4797-4adf-943e-08dedd013628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: yUzNjpyL2kJuwOXyW4Vo+DbC4oBlH8VxHKs163kEjeNDlXjNeYcTPR94Zm0ToLHXkpAWIat7DhflxXBqKKFuDH1MJOnflsQvG88A7CE54JIahlmh4gHQZpUv/bfQd38VSs4IwA3dLXFWJec2mzOkZaOrjpXLdsrGIeEuUG1cZnmtlstwce3cYiU1AH9u3hByPnxq50M6Gqnw8ZcMKVALk/oKsVR/bhh//vbmaP5fUkjEjZWhrtn5ZHB6tJ7IwO7roxRISt+4arMET0ANd+VH9obX/3/V6YpvaugWeHFIg/IkA/+T+cbdctt3mhuSTDedxdaM6f52Rh2VBUt1BI58vgMUhgAMvlDejnb8O+xIEUfvHFIV8yjNSxei6NmCi3/Stw7gpPWqPrsW+Rq3IjpWmF/tAN8G7T2KUTm94QjTWzAVVkADo4ppjwPY/lINFJlJKA/YpwxAm7NVUOXBCMxBsP0H9S61q9zdMcWHUXysQHJAkhmziXQfGWtNQwX7u2xEa0t6VPJdPd3dF4mIvVuR2lpHrVm87nRxLYEDXCXCCotZDUx7faeeVCUshUVX4M+81qWALbROxFY0c79JTG0YuT+r2gUwhfSyfv08KB4VKqeh/9wcTBN9NRschQlt9FzDaKoKYT/DrxVMci5ZqEvsJzmF4xXepsuWI8xNWeobI/LQyI8Bma+b8drb4+QQ2dxCnRddCGuQmi2JPN0bNb4aeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cA2nHH/zlU4XvRz5sfOrdOt78lPLMpo1RVPy4e7XT1SLhJuBov5FHRKWBrqM75KMHt+5YI6+oqFLsnYps2jT9pMH+YHjdogvaH8TritJffMpYzX38v0L2wL/kX4AT1nUA+yH1vUZyYLwqF/kVvoxJEunAa9gu+DKfiLS7X4vfYY8QQ4ADw6eHo3gxO1V2LToPmSqQI5UVirbzY4RtLZNcxkT/iNqgamZZj9ZRauQHh/M/tO2d50RmvIvCd1//GnsZWvfbcLa2BIN+lvFp+YkrK5VdeF3C4Sar+4FW4skCMQu3bWGC5MPGfup64BGUws9XOTye1Cpm565rhjkvORw0e41A8WZdZ6gVRhg8C2Vr5mT2bJ15YZPkJQetyMVjgYkC8hPmTrOsLK5/f/Vv66iuXg9BSAwRlD9EuX4ygMjG/UWkSTalKpTnkGwLqbm3ZVC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 14:57:20.5491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c3d9cd-4797-4adf-943e-08dedd013628
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5998
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

Add jpeg_busy and vcn_busy population to smu_v15_0_8 gpu metrics

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 2105a1d7bb34..227cd86e13e8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -1766,12 +1766,17 @@ static ssize_t smu_v15_0_8_get_gpu_metrics(struct smu_context *smu, void **table
 		idx++;
 	}
 
-	/* Per-VCN clocks */
+	/* Per-VCN clocks and busy */
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		inst = GET_INST(VCN, i);
 		if (inst >= 0) {
 			gpu_metrics->current_vclk0[i] = SMUQ10_ROUND(metrics->VclkFrequency[inst]);
 			gpu_metrics->current_dclk0[i] = SMUQ10_ROUND(metrics->DclkFrequency[inst]);
+			gpu_metrics->vcn_busy[i] = SMUQ10_ROUND(metrics->VcnBusy[inst]);
+			for (j = 0; j < NUM_JPEG_RINGS_FW; ++j)
+				gpu_metrics->jpeg_busy[(i * NUM_JPEG_RINGS_FW) + j] =
+					SMUQ10_ROUND(metrics->JpegBusy[(inst * NUM_JPEG_RINGS_FW)
+								       + j]);
 		}
 	}
 
-- 
2.46.0

