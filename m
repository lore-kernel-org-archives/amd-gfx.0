Return-Path: <SRS0=xwvD=6L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E91C54FD0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 13:02:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC47206BF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 13:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lDu15nPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC47206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9525889A1F;
	Mon, 27 Apr 2020 13:02:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FB6F89A1F
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2020 13:02:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qty+3pbAGA/MppeO/9XguEJpQKdSPdbLr18rADCW+M3YyyWwFGMj028/uIYMhOvzqbDVL7AOR8Q8evJWXpB2nxkbsMpm2wD4d01P7ELbuyHQ53EoVCkrEBLmKIUNHGAHKbJW5PS+orU+DRpOVNC8GC03Iz/eR7igJWjwBNRlFtF134TBm39QKouqkx1Aslm18DBxS0FFaSs5D3kp5fvQCEbkQiRE6ezsm9uKkNkH/zGKyiV/jup0kI7mFDcUxgLZNc/PM57DzuPU2XzTLRXfyECD7NDIiMggLAQC05/LaoZ/0OcFASeEyzUah7c3MOea+1Bz4Bqe+oOZ6uH1YxAIbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gs7BlYMrj3DzvLgnAAUOus4Wx4n1QOeSVzC2DZ/S4kA=;
 b=T+cgVufnaMXJuC0tFr1e9jcM4fC/Wv3G6aqzNFCjkyMeTZ53Bqk0U1bY19V1cKI4ZhZ4pwqRB0lCSDED9D07p23VGDV94KiHWMdJWCr+0JDhPP0Dh8XPKp41pemQRsqcZkWmTAO9hMUxTNegQOAGuhJiArNz1BcoBUH6qV3Jf/h7m/5rj39dQwcX47oA9jer5pcAJNQMst99W0UYYDyE8cdui1/zi9l805E1PxE2mOV+L/Kg5diSQ/ewrvB8LwYBYja+asTOjIjRwHkqyA4WeXG6OghHXFYQdQGxB2Pu/oxJtfqylLgRa1SkucHTWhAsllk0DbFC7AqjgZXs09Jy6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gs7BlYMrj3DzvLgnAAUOus4Wx4n1QOeSVzC2DZ/S4kA=;
 b=lDu15nPNZFeuq+icORds3vDgust1fnUC2ZK2jhPgDqTwQmHLbxOGgcxUK18AgNypyuQVWEsfs91xa5jNkioA+Hb7AfLNDIG/cXqfWCI/FCzd20Z/oBjBSc5KdqDPeR7POhUAb+ZiiRwOnjdkMb8yiRmw+PMX0L6J2ywbdx1yAXM=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 13:02:41 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::9dee:2a71:22d6:2941]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::9dee:2a71:22d6:2941%6]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 13:02:41 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?Windows-1252?Q?Marek_Ol=9A=E1k?= <maraeo@gmail.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: Re: drm/amdgpu: apply AMDGPU_IB_FLAG_EMIT_MEM_SYNC to compute IBs too
Thread-Topic: drm/amdgpu: apply AMDGPU_IB_FLAG_EMIT_MEM_SYNC to compute IBs too
Thread-Index: AQHWGt8OaSgu9lvFPUK6UpS3THAs1KiJ77gAgAChzwCAAIm0AIAB1zRL
Date: Mon, 27 Apr 2020 13:02:41 +0000
Message-ID: <MN2PR12MB448809E68050B9A61B1CC7FAF7AF0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <CAAxE2A64Z91LiB9FduJf-8OO3He+1gZ9sxDfD+BVwc+-9Z7BnA@mail.gmail.com>
 <64c5a883-1933-c494-7a93-dc19e0bd0445@gmail.com>
 <CAAxE2A6Hgnq_zBjQQoa51S7KfVzddjndRGjrJYtjY7v9+vuwDw@mail.gmail.com>,
 <328ea10b-1453-371e-7392-54e1a4051715@gmail.com>
