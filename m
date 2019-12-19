Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE852C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 04:29:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E1B82064B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 04:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FlgAzAUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1B82064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1BAB6E072;
	Thu, 19 Dec 2019 04:29:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4992A6E072
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 04:29:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CG1sK+IBc04GTfRtty2i3y+sllI3RSE0cn4WsL/XCNINw2+9h5Jpe3Thmtyu7ADE67udwk/UtqvBt/tBACjFqXCImhL6QaWwSPp3uNU0FuMlJrnrCedFT++2o76psnn9322zcAK+KocbzYcyfbbi6Cz8FaVsTygWh8HyHr50Gtn5w9uT4FZfJKfo+KVdC9s0dcdkNqY9Ihiu7BIP/y+mz0f4FLiXZO/H2xPpgMJWrSu7ULbgJMAP/sPGXNtAfRbhketSdweUXoWYYquSj+zrWtmKonk7VEWlSkbPsT9i7rBhYDMYwQML8HCZHNzBQadxggzDLtWvFOBB00SAHpBEdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCoatS+mHqnWnznlHxSYS6TEhiDTjclV5GaHlWtkMnY=;
 b=IuLgftrGv2iZelyWdOcQc5Ob33K4hMdIEF2uIolKwpMZMKgExMpQMSytbPxHusyQpA9AYmBBOtNr5c7mJvsbtV66MfC7VfWpMOolS87q/nE8H3Bmj81KRnhr3hfy4ZwEg77tV2D05TLk5j82U2enJnluj4qFvDLKiwiLukrxUEqHkbSX9Y3c0Nj7saGBuOpvMgpMWCOOP3tZA7P5DFzYvsL6zd6tEFrum9kXZbx4+WlceB+F5tJ5wOM2WcsFka6U63KosbnxRmyMdgRcHsuO7IHTfIGPzRT0XWXNa7mZrgcZPcUo8mOBlv4xbLDKO5v320zdj9p0DPxPwjbRnKOXBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCoatS+mHqnWnznlHxSYS6TEhiDTjclV5GaHlWtkMnY=;
 b=FlgAzAUBokVBCS1d37qFB8abgiD4EnRKI+q7wuHFxf8CH6KjTTBlZEH7Y0oO7ACoE9zmG9NEOSLcw8FK0QRfNQdJjJL+uymXvVLG7zL3VKI9ozfEzpV2U6omqKHT6g3yWXnSh2qAKvTIfI867MNg5or+6rRGunxkXXyMErEaEwA=
