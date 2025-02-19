Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71852C021B0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 17:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D5B810E86A;
	Wed, 19 Feb 2025 17:48:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yi7sCK0e";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A43B10E86A
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 17:48:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MA9qGB2E9TkAe8W1gmAu822bUIYtrb5TtpGtqBR999RTS5zyrirzznY56Gt/01tJmFwuwYY9SqqR+Bag5R2+rDI1SVnLDrdX/0tWCQzl7cj6j0c7jA01uX8TUaSc+lq6KXDjL0OKaryAZn237GdaLZRtT4wKVVw5aZS6BhZqSYtcyl8a6NI92jsQV9teeZtLYMo7X6JhwzZTu6+Ck0uyzg/evYWsEaJry4eOyqMXXTHujIrIn2U3MGfHiUTTSDLdmUitDTC1v5rcwaBTZyEn3aPukv+E4apNzjAN64cEGdzH9NndBWO1dFI8znY5s1hHqkqnUgkAqIVl/ep+1hDuHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvaL5i95yVS/agCZBqW5yUMfyeAQyU1I6cPnUSuoiP0=;
 b=Qg8F+KAxxLdPTK7Kgs4SOXYfsHyqB9F3hMh8VRM8Yx+ISw/Iw3mD/NoUkrPL8PVJm2h2M8jTWseaSeWWg+AZRv4wEhaYODWYb51oIkbXgvU91KTqmmc4UHT9Z1u/kU6l9FNSE3bo9FeYaoco/7mUgcHusE/PUUA3u1jgXaszXLpVcafsz+WFflT3Qc1LPhCVlkkRO/K7ISzkJjFUkLBAreYwGU/focEn3PAeeLJ0sVT80bwHn5zHKCW8zA+0L8drjPpzR/hX1CevB4OyKVBU3d2ZIuz/lRGYDzahvE9suseA1CahUvzFnnkDUH2f5nW+x+By+XVuadhtTbhNE6L/kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvaL5i95yVS/agCZBqW5yUMfyeAQyU1I6cPnUSuoiP0=;
 b=yi7sCK0e9/Ql+kC1np90T9WRhJbVH93vS8PMaAWH4EMsuTaa883j8nthYRWi2Ufj5KlU0NlrpzYfuIaZr4VkHyDd6HGO8KMfJzkYEh+tInu2oOIBvWGtcVs+srm5i1mk5iJ67S20mCZgtzRpoOO9CtOo8eanA+IOISUdVU03lgA=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by IA0PR12MB8303.namprd12.prod.outlook.com (2603:10b6:208:3de::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 17:48:48 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 17:48:48 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH v7 1/9] drm/amdgpu/kfd: Add shared SDMA reset
 functionality with callback support
Thread-Topic: [PATCH v7 1/9] drm/amdgpu/kfd: Add shared SDMA reset
 functionality with callback support
