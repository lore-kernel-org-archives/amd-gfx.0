Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D10C3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 05:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 085F410E0F5;
	Thu,  8 May 2025 05:10:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="erLXQdO8";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82B9310E0F5
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 05:10:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8BL1DHvOwYJ4/Z4k38LZPQputzATpyuE7lulojTmBB5XhJ88SY2K/JbKsQY1K2qCV2irTwwwZyp4joMs/l9YOIjraUNao3S8VwLZ2DZLcuHwP+VmFkYQ6AXsaqWbK+5/g4kTLrlFNpX+3HQMasZrqkVepcq4BEEruIECWknJhSEdIYzAUqme7VgWsueB7b1aga4vHrVFb1Ttt2oamobYoDUuMHjMHkPKMkafHq5A8BQvJzyFZ6fVNqnqQx8Br5LlFvVlKSxjSc5I5cv7GkUAAAeOpzsuzZBw1hyjRwZSgw8rBKk/fPQ+QtTep34StPVWdnz+T9fb31i49W3n+jnJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fa1pEPSEuF1lRdojuKQA6r9E6tE8oIJOQKCH0V4blF4=;
 b=D4D8erJ10Nm24gqOYwngEF/ebFXjn/v2IliFfWpj2iyI4lJ0t1Y9/mt/D9lQkXAkHDHu4opKlTyRQxTS5z0tI50tztGeWZfCM8FF8CQ/GzSQTOEdQuphnXd9F+QnT5R0DKHwEuvRtIQtuPJlvjOc51/PqzEtpHBaXHkaG3a0QnRsHoAVYr02S19m1AHbteFzzznxNx+68smcP48Co+6G8izbel2BMzHJ3oBau5HcOG9ZwvvXgU96dPM+QFqyAqoQ1wF0OSgGHTI9q9R8OsEXFp3cOTMOL+qbAAEnVMYB0/6LD7nu2KjhvOE4K+5xZbd6iVXzFy0tS6TISGuGOOimqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fa1pEPSEuF1lRdojuKQA6r9E6tE8oIJOQKCH0V4blF4=;
 b=erLXQdO8K/DwyQwns921XTIC6XzeKfz/inaa2PITJ14x4CSJB0oekltWsTnMjUIEY8ieYJ02lMdZZroatbwpsEqfCQ3XMLmjl+stF1ETqpF3hmEhkTQovqvDd6kuinzSliNuXj2iX/tb61b/zm2VeR0ZPOl/72Nr0g9AVwzj56M=
