Return-Path: <SRS0=+i0l=5W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8F8C2BA1B
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 14:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C3E23DC3
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 14:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AQO7gb8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C3E23DC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C11D6E3E1;
	Mon,  6 Apr 2020 14:28:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F30F6E3E1
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2020 14:28:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+bjXgmOURuhWuIqJ/eDh1LFlfgLhHPNcYr23uO2u8H8iV+Bbw5TBCdDcvanUA4fAGTszAJ1AmJj46nSYQgVkiMIYs+84JqT4G5RsCMbPLYnGrJrYJMxPXjrVdU60IeDgm4Z9DP9nRLU/dgTKQOJQQyXd0rGPB8WJUqWHmVeJY4AR4GWbm0Qh3wvBhbzniyEz2/i+ZXAsyezodb10BN0aCIgXE2dWCndvSnhD5gL7TNe4clUuWJF6matV1QtdklgJ1FWMNK7D5S1t9xHBgqWdvhNYUzZXQOiVQRqyycQ5mVI0gTyZmsRqo/6NDmyfrA4Uk6aSVHb1GjKI7oIqc5JLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rI5gAo9m9XbIbsmtlQaKsXZ6oe29CykUuwFKSmx8/XI=;
 b=iyiVmyUXjSrAbjLvgM13v3wPh0XhCR8V4g6Pf3aEf+LW0sbGatxRnATM43cPrpoBq3vqGckwZlCbr2l+h5kwILex2xWyxT9yn9eoOFSEyjI/3gozByvAU/QkUIRYF1v2obuw5gTQxuiWOyTKQJyRteNTyORrZ1ab5CVU+NccXnhL2CJ3EaSU92rVnQ0P8DOBAKQUVZ+wOwIqVVamyHgSOmaTi8ovgKE2hcZ6dn6dakISKoOKh/pc+QKeFY8DoB3gnA6xnU2vY4/eY0ArwAOGg8sp7jHL68uBjUFD6Ib9zoue2Wn26M6Nj9JHLWqDrN3bYqNK95hNxM2Hu/FSEbli1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rI5gAo9m9XbIbsmtlQaKsXZ6oe29CykUuwFKSmx8/XI=;
 b=AQO7gb8Cq0Yf42D8g+NuxdzZdq1OGYiN70nEAUgLGmRrS/RSsolXm3i/9HNMQ8mLswAD8Fd9QLKdPviGtzAVeVDDP/vVqG/CnDLIa6JNOTMAlMUcABKyWBWyOvspmHEbhKgK3KkhPqYflbEKkqRLGfcJc0ofVh3yTRWFWmNX2ro=
Received: from MN2PR12MB2957.namprd12.prod.outlook.com (2603:10b6:208:100::14)
 by MN2PR12MB3951.namprd12.prod.outlook.com (2603:10b6:208:16b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Mon, 6 Apr
 2020 14:28:10 +0000
Received: from MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::cc84:be2a:e761:5914]) by MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::cc84:be2a:e761:5914%6]) with mapi id 15.20.2878.018; Mon, 6 Apr 2020
 14:28:10 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add SPM golden settings for Navi10
Thread-Topic: [PATCH] drm/amdgpu: add SPM golden settings for Navi10
Thread-Index: AQHWCXjtJrA6a0ubh0CxatVil1imlahnfFOAgASvibs=
Date: Mon, 6 Apr 2020 14:28:10 +0000
Message-ID: <MN2PR12MB295702C539C35A93A6CE4BA095C20@MN2PR12MB2957.namprd12.prod.outlook.com>
References: <20200403052948.23664-1-tianci.yin@amd.com>,
 <CADnq5_OF=MFbH5uqKGzCkL_oWuDUhQdv4QJh6spSdy9TLqhWpw@mail.gmail.com>
