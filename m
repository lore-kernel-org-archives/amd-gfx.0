Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75532606A325
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 05:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hWIX3uey
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AB9E10FEC9;
	Fri, 20 Nov 2026 05:15:35 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010015.outbound.protection.outlook.com
 [40.93.198.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC5E810FEC9
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 05:15:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQGMJrdBHMVlDdCVi4R5riWuBNdctMtLi0hl8pm5RnlUKIWotQn/aUgb/M+hM33VMHj6LgLAf7ZbpL+tKNSoLW4viKiCSskJhDxg66zoINSObpNORZPGBayhg1iHZml1fUK+XG/XyJOPtVPw0uLQpOZHfVSxEpY/quo2kkK8nhSdc8XM9ycVR3r5nk+2VpFgWH33FFlfx7LRt0zM+LarAJIntQUiC5shFY+TSKcHhej9TcmRGh//Hdko0G4KXp9yNlXQTS499vjaXWXHEuZBBv89U0nVsbvz1+Y/kzcYXycumqnH7/j+H+GZQAPQuWb2gKSnoHa7QDpPY/gMHjwuHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dumG7RXTxCSwFtxEKwyo/mbYePdK9MK+74bXMGM+lZ0=;
 b=b1jOLQ1ovYgi9VGVv/WMV47/NHBS8rGva+0/i2hBHr1cjXYebYUDzroxY6RJ1aZw5sBOyuH+zywOZQb/Af8hKdB0YmicF8m7/RrWThkh5QtIZhzYeOsfDtd2Zad4Oy5D3NyhauyyOP523/ZhOMt/ZhXsF2MJ3w1nqJJ7QqsmjGR9sVQP5G3+xCZvbknto1o4RM3EbE2YCsEFs6+B6nbk9rlijpKKn7L+KnCba8gcnBhtfvULmXkahy5/y1a00IeYpYLyamLEDRwlmw/22O4y3vehD1zioHZSnTS5395Uf+5s8VI3MhHCR89cGaunFfcyuw0HKEbNFNRlS7BRNFXPCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dumG7RXTxCSwFtxEKwyo/mbYePdK9MK+74bXMGM+lZ0=;
 b=hWIX3ueyCvx/AS+ZTibwBxJHYcwgHj82ogn30nw+JUWuojifAN8N9ap9GQyReR8OCKgZleIy6yy8JXtA6v68Vbgn05CJbmvMl8XXTQiWgewLQvvVJ5+Td6mE7iTN/smbYPhkrm7m3jf34nQJmw/Ik5jUs07agWzB1/h00TmB6yA=
Received: from IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17)
 by PH7PR12MB6785.namprd12.prod.outlook.com (2603:10b6:510:1ab::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 05:15:25 +0000
Received: from IA1PR12MB7493.namprd12.prod.outlook.com
 ([fe80::8fb3:5909:b4c3:162e]) by IA1PR12MB7493.namprd12.prod.outlook.com
 ([fe80::8fb3:5909:b4c3:162e%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 05:15:25 +0000
From: "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 09/11] drm/amdgpu: add UAPI to create user queue gangs
Thread-Topic: [PATCH 09/11] drm/amdgpu: add UAPI to create user queue gangs
Thread-Index: AQHdd61ychUCuX6+qUeAyPBZ1bvYNrc2a7em
Date: Fri, 20 Nov 2026 05:15:25 +0000
Message-ID: <IA1PR12MB7493735875C5F18F03D1A87BFF782@IA1PR12MB7493.namprd12.prod.outlook.com>
References: <20261118223712.2518580-1-alexander.deucher@amd.com>
 <20261118223712.2518580-9-alexander.deucher@amd.com>
In-Reply-To: <20261118223712.2518580-9-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-20T05:15:24.929Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB7493:EE_|PH7PR12MB6785:EE_
x-ms-office365-filtering-correlation-id: 7f4a8c3b-2181-4bea-16b8-08df46c548fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261102123227099003|261026140227099003|11063799006|261028144727099003|261022075727099003|261021121427099003|261022105027099003|56012099006|38070700021|4143699003|10067099003|18002099003|261009223027099003|22082099003|8096899003|3023799007;
x-microsoft-antispam-message-info: r1bPyo7tiZd4dOt0fOKH0hirO0nlPmTlKzsEcq1SnXSZEu564dcdZhutdzAu3kOUbjPTDDyOGyXz2fiYlBlw8rqebAEfFAJapa6DeEhOfZ6s2YdeHy+nsC8PxbznS9rO6OxzteoZFDAzqGyhoxOYblMwS4CTStGWLHm9HdZ1vTxZxKl+7nTzJv+QFSamHBOF4zfqlBcqR3a7RmDLHFyK+JTarmX4VJUgOscDsd4xd+V+LmJ2jgwgK4HXsvecLex6xKNECe5ilwxOKbnOw5OXQg+XL0EFWX5zA/cTy0knm1jqGl8wA8f9DNzZpGYoO6oCjCHaxPfQRXIpYSVmJJ5qfFYMTLf14owwygX3QtOu1R3jR+jP1VojXO4jmq6Ie9XtSOjEvsENLs5mcN+LIayRi2gasDIgHMQABV5ADXiFVPiCkNnqHrKCJHXBPBsouqB8kTbwBfnXfip72Xr31m/z3kT0mxRnXQcLQIvCPwTtE9mnBOqcAPuq1KRUg9/SCyuQQ/iDK241MV9Npol/oRK1b6ljG3uIBy38UIC2EDCY1z4tMopkr0fi4gRVCG6XzJFjpEnT/aMMxRHwIgtyLnJpstvSypycUJurkZuLaCKoXaf2frY+urd+eXRu8k/C/oCm3uSfo6MMB2lvg/Egnqu6jgT78FcCrg+or5PE++VsFJMi/7IhWujqH9KlMoXxkNV6MwFuThhhdZ0ffAv+5vYcup3ghH11OROvX5j7JEMGpYY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB7493.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261102123227099003)(261026140227099003)(11063799006)(261028144727099003)(261022075727099003)(261021121427099003)(261022105027099003)(56012099006)(38070700021)(4143699003)(10067099003)(18002099003)(261009223027099003)(22082099003)(8096899003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+LaCQsFn66WuRFtGZMHzJ/siVNBlvZzLilVWwOFIRjcV5S3O3Had8G0eFx?=
 =?iso-8859-1?Q?12bZsZKNrjnHN2GCfU6ICfQMrMaMt2+S1vhpEfBOsWs4Xk+6nQ+LtjoC46?=
 =?iso-8859-1?Q?h1+Q1/x9Ylu+eSujaz2NOlZ5L+ZqoQKMUt3gmsYuIdXHnXRjJzAy52xCVq?=
 =?iso-8859-1?Q?S4ZcR9ggZg8x4Nmy2A//CHvey4ljdvixm23uHqtP/9WKJQ0J0Yjx69vX0g?=
 =?iso-8859-1?Q?TC3/DtF6ejtRGNuMHlPnoo05CNOizddEOPBp765txq4nkjpKgbSS/9qA2h?=
 =?iso-8859-1?Q?3wcqGKY9wvecqDSDFGkrF0TuWySRi5mR1p28KbgQZxQlBlKNTOshiDz3d3?=
 =?iso-8859-1?Q?pIsaHwnJxfe0rqlbIsbvqVRR+9eyieK0c1cnf2/gE96tZFYqWUPbVpNFvp?=
 =?iso-8859-1?Q?G6JbuP4Kc7qfPUCPA9M5JY2OOSlmKv1B8l45YcwW5Hr6hgzdbskRTYZoaO?=
 =?iso-8859-1?Q?ShkPh4rp2MojcWj9SXYseJ8coXLvxrS1yMxzfn8om0FnuoorYHzbYs+IUn?=
 =?iso-8859-1?Q?fvlQtJ8wP6e1cG/tAD9Mez9Cp07GuZ3phIJz2uXr4//xHK42BzvRhZvR4d?=
 =?iso-8859-1?Q?S5RxOy+P4nw74AU26HILjG1tE0q/6ILvRPGvo/PNRe2XLMl+ogJb2PI2Rs?=
 =?iso-8859-1?Q?kdqvOmkqHb6laGA/pL08/YxG7My4/yZIUC582v3RkGxmwfLXyQf32/JRtq?=
 =?iso-8859-1?Q?KZFx5EwsK782dZU6XFD6K6b4plKW0AW6gwGYSBqK2QzABlGj+XAYQXTswG?=
 =?iso-8859-1?Q?TM1Z8FRzft/KS7ki3w/vB2NWt4dfmadNUqLid3jri3dDZihjiUOF23pUH9?=
 =?iso-8859-1?Q?SUfSU9m1BCYRCVhBAYhGTp0emA0OLbmJ9y86ygOdnxQmDQ8Npshk0cmhkN?=
 =?iso-8859-1?Q?klXIqxcvH0FLtc9zI6N1gwQ39w+jEnFAHUgCDOpxyIOj00RlyO93TaIoZg?=
 =?iso-8859-1?Q?+VXyn6hzKJpiXLtlYR6d/umC8BVIgzc6a7+Ivt33oM2zUxQR0EAqdFlx+s?=
 =?iso-8859-1?Q?42U3GMqNBTL0UGv69qdZ/aWjvrPEdXXOHHNZvNx12BwRrelBj6dHtG12p3?=
 =?iso-8859-1?Q?VOfW3oEMJrpCwc3tKAwq7QA3TSCIJrSx8fawJFltpJ12whSvbMuG4Wo6DD?=
 =?iso-8859-1?Q?KmHZsgLCn55W4tTn0EbEBU5IpyxP6Be+J/eZj38wjnNhd3KvahQwt7yxVc?=
 =?iso-8859-1?Q?8dcARcnGR3drbhY1+hSEY4nwxLoeon3K9L3bEldufIFw8++XGa89ekF/2S?=
 =?iso-8859-1?Q?dLnaM/eqMxGcFaxMPAW1WE8Sli3ZES3wERcsGcmUWkAyjmA78+PsldwWj3?=
 =?iso-8859-1?Q?lIhVlqQTiXXtLTOAw0am2GiVlxB+C9vGbalPNb7NV8esNNZxfQyjRfGshP?=
 =?iso-8859-1?Q?FY5WiRhLEfhM2zP0Wiwrby/fvliPjg7arJMrFTs36oQsSt3JtQzNrO5x5W?=
 =?iso-8859-1?Q?or3odfCsSKuZO/pfaSj6o9MR2TaFA7F4ryzMBpPpen3YRKr1A5ZB0rOZwR?=
 =?iso-8859-1?Q?BMqUhBfGSAqk0Mz6LFmcDwrTR4RZ8N1DFLN3X5OxnvBgE1/MtvsRetpMJe?=
 =?iso-8859-1?Q?u4MVazFYaDcPa6Z05xdymfun2HlKGD0n8707N1/RvfyB1ZeF8sWdJxOD71?=
 =?iso-8859-1?Q?Ve7SkOB8KPUCw0AulooozuKnc/OR+WhNIwOgoZmjjX/VHe3hCPyuf272yq?=
 =?iso-8859-1?Q?Kc4Kgw3MzYF61AZ6KLNenwNvafolHLFrPBKuo3GKRQfJh2K0L/S0/+sh7z?=
 =?iso-8859-1?Q?LXFmCXAbdv+tX2PqOaUkIdbOmMfji8mlqACJk9lAZhhhHW?=
Content-Type: multipart/alternative;
 boundary="_000_IA1PR12MB7493735875C5F18F03D1A87BFF782IA1PR12MB7493namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7493.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4a8c3b-2181-4bea-16b8-08df46c548fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 05:15:25.6251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S7mPN1w/jW3/ryvIzXsK5g1brJEB2COfnFRJk4ltNMdskIutu5PTgfeNdXQmy2xLvTubmQL8+R32Jkjc+I53jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6785
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_IA1PR12MB7493735875C5F18F03D1A87BFF782IA1PR12MB7493namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

AMD General

MES firmware names the ganged queues as slave and master. Mesa radv calls i=
t as follower and leader.

Can the primary/secondary naming please be changed into and existing name s=
lave/master.

Thank you,
Yogesh

________________________________
From: Alex Deucher <alexander.deucher@amd.com>
Sent: Thursday, November 19, 2026 4:07 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Mohan Marimuthu, Yogesh=
 <Yogesh.Mohanmarimuthu@amd.com>
Subject: [PATCH 09/11] drm/amdgpu: add UAPI to create user queue gangs

Queues in a gang will schedule together.

Cc: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 86d42a5d683c0..bfb982f1d1757 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -340,6 +340,7 @@ union drm_amdgpu_ctx {
 /* user queue IOCTL operations */
 #define AMDGPU_USERQ_OP_CREATE  1
 #define AMDGPU_USERQ_OP_FREE    2
+#define AMDGPU_USERQ_OP_CREATE_GANG    3

 /* queue priority levels */
 /* low < normal low < normal high < high */
@@ -422,6 +423,15 @@ struct drm_amdgpu_userq_in {
         __u64 mqd_size;
 };

+struct drm_amdgpu_userq_in_create_gang {
+       /** AMDGPU_USERQ_OP_* */
+       __u32   op;
+       __u32   pad;
+       /** Queue ids passed for operation USERQ_OP_CREATE_GANG */
+       __u32   primary_queue_id;
+       __u32   secondary_queue_id;
+};
+
 /* The structure to carry output of userqueue ops */
 struct drm_amdgpu_userq_out {
         /**
@@ -435,6 +445,7 @@ struct drm_amdgpu_userq_out {

 union drm_amdgpu_userq {
         struct drm_amdgpu_userq_in in;
+       struct drm_amdgpu_userq_in_create_gang in_cg;
         struct drm_amdgpu_userq_out out;
 };

--
2.56.1


--_000_IA1PR12MB7493735875C5F18F03D1A87BFF782IA1PR12MB7493namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
MES firmware names the ganged queues as slave and master. Mesa radv calls i=
t as follower and leader.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Can the primary/secondary naming please be changed into and existing name s=
lave/master.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thank you,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Yogesh</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
<b>Sent:</b> Thursday, November 19, 2026 4:07 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Mohan Mari=
muthu, Yogesh &lt;Yogesh.Mohanmarimuthu@amd.com&gt;<br>
<b>Subject:</b> [PATCH 09/11] drm/amdgpu: add UAPI to create user queue gan=
gs </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">Queues in a gang will schedule together.<br=
>
<br>
Cc: Yogesh Mohan Marimuthu &lt;yogesh.mohanmarimuthu@amd.com&gt;<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;include/uapi/drm/amdgpu_drm.h | 11 +++++++++++<br>
&nbsp;1 file changed, 11 insertions(+)<br>
<br>
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h<=
br>
index 86d42a5d683c0..bfb982f1d1757 100644<br>
--- a/include/uapi/drm/amdgpu_drm.h<br>
+++ b/include/uapi/drm/amdgpu_drm.h<br>
@@ -340,6 +340,7 @@ union drm_amdgpu_ctx {<br>
&nbsp;/* user queue IOCTL operations */<br>
&nbsp;#define AMDGPU_USERQ_OP_CREATE&nbsp; 1<br>
&nbsp;#define AMDGPU_USERQ_OP_FREE&nbsp;&nbsp;&nbsp; 2<br>
+#define AMDGPU_USERQ_OP_CREATE_GANG&nbsp;&nbsp;&nbsp; 3<br>
&nbsp;<br>
&nbsp;/* queue priority levels */<br>
&nbsp;/* low &lt; normal low &lt; normal high &lt; high */<br>
@@ -422,6 +423,15 @@ struct drm_amdgpu_userq_in {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u64 mqd_size;<br>
&nbsp;};<br>
&nbsp;<br>
+struct drm_amdgpu_userq_in_create_gang {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /** AMDGPU_USERQ_OP_* */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32&nbsp;&nbsp; op;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32&nbsp;&nbsp; pad;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /** Queue ids passed for operation US=
ERQ_OP_CREATE_GANG */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32&nbsp;&nbsp; primary_queue_id;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32&nbsp;&nbsp; secondary_queue_id;=
<br>
+};<br>
+<br>
&nbsp;/* The structure to carry output of userqueue ops */<br>
&nbsp;struct drm_amdgpu_userq_out {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
@@ -435,6 +445,7 @@ struct drm_amdgpu_userq_out {<br>
&nbsp;<br>
&nbsp;union drm_amdgpu_userq {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_amdgpu_userq_in=
 in;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_amdgpu_userq_in_create_gan=
g in_cg;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_amdgpu_userq_ou=
t out;<br>
&nbsp;};<br>
&nbsp;<br>
--<br>
2.56.1<br>
<br>
</div>
</body>
</html>

--_000_IA1PR12MB7493735875C5F18F03D1A87BFF782IA1PR12MB7493namp_--
