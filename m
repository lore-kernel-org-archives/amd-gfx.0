Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A22C19F2D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Aug 2022 17:05:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0199894E04;
	Tue,  9 Aug 2022 17:05:11 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08B9A94A03
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Aug 2022 17:04:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqYLIHJrq5PoWfHkswrOf+UnXt37gL0wQvyTd9zwjgDlAwWN/Evva5kToFFtA1C+l+/Fe2CJ4T+TcfFN/tc1CXJjM2TiZUvPlqZgk3QZ1qpfpItt/55UzmOJrfazhQ6zg7e3nVkC8F9q3do+PQ5vB/SzPIz6F3br4PukDdz/nQExubbfN7IUtJD8VjQaGoSET796D57RA3hYiWLg92+9dlmaWR8HTRoaaWyKQy1LQOVeqyC537lzNC+S4mjuv0E8OMSJTGDrA4CZj1Z7uPgKlGnEsBDV1TNk6gM4q6ck6gw+lel6x0OUd+SOiwT7mLN0sLxzoF3cpSFPc06Bg5MzVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJUyinVzJDvlG3SrY66IkC9Ft/ragX5o3cUhZnccTCc=;
 b=dBoNCooE6RcY6HDvAX3aV7Gzp2BVZ+BliZ5epBoycYLK7DhEzfDuVVyNHof+kSS+ZAq9w395af0oIyKl0pSn8rqrMDXGaTM7zIfjvNXUpNKJx2gnZNOfB0xSTDbuR3NJVLOI/rFST77H+gWE++WJcczkvGGoMdVenRwUr6FKNo61LZ+qQUrokGn+e43+sVyR6zK9/7FibNauxapwXekvt49nhKu4j9vFirwCPHu3gUnOtlkCGRFQv7S7foRuYx33U4lPnA2F6ta7rvvLEFoopUgIXWpZzrVaC7BLt+PHNshaTgf25b675CQM6Khl2digIkm69XeKzGgipLTb36ccOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJUyinVzJDvlG3SrY66IkC9Ft/ragX5o3cUhZnccTCc=;
 b=tOvxMXgL5B0n1psq2U1BEDhqmPb5BZMFsoy71cYHZiMwFq687F5YTSld41pu4S8DXPckhG/zqbZiIwyGWm6SiRJGDCRGuD0l9NztOZCdG+ygqb8DBuEwb0oi9V4MBjw9AslPu0MX7fzXth3tVW0OHRWDXyjM2+wCSI7IU9r4Co8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 17:04:53 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f832:8c21:41ee:5876]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f832:8c21:41ee:5876%9]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 17:04:53 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, "Milinkovic, Dusica" <Dusica.Milinkovic@amd.com>
Subject: Re: [PATCH] Increase tlb flush timeout for sriov
Thread-Topic: [PATCH] Increase tlb flush timeout for sriov
Thread-Index: AQHYpxfT6ZS0zUSi1kmQBa2JzW6uXq2lgnSAgAAcZYCAATcmjw==
Date: Tue, 9 Aug 2022 17:04:53 +0000
Message-ID: <BL1PR12MB5144B0E91F2FB97B3B0A7545F7629@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220803090134.529299-1-dusica.milinkovic@amd.com>
 <CADnq5_ODjyTHPpGcsuHpbmaC-_MXvzKq7xXVKY9e5q7bwRBAfw@mail.gmail.com>
 <CH0PR12MB537246946D63A6599FD167CAF4639@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB537246946D63A6599FD167CAF4639@CH0PR12MB5372.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-09T17:04:53.028Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5c97710-a957-43a9-2ad1-08da7a294757
