Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFF6D2E008
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 02:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C15410E073;
	Wed, 23 Oct 2024 02:44:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U5m0Fk05";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 215B610E073
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 02:44:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h07CYgvoYcCdGUR7wHsZHGk/Xl16LInFVdTbp/72sjPZ1kB8D/kLDsenr1cST66lqyL7fZzVkDDJuz7b9BZKNFhUy7ImQY9caSZ12RBGIqMgdUlD1NgAV5IEpCd6iPku48RJyf7pHnUEZfv28+t8jNQFzHYUBrhzDK5rjOzo0iS/hFs0VP7tio9x6mwiaaAQck+RAYpxmM1tDZ0x9xSAB2Nedbm21nXPpr3szd5K5FzdI/SwnHMbk5DNC38FAaeiPuEHXhTnr2K0DE3eHYuaJg/363+huJl3sRp+Bll+AwCVAmedBVsF4oX9U87lt3wQ5ihUUtY+jSu/1vlMHYC1cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKv6v/el6CmKiWhpFOMNXisR6wMB+YbPufdrehqRWEo=;
 b=Upa6WWKbEmtpDnZ25kmuERgfZwv8XXlbmCYvai10pW0dMA8kPlEh8jUSGpxrau3HJdwy5kiUtf8dyRNk3bfzLXY+Zqt/ObIvYSOoE+M/KF5tbubDSsXdxcqdVmoQF0J5ZNCpSYNf2NU1EvZFKX1y/XpVeO+W6u+HJp41whnk2ZkrKSJKLGf/4XtRepI3+vIHGsxqeMWuy2l3jHogc8fkrIzhQGKSqKwnTLoU8YsZRAS/IJYpTvVlXdeOlMNjs66f6G2zD15lW9vTCELJfIWnnCJK8cOTDmGfolh/zrqokdAoBNiIQ/hCIlw4Kjq3QIEPl3tv6E3e8kxr0rkUOF01YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKv6v/el6CmKiWhpFOMNXisR6wMB+YbPufdrehqRWEo=;
 b=U5m0Fk05LKsx3VY1HdRGYjgbhymJtWesYSYTfFcEUO6cIt7K+RHkOAq+Kb8jG+3bMB/oMwAgDtRf9kjSlgHT1xpo90+vR9Y9JPyTuIK0dq2RRL0hMtdOK0+rcK/zKe3t7rn3D7tI/19A1bjwoxJEXRJpIkpdrTW+acZMQnIEwes=
Received: from SA1PR05CA0015.namprd05.prod.outlook.com (2603:10b6:806:2d2::24)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 02:44:17 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:2d2:cafe::d0) by SA1PR05CA0015.outlook.office365.com
 (2603:10b6:806:2d2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Wed, 23 Oct 2024 02:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 02:44:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 21:44:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 21:44:15 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 22 Oct 2024 21:44:09 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 3/5 V2] drm/amdgpu: Add sysfs interface for vcn reset mask
