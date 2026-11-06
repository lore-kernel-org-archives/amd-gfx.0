Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C55A606A329
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=foWvJaYU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99D7010E9F3;
	Fri,  6 Nov 2026 11:48:46 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B4E010E3FC
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 11:48:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9mjI5A/aooQlBDr+/mKtqh0ajEMGiHXo9iR2I0Iz5M+8p693kRvCxOE0kVyU4DTPuI9vjEpAY/hHHrL607fSjRqkxiG/t3PAH75bKQ7rweL1Anwiz7FKZ7uB9h3N7T5whDUNzW6/Ni9v5zsLgSvMmJZKJ9eLcv8qv4gjcjB4cHaNeN4mjyKF3sn89SFhUwHCbIDm8o6mTj3J6z94MiyKsth0qxFhO6GT1vIQlTVfTaWj+1D88GbZuV85ixibUuOpASPrgEfyzWUucjCdnv+N8MqlTzPHMJUdrBy+lqvaQhvxEJ92Dgwxrlm3E7aukQMdzsyM6XhyYx4eUAM9Xz5uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVRkzGmScJYDadXp6vI6GR7J9qM7KQla8hXKqftdiqc=;
 b=ZhyUwSlI/lKlQO6kD/G3jOfN2tsXl6YIxyMOl9tuFjjIqc/69pIsa6TcUb4LGols6PsL5oADWq9PTq44p4DA4uJVJ9JcYj2eNZQjUGXNVxyCrwCFztEmlr3g9XqirZd/UeWPVItQKpG9L/JbG64UNSiIH3rHwVGlldri0NDSm58klSlEPm+8uUfSnkbeN3brdqXNaHmxnVW23CoypGJEev4tU3xvhxpYITsfeyEWBK65t2qcpXjmPXTgkDBROYUWKIm9ZB6KK6tmaPQoiNb1bYBg2c4rpIxv42YKCFqQtD1gfw1b1O4UF2Z/+gmbyFVGa4yDwk5jE/ZTSL//AO8seQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVRkzGmScJYDadXp6vI6GR7J9qM7KQla8hXKqftdiqc=;
 b=foWvJaYUqprzNTVqsnwTcX19tOPMf2dCNOHVIP1d1UwfLXporb4YiThATCvLHw0U9dn0jQTp19A9fQ6mtftBMh/57ISY0SE0YIDizmJjQTDlsgvtlnXPeoikK581Ik8991pqRmlaJm6SGDpEqMwXSbxULCc+idX0QQnkp40O9Ac=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB999106.namprd12.prod.outlook.com (2603:10b6:8:301::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 11:48:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 11:48:37 +0000
Message-ID: <39444677-91c5-4011-a4bc-72b7e948dfc3@amd.com>
Date: Fri, 6 Nov 2026 12:48:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: don't take a per VM kernel BO for a page table
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Lijo Lazar <lijo.lazar@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
References: <20261106095608.1538768-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261106095608.1538768-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB999106:EE_
X-MS-Office365-Filtering-Correlation-Id: f0441c77-2757-4013-d53c-08df3bfbe4bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261026121527099003|11063799006|56012099006|261021123027099003|261022075727099003|261009223027099003|261022105027099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: sFrck4cwiAiUrJNoRzRrHPhx5E9P/xNM53r89UyhNTyBKI5orY6t1FkmH6tC+Rt/XCiGQdlsY3dGWmQolFxMabQtkpY8/wl1k93xD5CoJhHfKF68kNfm8J5YI0FTQroRziOe4+/mbyVDq9efZ+qwMd+ohbB+6XJ7eCxg5rKAPhRzSZNV4vyb9OqvPi0p0BOTS/9io9Pl2NgutQkE2rV3Z6JSxcjbvy5JgQuVtrO41QBl3uoGf/zoBHC7Na3fjlI20rsDcLzJ6iGT7wB0v2KrkG7pnMfGl19t8hDnEC5+yfzjVFfCIb0KnPwkzr2/ny2OPlPgafGlvREU/0RsLT43MVGD4RbGNwHWufD/7zTVUCkol3rE2xzlvA1gJzeLXpTT0X1ksm/k/T0l47Bmrwe9L0YXA7Vm0vWAaujopR4wcgk2Rs699Mas36QTvW0EHKKk2JYLAaWYEziSDKTbs+yrK5We/svNKGUzo/UQkbjfTvWLehAWbO1R8vzzJJz3jhUtxpSWKjwExiaQm3gCXaKpqjw7pSjVwWVx9llWvQTFrFrN4fMkb5uQoArjvgV6T2qzIhvLiW/d4uDao25CRoDuU0PaU3B3bEZM4fLZJGwGdIPDvyAylywPAWehkPHUeyXrxU2A8BJbm6XIgo8Y7XM/Hs3PDorUfrWq4mQi4U4rD1Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261026121527099003)(11063799006)(56012099006)(261021123027099003)(261022075727099003)(261009223027099003)(261022105027099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXNMbWxadDVqOCtuYXRmaS9QYmNaR0g1WlcwN2szaEJPQzd3TjlvaFJZL0xl?=
 =?utf-8?B?VVpyRlpBVG1QU1pQSVVVQ0NpdUZMekV2V1pmZGcreGVDQXdEdUlQV2J6V2s4?=
 =?utf-8?B?SkJ5c043K3hkcUFGR1RVTFZFQTBBcXJUMjhqSmFUakVYRHFwOXFkOXMxWjFh?=
 =?utf-8?B?SE5STStoYVFMa2ZhbDhUelBObWtxLzRQSFY2aStCaExaTUUzOVNKQ3Z0Yi9o?=
 =?utf-8?B?QnRXRzVXaytEOEpObTgyVjFRRFU2QzdtS3JCTUREL2NhdElGb3pEblpnL0cr?=
 =?utf-8?B?eEZWVGl2bGtCTWU2Q1pEOWttTHh1d3BxRGFMSFZNOEJJUkJtUytKdm02Vy9S?=
 =?utf-8?B?ZnpwdVA0bmdrMjgxQlp6MmxIVmdJMEdQdGg2alg4UUVMeUoyUFUvdEdDS0JH?=
 =?utf-8?B?Znd4NnhGbTloRFdmUS9IVzZnRThIK3NvTmR6TWs2K1hhQTF2N0t1SUtibENy?=
 =?utf-8?B?ZHpyeDE1NEtId2d0OG5zcFNkbzBpdG0zQitTdFNGTjJuRTAveDJuTDlnNmh2?=
 =?utf-8?B?aXB0VTFLdlEwd1Fra1pEVkg1NGhxdFpndUxMb3Jpc3UyVkZ0V3dwNGl1Z2p3?=
 =?utf-8?B?Y0JpbG5QRG9hK1FYaGg3VlNjUjJHUjlKcVh0bWJnZC9QM3g3dmxCU3ZkZmVn?=
 =?utf-8?B?MTBlVGtnL0doTXZveGJHbzRyRXZXM2MwNG5Fc2xrQlZMRGRTQVRQbDhXcjM5?=
 =?utf-8?B?Ymw5eUNQdmxBQmtQaCtmRnc5YlFuTW5XeitPalRib3FKemhsMVNGQk9qbENq?=
 =?utf-8?B?S00xWTlSZXRqVjFqdkpnRTI5V25hdXc2NFhqa2NiUW9vNU11ZGswcmFUMDRW?=
 =?utf-8?B?UjY1LzFYSWx6Y2Q3UmN3YXBXNEpPbENBMXFEZkU0aDlaUk5KZDNRbmFwUDNW?=
 =?utf-8?B?TWZqV0J0UmJidG5EVTVyc3M0M2RxWDlMUmhkN1h3ZFlDajlTcVpDVXpQMW1w?=
 =?utf-8?B?Mk92aElPRVBIWlRZejhpb3RaVDY5bVdkZE16b1JhTUNKem1HUW5OclFIZ3dG?=
 =?utf-8?B?R3YwNEFreEs1Ujk5Q1oyWlNRYXZoL2JSL3Z3OXJCajVQTjRUM3FwMi9Wa2Nr?=
 =?utf-8?B?ZjQ2dE1pN2lBcUsvU2E3bUZ5N09ZL0Z3M1BEKzg5ZTFkb1Fvd3E1eVd5cG9Q?=
 =?utf-8?B?RSswdnFMRjFLNDd2Zi9QUjhDM3V5WVhaeHpMb2ZvdUVBczM0R1ZsTk9yQklS?=
 =?utf-8?B?Y3NqNTVQaWI4UjJmWGRnREZMeWVId2EvYXBOcUswQ3FIOWRpdk40TUczSEx5?=
 =?utf-8?B?amJHTlRBdmc3SThWa0JLUERqTXJQL2l6YzV6RU9CcW1Pdm9qRnUxWFYrYTJT?=
 =?utf-8?B?WEE0UExHQU1iMXdVNVBPMVhtNm1WL0VlUTJVazFzZFhEV0YzQTFPcWhKeFZh?=
 =?utf-8?B?T1pPQzJ6VG9tdmZUZTFKNm42VUVmMG0wTzBFVFM4NTZRZ1ZpZFhSMmtmbjVE?=
 =?utf-8?B?dnFuc0IwNG1MSnZQTEwyVGFIUnQzRGx1ZG45MEh0MzMwOHJ1ZkZaOVFZQUk4?=
 =?utf-8?B?MTZsRGpRQmpRRkwwRkNrcmc4cnIrKy9pL2l5YjlyOENoZ1JnZVE4ajdtUUh4?=
 =?utf-8?B?QnY0WDBvS0tMSUtTKzVWRmFTRnQ0NXVkQmJkVWVrMFFYSWR3eVQ4NUgzZEVz?=
 =?utf-8?B?WmhzaWFXTzZMVThYQi85d2Zwc0tDN1pIQUVLNE50emtSQitzQlppemhYbXR4?=
 =?utf-8?B?WTdRUEZGMExtSzV5cjdVRDZTeHBIdmU1eWVqTlgxM1Z1TDZzdlU4ZlNuNDB6?=
 =?utf-8?B?R2p1VGxISjVQTFlEckNsbDVtRHdndlN3RERRbHRqZFRFUjV4QjFYT1RuVm1G?=
 =?utf-8?B?Uzd4TjdXbVU2bExtQWIwRm15Y0U2NnpvVWo0VGVGek9IZkZwYXZCYkI5WnBQ?=
 =?utf-8?B?dnhXSHdJMFRQNjFHeVpXN01Qc2tsdXM4MTkwODdaSS80eTZNOERYVFRmenhz?=
 =?utf-8?B?ZHpueHZiaE5KVlVnUDNkL1owbjRCRXBtMG9TdVkzYmRCaHV4dld6Y2NnYzJi?=
 =?utf-8?B?TW1SYmVqNTQvc2J2MHA5WmRKNEJYUWgvMlR0QURWVjVUWHdBMkFvS2NKMFVZ?=
 =?utf-8?B?QWRHVkRpRjVhT3lIRG1iVTZHTVo4cDN6ZXlVenp3VUJoQ25abm8yQTVhNWRR?=
 =?utf-8?B?dDcxOHFyU3hHV3NxS0NWN1ZWeXNDYldveTZEd29TanJxN09MWkN2ZkNZN2Nn?=
 =?utf-8?B?cHBiWTI0ODUrbWtGMmtUQnhLeFQyOHZrRHl4N0NxODhEbnBWSTN6eHRPb2N2?=
 =?utf-8?B?M1VsMzdVWHhDOGllY1UrM0xHWWJ2dFpQZDlRTElodGoyUDBzSmhyQXFPVzR1?=
 =?utf-8?Q?QU8kaW4xIlFwvdFf5Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0441c77-2757-4013-d53c-08df3bfbe4bd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 11:48:37.1960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PK9KTM29r57gMAIGS6LjU/F5mJ7DdIDaX3AAFfrHiYHhAbJENu43/SM9bS8Chzxb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999106
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 10:55, Jesse Zhang wrote:
> amdgpu_vm_bo_lock_lists() puts every BO which shares the resv of the
> root PD and is a ttm_bo_type_kernel BO on the page table lists. The
> CWSR TMA BO which amdgpu_cwsr_alloc() creates for every opened render
> node is such a BO, so it is treated as a page table: after a VRAM
> losing reset its bo_va moves to the page tables needing an update, and
> amdgpu_vm_update_pdes() tries to write its PDE. It has no parent page
> directory, so that fails, and fails again on every following
> submission of the file.
> 
> On navi48, submitting on a render node, then amdgpu_gpu_recover and
> submitting again, also with a new context:
> 
>   amdgpu 0000:03:00.0: VRAM is lost due to GPU reset!
>   amdgpu 0000:03:00.0: GPU reset(1) succeeded!
>   WARNING: amdgpu_vm_pt.c:671 at amdgpu_vm_pde_update+0x329/0x5d0 [amdgpu], CPU#0: vmreinit/2629
>   Call Trace:
>    amdgpu_vm_update_pdes+0x262/0x5e0 [amdgpu]
>    amdgpu_cs_ioctl+0x35c9/0x7a00 [amdgpu]
>    drm_ioctl_kernel+0x180/0x320 [drm]
>    drm_ioctl+0x530/0xcb0 [drm]
> 
> and every command submission fails with -EINVAL from then on.
> 
> Don't look at the BO type, let the creator of the vm_bo tell whether it
> is the root PD or a page table, like amdgpu_vm_bo_needs_update() already
> compares with the root PD instead of looking at the type. The TMA BO
> stays a kernel BO which userspace can't mmap.
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 11 +++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  2 +-
>  3 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 2ba33212d507..a7d6f4b1efd4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -162,7 +162,7 @@ amdgpu_vm_bo_lock_lists(struct amdgpu_vm_bo_base *vm_bo)
>  		/* No extra locking needed, protected by the root PD resv lock */
>  		amdgpu_vm_assert_locked(vm);
>  
> -		if (bo->tbo.type == ttm_bo_type_kernel)
> +		if (vm_bo->page_table)
>  			return &vm->kernel;
>  
>  		return &vm->always_valid;
> @@ -408,15 +408,18 @@ void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base *base,
>   * @base: base structure for tracking BO usage in a VM
>   * @vm: vm to which bo is to be added
>   * @bo: amdgpu buffer object
> + * @page_table: true if @bo is a PD/PT of @vm
>   *
>   * Initialize a bo_va_base structure and add it to the appropriate lists
>   *
>   */
>  void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
> -			    struct amdgpu_vm *vm, struct amdgpu_bo *bo)
> +			    struct amdgpu_vm *vm, struct amdgpu_bo *bo,
> +			    bool page_table)
>  {
>  	base->vm = vm;
>  	base->bo = bo;
> +	base->page_table = page_table;

I think we should rather have a separate destroy function for page tables in the BO and then identify them by the bo->destroy pointer.

We already do it this way for the user and KFDs svm range BOs, see function amdgpu_bo_is_amdgpu_bo() and the destroy stuff above it.

Apart from that the approach looks solid to me.

Regards,
Christian.

>  	base->next = NULL;
>  	INIT_LIST_HEAD(&base->vm_status);
>  
> @@ -1805,7 +1808,7 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
>  	if (bo_va == NULL) {
>  		return NULL;
>  	}
> -	amdgpu_vm_bo_base_init(&bo_va->base, vm, bo);
> +	amdgpu_vm_bo_base_init(&bo_va->base, vm, bo, false);
>  
>  	bo_va->ref_count = 1;
>  	bo_va->last_pt_update = dma_fence_get_stub();
> @@ -2704,7 +2707,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		goto error_free_delayed;
>  	}
>  
> -	amdgpu_vm_bo_base_init(&vm->root, vm, root_bo);
> +	amdgpu_vm_bo_base_init(&vm->root, vm, root_bo, true);
>  	r = dma_resv_reserve_fences(root_bo->tbo.base.resv, 1);
>  	if (r)
>  		goto error_free_root;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index d8e17f493f61..a58797e2b590 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -224,6 +224,9 @@ struct amdgpu_vm_bo_base {
>  	/* if the BO was moved and all mappings are invalid
>  	 * protected by the BO being reserved */
>  	bool				moved;
> +
> +	/* True for a PD/PT of this VM; constant after initialization. */
> +	bool				page_table;
>  };
>  
>  /*
> @@ -470,7 +473,8 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
>  				uint32_t flush_type,
>  				uint32_t xcc_mask);
>  void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
> -			    struct amdgpu_vm *vm, struct amdgpu_bo *bo);
> +			    struct amdgpu_vm *vm, struct amdgpu_bo *bo,
> +			    bool page_table);
>  int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  			   bool immediate, bool unlocked, bool flush_tlb,
>  			   bool allow_override, struct amdgpu_sync *sync,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index c73eb416c0e2..481f697ce9e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -542,7 +542,7 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
>  	 * freeing them up in the wrong order.
>  	 */
>  	pt_bo->parent = amdgpu_bo_ref(cursor->parent->bo);
> -	amdgpu_vm_bo_base_init(entry, p->vm, pt_bo);
> +	amdgpu_vm_bo_base_init(entry, p->vm, pt_bo, true);
>  	r = amdgpu_vm_pt_clear(p->adev, p->vm, pt, p->immediate);
>  	if (r)
>  		goto error_unpin;

