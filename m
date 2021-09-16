Return-Path: <SRS0=YYL8=OG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7B1C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 20:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EA5C60FBF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 20:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8EA5C60FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F2BD6E8CE;
	Thu, 16 Sep 2021 20:40:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61BA36E8B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Sep 2021 20:40:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1YzIpyy7BwswvNqZGsWAOJdsx0mUds6RtZDFkhdOEcHt86xPJDZ9SFTHp5usTVRh9JM5o/+raAqynTyHpZqXoa6U0cSMD+cg3Yj4d4e/6CfIuE9x598iog65sm/P2vsQ+5Ij56NibjeUjl2H2lX6O16/0cxA0v2xjnw2tGd3wLjGauyPM59cQKfG40g+lkg4pdiBnUyiLdWE1yZ4Z8jApILmLfuDWtIWyCSoBEkg00TK4R6CnxuXG8/QkJDfuHS5kAznOYHoXHw3irstQ5zIeEa1Aj0gGoymV1h5ZVTPl65DkbE1hrqoKiNPpKm9EBrLbgt+ymG73tWc6X0ORxyYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=hcywsKCBrG1e4dOMIA9+RectFUfUOZumnu6c44XHKk4=;
 b=CVdORT8TLx4dYxsTP+UlFDa+yQa7fPVVENB2uaNrxnNJlkGK7V9wqYzowGMlCLVO4Gyef9r6WbPpzQeMGVnbG1tHsDQhLh009HgZkBQs44r75zVEHtn/Aj82pFUQ6Nz8YEf0s7XIftan2VLfXGNjc7jCXCJPA8X2SJ5QCsAGIb2TgYVBYD42YYYhnTJGD6YK1S03R0rlYMPMyTHhEa/Q5B3DY1Xg8m+IP1yrzcO9WCocQaEGMVUGiUjSq1EFNT6Y8Wjl43pu88rsRGUNeVRmCzsBQR32MAaPSXhS6zhVkpUz8+RkXFCjY3fqHcPFc9GZuqx5Xc6EJdBIAHGtfCLQnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcywsKCBrG1e4dOMIA9+RectFUfUOZumnu6c44XHKk4=;
 b=cI2lfgfttQdbg4BSeHcheZui04ZPYtVI0yJoXgkxyfevEBDEX5PiN7mMZPff5H3uKciTJ3JDZ5jjyO7q8cKOtD1+yQ50FUEz0/fpDlcapGRroQPxIXDKX9dZKUwVsy/ELiywd17RGZHwhAlqpyfZ4c/4pVKCO+RvzuztAO56JU0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5365.namprd12.prod.outlook.com (2603:10b6:408:102::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Thu, 16 Sep
 2021 20:40:32 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c%5]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 20:40:32 +0000
