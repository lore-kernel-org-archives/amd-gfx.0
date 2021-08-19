Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52ED1C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 21:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12C1A6108F
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 21:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 12C1A6108F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 933086E8FE;
	Thu, 19 Aug 2021 21:13:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AAD16E8FE
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 21:13:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3+dmvEcnR/9WcbwbUZDAbYkJuUzw/HPgvkguOJspCxnMo+2MPVjYPtIHFX/2B5ossBwpeloYWvMG2EiWCiOAnTX+iikM4hFKPUy1l2ChDtXKu8mjiCj5qCfcxwrgD7E2N57L1OzDpE/kAAsQedCis1p5+W7HYeBzi7gP8/3aI6HhCZkwZMifsxmZ1pNNGUILp5+Otn6kEHBoGRPJcfK9EH9JkFyl+ppM1SNHNVtenkd4T+okIEFusXPRB0bHkWG+2F0qxtmGmGh64Y2CrtElWJ/Csb+JQg6K7uAY30S8md1G2+ajb30aTiuUudAt9TWDqH69v5j22OBDH68dvbA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXnhi5gzduP260eAL50lZjWAwpsj6kLgwRTPDrvkKpo=;
 b=WjaP6k9M9wURbi+RnB+L52pwM5TiIaLfnmf5rgwzqLQNpyqQHlP7sb4IpEDWvTHwErjIsJbaOaeevNYU14nXuVBHHBPixnMG2Yp0CFh1v4fKxuCgr6C2AQH1LK2b79UDmzL64OIQbavtC+0+luWalprj8tPQ/hhM1F2j4nOzdHhLQryO6aH9rmjBT/dYYc2lxjHNSdEgmrHLlqbcjspjvvFyvwxA5+zzVTrTW3DVGQVUIH7uszf56E+r0i7GUgC7Sk4nBqgV4htpsH4UNWJBjENgGa/ECj9oYMEs/u2ekCUAxqiu9gqSeL03JBj0ZfMb2VPKi2OXVirSMbn0Xoe/OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXnhi5gzduP260eAL50lZjWAwpsj6kLgwRTPDrvkKpo=;
 b=S1Km9zZ5VqZrhhzoifwWBGccVFWENEhE2wDK5FL0xYWdL297608q0kAHEeM4maSVChelfd5Eh639qg7pDyuHcVlsbR+Qf83eq0J1KB5Vv60q15meUpk4AeRmKhRKPYLxjAL1OyFA2XtdRv21WgvM7/XF1Mv71mTVUH40ih5EKwQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5227.namprd12.prod.outlook.com (2603:10b6:408:100::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 21:13:01 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%4]) with mapi id 15.20.4415.023; Thu, 19 Aug 2021
 21:13:01 +0000
Subject: Re: [PATCH 1/2] drm/amdkfd: check access permisson to restore retry
 fault
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210819145658.2254-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <e01bbdc0-87ae-510d-b4e6-40e1feff3822@amd.com>
Date: Thu, 19 Aug 2021 17:12:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210819145658.2254-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0077.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::16) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.47.3) by
 YT1PR01CA0077.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 21:13:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6461c09-48bb-4018-3d5b-08d96356201b
