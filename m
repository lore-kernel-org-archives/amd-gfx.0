Return-Path: <SRS0=hzS6=OF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AB5C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 03:02:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE26D6115B
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 03:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DE26D6115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6800E6E8AC;
	Wed, 15 Sep 2021 03:02:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E8A6E8AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Sep 2021 03:02:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkP/ZfUDNMFwPBn4gJVzAryAih7s3FsKYvZdSev8FC7Ph+HsewTrd51oDXD9EsHUKrQ8lH2rdul7oR7G1GLQI3WeZQVNiMZTUc0JUvpG1MqNBHVQyWGTH/bEZDwrrj4fzOY75kCInEKfXoy7Zva5w4xpYR0BEW3aJJvpVrIqjd7uh6xn3k9LttxUZNsoLat3NdpBbD9Hu4UPrOtVe26Ar3O2wMy7ur38diivhmT95FFM5UWw1qG9SzkB265Bp4HAU+kQDvGEOZyZjm49EdP3BuBHFVw25GXe65NgQSloec0c6pwIGpzBOie9H3qPPL8KRKqeBIa2rDr9Gs74haJP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=eZuo35kjzKo7IGwP6yObm0RXyUCerLFxr3I0yqH48JA=;
 b=eXypJ6IfvEzZ6/dYJEB4pCZfEQSROaK/ctS7VGHGBAk1gKj/XvBhszbjXx57tm9q/Dc30oYMb0KdY/ySPHrd5fsozfqIM4HrYruU9qk77NOYoWoT47Ei4zurzIhOYclGSRVydddaMFqpCZd50rRgoPoOBWzOU201yr3PYrNSD0YPHf7eKPm4hfjEEbBupJ/uMje2IZSO0WscO075OGL8l9dRy255Mxt+GjNdnu9ZzsZAsr1rD7mDUyk/b6BBSklMlNidZoN3tYVGEnvHLq+Sl/XutCq5Vojb7Z2pImkwCi6MZU+hRbqc8hrv4oMAGhHmVYz4uLwrP0AuYcZhftGPDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZuo35kjzKo7IGwP6yObm0RXyUCerLFxr3I0yqH48JA=;
 b=obrfwjcwMcvHHiQoRf+4bqwLExbqhCLkRYKgw+KQOwaHfUdnVZGTP4kGJ5s8jtSQ6OjUmFMSTWQeEoJQoQthEdwoXKqmmsvolyeGuChnacxwbRGpxa/gedORGAP0sIxIzbW7DurB+b9h/elVl7IfXO02ygs+/wUMNdS5Bw0HzMM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN1PR12MB2349.namprd12.prod.outlook.com (2603:10b6:802:2a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Wed, 15 Sep
 2021 03:02:54 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::c4ac:2505:5bd8:295d]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::c4ac:2505:5bd8:295d%6]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 03:02:54 +0000
Subject: Re: [PATCH] drm/amdgpu: Put drm_dev_enter/exit outside hot codepath
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
References: <20210915014256.20404-1-xinhui.pan@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <e70ea465-93c1-842c-69b4-88f9d0aa5217@amd.com>
Date: Tue, 14 Sep 2021 23:02:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210915014256.20404-1-xinhui.pan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT2PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::10) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:b478:f3df:a528:4eef]
 (2607:fea8:3edf:49b0:b478:f3df:a528:4eef) by
 YT2PR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 03:02:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6313ca71-c6d5-43d0-1958-08d977f54fa6
