Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F74DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 14:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F2AE60EB4
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 14:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2F2AE60EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC0F789FC3;
	Tue, 26 Oct 2021 14:58:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8529989DED
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 14:58:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naffXEgnpYuv2M3m/7pyplZVx5JR3IYGJJPBEU7uuEjFTrCFzhLrWJ9eZOWO7YqdYeDLghjiPm3IN2+s1Y8SynHlnXwuKbBflVpJdfcNZNVCE1uIvN6uFJsE8VQy4HYtSSPTkf294+6XfEfwO2avZbto/W6wREN8cs1EMqmKzcG2lbmXIqgbOqKBoCBXJYMy4v69i5vLm8qbfbOCJKt5eF6HXwAipM8XJmDYXXnwQrrszriuVplApPzE1J58J4Zpmg8wgRN8vVISflsYD5i3b4+cey+a9/Ei4QjOpINLE7Ze4HgTfLKXRFdFN89DZ3wpq4gC7G1/fpSwWyzzNDN3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTjYqj0db4yjD65SnDbU6CJTkiIBpmW3fYZ4s6LO4yY=;
 b=LOORlqKQykGD0Jx0NujiZigUDOdOnsKiyFcn+l6aGtPtdXuFrKYOaxTMzY92uDsdeN6ZrW3WX4tEbo1xlRKMwArg56flbQaNLPxum8lfylh+SY88S0pRpS4QwKPnQB9tZ2QNA5aVRm3AlaFKD2fcbycra7WkOeR+wwq5Wlvinx8F/C1yUaRU98GC/Y/aUj1/GRtBMHLVT7GcmbN4TUa7RKEJQYHGZctsx6rjubLOQArRQ99aTq0RSQlzTSlFAtVeEg5DUK2QKAODnxR6d9BY7umDpiXhgbftKgeJeh3zCW0SJVEOh5mZs+Xz49AGbWl8UMvh7MtcVwsZSY9ut15ytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTjYqj0db4yjD65SnDbU6CJTkiIBpmW3fYZ4s6LO4yY=;
 b=YHIBys08Zty3vCL0S/vVUx9cdzANLGEhtrSjTxHWzqShZABtAy6wuNRmC4/sxCzRnMYpo0Mfvyo58+xdfHAe0WP9hq8RWAwHbsXB2fQpfjBGpZYz1tIO8WMspDHInK8DmVdNVCfpb3rB5C6PyVeQ4WjYuMID+PyXxJlsv+/Pfsw=
