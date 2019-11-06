Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6304BC5DF63
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 14:09:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 356AF20663
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 14:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356AF20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1EFC6ED76;
	Wed,  6 Nov 2019 14:09:52 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800070.outbound.protection.outlook.com [40.107.80.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CF4A6ED78
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 14:09:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arAU7ygZX6P792/DdcZEUrf3LUz2xTj4izCjl1VX6o6XZQzxhlIO0rFAhabXWtnJUTUVHSe6oI3CHqTmjl0O3UAinN2hLhGlTBIBP4EYsb51gBNI7laoQJ3X5RY+iS8aTP+dZwYVLtwasXVv5CZEgvwrJhPvW+4fow9//PJHD1gwPSIn1bnJCiRJKIPwwgm5rTqKia2LORMbuuCeY4gDljzHJ1iSlP+WhYw+dMknmO0cyRkSMcG3S5yKIccH4yErgGUnQiihlRb63nUSmlUaPTRPNP8bysmahBknKaRufxeurdqVKsWTTZb98/OlTo6rbBB4P52A/OB92kpq9g6zPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzvzaW4dXHvAdmEFFOdD+d2Aa4p18D8X2TJmSvzttTo=;
 b=XqKMJ9BoxyPDkbaTdqANc9NmGO7S81SoaOUsPh5oGh9cxx2pq3+YXG+HfuDMaJriQynQerOeJBChe7JZo/tCf0wLIymcblriL8KEk6vOCT+h4g9iLoYm3JpFT+jLBi/7cQgE5pzi+8+OCN2WHpUUOt5YdDN9+75BqP7+lg15PvJcx2E6vsUXweeTZU5u5p3REphv9hMZWIwXubokxwOnrLq90vSRRXuKV1Xh4roWR39spK0J4aNpI8KfJyOB0GBe58VIkuf9KtwLl8kRQvRfbD6lIPVeiy4Gk9LKxt43s+3joXMw7C/4h40GBRX6CSNFrKNf8kWNootUShVzmeF0Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR12MB1813.namprd12.prod.outlook.com (10.175.80.21) by
 CY4PR12MB1829.namprd12.prod.outlook.com (10.175.60.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 14:09:49 +0000
Received: from CY4PR12MB1813.namprd12.prod.outlook.com
 ([fe80::dc23:193b:9619:a4fc]) by CY4PR12MB1813.namprd12.prod.outlook.com
 ([fe80::dc23:193b:9619:a4fc%4]) with mapi id 15.20.2408.025; Wed, 6 Nov 2019
 14:09:49 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Jiang, Jerry (SW)" <Jerry.Jiang@amd.com>, "Huang, JinHuiEric"
 <JinHuiEric.Huang@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: change read of GPU clock counter on Vega10 VF
Thread-Topic: [PATCH] drm/amdgpu: change read of GPU clock counter on Vega10 VF
Thread-Index: AQHVlCgfmdBRrOtnp0CjqhT72Mz92ad9MuYAgAAL0YCAAAKEcIAA7eHX
Date: Wed, 6 Nov 2019 14:09:49 +0000
Message-ID:
 <CY4PR12MB1813EEC3C3C3B0DA5CF0DECBF7790@CY4PR12MB1813.namprd12.prod.outlook.com>
References: <1572992808-20397-1-git-send-email-JinhuiEric.Huang@amd.com>
 <CADnq5_NDEXUD84z8srp8NNMNvDVwLNZsZUSek=U2hMwkDKxaNw@mail.gmail.com>
 <968d3fe1-4faf-f003-3ec4-10fd5c35cdd8@amd.com>,
 <BL0PR12MB250054D0D1FE729D1E0E15D3EE790@BL0PR12MB2500.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB250054D0D1FE729D1E0E15D3EE790@BL0PR12MB2500.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: deb7ef16-11d7-4cd9-0750-08d762c2fc63
x-ms-traffictypediagnostic: CY4PR12MB1829:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1829D30D36CED0473E4B8C31F7790@CY4PR12MB1829.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(199004)(189003)(13464003)(14444005)(11346002)(9686003)(236005)(6436002)(8676002)(6306002)(33656002)(54896002)(2906002)(55016002)(5660300002)(52536014)(19627405001)(6116002)(3846002)(229853002)(966005)(14454004)(4326008)(81166006)(81156014)(25786009)(8936002)(478600001)(606006)(86362001)(6246003)(102836004)(53546011)(74316002)(7736002)(105004)(446003)(316002)(6506007)(71190400001)(71200400001)(186003)(26005)(110136005)(66556008)(66446008)(64756008)(66946007)(66066001)(66476007)(7696005)(256004)(476003)(486006)(99286004)(76176011)(76116006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1829;
 H:CY4PR12MB1813.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1CRez6FoS3ueJRcvecat3f28pDpTUSYq17u0P21EUmGzWnzPx9Epnh8fDxkx+NCp+jaZd+h2+RvWuzBU1pzSlfIRVyorLLwQo2nmfCZl1qvW+YvLRROFs2ZQxgtveDJ+OjupQwJHdBg6Dk8Lm0yxqis72aXjA8i6BHUJDUk3o7yp9vSShAGbVwJbrK5O/NMdrhwuuEJAbiVj5AVnQ5BDfVYLXkiYYXsekPJdhgAzsQov/HwPymDsyvNrjp3jAh1YgHrhemuWPi4Q8nSsCUbVrhiCj6OOEKowATwt+qB1t6TDDiv1EoZyjQu4a2yotx+BagJ/6CdAzEsBmD2ePoeSz7d+J/Cilr3VLpUVu2zXdTQSj1FXC2C+rm0ySNUN9Q8y8e1z3ZyNJKiQEMNEa2VHr1OwMB9aq3LZ+BfnD/fQZYi0/vHedcZ+f0OI2oqBLR3h4fqbXKNchBS0DnkytrxXlb/VT7dnVRbAvauQW+pVL0s=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb7ef16-11d7-4cd9-0750-08d762c2fc63
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 14:09:49.2630 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pRssI2wWqfRsCs6ofSNCLceryG3gq6csSDFdlqzk+kKbVNPO43FGuaTtCSRPzy626oj9TqfBLh52VWVQJjD6GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1829
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzvzaW4dXHvAdmEFFOdD+d2Aa4p18D8X2TJmSvzttTo=;
 b=KFUsr2y1VeMZd8tbdxoAn6lmRXP3NrHLurXT4yqf7cPnaTV2ybltnVFGolEb+EV9cx9knWEea9pk4JWD9Q5b+7niP0s0OrJoC9RORe8Oo1b0r1YCygzQxm4AGk0jix5s90blq5pHKDBsBbQO/c9OWVhYmJSNkI8AdGWQSCavex4=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0599352257=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106140949.By7PiewmNZT-MZpCJF0RPyJVUmw_JmWC3G0L49qIeKk@z>

--===============0599352257==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1813EEC3C3C3B0DA5CF0DECBF7790CY4PR12MB1813namp_"

--_000_CY4PR12MB1813EEC3C3C3B0DA5CF0DECBF7790CY4PR12MB1813namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The current bare metal registers also get reset with gfxoff and GPU reset.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Jiang, J=
erry (SW) <Jerry.Jiang@amd.com>
Sent: Tuesday, November 5, 2019 7:04 PM
To: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>; Alex Deucher <alexdeucher=
@gmail.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: change read of GPU clock counter on Vega10=
 VF

Hi Alex,

Under the SRIOV mode, the L1 policy prevent the write to mmRLC_CAPTURE_GPU_=
CLOCK_COUNT on VF, so the RLC_GPU_CLOCK_COUNT_LSB/MSB doesn't get updated f=
or each read under SRIOV VF.

On the other hand, the read from RLC_REFCLOCK_TIMESTAMP_LSB/MSB doesn't rel=
y on any write, so it is available on VF. And of cause it is available for =
bare metal also. However, the RLC_REFCLOCK_TIMESTAMP_LSB/MSB will reset to =
zero under two cases: 1) GFXOFF 2) Reset. Since SRIOV doesn't have GFXOFF, =
and after reset, the guest will have to restart the app, so there is no pro=
blem for SRIOV to switch to this new register set.

On bare metal, there is concern with these two cases. We didn't get confirm=
ation from Rocm team that the counter reset to zero after  1) GFXOFF 2) Res=
et will not affect the usage of GPU timestamp, we can't make the switch for=
 bare metal. I would be more than happy to switch all over if we can..

