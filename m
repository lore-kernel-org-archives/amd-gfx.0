Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1C8C4BA13
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 16:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41AB4206E6
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 16:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e7CzLMPh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41AB4206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E87F6E402;
	Wed, 26 Feb 2020 16:33:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 222A16E402
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 16:33:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfprCVJSF4C/9UaGZ1Oi3dHa5bwPWKAZwLOwlsQ6c3BZdc6NFLhr2bWjeqTp8o7U3Zh3+nRgdFh+XAjEqsW6jSUAIU+Cb44s4z6srD9sQeHCLalmrLNIKuoutVOD2Y7D8M2SB+8xRZvujD5oTfpYU3NI+KtwtYcjXIu1r4WkEhL+ql3RNkdK/XDKB1J/RTBlM9ku7zGbv7gvvAJqPlmiX7dfkK2hqJuGuShiLbxssuU6OLrL2k2UY/HHoTTCFoPTyrhlfz3CAExdEB6pZG4C7RrIsl/kEWLE3Dmhdno2YdmpUJYj0repSi1P4pqZeK9aNUK03r2bvwsguSY5FJoypA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghNQ+N62sxovWRJpbMPsrSwAX4RB4bQrtmdOam84ol4=;
 b=Q57O8t6e+CQi3nboS/EOwYFn+5FG8JEjXtND1AT4aHCf/ujYf5qvOsU6hqns1zRkpDoE2AtJ7rCZpqis9EYTlsvTOA1om7j9alK0g5t1igbFLMB3jq3VZ3ZMNJ8bsd2+uNvlXisH01Gmj9CgYt116ZGg9BdPMtdU/oudTBAo/H3A/kOdTkqmXT6uIlJ7ut7/OhV6GaykDRMsq4eqM0P014vr/jI2Vvdb3qUccQnR4tBoTawC1818aMvFpFRzaCZEVYedb03GIrqKYb3+8VNs4bPrXcuvOCFSSJSwGn9jkKkpSLCyPq03Zx/UVmjUks8WrlS8QoQtxZI3dogRrNagKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghNQ+N62sxovWRJpbMPsrSwAX4RB4bQrtmdOam84ol4=;
 b=e7CzLMPhl+FQfIKNPNILtEyM+4Kqjx6zbLH90CyEbtJANbpwwGmThdlmTpmqXgiF1Hu6TWVCnj/vHY82T3vJezvHkOg5RX+CMvlcZfJSG7/+kKzrFy19Z8G/9bE8uEoBnrLnNpG2eNkDl5+Va+2/U5ptnvEptWW2d8umcju98ko=
Received: from CH2PR12MB3912.namprd12.prod.outlook.com (2603:10b6:610:2c::22)
 by CH2PR12MB3910.namprd12.prod.outlook.com (2603:10b6:610:28::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 26 Feb
 2020 16:33:23 +0000
Received: from CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167]) by CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167%5]) with mapi id 15.20.2772.012; Wed, 26 Feb 2020
 16:33:23 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Matt Coffin <mcoffin13@gmail.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/powerplay: Refactor SMU message handling
 for safety
Thread-Topic: [PATCH 1/2] drm/amdgpu/powerplay: Refactor SMU message handling
 for safety
Thread-Index: AQHV51mZUZ3X1/05PkSBgD23h/0x6qgsVXsAgABMJICAARR8Tw==
Date: Wed, 26 Feb 2020 16:33:23 +0000
Message-ID: <CH2PR12MB3912C9A349C893AFF8A623D6F7EA0@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <5d301d58-49c7-6c3c-0652-6e051514d1ff@amd.com>
 <20200219191941.67724-2-mcoffin13@gmail.com>
 <CADnq5_NTd_dZAtN4yVyeM+Fp2w0Toy=tkvz00OwiYyC908W1Xg@mail.gmail.com>,
 <4a61f3b0-369d-21ca-4fd2-23662c7738e4@gmail.com>
