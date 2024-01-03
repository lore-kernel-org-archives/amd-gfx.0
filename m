Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A674C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 18:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EC2610E327;
	Wed,  3 Jan 2024 18:59:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E129E10E327
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 18:59:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3YibtsJcKZ0YjVnipNuwdEMeNfqulVuqvPvG/6ozkVZZsIK+Qg1wXeQQ6Q4CLYVgB74ClFW0qxcgjhyq9AT70fl8zUrtNJpAp14kGoIBpRKYCoctZ6VOTCwxZfwy8DW9Rbe21W2BZvV5KHTpusDlZK2lP4fY+oZ76MPqreP2Ynyg0Q5OfFNY6tQiIECLgDxq2dIqUyhki6+7WYXEsC6ONxny+0Kf8yP/lGC3HQyMa9J8VOa8EW7SNO0iKeehofccymaSrKKUn+h+zk3aV4znXOOK+BQiUus6hIvYk9ZMPMt47cBAIvtUxq/fm/ZhYFQ4M2CS1Qk6XJYiHAx4BEn6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFSB+phOtHIhiY2w7rixVWmJB4p/Lb9XpujYSVuuAnw=;
 b=j3iEErAVHEbXo1qMo6CgqHCl9vFHDPnQDswhfXEb98LejO5A37WULPhjM9bWChnd00bRZibjJhcX7logPN9wXJqaWEfsJG3j9UmibHX8Fvx/5R/M5Jos8ittZYStqtZuaYanp1u7gI7HwD+TNgI4JO6a6A8bTDhH5TqR6AluNqkrULntsKzq7F3fO1Rt/uI825rBl35TcKWZsLS5d9v/kEzvOYcMxd3OJtn/M4rueFuSvtZ4F+TxxATlw1gifJ+EB0YVPl1XnsRTmxH70lMgZZAmLSlH0Z4rWa9/9EKLON0EQ0Ci1wTIxlTVHCEiVAwqKUaamQOX6CyI5NBS2tbSzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFSB+phOtHIhiY2w7rixVWmJB4p/Lb9XpujYSVuuAnw=;
 b=sXb2Utt/rMh/X0J/vbi5nPwJhSNzDJH6db54iK5xeE6hhoAI5eb3hCvCR2YsJHPcB/cW8C2i8Wi/v3QiB8kG8+dWmr39BHs9htaq+zK3qbGjE0Cr72pcR/i+Brq53M2IOMNGX262Sn8n2gct0KVagN0O8Wt37Bh7+yF7ktl49Wk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB6368.namprd12.prod.outlook.com (2603:10b6:208:3d2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.27; Wed, 3 Jan
 2024 18:59:34 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 18:59:34 +0000
Message-ID: <5213325f-f68f-4f9f-9fb8-4e58405a13ca@amd.com>
Date: Wed, 3 Jan 2024 13:59:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix lock dependency warning with srcu
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240103155628.11347-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240103155628.11347-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXP288CA0033.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::30) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN0PR12MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b00c700-2a99-417f-b8bf-08dc0c8e1fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2MRgV8DZaVBHlb/mxSPV5aRG/DgK2x7IxqNE1AmJ6IBF2IbTI9ME5BARhcedz2TBH2Yd5SpsF7hr2oMKWODx9fql1J/fA6R0QMHd+YNB9wOBt3P6ikGWS0QJ8f12K6np39jMSr+UlZojoO5CEgq4TdTN8dvfjjPsI9M0pa7NYVUiXpxiShFyq6sJZXc0NoN1ugnaFmVNruec6BrGxlGOmm9ntRRdUry9PoI/tAXXUzvB2GA5OSgWBAvcQvwB6bqpRzUyHqvGrS6U3EtPPIYe4hFsp8x9t7O/pf5co2pvegp1+h9h5mI5EVf5gOOz/y8ziChXs74PmsJvknxq5odFjV7eCu+PvNBKqM2E/9jxcBz2yEtE5z1wo7p24RRIrvpsMkI+smLDwjYx3rDvCc9Qu+83QCqu2pBfAEmd4ceOTWgxhHcCHgXsdbkRvYVC8bzcqeI0qvCiSFG7huFfUmNkHuAplvBBoryPDwp7S+mtHAu9w478Exvzokgy89CaL0vqsJs0081J/whYAT58qVaSwmTwY7HKT/qjzgafdeDtjRGPrzQgx/BpE+S0e96B4ZwCUUYc5UosCcHM+1xSpOGG6O4tq57BhFZMYMBMaj8CHo1LQzu5vOzEzmEluThJ6QCjRSH2OV9ZZ3FfiIe8Kjyq/VIQOV/+XTmcbleOnJcXh1B4bM+VSiHetyxjrJJh9oTT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(230273577357003)(230173577357003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6512007)(26005)(2616005)(6506007)(53546011)(36916002)(5660300002)(8936002)(41300700001)(44832011)(2906002)(83380400001)(6486002)(478600001)(66476007)(66556008)(66946007)(316002)(8676002)(86362001)(31696002)(38100700002)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnpIMy9NQnJ6U1NhTXdkaHQ0bnV0dzU1aDZCU2VQbmsxa29kVjdkUWtOZnZm?=
 =?utf-8?B?bnVkWW5pNjhZLzBIekw2c3hicGJudUZTcXFPYmh3RysrUEpjRTh0cWlsNmhH?=
 =?utf-8?B?eUVmZmJCZ1dHMmVFaE0yT2JRU3IrWEI0VWFEN2VCdElQQnc1YklKdHIrd3NN?=
 =?utf-8?B?bTdGUis3cWtoNzhJYVloRUNuQUFKNjRsZk13M3h5dmZaY09zZXZpOTNqZDRO?=
 =?utf-8?B?L29STlpEckVWK2QvcUdNUXZMUkdFZUVJUzdlTWd4UFJaZWc0TjJaR1ZqWG1y?=
 =?utf-8?B?U3JxQnFJRHUrREN2SzJ4QXNEZHA0cWwwUWkzZk05UWM4dGdFQitQYTBaS0J5?=
 =?utf-8?B?bmxod2djbFNiNzhkallWUDh2YXB2MmQ2K1NJY2NocHROUG1SRDlFaXdIL2l4?=
 =?utf-8?B?M1ZhaldOWDNLWXpmNExtZnVyZnh2T3pPc2ZXYkRjSGR3ZC96d3NKbENCdXBx?=
 =?utf-8?B?dDNVWEZhNUt4ZjdMdTV0MHFBdlhGUXhCTEVMNHFoeko0QVNUb2ZQQXQ0VEtR?=
 =?utf-8?B?UzErK255T2NWTDFUNDRwbHRoU1g1NVFzYW05dHA0RWl1eVZodlB0aGJiRmFo?=
 =?utf-8?B?NTM1aTBySDBMTWlRTDEzSS8xbEVsbGNGZk54V3hWbFB1ay9iRFViaG9LWEg5?=
 =?utf-8?B?MUxhSVQ2NGluaFJzYjFlVW5LeFNZZk9oZXpCZnlPNEdhR3ZYQTRVY2pZVGhj?=
 =?utf-8?B?S0JOV3pwOEoxUldERVFSMjNXS2FrNWJlVW12NjhxWWxvUmhXV0x1MDNQMkY4?=
 =?utf-8?B?WW5tc0JBeGZSOEgxbElUYitnUXg3M0xoWDNaKzlWSm9GWi8xMDM5SzhoTFBE?=
 =?utf-8?B?UmpRNGY3TUJWNDJBdDl3STYyNzBpWk9zTTAzQU9ZNEVTSzhKWUU1NTlHcFpi?=
 =?utf-8?B?U3ZhZ2VqOVpiUHZSc0lkd1cwTDQvekZ6WDBrT2E2cUVQOE1FeUhTa09IMUtR?=
 =?utf-8?B?RDZhOHh4NUExRVdUYm9oRDFVbmFvWFp2MXRuWGE1RHFiS2ZGREJHRTNtaXRy?=
 =?utf-8?B?UlR4QkJUVjVOQUJ1K2FxY1cxcWU0L3lHRGFmd21tYlNWS2pBdm5JOEhTb3JE?=
 =?utf-8?B?YTRSb21qQ2dxcEVPMmNFQURJb2NOWEZwQ0EzQmJlOGJwc1l2ZjhRMm5mK2ZN?=
 =?utf-8?B?a2o2OWV6RUp3VXVhTjhPUTFuaGYzams4SlEyc21GTTcyNytYUTJYV3h3QU5l?=
 =?utf-8?B?M2tlV2EvU1RmS2NWSDQxZVRxcXJtLzhRblIvcEtkKzRhbkNKek9oTjBYZ2cx?=
 =?utf-8?B?clVsMCtwT1VkR1VUK2o5N29xaDNXdnlMVXBUWEdsK09vUWlEa2djYVZEYjhM?=
 =?utf-8?B?ZVA5eVVZbnVmbWcxTGpWYlZFSUh0ZldPaWh0a0RUOXozV2NRZW1NYlBtSEZS?=
 =?utf-8?B?Q3ZCZzJDd0FFcXhLOHZSUEgrb2tWMThUb0ZSSzJ5czliSUtPUFQvQUErZS85?=
 =?utf-8?B?ajlzcFpUUnJ2Z3ZzM3VqL3BNeWVYK3pRM1BGT2JKNDNlWUZOTllZQVVYSzFi?=
 =?utf-8?B?VngycWcwTGJvQzVLSVdvUGZ2WTlTZG5vVkZsK0M1VDRTVFdiUjN4cG9GY25r?=
 =?utf-8?B?ajJPUldiMzRxZFZRdFpWeFAzdlQ5VTNuanRXWXJNNFRDWW02MmVMUnY1ZzE3?=
 =?utf-8?B?eVV0VllXMzZld1lxRFRQaWFXVkE1eTNjMUV5V3ROY1ByaTViUmFwSFRhTmFS?=
 =?utf-8?B?djk3eTgxT0ZjRjY4ZGQwOFI5VkFBWnFhUUFCN0E2bkxVdVJhclh2MnVaa1JV?=
 =?utf-8?B?YnFNUktrZnFPdzNBZmYrWW96RTN3QmR5bDR4R1YvZXl2SGpIM0YrY0cyUkpr?=
 =?utf-8?B?R1d6cFBTUzZYL2h5MkNYTXduMkJTRWNVYWV6UjFDNmljSUtUaVR1T2NuSmcw?=
 =?utf-8?B?L1hqcUR4bGpVdlE2a0czQXUvR0lwRjBpNU5uaWVvNTBTUUlBZHgyNWNHSDhH?=
 =?utf-8?B?Y292Z210ajdwTjFYN2VTdisvejBTTEhFVjlKc0cvYjJxc2QvYnlGZ0dwMnpv?=
 =?utf-8?B?L3FMNDI3b1JxTDNjSDFvTk5GcTY5aWNlTW5hbjJEaExsbjJKYXVQZTRaSnJY?=
 =?utf-8?B?SkdXR0pQUGl5UGFwQVQvdUtaSWFYM09PZzZjMmVYUVFJU0hvVmFTUVkwNjJU?=
 =?utf-8?Q?m1u/ixrm/WgviYuYQ4zWWcrvq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b00c700-2a99-417f-b8bf-08dc0c8e1fea
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 18:59:34.1475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOMa62gPKhAuQH8sVZnP6zDUCaF/K07xolK+HlLqwsI35g+U0boeTPZR53NaGasenMmKYjTWYgubuLyg/POz9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6368
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

