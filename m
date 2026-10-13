Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7E8CC6B0F
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 07:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 267C710F531;
	Tue, 13 Oct 2026 07:20:35 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011037.outbound.protection.outlook.com [52.101.62.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA60A10F50B
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 07:20:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+FtO9SaAgKGJLkREzMJetRHwV+ByPplUWgi85VEnDf4iAXxmxOh5yO3J7oQd3DD+Mho333CO+3c1TjQDmk0wTdj78T9TgfMM0C8wtbfrqJf3uHeRSSPm4dCe+c74Yw9WfvrMzv9nV1YFl50uSQebQhsqdtlVb8oMVY1MDN1a17onAsWT9NRQDt84EUr5JuaQk1K/HGiXvHTfNVMdkEhL6FqmXrgkT9HTKje8T2ipktzZNcehSd1euKhkHJ1iHKQNfsRbl4aJSSfzFD8hjtmoIaNu2FjQXUlL3FZ3pFOINzhPNHGxw5Lek/aHeXU2GtZ8JfQU0+xH2aMWuGG8ix4dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSXXImuMURbuSEZQgz4k22Rzpi8Jui7UEuvNw7JpIow=;
 b=jk3nhuvTd++yXWnpNhhyGJGiX+F0w7rKqhoCYXAbd6Js8R6UFNxzbVToBzpyu6j4ihfEf0/3TffKgmVZQqpyDfP4cKb5cmTa+wKtqsqeUYRyMEiRWH6cpX2Uti71ALtAEJiPcDfE+UBMKxRhqKhcORX0IlgJ8EIAjXXHR/CCYnTwcCgiKekjpbICRAMv/EFEOJCwQS4GulQgqtUK9wgH2L91VgmHefvhXL1OCBnsLGFesPUPn4yexTRs6eM04z8eiXt2/6EDZ6Gf5tvqD8V7+vG1+7rh6osxqME2OzwJhp9fCaUq2hMS6SjMoeXlqsOp8tEH8SHrnU/hNkzDyhl3cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSXXImuMURbuSEZQgz4k22Rzpi8Jui7UEuvNw7JpIow=;
 b=hxFqrMZoseL/bc1rvZu/FzGYNIxyJyvAf7MKl86FplxPtlAgpqcPiqcxke42k91nbyJ+tHPNgM7cEj4weL1154doCAfUdEKBsbfIh7nJvAl5eZfM6qxicjjqObLulFc9fdH1KYuffZTqME7pCDX6HXwDDSPFg3I6wdo1gPyRZWo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by CHBPR12MB047581.namprd12.prod.outlook.com (2603:10b6:610:369::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 07:19:38 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 07:19:38 +0000
Message-ID: <2a713cc2-6cf7-4f67-bded-3431978b509b@amd.com>
Date: Tue, 13 Oct 2026 09:19:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] drm/amdgpu: use spm_vmid for the default RLC SPM
 VMID
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261012092429.3937825-1-sunil.khatri@amd.com>
 <20261012092429.3937825-10-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261012092429.3937825-10-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0201.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::17) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|CHBPR12MB047581:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c6677b-8dd6-46c0-efbb-08df28fa574f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /ocL2sxJmU1AWA1c2XID5g5m0y5N1oRBZeJGxttyH6pJYiGycEc8w5svtNc+Vv0AU2Qm+Jj8fDGmr45js4eveNk6D6N9XVMHEb9OfKt6zZTWn+Y8hcV13bW4CgmypHEGlRC/0LWGdRT8l0s1UHig94AQbkqPtWFPGf/mwwzRxZaut8AuPFjkkA2QMPkqPK7dNz7KX993EKT8xcd+uSMd7Jm0sPhWgR5RuY9gLL5l4onsWUyVhRvmCpOTEjQ10qkSNK7VmmbGp6W9a70u4+ajpJokiuNtf4Ke0i7xkO10v805kQbI2gvdbNoXHbTI6gf3qq30OpW6bTnHwp9bW1PafbWp9vHY4DaowKAhv4FpiWFVj7PrYe8bHFS/BtxY4UjO7q1c+9eNZSGGHJ0Urofnx4zyMN9Bci6KMt9LX2MPkRauihB3ukBfhnYLasvE0GCeqczQSz+1MxTnUyVH+DGnm1XjO8H0pLI2V/bzfCyOemYyMPrM5L5ZwK94WjiZcOEkYt88Pssdx79+IziqNfiXVVcHnSLwABSZPTKNisbFMSVBCVXFSZVevFkOK3s6ikMLM5NNw/Is1NkQxlxAS8jgib/vFVSKMrVqXUM+d6F7subMJ5F0SgYb5UoewrHL/XdAKnR4FiQYCVZIzeWU0gFGdBq2M89Z1ZDC/zxAbMChYeo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zzd1NVNIODA3ZUthTzl6dmZtNWNxSjVrN1F3eXlZOU5Jb2owcEJJVmpDK1ho?=
 =?utf-8?B?VklrdE5JOEJYc0NNb2E4QWhUeTR3ak9xSTFFUkhGa3E4VDV5YjYyckdGR3du?=
 =?utf-8?B?WGIvMndianJBMHBYYWJLREUzZlREREpuYUFpb0hHOGtoNTVyQWhLUmJqTEkv?=
 =?utf-8?B?TzRHQ25pTkVuSlEza21BajV4QmtQbStlNy92bWdpY3R5TG5zZWpWUTh1S0Vq?=
 =?utf-8?B?bnNLaTAxR2ZlTVZWemFpVjZ5MkhGNW05TUVvVTMzenJpM2hDVnVrNEczR3E4?=
 =?utf-8?B?a3VINDBYVzA0VmlSYWp2RlZsenJiMkdjU0ZZNG1ONjF2OU1hTmpJSGUrcEVt?=
 =?utf-8?B?V3FLTDc1K2prUXJnTFVQQW1CWEQ0SVdmVTBoRUY0YSttL0dHektjL0RoOXlZ?=
 =?utf-8?B?MkMwaEN2OHY0alpYYm9KTHN0TTREYkY4SUszWS9lZDF5UTQyek1MNGp2REtx?=
 =?utf-8?B?Z1ZybHpKT3lIUlJGZWxUQ0t6SWkxUG1wWUd4UU9GMDFhK0RBN0cwWUxEOHdD?=
 =?utf-8?B?YnFuTkxEUGJ0eUJQc2h1OGx6Tytha2xQOVhjL3pXM2RrMFJkYXVpQUhFZjRs?=
 =?utf-8?B?cFF5N0NkK1MzdUMxMjBXbjd2Vm9RYmN4c0lJM0ZQMEpLQ1JsZitTYXhOcGRP?=
 =?utf-8?B?eCtXQnVZTm9EcTB6YXVIeDJ6dTRZLzFIbFpqMlowU0llcDJIME1OSFd6RHBZ?=
 =?utf-8?B?VWduNnBSS2J5S2IwRWRPVW9aZUFHekpNWUtzem5XbldHSWxBNmQyc2R0NHps?=
 =?utf-8?B?WUdZalJyS25ZdUx6TnpiSFl1MkswZmVhR0RMMXdBUGJuR2JzWmpxdklwNm9p?=
 =?utf-8?B?SGtPRzNTV2VYeTRxaWFPV2VCelBlTkhVbUJwNGZzOFVBTmxyNjZmaGpFVWo1?=
 =?utf-8?B?U1dmaXdXQnl5SWg5SUVBV2NNWkxXTE00YjRoQkVDSjNSa01kYktUZWJYc1Fh?=
 =?utf-8?B?TitVSzhzU3ROQUI0VjlBVXFybWNlYXlJc0V1NkwxWkVvVFV6TW0zYi9QZjdO?=
 =?utf-8?B?NmJTLzRoeEs0MjhGSU1VSEdFU3NjL0J0bDdhSmU2RFFSRXlZbGNHdmR5QytK?=
 =?utf-8?B?ZFk5RW44Vkg1bTRSQm4xYjRTdHYwSTlWWE04bVl2SndHUVhScFVmTmJ0djdn?=
 =?utf-8?B?d01iWlNuMmpzdldOTmhGcmNLeG93L2U5Y045czVUMURCVWNUMHJ5NzFOdHY5?=
 =?utf-8?B?NXRQdmFjdXpXMjBuSnBrdzdyQlFGVGpGQms5ZDZlaG1Gd0NOaEtzMkJ4dGxG?=
 =?utf-8?B?MTZvMEQvRDRtdFdxRlVjWDhxMC81VDBDblRScmtXSUdGd2FxVndXQkpHVlVw?=
 =?utf-8?B?MFdVUFVHenAxcUtwc25QbTNhTFRNOU4zUzlFOGxSY0NIUmtnbUdoS09td0hl?=
 =?utf-8?B?OFJuQTI2Ui9GV1JQNUtvTnMwMG9WcityaVlNUms1VGxQbjB2bklLait3OUhY?=
 =?utf-8?B?RTJpWkp5Nlc4c3JTSU8wL3UxTVYrdklMdkVJSFpRU1QxQmx4Vk0vWU45UEtu?=
 =?utf-8?B?NjNnRUt6Z01kTDZXbDFxRWV3WnJyRU05OFlsTWgwYzk2Y094alpDUVdGL002?=
 =?utf-8?B?cXJsdlJmVWhqNm9oK3ArMCt3QWoyZ2FmSFROSWlPWDlkZTRhOTRURVlZdTVj?=
 =?utf-8?B?OHRjWlFFTjBBTk03NW5sU3hHZWJKL0JpMjJJSUtXdVk3a1VzWWVzeDF2UVBT?=
 =?utf-8?B?Wk1KeGVCcDhVb3pzMmgyK0ppQlNsK080TmhsN3JreDJsOXRHYmJnVDdkdVV2?=
 =?utf-8?B?RC9Iby9zUlN5eEFibE1wc3d2TjdHbW43U1dIdjZ3Ky9LNFI1aVRRdloyNUhM?=
 =?utf-8?B?VHRuc1FVa0NDcUdHdWZyelpSd3RYVnRFc1JyMkR1NGlvMFF4R040TDlhUVFs?=
 =?utf-8?B?cEhzSFhsZmJNTmdTc3ozajNCNVpoc1ltWUxwTFNVSk0xT01DL3NUZmVBZnJT?=
 =?utf-8?B?cU0yWVMxQTNGb21VdG1ZUnFROGNhczBnSWxyYnFoZER2cGZOcGc3T2M3d2JG?=
 =?utf-8?B?aTFFSDhrcExjTm1OSU9HUWxkbEhNeWxsNWZsd01ZTlFDdUdMRmZiQWJkTENl?=
 =?utf-8?B?NEs5cCtLM1R6YkZ3OGp4eXJvd2JUWmo3UStCTDNYQzFMcVN3TjNNbGxpdTVS?=
 =?utf-8?B?RnM5WEk2YVpINitJUWxqVytpdlY0THF1MjUvVnM4M0NrU1poOEFIcEtSamtz?=
 =?utf-8?B?b3pBeGVJWWlLVzNoMjFZZzR2aE1ZK2tqdFpVS1BzVWduTk04OEZUZnhyMlMx?=
 =?utf-8?B?djJlV0tydnVEbGNWZjQ3Q2h5cjZvaWpFQzY1MHgvME5Wd1JCcklkQlRqY1U5?=
 =?utf-8?Q?9WoHf9ko9tcHw4Z3mP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c6677b-8dd6-46c0-efbb-08df28fa574f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 07:19:38.3129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/azLr8i9ieFG9Z0B8zUFts1bSue979tEs93viH0FF9FVQ9TE7G8dWeK3JltH3MY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB047581
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

