Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3CEC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 14:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5943510E8C2;
	Thu,  9 Nov 2023 14:49:37 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1639310E8C3
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 14:49:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GB7R0eQ3fpyjs8QvWaMbahhBTjF+TN6k1nw2QK1UFfWYbtV5WadL9Fq263P7bu8hmb4mp0n05mi7ms4RymDs2oOwHPTbEzhiJz8u2bYOus+xFtrpjYbMaAUwOPhZSDQlu6Q+qvXHm/3hlG8LKu09Q7IAfazW7EPTB6Mt5JRusW1OXacputwvLzYGYshBBqexI0VwyiXPMv0C2HEUoZ0oibQtyi1+D8H/x4RtTRCWfWKfA/RxxyVjghz9udFg4cdRY2R3O9aUsSHhoqSgOCPmJDBT8kww7vwEvaQQrbeBd0qhJvvAkWk5PB6SbCYXK0OsVXY6lj/96FSi4/8uZA2XQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sooJ6ThqOaunFtUe7I7OXRv352X7TkKe4TwKBP35IdA=;
 b=NoBcHjDQaQ3b51s/M+X/lsef8zjlRdxYDIpaucBEsnzDWEiMyM/QrI1AvS9TG3JIpuERVTwqiDSkcRVyivYER6RXQzPlhT15Z1DdXXLgn40nlJsqeoqs9pDeJTizma6n2APRGwm4GPAwGSyBsCjI9t27mh4dmTkBkzVaeZbHG8m8fahj583d8JvWMpRWqBWqTn6eHBs9y7DBr/LHf6aSGk3X6Pd8oCIZbp3Af8RUlXGBtyukviFcMGudXtyEGZsos6udSZXrXAbHMpksmToDLgdMQlOVvsTMduEWT7qa0B2xLpAug2N2YFqQZQezW16bJ7BvZ4iQvqgDf6cdBJV5rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sooJ6ThqOaunFtUe7I7OXRv352X7TkKe4TwKBP35IdA=;
 b=mzjSrvL+5IgTU2/0SWvem4eTwfZGORfPhigLcXAs5QCVSPdzbgtnLMl+/dVdL+EavrYuF8j7daIcy7cTr6vuHx2YzNqhqM8DLBpHUWpwL0GohGe9uo0pavyTZcft1WaB7ten71M/y80OxHW7KiOO+sX+JWPXxx92C8oz6nAc15I=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CY8PR12MB7265.namprd12.prod.outlook.com (2603:10b6:930:57::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 14:49:31 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e%4]) with mapi id 15.20.6954.028; Thu, 9 Nov 2023
 14:49:31 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amdgpu/gmc11: disable AGP aperture
