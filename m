Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDB0C5DF66
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 15:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7101D10E86D;
	Mon, 17 Aug 2026 15:36:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b1E0t6xC";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B18310E86D
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 15:36:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGlEqN3k7U4SJanVHlOig8rjCvnoemgKwuh+rJ4+2AzawFs9bqoTn+ii6Ow6gJIrzwujG6tJvJ2QXvNuRd/fHtswuK0VIYdJJ1zni1yfKfXGhpC0epIw5cllhSXsFpcd/hM8y/FkT69VeQcTXctOz2dh8rnuENGtXIKbBscx69AmH85MQpVyYODGfL8Ob2xJs3pu8WDTXAOwaXoEGKwXIFNV+yg0ffC46QIconaTRkZykV5mbMU69+xSFAzuJIORAqbztav1Qm3fqvJYMGVOk4pC6BUhlKxBLcBBkBrw27nSWJMppwUtYqWofW0PFpf+ieWgpV8HTNir23FoaWrzlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnFuzTdx3sM4kFmefNR8LhGhlrQWpCW5EJyEU4988N4=;
 b=x0dNmFuZDCGeOB0Z0wxZ7WMEUEbLp9PC3WvJkbjCewZ4GoqO6FKLwTA1yj3v52STIEpFZwxJmJ+uzxoTh1hlN78+zNOWwfBOWOS2Vw8htOVG/BlBZdHjwWjaed77xs9m6j7Y9mhZ+Iwdc84iaA6E8L6kQyEl4VFqQldH2j+SMu+ELOVV/pj1HkSOkE+xNtmtGJWoizpAtsDbgl3ujtew3JJwQhRGVbD/SHCz0Y4vFquQuzLCt4kH1Dzk+r/a0TzJHLYW6BrkKKXP/k2zIzfy5MKEFK2M2CjtuLTndl3zFaPTJzIWCB0emg1GF1J/3pdGmtBfqDXW78Jxio0oH70wDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnFuzTdx3sM4kFmefNR8LhGhlrQWpCW5EJyEU4988N4=;
 b=b1E0t6xCzG3ypBVCq90Ho97ro4xhCp2Ew6otbzr4dsHVeb/8Ozkou52NWMeMCBwFgebr7iOUCrOfhvVIYBDUfOKv8J4oc6BA2WJsQVTfBNStTmn5Tb4bzfPqCG577RxZZ+jNM0g4DZ9oZXVEpafEmS3eb4Qatn65B8KIMCHDU1k=
Received: from SA1PR12MB8600.namprd12.prod.outlook.com (2603:10b6:806:257::19)
 by IA0PPF0A63E7557.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 15:36:19 +0000
Received: from SA1PR12MB8600.namprd12.prod.outlook.com
 ([fe80::96bd:d94:4dac:b1d0]) by SA1PR12MB8600.namprd12.prod.outlook.com
 ([fe80::96bd:d94:4dac:b1d0%5]) with mapi id 15.21.0315.008; Mon, 17 Aug 2026
 15:36:19 +0000
From: "Marioukhine, Vladimir" <Vladimir.Marioukhine@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fix integer overflow in queue ring buffer
 size calculation
Thread-Topic: [PATCH] drm/amdkfd: fix integer overflow in queue ring buffer
 size calculation