x-ms-traffictypediagnostic: BY5PR12MB4307:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qNRd5UM+pGoxjYai8dyEcoJh+LoMrlGyb2kKQq8xXoJM+qG5Y5qBXouJPzCjx4losp9VWpNDOrf04n2QE8/GmZYWb/ZqVgwNJQeRpCnJ0drS9ZJYP3cwWGX/fLg5m7gfHHDqwSpgbS0ydaiOvZoAAIIhQtbZtdHXyy4VE74cddqb2A7bRi09adEltU2ygWgDxROR3RZOFc5ydcgLsUDotnH7kBcc/o6jGkha+CXcU9c+GQUGnT74qlz7jrffveUoWe5GhgJB3sHO8P1M9WfzQew1S4KsZgtwHwvUqCGpjRaG/v1B3cQOoAYbL2dXaeXhfkQXgTWmU5h/xplnvVI/u7h7NWAYKI91Wq3Oo44YcG5bp8Pc02PzK/nJCQFmbk0wjgcxXABt6BJuPZ2FUAOQUs1BsfVRHFRGVnmWPWTMU//7wcev3FjKjw4fTYS1t1QXLrIPZ7ftF3p+tuUeYt2rFjeKtPmHgRbpZujDq5PhvwxMkoC8he6rpe13a7aBKKqNWGthRb+eRG5b/ABAtEIpw0D5KkVkF8hS193oMVSvxJfE0EWO39mnI5oTRBf+NsuCvE8UuYSa3+Hrs0gSyISK7nCFHcmiqAFwo+wICN3dwnTZ9hVdmmqa0CBxNfkjS6wHzMg1jCmURgnC86U3NXy8VTwJhk1JV2V7kta7cLxSuEsEa7yhij6DCY0Y45d1D63St8QgOCk0dUrZza4X+f+zgrYkOJT5XcMGA1+S40h/dxqFhJqDOxrMrNYr4SqbbfVkIn4pMvW+fN68oNXBgpVOM6Na5zqCjp6pkcfR6uQ8zC9v3211gxoHhdTy3LBCrWC1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(478600001)(316002)(110136005)(71200400001)(41300700001)(6636002)(4326008)(6506007)(2906002)(55016003)(8676002)(66446008)(66946007)(66556008)(64756008)(66476007)(5660300002)(8936002)(76116006)(52536014)(38100700002)(122000001)(19627405001)(38070700005)(33656002)(86362001)(186003)(9686003)(53546011)(7696005)(83380400001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zh2Kv+eiz42qtKKSAaDagYRJb1ekRvttJCmZVI33Tr6Tsc+2bwt4/AJ7Ma9B?=
 =?us-ascii?Q?QDeQ5uZYdry5Ptbe+kmseV26oK0QmCw3e/VCO3AGQkeLcRsfR2CzqArj8R+c?=
 =?us-ascii?Q?TEdwLYfeCQVhHsLEkbIk4L5aqYoT5DFZCqwILoTOokOOE0T+73JsFcc6Uo/w?=
 =?us-ascii?Q?Wt54k9geZDQVXl6LhX5/2Y9OT6638I7uZj5gM2YVyDp7UwBy1puA94pqNzYP?=
 =?us-ascii?Q?4dRlJA1atV6QOJ1F2fmRJWWOFEVRjByg3gju/w7mqoGyNJLONLERpcOcoBby?=
 =?us-ascii?Q?YYkb3kEHTIQUQQN6FfXu8hcZbZmoIQqWY1GTbNruEr0x2stb6dHevRcLWWf/?=
 =?us-ascii?Q?9Xh43gLylZZFbQkD39gaPAR5d2m93oM4gtqopYB5OwZbH8GFPP911mPAd+oN?=
 =?us-ascii?Q?47DOIvoBD2cETCNZvDp/x5hFcWyf1il3EcNr4Rlbg9qAk9ND4kEExHm4coZi?=
 =?us-ascii?Q?8k+4J2J8oFUwl6eZvtyM0ONLlJ0dXKfrmuQaW91Bm4YAM29MiIqR8AAgKTuj?=
 =?us-ascii?Q?7qKciISCUBUVDU+raM8l/NPTCoSvE5hFZ71kN1yCMMyyEonnTK+CDHCswlHX?=
 =?us-ascii?Q?3iJkWA50FL1N2E1x7B3VQqpeE7ZelgA8CalpI+ohdg+Mexdno4s8eHCOOq2Z?=
 =?us-ascii?Q?XDwzWudqLCjfufdvkORCM7wjJcOeSS2uNO2D8vz8Q44sY8TnKh57bJiyOMUa?=
 =?us-ascii?Q?iFAzpQDgKhbOutnsG0lGsJznB04apnC4bZeeHnKwJXVQCVGGPt4TJw2oOC+d?=
 =?us-ascii?Q?fgOEmzgiwM0slfyD7aU3fz3SQFpLb9EgCxprzoDkARn1Ca13jZrGATifstXk?=
 =?us-ascii?Q?TQ8kmgJWfU0B4Oom/cQJVtEwkGLz6qNH3Io8cv4S3eWS12wXcgrch6VXQ3Rz?=
 =?us-ascii?Q?PdRA2KKQ3VlgT4mV+uEs8A+1k4uK6YJVI/HeEOJrJY5bneNB/N46alVg5qUN?=
 =?us-ascii?Q?V1u2hSrLu8UATiplLMRZ3hBM9ghw2KZqoBYHwJehfnpnV8uhSd8heXHF5u0A?=
 =?us-ascii?Q?i+Y3ZDcnIsBlQp/rN2uVXWt+oWAlWaehgUUYn6GwBvmExyAPVKHf/ELnZNOM?=
 =?us-ascii?Q?4J8Gu37yXCJ/pgtOEAZEf5hIvRzwbGJI9SsqWpC9frWJkkhZPNtbzPOWGAZN?=
 =?us-ascii?Q?C3vWeoHF7uDvrkAaNy21S5f2upZ8ooRe2NuCuZaFYggLkALpGh4d6nATSVWq?=
 =?us-ascii?Q?4liWBQBbB7Nv14B87L4Oov/pCNPw/FgDfEdw6zeNiV7JyrxzERLLs4Tbd8TH?=
 =?us-ascii?Q?SlWzO/Qw4C8YRpEkSsY3ZOn/pFi/38bN5x7yYumffvc4q+ePbmVMkZvKltHY?=
 =?us-ascii?Q?lXQFua0aW5TovD9FyqrM3nbQodQZKdqOGWH10fEUA50pmo/P7hYpRwDvV5Oa?=
 =?us-ascii?Q?FzBGRMLzrKsPfvbYImX5CXoI3Rzb1Eo1tjeO2jd2PkakEQjSPCRWTOJ4wEQt?=
 =?us-ascii?Q?10UlHxdsszMdw4v+to2M8Vn3rsx/BEO370s4moS8gcb9PuEiIaSCe4OAt16F?=
 =?us-ascii?Q?E28P3mUKXpPNULKepeEegh3gXbTUFNRZtTrK7gyCgLSLxy0kPv3k31SQoKAD?=
 =?us-ascii?Q?/cKJr/7rD8rN8IYtMf4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144B0E91F2FB97B3B0A7545F7629BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c97710-a957-43a9-2ad1-08da7a294757
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 17:04:53.5333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t4jWe+E1EyHoUJVNcnusMDozMlNGfOGr3K0Am6yG+fLppD89HSMultPTKEBoXXyQlx0tjo+vn5WEL+JaZ8Ln/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144B0E91F2FB97B3B0A7545F7629BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Please add these details to the patch description when you respin.
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Liu, Sha=
oyun <Shaoyun.Liu@amd.com>
Sent: Monday, August 8, 2022 6:30 PM
To: Alex Deucher <alexdeucher@gmail.com>; Milinkovic, Dusica <Dusica.Milink=
ovic@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] Increase tlb flush timeout for sriov

