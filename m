Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2591C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 04:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B1FB60E8F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 04:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8B1FB60E8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 104876FE2C;
	Wed, 10 Nov 2021 04:51:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B91FD6FE2A
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 04:51:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3eNJEqnVs5Nn1WmMeWvXlzYQ65i7Pcu3DejRtCqibkvcoWVxG1SHxsVLj/GuQsRBBrs3NgRVabFiZNzKkalfEtLfk6YdOuzbqDAsBJr6O3VIPiggDDVKHxew9bCGnGaCqG0Sd0MlQ3mQBa6uowDlwXOek80Vkq4g2qS5htfhmETmoM8Uy9k7/0oCQsnmVWQwAkqe6bWHplQxuuO7V9DzuKkeyJ7VsERHU6MHejGCWy4E6+5NfbYsRu2uO36wCP6jE83KAITRq9bPzICh8oPdyX5MN8vvOoY96d+1Dwlr1PlFICLvYmVavXFWbQzrbnfIuzEm2XaHB/e24Opl1uOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oV8rHpJ4mAc9E3BZk4qaqfeAxQas1iZdWJQb96uMl/4=;
 b=b5bzdCBpFAaiWDKAqAfFr9kkHCn6iiUEJgMz5xC9mrE69NvJgzD6bnt7eNqYp0hcIFN0OH/WwBjROFVkazfB8ks/LwjGbdKqu3+RHm9kbH0hWpx7/FtZ/lO/GbbmxXf70dJesud5997zdBlSB1G/1LGer0sCPZW8ibrYEInEqyXgy3iZeF0O0UnVBqAlMkrO0SiSVr6lolbbDU0/N6RXGhpNzb9HqOr8gXrTIwJp7KJTJ1+V4Inzd+bq0hLjqJOs3iI2vbn6sYT2fdIWvlYynYXlpwhlx40MY5gP7+Yf6eq1jDGMrizthaplCxDn5mfsE0/+xPEzeV+R0Wd244wVuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oV8rHpJ4mAc9E3BZk4qaqfeAxQas1iZdWJQb96uMl/4=;
 b=kYrx0Yu+WH6UFvEvPhjKV1Us+xzLrwt/o404Da1QesLRACZ2knSbI6PbaxGUgFeoRGzKGVHNVHx9qCnHsk5vGZLmtm1O3RvbtMLubEl+uE9UzcKYphnkCzf0OKg4bUWNlJ3aAr+xkc4jn8sBCT4M3PLD9IJmEElWtG2ERW8IZ7g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by BL1PR12MB5238.namprd12.prod.outlook.com (2603:10b6:208:31e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Wed, 10 Nov
 2021 04:51:46 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3%3]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 04:51:46 +0000
Subject: Re: [PATCH 5/5] drm/amdkfd: svm deferred work pin mm
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211109230432.3947-1-Philip.Yang@amd.com>
 <20211109230432.3947-5-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <a71af473-2b74-c0e5-5092-b88c44923e0d@amd.com>