Thread-Index: Ad0qb1u4tP6RDsYhT6yv4HV04Aw/mwD7sHIA
Date: Mon, 17 Aug 2026 15:36:19 +0000
Message-ID: <SA1PR12MB8600DD7A487308741A4FDA6B9FA72@SA1PR12MB8600.namprd12.prod.outlook.com>
References: <SA1PR12MB8600EE73548498C578990CF49FDC2@SA1PR12MB8600.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB8600EE73548498C578990CF49FDC2@SA1PR12MB8600.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: SA1PR12MB8600:EE_|IA0PPF0A63E7557:EE_
x-ms-office365-filtering-correlation-id: e775a725-d762-4291-70c5-08defc7548a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|8096899003|22082099003|18002099003|11063799006|38070700021;
x-microsoft-antispam-message-info: Warz9H4pn3iOpALKNzQDGut2cBiuz60WZs1q3/CmnNQg17czI4TinUzaryvM2hwWRglgwNIuItVqt6ria9v0mmkCg/SfSv/Tovb1YERnpgnxJIH7cV+8cLXRaTBMvso/Gsw5kMV1PYdSYYluxJpwJg+E1aMyc8uRig7byrb6cq5BwLGoahwtdbM/W4+67GZVFmaP3rHBhhA1LMrM8NjaKnZSkMU4SBVrqjyXCwB3Wh6jg5kuAx4k2GVWczwWGNrckRvwqtAYTN3ZcPYHKrzY7T93KacshMW8wzELCetVoF5gb0e/AtjH0sPl9RIJdrNc8IX8vqDukWkLOcoVknkiv81NSkhpK49yl7uIjLo/dhei/DU8VV3PTrQ8/+KsTb9UdRndUkBMxDo+VoGJiltm/k4xij6dcfYxpRrGY0qoKHU15hf20mwptHw2y2tVjdFsYSsey5hlhdrhJ6hc9e1oEJxjS+xYEWMMhw+eEnxvwTLZjCijB7RA/loiiAPQrwVIFf+1hvYAUqLmkS/SAQh0lFYtfOTLH/qYqogvccHWCuQzfMTcpItAjCjiSjE9hKO81W1qnHbockLnQFISSeoAmGm2fI3DBm17W37hi0hD3FN+pGShidAxNRZ3OZX601ImfDIhYZm3F8cKsOjuXDc50MGWQJ+iqHExLLWlhJtwthjGRgEi0gcciqox5l2HmPbLxHgS5eb7jxr40okV7TaeZ7vcli/AF5wjoTUosEWDbKw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8600.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(8096899003)(22082099003)(18002099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n6wUz2euoae7LrwZndsUVH/fGS+H78l0FGzt2QIrZXXa9Rx8x0CvTtD/LNFS?=
 =?us-ascii?Q?Ay1nWmDL5MfDhElEaijcyyu7rAGmtJi7dpeFmiR4YUHkrSfJG8+uIjAxQr0W?=
 =?us-ascii?Q?7xWs7wLJEbFA6usoz+MrK7Q3ssBACKUBORE8yrLDP3guI2k7fxjba6gtFzny?=
 =?us-ascii?Q?ws+42+/IVMsW/Yyyc3175J37QvauVJ1dYpp/tiyr/aEaZH35TA1v9cZjX3fQ?=
 =?us-ascii?Q?GLc04px6T0QbKxDJAnOu1Ff1p+TsLdiDf4tJcNpFSh26PcM86NmQm0B7Mptw?=
 =?us-ascii?Q?B9qH/YkPiz47LJCusD0ETVFzHi9WSPz7sT6EZ/CS1nnttJBdT47+1j1T3K+j?=
 =?us-ascii?Q?tOSO4/WUB+s4YO7tKKZOUsGw5x01L8x66zysJyYA5vCo1L/pzanJJoWaeppz?=
 =?us-ascii?Q?sXJWJFCZWUnF0GnJKgT1NwN218kRvaikjsfHcPEsiFmNCCaOfwXybVTMzWz7?=
 =?us-ascii?Q?pjUULQVoBiEPUraM79KIyP2f364L+gS4wn1cPBVpj29JSsQqMskr6VczxzSn?=
 =?us-ascii?Q?HXZIJfE6Vm0QlG8nYuC9T25BSEKu+U+hteDMv+CBcAg5lomhBtfFvXyQebFt?=
 =?us-ascii?Q?OXWul0pbwhvKFHZcgO3M5C9Anrbagn+t5lDO/TQvoPD5EqTD40jXn2AUwdqm?=
 =?us-ascii?Q?ty2ru1BQAcI+3vHK+i/xDu/qbuZf7lfTr3PTpEf4lvewmjAcZszoVPnEaTRB?=
 =?us-ascii?Q?aIhv4/hXALS+lprH2d/flCt5vUn86i8agWu16vldOK99p2vYZdpA22vnY4AD?=
 =?us-ascii?Q?g36u0QHwHrm+/OiqVgf3/FVxQxDWM/9TNfRthEpu+AQTqcF9Kiiw9BCtM1kR?=
 =?us-ascii?Q?EaPRk2ex5aDGq5PXlvF6tkSkMafVdCCG/8/itQHwA++o9rAveWgLIyI/UyFs?=
 =?us-ascii?Q?KZuYokOT3N0TaQydZBTRXs3pl8AhOkOK9zEZVXbHOuLFwPNNiU8SK1qWBg1d?=
 =?us-ascii?Q?cLcCGGDkhTHVp2qGGw2HhgpFhHIFB2eQpkXi0UIIgTAr22G6OzUeZ5dnhvFE?=
 =?us-ascii?Q?YIW4bcVxbMbsKu6uTZVE6ouD8GOoJ48sqp1jVvxxA6jbUWi49dUc56I8DQ+S?=
 =?us-ascii?Q?enJWM8chTrTyFhZ01IwnNKHCEonF7UjabBa0Jnk300n6SOOCT4uzKqeTui+e?=
 =?us-ascii?Q?oFV0cqlRJtsf+t81AL3WhM5GR1JogdFtw14YEb7VbMw2IEN4sb37TTGzi8AE?=
 =?us-ascii?Q?wPZtj8GnsnX3zsihlNN8n5ZPZlQ/Vq3SXOTik7t1+PSCLYexBxo1jzlsC3W4?=
 =?us-ascii?Q?sf4BbHNlgsWd9+3E+ziZuHD8QJQUKbN6vCKmkkn5HuW1UuPTsHM2QqwuXlOm?=
 =?us-ascii?Q?MzXhfJFTaegA+gO8GUBEKnwxeUKNbsTF8VAqe545Ksy0v8Ed5HVcRA/vHbAK?=
 =?us-ascii?Q?IgM26tAZb+6oyCEA1bJqTZZ02qfvMhy6RHuXbNEIkghZHiHCxHUpV0AFD8DM?=
 =?us-ascii?Q?Q2mloxf0KOQNfdNvM9LCZc+MnBj7qp620GHTjtQrokG63EcNNRAuqaCup3PI?=
 =?us-ascii?Q?K9v95jSA9brbyWwMgURZY9xYyoaeYZgseDUbZrhi/MoMjJH6lLWCXpyJ63p6?=
 =?us-ascii?Q?dJttpr9+o9utJylTahEO/nCsUz3Vv7DErxyElByFebFZJRyjfYA6JKD72zs/?=
 =?us-ascii?Q?dyZH/4C3EBgKRNZJM5J3+L/PU05ialsOmZ/MkrBBK3yjsT/iVHFeFnxHHDrc?=
 =?us-ascii?Q?oveuOzubGrBpeRGPqAF6sfXXRRgVtgkDeObux/d+uhH3lbnw?=
Content-Type: multipart/alternative;
 boundary="_000_SA1PR12MB8600DD7A487308741A4FDA6B9FA72SA1PR12MB8600namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8600.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e775a725-d762-4291-70c5-08defc7548a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 15:36:19.2727 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hFDUAN9v/C0eJOr9hR/b4QR1uP7bUvCTE5ArPaqVnGYCUOtAuQaVhxoZWhsjEcH9pq/uOHGsdpWdCohM6Ni87Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0A63E7557
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

--_000_SA1PR12MB8600DD7A487308741A4FDA6B9FA72SA1PR12MB8600namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General


Ping,



Can I get a review on this change please?



Kind regards,

Vladimir


From: Marioukhine, Vladimir
Sent: Wednesday, August 12, 2026 11:31 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdkfd: fix integer overflow in queue ring buffer size=
 calculation

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
Signed-off-by: Vladimir Marioukhine <Vladimir.Marioukhine@amd.com<mailto:Vl=
adimir.Marioukhine@amd.com>>
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


--_000_SA1PR12MB8600DD7A487308741A4FDA6B9FA72SA1PR12MB8600namp_
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
<!--[if gte mso 9]><xml>
<w:WordDocument>
<w:DontUseAdvancedTypographyReadingMail/>
<w:DontUseJustificationAdvancedTypographyReadingMail/>
<w:DontUseHyphenationAdvancedTypographyReadingMail/>
</w:WordDocument>
</xml><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
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
<p class=3D"MsoPlainText">Ping,<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Can I get a review on this change please?<o:p></o=
:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Kind regards,<o:p></o:p></p>
<p class=3D"MsoPlainText">Vladimir<o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:12.0pt;font-family:&quot=
;Aptos&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;mso-ligatures:none">From:</span></b><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-ligatur=
es:none"> Marioukhine, Vladimir
<br>
<b>Sent:</b> Wednesday, August 12, 2026 11:31 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: fix integer overflow in queue ring buff=
er size calculation<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
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
<p class=3D"MsoNormal">Signed-off-by: Vladimir Marioukhine &lt;<a href=3D"m=
ailto:Vladimir.Marioukhine@amd.com">Vladimir.Marioukhine@amd.com</a>&gt;<o:=
p></o:p></p>
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
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
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

--_000_SA1PR12MB8600DD7A487308741A4FDA6B9FA72SA1PR12MB8600namp_--
