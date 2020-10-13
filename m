Return-Path: <SRS0=VV5o=DU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1E0C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2020 11:52:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFCC020870
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2020 11:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wSihmKc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFCC020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53C896E0AA;
	Tue, 13 Oct 2020 11:52:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25A276E0AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2020 11:51:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKtwZtNoJND4ENh8g9kTTOhm5dfxi6uAo/p+Y/Q8GFR8DqiDV6P1f57WD2NFOX+76cIuS7FFL7Y6GzsWZO4SgGMad3L2E2Dt9sfT4fOX6u/2yCIPt2qn+y+Dm+yQXap7+ChZdOZ7ZgpdFqoDdgLIfuZKfeZzmAbsHl95LAe/3LLD1NUAKVl28tnBUJ/wJZrW0bW1Cw/a+SVZTyu6KHcNsjsLj4IaQg+jLrzQv0n3mI33+ByiIVBLzLck74TbxDzypUi9PUOHiXKMh06GLE7rbAVgshxyzmowqQtnbYR8lqQ5qAA3uRUNOspCAiyx5CDa6DwKL5TjS34nbTQF9zX2DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PS4l6R5J7kxPSrAN0ObJWFA1wG1Q8P+hHWnYh730kUk=;
 b=jYKeuxyRvV4HH87QBDzedq04popcYXrojpFqjUSmLPTdo9HSjGBwZB2TEa/OjaSagpqZorlyJs5hDzZRPtLzK+pYpvRY35slRwID5ZzKP+stDK/MwQHfePg0OFG14EgmuWxCIJH/L57p9BltP4Ke6oOWxTb69WFvq7wb/pXIznc66jxgqPP9joPmRBRKvLmL6Cq6jp16NzskUcegOkXkY4buHdZoVcAvCUzL9gKlt1UJ6wsOCoI4kB62UHx3onEkWXSZ+MiPI/z5+veL55ALAh6g4/Hv9Xgdr/+cl+aOOWUW+EPhnNUDTLW6KyS98Y6zgsx6IJ7dfe1f7WpTikUFIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PS4l6R5J7kxPSrAN0ObJWFA1wG1Q8P+hHWnYh730kUk=;
 b=wSihmKc36J/bZoSo4eiPzgxZ+J0Xa9VBHsPnDARWPCA52SHzmFZIYPYtI+J9WKrsDolhu52iK5r757aZwyDNFUqjlvOddYxcu2816R8BTwWPwmoKIh6aLYZ70MPeIYOztNrRHKBXAftBmChl1JcM18qiSsknDV+3D5UHKayQYuo=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3615.namprd12.prod.outlook.com (2603:10b6:208:c9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.25; Tue, 13 Oct
 2020 11:51:55 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::69f0:f749:3d9b:362]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::69f0:f749:3d9b:362%4]) with mapi id 15.20.3455.030; Tue, 13 Oct 2020
 11:51:55 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: fix the issue that apu has no smu firmware
 binary
Thread-Topic: [PATCH] drm/amdgpu: fix the issue that apu has no smu firmware
 binary
