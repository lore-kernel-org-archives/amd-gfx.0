Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCB4CA1016
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 03:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3F4610E057;
	Tue,  9 Sep 2025 03:05:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="405FIVt8";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A1B610E057
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 03:05:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wedGD5FpSo4C/aP9FhwHpbxWAnQ2EXcVV1ZvbAfhc8B/O4Cgv/ABaDuSYbiehr7ozkrC02ChDjYKId8o3Njn27f2JInpKkAtFYXsLiGRc52KG7EHoMiANqAMEL7yLeI+P12NQdamlvJ/OtPArywnHvPHpTRb3nN7h8HUoWKj7ndVs5gdmi/LNpS5TzqA7EBTsTL+b5k1Bs6iOwVCr3vXQBuAhqEgWvyS/daaLckNLFe4fuAkLf+ggUAVGPqCY7hNLOVg0hXkBR4YNFLK4oRHAKn6tSWx68q2xbBD/Uh8s2E7frUkpYRZUr+aZeDlOCKBieEC5SkcaQ21kpagsJ+gbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwvKt74deTsz74VYci4ScVm6QC+B3O6MH65q4LLpfFs=;
 b=x+jlHbBL4dblt3CEGiIt88ZfTkmANYuPQsGuXANfpJ60FlLSYqjOEfusH0w6JawJA66yJyL+FhGvOv0yDnQvWB4TxrRjGNXkyjmrlkTRXdqSwRuqXgNBtQVTtlNIMueZbdGukfyR5rxWeKfiPhFPvHTCVDeTU5PhW2GpsuJFbdd9lnG5v10sGJgupGGG1mrzpsnr7uBbQZWJOySdNKnQ+tg5LdygyQ3uOWWGsel4srH59I7e7bJk3W+LUo1XMLDuFhi/ZUPwjVIMwXyqwKoEDltkYbtjoDtoxO0dW/trKDhSuLFmCHHvW8TjOt2ItOhdnSIRKg8PkhrFPOEcHJ0CbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwvKt74deTsz74VYci4ScVm6QC+B3O6MH65q4LLpfFs=;
 b=405FIVt8eGo5w3p/fIFQjDUpZPSfoZOqRgULfxHPTRD25tI70iPSB7SFZIt/3hGrcfwXG5a3M/ZwKMpJx5mBFkgilZvU8cDChYNROQvvhrXhmtKzJR4+uemIYGTYWiCCTizrw/lx9iOK53rrSuWRHtJAvws57innpf1H0uCZOGQ=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Tue, 9 Sep 2025 03:05:09 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 03:05:08 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: Re: [PATCH] drm/amd/pm: make smu_set_temp_funcs() smu specific for
 smu v13.0.6
Thread-Topic: [PATCH] drm/amd/pm: make smu_set_temp_funcs() smu specific for
 smu v13.0.6
