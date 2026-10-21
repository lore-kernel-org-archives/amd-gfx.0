Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5560606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mb/onDAV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D00B10E285;
	Wed, 21 Oct 2026 12:47:49 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012015.outbound.protection.outlook.com
 [40.93.195.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5398510E285
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 12:47:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XO2wkudn8M8UdAmdcyHDVP8ybxJs+gCj11AJLQaqK/2nFfoiLSxRDwD3zrE2r5ZcYB9wMzHG3U9L1hIl3N7ZwpvsHAR5HhqzrLYEnVRrSoMnJ/90cg8hSwmIUArSZ9NJNzbAcQrg2iCJtVdYJP5800/djY9APqMzKjsl4ln9pKx3YqIU0tKsfq6ICcth2IFzbgVdngwoVYnHP69e84DRgg6lZD+v01zfRHzBs3ZwV8MeY26Ib6/g0QStL+P1D1OvKhamWR0zfNRe1u0W78k1v9TmTOwT9wAKhWoJU3vSNs2j/6L/+N7S9f/Ld2S0f7gXGNnC0PoA6dnCtaSX8Ngebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UmCjXyBvmej5Xusyy1BJNJ9ZCEoG+PnwKE8I4rKTRk=;
 b=ObiyzXmjuG6nl7LBLztXrre7Pj37qv22hwldJoBz3Tm9O1hF3RTS+PUuDlk88lqLKgJ0I/Kz5DI4v9jqyu6ljD0QeDl0yg41bhXJfY0wdnlU6E/9K2XUOu/v9t3faZz4xuAfWAtUR9YZ+HfLocGSnH+ItH1WfctIG6n+RalXjDrWV9WapyCTwZAS51fELUKrbLHwNxfpzitKzv2EQ1SGGTt9Vd2u7ECCkhFE9ikLScDuXG6ZJIHWlRrP/H/Yw64lf7ACakJWgGVCS6cLQ+GUUouqatTuCJnMoct30DCthfrFsFALtn8JJ6Y8RnvieQo4RtHSFhykkmDCBNfTFSapHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UmCjXyBvmej5Xusyy1BJNJ9ZCEoG+PnwKE8I4rKTRk=;
 b=mb/onDAVy4cftnaGuiU5xzJDOMHpNTVQ9quI9m2eFkEB0NcpS4SsKBJk9YZodoiX+h9yvBdqHhC8v+cVPZ24N3Nn0PQ5/AUvYib7uKegZCp3ZRKt03bzpMrjgr8J9xyNnvLTIWL5D+9gl7DpcMPRpSpXJPbHFLaRE3PZSU/5fv0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 12:47:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 12:47:38 +0000
Message-ID: <49be63ad-9edd-4279-a908-d7aac2022384@amd.com>
Date: Wed, 21 Oct 2026 14:47:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] drm/amdgpu: don't wait for the SPM VMID's jobs
 under the VMID manager lock
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Prike Liang <prike.liang@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
References: <20261021051033.3287259-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261021051033.3287259-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: b61e6db7-fde3-4ca0-44d7-08df2f717cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|261009223027099003|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: BzTbBm+0ndrxEjDvh3Np+j0a333NKBlrc/Mc2yq/sUomtgPt9DpNSs29VmR4ifD1Hza1ZrEcT/U5AGKqHT/0kZaKMaKT9k1Y1iH06x/b91L02P+LNA3uoi6hmEjmpZVNgAeSL3mSTbTFSqj59qexCb0F/BEmqT/UNkVFW9LUfil/UxHiS/W2xarxWba4M0Vt1Qpih2PnIck1BlEeB7OJcM6qUQvFsFY/nAgAz3iZxtWWkT2pdQh9YHEDEEbJId5tUXKh4By4GFg5QSxBXb3YTFxPqIjJlhl6NfefuI/DsXfOT4Uc99y/mMqXK8M/AeBWPaQQeJ94AtysYxrglGpfoGzyAfJfRu5OpTUaeu40KDTtOdNRAznGUmFbgaQ1/xatX5+uiIXCj/Lj63Pvn/7zVfh4ifSp+2Lkd7p1Ktgsf31eSyVIxeHV3s9Wr/IahbbbdT/lMjEAeRSrSOeltkhdqDc2foQWJMVCJulovw9SlzUplS/H5Fe1EW/rL/bAdecMFb0VK6rCg19mi4Mr9wA1I8vbs22B7ZaO+OuKN0eobiyW8DrJyiS4afzHOoL0ddIZiZxZpJ1Sw2pLh3VkEHp1fKVuOARComoGn/ZZpQ+fV9sbh/tm/WDP5dhFIFmTFQ0evwJFFw2hET4UDnNUCAor2cEWP6NfB+CsEPnC7LH2cCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWhyenFxOFQ2V2RwTVp5c245UWZXVWszSzFiQ3dBUklRYVFzSHYrQUZnOWxj?=
 =?utf-8?B?dnpaMnN6TTkyYnBVQ1pnZ3plVnhNdi9QYzJvODNINFlLckNvVjZGeVhKdUVk?=
 =?utf-8?B?OGJsamljZ29sRWl5WUszVHIxbVZOcnZkVndDODdJUy94SDRMS25vSUcvZHN3?=
 =?utf-8?B?SWY0UEZKQ2tZdUNCRnhDcy9peXcvajhhWlJMNnZEMnhPOWQ3TzVENklHUUxI?=
 =?utf-8?B?Ujc5V1JRL1NUTm1rQ3oyT3FQanZ1N0R1S3Y4SC9hVS8rSzJmL25OV2t1VFZ1?=
 =?utf-8?B?cWtXM0c5WCtaQlMvbDk5K2RFcDRZeDYyaS90QkZDT2czZ2RpV2ZUb0JoSFN3?=
 =?utf-8?B?My9CaGFnclFmVGZqSTNJU1JoclJuckJRaG02RDF2cVdoOUJBQXZnYkZsRDhI?=
 =?utf-8?B?eWFSSVMzUU04REJtdjJLZVlhWlpET0g0K1V2Ym1QV1Nkc1BvSXFUMXNJRXFF?=
 =?utf-8?B?M2hNU0RHOXdGSTRtVDhiT0YwTGVUanhvS1N4QVdzL2N2YlQ0ZXFqSC9XUk93?=
 =?utf-8?B?bjZDbzNRVTJxWmN6M3dvOU96cHRYM3NnODlZeVA1eVI5VGo1ZTV6Zk1KWkx1?=
 =?utf-8?B?SmFIZnM3S1Mxb1VrQ2wwdWhaR2Y0R3FhYm9DUFZNQmt0SnN1UVRnYWhpNVZQ?=
 =?utf-8?B?eU9pS0xkOHhRQmE3ZkRlNEo0Y29yaGFKL2o5dklBeVQ0MW5qME1TOXh6VFI0?=
 =?utf-8?B?R00rQkE3ZXppMzYvalRCckNWU3lKZlgvcmVEUzlFZXVNWHdQRkJuUFkycXp3?=
 =?utf-8?B?aDRJSkRJTGxoNjNCbnNoMVQyeVlQOGZjU2NiOENhTTQ3aUxWRTg5Z0h6T0oy?=
 =?utf-8?B?bGZkNEdwakZDOVBtZ1RJcXRyT0tpZWJkcmNRNFdzUE5mRHdqSCtwVzhQTHc2?=
 =?utf-8?B?NXNyTTlibVNaMkdKMVYzR1QyVndwd3NMVTZsTVdMNWVJY0hiN1hhUHNmZW84?=
 =?utf-8?B?UDJxV0JFOHJCaDBlN3NwNjVwSmRnZ0x0dnFEOTFYNEFrQnl4cHJHNWZnMENu?=
 =?utf-8?B?VkZ4dGpONXJsdVhiczZkUlgzUkp0T1BBZnRONU5OanR5MUQ0MXZPNXhIMms0?=
 =?utf-8?B?a3d5Yi9tNExUL1NFTklxTzd1anBRaC9HQ2h3VUUwZXBXdVBuT2ozdzlvcC84?=
 =?utf-8?B?eUdCeFdMMEFMVnJGTEc0M050Zm9OT2dabGZURE1zeFlZRll6U2ZKN0NlL09D?=
 =?utf-8?B?TDlQMEZYNUhZMDhTQ1lLcURkejZxQ1hIQ0JST2c1V3FLNklURGViQmlwZTY2?=
 =?utf-8?B?MUlrcHpJWlNnZWgraGFtQ0ZGNVQ2RjZ0MHlPQjBSNHY0elMxUnk4dCtJVXJP?=
 =?utf-8?B?dFV5cURJVS8zQThXdzBYN2s4WUM4ZUMvYkdvT2tOUXNNdkhzdWhZbmVhaTVU?=
 =?utf-8?B?eG5pb3NIUWNzaUpEcFkrVzkrSmFQWWNjK1dKdmhFYVptTk4wNk9TczhuTVhp?=
 =?utf-8?B?YVlpWkY2M0psRURoVmF3ZXdsK0VEZVoxVWY4VEVycnNBc2tSUXVlRFN6L3RU?=
 =?utf-8?B?UWJQcnF4ZE1XUHJabVN1NlZUR01XeVRJdmVveWEzRisrKy9UUXgrc04yRDJw?=
 =?utf-8?B?dE9rWHZrV1QvTnFYejlEdUljUmcvbkQ4ZE5nME1QYmZlbjk0M0oxQUxzRUhG?=
 =?utf-8?B?UWRxSXl6NlVkZTc3TEhJYzNUNlc5NjlxNFhiS2FUTVd3NjBMRlVPQXdpUXlq?=
 =?utf-8?B?VVZTUytreGU3dDhYZk5MWnlQQXdBSGpNcnRtM0xwTXRxa3p3WTBCQWV4NHpq?=
 =?utf-8?B?RUsvUXYvU3RHckhKaGZoUWI0a0h5V1JUaE9TYVZ5Z0ZKSjZrT1pQSWdIQnpS?=
 =?utf-8?B?TWZ2SVVRY1dZU3lzcmdITzBFSjVRd0IveTdqamlhS1BjSkk5OWhVZ1N6RFFV?=
 =?utf-8?B?WFZHcElIMFFwcFZrKzNqTTVFWTV3ZzJ2WkV4VE45aVFwU3lFR0ZHU3hTQ3RW?=
 =?utf-8?B?WXZsY0Nmakl4U3lScmRlVUFVV1p1RFgzOXdSeXNHK1N4R3loc0dwK3NzR0Yw?=
 =?utf-8?B?OUl0eEFFNmhWeG1PMHEvdGhxTUs5RnoxZHd2L003cm1uTk5FUWlMemgzOS9M?=
 =?utf-8?B?TGdnaEc1T3NaT1FqVE1TNlg0TS8va1pnVGRKdVJMMmdleVdTZnVUeVNHQ3la?=
 =?utf-8?B?WFFEak5DZ21DZ3RkSXpCeWZQUmdLQ3JIT2xlSVdvbEdEeUFiUnJTQlFDTXZE?=
 =?utf-8?B?d2I5dFJwQWFnL1ZBOWpsaU1KZ0J2d2R6S2dGTGJ0TEFxaTVYMW0vS0NuU3lH?=
 =?utf-8?B?K2RCbVdNT1dhakZ2MWFDVjJENWFVdjVWb3MzTnI3S3g5akNsRmd1ZmJpd05R?=
 =?utf-8?Q?Bw3oNQTRDj8H3TSCCU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61e6db7-fde3-4ca0-44d7-08df2f717cb3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 12:47:38.1300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6lwiaiWLAUApiKdrq48HwBCJ0GaOXjP5YSYYqXmZxWoUOWUgUA6CEbnrw2hFsGj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 07:09, Jesse Zhang wrote:
