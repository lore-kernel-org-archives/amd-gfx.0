Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452B7C6FA89
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 14:54:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76CAF10EB58;
	Thu, 15 Sep 2022 14:54:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B570410EB58
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 14:54:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWSU9znbnp/3ybz5vNzC7Yc1kpEp49ydPjTO3IktSu5OdBNcsTtQxGtDh9OwJcw59FoPD0WI446s4Mc65TIG5ADBmHk6SE+23hi2Gqeo6GsJdm5tyDX8YR/fkUYMxm91x8E2NpNJlzSHR35QUiWMNZriw+jOkU0J8zGVVqSt10+7WOcyhHWd4kRrDt1O1Zb+WT3ZDRJAQ17yjS93V2Awxd9w2xgCmbeqttW8fTDTKcM0dUE91RahnAnn0S44U26iXJxdyStscpu01aF/rU5nvNbFpwN1xGlRz0I5vS7J0ufO5EAp6CgNuhGyJGCD3ssCpx3V2GOEz6rBn4kgkp3NCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YpDW8mD5y9C5/0eGgBeW9fWScXRz2qz6fF5OWjNjYI=;
 b=Vi79R9Vy5b6m1bFmw6GWKGt3wbAHS65nDUpYXTFi8nTIMl3W6vUxJhmovwGT5YzxeOi3cm5UGRzcQ5hi47TiNu8ktLH+WPdWGPqw+nAkUgFf3wZG5qJZozE20Mr7013AKYldvrt3RoY+QAXVvxzJ4+KRBbEf30lkCQc5bYpQpUFsTh79pGRs3pxNAojUyW0Puzbey3tGAKQFtcsesf9lml5WeQ/15bXzx4EWiFGeGtNzgIywnBX9NllfuCr0p3PBKirygrco0/F+B6eK5MST2/mF7MDXJbSYjNDIOpEgInBaqsquAsFuNSlWoCFP61Fmkh6Ka7ScdVN86NSJ7HRhdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YpDW8mD5y9C5/0eGgBeW9fWScXRz2qz6fF5OWjNjYI=;
 b=AM7zygiZRDffvx9+zHulq24HDCZZKesmukOHK7NkFHB95ptWgte0eKAnwTbd1qzdjDPYvpyia3A9k6MddA2h4yXZ/oi3U25L2nGghnIdhA1+sy+vnJDlAViSCWlhdwFZ7gOkiZp1LpEj8gMMK9yvvA4BfwpXjz4KxRhexuFnark=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Thu, 15 Sep
 2022 14:54:10 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 14:54:10 +0000