In-Reply-To: <4a61f3b0-369d-21ca-4fd2-23662c7738e4@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-02-26T16:33:22.440Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 33a6eed1-f066-4787-8317-08d7bad99910
x-ms-traffictypediagnostic: CH2PR12MB3910:|CH2PR12MB3910:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3910E306708A5F2EC966DC7EF7EA0@CH2PR12MB3910.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(189003)(199004)(186003)(8676002)(81156014)(8936002)(81166006)(26005)(71200400001)(15650500001)(55016002)(9686003)(53546011)(6506007)(7696005)(4326008)(110136005)(54906003)(86362001)(19627405001)(33656002)(316002)(5660300002)(66446008)(64756008)(478600001)(966005)(52536014)(76116006)(66556008)(66476007)(66946007)(2906002)(45080400002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3910;
 H:CH2PR12MB3912.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZraBYFqK3luhd/nmXlSnz5c8i/q+F5st0KL5siH6M+Pb7QYQtdAw3UPqJhxHBD5Iew49XLE4I/ZwchEvtqdmQ/0KyP0InIQBCFfDl7JAv+L+pe/lzpAaUAIHx4FpcmQixL2ACkKDoRIR0sZoV/vMhKTd7EmL52XVuJLlybm0kX5o61SASzazTH9AP0gdWl6jT9WwY69i0uZad0g5ycaIZlfT/wG3W2st3LJbEhJPutFhF4dgUi9Y90KQbzb4ZX083qWlus7i9uLgKgXzgojwLy8E4Xf3REJlQ1D3TNOJeP/6QMsTQNaqRlKbQxmDS2+RbS8Kje/RWeHAm+znau606x+LRHHrEV8PqfOFMQ0Eq8RWKsMaI/s96bPsC8KAs5/hWGCGygl3qUElGmiL9kjbBsy0jcxLcWQpys3XQs1DCo1c8RjCxW9ikomOzpjnFsUPGlj3+cYPiGtvgKiQ46Y8utxDgXvf/O+Hxb88A5G+HGEuwdh+4ZyZHDGxOLL/epMJLlJHEudY0b4qVMZ5EmvBxw==
x-ms-exchange-antispam-messagedata: eJ0e3tBRAjjTLBg3yr+w/s/r3EXc7toqRuE8ZTPa+DAc+KUZU+w76hTExt9hqwmWfIEXLyNHUaxHTwT6LHiZNT2U5HWsuNmADJhD2MnU6xCzZjHn1WAG336/3tpdBVzD/9K2mG6gwmuKlnJFfL6M2w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a6eed1-f066-4787-8317-08d7bad99910
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 16:33:23.3640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4OcBcLAJKGTw6dLDkZlsEOuNNk8UUe6cQ8ehkhyUlL59th2p2TMc7Tcj558XEPzkPzGDg/pM/OGCccu5DeyJSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3910
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
Cc: "Das, Nirmoy" <Nirmoy.Das@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0281638158=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0281638158==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB3912C9A349C893AFF8A623D6F7EA0CH2PR12MB3912namp_"

--_000_CH2PR12MB3912C9A349C893AFF8A623D6F7EA0CH2PR12MB3912namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

That's fine we can take care of testing other platforms.

Thanks,

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Matt Cof=
fin <mcoffin13@gmail.com>
Sent: Tuesday, February 25, 2020 7:03 PM
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Das, Nirmoy <Nirmoy.Das@amd.com>; amd-gfx list <amd-gfx@lists.freedeskt=
op.org>
Subject: Re: [PATCH 1/2] drm/amdgpu/powerplay: Refactor SMU message handlin=
g for safety

Hey Alex,

The reason I didn't transition the other code is that I have no hardware
to test with.

I'll go ahead and do it, but someone with the hardware should at least
ensure it boots properly (vega20, and something on smu_v12_0).

With that, I'm good with doing it, I just don't want to risk breaking
other ASICs with a change that is supposed to increase stability.

On 2/25/20 12:30 PM, Alex Deucher wrote:
> Drop the unsafe ones.  Let's convert everyone.

Thanks for the review; I'll make the necessary changes. Sorry I keep
forgetting my Signed-off-by... I should really just add a git hook for it.

~Matt
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C479c9ea7ef3c4067dcf508d7ba4f4ee2%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637182722163693285&amp;sdata=3DnRAVFh8evB4fIOmPh%2=
F9ikOr3Aa52lc78wNgBxJChupw%3D&amp;reserved=3D0

--_000_CH2PR12MB3912C9A349C893AFF8A623D6F7EA0CH2PR12MB3912namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
That's fine we can take care of testing other platforms.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks,<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Matt Coffin &lt;mcoffin13@g=
mail.com&gt;<br>
<b>Sent:</b> Tuesday, February 25, 2020 7:03 PM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;<br>
<b>Cc:</b> Das, Nirmoy &lt;Nirmoy.Das@amd.com&gt;; amd-gfx list &lt;amd-gfx=
@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu/powerplay: Refactor SMU message =
handling for safety</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Hey Alex,<br>
<br>
The reason I didn't transition the other code is that I have no hardware<br=
>
to test with.<br>
<br>
I'll go ahead and do it, but someone with the hardware should at least<br>
ensure it boots properly (vega20, and something on smu_v12_0).<br>
<br>
With that, I'm good with doing it, I just don't want to risk breaking<br>
other ASICs with a change that is supposed to increase stability.<br>
<br>
On 2/25/20 12:30 PM, Alex Deucher wrote:<br>
&gt; Drop the unsafe ones.&nbsp; Let's convert everyone.<br>
<br>
Thanks for the review; I'll make the necessary changes. Sorry I keep<br>
forgetting my Signed-off-by... I should really just add a git hook for it.<=
br>
<br>
~Matt<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C479c9ea7ef3c4067dcf508d7ba4f4ee2%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637182722163693285&amp;amp;sdata=3D=
nRAVFh8evB4fIOmPh%2F9ikOr3Aa52lc78wNgBxJChupw%3D&amp;amp;reserved=3D0">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C479c9ea7ef3c4067dcf508d7ba4f4ee2%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637182722163693285&amp;amp;sdata=3DnRAVFh8evB4fIOm=
Ph%2F9ikOr3Aa52lc78wNgBxJChupw%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH2PR12MB3912C9A349C893AFF8A623D6F7EA0CH2PR12MB3912namp_--

--===============0281638158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0281638158==--
