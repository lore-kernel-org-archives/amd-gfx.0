Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4110C2A09B
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 14:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E35010F504;
	Fri,  7 Aug 2026 14:28:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WeIZlsy3";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011012.outbound.protection.outlook.com [52.101.57.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 777F610F504
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 14:28:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5KuzXai7264QGVqFqe9m/OxS48F4npPnvlQCpvHFkd95HIMQKdjfzK/HLg2xs78E7ZGlLi2/37mWMshJnZyBPSObl1da5TshjAEXc1XhSyKEFWqikDKNk0XjI1/OFM20uNVCo+PdZW3tlZC8HbLziiSEmsgvtnFFf3ZqS1kspsHhPT5gvikfolArSaQ5hY1jOvwDeMm1cKLxd7koBt8x2alqIEd5t6ApIU0lqDwCmPiTDw2Vkau6O74v3EmuB96vNHTcumZccF04/G2MpaD6W9Y4qnlpd0thcRGfrpexn0i9W9CE4f3Xi/tGeHJ8QWPUYT78JNzYGE2VYqmDTb+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quwiXGEY8YheAlDu2o610NJSN6aqcSq6cY0dqdVzVs4=;
 b=Fr8hhhy3VEzcXn2b770IHYMz1qV+DpFbXLW3fS/HR6Cghyjf9gFPLLHsK2beCSoVrQ2pQVWwmVopF9ndSvnIZZJ6kXAPC7uKxRaTmfHMlopjVmJglT30ANgg2Ja1Ffwh6xBGA2hPKXctTR+apmrkNYDZmCdS7qhSqbug+ZDZuWJZyLUB7pTtQDX5fP1EmqEJJtrdQN4Dg79ERorXNccyALzLnFKloqyadU8RzgMcp86vK4C6STcKtdrRL1XXIGT57BeUU1FLxMbiXpyEj1fbfRhcKPbFthPPZlJvpcK5Dv2iSGFXQAz4ax4wp0tWOoGus05J2BNc4ISVVriQ5ETu/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quwiXGEY8YheAlDu2o610NJSN6aqcSq6cY0dqdVzVs4=;
 b=WeIZlsy3dlqlDYqxtP8t9aFEwlHqhpSfbdmKH79ENRtuZUFvJGyAwHxLRWWTSVN68kg8uqX/Du8TTTnYXMM/GhhTd6IsvnzWPcOJMNTuHlSRvlVBb9/YcY0Nxb416Psye5w4FWh11PkKv56dO1iPNMOipAqpOAA5yQlxL7XWjbc=
