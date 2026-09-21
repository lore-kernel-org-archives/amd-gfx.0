Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597A5C982EE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCCF610E549;
	Mon, 21 Sep 2026 20:32:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mSABVWZ/";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011053.outbound.protection.outlook.com [52.101.62.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CA8610E549
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:32:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4T8xlNgCg7HxcqO5KWiOoGOSHbz6w4PWmZ1Z40zptJoEDQwRIHsMkpmyOnSusaTECeRYsXr1hNM5sQF/46KcXHwY0b1DUj9INXX3eNmMYrMbQbWoaeR6378jNttBdCbYAuYkKI1Bb0TOIPu4X56BRc4eMSuARNm1qs1RCNvqyZaQqpMba4+kxPbC+AuKqzmkcJgjZWslPeaPGidm3Ay4+QEuF9YPsEUyl+vS8z0WlN5HBSmLY4F0LpNL8KNLiQTqLBrilw4/08XM8pvtUo4Yi8m4tN7qmoOqEvSCUJWCZs43E4BfZ4zmR172/FsMo3uberbKj4irLxgnY7faVMO1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mx7FeLvHdgjvaRHh+jSkMUuNiUBeOWw/hoPAG7L8+iI=;
 b=WrGBtGhp3TA0KLguaErYUxUx+JI9xyeYUN8vfNzXUUVGKZyfuEsL5cXCFdcHzEzfUFjw8pUHe+7ORPa6Xe+uefrYuR3Bhj8qqTAwQEUlH59IUU30zDmjzfCDp6Mxf8awCm9KVLPQ4d1oIT9nGlcj1Je3sFaWDypfijcBUORBxmPsD2srHjzLniNFuYA92CaPJZEfEUvKMupVpBJzSP2ECIcxp9yeIAQQBHgGtjEIRkeQTOmHpKJVqZoXmtzFwBegmotPmWCLT4WJOH7iMz05baoFyEI6ajCaQ9GkMOIwZ9IHiWKl04fd3BuJqr8WMOYCE1RsOMFQp+b3wyhUDWjaew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mx7FeLvHdgjvaRHh+jSkMUuNiUBeOWw/hoPAG7L8+iI=;
 b=mSABVWZ/X/K+vSQy7W+52rhE3I7+hGdaGmf+9pNYHP162jGaHr3/H03kdwv/+N0/W8T5DVKPk/4W1KR0XAoA6kGFhVhGAa1wb2tgFiUJG0WYgrpnzmRz4+eSt3QLIGdhssX3o5xHQNtdEuy5bkRGTPpkKBx3tmBtu355TQW1F5M=
