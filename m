Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920C1CA5FF5
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 20:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B27F10E28B;
	Mon,  5 Oct 2026 20:57:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rh3G1Z7F";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010038.outbound.protection.outlook.com
 [52.101.193.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1EFB10E28B
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2026 20:57:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZedux5Vh4koNv0bVjgvhGzoZuIjmKsZuACwTmGQr35BSy2Pt4w1Ldp6VyvmWF415aXB9Gm4oqVsUwJ1f3x5TgxLn+tuJc7cF2ANHuqp0TkOS+lxvPhFlXtsylkQ+zhzLtvmMXcp83bx+WDxHFL6Xig4zIoVYy8s20s0rmhYIEDWE73nqCY51MLSICo1CxDPhRRqnSMHfeAcNUXGmix5iRvDLv+xp8AiPwSfdBXlSCZ7OSKnaZ2ls43XaU1n1X43RFDssOQKBGZVu+MZcVjLSgfA6DSnkIZNoHMPUhxFsMObE06++hNLl6DQWlA+3lzO4YX+FzfN61DUsNn6Y1c3yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBS0aGPOX5VWaPzEnss3l1k+FR6pzp8Lbqf73eiZFlg=;
 b=wkNK3arIdPfw5VMLOI+QUi49Js9slNTCAk04SovJ++BZ6sEQMnYVDwCaaB2AZGZ/zSEoZ/2JY966kpPHyp6EgfnA5UD2QErdBgqGnYbIWxyDxW4xsemSqKIItofIVVeQwFKZ6DNpgULlt1NhWyIhibkks4rbLUP5hGxfXLTbip4ZOR2VDxR848Mw978AeedWnD08dnzuFysQvyw6zwXtua4I+sM09FTB+iLjuMbS5h81jqJWIIBCDhi8tOCvhaHX4o/7xDqOGMq337J1x5pmkm4TQ82352Z9Bc10EVigiZ6x2Z1ktbU6FP2YEdn/rxh0JFCBIL7Q7/MFdkTvRYL+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBS0aGPOX5VWaPzEnss3l1k+FR6pzp8Lbqf73eiZFlg=;
 b=rh3G1Z7FP/7thf6A4npoW98jBXuA37wm2zEU8bqQBTryuKwYnlE4PJ8utdEkzIith511Nzdjz1+MG4CMdV0hDIu09kKoxY/Xb8u7eSdCJe1MTSi+iR+g5HjpjPkMDJbKFkWYnDQgTVQmcxCES66xpm1peWpGAu0O8pnOIpvkQ9o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by PH7PR12MB6633.namprd12.prod.outlook.com
 (2603:10b6:510:1ff::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 5 Oct
 2026 20:57:37 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 20:57:36 +0000
Message-ID: <16bb0bc3-b714-4192-ae6c-c20912328600@amd.com>
Date: Mon, 5 Oct 2026 16:57:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Fix svm_bo use after free in
 svm_range_clone
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Harish.Kasiviswanathan@amd.com, Mukul.Joshi@amd.com
References: <20261005203247.1363226-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261005203247.1363226-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0484.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::7) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|PH7PR12MB6633:EE_
X-MS-Office365-Filtering-Correlation-Id: 73300af8-d9f9-452d-4af4-08df232348f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: AY1bI3SjR7VMqtE9X15dPGMep1KCNLAYoqD5VZpZiGCfcd08RDdCLAbRWCOU5nqU0s4wUwoVySjaFPuXDMd9kZV2wyknd7+0kpVizUeR+uZAGCS08ODgcqmCzGm1UV0wnTg9rZp+NVz06JZgT5b5/38fKdBtdsTL2HD1Lt4k750hstnRg8S9ehUvxzz99WxzW05wyou17NTjP9oBjSuPrM++4YfEXmhxwXzNunXxsZc1nTC+Omp25C7nOi54ZaYEln9O1KTrWEM9CYjzC5OiX99TKzXDGUaukbflGzRgGYyeWtDmN0OlPHrdTrtdLDlrwh6wc1ht3ZUKSu14Z0aGSUZhoVLFNAKtw3hTrPZnmRIZCp1NyVspKn1rNci0O8M+LBMJ8ao8zhICWPvtjtVRKoeKWyKoyUrJYMzIPqj3cplUe92uPVRijxMxqy7KZba1L3RBkkz7qMbSvh9H9R35fSJVilB2dCEHcApW0UTMxdsOLhpRyVPT8jIWqdL2zbYLBFuhpCE9FpmDyki9t4O6RuPektrYy0vX5Ymc0pYMUASo1pZc/dVM25V1aD1NjHaj9FWLlXl7LR3F5E4qR6mFSt9FTGlFSkgOh6TSzDJDg56ayID5mXwm4m1hvXVEJtbJgRXJoK3iFDbL0oiaEXa8wQ9cC7NrEN57UnJZ0bRlf48=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0JQK2tJdWFtSGZjQWdwS1lmSksxQlNSK0pOVC9IanN6MGgzT2hlYmZwdFJa?=
 =?utf-8?B?RUwvb2o1NkFUMG0xd0pKaUZsaDFKa0JrQjVOazFNVk1TZy9oL01HNHgzUjVQ?=
 =?utf-8?B?OHlXQ1AzaUVFSWhRVHpYMFM1dm9uR3FtQzZ6SUF6Vll6clY4VnROQk1TbWV5?=
 =?utf-8?B?VENHN3l6RlZ5S0duVmtrbXhYeEozMG9uam51TkFaTFBDNk1tTGZPQUZQSVp4?=
 =?utf-8?B?dWx4dUNxVUpUNkhRL2FEdzJyWUc2cHUwUGJGbFl1Q2FJaEo1M1Z4b3hxTlRy?=
 =?utf-8?B?QXJKQk9DalN3NWVMdFY4REZ3ZDFBU1BGdS9FeUppMmFKVEhHZjhOajV0YSsw?=
 =?utf-8?B?c3hHQWhOb1J1NUVnMlRRYWxMdUJxV2NrTHFHTkdQL3V5TGdBV3hhZWVwZEgw?=
 =?utf-8?B?T2FjcTJOS0k0U3p0NjVQOTY4TERDbTdZaTRsNWJtLy9IeHAyUzZNc3FESndi?=
 =?utf-8?B?T2JETjlOVCtXUEdaOGJNeUljQndRMVdjQTBOUWVCOWFyLzB1UzI5c1drNiti?=
 =?utf-8?B?QkIxMXBuclNpWURObmFhcXEySFhmNFBQT2NOOFFmdVBZRkRjNDhURG4zcE9a?=
 =?utf-8?B?M3ZXNjBmdUxrWHNrOXJTaHdYOTNGL3pCRVhzS1cxdW9CZ2FHTnlMN05RNFJq?=
 =?utf-8?B?dDNzL0xMYTVzL0FPcmFtRm1OZmwrNGYyK29HOEpjMjNPTHliWUR0U01Mcmpj?=
 =?utf-8?B?SjhzL2VKSytjMk84dE9NcSszUGZ5QklCSVlyV1ZDaWpxbFNDcmUrWSs1dkZD?=
 =?utf-8?B?b256QmwzL1MxVUZoYkh0cmVPYVZ2MjdSaUk3RGpQbk51Vmo2ZEllY1ppVkQv?=
 =?utf-8?B?QlVlUC9vbW5uSEhZWi9Ha0pmZm0rWDJGTVE2VFJoYnJ2U1NETVZ1QW0vWFU2?=
 =?utf-8?B?Z0JxY2ZaVnVxVHpvN3ltVjU1bmc2dnVoWCtkK1VMbXZ6U3NLdGhyRG5DQ05F?=
 =?utf-8?B?ZzQ3VW56dkRGNGhWcm5Hd2hvOGtQSUhCMjg5bENSQmRwTmhQZGd6eUgrUnQ4?=
 =?utf-8?B?Wjd0VVFQV1NKODdVaHRSVFZoR0FRUHQyNTFhTzNSQS83YU5HQ3Ezck9qS0U4?=
 =?utf-8?B?NUNQdTZnbklEQnlyK1pHYjBFaUgxZ2U1aUM5UmdhNHhaTGxXTzY3VU0rMFJW?=
 =?utf-8?B?b3R3SU5xRlBRUFJLVXJSTmxpN015b1JFSXBXQnFwTDkzTDRFMjlFOERpTDRr?=
 =?utf-8?B?aGNuYXJQY1FaMmh0RncyWnA0R0QvUU14SnlJMTMrRVlEVlBRZ2NpODg1Tlcv?=
 =?utf-8?B?b01zZCt6d1hla01YMmUwT2lBSS9WYXdtM2JTcGZkaHlaSS9vcWhNamVQdkJT?=
 =?utf-8?B?Y1dnK2QzaVNTL0IrMy9GNHJISzIyRFA4NXJLMjJ0bzhDcGdpNFE5dUVqOTdP?=
 =?utf-8?B?djhNWkczVnFwbTVOcFY1MlRQRHpmeVdnOXlpbDl4dWRaZ2MwNk5LR2ZjWFVT?=
 =?utf-8?B?MSs4YmpqSGd4ZFNrbTNiUU5HbldicncydXpJVlNVSERxUGh0elpzNjNQL1Bm?=
 =?utf-8?B?dDJHSGNjMjNDVWdsOE5JRzJiWWI4dWhqMG5PbjVjc2hydnBMajV3OWtFR1l6?=
 =?utf-8?B?NE1LMHZOYlVFZDhmVHpQSXQ0YSttUlhmYW1vWjRuNEg2M05ROGxyYnJsMThY?=
 =?utf-8?B?OE5zMHBoUzdOZ1ZjUUVZMVRmaFEvOGhPdUg5WlJWR3ExWG5PNHdOMk05c01h?=
 =?utf-8?B?TWc3VmxUdDZnRHBTMjBmOXF4bXh6R3l0cnlPTjFpUTlLTk1ZOGZadks0WWdu?=
 =?utf-8?B?N055ZjVUeEx3UCs4eE90MlhPZm9IcjdhZm5PWVh4MjNqMy9xQ3NJTXF4UEVR?=
 =?utf-8?B?Wk5RVktwMVlQWWpDWS90eHdCbDE5bklOZUZLMjVKeEpnb3dYa0hlbFRTNGx2?=
 =?utf-8?B?bXZHWm95aXhDbTViZjNTRXpKMXRMZTJFUE53eWJjTmt1WFdxY3lXa3hDVmt6?=
 =?utf-8?B?S3EvWFpJTmR4Sk56ZEl0SnhLNTJYcG4xMnhDdDFYTklkZmxkL0RXcGI0aGd6?=
 =?utf-8?B?V2h4a3RuZkpQZGNLcXdQdXRlNlQwMTJSZ1VESEhLSGFFUGkxblJYRUpyUHJZ?=
 =?utf-8?B?LzdQV2FYQ09NZ3JwVTdNNHhZOTY4aythQ0c0dG5JNVN5NGhUQnVDQUoxMmJK?=
 =?utf-8?B?eFdyN05paVBoMWhQd2hzemlvRkczVnpjakdwcEdlWE0ySGZFNi9UWUk3ZFVY?=
 =?utf-8?B?WmU1OVE2cElNdUtSQmw5VE11S08rL3NWZnVBSnJTOEwyZCs3YVpYUkJnRjg0?=
 =?utf-8?B?ZlRpSXVUQWRKUktYalNvcWlWc1IzdlVacHNNR3pXWVVQUjAvaW5yb0lpMkcv?=
 =?utf-8?B?dlBENTV3VXQwb2oxSVdkWDhiQkNpeGZVcnRhS2hjYzBiaC84RE9kQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73300af8-d9f9-452d-4af4-08df232348f2
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 20:57:36.5713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHu0cuTSAaIHRlwxLaOcGjttGc1cD364/6HGs2E8vT9xOjyylJmjIaBNvLchdY1FbKlyk4kbdBKCmPenXAYbyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6633
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

On 2026-10-05 16:32, Philip Yang wrote:
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

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


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
