Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3766AC33C9E
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 03:07:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2F8C2067D
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 03:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3c5KF/cP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F8C2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8295A6E37F;
	Thu,  9 Jan 2020 03:07:11 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700045.outbound.protection.outlook.com [40.107.70.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 022F46E37F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 03:07:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyzIADlrd7bjhAUf052+JmKlqXZ6zyGoYAOQz8XqRGeYMQghtoBCSUTrPs1nKaz/Xs+pgH+OetrGEyVdFeVYtejRI4PzGb/rvv95q/5oYX5PT7CXsnk+yE4yPNZp2sJCnPJvY0b/hbmMrrsJ/uHXjEzBdehqrvj1aGmOkqjywpdDp1NFFSZYcb3d0PhybknSMTBygqvBUHU9HTwprnDX+UkFXt2cQsCSkpySQKIjhtTI6TbbPXdJoGjCkTsz5nlUnbiRUWqw59BQq7NocJhOThwPqbbXBbS/BNSpkj4L9yzbo5RzvzdGNpbKQQRtn3uBo1mHXRsT2aXPCa2ExTez6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1eDW3Sa3Q7RzPFSBkT4M66bdqwlzIdELaHnDYEIppw=;
 b=RHHX+GxoNJPsO8/A0Mj2T0d1GzKEQ8MYx5KvI6VifA/uD/X0lfFfYmzU6/KtfpnjRUIBqEOfhUSnEEeUpFEZnxB5SlB8w4zExlk4Abdkbc/8qXc3B3SG9nRBFdNUrOGfME3E5aMUGkqkf48x1we4zU5nR2bg8JT/rH4VmX0YNLWsfVa4L+yxg+EhJqTkzJwRTWaR7mbMOBJ8y45JpgIWq/mgWRLip1ikGJ3H7BCa6+xw2KT2jo4iku02ph2dyW0aSeI/UYmjZU3zP6z0XX4shljOVWr28S9AZMR1BFnwb9axY5v4Gb8d7fcSn7Zgh4prJQ+gMe8MYqANJfM/Y0L6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1eDW3Sa3Q7RzPFSBkT4M66bdqwlzIdELaHnDYEIppw=;
 b=3c5KF/cPTFkCXZ8jJZKwSjmjWNivYxqrzekimcO9VujNaCfMHCzFVlrcTUWFRGP2mArMKAZBmZqjH2TjzXfMSJtl3AiJbBZI7oQNkA828+i6gAVAzXePOb5tDuj0M2oCFGEQQ1AFXts37BKUi6WdTqCfS/K8NpC+FvbSDkkak1Q=
Received: from MN2PR12MB2957.namprd12.prod.outlook.com (20.179.82.14) by
 MN2PR12MB3597.namprd12.prod.outlook.com (20.178.243.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 9 Jan 2020 03:07:06 +0000
Received: from MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2cbe:ce2:60b5:7756]) by MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2cbe:ce2:60b5:7756%6]) with mapi id 15.20.2623.010; Thu, 9 Jan 2020
 03:07:06 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix modprobe failure of the 2nd GPU when
 GDDR6 training enabled
Thread-Topic: [PATCH] drm/amdgpu: fix modprobe failure of the 2nd GPU when
 GDDR6 training enabled
Thread-Index: AQHVxiBU8GGBuSDCyE+2e2fHcoZQZafguKSAgAAg5YCAAAP9AIAAw+3Y
Date: Thu, 9 Jan 2020 03:07:06 +0000
Message-ID: <MN2PR12MB29576985DC4A61F99F96052A95390@MN2PR12MB2957.namprd12.prod.outlook.com>
References: <20200108123648.7422-1-tianci.yin@amd.com>
 <ba1754a0-7230-5df7-cfb3-7b0d7c892c47@amd.com>
 <CADnq5_MQ1S60QX3=U2=LYSoiYg965yViTk0Y0WbaFTRXhvNZww@mail.gmail.com>,
 <aca36233-68fd-c692-1080-daa9c32efa14@gmail.com>
