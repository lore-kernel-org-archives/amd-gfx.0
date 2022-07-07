Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC731C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 18:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB9AE11AC62;
	Thu,  7 Jul 2022 18:11:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B8BF11AC62
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 18:11:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghTTFAy3h7hOxWaPIJe6cqeIunXVLWC8/+C32X5JCzBtkvYwdm/khk2ljH0xt4UEoDG9aXkyiXZLd82MWF2TxplTetM3A+2X5CirdiiN89WDqUWHtamo5vdxVRCj4dSuczWTbbw+DJ1GFmb9tnkLy4K5WiiJrwcEId9BgS7yHbKA8Y58VdZrIdd96KK8b7w/frL7GWV5XQNGpYPNqUEzm1CM1hlMPmI2CitcPfVItFhwcOKui4dOU822bqxjr1HmDFItuppC8S+IjiFWsFHWqcDvxuXInrGx6xAdceLkg+79sRGKHu3w6/zGfoW5GTIWf09AZROFyf8HRvRiHPLvMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slcfJ3Hg7irMxb29pmZhLvTh8ocVSf9oZANiX36CWNQ=;
 b=I4oMioFBUuShkGCkWyhbCH9uTgM9pJxlV+ZmaRv8xrQmptCANZf9w4NTOKPF4NEgXw5U+x4MUTUALh+duidTBsAm9O1Kdo/g+1ElZuGRYf1G6GdMCUV2750wZtnFPR6oMDRYyOc8oItjzbxS/7daIpXLuD/ew7UxDVqkZSUeWXMz28mYxuvzjVQEPoDHCExSJ6Qaa1M9Zsd0TgdNyW4x+NFHSgxuBEDnQF4G36FZFxY+lulJj16bo241Qj/M12qEeISUXGtwvn7gflNSNzfYIsIp2RGA/2nN6GSaRyY/puozoo34JXBcA0B9iDGAnkgsJSf1CoH9UVGxq5APU4FdHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slcfJ3Hg7irMxb29pmZhLvTh8ocVSf9oZANiX36CWNQ=;
 b=1x7I1FiyGCwgBRElknjC4RSmcltlCmwnmfv7507zDXWOIN/pD7xvlrtUjNsAeeBcJOd27k0K1lMgZcoTTpjotrpn9TyaPyDFpEvBXjHsKIsZSdPgTxIJZaLPtj97CMJqNJ5aQMZrWAeQo0h33GGw2BEgioz1GikUN9WSBGFwwuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL0PR12MB2820.namprd12.prod.outlook.com (2603:10b6:208:80::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 18:11:45 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa%6]) with mapi id 15.20.5395.022; Thu, 7 Jul 2022
 18:11:45 +0000
