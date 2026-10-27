Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DC8606A31D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 22:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=r3HZ5m51
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5DE610E1A9;
	Tue, 27 Oct 2026 22:02:01 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78CBC10E4A0
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 22:01:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aunfpZVN1gNZPA0txLSqtUWjwZMc5ujEobcYmx/UyUGVy4G6budoSGUoAoHnNGVAXKFSCMPoLXGHo0lwSi2u7SbPPHLUcW5oq+BiY3SgdYsglllmVPKrziiSF9vRvwpEmPg+pZ2AOkwHOhx19V8Pc+ULtjKdY8M0wbCGbc2oLR0Ez0hN5jJNXDpkwvbqqRI8S7xpGEtT+y6YZTZsBlX0pk88qbApgoEE8PLTfSODeiOL+Did/bjHneO+4cM47SQQxRisQAl7AgjDWeq5YFoS5vhLiyGsAzGB9nCEb7DMRWXLkw7zMkxeiTxr1Jb/OE6eGlD+DOUxY1Xm1ZzrJ5k59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/9k2nqyGM2HEf4b22zE6ioWF1xdySov0NxETJXRgJw=;
 b=uxyZbK4M4uhBYJmY7dEe8zoEavxIaU+ujptD16lNko8FEFM1mauIP4gQ6OHToanZ0Ypo/Rk9Gyh5ahfPGbmSmorKIkZJgvm49qGwwnlN+NftXQByAsB9GCsvhJm7p07MxyfnSryDzwZ5KUWCFJATggTo7Pbo/uFrSLcLZtMyvrHdOA+YnYlWRWlxAPeXhStlZzzNKOmP9qgThf2XOcIHu/JBQMq0m0SjXJddBbAi1wxLX152HkDFf9ckBtUn9+PMk6gSq8Q4lXSYAXNFaIlCu3BxmDfgVXFb0Rzy9UtV78bXzZKAL1ZbhGUIDlSuZUuTRUfG1V1XnkgSnsZiewC1QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/9k2nqyGM2HEf4b22zE6ioWF1xdySov0NxETJXRgJw=;
 b=r3HZ5m51q3c8xAChEEFdduENRZOui4FlrZGrHzgoUtFnUFjlB7QLKahUUulCU1ayjTIBsSzkbm8/BQtQ8FlDUHptVLu0WK1omJO+0vtUP47ng13oA5CtMUSKQYzJPxbgtIYH7U6LDXz5bkhT2B8mRut3x6dlPuXFi27M48bk4j8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by SAVPR12MB999120.namprd12.prod.outlook.com
 (2603:10b6:806:4e7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 22:01:52 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 22:01:52 +0000
Message-ID: <4a54950b-9a84-4765-be06-7c5fe1e1c397@amd.com>
Date: Tue, 27 Oct 2026 18:01:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: use the queue's process info for the WPTR BO
 eviction fence
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Eric Huang <jinhuieric.huang@amd.com>
References: <20261027052205.2716707-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261027052205.2716707-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::19) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|SAVPR12MB999120:EE_
X-MS-Office365-Filtering-Correlation-Id: 0290020f-d0c9-4cd2-fb1a-08df3475e84d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|261026121527099003|56012099006|11063799006|10067099003|261009223027099003|261022105027099003|261021123027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: DMrmOxv5MUygfwymqCWtBjTHAh7V1xagmibu7MptKlbtvurX+Iw8nbDgofttvZ5IAhGin+qKZjvowBah6Nfpc8FQd4a6zA5vj9UlppYFGkcuHcF/h+Zyb4P4krR3ET64eV9EeZBU6mKtdCQkxsbm+POujyLpxnAqOKOmRynsfGEoNZnYSYWcIlzHiahPM4Rvl5ek3OHgzcaVV3ZStufMrY1fKahhpNyXpH5YLcaMXfjX1i8Slv6ARcVlbQjIBi36vxQ1sT1jYGTFEZdNwiVjfKXvrJYFDsXKMYH3LB63XjcYgUTmsqukIs/N7LTTL38KM4haLToU18v31AXQG/LTjZRoyHC5qVTTs/UPFXdVejljlOHUv0sL42wuvHq2XYEb8yIpkIKSGwrKssWoFN1YiXtQxI2xzIsBJZqDUVHUlQbnCkfzW+mVo4iHnvlSuUm1IIrvdSZcA2EFMnEbt1+9h/7CIlhZo4HUEWKFHjZu/z/ES6/9wl6iLSxLd2IeeaKEpR4REZ5ytBsnItqGOPrNmthBap0HZ/ahnwdmCxkviKBCJ4qycVVBpjeut8ZDH100fcnUab2PCozkNBoN8HCX6CSoVToLLy3bR9iaRywYunmU9RzJwcaL9O6SLnn5DRYLZ2TP4wgiKZWrt289kBsMXNYWUU4V7eT6+vT1ZSS4Vv0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(261026121527099003)(56012099006)(11063799006)(10067099003)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWI1NnVMak9WMEZlTGZTaE1vQWxvY0lKbGZQL25UQ3NHdHF4TWlRdFRiejhF?=
 =?utf-8?B?UFZIN0dmdFVNbkp6dkFtd0ZWeUJlOVF4RWdOOVdJbXlHZEpkK2ltSjR2S1Bt?=
 =?utf-8?B?emNXQ0xRWU0wbkYvcjFHQlJDazVVOEU1U0JoWVArUkJTeURiMUNxWk9iM3pP?=
 =?utf-8?B?Zm1JanoyRmd5Z0szZmtUYm5YOTE4RG50SUtyQm96SEFMaUo5RDlwSWpNS1dK?=
 =?utf-8?B?UXdKODlJU1VtME5Fdlh4TkZWNDhuNGlaV1MrUi9ET1RKRTBXb1gzbThmSlh2?=
 =?utf-8?B?RnUxbHYvT2ZRblNmMk81eVhwTC8wTXV5czFmMmF5dEdNakIwTG02TkNWMXMw?=
 =?utf-8?B?UWxlM3lFa3Exd2I3N2QzZnJtVEJnU2NtSzRPYWRISFZZK0hxNEZiQnRXUUlh?=
 =?utf-8?B?NE1QTEQxUEtJV2tFdk91QkdXc2FRWXdCVW5na2czbGJESFZmM0I0SU8vV2pp?=
 =?utf-8?B?L2pKOFh5eDEwSm94WHhkOVVlMWhBWERSc3RTcTFGNHFYR2h0dUtsQm9VUVNG?=
 =?utf-8?B?ank2S296a2xJOXpBbEppZHd0M1d0U05oaHFBOTFPSTREZ2kvczRGSEV1U2dX?=
 =?utf-8?B?MndvZEs5NW16MDRwUFhaSFZtcnR2cVdqZkZTZm9ZK29vb2t2RVMrQ1loMGt2?=
 =?utf-8?B?a1FjdzluWmNvclJKK2cxdXRSakhmK2Q5NXkvSE1RUFVZaERXVjJ2U2dBMm13?=
 =?utf-8?B?d0JpcnNHZGFINUxhaGo0ZkhVd05UZkxRbTdVOHcxWU5Uay9FZDZPK2J5M3RX?=
 =?utf-8?B?MkRtODVPNTk2VnhabG9hUzl1WnY4aVpLamFqM1dJbUIwZFN4K3NRUzB0NHFG?=
 =?utf-8?B?N3JhcXJtWlh3ZGp1ZEIwKzdYNkIrTlV6UWphaXhYMDMyT3pNTDhUUzNZMGdY?=
 =?utf-8?B?dmtCNW8yc1hSU2F1UFQ0b0JhWGtUcmNXNGdYa21pYUdUdFZJMDliSnluSFFU?=
 =?utf-8?B?SmFCQW0zQ3ZYK1hJVWgvOFFTMjJDcmMzYVlGL0NWWGQxQ1hTQzc4MXFiVTdu?=
 =?utf-8?B?ZkNlMDFjdGVNMW42V0xxZnlBQ0l0Yk1OZTF1Z0lpeXNhdmRQbElPODkwRUF2?=
 =?utf-8?B?VWJIdExPZk1EeEJNY0wwdFpsb3NWV0wvL0NhNWZFTWc5WnZHbFlrd3hISzZF?=
 =?utf-8?B?SzVOUG5NVDZ5RkpYMTRzY093SFFhK3Z5ZlQva2VmUHJ2a0ZaTW1GcTNaanlk?=
 =?utf-8?B?S0xwL1Rtbm1OYlRNdFBlZ1BqbWlJZ2gzdDFsWVBNZzRCMmxVQXZFY2IzSzgx?=
 =?utf-8?B?UTIzYTdtdFg5RlAvVEcyL1hyVytvRnBCUDlBL1hDK2dFQnBVbUNOLzBpc0JO?=
 =?utf-8?B?QjJGbUNGc1lkWEFvdmtqMXhqbmVoRUJWRFNIbVEwOVQ2Uk81cllJNzdKUS93?=
 =?utf-8?B?QUhCcU1tWG14bDBURTdodHAvR0ZEZUNnOS9PMUZQQk1Pa2trR1o1dVNrOXlE?=
 =?utf-8?B?SEswNHFXRklCVGYvTXc5bXptUU5nY00xSnhvT1VDTHVKNUZ2Z3FHWms4MTVx?=
 =?utf-8?B?bmYxSDY1Rk1HNU11MWo4SGJsU3JPa3F0bWxYdFdkUkI0MnpFK3hCSnIyQzhM?=
 =?utf-8?B?UlBPMlVmeSsvUE01NUFYYVdWaDc0UDFQY1pESkZGTnp6YWtBVWcram5OWmtI?=
 =?utf-8?B?WVV1SGtkbnp5RHpHMytIVHBtUjEwN3hFdWtraC82U0M3QjZ5WFExZjg5ZXlH?=
 =?utf-8?B?eWU2MHRaRVlYUGxXbkJjTDhZMzltL0Nua0tGTzd6aGovdWxaRERFeHI3RnRD?=
 =?utf-8?B?UGJicTZ3TnQvSEd0bGswb2JIcThQOVlVMlJ1M1JiUmVVbnZ4dGQ4UGxKeFpo?=
 =?utf-8?B?TjBtajdvbkhncys2ZVh0eDlPUXVXbzcyZ3d6ellVcHRuQStNQlEvOUI5eWJX?=
 =?utf-8?B?a201bUVzYUtUQ1BWbzdFQ1lycXRYMVRXVng0TlpMUW5FRHhMWFIzZnVoN0I4?=
 =?utf-8?B?bGU4dUowbDFHdnREOU51anJWRmZHa2swakxyTGlWZXhHc21OeFdraCtTRytT?=
 =?utf-8?B?aFFrZjZER1ZhWjBPK2pmWkg0VDc2ZXpraXBTTjdWM2FtQXJDVTBHVkx0c3BO?=
 =?utf-8?B?a3U1RUtqUWNEanJiYm10eVFJVm5QTGVtMmZEQ1hNQXhlTWdMQXJaOGtSWUFT?=
 =?utf-8?B?OVFtRXNzcGlOZGJiT0puM0xYRnY4TlZ1MU5oOHdCTjJQT2puV0VPLy9WWU1G?=
 =?utf-8?B?cVpmWUNseVpJeXREZXpkVStWdTVyRTE4ZUNMbEdCaDhmQmc4ckhVT1BPNktD?=
 =?utf-8?B?cUc1cFZNclpWUFhvV2ZKZmFyc0JNOFFpYVdPZzF0aFdkd0lYMmxaZVRtNmJP?=
 =?utf-8?B?SXVselJWSGx5cmJOcmZMdndoaDd0VFQ0Y2k3NzFNNDM3dHFmOE52Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0290020f-d0c9-4cd2-fb1a-08df3475e84d
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 22:01:52.4359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlz051fiavyw4aMaZhuSL3B6Qp8bKFuFzs6HMowD0Xn6MSNBG1+7vSbVRJnSGMwKYRljGZYRcnOw8UihhQsxug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999120
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

