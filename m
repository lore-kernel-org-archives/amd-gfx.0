Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE85C88E77
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 03:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A72F10E091;
	Wed, 16 Sep 2026 03:18:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ns8Al/29";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010045.outbound.protection.outlook.com [52.101.61.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C273810E091
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 03:17:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNn7ekqokT8JYkeRxH90bCfLYyCRvPhW2L8bsP5tA4Be6zYVLM0AwIYBfe6GMTJPSWTRHiqGqIuKAX+M3w/kD84l+314607OSfKjYbc1CMOoXfHU8oHA7PNwTklfRF2v8Mw3SYhUlxtrwilsaT/0A/uJl1c/KVX6n2kJAYUmt7fwyt2WV7shQxE334LOJux5FXvPuIZkFMKwElGrr04WJqLsfqLK/s39zde44nd9Prb4CibIkU6JnGrdr9fknXwvFrWPBtxDcXqahNzF86HXu4HmFzblmYjwugQL4sbVwJinS+H1B1Nj+HNQX3jpYgsPmzRWr2x1Uh5oxmFV52W1Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fooGo1bwIyS9a275rBAXXQ19oMn2x2/hQ3noWptwr4=;
 b=RzV3OB4xYE00zsau5OWGaUIHhM+LHzuLWuS+D/Pu9zWczTQo41gcYJNHVzSK+qNnz/eOZrKR7G8SQPScgm5wvxRCu9F3sPGnYEy7bb2ICiVfmNO5WeQwqenWoqLfaTdJs24Y/TzYUw9wLa+1ykJBKMsnm+cnVNNMTsUb2wzKrEPH/OcOh6fyjGlP6XQFpq8a2Agzc/HLG9nfyAqL7QqZs36WzlLvgQ1Gh9APqjE5O0e1mcBph4Bj9flN2souuS3ujeA/g2UkisKSAdbpMCy95MOiU5GvR5VI0nvf/4LACtTsPeLPsHKrOR+XcN9yFTLhn/CQQQMOrEyOGqeJU2rQGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fooGo1bwIyS9a275rBAXXQ19oMn2x2/hQ3noWptwr4=;
 b=Ns8Al/29KfNwJz91XX+0wkqi9Kp+YJPu469M92sTYFGRZElsOr0cWfVlJmV/Egssh3NGhBEmaRnhAu1xI+ZkPDBKSTSime8Rib4eU3jRFsVycWnm/M0IYRwj7ufoYSuLOrL6zHgCUqV7h+Fj1MdODtud3yDQvOTwdf5TrbSeZx0=
Received: from CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5)
 by PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 03:17:54 +0000
Received: from CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85]) by CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85%2]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 03:17:54 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>, kernel test
 robot <lkp@intel.com>
Subject: RE: [PATCH 3/3] drm/amd/ras: use __le32 pointer type to resolve the
 sparse warnings
Thread-Topic: [PATCH 3/3] drm/amd/ras: use __le32 pointer type to resolve the
 sparse warnings
Thread-Index: AQHdRONn57yDOpFZn0ihwzBPjPPW5bbQig/A
Date: Wed, 16 Sep 2026 03:17:54 +0000
Message-ID: <CYYPR12MB87293815BAB46BE21DE8682EB0B92@CYYPR12MB8729.namprd12.prod.outlook.com>
References: <20260915072432.1751101-1-YiPeng.Chai@amd.com>
 <20260915072432.1751101-3-YiPeng.Chai@amd.com>