X-MS-TrafficTypeDiagnostic: BN9PR12MB5227:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB522744FA11F82251395AC4C092C09@BN9PR12MB5227.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QhIJks56FVbjGh7DJBuK9kF5h/1v4W1fW43BHh54O/B8o2nBtH6GYdH4FJZDQ2iOZXjH37sFFE7yRCo5rc9/K5+UqcTOIiUUY/asmiCR8ipoCLue6Bhwgz72SguBTxirJnKuNjwzdVvBKXPFmwoZpo4L8wJbgbA1bbuimnK/sJcf5Z5r7TVB7SqHfRmQJt6xRsD2QL7th89YWd3rGi5K9N0Dx/o3keOIIv/tI8WNr63w5le63UPz4ym9Me9BKEvhXBzXDMCEPO07Qt5GoDZBM9+vfOzmw13QhU/AXuTIJ72uj5sjQ7Y77m6KiVysKUMJA769rW6DTSf8Pwu9yR6VTwhc/nNXor6ZuuFzlex3ZSkczqfvY/P/9Gpmw8Vb/HG5G86hnmv/TORd+g6Jwf6Zb0YnVf3mrptvbPdsnmtriZ8HxiTu3kXBOiHTBkZAWTM+fE2ih4JhKLl6znXUGzQt+jaVjPKFrHK+TEf+d9nZYTdKI7oqYspEg92aVK7BeZxJ9ZDD4qKakNY/5K4Ert6Jme2AOVv+6fbWXNY5tb+HVyRR606DojcboYVrLR3SZvIXaHOywf8L0MEF5b/x7sucuBQgzqNo07eNiku1m2Fhao3XLNrhurNU77EtK14XwPkC5pjPhbId6D9l+ruzIZX6F6uafXhu7+Dzf8Jiep4lAxs7u70QAaZvIxVyTgSWlTa1vjejkGl3ApC0nxT+LANClrUX/ufKugrXvgQbD1eRW83xKISFnCI3G52Lw734dLqz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(2616005)(26005)(6486002)(66556008)(38100700002)(5660300002)(8676002)(316002)(956004)(44832011)(478600001)(186003)(8936002)(66476007)(31696002)(2906002)(83380400001)(31686004)(36756003)(86362001)(16576012)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3IrSEREY01scStIRnRETExXYkFVaFJ1c0J4RjdYTS9Rb0JmQkJwR3ExN0Vm?=
 =?utf-8?B?cWRjYk9XU1NmZllneXBDaTZ1TEY4cHBib1M2czFlZ1VtTHZsU1ptRGQxYUph?=
 =?utf-8?B?dk9zdXlVOXZ4dTVGVndORHNTeERERXM2RllZSm4rWnVPSTVWV3dRT29BZUlZ?=
 =?utf-8?B?N29QMlJZcGtGS1c5Z1FNZGljL2VMWE1ub2Urem5hNElKWStjOEpESWpadU5X?=
 =?utf-8?B?UVZUSFJHR2tacExqbmJBNSswWXF4dno3ZHZHZHZhNzl3ZmsxUzVubmhZOTdo?=
 =?utf-8?B?UHAxTDY0cjl0WHM0Rm5sNkJ6SzdGTjA5UVdCenIydWIyTjU2WDZVRzB2ekd3?=
 =?utf-8?B?alpzZm5XcWNNTGtLeXh0OXBGSDB3bDZiVVpXREJrSmpSTnpTeks1RzdQTVpK?=
 =?utf-8?B?cDUyVTdLWWh6c3lqK0FuTDRKY1VRN2UzS3hjb3ZBOHZUa2pDQnpiRnBjakJT?=
 =?utf-8?B?cjl5OWlIVjFic1ZVampQYzVVR01QczNqV1BGRlA5VXpSVjVhM0FGOFFOeWVq?=
 =?utf-8?B?bmNoRnVuaStvZ0E2OUJCbmcrQlc0Y3I0M3NBVndvbWNXcGxLUUtyNEF6dDc4?=
 =?utf-8?B?aHJtUGNuTDhYa2dYVGlpaE1lcGR6ZVk3VEVYOGlueGtQRFhScGhpS2o3dDBw?=
 =?utf-8?B?RkkzL0RkaVdab0NRSURBVzBuN2hGdS9PWEhoNjIrczFtWnY1b1oyK3Yzb0No?=
 =?utf-8?B?M3ZmMWpXYzlwVW5pdWdiOVhkY2wrdkFlV3EybkFPWFkxSElPakd1ZUZMZm9Y?=
 =?utf-8?B?RHlYM0N6NzlMVEFoVUpQdjZ1NWNDMGkrcm80RXlkRDM4M2hBWnIraE5MU3Mv?=
 =?utf-8?B?ZUxGZVdYeWNwSWlLbGU0RnRJTk9iMkhXOWtzcGxMNjFldTFIeisrcW9LZDB5?=
 =?utf-8?B?Q3RDY3UrRXhHVE5hREU0TnhQcW1ZbFd3S0pGVkVOVUQzN0pQbTZpUkQvMG14?=
 =?utf-8?B?RjJHOC9ZVlJXb01Ld3dpNVhGZUtnS1c0UjM0WDQxTFdGcnNrb0pkdDNIbjZz?=
 =?utf-8?B?L3Vuczl0TlZhQjkrcTQrR1VpN0JUK0xPczVKSldOdXlFMFJSbFl2WWl4MGJN?=
 =?utf-8?B?TEFLZzg4Qk1zbEJkekFQdmM0cnhnbVdaVVlyNVUrYTZoZDdWR1hlSkhSdHNT?=
 =?utf-8?B?NHdVL0NrVHp2VkNrdnFSZlhRSzljd2dsVGN5NU0vVXdxQ2t6QkJOL0lMTm0x?=
 =?utf-8?B?ZTNxR3NjMkdxMUh2WFc3RkRObTgyMjlSYTNoaHZhUFdnSUttWlF0Wjl1VDZ1?=
 =?utf-8?B?dSt0QUNNYW9tNTk2V0cralN2ZW8wZHNpM2l4ZnIrT1hrY09pekVuWGRvR3JK?=
 =?utf-8?B?S3B1eDZxaldqblYrYlVpdGhzRlE3bVFLQ2I2bnJDcXZ0Y1lBZUp0R01WcUMr?=
 =?utf-8?B?b29OOGZSdDlzZFRmRjRFMURtL3dpejREamx6eUY3UzIzZmt1cms1QVlSdTZq?=
 =?utf-8?B?eTV2RXYwR1BNYXJzeXhTSXV4UzVCNlJYSHVOc0twUHVIcE93aW9SeVdHQnBt?=
 =?utf-8?B?UTYzK282RE9oWnBwdWhEWkkrQmhzUjNta1prWEVrTjlnTTFvR2FuZXdFVTNB?=
 =?utf-8?B?dlp6M3g0azVabTJYUmF2S1gwZHBnYUgvZURxRjdraWFBUGlIWndMUWlNcTVq?=
 =?utf-8?B?aGlLbnBBUWZqZkZxaVNEbVRpOVBaMEFHL3UrcW1VOVFuNUFHcWZoSGF1TUdL?=
 =?utf-8?B?UGVpQkFIUmtINnduVmNFNlV4M0xZZEp5d0s2aHczbW9uT1o4TjhSejF0dWN1?=
 =?utf-8?Q?PHZM8dVJ5tRnaTs/hG7981t+SkRT2wXbvTjbnr2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6461c09-48bb-4018-3d5b-08d96356201b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 21:13:00.8580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqI3iA7gjVRsNYDltarGThXX0UZYOkY2Rt+N9wXauHTClwcoy4JEYmStkg06MPh8by25hjo1Nbrbg29z+o7Usw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5227
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

