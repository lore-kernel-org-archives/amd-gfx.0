Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA535CA1012
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 20:36:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9026B10E934;
	Wed,  3 Sep 2025 20:36:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jj9BQ+Y+";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C59010E934
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 20:36:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDgPmI5DjL9jxsx8BBP7MPomc372ZF2pd6Xa5p5lpDoVFK7c0YcjM/vBNVZcTYdWFM3KfoGctJxnN4SYytIDQFAJmUWt2TX1o2gqVS+ca4A+BmQUr9T5qqOL06iWfRGTCSi2JW7qh7+ztuuL/RFam+151MxagVGZi3bQpja1trf9nIzCXw3M2i49N7VPpHjeqniboBMVMuhZcNLT+WczUwtfniJxsMv6hN/kCUSlW0EtbAI/40Vfrh+/WWrsHN0UKt1ckajEUW3ps6/Q2aEA4dtKG59t5b4pvIHGnkQDlFpYYIBVH61eoSdOLR55vCxebQPPrY/0pZV4cvGlsWj4hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6B7Vpo0t/LO5wzEw6qPoRr34PhyyCNZ6c5Bhz9l731c=;
 b=tPc5AhxbuyvQz59vwfk44Hh7u6fGe0AeJx50WiE4tXeNM/JqjZXtacaXo3V6TFQz6k4J1n+uKlDrQG6npN4wITIfNxg4C37JdGB5g09IBajGuZNoETt7NhNzkfI8h6qkU36uzjT7TARMux5gltmwiYGKhDjTpeg81dz2EThg9p5CfUOExUeHjeO5Sawca2uc5KnrWlo4o1OC3Ys+szJHSq1GdE0++DErAkGppPmZO2tv5kbRbemkjfaivzfslH/5HJsIHBzpJkNwBS2M1ZEk/xgQ2yji2OE3JmXpYVAp0l/3ulVVSf8LDyyK+c6bKvbP949io13tQhFa0IH4G8UY7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6B7Vpo0t/LO5wzEw6qPoRr34PhyyCNZ6c5Bhz9l731c=;
 b=Jj9BQ+Y+FsGN/7p7F43ez+tJDzdmn5HnC0Gk5wrlJ8v3u+N8qD1ND4LFFRsJ8+rG3YgwvurbKslkjqyyFeg6lQAiuclLNdQ81LpbUdCb2ohONReA3uI/NKTPhHUQta9p/DJUMN6cpd498qX3MqqxVz+sfv/okXR7hAF+F3nNGMI=
Received: from SJ0PR13CA0090.namprd13.prod.outlook.com (2603:10b6:a03:2c4::35)
 by DS0PR12MB6605.namprd12.prod.outlook.com (2603:10b6:8:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 20:36:33 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::e9) by SJ0PR13CA0090.outlook.office365.com
 (2603:10b6:a03:2c4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.6 via Frontend Transport; Wed, 3
 Sep 2025 20:36:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 20:36:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 15:36:32 -0500
Received: from maple-stxh-linux-10.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Wed, 3 Sep 2025 13:36:31 -0700
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <mlimonci@amd.com>
CC: <benjamin.chan@amd.com>, <bin.du@amd.com>, <gjorgji.rosikopulos@amd.com>, 
 <king.li@amd.com>, <dantony@amd.com>, <phil.jawich@amd.com>,
 <xglooom@gmail.com>, Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH v2 1/2] drm/amd/amdgpu: Move isp firmware load into isp_v4_1_x
 modules
