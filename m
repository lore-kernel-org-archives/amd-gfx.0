Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC32C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 12:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19D0A10E7ED;
	Tue, 12 Apr 2022 12:11:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B408310E7ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 12:11:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3sDV3QXK3UYhnejc/wL5Paqo509BC+Z9hfN6noFzshk2aIWRSef8k6H0EB8Yw8BdgLNBxqPHqmRd58EYi5NFOsTypeuXb7WBs3Sjnm9NnPExu1noNvN5/aCiqN0YLWpQlPwqv8QYai6LYDrh7IgTc60WcYL35QNygrxSm1nxa237tNVLWlVgRdE8lwWNytKPGADpv2HkkcntCUNVjTs5jktjz8AdpLAoWtMECLHrXXRRpeTXh64u4ZTApCl6DFNU7Wfn24wJZEvkyWFIiCbGNLfNfpGyiACnnjJBJvlgOg4dr7MUKYwW3g+bqJflLAaFBagiEH9MVy3JynLSsYWgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmTwEHlUHi9wrR5CkyQJvhIw73OgrFut4CdK1CtXdzM=;
 b=NDxrcIMOt4CHTFF+S69d0A/G7yPMQttMhhQfmh/vdGD+haZOFhKo2dxv8UIvvrsCOfUiwVhtXXEhCpZcqZLdwAC6ymNCabOan3iV4DbKKq7QPU61EzKpBH69HUOWUqH5YIkI4okEEeMkgk4mFLR/PS5bW8waMn6wbb8XcrVG4tCPqE56UYckSRdyrkHTnlJyOhCW3tFY0qJc8bqFyh0Avt+gnheiECEZJ5EiP9TSdw+u8t40F8j5bsJbCeNd4WY9aXxC+NkDW3kQ5lO0XIYGtuc/BYBRiWK+lrkxKhj85Y6qezYmi1KtihKu/3m8uE25P+UIgQmy8SMyKMlPCf9dTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmTwEHlUHi9wrR5CkyQJvhIw73OgrFut4CdK1CtXdzM=;
 b=VkSa18GxfNcJFNSuaIGxnq+Z3h0puEEZ7oozkug3i7gcIGo3VCNv1anCs4xnRw43Zst4VA5cOmVYfiZOWui2i7bNr2R42qvNwdTa/FdsydmBcXujrPmw1flGDZagABTF/i/omLsLM/cXRP4D4OHYRXtdr3XMBA1YoXUh7DNcQk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BYAPR12MB3592.namprd12.prod.outlook.com (2603:10b6:a03:db::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 12:11:45 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a5fb:7137:5e64:cf8]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a5fb:7137:5e64:cf8%5]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 12:11:43 +0000
