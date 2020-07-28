Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD86C433E3
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 11:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D8DC2070A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 11:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="c9L2DFnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8DC2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2AAA89B22;
	Tue, 28 Jul 2020 11:19:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27FA989B22
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 11:19:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EA05LEBB19ImyPTGBWLGVWAh0nTsKFkNWG01kTQEcJ6WY4HNB0MNTyJhBIQf/b1Z7k/PmpzHmqRe7GUB3C4X8YxfQ2N4/miSh4flkxa5mw7wLTZpIGQhEVGgxHhHrchmlY0ST39BgAy9K9MjFrRFIB6LHLTezpfM4ErFml5u0ELXmooyXdHI6AAZ/yIfM1LFs5/IZj/em4qtBvTt2Dg9Avi3rpd0+qWoM++Lm6YclrD0N3zdFRxuc+c4QjftoG2OtJguwvrI6IbxrJEYc5w+8SGXa7pp+pH7nPu4COaV7aTS7RxWB8RLAC5Fq8Zp+1cBeJ5BgMh6OIbKUvuqQDMKAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HznZnQZp6tnwBvjwj2wFJjSFeC52w2mI/eSxWSFAzbA=;
 b=kNS9YgjEIOLIJR89rkYYosOwXXThqatD5bhs2nVrJLAZ6MQiaYkJMwwpcf6KpGy/Clh55K2gj39nr+za7JLxuRdK37J1X+ydg4fwYItnJuGsLATOYRGUsOfc+uax3XAcsvWF+mgQxkRoc8nYDMWCdSUGe4zJqTNW1QQdTr43sFKDb+PCEYAklIZMppwckNUX2aZa1q1WhKVaBiw0cpfGsdLco93y1TmjbKxZSNNEBNkPIvU2MKznhttPjTmgMEqpZw3KZKLS42hz06MZe6/gwwsNBoDPkzp2u5K6/vW35B4QAkJXPQBCwPKT8QS3VrdsNO+7XxsEdh6EeoDSMGSj8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HznZnQZp6tnwBvjwj2wFJjSFeC52w2mI/eSxWSFAzbA=;
 b=c9L2DFnpX20zVm3y66BhV10SsCQW70qjsod5J/exaZrMRic8xBuRAHLoiNbcpKLEHVGNNWXyxNFY/YwxHRY9g1fw0tdO2uBHaeFJMh3FW/j8Cxquw9EQ+Q6hsLX9FrL2K/vFHKRqboXmhMyRddbV5fAlI/rTutP3tXn/kfO1qb8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3696.namprd12.prod.outlook.com (2603:10b6:208:169::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Tue, 28 Jul
 2020 11:19:34 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 11:19:34 +0000
Subject: Re: [PATCH 2/4] drm/amdgpu: initialize the cpu/gpu address of
 rptr/wptr/fence
To: Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Hawking.Zhang@amd.com, Le.Ma@amd.com
References: <20200728102154.2505095-1-Jack.Xiao@amd.com>
 <20200728102154.2505095-2-Jack.Xiao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <388062d3-6d9f-25d7-42a2-eb750c71a856@amd.com>
Date: Tue, 28 Jul 2020 13:19:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200728102154.2505095-2-Jack.Xiao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0096.eurprd07.prod.outlook.com
 (2603:10a6:207:6::30) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR07CA0096.eurprd07.prod.outlook.com (2603:10a6:207:6::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.10 via Frontend Transport; Tue, 28 Jul 2020 11:19:33 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 28cbd7ba-09f6-45d3-2287-08d832e81b2b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3696:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB369693AEDABA7108B8661D2483730@MN2PR12MB3696.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UJYpLkZH7gB2qeephRmN3z9W775S6t/ZXyqs78HU2sRCzEE8E6lvw6oNei2mjnHQWZcyjqnY3yU7upTK+T1utdZ8DP10kfX88X3jpy2mpgub9FCTQbn+Imlatespz6QdBnEbR5yn29x3VuKrYGthpx9n5CR2Mn+0OWLJGPZzu4sJLOF7Vw22OZAO2NsEakHh0hnq8gp7B4KYcPkS03lAj7gAj/DVvVhUcyPQjG8LHvXCcAsVdqfAPFzfWpexDoFuf4ideJZvxWFg6i61LBN4+1OdSoK1HZsneGkIqlTLvBfLo9TOTyvoiBZLdEeCGWsYqcfBd/htYlkT4vxc93Q4EAAL7Q8xNIT7iii4pDx4q3Yr4aYCS2qVb87xfiW73Air
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(8676002)(66946007)(16526019)(52116002)(186003)(8936002)(6636002)(66556008)(2616005)(83380400001)(6486002)(5660300002)(66476007)(498600001)(2906002)(31696002)(86362001)(36756003)(6666004)(31686004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 7usNzyrxLwq5/i7cWGm9vZeDnE2eI78EOkZ+jDk1SObFcNA2yrEWvqFLbA1ld0s4Jbym87Koex/W9TPVGPw6eVLoHsV1rdkzL6u8qbddO6rqrfbnE5czETC0iyeDsRVsBO9PjNIE41e0ELKn/vM3ggcsdtVfA4HP5FKtfmChXHy0x0YRb6fryAhUbOEfRADSWy4ym2A2GU39+/xiQzukmxyryzyLYwDM+t9qpS8IuYpKlsBHPocsp3oyspTjIwGbeg9tSqJm8Rl7vK9Qlt7JMb90FaqMAaqtGVsiRAsRSfPXzpErl50OdRy27rLDirZ5OLOXc7c7K6LH+FFp1ciDvcPrOTzc2RJXeQcCKLI96oJO0kVfgZYKrfrxK81zirDf4Yq0BISj6Bi4WbxNIDtL/Sbhylp7gaZ2ccm7wyYbX4F1sLJLTcX9iSdVqIvSL4Dm9FrVTKYFW0y4t6Ed37HTrFRIJjcouG0kwDYKwsBblGxvto1m52t3RIItAyF39865q/s6g0Ehp42v4kup+7eA2IAE/7lyfcSLZqK7koJ4b54VHW+vncioImXKGPCn+8R5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28cbd7ba-09f6-45d3-2287-08d832e81b2b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 11:19:34.4407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6R8H6JCN4S9obaDxDbDuSNMmcKNjF/TCQQT32rElBvc9jd/fWQ7ywXffNG4aqWxv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3696
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 28.07.20 um 12:21 schrieb Jack Xiao:
> Initialize the cpu/gpu address of rptr/wptr/fence.
>
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 37 ++++++++++++++++++++----
>   1 file changed, 32 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 13ea8ebc421c..ff63ecc861bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -150,6 +150,12 @@ void amdgpu_ring_undo(struct amdgpu_ring *ring)
>   		ring->funcs->end_use(ring);
>   }
>   
> +#define amdgpu_ring_get_gpu_addr(ring, offset)	\
> +	(ring->adev->wb.gpu_addr + offset * 4)
> +
> +#define amdgpu_ring_get_cpu_addr(ring, offset)	\
> +	(&ring->adev->wb.wb[offset])

Those are not ring functions, but rather wb functions. Please clean that up.

Christian.

> +
>   /**
>    * amdgpu_ring_init - init driver ring struct.
>    *
> @@ -217,17 +223,38 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>   			"(%d) ring trail_fence_offs wb alloc failed\n", r);
>   		return r;
>   	}
> -	ring->trail_fence_gpu_addr =
> -		adev->wb.gpu_addr + (ring->trail_fence_offs * 4);
> -	ring->trail_fence_cpu_addr = &adev->wb.wb[ring->trail_fence_offs];
>   
>   	r = amdgpu_device_wb_get(adev, &ring->cond_exe_offs);
>   	if (r) {
>   		dev_err(adev->dev, "(%d) ring cond_exec_polling wb alloc failed\n", r);
>   		return r;
>   	}
> -	ring->cond_exe_gpu_addr = adev->wb.gpu_addr + (ring->cond_exe_offs * 4);
> -	ring->cond_exe_cpu_addr = &adev->wb.wb[ring->cond_exe_offs];
> +
> +	ring->fence_gpu_addr =
> +		amdgpu_ring_get_gpu_addr(ring, ring->fence_offs);
> +	ring->fence_cpu_addr =
> +		amdgpu_ring_get_cpu_addr(ring, ring->fence_offs);
> +
> +	ring->rptr_gpu_addr =
> +		amdgpu_ring_get_gpu_addr(ring, ring->rptr_offs);
> +	ring->rptr_cpu_addr =
> +		amdgpu_ring_get_cpu_addr(ring, ring->rptr_offs);
> +
> +	ring->wptr_gpu_addr =
> +		amdgpu_ring_get_gpu_addr(ring, ring->wptr_offs);
> +	ring->wptr_cpu_addr =
> +		amdgpu_ring_get_cpu_addr(ring, ring->wptr_offs);
> +
> +	ring->trail_fence_gpu_addr =
> +		amdgpu_ring_get_gpu_addr(ring, ring->trail_fence_offs);
> +	ring->trail_fence_cpu_addr =
> +		amdgpu_ring_get_cpu_addr(ring, ring->trail_fence_offs);
> +
> +	ring->cond_exe_gpu_addr =
> +		amdgpu_ring_get_gpu_addr(ring, ring->cond_exe_offs);
> +	ring->cond_exe_cpu_addr =
> +		amdgpu_ring_get_cpu_addr(ring, ring->cond_exe_offs);
> +
>   	/* always set cond_exec_polling to CONTINUE */
>   	*ring->cond_exe_cpu_addr = 1;
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