Message-ID: <1b124a8f-540a-dd53-7b9f-1b819ac2bb41@amd.com>
Date: Thu, 15 Sep 2022 16:54:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 1/1] drm/amdgpu: Fix amdgpu_vm_pt_free warning
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220914160842.9610-1-Philip.Yang@amd.com>
 <e95c37e7-d8c8-3802-63a1-92b5f6b579ef@amd.com>
 <de2064d2-1a30-4b88-855e-0207bb68aefc@amd.com>
 <cc5097f3-687b-ca13-4117-7d207facd4c1@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <cc5097f3-687b-ca13-4117-7d207facd4c1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P194CA0038.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b33620a-b010-4b65-65f2-08da972a257b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xb3J8cJbBZNA60pTxLZbz/yCrTDmH052jHKTzY8rXNv4r16SJAxQ63j5/2VBlKuXDmAH9VjGMoC1vxsP6AzqTw4CrD/B2/eVrQyHxTBiq6dKLcSiyC0BziHP46ibzkumqw9OJ+BTc4D71w3j/mF0HKxumbQt7MxU9StTWhGyFzQRdrp8K1IAj/My0N1t6ukJmhBdJ746dq2qVCseIf9BnsGUBdjHMSjOw1ifFa/uqT4U4/o18fpdze7U6EsnfuqbNCVYrPq9JMoNtMWqakrp5FBgObzcMufiO7Lt8F5oPEadQ0nCHecXDMC1KqFTYZwFrpXkflLqYV3zQa+2k4K/7bD3C0nQzZ9qcpVz6V9ku27rNcHUTMfV9iu0jBju1yDrQheO/8watAdY5WlIgW8DjAqLDdA7f9IbbOkQqQ+Wo1DoQ0xR13bJsF8VnAUV/+eF5BUHXAev64BTJKbShYDqI/pSMfeQJl2U/SnFzBS73wJz65+0ZUReF+8DxmtPaY+6L5WI/s36fJWrfB7y456t2cZ0xPGhBwXFHbgGFIyAk5OMR5xJ0kqLkflD/tknx3B35B+/8e3DSFMwMxqaNA2YuXD9lTRYD3oQ3AhpcIBVDMI4T+vpNfuuKQ/0JQBhf90yt43rFWVWJb2VEZRu7Eng+t9WTobdvhu1CyF52Ud32vdidMFXe9HlGvN40AAm65YMnnbIZc2gnVJaopZjbyTn+741HoPfDYkG9znSeV6msw1ioyDUYlN4Ph8KLeKvGSIIzqTHKxYb2KxWKbABLttf6yEfF7n3Sabrxvd0EvRGgr4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199015)(8936002)(66946007)(38100700002)(6486002)(66556008)(66476007)(6666004)(316002)(83380400001)(36756003)(478600001)(86362001)(31696002)(186003)(110136005)(31686004)(66574015)(6506007)(5660300002)(8676002)(53546011)(2906002)(41300700001)(6512007)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzJRRk1Ob09nVXhzWWU0blhhbHBsOFFra1NCdEdoWUtkMUFzMTdKdmNNaFV0?=
 =?utf-8?B?b2FkVlZ3aTFic0tyR0Z0N29kOWNESUdpb1RSbndBS1pxSHdjZkdvNG9YU3VG?=
 =?utf-8?B?SStoTzl5M2hNclFRRG45YUdjai9XL1pycG1leFQva1NmK054QlFuZ2hVOTY5?=
 =?utf-8?B?RmhUb3dnTGZOS3pNYjdnZkRDMWQ1WldYRENZaUxxTDh5QXVvcEdtWWdyd3RN?=
 =?utf-8?B?RmRxd25aa1dhSk5GRE1mYWgxT0d4ai9URG5iTCtJZlBKVExEaVozcUJ4Tlln?=
 =?utf-8?B?KytkV0ljbm9BSStEaVRNY3d3dWpCM25HMWpPdEJIdWhtYWJTbjFCVnFpN1Zl?=
 =?utf-8?B?cjUwRW9pZTFQVTJOQ1RUK043Q3UxbnNkWVNvV2R6VlBHYU9mcFRtZnFJQXoz?=
 =?utf-8?B?aEdTSFRDb3ozK0JxdVFTRUYxVi9CUkl6Ymd0QWFESytlM1BtREtld3BUc1hi?=
 =?utf-8?B?R2xlQW1EaXA5RjBVZ3FTVmZRbFlyN1RuWGN1cndGSXpVYUtsU1ZtWmI1N0cy?=
 =?utf-8?B?cDZMVm15ZXZEd0dCcDZsWG1BK1JyME4vY2V2a3hnRnJIM0trSGl0WGpITmJp?=
 =?utf-8?B?MHRkQmF1TGtkaGVHYVlFVWp3MUZlUGNwamRyQXZPQWw0YUVBS09BQlpadkcv?=
 =?utf-8?B?bEZxYVJFN1ZXckptQ0g1dWZReEZ2eHdBU05nb1laVHV2bGlWdXorZUpqRG1U?=
 =?utf-8?B?cFpYRXV4MGgwN0paY3FBZ0tXSXBnYUlLUEZkRzQ4WnZTMTlKYUdzd3YwVGhF?=
 =?utf-8?B?b2FBemZLK1U2Ym1TejQyakUxYjgyYUVmdU52aDV3SjZMZHdPeVpZWEFVd1JC?=
 =?utf-8?B?NGNHNGpXRTZsNGx6bXVrbjg2R3k3OVppalJBbnVHSXFQU2lXaWVGZXZId2x1?=
 =?utf-8?B?R1VKT1E2SDZwc1lyU0V3bWdQcE83Y2NCVnZXYkh3aUUxdnd1Uk9DSW5jc3RJ?=
 =?utf-8?B?LzhhU1c4THl0VW5mV2loUUY3OWUrSlJUUGlaMXBGQUl3aTYrYnVNY3VCRjdv?=
 =?utf-8?B?ZUUyL0ZtMUV0NCtNMGpQNUxBbWJDMGtpQUhLU1pkaGUrR09JcmZtekNMRWYr?=
 =?utf-8?B?TnZqN0tmWE5QcE9EWVVRb3hraGxXTWxtNTJNZFEwWlRpY29PT05tdXBsR1pY?=
 =?utf-8?B?ZTZOL09UYjVRbGNDQlA1TlQ5MXR6R3VYSlc5U3E1bjVhUzBNMElxQU5zUlg4?=
 =?utf-8?B?bWpaOVoxeG9IUTBpNm9mQTU0Vk9ocVkwNk5OcC96anFSUFdneGpuaTVOeEh5?=
 =?utf-8?B?V004N3ZScThxNTVtRGxrOHZOV3VRanRpL0N0LzE5YjdWUFczZzV3RjdBYnRN?=
 =?utf-8?B?dm4vckpWNVAwbDlzb1NhcnA1VEVoVUs5TFVHTlFwZjZvYzdWSmNmeXdTMUxW?=
 =?utf-8?B?bUlEaDQ0S1cxVEduQzlBaHBVOG50Y0FKeXRXZGRCWnF4NVlpdlhqV1ZYVWxD?=
 =?utf-8?B?WjhyK2ZLdkRNQ0F4VDM2WGVUU2RsS1REVU9ucXJDSUhuMTdWaXVnTXY1NWJC?=
 =?utf-8?B?aW4wbDRsYXlQYS93ZUlYMEp1SWlHYWFmNXhxazkwdk5lUmR0UnBjL3ZudWhs?=
 =?utf-8?B?QTM5U0RYQXRvK1F4S1hVQlYybFFyZy8yS3lKeFFSazd2REJDaVFRTjdJenNQ?=
 =?utf-8?B?UHQ0S2huL1ZhdkM3cVZqeXdRTHlLU1pWaDdXZkJBUUk2Q3hUbFBCUE1Odjkz?=
 =?utf-8?B?WTNoQXRCZDM1L3hLdlNFR1ZpMEc2VkRNenRObUphRFR0VVlnYi84QkF6SGx2?=
 =?utf-8?B?dnpzVThNTUFKM28wdFBYTlFxbHVGb0gvdlNvSHBkZ2s2M2tXVURUTE80WTkw?=
 =?utf-8?B?V3BpMVFTMkJ2TVpybExQWUJZMG82UlJ6Z3ZqbGNDc3A3citKcXRCbk5MdzE5?=
 =?utf-8?B?b2tnalh4bE5QYWpodkpJTnozeGYvOW10R2w3MTVEUmF4TFdSZ1F3cld1RFVu?=
 =?utf-8?B?b0hWQWdhZXhWTU80NmdtWmViZUQzTUtFb2ZHSTU1T0VCcWNRNEdKNEpZUHpt?=
 =?utf-8?B?UVQrSnJjdThkM0VVWll5ZXBhTlBabVQ0VlZXd09WVjFZVnBZOU9vcC9OUXh0?=
 =?utf-8?B?dzlBcUtvektlbEthNDNvRzYzWmpUemRBUEV5MmhRRXVuTDg4ekxIVFdWeElD?=
 =?utf-8?B?aERWZ3RtVkRxNUI1MTRRTEl5WnZHTlBHQ1FxQ0JzbXVmRkozYmxvYVJRVEcv?=
 =?utf-8?Q?LCR2p+3yL43+IbNEEMxNdhUs1anpkWWpfoV7h2NeSB7f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b33620a-b010-4b65-65f2-08da972a257b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 14:54:10.2110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHAQIvrkeq+j4C7pfzhNfzGEIbHhunAX6UZ8UwNDvDUeUINHF/+yuW/c3DYTypQe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
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

