Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E06C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 03:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6828206DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 03:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OTybwVUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6828206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 302886E82D;
	Fri,  5 Jun 2020 03:40:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1C8D6E82D
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 03:40:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G25JXgAoz6NElD4YKg+ujI3sLk/0BrMxvnUWHZA6ZGGC5aesvFUxeJdNy9o/gId34iqLMYTMO1tEp+dNuJb9mQ8lOVxYDcbnrWUe2aa3IsAp7UKXApt10NGCL9OboT9axKym09BwN0PZX6EhDnK6c2Uh0ZHaURLfcbGpFwf9PXYXjP4Os9EReNMs4QxAviyokACZ9NdhkDY73dVxXdl4AjBN6PUC5Zti8/scX0tq6ap+Y28CFcAN7iAG9ictaBRgNWACRrGBkU3G8Ejkhn9j1q31USyZg5S2ibR4r75TJ2ICUV1FMFg5adz8ZDhRK15y0hPoHgwRZP82jf5Ne/snvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ar8tCIG5EG2XoKwKbyLNcg3RJyYT+FirNwKLlHe9lx4=;
 b=iq+NAW9fNxmKoDwWK47nWmgo3EWcDJ6dj1BcoFduoF7EXT/zxSoMeBj3JuhqXbvJilspg2b+hFeB3F8ElWbzt6qk/vvQTYKHeqxbJqzGAGNIDtcbEMKcPcIrR5v1f9n7DXkM4xZLh45UMQDb0z7uBfOm/ExSlTTPX5WWnEuoW5WWjSpLfQI9hyDg6GSPfPGUuFCZGhBNOSbWoFwICWDtncOL9BILhv4vhx4BuqIsqv5YYj+turwdJfcRDUs0E52qrWPE3i7+0ttXMyTvOdsNujSesNW4phdHvBqldAIwhIK41sKce+c03y8kcNwVGRuzvaW8q38IUiQvIk4DkfJ2xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ar8tCIG5EG2XoKwKbyLNcg3RJyYT+FirNwKLlHe9lx4=;
 b=OTybwVUDbpqm3vqZfdNFuoZSjpyF+qg+r/PC/ZGMx3p6lj4VmMGH848U1dMCeM5ogMKgga+exYWmwAscFhZg/EANBptAmVHGX6TPdbb3qyP5RndUMMZR4fHwEihQ0gKK7g/k2JelXnUOkII88/NQAh1Ejbk2RGET82P1MabIX+s=
Received: from MWHPR12MB1837.namprd12.prod.outlook.com (2603:10b6:300:113::20)
 by MWHPR12MB1453.namprd12.prod.outlook.com (2603:10b6:301:e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Fri, 5 Jun
 2020 03:40:15 +0000
Received: from MWHPR12MB1837.namprd12.prod.outlook.com
 ([fe80::c142:31c5:738f:205c]) by MWHPR12MB1837.namprd12.prod.outlook.com
 ([fe80::c142:31c5:738f:205c%9]) with mapi id 15.20.3066.019; Fri, 5 Jun 2020
 03:40:15 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH V2] drm/amdgpu: support reserve bad page for virt