In-Reply-To: <328ea10b-1453-371e-7392-54e1a4051715@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-27T13:02:40.864Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.72.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ff452b8b-fdab-484d-a83e-08d7eaab4525
x-ms-traffictypediagnostic: MN2PR12MB4221:|MN2PR12MB4221:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4221EAB998CED1AB9A781981F7AF0@MN2PR12MB4221.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(966005)(52536014)(9686003)(55016002)(478600001)(2906002)(186003)(4326008)(6636002)(86362001)(26005)(19627405001)(53546011)(110136005)(8676002)(7696005)(6506007)(316002)(66946007)(66574012)(71200400001)(66476007)(64756008)(66446008)(76116006)(8936002)(81156014)(5660300002)(33656002)(66556008);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7uzWIM549g0Ix48Oxs40maOVPQfZ6Kq/KarF5FvUgL240gMj0kphiPEcOghEGeBCby5qC7s9OUvUCUcHEbU2GSuZoi5ey5v+h3Q8DSj95DieZZQB3T2So7NBeEVILppEJdbFOA1KFQ08icAt0OC6gXcXTtUATIRG+9jGlUoFxo84buK550nYtnyoePjrggvPE0LHPNKzzsXk/1dC/VS3RUfH4mvN/YYja+3GvGTlMYcwJjWccxbV4wHheJHbTxftsnv5Ola4o+yaHtvCXC8B7mz3CZiEtNfuiDDLfxce8bGpskVlgOqcPL8n6unku/v8PcVaUI7Hn+HATDGtMT3Rj/DGnVcrg68wvrc7oO2xQf7d3GYp17DRvAHhIeoSJYuLGWyFtawLRVW5CjZOjBp8KE2dgFwrQ95aApgyjEk96aoC0YtFuxoptJ9RyO5148UiqCJu2qTKZRaAuhxX6CG2Oyeb1cLyjm9AkY3v+7dUFbM=
x-ms-exchange-antispam-messagedata: flsajZeF4s6TLGKaz1rWC+E0k7ILU1HYaq2L/paM7+j/+Q4nv1GFvjD5JmLwGAZBZ8iWGfk8ywSCOi8dA0ilNEMtJmt1CBFiAXb42BATvP+WTWlSZ2q+i8IuCI0bM3oxI6Kwgo3ysL1OANtRvl1Gf21ROv3WQ4YujlqdIV0DTqj+DBRC7C6yunbbBcmccAuBZSolX/xomRFKYHM4O5PZmYk5EYP+qEfBnv8lluGDlrDsb5HZaPJ7rDp84Lc7G2i5Ti3+D2Uxg8248K0IqooQPJzsSA9BiZAtYxr1Tt2XwVU7eVT8rYymlsN8gFCzVMR69F78P8rrc0xvbgVnymZJ5e9wr9ecX2fWu0eKmFMtQxptqFEd5e5RKORbKCneKJl5Sq07DRtabTs0k8CLbdOPxpTCs9RIEQ9JxPL/Cfqc9ofxLYsTKArj4wvK3WRNLwogcWXUTuYF56vlsJDK66sUQGn/LBxiY8doZKLpgcJvR89O8QrsM1/iDDedw2qY59qnkUSCYEjtJ68HURJ6hVWj6vhKsJs5q521BHtLAH7OhGMaFyHrfC/GqxcHJAgXx8w9okI83b6Af12cYdJb5Yxj1NBpqV0UC+3qnd4Szb47sviUC1bNrGMIhrhTm5eBO7jbOccxri0BsyaVma2E7oaxdg25FOqj6H9aoHoQMs88RWH9v+MgQB7RxxIn4wrO9F1Q/Y7Ncb7tGIDpLYCUvvVDFgBKWPQMqPOhLu/eVlx+xzZwHNFkuRgHAeKEPRgVWHBSBhBQsdZQGjllcppCuOvpMKXol2IlCc+MI4h+sGkRFT0=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff452b8b-fdab-484d-a83e-08d7eaab4525
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 13:02:41.5562 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CmO10j442KG36NAsE9LIfVZftPZCYfgEWJxkWqGL8RCcN2WEPlYiuUcF97VHKHqTvf9BARVY3tzFAodRd/4jYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1969654541=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1969654541==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448809E68050B9A61B1CC7FAF7AF0MN2PR12MB4488namp_"

