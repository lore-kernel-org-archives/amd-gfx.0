Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15978C5475B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Mar 2024 13:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 774A610EDA4;
	Fri,  1 Mar 2024 13:29:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sI0i45/I";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D950B10EDAB
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Mar 2024 13:29:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=it+dacolRzSEQrjoFD4OEiN0/tpKPQNcdHjeZ6f2Ha03xijuX0LQvJvlTPm+PpXGxZwd814HDBOydCELKwLjWKU+ZscnRLpQtmXrVmXD3cQo8IG4sb3zMhDXCH2GsCkS1eFYALvDpjgtJQuIALZNXnVzvIEzSvXv0aG5EKCDlAuY6UeT9NhHTbWBzltRpkorPXYTpChx3PACvpJZ51aeOcsSD3NTW+o4xUqVXqUTu+usLQbVAZp2O8zHn6MLOQR6iOhf++GD9Pd1lSPhBYRa+IPaHLIM1D5OnE+9OstGZEFZICOgoCf90dRfg00VdoKDx0yvJfv26W2kdeWWxXfHuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cRr75kYPLdcjQgF2Ng4cSWLYMoonlGoUycCQaoJ7aA=;
 b=MPPMSAjsUu3311mUklcvnE78M+27c8r4kc54VcRSanh1oe1t0SLTfLnD6lTFCwTcFG7vblxgJjdtTFi6ZGLxgespZC1skeruk9k/wQ5tPkGTk3RB5mTIegu3X5PCIGBwE2SuT3ERjZn+/57ylgTwX4POOtLGvfrOHfd/Wn2aPz2S/x4dr0jvxLvvMnDKz4qCtoBRzRKneAnnWhnw1YUcUn33kesW4VpvQ3iF2/KXocIGo3ERI+yCAGH5F9hVQEBlSOx4qYkdnALtSG5ELsHbq40GzZsf4gvqSi0PmbS+aSoOjZydG7BfhRWf6ViE4K7B8xh8JcEyL377xG/5Tww2pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cRr75kYPLdcjQgF2Ng4cSWLYMoonlGoUycCQaoJ7aA=;
 b=sI0i45/Ih4dhtLgh1AUwvwi4nKjnjTxK0nCpLBtmbFHOpumrPzj2Q8DJGjr+fXoISH0ifEAIdLt6TyFU8SkJPa/chetguyBoIECBVWXeXAy6Dy7zmyDnOLJ4Fvy/ZeYEaO6DDLrzFRwJquQYDVoIUk0ODqozX94kX/h+jenSj7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6433.namprd12.prod.outlook.com (2603:10b6:208:3af::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Fri, 1 Mar
 2024 13:29:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7339.031; Fri, 1 Mar 2024
 13:29:30 +0000
Message-ID: <fdc41038-62e8-4aa4-8a7f-86ca09324362@amd.com>
Date: Fri, 1 Mar 2024 14:29:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] drm/amdgpu: sync page table freeing with tlb flush
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip Yang <yangp@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
References: <20240301110724.947-1-shashank.sharma@amd.com>
 <20240301110724.947-2-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240301110724.947-2-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0280.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: aab9ce93-f408-40cc-c6c2-08dc39f39fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 69wWmYy7ULUaJaDtuhSTdkTvcMXYwcyXq/TT9Lhc1iOl0E1Gk55pyz+MFQuYQHA2wQyFU0Qcc1hC78lkqfStc0NtraibY6cOSTPS5+WnPtSgc04SOEiXg1MlRYodJ/jydsbvVBB7QnGtuH/zZanzkT2y53LZppXolEdIHTt6ZXkKGrNCvn7Y+zx4Iw7hpIxKqAunsrGVquxOlh8pQ7I+yev670Gx12W78ljIihf75YtkOLaNwM881eksKWhklKppyzoi6NrmZJeGWMCKbzji7B9DiwC5LX2iEgs34NuydK7Qtk4YxztPKfR/ahbj+CqDAPr0u1wfj5JMy/12/IZZbev9dbSp5NQlOApEo69Zqy9YovppVusytkFF/nDBLyWt2WHxUPB1MMoxU5GjXtn9yd/IwhjOwUm6linZjk/SPNb6CAPswcdBmh4ypRCazQbsaflEb5nAgYiWdF0WL8vU54C9jwKLsJOR8qBNDRiQVAl6ETW4zUgki9RlUoy0Lb7ZKbDMV6aXv0Fus2UUSzp4L+Z1fLN8MoKWjbLuiiiUlyQ0G1ev8Xfqp5ZF3r7lOee07UVuy0Epdii8mfgQMsJmJ1mUClbI53fJUdOI/2B4bJnqndbWHwsgOojkz7wXxjhq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZURSSVhPRzZpcXFKM1RENUpmbTc4MVhKenVycktnWHl5WnAwaldvVEFNa244?=
 =?utf-8?B?M25XQzZqaEYrN0xuZmRYcWEvaVB4WmJKWElvZG1kWWNuN2E0NXQ5anp2bk4x?=
 =?utf-8?B?R203eU03Zjk4d0tOZmVoVTJPMElyUUhCeCszbXVXdVJVZTk1MXo3aEdnOStm?=
 =?utf-8?B?ZTlwR1pOajlVaFVrUDdlOTlGY1VSeWVpdGcwZXFxeGp3M0EzRU95ZDhWMVN0?=
 =?utf-8?B?eVpyMHJVbFl1WkpiTWtZWUpBRWt5cXQyc2pxWmczcW5jcVZ5M1BoS1V2SEox?=
 =?utf-8?B?bmdRUkZGWS9VT2ZIdDE2Nk1ZMVduQjRvM1FQMTNtZjdpZ3hRblY5bzlhYnhS?=
 =?utf-8?B?NVFrRUo1UkZhYmtJVk9QbC83dmFGWEtOQ3MwbXZaV3hKSUhndjI0dW5ITzJn?=
 =?utf-8?B?d1ovNlNXZWp6aWRvM1JmeW1NWXVuaXRia1JnNnpvQ1J5VmNjbTFCNWhLMyto?=
 =?utf-8?B?RFJScVJVZ25Xa0xTZlRqbitNQ3JHUXE2T0ZrTURMM1dxcnFLSWcrcVNxVk5j?=
 =?utf-8?B?R25CdVFlOXlINmE0UGRzVzkzVnJZeFgya25KZWY5Q3hsc0pXS3VIeU5uUnA2?=
 =?utf-8?B?b0VOYjNrZ3g3K2NwWlBRdmlKTk5WcEw4NlRRZm9yeXBpclRiT1FFaW5xc1lN?=
 =?utf-8?B?RHNxUDE4TXA4TldsUVFreFI1ZUQrZUhuZUtNUHJxNmtmM2UzUGNPNWVONUJL?=
 =?utf-8?B?ZXdQeWo5OWszKzRqbVpBTmJSTCs4NFFrdkpOZzZDZis3YU1FdVhtNkthSEtQ?=
 =?utf-8?B?V3l5WU44S1hxNzNQd2VUZDRoYnIzcnJXS2hFWU5QT09Wc0NTdlRkVTRSVnY0?=
 =?utf-8?B?aFVzekZPeGI3cDdBaGpuUGxsWithZW5tN01LZkFkeFJxYXdLUDl4ZVFkLzVQ?=
 =?utf-8?B?c210cXZ1U2hJaHZXYU9TK2dGbFZ5MUZPemJXNXZqTExVTUhwTUo4N3dkMy9u?=
 =?utf-8?B?SjUvaUlJSFp0SnZPSmE1KytaK1NNV3hmVE5ydzRGL1VLTDlSNUQ4ZXcvYWp3?=
 =?utf-8?B?eWw2akYxUURLaCtiUC9ZajMwUWltSnBGcEJxYzcramdTbzI0bXVHT3VUTGFL?=
 =?utf-8?B?U1lyVGJMYXR6bGlrZmR2RzQ4N1hsc1J4b1lxYmdka3lhTnI3R01LQUpicXhJ?=
 =?utf-8?B?ZVdYcUpQenYybU80MEd2VW50ZVlOekhyRUxKWXQwdjkvRmV4ZC9kTFNxcFlz?=
 =?utf-8?B?RVBTbldpb0k3SEJZUGdkeWY5QXdERFBBa0g1UVhXZGNlb2VoT1l0ZWFQVGN1?=
 =?utf-8?B?dC9aNHBxNVFwbnFFMDA5THhmck9ydkFiMnhMai9uZTcvbTFVRTBtKzFZUzZn?=
 =?utf-8?B?cnN6azNDd053VzdQVkpIZ1dibGQ3TVQ1dUxzY3B0VkV2Zm9jWDk0ZjJaYXBt?=
 =?utf-8?B?R2s2a2dQcFJYbkc2NlM2dmh2WmpVY0xZUnprOXRlMHlyZzdubHU2SXk3UTQx?=
 =?utf-8?B?ME9BWEdlYlRYMENvNUY5Wk5hQ1lqdjZCMTIxeE9oNkk1RDVuTmF2MW5RajJv?=
 =?utf-8?B?aTJHNVV3eFo0UmhtajMra0NGT1hQN3ZMeWY0c1VBVHNoU3lESTNKdHpuVVhX?=
 =?utf-8?B?ZjdBSnlTSWF2MXNjS3JCbktaMFp6ODVoTDVNVzBBMWNYc25xelk1c0J0Zlll?=
 =?utf-8?B?K1drZXBIMnJ3OG9rNml3WkV5cjc2QVI4b2Y2NzBuTVJpZGJia0Rhc1dpWU85?=
 =?utf-8?B?UW83OHNXQWh2eXFENTBnUGQ1SGxHMnlWVVBuVkZ3RmRQcGtJcDZOak84OUM4?=
 =?utf-8?B?RVlxelhEN3JVYngyMHBqTzlQM01EMHZHSmtUZmhjUUU1WU5YaEF5K1Y5TWhT?=
 =?utf-8?B?cysrNWZSbEJETG8vUnM4VUdDTlV1K1E2WUU1SXFoem84VEFNRUhvZktjOFh6?=
 =?utf-8?B?NzQzbXhoeFNNd0dncVBCaWhDWTJCc0pHeW81MHNzWm0rSWRUSFBlMUsyZGpQ?=
 =?utf-8?B?U1R2SThzOFBPZmtVRzVYbWxPVEFWOWsyNEhVNUo0RGdsZTFtcTJvOWJOaHh6?=
 =?utf-8?B?bkJDdXFxRjcvWExNTEJrR0RHUkJ0TmowanRINVk0TkxLNS9hVU5KemFuM0NH?=
 =?utf-8?B?TC9YMGVhdDg0bmtGdUlWbFNERGkzUGtZZmJZcHNhNnB0V2dZMmhpM1JocHdC?=
 =?utf-8?Q?dMaA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab9ce93-f408-40cc-c6c2-08dc39f39fc8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 13:29:30.2765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NM4q/+b8WkI8q9C7Q8NLN87CiRuKJHKvD0Wsn7EqNrI3SjxRaWpWr4PukRL809L2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6433
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



