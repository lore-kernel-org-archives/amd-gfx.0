Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AB8C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 08:37:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56526103A
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 08:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E56526103A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D976E546;
	Thu, 26 Aug 2021 08:37:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (unknown
 [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AA4F6E546
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 08:37:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXnQ/k8lx0QTRHkLy/BifioJEmSagEABuDcRapxTCcO85Niuuy0XPyUYLtteZpq1EmS422vta0QhKcX6mwqSOwK8n1Z79562SEnwLvURdJfvZ9yc2+Im8psumpPYj0HLKij5x/P1K91KuMQmfFA0wEQAmQ+fEtLJtwQMcht9dJvCoq3QwxAxVarNHLq67JEg9ojBZUxwDMqpM0t0E1Z67tXN/KwYVm7A5Ol6M+wJ6juSvxfTc/Y63rItzUgeURp/McyzuMVen0qh2l0s+5jgJmYJ2ySwGpCOcosQ207e4m/nC1EoEQaacSdi5Z3VafR9sm3LgHeWQtUBWrXDCHFOkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJbst1j8/Nf003vr5+VuXXn883ZyCx3HO7RZVXLBWDk=;
 b=LHbYEABY5apkZ+PsVtNCbE5yPRgLnxunLFbdEE5uOBZ5QKNtIY0v2sw3LDyTcNmDhsiOTuMvkAUearNw3lOfsXzZJHx7fYWxQYNPweWNHWwK22iFAkR+YSDe4XwwcoeoitHqLH9MBQfBsxnB9kGPFcZwCv7AEd+oQou6/dwegEcfN6pb5WqTbzhKTNHqyvn3MkMY/26dB6iKCrI4Q6OCzC0AjtJKYmeajQjY6+TeT3ZbNt84PZ3sjmWHQVSBbnA5pK8lqFcRLUR7NRVsUhX08eNqrhzz5kU4OzVhQ1P+uAXQGLF+LXcLKNkLHhMheK1uGfg3Lqwr2TS9kP37Ep/XJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJbst1j8/Nf003vr5+VuXXn883ZyCx3HO7RZVXLBWDk=;
 b=qOi+eEKPLOpP8vqaIV/RhAJE6pBaSJ3f6yOovaHOPJ4c1zX1yJHfP+QtZh0fGPHaiUyF+pWska6rBslV4C4r52XCWtCv0t7hIvtNfeOZ2Eh9a8hoUa/W9mHh86JckKdlSf7xU/0AfOqDUjKQwn9gqYTXjj/opJRs7hxTP7rmjGo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4868.namprd12.prod.outlook.com (2603:10b6:208:1c4::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Thu, 26 Aug
 2021 08:21:11 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4436.024; Thu, 26 Aug 2021
 08:21:11 +0000
Subject: Re: [PATCH 3/5] drm/amdgpu/vce:set ring priorities
To: Satyajit Sahu <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, shashank.sharma@amd.com,
 nirmoy.das@amd.com
References: <20210826071307.136010-1-satyajit.sahu@amd.com>
 <20210826071307.136010-3-satyajit.sahu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <259a72ff-5c7e-7f1b-67ab-4aa47ee4c875@amd.com>
Date: Thu, 26 Aug 2021 10:21:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210826071307.136010-3-satyajit.sahu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0031.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::44) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:1fe2:dd0d:124d:d9ff]
 (2a02:908:1252:fb60:1fe2:dd0d:124d:d9ff) by
 AM0PR02CA0031.eurprd02.prod.outlook.com (2603:10a6:208:3e::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.18 via Frontend Transport; Thu, 26 Aug 2021 08:21:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fc90391-4c33-49c7-a373-08d9686a764e
X-MS-TrafficTypeDiagnostic: BL0PR12MB4868:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4868C0EC1B9BDAC2AEA7EB1083C79@BL0PR12MB4868.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j6k4s7WN2WJkHEZ6qrO1lGq2Naaf2p/M/XGUBWGhI55DijgoCehiKOLjMnjPNKyZWVQL/aMN4QRnbwYXaZtDnkf1wzZV8nWOAOvFJqj+mwC1D/lO22FvkTsjl+opi3RjtNKudo16MGPBf0Yi0Va9glbNACZNq/Fc6IzIDqfNObafgPr5m+NjCPziNVbR3i7F1Zg5+zSnIfJtJcC+vVoYPrZbGODD5qe7nq0M5KBpwD7tfExrscv1C0vnJIrEhsgurCn0ohkU7GMf8PX+ZRep9xK5GC1SwLYTQ7hvOO2i/7wifjcLCr4MEROOfErjMG/SrgDkQW7oC47FjXxdMBFWRTjvvx4JTIyVyX7Uv5PPRjR7f6QxmpPJ0UdyNiJ2QxySTZmStjaKmtgS4+fzPKAXpUp7qlk0stxRdmzhTWPvCeIb0iPVBcsfjp59P/bPIx4S0FzqRkWzfvlHwENSEZ7RD9kEavjy08+bxoM+mBZoeXjDxgw7YN2NTrskVyito4UrIWu661VE0lXOMkYLpoYRicyDAzlMjTTzuGrmZsLcwbcEt2KAM/SLrFImbD7izm8EGWziBACzdr3u2/RB/q+PPJqqlNXJ4T3mcFBiD2QC38p9BOe3EWY74nmvjCkkocyyGUmzwZeoYEIPqFuOhaYBhCFVPTb9sZwvBmocw6Id2fq6g91sRGuf1y0enR4caD3cF71gQ0qmT65wkg/T4Etr4Ka3RIHd1Al8g58U6Ofgji24gCDqWai0IfSM5XI5EP6S
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(31696002)(5660300002)(186003)(4326008)(478600001)(2616005)(86362001)(6666004)(6486002)(66476007)(66556008)(316002)(8676002)(8936002)(66946007)(83380400001)(2906002)(36756003)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RENMbk9XWmphaE50UHdyQXRiMXdJUUZBNkM5SjE3NHNzNlpQcFl3K1UzdHIz?=
 =?utf-8?B?eDVkbE5SdkxLdW5zc3prRGRJTEl2d0V6c0Z2MjdLWEdXTUFKL3Fmc25JZnpj?=
 =?utf-8?B?bG1tYUJNS0d6cVo2OTIzYTdLeWltU2Nud0hwaXljSUQxbnVhaldLd1NxMnhR?=
 =?utf-8?B?ZlZTL0ViSzhxMEZxaWhydjhXZDk3N1ZOVUdaMnFqVUZMbXpMSDFJTlBRS2ds?=
 =?utf-8?B?MGMvRFdlU3V1ZDNKVHlBbnJEU2svb3ZtUkpWenRLbzBVSFBNdSs5d2ZKMnJo?=
 =?utf-8?B?NSt4dkhjKzk1NTgvRjZwSGFnVnZ4ZmphUG1jY0NCZDg2ZlY5UmtxWjJaMlVG?=
 =?utf-8?B?UUFYMjA1SHQ3SU1EekNWMTlESHRWNStCQVlBYmJKL09DZmU3NXQ1YUN4bEZm?=
 =?utf-8?B?RWJzZEIrNUw2aWlYUTYwL3lOQ25tMXZ6VFFwdVh4TU5sejYxZ1JvUGMySFlv?=
 =?utf-8?B?cmRwY3JINUpReFV5WHhmbmJ5OUM3K0xpWGoxYnE4TU9TM0V0elZDTWpIVFJO?=
 =?utf-8?B?Y2p5UGdiQkNhKzE5SUtWZEQwMHN0Z1NFUGVid3krNTJIT05YM0xiakdqSnp2?=
 =?utf-8?B?cVNYUFczTnVPSFBzKzlHaHZZRE9uOFVlU3hTVmNlelMxbmdJNVlMLzh6dmd3?=
 =?utf-8?B?UU9NNjFjYWl3aURVK213M2FmWEI2MlpQeUN6bjhLUUludzZBQ1RLQXExQkhh?=
 =?utf-8?B?RVA3cm52eERHWkZjQzZyZERhWmFlN2Z4MVZ0MGNNWjg5b2Ftd1QwRitBMW44?=
 =?utf-8?B?N0x0eXVYdjh5QWp5bTVLNVhKVTY4UE5uVlNWUEZTQytsWWZHcGV6c3EwWjE1?=
 =?utf-8?B?TmJ3VVpONXA2aVI1cFoxTlZKMUVBZUloaTJ1UitrK2k2YTdYc25FVnhZMStp?=
 =?utf-8?B?SVQxUTFpMVl4SFhrTXNTdzRYckVUSjQzWlIySkc2cDVJTnZHZVk4K0tTTUx2?=
 =?utf-8?B?Z1kxaTVCQU5NTHl1UVI0QVRZelVmU2xueXFGZ1dvSlFPZnNsaSt3WEJza1pq?=
 =?utf-8?B?RTJRdnp6REdLb3JncytzSUtFL1hMTFRUcENZaVVlRUw0VGxxTUI0R01yYUc2?=
 =?utf-8?B?dG05T0RPd0JBZkVjTWhGQWhtTjZHR3AvTWlEak9Db29EWkMwV3hWb296WnVC?=
 =?utf-8?B?TUpWUE5KT0xmZUdkQ0hpb0ZCUDM3Qi80NkFhVlJHMDFCM1FYK2dYUjJMZFM0?=
 =?utf-8?B?ekE5VzlCZU1vY2lZWmtKNlI1OXh6aTgyRnJ6ejBVcE15Z05JOEIwcldtZHFv?=
 =?utf-8?B?YXRCek9aa2pneDVhdmhCdWcybHYxYVZtYXlXYlJXY0pTQlU5UnhTakR4aDhh?=
 =?utf-8?B?M1RzWGpPUE9tZ09tUU85T2hZM2FTMGR2WGVOcytxQVpBbk9JNFFkU29HaS9U?=
 =?utf-8?B?VHViNmQ3QldmZGE0UnY0eXo0UzQvTDVYWFd5NDFOL2hBSkFMVnA4aGFRSTdV?=
 =?utf-8?B?a2srMXBnQS9NeURTOGRzTVZDMHozTkwyeUtidUpUWjM2dXErang1L1ZtaUlX?=
 =?utf-8?B?V2pLbmZDcUFnY05YZjI3U1JxenltRS9rdWc1cmxzQ2tvdk1oWXpkN1hWbmd4?=
 =?utf-8?B?ZlVJSitWazdMclZzeExTdzhyajgvbmhHZGg0eTQwUW55SFZ3eFBSQVRJenBx?=
 =?utf-8?B?azYwU1lHRmtIWVhLNkdWc2hXSnk4MTVnRjdKUm45eEE4bWg4MXJpbitlVFFi?=
 =?utf-8?B?RFpEQkZxeHR3WU1pTVJibWhpay9lWWZDcllMU0k1b05jdFF5THdtaFFaNnRM?=
 =?utf-8?B?M0R4NUlzenhEY2IvNmFOeGphSzJUelpsbjB6aTY0azJHbmpCRkNPa3hmTkw0?=
 =?utf-8?B?MWpFSVNjc3o2YjNWQnZHMkQyeWQ3a3YySnRNM290M1hOeEVNb0FnS09tcXkx?=
 =?utf-8?Q?ktP02h2EMpDEv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc90391-4c33-49c7-a373-08d9686a764e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 08:21:11.2072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TOAoyQ1mg31WXBHSGt576ccurCYuEQJbuLqplhOmAmUvy3NZe+xVcQZ8Agh5/qvU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4868
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

Am 26.08.21 um 09:13 schrieb Satyajit Sahu:
> Set proper ring priority while initializing the ring.

Might be merged with patch #1, apart from that looks good to me.

Christian.

>
> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 4 +++-
>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 4 +++-
>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c | 4 +++-
>   3 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> index c7d28c169be5..8ce37e2d5ffd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -431,10 +431,12 @@ static int vce_v2_0_sw_init(void *handle)
>   		return r;
>   
>   	for (i = 0; i < adev->vce.num_rings; i++) {
> +		unsigned int hw_prio = amdgpu_vce_get_ring_prio(i);
> +
>   		ring = &adev->vce.ring[i];
>   		sprintf(ring->name, "vce%d", i);
>   		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
> -				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +				     hw_prio, NULL);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index 3b82fb289ef6..e0bc42e1e2b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -440,10 +440,12 @@ static int vce_v3_0_sw_init(void *handle)
>   		return r;
>   
>   	for (i = 0; i < adev->vce.num_rings; i++) {
> +		unsigned int hw_prio = amdgpu_vce_get_ring_prio(i);
> +
>   		ring = &adev->vce.ring[i];
>   		sprintf(ring->name, "vce%d", i);
>   		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
> -				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +				     hw_prio, NULL);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> index 90910d19db12..931d3ae09c65 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -463,6 +463,8 @@ static int vce_v4_0_sw_init(void *handle)
>   	}
>   
>   	for (i = 0; i < adev->vce.num_rings; i++) {
> +		unsigned int hw_prio = amdgpu_vce_get_ring_prio(i);
> +
>   		ring = &adev->vce.ring[i];
>   		sprintf(ring->name, "vce%d", i);
>   		if (amdgpu_sriov_vf(adev)) {
> @@ -478,7 +480,7 @@ static int vce_v4_0_sw_init(void *handle)
>   				ring->doorbell_index = adev->doorbell_index.uvd_vce.vce_ring2_3 * 2 + 1;
>   		}
>   		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
> -				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +				     hw_prio, NULL);
>   		if (r)
>   			return r;
>   	}

