Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D17CC5B572
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 15:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A65710F081;
	Wed, 12 Aug 2026 15:30:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4D9+JUuS";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013034.outbound.protection.outlook.com
 [40.93.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C73A910F081
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 15:30:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVV5iYQerGlajWAEoE0REm/AU+ZBpp+ELCgjbP7txFuflKZsvCMOhBcX9b7PcLa4B+5QCgIWVx83a4Lf7Mnx1IjjfQLGEKwn30+/g0LM+4smlJU7iyUgcVSxAsB9X88b6slGMgYE9a7OQaE84iwUSVOcvUiAV9PU+AvpRcUsvKMVX+q/TqPs5eq/+0+4tJGIouXQLuLNU06VIObi/axFENzMF/tZADbRma32wlZKY7XENz412pi0As+g/03MMEHiZng6s6J8O0I901SDIxzllr8OEf9YdPnB9yr3qKMIzQ242csK6Gr9DudxnwC2NLVyXFUMa6XAXoXxcjlUwR3WWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mnllb3crLSk+EblIkp9DrMd+jLx7JBZkFXGNi8mR1+w=;
 b=N5VC9gXqrftAlyyZNU3Vr/NQlkEP/0Bo7pHD+0A0vt2bq0tpCAzEpA2QL5T1nPUVnntTfq8EDHRpDJK768RyavLQOWBahC/Uhs6vOVVn4xHD2XlFeGrSiBU3pnB77581Y/5X7NEKy9flmiGAuqkvGxBo2c3au3vj1cdpBOQdyroAwHembSyMYGZPYB2W0eP4cyERYL0AwkMyPG/jzA+sWdyAgSNwMdW+g4EFuwBg268o8UoUZPmsT4PbQxr9T2+PqC+Mgm8NRkBYTzMPNDuxfZuHr2SM52OvdP9bsE5Nf1Bk+bA/bdZVAda17XTpi2wPFSEcbR19lo6LYv5+A5Hoog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mnllb3crLSk+EblIkp9DrMd+jLx7JBZkFXGNi8mR1+w=;
 b=4D9+JUuSSAcylxy0DX/hqt7VS2RIxF+8Xur0XUmFMEobvS+UiAsxFcdc+g8rKTC3D2/GbbmuUq//PnN8+NtTKWB2T/N430x8M7ErFQB/y8kZ+IOCeyv77IKg1Tyet6gtodachf48BcevnhZElx8X68DGw5p6jN9NCxhU7cm4uoM=
Received: from SA1PR12MB8600.namprd12.prod.outlook.com (2603:10b6:806:257::19)
 by MW6PR12MB8951.namprd12.prod.outlook.com (2603:10b6:303:244::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 15:30:41 +0000
Received: from SA1PR12MB8600.namprd12.prod.outlook.com
 ([fe80::96bd:d94:4dac:b1d0]) by SA1PR12MB8600.namprd12.prod.outlook.com
 ([fe80::96bd:d94:4dac:b1d0%5]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 15:30:40 +0000
From: "Marioukhine, Vladimir" <Vladimir.Marioukhine@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdkfd: fix integer overflow in queue ring buffer size
 calculation
Thread-Topic: [PATCH] drm/amdkfd: fix integer overflow in queue ring buffer
 size calculation
Thread-Index: Ad0qb1u4tP6RDsYhT6yv4HV04Aw/mw==
Date: Wed, 12 Aug 2026 15:30:40 +0000
Message-ID: <SA1PR12MB8600EE73548498C578990CF49FDC2@SA1PR12MB8600.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-12T15:28:52.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8600:EE_|MW6PR12MB8951:EE_
x-ms-office365-filtering-correlation-id: 25e14ebf-1599-48f5-ffc7-08def886aadc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|11063799006|10067099003|18002099003|8096899003|38070700021;
x-microsoft-antispam-message-info: TMdS8Ski9VDQOrygye12Qutn4OKh7Sxz7KjbUWKdH0Z+4AUbTCgnfHyaTiWfZAcJbi9Btt8qP/OM0832V7geAnCj5TMD/Jq8QA1blX8ZsTkgKIPdSeQNSxtdvpECS8M/GuO2RTQXCrTzOzXuA3yKO4eTjj936k3GYRtVvU8BVrr8sZfzAXhUTg+FfD423Z4/qRc7xX/00G6s6TADMd/rqWngwZwTcIZc7a1/bC9Dg0fHo59G9jO9Ry8yQ2sQjnPUSeSov1kWVAu1i+hKWT1k/pD0P0jci+ku/Nd424CPoNl8LJ32JEo9/2Xgni/fm+1PLmR74tKcvvWgcOfuBwH432yLmhfdm1kVMf2tUVzSrv04RxuyAZM/xdgenkYalWz2vW6iQdmESucosbSKWpP1pzPo7YE/MF6LSU/sRfSJY9mEaaoLuEceK5FaGUGJ8DrWZ/+urvU2FqRS0sr7p/bM/Ea28Nvqnq5hyMaHgos7bFVnAPYHMc/r0OVidOM0aXA3l9rrdHfCc/Ls7b5b7bj3vzGnIb/1CcNHGxiD6KD0bTBp2Fa5j5aIC3M2Z11mdAHyUKl8vBAnuE3koCf001VH5qW3SKT/1XaM1oI0gIxBtvEHwGadRVBXl1vpidHB//ZPiQVOEmtWW+h+iFKdEgrfpgsBTa+GXX49MYUG7yZwQWsiX3mvqkvOQJeHrac4csQij8SpUh1DyIQkbVJtrIOQfjGPAWNbxjkSooV8s4O5ZYM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8600.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?piKVqEmSDj9kIoaVu1zHDFYz0GAEizdR1ugJTrWR+fzh6/M9ha0vGU/YPiH4?=
 =?us-ascii?Q?56UpClC65WEI3eabfAUyh/EknBbxhW0A96YN1gLJZr1yF9qU1zEMTmU16XeH?=
 =?us-ascii?Q?vk0LFJjAbS4dvKibwspv3J8rCwDirni9tFHNMAs1T5o+fWvc2iZhP6UPgekb?=
 =?us-ascii?Q?Snkomf+6X4TdbwrZH2CVZj0RbOoOh/8GxACPtXWf90aV4jFfc2ZDaQuibmZV?=
 =?us-ascii?Q?VB/eSyRHyNGXy4o6WX6EzEXr76/jQh572a/M4yWf+BooappX8sTCYT2e0Wvv?=
 =?us-ascii?Q?xPz4KVN5OpcRHdIKl6fXeKG8WFG8eKIE0gSpuUPr1ON63JmYCVG4bAXT+47b?=
 =?us-ascii?Q?GUzlrQ0z9/VDFDfA3pb6/Xy+FBsHKVDk23+LKCEcxZDpxAPQTp651QPnJ60W?=
 =?us-ascii?Q?QIJvzWuu4GdL9Aq6jmH+qW1YKKesr0OmOhLGrp4+bbbeWrJnUDHPVyX6wadj?=
 =?us-ascii?Q?qKhDM1mxg6P4jl1lrb/2Ps8JHtA1QLnm1emN8S36NEFL5KcHXF78K2mDTemm?=
 =?us-ascii?Q?35MoUpbjbAz7x3uG4/X0KCHz0BDY0Z6KlUPTVEXXy0iuVlXpP26dgzXgdNbN?=
 =?us-ascii?Q?rrjLZ2BNpiFlVqlj8JXb43QQDY3rBzyx1I+4YISv5rkYO7hZG5RSvK/VAVZS?=
 =?us-ascii?Q?i5DRO6137X0ORbDC/4YIk+lAST3ObKlpi3PPvzJUgqE+vJ6v1ifcsnjxC0TY?=
 =?us-ascii?Q?rObYMXLAEDE31e4q3gsAfIHEAerHeIR70mpqSxFoGHKiD5wuTC43rmiaNTt3?=
 =?us-ascii?Q?8hGrAkfyLE1ijII8rDWdQqTHcvdlassUgXsP4nAbBiB1BrosdosfUqZkeI9q?=
 =?us-ascii?Q?DnzmqT1x4sEeSZqBF6L2wUmEO5vOFQ+tkGRqe0y2zMxZg+K1y6QJOd0QFZ6T?=
 =?us-ascii?Q?uJfPwkvo3tKPTmQ9HtHKIu+2dK5y5qbWoYZtdHk3BO8HmptVtZNOZQlo2jVT?=
 =?us-ascii?Q?lVRCn+sEbLM2XY6mF3elGhgP6jZ7cRNalsAj85rmweHj48C0son/UWk4/Z37?=
 =?us-ascii?Q?AeZa6aGbCNoD/3rd5kmxDawTsczJ7K/BIXYHxhwIk08HGBB1cJm+2wQSjs2s?=
 =?us-ascii?Q?CwpBuXisXtm1rVi/qtHUSJxnrWOqANa41QQzy7kvzu3H71cT0IQZhuiPshHa?=
 =?us-ascii?Q?GN/JEhnLYO5smFLJyx0mOOkjsX36DuJ2gjrg515z+YxlNbWeqVafQNbjpIBx?=
 =?us-ascii?Q?Og9CIgphP7DzPblpYXtcoOomTD1w5lBFiWdYKBRjYx/G6xjO189CJSXo2EJG?=
 =?us-ascii?Q?cNiXtKSrincXEHcCG7SGLWMq2jgwJ3GVbVg2llbNfh600boXftfM1+SGp1Ak?=
 =?us-ascii?Q?IRItlijjZXkeUDgkxPkxyCPv5LgxKBbUMFDmGsnxaBT/2iFC87bgFqoAfku5?=
 =?us-ascii?Q?CPsPnwo/Ow3WkNHpACUzDiNFuetjcHGrds1B/tkJidffJTxiJvPGprqBC1rJ?=
 =?us-ascii?Q?3L5eNmU9k1JWsMJjf4N8kMHalA4mBsT/R4e1Vl+Y8nDSVIUjZBVw4aqJn7fz?=
 =?us-ascii?Q?+Rst4v6MURKKhs1zDWVaKJrJTVgNTQ5eyN0zX2nTvBhtpqo8h9ZszCZZBIV5?=
 =?us-ascii?Q?trjdGSDpWRPRQUcr4CLZqS9VTO/IOfcK36J1+MnkHbDRGtW8iva0yq3gc9r+?=
 =?us-ascii?Q?BA/nPLbvSGy75EhkH2RhigddBt8iMmOemaP5dz88h/zjcPuGOsD90hN8gWIq?=
 =?us-ascii?Q?Bt2WaicP1GbeosnWIwrSDwfJlSTPzHlRu+qW9sTEWTun8Fh6?=
Content-Type: multipart/alternative;
 boundary="_000_SA1PR12MB8600EE73548498C578990CF49FDC2SA1PR12MB8600namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8600.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e14ebf-1599-48f5-ffc7-08def886aadc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 15:30:40.9076 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rnOy1gbz8U72dfAtgmbOBOLls8cnkgy3lBGPV/GJxDKbjxKXXx9HfrWloWx59mZRgeYRzgpGfp2IrAVNx4TY3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8951
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

--_000_SA1PR12MB8600EE73548498C578990CF49FDC2SA1PR12MB8600namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

queue_size and metadata_queue_size are u64 fields copied directly from
user-supplied ring_size and metadata_ring_size ioctl arguments. When
both are set to 0x8000000000000000 (2^63), their sum overflows to zero
in kfd_queue_acquire_buffers(), causing kfd_queue_buffer_get() to skip
the BO size validation and accept any GPU buffer object regardless of
its actual size. The resulting queue is misconfigured: the kernel
validates only a 4 KB backing GPU buffer while the hardware is
programmed using a ring size derived from the much larger user-controlled
value, potentially resulting in GPU MMU faults and GPU reset.

Use check_add_overflow() to detect the overflow at the arithmetic site
and return -EINVAL if it occurs.

Fixes: c51bb53d5c68 ("drm/amdkfd: Add metadata ring buffer for compute")
Signed-off-by: Vladimir Marioukhine <Vladimir.Marioukhine@amd.com>
---
drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 12 +++++++++---
1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_queue.c
index 25954c2c2d91..52cc022dea36 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -250,9 +250,15 @@ int kfd_queue_acquire_buffers(struct kfd_process_devic=
e *pdd, struct queue_prope
                            /* metadata_queue_size not supported on GFX7/GF=
X8 */
                            expected_queue_size =3D
                                          PAGE_ALIGN(properties->queue_size=
 / 2);
-             else
-                           expected_queue_size =3D
-                                          PAGE_ALIGN(properties->queue_siz=
e + properties->metadata_queue_size);
+            else {
+                          u64 total_size;
+
+                          if (check_add_overflow(properties->queue_size,
+                                                              properties->=
metadata_queue_size,
+                                                              &total_size)=
)
+                                         return -EINVAL;
+                          expected_queue_size =3D PAGE_ALIGN(total_size);
+            }
              vm =3D drm_priv_to_vm(pdd->drm_priv);
             err =3D amdgpu_bo_reserve(vm->root.bo, false);


--_000_SA1PR12MB8600EE73548498C578990CF49FDC2SA1PR12MB8600namp_
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
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
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
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">queue_size and metadata_queue_size are u64 fields co=
pied directly from<o:p></o:p></p>
<p class=3D"MsoNormal">user-supplied ring_size and metadata_ring_size ioctl=
 arguments. When<o:p></o:p></p>
<p class=3D"MsoNormal">both are set to 0x8000000000000000 (2^63), their sum=
 overflows to zero<o:p></o:p></p>
<p class=3D"MsoNormal">in kfd_queue_acquire_buffers(), causing kfd_queue_bu=
ffer_get() to skip<o:p></o:p></p>
<p class=3D"MsoNormal">the BO size validation and accept any GPU buffer obj=
ect regardless of<o:p></o:p></p>
<p class=3D"MsoNormal">its actual size. The resulting queue is misconfigure=
d: the kernel<o:p></o:p></p>
<p class=3D"MsoNormal">validates only a 4 KB backing GPU buffer while the h=
ardware is<o:p></o:p></p>
<p class=3D"MsoNormal">programmed using a ring size derived from the much l=
arger user-controlled<o:p></o:p></p>
<p class=3D"MsoNormal">value, potentially resulting in GPU MMU faults and G=
PU reset.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Use check_add_overflow() to detect the overflow at t=
he arithmetic site<o:p></o:p></p>
<p class=3D"MsoNormal">and return -EINVAL if it occurs.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Fixes: c51bb53d5c68 (&quot;drm/amdkfd: Add metadata =
ring buffer for compute&quot;)<o:p></o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Vladimir Marioukhine &lt;Vladimir.Mar=
ioukhine@amd.com&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 12 ++++++++=
+---<o:p></o:p></p>
<p class=3D"MsoNormal">1 file changed, 9 insertions(+), 3 deletions(-)<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c =
b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 25954c2c2d91..52cc022dea36 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c<o:p></o=
:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c<o:p></o=
:p></p>
<p class=3D"MsoNormal">@@ -250,9 +250,15 @@ int kfd_queue_acquire_buffers(s=
truct kfd_process_device *pdd, struct queue_prope<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* metadata_queue_size not supported on=
 GFX7/GFX8 */<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; expected_queue_size =3D<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_ALIGN(properties-&gt;queu=
e_size / 2);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; expected_queue_size =3D<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_ALIGN(properties-&gt;que=
ue_size + properties-&gt;metadata_queue_size);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; else {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; u64 total_size;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (check_add_overflow(properties-&gt;queue_size,<=
o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; properties-&gt;metadata_queue_size,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &amp;total_size))<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; expected_queue_size =3D PAGE_ALIGN(total_size);<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; vm =3D drm_priv_to_vm(pdd-&gt;drm_priv);<o:p></o=
:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; err =3D amdgpu_bo_reserve(vm-&gt;root.bo, false);<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_SA1PR12MB8600EE73548498C578990CF49FDC2SA1PR12MB8600namp_--
