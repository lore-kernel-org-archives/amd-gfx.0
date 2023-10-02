Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C897E7490C
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 19:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCB8510E1A0;
	Mon,  2 Oct 2023 19:27:45 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57C5110E1A0
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 19:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALs9P7sRLtXAX0kAqQbntZPV2HKD0YJt0bL6dvm1QVPFoHwcpwkpJw5YvTyVYO/h1ulvQeHlW0RyCaTJlDxqPQvdbR1dJPvA0iAPsUK68SsJdqHKVydTJbZyQ4ITgbx13TDO/yi0BEG7PrJ6zm/GqmZJhqHWZfti+FVG/ktubbENDTjxfEk3Vj6QrlOS6+GN2pZ+h44J06nC2aZN1RfsxkBZi4gCQLnPP757chKZiRCkhG5h64i/+XsZ9m20q52tzrgrJAhK9sDbe14yexyQVTH4OaNakX/es1ZyF3tulCDlV2LD4nS1RrQRqf9OHjfdbqBeMf9T2LwyhoZoZD3y9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWst3jhdyR53Vux7uSCE7hEDp2vBMwm3sCpq2Mm6hUs=;
 b=ekE1cXeYnX3wyLUCEZqb54Ah9XwjImPymLt8g/CLFI8F5x9hW9ZiSCA5wX+RqZH1Hmtndr3QuGpAG6yUVemLLx5TP+ZGNoUnyfr7x/7s8Xmx+UtzbGcBGdHATPSbAKVDm33IwZ8AKErtNaOWvQjr7uVV9W3OMxJgCre/p/2teqvMshzmvrv+Wx9U8IFrLZ+YMAH4ZAQtDyVcNdmGOKnYrAUmH+XyZAbRksRRMSbFJ4E6KoS17kvMwQ1GkBfpqoLga22zafoqrJ7gFPHZrNdkiPpOgymtsc/Rx8VUTKtIXw0BqC0wOSnJJHdjTI7VpxDCEvGcnguHDJxEImD9Nq0Cyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWst3jhdyR53Vux7uSCE7hEDp2vBMwm3sCpq2Mm6hUs=;
 b=Q+Qwtxgurz/HPFY2DfMSpo7Uqc0Qal9K3JaPQKwNlpLqS36C87gmX0pEb8lwnaZTMI+vTwsDwgGoxeIwxb0UPktXj8WX4miYn9UyQqfyYY7/OCECLivT33hEGnxTJD1ywm4A2/2f2dn4k+FwNHMdf7fScBujg1+NBatfdVxgTbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Mon, 2 Oct
 2023 19:27:38 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6838.029; Mon, 2 Oct 2023
 19:27:37 +0000
Content-Type: multipart/alternative;
 boundary="------------FEqx4sobcUDb70V2gEyGElLG"
Message-ID: <3c56e437-b901-4d93-a3bb-1b788d1aba18@amd.com>
Date: Mon, 2 Oct 2023 15:27:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] amd/amdkfd: Unmap range from GPUs based on granularity
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230929141115.10016-1-Philip.Yang@amd.com>
 <20230929141115.10016-2-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230929141115.10016-2-Philip.Yang@amd.com>