Subject: Re: [PATCH] drm/amdkfd: SVM map to gpus check vma boundary
To: amd-gfx@lists.freedesktop.org, Philip Yang <Philip.Yang@amd.com>
References: <20210913201100.27146-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <061f931c-197f-2230-aa3d-bbf8acf8999d@amd.com>
Date: Thu, 16 Sep 2021 16:40:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210913201100.27146-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0147.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::26) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YT1PR01CA0147.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 20:40:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b35141da-d234-4829-f115-08d979523a41
X-MS-TrafficTypeDiagnostic: BN9PR12MB5365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB536522CE98ADF90CF54A53A392DC9@BN9PR12MB5365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nv87vmThmexZFgeI+l/o8F3iwbQg69upV9LGa747Lc5mLNDXRajVXVOlAIJlD2lCjGUsxZ/4T1bDyHNvAkUx+LSwAW6Cyjvqm4yPuK2X/B9QZD+i87FgICe1BYizL+exj32cxxHL2scqSXmm5Yng10CV1B/vEgvYhc7wTC7rsThozWOGG55YoCFX7TebEfej4ZP5uBmA3adZFJpHtAo63uGipGgPGH5AVgUaU7IxVAU3qsTqpTIGCkFtmZVuOo9TjlInX3HseuReaBCxyV/u2IzREPaHBdWGMwi/3EfMpaX6kSEbhPFYhkfQNp3hh5GmgOEcwvMXdNVgZQLn8JCmk+lYLobrLdVLRYkv0flUw6WEvbtChy2FgDWscjwNeNSIihGP9qTRhveMz8depYSzozAiFeN8squ1QKIG3EJV8cmqJy2rVleUyuat7z6za+rpSvpgIEilLrczGUlmVguTS8xqgA7M27k3avneCOUyulC0eLVEpS2S9E24WIXmKmocf/iIvcNL2tOx4kuCipFcmApyQDk3crbpeURhXU5i7p9KOz5z0jtPPMznLt6DAjIlPyapbaSGc2IilXxTwrQsD3V2TbklT068nF1hpTI4kOp8U9PMtSpjdjFplz74Ac99iFUvvWGIDaBbriqSyY7Oam2BPqe8FK32kAECVf3xx2USi7iWXdNyXn0QYKcoLETC61WXkOemZXlymtKvMNwgbnCIby6PFJtpD+esEZ2Fyuc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(478600001)(6862004)(83380400001)(8936002)(2906002)(6486002)(38100700002)(8676002)(37006003)(16576012)(316002)(6636002)(2616005)(956004)(36916002)(53546011)(26005)(44832011)(36756003)(86362001)(31696002)(66946007)(66476007)(31686004)(66556008)(5660300002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEp3WlBpR1djK3BmTzJUcjc3WEFoY2JZN1dXV053c3p6NnpuVksyTG9NaXNM?=
 =?utf-8?B?KzJVY21xUHVUQ05RcjhpVjNDOUZDWlJHbzczWnRqeEZFbWJ4c0ZIYUdrV3lS?=
 =?utf-8?B?YXJnOUJJUHNjaFEwVWVSV0xSMUF4TTlJTjBYSEpNejhCTUhCOFhtTVdDOGNQ?=
 =?utf-8?B?Y3lTcjkyZzlKcWxRNkJLeWFleDl2L1hiUDZkVG93Sll1VGZpZEpqUCszQm5n?=
 =?utf-8?B?V09KVjJ2TU52bzkzOVJOT2V6eVF5Qkl5STI5SXJuQVhYN00ybTMzbVlNVVhk?=
 =?utf-8?B?RCtRd3BDTDNZS05DSW1LWHd4YzFxNXNyMlV5bXdVcThKNFVEYnl2V0l6U01s?=
 =?utf-8?B?REE2Rzk3dzNaUjBBM0llazlhM0s0SWt6WVF4RUg0eWpyUW1tNWJ6THlaaG4z?=
 =?utf-8?B?emZoNDExT0VOOHNEd2JQay9CV1hlYnVPLzY0UmM1S0M1NndibHNiTm55L3lR?=
 =?utf-8?B?U2VsZm5JUGFwTFkzSHhCL3c3bWFCYTU3d3cxVytndE4zTjJCTC8vY2xXeTUr?=
 =?utf-8?B?Y1RVcXdRUmJWb0Rwa3RQWFNqZW9qdENvUHk3cTBVOFN3RnpweFFTUkx3bHVK?=
 =?utf-8?B?K2hDZGhJWVpBc0FrR1RoNERrQUdOK2xyNWNmMjJRWm9BY0RCUStJbmFSbHBn?=
 =?utf-8?B?MC85L1p3dVY1ZkhEbDdQTDgzLzNQcjl3REpFSHFtU0dJYndMRlRxdU1DOXNN?=
 =?utf-8?B?ZkFDT1R4QzlBOUI4M1BHWDJqMzdjcGNwWjU2VzdPL3pvTEdPWHdlQUtSTHR4?=
 =?utf-8?B?KzJUYVRJNWlMb3hnSkx1Y0V5bDgzeDVlbS9LYlhvdHBueTlwT3lPRnNCR0NZ?=
 =?utf-8?B?Zjdlc2xrN01Bc1NuaDBpd0hvM0owV3ZZUllQMWpuSFdGaE9OWHB1QjFJZFVQ?=
 =?utf-8?B?MmQxZDQzTHV6TFJmN3pURnVrcloxNHpVbzBrbFN1K0YxcG9wQ1YvNXAvRE5L?=
 =?utf-8?B?RlRaaklmN1lCcUQ4MVBoQ3Z1UStrWmJCSXNGNlhqNVpUd3c0aUk5WnpNMlk0?=
 =?utf-8?B?L0gwWWhLZXIrY2JTelhjYytqWS9Xamw3OHVUd2h2YXhOTEhnVnVNM3NrR00x?=
 =?utf-8?B?Y2JxckkxVlhVZ2hOdG5iVlI5dm5RRnhnTjRJTnhadm9wT25JZW5kanpBTkFj?=
 =?utf-8?B?aXVPaGZmOFkrYzlldGZnSWtZb3V4Uk15TmR3K3M1UlZlMjlackpoUXRxUDBB?=
 =?utf-8?B?RVpLOVYvbFdWb0hpNmw5bVFuV3BwdnZ0UG4yS3JGMC80NGtRUi9qSDNuQkpl?=
 =?utf-8?B?VmprNTZLd01GeUFPQkU1NlY4QzhyMjNJbzMwMVFaRnRjd2hpLzRsQUxlenE2?=
 =?utf-8?B?LzV2Q0VCdVdueW50Sy9NVGZaOFNURzArZHNiK1BLeXpkMllLc0ZPL0haYVRy?=
 =?utf-8?B?UHZrTzZlU2k0MExMSDA2UzZJbzlON2RaTjdVWHhDeGcvN2hLLy9wQTFzL2lU?=
 =?utf-8?B?YWoxQVBHSkp5a083S0dxVXViem9ieHBOUEdON0VjeHcxS2RTaCs5cGhzYWtS?=
 =?utf-8?B?UUdobnRPQUJxQVhFaTJ6MDBOcFRtVjJ5b05qdGFla05DR29UTDNjeEFFbW9t?=
 =?utf-8?B?Nk5DUzdmQmZsR1hFMk5lK3hTRGppUTIzNy80UytQS2x4Qld3UGY0UWZHY0dQ?=
 =?utf-8?B?djBQUE4vUmg5OUd5TVZPaHpGaHd5ZHNnbHFNM2JEUkorU0JQODRhczgyT2p6?=
 =?utf-8?B?MlVvY3N0bHZCd0Z1VzNtUTB6ZmdUUTVWOXlnODRmbzhGM0tEUXh1SVpJR0FS?=
 =?utf-8?Q?zODr19ZEzD3FEJn9oanKK/sJM7KIZNVNTZo+g4h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b35141da-d234-4829-f115-08d979523a41
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 20:40:32.3296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwPzbyiCUsDOWXJYPtEEi62nloTiC0+ovY5dFp2TnC2KgfXxpv9UzC8ZITL+tg3ai0lkN10LrpUb/TvQsLNUbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5365
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

On 2021-09-13 4:11 p.m., Philip Yang wrote:
> SVM range may includes multiple VMAs with different vm_flags, if prange
> page index is the last page of the VMA offset + npages, update GPU
> mapping to create GPU page table with same VMA access permission.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 110c46cd7fac..2e3ee9c46a10 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1178,7 +1178,9 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	for (i = offset; i < offset + npages; i++) {
>   		last_domain = dma_addr[i] & SVM_RANGE_VRAM_DOMAIN;
>   		dma_addr[i] &= ~SVM_RANGE_VRAM_DOMAIN;
> +
>   		if ((prange->start + i) < prange->last &&
> +		    i + 1 < offset + npages &&

I think this would be more intuitive: "i < offset + npages - 1" (meaning 
i is before the last page in the range)

Do we still need the the "(prange->start + i) < prange->last" condition 
at all now? I think it could just be replaced with "i < offset + npages 
- 1".

Regards,
   Felix


>   		    last_domain == (dma_addr[i + 1] & SVM_RANGE_VRAM_DOMAIN))
>   			continue;
>   
