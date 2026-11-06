Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6DF606A326
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 08:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1kIrUgdx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CB0E10E385;
	Fri,  6 Nov 2026 08:15:44 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22D6710E385
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 08:15:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckzgV4J9rPjTnZf9I8T2J8Cu4wUdG22UuQsPaBoobRwo2rJrIik/chXH0aaXNnzZXI+5IODPPgFanbOg0iwfIY1zUs6CGNhuMp7DsY3LUgKCnWffDJtjBuexlq+pSAyIwg/iUmeKJpx6r/5UCn7D74UKBkp6cKO6q8qsMi4DOxqMq+EUbk6433G/i8M8dGAJ/lMsU+seiafWYwPTjeHLLz2tMrSKBXlvLjZ+mHomN8AxSqYLa8jqbjDO5OeZF7Roue3iztatMi+WgXUyPemNFt6TtZ7GSMtCNpvCKSAJEt9mxjQayGIuKFGt14qs/CQzs52xvHW4TttKwrDzCfHVxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+y1qyiHjm5mmM4YGCbjcDeaP9thYlGzwPOB+PtVI+Tk=;
 b=WihozpnBWyylpZ70yIct6Ktr1hzkFvfpK0yEYoMk3kcub6NpnCeHxZ4AdSxdqYLL6zhruivKpQV4q0d8rIiMNCeipTd9IMXIhqm9PJxzyeBSmb1zUPBHeVCJ9jbJGap0JEfIAC5jV0z+Qg+YXg0uIKQhqYW8QUETJCxm8O47pHVWmpu8JwjTZ6W3PVt++5brlnFpGP1UTN+sz+4NhY1eIrTf+HAcPrLKk1oXL/JdJeWzqsjtqAAyFiQD7GAJ+BQ5GlVYmMrmYy819KJoBWrZ4EsKxM25zalHhcxQjYjrK8DEo8kK1K5XDqFmxQMs4/AWKlX9IGck6Lg8nQuCnM/rcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+y1qyiHjm5mmM4YGCbjcDeaP9thYlGzwPOB+PtVI+Tk=;
 b=1kIrUgdxJ+x3bldZnEoX4iFepQUuEimM3wHVvSed6j84/Scovkc3HaLzlAHYpvp8dO57ZJQ1G0tTxwsbyeVbCphwoFwytcJRxVkCmNvFLCpgshAHCAjs5Eee9nR2G+F4iXI0FpaO1iosaRhaiyUdhJLD6Iyw6D1EQMdSFrng/Z8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Fri, 6 Nov 2026
 08:14:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 08:14:59 +0000
