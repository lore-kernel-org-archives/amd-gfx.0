Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBE4C433E3
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 03:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F0E2068F
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 03:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XHqyY4w4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F0E2068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D5586E2D7;
	Thu, 23 Jul 2020 03:47:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15D796E2D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 03:47:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQSUPjfRiHtcKTsyraZgJdE7w3ECm752Mhm1eb6hmL69UZDI57v6NqtApef+Saoq+IVpafl553WelDPA6uVjgrTkWflqWPS0fTzLuk7a2U6C8pyXJDpEoDg/mUyg44JgoH8r69/1+aHxenlTARFpvPiSwv64kNvIj/mAL9ii1Fj18ExH2dAocWYj5z8R+Ix+R4NXlwr6QEhKy0trbGIxIaqCQVducA/vmW0h/YbuacXEcBhtq/ha7vx9e3EiBvl2EhpcGwMg6vrk3cbvTZuMXbNaVmZpdCatQNkU8bwApJERKnYqEmMYbwtNzoz++oWdQfLSIh+HSnV5QywvKe6o/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBfCoHmDIJeXoFGTLbqVaeyaD0UNzncL61cYh8YyrCQ=;
 b=AcunAdcKr54qmDrJBpcvhjT0/JgfhHl5QdSDOZ7/tHk6eilZKkaRpJEq3p2DgHGdbFCCj2C5jnW4ah0JlWLmVs4XE2zWY3YWfYnAv9/pYjFUwryV+te9kcl2WNy5Mcb/Wh4u4yrAAEWsWFf1+oZJyTLTHOxaYsuH+R0mlWDcefkPJpYWhPB3X9athslXexmsZMS2j8u1A8qOP56EJJKDCFpyRKpX6UE4UJbe8O8wYF2A+0HnrMkT/Bupgm/22YgxvH0UMF2R2GiHZw2X0JFBGKVcqAE73MKAOaQ38EKNPQMvlN/oe5GPpuIgQF39So1gYwPJzqRrjQwbKchDULwCLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBfCoHmDIJeXoFGTLbqVaeyaD0UNzncL61cYh8YyrCQ=;
 b=XHqyY4w4qk59iwpx7EPTE2ms2qRMvfKEBRg3p3R59OS8NmcR+iIdT9A7T8YuNTSVtkD6JhvT6csx4jSvbGbPYMU76SQLFrZlLCCe5MqHGpP5SvXozgIvuaLLzgpkcQPxoEoLRpT0PcKd5aPb/uOos/j4E0D+K+jgWWGFm2jhAac=
