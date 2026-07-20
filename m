Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBA1C44515
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2026 03:44:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D41F410E102;
	Mon, 20 Jul 2026 03:44:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eCsmVAqk";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012065.outbound.protection.outlook.com
 [40.93.195.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C91C10E102
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2026 03:44:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deMFYve0cQ5h4bzzXhcZ3Wf20aqO8TuaIDmW63rq6IdGGRnUUIVzD/mosTPr3/zkPoTpocjpxrRo4DKgEelH+JiNsW8XnjT9hL0CTFd72+Vfsx8jCA8iDexMtBu79exsSVkwJ8PV1Kx3uUNTO0VZBRyA9jaf0jD/UIt+yKTERlVA6H/ktz8KrWRx7KgzZlolxC6oOHPSzqmpRQ14kFBEuqCgb332qKF2MP+6fJDRtnKw8VAxEUHGiakrwBbXienxIL+pt6rO/KMnYkKq0c3NPu5DtWNa1QDDr5/bsKr6nxlnwShftxY6hEjOxs+UBUFHN89JQuR51DXg8tOqIDQRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzb883wzskmtDdkfzVvSGe41RCTJD90XoWj2HMpi5Zs=;
 b=RcaZL63Xf+Y2HZcTQitR0GEA5ygm+f3lb6LBkKQkHh7mj/+QmUcwmLRB+20Nu6RsrKa0WTAczU3FFcBqVkF2+0lcSqELkg7o9OaOlmyxh5nUnfzm8rgicvcP3HtYHntp2k1AWy8L2nXdiPu5hpL/OdfrXz1oQ2Snlw/mI+nCnpKRF0izcrTz22iMEBxha6cw1Oi/15/5s668WrtLszFEvWW6otdmSg7fE5aJmDWN7er0uoQCcMFBNKd4W1LQeg590izvGxrbn2TKzUn4NQqVtX3OIDpxEs5olFnp2NUE4YcCqKJ3ZmZbTiIpiokhwYPOTbWJNo8V1chn4+fm5bHGHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzb883wzskmtDdkfzVvSGe41RCTJD90XoWj2HMpi5Zs=;
 b=eCsmVAqkuqXwyntDeocqgfWm20z9trSomn4Pg/mKyXH5LOqp/QhAUlMGaf9W01cbradRqFewalWXjfacNKYB80U/ZEcP2VX/0Lj+ge4L8RUvtpD/68cxMu8xtKRmc3OkcNjk3tvy8966xXMyE2vD/l0E0kux5aQTxbhBNbBWcg8=
Received: from SJ0PR13CA0138.namprd13.prod.outlook.com (2603:10b6:a03:2c6::23)
 by PH7PR12MB7116.namprd12.prod.outlook.com (2603:10b6:510:1ef::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Mon, 20 Jul
 2026 03:44:49 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::80) by SJ0PR13CA0138.outlook.office365.com
 (2603:10b6:a03:2c6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.9 via Frontend Transport; Mon, 20
 Jul 2026 03:44:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Mon, 20 Jul 2026 03:44:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 19 Jul
 2026 22:44:48 -0500
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 19 Jul
 2026 20:44:47 -0700
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, chong li <chongli2@amd.com>
Subject: [PATCH] drm/amdgpu: reduce early full GPU access during SR-IOV init
Date: Mon, 20 Jul 2026 11:44:30 +0800
Message-ID: <20260720034430.786535-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|PH7PR12MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b54341-109a-46bd-255a-08dee6113fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|10067099003|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: XU7Oq4oMtx1kOt1p5v9OFPzBVlvPBAYSsNpLgxINIT6+w3jgQnMROkmwxyosIWp0gTNsxxeR5O1kmETTyTgmc+/XL9hIMziR/bjb2XiFpNrdrkLzYyTeroPA0P2Z9tzlgiQZwiXAvefeE0dH4BOEKZN815vWV6QRY1eMAj7qnpEgsnK2EhZmqda+E7bPwrVCg62DTrmYD+Bozu/bjiKVsL5jKrX5Zv+/qE0uh4MchjMqUG25ha0xiWHvbSJWYFYw5yLbCQDCGHPwZ2Ai+q5TApYiUqs8UFsCDrPDINDpSBwFg/WEuuRkHLgzdehGM+5l70RmRKNZAqrHkxeqZQq5GkD7iZN9KoYKe+YFEyaDqbjj2MnZ2rI9q7DWala18edMFJCYpbXhXs+ZcVlv2R6s1EvzNlhAFs6Oe6VRYaR2BdDdhu4WlhRuZh9n5Z+vjxnjDLBKaAdECF9IkIOjLZJ0PQXjI90Vn4cy8U7G8f0WKX5bkuapfhhoDmwK0ETqFVRXuSWcVNQLxbrKYxZSGYzzYXpSkBYLGLpBCUQdTCmRB/3H31t0FA9+QQtTFZrGedT2fLCa3j8ZlaOPpR471aIeY76Ca+Ykd9zCNsFRGiimh7cvmN5L36NiKLz/Hl66WUKAH++4DgaxmK0YpKtR9h+LsKK7hY/N3qGLT/5x1Hc/6UoSM3zKU1z/AxxPExJHzJ0U5eDdthyTTBpSojTyPDtrmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pE7WMNHlcgFXJgcCP2PuFGY0KwchPWNSK2IuIUzi9LLUcjm/GSSJXa31Rpq8Y4zHZrOfkGj5rMZ0v+0eFZj3n0vdmjcqGwj6RklzwHnsvqFNg1G+zeyqMAWWSc0NOMBOzClWhkHhKtnBR6a6K6h0Uk/RTDRbxnb82y/hC0N2oNrhW1Kgtuso05wEJSMx4BzYnNB8Qk34yw3TnM+qZcOedQ6v191s05AyX5TxO0CFR2FPnmd9C7clijCtC9tmT6rhqAflosXwLkF+KKJPfBOSIOMOvAlhm9unCRfkdVbKY2sOLQhjuCqWR7Y+hAML0PUL43nlBwvmvMPAuq9dX9zr3mtreNH5tkJyap+X07alLFJWvj2cQFVm0zR/wweBGD1L5mAbdzOi1acbtLg5D6bqQjabaktxIjbEPPto9dmLEsIV6jC7VuP+gtQfZtI24RK4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 03:44:49.1796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b54341-109a-46bd-255a-08dee6113fd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7116
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

Allow early FB reads to fall back to BAR0 when the VRAM aperture is not ready.
This lets SR-IOV VFs consume host-provided init data before requesting full GPU access.

For ASICs that support request_init_data,
defer full GPU access until after non-GPU early init to shorten the full-access window.

Legacy ASICs(before NV12) do not send request_init_data;
the host dumps init data only during full GPU access,
so keep the original early full-access request path for them.

Signed-off-by: chong li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 86 ++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  7 +-
 2 files changed, 86 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5442a1fc1c37..2e7aed5a93d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -743,6 +743,62 @@ void amdgpu_device_mm_access(struct amdgpu_device *adev, loff_t pos,
 	drm_dev_exit(idx);
 }
 
+/*
+ * During early SR-IOV VF init, host-provided init data can live in FB before
+ * the normal VRAM aperture mapping is ready.  Use a temporary BAR0 mapping for
+ * reads only, and verify it matches the VRAM aperture when aperture information
+ * is already available.
+ */
+static int amdgpu_device_read_fb_via_bar0(struct amdgpu_device *adev,
+					  u64 offset, void *buf, size_t size)
+{
+	resource_size_t aper_base, aper_size, bar_start, bar_size, map_base;
+	void __iomem *vram;
+	size_t map_offset, map_size;
+	unsigned long flags;
+	u64 end;
+
+	if (!buf || !size)
+		return -EINVAL;
+
+	flags = pci_resource_flags(adev->pdev, 0);
+	if ((flags & IORESOURCE_UNSET) || !(flags & IORESOURCE_MEM))
+		return -EINVAL;
+
+	bar_start = pci_resource_start(adev->pdev, 0);
+	bar_size = pci_resource_len(adev->pdev, 0);
+	if (!bar_size)
+		return -ENODEV;
+
+	aper_base = adev->gmc.aper_base;
+	aper_size = adev->gmc.visible_vram_size ? adev->gmc.visible_vram_size :
+						  adev->gmc.aper_size;
+
+	if (aper_base || aper_size) {
+		if (aper_base != bar_start || aper_size > bar_size)
+			return -EINVAL;
+	} else {
+		aper_base = bar_start;
+		aper_size = bar_size;
+	}
+
+	if (check_add_overflow(offset, size, &end) || end > aper_size)
+		return -EINVAL;
+
+	map_offset = offset_in_page(offset);
+	map_base = aper_base + (offset & PAGE_MASK);
+	map_size = PAGE_ALIGN(map_offset + size);
+
+	vram = ioremap_wc(map_base, map_size);
+	if (!vram)
+		return -ENOMEM;
+
+	memcpy_fromio(buf, (u8 __iomem *)vram + map_offset, size);
+	iounmap(vram);
+
+	return 0;
+}
+
 /**
  * amdgpu_device_aper_access - access vram by vram aperture
  *
@@ -762,8 +818,12 @@ size_t amdgpu_device_aper_access(struct amdgpu_device *adev, loff_t pos,
 	size_t count = 0;
 	uint64_t last;
 
-	if (!adev->mman.aper_base_kaddr)
+	if (!adev->mman.aper_base_kaddr) {
+		/* Writes still require the regular aperture/MM path. */
+		if (!write && !amdgpu_device_read_fb_via_bar0(adev, pos, buf, size))
+			return size;
 		return 0;
+	}
 
 	last = min(pos + size, adev->gmc.visible_vram_size);
 	if (last > pos) {
@@ -1946,16 +2006,25 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ip_block *ip_block;
 	struct pci_dev *parent;
-	bool total, skip_bios;
+	bool total, skip_bios, early_full_gpu_access = false;
 	uint32_t bios_flags;
 	int i, r;
 
 	amdgpu_device_enable_virtual_display(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
-		r = amdgpu_virt_request_full_gpu(adev, true);
-		if (r)
-			return r;
+		/*
+		 * Legacy hosts do not provide init data before early init, so
+		 * keep the original early full GPU access request for them.  Newer
+		 * hosts publish the init data through VF FB, which lets us defer
+		 * full GPU access until after non-GPU early init work is done.
+		 */
+		early_full_gpu_access = (adev->virt.req_init_data_ver == 0);
+		if (early_full_gpu_access) {
+			r = amdgpu_virt_request_full_gpu(adev, true);
+			if (r)
+				return r;
+		}
 
 		r = amdgpu_virt_init_critical_region(adev);
 		if (r)
@@ -2118,6 +2187,13 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	if (!total)
 		return -ENODEV;
 
+	/* Request full GPU access only for the remaining SR-IOV init work. */
+	if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
+		r = amdgpu_virt_request_full_gpu(adev, true);
+		if (r)
+			return r;
+	}
+
 	if (adev->gmc.xgmi.supported)
 		amdgpu_xgmi_early_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 9a40107a0869..fec08f235b92 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -185,8 +185,11 @@ static int xgpu_ai_send_access_requests(struct amdgpu_device *adev,
 	} else if (req == IDH_REQ_GPU_INIT_DATA){
 		/* Dummy REQ_GPU_INIT_DATA handling */
 		r = xgpu_ai_poll_msg(adev, IDH_REQ_GPU_INIT_DATA_READY);
-		/* version set to 0 since dummy */
-		adev->virt.req_init_data_ver = 0;	
+		/*
+		 * AI uses the GPU_CRIT_REGION_V1 layout in practice, so fix the
+		 * dummy version value to match the actual init-data format.
+		 */
+		adev->virt.req_init_data_ver = GPU_CRIT_REGION_V1;
 	}
 
 	return 0;
-- 
2.48.1

