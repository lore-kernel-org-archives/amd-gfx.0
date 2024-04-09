Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43836CD128A
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Apr 2024 21:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C89A10EB8A;
	Tue,  9 Apr 2024 21:35:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CosFvr4Q";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2090.outbound.protection.outlook.com [40.107.237.90])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6483810E347
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Apr 2024 21:35:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laKX6DKyGMylwi7rifAG4NqPObzjlMubi6j/wsN87xGl1kFCknt6i0LHBmuCEvyt6BGEL3WQZ4lKhvx4W0ZeDK4M8TrA0FCK/oiCqMCVS3JkKqJGvP4mDrGWCi+4Dp+v8NXg09Ws/wkZCHIkQcfJTGYRbT9J9iNAYLQVe/gv1uW8NUZtnV3rsChZd8r50SBBUDyVhuv2eD9EU4UFll8xQwleyXKhRGRfF9Z8/+ROUgTaoL8Krf58lF85W9m8QViN4Uexl63LUn+nBppao01NAMwOPrSOGXKvqxnkb797fpHNQCHbMbyYROK66wQ6vNbnfSaqsTqC7ChmAFQE0MVdNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5GAtNNX0bnMsvgvVEJ9jSkrz1oVwkSFB7p65//zFqE=;
 b=mPqNvFVqxUXR/AaFazTZWMw/qx2owJF/vdikj/noORBLctOXxFXNueiX1UrL/CCVK/VPeipoK66Jq707lfqMzCDq0Zp0S5mNn2QLYxklmeKKVrbC1he3EhE5IJTbsWVDBMoOeD65D5Ag/WRcvgMPWjnWbS48fo5leE+ArF8ODY0Aq4uPGRy8pCq8C/a3CgJcHqUll5LyYN5Y53YeAmn1Ia9vp+JWcli4f1ZNY2JKkc1P0AI4vYn0wtahHYb7rj/JbFw9yglHPO5O9yir5qot9c9e0ndkJWmbea8bxwm2weB4eyobJCKu9T7hcpGyJ9sZtPEU9kvlARor8m2fFflxoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5GAtNNX0bnMsvgvVEJ9jSkrz1oVwkSFB7p65//zFqE=;
 b=CosFvr4QEqunsOy7MLWJuckAdwX8y4cZ3VBcCssXYd4VDCzDqz6EYW3vsU/Yh3Ho3BuiOTTLJk5Q0zntitkzHaz7BLgv2veJ2rAWYr+8smJb3gZE8+gmYu52DAl40eDb+vQnFv77hPgvO8GO3h124GMsAMN7m4bXeNoCCvyQi6g=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN0PR12MB5882.namprd12.prod.outlook.com (2603:10b6:208:37a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 21:35:17 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::b001:1430:f089:47ae]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::b001:1430:f089:47ae%7]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 21:35:17 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Irshad, Luqmaan" <Luqmaan.Irshad@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Update PF2VF Header
