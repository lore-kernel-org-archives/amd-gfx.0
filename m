Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E67C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 06:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0170510E4FF;
	Fri, 25 Feb 2022 06:32:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84C8D10E4FF
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 06:32:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UP7GWopc0LW071ulzOFkYkW/KXIauUZQ1+CfJFDPmIN55efSaODXeO5J1lO0H58UhHRbQ1OXZbDG7TaBmmZeMKm2PEgP0McGa3LN1tEErG6CA+PMkXS1t6aSNllriJRl1E7KXl2C5Cw42OUhjL2C5UVL9JNv9ZTWwkQ+xn0Y/pdRQdmDJPFMCFhYbpMwD/sIWKBAVaF8pKkKDp7kd/ax8ZXqTqu+8cPH1iir4g+5gnl44IqmnrlTi0d40ys1OxrHwzB1wLrfkGMTuGlnSd6y2RG/bBlwxaE659HJOs5DEvC25ry12ZTLiHXeeGgW7mXngCWXIC3D+J3VqNbhFnf7YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsnGzR99X33QdoOWRg0aW2D7+E/Rsu0FrTNFP35HHO4=;
 b=PPiGMjnTnuY8QjX4js8wZzRxkzGXtKywIaomDBO8o8CsjYyHqtQpYB1bJrkxfGkRRBAH6vXbBeq2GYOr5o6y00DCVjpHEbkge7KanMNp+OS3GifbuaN28bbaVIZyiOlKDoNIghy6xU5KjrrCLmOCGmfdT5/0QJA4Hux2hJvpwxGUfm6FHwXu+CY4Mjb8kiFlKXBoXycmdMbDVz2whjCB9OPOeRNXcNmozKJRCHrn9xdd44AcgSq+RgGpE5QhA+XLZNZ2axH892DiJiRyM9tGoBTXe29adsX2HSnt/MMrtAWqtDa1bXAwkmAfQL/YMHmEKjSjEcHpAa8tErVsZm8g8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsnGzR99X33QdoOWRg0aW2D7+E/Rsu0FrTNFP35HHO4=;
 b=khtWM4LQHFDWzDNsPa50qyztr9CLEzi42YrsjApwwRZLwl9eq6eKrfLEBHMEYiu8FPKfBaoNrz0O9+n+7aqAvy22StXVVFGAdicw7K34ekp0OWrPK40AQgUls44voCDfPi6khwHZQEAHLRot6rm7n6Gxi8+NH8k7f8c1w7gI94U=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by LV2PR12MB5823.namprd12.prod.outlook.com (2603:10b6:408:178::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Fri, 25 Feb
 2022 06:32:39 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.5017.024; Fri, 25 Feb 2022
 06:32:38 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 01/12] drm/amdgpu: Modify .ras_fini function pointer
 parameter
Thread-Topic: [PATCH 01/12] drm/amdgpu: Modify .ras_fini function pointer
 parameter
