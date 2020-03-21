Return-Path: <SRS0=lmwh=5G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82E7C4332B
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Mar 2020 08:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B419820409
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Mar 2020 08:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hyGjR8I8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B419820409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB84F6E2DD;
	Sat, 21 Mar 2020 08:44:13 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750077.outbound.protection.outlook.com [40.107.75.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 357D36E2DC
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Mar 2020 08:44:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwqf+QO3b2Qd1dKq8lIIe5umx5oK3n60TGExwSLnHcnlTY91/mb8d38heYSSr7HkjmXDq1ya20HbHbOaoN3E9BmFUepZXQ1DJzm8Lgd/x7yGVbSQGusOJLl29jUMVoYcGf/YkpDrqfrJs+8QH51oEHa7cq8WFZs4SPbAAzs/lpPDHWxn2VplnV0M+oWKu/e7V3FD80m/bjPbavJsuTkcjeu67IqpEeY1V2MO3287jeAFliwAUSECr2c0M/bizy+yCg6/qrj7rmTObZ0uT0+6OcBU1UaEgSqqkCQnoxDokcuG1LtGU7rMKE9Ib1SV9r85WsCbv8/10nf8VXnELy/CcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mx4vVZf19k2+LsTFnPKFS7Hma/unIAgqtXu5uV0XXk=;
 b=QhmLKLJllqarHrV/q6Qt5MPWtKdNCQTa0lw8hn6YNibOKXVIIP5NcGrFL1iMKaYo6/QpKOXBUgdGwJaAqjLwLKL8Kuxx4pHotbC3cfsykqzAw9Qv0joiGJbEi+cW6GExv3qFNO/6Q39C0bwQB9/BKFROPvKazwGSulNyUfbR3M5Vw8++PsioltP+1NumBykrpYZj28ZN90wkNg4CBX0hAkuo7hpIQh4BmeS5YDrU4BGIF0GGDlMWjcoU65gS445Coca+X3om38AwB1wjsCMRyuTS+EI/77t6tFqmowf2C+KL26pJncVQWIBvMeVUY7tlGO6Uj8nbAMR5hPLI9TKsbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mx4vVZf19k2+LsTFnPKFS7Hma/unIAgqtXu5uV0XXk=;
 b=hyGjR8I8n1lYSCwT3TpQ8xl3OIgsqnjH9mPoEYr67bDtngrANk4uw4Zecex9MCO1+bjifZPr7bvg/PXd1I9fEsamHo3KP04V8fvf98Cvdnp7rub/uwS9T95nH1otlwVy300NymTzbrNptPqGACMhor0FmTpksxdeKs4CudbmK/w=
Received: from DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) by
 DM5PR12MB2359.namprd12.prod.outlook.com (2603:10b6:4:b4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Sat, 21 Mar 2020 08:44:09 +0000
Received: from DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::50f0:a148:4f52:701f]) by DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::50f0:a148:4f52:701f%11]) with mapi id 15.20.2814.025; Sat, 21 Mar
 2020 08:44:09 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix size validation failure in large buffer
 creation
Thread-Topic: [PATCH] drm/amdgpu: fix size validation failure in large buffer
 creation
Thread-Index: AQHV/pxq/5aHlhyyKUKSv7VKyR78IKhRzUUAgADqMrCAAAUWYg==
Date: Sat, 21 Mar 2020 08:44:09 +0000
Message-ID: <96951c39-ddee-4bc5-8de0-34a82e93af28@email.android.com>
References: <20200320094615.5524-1-tianci.yin@amd.com>,
 <cb153afb-1e3c-e512-7775-ae144db9aff9@gmail.com>,
 <MN2PR12MB29574DEBC51FC90EC87F122D95F20@MN2PR12MB2957.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB29574DEBC51FC90EC87F122D95F20@MN2PR12MB2957.namprd12.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-originating-ip: [2a02:908:1252:fb60:283e:a3dc:9914:9361]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8a6f0418-a965-4b07-33e5-08d7cd7405d6