Jerry


-----Original Message-----
From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
Sent: Tuesday, November 5, 2019 6:48 PM
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org; Jiang, Jerry (SW) <Jerry.Jiang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: change read of GPU clock counter on Vega10=
 VF


On 2019-11-05 6:06 p.m., Alex Deucher wrote:
> On Tue, Nov 5, 2019 at 5:26 PM Huang, JinHuiEric
> <JinHuiEric.Huang@amd.com> wrote:
>> Using unified VBIOS has performance drop in sriov environment.
>> The fix is switching to another register instead.
>>
>> Signed-off-by: Eric Huang <JinhuiEric.Huang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 19 ++++++++++++++++---
>>   1 file changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 829d623..e44a3ea 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -3885,9 +3885,22 @@ static uint64_t gfx_v9_0_get_gpu_clock_counter(st=
ruct amdgpu_device *adev)
>>          uint64_t clock;
>>
>>          mutex_lock(&adev->gfx.gpu_clock_mutex);
>> -       WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
>> -       clock =3D (uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_LS=
B) |
>> -               ((uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_MSB=
) << 32ULL);
>> +       if (adev->asic_type =3D=3D CHIP_VEGA10 && amdgpu_sriov_runtime(a=
dev)) {
>> +               uint32_t tmp, lsb, msb, i =3D 0;
>> +               do {
>> +                       if (i !=3D 0)
>> +                               udelay(1);
>> +                       tmp =3D RREG32_SOC15(GC, 0, mmRLC_REFCLOCK_TIMES=
TAMP_MSB);
>> +                       lsb =3D RREG32_SOC15(GC, 0, mmRLC_REFCLOCK_TIMES=
TAMP_LSB);
>> +                       msb =3D RREG32_SOC15(GC, 0, mmRLC_REFCLOCK_TIMES=
TAMP_MSB);
>> +                       i++;
>> +               } while (unlikely(tmp !=3D msb) && (i < adev->usec_timeo=
ut));
>> +               clock =3D (uint64_t)lsb | ((uint64_t)msb << 32ULL);
>> +       } else {
>> +               WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
>> +               clock =3D (uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_=
COUNT_LSB) |
>> +                       ((uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_C=
OUNT_MSB) << 32ULL);
>> +       }
> Is there a reason we can't use the same regs on bare metal and SR-IOV?
>   I'd like to minimize the deltas if possible.