X-MS-TrafficTypeDiagnostic: SN1PR12MB2349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2349CF05DBF7A7ACA273FD6EEADB9@SN1PR12MB2349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yO1ZT3Ly0XbSLDJt6KQtwP/ng2loVb2hwqie+2l0DoTrAUQ3aRLvOSz9dM68uRNBWnrpNlWKh3fF+RYzRQTExsSkb8DwdCL3HtW+JV1S8bVxLscQWyfbE33UwDibk403nFDLCsRJc6m94trITmFQEAhUuPHO0p9StrjPVzBKf1kSmH1Bq5tG4jLs8CCzjRufIOawM6XGdiUwmZzyjREZvmyEIrfJT54dv/6pLw4QHb8oWhHkCiCDcOhTy9vx24CoPKXe6wDlwTzx9lFWhkQ00fHw8twpoxk9LsC/rNKrvERj9TU19FUzTqvOb3soTlUobBkZKMh6j1ZBHVNf32y4eeFF3zSzL/z/0hVewC9mWE71sPFcMX0Yv46zBxAkeV3ZTDMgP/6Cu7thZ4bsoCl8YkuvUEyE6TJ/dnkKSD8ErGQxLXtpA3rtgETrMqxjrMhj6buarcz3daIS5Pm4cGzFS6ay2FQQAZFbX5kBWIAV8/gzrbJH8+3yOOa06fU5/I3tpsyD2/7H1eU/L18qC5Uk6PvuTB+AVZi4NDp1W6f2YYzaBpLSk0GSwyDYfNahIVpt4atq/05+kAE9X66twm0KRd61F2HhuHzLE200NbebkVVpzFMOFsLw/zubNGY6CcCXq2Su5dw9tj1Ke1Jp+P6id1RznRVhdxwPUurCn8h9Xv6ylnjJEqU6EBp15Y/3qfx4Ts+D6OomVLz68LTR9/l6yWogZqXE9jmN6uxvrfvdTDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(31696002)(44832011)(2906002)(186003)(8676002)(316002)(2616005)(6486002)(4326008)(5660300002)(8936002)(38100700002)(83380400001)(966005)(86362001)(478600001)(66946007)(31686004)(66556008)(66476007)(36756003)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW4wZTZhK0c2ZVJLU3djeGZKNUNhVkdnUDM5SWJHNytDR1JRejMwaGdPZVhL?=
 =?utf-8?B?bjZINENRTGhiTmgyNVVuQktzS25MbUVBUTZ0ZzQ3ZFpkQmozeDlJZFYxdGd2?=
 =?utf-8?B?RmVHSWVKbkdmUW4yamNkTWZoMS9kbC92UG9NeXRFZGJObGdhVzdocTAvNUJk?=
 =?utf-8?B?NFMvd3c3R2hlNHRKalpWdkRZd3RtL1BvNi8zdU9oNGRhdUNxMWZQazIzWlQ2?=
 =?utf-8?B?Y1VLYlFYVXpxbnEzZXRYeG5FTksxZE13RE5rcUppeFNlMFQrQmhobHRGaXdY?=
 =?utf-8?B?QkhMUVV0L25KdVhKMGFudS84RFBKRC96ZW1qNzBrWTV6cVZWeHJ0TDBkVURr?=
 =?utf-8?B?Y1E5eEc2VjdlRXBmV0FWNGNRZHlVK0FnRjFqQkZKT08yQ1pnRkZzaTF2VnJv?=
 =?utf-8?B?c0FabUl5L2ZVRHd3V1JhOFQrb2owK2wxS1QzN2ltTGk4TkZqeEtNOVBibHg5?=
 =?utf-8?B?WGYwaDRNc1ltcVp5bGwrT2dBbUR2ZDZiRWhnbXo5d3RYZ3lLbk1QSHlkaVFD?=
 =?utf-8?B?dFlrT1ZmUSt1RmVMQjBsWmNsa25RdWluMjVUWE05aWk4alVSY0ZNTlJyMlVx?=
 =?utf-8?B?RGRrQ1Q0RUlDQkcvcDFZRHN6azBlOFpCbjRxVWF5NFpvcmFaMkNNckh2YkRj?=
 =?utf-8?B?SE5heDBwNVBOMTFQdVFtVjJxNUFXTDNFL2s2ZkhYTmllR0hHNCt4WmpxYkUv?=
 =?utf-8?B?RHEyWTRXRFdZcXZMQm1qamhLZFNKSzFwNmJvR3g4SWJpU295dWtJNW1PaGFM?=
 =?utf-8?B?RzFmTzJsNEdmd1k5SzdQK1FhRmhIOVZLZ2dueGlWWmZQVncrYVFURGxQK2hW?=
 =?utf-8?B?amZYUHZCZDFSRVhKdkJDWlJrT082NCtPSlZqTUJ6ZC8yYWkzOVpkRWl6a1ZD?=
 =?utf-8?B?N29QUXUrTjQ5UHlkSVVFckk4ZS9jcjRFc3p1eG40N050RmVPMEZJYUlVd0tM?=
 =?utf-8?B?T1Q0cytvbEZrOTlzUVl1cFZZVERUTVhjNHNoT1pCd0ViWUNMNDRaV2p6MnpZ?=
 =?utf-8?B?TmN5NzhuZTd1Z3BuMk95bmh2OFRQcmdPbTdwMTE0aXdLNVRBdWFpOWJWeWdo?=
 =?utf-8?B?WFhaeGI2blhPOE9mSU1ZeHQxS2R0ZTdZd2dqUzVvYi9EYWRZbXNvZHRjeWJ0?=
 =?utf-8?B?dTBZR0J3Mkg3S0NMQlNhRHBaRER6NFA5UGtidXROcDJqUE1HRmgxVDl3UGZJ?=
 =?utf-8?B?YlVSejRwMHVER2ZjTkYxbXFlUkxGemxWY0JKMkVucFJEdCtTaTJleXJjdnlj?=
 =?utf-8?B?bXFqRERGazhOUG80dzRKUk4ydGl1QnZDOUhWMllEYW81WWtFL01qb1RjdXNX?=
 =?utf-8?B?QjhOMWtVRDBsbFZHZFdXYWt2NzlMVnNOM0h4ZExPQTFKOERDWWVIVDZyaDg0?=
 =?utf-8?B?ZDNrWXdORGNhNzV5aGxHMDQxY2gyMTJ0d0hzaWE0MzhLNjVuSDhCbkdEMEx2?=
 =?utf-8?B?bTN3QlMzbHFSZDNSWkwvaGR1dkdGTEIwTU9DL05aSHRPOTdKL2g1eld4TnBM?=
 =?utf-8?B?UmtkR2s3OGtPY0x5ZXR5QjZ3MVdmV3o5Tkg0SU1zeVZKNGFUTDhMVDA0VnRz?=
 =?utf-8?B?dFZPLzg3dm5sTi9Yei8yblVHa0xENUJOQzU4TUFOcS82MzZxVmkrNFF4YUlP?=
 =?utf-8?B?Nm1tN2k0R3NvTzVVQmdSN1JZTHBIV0VzTXlUUHcraWdjaFdiTXpUTFVNQk1o?=
 =?utf-8?B?bityTXBzb01ablJNdTdraVp3Rlo0emJ4aFhmQVdBcHUxUnZRNmc3d2grMVF2?=
 =?utf-8?B?d0w3MEc2clZkbksrVGxiRVVjTWtNUzl1empXeFpNeElVdmt1ODNvU01FTmc4?=
 =?utf-8?B?Q0dnMjFiTUlwdTlnNlViY2hWTXR2aml4b2NoRjRMdWV3ekh4R0thN2J2MS9l?=
 =?utf-8?Q?eQbv6hNv/0EYg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6313ca71-c6d5-43d0-1958-08d977f54fa6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 03:02:53.8533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTpiOmRpBYlS8vfWmZbblXf6Aa+ILykZhrzi/JzVAuYwhrZ4ZvZ1GgNK4bWKbZTQsF3VUzXmwGh3WsnpV03bMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2349
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