Thread-Index: AQHWoVZfvncWBu6/7k+wWaNfBZKN/KmVa7/v
Date: Tue, 13 Oct 2020 11:51:55 +0000
Message-ID: <MN2PR12MB3022810FF2AC7DDC2FADC44AA2040@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20201013114502.3479215-1-ray.huang@amd.com>
In-Reply-To: <20201013114502.3479215-1-ray.huang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-13T11:51:54.586Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6a51209c-5bab-4dc2-3856-08d86f6e61ee
x-ms-traffictypediagnostic: MN2PR12MB3615:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3615B74FB90557150EAD2D1EA2040@MN2PR12MB3615.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: caSiIqy9VYwkF8FD6WV+drsR3KNO3ys3BSClnACcrMVlqBDWrDj8xcltuwUMZVGhnl0Dtzm7UelZd03QBbZw04YKrvQERpGzLptjC0LpUiPLKLk1BayIvhE4dQFaZScwDWMiKW1IjMBQftje9na2FE537/+mCDQq3amikGR2kJ3tlG5VdRi+pc5Xrvbyc1v1J/Svx9/Bw3sDmOreFnxB7cjCdEsEGegkSzQ7DXIdHyNiWa9h1Har6z8/1FnUw+4VL/w3z1hLyENARcjaRSeQyMRDA6/fi2L3Ftk7IpafPgRN5sRDpZjZq3R2x54f+M4RncMfwufSYqHW4GFaBxr7FEBI6My220EZ4qJH3l6mPMY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(66946007)(91956017)(2906002)(66556008)(66476007)(76116006)(83380400001)(316002)(53546011)(9686003)(6506007)(7696005)(55016002)(186003)(110136005)(19627405001)(26005)(166002)(5660300002)(8676002)(86362001)(33656002)(71200400001)(66446008)(966005)(52536014)(45080400002)(64756008)(8936002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: etVTjWkIWkGiAF8uw15dCqAuUIhKuoJzJwfd5YHNpjh5gxEZHcU0093ya5djaF0+K4pt1rGNiYAVvmPZ6grnN+P8XeqS/WEToYxnCWldNej5dQNwEckHJClFvhK/IHfzibDHnMot85gohSOqUXXegxzXdHbKqwQfXDuLhQaI6IBMTCplY6N7A9GqXJpQ9WZnz/WZCRVMS6JViIi6z6ht69eWQO8RjzsT+7Bw2+QQBWuLpZK45hcPOJebwmRX6pTaH3XeM8DSls1HZiLubbgN0cFWAwtC5aAXSExbhnAoiV3b9RP89GrZ8j+0d5u3xKFAFuXo2QkVEOyuwI+UfjtujOHvXLR/7MJhNuSZNPi1hse8m8dmSKfmQmFiGM/3A1lP/sfdU3a59r4ufOS9yeEaZSXI4tgUmzSUWLer/RE/jFIxZRJphVWElrDRtbObiczSo7IWnjkEqLLwvbOeGf1bMtJJErUlpw+NXwzH3qK+h9CBJ0gAsFgi+6z/nkJeELKdaM8nbvVZNMzAY7zlaMzcTcHbk+eZor+/FKOLPiCbhetVzOa+Tw50DNc32B1VGDu45Km3QiGfkMJXwdFfM3KC6vKxQYCCl21HkfYqHVd3Tn6zIHvVG1NGsaim558YB7MiR9vDdiLso6YMZTWAF52bZQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a51209c-5bab-4dc2-3856-08d86f6e61ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 11:51:55.1593 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b3MpcuthEOnuHyXuWmh5YXFJ8/ioxu0f7E1Aeqyxl0OSpM9NnaybA02cyJ2Cv7AQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3615
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
Content-Type: multipart/mixed; boundary="===============0570885353=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0570885353==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3022810FF2AC7DDC2FADC44AA2040MN2PR12MB3022namp_"

--_000_MN2PR12MB3022810FF2AC7DDC2FADC44AA2040MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Huang Ru=
i <ray.huang@amd.com>
Sent: Tuesday, October 13, 2020 7:45 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Huang, Ray <Ray.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: fix the issue that apu has no smu firmware bin=
ary

The driver needn't load smu binary on APU platforms.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 9d31f9339e02..042ad5e4292b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7049,7 +7049,7 @@ static int gfx_v10_0_hw_init(void *handle)
                  * loaded firstly, so in direct type, it has to load smc u=
code
                  * here before rlc.
                  */
-               if (adev->smu.ppt_funcs !=3D NULL) {
+               if (adev->smu.ppt_funcs !=3D NULL && !(adev->flags & AMD_IS=
_APU)) {
                         r =3D smu_load_microcode(&adev->smu);
                         if (r)
                                 return r;
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7C2bcdef4a06454092df7708d86f6d7f8b%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637381863385762892&amp;sdata=3DPK8E49RMQ3myvBXdV7pE7rxQT=
Rd9p7SVGJOhcXUFNHE%3D&amp;reserved=3D0

--_000_MN2PR12MB3022810FF2AC7DDC2FADC44AA2040MN2PR12MB3022namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Huang Rui &lt;ray.huang@amd.c=
om&gt;<br>
<b>Sent:</b> Tuesday, October 13, 2020 7:45 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix the issue that apu has no smu firmw=
are binary</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">The driver needn't load smu binary on APU platform=
s.<br>
<br>
Signed-off-by: Huang Rui &lt;ray.huang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 9d31f9339e02..042ad5e4292b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -7049,7 +7049,7 @@ static int gfx_v10_0_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * loaded firstly, so in direct type, it has to =
load smc ucode<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * here before rlc.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;smu.ppt_funcs !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;smu.ppt_funcs !=3D NULL &amp;&amp; !(adev-&gt;flags=
 &amp; AMD_IS_APU)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D=
 smu_load_microcode(&amp;adev-&gt;smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7C2bcdef4a06454092df7708d86f6d7f8b%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637381863385762892&amp;amp;sdata=3DPK8E49=
RMQ3myvBXdV7pE7rxQTRd9p7SVGJOhcXUFNHE%3D&amp;amp;reserved=3D0">https://nam1=
1.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.o=
rg%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40am=
d.com%7C2bcdef4a06454092df7708d86f6d7f8b%7C3dd8961fe4884e608e11a82d994e183d=
%7C0%7C0%7C637381863385762892&amp;amp;sdata=3DPK8E49RMQ3myvBXdV7pE7rxQTRd9p=
7SVGJOhcXUFNHE%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB3022810FF2AC7DDC2FADC44AA2040MN2PR12MB3022namp_--

--===============0570885353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0570885353==--
