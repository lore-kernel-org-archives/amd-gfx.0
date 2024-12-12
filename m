Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F505E7717F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 14:25:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DF0610EDE6;
	Thu, 12 Dec 2024 14:25:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FLn/FzRL";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A733A10EDE6
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 14:25:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pG0l8c9lRrh67/lb+bxQekvoR2w3+JCRJqmS83IP5pn25Zc1IJo94c6CZsszvm+nrKhNmlvXOp/LM/ijL/7RPC3WPgXfgh45t4AtHUpmeHQYnEmrx4uUrRXwKYUk74h7fglj31Q+f3HxJiPPNOfhPO0xk3d9q++3EBwBiWlCu9eI/85jigIFJkNtzXXlxCgxbR6cXTuQVAQEuDLjVm4Qs3ZtKr7jCn4ZDW5+WqVeHapkVZlWtViGOuVdPOjWtDiztVvzo4+jynr7sZqc6JE244PvXexiQTywBy83xxG/AaVsf8x9KvSYFDCC9Szw0YxrFNiSeLxtT4zfTyKEi0EAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4PNOd+yTgvDtdsRiZ/IvECJN99XNu1WV7K1bYsP4aU=;
 b=DqmqO2uqyIb/vekUy3JWT+9mmkxMglHHtDR9l2r7lSzFvcAumWkqtvDHmjhT6BDB4QO2o3Br/6K/iJ4Dwxd571XDn/Uyi9P7uMmC8br+YN+qwBTAxggetfd70OsktUHx2j+MFeNrGRpL2FPhE7ralB9VM7aMzzPAOnOJKxqfOnjMWpTj66TgwF6H8pQ2s4BYTcU5gEsgTMcc9/RU5d2c+ffvOEHQ2hdBtdxdswnkQssD26u7ExrQnZqK2DIhkv+WdEbIaCkb2drD53l/dD2KuTfAcDXsVhnh5ov+rxfj3GtZS/K1B8Gtie7uBJwgz4QRDhHXHIkNhgEc72mStAPfqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4PNOd+yTgvDtdsRiZ/IvECJN99XNu1WV7K1bYsP4aU=;
 b=FLn/FzRLtEj4NSi5zzg5XBYEUcSNAU6gsnXYl3jNbr2NBVZKldkE9PQEcVK5ALL314d3Lf3P4KuVzinRcXCfkp0zwLH8QXWuFXsDBsbb9rgLSW5neNPED/KhIGsSx5K9EvhegDBUwTilSNZIyxccE1ZmlH6oOrVhw2eD64oaxVg=