X-ClientProxiedBy: YQBPR01CA0159.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: f037c045-d896-4652-8c5c-08dbc37da2ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QeALCPfR+Z56pCQtRiDqlwuv2nUiVoFkfDHyQOubGWKqWA9mUIY0CwMP+59gyvuoDKdrLK2wsl6s524c8TU7mkivB8D3EEXtdD2e9cn+lO7hiFkny+l6kkgJO1F0z2NKkOVKOb+boTBX1NoSdYst/k1gAKGi6Y4jxp7FuiafwnB7Ys/yCWVxzSJQavHBPTyrJdBcJddyNF/WYlk2LujA+zSrEZVbQPK2NvWuYNoLrF8ebuRDbfMnA7PPQWSS4SLsPIvOuqNU1stE+VzwPjq3yduj42JJY/r8+33M/WAHHaqlbo/JG7iot1NwbXopzSl3p/XyB44velYGrX5GliZs0TMxSLXk16XVueI4xa8g88PQ/eLUzUbU0TmGWVIYq/WEA2HuP/7IUd2Kd0Axh8jmTrjUUjTgKOHV4v5xbHKJJYA2vVIgJnbip7TXFml4oN2l28rRZ/udGLqXTAzmMZilLAXwpv6a1rsBjX7IopUmd2OQKMebuVh/O+IUPuIGFYAWrFAdfP3EAb5sQ/2jM9e9MO6kBZlmjswj8HaJ88sIK8o1U5eec5d01dM/VtJkdNF8LDWmnmWG7zMRtfNwG5UCrSD0l69CFSHHiUdGMYsQ27Yptj+J+XgbowcNZH4ERMW84X2iSoqW+5xTTSp2EpCmUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(53546011)(6512007)(2616005)(6486002)(6506007)(33964004)(8676002)(6666004)(316002)(66946007)(26005)(5660300002)(44832011)(66556008)(41300700001)(8936002)(66476007)(83380400001)(86362001)(31696002)(2906002)(38100700002)(36756003)(478600001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFZjblRQVlkwcXZoZ2dxYlZmdWZzcmc4Z2t5b211R2h6c2dQU0ZWZ0VaVG9R?=
 =?utf-8?B?cTZjc3daZ2ZubjdxalFPc2V3KzlneC9wQTlKRjRWbnZYaXR3ZzBFWjcwM2ZY?=
 =?utf-8?B?bnQrL21jSmdObXUzcUc0SUhsSXBMOUtiL3RreUUrWDlrQzRlRWVUS2lMQlA1?=
 =?utf-8?B?SXBGbmhaei83Tzl1TGdFdW5SZG9JczF3RTVkMFd1UGR0T0ovbVAyaEs2bFlU?=
 =?utf-8?B?TFhKY3k5WUkwV2VDSkVzNm9jNE5QMy9yNVhFQ0FDMHo2VlZwaTFZN0RGRmxq?=
 =?utf-8?B?L1RaR05XV0hEOC9kMkxDeFh1TGdrS2lqQmhzRVZtcnIzL2RGRmJrWkZ0Nmc0?=
 =?utf-8?B?WE5WWW1EZUcvbEorRFVCeHdzTUpIWjUrbDJVM3hremdITmNjczNrZWFwSG4x?=
 =?utf-8?B?QjU4L08xRzd4QTl0RzF2ZUdnd09nLzhTdERmcTV3dWJhZ2VmNHMzQVZQTnRM?=
 =?utf-8?B?bVRzQ0M0Q1lZV2pqNHpKSSs2N0JLNnV2QTZuazJoaDdLaVBNQVZkOEFQUzI3?=
 =?utf-8?B?RTJBZGMwUUZlWkRTN3cxelNLNFFnSktqTTBnckxCUUhmcnJNMkYrVUh2aWhh?=
 =?utf-8?B?ODBhWFFndUFNdmNPcS9ka3FHbTlUcVluUXF0UjR4Z05GaDc3RjRKTnUrK3Bt?=
 =?utf-8?B?ZGFkWExMSHFBWTRDdVJ2Q05nTXR3UmE0VGV3bzBwS2QxdzdOVmtGKzRlZnM1?=
 =?utf-8?B?bEgwWStBcFN0aTFHUTlSSHJlRmlNK3pia2V6UEs5N0crN3J4TG5NdmxTR3hl?=
 =?utf-8?B?L1BMZnBuSThLVXlzczhJNXRYK1dIMDVNN3p6S2hORHVhT0IvQ09QVEZ4N2Rr?=
 =?utf-8?B?SEE0Z2VVYjlCanpVUWppUjY4T3p4ZXpEbzZTcEhsUGM5UlF5dWx3S2oyOXdy?=
 =?utf-8?B?Z29pWmdHRlBJb0FlaG9yVFVIYlRieFpsZEY0aUU5UmpwZ09HakpXR3liZlhY?=
 =?utf-8?B?VmMvYTZVeWxtMGh4RmJhNVhNQU1zQUxUNnhHd1pMejJFZ3ZZemNlaXVVQkd4?=
 =?utf-8?B?eGEvdFNSbkxmbzh3K1FYYXF4M0ZqNFJMb01Xanl5QTYydWtpUEgxdHlvY1JJ?=
 =?utf-8?B?UUNxNVJiNTFoc1krMzg0QUM3ZlUyTVlRLzFWTlRVcVV4N2xkRUdOdzhMeDcr?=
 =?utf-8?B?Rjk5SkUvK1hXNmkycjRwMHozN0MvS2Vsa3FZVGVZZHFsVURnQkhLanh3Ukgw?=
 =?utf-8?B?TzZ6Tm1mSmtCYURJekFxbjB3Y2RBaVppZklhQUpWcUZFUmVWN3FuT1VXbzhv?=
 =?utf-8?B?M0pNQ1lwTmFnaklOVlR2RHVzaUlVUVFzVnJHTmpJT1d4bmRKL3luOTBkeHhi?=
 =?utf-8?B?djZ2a2psNEoyc3JkbVpSS3lDZWRwQXJiYU1ub255U3pVSy9JaVRLcm9IM2x3?=
 =?utf-8?B?TWVMemRmQU9hbE5reHNHYjVkUUYwWUFpNEVSY0Fsa0RxTE5nUWdiTjZVa094?=
 =?utf-8?B?TEQ4MXAxbi9IMVc0bWMrRjhjK3RjRXN0Sk95MnozKzBxQU5jSUorbng5a05i?=
 =?utf-8?B?U2gwREx4MXMyR1RnYkJFWC9CTWVTaUNzSk5ZZ3J3eU8vWm9wU2lJSGl1d2ph?=
 =?utf-8?B?ZTVmOUtKeXgrZUdVYzZ4d3dYYjFCOHNEZmZFRXhiVlJ1YjgxT0E0OHFheTNC?=
 =?utf-8?B?L0lqbFRTZHNzbCs4aWUwWnFQaFJnd0NoTGhzeXIwV0NBSGMxeXVhdzRoTUNQ?=
 =?utf-8?B?TkFBNVBMckNlTmhsSHdzeDFPWHdqMlh5YnJYdUYxZVJDaTBmU2hSTDFXUHpJ?=
 =?utf-8?B?TWpzd1J1Ky8rR0g4OXVVcEV4SnhEOVZBdTVGSEFvY1ZUMVk2RUR4US9iUEkz?=
 =?utf-8?B?MTRNdjViOTI3VGR5d3B5MUhteVQrNERPSXJlc21FU2d6WEdsYkRQWnl2SGhJ?=
 =?utf-8?B?RFphZ1EvSlhlaEhXWEl4WmY2UmQ3UU1NZFlhVkNJVTRCWHgwTnU1dmpEeDQv?=
 =?utf-8?B?K1g4ekkrMlE1QzBiZ0xHdEFhelVGc2NjZ3FXaXFwaWpBd0dxSEhsTWh0aW5u?=
 =?utf-8?B?MEZINWhpVm5maE5jN1E0ai84MENPdkVzeDd3OVB1SUc4K0g3OUIyNjI3bDUw?=
 =?utf-8?B?TjRtOUM2bWNNbmtKNGN1S2RzYlp6RU54T1BQYlZubWF0VkZMTWorREU5ZzEy?=
 =?utf-8?Q?z14wQtESyie2mrWw91ChPFxRJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f037c045-d896-4652-8c5c-08dbc37da2ed
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 19:27:37.6434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kX6zNuTSIid5qId6WewFfDmM0xQp6jEVwXdGD4MXwvg0+Q7uMX8NDQ4LcZGpbiExBqdqt0NzcvqTkUlajrqXbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690
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

--------------FEqx4sobcUDb70V2gEyGElLG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023-09-29 10:11, Philip Yang wrote:
> Align unmap range start and last address to granularity boundary.
> Skip unmap if range is already unmapped from GPUs.

This only handles unmap due to MMU notifiers with XNACK on. What about 
svm_range_unmap_from_cpu?

Regards,
   Felix


>
> This also solve the rocgdb CWSR migration related issue.
>
> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 35 ++++++++++++++++++++++++----
>   1 file changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 626e0dd4ec79..ac65bf25c685 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2004,6 +2004,26 @@ static void svm_range_restore_work(struct work_struct *work)
>   	mmput(mm);
>   }
>   
> +static unsigned long
> +svm_range_align_start(struct svm_range *prange, unsigned long start)
> +{
> +	unsigned long start_align;
> +
> +	start_align = ALIGN_DOWN(start, 1UL << prange->granularity);
> +	start_align = max_t(unsigned long, start_align, prange->start);
> +	return start_align;
> +}
> +
> +static unsigned long
> +svm_range_align_last(struct svm_range *prange, unsigned long last)
> +{
> +	unsigned long last_align;
> +
> +	last_align = ALIGN(last, 1UL << prange->granularity) - 1;

I think this should be

	last_align = ALIGN(last + 1, 1UL << prange->granularity) - 1;

Otherwise you're off by one granule when (last & (1UL << 
prange->granularity)) == 0.


