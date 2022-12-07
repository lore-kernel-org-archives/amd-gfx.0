Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3937BC352A1
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 07:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5B3810E0C6;
	Wed,  7 Dec 2022 07:27:08 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AF6910E0C6;
 Wed,  7 Dec 2022 07:27:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSJE4FrP4ZJwJ93Bx6HEizmSFwWv3qEmX9Wt4d+s+w3RVUnDZz6hWuR61X64/+m2RDqX4Az3GSaTbrHa+T3Qt0ccrBe7JfWqmabY9kdWxtF1SA0Zv0oW2B+F0i+jyoIfHoBqxgSqSAT4XyyXFbvJbo/Y1BGbekNa0xgGG+dItGf2tJRWerxj2Qr07D6mCivKUw2WeiQnXoki6fCIfR5HP8LDzMUoZeZIWinNYvl4MkNE6R8ypRxUX8yWnDCYvOYcK80f4HQGRSB32/RKFq+zVuvIavS0rcw1cD0Bzab6EhzNUa3wNT02USO4MtPBjg+m/uCSRfImjf3QAPaTduriKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsAZ+skTv2K6cKfiz+cD0JirunmgG2xy3XKaSFL8XwU=;
 b=Zm2feIrcJ/jZMC+pMnYF1vnUz/KnIkimq/dFyjJDop/6WNEa4Y6DgBa3z4+w/zml4knrIebADjUDs3aIq0s3IbuLvhAUp7eT47FQpKi4KtAXPQ31E59iesNLeghZaZTiYfd9CnhMFUpfau1Q/dJGr92DucDCRgZFNQ99elQhz4T43unvhYL99r6fUDJQ0v2PL7BojcRxyZXJR/3NMF9uWCzab5ACgYvzGHuluKgJStAIdadZQyovSftWb0rttaWj6kQtCAq6oCUSRfywAVCFNfxFHbOeKNn4Od1noBIeUcDABz51sIhU1bG4I+4vNW4u2rBOB+n4kmv22txSNRGrjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsAZ+skTv2K6cKfiz+cD0JirunmgG2xy3XKaSFL8XwU=;
 b=2gBkEbtqvh9Z9jW6eXuJ35QM4kqNGVIt/wdwYunKGpWPCIDLL3h6J3UZA3ALU3+0P7rNGWX1jZAibKWF8snk9bxxqwEQ9NACR1oUGQxi4YSxViCRoolfpdkrJ1WWYjqk5GZlSdQK8fuetCFjcXjXMB2+fwbp0cZdzGMIpeupd5A=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by PH8PR12MB7111.namprd12.prod.outlook.com (2603:10b6:510:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 07:27:02 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::92d3:eae1:35fd:98cc]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::92d3:eae1:35fd:98cc%7]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 07:27:02 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Paneer Selvam,
 Arunpravin" <Arunpravin.PaneerSelvam@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: try allowed domain when pin framebuffer failed
Thread-Topic: [PATCH] drm/amdgpu: try allowed domain when pin framebuffer
 failed