On 2026-10-27 01:21, Jesse Zhang wrote:
> amdgpu_amdkfd_map_gtt_bo_to_gart() removes the eviction fence of
> bo->vm_bo->vm->process_info from the WPTR BO of a new queue. bo->vm_bo
> is the VM which opened the BO last, not necessarily the KFD process' VM,
> and a render node VM has no process info.
>
> On navi31, an unprivileged process which exports its WPTR BO with
> AMDKFD_IOC_EXPORT_DMABUF and imports it on a second render node fd
> oopses in AMDKFD_IOC_CREATE_QUEUE:
>
>    BUG: kernel NULL pointer dereference, address: 0000000000000060
>    RIP: 0010:amdgpu_amdkfd_map_gtt_bo_to_gart+0x86/0x1a0 [amdgpu]
>     init_user_queue.part.0+0x180/0x250 [amdgpu]
>     pqm_create_queue+0x32d/0x730 [amdgpu]
>     kfd_ioctl_create_queue+0x583/0x9f0 [amdgpu]
>
> Pass the process info of the queue instead. With the fix, the queue is
> created and destroyed normally.
>
> Fixes: 7f347e3f8217 ("drm/amdkfd: Fix NULL pointer error for GC 11.0.1 on mGPU")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h             | 3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c       | 8 +++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 3 ++-
>   3 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 77c0504cc158..74dc307e5140 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -344,7 +344,8 @@ int amdgpu_amdkfd_gpuvm_map_bo_to_kernel(struct kgd_mem *mem, void **kptr,
>   					 u64 *size, u32 domain);
>   void amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(struct kgd_mem *mem);
>   
> -int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo_gart);
> +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo_gart,
> +				     struct amdkfd_process_info *process_info);
>   
>   int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>   					    struct dma_fence __rcu **ef);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 4d209b6c2582..cd72f8d84e79 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2261,11 +2261,13 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
>    * amdgpu_amdkfd_map_gtt_bo_to_gart - Map BO to GART and increment reference count
>    * @bo: Buffer object to be mapped
>    * @bo_gart: Return bo reference
> + * @process_info: KFD process info of the queue the BO is for
>    *
>    * Before return, bo reference count is incremented. To release the reference and unpin/
>    * unmap the BO, call amdgpu_amdkfd_free_kernel_mem.
>    */
> -int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo_gart)
> +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo_gart,
> +				     struct amdkfd_process_info *process_info)
>   {
>   	int ret;
>   
> @@ -2287,8 +2289,8 @@ int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo
>   		goto err_map_bo_gart_failed;
>   	}
>   
> -	amdgpu_amdkfd_remove_eviction_fence(
> -		bo, bo->vm_bo->vm->process_info->eviction_fence);
> +	/* bo->vm_bo can be the VM of any file which opened the BO */
> +	amdgpu_amdkfd_remove_eviction_fence(bo, process_info->eviction_fence);
>   
>   	amdgpu_bo_unreserve(bo);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 78ab759ad854..4c4a3a8587f4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -303,7 +303,8 @@ static int init_user_queue(struct process_queue_manager *pqm,
>   		}
>   
>   		retval = amdgpu_amdkfd_map_gtt_bo_to_gart(q_properties->wptr_bo,
> -							  &(*q)->wptr_bo_gart);
> +							  &(*q)->wptr_bo_gart,
> +							  pqm->process->kgd_process_info);
>   		if (retval) {
>   			pr_err("Failed to map wptr bo to GART\n");
>   			goto free_gang_ctx_bo;
