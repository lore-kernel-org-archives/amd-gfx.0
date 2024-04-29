Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E6CC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 13:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A11E112BF6;
	Mon, 29 Apr 2024 13:57:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jOtAdPVm";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1673112BF6
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 13:57:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gf332RcyTTjbrXSlY+KrZL0SA5j2V1sklmwjRFILNcwtsI1J2oIQQ9FSezakRpNYnKOHT32W61CdCMNUXsLy2/e8JSQfsoxRVbAiIaWfKIgg64ZJHgLC/zbBW4mVi4ZmDNR35oAfq5K2atlQwtyiqE9AHJO6+1z0laOw0Daz/5UwOXS56uBMoRumBJo3wn6nxQMYXDbnoG1TL3g5MNNhtJCFtIFBxzBtwRLwyMCHXO+NT78HXsppeBnjWKV78qBWeDwCWsRuOm9wPYFb6F/pUO3F2zcsTMquDm2PerkhZHPKXH5r5NAVSWyyqDkvZj1LQE7TKXOOvyHS+6DYJYN9ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYbH6m0EUhYJv6bc37lz1FBcpQuEkB/yUQq8bRR0rak=;
 b=K+688tO7uy8HsLHBeeIPrHDjZGTdziftwKp6vhu1z4pZcjvZW8qqFnErXrQTTWQ8QCUq4N7tzO0MJ1Inny4//XQzDgfbELU8jR9uFHmsNx300jkCR1BJZfzZoFpOKUDgakXrPfRaqEO2Wj6Hwh9634amaODqIy80eyQJHLXffwU6MvxLs/kYnEooHg0Y5r14kw4qCdk9il6sqDUBTEjE6MDBslZEKWDWt+l4bf7hyx7G6Go4znypGajc8TNlKviAtRrfd0hScq3RJVGuUxg/0kdy2khTNDE8OTf+d46zan9Q9jBvvP9ndJpkm+4YACyMFyc9JMiCT1wveHr7YGsoqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYbH6m0EUhYJv6bc37lz1FBcpQuEkB/yUQq8bRR0rak=;
 b=jOtAdPVmUZxERbQETVGU6wGR3T7f1+XpISfq9CRk2WgzDPb917bncPhYMhXQp3RTukZSaRFnNVNM8muYeA0SisKQFqvYwO1/Ma3afNxhnXtiHj8+I/nabx3ZA+R50KuiEfjB74jAEjtq8Fduk5UFcty4KNXYYED/hlPrnjZzcQ4=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.35; Mon, 29 Apr 2024 13:57:20 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 13:57:20 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Jiang, Sonny" <Sonny.Jiang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Jiang, Sonny" <Sonny.Jiang@amd.com>, "Jiang, Sonny" <Sonny.Jiang@amd.com>
Subject: RE: [PATCH v3] drm/amdgpu: IB test encode test package change for VCN5
Thread-Topic: [PATCH v3] drm/amdgpu: IB test encode test package change for
 VCN5
