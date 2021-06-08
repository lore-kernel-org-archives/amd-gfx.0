Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F12C47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 09:37:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F46611BD
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 09:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F46611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 831796EB79;
	Tue,  8 Jun 2021 09:37:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A3EA6EB79
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 09:37:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uhnoxur/1o3aBb8PW0nV/BdiVTaRo8RHrahBO9FW3w0vBQfheByssIz5YPwoGQ3CnROx5odxm4gPINVnyXVm9LXjmKdht6Dk+UI6Uq2Y6zL8fLMXTvyTnWTy7hUnvQuwet54Y9CAVRbWqrfnaW1S460dW79EqfEfD4IMQlaRGIcj8mGkTnq2IWkYswDvQ9K5GsYASZ0Bn6GoRo28AjB93/VJisvuk7KQBVjYUK+4bVhY9x3mtEOO0cbuS/HpScXOBjK+IK3J40Nt+WgDBvG01xaB45JmuuBWzpWDePBbpumLKQ+rMaSfNrFlvjFwYvX4GdPEc77qf71yrzTNF6OVJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjIn5qpZFOcg4Llsg9a4lbSSvLtoaOrvFjyujOBePIg=;
 b=AgAEkeiMiy3BCK+UWab6DwP7MwsuExS+UKXh2npezNjZ0MpIvYFn0m+NY1IrW9nZfBgdAtSxXUvtTCGBxBtw72BadTYMxd5JY7/EhCaYT5+bPikZc8V/YXK3C6xwDcFe94QvtB3ndBl3nd7tbgBpb7Ssfi5QhKLIVGSYHPyUAlMkBdV5bIq1fK1ZexMnC4qnSUJIweVMtQc/HsfNIYpatZalBIM0nFiiBSeHVgjN6czquuvRpmw0VOXB7zZ8RSUx29v5A3fRrMulc6dc1MZ7FXTokB7C8npch9rj2J6K+UVG+sCFQClYBEY4L1AODhtqmB0BUlBpEMsRfWtwM9VUWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjIn5qpZFOcg4Llsg9a4lbSSvLtoaOrvFjyujOBePIg=;
 b=xweKG952nQ3atg43nA7zhYEtEMgudGwjf8ruvwB0uujFC3252MzDGqmL+0a378QhWEiGNwh0/YMoXedANpxpAt/b3ZcgN7WNbSyxE45XAmUKJY46n3ZqAZbGVSmZ65przIEhQhHiE4FkHbA6SGcWMlxMrX0aMkZwMbI/Bv9nTyc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 09:37:09 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 09:37:08 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: use allowed domain for vmbo validation
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210608093213.8269-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <63f66fd0-7162-ea31-41e3-1f145d8a6ddd@amd.com>
Date: Tue, 8 Jun 2021 11:37:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210608093213.8269-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:197a:8536:afbe:3762]
X-ClientProxiedBy: PR2P264CA0008.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::20)
 To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:197a:8536:afbe:3762]
 (2a02:908:1252:fb60:197a:8536:afbe:3762) by
 PR2P264CA0008.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.20 via Frontend Transport; Tue, 8 Jun 2021 09:37:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afec115d-3752-4622-43f8-08d92a60fbfe
