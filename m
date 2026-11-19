Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDB4606A324
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oKfn3d+L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEFB510E4FB;
	Thu, 19 Nov 2026 10:54:12 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010053.outbound.protection.outlook.com
 [52.101.193.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0096110E4FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 10:54:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/P2PjUG1OY2zBhs6lBNHdLpOtPr+X/H0C+DRJ8L/5qo/Q67I/JHnqck2KgaukjXDKqSa/auGc6KFArdPgRI2+1fYDNZBg0dcnbGvGKEhtRMrR5L9cJYUoTsQzRyCchkR7yTFFnN1fZKEI39fMm51O2wWXoz7xJgF+Ey/eXdOHQ4q1DZTCn89acR3Mk/Y1GLknihc0qFygsBQH8XKHkmiLRdhiLb2yNBdrweqO5sBg6hrASHMA9o1EZH71iLLJ7Qnma0yVkC+yGdAolCIajB2VLMXp5BTBcl4IoSfSAcsgLo8UEYk6Os4DBNeXqRbgyqVlH0YxBq1cx71sJI3VPbSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xB3rDrhB8+7FZMK+4qzFctZx5RpDLjp/VFpqOBU+QBk=;
 b=R6OdWglw1NWKTCZt/9EcCiPZffw5EIhCQi5hBkd9qHVq8RgyC3WIEdooByatmKrlh8R6nsW9WEBR/CDqLL7QawRJPzkvdNExRFw/COi3DIMZ6T7Xot2hVtur+t+RddwSiee2pJxEJU/G2Y1DZSlM5fGnWSdzwlH38QqcIxJgObEMYLD19TQ70HR1NrBZFG62kokDVu5ixlts5xtR8FNbaGDN0uB+R36iNK7+rjPC8sPEl673/jfm0vqxCxe7Awdb75g4Kku5NpOp+LbfNT0ac7FXOqe6uzugSzkBMri4lH3NThbrX+PkCG/JxQxWKP/nGAsJDqGqtXRetJM7K0wj6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xB3rDrhB8+7FZMK+4qzFctZx5RpDLjp/VFpqOBU+QBk=;
 b=oKfn3d+LEIm8Q7VToOlFfKLbTlW+NO8jVOoM5p/A72f2qAxZaHNUxt8y1NJH+i1FmfchOoieMLAqOmTbxXm/7SGFDX4QvFdqjN4wuzJXS8VZ+A1197R/u3CNU5l7J/3Rn96JBLcfkxPqo/+41cQFeBfjok7SChXyuO29rffUQrA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by AT6PR12MB727359.namprd12.prod.outlook.com (2603:10b6:170:116::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 10:54:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 10:54:04 +0000
Message-ID: <edb46a28-519a-42a6-88f8-0640ece6e33b@amd.com>
Date: Thu, 19 Nov 2026 11:54:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: reserve fence slot within
 amdgpu_vm_validation()
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20261117195457.327049-1-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261117195457.327049-1-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::35) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|AT6PR12MB727359:EE_
X-MS-Office365-Filtering-Correlation-Id: c7bd516a-1eb7-4b66-6772-08df462b6d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|261021121427099003|261009223027099003|261102123227099003|261022075727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: YO0CWB6eH+kVM7AQmO4cVGm2ilTS2WZ2HNWtaRs9Y4OvT5HK7v5BNqC+zzq4TJa29ZJjhQ0RE+lYetzgh14IDkDvI2rH3dFCt3t467DPommSdzzSJqMVONCwb+Pfk5NCWSOxl8FzmkOcxQsdRk9FStSha1rNelKVAgcj7ki4Mtr2kOqdkLQginckTK+o8xmK6gMRrsXZHTmUhDogc1X8F0LRPS7MUyAMNtDU9Izs311Um4vAeXt9rzAcQ5r8NNpC59HLtaVkwUo1UTMhCS1MzRgsLHtYW4yNWHl9qiLPtpLaNE/Y/S3OJkwjc26j4ZaMfIIlVXIFY1r/rJvhxad3O4Imh4BWxVA1Js8YLQXcXqN5IHmFGkY3thwfXOQ1y0YmvOjVw0260IwA2UxDpRJFdKsKWEVYtAANmQ3tZ/Bw7QBaHZpd0iQX6+vJVuiSr6/P7dPnhVV4/0Yj6e0BxRxtdBmg8s/9/OV0sDj8376xhVS4PGCGqg0lJjmDJ5swDHLZBMf74jxnGLoFoVi5zDhmhFiSEmVxrEkAGnUefjhDOsJ7hOzyKTYJtvA2phauNmnEbPNtfyTpVBrWyYwwxRaaLfyWrbmAhYj5b/FNAoIzX7xL0XBi0TG+exvIguz37TbJrP54unV2sudAxRV30Kf90jnvYwjZp6uYTu3qfYpAXRk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(261021121427099003)(261009223027099003)(261102123227099003)(261022075727099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0ZWME52cGM0czN0Y2VjV0pPYlB6N2FoMDZPdTI5Y1BQZm5Dc09wTnRwMlhC?=
 =?utf-8?B?ZDBzbDN5bTdKQm1HeitaNHIwQ04wbDZxTk1VcUdzTnZwaGVNdDdhRzJNZjlF?=
 =?utf-8?B?NmlPTVZxQzlpenhQcjc2YUFDczROUm9wb1JLRGFOUEtLdUhra05wdklHRDd4?=
 =?utf-8?B?eGVZdG8xRXE4ZWVPamhsQWR0U2ZabDZhZ0tLZ0tZKzlHdmE0MXcyQnpucHpI?=
 =?utf-8?B?TTl2ajN2ejlqcmFHcjRZcW1iWDI4VmNZVHN0VEZoUnNha3VROHp6L2dlclZ3?=
 =?utf-8?B?NWVFK2MycG1yalo4NndxVnliMmJJa3dxcWlJRXJ1N0Q0VDhheis2MEUyR05Q?=
 =?utf-8?B?bUYydzZvQjdxbVRBUng5ZzQzallqUTl4ejcyOFE1a1pPYmFFVlMrNG9PWTdw?=
 =?utf-8?B?b0wyRFl5ZFpmMkJ3N2tqdXhsYVJKZzU5RTgxY3V4ZlhzWEFvR3lBaGRWZkNV?=
 =?utf-8?B?ZmlNNW5EL3RBV1NFSGdrZ2FhV0E2dHFRdk9DeTlRM0pVMlhhSHVRR1U5elJH?=
 =?utf-8?B?ODJjSDVVY0tuYStJcjNkeXVmbm5xWEt2SXVnZXFCbDdYa0crbzlubjV1U09k?=
 =?utf-8?B?MXRqK0k0VWtpTEJPVGNHQ21CODdnYVhZRFVjTUkxYVhMc3ZJSVhBbTB3VmMw?=
 =?utf-8?B?VWdFa1JsZVJ1NVI0UTdmNVJMai9jamRsdXBiY2ZKOEtzelFNK01ZbUkyZS8w?=
 =?utf-8?B?di9hS014b2MxRzN1bWh4eE13ZXh3U3FUTk1taUVrUllXaWl5WFQ1b2JlT0Ev?=
 =?utf-8?B?S3h0NzNxbHF2MkcyS29vN0NRZjBTeGU0S3JpNW8rWTRLOVI5bFdMYlE5MU5z?=
 =?utf-8?B?N3pML3pCa3lWclZDd24xNTBGNDZPWVR1OWZFb2N4YThRdXFQWGdWUkdNYU5y?=
 =?utf-8?B?Y2tGZG55WlJRYjhWbVJIWEdKY1RRR2t4YlRzRFBwWWtLMVRHRGV6MCtBdkQz?=
 =?utf-8?B?T0FFZDFKT0ZCNVlqN2lnSTB4WklZVEx5aXl3OHJ2VnVlVWVJbXdzT0ZGdGZV?=
 =?utf-8?B?SGFTKzBTSDF2emlBTk90dk9rKzJmR0w3WUVReEFEUVRucXl2U2hwVEdvaU94?=
 =?utf-8?B?M283bXExZmNURWhVTG9yMHJlT29ZTXlLSis5UjhRNTR6MkMyL1pBWFFkYmh4?=
 =?utf-8?B?M0U0Qnhpdm16SzJpQzlvRzZjN25WWHZRcXhNNE4wbEYwNkt5WlY2TkJiVGp4?=
 =?utf-8?B?NjVOVEVqRjdQVUlVYWQyR1Vka21SR0ROb0pHR3pWMUJ0TiswZ095VnQzUXNL?=
 =?utf-8?B?ZVA3ajRraUdGbHpkL2V2d2NRRnZxbnNtMGx1S0hyejI3akp6QTFUbWZzYTcx?=
 =?utf-8?B?UnNYbWxBSUVvTEZqZjlFY2JVeUplSS9adEhoTGxYY09rRnp5Nys5ZzRKd2t2?=
 =?utf-8?B?RE1Edlg5SGVYemZWVUNSTXMwb1BEVWQ0WEV0TmpOb1BJWW5zc3RkSmIzZThH?=
 =?utf-8?B?V0xMWnFEeXFzMXNpSDg5RDRYd3NhZnUxK0F4T3MyVVB2U1pTZ1doVkFydkhL?=
 =?utf-8?B?S2dsSSt2UGVlYjZsTm9kQVBsNkhtazhtQ3VmQURLSmo2UFRadnN1amdrUlN3?=
 =?utf-8?B?azRKc2NYcDNCcnpZYUlOUGI4ZWxtWTNTa0RZb0s4OEdEOGRHclozbDd2Qk1L?=
 =?utf-8?B?ZFZaUjAxUTVnYWNDRGdTaERLbTB0Wk05anhMSnZ5WkxHLytGRFFSY1hySDVz?=
 =?utf-8?B?S2h3ZnVBK1l5TU94MGdZV09GS09ldEEvU3V2MndaSU1OTnA1U0hPaXZDaHkw?=
 =?utf-8?B?U2g2VW44UFlhUlJaSi9hNEFSUG5wckFGSTh3dmVlVkc0bGxsdEhld0RyZlk1?=
 =?utf-8?B?UTlyaEduSkN1V3Z6Z2tLTDVDQUc2V3Z5anJURnFaUnZLSHdaVm1Qd09VbEJ4?=
 =?utf-8?B?TEdDL2EzQ2NYZ205N0FPL1FDSFU5NjR4OVBucGtCWEJLN3RldzRkamw4REFj?=
 =?utf-8?B?aThxOFdZbThtZUxIZ2IzcHJzTkhBZnMvMGJkeDFHN25ReFdJM2JtUmRwZTli?=
 =?utf-8?B?YTZqUDVncGdmNjMwTUV1VjIwNld5dExUaTJ1ZnloTlZreXFmMDhVZ2dlNnRT?=
 =?utf-8?B?Q2h4ZC9CQzdKcEwyejh6Wm9NMmlydjE1QjNWSys0L0VqZDdmbjBhYTc3MDdq?=
 =?utf-8?B?aGJMdVNEUklWTmFCeDVoWlAxVU9leE1NdHRpcWFjOS9CVS9vUzFJSnlCY2tp?=
 =?utf-8?B?MnczQUxYK1B0Zmx2cnp0MGR3OGo2ZTFLZnZsS1FrYjN0U1owODR1WlYzUys5?=
 =?utf-8?B?MXJnUkV3bUZkdzB0eCtTMytmek5YOTBidkh1aFJ5YUVoTFErSWdaNElWTm9F?=
 =?utf-8?Q?p07kGldKymu8PSUwFB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7bd516a-1eb7-4b66-6772-08df462b6d07
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 10:54:03.9318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cMBio6AWa7ZPonfcVd8lLYlrn+kEoKWwTjHhUgkbgqAGGZlSZ+DrrvJl2T2BV4Ha
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR12MB727359
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

On 11/17/26 20:54, Shahyan Soltani wrote:
> Anytime amdgpu_vm_pt_clear() is called, a job is committed through
> vm->update_funcs->commit(). If the GPU is currently using SDMA, this
> triggers the function amdgpu_vm_sdma_commit(), which requires a fence
> slot due to it utilizing dma_resv_add_fence(). Since this slot is not
> provided in amdgpu_vm_validate() a kernel crash can occur.

Yeah that is not correct.

Fence slots are reserved when the root PD is locked, see function amdgpu_vm_lock_pd():

        /* We need at least two fences for the VM PD/PT updates */
        return drm_exec_prepare_obj(exec, &vm->root.bo->tbo.base,
                                    2 + num_fences);

Since all page tables share the same dma_resv object with the root PD that should be sufficient for all use cases.

Have you encountered an actual problem with this or is that just a precaution?

Regards,
Christian.


> 
> Reserve a fence slot with dma_resv_reserve_fences() before
> amdgpu_vm_pt_clear() is called.
> 
> Fixes: ddc3c87584e2 ("drm/amdgpu: clear vm pts upon a vm->generation mismatch")
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3bcfe0f3b35a..d5b758b5eb82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -658,6 +658,9 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		bo_base->moved = true;
>  
>  		if (vm->generation != new_vm_generation) {
> +			r = dma_resv_reserve_fences(bo_base->bo->tbo.base.resv, 1);
> +			if (r)
> +				return r;
>  			r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(bo_base->bo), false);
>  			if (r)
>  				return r;