x-ms-traffictypediagnostic: DM5PR12MB2359:|DM5PR12MB2359:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB23597A84236478E9B71980AF83F20@DM5PR12MB2359.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 034902F5BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(66476007)(64756008)(66556008)(91956017)(316002)(6486002)(54906003)(19627405001)(5660300002)(31696002)(31686004)(66946007)(86362001)(71200400001)(2906002)(186003)(6636002)(76116006)(66446008)(6862004)(4326008)(6506007)(478600001)(8676002)(53546011)(81156014)(81166006)(9686003)(6512007)(66574012)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2359;
 H:DM5PR12MB1578.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zID2NUL9NzmMZyzlkpzn6quiViknTdDh62/03KVBiar5i6sv5BPU42UI0/MUxGNEVNUABMmkUV45ufFmx3nTtSmes07bDsDPZQzvt/a9TE0h8wfr1TzSDApgQKSuoc9VqVAPvXYRTaUqOGOxstklEKx6+ZVNKaRZUISLfQvp/curNo6PKyhPfmnoTIhtXCIuNdho3BdI2uaKCa27QSOM/WsPkp0OCsls7vQ1edLEAWyYJkm1J+3ux2je5XLixVWkVd5NNQGxY5Hl3uE0P+RaZZ81tzg/bAbIWp5qrw78t8iN/5g0y7KIz6KOmwMC9S6wzo9Mr4nBVb1fx/Q7djmbtKDHKJMV3j/3s4fj9s/c37EBsSu5mNeAZqWckoEbtS4lJgSGlYgvNAaUVbZz3FPa3tNMf5h/l+xFA6co4TS/4pvMf7W9zyp0JeHRJPYggr5k
x-ms-exchange-antispam-messagedata: LS64rzp4tSny1oeRl6MSrGu/rg7U2WnicSw+O+H9iq0RguZQLf4ysqejTzZ9L6/jM/ESUMxl2dxQFDsQrt+kRiSCoeuN9vcshhf1Rf/KaN3FM7VwQIm4XHg6C0pOrga49+0ef+Xc7cFCSZIB+xrJrrhBM1RDV1qmuJOp+ZqwSCW9A5cZA9hKJsphsw5AGKZvTTlNQQEFKs3l9Og1zvy3gQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6f0418-a965-4b07-33e5-08d7cd7405d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2020 08:44:09.2889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8yQXfu3J3h++8nFjbgBp3iL0AkJovCdBeO1uQxZyKRABmo4MWx76f2C9brn1WcG1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
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
Cc: "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Li, Pauline" <Pauline.Li@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Long,
 Gang" <Gang.Long@amd.com>
Content-Type: multipart/mixed; boundary="===============1865174135=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1865174135==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_96951c39ddee4bc58de034a82e93af28emailandroidcom_"

--_000_96951c39ddee4bc58de034a82e93af28emailandroidcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Correct, yes.

For example if you have a 16GB VRAM Vega10 in a system with just 4GB RAM yo=
u can only allocate < 4GB VRAM (actually more like ~3GB) in a single BO.

Otherwise we wouldn't be able to evacuate VRAM to system memory and disk du=
ring suspend/resume or during memory pressure.

Regards,
Christian.

Am 21.03.2020 09:32 schrieb "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>:

[AMD Official Use Only - Internal Distribution Only]

Hi Christian,
You mean amdgpu_bo_validate_size() return false is the expectation when GTT=
 < request < VRAM, even if VRAM size can meet the requirement, right?

Thanks!
Rico
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Saturday, March 21, 2020 2:27
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Li, Pauline <Pauline.Li@amd.com>; Long,=
 Gang <Gang.Long@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix size validation failure in large buffe=
r creation

Am 20.03.20 um 10:46 schrieb Tianci Yin:
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> [why]
> When GTT domain size is smaller than VRAM, if APP apply a very large
> buffer whose size is larger than GTT but smaller than VRAM, the size
> validation will fail.
>
> [how]
> Validate VRAM domain size at first place, then GTT domain.

NAK, this is intended behavior. VRAM allocations larger than GTT
allocations are illegal and can crash the memory management.

Regards,
Christian.

