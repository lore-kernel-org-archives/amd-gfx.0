Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48B5C5DF63
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 14:43:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FD2C2187F
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 14:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD2C2187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AC3C6ED91;
	Wed,  6 Nov 2019 14:43:38 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820078.outbound.protection.outlook.com [40.107.82.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B03F66ED91
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 14:43:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjnJjbbbGTB9F+IiqnbrWBQ8KDYtU/zSfiaa4rmMfdUHURjJCX3kwnNNoFHNuwrWTpKYO177+svpppbgxHlszGqHv4SXveyhd3LHZDVo559UCDKJN1vGQ5NSKDtN1KdsP7MUDPe54bYGSm5PA8tV9QYs3YOe5aE8kXPdUhua1hAcrmzwOKbaemanaReHmHDandfw5Cyc6hABrWqA/fdY0vew7yhKoXn00gXK2ZzVBMvq8JWwpnehdS7fRQpOARmTDlXFgriyqdUMFGR59baId+ArLXgVtMQdjfoa3iw2LBBZehrzXB9yqZwBqCwZNcFO0CyILYMIevqC/VYKGVRGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuhgJ6U9WcKg41RoeXSDcMagPzc5fJBiSCxWUxbYXd8=;
 b=ngx3RkugwSJok5/rL7Hi842ylpBm4YDEkwaIiKrriOTCWOoC0o31GVZVpeZYEORv5hGzkXzQT8Jz1+ep84C2628pJPkFB47HEqBCh1zENPxFijvYh06woy5e56842jzwxlOOes/D4wYq5uSH98tj1NhP0M8upx/YywGucMB3cW0hSfBwI6/ToluqS3EEqgUlbJod8BokD3AhQl3kBuiNcDSI/aya2rJz/Hh8YOj6KHN+a4gWLjTIxruBLK5Q+js1zvcvVWr0bUZ1QFtBLHEMLNSNBoS71YHmgfzu3gC2FoWPlNG7SHu6R0kbpMH8jU0DDAlm6JhEJtlwGS8fUimUnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from SN1PR12MB2511.namprd12.prod.outlook.com (52.132.196.154) by
 SN1PR12MB2398.namprd12.prod.outlook.com (52.132.195.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Wed, 6 Nov 2019 14:43:34 +0000
Received: from SN1PR12MB2511.namprd12.prod.outlook.com
 ([fe80::f414:c648:5e79:49d5]) by SN1PR12MB2511.namprd12.prod.outlook.com
 ([fe80::f414:c648:5e79:49d5%7]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 14:43:34 +0000
From: "Jiang, Jerry (SW)" <Jerry.Jiang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, JinHuiEric"
 <JinHuiEric.Huang@amd.com>, Alex Deucher <alexdeucher@gmail.com>, "Namin,
 Ashkan" <Ashkan.Namin@amd.com>
Subject: RE: [PATCH] drm/amdgpu: change read of GPU clock counter on Vega10 VF
Thread-Topic: [PATCH] drm/amdgpu: change read of GPU clock counter on Vega10 VF
Thread-Index: AQHVlCgfmdBRrOtnp0CjqhT72Mz92ad9MuYAgAAL0YCAAAKEcIAA7eHXgAAJMwA=
Date: Wed, 6 Nov 2019 14:43:34 +0000
Message-ID:
 <SN1PR12MB251192B770A0D1906C9B56C9EE790@SN1PR12MB2511.namprd12.prod.outlook.com>
References: <1572992808-20397-1-git-send-email-JinhuiEric.Huang@amd.com>
 <CADnq5_NDEXUD84z8srp8NNMNvDVwLNZsZUSek=U2hMwkDKxaNw@mail.gmail.com>
 <968d3fe1-4faf-f003-3ec4-10fd5c35cdd8@amd.com>,
 <BL0PR12MB250054D0D1FE729D1E0E15D3EE790@BL0PR12MB2500.namprd12.prod.outlook.com>
 <CY4PR12MB1813EEC3C3C3B0DA5CF0DECBF7790@CY4PR12MB1813.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1813EEC3C3C3B0DA5CF0DECBF7790@CY4PR12MB1813.namprd12.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9a1a0790-eca7-4c2d-fbca-08d762c7b36b
x-ms-traffictypediagnostic: SN1PR12MB2398:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR12MB239814F611A1FB4D49EADC45EE790@SN1PR12MB2398.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(199004)(189003)(13464003)(110136005)(5660300002)(66066001)(74316002)(26005)(66446008)(478600001)(66476007)(66556008)(64756008)(33656002)(52536014)(76116006)(8676002)(186003)(66946007)(8936002)(81166006)(81156014)(7736002)(6506007)(53546011)(25786009)(11346002)(486006)(476003)(446003)(102836004)(256004)(14444005)(3846002)(7696005)(6116002)(790700001)(76176011)(86362001)(2906002)(316002)(6436002)(55016002)(14454004)(71190400001)(6636002)(606006)(71200400001)(229853002)(6246003)(4326008)(966005)(6306002)(236005)(54896002)(99286004)(9686003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2398;
 H:SN1PR12MB2511.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GjXo56XOg6clhuJuvIamv2k6NEGiA2b7QLVPgFCf+C4sUTqOorMxGTQoiBmuWcpyDb6On+STO0ijhmfUDRAux9FSxEsV9qHyT2N8zBK8MfxMfFkL30LdmTdHKYR/2pdDFgCN+A/fg+RpoNtHxx9aP9L28dXzmY3+O+1T3coFr/D6eaZCPMlesm7cxrviDuVDAtWN8wXQr5Urqpd+yOUqU1UzzrEkjJy8tnBabtkVI89dJ9nVXkeIZqPqZo1EjvAm8fC4NXm+OZhK5rf50DhnE5DuAee/b9HMcHREi9hHk5/KRCsBJxu8p/4hfT33PThJkDGL0b4rrJbFHmm5iHK/bv9yrN7Gozs3J/IJ7co7uwPOddchIVaH9i9eLZIWJyYaVn3YRA64seU/RNPeRe6rrmf5FNJJm9Uh/nHTjOdI3qUgsxFWG3KGBWbTNBdldOsMihMH7/gO53vOoGbhkR1seg4XtIAM04ZKdoEEj+jyHKI=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1a0790-eca7-4c2d-fbca-08d762c7b36b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 14:43:34.3647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5a+dQWJ4Pbf6rvCesDLdNW/ELXNcc5djUMJGZKfSf7Aki8sOkAJifEjLh5Ew9d4q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2398
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuhgJ6U9WcKg41RoeXSDcMagPzc5fJBiSCxWUxbYXd8=;
 b=y1w1DmkEKhB/Yx2XGqufsEYoWyDhWWr7stRMJCg35uWV/c94PFIkdgHjvm+Zvx7mw8++9rzU+DsMMgBwXXjn+4HPrPJsmdw4R8s+bNQ9ydMWSdkv8WLjazeH6YK8KTqOjLw9EU1wxtB4j+IXnSfJLNInV+GnFydEayb/WC0uOeA=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jerry.Jiang@amd.com; 
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
Content-Type: multipart/mixed; boundary="===============1088048292=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106144334.ksDS3b-wKaOFOiPLuWwAfHel_MsdlpyVYQ5Nm2eAvTs@z>

--===============1088048292==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN1PR12MB251192B770A0D1906C9B56C9EE790SN1PR12MB2511namp_"

--_000_SN1PR12MB251192B770A0D1906C9B56C9EE790SN1PR12MB2511namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ashkan,

Can you comment on the observation from Alex regarding RLC_GPU_CLOCK_COUNT_=
LSB/MSB register with GFXoff and GPU reset?

If the statement from Alex is the real situation, we can simply our change.

Jerry


From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Wednesday, November 6, 2019 9:10 AM
To: Jiang, Jerry (SW) <Jerry.Jiang@amd.com>; Huang, JinHuiEric <JinHuiEric.=
Huang@amd.com>; Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: change read of GPU clock counter on Vega10=
 VF

The current bare metal registers also get reset with gfxoff and GPU reset.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Jiang, Jerry (SW) <Jerry.Jiang@amd.co=
m<mailto:Jerry.Jiang@amd.com>>
Sent: Tuesday, November 5, 2019 7:04 PM
To: Huang, JinHuiEric <JinHuiEric.Huang@amd.com<mailto:JinHuiEric.Huang@amd=
.com>>; Alex Deucher <alexdeucher@gmail.com<mailto:alexdeucher@gmail.com>>
Cc: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
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
From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com<mailto:JinHuiEric.Huang@a=
md.com>>
Sent: Tuesday, November 5, 2019 6:48 PM
To: Alex Deucher <alexdeucher@gmail.com<mailto:alexdeucher@gmail.com>>
Cc: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Ji=
ang, Jerry (SW) <Jerry.Jiang@amd.com<mailto:Jerry.Jiang@amd.com>>
Subject: Re: [PATCH] drm/amdgpu: change read of GPU clock counter on Vega10=
 VF


On 2019-11-05 6:06 p.m., Alex Deucher wrote:
> On Tue, Nov 5, 2019 at 5:26 PM Huang, JinHuiEric
> <JinHuiEric.Huang@amd.com<mailto:JinHuiEric.Huang@amd.com>> wrote:
>> Using unified VBIOS has performance drop in sriov environment.
>> The fix is switching to another register instead.
>>
>> Signed-off-by: Eric Huang <JinhuiEric.Huang@amd.com<mailto:JinhuiEric.Hu=
ang@amd.com>>
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
>> amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_SN1PR12MB251192B770A0D1906C9B56C9EE790SN1PR12MB2511namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
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
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle21
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
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
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Ashkan,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Can you comment on the observation from Alex regardi=
ng RLC_GPU_CLOCK_COUNT_LSB/MSB register with GFXoff and GPU reset?<o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If the statement from Alex is the real situation, we=
 can simply our change.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Jerry<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Wednesday, November 6, 2019 9:10 AM<br>
<b>To:</b> Jiang, Jerry (SW) &lt;Jerry.Jiang@amd.com&gt;; Huang, JinHuiEric=
 &lt;JinHuiEric.Huang@amd.com&gt;; Alex Deucher &lt;alexdeucher@gmail.com&g=
t;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: change read of GPU clock counter on=
 Vega10 VF<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">The cur=
rent bare metal registers also get reset with gfxoff and GPU reset.<o:p></o=
:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Jiang, Jerry (SW) &lt;<a href=3D"mailto:Jerry.Jiang@amd.com">Jerry.Jiang@=
amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, November 5, 2019 7:04 PM<br>
<b>To:</b> Huang, JinHuiEric &lt;<a href=3D"mailto:JinHuiEric.Huang@amd.com=
">JinHuiEric.Huang@amd.com</a>&gt;; Alex Deucher &lt;<a href=3D"mailto:alex=
deucher@gmail.com">alexdeucher@gmail.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: change read of GPU clock counter on=
 Vega10 VF</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">Hi Alex,<br>
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
From: Huang, JinHuiEric &lt;<a href=3D"mailto:JinHuiEric.Huang@amd.com">Jin=
HuiEric.Huang@amd.com</a>&gt;
<br>
Sent: Tuesday, November 5, 2019 6:48 PM<br>
To: Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeucher@g=
mail.com</a>&gt;<br>
Cc: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a>; Jiang, Jerry (SW) &lt;<a href=3D"mailto:Jerry.Jiang@amd.com">J=
erry.Jiang@amd.com</a>&gt;<br>
Subject: Re: [PATCH] drm/amdgpu: change read of GPU clock counter on Vega10=
 VF<br>
<br>
<br>
On 2019-11-05 6:06 p.m., Alex Deucher wrote:<br>
&gt; On Tue, Nov 5, 2019 at 5:26 PM Huang, JinHuiEric <br>
&gt; &lt;<a href=3D"mailto:JinHuiEric.Huang@amd.com">JinHuiEric.Huang@amd.c=
om</a>&gt; wrote:<br>
&gt;&gt; Using unified VBIOS has performance drop in sriov environment.<br>
&gt;&gt; The fix is switching to another register instead.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Eric Huang &lt;<a href=3D"mailto:JinhuiEric.Huang@a=
md.com">JinhuiEric.Huang@amd.com</a>&gt;<br>
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
&gt;&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.fre=
edesktop.org</a><br>
&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
>https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_SN1PR12MB251192B770A0D1906C9B56C9EE790SN1PR12MB2511namp_--

--===============1088048292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1088048292==--
