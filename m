Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17CCCA9EDD
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 15:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4879110F19E;
	Mon, 12 Oct 2026 15:05:59 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2795D10F19E
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 15:05:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/qUk4ESwt1kzBBZLtmHrqRFDFhg9E9wUKfsjpNL8J6kYflj4cVAFNxzQ2PgoKTyx/Vdg2zEhYBeE5V3Bt2xcoc4I7ECQXnorlib8AqZ1MSnAa7hhXKZfgWTsUGXJVLQGMbjTaxmyPlhTKT1+TY2iQeb2MnEXVIubFmd4wNMn13AIGFpKMNIqLY79dKR15ypIyGQ65hWkoBWl5bUqoc7fnRwmgIUF/5/fy4QjYPZSBFl0jhkZK5jfHg1ZddxWC9YELHWKF2xUak08s35Ebk9iP4q+C6j4aKv8irGjbzh5DyHVMtQEkLK0Lf7UmNjLIBwjohVCKiKlRq18dqVSEa4gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjWXAjJVqcRvyje2nZ4G3KKQzrjBy0WvfZKXx9ZMOG0=;
 b=VWKpx9CTc5QUibdTt1MLrbTwHDetwATCqS3c99C18sa/v/RMfnm3EDrRpmJYxBXRK0DjYzHWkyk6cVHlHtbrb3zSMs25AD2vdBClGLX2iVxZoTF946zFVDR7/Hq9WATki9qHGLtAx13DLdOyH0zpVXAQ3JDv5tWMMuxmZ+UQJXQw5A4DO/525bq9PNUeXn1ni36tnxMIil9JX6kjvyzBS2ePShr79mQDW7FqzX9ahp7aAgk8ZJDiBfNCFY7I0l5lS22AaOixJ8S2GUKidCz6Uno+McOsD4uLoczWEB7jEIIGezg4PpbVrGOvMI6kdieFZJVMMeKpctwS2JdD6H0VWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjWXAjJVqcRvyje2nZ4G3KKQzrjBy0WvfZKXx9ZMOG0=;
 b=RiWpnCnuRDiBxDBNHYEVbVD4mO31I8hrXugjSCVXvODuZXmTOwrFSE6AEU2QOc46BjqBeTamUPCI+Lox2xqrQ/oJJVROHWU0XE0yZWqwdZh/vzTPhokhguWE1sfKh/GijiyUl3uoVceOu4g0f/vw+Y4l0rvY5Hrgin6RyP7pKZs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4129.namprd12.prod.outlook.com (2603:10b6:a03:213::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 15:05:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 15:05:30 +0000
Message-ID: <01bc716f-9862-44e1-aa7f-9d2dfaec44f1@amd.com>
Date: Mon, 12 Oct 2026 17:05:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] drm/amdgpu: Program trap TBA/TMA for kernel-managed
 VMIDs
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Lancelot Six
 <lancelot.six@amd.com>, James Zhu <james.zhu@amd.com>,
 Samuel Pitoiset <hakzsam@gmail.com>, Natalie Vock <natalie.vock@gmx.de>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20261008070542.1111149-1-srinivasan.shanmugam@amd.com>
 <20261008070542.1111149-7-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261008070542.1111149-7-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4129:EE_