As Jerry's request, this change will avoid P1 policy protection on RLC_GPU_=
CLOCK_COUNT_LSB/MSB.

Eric

>
> Alex
>
>>          mutex_unlock(&adev->gfx.gpu_clock_mutex);
>>          return clock;
>>   }
>> --
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB1813EEC3C3C3B0DA5CF0DECBF7790CY4PR12MB1813namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
The current bare metal registers also get reset with gfxoff and GPU reset.<=
/div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Jiang, Jerry (SW) &lt;Jerry.J=
iang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, November 5, 2019 7:04 PM<br>
<b>To:</b> Huang, JinHuiEric &lt;JinHuiEric.Huang@amd.com&gt;; Alex Deucher=
 &lt;alexdeucher@gmail.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: change read of GPU clock counter on=
 Vega10 VF</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Alex,<br>
<br>
Under the SRIOV mode, the L1 policy prevent the write to mmRLC_CAPTURE_GPU_=
CLOCK_COUNT on VF, so the RLC_GPU_CLOCK_COUNT_LSB/MSB doesn't get updated f=
or each read under SRIOV VF.<br>
<br>
On the other hand, the read from RLC_REFCLOCK_TIMESTAMP_LSB/MSB doesn't rel=
y on any write, so it is available on VF. And of cause it is available for =
bare metal also. However, the RLC_REFCLOCK_TIMESTAMP_LSB/MSB will reset to =
zero under two cases: 1) GFXOFF
 2) Reset. Since SRIOV doesn't have GFXOFF, and after reset, the guest will=
 have to restart the app, so there is no problem for SRIOV to switch to thi=