Received: from BN6PR12MB1283.namprd12.prod.outlook.com (2603:10b6:404:19::8)
 by BN6PR12MB1410.namprd12.prod.outlook.com (2603:10b6:404:18::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Thu, 23 Jul
 2020 03:47:17 +0000
Received: from BN6PR12MB1283.namprd12.prod.outlook.com
 ([fe80::48d8:4df2:bfa0:907f]) by BN6PR12MB1283.namprd12.prod.outlook.com
 ([fe80::48d8:4df2:bfa0:907f%8]) with mapi id 15.20.3216.020; Thu, 23 Jul 2020
 03:47:17 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Yang, 
 Stanley" <Stanley.Yang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Clements, 
 John" <John.Clements@amd.com>
Subject: RE: [PATCH 1/5] drm/amdgpu: add bad page count threshold in module
 parameter
Thread-Topic: [PATCH 1/5] drm/amdgpu: add bad page count threshold in module
 parameter
Thread-Index: AQHWX9Y/HmdxhZgxYke/u1yOyXTp7akUUZiAgAA1WBA=
Date: Thu, 23 Jul 2020 03:47:17 +0000
Message-ID: <BN6PR12MB128336C43F529CC62BEB4281F1760@BN6PR12MB1283.namprd12.prod.outlook.com>
References: <20200722031415.4792-1-guchun.chen@amd.com>
 <20200722031415.4792-2-guchun.chen@amd.com>
 <DM5PR12MB25332D58B47ABB52BFBD1A4DED760@DM5PR12MB2533.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB25332D58B47ABB52BFBD1A4DED760@DM5PR12MB2533.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-23T03:42:43Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=d4a12bf2-66fc-41a2-a20d-0000ae4512c5;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-23T03:47:15Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: f895dccd-e8dc-4b3d-ba97-00005a300b8f
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d93448c-aea4-4f64-c564-08d82ebb1893
x-ms-traffictypediagnostic: BN6PR12MB1410:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR12MB1410D5794FC44B90E65D7FA4F1760@BN6PR12MB1410.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FIz4s2wIX3/2WMZU++ZHeyonxxnKX+2AwQWCieObCMxv7PD3Sr0jKTTXsxr81hv3cX+ZVzLfuzKWNO1heXy0374Mz0z++SUk/l+ZDRVFH9Ao1FDGBA9jPlv27QfV2Luy/U+8LT9a2deDI2JtZZZ3y6VSHhY9egl4bTxCBKp6+ewIZ8KYH8dLXRDybcQZyt8R/zogB/YozmY2RYfLxotQezWNCp37Li0S9lQSIlnt6iJgLNmcC0TcYXDDnBHZFGY0oa25pSTLTs+7NsYHRsUyZFqGZ9G7MzmKUEursqR8Ds/pdEMfFC8hawJCt0NRnH2aCJiiRFiQiw2wmdDH6cLeM8RS0OpArHzRhgU6RfPo2gr6ncjvoTHKXycK6YCUXb2E
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1283.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(76116006)(2906002)(8676002)(5660300002)(186003)(71200400001)(6636002)(33656002)(86362001)(110136005)(53546011)(66476007)(6506007)(52536014)(478600001)(316002)(83380400001)(7696005)(66446008)(64756008)(66556008)(9686003)(8936002)(26005)(66946007)(55016002)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: T3LccuFPzLWSS4Z8q6zjSp4ryo4txO31BbfWbOMu+gGJAm5DyKDexRYl57R9A+NZue9EqN+/Ke8YLap5Kg4OXKuUDDPj9P570dw1RK4421eQ8e3x4jg4eHJGoscSM/uNgmRO7rvpotP1zQZ46OZGZlR00xF3MADK2v0jYYGOOTtE+X1qrGRJuM34OJGkxG3lpeK+//W0L6PN75BInIb4iMPN8dpSvR4y8LSCtir1R+35hfGhGGkz7Ce4EX+UxlsyBjhMdvdd2vwTBwYf36qvss5sNDuY7E+L4/MM7Ae1JzwXoTlQWa2sLGrEB3LtJGAuJ3IcW34c6KakuGMx4juM/1rj+hqoeG5Rfp+LKtpUpK6cXafXX8Hl+qjs/3ZH62xxB6jb9T2MZFDIIBZO5jf1YuQh/yT+G9pcx9zShIsgPqQyMvXJwoG4CbPvldiMZP99+kMsIKnrebiBLaJGnFg54B3J9dHzfEzujj0VJWWFw0Shlck1u5soP1T3Gm0pSoB0
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d93448c-aea4-4f64-c564-08d82ebb1893
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 03:47:17.7905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 53aGkfkNeb4J+0jvBq5pMLWEpx6j/4hv6rZ81mA+mWTtp6O513XkrsvFYEH8kj/p1DopEnjWeC1t/mhJcfSEKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1410
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

Hi Dennis,

To be honest, your suggestion is considered when I start the design. My thought is in actual world, bad page threshold is one static configuration, it should be set once when probing.
So module parameter is one ideal choice for this.

Regards,
Guchun

-----Original Message-----
From: Li, Dennis <Dennis.Li@amd.com> 
Sent: Thursday, July 23, 2020 8:32 AM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Subject: RE: [PATCH 1/5] drm/amdgpu: add bad page count threshold in module parameter

[AMD Official Use Only - Internal Distribution Only]

Hi, Guchun,
      It is better to let user be able to change amdgpu_bad_page_threshold with sysfs, so that users no need to reboot system when they want to change their strategy.  

Best Regards
Dennis Li
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Wednesday, July 22, 2020 11:14 AM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: add bad page count threshold in module parameter

bad_page_threshold could be specified to detect and retire bad GPU if faulty bad pages exceed it.

When it's -1, ras will use typical bad page failure value.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 06bfb8658dec..bb83ffb5e26a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -181,6 +181,7 @@ extern uint amdgpu_dm_abm_level;  extern struct amdgpu_mgpu_info mgpu_info;  extern int amdgpu_ras_enable;  extern uint amdgpu_ras_mask;
+extern int amdgpu_bad_page_threshold;
 extern int amdgpu_async_gfx_ring;
 extern int amdgpu_mcbp;
 extern int amdgpu_discovery;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d28b95f721c4..f99671101746 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -161,6 +161,7 @@ struct amdgpu_mgpu_info mgpu_info = {  };  int amdgpu_ras_enable = -1;  uint amdgpu_ras_mask = 0xffffffff;
+int amdgpu_bad_page_threshold = -1;
 
 /**
  * DOC: vramlimit (int)
@@ -801,6 +802,16 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);  MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)");  module_param_named(reset_method, amdgpu_reset_method, int, 0444);
 
+/**
+ * DOC: bad_page_threshold (int)
+ * Bad page threshold configuration is driven by RMA(Return Merchandise
+ * Authorization) policy, which is to specify the threshold value of 
+faulty
+ * pages detected by ECC, which may result in GPU's retirement if total
+ * faulty pages by ECC exceed threshold value.
+ */
+MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = 
+auto(default typical value))"); module_param_named(bad_page_threshold,
+amdgpu_bad_page_threshold, int, 0444);
+
 static const struct pci_device_id pciidlist[] = {  #ifdef  CONFIG_DRM_AMDGPU_SI
 	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