>
> Change-Id: Ic1d31b9b0a4939e6bba0241ff79ae9aa2225ee05
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index 84745f9e7408..bab134b6369f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -464,21 +464,21 @@ static bool amdgpu_bo_validate_size(struct amdgpu_d=
evice *adev,
>   {
>        struct ttm_mem_type_manager *man =3D NULL;
>
> -     /*
> -      * If GTT is part of requested domains the check must succeed to
> -      * allow fall back to GTT
> -      */
> -     if (domain & AMDGPU_GEM_DOMAIN_GTT) {
> -             man =3D &adev->mman.bdev.man[TTM_PL_TT];
> +     if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
> +             man =3D &adev->mman.bdev.man[TTM_PL_VRAM];
>
>                if (size < (man->size << PAGE_SHIFT))
>                        return true;
> -             else
> +             else if (!(domain & AMDGPU_GEM_DOMAIN_GTT))
>                        goto fail;
>        }
>
> -     if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
> -             man =3D &adev->mman.bdev.man[TTM_PL_VRAM];
> +     /*
> +      * If GTT is part of requested domains the check must succeed to
> +      * allow fall back to GTT
> +      */
> +     if (domain & AMDGPU_GEM_DOMAIN_GTT) {
> +             man =3D &adev->mman.bdev.man[TTM_PL_TT];
>
>                if (size < (man->size << PAGE_SHIFT))
>                        return true;


--_000_96951c39ddee4bc58de034a82e93af28emailandroidcom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta content=3D"text/html; charset=3Dus-ascii">
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
</head>
<body dir=3D"ltr">
<div dir=3D"auto">Correct, yes.
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">For example if you have a 16GB VRAM Vega10 in a system wi=
th just 4GB RAM you can only allocate &lt; 4GB VRAM (actually more like ~3G=
B) in a single BO.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Otherwise we wouldn't be able to evacuate VRAM to system =
memory and disk during suspend/resume or during memory pressure.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Regards,</div>
<div dir=3D"auto">Christian.</div>
</div>
<div class=3D"gmail_extra"><br>
<div class=3D"gmail_quote">Am 21.03.2020 09:32 schrieb &quot;Yin, Tianci (R=
ico)&quot; &lt;Tianci.Yin@amd.com&gt;:<br type=3D"attribution">
</div>
</div>
<div>
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#0078D7=
; margin:15pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Hi Christian,</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
You mean&nbsp;<span style=3D"color:rgb(32,31,30); font-size:14.6667px; back=
ground-color:rgb(255,255,255); display:inline!important">amdgpu_bo_validate=
_size() return false is the expectation when GTT &lt; request &lt; VRAM, ev=
en if VRAM size can meet the requirement, right?</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"color:rgb(32,31,30); font-size:14.6667px; background-color:r=
gb(255,255,255); display:inline!important"><br>
</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"color:rgb(32,31,30); font-size:14.6667px; background-color:r=
gb(255,255,255); display:inline!important">Thanks!</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"color:rgb(32,31,30); font-size:14.6667px; background-color:r=
gb(255,255,255); display:inline!important">Rico</span></div>
<div id=3D"appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Saturday, March 21, 2020 2:27<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Li, Pauline &lt;Pauline.Li=
@amd.com&gt;; Long, Gang &lt;Gang.Long@amd.com&gt;; Zhang, Hawking &lt;Hawk=
ing.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix size validation failure in larg=
e buffer creation</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Am 20.03.20 um 10:46 schrieb Tianci Yin:<br>
&gt; From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
&gt;<br>
&gt; [why]<br>
&gt; When GTT domain size is smaller than VRAM, if APP apply a very large<b=
r>
&gt; buffer whose size is larger than GTT but smaller than VRAM, the size<b=
r>
&gt; validation will fail.<br>
&gt;<br>
&gt; [how]<br>
&gt; Validate VRAM domain size at first place, then GTT domain.<br>
<br>
NAK, this is intended behavior. VRAM allocations larger than GTT <br>
allocations are illegal and can crash the memory management.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;<br>
&gt; Change-Id: Ic1d31b9b0a4939e6bba0241ff79ae9aa2225ee05<br>
&gt; Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 18 &#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;---------<br>
&gt;&nbsp;&nbsp; 1 file changed, 9 insertions(&#43;), 9 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_object.c<br>
&gt; index 84745f9e7408..bab134b6369f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; @@ -464,21 &#43;464,21 @@ static bool amdgpu_bo_validate_size(struct a=
mdgpu_device *adev,<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_mem_type_manager =
*man =3D NULL;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If GTT is part of requested domains =
the check must succeed to<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * allow fall back to GTT<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (domain &amp; AMDGPU_GEM_DOMAIN_GTT) {<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; man =3D &amp;adev-&gt;mman.bdev.man[TTM_PL_TT];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (domain &amp; AMDGPU_GEM_DOMAIN_VRAM)=
 {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; man =3D &amp;adev-&gt;mman.bdev.man[TTM_PL_VRAM];<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (size &lt; (man-&gt;size &lt;&lt; PAGE_SHIFT))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
true;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; else if (!(domain &amp; AMDGPU_GEM_DOMAIN_GTT))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fa=
il;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (domain &amp; AMDGPU_GEM_DOMAIN_VRAM) {<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; man =3D &amp;adev-&gt;mman.bdev.man[TTM_PL_VRAM];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If GTT is part of requested doma=
ins the check must succeed to<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * allow fall back to GTT<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (domain &amp; AMDGPU_GEM_DOMAIN_GTT) =
{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; man =3D &amp;adev-&gt;mman.bdev.man[TTM_PL_TT];<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (size &lt; (man-&gt;size &lt;&lt; PAGE_SHIFT))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
true;<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_96951c39ddee4bc58de034a82e93af28emailandroidcom_--

--===============1865174135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1865174135==--
