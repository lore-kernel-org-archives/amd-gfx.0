Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66071C25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 20:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC33E10E0C0;
	Fri, 10 May 2024 20:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mn4dxAKL";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11BFE10E0C0
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 20:57:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=miSZtxz1Gh5dxmCXZxONMhxuR8FsnuZBrSEW+D1XBGdi733AC4yHgflbiyuNQA7yR0Zw39HIkYY7ao2XKh5DqYzUTs7e6X/3bwVhkjxnrKpiO3t9UnR8J+pQ8K0b67WJkxDfeCl1gw8WUWpelIOwwul6XiAdtNVDHymMlTu7ADez/vKX+TqGfXdSFZiKm1tgTPGZ4laGuGs5p7Ecfq+2PKMzjgSwCnkWgQAFCT1eHZV30KjxGzXw9W+Dn/ykpGpaOk4MW3WCHR1fwCJVX/56beppS7me7XRpdWMf63iRXIjAduuFsWIYgv74C+6ePrhj2VHpcIPyC02YL6/VkH4Zsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c44470g1zYSxyLsKgdskMeHt3hmOwIE1v6QhNO7FRJo=;
 b=DdM1jBawQMI2/B7dBw9S0iHoBA8BOPzXi+Vv1/C78ZIicYEl0kAbCQteuj6qp30UN4BQiBr7Y1E+abXZA7pRK/bDPhpa4pAeAxfmUuz+7g6VUpBVAlLYQWIhCMGmGn3Sv3IJ7LQlW83w4/FcH9Taik6FlmDWCm4tDDArNnUp2uE6jsF+Hp/GGEdwYtVBuPXTkbPitsIqtFuLZTjI4A6Vn3+1nZohN/JY3vuviauRtuTnPfU6t64FBgRctVOniSYNwVPz0A5PWLxtuFkfHR4QNxZuaw8PThsMzYhUZxx/Lfg7HEyT+n2AC+gTC/ekt9GdYugd/B0cfCikGetLDs8dSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c44470g1zYSxyLsKgdskMeHt3hmOwIE1v6QhNO7FRJo=;
 b=mn4dxAKLs/f6p+Ejrv8m/zjVafiXFzOyixiGi6Koxg/XawWvL646mpNS0NmQX9uOMMdU/2UKrdsBwYKmHrOP/288IRBLpOBnnoDmufQAxAYPjOl/Gwvt5UGQ47KDZK9iyrHw3zGKT4WOJV9eK91IWFxZfD+hT49AaNNXMg8+3Nc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by SJ0PR12MB6941.namprd12.prod.outlook.com (2603:10b6:a03:448::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.51; Fri, 10 May
 2024 20:57:45 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8%4]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 20:57:44 +0000
