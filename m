Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA46C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 22:10:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C60B661167
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 22:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C60B661167
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B6EA6EB29;
	Fri, 20 Aug 2021 22:10:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CE4D6EB29
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 22:10:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2CJRDvw4MgAWLRieSP60WVhBd67YP8We7nqjQQOYIrUDeorbsd3kVdaP8QtbaltNsxYG/NsOoX6rxItziqa3wR7ledZXk86aBNHsNYnKi3Dgi0sq+NCj4cG+cDgl79eRUfFv8NAHDpNQq3kYaEdAsqZXzsxX4wM4btXM6ki1ccEabSoRqz3t6s8wT+nGF/TYAqXf7KqMhr5wQpX5nFIXYALrVw9GK8W452ei8Eu1G5qagL3jODZQMrTExMeHMT5TYepAuhJLIUc9HvPBUnH6Ri2vKw2mLJSjwyH87M2n2jp0xTWDf1zKnk0DKVyDjh+RKsGtFOlN2y8sHgE1pPngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQqlIVMCtmdJo7wb24LIhaEqB6oQB9o/SenecvCa34Y=;
 b=d8S1ezaDTcP9Oc76VAbIUXPiuwt567UoVxOJ0oGGX0w6rumvAbk+7EoUOJJS8hpSnftU8K3Ys5c5ciUGuqJNJw/26MGsc20r9b4ywMT18JkitMpLWE0+/a206BWPDqkKuMjEUg/hSXm8l2TDgC2SQbDe7ZNSnUIO36iaQ2A++Dsf+QjoN94rLeuaFs0eiR5uwAfIUJ1Jb2zmrtOnhbPmczTWpo6O/fEF/CP63j2c3pzRryVOLB2kZfwZ4lkX2sUT3ODHCyONfoujP3SM4FQEiiraYTxO7S4njF571lFe+UggccsU8KNMEkN41/dppuZGYys+xvbhKS/02/Q2gozQTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQqlIVMCtmdJo7wb24LIhaEqB6oQB9o/SenecvCa34Y=;
 b=Ytv/F8lB9+ahS9bWDi8ryD3dd/0qXkwU9wqCPX7MNew9PKBZ6tdNednQjk5ovnnbwIuhpkvUrGbpdWRJ+cXeqS86nc5GLicktmChnCa8Q35RrfG1RnU9UfVkJbmjbVRqm4X9/MnoVBcFoghiY0m2WljB5KukDUbV/ybkmtDCYmE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5180.namprd12.prod.outlook.com (2603:10b6:408:11d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Fri, 20 Aug
 2021 22:10:01 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%4]) with mapi id 15.20.4415.023; Fri, 20 Aug 2021
 22:10:01 +0000
Subject: Re: [PATCH v2 1/2] drm/amdkfd: check access permisson to restore
 retry fault
To: amd-gfx@lists.freedesktop.org, "Yang, Philip" <Philip.Yang@amd.com>
References: <20210820183114.30710-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <678795d7-9976-401f-3da3-3e33bc819ed5@amd.com>
Date: Fri, 20 Aug 2021 18:09:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210820183114.30710-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::21) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.47.3) by
 YTOPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Fri, 20 Aug 2021 22:10:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a41b6af4-caf9-4365-6cff-08d964274166
