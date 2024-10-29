Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E341D13594
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 07:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C11F810E5B3;
	Tue, 29 Oct 2024 07:15:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jzfg3gaV";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04DFA10E5B3
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 07:15:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+5Dqm73sL1lW0A2QOMzHH02w3KGsDPQplTJk2pTjCet5ZDz9yJfLn/SLh2rcQGg1eMQ99tK5I8v+k2HVsA0JPX9N7CWTc2ItqJjdB5t1HbVw6ZP+nYGF3D3C8yUz2e/ejpHsJ6PJluOgWsdbMle2t+jt14DU+AWa71wp8YrtA2SnBMA/gREcUu5ggj62ZlMHE9JXBIUR2agUmA28Ok860LEsbhV644wmiJyh2RLlVJb94Ip/4BAeFYY99enLVNPNJWizk3QdQ6MskiAOc+FxPhOqQy1/3icZueNt1P17wcK6BLO4msrpEV4XPA1j1yOw7G/miHej3n6S+DBxldX5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OW6yUidk0c35BTQcF49xD9WY62TkfbL5urxsNmvbrHg=;
 b=A832mdno88vKK45YeI+DzGnLLUwi9T6jjNvr5ki3wnXAz/eiHzAnAMfUrw6BZscQPhG5e5kEwdPUimnsTEtwTnKeJVALkypSN0tmvPllMHCuRjx8nvAbROQbX2wdf+tPpWefehL+4WcU7yXGr9k/rHdJ6mPSYORKB+wfpZ7r3ZRuuhaaca34pcMoS+Rk4PY4cMUHsPezNL0CHddH1cW76USZYt7bQSnuiUAspi6c7Szj1EIHKlAMVSBHPhZb1+8OlRB7AHYIcsLF/bqvNkExY3Q7+J/FpEkzB6HrHkLV/7oQpdN7m3MrS9E3TcOJtdLNuDECfpusOoX32gKcGzxf1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OW6yUidk0c35BTQcF49xD9WY62TkfbL5urxsNmvbrHg=;
 b=Jzfg3gaVA9hRy14P8RLa79LOxMAt5j6qdiP2Ulql3Q+kTwLjPotWWGZFkPS5Mc5LQm1J3FPG/QAdmHwFdm8+uNOSo11M8JxpyC5YNlj5cNLYFwUi0w4nnsD2IvhCOANUBvsBsVc23WHeS2P4q8c+9EQN5ct5kJDygqNKiIyNxk4=
Received: from PH7P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::19)
 by SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Tue, 29 Oct
 2024 07:15:54 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::d0) by PH7P222CA0025.outlook.office365.com
 (2603:10b6:510:33a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23 via Frontend
 Transport; Tue, 29 Oct 2024 07:15:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 07:15:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 02:15:47 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 29 Oct 2024 02:15:41 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 2/5 V4] drm/amdgpu: Add sysfs interface for sdma reset mask
