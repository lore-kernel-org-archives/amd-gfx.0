Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8872C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B240B64E20
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B240B64E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 208A36EB39;
	Wed, 24 Feb 2021 22:20:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA2976EB21
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kH6N1zr55XoY0kQSrMQNkxCpprIlhnlHy6YfZQyjj/SE0sDW0ahJBTCZcdhpoKXzn2xG4aOyRNXdAocSaQoeHPog6LcsA/w/pXrVPyjEPmQfu8Nv6K/Kw5jUQWdXKGZlKI4eZVNADqV4xAygmnDPkU474s4kJa4EBDKMwVg28HbB3Iqn6HnQp6dB/uMlQSvUiYwEQZCe4QuDzhpAwOMZh5USyBtDoJiX8Svlk6D2SsD/Lm9O7JvVt1Xi3HxwK0ZCLaezNd8SYvHbJv9dKotARrL9WvIlabm1IVr0PZNTGCjHOwosCV6owitQH5sbcJys9VJ2+akD2F8SNnGFJFQolA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgR+HKWZUeSeGJ3SPz6r+LU8it7rrn08R1nTcuWUfD8=;
 b=BWjCIPIGplL2sXXcCBL3YWGQPU9t68egQc5Nlwk2BbmqZ8RUF8SCbR5hfflrJ27yImrGTxyaJfgWVO3HwgL/KYVYU/+cLSyGkeBv4fVAOKx64drDGZMynYH5QN7KAmglCtKNu+z6C5UnwephBWYfAq34kJNcMUI0n0GDExc/eJ9KZzye+uA4MtSjjlvMmhWvsf0224A43f7IfLR/+A54f3jNQj59GvTbhsSIpxLiThTHb89idOZqDbmnx3+KfPRZJ7OCz4bnwOf1BD+1u9UCEWPq0Nf51vE9TH5rWUQO3vQzpam8ecWZ25qOyumfCY7jZeHzaTR4UWE67KI75c5+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgR+HKWZUeSeGJ3SPz6r+LU8it7rrn08R1nTcuWUfD8=;
 b=eQ/uZD2d/oC1xLrZ7ATUSB0FMtcx8KN67Tq5xpx/rXKzD4G2mjquI/qftLIROZ0e5Qbd+vpjG3vuAgLpbRcyOegJqdThVx288Vky0VGJ+ceBwe6/Ng/TmwvNX/gt/ttoWiMXchFBm6yJsAU5rI64gLRKJJ2xYH7CvPq3NmFNz2U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Wed, 24 Feb
 2021 22:20:17 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:17 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 040/159] drm/amdgpu: define address map for host xgmi link (v3)