Message-ID: <ef60de3f-2f99-4328-9a3a-26e582aa5da7@amd.com>
Date: Fri, 10 May 2024 16:57:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Ensure gpu_id is unique
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240509200626.497769-1-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240509200626.497769-1-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::19) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|SJ0PR12MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: c0d12e46-93c3-4f8a-8be8-08dc7133d73a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0crZ3ZqTlMrOTRuYWMxOGlQNEZsTlRTa0ZWSnBqNXlEWHFHUVFqR0xFRHdJ?=
 =?utf-8?B?NS81bmhFODBwdHk4NCtpS0Q4Ti9DS0JiMU84TkhDZUZRMVJmTGhjSmFmNjV6?=
 =?utf-8?B?OGlLSnA1akdvaS91cWFPSXVzUitBMHVwVTJKM1V1NFMzMGYza0FUSlhaQmcx?=
 =?utf-8?B?TFF4T215RER0UFFaVmJXWlNoZlpwQzNBZlFuMXZsS0FnRG42QlFkQ2NWRW9J?=
 =?utf-8?B?RW05Wkg4RFR6Y2ErYkpHYWp4a0Q2SU5wRVVOaEp0VlR1U2hYV2w5bUtVcUYw?=
 =?utf-8?B?alRWM0xmTkpQWFNFWCtYV29mSWxsM0JLRUdTYVBOVEVkOXkrMGtqRTdjWCtL?=
 =?utf-8?B?TjFxMzVna2hycVZ4R05aWDlMZWlvSzUxc0J0S1lKcCtKM0liWkJsb1BjdEsx?=
 =?utf-8?B?WFByNlNYa1dzWnVIVkFjYWl5Rk1EcFVVUmVuSWhLY0NDRTdjUTZsaEFtT3BX?=
 =?utf-8?B?T3ptUkMrQzhZMkJ1ZTU2Y3ZqeXBWSzhXN3lCMDExMFVOTmw3WEJMa2FZV2hO?=
 =?utf-8?B?U056VGl2YmY0RlpuSVVETWNGd2ZiTlFqUFhEU1NESGhXemV5Z1RXRXg3SFVu?=
 =?utf-8?B?SnMraUpzQkNrd1Y4VWVPWGNYL3dhZUFjbWNZWGwwV0lhVjNZeGdhWFlLY29N?=
 =?utf-8?B?enZ5ZWVlKzFWcGR2VG9YV015R0N3dTJaeDlKeUROcHQ0b21WMzlPN2t5Ti82?=
 =?utf-8?B?bG02QWo1MjJtd3pkVVlpYlc0TjhCdnZyK2R4Y2RTSGpjVDhpOHh0MWYvYmNl?=
 =?utf-8?B?WnhXbHlzdThhR3Z6RVlvMHdqMy94aGg5ODJacTdOSFpGSmgyaWJiU0ZyT3c5?=
 =?utf-8?B?L0x0OHJKVVlrOTNtRmZZUUk5a2NSUm02Um0waXR3SnBBMnpVaTQwTExqdmJa?=
 =?utf-8?B?VEszcDRlVTdIbUk5b0w4RTJ3WUN6aGhJYngzTGZUZzZTWTBBVjVaVy9BMHpi?=
 =?utf-8?B?dFZXVjRYL1R2a3JUNTMzVGk0bWZSL1YrTk80dVYvRHR6VGhQL3NidkxVRVFW?=
 =?utf-8?B?eS9Ebk91d3NZRGlDSDE4elZSMGFkT0xsUVk5OVVDalJmM1BpT0FrMWlrZGJD?=
 =?utf-8?B?aDg2cTV2Z2l5aEFlQkQ1bDQ1NDE5MWYzdUkyd1c1b2s3ZmNjUmRTTVhwRDd5?=
 =?utf-8?B?ekkzVXB0WE5rMHY1anRwaXZPT205QjZhYlQyUHhVWm5UWjJHY0hhVkdJcVkv?=
 =?utf-8?B?eklBb0ZJRUIzTHNNcGt6blQ5U0RVOE9DVmx6QUdKNUgvY3pEbjdjMWpwNFAx?=
 =?utf-8?B?WGxCMTZYc3hudFF2eDZSOU0rMEZDamRicEZBcjlFb1A4VjhOWjREeThia3cv?=
 =?utf-8?B?bmdjRXFxbWNqTVBRbEsrRFlWQ2lqcW5tc2dPRkI5QWdQcURXZ1RvNUlkNkhU?=
 =?utf-8?B?Ui85UUpHeWdsUkZNdngyMm5NZHgvL25NbS9QbE90TGtla0MzKzNRZVppWmRC?=
 =?utf-8?B?NitDd2J3d0NPSHlFODlMNmYwUkVNV2pNWDZwYmNIWW01bTU5RTh3S25uaGpy?=
 =?utf-8?B?MXpvbDJSWWkrT2h2eXlZbEg1dyswRmtnbFpsV21QVkFHT0x1ZE5SVGVPdUxw?=
 =?utf-8?B?TFJqVTg5WmNHU3JCbFoxY2dnbFRFY3IzTENHRHBwYWhzTXFDWGJRT25sVkJ3?=
 =?utf-8?B?dDIrY2RjaDlvRDErT20wSWNQNHFqUkNYQlJoQjY5RXBTdzAvL2dmNmpVYTV3?=
 =?utf-8?B?SWFGZ3hjQ2p6VjJiSFMzUXBDaFBKZ0NoTDZVVDVHMExWOFVHTDVDRWpBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm8wRXZzWFR3SHpBZTNJOUlWR2licDRBS1RpOHFhL056bFJObnAvcENKWmJG?=
 =?utf-8?B?Qzg2QTg4SDh1ZjJaV3pseXU0c2JaQ2hLY2R5ZndWZ2g2VHdNcWRLcWFlZzVo?=
 =?utf-8?B?V2Vxa2JwMXdHNG83Mk1pQlROVXAwS3N6Ull5QVQwNXM2aTAraE5UMmtkTGhm?=
 =?utf-8?B?NkpoWjhPelYvK0w4QjFTOENBZGRpMWkzUjdaRzgvUnhUL0w0cWZWcm1iM3Zz?=
 =?utf-8?B?bWFPazB2MkRWb2VsbzIrRy8rRVozVDgvWkFUNFhpZ1daOXNqTjJZRGdReUlO?=
 =?utf-8?B?YXJNRlZieXQrSklrUGRSV1JLVVdHOVY1bWtVSmhBRXRwS0J6bTlzcjJSVWdH?=
 =?utf-8?B?LzNiMmVWWVNnNVRwdHpGa283VTlNSjJ4ZmczQzJKQnFnUXJwTW1hSldIU2xJ?=
 =?utf-8?B?Q2I2clpaeXhFY2lhWG1PaXVwaUljNkZqQnIvdjRUUURuMDF0UTd4V1pvVEtr?=
 =?utf-8?B?aWRwckVLckdwOGdJU2Y1UldLcXQ5eTJGT3VPMHQvNCtiM3pxbWlnTlJENVFV?=
 =?utf-8?B?SnFTRExjUkNQTlZuV3BKTG8yNGJwTERwWTVmTFk1NmRtZXRmdVg1d25LZ01w?=
 =?utf-8?B?M1RhREQ4REFQZ1NlUzZaTFdSajArcFNLK1EzZjNHeHZCMFRCSm16TndGeXo5?=
 =?utf-8?B?R0JpN3VIWmtmVnM4RFhxeWhhSnZjdU9lbndlVnBrbHRIRitTUFBIelpOVFR5?=
 =?utf-8?B?SVhlOUdKM1hBbHQrWmtHdUU0bFlUK1F3a3hwY1BUWi9qbGJ3aVlqc1oyR0VF?=
 =?utf-8?B?Qktkd1hXUGY4R2VNcitMeWF2UGJrUzY1U1lndTdSK2NBZWlUcHFFbXBMdlRE?=
 =?utf-8?B?dXNvN21mTnJMWUtiTHl5NzBrRHhDNTh1NWJISkxyb0VtMm9RNHFqSFBCRVlt?=
 =?utf-8?B?UmsyWW5KcUQ1WnNhNnlnVTB0ck8vb3cwVSs2U1FqMkRUM1dwOWN6TmtnUTBk?=
 =?utf-8?B?UlhvRks3TzFKaGlwallvcGNzclF6dFFiMWlxR0lZcU5DS2tKblJVenZMOUFn?=
 =?utf-8?B?cFJsdUwwN29DNCttWkZhZXVkOGlZcVhaekdoYnhpck4zaVQwNmU0QzM2ZW9P?=
 =?utf-8?B?Yy9kaDV1ZnZwUmtDT0w2UzR3ZUtrOXd1OFdsblhOb1ZtTWFCejZXSDNNOGdT?=
 =?utf-8?B?WGdmMmRzRGljdEEzOW0ydGlWSWRTN0ZFZHFmTTU3MWVtSFI3OWxTQUxocnJD?=
 =?utf-8?B?NmkxRVdlY1l6SHBlR1B5eUZ0OHVnVExzdDR1T2ljMHZXRmliUnNUUlVTWUdR?=
 =?utf-8?B?YXRJd3VQaXljbHpNdm5LeGJFUmhvSnRLN1lPQlBNWDdoYlB1L0wvQXpCOTRH?=
 =?utf-8?B?NmNCall3bmR6b1BGQ3VPZjF0VUJMdEl3aWo4NTBrejlRWmdLeGxjaEVqallP?=
 =?utf-8?B?U3M2V09QS1k2Umw1SFVyUDBsS1k1cEdiN3QrbExLeDRRejdhMG5EUlB5dTh1?=
 =?utf-8?B?UzYwcTZGUkE1QTN4OTFwZlQvVGJGSXRhekgyUU44bit4MXlIOStnYWZUb0lH?=
 =?utf-8?B?OGZrdUdxT0xLeDBJQXNnM1o3VEl5ZVFqMldYMFFmUUJObk93QkxQMUNXSWFY?=
 =?utf-8?B?RUp3b1Axam5Tc2NzVXprZVVUaTBKNW1KT2V3emFvTGNQblZxNVRlbkxad0lw?=
 =?utf-8?B?M1NDKzhOSmJPRE1JM3F2N2F3WEM4K3FVMG96UUpZQ0NPWFVVQVVjR082TzBE?=
 =?utf-8?B?eWV6N2xTOGJxTUlXaktKK2dLdnRLcWE3V0ZiQmkzTFpvb3FmbDA4ZWQ5MHFn?=
 =?utf-8?B?TzRhM1ZraHVkR3JJY1FVRWlsbU0vaXBsZFdKZHdsM1NFME9zM0VvZ09kbHpC?=
 =?utf-8?B?cVdaTjlycFZFcE51aklWa0VhY0FHeTVGcTBTZGJJZDQxeTIxalo4Tm0vZDkr?=
 =?utf-8?B?MlNDeHN5VlVwcjJNV1NMd1lCdldZUXNoYTloYVcvMDIvbkJtV3l4RElKLzF1?=
 =?utf-8?B?cVl0U1hXdUtaczZ4anFGQS9rL3FTeUxnSE1vVVZmNTAvc0dtN1VCWnNkb3lQ?=
 =?utf-8?B?Rzl1ZWk1bEJHRW9uMUZMRUtwR1JBZklWdHNBR3hDbWNVSmNrTzJBZGViQXd4?=
 =?utf-8?B?TVgwQmFMQmpidTdpSlpWVzFXL2oxRXFyeGxwbCtGWlBXb1VYRk14RTFwcE1G?=
 =?utf-8?Q?ZEvS0c3YLHR6QgugU2NKlmF5R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d12e46-93c3-4f8a-8be8-08dc7133d73a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 20:57:44.9007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hHNjtEuNtJT2OcgkM0QlZTGfbQ0g57TXCucVky3lrQB5l30CZszP8eOn3crHUqafFckoCTLvE5IQpuVoR2mFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6941
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