--_000_MN2PR12MB448809E68050B9A61B1CC7FAF7AF0MN2PR12MB4488namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Do we have open source code UMD code which uses this?

Alex
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Sunday, April 26, 2020 4:55 AM
To: Marek Ol=9A=E1k <maraeo@gmail.com>; Koenig, Christian <Christian.Koenig=
@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx mailing list <a=
md-gfx@lists.freedesktop.org>
Subject: Re: drm/amdgpu: apply AMDGPU_IB_FLAG_EMIT_MEM_SYNC to compute IBs =
too

Thanks for that explanation. I suspected that there was a good reason to ha=
ve that in the kernel, but couldn't find one.

In this case the patch is Reviewed-by: Christian K=F6nig <christian.koenig@=
amd.com><mailto:christian.koenig@amd.com>

We should probably add this explanation as comment to the flag as well.

Thanks,
Christian.

Am 26.04.20 um 02:43 schrieb Marek Ol=9A=E1k:
It was merged into amd-staging-drm-next.

I'm not absolutely sure, but I think we need to invalidate before IBs if an=
 IB is cached in L2 and the CPU has updated it. It can only be cached in L2=
 if something other than CP has read it or written to it without invalidati=
on. CP reads don't cache it but they can hit the cache if it's already cach=
ed.

For CE, we need to invalidate before the IB in the kernel, because CE IBs c=
an't do cache invalidations IIRC. This is the number one reason for merging=
 the already pushed commits.

Marek

On Sat., Apr. 25, 2020, 11:03 Christian K=F6nig, <ckoenig.leichtzumerken@gm=
ail.com<mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
Was that patch set actually merged upstream? My last status is that we coul=
dn't find a reason why we need to do this in the kernel.

Christian.

Am 25.04.20 um 10:52 schrieb Marek Ol=9A=E1k:
This was missed.

Marek



_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx<https://nam11.safeli=
nks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmai=
lman%2Flistinfo%2Famd-gfx&data=3D02%7C01%7CAlexander.Deucher%40amd.com%7C6b=
35f61512d34bf2dc8b08d7e9bfa1a6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7=
C637234881577782939&sdata=3D%2B95wpbjY3Q675FaX9iH1BNIFyEz5jpN4PzjEOOpIu9Q%3=
D&reserved=3D0>





_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx<https://nam11.safeli=
nks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmai=
lman%2Flistinfo%2Famd-gfx&data=3D02%7C01%7CAlexander.Deucher%40amd.com%7C6b=
35f61512d34bf2dc8b08d7e9bfa1a6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7=
C637234881577782939&sdata=3D%2B95wpbjY3Q675FaX9iH1BNIFyEz5jpN4PzjEOOpIu9Q%3=
D&reserved=3D0>



--_000_MN2PR12MB448809E68050B9A61B1CC7FAF7AF0MN2PR12MB4488namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
Do we have open source code UMD code which uses this?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Sunday, April 26, 2020 4:55 AM<br>
<b>To:</b> Marek Ol=9A=E1k &lt;maraeo@gmail.com&gt;; Koenig, Christian &lt;=
Christian.Koenig@amd.com&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx ma=
iling list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: drm/amdgpu: apply AMDGPU_IB_FLAG_EMIT_MEM_SYNC to compu=
te IBs too</font>
<div>&nbsp;</div>
</div>
<div style=3D"background-color:#FFFFFF">
<div class=3D"x_moz-cite-prefix">Thanks for that explanation. I suspected t=
hat there was a good reason to have that in the kernel, but couldn't find o=
ne.<br>
<br>
In this case the patch is Reviewed-by: Christian K=F6nig <a class=3D"x_moz-=
txt-link-rfc2396E" href=3D"mailto:christian.koenig@amd.com">
&lt;christian.koenig@amd.com&gt;</a><br>
<br>
We should probably add this explanation as comment to the flag as well.<br>
<br>
Thanks,<br>
Christian.<br>
<br>
Am 26.04.20 um 02:43 schrieb Marek Ol=9A=E1k:<br>
</div>
<blockquote type=3D"cite">
<div dir=3D"auto">It was merged into amd-staging-drm-next.
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">I'm not absolutely sure, but I think we need to invalidat=
e before IBs if an IB is cached in L2 and the CPU has updated it. It can on=
ly be cached in L2 if something other than CP has read it or written to it =
without invalidation. CP reads don't
 cache it but they can hit the cache if it's already cached.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">For CE, we need to invalidate before the IB in the kernel=