Thread-Index: AQHbfdrGgoCb2NafC06vJXETeCx9NrNO8EXA
Date: Wed, 19 Feb 2025 17:48:48 +0000
Message-ID: <BL1PR12MB51443C8B08F5718E2CEC0A71F7C52@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250213054715.3121445-1-jesse.zhang@amd.com>
In-Reply-To: <20250213054715.3121445-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=c20acfab-3796-40c3-9c8a-58516ab6850d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-19T17:45:34Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|IA0PR12MB8303:EE_
x-ms-office365-filtering-correlation-id: bd3c2380-898e-4906-e004-08dd510da9b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?GEzjeiwdFcNRmVUh6vMqS3Nwgqi8rt9vCl5JFcaIq7RvmrRNlnr4pLyeUiO5?=
 =?us-ascii?Q?j1UlWD4wqxjBWuS+HW1SXILR+AdOyciT8FEXKniSbRJJ4x2t2wqi8fR3yoGp?=
 =?us-ascii?Q?d6sPBkddncUa5QvVAj0ztCLkSj1nR68qAvJuQAhoMGdGJ7trwc7Ji7CGb+oA?=
 =?us-ascii?Q?qGP2KVWzShUQp5e1981FX8mgi3wM5RkyK7BfQ+leuxGSuWbokiD3YKU7NIge?=
 =?us-ascii?Q?GB/HKi5Wg+mHRBlb2fJl6WOaJ8/bgZK3K2g7iniatLStcC1R4pVNwF33N1tn?=
 =?us-ascii?Q?vOZeBoEIZPXbWzyY5Xkn6jIGdzCFxVmZv1+mx4SZkJGL+zNW1RBdFmxBf8cA?=
 =?us-ascii?Q?r9OkLUxoT5RcC3EHqfuyEvXEkywojGHaXFVIbQQaKGYrZztuMouLjnSj8p1q?=
 =?us-ascii?Q?gpUEnvBn6kurRCmVtUrekhWg5jXEM/2pukyvPwSTiTAmwB6uQaZ83U2VZ5ve?=
 =?us-ascii?Q?GD2mYTD7oqBQFI8txbdyu6UlI4m3A0tyuVGJLG4flTsQQ0NwxjkN2it78j7p?=
 =?us-ascii?Q?0KIR2541twEhNKEQfNKmboaBNxkh7l9B4+168rR5zvx5Mw2GTf/E6wOkSoaw?=
 =?us-ascii?Q?GNi9+XTGPQqsYxYglNncGdCEK660hn76vaqJtLIpxPzobhkSs6NogLWBdD07?=
 =?us-ascii?Q?vd7YqWJMt9xdGuL0lDYsqq98BGM3eg4WEgPyId6QiupHQztYvVuzD020bKw2?=
 =?us-ascii?Q?6YP3kKW7JroBfqvS1QsE1H/Skrtw93beKlYbT6yjbP65hlEKSjVCWcYt1F4+?=
 =?us-ascii?Q?yIFtAunrF0Fi2OPFZOgEKEjIbrXhbS+gLZgOmc6ncWbKch0HyN+Ci9uHqdig?=
 =?us-ascii?Q?0FgQ1yn1ZQ3z1CV7E509T6CSqs5yme7xWttBqFGqfmTwbBS5SH6FzOrWbZ2F?=
 =?us-ascii?Q?AcYOUnMAvyNvQe0YBsGxkBRywhq6QaWrZ/UFI9xexXyJ1Jd0AyCP+03VBVwR?=
 =?us-ascii?Q?Ipiroj+a7dUxZLsKWhBUsQydHau7gSArqWxIldUiKCBNzaoPwi8q54CswxHz?=
 =?us-ascii?Q?i1ZjJjhhoYvH8BcLuiR/Bj5bQbu9qdxbJHRs5eVj3sapg943KUgfgwRO1X3C?=
 =?us-ascii?Q?Tfe/20b78p5xSULX/RuBYZW8x6+UsQWM9bGflf11ICBOctYEKCrBPqSMIj0B?=
 =?us-ascii?Q?9g0iqxz1peEBomuGO7Ck+rIvYrOzt5m7rks5CtZRoPtHUzMeuFo8Fy16x9Ba?=
 =?us-ascii?Q?c7IfnYPEDYy1u4vMXaVUWTHs1+50Jjnd1JfQshyPteNXV/teQ6WNV7cNj6sQ?=
 =?us-ascii?Q?2K7so2n2M8AwapRNk+ZCSuSKM/xXCXDWAbv8gBU1Gh6AnLzOLHBlCZM+UUik?=
 =?us-ascii?Q?HY9rmumLSeSvR4+kdmsBX3ohf3At0LpJuOMwcCFvutesV3nSAkGPEPXb/rS2?=
 =?us-ascii?Q?CdS55uH4+b4OwvraNFQCdlnL9wSfvidhCFrLomxXZ0N+EuLMez9kHQbu9vAM?=
 =?us-ascii?Q?Gp8Am+hIl6sKvGl514Qq+3i9lLmkJU0Z?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NHUBxj1PUOf63RteHNodB1VHnoSgsMwB/r3RrJrhtIB5unv8azPJcImKzfBp?=
 =?us-ascii?Q?LNTZhKd2pTmzd9oiENEITfioQYNsGdmptjvYuqbralc/8vV1gPsHcZEe+E+V?=
 =?us-ascii?Q?kpLr3KvXA2vG64BdDYRcD2xeflIatEzOsIHAf9ieskBuPyLevoXum8Es2hGd?=
 =?us-ascii?Q?id9HELZNMIRrqxTLHmVfVqCQgRHYvE/JwY4Xr1yar0w8dyzM7EKND335eLp7?=
 =?us-ascii?Q?pF4vDo30Pshle9HPESvy8xk6W4uqvWE2RxejoOhiKVKmSKjtWnagHNGkNlQc?=
 =?us-ascii?Q?6TCadVYODkmP6NYF3zMl2ozebB/QSgwIuoHyZ8plrkyL8Pas4K9qSIBqZGFs?=
 =?us-ascii?Q?XrkAKrkW0XVR9T38htB4a+uk73zSALh8tLkueGNCAL6GZwdGxVBr3DOxuEqL?=
 =?us-ascii?Q?tmVGxk5Izx+z3pyPsM9h8Wpfp73AUKB1nN6zu4YX9g1xbdrFgQUHb5u+qBOg?=
 =?us-ascii?Q?lLuXuaQNKRn9FbGGpbXFLp8VkIxlbFcmjkyTej88ku2LPlBW1BE8RVsLHclk?=
 =?us-ascii?Q?3LrzFctOg3q5DKQcQVBu92qgG82t2sC8vZsy5GfZCkfVu5Uz8aoapbFuktsk?=
 =?us-ascii?Q?uUVvBX/FPFhDMlaXdUXc8KPsR0P9S7SjVYak1Hyab9byEL4bPN3QAjzUf9gp?=
 =?us-ascii?Q?LS1LSsOsU9x5Bi3cAGaPUuDLfQf8LuCJEv4xOVFffXJYmHTtp+XQk1xhQEOJ?=
 =?us-ascii?Q?PDjqa6rdnyAaixEuLuubMSoX2mzG5kP4iqPK+XFKn4svASjATvUJyNUtM9Nc?=
 =?us-ascii?Q?yGqdxaIqElzg1rcs9btcYJ+hIiilY0OB0WSyHgJQmcUpP1HBoDlg5fDnOUW/?=
 =?us-ascii?Q?YTdCEUvsGdTlCJ8moN9J1f7ZYGM2eO+pKy7DoKVpTS7Iu+q1SYUzPpxPHFuL?=
 =?us-ascii?Q?3NdVFFP4hMvMpNPCaHAKHAZnxNmV2TzEY78pNwCLyFFGeXNGUNyvywGWo9ge?=
 =?us-ascii?Q?84Q4G5jQikB61unOy9gTsaS+O94lWCkJjSP8+d3ZIB0/TWTVE3c4/JVfjhA3?=
 =?us-ascii?Q?7AjqoZKdrYnLyxiKxFyVclL5m8tAW0+EfTANXHrVm320IdE87y4yuiQAaLq6?=
 =?us-ascii?Q?Kxjj+RIt+nvkbuxzalrw8AXtEbWgy+X1nP7RNhaeKE+OzfKGWozZ9cvMo8+I?=
 =?us-ascii?Q?jmkdYnumb80q7Ogxky1xViKvOUF1iOLX9WguFzl45038kjZUCpINtMvnTLTJ?=
 =?us-ascii?Q?/0NwR7clwhYRb88qN9m6f2hlfKrISmh0QmK79MxLbHTcDi4zLSSe0rz+ui/+?=
 =?us-ascii?Q?XWQ3l2HgoOBVxlW7SjRYiSNx+V88IQY3Ef2fxR2xg5oMiK/qZz5epx9vt1ZK?=
 =?us-ascii?Q?V+cS4vLg6Na6rqVbh3PgMWVjcoe+TArTa87NxStkMNAz8ASAX1nExeubazbk?=
 =?us-ascii?Q?GrDjQNgPIe1Ay9Ud8LsFFrZjgz0tkIgalvWBExzUUDXg0pb7XQS6TcOMcK4R?=
 =?us-ascii?Q?FUVETnsFcub3OYngQgxh0ZhwrvsJ2vKC7u3oqysp2WjHHcrtYr2xB2iYncBh?=
 =?us-ascii?Q?etc+49oKafi+8lyezS9GXcyxb13lwZT/Ug2GhqcUc3I0kzdPoqUP8u1Km3qD?=
 =?us-ascii?Q?u46IRmyob9sZs3f35gI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3c2380-898e-4906-e004-08dd510da9b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 17:48:48.0324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YmRhz+sJwquo3jUTPkE/ShmVUv1wox6etKwtHsgp6vXm5A2hKzra8SwtRz7Uhr1mzFMzyxaqWDKUDLReuYiF1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8303
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

