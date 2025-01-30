Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28BAC0218A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 13:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 595D410E050;
	Thu, 30 Jan 2025 13:48:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aLk0yXBX";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7436310E050
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 13:48:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIQfraeiPAMmXILsmtAywB5qOcu7gQj2SPUcAl+7MM/G0eGMa7atEsiBSBPA0PBq5oD4P6D2u7UBaCDnGnuWtAWPfshGRSGUKRjb2coZkTi/bYcZqMDiF1F4dD7DdG8oRNRm60tW359Gozs/a1pWsuAQRT2mXxlqhyJtLZ6SaPaWvBpUePwmzylFyXkw18mnpPTDLl2etXgXpbwU/BIKuVctfWKZmDNHBrIZM3Sa/izhx7rPX77MpdrkmWkKYmZ/KY3oM7vFWfDS/iD8QfuwFoNJ19fsbKSrvBDxM3Wq0Nj8dx3fY3LxqAyyrvZPE2XThcKDv+EJPXG6UKM13c9Tjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZgxYP9IhmDiUi9bL3fpEnu9/k8DSAyTDZpISYcAp+U=;
 b=gWutc+wwaDmLjahZiFrbsb6E5KxR1N/M18LPMwIskHojWc6MHbHbsxEGxQMWUWzSMrgEnMvah4YXlJh+pW8luwoRRKm5MDLO8GL+8RO5H7ZfJCtT1VfEpyu07Vqn4HCKvUdftl/3qq5wkCS1EoNSNBfUUtCIpWOZZtDLaj/ijlg1VywI0weMf/tnNHFtaGpTUIl67rootLV+RbJLo9mfWbVoCjUST7Ac61JYWLpX07IogI+4tHC6DJ6A+O5bezu3IuA6yrs4FzHDrJJDI1HDEswWYeZWRxM0t53rNFHkKurwKxa3SfRFI8kTDEkhjXVEQsaXrF36WqXkYycfxr8N1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZgxYP9IhmDiUi9bL3fpEnu9/k8DSAyTDZpISYcAp+U=;
 b=aLk0yXBXQVcZfKePALy9gXY+PK8Pxq4jAtfVyAZiPfqCtYboJlpEn4fhuD5BiybdR9leQsFxLgVMmZpB1sM1dkUGlTmPPvoKnr3FB+BotfiPt4njL2Sitw+dbvuPdZm4EiAFeCrDq8rJAA5D5Py/DDeBKztERhX82JlGfIQ9yTI=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 IA1PR12MB8222.namprd12.prod.outlook.com (2603:10b6:208:3f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.24; Thu, 30 Jan
 2025 13:48:00 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%4]) with mapi id 15.20.8398.018; Thu, 30 Jan 2025
 13:48:00 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH v3 10/10] drm/amdgpu: Enable devcoredump for JPEG5_0_0
Thread-Topic: [PATCH v3 10/10] drm/amdgpu: Enable devcoredump for JPEG5_0_0
Thread-Index: AQHbcvzx26/QoiCYmUSD2JQtDaRo6rMvVOWg
Date: Thu, 30 Jan 2025 13:48:00 +0000
Message-ID: <DM8PR12MB5399804C93DC3748567CB38DE5E92@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20250130095113.534630-1-sathishkumar.sundararaju@amd.com>
 <20250130095113.534630-11-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20250130095113.534630-11-sathishkumar.sundararaju@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c3cac35d-40c1-4348-bdce-3a8c2d25ce37;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-30T13:47:00Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|IA1PR12MB8222:EE_
