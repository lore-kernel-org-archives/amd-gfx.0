Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE90D2ECF9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 07:40:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6165610E56E;
	Tue, 20 Jan 2026 07:40:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PEfsG7XA";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B900610E56E
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 07:40:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vr5FTtjww7zGKFcSLcP8YJLqRJHxzN5HDNz6Cgcr5b0V87Rf5YTbNf9dKl102a2vShSFqJLzXaS9q5n8IPTCVFbMxYQXxoqkzN7P4y8B/assgbUFTmLliS6RZTxEuoQb8n6UeaeW9w/wzWj87SdrCTJo9ujIybobG64HQ5om9gWOuezou4jR2Kqe1a5DbeKh03aFx6FCYtqsW7IpA+Jd7an60RJG8WnvXyvcny9wvoh/a6DIm2op5LvTQ2uwJ27S71yq1O/WeMqe5ZpTKgsDlerKTvNK05CxwN8SDms0eVM8i4SLEcPUrN4g6ECSFJ5/SFienHGjyL47b/JGCVSI/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ll1oT+UxW/vH58unpTfLzk8IZGPNK5rQ0HjHnmfaqY=;
 b=fA+pD9OGpphaWITi+4wCeJfzzvGH+YjIflxqa87S9f8bVm1pCqsJQ4dpdkj3KqaV8E/44hzFJNZbbdLN421ei8dBq+tik6Thv8VDtSHMgEHothmnlC/XVHhgpe/zXvFoUc79cWLt70foPnNfexHvnpDsW1ZMG5qaEPAilILL79a9plePEi9hhWohChAwH/7/h+c77GO1eUyAxzdVxUhVHvACDpxoJw7gZs12eTZOCxczMHntxNK7GT2x1mqWgCxs6a/n+AYhoOZlHGTlw6LAIRhe90lgXiTd9itMWcf8dKEE+H3YWAIyK5jKYHf+j0ND+n6ncgAE3GYkcvAYc9DJ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ll1oT+UxW/vH58unpTfLzk8IZGPNK5rQ0HjHnmfaqY=;
 b=PEfsG7XAm4TVddRHtEKUurcQvueD+Z14P/wVrvVgpI4r9dRh4yUGZi77xgfBp3+NXL/Dzvzlp7653u7Kpaui7SiFRd49AszSeE7Iq90RKFD5yLdjkMVerDtp72OPYtxjz5vGgIQ5Bw06eAmsYqNA+CFBL6ZV/tO1DfJCRk8xlhI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS5PPFB8FBD73EA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 20 Jan
 2026 07:40:02 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 07:40:01 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 04/10] drm/amdgpu: require a job to schedule an IB
Thread-Topic: [PATCH 04/10] drm/amdgpu: require a job to schedule an IB
Thread-Index: AQHciazy8f9FIpKlBkmU4BQTmApe1bVarJig
Date: Tue, 20 Jan 2026 07:40:01 +0000
Message-ID: <BL1PR12MB514479ED744DBB56A4CF1691E389A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260120013411.15659-1-alexander.deucher@amd.com>
 <20260120013411.15659-5-alexander.deucher@amd.com>
