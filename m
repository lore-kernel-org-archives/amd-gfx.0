Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25794D0BB6A
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 07:40:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C391F10E8C3;
	Thu, 24 Oct 2024 07:40:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z42cIFdd";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A83B810E8C3
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 07:40:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRpRWLiDFdkKVNGS4Dnwpi8lET3FMdxahIVRlZ2WAH9P5+9FIcqwD1kiOOjoirVG7tvua49HrpSOSHDnKvkEJaww4SUTszUvgknATSLHNf30KrQ/cE6pnklRxmULSDkj46Ogzr+lC1mpgHfaZtUjaJ5GZn3MuaBYVlWl2lL1444l9uuml4c1aSfiwjOfVE4hKP9NgLG6tYDxibl4V0lIdqzi17DnKNm8f4qO6L6IV8UfeNbwC2w45OsDgA+LrT2zqYVgEUU+Qrz73yGx7EVXvyLP4TdwsqUGpXYFiz7BcjSLUzGkm0IpWhSmkC4NH8HXE27Zhj1BV6EmfBtpWl1Qxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pi0MurgdD0oAIHGaYISfEQL6c5RNr65uLh18zSb8ccA=;
 b=HLDEYGDKeLbEPrR+IJN8UC+f7kJiX2UwZVnjacBb6u1Nr7SiJkEVMiqli2/fs8ZsT+MToZpbwivPp1Tous/wa0CAGNg0rPA/Nc/0ylb4hmWKPNy7CdkTAr2xuxSSjITLZpGGAWxi8ViVh7VuHBUXaEpWeHWCizsnFWitOdJOtd7rfmFIqegsgcceSuilElR9HVIJk3FgSs9xCgwRJfscZr3NcaW+DtcZr+7YdlDB6Lg6mAdAA0kZLFQlHHxcttbwcQlOS+HesZ/fxOJzXb/fbKZc9UCn4ddfdMzdeJOv+RK4cvOCEbG8zyv4Xg9YlLOxIG7biQ0e1y6iXY+EWin84A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pi0MurgdD0oAIHGaYISfEQL6c5RNr65uLh18zSb8ccA=;
 b=z42cIFddzHBPYwmBXlJ8E70sIQD2wrxDbV1EBNlA/ALkcg8rRD0d0EKyAZ+c7AuLCC9p4+ZXomHBpOaKeVWt5Ea27xgS7rWOZQrxVgMyTHsLRW0xGtASdUFvAH4OYt4UY/Z4FEf1ybR+tk+02XC3iaNjF4Z7VNXUqAMTbzqGfK8=
Received: from MN0P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::19)
 by MN0PR12MB6001.namprd12.prod.outlook.com (2603:10b6:208:37d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Thu, 24 Oct
 2024 07:40:04 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::b9) by MN0P221CA0016.outlook.office365.com
 (2603:10b6:208:52a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Thu, 24 Oct 2024 07:40:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 07:40:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 02:40:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 02:40:01 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 24 Oct 2024 02:39:54 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH V3 4/5] drm/amdgpu: Add sysfs interface for vpe reset mask
