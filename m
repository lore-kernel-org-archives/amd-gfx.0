Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAA5606A322
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jWp3RyDQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1114810EAA5;
	Mon, 16 Nov 2026 21:00:17 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013021.outbound.protection.outlook.com
 [40.107.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F331510E055
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 21:00:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIQvOPSbAuVeetlCL+TfvKPVvYc1esdqp7BAFssJ8+b53CpBUjKvH0Liaeh234HnWViQYgbmCrsUoKYPtgTfEoKZwo3yxD0uX4PpLMfM4gGmLByy9g6WRevERCjiWSDnLg843U0rDVpfSJFU/pzjuKehlmbX0dLbgUYXmUBy3QMch3a5WX+h73ztoDNNb/7blTu3ToE34/HZPexn05yc/gr8FFO2OHJ6zYWS2Z4rfHRzfVjS1LTE0nz4d/uQWulphY/EfDjgVdFfPEy1S9tIslaqkXBJYb+t62nvz8RQWfHaNyeTQ7JFKcAog/XYWpvQjiwt0xQWZ/M3iChRpPLeeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfl6E/63ymMiI9owHzrVEyMIyIBJi3UNuKMSS7sCPb4=;
 b=k4hKyTWr7ix7+YKr5gJ4uUR0Zj1Qc24eCstpgoQpAzvmlaO5s0q4wNjI4YV4d/mQz2Y+mYSBvIOtAH997Tz2dkFN3FewjkhM7bnosvoDWbZEvl9yWWykKbCEIdAfPopz+SalQLgaiP2/iH4qkJtlzDfdoi1JCXdULBG14E+/J6uMJCrV6hkbPaFlqMqS8ez2uO1NaU3JUs0Elckm4ieQhfCFltvmUjbin/NsBTpgRfic+6IaKXS6myLaqGJABOlngm88yW+wiMds2ySwv0ENxzBJT0ZnEjnTdbxkWomOUKFrIxhB1pLviTRAF99k71PhXJ08TwDOdtPK1GVSFp65tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfl6E/63ymMiI9owHzrVEyMIyIBJi3UNuKMSS7sCPb4=;
 b=jWp3RyDQHcIdq8oGcGCZwaXMRUexaiieRS/+5T9f8ZKSK/2aOvI2Jo2YELX0AjmE9U/z7/4dPSoH99CuIPSyhFLyzqZfBgsmANizckHq136E59f30J5fLXM9BDIL/RnuLYT/Wn0Ng/jZKzmYZSfv7AIkBx0Nz+e3Oe1SPz6KShM=
Received: from SN7PR12MB8435.namprd12.prod.outlook.com (2603:10b6:806:2e2::11)
 by PH0PR12MB999112.namprd12.prod.outlook.com (2603:10b6:510:38c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 21:00:07 +0000
Received: from SN7PR12MB8435.namprd12.prod.outlook.com
 ([fe80::aa71:237c:b901:66d6]) by SN7PR12MB8435.namprd12.prod.outlook.com
 ([fe80::aa71:237c:b901:66d6%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 21:00:06 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhu, James" <James.Zhu@amd.com>, "Indic, Vladimir"
 <Vladimir.Indic@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
Subject: Re: [PATCH v2] drm/amdkfd: move TBA/TMA back to system memory
Thread-Topic: [PATCH v2] drm/amdkfd: move TBA/TMA back to system memory
Thread-Index: AQHdddmHqzb4vwPggEqvTT1NsQjfabcxLyOP
Date: Mon, 16 Nov 2026 21:00:06 +0000
Message-ID: <SN7PR12MB843595F0DF8CE5095E5A4DCA8C7C2@SN7PR12MB8435.namprd12.prod.outlook.com>
References: <20261116144744.1904011-1-alexander.deucher@amd.com>
In-Reply-To: <20261116144744.1904011-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-16T21:00:06.130Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8435:EE_|PH0PR12MB999112:EE_
x-ms-office365-filtering-correlation-id: 26ded2c7-9c6a-4f0a-387f-08df442497ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|261009223027099003|13003099007|8096899003|11063799006|56012099006|261102123227099003|261021123027099003|261021121427099003|38070700021|10067099003;
x-microsoft-antispam-message-info: l9Fzc68/UvEvh+Dfp9hC5F0AkZQuKB6RCowNpKLpAd9q5VaBnO0Qd4elUSvISozyO+ZW9M2mt8kLlgXbFmB8hbQMM2GkrNx1g5urdisURoPZEYrbe1qNzhC8tIHt6GYaxO/biX7SNI4USNFWv/iuyiJuAtd8Qj+m+LirHJfBl4yBN3suqpi0VYYWYTV2zsdzJ4stmgWLMvQbYAp/rgYJrQEJX8eLclNGGZSvHbvqj0pl0cpivwv0Ux+rUaGxaUF2zAhAaC78BMcgamp5hfuSlUhEfqVMqy85inrvzNWYrQuPEHbJ+RTs66Uqkm0FfFR3xOe//AoJphHpeXeEC8pGOdopUj48sIcYK25JkP3YB3NwQ7juuUEMSZzBtT7mnjCwanyj8rHm3qd2MX6wFqwS83xsFBqSMMyawW2qD7ZPeLDsxf5tpalFZXuj9EOeCdCVAGsSNNOoeYI7WukjMyBh2+kbZveCR8nClQP7a7EmPfHXz11cHobzgtPi/hzSiWmBsfnEhZuIfI8Hj/NyWJjNiSMSffg5R/UPYZ39Oz2BT9/GmeHLiRrLSEZjfxawj7PB/GlO/g26w5KiCpsP61UX8hDth10OfFsr7xMLTrvg3TJmnA+r1AC1LOSUHrwddfOOiyw3CZWpywMp683GT3V2FuRWmNAhPHlJYELD0yGAgj4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(261009223027099003)(13003099007)(8096899003)(11063799006)(56012099006)(261102123227099003)(261021123027099003)(261021121427099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1yqAeedVQQyWrnHWsbbirnDIiVn/9w6zG9POylE6yfBzdx4+QymK1yskMqLp?=
 =?us-ascii?Q?qzo2abSFBan+Z2FYth06ga4fPaIXqyvdiZDVqiAuzhj4sTX/Ly44VgJRHYBH?=
 =?us-ascii?Q?0WeceRQPe8j59jTe4STt7sGIIImn8Zi6c3c5lQP5uI4bXi+2j2ow6EgFC7AB?=
 =?us-ascii?Q?P0JfUDFj9pYFAj+pFfKsXdJ9M2skdVw0hmIDwCZopLxiySQ+UeHRKypwtP/2?=
 =?us-ascii?Q?/qLmrdV9RNDnLWe6r2hIRRIUW5dsCpE3FUOlfUsOv33oolZcykEFG4Lpqo8H?=
 =?us-ascii?Q?yk+AcXk/nurNaLDqHRZAD2tR4EZ7vBSJYMzQnk9y49zAN2JnSvlAHLt9QIZ1?=
 =?us-ascii?Q?CHprFXo8IDwZJweuOTJk1MJ52HOsz4KYyKel6kQf4zSttCGO5d8YsBSzwa33?=
 =?us-ascii?Q?N+5IfkUywzNGQIuFEv5ou0LnVUFsg6xcufsKhRuU6mwA8ANpiMPgr53iIgYB?=
 =?us-ascii?Q?1YN9I2hZ+iaAGoLnfl6Q2V6D+PzEQpaMZdB1WUm6bjqz4zhgdxhjkk0A3ef3?=
 =?us-ascii?Q?wq7PC/oT7Xhdwmn3W9dkYCaWfVjnN0H0h1TIEcGP5Dnm4zVs84N/tyZoy3Vd?=
 =?us-ascii?Q?hvciwNMnk/lnWZ5dCV/OwNO+N/GaBLqThTyvbQUQtyXOBh8D675UJWHiCrbx?=
 =?us-ascii?Q?/ADwxh5fBp6fWVjEnL8FvS/Ynuk+SfyWa8i1qkHaoI1JGf5P2o9OYyyb7Nsi?=
 =?us-ascii?Q?/CTwMe7KE1EJAZs8ME35tPpCYXyCdXnh8eOmxBiW22K9THYf8hc5pdJgzkiG?=
 =?us-ascii?Q?pHD3KGnu/TANlVtSPIvDyNHPGzFS+Zu3kd8DKYm+HIm0/QDSyDLfHzOOgDnu?=
 =?us-ascii?Q?IOniax7Ug3mK11Wl4JC0AHpP7Ka1BvtfDRwtp4xJpUhp+vnGSapFfH7T1Mpq?=
 =?us-ascii?Q?1r6SSVTTjV0hm7Q/cxmkP0pXhZ3CnmPSxuon7IStSo9hYULWGE8AFMC65GJ7?=
 =?us-ascii?Q?T/YgUSqk7L5aPBHyorpqBJRsFCWuKFofKakaEeLPPewsTVhOFz47VKB4RILD?=
 =?us-ascii?Q?mpGi2ySoDswVySYeLCjjy8faxI3X63XrISOnWtBcILwkJ8vFwcCBShFc8/TS?=
 =?us-ascii?Q?3uR0bhk78x4TvU4hwfrVz4nydc2z2LYOGSXzYrMbQmsHByKVB3gJEjhAGWu2?=
 =?us-ascii?Q?/WBnKYeLJJqUw8RRnADvPzTW+AVUYKK98YpDipbkC+2YqK9LYwCmKrxK9XHC?=
 =?us-ascii?Q?jFG2zAvOQ7AuTwtg1QUytrXEHy/HgovC8FSG5Nrs1Lc0n5+PQXoFEAZI13Uu?=
 =?us-ascii?Q?7fsCBic+bPl+Q4m9HCliShSa9MGIWOn/TBzfbnwKOCuukBkiMFAFbOWRrrMF?=
 =?us-ascii?Q?k5CrOCw+FhfTj5g+XlkzedrpJkUHy6f7VGQeNaLt8qlHFDEup/eDAHnDlsAh?=
 =?us-ascii?Q?pC1WWZs48qT22Z8JicEnt/lpCo7/p/cD2vuwJINV/qtUMCbN0G3sNg+BFOAb?=
 =?us-ascii?Q?wkn7jPd7GPA94p+8mJCrOU0axbnKT+4qNanb1FN4FAxB4iW9b58Ki+/R3yZP?=
 =?us-ascii?Q?O0ghcf4k1N7+2ttBWRGtjB326EbhnOiQKbEOaIY5CzqZyqG2G8MyyCNhN/F7?=
 =?us-ascii?Q?rQrcb0P/zTsGp/o3jZvhw8wtpS9dF5RdfwmIGF2Z+ZOxWn9cm2kX0Nh+9m7q?=
 =?us-ascii?Q?F0ovn4MwkRFUglyBxwwWFmqaOdeJSVKXqYMA6k5GASeW9Sis2l+I2gRfVnt/?=
 =?us-ascii?Q?bVYIF6YpxZoMIlkXqWpcca9zKI0f+8KKeCUUxBzWrlBOnkqc?=
Content-Type: multipart/alternative;
 boundary="_000_SN7PR12MB843595F0DF8CE5095E5A4DCA8C7C2SN7PR12MB8435namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ded2c7-9c6a-4f0a-387f-08df442497ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 21:00:06.8004 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QdxfsWl/zmAPB2oBmjiihp3w6tylh9ZbBrphFS0IXsD7XMxoMniJtwy5XJ23JuGnNQnGWw4Y/D1/68J4yy4mIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999112
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

--_000_SN7PR12MB843595F0DF8CE5095E5A4DCA8C7C2SN7PR12MB8435namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>


________________________________
From: Alex Deucher <alexander.deucher@amd.com>
Sent: Monday, November 16, 2026 9:47 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhu, James <James.Zhu@a=
md.com>; Indic, Vladimir <Vladimir.Indic@amd.com>; Kasiviswanathan, Harish =
<Harish.Kasiviswanathan@amd.com>; Yang, Philip <Philip.Yang@amd.com>
Subject: [PATCH v2] drm/amdkfd: move TBA/TMA back to system memory

For non-MI parts, move TBA/TMA back to system memory.
Results in GPU resets in some apps after suspend.

v2: add additional IP versions

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/6116
Fixes: fe5966d4fdcb ("drm/amdkfd: move TBA/TMA from system to device memory=
")
Cc: James Zhu <James.Zhu@amd.com>
Cc: Vladimir Indic <vladimir.indic@amd.com>
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: Philip Yang <philip.yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index 546721b4d59ac..b1b641ddbcf68 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1554,7 +1554,12 @@ static int kfd_process_device_init_cwsr_dgpu(struct =
kfd_process_device *pdd)
         if (!dev->kfd->cwsr_enabled || !iosys_map_is_null(&qpd->cwsr_map) =
|| !qpd->cwsr_base)
                 return 0;

-       if (KFD_GC_VERSION(dev) >=3D IP_VERSION(9, 4, 2) && !dev->adev->apu=
_prefer_gtt)
+       if ((KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 2) ||
+            KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 3) ||
+            KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 4) ||
+            KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 5, 0) ||
+            KFD_GC_VERSION(dev) =3D=3D IP_VERSION(12, 1, 0)) &&
+           !dev->adev->apu_prefer_gtt)
                 flags |=3D KFD_IOC_ALLOC_MEM_FLAGS_VRAM;
         else
                 flags |=3D KFD_IOC_ALLOC_MEM_FLAGS_GTT;
--
2.56.0


--_000_SN7PR12MB843595F0DF8CE5095E5A4DCA8C7C2SN7PR12MB8435namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Harish Kasiviswanathan &lt;Harish.Kasiviswanathan@amd.com&gt;<=
/div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
ander.deucher@amd.com&gt;<br>
<b>Sent:</b> Monday, November 16, 2026 9:47 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhu, James=
 &lt;James.Zhu@amd.com&gt;; Indic, Vladimir &lt;Vladimir.Indic@amd.com&gt;;=
 Kasiviswanathan, Harish &lt;Harish.Kasiviswanathan@amd.com&gt;; Yang, Phil=
ip &lt;Philip.Yang@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amdkfd: move TBA/TMA back to system memory</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">For non-MI parts, move TBA/TMA back to system memo=
ry.<br>
Results in GPU resets in some apps after suspend.<br>
<br>
v2: add additional IP versions<br>
<br>
Closes: <a href=3D"https://gitlab.freedesktop.org/drm/amd/-/work_items/6116=
">https://gitlab.freedesktop.org/drm/amd/-/work_items/6116</a><br>
Fixes: fe5966d4fdcb (&quot;drm/amdkfd: move TBA/TMA from system to device m=
emory&quot;)<br>
Cc: James Zhu &lt;James.Zhu@amd.com&gt;<br>
Cc: Vladimir Indic &lt;vladimir.indic@amd.com&gt;<br>
Cc: Harish Kasiviswanathan &lt;Harish.Kasiviswanathan@amd.com&gt;<br>
Cc: Philip Yang &lt;philip.yang@amd.com&gt;<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_process.c | 7 ++++++-<br>
&nbsp;1 file changed, 6 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c<br>
index 546721b4d59ac..b1b641ddbcf68 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
@@ -1554,7 +1554,12 @@ static int kfd_process_device_init_cwsr_dgpu(struct =
kfd_process_device *pdd)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dev-&gt;kfd-&gt;cwsr_=
enabled || !iosys_map_is_null(&amp;qpd-&gt;cwsr_map) || !qpd-&gt;cwsr_base)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (KFD_GC_VERSION(dev) &gt;=3D IP_VE=
RSION(9, 4, 2) &amp;&amp; !dev-&gt;adev-&gt;apu_prefer_gtt)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((KFD_GC_VERSION(dev) =3D=3D IP_VE=
RSION(9, 4, 2) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_GC_=
VERSION(dev) =3D=3D IP_VERSION(9, 4, 3) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_GC_=
VERSION(dev) =3D=3D IP_VERSION(9, 4, 4) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_GC_=
VERSION(dev) =3D=3D IP_VERSION(9, 5, 0) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_GC_=
VERSION(dev) =3D=3D IP_VERSION(12, 1, 0)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !dev-&gt;adev=
-&gt;apu_prefer_gtt)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; flags |=3D KFD_IOC_ALLOC_MEM_FLAGS_VRAM;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; flags |=3D KFD_IOC_ALLOC_MEM_FLAGS_GTT;<br>
-- <br>
2.56.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SN7PR12MB843595F0DF8CE5095E5A4DCA8C7C2SN7PR12MB8435namp_--