In-Reply-To: <20260915072432.1751101-3-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-16T03:17:35.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8729:EE_|PH8PR12MB8431:EE_
x-ms-office365-filtering-correlation-id: 8b9cc303-ff98-4200-4450-08df13a11925
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|38070700021|56012099006|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info: 1V23EFg4TCwrpFHnhPcIq5Fo5j9+1XCQ+3rsmvamCR/TX6oqH/45faLa4ZF4LK+H4D1NKtDQP0DfIU0rxM8geWUbO9EI3s0T7a+bxYuJ3F0buyISqjXTU5Y+FAyKDH1beK3pNEqP1cZxf6nsm39HY/1NFrO5Rcx5LmVLgJSfmuUfFZN1hfHU8apShIc/rDCE/y7nXca3calxO8xrJ0yO5W+kVrW0iq++Zs/HhWxqQ+iTL0X88OJlXqR3Xr097ms7QUt3ZaW4AXJRFfhQYtJS2cJhxdCDK20OAIoJj/39h4n//wB/GtFdp7ANWEQ91lH1VjIWGTsnWO14Ld5CRGdI5MV0C7QvH1Spg1bhbDM35ZiYnUQY8rJaNkO2/kY7t01/alAjDf8282yUC9qilNiiqdU/L5AcgP1vS4L84YC3oWK3XD+ja3bfFkLJGB10t9V/XZGKKVNlQQQ/S91d8Z98PzEL2ZvTC3cPXg3t7XXs5FdeZGlgDA+Dz/yr/1M6J36kB43i2Gc1tpjMov/5ccbkimwR7b3PiG8D8Wl0cKknjvuim5umQaw11j9KoQk5GT+3O9eOHnoVn+Nek3Hmz9Kid2/iGlgSo596yEpiMeFLpNamWh2TXFTy/BOydxL5MbHjB0B/5vPZqd6nv8V8Bd51MCtHoBU5lSXMuwSMP0p8D4qCgqK3i+6P99RHPfYTbUouF9aVI7XiUA5Q3kEEUw5f0Xy2Tc9TxOXq5l1Bb77syyw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8729.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BL+YPsLJJGQcrPtS/2rMiBbOZEy6xhSv6gglo+mWiDPpNpt+IXHq/W29+ZGw?=
 =?us-ascii?Q?ee4+FHrJ+OBcwJ8+9q9vawm3C98ZZJ+7syA/y1BbW/ODd/1GmbDReM8wC+a8?=
 =?us-ascii?Q?u/BQYg88ySd7GYjICjbr9cqZJyI3g+E5oiVUZLxvT2UFLoVJsvaa/SVErHGJ?=
 =?us-ascii?Q?a+jiumTajKcUZUpY+YMjVoD903FA52NcZ6kx09MOSvhwZilsV/e0Z+uNR9db?=
 =?us-ascii?Q?ZGlQ6Y+PCweq3nFfpyCo01/y52eguMEijcdCTsLwxTbAlJ6X6hLCtAe/cntr?=
 =?us-ascii?Q?t7eAuFs+XZ18QrIZHLMo2D4PyN6Er+Zvg8l0SdUjBUi9N0hVP5Jia0fW0Bpq?=
 =?us-ascii?Q?uISb/W+IMJY5ziC81dL8yoAWoa4wOlug1Fjmoj3y8eTsOWs/57Iz78ghtOge?=
 =?us-ascii?Q?b0k/Cwi7C3WcYw8XWA5jnekvJYy/eSvndUI8KOwmIScWSsUgQ5M9V0dVzxMh?=
 =?us-ascii?Q?KqEz9NR8H9Ps0Bv/yYVQRnotcWRyPvaHRVB4DTFVmNeCjB+lQT67kWlH5BbD?=
 =?us-ascii?Q?J2931+Qptea2zI4byPulEBhD4ky868gepiSfDcAwCFajiNc5gzBHrwU3pcHv?=
 =?us-ascii?Q?jOJ05LU1vSX0QNd8aZtHF53uLxBEyW48/JYaVRSFs+xzHhgcBjsN7rS/tsy9?=
 =?us-ascii?Q?mwLtKEHEznNBmGt4SQY0vY1gFEI+UX+mkTf1jTw8W4l5/4UAcuZkCtPWCHQN?=
 =?us-ascii?Q?7RV4P6Kx+dkMqfmsbEvk5Qh2PjkPqz2fVlafH/qKU6fYKbLIML7ny78TLoUI?=
 =?us-ascii?Q?ESZOxyXN7qoI6N2879kTTEXaTrBaUDuKJmDApJ8P4BpT9NjZMTcR7hy5WNVY?=
 =?us-ascii?Q?Y9Y3O+5uf/4ccPSZ1iYiZphk9uIODXl++mlXS2/mNUEfxTVtcna8c9lrw6Lk?=
 =?us-ascii?Q?gING9GSrtfqNNqJ8dLTq3A0OWFkKpidXDaWqEmY+IcZZepeABcbzQJRccMWZ?=
 =?us-ascii?Q?Ut1kOQM9T+hj3poG0wt2iEb1uFmTCRo16Cl7yUhYremeu6/jGGva1KTIi6Ks?=
 =?us-ascii?Q?+j5qqvVXWAVD+fybx2pk67mFKl+GxPcs2m9CqNWg71g8BZ0TCkpHyYduasu0?=
 =?us-ascii?Q?me4uqNeLGtQ43mouDJ/N1cLxzkqH89vE1DrczR3wfMOyiK/Po5ywyMdPXZD5?=
 =?us-ascii?Q?U7BitlD3Pno+09fLWxCgCxKSYVzXxgs8GwgWfJJe/uoDRl/y5CxqLX/ubLW3?=
 =?us-ascii?Q?xUh61OyKYroGrb2So5vTK7QtHzpbSKhcIei2qz4PcaXUMMw6IFv5YiSxaBhU?=
 =?us-ascii?Q?rYfs4R6vEzwX98+u6oMJR7YTSlwEMxIWFonovdjvpSecTKcycw5GgzpEPDu6?=
 =?us-ascii?Q?haaM7W0QcGKLdMh1vdv3fVFKzQ5+8cuoVczZPRsYKBAZyycprXFaQMQNixp0?=
 =?us-ascii?Q?WvYz44kt7MpL0B34zcSPTc4cV8Uq0/fDZ0Etjjv2g9w5Wu16Up8sf5dxSiLP?=
 =?us-ascii?Q?ytfTk6uc37vjf3l8LAAWONqZ1x9Mg/PjlcEFAa1hcYLTIyj7e7PhKgi5Xzx7?=
 =?us-ascii?Q?2GJMwlaE63Vem4ZDWgHZz3liZA6y4amlaDpANxzAqbVBWfwOGGmqIH8co5dt?=
 =?us-ascii?Q?FTcKGcKJ2lNEuuMgI05Ar/McGcyV6JopFIaS4PzhsBtwYrPVPM1UL9XdzmQE?=
 =?us-ascii?Q?o0DtcH38w5hNZ/hgyjivnOn/3GVNG7TYT6ah35iIUyKSqZ74yUFm8jDm1tQz?=
 =?us-ascii?Q?qsnanfz/+x9rOrgL4ZoPYNi6JugYAiOVJb0vr5PoyWdPfrjG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8729.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9cc303-ff98-4200-4450-08df13a11925
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 03:17:54.2227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gJWjm3E2huWfCgAcIOBZgoWn6pnO+q4C7iUHNN2XqhVmj73S7P7ZcVe9rL3UuGX2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431
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

