Return-Path: <SRS0=KKXi=LR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF29C4743C
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 08:24:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D6FD6108E
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 08:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6FD6108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1EFF6E839;
	Wed, 23 Jun 2021 08:24:07 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2078.outbound.protection.outlook.com [40.107.101.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 699FB6E839
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jun 2021 08:24:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YONc2XQ6RoP2vZedfxURGKHe7VamE4hOzGuFz5tzKKO/aoEyCi1LLXnBG0K+mn/dCgvyo14gEuV+9oa8yO5hGAN/yZAyEdhurjFA3WFUACLAjmIQqudojic/k18CoyAA9E10KYs4iNUHmjpPRUPKneamgZQMPZgyaKWJEd3TYrMp/rXHFZ6JJfkzZ9ZHC3KuE5JAG4En+F/pWD1xBbvPZdom3t5Ynk8kPV0hK1v+ktZcOllemWTjQOqcxKKIf4x+qD38pcIIrOLpNMukqauudmEnz0wqNpUk2J+bEWrgWhUG2qlMc3utP4jCbOdRcf4HSjFT4yOrs31RgJnJyc6+gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1XEEM31rMKo/bCP8f7fPiOeVF3CKMKdMlx70sb0p38=;
 b=mffp8R72eWLpyYgIqU+LgIizseZtlpPbnkUoEj2IQkqqf+ielRrSFYfy2fT51LhkHVvy6QOs2WVAy7Js2dsAPsUNZMvnuToaqPyPXrqpxb2kf93LX0OMesY3Dkj+e4lPVYFbX04E4ludvOgz4ZuJhhZjuDIcmTP/GutFVx+Ef5a1xmxvbhQniT1XS3Xhxls3GryPfnjeCVjgDVZltnc45TudhwFRA8IDh2PidGugSWa0wyxm0e+v1MOu/Z6Y11GO6WiQlnbbcSAOcasGfj/1UTMuVIoYVm1nOGbU3L45TTbTi9yRXTwcUgrjwWHC433R8veTNVQGSQwOH/sS9LgW4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1XEEM31rMKo/bCP8f7fPiOeVF3CKMKdMlx70sb0p38=;
 b=LGPsmMJe9mJD6iMJXK4QhWRMXgDdcYjeT6vtpbN5X2ZSdZmFg/97qff6OLED2g7hQH+WfmQiFiFb6SSzIkHjPOCrbBLnpLKmnMG4DNJFRc8tCoyh5pV+vjlyj2xZvJlWSZpCVFQ7jYS4VXBOhNDadHt4Af6d5DEesKAQaaxmU+g=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3935.namprd12.prod.outlook.com (2603:10b6:208:168::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 08:24:04 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4242.024; Wed, 23 Jun 2021
 08:24:04 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: cleanup pasid handling
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210623075627.14797-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <55afea58-fb31-12c7-26bb-051dd8ccd5fa@amd.com>
Date: Wed, 23 Jun 2021 10:23:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210623075627.14797-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:69e4:a619:aa86:4e9c]
X-ClientProxiedBy: PR2PR09CA0017.eurprd09.prod.outlook.com
 (2603:10a6:101:16::29) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:69e4:a619:aa86:4e9c]
 (2a02:908:1252:fb60:69e4:a619:aa86:4e9c) by
 PR2PR09CA0017.eurprd09.prod.outlook.com (2603:10a6:101:16::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.18 via Frontend Transport; Wed, 23 Jun 2021 08:24:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23ff496e-475f-4e86-bbca-08d9362042bb
X-MS-TrafficTypeDiagnostic: MN2PR12MB3935:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB393596C07194FE8D99ED364183089@MN2PR12MB3935.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wXeH6TxXcghwwj2H8k0VXJRJr3WjhfiqRO1zXS3FfGp99I6biqpjK2ic12BCwT1v6MgJE24DOUTqXLcDTlUzhDzLkVMRUobFU4Wpgr7pEHJISQ9Zz/KhwXCqWFsg8J8Q4zNmk4mC6CQ/RQw7kTYA8W8DYxsg/iAzYoOSmBgC0yaK/c/oRllqsdrpgPAAU9BpjRbqAYSa8iQJr6Lr/WmILeMX8j53lFU7Kp1CaSmVmuC+ZfATf88Yyc3BgSUTVSk0xojEd2eaSmC7DncP/wL4Zm3WJYm7K9QmOpVonHJy2W1qYxtHS5Jurx+jhZ9LJGJ7qQC49UgrcXslzVoLLiTtoIFDIZxP82ZSQ8hMfiqgD4JXwHCZI/lPg8suHfnQ9P6e2xmDdtepHv6BMsIe0v+DJafgY8frlucxvtXcvA55ibquuOaXccLm2/NlVVwHacM3NF+9CyTHfG/SZYB84S2PFqozrs3OKcVyQLZmsOH8kgeES6dp+jkLKq5zMC0AQs+zKuPppDMUXZWRp/NkTeWshtcb3WAjx6/DQ82CBK5U+VEj7wM2cfJ/35YyooX9Zk+sc7kta2YOVQkrCUHexfLAf1UxVJB5Wo0gP7LCpAUanSjdcvIgNbehka7eTB+31amOUTJqFRej8WP00U3Bw+dX1/f5chpYIVD2yTW4lhntagH8DcexS69vnjbx4g9XwKNH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(4326008)(5660300002)(36756003)(6666004)(38100700002)(478600001)(316002)(16526019)(186003)(2906002)(2616005)(8676002)(86362001)(66556008)(66476007)(8936002)(66946007)(31696002)(6486002)(83380400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkQwR3hndlFMenhjR0xhU2J1ZS8rSGh4QXJ2RU1neVlMeXVpWDQ1elprcFZL?=
 =?utf-8?B?d05qT3NnMk9Ja3hxTWVoM0pzcUY4eXpveHZRWWxsNFlRUENjYXo2Tno3aWZM?=
 =?utf-8?B?OXRrNFhHdUxrSHVHcWVReElwNXE5VnR2QXEvRTJVb2plSElNazNtV0ozdjNh?=
 =?utf-8?B?b3Y5ZXc0WCsyQjk1Ym5YY3ZIUWIyOWdpWTRjOGdjK0piU1NPVHpFc1ppUERJ?=
 =?utf-8?B?VlZ2Z2RFN0ZidStkVEJyaU5ST1dOYkVoc0crL1Urd1V4Z2tXckhCNHlxOHNM?=
 =?utf-8?B?L1I5Q2E1SmNoZFdkUUpUWDNHOUhGOWR1dzVZS29Jc1RCZHpCZ3gxcjJPTm4r?=
 =?utf-8?B?U08zcHZ3V2Q4dDROZUIwQTZNcU90b29MQlRvcGpKYjVXYTJNb01Nd20yT0FW?=
 =?utf-8?B?b3JwNGdzUTdOTDVYVFB2WkJnQTFpaklIemh5NVRueEFuYkhSNkRidm5iMlVY?=
 =?utf-8?B?RTVncUVobU9RcFFpeTV2TVhtUU9ZZnRZTThnZ1JnaTJ5Zm9sdi9QbHFxOFZs?=
 =?utf-8?B?SEIxNi9CNm1iaU9vTmtpdWY2MFV4RFU3VHJJcmk0VjhUNzNWdElmRkRmd29t?=
 =?utf-8?B?ZWFrWVFyWW0zaEpUUGhVeWdUdGpteGNrcjdTZWE0NlhLMHhibjZVMEhiR1VG?=
 =?utf-8?B?MVJZbm90NDRXWTZnbU9CZXFVaUtMLzJMczZMaUJOZnd3SmFqZ29lS2ZOSEE0?=
 =?utf-8?B?bHRwa1c2SUxmRlBqdlgzMkZVZ1JpYmVIQXlrUGVvOElNbEc2SzZ5NmlqRGRV?=
 =?utf-8?B?MEtNaWNzaGxIVWQyMTE1Wmk2SDlkM3g1cnM1KzduY0htcERSTDBPcUhQblRr?=
 =?utf-8?B?YU1TbGNVSnJ2V09LdnRFdExqblZpU0FndjJkV21HSXU5Nk9qejExdzNoakxJ?=
 =?utf-8?B?ZDJwT2NUUzZYbkRjQTFqdzRkNzV2ajFsSTk3QVhjOC9OQSt0V2dteWR0cFBm?=
 =?utf-8?B?ZUd5YiszZXp5RExzWEVVMm5BS09TVnF2ajc5aFRXY2M1d3hiaTFTSDByZEg0?=
 =?utf-8?B?Yk9SUkczUmRZTnNrZmVvdkUvNzRnblJEY0IybE9UNXJydm5ZZEl2Rm9tRlhi?=
 =?utf-8?B?SUc0azArWWY1Z1JXa0xFN2VzR0FlL2YwMDNXRWQ2SFBrV0ppUFdrUld4R1RM?=
 =?utf-8?B?Sk5WeUxuNjF5aHRwUnNUYW45bFRGZFJFVlQ4UEpQVUhzOENQRnIxRTNXQWFa?=
 =?utf-8?B?b3BxcTdaeDlDQlZubTVudHM4MHNNdXV5M2twUlN2RmFLTFkxQUxiT3JrV1Zh?=
 =?utf-8?B?ZkhJeStvZmxodFJFcllIYzE0NGk5dFBpQnU3Y2VRcStIcXJSelNpOElFSVNS?=
 =?utf-8?B?TXJHZFdMclg5T1Vxa2pVbElSckllWitmTkdlcW5wZEQzN0tmUDBtOWQyd0VJ?=
 =?utf-8?B?UG1DWllLck4wYnJ4ZkVFYW9sNjJJWW10QzVGcytvTkNxcytEZ0dNMHNwSWhN?=
 =?utf-8?B?aWhjS281N0l3blVZV2VTb041b2Q3bi83ckxlclcra0JTNnJtV3JhRmVqblg5?=
 =?utf-8?B?Nm5EWTVTTGw0ZHhCSUFHV2ptSTIxcHh1SjY2ZDRyTFdMTzZ3V0c5LzdhZXgv?=
 =?utf-8?B?TzlZcFVudVYvU1VNdTFMVUI5ZlZWNWdyU2I0VWJ1Ulpad0NzN0ltSFdhdkZS?=
 =?utf-8?B?N0IwRUhLT1RxK1Y4MDFqM3VDYzcxUXZLNm9MSC9yOGoyMFRuRDhabVBDelk4?=
 =?utf-8?B?Y2haMlByS29BeE9tbzhicVoyM2NmZHptSGZFNDdQeThzN2lMcEUvRnhvOHFx?=
 =?utf-8?B?UXBuZVJ6Ui9QSHJtZk1YTzErNVRicFU0bmttM0Y2M3krUy8zU2c0Rmd0U281?=
 =?utf-8?B?am04TFJ5RlBSQXNTK2RGbTdhb2ZkUlIybWxubXNhNFU0T293M3NKTFg3Q1M5?=
 =?utf-8?Q?ibQBT6HTcK0TP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ff496e-475f-4e86-bbca-08d9362042bb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 08:24:04.2944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfHpihhd64i5IlILvCZTcPqmfQ7fpFUL4hACYzY2yV7DAFuvqYD56aOHXzD6WMi+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3935
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
Cc: Felix.Kuehling@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 23.06.21 um 09:56 schrieb Nirmoy Das:
> Cleanup code related to vm pasid by adding helper functions.
> Also replace idr with xarray as we actually need hash functionality.

That looks quite a bit better than before, but I think we should 
approach it differently.

First of all make a patch which moves amdgpu_pasid_free() outside of the 
VM code.

We don't allocate the pasid inside the VM code for good reasons so we 
shouldn't free it either.

Then in a second patch make a function amdgpu_vm_set_pasid(adev, vm, pasid);

When the pasid is zero we remove the VM from the xarray, otherwise we 
update the entry.

Thanks,
Christian.

>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 130 ++++++++++++-------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   3 +-
>   2 files changed, 62 insertions(+), 71 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 63975bda8e76..abba1e2de264 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -87,6 +87,45 @@ struct amdgpu_prt_cb {
>   	struct dma_fence_cb cb;
>   };
>   
> +static int amdgpu_vm_pasid_insert(struct amdgpu_device *adev,
> +				  struct amdgpu_vm *vm,
> +				  unsigned long pasid,
> +				  unsigned int *vm_pasid)
> +{
> +	unsigned long flags;
> +	int r;
> +
> +	if (!pasid)
> +		return 0;
> +
> +	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
> +	r = xa_err(__xa_store(&adev->vm_manager.pasids, pasid, vm, GFP_ATOMIC));
> +	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
> +	if (r < 0)
> +		return r;
> +	if (vm_pasid)
> +		*vm_pasid = pasid;
> +
> +	return 0;
> +}
> +
> +static void amdgpu_vm_pasid_remove(struct amdgpu_device *adev,
> +				   unsigned long pasid,
> +				   unsigned int *vm_pasid)
> +{
> +	unsigned long flags;
> +
> +	if (!pasid)
> +		return;
> +
> +	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
> +	__xa_erase(&adev->vm_manager.pasids, pasid);
> +	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
> +
> +	if (vm_pasid)
> +		*vm_pasid = 0;
> +}
> +
>   /*
>    * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
>    * happens while holding this lock anywhere to prevent deadlocks when
> @@ -2940,18 +2979,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
>   
>   	amdgpu_bo_unreserve(vm->root.bo);
>   
> -	if (pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid + 1,
> -			      GFP_ATOMIC);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -		if (r < 0)
> -			goto error_free_root;
> -
> -		vm->pasid = pasid;
> -	}
> +	r = amdgpu_vm_pasid_insert(adev, vm, pasid, &vm->pasid);
> +	if (r)
> +		goto error_free_root;
>   
>   	INIT_KFIFO(vm->faults);
>   
> @@ -3038,19 +3068,9 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	r = amdgpu_vm_check_clean_reserved(adev, vm);
>   	if (r)
>   		goto unreserve_bo;
> -
> -	if (pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid + 1,
> -			      GFP_ATOMIC);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -
> -		if (r == -ENOSPC)
> -			goto unreserve_bo;
> -		r = 0;
> -	}
> +	r = amdgpu_vm_pasid_insert(adev, vm, pasid, NULL);
> +	if (r)
> +		goto unreserve_bo;
>   
>   	/* Check if PD needs to be reinitialized and do it before
>   	 * changing any other state, in case it fails.
> @@ -3089,35 +3109,23 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	vm->is_compute_context = true;
>   
>   	if (vm->pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -
>   		/* Free the original amdgpu allocated pasid
>   		 * Will be replaced with kfd allocated pasid
>   		 */
>   		amdgpu_pasid_free(vm->pasid);
> -		vm->pasid = 0;
> +		amdgpu_vm_pasid_remove(adev, vm->pasid, &vm->pasid);
>   	}
>   
>   	/* Free the shadow bo for compute VM */
>   	amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.bo)->shadow);
> -
>   	if (pasid)
>   		vm->pasid = pasid;
>   
>   	goto unreserve_bo;
>   
>   free_idr:
> -	if (pasid) {
> -		unsigned long flags;
> +	amdgpu_vm_pasid_remove(adev, pasid, NULL);
>   
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		idr_remove(&adev->vm_manager.pasid_idr, pasid);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -	}
>   unreserve_bo:
>   	amdgpu_bo_unreserve(vm->root.bo);
>   	return r;
> @@ -3133,14 +3141,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>    */
>   void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   {
> -	if (vm->pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -	}
> -	vm->pasid = 0;
> +	amdgpu_vm_pasid_remove(adev, vm->pasid, &vm->pasid);
>   	vm->is_compute_context = false;
>   }
>   
> @@ -3164,15 +3165,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   
>   	root = amdgpu_bo_ref(vm->root.bo);
>   	amdgpu_bo_reserve(root, true);
> -	if (vm->pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -		vm->pasid = 0;
> -	}
> -
> +	amdgpu_vm_pasid_remove(adev, vm->pasid, &vm->pasid);
>   	dma_fence_wait(vm->last_unlocked, false);
>   	dma_fence_put(vm->last_unlocked);
>   
> @@ -3254,8 +3247,7 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
>   	adev->vm_manager.vm_update_mode = 0;
>   #endif
>   
> -	idr_init(&adev->vm_manager.pasid_idr);
> -	spin_lock_init(&adev->vm_manager.pasid_lock);
> +	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
>   }
>   
>   /**
> @@ -3267,8 +3259,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
>    */
>   void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
>   {
> -	WARN_ON(!idr_is_empty(&adev->vm_manager.pasid_idr));
> -	idr_destroy(&adev->vm_manager.pasid_idr);
> +	WARN_ON(!xa_empty(&adev->vm_manager.pasids));
> +	xa_destroy(&adev->vm_manager.pasids);
>   
>   	amdgpu_vmid_mgr_fini(adev);
>   }
> @@ -3337,13 +3329,13 @@ void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
>   	struct amdgpu_vm *vm;
>   	unsigned long flags;
>   
> -	spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> +	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
>   
> -	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
> +	vm = xa_load(&adev->vm_manager.pasids, pasid);
>   	if (vm)
>   		*task_info = vm->task_info;
>   
> -	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> +	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
>   }
>   
>   /**
> @@ -3385,15 +3377,15 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   	struct amdgpu_vm *vm;
>   	int r;
>   
> -	spin_lock_irqsave(&adev->vm_manager.pasid_lock, irqflags);
> -	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
> +	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
> +	vm = xa_load(&adev->vm_manager.pasids, pasid);
>   	if (vm) {
>   		root = amdgpu_bo_ref(vm->root.bo);
>   		is_compute_context = vm->is_compute_context;
>   	} else {
>   		root = NULL;
>   	}
> -	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, irqflags);
> +	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
>   
>   	if (!root)
>   		return false;
> @@ -3411,11 +3403,11 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   		goto error_unref;
>   
>   	/* Double check that the VM still exists */
> -	spin_lock_irqsave(&adev->vm_manager.pasid_lock, irqflags);
> -	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
> +	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
> +	vm = xa_load(&adev->vm_manager.pasids, pasid);
>   	if (vm && vm->root.bo != root)
>   		vm = NULL;
> -	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, irqflags);
> +	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
>   	if (!vm)
>   		goto error_unlock;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index ddb85a85cbba..31c467764162 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -359,8 +359,7 @@ struct amdgpu_vm_manager {
>   	/* PASID to VM mapping, will be used in interrupt context to
>   	 * look up VM of a page fault
>   	 */
> -	struct idr				pasid_idr;
> -	spinlock_t				pasid_lock;
> +	struct xarray				pasids;
>   };
>   
>   struct amdgpu_bo_va_mapping;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
