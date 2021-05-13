Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0F9C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 07:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46330613C1
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 07:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46330613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC3E46E850;
	Thu, 13 May 2021 07:54:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC3336E850
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 07:54:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+W75n1eORfAMJR8pjlFKfyzlQa3k9FLvMBTvdL61Y/K8Sgtr163uBsS9OF+2D5V5Vu4md9aM7H8un5+YGUCMW8x+M6T/kk5AS+96IfOm3h0jqI0n27JxnJEE+zjhgH7zQxYdNXtm/sW/B3iAj5KrZuigkQqyG7FO0buCiZTmCo2Xs3H5Az/x9r4VWS4ojI3S35NC9EIxyik3HEhtGeGnL8UkpSX14dbjNipH24gMHHj+XsOZlJfzQN4IttxjBjRFqcp/GlXKFlyvOor4vC6C17//vM/hdgLmxAJEs1dH+Z2NGh+CPlhwfnE74imPDaxHniTjH68MHjdCjfJ4py9oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcOM5Oj6pYfhjrQQWgErZOqG+7ztoLAxi2zcXElOV5w=;
 b=dTsJdQGeutTrI3O5NHVystTwZTEwjlIpsLaXHWLH3+mVa4La6kV4Yl5qribMUx5+CRGddERBVB74kwIYl2IdYueBxrDVrx/JZPFjVIIhABkSG9Goxc73lBHpARCbD49QJNj/wMCIG3ITVuLdmFPLAmyuTJ3yrkYXgVLRU5q/hQ1ezZbhqCm4y19gT5gUDbHJSD6dKie1xtejHPlsipd2FaBhPKklZHH9jZL9mpC4Kd9PiTURt5oSA2a7q0GS7+YYvkMzrKUSShnguIJUKXnxQ2nou18zi+mpl9MLxd6tw8CgFzbDXP77+U7X5GtvTIf/4+5clOf1kZke5ES7F7u6sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcOM5Oj6pYfhjrQQWgErZOqG+7ztoLAxi2zcXElOV5w=;
 b=xc6JVmt/JhIupVFpAngWIuQLsKkuTMVwi/nZCb75NYKDXRuyhUG4+9AMc1gf117d7dk7FYb2hKiAb5v/512IvhQTD+jwXpO6gzrXC8uAdEH6HTMxcC/+vtqhLEhVrGUfJiYGiv6p1pCD0qARzzPLqRN6tHtSB9CY2iHAFElZT0c=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4783.namprd12.prod.outlook.com (2603:10b6:208:3e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 07:54:35 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4108.031; Thu, 13 May 2021
 07:54:35 +0000
Subject: Re: [PATCH] drm/amdgpu: remove unsafe optimization to drop preamble ib
To: Jiansong Chen <Jiansong.Chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210513032130.3069-1-Jiansong.Chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e1e8ce15-f035-e21a-e466-3e3afe008cbe@amd.com>
Date: Thu, 13 May 2021 09:54:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210513032130.3069-1-Jiansong.Chen@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:1e3f:7b0a:2eb9:c6dc]
X-ClientProxiedBy: PR3P195CA0024.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::29) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:1e3f:7b0a:2eb9:c6dc]
 (2a02:908:1252:fb60:1e3f:7b0a:2eb9:c6dc) by
 PR3P195CA0024.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:b6::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 13 May 2021 07:54:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33d0c2e3-d3f6-4f03-2f6d-08d915e459b6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4783:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4783C6975952B60928E2BF4783519@MN2PR12MB4783.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L56tg7/smebNhqsVMZ8sxkcaegrytNhiYrxPUEqX7zt9ZcjeQPoVpdz1yLb/umX4t0Mbbv+WluLEnhRtyr7bq7g/2wwya335xDr8fNvMvYlRUnaqQDSfyKt7OF89SxMGRLjpyR8wjBmJnobfxP73p3FOQQ8RL7UxqVe7rPglSRRm4OlYpCnTNDE7fRyFLEgtoTt38yMh7hgmiUS48K43y2buEkhmn1yMEcR2SkR0Mo6EtTWZwik2EguDsiSc0bSvcnhT3vss8UrSGlDBnaLH1CEJyZ56LbeZ/pLh/X7A43I+1SesXyKoMvHNgde/ZOLuLK3gvUj0etOki16KZHL/aAH6KKL/BF1wJ9IfOfMxkUDAYiP0e9SgIa58piKlgG25STyO+F5bQGPjEh00A7Qt+2BcCP9mXgWHBCa6TNvZJdkByZwhvKpZm+T8D7Pzku/5QZgH9kZ/w9Qi7C3ONlwv2NxcpMGCeY/j+PsbRtFdq1WDgMgkGDYkLgRyPXdzGbWg1/+y8Q4FVdL5N/rlyuNagq6yvSewgVaOccd9J+/nsJq/0Uvx0k6SQjMt7KVwlkelt25c9Irl59Gu8CkTkEmA/xUVi0OJvKiLBXor3EuVIsH1ZQogmDULD65HQT0HeoPXBJQcClYbo9L3cQhTWlZZshGm2Ym1Ro0XUpbYr8NzmpYimH+/k16nSITz/eueOw2f
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(498600001)(83380400001)(6666004)(4326008)(31696002)(2906002)(38100700002)(8936002)(6486002)(8676002)(2616005)(52116002)(36756003)(86362001)(5660300002)(66946007)(66556008)(31686004)(16526019)(66476007)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?azFOVFRrV3RNZGJRVnNyU1hIL3A3MnFyb2RJUFU3a081MjFidlN0citOTFda?=
 =?utf-8?B?Vzk3c29pMEMreVlRcy81WVlVT1BQa210blVWeVhaQmFLS0d5S2VWNUQwaXZl?=
 =?utf-8?B?QTF1QmwydS9ibVozRWlxc2lCMXNBTDA4a2twNHpuR3c0ajF0WDJRUXhtUktk?=
 =?utf-8?B?OXRFeWpKNXU4N2tZcDZiQUlrRFA3Y3p5ZmxYNXRpeWFIOTd0NXJ3Z1BTOVli?=
 =?utf-8?B?VVR0MjR4b3RUekxHOW1uVkJXYTFzdG5WQno2K0xuQlRYZE1iM3FwRDk5dlVo?=
 =?utf-8?B?Uk5jSlo4aGxxMnNxK3hubzZZQVk4OHVCendDR3lYM3gzYjZpa1dNRllHTjYv?=
 =?utf-8?B?Q3ZwNk80RVJnVnlFTXR5WGdEbUNnbFQyKzZDeSs1S0dsT2taVFJ6VUp4akFI?=
 =?utf-8?B?NGZ5cHZIVGI0SUJuWFk0RE1EVTMvRnQ0dUg0Uk1MMGlWOGFMYVVUSjR6cCtl?=
 =?utf-8?B?WDRKQXRDWmJiVjFjU0xFRGc1SDhmZWJ6ajZJWURMdXRiUFE2Y0FDQWt5K2tj?=
 =?utf-8?B?MUNmUkxiN25oZGlTSll2aVk1TTd0N3pQdEIrNUtGeDJxcFQ5aHlML2g3eTlo?=
 =?utf-8?B?UHZvdU5jRnlJbnlrcVlLNndEdUlzVTRUQzZUd242aTV5eTRucW5kWGZnbDR2?=
 =?utf-8?B?RzRVc1RBQldXdzRrbDd2bHd5bTZHWWdCMXJ3clh5azREd3Fvb3B3TGM1UVZ4?=
 =?utf-8?B?OHRKY0RrVDJ4NWFJUWVYNFlmbmFJeGgrbXJvaTZlODZOVkQxR1VTYVVuclFa?=
 =?utf-8?B?Y2xWb0Y2ZGNxaWtxTVpmQXhTaHc5K1NxQUt1N20vZ3NpNlZOS3lKc1UrM012?=
 =?utf-8?B?Tzl3NWhDZ1dSRTlBVzA3YWxqVjl1REJJMUY2OWk3UFVtaWc4ZlRxN2JZYWRX?=
 =?utf-8?B?T0NWWjBLQWVnQ0g4Slh1SzR2bEFNalJHUTEzaUZzZE9tL29rUVkwRnlvaEZq?=
 =?utf-8?B?TC9CM1JHWkx5OHQ1cGNVcEJLeTBxSHovMGNYdlpGa1Y4bTVSOGZsY0xGTHdn?=
 =?utf-8?B?NjFVeFMrcTVrNldjZ3VLMnNua21RZFlCQi93NWRMMkNuQnN6R2pSZE94Y1g2?=
 =?utf-8?B?MkdGMGxCMGhMaTR3bEtERDlFdHFpRlQ5cXM0R1Z0MWdvaWNZa1dCb1ZUdE1D?=
 =?utf-8?B?NzgvQnA3QUovNElmVVJhVWhuYWdVNG5rL1hMdVNhWjJUYnkwMTVlbHUzajNr?=
 =?utf-8?B?cVlVeEpTK2hQQ2lnTkZaazhFRlpOR21GaFd0TGdDQzBkM3VmU2FnNDhEZzV2?=
 =?utf-8?B?Y0dia3BoT1NpRlZOMDRCbzREbk0yaE5Cd2V5L0FpYzZ3djIxNi9ybzZqdERU?=
 =?utf-8?B?Uk5NV0lFM2lSQ3REUUVOVEVnbVc3MEt3Y3ZiSzNjT1BJVlZZZXJreGcxNVlW?=
 =?utf-8?B?V2RkWDZUbWtyNG55bkhLT0VDQnhaN3ZiSU5BaGEwaEVhcE9OcHRYVDNDTVNX?=
 =?utf-8?B?QkJ2SHpxcldhQUlRc2RtSVdoNjE3OHV1SHZ5SGxWbE1Ob0dYa2dCNERYeTBK?=
 =?utf-8?B?b1FTa1NPK0w4SDRkZk1iT2YyVDVUaE13LytQRGN4RXFkUERkSTk0cXlyY0hD?=
 =?utf-8?B?TFhFa1hqZkxVSFhJU29Ncnk4SnJ5U2tmdE4wdFk0QTJWMG1rTlNkMHRUa2I2?=
 =?utf-8?B?RXZjQjU0RVNVYW5YUUw3S3ZDbDRVMEh1OWFEVHNpRUFiM3YwMlRlSXFCZGV6?=
 =?utf-8?B?OXcvUThqRmxFYTArQVJrcndLT1dvYnAyOUdoN3JtWXJ5ODdIQ1lTSXJGWloz?=
 =?utf-8?B?QjNDTU5lN3ljS3E0cWlZUld6c0pvNEo0d09UaXg5Q2Z5RDNaSVZPK25MTmZC?=
 =?utf-8?B?bHd5Z1pGaXBGTWVnSy9aWDlsSitHNGg2MGQ0dWN3YjJKSldLdkx3TXZkSVRr?=
 =?utf-8?Q?lXgSnPorgbmHV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d0c2e3-d3f6-4f03-2f6d-08d915e459b6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 07:54:35.3473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pdgVAnzX+5c+Ng3XJkBbQ3cZ2HDSD/v+AjJtRkbGijlYFpt6FH+B+Rx55AU5jpK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4783
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
Cc: Hawking.Zhang@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.05.21 um 05:21 schrieb Jiansong Chen:
> Take the situation with gfxoff, the optimization may cause
> corrupt CE ram contents. In addition emit_cntxcntl callback
> has similar optimization which firmware can handle properly
> even for power feature.