Thread-Topic: [PATCH] drm/amd/amdgpu: Update PF2VF Header
Thread-Index: AQHahUloWy+H+LYS8Uq2YnMycoZlM7FggPhk
Date: Tue, 9 Apr 2024 21:35:17 +0000
Message-ID: <BL1PR12MB5144B4D44BE6AD0BE6170FC8F7072@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240402220137.184869-1-Luqmaan.Irshad@amd.com>
In-Reply-To: <20240402220137.184869-1-Luqmaan.Irshad@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-09T21:35:17.293Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MN0PR12MB5882:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sH1lJq3YJ+xFTXCZxd+E4mlx7HtlCv10kWwMoWcF8WNfmVk3dZ64HcUctX9x2XY/QuIMIjMiNTuFF4MMPkVHyqfwKO+avOn/OMvuAEa/wDEtGVG74FtBKBkVRZqjZRKIctp+joiI/3vlk9sqHL1AwGzDtqe3OZyKwr2E0Ji1pxSU0GZ0/sHpF0kD9NG7bMyLA5ESG0zeHnfrpOwc+1FVIW1hi4M3uC039KiOReSsf6QR4fiIeJY9n7wC61Oz3X5JbeB0Rqp8ZwFt4k1q+gwam8hlNF1MrfFWY3lkT2wy8gzh0f/oPTxtAoU/rTConVdoUzj9IJZS37IRwJ/bs3N64s9h5MSlL04tLdUlitfpBWbNNb0lpJXHOG/GUxSPQzsvwlyoAIl0fojUqtU4rBRmIHqXhz5q0Fn8tsSB6hG2WYg55srAqOvC/XmPh+WsC8yZT5WMRM3Mb+hqje/qB5V1K7KkhV2m9JFmaJS8KWR/N7gQYMdXIPXbbl3SllfjJtlwkhEpbTrkrh6KOw5b1hBWfYOgEttuu2pkjQZ2AczlWz6w73S6LRFmbLRW6d9mLE5wuSbuzuuQZ+l+mFb4T2FlFosJZ8qqm6JDjNwZq6vFtAhXL1d0mhONspZAUzXpEINYdx5GyNmU+9Dkl4HxtSfngfKubrWJCaQ/XcG1dvxWevQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yhrGz17z5bA02QTLt6lZawJBnY9Q8jlOlW98Wl0KFHghjXrsKCXVIeZjrYS7?=
 =?us-ascii?Q?1J33bOelob4RyD56tw5zDapqIb101FSbNkEi/3NHMIQrNAcKXpCJURWxL4E2?=
 =?us-ascii?Q?lfmEejhU1sqEFf4CQE6BYHh3VcAnmt5RyupJ6UEkqgu5ToT5Jvm6hrM5EGRj?=
 =?us-ascii?Q?vPXeYG7l6D+tO5cmNgeOE+FbUDa9XqHiG/3JX8AvNl7KEavD273V1Rvg8tof?=
 =?us-ascii?Q?clNd4obcfpUHXiFh8Kq1HeariTVcfQWLxdF94wRbV01XyKEJ0KHlQn47fpVG?=
 =?us-ascii?Q?qj91jaoODbgpe+s82dKRKysqM27lHwv0CsYCs2YKH1PBNwEsiUt+l9NLeL8F?=
 =?us-ascii?Q?I5YA/jPOrHFZuoPtXbae5TrxIAR1lwXRnvVYZDmz05PX0xZ2sEkmf0zOoZUF?=
 =?us-ascii?Q?pBPj1YZ+PLSiAEGAEbQIc7kt0C/xFuHD1iwDcnIc5UrE5mqc9b1snj6IEC4L?=
 =?us-ascii?Q?EBVh9RePhz2pgik9bjsD9/uHjZK7HSkI3dZuaGazAvYo/eVHdy3w/2G5L78k?=
 =?us-ascii?Q?91oD/DFSHDvtrJIt4lRs9Hq/XSVpfNAvnQWNrKY9lWe5MULLFE/6qM4cF+qa?=
 =?us-ascii?Q?ccwY3hY95CAUoUgQRMs3HbbCXrAo8YcSIAnpp3roBWXpmRbe2816TLA88+dN?=
 =?us-ascii?Q?5BgHZ+60cEY5OAAfc8uSDEgczgJhzjbprL7nAQRf3ObRhFJr7ayVx+9kvlnt?=
 =?us-ascii?Q?FKotrOFJfbS5cHBe+cAdtyFLS8qYK7U3O2adr419nbK8Y75UW95+cVc35pQJ?=
 =?us-ascii?Q?qKvC3exVUMuIHlG0G8bzctUqsQe7WWROQbZA92YMuZK6xf2EHFptMGfmDzzL?=
 =?us-ascii?Q?buICXeO5ol3ZAZUCxrR5IldNuprm8mK6GkFW3kU+LRUczFW6Yx165WSreNJg?=
 =?us-ascii?Q?pvfR4GuCdkkiuyNtRb4IJ5pHO68E9Ju0ylkgrY83Nl6VmbMl1nU66o9ZNB6Y?=
 =?us-ascii?Q?H1uR2C3ht8tDPvMMfpjjw9CbbKvmVngT0uyjPi41balyzpvuaqhSHwj7Aw8J?=
 =?us-ascii?Q?b2nOH1RQHtPSpxq2gPiA5IXeEAXPL5XUdC1tRSs8CLemmtNITf8IEnmXG7Y/?=
 =?us-ascii?Q?XIE5u44RsjpwQCn/lXeE6ADw/JVLrt7xjm0G2fynA303xDhV2E1Sm4FWqbaN?=
 =?us-ascii?Q?pim26QJVODQJ6N+S/VMAixXLxxwrnagT59qPoefW1mNzt1Tuq3LpIXRYBPHP?=
 =?us-ascii?Q?CzM/XXPWiFJ5eXxaDzYujAZljPT3KMFyOR8N2YAoqKNOWt9dYW6I/1oAThLz?=
 =?us-ascii?Q?QMrWbjof4M6gzjjVyqhXuEFIo2SRDfyS9y/T5qQOWH1gUTq5dg9BB9pStlc2?=
 =?us-ascii?Q?7lc5PSB0MFw9Pln26nV6Q1/bWEnN9YZ2eg80+O6wYiM9c6r/5fEfVSRcEeiq?=
 =?us-ascii?Q?X03LJGcglv4Evbv3MgD1bJEa3JjeLjCl98Hmh2YTcXhSUubkjfK6vLtPzmNz?=
 =?us-ascii?Q?8efgR3SwCo/Jj8tB+Ez/TrM11r97jVCLxZJ6RLP/S7MQb+mh4v+trax1n4TJ?=
 =?us-ascii?Q?yzP0EGzpwAir7tnU2mPu45m0kiijsjiODcxIxgjoktW+F9gvVNEcbcXkGTKh?=
 =?us-ascii?Q?O1OiYnWKA2ngBuEIqL0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144B4D44BE6AD0BE6170FC8F7072BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0e6444-67dd-47af-bb6b-08dc58dcf34f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 21:35:17.7717 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pmL/ZxuQEkQXskFbRihHM6YkKjty0lJFP4PxXmY0O8sGT6JzgWGzMQHAVk/W7l05wGN6QI+sj/DweEqUpSdZVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5882
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

