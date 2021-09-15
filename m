Return-Path: <SRS0=hzS6=OF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0112EC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 20:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD7D1601FA
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 20:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD7D1601FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B4166EA1D;
	Wed, 15 Sep 2021 20:14:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F394C6EA1D
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Sep 2021 20:14:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bb5yUxK7Q5ziDaL0pYgrVuw5rStL457IlmykUwpTQTM8cMcKAmrP9BiGmheszMORZPTMeb4edm9t/ZyOqFNFeEAPu0TT7M1R4+2oTHhn0BV2rchUpKHFrkETqK2SDtZ8YUeGhdc33AhQXqZgot10No2NuOvRICxP/Vk6ZYP7WqV5sLBiHd1xQcRaIEW8GJyWhiX5w2loZq2fSaweidq8UxHtBp1G2bPk73tuxDGZRQF9sUPnAn7oQeXjRe/Pvp/w0Hqw7suQzCPXm4dt80pL/cE+R3LmUicB0AtHSH8Y1HqM5HDd6w9J9IOytcQQjzzXfaLT3tYhIGNqSq045MLWOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=d02FifD+zbtpjbsWrBQTc6oSCUnekXOlnnOdWJr8oXI=;
 b=dh/5rl0Z5DUDXjvFnIknRgZjhATvNEgejhidclTCtxNTTh9naGyEzSziPSKNXMNKb3zBt8eCOqJsj2Q14qavPJQXLQ3Zc14xailZUZLNusyf4UNOm/5LDCtWyv51Dsj3XcOFGgj4D8X6UdaUL8oQV7ReIMavroQhMQqPXWf/E87U2rIDOkvmAEbL+jQVGtl2WqD/V5YtlsuJ8zhXAO7DQ1zjr+rF6mjF5kTYwlYqDe7oiCIhn06Tx/FYAbovrCnFQPeE3VkguSQ3VuMdLZn1TrKqGmBmiR0JkevBLfRbjx+HoNplVonWJGJ4tb2EvJJ5szKIxEAP+Owv5kz1oDB23A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d02FifD+zbtpjbsWrBQTc6oSCUnekXOlnnOdWJr8oXI=;
 b=NNMt5JeZYmXy6jerNr6ktzfZs4z7dUfqK7u+5bR87Ejz4rcy3S44aNuAWL2AjBV5soKA8oal9zFo8cRcaLKtHAGseNcNUkhNhDCaEHc+ofD23bsX0WwkTi1Ueky9eG63FquTimivhvrei3t6gvAIworcNGx4ZhDmO6MG2PujhSo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 20:14:49 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::c4ac:2505:5bd8:295d]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::c4ac:2505:5bd8:295d%6]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 20:14:49 +0000
Subject: Re: [PATCH v2] drm/amdgpu: Put drm_dev_enter/exit outside hot codepath
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
References: <20210915063739.31244-1-xinhui.pan@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <120864cb-15ec-0ff1-b60d-7b90a408c7cd@amd.com>
Date: Wed, 15 Sep 2021 16:14:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210915063739.31244-1-xinhui.pan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::16) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:b7f3:c5bf:cc7e:9d39]
 (2607:fea8:3edf:49b0:b7f3:c5bf:cc7e:9d39) by
 YTXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Wed, 15 Sep 2021 20:14:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da1a5e18-b1a5-4bc4-87d9-08d9788577f6