> amdgpu_vmid_free_spm() waits for the jobs of the reserved VMID while
> holding the VMID manager lock of the hub, which every VMID grab on the
> hub takes as well. Freeing the reservation, by UNRESERVE_VMID or when
> the VM is destroyed, so stalls the kernel queue submissions of every
> process on the GFXHUB until those jobs completed, or until the job
> timeout if one of them hangs. A full GPU reset even deadlocks, since
> amdgpu_vmid_reset_all() needs the lock before the scheduler is started
> again to signal the jobs.
> 
> On navi31, with a GFX job of the reserving process that waits for 1s,
> an unrelated process' SDMA NOP takes 0.8s instead of no time when the
> VMID gets unreserved meanwhile.
> 
> Wait for the submissions of the VM in the callers instead, through the
> fences of the root PD, before taking the lock. Use DMA_RESV_USAGE_READ,
> which covers the command submissions but not the KFD eviction fence.
> UNRESERVE_VMID keeps the root PD reserved while waiting and freeing the
> VMID, so that no new submission can grab the VMID in between, and only
> waits when the VM actually has the VMID reserved.
> 
> v2: wait for the root PD's reservation object in the callers instead of
>     accessing id->active without the lock (Christian)
> 
> Fixes: 9b47649cabf4 ("drm/amdgpu: bind the SPM VMID's page table to the reserving VM")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c |  8 +++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 16 +++++++++++++++-
>  2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 1482fc031d44..9c879ac68352 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -634,8 +634,9 @@ int amdgpu_vmid_alloc_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   * @vm: the VM with the reserved ID
>   * @vmhub: the VMHUB which should be used
>   *
> - * Waits for all work that used the reserved VMID to finish before unbinding
> - * its page table, so submissions still in flight don't suddenly fault.
> + * The caller must wait for all work that used the reserved VMID to finish
> + * before, so submissions still in flight don't suddenly fault when its page
> + * table gets unbound.
>   */
>  void amdgpu_vmid_free_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  			       unsigned vmhub)
> @@ -649,9 +650,6 @@ void amdgpu_vmid_free_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		vm->reserved_vmid[vmhub] = NULL;
>  		id_mgr->reserved_vmid = false;
>  
> -		/* Only for kernel queues and kfd/userqueues by pass that */
> -		amdgpu_sync_wait(&id->active, false);
> -
>  		if (adev->vm_manager.spm_vmid && adev->gfxhub.funcs)
>  			amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(0),
>  					     adev->vm_manager.spm_vmid, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3f19d03fd7d8..c5643344a3f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2852,6 +2852,10 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>  
>  	root = amdgpu_bo_ref(vm->root.bo);
>  	amdgpu_bo_reserve(root, true);
> +	/* Wait for the jobs which might still use the reserved VMID */
> +	if (vm->reserved_vmid[AMDGPU_GFXHUB(0)])
> +		dma_resv_wait_timeout(root->tbo.base.resv, DMA_RESV_USAGE_READ,
> +				      false, MAX_SCHEDULE_TIMEOUT);
>  	dma_fence_wait(vm->last_unlocked, false);
>  	dma_fence_put(vm->last_unlocked);
>  	dma_fence_wait(vm->last_tlb_flush, false);
> @@ -3002,9 +3006,19 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  		}
>  		return r;
>  	}
> -	case AMDGPU_VM_OP_UNRESERVE_VMID:
> +	case AMDGPU_VM_OP_UNRESERVE_VMID: {
> +		struct amdgpu_bo *root = vm->root.bo;
> +
> +		amdgpu_bo_reserve(root, true);
> +		/* Wait for the jobs which might still use the reserved VMID */
> +		if (vm->reserved_vmid[AMDGPU_GFXHUB(0)])
> +			dma_resv_wait_timeout(root->tbo.base.resv,
> +					      DMA_RESV_USAGE_READ, false,
> +					      MAX_SCHEDULE_TIMEOUT);
>  		amdgpu_vmid_free_spm(adev, vm, AMDGPU_GFXHUB(0));
> +		amdgpu_bo_unreserve(root);
>  		break;
> +	}
>  	default:
>  		return -EINVAL;
>  	}

