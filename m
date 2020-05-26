Return-Path: <SRS0=trOe=7I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590C1C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2020 13:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18359207CB
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2020 13:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yQ0a3bsd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18359207CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8CE26E1CD;
	Tue, 26 May 2020 13:21:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D4456E1BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2020 13:21:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doy19zaE2PTKIBLbVloAHz3NGegDgddetms/kiXsioFKO451JrlCkgiyviDRbpfRKXMt+MtO5pEW+A4+jZxZHMPEovQdC+gNjoJZDeQlKbsxMtVsHCkkqxUWdUUap3U5e8d5E+AW08YknL1LOpYWytPPlOsKrjGIUl+DTlgbIowBEUcd3BSfzq9fd9SmkGDIf50JInPVXXg0Va7A3BZrJAg+sqKeCVxcF7+3eiZxqVE+IvRo+cV8KQqiFR401cDqEAa3PMbud1WS0rPfxMPNIT+EoFVUdGQMzDMknxkZz3YZYDu3MCGaw7hCxTgnduiTdJXcVQaNLkSQoKNMIhVgKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39bMt8PZd6HjGQwmZI7BQEq0+L/MJwevn3u61fAMPzM=;
 b=Z7HgGy34yPHz6myTqyWAzBpGlShkYAVw2LhgKpP8gM6sAfZbZnP7cm7Xgc1B7VkTDvdoeSplLrDpnoJF6MuWGIFZz1gZCzZ3apX02wJpxT5n92Xat214gQ4nLCq2dwdPmf0jSXHydeE3Cb3NflqyWc74Yh403PtlXCcniCtH8Ztr//TAr+hkgu+ksjnff3MmSVDm9FFY8DsP0iyC8RsNydUo84sCjmu+yduPrTF1FIfCtCMq8jCLo4qbD/+xl9qcMaYoZZcFXrUZkoc8O14RLchnTJBK0X8vg6dsd9BHNvpeXYDgf6cN2iEKNdFQgS7sV8HBRwEjy1lYuYJarAb+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39bMt8PZd6HjGQwmZI7BQEq0+L/MJwevn3u61fAMPzM=;
 b=yQ0a3bsd2QFX1h0ok3O3CGazpiyuHVSaxfkSvsfd2Xcwah+CkmV/cJoZ3ylWNk+PO8PvzLxAb2NHpLrRkdozwHmqFo3PlfnV5Oqq4/w/WWmSrh8+eejJgWBofb4YV8EFmhP9zVNAM6nZrWxzfIM93s4d8bRwAnDmQD7hGpiRXaY=
