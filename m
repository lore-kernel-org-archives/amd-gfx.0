Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E23C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Mar 2022 06:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EE4110F021;
	Tue, 29 Mar 2022 06:10:29 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2072.outbound.protection.outlook.com [40.107.212.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B609810F021
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Mar 2022 06:10:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fW7QTcTg/6elEa4jm/GMeKCYFGbYv+OB/fSAvJ2ZM0yUhqeocFY+RXQyvFNHjz/lcQAUg3I0JNhiYr3K1vDkyEwxjRdZKyOxejd88anNTRzW3Df2aZinzCerZDA5EdJXgPMp2mn2i6DDOY29c0E071Z6KA3iopnncA3Se4Ll1B0cgy7befa5S6ICVbuIt736+uUiS2Q17vgJt0a6ItCzTmSHQcgeQZJp3miS+ZbH+X7r8JBg/LPb6TTk1xDiadY21NJtfsHcCxjwfLg+gyhdzybBjFsaHCA9z7W+mZCr1jYz/rk6HiLmlv7Ciu7ssQSKCygeUpUrGYUAS/vFiNRDYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=553PKi1+jv22k3siYvogOjxEi+0LUKc3gpmyijgNKos=;
 b=DazzDxhSHsGChC+Yn8cAqVGDDkOYE2drUeBiNUWUhtppmDZxCvx2ZgZ9iqJ4KacoQvC04FdrugdztUWcJer12OGILJ+Ku/Mx5dXPRFTa19m1ku9fp9VxrSjZlcMx/c5oLg5ia6dfTAwrCXsu0MZUVQ3ZcBAOOkglY5nVQT7X74j2J+TgIH9valHIdMqzOtcLLWsRHD1aMhK44iC4gisaUQEFrbcbWrxTNVan4AF1AdwjgBHRZoTgmRX5apQXZ3s0DFH/02AcmINRKHgHIhKhTeOEFx42fNFBzLUDKRrhqZ3KWVk7++4jwHGAKmaGLPzwCDfvj/gdbs7lAbkn5Npuiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=553PKi1+jv22k3siYvogOjxEi+0LUKc3gpmyijgNKos=;
 b=d1FOYv94VgogLGl2rKbhaFPiIQafQYlYxNWonA+XVRuyJGP+50flhPHDPDJPQ3r8gFwdnPaFLs2hnoLP4tDl2hefY6+DamISwc3c/wreUpKG6LyMlfCb1MwLL+XGtSL40M7Q6TCttJbE3wTeZemBETj8lfhx8zk52IR37z/LO7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM5PR12MB1322.namprd12.prod.outlook.com (2603:10b6:3:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.21; Tue, 29 Mar
 2022 06:10:22 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 06:10:22 +0000
Message-ID: <e81d029d-d6e3-13ec-95a8-cce380ebef2a@amd.com>
Date: Tue, 29 Mar 2022 08:10:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/1] drm/amdkfd: Use atomic64_t type for pdd->tlb_seq
Content-Language: en-US
To: 20220328130700.29642-3-Philip.Yang@amd.com, amd-gfx@lists.freedesktop.org
References: <20220328211952.21889-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220328211952.21889-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0078.eurprd06.prod.outlook.com
 (2603:10a6:20b:464::28) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 645c114c-49ce-4205-9ffd-08da114acea7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1322:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB132252D9D84C70ED54F0D9F6831E9@DM5PR12MB1322.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: or/puP8+B0Fq+dx2PDMTvykrIEGVMT34/v5EHqstVO3YjbVtFCqnxOytXFNuXtzlCX1LrknBSf41T/h2Z3wYEnwUcHUZIVZtPZjQUiHyuIOS+a2h9j4cG8w9ME5nc20dQYWIFGamhPAfnYtisHFuZgyAr+0PXXHV+kh46PlG2vRxkQBiRjUj5O6Dv84e+/z+NozbKhL2b1T6JxZBY0v5zbF0j44zYERRNOhzNmowkeTN6gujoS+Kd4yZLNzNwiemU7liaWaoKpOSU4e4uFiSXoIAgDBT++VafIMI5oCIGx2IXeJtFrwwYlbTNe7WQHVst6w2qCCocuZc14Go/C5nv+rqaS8Db0jij+j6X5geCXNphR9StA/Ma52Blz8+FYiM3KMlw0WVxO7JlGXgHqab/ers/Hp7M52NN1xpMqpmGXzvEtJsnwPf7x8JO1L3Spraf05m4D6VTsjgy3rmo6+Lg+yZ5CeCWEQzdz1TSwWgkLpE7yJHkXEpEE7Wd+tjNZrr3azMXDCZUbrerySlqrTvjRwq/QzCVvhWSkz3EKOOvUWfzISDzilAa4RqT22xD/hsp66wLXsESH/kktAZi5XTEOqSCHCD8bydH8GMj4YeYzp0Gi9zUUqLPuaxE3nCbJNKsSnWNio8M1ORBShLjxIUbGD9t85Ox0aWENeSFkVMbuRfbzFvmJrBXzqz/lVPIfsRdJ1UD3NIr490F65qqWg21NaiF7ZbgqzfcK7/R2GT3C7DagYAWg9t72zByNoAjUaH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(26005)(6512007)(2906002)(2616005)(83380400001)(8676002)(66574015)(186003)(5660300002)(66556008)(66476007)(66946007)(8936002)(36756003)(508600001)(6486002)(31686004)(38100700002)(316002)(31696002)(6666004)(86362001)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkVUejcvRlBkL2tUUVlyYThjYk5KOXZiVktPWDg4dWVBb2RpblBKVUFqZWdX?=
 =?utf-8?B?NW1nZ0lTVUVoS3NOc05WcmRhM25YRGNKbzh1QVZrRHJnWGRNNUppa3hCamJR?=
 =?utf-8?B?ZWdWMUNiSTZIdWNOOURodENOaHVqOVo4TzY1eUlaN2JCZXZvYXM4bXdYTTFY?=
 =?utf-8?B?eG9ld3E4WXFpVERQZHdPdUZYNE5DekdYT3ZWbDAzS1dlQnJCZENwMXB0TzFq?=
 =?utf-8?B?RFdHY3FOVU44SVl5UGhBbW5yUUFqTlZUSXVwdEdzY08yZDBveXd5TnlTeTdF?=
 =?utf-8?B?Vjd1VWxzVkdRWjhxUXAybTJQejZpTFh6VzNOazhXUHVVWUxaeDlUdVBudy8y?=
 =?utf-8?B?cEtocm9peTJoVUxDaFQzMnFZSDNheTNkeWlrVk5IcVNLNDZ6WWFIOENleUQv?=
 =?utf-8?B?c1c2YXNNRFJpSkNyekM3bTkvc1h6OFhkZGJVVCtnbStqMlMxaUx6NnNjb2g1?=
 =?utf-8?B?bFQxQ3lvT1Z6RE9qaE9GOVRTZE04QTZJdnV4bFgvMVNqNTRoeEdyUWtNSHVx?=
 =?utf-8?B?OGxrbFlwd1hKK2dZQU5ETlkycVlYT3R0clgzajUyMTlHbjVUb0htVzRvR2FR?=
 =?utf-8?B?MFZJek5ybVJqTEkwc2VlT0l5cUMzd3Z0azcyc0RudHM3c0xLMXZ0OWdhcjdW?=
 =?utf-8?B?YUlIM2ZCQlhldjUrdUhONERRY3V5ZVpmNEMxSWNBWmhzTU1TMlUwbld3eEFo?=
 =?utf-8?B?RG1mc09ETUFCaTFCd3pVeE94eTRxajMzeU14dVFUK29leXJycE1QbVg2Y1J0?=
 =?utf-8?B?bTdXTFpzaHNDOXNjY0VTS2pUQ3YrZWtjQzBQakVNWEk3YWJUTnpFb3VGWHlH?=
 =?utf-8?B?NjZUZk83bVhnc2cyWXRnNm1EVmtZREpGTzhjV2ZuUEFzTXBLc1llZCtSZGoy?=
 =?utf-8?B?UytNRWY3Vm90bkZFOGNMcExMQUZqNnpxRndzZEFCbFV5TlNXZ0ZEVFhaZHE4?=
 =?utf-8?B?Y2hTeS9Vd1E4Zlp6RWlVbVhublBEazBEK2JTNDdQMWlTT29CWGYrR2tJSXp2?=
 =?utf-8?B?L3NTcHNJbjlZNGdoU3RGSldGN2JLK0IrTlk4MXg5TkIwM0hRVzN3M2lwbE9k?=
 =?utf-8?B?eWxqVFBncFkrOThuWmcvR3NwS2d4WGtSTGJzMDhwQTV3OHpmaHJ5cTluNzll?=
 =?utf-8?B?QW1uUmtTcUIxeHRid0NMcFJldmpILzdNbUtBT05FaElnbGwrRFRsdXJKU24w?=
 =?utf-8?B?Z3pNNVJOUERMVFVoV0V6WFpIMFVSSThuQWduTmQ3RnozVVhkSnREZmV6YXJG?=
 =?utf-8?B?YzRteERNNVpKOGdsK1NLMHdKaVRVK1VJZk9UTVFEcHhjRXFoUnJGMlU1YURh?=
 =?utf-8?B?bjNSZmFldWExNURiV09zOVZ4NXRvTy9aMENLWWx2NGdyL2s1Q3d3TGpDR0Qx?=
 =?utf-8?B?amhURElNc0FKaEl0YTdmSXlaN2lHOElxd3NkYkowZGxKcEpMM21Ca2g0TEhi?=
 =?utf-8?B?YmhtQ1lYdkhzYThhNllUNE8yWE1xeXlxdVFYa1JzaFc3L1Uzd3I3M3VmcVgz?=
 =?utf-8?B?bkpqOGpLalRhdTdFTG5lZDcrR0NCakk2Ykp0OWtVM3d1NWMwL3M1YVIrcytL?=
 =?utf-8?B?TkIrRFZhSHFxMXdjdUlRditndnVnT3IvTkg2UHVwREs4RVl0ODRwalJ6S1pw?=
 =?utf-8?B?NTVzV0RaM3c1aE9QZEFPNDFhNFd4SGZlSGhkSXBkbUFTSUN4d3c2VlUya1U4?=
 =?utf-8?B?Vys1Vyt1OHA1a04wbU1Sdmp2U2FkcjdBYXVYaWdJSUZBd0ZuMmpEakpGMHFu?=
 =?utf-8?B?d1lndDdLNDhvQWdxVktENVFqWnp6UjJqbFF5U1dNaDFlR3gzMEZSS3JNblVp?=
 =?utf-8?B?VGtKU3pTWThIWU8xZm82V0VSYlduNnRHVmFrWmE5QVlDbkJPWlgrYXB1RnRV?=
 =?utf-8?B?RG5Bekg3ZU1UaTg3ZytCQWpWNXBYbCszVkVnNGRzdVZ4NFJEN2NkNEFoTDk3?=
 =?utf-8?B?V0o5TC9EUmFwVk9pRW4xdmtXSGpvVWxxTHZSTTdVZkFJbjZ1K2FkcDB0SDZm?=
 =?utf-8?B?SC9MZ0hNUW4yWW1RUUpxTm1rTnNyTGkxbHFHUnFqL2tIWERZd3F3a0U4QWQz?=
 =?utf-8?B?MGRMS2RjMUxpOVpIUklRK1Y5SGwyM01nZjNkOGxhZjljWDBoZnBaNWh1ZDgz?=
 =?utf-8?B?dWdDWXJpV0RRbndIa3BOWEQ1a1J0WXBQbE8rYzRhTjBPT2ZvWWJLM3ZkM2J2?=
 =?utf-8?B?QkxlaklZUCtHQjBRVVYzSFF4SU4vNVRtYVJHT3B6MG5VeE5xRkpqUzdvVjZu?=
 =?utf-8?B?Y2NTeXZ1dHBHaVBoYXpITVZWR01YeVlXS2ZoR1UwUGtVcVVGVGdHd0QzZFRm?=
 =?utf-8?B?Um5laEJiSXIyMlY5b0YxOUhMbGNwdys0d0tYTkJFOTZBaUZHZ0tiUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645c114c-49ce-4205-9ffd-08da114acea7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 06:10:22.0877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4GCVyktH+uMWJoxTn/xo/MNm4dabqBUyWk7QWfjGpmETh6XmX2a/1ISY2ZMX6OfD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1322
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 28.03.22 um 23:19 schrieb Philip Yang:
> To support multi-thread update page table.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

One nit comment below, but patch is Reviewed-by: Christian König 
<christian.koenig@amd.com> anyway.

> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 5 ++---
>   2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 945982a5d688..e1b7e6afa920 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -705,7 +705,7 @@ struct kfd_process_device {
>   	/* VM context for GPUVM allocations */
>   	struct file *drm_file;
>   	void *drm_priv;
> -	uint64_t tlb_seq;
> +	atomic64_t tlb_seq;
>   
>   	/* GPUVM allocations storage */
>   	struct idr alloc_idr;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index ac8123c1ee8f..267ba8c434c0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1560,7 +1560,7 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>   		return ret;
>   	}
>   	pdd->drm_priv = drm_file->private_data;
> -	pdd->tlb_seq = 0;
> +	atomic64_set(&pdd->tlb_seq, 0);
>   
>   	ret = kfd_process_device_reserve_ib_mem(pdd);
>   	if (ret)
> @@ -1954,10 +1954,9 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
>   	uint64_t tlb_seq = amdgpu_vm_tlb_seq(vm);
>   	struct kfd_dev *dev = pdd->dev;
>   
> -	if (pdd->tlb_seq == tlb_seq)
> +	if (atomic64_xchg(&pdd->tlb_seq, tlb_seq) == tlb_seq)
>   		return;

It can be that we race and lose here, but that is extremely unlikely and 
the worst thing which could happen is that we flush the changes into the 
TLB once more which is harmless.

Might be a good idea to note that in a comment.

Regards,
Christian.

>   
> -	pdd->tlb_seq = tlb_seq;
>   	if (dev->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
>   		/* Nothing to flush until a VMID is assigned, which
>   		 * only happens when the first queue is created.