Thread-Index: AQHcITB5LbJGK6SqKUeaOPqgiDYKbrSKKmdJ
Date: Tue, 9 Sep 2025 03:05:08 +0000
Message-ID: <DS0PR12MB78045814DF5FE4A2247B2534970FA@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250909022110.2695284-1-kevinyang.wang@amd.com>
In-Reply-To: <20250909022110.2695284-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-09T03:05:07.5184514Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|CYYPR12MB8729:EE_
x-ms-office365-filtering-correlation-id: 880954e2-0e45-424e-fa4f-08ddef4daf38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?496r3MJC6hNj/J2IGkIDd6lsFif3yBDyspSEIUImHWkGqHy3+lumMfl9qCS4?=
 =?us-ascii?Q?OFqfmUlR8yOmup6NXyMsW6pV/WOOIamW0uQbg4OKZ9tTV2GjHrejzZxdXoT9?=
 =?us-ascii?Q?HyaG3rkxxnazHxxKcuN3R3fyH4BGOmOtouJtuOzXWV1nB6UGcZieHcHC7Ra6?=
 =?us-ascii?Q?qaMxJGXKdvDyKSZkXAypk52QiFaml/ba+aytHk75Imqhm9quyyIlPPuihfyc?=
 =?us-ascii?Q?VXzQU5WW878Et/unckbRCIpJrhZwp6pMVSFzCXrcKR7qspkQF68jX40Iaq80?=
 =?us-ascii?Q?SbibQB9H5K2E/8Us0/XR7VS39Hvf0kSf/mGLVyakrDHgKK20dQa8snE01Q15?=
 =?us-ascii?Q?i8N0pcwNpyfXtFNc2uTHA5p/UQ6QYPQMZdo57zyJqcwWSmS0AXwEUvXWhAHy?=
 =?us-ascii?Q?lkpoenVvcYXfVFsn9/WefrUEf27JxRaBj56HSeivklcdvcEYN/+0xpJqz/aE?=
 =?us-ascii?Q?Yjb3ik3NFuHXD8dVk80fcfrdN2lhDufVShgE4GrqChc3qWac76+3YtIVB2hm?=
 =?us-ascii?Q?7M+K14AnF2Gk2fr1JbPkaK1glI3/OSJGdz6FFyjmwzqkt73uLo/FB/p5MfYg?=
 =?us-ascii?Q?Ziva0Wi3MS6Td3X01PC0o4o2pyHJ0LZRwOjzlZxbaMEgEzekci/dKjH8cmGw?=
 =?us-ascii?Q?QtJSxPn+46k+yjtadzvGycakTq86uvDOpdwzxySePs0Vzs6s5aZR4jZl83+2?=
 =?us-ascii?Q?MFUEIRisRS5bxKmh1sPP3Hv7y0bnmwvkgbyiyCOJ/5aFYjfx10/T0WhJnL3C?=
 =?us-ascii?Q?UFHY2vIwFAfpDjPnh9EEvNxeyzZ/7fEuXx+fC5r0y8bvP5Ay6nv5S4MpgbdP?=
 =?us-ascii?Q?94F6RASMyCVn2kpSkDVtNhNX7b1IZ1l6LCBWsccoazOcUljlGKcbmNBrehMo?=
 =?us-ascii?Q?F8tQ/9W0jgHK/Q2t834tZlabHkcYLAm1ocsnMIgiMVdOTb277VXPBCEwSx8m?=
 =?us-ascii?Q?V8OUvYEy7btwjy9tu97u0B/Kj39HjYU1ps4qi8QzOzeE5GQJJzPKrKbccBgc?=
 =?us-ascii?Q?vjSEiK94IBIU+fYrEFgUp2dLX7n/StXXBwN1pgKo2PxtR9X6df25LRvdohIW?=
 =?us-ascii?Q?/IGLwRorkfdz2OVAibm8NSJ8NolXBi+hRRtkHUEO0vIk9Y9dxd9CkDNP5KD1?=
 =?us-ascii?Q?tPD+0y9RZjQporRMQfjrLf+s0VMF/hBjm5pEUjJJeH47CnFOxiGMlmALVBFO?=
 =?us-ascii?Q?eD5D1ZyYt+PERQordGP1uXLmI7+NSo6EozuYHP1geNkkYjq8SE0UJRNX2Wnw?=
 =?us-ascii?Q?rzO97NfBmr2NUloGMMe1UoyEJ7uIho3349KTQFcUHOzQJ3zmAQ04qZBYCm66?=
 =?us-ascii?Q?wyfy/A/2vztcqvqCrFk2C0IUptbZFqkVc2QEf8RiaHE5ZGt1HO61EcUFkdz0?=
 =?us-ascii?Q?2MEkeEtB2rFuMjBeDkfXtslh94itkq43yLjfziHbbLv0+R2oLERC9Swy+fua?=
 =?us-ascii?Q?Hzq5ghyOiYSyiKIwp4+SV0Mm5JMvbJbTrIsuGoR5y9xDErwE+07Bu1y5KC7d?=
 =?us-ascii?Q?+c5K3GxVOPt7gf8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aj3yDNMavK1kn4PZUkZokuznfE42zdEcIYoCGRmhqLR7Yw8kF4E0tPOmkmrf?=
 =?us-ascii?Q?qSMBnprAE0r4caoXJl5ZrYzmQ2fskL8PInBdQkdZ2oqzySPonC57KG3Xz749?=
 =?us-ascii?Q?NqKYt+4kltldWZpx7ZfUUEXXR/k857mJQ6bcITwn4SQe6piqZz4c2QXwgqTy?=
 =?us-ascii?Q?nK8f3UErWN77i7E0QqlzQa1dD7ZXNryBcKbV29OU+dME4JCY3NA7dD/OAF2Z?=
 =?us-ascii?Q?Tr7zUfbNNHdiJ/23w7LcHFQUSLbRHRaFYb61KLAV8hun0sN45tXjeJi8O//x?=
 =?us-ascii?Q?6M8fkMPE3Nby/vXdoINGCW4M0T86SDMyx73nynwTFfRGSMuC6RHY9ov/RM1D?=
 =?us-ascii?Q?RtGfCuf9dobnl4OAxtfMJVTP5VEqCvd9vMCYDBW/l33njRX9EV+YixoFhiPP?=
 =?us-ascii?Q?udRJhqj0BGg55U35JQR1ugn6JITVrI1ew+0z2F4Nv2MsMX1M0wE1wAY1O69/?=
 =?us-ascii?Q?4tYKu/+5xScKZoub5Z4JNgM8in/StuZrU5IV/BMuh510PDqZ8Y5RGd8O2OfF?=
 =?us-ascii?Q?YeiRWnPt9UpYi73L+CcD8QxW9P5QyOhGlGC+66+PE4UQyHBlGxhtQm9J2vQV?=
 =?us-ascii?Q?hXvCG+nuARyuGHa3/iMtd0xd+A9zSB0EAj4+ppwoSfoLZddw3fcP9XVnaKuj?=
 =?us-ascii?Q?D3bZJKSY8byPryCP3IeBNQbQQ0Jh+FBvU7kfXtPEyrtLIbPZiV4yZqvyLrVc?=
 =?us-ascii?Q?cuZgOkGGsCu8J6DQUSpKy9VdcnDk/jy8hpme/KaPqWHAcINYHUtluN3JbHTb?=
 =?us-ascii?Q?N/yQ3caAVtkmP2hJg+DBAeghu7RSoN7si9K2I0W1TJ279tzSw0ywOS5RIw/E?=
 =?us-ascii?Q?OHEqZwVdxd8kifJCohGyn/AMzrEMB5YfMqFRzx0dvWqBXrxebIOJQ2pwTHfa?=
 =?us-ascii?Q?gbqUNX95KJ49H8qiY4ACRfTbB3jzkupkv97x7ko9yZNSLfFoK7MGBYfTB1I3?=
 =?us-ascii?Q?X1Qe+IYFkrNvqLNAWCnm3MjMDLGdciyiYqyZE/oSMOu113kckWXRSV7DLQT0?=
 =?us-ascii?Q?uGnie8iCGuG86rBkOBagKcyofvvj9ZFFTA8cUJdLOzU71YhNQR1Q/tJ71vsd?=
 =?us-ascii?Q?0JGlzMf29WyVgbI7Wo38OuCSZ5ry8i94zj48sFkHQgr1mnoNUbnIN8naolXm?=
 =?us-ascii?Q?hJVcy2e4Ab8+wuDDsjzpT2IxzLybcdedmwwzz4UbSLmwOVhjcgQf9GebEJOJ?=
 =?us-ascii?Q?CIpOvURMW1UkRg028RivsO40XG6GXIeVslMQHTthIguVna3L9NqKaE9/lzVR?=
 =?us-ascii?Q?rs1KRH3aGhyBEv2FTisApflLuBeQn5jyd2Ld4lAAo4u7rrUpqIlzTQhdiwW3?=
 =?us-ascii?Q?3a6b4pjLGiGaCK+KzARIxkhpQSbTJINKqdJ5sWaKXozXBC69//eT738/sOpp?=
 =?us-ascii?Q?btvOGD54Ye+vDJTxmvdFkTqDXL1dKxkySS/pPDFL9rZXc1WrgUO/zxy3ow00?=
 =?us-ascii?Q?sAufzaYpZT6WzOUqyyfwCbd53K+Viha7HAxvDTFBxh7J6sKvjLNncQ/13s3D?=
 =?us-ascii?Q?GNoBVo6GJgicVWvDrgRAB2G3yXWD5Pvbq9EeCGff6W2cJBdGJfr3t1uv1UPJ?=
 =?us-ascii?Q?k8+cgegNEOjl/BV+DzMITnZzhJzAcyoR4GZW/XCv?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR12MB78045814DF5FE4A2247B2534970FADS0PR12MB7804namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880954e2-0e45-424e-fa4f-08ddef4daf38
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 03:05:08.7515 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BHcGo/6R6F8tIfswTy5RLIflOSk/Jdfluhu73kkWxostNOxoc2wW1JnwMuRQsFfb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8729
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

