Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02B7C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 16:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE773604AC
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 16:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE773604AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D45F899C7;
	Tue, 26 Oct 2021 16:21:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD38C899C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 16:21:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDjcE/wlQjodLCk0Lc2n+ArQ5HIOUW67r0Pq7CPiZ8EIi/AMKG95n6A3ssIXj3fbzVVV6hXbTFC9Np4wVicmR7NjQFiv4RnaOOdN8RwZCmweq+jQ1TX22cElYJiTA98OyrQj60v67beJaDhCzyybGATPG32BQJ431VWZtdKWW3o543E5UWkH7fnSbu0lqd5qJ5PgAVURuIcEvX53YGJVsHt69I+cmkOALmtfHVCxTgxMx45YXo8+Gr0YZ6xqreCd8GiRxszDIW52q+lKm/CRETeYIoi2yVftDYN0Mj0rzPDIpIyAWnU4zqyvKLXLbOin70GhMXhbqK2XRPp/RqT9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g65gcfov7nD5Q7+X5jcamD1FuvuwO1omLAKH1pZyd1s=;
 b=j6z0fokzbYTwj/3qsZ89rjRI3G4kGtSEPnPhAKBmzTE1EKpjJ5NIEKOsOPa8KwSY4/jtfwwQ4uH/qIhzNPbMa998GZ/lFkdrYTm/aHuuwkcfMhbSlFCpzSuYkCgXGhGP9KKRw2L5pCvpe19yvB/gIek3blxmz4vo190yDUvXtgqq4IIi3LVF745Kny3SqOV/HlleGnhBRhqjBmnlhQ7IkgSkPnxgwNFsNpt0JLyEEMjwd5aLycvn0HGA6bT1RYWL3n5XG/fS8rrm3ggYC5MZHIw5oyP6CwQyyBUh0mLH3kO5JhZ4ByUq06ObkqdXOeMnSTaz7AwcWI9N5FESU7/hcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g65gcfov7nD5Q7+X5jcamD1FuvuwO1omLAKH1pZyd1s=;
 b=MlGInEYFS4Ov/QLVe8MRBwUi/hpowqIDVX76TT3VQ6oGZMIHqjWpYO6JUHvlafdPgsc5ClOHW87pIp9BzUX2eDj4nUaEr+Q3KggV0hrmsCBbcmTjqvueHs2RDVm4DoA+M2tnSPQhmqt5sqUIDvIKqDV63yeeX5AZrSD8Syy+3CU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM5PR12MB2485.namprd12.prod.outlook.com (2603:10b6:4:bb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Tue, 26 Oct
 2021 16:21:35 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 16:21:35 +0000
Subject: Re: [PATCH] drm/amdgpu: fix warning in pr_debug
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip Yang <Philip.Yang@amd.com>
References: <20211026153612.474820-1-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <47604677-2f0f-0b97-c18d-1c064d790aab@amd.com>
Date: Tue, 26 Oct 2021 12:21:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211026153612.474820-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YQXPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::18) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YQXPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:14::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Tue, 26 Oct 2021 16:21:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb6f624c-7d47-453e-7a9e-08d9989cae20
X-MS-TrafficTypeDiagnostic: DM5PR12MB2485:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2485A2B61AF9417EE76C0CAF92849@DM5PR12MB2485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oE1BmoECXGqorrhXXv81a1mxbO7CTPNUXOZRG7PRU1LyLAc5NUvd5lgY5nx+NRXbza0Bw++ktaoB5117QAx1EkeHt0+eQbr7HVmY+y4Rk2U6KYSwLupt1UzJE8pzczguMoDnx1a/jlKf3Yg2n5g0kegUGPmd1F+/9eXS+cr0bqXlE6hztDeZxqy5qWQ5tfrMUDXQzxqkDclTY/8Yd2GJiMq5Co3+tED0t7lWbzXsUpdqhR9eBP9vR1I3CQ7qsXyLwhPbKN1BSPC/Z4pLDeLLm+7Kb+BW4KWJC53jdaYJ7fU28K4pQARZN6syKXnBUbG8wvbzGc+jjCjt3oIX7oe9423T9fg38824v8kYeO+++9ngvv8HQq1TmlN8JjKk4WYhC02M5xcIPEQF9icf+eFTrke9RuljbUrNDqfsjAVZdnOa1ar7EXuB/IVobPA/h8mTuKVAjUxN4t73GWukwh/gKRRNwQWaRBnejn6xrYliLrc4EkWO4qJ4RPAc+VYtBgmHI8frdRbKilhfleCA9jdRh0dBcZaUJQsjkOGIuwrL5dB08WKY6fVYeh4nPfzio8Hr+VA5jUtbXJhfG2MYhXdnDk8XOB8xY40F0aZdab06YeKu3xB+FBlbt/LSP7H3JmDlSmLXIyrlu0bXIxKKve99x09p4pGq0jPQKrOPkfn2TiqdgkZ7TBYZInIv2DUH0vco3rLKCUwKnfycED+4rdAVL/4hQmhwtGmJHxNcF3aLRnreGcxQYZCcUGSrI20wBso4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(36756003)(26005)(956004)(66946007)(316002)(16576012)(2906002)(66476007)(5660300002)(2616005)(4326008)(186003)(508600001)(38100700002)(4001150100001)(86362001)(83380400001)(8676002)(31696002)(6486002)(44832011)(8936002)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTR0QUlKb0dDMVBVNlRDTzgvMjl2R2RMOTh2bTBVbDRnUHMzL3pQWCt0aFVF?=
 =?utf-8?B?S2dzWXlrVmVLOGd2K0I2S0Jva2llS3ZZS2xrVWZxWXRGMWRVNDd6cTIyMjcz?=
 =?utf-8?B?aHFnSmFxWStOWHhheXpoUGFQbUp6MHgzREFDKzRTR1E3dzU0KzYwQklHeHEr?=
 =?utf-8?B?NVcraXA0MzBhekVlUGF5ZlNtUlZEbkhpM1VDM2hPYTRSVmtKNlZsb2t5REhZ?=
 =?utf-8?B?Q25DTk9zb0xnSHQ5bHBTS29QNkRidW41OEQzYzZvd0k1a0UwVnFNeWhuZ0xW?=
 =?utf-8?B?WHpTUjFRaG1wWVBVTGV6RExnWkN4dW9KR1lQTGVLY3lWOTNhVmRDNG9jSmZF?=
 =?utf-8?B?QW9qLzk0aDJUOXRVMlczYlJrRHdYMWZkSkJSdzl1Mit3L3JMekIweUJ4T3pB?=
 =?utf-8?B?WlBFN0xEbnZHUWJpd2hLb1M1L1E2MkpJQW1ZN29UVk9HN2orVnEzS2VJK0lS?=
 =?utf-8?B?bHJqMXFtdWNad2tSOVNFS1VIYk5YbE1qZDhMNkswRUNpMUd0Y2NsMWx0ZjJN?=
 =?utf-8?B?dHlLUjNzQTNWcVlhZm80bCtBdVk3bnNUUmpJZ1NFZHVaQXl2dHpxTHA0NlVQ?=
 =?utf-8?B?eXZZempiRm1IL1FHOW5Uc3pFYXdEUGhmZ29ORWRzMi9WR3RzcUZCYlEzNFdR?=
 =?utf-8?B?QTlsOTJQenMzU1Z6dU1ZZEo1YmFxMTMrWXU3YlZFQzJXZEc0RlBDVmd4OWNt?=
 =?utf-8?B?eS9OaURTVUJYRHVSaFIxNG9aREpjK0hCRE5kWkJyKzI3MzlDZklJZnBycVV3?=
 =?utf-8?B?QWhUVHAyU3hwUVN1WXR4OFF6L0NPWGNlZ1lDUWdyOXhla3NLdkMrekZubU5L?=
 =?utf-8?B?MTBkYXNNTkp5QXg2aEhZSldUNERkR0tKTnNIY3FuZ1dxUGZrTmZLbEg3M0Ji?=
 =?utf-8?B?Z3pTSkdkeURqbm9JN2ozQjdEN3Q5VWtzaW9ISlZzT0ZwRUZDQUhYcjdiekl1?=
 =?utf-8?B?Lzdhenp0c2U3QS94d2VwYnZ4VWQ4ZGNPS2xjWTdTV1JLUnAvalliU1ptSnJj?=
 =?utf-8?B?b1FkV2JIZ1FTblNKd2N2eHVodzdHTVhxVHNWM0pHWHBjamlSVlZEdlpOclNJ?=
 =?utf-8?B?Q3Fqdk95cDdwQUJLck5iNFFUYmU1SmhaYXZzU0JOKzlqSDR3K2Rmci9ad1A2?=
 =?utf-8?B?anVDL3pLMzYzb2dlMmlNMUZpTVVWVU5GNWl2M3Zwb0NVQVZadGJVSlBLNDlJ?=
 =?utf-8?B?NEdoN3pEUlE4YkVkNWE5MW1RcU1TT1ZvbmRnb00yL1JTUmdqRHR1aU5rdFFB?=
 =?utf-8?B?SWNHVHVReVc0a091ZlIyKzJBeXVzdzFWTEZ6NnVBMXhJMEZ2OG4yZHI4UitL?=
 =?utf-8?B?VU02ZHFCMyt1bCttQTZUbzdxWit2cS9JK1lyakc0M293TnBTMmR6UXVHYjkz?=
 =?utf-8?B?VkQrK1h2SDlUY1dpRjNScXRxQ3hrNUI4ZkZFTGFZMkY4SDNLNUpsMmlmdFBV?=
 =?utf-8?B?bWk4Ky9JOHg1NGpxeTQ4WnBUOXFMUmxmVjdMR0J6UnF5cUlVR2U4MEthbUxs?=
 =?utf-8?B?Zng0WjJXVlRENUFpKzZCdUdHQWI0cDh2Uis1eTlncW1lU0VuRDFmT291ekVU?=
 =?utf-8?B?S1pPbGtsV2I2Y2xkc0ZvWmp6UTRMQi9NRlRERUZWSmxnaVhkK1Q2VlBENnAv?=
 =?utf-8?B?Z1VrRzdLVmhJNmJNWnJTbkl2QXZydm5HQWxMdG96dmEyNlErakhiTkFwTTNK?=
 =?utf-8?B?OUFTU1Q5VjVveEpBMnlJeU4yMjNqUWpTRU54L2tRZC9sc1lhUmtPSUx4NXdD?=
 =?utf-8?B?ekNmZVZPaW4wRUh1ZzNLMlN6aUZ3MjN5cFpIYUs0K0xvNUJEeVMvOUl4Tld2?=
 =?utf-8?B?aWhmWkhZVnBxcll3N2IvRkROdFhNcmdIdDZSR0xIYk1USWdYKytBVmRGMlRQ?=
 =?utf-8?B?bDQwdGJabjMyN0hYUWVHcTNraUdhakxRQ0tDbmE3SDJmTVZ0UDVNUmpaSXZV?=
 =?utf-8?B?aWNETDNBeFdwYjRWNEpwc3hFNGVyYzVHdmFvSFZMQ1EyMkNxTTFrcU94QStq?=
 =?utf-8?B?cmdiY2dpWHVPbFJScVdoVUZwbW5ySnliUEVnTWxxS0M2MTBDWnhoOUxQMlYy?=
 =?utf-8?B?KzZDQVJLZkdIR0ZpWXpkbmdtS0pxU1VIZGtPcVZzRmwxUCswZXhvOGwzbXdk?=
 =?utf-8?B?RjBFQVF6Y1ZFN2N0TGdybGIyMnR0YWFqS2loRW9kamEzR29nMjJsWlgyQXBD?=
 =?utf-8?Q?rk4ij6SxdtOCxu9RdyiJkVM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6f624c-7d47-453e-7a9e-08d9989cae20
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 16:21:35.4779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBJVz97DdAQ+TJ16sQ4TlMdazIfikQuVLv22K8kesbH9IHYP6LzXwiajSeIq4Jeh4kP0MQm6GA4uaE13DMWtrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2485
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