[Public]

Patches 1-2 and 4-9 are:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

For patch 3,  I don't have a strong preference.

Alex


> -----Original Message-----
> From: jesse.zhang@amd.com <jesse.zhang@amd.com>
> Sent: Thursday, February 13, 2025 12:47 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Zhu,
> Jiadong <Jiadong.Zhu@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH v7 1/9] drm/amdgpu/kfd: Add shared SDMA reset functionali=
ty with
> callback support
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> This patch introduces shared SDMA reset functionality between AMDGPU and
> KFD.
> The implementation includes the following key changes:
>
> 1. Added `amdgpu_sdma_reset_queue`:
>    - Resets a specific SDMA queue by instance ID.
>    - Invokes registered pre-reset and post-reset callbacks to allow KFD a=
nd
> AMDGPU
>      to save/restore their state during the reset process.
>
> 2. Added `amdgpu_set_on_reset_callbacks`:
>    - Allows KFD and AMDGPU to register callback functions for pre-reset a=
nd
>      post-reset operations.
>    - Callbacks are stored in a global linked list and invoked in the corr=
ect order
>      during SDMA reset.
>
> This patch ensures that both AMDGPU and KFD can handle SDMA reset events
> gracefully, with proper state saving and restoration. It also provides a =
flexible
> callback mechanism for future extensions.
>
> v2: fix CamelCase and put the SDMA helper into amdgpu_sdma.c (Alex)
>
> v3: rename the `amdgpu_register_on_reset_callbacks` function to
>       `amdgpu_sdma_register_on_reset_callbacks`
>     move global reset_callback_list to struct amdgpu_sdma (Alex)
>
> v4: Update the reset callback function description and
>    rename the reset function to amdgpu_sdma_reset_engine (Alex)
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 73
> ++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |
> 11 ++++  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  2 +-
>  3 files changed, 85 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 174badca27e7..fe39198307ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -460,3 +460,76 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct
> amdgpu_device *adev)
>                       device_remove_file(adev->dev,
> &dev_attr_sdma_reset_mask);
>       }
>  }
> +
> +/**
> + * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset
> +callbacks
> + * @funcs: Pointer to the callback structure containing pre_reset and
> +post_reset functions
> + *
> + * This function allows KFD and AMDGPU to register their own callbacks
> +for handling
> + * pre-reset and post-reset operations for engine reset. These are
> +needed because engine
> + * reset will stop all queues on that engine.
> + */
> +void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device
> +*adev, struct sdma_on_reset_funcs *funcs) {
> +     if (!funcs)
> +             return;
> +
> +     /* Initialize the list node in the callback structure */
> +     INIT_LIST_HEAD(&funcs->list);
> +
> +     /* Add the callback structure to the global list */
> +     list_add_tail(&funcs->list, &adev->sdma.reset_callback_list); }
> +
> +/**
> + * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
> + * @adev: Pointer to the AMDGPU device
> + * @instance_id: ID of the SDMA engine instance to reset
> + *
> + * This function performs the following steps:
> + * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU t=
o save
> their state.
> + * 2. Resets the specified SDMA engine instance.
> + * 3. Calls all registered post_reset callbacks to allow KFD and AMDGPU =
to
> restore their state.
> + *
> + * Returns: 0 on success, or a negative error code on failure.
> + */
> +int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
> +instance_id) {
> +     struct sdma_on_reset_funcs *funcs;
> +     int ret;
> +
> +     /* Invoke all registered pre_reset callbacks */
> +     list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
> +             if (funcs->pre_reset) {
> +                     ret =3D funcs->pre_reset(adev, instance_id);
> +                     if (ret) {
> +                             dev_err(adev->dev,
> +                             "beforeReset callback failed for instance %=
u: %d\n",
> +                                     instance_id, ret);
> +                             return ret;
> +                     }
> +             }
> +     }
> +
> +     /* Perform the SDMA reset for the specified instance */
> +     ret =3D amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
> +     if (ret) {
> +             dev_err(adev->dev, "Failed to reset SDMA instance %u\n",
> instance_id);
> +             return ret;
> +     }
> +
> +     /* Invoke all registered post_reset callbacks */
> +     list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
> +             if (funcs->post_reset) {
> +                     ret =3D funcs->post_reset(adev, instance_id);
> +                     if (ret) {
> +                             dev_err(adev->dev,
> +                             "afterReset callback failed for instance %u=
: %d\n",
> +                                     instance_id, ret);
> +                             return ret;
> +                     }
> +             }
> +     }
> +
> +     return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 5f60736051d1..f91d75848557 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -98,6 +98,13 @@ struct amdgpu_sdma_ras {
>       struct amdgpu_ras_block_object ras_block;  };
>
> +struct sdma_on_reset_funcs {
> +     int (*pre_reset)(struct amdgpu_device *adev, uint32_t instance_id);
> +     int (*post_reset)(struct amdgpu_device *adev, uint32_t instance_id)=
;
> +     /* Linked list node to store this structure in a list; */
> +     struct list_head list;
> +};
> +
>  struct amdgpu_sdma {
>       struct amdgpu_sdma_instance
> instance[AMDGPU_MAX_SDMA_INSTANCES];
>       struct amdgpu_irq_src   trap_irq;
> @@ -118,6 +125,7 @@ struct amdgpu_sdma {
>       struct amdgpu_sdma_ras  *ras;
>       uint32_t                *ip_dump;
>       uint32_t                supported_reset;
> +     struct list_head        reset_callback_list;
>  };
>
>  /*
> @@ -157,6 +165,9 @@ struct amdgpu_buffer_funcs {
>                                uint32_t byte_count);
>  };
>
> +void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device
> +*adev, struct sdma_on_reset_funcs *funcs); int
> +amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
> +instance_id);
> +
>  #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffe=
r_funcs-
> >emit_copy_buffer((ib),  (s), (d), (b), (t))  #define amdgpu_emit_fill_bu=
ffer(adev, ib, s,
> d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 5e0066cd6c51..64c163dd708f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1477,7 +1477,7 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_blo=
ck
> *ip_block)
>       r =3D amdgpu_sdma_sysfs_reset_mask_init(adev);
>       if (r)
>               return r;
> -
> +     INIT_LIST_HEAD(&adev->sdma.reset_callback_list);
>       return r;
>  }
>
> --
> 2.25.1

