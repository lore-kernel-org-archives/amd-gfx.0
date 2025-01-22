Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4502C02181
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2025 03:54:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 581FF10E203;
	Wed, 22 Jan 2025 03:54:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w8ozh6KZ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A208310E203
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2025 03:54:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvZSjyFZ/uDK5IIEpn/Tu+ltBFWykYSMXBI9IcLGv1NTJ0ijLeKKFh3fFwC5NpDtpxwhv9uP525oMGgtqTFogJz+lGC+/rIqb2SLg9wlOUKfSkvZ9TvOFHzpwMHwQWdSgxHzzycdNAAWgA1/zd6ly7P2L38T894pZESPYPjoz9sBWuIJ5Que3vpYOfwU07s4UtbYONuzzakopEE5VSAiHEhAnQ0AaaUWVLly9hzQiM7Rs12BrMid4LhvwslMTLSYw8azdH+ukKyScQa4gfoHoz+PhGpkR0rZJaUG7M5kYIz2797hi2JabHSXE8Q/7/rSc2RhkdtjYPcI5GwgN9ExXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHK4IyCDPMGpqeog2NC4wK4gO2tq2/8DR7EZOuC2IAg=;
 b=eR8+cZJc48OEIcbH8g1qZC1Nu+uNt0DBlh6NXiqK9TCkRYjFWrGur+9ig3yKu/UcsIu5ToQbmSuxh1CNGGYsqrtMmIlbsccqU9nlLOgyPCSwfm6znyC+TZuThdKzfn/rHPm+beg1p3aZnlyxt6yCr+06rrwUyh4rPZzUB+lKeYFo+in80fkip3Won8THLYLPiCkKopFv6p2FeE2WrIPaAJShXxDbdwFMMelmJiWPVKCg+haH2c+nPc4DSysVRM3QlLOj/9sccKrQhGRv4E7OUAgWfpacVaFAs8lYUQoxW8fV8b4ioDybtmnr1rp1gc1vTS1Av7fmM90A3w+yUaPZmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHK4IyCDPMGpqeog2NC4wK4gO2tq2/8DR7EZOuC2IAg=;
 b=w8ozh6KZbZ/X5TEQLqveaJXHDVB0FQDqHmCFOyO6DWHfPidif1bAa1OwS2hUCmj4LoorTwgnhlUbpEfhlAJ/Zb3rI5IkfCZlxZLT0SgRkm/UtSj4yaHRDZP0H1sa9eiDE62VAk4SJlwQPgVCPVM8J3zduZ08KTx//4qcAcFvkOc=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 03:54:33 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 03:54:33 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amd/pm : Mark MM activity as unsupported