Message-ID: <e210ed12-8c78-442b-ab5f-637fa5d582dd@amd.com>
Date: Fri, 6 Nov 2026 09:14:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: don't create the CWSR TMA BO as a kernel BO
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Lijo Lazar <lijo.lazar@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
References: <20261106072627.1449709-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261106072627.1449709-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 560491b7-9311-4574-1bbf-08df3bde0cba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|261021121427099003|56012099006|11063799006|261022075727099003|261026140227099003|261028144727099003|261009223027099003|261026121527099003|261021123027099003|261022105027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: g10V1/5/PHYSol+hus6N0Y3tYv9g/erXzS62oQEeQskXh6mi7OpTYyGisz/bOnb2GSVBrYUKjyBtv+egc1c2R2CLUyaxuadSwOgrmiQUj6FMZz6uDhn6w8po6cIBspWwBPZ8OaKk5NwcUmx9dOs1gaX5KaYySUNbwxYEU2/efWswqrH0nV40hsFMaGWjcVZn8LkvKWj+vGNdICaVcqfUy/n/yV/Zo2uT5Hhkdb1j21CZWLcKmkzy5iFpI7scljSPq6n/dJS346lBT+97M9jfl1LvG1qRLSGjG0sxJ+7L11sSd5FuCM0JYpRe8sxW/pwLxlUBRQF3I/bjRa9bSdviRky8BxTBMW0p2IlA2+l0L9hdcIXalQQ0hpbLsV+LNkqkbkx5GDFazMHWsGhaAyU2nvq9kzkrKYu6Iih/ahst8l+KClfgRBCEyaJ6UnjF8oItdd2tulAZwyEIquRKDNJzBbeOHMq4TxHezy7/Lt/gy92cIyxnSq58VBl0Sp3mzf/GGvw+QhTAhjJuMt4RMBfzdl6ScXVhYrrW3IcIzCqNnhzEslp9cUgJkpvmKqJO+/C1+wtnPU394eysaXDou48etPwE+2UYZHRAIkXUTQSE5TBQTT90gf1W41VfAy2a0Hx5XAX/KwNwD9WhEkL1ETWnh6MYwyQLpryyTo9hNCmQ8EY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(261021121427099003)(56012099006)(11063799006)(261022075727099003)(261026140227099003)(261028144727099003)(261009223027099003)(261026121527099003)(261021123027099003)(261022105027099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVlwZ2hZZUhWSXV5UG9KMVVaUU56ODBMNmJRZkZyZzFsL1lTOFVZZFZiNGp6?=
 =?utf-8?B?anVUZjZkbW9BbXBYNjQ5eStJQmxJRXNpTXZveGwyZGxUSDVaS0Y0c20xRTZO?=
 =?utf-8?B?NkdEZEt4VDhuVXd2d0hLczdCVFNDQW5qNFJxakRCWkpGSWRQVmJSRWZZY1Q1?=
 =?utf-8?B?YmQrYkhncjR3dzJPcGttZHVyNzNiWUR6WnJWeGhJMTJENitmS1VvSGxQTzJl?=
 =?utf-8?B?d0Vya3Qxd0dzZW1lNTBnOG9qVWlBY0VoSU9BcWp3SlBpQXV0cU41bXNTWm5O?=
 =?utf-8?B?VzBqWEFCVGc5cEpSbWx5SjFPbDZQMkNlTmVEMk95b3RpaldpbTBJenBrTklD?=
 =?utf-8?B?MGpya0V6TnJ1dHdMM3VTcWRrRWM0cXRyQ2ZBZ1lwd3RpQnhBcG9ad0VqcG5i?=
 =?utf-8?B?Ui8zcnNhSzhjeTdLOGNmRkorZzBoQlhCcndEdFI5V0pCdzRiNmEvWWhZSi9V?=
 =?utf-8?B?OVVWZDIrZG1JWWh5MnR0REJDWGJGT2dBYld3RjIxME5NZFRxQjk3V0FDS3VH?=
 =?utf-8?B?RUo3SXd5RWUwbk0xcWdnaGFRcXJuVUd2ZTFqNE9KTGZ4dy9KVjR0K0pwK3BE?=
 =?utf-8?B?Vmk2SWdvL01Zd3dHbEpkOENSakRqeG9YaEhLOEhSNTJTY1BwM2U2ajNISE1H?=
 =?utf-8?B?QmdDS28yQkhxUEwrd0c2d3JmYjY4L05MUXFGNzYraG5QVklvQWx1V01ZMlFu?=
 =?utf-8?B?NEQ1NzdXaGU0c3Z0Zml2VjNTcVNsU3NXcndWTkpUWGdKakJ4NE1IVDB3RzAr?=
 =?utf-8?B?bnB2YkhRYUlMa2Q1bHV0YXRKTEYyeHhKUFlsdW1Gak84eHhteDdST25KRnRa?=
 =?utf-8?B?ZDJYTWpLQTdJazMwNWF0YW8wejIxS1JxWmFxVVJoa2l1VUNrRllsY3BLb2Rp?=
 =?utf-8?B?dG5DTTRiM0JXS2tLRHRsTndKbnBjOFdtSW9CWFM1Ymk2L0U4RTRNd2lHRDdE?=
 =?utf-8?B?VFNrSEJJMjhXRjRralhSY2xxWXdKRnVTNmhwMGQ4WjZCVzl6TjJ1cHVGN2gz?=
 =?utf-8?B?aUxKNGxMQjFkUTNWUFA4eVRSdU1zeHhQdU5sSkFkNSszaFhYUURPTzdST2lT?=
 =?utf-8?B?UzQ3eHZrRWFuc2FVZDBiREVjQWtycEQ4NnpnVyttbisrbE96dGRYZGZ0VHRX?=
 =?utf-8?B?Q1FYR0JxRU5vb2RSUmlHdmcvN203OWZUVUVWR1Fidk03V3VXT2hISFk4Zm1q?=
 =?utf-8?B?emFxc1YwK0FTOHNWSktYVVl2aStoajVuWXVwQUVjVlNORUN4aGJDYzV0NXpz?=
 =?utf-8?B?UGxGNzRVZ2h6MHFsT1d3WXpwR05VUTlXL2hBYWF2UlE0b3hpUExYOUpLL0c3?=
 =?utf-8?B?RHVyb3c2YUZLRkRPeXdJZW5palg0U3RIaDU5d0l0V0JmdXY1N09MSG5WKzYw?=
 =?utf-8?B?N0w2MXNVdTZ3RGV4WnZ2RC9jSGhPcjJzVVFYbC9mZDJwcHRoUUJqZm9tVWM3?=
 =?utf-8?B?eGlpOWxaMjJDVTJjaHBvQTIyLzFjMGhnVG9WbXY4aW1rQWlmaE1KMVlQT04z?=
 =?utf-8?B?RXhueWYwdzZQcDIzRGExUHFwZHJQNENFb1FvWHVRbjN2T2o0OW1vdlltbjcr?=
 =?utf-8?B?dDd4ckJ3YmNDam9UQmEyMzlZQ1BMcGxYd0VIdFp5QkY4amU3cjQ1TlV1bUN4?=
 =?utf-8?B?cWI4N1A3RDNXOGxwellJN1BINzBBa1NVMkZZRjNjTVFWTGxHVjI3c3VjeVRI?=
 =?utf-8?B?RW9KWmlHdEw1U1hMMml5WXZReTE1NzM4aGFrRzMxWkZHY2xzK0hZcEo4aWEv?=
 =?utf-8?B?QTJjL1RxRWEreXMyZlVVUWxZb3ltYk44QUZlUURpVStqaUdVcjlBRlBQUGJP?=
 =?utf-8?B?c25GVkJJVFVxVW9Bc0hMdVRFV3ZiNTR2c25TVWJ0VmI1UEhnWHgzVW1SR2l0?=
 =?utf-8?B?d0J1RHRVOTdRbTJ6Wk5FN29MRnJUVElSQ0UxdnBRazZKdHJsYWlyUWRLNDZY?=
 =?utf-8?B?SXlPaGUxMmxjdmpkOUlwRkFKQlVHMWhST0I1UUQ1eGUzN254YWs3WlBlbXBI?=
 =?utf-8?B?NDU0ZEMxQk9KTXVYMFFqMlVHeTlnL0JpSkZNS0poU2ZESERvS01CT2IyMkov?=
 =?utf-8?B?dmRkeVlWR2VnK0lHRks4M3RVc2twaGlIUTFFYXBJekxWZE9uVEFMamdBRUFG?=
 =?utf-8?B?eTB1d296YUJvZmNGOE1qeVpJR2t1TXpLU0lDMk42aEd3SFByaXpaWkVIZFNR?=
 =?utf-8?B?dE54QzhicUZvNHNibHNrblMrbzZYT0tmbnRaL3llVmNYUTlKR0NIRFJVelFu?=
 =?utf-8?B?MDBjcFcycXdMcklhRVdmOUQ1WjJMRGNCeWZNaGhOZ1Z4NDUzNmdTTkFPUUk0?=
 =?utf-8?Q?Vr4tLQvMr5QFkeh0ht?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560491b7-9311-4574-1bbf-08df3bde0cba
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 08:14:59.3441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMl+x4lXxecXe7OYtfZM7IqVAe5ZuEw5e2gzOHTHiXSzW3+FuHs8Xty0Z/HSNoxC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346
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

On 11/6/26 08:25, Jesse Zhang wrote:
> amdgpu_cwsr_alloc() creates the TMA BO of every opened render node with
> the resv of the VM root PD and as ttm_bo_type_kernel. The VM puts kernel
> BOs which share its resv on its page table lists, so the TMA BO is
> treated as a page table: after a VRAM losing reset its bo_va moves to
> the page tables needing an update, and amdgpu_vm_update_pdes() tries to
> write its PDE. It has no parent page directory, so that fails, and fails
> again on every following submission of the file.
> 
> On navi31, submitting on a render node, then amdgpu_gpu_recover and
> submitting again, also with a new context:
> 
>   amdgpu 0000:03:00.0: VRAM is lost due to GPU reset!
>   amdgpu 0000:03:00.0: GPU reset(1) succeeded!
>   WARNING: amdgpu_vm_pt.c:664 at amdgpu_vm_pde_update+0x329/0x5d0 [amdgpu], CPU#3: vmreinit/2728
> 
> and every command submission fails with -EINVAL from then on.
> 
> Create the TMA BO as a device BO, a per VM BO like the other ones.
> With that the submissions after the reset complete.
> 
> Fixes: 8a93aae9896b ("drm/amdgpu: Add CWSR infrastructure for user queues")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Clear NAK, that allows to mmap the CWSR BO from userspace and that in turn is seen as highly problematic.

IIRC Sunil already stumbled over this issue as well and we agreed to not check for ttm_bo_type_kernel any more.

Could be that Sunil and I didn't fix all problems with this, maybe take a look at the history of amdgpu_vm.c.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> index daca0a1ac990..52ae77a08ca0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> @@ -433,7 +433,11 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
>  	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC |
>  		   AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> -	bp.type = ttm_bo_type_kernel;
> +	/*
> +	 * Not ttm_bo_type_kernel: the VM takes kernel BOs sharing its resv
> +	 * for page tables.
> +	 */
> +	bp.type = ttm_bo_type_device;
>  	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>  	bp.resv = vm->root.bo->tbo.base.resv;
>  