X-MS-Office365-Filtering-Correlation-Id: dfe91814-f4ac-40c9-8504-08df287241b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: WHl8GslTv2pDQ7O8ycMH7RBGhnOzL93DAGSh2PZDckB8Usk2byOGqBT4W5gmvIQgfgcfnCtGmCov65d+KVb+IzA4PekKzbo2rEbsr3AYEoPOfI063+5xNlXb5opXrIr0GtbLUszmckrctpkp+1bogGsOlox53M4hTRGpqew9gNHKi2SwASKFxsv9pZdt/G7TqvGYf+Z5bm03Out54mg6mwZDMLayG+lDdYtvhBLUXVw9bo6ZMuDk+i8S7y2Q1dga1d/Nd7k6Ta7wrpphn+axgkfoRtV08ZBYnM9DTDZMYmabQIw7CDNyVkeKL+13tUv3rc40UrgM1gkSkKyhEVW6bj83A/vSGXeiy/wv0iyLhH2yvCkEWJ8qa4y820/lqGQitT7Ik7RMGLahN+JkFbnv5iH/Dx4UwK2qg+PibBi4LWKa39gMfc5/0HQ3YDiKH9Sffmqbs8KP/NB61O5HZyKkgIzg0X8c8PXr1Z9I6JrXgM/APImVhYiMlM7/D4X1Aoz7W8bFCwTnljbi0K/vOcnw8sHaqLPwfSd5WmWBCIW2d0Sy7CvLpzoSexQCCdWT6nY1IUi7J9+HHoylabWLZ8XpqURa94MFSGdiZXD4mV7OJV21zrb9SbAdaE8usVOozcMZQkG5sM/P0Q1Qa0FNWJNFjAWeeWVu/puwA2lLhtLrTHA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWdTc1RUKy9IYlArRXAzNDVIQjBVbXhOU3Nib1lzYlp3UUw2QUxkTUVYcVgv?=
 =?utf-8?B?WEZPcjVvVFpDVDZkRGFZemZiZFU0TnFFOEZrQlgrUWxFalRQcmw1OXhraDU5?=
 =?utf-8?B?azh0azFyczFxVDZsSWdyL3lMSkhFNUlJdVdwdXYySlgrVk9EWVVXT1dnQysx?=
 =?utf-8?B?cSsyOENNWWlFSnE2bEUvZjVDWnB6elFoblFFV3VPTGZRTWV6Zm1tUCtCSitB?=
 =?utf-8?B?Y005VC92NkFzc3pjbFpFcDNpZU5yMllTZW5VWll2aHN3a1lCUHpGNDFES2xY?=
 =?utf-8?B?QW9SdDNqaVR4dFVzK0t3L0w0Q2M4MkEvdkpMWFpod1hTVVZNNkc2RnFkWENv?=
 =?utf-8?B?bVFMRk9oaFdPVWdnMXIvUXExQUZKbjBpVjM2cE9lVmhRL0MvVlA5Q1JVRmlL?=
 =?utf-8?B?bGNaTEM2bkN3UlduQ2pORUdtcUs2VXczSkRXblNtQ2M0dTdxNmFRR0trVnlv?=
 =?utf-8?B?ZlpHV0xYVnRzRkRTUmRCUkZtZmhoQUVmTXR3V0g1N1A2Mko0bEVVRHVmRmFs?=
 =?utf-8?B?MDA4Q3JNYmphTk1MR3I4NDhLN0ZIWGRrSU93ZEk5cXZxS0YwWjZNS1NNSW4x?=
 =?utf-8?B?YWVhc2s2dGI1SzY1bERVTjB5VjlTejNwYWNsTEs3b0VjQTUzcnZxZXNsZkpY?=
 =?utf-8?B?YnBNalM2QndGTThtTVB6SG9SWmNzL1oxdEN5bUNzbFRqOHVNWFFxNWx3Vm9q?=
 =?utf-8?B?R3EyYk9NT0EwNUd4K0dWTUVpdnVNclRWdjgraVN2emVidnBRb0VpaVo4ZnJm?=
 =?utf-8?B?U3ZPMndwZ3dsRElheWp4ajZ1bHpPbXpueUsxNC9rekxDNEVJams3N1dKOE9T?=
 =?utf-8?B?OFlieTJub2YvaThTYUFmTlJCOXZ4anEvMjB3Ym16TjV4UEZPREg2WXZ2em55?=
 =?utf-8?B?N0xDcnVZYSs3bXBtOFdQQVFuMGROanNqREhmYVJTM0tqREhFSHNlTWw3ZVVK?=
 =?utf-8?B?ZUx4NG9UemNuY2ZpaUFpbWpDVXV3amNMU2hudmk3cm9zalVFL1ZxNjVqaHg2?=
 =?utf-8?B?UDlOakhqUnNTRGdsOE5jT1Q0QkFZOHFEVUlHbnlXQWJFSHl6ckUxNDN1ejUz?=
 =?utf-8?B?UjhsMjNGUklpVTNMaDhZV0piZUNzUEtjRmRlR3RLVVVlTFlQTlNOSWh1ZzFS?=
 =?utf-8?B?a0V5TFZ6eUpGOHNYTnlRbnk1SE0vQnhWajFyNW4rbjl5TzJ5YXkvVDUxVE5t?=
 =?utf-8?B?QWVQVE1kTmxSTzQvT3FjemZQdjE1b0J6YjluWGNvOWFYQkdZdkcvU04vS2V4?=
 =?utf-8?B?end2OERReHRmYTBYakU5aU1DYUgrRjl5V2pPcWVCZkJ0aURvazc1YzVRYmxz?=
 =?utf-8?B?RTJDek8wMnh3WUh6MWlaWTdYa0FRYzRPMFBoZG4ydUZ0MTdXWVZFWk42WWli?=
 =?utf-8?B?OGFzY3RmeWlEQ1V2cUVNTW5MaVFRWlA2amdXV0ppbHpEUGJGaHBINlFIb3VV?=
 =?utf-8?B?enlxREMzNVVEWVRsSE80Z1B4RXRaVlNSNktIaVg1QWIxbTBkYWIrSktXQjN6?=
 =?utf-8?B?eEFVNDdIajlNaERTZklZbTJ2RmhNeGUzNHNLbm1vdW9VTS9uNi8zdUUyc1ll?=
 =?utf-8?B?STNBd0Y2V2RnenAxTXZsNDV6V2dpQTNDeEpaKzRSM1JsWkdDOS9tSUIycEgv?=
 =?utf-8?B?N3NnSjhyN0RDOHVTMmlyeUFvbWtBcjdOSXFFZWlQbzBEMlRHaytMNUFSbFA5?=
 =?utf-8?B?eUJ0ZXNvcXNDa1hjbUVOME56UkU4a3hXcjZ0YklDUG9GajBkTEJZeFpaZEVz?=
 =?utf-8?B?dko5eVNzZHg2SVZTVmp1anFITFZRdHNYOUVEbUFCbkxjUy9Lb1JTblhJWXRl?=
 =?utf-8?B?RHIzZXdzS2ZiQlpzc0Rtc0hKbldlOGZ3bzE4UjVnd2E1UVJ3UkZwNFJhczdv?=
 =?utf-8?B?U2pIMS9hYWVwM1c3Q0FBdXVqWHgxVURzRDJTV0VuMWJoeUlMM2lPRHk1c0tT?=
 =?utf-8?B?VThqbmdPNzlabXF5RjNORUdsRzNnNGVJbGR3RGgyWWpiTEp0c0tNcTVuTmZG?=
 =?utf-8?B?SVBZQUFZNldzVGErSnRLL2t2cktWT0drcmZmZFV1TXFTbDlaZXNJY2pjQVkv?=
 =?utf-8?B?MlBwbWdHU2RkMTlBZ0xIL2gwRUZxR0sycHdDcDlHZU9CdWY0YzUvYmNxNGpa?=
 =?utf-8?B?M0kyYXJpc01XbDRhdDJScWViZkZMSlVUdkttei9qVkJFQUdub1Y1ZnhiU2h1?=
 =?utf-8?B?Y2l1dmVFT2lHZTNRTWhhTm0wMUcyTGVPOVdpaTJrbzNPSkNaaHdQZ1Z3Wmor?=
 =?utf-8?B?a1IxUUVUM3M5aEFrSjF5THNpakdkTFh5ekRMbXhPWGpTNlZKcTU3N0pwQUxw?=
 =?utf-8?Q?0KJZbX89tboHnyIJf0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe91814-f4ac-40c9-8504-08df287241b1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 15:05:30.7148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pj3yprDuVsQRRo7fLLfnzZ0mSfTgkbvtEXmwBF6xN+F+D1AeZSh2KvdHWTN2CYSe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4129
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

