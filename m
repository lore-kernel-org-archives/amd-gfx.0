Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16A0C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Dec 2022 23:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F67210E400;
	Tue, 20 Dec 2022 23:28:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EB0E10E400
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 23:28:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3MHf19rSRgqDfkCxk5gfWZQjNfj5iyr6SrEwn65h5k/QFuiO3V5h/C9RQHh5Jdfkz/NxmIVdRfXObr1w2Ji0Qogvv+Kqa3OTOLiDstythVjUqzK5X4t64VJwJhz4tebs6HN/2b4ZYvGnKxNtlvrnI8JQmgg9fqEuP32hVcPkbB8rQdzkZaADJ5r8ILj7qMr5erivY1jyqEsiatWglS2MwjVzfdt/dkgneLCXToK+F96lkfCoF0MK2ADmm6M/RbjOeOdz73d3XUf5955ZzqzMe1gnloIplW1siDgd00sk2/ZSjJxRj+W3YpXCK7Ex2YJ1wWWvFcHT19sgGBew6Z/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSUyzPoBm6pw8CikCpyrC26FuVGUbA5X+EY31LWKFsg=;
 b=FIkZxMpkb90CsfnvwYRWw4wxpVN8Timn4WHtuT2KCGYOq4g7BLzzHT2F4n5OVttQcTQZafyEfpphjcfqGIsH7QefBdNU2+VL7ngSviezDlLjRDCwZRKfzn4yWYc5KU+PPom04yiifP+bpyIF0MaQkkq2fqwkujI5HLHEWoShwNStL8fg4sey7N2NoxcUb0Zig44uei1st+Ch3/xlnHpe+cFuhfeUAIxy4Oc0Yyrzk4Xl13g3MkMRZcNogemJGy55ZzZiP6Mq5gu3fuSXYWZ/pqfjNPuzgLL5t0jgtnKtdxpjlZNUTAG3iE/MH57FNjgWCDeYaEoAG+Gdy63qUET25A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSUyzPoBm6pw8CikCpyrC26FuVGUbA5X+EY31LWKFsg=;
 b=WUJNpQ3WzWiYJEsH/Rx28OQFzFp8q/+HwF0dVoinVmisfHORtvtZvSdiH6tvCy773JL1UjPHdXHHm94xzw2jf/jLSW5hvSd+82IvXmlgjTqwV1OCaFekVOfZH1ts/WCxhnANyeUocmWnKWcF5eK/hW3e2N8MRispYSC1JKfqI6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB6668.namprd12.prod.outlook.com (2603:10b6:510:1aa::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 23:28:44 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%4]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 23:28:44 +0000
