Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C99BC07E9A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 15:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEDFA60FEB
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 15:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEDFA60FEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9374E6E3EE;
	Wed, 14 Jul 2021 15:59:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7439E6E3EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 15:59:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLT4czViUJ/Vgmgz+JuYwCrdpFmzhNEWvShdvIodh/rPB1XX51/S+ddAsjHBoFMxVUbA4IWThFHjgxJQWJ3025CxVjnkyGTt0cVD/WiNLVJVVgIznYi2Cnhq8f59IVaivO9vBovjYu17cZjfnWIl/bZx3pjKQNo5gRqyXctw/+i9xepSr+PnpMfD3PEwIIbXc5FUSXeH73pE6PXBuQ1bm2jwJwvfN+INFQmCfg6mm8OdRIUUkTlUOokk3CnDZ9RN5177nIn671vbSkJ+PyxHIwshmQ0XXlYd97DVcBpHoIbSOoOJ9U9RcQhnRj6l6niGxArFw4Wznw0VUbikcrOCdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5DYjDk8wH+qizyK3AGoGPdVBRBqfutlDM28kkT24qM=;
 b=jwFf09lbbV4tKRB1SoReX/8IA73tpwXM4oNIp7h+KM72nUPH1IE+wtV984e90oRcquSzGrTrOvbRSCUFLBcsGDt9d/5ZgiIouOdZk0F6VJ5hi8de0aeOUF2LpOxVEHPP4x6VZzzvAhAR1QET491XtmKx7nMjt/5Ymm7p4RN6AzVz5mmHG2ibcuS/uH5FdJ7sjEi7y/HJ0vxQrLZRyjwrhYSLL8fbg4j1tAUhmmFYKXMuKlCj4YNVDd+1R2IzE8z3iBqU+rG+hDhgT35RaPaXmS8saATZOCeuunt5nx2JIe++vtl9pedy5wbl84H7LAhK3oSyJpC1uAIfv6jpHv7KHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5DYjDk8wH+qizyK3AGoGPdVBRBqfutlDM28kkT24qM=;
 b=iBz614+NcwzSY1G5H9UbhQaqkjY8GfTPXWLezqkMU4maibmOMuvMzu0x+3h/Hbqrs/HDfBI1767K3aWU8t5S8FoB+TCUNsluHbyQmsVPsD7+6fq35T2JYoP7YzXoSeoeZUfUP8LADGCXm8z2bCca7FpkiqbvMQqpVgvhGaF9nEE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5130.namprd12.prod.outlook.com (2603:10b6:408:137::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Wed, 14 Jul
 2021 15:59:06 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 15:59:06 +0000
Subject: Re: [PATCH] drm/amdkfd: Only apply heavy-weight TLB flush on Aldebaran
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210708195333.322119-1-jinhuieric.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <dbaf4665-c723-1ead-acef-df1f80f339a5@amd.com>
Date: Wed, 14 Jul 2021 11:59:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210708195333.322119-1-jinhuieric.huang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::26) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.84.51) by
 YT1PR01CA0087.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Wed, 14 Jul 2021 15:59:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93744e8e-30e7-4564-ee7b-08d946e04f1d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5130:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5130B9EE90BFDF259B6933D492139@BN9PR12MB5130.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jNzKaxcE3RsTLi4cMnLfb3mjKb3ZYX4BtyL6mBJ+ZvAVN+KvNE738bpxcJC/0LzAaMXY3RVLKLt5znCpJFlnopTQyNx5P3tT3nAOzd/3wjjOr1KKleR7NXcQCG8b+MLuc8gyiD+Oid1IPAMuj5ZEIjH8Bfz9Ki92Q6zx6EGmrLDP99l8qOkVSRfpw9JqU0KsSCU2AH0sRLLti7+DcTx9YfUaDOMxma2gJSIZuKNXwckyFwsQ10620VGqbtpToNldoJCHokVusgMKqhyjuopspazxqVzm3rIxsmbs7vfjUe8rakfhGfBySk08vCOFm6ThK37NUYXeQWSAOmHcFM8EXc7mWqeUW54aB89mpIV5DYQh2Jb3tbKa5w2n8vyq427/OGZvvLbo6KWMoGeL56vTM1eEoUAoYBBFP5TPs+PMiKTvw+rL2JKVkobH4o3EzN9d60+7uOsiaOzmCd0meCi8BmE6pwku5EwMt4tJX6wgQTHmJJq2dlU2O33hymqxdH0HFkkvrFv2TtBvrxHr81YOsVvCSaSnGqjhMpXFyrvPKehQ+u0YjR6YqDn1lACo4t+QGC3PBBQC7i/WPwYTg1MTNWzDNLjfnVQVuJYKQz/J9A5bbePn+eIBcKdI/PebTSj+VFqykXA84K/Kit8362r9/q5ff52ckfLSShijNbjtlt/Kq9PlCVJY+iK+/wVIgBBJ0n4wlMcnal70enDWZLwAvgDXW6J+S3IT5IPXB1G1k+MznwBwdGqHGLC2Av/f0o1FsTVJ8a4ESwj6+GR6ZfBkYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(316002)(956004)(2616005)(44832011)(8676002)(2906002)(478600001)(16576012)(186003)(83380400001)(6486002)(66476007)(5660300002)(38100700002)(36756003)(8936002)(26005)(66946007)(31696002)(86362001)(66556008)(31686004)(16393002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVArQ09qU3htU2ZhTWVQVGhZSmg2TEcxMWd3WksvK05SdDdocnZ4UlJSMktP?=
 =?utf-8?B?MStGL2t5WGhHZFdTRnhURjFHR1FlbHNudmNhQVpFTTduTjZiRWZ5MCs3MGZK?=
 =?utf-8?B?MTdrQmpKT3E2a3BVNVdRdHRFVnlUN1gwNk1MZnNyTmdvSk5RL2pMVG4rU1NW?=
 =?utf-8?B?QkpTVnNqTzZkaEdHZzNUMkNFOE54Rjk1cG0vSHlBVXhzSEpWdmovdlJ3aVpK?=
 =?utf-8?B?bmhhaG9qWXJPWTQ1QzEvbEdZVmQ0Ym5nNkI5bTBjKzhkY0VyWnBRTjcxUGdV?=
 =?utf-8?B?bmtnWjNBQXFTZS9Jb3lKWnlGdXo0VnRTcjNXZG42SVFPUU1XUXZUZ2lkSGt1?=
 =?utf-8?B?WC9rcjBCcnRpVVJaenIwb3ZDSFh6bFhnS3d0cWwwSkhUUUg1eGxIaHYrOE1C?=
 =?utf-8?B?NEM1N3k4Q2MrMHVGZ0g0Z0xEV3dRd25BYVdvQ2RpUkVPNEJNaFlUMTFzWjBB?=
 =?utf-8?B?N0kxUkQ1MDM5cld0a2R5eW9tVllUcWxRSkN6S3J4RnM0QVEydWY1UytDZU9k?=
 =?utf-8?B?KzJ4TWJ2WlVzUmVEYnRlUHNaTVJPSWdxLzgzdU1YbklGQ0FJQ3kxM0NDUTRu?=
 =?utf-8?B?Rm5IZGJ6eVc3dWhTZVpIWjJLK3dGaXJXUXJlNzZscm9tcy9MRGhuNU5mUDJ3?=
 =?utf-8?B?Ynp5eTRZbWErQlNIUk9MdWEyTkxNcEsrSzNjdzZXQzluZThyTkpTTmV5a04x?=
 =?utf-8?B?RFVMUEFYWllxZU04aHU2aldMM29CQklKS05RQURzbHFId2dSMjdVZC82UkYy?=
 =?utf-8?B?QnpnQ2pOd1JaOWwvaFRoOTgzRnBYeE04ZmNoSlJrNFlxeU05UDZYY1NKaFZm?=
 =?utf-8?B?Nk0zVlJhR2ZPWGMvcitiQmJNS2p5QkdBZUg5VVJVOVVFTkw4MmtOWU8zQUxT?=
 =?utf-8?B?c01qeDA2Y1llK1dIcXJRbWFQeGwzMDBRTWJldGxmZENRWWM2RkNUZk1pdzVs?=
 =?utf-8?B?eG10R3IvV2NjSk0rRU52b2lPRThKN3V5ZGxTaVZMSzlyWUVKcVBIVU9hZzM3?=
 =?utf-8?B?UXdXenVWQ1JmRnFJNjVjUEplNE41bG5QanVrRDlmWE4yNlJMYUZBTURLQXNP?=
 =?utf-8?B?K0xxT3dIZTd5em5wWjBDbTR2WEV3YUtBWEM0SzVKc2VjSnlWRDZOSVlJdVRF?=
 =?utf-8?B?SVgxcUVGei9jWWNPc1BmNnI0Y1V4QnZ2RDJ5VDBXNE9NS0ZKVDhocnBZWHBa?=
 =?utf-8?B?MWJHQmdjOTlwTFUxVTBVVG5CaU9EYVZoUDdKdFZlMURtRWxDUkI4Rm1obzJr?=
 =?utf-8?B?MTVPdlk5S3E3SWVvM3pUckxLZWpFMFJRTlV4V3BodFhleXFiTVd6dUQrSk9P?=
 =?utf-8?B?dHpiZzNTTjFnVnllNWQ1WEp6QWRscGE4REltckd5OHpnVVAxZjBNeHNkRTA3?=
 =?utf-8?B?TXR4dGxYSUZLeVAzNzNoL3FIWVVjZkxCUVlJcWEyNDMxMnV1ZFY0eUlxcWJ5?=
 =?utf-8?B?a3phWUxaWXI4MXEyL2JuNVh5Z0o0M0FUZDdJRStyanpWR0hQT29Qc3R5OWhy?=
 =?utf-8?B?TGc1UjFvMDFzOEZ1R3pVQkRGNVVLR1VsVm1PMTRlZkJEOERuaG1iQWpWc2hD?=
 =?utf-8?B?SnEyR0RiZjg0UW9FTmEwVWFWUU8vY0prUHAwL1BlbUhodFhsVStHNExwN2hr?=
 =?utf-8?B?RndwLzJ1TE1nQ3NqdnhlLzhhcDRUcWIwdVFmVzlXVS9nVGJ2WlczWWdEQjdK?=
 =?utf-8?B?MDdhODB2NXZEeDFPZzZLWVVQU2RNTlR0eWpKUWRnUGhSalJoUW1UYVFjK3I5?=
 =?utf-8?Q?ix+c7fxtnj+crTuoxwrdlyWCd4h930M9UiP+Zp3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93744e8e-30e7-4564-ee7b-08d946e04f1d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 15:59:06.4581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eruUtrdz4hou6uOB9pkZP9z2o4K3Ol3o0HbALwW8SHgXnB5IBx8fUITDrqy9KYo+7/NmYn0Pr8czw64/S6b/0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5130
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-07-08 um 3:53 p.m. schrieb Eric Huang:
> It is to workaround HW bug on other Asics and based on
> reverting two commits:
>   drm/amdkfd: Add heavy-weight TLB flush after unmapping
>   drm/amdkfd: Add memory sync before TLB flush on unmap
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 37 +++++++++++++-----------
>  1 file changed, 20 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index ebb4872c5a9d..5f2655cf0162 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1773,26 +1773,29 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>  	}
>  	mutex_unlock(&p->mutex);
>  
> -	err = amdgpu_amdkfd_gpuvm_sync_memory(dev->kgd, (struct kgd_mem *) mem, true);
> -	if (err) {
> -		pr_debug("Sync memory failed, wait interrupted by user signal\n");
> -		goto sync_memory_failed;
> -	}
> +	if (dev->device_info->asic_family == CHIP_ALDEBARAN) {
> +		err = amdgpu_amdkfd_gpuvm_sync_memory(dev->kgd,
> +				(struct kgd_mem *) mem, true);
>  
> -	/* Flush TLBs after waiting for the page table updates to complete */
> -	for (i = 0; i < args->n_devices; i++) {
> -		peer = kfd_device_by_id(devices_arr[i]);
> -		if (WARN_ON_ONCE(!peer))
> -			continue;
> -		peer_pdd = kfd_get_process_device_data(peer, p);
> -		if (WARN_ON_ONCE(!peer_pdd))
> -			continue;
> -		if (!amdgpu_read_lock(peer->ddev, true)) {
> -			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
> -			amdgpu_read_unlock(peer->ddev);
> +		if (err) {
> +			pr_debug("Sync memory failed, wait interrupted by user signal\n");
> +			goto sync_memory_failed;
>  		}
> -	}
>  
> +		/* Flush TLBs after waiting for the page table updates to complete */
> +		for (i = 0; i < args->n_devices; i++) {
> +			peer = kfd_device_by_id(devices_arr[i]);
> +			if (WARN_ON_ONCE(!peer))
> +				continue;
> +			peer_pdd = kfd_get_process_device_data(peer, p);
> +			if (WARN_ON_ONCE(!peer_pdd))
> +				continue;
> +			if (!amdgpu_read_lock(peer->ddev, true)) {
> +				kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
> +				amdgpu_read_unlock(peer->ddev);
> +			}
> +		}
> +	}
>  	kfree(devices_arr);
>  
>  	return 0;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
