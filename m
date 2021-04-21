Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17A8C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 04:35:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33213613E1
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 04:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33213613E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7F676E062;
	Wed, 21 Apr 2021 04:35:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 459266E062
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 04:35:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvnNVDU4T9PCYN7IheMuOeHZPzoQIMgBBuUofWj7a9OpghJdQhpd3NaVWHFDIpKLJiVv3tFQj6LbIhBL6MOPUGowVzOHgVxIuF9gnam+ycMFHQSb2ToPvwWG13KeaUUlJueJRKfT3n6izCvHGM0pd8ipsymzalLNr0Fvw16Q/xcBgTnIv+yyi0AHx/urHKEhb5ec73etWn2t5u4y+DCFU3IAXJ0k2RsyhqyydCuqIOIaQ2Nu0+uStFt8an3wAVzl+rBIHQv5pywtJHKULvpU82pjeiFdwQoa45akIhVikX0h77pRwtLp+xv444QV2hLxxBh7R5ked0fKno0h5AOTXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9euUTKQpbLT4MfA9NUkEMWT0YZPf79P6dxuqD3j4Zk=;
 b=hs/K9fsWe9K/G4aYwreRe0fKBtJ90IYquiiCttMz7BoysiV3lOzQ69V6gLJKfuFuvB9M4ba0uSvDNVWA6mJHl3ehFrwTKSexUhp54xsm5+dwkZIoUo+q3UfHsxhdgx7gtIVQuHzkJ4yl2mjARv1LUOmkaAi9LVhMefXA9UbHpmMuQ/0CLZJcfXrHRf+7JrYCvqbBXGbbF0qoJnWTmN4lX8yJ5Y741xk6Ij/TKfuCxArv+Cj3mkKBXHDCPgcvAp69J5nMVkMbKfWhbidb4UE/jHGx0qhq4+JZ2ijjNn0z7ompfRN/5LALYQA81eD4qaMwWgKV9rzLDMwhqUmWQprtMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9euUTKQpbLT4MfA9NUkEMWT0YZPf79P6dxuqD3j4Zk=;
 b=f2A5YwiVVgBZMrfJvlTgH2cCjo2wlUpPfHmj7gx+/Psz9p7RppB5eLyJI7gSbbq8nP89tPyJkyvXT5yyaiMYVGiiwDGR6QBUZlKT2fhMaQkNMWjReuGpbjqwCSg2+EV1CQ7dUR08PFGqRWY+QYJGhop1Dyy2mQz+nz6UbYJfBts=
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB3189.namprd12.prod.outlook.com (2603:10b6:a03:134::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.24; Wed, 21 Apr
 2021 04:35:10 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 04:35:09 +0000
From: "Nieto, David M" <David.Nieto@amd.com>
To: "Sun, Roy" <Roy.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: Add show_fdinfo() interface
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add show_fdinfo() interface
Thread-Index: AQHXNmD3Fo452gBcAkeRgvK8Ii7+16q+YWVE
Date: Wed, 21 Apr 2021 04:35:09 +0000
Message-ID: <BYAPR12MB2840CE4D42797053683D3541F4479@BYAPR12MB2840.namprd12.prod.outlook.com>
References: <20210421034636.27816-1-Roy.Sun@amd.com>,
 <20210421034636.27816-2-Roy.Sun@amd.com>
In-Reply-To: <20210421034636.27816-2-Roy.Sun@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-21T04:35:09.272Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.143.192.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9628b4be-4fa7-4bc5-a5de-08d9047ed8cb
x-ms-traffictypediagnostic: BYAPR12MB3189:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3189AB0A4598BA30DB6C707AF4479@BYAPR12MB3189.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Bg0s5qZl/ItBYJF532I47M5wJ4nc2mm+IzzLocsplLxpxX+MKgbACpEx6HuPr3xG/xCbpgwpwOV6Wi/9j75WX0PmGPZkaLXh+69ufcpR6XqzfAUIh4AZdy+HoaXFroftOAhYh0ZucpmKPkLwJWA7CcOkNdAVC7afHVNDpOb/o7YjVSB2dd6wtc1ClTYP6bdrhyEtRDqGD8xA6IV/oAVdXrXEz5VQ+IfDVjbwNAGHetZD8JnabkKB7H9SlAuTlDnQdJqbdyZp0bxzilUVqWfewJSih4KO+oQ4PwabPcaA+HLrhRCZK/OfU8q4uLjqLUZK/uSES9Vp2D+OdcoSTTmjN1X6+YBoJ0eH/8EY8leuGQLhVWQtFAbBmoelhfTyE702NbzbkDa8j1zYS98Rq4JPBimv2sI4SHq4Sz7acV96giwjIBAdCHnqGQMTgGxElwgPj6nKN1ZPLhvjIlkzHgS9lzJ8usxd0BQVF6lSxQ1XYzxdS7GakJ1JuLgJo16mOACx1U0Xrjlf1COxEfoBMCAWLfPlCjR5kOnzmqZe+JI94JgwdTUquyOfphlPD6nSqPTSO6tIn7yMfhy0+udh+6X1rmBSC1fTbNJpSuKJ2xVDWzVsI/cZVqAspGEsBWxVhaWkwJdbmJjcswM7wmYgpMk8z+z52MEo4cxNGQGeSdet9rdEybLfI11U9zuQMILkbMS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(83380400001)(166002)(19627405001)(66476007)(66946007)(76116006)(316002)(5660300002)(55016002)(26005)(2906002)(110136005)(30864003)(8936002)(33656002)(71200400001)(186003)(9686003)(478600001)(7696005)(86362001)(122000001)(52536014)(64756008)(66556008)(8676002)(6506007)(66446008)(53546011)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?anbmbb3Kv3ESepd99MQ4eIOStBzAAihcPQe3gnPxsvLvP/89WKa0QhCl0pLe?=
 =?us-ascii?Q?gUkxHKgAss3JykPo1AwCSUMeqk9nuQKCpNBaz9z0PT0R9Z+3QYbT7/VFTW1q?=
 =?us-ascii?Q?2yCnBeuYdjknBUapUiLqCW4FDddg9a3EA8Dg8Qi1IRr2fsvjv7FWyfEHtBlZ?=
 =?us-ascii?Q?QAWDLBYTgkLc8I2IxvZ3WEa3t45Q+XlVQ9R82v866mzF5pyXoaU6D8ksJixn?=
 =?us-ascii?Q?wONDx1y0ITIT9nLmJhfcWkFQWWjikKbiMnF9HHsiqWg035V9J0bp3LXz4TeV?=
 =?us-ascii?Q?W7V16v9CQgsS78dFqU+0qMOXWDYwDN7LptPxWOmCYH75Zveh9Y/1cOeUI835?=
 =?us-ascii?Q?G2/n0uaxdWHh5oaQ0ftt4iUXc+NmxAWw/ewyaJ0k1uojUWrqvWhFpgtS92Nb?=
 =?us-ascii?Q?+A33rdKrIkaRoaSeLwCBQbdiaE7Q+qov10HVgX7/mEOvGka6eUX7UQcW7uUN?=
 =?us-ascii?Q?HBc0Kcj6Ne+s4BXvUcIEdvPKXLxd2Jw4pUGCb0fINULlBj1/MOPoeN6CcLhI?=
 =?us-ascii?Q?MWF6pxR97RWtKJNnddeB1Fqgy/evb5Ye594YHLuuM1T1rJUM+lO701fBAx+8?=
 =?us-ascii?Q?04JnlqFi6H+tpMus7KlHSOkuVUOrErSDXRNQM2Y/7I7h8J8d9tBugBhxGM3R?=
 =?us-ascii?Q?lBAec7RNpA5LD48g61Hx/9j3r6imVGIUQIA+Mw+cRrPZuL27RjfZquag5a3c?=
 =?us-ascii?Q?D34XBMQAwqzPNiRiKgTEIWqOgQKU7iHQgqFggmgYwr2yuizrBwBXwbiRr+Kk?=
 =?us-ascii?Q?XHoIjdQD5X2XTK6cIMrcy/WsGynNgqDZnQF7q/75EKbOT1vhlL0CSjVZuoGa?=
 =?us-ascii?Q?+M1X+7fTwoEGk/r0hUIdB6hCVYR10d1jTaTX9V8hTt5rywOBPK0ugm9+5nYv?=
 =?us-ascii?Q?Gd47xAzJNBClkkKNVUMnehrkaz4smldpxa0S8YZ3hzuebizcBo2QXM2AxOn7?=
 =?us-ascii?Q?JnhaqIOUn8EXroxksf7BYLGdbAlZnCdHFe/ppBPqVhfHRMVL3fsExp7FdgCz?=
 =?us-ascii?Q?mtU9jS3y8UxZLLEhlkOj5X8TYPRC65FmcgE0qkUAnL5OqBc92mbSaMlK9TzI?=
 =?us-ascii?Q?taJSVWFUzpknS4JPrH04x3TkeUm8sey3c/D27pgjUKRgQd68BTohPJxQYrSy?=
 =?us-ascii?Q?R7o+rHPHD3fEV0lHu3ZmP5mMJGOcRqn9m/d670uF2uzI/R8tAeO+za91XuBM?=
 =?us-ascii?Q?gbAqoFKguFtdhmK4FI5W1d8Zgr8t7NU6QK+5Vo//R6O3UUGPyghU3DTkjRMo?=
 =?us-ascii?Q?QEUzFTUiAlVS5u82y2QGQEnUWDYFP2XcZ8itOYTxWgD6SRRV+o9UbZeNFfMW?=
 =?us-ascii?Q?HPU6cCa+Sl2O8IXZfpGfu64n?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9628b4be-4fa7-4bc5-a5de-08d9047ed8cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 04:35:09.7502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OErIZ5OJQecC/2DyDEBG260V6kXXEF73cME6XV1GAzcTh3hjlKiJjnuT3Az0HIlU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3189
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
Content-Type: multipart/mixed; boundary="===============0937732563=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0937732563==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB2840CE4D42797053683D3541F4479BYAPR12MB2840namp_"

--_000_BYAPR12MB2840CE4D42797053683D3541F4479BYAPR12MB2840namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

I think we should probably add the pci domain to the bdf to match the forma=
t in the kernel

+       seq_printf(m, "pdev:\t%02x:%02x.%d\npasid:\t%u\n", bus, dev, fn,
+                       fpriv->vm.pasid);

you can get it with

pci_domain_nr<https://elixir.bootlin.com/linux/latest/C/ident/pci_domain_nr=
>(pdev->bus<https://elixir.bootlin.com/linux/latest/C/ident/bus>)

David

________________________________
From: Roy Sun <Roy.Sun@amd.com>
Sent: Tuesday, April 20, 2021 8:46 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Sun, Roy <Roy.Sun@amd.com>; Nieto, David M <David.Nieto@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add show_fdinfo() interface

Tracking devices, process info and fence info using
/proc/pid/fdinfo

Signed-off-by: David M Nieto <David.Nieto@amd.com>
Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile        |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 61 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 92 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h | 43 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  1 +
 8 files changed, 208 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdg=
pu/Makefile
index ee85e8aba636..d216b7ecb5d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -58,6 +58,8 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_kms.o \
         amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
         amdgpu_fw_attestation.o amdgpu_securedisplay.o

+amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o
+
 amdgpu-$(CONFIG_PERF_EVENTS) +=3D amdgpu_pmu.o

 # add asic specific block
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 125b25a5ce5b..3365feae15e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -107,6 +107,7 @@
 #include "amdgpu_gfxhub.h"
 #include "amdgpu_df.h"
 #include "amdgpu_smuio.h"
+#include "amdgpu_fdinfo.h"

 #define MAX_GPU_INSTANCE                16

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ctx.c
index 0350205c4897..01fe60fedcbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -651,3 +651,64 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
         idr_destroy(&mgr->ctx_handles);
         mutex_destroy(&mgr->lock);
 }
+
+void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_ctx_entit=
y *centity,
+               ktime_t *total, ktime_t *max)
+{
+       ktime_t now, t1;
+       uint32_t i;
+
+       now =3D ktime_get();
+       for (i =3D 0; i < amdgpu_sched_jobs; i++) {
+               struct dma_fence *fence;
+               struct drm_sched_fence *s_fence;
+
+               spin_lock(&ctx->ring_lock);
+               fence =3D dma_fence_get(centity->fences[i]);
+               spin_unlock(&ctx->ring_lock);
+               if (!fence)
+                       continue;
+               s_fence =3D to_drm_sched_fence(fence);
+               if (!dma_fence_is_signaled(&s_fence->scheduled))
+                       continue;
+               t1 =3D s_fence->scheduled.timestamp;
+               if (t1 >=3D now)
+                       continue;
+               if (dma_fence_is_signaled(&s_fence->finished) &&
+                       s_fence->finished.timestamp < now)
+                       *total +=3D ktime_sub(s_fence->finished.timestamp, =
t1);
+               else
+                       *total +=3D ktime_sub(now, t1);
+               t1 =3D ktime_sub(now, t1);
+               dma_fence_put(fence);
+               *max =3D max(t1, *max);
+       }
+}
+
+ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hw=
ip,
+               uint32_t idx, uint64_t *elapsed)
+{
+       struct idr *idp;
+       struct amdgpu_ctx *ctx;
+       uint32_t id;
+       struct amdgpu_ctx_entity *centity;
+       ktime_t total =3D 0, max =3D 0;
+
+       if (idx >=3D AMDGPU_MAX_ENTITY_NUM)
+               return 0;
+       idp =3D &mgr->ctx_handles;
+       mutex_lock(&mgr->lock);
+       idr_for_each_entry(idp, ctx, id) {
+               if (!ctx->entities[hwip][idx])
+                       continue;
+
+               centity =3D ctx->entities[hwip][idx];
+               amdgpu_ctx_fence_time(ctx, centity, &total, &max);
+       }
+
+       mutex_unlock(&mgr->lock);
+       if (elapsed)
+               *elapsed =3D max;
+
+       return total;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ctx.h
index f54e10314661..10dcf59a5c6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -87,5 +87,8 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr);
 void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr);
 long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)=