Thread-Topic: [PATCH] drm/amd/pm : Mark MM activity as unsupported
Thread-Index: AQHbbIAdgHys1O9Qt0ek1qiKPb4A57MiKZ7g
Date: Wed, 22 Jan 2025 03:54:33 +0000
Message-ID: <BN9PR12MB5257AF1387A4C7D2DCCBADA0FCE12@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250122034451.1578850-1-lijo.lazar@amd.com>
In-Reply-To: <20250122034451.1578850-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6f9a0e1d-5ff5-44c2-8923-91d95c83b9bf;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-22T03:54:17Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS7PR12MB5960:EE_
x-ms-office365-filtering-correlation-id: 1f0e6e89-93dc-4f63-19e5-08dd3a987b54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?SjDE1GkYvkwQqkhPvalPz74sZ/mCKLzIhRbS+4rbm77Bqyvtl3jG4+Sf/VCB?=
 =?us-ascii?Q?ajv1elf/JA+zPgJR8DaBL9KqXmxaqDftW1vYzl/mNTuzsu9Y4TX990b96JGj?=
 =?us-ascii?Q?cbquYNcn35+cV6h+cLtoBDxYWIkLc9v6Wr2kURW+pwMARBLTAOKskEiX5akr?=
 =?us-ascii?Q?oOg+235vFoZOhfK+UBTyD+/VcMIzJrC77odC5nVjRLLKGZJRH3i/AmAefXmi?=
 =?us-ascii?Q?OnN6MCpJKsc73YGHrfP8FvU7Qhd6KRcZh1NYPhTEqvzsv2O7ifqQU7pkxvPN?=
 =?us-ascii?Q?K12z+OrLOWv1oPh/kk7WZJ0/WVjQ5g1OV6kG3L/hSGB1AsbOA2t2YvP8qQb3?=
 =?us-ascii?Q?wihuQ1TQoy5Ov+BqVTXd6SgNPhDXWQ1a0n4Eks/z10Gf8MsstNz6DkkyMHYK?=
 =?us-ascii?Q?0K5HX6Hzf8jmI1iK1c+IFHPCzZzKy4FdYUBTZFWKzx5cRTxUPxShuBUobOQT?=
 =?us-ascii?Q?opbieN0hZWsIadKEaUISBxbSeJRRcmX4/WSucc2/f2/K7zqIpimTWA6WX2gf?=
 =?us-ascii?Q?0YTiz3AmfJWjyDCz016reXtArlxi9Api6huOvl+xLY96qWVl24eRN1PS1yfk?=
 =?us-ascii?Q?XvuKuDUH4ftgEME/5lc35Wq9+QZ5UoePZ5oRCY/BibXrLjacmCGrXlrUL3ao?=
 =?us-ascii?Q?AU43MCrwL7yuCKXro3NsQrMRsgxONcleiL6FLNO6uR/G5XAuWSMt5bbP5EBk?=
 =?us-ascii?Q?0yObWbYXj/L2/wo986WiAUQaoqYw8vzzbvsGwrzqd4IzeuczS713JjgpnTw5?=
 =?us-ascii?Q?t0/IZ2X2xFTFGF2yNPSFpKCPHrrlivvgipsUgXl02Xn0sS8/sknVZeGFnAJI?=
 =?us-ascii?Q?m099YOBZauwX8rstlNFdgjufKj9o02czuXGzyD993R3d/Rm2P2V3chGYr3/g?=
 =?us-ascii?Q?h4wNoO+GTcOr4MxfX7VGeNkn4R2CUud7+nh3Ic/PDrbVWMKNHrdWXIJSLEpp?=
 =?us-ascii?Q?/0hDKRnNYpmcgNXJqksMZ5knw3YeedneJvDkoXte16rtbPxojykEtVz7OS+g?=
 =?us-ascii?Q?tiY6H3b8Aaj+e0Q+civdQovtDYVngnYncMD8qWleariOUQAdRsWre01zj/LC?=
 =?us-ascii?Q?KZf8WSUMMc1zTkJWWx1p+VMSluzg83qasB8avcKYseIULq21SFhaA9e0OOIh?=
 =?us-ascii?Q?xHwVrVTfzm7qfb9GPiXiiZdtaZ9//fkMT71FXO71OYF+HJOl3ufu/LGlNU7u?=
 =?us-ascii?Q?UOsDCOfGIfbSbOHRxhSnZyKPP7Mg2c0NCOVKacA7OxAo3zybMaTHmH19cEpb?=
 =?us-ascii?Q?rSh1FTKwV1LdjqnMuqmuZZvQM1gOqPuDhcRw++GfLqjYTt1kAiyCmJ8yNdbN?=
 =?us-ascii?Q?djHRcpa1K9gcYvwnDIjCOiZA2cOrRyEc6W1hrInLhumwtfHldYag2u4O57qE?=
 =?us-ascii?Q?wZcos+qTKoXOoK7TpsdETCmxRN1iuOuuKePdvyrSWJdFr8jVWPopsG5EHnur?=
 =?us-ascii?Q?StN32KF4epOez2WdtkCgY9XeFgy4ZJ1q?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o+Rqd/n+JVlzLRG3CJmxW0Nxkd4dhn6Erh5r+smnPH1WnMnWvePuSPrhZYfx?=
 =?us-ascii?Q?OnhiOpLARP0Lt753rW/yMLyS2j8nz79MFYAPI39lgSdSxK6odk8hyeLSzj2s?=
 =?us-ascii?Q?sxuuYomaf/Gqz0L8guKxX3uE5ARvHaZkJeKjRU2C+zV7pMJTgwr1xaWO91Ek?=
 =?us-ascii?Q?rOGelnjbrud3jfoNXlh8SREprlUwcFdyrHrafFKrizZoPWU9CgXT3cFbgKv8?=
 =?us-ascii?Q?8vzgP8vfgAYpjowF5u7gGxJs6T0Tni2kG/4yW1GA6NU75gaUWZa+80GUSnDo?=
 =?us-ascii?Q?/NFvg1UPQx+Xaqj3yzK3eTa68miGugxNstEIgKy1hwgAjNGnqEVaGQOnwbPF?=
 =?us-ascii?Q?QiehltZvbYGrMEGfqFuCKVjiS7iRrGMz9Wp/IJFeZC8yhFY6/zNjPTiHEMwL?=
 =?us-ascii?Q?QAkh1FkuAK5XRyF0PTWTmWrSwVEErKPmLKrURAeWX4yIdq2qdwYNvuBt0TCZ?=
 =?us-ascii?Q?UBwLsxGXxrvZENe+4RkBlnH313ReVvjUUAzIpv2RfelrZpIlLQs7DVAJdTF0?=
 =?us-ascii?Q?2fZkmBUIOBQ+8KhYQQnvowP1+0mk7DuwdwdODf/1ac0eML0J5AR2I2+Enbl8?=
 =?us-ascii?Q?IDWIzSA3anNNkU428U2u0VX+SM9SsdVgzjKH1XsogUZR2RmlQAco70sjIqHD?=
 =?us-ascii?Q?1GwtkQWndj6D2gpHAEBEUiYjHt6UX1Z6V2Gn15vxESiZ/+LAGuWnN0OWq2AA?=
 =?us-ascii?Q?kLDuEVq0re5gWR6Z/RkAmzox2eVd+Gyf55NpCOcI7/5rSZfcQ2X/I4bTkTSB?=
 =?us-ascii?Q?iS05GskKK5t7+7qroWQc7zasbipH0rtvr3G32MKQw7hiJf5xLJY7ROVIhWQn?=
 =?us-ascii?Q?f2ccaEsejT2Kmh+QK8bEK0xrqE6qOtnxjl2QrC9Obq7rut4gWsW+2HrwOcRS?=
 =?us-ascii?Q?td1/SxBK+VdehN2eGNT7Lp5979Q0yRaE1QFDm5FFFqdj9RDm2m/yqnrrWBK4?=
 =?us-ascii?Q?Em4lJ7aJktRtIRI1sEa6ueRs6szYOVVGt0+ADM8wkWUw4r04nye1fX046A18?=
 =?us-ascii?Q?8wHWvb9NfsgmdLm9veKDD0qoj317+V2SF1H5Vs2rwYlb1Fd3fBwoXJwOW7XK?=
 =?us-ascii?Q?/m285MTT090lidn5a6Q7yikK10GibJ8BXlkltRHUGFPDfAoG38UHeTlROb97?=
 =?us-ascii?Q?szYn7NJWX1dCA6yUYVNY7EimcpDUWpffB7vjVT1RE+Xe7y6dbETI8CFC4Y64?=
 =?us-ascii?Q?Jc06Jy37+vjOYhmR0sDzOXkLVkD/JaTh/+qiTxEmJlFWMqthUEVB3sVH2iK3?=
 =?us-ascii?Q?VupohM33YNAKUnUOy//7gaDjsGDyJk3f2zRN9HwUaB1v7HfnZKXRDBLqamSD?=
 =?us-ascii?Q?UzXpNlOjvM8CbzVWoIjNm5c8i5gk9KP+Q8AkhKkC27uaZQsfjqjlhTrAdj3X?=
 =?us-ascii?Q?WRGpUlJ3NaeBXss5yKN+kAf31bHxXonhwXvM3iSpM7GxNSn4TTYr8cNAwku/?=
 =?us-ascii?Q?UQKv1x0XI1vbybAElawfZqeFFxr8OViPNt50VrlqVssgpQEp8zOVFKbrrqD6?=
 =?us-ascii?Q?8qV2saNcHwmSE1XSfsPE/EelCaAHi+Aoh4KMKsw2EBnLVX/6ZvWpy995gjOt?=
 =?us-ascii?Q?jTMQcd9iz0EnBqNmjEQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0e6e89-93dc-4f63-19e5-08dd3a987b54
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 03:54:33.4981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cH1jwlRvA2XfWZYS+9VMQqzpoLxTP7OYUau/HjuC1jxw/jHEreEKeimx7QfWea/3RepeYaThZ3GY4Vv9T8OebA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5960
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, January 22, 2025 11:45
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm : Mark MM activity as unsupported

Aldebaran doesn't support querying MM activity percentage. Keep the field a=
s 0xFFs to mark it as unsupported.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index f6b029354327..83163d7c7f00 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1732,7 +1732,6 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_c=
ontext *smu,

        gpu_metrics->average_gfx_activity =3D metrics.AverageGfxActivity;
        gpu_metrics->average_umc_activity =3D metrics.AverageUclkActivity;
-       gpu_metrics->average_mm_activity =3D 0;

        /* Valid power data is available only from primary die */
        if (aldebaran_is_primary(smu)) {
--
2.25.1