In-Reply-To: <CADnq5_OF=MFbH5uqKGzCkL_oWuDUhQdv4QJh6spSdy9TLqhWpw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-06T14:26:59.691Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianci.Yin@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a213890a-3f7b-415d-b152-08d7da36bbc7
x-ms-traffictypediagnostic: MN2PR12MB3951:|MN2PR12MB3951:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB39514AB7F425701F03251F1295C20@MN2PR12MB3951.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0365C0E14B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2957.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(9686003)(55016002)(6916009)(64756008)(66556008)(33656002)(54906003)(76116006)(316002)(66446008)(91956017)(71200400001)(66476007)(19627405001)(66946007)(52536014)(2906002)(4326008)(478600001)(186003)(7696005)(81156014)(81166006)(8936002)(53546011)(6506007)(8676002)(86362001)(5660300002)(26005);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gBT4ZDzTJ/iTp/nAID4RWifxKFi+yS5GR0sowEYl0W+RDvSG6Ec7SvhD7harKAVwVGfaEfzCxRp4sZZeNMeGIR5AUt9m5Sysn6IeKtWVd6PyqR4nmHxbDXZK6+a9PS5O766xyYoxI/cwQNUDf/oDy539jX1T4lIPbLVBk6Bj6km6RcShcf9irirVFuOmHyoneUlXvKDZxsPDeoH/v4u6K1PP5DKCrtZCPEIq6tMxzubtNmG/aGEIbKEzqeonPMdtOIKmCs8wa2yiADjMxHpyX30ujwPFpkHsdOHkNLt5Y/T8XMebob4g4XFVZkFI5JCK1y9ae7ZumBzcaHJnuA8cKsLo2ed2U/O1lT3wGGmYv2WfiYHk+5jniPdknfE3M+sHguct4A36aGFv7UGAuMx7F+7XHRmpNPJJL8fmKwpmGV4obYHSWvfcfkDS+A5br48d
x-ms-exchange-antispam-messagedata: 2X4x5dLXc0fvf42xB0hV+gYmCk3ytnia3t/n+FB1x+byeDuZehXd7dlpOE4UaVNAyNbd8nSgcwEhbtwOFS8Si1Ris0LwtuQmUPtDa5+Kw+Bl5DCMXT0IK88bQ/72TwlimDBlK8XC2gIdekfTceVyEQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a213890a-3f7b-415d-b152-08d7da36bbc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2020 14:28:10.8460 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hEXPZbb1GzjrmjpOiqq8pB2A+Z2uFpCzk78n/PxZcKlpF3CU2bG63UAE/0lrc9nNkZPOCDsm5xd2gz0yiGuIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3951
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Hesik, Christopher" <Christopher.Hesik@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0297219552=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0297219552==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB295702C539C35A93A6CE4BA095C20MN2PR12MB2957namp_"

--_000_MN2PR12MB295702C539C35A93A6CE4BA095C20MN2PR12MB2957namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Thanks Alex!
I send it again, please help review.

BR,
Rico
________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Friday, April 3, 2020 22:53
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Zhang, Hawking <Hawk=
ing.Zhang@amd.com>; Hesik, Christopher <Christopher.Hesik@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add SPM golden settings for Navi10

On Fri, Apr 3, 2020 at 1:30 AM Tianci Yin <tianci.yin@amd.com> wrote:
>
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> Add RLC_SPM golden settings
>
> Change-Id: I616e127171293d915cb3a05dee02f51cec8d8f6f
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |    9 +
>  .../gpu/drm/amd/amdgpu/golden_gc_spm_10_1_0.h | 1058 +++++++++++++++++
>  2 files changed, 1067 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/golden_gc_spm_10_1_0.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 70edbbf84338..7c96a894ad37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -48,6 +48,7 @@
>  #include "v10_structs.h"
>  #include "gfx_v10_0.h"
>  #include "nbio_v2_3.h"
> +#include "golden_gc_spm_10_1_0.h"

Can we just include the table directly in this file instead of a
separate header?  One more comment below.

