Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD0FC4361B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 14:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 241C022518
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 14:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241C022518
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 947078982D;
	Tue, 15 Dec 2020 14:27:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0BEC8982D
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 14:27:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jt+TFhq9MFdkKHPWRHboTfacZx04KfzlM08PaF0ODdjtA000J+8j2FgUDbrXAbhrM8/ZB/qNj5k4k9JsaRXSsysOTAigowYPmBxEYj/wixbcYoODe1RRcgGY/D4FXP+7g1Fj5rwCYH2/Q/3Es98CnSdgQsWVSAvCNu9Xdh84P8LqKMWMbG8tpVdFyYFVIH8+otRdVNj9poJ+Z/wMFJrdaKYCQf/UMaIzJFaCG0vN4O8ovWI6Y+mfXVm4ZoGXrf6az8AlhxwJun2+P3tAsXC5cmTQvOVti7pSrK9pdZWfnq3FaTdxENHEju4GQFHOkxOG8JcxxTs+tVs1S3PP0qsVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZeIBQeOir1CTvMYYASoOfDHWUju9YNMKIKGmmLcvtw=;
 b=Jm66ozeTmR0Ao+6JV3G6OIB29lWr1K8D4bgRu684DhcGYV5BUu+mK08bwB/iST4Nxx9T76MetiTIFP/DmrTiq1xB+jeNcXdCBfE6GpzYeEO2Wj5uOFFmt9R+le0HBry2j/UuViamN8ejGTO+khabdgByaXEsTFmwdOreJ7bmGGzD2Bj1Vqc76jjAEgUz9+uaX8carNiWdEgl9FmL6nCVAy+pOjjCQZjyy7s0T8rY7Y1blbdWPm2t5T1Omc9UcufG+ak4E4xbdSvv23w+bwBGsh8U5r9UzhSPjbVfB2187FhTrND2hosmG1yRNpdrgDX4aUhhiQCMOMyy0Whh+pj8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZeIBQeOir1CTvMYYASoOfDHWUju9YNMKIKGmmLcvtw=;
 b=enULEAv+6CsioKcL5RUkOazog7kVjYqPU2DIQUbN0IgAhIeC+nqj5cuXXkaI1lmsCLLuwPx79UgqXcjwjusMUg8lNMXMXmtALhQpHngIPqkNthTab7vNABaASqgSzbqn9JpMmKkHQqk/Wr8ZWsyV2/Yv/jC8qgczZ16DjB3lkGE=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17; Tue, 15 Dec
 2020 14:27:08 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af%4]) with mapi id 15.20.3654.024; Tue, 15 Dec 2020
 14:27:08 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: set mode1 reset as default for
 dimgrey_cavefish
Thread-Topic: [PATCH] drm/amdgpu: set mode1 reset as default for
 dimgrey_cavefish
Thread-Index: AQHW0sxfgrka6MCpSE+8tqWKwqia+6n39cGAgABBG7s=
Date: Tue, 15 Dec 2020 14:27:07 +0000
Message-ID: <MN2PR12MB4488488511B633CF55C1F390F7C60@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201215102321.20233-1-tao.zhou1@amd.com>,
 <BY5PR12MB488509A067242B247E2C1906EAC60@BY5PR12MB4885.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB488509A067242B247E2C1906EAC60@BY5PR12MB4885.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-15T14:27:07.011Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1c30e7f6-aba7-4bb0-f1c2-08d8a10580cc