X-MS-TrafficTypeDiagnostic: SA0PR12MB4381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4381655B74D00F3799BA1C80EADB9@SA0PR12MB4381.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DFOWbDeNTs7swOG3ztZB1R4xo+i8bIxd3g5fZ34mjK0ccIAEbua9C7TRN1Op81E2eayB46xa/oQOWWFR+OTKvXFMZsG3JbqAFH11p7azK9siUhXmAEqzgsoWA4W/DW/h5ByzjiyAjOTS0+QEjK94nqyJ2HNZp1gqVqK2vlqDwlY5Ii+bebergOUMWjmvgm83kv65Ls3eHcWUOv7XJbI3iKtVFfJBGfiNHi5vUyS/eE5ChodxH02pqMaD1suzLlJFOK666Xkk1xVCrlsKRNSs6pzlLlqhjY6/gNCHCi5hd7+H6OIQTyVdql5cKbAcFUYPR0X4JLMk/NkeF7kHjBz87DOT6uSYiSD8FdyRScEgWNYBGpxJXDZrACBuam2M5UBU6neE6JOoYYwSR7o8zPgfa9UxjiVrrDkPLlLERHhAJv7/fgHuWwJt7/fgYdHyaurjHvZvW4JDhXw8xNEyGj+NwDNly5eyhX1vQG7NOXcDPDRMmwHJUfi3UpyDVUZkK4q90hw3sokeYxLURU3aEzlsY8lqNRw7TqrFcy5nZCJryM9Lu1vALyZQ9cu9yyc+caz4VBy0m6lxpfoEe1u7JmNXpb+qroJJbkFtqa23B/D+j/sUe7Rg8ZzZlaEZMyyoicA2aG4Sx97yYfKJyuVXqfXTVk1dzUJlPPQN6dSvmSGeJ/hzJ5tytJ1iBZbotlbf4TlGu+O9inghiN44vpvWCi+DY6FXCB6CbwguOJtWM+tscTQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(8936002)(31696002)(66946007)(2906002)(53546011)(66476007)(83380400001)(38100700002)(66556008)(186003)(31686004)(36756003)(4326008)(478600001)(86362001)(316002)(8676002)(5660300002)(2616005)(6486002)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnRwV0tPalFpMmpkL2g3UDlneFFIMUJuMGc3YVpMYThKV0tLU1UwV3ZaTjQx?=
 =?utf-8?B?M213Z2RpQ29ISW5uMkRrS1UycWVhVHpqbDVaT1dWOTArY2hjL2YwV0pEek9V?=
 =?utf-8?B?eDRYcHN3MWdMNkdxbmhMQisycTRENzA4UUFqN2crSk15di9aWnpOY2p6OUNx?=
 =?utf-8?B?M1NocHNseXdhMEttdjZJcy9zZ2tJZkdWSDE3cEZuUDd4dkptRXRWNXpra1oy?=
 =?utf-8?B?WnJKZUZ4aFpmMVJXak96TXlJN3EvNTFrRVM2RWtWVGNzanNadmxzenlhMG1z?=
 =?utf-8?B?b0piT0VCY0RaK2RjM2ZBcC9zRStaYk1wZy9TK1g0TjV3MkplWHR6bVBoTExQ?=
 =?utf-8?B?cW5RYjRybXZBOGQ3L1Z2ejAxcVpwdFdkY3ArL0RNdHFmTERFS2pkOUZuTXdF?=
 =?utf-8?B?R010aVZFZzREMHh5Szl6VklxK1V1bXpsSUY1bzd5aU1uSUhvaENxWWppSkxN?=
 =?utf-8?B?cmFEcGhjc2xPUlcxZW42Zy9Pb2ZKZk9yYnU3SmcxVUJRSWJSMUpLbDBOZWZk?=
 =?utf-8?B?NnlVTWMrZVFUVjdaSGgwSFFwTWRETVN6VnFnenFwSlBzeWdOVG9JM2RnR3RU?=
 =?utf-8?B?VzRIMUsvSVRnOERncFM2em4wS29oamJ5aGt3cnQ2MkRmUEZtTE5wRTJ0V3RL?=
 =?utf-8?B?SHc0SDlaVGlXaUNocXhMazRsZ3BxTktZUkVmUSt3WVBRYW5lYWtiRUF6ZE1V?=
 =?utf-8?B?NXU4YkFNMWN0Q1lDcStTWkdMRG9uaDdzK2p6MWw0aWQ4R3RwZXJvWURuS0lN?=
 =?utf-8?B?N0dueWlaVkxsQzZ0WTF4WEQ2TWNKc0VncElJazNtQWRWeHdiUmZLcjR4UEZE?=
 =?utf-8?B?WW9XWnBnc05KUXZ2RFl0NGhra21NRjN0eDVueU03elVMRXJnZEl0aiswQmVp?=
 =?utf-8?B?WjZoYTQ3MERyRXNRZmtuUWRJMjVvdlRIbXhnTHBWZzZSZlpvYk51K0ZlWXBX?=
 =?utf-8?B?RGFtREFpRGtmTXk1U2puN0JjclZCVSs1eGpuY1RjT1FKMERodDVCNGpUMlRH?=
 =?utf-8?B?eDJQY0JXSTRTSUVQNjhDYUpvMXk0R3d6Q3JKZFN5YkxYeC96ektWSlVORTc3?=
 =?utf-8?B?OVdPZVZxMHowdDk2M3hhUUpRR2hMby9XejUwUkREanE2YS9VTG5HcTRjaUxI?=
 =?utf-8?B?eTJOQUtwTzFERk8xK3Z6M2lMZmxPQVZyMVViaTN1cE52V0J6VlJ3SUdicTEw?=
 =?utf-8?B?bmZMcnN2WUpaeTBkdk9OQlN4UTRVbmpUbnlocEZCOVE5L1N2M0h4TWdwQ1Jl?=
 =?utf-8?B?RjBNMHdDUzYvcmFOYXlPeWZGNW1zMGxXS0JNZWI3dy96Y0VsUG9wWWJSUVNh?=
 =?utf-8?B?Y0FSZmoxdWNBM2l4Yks2Qlozc2lXNzAyNzZXbHRJeFE1cEZCZDhjT1MyLytW?=
 =?utf-8?B?R0FyNXA3bzVoMTB3ZU9Kb0syeFlQNTRkTjVJVktmUmVaQXJaNFBGVzF6Y0pr?=
 =?utf-8?B?NzF3RXNGV3ZsR2NSdjFaK0ZRRW5ISXUrYVNXeHNMeVVhY2lIVDBmejRyc3V6?=
 =?utf-8?B?cDdjRDE3Y09rd1JEMTdISmQ5THJFYTBiVEtlb2RwZXlDaFYzeHcrN2lQVDFw?=
 =?utf-8?B?UVlPTW90N1VYMzRlemx2cXB0UXAxNVBHSldrTXJ2dVpHN3A1TXJsMlUyNHND?=
 =?utf-8?B?NktXTzhFMlIvYmhXUE1zOGVQMDk3SEtjUERXaVZuOWJGRnd3NmJaMjNYdUFp?=
 =?utf-8?B?OUY0bjkxdE1WSW9xOUpiWjFIZk42YldCTHo4aDQyekduVHp2UmUrY203S0JC?=
 =?utf-8?B?SERqQWtpQk8rOGt2K1F6MVh3VHNSdysrVUQxRDc2Rjg2ek5wUzVUVXBTQXhx?=
 =?utf-8?B?U3BrUUFLWlN6STNoQkFpU094T2lXWGhudDNJc1BZYXM5WlBXT24zRitNOVR0?=
 =?utf-8?Q?bbHdPk47Nw95Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1a5e18-b1a5-4bc4-87d9-08d9788577f6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 20:14:49.0783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTOkm2ldixSPpvDEJ5IPvtTMbCgO8DBHzVB3lMFnMfXI6sM7GKi6slw9W6OgyBitNF3S+oJEsrfSJ2ypzwZ9sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
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