Am 2021-08-19 um 10:56 a.m. schrieb Philip Yang:
> Check range access permission to restore GPU retry fault, if GPU retry
> fault on address which belongs to VMA, and VMA has no read or write
> permission requested by GPU, failed to restore the address. The vm fault
> event will pass back to user space.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Just some nit-picks. Other than that the patch looks good to me. See
inline ...


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |  5 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |  3 ++-
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 30 +++++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |  5 +++--
>  6 files changed, 40 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 831f00644460..ff6de40b860c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3347,12 +3347,13 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>   * @adev: amdgpu device pointer
>   * @pasid: PASID of the VM
>   * @addr: Address of the fault
> + * @rw_fault: 0 is read fault, 1 is write fault
>   *
>   * Try to gracefully handle a VM fault. Return true if the fault was handled and
>   * shouldn't be reported any more.
>   */
>  bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
> -			    uint64_t addr)
> +			    uint64_t addr, uint32_t rw_fault)

Should rw_fault be a bool? And maybe call it write_fault to clarify what
"true" means.


>  {
>  	bool is_compute_context = false;
>  	struct amdgpu_bo *root;
> @@ -3377,7 +3378,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>  	addr /= AMDGPU_GPU_PAGE_SIZE;
>  
>  	if (is_compute_context &&
> -	    !svm_range_restore_pages(adev, pasid, addr)) {
> +	    !svm_range_restore_pages(adev, pasid, addr, rw_fault)) {
>  		amdgpu_bo_unref(&root)
>  		return true;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 80cc9ab2c1d0..1cc574ece180 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -448,7 +448,7 @@ void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>  void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
>  			     struct amdgpu_task_info *task_info);
>  bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
> -			    uint64_t addr);
> +			    uint64_t addr, uint32_t rw_fault);

bool write_fault


