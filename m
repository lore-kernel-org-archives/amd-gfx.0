Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2601CA5FF0
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 21:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DDAF10E0E6;
	Mon,  5 Oct 2026 21:05:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uxUiglBs";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012035.outbound.protection.outlook.com [52.101.48.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E08F10E0E6
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2026 21:05:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfYu3Jsm/yWPSW/T9RRiAio9L9ZjfD8Bs0FUUJa2XUEBNBaVt7iXS2LXlkppYVclUw/KSdDJV1oJP5dP3Kpjl65hqWc4cYELa493HQ3gqznNM5PKTv6s5hvto7o3SEih5t2vgOQnf/RPav2X6MRVe+CDRzTMNd7PAlgXVzEPX+8bwwaSRbDceQ9gMOjo7dkiBrMqzx3V9DoT8olL5OZUUFQFPsB9qaLLUm7indhQUgRhlLbIWV2cGK1USltaQi3iF4RvB0xaI7p45PvQKE0jv/W9g5UCOsXr1jIcEyxUuKpa74tUTE8yEw9WsX4RxjIwBnKnXi7gxn8gAyZ2CL0YMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVh3lIweBD7jqCePq8o38mb7tMtAmvaL/tfyd/iqqJY=;
 b=UrsNfsAZYRhvc7fznYsBqo/hrXuHOjHAAxR8RyvIdgSDrl9B+t2JiAPZKKWeO3hlmdWP2U66guv3EPV1EUwV8bNBiWNvP9V/0X2nlaeIcm7SUtcWIWiQKSmZAwKpzQLHLr7tvEP4LZixA0yT7lPpz5RlyqwJr4dn2pqlZdqzCRr0eEIbKie7OxUcgfUCJgIbIkp5PKPorrMg6nq2xn4dMDJqoiNuPQuB8yTezNPS9XHmKf4SviSo0JVMwIFN/kSFM3MXxcHlTkq4ZeOPUHAYUD5nvu0UazQDQyqVcRbMbJH68sgSP5XqwKs2rn8VXl1olt0FWdCEEtnH1iDjWMAGdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVh3lIweBD7jqCePq8o38mb7tMtAmvaL/tfyd/iqqJY=;
 b=uxUiglBstLs0sC5qfc4DIk/7WSk6cpxZUKFkQ6J+kxZQD9Q1NU4GxxzZsIjqjrkq6qkbpO0nAnio9xnDFC8rcVO66Ueh/csqMGtrbH+WIEriDJBje15B3DFUCuRAGP874aEe8aL9/X741xUvlZdn/Cpj0vhDAbyfSjs6HM0JZyI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by CH1PR12MB9717.namprd12.prod.outlook.com (2603:10b6:610:2b2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Mon, 5 Oct
 2026 21:05:14 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%4]) with mapi id 15.21.0472.015; Mon, 5 Oct 2026
 21:05:14 +0000
