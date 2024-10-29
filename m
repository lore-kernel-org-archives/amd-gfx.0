Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93E5D13590
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 06:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65B4810E5A6;
	Tue, 29 Oct 2024 06:41:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CtjQKtK/";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C77310E5A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 06:41:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a93+H3ssYVuVP6rqLBCwOtQzynK0R2BixqS+iJ7OmIVoZjbas2394/pHWSHeOeQmB9Z03fTJFR6GoV4Om1Go4IT9SXOO3Ho8ULVcBpMOjh8jsRZTG9YYxYcecAk2B4AGbTzTB5xcxs51hN+qVilF8V7ch/xCULWqbqzUNUGilzhxD3A2haFthAYlpGfM0VZl1YQ6HS3aIt+AcSMuclNj+ZZptRxTQ+uQApKyHEQCROl9s8v9rUgqO3ylgGCOKTYvN3V+iMWmcoDG+W3iusNE7nuadVDdmqNqJ1sGD0ukFnicXCdr/KSbpPrNAMKUAuflsJr4F0hc65XRKvNi38FVjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5aIwHZn/Vo0ul1EG4j0F1kePDibZ0ZG9vTCzflKVLA=;
 b=L/L1SCJtikQipjRHl/e3rDMtni11Qsvucyuvzevbb6lOJ0as+TrbPPU/xluy+sJdpaSTb2uDd06XKgJdl/Zv6cqITIz0QbNwgHdd8iICei9TK/Kt8oIDeLAKKgWyL351ZxCP/r2ecJPxnuMRIb/PUbDQU5QVaqvZhDh6uaYZ9sTup22aKKgmnWKw0wG3CIPDZ6bZvI2FY/PzKXLGRa8WVLyNOfX6GXoUL0ZsJcLgDoyhwZIgVZYm8cAkmBPqe7wF0Qhy/2vVFPD3QTbKzMr/awxNEDL5Z1tbwwityn26PLm9c88UP28t/B5ztetU1BLGI2TKF5kiIWUMXR2Ienxqlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5aIwHZn/Vo0ul1EG4j0F1kePDibZ0ZG9vTCzflKVLA=;
 b=CtjQKtK/A0mrKA3MZYgwA5fg7rmwnADIBEC1jj2wb/BLWHKLt76rf2po90zEQoalUTLAeytyJV39WJd4yq/CQ5ArOB4yC1QA8SN9dsGLURnWm0eHmpc3HSrlhEhYkzC7acN4V/rRuJbKC48XeVsJIZQ+E8NKzIyIgAFZmu2klzY=
Received: from MW4PR03CA0339.namprd03.prod.outlook.com (2603:10b6:303:dc::14)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 06:41:51 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:303:dc:cafe::77) by MW4PR03CA0339.outlook.office365.com
 (2603:10b6:303:dc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29 via Frontend
 Transport; Tue, 29 Oct 2024 06:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 06:41:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 01:41:50 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 29 Oct 2024 01:41:43 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, "Jesse.zhang@amd.com" <jesse.zhang@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V4 2/5] drm/amdgpu: Add sysfs interface for sdma reset mask
