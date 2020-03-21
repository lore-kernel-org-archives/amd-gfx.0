Return-Path: <SRS0=lmwh=5G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653B5C4332E
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Mar 2020 08:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B2320739
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Mar 2020 08:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="moDJNsl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B2320739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C6D36E2DC;
	Sat, 21 Mar 2020 08:32:04 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750071.outbound.protection.outlook.com [40.107.75.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1C396E2DC
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Mar 2020 08:32:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwRpQrVaxI71EiP3/Dsz4znPLqmzi7WKu04npAROvc/RK9LOx/rqaSOm8JIpG79GlHXjCnn/hFLi+1IBb7yjPbguWwFv1P3roG6L0IegtgoAy3WbfkDJeeJKvT5F4dPG31JM68r0wmOMTRFHPTJgN/AJi4lUnnQI6K1m+qOAyr+QoZg9WBVaoRgcDSdem85+Y2+GWOguu8vQGO6rCnrys+7J7eR3c70EKznoQiVdtYBz+OP0XVmt8rnSIyMGNwmutmy8ACfHqP0lrKy7ksCWNyFzCJTtOAEsunYKRHsPCQaIYB99q8DbfS1HFH73MYsVJTyUVhg3PWVmmtRuVvqGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYSxctPL9+cJrN0poWPPsh4HOHs8wYVDRA9X21O26ks=;
 b=BZAT7fjy+KyylJXqXnR7EsOFBfL5ousYbw+H8LHsfT0+tOs03oJwG+kATxU6lpaVhe8Dxk+9itjzDvBMs5CGJ0/skwoxHr8QqZHdr6R+/VpF/6rBmv8OJSvIIU5B+gmdtMb1R/EoW8olOEwA1RwArxWiAEtwYcD6A1Fh36vyUg3Qkm/NrgOE9vsywdpmTQ27pGRuFo4nkQG/Kfdpu/r0neinPej6g+SK6MziQKbjGy7YK62RFnNhpSO4U6QkRSEgEqaCE3cNRXzxCU2PdW0G5nd+dScYlRdX+oBTky+JBF+2Pekk1trAdrLWk8r8dyqjQWVhdv60+d8/9C2TyhqyXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYSxctPL9+cJrN0poWPPsh4HOHs8wYVDRA9X21O26ks=;
 b=moDJNsl3bKl1XW8JrYoWS8EMGP8sfrYXjSChxpmM4qAFPcbyZkPUGgho+olkna5pfdS2uxULUZxnvVHwv64xwFSq0i8K9jhWZJkRrP4XhxgZZfkiVEMUmVjdJ9QnGN3sF+LCDPybGtB1Dwxo/08v6/8aJ69NDc2K1eo28utSLZE=
Received: from MN2PR12MB2957.namprd12.prod.outlook.com (2603:10b6:208:100::14)
 by MN2PR12MB2880.namprd12.prod.outlook.com (2603:10b6:208:106::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Sat, 21 Mar
 2020 08:31:59 +0000
Received: from MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::cc84:be2a:e761:5914]) by MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::cc84:be2a:e761:5914%6]) with mapi id 15.20.2835.017; Sat, 21 Mar 2020
 08:31:59 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix size validation failure in large buffer
 creation
Thread-Topic: [PATCH] drm/amdgpu: fix size validation failure in large buffer
 creation
Thread-Index: AQHV/pxq/5aHlhyyKUKSv7VKyR78IKhRzUUAgADqMrA=
Date: Sat, 21 Mar 2020 08:31:59 +0000
Message-ID: <MN2PR12MB29574DEBC51FC90EC87F122D95F20@MN2PR12MB2957.namprd12.prod.outlook.com>
References: <20200320094615.5524-1-tianci.yin@amd.com>,
 <cb153afb-1e3c-e512-7775-ae144db9aff9@gmail.com>