Am 01.03.24 um 12:07 schrieb Shashank Sharma:
> The idea behind this patch is to delay the freeing of PT entry objects
> until the TLB flush is done.
>
> This patch:
> - Adds a tlb_flush_waitlist which will keep the objects that need to be
>    freed after tlb_flush
> - Adds PT entries in this list in amdgpu_vm_pt_free_dfs, instead of freeing
>    them immediately.
> - Exports function amdgpu_vm_pt_free to be called dircetly.
> - Adds a 'force' input bool to amdgpu_vm_pt_free_dfs to differentiate
>    between immediate freeing of the BOs (like from
>    amdgpu_vm_pt_free_root) vs delayed freeing.
>
> V2: rebase
> V4: (Christian)
>      - add only locked PTEs entries in TLB flush waitlist.
>      - do not create a separate function for list flush.
>      - do not create a new lock for TLB flush.
>      - there is no need to wait on tlb_flush_fence exclusively.
>
> Cc: Christian König <Christian.Koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 10 ++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 21 ++++++++++++++-------
>   3 files changed, 28 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 310aae6fb49b..94581a1fe34f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -990,11 +990,20 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	/* Prepare a TLB flush fence to be attached to PTs */
>   	if (!unlocked && params.needs_flush && vm->is_compute_context) {
> +		struct amdgpu_vm_bo_base *entry, *next;
> +
>   		amdgpu_vm_tlb_fence_create(adev, vm, fence);
>   
>   		/* Makes sure no PD/PT is freed before the flush */
>   		dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
>   				   DMA_RESV_USAGE_BOOKKEEP);
> +
> +		if (list_empty(&vm->tlb_flush_waitlist))
> +			goto error_unlock;
> +
> +		/* Now actually free the waitlist */
> +		list_for_each_entry_safe(entry, next, &vm->tlb_flush_waitlist, vm_status)
> +			amdgpu_vm_pt_free(entry);