x-ms-traffictypediagnostic: MN2PR12MB4424:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4424B3E101AB07A981E02FABF7C60@MN2PR12MB4424.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ow9fH8V+qH1d0IV0PTo616J6vMvA7M/wyQiBr8Q1x62W153MIPtZ9LWzF42JMKUR3DryYWiiLlv4OJd5aOBlEMXpTfu0qx4IK8H31kYULX0H64JXeZGr1fHmg8Gkn9pv5jPVa9ZxaRrrzoHcjcPLuoCR57aymfrlf+VHKB48YjT8FPW7QW4AIAZZRlAcbcCu6S4PCl/1mq5eV+J1SDZfYdr3ARnjzH468gIjHDbUzZi4gsVIWr3Ygn9a8SoiSCkHhYGINuyvt0XalEoH7apH6PMt8G5z3BOiCZmw9S1+QgGHFaX6tNkTohxX25EPTeMfPbBraRDqkMP1ymt/8zbESaUqxb2oHvs4Frl+E8IHSDY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(346002)(2906002)(508600001)(7696005)(966005)(83380400001)(8676002)(76116006)(5660300002)(86362001)(45080400002)(19627405001)(52536014)(64756008)(186003)(26005)(8936002)(6506007)(66556008)(66946007)(166002)(66476007)(55016002)(33656002)(66446008)(71200400001)(9686003)(53546011)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9WdXOILqUWr9piRg5S/kYuMkbX8zSJhXvXuU+Io1gtEt/enZZRMzcW4PZArs?=
 =?us-ascii?Q?uA+BYWzFE+pmqACG47M1VDbY4ZgkG7mkkpSUDJOHDKshQjo1TKYAr1TUlwBA?=
 =?us-ascii?Q?6Aet04GGCcdMNJqCW/a6aN7JaFgTU3Ed6ThcPhfOaSernavGPOLSE/Kgm/r2?=
 =?us-ascii?Q?OIonkq/3hpcCx971Uc1Im1xMObS0p54emCti7MMrPgfCu1kBXR8ESO5HVFBf?=
 =?us-ascii?Q?5hTn54T4FJBIe/8ONBJUBBqGqQs+KMiWksZEzV5tx4qB2I7eaTvEcj0LeOuL?=
 =?us-ascii?Q?LhZUe4QweCffKoJVrkyGxYNxNhoo9tevWSJylWVEaJSc3wOtAnMAHuYerZzU?=
 =?us-ascii?Q?RswUr1p74TGBMXwXp0KRECKy4eykR6d7u4SPRSsz0mmeY8E7iXVBPXE1pbzl?=
 =?us-ascii?Q?TaxChDjb3z8xPEoYj3X++SQTmzGI/0IKMnDGRP6CSjU9W5+8awIVWymdJhG9?=
 =?us-ascii?Q?Z9pMeR7ZXNonYFPTLCvdYT8dItjN/ijEfru3gbGCMJ3i+vuYHgfst8FM1AMi?=
 =?us-ascii?Q?VchqpJuo+YEJT+5SxNwF9HT8RB2CUFQnGW+FxqswmKSmNA33IkAR5rQiqb00?=
 =?us-ascii?Q?AHKabjbKbVDyf94MYwL2Vr78vmBTUKfFyaw9QBJ7ID18jeECSpaN82fwWIT7?=
 =?us-ascii?Q?x9z9Nsm3BE76S+ZCBvPW1DdcYMo2M4dyBZu7vdeF3703Em92U2X7eK4hZawo?=
 =?us-ascii?Q?fCyyh51pttYuUl/wI+jqEEw0kx/C4deELeKMUoG0xve+48vhp6Gi2o21VxiD?=
 =?us-ascii?Q?vXbYh4RX+0PWWzCyUhIerxSKL9gAjbH2JnLo4d4ukle8cj3vJR8skDr82Di8?=
 =?us-ascii?Q?miaBgWKqmQ5iLZ58XRTLT5/oUYg6Q2ico/Bq8ppJpXOUMwM8GVXXc1dKkTKY?=
 =?us-ascii?Q?Tc3/xkZSxVQJNK1QrDKaVKdiM0P/BaNb7N9hdjZJ857Xu2Tah8d2hVfisupG?=
 =?us-ascii?Q?alixvwY1/SbB5uvZBAIUzmmag6mTdL8zbB8/EHGh56I=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c30e7f6-aba7-4bb0-f1c2-08d8a10580cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2020 14:27:07.8836 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rquaO4cuB2Yb/d3dC7ahXste1panOv1dDSWk1cD49hC463ovbnD2do1NG/QiwM6bQNVXaz3If+iBe5KoUrzzNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424
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
Content-Type: multipart/mixed; boundary="===============0574323238=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0574323238==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488488511B633CF55C1F390F7C60MN2PR12MB4488namp_"

--_000_MN2PR12MB4488488511B633CF55C1F390F7C60MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