Date: Tue, 9 Nov 2021 23:51:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211109230432.3947-5-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YQBPR0101CA0074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::7) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YQBPR0101CA0074.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.16 via Frontend Transport; Wed, 10 Nov 2021 04:51:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1443f8e-044c-4d9e-e091-08d9a405cc94
X-MS-TrafficTypeDiagnostic: BL1PR12MB5238:
X-Microsoft-Antispam-PRVS: <BL1PR12MB523894DB1807C5F6C475FEDA92939@BL1PR12MB5238.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/0CG6s9UJj3OXYGwwbOw0LdPG1i3w2Zxd2WL96VMY7L/dGTSaBCUbZRTTq+8z/i+3y4eN6LLsx3f4//6ubBrBx2xBNrm3QADEvTPk5jgo1H1KhnloHF5mh/abYw2ImujPT7/3JitjESByHle03lfqXeFAaU8bQTd9nblJPdxTXpLqetc2lzfjo2Z2cI7LAoC9D2BDk7kff6BSWjjXJyETQXrVKt6aG5ydFHn5SJITWpa5ihtTe1j5RYGJWLOINGo7Z9LJz5Flg/lMJN5wwlgJswmjgXa1G7GEfqVs79PgKPt7rGiHeYwsNhBdqE80qI4ptHdbBzyixvsbZPHbNYM7+EdVEmIZ4PvFOhGw6xTvnw6vmW21eIPI7IaN2qM6cXEEbnEbrtIQSfD0cXxjQqHELPR8IcVF4/FZImor+6ZIvU82BPn8AXPLu39vRB5h3Q1pUZvP4TsG6GoPLPyLqQgdPKnHLnoN7hXDwYoPp2rpldfcT62tSODsG+6mCi4Jx72PP/f8xTSMFrkmy2xPfLtthxgV2WO08+NbSx14a7D+zf7MJpC1EuH8Be5CrL1V4TAtBVOg2HRCSXkV9JwOV7HulIgNS+4+WWQXxoDtwdX4DwypA/JV/P+ARROlnE98sGzPksSocIKltKCquPQl9IRQdfkdG28yHUcmRug5ED8VsGdw832ZVL/YWYs/nqQdAIW3JQBM8nQ5ytS+5nGR0FzVIHNKxCoa7wH6S0T8w42U8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(38100700002)(86362001)(956004)(316002)(186003)(2616005)(31686004)(6486002)(36916002)(26005)(5660300002)(16576012)(508600001)(36756003)(66476007)(83380400001)(31696002)(66556008)(66946007)(8676002)(53546011)(8936002)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXNIbUU2NXBQcWJxZ3FOMzNjSkJkY1cxSkNYbXYrQ0ZLTU9BQmJDU0hKdThp?=
 =?utf-8?B?N3czRFNaSzdTdjEyVXJvTzR3Tk55T1NnUUlwM1NzVGJIbjZMOUVBY3NzQ3c0?=
 =?utf-8?B?ZitEdTJlZmRSSVUxV2diZnA5MEFZLzVFY1huM2RrZ1gwcHEvbHdORnBwdXFw?=
 =?utf-8?B?MFVWSmpVWjRoMGppeUQ1L21oWlJPUTdZWVMwMW9kWVpUT1J0c1ZQM3puVERy?=
 =?utf-8?B?Q1dhbWtSbU9nR1FtY3lYT1lXdkcraElMcVB6amhnQTFVSTd6UFNNSGlKZFF3?=
 =?utf-8?B?ZEJraElCbjJ6TDVVWmxXM3k4WElnS0pHQjk5SzNpUktlMHBTcUhISzl4eDJz?=
 =?utf-8?B?RmJoNXpvNmJ0OXljaGpTSzdGMTl2ZFRPNjdST3IzdGFDZHJOTUNYS2FjNHpH?=
 =?utf-8?B?MjRsV2Qra2Nmdno1WGVGVm5XWFhzdzBLZHMxU2FrdTh5MkpBaXBDNWV0SFh6?=
 =?utf-8?B?b2JrWGEwT3lZaUpJeWhVRmJGUlAvU2FCLzdFZFZYS3NLME5DQXVZeFJQTFoz?=
 =?utf-8?B?RW9UNEptSTVNWFZqeThkYTQ4VmovSFJTOGo5RHF0Q0ppZDA5R0hhZjlVb212?=
 =?utf-8?B?UURzb21mUUw5bk5hRFVtTy8rVTdvbWp0MTJrWmNIUjdtdzVCUUJxaXN4UHNB?=
 =?utf-8?B?ekdKbUVEVnFESSsrd3kwSExGc0tHcEtXSGpTRVVRdFFoZjluZDA3V2NPNGtj?=
 =?utf-8?B?cW9BZE5zQ1hWeGFmTlM3TFFKazVRMWdmMTJMZUJ0WkxiSzBjNzkwek42OUlt?=
 =?utf-8?B?eTYvMnNvUkFJbHptOWFkQi9ZSXRDejRWZXZTdzZjTG9KdGozSlZTM1lBSnZp?=
 =?utf-8?B?YTFPOS9ucWEwb3ZSWHV3c3VwOVc5bHJmZFJYSmxrWUNwS0Nhd3hMWWFocUhG?=
 =?utf-8?B?S3ZaM1RqWmsybDVBQVAzSGluOGlXeTNjeklsR2VkNXlZQUxNa0lycmNqQW04?=
 =?utf-8?B?TWJsUGVZNUxCVkFCM2pZMktRMmJxSTdLSzFGSWl2bUxhUkdJTytoSE10Z3Bp?=
 =?utf-8?B?Vlo5ay9Fd0pta2tPOGFVSTkxRk0vSjlqSGZJd2gxTlFRVEY4LzlIaVRkL0tu?=
 =?utf-8?B?S2lpOUpQdHNGUFFiUW5URmNlMHdVVGtDYVllVVZwYUlCUHJiODVDaTFkVU1K?=
 =?utf-8?B?cXhXdTlqMFdBLzJwY3E2a1plandpa1B4U3hXZ3p3Q0sydE5qYkJBRDFVNmNP?=
 =?utf-8?B?ajRqbEtLUWhpT2ZkOE41RDZPQ01aOWxwYjRwMHpIclJwdEE2cUlURUZneGNQ?=
 =?utf-8?B?ckxQQ0JkQlpoaDFtakxKQVluL2Vua3BvZTZFQzdXVGJocEIwZjhvSkRJYUZQ?=
 =?utf-8?B?bGhuN3ZsLy8yVUNvcUlZcklHaDZrc0VRODM1OG1xNWhWVzBPclFkWTF5Ym03?=
 =?utf-8?B?Y0Nsd2RIRzFpUWFLUzlabnJJcGl6M2Y0dW9YVkJpUTZYTFNoQ2M2K2ZLRWxZ?=
 =?utf-8?B?NURRRyt2U0QzUTJTNlp5ektVMHUxOHdKZWNyM0pxeTNETmhTakVha0Z3RkJJ?=
 =?utf-8?B?MVhFUER4cWxrVzdtMnl1eU1TTU4xbnV1QXp1UGl4UVpTK1Y4YkdnRjNxMEo1?=
 =?utf-8?B?c29ueGlJV2k3Nkg1cFZML0QwRm5kTzBQdVl2TDJEMTdyU2RqaE5kQmdFaDh0?=
 =?utf-8?B?cXRTSy9rUXlOQitIT0dxL24venQ2UHFsenlRVm1xaW1FNlg5UnBtVG9rSmZF?=
 =?utf-8?B?aVpJV1llTzZ5THFOZ3lJM2dDVFRGRENheDRKc2FpNmx6R3EzWVZETFkyZWdt?=
 =?utf-8?B?eU8wNGxTTldkZzd0RndJTFROK1lrUjZoQWs3U1dEZExYVzdTa0M4MVhKa2pV?=
 =?utf-8?B?SVJSL0FCbXMrSmo1enV4bVJKMnF3VnYyTHVvUUVvQnpJeVpNK293dnZ0Rk9y?=
 =?utf-8?B?eUswbkdGREVDQ3NPek4wdWlaclk1djVwY2FKbUY1c0wvTkZqTUo2V1J6VDI0?=
 =?utf-8?B?V2ZXSlFNYW5zNUZhZkFrQW9pUDdpbmpHbE0zSzUyK3ZkUUkvem4rSHVyZXA1?=
 =?utf-8?B?c0lzZm13TXR0N2hoUmZLcEtEcXdCOFV5K01XdndvTWNOSEJnVnpaTWJEaHlT?=
 =?utf-8?B?bUNXc0N6TFAyaytUQTdJLzJKYUxCYUlNdU1CZVg2VzRvNDhYWTczbFBpRXZi?=
 =?utf-8?B?V011ODJWT2R5QmhaMkRBS0UvZG5iME8vdVRaeXFVU2J2VUFWUkQzTytieWVn?=
 =?utf-8?Q?sg857dB3KzMNCD1g9grX+uY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1443f8e-044c-4d9e-e091-08d9a405cc94
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 04:51:46.5050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6L2BwBHdCA70iA7uXfoVXL59UfbLsmS8crIxKp1IH9kEaqI1kff+zR3g5xtvpSQUmppW8ewe8PbgUyFvpEKBRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5238
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