AMD General

The series is: Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of YiPeng=
 Chai
> Sent: Tuesday, September 15, 2026 3:25 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; kernel test robot <lkp@intel.com>
> Subject: [PATCH 3/3] drm/amd/ras: use __le32 pointer type to resolve the =
sparse
> warnings
>
> Use __le32 pointer type to resolve the sparse warnings.
>
> sparse warnings:
>  ras/core/eeprom.c:275:15: sparse: expected unsigned int [usertype]
>  ras/core/eeprom.c:275:15: sparse: got restricted __le32 [usertype]
>
>  ras/core/eeprom.c:277:15: sparse: expected unsigned int [usertype]
>  ras/core/eeprom.c:277:15: sparse: got restricted __le32 [usertype]
>
>  ras/core/eeprom.c:288:33: sparse: sparse: cast to restricted __le32
>  ras/core/eeprom.c:289:33: sparse: sparse: cast to restricted __le32
>  ras/core/eeprom.c:290:33: sparse: sparse: cast to restricted __le32
>  ras/core/eeprom.c:291:33: sparse: sparse: cast to restricted __le32
>
>  ras/core/eeprom.c:333:15: sparse: expected unsigned int [usertype]
>  ras/core/eeprom.c:333:15: sparse: got restricted __le32 [usertype]
>  ras/core/eeprom.c:343:15: sparse: sparse: cast to restricted __le32
>
> Fixes: d95700604fbc ("drm/amd/ras: rename core ras_* files and update inc=
lude
> guards")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202609101657.kczNjTnY-lkp@i=
ntel.com/
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/core/eeprom.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/core/eeprom.c
> b/drivers/gpu/drm/amd/ras/core/eeprom.c
> index e7aad113b98a..efa04cd8fbe0 100644
> --- a/drivers/gpu/drm/amd/ras/core/eeprom.c
> +++ b/drivers/gpu/drm/amd/ras/core/eeprom.c
> @@ -260,7 +260,7 @@ static void
>  __encode_table_header_to_buf(struct ras_eeprom_table_header *hdr,
>                            unsigned char *buf)
>  {
> -     u32 *pp =3D (uint32_t *)buf;
> +     __le32 *pp =3D (__le32 *)buf;
>
>       pp[0] =3D cpu_to_le32(hdr->header);
>       pp[1] =3D cpu_to_le32(hdr->version);
> @@ -273,7 +273,7 @@ static void
>  __decode_table_header_from_buf(struct ras_eeprom_table_header *hdr,
>                              unsigned char *buf)
>  {
> -     u32 *pp =3D (uint32_t *)buf;
> +     __le32 *pp =3D (__le32 *)buf;
>
>       hdr->header           =3D le32_to_cpu(pp[0]);
>       hdr->version          =3D le32_to_cpu(pp[1]);
> @@ -315,7 +315,7 @@ static void
>  __encode_table_ras_info_to_buf(struct ras_eeprom_table_ras_info *rai,
>                              unsigned char *buf)
>  {
> -     u32 *pp =3D (uint32_t *)buf;
> +     __le32 *pp =3D (__le32 *)buf;
>       u32 tmp;
>
>       tmp =3D ((uint32_t)(rai->rma_status) & 0xFF) |
> --
> 2.43.0