--_000_DS0PR12MB78045814DF5FE4A2247B2534970FADS0PR12MB7804namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

The purpose is to keep thermal related interfaces separate going forward. I=
t's not about this one alone.

Thanks,
Lijo
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Yang Wan=
g <kevinyang.wang@amd.com>
Sent: Tuesday, September 9, 2025 7:51:10 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: make smu_set_temp_funcs() smu specific for smu=
 v13.0.6

move smu_set_temp_funcs() into smu_v13.0.6 ppt.c file to keep same code
layer in amdgpu_smu.c. (only set_ppt func in amdgpu_smu.c)

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            |  1 -
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 12 +++++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h |  1 -
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index ae3f7f00c38f..b140f6fc50f6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -766,7 +766,6 @@ static int smu_set_funcs(struct amdgpu_device *adev)
         case IP_VERSION(13, 0, 14):
         case IP_VERSION(13, 0, 12):
                 smu_v13_0_6_set_ppt_funcs(smu);
-               smu_v13_0_6_set_temp_funcs(smu);
                 /* Enable pp_od_clk_voltage node */
                 smu->od_enabled =3D true;
                 break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 1e506781a470..e028046b027f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3850,6 +3850,12 @@ static const struct aca_smu_funcs smu_v13_0_6_aca_sm=
