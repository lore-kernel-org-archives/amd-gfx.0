Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A227CC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Nov 2022 22:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D45BD10E278;
	Tue, 29 Nov 2022 22:37:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89DEA10E278
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Nov 2022 22:37:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiPtbBSbpip6HmVEH8tqMRSG+kj9qd3S+rKDfTdBn4YuzLu7lKamnt0HbQSY5WKlLA9kXFIE28cQgLtGsVsVv50ZBaS0qYGD72W13U/6JSAdCy9iPJtn0uJNevBsjKH44IhdFP3pFv0sA+CD2c7Ev0H6sCAdhaHl0TY9Oby6bflf2LP90iiSzVKBCKCewgYFbDKAaj/QBxw2nRuptGtqLYQ0niyXtcNS5RV7aGi/6k1S2VTyrOKCl3mQKDamnTZHMa1vaAktegJU3vHTDTbLKN4GE03a9gEhmj7v76PFtHS+JW4yIXNEFkZSewyhkQX/56py+dVWfh39VLzitGPIBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9vTPCNUBkUBT9IZsjBFic5BNEbOjYV5kv6QDERRN7k=;
 b=D5mZaOESQZ5bgikQrNpmI8nhJVAgcqDbWyVAYYmXOsO/LGJMUzDlligJvbFDdJRRRaWfSoEl81l1WIYieya5MoOio7huwvjHK08n+ZBv86eJJy+R1o5APQIgLLYTOeGjR5JPofw6ggO2BhV6mCbJd348SI5X4yRKiRh6nfN/K/BwiVYsq+4Bw28TN3ZD+sRHkLnsQu/jgUaHHuH+GMmS8AU7JiQ+dgQP2g3zlYZfUq+3QKSEpd7gWdvcbNqQxoolL9rads/vYD0Mz7536q5I7Dh4SAAREjxnOOQYXceIZB7yW1f2gMl2Ubsszx8koppdtpcMBbaw5Nvo5FYNJMPRHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9vTPCNUBkUBT9IZsjBFic5BNEbOjYV5kv6QDERRN7k=;
 b=XRx887E5F/SiwZfcfQmoSGBPtr0quvt3gBW6uP+wg5nVsE1t68CBHfXfIMAd7Wx7SXc+2RlYlnJ+634UabNYJEHXjrEGxSsIGVDpnJTYbZrNphOn/zUuNy5Ygc7UbD/35QnlcUrpz7xmaOCV6JGUEJOz/v0TLSn3R7m62kNlxYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB7035.namprd12.prod.outlook.com (2603:10b6:a03:47c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 22:37:40 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 22:37:39 +0000
Message-ID: <c5fdb6de-2a02-dda4-3646-9c07810a0ebc@amd.com>
Date: Tue, 29 Nov 2022 17:37:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 20/29] drm/amdkfd: add debug wave launch override operation
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221031162359.445805-1-jonathan.kim@amd.com>
 <20221031162359.445805-20-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221031162359.445805-20-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0047.namprd02.prod.outlook.com
 (2603:10b6:207:3d::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a7a383-fdb5-408b-2ead-08dad25a5242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5XW6HAj39/5a3FhuY1197JcTVXeWEn5qS/kgs/6mdvhcf+7WaV7kDXFoeBYiTTBYO4M3Ym4Jd8U99QG6iJG/oZI5i7mH0rBn97d/6VKbJlHkJEDKYW5M8ldiw1uVEEzfj2anDO9XMwsVw2fZuHJrl/zNM/Y6ekftn9HNEmq3YjetEEiH69lqrm8EnKL49S+6V2t+FQWqVP/KjDLHbmxK+Rp4j/MPdMwslgHT5a86zgd64JHtXVgbU0Q2P4NWoWbMDt933lw6diNN0pJ7CdL0Y7S9ab+xkXV2xgwQsi82jxVG5JNqk+v/4gAgZbQkR0hG3V043XQEA7txvb6qpnENxSUWn169LSJhAS6Nud6lHfuqmENOK3kqvAep5upLZJyPAKiDj23rWr+FTMD+gzNsy7pqE7HEKD8fjqvB+1y3wY90cVYey7p2IH+axzgvXBDJpabXYLVS/rlhCwXWmUgqOfpaaza2Od6ESaVsGF6qg5RFUAGQF33AgYRVzPYa0eP07V+1CICRJpSd1RkC/6bGB3+7cW8ilqPgF73C/VuiQLt0EyUTJMXXnstsjN7OJum1EOWssHl5YeuCGL6eJXOhA2WLCM+51nsBNzkti4ELB4WWtO5QkA3d8ShQpTHykpMlZak29ajeYZXdEN1gdzTkP9ItIQp/K7JCZ6a6mNQzgY/BQj6GHjykcJwMlRzZg2qhj4iZpikKJd89cHoaRlVSZZlt9xY8is5ynm4haDVCuoA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199015)(6486002)(53546011)(36756003)(36916002)(26005)(6506007)(6512007)(38100700002)(66946007)(8676002)(41300700001)(478600001)(66476007)(66556008)(4001150100001)(86362001)(31696002)(316002)(44832011)(30864003)(5660300002)(8936002)(186003)(2616005)(31686004)(83380400001)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHk2SDZMb1dLeFNydFB4Zks5NUdKTE5EN3I2dG5rRGx0aXhHTjZJWXhQaGJI?=
 =?utf-8?B?bm56WC9xS0lGaG5aU0tLTTE3UHFDN1M3ejJLSzk2KytjQ1NQVXRwK0ZXWDZD?=
 =?utf-8?B?V3lDTzUvQTJPVjRmWGZ1cmdtR0xGZ3JBa0FEK1FyL0d0dmNYdVI2UjQxSU55?=
 =?utf-8?B?ZXdRcWdjZmlGcjhJczEraDdQbHM3MUJlODZQd2RnTmZLaGd3L0FsZVlBaFJ4?=
 =?utf-8?B?bzRLb1NMZW9RaXR4TW5IbEpETDNtQnVKam5NUTV1Nzl3WHhTVElhUTdnWGlG?=
 =?utf-8?B?ZUtCNDV0cDg4Y1NnYmlISndGMXJpMDBjK3c5ZitsaTFnOThxbC8vcEpOTUZ3?=
 =?utf-8?B?MmFYUkNZam9SVjIzTFBrTTFhRWJEMm16VTV2TzZnSzBhTnd1N0NPVTI2emgw?=
 =?utf-8?B?VXpXSys2Z1VVWWxENm5RU0tiK25XMXZaSk41cFVaOW5JeFpNcmpidzlhZFlW?=
 =?utf-8?B?WWlMQ2EzMEJzYkd0UWJOcC9RcStkRWFtbzlJdVF5TWhTYjVmR1N1SXJvUWtp?=
 =?utf-8?B?RitDSjJlL09PdDRud3cxWmN1dWw1WVZRL1dRRS9WWXNhdXMvRk9Hc0hPY1cx?=
 =?utf-8?B?V1FHSlBSQzR1bTdNZHc2a25RdWg1cXFSdUhPdkxFQjQxbUZKWjlZdjRFSC9a?=
 =?utf-8?B?NFZmVXcvVUNFa3c2d0k5L0ZJbDhBZzEwQ1J4ZUJXSk5GVlBOVmlNVUpLMk5D?=
 =?utf-8?B?K1YwTUhERmIyYkRPT0NESHpCdDdKaWZhY0JsYTRKSXFScUV2SGErdHBiVC92?=
 =?utf-8?B?dFFMOG9XZ21TK3p1VTR2a0lSZ3ZJQzYxY0ZmZUplcjd6SGs2UWovbVQ1MFFk?=
 =?utf-8?B?aFFiK2FCM21Xb2toZjF6SytDSHJlN2d1QWs5bTlNeHdtQm9kMGY5amJBTmlh?=
 =?utf-8?B?ek5MRVlNc1IvRzd3SkZobC9RTExBVU5qalhRSTFmY0RIbTJ2aHNxMDVpcGpy?=
 =?utf-8?B?RGJRWG1LZzl4UWVOV1VpZUJ4aHFBZDR6aXloaTFJK0tPSzBwNTBaTzZqcEMz?=
 =?utf-8?B?bHVoOCtUamtSdHMvZ1ZuNk8rYitvcG9hb1gwRFZqVzNKWEZZTUMzOEZhWlM1?=
 =?utf-8?B?czh1eG1FbncvOGt0L1dXZUlRMWF1Zkwyd3JDMS9WNnVITEpvQ3NsdzM3TEJ3?=
 =?utf-8?B?S0w2aDMva2VsdERJSngrTTRmOTNwdUNEbm9NS2dhZXJsb1BOc2Z2SmhWQVhu?=
 =?utf-8?B?UFZqQ2c1dy9NaStTWnBYYnRyWGd3UXE2R25TT0Y3WCtwUHBOU01JaXFCdnF1?=
 =?utf-8?B?TVpiZEJSUzRsalNZZlc0YnM4S0lBenNJa2ZnZmoyc0RhY3ZuKzd0enRFVWJH?=
 =?utf-8?B?MG9JWVpmbVNIME1vZ0tScjFweWhPRGZ2ZE5lNWNnNEU1MmFSeHhoYytobUxn?=
 =?utf-8?B?VkVmNERHckZRSmkrNTFDVDBCRTFXd24wVHl6NlQ0Y1puVEg5WEh6WWZWMkw1?=
 =?utf-8?B?ajZlVVRTWWdXajFOL0RZeGhVL2YxaUx5RTByRVBrWTRpWnd3emxxbzQ2Z0Rk?=
 =?utf-8?B?OERFQ2V6Z2h1TEZWaU83RkNSS3EzZHBJWitFb01ua0kvQ3Z1OFc1R0xTQk1r?=
 =?utf-8?B?azFGZFZSYkdYOUFieFY1VXlpMk96OEhXendzdE1TTzhjazRuVno2VDhVK2VK?=
 =?utf-8?B?aS96blpRQ2NUTWQ2OUZESVNvUFMyeElrNlRlRGoxeGF6d2dYc255Qlhxb3Ro?=
 =?utf-8?B?VERJdkZtNWt6SEt4OWk5aURaTUc0VGxFQk1HSjhTM3pGWFYwdi9LakxCWDBO?=
 =?utf-8?B?enhGemF2SWErQWZMa0txZFpUbC8rUnlBRk92VjI4dWVxZ0M0d0JieWIyV2tT?=
 =?utf-8?B?VTRncVJmNjQra1Z2OXpieDFEb3N3RVFuNlpkYVprZEJ4N0ttTk8zb0NHdGZq?=
 =?utf-8?B?R01uQWcySmsrellwcjN4NEJHbVBQdXdoSzh0QlB4cUdObWE1UXVkbHhGUEFa?=
 =?utf-8?B?YVR5Y0JEUFY0bHlCeHJqNitOZnRNbnlyWXhxZ2VjRXlBWlAzdHJRZW1nZEhF?=
 =?utf-8?B?eVE1aXBHWmExaUlsUVFLSmpnN0FGaUZBSW13THR3WjVROXNicG5aS2FpbHo4?=
 =?utf-8?B?Z1VvSEo1SC9mNEV2RE9qK0VLSUVDNVZ1NjJSelVIdTQ5ZTFJYm4zV2dtMEFV?=
 =?utf-8?Q?XnjLjpWQuQQba2f9iP2FqIjOt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a7a383-fdb5-408b-2ead-08dad25a5242
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 22:37:39.7492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3kF//kK78QaVIBv/cRR0QmSEb6ZBCjrggocecyNixBwXoTabrcx9sSRIspPVDQtwsqyYVxGNoUp7ulL6UIwQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7035
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