Date: Wed, 24 Feb 2021 17:17:00 -0500
Message-Id: <20210224221859.3068810-33-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c1fdccf-e118-4cf6-e8b4-08d8d9124bb6
X-MS-TrafficTypeDiagnostic: BL0PR12MB4865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB48657C464D26A310FE446172F79F9@BL0PR12MB4865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gAOw2R/WDfX0VRMNk7IloV0Z/mFmapIb51zm/vwbgmzORpPhjY1Na6rDqJZWuH2UmHfe6So2NN1bgeloi8hwriKMtIgZqdI2NuQb2/c330qKsE6+ZzDlTNhWcvHyViUoNE+CNNIa8JK7xLoIQ6st1LqO3+UFR/04vRno8zaZbU683GmzwcZoZgGY7tBDx0jBbRYxJJsB+anitCAsDoDiCjuH74AMWhGroRz2PrdMF5SdvpgXUWdDXIED7IOOK+J5YYJ/49btkBOGfdbN6Fv1q35E+uYAvFfLvxlReBvWaJA+mypNocIWvBzpnADCHY/m8atqPSBv9JOp8lUoR8I9kb1HhQYINM0V36IIFmtL5vFlfN9dwfLwt9nokmwKfxQsD4cZ1qOl0Qf5nsmfUqYhLj4LJ2EZzdok53QUeLaxCFCzV/a6xWbT93gACVaoeArgbqC6PYDFrB+Jm0wvslNnUHftqmZ5AxdN8A8iCyj6Uvl9MLpUXpFHAVpyEnX0whhVNL7XGpyhW8pJ7Un59Zx+N872QwOtp//3xpNGmQ9q9wlDxocpwLPvhE8e7080Iwu88PcQNRnxO0T9A+kbJqaJfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(6506007)(478600001)(316002)(66476007)(66556008)(86362001)(2616005)(5660300002)(6916009)(8676002)(956004)(36756003)(1076003)(2906002)(6486002)(6512007)(26005)(4326008)(52116002)(186003)(66946007)(69590400012)(54906003)(8936002)(16526019)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0+uCB96YGCSTSj0HOpQr3td0lk2V3RX75+8o+SC5OSBXutw5FruC194Hx0O/?=
 =?us-ascii?Q?oMiemRkXN+vWi0tMu7A2tsSy3A769uGwG/xa54ysjx6rpXZSAj1ruG9KV8ml?=
 =?us-ascii?Q?3YM22NQcpdAQnqp3oJyL9vyDzbsifpOfYThHN5EIyjWu4Go52cWl7r3cX+Oc?=
 =?us-ascii?Q?B3efJceM4TNNsSdQbSQXrEd6KxMVcJpW9a0wlFUeXgViooiCqeEzHjzSXrL+?=
 =?us-ascii?Q?gmvvbE6skC7oYqzU9ijdDkHiMBTu8afB3Jsfbn9CnK5pJvxpU2u634Vb4go8?=
 =?us-ascii?Q?6zStnwDs/Kkr4VUF1JH1tUNLI/bdZ49+oJq/RbOQJfvxlaTSliX0bDWSVGMB?=
 =?us-ascii?Q?cbP1NBdp8E0l49WA0HzPcVuXiGe5DknVaJ8jUVzpygXwy9e+2Ki8BZLnlFdV?=
 =?us-ascii?Q?PiW/aNxfPZ8u16lpk/EsdchgC/3ZIBQ04bsACNWWMBpYXPHAFYNYi3nAP24C?=
 =?us-ascii?Q?xyACHaGPNUuldhvQsqTIieCeiH6wF1y2G3ZVr12HE2C4oClBgHua0IsbTLk1?=
 =?us-ascii?Q?sYvVJVlPFuh0tB6WR1p3LaGq/lx6PgAWDuG8qymgzoeD+9UXWpX6SAiXsgqD?=
 =?us-ascii?Q?SX+xCCZgFF4v8QdJjfp7nFAH73mpRlQ83y9xCG6yzJsJZ113u2fIlsgBa7l8?=
 =?us-ascii?Q?ALBnpy9d1yEGz/ZE69Im08WJWS0JwqQD3p0iwZqw5aBAnvfNS3ubNZoGH35x?=
 =?us-ascii?Q?47q3CaxFl8O4dpdDg72ReS3a7x4/QvGIblpXF+qZZMArFD94f/jpYuXVwH0x?=
 =?us-ascii?Q?DLsmbQBdKRYjEzJe+E1U7KwAZT1M26DY190/Kxbv8E8ykYb07u8hdaJzy5xl?=
 =?us-ascii?Q?M2MyhL5bM85SM/i47S+oj0k/WdZFl+5FBl5PpgXkB/DtQov2qKXOig0SyiOn?=
 =?us-ascii?Q?1RHXxmNsaBHb9OlPKipXS0kVXKMZUkGqzcRNbpNUe8sd8cyKG3BDsjrp2778?=
 =?us-ascii?Q?IZqQvij9Kc0Nehp9FM4w55/OwiZAvrZorYAYNflCVxsm/1nWwdyhJPb9rZCe?=
 =?us-ascii?Q?W7qdmbAXML8P3UfHThCfrCWl09i3ZFQZ8LGT/DC4mEQtMrpYUhIdgqLFKtCg?=
 =?us-ascii?Q?S3St5MPfXlaFf+GSaEXr6ik+45TPJkaAyEQeIFpMcwXDOz5ef5ga224lTutD?=
 =?us-ascii?Q?44m/V/XH8UHVneJr+S4jRefIuW1sREM3J9sK+vi35UpAnkeJoYN1iP9JT5N3?=
 =?us-ascii?Q?bN6PrazO5cdVFi+86EDpej/2Haxp6a9Z7p/9wYAim74ILoSI6iqB9VMmSb+l?=
 =?us-ascii?Q?JDqM+Q5HtS5i8UcImpz0JKfDkHdKWxN76elcdrlK/7PUHEtjOFbX1N0k4MPc?=
 =?us-ascii?Q?u0bSmLvLomFulPb8Chk/VIrZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1fdccf-e118-4cf6-e8b4-08d8d9124bb6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:47.7923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzYDQ7SAW7YVpIYc/UNIC912zOqx+5L+mHoD1CRlSpJFnJQKd3lpMfv/z3G4u8mCgdlnKuPFDlE8n6DB2bhv8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Oak Zeng <oak.zeng@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