>  
>  void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 24b781e90bef..994983901006 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -93,6 +93,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>  				       struct amdgpu_iv_entry *entry)
>  {
>  	bool retry_fault = !!(entry->src_data[1] & 0x80);
> +	bool rw_fault = !!(entry->src_data[1] & 0x20);

write_fault


>  	struct amdgpu_vmhub *hub = &adev->vmhub[entry->vmid_src];
>  	struct amdgpu_task_info task_info;
>  	uint32_t status = 0;
> @@ -121,7 +122,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>  		/* Try to handle the recoverable page faults by filling page
>  		 * tables
>  		 */
> -		if (amdgpu_vm_handle_fault(adev, entry->pasid, addr))
> +		if (amdgpu_vm_handle_fault(adev, entry->pasid, addr, rw_fault))
>  			return 1;
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 097230b5e946..9a37fd0527a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -506,6 +506,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>  				      struct amdgpu_iv_entry *entry)
>  {
>  	bool retry_fault = !!(entry->src_data[1] & 0x80);
> +	bool rw_fault = !!(entry->src_data[1] & 0x20);

write_fault


>  	uint32_t status = 0, cid = 0, rw = 0;
>  	struct amdgpu_task_info task_info;
>  	struct amdgpu_vmhub *hub;
> @@ -536,7 +537,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>  		/* Try to handle the recoverable page faults by filling page
>  		 * tables
>  		 */
> -		if (amdgpu_vm_handle_fault(adev, entry->pasid, addr))
> +		if (amdgpu_vm_handle_fault(adev, entry->pasid, addr, rw_fault))
>  			return 1;
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index d4a43c94bcf9..cf1009bb532a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2400,9 +2400,29 @@ svm_range_count_fault(struct amdgpu_device *adev, struct kfd_process *p,
>  		WRITE_ONCE(pdd->faults, pdd->faults + 1);
>  }
>  
> +static bool
> +svm_range_allow_access(struct mm_struct *mm, uint64_t addr, uint32_t rw_fault)

I think the function name "svm_range_..." is a bit misleading because it
doesn't do anything for an address range. It only checks one VMA at one
virtual address. I'd suggest "svm_fault_allowed".


> +{
> +	unsigned long requested = VM_READ;
> +	struct vm_area_struct *vma;
> +
> +	if (rw_fault)
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
> +	return (requested & ~vma->vm_flags) == 0;

I think this is the same as "(vma->vm_flags & requested) == requested".


> +}
> +
>  int
>  svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
> -			uint64_t addr)
> +			uint64_t addr, uint32_t rw_fault)

bool write_fault

Regards,
  Felix


>  {
>  	struct mm_struct *mm = NULL;
>  	struct svm_range_list *svms;
> @@ -2440,6 +2460,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  	}
>  
>  	mmap_read_lock(mm);
> +
>  retry_write_locked:
>  	mutex_lock(&svms->lock);
>  	prange = svm_range_from_addr(svms, addr, NULL);
> @@ -2484,6 +2505,13 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  		goto out_unlock_range;
>  	}
>  
> +	if (!svm_range_allow_access(mm, addr, rw_fault)) {
> +		pr_debug("fault addr 0x%llx no %s permission\n", addr,
> +			rw_fault ? "write" : "read");
> +		r = -EPERM;
> +		goto out_unlock_range;
> +	}
> +
>  	best_loc = svm_range_best_restore_location(prange, adev, &gpuidx);
>  	if (best_loc == -1) {
>  		pr_debug("svms %p failed get best restore loc [0x%lx 0x%lx]\n",
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index e7fc5e8998aa..e77d90de08a6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -175,7 +175,7 @@ int svm_range_split_by_granularity(struct kfd_process *p, struct mm_struct *mm,
>  			       unsigned long addr, struct svm_range *parent,
>  			       struct svm_range *prange);
>  int svm_range_restore_pages(struct amdgpu_device *adev,
> -			    unsigned int pasid, uint64_t addr);
> +			    unsigned int pasid, uint64_t addr, uint32_t rw);
>  int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence);
>  void svm_range_add_list_work(struct svm_range_list *svms,
>  			     struct svm_range *prange, struct mm_struct *mm,
> @@ -210,7 +210,8 @@ static inline void svm_range_list_fini(struct kfd_process *p)
>  }
>  
>  static inline int svm_range_restore_pages(struct amdgpu_device *adev,
> -					  unsigned int pasid, uint64_t addr)
> +					  unsigned int pasid, uint64_t addr,
> +					  uint32_t rw_fault)
>  {
>  	return -EFAULT;
>  }
