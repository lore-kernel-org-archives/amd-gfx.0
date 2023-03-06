Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9788BC61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 23:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B28510E012;
	Mon,  6 Mar 2023 23:46:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5237510E012
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 23:46:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUn7FtveyhrIGd/lQcbb9qzWYkiuuT++Xsi/yURzPFy1Jn+CFJe91eo1algxYoyscJAOHtmMGiuqjE7ELXib47yA76GiTXiCav2MO+yH18B2HSB30vr1CYVHlB1DxpA6P7ZwZygjyYQE8QgLhBhvKeF5xxhJ1sjoNYUjXYIoorC0ptdGWLXbMRHISzfKrz2dK/yFPp180RYgM1gztBXRB+bfRVHhnK/xoHVlUL2j+rZErZhtORN2q258P14teKvDlRw7uhVzhlC2S8IK32xPEnJCdatNIa0JEFOzYWOg7kh9s69R40DAiJ7qyIA1PO921LJ0FgoLAKDXh1u3+RCe0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7aT2Zei+3K9f0Qe95bHTZBHKJfnpxPBimvzEk/PAxY=;
 b=AwcXvvDku3FYgxvosDticKPnl3gzjLWaC/S4o/AhO6dgpdZZfJNnHw6eDD1/jUKb1EvBqTHHCS27Rn/SfiAm7+DsFlKzCStfJ17ZKT+bdltf+rREMueN7NeDwkYa7sNdtJUnfn/0g691zFq8RM6F3OFGhEPaV+aj1sYtFG1HJpJDa2pXfrR5OVrdfYVo+utwes10IotWoSAMSh/hGgBu2C4WyVfwfsB4r8Eh/f1lY2TBdP8ymf6QoMh10J69n37rrrFhdhaKJHhrVwJoTtmAzezunBDIvw6IiimwxJ9Lu7uwrEDcqZHDH2wQEeTFPA27hthPJ0LqByWM3C+4if355w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7aT2Zei+3K9f0Qe95bHTZBHKJfnpxPBimvzEk/PAxY=;
 b=nJg6dXcq6T8AoD+RMTzsu5hJJn8T5Sj7WZ53buL3oElGY21ZHvLzRidtLKAsfoPLuhv6qfy9qKnJwk6kjgXryIXaGYmlRuI/43axaXzcjprfiY9eaa7EUiY6quaTt4qxs0YL7Um5+7QJtt7ICiy9ai9Xtlqi5kj+tyxCydR0ruw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB6948.namprd12.prod.outlook.com (2603:10b6:806:24f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Mon, 6 Mar
 2023 23:46:00 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e%4]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 23:46:00 +0000
