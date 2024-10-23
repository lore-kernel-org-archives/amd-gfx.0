Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAEFD2E008
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 02:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E029310E34A;
	Wed, 23 Oct 2024 02:47:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rUui06JK";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6557F10E34A
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 02:47:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vg8+YgG+7+wCUaPM6CxPZVBkvA7ako576+5MOODNw0JaMNC2s/coPL5RJodw8UkQuPDrKFVpXRTYNynJeDCu0UyCo9CYD08wJSL7aGDwDGOtGnV5S+07scx3AWDoX1Gr7bFwB8etxmdr2WMl3jvF62/+JwTkmTv6gubz80vDrxLQwmv4w3rmfT04alw026uIXFhNVeTKEco98xM4JTppEbEb0mi0lAn9X07wCQk5hAIAzGXtNsuRir7e/iTWVx2zFsIxrjhR2n7DUWYmHLzfnCIP8ndvxtqE2ihS62jhFWQN38NY5nfaXbsVzzc/m6sX5lulmLpBqBRXNJM55alVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11Ub6UhUOrwXgKQXBTYh88iuIdClKjC+UBDhmXBwlFs=;
 b=kdlbAKORlfavI6tdy35Zwy8/2YF0OyAEsiN/1Av8rZq4HJqKBH8eo3koYU+N2nB/xGv3WBkW9ewI5U4lvEy6x4y5eLZMPGUDiR48JL9NXEGK7Z16iY7zTmwY7OOhDnCYsrC2C6eiG27sEAVmyJNSY6S1trrFaiBSPHm+nVX+ISuIyHFd3KfpV/G9YezmFp7oq31Iy/CXfoYov+q6vNdkdJfFwRzIn1HuHvHJA9W10sKyz7R9Y6x955uup9s7xXW4pTYEPh47E7uNKByq5zvQ+1laqjvv2RD22hkLigr+2l1h7uuC8b1g4q2ug2AUTbEsHOWyI3SpKrss2Mm7FSH9sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11Ub6UhUOrwXgKQXBTYh88iuIdClKjC+UBDhmXBwlFs=;
 b=rUui06JKwGdx/0DmZQQP2DCyeMl/JLMf+QunVbQA1HABZ9nV44gtHCk1T30huxgmVFTLl1m4n9aI8W2uZ7dr0Klxa3cTjPQjWbneoegSAw8Fx530Z72frEX90htKJzo1R02YdXWvvsI6eT7Rfex943j1w606H7P/l0+09aRkExc=
Received: from SA1P222CA0158.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::18)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 02:47:14 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:3c3:cafe::ff) by SA1P222CA0158.outlook.office365.com
 (2603:10b6:806:3c3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Wed, 23 Oct 2024 02:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 02:47:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 21:44:51 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 22 Oct 2024 21:44:40 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 4/5 V2] drm/amdgpu: Add sysfs interface for vpe reset mask
Date: Wed, 23 Oct 2024 10:44:34 +0800
Message-ID: <20241023024434.2578611-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: fa28c9a3-538a-48cb-46c1-08dcf30cffc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MTzL5I6DPhAo7rvnOPBnAk8V4qiOeq+E005e1yry7al9j5cPOCaGbwPVaCkC?=
 =?us-ascii?Q?CMl5+fJ1pdEppTRekeGhrMF8czY/6uX2bnugST2OEF63Ds1N9HLji82qapVn?=
 =?us-ascii?Q?55FxO/fV08jH2H4BbESRUWmVgzRy2oz4SndsXFvgLGc0owmx9djnEcSu6D/I?=
 =?us-ascii?Q?eCPQ5rJF2T8ImkKeB862qE5syDPp/EYV8eo6yIAAocIG8AmtaiZW8nSvjw2B?=
 =?us-ascii?Q?LJOIkGdmceBHSCaRrXVTkQpciv5oCI1dzH2wu9sEpv/mzXq6Mm4MqdXeIl2k?=
 =?us-ascii?Q?XyO/bwgXIEVavwcllinJnbAuj+japLgidoEvJhccKno/UVqe61t1ur7b/GjP?=
 =?us-ascii?Q?6AFyXWrMxxc3NWHAVMTkCLeWk9gzBFLtvZLH/43YtoZLbK552FOYp8UXgXgz?=
 =?us-ascii?Q?Z0LsJQdfkbAsysC/jaHj9YRZwvGm1JynnrBNo5v+vYhMlcJWwF/wSuvEFvD/?=
 =?us-ascii?Q?fkPmOavrPHGHRaY69tvewfrmaW1hXQZM6djkRCQ+ux8pFNXxjp67Sq+9+M7X?=
 =?us-ascii?Q?1umpAe6W42XpjXjBzohQm5Nen3Rv14A/RHqGEBOisev2oLKVIB0KylCa6rYZ?=
 =?us-ascii?Q?eAsMqZ1l1sh8nwZa43OAEBRQEAUgJQQ/OQRtfrTWw6uYM2Ry2domZx2m5Nzy?=
 =?us-ascii?Q?87RK1ZJxruFOtRUjLSx9IyZhLiMG6gEHCU1PdygDyL53F3L213qLi2sxU3Xa?=
 =?us-ascii?Q?FerYIT0elmlD+9lsnzqyZtKULH7iLeMnK2drAqP0h+TzsDudcACmJeizTVM1?=
 =?us-ascii?Q?U/kgxwgDoBllj+W3+S1/8PWXn2Vykz/pxfyGnvRdZAXC/kuhjDC5t1MD6o0k?=
 =?us-ascii?Q?5dvcn+g0NTHPqkNpsTU4hDXzNsMC3vCe0E47ILarO8C+825QPl4daahRnh3/?=
 =?us-ascii?Q?GgCF9aFBB28pi2Tp7nBHsJwWjs4j5xTr+tP+tEsNQXdgBkAzg2GGffEd01EF?=
 =?us-ascii?Q?yIwa2OW9WlOzbZSZOMEV1e6t5nqw+qoG7sKi6WL0+Sue9uehVZGhPhzOm9G5?=
 =?us-ascii?Q?slqEjEQn3NxETKQY2ZSWJdc7ICDuLqsORiNQAAPcF0amsek6UDE8LALEXtRN?=
 =?us-ascii?Q?LTq462H1lYPsWsJebBwH6WAUQmo3zdi1Y5ydb5HQ77LmsLkvSae/EBm+cNUm?=
 =?us-ascii?Q?iQZOfSo6EejCxW2GKbgWpwzcK/WkasH/D3LMa9bW4VQfT/61PGI4CJN3rlD4?=
 =?us-ascii?Q?1xrry+AnoMjivB20OQZ0HHT5xyDUZPiYXPrGC0jkCayOvjRismI30FT92uT+?=
 =?us-ascii?Q?A6zVOdYnvZhS4tvNjSR3RMyJY8f+2bqrOlfQxTn1pTzzdCYOMsli+KdND/5c?=
 =?us-ascii?Q?ULE1uQwlFDOwxeo6mb4WOZ9A5BE1cO84cfNnIkO+apWsYH2Jp6p4Qmzjh8Av?=
 =?us-ascii?Q?hwaL5b2oWR9E1mD87wdQwKoLRx9TkyuoaQAMggvi6lYMh50+8Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 02:47:13.4909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa28c9a3-538a-48cb-46c1-08dcf30cffc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009
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

