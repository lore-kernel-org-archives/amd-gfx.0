Return-Path: <SRS0=LR/f=CD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC63BC433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 14:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C4CB20665
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 14:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hJdiH4HD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4CB20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B58D6E0BE;
	Tue, 25 Aug 2020 14:14:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A20D56E0BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 14:14:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKevSll5OJ99bZll5EqcLQugB+Vf0UldAL3w2kxkl+fXNiRjnJpIuMlXJ4bRYcxyIV53xBXQLqJc3KKmxThnvvxH1N6grXsinhb3jxYdjyB4GnlM4AgTXcnC4EOT6fdZ1bEtiNAQfm2iiEeChZsMvAsqi+1ZAkTIGk3aY7IxPdf3zMqZy7BDKuYGJITFn9UfB3uY6GWjpc+kQmcUEM6RgceXonSi8lrDNnkzTj0VTKqlQ/AM1vqiHB3cZol2J13OjJXNCzAhGbb1Sp0IS1XLKJYCOam4dx92omz8/axA/fydCbXnYo+AykJlO/qw7iNm4nE+v3qZ8v5sAomwCZ32ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rYYFPoGpt84uphq75p8+SWUzuDSuaVIc3sax8QH7lo=;
 b=moNfDu+o706Vzaribx4vgE4CRSStmVbhyn4EZdS4nBCUDZ89dnTivI/Pc11Jo96Q0gg98uN92MfkmdHap9qd6qozvWrtpw20rg3EAmOEaaidY2lX26PWclwcy1IbJiy0hISTY0lBL1nHHQAuv3/3I4p7lpHPq7JlByKZwanuQyj7cSEgpER/wiqnWYJel7cLrARl82i+3bRDH8wnB5xocKjwxnP86dTiiK+JO0Omoa36VDik1DrMjFK3K0hfwZFGxyRP+5u860ftsUcdD5mF8Ng0q2S/fb8h+uTMesDpRbGKcqLaHmBOEG6aFdOqVlfUHwljgSoOTZ4mnJDWgbyfJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rYYFPoGpt84uphq75p8+SWUzuDSuaVIc3sax8QH7lo=;
 b=hJdiH4HDld4PRSLHznL30FOJwC+cLDZI1UNTWolERiySAE5hsU8aFqVMeRYcDimYN6rO2ex2CiqzS7hDDG2qEsGQvLwIbPCQhp9NIK/t/5G8ukxNJ5jhD/ViI47vCcq27OqCggFOlCe6qQee5aPkQXJDuHIv4Sl/7C/iRu9zbXw=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3742.namprd12.prod.outlook.com (2603:10b6:208:16a::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Tue, 25 Aug
 2020 14:14:11 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 14:14:11 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: report DC not supported if virtual display is
 enabled
Thread-Topic: [PATCH] drm/amdgpu: report DC not supported if virtual display
 is enabled
Thread-Index: AQHWeuYAMcsgG7o6eEu/FxSjaP/GBqlI3fOAgAAAOx4=
Date: Tue, 25 Aug 2020 14:14:11 +0000
Message-ID: <MN2PR12MB448893E81D49F2AAFF40D31FF7570@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200825134515.278350-1-alexander.deucher@amd.com>,
 <CY4PR12MB1287A49F16CDA99D56B5ABF1F1570@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1287A49F16CDA99D56B5ABF1F1570@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-25T14:14:11.036Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d4e9e4e0-8232-483a-5630-08d8490123c1
x-ms-traffictypediagnostic: MN2PR12MB3742:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3742EE40DEF496E9325428E7F7570@MN2PR12MB3742.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 78QxQmzhzP5yv72EJVhITfvklVChwLxnaZf7o82OrwbkQ+16sKd+w7zOl9mgHZ6tARppbxV3Xpw356ahm6xM8WRO0Kkkot1GFAWp02dR5eQtqMHbkmHc7h7e5lvGoKJgPBpJ8vwBoWdtzmV6pC5F9nPADdQ7/c8q4f/QIqtJ56+LGNrMUx163Z1xrZRNJm5g90HrLDAtxJtn8fe3NmX0uBy4O3zpzxXKbK2WpD8ThOch2wZuxJOyflRUxPAsVKlwBDxQzCOBMqQAPghIbE+qajP1L28gORYAS7a1VMccg5Xn9du7Ck7o3pHUnwlOloPz5ootVWfD6TiqZGpbP3WRTWuvLbmzcYEX+4iG9Ikn+64=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(64756008)(53546011)(66476007)(6506007)(8936002)(86362001)(8676002)(66446008)(45080400002)(66946007)(76116006)(71200400001)(33656002)(316002)(110136005)(478600001)(966005)(7696005)(186003)(5660300002)(52536014)(2906002)(26005)(66556008)(166002)(83380400001)(9686003)(55016002)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: D/mSO/hi0ilBqqUClx0x9PNte9kOmG8T09DRadvAPcbqVrcn1AnVF96Eg0j6DXL3QlxSzF3u6Evvm5qBE8xurlNGxrKMpJEmKKN/VyBCcph3eZJdhDVwGJSXd2zc+92HtS3adImkLoPqavoPZMIx8/KUxKP720xTAKq1PaSnsj/bvn1VH2uK8YPiG2vukRaxCU6aRxNDlTlfoqr5l36+15w7dCWq+mWUw0gdlrCPH9CCROSRBmgAybOlMt1OwOqnyvSuLHviJK/OORw7L6FmlT+Ka38C51kZ3lw603lF1Ukl+pUFWNq+USxS6qtp7ObSSO5DpLQvVsU81xnNiEHc4gpY1NtqPDNl3Y1/9yMF3kSW7O6o1NKfAH/2vR31Enjfp/8wrJxItv5ovequYlvcXL3ffkQQJ+448ggQ5PSFR+ka7aZsOJzDImRz8/J9FWWA8k0Hiqig5SieZeKLMSJVd27oluMTsvA+k+7Fj4h1CUG7a+2GI3SWjUXhbeEgFYvLEgQmRVmJv6oDXYeKRFVwrrvm22wF/1OYktyfW1qSBmdedxeYNmaTP9FTyOnBmnks4HyXkzozOgfGOr5xsnTYbEp/jfGjH9NTdH3KhBNkp/PTYQKi8OGzBiH9guVkkBdPEjEIErsg/shtlo9xQEZhKg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e9e4e0-8232-483a-5630-08d8490123c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 14:14:11.5428 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KDALT95ijwDq+OPyqXq5qIJrF5/wwzhSW9h+7ax+Cc5Q21drAnX6Q7B66+TACfE7NvBu9IjyBId+XOs5PKfzKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3742
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
Content-Type: multipart/mixed; boundary="===============0141427408=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0141427408==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448893E81D49F2AAFF40D31FF7570MN2PR12MB4488namp_"

--_000_MN2PR12MB448893E81D49F2AAFF40D31FF7570MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

I can do that.

Alex

________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Tuesday, August 25, 2020 10:13 AM
To: Alex Deucher <alexdeucher@gmail.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: report DC not supported if virtual display=
 is enabled

[AMD Public Use]

Why not merging it to the same line of SRIOV check?

if (amdgpu_sriov_vf(adev) || adev->enable_virtual_display )
        return false;

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, August 25, 2020 9:45 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: report DC not supported if virtual display is =
enabled

virtual display is non-atomic so report false to avoid checking atomic stat=
e and other atomic things at runtime.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 5a948edcc93c..19f1e8449986 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2864,6 +2864,9 @@ bool amdgpu_device_has_dc_support(struct amdgpu_devic=
e *adev)
         if (amdgpu_sriov_vf(adev))
                 return false;

+       if (adev->enable_virtual_display)
+               return false;
+
         return amdgpu_device_asic_has_dc_support(adev->asic_type);
 }

