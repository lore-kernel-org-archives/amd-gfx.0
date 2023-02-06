Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AD8C05027
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 16:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0149F10E9BE;
	Mon,  6 Feb 2023 16:51:21 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C041A10E422
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 16:51:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmr6iLu/NxuoDQhZqUBXSY5QqRvSHJN1crUHSYe7eJXiz6cjjAi61Yi2aQU4dodIkOxS3YrsB5yfkAVrj3Pjhc3BpxAIoirPYFosGQFR+HcZXoowsHummHP7wa67qPIBv6lyES7DwkerR+8DQ7CH5hQw+wQZnLYRlo2L/lZ5Gq62iMLqG/VQ1KBL1ws/g76j2grsItvPb4G8oDiv9d/gbbM7jaEXqcyPMB7AU5x6Mjjv0c3XjAXKaLirqFUjFytFuSkg8TO4mAiqe5wTxJWHN8hLKHEcb4mEVv6moKazJYgX9T8AHmb3VkkWaL7Le5+BT4dxM4YVXjs5K3rqvWwtOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSatKUoN5sMdslTqs6XQstnzNy7ykaOVm9u7F/vuJGY=;
 b=I8qNHFgkpMw+LnHXEXmFIxrz73JB3otV47VQ03miFbIB2fICkz7MGGUVDvS2HXkk+7ConoCKD8zUCk0ZIezkwALm1CPXx3l5Aj9rQurd8lsxmqZAXe0kHFg9J4BH3MTWLWdbf4BDQHbdnSSTlg771+Yqqcu2vYZlxswyCnjruLRNt47MUVEJgQggtp+WAzPhFfuik9CWm0byzdekl7JUAzcV7ExWIeAkyl81hEWInntZwHQrhquGma2vy7eBa5t43FDsnLM4ENZOW8oKRp0vIlSUVIqXTzmLuFvw3tlwnKKwArcco6ECdobfTwrDD/OK8Wg4YnY9ks/yP2Mxu35Q6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSatKUoN5sMdslTqs6XQstnzNy7ykaOVm9u7F/vuJGY=;
 b=ZmNFjOXQIFut20PVIyWsvERkChXlXJbfedZJJgOCmxqbI64WuwUkFazqQaHVEIcsQIGpT0/fI3uuPKl3K9J3KNcSRmKbaSpZb9zHR4ycUHCOZGIwudbv8/QXOigVoTILdGolvbIrXrfAxIrnHTTa4yAV5lTFALmo3oop5LPMUM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SA3PR12MB8021.namprd12.prod.outlook.com (2603:10b6:806:305::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Mon, 6 Feb
 2023 16:51:15 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 16:51:15 +0000
Message-ID: <b94aa331-ce65-fbe2-6695-32e68ec68236@amd.com>
Date: Mon, 6 Feb 2023 17:51:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 12/13] drm/amdgpu: add domain info in bo_create_kernel_at
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230203190836.1987-1-shashank.sharma@amd.com>
 <20230203190836.1987-16-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230203190836.1987-16-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::8) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SA3PR12MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e772123-2f4b-48a6-0c2f-08db08625c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BuEPmJtQdfY8vleBHScJFzu7MzON7hgvkpgX7WxgpULNUS2e1KRG+pqkXAv+t4TClkhENMR6DpA0BM/TIrbYm/AiwJpSwwu/vHsdoNeluoYsUpTT//pxVvsaa/Cc+aynx/GA7XG7j4pPwKr8fX1gb3kyQxYLZfAzW7uvTBmqSmn/Og5QIrYRlxFKa4S1igl2U9b1+e29Biz+AFrMGE4lMg+W+8IFatX+ab1NVaz1Z2AJEcvzYrCNne82aDnADE1ZiQ+Y545zuddYqIpEuJrSNT/LQz29ADIwTPYhzc0L5OCDfAivBQN0Q5fiMVatwmDu9j4m2kximsoUhboNIitFlQN3+ZNJBtYeL4sq76Yvj2XlVpJK0EMHUcsyiqY3AZ1IgcjnmPSBAf5tk2tCi2EcVU6Lt59w5HO/Te8P+UrJqh/Ry0oWPzelFSMenNeWbJ4N+UpRxfK+o041kyLNJ9viCuo18hIq3qsF9wAQObPVhb4cLPwybl62KxW14WxnW/u+KPxnTCHQuWZCSmps03+d3OV/bg5Zz8ctrJBL5wGaHkCIQsVSYMYA2wa+8yN37Xh5Lfe5os8ufg9ctHJLhICUnU+g1uiqAcgKkyDy668WEHw9VG7dQapZkGd0F6cD7WW+MBlgH5VKbXGzpgprKhp46e/v+yN/oVZe3QXisbICPFWTFsDLVa0BExLa/C3sQn87P3Ko2sddioCU65hbTLdS+hDCxuFtNvJSlHAMbxdIDUY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199018)(6486002)(478600001)(316002)(36756003)(5660300002)(31696002)(83380400001)(8676002)(4326008)(66476007)(41300700001)(86362001)(2906002)(8936002)(66556008)(66946007)(2616005)(38100700002)(6506007)(6512007)(186003)(31686004)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vmw5WTRwblJiT2J2UU9qb082M3FFbXFoWWRuaWhZTjNXRnJmZGNsMHZ2dkJI?=
 =?utf-8?B?WnF6ZUJPTjU4cHpia2VFam0vZGwwb2syK1VQNVpnVExhWUROWTh5Y0JobUw3?=
 =?utf-8?B?cWlZempMa2xaV1Y5YVAzYnRjMEgyelBQOHc5eklobjh4OHI2UXJwemgrdFd1?=
 =?utf-8?B?VVQ1bHpDbTJKTm9ETHJ3blQ3L2tYbFhIMU1oUkVySTFkbFJsSFhFUDkyaTQz?=
 =?utf-8?B?eFovSG9CRzZ5dCtlbXUyK2s0N3N3elNCdFU4SFVpT2NuK1htSit3ZGtIYy93?=
 =?utf-8?B?Slo2WWUvL2pGeHk5bnRVQkVuUjA5Y2k2dWtSWkU5eEFqMVcyaGVVVDdPeDVl?=
 =?utf-8?B?UjBjOTJyS1R4NVRTcHMrZUdsNzg0Q3NqS0hVdVVqQmdSemV2Y2RLU0huRlBW?=
 =?utf-8?B?WThrMW5UajFNUk1DaFppY1NtZlNTcXh0aGk3WnNQbFA3djBzejlzNVBzTFA2?=
 =?utf-8?B?VlEzckF5TXMxMzRGNG5xZUpadVBUbmJYbnFPUmVCSW5mVDdta0JnMnBMbmsw?=
 =?utf-8?B?bHVnbzYyVzN2QWNZbXhEUWVnL0JKT2plaC81ZTIwb3BGZGVKZ2xXL2FnM1dI?=
 =?utf-8?B?QjlESjhRZ3RpQnBCNWJSR3F0ZVVZZDFycXJPMkNiSlhSSlJ4RXBCaU04YTVJ?=
 =?utf-8?B?T2ZXb3lTMy8vakhnb2p3Zy9lY1lhR2c0TXlnT2xkTWNkV3B0bTdFNitUbzAx?=
 =?utf-8?B?UlJIZ2hWOHRMck9lbzRCZ1RaN3RFUWU3bVB6Q2xrYjVWVHpsdm1GaHJwdDc0?=
 =?utf-8?B?dys5ZEh0K0YrT3RvNVVPODRzMit6V1dlWUYvYlVMODIvR1VYb2gySU5aeUNq?=
 =?utf-8?B?M2Q2dkZxRUY5eVdqTVFzUXFISEpHekVIbE5NSTVzMlE5dVFHSU9acGtMbXdS?=
 =?utf-8?B?VU8zaDZ4b2p5YzczVlpTdUlWNEkzNkNVZVB2dDFoZitJbFdMZldCcmZZcW85?=
 =?utf-8?B?aGxkVXpWMW1wTXRucjZVdXFmdVdHb2VES25wR21QdFM1RFAreWJJMUFVdGNt?=
 =?utf-8?B?WkNMbWlXcWI2N29YdGlHaGZPbFZRbjRTaHlWbmExOVBHQmVQdXRuZlROSUZW?=
 =?utf-8?B?NHJTL3NyaGs1aU9KMmgyQVQzMTE1L25kNlkza2VoT0YrLzdLWGROTGF2L3JP?=
 =?utf-8?B?RUJYbzN6Z3hnVHFkWkVpaW9hV09UNUlSNnBXOE95VllLL2tyekNXd3ZjeTFU?=
 =?utf-8?B?RFJrM3Bmc3lSMENYb3Yyc1V6bGM1NUlMRVBic0p4T0hhTTIyRlNhMnRlL09S?=
 =?utf-8?B?T0NOK2lNTElBejluT2JJNHoxQU10bVUvWnBjR3QyMkV4eitOUnY4ank3c0NT?=
 =?utf-8?B?U1crVTVHdVlxZnQ4eWd1WW5DeXhQK1RTTnh5aHhvN3hTMWk2dHN5ZEdCQWJ3?=
 =?utf-8?B?S1N4U3pnZDFLWkRtTlU0L3VBMVF5NTJsOE4zY3Uya24zc2l0NlNJbjdNbUhl?=
 =?utf-8?B?bmZia1poNEdXdTljRDhybnhSWDBITmpLeW02V1RFL05vOTF2bFNxY3JpWDdu?=
 =?utf-8?B?bkZxRmUwMEpyNHEyZGtkZ0U2TzZDQUxrNHNPSVltMkJ5MDB1YkNZanU5U2tk?=
 =?utf-8?B?Ujc4cmVXOHI0SWRRamF2aFdDUjE3VW42ekorTHBSWEZTS2tWS0M2Mmk2a2tY?=
 =?utf-8?B?ZVYxUWV4VlZPTlNVV1U5ZDhHcHh3dVhnN1pmZjNqOFZ3OW9xWjBwRys2QjRI?=
 =?utf-8?B?QlVxQnUwb3VBMVAvQ2tHTVhvR28vcnBTc0RUQjBWY1I2enZsa2FSZDRBdTRD?=
 =?utf-8?B?aW5KWFFHNHVJTy9GWkMwZWhqdnFKZHJHMnhtNnNxWDNPTXJJTThUejE1cE1v?=
 =?utf-8?B?MkNZWWhFNk45bXFHNGtEU0NoZ2tGU1hXSUw4Vk03K0JlNzdhelZsNDJ2Y0Rk?=
 =?utf-8?B?UnNQVHdUalVaWlgxdjg5YmNMQ0phcEZhcllBQUgwaHpUNU0ybjdkZ3A5am5P?=
 =?utf-8?B?SmtQWXB5SE1nOXNpMGIvZ3ZEQkpFbGZjK0VTUy9pL1pvamp5OS84YWsyOVNm?=
 =?utf-8?B?VlN4OU1QSTdyZEVTN0ZQOWRpNllkRjl6U1B4cHR2bDFvb0hEMEgybXdqamEx?=
 =?utf-8?B?bGp3OFhZZ0kzeUdTUk1aNWVhWlpxRDhhNmtRK1l0R1pySVBHWjloSngwMHFh?=
 =?utf-8?B?aHlJZFBvSWtmMG9PaE92Uk51RmJ0NWRObDd0UUk5aHdPQ3VuWmpPL0ZneDd1?=
 =?utf-8?Q?cPqi30qmQt3/UJO9qEM4KXBTOhk40O6elhinHt/xUXm4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e772123-2f4b-48a6-0c2f-08db08625c0f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 16:51:15.1270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUADldCHDdpthAzr1ErE02lianHS9uRH1S+rmAc+yimGetX2rzk8uofYpZ7bOUqz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8021
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.02.23 um 20:08 schrieb Shashank Sharma:
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> This patch adds a domain input variable for amdgpu_bo_create_kernel_at,
> so that it could be used for both VRAM and DOORBELL domains objects. It
> also adds supporting code for existing callers.