On 2021-09-14 9:42 p.m., xinhui pan wrote:
> We hit soft hang while doing memory pressure test on one numa system.
> After a qucik look, this is because kfd invalid/valid userptr memory
> frequently with process_info lock hold.
>
> perf top says below,
> 75.81%  [kernel]       [k] __srcu_read_unlock


Do you have any idea why most of CPU cycles would be spent in SRCU 
unlock ? It's
not waiting on anything within this function and does some simple 
arithmetic inside
as far as I see.

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


Not clear from explanation here how the soft hang with process_info lock 
being hold
is related to to SRCU lock of drm_dev_enter/exit.


> They are gart_unbind, gart_map, vm_cpu_update(already hold in its
> caller)


Where in the caller ?


> and gmc_init_pdb0(no need)


Why no need ? Those guards protect from accessing MMIO ranges after
device is hot removed and hence they don't belong to him anymore. The
function above is also called during device resume from S3 and it's possible
to hot unplug device during S3 so this might be called with extracted device

Is it possible to run libdrm amdgpu test hot plug test suite on this 
change (before and after)
to verify if this actually breaks hot unplug ? The suite is committed 
into latest libdrm but disabled
until latest fixes from amd-staging-drm-next reach upstream drm-next. So 
to enable it this
code 
https://gitlab.freedesktop.org/mesa/drm/-/blob/main/tests/amdgpu/hotunplug_tests.c#L65
needs to be commented out.

Andrey


>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 11 +++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  7 -------
>   2 files changed, 11 insertions(+), 7 deletions(-)
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
> index 54f059501a33..e973488250e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -31,7 +31,6 @@
>   #include "amdgpu_ras.h"
>   #include "amdgpu_xgmi.h"
>   
> -#include <drm/drm_drv.h>
>   
>   /**
>    * amdgpu_gmc_pdb0_alloc - allocate vram for pdb0
> @@ -153,10 +152,6 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
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
> @@ -165,8 +160,6 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
>   	value |= flags;
>   	writeq(value, ptr + (gpu_page_idx * 8));
>   
> -	drm_dev_exit(idx);
> -
>   	return 0;
>   }
>   
