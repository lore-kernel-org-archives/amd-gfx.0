Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61082C636CC
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 20:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D742A10E5EC;
	Tue,  7 Feb 2023 20:48:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 033C610E5EC
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 20:48:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcHS9VnWcs+rMTMDND6gNJU0+n///6aFB6w1KHQqt8MbauYaFtRDFcJpm/+QTyZ5NA3zgM9gMjrMDCfuYf9KsByJWxrkNMgaX8jsadF4j1wOMsQdj1uY/rU2I5Ulc+Q6uSwLOz76sgIP8pDcnCqO8Z+Cd9Ot6fwmDNBPki23McEdRXUIPO1Sdu5pSnRZYqFpkXJXZxyGyEsUFQ4J4EaMLy1NvdiiztIWIJv0xwaUy7mnbOsh8bgjmG701Pq/RavNLMVxfjyyuJ2ysbYjS8hVnoPK7Jkvy7LygpCsI9jeoNZvp/T8CMnV+jhmc0tVZuB9BDiBIzwP7wf9Oj+2IZ2JBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdB1VXfj2vR8OhZCIjOid6BhguQ0S0TK8uDVS/pfb64=;
 b=FqcOU6z0kxZh+QeAQNETPiRa3lhf/vy59Uyar9ntU2mb1LSy59Rc4BLuH/PhRdYsaWrI4T/XYx1qQQB0gV6HROMZ007CkrpjlpWAGt1rvXprd8zkFqO1/mq0Qbb3HiM73nuVEIz9fXaFnMGVZ7lIWAaQSi/kwOOaT1Pz31EOHN2vML2GNqAJ7Z4W/JzGvEfNgw7fjeBBiybqNILrv7Smr7wG5Ol3dbVOES1lxrwv1P/lH4WqqyTdJSvqu6clX8rbAmy/BaapLV0QDBW45JviAHwWqWxelDHN2IMYM4okmfZnEFy3BF5Lh98UKn4xKKJcC8GNRHPlwof1lrGZcVNQuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdB1VXfj2vR8OhZCIjOid6BhguQ0S0TK8uDVS/pfb64=;
 b=uW/8iVevy+mCT8duXPlXr7IeQ6VqHx4X/7CYOLUh11K+aHNuTGsOL6JPZ30VeFWmQ+UgEVQRB0qLC5wkEd7/2v8FnvwcjkqcuqSiQQ/VTjWPlDzMP+clMQJOnWguG3XsCQSiE9KFeS8JRcFOxOGzpAQkVmb1NpdCg2qvBi8LGyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB7872.namprd12.prod.outlook.com (2603:10b6:510:27c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 20:48:02 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::e6ea:9231:6d39:93da]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::e6ea:9231:6d39:93da%5]) with mapi id 15.20.6064.036; Tue, 7 Feb 2023
 20:48:02 +0000
