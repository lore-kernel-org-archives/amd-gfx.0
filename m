Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B42C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 16:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D10020897
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 16:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="imJ0vemC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D10020897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC3026E211;
	Thu, 21 May 2020 16:11:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E3DC6E211
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 16:11:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQEXr9GyB+ynz4JaGx/AiEr6a9X9HPO9cBkiFrL/jZMoGnyWcjDjzG9wTeEemHmI/WbQV1UDINjF9H6WAA5sYdO7TxT/PXwLS/MWC/qmbjHFGBNQAdLGRCiFkPBRJw6rQEIa+cpVtMkGRMfx24q8Toe200OeIIR96gSdJO/Jk8FW2C0/AliwSujuxyLBw/w2O+vaDY0ITykw1A7z5ISTBJxD1fwPPivcdC2H51UrGHf+2nJ1jWEH6lguJY+W0Je+Ca0pZHfnJJFw9t7jydpVUjD9yuL4Rz4sy6C3zYCmez9m9FZMFZ9k/nsbyg628GELSw0WP12JHBBrxMM7iGF9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfZ97En4QNDpDgc6DKI60BlY66hqCUOqFyJ+JVjXWn0=;
 b=Chnv+rgSKcTt+Ep6kGLM92dFBvjDmdrH/MRglN1SG2D5/pK6IOndUnmRBK9qo0UfxYqecpQGpYbOd+3/M09OF+des4KqU47HhxgBdMZcagVC+6w8VTkKRTdoyIjegY191xAbxp5gw6wl5ku7QTcGKRmvJHjYpbrvMl65AJQ0RtqSf8SLG5byQ8z/SLu+xlc5sPGeiBkL7FkLCrfb9ZOD5QYJ8y2EOTjwJqeRWgLNx+XXzJ2YbpyOEQIEPSMQHBucnw48DQSAD747uwjMl9pbXfCnSWFcZvhvG/9H9IyMh4PExOduSxHjRHlWhOezpZEmVB7+sX3cUuZChMDC9LbprA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfZ97En4QNDpDgc6DKI60BlY66hqCUOqFyJ+JVjXWn0=;
 b=imJ0vemC7EcddhuLoIxcK0B+kuWk/6B8GShnPJHKiYybTXLfYT93nwj/wzExwA8NCPS1UJLz8V5FuCQlxvc7mjfaV+7D++zwYjagSblw1qYP6ti2MtmRWug58jYnuSspxhsYliWVAU2j9yX12rk5yorJlvSa0ccgJR2QgXmTBuU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2591.namprd12.prod.outlook.com (2603:10b6:802:30::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 16:11:05 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 16:11:05 +0000
Subject: Re: [PATCH] drm/amdkfd: fix restore worker race condition
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200521144252.28102-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <61b8a14e-5429-94f1-1d5d-da56f037fcb7@amd.com>
Date: Thu, 21 May 2020 12:11:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200521144252.28102-1-Philip.Yang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::21) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YT1PR01CA0052.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Thu, 21 May 2020 16:11:04 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d9f4ae7f-cae3-4139-6ee8-08d7fda19081
X-MS-TrafficTypeDiagnostic: SN1PR12MB2591:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB259141FBB1847A4D1B7F1A7C92B70@SN1PR12MB2591.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w1QVraVuZnnaMTNczHwI0TQNzxWm5A8rB9oAQtLR8aHIcIAajRznPu6a+2MHA7ePgkw60J52ZKOPezwJfAKhkuGlibD1LumBdez6380YQIGLqlmfnzHPAeOVm1JM8OEvLunGAfIuk5KrachsaodGCOgjWP9R8I1t9DW2HEnDHA1xCImjviv5EX2k9RpRTu2uRHgTBgszwhsbtSHk28JePPIWUTOouIQCXfz3Q8faquw0nVZ3VlBvvAdmIwX4VLy7tiLBKssOfpCzUY+cdQl3YAoXaG/o1Oyp+OL/MVAatwa2LRpavDgagkTYK7H61xt4K1FcFlRSn3p7bJHaP5XeXQVgLaiNknbrMBsG86T+99iJ3Z3OndW8m+sNEsHdKLvF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(2616005)(16576012)(956004)(16526019)(186003)(2906002)(66556008)(66476007)(44832011)(5660300002)(66946007)(8936002)(478600001)(8676002)(36756003)(31696002)(316002)(6486002)(52116002)(26005)(31686004)(86362001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: xfe2NyJYzjYjNVFa5ywM16ygzVUajeRmu3mUZB1bqhAzx063iwiGpQZgazbemdag3fnioUIn+yjhiEZIrjvcXml5rUTQW5oo5p+tsN3d5Grri8YlB17O9fd+IPLtpHy07qSd9dy2+5pHu3kxRuo8jFD6gZJ9LsQ2NCIgVILTXCa9n9g/74fbxOAZFec2o2G8llKjRcftfn6CxAbEF/V8E51T9JjHFg0RCji2j07MmADMQuE3ELCst41VjNnYlHDTD9QG+/whQVG8XoSfXSpkA16VDd2OVJ7W6bk36P73+2W0r6PtFQUgoD4WUOAa34PBIZiJ1bWeFXo7GDEkXWgdYEApQ1PlGVuQs3Uiqhv8vBUD+o8ku2syAjtZIb1Nd81ZUIwfakKGm+9TQoyGXDu9SSXd7ZMgUN7vp+iEP9nFgmsILBjhNUoC7WfFrc3S4+e+0ZHpJuAsFXxDxhTuN6DOo0tVG37Qn0wzkqgnirVQIszXUfuPfKLY8fsfYsRfS0BD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f4ae7f-cae3-4139-6ee8-08d7fda19081
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 16:11:05.5186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/jQYU4a5pFy9HLww7G9ClvgD3peplq5jZGoZnjEypdXE0Ow22rM22+PSIVhz+8qMzbDTD0SwiidSzPBQmdbPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2591
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

Am 2020-05-21 um 10:42 a.m. schrieb Philip Yang:
> In free memory of gpu path, remove bo from validate_list to make sure
> restore worker don't access the BO any more, then unregister bo MMU
> interval notifier. Otherwise, the restore worker will crash in the
> middle of validating BO user pages if MMU interval notifer is gone.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index da8b31a53291..68e6e1bc8f3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1302,15 +1302,15 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>  		return -EBUSY;
>  	}
>  
> -	/* No more MMU notifiers */
> -	amdgpu_mn_unregister(mem->bo);
> -
>  	/* Make sure restore workers don't access the BO any more */
>  	bo_list_entry = &mem->validate_list;
>  	mutex_lock(&process_info->lock);
>  	list_del(&bo_list_entry->head);
>  	mutex_unlock(&process_info->lock);
>  
> +	/* No more MMU notifiers */
> +	amdgpu_mn_unregister(mem->bo);
> +
>  	ret = reserve_bo_and_cond_vms(mem, NULL, BO_VM_ALL, &ctx);
>  	if (unlikely(ret))
>  		return ret;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