Add the sysfs interface for vpe:
    vpe_reset_mask

The interface is read-only and show the resets supported by the IP.
For example, full adapter reset (mode1/mode2/BACO/etc),
soft reset, queue reset, and pipe reset.

V2: the sysfs node returns a text string instead of some flags (Christian)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by:Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 53 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h |  2 +
 2 files changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 6d96e1f21e20..eae94fdb126e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -377,6 +377,10 @@ static int vpe_sw_init(struct amdgpu_ip_block *ip_block)
 	ret = vpe_init_microcode(vpe);
 	if (ret)
 		goto out;
+
+	ret = amdgpu_vpe_sysfs_reset_mask_init(adev);
+	if (ret)
+		goto out;
 out:
 	return ret;
 }
@@ -389,6 +393,7 @@ static int vpe_sw_fini(struct amdgpu_ip_block *ip_block)
 	release_firmware(vpe->fw);
 	vpe->fw = NULL;
 
+	amdgpu_vpe_sysfs_reset_mask_fini(adev);
 	vpe_ring_fini(vpe);
 
 	amdgpu_bo_free_kernel(&adev->vpe.cmdbuf_obj,
@@ -865,6 +870,54 @@ static void vpe_ring_end_use(struct amdgpu_ring *ring)
 	schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
 }
 
+static ssize_t amdgpu_get_vpe_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	ssize_t size = 0;
+	struct amdgpu_ring *ring = &adev->vpe.ring;
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
+static DEVICE_ATTR(vpe_reset_mask, 0444,
+		   amdgpu_get_vpe_reset_mask, NULL);
+
+int amdgpu_vpe_sysfs_reset_mask_init(struct amdgpu_device *adev)
+{
+	int r = 0;
+
+	if (adev->vpe.num_instances) {
+		r = device_create_file(adev->dev, &dev_attr_vpe_reset_mask);
+		if (r)
+			return r;
+	}
+
+	return r;
+}
+
+void amdgpu_vpe_sysfs_reset_mask_fini(struct amdgpu_device *adev)
+{
+	if (adev->vpe.num_instances)
+		device_remove_file(adev->dev, &dev_attr_vpe_reset_mask);
+}
+
 static const struct amdgpu_ring_funcs vpe_ring_funcs = {
 	.type = AMDGPU_RING_TYPE_VPE,
 	.align_mask = 0xf,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
index 231d86d0953e..015ba7aaf0ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
@@ -86,6 +86,8 @@ int amdgpu_vpe_init_microcode(struct amdgpu_vpe *vpe);
 int amdgpu_vpe_ring_init(struct amdgpu_vpe *vpe);
 int amdgpu_vpe_ring_fini(struct amdgpu_vpe *vpe);
 int amdgpu_vpe_configure_dpm(struct amdgpu_vpe *vpe);
+void amdgpu_vpe_sysfs_reset_mask_fini(struct amdgpu_device *adev);
+int amdgpu_vpe_sysfs_reset_mask_init(struct amdgpu_device *adev);
 
 #define vpe_ring_init(vpe) ((vpe)->funcs->ring_init ? (vpe)->funcs->ring_init((vpe)) : 0)
 #define vpe_ring_start(vpe) ((vpe)->funcs->ring_start ? (vpe)->funcs->ring_start((vpe)) : 0)
-- 
2.25.1

