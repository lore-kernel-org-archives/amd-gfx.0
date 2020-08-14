Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2697EC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 19:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E548A2065C
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 19:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NADATgYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E548A2065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 891CF6EC05;
	Fri, 14 Aug 2020 19:21:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A0566EC04
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 19:21:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GA8vs4KWIlu7hl8e+u2w621zZlGLXgbjjs3AzjDVjebhQ8P3Q7W0UotJZgJXCm1+ns10I1AtrbyPPaGYKQUrRn+yiR4DSKh+w+ym+MwozqE6d5OU7NLORr0UyobWP68vE0GKUj3kpe3mriGjEoSJP5MgPnFxdxGcWfiT9mCs7VVvgiG0gLYsGAbfgHu+I4wvkM5SsEh7XMAQn0HiDlTclVrOs9u6OYxojjbeDqJdUwq2noFpw69jmnTAXFSemzOi1R6c4szAeERLyO3uppSB5xx5Cg8HsL4ahO9w+QPQKp14dQ82K6wbJ/oMr1YoynjlFk6mPmxeizpHHAhW3a4BGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nArK8/fFzf6Fxfo/w5a7UpOa5O5sZeeMG8YITDxN/o=;
 b=gJXVDn77PytuQMOWfyd7eYH73O3+zk/+YWdcXcn+En8t9Ps1TsOQhlHYJAw9cukCYVYf59uz2rMTXUioYA23vcruYK2sdf6pGPtkPraErTBcXwlFIX6OL8lNSzzkKcYntDnjz0bF3WCtWX1JouP+Q5gdENf0GoP7vGhcaVhoY9i8MzcKj2ZwePPsxfrP5ka2smiBBvyTDzTOxdd0zCWIrhxVm5eUrQPPGvgvJpfnGm4D2XY1CANEn1e6Az7A4UNHWEs7Snstz5gK6HDGWCF+yMj/w+m1fuZbC0S4XXv2weNi0t5npH8hbhmxREZyLm687/ry1kBB8UXGdxGNwuFsYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nArK8/fFzf6Fxfo/w5a7UpOa5O5sZeeMG8YITDxN/o=;
 b=NADATgYiyDllNH2f+snC2cpXuIP1qyiDXXzMEIE2iQ+CgeMHsutpAWg7eR6LRtZwBFRmBhw8WqUxo4ECZbyCUbLtw/7nXo6MmSP7ae1lG+j5X1Bzu137o5TVHIOL7nOa8/XR2pMO/bFGfFYuY0eg3Qw4dBqO3WiCCJkmATDI6Xc=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2466.namprd12.prod.outlook.com (2603:10b6:207:4e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Fri, 14 Aug
 2020 19:20:59 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3283.022; Fri, 14 Aug 2020
 19:20:59 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Matt Coffin <mcoffin13@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Fix incorrect return value in sysfs for
 pp_od_clk_voltage
Thread-Topic: [PATCH] drm/amdgpu: Fix incorrect return value in sysfs for
 pp_od_clk_voltage
Thread-Index: AQHWcdiY7uQGk0N/p0OTU6H+mxpnVak3+mCAgAABfUA=
Date: Fri, 14 Aug 2020 19:20:59 +0000
Message-ID: <MN2PR12MB4488E38225D33AE3774DA2F3F7400@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200814011528.10862-1-mcoffin13@gmail.com>,
 <18f2505d-021b-c2ad-9a47-056aa644c242@gmail.com>
In-Reply-To: <18f2505d-021b-c2ad-9a47-056aa644c242@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-14T19:20:58.948Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1493209-7dfe-4130-2b94-08d840872d29
x-ms-traffictypediagnostic: BL0PR12MB2466:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2466B952655D40AC8C002D56F7400@BL0PR12MB2466.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 46HtkpHQDhKoi00+en8OEb7QanXx/UbKYHxOUHfHpS/s7hfocs1eX8hPrvor0lXiev4atQmy72xpNdfDiraDqOhO4QMWJfpeD4VklCJyedAadhx+am90c02UW/kFXexB2trU2Zs1hWGzL1P5x2x2y+m7ss34QAFx0SiT8KxBibUb0RoEPFmX3NtPqmDLEOkpuH+/95b3kVGe1RlRV8loYdVqnfguRFby5/rs7BP1AGpu/qHrFPN/nH92dQ6L9DgTonqKPn+DqUuJgNdVQ9gQ2aopOwGvEsJEz7VIWY+Loc1yuoIC4f+L/TzBvrRCoATin/jg2R1HVvT96G1WHxKs5wQQfXXIhU88VrsFexeQa+k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(26005)(186003)(71200400001)(110136005)(316002)(54906003)(478600001)(45080400002)(966005)(6506007)(8936002)(86362001)(8676002)(53546011)(2906002)(4326008)(7696005)(83380400001)(55016002)(5660300002)(76116006)(66446008)(66556008)(52536014)(64756008)(66946007)(166002)(9686003)(33656002)(66476007)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: td0iZiz/vQ2P/WHbSw+uqr05I7zAoL04XgbI/XuiME1vl2w4vtGhOXdCwsHMIkL3htxhetz7NRsj3XoTbxiVoyUPD1TPMOuBkUy0LpWQFbmOnJnstA9Oh+hP+9HGSITnQmTi6iS8vB0bBWXr07eXtqY6ewb3AGb5LNIVoMJkzAPvCT8Gf1KL6SSDNAGFcalNMFRvtfHInJbg7SCoDf2iMCqO6UB9zvyKM7zphthJOns85HLKYA9LfIupE4e9Po25ky+YIWSFI9O1aoy7jF7NpD0lfDV0/SAl2gFkli5yKmexJRG4nFRBxc8ngCHSHR1hpgSeCSlssCU9hWIfpTVtbmh38BHXvHXGERL8ntH9ZfSK6GBKNnl56nA8DkDKNQKZNO69leimJA+xV/Gu6G33JXfaOCPjFS/Ke+sDLlXGk3q0AcI0o2L91TSJaWN+u6j51sSlzMUU5vcm/+w1iXZwifp57MDqcqVYLi6dwFgRbXz/O35lUsajh1AnwnV2b3ILPeKolqz6qLppYbm/2Df2/xazonwDyd1isdU369LYL7LTSuH72Viz23JwPXo+UnzkEIx8s19dCx9Evfqjf5Fh3hsIlxZMmORFfVwJPG/l3EzH0Rx8o+r24SZzFm9nvf+/1GTPgIcmGe8g+PwZGDJT6Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1493209-7dfe-4130-2b94-08d840872d29
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2020 19:20:59.3757 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rUXmImI9ow8ZnYU7l+uqF5G+HTZz4cCtrDgXjVSq7r0uDa354syD7+P9Dt5SyvS/o2rCZ3VU6IBa8K55ep7PHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2466
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: multipart/mixed; boundary="===============1099975683=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1099975683==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488E38225D33AE3774DA2F3F7400MN2PR12MB4488namp_"

--_000_MN2PR12MB4488E38225D33AE3774DA2F3F7400MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

No need to apologize, it was a good catch.  Something to double check in th=
e future if something similar ends up getting applied again.

Thanks!

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Matt Cof=
fin <mcoffin13@gmail.com>
Sent: Friday, August 14, 2020 3:13 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Quan, Evan <Evan.Quan@amd.com>; Koenig, Christian <Christian.Koenig@amd=
.com>; Li, Dennis <Dennis.Li@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix incorrect return value in sysfs for pp=
_od_clk_voltage

Hi all,

As of 026acaeac2d205f22c0f682cc1c7b1a85b9ccd00 ("drm/amdgpu: revert "fix
system hang issue during GPU reset""), this patch is no longer needed,
and won't apply, because the badly-behaving code was removed; I'll
withdraw this patch for now.

Sorry to those who wasted their time reviewing.

Cheers,
Matt

On 8/13/20 7:15 PM, Matt Coffin wrote:
> The changes in edad8312cbbf9a33c86873fc4093664f150dd5c1 introduced an
> issue with the sysfs interface for pp_od_clk_voltage. It overwrites the
> return value to 0 when it calls another function, then returns 0. The
> intended behavior is that a positive return value indicates the number
> of bytes from the buffer that you processed in that call.
>
> With the 0 return value, clients would submit the same value to be
> written over and over again, resulting in an infinite loop.
>
> This is resolved by returning the count of bytes read (in this case the
> whole message), when the desired return is 0 (success).
>
> Fixes: edad8312cbbf ("drm/amdgpu: fix system hang issue during GPU")
> Bug: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
gitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1245&amp;data=3D02%7C01%7=
Calexander.deucher%40amd.com%7C3fb1fd9f95ad441a88a208d840862e80%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637330292979204288&amp;sdata=3DiABLxfzQVQ=
a5zBK6a0JozvRYl%2Fg5eTFnfOS86r0g9rU%3D&amp;reserved=3D0
> Signed-off-by: Matt Coffin <mcoffin13@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_pm.c
> index 1705e328c6fc..f00c7ed361d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -937,7 +937,11 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct d=
evice *dev,
>
>  pro_end:
>        up_read(&adev->reset_sem);
> -     return ret;
> +     if (ret) {
> +             return ret;
> +     } else {
> +             return count;
> +     }
>  }
>
>  static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C3fb1fd9f95ad441a88a208d840862e80%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637330292979204288&amp;sdata=3DGLWlbhgo0grFjcOh5ZA=
JWhXGxSm6Ufw8eDFDHZf95Uk%3D&amp;reserved=3D0