>
>  /**
>   * Navi10 has two graphic rings to share each graphic pipe.
> @@ -138,6 +139,11 @@ static const struct soc15_reg_golden golden_settings=
_gc_10_0_nv10[] =3D
>         /* Pending on emulation bring up */
>  };
>
> +static const struct soc15_reg_golden golden_settings_gc_rlc_spm_10_0_nv1=
0[] =3D
> +{
> +       GOLDEN_GC_SPM_10_1_0
> +};
> +
>  static const struct soc15_reg_golden golden_settings_gc_10_1_1[] =3D
>  {
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x00=
3c0014),
> @@ -388,6 +394,9 @@ static void gfx_v10_0_init_golden_registers(struct am=
dgpu_device *adev)
>                 soc15_program_register_sequence(adev,
>                                                 golden_settings_gc_10_0_n=
v10,
>                                                 (const u32)ARRAY_SIZE(gol=
den_settings_gc_10_0_nv10));
> +               soc15_program_register_sequence(adev,
> +                                               golden_settings_gc_rlc_sp=
m_10_0_nv10,
> +                                               (const u32)ARRAY_SIZE(gol=
den_settings_gc_rlc_spm_10_0_nv10));
>                 break;
>         case CHIP_NAVI14:
>                 soc15_program_register_sequence(adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/golden_gc_spm_10_1_0.h b/drivers/=
gpu/drm/amd/amdgpu/golden_gc_spm_10_1_0.h
> new file mode 100644
> index 000000000000..e65af4a6fcdd
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/golden_gc_spm_10_1_0.h

This file is missing a license.

Alex

--_000_MN2PR12MB295702C539C35A93A6CE4BA095C20MN2PR12MB2957namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks Alex!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I send it again, please help review.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
BR,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Rico</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher@gmail.com&gt;<br>
<b>Sent:</b> Friday, April 3, 2020 22:53<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Deucher, Ale=
xander &lt;Alexander.Deucher@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&=
gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Hesik, Christopher &lt;C=
hristopher.Hesik@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: add SPM golden settings for Navi10<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Fri, Apr 3, 2020 at 1:30 AM Tianci Yin &lt;tian=
ci.yin@amd.com&gt; wrote:<br>
&gt;<br>
&gt; From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
&gt;<br>
&gt; Add RLC_SPM golden settings<br>
&gt;<br>
&gt; Change-Id: I616e127171293d915cb3a05dee02f51cec8d8f6f<br>
&gt; Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 9 &#43;<br>
&gt;&nbsp; .../gpu/drm/amd/amdgpu/golden_gc_spm_10_1_0.h | 1058 &#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<=
br>
&gt;&nbsp; 2 files changed, 1067 insertions(&#43;)<br>
&gt;&nbsp; create mode 100644 drivers/gpu/drm/amd/amdgpu/golden_gc_spm_10_1=
_0.h<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v10_0.c<br>
&gt; index 70edbbf84338..7c96a894ad37 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt; @@ -48,6 &#43;48,7 @@<br>
&gt;&nbsp; #include &quot;v10_structs.h&quot;<br>
&gt;&nbsp; #include &quot;gfx_v10_0.h&quot;<br>
&gt;&nbsp; #include &quot;nbio_v2_3.h&quot;<br>
&gt; &#43;#include &quot;golden_gc_spm_10_1_0.h&quot;<br>
<br>
Can we just include the table directly in this file instead of a<br>
separate header?&nbsp; One more comment below.<br>
<br>
&gt;<br>
&gt;&nbsp; /**<br>
&gt;&nbsp;&nbsp; * Navi10 has two graphic rings to share each graphic pipe.=
<br>
&gt; @@ -138,6 &#43;139,11 @@ static const struct soc15_reg_golden golden_s=
ettings_gc_10_0_nv10[] =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Pending on emulatio=
n bring up */<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt; &#43;static const struct soc15_reg_golden golden_settings_gc_rlc_spm_1=
0_0_nv10[] =3D<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GOLDEN_GC_SPM_10_1_0<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt;&nbsp; static const struct soc15_reg_golden golden_settings_gc_10_1_1[]=
 =3D<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE=
(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x003c0014),<br>
&gt; @@ -388,6 &#43;394,9 @@ static void gfx_v10_0_init_golden_registers(st=
ruct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; soc15_program_register_sequence(adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; golden_=
settings_gc_10_0_nv10,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const =
u32)ARRAY_SIZE(golden_settings_gc_10_0_nv10));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; soc15_program_register_sequence(adev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; golden_settin=
gs_gc_rlc_spm_10_0_nv10,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const u32)AR=
RAY_SIZE(golden_settings_gc_rlc_spm_10_0_nv10));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; soc15_program_register_sequence(adev,<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/golden_gc_spm_10_1_0.h b/drive=
rs/gpu/drm/amd/amdgpu/golden_gc_spm_10_1_0.h<br>
&gt; new file mode 100644<br>
&gt; index 000000000000..e65af4a6fcdd<br>
&gt; --- /dev/null<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/golden_gc_spm_10_1_0.h<br=
>
<br>
This file is missing a license.<br>
<br>
Alex<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB295702C539C35A93A6CE4BA095C20MN2PR12MB2957namp_--

--===============0297219552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0297219552==--