Thread-Topic: [PATCH V2] drm/amdgpu: support reserve bad page for virt
Thread-Index: AQHWOmy9PSjHlVLZTUOdOVKeTyv1wqjJVhaAgAAJb+A=
Date: Fri, 5 Jun 2020 03:40:14 +0000
Message-ID: <MWHPR12MB1837998F97D0D4F78B4DEFF59A860@MWHPR12MB1837.namprd12.prod.outlook.com>
References: <20200604123602.14032-1-Stanley.Yang@amd.com>
 <BYAPR12MB28880F18E2F539BB8566A26AB0860@BYAPR12MB2888.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB28880F18E2F539BB8566A26AB0860@BYAPR12MB2888.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-Mentions: Hawking.Zhang@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-05T03:00:11Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=2cb7fd7c-b27a-4ae9-8e77-0000e6a640dc;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-06-05T03:40:11Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 984b11e1-1734-4411-805a-0000d1fef73e
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: caf86f9e-f16f-4f6e-a482-08d8090228c5
x-ms-traffictypediagnostic: MWHPR12MB1453:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB14537C8D353C0F659C0213759A860@MWHPR12MB1453.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G+sqzXFEwRHPldkUAxGnxeMpFv6T2oDRoxUkJdqqhy31z+6ZgxtmGId4zoAWjYQ36FoiCOGYGIFHl4pGgluIVmX9N+vhY8r9CDq89WLUe/Aspln4i757ojmyxTM4md5vcudQzZgBFnIAxEjI2pbz9jRQ/CY3zOOIRbZjqqrHwlUfoHYdmg9S+2sQL2ilu7BT67mQuXWe2kLkwxjRNyav6LfUYwflJhLmQnRJSs+g8X7IBRQV583R0lrwoXoHvwf3mZW7d9r8apdIuQECzrsxQ9gLuqa4rXM7N2XNC1Wec40d45fz8Nk9e1TRPdZupWFo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1837.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(83380400001)(64756008)(52536014)(66476007)(66556008)(66446008)(478600001)(2906002)(66946007)(54906003)(110136005)(316002)(9686003)(7696005)(26005)(55016002)(53546011)(6506007)(30864003)(5660300002)(4326008)(71200400001)(76116006)(86362001)(186003)(8676002)(8936002)(33656002)(6636002)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: m4xVgZ/yy7V4BNHapzHne3w+RHRs8bPtNsAkcNTumh5axdD9pgeJCXpzV0SWiAhkHC/obvJHD2SBIELGJ0Di6F9qfT4v8tpErRYYiWfgoWETaNY5Q8jqWaAUhhWRdmHQZSTqP71qG5OVUANKGslij0od0dIo7sFwlJzPR0QS+d5sB0NAdD5c+ftn80zmUmz/rEb2NoFy9ycLX0XePYpsVVhkheCtb8ksyb0SN3KWl5Bdvu9AVIW75JVJM7u7nEnzPrlnlQ83Qf4S0fQsryyF8baR1r9Wh+YogeHFf41RLUuZ3hfsZUV9WcL/NnGixEUtjARG7Orwnk0RppxanBE34F4K1IQfvLLWMaYXTcR2H2lpmq14ccKagZXkpZu7zOf96OzaWPZ935PetqWPftwgbu+zvafM2R/r5Ojvu7E6V21as2GzBpFQUH/8l4ysFK6etIYAIR/Eeb4gUe5D5jbTxuxm8+U9kyL5LF4/OymQxPe+LXMrWtq5lAksY+a0ZqDJ
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf86f9e-f16f-4f6e-a482-08d8090228c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 03:40:14.9702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5sCh2ztaYOtjWHY72BoMQ48odBVyS6rEKjDmyS6cX5x9EX2gThs/nDVc1kpatZ6fwfQa/ABJKk8c5rqhTBZSBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1453
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
Cc: "Clements, John" <John.Clements@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 "Chen, Guchun" <Guchun.Chen@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: multipart/mixed; boundary="===============1052776192=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1052776192==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB1837998F97D0D4F78B4DEFF59A860MWHPR12MB1837namp_"

--_000_MWHPR12MB1837998F97D0D4F78B4DEFF59A860MWHPR12MB1837namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]


Hi Tao,



Thanks for your suggestion and reply inline.



Regards,

Stanley

> -----Original Message-----

> From: Zhou1, Tao <Tao.Zhou1@amd.com>

> Sent: Friday, June 5, 2020 11:00 AM

> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org

> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun

> <Guchun.Chen@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Clements,

> John <John.Clements@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Yang,

> Stanley <Stanley.Yang@amd.com>

> Subject: RE: [PATCH V2] drm/amdgpu: support reserve bad page for virt

>

> [AMD Public Use]

>

>

>

> > -----Original Message-----

> > From: Stanley.Yang <Stanley.Yang@amd.com>

