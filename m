Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A652C55167
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 08:05:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0B4810F1D7;
	Fri, 31 Jul 2026 08:05:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JARpPiBe";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011022.outbound.protection.outlook.com [52.101.57.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4269D10F1D7
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 08:05:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyvRMgGqbiHcQvrPJ71/xhZzhXMADystyMOA8ZZtwBUqamGOPM6H9v187ygelx3YdJ/5FziBZgYiYsoFVNe7MVhpJS6hXKhuALf6YGDUfQ7XPsloHSm3SWPCQ77Z7zpT2xAz8AP/nM9PGiBta8EIi6sMEEecSJ5+TB7jPRt3EWUEBVwr4pDfqqQUzoz47pI45z6MxdkiYY0lRsfEox5idpneJ5PO7ru9yYOKIl7KEhmmz6EJYbQOJYSa9kdC7pR/sNfLygX/Z1eveeIJ2P3u7qw9ZDV66aXLTzsq6+Kgkt/SQ2pCzVXDDEywx8TTaSQEH30ne/AGoZraloQcaNRSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxkq6UKR1xRr2jlGuC14ZUeQ1+UjuEeH/soUzvGVgKg=;
 b=G48kqcWpm8KzWG91ZhkjgNApFYieyWGlD9JpHQIgq0wHuwnEpsOakrfX2j1AvW44s/tloVZZwnXORHhDuPBaVJfmJtQzecgglpt+Nsl6e9UoDxG6u6b9T+d5iO8j07qgFj6xczL+oulRKJod+OkdWNrR83IKlHExWKSTyOYTAgeaxzTxTpfBkky81wnhbqg+uDLSKKN2gctCufNpCaM9ZIUSg4j1XzduqSdZ3w1HM/t1PCsmRDv4istZTvNCc2F+WdGaVfupYS9PQIedRkO/VkvVZk6l36gkvWP+Mlic0ceh5U6oDbAc3r0hopgz67ExSOSEjOyIFP1g2y9mwR/tqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxkq6UKR1xRr2jlGuC14ZUeQ1+UjuEeH/soUzvGVgKg=;
 b=JARpPiBeUyqgqmQlLIwh3MArvhzQ2e2IntNT9b261lf8Og3LiSXRaahgn2fpEUR2pZb9QPBmomqXtyRjgcTOgM0cv92IaqcO528majUM3+M1bV14EVchckFo9O3NJSXSThsQ9KClt/j04X2J1rRg8ymBF4iEYhZm6alyn5n/8k8=
Received: from BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24)
 by SJ2PR12MB8738.namprd12.prod.outlook.com (2603:10b6:a03:548::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 08:05:32 +0000
Received: from BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a]) by BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 08:05:32 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 3/4] drm/amd/pm: refactor user PPT policy save and restore
Thread-Topic: [PATCH 3/4] drm/amd/pm: refactor user PPT policy save and restore
Thread-Index: AQHdIJo02ZVaAn1utkGCKItVbvdcT7aHEPIAgAAcarCAABJ2AIAAAPeg
Date: Fri, 31 Jul 2026 08:05:31 +0000
Message-ID: <BN9PR12MB52114F26DFDDB7845449E15482C82@BN9PR12MB5211.namprd12.prod.outlook.com>
References: <cover.1785467079.git.kevinyang.wang@amd.com>
 <2a1bf8c187a6b6a67169fda0e6551a062af56c77.1785467079.git.kevinyang.wang@amd.com>
 <c4cd5c4c-00e5-41cb-b049-8e668270bbcf@amd.com>
 <BN9PR12MB5211E9C9924BF1CCD56ACF5A82C82@BN9PR12MB5211.namprd12.prod.outlook.com>
 <64d8e874-9b20-4ef7-8b61-9b1fa08a1278@amd.com>