Date: Wed, 3 Sep 2025 16:35:43 -0400
Message-ID: <20250903203601.839525-2-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903203601.839525-1-pratap.nirujogi@amd.com>
References: <20250903203601.839525-1-pratap.nirujogi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|DS0PR12MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 703227b6-332c-46a9-3f2c-08ddeb299219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2Se8GF3pGR18KXI3Da3xdE8qpDMcWoI1TNQxKJmArK5fB018ZcVsaEdjqlM3?=
 =?us-ascii?Q?hl3jJYqXJ4xSPsJnb70Vvv2xBcdphnC8fYhXay5vNTM2t/SJQpjB8vJ2KOUj?=
 =?us-ascii?Q?lXStDn52V6IBSyxOt1CzsKkSUKMa9U3wd4opIsuGgJz1sayBhg/i/6A/+lr9?=
 =?us-ascii?Q?W/kqzt7f/jeKMLkgaA0o2l3ZyLW3n8Hjew4axojTmNmuJXMtifeswO5I1J4Y?=
 =?us-ascii?Q?Gaz6InmsWO+oh17v8QotLTj6luXg/VkfVTeJIb9Yz0qrFH2JLZ502l0WKiYS?=
 =?us-ascii?Q?t7h1xYRyNGut8G7TDGUl0MIQ9TlWCTl4ByG5PNSRDCctyC6xaGptj8q804oC?=
 =?us-ascii?Q?VKL7Qb1ZA8koYB68/5XLyKB4YAoiYn8smOxuYRhQQock2HKHxk+VAnX/BwA1?=
 =?us-ascii?Q?IT6qxmGqWM1dJ2XuS2q9Jqwc/+CS76iqH16gYUxgjXAh8ckFjKajFuSNLIlq?=
 =?us-ascii?Q?v2zNEBsckgaY/+zE8tNIPjZM1c/tlbO+aoPmHjoJSSc/Cnl06Hha2U0k0gkt?=
 =?us-ascii?Q?HfqYdqBtc7LHpmtHVZtE/8IC9p6bov5sRO+Q/e9tFFvFSWiFByzpJzivcVe0?=
 =?us-ascii?Q?2s9Muq5sadtwF5Sn/q3Xgl8QY4sHH4fTV02DV6nSM8rp0gS5QHRtmsLcR7na?=
 =?us-ascii?Q?3s2k1QC90+geE7CHxxDwgPE1eJLYI1kTfPNcfsSnL2hL2T4Vox+s4mcS5NEx?=
 =?us-ascii?Q?hnubFjFLuoHDBQjLpxWcHBunOz645vcF5q5dDauGDLtdOvSEDfihb/D+cU1C?=
 =?us-ascii?Q?p0FEnSmOg5Yx+Lwz747Mj3C9BasRlZu/WYqhJIzLlU+vaklGI4q/GINT4n5f?=
 =?us-ascii?Q?zrGoWHmF3G9+M+hdff+ZCsupxGYTZEQVc9k5GwV7MzE82Zm68JuHVd5F+cen?=
 =?us-ascii?Q?FxVMsqqCHXIwRWp3EJ3CngMYB/XqLlJQqel81NTe1P8PdpAe3DZ6oHpa93yT?=
 =?us-ascii?Q?74MplA4kCbZw6RaN7Yyptr/6xrOwxS0Yjgl3INJ/GFDoVSRJ1Ka0RKZr6dDE?=
 =?us-ascii?Q?ZzTCddy9YjcyTzqpAcJANa7rmtwMuLqm1ee0nhcDVQWJhphs7ZEHZbGfA0xs?=
 =?us-ascii?Q?MXHrfBY7gYl1R7aSnEs4y3YH/DD4vyp+aFBXQZyBnG34iXVTYO5TktLdsZ3P?=
 =?us-ascii?Q?8k7nqGwcQ8KjkTSI0EtPtqT+AhcSZeV2M3Jl1R8mh4FrGxC3kEN45IFAnSqo?=
 =?us-ascii?Q?kjfskTrvKLvqJFCdGR2EDcN61VP/RwwusuTcGlYKhnjjSB/j4E24lv8gVK7N?=
 =?us-ascii?Q?TbPLMprtLAnnJhiA9LD1FWyHcIx5GWsXIP1fPCHGS35CzEYd+wNZh9qKvYbV?=
 =?us-ascii?Q?JZioX7/z75Z54ANDO5Kjt2mFuaP5/IjXeDNfYC8nmyIpjlApVvEzoX6irCDZ?=
 =?us-ascii?Q?te9u8IzQ+F1J3CdM5adrLcc/s5GXmX6jr/FRWWGT6F8PaXbsFweAx1mJpEzo?=
 =?us-ascii?Q?yZduQzbatKqcUT2RWPfPFQ8rf2dj+f4t8Kq3xjvzFlURq79vujBULPMkDCfU?=
 =?us-ascii?Q?/wPlJ/3Z0ODWEfB81uU1DhnMJOYuE8chleG4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:36:33.2036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 703227b6-332c-46a9-3f2c-08ddeb299219
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6605
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

Move isp firmware load from generic amdgpu_isp driver to isp
version specific driver modules isp_v4_1_0 and isp_v4_1_1.

Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 22 +++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c | 12 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 12 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h |  2 +-
 6 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index 9cddbf50442a..90af35ee8f6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -68,7 +68,7 @@ static int isp_hw_fini(struct amdgpu_ip_block *ip_block)
 	return -ENODEV;
 }
 
