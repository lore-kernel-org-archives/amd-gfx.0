Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADBEC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 12:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8457B64E9C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 12:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8457B64E9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EA776E578;
	Mon,  1 Feb 2021 12:19:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A3AD6E578
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 12:19:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+qnZBE/GTbEZ/6IrjbVGPxG/Gd3d8VTvAW02wZJq/z46rTg11M94NA9QCXaD/CbwNSk2Lz16PXpkLz7LjHfqCepiQQ3PLRpcyrUFqFMk1ASLQiXTzz7Ddvo+c7i4DUzo3pzfe4XlRFQuiB6U5Ps09HFwdI82Tpyir9dGoRzQhcs7TONcjHxkGuk1TV8WCVpYqaOGKgezq7W4TyjOOodhDquuTJIEgCfxDjWNuzBzdwudKdGZpxV+a36NLjmdPPcQY+408147y+YhDPxP1JuhfDx1KRT+hFyJ+Tyec+FxO30Yz2HuNetSj6vHeIRzey8Un+FPHL5goyvJfqQpliJaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRPUicYrk5VmwDmYjNRuE5e5Enh8YYbi9ObKjQJehXg=;
 b=JW6T2Q4rUVuP/CbU0JLbO7QobOFE6TbmOJ7JTEkNCV+BwLNfZBgBKYVYnyv0XpckUCf718bIUkEoVYigiAY3Hd0K0kr/wiQ1tHQ4DHAiPqyK3Nw6eifzO11LaKKE17sJ41PaZdNnhLR+E8dDSxePkwjlduYrgNYZ+OZhf4EPtUAhNHdS12ZecP20U72a3256GpoD/2UZ0K8jFxU71agQfvTIY7NLTdTZMiqaI/sqXvapqKp7V7BQ9KjCcjUGfFCCjHelEdYHWWL3rHfDhcJhyJNabF6EJvPYcA7xCYlRaBiK9RR6JZQgBqQAqM+cOjlqmptWzCITQby17+B5m7JegA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRPUicYrk5VmwDmYjNRuE5e5Enh8YYbi9ObKjQJehXg=;
 b=YQIfNgKO3CR3+RpgzsncLTTHX0v/Qg9OPIS7i4FvqMzRehP5bcWYncmugfjNg8pZRPnIyC8uyWEp83ZzsvftbksrHib9H1dzjNpn9v7GHOBF2cbaYR5IRqMoSCwAHyNu5Cd0KIQk0M8LeaVvD+P5eJOneYFNPHTDqHNRcn1lzmc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.22; Mon, 1 Feb
 2021 12:19:50 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3805.024; Mon, 1 Feb 2021
 12:19:49 +0000
Subject: Re: [PATCH 3/3] drm/amdgpu: enable gfx wave limiting for high
 priority compute jobs
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210201120735.2970-1-nirmoy.das@amd.com>
 <20210201120735.2970-3-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f2ed5848-5c26-3d60-0f57-2a918eff17e0@amd.com>