Thread-Index: AdkKDSDFxSlpkC5gTnSZE4zebcKC0w==
Date: Wed, 7 Dec 2022 07:27:02 +0000
Message-ID: <DM4PR12MB51524585CEC4E2B4B8370874E31A9@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-07T07:25:22Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4befb31a-5842-4d3b-a8ae-ba5d5e9e96cd;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-07T07:27:01Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: ac89d86a-b332-4031-acf5-e57b051ac68f
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|PH8PR12MB7111:EE_
x-ms-office365-filtering-correlation-id: 6af16e94-3325-4911-c3a5-08dad8246f8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ARmL+l8DJq73AZocXonXSHmfwqcDekEaEMdL4qcDkE3Mj7ImgsV302JcXQ7fWbxliq8B7W3HTwe/d+jR32w0z4FKbNVgTKRfSjOw5M3IH8zqxOE7jNUYTFN50CBHw9QaEuZYH7hhONGreoXshALnPfIPuNVR7k6Kh0GI7K4iKGpZwGt3y2QEjO61tMm7unfP58G/w/L/vxfaVpGW7tdtxHcBDYBL0I5Deas6ar7ym0vUZ5qvypyadeuJrGTwVOHQtyn97jA+dgOKUl6SRjPky2i9HCu0Nx3rILmuzR1S/m9MU9KegmEsKGVRxuy0Z9qJNn/clw0Tej7cziOJaB04Tmjh+9xgoz1TEKec7T8Yw60Ks3klpOE1UbvipDoWSNwMaHmygtD+Ah+Al8iwXDxIXO15GJ0pyvyPyXI65s0QcMVxRRhiEYYQsXrUaGvOliAcR3VVX+br5MCpadY+4JzkJnK5dU8ASHtrhlL90s2RhVLEXvrVaNA95++m4Z6lbknZT0eFiKqXQLSX1zAzgPygoyd3UJBw7hoJTndAqWmD0j/C/p53OGYBcotQL8KXgmoA72nlg5ukCQwoz1AsFkTag1Sxbh+2hQmxijpX16/JA4o0iR1xn9IoZTdIm/hmHCPnholGkvxGap3/Bm/SHI2i9fH/cK7xeYPQbB6wU9KzAcjR1eoP/O5qlNy7RtXWLSX5LwE8sCmRYM9qyXS3N8oFcT9s4h6c8ToiHycOGb8pHgL5FqcVUXCE8GKEIyINA0D3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199015)(38100700002)(5660300002)(86362001)(41300700001)(2906002)(122000001)(33656002)(8936002)(4326008)(38070700005)(66476007)(83380400001)(8676002)(66556008)(450100002)(76116006)(66946007)(110136005)(316002)(6636002)(54906003)(71200400001)(478600001)(55016003)(66446008)(64756008)(9686003)(26005)(52536014)(186003)(6506007)(7696005)(414714003)(473944003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mZyIPgqfZKMjcBkC+vDEqhnkJ5w3rUdELjnNxwR1OEzPFFbZcDPmSbDR6rWh?=
 =?us-ascii?Q?606Na6PbHnxZWURXpZ6ZdA20qOyY5zQz49RSPIQkVdsxgythJjl616DZ3OEb?=
 =?us-ascii?Q?HwqSEJ6okpYE5Mzsd/f9YzMzrHZM6UDdu1uaCsSb5tUs+7uN3oOL6EGHoaUg?=
 =?us-ascii?Q?y7myTyjUO4qAYeeEJ2SVXGI0McWaOTG22Q4m/l+dMefkBxM0qkIRce/BqcHj?=
 =?us-ascii?Q?pkXsddEa8G08zEMSAQ36vgKictEOTn5yt4qFFbIF2jdkJ1UbaM/4b9Cch30M?=
 =?us-ascii?Q?Q5YENCjTGc2ZOjfbKZxTwYwHG3Cx3FNNhb2DkvfF2SwAIKcvBdPA73ikQjE2?=
 =?us-ascii?Q?jx51+y3vqXLU+/TEYUpJnlbvl2Ni5ziB9Sx66yySrucvBWFLnZhlLxheHKiG?=
 =?us-ascii?Q?SyAXmIfglVt6+0HANgMKXcMSlvzXvepWf9R0k2HlkWM08NLTM7azpt0zC4Wh?=
 =?us-ascii?Q?EEom5NRLc1mMjO5aV6P2PBWD/jWtO/jrDX99VD473hK2Ek5nEc5K2L4dpAM7?=
 =?us-ascii?Q?3QDm2SiCxKdTq/KdDQYbJmF/uI5oZRwFOvAQ29JOkb8ilkAFzAtX2tra1H5I?=
 =?us-ascii?Q?OhzR76P1sH/c4TfODMdT3tFPU2EN1opb5XSqqj4ZDHbJbEaDenbU8LQLbcnJ?=
 =?us-ascii?Q?QCKdQ8JBcHhO3KldJKNG0cv5TxrgeC60oPt5WHrOBQlBoHUBFx0muukX8DC9?=
 =?us-ascii?Q?fW/cvXqRxeIYS+XJ7ztXu9ah7pTnDr/u8IzyZSPVzr3b/IfOU/iBRzOQnnrY?=
 =?us-ascii?Q?T0KRDFsdiX5w8Wkbmtu0IpSfB4bJOzctWOkIc1uotMn5uR3NRQhkIySRPS1h?=
 =?us-ascii?Q?iOwuh76KQO4k3CdLLNkbesiEZVIpxBDGQ9pxijqmPG/nfvDxXUmFjmioO0Vc?=
 =?us-ascii?Q?Ks/azNte9g7se3AA3shDe1IsopNfkbwk0legzntSD4YmzyGqhKrTiP3cRh7e?=
 =?us-ascii?Q?iYAB720hFknva4dYe7k5CWRM/ulL0g/7uadzWvkxTFX1kVVaXuukPSmRr7P/?=
 =?us-ascii?Q?MUwDmjAqGGDBkLNoONpM174u1P//bvlmGFe3/VtL5Qu/fdGkJGcdHcAMf0it?=
 =?us-ascii?Q?GpsN+g6+YuhVD/+qmqnU/iu3NAidxiyakKnpNP9J5jGObIMWZCad3JjGwDvR?=
 =?us-ascii?Q?PtFfl4Ze/NhaBMofTGlE0olK6kdRHalk2GLwoHzaoJIc8WFjtuiFkEEzEBpa?=
 =?us-ascii?Q?+DNNFvBlX3gn4hMbAQ84aArgRSJpYiwazU0z1rNx48SXWemVB2SLqxN9mES2?=
 =?us-ascii?Q?Xyt/6qW1ClNUslqmbhZa02t0yojXCJ2/ABGQZi7yytGJS+xxvnvQrfZG9xPu?=
 =?us-ascii?Q?kJeezdekGXE00iSSTNwBNou4Nl0tIVevtYEW9n9pzO+kIIx8b7tXbzbXT2Ur?=
 =?us-ascii?Q?yIP4xe+N7SeACXL0bBqjZQTnDL1THOmzMTq5ux5ivEX0PsjUB8/yQt4r6xLV?=
 =?us-ascii?Q?ERMOS5CV8AgbkzldYRuRisiGIMHJ9PWGZAl5cBYhMgNWJ8D0ML4/lK9tL/N1?=
 =?us-ascii?Q?ZFvYaBsaIJHsoCkBTlP7EV9CQXojK1NEtHpQ058cPn8EEx7CbJQban0Vm5zn?=
 =?us-ascii?Q?CdM/Bleahpz7RI73R5DKCpB3J2qV0+L2Ob5Nq7f9?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB51524585CEC4E2B4B8370874E31A9DM4PR12MB5152namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af16e94-3325-4911-c3a5-08dad8246f8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 07:27:02.8239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y5Dxu7DjSumNAkfYt56HAmywjWuyGQte0c+Vg6ouUVxGJdg4I/8mbVP05Xb0Fu83sMB2vVJiZUWwOn3hwwGckQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7111
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
Cc: amd-gfx <amd-gfx-bounces@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB51524585CEC4E2B4B8370874E31A9DM4PR12MB5152namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

    drm/amdgpu: try allowed domain when pin framebuffer failed.

    [WHY&HOW]

    in some scenarios, the allocate memory often failed. such as do hot plu=
g or play games.
    so we can try allowed domain, if the preferred domain cannot allocate m=
emory.

    Signed-off-by: jie1zhan jesse.zhang@amd.com<mailto:jesse.zhang@amd.com>
    Change-Id: I4b62e2ff072d02c515f901000a5789339d481273

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index 1ae0c8723348..05fcaf7f9d92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -39,6 +39,7 @@
#include "amdgpu.h"
#include "amdgpu_trace.h"
#include "amdgpu_amdkfd.h"
+#include "amdgpu_display.h"

/**
  * DOC: amdgpu_object
@@ -942,8 +943,14 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32=
 domain,
                        bo->placements[i].lpfn =3D lpfn;
        }

+       retry:
        r =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
        if (unlikely(r)) {
+               //try allowed domain when pin failed. just a workaround.
+               if (unlikely(r =3D=3D -ENOMEM) && domain !=3D bo->allowed_d=
omains) {
+                       amdgpu_bo_placement_from_domain(bo, bo->allowed_dom=
ains);
+                       goto retry;
+               }
                dev_err(adev->dev, "%p pin failed\n", bo);
                goto error;
        }

--_000_DM4PR12MB51524585CEC4E2B4B8370874E31A9DM4PR12MB5152namp_
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
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p class=3D"msipheaderdf3d92d6" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0000FF">[AMD Official Use O=
nly - General]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; drm/amdgpu: try allowed domain wh=
en pin framebuffer failed.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; [WHY&amp;HOW]<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; in some scenarios, the allocate m=
emory often failed. such as do hot plug or play games.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; so we can try allowed domain, if =
the preferred domain cannot allocate memory.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Signed-off-by: jie1zhan <a href=
=3D"mailto:jesse.zhang@amd.com">
jesse.zhang@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Change-Id: I4b62e2ff072d02c515f90=
1000a5789339d481273<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_objec=
t.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 1ae0c8723348..05fcaf7f9d92 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<o:p=
></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<o:p=
></o:p></p>
<p class=3D"MsoNormal">@@ -39,6 +39,7 @@<o:p></o:p></p>
<p class=3D"MsoNormal">#include &quot;amdgpu.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">#include &quot;amdgpu_trace.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">#include &quot;amdgpu_amdkfd.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+#include &quot;amdgpu_display.h&quot;<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">/**<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; * DOC: amdgpu_object<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -942,8 +943,14 @@ int amdgpu_bo_pin_restricted(st=
ruct amdgpu_bo *bo, u32 domain,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;bo-&gt;placements[i].lpfn =3D lpfn;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retry:<o:p></o=
:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D ttm=
_bo_validate(&amp;bo-&gt;tbo, &amp;bo-&gt;placement, &amp;ctx);<o:p></o:p><=
/p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlik=
ely(r)) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //try allowed domain when pin failed. jus=
t a workaround.<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(r =3D=3D -ENOMEM) &amp;&amp;=
 domain !=3D bo-&gt;allowed_domains) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_bo_placement_from_domain(bo, bo-&gt;allowed_domains);<o:p></o=
:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; goto retry;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;%p pin f=
ailed\n&quot;, bo);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o=
:p></p>
</div>
</body>
</html>

--_000_DM4PR12MB51524585CEC4E2B4B8370874E31A9DM4PR12MB5152namp_--