Thread-Index: AQHal0y/2ZhOqrkqakCtoZV7U9tNs7F/S5GQ
Date: Mon, 29 Apr 2024 13:57:20 +0000
Message-ID: <DM8PR12MB5399AEC3EF942C7C2304956BE51B2@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20240425201058.3240622-1-sonny.jiang@amd.com>
In-Reply-To: <20240425201058.3240622-1-sonny.jiang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8165fb1c-91b3-45fc-bd22-15d5ad6b1c41;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-29T13:56:50Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|DM6PR12MB4313:EE_
x-ms-office365-filtering-correlation-id: 4d277aa5-e5b5-407c-b235-08dc685449c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?YBHHcxyGwtaqP//dfraCsi8kxukyHHpO6fpabTTpldmYGDv3ferv7RKwbKvd?=
 =?us-ascii?Q?edCEItyCVV4tzbey1tXSshV85b/6aHjTO4gupjLD2r2AkKWBKh9Srdtm3+mI?=
 =?us-ascii?Q?ZvPzcXDjdhPtnW/qFVP+8dgHU0Dw4i2DVY5lxg8o/9wU/F9c4Vj03ca0GmJj?=
 =?us-ascii?Q?Tlnjv+TMmSGY9dsupJTvK5paVT2D3ThhdEayQb+kNyPEHuIZ7Mf25vmdnyym?=
 =?us-ascii?Q?5v0dBsC52KQ0xGo+CAo8ihqlWqMypa7kTM7PRQtUXom6/fhhUPXSF3UyJmlY?=
 =?us-ascii?Q?RcaNJCmmPHORIr4RVFwspfZEMi8ZhKuVL4Fszsw8eLsyuUutcgMD1VKWhjJW?=
 =?us-ascii?Q?GoQEvKdKDTd9u6ScbvIuU3m77I/XLFWQlN7Uf9douzld4nffGVDze93pPeA5?=
 =?us-ascii?Q?LcVLBuKqua3t3nPLrMBhkglT4WdfbRw36VV2BlipSnEiOOBuRNKM0w47bQlv?=
 =?us-ascii?Q?lypHewk6WMr9a4SXuwTklMUE7wMaMgiWzD2zSYdJyuK0IOGKxJ7fV7Cv/H2R?=
 =?us-ascii?Q?NfAg5uWxm7904pwoqU35RX6/xjTpYFm874K1/cA3flsU8DzNAsfBOEJXOCDw?=
 =?us-ascii?Q?1PzGbV4sS27N04IUIl3WuFjS4uiDBLJGTu2MEDguk2mEsTHz4ke+BrxXkeqU?=
 =?us-ascii?Q?cwlrs8ouvXffF4nwkl5m7wwVgroROtWll0VDTwblS1fa5mQfH/4KZ0sxBLQJ?=
 =?us-ascii?Q?W3zbXII1fNNiraaxFc85DGZ9ovalsQv0rw5Id4ORL2A4KLOvEc4uNuc7knxw?=
 =?us-ascii?Q?ZmcJBeb+Uim7oHpJJYapC+P/tR+6WrS8fIFT80Lhdf1AuB/RuVYePWbnDY57?=
 =?us-ascii?Q?xzJM1u76lWVWFUnxyqeIr2GMJAxELIW+u3A6/YhU4VQNov/cvrTuha3kY/x5?=
 =?us-ascii?Q?lqsNZWRVbLnG6+r5kE+gyDyq0XJVzcHsRPmAl4MwwY6RVRbsi91dNVxgsB0i?=
 =?us-ascii?Q?axVR5knD5tzEF7jJNbYLv/OjgK/Xj0XFcpsDpehpKvyf51752V5UhFwqoCdD?=
 =?us-ascii?Q?PbERY8t3uBwc7bRi7gjm8ooxulg58W0nnGRVhR8u2dk4i39W1U3enRBeTVGT?=
 =?us-ascii?Q?Jg0aH9O+vpKPsYJQ7m7Mb52BKqfNR/1a3U+B0ps1URysdTmWyACXNH06QiL6?=
 =?us-ascii?Q?Ev4rjEHQoN7Ns23BLF6YF3TWXJ9b6XXAQRixJpJUn2YY6xdrsRZAxFTkOquU?=
 =?us-ascii?Q?T1OsbjxkPcZme+fTeQUQ1gBzWGER1zIwnyjyY5H4VUrHgGyQ3fspp95NKbfF?=
 =?us-ascii?Q?TwCevfFhO3aS1RwJhnTnENKZxvCDqIkN5yy0gQ/pUr5MnLo3nk9Rb30GVkbZ?=
 =?us-ascii?Q?z2nIM1fejcS2maKaFnr+GkZf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sh0T8nA4tAkrRqtfy8whLIi36iIDhrqufU9ZUHBYNZaPrcAPQ7Wp5PugsW1B?=
 =?us-ascii?Q?TD9ZPScnKiN7loDcAnTWH2WDyIoIxK6TKWA+fc2yHDaOfuX7meW/pfBjtVXe?=
 =?us-ascii?Q?7uEvxC/lSBlRz0d85s1BbSc4nftS5ZuUNwZS/UFpO8OJA+YXTb9hr6g8ixG/?=
 =?us-ascii?Q?x9u1xPNcyC602xSVv10nuSP2Fff5zIkNQ2TY2j4kBWZlfwGDUzFupuEMnFbE?=
 =?us-ascii?Q?+6Dnw0VMlA1Aop/X0K5gcfTo8TYOGpqXu7lYywIB5x56mzMlPGo8NBt3DkW6?=
 =?us-ascii?Q?0iKM9kEs8M77EioYsdUjTzb4OOJ6AszgHYjIUVPFjFbQv8BWbs88VWMLA5LH?=
 =?us-ascii?Q?FK6T0f2n5iP2GvJGfO1vC8u0Qb1kUpT1Gb9MJ01Wlrgupb4G3FelWBwFifA4?=
 =?us-ascii?Q?ThwDtD3d/KNp2R/O5QTz14jBBGWCxiQ0YL/EfaLNuPK6pMGid5CY4yvO5DbW?=
 =?us-ascii?Q?3G2GRB6l8mLsulnNmCFCnpH6KDruC1ATWakepSoLw40EWTMudM62xD9bMcmw?=
 =?us-ascii?Q?Mn3dV+kfq1PJ9D7YyegP7pCs6yZpE/u/EHiS1xyB0WAp+Lg2JU49RxbRA87w?=
 =?us-ascii?Q?E8xIK/V1Wh04n4ftw7kF6ERb2yIVq8rXSCwCPpNL6O3JF/9dCgayf0Z/ilS2?=
 =?us-ascii?Q?ZpCah5WhQ/Uhm/ByrkiDkxtNgPHWdj+MiH/KNayVHdTqe+QVAX1WkgZv4hyB?=
 =?us-ascii?Q?Sz5M7RznKx/YP6cbUjJAI3xi7IfboHSgLp3mTI2dc07JLl2J/CVm/jA9O5+U?=
 =?us-ascii?Q?pE+K6RpWAiGMml5vke4UzAhc+KJvGlKSunpGYbYCnhewHas+IZCGPglolHqt?=
 =?us-ascii?Q?d6tSUogzDbueBnswF3KMT6s8gsr+XlR991ANTR06ndk1I4Ev4jQN4rcWrCiC?=
 =?us-ascii?Q?vtjkqvY8SuKrHh7InrzEUbfktV3fxDulDtLWG3o5/jy4eFCriYbTMSRxRSxs?=
 =?us-ascii?Q?Y3lnO0f69IrxUIndBs2vJql47ENH/oK/Qzp9Gg34CKHSTcy6ZaAbQI/jDLwF?=
 =?us-ascii?Q?5t8sKmZtOYLulz0mwq3AxZTdjBUjADPcya4MQaA1NreG7nGDOnB24Pva8OtJ?=
 =?us-ascii?Q?idbWgxnLzhRgJUjKl8TKVANn4vh+xM1WYnCfo504Hi7R0M9t8cGaYJG2aPGQ?=
 =?us-ascii?Q?k7ibH3YLqDYhg3ouBebmofq+KoTs0V4nXvomTV6P+pOK+tjUxbtlR0B9nUXK?=
 =?us-ascii?Q?SI4Hk6r7xo9LKL3JJ2HrH2mYbkHu3nCjcdLpik7PjJbavZrJwFbyeXvvLiXo?=
 =?us-ascii?Q?s/bZe7tXqYVz+7ISFPydEyVBE9pVLHLO+8gjPV5gIZxtva4Vv5PNWRbx0ZUQ?=
 =?us-ascii?Q?arY8+CHKpVjxjxqFAmVc+UUkZ35LD3tsTTSNnKt7zU7dF/wiruKjSb+9pP5T?=
 =?us-ascii?Q?0/vfO90TkMyEeUgPmnC4SIkty4X9ViHoWLQQwjFB0xzU21o30O8Mt7u0pU88?=
 =?us-ascii?Q?IZmvj9+5Muqixdoo0gFBWYZ/BmQ+qD1tE9BhdcxwdR3hC2gaJ5dMOhGzkYVp?=
 =?us-ascii?Q?2Rtpk4dE8l/uChGUMtaakqbgIDgqd03KFlon6v7684InK9wmosx5ZB4Bogu4?=
 =?us-ascii?Q?BcAxpPlUteIp9oUEyp8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d277aa5-e5b5-407c-b235-08dc685449c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 13:57:20.3633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IYW7cK/6b+HvMWLyFZtZz9glJ5NvzHsT7ZPLv0fbLQUGxFWUFjqHNck2TPdt4vr/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313
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