Thread-Topic: [PATCH 1/3] drm/amdgpu/gmc11: disable AGP aperture
Thread-Index: AQHaExruQeG9Zwx5l06gcQs8NgdbC7ByEYyQ
Date: Thu, 9 Nov 2023 14:49:31 +0000
Message-ID: <PH7PR12MB599733FA67106A4B24D1BD3A82AFA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231109144143.502132-1-alexander.deucher@amd.com>
In-Reply-To: <20231109144143.502132-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CY8PR12MB7265:EE_
x-ms-office365-filtering-correlation-id: af0214d2-8e10-4150-20ac-08dbe13314cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IwWE5WbWEE19niJUg3EfWYpd51sf3in9uKqrBiD4M3RBBIE7om+un7wULJgvSyT1M4+jOcCoKY5kZKQSlwXeZDULNzZtP2UxKOxJHF3/7BzIqzZlGzm0yTgbcuDivh+MM8HvgI29TkFc5yWpDCh93l/UUwofqfCW1Jd9sM2ChXcrzTrj+qypb+tyTNj+VPnlhcm/i4f7GAEk7uTb/GiFeqpv1xPtdH0Gk0JCglBGs6kpuyCyE31sk+A7SaECQpVFUib3DvzvoxwQfucdFwU6M+iOjAaoZSvIfshLDHye299Vk7dOln6O7ic4111RibHtSODTSNGCI5QFo7j4AixAMX4+WbG3kMpNeR2wpJQDA53PXMmhbftROfjoIfFq1QgwYQ48i5rmpbmvKNbC8ZFuJgtoH2KDIPfv7cpAQMY+9Hvvjb2iio5BYxkyaXqYUyHH8KnU/+MfeI6tEH6eIOBQ1ZRGMLuOGUge5sYG+q5ThSHfQhclaJoZLSYi46XfSAoijGtHEX/1h217VdCDkjxT6VZ7OiEHb1BC9FlxwSPVYExqLKfp/L/kK0XntyAxuOXAnpunpBPjGdyIMXbUukxeeCyntG0ZXyfoyjrer62kqyIltcaN9m9pqTWzg0kF2LRQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(55016003)(83380400001)(52536014)(4326008)(38070700009)(8936002)(86362001)(41300700001)(8676002)(33656002)(316002)(2906002)(71200400001)(7696005)(76116006)(6506007)(66446008)(53546011)(478600001)(122000001)(110136005)(66556008)(5660300002)(9686003)(38100700002)(66946007)(64756008)(26005)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z+JPwK3+bjZ5NJEKTvSYmnHm/AKwKyBK20FrzHx9nJ6mAUoUHcpWqkF5ziY9?=
 =?us-ascii?Q?zzM1yKGmkZN2PerjpepvxCUK8sVzNxMB+YndjJtsOYqeUSQanc88Isqx4Lz8?=
 =?us-ascii?Q?yo/gpXnmIfbwjWHjciBrddRmVRtygInvuinV7CDXBQkGoL/1qDWusbjfq2EC?=
 =?us-ascii?Q?qXeY2Z3A+2xNuE8E3uVOnn8bdv2YOXzzZNtb5WrIxLI3/n+XUpzNanv7ADev?=
 =?us-ascii?Q?fYDkNNTbvyEyKd+UY+DAT5429qMiS+SOIruFHX8cWyOD2tj+aNWhMC2ezHh0?=
 =?us-ascii?Q?J5eQivx4mgfJA6i76K9eiydbIG4h9+bx6sRuafb0v8V5zXYmrpIN1YAJ8DFm?=
 =?us-ascii?Q?2syUAIKLs9c/nMLM9SgrJZH1vYBkUC7RUFminfkmU89YpdhLD7VdP/l3/oBl?=
 =?us-ascii?Q?yacR8SBTSJRh6oSKA0wFdPMr2Hh3MJUsb9HEO60iV2qHgpxcs0YcAiiUu54x?=
 =?us-ascii?Q?0Ng6bfJi9Mcqz0qRUMnZlqNt0xtLPeJV871d77ZWzvhrEguWZJSoJNUiDgfX?=
 =?us-ascii?Q?4piBzL73ghfwHhveUTrA7g/L5WHJzCmR2VoMX5asIMmDY/Nw7N1gjQanitS3?=
 =?us-ascii?Q?wnvuPBxAcqeAz3oC0IPlTx1MfGDqL+WwlpBM4VS0ACh4riRNAFa2grn7Artb?=
 =?us-ascii?Q?DqoxudI7ejsDu50mk0Ow9G2HKrJs3W+ug3jIOfzoHkuwg1JUUKW9f5SAZpUQ?=
 =?us-ascii?Q?v+dctu+MYTLppVvAcgsRqZhLvwvk8tv/89H+6tnBysBa1N8kJ+iwBQguweCj?=
 =?us-ascii?Q?EnsXeUbiLj9oKHihCn2SV5i43X8nducJNJMz51qVJosR5Jrfxu6X7K4E4nNM?=
 =?us-ascii?Q?58j7GEyB4xQDrHISw2ow38fvCkBlEH1OgYPOnVfDuU591MJPSbsuEPbOW98z?=
 =?us-ascii?Q?o86d6R5IBkvW9B7OLml/wu4T5rkoGKy1sapgu/GIDYu6TEieS1ohRjJwCu+4?=
 =?us-ascii?Q?b4g0hMOiyVYPn8IhbdqWD2e0USLsFwwPoty2+YC3hJAZqlNZ1zzQQ0PrL+le?=
 =?us-ascii?Q?qfViTYhbpu7U+j+sGpT0d6P3F0OvUHEff6fpmyJWk04GwP2hZtM93Ck2wxY0?=
 =?us-ascii?Q?DvM1yCAcivCsfa4+d+MHVcs2PUo4+APkBiHO+rWQ3zArDHNkrAJPQsyISyd8?=
 =?us-ascii?Q?DdJyChbuLLGG2Ei0+KuuWqh+3T3kAsV/PVFO2P3tg0d6Vhx5L37jvmV9NMKf?=
 =?us-ascii?Q?xMFg0AZL4UL7uSWK5w+9mLMhAAc9YdDKMLQWyOAq75R7uGkYd02z8dVldnx6?=
 =?us-ascii?Q?c6ZPUp+aXT86i53kqCKXVUwKMb8z1AlPtt2oFrbXUjagWd1ViH4oerKqYEnl?=
 =?us-ascii?Q?8qI7ykFnj1M+3YAMgCE0Kt5RGw7S26nSgEAZs2j8GNENO65sNtGaUoMjrQiM?=
 =?us-ascii?Q?excdvSNWaRbONGHLlYM+eNk8nzYlb7OXTeYKCtWnHXQB/zCQVqV8ZKh9oHE8?=
 =?us-ascii?Q?JcJ2VsPJrC8lNd2U0CjiVzrWNZKM9arEtt7hzMYYcnT9rXpaMKd8wRE6s0X9?=
 =?us-ascii?Q?CSX34b5LrqTSycEmMgPJV9PGCosUyb1cwc4dmNJtsZk+QKjokKpyPvJ1p2c0?=
 =?us-ascii?Q?G6XIG0haETTzB/80WgM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af0214d2-8e10-4150-20ac-08dbe13314cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 14:49:31.1496 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ofCrzUVMau/xZX1YGUoBRnfCra2XhyzdLhP+tmMGYkwiNHKVdiyuYkbSNTszDhk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7265
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Thursday, November 9, 2023 10:42 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/gmc11: disable AGP aperture

We've had misc reports of random IOMMU page faults when this is used.  It's=
 just a rarely used optimization anyway, so let's just disable it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c
index 6dce9b29f675..e1cac5da9c4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -640,9 +640,6 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_d=
evice *adev,
 	amdgpu_gmc_set_agp_default(adev, mc);
 	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
 	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_HIGH);
-	if (!amdgpu_sriov_vf(adev) ||
-	    (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(11, 5, 0)))
-		amdgpu_gmc_agp_location(adev, mc);
=20
 	/* base offset of vram pages */
 	if (amdgpu_sriov_vf(adev))
--
2.41.0

