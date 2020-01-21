Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96604C32771
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 02:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 637D824656
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 02:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Fe4bUoXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637D824656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26F0A6EB72;
	Tue, 21 Jan 2020 02:23:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 728E96EB72
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 02:23:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuZWjDHr5es8U3WMXvKsABtpmSbLH1Sn1mof5Xru/djYlY2z5NTiHa683AlHWxRy1M4k2UQlKOU6BPA0AqsKLFyTEkYaFS01mwwgWBzYaoUr++HLECE+mx/HnORtw70dJ9H/pT47sD7Hu/fvz2ryUcYjxvexY1QMuqoOEAVeXliFbVIkTRPq1zinM8ywbRXUOjrZ7ycxAvOE8noqew0GPKQ99X8L/LRbtp1PxkCwOCYDZdyfvj/uJo8Ywu3YBvfksAvQXeVwjUpN73+wEqnX8UT6E1ZTABT6zR+K8Rdtdba57KdJk7chwynpCRzqLfCitTiCq9rlp87MF778rOAVxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XObDMhBgLOkBBMHFizBaFGICTfVuhHJmmKHldmfjnc=;
 b=MLq5C+J9MJVf+Xx8Cvlo163SuV6OzMSuLcPhhNsvWl2r17EXyj6hmNGJ1ECkl75dZtQSA1bLcct8TrjrBlmv1OZQnPPaUl0Uv1ftTWUSII1wRdoX4+yhrinEpRVI02/sL7+YH71q3NuWOPrabrLeZN1ynsbBy9jrlnaUy/iWyEPYRrr1U4IkWYVxu5Yrwno/yejyD2V193lXeFf1E4MRZXd+t0HMuvPbvVrx8zB8tqwZKtEA2PMEruEJ7QUxeUe9MPPU8bkaZZJ6yoMUuZ+LUxr2NG2aQ2KYRHiAqqemOHniZR5MktBeTYdokEtpoZzpKq0L64Z8iAHr/Wr3sNcPoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XObDMhBgLOkBBMHFizBaFGICTfVuhHJmmKHldmfjnc=;
 b=Fe4bUoXvhF0ihpRyZKcc6SXyWw2wDOVsSiMx9X43sPxKC/V3Cy3WqOccJd/a/U5N03WU1+EL+ACiG2nBaido/etV/qGm+iMNvNXqWSBdf3cjCZ5mEJxsO5j0hHzSv/iypxM8lSUv2iqWHk2S5FRSoZzcNQaRNujHZbxqWERhnfM=
Received: from MN2PR12MB2957.namprd12.prod.outlook.com (20.179.82.14) by
 MN2PR12MB4190.namprd12.prod.outlook.com (52.135.51.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Tue, 21 Jan 2020 02:23:22 +0000
Received: from MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2cbe:ce2:60b5:7756]) by MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2cbe:ce2:60b5:7756%6]) with mapi id 15.20.2644.024; Tue, 21 Jan 2020
 02:23:22 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix VRAM partially encroached issue in
 GDDR6 memory training
Thread-Topic: [PATCH 2/2] drm/amdgpu: fix VRAM partially encroached issue in
 GDDR6 memory training
Thread-Index: AQHVz4H2ro+tKcjpG0S/afsji891bqfzct6AgADvC+8=
Date: Tue, 21 Jan 2020 02:23:21 +0000
Message-ID: <MN2PR12MB2957C40B327A3B48523BBEBE950D0@MN2PR12MB2957.namprd12.prod.outlook.com>
References: <20200120110822.30163-1-tianci.yin@amd.com>
 <20200120110822.30163-2-tianci.yin@amd.com>,
 <d2cf1e77-9d4a-229a-95e9-bc47b7f89389@gmail.com>
