Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A07C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:42:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 455C320672
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KoTN0O+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455C320672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E7126E430;
	Wed, 29 Jul 2020 02:42:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B6656E430
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 02:42:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9jAgAqQH0h9yE0QKde4OTeYW138ROk4PJrAezXOSlhGE8t2e1jUC6QLJ9BxDle7u9TSKLE7zRrIigbo9YqwSxUpdQEQXkdr4XsvFw1qORZo2hLVFHjLiydzU3wkJ7i0xNehcxvuj0O0MEQO/ZqvT7rwHKpufYd4g8XHYe0NKfJarXaC63r3tD55GJoAZsnR7b0J4N91hnfreT3+4lp6raKRbaR75rF9/Uhu2LY3HHXIT+PyaEMu19jsahgzNw4mGQ8MROKruox0vQeRcgYvkqSI6i9Dol4AEXoMpZwvfcFppRQZva+XbhyURc0wxLf1g8AEPs9rI+xil32/WhX6uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3MYllOckbamAmUYyqTUCUGPtkQ9DFqN3M17Jx3F9yU=;
 b=kWAu24fiRT+WUTtBsZEp3I75t8M1oIvIkiQ4iAVsXZfnfKUi5+1PDaD4E5ANjhtG5tYTD2KLZglS0UN9/Zmy6Pza2nrQ5542AjwsScvOtFm/XTqMJj8hSN0WVelw6/Waklnnm/1M9aFYlSr9yNwIhtPUBQuuMU62TK0gd7dIrK2TyNPASPjVZr9cbPl2bOhqDUa4XI6O7fX95+TAhMupTSN1rXzyUvV1wPm9WFsnW4xyJaDi1mYW7MH5ZBRitBRp/+1Asz3OxTZCBmUUvzJfFuQ8GovAgQmwNdAJrQ2+ckGpwt5H379TNZamIymFulJgDFJi41+9JGY1stOSWvXgfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3MYllOckbamAmUYyqTUCUGPtkQ9DFqN3M17Jx3F9yU=;
 b=KoTN0O+WAIDO0gWHSzay9IDOlBLX7NJH2ZnA4RFaVxgRwwblEGOlf2PJ/ma6a3aBoI3xyCOkMXJQyV9uW3R6LnyYwaveEYJ+CU/sxU0lE2hhIS8kgAzVa0M1k+7nnwLn/ZFAzMaslCWr1JaPCFPS/gPyC+ATBUCyLTLHKpW6RPE=
Received: from BY5PR12MB3777.namprd12.prod.outlook.com (2603:10b6:a03:1a9::14)
 by BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Wed, 29 Jul
 2020 02:42:03 +0000