As I discussed with Alice ,this change is when multi-vf running compute ben=
chmark (Luxmark) at the same time, which involves multiple vf  do the tlb i=
nvalidation at the same time. They observed kiq timeout after submit the tl=
b invalidate command. Although each vf has the invalidate register set, but=
 from hw, the invalidate requests are queue to execute.

Alice, as we discussed, we can use maximum 12*100ms for the timeout , it sh=
ouldn't be 6000ms. Did you see issues with 1200 ms timeout?

Regards
Shaoyun.liu
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexdeucher@gmail.com>
Sent: August 8, 2022 4:49 PM
To: Milinkovic, Dusica <Dusica.Milinkovic@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] Increase tlb flush timeout for sriov

On Wed, Aug 3, 2022 at 5:02 AM Dusica Milinkovic
<dusica.milinkovic@amd.com> wrote:
>

Please include a patch description.  Why do you need a longer timeout?
 What problem does it fix?

> Signed-off-by: Dusica Milinkovic <dusica.milinkovic@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 6 +++++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v10_0.c
> index 9ae8cdaa033e..6ab7d329916f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -419,6 +419,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgp=
u_device *adev,
>         uint32_t seq;
>         uint16_t queried_pasid;
>         bool ret;
> +       uint32_t sriov_usec_timeout =3D 6000000;  /* wait for 12 * 500ms =
for SRIOV */
>         struct amdgpu_ring *ring =3D &adev->gfx.kiq.ring;
>         struct amdgpu_kiq *kiq =3D &adev->gfx.kiq;
>
> @@ -437,7 +438,10 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdg=
pu_device *adev,
>
>                 amdgpu_ring_commit(ring);
>                 spin_unlock(&adev->gfx.kiq.ring_lock);
> -               r =3D amdgpu_fence_wait_polling(ring, seq, adev->usec_tim=
eout);
> +               if (amdgpu_sriov_vf(adev))
> +                       r =3D amdgpu_fence_wait_polling(ring, seq, sriov_=
usec_timeout);
> +               else
> +                       r =3D amdgpu_fence_wait_polling(ring, seq, adev->=
usec_timeout);