--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cguchun.c=
hen%40amd.com%7C6679ea962a8a4b5715cf08d848fd2469%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637339599368934081&amp;sdata=3DWMMrhLJ2qXKEr6gHMn0ydF2%2=
B3jxzUEZ3azRsjkgOXZI%3D&amp;reserved=3D0

--_000_MN2PR12MB448893E81D49F2AAFF40D31FF7570MN2PR12MB4488namp_
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
I can do that.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Tuesday, August 25, 2020 10:13 AM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: report DC not supported if virtual =
display is enabled</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Public Use]<br>
<br>
Why not merging it to the same line of SRIOV check?<br>
<br>
if (amdgpu_sriov_vf(adev) || adev-&gt;enable_virtual_display )<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
<br>
Regards,<br>
Guchun<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Al=
ex Deucher<br>
Sent: Tuesday, August 25, 2020 9:45 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
Subject: [PATCH] drm/amdgpu: report DC not supported if virtual display is =
enabled<br>
<br>
virtual display is non-atomic so report false to avoid checking atomic stat=
e and other atomic things at runtime.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++<br>
&nbsp;1 file changed, 3 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 5a948edcc93c..19f1e8449986 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2864,6 +2864,9 @@ bool amdgpu_device_has_dc_support(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_virtual_display)<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_device_asic_=
has_dc_support(adev-&gt;asic_type);<br>
&nbsp;}<br>
&nbsp;<br>
--<br>
2.25.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Cguchun.chen%40amd.com%7C6679ea962a8a4b5715cf08d848fd2469%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637339599368934081&amp;amp;sdata=3DWMMrhL=
J2qXKEr6gHMn0ydF2%2B3jxzUEZ3azRsjkgOXZI%3D&amp;amp;reserved=3D0">https://na=
m11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop=
.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cguchun.chen%40=
amd.com%7C6679ea962a8a4b5715cf08d848fd2469%7C3dd8961fe4884e608e11a82d994e18=
3d%7C0%7C0%7C637339599368934081&amp;amp;sdata=3DWMMrhLJ2qXKEr6gHMn0ydF2%2B3=
jxzUEZ3azRsjkgOXZI%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448893E81D49F2AAFF40D31FF7570MN2PR12MB4488namp_--

--===============0141427408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0141427408==--