Date: Thu, 24 Oct 2024 15:39:32 +0800
Message-ID: <20241024073933.2709389-4-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241024073933.2709389-1-jesse.zhang@amd.com>
References: <20241024073933.2709389-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|MN0PR12MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: c91ffd14-ebfd-4645-bbb3-08dcf3ff1301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?640TlAssFnHihqc+ADSyvQoRn2D6/KUTeKkx1QycVsoRxBbszfUWI1/RrGsK?=
 =?us-ascii?Q?boaizbmFi6Pbnho7tH7fC3cdBPsCPbxSIdOOAWzsb2+/vEA2MfIoEW90B60D?=
 =?us-ascii?Q?j2Y8RTjDfYpbPlsgCuVyCOX1xQa2wGvtS4J5yGkAXjVKcMRJlWUvIfvDhdpU?=
 =?us-ascii?Q?EbL1ussHxHzLy+91Tiv/ot2KNqbxc0AGCouyAtFYo2RjPW3aTqGVWeTGy5kd?=
 =?us-ascii?Q?ZiE7e26bB/UJ0M3Ds96xW3YyGqFl7k4NFyvNjsSfWZc/svB0bn7jXWvmbCUA?=
 =?us-ascii?Q?W6sO4UiYWkyAau6soMrfKkpiMdxbHATO94lclvRzCyep4ic36kJXaLUnVJr5?=
 =?us-ascii?Q?Og/ii8BdMLrnWhDlfr0xsqMXf4I8ABRTvrlZgSnNEb7ehofbGkUp/vsgV41B?=
 =?us-ascii?Q?oUvZolWrn9hZDuLEd9Etg2uIT7EUG/ykpj1XKQhA+eD5eIVobqAJYZQfAsxF?=
 =?us-ascii?Q?AEfu+KCvAjKRpg6h1V6Tled2CUi3AaperflSp5a5m8FR6s0FKlMathsDqgw8?=
 =?us-ascii?Q?qsETw4ccyYVTFMOIjWVjAR8QWFeDKRg8LYsseNWDd9eQJEV22YIxyMhYqqR0?=
 =?us-ascii?Q?4K8MlyVVcHps03+KCYi9KZhUhItYjbOfuISKGtjB9Oo62w/lW7GOzYbtGyDs?=
 =?us-ascii?Q?t2bLbMioIwAgMhXvcr3F1u+uGlIFkQi0IkFI7j7LJFVygVStOTs1yd/Dstco?=
 =?us-ascii?Q?zkGF6gk0AzZMam7poRNWYywp0hWr07q9xXZxGtCamTjVlUznThACBsZUSi6T?=
 =?us-ascii?Q?isQ8Fi7AI5HwopRgXrPC2dlimUhDQp2Lt2UkJq4cTZi7cBVlVLESZiSw6ksD?=
 =?us-ascii?Q?OfUVzFg0w5NSuammhs7NjfioA5cLa+m6niPN5j57abVZBqY52tm0izrSjuew?=
 =?us-ascii?Q?RdF60jZIDMfL9zKsGLAv1qoYfLg4NSC105bjdhG4aql1I5r7CgeRrbA0t11z?=
 =?us-ascii?Q?ZXQp4PEDAaqEW8eYV8ff3K3cHkCP/crA8hUYIUYnXunR8dYgwk6yCbU4dRuC?=
 =?us-ascii?Q?MRdEPKBQRsUpcgmAseLDw5a9ncTBAz8nCE/9iDXvYbPufHLXaSbWRrbhyxkf?=
 =?us-ascii?Q?z39woZpFceKdgQKKadNvqZgxM8TxzfxZ7MoBXz61DAeLZmvCMo391odXoS8G?=
 =?us-ascii?Q?UcoJw8J64r9GS/M58xlaILgwb8VIhPKNcoRTJFYXiP6TIObEdoAw+/RYtJRW?=
 =?us-ascii?Q?s/G96JRtfQ+pIWZs5mmCkyQ209/c/eYwWDwjG3V1TAo5md4u1xlaXfqlrj5g?=
 =?us-ascii?Q?ebW3IV/zl576BgkqGgIFxzWsoJnZZlco/o14MRpYtVO9A+jhyZJW09xg/Q+p?=
 =?us-ascii?Q?z6ARQ7tprLUtm0GAMB/NhuIpiTJmjhMNgH62xfRN9/vjMKkYYzJTDye/9jFp?=
 =?us-ascii?Q?PS7MHXJSdRdq13pTJe7PDRZygO7a5TGmY/6Oo0ogpDpfc41cPg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:40:04.0233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c91ffd14-ebfd-4645-bbb3-08dcf3ff1301
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6001
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

Add the sysfs interface for vpe:
    vpe_reset_mask

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 43 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h |  3 ++
 2 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 6d96e1f21e20..44213634e236 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -377,6 +377,13 @@ static int vpe_sw_init(struct amdgpu_ip_block *ip_block)
 	ret = vpe_init_microcode(vpe);
 	if (ret)
 		goto out;
+
+	/* TODO: Check the version that supports queue reset */
+	adev->vpe.supported_reset |=
+		 amdgpu_get_soft_full_reset_mask(&adev->vpe.ring);
+	ret = amdgpu_vpe_sysfs_reset_mask_init(adev);
+	if (ret)
+		goto out;
 out:
 	return ret;
 }
@@ -389,6 +396,7 @@ static int vpe_sw_fini(struct amdgpu_ip_block *ip_block)
 	release_firmware(vpe->fw);
 	vpe->fw = NULL;
 
+	amdgpu_vpe_sysfs_reset_mask_fini(adev);
 	vpe_ring_fini(vpe);
 
 	amdgpu_bo_free_kernel(&adev->vpe.cmdbuf_obj,
@@ -865,6 +873,41 @@ static void vpe_ring_end_use(struct amdgpu_ring *ring)
 	schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
 }
 
+static ssize_t amdgpu_get_vpe_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (!adev)
+		return -ENODEV;
+
+	return amdgpu_show_reset_mask(buf, adev->vpe.supported_reset);
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
index 231d86d0953e..695da740a97e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
@@ -79,6 +79,7 @@ struct amdgpu_vpe {
 
 	uint32_t			num_instances;
 	bool				collaborate_mode;
+	uint32_t			supported_reset;
 };
 
 int amdgpu_vpe_psp_update_sram(struct amdgpu_device *adev);
@@ -86,6 +87,8 @@ int amdgpu_vpe_init_microcode(struct amdgpu_vpe *vpe);
 int amdgpu_vpe_ring_init(struct amdgpu_vpe *vpe);
 int amdgpu_vpe_ring_fini(struct amdgpu_vpe *vpe);
 int amdgpu_vpe_configure_dpm(struct amdgpu_vpe *vpe);
+void amdgpu_vpe_sysfs_reset_mask_fini(struct amdgpu_device *adev);
+int amdgpu_vpe_sysfs_reset_mask_init(struct amdgpu_device *adev);
 
 #define vpe_ring_init(vpe) ((vpe)->funcs->ring_init ? (vpe)->funcs->ring_init((vpe)) : 0)
 #define vpe_ring_start(vpe) ((vpe)->funcs->ring_start ? (vpe)->funcs->ring_start((vpe)) : 0)
-- 
2.25.1