--_000_BL1PR12MB5144B4D44BE6AD0BE6170FC8F7072BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Luqmaan =
Irshad <Luqmaan.Irshad@amd.com>
Sent: Tuesday, April 2, 2024 6:01 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Irshad, Luqmaan <Luqmaan.Irshad@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Update PF2VF Header

Adding a new field for GPU Capacity to align the header with the host.

Signed-off-by: Luqmaan Irshad <Luqmaan.Irshad@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/=
amd/amdgpu/amdgv_sriovmsg.h
index 0de78d6a83fe..fb2b394bb9c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -158,7 +158,7 @@ struct amd_sriov_msg_pf2vf_info_header {
         uint32_t reserved[2];
 };

-#define AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE (48)
+#define AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE (49)
 struct amd_sriov_msg_pf2vf_info {
         /* header contains size and version */
         struct amd_sriov_msg_pf2vf_info_header header;
@@ -209,6 +209,8 @@ struct amd_sriov_msg_pf2vf_info {
         struct amd_sriov_msg_uuid_info uuid_info;
         /* PCIE atomic ops support flag */
         uint32_t pcie_atomic_ops_support_flags;
+       /* Portion of GPU memory occupied by VF.  MAX value is 65535, but s=
et to uint32_t to maintain alignment with reserved size */
+       uint32_t gpu_capacity;
         /* reserved */
         uint32_t reserved[256 - AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE];
 };
--
2.44.0


--_000_BL1PR12MB5144B4D44BE6AD0BE6170FC8F7072BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
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
ounces@lists.freedesktop.org&gt; on behalf of Luqmaan Irshad &lt;Luqmaan.Ir=
shad@amd.com&gt;<br>
<b>Sent:</b> Tuesday, April 2, 2024 6:01 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Irshad, Luqmaan &lt;Luqmaan.Irshad@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/amdgpu: Update PF2VF Header</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Adding a new field for GPU Capacity to align the h=
eader with the host.<br>
<br>
Signed-off-by: Luqmaan Irshad &lt;Luqmaan.Irshad@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 4 +++-<br>
&nbsp;1 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/=
amd/amdgpu/amdgv_sriovmsg.h<br>
index 0de78d6a83fe..fb2b394bb9c5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h<br>
@@ -158,7 +158,7 @@ struct amd_sriov_msg_pf2vf_info_header {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserved[2];<br>
&nbsp;};<br>
&nbsp;<br>
-#define AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE (48)<br>
+#define AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE (49)<br>
&nbsp;struct amd_sriov_msg_pf2vf_info {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* header contains size an=
d version */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_sriov_msg_pf2vf=
_info_header header;<br>
@@ -209,6 +209,8 @@ struct amd_sriov_msg_pf2vf_info {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_sriov_msg_uuid_=
info uuid_info;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* PCIE atomic ops support=
 flag */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pcie_atomic_ops_s=
upport_flags;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Portion of GPU memory occupied by =
VF.&nbsp; MAX value is 65535, but set to uint32_t to maintain alignment wit=
h reserved size */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gpu_capacity;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* reserved */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserved[256 - AM=
D_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE];<br>
&nbsp;};<br>
-- <br>
2.44.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144B4D44BE6AD0BE6170FC8F7072BL1PR12MB5144namp_--