x-ms-office365-filtering-correlation-id: e1be801c-b347-4970-4033-08dd4134b600
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?eqeK+os6tgYAB/mPXeYLIHPEa3nvH7dZKz8Brn49xXEu8FGOmvMUbeL4UVir?=
 =?us-ascii?Q?x7jMn7pmBojANPSDqeWvk8tUcL43sIPEqZhiqPwMxYalVfpgMrl5xVzIkzTB?=
 =?us-ascii?Q?7uBeRCtZaklrvyhey2FS1fO3nEYv6EhKLIN+eXKm++Hs1tr+Jt15fsf3HW9H?=
 =?us-ascii?Q?3ucU+8tstfmS1Y2h3JgzpbmlB+mRtCl4ektMlOP8GEj9vqRwLm8p4k6I6D/f?=
 =?us-ascii?Q?zo0fKNRv6LmHysV22fgyOykWfBLjqHlEz71qCnxa71GLSogwMo7nE6saY4/T?=
 =?us-ascii?Q?xcI5qvsnXUGUsHbopeQABTXvnHdz8442Re3g+mghNaQWaAklIX1NV4PiYiJx?=
 =?us-ascii?Q?f25iWtV79mH/fgTcGsLUOIqN2uaUM83B0YzdHm+bjF4THFpXPn3RStNpwpg1?=
 =?us-ascii?Q?8AcqjeT/78qr75Pgmcm9SEgv++hEzZfGb5MEqU9c8Yws3JybHRw3p+qTcWC/?=
 =?us-ascii?Q?74yOQdhVmb9WrKTrg2eOWNSNl0OT6oDeXRVGw4Szd7Gva+pu6mVKamV3eXEk?=
 =?us-ascii?Q?xkuQPta64ro71/Ro2SCVN3nDlKFczoj1WXsiP4h46sbRD7cOc8yEeyLf54dH?=
 =?us-ascii?Q?O1wmg6YP04Jdv6MIGAIl1COBpHK5alxf+HBCl5bC1O8UdrCbwsA00FaL75jS?=
 =?us-ascii?Q?5jKiTflX7hWHV44YFgl9iFZ0XUZlqTEIoJ7ye3r+CqX/nXxzkByx1qsPBdMZ?=
 =?us-ascii?Q?DZG0R75zd8/Wcp8mCLHnjkYRzgXACFvVcEnlSLevDWWVCg1U2o//krClbTlc?=
 =?us-ascii?Q?nr5TrgxGX4Mp0Xz5ecEXieb14M983IbZHlop6ThFlTeaL9yfuRiiiKpjYxPw?=
 =?us-ascii?Q?hxn2z6GFCfU66gREDzBVBlt3W/RmvpqY+IvnpTeptXf6UyP1LIvcLOWtbPKs?=
 =?us-ascii?Q?dZeTZZypBpK5Q2MEG9+LF4+D2TuQktsKAvcjv4mLHX48oMD7au+eT97de/3T?=
 =?us-ascii?Q?aVxVC2gRLYvUFjdr9mgQ5teWEFnuKGAPFyD+I9rbNczxzZBYiWWgtq2UXBnN?=
 =?us-ascii?Q?L4z7nxPJgtcIi3NssANueZkuQ0HLl2XHxZ1bFFVeaw1apmKSfj796e1lp1GB?=
 =?us-ascii?Q?rq8/CpJMWaD1qFEbQUTcARHioViaYlY7HP6/Z4VKcmSRLzOlse1V6CsTfStQ?=
 =?us-ascii?Q?+YSDWsP7X5fQhs+OpzKMZqxJNu7to/WZRH7H8rVAL/O5bxyb6Mf11KKVX8CD?=
 =?us-ascii?Q?3dW30Qu3CnqwdRwgm3kWuKURJz56C5O1ot/KLjpa93xScrJclu9euhl0/eyd?=
 =?us-ascii?Q?dpFAKa7iQal1+UxtYk/dQNi97fNkzHLxsSslz5Z0jaVqto5b4APOgrOscRjp?=
 =?us-ascii?Q?0f4UxnDOfpQeHaWg5a4g1rN6LCdaTXhqCppdaREHHgDl9l06/UmYhhXrE63I?=
 =?us-ascii?Q?REDLUY16gjxeUB32Sn1NhoOmRrGI4G3DIE3iMXovESnVk9ERoM1a9wURmnij?=
 =?us-ascii?Q?sdynS0ccWhwIKCQNmk7af8nhPmPAJO8G?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?skTEZr4WUyeYasJII+ondYvXUYxxGxEkMKpjBqX0ZSq2zyEoRG6xn2PRxZY+?=
 =?us-ascii?Q?bIr+v4nIYC7k6q1X1Qdm+Fzl8qkomizbXgkGnUewlWCH6hfXUvPrbtyKRitF?=
 =?us-ascii?Q?ivgLSbiQMEqP/ossvs0mbhaQdxcXXlqxAb5NwqzpxRUB7o56ZQ3PR1MRG3Pn?=
 =?us-ascii?Q?426VDy6TveLBBj1oFpssMt7cKgi+SLGBPQ6noM+qmujnsleTGDeywdJj0Lj5?=
 =?us-ascii?Q?YXpQDaB5EfNK1bmT5CZl5xBwd48WFsjLz7RLHcu72YdHYA1QC7YMilD5NgZb?=
 =?us-ascii?Q?a02yo5iRIgPo16g5XovASyDIupUsx+dal1dzwje//AEfuLEH8XkTBcjGbl64?=
 =?us-ascii?Q?cydFPyXrlHJPyr7vmi2+6r3vYw/MSD82XpXr/agsN3sfDRG/Su2A+L4kt88p?=
 =?us-ascii?Q?3GOLqtiuaA2M0R3Obx2+rI4d8a0qXA4NNgKJfQm8rYLrwUySU3zCEHF0ZQpP?=
 =?us-ascii?Q?U1tjiKrRiefzmRl/z8jpp+Ij5W2a1XPAmZXr19MLqCgf8JKbxhZ0qET/qPMe?=
 =?us-ascii?Q?qCJ5VkCjBUt0R1y2RqheRH2fiGEOpR3rXbs5ZjjnACttmkdEgvO4moGE5Vxc?=
 =?us-ascii?Q?A+WXn4SPIglFKpE5HMeZwBHRF5XYnudxZrxzqyinauKQrodX6EIgWcWDR17J?=
 =?us-ascii?Q?nLKIZ6pkNDk5N1nW3qCgg+uIk7fearJ3D8vOkVeq1sUMgcGh5NKBTg/7snaT?=
 =?us-ascii?Q?/vGTglbSDnlkL3lakJJ06k0e6QDARZHOybzzqV3tig0WW4k+c/E42PFV4Qtq?=
 =?us-ascii?Q?CiAw/vauoUQqnMcL0iSFTdZAM3anHc7ebFhVP1SgediczOW+Fnqa1BPQb4X6?=
 =?us-ascii?Q?ZeqH83e/jovlh+CSwnk6ivGySwHH3NjQ6MVGvESeYuoIJdusB5GieiaAL+q1?=
 =?us-ascii?Q?2E2amA8PWN3cIb8WA/yKBb8d5dZeZm0Z2OHNWSvrwikXdj/W43QJDju4ra6A?=
 =?us-ascii?Q?ecEyzumLKCfrp5xJ5eMj7Uhnl5KklJyuzxGLazVqUFmksf/p246Q0H4fbgKm?=
 =?us-ascii?Q?hok650v1iM8NSJiDYx6DAjl4/e8qmwtWbACfR0CZ7qXOyQnToHkaolyfHJK7?=
 =?us-ascii?Q?Sdy1j5Vt2rDrCUcbqrTB6MMVNfMWkrqJqQbDp9zCjD/jmWM35X3nTv6WAvVO?=
 =?us-ascii?Q?zz2T9ijOEvlEB/x2al3/ofnHH/lc/1rJmPehZAtufdLESxKoaUmzME4d+2PN?=
 =?us-ascii?Q?gcpSMmybYlKSi0d+nHS2w6kXPgS5uGbAT66vkHXI+6jOK1WtkIUyCKWvWWJ9?=
 =?us-ascii?Q?lLtaNhkf1j22Gvz8BvozdvJumKZlI29hZptZuDEIvIFUXQ9tyfj9vU7SICFm?=
 =?us-ascii?Q?BpQSZUzlo1AKVdi46uhNwNeTz/qyu3lgYHdNXCynwTW12x7SIS1xG2JHZW9z?=
 =?us-ascii?Q?XPA5dkl684QeBIkfbCWY/oX5h1w4bO50HOi6c2Yka4vLHwFAaJpf6p/JuytM?=
 =?us-ascii?Q?ID3fV2PC/M1CsUZBTfylWug7OTTEbn04oeP+ExiHpUkLXg3ijE6urdgq93pa?=
 =?us-ascii?Q?rIKryINM2InA01GDIpk36CzQb91lbJlZDbgYEp8yDqaHCJVS1QUR1rxK8JLD?=
 =?us-ascii?Q?xlHXQVw+dM9YPZ/5lMU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1be801c-b347-4970-4033-08dd4134b600
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 13:48:00.3844 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: STioOfESgwBn0YONQssIlX5iLpOwnKwxUm/WvFR8MdHqkIJj+6MxZ6TCJJIkgkmG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8222
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