Message-ID: <ba38fdff-8c67-a844-b085-24b9b5880225@amd.com>
Date: Tue, 20 Dec 2022 18:28:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/1] drm/amdkfd: Cleanup vm process info if init vm failed
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221220203604.27260-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221220203604.27260-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::32) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: 96d3a0ba-4100-4216-664e-08dae2e1efbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iJEquSOLfIgnTf7eJLLat0+hJ1DLcCGwVOBShojSWVBNiQTP+XhqlC6qQDQIWm6r5S1b64uVB9Kdg2AN6q1hVYGRdhPgNEAlnXKW6IQEeznQ5BhadS+Rcp+TLG/yltOI9CAvpEjZcxruLNrUkhJmQJARZfvq0T2AailkBT+wBaraeMmx4ZcLWDhFo1SHzLA79knuTJk+fXP92mcCIRbil3AkoBeUdHtnPd2Nfncj48/LFi3+w0Z5tu2UVMJHuB05IP9J/JYXny3UyM4eIBvpNlxGh02Xb0yM4UuW1PlEPbLWYYF03zC2x4XLQW9bWpt6dsHnjDyi23DuKWVD8tU0wZv3DlswWDeg5JejG0KWPs+6mQPizkBEtulREwbeS068bCyaS1QuqH9/5UAERIsY+ntS+m9EH4IlhzMSc7yXdI/ME0ZEzWE4nvv2KaG4HD4MTbT8wLN/dWwzwRrLUg7JstiOE15/Kl/kGR2okTBY58Phko6UNKAVB8HpFBhNm/utnPdqF4M9STvvyqdFhh2ppObP+MP+Xkc3N8qs5e3/WuzPtUzWmalvTHxvDQRvuve25yN/ucH46sygQL6+GJI39J10ivwKa59VPnDaA4OV4jTs+4x9aORA1nUySB4QesNH3RXMLHeuv7OYCDmuH5AsL+0+mK7lPLMwTZL/KLQs7KiN89/zEue8IsVO6A/ekFfyDAPcvP0LTE9qgzK+iLlqWFqSGswmvpNgvirkZb/Acu4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199015)(36756003)(6486002)(86362001)(26005)(36916002)(478600001)(31696002)(316002)(66556008)(44832011)(5660300002)(2906002)(4001150100001)(8676002)(8936002)(66476007)(66946007)(41300700001)(38100700002)(2616005)(186003)(83380400001)(6512007)(53546011)(6506007)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHZRNGp6L2I2VnpTYXRxSzJHL1poS080N0gxa3NOaXBEQStVTWhVMHNBdHRF?=
 =?utf-8?B?dnE4YUZrVDY1SHJTMlNlaUEzWEZHaUtNZDB4NnZvREJST2RhY0pBWGdqR3RD?=
 =?utf-8?B?ZnV1Y2VFYzVGVjc2T3pZVnNRUlJrRTBVZUt0Nm9RMEVRcEJkMjBvM01LZmt4?=
 =?utf-8?B?YWhRdU5SY3NWa1d3SDJFVkVEZUJINXFSZUxBR0xDaGJIc3Iyd3A1bzQyL2xm?=
 =?utf-8?B?SHdzcUFsejk2QzVQVUtxb2dqUGtmMEVZYTN0Z3E3WUthc2kwWW1uZnY4NUFK?=
 =?utf-8?B?R2F0blBETk5tYmhNMERlaGFTQzZyUXR6Ky9WVUpWS05DL1NaV2x3OFdvQmRv?=
 =?utf-8?B?UWVjU0JhdVU4SkNqZjJFSzliVFA2a1cxVlRucUxzdk84eWFESTUzMHhXUTBC?=
 =?utf-8?B?aXpINGxNTjNpQ0J6dGtWZ0ZsRThCdTIzT3hFejVxU0lGVWQzcmNKVUpBUERY?=
 =?utf-8?B?VndSTWRVd1Y1LzNJaURwTDAzOVdVZkdGR3NEM1kwekhObkpxSkwwaWtZSzdj?=
 =?utf-8?B?SWtCV0t0NDU2Y0paQXM4ZFNrQ3V1N0ZyeG1rR1JyVE54VUhPTXlleERxKzhh?=
 =?utf-8?B?QjJSN0Z0RkRoNEZ0am5pT0J2dzFEQjR1d3NKQk9JWlJjUXBuZ29XZElIcnZx?=
 =?utf-8?B?ZUpXeEQwdldWL1NMSUZ3aDFkRnU4TmpYUklJbkw0MG9yRDFESXhJT3RmOTJI?=
 =?utf-8?B?bDVoZVNLRHFSb28va1dFa0h0UHFXQkVqOHk1bEltcUNGSmsrcUxnOENveVJn?=
 =?utf-8?B?LytLZTVyN1RQNkVXVVlBeDVYY2lnSjE5V1ZmWEZOMWNBREt3Wk1QWjRzNmhZ?=
 =?utf-8?B?TEloUGdiVkNiQm1hRDhWM3hPMlpVcGJNcVBkNld1bU0ra0VZb1VqeU5ITWhY?=
 =?utf-8?B?T0NPT2lkWFhIbVBZWUFnNXJmcW1mZmEwL3hCdlVWMjBtNFFsTjBZZGtHa1Yw?=
 =?utf-8?B?VCttNG1sWEEvN2srV3NRWkM4ZTlzbXdpOXVnSFRjcjFnNHFKRXNGS1FsMU5s?=
 =?utf-8?B?WlFWY2J4RVJMNG5SSXplQmZ6U05ENzF5dHJpc0F6OUg2OFFqWTVtaDQ1WG4r?=
 =?utf-8?B?d2ZNRDZtdEVYNGdSV1pEYkw5M2dZZUZYQXZ4NFhZNUNiV2ppMmEwdGRYNGhm?=
 =?utf-8?B?VDdpVEFkSVRlUC9veEFVVE1TWDhRNjhaQ3BlbEJZbXJTdnJZb1l6NHJ0QXNO?=
 =?utf-8?B?Ymd6cW5vdWxURjBwRmVHaW9iVmc3c250b2xudWZZMUZEY0NWSGtERjN5QSs1?=
 =?utf-8?B?a2p1QWhCU3RkZzd2cEM0V0FBOEY3Rm5najlzWVVLK2hUT3FZWWhWNmcrQkJT?=
 =?utf-8?B?MmM2OEU0dW15MkdlWmFlWjd5NmRha0pXVFFYUml6S09YWERaL0ZZeDBNVzhp?=
 =?utf-8?B?dWs3Qm0zSHdTNEt0SEhZS1E2QkJYbHR1MG84ZXdkNnBsZnk0VXdyUjlSODE5?=
 =?utf-8?B?WUNLODQ3M2NTVkdadGJoeGgrWVJ0SjFoSis2Y0ZtRTZtSUFZalRFQVQ5OTZM?=
 =?utf-8?B?ODlUT2tOKzFvR1hETWJ5VGdNeWpkMEp4OVA0MkYwcnlNSWdTZXVydlErR2VH?=
 =?utf-8?B?Q2t4K0g2RmpTa2xPRENEem1UUTliSUJDL25tUU1IV0pCV2Y5ZkFINTQ5c1Bk?=
 =?utf-8?B?VkJKL1A0QmVMcGpORWNZQ3JlODlDcWZSaldsUnZWK2xYS3BpYVN2bXBxMHNQ?=
 =?utf-8?B?RDV2akdveU56VXRkK2xlT1g5Q3JKakl6a0JDUWtnbUMwRFhhY0xTcEsxQkt0?=
 =?utf-8?B?eitPc2hvdWRjZXhoNHlxdEV6cDBDaENRNEhxYjVpL0lvQWJQU3dRMFBtQnkw?=
 =?utf-8?B?M3JPM3M2bmVhMFBuYzVwRm1MdHowZENwN0swd05IVWV0WWJJMTRUcm1QMHlH?=
 =?utf-8?B?WHg1bEJxKy9keCs0S2Y3aXRWZWtwcWlrOVdyWjMyeHdyVGZxeHc1YjJvcDJh?=
 =?utf-8?B?YmtUMnZIdW9rR2tCU3h0K0g3b2lhWGNGU3hUODBiRjFuWmkrTU5ja1NBR0Nh?=
 =?utf-8?B?aVgycFVocmhkbTlmSllYUzFQNUNwWVJVeDhDOHRmeFhTZ3BLanowRXUwVWhT?=
 =?utf-8?B?dVI2eWxjZUp3NHE4dk9FOVBrZ1B5eDlCTnlIK3lJMGVpRUxHSlZWNjVaaDhS?=
 =?utf-8?Q?KHYP3pB+vKXVOAUf+Ompp/Oov?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d3a0ba-4100-4216-664e-08dae2e1efbc
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 23:28:44.5685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeYlMkEagV4p2KHH9OTw0up6dmKjBl/PrzVvnfzgeObjXiltlNHoNqzilUkfyW4AbEva8xy5bslyXhZC6bbozQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6668
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

