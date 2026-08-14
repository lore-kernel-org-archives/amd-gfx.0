Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EBAC5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 16:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 951A510E17B;
	Fri, 14 Aug 2026 16:29:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l5YgtCj8";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3598410E17B
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 16:29:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7rC+rt9uTFzyU8Zzwm1sLTBsYoCu6+WgxlTg+w+ktsmiaetL0Orxt8Go90NDQQ7MYsCPmFIdZu97pUozNUeGsZBl7p44674U776pMsVG13TWhNIS96/h2fEo9G8jtA0MFR4m/fcFKb3ysM4MyKwuAZgYHXbjwfHyNZMuVTKUqKDiHXa+OmVL8z8tZgn+Pl553vaBOnocaM+7qVFpTYfAtQMVFv7QHAjKIxEnKzoCcXR0TQjHjtFwCGzohZQo/OxuHt2lrfaYrZ5nNEz28l8Ituwceq7N/pRRMBwhifhCsXRB0DU20FczmkIdwKGeebwe+fVcP87ASvmJbZ+vteX2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBQure/oDTHRQtIfbi6+eU3NoFuC3QhYniVZR33FrsE=;
 b=gi9mkTY2n69J/VRcCtzw1zv816ZNkMUKVA1o9t3tUDG0pcn1f8ARueR/rYX5gmYGZoDmpEsMLnhtwTbQX/1xOKfpbnIoWHFIRJgJrv/WlHxXoaXuTwIzS5RMZ4kvXg8ZmTtHUKYZRsB0WVaWT0nY1xP4LmvkX0R+ageMFtlZn5IvuuOOvVHZK5knsLCg9vNCSh91Axgv2pXfvUj3QoynCCWUVrcAqIpGEgeM2iE7U/7AwKEiuPZdn2HjvgnNNbIK2OLMUxObUeRqFwnI/eA75CC/2GmEkQlpUOKUelM9bbSJOeej6YyFbGK3JFfHktjtIvVg4BhG87qf5Ma9USgN0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBQure/oDTHRQtIfbi6+eU3NoFuC3QhYniVZR33FrsE=;
 b=l5YgtCj8vi1HxzfQwHKpEOEIVLzgfKaLC3BIqYrlpAsDOK70LxIctVwAoFlMJ2j1aAKk8deq0mFsTh4D6XWa0x/RjOfoaNb7ojONQ/DZBh3FzBEQYw7xitoKfPbievqVdf0hPzMI2QiDvQKCtEA5q0Ta4g5pKT1H3m3YtwtPdBg=
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by LV8PR12MB9642.namprd12.prod.outlook.com (2603:10b6:408:295::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 16:29:26 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 16:29:26 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Hosur, Priya" <Priya.Hosur@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Liu, Shaoyun"
 <Shaoyun.Liu@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
CC: "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>, "Gopalakrishnan,
 Veerabadhran (Veera)" <Veerabadhran.Gopalakrishnan@amd.com>, "Hosur, Priya"
 <Priya.Hosur@amd.com>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue
 unmap
Thread-Topic: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue
 unmap
Thread-Index: AQHdLAimb22PfBCNZEqhjo73LVXY17adu+i/
Date: Fri, 14 Aug 2026 16:29:26 +0000
Message-ID: <SA0PR12MB7091D3AE34006DC6797EECD197DA2@SA0PR12MB7091.namprd12.prod.outlook.com>
References: <20260814161841.5906-1-Priya.Hosur@amd.com>
 <20260814161841.5906-3-Priya.Hosur@amd.com>
In-Reply-To: <20260814161841.5906-3-Priya.Hosur@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-14T16:28:50.1720513Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR12MB7091:EE_|LV8PR12MB9642:EE_
x-ms-office365-filtering-correlation-id: 135d10ac-bb20-47b9-35e4-08defa2134f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|4143699003|8096899003|56012099006|10067099003|11063799006|18002099003|22082099003|921020|38070700021;
x-microsoft-antispam-message-info: qu4vv32cIksYeldGOFQARLHia/lWShP+iA5drdRvfNtmqdIrLbRfJBsp6qVdoqD6Zi0q3hRG+rJ1wdDdudS3cda3IR/BZw0XluzWeBpQ63UeqpnP8a1wft9fo7CxkOQYyLxsk5z1bBQyurRORV8mpi6l+GjV5vjehdd+Y2S1HDiA66uu+HEbGIQ9MppLn9yNpF6P9R0ddiFH18ZE5BjZHAJrVL5RTrMvcZHuiYVmhL7zoM0kcp9v5UY7kXE/Bri6fOL80RbWlQrbMZ4OqrCbuD8vm5I8ye3DqhUajqzaFms3nt5HjyLbMmDXpm5BJUjsXjtCxJNkpLW7DG061W5/TfnMjZPf16wNzTwY6LROobE7t68xO41KDTcxeqr9IFYsVxhTxW1AA97Y8+vqDJSjoei3ByK1FbUrKWD0pwSD/D+9MYrDT17zR+8OcYxCFUxXtfWAj4zzQ0uvWXtpB5kHQfTrfdubCvu0ZUzNYSqhyYSSq1GHIEzLkSzcn0aotu9voWBG5ume2kaMiSDwLqMxjjTThtVuBfnqMbzdvDM6gfg+rgM8fKiysai0yOOdtFeF1iygnUkI6Wp37voTiNJ68Yi9PwQKM0JBHpaDnYHLZqDqSwhSNoQr1uT1RjEnYbbPTk6uEB/+Qqz8SzpzIrCOxi/w3ULRVsQB5OrynJTN/7ZlF70wuxtGSw+2YfkheWf4Go9vNSyGsvQgeD0hlKg5Mle1N6V90y9LT6YkZJRlKrQsRkeKk7gAfUUdfed+zxvF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(4143699003)(8096899003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(921020)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?naGI06fcehdp+sQN72DqZSXdLD8XiH0m0m6P3Qp1oDKuJm0rfYNdQ3kHtmtR?=
 =?us-ascii?Q?cPpzUy2iirtXYdBE8apdf9mHMbg3nT61/AImG4KUvrjogrVwTn7WBufvBq6j?=
 =?us-ascii?Q?hYXhNjC1qRAl6X1aJbOCb9fhtCiVRIfI8oi1DZ19ANNWgfEbyfgkPuTDzbcs?=
 =?us-ascii?Q?jLRBmZEB9ruxSA/K6j3fcBC5DnaLcryo81OBklZ18LFK9jIzjrvfzRNQtzfV?=
 =?us-ascii?Q?YywDzVntdl9Z2e/nvOmY/LVSveKMxFnhNPaRGHLZJ97KtyPeobUuOHPku+lK?=
 =?us-ascii?Q?QQv+BCShHK3lJpjhJe/1VmRhmGjMkn89KHw9D+SehQ0YynsnVhXWKFej9Xjv?=
 =?us-ascii?Q?2iKEHZYc72olPEUSwaRgJMHC454QG2sJpGGMM/Cx/dUoJTSJP1Hs0LXmbUri?=
 =?us-ascii?Q?t6GqSnC7tMlOInVmkvKpzlPKDrh30BSAkG6YlZQVxeMMq3kynDDU55+utlIl?=
 =?us-ascii?Q?0OMbLM2YFmIfyWhfhGfa8TEG4J8BpEMGMB0W3cj0Y/eu8xsxhw3/IYJxJ5ry?=
 =?us-ascii?Q?zRKMjef/l7mPwtZq7xKZZvi+HD+XMCSu45N4m5Zk10KL5Q7Y5netWCkYrxKb?=
 =?us-ascii?Q?1PqnSo1EM1E/UCH0XKuo9vmdrrAiomLVajwR0tMEfX1Gkk3ZpC8FygF0aIhc?=
 =?us-ascii?Q?lQED7cvpWdv2uvJbg9msvY0gRBep0gqpAQ/36bOvJq2LH9OWpPwRQRnD0qg+?=
 =?us-ascii?Q?8eSoSLlCKSx+UA6NwvJyKUKyx0yqWpTcl4k0B00/O0T/859yjARe4WGg67si?=
 =?us-ascii?Q?GA0NIGMpHTc0Yzlb5wuHjsQTYchRlNjRNhVbgJYc6ZMjjmP5B26o3Dmpm+VT?=
 =?us-ascii?Q?e+TghgP30d/BcW+NGrBQWYJxxEg622PX2N1ZFz1gRxy5Hg7JXD8ZQeH0X/w/?=
 =?us-ascii?Q?mYjpJhIvB5VcDLysM/GtFpnNCqR93ffneymkHGBUnL3BlQL27eEk26Ct/q9d?=
 =?us-ascii?Q?P0pKhPDafk6nQl5TDBXRekcGGQndBc6Jd+Z3CmCwhijzkLvdYDdlbf41rAU/?=
 =?us-ascii?Q?WJJn0rlL5PcTlVUm6LfYxT5tR8aHtAg73i7H8+ppdYGJowWaEyhZmBrihvnV?=
 =?us-ascii?Q?pE/NbNKixdYDKthSAXnFh5Ar7q7Xc8jGnMLQ5BEV3VOzpid3HkHRsQ7qhlIC?=
 =?us-ascii?Q?8i0AHzh3MBSFiCtArABMXM/4h/W0vYvgONa0m8vLBAXExEzrHrhvtBdRIfSx?=
 =?us-ascii?Q?yDiR8Y7uE6tMDIlLhS8oUHn5mUeU6RMPjyU9sp4XdDe5r98di4b7H7t7K2tH?=
 =?us-ascii?Q?0svYnHosyBYI8tujn7LccFj1VrEqXHkbc3Nr0K6HRhYXdqKyVA7FvzNnqqzC?=
 =?us-ascii?Q?yxxYmbQGzDrOJIPeDFbIygpxWmpHMgmpqd/+T2tZjDcFhxbPCTfWDvrCUvgg?=
 =?us-ascii?Q?lkxL0FLR5eqS3eEe7vBBl2sQij8bwbULX7oBr4qvHj2DiFKyk7qGm9RGzOTC?=
 =?us-ascii?Q?b6s/YaGJq9R3jhDal7Zo7UOSDFDVWI/K3bl/LxWK82TUatzZxsasYAQXxHoM?=
 =?us-ascii?Q?ytpyhkuFPGMGR42lHn9Hu5otOWxdblk2pGWecZxqZAew6uqaGbHLnB7H8c+C?=
 =?us-ascii?Q?klofGB2TXKEavQwlILvH2rlZaYpUcOxJxfKGDNdWG6vzkf//VguVwfkEu4lE?=
 =?us-ascii?Q?A/7wgHCmpOidGvsaQr018tzc+QHMrtR/Mwy/xgf8nTC7NtkEVFOo+kEu4DmZ?=
 =?us-ascii?Q?VOTr5v8psBf/AOb8NwHwuPW7gm2uPK+2eqN+IsM0vCBGJY5iTjN1/qlUnAVA?=
 =?us-ascii?Q?oWRdg/Y7Pw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SA0PR12MB7091D3AE34006DC6797EECD197DA2SA0PR12MB7091namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 135d10ac-bb20-47b9-35e4-08defa2134f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 16:29:26.2306 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KS47Pnxg//ZKt8lolAnkCpZW/+sTmHdzJMPkq19o6XOqcVkwEtMHwbQlEiNA2e1L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9642
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

--_000_SA0PR12MB7091D3AE34006DC6797EECD197DA2SA0PR12MB7091namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Hi,

Shouldn't this be a FW fix?

Thanks,
Lijo
________________________________
From: Priya Hosur <Priya.Hosur@amd.com>
Sent: Friday, 14 August 2026 21:48:40
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com=
>; Kuehling, Felix <Felix.Kuehling@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.=
com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Limonciello, Mario <Mario.Limonciel=
lo@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Gopalakrishnan, Veera=
badhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Hosur, Priya <Priya.=
Hosur@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue unma=
p

Similar to the KFD fix, MES does not perform heavy-weight TLB
invalidation after unmapping user queues. Add
amdgpu_gmc_flush_gpu_tlb_pasid() after MES unmap succeeds in
amdgpu_userq_unmap_helper() to ensure in-flight memory accesses
complete before memory is freed or migrated.

Change-Id: I94fe2c84547723b6b73816ce8d727a54bd773a6a
Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.c
index 6d3ed55e9ab4..9fcf15d69b7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -375,6 +375,12 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_use=
rmode_queue *queue)
                 } else {
                         trace_amdgpu_userq_state_changed(queue, AMDGPU_USE=
RQ_STATE_UNMAPPED);
                         queue->state =3D AMDGPU_USERQ_STATE_UNMAPPED;
+                       /*
+                        * Heavy-weight TLB flush after MES unmaps queue to=
 ensure
+                        * in-flight memory accesses complete before memory=
 is freed/migrated.
+                        * MES does not do this automatically unlike HWS.
+                        */
+                       amdgpu_gmc_flush_gpu_tlb_pasid(adev, queue->vm->pas=
id, 2, true, 0);
                 }
         }