Received: from DM6PR12MB3241.namprd12.prod.outlook.com (20.179.105.153) by
 DM6PR12MB3386.namprd12.prod.outlook.com (20.178.29.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Thu, 19 Dec 2019 04:29:42 +0000
Received: from DM6PR12MB3241.namprd12.prod.outlook.com
 ([fe80::e9a0:2dda:d7b9:9a10]) by DM6PR12MB3241.namprd12.prod.outlook.com
 ([fe80::e9a0:2dda:d7b9:9a10%5]) with mapi id 15.20.2538.019; Thu, 19 Dec 2019
 04:29:41 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR of SRIOV
Thread-Topic: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR of SRIOV
Thread-Index: AQHVtMOgaNWBDmp6tUizRqwBPK8Zp6e+IooAgAKyjACAAADwgIAABT+U
Date: Thu, 19 Dec 2019 04:29:41 +0000
Message-ID: <DM6PR12MB3241F577F9502E7C7189B9CDF4520@DM6PR12MB3241.namprd12.prod.outlook.com>
References: <1576577994-12874-1-git-send-email-Monk.Liu@amd.com>
 <1576577994-12874-2-git-send-email-Monk.Liu@amd.com>
 <b4117c49-7107-6ded-a5e0-9fd7ea69e9dc@amd.com>
 <MN2PR12MB3933E586A9792FC3901F460184520@MN2PR12MB3933.namprd12.prod.outlook.com>,
 <MN2PR12MB39334EA3BB4AB52FDC37A97084520@MN2PR12MB3933.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB39334EA3BB4AB52FDC37A97084520@MN2PR12MB3933.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shaoyun.Liu@amd.com; 
x-originating-ip: [2607:fea8:3bc0:316:a863:d6bb:b24f:7c55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 45d8ce11-ff9f-4c0a-e9fe-08d7843c1137
x-ms-traffictypediagnostic: DM6PR12MB3386:|DM6PR12MB3386:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3386141E8091B8C9F6991CABF4520@DM6PR12MB3386.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(13464003)(199004)(189003)(8936002)(86362001)(81166006)(81156014)(7696005)(71200400001)(66946007)(76116006)(45080400002)(9686003)(478600001)(33656002)(316002)(66556008)(2906002)(66476007)(53546011)(186003)(6506007)(110136005)(55016002)(66446008)(8676002)(52536014)(4001150100001)(5660300002)(966005)(64756008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3386;
 H:DM6PR12MB3241.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BYviZaFvN5ekl7ZB2bV1tJapQyY50wsTU8D1cg62GgqE/vgwUeAUE5SjohVSIJk/WewuPnAPd1aePuZ7ziIoJStH7508JzNLknIbvPnoghyDb6HfsGo2OlS9QMOdbRh3QHghdrc7Jsx267h5or2SvaQhMRKp0bnBdChmF7zVEvEVNz+lQfaiQtey26VBae/45SgUji0uYZ16V5rR879+IvVcxO5rgnRwI4slZCsgxYM2XbdB/ENx/W9AuybVPDPW0XCKeopDtBctm2fl/qGJ5Ltg4S2TfppJjG1H60lqf1BOYGziEGw80kmhUWECoPKWn3RiMW1kH3Y9wr+/95jFL+tiojyDBt298GPnEoGPwgXTU6qKEtweBzr5piLZHnVwsVoFmxUwDqrpyjNbAoPzEiPJzUT9zFAf/QdCfWkaGeyme6p1izkWmDX1+JLc5AUB6FjCHYrOD0BuuLcukk1atpaw09C+T/9FIC7LVh4wfWMmK1V/w7bGyRrAfkVhxrOKnMRiRxThM66Gi54G5oTCQ+Y4liMAvFbERoTN5ewIfOg=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d8ce11-ff9f-4c0a-e9fe-08d7843c1137
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 04:29:41.6816 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /6qLSII5DDp5CIuH/gKPnCBY7DHpzqw/QSN708JxnC76JJ1KDwv90SQLkePJI/jxHsBW11DLmtmFLwhkH3ytgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3386
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
Content-Type: multipart/mixed; boundary="===============1781167086=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1781167086==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB3241F577F9502E7C7189B9CDF4520DM6PR12MB3241namp_"

--_000_DM6PR12MB3241F577F9502E7C7189B9CDF4520DM6PR12MB3241namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I don't remember any register access by amdkfd_pre_reset call,   please let=
 me know if this assumption is wrong .
This function will use hiq to access CP, in case CP already hang, we might =
not able to get the response from hw and will got a timeout. I think kfd in=
ternal should handle this. Felix already have some comments on that.
I would like to check why we need a special sequences for sriov on this pre=
_reset. If possible, make it the same as bare metal mode sounds better solu=
tion.

Regards
Shaoyun.liu
________________________________
From: Liu, Monk <Monk.Liu@amd.com>
Sent: December 18, 2019 10:52:47 PM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR of SRIOV

Oh, by the way

>>> Do we know the root cause why this function would ruin MEC ?

Only we call this function right after VF FLR will ruin MEC and lead to fol=
lowing KIQ ring test fail , and on bare-metal it is called before gpu rest =
, so that's why on bare-metal we don't have this issue

But the reason we cannot call it before VF FLR on SRIOV case was already st=
ated in this thread

Thanks
_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: Liu, Monk
Sent: Thursday, December 19, 2019 11:49 AM
To: shaoyunl <shaoyun.liu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR of SRIOV

Hi Shaoyun

>>> Do we know the root cause why this function would ruin MEC ? From the l=
ogic, I think this function should be called before FLR since we need to di=
sable the user queue submission first.
Right now I don't know which detail step lead to KIQ ring test fail, I tota=
lly agree with you that this func should be called before VF FLR, but we ca=
nnot do it and the reason is described in The comment:

> if we do pre_reset() before VF FLR, it would go KIQ way to do register
> access and stuck there, because KIQ probably won't work by that time
> (e.g. you already made GFX hang)


>>> I remembered the function should use hiq to communicate with HW , shoul=
dn't use kiq to access HW registerm,  has this been changed ?
Tis function use WREG32/RREG32 to do register access, like all other functi=
ons in KMD,  and WREG32/RREG32 will let KIQ to do the register access If we=
 are under dynamic SRIOV  mode (means we are SRIOV VF and isn't under full =
exclusive mode)

You see that if you call this func before EVENT_5 (event 5 triggers VF FLR)=
 then it will run under dynamic mode and KIQ will handle the register acces=
s, which is not an option Since ME/MEC probably already hang ( if we are te=
sting quark on gfx/compute rings)

Do you have a good suggestion ?

thanks
_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of shaoyunl
Sent: Tuesday, December 17, 2019 11:38 PM
To: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR of SRIOV

I think amdkfd side depends on this call to stop the user queue, without th=
is call, the user queue can submit to HW during the reset which could cause=
 hang again ...
Do we know the root cause why this function would ruin MEC ? From the logic=
, I think this function should be called before FLR since we need to disabl=
e the user queue submission first.
I remembered the function should use hiq to communicate with HW , shouldn't=
 use kiq to access HW registerm,  has this been changed ?


Regards
shaoyun.liu


On 2019-12-17 5:19 a.m., Monk Liu wrote:
> issues:
> MEC is ruined by the amdkfd_pre_reset after VF FLR done
>
> fix:
> amdkfd_pre_reset() would ruin MEC after hypervisor finished the VF
> FLR, the correct sequence is do amdkfd_pre_reset before VF FLR but
> there is a limitation to block this sequence:
> if we do pre_reset() before VF FLR, it would go KIQ way to do register
> access and stuck there, because KIQ probably won't work by that time
> (e.g. you already made GFX hang)
>
> so the best way right now is to simply remove it.
>
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 605cef6..ae962b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3672,8 +3672,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_=
device *adev,
>        if (r)
>                return r;
>
> -     amdgpu_amdkfd_pre_reset(adev);
> -
>        /* Resume IP prior to SMC */
>        r =3D amdgpu_device_ip_reinit_early_sriov(adev);
>        if (r)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cmonk.liu=
%40amd.com%7Cee9c811452634fc2739808d7830718f6%7C3dd8961fe4884e608e11a82d994=
e183d%7C0%7C0%7C637121938885721447&amp;sdata=3DFiqkgiUX8k5rD%2F%2FiJQU2cF1M=
GExO8yXEzYOoBtpdfYU%3D&amp;reserved=3D0

--_000_DM6PR12MB3241F577F9502E7C7189B9CDF4520DM6PR12MB3241namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
I don't remember any register access by amdkfd_pre_reset call,&nbsp;&nbsp; =
please let me know if this assumption is wrong .
<br>
This function will use hiq to access CP, in case CP already hang, we might =
not able to get the response from hw and will got a timeout. I think kfd in=
ternal should handle this. Felix already have some comments on that.
<br>
I would like to check why we need a special sequences for sriov on this pre=
_reset. If possible, make it the same as bare metal mode sounds better solu=
tion.
<br>
<br>
Regards<br>
Shaoyun.liu<br>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu, Monk &lt;Monk.Li=
u@amd.com&gt;<br>
<b>Sent:</b> December 18, 2019 10:52:47 PM<br>
<b>To:</b> Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR o=
f SRIOV</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Oh, by the way<br>
<br>
&gt;&gt;&gt; Do we know the root cause why this function would ruin MEC ?<b=
r>
<br>
Only we call this function right after VF FLR will ruin MEC and lead to fol=
lowing KIQ ring test fail , and on bare-metal it is called before gpu rest =
, so that's why on bare-metal we don't have this issue
<br>
<br>
But the reason we cannot call it before VF FLR on SRIOV case was already st=
ated in this thread
<br>
<br>
Thanks<br>
_____________________________________<br>
Monk Liu|GPU Virtualization Team |AMD<br>
<br>
<br>
-----Original Message-----<br>
From: Liu, Monk <br>
Sent: Thursday, December 19, 2019 11:49 AM<br>
To: shaoyunl &lt;shaoyun.liu@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
Subject: RE: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR of SRIOV=
<br>
<br>
Hi Shaoyun<br>
<br>
&gt;&gt;&gt; Do we know the root cause why this function would ruin MEC ? F=
rom the logic, I think this function should be called before FLR since we n=
eed to disable the user queue submission first.<br>
Right now I don't know which detail step lead to KIQ ring test fail, I tota=
lly agree with you that this func should be called before VF FLR, but we ca=
nnot do it and the reason is described in The comment:<br>
<br>
&gt; if we do pre_reset() before VF FLR, it would go KIQ way to do register=
 <br>
&gt; access and stuck there, because KIQ probably won't work by that time <=
br>
&gt; (e.g. you already made GFX hang)<br>
<br>
<br>
&gt;&gt;&gt; I remembered the function should use hiq to communicate with H=
W , shouldn't use kiq to access HW registerm,&nbsp; has this been changed ?=
<br>
Tis function use WREG32/RREG32 to do register access, like all other functi=
ons in KMD,&nbsp; and WREG32/RREG32 will let KIQ to do the register access =
If we are under dynamic SRIOV&nbsp; mode (means we are SRIOV VF and isn't u=
nder full exclusive mode)<br>
<br>
You see that if you call this func before EVENT_5 (event 5 triggers VF FLR)=
 then it will run under dynamic mode and KIQ will handle the register acces=
s, which is not an option Since ME/MEC probably already hang ( if we are te=
sting quark on gfx/compute rings)<br>
<br>
Do you have a good suggestion ?<br>
<br>
thanks<br>
_____________________________________<br>
Monk Liu|GPU Virtualization Team |AMD<br>
<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of sh=
aoyunl<br>
Sent: Tuesday, December 17, 2019 11:38 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR of SRIOV=
<br>
<br>
I think amdkfd side depends on this call to stop the user queue, without th=
is call, the user queue can submit to HW during the reset which could cause=
 hang again ...<br>
Do we know the root cause why this function would ruin MEC ? From the logic=
, I think this function should be called before FLR since we need to disabl=
e the user queue submission first.<br>
I remembered the function should use hiq to communicate with HW , shouldn't=
 use kiq to access HW registerm,&nbsp; has this been changed ?<br>
<br>
<br>
Regards<br>
shaoyun.liu<br>
<br>
<br>
On 2019-12-17 5:19 a.m., Monk Liu wrote:<br>
&gt; issues:<br>
&gt; MEC is ruined by the amdkfd_pre_reset after VF FLR done<br>
&gt;<br>
&gt; fix:<br>
&gt; amdkfd_pre_reset() would ruin MEC after hypervisor finished the VF <br=
>
&gt; FLR, the correct sequence is do amdkfd_pre_reset before VF FLR but <br=
>
&gt; there is a limitation to block this sequence:<br>
&gt; if we do pre_reset() before VF FLR, it would go KIQ way to do register=
 <br>
&gt; access and stuck there, because KIQ probably won't work by that time <=
br>
&gt; (e.g. you already made GFX hang)<br>
&gt;<br>
&gt; so the best way right now is to simply remove it.<br>
&gt;<br>
&gt; Signed-off-by: Monk Liu &lt;Monk.Liu@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 --<br>
&gt;&nbsp;&nbsp; 1 file changed, 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index 605cef6..ae962b9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -3672,8 &#43;3672,6 @@ static int amdgpu_device_reset_sriov(struct =
amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_pre_reset(adev);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Resume IP prior to SMC */=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_ip_reini=
t_early_sriov(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Cmonk.liu%40amd.com%7Cee9c811452634fc2739808d7830718f6%7C3dd8961fe488=
4e608e11a82d994e183d%7C0%7C0%7C637121938885721447&amp;amp;sdata=3DFiqkgiUX8=
k5rD%2F%2FiJQU2cF1MGExO8yXEzYOoBtpdfYU%3D&amp;amp;reserved=3D0">https://nam=
11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.=
org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cmonk.liu%40amd.=
com%7Cee9c811452634fc2739808d7830718f6%7C3dd8961fe4884e608e11a82d994e183d%7=
C0%7C0%7C637121938885721447&amp;amp;sdata=3DFiqkgiUX8k5rD%2F%2FiJQU2cF1MGEx=
O8yXEzYOoBtpdfYU%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB3241F577F9502E7C7189B9CDF4520DM6PR12MB3241namp_--

--===============1781167086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1781167086==--