> > Sent: 2020=1B$BG/=1B(B6=1B$B7n=1B(B4=1B$BF|=1B(B 20:36

> > To: amd-gfx@lists.freedesktop.org

> > Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun

> > <Guchun.Chen@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Clements,

> John

> > <John.Clements@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li,

> Dennis

> > <Dennis.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>

> > Subject: [PATCH V2] drm/amdgpu: support reserve bad page for virt

> >

> > Changed from V1:

> >         rename same functions name, only init ras error handler data fo=
r

> >         supported asic.

> >

> > Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>

> > Change-Id: Ia0ad9453ac3ac929f95c73cbee5b7a8fc42a9816

> > ---

> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   3 +

> >  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 172

> > +++++++++++++++++++++

> >  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  30 +++-

> >  3 files changed, 201 insertions(+), 4 deletions(-)

> >

> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

> > index 1df28b7bf22e..668ad0e35160 100644

> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

> > @@ -2326,6 +2326,9 @@ static int amdgpu_device_ip_fini(struct

> > amdgpu_device *adev)  {

> >         int i, r;

> >

> > +      if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)

> > +                    amdgpu_virt_release_ras_err_handler_data(adev);

> > +

> >         amdgpu_ras_pre_fini(adev);

> >

> >         if (adev->gmc.xgmi.num_physical_nodes > 1) diff --git

> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c

> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c

> > index bab9286021a7..174fcb8c8b57 100644

> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c

> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c

> > @@ -26,6 +26,7 @@

> >  #include <drm/drm_drv.h>

> >

> >  #include "amdgpu.h"

> > +#include "amdgpu_ras.h"

> >

> >  bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)  { @@ -

> > 255,12 +256,169 @@ int amdgpu_virt_fw_reserve_get_checksum(void

> *obj,

> >         return ret;

> >  }

> >

> > +static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device

> > +*adev) {

> > +      struct amdgpu_virt *virt =3D &adev->virt;

> > +      struct amdgpu_virt_ras_err_handler_data **data =3D &virt-

> > >virt_eh_data;

> > +      /* GPU will be marked bad on host if bp count more then 10,

> > +      * so alloc 512 is enough.

> > +      */

> > +      unsigned int align_space =3D 512;

> > +      void *bps =3D NULL;

> > +      struct amdgpu_bo **bps_bo =3D NULL;

> > +

> > +      *data =3D kmalloc(sizeof(struct amdgpu_virt_ras_err_handler_data=
),

> > GFP_KERNEL);

> > +      if (!*data)

> > +                    return -ENOMEM;

> > +

> > +      bps =3D kmalloc(align_space * sizeof((*data)->bps), GFP_KERNEL);

> > +      bps_bo =3D kmalloc(align_space * sizeof((*data)->bps_bo),

> > GFP_KERNEL);

> > +

> > +      if (!bps || !bps_bo) {

> > +                    kfree(bps);

> > +                    kfree(bps_bo);

> > +                    return -ENOMEM;

> > +      }

> > +

> > +      (*data)->bps =3D bps;

> > +      (*data)->bps_bo =3D bps_bo;

> > +      (*data)->count =3D 0;

> > +      (*data)->last_reserved =3D 0;

> > +

> > +      virt->ras_init_done =3D true;

> > +

> > +      return 0;

> > +}

> > +

> > +static void amdgpu_virt_ras_release_bp(struct amdgpu_device *adev) {

> > +      struct amdgpu_virt *virt =3D &adev->virt;

> > +      struct amdgpu_virt_ras_err_handler_data *data =3D virt->virt_eh_=
data;

> > +      struct amdgpu_bo *bo;

> > +      int i;

> > +

> > +      if (!data)

> > +                    return;

> > +

> > +      for (i =3D data->last_reserved - 1; i >=3D 0; i--) {

> > +                    bo =3D data->bps_bo[i];

> > +                    amdgpu_bo_free_kernel(&bo, NULL, NULL);

> > +                    data->bps_bo[i] =3D bo;

> > +                    data->last_reserved =3D i;

> > +      }

> > +}

> > +

> > +void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device

> > +*adev) {

> > +      struct amdgpu_virt *virt =3D &adev->virt;

> > +      struct amdgpu_virt_ras_err_handler_data *data =3D virt->virt_eh_=
data;

> > +

> > +      virt->ras_init_done =3D false;

> > +

> > +      if (!data)

> > +                    return;

> > +

> > +      amdgpu_virt_ras_release_bp(adev);

> > +

> > +      kfree(data->bps);

> > +      kfree(data->bps_bo);

> > +      kfree(data);

> > +      virt->virt_eh_data =3D NULL;

> > +}

> > +

> > +static void amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,

> > +                    struct eeprom_table_record *bps, int pages) {

> > +      struct amdgpu_virt *virt =3D &adev->virt;

> > +      struct amdgpu_virt_ras_err_handler_data *data =3D virt->virt_eh_=
data;

> > +

> > +      if (!data)

> > +                    return;

> > +

> > +      memcpy(&data->bps[data->count], bps, pages * sizeof(*data->bps))=
;

> > +      data->count +=3D pages;

> > +}

> > +

> > +static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev) {

> > +      struct amdgpu_virt *virt =3D &adev->virt;

> > +      struct amdgpu_virt_ras_err_handler_data *data =3D virt->virt_eh_=
data;

> > +      struct amdgpu_bo *bo =3D NULL;

> > +      uint64_t bp;

> > +      int i;

> > +

> > +      if (!data)

> > +                    return;

> > +

> > +      for (i =3D data->last_reserved; i < data->count; i++) {

> > +                    bp =3D data->bps[i].retired_page;

> > +

> > +                    /* There are two cases of reserve error should be =
ignored:

> > +                    * 1) a ras bad page has been allocated (used by so=
meone);

> > +                    * 2) a ras bad page has been reserved (duplicate e=
rror

> > injection

> > +                    *    for one page);

> > +                    */

> > +                    if (amdgpu_bo_create_kernel_at(adev, bp <<

> > AMDGPU_GPU_PAGE_SHIFT,

> > +                                                                      =
AMDGPU_GPU_PAGE_SIZE,

> > +                                                                      =
AMDGPU_GEM_DOMAIN_VRAM,

> > +                                                                      =
&bo, NULL))

> > +                                   DRM_DEBUG("RAS WARN: [SRV-IO] reser=
ve vram for

> > retired page %llx

> > +fail\n", bp);

>

> [Tao] SRIOV? Typo?

[Yang, Stanley] :

Will keep the same message with bare-metal according to @Zhang, Hawking<mai=
lto:Hawking.Zhang@amd.com>'s suggestion.

>

> > +

> > +                    data->bps_bo[i] =3D bo;

> > +                    data->last_reserved =3D i + 1;

> > +                    bo =3D NULL;

> > +      }

> > +}

> > +

> > +static bool amdgpu_virt_ras_check_bad_page(struct amdgpu_device

> *adev,

> > +                    uint64_t retired_page)

> > +{

> > +      struct amdgpu_virt *virt =3D &adev->virt;

> > +      struct amdgpu_virt_ras_err_handler_data *data =3D virt->virt_eh_=
data;

> > +      int i;

> > +

> > +      if (!data)

> > +                    return true;

> > +

> > +      for (i =3D 0; i < data->count; i++)

> > +                    if (retired_page =3D=3D data->bps[i].retired_page)

> > +                                   return true;

> > +

> > +      return false;

> > +}

> > +

> > +static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,

> > +                    uint64_t bp_block_offset, uint32_t bp_block_size) =
{

> > +      struct eeprom_table_record bp;

> > +      uint64_t retired_page;

> > +      uint32_t bp_idx, bp_cnt;

> > +

> > +      if (bp_block_size) {

> > +                    bp_cnt =3D bp_block_size / sizeof(uint64_t);

> > +                    for (bp_idx =3D 0; bp_idx < bp_cnt; bp_idx++) {

> > +                                   retired_page =3D *(uint64_t *)(adev=
-

> > >fw_vram_usage.va +

> > +                                                               bp_bloc=
k_offset + bp_idx *

> > sizeof(uint64_t));

> > +                                   bp.retired_page =3D retired_page;

> > +

> > +                                   if (amdgpu_virt_ras_check_bad_page(=
adev,

> > retired_page))

> > +                                                 continue;

> > +

> > +                                   amdgpu_virt_ras_add_bps(adev, &bp, =
1);

> > +

> > +                                   amdgpu_virt_ras_reserve_bps(adev);

> > +                    }

> > +      }

> > +}