Received: from DS0PR12MB8813.namprd12.prod.outlook.com (2603:10b6:8:14e::11)
 by DM4PR12MB8569.namprd12.prod.outlook.com (2603:10b6:8:18a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Thu, 12 Dec
 2024 14:25:06 +0000
Received: from DS0PR12MB8813.namprd12.prod.outlook.com
 ([fe80::209d:684c:7773:42aa]) by DS0PR12MB8813.namprd12.prod.outlook.com
 ([fe80::209d:684c:7773:42aa%6]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 14:25:06 +0000
From: "Zhang, Bokun" <Bokun.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/vcn: reset fw_shared under SRIOV
Thread-Topic: [PATCH] drm/amdgpu/vcn: reset fw_shared under SRIOV
Thread-Index: AQHbTBZ0JS/OPIsgTkaHzPBgTceGf7Liqv4K
Date: Thu, 12 Dec 2024 14:25:06 +0000
Message-ID: <DS0PR12MB8813457D3836BA8027A74B8DF43F2@DS0PR12MB8813.namprd12.prod.outlook.com>
References: <20241211214822.28160-1-bokun.zhang@amd.com>
In-Reply-To: <20241211214822.28160-1-bokun.zhang@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-12T14:25:05.314Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB8813:EE_|DM4PR12MB8569:EE_
x-ms-office365-filtering-correlation-id: bca000f7-156e-4fd5-0133-08dd1ab8c69f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?PJ2ZX1wF/BLpUzdFMZqW3dQb1LtsLltp0Ig6yXACQNsc+kZ5gsPsZmZI3t?=
 =?iso-8859-1?Q?Jlm9D9GJfJaIYpJ1RibuLLazKskvoIpEk9ZmABD/tlGzRUjBILR2t+svRV?=
 =?iso-8859-1?Q?f8i+zk/GWmjdSaOfn1vkeF4Qpvajn9mbf//kQomzBlBmA8WGpMwyeyoJ9P?=
 =?iso-8859-1?Q?HD3mUV7hiTkJ7hRgJzM54Csh8hOyrxLaDX/8xu67Z7bmr1q7+JV8K73ySV?=
 =?iso-8859-1?Q?Qaq1+0Od/TN9K7/FtsbGDOYcSF3T1C8+pIMNAsM81bHoAt1jGJ8x0B15Xe?=
 =?iso-8859-1?Q?ismSqD8+x7Z45bdIwgqkHR+CSpBy4ijsztypEvBw9qxrQsnpmDYaqgb1wk?=
 =?iso-8859-1?Q?FwqPGdQ5mw9O34OuoypiE91pAKxUIjgJE4dcFAwpIded6mbtpm0rgoTtdM?=
 =?iso-8859-1?Q?WGOBy8mSkPQmBhDjsQ8X4SWBFKz/Q2+lKdCiLs3k//P6KKCjdfGaT0AQNB?=
 =?iso-8859-1?Q?ZpQmBIW3M7wzoOWzECoCJ0bye+ZA9MsuvRyaFJITx/zIRe9d5mGcrWIwnx?=
 =?iso-8859-1?Q?8sAa37BSDDYiILn+MYI2TJ+glRw0epqFoUZwMY4P90Umq5sj2220svuXQP?=
 =?iso-8859-1?Q?SOu/rPyVDXMKfjG9UDceH5QOtq0A1vCH6syv61U78PUOeFt98TiCMHFvq5?=
 =?iso-8859-1?Q?WvfGyyaWFcwvfK3V7Clj/T6tTKPeVvOAPzd6HABmzrV4SA4BMoCjQDTpoM?=
 =?iso-8859-1?Q?aBr7OI6UYvf08efEoAdVL/dNtYKH2ZppfWsQ+eLuoGn5aZFFeVEEH8K63E?=
 =?iso-8859-1?Q?6J3a4nA3ckBmT2YWGemChy3yS+tC9Hb8g80A67UJr4Q6+EYBKEDV5rLMsh?=
 =?iso-8859-1?Q?EsNJ9lkGcJ8w6j+YsOXT1UdYzqZwwWLk9Qgb8IbBXqq8fsrg1zzPB+aQQ4?=
 =?iso-8859-1?Q?FCy5i2syAeu00f00YNVkA5uWNR+W+OBaE9AVVBpxo1v96zONsmazQVQseF?=
 =?iso-8859-1?Q?Fdc5R74LR7ZwsiKCYoajSRc6nxlWnI/6Ol4OezLNpXz2yQXXlWMY0Hsya5?=
 =?iso-8859-1?Q?PhS3jqPFSqM2RqfhZRfcjjt21R9Zy3vFVnZ6jdzNe8Jt1et+NUP9wHnKru?=
 =?iso-8859-1?Q?AAmHyyQARKJtb66B2fAfumVg81HFYzIto81q8Alp+0uhCgtQCLK2D6IRhE?=
 =?iso-8859-1?Q?R0D5ER8NYciRE2OMYNmOdhPkmQmUlYyi/koFCyeMPmCWldoSoxLiMOWbJv?=
 =?iso-8859-1?Q?jGvyA7V45lPusN/ElDNC1+8M1VXTWQfSaXhSUm2wpvhDWWMnXVqiQMhU1Z?=
 =?iso-8859-1?Q?nv5G5vUuH+iPShLzPGEqYCGAENXEsI0XSHdYk+QFPpdMRfZt+IqwPU13UW?=
 =?iso-8859-1?Q?Q8rX3A6/icg1tIVub2uKDpyYzblE9BeOyN2s/xhSlxKWoFhrC5QRzWqZ8j?=
 =?iso-8859-1?Q?e+H7vcZvsbcsCVseOyiM1g5ERVK/A5HNzu436iuro4xYlDofJEzBW14wa7?=
 =?iso-8859-1?Q?rwMu6QogShosPCXNOny1E77gB5Ko8jcWsF5wIw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8813.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Llims4a7NW2CGfWFyb81zyjKiLeQ8D6CwTWaKg/HmJqJOlyzQnF0cO11Xh?=
 =?iso-8859-1?Q?aY1H/vloVi/9S2Ch2+VKa1ef8u/enqf+SjRor1Q377fhWJ9FbZYfPiEaDV?=
 =?iso-8859-1?Q?r6A9zrfztoACTOY1cGlsoTzGpeWpiS2xKCPuoYlp3le00Y30KGGhJsQGvF?=
 =?iso-8859-1?Q?LvnkkVSBf68MO13JKvesWTXQhh5/xWkZoScUEN1tglJI1KTGPs3hb5RJuF?=
 =?iso-8859-1?Q?HIb5T15ZJCZePsRC126IllG9d6L1wO4Bkl7PNElqMYgyJ3XzGpfG7jV3pN?=
 =?iso-8859-1?Q?KRq4kDJj4m6g6vwlOPAMNMP+1EsCHNKIzZU+DDjJFjLHT8QNDx2hqKoOQi?=
 =?iso-8859-1?Q?MNh+Me+Ge6UfbdBRrDsZ5fCaW0UmuvyynQyPjrxi0uoDxLzQdiDHvcEH8J?=
 =?iso-8859-1?Q?40Qzr6Ex6EC6jpM5ggM2JnnPM+OpiHMwidzxz2kg7iYKOIwrg0+5qghllL?=
 =?iso-8859-1?Q?QcjPsPqq7hzLIfoTUWQneEEGb570u6OWISQ24PpJ+P8CDYgoKgK7A5dpdu?=
 =?iso-8859-1?Q?2qVHyG6jCG9PFaXrNLS/w8Ks3JN4EhwoQYEU/1GBSZW+9nhtXD7my+H3cn?=
 =?iso-8859-1?Q?wsH9A/X3lJNL5FgRRHa7urwxaf/vXjyeGdnrFBf2XKjEwXd0oe3IGYFBTz?=
 =?iso-8859-1?Q?ok5rPskhXnkVvUByrolZ+wk1WA/ye9xGVR9vb/RyuEm/wCuhiKM40FAS36?=
 =?iso-8859-1?Q?IyEQg1bxqeEs3J+tR0To1XyiT1rlBwwbPtbhHj4si9nb4cxupE16WcW9PN?=
 =?iso-8859-1?Q?GX1vSxta0EuYc6K24PpITwVAQ1T3A2QMK4oeHdDdR9w9FvN0C7GF7gcxk0?=
 =?iso-8859-1?Q?WWXfrOaK+l/h9pON+kz4y3BXqR9+kJk+ml9gbrFg+xaM+tliQQJlU2Owpv?=
 =?iso-8859-1?Q?2dQm2RTxqbibynQkY9yq+6AcQ8RxgZRSAz3Mxi2ufKB6ps6UMwUe9CbQVk?=
 =?iso-8859-1?Q?tB6EYnMxJPulCuKHrsI0N6hgX9i4wj4AhqZ0hvAkvSnR2j1kj1Yux2HbMm?=
 =?iso-8859-1?Q?tFyd5v5M2HReAh8ZoWHTaK8bgSCWNENCEVpXad8aTUtaqchuUWHyxCX6VJ?=
 =?iso-8859-1?Q?M4Qq8nEVxfgkjXJULl/jOVh35ff2f9QszTgWZPBrWCWp9hGNRlN0EvwLu1?=
 =?iso-8859-1?Q?6JV2j294hLKy+kgGdIbWYbrTYGAG8xlMvcCX8wWCxtj/57u9w6IG06VBS8?=
 =?iso-8859-1?Q?xdUeted6mcKutPDotRfMDWoDWVXhm7H3bgB934jk9d2EZVNs6rBvnHo/1e?=
 =?iso-8859-1?Q?sldFJ9PzXnlYgo60EYy7j0QzF9fNejFc4/sUXMO6m+tH3uR/nS+oDgGoCw?=
 =?iso-8859-1?Q?r4Pkmwu6AxqouJkpXwoCPHD/SpdW6tuI5kdw+axT7At6OcfEa1m6hAphm2?=
 =?iso-8859-1?Q?aW7/teFDkVTgZo0LJVsASq1e9nWiyqnXtl1dZX2Q6eYKL8p07gvFD4yr7l?=
 =?iso-8859-1?Q?c8F/SRA0klM/o5XofIIEXz3WUHdcAyeHATPzPG7irtosMjgB44tjaS0uQh?=
 =?iso-8859-1?Q?OAdU4TeYEhqpYD/5Dw1oSvBXxfPSQb3rIQxAiqeY72QWr+/ey3Vv++AVDZ?=
 =?iso-8859-1?Q?9iriLqYGfjnE2PERuEH4XHq8k0bRnB0fchoqoZQedIUZ7RlqyB9Mi0z2aM?=
 =?iso-8859-1?Q?E9JIoSwxKXrAA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR12MB8813457D3836BA8027A74B8DF43F2DS0PR12MB8813namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8813.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bca000f7-156e-4fd5-0133-08dd1ab8c69f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 14:25:06.4861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VnRrqEtTQbN8gnxeZAHDNK9h1KSa42XbCcxPlCayhwl5ADz6BmfmDrMLr2Qgam6c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8569
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

--_000_DS0PR12MB8813457D3836BA8027A74B8DF43F2DS0PR12MB8813namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Please help us review this patch.

Thanks!

________________________________
From: Bokun Zhang <bokun.zhang@amd.com>
Sent: Wednesday, December 11, 2024 4:48 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Bokun <Bokun.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: reset fw_shared under SRIOV

- The previous patch only considered the case for baremetal
  and not applicable for SRIOV code path. We also need to
  init fw_share for SRIOV VF

Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
Change-Id: If26a377a2fe8f2aa09bfa21fc54bf26e80fd564c
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0_3.c
index eeade7366e82..ecdc027f8220 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -957,6 +957,8 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu_device =
*adev)
         for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
                 vcn_inst =3D GET_INST(VCN, i);

+               vcn_v4_0_3_fw_shared_init(adev, vcn_inst);
+
                 memset(&header, 0, sizeof(struct mmsch_v4_0_3_init_header)=
);
                 header.version =3D MMSCH_VERSION;
                 header.total_size =3D sizeof(struct mmsch_v4_0_3_init_head=
er) >> 2;
--
2.34.1


--_000_DS0PR12MB8813457D3836BA8027A74B8DF43F2DS0PR12MB8813namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Please help us review this patch.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thanks!</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:11pt; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Bokun Zhang &lt;bokun=
.zhang@amd.com&gt;<br>
<b>Sent:</b> Wednesday, December 11, 2024 4:48 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Bokun &lt;Bokun.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/vcn: reset fw_shared under SRIOV</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">- The previous patch only considered the case for =
baremetal<br>
&nbsp; and not applicable for SRIOV code path. We also need to<br>
&nbsp; init fw_share for SRIOV VF<br>
<br>
Signed-off-by: Bokun Zhang &lt;bokun.zhang@amd.com&gt;<br>
Change-Id: If26a377a2fe8f2aa09bfa21fc54bf26e80fd564c<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 ++<br>
&nbsp;1 file changed, 2 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0_3.c<br>
index eeade7366e82..ecdc027f8220 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c<br>
@@ -957,6 +957,8 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu_device =
*adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;vcn.num_vcn_inst; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vcn_inst =3D GET_INST(VCN, i);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vcn_v4_0_3_fw_shared_init(adev, vcn_inst);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; memset(&amp;header, 0, sizeof(struct mmsch_v4_0_3_ini=
t_header));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; header.version =3D MMSCH_VERSION;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; header.total_size =3D sizeof(struct mmsch_v4_0_3_init=
_header) &gt;&gt; 2;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DS0PR12MB8813457D3836BA8027A74B8DF43F2DS0PR12MB8813namp_--