Date: Wed, 23 Oct 2024 10:44:08 +0800
Message-ID: <20241023024408.2578558-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|MN2PR12MB4424:EE_
X-MS-Office365-Filtering-Correlation-Id: 882acda9-2c97-41f1-9770-08dcf30c9668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wt9ovK7TtyBy66Y/hkz1EOEHNqQL+4xB0dTZ/UIkrz5sMfO6ly8L7cJ3PpWb?=
 =?us-ascii?Q?NKjjZ/YQz0BTcHK20C8v9o8MNy/A6LlYfqwu/zkWp3Y0Prbc4u3PuMT/KW1z?=
 =?us-ascii?Q?xz2UZRnvfcoI0dBTmqRVyVliTBaKn7DfI1vlc3iLQYEXoMqsbz3h07nI39K5?=
 =?us-ascii?Q?Gj2MiL/Ya7Sxti3WtAjZNGi6x2le9+fxwBcvJjaq5IIvaXRj0QO03/2besw6?=
 =?us-ascii?Q?7lQpjVWYKe8JsxHb1SzvMVHFHJjHpp2OTqyEARisrPE/jYxPxRKGIKsfGcxm?=
 =?us-ascii?Q?FtNLwuQZRZIj2uqnK7X4mrNvQfABRiwg4MA8eHMCIW1M7NGQVU3etFdKa/Ex?=
 =?us-ascii?Q?ZDdxw8R2oFzTRLKmp2UyN8C48J/udjcuzzyYNDfGVkld/XF+A0LJEfwxQrVK?=
 =?us-ascii?Q?8vbaamDRT1LqQe6q7okKP2fff0n4BIVkDX6vnqzuTOwuUEroyHzLjR1XKsp1?=
 =?us-ascii?Q?zKkn7CT8WvJHD2X4oC7LeBePoEmj9lHxR+vacBEniIijhOxwrCGoXS0Ytidc?=
 =?us-ascii?Q?OImfQCiKAreFJyzfwlBKc2Jf1z7V3dfww+DuvV4rfIbUKx/AdoA8GP75mQIz?=
 =?us-ascii?Q?FDrT11C7G/Fzol0+awcChR1JSaIF0SE7vcGNGa1RbhgYU8wQrxqh8/8wkav5?=
 =?us-ascii?Q?S1SWLL3QtRvclEnIDrWGTq4d8VrQFzyMfjip/06Y98Wninm9IS0/FSt3Q+d/?=
 =?us-ascii?Q?1J419m8fAFgw5/DxhVFePhzSnp4b044wrSaSfnJhI2L3j97cWq+KsvNihede?=
 =?us-ascii?Q?a5/kO8HQrljhIIo+4j9quXGgOfW1sR6Um0DCVexexrQLsbTdUvjZCcdAqmWu?=
 =?us-ascii?Q?N2s6RQ9nggrkH4fHeXo9b9/fK4QgeLuWp79CvtcXB11Ob7bkdyOaURWOuXYQ?=
 =?us-ascii?Q?WuGFncDttX2Fm5VFlAPsJQTx9t1leoefoFb+7jy/BlYzaV2TGbWgjSmvXukn?=
 =?us-ascii?Q?7HhXG05WtZdXoANKy4Z1YldgV/z91g69UQtYRSSRSdaEjtJ74GQG/MnImpNN?=
 =?us-ascii?Q?CbDNIxTLl7u28jiAhDtsgqngevjV8efisMLqsk3aL+8s/K8G09pW1B0Ws0zm?=
 =?us-ascii?Q?zbViJlRuyRe9gxekVMIVbVKgIV6W7uHuc/XmEdujynDOaoJGZYRrv/Ak6I2G?=
 =?us-ascii?Q?bNrq5jctK5yysCPhD1KtPnWGXMf75XCCnKoXAq0kCWE7eEEMp3OJrUNU0NOz?=
 =?us-ascii?Q?0cttVQrKV7MkUaTFGa+4KdXvoDwLo/4eZfjhr/H8J/OTWKqM4hM/keRNZjvC?=
 =?us-ascii?Q?EkJRNazq9WP8Fc5KB/2kcjjZA5rckoxlpOwkiRNAeYnmkBY+x1RkzIdjyXmr?=
 =?us-ascii?Q?NyJwDLTRKN7REzcP/BXeJ/IEdhHSpXsZ1XexEQS5PmegR6E0LZu8+7zxc4FV?=
 =?us-ascii?Q?cyvpwKlxXRt5I9TFpSL8vo1OQzTXfHIaNa5emc8PArkrwZRVnQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 02:44:16.7424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 882acda9-2c97-41f1-9770-08dcf30c9668
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424
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

Add the sysfs interface for vcn:
vcn_reset_mask

The interface is read-only and show the resets supported by the IP.
For example, full adapter reset (mode1/mode2/BACO/etc),
soft reset, queue reset, and pipe reset.