--
2.43.0


--_000_SA0PR12MB7091D3AE34006DC6797EECD197DA2SA0PR12MB7091namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
Hi,</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
<br>
</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
Shouldn't this be a FW fix?</div>
<div id=3D"ms-outlook-mobile-body-separator-line" data-applydefaultfontstyl=
es=3D"true" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system=
, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(33, 33, 33);" =
id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
Thanks,</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
Lijo</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Priya Hosur &lt;Priya=
.Hosur@amd.com&gt;<br>
<b>Sent:</b> Friday, 14 August 2026 21:48:40<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Khatri, Sunil &l=
t;Sunil.Khatri@amd.com&gt;; Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;;=
 Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.c=
om&gt;;
 Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; Koenig, Christian &l=
t;Christian.Koenig@amd.com&gt;<br>
<b>Cc:</b> Vishwakarma, Pratik &lt;Pratik.Vishwakarma@amd.com&gt;; Gopalakr=
ishnan, Veerabadhran (Veera) &lt;Veerabadhran.Gopalakrishnan@amd.com&gt;; H=
osur, Priya &lt;Priya.Hosur@amd.com&gt;<br>
<b>Subject:</b> [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user que=
ue unmap</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Similar to the KFD fix, MES does not perform heavy=
-weight TLB<br>
invalidation after unmapping user queues. Add<br>
amdgpu_gmc_flush_gpu_tlb_pasid() after MES unmap succeeds in<br>
amdgpu_userq_unmap_helper() to ensure in-flight memory accesses<br>
complete before memory is freed or migrated.<br>
<br>
Change-Id: I94fe2c84547723b6b73816ce8d727a54bd773a6a<br>
Signed-off-by: Priya Hosur &lt;Priya.Hosur@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++++<br>
&nbsp;1 file changed, 6 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.c<br>
index 6d3ed55e9ab4..9fcf15d69b7b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c<br>
@@ -375,6 +375,12 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_use=
rmode_queue *queue)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace=
_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_UNMAPPED);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue=
-&gt;state =3D AMDGPU_USERQ_STATE_UNMAPPED;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Heavy-we=
ight TLB flush after MES unmaps queue to ensure<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * in-fligh=
t memory accesses complete before memory is freed/migrated.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * MES does=
 not do this automatically unlike HWS.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_flush=
_gpu_tlb_pasid(adev, queue-&gt;vm-&gt;pasid, 2, true, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SA0PR12MB7091D3AE34006DC6797EECD197DA2SA0PR12MB7091namp_--