On 2022-10-31 12:23, Jonathan Kim wrote:
> This operation allows the debugger to override the enabled HW
> exceptions on the device.
>
> On debug devices that only support the debugging of a single process,
> the HW exceptions are global and set through the SPI_GDBG_TRAP_MASK
> register.
> Because they are global, only address watch exceptions are allowed to
> be enabled.  In other words, the debugger must preserve all non-address
> watch exception states in normal mode operation by barring a full
> replacement override or a non-address watch override request.
>
> For multi-process debugging, all HW exception overrides are per-VMID so
> all exceptions can be overridden or fully replaced.
>
> In order for the debugger to know what is permissible, returned the
> supported override mask back to the debugger along with the previously
> enable overrides.
>
> v2: switch unsupported override mode return from EPERM to EINVAL to
> support unique EPERM on PTRACE failure.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  | 47 ++++++++++++++
>   .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |  2 +
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 55 ++++++++++++++++
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    | 10 +++
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |  5 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 55 ++++++++++++++++
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h | 10 +++
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  7 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 65 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.h        |  6 ++
>   10 files changed, 261 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> index c9629fc5460c..a5003f6f05bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> @@ -25,6 +25,7 @@
>   #include "amdgpu_amdkfd_gfx_v9.h"
>   #include "gc/gc_9_4_2_offset.h"
>   #include "gc/gc_9_4_2_sh_mask.h"
> +#include <uapi/linux/kfd_ioctl.h>
>   
>   /* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
>   static uint32_t kgd_aldebaran_enable_debug_trap(struct amdgpu_device *adev,
> @@ -54,6 +55,50 @@ static uint32_t kgd_aldebaran_disable_debug_trap(struct amdgpu_device *adev,
>   	return data;
>   }
>   
> +static int kgd_aldebaran_validate_trap_override_request(struct amdgpu_device *adev,
> +							uint32_t trap_override,
> +							uint32_t *trap_mask_supported)
> +{
> +	*trap_mask_supported &= KFD_DBG_TRAP_MASK_FP_INVALID |
> +				KFD_DBG_TRAP_MASK_FP_INPUT_DENORMAL |
> +				KFD_DBG_TRAP_MASK_FP_DIVIDE_BY_ZERO |
> +				KFD_DBG_TRAP_MASK_FP_OVERFLOW |
> +				KFD_DBG_TRAP_MASK_FP_UNDERFLOW |
> +				KFD_DBG_TRAP_MASK_FP_INEXACT |
> +				KFD_DBG_TRAP_MASK_INT_DIVIDE_BY_ZERO |
> +				KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH |
> +				KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION;
> +
> +	if (trap_override != KFD_DBG_TRAP_OVERRIDE_OR &&
> +			trap_override != KFD_DBG_TRAP_OVERRIDE_REPLACE)
> +		return -EPERM;
> +
> +	return 0;
> +}
> +
> +/* returns TRAP_EN, EXCP_EN and EXCP_RPLACE. */
> +static uint32_t kgd_aldebaran_set_wave_launch_trap_override(struct amdgpu_device *adev,
> +					uint32_t vmid,
> +					uint32_t trap_override,
> +					uint32_t trap_mask_bits,
> +					uint32_t trap_mask_request,
> +					uint32_t *trap_mask_prev,
> +					uint32_t kfd_dbg_trap_cntl_prev)
> +
> +{
> +	uint32_t data = 0;
> +
> +	*trap_mask_prev = REG_GET_FIELD(kfd_dbg_trap_cntl_prev, SPI_GDBG_PER_VMID_CNTL, EXCP_EN);
> +	trap_mask_bits = (trap_mask_bits & trap_mask_request) |
> +		(*trap_mask_prev & ~trap_mask_request);
> +
> +	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
> +	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, trap_mask_bits);
> +	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE, trap_override);
> +
> +	return data;
> +}
> +
>   const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>   	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
>   	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
> @@ -73,6 +118,8 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>   	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
>   	.enable_debug_trap = kgd_aldebaran_enable_debug_trap,
>   	.disable_debug_trap = kgd_aldebaran_disable_debug_trap,
> +	.validate_trap_override_request = kgd_aldebaran_validate_trap_override_request,
> +	.set_wave_launch_trap_override = kgd_aldebaran_set_wave_launch_trap_override,
>   	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
>   	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
>   	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index 60a204f767ba..b3682758184f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -397,6 +397,8 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
>   				kgd_gfx_v9_set_vm_context_page_table_base,
>   	.enable_debug_trap = kgd_arcturus_enable_debug_trap,
>   	.disable_debug_trap = kgd_arcturus_disable_debug_trap,
> +	.validate_trap_override_request = kgd_gfx_v9_validate_trap_override_request,
> +	.set_wave_launch_trap_override = kgd_gfx_v9_set_wave_launch_trap_override,
>   	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
>   	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
>   	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 2491402afd58..32a6e5fbeacd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -31,6 +31,7 @@
>   #include "v10_structs.h"
>   #include "nv.h"
>   #include "nvd.h"
> +#include <uapi/linux/kfd_ioctl.h>
>   
>   enum hqd_dequeue_request_type {
>   	NO_ACTION = 0,
> @@ -801,6 +802,58 @@ uint32_t kgd_gfx_v10_disable_debug_trap(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +int kgd_gfx_v10_validate_trap_override_request(struct amdgpu_device *adev,
> +					      uint32_t trap_override,
> +					      uint32_t *trap_mask_supported)
> +{
> +	*trap_mask_supported &= KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH;
> +
> +	/* The SPI_GDBG_TRAP_MASK register is global and affects all
> +	 * processes. Only allow OR-ing the address-watch bit, since
> +	 * this only affects processes under the debugger. Other bits
> +	 * should stay 0 to avoid the debugger interfering with other
> +	 * processes.
> +	 */
> +	if (trap_override != KFD_DBG_TRAP_OVERRIDE_OR)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +uint32_t kgd_gfx_v10_set_wave_launch_trap_override(struct amdgpu_device *adev,
> +					      uint32_t vmid,
> +					      uint32_t trap_override,
> +					      uint32_t trap_mask_bits,
> +					      uint32_t trap_mask_request,
> +					      uint32_t *trap_mask_prev,
> +					      uint32_t kfd_dbg_trap_cntl_prev)
> +{
> +	uint32_t data, wave_cntl_prev;
> +
> +	mutex_lock(&adev->grbm_idx_mutex);
> +
> +	wave_cntl_prev = RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL));
> +
> +	kgd_gfx_v10_set_wave_launch_stall(adev, vmid, true);
> +
> +	data = RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK));
> +	*trap_mask_prev = REG_GET_FIELD(data, SPI_GDBG_TRAP_MASK, EXCP_EN);
> +
> +	trap_mask_bits = (trap_mask_bits & trap_mask_request) |
> +		(*trap_mask_prev & ~trap_mask_request);
> +
> +	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_MASK, EXCP_EN, trap_mask_bits);
> +	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_MASK, REPLACE, trap_override);
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), data);
> +
> +	/* We need to preserve wave launch mode stall settings. */
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL), wave_cntl_prev);
> +
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return 0;
> +}
> +
>   /* kgd_gfx_v10_get_iq_wait_times: Returns the mmCP_IQ_WAIT_TIME1/2 values
>    * The values read are:
>    *     ib_offload_wait_time     -- Wait Count for Indirect Buffer Offloads.
> @@ -886,6 +939,8 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
>   	.set_vm_context_page_table_base = set_vm_context_page_table_base,
>   	.enable_debug_trap = kgd_gfx_v10_enable_debug_trap,
>   	.disable_debug_trap = kgd_gfx_v10_disable_debug_trap,
> +	.validate_trap_override_request = kgd_gfx_v10_validate_trap_override_request,
> +	.set_wave_launch_trap_override = kgd_gfx_v10_set_wave_launch_trap_override,
>   	.get_iq_wait_times = kgd_gfx_v10_get_iq_wait_times,
>   	.build_grace_period_packet_info = kgd_gfx_v10_build_grace_period_packet_info,
>   	.program_trap_handler_settings = program_trap_handler_settings,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> index 0abc1e805180..85c929fc2926 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> @@ -26,6 +26,16 @@ uint32_t kgd_gfx_v10_enable_debug_trap(struct amdgpu_device *adev,
>   uint32_t kgd_gfx_v10_disable_debug_trap(struct amdgpu_device *adev,
>   					bool keep_trap_enabled,
>   					uint32_t vmid);
> +int kgd_gfx_v10_validate_trap_override_request(struct amdgpu_device *adev,
> +					     uint32_t trap_override,
> +					     uint32_t *trap_mask_supported);
> +uint32_t kgd_gfx_v10_set_wave_launch_trap_override(struct amdgpu_device *adev,
> +					     uint32_t vmid,
> +					     uint32_t trap_override,
> +					     uint32_t trap_mask_bits,
> +					     uint32_t trap_mask_request,
> +					     uint32_t *trap_mask_prev,
> +					     uint32_t kfd_dbg_trap_cntl_prev);
>   void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev, uint32_t *wait_times);
>   void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
>   					       uint32_t wait_times,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> index c57f2a6b6e23..ae3ead207df4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> @@ -673,5 +673,8 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd = {
>   	.get_iq_wait_times = kgd_gfx_v10_get_iq_wait_times,
>   	.build_grace_period_packet_info = kgd_gfx_v10_build_grace_period_packet_info,
>   	.enable_debug_trap = kgd_gfx_v10_enable_debug_trap,
> -	.disable_debug_trap = kgd_gfx_v10_disable_debug_trap
> +	.disable_debug_trap = kgd_gfx_v10_disable_debug_trap,
> +	.validate_trap_override_request = kgd_gfx_v10_validate_trap_override_request,
> +	.set_wave_launch_trap_override = kgd_gfx_v10_set_wave_launch_trap_override
> +
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 673c99c5523d..cb0044bbfae5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -38,6 +38,7 @@
>   #include "soc15d.h"
>   #include "gfx_v9_0.h"
>   #include "amdgpu_amdkfd_gfx_v9.h"
> +#include <uapi/linux/kfd_ioctl.h>
>   
>   enum hqd_dequeue_request_type {
>   	NO_ACTION = 0,
> @@ -724,6 +725,58 @@ uint32_t kgd_gfx_v9_disable_debug_trap(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +int kgd_gfx_v9_validate_trap_override_request(struct amdgpu_device *adev,
> +					uint32_t trap_override,
> +					uint32_t *trap_mask_supported)
> +{
> +	*trap_mask_supported &= KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH;
> +
> +	/* The SPI_GDBG_TRAP_MASK register is global and affects all
> +	 * processes. Only allow OR-ing the address-watch bit, since
> +	 * this only affects processes under the debugger. Other bits
> +	 * should stay 0 to avoid the debugger interfering with other
> +	 * processes.
> +	 */
> +	if (trap_override != KFD_DBG_TRAP_OVERRIDE_OR)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +uint32_t kgd_gfx_v9_set_wave_launch_trap_override(struct amdgpu_device *adev,
> +					     uint32_t vmid,
> +					     uint32_t trap_override,
> +					     uint32_t trap_mask_bits,
> +					     uint32_t trap_mask_request,
> +					     uint32_t *trap_mask_prev,
> +					     uint32_t kfd_dbg_cntl_prev)
> +{
> +	uint32_t data, wave_cntl_prev;
> +
> +	mutex_lock(&adev->grbm_idx_mutex);
> +
> +	wave_cntl_prev = RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL));
> +
> +	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, true);
> +
> +	data = RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK));
> +	*trap_mask_prev = REG_GET_FIELD(data, SPI_GDBG_TRAP_MASK, EXCP_EN);
> +
> +	trap_mask_bits = (trap_mask_bits & trap_mask_request) |
> +		(*trap_mask_prev & ~trap_mask_request);
> +
> +	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_MASK, EXCP_EN, trap_mask_bits);
> +	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_MASK, REPLACE, trap_override);
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), data);
> +
> +	/* We need to preserve wave launch mode stall settings. */
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL), wave_cntl_prev);
> +
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return 0;
> +}
> +
>   /* kgd_gfx_v9_get_iq_wait_times: Returns the mmCP_IQ_WAIT_TIME1/2 values
>    * The values read are:
>    *     ib_offload_wait_time     -- Wait Count for Indirect Buffer Offloads.
> @@ -992,6 +1045,8 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
>   	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
>   	.enable_debug_trap = kgd_gfx_v9_enable_debug_trap,
>   	.disable_debug_trap = kgd_gfx_v9_disable_debug_trap,
> +	.validate_trap_override_request = kgd_gfx_v9_validate_trap_override_request,
> +	.set_wave_launch_trap_override = kgd_gfx_v9_set_wave_launch_trap_override,
>   	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
>   	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
>   	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index c0866497cb5c..47cff392b434 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -64,6 +64,16 @@ uint32_t kgd_gfx_v9_enable_debug_trap(struct amdgpu_device *adev,
>   uint32_t kgd_gfx_v9_disable_debug_trap(struct amdgpu_device *adev,
>   					bool keep_trap_enabled,
>   					uint32_t vmid);
> +int kgd_gfx_v9_validate_trap_override_request(struct amdgpu_device *adev,
> +					     uint32_t trap_override,
> +					     uint32_t *trap_mask_supported);
> +uint32_t kgd_gfx_v9_set_wave_launch_trap_override(struct amdgpu_device *adev,
> +					     uint32_t vmid,
> +					     uint32_t trap_override,
> +					     uint32_t trap_mask_bits,
> +					     uint32_t trap_mask_request,
> +					     uint32_t *trap_mask_prev,
> +					     uint32_t kfd_dbg_trap_cntl_prev);
>   void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev, uint32_t *wait_times);
>   void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
>   					       uint32_t wait_times,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 61612b9bdf8c..1f0ee2413b13 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2891,6 +2891,13 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
>   				args->set_exceptions_enabled.exception_mask);
>   		break;
>   	case KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_OVERRIDE:
> +		r = kfd_dbg_trap_set_wave_launch_override(target,
> +				args->launch_override.override_mode,
> +				args->launch_override.enable_mask,
> +				args->launch_override.support_request_mask,
> +				&args->launch_override.enable_mask,
> +				&args->launch_override.support_request_mask);
> +		break;
>   	case KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_MODE:
>   	case KFD_IOC_DBG_TRAP_SUSPEND_QUEUES:
>   	case KFD_IOC_DBG_TRAP_RESUME_QUEUES:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 594ccca25cae..8add359d1cb9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -442,6 +442,71 @@ int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
>   	return r;
>   }
>   
> +static int kfd_dbg_validate_trap_override_request(struct kfd_process *p,
> +						uint32_t trap_override,
> +						uint32_t trap_mask_request,
> +						uint32_t *trap_mask_supported)
> +{
> +	int i = 0;
> +
> +	*trap_mask_supported = 0xffffffff;
> +
> +	for (i = 0; i < p->n_pdds; i++) {
> +		struct kfd_process_device *pdd = p->pdds[i];
> +		int err = pdd->dev->kfd2kgd->validate_trap_override_request(
> +								pdd->dev->adev,
> +								trap_override,
> +								trap_mask_supported);
> +
> +		if (err)
> +			return err;
> +	}
> +
> +	if (trap_mask_request & ~*trap_mask_supported)
> +		return -EACCES;
> +
> +	return 0;
> +}
> +
> +int kfd_dbg_trap_set_wave_launch_override(struct kfd_process *target,
> +					uint32_t trap_override,
> +					uint32_t trap_mask_bits,
> +					uint32_t trap_mask_request,
> +					uint32_t *trap_mask_prev,
> +					uint32_t *trap_mask_supported)
> +{
> +	int r = 0, i;
> +
> +	r = kfd_dbg_validate_trap_override_request(target,
> +						trap_override,
> +						trap_mask_request,
> +						trap_mask_supported);
> +
> +	if (r)
> +		return r;
> +
> +	for (i = 0; i < target->n_pdds; i++) {
> +		struct kfd_process_device *pdd = target->pdds[i];
> +
> +		amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
> +		pdd->spi_dbg_override = pdd->dev->kfd2kgd->set_wave_launch_trap_override(
> +				pdd->dev->adev,
> +				pdd->dev->vm_info.last_vmid_kfd,
> +				trap_override,
> +				trap_mask_bits,
> +				trap_mask_request,
> +				trap_mask_prev,
> +				pdd->spi_dbg_override);
> +		amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
> +
> +		r = debug_refresh_runlist(pdd->dev->dqm);
> +		if (r)
> +			break;
> +	}
> +
> +	return r;
> +}
> +
>   void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
>   					uint64_t exception_set_mask)
>   {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> index 837e09491a76..b54a50a5d310 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> @@ -45,6 +45,12 @@ int kfd_dbg_trap_disable(struct kfd_process *target);
>   int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
>   			void __user *runtime_info,
>   			uint32_t *runtime_info_size);
> +int kfd_dbg_trap_set_wave_launch_override(struct kfd_process *target,
> +					uint32_t trap_override,
> +					uint32_t trap_mask_bits,
> +					uint32_t trap_mask_request,
> +					uint32_t *trap_mask_prev,
> +					uint32_t *trap_mask_supported);
>   
>   int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
>   					unsigned int dev_id,