On 2024-01-03 10:56, Philip Yang wrote:
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.5.0-kfd-yangp #2289 Not tainted
> ------------------------------------------------------
> kworker/0:2/996 is trying to acquire lock:
>          (srcu){.+.+}-{0:0}, at: __synchronize_srcu+0x5/0x1a0
>
> but task is already holding lock:
>          ((work_completion)(&svms->deferred_list_work)){+.+.}-{0:0}, at:
> 	process_one_work+0x211/0x560
>
> which lock already depends on the new lock.
>
> the existing dependency chain (in reverse order) is:
>
> -> #3 ((work_completion)(&svms->deferred_list_work)){+.+.}-{0:0}:
>          __flush_work+0x88/0x4f0
>          svm_range_list_lock_and_flush_work+0x3d/0x110 [amdgpu]
>          svm_range_set_attr+0xd6/0x14c0 [amdgpu]
>          kfd_ioctl+0x1d1/0x630 [amdgpu]
>          __x64_sys_ioctl+0x88/0xc0
>
> -> #2 (&info->lock#2){+.+.}-{3:3}:
>          __mutex_lock+0x99/0xc70
>          amdgpu_amdkfd_gpuvm_restore_process_bos+0x54/0x740 [amdgpu]
>          restore_process_helper+0x22/0x80 [amdgpu]
>          restore_process_worker+0x2d/0xa0 [amdgpu]
>          process_one_work+0x29b/0x560
>          worker_thread+0x3d/0x3d0
>
> -> #1 ((work_completion)(&(&process->restore_work)->work)){+.+.}-{0:0}:
>          __flush_work+0x88/0x4f0
>          __cancel_work_timer+0x12c/0x1c0
>          kfd_process_notifier_release_internal+0x37/0x1f0 [amdgpu]
>          __mmu_notifier_release+0xad/0x240
>          exit_mmap+0x6a/0x3a0
>          mmput+0x6a/0x120
>          do_exit+0x322/0xb90
>          do_group_exit+0x37/0xa0
>          __x64_sys_exit_group+0x18/0x20
>          do_syscall_64+0x38/0x80
>
> -> #0 (srcu){.+.+}-{0:0}:
>          __lock_acquire+0x1521/0x2510
>          lock_sync+0x5f/0x90
>          __synchronize_srcu+0x4f/0x1a0
>          __mmu_notifier_release+0x128/0x240
>          exit_mmap+0x6a/0x3a0
>          mmput+0x6a/0x120
>          svm_range_deferred_list_work+0x19f/0x350 [amdgpu]
>          process_one_work+0x29b/0x560
>          worker_thread+0x3d/0x3d0
>
> other info that might help us debug this:
> Chain exists of:
>    srcu --> &info->lock#2 --> (work_completion)(&svms->deferred_list_work)
>
> Possible unsafe locking scenario:
>
>          CPU0                    CPU1
>          ----                    ----
>          lock((work_completion)(&svms->deferred_list_work));
>                          lock(&info->lock#2);
> 			lock((work_completion)(&svms->deferred_list_work));
>          sync(srcu);
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 2ac0c7788dfc..6c0e6d654a26 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2340,8 +2340,10 @@ static void svm_range_deferred_list_work(struct work_struct *work)
>   		mutex_unlock(&svms->lock);
>   		mmap_write_unlock(mm);
>   
> -		/* Pairs with mmget in svm_range_add_list_work */
> -		mmput(mm);
> +		/* Pairs with mmget in svm_range_add_list_work. If dropping the
> +		 * last mm refcount, schedule release work to avoid circular locking
> +		 */
> +		mmput_async(mm);
>   
>   		spin_lock(&svms->deferred_list_lock);
>   	}