We should probably drop this one as well.

We just removed the domain from the function because we only have BIOS 
reserved regions in VRAM, never anywhere else.

Allocating a doorbell for the kernel is not really an use case for 
amdgpu_bo_create_kernel_at().

Christian.

>
> Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 7 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 1 +
>   4 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index ef1f3106bc69..dec391fa42dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -367,7 +367,7 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
>    * 0 on success, negative error code otherwise.
>    */
>   int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
> -			       uint64_t offset, uint64_t size,
> +			       uint64_t offset, uint64_t size, uint32_t domain,
>   			       struct amdgpu_bo **bo_ptr, void **cpu_addr)
>   {
>   	struct ttm_operation_ctx ctx = { false, false };
> @@ -378,7 +378,7 @@ int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
>   	size = ALIGN(size, PAGE_SIZE);
>   
>   	r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM, bo_ptr, NULL,
> +				      domain, bo_ptr, NULL,
>   				      cpu_addr);
>   	if (r)
>   		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index bf9759758f0d..b2b7e55ac486 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -284,7 +284,7 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
>   			    u32 domain, struct amdgpu_bo **bo_ptr,
>   			    u64 *gpu_addr, void **cpu_addr);
>   int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
> -			       uint64_t offset, uint64_t size,
> +			       uint64_t offset, uint64_t size, uint32_t domain,
>   			       struct amdgpu_bo **bo_ptr, void **cpu_addr);
>   int amdgpu_bo_create_user(struct amdgpu_device *adev,
>   			  struct amdgpu_bo_param *bp,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 08355f981313..4cec90debe46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1591,6 +1591,7 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
>   	return amdgpu_bo_create_kernel_at(adev,
>   					  adev->mman.fw_vram_usage_start_offset,
>   					  adev->mman.fw_vram_usage_size,
> +					  AMDGPU_GEM_DOMAIN_VRAM,
>   					  &adev->mman.fw_vram_usage_reserved_bo,
>   					  &adev->mman.fw_vram_usage_va);
>   }
> @@ -1616,6 +1617,7 @@ static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
>   	return amdgpu_bo_create_kernel_at(adev,
>   					  adev->mman.drv_vram_usage_start_offset,
>   					  adev->mman.drv_vram_usage_size,
> +					  AMDGPU_GEM_DOMAIN_VRAM,
>   					  &adev->mman.drv_vram_usage_reserved_bo,
>   					  &adev->mman.drv_vram_usage_va);
>   }
> @@ -1696,6 +1698,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
>   		ret = amdgpu_bo_create_kernel_at(adev,
>   					 ctx->c2p_train_data_offset,
>   					 ctx->train_data_size,
> +					 AMDGPU_GEM_DOMAIN_VRAM,
>   					 &ctx->c2p_bo,
>   					 NULL);
>   		if (ret) {
> @@ -1709,6 +1712,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
>   	ret = amdgpu_bo_create_kernel_at(adev,
>   				adev->gmc.real_vram_size - adev->mman.discovery_tmr_size,
>   				adev->mman.discovery_tmr_size,
> +				AMDGPU_GEM_DOMAIN_VRAM,
>   				&adev->mman.discovery_memory,
>   				NULL);
>   	if (ret) {
> @@ -1816,18 +1820,21 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   	 * avoid display artifacts while transitioning between pre-OS
>   	 * and driver.  */
>   	r = amdgpu_bo_create_kernel_at(adev, 0, adev->mman.stolen_vga_size,
> +				       AMDGPU_GEM_DOMAIN_VRAM,
>   				       &adev->mman.stolen_vga_memory,
>   				       NULL);
>   	if (r)
>   		return r;
>   	r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_vga_size,
>   				       adev->mman.stolen_extended_size,
> +				       AMDGPU_GEM_DOMAIN_VRAM,
>   				       &adev->mman.stolen_extended_memory,
>   				       NULL);
>   	if (r)
>   		return r;
>   	r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_reserved_offset,
>   				       adev->mman.stolen_reserved_size,
> +				       AMDGPU_GEM_DOMAIN_VRAM,
>   				       &adev->mman.stolen_reserved_memory,
>   				       NULL);
>   	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index fc9edc3028b6..fd1f58158238 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -395,6 +395,7 @@ static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
>   		 */
>   		if (amdgpu_bo_create_kernel_at(adev, bp << AMDGPU_GPU_PAGE_SHIFT,
>   					       AMDGPU_GPU_PAGE_SIZE,
> +					       AMDGPU_GEM_DOMAIN_VRAM,
>   					       &bo, NULL))
>   			DRM_DEBUG("RAS WARN: reserve vram for retired page %llx fail\n", bp);
>   