Message-ID: <299dca93-dc4d-8b1a-6de7-bfab8ebc8c19@amd.com>
Date: Tue, 12 Apr 2022 14:11:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: Fix one use-after-free of VM
Content-Language: en-US
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>
References: <20220412120322.28169-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220412120322.28169-1-xinhui.pan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P194CA0004.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:90::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 969b9567-2a11-4615-f3b2-08da1c7d9b68
X-MS-TrafficTypeDiagnostic: BYAPR12MB3592:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB35923B756564ED7F269D7E1083ED9@BYAPR12MB3592.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: omCkU3RVQm/2xYJBwFSxuR1vEflmtKKroSOALJV9bIa3QjVLIQjG2YjlL+x/GiqiBwGGN+4yVsODyLGPxro5IXyC7mWJXPmQYgaRyfwPHRuPy3C+XAfrVc4x6vuB39/sB/Tw5cgQJyviVkx9Hj7gcAM+qnOP99j/oyPhSadnuuUkoHFJAYM7D1mwS6rWujw+Z8afOU4LfNw4b1AEzTRFepO4gywA4ooPHqizBLbo7NGm7v7DP04t5rVWEfZghwZD9acI+KOOT98M3WpWodX3R/0tkGm5iPTQ2NtajgsUMwx3SYoZXNboqsVpmiuUkElVnSL5LYHP0b8DQCXN6P0p4D9Mm7sAir2BNx13ff0K4ysHsmlZLnWihMbC901pjc0THqH8tzww8sasPFV++KSlCLF009mQab3hcMGKOKoHpWmEgf3braKSABsSHlmQ+qkO2D9dHPShOmXN9ruC68RzXowp4HJQOFkG6YvHby+NyJErbry+TSgS3a5PYG31KPOdUHdLpBezFle4+zJ6SzTPYX/O4oMsLvjRqJbB4IH8we7zGlEOfVC4CFMV1nXNdI/UMmvV6WUQ1MMqX2SAbGP0HHQ3owlMM/ADo4VcEg75xf96nZDLz9mODLwC6bseM09ey9eveRU2Ds11Hn8jp566Z2hHBxAWnOacJ1UZa6zQlhEhGg1q8ZyS4e49TFJfnVxxVKVxDUi3Whj/XMx4QCF2CO7RvycncaS6QSv6Wx62WAOaRxwuid0XTja9VzSeBVCo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(66556008)(38100700002)(86362001)(508600001)(6486002)(31696002)(6506007)(5660300002)(66946007)(316002)(4326008)(8676002)(66574015)(66476007)(186003)(26005)(110136005)(83380400001)(6666004)(2616005)(6512007)(31686004)(2906002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVVva3FHTElyYWpSN2NWZlNKdnZpaFUyUEozZlhERkNEeklrdjRkRkJ0Vmt1?=
 =?utf-8?B?azNRL016ZXJLQjhVUHRkQXBuZnZuY3BXZWdqRnQxZEFiUHlCcmlwcm1jeWts?=
 =?utf-8?B?ZXk4OXZyZTJQR0F5K2Qxb3kzZW1JZlRzOCtxdDhMbGpybXQ4MUN3YVdHNDZZ?=
 =?utf-8?B?TTEreThJY3laWnh5b1VMOHZWckI4REJxbGZjc085MjZ3UkN6THJzanFmc0hu?=
 =?utf-8?B?VWpPRFlkL3d2T3d1a1VlT243ZUhldERJMXVMbWtkR2F6U0hBd1lNNFhjSms0?=
 =?utf-8?B?eW9ZbXJOVWxsY1UwSTZHMzJ3T0dDM3JHNmlaK2pLNWFGVlBacXcvUDAxbHNR?=
 =?utf-8?B?aUlTOFB2N1FVQWtFRXVKaUt4NmNOSVVERmJ2YjhYV2R2QUdhdWtTS3lkYmto?=
 =?utf-8?B?MFo5L1F1K3ViRUNJMWd0WVFUYVlzb3VkdDg0YTJYNUtaTjNTeEVVR29Vd3E3?=
 =?utf-8?B?d0dOR0prRElETTZmSUw3ZmJiaDFHU2ZzWGVFa3pnbVIzemt4ejV0Mmx3NUpT?=
 =?utf-8?B?L0J4WmhOZ0NTcUV5a3NhTXU3VVY1RjBubXUyWDJ6Q2d3cnpQWmVvdHdBNEZT?=
 =?utf-8?B?dTJ4RmVCZWxlbWF0eWlzbEk0Sm9qbFZIVDVEdkRBNXcycC9HSnhldm1UYzB0?=
 =?utf-8?B?N2dxOCtWaWhXOGlvQWkwU0dNNnFLWVR1eDRZQ2JLVThneWVZalg4TFU5RHlG?=
 =?utf-8?B?bGE0ckxxRjhMbkc3WlViczBaVUR2d1l6eitJQThIMHVSK3RoZFA0VzVBdjBu?=
 =?utf-8?B?L05yL2d4STJJaHZCc1M2LzhvYzkvL09TOXNsV1pDNnV6eHpWeEdMRFE0VXpD?=
 =?utf-8?B?M2c0QXB1L21INThTZm9XSUd2Z3lyMjVPVXNFWGdBakduVzVzbC8wME9pRDBQ?=
 =?utf-8?B?bElLUWRzR3hHck50Znl3UDZVenJmZW5lTEJhb2VIbkRNemNiVDdoYVNsVWsr?=
 =?utf-8?B?MXYrL2tGUms3MlYrMGpwZ2l1QnBZN1dpSlhCVDNXRTlRcnBUOUdTNjFXUzh3?=
 =?utf-8?B?VFlYQ0lyN243THl1N1pnQkhuazNOOWRiZThrdXBqZEkrTjZ2NjkxcmYwVGQ1?=
 =?utf-8?B?UTF3aE9TYjlSdjdUWXoxVVBLQzc3b3dPK25JL0lnVklMaEl4RXJjdFEyYXJV?=
 =?utf-8?B?REI1eE5GeGovWlR6bmJ1dk9mZEd4VEhpeVNOdWtZcVZIS3h3V2F4aDJwMHht?=
 =?utf-8?B?WmhMSFJPemUyZTVWZGR6Wi94NExkYlM3Rjl1cUFFb1RLK0YxeHdaSCs2SzRI?=
 =?utf-8?B?Qm1Bb1RVeXhoOHpuTTVLWjRZenI1a0RiN3FmT1lMY3ZDZ21yYzg3SEdIMnpL?=
 =?utf-8?B?SmFpRk9UZGRub2oyVVE4ek54L3NETVdGaFBweU42VEFsNTI4S1o3UUlqT2lB?=
 =?utf-8?B?Y1JkeExUQmsxaFd6QVFpamZ2S2hFWnFsbktZRExrb1RUY0ZpZ1Q0blVScU00?=
 =?utf-8?B?Yk8yMERRaVNLakxNVEpwemp2bFZGNEViRmw0ZXQ3Nks2YVZKYmgyTklTTnVU?=
 =?utf-8?B?WEhIK3d0OVMzSDU3Uk5xUDFReW5Ud0lUblhyQlJjNzdYdmFzV1pCa0IwZlUw?=
 =?utf-8?B?blVKN280WWFjdW1wQVJ0Y2pjdjFjVDRLdlZ4alFObDVETVF4eWVNa1BFeDQw?=
 =?utf-8?B?RVlWSUZlclhxT0ZKWmFuczBmajJUNVg5U3ZyaHBZNEZTU2cyVmk1Uk5VUlZI?=
 =?utf-8?B?Z0M2VDJTYkJNbXJVOEVMTTBLUW5DSHhzSnR1QTl2WnlHREdlQmNvMndHMWZM?=
 =?utf-8?B?d1BicjFlcTNrY0NGbmlzWjVCenBIQmI5Y3QrRFVLMkF0WWVBTG5aUm5ZUWNN?=
 =?utf-8?B?MHhGZHRHcTdkdXRLcDI3ZnhqRzBnN3ZUdHI3K0c3ZlVMLzUxbHl3U3A1RlVi?=
 =?utf-8?B?bzhIZ0NrUTA5SStSZ2JGQ0xyays5eFRvVFJTWjhpRDBaTzN1VW5LY2VtSVk0?=
 =?utf-8?B?cGNoZ0hYclZQTEdWeUl5Yk5udUpBUlZOQnluRkh1UGJadHZjQjVidFUrbDhJ?=
 =?utf-8?B?bDV5d05iTXhzQ0wveWNnL0RIQXppazVRZEsxU0luWXh2ZXo5ZFJlQ3pieFVw?=
 =?utf-8?B?MGNFbGVPWDNpNThtQ1RWSmoybXRhUDQrQWdnb0RJSG05K29QWFYwTUdocDkv?=
 =?utf-8?B?YTMxUDcwMUtwSit3cFVZR3NPN1UxYVF1MnpVWERGeDl3RUNIWkp0TkF6T3FT?=
 =?utf-8?B?NVFQMnFERWFZb2xCdmxyRGEwM2NObW5CM25MY3NUWkpHMVgxRlBtdFNQaXRP?=
 =?utf-8?B?M2Z4ZGdYUmhxM1QySG8zaStjVktGYmt1MWprcWdxb1A5WGVHM1UycGZqNHpU?=
 =?utf-8?B?RzQyMVRLUHBjZkdpelM0MExqR0FWUWw3djhLRldZOTVJK2lwOGNPQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 969b9567-2a11-4615-f3b2-08da1c7d9b68
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 12:11:43.3620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUqOAwQqEU4YGKrok6ARbxIYd7nR+CxDZ3f5F1fhaaVsCPZssp8OcfR2CG1ZPw7X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3592
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.04.22 um 14:03 schrieb xinhui pan:
> VM might already be freed when amdgpu_vm_tlb_seq_cb() is called.
> We see the calltrace below.
>
> Fix it by keeping the last flush fence around and wait for it to signal
>
> BUG kmalloc-4k (Not tainted): Poison overwritten
>
> 0xffff9c88630414e8-0xffff9c88630414e8 @offset=5352. First byte 0x6c
> instead of 0x6b Allocated in amdgpu_driver_open_kms+0x9d/0x360 [amdgpu]
> age=44 cpu=0 pid=2343
>   __slab_alloc.isra.0+0x4f/0x90
>   kmem_cache_alloc_trace+0x6b8/0x7a0
>   amdgpu_driver_open_kms+0x9d/0x360 [amdgpu]
>   drm_file_alloc+0x222/0x3e0 [drm]
>   drm_open+0x11d/0x410 [drm]
>   drm_stub_open+0xdc/0x230 [drm]
>   chrdev_open+0xa5/0x1e0
>   do_dentry_open+0x16c/0x3c0
>   vfs_open+0x2d/0x30
>   path_openat+0x70a/0xa90
>   do_filp_open+0xb2/0x120
>   do_sys_openat2+0x245/0x330
>   do_sys_open+0x46/0x80
>   __x64_sys_openat+0x20/0x30
>   do_syscall_64+0x38/0xc0
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> Freed in amdgpu_driver_postclose_kms+0x3e9/0x550 [amdgpu] age=22 cpu=1
> pid=2485
>   kfree+0x4a2/0x580
>   amdgpu_driver_postclose_kms+0x3e9/0x550 [amdgpu]
>   drm_file_free+0x24e/0x3c0 [drm]
>   drm_close_helper.isra.0+0x90/0xb0 [drm]
>   drm_release+0x97/0x1a0 [drm]
>   __fput+0xb6/0x280
>   ____fput+0xe/0x10
>   task_work_run+0x64/0xb0
>   do_exit+0x406/0xcf0
>   do_group_exit+0x50/0xc0
>   __x64_sys_exit_group+0x18/0x20
>   do_syscall_64+0x38/0xc0
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 22 +++++++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  1 +
>   2 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 645ce28277c2..e2486e95ca69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -932,9 +932,12 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	if (flush_tlb || params.table_freed) {
>   		tlb_cb->vm = vm;
> -		if (!fence || !*fence ||
> -		    dma_fence_add_callback(*fence, &tlb_cb->cb,
> -					   amdgpu_vm_tlb_seq_cb))
> +		if (fence && *fence &&
> +		    !dma_fence_add_callback(*fence, &tlb_cb->cb,
> +					   amdgpu_vm_tlb_seq_cb)) {
> +			dma_fence_put(vm->last_delayed_tlb_flush);
> +			vm->last_delayed_tlb_flush = dma_fence_get(*fence);
> +		} else
>   			amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
>   		tlb_cb = NULL;
>   	}
> @@ -2258,6 +2261,19 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	dma_fence_wait(vm->last_unlocked, false);
>   	dma_fence_put(vm->last_unlocked);
>   
> +	if (vm->last_delayed_tlb_flush) {

You can initialize last_delayed_tlb_flush() with the dummy fence, see 
how last_unlocked works.

> +		/* Wait until fence is signaled.
> +		 * But must double check to make sure fence cb is called.
> +		 * As dma_fence_default_wait checks DMA_FENCE_FLAG_SIGNALED_BIT without
> +		 * holding fence lock(the first test_bit).
> +		 * So call dma_fence_get_status which will hold the fence lock.
> +		 * Then we can make sure fence cb has been called.
> +		 */

Uff, that is a really good point and most likely a bug in dma_fence_wait().

I'm pretty sure that a couple of other callers rely on that as well.

Daniel what's you opinion about that?

Thanks,
Christian.

> +		(void)dma_fence_wait(vm->last_delayed_tlb_flush, false);
> +		(void)dma_fence_get_status(vm->last_delayed_tlb_flush);
> +		dma_fence_put(vm->last_delayed_tlb_flush);
> +	}
> +
>   	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
>   		if (mapping->flags & AMDGPU_PTE_PRT && prt_fini_needed) {
>   			amdgpu_vm_prt_fini(adev, vm);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 1a814fbffff8..c1a48f5c1019 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -286,6 +286,7 @@ struct amdgpu_vm {
>   
>   	/* Last finished delayed update */
>   	atomic64_t		tlb_seq;
> +	struct dma_fence	*last_delayed_tlb_flush;
>   
>   	/* Last unlocked submission to the scheduler entities */
>   	struct dma_fence	*last_unlocked;

