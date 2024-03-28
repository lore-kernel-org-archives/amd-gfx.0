Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50645C54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 03:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B46AD10E2DA;
	Thu, 28 Mar 2024 03:33:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kV5AcF5D";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E1D310E2DA
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 03:33:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lwr5OkmpRBLiwTxhXXY7r6l0/X7ZwcKSUFJwszvGAZ6RbCHON5W0D3sEDXpAu+2Q/cFPU5CUraLcLNrTpSeCf0F0TFy31B1bjnlaZ79clCWtyn4nXGxZeQgT5JL/7CrxWRI5djuu7lzgSCGDC5KzC6FVQedWq1KjvJuYU/fif3Xrh0/UWd9elFFpFWOMPCVH57UD4eKtZ+pWBFO+EOsEwasXXRJttygsApD75sQHUwD9M0oVSreKg1lmbXwu+grOoJTUoqOOy+cCni5n23VMxRaMIa3Kf7nHn0OhssAk72HaFMN5dbtNoYFaHmkG9OrrXWjC4irkZB5nBNFUDxRkiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUTJDBufvXnLW25LKcgNRyguLhmQNaHvoTsEKtR1Nz8=;
 b=BmZ+hx6JUnxCTyD3lLTpe+j2z1iO2gWM02WsXsphxCEqWVwf3DwW0Df+3iYVwSyQeOjKYLMfEU7yxZjBgAkhzTY7OsDke4zcec705YHlBf/GGTSpZJGFt6GNR1AqSYUe6pdR4yiV/BM6E1LVDbL6yJFtqxstWsr053nVZ+bPnq4VzTDIqYZj4kAgwjY4Wj9CO2ei/hujudvuILhQarvP47/HwY6xsSlvfamxwsKLtATnF9oayJfsjBq3ciI2WrEJ7n4gYG+vY3owTdTaBbSDXxc8SGZE0NdODaust7fiPwVTIWUdgrgifGFVvS7L8KNb/pzy/k5+BRvYeSlYVgHPSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUTJDBufvXnLW25LKcgNRyguLhmQNaHvoTsEKtR1Nz8=;
 b=kV5AcF5DYCFD5sVG6YZEjobDJA5gTC4ZUtEwd7o1o7JsaufzmKpm3dMUJoE6FHbYWynBxvQ4h6/aUthVup2A3evulkkbTIHMhIwTuUVorAPC3PzAHpxDE93WulkuOtUi3Bqs755hV86yxqeP1cv98pS1OKosIXGarV/wle/CQWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA0PR12MB8838.namprd12.prod.outlook.com (2603:10b6:208:483::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 03:33:26 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 03:33:26 +0000
Message-ID: <49b2226e-ac39-48d8-9fb9-aa725a9fbaea@amd.com>
Date: Thu, 28 Mar 2024 09:03:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] drm/amd/pm: Add PMFW message and capability flags
Content-Language: en-US
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240328023544.820248-1-lijo.lazar@amd.com>
 <20240328023544.820248-2-lijo.lazar@amd.com>
 <PH7PR12MB599784C8DC7295A8D239B126823B2@PH7PR12MB5997.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <PH7PR12MB599784C8DC7295A8D239B126823B2@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA0PR12MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f80ac14-0519-429f-ec10-08dc4ed7d40c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcExCVPDAgqtHsEaQsmtqrCYAT2b9kbDX2kxmriz+3k8Eg2wTTWbsItCkR0Tu6EJXv1u7HSerE4w/pWVr9MGDzFCzSRFWZ/TlqXPkhDOL+/1DefWqE1NrG5XDmIkoD4BI3zyPkM/vhNCsqtieRNHTVcHDSEXa5mhSmGwN1UuzLSuIUVOv+R6tSMWCC/bIIlMf59JT7oO6aPS5iRD+blTDjb0ZwqDWY60me9kDqTwnM8Z3f+vAo7PhDqCKtgNRwzZGt1u/4W0w+FORDwSY+uIIPNseaYip9+NAR/mCCT8UilOCT2GqihDMAIHhvCHNKxSu3u9xA67N5qTb9HHjkzqow3y5BjE8IVkFSuVaXKXhDJhq55RkVoIyhRsaXVEcgEGxr+3xoGxdyNG2nyhmpHJjdGvplRM6KUw4eXnPhwQo1IYdzOHCuSi/v5SMuVS2YyiMAiMETNe6rdKJueomVxZAiBrMJdg2PE13XZURem4V4ziONjXWSeJLeeZoCFRRbnfoA4ixRr82WUdnSyvjAIHfIeiV78EdfzCmO27XoG/U1SbTgjf6OrjpGvtJAuZOwIJzDbS8W/chJaFWAxYn9z+M57yQiMn1kex0nzcx60kCMFtFdDppMQfXQBov+/kVL7MOqr2DM9eRDxvJCwusx607SkbzYga4DhVexPCBQfViJc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2dWSERjZm9jMHFWL01Za3c5c25JSUxpZ3VLQXBmYUl0VXZNUXRyd2VrRDhI?=
 =?utf-8?B?NDdJNytoQzdxaUMrQk5oOGdRN0Y0bUlhelRNNEdCWGk1VXJINnIvTW00L0xR?=
 =?utf-8?B?ci9VRkk2WGJlU3JaQXFYdEIvM0RnQ0IybjlVUHEwL3BySURlQW5vWlJUZi9C?=
 =?utf-8?B?V0FsbVladXlwQ3B6V3pldmdzWlFNTEZ2d0pBQXlhekpIR1kvUldwam9zcm90?=
 =?utf-8?B?bFppcGl6Vlp5am1sR3J4N3ZXcjBUOEY4T1ZIYzVUaTNCNU9lZVB3SnRxaWpK?=
 =?utf-8?B?bm9ZcGMybGg0TXk2cU01ak03SmFFZ01yVFIxdzVPWHpLKzk2S0ZMcnBZQ3RO?=
 =?utf-8?B?SjVzVkg5bCtnUDNJTEY3S3FzaHFRZ0Zlak9BOGIyRk84YlI5aTFDQ3J3alBa?=
 =?utf-8?B?VVBkcVFaTVkvSFJ1NS9XNDhnb2QxQ2ZyTGt0dUF5b0RtOHJvTEgyS1VXbnJ0?=
 =?utf-8?B?SU5rd0JZa3pvZUNRZGpFSTZ1bnlvYjM0eTA4NVNWeXVqVXowU2w5aDV3VkMw?=
 =?utf-8?B?L1lpZEVYODJ4cUJMb0podktiVityS0hMVk9pMHpUMU5HVEYwZlJON0J5UjRL?=
 =?utf-8?B?N2xYRXZYeW8waFV5VVJuQWN0b0s1MGlSY29xTXBHSDlNdm5ldUpRNTVZR1Ns?=
 =?utf-8?B?R2tUeTB3Tk9TcGZ5MWJycHNnUW9QM3BoYXUvSWFTNjJWU21YMEdjamZqTG5Q?=
 =?utf-8?B?L3NET3RRRTVhYUh2NEpRbjBDNU4wS0JHc1kwQUtCODdJZ3ZicWFLcjgxTjBF?=
 =?utf-8?B?OTlXVE9tVnJrUTAySDZyNlZTNFRaK1djVHB3ZzY4bGY4bkloU0NYRG5yRXdw?=
 =?utf-8?B?OVZjT2lZMlByYXFFVkFwVVdnRVFjSnlPdHFicjdnd0RUamlqeXQvcmQwK3o1?=
 =?utf-8?B?SHhZekNTYmFsL1FLdFhJaGRuTkpBMkVrNjE5ZkxaTGlKckhYWGM0V3p1NmVr?=
 =?utf-8?B?dDl2UEtZRjJZa2RPS2Y3VW5RQ0JqcEx3bWprK0FmQ1ArNjJnRGc4N083K0dl?=
 =?utf-8?B?N3k2QWFjb0NuOWpqbktCK3IyNlY0VE05SXJVZ3hvd0Vpb0xNcDFlbEtWNGEz?=
 =?utf-8?B?cDVmWXF6aCt6L3N3VUVmaUZZVllPTkswMURBUGtBTGJKTnRzc1l6WmQ4SmFS?=
 =?utf-8?B?dnhUVUplYlBnMVJKNUQzazBnUU9WS1lUdG5KSitsOUlYWFlQUzNFZnBseXZZ?=
 =?utf-8?B?ak1tbmN2dXJIcDdBa295dEU5VGJJWmZUQjJEUEYyUm04MUtDQUpXVlRwcFk5?=
 =?utf-8?B?YzF2dktIQThTREpqZW5MWkFxaGk4L0RYUWpDOFdtR1ZRU3h0OGxNdklzZ1Rt?=
 =?utf-8?B?RHl0QVJCRGVSL2tiNVVIaXE2Vm04K1VPOWFzWmRzMXAvTTZ2WENBeGJKUVJ6?=
 =?utf-8?B?TDk3bGJmZFNnYnVWWlhJc3pNY0p2WnBjNlovL1NDQWJmVVBCc0R2US92VTc0?=
 =?utf-8?B?dDdqSXZlV21ySlpSdml0cTBWcTVYMnZjNkFmZUZjdFZ5YktjM3FLZWk2b255?=
 =?utf-8?B?MmtwRU5qWWtNZ3VSUEJkNHNobGFENUdEdk9VRElYcGg1L3ZMWTRmd2xWNlpt?=
 =?utf-8?B?WXBWdHlISGRzcVl2Q2taMTNRSk9JcFpUR0NyUTM0V0k4akRxazhSRUwwdGhG?=
 =?utf-8?B?OFJKR0JaanpGbm5Ra2ZCbFkyM1REeHZJakcyLysyaUROa1ZpMko5Rk4vcEhU?=
 =?utf-8?B?RUwyMjRXMXQ0dU9pME9QaytlL3NGdWp5bUNuZC93N3BXYlhEVkkzN2xHbEpM?=
 =?utf-8?B?WEJUajlaRFR2MElsU0VvWGpGeGtsQjBHWDRJNE5EOExna0hZd1l0Wkd6aU9Y?=
 =?utf-8?B?S3VHU1p3Z1RaVnRxUTNIN0pZaklVVllhOXFNb1JVY3drczZKanpVU2Z4RmJs?=
 =?utf-8?B?NkF0aHI1SzRKWkJ4dTFaQlBEam1HZkZsR3MxazJHdFlGY2N0VStBMFlYazlX?=
 =?utf-8?B?UGZtYjNZdS92QzgxQW50T1hQdGp5K1g0YkFTSUJ1L0Zyb3JvbGE4TEVDQVRQ?=
 =?utf-8?B?dk9abkJTL1d0bEhMWHJnL1IrU0dTK05rVmUwblNLMzhGWDI1aWlyOVFaK2pF?=
 =?utf-8?B?ZlhxOUdFcHZ3NFdWeDFmbHpVWHRHL0ZSSUdhR05PT2R5OFhFUVdZV0F2Zmx0?=
 =?utf-8?Q?TGgex8Rtc0g4YdKLhJYajU8fG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f80ac14-0519-429f-ec10-08dc4ed7d40c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 03:33:26.5725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAP/q+oTLEWjZVGDz1jKAIRmJZBK8OsY9yNegndYCA4HWCi66bB1JUju/7sG6Ob1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8838
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



