Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5E9C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 10:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A77C564F51
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 10:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A77C564F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29D896E9EE;
	Wed, 10 Mar 2021 10:40:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DA3C6EA04
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 10:40:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZGARfjLsPlWlEdMihK43nHKhhj4wWuFMEkgc/hx/hyjmSgxylWy5MomqScR6J84QHtzVnMC3FEVxwWKSm9uEXZSqddm+geRenDnenDtOj/0uK3lUGz4YIyHe/17VESLPO3FufF2748MOmvJW/f1K/Jgw4z4PNKF/UTDDXUR18OBx13qmRqseFhnypd6ZqptjCV8BZd35ncz5rpQMg1i85mkVEbFLcRt51sxWGWC/9KqNwoOT5sz4k5rnIUC4eL6svGtfLocm8HaYr5Wl4sUyUvFo6taO9acZlH99NsUAtg1RthWK2DInogRfWT+j/M5/JNofKjnjWhQn99S7Ykvxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQZ7QidRVkOT4xK7qAbOlDaYp9jTjK6Dj8VYYU6Q4ro=;
 b=asbgLSBpPQ8OFsF4+I3wxVkg5zS8zgEAvTA7gnLdVuL+pQ+4QB7hiprsZZN5FCUx9LyN+rC8HNtA2UWRhSEZZU2KfXtIi2oTOpkfYTJqBQRaMvJQ6LjebFozXUWl/pHSXNODw1RxkNfL/CdBgMR4bVedKmH6PeEq4bPm/SYYXbyaGteuFEXCNO0PQssjk8w+nFZvD+kRPsI6A7tHtUeBORMLjgcdtXHdbYTca3s33ZuQu0soDm1cV5Lo+QbEK0Gnt/goCLSmLNBiAFB86qOoGgcK2TIBeFekpQSFWAOt58ESsaSc5jclS5T0k/2ywnOySsBBSny/KMW5NQ4QsiGFnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQZ7QidRVkOT4xK7qAbOlDaYp9jTjK6Dj8VYYU6Q4ro=;
 b=hB/UQrDCC2t8VRwnpxuAlHGKENU/QPDYEuhumffRbRkjld4aSt4ZIxheKOijw10/vDDsXcuMXXj0bMJxx7kprfaUBXdxmASimy3G5I9QBgeU0CAY/G26pBJEY22SEG8h9IntyR/7ZX8eNmyfp6D2/evriK4cYmII47hiTOhJYzA=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4552.namprd12.prod.outlook.com (2603:10b6:208:24f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.29; Wed, 10 Mar
 2021 10:39:57 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a%3]) with mapi id 15.20.3912.030; Wed, 10 Mar 2021
 10:39:57 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Free PDB0 bo before bo_fini