Date: Mon, 1 Feb 2021 13:19:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210201120735.2970-3-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR02CA0167.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::34) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR02CA0167.eurprd02.prod.outlook.com (2603:10a6:20b:28d::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Mon, 1 Feb 2021 12:19:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b459f02b-0b5c-4a3a-5c25-08d8c6ababd0
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB434218C964D554B55F6F1CE583B69@MN2PR12MB4342.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:129;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mK+PRHe6oMfI/x6YrT0QbJyizX2O9TKwZIO9khzWePCok16E0/Ul5T+aKlc/mcA1U4BZBaLKoBmZdBcG+FAGPDtXYh00gESOYjkKeP9zIyLgVor+GviwmboehDnLCFUJ6EZLulyNCh0BKUNejIZus05koghV8cziJjF8oRbcbTt4o5GCy+tMw8AJEGdvnZKKd2/WYM5jtv8cA2NucU311gBcRWRUnUePi8kTyihQHZgGnsYf+pfrKRaasox95zv+Oc52avitfIwSvutr5UdArumnnEoUl392qhbFP3S1k9ojfZXEDJq2U4wtrPDXcRwpUNL/SYRK9L1JYpYG2h2tdvjQ0JD1FsePcln76k9NwJjb8nK9dLhPT3AVRX/LgJk046UodyfjPlqf4OecM4P0Ya1nBXev4MRKY6NcBqI+zfdbxw7Kk3wsOw12ts85KfO9cr0rzYZZ+b7y8W4ezMKLYP6VcFNDw7DQUEFvoBO44ymS6LWa1gcMSYobOYiNwLS82CJjbq/L2SmK6PoPHlzM0xXoOah7tY+bWgooL6gX5/pOhqx31NeLqI7HyO9C5FdVq0KlaoyWelHnMyes7YF8k0nMKKkgAITlTZXUIbntPjY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(186003)(16526019)(83380400001)(2616005)(36756003)(8936002)(8676002)(5660300002)(4326008)(478600001)(2906002)(6486002)(66556008)(66476007)(66946007)(31696002)(86362001)(316002)(31686004)(52116002)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YlBXVXhOYlVNSTNwYlNyTXBvTmJYSnhmdWVNcHFyMldXZVowQzlZUjZwYWFh?=
 =?utf-8?B?ZzhhNldlWjcyRFBlRHM0cE5OVnhBRWJjeXN0WlBwWmZMUkhXTlM5dkFzaHBM?=
 =?utf-8?B?VFVDRHRveWR5SFlJRUljRlkzVm4rRThQYm52bEJXNzNIbWFxYVA0bTJ5cG05?=
 =?utf-8?B?YTNQUVNVTEZkT1FpUHQrQ08zdlN0akRDSGlJWUNmL1FPeGNpY01TY3UxQmhN?=
 =?utf-8?B?dFNXRGZBYkRiOXE3cHBHU3B6RXllMHhxck1aTFVHSzUwdVVhMjdCOU8zeEJU?=
 =?utf-8?B?QUlSUUVWeVZjWUEvd1JTTDhLZUxhbElHV0Nza0hDN1dFeThOa2xDSy9mbkph?=
 =?utf-8?B?Q0JqR1JtaXRwZGFBN1hPRnp4WFBIbWQyOW01Unc2TkMrWk5ZS3NOT2tWTnNW?=
 =?utf-8?B?TlFXcDZDVytoekZiNGR1YVN6SENIYld2T2hWZlBUWXlJVlpTNDdZSVRPdUpr?=
 =?utf-8?B?eHFLQnpha29ZaDBHTkIzTlI1UjhrSkx3dWJyQ2pYMHVjUlVUL3dJcTJkMVlW?=
 =?utf-8?B?dGdhZFYvSG9sblF1UkdIbng0VFljTW01a3JPK3p3Y003ckFqaTR1bzNYY3l4?=
 =?utf-8?B?NHVWb1NYOEQzSWFpSVpqZW41VGJBYVpERW1BMGY2WDVpNlFScm5hUUMxSmZ1?=
 =?utf-8?B?L3d6cytiNXh0THJGSlFua3UvU0RiSWFOR1Q4S01YS2JSSkhUdzQycWRWQ1N6?=
 =?utf-8?B?ekhEOFZwM3NwM0pHNloyYmJKL3B1T3dJc3F4dDlNOTdpVnl5U0FTTmx2aU1q?=
 =?utf-8?B?YzNvTDNFQmFncUpNMVQxSm12OFpDNUhtQzlnZmlDSTdoemhKZzNRU3VNcGZl?=
 =?utf-8?B?bFNhTDFNaG01d0JTV1JtakNmdWdOK2RyNit4THBvSlBDU3k2V05wMFRzR01K?=
 =?utf-8?B?ZHZ3SmJDbzc2TDZFeSs0bENzMXhjUTFHYVZyWE9hTG9wRzYybzc4aUpmUktR?=
 =?utf-8?B?QjhtK1dmeDZQVTVpMU1kNVpSNnhrZGZJUXJ3YWlUMVcrYmFhRmtjNU1yNGNC?=
 =?utf-8?B?NHVZV3J0TXJCWFBPdC9jaTVuS1p1YlFSUGRIT25jSERFalZSOXRxZ2ExWWc4?=
 =?utf-8?B?QlpmRkIvaVY4ZTV6QnRVeFo4RTJMZHhQWkVobDQ2eWoyOXUvZzNkaU9ZTnRj?=
 =?utf-8?B?Uzd6WTJtNjRvMGdyZUhoaFFKT2N2SVhsNzZPVVJONERBOE5WWVpzNldqWDhU?=
 =?utf-8?B?aTZlOEVpNFQxb2p3bmlLTlp2dUt1V0FQbHIxWlY0RGdvWjdQRGRtRE1lTUgw?=
 =?utf-8?B?cFozQjE2bk1RTmZPMjZTa2s1dGlxa2d6ZElmNGJ3RTNua25pZk9jRE8vZXRV?=
 =?utf-8?B?QlBxVmRzMEtJQ05UV1dkWnBveDJ2U2hUbDQ0dVZYV2tuVldobFM4Rk12bExo?=
 =?utf-8?B?N2dRWGZXYWVYVTQ1bEFwQWk4dzFaOW1Jc3RwOWlqQzNCQUNEeGViZ3d2VC9j?=
 =?utf-8?B?cHEyTnFOcStpN28rVEJvajhZa0twNmxudWFnazFiWGlhWTBqT21qSXAxdDBT?=
 =?utf-8?Q?zm4pM4stCnW65ywMDACVnRdW2FE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b459f02b-0b5c-4a3a-5c25-08d8c6ababd0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 12:19:49.8670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3nuAYEWJUlattESNMx362SX2jucJCKdhR1RdEngLdQ28mW7O3yXCCEae7RTyKtF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
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
Cc: Alexander.Deucher@amd.com, Alan.Harrison@amd.com, Felix.Kuehling@amd.com,
 ray.huang@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 01.02.21 um 13:07 schrieb Nirmoy Das:
> Enable gfx wave limiting for gfx jobs before pushing high priority
> compute jobs so that high priority compute jobs gets more resources
> to finish early.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 024d0a563a65..ee48989dfb4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -195,6 +195,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   	if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->emit_mem_sync)
>   		ring->funcs->emit_mem_sync(ring);
>   
> +	if (ring->funcs->emit_wave_limit && job &&
> +	    job->base.s_priority >= DRM_SCHED_PRIORITY_HIGH)
> +		ring->funcs->emit_wave_limit(ring, true);

Since we can only do this for one ring anyway we should probably check 
the ring priority instead of the job priority.

Alternatively you could put this into begin_use and end_use callbacks of 
the ring instead of adding an extra callback for this.

Christian.

> +
>   	if (ring->funcs->insert_start)
>   		ring->funcs->insert_start(ring);
>   
> @@ -295,6 +299,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   	ring->current_ctx = fence_ctx;
>   	if (vm && ring->funcs->emit_switch_buffer)
>   		amdgpu_ring_emit_switch_buffer(ring);
> +
> +	if (ring->funcs->emit_wave_limit && job &&
> +	    job->base.s_priority >= DRM_SCHED_PRIORITY_HIGH)
> +		ring->funcs->emit_wave_limit(ring, false);
> +
>   	amdgpu_ring_commit(ring);
>   	return 0;
>   }

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