;
 void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);
-
+ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hw=
ip,
+               uint32_t idx, uint64_t *elapsed);
+void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_ctx_entit=
y *centity,
+               ktime_t *total, ktime_t *max);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 0369d3532bf0..01603378dbc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -42,7 +42,7 @@
 #include "amdgpu_irq.h"
 #include "amdgpu_dma_buf.h"
 #include "amdgpu_sched.h"
-
+#include "amdgpu_fdinfo.h"
 #include "amdgpu_amdkfd.h"

 #include "amdgpu_ras.h"
@@ -1692,6 +1692,9 @@ static const struct file_operations amdgpu_driver_kms=
_fops =3D {
 #ifdef CONFIG_COMPAT
         .compat_ioctl =3D amdgpu_kms_compat_ioctl,
 #endif
+#ifdef CONFIG_PROC_FS
+       .show_fdinfo =3D amdgpu_show_fdinfo
+#endif
 };

 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_fdinfo.c
new file mode 100644
index 000000000000..56ad1e819822
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: MIT
+/* Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software=
"),
+ * to deal in the Software without restriction, including without limitati=
on
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: David Nieto
+ *          Roy Sun
+ */
+
+#include <linux/debugfs.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/uaccess.h>
+#include <linux/reboot.h>
+#include <linux/syscalls.h>
+
+#include <drm/amdgpu_drm.h>
+#include <drm/drm_debugfs.h>
+
+#include "amdgpu.h"
+#include "amdgpu_vm.h"
+#include "amdgpu_gem.h"
+#include "amdgpu_ctx.h"
+#include "amdgpu_fdinfo.h"
+
+
+static const char *amdgpu_ip_name[AMDGPU_HW_IP_NUM] =3D {
+       [AMDGPU_HW_IP_GFX]      =3D       "gfx",
+       [AMDGPU_HW_IP_COMPUTE]  =3D       "compute",
+       [AMDGPU_HW_IP_DMA]      =3D       "dma",
+       [AMDGPU_HW_IP_UVD]      =3D       "dec",
+       [AMDGPU_HW_IP_VCE]      =3D       "enc",
+       [AMDGPU_HW_IP_UVD_ENC]  =3D       "enc_1",
+       [AMDGPU_HW_IP_VCN_DEC]  =3D       "dec",
+       [AMDGPU_HW_IP_VCN_ENC]  =3D       "enc",
+       [AMDGPU_HW_IP_VCN_JPEG] =3D       "jpeg",
+};
+
+void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
+{
+       struct amdgpu_fpriv *fpriv;
+       uint32_t bus, dev, fn, i;
+       uint64_t vram_mem =3D 0, gtt_mem =3D 0;
+       struct drm_file *file =3D f->private_data;
+       struct amdgpu_device *adev =3D drm_to_adev(file->minor->dev);
+
+       if (amdgpu_file_to_fpriv(f, &fpriv))
+               return;
+       bus =3D adev->pdev->bus->number;
+       dev =3D PCI_SLOT(adev->pdev->devfn);
+       fn =3D PCI_FUNC(adev->pdev->devfn);
+
+       amdgpu_debugfs_vm_bo_info(&fpriv->vm, m);
+       seq_printf(m, "pdev:\t%02x:%02x.%d\npasid:\t%u\n", bus, dev, fn,
+                       fpriv->vm.pasid);
+       for (i =3D 0; i < AMDGPU_HW_IP_NUM; i++) {
+               uint32_t count =3D amdgpu_ctx_num_entities[i];
+               int idx =3D 0;
+               uint64_t total =3D 0, min =3D 0;
+               uint32_t perc, frac;
+
+               for (idx =3D 0; idx < count; idx++) {
+                       total =3D amdgpu_ctx_mgr_fence_usage(&fpriv->ctx_mg=
r,
+                               i, idx, &min);
+                       if ((total =3D=3D 0) || (min =3D=3D 0))
+                               continue;
+
+                       perc =3D div64_u64(10000 * total, min);
+                       frac =3D perc % 100;
+
+                       seq_printf(m, "%s%d:\t%d.%d%%\n",
+                                       amdgpu_ip_name[i],
+                                       idx, perc/100, frac);
+               }
+       }
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_fdinfo.h
new file mode 100644
index 000000000000..41a4c7056729
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: MIT
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software=
"),
+ * to deal in the Software without restriction, including without limitati=
on
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: David Nieto
+ *          Roy Sun
+ */
+#ifndef __AMDGPU_SMI_H__
+#define __AMDGPU_SMI_H__
+
+#include <linux/idr.h>
+#include <linux/kfifo.h>
+#include <linux/rbtree.h>
+#include <drm/gpu_scheduler.h>
+#include <drm/drm_file.h>
+#include <drm/ttm/ttm_bo_driver.h>
+#include <linux/sched/mm.h>
+
+#include "amdgpu_sync.h"
+#include "amdgpu_ring.h"
+#include "amdgpu_ids.h"
+
+uint32_t amdgpu_get_ip_count(struct amdgpu_device *adev, int id);
+void amdgpu_show_fdinfo(struct seq_file *m, struct file *f);
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index f95bcda8463f..3c7390727edf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -25,6 +25,7 @@
  *          Alex Deucher
  *          Jerome Glisse
  */
+
 #include <linux/dma-fence-array.h>
 #include <linux/interval_tree_generic.h>
 #include <linux/idr.h>
--
2.31.1


--_000_BYAPR12MB2840CE4D42797053683D3541F4479BYAPR12MB2840namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
I think we should probably add the pci domain to the bdf to match the forma=
t in the kernel</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
system-ui, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.66=
67px; background-color: rgb(255, 255, 255); display: inline !important;">+&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 seq_printf(m, &quot;pdev:\t%02x:%02x.%d\npasid:\t%u\n&quot;, bus, dev, fn,=
</span><br>
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
system-ui, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.66=
67px; background-color: rgb(255, 255, 255); display: inline !important;">+&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 fpriv-&gt;vm.pasid);</span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
system-ui, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.66=
67px; background-color: rgb(255, 255, 255); display: inline !important;"><b=
r>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
system-ui, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.66=
67px; background-color: rgb(255, 255, 255); display: inline !important;">yo=
u
 can get it with&nbsp;
<pre style=3D"font-family: &quot;Ubuntu Mono&quot;, monospace; font-size: 0=
.9em; line-height: 1.2; padding: 1em 0px 4em 1em; color: rgb(0, 0, 0); marg=
in: 0px; min-height: 100%; tab-size: 8; hyphens: none;"><span class=3D"n"><=
a href=3D"https://elixir.bootlin.com/linux/latest/C/ident/pci_domain_nr" st=
yle=3D"background: linear-gradient(rgba(0, 0, 0, 0) 10%, rgb(244, 246, 255)=
 10%, rgb(244, 246, 255) 90%, rgba(0, 0, 0, 0) 90%); font-weight: 700; bord=