Thread-Topic: [PATCH] drm/amdgpu: Free PDB0 bo before bo_fini
Thread-Index: AdcVmYi3nGUgLuqGR2CtYPJZg2gsbg==
Date: Wed, 10 Mar 2021 10:39:57 +0000
Message-ID: <MN2PR12MB45490E6DF73972AFEF0F052897919@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-10T10:39:55Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=15ee522d-f8ff-4ecd-a4de-67ff884c4c6d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e4cd9c44-a654-4e8d-c243-08d8e3b0d994
x-ms-traffictypediagnostic: MN2PR12MB4552:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4552FF3EBFFF2188D6D6A60B97919@MN2PR12MB4552.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0iANg2H/DAS1ULuuqyXPAve02gOnhXAEA5IOFCQJ3xjr7ewUGddfr6AL9AHRe5806gvKQ2oEuEM/LIDbK82ENEX/rCOneiAyHG4CSexFHFW7T+l68GRsVtaBTbPy3tv/lx4ioxHaIz1NTvIbCqy29hZoWaOEg6oLpc5ZTMEtSv+GY2kN+w1yLqaT1CKrBHVmnQ1X3ArY9AP4S6BqWZXj6Ex4ynsPPc2jDIy162Jh9/UXDZbqSjTYZ8IF+c2uJYgU4vVr0/+GzgaDpH2r6+ObA1DmLH0j6a3IW/T34lFDEuUhbI96/0x6SYaTE6V/Jh65oERynjSCoTMxVPIZwFlJy8/2o55KK0DjyNw/f2w2lzJT6ZU34BgFR7FEZmY7mNouZ5lSEPx3uvO8W/LH/O18S5MXobVUDIxGLZEWkh88LYSbRtrzqJp12kaDcdneOWZ9/IDW+L3SPF+tl+f/LN477vN3wfqOZFdrF3cj0TwhO7u7cJVDomsnTEBRh2ztN2zCo8fwVg0echv8htif3f76Tg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(4326008)(6506007)(52536014)(478600001)(2906002)(33656002)(6916009)(5660300002)(186003)(4744005)(71200400001)(83380400001)(26005)(66476007)(9686003)(66446008)(7696005)(54906003)(8936002)(55016002)(66946007)(76116006)(8676002)(316002)(86362001)(64756008)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?B8GLisLvrJP99DDk8kKvBUeC9SGdtz7rIecEemyZXAvjtjHCH1DInxCswpEM?=
 =?us-ascii?Q?9ISJNXpzD2IrM0kmjRN6XYEN7vlUqdJgRmMEN5VY5X0CMasuZXPd/+7H7DAW?=
 =?us-ascii?Q?FtTh6ssA1UezqQIAyFgsGSAT+i5SmrC0Bs2J4B41B6wMXRFVcAW1mYfRyj50?=
 =?us-ascii?Q?dsGXM3+yhxnq+QGC3f0wJ/JqerJHa3tNtCLQy9OE3MLVfx8t9uoP4JcbCejd?=
 =?us-ascii?Q?KiiC2jlcXX5wDhlW3lLS/E9WhViPasLkr03kstT4q2mC1Ud6ojRTrYv4/+9B?=
 =?us-ascii?Q?Ad4b1ComyBYmnCbyq9iYj893ZnJeYIFNYHa9F0BWNMqqKl74FLxseHxAZu1H?=
 =?us-ascii?Q?4d7qmXT3v5qLldQcAJKGuoqWBYf9y05y/QReKCGAMN6hD/hWoqUkgp7ChcKK?=
 =?us-ascii?Q?IlrZpamoj/ivdHFjk0MURaNVNID/filzeKFQBKKeSSa0kuylYUIaXYtrfSkg?=
 =?us-ascii?Q?IoHkbf++2+kw2Zk4MfLOFnA6quGYbguZ3EF5fdS9+5zXQ11homFjLqpiCk86?=
 =?us-ascii?Q?Q9xRbddnh2+UcxO1QCU9LyHHD5zdAfL6ow1/ooeoWFlSqg5DBpFK3errziJw?=
 =?us-ascii?Q?i0iSyG43euA28ISVlGU2n8jMskmV2IkfBpYUvmLNV/eW5SVFoh+qOQG0fyGI?=
 =?us-ascii?Q?SBiJ6eRpnDwu6Rqnvtl9S/jP7jKSRxnV8erk0+o6+KnF7cEdOPDv5758tDge?=
 =?us-ascii?Q?CxhXDRLbETGUemQaviRK6tlKeb0+19bT8ZEBn3P+u5VplgpcI7gIHCVgOPc2?=
 =?us-ascii?Q?WArVwq89ihzO/9Q3o/Zj2V7FfvZZ1qXhbA+x9QBqkXdY/mWeokQszQZFe5qk?=
 =?us-ascii?Q?dFU2hubnFlUwZAhJHmaJqiQ216Zvt4O4XpbVryHsIBapCo6ty5xuNddpylyl?=
 =?us-ascii?Q?vgs4OFhzloKrtRz//6Mu7laT9NXDz7XTUIlw3WmhFAGiuN3q8rTLHBLnfkYT?=
 =?us-ascii?Q?ogHVWv9WDgffbVF+KphNdz7HC6F/csU85xmSyk7mrpEoHjZzZvE6VvDY4A9k?=
 =?us-ascii?Q?0bUtp4V8jQa8sW+HBe9r+Gu8kIHi2e1akUcg7ka1rjaESv0PCmUHF1AiY5MW?=
 =?us-ascii?Q?3H1QQCQah9kK+8xA/fsNd+USDv8BbnfN3dQ6HAEGPtDds41JmQsO5R+iWR9h?=
 =?us-ascii?Q?sIuFhIPdz7q3L3HGqXVrtcDgXonZSYotT5ZRcXswTpqbwzR+Mbdi2WvoiFSu?=
 =?us-ascii?Q?/gQhCb41wiXCNeCVurjpkmm8qfUWhJRyS1ptsX1WzN+A5yBFww3om88P9L2X?=
 =?us-ascii?Q?ON8JrdhgFZpeF6QZnsxynFE4ecpIYUh5z824uQPJzuwdM+yQrQbPslQjNSI5?=
 =?us-ascii?Q?hudiKCfPksvdGmVPaessj0cf?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cd9c44-a654-4e8d-c243-08d8e3b0d994
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 10:39:57.6302 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SuxMQjtVM4pREgVRObMdHMP0FNhmFnvTsA3R7GOt25D3nZ2nQcL8OmSMqjkhPFPG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4552
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
Cc: "Zeng, Oak" <Oak.Zeng@amd.com>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============2008409529=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2008409529==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB45490E6DF73972AFEF0F052897919MN2PR12MB4549namp_"

