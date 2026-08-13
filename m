Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422E3C5CFCF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 16:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D32210F432;
	Thu, 13 Aug 2026 16:58:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RWTWsCFr";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013053.outbound.protection.outlook.com
 [40.93.201.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C97D10F432
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 16:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQKeqGWi/4P4Rwzas1SqDmsFvq6Yp3NuVT5Zbkg5T0532FvLdILQ8cX7v1vV1X1rjzJ6Wbzw30xPi6DtzEkMCfXBAi99y9JG/F/4vg9T82UPnwSSKT1K5qjTPYTTfb322ECI5WYcWLtePgRfOA7MF06tbJDuMDwLnJ7Sx+um/SzidkeWlvJNhIXw2/JJINoXPbu5zkKswq98H6boBwEqsmoB46KPvY249s3MKszx7qv2EOtm5uGSW/Y9tyqa52Hq3iq+EbDWIO10qmFBzxOmuxiNQHYBgY+Y+eUsNHl7lh1mzEAZ76FQ0irPis5b700gVz8hWoODLqhW5GwnwwoO9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzlzmOK7WXvVKMMZ0QlYoH7FoJ7wJJls5CcOqSH0IMg=;
 b=Kt2X7tAHZgl0Z0wlksaft6OvLidQ7OqOCDY2zH13gRUBomxpkhcipAfzEHbcqkoNZUt1bZlLxXswq2stBROCWKPSY+GrhyTkHEZw4jA9Fjtai1J/javz2EuxmKKj+ESKVxemYbQddWPmlZMaSOcWsCDCnm913EsS/2QRARDkutc9J1HyInH7+p2XSZGQCxijbaxc/xVqm6TO5YNSMykLrayvqhVmJLoU9Mb0N8cOAoivHS1nLgtu4oKJCBzlZoKbYuHShDOLFkxUZ/AwjMIIeXzX1p0Xco7DDQAWRZv8lh4B4nmpVWzKTMcbcg3BMo/x1W10BlOSIw5RVb2tiCoXeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzlzmOK7WXvVKMMZ0QlYoH7FoJ7wJJls5CcOqSH0IMg=;
 b=RWTWsCFrbueH5XZ2YxJsga/1hT3D168lmyj6qxwRGuorB6FNGfzmv/eYog4KbEmWWvkcbjkYNHhCPrRhiB1bsGXd4NvXQKfQkRGsaghiNPF2thUEtfoQs1V42aH17R2ioYxgdYVzd+jO/wGfbpWrINyxHFn4c7jgfwnwpSnl9M4=
Received: from SA1PR12MB8600.namprd12.prod.outlook.com (2603:10b6:806:257::19)
 by PH0PR12MB8775.namprd12.prod.outlook.com (2603:10b6:510:28e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 16:58:19 +0000
Received: from SA1PR12MB8600.namprd12.prod.outlook.com
 ([fe80::96bd:d94:4dac:b1d0]) by SA1PR12MB8600.namprd12.prod.outlook.com
 ([fe80::96bd:d94:4dac:b1d0%5]) with mapi id 15.21.0315.008; Thu, 13 Aug 2026
 16:58:19 +0000
From: "Marioukhine, Vladimir" <Vladimir.Marioukhine@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: guard against NULL restore_mqd in CRIU queue
 restore
Thread-Topic: [PATCH 1/2] drm/amdkfd: guard against NULL restore_mqd in CRIU
 queue restore
Thread-Index: Ad0rRMKkZMtjCdRRQSmLmOSzrfpEcw==
Date: Thu, 13 Aug 2026 16:58:18 +0000
Message-ID: <SA1PR12MB8600A6C7595378BECA3E4A999FDB2@SA1PR12MB8600.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-13T16:56:50.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8600:EE_|PH0PR12MB8775:EE_
x-ms-office365-filtering-correlation-id: 34b6344c-b97a-44d7-9ff2-08def95c135d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|38070700021|10067099003|6133799003|56012099006|11063799006|18002099003|8096899003;
x-microsoft-antispam-message-info: j23qDcoVQ21k+WodsCnMVXdjelfYtwCRr4QGbkfQHUGhswGVA9gTxCWDuAQieoQT9fbp78I2doQpKvXOIPndnsRtBhy9eJ7QRaDMTgzt0t8FcA0sRSJ2rLS5SmsZUC8WRdonGMcTtI2Tz4aHlrxxQm5DFZGei829t1q6iU+wCwlZDFdLtfRgfL7YsmpJiikrlgBGOPCn/k3Tp+ASTsseo/FWkSxabqlMkjqFESzO1dBH8zGQblUj9bQPHQADUQC5guBD7/OBMcgyrYICiUXD0qAeIGdFRGazkZF5yoqVaw7ygvE07OdfaDNuVKW1UXVqb84iHbybg31fR9fUCUviLBDOw09EQIpuztEItXgFqBVL2WsA9TQYQ71vgxqppAmmS9bMfvok2bz/cBBr1PPynlpi0g+uzP6vjlmfd1TXp/PKW2giaiAjXlDSEdRwAwNR6SIec54ZneXCzn+BCQqr+bsNmYY102/RlflxPI6j2KMo675ccl9GsBUhn3gQr5KVbxktqNHRqD+G/LN0rqyUqQwyLjPttSl03pFd0d0zdPh3OftIlVOySnJldhpOkWqIJYhg3Lg1f2dbl8T92XbdGH7zslbc8kU8qdTi0cfg0QTAme4exVMbUSesXdhEZ4CEDac6ny1bm+1gkukpjpbTSE1O9WxMHtuDBfPy2M2+q/NIuSUitQyl4iz2U81YKzUgU7NrOMzSDeyNS7W06s5flMGlf+A83Nvz4o1/Z7NlcF4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8600.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(10067099003)(6133799003)(56012099006)(11063799006)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YeYFBms8WFFJUPEeUqu1nl1JM1WhVhsARcoYDxMyyBeGAaW6gShXu5rFUa6r?=
 =?us-ascii?Q?D/+twlIkZW+41vNUaZcmDp5tvVd3qAigw0JfmnDxSYmvfqzayVz9NRThLTnr?=
 =?us-ascii?Q?j9zV5e5bKDl5mkY08gI2Pur6XY7bv3FnKus4AXFL1sX1ayIR5AZmMbEUiNC/?=
 =?us-ascii?Q?pva2hLibtJiC1paj9kPT3hDEHOVjaf8BPchfbK/Zh+PmmlWXFIWwQSJ9yq24?=
 =?us-ascii?Q?UX0y4QOlfE/WqC1ZP/YSjc9cEGE0i7AaMYMcKfFQrhd1t1rKVlAIHfy7Pdl1?=
 =?us-ascii?Q?o0bwcjOpeq+BaZgjqGIfe7FGuop0Wp7UOSWEkxWWcju1Tex/Hgex3xcFmD08?=
 =?us-ascii?Q?dZMnvUgoOCw34uMZS5LeUj15nxaopEm03/4v+c1MdzI0vrFCvyhheFTojcE/?=
 =?us-ascii?Q?/S7ldCq0kqHwWiRJJpP8slW9CNuS+Y42OluQngwc8F5yGFQiWeCeVIDqK4+5?=
 =?us-ascii?Q?h4bvPr2GpRcLuln1HX0eWY174urMdkbsj5hTANAsLZ5oP3QZJfxOUwbvWvqj?=
 =?us-ascii?Q?6xwZSSyYnC58/K9ynNNEKzcl45yqAKlLMN3KBXqA1ZfNHhXkOssrRZr1pe2t?=
 =?us-ascii?Q?yAjwU6YkDpLqRyIjOMSpMNeiZc204ybZK4oWasswzoosyhfJUh0YjLIRQMRD?=
 =?us-ascii?Q?PldK6LrLVnv9V8q5q18aMYLlaQWAz9rgQmBgyPzsZcMQg8oGothknnawq3Gr?=
 =?us-ascii?Q?7R5yPBQpoFLvbRnnwl52yNaZxuUmVOOqS+S0fz458V4mRkKheiKSZuGt1YUW?=
 =?us-ascii?Q?w40LaABGALUFZIpEZ8l6yYJyQBNTA+8VgnBEEGx1lBpBLQt31hI2rp+7z6h1?=
 =?us-ascii?Q?b647eB/uLX7CSp4A/IpZ+K+KgORLLgW7G3YI2HEoNVEOB/PSDm2C1HZdbcVR?=
 =?us-ascii?Q?DxUz6JWICuOfOdglrwb0+MFtGiWKJzqjmxhZOh3+Izu6noV3Xotp5XyacccX?=
 =?us-ascii?Q?Y5cMi4nWuTJ0kbppyZg9uOo6x+AlSMQavPar/L7JuF02sclWSt2X+hEtfAHn?=
 =?us-ascii?Q?La/B2Rp+we1mRATJttCClZf/rLa25dXjNSdi1hazx3rDt7dutizyZT2OT6b2?=
 =?us-ascii?Q?8Q2FlFOoCv13WRAkvrn23HGu5MtQMpaSgWY0Dybtq5AI7f9tFZK8yZrbRnZV?=
 =?us-ascii?Q?EhHlpfpwuAEEWhy89oSFf21t10NwL3MvI4UFbbmA/9eoTjzPeqt/vTy1Wjq2?=
 =?us-ascii?Q?dvyI+2Ia1dp++3Amtm7O3IWXOGYnJ2OHmUhbuN+332EewPSsSalewjv5TE9Q?=
 =?us-ascii?Q?sYef6o/YPHrWwVprLXGyYdbc1+4ocDoYfQI+qoIAM4nmg/gKQZZeo+DDluwD?=
 =?us-ascii?Q?PL9o6O1Y8LQYCKsZhm42mYNTVBDV5niDPJPBqlbNC8QOwmVxuySbOCsfi+oP?=
 =?us-ascii?Q?h6kZ75T/xfOZJA/aEIC/DiidQ9hmuTCQiI+n7nyxHFiDKa9bytlqc1mixw1M?=
 =?us-ascii?Q?hlDQqBFYKYf32a5Qy9M+vcbblz3XzkuResH3LzhFkamDT+MThwVhN+M+F+do?=
 =?us-ascii?Q?lZGX9DHofxbhYOcYgo7UPiNxs2lUvjB+9YsLPm4oHCj9msIOp0X6zknWfs3N?=
 =?us-ascii?Q?4INIYD+SaKqe19siEY2FCe9dKL94YQr/ItJbfDCyilMaa5kJ6CV8wPvR0XLk?=
 =?us-ascii?Q?lka0IdNnr25w8bkxRAdJwoxPYqYzts0HFHO12G/9tn6ECpZG8N4LLxnjWk2z?=
 =?us-ascii?Q?O+gynNCNIXWM5MUoMmbG+0UcDEP81QwKL1wttmJ7ystOMoTw?=
Content-Type: multipart/alternative;
 boundary="_000_SA1PR12MB8600A6C7595378BECA3E4A999FDB2SA1PR12MB8600namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8600.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b6344c-b97a-44d7-9ff2-08def95c135d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 16:58:19.0161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jj32rcrxXrTRpi15/CBPZ0C8d3Qvm1LACX4U632CIBflCj7hXhgwL2qHqS+EnVSgH5wwKpPnXUqTak/Rm+xSgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8775
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

--_000_SA1PR12MB8600A6C7595378BECA3E4A999FDB2SA1PR12MB8600namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Both create_queue_cpsch() and create_queue_nocpsch() unconditionally
call mqd_mgr->restore_mqd() when a CRIU restore is in progress
(qd !=3D NULL), with no NULL guard. On any system where restore_mqd is
not implemented, a user holding CAP_CHECKPOINT_RESTORE can trigger a
kernel NULL pointer dereference and panic the machine by issuing
KFD_IOC_CRIU_OP_RESTORE with a crafted queue restore object.

Add a NULL guard for restore_mqd right after mqd_mgr is resolved,
before any resource allocations, returning -EOPNOTSUPP if the callback
is not implemented. This avoids complex error unwinding and is
consistent with the existing checkpoint_mqd guard.

Fixes: 48f0bdf4e38e ("drm/amdkfd: Added MQD manager files for GFX12.")
Fixes: 01bbc4a4b947 ("drm/amdkfd: Add MQD manager for GFX 12.1.0")
Cc: stable@vger.kernel.org
Signed-off-by: Vladimir Marioukhine <Vladimir.Marioukhine@amd.com>
---
drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 10 ++++++++++
1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index ea9d87450eae..25b738200e7e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -769,6 +769,11 @@ static int create_queue_nocpsch(struct device_queue_ma=
nager *dqm,
               mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(
                                            q->properties.type)];
+            if (qd && !mqd_mgr->restore_mqd) {
+                           pr_debug("restore_mqd not implemented for this =
GPU\n");
+                           retval =3D -EOPNOTSUPP;
+                           goto deallocate_vmid;
+            }
              if (q->properties.type =3D=3D KFD_QUEUE_TYPE_COMPUTE) {
                             retval =3D allocate_hqd(dqm, q);
                             if (retval)
@@ -2134,6 +2139,11 @@ static int create_queue_cpsch(struct device_queue_ma=
nager *dqm, struct queue *q,
               mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(
                                            q->properties.type)];
+            if (qd && !mqd_mgr->restore_mqd) {
+                           pr_debug("restore_mqd not implemented for this =
GPU\n");
+                           retval =3D -EOPNOTSUPP;
+                           goto out_deallocate_sdma_queue;
+            }
               if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA ||
                             q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_=
XGMI)


--_000_SA1PR12MB8600A6C7595378BECA3E4A999FDB2SA1PR12MB8600namp_
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
<p class=3D"MsoNormal">Both create_queue_cpsch() and create_queue_nocpsch()=
 unconditionally<o:p></o:p></p>
<p class=3D"MsoNormal">call mqd_mgr-&gt;restore_mqd() when a CRIU restore i=
s in progress<o:p></o:p></p>
<p class=3D"MsoNormal">(qd !=3D NULL), with no NULL guard. On any system wh=
ere restore_mqd is<o:p></o:p></p>
<p class=3D"MsoNormal">not implemented, a user holding CAP_CHECKPOINT_RESTO=
RE can trigger a<o:p></o:p></p>
<p class=3D"MsoNormal">kernel NULL pointer dereference and panic the machin=
e by issuing<o:p></o:p></p>
<p class=3D"MsoNormal">KFD_IOC_CRIU_OP_RESTORE with a crafted queue restore=
 object.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Add a NULL guard for restore_mqd right after mqd_mgr=
 is resolved,<o:p></o:p></p>
<p class=3D"MsoNormal">before any resource allocations, returning -EOPNOTSU=
PP if the callback<o:p></o:p></p>
<p class=3D"MsoNormal">is not implemented. This avoids complex error unwind=
ing and is<o:p></o:p></p>
<p class=3D"MsoNormal">consistent with the existing checkpoint_mqd guard.<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Fixes: 48f0bdf4e38e (&quot;drm/amdkfd: Added MQD man=
ager files for GFX12.&quot;)<o:p></o:p></p>
<p class=3D"MsoNormal">Fixes: 01bbc4a4b947 (&quot;drm/amdkfd: Add MQD manag=
er for GFX 12.1.0&quot;)<o:p></o:p></p>
<p class=3D"MsoNormal">Cc: stable@vger.kernel.org<o:p></o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Vladimir Marioukhine &lt;Vladimir.Mar=
ioukhine@amd.com&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.=
c | 10 ++++++++++<o:p></o:p></p>
<p class=3D"MsoNormal">1 file changed, 10 insertions(+)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_q=
ueue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<o:p>=
</o:p></p>
<p class=3D"MsoNormal">index ea9d87450eae..25b738200e7e 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_ma=
nager.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_ma=
nager.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -769,6 +769,11 @@ static int create_queue_nocpsch=
(struct device_queue_manager *dqm,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =3D dqm-&gt;mqd_mgrs[get_mqd_type_=
from_queue_type(<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.t=
ype)];<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (qd &amp;&amp; !mqd_mgr-&gt;restore_mqd) {<o:p></o:p></p=
>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;restore_mqd not implemented f=
or this GPU\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D -EOPNOTSUPP;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto deallocate_vmid;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type =3D=3D KFD_QUEUE_TYPE_=
COMPUTE) {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D allocate_hqd(dqm, q);<=
o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -2134,6 +2139,11 @@ static int create_queue_cpsch=
(struct device_queue_manager *dqm, struct queue *q,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =3D dqm-&gt;mqd_mgrs[get_mqd_type_=
from_queue_type(<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.t=
ype)];<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (qd &amp;&amp; !mqd_mgr-&gt;restore_mqd) {<o:p></o:p></p=
>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;restore_mqd not implemented f=
or this GPU\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D -EOPNOTSUPP;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_deallocate_sdma_queue;<o:p></o:p></=
p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type =3D=3D KFD_QUEUE=
_TYPE_SDMA ||<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.type =3D=3D KFD_=
QUEUE_TYPE_SDMA_XGMI)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_SA1PR12MB8600A6C7595378BECA3E4A999FDB2SA1PR12MB8600namp_--