Thread-Index: AQHYJwwoDpGSJuwwcEKBpAhOziwxbKyj1HLQ
Date: Fri, 25 Feb 2022 06:32:37 +0000
Message-ID: <DM5PR12MB17702B20C0249EF0E696D0DBB03E9@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220221101620.3269611-1-YiPeng.Chai@amd.com>
In-Reply-To: <20220221101620.3269611-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-25T06:32:33Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6b32816b-c46d-490f-a36d-1a831579b41f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-25T06:32:33Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: bfd0c071-05c3-427a-ad11-36d0b3eeca3a
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee07cc50-37f9-4947-aeb6-08d9f8289e56
x-ms-traffictypediagnostic: LV2PR12MB5823:EE_
x-microsoft-antispam-prvs: <LV2PR12MB5823CCE5389FC3A920CE1E21B03E9@LV2PR12MB5823.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bcr8NEu0LeV2/r5ynsBSxS30YEbT2SRBIq6g6b8FA2s0in+s+cM2tYxmvi1pF3YBpFwCpaqfJLXPB9Qc2YyRq4dOvyszrPd1WyKN5zRxIL2S+tTnSWG4+alHfUETLE5A0De8IApPGqngwcvt+ekVDt08LIkzVaCG+KR8GcvKoMx90q4Ynua9qPsrPIkMcZ0kWHIfFQaIjRLxqu9R5HzRlAfrU9UMiSFI1xlAlQdYoiO8ahwWadVpi2Ej47usDMnS/x8wp6BX0mgx4SY2N+BhiEJPqjpHsLUZnFmmpHZjQmfR258BBR7bGGQlXg5K9YLSYnHSjGU4GLjgmy3YpIsWy2+V1FzCfsoCUKsFRK17NUxTKdfxMRPuODYWyjOaMpUWbwUBVumrOZM8wTCNViQO+M9fRrLZKjhxQQB0M8khDv8QAojZxbuiIkVMLMfFQMm+GrdthrRbAKVzcIUKBja9Z9d9hzMMg9xOgOOhnfzp+Uka8WUIENtE6rPF/kfHCypx1YcYciDaRjJQ/qKmAnEWEjxF4pNbsFUjmjBHxirTHkKq8k5sZsVRsiy6DqOzngxcOF6rcmxrO2TAGJMWtLakRz9ZgJZKKwpKHNqIVK6GycIBKTop+A6y1umbyMGsCwltlTKyzYa/cb23BMG4ATw+dUWB7sx7g8VQgdOrJyfDBeJnPaWn6NFV5WNcCavnckIE/PnQ3uGH24ixZ+GQdTCqxY0gn/YRgSUEY/Q1/6DZgZM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(122000001)(4326008)(38100700002)(66476007)(66446008)(66556008)(186003)(26005)(76116006)(2906002)(83380400001)(8676002)(66946007)(64756008)(52536014)(5660300002)(30864003)(55016003)(33656002)(9686003)(6506007)(7696005)(86362001)(316002)(110136005)(54906003)(71200400001)(508600001)(53546011)(38070700005)(142923001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OtgVzSG/Uaw8F6x7LigPelFa22179QEMHeloRabqXuPxWCXFa0qs0S73D9he?=
 =?us-ascii?Q?WgPXLqv0uy9XhsGIVsV0w+/uVOgzqRvMcRuEdvpGLJC7kdvNPaD9d1Zc63I9?=
 =?us-ascii?Q?NKIqNKLWsH6Y8IJvzk8GZASpMbpEJegXxIbT4HMeRNyl7PMf8QdsLE9fxK4l?=
 =?us-ascii?Q?0/O1J4RDanciD0bjNWED7QS+SZFM7Tx6+q4KVEuv5nGVeTEovaP44QN5e6oU?=
 =?us-ascii?Q?vFkHPKFbov66sPq3umSXpYFI/e+KAg0pMxpXw/FxYs4YAnFskbkunN68DOuS?=
 =?us-ascii?Q?l8iUPHBfskxCQwLPQwDKgTtowLHaPBgPKUd24lENlsSS3aXWwyjWeVgRRcHV?=
 =?us-ascii?Q?3KIPBulOxj4eSKdlG2B1gYmIp5rzXKkwnz+TJWpwjzBZiS9rTl4iCRcML2wJ?=
 =?us-ascii?Q?3wD4MLoDJAmDY8BmehhXmzEJElObs2Pr4VLkgXi6jsNH2xf8jlcBCnkEK9xl?=
 =?us-ascii?Q?v6Ji9VwkkjPolPS3W+2DO1wZFz3qdgJ26lDdpeSQJUoANouukmzSQZi009rN?=
 =?us-ascii?Q?WqVdTAN/BpBIk3iBEpzeirXZ3K7FwAsZa4V4lxHMTRV01IGS1HS4zq8aNjZw?=
 =?us-ascii?Q?XTAnVyEse0Q13njVcsWaYe99Az3MzyduvarJx14sStFce0xiEAUP1Y2klEyU?=
 =?us-ascii?Q?9XyxCuOwxQWy4tU+Seql3poCeIZuoIypa4x5/cY6UgCJoFuGBSbbbujDlY8M?=
 =?us-ascii?Q?6YIGmMADezUxl7vdSHQu3eHAkFusZcESl+IgOyODdeTYc2x7l/eDgnHrA5i9?=
 =?us-ascii?Q?O5qJK2JuGU0+ebE1PJoRiPoGGbAHzyM2zZc3tRmLlEg1LjlWgc6SzNPXX8rN?=
 =?us-ascii?Q?SlMPAQ5k0ee6vG7WFeWtSXQV6B9wplIyth9cFaauxXcNZfNri15K9JxyojCh?=
 =?us-ascii?Q?qmScZz79pBctwtKcQ+GJ6Hj0MD+4i3TqzP8ekeiSTdO125C/esYeYCHRTOhH?=
 =?us-ascii?Q?/XkRcN+IZAjAo3hEqXIfq40A+8gYObEqxUrnJynYW6olKUzT5m8bIsTRWWfs?=
 =?us-ascii?Q?sL4CvQjv3KlqsDya4sk5T7w6YV7iOg+/tFu1S/cE2/vUoZIpjv9M5nP8oiaL?=
 =?us-ascii?Q?G+5yMK66JdExpwxotPKJikfpiRXdlCZzB4JpU4ZGGycKadpTi2vDWlmmT/ag?=
 =?us-ascii?Q?Ujq6UYj5sU2u8BE5l9mDdx29TbNqrB+xS0u8L2sbYadEFt4JkTgLMZ0p9km3?=
 =?us-ascii?Q?b6EVLziQYknkjMlknOkKaHi5Qiidr6d2XiAi3V/7oSwF6oQ3KGmbdYWaUFCx?=
 =?us-ascii?Q?9yfHSCBmpSKczg7ub9/wtEH1TSk/UdgKjzmjzH6/nqa6kign4o3fKhyGK2HU?=
 =?us-ascii?Q?DqAA72YDQfxgwQ8J02n2NRNrbxjBYNLNgsn6BqeCY9NDqTVfT5gN7T4Un+4i?=
 =?us-ascii?Q?auyT9z3CAg9gMEGhhcI5mZeKHEXo8SBvkNChnWofuYY1bAPXMtZtNvYLzD9N?=
 =?us-ascii?Q?nlwq5xmeoQBLij473VVXUVgkwBqPF1a4fYHWPStTLJ33MjYKRJdf1ubymPzl?=
 =?us-ascii?Q?a/UwSV0SHRCNrao2l5Y3nvEFbUVMsWSMyJf6WW8DxSa3XZpbuHrWVLYiRnsj?=
 =?us-ascii?Q?WAGc98Ga8VWa58ZYE6c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee07cc50-37f9-4947-aeb6-08d9f8289e56
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 06:32:37.9279 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JachHrG9nWrglG0/VBofgmziX+dNHaWR3Nf398CbRA3o8S6UHMChoi40BC8qVNHE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5823
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Monday, February 21, 2022 6:16 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 01/12] drm/amdgpu: Modify .ras_fini function pointer
> parameter
>=20
> Modify .ras_fini function pointer parameter so that it can remove redunda=
nt
[Tao] it can remove -> we can remove

