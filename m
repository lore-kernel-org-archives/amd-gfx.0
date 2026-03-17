Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF77F3380C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 08:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EE6410E59E;
	Tue, 17 Mar 2026 08:31:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LKWvsohz";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011002.outbound.protection.outlook.com
 [40.93.194.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C54110E59E
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 08:31:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjYdv7zgPCfeF/OX9qsNXnBloe05SSGxiu5qfatm0XGM16//tu+RFUzx6zbJ4HDfpep6DqM745TPdRvfm/ZTSK3SeVt6ez2jNGS3PZaoB3d0BVPLUrlJwDqZSyxGkKgjBI9K6GpB1Pgf9wHMzV5i9296qgKSPR6CEEPMM/+IS/lAcJtHlNhDckiMALK+jXiuKXLZQPVDp8kJ16/YC5cCmPt+6dpRoEJ2NPgIuBi/rePbUSgZg3ynCrCZngbDJZ/kHYh9ZkrCk5Fg/eCA9iEtyoKSVT737BVs47GLAGraxesMBfj/zg15/89ioOreXMH1VMaa6cUoFujewniNAQr0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5xMntplnELVo3THBkPUWN7l/vXMv6k25OMgSke7/AE=;
 b=oUq0FOcni9rPfvRMmQYx/LP9ZyBNhnuCWlPzdCDoM0Fbw7VPp2mkDS6Ab1qycRDgmXvTXs49lc+vbJ2EtbpXHL2JRWc7UKORLkXgua/FNmXgQp+uLQ73bLaLLzzOUGS0zm6qszEQg1mXxOSe5sSq2KVvNCJzBpodyviU0oUWggx/VzD4rGaEFSBrF/v8fT0M+UT5HYX7BM7YEp/G7E2ZKIg0XZIKRDktMMakCmGGWrnEolTWWpLp1BziitIh1jbgEupwjVVHKkx4kYLaRVf6PKg74e52wKla6t2o8Y+JO+Ytg3VDaVPmXPVHMOsCXbYbA+Hx/VFFWmYJAFUELLB4vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5xMntplnELVo3THBkPUWN7l/vXMv6k25OMgSke7/AE=;
 b=LKWvsohzuP5e43JZbfvOctbiRXC/3sZyQ4Sen9JFUPH0A1s3P64I09lvSxWnOVqEVuQ4KiKfVUBIWHvP7zR1v1HHiV1iGISsA8vU6sWydJtmW8TZt9/Fa1BldSAYEqepMldy2+6YJqT3WVjQjUn0UQwQ29isMQPeBgr19cdk2Mk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 08:31:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 08:31:18 +0000
Message-ID: <d0b7e582-9914-4579-9128-dacb5ed52c7d@amd.com>
Date: Tue, 17 Mar 2026 09:31:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drm/amdgpu: harden SIGNAL/WAIT ioctl argument
 validation
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Vitaly Prosyak <vitaly.prosyak@amd.com>
References: <20260317074804.2363458-1-Jesse.Zhang@amd.com>
 <20260317074804.2363458-3-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260317074804.2363458-3-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0226.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8784:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a6a2ad2-0f33-4e5d-18f0-08de83ff8fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 8zgy0vXUwjwpPvuSZc/8F0zU9YOUvToJ4ws9E+JzWIubhNWNBjRyamzCOroOFRR68egnmoxaYOq/LvXkZt8Q9Tt86GhebIO/3RabNpdix4SppIrg3gfd+BFkH3r/mYU6a+Ohc6J7onrmIiQjiVlPMlzpUdgdbnPAMB4e0itW1TSl51BU81zWbfFuQCJbMvdapeFakEDttHoENJXIds3xl1RDDJE7wjFkPisTykcxEbPQfDGppEOT8wKfXXqyVlwsmYLqgWiu+wVIdt09P0bwfYtozKZ6NHj52H/IS3n2txT/g9LiQgV474h2weqMUHrhNFMmXPRQIDkNu5DfIYe/7WqVDum0o1rFpNmyyrIuS1b5t/jb4KQVW4plGfhKc39VqP2OTYVrJ88flIcopkQT6gKitIRG8rAJqxofw+FfRuIftYgXW/CMUt3OXZj59zhvM8KwZ672kEGp8YpyhSd2PUnibvGsOAK3NvcMuAqMoo01eXeiYDZQe3WooyFoJcyjVvpPYNakcnpm2Box562JBIOE4ZyXX1nq+rzBuxzvdBIIVdYJK3xSbTm/Cqt5rHhI8lP5qUw50yrZf8OMOkfT3+5iOPRYegsxM0I1DnrL4h6f6bRbEl7IrX2H2Q+ka+ssvZDT5HmNRWyt96AluPE3aWFTllrV9ByRxjbbqaFkU71oMBrFS3gi2KLLkncnOT9x2Y2MhpouYfZWqcZdNLss0OAm68X9lUPJ6+qTDePFqxU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWxHTGtyei9yaDZmenBoblBTWmxHVHZCbWxHOC9sd2NEOHh6cHhWQ1Z3aFBj?=
 =?utf-8?B?OUpTVldaRGRZWDBzbVoxTWRwVmJDUUQvNERWSG96Sy9BRGN0TlNPSzQzNTRN?=
 =?utf-8?B?eVl4NlRuT3k1aTFDOTNxdG1MOTRKTkJ0OFM1RVhXSnhzamE5M0pGc0lFRzRq?=
 =?utf-8?B?elBuYXNib003alpyYVhocUxRRU9HanV5dDMzNmQyVW40MHFWQ1F6NHhOTDBn?=
 =?utf-8?B?RGQ0NGVBWDhKQUNTTHZCdjdSMkZjQ3FKQlB5SXVlaHJUcC9HZTEyUCs5RW5Y?=
 =?utf-8?B?ODNWb1VGcmh6Y1EvaTRmdDNSQ3lXdWlwcHNwVHdxc3hIK0o4QjNLT0xLQ2Rw?=
 =?utf-8?B?eHRWT29kMjJuUEJMYVJvYkZNOG5ycDRrSFhRNW1laGczS2xlcERnNThqYmRs?=
 =?utf-8?B?MVliRjh0d1JoZ3VqaW0vSDZwblJmai9rOFY5SVhkaGY1Z25GL2x4dFZka1BW?=
 =?utf-8?B?Y0hibnBxUzlDUTczQ09EVXBuaHkxeXloSjAvQVBwN0hPZDRuUkVxREg5RXUz?=
 =?utf-8?B?V1NXbkI2THVlUzNJbVJoYVoxaEZ5bFEveVBCYnhBL0xGUXdvRXdHTFFIRzY0?=
 =?utf-8?B?clNhQWZiQXJGMXhDaS9CR0I4Q0JFT3ZkRGU3emZVbzlHTVYvbDlOb1UvUGQ1?=
 =?utf-8?B?a0NobVZBWEs5YmZDMTAvSWI5bXFjVTlTczB2L2R1MWh1QTBSK1BUVVFPeDZU?=
 =?utf-8?B?VXJsK2tnanptdmFFL1h3cnZ0dFh3a3M4eVNvQmlwRjU5aVU3cFp4dE9objNH?=
 =?utf-8?B?bmQzYmF6cW8zRW1DUjFzS1NSZXBYM0s0enE5WE92OEgxcXFmTWFwbk8vYyt4?=
 =?utf-8?B?Z2Rmb1dtRFgvV1FhYjRIWkp6Tm93cjBrV2FCMXF4QmNOWDR2c2ljUmVCK2xD?=
 =?utf-8?B?eGZQUzZ4Q0xaM1hGSGY3QUEydmhIVHdsZDZNbGQ5d2MrMUluTTNMVXVzVVRF?=
 =?utf-8?B?VXlXc1pLSG1RbUtzT0ZVRDVKRXAvcC9BcCs3QVBwSGpldzg1RTBRNDVFazNv?=
 =?utf-8?B?eVRTbldzcktjS1Y3dVZ4L1RKYVFYWXU0R3Z4SUdCSCtDaytVWUFMQlJaQzRu?=
 =?utf-8?B?dGIvRWpwaU81RG1qYVhCejhYVUJlUUNJcXdzV0VhZjlDUGc1czRHYXowYmZR?=
 =?utf-8?B?dzNhZGJMekhIMnYxMlhOeE9Rbi9WRDQ5eldpaElCcFpTeDVNMmFRZVRYZXdi?=
 =?utf-8?B?dFpTMGJheHA3V2wvZmthcDhpdzdNM2dMU2hoOW9EVXVwNlZhMkhLOWFzRVpy?=
 =?utf-8?B?eVUrYXArTlV2ekJGeE9FTGpMbXFwN245Rlc5cmNxbE9IQzJtb0NvTFV6MWVW?=
 =?utf-8?B?ZHhNL3ZHZXJHRk5jcER3ZTNnZ1IxQXJRNC9RNXprdC8vbjBKZW9RQVBpY0tC?=
 =?utf-8?B?SUtVT1YyQWJGWmlnM0V0Mk9iSUw1WmRaTVBXMWtQaFV1dDVIOEFKTW5UelRN?=
 =?utf-8?B?RDg5VjhOQ2lvOGdYSDFCTWh1RTF5N2VCbEx5UHFKOFlBVHNPZkV1UHBUdUdq?=
 =?utf-8?B?R3BiZVI0UTcrZkhkVTZhTlN4dEFyQWl3T21HUmpNS2J1MkpNM2lka05hL3Yw?=
 =?utf-8?B?NTR5YUFZWHpGRU5ISDlwZlNDS3FuU3h5dFJCcHgxc2UzMGhzckhjRTl6THJa?=
 =?utf-8?B?TEwrKzM3d2tZN21HRk91S1EzcFB3cXlTV045MjBaWFE0MjQ1VXdBY3BrQ1RE?=
 =?utf-8?B?TFMxQm1Ia3NQU2psYTNlZXFsK1lJN3F3aW5kdExBbjF3Y0Jvc0hFTFlsT1Zh?=
 =?utf-8?B?UEQ4NnhOZEN2aEt2bm9MdExBbWNzeDNFckQyYkk2SFdXRHNuQ0ZnaDhCMGRP?=
 =?utf-8?B?WE9oU3BGUUlKSVJDYVNSQWkyNkgyelJEd0pLRWZWYTViNkd1MzFrbXhRQ05S?=
 =?utf-8?B?YnVRbklhWTVpem03VHk4NE80b3VHQnpOMHhGSldjeEpCbzNnZWZqbkMvcHIz?=
 =?utf-8?B?djVKYlc3UDR4QnVFM0Q3Z0R0RWFUQTM5V3I5akVnL3Q0d0RiY3d4dHJUeW1s?=
 =?utf-8?B?T2srMzBmN3FyWUhTWFVEMDE2YVZaM2lJdmxBY3ZwaERtZXdqcTIzM1RVejBJ?=
 =?utf-8?B?Wll1a3lKbHNZaWx3RnpmYitZa2NEM0twRmVXSlI4eGRPbHZUTVVhSlVXWi9z?=
 =?utf-8?B?WU9DZUZsVTM4OUo3OG1tbUtIanRBeUdaSzJEcFVyaTBiYmF1U1IzRFJkb1Ns?=
 =?utf-8?B?aFVmelNNZlJ6QTNwelFDT3AxRUJuTGNEMlV6a3owNGhJbEJGdld0MnV0Ynhq?=
 =?utf-8?B?SUVDZWFtN1VpSGkwVXFISm5RUkdLeWtQZmpuRFBqSzB3Q2R6Z3RjbWZMM25m?=
 =?utf-8?Q?eWmzbUw0WPRHCGBnMo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6a2ad2-0f33-4e5d-18f0-08de83ff8fd7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 08:31:18.7909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/y60hkBK0vtSVvAY1XlAeKp37lT/7jp1Sbq9+qstyKj4FnNpd58S/ktfIdgAS+F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8784
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

On 3/17/26 08:47, Jesse.Zhang wrote:
> Tighten the early parameter checks in the USERQ SIGNAL and WAIT ioctls:
> 
> 1. Validate num_syncobj_handles against AMDGPU_USERQ_MAX_HANDLES in
>    addition to the BO handle counts that are already checked. The UAPI
>    field is __u64 but the driver stores it in a u32, so the comparison
>    must happen before the narrowing assignment to prevent unintended
>    truncation (e.g. 0x1_0000_0000 would silently become 0).
> 
> 2. Reject inconsistent pointer/count pairs where a non-NULL userspace
>    pointer is provided with a zero element count. This is clearly
>    malformed input and returning -EINVAL early gives userspace a
>    deterministic error rather than silently proceeding with empty data.
> 
> No functional change for well-formed userspace callers.
> 
> v2:
> - Reworked commit message to focus on parameter validation correctness (Vitaly)
> - Updated code comments for clarity: describe the type width mismatch
>   and why the early check is needed (Vitaly)
> - No functional changes to the code itself (Vitaly)
> 
> v3: drop the num_syncobj_handles > AMDGPU_USERQ_MAX_HANDLES checks (Christian)
> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

We should also take another look at the UAPI and make sure that all those num_* fields are either u16 or u32 and not u64.

Regards,
Christian.

> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index fad595401a77..5ff8fc815e45 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -484,6 +484,16 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  	    args->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
>  		return -EINVAL;
>  
> +	/* Reject non-NULL pointers paired with a zero count. */
> +	if (!args->num_syncobj_handles && args->syncobj_handles)
> +		return -EINVAL;
> +
> +	if (!args->num_bo_read_handles && args->bo_read_handles)
> +		return -EINVAL;
> +
> +	if (!args->num_bo_write_handles && args->bo_write_handles)
> +		return -EINVAL;
> +
>  	num_syncobj_handles = args->num_syncobj_handles;
>  	syncobj_handles = memdup_array_user(u64_to_user_ptr(args->syncobj_handles),
>  					    num_syncobj_handles, sizeof(u32));
> @@ -642,6 +652,25 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  	    wait_info->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
>  		return -EINVAL;
>  
> +	/* Reject non-NULL pointers paired with a zero count: the pointer
> +	 * is meaningless and indicates inconsistent input from userspace.
> +	 */
> +	if (!wait_info->num_syncobj_handles && wait_info->syncobj_handles)
> +		return -EINVAL;
> +
> +	if (!wait_info->num_syncobj_timeline_handles &&
> +	    (wait_info->syncobj_timeline_handles || wait_info->syncobj_timeline_points))
> +		return -EINVAL;
> +
> +	if (!wait_info->num_bo_read_handles && wait_info->bo_read_handles)
> +		return -EINVAL;
> +
> +	if (!wait_info->num_bo_write_handles && wait_info->bo_write_handles)
> +		return -EINVAL;
> +
> +	if (!wait_info->num_fences && wait_info->out_fences)
> +		return -EINVAL;
> +
>  	num_syncobj = wait_info->num_syncobj_handles;
>  	syncobj_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_handles),
>  					    num_syncobj, sizeof(u32));

