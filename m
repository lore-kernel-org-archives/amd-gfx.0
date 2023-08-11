Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E2CC001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 20:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8733710E6F9;
	Fri, 11 Aug 2023 20:07:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31F4410E6F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 20:07:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJn4G6FXfU8bj706SGNggbTuy8YpCGsCxPyXSVqB4nETt9wepp9OdJyLM35S7zK3Z+Y4uqyQ2/e8gBRGD2VchluU7Zu/Yequnp4CoLcOm3PfF8VaJqOaIctIU8v5RecSWMNAUmjGSEvcL6Hd7qJSAYSPtJWSL+/UK2A1La0zQg1zNcjD84eUpfYfDXsks/oIiorNVdVSyunq+h0P0cBUtDHD0hXHvWGzjlXqtOaQbrANja97UMy6GP39Qm3Gtt249yUasw5D/HvLnnis2iRDHljWFLj7ouverTI8cb9dlYGZ1fTdShU+zMVyQ2z+Lbj3fy+bmtPakZofQ7+uP8cAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jkYBT7VXb+e+nT8z9CMs4KKyBlyNSxrraLh3hF0SQI=;
 b=VlLxANyBD+zwSDPz2YSjXlnxj5pwUosx9rj3N5goN644yR6P0TB3cGHb9JZ3AowhwmZ9vP+JqkGwYWbYqPWfcotcl9mBNjBq79TKTgJl1inTJdlPwxIazkCthoXkXIowQXlMfvRogYu7Shl7Aajys1idsa7XmF81afw2WINfpsjkmQQLd7zYWroJpsbtCtJLLAIe7oE8Dcbc8tLUuPdmG0HA5XAgA0rHODlykWcOQ2ghsRbUJ+PFIQYr4t+I5D//nEMLswDX5PykXSU5ESVWeZperN5jvKH8zoaaP6otH4xiQwQRAIkP+UKOCjrdIm0UZ9eBOxhA1hUAt2LN6s5BlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jkYBT7VXb+e+nT8z9CMs4KKyBlyNSxrraLh3hF0SQI=;
 b=m0bhRXvpyhLf8/h0jm4g47DgQ22ntv8gfm9RzV59OEnAmyW9eh3XKXn0v/XHrakOcRvvTyWUCT8hV9dBa80Y5NSNFnB+aevfOYVu5+faZr9VmJ0p4fJoTYWSlTz3TQXEqe6gUhuAPpIjBazMxpeaARQpZTIVrlwM9te8VeqqPkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 20:07:00 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6678.020; Fri, 11 Aug 2023
 20:07:00 +0000