Received: from SJ0PR13CA0109.namprd13.prod.outlook.com (2603:10b6:a03:2c5::24)
 by CH8PR12MB9815.namprd12.prod.outlook.com (2603:10b6:610:277::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:32:22 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::61) by SJ0PR13CA0109.outlook.office365.com
 (2603:10b6:a03:2c5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Mon,
 21 Sep 2026 20:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 20:32:21 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:32:19 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 15:32:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: ZhenGuo Yin <zhenguo.yin@amd.com>, Frank Min <frank.min@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: fall back to RCC_HW_DEBUG for VF frame buffer
 size
Date: Mon, 21 Sep 2026 16:32:06 -0400
Message-ID: <20260921203206.2038708-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921203206.2038708-1-alexander.deucher@amd.com>
References: <20260921203206.2038708-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|CH8PR12MB9815:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6d949f-d81f-4056-e368-08df181f6ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /7lJ36Qawyj6oohjg93l0mFCcDzAruU2XLnrx5eH6StREXtTKD/y3+PMSLYvrJ8bpM73oA1Pdrs9v38QY4eWhQtW8HOAL/FVqWL5qAB6Vb7YI7ZrZeYD4aEZUJKXDyfimZLqYh9ojkxb9rCpuhL7J8VI60R25hVz8DcBvs4Y9jos9QMqsLkaJHaDGXvIlibi4L0NqRbOgnWqcXb9K8QpH8bLyaCdny5g5jJFw5jQX19jQeZ6WXuwQYAr5nFPFG6c8DiYMr32U2wI4xc6ubOhdVnvNU2qv2u5vquzDkjNWp7gUB4B/6LV3yCsXiFy7kBuRPJbz0jHCU6BD+Dqez++d9ri1ML8wVZTFc5IOaaP525hWWpZze6QCbQx7b5uOqrCILLeBXhIoGWwF+6qCFYQVmrdIiBoTLxVPOhS7MeE34I6Ke6kgvMj/TtTN1MfIayPRRmzg+al2+zMSkNokvrGAKk2cXI1b/fs0T9NqsvzZNv6uSRR56SINmWVyAvUyPdooLGDr1hyD+2Y/6Iake6Xofl4gCrcodWf6Yv21nuECvIoX45zgUv5pD5OorcfXlK1eAZ3xIl/uHTDCI/cl/XCRcK9qsdx9SrwLgjKGgiyIq+g8SRLaE1Ma3tPVCqmiP3TFAZgCVxCdhUkZHPVs4QYvbhkt/KNc5mqMHihgzXsByPc6DFeKQmaa7lk6qNxEPC8MmVV9WrqaBZRMNRaaj2+WQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: itFhwYA3nFrkm2CDx2NUQOFrSA+OqQeUFiGCw5vxsg+O/JL+YM/555aml7kmRQnCpv45x0CiQQ72P8t4BQidttXnNdZ2hjojA6UKmNnReitrPpjl1Q5xVelMajm+UBwEAhuhX00CDm3Jd7wquGOlOpHWxtEZkSnAonT3Imqz/QSnViB4AS+At8gPN81+32fDaa+D/rqYt7dj8QUamlS9vL6VBvsem1x33iDnQ3AAuIG9+qeAAApBlkYZjc23st2RW177FxpH4fJIEyrnMu6Hn6iAqv6sJjFmgQ044xjPnuee+bCl8P1LPrMcvNQuAxCn//gVEF61OVaX+Rh+I2gNvaQp1HTRmcnvgbK37QUoJYx2pwu3H4aMrPYeh3HoBkzN7q48y2OWABJgvQnpE2D8Ky0qG0zm3TsCbT/HugSls2aIuy8LrsCcNCSrGv/FLaNJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:32:21.0458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6d949f-d81f-4056-e368-08df181f6ff2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9815
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

From: ZhenGuo Yin <zhenguo.yin@amd.com>

On some SR-IOV VFs RCC_CONFIG_MEMSIZE reads back 0. Fall back to
RCC_HW_DEBUG for the frame buffer size in the nbif get_memsize()
callback and in the early-init paths that read the register directly.
Only VFs that read back 0 are affected.

Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
Reviewed-by: Frank Min <frank.min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 16 ++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  4 ++++
 drivers/gpu/drm/amd/amdgpu/nbif_v7_10.c       |  8 +++++++-
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 2034754d6af74..59294028f0690 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -144,6 +144,7 @@ MODULE_FIRMWARE("amdgpu/aldebaran_ip_discovery.bin");
 /* Note: These registers are consistent across all the SOCs */
 #define mmIP_DISCOVERY_VERSION  0x16A00
 #define mmRCC_CONFIG_MEMSIZE	0xde3
+#define mmRCC_HW_DEBUG		0x10c01
 #define mmMP0_SMN_C2PMSG_33	0x16061
 #define mmMM_INDEX		0x0
 #define mmMM_INDEX_HI		0x6
@@ -289,6 +290,17 @@ static int hw_id_map[MAX_HWIP] = {
 	[ATU_HWIP]	= ATU_HWID,
 };
 
+static u32 amdgpu_discovery_get_config_memsize(struct amdgpu_device *adev)
+{
+	u32 memsize = RREG32(mmRCC_CONFIG_MEMSIZE);
+
+	/* Fall back to RCC_HW_DEBUG when RCC_CONFIG_MEMSIZE reads 0 on a VF. */
+	if (!memsize && amdgpu_sriov_vf(adev))
+		memsize = RREG32(mmRCC_HW_DEBUG);
+
+	return memsize;
+}
+
 static int amdgpu_discovery_get_tmr_info(struct amdgpu_device *adev,
 					 bool *is_tmr_in_sysmem)
 {
@@ -313,7 +325,7 @@ static int amdgpu_discovery_get_tmr_info(struct amdgpu_device *adev,
 		}
 	}
 
-	vram_size = RREG32(mmRCC_CONFIG_MEMSIZE);
+	vram_size = amdgpu_discovery_get_config_memsize(adev);
 	if (vram_size == U32_MAX)
 		return -ENXIO;
 	else if (!vram_size)
@@ -2323,7 +2335,7 @@ static int amdgpu_discovery_refresh_nps_info(struct amdgpu_device *adev,
 	struct binary_header_v2 bhdrv2;
 	uint16_t checksum;
 
-	vram_size = (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
+	vram_size = (uint64_t)amdgpu_discovery_get_config_memsize(adev) << 20;
 	pos = vram_size - DISCOVERY_TMR_OFFSET;
 	amdgpu_device_vram_access(adev, pos, &bhdr, sizeof(bhdr), false);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index a454c6f12d38d..681a9904a79e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -47,6 +47,7 @@
 	} while (0)
 
 #define mmRCC_CONFIG_MEMSIZE    0xde3
+#define mmRCC_HW_DEBUG          0x10c01
 
 const char *amdgpu_virt_dynamic_crit_table_name[] = {
 	"IP DISCOVERY",
@@ -1068,6 +1069,9 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 		return 0;
 
 	vram_size = RREG32(mmRCC_CONFIG_MEMSIZE);
+	/* Fall back to RCC_HW_DEBUG when RCC_CONFIG_MEMSIZE reads 0 on a VF. */
+	if (!vram_size)
+		vram_size = RREG32(mmRCC_HW_DEBUG);
 	if (!vram_size || vram_size == U32_MAX)
 		return -EINVAL;
 	vram_size <<= 20;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v7_10.c b/drivers/gpu/drm/amd/amdgpu/nbif_v7_10.c
index 9022454aa74ec..3cdbb79906470 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v7_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v7_10.c
@@ -60,7 +60,13 @@ static void nbif_v7_10_mc_access_enable(struct amdgpu_device *adev, bool enable)
 
 static u32 nbif_v7_10_get_memsize(struct amdgpu_device *adev)
 {
-	return RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_RCC_CONFIG_MEMSIZE);
+	u32 vram_size = RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_RCC_CONFIG_MEMSIZE);
+
+	/* Fall back to RCC_HW_DEBUG when RCC_CONFIG_MEMSIZE reads 0 on a VF. */
+	if (!vram_size && amdgpu_sriov_vf(adev))
+		vram_size = RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_RCC_HW_DEBUG);
+
+	return vram_size;
 }
 
 static void nbif_v7_10_sdma_doorbell_range(struct amdgpu_device *adev,
-- 
2.55.0