On 2021-11-09 6:04 p.m., Philip Yang wrote:
> Make sure mm does not remove when prange deferred work insert mmu range
> notifier, to avoid WARNING:
>
> WARNING: CPU: 6 PID: 1787 at mm/mmu_notifier.c:932 __mmu_interval_notifier_insert+0xdd/0xf0
> Workqueue: events svm_range_deferred_list_work [amdgpu]
> RIP: 0010:__mmu_interval_notifier_insert+0xdd/0xf0
> Call Trace:
>    svm_range_deferred_list_work+0x156/0x320 [amdgpu]
>    process_one_work+0x29f/0x5e0
>    worker_thread+0x39/0x3e0
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 2083a10b35c2..fddf0a93d6f1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1992,6 +1992,13 @@ static void svm_range_deferred_list_work(struct work_struct *work)
>   			 prange->start, prange->last, prange->work_item.op);
>   
>   		mm = prange->work_item.mm;
> +		if (!mmget_not_zero(mm)) {

You can only rely on mmget_not_zero if there is an mmgrab-reference 
still active. Otherwise the mm_struct may already be freed and allocated 
for something else and the mm_user counter may be corrupted. You're safe 
until kfd_process_wq_release calls put_task_struct(p->lead_thread) 
because the task holds a reference to the mm_struct.

One way to guarantee that at least the mm_struct still exists while this 
worker runs is, to add cancel_work_sync(&p->svms.deferred_list_work) in 
kfd_process_notifier_release. We should probably do that anyway.

> +			pr_debug("skip range %p as mm is gone\n", prange);
> +			spin_lock(&svms->deferred_list_lock);
> +			list_del_init(&prange->deferred_list);
> +			continue;

If the mm is gone, you can probably just break here. All the items in 
the list should have the same mm.

That makes me wonder why we need the mm pointer in the work_item at all. 
We could just get an mm reference from get_task_mm(p->lead_thread) 
(where p is the container of svms). And you can do that outside the 
loop. You'll still need a matching mmput call.

Regards,
   Felix


> +		}
> +
>   retry:
>   		mmap_write_lock(mm);
>   		mutex_lock(&svms->lock);
> @@ -2032,6 +2039,7 @@ static void svm_range_deferred_list_work(struct work_struct *work)
>   		svm_range_handle_list_op(svms, prange);
>   		mutex_unlock(&svms->lock);
>   		mmap_write_unlock(mm);
> +		mmput(mm);
>   
>   		spin_lock(&svms->deferred_list_lock);
>   	}