Message-ID: <41b68fb8-378d-6f6d-c653-d6c2b106d8d3@amd.com>
Date: Fri, 11 Aug 2023 16:06:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: add schedule to remove RCU stall on CPU
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230811191108.1808648-1-James.Zhu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230811191108.1808648-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1P288CA0021.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::34)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a0bbe69-0e27-4e79-c346-08db9aa685df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O8UTE/oY6kAxizswME6uKTDGGn38djPj0bUBLiRaq4hPC1QQSdx+zjudU8zyWwubjHQVDYVljBBo+YlMqS0Km3dvCozC+OGjuPVCR/GPEuG++uPzk0ZatLGIRYLYQRnIDgE1FgdnX3Ay1T2guiQeCxIJiSJXfPmw3mH8PtJ3QadrdELAt0d0SGfdRi5wFobNNxKSWdd9jDkDFyji0mRaZGaf4r/N7AXh09e05U/H19ACm08AAIzZy12auWwlHYhYyR+sxSGyLNSa87b3jlIvZ8jW+Gxj1x5ziKMUKVG4nmgRVaf+PxiuC4TctCFeZaopfZY4guQwwGyt9amkwNZbPdb0caIAUGNK0X11fgQqbCdWuGgPfGQFxjrRSmpqoAe04rpc+JHURy3YGyaYaPbl0edZfTf/2eIAfrvuFakTgjXD6H8yphJr0Ylzzw7y5uBUseokdRM1/sQHJqKaj+A0obde52h6vJkeQoyd67hWZrldlXh6WKGt+2sz1L11lNifkj2+5KYu6It/6bFIFeZTPTGGeZaC0+CSwGomRrYeU+SY80xbyWrzBYhGe/5GAMxd6wtpOTn+67QblvV0sKCaQ0c6j+Rx1OHYjDH9dYaoVKf+t6W8GCTCjh8KKRZtWsu01L6hSKa+0yTFsZHbbXWR0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199021)(1800799006)(186006)(4326008)(66556008)(66476007)(66946007)(41300700001)(31696002)(86362001)(316002)(6506007)(36756003)(26005)(53546011)(6486002)(6512007)(36916002)(2616005)(83380400001)(478600001)(38100700002)(2906002)(5660300002)(31686004)(8676002)(8936002)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGlVcTBDUVRhZnQrYjhlUlJ2eC9WTXV4QU4xTWFZczNUbTNORnVTeDJKeXR1?=
 =?utf-8?B?SUNZQUwvL0JDK2YyZnhabnpTREhFKytOR3pHSUNwa0Q4bkY4dXBOc1RYREhm?=
 =?utf-8?B?YWFvTGgwWTRMTUx0alhyL3k5czZvcHpiYVIwQXY1QnkxNGVjZ0s0WHpyN1Rl?=
 =?utf-8?B?cWgyUjhDTzhCSGE0ZnBtMmJsRnlGTnByZGVxbGlpclVadkpRNkhpSDVJZGVl?=
 =?utf-8?B?WEtPU1pzUWlhUWZxL3BNSU16SDJJUFBnalR0UU55eWJlVXE0b3RSajBCZTBh?=
 =?utf-8?B?bWllM0Z5dGJxS1pFRGFneEZ5WlNMWHFUZTFuRTcySHIwOEN1VzJNZWhCYnRY?=
 =?utf-8?B?dFVrMDJHZjdzN2tGYjE2RHB3bGNUQjM2bU5EcWhnSzBhY2dnMW1BWEFiK0xP?=
 =?utf-8?B?S0kxVEJTaEFRWTdjSmFBRGd4RHNrVTJ4YWVmMVVFd1pwRkZEMEt3bWVOR2pJ?=
 =?utf-8?B?Zk1VK21KNWhrYlZ6RGc0OTNPeGxNL1RmMzFmRUZpZnNXdk9NbFRwSm4zWEhm?=
 =?utf-8?B?NHhPdHovMGVVUTB6bXRtSStmYjR3ZE04ZlZXOGNvOEdIcUJ3K0Z1VVpyanBJ?=
 =?utf-8?B?bnkrWVlsclJyR0lqTnlHVzVlUTAwclRic2NJMG9wbXJ4V2ZmUlJXeVhjbG40?=
 =?utf-8?B?SWJNVUtOS25vS3NSQStiR1IzRmlYWVZTV0hKNEE4OVo1c3FUcWQwRU5WVFdp?=
 =?utf-8?B?OUtQWFI1SVRCMUFhKzJ4YjdQTjZyZE9UYWY3a0RjUjNUelY0U0dXSXpIcmRH?=
 =?utf-8?B?VlJXRExMcGVHamtGMjM5RXVSZ1FrU3dIemVxazdqai91Wnd1WERQWXp1RjYv?=
 =?utf-8?B?dTFhSUMvQ3E4eWRabnROdG5rSVo2a1JjNTUrVWIwSGY1dnBCbFM5NWVBTndH?=
 =?utf-8?B?RVhpUkpUR3N2NDFUNTVUT0hPdy9YTS9yTXdvUkovM2dzMThMS2FpZTNXVlFp?=
 =?utf-8?B?R01rM0VnOC81ZHdKMG5XblZkNVJjZkQ3djh5Z3VqbFU1RHNmalAvSmMrV1Vk?=
 =?utf-8?B?Ky82emhtcEZTU1AwYk9IS1ViNnZHK2tKc0trVVBKZWZwQlI1STBSbHRjbUpC?=
 =?utf-8?B?bi9tL0VWVWR3LzFiV09aR3ROZ05CN3I0eVgwdkdIcDdhVDY5cWhYMlFGL2pH?=
 =?utf-8?B?RkdPOFgvVUpUT3dPSTF5VlJkNkhLTWt2Q093RzRURlM5SE1QRzVveGxaMDFt?=
 =?utf-8?B?SitITXRqQi9mRm9KNXZGMHRsOXRyMnRKUE1IS3g3SmdDMFpwYnZwbndCeTc5?=
 =?utf-8?B?bk1PSklPaTRpekNldVRtNDl6TUFUcFRoU3N0Q0EzMmFsalJUdEpETjYwYXBL?=
 =?utf-8?B?MnMvMnN5VC9leTRVVnI4Rk1ZdU9RQm1iVDBhYnNVQ2FWOHBpTjFYRkZ1cHg5?=
 =?utf-8?B?eHdFNGFYODhnZGltcERLQlpxSHJzWGpxRFU3NlVDdEZ3L3E1K3paN2drRURV?=
 =?utf-8?B?by9oV2ZoRUFmcHhHcE5ZaERBZlVRclhMcmNOOUdZSlF2eE1LWWUvc3VXMjJG?=
 =?utf-8?B?YUc1bVZqZHBYNjA4N2crck9qd3VsZUQ5aThDVDh2aGNvamhzQkk3N2xaK1ZJ?=
 =?utf-8?B?RGJSeFlHTWxsdmJpZG1oS214Wm5FK2ZGT01SdkRaNCtkQS9oeldzdU9lNVMy?=
 =?utf-8?B?OGxiY282dnh0Tk5Xd2drdzloeFAzWVdNeHlINE0rYXpOYzJzSmlFMFg2dk1V?=
 =?utf-8?B?ZVRYL0tyR05RMWdtYTYzVmMyalFHWU9WWmdBQ0x3OHBhMktlNmRlS2JJdldv?=
 =?utf-8?B?RmVla1Nod0QvRy84cytoUVRMWFV1NHgrcEFNRlkrWGNZSXBWRW5uVUtjZE9X?=
 =?utf-8?B?WW81QVFZT2ZDZVZpMlAwT3dLazlZUWJJd0haV2ZaRk1mbXRvQmhwQVNndHla?=
 =?utf-8?B?cjVuQXRmeldMbG9tZkIvYTJYRWRURFg5ODVMc01wcVFjd2owbXpNeDdPSUxq?=
 =?utf-8?B?eU5vTkYrU0Nsb0J0ZHd5TlBtMEY3cSsySE5XVTQ1cC9acEYxWG4xM1FiVWdR?=
 =?utf-8?B?cms4RGJHZXMvUGJsb2hRYUR5b2xrd2FnQXZWZFBIVVNhekdaRlIrUHFtZHNK?=
 =?utf-8?B?YXRMQWZzSmJHRnhxdEMvZFYzeWhreHl1dDlheThoMzgrVUptK0lSYVJSdzY5?=
 =?utf-8?Q?HSPbN/5kdWRP4eK0PkJwe3fcm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0bbe69-0e27-4e79-c346-08db9aa685df
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 20:07:00.6043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ic+01Kyfa3wB4tvE0yZYRful+/srGT4r77oyaIz4jFm7ozOdd9OWvCeZ+lfQOLVl++QfME//ELVUScrK98PkmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570
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
Cc: jamesz@amd.com, Roger.Madrid@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-08-11 15:11, James Zhu wrote:
> update_list could be big in list_for_each_entry(prange, &update_list, update_list),
> mmap_read_lock(mm) is kept hold all the time, adding schedule() can remove
> RCU stall on CPU for this case.
>
> RIP: 0010:svm_range_cpu_invalidate_pagetables+0x317/0x610 [amdgpu]