V2: the sysfs node returns a text string instead of some flags (Christian)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by:Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 48 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  6 ++++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  4 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  5 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  5 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  4 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  5 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  6 ++++
 9 files changed, 85 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 43f44cc201cb..7ae52c7026d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1277,3 +1277,51 @@ int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
 
 	return psp_execute_ip_fw_load(&adev->psp, &ucode);
 }
+
+static ssize_t amdgpu_get_vcn_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	ssize_t size = 0;
+	struct amdgpu_ring *ring = &adev->vcn.inst[0].ring_enc[0];
+
+	if (!adev || !ring)
+		return -ENODEV;
+
+	if (amdgpu_device_should_recover_gpu(adev))
+		size += sysfs_emit_at(buf, size, "full ");
+
+	if (amdgpu_gpu_recovery && unlikely(!adev->debug_disable_soft_recovery)
+			&& !amdgpu_sriov_vf(adev) && ring->funcs->soft_recovery)
+		size += sysfs_emit_at(buf, size, "soft ");
+
+	if (amdgpu_gpu_recovery && ring->funcs->reset)
+		size += sysfs_emit_at(buf, size, "queue ");
+
+	size += sysfs_emit_at(buf, size, "\n");
+	return size;
+}
+
+static DEVICE_ATTR(vcn_reset_mask, 0444,
+		   amdgpu_get_vcn_reset_mask, NULL);
+
+int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev)
+{
+	int r = 0;
+
+	if (adev->vcn.num_vcn_inst) {
+		r = device_create_file(adev->dev, &dev_attr_vcn_reset_mask);
+		if (r)
+			return r;
+	}
+
+	return r;
+}
+
+void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev)
+{
+	if (adev->vcn.num_vcn_inst)
+		device_remove_file(adev->dev, &dev_attr_vcn_reset_mask);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 2a1f3dbb14d3..d52c3f752c06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -518,5 +518,7 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
 
 int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
 			       enum AMDGPU_UCODE_ID ucode_id);
+int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev);
+void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 129c759772c2..5d03d4c0a273 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -207,6 +207,11 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 	} else {
 		adev->vcn.ip_dump = ptr;
 	}
+
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return r;
 }
 
@@ -228,6 +233,7 @@ static int vcn_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	jpeg_v1_0_sw_fini(ip_block);
 
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 	r = amdgpu_vcn_sw_fini(adev);
 
 	kfree(adev->vcn.ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 19bbd49f760e..6a7a55bc96bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -231,6 +231,9 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->vcn.ip_dump = ptr;
 	}
 
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
 	return 0;
 }
 
@@ -258,6 +261,7 @@ static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 	r = amdgpu_vcn_sw_fini(adev);
 
 	kfree(adev->vcn.ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 13632c22d2f9..7c5838060bae 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -293,6 +293,10 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->vcn.ip_dump = ptr;
 	}
 
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -329,6 +333,7 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 	r = amdgpu_vcn_sw_fini(adev);
 
 	kfree(adev->vcn.ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index e7b7a8150ea7..b2fd59c55804 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -247,6 +247,10 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->vcn.ip_dump = ptr;
 	}
 
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -284,6 +288,7 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 	r = amdgpu_vcn_sw_fini(adev);
 
 	kfree(adev->vcn.ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 6dcae398b2dc..d99787f4dce1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -206,6 +206,9 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->vcn.ip_dump = ptr;
 	}
 
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
 	return 0;
 }
 
@@ -239,6 +242,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 	r = amdgpu_vcn_sw_fini(adev);
 
 	kfree(adev->vcn.ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index edb9cd8390b6..dc73d3d927e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -214,6 +214,11 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 	} else {
 		adev->vcn.ip_dump = ptr;
 	}
+
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 89bf29fa6f8d..b1d8c31de764 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -181,6 +181,11 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 	} else {
 		adev->vcn.ip_dump = ptr;
 	}
+
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -215,6 +220,7 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 	r = amdgpu_vcn_sw_fini(adev);
 
 	kfree(adev->vcn.ip_dump);
-- 
2.25.1