> > +

> >  void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)  {

> >         uint32_t pf2vf_size =3D 0;

> >         uint32_t checksum =3D 0;

> >         uint32_t checkval;

> >         char *str;

> > +      uint64_t bp_block_offset =3D 0;

> > +      uint32_t bp_block_size =3D 0;

> >

> >         adev->virt.fw_reserve.p_pf2vf =3D NULL;

> >         adev->virt.fw_reserve.p_vf2pf =3D NULL; @@ -275,6 +433,20 @@ vo=
id

> > amdgpu_virt_init_data_exchange(struct

> > amdgpu_device *adev)

> >

> >                       /* pf2vf message must be in 4K */

> >                       if (pf2vf_size > 0 && pf2vf_size < 4096) {

> > +                                   if (adev->virt.fw_reserve.p_pf2vf->=
version =3D=3D 2) {

> > +                                                 struct amdgim_pf2vf_i=
nfo_v2 *pf2vf_v2 =3D

> > NULL;

> > +

> > +                                                 pf2vf_v2 =3D (struct =
amdgim_pf2vf_info_v2

> > *)adev->virt.fw_reserve.p_pf2vf;

> > +                                                 bp_block_offset =3D (=
(uint64_t)pf2vf_v2-

> > >bp_block_offset_L & 0xFFFFFFFF) |

> > +                                                                      =
        ((((uint64_t)pf2vf_v2-

> > >bp_block_offset_H) << 32) & 0xFFFFFFFF00000000);

> > +                                                 bp_block_size =3D pf2=
vf_v2->bp_block_size;

> > +

> > +                                                 if (bp_block_size && =
!adev-

> > >virt.ras_init_done)

> > +

> >         amdgpu_virt_init_ras_err_handler_data(adev);

> > +

> > +                                                 amdgpu_virt_add_bad_p=
age(adev,

> > bp_block_offset, bp_block_size);

>

> [Tao] We can add "if (adev->virt.ras_init_done)" before it to skip add ba=
d

> page handle quickly in init failed case.

>

[Yang, Stanley] :

Yes, add this judgement is better.

>

> > +                                   }

> > +

> >                                      checkval =3D amdgpu_virt_fw_reserv=
e_get_checksum(

> >                                                    adev->virt.fw_reserv=
e.p_pf2vf, pf2vf_size,

> >                                                    adev->virt.fw_reserv=
e.checksum_key,

> > checksum); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h

> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h

> > index b90e822cebd7..f826945989c7 100644

> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h

> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h

> > @@ -143,19 +143,27 @@ struct  amdgim_pf2vf_info_v2 {

> >         uint32_t vce_enc_max_pixels_count;

> >         /* 16x16 pixels/sec, codec independent */

> >         uint32_t vce_enc_max_bandwidth;

> > +      /* Bad pages block position in BYTE */

> > +      uint32_t bp_block_offset_L;

> > +      uint32_t bp_block_offset_H;

> > +      /* Bad pages block size in BYTE */

> > +      uint32_t bp_block_size;

> >         /* MEC FW position in kb from the start of VF visible frame buf=
fer */

> > -       uint64_t mecfw_kboffset;

> > +      uint32_t mecfw_kboffset_L;

> > +      uint32_t mecfw_kboffset_H;

> >         /* MEC FW size in KB */

> >         uint32_t mecfw_ksize;

> >         /* UVD FW position in kb from the start of VF visible frame buf=
fer */

> > -       uint64_t uvdfw_kboffset;

> > +      uint32_t uvdfw_kboffset_L;

> > +      uint32_t uvdfw_kboffset_H;

> >         /* UVD FW size in KB */

> >         uint32_t uvdfw_ksize;

> >         /* VCE FW position in kb from the start of VF visible frame buf=
fer */

> > -       uint64_t vcefw_kboffset;

> > +      uint32_t vcefw_kboffset_L;

> > +      uint32_t vcefw_kboffset_H;

> >         /* VCE FW size in KB */

> >         uint32_t vcefw_ksize;

> > -       uint32_t reserved[AMDGIM_GET_STRUCTURE_RESERVED_SIZE(256,

> 0,

> > 0, (9 + sizeof(struct

> > amd_sriov_msg_pf2vf_info_header)/sizeof(uint32_t)), 3)];

> > +      uint32_t reserved[AMDGIM_GET_STRUCTURE_RESERVED_SIZE(256,

> 0,

> > 0, (18 +

> > +sizeof(struct amd_sriov_msg_pf2vf_info_header)/sizeof(uint32_t)),

> > +0)];

> >  } __aligned(4);

> >

> >

> > @@ -254,6 +262,17 @@ typedef struct amdgim_vf2pf_info_v2

> > amdgim_vf2pf_info ;

> >                       } \

> >         } while (0)