Message-ID: <225ab4e4-81d9-e565-debb-4ab24f6140f8@amd.com>
Date: Thu, 7 Jul 2022 14:11:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/1] drm/amdgpu: Don't clear memory when PTB BO is released
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220707164549.4032-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220707164549.4032-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR18CA0017.namprd18.prod.outlook.com
 (2603:10b6:208:23c::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3e3033d-0622-47d5-2d9f-08da60442714
X-MS-TrafficTypeDiagnostic: BL0PR12MB2820:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FWNl4KtM/ihW3klVS8K49wYvZgBvbS9tQSA8o9Wd0EMAijs/ZnQhFdJxhz+KBrBvdmeQh0rjnBr0d3pNW51s3SVvXTW5q1yHptsV/SBjGZERcHy2c9oqYUf5TjhO6hO6BYvopOt4lyTtz1rG+rRGU/Wa25goXPYnOVZ/mtItbHc543t9zWvRuQ6FyZZHXRXCDm5Sorcqga6HpuzDV88GNLxawXXzbxfkHD5pTh673piOwaqIzZeg3C7/+hh+fgjLwlG15+AlSW5lOvjVBJrn+p1GbYC080sxZP/tIzvXPttcqMSdKjcjYKpAnKw9ndx8ZXUXZzMOizb8m/aZ6/QwSr+rJF1HdPR44u04dtNsp1nx3+AUDxeyQ3+VH8gybQaWN47pTqykpCBbQB5xh1Z6nnjEi58bOWurZ6+YkDir/CQvI6hifvstwLEcgzCs9Hr1kZ2C01v09K9wwfvhD94/zFeHpR5vG9ULD579UWgLrbb81dyn7w8QW9f/v1tbwqoeTGNCQ9Z9UnxrUtNi1511M491sS41aZl4RuindnUYlVkKnXJnu3YEjWITND+pNfx/a0t5MclM8VZWiqMtzG5Oe7aKS7B456XszrMtTLpQjPOkfSr4EdfXPfMFlXiWtu0nwZJmXPWemX8swthYWkhFSXGnECf/4knV6xM92DWPoctYhKlzGiOXwM/ymVzGAK2C8g75FrTMLnz3c7UoD/3mBypHtcCk9cpZ5BWaPYXCTKhKFrftbKrRWphAkHb3y2MSjqEL6Cp4ggOavylXalDlPwx/JP31tc5Kf6M56dDniJg4zLuk7fHM0T+pYuhYZbiZz2gdtIUtilBUxoDtSwoE/10SRaFEiL7KAyGcxy4kSEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(66946007)(66476007)(66556008)(36756003)(8676002)(316002)(6506007)(44832011)(53546011)(31686004)(38100700002)(26005)(478600001)(6486002)(36916002)(86362001)(2616005)(8936002)(31696002)(5660300002)(186003)(41300700001)(2906002)(6512007)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjl6bkVQcUcvd2F4VmZqa1E2dUV2cHVSWUYxM1ZqcURsWkV6RCt3Z3JCVUE4?=
 =?utf-8?B?Tm9FcHIwUFNFalFXd3NSZis3ZmFQMTdDeEVaNDN5Q1VsTUVhMm90N01oMElF?=
 =?utf-8?B?YWRPSzNnRjF4Q3ZBOTgyRnpMOXZwckRyeXcyRlg3ZklxelhpSTJ3ejA1Y01V?=
 =?utf-8?B?elY0cjNPQnE3eWhMTnJYbm1JU2ZLaWpLQWdaUmVDdXhLaXR2aWVCZjFheUlM?=
 =?utf-8?B?eTMvU0FXN3RkZ1E0d2tENDN5Mml5Zi92V0d6ZUdmNktCYVFFUHZWVkJGc2NB?=
 =?utf-8?B?NkJiMnhDRGVKQzFiaEdXTnNQNzdVNEE4K0JUMXhuZStNK2ZRNGdyNkNPTCt5?=
 =?utf-8?B?enNXZTRYeHYzMmpzY2hQdTJleVVwbTJqcnBKbVF0eVg0UG1UNkZqLzk1SEhx?=
 =?utf-8?B?M0MvbjdWWjExbXZnVDdTcmFNRHFCVC90Ni85NXVtTFZSVUdYaWtJYTdvZE5F?=
 =?utf-8?B?dmJtOXVrVVQ1WFcyMGR1VFV2L2lFK0ZoYTRSU01HVzFCWEVJazA4elcxT2sv?=
 =?utf-8?B?MUZSYk5lR1gySTZHc0p4VzBaeC92MzVrd0hQb0dLeTV6YlMyZEZwOWZPcjVK?=
 =?utf-8?B?aVg3ajF4QmFwODZJTDkzalBEQkR2M1ZHeG8vNS9xd2FqL1lwL0xWRXpMUHhZ?=
 =?utf-8?B?K2doZnRuTVE1YjEyZm5GTUZhSm80bDg5ZzdYdWUrZWJ3U1grTkxUS0FHeVk0?=
 =?utf-8?B?VUJ3U1Vsd0VydmROVElUYjNvSWJmY25iSzRhK25mVnpzSzN0eWduUmZ6WkJi?=
 =?utf-8?B?VEdFTGE2VVQycE9GSDFBWHJCNU8yM1V2YUJlNXNJL0tuS2s4My8vZ2ZCWmEy?=
 =?utf-8?B?SkgrQlhYa0tVbVh4dGhSWlU1VFYycWluY3ZML01LZ1ZINWpXeFN5cFRvWm9S?=
 =?utf-8?B?enFhV1RMZkY5MmZaNWFMNjh1SHZKVDloOWh1UXhySnVYTit0bnluYUxCZVhw?=
 =?utf-8?B?Rmd0cGFzS2FBdVpwbHB1TkFCeXU1ZnRJREhaTGxKR0szY1BPUEFQY2U3a3p2?=
 =?utf-8?B?SCtOZG9DZlRJNXZsRXN1ZU9QVEVGL2dZcGxMMnd3cTNuYldLM1d0c2UwVitB?=
 =?utf-8?B?cmkzbHdWc3poeGRJUk9ZTHh2RmNTRWR5M3dRdy9CalZxdjhac2JWWXpsYXQw?=
 =?utf-8?B?NUx2eDFzMlhSUGZQZjB2aXhOWTNZdjBJNjJzRm5IbjN5azc1NmZtL3RLTHB5?=
 =?utf-8?B?YTkybXgxZGVWbmE3R2J6VzdoS0EyVUFueGlZVzhuWkZCNEp5N1B1OE1Gc2lB?=
 =?utf-8?B?UE9kd1RNL0txS3V1OTV1NjdKWXU3V2dMZDJucGtJcVJubGxZcTM2RmxIVGpZ?=
 =?utf-8?B?Wkg5cGlNZ25Ec1VWT0FRT0tCMFQzc3MwbUF5cHhDdHNWYWN0U0pyZDE5VE02?=
 =?utf-8?B?RzluMXpJRzlUME92VENTdHVoUlhPRTF1RytMNXJmOFhsbjRUWjNwUkhXcmQw?=
 =?utf-8?B?RlloOXBEYkVrNmZWYzBRd2U2YjhDYmRzQm55TEVOOUdrZ1k4VFBMb1pGM3g1?=
 =?utf-8?B?QmozNUVHWFMxZlQ1cllkb3hadEl2N3pEU2dCM3JDS05kamhaUTlvUzFVdERU?=
 =?utf-8?B?ZldGQ0NodWtrMGZUa3haMTBJYytHNklWb0xWcnM0RGZzVGhqLzdWaE92Vy9M?=
 =?utf-8?B?eWR3em01U2pqakRpR3BHZlF4eVNtNXNhTFhJWXdNSmhFNUhRNU5jaTVJdDRw?=
 =?utf-8?B?SnZjTDlPWjEzNnN0SU1JZzB3Si91NUNvVUlPN2trQ2ZwR055ZkZBRnpTOUNw?=
 =?utf-8?B?UWZWbnRFUHkxcmNqVWNaM2xDUFhvdlpZRzB3R3YvL3NKWVRaSFRSaHdPTEhN?=
 =?utf-8?B?bFRQSEVXQzdnYmpmMXRMbjNXWGFDNC9iQnFsR0tjRkw1OE5EVDV6aFBaalRB?=
 =?utf-8?B?djRIMmpMeGdpVTU0UnZPaXZaYUF4dVlsMXkzaUtXcDBEYnN3cXp5N1dYdGlM?=
 =?utf-8?B?Z0ZnMXpaclEvMTdSQmNmZGZBQjRhRlJhWjFELzF4NnBjZ2hpanJuRlV0MUZx?=
 =?utf-8?B?b290VTRPQ21mbnJNc05OK3UyUTdoelZ0TFQ0c3JhL09oTVlVc0lqczdnd29x?=
 =?utf-8?B?aDFpZmtBbmJvNzhRUUN1K0RGeFlROEhqTEx5aklzWmwrNEhvdlN2cmw5bWoy?=
 =?utf-8?Q?65rql2zqKTbwYECleGxDYMfLA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e3033d-0622-47d5-2d9f-08da60442714
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 18:11:45.6804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLh3WtCRoyz3YjYowoGWs2WjhWvY6ZGt6I8/kz+ex5qr91Rp7qOKq9OCoEo6wJacmuuUx9a44Os70KlM4D2+1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2820
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

On 2022-07-07 12:45, Philip Yang wrote:
> MMU notifier callback unmap the svm range update page table may free the
> PTB BO, then amdgpu_fill_buffer zero BO memory could cause deadlock as
> kmalloc may trigger MMU notifier.
>
> amdgpu_vm_pt_clear setup PTB BO memory with initial value, and no
> sensitive data in page table that must be wiped out before releasing the
> memory. So don't clear the memory when PTB BO is released.

The problem happens if the memory is used for a non-pagetable BO after 
it has been freed. In that case it doesn't get initialized. That can 
leak data from the page table to a user mode application. And it can 
leak RAS poison to a new user mode allocation.

Therefore this memory must be wiped on free. If this causes issues in 
the context of the MMU notifier, then the wiping of memory should be 
deferred to a worker thread. The code for delayed freeing already exists 
for cases where memory has an unsignaled fence when it is freed. So it 
should be possible to create a fence, attach it to the BO before freeing 
it (maybe after it is individualized in amdgpu_bo_release_notify), and 
only signal it after freeing the BO. Or maybe there is a more 
straight-forward way to force delayed freeing of PT BOs in the MMU notifier.

Another alternative is to ensure that kmalloc in amdgpu_fill_buffer can 
never cause a recursive MMU notifiers by using GFP_ATOMIC or 
memalloc_noreclaim_save/restore. BTW, I don't see where the kmalloc is 
happening. I guess it's somewhere lower in the call stack.

Regard,
   Felix


>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 8a7b0f6162da..65b4ff6979ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -576,7 +576,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   	if (!amdgpu_bo_support_uswc(bo->flags))
>   		bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>   
> -	if (adev->ras_enabled)
> +	if (adev->ras_enabled && bp->type != ttm_bo_type_kernel)
>   		bo->flags |= AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
>   
>   	bo->tbo.bdev = &adev->mman.bdev;