In-Reply-To: <cb153afb-1e3c-e512-7775-ae144db9aff9@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-21T08:31:01.105Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianci.Yin@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 62ee1633-018d-4180-0dbc-08d7cd7252ac
x-ms-traffictypediagnostic: MN2PR12MB2880:|MN2PR12MB2880:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB28801BE0B1A3E6535ECF550C95F20@MN2PR12MB2880.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 034902F5BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(199004)(66446008)(4326008)(2906002)(6506007)(186003)(71200400001)(6636002)(9686003)(8936002)(66574012)(478600001)(81156014)(53546011)(26005)(8676002)(81166006)(7696005)(19627405001)(52536014)(54906003)(5660300002)(64756008)(76116006)(66556008)(66946007)(91956017)(316002)(66476007)(55016002)(110136005)(86362001)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2880;
 H:MN2PR12MB2957.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0dSBYSAJxmDnQBbXDEp2Jysb+Mk3b1XZJsABW7HqYNB9j3WMqt3npXDcValv4KE9vaMs/kPib9jGs3pbnNFk44rb3IihPkjsOp7e12TdYXoJk9TVaVHBy0dNkvtRLR7XTmPDuo5C2EYc6O7qffG52q13RgSGpTL1Gq+pcTIgV4RZvKXKH+ZlJv8M5uxH3n+iCRx+7bG9ph83Q2iKARfDogSN8puBI5YAcGXQlf8K1f2+/GE77aptTewlaCt6eeEnTw6DoScf0qnl4w3ist4m3z3OZTNk0xBvLyggZdRIX20Mrq25Hp9UGc6cBtdPyEHZTVwNfEsOgUTCHIh234LZyKytuYwGqdimgBNWMarsmhsqIyF1tSN7Z0bF7QgDoC1s21l7avTlOv8BEIjp/El2l6dhoNywd7mRQwQ8KX9vkh5SFp4YTOTx5utHitcFDqR0
x-ms-exchange-antispam-messagedata: 4Zfq2f95u0XojXsVPpsTAV4jZ0eewXk0+ewufeniaH1gxAAX8UNwPwKs3k2C2mspsx2UgjKcC2u/pQsaz9B1iCr1JnAv7w0rx/s7YN5ogZlof3EkNovhX4v1IMDzbrn+Qy6/NKnDPGOim/julXKveg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ee1633-018d-4180-0dbc-08d7cd7252ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2020 08:31:59.1738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WAWFNaEX6WMjdHFj9F+m5j3JmauOH32VwzK+5O7j5AHkH5JMoAVlJYWe1cWBv0SaIifzExjFhsZH4uPeQnuiMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2880
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Li, Pauline" <Pauline.Li@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Long, Gang" <Gang.Long@amd.com>
Content-Type: multipart/mixed; boundary="===============1671286772=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1671286772==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB29574DEBC51FC90EC87F122D95F20MN2PR12MB2957namp_"

--_000_MN2PR12MB29574DEBC51FC90EC87F122D95F20MN2PR12MB2957namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi Christian,
You mean amdgpu_bo_validate_size() return false is the expectation when GTT=
 < request < VRAM, even if VRAM size can meet the requirement, right?

Thanks!
Rico
________________________________
From: Christian K?nig <ckoenig.leichtzumerken@gmail.com>
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


--_000_MN2PR12MB29574DEBC51FC90EC87F122D95F20MN2PR12MB2957namp_
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
Hi Christian,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
You mean&nbsp;<span style=3D"color: rgb(32, 31, 30); font-family: &quot;Seg=
oe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;=
, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sa=
ns-serif; font-size: 14.6667px; background-color: rgb(255, 255, 255); displ=
ay: inline !important">amdgpu_bo_validate_size()
 return false is the expectation when GTT &lt; request &lt; VRAM, even if V=
RAM size can meet the requirement, right?</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(32, 31, 30); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(32, 31, 30); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant">Thanks!</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(32, 31, 30); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant">Rico</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K&ouml;nig =
&lt;ckoenig.leichtzumerken@gmail.com&gt;<br>
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
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
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
</body>
</html>

--_000_MN2PR12MB29574DEBC51FC90EC87F122D95F20MN2PR12MB2957namp_--

--===============1671286772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1671286772==--
