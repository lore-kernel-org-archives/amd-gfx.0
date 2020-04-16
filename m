Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1464DC352BE
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 13:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF78621D79
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 13:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="g9JbMofJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF78621D79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EB1E6E049;
	Thu, 16 Apr 2020 13:28:10 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770047.outbound.protection.outlook.com [40.107.77.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFACD6E049
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 13:28:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glV53tOPMScA7D8bh34iGE+QCQgj1orfZ9Dwr5bIWa6pZJ7pcja6fu4T/0zho/mSpKM48Efe8G8Mlny7aw0pB2Dj8Dwd6EJezftWYcuYyCKyzvVjtswpcK828knGPyTIuClAn1aYM10In7LJAVsZPRYHqukfaCM846TUBaLEw2+CW7/HPEnae90UJgIKzoPvcqTE7yY+PZbFrbIvN71cVoSNaK1CNMFhz4KPTBjblOquwyODblsl4LCkm82CnSaOgke7BlhGwKB/QDAXV2/18pdxEpoD0ii87A8IHW9FY5S1heKghhiP5KRJVjJWpiSpOCYmVcVTs7NrTz8ZApXing==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gOZqdsMZMwp9jlOIKByOn9/fk09jf+0EeWzBISVJ4A=;
 b=CwViFk+ASL/V3Khj+DysJMsU52xqLqVwlE42Cw2cZuZTdZiiIYkoxyNNGjU9PoBOHs1ICbDXzyDWaKvm6cVvqRR7jwiG00qdOdy26bXlCGCSdtFMnfVAh5oHLNyyQmSHcFkZ9FjmxmAxLGK9lzhDy/aOHD6icRUnMZ1yyrlS2R6BHCf/N+DWSVJkAbqNVyxdhbXso5qoVevWhftD1/UAPg9ZTMdKccwgp5qeBGEgum2xO6iqOGwrFXRfGAm9iAIfJXant3DdZnoCO1mfh8lGO+xhH+Jk3zii3IHNaiXUCZPOM4EC+cI1ebZW5JhahMUzbDGWKjUV/BSs8iUWArF+KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gOZqdsMZMwp9jlOIKByOn9/fk09jf+0EeWzBISVJ4A=;
 b=g9JbMofJyARohK5vdhvSkAKj+5FbDa+mfpsIS7Pz1Qz3SMlbg1ICLkg6DTtrervtyU96G6v65wHnZUyCM7xsSpVCtY94EOSbTRioaeSV0EU+cInSjXDtvg8ksXeTgGfTzUVweEoOHDOzvWwMU1ckWr54HZJHOrGOzyaZahYIZyQ=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3408.namprd12.prod.outlook.com (2603:10b6:208:cd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Thu, 16 Apr
 2020 13:28:04 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03%2]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 13:28:04 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Disable FRU read on Arcturus
Thread-Topic: [PATCH] drm/amdgpu: Disable FRU read on Arcturus
Thread-Index: AQHWE+ptSYdzlV8blk+IWDAcmnj64Kh7vc20
Date: Thu, 16 Apr 2020 13:28:04 +0000
Message-ID: <MN2PR12MB44885498520F7504EF6A868CF7D80@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200416122616.29174-1-kent.russell@amd.com>
In-Reply-To: <20200416122616.29174-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-04-16T13:28:03.764Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.52.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 898fc35f-aeb7-4c46-66ec-08d7e209fe4b
x-ms-traffictypediagnostic: MN2PR12MB3408:|MN2PR12MB3408:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3408DF0F14F688CEDA18F630F7D80@MN2PR12MB3408.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(478600001)(966005)(53546011)(6506007)(316002)(55016002)(9686003)(45080400002)(186003)(5660300002)(2906002)(33656002)(52536014)(81156014)(8936002)(8676002)(71200400001)(19627405001)(26005)(7696005)(110136005)(64756008)(66476007)(66556008)(66946007)(66446008)(76116006)(86362001);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OGWj9U8LyKX7PaGfyt5BNrIA1WHZRXYtnTmDI7JR/xGvhdb2lxiJAEB13PyGlKPJG+3+h9YEVM4vYZ8QrsHGJyWJgtx44KYS01bvaearWza4ZA/iP2JXqWyfdV7V7Y+H+jWCIVCCGQLnYVC+vp1xITBI++lL8RrSVbW0ayorFO/gzPkyfiwu1Jt1zfjOMnsagxFdHdXoyKMUejBmF9nVBx6Hcarv9Ept4gopstzw5c+C/tY3pM+l9rvNvDT98nbbQsPrIAc24ITV+A6BuEoRcS3oDFCqI/NvGheyZcCnr4Bc0ywVHCicdkgQioBj4Y/Vf/8u6a4CAj+nVTdGQNsiT4w/BJLZMUhkEXRudSRKndN6cPcqqDX7qxrcOKDpSEfoA4f19+eliK47o7UBFtOzq1oN+CtNv3f0iAsrW2yLuOC24md7J3cSbg0z+yUQCfWz9EEGcP/YFOIB0wAeg70QTCm8bqKeBSKmZzjpTPni0a8=
x-ms-exchange-antispam-messagedata: u5tkuhh7hNDk/14F7SvinBXt7PPFOgO6reaiVmBloF+keAhnRCKXg9476tdSw4awbV60rdUH6Oj9RRbyUd3Aesm+6G+au/cEp+6BlRX5vsQ78Tsy09phlSEtGPVUf4VDzBKxJN39+ZI1z8OsKa1vTQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 898fc35f-aeb7-4c46-66ec-08d7e209fe4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 13:28:04.4325 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xaJNifHCL+NKqjS8K4zKxJUQ9lCtMl4qnGgHSuM+JD4MjmkwmetOmbbUnd7JiA7UTyvtAPIac1LDsaW025lwmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3408
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
Content-Type: multipart/mixed; boundary="===============1677438202=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1677438202==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44885498520F7504EF6A868CF7D80MN2PR12MB4488namp_"

--_000_MN2PR12MB44885498520F7504EF6A868CF7D80MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kent Rus=
sell <kent.russell@amd.com>
Sent: Thursday, April 16, 2020 8:26 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Russell, Kent <Kent.Russell@amd.com>
Subject: [PATCH] drm/amdgpu: Disable FRU read on Arcturus

Update the list with supported Arcturus chips, but disable for now until
final list is confirmed.

Ideally we can poll atombios for FRU support, instead of maintaining
this list of chips, but this will enable serial number reading for
supported ASICs for the time-being.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fru_eeprom.c
index c7e55fe170bd..815c072ac4da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -36,10 +36,11 @@ bool is_fru_eeprom_supported(struct amdgpu_device *adev=
)
         /* TODO: Gaming SKUs don't have the FRU EEPROM.
          * Use this hack to address hangs on modprobe on gaming SKUs
          * until a proper solution can be implemented by only supporting
-        * it on Arcturus, and the explicit chip IDs for VG20 Server cards
+        * the explicit chip IDs for VG20 Server cards
+        *
+        * TODO: Add list of supported Arcturus DIDs once confirmed
          */
-       if ((adev->asic_type =3D=3D CHIP_ARCTURUS) ||
-           (adev->asic_type =3D=3D CHIP_VEGA20 && adev->pdev->device =3D=
=3D 0x66a0) ||
+       if ((adev->asic_type =3D=3D CHIP_VEGA20 && adev->pdev->device =3D=
=3D 0x66a0) ||
             (adev->asic_type =3D=3D CHIP_VEGA20 && adev->pdev->device =3D=
=3D 0x66a1) ||
             (adev->asic_type =3D=3D CHIP_VEGA20 && adev->pdev->device =3D=
=3D 0x66a4))
                 return true;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C42f34f3317a34ab721b308d7e2016ac3%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637226368632314607&amp;sdata=3DJA4W0rXwcxh3Pv7277q=
etB8bUAKc226ZVDQ4JY0P7UY%3D&amp;reserved=3D0

--_000_MN2PR12MB44885498520F7504EF6A868CF7D80MN2PR12MB4488namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Kent Russell &lt;kent.russell=
@amd.com&gt;<br>
<b>Sent:</b> Thursday, April 16, 2020 8:26 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Disable FRU read on Arcturus</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Update the list with supported Arcturus chips, but=
 disable for now until<br>
final list is confirmed.<br>
<br>
Ideally we can poll atombios for FRU support, instead of maintaining<br>
this list of chips, but this will enable serial number reading for<br>
supported ASICs for the time-being.<br>
<br>
Signed-off-by: Kent Russell &lt;kent.russell@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 7 &#43;&#43;&#43;&#4=
3;---<br>
&nbsp;1 file changed, 4 insertions(&#43;), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fru_eeprom.c<br>
index c7e55fe170bd..815c072ac4da 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c<br>
@@ -36,10 &#43;36,11 @@ bool is_fru_eeprom_supported(struct amdgpu_device *=
adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO: Gaming SKUs don't=
 have the FRU EEPROM.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Use this hack to a=
ddress hangs on modprobe on gaming SKUs<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * until a proper sol=
ution can be implemented by only supporting<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * it on Arcturus, and the expli=
cit chip IDs for VG20 Server cards<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the explicit chip IDs for=
 VG20 Server cards<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TODO: Add list of support=
ed Arcturus DIDs once confirmed<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;asic_type =3D=3D CHIP_A=
RCTURUS) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asi=
c_type =3D=3D CHIP_VEGA20 &amp;&amp; adev-&gt;pdev-&gt;device =3D=3D 0x66a0=
) ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;asic_type =3D=3D CH=
IP_VEGA20 &amp;&amp; adev-&gt;pdev-&gt;device =3D=3D 0x66a0) ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (a=
dev-&gt;asic_type =3D=3D CHIP_VEGA20 &amp;&amp; adev-&gt;pdev-&gt;device =
=3D=3D 0x66a1) ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (a=
dev-&gt;asic_type =3D=3D CHIP_VEGA20 &amp;&amp; adev-&gt;pdev-&gt;device =
=3D=3D 0x66a4))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C42f34f3317a34ab721b308d7e2016ac3%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637226368632314607&amp;amp;sdata=3D=
JA4W0rXwcxh3Pv7277qetB8bUAKc226ZVDQ4JY0P7UY%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexander.=
deucher%40amd.com%7C42f34f3317a34ab721b308d7e2016ac3%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637226368632314607&amp;amp;sdata=3DJA4W0rXwcxh3Pv727=
7qetB8bUAKc226ZVDQ4JY0P7UY%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44885498520F7504EF6A868CF7D80MN2PR12MB4488namp_--

--===============1677438202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1677438202==--