In-Reply-To: <20260120013411.15659-5-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-20T07:39:56.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS5PPFB8FBD73EA:EE_
x-ms-office365-filtering-correlation-id: d848f180-d076-4eeb-efec-08de57f71ece
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?+JfgN70yae+BB/AATYfryzYybj6qJrh8VZDf6wemMeBxWoOniBBT8DZUmreG?=
 =?us-ascii?Q?UZtJ9EYxPoJatI2grq9ukMJ+KpaAtp+u8qk8l1UZRLMEZKDOvb873F7bftUZ?=
 =?us-ascii?Q?UOW4ObIN7azZohmrBz9P5dV+IPPBWLIY/giYfcZAHA5KEzqrSnrbJolMM9aM?=
 =?us-ascii?Q?O6H18Dg7NAtNFBf8MX56K236DfB8HY7ZSZEhPRbbiuS+GyRGjISSkWiqpUz2?=
 =?us-ascii?Q?JQbI31pc3shOkm/j8P4HmmM4NWC1o3bLIkRi2OeJV/QGvUNF1kBFoK0oAnrO?=
 =?us-ascii?Q?w9G6E1MAW3Oa4IpC/+VxqiXWwT0SvoI2rHJxsvUlrooMxcvmCG9wJDQ7Hmha?=
 =?us-ascii?Q?2p02dTOxxHHbAUf/x+qd2rYXxzoHwuOt0ibZ9/yWmIci2bBV/iXTRj5geyIi?=
 =?us-ascii?Q?BczlpuYMyz/zSk/ZT5XDcILQtXO4pt7JHXyP0HdxyFpN5AKdwypIWVU3k1Hp?=
 =?us-ascii?Q?qlCMrPTAmfiWSURsRSn/b3mvZFH5SyEypOpgKlY7TF0OGWy4qH2ZfHwCCpNB?=
 =?us-ascii?Q?edwW1vaidHS/OAmGHsiQ+mCuHPVryYh8XGZZhRPj8CR9oAafmCRVlB0HJLPU?=
 =?us-ascii?Q?gc8PpzC45iTJtSrZVYzgRBg2dICIkDIXH0eVhnGi7KwLYX6ia9w4Dw3ZsBqs?=
 =?us-ascii?Q?EIsztbEwYphi0dbC4taPoe8ucfYo1fRxvTTh7d7lrt37DQFjuDKbOI0CTTXN?=
 =?us-ascii?Q?gkrts4u2tpusxpBfwP7mapZS6ZROWKX9dm8NBCOuvCIDZOysG0JQPiG4WZT+?=
 =?us-ascii?Q?kc+LKvHdf4TyvNjXDNWHDarBzNj+fMa8Gw5TiR9GBp8Rp/msyprk4EXhkko1?=
 =?us-ascii?Q?zhgpcUE0R+sa2ARVCcvKI9zDjUJF8R+LPcVjaYZyV1Iqsog3ripeTgqo+2pZ?=
 =?us-ascii?Q?jrtthwQDsyydmmd9Pl5KankNBnoU3bwhY6i+IVeCH+wljUtCzVYtLxEhfaxH?=
 =?us-ascii?Q?xKlWKLOu1jh+Q6s2CmUuSp5l0wjtkFsR9fbJWX9OcrlxGLNljzAwclNfRuec?=
 =?us-ascii?Q?+uvo+wIIWLmWndU8WNM31hOn/5lHwov3BvFhqMlLxG+Zg1Yb39qRk96zA3GU?=
 =?us-ascii?Q?Nq4i3UuIXxR9nU4rNI9pUEAqyAlsMvRByt9wruL6hQOsvnmx5g6p6N1AXH8J?=
 =?us-ascii?Q?yO3yecJmYtLRVszv+ByaE2lR6pYniVR5GLmI3giv3leExOi2/Mr3NfzEvUWa?=
 =?us-ascii?Q?4+xOMBGP0EEfZbcLjSGzMjj4POPi2HBJLfic5OCgj9+V37K2NH9UrSOJ8/Jj?=
 =?us-ascii?Q?GJdFcj551/NhB7YBL7XKsRUBHJ3M+HG7RYPdI+9UVz/Bju/aRU3wFHKEDZnk?=
 =?us-ascii?Q?v00y0nPyQjtcxe9ihftw8uw5TeWBsCEeUMKWTxAi8qS6AyIi7/pC+/0IRlq+?=
 =?us-ascii?Q?/pEeIP6qaeGiXG/cqWhIMnZ1Y8QSOzMKCfa3B6jbCXQ+XGyZE8vn8zC3zs9n?=
 =?us-ascii?Q?YJN23UgI+g+tkEjV8Bz9HM3VZRgSt9zyuHToiFLa7ojY1w2HYlFgiHLsyUDQ?=
 =?us-ascii?Q?GlHj9i+p8N9Ytpy70FbYS/OsL0u5/v3OAZA/wyGYZ3I04Lq+zJlxBhRUg4aa?=
 =?us-ascii?Q?yaXvri213ESLCAK/k9agozaZBRvwDP6yFWEAsLTHqw/HwZaP6o4XlYoHPi4s?=
 =?us-ascii?Q?hTbqGsTGpL92mZTRSjjiPFg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jBxZAPXZtMA1jFopjoRejYVtJPbYlDriri7rcD/1jfyUsvk0+F2w5rr6T6lD?=
 =?us-ascii?Q?bPHRszSukUo1giX6xDGXKLBH/ICUyrBLBGPKqBC616CCrWulgeWpGwPz5stg?=
 =?us-ascii?Q?Zd4qpSGWC/KUayNikrb5JkNIPF02EQ7i3ifLcZ8m/0bICX+g1LAoIZ1jK6Cd?=
 =?us-ascii?Q?eMvFm9nCijhBuy38jfXRd226RGxuBZ4NJ6xK2SqScEf3Hn4ZAU4s/Le9OVZ9?=
 =?us-ascii?Q?dFA/GqWLG1U4DlJxnELHm7qQv/BNmDSPoobZPHa98ylg3PwoziK0w/rvla16?=
 =?us-ascii?Q?wUD0nME8EvHNANgw/mSJQ2RvzUXooIwc6CY+Nrq8Xdi7ZiYTrecS2cBJ+0t3?=
 =?us-ascii?Q?z9Idbv9HqYyYGikzzcWpVN6+lNjCpjC7VM6IjwoUtztMp9mJPaGbowy0caVe?=
 =?us-ascii?Q?pSPfzz6tAhN+7CYuB3liAR8Zy1P5PPxygxQKos1/PwfZ4fQXfLRA0I4GM2C9?=
 =?us-ascii?Q?/RLd6Mqt5GItqeI11DWkLXGZHZ/5FsXaUXWQ+qQSPOGpYenwujh83jVYMSv2?=
 =?us-ascii?Q?DtuCVDJ5wuezbwD1fdzWjGO5vF7jrn5Ox+If0C6a8Km/KfK84ibPIQZ9k0Ln?=
 =?us-ascii?Q?a2CSGAm7+luECtpE2vo1ZjkB2gbBOI8ILiPwB8ZELSG3jqXZw4vlVs4WDLNf?=
 =?us-ascii?Q?KoSlycTdrs3kpGGFDJ84QKfFsYs/JIsv5ZszwiX729YQGYn749dWNt/x0eHE?=
 =?us-ascii?Q?SSJaO59b7oZA2148nuwmPzxL7yzgd8D8Sd3Q7aIkCkcE01qKJcfgpSnTzFmX?=
 =?us-ascii?Q?iQw+TpZt17tCbVUtQ5WgWehUbcrvRNHHtt9ta4Dd1K+RyZoYEe6ERC3/+wR2?=
 =?us-ascii?Q?bKp5jtU815j//Io4zQ2bdciMK+ffWGDcdpZQqpke8Ccu62b92KlgRkGWg2/Y?=
 =?us-ascii?Q?iaVO6HbidFFZj+3QINuDSjKhAPO29rgejRpn7Z/sTTEbkT6u0Uh8IISirkZ5?=
 =?us-ascii?Q?asPsTs4d+TrySwg8OmHcWqQJq+OxwnLmlowPQy5X6f2uxGKCkWbgv7r/t6Nz?=
 =?us-ascii?Q?ZXCydO5I1Q5YuGcnFyz0xsejHqsAWDh3RBqR9VWT5H2Sz2KPSRtloMtZO2sY?=
 =?us-ascii?Q?+a71Q6CPm+0CA48QnKvftK+rLydUgayQx8ryPTAMLdtUMf7ihkRPAkdjzoxt?=
 =?us-ascii?Q?h9NC/s3qBvd0VdriZCMToH16ouvub5ohwAhWpw+YTCqmcATMWjjbpbUDKzy8?=
 =?us-ascii?Q?g4gnknIiedn2+uXSK8PKo6jH6/LocDb6W7SgSbPeS0VyT/MmBngQ0yOaRglp?=
 =?us-ascii?Q?EkCUTYzJEyALI9AjngwW9b6xwAkduL5g1VwApBRqehNOgIWRt7lIzei2TH20?=
 =?us-ascii?Q?+ZimRhgzm5QcADWe0IbjDnxvsFdqqOC9KZpOcahvGErj+fHmUmdJwNQRZSpF?=
 =?us-ascii?Q?JS59IpvAnISZQ8Xl+p3CwpoJn53asruLZd6/nWlcoJUt+72ZXaDf5Gh5LOPy?=
 =?us-ascii?Q?rETFbChZ1ouTgNUaR/8LLJDQqMHz4ZAfkss2YLpKWxO9g4bFcQ9WZZDrSYYO?=
 =?us-ascii?Q?9s3l3cAoqqggfjKDwh58usMLuMi8XdoUavBlWQ3CLH3JzU0f7gEMdCRbzxVw?=
 =?us-ascii?Q?UghyGebOSBGzntY2JvtAdEMXQfMws1QnUK3rxH+69DWEWrsob7AKuuRfT5Yq?=
 =?us-ascii?Q?+CZoh8Z+uuYAbbTnmbEG2ysoKcJH7QpOT6OxnbGfNaL8Hlqs3/XVrz0UOKMb?=
 =?us-ascii?Q?aa0hISs9OQ9i0WZ/pmaBjYphJ7aTz6Ar56u4dY53NiAEXr3j?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d848f180-d076-4eeb-efec-08de57f71ece
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 07:40:01.8324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ec2KNRA4gCyHBf3z7HaaDOtAcDj9jwcmGUERaSgDpC7G2eXKLB1vGRJTEWLnpn/1vnAfD9e/Eaez+2bK+L2HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFB8FBD73EA
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

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, January 20, 2026 9:34 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 04/10] drm/amdgpu: require a job to schedule an IB
>
> Remove the old direct submit path.  This simplifies the code.
>
> v2: remove more local variables
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     | 111 ++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |   5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   3 +-
>  4 files changed, 44 insertions(+), 77 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 89df26dd5ada7..f69eafb898540 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -686,7 +686,7 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device
> *adev,
>       job->vmid =3D vmid;
>       job->num_ibs =3D 1;
>
> -     ret =3D amdgpu_ib_schedule(ring, 1, ib, job, &f);
> +     ret =3D amdgpu_ib_schedule(ring, job, &f);
>
>       if (ret) {
>               drm_err(adev_to_drm(adev), "failed to schedule IB.\n"); dif=
f --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index d90966daf52fc..78987ecdfe03a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -103,8 +103,6 @@ void amdgpu_ib_free(struct amdgpu_ib *ib, struct
> dma_fence *f)
>   * amdgpu_ib_schedule - schedule an IB (Indirect Buffer) on the ring
>   *
>   * @ring: ring index the IB is associated with
> - * @num_ibs: number of IBs to schedule
> - * @ibs: IB objects to schedule
>   * @job: job to schedule
>   * @f: fence created during this submission
>   *
> @@ -121,85 +119,64 @@ void amdgpu_ib_free(struct amdgpu_ib *ib, struct
> dma_fence *f)
>   * a CONST_IB), it will be put on the ring prior to the DE IB.  Prior
>   * to SI there was just a DE IB.
>   */
> -int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
> -                    struct amdgpu_ib *ibs, struct amdgpu_job *job,
> +int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job
> +*job,
>                      struct dma_fence **f)
>  {
>       struct amdgpu_device *adev =3D ring->adev;
> -     struct amdgpu_ib *ib =3D &ibs[0];
> +     struct amdgpu_ib *ib;
>       struct dma_fence *tmp =3D NULL;
>       struct amdgpu_fence *af;
>       bool need_ctx_switch;
> -     struct amdgpu_vm *vm;
>       uint64_t fence_ctx;
>       uint32_t status =3D 0, alloc_size;
>       unsigned int fence_flags =3D 0;
> -     bool secure, init_shadow;
> -     u64 shadow_va, csa_va, gds_va;
> +     bool secure;
>       int vmid =3D AMDGPU_JOB_GET_VMID(job);
>       bool need_pipe_sync =3D false;
>       unsigned int cond_exec;
>       unsigned int i;
>       int r =3D 0;
>
> -     if (num_ibs =3D=3D 0)
> +     if (!job)
> +             return -EINVAL;
> +     if (job->num_ibs =3D=3D 0)
>               return -EINVAL;
>
> -     /* ring tests don't use a job */
> -     if (job) {
> -             vm =3D job->vm;
> -             fence_ctx =3D job->base.s_fence ?
> -                     job->base.s_fence->finished.context : 0;
> -             shadow_va =3D job->shadow_va;
> -             csa_va =3D job->csa_va;
> -             gds_va =3D job->gds_va;
> -             init_shadow =3D job->init_shadow;
> -             af =3D job->hw_fence;
> -             /* Save the context of the job for reset handling.
> -              * The driver needs this so it can skip the ring
> -              * contents for guilty contexts.
> -              */
> -             af->context =3D fence_ctx;
> -             /* the vm fence is also part of the job's context */
> -             job->hw_vm_fence->context =3D fence_ctx;
> -     } else {
> -             vm =3D NULL;
> -             fence_ctx =3D 0;
> -             shadow_va =3D 0;
> -             csa_va =3D 0;
> -             gds_va =3D 0;
> -             init_shadow =3D false;
> -             af =3D kzalloc(sizeof(*af), GFP_ATOMIC);
> -             if (!af)
> -                     return -ENOMEM;
> -     }
> +     ib =3D &job->ibs[0];
> +     fence_ctx =3D job->base.s_fence ?
> +             job->base.s_fence->finished.context : 0;
> +     af =3D job->hw_fence;
> +     /* Save the context of the job for reset handling.
> +      * The driver needs this so it can skip the ring
> +      * contents for guilty contexts.
> +      */
> +     af->context =3D fence_ctx;
> +     /* the vm fence is also part of the job's context */
> +     job->hw_vm_fence->context =3D fence_ctx;
>
>       if (!ring->sched.ready) {
>               dev_err(adev->dev, "couldn't schedule ib on ring <%s>\n", r=
ing-
> >name);
> -             r =3D -EINVAL;
> -             goto free_fence;
> +             return -EINVAL;
>       }
>
> -     if (vm && !job->vmid) {
> +     if (job->vm && !job->vmid) {
>               dev_err(adev->dev, "VM IB without ID\n");
> -             r =3D -EINVAL;
> -             goto free_fence;
> +             return -EINVAL;
>       }
>
>       if ((ib->flags & AMDGPU_IB_FLAGS_SECURE) &&
>           (!ring->funcs->secure_submission_supported)) {
>               dev_err(adev->dev, "secure submissions not supported on rin=
g
> <%s>\n", ring->name);
> -             r =3D -EINVAL;
> -             goto free_fence;
> +             return -EINVAL;
>       }
>
> -     alloc_size =3D ring->funcs->emit_frame_size + num_ibs *
> +     alloc_size =3D ring->funcs->emit_frame_size + job->num_ibs *
>               ring->funcs->emit_ib_size;
>
>       r =3D amdgpu_ring_alloc(ring, alloc_size);
>       if (r) {
>               dev_err(adev->dev, "scheduling IB failed (%d).\n", r);
> -             goto free_fence;
> +             return r;
>       }
>
>       need_ctx_switch =3D ring->current_ctx !=3D fence_ctx; @@ -225,19 +2=
02,17
> @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>       if (ring->funcs->insert_start)
>               ring->funcs->insert_start(ring);
>
> -     if (job) {
> -             r =3D amdgpu_vm_flush(ring, job, need_pipe_sync);
> -             if (r) {
> -                     amdgpu_ring_undo(ring);
> -                     return r;
> -             }
> +     r =3D amdgpu_vm_flush(ring, job, need_pipe_sync);
> +     if (r) {
> +             amdgpu_ring_undo(ring);
> +             return r;
>       }
>
>       amdgpu_ring_ib_begin(ring);
>
>       if (ring->funcs->emit_gfx_shadow)
> -             amdgpu_ring_emit_gfx_shadow(ring, shadow_va, csa_va, gds_va=
,
> -                                         init_shadow, vmid);
> +             amdgpu_ring_emit_gfx_shadow(ring, job->shadow_va, job->csa_=
va,
> job->gds_va,
> +                                         job->init_shadow, vmid);
>
>       if (ring->funcs->init_cond_exec)
>               cond_exec =3D amdgpu_ring_init_cond_exec(ring, @@ -248,7 +2=
23,7
> @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>       if (need_ctx_switch)
>               status |=3D AMDGPU_HAVE_CTX_SWITCH;
>
> -     if (job && ring->funcs->emit_cntxcntl) {
> +     if (ring->funcs->emit_cntxcntl) {
>               status |=3D job->preamble_status;
>               status |=3D job->preemption_status;
>               amdgpu_ring_emit_cntxcntl(ring, status); @@ -257,15 +232,15=
 @@
> int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>       /* Setup initial TMZiness and send it off.
>        */
>       secure =3D false;
> -     if (job && ring->funcs->emit_frame_cntl) {
> +     if (ring->funcs->emit_frame_cntl) {
>               secure =3D ib->flags & AMDGPU_IB_FLAGS_SECURE;
>               amdgpu_ring_emit_frame_cntl(ring, true, secure);
>       }
>
> -     for (i =3D 0; i < num_ibs; ++i) {
> -             ib =3D &ibs[i];
> +     for (i =3D 0; i < job->num_ibs; ++i) {
> +             ib =3D &job->ibs[i];
>
> -             if (job && ring->funcs->emit_frame_cntl) {
> +             if (ring->funcs->emit_frame_cntl) {
>                       if (secure !=3D !!(ib->flags & AMDGPU_IB_FLAGS_SECU=
RE))
> {
>                               amdgpu_ring_emit_frame_cntl(ring, false, se=
cure);
>                               secure =3D !secure;
> @@ -277,7 +252,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring,
> unsigned int num_ibs,
>               status &=3D ~AMDGPU_HAVE_CTX_SWITCH;
>       }
>
> -     if (job && ring->funcs->emit_frame_cntl)
> +     if (ring->funcs->emit_frame_cntl)
>               amdgpu_ring_emit_frame_cntl(ring, false, secure);
>
>       amdgpu_device_invalidate_hdp(adev, ring); @@ -286,7 +261,7 @@ int
> amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>               fence_flags |=3D AMDGPU_FENCE_FLAG_TC_WB_ONLY;
>
>       /* wrap the last IB with fence */
> -     if (job && job->uf_addr) {
> +     if (job->uf_addr) {
>               amdgpu_ring_emit_fence(ring, job->uf_addr, job->uf_sequence=
,
>                                      fence_flags | AMDGPU_FENCE_FLAG_64BI=
T);
>       }
> @@ -299,15 +274,14 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring,
> unsigned int num_ibs,
>       r =3D amdgpu_fence_emit(ring, af, fence_flags);
>       if (r) {
>               dev_err(adev->dev, "failed to emit fence (%d)\n", r);
> -             if (job && job->vmid)
> +             if (job->vmid)
>                       amdgpu_vmid_reset(adev, ring->vm_hub, job->vmid);
>               amdgpu_ring_undo(ring);
> -             goto free_fence;
> +             return r;
>       }
>       *f =3D &af->base;
>       /* get a ref for the job */
> -     if (job)
> -             dma_fence_get(*f);
> +     dma_fence_get(*f);
>
>       if (ring->funcs->insert_end)
>               ring->funcs->insert_end(ring);
> @@ -315,7 +289,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring,
> unsigned int num_ibs,
>       amdgpu_ring_patch_cond_exec(ring, cond_exec);
>
>       ring->current_ctx =3D fence_ctx;
> -     if (job && ring->funcs->emit_switch_buffer)
> +     if (ring->funcs->emit_switch_buffer)
>               amdgpu_ring_emit_switch_buffer(ring);
>
>       if (ring->funcs->emit_wave_limit &&
> @@ -334,11 +308,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring,
> unsigned int num_ibs,
>       amdgpu_ring_commit(ring);
>
>       return 0;
> -
> -free_fence:
> -     if (!job)
> -             kfree(af);
> -     return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 8660e3d1c3088..a323071762822 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -379,7 +379,7 @@ int amdgpu_job_submit_direct(struct amdgpu_job *job,
> struct amdgpu_ring *ring,
>       int r;
>
>       job->base.sched =3D &ring->sched;
> -     r =3D amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job, fence);
> +     r =3D amdgpu_ib_schedule(ring, job, fence);
>
>       if (r)
>               return r;
> @@ -449,8 +449,7 @@ static struct dma_fence *amdgpu_job_run(struct
> drm_sched_job *sched_job)
>               dev_dbg(adev->dev, "Skip scheduling IBs in ring(%s)",
>                       ring->name);
>       } else {
> -             r =3D amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
> -                                    &fence);
> +             r =3D amdgpu_ib_schedule(ring, job, &fence);
>               if (r)
>                       dev_err(adev->dev,
>                               "Error scheduling IBs (%d) in ring(%s)", r,=
 diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index cb0fb1a989d2f..86a788d476957 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -569,8 +569,7 @@ int amdgpu_ib_get(struct amdgpu_device *adev, struct
> amdgpu_vm *vm,
>                 enum amdgpu_ib_pool_type pool,
>                 struct amdgpu_ib *ib);
>  void amdgpu_ib_free(struct amdgpu_ib *ib, struct dma_fence *f); -int
> amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
> -                    struct amdgpu_ib *ibs, struct amdgpu_job *job,
> +int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job
> +*job,
>                      struct dma_fence **f);
>  int amdgpu_ib_pool_init(struct amdgpu_device *adev);  void
> amdgpu_ib_pool_fini(struct amdgpu_device *adev);
> --
> 2.52.0