Received: from BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 by BY5PR12MB4161.namprd12.prod.outlook.com (2603:10b6:a03:209::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Tue, 26 May
 2020 13:21:44 +0000
Received: from BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c]) by BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c%2]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 13:21:44 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] drm/amdgpu: remove unused variable
Thread-Topic: [PATCH 1/1] drm/amdgpu: remove unused variable
Thread-Index: AQHWM14K4mrK0Imi+USkwJXNaZx4i6i6Wl4y
Date: Tue, 26 May 2020 13:21:44 +0000
Message-ID: <BY5PR12MB4068656192206727530C7845A2B00@BY5PR12MB4068.namprd12.prod.outlook.com>
References: <20200526130337.123848-1-nirmoy.das@amd.com>
In-Reply-To: <20200526130337.123848-1-nirmoy.das@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-26T13:21:43.812Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 346e6e9a-4e54-4dc3-2459-08d80177bc3b
x-ms-traffictypediagnostic: BY5PR12MB4161:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB41612F991EF980E01CB7FC0CA2B00@BY5PR12MB4161.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:820;
x-forefront-prvs: 041517DFAB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fx151gNfb3ATY7o8fen5Jk2XPaskAVXj3F1vWkZr3bDdH1lUtxB3AIJWwRCFSpu5VU/9PFwSVqTOuYozGRlsfn3hjkZQqRvhG5tNXC+gsQT2mpCI/9fBnEgTZVQaGdBDZiTN4pwcq3o2XUpCVBpMDeTWU9njj4oSzH77/gOXfYBKcCKCcJ4XKwHYqppCUH38fKPN8Lm/DU5Ws8KHKHCtlQJ4VaOC71c90ZCgZ1i5J5JnjKH2T1zutiVqu80eVDB9DomgD6Okpme09gwBmefl9Fj3yoASGZ4uS9sw97EtzH/zE6VNxqXEnNhzjanUz2CmlR4i3zAxtkhSpoo/TrRv9Sg+RZjSK5pBBIjXySKuVhQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4068.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(110136005)(316002)(64756008)(2906002)(7696005)(186003)(6506007)(66556008)(66446008)(166002)(66476007)(52536014)(91956017)(76116006)(8936002)(53546011)(26005)(8676002)(66946007)(4326008)(5660300002)(45080400002)(478600001)(19627405001)(33656002)(55016002)(966005)(9686003)(86362001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: PRU/eJOYaIkC46dvVVwKt2MtRePXYWdUZ3m0A3V0rqP+l0Wvcqb9QDZpg4OrCsALUVKbyzF1DJO0Tac5Tr+CTThwU9wFOnv3z5NZ/BoZ6z0LVJd/UqEvBUoWI+KQOwy9+2OwW7T4Y1h0drkugWZdn8Q2h3dQmhyosqjo3T5a1o53ixDbPA7vFCXg+4hmfajBv78+je6QcWJ+TqQm5J3qhKwFRYOjJmDwmsJAWPROAhtJ9RYPOQAO0uudyMq/Xpzb2GUz89ZDtINJ+8k7D7pzP0xFECiN9ZC1QshVvE6ABPq6fUxNNc9uP4o92QuU/kBlfSd5P/v7k2Dl7aeV/RMNT0IyaFhL7sX4Z+5PPlmN3nIQPQRpT7XdJEEmST5vByoiGb7oRTk1IC1cGHZ3qzfDch+SPZNudXGLQKOhXk+oGVi0pMoS1Z/g5ccrMElfGR63bjNj++wR0+3c3I2e6dtfgJymy+XBLZkHEmnCqtYzfKLvhulOHMYlGZyzV9k+g+T6
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346e6e9a-4e54-4dc3-2459-08d80177bc3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2020 13:21:44.1901 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e+z8CraTjUj/nEFqN7TIiB4jWZrsJXF5of278zfaysb4cV16O46pNQaJLFab8vGK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4161
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
Cc: "Das, Nirmoy" <Nirmoy.Das@amd.com>
Content-Type: multipart/mixed; boundary="===============1640955422=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1640955422==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR12MB4068656192206727530C7845A2B00BY5PR12MB4068namp_"

--_000_BY5PR12MB4068656192206727530C7845A2B00BY5PR12MB4068namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Nirmoy D=
as <nirmoy.aiemd@gmail.com>
Sent: Tuesday, May 26, 2020 9:03 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Das, Nirmoy <Nirmoy.Das@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: remove unused variable

Fixes: 1291bd70a2ee4 ("drm/amdgpu/sriov skip the update of SMU_TABLE_ACTIVI=
TY_MONITOR_COEFF")

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c
index 7f414034d2ef..67980f50d8ec 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1335,7 +1335,6 @@ static int arcturus_get_power_limit(struct smu_contex=
t *smu,
 static int arcturus_get_power_profile_mode(struct smu_context *smu,
                                            char *buf)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         DpmActivityMonitorCoeffInt_t activity_monitor;
         static const char *profile_name[] =3D {
                                         "BOOTUP_DEFAULT",
--
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7C89d1e7c484d245eb2c3008d801752b56%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637260950051221593&amp;sdata=3DOaC97%2F%2B9vUXRVY8jTvGQn=
aMQbMpvlIv1tCR9u9dHlz8%3D&amp;reserved=3D0

--_000_BY5PR12MB4068656192206727530C7845A2B00BY5PR12MB4068namp_
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
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Nirmoy Das &lt;nirmoy.aiemd@g=
mail.com&gt;<br>
<b>Sent:</b> Tuesday, May 26, 2020 9:03 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Das, Nirmoy &lt;Nirmoy.Das@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/1] drm/amdgpu: remove unused variable</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Fixes: 1291bd70a2ee4 (&quot;drm/amdgpu/sriov skip =
the update of SMU_TABLE_ACTIVITY_MONITOR_COEFF&quot;)<br>
<br>
Signed-off-by: Nirmoy Das &lt;nirmoy.das@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 1 -<br>
&nbsp;1 file changed, 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c<br>
index 7f414034d2ef..67980f50d8ec 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
@@ -1335,7 &#43;1335,6 @@ static int arcturus_get_power_limit(struct smu_co=
ntext *smu,<br>
&nbsp;static int arcturus_get_power_profile_mode(struct smu_context *smu,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DpmActivityMonitorCoeffInt=
_t activity_monitor;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static const char *profile=
_name[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &quot;BOOTUP_DEFAULT&quot;,<br>
-- <br>
2.26.2<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7C89d1e7c484d245eb2c3008d801752b56%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637260950051221593&amp;amp;sdata=3DOaC97%=
2F%2B9vUXRVY8jTvGQnaMQbMpvlIv1tCR9u9dHlz8%3D&amp;amp;reserved=3D0">https://=
nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedeskt=
op.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%=
40amd.com%7C89d1e7c484d245eb2c3008d801752b56%7C3dd8961fe4884e608e11a82d994e=
183d%7C0%7C0%7C637260950051221593&amp;amp;sdata=3DOaC97%2F%2B9vUXRVY8jTvGQn=
aMQbMpvlIv1tCR9u9dHlz8%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BY5PR12MB4068656192206727530C7845A2B00BY5PR12MB4068namp_--

--===============1640955422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1640955422==--