You're just showing the backtrace here, but not what the problem is. Can 
you include more context, e.g. the message that says something about a 
stall?


> Code: 00 00 00 bf 00 02 00 00 48 81 c2 90 00 00 00 e8 1f 6a b9 e0 65 48 8b 14 25 00 bd 01 00 8b 42 2c 48 8b 3c 24 80 e4 f7 0b 43 d8 <89> 42 2c e8 51 dd 2d e1 48 8b 7b 38 e8 98 29 b7 e0 48 83 c4 30 b8
> RSP: 0018:ffffc9000ffd7b10 EFLAGS: 00000206
> RAX: 0000000000000100 RBX: ffff88c493968d80 RCX: ffff88d1a6469b18
> RDX: ffff88e18ef1ec80 RSI: ffffc9000ffd7be0 RDI: ffff88c493968d38
> RBP: 000000000003062e R08: 000000003042f000 R09: 000000003062efff
> R10: 0000000000001000 R11: ffff88c1ad255000 R12: 000000000003042f
> R13: ffff88c493968c00 R14: ffffc9000ffd7be0 R15: ffff88c493968c00
> __mmu_notifier_invalidate_range_start+0x132/0x1d0
> ? amdgpu_vm_bo_update+0x3fd/0x520 [amdgpu]
> migrate_vma_setup+0x6c7/0x8f0
> ? kfd_smi_event_migration_start+0x5f/0x80 [amdgpu]
> svm_migrate_ram_to_vram+0x14e/0x580 [amdgpu]
> svm_range_set_attr+0xe34/0x11a0 [amdgpu]
> kfd_ioctl+0x271/0x4e0 [amdgpu]
> ? kfd_ioctl_set_xnack_mode+0xd0/0xd0 [amdgpu]
> __x64_sys_ioctl+0x92/0xd0
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 113fd11aa96e..9f2d48ade7fa 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -3573,6 +3573,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   		r = svm_range_trigger_migration(mm, prange, &migrated);
>   		if (r)
>   			goto out_unlock_range;
> +		schedule();

I'm not sure that unconditionally scheduling here in every loop 
iteration is a good solution. This could lead to performance degradation 
when there are many small ranges. I think a better option is to call 
cond_resched. That would only reschedule only "if necessary", though I 
haven't quite figured out the criteria for rescheduling being necessary.

Regards,
   Felix


>   
>   		if (migrated && (!p->xnack_enabled ||
>   		    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