On 3/28/2024 8:57 AM, Wang, Yang(Kevin) wrote:
> [AMD Official Use Only - General]
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Lazar
> Sent: Thursday, March 28, 2024 10:36 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Subject: [PATCH v2 2/4] drm/amd/pm: Add PMFW message and capability flags
> 
> Add flags to categorize messages and PMFW capabilities.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 3 ++-  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  | 7 +++++++
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 2 +-
>  3 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index a870bdd49a4e..aa835df7ba1a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -458,7 +458,7 @@ struct smu_umd_pstate_table {  struct cmn2asic_msg_mapping {
>         int     valid_mapping;
>         int     map_to;
> -       int     valid_in_vf;
> +       uint32_t flags;
>  };
> 
>  struct cmn2asic_mapping {
> @@ -538,6 +538,7 @@ struct smu_context {
>         uint32_t smc_driver_if_version;
>         uint32_t smc_fw_if_version;
>         uint32_t smc_fw_version;
> +       uint32_t smc_fw_caps;
> 
>         bool uploading_custom_pp_table;
>         bool dc_controlled_by_gpio;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index af427cc7dbb8..c48214e3dc8e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -445,4 +445,11 @@ enum smu_feature_mask {
>         SMU_FEATURE_COUNT,
>  };
> 
> +/* Message category flags */
> +#define SMU_MSG_VF_FLAG                        (1U << 0)
> +#define SMU_MSG_RAS_PRI                        (1U << 1)
> +
> +/* Firmware capability flags */
> +#define SMU_FW_CAP_RAS_PRI             (1U << 0)
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index b8dbd4e25348..3227e514e8ae 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -437,7 +437,7 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
>                         return -EINVAL;
> 
>                 if (amdgpu_sriov_vf(smu->adev) &&
> -                   !msg_mapping.valid_in_vf)
> +                   !(msg_mapping.flags & SMU_MSG_VF_FLAG))
>                         return -EACCES;
> [kevin]:
> 
> Is it possible to use smc_fw_caps uniformly to handle sriov cases (likes FED/ras msg.flags) , which would look more reasonable?
> +       smu->smc_fw_caps |= SMU_FW_CAP_VF ?

Presently, most FW support handling VF messages which is why another
capability is not added.

Messages need to be categorized even if FW capability is there.

Thanks,
Lijo

> 
> Best Regards,
> Kevin
> 
>                 return msg_mapping.map_to;
> --
> 2.25.1
> 