Received: from SJ0PR12MB5488.namprd12.prod.outlook.com (2603:10b6:a03:3ad::15)
 by SJ0PR12MB5455.namprd12.prod.outlook.com (2603:10b6:a03:3ba::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 14:58:26 +0000
Received: from SJ0PR12MB5488.namprd12.prod.outlook.com
 ([fe80::f05e:325b:80ea:c723]) by SJ0PR12MB5488.namprd12.prod.outlook.com
 ([fe80::f05e:325b:80ea:c723%5]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 14:58:26 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/pm: look up current_level for asics without pm
 callback
Thread-Topic: [PATCH] drm/amdgpu/pm: look up current_level for asics without
 pm callback
Thread-Index: AQHXynhU4akyIZm/6UuNafhssGN+/KvlXiYi
Date: Tue, 26 Oct 2021 14:58:26 +0000
Message-ID: <SJ0PR12MB5488F018A8C6DA3CBDC60FEF82849@SJ0PR12MB5488.namprd12.prod.outlook.com>
References: <20211026144639.191828-1-alexander.deucher@amd.com>
In-Reply-To: <20211026144639.191828-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-26T14:58:25.113Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 9d64763a-70b3-2699-16cb-13563ee58b21
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fea43ad-aaca-49a3-4228-08d998911096
x-ms-traffictypediagnostic: SJ0PR12MB5455:
x-microsoft-antispam-prvs: <SJ0PR12MB545568A47F841DF26F9BFAE682849@SJ0PR12MB5455.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 15E+lNCAgeGOgNrfaYxY1YKCiQkbcy7FGxmTUgZM5dHrsL+day6+lIlSXAnsdlPgn2fbebHsvmOjPPceWW3lwLWLG7nO696/XCImlqCoRm9auwTKPy++lfU6zi7VrSf8dLMbLqgZ2tHZ37b/seqBSuZty4tlyh9qqTk7LG6hudEwhle3Nx+NnEVF+O1CqYBpRxvXEKIC8Bbv2fd7UENlhIRgeRE3myLWYmxBjsB4E8DgtbdX3ThwU5rtcqGJEc7TOWqOgEtNEFWpJisuMSD9DoY2nMiq0pOAiZnddUZKhrb5xQL1TnxyU2cW+J66CuIjIkDLTLHKCjKzOhsg/QUm9sJM/9w71MhVWfio2o2XEOtIZ2WE8bflYAe5bw72buxZbVflGgBXOQsT+PsB6gTqsT6OwLkLRwbBRqAQnl07v1doMHYPf6JE9sA/8rC7pBLqXc9QdhPjclArcS0bb2PkGdblzfD46DGWxAoJzMxYVDHTkGBN2YYPc7wdM+luM7rRWjjmnaiveeSKyYQoPnQqrTgLp1waE4JWXtMzBxVcFg3eXVbTqNUc2TH7FGr7FfxWIWB+15/52Bk4vfWp0vd4njQDZxXzTIXsT47sYULkvF12L6iRKnM39fOz9GM6u7NfcHW0NDIIePfsI4Nx8NfQO8xGEojQTf7gH+87odR4VXsnKic2SZDIEuIDfIdhhvkIOUfXPDyoFRjgv0jWABENlg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016002)(6506007)(83380400001)(33656002)(316002)(8676002)(186003)(19627405001)(38070700005)(508600001)(2906002)(122000001)(71200400001)(66556008)(86362001)(110136005)(9686003)(66446008)(91956017)(8936002)(76116006)(64756008)(66946007)(26005)(66476007)(5660300002)(38100700002)(7696005)(53546011)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?u1Wh1/duXBCUDHZov3lVSyocSn21pImh3fZJuJa5jTDPAb7lTEYVpFyhsH?=
 =?iso-8859-1?Q?w5qu2y5YQqHHhEEjasVGOqgs3/5KS2im8yg66fdIp2PxUyY7MAfILZSAar?=
 =?iso-8859-1?Q?0fJ7iHVwTvYTXadu+5v9BBk4iugq/H+o7zh2SGw32NvYRdO+gsTdd3Q70/?=
 =?iso-8859-1?Q?srFqF6ZQFNhFuxM0YhVaF2/gkDZVDtIjGh4ga21omDG/XXH5c0FVaHVmX4?=
 =?iso-8859-1?Q?PaRj3yT2mi6zzgZczrZ0RkEojcIpGvpWzkdGaCBM3bx4V+vk9LxpmP2Ldo?=
 =?iso-8859-1?Q?lOcyP25favXcIG4/1NxTI4pU/aea34wk7S5LlmcF/fy2G/qNzItZILIRfh?=
 =?iso-8859-1?Q?etph+IhyyRsXlunLlf/XXzJ97ITUjoCs49yh79SQroFI6SlAbq0P5A2Uqg?=
 =?iso-8859-1?Q?rslWSwZNiZ4lhFcdsBCMN354YKfrrw2k6qjxjqoMTAlFJlv7ghunackw+R?=
 =?iso-8859-1?Q?138EYa0P1ya1qkxkDWsWNG5+d+gu8pwsRX/9TwvMwUpn9Ilb5SBUglPf6d?=
 =?iso-8859-1?Q?9p1AluzvL5iowa7y972uIgdpvBuYSzzfMdLYfsG+kUE0LbPOGruUrSTSg+?=
 =?iso-8859-1?Q?UMHClUx4ush3GiMCpbYJZHNzS2oG8EOM0HX9eQoVvY/jGejJaNE1GFv/Ig?=
 =?iso-8859-1?Q?5fOAsP1VU+agbDIn1lwQJFiGcXKQa6ffc9aQl3QBpybFhL/HPAxKJz88/m?=
 =?iso-8859-1?Q?+pgp8cku8BZ7ze6N9P6dytCbuutYZP02huz6sWZHH5EaT5meXXXpvSa0aI?=
 =?iso-8859-1?Q?IyhUXlm0fAdb+GQt0LTTmM90q+Ang6c3R2gtwuCIrzeG3fNgL6QM7SUHHz?=
 =?iso-8859-1?Q?GCboZw5HuldULuWCMmvfxUGjab629JKLnHb8ARWzaLodduuZvVSFT49+WS?=
 =?iso-8859-1?Q?wjzjwbSkrWu7UainDjd8FasNMh5CUoCIpMdElEUiGXbrE0HAI+bNqvmPdJ?=
 =?iso-8859-1?Q?006S3jBxPlaYruDn2lb/99yeTwFFhXw0RBdpvm5Fs7DJBR8+nujrSWPoYF?=
 =?iso-8859-1?Q?rFX1sPqpLm5aKtvSC/N10rq/gVsfnKRQT0r8DImUxwJT5ROLZYAGdjDyjb?=
 =?iso-8859-1?Q?bqFrA9XQ9QcUSywmOBAZqnQMdIsNjHLzRjYNbRLl718KDo5Xe7pbNc5FQQ?=
 =?iso-8859-1?Q?4zKgKVsilcE7qyL+3alYLp7HpVXuJgdQGh4P1U+sjHpLH7rzxAvSzmnc6i?=
 =?iso-8859-1?Q?9Cm9HyNCeNTfpcFc0r3RHJqk8Ezb0g3qQ+aiBwcSRi98GC+jQS15VcFPJQ?=
 =?iso-8859-1?Q?lESSClAzHCWcyrNgEPo5KwSbCvGNRegCHx+UdBx4qEvsjEiyrTtNGWWKd+?=
 =?iso-8859-1?Q?mmWtvBeWKrN+SQ/Yxu9a5RxlAf26itCXtC5nkzUmumPO5ShcdkQFDhrrTc?=
 =?iso-8859-1?Q?s5BQ4VC8pU/NdQxxQNHSYUo1AhlAFLtGs3XXQMpMIt7hLA3tHYo28WNsg9?=
 =?iso-8859-1?Q?gsW27Foc0H0L0a3RkHcwmIeo03ohYdGrU5gKf1SnIwv4YGM6y67z50qH2K?=
 =?iso-8859-1?Q?bUQ5CJBtmh9xAK5jt1Qrtx0XUEO4JYBXJYAQKIytdg/45zYiUckmUIk+wG?=
 =?iso-8859-1?Q?p1KrDpCfdgyVCx+yJS6oBz40LsVyS7kvCSgT4aGpNEkJcTammg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB5488F018A8C6DA3CBDC60FEF82849SJ0PR12MB5488namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fea43ad-aaca-49a3-4228-08d998911096
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 14:58:26.3895 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ylqoVQYmBLQQdTeGJhkOxUALN4pEBiPH6Y6ydEQj8gLUEiG1fgnKhnRPPETVXM3o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5455
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_SJ0PR12MB5488F018A8C6DA3CBDC60FEF82849SJ0PR12MB5488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Kevin Wang <kevinyang.wang@amd.com>

Best Regards,
Keivn
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexander.deucher@amd.com>
Sent: Tuesday, October 26, 2021 10:46 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/pm: look up current_level for asics without pm =
callback

For asics without a callback, use the current level rather than 0xff.
This can avoid an unnecesary forced level set on older asics when
set by the user.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 01cca08a774f..49fe4155c374 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -310,7 +310,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_l=
evel(struct device *dev,
         struct amdgpu_device *adev =3D drm_to_adev(ddev);
         const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
         enum amd_dpm_forced_level level;
-       enum amd_dpm_forced_level current_level =3D 0xff;
+       enum amd_dpm_forced_level current_level;
         int ret =3D 0;

         if (amdgpu_in_reset(adev))
@@ -350,6 +350,8 @@ static ssize_t amdgpu_set_power_dpm_force_performance_l=
evel(struct device *dev,

         if (pp_funcs->get_performance_level)
                 current_level =3D amdgpu_dpm_get_performance_level(adev);
+       else
+               current_level =3D adev->pm.dpm.forced_level;

         if (current_level =3D=3D level) {
                 pm_runtime_mark_last_busy(ddev->dev);
--
2.31.1


--_000_SJ0PR12MB5488F018A8C6DA3CBDC60FEF82849SJ0PR12MB5488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Kevin Wang &lt;kevinyang.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Keivn</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexander.de=
ucher@amd.com&gt;<br>
<b>Sent:</b> Tuesday, October 26, 2021 10:46 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/pm: look up current_level for asics with=
out pm callback</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">For asics without a callback, use the current leve=
l rather than 0xff.<br>
This can avoid an unnecesary forced level set on older asics when<br>
set by the user.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 +++-<br>
&nbsp;1 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index 01cca08a774f..49fe4155c374 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -310,7 +310,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_l=
evel(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D drm_to_adev(ddev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs =
*pp_funcs =3D adev-&gt;powerplay.pp_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_dpm_forced_level =
level;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_dpm_forced_level current_lev=
el =3D 0xff;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_dpm_forced_level current_lev=
el;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_in_reset(adev))=
<br>
@@ -350,6 +350,8 @@ static ssize_t amdgpu_set_power_dpm_force_performance_l=
evel(struct device *dev,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pp_funcs-&gt;get_perfo=
rmance_level)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; current_level =3D amdgpu_dpm_get_performance_level(ad=
ev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; current_level =3D adev-&gt;pm.dpm.forced_level;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (current_level =3D=3D l=
evel) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev-&gt;dev);<br>
-- <br>
2.31.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SJ0PR12MB5488F018A8C6DA3CBDC60FEF82849SJ0PR12MB5488namp_--