Received: from DM6PR12MB3611.namprd12.prod.outlook.com (2603:10b6:5:3c::17) by
 LV3PR12MB9332.namprd12.prod.outlook.com (2603:10b6:408:20f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 14:28:17 +0000
Received: from DM6PR12MB3611.namprd12.prod.outlook.com
 ([fe80::7861:6815:8b7d:bd0b]) by DM6PR12MB3611.namprd12.prod.outlook.com
 ([fe80::7861:6815:8b7d:bd0b%4]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 14:28:17 +0000
From: "Chen, Michael" <Michael.Chen@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu/mes11: disable MES RS64 process/gang context
 loading
Thread-Topic: [PATCH] drm/amdgpu/mes11: disable MES RS64 process/gang context
 loading
Thread-Index: AQHdJlUPmgrTKPf7cECoh5EFg5UFGraSpR4p
Date: Fri, 7 Aug 2026 14:28:16 +0000
Message-ID: <DM6PR12MB361198AFD6BC49B5A4C0340694D12@DM6PR12MB3611.namprd12.prod.outlook.com>
References: <20260807101051.367233-1-Prike.Liang@amd.com>
In-Reply-To: <20260807101051.367233-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-07T14:28:16.087Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3611:EE_|LV3PR12MB9332:EE_
x-ms-office365-filtering-correlation-id: b7260680-3f04-434e-cf91-08def4901f42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|56012099006|11063799006|10067099003|8096899003|18002099003|22082099003;
x-microsoft-antispam-message-info: OrysgMlXJ5k0w0rzrjHhTjZ5xiIt2oFv9yjergXAm75m8XSmPg6hcQBVKFWSDx7xGjawV2a7iMlmZhwusc51eaYeavC8zMZ6aXVAToxoDfYkR1JlmteSVTaANcG8edUsi0rcNfuJB2C0W1hj1bwqIjg4cWnCYXSLz+G/8pXotN8vZEJJ93FclgHpSjlV9kLOuWUJfBC9DrL7ob3bBGeE9Dl09z6pDio8bdpgJhEDmaXs/My0b+ANOKZ6w+jW4ZVzP7rsmI4uU/pOuYyeqhk2teUKPp5Ohy0b+hIVbCr2x13dN4D78ZgQedKDBmIGnPL+FSpzo1j8UrcKo8m+4DZhM4MK+eauIQyHh4OrSyEAxlc84anNjLfvIfV0BlkSCMkm+FUBqjY57dUEMdwkii9bISdLR3+VoeVmIA6iDKoBYierfwoS1nPjsnjMEnzkzzsdc5kXvLNVpzbGjKB/Hh1yct5kpRROFD4ajJNjIxrEcpWuzAyWbdSGK8sLmKtZ38tz+RSZvuRpbjQpL1aUBfrxOEaRfqfvQ8Z4eVP2qet0ZVp//+VLapgOLV6dSL/SfX2ushF+ZZBZ8crmPT3k2tEfbKtvmO5bTSacx3DzzDw2aD2O4RTtooFV5Lkt/MG/REnweEELoS0UQbfSXWfwI3rk1mp81eqOjS9TKWXYyaxnOFt+6l/DmvTQF7hI5r9/jUaiwEbCzyaAmFNYoISUi5RK0Qfi2avySnuUMCvEr+1w6n4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(56012099006)(11063799006)(10067099003)(8096899003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TvV/MVQB4XVBjV88MKNdPrsPifRHcrf0Z5/CEdm5naBf+XrdN+aYx3od4xjm?=
 =?us-ascii?Q?H0FEdMdWiqVIIeLdYxzve9MjfDYYkHfIXDjNXYHA+d/5T3i+0z33v2Fdkk6t?=
 =?us-ascii?Q?x3HqirPDZgWUx0w8TezJY0ZhikYls6yfmW7JplHEjWRa2Ja2tEFUhbbx7PU9?=
 =?us-ascii?Q?TJw3m2RwxXjcHwHzFbv5qUFoJRd2vNCDNYhfSXFVapHxXMYRR/74hI6LEphr?=
 =?us-ascii?Q?iKLydBFPzvW3FNb+12vIhZF9NlRgPqtcxqdeOCcJGGc6FkxkDIZUwzYw+1Bq?=
 =?us-ascii?Q?WkjJW+F/4TOW0TVIeWixFykb8LUHGdpXIQ8JD1QfeVxG1UzJ63YxRG6aPfnI?=
 =?us-ascii?Q?eWdgxd3p4h1pkR5FEsv/wqFvuG6BqmuBQieukfCgGnP8pAhvUh7H59aAI42/?=
 =?us-ascii?Q?1PPyLAk9PVTY3hi642SI0L0o/AgScQJBXG8+VhQxgtNYl1YAWwVfI8rO3dH5?=
 =?us-ascii?Q?p3WxCgwiwEnzGXWEHbMvEVXDVyJqIaj2KBBvWfqgjEuC3QO9WDg6Ju5ZWN5W?=
 =?us-ascii?Q?u0kbt/NlMcp4r6uXN4i9BZ+/UHyLIHK9d5062fexao8c2Z+jHwcjkV+kEtEv?=
 =?us-ascii?Q?AJ6sRKtaALTJV1EVodkaYiSDfPZnFEAUDenx9shiHyiwZx4B+HYewsQzsHP+?=
 =?us-ascii?Q?VlO5S71cw6ChVOWlC+qf7tVVY8a654ZIf4iAr08LpTFPgoCbO1mmtq95dhX6?=
 =?us-ascii?Q?oxCymuSVYcAEBFcd7hmBIMRd3SKdzxmkZ+RuZ1/vvJ6NeEmS5+vGOLL6uogm?=
 =?us-ascii?Q?9WT1LaIFYb4uSAU8NxlLjHR3yM6i/yOFlWfRs1kNcUhVszHv7pRA2LZLH9F7?=
 =?us-ascii?Q?xMQV3XjILT2YqGFXCIH9kpASXzy+9llb9OfkE0w/mhT87/MnT7cNHqh6irfS?=
 =?us-ascii?Q?Nl2GKElrerUeI+ga+mRFda+tTKnmrridvaCcGqi+fYycup8oUHSdm6oCZKA/?=
 =?us-ascii?Q?jDURqaLfOiQy/H6FMRVINc4c8fEljEbO0O7FoU6MkAsjN8YL7oAJuCZGY/5U?=
 =?us-ascii?Q?mnnFq6PSObGsXMNCCWiyRcaCAAbav6w/2ThjAg4N/m4f+SSl3nCDNApFTDAV?=
 =?us-ascii?Q?4elE6qxDIchTumRcsy9xqG8OGp6dJkQ7uaqHxoRIyC5aJnr+kARUN7piSW9h?=
 =?us-ascii?Q?mTdFjDSD7w0zCR610Ipxeb85hF/kyunGmfD6CgAVP6uUTDcAiWOvqTh76jRy?=
 =?us-ascii?Q?nZLhErCelkA6JHxbwgQfh0EohyrapGaaJs5sGy+lAL2kcBmG8kw36gteR5jP?=
 =?us-ascii?Q?cPtV6bwQH04e9ZSl7evqUed+RaJK5qyB4tD38+81A7SbIXHQitYov49X3gEk?=
 =?us-ascii?Q?RIddvw0x0AKaIxTBXcqFUdnlxTMI3nfyWj9DdSloa5QnhTTAeEOGkrMYHWu1?=
 =?us-ascii?Q?68WmRyCRew96wJZBPIeLuFIr89iGAzcGms3880J+iO7rd+Wth2Z+tsbJsmcr?=
 =?us-ascii?Q?gxgNnyp26C3mY7UXTypnyJTJlYl8HV5iay9LapNtOhyEFiGudx+2izqMonEO?=
 =?us-ascii?Q?Z7s8hq0mAJDPApA8yu36v11NZRvjAbtn6wQIm2aFG8ZPjR9zElstrhpkBZaC?=
 =?us-ascii?Q?rC26O+EuzRuCXgcNBMGgJDAlappGVGhIOdN2CnxqhK0FBbIdUV0RlOuuxelr?=
 =?us-ascii?Q?YzpBIoUvFsziZW3289dpDarqRQS78Wb2G8hGmKNLKnXyRB6MGGF9MG+VjyCX?=
 =?us-ascii?Q?88w31zioaUMd0MnheNzjZ5McqzkPQheuBPvbYECOrw8sYqJA?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB361198AFD6BC49B5A4C0340694D12DM6PR12MB3611namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7260680-3f04-434e-cf91-08def4901f42
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 14:28:16.9861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2pmY0zUMoJ88t3DDTsmnPKUVzynSqiknz52UPoomavB2JFBxeOLBSEXrJfdAkOCTeXQdQSEGMuVY+xm/hqTkzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9332
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

--_000_DM6PR12MB361198AFD6BC49B5A4C0340694D12DM6PR12MB3611namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Reviewed-by: Michael Chen <michael.chen@amd.com>
________________________________
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Friday, August 7, 2026 6:10 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Chen, Michael <Michael.Chen@amd.com>; Liang, Prike <=
Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu/mes11: disable MES RS64 process/gang context lo=
ading

The MES RS64 local memory process/gang context index may be updated,
saved, or restored improperly during queue eviction and restore cycles.
Enabling RS64 memory for MES process/gang context loading introduces
two known issues:
  1. Performance regression on userq due to improper context index
     handling during RS64 memory access.
  2. KFDIPCTest.BasicTest failure on Navi31/32/33: the IPC buffer
     GPU VA mapping is not correctly reflected in the restored RS64
     process context, causing GPU page faults on the IPC shared
     buffer address, which eventually leads to MES firmware becoming
     unresponsive and requiring a full GPU reset to recover.
Temporarily disable MES RS64 process/gang context loading until both
issues are resolved.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index a0b874c9ee7b..c57bcb9a98b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1954,7 +1954,7 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *=
ip_block)
         if (adev->mes.ring[0].sched.ready)
                 goto out;

-       adev->mes.use_rs64mem =3D true;
+       adev->mes.use_rs64mem =3D false;

         if (!adev->enable_mes_kiq) {
                 if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT)=
 {
--
2.34.1


--_000_DM6PR12MB361198AFD6BC49B5A4C0340694D12DM6PR12MB3611namp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
Reviewed-by: Michael Chen &lt;michael.chen@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liang, Prike &lt;Prik=
e.Liang@amd.com&gt;<br>
<b>Sent:</b> Friday, August 7, 2026 6:10 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Chen, Michael &lt;Michael.Chen@am=
d.com&gt;; Liang, Prike &lt;Prike.Liang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/mes11: disable MES RS64 process/gang con=
text loading</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The MES RS64 local memory process/gang context ind=
ex may be updated,<br>
saved, or restored improperly during queue eviction and restore cycles.<br>
Enabling RS64 memory for MES process/gang context loading introduces<br>
two known issues:<br>
&nbsp; 1. Performance regression on userq due to improper context index<br>
&nbsp;&nbsp;&nbsp;&nbsp; handling during RS64 memory access.<br>
&nbsp; 2. KFDIPCTest.BasicTest failure on Navi31/32/33: the IPC buffer<br>
&nbsp;&nbsp;&nbsp;&nbsp; GPU VA mapping is not correctly reflected in the r=
estored RS64<br>
&nbsp;&nbsp;&nbsp;&nbsp; process context, causing GPU page faults on the IP=
C shared<br>
&nbsp;&nbsp;&nbsp;&nbsp; buffer address, which eventually leads to MES firm=
ware becoming<br>
&nbsp;&nbsp;&nbsp;&nbsp; unresponsive and requiring a full GPU reset to rec=
over.<br>
Temporarily disable MES RS64 process/gang context loading until both<br>
issues are resolved.<br>
<br>
Signed-off-by: Prike Liang &lt;Prike.Liang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c<br>
index a0b874c9ee7b..c57bcb9a98b1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
@@ -1954,7 +1954,7 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *=
ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;mes.ring[0].s=
ched.ready)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto out;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.use_rs64mem =3D true;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.use_rs64mem =3D false;<b=
r>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;enable_mes_k=
iq) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_type =3D=3D AMDGPU_FW_LOAD=
_DIRECT) {<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB361198AFD6BC49B5A4C0340694D12DM6PR12MB3611namp_--