In-Reply-To: <aca36233-68fd-c692-1080-daa9c32efa14@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-09T03:07:05.722Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianci.Yin@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6723b963-895c-4e7f-cc79-08d794b1024d
x-ms-traffictypediagnostic: MN2PR12MB3597:|MN2PR12MB3597:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB35973B1F337613A0A126D4A795390@MN2PR12MB3597.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(199004)(189003)(110136005)(7696005)(54906003)(4326008)(45080400002)(66574012)(478600001)(55016002)(9686003)(966005)(26005)(6506007)(316002)(53546011)(71200400001)(2906002)(81156014)(33656002)(19627405001)(86362001)(186003)(6636002)(52536014)(8676002)(81166006)(66476007)(66446008)(64756008)(5660300002)(66556008)(66946007)(91956017)(8936002)(76116006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3597;
 H:MN2PR12MB2957.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S4SPxt42TKLga2GumqCZIHptjC7YGE73FgHMKYs/23qy3Ju/VoyLm59kgZVOUbwI3z5nMzy9TOkVqkvL9Z7FFq+uJyX3UaIeBadPtqSJ8794QDC3tilee4XlEdS5SKFvcA7RpHIrMXbTTbRlCwZvblgP8mWymG8KWJKnYDlSlaZ+Bl3PHt85KUaQErlSSnaTkGuNSQkJF5lLgjXK1g/cjHArWJKW+/deZHym/M0jCgGTCMrpGREVVTlUg0oUILpGAkTwVMhYGimve7zucnbVGP4zKUXm8DXZeCHnH646fUV4b8djFjFD/3fxGcDw0C9nJlT5N4ev2IXBaGL/ZxzNKKhnWes7djoSImeY6TdzjjLJ0CDCpCrfPbrTilohHsn+rT56vGgHwm/YWslja9c00tRl68LMzJiVFGQoFfzvkv2S5hDPzbWM5UT3VrhKBKFG58rcWlqdUp++8pgqufEGnFRBvFSLa1cbUO8OfHE73kk=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6723b963-895c-4e7f-cc79-08d794b1024d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 03:07:06.3330 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uzQNn1+hzXYM9tYQQbCX7lwc4NZk/8S0BBZWCZPgInXy6VkH2lXcK2axbtbYjXSg9iqlt+rCFz6kgRMo+a093A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3597
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
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
Content-Type: multipart/mixed; boundary="===============2113282939=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2113282939==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB29576985DC4A61F99F96052A95390MN2PR12MB2957namp_"

--_000_MN2PR12MB29576985DC4A61F99F96052A95390MN2PR12MB2957namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Thanks Alex and Christian!

Hi Christian,

On ASICs with gmc v10, I find amdgpu_bo_late_init() is not invoked, so stol=
en memory never get free, on other ASICs with gmc v9/v8/v7/v6, stolen memor=
y was freed in gmc_v*_0_late_init(). I don't know why, are there some speci=
al reasons or just missed by coding?

Thanks!

Rico

________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Wednesday, January 8, 2020 23:04
To: Alex Deucher <alexdeucher@gmail.com>; Koenig, Christian <Christian.Koen=
ig@amd.com>
Cc: Long, Gang <Gang.Long@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>=
; Xu, Feifei <Feifei.Xu@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>; =
amd-gfx list <amd-gfx@lists.freedesktop.org>; Tuikov, Luben <Luben.Tuikov@a=
md.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Yuan, Xiaojie <Xia=
ojie.Yuan@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix modprobe failure of the 2nd GPU when G=
DDR6 training enabled

Am 08.01.20 um 15:49 schrieb Alex Deucher:
> On Wed, Jan 8, 2020 at 7:52 AM Christian K=F6nig <christian.koenig@amd.co=
m> wrote:
>> Am 08.01.20 um 13:36 schrieb Tianci Yin:
>>> From: "Tianci.Yin" <tianci.yin@amd.com>
>>>
>>> [why]
>>> In dual GPUs scenario, stolen_size is assigned to zero on the 2nd GPU,
>>> then the bottom region of VRAM was allocated as GTT, unfortunately
>>> a small region of bottom VRAM was encroached by UMC firmware during
>>> GDDR6 BIST training, this cause pagefault.
>> What I'm missing here is why is the stolen size zero on the 2nd GPU?
>>
>> Maybe we need to read the stolen size after posting the GPU instead?
> There is no stolen memory on secondary GPUs because there is no pre-OS
> console using that memory.

Ah! Yeah that makes sense.

But in this case I would say we should change the patch like the following:

adev->gmc.stolen_size =3D min(adev->gmc.stolen_size,
AMDGPU_STOLEN_VGA_DEFAULT_SIZE);

And in amdgpu_ttm_late_init():

/* Can't free the stolen VGA memory when it might be used for memory
training again. */
if (!adev->fw_vram_usage.mem_train_support)
     amdgpu_bo_free_kernel(....


Regards,
Christian.


>
> Alex
>
>> Regards,
>> Christian.
>>
>>> [how]
>>> Forcing stolen_size to 3MB, then the bottom region of VRAM was
>>> allocated as stolen memory, GTT corruption avoid.
>>> The stolen memory of the 2nd GPU will be free in late_init phase,
>>> no memory wasted.
>>>
>>> Change-Id: Icd0ad7de41333282949bb1e3e676c6c307ddd081
>>> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  6 ++++++
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 21 +++++++++++++++++++++
>>>    2 files changed, 27 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gmc.h
>>> index c91dd602d5f1..440b793316df 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> @@ -60,6 +60,11 @@
>>>     */
>>>    #define AMDGPU_GMC_FAULT_TIMEOUT    5000ULL
>>>
>>> +/*
>>> + * Default stolen memory size, 1024 * 768 * 4
>>> + */
>>> +#define AMDGPU_STOLEN_VGA_DEFAULT_SIZE       0x300000
>>> +
>>>    struct firmware;
>>>
>>>    /*
>>> @@ -192,6 +197,7 @@ struct amdgpu_gmc {
>>>        uint32_t                srbm_soft_reset;
>>>        bool                    prt_warning;
>>>        uint64_t                stolen_size;
>>> +     bool                    stolen_temp_reserved;
>>>        /* apertures */
>>>        u64                     shared_aperture_start;
>>>        u64                     shared_aperture_end;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v10_0.c
>>> index 7dc8c068c62a..0c96b67d6ca7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> @@ -566,6 +566,11 @@ static int gmc_v10_0_late_init(void *handle)
>>>        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>>        int r;
>>>
>>> +     if (adev->gmc.stolen_temp_reserved) {
>>> +             amdgpu_bo_late_init(adev);
>>> +             adev->gmc.stolen_temp_reserved =3D false;
>>> +     }
>>> +
>>>        r =3D amdgpu_gmc_allocate_vm_inv_eng(adev);
>>>        if (r)
>>>                return r;
>>> @@ -756,6 +761,22 @@ static int gmc_v10_0_sw_init(void *handle)
>>>                return r;
>>>
>>>        adev->gmc.stolen_size =3D gmc_v10_0_get_vbios_fb_size(adev);
>>> +     /*
>>> +      * In dual GPUs scenario, stolen_size is assigned to zero on the =
2nd GPU,
>>> +      * then the bottom region of VRAM was allocated as GTT, unfortuna=
tely
>>> +      * a small region of bottom VRAM was encroached by UMC firmware d=
uring
>>> +      * GDDR6 BIST training, this cause pagefault.
>>> +      * The page fault can be fixed by forcing stolen_size to 3MB, the=
n the bottom
>>> +      * region of VRAM was allocated as stolen memory, GTT corruption =
avoid.
>>> +      * The stolen memory of the 2nd GPU will be free in late_init pha=
se,
>>> +      * no memory wasted.
>>> +      */
>>> +     if (adev->fw_vram_usage.mem_train_support &&
>>> +             adev->gmc.stolen_size =3D=3D 0) {
>>> +             adev->gmc.stolen_size =3D AMDGPU_STOLEN_VGA_DEFAULT_SIZE;
>>> +             adev->gmc.stolen_temp_reserved =3D true;
>>> +     } else
>>> +             adev->gmc.stolen_temp_reserved =3D false;
>>>
>>>        /* Memory manager */
>>>        r =3D amdgpu_bo_init(adev);
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist=
s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Ctianc=
i.yin%40amd.com%7C1365f16aef4c418f0db308d7944c0f26%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637140926723776401&amp;sdata=3Dubt7GGRaAvLzv%2F%2BUXxa=
TW%2FgGbKkRKWv6%2BB50fHHW3Xc%3D&amp;reserved=3D0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Ctianci=
.yin%40amd.com%7C1365f16aef4c418f0db308d7944c0f26%7C3dd8961fe4884e608e11a82=
d994e183d%7C0%7C0%7C637140926723776401&amp;sdata=3Dubt7GGRaAvLzv%2F%2BUXxaT=
W%2FgGbKkRKWv6%2BB50fHHW3Xc%3D&amp;reserved=3D0


--_000_MN2PR12MB29576985DC4A61F99F96052A95390MN2PR12MB2957namp_
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
Thanks Alex and Christian!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Christian,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
On ASICs with gmc v10, I find <span>amdgpu_bo_late_init() is not invoked, s=
o stolen memory never get free, on other ASICs with gmc v9/v8/v7/v6,
<span>stolen memory </span>was freed in gmc_v*_0_late_init(). I don't know =
why, are there some special reasons or just missed by coding?<br>
</span><span></span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt">Thanks!</span></font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt"><br>
</span></font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt">Rico<br>
</span></font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt"></span></font><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Wednesday, January 8, 2020 23:04<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;; Koenig, Christian &l=
t;Christian.Koenig@amd.com&gt;<br>
<b>Cc:</b> Long, Gang &lt;Gang.Long@amd.com&gt;; Wang, Kevin(Yang) &lt;Kevi=
n1.Wang@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Yin, Tianci (Ric=
o) &lt;Tianci.Yin@amd.com&gt;; amd-gfx list &lt;amd-gfx@lists.freedesktop.o=
rg&gt;; Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deucher, Alexander
 &lt;Alexander.Deucher@amd.com&gt;; Yuan, Xiaojie &lt;Xiaojie.Yuan@amd.com&=
gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix modprobe failure of the 2nd GPU=
 when GDDR6 training enabled</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 08.01.20 um 15:49 schrieb Alex Deucher:<br>
&gt; On Wed, Jan 8, 2020 at 7:52 AM Christian K=F6nig &lt;christian.koenig@=
amd.com&gt; wrote:<br>
&gt;&gt; Am 08.01.20 um 13:36 schrieb Tianci Yin:<br>
&gt;&gt;&gt; From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; [why]<br>
&gt;&gt;&gt; In dual GPUs scenario, stolen_size is assigned to zero on the =
2nd GPU,<br>
&gt;&gt;&gt; then the bottom region of VRAM was allocated as GTT, unfortuna=
tely<br>
&gt;&gt;&gt; a small region of bottom VRAM was encroached by UMC firmware d=
uring<br>
&gt;&gt;&gt; GDDR6 BIST training, this cause pagefault.<br>
&gt;&gt; What I'm missing here is why is the stolen size zero on the 2nd GP=
U?<br>
&gt;&gt;<br>
&gt;&gt; Maybe we need to read the stolen size after posting the GPU instea=
d?<br>
&gt; There is no stolen memory on secondary GPUs because there is no pre-OS=
<br>
&gt; console using that memory.<br>
<br>
Ah! Yeah that makes sense.<br>
<br>
But in this case I would say we should change the patch like the following:=
<br>
<br>
adev-&gt;gmc.stolen_size =3D min(adev-&gt;gmc.stolen_size, <br>
AMDGPU_STOLEN_VGA_DEFAULT_SIZE);<br>
<br>
And in amdgpu_ttm_late_init():<br>
<br>
/* Can't free the stolen VGA memory when it might be used for memory <br>
training again. */<br>
if (!adev-&gt;fw_vram_usage.mem_train_support)<br>
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(....<br>
<br>
<br>
Regards,<br>
Christian.<br>
<br>
<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Christian.<br>
&gt;&gt;<br>
&gt;&gt;&gt; [how]<br>
&gt;&gt;&gt; Forcing stolen_size to 3MB, then the bottom region of VRAM was=
<br>
&gt;&gt;&gt; allocated as stolen memory, GTT corruption avoid.<br>
&gt;&gt;&gt; The stolen memory of the 2nd GPU will be free in late_init pha=
se,<br>
&gt;&gt;&gt; no memory wasted.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Change-Id: Icd0ad7de41333282949bb1e3e676c6c307ddd081<br>
&gt;&gt;&gt; Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |&nb=
sp; 6 &#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c&nbsp;=
 | 21 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; 2 files changed, 27 insertions(&#43;)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt;&gt;&gt; index c91dd602d5f1..440b793316df 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt;&gt;&gt; @@ -60,6 &#43;60,11 @@<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define AMDGPU_GMC_FAULT_TIMEOUT&nbsp;&nbsp;=
&nbsp; 5000ULL<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &#43;/*<br>
&gt;&gt;&gt; &#43; * Default stolen memory size, 1024 * 768 * 4<br>
&gt;&gt;&gt; &#43; */<br>
&gt;&gt;&gt; &#43;#define AMDGPU_STOLEN_VGA_DEFAULT_SIZE&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 0x300000<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; struct firmware;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt;&gt; @@ -192,6 &#43;197,7 @@ struct amdgpu_gmc {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; srbm_soft_reset;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; prt_warning;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; stolen_size;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; stolen_temp_reserved;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* apertures */<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; shared_aperture_start;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; shared_aperture_end;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/=
gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
&gt;&gt;&gt; index 7dc8c068c62a..0c96b67d6ca7 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
&gt;&gt;&gt; @@ -566,6 &#43;566,11 @@ static int gmc_v10_0_late_init(void *=
handle)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device=
 *adev =3D (struct amdgpu_device *)handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.stolen_temp_res=
erved) {<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_bo_late_init(adev);<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;gmc.stolen_temp_reserved =3D false;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_gmc_all=
ocate_vm_inv_eng(adev);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt; @@ -756,6 &#43;761,22 @@ static int gmc_v10_0_sw_init(void *ha=
ndle)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.stolen_=
size =3D gmc_v10_0_get_vbios_fb_size(adev);<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * In dual GPUs scenario, s=
tolen_size is assigned to zero on the 2nd GPU,<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * then the bottom region o=
f VRAM was allocated as GTT, unfortunately<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * a small region of bottom=
 VRAM was encroached by UMC firmware during<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * GDDR6 BIST training, thi=
s cause pagefault.<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * The page fault can be fi=
xed by forcing stolen_size to 3MB, then the bottom<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * region of VRAM was alloc=
ated as stolen memory, GTT corruption avoid.<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * The stolen memory of the=
 2nd GPU will be free in late_init phase,<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * no memory wasted.<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;fw_vram_usage.mem_t=
rain_support &amp;&amp;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;gmc.stolen_size =3D=3D 0) {<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;gmc.stolen_size =3D AMDGPU_STOLEN_VGA_DEFAULT_SIZE=
;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;gmc.stolen_temp_reserved =3D true;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;gmc.stolen_temp_reserved =3D false;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Memory manager */=
<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_init=
(adev);<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; amd-gfx@lists.freedesktop.org<br>
&gt;&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dh=
ttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;d=
ata=3D02%7C01%7Ctianci.yin%40amd.com%7C1365f16aef4c418f0db308d7944c0f26%7C3=
dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637140926723776401&amp;amp;sdata=
=3Dubt7GGRaAvLzv%2F%2BUXxaTW%2FgGbKkRKWv6%2BB50fHHW3Xc%3D&amp;amp;reserved=
=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Ctian=
ci.yin%40amd.com%7C1365f16aef4c418f0db308d7944c0f26%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637140926723776401&amp;amp;sdata=3Dubt7GGRaAvLzv%2F%2=
BUXxaTW%2FgGbKkRKWv6%2BB50fHHW3Xc%3D&amp;amp;reserved=3D0</a><br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx@lists.freedesktop.org<br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D02%7C01%7Ctianci.yin%40amd.com%7C1365f16aef4c418f0db308d7944c0f26%7C3dd8=
961fe4884e608e11a82d994e183d%7C0%7C0%7C637140926723776401&amp;amp;sdata=3Du=
bt7GGRaAvLzv%2F%2BUXxaTW%2FgGbKkRKWv6%2BB50fHHW3Xc%3D&amp;amp;reserved=3D0"=
>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Ctian=
ci.yin%40amd.com%7C1365f16aef4c418f0db308d7944c0f26%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637140926723776401&amp;amp;sdata=3Dubt7GGRaAvLzv%2F%2=
BUXxaTW%2FgGbKkRKWv6%2BB50fHHW3Xc%3D&amp;amp;reserved=3D0</a><br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB29576985DC4A61F99F96052A95390MN2PR12MB2957namp_--

--===============2113282939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2113282939==--