Message-ID: <3c62317d-7ef8-9f5d-4ca3-1b1bb9d56b14@amd.com>
Date: Tue, 7 Feb 2023 15:48:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amdkfd: Prevent user space using both svm and kfd api
 to register same user buffer
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230207203504.879056-1-xiaogang.chen@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230207203504.879056-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::7) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: b5e71695-a357-4e9d-5319-08db094c9aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kbn7Zv8aNvs8jsZbr5BAdjtMzn4NmGqgbaISjPMYkMZfFIT6F4n9poe/u6Xthdrimb8vqWg6nPR2m38h04GHozdIzXu0r9Y9b9lcUN8qki5kkBFXcyLIH6UbjGJx/HQeJdDPBLRYoxz36jtWXPxL3WAo59h3xQyyoIaM48Z45YK0MfHih0uscIAMShOwsTa+j79/X1GF1xotC6Hovgh/S9dOHlu49Vj2pL4vFNpdmjYaXVKmrM0Uli5HBAGQ/8Xkzf9ciTpe9B0LmRxD8EPXGNdh9eB+jkD9G41c2UiawgVf9ivTkOemDQbZvBnZCJRHwctnDUkNLj4ldbBZMvW8PjXlv9l5mAtEu9LcR4OlEk2HMp8J4iJHtwAyt2wVMGmwFhXfghFlYQLX7NBkXkvlnMPIDkggq+xF/zuHPhb1+s55+HbH3DOd/S2SfgJnh6PLvkf66M5SLExS1qi9ddoZ5zlEp6XdiZ3e24L3TI8HU/YPaWj5pBBFVJIBcjfdGBKjXg1GVcktCrdcyKeeDuVOtny1++a6r2NKSTX38N/gzYcaNHQC0Up6nP6m9Yd7Bg07UJJLBWf8tTC6DKe3m7NDvgisnfCp3Te1Rhbz8qLIJX6PQmib/xStaT62h4amCC/ztHaQVOosCXuejHR3F2TOQim5H83+DCjdybiqMK6yLA/kv1hW3tE65EV6r9iSA3KCFtl7wwKqtR7mu0OBak0srSTRKwTVj5UtbbkJIzY6Nu0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199018)(31686004)(36756003)(86362001)(38100700002)(26005)(2616005)(6486002)(186003)(6512007)(41300700001)(83380400001)(66946007)(478600001)(6506007)(8676002)(44832011)(31696002)(316002)(8936002)(5660300002)(2906002)(66556008)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVV4TnBoRmJaeDNVRzM3cVlFZkQzYnh3RmQraE1FYnYxayt2VXViVEU3WG9J?=
 =?utf-8?B?YmlGZTRFWSs2eDNXdXdpdFRNd0JjZ0NuU3FpQUNvZU9OZnNob2hXZ01kLy9Y?=
 =?utf-8?B?RWRXblk4ZlJlUjJkWGlFakY3ei9hWmJOclNhZGsrbTRzcXlmNVlBOHFMbzl3?=
 =?utf-8?B?ZzdKY0xHRDgxR2g4TG9mVmZLYzJaQUh3QWU5b0d4dlRhV0ZFT2VhNUMvMlBC?=
 =?utf-8?B?OEhhd2JsNGcxN3YyODlMUnQvY0pxV0poZVZTbjcvdnFuRDZHVkxodnpjb05E?=
 =?utf-8?B?QWZlYTcvQitZell1WW15V2lNdElmcmtmR3BWWWRvbkt1c1F1UllsNTI1Vitu?=
 =?utf-8?B?eHNxcWZmWHdLaFN6VFFmRUVKd05wdVlGOGRsbzNqTnJhejJhSVUyWWN3K2No?=
 =?utf-8?B?cFZQVE95VVg3eXlPSXV2alBTOTZidnhtVkJLaFZ3cldxNGNGSDFWRklOZU4x?=
 =?utf-8?B?MiswV3R0bHZKRWdmQ0I5QmpFTTNZc1lzSjR1L2xrT2xUdFN5WnZpNVVMQURV?=
 =?utf-8?B?U25hVFZ5YVA0bGlIdGlTMWFJZkRoZTR1WUZXODh6Nm1rTElMTmFjODFsbGky?=
 =?utf-8?B?ZHlON3BuaXk1dzI4YVp3NlpJTGpZeFhrZkx3U1V0d0VuWXhKbFFXVEZCQmxv?=
 =?utf-8?B?VVZmWFFKQ1Yzc3o1d2xIRC9neVQ4MG1UdGE0YUhwRDF6TVFzMmZiS2liZ3hZ?=
 =?utf-8?B?K2Z6bWhzVzFvQkZqcy9vTEN1QjJIL2syYVRDcUNvbWdCT0tjZGRud2s4bGVy?=
 =?utf-8?B?dWc4ZUNwUHBtTnNXR253b3VnUHQ1YmVoNWxpdFB2S3VzeEs1VjZYTmN6VE4y?=
 =?utf-8?B?V0lZME54cGxURlh6UWw5V3E3UHdPaWRNUlhFRytIdEVWMVUwaTRaa0U0cm4x?=
 =?utf-8?B?cGk0aFdyNFFuekVyakFLQ2lNVnIzM3NndC9acWhUM25tZUtlNnM4SnRrK3Ja?=
 =?utf-8?B?SVlSU2J0b2VOWGdMK2dyNEJkcjYxRG01RXA4OVduMVd5WVNWd1FoaS9kODBI?=
 =?utf-8?B?OVdaNTliQUZ3OGN6YzdmNG0rUWdVUUFucUFuZ3hXM3BZTzA3N1d1NHg0a3lI?=
 =?utf-8?B?dHE3MVRRRVA0aks0NmNBRGlGS0o2RDlKcmUyNWFQYUY4aVI0RDRiY3BDMVBx?=
 =?utf-8?B?aFA1ekhCUTdDVURPYXVWSkxHMnAzSzhVNDVOckYwNG5tVXo0OUE2UVhzMUZH?=
 =?utf-8?B?OVhWcGtSbmJBcVVTRlM2aXhLeE9QTkpKQzExaWduS1FQRCswMlZXazNMOFla?=
 =?utf-8?B?dkR5L2Y0ZnBtb0t5QUxYS3piYkFTM3VsQnZIaVphd2JjczgvNnJ6alhjWTJU?=
 =?utf-8?B?ZHUyS2FaaVJYSkJBaFBhRnU4SmhCQXFNUWxmTXN2Q1ltaG9jUGVKZ3NIbmpN?=
 =?utf-8?B?UDQ2QWVHMHc2VFdVMHNaUllDK0JTaVdScFE4UzVnRUtRbWFXZ0ZWa3ljYTRl?=
 =?utf-8?B?NDZpd0xTNkUrbmNyNmFJMHJjMWVPZm9XeFR4clhGV0Y2ZjQ4dnFUT2t1OVN2?=
 =?utf-8?B?cUdwZ3o2UytDaHB5Q01FVmlJMmt3dnB2TWcvREFkQlZIQUR2T1o0NmUrQ1lu?=
 =?utf-8?B?OXlmTEsxK2dSYzVEUG1obVlwNVkzQmh0VjZOQVc5Z2FJRWRDdUJFMzdxRWRN?=
 =?utf-8?B?WnBhYnVwcVNYTnlVMzArWUdQYi90dTVsaGhKOVZUZ0lpUkpjdjZHNjFxM0NP?=
 =?utf-8?B?bkFLaStrdnhPZ0lIblZDdXVaSHUyRkNsZnl1MU9Dd2NIaC9VK2RaMGY1TVNz?=
 =?utf-8?B?Vjc3SjFjNEhBNXNPUWZsc3dZU1VsMitRbEttU1JiZ1VTYmR3bzZWMTJxMGs5?=
 =?utf-8?B?c0dVaFdLb1FVbUZoOHZzaWFtdG0xajVMS3JPd1FPcmZmbUUzWHNwbmlNbmlO?=
 =?utf-8?B?K1RhUGM5K2lGMnlwOWdqSEVNS09yZWFPMGVwM0ZIL1ZOVHAxcy8yNnpZMkE2?=
 =?utf-8?B?WWhwUTNTZ2psMTZ5ejJkZmJzK01TVjR1UCtuU3liQlVDdkNIaExsRG9DMkZH?=
 =?utf-8?B?V2RBd3Z2T2Fld2kwK2xkdkJnbHZsUWtFSHh0a2tqTk4wcm41dTh4NUZLZU5U?=
 =?utf-8?B?czdURGVJYTdycGZwWU0yWHVJWjVqOEZGZm1KSzM5bXZGQlhCTGZqNEh4ZzhT?=
 =?utf-8?Q?XeVDkqSU3ZQ8SanwPwfziW+4L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e71695-a357-4e9d-5319-08db094c9aef
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 20:48:02.5691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceOcImf+6ngXEIvNrgSxGby3ouPYeRKsGDkWBctiLm6J4dsgtcFkXzwkNLVBEkFav9j+xFzei94yQDoGy+/hOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7872
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