X-MS-TrafficTypeDiagnostic: MN2PR12MB4110:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41102C2E9840D0DD9AA6E74683379@MN2PR12MB4110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fOkJBY9VqLSWYzb5SwLwdG8O5U2ZZ+54kbmT+xgqlz4Wubv/zFJO0fyN3CiCYuNKPbaywqf7xKJbZOKqrpw7yLM2zJrtqEvjaj5TngVVFYkzd1DIwBaAY9oEP9xSmcaw3tEv7DViD/l/EaF++aqbx7V+HLskj6emxrylECQ7J0SmJKDQiEZCoBNnFnK9Li1OYKjVefpMJ3Jrxjjl4Kq4bHxJpXXuiTR2umIJO+RukdUR4aAcQLFrKFgCQwJwb6PPfjs7AVfsWJ2aN1wXLD0SIiv3KCz/Wb4tI7iOFDP+TUZlDXZYu4dUviXlVYJbC+I0pJan5o/l8ccOp2MidXro9GiOHWAArw2s/eo1wfDg0liZRY7hwclg+oUwUca66r752QSWrOMJU0F3mvlHV7MFAqQn+jFP9fC+F78DPMdSIfZkf994esK+3Iw/CGMBoKQ6h8haZo7iKx9YeMs0zpWnymYAo1ymV9mxCXoShOGND/uwEqbV8q44pm3Z+k1cCbscX8ASaVxTLE34gZMACYzfHK+pXPG1GPCyet5gonlioWVc0Y4vYhbtHaUH2rSbNxsLejPJpkwCPtf4WAvIcJlidAC05CJze2OmIpc5W+MyCU4vkdV1HUPPqKjuP4I5LTC9yfhG2ACiFrTBfwByIdkNKTmOLkLx+6ExKiWp7lvLKdWIU7XqMg+1Ze3vfWx/cLc/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(8676002)(38100700002)(2906002)(8936002)(6486002)(66946007)(66556008)(66476007)(36756003)(186003)(16526019)(2616005)(4326008)(31696002)(316002)(86362001)(83380400001)(31686004)(5660300002)(6666004)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXI5YlB4aW83c1owclMyS29PdVNTOUVzSkVlSkV2Q0ttbEFTYzNVN1NZVU5L?=
 =?utf-8?B?dlFZL0lkbWo2SVdZa0I5c2VXd0l6bFFSdkRVelJrRGZxWWFTREIwVEk3QlN6?=
 =?utf-8?B?UHJ0WmN4WU5CbXZXZldhb2ZncjBSd0tMNG4zVlNacG5IQm9SaGY4czZkK0dS?=
 =?utf-8?B?KzVHQzdvYVN0cGtqZW1ERzRpbVV4ZHZabEc5aythenMzaTdnU2ZnMWlxbDNh?=
 =?utf-8?B?SFZweUtZRFlmMWNoQS9mYnpHSlhVRjhQOFo0aWpOTUlMeDY3WEpDbERZeDlH?=
 =?utf-8?B?R0tOcTRobm5tQ2tvcTNkMTFRTW50bzFjbjd0cXNtVlByTDNMVjR1cmdHSmpL?=
 =?utf-8?B?NUY2ejZtWDJaNGZvZXdDek1QY0ovdzllT1M5VXJObEJleXJOR0NwVzBKQWd3?=
 =?utf-8?B?M2pCWnUyODFCMXo3U2pZTEN0bVpMSnJCUGJTc3EwNGxscFVyeDhxUmtnbldE?=
 =?utf-8?B?NHNIZ0FsZm03Y2N1Z1JSb2dEZGVCcTlFcEtzaElHZ04xWW01OTM5S043ZWdn?=
 =?utf-8?B?SWs0L1lFY3dOUW9WeDUwUThmT3ZTWkJGUFNWZEtoUEU1WW5SZitGQzd3bVE2?=
 =?utf-8?B?dHhQWFk0cEdvQitTdExFb1lqQVl5NldFV2diRVVMR3hMWmdwSUphNnhUYUdH?=
 =?utf-8?B?OUg3NXl0UVVtaW55TDltL0M2OWdvTTkzNlJvS0lHcDRTTnN3cXp6SkpPVWFX?=
 =?utf-8?B?bFhmdC9WckxyVDI5S1dzczExZHVTdXoxenZGRWpHR1RHMjQwUDhyWm15UGNL?=
 =?utf-8?B?bFRub1VkR0RuNGRETnZjZ2d4UW5QVit5U3RVa0wyUlRwK2RBOGRwYmJ4K05Q?=
 =?utf-8?B?cEYyNEpnUm9uaFI1NHJFU3Vpa3VxSDBzQ04xR2pVczBMYzFLWFJsRnhQSGV0?=
 =?utf-8?B?dE1rVi9zVG80eEE1eTBLWEw4T1Q2Z3lwdzN3VlBJbGJBQ0Y0K3hKS0MwM2RE?=
 =?utf-8?B?b3FyTlVUUFdVZEhtRzFFV3pKKzEwWjFzZjB6cGt3Sk9sSU8zSGl2czB4Q2dW?=
 =?utf-8?B?RHYvZWRsNjB2cWpVNjc3MVRJWEUxZythcUNETVlCWjNsR0M5Sm5ibE9DNUIz?=
 =?utf-8?B?MkhuNTV3MllwK05nanMzTmVJaU04TGlmcU5Md2JrUHc5aUJxdThtRlFpWFVs?=
 =?utf-8?B?d3pxajdXZkNTeXMvSWFLTzVNOUNnK1VxV25YWlVOYlVCUXFna1pDa3U5QlZl?=
 =?utf-8?B?S0JpVjc0T2liekYveWorUlFmaFMyeGZnd29PajFhN2xCbUdjR0NjcGVVMkdo?=
 =?utf-8?B?ZDNTRGhISitjMWRaem4zK0FZU1Z6WTNvRjg3YVdzZWV0dHJvVXlKMlNaQXd4?=
 =?utf-8?B?Z0RZdExQOEQyYzNSVTVuY254ZUdGdVFRWk40cHhSOUhKVGxWQm9NNmJXaXRo?=
 =?utf-8?B?RnpGbW5jdHV0YnFQaHBBTGg5UkQ4eE1wWDEzNDk2SS95STFZRkVTdnErdG9O?=
 =?utf-8?B?ZHZkM3lGNThyK0FKcHBOWmJyZlF0b2p3SjJkQnk5RktuNS8vK2pYVG1pSVo1?=
 =?utf-8?B?TCtTckFyVUVRbG9IWjRpWmJDVzR0UTIyVmI2UWFRRzhRREpYNjljdEtjc1pL?=
 =?utf-8?B?dlJCeHJ1L0FkUm9Mb0E5c1NmRFFEK255WDFvSldNOE1nd0w5N2REamszMnRT?=
 =?utf-8?B?YU02Nk9jUVVITU9yRlRrOUlCSnJwQUZnWmluMW9nWHVxUEhBeHRRdTROTm5n?=
 =?utf-8?B?V2xxT2RDTWY5ZjNQbTVsalliZCsybTJKdytuVEswY2phNjdvenBQcXZyTlJh?=
 =?utf-8?B?cWNnV0l5N3ltTUlSbzN6ZjIzcE9POHNHbE5pdE4rakhtSVZzNDlkRmVLL3Fy?=
 =?utf-8?B?S0RxSVlsamY2bjA2U0VRYmhwbEF6MllJSUlvTk1DQ0VubkxQV0NtWjdLOHlZ?=
 =?utf-8?Q?oY9ER4nRuFMTl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afec115d-3752-4622-43f8-08d92a60fbfe
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 09:37:08.4975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tO6voF9VujKMfPOiK5MpaBtsmVcQnWxcF43zBcLBHFm7sC2PE8LLV18gT0RUHg7F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
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

Am 08.06.21 um 11:32 schrieb Nirmoy Das:
> Remove fixed domain and use BO's allowed domain for PT/PD
> BO validation.

"Fixes handling when page tables are in system memory".

And I think you can now remove the validate structure as well.

Christian.

>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index d6cb7cf76623..a45eadfbf417 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -336,7 +336,7 @@ static int amdgpu_amdkfd_bo_validate(struct amdgpu_bo *bo, uint32_t domain,
>   		 "Called with userptr BO"))
>   		return -EINVAL;
>   
> -	amdgpu_bo_placement_from_domain(bo, domain);
> +	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
>   
>   	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>   	if (ret)
> @@ -369,7 +369,6 @@ static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
>   	struct amdgpu_vm_parser param;
>   	int ret;
>   
> -	param.domain = AMDGPU_GEM_DOMAIN_VRAM;
>   	param.wait = false;
>   
>   	ret = amdgpu_vm_validate_pt_bos(adev, vm, amdgpu_amdkfd_validate,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