NAK, it is the whole purpose of the preamble IB to be dropped if there 
isn't a context switch.

You are completely disabling this feature with that.

Christian.

>
> Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
> Change-Id: I962946557108bb0575f8b2afc25b18a6dcf0d838
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 2e6789a7dc46..77baf9b48d67 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -130,7 +130,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   	struct amdgpu_device *adev = ring->adev;
>   	struct amdgpu_ib *ib = &ibs[0];
>   	struct dma_fence *tmp = NULL;
> -	bool skip_preamble, need_ctx_switch;
> +	bool need_ctx_switch;
>   	unsigned patch_offset = ~0;
>   	struct amdgpu_vm *vm;
>   	uint64_t fence_ctx;
> @@ -227,7 +227,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   	if (need_ctx_switch)
>   		status |= AMDGPU_HAVE_CTX_SWITCH;
>   
> -	skip_preamble = ring->current_ctx == fence_ctx;
>   	if (job && ring->funcs->emit_cntxcntl) {
>   		status |= job->preamble_status;
>   		status |= job->preemption_status;
> @@ -245,14 +244,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   	for (i = 0; i < num_ibs; ++i) {
>   		ib = &ibs[i];
>   
> -		/* drop preamble IBs if we don't have a context switch */
> -		if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
> -		    skip_preamble &&
> -		    !(status & AMDGPU_PREAMBLE_IB_PRESENT_FIRST) &&
> -		    !amdgpu_mcbp &&
> -		    !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
> -			continue;
> -
>   		if (job && ring->funcs->emit_frame_cntl) {
>   			if (secure != !!(ib->flags & AMDGPU_IB_FLAGS_SECURE)) {
>   				amdgpu_ring_emit_frame_cntl(ring, false, secure);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