Am 2023-02-07 um 15:35 schrieb Xiaogang.Chen:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> When xnack is on user space can use svm page restore to set a vm range without
> setup it first, then use regular api to register. Currently kfd api and svm are
> not interoperable. We already have check on that, but for user buffer the mapping
> address is not same as buffer cpu virtual address. Add checking on that to
> avoid error propagate to hmm.
>
> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index f79b8e964140..cb7acb0b9b52 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1065,6 +1065,23 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>   		mutex_unlock(&p->svms.lock);
>   		return -EADDRINUSE;
>   	}
> +
> +	/* When register user buffer check if it has been registered by svm by
> +	 * buffer cpu virtual address.
> +	 */
> +	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
> +
> +		if (interval_tree_iter_first(&p->svms.objects,
> +				untagged_addr(args->mmap_offset) >> PAGE_SHIFT,
> +				(untagged_addr(args->mmap_offset) + args->size - 1) >> PAGE_SHIFT)) {

Instead of nesting two if-blocks, you can write this as a single 
if-block like

	if ((flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) &&
	    interval_tree_iter_first(&p->svms.objects,
				     untagged_addr(args->mmap_offset) >> PAGE_SHIFT,
				     (untagged_addr(args->mmap_offset)  + args->size - 1) >> PAGE_SHIFT) {

I'm also not sure untagged_addr is needed here. If it is, we're missing 
it in a bunch of other places too. Most notably, we don't untag pointers 
anywhere in the SVM API.

Regards,
   Felix


> +
> +			pr_err("User Buffer Address: 0x%llx already allocated by SVM\n",
> +				untagged_addr(args->mmap_offset));
> +			mutex_unlock(&p->svms.lock);
> +			return -EADDRINUSE;
> +		}
> +
> +	}
>   	mutex_unlock(&p->svms.lock);
>   #endif
>   	mutex_lock(&p->mutex);