, because CE IBs can't do cache invalidations IIRC. This is the number one =
reason for merging the already pushed commits.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Marek</div>
</div>
<br>
<div class=3D"x_gmail_quote">
<div dir=3D"ltr" class=3D"x_gmail_attr">On Sat., Apr. 25, 2020, 11:03 Chris=
tian K=F6nig, &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com">ckoen=
ig.leichtzumerken@gmail.com</a>&gt; wrote:<br>
</div>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0 0 0
          .8ex; border-left:1px #ccc solid; padding-left:1ex">
<div bgcolor=3D"#FFFFFF">
<div>Was that patch set actually merged upstream? My last status is that we=
 couldn't find a reason why we need to do this in the kernel.<br>
<br>
Christian.<br>
<br>
Am 25.04.20 um 10:52 schrieb Marek Ol=9A=E1k:<br>
</div>
<blockquote type=3D"cite">
<div dir=3D"ltr">
<div>This was missed.</div>
<div><br>
</div>
<div>Marek<br>
</div>
</div>
<br>
<fieldset></fieldset>
<pre>_______________________________________________
amd-gfx mailing list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank" rel=3D"n=
oreferrer">amd-gfx@lists.freedesktop.org</a>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01=
%7CAlexander.Deucher%40amd.com%7C6b35f61512d34bf2dc8b08d7e9bfa1a6%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637234881577782939&amp;sdata=3D%2B95wpb=
jY3Q675FaX9iH1BNIFyEz5jpN4PzjEOOpIu9Q%3D&amp;reserved=3D0" originalsrc=3D"h=
ttps://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash=3D"qFDNJ6J&#43=
;Ha3DqF45&#43;RVY44xxqdH6Z4eu59lTx1cfjRU8LXDoq2uEGKp1n6Dc25g5mKKrSdES7WM02h=
sv0fiyWsbUfeKg2toJcxHheSdz1N44wTjU9rkTCfF&#43;nmggZ&#43;X&#43;/JOm64Z0KpWPF=
k2fu8IGjE3KRxxLPdgdyZRUgu6oWmg=3D" target=3D"_blank" rel=3D"noreferrer">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
</blockquote>
<br>
</div>
</blockquote>
</div>
<br>
<fieldset class=3D"x_mimeAttachmentHeader"></fieldset>
<pre class=3D"x_moz-quote-pre">____________________________________________=
___
amd-gfx mailing list
<a class=3D"x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@lists.freede=
sktop.org">amd-gfx@lists.freedesktop.org</a>
<a class=3D"x_moz-txt-link-freetext" href=3D"https://nam11.safelinks.protec=
tion.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flis=
tinfo%2Famd-gfx&amp;data=3D02%7C01%7CAlexander.Deucher%40amd.com%7C6b35f615=
12d34bf2dc8b08d7e9bfa1a6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63723=
4881577782939&amp;sdata=3D%2B95wpbjY3Q675FaX9iH1BNIFyEz5jpN4PzjEOOpIu9Q%3D&=
amp;reserved=3D0" originalsrc=3D"https://lists.freedesktop.org/mailman/list=
info/amd-gfx" shash=3D"qFDNJ6J&#43;Ha3DqF45&#43;RVY44xxqdH6Z4eu59lTx1cfjRU8=
LXDoq2uEGKp1n6Dc25g5mKKrSdES7WM02hsv0fiyWsbUfeKg2toJcxHheSdz1N44wTjU9rkTCfF=
&#43;nmggZ&#43;X&#43;/JOm64Z0KpWPFk2fu8IGjE3KRxxLPdgdyZRUgu6oWmg=3D">https:=
//lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
</blockquote>
<br>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB448809E68050B9A61B1CC7FAF7AF0MN2PR12MB4488namp_--

--===============1969654541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1969654541==--