Date: Tue, 29 Oct 2024 14:41:33 +0800
Message-ID: <20241029064136.3057034-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241029064136.3057034-1-jesse.zhang@amd.com>
References: <20241029064136.3057034-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|IA0PR12MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: 26dd4be1-14a6-4bb0-99ba-08dcf7e4c52e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1MUW8dwPuBaaR0iL1Mgt9+fBc1ml5MUo9ULoZDlAk3jhpfsqd1NX5fm0hM5s?=
 =?us-ascii?Q?HXwXbyyJcSSeH3/bVbPReVqfOyuOquXi3Uxw13xLzvN7EuJubiAgKbUjzJVs?=
 =?us-ascii?Q?HHZ0Qk+6tjZnMym4EE9yOs4O++eiNL/dOYFgr4NhS5n1nSSkaxZH5wLN/Vr2?=
 =?us-ascii?Q?y1Hh7ZL7ZUllgEsb8vzzyBvQfMDbKozp/H89ZDw3iDMB0BPKtkoXOviH1aIY?=
 =?us-ascii?Q?rPF4hbjXNrGJQQ/9MorhExNAjLb+rVy7KO7Jn1fM0Ng0en6JokPucngY2Fqk?=
 =?us-ascii?Q?JXne9HkIx25yiuqiNDLDEulcMu3RQ1sic+dKSFK0hhMqSoBAhJCuTO0vrx1o?=
 =?us-ascii?Q?3gnrtPI7/tgFYMm2Q3RE8ritZHxUFKbr9qQvDWdx+hh8bH7rhreSCHG3pmhn?=
 =?us-ascii?Q?hlb496ZAGtd7teonhCtW8wWOXY7IhI8rWT6RVupkGQr0p3Wh6fDrL2K0Yv1+?=
 =?us-ascii?Q?BnHRgFXQVudCUU9F4FZD7QY0TERalXq9W/j/et9BUUDX26DjjQ/uu2OFp4cQ?=
 =?us-ascii?Q?3KIvRSyo1bHPMBgvG4yzexvLCinhzOFzO82VxvJKfnGp99y7e6f83TxI4VcE?=
 =?us-ascii?Q?aheladvBlMCZWBq/+ErpCf3E4L9GKdGY3S/NyJnp6nPPVKAiyvqnHvdWON11?=
 =?us-ascii?Q?HzotpJrceStZD9MC2DrGtrE3C9phBPi1wfbO/sslSOVyhltDfN+n8WrZnpQQ?=
 =?us-ascii?Q?Ronpe1wtIcV6vCyOAWOuHslnMeEjGC7TgYOcYrInNUA7g47sd/hwN8Q+k1m1?=
 =?us-ascii?Q?EXZWwGFiuKU4roJnco7fsR8A3Oc1enaEcXUXBersAXB9dvq0/ycCFai7wNW+?=
 =?us-ascii?Q?WMoF10ixtMniBc7gviZ9A3VBCyV5mqA/Swy+/SrOf+JydFwYZ2OSz1muoFQm?=
 =?us-ascii?Q?Uid+U1wXT0bSeRoUZ/nFXwXJLtMkqT3i8prQHPWahnBb01Y5BTLSUTe5LFJB?=
 =?us-ascii?Q?E+va/9iF3yfKIoRB9IXNO6os7fLLrNBv15x8vxWcr9B9lxl25ga4dggfivE3?=
 =?us-ascii?Q?zgiHltvck9yE50Za8WJfTAtbSUmz139gbwzMa9YXAum6kPPZhFAhIN8kmIsT?=
 =?us-ascii?Q?4LMccLB+0KvCXL/FFkTBgAi22rPLkOHVuDVNwbOVqarTaEcApjjPugPmZRdU?=
 =?us-ascii?Q?2+Prkb1zQ3yHQINs1IY+YjEBHBTgXI1ZBgYZ+k+ZHgGPtolxck++Gd2lpjqq?=
 =?us-ascii?Q?Ei5qXGPSw0rd7xXsZWlmqFrGDl+3c9F/SzzR8TUUADQ54QGxT37ThaZwvigI?=
 =?us-ascii?Q?E4WLIKPmI6HSvuxLjiKx3ggoSgbc04GgV25f30mOfbnbUsk92Vx86OgIOkx1?=
 =?us-ascii?Q?+U1WkEGvpzn9lMHHAL6ae3euC1m/8gO+0SQkRrX01GVV5O0eLVZPL3i9h1Nt?=
 =?us-ascii?Q?zr4UODt0Rr9hKC97+tFSh9GtmWnBFnenLeyERI0F+yb8v/2IZg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 06:41:51.1756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26dd4be1-14a6-4bb0-99ba-08dcf7e4c52e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505
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

Add the sysfs interface for sdma:
sdma_reset_mask

The interface is read-only and show the resets supported by the IP.
For example, full adapter reset (mode1/mode2/BACO/etc),
soft reset, queue reset, and pipe reset.

V2: the sysfs node returns a text string instead of some flags (Christian)
v3: add a generic helper which takes the ring as parameter
   and print the strings in the order they are applied (Christian)

   check amdgpu_gpu_recovery  before creating sysfs file itself,
   and initialize supported_reset_types in IP version files (Lijo)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by:Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 41 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  9 ++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 18 +++++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 23 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 17 ++++++++++
 6 files changed, 111 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 183a976ba29d..7edcd989afce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -343,3 +343,44 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev)
 
 	return 0;
 }