--_000_MN2PR12MB4488E38225D33AE3774DA2F3F7400MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
No need to apologize, it was a good catch.&nbsp; Something to double check =
in the future if something similar ends up getting applied again.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks!</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Matt Coffin &lt;mcoffin13@gma=
il.com&gt;<br>
<b>Sent:</b> Friday, August 14, 2020 3:13 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;; Koenig, Christian &lt;Chri=
stian.Koenig@amd.com&gt;; Li, Dennis &lt;Dennis.Li@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Fix incorrect return value in sysfs=
 for pp_od_clk_voltage</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi all,<br>
<br>
As of 026acaeac2d205f22c0f682cc1c7b1a85b9ccd00 (&quot;drm/amdgpu: revert &q=
uot;fix<br>
system hang issue during GPU reset&quot;&quot;), this patch is no longer ne=
eded,<br>
and won't apply, because the badly-behaving code was removed; I'll<br>
withdraw this patch for now.<br>
<br>
Sorry to those who wasted their time reviewing.<br>
<br>
Cheers,<br>
Matt<br>
<br>
On 8/13/20 7:15 PM, Matt Coffin wrote:<br>
&gt; The changes in edad8312cbbf9a33c86873fc4093664f150dd5c1 introduced an<=
br>
&gt; issue with the sysfs interface for pp_od_clk_voltage. It overwrites th=
e<br>
&gt; return value to 0 when it calls another function, then returns 0. The<=
br>
&gt; intended behavior is that a positive return value indicates the number=
<br>
&gt; of bytes from the buffer that you processed in that call.<br>
&gt; <br>
&gt; With the 0 return value, clients would submit the same value to be<br>
&gt; written over and over again, resulting in an infinite loop.<br>
&gt; <br>
&gt; This is resolved by returning the count of bytes read (in this case th=
e<br>
&gt; whole message), when the desired return is 0 (success).<br>
&gt; <br>
&gt; Fixes: edad8312cbbf (&quot;drm/amdgpu: fix system hang issue during GP=
U&quot;)<br>
&gt; Bug: <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3D=
https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1245&amp;am=
p;data=3D02%7C01%7Calexander.deucher%40amd.com%7C3fb1fd9f95ad441a88a208d840=
862e80%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637330292979204288&amp;=
amp;sdata=3DiABLxfzQVQa5zBK6a0JozvRYl%2Fg5eTFnfOS86r0g9rU%3D&amp;amp;reserv=
ed=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitlab.=
freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1245&amp;amp;data=3D02%7C01%7Cal=
exander.deucher%40amd.com%7C3fb1fd9f95ad441a88a208d840862e80%7C3dd8961fe488=
4e608e11a82d994e183d%7C0%7C0%7C637330292979204288&amp;amp;sdata=3DiABLxfzQV=
Qa5zBK6a0JozvRYl%2Fg5eTFnfOS86r0g9rU%3D&amp;amp;reserved=3D0</a><br>
&gt; Signed-off-by: Matt Coffin &lt;mcoffin13@gmail.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 6 +++++-<br>
&gt;&nbsp; 1 file changed, 5 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_pm.c<br>
&gt; index 1705e328c6fc..f00c7ed361d4 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; @@ -937,7 +937,11 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struc=
t device *dev,<br>
&gt;&nbsp; <br>
&gt;&nbsp; pro_end:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; up_read(&amp;adev-&gt;reset_=
sem);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return count;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,<=
br>
&gt; <br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C3fb1fd9f95ad441a88a208d840862e80%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637330292979204288&amp;amp;sdata=3D=
GLWlbhgo0grFjcOh5ZAJWhXGxSm6Ufw8eDFDHZf95Uk%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexander.=
deucher%40amd.com%7C3fb1fd9f95ad441a88a208d840862e80%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637330292979204288&amp;amp;sdata=3DGLWlbhgo0grFjcOh5=
ZAJWhXGxSm6Ufw8eDFDHZf95Uk%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488E38225D33AE3774DA2F3F7400MN2PR12MB4488namp_--

--===============1099975683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1099975683==--
