Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53E3C35E01
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 18:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA8AB2082F
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 18:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="F8hh18tu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA8AB2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 894D66EB83;
	Tue, 25 Feb 2020 18:21:39 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680045.outbound.protection.outlook.com [40.107.68.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99BCB6EB83
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 18:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmAzlqPx86LhsY3MbrEz/QwI+EJsFOjudusjaQHkF4JlPV4TLBRGbxfMIbJUwln+gExOyliNYxWe2K+j5mciISoLQeZkbrOvPAW5bHKXhc8XTumWBHK+o5i6Zc4os7VKcPndHOpDygMcXGH7U2q4Wzgbeo/sCjvyGXqyaRmmlnEmb/JMhjZe6IVbKJzhhJ6E/zJsnmOhJf2t2kG+bu60htsR/9IDfS8dCiTKVsZoXBsq4fMsUxDvTKLoepimesWkKLIlhbWgxO1cfFzlXSH8Nyc1N/+SnFr/2z39XrvN4Ch2CREZsuQcMv99g+hknsnAF/oI58YTo7r250VHcwBkKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBJTcLSt77LBpzsOvQd8qQ2/kawtYuoh4tIpSXkrSag=;
 b=WNWYIITXXExdyjq9f47ByUpsjR7HeDO2RvJfbDy4Ihb0tltpJZJUoybusBh88gaXY61kbgWO8Om/F9BPfQBMDeJ+p59EBrtc2KCldEIqDjpoJrG8QuV8dSISMWdqefv9hOhGAgMX3WFR9W/xUnoLk1yF4xxqGj0ybJGQUro6U/eqOGB0WYu5Q68/wu1Kc9GO9imp7pZ3oPVpi/hdctMxFPlVnTvqLNTvwHTQDceLcapwrnRCEubbYC9rVd0Sonl3v8yeJds8cD6001BJQmhLKFBCsBXKsPFdcYaROzJ78rxgUw//SScEccHK2qY7fIG3a335yp6ivGiZapdZxtnHSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBJTcLSt77LBpzsOvQd8qQ2/kawtYuoh4tIpSXkrSag=;
 b=F8hh18tuGWqOe9hzncklxBP6Vz60eCL7MD73WukrJCJA/NluSk/jW3bMTn+NMqM/ZB7ri+LtVRtrKVXhxWbXh7jW7H5OfQsSxYZC3sCiNuJ/+2C8ffLKwEkMXbj28XDpEU+DcXdXWSEj97dFJlLursXs+F8PBjgREW6NtyRRL4c=
Received: from CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13)
 by CH2PR12MB3880.namprd12.prod.outlook.com (2603:10b6:610:2b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 18:21:37 +0000
Received: from CH2PR12MB4149.namprd12.prod.outlook.com
 ([fe80::919a:5402:a799:6bd0]) by CH2PR12MB4149.namprd12.prod.outlook.com
 ([fe80::919a:5402:a799:6bd0%3]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 18:21:36 +0000
From: "Khaire, Rohit" <Rohit.Khaire@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] SWDEV-220585 - Navi12 L1 policy GC regs WAR #1
Thread-Topic: [PATCH] SWDEV-220585 - Navi12 L1 policy GC regs WAR #1
Thread-Index: AQHV6PTp3PlExzCCtUq3ARzaHtdD9qgsPUWAgAAAdnA=
Date: Tue, 25 Feb 2020 18:21:36 +0000
Message-ID: <CH2PR12MB41492F3D5D80C1F6E64117AE87ED0@CH2PR12MB4149.namprd12.prod.outlook.com>
References: <20200221202410.3876-1-Rohit.Khaire@amd.com>
 <CH2PR12MB3912DC1B987DBE18C583E96FF7ED0@CH2PR12MB3912.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB3912DC1B987DBE18C583E96FF7ED0@CH2PR12MB3912.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-02-25T18:15:43.400Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rohit.Khaire@amd.com; 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d5d35f5-e7c8-4c63-5454-08d7ba1f8d0e
x-ms-traffictypediagnostic: CH2PR12MB3880:|CH2PR12MB3880:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3880ABEADEE8919999793A7887ED0@CH2PR12MB3880.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(189003)(199004)(8676002)(81156014)(81166006)(966005)(33656002)(8936002)(76116006)(66946007)(66476007)(5660300002)(66446008)(2906002)(110136005)(66556008)(64756008)(316002)(6506007)(478600001)(52536014)(53546011)(45080400002)(186003)(86362001)(26005)(7696005)(55016002)(9686003)(71200400001)(17413003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3880;
 H:CH2PR12MB4149.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kSL6pjbCp1LkHlatC03aRa+x5B+ePE1VnXZKM1yrfkXFNBI5Rr9ohF3QDTn6Qtwo8Jz41leVjsbnrQstWknbvwgXHg8gHPLz+muPV2vSExNcXX51Xu/0Vki++viIOMDu5l34DN5v+xgIvFuhRXYNEfbLZ6ayo5uGjymXHPEcw5pTs+qXMvRmcpUELM/cJD7s6JMILIo3rJXnGXIRUdAYrn3NcM0ZKE8W7umi7MmCSY/Qawj1+EZglHBTtC9bNk1D2Ux9Yxjwy8bU+kCpVzeAwd5JRaLMpCRoL4PmtcJHJemfFhaunJMUe04HGEYRBfVdIgD++kcZDXBqC9+b8n6X4ttm7jYQTqnphJ3JljpxeC+TEMJ+X60O1e3RcFNm6nDVXxVBhD2sIyLjQVdbYO6PiGYAMiaebkjm+nFv5kKmuxSk8yOzO9bOsLVwjNIlyAyHti3E26Gc7/GO9zGlb7pxEiZp+MKVE+u82tcu6vjm7bQKMWrbiPBKqnaE4r1iv3v1OBuygHuDTrYPHtv1h9fi9sTjZRaVJV/1fvRtHMXD0iSETASdyfSn18jDhCLoH3/Y
x-ms-exchange-antispam-messagedata: ABT25sZgd1d7pSzKMXWzsTjBUacAuas21gzcGyh/JYFQWpqbDFoBikujxG2Zb8O5S0O/mdNCr9zykapVAx2tR5pBAfIvjdqEwTauMH7NY469vHTJoolUyHWrX9XcDswj+ybT+sxgA6/D4xdEUjAVgQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5d35f5-e7c8-4c63-5454-08d7ba1f8d0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 18:21:36.7392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 98SqTfYjCY9bNLVhDN30ubV+/zwvXXSnUoIetokPQv139MbE137zzZfLNAyWfuC6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3880
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
Content-Type: multipart/mixed; boundary="===============1079985778=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1079985778==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB41492F3D5D80C1F6E64117AE87ED0CH2PR12MB4149namp_"

--_000_CH2PR12MB41492F3D5D80C1F6E64117AE87ED0CH2PR12MB4149namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks Alex!

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: February 25, 2020 1:16 PM
To: Khaire, Rohit <Rohit.Khaire@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] SWDEV-220585 - Navi12 L1 policy GC regs WAR #1


[AMD Public Use]

Please fix up the patch title.  E.g.,
drm/amdgpu: Don't write GCVM_L2_CNTL* regs on navi12 VF

With that fixed, patch is:
Reviewed-by: Alex Deucher@amd.com<mailto:Deucher@amd.com>>

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Rohit Khaire <Rohit.Khaire@amd.com<ma=
ilto:Rohit.Khaire@amd.com>>
Sent: Friday, February 21, 2020 3:24 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Khaire, Rohit <Rohit.Khaire@amd.com<mailto:Rohit.Khaire@amd.com>>
Subject: [PATCH] SWDEV-220585 - Navi12 L1 policy GC regs WAR #1

This change disables programming of GCVM_L2_CNTL* regs on VF.

Signed-off-by: Rohit Khaire <Rohit.Khaire@amd.com<mailto:Rohit.Khaire@amd.c=
om>>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v2_0.c
index b70c7b483c24..e0654a216ab5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -135,6 +135,10 @@ static void gfxhub_v2_0_init_cache_regs(struct amdgpu_=
device *adev)
 {
         uint32_t tmp;

+       /* These regs are not accessible for VF, PF will program these in S=
RIOV */
+       if (amdgpu_sriov_vf(adev))
+               return;
+
         /* Setup L2 cache */
         tmp =3D RREG32_SOC15(GC, 0, mmGCVM_L2_CNTL);
         tmp =3D REG_SET_FIELD(tmp, GCVM_L2_CNTL, ENABLE_L2_CACHE, 1);
@@ -298,9 +302,11 @@ void gfxhub_v2_0_gart_disable(struct amdgpu_device *ad=
ev)
                             ENABLE_ADVANCED_DRIVER_MODEL, 0);
         WREG32_SOC15(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL, tmp);

-       /* Setup L2 cache */
-       WREG32_FIELD15(GC, 0, GCVM_L2_CNTL, ENABLE_L2_CACHE, 0);
-       WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL3, 0);
+       if (!amdgpu_sriov_vf(adev)) {
+               /* Setup L2 cache */
+               WREG32_FIELD15(GC, 0, GCVM_L2_CNTL, ENABLE_L2_CACHE, 0);
+               WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL3, 0);
+       }
 }

 /**
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C52705cf7b1bc4750932a08d7b70c0e38%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637179135079462923&amp;sdata=3D6YT8MUoBGMujktD%2Bo=
YjEcxCAq2TE4gt7CO7GO4mGpoc%3D&amp;reserved=3D0

--_000_CH2PR12MB41492F3D5D80C1F6E64117AE87ED0CH2PR12MB4149namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-CA" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Thanks Al=
ex!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US">From:</span></b><span lang=
=3D"EN-US"> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;
<br>
<b>Sent:</b> February 25, 2020 1:16 PM<br>
<b>To:</b> Khaire, Rohit &lt;Rohit.Khaire@amd.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
<b>Subject:</b> Re: [PATCH] SWDEV-220585 - Navi12 L1 policy GC regs WAR #1<=
o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Please =
fix up the patch title.&nbsp; E.g.,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">drm/amd=
gpu: Don't write
</span><span style=3D"color:black">GCVM_L2_CNTL* regs on navi12 VF</span><s=
pan style=3D"font-size:12.0pt;color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">With th=
at fixed, patch is:<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Reviewe=
d-by: Alex
<a href=3D"mailto:Deucher@amd.com">Deucher@amd.com</a>&gt;<o:p></o:p></span=
></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Rohit Khaire &lt;<a href=3D"mailto:Rohit.Khaire@amd.com">Rohit.Khaire@amd=
.com</a>&gt;<br>
<b>Sent:</b> Friday, February 21, 2020 3:24 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Khaire, Rohit &lt;<a href=3D"mailto:Rohit.Khaire@amd.com">Rohit.=
Khaire@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] SWDEV-220585 - Navi12 L1 policy GC regs WAR #1</spa=
n> <o:p>
</o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">This change disables programming of GCVM_L2_CNTL* re=
gs on VF.<br>
<br>
Signed-off-by: Rohit Khaire &lt;<a href=3D"mailto:Rohit.Khaire@amd.com">Roh=
it.Khaire@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 12 &#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;---<br>
&nbsp;1 file changed, 9 insertions(&#43;), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v2_0.c<br>
index b70c7b483c24..e0654a216ab5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c<br>
@@ -135,6 &#43;135,10 @@ static void gfxhub_v2_0_init_cache_regs(struct amd=
gpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* These regs are not accessible =
for VF, PF will program these in SRIOV */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Setup L2 cache */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0=
, mmGCVM_L2_CNTL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 GCVM_L2_CNTL, ENABLE_L2_CACHE, 1);<br>
@@ -298,9 &#43;302,11 @@ void gfxhub_v2_0_gart_disable(struct amdgpu_device=
 *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; ENABLE_ADVANCED_DRIVER_MODEL, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCMC=
_VM_MX_L1_TLB_CNTL, tmp);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Setup L2 cache */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD15(GC, 0, GCVM_L2_CNTL, E=
NABLE_L2_CACHE, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL3, =
0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* Setup L2 cache */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_FIELD15(GC, 0, GCVM_L2_CNTL, ENABLE_L2_CACHE, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL3, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C52705cf7b1bc4750932a08d7b70c0e38%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637179135079462923&amp;amp;sdata=3D=
6YT8MUoBGMujktD%2BoYjEcxCAq2TE4gt7CO7GO4mGpoc%3D&amp;amp;reserved=3D0">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C52705cf7b1bc4750932a08d7b70c0e38%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637179135079462923&amp;amp;sdata=3D6YT8MUoBGMujktD=
%2BoYjEcxCAq2TE4gt7CO7GO4mGpoc%3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CH2PR12MB41492F3D5D80C1F6E64117AE87ED0CH2PR12MB4149namp_--

--===============1079985778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1079985778==--