On 2024-05-09 16:06, Harish Kasiviswanathan wrote:
> gpu_id needs to be unique for user space to identify GPUs via KFD
> interface. In the current implementation there is a very small
> probability of having non unique gpu_ids.
>
> v2: Add check to confirm if gpu_id is unique. If not unique, find one
>      Changed commit header to reflect the above
> v3: Use crc16 as suggested-by: Lijo Lazar <lijo.lazar@amd.com>
>      Ensure that gpu_id != 0
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 40 +++++++++++++++++++----
>   1 file changed, 34 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 219dcf504f24..4954a3021f70 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -31,6 +31,7 @@
>   #include <linux/log2.h>
>   #include <linux/dmi.h>
>   #include <linux/atomic.h>
> +#include <linux/crc16.h>
>   
>   #include "kfd_priv.h"
>   #include "kfd_crat.h"
> @@ -1091,14 +1092,17 @@ void kfd_topology_shutdown(void)
>   
>   static uint32_t kfd_generate_gpu_id(struct kfd_node *gpu)
>   {
> -	uint32_t hashout;
> +	uint32_t gpu_id;
>   	uint32_t buf[8];
>   	uint64_t local_mem_size;
> -	int i;
> +	struct kfd_topology_device *dev;
> +	bool is_unique;
> +	uint8_t *crc_buf;
>   
>   	if (!gpu)
>   		return 0;
>   
> +	crc_buf = (uint8_t*)&buf;
>   	local_mem_size = gpu->local_mem_info.local_mem_size_private +
>   			gpu->local_mem_info.local_mem_size_public;
>   	buf[0] = gpu->adev->pdev->devfn;
> @@ -1111,10 +1115,34 @@ static uint32_t kfd_generate_gpu_id(struct kfd_node *gpu)
>   	buf[6] = upper_32_bits(local_mem_size);
>   	buf[7] = (ffs(gpu->xcc_mask) - 1) | (NUM_XCC(gpu->xcc_mask) << 16);
>   
> -	for (i = 0, hashout = 0; i < 8; i++)
> -		hashout ^= hash_32(buf[i], KFD_GPU_ID_HASH_WIDTH);
> +	gpu_id = crc16(0, crc_buf, sizeof(buf)) &
> +		 ((1 << KFD_GPU_ID_HASH_WIDTH) - 1);
>   
> -	return hashout;
> +	/* There is a very small possibility when generating a
> +	 * 16 (KFD_GPU_ID_HASH_WIDTH) bit value from 8 word buffer
> +	 * that the value could be 0 or non-unique. So, check if
> +	 * it is unique and non-zero. If not unique increment till
> +	 * unique one is found. In case of overflow, restart from 1
> +	 */
> +
> +	down_read(&topology_lock);
> +	do {
> +		is_unique = true;
> +		if (!gpu_id)
> +			gpu_id = 1;
> +		list_for_each_entry(dev, &topology_device_list, list) {
> +			if (dev->gpu && dev->gpu_id == gpu_id) {
> +				is_unique = false;
> +				break;
> +			}
> +		}
> +		if (unlikely(!is_unique))
> +			gpu_id = (gpu_id + 1) &
> +				  ((1 << KFD_GPU_ID_HASH_WIDTH) - 1);
> +	} while (!is_unique);
> +	up_read(&topology_lock);
> +
> +	return gpu_id;
>   }
>   /* kfd_assign_gpu - Attach @gpu to the correct kfd topology device. If
>    *		the GPU device is not already present in the topology device
> @@ -1945,7 +1973,6 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>   	struct amdgpu_gfx_config *gfx_info = &gpu->adev->gfx.config;
>   	struct amdgpu_cu_info *cu_info = &gpu->adev->gfx.cu_info;
>   
> -	gpu_id = kfd_generate_gpu_id(gpu);
>   	if (gpu->xcp && !gpu->xcp->ddev) {
>   		dev_warn(gpu->adev->dev,
>   			 "Won't add GPU to topology since it has no drm node assigned.");
> @@ -1968,6 +1995,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>   	if (res)
>   		return res;
>   
> +	gpu_id = kfd_generate_gpu_id(gpu);
>   	dev->gpu_id = gpu_id;
>   	gpu->id = gpu_id;
>   