What about something like this?
u32 usec_timeout =3D amdgpu_sriov_vf(adev) ? 6000000 :
adev->usec_timeout;  /* wait for 12 * 500ms for SRIOV */
...
r =3D amdgpu_fence_wait_polling(ring, seq, usec_timeout);


>                 if (r < 1) {
>                         dev_err(adev->dev, "wait for kiq fence error: %ld=
.\n", r);
>                         return -ETIME;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index 22761a3bb818..941a6b52fa72 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -896,6 +896,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu=
_device *adev,
>         uint32_t seq;
>         uint16_t queried_pasid;
>         bool ret;
> +       uint32_t sriov_usec_timeout =3D 6000000;  /* wait for 12 * 500ms =
for SRIOV */
>         struct amdgpu_ring *ring =3D &adev->gfx.kiq.ring;
>         struct amdgpu_kiq *kiq =3D &adev->gfx.kiq;
>
> @@ -935,7 +936,10 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgp=
u_device *adev,
>
>                 amdgpu_ring_commit(ring);
>                 spin_unlock(&adev->gfx.kiq.ring_lock);
> -               r =3D amdgpu_fence_wait_polling(ring, seq, adev->usec_tim=
eout);
> +               if (amdgpu_sriov_vf(adev))
> +                       r =3D amdgpu_fence_wait_polling(ring, seq, sriov_=
usec_timeout);
> +               else
> +                       r =3D amdgpu_fence_wait_polling(ring, seq, adev->=
usec_timeout);

Same comment here.

Alex

>                 if (r < 1) {
>                         dev_err(adev->dev, "wait for kiq fence error: %ld=
.\n", r);
>                         up_read(&adev->reset_domain->sem);
> --
> 2.25.1
>

--_000_BL1PR12MB5144B0E91F2FB97B3B0A7545F7629BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Please add these details to the patch description when you respin.<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Liu, Shaoyun &lt;Shaoyun.Liu@=
amd.com&gt;<br>
<b>Sent:</b> Monday, August 8, 2022 6:30 PM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;; Milinkovic, Dusica &=
lt;Dusica.Milinkovic@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> Re: [PATCH] Increase tlb flush timeout for sriov</font>
<div>&nbsp;</div>
</div>
<div>
<div style=3D"font-family:inherit; font-size:inherit; color:inherit"></div>
<div>As I discussed with Alice ,this change is when multi-vf running comput=
e benchmark (Luxmark) at the same time, which involves multiple vf&nbsp; do=
 the tlb invalidation at the same time. They observed kiq timeout after sub=
mit the tlb invalidate command. Although
 each vf has the invalidate register set, but from hw, the invalidate reque=
sts are queue to execute.
</div>
<div><br>
</div>
<div>Alice, as we discussed, we can use maximum 12*100ms for the timeout , =
it shouldn't be 6000ms. Did you see issues with 1200 ms timeout?</div>
<div><br>
</div>
<div>Regards</div>
<div>Shaoyun.liu</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexdeuche=
r@gmail.com&gt;<br>
<b>Sent:</b> August 8, 2022 4:49 PM<br>
<b>To:</b> Milinkovic, Dusica &lt;Dusica.Milinkovic@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> Re: [PATCH] Increase tlb flush timeout for sriov</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">On Wed, Aug 3, 2022 at 5:02 AM Dusica Milinkovic=
<br>
&lt;dusica.milinkovic@amd.com&gt; wrote:<br>
&gt;<br>
<br>
Please include a patch description.&nbsp; Why do you need a longer timeout?=
<br>
&nbsp;What problem does it fix?<br>
<br>
&gt; Signed-off-by: Dusica Milinkovic &lt;dusica.milinkovic@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 6 +++++-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp; | 6 +++++-<br>
&gt;&nbsp; 2 files changed, 10 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/=
amd/amdgpu/gmc_v10_0.c<br>
&gt; index 9ae8cdaa033e..6ab7d329916f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
&gt; @@ -419,6 +419,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct am=
dgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t seq;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t queried_pasid=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sriov_usec_timeout =3D =
6000000;&nbsp; /* wait for 12 * 500ms for SRIOV */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ri=
ng =3D &amp;adev-&gt;gfx.kiq.ring;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_kiq *kiq=
 =3D &amp;adev-&gt;gfx.kiq;<br>
&gt;<br>
&gt; @@ -437,7 +438,10 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct a=
mdgpu_device *adev,<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_commit(ring);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;adev-&gt;gfx.kiq.ring_lock);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; r =3D amdgpu_fence_wait_polling(ring, seq, adev-&gt;usec_ti=
meout);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgp=
u_fence_wait_polling(ring, seq, sriov_usec_timeout);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgp=
u_fence_wait_polling(ring, seq, adev-&gt;usec_timeout);<br>
<br>
What about something like this?<br>
u32 usec_timeout =3D amdgpu_sriov_vf(adev) ? 6000000 :<br>
adev-&gt;usec_timeout;&nbsp; /* wait for 12 * 500ms for SRIOV */<br>
...<br>
r =3D amdgpu_fence_wait_polling(ring, seq, usec_timeout);<br>
<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 1) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
ev_err(adev-&gt;dev, &quot;wait for kiq fence error: %ld.\n&quot;, r);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
eturn -ETIME;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v9_0.c<br>
&gt; index 22761a3bb818..941a6b52fa72 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; @@ -896,6 +896,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amd=
gpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t seq;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t queried_pasid=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sriov_usec_timeout =3D =
6000000;&nbsp; /* wait for 12 * 500ms for SRIOV */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ri=
ng =3D &amp;adev-&gt;gfx.kiq.ring;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_kiq *kiq=
 =3D &amp;adev-&gt;gfx.kiq;<br>
&gt;<br>
&gt; @@ -935,7 +936,10 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct am=
dgpu_device *adev,<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_commit(ring);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;adev-&gt;gfx.kiq.ring_lock);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; r =3D amdgpu_fence_wait_polling(ring, seq, adev-&gt;usec_ti=
meout);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgp=
u_fence_wait_polling(ring, seq, sriov_usec_timeout);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgp=
u_fence_wait_polling(ring, seq, adev-&gt;usec_timeout);<br>
<br>
Same comment here.<br>
<br>
Alex<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 1) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
ev_err(adev-&gt;dev, &quot;wait for kiq fence error: %ld.\n&quot;, r);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
p_read(&amp;adev-&gt;reset_domain-&gt;sem);<br>
&gt; --<br>
&gt; 2.25.1<br>
&gt;<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB5144B0E91F2FB97B3B0A7545F7629BL1PR12MB5144namp_--