X-MS-TrafficTypeDiagnostic: BN9PR12MB5180:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5180C749F5FADA70A9562DE092C19@BN9PR12MB5180.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BcL+LZcyslLZ6ugu2YTrtFpXmckOTcKY6TKb/mEMVeroL7tQE8yPueyjr2mJah/CKvD7wCvnJDSpVn4Kpb0EBS7iUNcT9tiSiCklccvP/ZOUV4VV/i4sSAhh1Qc5s0dMSCSQPnS2qusU0wBcpgbaJRh1Wfvum5p0fER/KoHkR6cKmfJr50jtVR0uAU4yecdyaxHugdAmzdHByh46lI0GFiLQihl638pwFSyPjT2Z2Xv2MAjUTT9QN3r0qKa0a6UCxXQtd3Dy6CWi0s+/TLx/8l5veaBYy6LplfNlp5wT+2PM3BJGtgkXG8/MYUtGrh3Kzjm33rNwuJ90jM4ga68Z4czJaMMBzDB+1Eb5WjcpW+0aWRqH1UaCx/u87BrnQFkZoVtS8I6iO1AtcxnC5UrBh9bEgQzGIQfKn8tk4T8b9sEutbEItemvIMWHzmWhaAjFuLDnrGBarM7uCZMwFPrnpPdNX8ZM+vKLcUTRFcOTTjO666z0BmGTlTBnXy3U7iJlKl1jaOPQ254KCbV0VEnM0muBXBL2R0iTaO4SaFJIpH41viR3fIFiE7umJ68JnwGnNNr/I6Kst7Z++2QGQ1NfWparlFDrgxFxpW5H01ZWcKyYFYZwGvpzMAibadzOy7HhxRkO3KaaM27/Rvq3UoQcJGFVyl1CLuxW9OBMsHLMsXmjRkr6oqwCyK6bCCYU2tnHP6iUskuXzSuCD/dx8vyX8UOxdt3MxksZoQl3uy34/1Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(66476007)(66556008)(31696002)(6862004)(186003)(2906002)(956004)(38100700002)(6486002)(44832011)(2616005)(5660300002)(66946007)(26005)(31686004)(36756003)(8676002)(83380400001)(8936002)(86362001)(316002)(16576012)(37006003)(6636002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D6ZtVYssEZP7WpEuRDMJoX61ZBuynRZgn4Upi1SzVQu9o4PcpqWhjP3IEzzsjo4hz1T6BJ7pl3AJr9EwHavN3AkTABL129Lxj/C0mQRzx60Z5t04WZl42KwHGaXsxKSIzRSYjM2PEFyEXG8hS3GawCi5CfI+ZCOjZx0AWBy/zs596gxx/vyLBFKCrPAmJYnUoS29HseO/A25LmMuHQGVLeJVJuUsI+eAQT5YJEJx2RXvBP/nK7bASOARfSysTlEGNi5jX2fckNrqzHOGK7FmMQBp2ZIvB0JKOwOvWJjqwC3h/zMhco2iRsvp49+aDZr/lKqlfdowuEElBSogEgVmDr3hdo2eVEeFFel0wskvC1afiYCbXYnyTg/dokA2bne4nKH1w8VrF02Tdn7hoEP0FBiG3hCHV0/iQ7TDEUN9OBHA6R0BeL3RU852bPfBwiJJa3uwu2+qAxhB0cFDra/DlkX83tzuNFbfjgZDJ/9u9Rt9grRXb5sjXh0CTucQB+Mn8CjCvQsgNZ3auDLuXoN7+qj29Lmzk+780sJqCVYz3113126eafzqerX7yEI6Cvzb+ZK23BNI/t0Y1gORWh8U7OjlVPeN2ssNwtJ6tNXqWVlOn9dpiwy3tfjoPQjKkKJgkL7esa7MqYSbwfn6c2uv/rOkuiRagPmgTsqSiop7935jnjhb2LI5Io8fC2MczyPoRFSuK3XippgHfWCSiWHkdf5BOQuTZZK0z6A+i+w6Q6y1dYitFPEBES7j9fgzAUmJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a41b6af4-caf9-4365-6cff-08d964274166
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 22:10:01.4325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Exc5NdX/TNk+UlnZTsfE0f6/HuUZtqWGy+6xaEMpN+ITKrZzqAC9RnvqhCeh177yyebHbZRdKkbtNzThykTcfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5180
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

Am 2021-08-20 um 2:31 p.m. schrieb Philip Yang:
> Check range access permission to restore GPU retry fault, if GPU retry
> fault on address which belongs to VMA, and VMA has no read or write
> permission requested by GPU, failed to restore the address. The vm fault
> event will pass back to user space.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |  5 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |  3 ++-
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 29 +++++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |  5 +++--
>  6 files changed, 39 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 831f00644460..bbb892d8f489 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3347,12 +3347,13 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>   * @adev: amdgpu device pointer
>   * @pasid: PASID of the VM
>   * @addr: Address of the fault
> + * @write_fault: 0 is read fault, 1 is write fault

That should say true/false instead of 0/1. With that fixed, the series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>   *
>   * Try to gracefully handle a VM fault. Return true if the fault was handled and
>   * shouldn't be reported any more.
>   */
>  bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
> -			    uint64_t addr)
> +			    uint64_t addr, bool write_fault)
>  {
>  	bool is_compute_context = false;
>  	struct amdgpu_bo *root;
> @@ -3377,7 +3378,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>  	addr /= AMDGPU_GPU_PAGE_SIZE;
>  
>  	if (is_compute_context &&
> -	    !svm_range_restore_pages(adev, pasid, addr)) {
> +	    !svm_range_restore_pages(adev, pasid, addr, write_fault)) {
>  		amdgpu_bo_unref(&root);
>  		return true;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 80cc9ab2c1d0..85fcfb8c5efd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -448,7 +448,7 @@ void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>  void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
>  			     struct amdgpu_task_info *task_info);
>  bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
> -			    uint64_t addr);
> +			    uint64_t addr, bool write_fault);
>  
>  void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 24b781e90bef..41c3a0d70b7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -93,6 +93,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>  				       struct amdgpu_iv_entry *entry)
>  {
>  	bool retry_fault = !!(entry->src_data[1] & 0x80);
> +	bool write_fault = !!(entry->src_data[1] & 0x20);
>  	struct amdgpu_vmhub *hub = &adev->vmhub[entry->vmid_src];
>  	struct amdgpu_task_info task_info;
>  	uint32_t status = 0;
> @@ -121,7 +122,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>  		/* Try to handle the recoverable page faults by filling page
>  		 * tables
>  		 */
> -		if (amdgpu_vm_handle_fault(adev, entry->pasid, addr))
> +		if (amdgpu_vm_handle_fault(adev, entry->pasid, addr, write_fault))
>  			return 1;
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 097230b5e946..a7dfb370f642 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -506,6 +506,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>  				      struct amdgpu_iv_entry *entry)
>  {
>  	bool retry_fault = !!(entry->src_data[1] & 0x80);
> +	bool write_fault = !!(entry->src_data[1] & 0x20);
>  	uint32_t status = 0, cid = 0, rw = 0;
>  	struct amdgpu_task_info task_info;
>  	struct amdgpu_vmhub *hub;
> @@ -536,7 +537,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>  		/* Try to handle the recoverable page faults by filling page
>  		 * tables
>  		 */
> -		if (amdgpu_vm_handle_fault(adev, entry->pasid, addr))
> +		if (amdgpu_vm_handle_fault(adev, entry->pasid, addr, write_fault))
>  			return 1;
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index d4a43c94bcf9..b6d1268bc38f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2400,9 +2400,29 @@ svm_range_count_fault(struct amdgpu_device *adev, struct kfd_process *p,
>  		WRITE_ONCE(pdd->faults, pdd->faults + 1);
>  }
>  
> +static bool
> +svm_fault_allowed(struct mm_struct *mm, uint64_t addr, bool write_fault)
> +{
> +	unsigned long requested = VM_READ;
> +	struct vm_area_struct *vma;
> +
> +	if (write_fault)
> +		requested |= VM_WRITE;
> +
> +	vma = find_vma(mm, addr << PAGE_SHIFT);
> +	if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
> +		pr_debug("address 0x%llx VMA is removed\n", addr);
> +		return true;
> +	}
> +
> +	pr_debug("requested 0x%lx, vma permission flags 0x%lx\n", requested,
> +		vma->vm_flags);
> +	return (vma->vm_flags & requested) == requested;
> +}
> +
>  int
>  svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
> -			uint64_t addr)
> +			uint64_t addr, bool write_fault)
>  {
>  	struct mm_struct *mm = NULL;
>  	struct svm_range_list *svms;
> @@ -2484,6 +2504,13 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  		goto out_unlock_range;
>  	}
>  
> +	if (!svm_fault_allowed(mm, addr, write_fault)) {
> +		pr_debug("fault addr 0x%llx no %s permission\n", addr,
> +			write_fault ? "write" : "read");
> +		r = -EPERM;
> +		goto out_unlock_range;
> +	}
> +
>  	best_loc = svm_range_best_restore_location(prange, adev, &gpuidx);
>  	if (best_loc == -1) {
>  		pr_debug("svms %p failed get best restore loc [0x%lx 0x%lx]\n",
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index e7fc5e8998aa..6dc91c33e80f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -175,7 +175,7 @@ int svm_range_split_by_granularity(struct kfd_process *p, struct mm_struct *mm,
>  			       unsigned long addr, struct svm_range *parent,
>  			       struct svm_range *prange);
>  int svm_range_restore_pages(struct amdgpu_device *adev,
> -			    unsigned int pasid, uint64_t addr);
> +			    unsigned int pasid, uint64_t addr, bool write_fault);
>  int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence);
>  void svm_range_add_list_work(struct svm_range_list *svms,
>  			     struct svm_range *prange, struct mm_struct *mm,
> @@ -210,7 +210,8 @@ static inline void svm_range_list_fini(struct kfd_process *p)
>  }
>  
>  static inline int svm_range_restore_pages(struct amdgpu_device *adev,
> -					  unsigned int pasid, uint64_t addr)
> +					  unsigned int pasid, uint64_t addr,
> +					  bool write_fault)
>  {
>  	return -EFAULT;
>  }