u_funcs =3D {
         .parse_error_code =3D aca_smu_parse_error_code,
 };

+static void smu_v13_0_6_set_temp_funcs(struct smu_context *smu)
+{
+       smu->smu_temp.temp_funcs =3D (amdgpu_ip_version(smu->adev, MP1_HWIP=
, 0)
+                       =3D=3D IP_VERSION(13, 0, 12)) ? &smu_v13_0_12_temp_=
funcs : NULL;
+}
+
 static const struct pptable_funcs smu_v13_0_6_ppt_funcs =3D {
         /* init dpm */
         .get_allowed_feature_mask =3D smu_v13_0_6_get_allowed_feature_mask=
,
@@ -3921,12 +3927,8 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *s=
mu)
         smu->smc_driver_if_version =3D SMU13_0_6_DRIVER_IF_VERSION;
         smu->smc_fw_caps |=3D SMU_FW_CAP_RAS_PRI;
         smu_v13_0_set_smu_mailbox_registers(smu);
+       smu_v13_0_6_set_temp_funcs(smu);
         amdgpu_mca_smu_init_funcs(smu->adev, &smu_v13_0_6_mca_smu_funcs);
         amdgpu_aca_set_smu_funcs(smu->adev, &smu_v13_0_6_aca_smu_funcs);
 }

-void smu_v13_0_6_set_temp_funcs(struct smu_context *smu)
-{
-       smu->smu_temp.temp_funcs =3D (amdgpu_ip_version(smu->adev, MP1_HWIP=
, 0)
-                       =3D=3D IP_VERSION(13, 0, 12)) ? &smu_v13_0_12_temp_=
funcs : NULL;
-}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index aae9a546a67e..4652fcd5e068 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -74,7 +74,6 @@ enum smu_v13_0_6_caps {
 };

 extern void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu);
