Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB22107637E
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 14:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D16E110ED3B;
	Wed,  1 Apr 2026 14:06:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HFLStizo";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C152910ED2F
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 14:06:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4gsvpY6/p2nyilU0EItyRfT0NLsOdv6loxc8imxQRlvEkMyvrCJ7FSYCS5DAhB2W4SpLkUaA2W9acyjLH7hCSeZdhXF4yif1GVaLQ81RGSPWS4FASlYTLGrR/NdpB3pBrH8zpQLcC8emsS1CfwyB37sFJmuMsTiqJvNCnuv8Q3GmJtlQtvg8ymy9iLbZWN48RRMn2aANu84QVeVawxzUP/2SI/2rJyc5wmqOzpTp5a0TsVkFPUwALNp1PZ7Poa4rjtXzlVnJf66NT7ckrBkTFOUJyVqQcN7MzUGD3zUN57MrP9UU2NelAAyLNd99GiNnAdW5gan+A7B9jxHX+yz+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSZICZ/tAffOJqPSVrhTmjkTNEalOQOfxKkzfi2soRM=;
 b=iV2KOV99lSpdzVIrA2mJcBlTQgktAiq0TQ1DC89LOQd53U/+pPQAbqeCxfRuQXRx6pLKi8LrShVQR0QbXIpxU+rCZbFePWiw11JOdwJecnd60tAYr4FIes4M5EcmTijsq4UyASzPW8M2h1Cxb50sRL4WVelbt2BdzxiotaeCLnYX0KkLc/RKrRiNkS5m7hRyfbuV+Efh1LzesaqnI8C8VEahAW9kzVeyvjBVWu9MPoE2rZ64q5/Gw4W/w/eIgo5oQlaspj7TgpllD/IaXiiym6USpqBqmbDaNIdsCM/surZfhpVhVuMORo2L8zw6PK8lKIXOYcIFqGtbwGer5X8+gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSZICZ/tAffOJqPSVrhTmjkTNEalOQOfxKkzfi2soRM=;
 b=HFLStizosuCK7hwgo/BkAi2uym1wDiJSqfO2VFaldn9rWH8DhOFILj8I01ECZmWdDqNeyQsbI5Sycf4ydKSTrxpK3NytU1KNyBVNHr8Y9Af4XLCg3AQR8IktBQOdpIcFdAxHDil13ELVI36WLnGKWwtBItxWR0vYl2W72ZR+G2o=