In-Reply-To: <d2cf1e77-9d4a-229a-95e9-bc47b7f89389@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-21T02:23:21.389Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianci.Yin@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 08175e24-46f5-46f6-d82a-08d79e18e311
x-ms-traffictypediagnostic: MN2PR12MB4190:|MN2PR12MB4190:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB41902F8F95C17F2BF4F100B6950D0@MN2PR12MB4190.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(189003)(199004)(110136005)(54906003)(66476007)(316002)(66946007)(86362001)(91956017)(76116006)(66556008)(66446008)(2906002)(186003)(64756008)(55016002)(81166006)(9686003)(52536014)(8936002)(5660300002)(8676002)(26005)(81156014)(7696005)(6506007)(53546011)(478600001)(33656002)(4326008)(66574012)(71200400001)(19627405001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4190;
 H:MN2PR12MB2957.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n817kGUmuyzpJ9Tzall0s9KLUVSQl2/ASw4Ti+V25AwOS1z/3lTtn0j8p9b3FjGfjC1JRidsHRxcCJcW/px8vGZJtD4MaL6zjH4YPkFa7ga18/eRpiX52z8h7E+lp/jgdh5LJzSIwf1QlBATN0DrqWCS77b5ca6DrgCXk5qSeiQqhk6e/wJXP3xLjmEwvX1IT9Dwp6yW9eNQjRwlKkvpgFMwPvd75biI4YHajVcxk8x+EeMr3/imkl4pFDrTC5Jjehb+klbunMY1215/RnWQxmCWGjWdNGag1yn8gz0kr4YJIY9F7GMZrR9sCn0c+Q8CskTrDhJhkxhdEvdPQzXyY71Q5vZa+DdNsWXdo0xqVnHO7wsNUsnsq/f2+CVxDEARqsFs/nW8hLo0bU68iYDbG9xMPPXpQ6bKg88oSR5Vo/uUXEor0t2bDZNop82O67WL
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08175e24-46f5-46f6-d82a-08d79e18e311
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 02:23:21.9927 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mTvUIbmxveuidP/gW5nT60QJx8TXn/lIvwKecGCVh8hqcvwA8o6Jm25VKiQI04evEB9SmZ2pWfnPAqQceLZa3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang, 
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0740020854=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0740020854==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB2957C40B327A3B48523BBEBE950D0MN2PR12MB2957namp_"

--_000_MN2PR12MB2957C40B327A3B48523BBEBE950D0MN2PR12MB2957namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Thanks very much Christian!

Please review again.

Rico
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Monday, January 20, 2020 19:58
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Long, Gang <Gang.Long@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, K=
evin(Yang) <Kevin1.Wang@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Deu=
cher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@=
amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Yuan, Xiaojie <Xiao=
jie.Yuan@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix VRAM partially encroached issue in=
 GDDR6 memory training

Am 20.01.20 um 12:08 schrieb Tianci Yin:
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

You need to re-order the patches, this one should come first and the
other one last.

One more style nit pick below.

>
> Change-Id: I04a8a6e8e63b3619f7c693fe67883b229cbf3c53
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 ++
>   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 32 ++++++++++++++++++++++++-
>   2 files changed, 33 insertions(+), 1 deletion(-)
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
> index 685dd9754c67..51011b661ba8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -972,7 +972,10 @@ static int psp_v11_0_memory_training_init(struct psp=
_context *psp)
>   static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t =
ops)
>   {
>        int ret;
> +     void *buf;
> +     uint32_t sz;
>        uint32_t p2c_header[4];
> +     struct amdgpu_device *adev =3D psp->adev;
>        struct psp_memory_training_context *ctx =3D &psp->mem_train_ctx;
>        uint32_t *pcache =3D (uint32_t*)ctx->sys_cache;

In general it is preferred to order the lines in reverse xmas tree.

E.g. long lines with pre-initializes variables such as adev, ctx, pcache
first. And temporary stuff like i, ret, buf etc last.

Apart from that this looks good to me,
Christian.

>
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


--_000_MN2PR12MB2957C40B327A3B48523BBEBE950D0MN2PR12MB2957namp_
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
Thanks very much Christian! <br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Please review again.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Rico<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Monday, January 20, 2020 19:58<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Long, Gang &lt;Gang.Long@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@a=
md.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; Tuikov, Luben &l=
t;Luben.Tuikov@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.co=
m&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Koenig, Christian
 &lt;Christian.Koenig@amd.com&gt;; Yuan, Xiaojie &lt;Xiaojie.Yuan@amd.com&g=
t;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: fix VRAM partially encroached i=
ssue in GDDR6 memory training</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 20.01.20 um 12:08 schrieb Tianci Yin:<br>
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
<br>
You need to re-order the patches, this one should come first and the <br>
other one last.<br>
<br>
One more style nit pick below.<br>
<br>
&gt;<br>
&gt; Change-Id: I04a8a6e8e63b3619f7c693fe67883b229cbf3c53<br>
&gt; Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |&nbsp; 2 &#43;&#4=
3;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/psp_v11_0.c&nbsp; | 32 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&gt;&nbsp;&nbsp; 2 files changed, 33 insertions(&#43;), 1 deletion(-)<br>
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
&gt; index 685dd9754c67..51011b661ba8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
&gt; @@ -972,7 &#43;972,10 @@ static int psp_v11_0_memory_training_init(str=
uct psp_context *psp)<br>
&gt;&nbsp;&nbsp; static int psp_v11_0_memory_training(struct psp_context *p=
sp, uint32_t ops)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; void *buf;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sz;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t p2c_header[4];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D psp-&gt;a=
dev;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_memory_training_c=
ontext *ctx =3D &amp;psp-&gt;mem_train_ctx;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *pcache =3D (uint32=
_t*)ctx-&gt;sys_cache;<br>
<br>
In general it is preferred to order the lines in reverse xmas tree.<br>
<br>
E.g. long lines with pre-initializes variables such as adev, ctx, pcache <b=
r>
first. And temporary stuff like i, ret, buf etc last.<br>
<br>
Apart from that this looks good to me,<br>
Christian.<br>
<br>
&gt;&nbsp;&nbsp; <br>
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

--_000_MN2PR12MB2957C40B327A3B48523BBEBE950D0MN2PR12MB2957namp_--

--===============0740020854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0740020854==--