This applies to AMD Accelerated Processing Platforms that support host
gpu interconnect throguh a special link (xgmi). Aldebaran systems will
support this special feature for utilizing the benefits of host-gpu
cache coherence. This change outlines the basic framework for mapping
the GPU VRAM (HBM) to system address space making it accesible to the
host but managed by the amdgpu driver since this region is marked as
reserved memory in host address space by the underlying system firmware.

v2: switch to smuio callback function to check the type
of host-gpu interface (Hawking)
v3: use hub callbacks rather than direct function calls (Alex)

Reviewed-by: Oak Zeng <oak.zeng@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 34 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc15.c      |  5 ----
 3 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index aa0c83776ce0..11c6977c0b35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -149,6 +149,7 @@ struct amdgpu_xgmi {
 	struct list_head head;
 	bool supported;
 	struct ras_common_if *ras_if;
+	bool connected_to_cpu;
 };
 
 struct amdgpu_gmc {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index ff4a2e0a1ad6..1f8732beedd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1146,6 +1146,16 @@ static int gmc_v9_0_early_init(void *handle)
 	gmc_v9_0_set_mmhub_funcs(adev);
 	gmc_v9_0_set_gfxhub_funcs(adev);
 
+	if (adev->asic_type == CHIP_VEGA20 ||
+	    adev->asic_type == CHIP_ARCTURUS)
+		adev->gmc.xgmi.supported = true;
+
+	if (adev->asic_type == CHIP_ALDEBARAN) {
+		adev->gmc.xgmi.supported = true;
+		adev->gmc.xgmi.connected_to_cpu =
+			adev->smuio.funcs->is_host_gpu_xgmi_supported(adev);
+        }
+
 	adev->gmc.shared_aperture_start = 0x2000000000000000ULL;
 	adev->gmc.shared_aperture_end =
 		adev->gmc.shared_aperture_start + (4ULL << 30) - 1;
@@ -1234,10 +1244,34 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
 
 #ifdef CONFIG_X86_64
+	/*
+	 * AMD Accelerated Processing Platform (APP) supporting GPU-HOST xgmi
+	 * interface can use VRAM through here as it appears system reserved
+	 * memory in host address space.
+	 *
+	 * For APUs, VRAM is just the stolen system memory and can be accessed
+	 * directly.
+	 *
+	 * Otherwise, use the legacy Host Data Path (HDP) through PCIe BAR.
+	 */
+
+	/* check whether both host-gpu and gpu-gpu xgmi links exist */
+	if (adev->gmc.xgmi.supported && adev->gmc.xgmi.connected_to_cpu &&
+	    adev->asic_type == CHIP_ALDEBARAN) {
+
+		adev->gmc.aper_base = adev->gfxhub.funcs->get_mc_fb_offset(adev) +
+			adev->gmc.xgmi.node_id *
+			adev->gmc.xgmi.node_segment_size;
+
+		adev->gmc.aper_size = adev->gmc.real_vram_size;
+
+	}
+
 	if (adev->flags & AMD_IS_APU) {
 		adev->gmc.aper_base = adev->gfxhub.funcs->get_mc_fb_offset(adev);
 		adev->gmc.aper_size = adev->gmc.real_vram_size;
 	}
+
 #endif
 	/* In case the PCI BAR is larger than the actual amount of vram */
 	adev->gmc.visible_vram_size = adev->gmc.aper_size;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 857fba284e78..486839c3052a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -687,11 +687,6 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 	if (!amdgpu_sriov_vf(adev))
 		soc15_reg_base_init(adev);
 
-	if (adev->asic_type == CHIP_VEGA20 ||
-	    adev->asic_type == CHIP_ARCTURUS ||
-	    adev->asic_type == CHIP_ALDEBARAN)
-		adev->gmc.xgmi.supported = true;
-
 	if (adev->flags & AMD_IS_APU) {
 		adev->nbio.funcs = &nbio_v7_0_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v7_0_hdp_flush_reg;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