On 2022-12-20 15:36, Philip Yang wrote:
> If acquire_vm failed when initializing KFD vm, set vm->process_info to
> NULL and free process info, otherwise, the future acquire_vm will
> always fail as vm->process_info is not NULL.
>
> Pass avm as parameter to remove the duplicate code.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

I'm still curious what caused the acquire_vm failure in the first place.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h     |  4 ++--
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 18 ++----------------
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c       | 12 ++++++++++--
>   3 files changed, 14 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 0040deaf8a83..fb41869e357a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -271,9 +271,9 @@ int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_
>   		((struct drm_file *)(drm_priv))->driver_priv)->vm)
>   
>   int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
> -				     struct file *filp, u32 pasid);
> +				     struct amdgpu_vm *avm, u32 pasid);
>   int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
> -					struct file *filp,
> +					struct amdgpu_vm *avm,
>   					void **process_info,
>   					struct dma_fence **ef);
>   void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index b15091d8310d..2a118669d0e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1430,18 +1430,11 @@ static void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
>   }
>   
>   int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
> -				     struct file *filp, u32 pasid)
> +				     struct amdgpu_vm *avm, u32 pasid)
>   
>   {
> -	struct amdgpu_fpriv *drv_priv;
> -	struct amdgpu_vm *avm;
>   	int ret;
>   
> -	ret = amdgpu_file_to_fpriv(filp, &drv_priv);
> -	if (ret)
> -		return ret;
> -	avm = &drv_priv->vm;
> -
>   	/* Free the original amdgpu allocated pasid,
>   	 * will be replaced with kfd allocated pasid.
>   	 */
> @@ -1458,19 +1451,12 @@ int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
>   }
>   
>   int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
> -					   struct file *filp,
> +					   struct amdgpu_vm *avm,
>   					   void **process_info,
>   					   struct dma_fence **ef)
>   {
> -	struct amdgpu_fpriv *drv_priv;
> -	struct amdgpu_vm *avm;
>   	int ret;
>   
> -	ret = amdgpu_file_to_fpriv(filp, &drv_priv);
> -	if (ret)
> -		return ret;
> -	avm = &drv_priv->vm;
> -
>   	/* Already a compute VM? */
>   	if (avm->process_info)
>   		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 51b1683ac5c1..71db24fefe05 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1563,6 +1563,8 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
>   int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>   			       struct file *drm_file)
>   {
> +	struct amdgpu_fpriv *drv_priv;
> +	struct amdgpu_vm *avm;
>   	struct kfd_process *p;
>   	struct kfd_dev *dev;
>   	int ret;
> @@ -1573,10 +1575,15 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>   	if (pdd->drm_priv)
>   		return -EBUSY;
>   
> +	ret = amdgpu_file_to_fpriv(drm_file, &drv_priv);
> +	if (ret)
> +		return ret;
> +	avm = &drv_priv->vm;
> +
>   	p = pdd->process;
>   	dev = pdd->dev;
>   
> -	ret = amdgpu_amdkfd_gpuvm_acquire_process_vm(dev->adev, drm_file,
> +	ret = amdgpu_amdkfd_gpuvm_acquire_process_vm(dev->adev, avm,
>   						     &p->kgd_process_info,
>   						     &p->ef);
>   	if (ret) {
> @@ -1593,7 +1600,7 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>   	if (ret)
>   		goto err_init_cwsr;
>   
> -	ret = amdgpu_amdkfd_gpuvm_set_vm_pasid(dev->adev, drm_file, p->pasid);
> +	ret = amdgpu_amdkfd_gpuvm_set_vm_pasid(dev->adev, avm, p->pasid);
>   	if (ret)
>   		goto err_set_pasid;
>   
> @@ -1607,6 +1614,7 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>   	kfd_process_device_destroy_ib_mem(pdd);
>   err_reserve_ib_mem:
>   	pdd->drm_priv = NULL;
> +	amdgpu_amdkfd_gpuvm_destroy_cb(dev->adev, avm);
>   
>   	return ret;
>   }