Message-ID: <52720ba5-09be-fafa-efee-33a230aeae07@amd.com>
Date: Mon, 6 Mar 2023 18:45:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amdkfd: Fixed kfd_process cleanup on module exit.
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org, "Belanger, David" <David.Belanger@amd.com>
References: <20230306215808.2903387-1-david.belanger@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230306215808.2903387-1-david.belanger@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA1PR12MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 2895a960-c59d-4073-ca74-08db1e9cf091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1XkZHUaCRx8wINNiliyPK94Kl5rFRAdAXUuLo2uawbptU3WBPC2ZEcUKmf+7ReflYjyBzQ9neZfZLMNoetRbLbjnMVPWj1yJIWDCFkbyzsnW9q7bEqCcTCeFOaysClPJL7vJxFs8wxIJPC0cKb69LVx88KhxiFW/92+qnR4A6EfhbW0F4F1eyldwdp8shiHzeMoTU4dfEqqJkfbPXmfNuDANiARUorMeNcmxfyUMxgKYNo+4tte45WRnDIkqQx6L8Cw4MYAL5Gmr4kKQm9FTL2jLRAKeEMWeg+uIcriwkLOCu2jLzGdcn1Ow2Hn0FQLHUtmv8/69gsYINicQoiZygjSTHQk6gWyCrKbsY3CMh6CiUt6fmsl5Tv2sXooeqDMoiseruPuVYfEnyloerol9MTK0FNMtAKlI/G/Eil55RSqj+8Zrcc93HC7sfU9Ypq62tuvQ+Edw4/f+2dbcOSrdVMi1hWpqunD7LJvhJEtIpUQYw0DkIcujizWiDKSZy1YJjGgnE1GKks5yU6A2kGRG44hU72Xt+pjd9Ft7l9qVTw5RxbRKNKL5CKY6VwCLO3r+hXGnHnSrUXjNS076vkSvaEgJOiNQOHR4/90bLDejelto3sX8Z7b5sQN5J7c6BgB6MrV8rbQt/3QyhPAHkTM05R1l+7lOXhaNZW+FaqhoPzLcF0x0N6paVFFmhMQ1ZipmLZIYqKRHgppflWAAa3Imnf79/soyTa7E3qxHkC0YBW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199018)(41300700001)(2616005)(83380400001)(6506007)(6512007)(26005)(186003)(38100700002)(6636002)(316002)(37006003)(478600001)(8676002)(36756003)(66476007)(66556008)(66946007)(31696002)(86362001)(6486002)(6666004)(2906002)(44832011)(31686004)(5660300002)(8936002)(6862004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWk1YTBqL1gwenllamprbklQdVlLS1VoMGhnVFVyckFsRytRRHU0eE5Zb3RL?=
 =?utf-8?B?QTMrQ2drbFBKeGpxdkdueGlOdmlrbFl6NFNCaE9SMHVjRzlSZFBiQkdFODNT?=
 =?utf-8?B?aDV6b3BzYTlPNXFBRUZRaDdvQUZ0d0JYUk04bkFibm1xUzBIT0tiNWtWc1p4?=
 =?utf-8?B?OTFmNWlHMHRQcmpQMDV3VythTTFHdzJmNGlIVkZOdWhpOWtyQTh5RG04bzY2?=
 =?utf-8?B?NUhoSUZVTWtlQ3BUdnBZNG93NUl1dlhvaDFEV1MyVmxNZTJFYWJxbjhPcVhx?=
 =?utf-8?B?VE9wd05JNG9lQXNuZFFsYnZCWkFvb1N5S0lWZyt4OWM2NGRMYjR5UERNRkQr?=
 =?utf-8?B?MXVuclpNai9BZjVMemhFOHJkaWRGL0g3ZTFORWprS1FZWXIxQytEdVdzRk5x?=
 =?utf-8?B?OXhmazdHanp1dUtVL0pOU3pPYnlFK3dLSVhaNS9hR0pLQThxbWFUZ3pROFcy?=
 =?utf-8?B?R0Q5WlgrMTgwK1gydW1JZWVOaVF1WUJiaVB5Wms2ZWFrY2ptRUFaMlQ0NmxH?=
 =?utf-8?B?WWdCcW5OSitjK2dlbEVpYnpyOGw1NmVVZ3FSdSsySEhYSzZodlJkSU9iNzJi?=
 =?utf-8?B?NVJ3YWNrS2J0cTAvS29qVnd2NTVzZjJxMmtrYytDZUxmczdVeVNqc0hrL0ow?=
 =?utf-8?B?Qnp2a1JRbGI0VVBNTFVKWDFGQk9ob1Q3eUlqL2Q0TlQvZkFteDJkaDA1YzVT?=
 =?utf-8?B?N3VFbzdtWnRBRDVEZlpkS3FlRktCZWR4dlIyQ09KYmRZTnpLblhsM3BwSmJZ?=
 =?utf-8?B?dGk4K3I5NzZMdU9CdkIvejdBSUxOQzBLMldhSG1XYStLTDg1STg0endMcllZ?=
 =?utf-8?B?ci8vTGZZRUkxdGs2N3VINmxscjlqWG4vaFh2dmIzeWJrbjRRUkxERVNhUE4z?=
 =?utf-8?B?d3AyUUtiVWxPNGpIaGVNUXIvaDFncVhFS09hMi9WQlpIVW1INTRkNWZOYzRj?=
 =?utf-8?B?T2ZSclZEZkh1cGlHMUlyV04vaUJWc2xMN25nb0NDcEdxYzI0R2JubWVJS0tS?=
 =?utf-8?B?VjFnN243dm81K25LbXZkbWp0cWxYZUJ6bU1TMDJvTzl5TlczSVp0d0QxMnJo?=
 =?utf-8?B?YVVURGhTcDF0Qzh2eWxoRUxiNVFPZjErRlhPQy9sMlZyaHFoRjdoNVV6SVNO?=
 =?utf-8?B?YTZqU0pZT0ZxbWdYYWI3UEx3R0p0YTZ5d096Y2N4MEIxNFNucUE5S3lPR0x1?=
 =?utf-8?B?WjRpNStwMlo3TlI1OHpIVjBZbzlqc004VzRDaGhraEtrbjlWTWZOcjVDT2hq?=
 =?utf-8?B?Y21GbEc0VWVpODIzd1hEOVprSUpHc0xMWFlFNUV0YWp0bkhlVURydXBwRGpZ?=
 =?utf-8?B?SWxyeXNOaUhPdUpEbS8xL0RkRVV6d1pIOUlTYTk1dEd1YU0va0RBdlk3a3Qy?=
 =?utf-8?B?OTlVMFlPMFM0UEhXQ0l6NGQ3dTNjSy9VR1N3VVBHWHJCam5YVEhjRC9uaExs?=
 =?utf-8?B?MjV3ZTZxWFJCNzVnUzdVcXJOOFdYZ3U5QjRaL1BxWDRveHh3VVV5cjBJMmF6?=
 =?utf-8?B?VlpodTNHdFE3OEU1WW1MczJwODhkWVdTRzlwTHpnTDNDU29sZ1o5SWRTb1U0?=
 =?utf-8?B?Nkc2SjkrMTJFUkZybFc0YlhnWDJMZXZBbXozRmhCTHBrVEFpYkt5S1VCaUxY?=
 =?utf-8?B?U3dhcjUyYkhOQm1NMjEzMFVubWc2bnU5UVYyL2xTU0FXUldJTVE2Z1V0ZDhT?=
 =?utf-8?B?MjNDSlR2RUdKVGZUcG11K1pGVldmQ0t1dEd0ajA5Z2ozazQzOFNyNnh1bVcv?=
 =?utf-8?B?YjdkYmZmZFRabkhlL1dBY25zUTl0dHZlS2lhK1MzRkRQd25KRWpRSDh3MHRE?=
 =?utf-8?B?V09ZaktzUVhyeE9LcmhWbTQ5a0tTSWVuMktJN3Z4cURKQ3pDNEEzK1JrQzBP?=
 =?utf-8?B?K2cxaU16UWtkL3M3c2c3UThWZnRrVXRDOGp0ejgrY1VsMGd2eStua0VrOXJ0?=
 =?utf-8?B?bkhWS3dmWkVNY042N2FhL3JZRXJlZ2FORThYV0V0TVpqSXUxVUJlVjhHTEJs?=
 =?utf-8?B?MkJCaHJqVCt5dEdwc2lWZWtSU2JJcENONnZKNTB3aUpYdDF0VEhkekNxdGZZ?=
 =?utf-8?B?NmZwdVZtTm1JaFpRclBsTWtMKzMzT3N1RGlEN1krbzNrZzhNME5hN3J3YU1W?=
 =?utf-8?Q?p03MAfxgiBm0hefKhM8h4T6f8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2895a960-c59d-4073-ca74-08db1e9cf091
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 23:46:00.3968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lIaqaF6WBVHd0oVVHxmRcR2D8pqN0x2Hvj4zL64sPCflIDg636h6Ra662q11YZnFmEEA+GmWtzkvjoLhB0KA2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6948
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


Am 2023-03-06 um 16:58 schrieb David Belanger:
> Handle case when module is unloaded (kfd_exit) before a process space
> (mm_struct) is released.
>
> Signed-off-by: David Belanger <david.belanger@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_module.c  |  4 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 57 ++++++++++++++++++++++++
>   2 files changed, 61 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
> index 09b966dc3768..8ef4bd9e4f7d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
> @@ -26,6 +26,9 @@
>   #include "kfd_priv.h"
>   #include "amdgpu_amdkfd.h"
>   
> +void kfd_cleanup_processes(void);
> +
> +
>   static int kfd_init(void)
>   {
>   	int err;
> @@ -77,6 +80,7 @@ static int kfd_init(void)
>   
>   static void kfd_exit(void)
>   {
> +	kfd_cleanup_processes();
>   	kfd_debugfs_fini();
>   	kfd_process_destroy_wq();
>   	kfd_procfs_shutdown();
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index ebabe92f7edb..b5b28a32639d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1181,6 +1181,17 @@ static void kfd_process_notifier_release(struct mmu_notifier *mn,
>   		return;
>   
>   	mutex_lock(&kfd_processes_mutex);
> +	/*
> +	 * Do early return if p is not in the table.
> +	 *
> +	 * This could potentially happen if this function is called concurrently
> +	 * by mmu_notifier and by kfd_cleanup_pocesses.
> +	 *
> +	 */
> +	if (!hash_hashed(&p->kfd_processes)) {
> +		mutex_unlock(&kfd_processes_mutex);
> +		return;
> +	}
>   	hash_del_rcu(&p->kfd_processes);
>   	mutex_unlock(&kfd_processes_mutex);
>   	synchronize_srcu(&kfd_processes_srcu);
> @@ -1200,6 +1211,52 @@ static const struct mmu_notifier_ops kfd_process_mmu_notifier_ops = {
>   	.free_notifier = kfd_process_free_notifier,
>   };
>   
> +
> +void kfd_cleanup_processes(void)
> +{
> +	struct kfd_process *p;
> +	unsigned int temp;
> +
> +	/*
> +	 * Iterate over remaining processes in table, calling notifier release
> +	 * to free up notifier and process resources.
> +	 *
> +	 * This code handles the case when driver is unloaded before all mm_struct
> +	 * are released.
> +	 */
> +	int idx = srcu_read_lock(&kfd_processes_srcu);
> +
> +	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
> +		if (p) {
> +			/*
> +			 * Obtain a reference on p to avoid a late mmu_notifier release
> +			 * call triggering freeing the process.
> +			 */
> +
> +			kref_get(&p->ref);
> +
> +			srcu_read_unlock(&kfd_processes_srcu, idx);

I don't think it's valid to drop the lock in the middle of the loop. You 
need to hold the lock throughout the loop to protect the consistency of 
the data structure. I guess you're doing this because you got a deadlock 
from synchronize_srcu in kfd_process_notifier_release.


> +
> +			kfd_process_notifier_release(&p->mmu_notifier, p->mm);

This calls hash_del_rcu to remove the process from the hash table. To 
make this safe, you need to hold the kfd_processes_mutex.

Since this is outside the RCU read lock, the entry in the hlist can be 
freed, which can cause problems when the hash_for_each_rcu loop tries to 
find the next entry in the hlist.


> +
> +			kfd_unref_process(p);

This schedules a worker that can free the process at any time, which 
also frees the hlist_node p->kfd_processes that is still needed by 
hash_for_each_rcu to find the next entry. If you're unlucky, the worker 
will be scheduled before the next loop iteration, and you can get a 
kernel oops.

I suggest a safer strategy: Make a loop using hash_for_each_safe to move 
all the processes into a new hlist. You can do that while holding the 
kfd_processes_mutex, so you can safely remove all entries from the hash 
table and move them into your own private hlist.

Then you can safely release all the processes from your private hlist 
without having to hold either the srcu read lock or the mutex.

Regards,
   Felix


> +
> +			idx = srcu_read_lock(&kfd_processes_srcu);
> +		}
> +	}
> +	srcu_read_unlock(&kfd_processes_srcu, idx);
> +
> +	/*
> +	 * Must be called after all mmu_notifier_put are done and before
> +	 * kfd_process_wq is released.
> +	 *
> +	 * Ensures that all outstanding free_notifier gets called, triggering the release
> +	 * of the process.
> +	 */
> +	mmu_notifier_synchronize();
> +}
> +
> +
>   static int kfd_process_init_cwsr_apu(struct kfd_process *p, struct file *filep)
>   {
>   	unsigned long  offset;