On 10/12/26 11:24, Sunil Khatri wrote:
> The RLC bring-up paths programmed the RLC_SPM_VMID field to a hardcoded
> 0xf as the idle default. Now that the dedicated SPM VMID is tracked in
> vm_manager.spm_vmid, use it directly so the idle default matches the
> VMID the reservation path hands out.
> 
> No functional change: spm_vmid is the top VMID (0xf) on all affected
> generations (gfx7 through gfx12).
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 +-
>  8 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index e791bf86ad571..fce651d9bc613 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -5575,7 +5575,7 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
>  
>  		gfx_v10_0_init_csb(adev);
>  
> -		gfx_v10_0_update_spm_vmid_internal(adev, 0xf);
> +		gfx_v10_0_update_spm_vmid_internal(adev, adev->vm_manager.spm_vmid);
>  
>  		if (!amdgpu_sriov_vf(adev)) /* enable RLC SRM */
>  			gfx_v10_0_rlc_enable_srm(adev);
> @@ -5607,7 +5607,7 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
>  
>  		gfx_v10_0_init_csb(adev);
>  
> -		gfx_v10_0_update_spm_vmid_internal(adev, 0xf);
> +		gfx_v10_0_update_spm_vmid_internal(adev, adev->vm_manager.spm_vmid);
>  
>  		adev->gfx.rlc.funcs->start(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 1caecf26c4589..1f2ad47adb9fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -944,7 +944,7 @@ static int gfx_v11_0_rlc_init(struct amdgpu_device *adev)
>  
>  	/* init spm vmid with 0xf */
>  	if (adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index a5151e15e1011..72ceb113689e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -773,7 +773,7 @@ static int gfx_v12_0_rlc_init(struct amdgpu_device *adev)
>  
>  	/* init spm vmid with 0xf */
>  	if (adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index 4ceb3c0aa3322..b44f5ec68714d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -1861,7 +1861,7 @@ static int gfx_v12_1_xcc_rlc_resume(struct amdgpu_device *adev,
>  	int r;
>  
>  	/* init spm vmid with 0xf */
> -	gfx_v12_1_update_spm_vmid(adev, xcc_id, NULL, 0xf);
> +	gfx_v12_1_update_spm_vmid(adev, xcc_id, NULL, adev->vm_manager.spm_vmid);
>  
>  	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>  		gfx_v12_1_xcc_init_csb(adev, xcc_id);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 2eaea0e4864dd..91ce21425126f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -3252,7 +3252,7 @@ static int gfx_v7_0_rlc_init(struct amdgpu_device *adev)
>  
>  	/* init spm vmid with 0xf */
>  	if (adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 696558f6f30d3..479480e39fe47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1274,7 +1274,7 @@ static int gfx_v8_0_rlc_init(struct amdgpu_device *adev)
>  
>  	/* init spm vmid with 0xf */
>  	if (adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>  AMDGPU_MMHUB0_START
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 3fb51417ebee5..8afcdb54a0f56 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3233,7 +3233,7 @@ static int gfx_v9_0_rlc_resume(struct amdgpu_device *adev)
>  		break;
>  	}
>  
> -	gfx_v9_0_update_spm_vmid_internal(adev, 0xf);
> +	gfx_v9_0_update_spm_vmid_internal(adev, adev->vm_manager.spm_vmid);
>  
>  	adev->gfx.rlc.funcs->start(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 3572eb9b5758a..1d1973fd8f677 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1395,7 +1395,7 @@ static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
>  {
>  	/* init spm vmid with 0xf */
>  	if (adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>  
>  	return 0;
>  }

