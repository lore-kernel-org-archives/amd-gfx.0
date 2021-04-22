Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6851C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 07:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA9F613CB
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 07:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA9F613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C07EC6EA36;
	Thu, 22 Apr 2021 07:09:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DF9B6EA36
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 07:09:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaGbEPua4wYWy1p/Q1Ma6dvkUkfSppFomUNHhi6bNDTAWxPyb7MF5whB9+NvJZLhczqY9DmmBBavDeYAEic6NXziMF7B+Ekc3SIm76VI/VCmSZ9IwR+le3eNplUGEva2mNzF92MJPILgS4HfeF2LsjwZk4MC9KZjPcvQxXfIKVYkVAn8Zh/VrUCARKMnhznbdazb5nnXOv/V/6wPbbO2B0MPKW5iGEdJ0It5uCIwIJUTLRmDI04zI/cJcwpkJMpneLhCr1IsCfcqZjOAC8aRClasYqlD4FEBs562633RvHEZMaMk5ETuTzv0CvsKHVlJNY12JUQAnTIE4g4WCBAUkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HY25R9uAlRRkocTobvpoRdHLRp8kiVQYrq8pf/vtf6k=;
 b=gmt+jtsJTAw1Aa0DFOnBMMizNQGg0o6EUkVCV909/H8vGZ5i2Y1YFzz66bOerUNu42zThFVIM9AfHWufVuI+aBuAsaDw9vKkvLdPuUMQ7YsX5YurmrIm7n9vUFqPwKHmmXl6JJKil7uzCO2OGHo3QL790462Q4Dr4bOiXamkRTPnU6iHX5sJ+IQvR5BCCL9CdEs2e9IOemfYro9oShxzTdFHmQkrOw6d+XlyjWzhDMXexUchh9NWulY4t6aGRuO4MIUTvW+a+3dtUncE4/G6zTKDWjYTTz7u65htTf/jV0d2y5USRLlKVi9kYZmTHqys4He7Lz2UqgUTHwPvaFAzgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HY25R9uAlRRkocTobvpoRdHLRp8kiVQYrq8pf/vtf6k=;
 b=Fv6W2W6Nk6EnDB5TQlcQTEY6eC2NDaseN20N2iIJ3952wyIl7lzJnYX/TNDAObKjUcLvsTh0bRdBa7Z80ZZcuaBMrYh9anXF1fuoRsaT+5XG4KeHB9p63RxKoDmRBmZFHvs3RyOvx9+oewvsDEQXG8eIIjOrpDIB3vJOZatC73U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4816.namprd12.prod.outlook.com (2603:10b6:208:1b5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 22 Apr
 2021 07:08:54 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4065.022; Thu, 22 Apr 2021
 07:08:54 +0000
Subject: Re: [PATCH 2/4] drm/amdgpu: create shadow bo using
 amdgpu_bo_create_shadow()
To: Nirmoy Das <nirmoy.das@amd.com>
References: <20210421163523.14493-1-nirmoy.das@amd.com>
 <20210421163523.14493-2-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <bb44558e-44dd-303b-de5f-9cefb584dbb0@amd.com>
Date: Thu, 22 Apr 2021 09:08:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210421163523.14493-2-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:2fbd:d2a4:da7e:4526]
X-ClientProxiedBy: FR0P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::16) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:2fbd:d2a4:da7e:4526]
 (2a02:908:1252:fb60:2fbd:d2a4:da7e:4526) by
 FR0P281CA0061.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:49::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.17 via Frontend Transport; Thu, 22 Apr 2021 07:08:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31444d70-5c1d-4d2e-8a57-08d9055d7d0f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4816:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB48167DD3D886BA46374290D783469@MN2PR12MB4816.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 17s++WquilshrzUoSj2wObWxQb3DJW5tPGtxyb+2bARWLLJCAP7eZAkH4bW9mItwEEHgTUGHUkRCt60AcUmTM8KNcD89DxWKLAhVmtIj1yp9zLWd9nj4oFnKdLWcM+1bTNdaaXYJEFk0u6TGqu+u5jTBwW8gSxcXVMkMWEP+7KGWGzfh2C2z/FR67X6DnGN7F0Tz119N7Q3i8m0fblAxJlTrYL/Q5opKPicHWwin4C87suOk/xuh4aXSrD1+rsyNq8rSPtHtr6r8jyuVMrfP8m8Cr9Rd9fcoVXoOGNw6Tv4T64rloCJ77FeM4+P1V6veY0ECutyMD8qNO6QStVX8opn4+upgE/WSpDXEmuu6knJfKCMt+Un9OrWFCRVh8Wzj8B8VWqibRINW80j+EM8rOMzN2njAYfQetXa6w1lEVy7G0bIEU+hIIxZrvNclE6YQt+GvkgxqEJVtv2vpkZ5NdnTzdIaMTdahq0z718T2WPqk2DRA/X/uFhYMAep3dS0jkUVDpgvs+59ktJFwfwmtXFf0hB5hkI1OzZMNxropFXUzh4STJCpXKxvxX47LR/I9yw+maSs9o8bQhG78r/5XSqSyHxXkBlCr+6aDrXt8p8VO0/xsTCTnbbYq+Yp6n9cWObAI/DVGrOibgb+84ZsdgXBlaR+XdOoeWwjRjBzb0Prxn/6OHiz3Bgn7y0AT06bO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(8936002)(6636002)(86362001)(316002)(4326008)(83380400001)(5660300002)(2616005)(37006003)(31696002)(8676002)(36756003)(6666004)(31686004)(6486002)(66556008)(66476007)(38100700002)(66946007)(16526019)(6862004)(478600001)(2906002)(186003)(52116002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eXRIS1lpWGxrMkVYS0U5NkgwWHhOMUl1QnBiNURQQ0Z6Q2pBd1BqdlkrSy9G?=
 =?utf-8?B?YWpxSVI3dHlydGZRMFIzR1JScHpBcWdjTlhaSzJ2c2hwTC8wa2RJeDByOUNY?=
 =?utf-8?B?UFpMTTJ1WnNVTVNQMmlIOVN5VGdNbGNYNUQvSU9MWVRaU0Ryb3U4bHk2L2xX?=
 =?utf-8?B?LzlVa2FNc2RRczNjSitYWmJzZW13Rk9uWXNIWVlrcW5GYVV3QlQ5YUI4ME5p?=
 =?utf-8?B?TXFzcmx4VGtibzZRWnJJaGxMUTI0N3dTQ205TE1xMS91a1V3MUdSQTFsOVRW?=
 =?utf-8?B?bCtZY200S1Y1QTk0MzFIY3lnMUlHRkY2ZjdDZjlYTWdpK0JpLzlFdGF3QTJF?=
 =?utf-8?B?dVBXTHh6bzZRMlMyenZDWC9nUTZLS05QTFJuQUhtemVrVXV4Y25GQkRGeDBI?=
 =?utf-8?B?ckRWZTEzMVBWUHBRVUF1ZEdMeUhMTTByWlhUbkVHUTJiOGY0YWw4SDY3L2xH?=
 =?utf-8?B?OHhDUUxDYzRudUJDSldCRG14aHFPcGNZZjJXbEQzRDh5R2ZIcnRkV003NUZG?=
 =?utf-8?B?ZWZhcll0dGsvd09YNXZCOEVSL09GZG41TFZCQ0FVcXVrKzRoUFZ2ZkRIeCtR?=
 =?utf-8?B?TnRFeVE0RGtvOU1QUElRRGhiVXJrY1ZoeUlURGNaTVNtdXZuTnM4M3F3Tkkw?=
 =?utf-8?B?ancvaUtjZlR6U0FWNWRGa3lXQnJzMXRnWlh4eWtlRk1oQXE5eU5hT3NHN05u?=
 =?utf-8?B?UlZteHBOSmRiRkJyZE0zU0ZRSXJOUld2WEFIREdkK1dpaGRSUjU5ZFdoRFZV?=
 =?utf-8?B?cGdDZU5IUkY3U3Y2bG1UaWJEZzB3bW5yb3Z4dnU2VWFiMU1nN01pYVBSeE1t?=
 =?utf-8?B?SlVRKzRZaWZ4SmVBT0U0TlRnV2pvRjlFM2cwMTRGdnBORzg4bk13TTFuMytV?=
 =?utf-8?B?QnIvRExsTXBZeWVsU0hhMHBHVnViRmRmWURiMWp6cFdjWGNxUDRwMzNLS2Zj?=
 =?utf-8?B?U3k4VmtmSnRYQlkzbzRwRTNvaVJqelNITEw4YjNseS9tRDQvNEJnMVJwZ0dY?=
 =?utf-8?B?RW1WUVFyTXdVSTJjMXQ1d0FtY1lWNXM0U0RmcFJ5RVc5VmFYekQ2dTlTaXI1?=
 =?utf-8?B?Ny9QTkE2eXJib0M4dkUra0VMcVVVWmpsSlU2NExoNEd5U2FTdnlEVExFYVlU?=
 =?utf-8?B?aC9jOG1YTnltMW5MdytpWGlIZzQrZ1pPUlZmUGk3WEt0WVNRTXpBVzZYWW5I?=
 =?utf-8?B?eFVycS9WMU92M3dnaHZsNW4rTDR1T3pvUU8yZEtpQUUxNlB5eGc0UTNkNjJB?=
 =?utf-8?B?TkRkZ1hrZnFpS1JzQjFqWW9TdWZ6SW9OclJPOHdEbVZVUU4yYTRMZHV6ZHZG?=
 =?utf-8?B?L0o2a09NN1Q5Ump5UXM0UHVWcUI4MjNweUh5MWJoRVUyL01ZVTRuaHNDNDI1?=
 =?utf-8?B?RTVBbjg5NjJFNkRaWWFkK3JKYlFmalZkeG9zT2NSLzNwRFg3YkoveExhSnND?=
 =?utf-8?B?bUZpTWxXRDI3MUdlU0hSdm5zdVB0ODNUbVBGU1pBaXVoRG9ycUR5eUl4cHJO?=
 =?utf-8?B?MlZWcjVZK1Mrdm42NW9MOWowMFhYbnc5SGd2ZDVOTkRmNlhoV2JqalJFMHNp?=
 =?utf-8?B?RnBmY0QvTEdPODRxVTVtZkJJb1dhZ0ZEMGllNmRyOWZORFJnS3hjbnRjc3c2?=
 =?utf-8?B?WE1pVE83eE1NM1NGMnQ3enZrdnhHNlJQd0ttNVBSV0ZIZHduRXBKYktONVNC?=
 =?utf-8?B?YzRmM3VNaVB2SHdtMGpuckNNWVZpWFBMU2dOc1RUTkt0c1pReFdIMFJDcVVJ?=
 =?utf-8?B?R3pSZGkxZkJpWllkbUp1WkVBcTdkZEJJK2RseWdNdFU3MVY4UEpkUnoxU0lS?=
 =?utf-8?B?cnhRbEgzU29qTWhQVXZ5RXh5ZE1hVkhqMElFVkwxQnB6REFFeTJTWjB1dHBG?=
 =?utf-8?Q?356W9dL1MTYym?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31444d70-5c1d-4d2e-8a57-08d9055d7d0f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 07:08:53.9482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5CwFg84SWTJkhcJExLH+NdHoxvO6oaZJHpeH33LgOJIPiN9GmgbRFtxnEvGRNMP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4816
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 21.04.21 um 18:35 schrieb Nirmoy Das:
> Shadow BOs are only needed for vm code so call amdgpu_bo_create_shadow()
> directly instead of depending on amdgpu_bo_create().

As far as I can see that won't work correctly.

Now you only create the shadow for the root BO, but not for anything else.

Christian.

>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index f95bcda8463f..bc302548dfba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -873,8 +873,7 @@ static void amdgpu_vm_bo_param(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	bp->bo_ptr_size = sizeof(struct amdgpu_bo);
>   	if (vm->use_cpu_for_update)
>   		bp->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> -	else if (!vm->root.base.bo || vm->root.base.bo->shadow)
> -		bp->flags |= AMDGPU_GEM_CREATE_SHADOW;
> +
>   	bp->type = ttm_bo_type_kernel;
>   	bp->no_wait_gpu = immediate;
>   	if (vm->root.base.bo)
> @@ -2844,12 +2843,24 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	vm->evicting = false;
>   
>   	amdgpu_vm_bo_param(adev, vm, adev->vm_manager.root_level, false, &bp);
> -	if (vm_context == AMDGPU_VM_CONTEXT_COMPUTE)
> -		bp.flags &= ~AMDGPU_GEM_CREATE_SHADOW;
>   	r = amdgpu_bo_create(adev, &bp, &root);
>   	if (r)
>   		goto error_free_delayed;
>   
> +	if (!(vm_context == AMDGPU_VM_CONTEXT_COMPUTE) &&
> +	    (!vm->root.base.bo || vm->root.base.bo->shadow)) {
> +		if (!bp.resv)
> +			WARN_ON(dma_resv_lock(root->tbo.base.resv,
> +					      NULL));
> +		r = amdgpu_bo_create_shadow(adev, bp.size, root);
> +
> +		if (!bp.resv)
> +			dma_resv_unlock(root->tbo.base.resv);
> +
> +		if (r)
> +			amdgpu_bo_unref(&root);
> +	}
> +
>   	r = amdgpu_bo_reserve(root, true);
>   	if (r)
>   		goto error_free_root;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