On 10/8/26 09:05, Srinivasan Shanmugam wrote:
> User queues get their first-level TBA and TMA from MES/KIQ when the
> queue is created. Kernel-managed VMIDs do not use this path, so program
> their trap registers from the gfxhub setup path.
> 
> Get the reserved first-level TBA and TMA virtual addresses and program
> them for each kernel-managed VMID.
> 
> The trap registers use the SRBM selector, so keep the programming under
> srbm_mutex and restore the VMID selector after the registers are
> updated.
> 
> Trap enablement differs across GPU generations. On GFX9, enable traps
> for kernel-managed VMIDs through the debug trap configuration. On
> GFX9.4.3, enable the per-VMID trap control on each XCC. On generations
> where trap enable is encoded in SQ_SHADER_TBA_HI, program TRAP_EN
> together with the TBA address.
> 
> Mask the TBA and TMA address fields before writing the registers. Keep
> TRAP_EN disabled on the affected GFX11 ASICs to preserve the existing
> trap workaround.
> 
> On multi-XCC hardware, program the requested XCCs and restore the VMID
> selector on each XCC afterwards.
> 
> Keep the first-level trap VA layout inside amdgpu_trap. The gfxhub code
> only needs the final TBA and TMA addresses.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>
> Cc: James Zhu <james.zhu@amd.com>
> Cc: Samuel Pitoiset <hakzsam@gmail.com>
> Cc: Natalie Vock <natalie.vock@gmx.de>
> Cc: Timur Kristóf <timur.kristof@gmail.com>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

This conflicts a bit with Sunils works since he is currently replacing the VMID ranges with a VMID mask.

I suggest that Sunils work goes in first and then this here is rebased on top.

But it is mostly just rebasing and using different parameters for the function (mask instead of first/last) and then a different for loop.

Lijo or somebody else with more HW background needs to take a look as well I think.