Am 15.09.22 um 16:39 schrieb Philip Yang:
>
> On 2022-09-15 02:21, Christian König wrote:
>> Am 14.09.22 um 19:45 schrieb Felix Kuehling:
>>> Am 2022-09-14 um 12:08 schrieb Philip Yang:
>>>> Free page table BO from vm resv unlocked context generate below
>>>> warnings.
>>>>
>>>> Add a pt_free_work in vm to free page table BO from vm->pt_freed list.
>>>> pass vm resv unlock status from page table update caller, and add 
>>>> vm_bo
>>>> entry to vm->pt_freed list and schedule the pt_free_work if calling 
>>>> with
>>>> vm resv unlocked.
>>>>
>>>> WARNING: CPU: 12 PID: 3238 at
>>>> drivers/gpu/drm/ttm/ttm_bo.c:106 ttm_bo_set_bulk_move+0xa1/0xc0
>>>> Call Trace:
>>>>   amdgpu_vm_pt_free+0x42/0xd0 [amdgpu]
>>>>   amdgpu_vm_pt_free_dfs+0xb3/0xf0 [amdgpu]
>>>>   amdgpu_vm_ptes_update+0x52d/0x850 [amdgpu]
>>>>   amdgpu_vm_update_range+0x2a6/0x640 [amdgpu]
>>>>   svm_range_unmap_from_gpus+0x110/0x300 [amdgpu]
>>>>   svm_range_cpu_invalidate_pagetables+0x535/0x600 [amdgpu]
>>>>   __mmu_notifier_invalidate_range_start+0x1cd/0x230
>>>>   unmap_vmas+0x9d/0x140
>>>>   unmap_region+0xa8/0x110
>>>>
>>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  5 +++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  6 ++++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 41 
>>>> +++++++++++++++++++++--
>>>>   3 files changed, 49 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> index 59cac347baa3..20cfc8c9635b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> @@ -2022,6 +2022,9 @@ int amdgpu_vm_init(struct amdgpu_device 
>>>> *adev, struct amdgpu_vm *vm)
>>>>       spin_lock_init(&vm->invalidated_lock);
>>>>       INIT_LIST_HEAD(&vm->freed);
>>>>       INIT_LIST_HEAD(&vm->done);
>>>> +    INIT_LIST_HEAD(&vm->pt_freed);
>>>> +    INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
>>>> +    spin_lock_init(&vm->pt_free_lock);
>>>>         /* create scheduler entities for page table updates */
>>>>       r = drm_sched_entity_init(&vm->immediate, 
>>>> DRM_SCHED_PRIORITY_NORMAL,
>>>> @@ -2223,6 +2226,8 @@ void amdgpu_vm_fini(struct amdgpu_device 
>>>> *adev, struct amdgpu_vm *vm)
>>>>         amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
>>>>   +    flush_work(&vm->pt_free_work);
>>>> +
>>>>       root = amdgpu_bo_ref(vm->root.bo);
>>>>       amdgpu_bo_reserve(root, true);
>>>>       amdgpu_vm_set_pasid(adev, vm, 0);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> index 9ecb7f663e19..b77fe838c327 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> @@ -276,6 +276,11 @@ struct amdgpu_vm {
>>>>       /* BOs which are invalidated, has been updated in the PTs */
>>>>       struct list_head        done;
>>>>   +    /* PT BOs scheduled to free and fill with zero if vm_resv is 
>>>> not hold */
>>>> +    struct list_head    pt_freed;
>>>> +    struct work_struct    pt_free_work;
>>>> +    spinlock_t        pt_free_lock;
>>>> +
>>>>       /* contains the page directory */
>>>>       struct amdgpu_vm_bo_base     root;
>>>>       struct dma_fence    *last_update;
>>>> @@ -471,6 +476,7 @@ int amdgpu_vm_pde_update(struct 
>>>> amdgpu_vm_update_params *params,
>>>>   int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>>>>                 uint64_t start, uint64_t end,
>>>>                 uint64_t dst, uint64_t flags);
>>>> +void amdgpu_vm_pt_free_work(struct work_struct *work);
>>>>     #if defined(CONFIG_DEBUG_FS)
>>>>   void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct 
>>>> seq_file *m);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>> index 88de9f0d4728..c16579471f22 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>> @@ -641,6 +641,27 @@ static void amdgpu_vm_pt_free(struct 
>>>> amdgpu_vm_bo_base *entry)
>>>>       amdgpu_bo_unref(&entry->bo);
>>>>   }
>>>>   +void amdgpu_vm_pt_free_work(struct work_struct *work)
>>>> +{
>>>> +    struct amdgpu_vm_bo_base *entry, *next;
>>>> +    struct amdgpu_vm *vm;
>>>> +    LIST_HEAD(pt_freed);
>>>> +
>>>> +    vm = container_of(work, struct amdgpu_vm, pt_free_work);
>>>> +
>>>> +    spin_lock(&vm->pt_free_lock);
>>>> +    list_splice_init(&vm->pt_freed, &pt_freed);
>>>> +    spin_unlock(&vm->pt_free_lock);
>>>> +
>>>> +    // flush_work in amdgpu_vm_fini ensure vm->root.bo is valid
>>>> +    amdgpu_bo_reserve(vm->root.bo, true);
>>>> +
>>>> +    list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
>>>> +        amdgpu_vm_pt_free(entry);
>>>> +
>>>> +    amdgpu_bo_unreserve(vm->root.bo);
>>>> +}
>>>> +
>>>>   /**
>>>>    * amdgpu_vm_pt_free_dfs - free PD/PT levels
>>>>    *
>>>> @@ -652,11 +673,24 @@ static void amdgpu_vm_pt_free(struct 
>>>> amdgpu_vm_bo_base *entry)
>>>>    */
>>>>   static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>>>>                     struct amdgpu_vm *vm,
>>>> -                  struct amdgpu_vm_pt_cursor *start)
>>>> +                  struct amdgpu_vm_pt_cursor *start,
>>>> +                  bool unlocked)
>>>>   {
>>>>       struct amdgpu_vm_pt_cursor cursor;
>>>>       struct amdgpu_vm_bo_base *entry;
>>>>   +    if (unlocked) {
>>>> +        spin_lock(&vm->pt_free_lock);
>>>> +        for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, 
>>>> entry)
>>>> +            list_move(&entry->vm_status, &vm->pt_freed);
>>>> +
>>>> +        if (start)
>>>> +            list_move(&start->entry->vm_status, &vm->pt_freed);
>>>> +        spin_unlock(&vm->pt_free_lock);
>>>
>>> Question for Christian: list_move will take the entry off another 
>>> vm_status list (evicted, idle, invalidated, relocated). I don't 
>>> think this is safe without holding a reservation lock in most cases. 
>>> Since the point here is to maintain a list of PTs to be freed 
>>> without locking a reservation, is the vm_status really the right way 
>>> to do this?
>>
>> Oh, good point. This means we need to protect the whole state machine 
>> with a spinlock or use a separate deleted list.
>>
>> I don't see how we can easily use a separate list here, but we 
>> already have the invalidated_lock, maybe we need to rename this one 
>> to status lock and use it for all cases.
>
> Rename invalidate_lock to status_lock, then we can use it for 
> vm->pt_freed list, don't need another vm->pt_free_lock, this is good.
>
> invalidate_lock is used to protect list vm->invalidate and vm->done 
> right now, other vm list evicted/relocated/moved/idle/freed are 
> protected by reservation lock. Do we need protect all vm lists 
> operations with status_lock as well to ensure it is safe to take entry 
> from vm_status lists for unlocked context?

Yes, that's probably the best approach.

In theory we could skip some states because those state changes only 
happen with resv lock held, but I think it's better to be save than 
sorry here.

Christian.

>
> Regards,
>
> Philip
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>> + schedule_work(&vm->pt_free_work);
>>>> +        return;
>>>> +    }
>>>> +
>>>>       for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>>>>           amdgpu_vm_pt_free(entry);
>>>>   @@ -673,7 +707,7 @@ static void amdgpu_vm_pt_free_dfs(struct 
>>>> amdgpu_device *adev,
>>>>    */
>>>>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct 
>>>> amdgpu_vm *vm)
>>>>   {
>>>> -    amdgpu_vm_pt_free_dfs(adev, vm, NULL);
>>>> +    amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
>>>>   }
>>>>     /**
>>>> @@ -966,7 +1000,8 @@ int amdgpu_vm_ptes_update(struct 
>>>> amdgpu_vm_update_params *params,
>>>>                   if (cursor.entry->bo) {
>>>>                       params->table_freed = true;
>>>>                       amdgpu_vm_pt_free_dfs(adev, params->vm,
>>>> -                                  &cursor);
>>>> +                                  &cursor,
>>>> +                                  params->unlocked);
>>>>                   }
>>>>                   amdgpu_vm_pt_next(adev, &cursor);
>>>>               }
>>