Am 2021-10-26 um 11:36 a.m. schrieb Alex Deucher:
> In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:52:
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c: In function ‘amdgpu_ttm_tt_get_user_pages’:
> drivers/gpu/drm/amd/amdgpu/amdgpu.h:35:21: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 4 has type ‘long unsigned int’ [-Wformat=]
>    35 | #define pr_fmt(fmt) "amdgpu: " fmt
>       |                     ^~~~~~~~~~
> ./include/linux/dynamic_debug.h:134:15: note: in expansion of macro ‘pr_fmt’
>   134 |   func(&id, ##__VA_ARGS__);  \
>       |               ^~~~~~~~~~~
> ./include/linux/dynamic_debug.h:152:2: note: in expansion of macro ‘__dynamic_func_call’
>   152 |  __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
>       |  ^~~~~~~~~~~~~~~~~~~
> ./include/linux/dynamic_debug.h:162:2: note: in expansion of macro ‘_dynamic_func_call’
>   162 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
>       |  ^~~~~~~~~~~~~~~~~~
> ./include/linux/printk.h:424:2: note: in expansion of macro ‘dynamic_pr_debug’
>   424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
>       |  ^~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:697:3: note: in expansion of macro ‘pr_debug’
>   697 |   pr_debug("failed %d to get user pages 0x%llx\n", r, start);
>       |   ^~~~~~~~
>
> Fixes: 702dde19d4b0e7 ("drm/amdkfd: restore userptr ignore bad address error")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index ae6694f2c73d..881a91a6ab13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -694,7 +694,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>  				       ttm->num_pages, &gtt->range, readonly,
>  				       false, NULL);
>  	if (r)
> -		pr_debug("failed %d to get user pages 0x%llx\n", r, start);
> +		pr_debug("failed %d to get user pages 0x%lux\n", r, start);
>  
>  out_putmm:
>  	mmput(mm);