s new register set.<br>
<br>
On bare metal, there is concern with these two cases. We didn't get confirm=
ation from Rocm team that the counter reset to zero after&nbsp; 1) GFXOFF 2=
) Reset will not affect the usage of GPU timestamp, we can't make the switc=
h for bare metal. I would be more than
 happy to switch all over if we can..<br>
<br>
Jerry<br>
<br>
<br>
-----Original Message-----<br>
From: Huang, JinHuiEric &lt;JinHuiEric.Huang@amd.com&gt; <br>
Sent: Tuesday, November 5, 2019 6:48 PM<br>
To: Alex Deucher &lt;alexdeucher@gmail.com&gt;<br>
Cc: amd-gfx@lists.freedesktop.org; Jiang, Jerry (SW) &lt;Jerry.Jiang@amd.co=
m&gt;<br>
Subject: Re: [PATCH] drm/amdgpu: change read of GPU clock counter on Vega10=
 VF<br>
<br>
<br>
On 2019-11-05 6:06 p.m., Alex Deucher wrote:<br>
&gt; On Tue, Nov 5, 2019 at 5:26 PM Huang, JinHuiEric <br>
&gt; &lt;JinHuiEric.Huang@amd.com&gt; wrote:<br>
&gt;&gt; Using unified VBIOS has performance drop in sriov environment.<br>
&gt;&gt; The fix is switching to another register instead.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Eric Huang &lt;JinhuiEric.Huang@amd.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 19 &#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---<br=
>
&gt;&gt;&nbsp;&nbsp; 1 file changed, 16 insertions(&#43;), 3 deletions(-)<b=
r>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt;&gt; index 829d623..e44a3ea 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt;&gt; @@ -3885,9 &#43;3885,22 @@ static uint64_t gfx_v9_0_get_gpu_clock_=
counter(struct amdgpu_device *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t clo=
ck;<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&=
amp;adev-&gt;gfx.gpu_clock_mutex);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_CA=
PTURE_GPU_CLOCK_COUNT, 1);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock =3D (uint64_t)RREG32_S=
OC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_LSB) |<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ((uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_MS=
B) &lt;&lt; 32ULL);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =
=3D=3D CHIP_VEGA10 &amp;&amp; amdgpu_sriov_runtime(adev)) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp, lsb, msb, i =3D 0;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; do {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(i !=3D 0)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(1);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp=
 =3D RREG32_SOC15(GC, 0, mmRLC_REFCLOCK_TIMESTAMP_MSB);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lsb=
 =3D RREG32_SOC15(GC, 0, mmRLC_REFCLOCK_TIMESTAMP_LSB);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msb=
 =3D RREG32_SOC15(GC, 0, mmRLC_REFCLOCK_TIMESTAMP_MSB);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i&#=
43;&#43;;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; } while (unlikely(tmp !=3D msb) &amp;&amp; (i &lt; =
adev-&gt;usec_timeout));<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; clock =3D (uint64_t)lsb | ((uint64_t)msb &lt;&lt; 3=
2ULL);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, =
1);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; clock =3D (uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_C=
LOCK_COUNT_LSB) |<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((u=
int64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_MSB) &lt;&lt; 32ULL);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; Is there a reason we can't use the same regs on bare metal and SR-IOV?=
<br>
&gt;&nbsp;&nbsp; I'd like to minimize the deltas if possible.<br>
<br>
As Jerry's request, this change will avoid P1 policy protection on RLC_GPU_=
CLOCK_COUNT_LSB/MSB.<br>
<br>
Eric<br>
<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock=
(&amp;adev-&gt;gfx.gpu_clock_mutex);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return clock=
;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt; --<br>
&gt;&gt; 2.7.4<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; amd-gfx@lists.freedesktop.org<br>
&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
>https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB1813EEC3C3C3B0DA5CF0DECBF7790CY4PR12MB1813namp_--

--===============0599352257==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0599352257==--