This needs to be outside of the "if". We also need to free the PDs/PTs 
in non compute VMs.

>   	}
>   
>   error_unlock:
> @@ -2214,6 +2223,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	INIT_LIST_HEAD(&vm->pt_freed);
>   	INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
>   	INIT_KFIFO(vm->faults);
> +	INIT_LIST_HEAD(&vm->tlb_flush_waitlist);
>   
>   	r = amdgpu_seq64_alloc(adev, &vm->tlb_seq_va, &vm->tlb_seq_cpu_addr);
>   	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 298f604b8e5f..ba374c2c61bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -343,6 +343,9 @@ struct amdgpu_vm {
>   	uint64_t		*tlb_seq_cpu_addr;
>   	uint64_t		tlb_fence_context;
>   
> +	/* temporary storage of PT BOs until the TLB flush */
> +	struct list_head	tlb_flush_waitlist;
> +
>   	atomic64_t		kfd_last_flushed_seq;
>   
>   	/* How many times we had to re-generate the page tables */
> @@ -545,6 +548,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   			  uint64_t start, uint64_t end,
>   			  uint64_t dst, uint64_t flags);
>   void amdgpu_vm_pt_free_work(struct work_struct *work);
> +void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry);
>   
>   #if defined(CONFIG_DEBUG_FS)
>   void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 95dc0afdaffb..cb14e5686c0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -636,7 +636,7 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
>    *
>    * @entry: PDE to free
>    */
> -static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
> +void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>   {
>   	struct amdgpu_bo *shadow;
>   
> @@ -685,13 +685,15 @@ void amdgpu_vm_pt_free_work(struct work_struct *work)
>    * @vm: amdgpu vm structure
>    * @start: optional cursor where to start freeing PDs/PTs
>    * @unlocked: vm resv unlock status
> + * @force: force free all PDs/PTs without waiting for TLB flush
>    *
>    * Free the page directory or page table level and all sub levels.
>    */
>   static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>   				  struct amdgpu_vm *vm,
>   				  struct amdgpu_vm_pt_cursor *start,
> -				  bool unlocked)
> +				  bool unlocked,
> +				  bool force)
>   {
>   	struct amdgpu_vm_pt_cursor cursor;
>   	struct amdgpu_vm_bo_base *entry;
> @@ -708,11 +710,15 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>   		return;
>   	}
>   
> -	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
> -		amdgpu_vm_pt_free(entry);
> +	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry) {
> +		if (!force)
> +			list_move(&entry->vm_status, &vm->tlb_flush_waitlist);
> +		else
> +			amdgpu_vm_pt_free(entry);
> +	}
>   
>   	if (start)
> -		amdgpu_vm_pt_free(start->entry);
> +		list_move(&start->entry->vm_status, &vm->tlb_flush_waitlist);
>   }