[AMD Official Use Only - General]

Reviewed-by: Leo Liu <leo.liu@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Sonny
> Jiang
> Sent: Thursday, April 25, 2024 4:11 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Jiang, Sonny <Sonny.Jiang@amd.com>; Jiang, Sonny
> <Sonny.Jiang@amd.com>
> Subject: [PATCH v3] drm/amdgpu: IB test encode test package change for VC=
N5
>
> From: Sonny Jiang <sonjiang@amd.com>
>
> VCN5 session info package interface changed
>
> Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 677eb141554e..b89605b400c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -885,7 +885,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct
> amdgpu_ring *ring, uint32_t hand
>       ib->ptr[ib->length_dw++] =3D handle;
>       ib->ptr[ib->length_dw++] =3D upper_32_bits(addr);
>       ib->ptr[ib->length_dw++] =3D addr;
> -     ib->ptr[ib->length_dw++] =3D 0x0000000b;
> +     ib->ptr[ib->length_dw++] =3D 0x00000000;
>
>       ib->ptr[ib->length_dw++] =3D 0x00000014;
>       ib->ptr[ib->length_dw++] =3D 0x00000002; /* task info */ @@ -952,7
> +952,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring
> *ring, uint32_t han
>       ib->ptr[ib->length_dw++] =3D handle;
>       ib->ptr[ib->length_dw++] =3D upper_32_bits(addr);
>       ib->ptr[ib->length_dw++] =3D addr;
> -     ib->ptr[ib->length_dw++] =3D 0x0000000b;
> +     ib->ptr[ib->length_dw++] =3D 0x00000000;
>
>       ib->ptr[ib->length_dw++] =3D 0x00000014;
>       ib->ptr[ib->length_dw++] =3D 0x00000002;
> --
> 2.43.2