-extern void smu_v13_0_6_set_temp_funcs(struct smu_context *smu);
 bool smu_v13_0_6_cap_supported(struct smu_context *smu, enum smu_v13_0_6_c=
aps cap);
 int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu);
 int smu_v13_0_6_get_metrics_table(struct smu_context *smu, void *metrics_t=
able,
--
2.34.1


--_000_DS0PR12MB78045814DF5FE4A2247B2534970FADS0PR12MB7804namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
The purpose is to keep thermal related interfaces separate going forward. I=
t's not about this one alone.</div>
<div id=3D"ms-outlook-mobile-body-separator-line" dir=3D"auto"><br>
</div>
<div id=3D"ms-outlook-mobile-signature" style=3D"font-family: Aptos, Aptos_=
MSFontService, -apple-system, Roboto, Arial, Helvetica, sans-serif; font-si=
ze: 12pt;" dir=3D"auto">
<div dir=3D"auto">Thanks,</div>
<div dir=3D"auto">Lijo</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Yang Wang &lt;kevinyang.wang@=
amd.com&gt;<br>
<b>Sent:</b> Tuesday, September 9, 2025 7:51:10 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Kamal, Asad &lt;Asad.Kamal@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: make smu_set_temp_funcs() smu specific =
for smu v13.0.6</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">move smu_set_temp_funcs() into smu_v13.0.6 ppt.c f=
ile to keep same code<br>
layer in amdgpu_smu.c. (only set_ppt func in amdgpu_smu.c)<br>
<br>
Signed-off-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 -<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 12 +++++++----=
-<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h |&nbsp; 1 -<br>
&nbsp;3 files changed, 7 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index ae3f7f00c38f..b140f6fc50f6 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -766,7 +766,6 @@ static int smu_set_funcs(struct amdgpu_device *adev)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 14)=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 12)=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu_v13_0_6_set_ppt_funcs(smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_v13_0_6_set_temp_funcs(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Enable pp_od_clk_voltage node */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu-&gt;od_enabled =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
index 1e506781a470..e028046b027f 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
@@ -3850,6 +3850,12 @@ static const struct aca_smu_funcs smu_v13_0_6_aca_sm=
u_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .parse_error_code =3D aca_=
smu_parse_error_code,<br>
&nbsp;};<br>
&nbsp;<br>
+static void smu_v13_0_6_set_temp_funcs(struct smu_context *smu)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_temp.temp_funcs =3D (amdg=
pu_ip_version(smu-&gt;adev, MP1_HWIP, 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=3D IP_VERSIO=
N(13, 0, 12)) ? &amp;smu_v13_0_12_temp_funcs : NULL;<br>
+}<br>
+<br>
&nbsp;static const struct pptable_funcs smu_v13_0_6_ppt_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* init dpm */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_allowed_feature_mask =
=3D smu_v13_0_6_get_allowed_feature_mask,<br>
@@ -3921,12 +3927,8 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *s=
mu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smc_driver_if_vers=
ion =3D SMU13_0_6_DRIVER_IF_VERSION;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smc_fw_caps |=3D S=
MU_FW_CAP_RAS_PRI;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v13_0_set_smu_mailbox_=
registers(smu);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v13_0_6_set_temp_funcs(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mca_smu_init_funcs(=
smu-&gt;adev, &amp;smu_v13_0_6_mca_smu_funcs);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_aca_set_smu_funcs(s=
mu-&gt;adev, &amp;smu_v13_0_6_aca_smu_funcs);<br>
&nbsp;}<br>
&nbsp;<br>
-void smu_v13_0_6_set_temp_funcs(struct smu_context *smu)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_temp.temp_funcs =3D (amdg=
pu_ip_version(smu-&gt;adev, MP1_HWIP, 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=3D IP_VERSIO=
N(13, 0, 12)) ? &amp;smu_v13_0_12_temp_funcs : NULL;<br>
-}<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h<br>
index aae9a546a67e..4652fcd5e068 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h<br>
@@ -74,7 +74,6 @@ enum smu_v13_0_6_caps {<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;extern void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu);<br>
-extern void smu_v13_0_6_set_temp_funcs(struct smu_context *smu);<br>
&nbsp;bool smu_v13_0_6_cap_supported(struct smu_context *smu, enum smu_v13_=
0_6_caps cap);<br>
&nbsp;int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu);<br=
>
&nbsp;int smu_v13_0_6_get_metrics_table(struct smu_context *smu, void *metr=
ics_table,<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DS0PR12MB78045814DF5FE4A2247B2534970FADS0PR12MB7804namp_--