Received: from CY5PR19CA0008.namprd19.prod.outlook.com (2603:10b6:930:15::11)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Thu, 8 May
 2025 05:10:05 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:15:cafe::7b) by CY5PR19CA0008.outlook.office365.com
 (2603:10b6:930:15::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Thu,
 8 May 2025 05:10:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 05:10:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:10:02 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:10:01 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 8 May 2025 00:09:59 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, Jiang Liu <gerry@linux.alibaba.com>
Subject: [PATCH v4 1/7] drm/amdgpu: update XGMI info on resume
Date: Thu, 8 May 2025 13:09:20 +0800
Message-ID: <20250508050926.228674-2-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250508050926.228674-1-guoqing.zhang@amd.com>
References: <20250508050926.228674-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c0122f8-160a-4f58-3b40-08dd8dee9770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Bwe60l8ruiosa2X3lpzRZcIbtaOtLGn1Hypq03mvoFulFP2lFw6NWiwQzOHP?=
 =?us-ascii?Q?h0gY+/JRUErbaT2ZodHBwDDPJx40CB393YCBSlS5ISBYqAKGGVpdK7GqfQwx?=
 =?us-ascii?Q?kV13r9O/udI20c941QvF26G+L7tht2AZzfogljvQUPw+eq6zKp2vr/At1bK8?=
 =?us-ascii?Q?Ji5ADIXdCGjc1DQRmj63N5t8GhXh/MFvothwsw7JNScuGGJ4IjAcSY0PRM8K?=
 =?us-ascii?Q?yq018kmhsmykIquj/rJyyDg2up2oEc/DYuoQ6K9J1znQKWZ5cPIulUGUkCcC?=
 =?us-ascii?Q?4Clta9+f02DLAfkS1VvkKWU1dFPO5dT5OjtfA7+tdGhSRH8Y5AFFehgSNuax?=
 =?us-ascii?Q?G2re6WbD5zEIeepA+BVBzPXyOzcYKiF+RvIyo6bb8cF3tI9jcBGVAWH5vAzF?=
 =?us-ascii?Q?/lUwSoQLBXLgxJjygKtqIDwRsGTShHaEh2D2eEQd/fwln0xqSHbQarCmQdGy?=
 =?us-ascii?Q?4wJ8UEH0+BS3YJwEw/MiBYg8Bxo89ivxi/bVEjsduGeuMokthGSfqiNUM1Ud?=
 =?us-ascii?Q?kQj1UfcpvortqAAilKTZBvQKjRaHYHKBMKrzuYcqrUcvPA5y62AlxQ6B0mrg?=
 =?us-ascii?Q?zTeW6xXMfSFDOSHRRqRcYC3DIVIOrxmq6KRaqHUloWALyr62RDbHVkmsXe4B?=
 =?us-ascii?Q?lTyAwAaJTteuNA/NvFGRz+DM7otEJn3oE7hGf6yPY1FRMusQIbN5yqFKA82x?=
 =?us-ascii?Q?z1TxyXYPwVEvw5nAGZlt/K0DvoN5LQ8HrbvtLWYfnC3fsikpumh8622mdCUH?=
 =?us-ascii?Q?hbG7txlVWl2PG7lTtoYhwf4ZEHZ1QjHkuOObXUAiK438o1Vix8w4XiIPo9X/?=
 =?us-ascii?Q?q6lr3+EEomXd9GFuP74J0tIEoCEsgZAP7Dm3iEjEc3hoMSIAPTjUgRCnrglK?=
 =?us-ascii?Q?5+lnypoKxGrqIeREDEyRKJInk7t0I2T5M+P/2/Vc8IDsjkQ3IAcma2g6lmSy?=
 =?us-ascii?Q?/0ymLnXXPvYaoTqVjchDd76itQN8kKuwNOjeTd+9eX5p/4f4ng6YjClH0Fhv?=
 =?us-ascii?Q?vIEPKMxb77GWvMBjJ3TYK/0n+9Z0+8qDilaFICtkUgfrcsIQB45i4kaFcaQV?=
 =?us-ascii?Q?5nZCFMqCJWiBNGF0O5+vlpkQsjnQIx5kJWWWgKVNYjDpAUtFHsAFQokSllgo?=
 =?us-ascii?Q?bOAiKJ9B+59xiOCE3ucn79fw9/b2blSj1c8o+6mWjH6gIfZJr51tT0CBdguO?=
 =?us-ascii?Q?c+m2W7vOKPq3atqxdR2uPmvGsOetn+txlwskMKo0m6bpFi+TP7VSk/y9yOQ0?=
 =?us-ascii?Q?FkiAJCQd5WNQS6gacMFBTUo2DwhT9xHdiS5ju2ST8dJuMrCMlUjHY0l1wAk1?=
 =?us-ascii?Q?29el2HsKGsJm8lwe/ng0KXymfMTqwYGk8w26yVmrvqNPlbp3ntYcCS+i44VL?=
 =?us-ascii?Q?R1XarAquQ6tT6FegoM3Xa5kJgfgDR4myjKeY/3ztEP1W1Q+wo3MtAF/UlBLC?=
 =?us-ascii?Q?oGmAQeEB3pM0cTKn0UO94l2WQAe/fztw7zDPJF2sdswV6qMDRyCGlEyR7/fM?=
 =?us-ascii?Q?9M33f+sfthi9cMZEPEhYqtoSf+juhvDjw6+N?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 05:10:03.7464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0122f8-160a-4f58-3b40-08dd8dee9770
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907
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

For virtual machine with vGPUs in SRIOV single device mode and XGMI
is enabled, XGMI physical node ids may change when waking up from
hiberation with different vGPU devices. So update XGMI info on resume.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  4 ++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  6 ++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d477a901af84..843a3b0a9a07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4478,6 +4478,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		r = adev->gfxhub.funcs->get_xgmi_info(adev);
 		if (r)
 			return r;
+		adev->gmc.xgmi.prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
 	}
 
 	/* enable PCIE atomic ops */
@@ -5040,6 +5041,26 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	return 0;
 }
 
+static int amdgpu_device_update_xgmi_info(struct amdgpu_device *adev)
+{
+	int r;
+
+	/* Get xgmi info again for sriov to detect device changes */
+	if (amdgpu_sriov_vf(adev) &&
+	    !(adev->flags & AMD_IS_APU) &&
+	    adev->gmc.xgmi.supported &&
+	    !adev->gmc.xgmi.connected_to_cpu) {
+		adev->gmc.xgmi.prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
+		r = adev->gfxhub.funcs->get_xgmi_info(adev);
+		if (r)
+			return r;
+
+		dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
+			adev->gmc.xgmi.prev_physical_node_id, adev->gmc.xgmi.physical_node_id);
+	}
+	return 0;
+}
+
 /**
  * amdgpu_device_resume - initiate device resume
  *
@@ -5059,6 +5080,9 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 		r = amdgpu_virt_request_full_gpu(adev, true);
 		if (r)
 			return r;
+		r = amdgpu_device_update_xgmi_info(adev);
+		if (r)
+			return r;
 	}
 
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 32dabba4062f..1387901576f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -89,6 +89,7 @@ struct amdgpu_xgmi {
 	u64 node_segment_size;
 	/* physical node (0-3) */
 	unsigned physical_node_id;
+	unsigned prev_physical_node_id;
 	/* number of nodes (0-4) */
 	unsigned num_physical_nodes;
 	/* gpu list in the same hive */
@@ -101,6 +102,9 @@ struct amdgpu_xgmi {
 	uint8_t max_width;
 };
 
+#define amdgpu_xmgi_is_node_changed(adev) \
+	(adev->gmc.xgmi.prev_physical_node_id != adev->gmc.xgmi.physical_node_id)
+
 struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev);
 void amdgpu_put_xgmi_hive(struct amdgpu_hive_info *hive);
 int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 59385da80185..7c0ca2721eb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2533,6 +2533,12 @@ static int gmc_v9_0_resume(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
+	if (amdgpu_xmgi_is_node_changed(adev)) {
+		adev->vm_manager.vram_base_offset = adev->gfxhub.funcs->get_mc_fb_offset(adev);
+		adev->vm_manager.vram_base_offset +=
+			adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
+	}
+
 	/* If a reset is done for NPS mode switch, read the memory range
 	 * information again.
 	 */
-- 
2.43.5

