Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8482FC27C6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jun 2024 18:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E48DE10EE10;
	Fri, 14 Jun 2024 18:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xqAYJOnh";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D3510EE10
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jun 2024 18:05:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nR7sMw4zMuohSQBA2EawkkMEPEARLma9zpqzoTGlRI3Nr6yg7DGOYaZoglEdxEOqK4HD612I8su3H8I/uqDkSxHppuxcYErWcmSzdHAAdU3O7n+9mChNb3h80h+ctNfWIjzKPkKY7KImq1KJq4d4xYBw3ZJItK6eDbZX/KM/puUU2QY5RyiPftM9oDB7VYoGUTUPSD5KQrPOkKIR15qn2DGeX2M2rHU6932LITPC/OzOttSFR+vl+cdBNDTaseWFqfRXSHccGxxu8VdTSjQYJdr4bMC/QfgVBuMKwaqkyDqpDSz/HDzdu8o4aoV+91RpxrgaR9efqN28SQei3Zj4Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yx2TAi/HnbCXopGPpN7DanyxBaK6hhDs+mC6nkiYUkI=;
 b=NHZm5OVlMroJ1TUWChGMyd9pFVCljT8NWyHF4L9dpp3l85rSOZ6wt5OsCmUWtQc8YTBRyz9m/Axk0pSgQm3yyEuRDqA/oIBYb3ZTWJK1gL/tEjJdJU7DEl2ScN489kaipVP+mAi2xtzWXNhSCThDn2Tu4ao+KKNNRETkqdJypLasDPgWm+AF8TJjdMxaEzUBmLAVapn9N2vpRVFqRyHsugVPG5tltq5BQcRvvHGJUuwvEzYArJ4TFk324mp7tKCKrH4YXUhIZB1Tnb9PRGwaKf3Oh0VAefHCs05xUPunVE0Fal0UJBc9qc50OV6DW1VNwK9RBIb8kL6X+2Ixjpergg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yx2TAi/HnbCXopGPpN7DanyxBaK6hhDs+mC6nkiYUkI=;
 b=xqAYJOnhvEipVUg9+E9jO3FppWHMP6qRDwc0EQ5b5Yz60NXXgxfHfuB0SDqM0BvDwkHfpcJUtjH3u4oiDu8IS/guGbH8+5Og3orEihG5Y0HqKNwtqoK/RwHyAZ9cJ+KmlJbC0UTnT7gUMWif+caueHEI2NLY+P9bo5D3u1v6FbE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA1PR12MB6703.namprd12.prod.outlook.com (2603:10b6:806:253::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Fri, 14 Jun
 2024 18:05:44 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.7677.026; Fri, 14 Jun 2024
 18:05:44 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Jian, Jane" <Jane.Jian@amd.com>, "Chen, JingWen (Wayne)"
 <JingWen.Chen2@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/vcn: port mmsch ctx table size fix from jpeg v4
Thread-Topic: [PATCH] drm/amdgpu/vcn: port mmsch ctx table size fix from jpeg
 v4
Thread-Index: AQHau+cgzB8v7co3pEGijOO51Js3hbHHkvtP
Date: Fri, 14 Jun 2024 18:05:44 +0000
Message-ID: <BL1PR12MB5144DDFF8656B85FE4F0A320F7C22@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240611100655.227033-1-Jane.Jian@amd.com>
In-Reply-To: <20240611100655.227033-1-Jane.Jian@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-06-14T18:05:44.405Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SA1PR12MB6703:EE_
x-ms-office365-filtering-correlation-id: 05d31dd2-e267-4048-af51-08dc8c9c9c7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?pC+++Eaxg9QG7uuW16SBYWeCPtzCFKLGVi0TAkIXq7D+dyyR5XQmzMbjGXXI?=
 =?us-ascii?Q?9jhKGWlwT9CBLURrD2nYmCuigxqm0EiDnD0tGmxH7KrFuoEabL0vIrvLqYuS?=
 =?us-ascii?Q?Esm9zFt2FdZsE6jH+6mTS3Nphre1JR28IDUpZIZ6j3ORIacQmRSTFW8FPmw0?=
 =?us-ascii?Q?FBnGRIkfZDdG/dSCurFdmeevWBB/nZzMtbuq4zuvfiPN4SjjuZak36gzODRz?=
 =?us-ascii?Q?QyhxmwzbjJ1X2u+nmewq6LqoEi+zFC+UdLPA1Mygv49/Oi1t+x+MxK0iHw55?=
 =?us-ascii?Q?Q10yQtpvy82iP7pqNRZs5Y2RGrOBSqkj2HtWkJRIE5PQSKDOZIe+v0x7E7N/?=
 =?us-ascii?Q?c5HbaIJHnuPCG2KPkmfjpgcA2aRCgc3N/j9inm4FobmjkhufkKHWbOXQLixo?=
 =?us-ascii?Q?+9g9857zSEyso22oZ3m+NYXBeDBsGAFvMfgeuxMu5Y6BIaHKt++PhY9kbehr?=
 =?us-ascii?Q?BnQBY03MqbIBLI0q3+FTpFBSLCWzTQ+myNL7VpISTf2jWIELz+/YyFY/yFYu?=
 =?us-ascii?Q?GlM7nD+OVisv0g3Tb+B4jXop4xFmICplu1n0Uk31nFqom2m2v8aA5P5bGmn3?=
 =?us-ascii?Q?r+0Nw7+IFdzhsbyqEJdgB0HWou2X8ByrcEuv1o3Fd0t2IsHrn6g1ry5nOHX4?=
 =?us-ascii?Q?VcR6gDWs/6Oqyyw1Pvp3u0u2ptR6Utwy+6yRalw59+Q/3/FNwR6KhLkjtmDy?=
 =?us-ascii?Q?2Fps1N3AKKu1gQVcKHzGj+5hRe4mF7O84+kpA7/6JS/yXjmU4wsgwVdaGWy8?=
 =?us-ascii?Q?qSg3rRDDgbvP/L85xAHwcWH0x/smvz+A4Ig1FeMXg+lI0uRCl4pXWWioUQYN?=
 =?us-ascii?Q?yCryJnMUkylHezX6C1zufAnG8TZFV75KJKdYEmeZzrdlLiKOD1ock29dHsvz?=
 =?us-ascii?Q?dieeKZUcOv4CxfEQRVqkRwKmadO5RujbYFeyLsmXM94g4rl1NH7/6KFuc0o6?=
 =?us-ascii?Q?KpYxRiMjfGUmKMRxoOnje6PBPFAbRJT1qovYE73FLv4dejiKq1sAIxFAEM7y?=
 =?us-ascii?Q?DuCLwg3we10tR1SyXqQq8CkeOLVnuT8mROaNKdWFlJbhdj84ea+w+GleG343?=
 =?us-ascii?Q?6WS/K5kJwgWWaF6SoP+PtfVcFr7luGeGPAeEavBI1Bslxw8jKinjdJAgbu67?=
 =?us-ascii?Q?ax5rxp5h5OFoxP7fFVuTnrYhP3aVZKpcKz1FmD3vI1/pip3TtR5no9RwPaOM?=
 =?us-ascii?Q?/wYLqluKcvRQ7x5WwJ1JEL6dQTiMyNl0IjFBTb8IcE4Cmp/zgKIHC+TwkZIK?=
 =?us-ascii?Q?a2aNyuaooZ68jIwfn/7+LSQ3AQD3uGMKsLMDHqLiLCCoyrRzmDF8U7jSqLD3?=
 =?us-ascii?Q?hVSG2H4JG/7WM15XvcZN5bfx2aYpbSwxeIMtN3KiyAP0+72C9amcBqHmO90T?=
 =?us-ascii?Q?ROIr/90=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(366013)(376011)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EDszGxjIkCOMW2HtN4x2fdWNOjcRwWiNYaS3MUklFZV5iUod53ucxRZ9UpVV?=
 =?us-ascii?Q?c2hFiLTQUMlypGJZW1ggGFtBzMmIHmNKLMXJP5UOcFqfxoFMUu3hoaGjfjTe?=
 =?us-ascii?Q?MxK1uk09Ni4R8l5dEqHaGWAJFpxHbqVCxyYRZrp8Hwb78YZ6fROajvNFc62w?=
 =?us-ascii?Q?gRm/JE5XGOIt0d7eRFxGK1xWl/nrQF5vuUegqODmRrq24m/4+yn7j0XK54XC?=
 =?us-ascii?Q?7O/hACOzp6F2kggINq6Z2ZOi1PtMLR4OBr3k1EqPrk1d0i5UKWL8N7HwWsUC?=
 =?us-ascii?Q?uh58tJs/WBcOhSTryERM6Hf0iVUWrCx9/8JiM4t2CwqV/e709S39m10TB2ZO?=
 =?us-ascii?Q?67cxYN7AYev0aGu4t5Fsy26sXMh7EDpugZzFsATxRTEL5SSTmkzgrl/Uhhat?=
 =?us-ascii?Q?mlA7jJrmRvo4MEs8URPVFQeXlw893ezISCseczXrwwtNFVc1eHB0eiqlhIFn?=
 =?us-ascii?Q?ldXh/46SqV3HfXWp5sY5vtPSEwXHi7h0GORp8oNknEKYHRZ2gYTADbyf4cs/?=
 =?us-ascii?Q?gzKq2AvYlFXL2nfccxnG30FUVm9Zvj+5qS8uITjs20wTaRlDIcOIXVjoyxcl?=
 =?us-ascii?Q?II4gxmHcSQ6iRKaKhlcxDD4HfvxxsopiQIbtHsxDqdk0dx34J2F70Pr8FTMU?=
 =?us-ascii?Q?YzA74mbmV4GAWyA5fRj8RPo/nwkkGZXdv6YZsTPRVrwrCU0jY3uF8l5Ips2P?=
 =?us-ascii?Q?Cm7S4tfX9JLy7p8B2CkgV8QfJualJxisxVX0tPZqn3O05LePGTzp6vGLWZAu?=
 =?us-ascii?Q?wBLEJy6omOovJj9gnxvyTeRjcFvpVs34j0O1rysF1BYLJBDmADTTi82/P6L0?=
 =?us-ascii?Q?DcRaG7tg0QejzZx/VCRxsW06UutNOn+u0LP3Qk2ZPAIUhv/DZja+/GqPAwKD?=
 =?us-ascii?Q?KReubt1yeLfXEzQDM4PR4iBOM07tecuvoy+NBMDFHHuHwAHEN1/WpP4xtkba?=
 =?us-ascii?Q?QEjNuhvG7Xb7TcTT+iWiI++kNXoA3o1BLvIfym1JmRf4ZBhxvrKKZ9GcgaFH?=
 =?us-ascii?Q?5xVWOfInP3X1Oc/boiUa6G4EXBQQCQMqqGyPOQ3W8EJSW7uKm4W7aDx4k+lJ?=
 =?us-ascii?Q?OH91LFZ+mjVXHqgV25WkwHBz3ni/CW5ZMM+pBssdtYUX9wK4X0qhllZTszit?=
 =?us-ascii?Q?SovmzVt1eGzxI37LYxKEfyLOelQ4t90gyfJPUqOEZOGBmjdyiz58NguBuaPQ?=
 =?us-ascii?Q?MkXwyQ7fA8viKyhow/h63NdCLJDJC7nN1kQmDmow4idGkbNsY7uVQQYZERC2?=
 =?us-ascii?Q?K4t/U49aJE2YLYKvqFVRp3Qi8sGTqmfRYRTR2NRdrAkB7pyOiW0jbCdxyOvt?=
 =?us-ascii?Q?6j0NFHc4QWi8eiz+W9wdETHs/0PIfvCkvCE6pj4HzBj7Rw2bStcF9u8tbav5?=
 =?us-ascii?Q?bAYgpnuFZ3uL72AqABWcqQBVMpXpDDIyKbCrrXlUG6NtWJmXXPfEN3GlowMO?=
 =?us-ascii?Q?RWWt8MuQTdNhBGdQ9lOJ7LFVjvX4jCmEAaK9K8KWKKoXiEX+TIgge2smy6dq?=
 =?us-ascii?Q?8lt039IR8/noNCp80xEzAu6rrqo+ja3J4YcyghN3cdb8u7DE03HLoaE9fWnN?=
 =?us-ascii?Q?cQlwsXfhG197ka6BnoI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144DDFF8656B85FE4F0A320F7C22BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d31dd2-e267-4048-af51-08dc8c9c9c7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 18:05:44.7479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hGzgbBSxNKC4zH9bVC46UuV8MsdAI6c4RelDBneP7Nc7/BI4rQiwuKWY8d9+lKD/SinVkLcB7+lp7o6IKz9eHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6703
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144DDFF8656B85FE4F0A320F7C22BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Jane Jia=
n <Jane.Jian@amd.com>
Sent: Tuesday, June 11, 2024 6:06 AM
To: Chen, JingWen (Wayne) <JingWen.Chen2@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Jian, Ja=
ne <Jane.Jian@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: port mmsch ctx table size fix from jpeg v4

add jpeg table size to ctx table size rather than override it

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v4_0_3.c
index 04d8966423de..0edfb7754768 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -202,7 +202,7 @@ static int jpeg_v4_0_3_start_sriov(struct amdgpu_device=
 *adev)

                 memset(&header, 0, sizeof(struct mmsch_v4_0_3_init_header)=
);
                 header.version =3D MMSCH_VERSION;
-               header.total_size =3D sizeof(struct mmsch_v4_0_3_init_heade=
r) >> 2;
+               header.total_size =3D RREG32_SOC15(VCN, 0, regMMSCH_VF_CTX_=
SIZE);

                 table_loc =3D (uint32_t *)table->cpu_addr;
                 table_loc +=3D header.total_size;
--
2.34.1


--_000_BL1PR12MB5144DDFF8656B85FE4F0A320F7C22BL1PR12MB5144namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Jane Jian &lt;Jane.Jian@amd.c=
om&gt;<br>
<b>Sent:</b> Tuesday, June 11, 2024 6:06 AM<br>
<b>To:</b> Chen, JingWen (Wayne) &lt;JingWen.Chen2@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Jian, Jane &lt;Jane.Jian@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/vcn: port mmsch ctx table size fix from =
jpeg v4</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">add jpeg table size to ctx table size rather than =
override it<br>
<br>
Signed-off-by: Jane Jian &lt;Jane.Jian@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v4_0_3.c<br>
index 04d8966423de..0edfb7754768 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c<br>
@@ -202,7 +202,7 @@ static int jpeg_v4_0_3_start_sriov(struct amdgpu_device=
 *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; memset(&amp;header, 0, sizeof(struct mmsch_v4_0_3_ini=
t_header));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; header.version =3D MMSCH_VERSION;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; header.total_size =3D sizeof(struct mmsch_v4_0_3_init_header) &g=
t;&gt; 2;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; header.total_size =3D RREG32_SOC15(VCN, 0, regMMSCH_VF_CTX_SIZE)=
;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; table_loc =3D (uint32_t *)table-&gt;cpu_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; table_loc +=3D header.total_size;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144DDFF8656B85FE4F0A320F7C22BL1PR12MB5144namp_--