+
+static ssize_t amdgpu_get_sdma_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (!adev)
+		return -ENODEV;
+
+	return amdgpu_show_reset_mask(buf, adev->sdma.supported_reset);
+}
+
+static DEVICE_ATTR(sdma_reset_mask, 0444,
+		   amdgpu_get_sdma_reset_mask, NULL);
+
+int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev)
+{
+	int r = 0;
+
+	if (!amdgpu_gpu_recovery)
+		return r;
+
+	if (adev->sdma.num_instances) {
+		r = device_create_file(adev->dev, &dev_attr_sdma_reset_mask);
+		if (r)
+			return r;
+	}
+
+	return r;
+}
+
+void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
+{
+	if (!amdgpu_gpu_recovery)
+		return;
+
+	if (adev->sdma.num_instances)
+		device_remove_file(adev->dev, &dev_attr_sdma_reset_mask);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 087ce0f6fa07..7ce613de7ee0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -116,6 +116,7 @@ struct amdgpu_sdma {
 	struct ras_common_if	*ras_if;
 	struct amdgpu_sdma_ras	*ras;
 	uint32_t		*ip_dump;
+	uint32_t 		supported_reset;
 };
 
 /*
@@ -175,5 +176,7 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev, u32 instance,
 void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
         bool duplicate);
 int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
+int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev);
+void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 9c7cea0890c9..d73932728b93 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1430,6 +1430,10 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
+	/* TODO: Add queue reset mask when FW fully supports it */
+	adev->sdma.supported_reset |=
+		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
+
 	if (amdgpu_sdma_ras_sw_init(adev)) {
 		dev_err(adev->dev, "fail to initialize sdma ras block\n");
 		return -EINVAL;
@@ -1442,6 +1446,10 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return r;
 }
 
@@ -1456,6 +1464,7 @@ static int sdma_v4_4_2_sw_fini(struct amdgpu_ip_block *ip_block)
 			amdgpu_ring_fini(&adev->sdma.instance[i].page);
 	}
 
+	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 2) ||
 	    amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 5))
 		amdgpu_sdma_destroy_inst_ctx(adev, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 6a675daf5620..4b71f93fc1c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1452,6 +1452,19 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
+	case IP_VERSION(5, 0, 0):
+	case IP_VERSION(5, 0, 2):
+	case IP_VERSION(5, 0, 5):
+		if (adev->sdma.instance[0].fw_version >= 35)
+			adev->sdma.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+		break;
+	default:
+		break;
+	}
+	adev->sdma.supported_reset |=
+		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
+
 	/* Allocate memory for SDMA IP Dump buffer */
 	ptr = kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint32_t), GFP_KERNEL);
 	if (ptr)
@@ -1459,6 +1472,10 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return r;
 }
 
@@ -1470,6 +1487,7 @@ static int sdma_v5_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->sdma.num_instances; i++)
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
 
+	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	amdgpu_sdma_destroy_inst_ctx(adev, false);
 
 	kfree(adev->sdma.ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index e1413ccaf7e4..38cb5ebe1b7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1357,6 +1357,24 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
+	case IP_VERSION(5, 2, 0):
+	case IP_VERSION(5, 2, 2):
+	case IP_VERSION(5, 2, 3):
+	case IP_VERSION(5, 2, 4):
+		if (adev->sdma.instance[i].fw_version >= 76)
+			adev->sdma.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+		break;
+	case IP_VERSION(5, 2, 5):
+		if (adev->sdma.instance[i].fw_version >= 34)
+			adev->sdma.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+		break;
+	default:
+		break;
+	}
+	adev->sdma.supported_reset |=
+		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
+
 	/* Allocate memory for SDMA IP Dump buffer */
 	ptr = kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint32_t), GFP_KERNEL);
 	if (ptr)
@@ -1364,6 +1382,10 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return r;
 }
 
@@ -1375,6 +1397,7 @@ static int sdma_v5_2_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->sdma.num_instances; i++)
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
 
+	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	amdgpu_sdma_destroy_inst_ctx(adev, true);
 
 	kfree(adev->sdma.ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 4856a093e23f..97c837dbb135 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1351,6 +1351,19 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
+	case IP_VERSION(6, 0, 0):
+	case IP_VERSION(6, 0, 2):
+	case IP_VERSION(6, 0, 3):
+		if (adev->sdma.instance[i].fw_version >= 21)
+			adev->sdma.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+		break;
+	default:
+		break;
+	}
+	adev->sdma.supported_reset |=
+		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
+
 	if (amdgpu_sdma_ras_sw_init(adev)) {
 		dev_err(adev->dev, "Failed to initialize sdma ras block!\n");
 		return -EINVAL;
@@ -1366,6 +1379,9 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 	adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_v11_0_funcs;
 #endif
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
 
 	return r;
 }
@@ -1378,6 +1394,7 @@ static int sdma_v6_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->sdma.num_instances; i++)
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
 
+	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	amdgpu_sdma_destroy_inst_ctx(adev, true);
 
 	kfree(adev->sdma.ip_dump);
-- 
2.25.1