You will also need to add the asic_type to amdgpu_device_should_recover_gpu=
() if you the driver to actually use GPU reset when it encounters a hang.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Chen, Ji=
ansong (Simon) <Jiansong.Chen@amd.com>
Sent: Tuesday, December 15, 2020 5:33 AM
To: Zhou1, Tao <Tao.Zhou1@amd.com>; Gui, Jack <Jack.Gui@amd.com>; Zhang, Ha=
wking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists=
.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: set mode1 reset as default for dimgrey_cav=
efish

[AMD Official Use Only - Internal Distribution Only]

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Tuesday, December 15, 2020 6:23 PM
To: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Gui, Jack <Jack.Gui@amd=
.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.or=
g
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: set mode1 reset as default for dimgrey_cavefis=
h

Use mode1 reset for dimgrey_cavefish by default.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c index ac02dd707c44..6bee3677394a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -362,6 +362,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 switch (adev->asic_type) {
 case CHIP_SIENNA_CICHLID:
 case CHIP_NAVY_FLOUNDER:
+case CHIP_DIMGREY_CAVEFISH:
 return AMD_RESET_METHOD_MODE1;
 default:
 if (smu_baco_is_support(smu))
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7Cb3da8467a171425a6cf208d8a0e4d612%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637436252010819826%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3Dfr8uXVyoVz5WlYtYPRbKm1%2BN0ROBWuLuqPOuL3%2BHC0E%3D&amp;reserved=3D0

--_000_MN2PR12MB4488488511B633CF55C1F390F7C60MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
You will also need to add the asic_type to amdgpu_device_should_recover_gpu=
() if you the driver to actually use GPU reset when it encounters a hang.</=
div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Chen, Jiansong (Simon) &lt;Ji=
ansong.Chen@amd.com&gt;<br>
<b>Sent:</b> Tuesday, December 15, 2020 5:33 AM<br>
<b>To:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Gui, Jack &lt;Jack.Gui@amd=
.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.freed=
esktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: set mode1 reset as default for dimg=
rey_cavefish</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Official Use Only - Internal Distribution Onl=
y]<br>
<br>
[AMD Official Use Only - Internal Distribution Only]<br>
<br>
Reviewed-by: Jiansong Chen &lt;Jiansong.Chen@amd.com&gt;<br>
<br>
-----Original Message-----<br>
From: Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>
Sent: Tuesday, December 15, 2020 6:23 PM<br>
To: Chen, Jiansong (Simon) &lt;Jiansong.Chen@amd.com&gt;; Gui, Jack &lt;Jac=
k.Gui@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org<br>
Cc: Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>
Subject: [PATCH] drm/amdgpu: set mode1 reset as default for dimgrey_cavefis=
h<br>
<br>
Use mode1 reset for dimgrey_cavefish by default.<br>
<br>
Signed-off-by: Tao Zhou &lt;tao.zhou1@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c index ac02dd707c44..6bee3677394a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -362,6 +362,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)<br>
&nbsp;switch (adev-&gt;asic_type) {<br>
&nbsp;case CHIP_SIENNA_CICHLID:<br>
&nbsp;case CHIP_NAVY_FLOUNDER:<br>
+case CHIP_DIMGREY_CAVEFISH:<br>
&nbsp;return AMD_RESET_METHOD_MODE1;<br>
&nbsp;default:<br>
&nbsp;if (smu_baco_is_support(smu))<br>
--<br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7Cb3da8467a171425a6cf208d8a0e4d612%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637436252010819826%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3Dfr8uXVyoVz5WlYtYPRbKm1%2BN0ROBWuLuqPOuL3%2BHC0E%3D&a=
mp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3D=
https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;=
data=3D04%7C01%7Calexander.deucher%40amd.com%7Cb3da8467a171425a6cf208d8a0e4=
d612%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637436252010819826%7CUnkn=
own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI6Mn0%3D%7C1000&amp;amp;sdata=3Dfr8uXVyoVz5WlYtYPRbKm1%2BN0ROBWuLuqPOuL3%2=
BHC0E%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488488511B633CF55C1F390F7C60MN2PR12MB4488namp_--

--===============0574323238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0574323238==--