In-Reply-To: <64d8e874-9b20-4ef7-8b61-9b1fa08a1278@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-31T07:48:37.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5211:EE_|SJ2PR12MB8738:EE_
x-ms-office365-filtering-correlation-id: df9e2e9f-7720-4fa0-0b80-08deeeda7e21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|11063799006|4143699003|5023799004|10067099003|6133799003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: KkOOnLyCqFTOF6l9865RPkMwd34k5/rl/tf01IdYXRRBLVSAd11SA6tVQqy6oXUKlQ5DQINWVtT+GYrA89j5rS2IIj1wn8tFisjgfbVgmlRiVzGaikv2xJdyoTJ3EbQxSy09qWX6+Chgklpc0gUZuFdAXfLxTc141E0UulVQ+ZxnXqxcsj13hO5xIw2qiYNfOR56u1mYYMMmfdhq5G8rUseHZNexzHKqVLUP3+qKUaMzejTCK+xiqzVKqbXwu9Tot/SHldQMl2Hon1j8XkZCaOHcOqSLjPXv+EXkQgfx8ued31Po1KkMlJngDgdUSlM/qs0Y1LLRvfCkx0ndzBn0JAkI26joRqMqNhKVZ4hCDa0/hGxTEbePPlo1P5HNznNtVHm038/mK9LoHT2tWlFEQR+95Sq43iJ1ZTKuHlvRPZZttNhcSwFaLpWblcJaqtI1bEvZmNcXlVflkrZMiVp2N+iV73gpLTcngJyLbhhJKiklia400ISUuUgvExu9g0rJpTKqLuo+q8BnRX3l9JbELZ5UKMiwMHZ2jH+yj8sLvc491TQzq/DpCsSdkzBY2dmLsKg8oL1gXwTWuRYmQuZXGdlR6rOdq8nDaNdzvc7tDoy2je78OFF8dBLdAUexqVnUj6egZ0f0yO9kcPCawV2h5/6WT+XVvZpm+AMU3s5MfTfGoY+j3CmvrQWw9W7k+Jo7A9JTsKwEs9Y4UoHUZyzFYm4UQapoy7bbEsjIFjG1Wz0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5211.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(4143699003)(5023799004)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5sHkfvs+5zytekEAnCItWy1WEqaWwHzz8ICsH3ejw8W98UGQTOduhcC1P2td?=
 =?us-ascii?Q?zrMqFp3P/lwhfxGuJGWL+ZiILg8fw3tNJdjAtXYFvBrKfvnpGwqLfutUshOz?=
 =?us-ascii?Q?JiPxNBBUhK+c5vhj1H2NcATm4AX+VrdUC5vN5/XKSPs5Yb+Yxa9wVeUj99xM?=
 =?us-ascii?Q?Ytx74AKtnAGybsr1XmYu6y64z5jFYKGb83eejLTSKXBAenx1is13v2SmqvWb?=
 =?us-ascii?Q?Vz7A67CmUkkULPQ/7cj/OHtJg5R7idtd0rqxg26TBmjo2M+cUIEEpdIbFU8L?=
 =?us-ascii?Q?sLVkDbtkAL7fs21ZU+veUdnCbS8SvAQsGiarkAXMVJwDVAZqr0XxhfdI3y5v?=
 =?us-ascii?Q?+FJS1N1cyDhE2lEuCNvzWsSoFFUWpA0u3/XlQBenno5nvo+oRoyajl9/RMFk?=
 =?us-ascii?Q?KWLYJvp6cZ1uwFsUYasgh0afp6jByIf6yMZcZFuYiKC6NFU6ddHxBgTmkqJ8?=
 =?us-ascii?Q?cS3DaKxFG+fO0ROmaHWi0UEYfjX6/oYzxGrKpVAMVXFGbni0Zv8HBnZ1w5yR?=
 =?us-ascii?Q?mnmwtGTOgwPf8RqK6OyLEqVK5d109HFOg2IlfpvHBvTHLQJdOI8QowplWrAz?=
 =?us-ascii?Q?2tqKbs7XzXnD7op4HijTubEWKMMS/Q5LR1DFvQKmDVC4tZa1Jh6WA1COOQ3O?=
 =?us-ascii?Q?RKkNzLg7c820kkruEJDZAQubpA7zEcZSVlhqc/0dGOp2H75QOKIpGOinehjI?=
 =?us-ascii?Q?uN7kx3AF51F0OE8GQg732k2g2cE1aYnkNVVGOnHmbAawIl2HKJowhWJqq/Hu?=
 =?us-ascii?Q?Xo9xMxbemQyoA/l/prD7z2iWEjg62qiSkGifCKts5MGlm8nD9rdy3WUNTa4Z?=
 =?us-ascii?Q?VnoG/QpvPsxNHr0Mo5ra9LYLcKB5K1jAhIG52qq23TixRZN+cFqHH+wVtdDW?=
 =?us-ascii?Q?+jRQZx9rbf9MDAS5NthdPXLrcDb4bjiazNTdoS/SY/FwybyCsnSpC/BRgW0n?=
 =?us-ascii?Q?0aeTgr2T62oGVS2nP2euRWDpvql1/zm395oU0l8EIax7bBp+QcYf0xDbJGtj?=
 =?us-ascii?Q?yESvQcM+pfxJ93hJLesJb4hdwVOe6TiYcoRcCFcZMPjReXxJSTOwTIT7/ae5?=
 =?us-ascii?Q?RrD+plAGAWKryqoR0vpYFUOVonQgz1AMP5b/JYyIwVfohugE1Q8pVJdTdvr0?=
 =?us-ascii?Q?w1iAhTYWboDjMQqntyPxHTua6m2kvfhtJWqTWDQtRkd4+be2TSkW9txCZIHQ?=
 =?us-ascii?Q?AlyjhCYbNN4itGR0tZNnE1hGyOEHgQ2bXHjy8n/UhT5qSRy4Z5Bp+MtRxS0m?=
 =?us-ascii?Q?zgUvwNPrFvaSwl59tftd8g3RhzftOeeAdV+pb0T2r3JpcOGS9S73iKIdy9Nb?=
 =?us-ascii?Q?CDq14Y3kpCrlAesMhkX6YpDJGBYFqR80+aXUJ+3yCl3vmpVXp0JNKSr62g48?=
 =?us-ascii?Q?4cSTmXkNEZsaNawUGWpfcCJjkvh1lkJd+/tivYjGVHYc+QrWs+m1nFlafzQ0?=
 =?us-ascii?Q?RL3x2NYQahrvYS2A6dIllf3QFb/aJoSr9o+f3hPHaq89alnnlP4/Bwj/2mUp?=
 =?us-ascii?Q?1T2JGRZ8Bssa/Qe8IIcBM4U/ffoduhSHmQ11pYZiT81Ab1rtgqkMyqFHGi+r?=
 =?us-ascii?Q?zGjbI6HBgTGF55LwCeILgv09z0HqgmCrMFud+qy8rexi7E7Jq81xEMYZdC/P?=
 =?us-ascii?Q?npRTf6InKnRWPGLMADO1WGOF83ZrBWycf/wNXgeYE68SLl74OY1f27cAqia9?=
 =?us-ascii?Q?tqaObNXPrOe0KTztpIIga+yvfEJMZxpknT4bv7vdq7QBTe+j?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5211.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9e2e9f-7720-4fa0-0b80-08deeeda7e21
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 08:05:31.9050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yTzzJ/do0NpQdy4FcqRLXHNUpA3opszat2XeFnbQ1x0hiYeTbRb7VzgAyWhvWzp4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8738
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

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Friday, July 31, 2026 3:45 PM
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
> Subject: Re: [PATCH 3/4] drm/amd/pm: refactor user PPT policy save and
> restore
>
>
>
> On 31-Jul-26 12:21 PM, Wang, Yang(Kevin) wrote:
> > AMD General
> >
> >> -----Original Message-----
> >> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> >> Sent: Friday, July 31, 2026 12:57 PM
> >> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
> >> gfx@lists.freedesktop.org
> >> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
> >> <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
> >> Subject: Re: [PATCH 3/4] drm/amd/pm: refactor user PPT policy save
> >> and restore
> >>
> >>
> >>
> >> On 31-Jul-26 8:40 AM, Yang Wang wrote:
> >>> The existing user policy representation has three ambiguities:
> >>>
> >>> - A numeric value cannot distinguish explicit zero from an unset poli=
cy.
> >>> - One value per controller cannot preserve independent AC and DC
> >> requests.
> >>> - Suspend-only restore misses runtime resume, GPU reset, and table
> reload.
> >>>
> >>> Refactor policy storage and restore as follows:
> >>>
> >>> - Store values and validity masks by power source and PPT controller.
> >>> - Save writes against the active source.
> >>> - Restore the active source after default SMU setup.
> >>> - Reapply the target policy after live AC/DC transitions.
> >>> - Use the target source default when no explicit request exists.
> >>>
> >>> The late-init path now covers system resume, runtime resume, GPU
> >>> reset, and custom PPTable reload. Common code owns persistent
> >>> policy; PMFW continues to own effective current limits.
> >>>
> >>> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  2 +-
> >>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 89
> +++++++++++++-
> >> -----
> >>>    drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 +-
> >>>    3 files changed, 68 insertions(+), 28 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> >>> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> >>> index c3688b3b12cc..ce526db4d24a 100644
> >>> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> >>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> >>> @@ -508,7 +508,7 @@ void amdgpu_pm_acpi_event_handler(struct
> >> amdgpu_device *adev)
> >>>                      amdgpu_dpm_notify_ac_dc(adev);
> >>>
> >>>              if (is_support_sw_smu(adev))
> >>> -                   smu_set_ac_dc(adev->powerplay.pp_handle);
> >>> +                   smu_set_ac_dc(adev->powerplay.pp_handle, true);
> >>>
> >>>              mutex_unlock(&adev->pm.mutex);
> >>>      }
> >>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >>> index 99d42446cfc8..43d5dd7dce7e 100644
> >>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >>> @@ -488,12 +488,52 @@ static void
> >> smu_set_user_clk_dependencies(struct smu_context *smu, enum
> smu_clk_
> >>>              return;
> >>>    }
> >>>
> >>> +static void smu_restore_ppt_limits(struct smu_context *smu,
> >>> +                              bool restore_defaults) {
> >>> +   enum smu_power_src_type power_source;
> >>> +   struct smu_ppt_limit_range *range;
> >>> +   uint32_t restore_mask;
> >>> +   uint32_t limit;
> >>> +   int i, ret;
> >>> +
> >>> +   power_source =3D smu->adev->pm.ac_power ?
> >>> +           SMU_POWER_SOURCE_AC : SMU_POWER_SOURCE_DC;
> >>> +   restore_mask =3D smu-
> >>> user_dpm_profile.ppt_limit_user_mask[power_source] &
> >>> +           smu->ppt_limits.supported_mask;
> >>> +   if (!restore_mask && !restore_defaults)
> >>> +           return;
> >>> +
> >>> +   smu->user_dpm_profile.flags |=3D
> >> SMU_DPM_USER_PROFILE_RESTORE;
> >>> +
> >>> +   for (i =3D SMU_PPT_LIMIT_PPT0; i < SMU_LIMIT_TYPE_COUNT; i++) {
> >>> +           if (!(smu->ppt_limits.supported_mask & BIT(i)))
> >>> +                   continue;
> >>> +
> >>> +           if (restore_mask & BIT(i)) {
> >>> +                   limit =3D smu-
> >>> user_dpm_profile.ppt_limits[power_source][i];
> >>> +           } else if (restore_defaults) {
> >>> +                   range =3D &smu->ppt_limits.range[power_source][i]=
;
> >>> +                   limit =3D range->default_value;
> >>
> >> This should be restore the current limit before a suspend/reset and
> >> not the default limit. The current limit could be set through out of
> >> band also, user profile values won't reflect that.
> >
> > Please check the call sites.
> >
> > The quoted default path is an opt-in fallback for AC/DC policy restore,=
 and it
> is not used for suspend or GPU reset.
> > Suspend and reset invoke smu_restore_ppt_limits(smu, false), which repl=
ays
> only limits recorded in user_dpm_profile.
> >
>
> Yes, I'm specifically talking about late_init path. It gets called after =
a suspend
> or reset. It's about a case where user dpm limit is not present.
>
> > The profile intentionally does not represent out-of-band state, and
> > the amdgpu driver has no ownership or synchronization contract for PMFW
> limits changed outside the driver.
> > Supporting that use case requires separate policy and should be address=
ed
> in a separate change.
> >
>
> This only requires restoring the current limit after a suspend or reset w=
hen
> called from smu late init if a user specified limit is not found.
> It doesn't need to revert to default limit.

Yes, the restore function takes no action if no custom limits are set by th=
e user.
And the logic has been verified on the target system, including suspend, re=
set and default cases.

Best Regards,
Kevin
>
> Thanks,
> Lijo
>
> > Best Regards,
> > Kevin
> >> Thanks,
> >> Lijo
> >>
> >>> +           } else {
> >>> +                   continue;
> >>> +           }
> >>> +
> >>> +           ret =3D smu_set_ppt_limit(smu, i, limit);
> >>> +           if (ret)
> >>> +                   dev_err(smu->adev->dev,
> >>> +                           "Failed to restore PPT%d limit: %d\n", i,=
 ret);
> >>> +   }
> >>> +
> >>> +   smu->user_dpm_profile.flags &=3D
> >> ~SMU_DPM_USER_PROFILE_RESTORE; }
> >>> +
> >>>    /**
> >>>     * smu_restore_dpm_user_profile - reinstate user dpm profile
> >>>     *
> >>>     * @smu:  smu_context pointer
> >>>     *
> >>> - * Restore saved user power limits, clock frequencies and fan settin=
gs.
> >>> + * Restore saved user clock frequencies and fan settings.
> >>>     */
> >>>    static void smu_restore_dpm_user_profile(struct smu_context *smu)
> >>>    {
> >>> @@ -509,17 +549,6 @@ static void smu_restore_dpm_user_profile(struct
> >> smu_context *smu)
> >>>      /* Enable restore flag */
> >>>      smu->user_dpm_profile.flags |=3D
> >> SMU_DPM_USER_PROFILE_RESTORE;
> >>>
> >>> -   /* set the user dpm power limits */
> >>> -   for (int i =3D SMU_PPT_LIMIT_PPT0; i < SMU_LIMIT_TYPE_COUNT; i++)=
 {
> >>> -           if (!smu->user_dpm_profile.ppt_limits[i])
> >>> -                   continue;
> >>> -           ret =3D smu_set_ppt_limit(smu, i,
> >>> -                                       smu-
> >>> user_dpm_profile.ppt_limits[i]);
> >>> -           if (ret)
> >>> -                   dev_err(smu->adev->dev,
> >>> -                           "Failed to set %d PPT limit value\n", i);
> >>> -   }
> >>> -
> >>>      /* set the user dpm clock configurations */
> >>>      if (smu_dpm_ctx->dpm_level =3D=3D
> >> AMD_DPM_FORCED_LEVEL_MANUAL) {
> >>>              enum smu_clk_type clk_type; @@ -932,7 +961,7 @@ static
> >>> int smu_late_init(struct amdgpu_ip_block
> >> *ip_block)
> >>>       * is unnecessary.
> >>>       */
> >>>      adev->pm.ac_power =3D power_supply_is_system_supplied() > 0;
> >>> -   smu_set_ac_dc(smu);
> >>> +   smu_set_ac_dc(smu, false);
> >>>
> >>>      if ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, =
0,
> >>> 1))
> >> ||
> >>>          (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, =
0,
> >>> 3))) @@ -967,6 +996,8 @@ static int smu_late_init(struct
> >>> amdgpu_ip_block
> >> *ip_block)
> >>>              return ret;
> >>>      }
> >>>
> >>> +   if (adev->in_suspend)
> >>> +           smu_restore_ppt_limits(smu, false);
> >>>      smu_restore_dpm_user_profile(smu);
> >>>
> >>>      return 0;
> >>> @@ -2746,7 +2777,7 @@ static int
> >> smu_set_watermarks_for_clock_ranges(void *handle,
> >>>      return smu_set_watermarks_table(smu, clock_ranges);
> >>>    }
> >>>
> >>> -int smu_set_ac_dc(struct smu_context *smu)
> >>> +int smu_set_ac_dc(struct smu_context *smu, bool restore_ppt_policy)
> >>>    {
> >>>      int ret =3D 0;
> >>>
> >>> @@ -2754,17 +2785,22 @@ int smu_set_ac_dc(struct smu_context
> *smu)
> >>>              return -EOPNOTSUPP;
> >>>
> >>>      /* controlled by firmware */
> >>> -   if (smu->dc_controlled_by_gpio)
> >>> -           return 0;
> >>> +   if (!smu->dc_controlled_by_gpio) {
> >>> +           ret =3D smu_set_power_source(smu,
> >>> +                                      smu->adev->pm.ac_power ?
> >>> +                                      SMU_POWER_SOURCE_AC :
> >>> +                                      SMU_POWER_SOURCE_DC);
> >>> +           if (ret) {
> >>> +                   dev_err(smu->adev->dev, "Failed to switch to %s
> >> mode!\n",
> >>> +                           smu->adev->pm.ac_power ? "AC" : "DC");
> >>> +                   return ret;
> >>> +           }
> >>> +   }
> >>>
> >>> -   ret =3D smu_set_power_source(smu,
> >>> -                              smu->adev->pm.ac_power ?
> >> SMU_POWER_SOURCE_AC :
> >>> -                              SMU_POWER_SOURCE_DC);
> >>> -   if (ret)
> >>> -           dev_err(smu->adev->dev, "Failed to switch to %s mode!\n",
> >>> -                  smu->adev->pm.ac_power ? "AC" : "DC");
> >>> +   if (restore_ppt_policy)
> >>> +           smu_restore_ppt_limits(smu, true);
> >>>
> >>> -   return ret;
> >>> +   return 0;
> >>>    }
> >>>
> >>>    const struct amd_ip_funcs smu_ip_funcs =3D { @@ -3020,8 +3056,11 @=
@
> >>> static int smu_set_ppt_limit(void *handle, uint32_t limit_type,
> >>> uint32_t
> >> limit)
> >>>      ret =3D smu->ppt_funcs->set_ppt_limit(smu, limit_type, limit);
> >>>      if (ret)
> >>>              return ret;
> >>> -   if (!(smu->user_dpm_profile.flags &
> >> SMU_DPM_USER_PROFILE_RESTORE))
> >>> -           smu->user_dpm_profile.ppt_limits[limit_type] =3D limit;
> >>> +   if (!(smu->user_dpm_profile.flags &
> >> SMU_DPM_USER_PROFILE_RESTORE)) {
> >>> +           smu-
> >>> user_dpm_profile.ppt_limits[power_source][limit_type] =3D limit;
> >>> +           smu->user_dpm_profile.ppt_limit_user_mask[power_source]
> >> |=3D
> >>> +                   BIT(limit_type);
> >>> +   }
> >>>
> >>>      return 0;
> >>>    }
> >>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> >>> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> >>> index 3d32ee723b8e..698197a285e3 100644
> >>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> >>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> >>> @@ -251,7 +251,8 @@ enum smu_memory_pool_size {
> >>>
> >>>    struct smu_user_dpm_profile {
> >>>      uint32_t fan_mode;
> >>> -   uint32_t ppt_limits[SMU_LIMIT_TYPE_COUNT];
> >>> +   uint32_t
> >> ppt_limits[SMU_POWER_SOURCE_COUNT][SMU_LIMIT_TYPE_COUNT];
> >>> +   uint32_t ppt_limit_user_mask[SMU_POWER_SOURCE_COUNT];
> >>>      uint32_t fan_speed_pwm;
> >>>      uint32_t fan_speed_rpm;
> >>>      uint32_t flags;
> >>> @@ -1953,7 +1954,7 @@ int smu_set_soft_freq_range(struct
> smu_context
> >>> *smu, enum pp_clock_type clk_type
> >>>
> >>>    int smu_set_gfx_power_up_by_imu(struct smu_context *smu);
> >>>
> >>> -int smu_set_ac_dc(struct smu_context *smu);
> >>> +int smu_set_ac_dc(struct smu_context *smu, bool
> >>> +restore_ppt_policy);
> >>>
> >>>    int smu_set_xgmi_plpd_mode(struct smu_context *smu,
> >>>                         enum pp_xgmi_plpd_mode mode);
> >

