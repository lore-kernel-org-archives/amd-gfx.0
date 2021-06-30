Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875A1C11F65
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 21:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2806B61477
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 21:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2806B61477
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFE4F6EA8B;
	Wed, 30 Jun 2021 21:57:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 543386EA8B
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 21:57:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H96UFmsxGUhBIfTFmCbGYPJhhGZ7GBB8vZC4XnlqCCFPwXEsjzWjCWT7bcx436lkGzAygS1YuZwnkZQVcKw6bpQr3ngxoY0XtjmN1wOpfpr0v8JLyo9X08gvjfbtnNGCj4/iOEdiRdOizBGTQbeRGhV7clhpPRw+z4Cdpl217IboR4fMYEXtxHlUrTO9btyEtl6b5FUQIMatCT/ynJYrTZ4vAf15ngRd9HA+BRca8mYu6cO017E+XT5Ke2omVg6bBfnOHWylaEc5zJIFs0dCjaYln0C3IV04p3WGMtbUDY0SQmJ9PByn2UBoPCdErIGqhBAYj52rSnpmUPhi2nUjXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3QrLmwZijsBn0anTabrWpE/ULm6PMkaGjfxekHgDIU=;
 b=eyDDz6OMgwhr0/a2mPf53geWzNAaaW9Ps/4Prfk9gLly0PjsgBqUEwKwTrJiSyRUW26XdZn6ZREr9JJcss/uFedhb8pifv0idPkSF6s8nHqzI4MXySlqR8k/38+IcRQgIBxQ8nGUf9QpL5AY82Fhepvxb6kZKQqZA9UBhK5wL4+SIxrSIlziDPfK2r/Ku5EVPzelsENHh3Q1s9XxXJqqZvTMy5TeuWpY1241v/4TYHo/FMcJTPY5KuoLzkdRXpIbmCOtNjnDEuNS5Ea7NUKNLh6soeZ25UgALA+SIlYTJywny6+L+IaM5OiAR0J/ngAl0XP0MvN46v+oONh28TZ54Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3QrLmwZijsBn0anTabrWpE/ULm6PMkaGjfxekHgDIU=;
 b=PM5UFr5yfOU8LOgoAPpR9vjkcK/cQ23zI9Z/7VmBIwzJwDdbjH+WAGGdQUnO7QVzWeebYsaLHrqlhg5nRnhYWp1TJqKYPbm2qf81v1x097kwl3CNYjG8AsMPLXSECXyz1WkPQMLlNY+L7GCWsDpun/6kv5ecWSEaaut7Sz+8dXc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5116.namprd12.prod.outlook.com (2603:10b6:408:119::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Wed, 30 Jun
 2021 21:57:42 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 21:57:42 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: separate out vm pasid assignment
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210629151907.4251-1-nirmoy.das@amd.com>
 <20210629151907.4251-2-nirmoy.das@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <c25d5480-0359-87c5-3a05-76790fd5044e@amd.com>
Date: Wed, 30 Jun 2021 17:57:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210629151907.4251-2-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::32) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YT1PR01CA0093.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.23 via Frontend Transport; Wed, 30 Jun 2021 21:57:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53d88c03-f7c1-48ce-7ebe-08d93c121599
X-MS-TrafficTypeDiagnostic: BN9PR12MB5116:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB51169904E0B44E3AEBFCC46792019@BN9PR12MB5116.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XNhgL9tTyuE4/y6fpCaBn+LPA69wG/6BzY6rXyICLUV4LrBcpE5BunPJ7buur7jwLzypjefxL6LhmFYRyVjJVHo2Tq08YL4O0LtPtSfwnp1YAipoBd43kr2xNAJZQy48wjP29nVzrmKJat2H2aWwtRDDDd8eSdydvzPui2nKGJpb0JLmpj4zcC7zyFymKFyU2l63D4cS7uXedGcl3e3xXKYdcZZEgaodCVrL/qhMixUawzgxbtWgveQYU4v+wKvIJNYsebj93KEqJegdDL883qjvQ4UT1pYhZR4GBLAhtWvAZzu08DenFlIYyaCSpIBfiG3PeNytbGb8YgzjAiMb54I5Ulfmxe4RtjRbK9s8vVidLM5NiqCQuvSHbWIMjKiQssxolvSl7nYP/b4Nacs0NSKtLUZtms57wEyvW3I4OBzbx62GELRxNPWKSws17EdNsGj3qdLSPqcx4gv1T1OGDrjWDHH06ZkAIDcP2QoQRyXeZRJcFbZ/La9Tixexel6/1sg8TprJS089G5CCiIUwNwY/lxtGzcxjFFs3eTncPyxFkzfyhtNAQVoAzUtSkxUVl7YzHxmBeFPd4wIEOG8SrwH02XlpWASIwEqElsXiqWCm7Syx6lIt2EXB+i8qOcKwj9XbXB0tXhhJqDaggR7kL5KerZvQYqV4w94MDGnSKEbZxtlHSt1W1sTwxItOpPOTL93JDB0saEcZ3yBiiVwRGx4/dJyIFg5LCsGkuJ91MQzo98MC9ryq62tuzUUkC98p
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(31686004)(2906002)(53546011)(83380400001)(44832011)(31696002)(66946007)(316002)(956004)(4326008)(86362001)(26005)(38100700002)(8676002)(6486002)(66476007)(8936002)(16526019)(2616005)(36916002)(186003)(16576012)(66556008)(36756003)(5660300002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzFhcDZJaGYwcUZtV0laNm5HeVROSVV2b001QnhmdjRzT1VSMDlwMGJHRElN?=
 =?utf-8?B?aXE2dzdGOGNiNVB2SUg3cXNyVE5HQ3p0QitNaWV2SURBM0s4MXJqYStuUXRU?=
 =?utf-8?B?T3ZGSVVwdllLczAwU0tjbHhEdFoyd084QW5DTlp3RlNjV2Z1ZEFTelhDZGsy?=
 =?utf-8?B?MUpIT0x2QWJDcnhSc3NDSFd0bEhjZ09SNzZoY1BWMWZObnNrMW16dzN3RmZk?=
 =?utf-8?B?RTFPL2lCSXY5QTNtOE56V2VVZURnTVV2UDloaFFLdmZhMkwwUGNzSWMyczcv?=
 =?utf-8?B?NXR4NzZxN2dJY3NDMkU1L1Fvd2xKWEh6UzFqU3l0ZUc4d09rd2lPdE9wMThm?=
 =?utf-8?B?aFNxdXEyVzh2Wi9NQ252T2lYQkpsOGxVNjhkZjJ2Y20xOE1vMFM4TUoxWEJW?=
 =?utf-8?B?SXhYbFJZelRFdVVsQm81dVFpVFdCNWIya09BOC9COStxMzZLbE8xdnJ6aTQv?=
 =?utf-8?B?cEhjZ1hBZzVZb25LY3R6N0grL09iaFdDWlJZV0VTaG12WUxTclRpNGxoQ0py?=
 =?utf-8?B?WjR3STkrS2xtVVUzMzJLTEhBSEZlNVpkOWoxcjNNaTRKbEprVlhCV01mT0dw?=
 =?utf-8?B?dUR4dzVzUGx6aTNFREVhTWlESWI5SDdJV29DKzBpTkFUQ1B0S3MxWVhKS2NB?=
 =?utf-8?B?WFZtU3lZUFdaTFBuWEgvUzRVSVIyK3NjVytscFFESjJ6ay9vbkZ2Q2Rqa1B1?=
 =?utf-8?B?b3A0aGVIYi9qSGpFdDczQjF5VjJnTXpUdzRGOUJVbkNiVUlHT3dQZzdCNGd5?=
 =?utf-8?B?VXc3aFdXTHZMS0UzdzJSNTl0VWUzZzkxMTRNT1lHTUlNZEt6UVI2UHNVNm90?=
 =?utf-8?B?TTcvelFxMm8wcWQzQUJZVkNuajFaRGx1emtWYlg1SEMwSkZxR2FHbGZuRm5E?=
 =?utf-8?B?MzIyRnE3MzlCSUhJSFRlS1dsMjNuVnZxWXFEak0wK2puZ1NiTmcxc0VkMnFp?=
 =?utf-8?B?UnZkMy84YWE3c2xuSm1MMHFaSFRFTG1MejVEd044Y3U1R2FYUkZLREE2QTRR?=
 =?utf-8?B?NXU1a3ZtQWFPenpSRWMvNEx6MjZUNEZJVFFlbEZJeGx3cmJPVXR2MzdRQTZX?=
 =?utf-8?B?RnlENExTR0J4czBiYUE3dEhuaXFsZWNVbVVRWDZZOTlIR2tjYXJZUmVQYW9V?=
 =?utf-8?B?cTNUQlVCN3Q4L1FtRjliZnE5ZHFSajNkWGgrYzhCNGJBMXY1YUNnQjVZWnRm?=
 =?utf-8?B?cWlhbUx4Z2JEaGplbysxNThPNTEvejMwU1B3SDJpYUJBVzAxSkFCNHBXMHFG?=
 =?utf-8?B?eGM3QkgzcXMrUTlWQXV6dUo0SXMvQ1E4cnk0dkc5Q21nTmVheDAyMU1xblo3?=
 =?utf-8?B?OVN4WFZxeW1Hak9NZndieTZpZi95eEtxTlRqQTdDVFBqdTFWZVJXc284MW1M?=
 =?utf-8?B?Y2xoMHdyZkFGb1Q4K0xWcGoydU5vcUNaQ0ZnK3ZtRUpma0taVVVQcXZtKzFz?=
 =?utf-8?B?Tlhmb21rcUY0VlJ3REZsclE1ZytzYmVXY1NSNDVrVkUzWlgrSm0vUDdOeTZy?=
 =?utf-8?B?K3gxYzl5c0xBQTVnbURJUlppbElRenZJMzZwVkRjQU0vd0QvM1Z5Z1k4amlK?=
 =?utf-8?B?WWl4M0ovWllpSk5qdnhJblkzZldza0F4MWlqTGgyZ0xSRWdMMjBTWnFDbHZ3?=
 =?utf-8?B?VTBsRFpSYTFpUjFlUWU1anc3eUdDRXFrM1lSV1pGc2tJVEJlR3k0SWo5c3Fh?=
 =?utf-8?B?WU1KM0NacDA0L3krempHbTUrKzVQWEVkNXh0QmpSazRQeXlGb0c0SGhNR21S?=
 =?utf-8?Q?KQIN3Uj0ZV8MPlWCaYyZ7v0rjcirDocKcyAwIPJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d88c03-f7c1-48ce-7ebe-08d93c121599
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 21:57:42.0737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TsTP2kXZ1Ywv7rfL+O9DFD99nhJZIwXaOmcfB0AxsyfEzDEzZlW8LXMe6AiW8qnktBzJsXyK+0zBz/ns6s/L4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5116
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
Cc: Christian.Koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-06-29 11:19 a.m., Nirmoy Das wrote:
> Use new helper function amdgpu_vm_set_pasid() to
> assign vm pasid value. This also ensures that we don't free
> a pasid from vm code as pasids are allocated somewhere else.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>

Christian's comments notwithstanding, the series is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 13 ++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       | 10 +++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 28 +++----------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  4 +--
>   4 files changed, 26 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index f96598279593..3a2ac7f66bbd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1287,11 +1287,22 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct kgd_dev *kgd,
>   	if (avm->process_info)
>   		return -EINVAL;
>   
> +	/* Free the original amdgpu allocated pasid,
> +	 * will be replaced with kfd allocated pasid.
> +	 */
> +	if (avm->pasid) {
> +		amdgpu_pasid_free(avm->pasid);
> +		amdgpu_vm_set_pasid(adev, avm, 0);
> +	}
> +
>   	/* Convert VM into a compute VM */
> -	ret = amdgpu_vm_make_compute(adev, avm, pasid);
> +	ret = amdgpu_vm_make_compute(adev, avm);
>   	if (ret)
>   		return ret;
>   
> +	ret = amdgpu_vm_set_pasid(adev, avm, pasid);
> +	if (ret)
> +		return ret;
>   	/* Initialize KFD part of the VM and process info */
>   	ret = init_kfd_vm(avm, process_info, ef);
>   	if (ret)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index cbb932f97355..66bf8b0c56bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1178,10 +1178,14 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>   		pasid = 0;
>   	}
>   
> -	r = amdgpu_vm_init(adev, &fpriv->vm, pasid);
> +	r = amdgpu_vm_init(adev, &fpriv->vm);
>   	if (r)
>   		goto error_pasid;
>   
> +	r = amdgpu_vm_set_pasid(adev, &fpriv->vm, pasid);
> +	if (r)
> +		goto error_vm;
> +
>   	fpriv->prt_va = amdgpu_vm_bo_add(adev, &fpriv->vm, NULL);
>   	if (!fpriv->prt_va) {
>   		r = -ENOMEM;
> @@ -1209,8 +1213,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>   	amdgpu_vm_fini(adev, &fpriv->vm);
>   
>   error_pasid:
> -	if (pasid)
> +	if (pasid) {
>   		amdgpu_pasid_free(pasid);
> +		amdgpu_vm_set_pasid(adev, &fpriv->vm, 0);
> +	}
>   
>   	kfree(fpriv);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index fd92ff27931a..1dccede6387e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2899,14 +2899,13 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
>    *
>    * @adev: amdgpu_device pointer
>    * @vm: requested vm
> - * @pasid: Process address space identifier
>    *
>    * Init @vm fields.
>    *
>    * Returns:
>    * 0 for success, error for failure.
>    */
> -int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
> +int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   {
>   	struct amdgpu_bo *root_bo;
>   	struct amdgpu_bo_vm *root;
> @@ -2980,10 +2979,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
>   
>   	amdgpu_bo_unreserve(vm->root.bo);
>   
> -	r = amdgpu_vm_set_pasid(adev, vm, pasid);
> -	if (r)
> -		goto error_free_root;
> -
>   	INIT_KFIFO(vm->faults);
>   
>   	return 0;
> @@ -3039,7 +3034,6 @@ static int amdgpu_vm_check_clean_reserved(struct amdgpu_device *adev,
>    *
>    * @adev: amdgpu_device pointer
>    * @vm: requested vm
> - * @pasid: pasid to use
>    *
>    * This only works on GFX VMs that don't have any BOs added and no
>    * page tables allocated yet.
> @@ -3047,7 +3041,6 @@ static int amdgpu_vm_check_clean_reserved(struct amdgpu_device *adev,
>    * Changes the following VM parameters:
>    * - use_cpu_for_update
>    * - pte_supports_ats
> - * - pasid (old PASID is released, because compute manages its own PASIDs)
>    *
>    * Reinitializes the page directory to reflect the changed ATS
>    * setting.
> @@ -3055,8 +3048,7 @@ static int amdgpu_vm_check_clean_reserved(struct amdgpu_device *adev,
>    * Returns:
>    * 0 for success, -errno for errors.
>    */
> -int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			   u32 pasid)
> +int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   {
>   	bool pte_support_ats = (adev->asic_type == CHIP_RAVEN);
>   	int r;
> @@ -3070,16 +3062,6 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (r)
>   		goto unreserve_bo;
>   
> -	/* Free the original amdgpu allocated pasid,
> -	 * will be replaced with kfd allocated pasid.
> -	 */
> -	if (vm->pasid)
> -		amdgpu_pasid_free(vm->pasid);
> -
> -	r = amdgpu_vm_set_pasid(adev, vm, pasid);
> -	if (r)
> -		goto unreserve_bo;
> -
>   	/* Check if PD needs to be reinitialized and do it before
>   	 * changing any other state, in case it fails.
>   	 */
> @@ -3089,7 +3071,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   				       to_amdgpu_bo_vm(vm->root.bo),
>   				       false);
>   		if (r)
> -			goto free_pasid_entry;
> +			goto unreserve_bo;
>   	}
>   
>   	/* Update VM state */
> @@ -3106,7 +3088,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		r = amdgpu_bo_sync_wait(vm->root.bo,
>   					AMDGPU_FENCE_OWNER_UNDEFINED, true);
>   		if (r)
> -			goto free_pasid_entry;
> +			goto unreserve_bo;
>   
>   		vm->update_funcs = &amdgpu_vm_cpu_funcs;
>   	} else {
> @@ -3121,8 +3103,6 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	goto unreserve_bo;
>   
> -free_pasid_entry:
> -	amdgpu_vm_set_pasid(adev, vm, 0);
>   unreserve_bo:
>   	amdgpu_bo_unreserve(vm->root.bo);
>   	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 8e8bc132e590..a0bceccaa6b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -378,8 +378,8 @@ int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			unsigned long pasid);
>   
>   long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
> -int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid);
> -int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid);
> +int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm);
> +int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>   void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>   void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>   void amdgpu_vm_get_pd_bo(struct amdgpu_vm *vm,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