> +	last_align = min_t(unsigned long, last_align, prange->last);
> +	return last_align;
> +}
> +
>   /**
>    * svm_range_evict - evict svm range
>    * @prange: svm range structure
> @@ -2078,6 +2098,12 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>   		unsigned long s, l;
>   		uint32_t trigger;
>   
> +		if (!svm_range_partial_mapped(prange, start, last)) {
> +			pr_debug("svms 0x%p [0x%lx 0x%lx] unmapped already\n",
> +				prange->svms, start, last);
> +			return 0;
> +		}
> +
>   		if (event == MMU_NOTIFY_MIGRATE)
>   			trigger = KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY_MIGRATE;
>   		else
> @@ -2085,16 +2111,17 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>   
>   		pr_debug("invalidate unmap svms 0x%p [0x%lx 0x%lx] from GPUs\n",
>   			 prange->svms, start, last);
> +
>   		list_for_each_entry(pchild, &prange->child_list, child_list) {
>   			mutex_lock_nested(&pchild->lock, 1);
> -			s = max(start, pchild->start);
> -			l = min(last, pchild->last);
> +			s = svm_range_align_start(pchild, start);
> +			l = svm_range_align_last(pchild, last);
>   			if (l >= s)
>   				svm_range_unmap_from_gpus(pchild, s, l, trigger);
>   			mutex_unlock(&pchild->lock);
>   		}
> -		s = max(start, prange->start);
> -		l = min(last, prange->last);
> +		s = svm_range_align_start(prange, start);
> +		l = svm_range_align_last(prange, last);
>   		if (l >= s)
>   			svm_range_unmap_from_gpus(prange, s, l, trigger);
>   	}
--------------FEqx4sobcUDb70V2gEyGElLG
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2023-09-29 10:11, Philip Yang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20230929141115.10016-2-Philip.Yang@amd.com">
      <pre class="moz-quote-pre" wrap="">Align unmap range start and last address to granularity boundary.
Skip unmap if range is already unmapped from GPUs.</pre>
    </blockquote>
    <p>This only handles unmap due to MMU notifiers with XNACK on. What
      about svm_range_unmap_from_cpu?<br>
    </p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20230929141115.10016-2-Philip.Yang@amd.com">
      <pre class="moz-quote-pre" wrap="">

This also solve the rocgdb CWSR migration related issue.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 35 ++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 626e0dd4ec79..ac65bf25c685 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2004,6 +2004,26 @@ static void svm_range_restore_work(struct work_struct *work)
 	mmput(mm);
 }
 
+static unsigned long
+svm_range_align_start(struct svm_range *prange, unsigned long start)
+{
+	unsigned long start_align;
+
+	start_align = ALIGN_DOWN(start, 1UL &lt;&lt; prange-&gt;granularity);
+	start_align = max_t(unsigned long, start_align, prange-&gt;start);
+	return start_align;
+}
+
+static unsigned long
+svm_range_align_last(struct svm_range *prange, unsigned long last)
+{
+	unsigned long last_align;
+
+	last_align = ALIGN(last, 1UL &lt;&lt; prange-&gt;granularity) - 1;</pre>
    </blockquote>
    <p>I think this should be</p>
    <pre>	last_align = ALIGN(last + 1, 1UL &lt;&lt; prange-&gt;granularity) - 1;
</pre>
    <p>Otherwise you're off by one granule when (last &amp; (1UL
      &lt;&lt; prange-&gt;granularity)) == 0.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20230929141115.10016-2-Philip.Yang@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	last_align = min_t(unsigned long, last_align, prange-&gt;last);
+	return last_align;
+}
+
 /**
  * svm_range_evict - evict svm range
  * @prange: svm range structure
@@ -2078,6 +2098,12 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 		unsigned long s, l;
 		uint32_t trigger;
 
+		if (!svm_range_partial_mapped(prange, start, last)) {
+			pr_debug(&quot;svms 0x%p [0x%lx 0x%lx] unmapped already\n&quot;,
+				prange-&gt;svms, start, last);
+			return 0;
+		}
+
 		if (event == MMU_NOTIFY_MIGRATE)
 			trigger = KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY_MIGRATE;
 		else
@@ -2085,16 +2111,17 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 
 		pr_debug(&quot;invalidate unmap svms 0x%p [0x%lx 0x%lx] from GPUs\n&quot;,
 			 prange-&gt;svms, start, last);
+
 		list_for_each_entry(pchild, &amp;prange-&gt;child_list, child_list) {
 			mutex_lock_nested(&amp;pchild-&gt;lock, 1);
-			s = max(start, pchild-&gt;start);
-			l = min(last, pchild-&gt;last);
+			s = svm_range_align_start(pchild, start);
+			l = svm_range_align_last(pchild, last);
 			if (l &gt;= s)
 				svm_range_unmap_from_gpus(pchild, s, l, trigger);
 			mutex_unlock(&amp;pchild-&gt;lock);
 		}
-		s = max(start, prange-&gt;start);
-		l = min(last, prange-&gt;last);
+		s = svm_range_align_start(prange, start);
+		l = svm_range_align_last(prange, last);
 		if (l &gt;= s)
 			svm_range_unmap_from_gpus(prange, s, l, trigger);
 	}
</pre>
    </blockquote>
  </body>
</html>

--------------FEqx4sobcUDb70V2gEyGElLG--