Message-ID: <c98c7828-738e-460a-8fed-9ccf4b591240@amd.com>
Date: Mon, 5 Oct 2026 16:05:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Fix svm_bo use after free in
 svm_range_clone
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com, Mukul.Joshi@amd.com
References: <20261005203247.1363226-1-Philip.Yang@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20261005203247.1363226-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:610:5a::12) To IA1PR12MB8517.namprd12.prod.outlook.com
 (2603:10b6:208:449::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8517:EE_|CH1PR12MB9717:EE_
X-MS-Office365-Filtering-Correlation-Id: 363e1664-b9b5-4b90-7009-08df2324597c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oHc/SZF1BqLCESlfRFFqo/u/JQ4P5PleAPNHlnQi6sYhO3b0WzPt5bZuo4q5ue9EsdCtSokLWoB5BSY0+tat2Rbf2MG76G7JJeeHr/MOGEpaow2f2Tg74BOSeDt4NTW67SH4SR70Bzcwbzy6Wy/SODvbizzPt3aKc+NnzCIrkr3ty8EPWdT/IC6i2wRaBLwo1Rs6PoieczSavRmzFzH5eFkgaY85AfhR70WPIJVQV0aG/COEBT+4fUTt+0FpP8gceNlghOh7IGqQ2wcqI2BeRnLDxxQWM9Y51DGzVGh/tR2d/m7KsXKX7ZkiOUQ9UgKc0YtdcvpJae5X77Yh2yB1FJkVwOdMQYucWf3yOcdgwQ++r5UnAfInioVNXD1huh6ybWdjie7AVhzs4jUnIya5chMyVShGZRrU2wyQ5/k0/hMakqxDdAzXDbRqvdG3NHkKpbAK+f+gcFkYMz9FICr2BpZg3GQTrLRGeqUYhw4OgO9US6Q85JxqHoZPCgbi6WiaBMdysTJtKc/NcVYiyF4UyewUJU+pY4VqN/TS6uvRYgFiY5If0A1QEZRq4lTtC3NpdKzC7RQk5lJxkih2a846PTh1CGJC8pdUpO4lKSMBHwIp+QfgHhlGZ0lptOYzUSkfgfbywLEgWfuQBEcL1Q7bl8+D6sY6PM61cR3cqI+zJOY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjVmMXozcGtVcXdPeXZMUUp3Rk1qclFRMUhUeTZqbUlwaUNXZEIwTVhLNjFH?=
 =?utf-8?B?dGdiSGVaTUdYVzBWVWhObVF5Zi9KRThPdktGWWQrQVQvQTNHSlVtd2hINTRl?=
 =?utf-8?B?a3hacWNqM2RtMDBNU0gwenJVTEtLNjFOT2thaXRMNTlTUmdKRWwwaDllQzdV?=
 =?utf-8?B?cGJmejVEeFZQV2JhL0hzU1VMOGN2cldBdC9ublVMRTBXMVBBKzczWXhkZXh6?=
 =?utf-8?B?RExUdGkrSkJJcXVyK25vWk43UkQ3WFVlNHlJVThjZEdHc1pLMy93ajcyWGd3?=
 =?utf-8?B?MmRZZXJhaGpnWHRPKzFuTk1MU3dLMTRmbkJsbmo2cnp4U0kyTUloeGlGRkx3?=
 =?utf-8?B?TlZwdW5qNG5ZRkJqd2RZdUtaeWJTN1JIcDJDNmpsODByLzBDcVVtYzROWndK?=
 =?utf-8?B?V1F0MG1BY2RxbVA3aEdXKzhtRU03R0dMWVJ4SWNTeElGSDB0ZHZSeEc4M3U1?=
 =?utf-8?B?S0xuYVkrWGY3QTVDV2trdmlqQTdaYi9ZRXhLeU9CYjZGZFhkcE1MTGloZjdk?=
 =?utf-8?B?MkFkcU1kNlFtVzhqbG1wYkxBc0NNRlJBQndnamdTSTRKYTJKemFTU25LalFD?=
 =?utf-8?B?YytqN2ZPNk5kbk1IbDVwaE1oTzBqaGRwd2s4T3BMR1Y2NU9mVytMTk9GbXp3?=
 =?utf-8?B?SkQxTDFCYTZ0TkM3T0pyUUloR1dFTHpvaU45bndha3BROGhZTHRUMjcwL01Q?=
 =?utf-8?B?aHpFenFORi9JbWFkLzg5cnlFcTRWZUlTcUd5T29NU3pmQnhPTHMvTzVYdito?=
 =?utf-8?B?a2k5UXhocUtXOVN2Qmw2aWdQRFpXcHVuaDlqeXQ0U3BGdmFnR1h0QjdQTUlL?=
 =?utf-8?B?aVMrT2dHV1JyaWtJU1ovc2Qza1l0R0hXUVIwek5VUi84OTVCQVo4RlhXTjAz?=
 =?utf-8?B?U1RWWjNvR0dYMCtIU0hNNEhNYXM5N24xSk1lUy8yNVlrSlJoWTJJT3dlbVls?=
 =?utf-8?B?dmZpZ3E0RUtmMU14MjRQeER4SVdQZ0pqZ1k4MUxLdXY3YUF2MEphQzROVmRF?=
 =?utf-8?B?VXEvcGNXeGl4RGk1S1FHamFxT2hTRVVucm0zTEg0S1dVdTgyL2VoZXRwbC91?=
 =?utf-8?B?cjhiVWRjTUwxakR0S2Fpb3Z4dE1rRHVtbk9JejE5UmR1SXQrbC9HOHdCSGlu?=
 =?utf-8?B?MkJCcXB3UGlQKytqR3ZRL0pmQnZEcCtYNnkrWXJ0SVdnTk0rWFBtK0tQQWxK?=
 =?utf-8?B?WFk4STQ4aTZwVHVIWmpPbjJBRXpyUTl4aXN0Wkt2RHgyeGxwU3kzOUtpcHBz?=
 =?utf-8?B?NHZzS3NoMVhNd2ZCWEYrVDJZZ1NQeHpQcHJuSTdFR2c2OHViYk9iNHl4a296?=
 =?utf-8?B?NFRhZ0JjZS9VMHoxUUllTFhWYmVLN0F0MmdRVWxxOGEwWUliRUpMb3QwYWZ2?=
 =?utf-8?B?cks2Z2k3NkpRZ05BT2kwQnRzYmR6NzFGaExYelVid0hNcWo4N29YcmZvOXVp?=
 =?utf-8?B?dGU1ZldFcXBXbnhMNENIVGx6bno0c1duWmFJdnd3U3ZaUmJOc3NhTHlnNFJ6?=
 =?utf-8?B?SDA5QXBxV3BqWFNydUx3QlN5MW9WaGhTQitkOE45QVEvS1lJMzVYbUNuM3ZB?=
 =?utf-8?B?YzBCaUJ2akhzZWhSTWFCdUsxSVFveDNjNEtSVkNsWGZwMlA3ODBDSzQ0ZVcw?=
 =?utf-8?B?dUpOZU9OSTlJcEYyaXU1Ty93QXVMTEUrWlB1UmhUZmxBc0VoUEVya2NFRHds?=
 =?utf-8?B?Y1JPTjFnK21BaFEwZUI2STBGS3p3WTR3eTYreURCREtjUmlCZmNiM1BXWnJD?=
 =?utf-8?B?NDBmYjdTZW5qSmpsdnRWRUd1UzVoaFB6Snp1WjIxZDBnNmszNXBhTExlQ2gy?=
 =?utf-8?B?cHMrQkpTOHd0dWpDaW9BZkQvOUM4UjUwNXBxVWM5bEo0clAwbVl3ZmZMNmYv?=
 =?utf-8?B?eXdXUmwzRmYwb0VkUUhqWjdYOEdaYmF3eG0vN3JzdTJSL2ZQQVZGcTBDSUI4?=
 =?utf-8?B?TVBpc05aVjFNWGtZbmJyTHk1SHpyT2d1bll4QjVXSElXam0wQXBOZnZlRHdx?=
 =?utf-8?B?cDhpMGdNMmhTVEtUOVhFS2htNFEvY1VPQ2xhSjBTbm5PQVZJWDR1djN5TXRE?=
 =?utf-8?B?aW13M25rdW5rUzFYcTYyelR4Vi95cDh2dU5xcUMxNGJub3Z1UGZKNGUxYUYx?=
 =?utf-8?B?Z2RFWTF0djlTOVVPNFNFdzBtYVRxNGtwUC9wbFNkQzErU1VzNnhWVlhTbVRG?=
 =?utf-8?B?eXplMmZrTk01ajlnU3Y1RG5BOG9SRUpzZWFHOExyYko3dmRsUzBnV2JJN1ZM?=
 =?utf-8?B?TzBXQi8wVEJNdEducXgrV2FHb2hDbUJSMitOSExHSEdicFlqa05pcG94bzRK?=
 =?utf-8?Q?VRr6zXBOomf+uOS8U3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 363e1664-b9b5-4b90-7009-08df2324597c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 21:05:13.9170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pi62ByWX2mgdgKxWsALCKqTT396WLP5m+HaK7RYFZHGCJGg7WzOxbVl3jh+h+Alq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9717
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


On 10/5/2026 3:32 PM, Philip Yang wrote:
> prange->svm_bo stays set after the range drops its reference in
> svm_range_vram_node_free(), it is only cleared later by
> svm_range_bo_release(). Taking a new reference based on old->svm_bo can
> therefore hit a svm_bo with refcount 0 and svm_range_bo_release_async()
> pending, leaving the clone with a freed svm_bo.
>
> Use svm_bo_ref_unless_zero() under old->lock to only share the svm_bo if
> it is still alive, same as svm_range_validate_svm_bo() does.
>
> v2: use svm_bo_ref_unless_zero instead of checking old->ttm_res, to keep
>      sharing the svm_bo when the range dropped its own reference (Felix).
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index cfb428c72686..7ffc31df3b87 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2158,14 +2158,19 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>   		svm_range_free(new, false);
>   		return NULL;
>   	}
> -	if (old->svm_bo) {
> +
> +	/* old->lock keeps old->svm_bo alive while taking the reference */

How old->lock can keep old->svm_bo alive? This lock protects old 
prange's data from accessing.

Regards

Xiaogang

> +	mutex_lock(&old->lock);
> +	if (svm_bo_ref_unless_zero(old->svm_bo)) {
>   		new->ttm_res = old->ttm_res;
>   		new->offset = old->offset;
> -		new->svm_bo = svm_range_bo_ref(old->svm_bo);
> +		new->svm_bo = old->svm_bo;
>   		spin_lock(&new->svm_bo->list_lock);
>   		list_add(&new->svm_bo_list, &new->svm_bo->range_list);
>   		spin_unlock(&new->svm_bo->list_lock);
>   	}
> +	mutex_unlock(&old->lock);
> +
>   	new->flags = old->flags;
>   	new->preferred_loc = old->preferred_loc;
>   	new->prefetch_loc = old->prefetch_loc;