-static int isp_load_fw_by_psp(struct amdgpu_device *adev)
+int isp_load_fw_by_psp(struct amdgpu_device *adev)
 {
 	const struct common_firmware_header *hdr;
 	char ucode_prefix[10];
@@ -80,7 +80,7 @@ static int isp_load_fw_by_psp(struct amdgpu_device *adev)
 
 	/* read isp fw */
 	r = amdgpu_ucode_request(adev, &adev->isp.fw, AMDGPU_UCODE_OPTIONAL,
-				"amdgpu/%s.bin", ucode_prefix);
+				 "amdgpu/%s.bin", ucode_prefix);
 	if (r) {
 		amdgpu_ucode_release(&adev->isp.fw);
 		return r;
@@ -103,27 +103,23 @@ static int isp_early_init(struct amdgpu_ip_block *ip_block)
 
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_isp *isp = &adev->isp;
+	int r;
+
+	isp->adev = adev;
+	isp->parent = adev->dev;
 
 	switch (amdgpu_ip_version(adev, ISP_HWIP, 0)) {
 	case IP_VERSION(4, 1, 0):
-		isp_v4_1_0_set_isp_funcs(isp);
+		r = isp_v4_1_0_set_isp_funcs(isp);
 		break;
 	case IP_VERSION(4, 1, 1):
-		isp_v4_1_1_set_isp_funcs(isp);
+		r = isp_v4_1_1_set_isp_funcs(isp);
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	isp->adev = adev;
-	isp->parent = adev->dev;
-
-	if (isp_load_fw_by_psp(adev)) {
-		DRM_DEBUG_DRIVER("%s: isp fw load failed\n", __func__);
-		return -ENOENT;
-	}
-
-	return 0;
+	return r;
 }
 
 static bool isp_is_idle(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
index d6f4ffa4c97c..36750123ed46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
@@ -57,4 +57,6 @@ struct amdgpu_isp {
 extern const struct amdgpu_ip_block_version isp_v4_1_0_ip_block;
 extern const struct amdgpu_ip_block_version isp_v4_1_1_ip_block;
 
+int isp_load_fw_by_psp(struct amdgpu_device *adev);
+
 #endif /* __AMDGPU_ISP_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
index 0027a639c7e6..926947a612a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
@@ -185,7 +185,17 @@ static const struct isp_funcs isp_v4_1_0_funcs = {
 	.hw_fini = isp_v4_1_0_hw_fini,
 };
 
-void isp_v4_1_0_set_isp_funcs(struct amdgpu_isp *isp)
+int isp_v4_1_0_set_isp_funcs(struct amdgpu_isp *isp)
 {
+	struct amdgpu_device *adev = isp->adev;
+
 	isp->funcs = &isp_v4_1_0_funcs;
+
+	/* load isp firmware */
+	if (isp_load_fw_by_psp(adev)) {
+		drm_err(&adev->ddev, "isp fw load failed\n");
+		return -ENOENT;
+	}
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h
index 4d239198edd0..5e43ba064708 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h
@@ -45,6 +45,6 @@
 #define ISP410_GPIO_SENSOR_OFFSET 0x6613C
 #define ISP410_GPIO_SENSOR_SIZE 0x54
 
-void isp_v4_1_0_set_isp_funcs(struct amdgpu_isp *isp);
+int isp_v4_1_0_set_isp_funcs(struct amdgpu_isp *isp);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
index a887df520414..9766c6056dc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
@@ -369,7 +369,17 @@ static const struct isp_funcs isp_v4_1_1_funcs = {
 	.hw_fini = isp_v4_1_1_hw_fini,
 };
 
-void isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp)
+int isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp)
 {
+	struct amdgpu_device *adev = isp->adev;
+
 	isp->funcs = &isp_v4_1_1_funcs;
+
+	/* load isp firmware */
+	if (isp_load_fw_by_psp(adev)) {
+		drm_err(&adev->ddev, "isp fw load failed\n");
+		return -ENOENT;
+	}
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
index fe45d70d87f1..b221d8b81983 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
@@ -44,6 +44,6 @@
 #define ISP411_GPIO_SENSOR_OFFSET 0x6613C
 #define ISP411_GPIO_SENSOR_SIZE 0x54
 
-void isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp);
+int isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp);
 
 #endif
-- 
2.43.0

