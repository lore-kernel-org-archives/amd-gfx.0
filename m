Return-Path: <SRS0=r20P=DW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41098C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 12:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9506922251
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 12:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YDJ6CXt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9506922251
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21D786ECC9;
	Thu, 15 Oct 2020 12:54:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 095746ECC9
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2020 12:54:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVPV4oLR9aosS/zNwRTlYRCXZjDkjeV+tRJOzEHRZb5gL7c/VAUtEJ4tw3CMKJHQ1wbDJJcZwbHYyLORDypl1tIDb/x6PX2GtWVAL8JXzdCuUlCAlhDboiwyfRkvZhGC7RvLJtJemJDAJ1NO80HzcjTZ4cvwpYKGtQ0rsKd4rolT28ioL8ENRg9NMaSQhTbZtoXxOTaC4JNhbvQhypcTLdPOh0ViX39cWsxPOqJCNp9NNWaokVbBstnvKPngxAvBISAOMUy33iThL9zoaxHGnP2/kUA0I+TMd0QM4D9x7vLUXTHrX9sgxM5ucn3ucMFdb6t4Gnnu3ViM+uTwNqbpUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRUyuc2c7ogQEA7P3tTJ5ifjpIF/i1VhoX4gtUp2fyA=;
 b=j2NBUuAvxaaxA8N9Hqdqkjv5o3kOHnRfw6LG9CQSsho9jDMy6ZHq7vgySq9SbYFKFYbzI/OiCRC6r78mvtp6ixiW1gfgFiEs2aSVqtQs5EUiBKQ+j6tfANjjmKZaubzsuHgwS2RmAJow9Bm6L3StGMvKwqIJjzgOBz/cG5g5qhZ5MWal20yBf4OCPH0oFhzOqWht5XllZanS7LUy6o91hqQ658gbjPfqFaxfZFcL6DGCH7TWpZ8IZzDqjbfQuXsVQoXfty91k443xyiC2U43OSmKxkRuYDnmXCEnmz7v6vr0kWlJFt9j3WJnULiqT88O2vO6ZS/ySxUOJhYVeDmFqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRUyuc2c7ogQEA7P3tTJ5ifjpIF/i1VhoX4gtUp2fyA=;
 b=YDJ6CXt6rQ4Dy5Wfjst/xAO+ckcaS5KWOb+gogf7Bs5T7CwV9Y4dXv6Bzo0xRFYOsa7Gn7N8IHZ7Q/IDqlrmPTPrwZK1WX0DETF2soXYR94QWQzsl7INnBwItRQC8QslVBx3buQ2kYLGg3UaDJYO2MZiIODhtlWgNS8Eas1RTzk=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3083.namprd12.prod.outlook.com (2603:10b6:5:11d::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.25; Thu, 15 Oct 2020 12:54:53 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3477.021; Thu, 15 Oct 2020
 12:54:53 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove gfxhub_v1_1_funcs set
Thread-Topic: [PATCH] drm/amdgpu: remove gfxhub_v1_1_funcs set
Thread-Index: AQHWoqLXPKTB028t30O/L0rX4XV5JKmYn0kQ
Date: Thu, 15 Oct 2020 12:54:53 +0000
Message-ID: <DM6PR12MB407506AF660F30BD9D4139B2FC020@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201015032509.28605-1-kevin1.wang@amd.com>
In-Reply-To: <20201015032509.28605-1-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-15T12:54:47Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=deab3ce2-0d91-4dec-9aba-0000dd8390d1;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-15T12:54:41Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 4acb50f7-f325-4a10-a695-00005e6ed754
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-15T12:54:50Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 6116a058-061f-4421-97bf-00009539c818
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a2b3c67c-0f3e-4692-309e-08d87109829a
x-ms-traffictypediagnostic: DM6PR12MB3083:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB308337A3AE58ECD78E5D9B84FC020@DM6PR12MB3083.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:489;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DudWkF4ZbPwtiu1K7OYXJGu0Bq/MPdt6mqy2icjZfPedmxEMDYE5wJ7te+MNEuTqeDhOWUferBv+BWect2P8JoG7woxuPCBtuetGYVvwuHO9zvNfkbXQEutaK4lRyi5uechBVoh5xlXEy6vBeXTra3a3yJ0A422eS7f9SZhXXiN5UT5+kQTQ6Tdyt6hqjC+WZh3O3Yb5ghw0Td9MbkEmNQMZXbjDsOOLvu1QmSCgV0+qJqpW3MmHwu3ALkmtBoKfJ1Vpenf9WD32RtOAe8RrUXosFWUzHoO8wF3EDHnnrm+eZIncuIHdQ8yrrLFaGWub2xhQ0ONgwQCE2v7LVE5mog==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(186003)(5660300002)(26005)(9686003)(2906002)(53546011)(33656002)(6506007)(55016002)(8676002)(76116006)(478600001)(86362001)(110136005)(83380400001)(64756008)(66476007)(7696005)(71200400001)(316002)(66556008)(66446008)(52536014)(66946007)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: t0HZ43EV6dkK3pPD8N7Kvw2xGelpXAyX+zFr1GtLHAVtcxzYNHykv5bKMWJpzMmDCUu6jKq2fjWiOYB2jruFY5qlAfYB/uB9Yipy0kJSo7M+g4Sj+oWwBkh1mFR8lDHFRpGPhZQc2H4V5RVxue3MIu0NIPaIZ9eRif9nCik1+gOVG+59dczSJKotneOQDlt5KAOFNEBsxYPrsat0k0+XZ4Yb2RRdq2E6aSaFd9yuzD5gVyeV4aDM+wGCcSmbdJHpmekfc9vjRjhWPYmX+YFzv9E3LupHusXNiyQfuLY6uRnLz3VMAQtPCxJoHGexmU1mx5tOugm8dd3dtsDMy+g+vrIO2PU3BqQpd3eRSO23egvuymatoYesX4WneuGYtAEAUmC+RcgZ+uYh+V8odVjFqOmkoq5aTrvMZ8nAwXMRyVnYB4+08JdpFXpSdf5NjBM96RYFdEnYMTKL7Velj8MoVSJFM6q2kQDV5ChME9aQf/tGoyR2YcyWbybiysDPVO26WWxukTjLkJaQ5eGJAMzEUxVNbrGYdF3ogNCPkJz8CzgtTJUC8yTl1UHdAclrsZcc7q0MYB0PPeTLggKtHL5t0Pm/WJatC/Ldtqna+msb6kNJZzsBUOyyEQ15ir/abS0b0XjDxbMBYloCtUHfQCGm6w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b3c67c-0f3e-4692-309e-08d87109829a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 12:54:53.0671 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tYa0/rLQgO3ApuZ0Yktb/n70HeH7nEhbMwkOs7S1GHAJ6AvJHJx/szdgYXkLTMhbTO/QFPsbP8PmGAmEFthwrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3083
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com> 
Sent: Thursday, October 15, 2020 11:25
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: remove gfxhub_v1_1_funcs set

remove duplicate gfxhub v1.1 function set.
put function of gfxhub_v1_1_get_xgmi_info to gfxhub v1_0 function set.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c |  2 ++  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c | 13 +------------  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 10 +---------
 4 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index fad887a66886..d83577b77a66 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -22,6 +22,7 @@
  */
 #include "amdgpu.h"
 #include "gfxhub_v1_0.h"
+#include "gfxhub_v1_1.h"
 
 #include "gc/gc_9_0_offset.h"
 #include "gc/gc_9_0_sh_mask.h"
@@ -412,4 +413,5 @@ const struct amdgpu_gfxhub_funcs gfxhub_v1_0_funcs = {
 	.gart_disable = gfxhub_v1_0_gart_disable,
 	.set_fault_enable_default = gfxhub_v1_0_set_fault_enable_default,
 	.init = gfxhub_v1_0_init,
+	.get_xgmi_info = gfxhub_v1_1_get_xgmi_info,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c
index 1e24b6d51e41..c0ab71df0d90 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "gfxhub_v1_0.h"
 #include "gfxhub_v1_1.h"
 
 #include "gc/gc_9_2_1_offset.h"
@@ -29,7 +28,7 @@
 
 #include "soc15_common.h"
 
-static int gfxhub_v1_1_get_xgmi_info(struct amdgpu_device *adev)
+int gfxhub_v1_1_get_xgmi_info(struct amdgpu_device *adev)
 {
 	u32 xgmi_lfb_cntl = RREG32_SOC15(GC, 0, mmMC_VM_XGMI_LFB_CNTL);
 	u32 max_region =
@@ -67,13 +66,3 @@ static int gfxhub_v1_1_get_xgmi_info(struct amdgpu_device *adev)
 
 	return 0;
 }
-
-const struct amdgpu_gfxhub_funcs gfxhub_v1_1_funcs = {
-	.get_mc_fb_offset = gfxhub_v1_0_get_mc_fb_offset,
-	.setup_vm_pt_regs = gfxhub_v1_0_setup_vm_pt_regs,
-	.gart_enable = gfxhub_v1_0_gart_enable,
-	.gart_disable = gfxhub_v1_0_gart_disable,
-	.set_fault_enable_default = gfxhub_v1_0_set_fault_enable_default,
-	.init = gfxhub_v1_0_init,
-	.get_xgmi_info = gfxhub_v1_1_get_xgmi_info,
-};
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.h b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.h
index ae5759ffbee3..d753cf28a0a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.h
@@ -24,6 +24,6 @@
 #ifndef __GFXHUB_V1_1_H__
 #define __GFXHUB_V1_1_H__
 
-extern const struct amdgpu_gfxhub_funcs gfxhub_v1_1_funcs;
+int gfxhub_v1_1_get_xgmi_info(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 6e9de02d5455..33c34cae9f42 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1166,15 +1166,7 @@ static void gmc_v9_0_set_mmhub_funcs(struct amdgpu_device *adev)
 
 static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev)  {
-	switch (adev->asic_type) {
-	case CHIP_ARCTURUS:
-	case CHIP_VEGA20:
-		adev->gfxhub.funcs = &gfxhub_v1_1_funcs;
-		break;
-	default:
-		adev->gfxhub.funcs = &gfxhub_v1_0_funcs;
-		break;
-	}
+	adev->gfxhub.funcs = &gfxhub_v1_0_funcs;
 }
 
 static int gmc_v9_0_early_init(void *handle)
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