> >

> > +struct amdgpu_virt_ras_err_handler_data {

> > +      /* point to bad page records array */

> > +      struct eeprom_table_record *bps;

> > +      /* point to reserved bo array */

> > +      struct amdgpu_bo **bps_bo;

> > +      /* the count of entries */

> > +      int count;

> > +      /* last reserved entry's index + 1 */

> > +      int last_reserved;

> > +};

> > +

> >  /* GPU virtualization */

> >  struct amdgpu_virt {

> >         uint32_t                                          caps;

> > @@ -272,6 +291,8 @@ struct amdgpu_virt {

> >         uint32_t reg_access_mode;

> >         int req_init_data_ver;

> >         bool tdr_debug;

> > +      struct amdgpu_virt_ras_err_handler_data *virt_eh_data;

> > +      bool ras_init_done;

> >  };

> >

> >  #define amdgpu_sriov_enabled(adev) \

> > @@ -323,6 +344,7 @@ void amdgpu_virt_free_mm_table(struct

> > amdgpu_device *adev);  int amdgpu_virt_fw_reserve_get_checksum(void

> > *obj, unsigned long obj_size,

> >                                                                   unsig=
ned int key,

> >                                                                   unsig=
ned int chksum);

> > +void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device

> > +*adev);

> >  void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev);

> > void amdgpu_detect_virtualization(struct amdgpu_device *adev);

> >

> > --

> > 2.17.1

--_000_MWHPR12MB1837998F97D0D4F78B4DEFF59A860MWHPR12MB1837namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"MS PGothic",sans-serif;
	mso-fareast-language:JA;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:JA;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"MS PGothic",sans-serif;
	mso-fareast-language:JA;}