Date: Tue, 29 Oct 2024 15:15:40 +0800
Message-ID: <20241029071540.3078018-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SA1PR12MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: 360be546-0ee7-4dbb-65d7-08dcf7e98688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mvm+0W7WhAy2IU36za+632BL7I7PnMACrUSb2FGgHTPrYdAQO+NfCfRhTvJi?=
 =?us-ascii?Q?j71SuUbf37xGdqYFSlBQ5a6AUnEwDYSwHAHqodtkFVzIk+Y3GceXVaFbQfA9?=
 =?us-ascii?Q?eVhA8jFAl6jmpAcvqlEwnYGSf1ajRr+9qZBZFr6ElOC0RwTd0mL258wJnBkf?=
 =?us-ascii?Q?GGeOB+BizFX9Jk6Prlki/oP7CWCOpt93oP3AEl2XKL1bX1uFxM67nGbToD8c?=
 =?us-ascii?Q?OX8D5S4d/b4MjpaYGdHB0hxRP/MU3qIOjVglQQVpJI6JtjQ4ej5hkvsVk1oH?=
 =?us-ascii?Q?ouY8TzCKfmXD2rc+UcjTckNCYdBb5rUwL6cxFCXhnXW4HLDJx5ldeMxNEBZg?=
 =?us-ascii?Q?5CF21X4yIfmlimd0SVjTdHxLIHq285Ea0y39IhFH6gH+2uf1bNZe4OygONKg?=
 =?us-ascii?Q?egU/roXP9/bztp6GVFokwsqxKAGklLqlTIWGacrUHG0Lo7p0DIRbCb4WyDLn?=
 =?us-ascii?Q?Ej4LtB38M+Mlx0wEodvK5NIS6AIeDuqRRnr4p0Qe+ZvfoL/feS7GHTjRE9hv?=
 =?us-ascii?Q?3tZU/qtSrg+zuNabTXWQx+6TfM9IOmNnPDKHln3JKEnbWIuRxMYsYUMas16F?=
 =?us-ascii?Q?qvFSvXn0xUszZwGRkvM2f62Ee32kk5NDZoP8B+MPPOdUSZk6oQ2JpmIMT7C8?=
 =?us-ascii?Q?bZYPQA0Z0FOEiUjkmCuSSxwbZhZj/MxlQGur8/DlX6FgmbWgV0dh4VRuc8Cc?=
 =?us-ascii?Q?y1h52YVwJwKRoEifal6uWxEwAWN3QtIgekt7AD9pgCG+K72X012wDMcUmQ+Q?=
 =?us-ascii?Q?ovjMAtogR95sT1IZ6YQVX8TejKu9F7VRTP0xUZnEap/OuGJ7fGyLCrkG8u1w?=
 =?us-ascii?Q?8XmPaEUQV0Cs9AViX+mm2qAsEmEwExiIe9Z3U/ueu9bpiK5RjMRZCp8chPTZ?=
 =?us-ascii?Q?fxxCZTWqad4CzL6VGgDTL7Jhuk1YPQZsvrqCI/4kcs+5LwVLPdYGCANtv4ab?=
 =?us-ascii?Q?bgRkyruMlOAd2Idiu0/n6Rw9TpD3Aved4yPMMewt1cCSP5oNE9SRYbEP7fhc?=
 =?us-ascii?Q?x6DBiUvpPh7VRkh2D9XnfJwshDLXlAARkP2nIjmTnWCQg/mUB9f29ENvGMHT?=
 =?us-ascii?Q?4yPjS5N1Q1JYSho+pw38ouiWiN4Xij88nihj6ddUQ/eJAD3rq6Wt6ZsllGub?=
 =?us-ascii?Q?Yr0/o7upeRlg7FsZSKPFCmFavGRPTHW4n1ulsbLk1U/SWY0sIfiSyg8dYOiW?=
 =?us-ascii?Q?pQYjLaKljMk1oEmXalBji7YqW7rMmbGzaLHywnuCegrcsYe6UQeCayQUq7iw?=
 =?us-ascii?Q?7267/i+7x0VD9Hr7DaFimL+n2SB+BNfvQq4ueXY8V+rDd9izEDtCas1DpiJ/?=
 =?us-ascii?Q?NdmXHN9v9VSAxfHWrdxSPCcjhhNb90ns//S0/K82+Qv92gFRZC3EQboJY+bW?=
 =?us-ascii?Q?WqLZe1zG55CKfAaL63SqYD2ACq9TS18jNFac0YhV3mpxOeR4Xw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 07:15:53.4576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 360be546-0ee7-4dbb-65d7-08dcf7e98688
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

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
index 9c7cea0890c9..a38553f38fdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1430,6 +1430,10 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
+	/* TODO: Add queue reset mask when FW fully supports it */
+	adev->sdma.supported_reset =
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
index 6a675daf5620..40d0e8e9132c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1452,6 +1452,19 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	adev->sdma.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
+	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
+	case IP_VERSION(5, 0, 0):
+	case IP_VERSION(5, 0, 2):
+	case IP_VERSION(5, 0, 5):
+		if (adev->sdma.instance[0].fw_version >= 35)
+			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+		break;
+	default:
+		break;
+	}
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
index e1413ccaf7e4..cb276ff77b91 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1357,6 +1357,24 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	adev->sdma.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
+	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
+	case IP_VERSION(5, 2, 0):
+	case IP_VERSION(5, 2, 2):
+	case IP_VERSION(5, 2, 3):
+	case IP_VERSION(5, 2, 4):
+		if (adev->sdma.instance[i].fw_version >= 76)
+			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+		break;
+	case IP_VERSION(5, 2, 5):
+		if (adev->sdma.instance[i].fw_version >= 34)
+			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+		break;
+	default:
+		break;
+	}
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
index 4856a093e23f..86d101cc3bdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1351,6 +1351,19 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	adev->sdma.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
+	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
+	case IP_VERSION(6, 0, 0):
+	case IP_VERSION(6, 0, 2):
+	case IP_VERSION(6, 0, 3):
+		if (adev->sdma.instance[i].fw_version >= 21)
+			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+		break;
+	default:
+		break;
+	}
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

