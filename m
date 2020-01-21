Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1765CC2D0CE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 10:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C23A120882
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 10:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jn4WhBHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23A120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 915396E218;
	Tue, 21 Jan 2020 10:21:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50CF56E218
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 10:21:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Es4zHI/eNdiaSXweMnQRx4fzU4QBHx/sBYJ1Sl+bvsK0Ngbzfq9jXKJTQoiAqbdmn06qUHm26LIKNBuNx0s2mi1eAZkidUiCLElPsmoIT6LxLGxgcBy3wYhc/vQh4uNs347KTFZ7LmBz6yg1g2N0UCbMl+aXjxKIbP+rSmoLgPTVsfVxwOY2z3hu9qIXoyyv3KlVCQP3VAisn1ukSiU0k9VTpBwwg0FzdqUta8fvDTRatVsRWpRQKRlzp+OVcyDxQwDUsj9IEVDwrnktTgQRsvdjKESZ1sEJCBDYgIr2h01QoQBBmd8lL42sSJKQKCruchD6DVGV3KSaiZFKVyyzwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIifjH0ibFQ5FUOFhvfrR+8UEJPlvMeikrnxB5IkIp0=;
 b=eCBBGDfy9L/JxH2Ql/wG4sQwBBHIMzFzYk0dO4G8/5pKlztAgLe1efJMNWjOc9eoCkdePG8qFmDqcoSDjvz3SFqLKJKDLW9yfYIkDpfaYRBfuzymW3yIWs8dvwQQczjsvNj9CuLTjBHSpJxnRzUtMasGiSKQozOFYXQxWLUp8/exHJMzlHWRMc6LaDG5aoaUjpLpx0aodseQJIkAicP75cfX7HIXlznYmyBXs4543godTppg8RG8kN7cu77vGRb/6NnZkzRRnz+vVaife5KJallIsMAthfUIglPOf1k3EqpD/YUSOwXQYcQcJZHQG5JLog3Sv8f3yg4tPQ94Y3tqnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIifjH0ibFQ5FUOFhvfrR+8UEJPlvMeikrnxB5IkIp0=;
 b=jn4WhBHNdynzHjSpBF6/hESfBQGJ+JzUPD9ZJsf8QHtKMwUQO82C49WmnQwKomrvzChSvkzyzieiwXyG4+okA41vFsuK3OtpqYZYDSA6DhDumUlopsHf0G1EoqGmBVXoFmN+3KXonOgvlHI6ypUmL8ov0L+NMbcPkygVrLXHNVY=
Received: from MN2PR12MB2957.namprd12.prod.outlook.com (20.179.82.14) by
 MN2PR12MB3677.namprd12.prod.outlook.com (10.255.86.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Tue, 21 Jan 2020 10:21:15 +0000
Received: from MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2cbe:ce2:60b5:7756]) by MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2cbe:ce2:60b5:7756%6]) with mapi id 15.20.2644.024; Tue, 21 Jan 2020
 10:21:15 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix VRAM partially encroached issue in
 GDDR6 memory training(V2)
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix VRAM partially encroached issue in
 GDDR6 memory training(V2)
Thread-Index: AQHV0AGaowUFp9NBG0OIIGBEn2KzMKf0BxgAgADh290=
Date: Tue, 21 Jan 2020 10:21:14 +0000
Message-ID: <MN2PR12MB2957285339A3AC4D42DA54DF950D0@MN2PR12MB2957.namprd12.prod.outlook.com>
References: <20200121022206.5223-1-tianci.yin@amd.com>,
 <b4f70898-0d48-f09a-046f-d312082432f6@amd.com>