I fixed 2 regressions and latest code, applied your patch on top and 
passed libdrm tests
on Vega 10. You can pickup those 2 patches and try too if you have time. 
In any case -

Reviewed-and-tested-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 2021-09-15 2:37 a.m., xinhui pan wrote:
> We hit soft hang while doing memory pressure test on one numa system.
> After a qucik look, this is because kfd invalid/valid userptr memory
> frequently with process_info lock hold.
> Looks like update page table mapping use too much cpu time.
>
> perf top says below,
> 75.81%  [kernel]       [k] __srcu_read_unlock
>   6.19%  [amdgpu]       [k] amdgpu_gmc_set_pte_pde
>   3.56%  [kernel]       [k] __srcu_read_lock
>   2.20%  [amdgpu]       [k] amdgpu_vm_cpu_update
>   2.20%  [kernel]       [k] __sg_page_iter_dma_next
>   2.15%  [drm]          [k] drm_dev_enter
>   1.70%  [drm]          [k] drm_prime_sg_to_dma_addr_array
>   1.18%  [kernel]       [k] __sg_alloc_table_from_pages
>   1.09%  [drm]          [k] drm_dev_exit
>
> So move drm_dev_enter/exit outside gmc code, instead let caller do it.
> They are gart_unbind, gart_map, vm_clear_bo, vm_update_pdes and
> gmc_init_pdb0. vm_bo_update_mapping already calls it.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
> change from v1:
> add enter/exit in more gmc_set_pte_pde callers
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 11 ++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 11 +++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   | 28 +++++++++++++++++-------
>   3 files changed, 36 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index 76efd5f8950f..d7e4f4660acf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -34,6 +34,7 @@
>   #include <asm/set_memory.h>
>   #endif
>   #include "amdgpu.h"
> +#include <drm/drm_drv.h>
>   
>   /*
>    * GART
> @@ -230,12 +231,16 @@ int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>   	u64 page_base;
>   	/* Starting from VEGA10, system bit must be 0 to mean invalid. */
>   	uint64_t flags = 0;
> +	int idx;
>   
>   	if (!adev->gart.ready) {
>   		WARN(1, "trying to unbind memory from uninitialized GART !\n");
>   		return -EINVAL;
>   	}
>   
> +	if (!drm_dev_enter(&adev->ddev, &idx))
> +		return 0;
> +
>   	t = offset / AMDGPU_GPU_PAGE_SIZE;
>   	p = t / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>   	for (i = 0; i < pages; i++, p++) {
> @@ -254,6 +259,7 @@ int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>   	for (i = 0; i < adev->num_vmhubs; i++)
>   		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
>   
> +	drm_dev_exit(idx);
>   	return 0;
>   }
>   
> @@ -276,12 +282,16 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>   {
>   	uint64_t page_base;
>   	unsigned i, j, t;
> +	int idx;
>   
>   	if (!adev->gart.ready) {
>   		WARN(1, "trying to bind memory to uninitialized GART !\n");
>   		return -EINVAL;
>   	}
>   
> +	if (!drm_dev_enter(&adev->ddev, &idx))
> +		return 0;
> +
>   	t = offset / AMDGPU_GPU_PAGE_SIZE;
>   
>   	for (i = 0; i < pages; i++) {
> @@ -291,6 +301,7 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>   			page_base += AMDGPU_GPU_PAGE_SIZE;
>   		}
>   	}
> +	drm_dev_exit(idx);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 54f059501a33..1427fd70310c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -153,10 +153,6 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
>   {
>   	void __iomem *ptr = (void *)cpu_pt_addr;
>   	uint64_t value;
> -	int idx;
> -
> -	if (!drm_dev_enter(&adev->ddev, &idx))
> -		return 0;
>   
>   	/*
>   	 * The following is for PTE only. GART does not have PDEs.
> @@ -165,8 +161,6 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
>   	value |= flags;
>   	writeq(value, ptr + (gpu_page_idx * 8));
>   
> -	drm_dev_exit(idx);
> -
>   	return 0;
>   }
>   
> @@ -752,6 +746,10 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>   		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
>   	u64 vram_end = vram_addr + vram_size;
>   	u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
> +	int idx;
> +
> +	if (!drm_dev_enter(&adev->ddev, &idx))
> +		return;
>   
>   	flags |= AMDGPU_PTE_VALID | AMDGPU_PTE_READABLE;
>   	flags |= AMDGPU_PTE_WRITEABLE;
> @@ -773,6 +771,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>   	flags |= AMDGPU_PDE_BFS(0) | AMDGPU_PTE_SNOOPED;
>   	/* Requires gart_ptb_gpu_pa to be 4K aligned */
>   	amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, gart_ptb_gpu_pa, flags);
> +	drm_dev_exit(idx);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 0126ece898da..daa16d2f89da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -800,7 +800,7 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
>   	struct amdgpu_bo *bo = &vmbo->bo;
>   	unsigned entries, ats_entries;
>   	uint64_t addr;
> -	int r;
> +	int r, idx;
>   
>   	/* Figure out our place in the hierarchy */
>   	if (ancestor->parent) {
> @@ -845,9 +845,12 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
>   			return r;
>   	}
>   
> +	if (!drm_dev_enter(&adev->ddev, &idx))
> +		return -ENODEV;
> +
>   	r = vm->update_funcs->map_table(vmbo);
>   	if (r)
> -		return r;
> +		goto exit;
>   
>   	memset(&params, 0, sizeof(params));
>   	params.adev = adev;
> @@ -856,7 +859,7 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
>   
>   	r = vm->update_funcs->prepare(&params, NULL, AMDGPU_SYNC_EXPLICIT);
>   	if (r)
> -		return r;
> +		goto exit;
>   
>   	addr = 0;
>   	if (ats_entries) {
> @@ -872,7 +875,7 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
>   		r = vm->update_funcs->update(&params, vmbo, addr, 0, ats_entries,
>   					     value, flags);
>   		if (r)
> -			return r;
> +			goto exit;
>   
>   		addr += ats_entries * 8;
>   	}
> @@ -895,10 +898,13 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
>   		r = vm->update_funcs->update(&params, vmbo, addr, 0, entries,
>   					     value, flags);
>   		if (r)
> -			return r;
> +			goto exit;
>   	}
>   
> -	return vm->update_funcs->commit(&params, NULL);
> +	r = vm->update_funcs->commit(&params, NULL);
> +exit:
> +	drm_dev_exit(idx);
> +	return r;
>   }
>   
>   /**
> @@ -1384,11 +1390,14 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   			  struct amdgpu_vm *vm, bool immediate)
>   {
>   	struct amdgpu_vm_update_params params;
> -	int r;
> +	int r, idx;
>   
>   	if (list_empty(&vm->relocated))
>   		return 0;
>   
> +	if (!drm_dev_enter(&adev->ddev, &idx))
> +		return -ENODEV;
> +
>   	memset(&params, 0, sizeof(params));
>   	params.adev = adev;
>   	params.vm = vm;
> @@ -1396,7 +1405,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   
>   	r = vm->update_funcs->prepare(&params, NULL, AMDGPU_SYNC_EXPLICIT);
>   	if (r)
> -		return r;
> +		goto exit;
>   
>   	while (!list_empty(&vm->relocated)) {
>   		struct amdgpu_vm_bo_base *entry;
> @@ -1414,10 +1423,13 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   	r = vm->update_funcs->commit(&params, &vm->last_update);
>   	if (r)
>   		goto error;
> +	drm_dev_exit(idx);
>   	return 0;
>   
>   error:
>   	amdgpu_vm_invalidate_pds(adev, vm);
> +exit:
> +	drm_dev_exit(idx);
>   	return r;
>   }
>   