span.EmailStyle22
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#317100;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"msipheader251902e5" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Hi Tao,<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Thanks for your suggestion and reply inline.<o:p>=
</o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Regards,<o:p></o:p></p>
<p class=3D"MsoPlainText">Stanley<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; -----Original Message-----<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; From: Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<o=
:p></o:p></p>
<p class=3D"MsoPlainText">&gt; Sent: Friday, June 5, 2020 11:00 AM<o:p></o:=
p></p>
<p class=3D"MsoPlainText">&gt; To: Yang, Stanley &lt;Stanley.Yang@amd.com&g=
t;; amd-gfx@lists.freedesktop.org<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com=
&gt;; Chen, Guchun<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &lt;Guchun.Chen@amd.com&gt;; Liu, Monk &lt;M=
onk.Liu@amd.com&gt;; Clements,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; John &lt;John.Clements@amd.com&gt;; Li, Denn=
is &lt;Dennis.Li@amd.com&gt;; Yang,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; Stanley &lt;Stanley.Yang@amd.com&gt;<o:p></o=
:p></p>
<p class=3D"MsoPlainText">&gt; Subject: RE: [PATCH V2] drm/amdgpu: support =
reserve bad page for virt<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; [AMD Public Use]<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; -----Original Message-----<o:p></o:p></=
p>
<p class=3D"MsoPlainText">&gt; &gt; From: Stanley.Yang &lt;Stanley.Yang@amd=
.com&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; Sent: 2020<span lang=3D"ZH-CN" style=3D=
"font-family:DengXian;mso-fareast-language:ZH-CN">=1B$BG/=1B(B</span>6<span=
 lang=3D"ZH-CN" style=3D"font-family:DengXian;mso-fareast-language:ZH-CN">=
=1B$B7n=1B(B</span>4<span lang=3D"ZH-CN" style=3D"font-family:DengXian;mso-=
fareast-language:ZH-CN">=1B$BF|=1B(B</span>
 20:36<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; To: amd-gfx@lists.freedesktop.org<o:p><=
/o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; Cc: Zhang, Hawking &lt;Hawking.Zhang@am=
d.com&gt;; Chen, Guchun<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &lt;Guchun.Chen@amd.com&gt;; Liu, Monk =
&lt;Monk.Liu@amd.com&gt;; Clements,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; John<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &lt;John.Clements@amd.com&gt;; Zhou1, T=
ao &lt;Tao.Zhou1@amd.com&gt;; Li,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; Dennis<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &lt;Dennis.Li@amd.com&gt;; Yang, Stanle=
y &lt;Stanley.Yang@amd.com&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; Subject: [PATCH V2] drm/amdgpu: support=
 reserve bad page for virt<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; Changed from V1:<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rename same functions name, only init ras error handler data for<o:p></=
o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; supported asic.<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; Signed-off-by: Stanley.Yang &lt;Stanley=
.Yang@amd.com&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; Change-Id: Ia0ad9453ac3ac929f95c73cbee5=
b7a8fc42a9816<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; ---<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu=
_device.c |&nbsp;&nbsp; 3 &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu=
_virt.c&nbsp;&nbsp; | 172<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<o:p></o:=
p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu=
_virt.h&nbsp;&nbsp; |&nbsp; 30 &#43;&#43;&#43;-<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; 3 files changed, 201 insertions(&=
#43;), 4 deletions(-)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu=
/amdgpu_device.c<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev=
ice.c<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; index 1df28b7bf22e..668ad0e35160 100644=
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu=
_device.c<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_device.c<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; @@ -2326,6 &#43;2326,9 @@ static int am=
dgpu_device_ip_fini(struct<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; amdgpu_device *adev)&nbsp; {<o:p></o:p>=
</p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; int i, r;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(amdgpu_sriov_vf(adev) &amp;&amp; adev-&gt;virt.ras_init_done)<o:p></o:p></=
p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; amdgpu_virt_release_ras_err_handler_data(adev);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_ras_pre_fini(adev);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;gmc.xgmi.num_physical_nodes &gt; 1) diff --git<o:p></o:p><=
/p>
<p class=3D"MsoPlainText">&gt; &gt; a/drivers/gpu/drm/amd/amdgpu/amdgpu_vir=
t.c<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vir=
t.c<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; index bab9286021a7..174fcb8c8b57 100644=
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu=
_virt.c<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_virt.c<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; @@ -26,6 &#43;26,7 @@<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; #include &lt;drm/drm_drv.h&gt;<o:=
p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; #include &quot;amdgpu.h&quot;<o:p=
></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;#include &quot;amdgpu_ras.h&quot;<=
o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; bool amdgpu_virt_mmio_blocked(str=
uct amdgpu_device *adev)&nbsp; { @@ -<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; 255,12 &#43;256,169 @@ int amdgpu_virt_=
fw_reserve_get_checksum(void<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; *obj,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return ret;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;static int amdgpu_virt_init_ras_er=
r_handler_data(struct amdgpu_device<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;*adev) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_virt *virt =3D &amp;adev-&gt;virt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_virt_ras_err_handler_data **data =3D &amp;virt-<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &gt;virt_eh_data;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
GPU will be marked bad on host if bp count more then 10,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * s=
o alloc 512 is enough.<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<=
o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uns=
igned int align_space =3D 512;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; voi=
d *bps =3D NULL;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_bo **bps_bo =3D NULL;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *da=
ta =3D kmalloc(sizeof(struct amdgpu_virt_ras_err_handler_data),<o:p></o:p><=
/p>
<p class=3D"MsoPlainText">&gt; &gt; GFP_KERNEL);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!*data)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; return -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bps=
 =3D kmalloc(align_space * sizeof((*data)-&gt;bps), GFP_KERNEL);<o:p></o:p>=
</p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bps=
_bo =3D kmalloc(align_space * sizeof((*data)-&gt;bps_bo),<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; GFP_KERNEL);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!bps || !bps_bo) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; kfree(bps);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; kfree(bps_bo);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; return -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o=
:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*d=
ata)-&gt;bps =3D bps;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*d=
ata)-&gt;bps_bo =3D bps_bo;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*d=
ata)-&gt;count =3D 0;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*d=
ata)-&gt;last_reserved =3D 0;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vir=
t-&gt;ras_init_done =3D true;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn 0;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;}<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;static void amdgpu_virt_ras_releas=
e_bp(struct amdgpu_device *adev) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_virt *virt =3D &amp;adev-&gt;virt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_virt_ras_err_handler_data *data =3D virt-&gt;virt_eh_data;<o:p><=
/o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_bo *bo;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int=
 i;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!data)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; return;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for=
 (i =3D data-&gt;last_reserved - 1; i &gt;=3D 0; i--) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; bo =3D data-&gt;bps_bo[i];<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; amdgpu_bo_free_kernel(&amp;bo, NULL, NULL);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; data-&gt;bps_bo[i] =3D bo;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; data-&gt;last_reserved =3D i;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o=
:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;}<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;void amdgpu_virt_release_ras_err_h=
andler_data(struct amdgpu_device<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;*adev) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_virt *virt =3D &amp;adev-&gt;virt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_virt_ras_err_handler_data *data =3D virt-&gt;virt_eh_data;<o:p><=
/o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vir=
t-&gt;ras_init_done =3D false;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!data)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; return;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd=
gpu_virt_ras_release_bp(adev);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfr=
ee(data-&gt;bps);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfr=
ee(data-&gt;bps_bo);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfr=
ee(data);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vir=
t-&gt;virt_eh_data =3D NULL;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;}<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;static void amdgpu_virt_ras_add_bp=
s(struct amdgpu_device *adev,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; struct eeprom_table_record *bps, int pages) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_virt *virt =3D &amp;adev-&gt;virt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_virt_ras_err_handler_data *data =3D virt-&gt;virt_eh_data;<o:p><=
/o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!data)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; return;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem=
cpy(&amp;data-&gt;bps[data-&gt;count], bps, pages * sizeof(*data-&gt;bps));=
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dat=
a-&gt;count &#43;=3D pages;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;}<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;static void amdgpu_virt_ras_reserv=
e_bps(struct amdgpu_device *adev) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_virt *virt =3D &amp;adev-&gt;virt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_virt_ras_err_handler_data *data =3D virt-&gt;virt_eh_data;<o:p><=
/o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_bo *bo =3D NULL;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t64_t bp;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int=
 i;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!data)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; return;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for=
 (i =3D data-&gt;last_reserved; i &lt; data-&gt;count; i&#43;&#43;) {<o:p><=
/o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; bp =3D data-&gt;bps[i].retired_page;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; /* There are two cases of reserve error should be ignored:<o:p></o:p>=
</p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; * 1) a ras bad page has been allocated (used by someone);<o:p></o:p><=
/p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; * 2) a ras bad page has been reserved (duplicate error<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; injection<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; *&nbsp;&nbsp;&nbsp; for one page);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; */<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (amdgpu_bo_create_kernel_at(adev, bp &lt;&lt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; AMDGPU_GPU_PAGE_SHIFT,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 AMDGPU_GPU_PAGE_SIZE,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 AMDGPU_GEM_DOMAIN_VRAM,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 &amp;bo, NULL))<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;RAS WARN: [SRV-IO] reserve vram for<o:=
p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; retired page %llx<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;fail\n&quot;, bp);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; [Tao] SRIOV? Typo?<o:p></o:p></p>
<p class=3D"MsoPlainText">[Yang, Stanley] :<o:p></o:p></p>
<p class=3D"MsoPlainText">Will keep the same message with bare-metal accord=
ing to <a id=3D"OWAAM41939817802A441C8E6A57C990A966F1" href=3D"mailto:Hawki=
ng.Zhang@amd.com">
<span style=3D"font-family:&quot;Calibri&quot;,sans-serif;text-decoration:n=
one">@Zhang, Hawking</span></a>'s suggestion.<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; data-&gt;bps_bo[i] =3D bo;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; data-&gt;last_reserved =3D i &#43; 1;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; bo =3D NULL;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o=
:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;}<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;static bool amdgpu_virt_ras_check_=
bad_page(struct amdgpu_device<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; *adev,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; uint64_t retired_page)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;{<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_virt *virt =3D &amp;adev-&gt;virt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_virt_ras_err_handler_data *data =3D virt-&gt;virt_eh_data;<o:p><=
/o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int=
 i;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!data)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; return true;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for=
 (i =3D 0; i &lt; data-&gt;count; i&#43;&#43;)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (retired_page =3D=3D data-&gt;bps[i].retired_page)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return true;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn false;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;}<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;static void amdgpu_virt_add_bad_pa=
ge(struct amdgpu_device *adev,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; uint64_t bp_block_offset, uint32_t bp_block_size) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct eeprom_table_record bp;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t64_t retired_page;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t bp_idx, bp_cnt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(bp_block_size) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; bp_cnt =3D bp_block_size / sizeof(uint64_t);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; for (bp_idx =3D 0; bp_idx &lt; bp_cnt; bp_idx&#43;&#43;) {<o:p></o:p>=
</p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; retired_page =3D *(uint64_t *)(adev-<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &gt;fw_vram_usage.va &#43;<o:p></o:p></=
p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp_block_offset &#43; bp_idx *<o:p><=
/o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; sizeof(uint64_t));<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; bp.retired_page =3D retired_page;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (amdgpu_virt_ras_check_bad_page(adev,<o:p></o:p></p=
>
<p class=3D"MsoPlainText">&gt; &gt; retired_page))<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; amdgpu_virt_ras_add_bps(adev, &amp;bp, 1);<o:p></o:p><=
/p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; amdgpu_virt_ras_reserve_bps(adev);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o=
:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;}<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; void amdgpu_virt_init_data_exchan=
ge(struct amdgpu_device *adev)&nbsp; {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t pf2vf_size =3D 0;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t checksum =3D 0;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t checkval;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; char *str;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t64_t bp_block_offset =3D 0;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t bp_block_size =3D 0;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;virt.fw_reserve.p_pf2vf =3D NULL;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;virt.fw_reserve.p_vf2pf =3D NULL; @@ -275,6 &#43;433,20 @@ voi=
d<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; amdgpu_virt_init_data_exchange(struct<o=
:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; /* pf2vf message must be in 4K */<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (pf2vf_size &gt; 0 &amp;&amp; pf2vf_size &lt; 4096) {<o:p><=
/o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (adev-&gt;virt.fw_reserve.p_pf2vf-&gt;version =3D=
=3D 2) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgim_pf2vf_info_v2 *pf2vf_v2 =3D<o:p=
></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; NULL;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pf2vf_v2 =3D (struct amdgim_pf2vf_info_v2<o:p=
></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; *)adev-&gt;virt.fw_reserve.p_pf2vf;<o:p=
></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp_block_offset =3D ((uint64_t)pf2vf_v2-<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &gt;bp_block_offset_L &amp; 0xFFFFFFFF)=
 |<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((((uint64_t)pf2vf_v2=
-<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &gt;bp_block_offset_H) &lt;&lt; 32) &am=
p; 0xFFFFFFFF00000000);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp_block_size =3D pf2vf_v2-&gt;bp_block_size;=
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bp_block_size &amp;&amp; !adev-<o:p></o:p=
></p>
<p class=3D"MsoPlainText">&gt; &gt; &gt;virt.ras_init_done)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_virt_init_ras_err_handler_data(adev);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_virt_add_bad_page(adev,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; bp_block_offset, bp_block_size);<o:p></=
o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; [Tao] We can add &quot;if (adev-&gt;virt.ras=
_init_done)&quot; before it to skip add bad<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; page handle quickly in init failed case.<o:p=
></o:p></p>
<p class=3D"MsoPlainText">&gt;<o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">[Yang, Stanley] :<o:p></o:p></p>
<p class=3D"MsoPlainText">Yes, add this judgement is better.<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; checkval =3D amdgpu_virt_fw_reserve_get_checksu=
m(<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.fw_reserve.p_pf2vf, pf2v=
f_size,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.fw_reserve.checksum_key,=
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; checksum); diff --git a/drivers/gpu/drm=
/amd/amdgpu/amdgpu_virt.h<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vir=
t.h<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; index b90e822cebd7..f826945989c7 100644=
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu=
_virt.h<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_virt.h<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; @@ -143,19 &#43;143,27 @@ struct&nbsp; =
amdgim_pf2vf_info_v2 {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t vce_enc_max_pixels_count;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* 16x16 pixels/sec, codec independent */<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t vce_enc_max_bandwidth;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Bad pages block position in BYTE */<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t bp_block_offset_L;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t bp_block_offset_H;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Bad pages block size in BYTE */<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t bp_block_size;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* MEC FW position in kb from the start of VF visible frame buffer */<o=
:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int64_t mecfw_kboffset;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t mecfw_kboffset_L;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t mecfw_kboffset_H;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* MEC FW size in KB */<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t mecfw_ksize;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* UVD FW position in kb from the start of VF visible frame buffer */<o=
:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int64_t uvdfw_kboffset;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t uvdfw_kboffset_L;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t uvdfw_kboffset_H;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* UVD FW size in KB */<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t uvdfw_ksize;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* VCE FW position in kb from the start of VF visible frame buffer */<o=
:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int64_t vcefw_kboffset;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t vcefw_kboffset_L;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t vcefw_kboffset_H;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* VCE FW size in KB */<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t vcefw_ksize;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t reserved[AMDGIM_GET_STRUCTURE_RESERVED_SIZE(256,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; 0,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; 0, (9 &#43; sizeof(struct<o:p></o:p></p=
>
<p class=3D"MsoPlainText">&gt; &gt; amd_sriov_msg_pf2vf_info_header)/sizeof=
(uint32_t)), 3)];<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t reserved[AMDGIM_GET_STRUCTURE_RESERVED_SIZE(256,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; 0,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; 0, (18 &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;sizeof(struct amd_sriov_msg_pf2vf_=
info_header)/sizeof(uint32_t)),<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;0)];<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; } __aligned(4);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; @@ -254,6 &#43;262,17 @@ typedef struct=
 amdgim_vf2pf_info_v2<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; amdgim_vf2pf_info ;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; } \<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } while (0)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;struct amdgpu_virt_ras_err_handler=