Received: from BY5PR12MB3777.namprd12.prod.outlook.com
 ([fe80::391f:5cf2:69c7:9962]) by BY5PR12MB3777.namprd12.prod.outlook.com
 ([fe80::391f:5cf2:69c7:9962%7]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 02:42:03 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on Navi1x
 after GFXOFF exit
Thread-Topic: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on
 Navi1x after GFXOFF exit
Thread-Index: AQHWZJ/JJnQa1rfOrkiiEaG9S8S0L6kdVPaAgACFS0k=
Date: Wed, 29 Jul 2020 02:42:02 +0000
Message-ID: <BY5PR12MB3777AC4248B8D2071DF21B7695700@BY5PR12MB3777.namprd12.prod.outlook.com>
References: <20200728052717.21071-1-tianci.yin@amd.com>
 <20200728052717.21071-2-tianci.yin@amd.com>,
 <6bf4db16-25ca-4588-345e-c4919f1bdf30@amd.com>
In-Reply-To: <6bf4db16-25ca-4588-345e-c4919f1bdf30@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-29T02:42:02.436Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0f5602e6-9f37-4333-4c30-08d83368f9b5
x-ms-traffictypediagnostic: BY5PR12MB3873:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB387372194491209B7DC30BEA95700@BY5PR12MB3873.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VL1CE0WshJHKA2hZj+vjuNyUobCEPngVwxKOZQWvOws72Lx7HdbjR9auKGiuYM+to8PpmA0C93l81iA0DjJHZMl4wvd47g5ZFdCxqeQOh9YGkEouRo/vCM7GDEyjjXeqaDTb6ZxpXqH4J+1OKCM20FWIh9pFWFhvi0CYGno3ArNzvUjBt7ONhacE9DZGC6gICYa0vbwlxAxTTTGh24eb4xNNOSuFPw+UKXQNBUMHdoERpjfZIw+O7FCt8+cnCze8s81yeqwdrI/jk4La+MlvUJCpiK/Y0E3jPFQVfTvdRMN6nLx3jguVmPdLMrM3VADuk+7/V4rJBgoQZe/4SxWTm9l38u+H0bgt7iMjbHK7dLMqiWocHr00iBCPDp2ZdJv2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3777.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(86362001)(2906002)(186003)(5660300002)(71200400001)(19627405001)(26005)(8936002)(110136005)(8676002)(54906003)(4326008)(53546011)(9686003)(316002)(52536014)(478600001)(55016002)(83380400001)(64756008)(33656002)(91956017)(66946007)(66446008)(66476007)(7696005)(6506007)(76116006)(66556008)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: BS6BA/vkUoWWPAGJq6IUFKOOZxtMSALAQVpqnVpS9yLHk1EdVdF17uwAXbOFJ4y1kj0tg1g0fe8JGu6YhZpkvIaBWFAOZ9glc8u+xo/ocEOK8L7SGfcMM1l52IzUaJSoveCRIO+h8tlQUB5XZqDZYWEQuPKFOp9tMAcKy/pjmm+ebK0wJQk8gDpa5JVdpsUnC8SQ9TNBJTOTH1baRfbXAq14UBYZiPR6TPoEvGWikqZFQYtBGlnhNt5kAWxTqhRAF1ci9B7qcdoK0Nm24JUeVLBsKgJCxQN0r07Di3sgz2MfngVvycTrZt45O8IxsshNk+FplsRQzliB2bP6teLGKWKBokprrFIg0B3+rbGV0D2uzkmABJ/N3OfnQI21FM6awWkH4fQUVcnpFZikDjJerYi8/jD+MosdhByc3Y3IjATHBMXKOJl62guTXdOOAYl1Pa8u77kyIUCs5opcsW67h0k3EYETIZh+5/bzp7CpjqSYpDDN+hD7wSyRgefUjvqr
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3777.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5602e6-9f37-4333-4c30-08d83368f9b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 02:42:02.9909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ovtzXJ0hoPOt7vEIg99HiQEUSH/RNnn03NBsCtIx+y8Bd7F/Dsx/SQcd6wxxJvOONor3Z89zMB60qbe0IYMlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3873
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Hesik,
 Christopher" <Christopher.Hesik@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Swamy,
 Manjunatha" <Manjunatha.Swamy@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1383285194=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1383285194==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR12MB3777AC4248B8D2071DF21B7695700BY5PR12MB3777namp_"

--_000_BY5PR12MB3777AC4248B8D2071DF21B7695700BY5PR12MB3777namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Thanks very much Lunben and Guchun!

Regards,
Rico
________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Wednesday, July 29, 2020 2:44
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Hesik, Christopher <Christ=
opher.Hesik@amd.com>; Swamy, Manjunatha <Manjunatha.Swamy@amd.com>; Quan, E=
van <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on Nav=
i1x after GFXOFF exit

On 2020-07-28 1:27 a.m., Tianci Yin wrote:
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> On Navi1x, the SPM golden settings will be lost after GFXOFF enter/exit,

" are lost "

> reconfigure the golden settings after GFXOFF exit.

" so reconfigure ..."

>
> Change-Id: I9358ba9c65f241c36f8a35916170b19535148ee9
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm=
/amd/powerplay/amdgpu_smu.c
> index 55463e7a11e2..5da0436d41e0 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1309,6 +1309,7 @@ static int smu_enable_umd_pstate(void *handle,
>
>        struct smu_context *smu =3D (struct smu_context*)(handle);
>        struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
> +     struct amdgpu_device *adev =3D smu->adev;
>
>        if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
>                return -EINVAL;
> @@ -1324,6 +1325,16 @@ static int smu_enable_umd_pstate(void *handle,
>                        amdgpu_device_ip_set_clockgating_state(smu->adev,
>                                                               AMD_IP_BLOC=
K_TYPE_GFX,
>                                                               AMD_CG_STAT=
E_UNGATE);
> +
> +                     if (adev->asic_type >=3D CHIP_NAVI10 &&
> +                         adev->asic_type <=3D CHIP_NAVI12 &&
> +                         (adev->pm.pp_feature & PP_GFXOFF_MASK)) {
> +                             if (adev->gfx.funcs->init_spm_golden) {
> +                                     dev_dbg(adev->dev,"GFXOFF exited, r=
e-init SPM golden settings\n");

Space after comma is required.

> +                                     amdgpu_gfx_init_spm_golden(adev);
> +                             } else
> +                                     dev_warn(adev->dev,"Callback init_s=
pm_golden is NULL\n");

Space after comma is required.

Please add braces to the single statement of the "else". The reason for thi=
s
is that it complements the braces of the "if ( ) {" of the multi-line state=
ment
and closes the block. "checkpatch" calls it "unbalanced braces".

With these three fixed, this patch is
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

> +                     }
>                }
>        } else {
>                /* exit umd pstate, restore level, enable gfx cg*/
>


--_000_BY5PR12MB3777AC4248B8D2071DF21B7695700BY5PR12MB3777namp_
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
Thanks very much Lunben and Guchun!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Rico<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tuikov, Luben &lt;Lub=
en.Tuikov@amd.com&gt;<br>
<b>Sent:</b> Wednesday, July 29, 2020 2:44<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Haw=
king &lt;Hawking.Zhang@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; H=
esik, Christopher &lt;Christopher.Hesik@amd.com&gt;; Swamy, Manjunatha &lt;=
Manjunatha.Swamy@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;;
 Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings=
 on Navi1x after GFXOFF exit</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2020-07-28 1:27 a.m., Tianci Yin wrote:<br>
&gt; From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
&gt; <br>
&gt; On Navi1x, the SPM golden settings will be lost after GFXOFF enter/exi=
t,<br>
<br>
&quot; are lost &quot;<br>
<br>
&gt; reconfigure the golden settings after GFXOFF exit.<br>
<br>
&quot; so reconfigure ...&quot;<br>
<br>
&gt; <br>
&gt; Change-Id: I9358ba9c65f241c36f8a35916170b19535148ee9<br>
&gt; Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 11 +++++++++++<br>
&gt;&nbsp; 1 file changed, 11 insertions(+)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/=
drm/amd/powerplay/amdgpu_smu.c<br>
&gt; index 55463e7a11e2..5da0436d41e0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; @@ -1309,6 +1309,7 @@ static int smu_enable_umd_pstate(void *handle,<b=
r>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D =
(struct smu_context*)(handle);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *smu_=
dpm_ctx =3D &amp;(smu-&gt;smu_dpm);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;adev;=
<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;is_apu &amp;&am=
p; !smu_dpm_ctx-&gt;dpm_context)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; @@ -1324,6 +1325,16 @@ static int smu_enable_umd_pstate(void *handle,<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
device_ip_set_clockgating_state(smu-&gt;adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; AMD_IP_BLOCK_TYPE_GFX,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; AMD_CG_STATE_UNGATE);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =
&gt;=3D CHIP_NAVI10 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 adev-&gt;asic_type &lt;=3D CHIP_NAVI12 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 (adev-&gt;pm.pp_feature &amp; PP_GFXOFF_MASK)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.funcs-&gt;init_spm_golden) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; de=
v_dbg(adev-&gt;dev,&quot;GFXOFF exited, re-init SPM golden settings\n&quot;=
);<br>
<br>
Space after comma is required.<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; am=
dgpu_gfx_init_spm_golden(adev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; de=
v_warn(adev-&gt;dev,&quot;Callback init_spm_golden is NULL\n&quot;);<br>
<br>
Space after comma is required.<br>
<br>
Please add braces to the single statement of the &quot;else&quot;. The reas=
on for this<br>
is that it complements the braces of the &quot;if ( ) {&quot; of the multi-=
line statement<br>
and closes the block. &quot;checkpatch&quot; calls it &quot;unbalanced brac=
es&quot;.<br>
<br>
With these three fixed, this patch is<br>
Reviewed-by: Luben Tuikov &lt;luben.tuikov@amd.com&gt;<br>
<br>
Regards,<br>
Luben<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* exit umd pstate, restore level, enable gfx cg*/<br>
&gt; <br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BY5PR12MB3777AC4248B8D2071DF21B7695700BY5PR12MB3777namp_--

--===============1383285194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1383285194==--