Received: from PH7P220CA0150.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::13)
 by LV3PR12MB9095.namprd12.prod.outlook.com (2603:10b6:408:1a6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 14:06:00 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::52) by PH7P220CA0150.outlook.office365.com
 (2603:10b6:510:327::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 14:05:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 14:05:58 +0000
Received: from test-X10DRi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 09:05:58 -0500
From: Alysa Liu <Alysa.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, Alysa Liu <Alysa.Liu@amd.com>
Subject: [PATCH v4] drm/amdkfd: Add upper bound check for num_of_nodes
Date: Wed, 1 Apr 2026 10:05:51 -0400
Message-ID: <20260401140551.19398-1-Alysa.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|LV3PR12MB9095:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f85e25-8f70-4b07-540f-08de8ff7cccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: pP6hoC+Cx8poQJHwOzjChdEnmdIHaQ+CnfFN0tWBRNd6+pwnDehJHXDOvG1+hXTpKYNoUFrUn67BukTM9P1Wvm3piUat5pOMhzLpSXXRb9IdDLd+J8W1segFvyLheGp/uV/QphcmPq0P5bFIyx5BF7BgGEkzjY5cX0O2jUTnUyR4vG92foIm1MJwzzJgfqsJfDN/tYk7qtbQU0OZw836fpPj4vzClgw+NwJY1dMFlXpApJprbwxiS0HJfZiVeGvRKyF6X04H8oPppU+HbgR5WIZ20hp1lbwiz5SkIOwAhEKilCmTfLT9O1J6o5QCb7iIVCeM9fgCi8oen83RV1hZhb57W4r8RHqnR/y06NvrrxLgFyFaQCba8iEG0IOKWwdpjTPkHle+Dg1U+jLP2rcHAh1gDvUlVZyT72u+25CRRP1oCLiYVgB8SjMNrgoHj6c2O3kMS5GyFziIUhLrYUm95FlxberaTsdwFb/mHdhAunCYBMlj9KqOyJp3CFKQUO1zIrF0q8hxiSuwR8U4vdtBj6YCTWnWJredu1rp6eP9DWZu6sXDyqxJ81KQ0qPCAZVb5j9pisuXCNsW6Hvgbd4dPZi4jgeXxAHd3OsS+L4LX2Rc857J9laoNckcYN01F5V3g45nuQcY1gApVV7sEMoWNoVPn2tgCeNvfaYCnIdTPbRPbyvd+CtWpPYcyoTIJ80UsL/k/4iZbeA2P/7u/PJdH74711D55viN4TZqFJhybQeuBrbo5ryaCM1mUzCv74SGAmNTI0h+ABMjDuARknFd8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pYc5OlEXUvYfpN+UN/KB7Eld7NraJdPm4jntvvbDeuc6eReUx2So4d9+1s49PyYWbojOfPIOTccJjIWzP4a8eLLlw3Yq17t7Ne1IS94o0K46+EUAzdCDevwzyga6f0fRL47B4ATBWOqfDiyPZh6aiHWS5oo2EpOGF6CvJuD2eUMtR3OJHduXUxfYyHFfFmy9Zz6ZPvBlEGVpdbbffrlFfXlFlrQNGVawX0SETC91xcug71AlgIsxjU/zuqHEEn16WY+Fe3YRNcHbfVAQNwu0VyH4tpWHIiMbHZRkFZBViY2E/PT2LaxufA37wHDApK0u7iCIwADEbhG+Gmx9qdRzvYv2lbssWjgkj+sqx5vwa1ZBK6T7TOqigKFILL1KbRgYCVwZdQFrQLn0lR4e0+orYgU/QU0BdeI4+fHvFeTdoh7k+5QMEs2jd+T1b3XYndLK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:05:58.8488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f85e25-8f70-4b07-540f-08de8ff7cccd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9095
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

drm/amdkfd: Add upper bound check for num_of_nodes
in kfd_ioctl_get_process_apertures_new.

Signed-off-by: Alysa Liu <Alysa.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c  |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 11 +++++++++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 1db565442c48..5435419a7bd9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -776,6 +776,9 @@ static int kfd_ioctl_get_process_apertures_new(struct file *filp,
 		goto out_unlock;
 	}
 
+	if (args->num_of_nodes > kfd_topology_get_num_devices())
+		return -EINVAL;
+
 	/* Fill in process-aperture information for all available
 	 * nodes, but not more than args->num_of_nodes as that is
 	 * the amount of memory allocated by user
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index e7a8f3e17872..af7b687d729c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1191,6 +1191,7 @@ static inline struct kfd_node *kfd_node_by_irq_ids(struct amdgpu_device *adev,
 	return NULL;
 }
 int kfd_topology_enum_kfd_devices(uint8_t idx, struct kfd_node **kdev);
+uint32_t kfd_topology_get_num_devices(void);
 int kfd_numa_node_to_apic_id(int numa_node_id);
 uint32_t kfd_gpu_node_num(void);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 1ccd4514d3ee..4dc9f9aa3a2e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2297,6 +2297,17 @@ int kfd_topology_remove_device(struct kfd_node *gpu)
 	return res;
 }
 
+uint32_t kfd_topology_get_num_devices(void)
+{
+	uint32_t num_devices;
+
+	down_read(&topology_lock);
+	num_devices = sys_props.num_devices;
+	up_read(&topology_lock);
+
+	return num_devices;
+}
+
 /* kfd_topology_enum_kfd_devices - Enumerate through all devices in KFD
  *	topology. If GPU device is found @idx, then valid kfd_dev pointer is
  *	returned through @kdev
-- 
2.34.1