_data {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
point to bad page records array */<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct eeprom_table_record *bps;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
point to reserved bo array */<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_bo **bps_bo;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
the count of entries */<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int=
 count;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
last reserved entry's index &#43; 1 */<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int=
 last_reserved;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;};<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; /* GPU virtualization */<o:p></o:=
p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; struct amdgpu_virt {<o:p></o:p></=
p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; caps;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; @@ -272,6 &#43;291,8 @@ struct amdgpu_v=
irt {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t reg_access_mode;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; int req_init_data_ver;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; bool tdr_debug;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_virt_ras_err_handler_data *virt_eh_data;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; boo=
l ras_init_done;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; };<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; #define amdgpu_sriov_enabled(adev=
) \<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; @@ -323,6 &#43;344,7 @@ void amdgpu_vir=
t_free_mm_table(struct<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; amdgpu_device *adev);&nbsp; int amdgpu_=
virt_fw_reserve_get_checksum(void<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; *obj, unsigned long obj_size,<o:p></o:p=
></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int key,<o:p><=
/o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int chksum);<o=
:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;void amdgpu_virt_release_ras_err_h=
andler_data(struct amdgpu_device<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; &#43;*adev);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;&nbsp; void amdgpu_virt_init_data_exchan=
ge(struct amdgpu_device *adev);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; void amdgpu_detect_virtualization(struc=
t amdgpu_device *adev);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; --<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt; 2.17.1<o:p></o:p></p>
</div>
</body>
</html>

--_000_MWHPR12MB1837998F97D0D4F78B4DEFF59A860MWHPR12MB1837namp_--

--===============1052776192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1052776192==--