The complexity inside amdgpu_vm_pt_free_dfs() really starts to make no 
sense any more.

First of all ditch the usage in amdgpu_vm_pt_free_root(). Instead just 
inline the call to for_each_amdgpu_vm_pt_dfs_safe() to free up all of 
the page tables immediately.

Then the other use case in amdgpu_vm_ptes_update():

/* Make sure previous mapping is freed */
if (cursor.entry->bo) {
     params->table_freed = true;
     amdgpu_vm_pt_free_dfs(adev, params->vm, &cursor, params->unlocked);
}

We should basically change params->table_freed into a list_head and put 
all to be freed entries on there. Something like that:

spin_lock(&vm->status_lock);
for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
     list_move(&entry->vm_status, &params->table_freed);
spin_unlock(&vm->status_lock);

And then finally in amdgpu_vm_update_range() we should call 
amdgpu_vm_pt_free_dfs() to really free up all PDs/PTs (probably rename 
the function while at it).

Regards,
Christian.

>   
>   /**
> @@ -724,7 +730,7 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>    */
>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   {
> -	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
> +	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false, true);
>   }
>   
>   /**
> @@ -1059,7 +1065,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   					params->needs_flush = true;
>   					amdgpu_vm_pt_free_dfs(adev, params->vm,
>   							      &cursor,
> -							      params->unlocked);
> +							      params->unlocked,
> +							      false);
>   				}
>   				amdgpu_vm_pt_next(adev, &cursor);
>   			}