--_000_MN2PR12MB45490E6DF73972AFEF0F052897919MN2PR12MB4549namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Cleanup pdb0 bo before bo_fini gets called

Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>
---
drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 3 +--
1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 45ba3819bb8f..e8de5145339b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1577,10 +1577,9 @@ static int gmc_v9_0_sw_fini(void *handle)
        amdgpu_gem_force_release(adev);
        amdgpu_vm_manager_fini(adev);
        amdgpu_gart_table_vram_free(adev);
+       amdgpu_bo_unref(&adev->gmc.pdb0_bo);
        amdgpu_bo_fini(adev);
        amdgpu_gart_fini(adev);
-       if (adev->gmc.pdb0_bo)
-               amdgpu_bo_unref(&adev->gmc.pdb0_bo);

        return 0;
}
--
2.17.1

--_000_MN2PR12MB45490E6DF73972AFEF0F052897919MN2PR12MB4549namp_
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
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p class=3D"msipheader251902e5" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#317100">[AMD Public Use]</s=
pan></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Cleanup pdb0 bo before bo_fini gets called<o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar <a href=3D"mailto:lijo.laz=
ar@amd.com">
lijo.lazar@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 3 +--<o:p></=
o:p></p>
<p class=3D"MsoNormal">1 file changed, 1 insertion(+), 2 deletions(-)<o:p><=
/o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b=
/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 45ba3819bb8f..e8de5145339b 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<o:p></o:=
p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<o:p></o:=
p></p>
<p class=3D"MsoNormal">@@ -1577,10 +1577,9 @@ static int gmc_v9_0_sw_fini(v=
oid *handle)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ge=
m_force_release(adev);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm=
_manager_fini(adev);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ga=
rt_table_vram_free(adev);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unre=
f(&amp;adev-&gt;gmc.pdb0_bo);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo=
_fini(adev);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ga=
rt_fini(adev);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;g=
mc.pdb0_bo)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unref(&amp;adev-&gt;gmc.pdb0_bo=
);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;=
<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal">--<o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB45490E6DF73972AFEF0F052897919MN2PR12MB4549namp_--

--===============2008409529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2008409529==--