Acked-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c    |  9 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h    |  5 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 29 ++++++++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     | 16 +++++++
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 38 +++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 38 +++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   | 53 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    | 41 ++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    | 53 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 38 +++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    | 42 ++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 46 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 46 ++++++++++++++++++
>  13 files changed, 446 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> index 89968b5b7ecb..6e7dfceeee10 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> @@ -63,7 +63,14 @@ static inline uint64_t amdgpu_trap_tba_vaddr(struct amdgpu_device *adev)
>  	return addr;
>  }
>  
> -static inline bool amdgpu_trap_is_supported(struct amdgpu_device *adev)
> +void amdgpu_trap_get_l1_addr(struct amdgpu_device *adev,
> +			     u64 *tba_addr, u64 *tma_addr)
> +{
> +	*tba_addr = amdgpu_trap_tba_vaddr(adev);
> +	*tma_addr = *tba_addr + AMDGPU_TRAP_TMA_OFFSET;
> +}
> +
> +bool amdgpu_trap_is_supported(struct amdgpu_device *adev)
>  {
>  	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> index c78c60e3d18d..523f65cb3d3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> @@ -76,6 +76,11 @@ struct amdgpu_trap_usr_addr {
>  int amdgpu_trap_init(struct amdgpu_device *adev);
>  void amdgpu_trap_fini(struct amdgpu_device *adev);
>  
> +bool amdgpu_trap_is_supported(struct amdgpu_device *adev);
> +
> +void amdgpu_trap_get_l1_addr(struct amdgpu_device *adev,
> +			     u64 *tba_addr, u64 *tma_addr);
> +
>  int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		      struct amdgpu_trap_obj **trap_obj);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 1678015ce5a9..07e249500254 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -29,6 +29,7 @@
>  
>  #include "amdgpu.h"
>  #include "amdgpu_gfx.h"
> +#include "amdgpu_trap.h"
>  #include "soc15.h"
>  #include "soc15d.h"
>  #include "amdgpu_atomfirmware.h"
> @@ -2568,21 +2569,26 @@ static void gfx_v9_0_setup_rb(struct amdgpu_device *adev)
>  }
>  
>  static void gfx_v9_0_debug_trap_config_init(struct amdgpu_device *adev,
> -				uint32_t first_vmid,
> -				uint32_t last_vmid)
> +					     u32 first_vmid,
> +					     uint32_t last_vmid)
>  {
>  	uint32_t data;
> -	uint32_t trap_config_vmid_mask = 0;
> +	u32 trap_config_vmid_mask;
>  	int i;
>  
> -	/* Calculate trap config vmid mask */
> +	data = RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG));
> +	trap_config_vmid_mask =
> +		REG_GET_FIELD(data, SPI_GDBG_TRAP_CONFIG, VMID_SEL);
> +
> +	/* Add the requested VMIDs to the existing trap configuration. */
>  	for (i = first_vmid; i < last_vmid; i++)
>  		trap_config_vmid_mask |= (1 << i);
>  
> -	data = REG_SET_FIELD(0, SPI_GDBG_TRAP_CONFIG,
> -			VMID_SEL, trap_config_vmid_mask);
>  	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
> -			TRAP_EN, 1);
> +			     VMID_SEL, trap_config_vmid_mask);
> +	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
> +			     TRAP_EN, 1);
> +
>  	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG), data);
>  	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), 0);
>  
> @@ -4051,6 +4057,15 @@ static int gfx_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> +	if (amdgpu_trap_is_supported(adev)) {
> +		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
> +			gfx_v9_4_2_debug_trap_config_init(adev, 1,
> +							  adev->vm_manager.first_kfd_vmid);
> +		else
> +			gfx_v9_0_debug_trap_config_init(adev, 1,
> +							adev->vm_manager.first_kfd_vmid);
> +	}
> +
>  	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) &&
>  	    !amdgpu_sriov_vf(adev))
>  		gfx_v9_4_2_set_power_brake_sequence(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 01ed1701c781..69a1e64620cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -25,6 +25,7 @@
>  #include "amdgpu.h"
>  #include "amdgpu_ip.h"
>  #include "amdgpu_gfx.h"
> +#include "amdgpu_trap.h"
>  #include "soc15.h"
>  #include "soc15d.h"
>  #include "soc15_common.h"
> @@ -1173,6 +1174,21 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
>  			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
>  
>  	mutex_lock(&adev->srbm_mutex);
> +
> +	if (amdgpu_trap_is_supported(adev)) {
> +		for (i = 1; i < adev->vm_manager.first_kfd_vmid; i++) {
> +			soc15_grbm_select(adev, 0, 0, 0, i,
> +					  GET_INST(GC, xcc_id));
> +
> +			data = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
> +					    regSPI_GDBG_PER_VMID_CNTL);
> +			data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL,
> +					     TRAP_EN, 1);
> +			WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id),
> +					 regSPI_GDBG_PER_VMID_CNTL, data);
> +		}
> +	}
> +
>  	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>  		soc15_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
>  		/* CP and shaders */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> index 8be912d50601..e635d83488af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> @@ -22,6 +22,7 @@
>   */
>  
>  #include "amdgpu.h"
> +#include "amdgpu_trap.h"
>  #include "gfxhub_v11_5_0.h"
>  
>  #include "gc/gc_11_5_0_offset.h"
> @@ -295,6 +296,40 @@ static void gfxhub_v11_5_0_disable_identity_aperture(struct amdgpu_device *adev)
>  
>  }
>  
> +static void
> +gfxhub_v11_5_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
> +{
> +	u64 tba_addr, tma_addr;
> +	unsigned int vmid;
> +
> +	if (!amdgpu_trap_is_supported(adev) ||
> +	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
> +		return;
> +
> +	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
> +
> +	WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +	WARN_ON(!IS_ALIGNED(tma_addr, 256));
> +
> +	mutex_lock(&adev->srbm_mutex);
> +	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
> +		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
> +			     lower_32_bits(tba_addr >> 8));
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
> +			     (upper_32_bits(tba_addr >> 8) &
> +			      SQ_SHADER_TBA_HI__ADDR_HI_MASK) |
> +			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
> +			     lower_32_bits(tma_addr >> 8));
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
> +			     upper_32_bits(tma_addr >> 8) &
> +			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
> +	}
> +	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
>  static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> @@ -342,6 +377,9 @@ static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
>  	}
>  
>  	hub->vm_cntx_cntl = tmp;
> +
> +	if (amdgpu_trap_is_supported(adev))
> +		gfxhub_v11_5_0_program_kernel_trap_tba_tma(adev);
>  }
>  
>  static void gfxhub_v11_5_0_program_invalidation(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> index 4144c1c2ee13..dc7fde6962ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> @@ -22,6 +22,7 @@
>   */
>  
>  #include "amdgpu.h"
> +#include "amdgpu_trap.h"
>  #include "gfxhub_v12_0.h"
>  
>  #include "gc/gc_12_0_0_offset.h"
> @@ -300,6 +301,40 @@ static void gfxhub_v12_0_disable_identity_aperture(struct amdgpu_device *adev)
>  
>  }
>  
> +static void
> +gfxhub_v12_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
> +{
> +	u64 tba_addr, tma_addr;
> +	unsigned int vmid;
> +
> +	if (!amdgpu_trap_is_supported(adev) ||
> +	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
> +		return;
> +
> +	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
> +
> +	WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +	WARN_ON(!IS_ALIGNED(tma_addr, 256));
> +
> +	mutex_lock(&adev->srbm_mutex);
> +	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
> +		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
> +			     lower_32_bits(tba_addr >> 8));
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
> +			     (upper_32_bits(tba_addr >> 8) &
> +			      SQ_SHADER_TBA_HI__ADDR_HI_MASK) |
> +			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
> +			     lower_32_bits(tma_addr >> 8));
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
> +			     upper_32_bits(tma_addr >> 8) &
> +			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
> +	}
> +	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
>  static void gfxhub_v12_0_setup_vmid_config(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> @@ -347,6 +382,9 @@ static void gfxhub_v12_0_setup_vmid_config(struct amdgpu_device *adev)
>  	}
>  
>  	hub->vm_cntx_cntl = tmp;
> +
> +	if (amdgpu_trap_is_supported(adev))
> +		gfxhub_v12_0_program_kernel_trap_tba_tma(adev);
>  }
>  
>  static void gfxhub_v12_0_program_invalidation(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> index b13967a1c8fb..78088e72606c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> @@ -21,6 +21,7 @@
>   *
>   */
>  #include "amdgpu.h"
> +#include "amdgpu_trap.h"
>  #include "amdgpu_xcp.h"
>  #include "gfxhub_v12_1.h"
>  
> @@ -392,6 +393,55 @@ static void gfxhub_v12_1_xcc_disable_identity_aperture(struct amdgpu_device *ade
>  	}
>  }
>  
> +static void
> +gfxhub_v12_1_program_kernel_trap_tba_tma(struct amdgpu_device *adev,
> +					 uint32_t xcc_mask)
> +{
> +	u64 tba_addr, tma_addr;
> +	unsigned int vmid;
> +	int xcc;
> +
> +	if (!amdgpu_trap_is_supported(adev) ||
> +	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
> +		return;
> +
> +	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
> +
> +	WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +	WARN_ON(!IS_ALIGNED(tma_addr, 256));
> +
> +	mutex_lock(&adev->srbm_mutex);
> +	for_each_inst(xcc, xcc_mask) {
> +		for (vmid = 1;
> +		     vmid < adev->vm_manager.first_kfd_vmid;
> +		     vmid++) {
> +			amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0,
> +						    vmid, xcc);
> +			WREG32_SOC15(GC, GET_INST(GC, xcc),
> +				     regSQ_SHADER_TBA_LO,
> +				     lower_32_bits(tba_addr >> 8));
> +			WREG32_SOC15(GC, GET_INST(GC, xcc),
> +				     regSQ_SHADER_TBA_HI,
> +				     (upper_32_bits(tba_addr >> 8) &
> +				      SQ_SHADER_TBA_HI__ADDR_HI_MASK) |
> +				     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
> +			WREG32_SOC15(GC, GET_INST(GC, xcc),
> +				     regSQ_SHADER_TMA_LO,
> +				     lower_32_bits(tma_addr >> 8));
> +			WREG32_SOC15(GC, GET_INST(GC, xcc),
> +				     regSQ_SHADER_TMA_HI,
> +				     upper_32_bits(tma_addr >> 8) &
> +				     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
> +		}
> +	}
> +
> +	/* Reset the VMID selector on every XCC instance. */
> +	for_each_inst(xcc, xcc_mask)
> +		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, xcc);
> +
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
>  static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
>  					       uint32_t xcc_mask)
>  {
> @@ -457,6 +507,9 @@ static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
>  
>  		hub->vm_cntx_cntl = tmp;
>  	}
> +
> +	if (amdgpu_trap_is_supported(adev))
> +		gfxhub_v12_1_program_kernel_trap_tba_tma(adev, xcc_mask);
>  }
>  
>  static void gfxhub_v12_1_xcc_program_invalidation(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> index c35856180c3c..dbd993ae1d0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> @@ -21,6 +21,7 @@
>   *
>   */
>  #include "amdgpu.h"
> +#include "amdgpu_trap.h"
>  #include "gfxhub_v1_0.h"
>  #include "gfxhub_v1_1.h"
>  
> @@ -252,6 +253,43 @@ static void gfxhub_v1_0_disable_identity_aperture(struct amdgpu_device *adev)
>  
>  }
>  
> +static void
> +gfxhub_v1_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
> +{
> +	u64 tba_addr, tma_addr;
> +	unsigned int vmid;
> +
> +	if (!amdgpu_trap_is_supported(adev) ||
> +	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
> +		return;
> +
> +	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
> +
> +	WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +	WARN_ON(!IS_ALIGNED(tma_addr, 256));
> +
> +	mutex_lock(&adev->srbm_mutex);
> +
> +	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
> +		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
> +
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_LO,
> +			     lower_32_bits(tba_addr >> 8));
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_HI,
> +			     upper_32_bits(tba_addr >> 8) &
> +			     SQ_SHADER_TBA_HI__ADDR_HI_MASK);
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_LO,
> +			     lower_32_bits(tma_addr >> 8));
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_HI,
> +			     upper_32_bits(tma_addr >> 8) &
> +			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
> +	}
> +
> +	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
> +
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
>  static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> @@ -310,6 +348,9 @@ static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
>  				    i * hub->ctx_addr_distance,
>  				    upper_32_bits(adev->vm_manager.max_pfn - 1));
>  	}
> +
> +	if (amdgpu_trap_is_supported(adev))
> +		gfxhub_v1_0_program_kernel_trap_tba_tma(adev);
>  }
>  
>  static void gfxhub_v1_0_program_invalidation(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> index e89813590539..76c2b6b74903 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> @@ -22,6 +22,7 @@
>   */
>  #include "amdgpu.h"
>  #include "amdgpu_ip.h"
> +#include "amdgpu_trap.h"
>  #include "amdgpu_xcp.h"
>  #include "gfxhub_v1_2.h"
>  #include "gfxhub_v1_1.h"
> @@ -328,6 +329,55 @@ gfxhub_v1_2_per_process_xnack_support(struct amdgpu_device *adev)
>  	return !!adev->aid_mask;
>  }
>  
> +static void
> +gfxhub_v1_2_program_kernel_trap_tba_tma(struct amdgpu_device *adev,
> +					uint32_t xcc_mask)
> +{
> +	u64 tba_addr, tma_addr;
> +	unsigned int vmid;
> +	int xcc;
> +
> +	if (!amdgpu_trap_is_supported(adev) ||
> +	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
> +		return;
> +
> +	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
> +
> +	WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +	WARN_ON(!IS_ALIGNED(tma_addr, 256));
> +
> +	mutex_lock(&adev->srbm_mutex);
> +
> +	for_each_inst(xcc, xcc_mask) {
> +		for (vmid = 1;
> +		     vmid < adev->vm_manager.first_kfd_vmid;
> +		     vmid++) {
> +			amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0,
> +						    vmid, xcc);
> +
> +			WREG32_SOC15(GC, GET_INST(GC, xcc),
> +				     regSQ_SHADER_TBA_LO,
> +				     lower_32_bits(tba_addr >> 8));
> +			WREG32_SOC15(GC, GET_INST(GC, xcc),
> +				     regSQ_SHADER_TBA_HI,
> +				     upper_32_bits(tba_addr >> 8) &
> +				     SQ_SHADER_TBA_HI__ADDR_HI_MASK);
> +			WREG32_SOC15(GC, GET_INST(GC, xcc),
> +				     regSQ_SHADER_TMA_LO,
> +				     lower_32_bits(tma_addr >> 8));
> +			WREG32_SOC15(GC, GET_INST(GC, xcc),
> +				     regSQ_SHADER_TMA_HI,
> +				     upper_32_bits(tma_addr >> 8) &
> +				     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
> +		}
> +	}
> +
> +	for_each_inst(xcc, xcc_mask)
> +		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, xcc);
> +
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
>  static void gfxhub_v1_2_xcc_setup_vmid_config(struct amdgpu_device *adev,
>  					      uint32_t xcc_mask)
>  {
> @@ -398,6 +448,9 @@ static void gfxhub_v1_2_xcc_setup_vmid_config(struct amdgpu_device *adev,
>  					    upper_32_bits(adev->vm_manager.max_pfn - 1));
>  		}
>  	}
> +
> +	if (amdgpu_trap_is_supported(adev))
> +		gfxhub_v1_2_program_kernel_trap_tba_tma(adev, xcc_mask);
>  }
>  
>  static void gfxhub_v1_2_xcc_program_invalidation(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> index 04778f9f95bd..da4e1fa34d8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> @@ -22,6 +22,7 @@
>   */
>  
>  #include "amdgpu.h"
> +#include "amdgpu_trap.h"
>  #include "gfxhub_v2_0.h"
>  
>  #include "gc/gc_10_1_0_offset.h"
> @@ -285,6 +286,40 @@ static void gfxhub_v2_0_disable_identity_aperture(struct amdgpu_device *adev)
>  
>  }
>  
> +static void
> +gfxhub_v2_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
> +{
> +	u64 tba_addr, tma_addr;
> +	unsigned int vmid;
> +
> +	if (!amdgpu_trap_is_supported(adev) ||
> +	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
> +		return;
> +
> +	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
> +
> +	WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +	WARN_ON(!IS_ALIGNED(tma_addr, 256));
> +
> +	mutex_lock(&adev->srbm_mutex);
> +	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
> +		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_LO,
> +			     lower_32_bits(tba_addr >> 8));
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_HI,
> +			     (upper_32_bits(tba_addr >> 8) &
> +			      SQ_SHADER_TBA_HI__ADDR_HI_MASK) |
> +			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_LO,
> +			     lower_32_bits(tma_addr >> 8));
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_HI,
> +			     upper_32_bits(tma_addr >> 8) &
> +			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
> +	}
> +	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
>  static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> @@ -332,6 +367,9 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
>  	}
>  
>  	hub->vm_cntx_cntl = tmp;
> +
> +	if (amdgpu_trap_is_supported(adev))
> +		gfxhub_v2_0_program_kernel_trap_tba_tma(adev);
>  }
>  
>  static void gfxhub_v2_0_program_invalidation(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> index 6c77c17878f8..c0ff251bcbff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> @@ -22,6 +22,7 @@
>   */
>  
>  #include "amdgpu.h"
> +#include "amdgpu_trap.h"
>  #include "gfxhub_v2_1.h"
>  
>  #include "gc/gc_10_3_0_offset.h"
> @@ -297,6 +298,44 @@ static void gfxhub_v2_1_disable_identity_aperture(struct amdgpu_device *adev)
>  
>  }
>  
> +static void
> +gfxhub_v2_1_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
> +{
> +	u64 tba_addr, tma_addr;
> +	unsigned int vmid;
> +
> +	if (!amdgpu_trap_is_supported(adev) ||
> +	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
> +		return;
> +
> +	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
> +
> +	WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +	WARN_ON(!IS_ALIGNED(tma_addr, 256));
> +
> +	mutex_lock(&adev->srbm_mutex);
> +
> +	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
> +		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
> +
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_LO,
> +			     lower_32_bits(tba_addr >> 8));
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_HI,
> +			     (upper_32_bits(tba_addr >> 8) &
> +			      SQ_SHADER_TBA_HI__ADDR_HI_MASK) |
> +			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_LO,
> +			     lower_32_bits(tma_addr >> 8));
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_HI,
> +			     upper_32_bits(tma_addr >> 8) &
> +			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
> +	}
> +
> +	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
> +
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
>  static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> @@ -344,6 +383,9 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
>  	}
>  
>  	hub->vm_cntx_cntl = tmp;
> +
> +	if (amdgpu_trap_is_supported(adev))
> +		gfxhub_v2_1_program_kernel_trap_tba_tma(adev);
>  }
>  
>  static void gfxhub_v2_1_program_invalidation(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> index e2b9fd0c8af0..1d9d4d41c42c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> @@ -22,6 +22,7 @@
>   */
>  
>  #include "amdgpu.h"
> +#include "amdgpu_trap.h"
>  #include "gfxhub_v3_0.h"
>  
>  #include "gc/gc_11_0_0_offset.h"
> @@ -292,6 +293,48 @@ static void gfxhub_v3_0_disable_identity_aperture(struct amdgpu_device *adev)
>  
>  }
>  
> +static void
> +gfxhub_v3_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
> +{
> +	u64 tba_addr, tma_addr;
> +	u32 tba_hi;
> +	unsigned int vmid;
> +
> +	if (!amdgpu_trap_is_supported(adev) ||
> +	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
> +		return;
> +
> +	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
> +
> +	WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +	WARN_ON(!IS_ALIGNED(tma_addr, 256));
> +
> +	tba_hi = upper_32_bits(tba_addr >> 8) &
> +		 SQ_SHADER_TBA_HI__ADDR_HI_MASK;
> +
> +	if (!amdgpu_trap_has_dbg_wa(adev))
> +		tba_hi |= 1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT;
> +
> +	mutex_lock(&adev->srbm_mutex);
> +
> +	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
> +		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
> +
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
> +			     lower_32_bits(tba_addr >> 8));
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI, tba_hi);
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
> +			     lower_32_bits(tma_addr >> 8));
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
> +			     upper_32_bits(tma_addr >> 8) &
> +			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
> +	}
> +
> +	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
> +
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
>  static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> @@ -339,6 +382,9 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
>  	}
>  
>  	hub->vm_cntx_cntl = tmp;
> +
> +	if (amdgpu_trap_is_supported(adev))
> +		gfxhub_v3_0_program_kernel_trap_tba_tma(adev);
>  }
>  
>  static void gfxhub_v3_0_program_invalidation(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> index fa8b966b7ea1..7f2a0b21cd4f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> @@ -23,6 +23,7 @@
>  
>  #include "amdgpu.h"
>  #include "gfxhub_v3_0_3.h"
> +#include "amdgpu_trap.h"
>  
>  #include "gc/gc_11_0_3_offset.h"
>  #include "gc/gc_11_0_3_sh_mask.h"
> @@ -297,6 +298,48 @@ static void gfxhub_v3_0_3_disable_identity_aperture(struct amdgpu_device *adev)
>  
>  }
>  
> +static void
> +gfxhub_v3_0_3_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
> +{
> +	u64 tba_addr, tma_addr;
> +	u32 tba_hi;
> +	unsigned int vmid;
> +
> +	if (!amdgpu_trap_is_supported(adev) ||
> +	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
> +		return;
> +
> +	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
> +
> +	WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +	WARN_ON(!IS_ALIGNED(tma_addr, 256));
> +
> +	tba_hi = upper_32_bits(tba_addr >> 8) &
> +		 SQ_SHADER_TBA_HI__ADDR_HI_MASK;
> +
> +	if (!amdgpu_trap_has_dbg_wa(adev))
> +		tba_hi |= 1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT;
> +
> +	mutex_lock(&adev->srbm_mutex);
> +
> +	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
> +		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
> +
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
> +			     lower_32_bits(tba_addr >> 8));
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI, tba_hi);
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
> +			     lower_32_bits(tma_addr >> 8));
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
> +			     upper_32_bits(tma_addr >> 8) &
> +			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
> +	}
> +
> +	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
> +
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
>  static void gfxhub_v3_0_3_setup_vmid_config(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> @@ -344,6 +387,9 @@ static void gfxhub_v3_0_3_setup_vmid_config(struct amdgpu_device *adev)
>  	}
>  
>  	hub->vm_cntx_cntl = tmp;
> +
> +	if (amdgpu_trap_is_supported(adev))
> +		gfxhub_v3_0_3_program_kernel_trap_tba_tma(adev);
>  }
>  
>  static void gfxhub_v3_0_3_program_invalidation(struct amdgpu_device *adev)