Reviewed-by: Leo Liu <leo.liu@amd.com>

> -----Original Message-----
> From: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
> Sent: January 30, 2025 4:51 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Liu, Leo <Leo.Liu@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>;
> Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
> Subject: [PATCH v3 10/10] drm/amdgpu: Enable devcoredump for JPEG5_0_0
>
> Add register list and enable devcoredump for JPEG5_0_0
>
> V2: (Lijo)
>  - remove version specific callbacks and use simplified helper functions
>
> V3: (Lijo)
>  - move amdgpu_jpeg_reg_dump_fini() to sw_fini() and avoid the call here
>
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 22
> ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> index d5cf0f2799d4..4a55e0cf39e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -34,6 +34,22 @@
>  #include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
>  #include "jpeg_v5_0_0.h"
>
> +static const struct amdgpu_hwip_reg_entry jpeg_reg_list_5_0[] =3D {
> +     SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_POWER_STATUS),
> +     SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_INT_STAT),
> +     SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_RB_RPTR),
> +     SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_RB_WPTR),
> +     SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_RB_CNTL),
> +     SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_RB_SIZE),
> +     SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_STATUS),
> +     SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_ADDR_MODE),
> +     SOC15_REG_ENTRY_STR(JPEG, 0,
> regJPEG_DEC_GFX10_ADDR_CONFIG),
> +     SOC15_REG_ENTRY_STR(JPEG, 0,
> regJPEG_DEC_Y_GFX10_TILING_SURFACE),
> +     SOC15_REG_ENTRY_STR(JPEG, 0,
> regJPEG_DEC_UV_GFX10_TILING_SURFACE),
> +     SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_PITCH),
> +     SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_UV_PITCH), };
> +
>  static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev);
> static void jpeg_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);  stati=
c
> int jpeg_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> @@ -100,6 +116,10 @@ static int jpeg_v5_0_0_sw_init(struct
> amdgpu_ip_block *ip_block)
>       adev->jpeg.internal.jpeg_pitch[0] =3D
> regUVD_JPEG_PITCH_INTERNAL_OFFSET;
>       adev->jpeg.inst->external.jpeg_pitch[0] =3D SOC15_REG_OFFSET(JPEG,
> 0, regUVD_JPEG_PITCH);
>
> +     r =3D amdgpu_jpeg_reg_dump_init(adev, jpeg_reg_list_5_0,
> ARRAY_SIZE(jpeg_reg_list_5_0));
> +     if (r)
> +             return r;
> +
>       /* TODO: Add queue reset mask when FW fully supports it */
>       adev->jpeg.supported_reset =3D
>               amdgpu_get_soft_full_reset_mask(&adev-
> >jpeg.inst[0].ring_dec[0]);
> @@ -637,6 +657,8 @@ static const struct amd_ip_funcs
> jpeg_v5_0_0_ip_funcs =3D {
>       .wait_for_idle =3D jpeg_v5_0_0_wait_for_idle,
>       .set_clockgating_state =3D jpeg_v5_0_0_set_clockgating_state,
>       .set_powergating_state =3D jpeg_v5_0_0_set_powergating_state,
> +     .dump_ip_state =3D amdgpu_jpeg_dump_ip_state,
> +     .print_ip_state =3D amdgpu_jpeg_print_ip_state,
>  };
>
>  static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs =3D =
{
> --
> 2.25.1