er-radius: 0.2em; border-bottom: 1px dotted rgb(0, 0, 0);">pci_domain_nr</a=
></span><span class=3D"p" style=3D"color: rgb(102, 102, 102);">(</span><spa=
n class=3D"n">pdev</span><span class=3D"o" style=3D"color: rgb(102, 102, 10=
2);">-&gt;</span><span class=3D"n"><a href=3D"https://elixir.bootlin.com/li=
nux/latest/C/ident/bus" style=3D"background: linear-gradient(rgba(0, 0, 0, =
0) 10%, rgb(244, 246, 255) 10%, rgb(244, 246, 255) 90%, rgba(0, 0, 0, 0) 90=
%); font-weight: 700; border-radius: 0.2em;">bus</a></span><span class=3D"p=
" style=3D"color: rgb(102, 102, 102);">)</span></pre>
<pre style=3D"font-family: &quot;Ubuntu Mono&quot;, monospace; font-size: 0=
.9em; line-height: 1.2; padding: 1em 0px 4em 1em; color: rgb(0, 0, 0); marg=
in: 0px; min-height: 100%; tab-size: 8; hyphens: none;"><span class=3D"p" s=
tyle=3D"color: rgb(102, 102, 102);">David</span></pre>
</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Roy Sun &lt;Roy.Sun@a=
md.com&gt;<br>
<b>Sent:</b> Tuesday, April 20, 2021 8:46 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Sun, Roy &lt;Roy.Sun@amd.com&gt;; Nieto, David M &lt;David.Nieto=
@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: Add show_fdinfo() interface</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Tracking devices, process info and fence info usin=
g<br>
/proc/pid/fdinfo<br>
<br>
Signed-off-by: David M Nieto &lt;David.Nieto@amd.com&gt;<br>
Signed-off-by: Roy Sun &lt;Roy.Sun@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; |&nbsp; 2 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; |&nbsp; 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c&nbsp;&nbsp;&nbsp; | 61 ++++++=
++++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h&nbsp;&nbsp;&nbsp; |&nbsp; 5 +=
-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp; |&nbsp; 5 +=
-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 92 +++++++++++++++++++++=
+<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h | 43 ++++++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp=
; 1 +<br>
&nbsp;8 files changed, 208 insertions(+), 2 deletions(-)<br>
&nbsp;create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c<br>
&nbsp;create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdg=
pu/Makefile<br>
index ee85e8aba636..d216b7ecb5d1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/Makefile<br>
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile<br>
@@ -58,6 +58,8 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_kms.o \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_umc.o smu_v11_0_i2c=
.o amdgpu_fru_eeprom.o amdgpu_rap.o \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fw_attestation.o am=
dgpu_securedisplay.o<br>
&nbsp;<br>
+amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o<br>
+<br>
&nbsp;amdgpu-$(CONFIG_PERF_EVENTS) +=3D amdgpu_pmu.o<br>
&nbsp;<br>
&nbsp;# add asic specific block<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 125b25a5ce5b..3365feae15e1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -107,6 +107,7 @@<br>
&nbsp;#include &quot;amdgpu_gfxhub.h&quot;<br>
&nbsp;#include &quot;amdgpu_df.h&quot;<br>
&nbsp;#include &quot;amdgpu_smuio.h&quot;<br>
+#include &quot;amdgpu_fdinfo.h&quot;<br>
&nbsp;<br>
&nbsp;#define MAX_GPU_INSTANCE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ctx.c<br>
index 0350205c4897..01fe60fedcbe 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
@@ -651,3 +651,64 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idr_destroy(&amp;mgr-&gt;c=
tx_handles);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;mgr-&gt=
;lock);<br>
&nbsp;}<br>
+<br>
+void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_ctx_entit=
y *centity,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ktime_t *total, ktime_t *max)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ktime_t now, t1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; now =3D ktime_get();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; amdgpu_sched_job=
s; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct dma_fence *fence;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct drm_sched_fence *s_fence;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spin_lock(&amp;ctx-&gt;ring_lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fence =3D dma_fence_get(centity-&gt;fences[i]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spin_unlock(&amp;ctx-&gt;ring_lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!fence)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; s_fence =3D to_drm_sched_fence(fence);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!dma_fence_is_signaled(&amp;s_fence-&gt;scheduled))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; t1 =3D s_fence-&gt;scheduled.timestamp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (t1 &gt;=3D now)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (dma_fence_is_signaled(&amp;s_fence-&gt;finished) &amp;&amp;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_fence-&gt;fini=
shed.timestamp &lt; now)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *total +=3D ktim=
e_sub(s_fence-&gt;finished.timestamp, t1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *total +=3D ktim=
e_sub(now, t1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; t1 =3D ktime_sub(now, t1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dma_fence_put(fence);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *max =3D max(t1, *max);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+}<br>
+<br>
+ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hw=
ip,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t idx, uint64_t *elapsed)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idr *idp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ctx *ctx;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t id;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ctx_entity *centity;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ktime_t total =3D 0, max =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (idx &gt;=3D AMDGPU_MAX_ENTITY_NUM=
)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idp =3D &amp;mgr-&gt;ctx_handles;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;mgr-&gt;lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idr_for_each_entry(idp, ctx, id) {<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!ctx-&gt;entities[hwip][idx])<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; centity =3D ctx-&gt;entities[hwip][idx];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_ctx_fence_time(ctx, centity, &amp;total, &amp;max);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;mgr-&gt;lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (elapsed)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *elapsed =3D max;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return total;<br>
+}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ctx.h<br>
index f54e10314661..10dcf59a5c6b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h<br>
@@ -87,5 +87,8 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr);<br>
&nbsp;void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr);<br>
&nbsp;long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long tim=
eout);<br>
&nbsp;void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);<br>
-<br>
+ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hw=
ip,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t idx, uint64_t *elapsed);<br>
+void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_ctx_entit=
y *centity,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ktime_t *total, ktime_t *max);<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 0369d3532bf0..01603378dbc9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -42,7 +42,7 @@<br>
&nbsp;#include &quot;amdgpu_irq.h&quot;<br>
&nbsp;#include &quot;amdgpu_dma_buf.h&quot;<br>
&nbsp;#include &quot;amdgpu_sched.h&quot;<br>
-<br>
+#include &quot;amdgpu_fdinfo.h&quot;<br>
&nbsp;#include &quot;amdgpu_amdkfd.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;amdgpu_ras.h&quot;<br>
@@ -1692,6 +1692,9 @@ static const struct file_operations amdgpu_driver_kms=
_fops =3D {<br>
&nbsp;#ifdef CONFIG_COMPAT<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .compat_ioctl =3D amdgpu_k=
ms_compat_ioctl,<br>
&nbsp;#endif<br>
+#ifdef CONFIG_PROC_FS<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .show_fdinfo =3D amdgpu_show_fdinfo<b=
r>
+#endif<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpr=
iv)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_fdinfo.c<br>
new file mode 100644<br>
index 000000000000..56ad1e819822<br>
--- /dev/null<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c<br>
@@ -0,0 +1,92 @@<br>
+// SPDX-License-Identifier: MIT<br>
+/* Copyright 2021 Advanced Micro Devices, Inc.<br>
+ *<br>
+ * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
+ * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
+ * to deal in the Software without restriction, including without limitati=
on<br>
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
+ * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
+ * Software is furnished to do so, subject to the following conditions:<br=
>
+ *<br>
+ * The above copyright notice and this permission notice shall be included=
 in<br>
+ * all copies or substantial portions of the Software.<br>
+ *<br>
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO EVENT=
 SHALL<br>
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R<br>
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<b=
r>
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR<b=
r>
+ * OTHER DEALINGS IN THE SOFTWARE.<br>
+ *<br>
+ * Authors: David Nieto<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Roy Sun<br>
+ */<br>
+<br>
+#include &lt;linux/debugfs.h&gt;<br>
+#include &lt;linux/list.h&gt;<br>
+#include &lt;linux/module.h&gt;<br>
+#include &lt;linux/uaccess.h&gt;<br>
+#include &lt;linux/reboot.h&gt;<br>
+#include &lt;linux/syscalls.h&gt;<br>
+<br>
+#include &lt;drm/amdgpu_drm.h&gt;<br>
+#include &lt;drm/drm_debugfs.h&gt;<br>
+<br>
+#include &quot;amdgpu.h&quot;<br>
+#include &quot;amdgpu_vm.h&quot;<br>
+#include &quot;amdgpu_gem.h&quot;<br>
+#include &quot;amdgpu_ctx.h&quot;<br>
+#include &quot;amdgpu_fdinfo.h&quot;<br>
+<br>
+<br>
+static const char *amdgpu_ip_name[AMDGPU_HW_IP_NUM] =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [AMDGPU_HW_IP_GFX]&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; =3D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;gfx&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [AMDGPU_HW_IP_COMPUTE]&nbsp; =3D&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;compute&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [AMDGPU_HW_IP_DMA]&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; =3D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;dma&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [AMDGPU_HW_IP_UVD]&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; =3D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;dec&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [AMDGPU_HW_IP_VCE]&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; =3D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;enc&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [AMDGPU_HW_IP_UVD_ENC]&nbsp; =3D&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;enc_1&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [AMDGPU_HW_IP_VCN_DEC]&nbsp; =3D&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;dec&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [AMDGPU_HW_IP_VCN_ENC]&nbsp; =3D&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;enc&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [AMDGPU_HW_IP_VCN_JPEG] =3D&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; &quot;jpeg&quot;,<br>
+};<br>
+<br>
+void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_fpriv *fpriv;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t bus, dev, fn, i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t vram_mem =3D 0, gtt_mem =3D =
0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_file *file =3D f-&gt;priva=
te_data;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D drm_to=
_adev(file-&gt;minor-&gt;dev);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_file_to_fpriv(f, &amp;fpri=
v))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bus =3D adev-&gt;pdev-&gt;bus-&gt;num=
ber;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev =3D PCI_SLOT(adev-&gt;pdev-&gt;de=
vfn);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fn =3D PCI_FUNC(adev-&gt;pdev-&gt;dev=
fn);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_vm_bo_info(&amp;fpriv-=
&gt;vm, m);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;pdev:\t%02x:%02x.=
%d\npasid:\t%u\n&quot;, bus, dev, fn,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fpriv-&gt;vm.pas=
id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGPU_HW_IP_NUM=
; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t count =3D amdgpu_ctx_num_entities[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int idx =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t total =3D 0, min =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t perc, frac;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (idx =3D 0; idx &lt; count; idx++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total =3D amdgpu=
_ctx_mgr_fence_usage(&amp;fpriv-&gt;ctx_mgr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i, idx, &amp;min);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((total =3D=
=3D 0) || (min =3D=3D 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; perc =3D div64_u=
64(10000 * total, min);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frac =3D perc % =
100;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_printf(m, &q=
uot;%s%d:\t%d.%d%%\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; amdgpu_ip_name[i],<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; idx, perc/100, frac);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_fdinfo.h<br>
new file mode 100644<br>
index 000000000000..41a4c7056729<br>
--- /dev/null<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h<br>
@@ -0,0 +1,43 @@<br>
+/* SPDX-License-Identifier: MIT<br>
+ * Copyright 2021 Advanced Micro Devices, Inc.<br>
+ *<br>
+ * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
+ * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
+ * to deal in the Software without restriction, including without limitati=
on<br>
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
+ * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
+ * Software is furnished to do so, subject to the following conditions:<br=
>
+ *<br>
+ * The above copyright notice and this permission notice shall be included=
 in<br>
+ * all copies or substantial portions of the Software.<br>
+ *<br>
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO EVENT=
 SHALL<br>
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R<br>
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<b=
r>
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR<b=
r>
+ * OTHER DEALINGS IN THE SOFTWARE.<br>
+ *<br>
+ * Authors: David Nieto<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Roy Sun<br>
+ */<br>
+#ifndef __AMDGPU_SMI_H__<br>
+#define __AMDGPU_SMI_H__<br>
+<br>
+#include &lt;linux/idr.h&gt;<br>
+#include &lt;linux/kfifo.h&gt;<br>
+#include &lt;linux/rbtree.h&gt;<br>
+#include &lt;drm/gpu_scheduler.h&gt;<br>
+#include &lt;drm/drm_file.h&gt;<br>
+#include &lt;drm/ttm/ttm_bo_driver.h&gt;<br>
+#include &lt;linux/sched/mm.h&gt;<br>
+<br>
+#include &quot;amdgpu_sync.h&quot;<br>
+#include &quot;amdgpu_ring.h&quot;<br>
+#include &quot;amdgpu_ids.h&quot;<br>
+<br>
+uint32_t amdgpu_get_ip_count(struct amdgpu_device *adev, int id);<br>
+void amdgpu_show_fdinfo(struct seq_file *m, struct file *f);<br>
+<br>
+#endif<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c<br>
index f95bcda8463f..3c7390727edf 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
@@ -25,6 +25,7 @@<br>
&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Alex Deucher=
<br>
&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Jerome Gliss=
e<br>
&nbsp; */<br>
+<br>
&nbsp;#include &lt;linux/dma-fence-array.h&gt;<br>
&nbsp;#include &lt;linux/interval_tree_generic.h&gt;<br>
&nbsp;#include &lt;linux/idr.h&gt;<br>
-- <br>
2.31.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB2840CE4D42797053683D3541F4479BYAPR12MB2840namp_--

--===============0937732563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0937732563==--
