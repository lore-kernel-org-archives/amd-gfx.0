Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608E0C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 20:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2664365285
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 20:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2664365285
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E43036E879;
	Mon,  8 Mar 2021 20:24:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4E996E879
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 20:24:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FB8hFxjfYqxrvhmzsJoTd4rv5B21ZGcFBKRyblOWNLmr2GTl1ibnWjBtELuFKHOc6CDWBCbKIkROYafN0nV5STGKetNiohGDD7mHDMd6waAdEkkcypy9XA4T+XC9CIEshnI7/Eg5TNoPiIueGM8PMv8NUQWqSwisE08qy0pa7O/gZWiADsOpw8UseZ8JkbtsC8K9kxg4WN9USzhGpwG59iuZqI0PhwfjaokGPMFaF5TDVzs7vK8BsYkpC65hHiHXi5TgUVK/7trdyPEzdt55ZGWH1xE6nL7qf+y/9iOcL89XoivPl/LAfiVgE+RIAec9+db1H9GOQCT4EDdjIHzu1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnUkOlYCmVzX8hw5p+g2kOpDLf7Ze7CnJ7p5ckjyMxQ=;
 b=R8bvHkZn8rplFnFS6+6p/0wMBJAKNxGqolMIj6GO0YJG1/pdISrY1ZJxT+lB1805AXMlcB+GrJ9pQixMmK9Cty+aUBr97IEAPSz6E+EBkgpvmRTKUYVICsil7MwDnjLsbfkRHilx2ItVP6ssImxqCyIxDU68qorTnwbueqlR3qSl1xe+9x2x7nkSRVOIMRRZQaziwqwlobZwQETfZxGyKq45+TT8f7vT7HDLXzTBNLnZNJBT9wbxwTGndJgzWBrmI+LxapsIYBUhPxxs5WnEcAwcVNVS6FzrZIQ395/jXq+KPV9xXFU7EvvH9K7iRrvZzPW22+9DLz6MGNJ6guARDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnUkOlYCmVzX8hw5p+g2kOpDLf7Ze7CnJ7p5ckjyMxQ=;
 b=u2L52RSlYv8FHCkNLoG/7Bc3trDTOSHqcPIY1Cbuhfo7KCumxbynWho9aXnfnopdsXJauEBmU5QE0ishVfAAvurqTuxjjvTgKtHtf9PSNxsCB1cP2vGoFHI5ftYN+ACopIdi597O2M6qgbaCjgWU1xVX0fc4Tucx7Je0sJW+ehc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2355.namprd12.prod.outlook.com (2603:10b6:207:3f::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Mon, 8 Mar
 2021 20:24:09 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 20:24:08 +0000
Subject: Re: [PATCH 2/5] drm/amdgpu: introduce struct amdgpu_bo_user
To: Nirmoy Das <nirmoy.das@amd.com>
References: <20210308153705.37414-1-nirmoy.das@amd.com>
 <20210308153705.37414-2-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <fc03665e-eca7-8746-18c1-87eba67937bf@amd.com>
Date: Mon, 8 Mar 2021 21:24:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210308153705.37414-2-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a01:c23:6c03:dc00:772e:c5dc:d360:4620]
X-ClientProxiedBy: AM3PR05CA0104.eurprd05.prod.outlook.com
 (2603:10a6:207:1::30) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a01:c23:6c03:dc00:772e:c5dc:d360:4620]
 (2a01:c23:6c03:dc00:772e:c5dc:d360:4620) by
 AM3PR05CA0104.eurprd05.prod.outlook.com (2603:10a6:207:1::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 20:24:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 07bfe3ea-f00b-4c9d-8d88-08d8e270204c
X-MS-TrafficTypeDiagnostic: BL0PR12MB2355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB235577C34181BE654AFD3A1983939@BL0PR12MB2355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yd/AU43B0NtWxQWhCtdm+FL9XqXcqF6aHF8l4t43F9PadWuLRVbMi7WUtBvtMhnumnRn9GIj7XO51MKPijKhPJLAezTVmSKHYj61ekYp2af75hGIh4UOkWAo6QiwATczjRbe868blevCBXw8OSuO/g5jwejQ2a6TQxLp/z2NzMzqga2TBGYrRa6tm1YWaY+wwwQsH8C78yWJIhxmM++bYsBs2efdJZHU5peLCjbIfR/h/sWG4WfHs7MKW2rHue8i82KOomlbKJYEUI3dlw45hykKGHeq6f/djMEkoB9T8nx70nRq9lEIvqJ6bu4y8cywBN24PEtlr3Hp6miEOZg9HxEjaOpEhUr3oLQfCAKJr2J+gl6xLYKEYaxC4XvoEOw1KOo1BUCYcGi24/01/K8UnVDELg7Qt2EnKLEIQHLN+pH71InYxTi3Xmb41JfMhrUmr804fi+46gE49se2yURXydV6xm06fu8C4LahzUI7G9flUFcUswCxAvt2w7HhYwgGjh0QCc0G5ueXN8dsXofcaf8ndVSCgIMxVcBzKm4tDOcODgSH+36+rn8Y4/GNe4/whZytVueMaLYpc7BSRd/pfpNZ7fktIup/6Axf6apHti8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(2616005)(31686004)(6636002)(5660300002)(8936002)(66556008)(36756003)(66476007)(6862004)(6486002)(4326008)(37006003)(16526019)(8676002)(186003)(66946007)(52116002)(31696002)(6666004)(478600001)(316002)(86362001)(83380400001)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UnNjam81eFVkbStTUm8xbEJVVEFCZUpKbE03a3lmVlEzT0FpQ3hKbjNtTXhX?=
 =?utf-8?B?STNHeEowM1NyZUkwOXNBK0tIdlFNcGJuYjRlNlV0UGxsYXZSRitSUlFCRi85?=
 =?utf-8?B?dWhRc09mTXBXYkoyTThIanl1dVlTRzFIaE1kVTB1bm9uQlhSWkhqYnhuYit1?=
 =?utf-8?B?a3RGWHhOV3ZMQWNNRlRac1VicTE5QnVpdlErTWxKaFhSTTcyL0dBTjRrdmpZ?=
 =?utf-8?B?ck1SOXIzTGdtZHMzZ1QrVnFUdVRRdS92ZmhqZ3NMRWFvQlhGc0FCa1BzSDhY?=
 =?utf-8?B?SE1UTWE3aDRlSGdCQ0phSlZXTFd4THdaaCtvRVhEYTU3cE1UQWthcTFrYWVU?=
 =?utf-8?B?bnFrcks3eE1pNjJRanZaTGx3TTgvYTREYkwyUFBYRTdWeHpXY0ZWNFUwZEMr?=
 =?utf-8?B?b3hUM2hicEV5aEhCRVAzeWNMMFhtZkpIVXRUQkFKR0xKdEJkcjNlbXRJUEpp?=
 =?utf-8?B?SVk0OU1aREFJd3JZOENNMzBQWnBkUmhPVzFmaW1EaVp5N014S2E0UXN2R1hw?=
 =?utf-8?B?L21HOVU2UkI1RE1PSVdZbUlVMW90TEZzSmc1RUdRdjlwVWtFbHJPOXRxM3U5?=
 =?utf-8?B?c1N6WnBTeDVLVktlR2pURC9mbXNRYUxCS2k5eWlvNHVLN09DSGpwRUEzMkRH?=
 =?utf-8?B?czhpdnpsNmNwNzJQMG5pYU9Ha1A1MmtDc2IyWTJhTHhkakFFY1pSM0dZMGhu?=
 =?utf-8?B?NHdQclRVejY0TmNaS0Jsc00vUVo2K0VBN0MxeWVER0U3MkpLVEFoOWkxTTdi?=
 =?utf-8?B?U3U4dmdianRtQ01LcWtOQUp0WlY3UVZCaTdDSHhrRmV2TjNmL1V0NmNyTWhB?=
 =?utf-8?B?UGZMckFRV2xMTnE4cVdqdDNQQXVHL2dlMWtXNUNMNWNLa3V5V1ZTRVA0aWhy?=
 =?utf-8?B?WXNOWFIzY1diOGkwcUlEU2ZDTXhlMVlYdWQydTBreHBpWVljaGdzcFhUYzM4?=
 =?utf-8?B?eVJZc3VmVFpFRU9DQUMyMWNsRWc3NmdwRUhwWVlxVkx5SGswSTE5SUxCc1pv?=
 =?utf-8?B?b3JZWjdQSlhMalJvRjdiMlJwaSt3cVRZMDcvZFI3QzJsRVltZWVqWXplV2Rs?=
 =?utf-8?B?M0o3V3ZQaE1Lc2RlbHo3MHc5WFNkdWNZRjZzQURzTkV0REJ0V05ZdmIvWERU?=
 =?utf-8?B?SE5URVRzT002TDNBWXVCMFZCeE9XUjY3YzFodWJtRXRwaGxBU2s4UEx3NU5T?=
 =?utf-8?B?Y1JSUmdrVkE3ZFV5UkN0KytmWlZaeThTVDZ3N085K2F6TFZQYmZTcStaSHpt?=
 =?utf-8?B?K05DQ09PdTNyS0NzdDJ0Wlp5YjRUVndzMldLZHFkSEtQSGZoUTJ0di8yT3ZQ?=
 =?utf-8?B?ajVXTE4ycW85dXgwUDBhVHVHUXFEcWhJbkFnZjdkZEU5ZE5mVE90ajBHNWtN?=
 =?utf-8?B?Y3RVOHR3ZjNZMmo1WFQ4U0VzcFphU0xvRC9KdkQzQTRHejVxb0RJeVVRUHVx?=
 =?utf-8?B?ajZpd0k5cXlCRzFkd2lFN1VBcXQ5NFI2TDBBdmkwbXZnc1lNQXVLNTc3WHNS?=
 =?utf-8?B?WXZ1QXZLeW9YbEtyMWN1NFFDRmtrWGJIR0djclRtM3hwVFFqWTZ5cHRCMENo?=
 =?utf-8?B?YXZSUWxwSGFNSkFNNnVURGNiRGhrWnBuMlZueEMwNDJwVXlCUURBRTlxR1hp?=
 =?utf-8?B?VE43TnIrMHFzTTlKaVBFQ3JoRjZ1bmhaUzN1QlhlbW1GeXMzNlZ1U1dVZDB6?=
 =?utf-8?B?cHFZUUlqVHpFNnZvSk42TXl3TFFiREl0WEFtSWxLSnJFUGMzQ3RMcE12Z0lF?=
 =?utf-8?B?V1R0MU1ZNnpVVTJITGorWWdJeFN5RmtGY0JxU2xpSVlZcy9Ub1hzUWxkUjA5?=
 =?utf-8?B?VHhzRW5rcjVYSlJlNmwvM0J1aDJJZmNtcWRVSTZQalJwekcyYXZOdjVsejVP?=
 =?utf-8?Q?WDhCKPdoYJrE6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07bfe3ea-f00b-4c9d-8d88-08d8e270204c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 20:24:08.4634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EuqMgaf/nrbkTdeVYsh216zrT5IGsaQM+n08CxBIZo7S7Q2+QFI8ghEm7SSxXhU6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2355
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

Am 08.03.21 um 16:37 schrieb Nirmoy Das:
> Implement a new struct amdgpu_bo_user as subclass of
> struct amdgpu_bo and a function to created amdgpu_bo_user
> bo with a flag to identify the owner.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 28 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 14 +++++++++++
>   2 files changed, 42 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index d32379cbad89..abfeb8304894 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -695,6 +695,34 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> +/**
> + * amdgpu_bo_create_user - create an &amdgpu_bo_user buffer object
> + * @adev: amdgpu device object
> + * @bp: parameters to be used for the buffer object
> + * @ubo_ptr: pointer to the buffer object pointer
> + *
> + * Create a BO to be used by user application;
> + *
> + * Returns:
> + * 0 for success or a negative error code on failure.
> + */
> +
> +int amdgpu_bo_create_user(struct amdgpu_device *adev,
> +			  struct amdgpu_bo_param *bp,
> +			  struct amdgpu_bo_user **ubo_ptr)
> +{
> +	struct amdgpu_bo *bo_ptr;
> +	int r;
> +
> +	bp->flags = bp->flags & ~AMDGPU_GEM_CREATE_SHADOW;
> +	bp->bo_ptr_size = sizeof(struct amdgpu_bo_user);
> +	r = amdgpu_bo_do_create(adev, bp, &bo_ptr);
> +	if (r)
> +		return r;
> +
> +	*ubo_ptr = amdgpu_bo_to_amdgpu_bo_user(bo_ptr);
> +	return r;
> +}
>   /**
>    * amdgpu_bo_validate - validate an &amdgpu_bo buffer object
>    * @bo: pointer to the buffer object
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 8e2b556f0b7b..fd30221266c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -37,6 +37,8 @@
>   #define AMDGPU_BO_INVALID_OFFSET	LONG_MAX
>   #define AMDGPU_BO_MAX_PLACEMENTS	3
>   
> +#define amdgpu_bo_to_amdgpu_bo_user(abo) container_of((abo), struct amdgpu_bo_user, bo)

Mhm, the name could be improved, but apart from that the patch looks 
good to me.

Christian.

> +
>   struct amdgpu_bo_param {
>   	unsigned long			size;
>   	int				byte_align;
> @@ -112,6 +114,15 @@ struct amdgpu_bo {
>   	struct kgd_mem                  *kfd_bo;
>   };
>   
> +struct amdgpu_bo_user {
> +	struct amdgpu_bo		bo;
> +	u64				tiling_flags;
> +	u64				metadata_flags;
> +	void				*metadata;
> +	u32				metadata_size;
> +
> +};
> +
>   static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct ttm_buffer_object *tbo)
>   {
>   	return container_of(tbo, struct amdgpu_bo, tbo);
> @@ -255,6 +266,9 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
>   int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
>   			       uint64_t offset, uint64_t size, uint32_t domain,
>   			       struct amdgpu_bo **bo_ptr, void **cpu_addr);
> +int amdgpu_bo_create_user(struct amdgpu_device *adev,
> +			  struct amdgpu_bo_param *bp,
> +			  struct amdgpu_bo_user **ubo_ptr);
>   void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
>   			   void **cpu_addr);
>   int amdgpu_bo_kmap(struct amdgpu_bo *bo, void **ptr);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