> intermediate calls in some ras blocks.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c   | 8 ++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c | 2 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h | 2 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c  | 2 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h  | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c  | 2 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h  | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c  | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     | 2 +-
>  drivers/gpu/drm/amd/amdgpu/mca_v3_0.c     | 6 +++---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c    | 2 +-
>  drivers/gpu/drm/amd/amdgpu/soc15.c        | 2 +-
>  19 files changed, 24 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 52912b6bcb20..d020c4599433 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -644,7 +644,7 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device
> *adev, struct ras_common_if *r
>  	return r;
>  }
>=20
> -void amdgpu_gfx_ras_fini(struct amdgpu_device *adev)
> +void amdgpu_gfx_ras_fini(struct amdgpu_device *adev, struct
> +ras_common_if *ras_block)
>  {
>  	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX) &&
>  			adev->gfx.ras_if)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index ccca0a85b982..f7c50ab4589c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -387,7 +387,7 @@ bool amdgpu_gfx_is_me_queue_enabled(struct
> amdgpu_device *adev, int me,  void amdgpu_gfx_off_ctrl(struct amdgpu_devi=
ce
> *adev, bool enable);  int amdgpu_get_gfx_off_status(struct amdgpu_device
> *adev, uint32_t *value);  int amdgpu_gfx_ras_late_init(struct amdgpu_devi=
ce
> *adev, struct ras_common_if *ras_block); -void amdgpu_gfx_ras_fini(struct
> amdgpu_device *adev);
> +void amdgpu_gfx_ras_fini(struct amdgpu_device *adev, struct
> +ras_common_if *ras_block);
>  int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
>  		void *err_data,
>  		struct amdgpu_iv_entry *entry);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 26e31c53ed0d..5dcb341cae19 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -455,16 +455,16 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device
> *adev)  void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)  {
>  	if (adev->umc.ras && adev->umc.ras->ras_block.ras_fini)
> -		adev->umc.ras->ras_block.ras_fini(adev);
> +		adev->umc.ras->ras_block.ras_fini(adev, NULL);
>=20
>  	if (adev->mmhub.ras && adev->mmhub.ras->ras_block.ras_fini)
> -		adev->mmhub.ras->ras_block.ras_fini(adev);
> +		adev->mmhub.ras->ras_block.ras_fini(adev, NULL);
>=20
>  	if (adev->gmc.xgmi.ras && adev->gmc.xgmi.ras->ras_block.ras_fini)
> -		adev->gmc.xgmi.ras->ras_block.ras_fini(adev);
> +		adev->gmc.xgmi.ras->ras_block.ras_fini(adev, NULL);
>=20
>  	if (adev->hdp.ras && adev->hdp.ras->ras_block.ras_fini)
> -		adev->hdp.ras->ras_block.ras_fini(adev);
> +		adev->hdp.ras->ras_block.ras_fini(adev, NULL);
>  }
>=20
>  	/*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> index b7fbc114a175..0f224e21cd55 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> @@ -24,7 +24,7 @@
>  #include "amdgpu.h"
>  #include "amdgpu_ras.h"
>=20
> -void amdgpu_hdp_ras_fini(struct amdgpu_device *adev)
> +void amdgpu_hdp_ras_fini(struct amdgpu_device *adev, struct
> +ras_common_if *ras_block)
>  {
>  	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP) &&
>  	    adev->hdp.ras_if)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
> index aabd59aa5213..c05cd992ef8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
> @@ -44,5 +44,5 @@ struct amdgpu_hdp {
>  };
>=20
>  int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev, struct
> ras_common_if *ras_block); -void amdgpu_hdp_ras_fini(struct amdgpu_device
> *adev);
> +void amdgpu_hdp_ras_fini(struct amdgpu_device *adev, struct
> +ras_common_if *ras_block);
>  #endif /* __AMDGPU_HDP_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
> index 42413813765a..6dfcedcc37fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
> @@ -24,7 +24,7 @@
>  #include "amdgpu.h"
>  #include "amdgpu_ras.h"
>=20
> -void amdgpu_mmhub_ras_fini(struct amdgpu_device *adev)
> +void amdgpu_mmhub_ras_fini(struct amdgpu_device *adev, struct
> +ras_common_if *ras_block)
>  {
>  	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB)
> &&
>  			adev->mmhub.ras_if)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
> index 240b26d9a388..253f047379cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
> @@ -47,6 +47,6 @@ struct amdgpu_mmhub {
>  	struct amdgpu_mmhub_ras  *ras;
>  };
>=20
> -void amdgpu_mmhub_ras_fini(struct amdgpu_device *adev);
> +void amdgpu_mmhub_ras_fini(struct amdgpu_device *adev, struct
> +ras_common_if *ras_block);
>  #endif
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> index f09ad80f0772..0de2fdf31eed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> @@ -44,7 +44,7 @@ int amdgpu_nbio_ras_late_init(struct amdgpu_device
> *adev, struct ras_common_if *
>  	return r;
>  }
>=20
> -void amdgpu_nbio_ras_fini(struct amdgpu_device *adev)
> +void amdgpu_nbio_ras_fini(struct amdgpu_device *adev, struct
> +ras_common_if *ras_block)
>  {
>  	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__PCIE_BIF)
> &&
>  			adev->nbio.ras_if)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> index f9546c7341b8..3222e1cae134 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> @@ -105,5 +105,5 @@ struct amdgpu_nbio {  };
>=20
>  int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct
> ras_common_if *ras_block); -void amdgpu_nbio_ras_fini(struct amdgpu_devic=
e
> *adev);
> +void amdgpu_nbio_ras_fini(struct amdgpu_device *adev, struct
> +ras_common_if *ras_block);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 143a83043d7c..7cddaad90d6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -491,7 +491,7 @@ struct amdgpu_ras_block_object {
>  	int (*ras_block_match)(struct amdgpu_ras_block_object *block_obj,
>  				enum amdgpu_ras_block block, uint32_t
> sub_block_index);
>  	int (*ras_late_init)(struct amdgpu_device *adev, struct ras_common_if
> *ras_block);
> -	void (*ras_fini)(struct amdgpu_device *adev);
> +	void (*ras_fini)(struct amdgpu_device *adev, struct ras_common_if
> +*ras_block);
>  	ras_ih_cb ras_cb;
>  	const struct amdgpu_ras_block_hw_ops *hw_ops;  }; diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 3b5c43575aa3..863035a94bd8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -111,7 +111,7 @@ int amdgpu_sdma_ras_late_init(struct amdgpu_device
> *adev,
>  	return r;
>  }
>=20
> -void amdgpu_sdma_ras_fini(struct amdgpu_device *adev)
> +void amdgpu_sdma_ras_fini(struct amdgpu_device *adev, struct
> +ras_common_if *ras_block)
>  {
>  	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA) &&
>  			adev->sdma.ras_if)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 8b226ffee32c..34ec60dfe5e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -118,7 +118,7 @@ int amdgpu_sdma_get_index_from_ring(struct
> amdgpu_ring *ring, uint32_t *index);  uint64_t
> amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring, unsigned vmid);  in=
t
> amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
>  			      struct ras_common_if *ras_block); -void
> amdgpu_sdma_ras_fini(struct amdgpu_device *adev);
> +void amdgpu_sdma_ras_fini(struct amdgpu_device *adev, struct
> +ras_common_if *ras_block);
>  int amdgpu_sdma_process_ras_data_cb(struct amdgpu_device *adev,
>  		void *err_data,
>  		struct amdgpu_iv_entry *entry);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index 9400260e3263..41e976733c57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -162,7 +162,7 @@ int amdgpu_umc_ras_late_init(struct amdgpu_device
> *adev, struct ras_common_if *r
>  	return r;
>  }
>=20
> -void amdgpu_umc_ras_fini(struct amdgpu_device *adev)
> +void amdgpu_umc_ras_fini(struct amdgpu_device *adev, struct
> +ras_common_if *ras_block)
>  {
>  	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC) &&
>  			adev->umc.ras_if)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> index e4b3678a6685..c8deba8dacb5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> @@ -73,7 +73,7 @@ struct amdgpu_umc {
>  };
>=20
>  int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct
> ras_common_if *ras_block); -void amdgpu_umc_ras_fini(struct amdgpu_device
> *adev);
> +void amdgpu_umc_ras_fini(struct amdgpu_device *adev, struct
> +ras_common_if *ras_block);
>  int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
>  		void *ras_error_status,
>  		bool reset);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 77b65434ccc2..27421811f2f0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -743,7 +743,7 @@ static int amdgpu_xgmi_ras_late_init(struct
> amdgpu_device *adev, struct ras_comm
>  	return amdgpu_ras_block_late_init(adev, ras_block);  }
>=20
> -static void amdgpu_xgmi_ras_fini(struct amdgpu_device *adev)
> +static void amdgpu_xgmi_ras_fini(struct amdgpu_device *adev, struct
> +ras_common_if *ras_block)
>  {
>  	if (amdgpu_ras_is_supported(adev,
> AMDGPU_RAS_BLOCK__XGMI_WAFL) &&
>  			adev->gmc.xgmi.ras_if)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 1997f129db9c..3ecb238c6483 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2433,7 +2433,7 @@ static int gfx_v9_0_sw_fini(void *handle)
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>=20
>  	if (adev->gfx.ras && adev->gfx.ras->ras_block.ras_fini)
> -		adev->gfx.ras->ras_block.ras_fini(adev);
> +		adev->gfx.ras->ras_block.ras_fini(adev, NULL);
>=20
>  	for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
>  		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> index b4b36899f5c6..02c50be19d3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> @@ -37,7 +37,7 @@ static void mca_v3_0_mp0_query_ras_error_count(struct
> amdgpu_device *adev,
>  				         ras_error_status);
>  }
>=20
> -static void mca_v3_0_mp0_ras_fini(struct amdgpu_device *adev)
> +static void mca_v3_0_mp0_ras_fini(struct amdgpu_device *adev, struct
> +ras_common_if *ras_block)
>  {
>  	amdgpu_mca_ras_fini(adev, &adev->mca.mp0);  } @@ -83,7 +83,7 @@
> static void mca_v3_0_mp1_query_ras_error_count(struct amdgpu_device *adev=
,
>  				         ras_error_status);
>  }
>=20
> -static void mca_v3_0_mp1_ras_fini(struct amdgpu_device *adev)
> +static void mca_v3_0_mp1_ras_fini(struct amdgpu_device *adev, struct
> +ras_common_if *ras_block)
>  {
>  	amdgpu_mca_ras_fini(adev, &adev->mca.mp1);  } @@ -115,7 +115,7
> @@ static void mca_v3_0_mpio_query_ras_error_count(struct amdgpu_device
> *adev,
>  				         ras_error_status);
>  }
>=20
> -static void mca_v3_0_mpio_ras_fini(struct amdgpu_device *adev)
> +static void mca_v3_0_mpio_ras_fini(struct amdgpu_device *adev, struct
> +ras_common_if *ras_block)
>  {
>  	amdgpu_mca_ras_fini(adev, &adev->mca.mpio);  } diff --git
> a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index e26c39fcd336..d0a9012e53d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1997,7 +1997,7 @@ static int sdma_v4_0_sw_fini(void *handle)
>=20
>  	if (adev->sdma.ras && adev->sdma.ras->ras_block.hw_ops &&
>  		adev->sdma.ras->ras_block.ras_fini)
> -		adev->sdma.ras->ras_block.ras_fini(adev);
> +		adev->sdma.ras->ras_block.ras_fini(adev, NULL);
>=20
>  	for (i =3D 0; i < adev->sdma.num_instances; i++) {
>  		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index b7c24149a6bd..34cd5cad7da5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1215,7 +1215,7 @@ static int soc15_common_sw_fini(void *handle)
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>=20
>  	if (adev->nbio.ras && adev->nbio.ras->ras_block.ras_fini)
> -		adev->nbio.ras->ras_block.ras_fini(adev);
> +		adev->nbio.ras->ras_block.ras_fini(adev, NULL);
>=20
>  	if (adev->df.funcs &&
>  	    adev->df.funcs->sw_fini)
> --
> 2.25.1