In-Reply-To: <b4f70898-0d48-f09a-046f-d312082432f6@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-21T10:21:13.986Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianci.Yin@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2558354c-dc77-46f7-031b-08d79e5ba595
x-ms-traffictypediagnostic: MN2PR12MB3677:|MN2PR12MB3677:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3677B4946A9D077EF973A524950D0@MN2PR12MB3677.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(189003)(199004)(7696005)(186003)(8936002)(54906003)(4326008)(66574012)(81166006)(316002)(2906002)(110136005)(66446008)(33656002)(478600001)(66556008)(52536014)(9686003)(6506007)(53546011)(64756008)(66476007)(55016002)(26005)(86362001)(19627405001)(8676002)(66946007)(81156014)(71200400001)(91956017)(5660300002)(76116006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3677;
 H:MN2PR12MB2957.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IrEnCkmdfqkEq0/vp+mRuJ0GGL2xJElT+kWOy19ShVnOiEZ5OJaOXJILjjEo5fOh4ALNQDUXk2T7/8CKeutB+ekE6QYcxEkY7zqnNEY6DKnEPlz/0JCqiYrL/aMrqDEBeymO/gu9aJ0mKfOeLsGPm3hmxAd2Rmgr7pxlty9q9vK6RuU+I+Ml0aocCys9X86hWO6QiDuFarO0IC2zBO9QuWy+9YvzQlCbx2bGQuMSTIQY5seAhBRB0/fKD+fpmk0e8PiYin959d2j3z7Z7UOgzdI6ZPJjzif48czh/XPgth88OjBl4hwUwnwjCqnrBQ+cYwsHIc//gM6LCpYxh1Xbm7YFU7Okpmjf3AJw0zhD6cQ2toRxDmUUV3SRaERXlLaLZtzRoLg0ZHTPR+yuEtVwP2UqmbVqVID852TwI9VlWM/T8Ael8xceodkkPsxx5UE1
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2558354c-dc77-46f7-031b-08d79e5ba595
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 10:21:14.7156 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CnJFbMHXAZdrkqgUMaRN375dJVpowJb4wVVxzJWOusUmMIYysLnQeYGQO9L0qBe08rARRdsQxDAoAVVCGB7Fyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3677
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
Content-Type: multipart/mixed; boundary="===============1280115311=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1280115311==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB2957285339A3AC4D42DA54DF950D0MN2PR12MB2957namp_"

--_000_MN2PR12MB2957285339A3AC4D42DA54DF950D0MN2PR12MB2957namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Thanks very much Christian!
________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Tuesday, January 21, 2020 4:52
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.X=
u@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>; Long, Gang <Gang.Long@amd=
.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix VRAM partially encroached issue in=
 GDDR6 memory training(V2)

Am 21.01.20 um 03:22 schrieb Tianci Yin:
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> [why]
> In GDDR6 BIST training, a certain mount of bottom VRAM will be encroached=
 by
> UMC, that causes problems(like GTT corrupted and page fault observed).
>
> [how]
> Saving the content of this bottom VRAM to system memory before training, =
and
> restoring it after training to avoid VRAM corruption.
>
> Change-Id: I04a8a6e8e63b3619f7c693fe67883b229cbf3c53
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>

Acked-by: Christian K=F6nig <christian.koenig@amd.com> for this one and
Reviewed-by: Christian K=F6nig <christian.koenig@amd.com> for patch #2.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 ++
>   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 36 ++++++++++++++++++++++---
>   2 files changed, 35 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.h
> index 3265487b859f..611021514c52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -172,6 +172,8 @@ struct psp_dtm_context {
>   #define MEM_TRAIN_SYSTEM_SIGNATURE          0x54534942
>   #define GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES       0x1000
>   #define GDDR6_MEM_TRAINING_OFFSET           0x8000
> +/*Define the VRAM size that will be encroached by BIST training.*/
> +#define GDDR6_MEM_TRAINING_ENCROACHED_SIZE   0x2000000
>
>   enum psp_memory_training_init_flag {
>        PSP_MEM_TRAIN_NOT_SUPPORT       =3D 0x0,
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/psp_v11_0.c
> index 685dd9754c67..ac173d2eb809 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -971,10 +971,13 @@ static int psp_v11_0_memory_training_init(struct ps=
p_context *psp)
>    */
>   static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t =
ops)
>   {
> -     int ret;
> -     uint32_t p2c_header[4];
>        struct psp_memory_training_context *ctx =3D &psp->mem_train_ctx;
>        uint32_t *pcache =3D (uint32_t*)ctx->sys_cache;
> +     struct amdgpu_device *adev =3D psp->adev;
> +     uint32_t p2c_header[4];
> +     uint32_t sz;
> +     void *buf;
> +     int ret;
>
>        if (ctx->init =3D=3D PSP_MEM_TRAIN_NOT_SUPPORT) {
>                DRM_DEBUG("Memory training is not supported.\n");
> @@ -989,7 +992,7 @@ static int psp_v11_0_memory_training(struct psp_conte=
xt *psp, uint32_t ops)
>                return 0;
>        }
>
> -     amdgpu_device_vram_access(psp->adev, ctx->p2c_train_data_offset, p2=
c_header, sizeof(p2c_header), false);
> +     amdgpu_device_vram_access(adev, ctx->p2c_train_data_offset, p2c_hea=
der, sizeof(p2c_header), false);
>        DRM_DEBUG("sys_cache[%08x,%08x,%08x,%08x] p2c_header[%08x,%08x,%08=
x,%08x]\n",
>                  pcache[0], pcache[1], pcache[2], pcache[3],
>                  p2c_header[0], p2c_header[1], p2c_header[2], p2c_header[=
3]);
> @@ -1026,11 +1029,38 @@ static int psp_v11_0_memory_training(struct psp_c=
ontext *psp, uint32_t ops)
>        DRM_DEBUG("Memory training ops:%x.\n", ops);
>
>        if (ops & PSP_MEM_TRAIN_SEND_LONG_MSG) {
> +             /*
> +              * Long traing will encroach certain mount of bottom VRAM,
> +              * saving the content of this bottom VRAM to system memory
> +              * before training, and restoring it after training to avoi=
d
> +              * VRAM corruption.
> +              */
> +             sz =3D GDDR6_MEM_TRAINING_ENCROACHED_SIZE;
> +
> +             if (adev->gmc.visible_vram_size < sz || !adev->mman.aper_ba=
se_kaddr) {
> +                     DRM_ERROR("visible_vram_size %llx or aper_base_kadd=
r %p is not initialized.\n",
> +                               adev->gmc.visible_vram_size,
> +                               adev->mman.aper_base_kaddr);
> +                     return -EINVAL;
> +             }
> +
> +             buf =3D vmalloc(sz);
> +             if (!buf) {
> +                     DRM_ERROR("failed to allocate system memory.\n");
> +                     return -ENOMEM;
> +             }
> +
> +             memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
>                ret =3D psp_v11_0_memory_training_send_msg(psp, PSP_BL__DR=
AM_LONG_TRAIN);
>                if (ret) {
>                        DRM_ERROR("Send long training msg failed.\n");
> +                     vfree(buf);
>                        return ret;
>                }
> +
> +             memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
> +             adev->nbio.funcs->hdp_flush(adev, NULL);
> +             vfree(buf);
>        }
>
>        if (ops & PSP_MEM_TRAIN_SAVE) {


--_000_MN2PR12MB2957285339A3AC4D42DA54DF950D0MN2PR12MB2957namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks very much Christian!<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Tuesday, January 21, 2020 4:52<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&=
gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Yuan, Xiaojie &lt;Xiaojie.Yuan@a=
md.com&gt;; Long, Gang &lt;Gang.Long@amd.com&gt;; Wang, Kevin(Yang)
 &lt;Kevin1.Wang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: fix VRAM partially encroached i=
ssue in GDDR6 memory training(V2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 21.01.20 um 03:22 schrieb Tianci Yin:<br>
&gt; From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
&gt;<br>
&gt; [why]<br>
&gt; In GDDR6 BIST training, a certain mount of bottom VRAM will be encroac=
hed by<br>
&gt; UMC, that causes problems(like GTT corrupted and page fault observed).=
<br>
&gt;<br>
&gt; [how]<br>
&gt; Saving the content of this bottom VRAM to system memory before trainin=
g, and<br>
&gt; restoring it after training to avoid VRAM corruption.<br>
&gt;<br>
&gt; Change-Id: I04a8a6e8e63b3619f7c693fe67883b229cbf3c53<br>
&gt; Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
<br>
Acked-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt; for this one a=
nd <br>
Reviewed-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt; for patch #=
2.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |&nbsp; 2 &#43;&#4=
3;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/psp_v11_0.c&nbsp; | 36 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;---<br>
&gt;&nbsp;&nbsp; 2 files changed, 35 insertions(&#43;), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_psp.h<br>
&gt; index 3265487b859f..611021514c52 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
&gt; @@ -172,6 &#43;172,8 @@ struct psp_dtm_context {<br>
&gt;&nbsp;&nbsp; #define MEM_TRAIN_SYSTEM_SIGNATURE&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x54534942<br>
&gt;&nbsp;&nbsp; #define GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 0x1000<br>
&gt;&nbsp;&nbsp; #define GDDR6_MEM_TRAINING_OFFSET&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8000<br>
&gt; &#43;/*Define the VRAM size that will be encroached by BIST training.*=
/<br>
&gt; &#43;#define GDDR6_MEM_TRAINING_ENCROACHED_SIZE&nbsp;&nbsp; 0x2000000<=
br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; enum psp_memory_training_init_flag {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PSP_MEM_TRAIN_NOT_SUPPORT&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x0,<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/=
amd/amdgpu/psp_v11_0.c<br>
&gt; index 685dd9754c67..ac173d2eb809 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
&gt; @@ -971,10 &#43;971,13 @@ static int psp_v11_0_memory_training_init(st=
ruct psp_context *psp)<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; static int psp_v11_0_memory_training(struct psp_context *p=
sp, uint32_t ops)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t p2c_header[4];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_memory_training_c=
ontext *ctx =3D &amp;psp-&gt;mem_train_ctx;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *pcache =3D (uint32=
_t*)ctx-&gt;sys_cache;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D psp-&gt;a=
dev;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t p2c_header[4];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sz;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; void *buf;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ctx-&gt;init =3D=3D PSP_=
MEM_TRAIN_NOT_SUPPORT) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;Memory training is not supported.\n&quo=
t;);<br>
&gt; @@ -989,7 &#43;992,7 @@ static int psp_v11_0_memory_training(struct ps=
p_context *psp, uint32_t ops)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_vram_access(psp-&gt;adev, ctx-=
&gt;p2c_train_data_offset, p2c_header, sizeof(p2c_header), false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_vram_access(adev, ctx-&gt;=
p2c_train_data_offset, p2c_header, sizeof(p2c_header), false);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;sys_cache[%0=
8x,%08x,%08x,%08x] p2c_header[%08x,%08x,%08x,%08x]\n&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcache[0], pcache[1], pcache[2], pcache[3],=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p2c_header[0], p2c_header[1], p2c_header[2]=
, p2c_header[3]);<br>
&gt; @@ -1026,11 &#43;1029,38 @@ static int psp_v11_0_memory_training(struc=
t psp_context *psp, uint32_t ops)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;Memory train=
ing ops:%x.\n&quot;, ops);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ops &amp; PSP_MEM_TRAIN_=
SEND_LONG_MSG) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /*<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * Long traing will encroach certain mount of bottom VRAM,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * saving the content of this bottom VRAM to system memory<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * before training, and restoring it after training to avoid<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * VRAM corruption.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; sz =3D GDDR6_MEM_TRAINING_ENCROACHED_SIZE;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (adev-&gt;gmc.visible_vram_size &lt; sz || !adev-&gt;mman.aper_b=
ase_kaddr) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;vis=
ible_vram_size %llx or aper_base_kaddr %p is not initialized.\n&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.visible_vram_size,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mman.aper_base_kaddr);<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; buf =3D vmalloc(sz);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (!buf) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;fai=
led to allocate system memory.\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; memcpy_fromio(buf, adev-&gt;mman.aper_base_kaddr, sz);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D psp_v11_0_memory_training_send_msg(psp, PSP_BL_=
_DRAM_LONG_TRAIN);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERR=
OR(&quot;Send long training msg failed.\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vfree(buf);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; memcpy_toio(adev-&gt;mman.aper_base_kaddr, buf, sz);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;nbio.funcs-&gt;hdp_flush(adev, NULL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; vfree(buf);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ops &amp; PSP_MEM_TRAIN_=
SAVE) {<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB2957285339A3AC4D42DA54DF950D0MN2PR12MB2957namp_--

--===============1280115311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1280115311==--
