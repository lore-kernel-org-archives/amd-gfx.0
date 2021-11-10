Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC88AC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 03:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC4461038
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 03:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7DC4461038
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2CE46E47A;
	Wed, 10 Nov 2021 03:26:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 520596E47A
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 03:26:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjfR9dRR5rUFptP7jSOSKWRh57dAqZ878Sb/og/u6s4Omb47PPNMlI/QETL5XlMrH0GK2p/QXKPR9KmUIiYGRS2kQ1a7Oog3+ZGXbDPsmMrZYgHbuiFmuE80iXFIp0fjQZBY1idkmpYZAMBSvSXMEyItikdGwzubw+sfEiWXKZ9DRRCkIjSNl3VhQrlVMEleXoNxY8XFi7FbdsQfAAgJEMqD5oC/99QNY1tsWfnXyEwKKsrHKT0CnFK4VzqhoPQdF6/5JwWEdu67YnSZ7JjNFmM8IubRfUX7egRVmEVso1DINJZ1u3tYBpAkBcJoa+FAFftzDzE3K7rQOgoyZ0cCiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bx4Wj7y/ueKzSZiE6BhzBtoe4yHl+aAivMZ4RAM0jiI=;
 b=LkzQ28SwEspXZXIQ5+ui+35p4aKHpeaPV5QpSqZ0/ZDZXx8lu5LCkqZhdYgLmAvTJifzBn5rXG2sBmPe9VAhkryKLsJsYaB06IZ91DVU5SSqNd25d2FjgZJGlgSELsF3V+l+g40HypTBun5sSzmMvdhxYf12npuUQbnrl7D78jSKEUXlg/SvHdmsxhyUGHA8D+gJj2qh394ctdvWgl29DhStGVdBjHzUGLTexmVs7V6v4PPHLc4zcrH3/ADkb003nRH2AO1BodL4LHHKu9rItgkHl4FrMfcU1LTu53Wc6h++yQMI+XZy7PPhUvsf/nAIoWQSjKhOwMExgWaaKC6b3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bx4Wj7y/ueKzSZiE6BhzBtoe4yHl+aAivMZ4RAM0jiI=;
 b=Xsq0fEaV0+oVZQAxlABJgoYq9lHO/yUqjiiJLQyz2cS/vu8zEyfG7MYwJqA9HQqunN7EGH8COrvM2hjQ6WXuyrcFqyJHlUKxroSX65JnC5EO7RwW2WRMY5gX7r11reh2DllQ6psHwoEL6BSqLSDCK/6nvZDk1VPfik0rMcBLBeY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Wed, 10 Nov
 2021 03:26:07 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3%3]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 03:26:07 +0000
Subject: Re: [PATCH 2/5] drm/amdkfd: check child range to drain retry fault
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211109230432.3947-1-Philip.Yang@amd.com>
 <20211109230432.3947-2-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <d4bc4acf-ff14-5370-16bd-8cec6253c09c@amd.com>
Date: Tue, 9 Nov 2021 22:26:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211109230432.3947-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM6P195CA0088.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:86::29) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 AM6P195CA0088.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:86::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 03:26:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5da331d-c50a-4cd2-fd79-08d9a3f9d58b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5237:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5237E718F422A906134562E392939@BL1PR12MB5237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OyfWCVlX0FVlIXm8+jDA+f2I5RdzXBfdEddLw7MU3PE7F5TxOObcWsUAwCiBK7kBq75ze3aXna0kIFDNMj7rwogvC0ai+10SieWBJlaaTiwD4yEqGwq1//GtnEjKbcLMfJ498SwvD7V5qiIzol4iJcu6qc7JOwxKU6aKkLqY2jq2R8yd58BIhMVuvcGRSQLxmox2a1aowN0ZI2RocgwiPDf5uCniiPIxFNsKKImZYkpFpuchf+zFZVlTx8GJ8quPjuRkJp+wX+kV/eUXvwAoS7GpK0iVMTAtyCslzrw51XgkrxJWQysVopDjWC/G9nLu5cz3wq+ZqTZd0wwPXUCgqqEM43l/Edk8UhIgau2WPx+JU7nwK3KxCwHO7jWWB9gFOhhFF2DrI5yJPBth70AxUMUk1pvo+Bc3A5xT+G3oL3FB/mE3kZMk9MGDjAx008HZQz1qZ7SAnjGMx7kjf6/5qyXS004J9VpNDkY0+qqn1JR2gxjiul5BrvFRGDU5ovUifqBxAYKnGUAh+e9zRjMBYlraRX4qwVMFMVXNwYhptJb/7eUe7R/N4Ku4pthQmr+HAlviPPzpMdb7SF1Nh0kjOKnU923xKGRzHGU5atERStdmC70cKNRFL/PBVWYGH4XrhfiQRVwB0XEcPBFCLXUFBfQYqkDvy880s2GrJjKVEORHzC47fxmy7XsWen63N+o/hNj6kQAFV+86dyv6PXOQEIH5MsIm2YPtlNd6cM8I3Co=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(956004)(508600001)(8936002)(36916002)(316002)(16576012)(83380400001)(36756003)(6486002)(31696002)(44832011)(6666004)(8676002)(5660300002)(38100700002)(31686004)(66946007)(26005)(66476007)(66556008)(2906002)(53546011)(186003)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emFhZjlHOVlRb1E1aENKSjZCekUyaGw5RlhLL1NOb2ZGKzFxcjlDWmlMUVBM?=
 =?utf-8?B?NnFKZ3NuN3V5amUwQzg4RFE4cVgzbTNDOHZYZy9CbncwaWxPbklaeGlubmI3?=
 =?utf-8?B?T0FhQkpwMzEvalNEQkdGSkhuQTJxWHBJc3VLMzFWNFA5UHJhVWFCeGRjanZK?=
 =?utf-8?B?emViOWVDdlgydFU1K3BQU3Yrcjd6VzArcU1ncnpIeld2ZXZvak9uMDhEcTdS?=
 =?utf-8?B?RzF4akJZaUxlYWZ2STdUdXhjbS80dmNrU2lLcWNKQ0hOSjZYNkhTMlVWdWlo?=
 =?utf-8?B?aVFxTi9JUlFQMi9PSDFRMkhlMVIrNitpTVZxa1ZRMUtnb0t5cXJ6bXV2WWU4?=
 =?utf-8?B?OGYwa2RaWm5RZE95a1Fab2FhSSt3Qkt3QUFDVlJ5QVFrSnE0emE0OVlDWWcr?=
 =?utf-8?B?RmNPSjMvZXAwRUZlTlhsT0YreERLMTRLZCtrVE5VY2dxOFZWSTg2azhPRkMr?=
 =?utf-8?B?Zldwb2RkZ1Z5VUxsWE1aRDFKei9yL2tOVnJ1WGpFWm1HQXB3Nk5KTEp0a1c4?=
 =?utf-8?B?a0J0dndFVDF3UGhDSnY1OE55TW4rblR3WTNZdkZvU1VaenovbFpLOWh5MDNj?=
 =?utf-8?B?cXdMTnRqMEF3cmJVam04NEt4VjZ2RzV4dGlqUWJ3cW9BV2VlYTZSdzNzbm4z?=
 =?utf-8?B?a0Vvdm5ZdzkwN3N2cGx2SUZDRC9hYWlYUy9hemREYWQzbDluUTc3Y3hiQ3FH?=
 =?utf-8?B?YjRWVUUyMXo4TThkR1JZTWFWKzM3OG02VU54blZyNDEyQVZPQ2EzS05nbi9P?=
 =?utf-8?B?b2RYMThKcVoxS250clJjOVdPNUxnMk85aHNYWCszL1dFRE5sbUUyWXVuRGZh?=
 =?utf-8?B?Qys4RXBHYUZZYWQ4NDViZUVhZS9RZkw0cDZNSU5xNDJZakpsUmg0dVArYlR2?=
 =?utf-8?B?SkxxNXhjTG1jOCtrMDhEZkZ6ZGhnK1c1YWZhQkV1bVA4NlRFWUtsUjRZekZx?=
 =?utf-8?B?VTNMMndvZkVoMVdjM3NRQUFqMDdadG5GTnlHR1VQaTR1OU9aeVU3d3JDeDlE?=
 =?utf-8?B?eHZaREk1Y2lYQkRackR5MGllaG1ZUjJQK0UzLzk4ZVkxd0o3THRhSEU5UUtm?=
 =?utf-8?B?b0o0MCtnN1Z5MVphZFVUWlNwd24wUnRsaDBDbnVHdXhCMXdHSVlpNTArTWxQ?=
 =?utf-8?B?NVl6N0djazZlRlJkNnNhRENuQnNubVJHUG1FVWN6WDJjeXBsQ3NCdUZFSzk2?=
 =?utf-8?B?QVhDNmpJYTNEdWxiNkQ2clEyaXZML2I1UXhxU1ZzL3R0cERPZU1WSTRmUTBn?=
 =?utf-8?B?cXNETGtheEdKWm8vOEFzSzhwT2hXcS9zYlg0WERIT0JtclUzSlRTdUl0M04r?=
 =?utf-8?B?RmZlVWNLcGhxSDg1dHQ4ZjhiK0R0TWNvL3NYUHh2eHpwRVJZWGZNSDF6ejF1?=
 =?utf-8?B?Vy81RVVleE9tOVloWjJ0UElIODVrczB3T2F6L3JkNDI1U3lHSXBGQlB0cWxM?=
 =?utf-8?B?WFpVUFE2QlZ6d1ZXNW56ZkxPbnZiMUlrellDdUJ0YVdINmNjSHVqYUtMR3hw?=
 =?utf-8?B?MXFWQWNpZHhWRm5wKzRQN0IxMWY0cks3NUZ0Tld5S0syN25qYVVWQVZaM2xD?=
 =?utf-8?B?cytDTkZsV3hUWnpNQVF2VldEUm4xVDkvbk1FdHBqcit4VlFwNHRMUXpHQUtS?=
 =?utf-8?B?MDNzU0h3NUhPVmJlcGQyOUkwcU8vd3VuYytYclZ0OFBybFdQdVM3blRvRVRx?=
 =?utf-8?B?bnp2Qlk4c2txVTIxa3Q2Y1g3V2J6aFZYSjlhLzVjdW53a1JWdTFHY0xXeGNV?=
 =?utf-8?B?TzcwR05id2NZY0x2VmhjK3hvSDVsSkNhTjFhQjZQNGpCMW4wNHUrUnU2eXVS?=
 =?utf-8?B?VzNDS1kyQ2J0a25vdlRlSHA3d1N4WkJhYytsMjFTRmp2dHVWbDFMb2JFMmZz?=
 =?utf-8?B?cmo5VkRJeFVXaitSYVA3WkY4YUN2S2tqVHFRWGVNWDdUM2dFV0VqZWZ0SGQv?=
 =?utf-8?B?T2RROG14Z0lCRTZZck5pRnJRbFJjdFFBZHc3R2NwdlhRekhHdG9SQlE5QUl6?=
 =?utf-8?B?VnVnemtrMXJSQ1BwODNwTUdENTNXY0R5dllEbVVTWm5lS1gvNzdjaFl6Uk5P?=
 =?utf-8?B?cGhjbVpPNTA3OVp4RUFXTnlGSWw0Wlpra1d0Z3YreEQyVlFDWWR4NE51QjVs?=
 =?utf-8?B?YXVEbk83bjR0NSthVHVLc0Iyd1RqdjRhQ2ZuWmhyZHVqRmNmNG1DcmEvanh1?=
 =?utf-8?Q?IvoW+ZeeqO8kTZka1h3SIx8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5da331d-c50a-4cd2-fd79-08d9a3f9d58b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 03:26:07.6194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5W/f1sLKWrR4bt5ihrqbvyx+DwqczmEOMN3ZmNNF2Maw9WV13EIiXeyYQLVYWuoYp0wIOrTm2CK4e+sXS9ssg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5237
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


On 2021-11-09 6:04 p.m., Philip Yang wrote:
> If unmapping partial range, the parent prange list op is update
> notifier, child range list op is unmap range, need check child range to
> set drain retry fault flag.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

I think this could be simplified by simply setting 
svms->drain_pagefaults in svm_range_unmap_from_cpu. The mmap lock 
ensures that this is serialized with the deferred list worker reading 
and clearing svms->drain_pagefaults. You can also use READ_ONCE and 
WRITE_ONCE to be safe.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 77239b06b236..64f642935600 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2049,8 +2049,19 @@ svm_range_add_list_work(struct svm_range_list *svms, struct svm_range *prange,
>   	 * before the range is freed to avoid straggler interrupts on
>   	 * unmapped memory causing "phantom faults".
>   	 */
> -	if (op == SVM_OP_UNMAP_RANGE)
> +	if (op == SVM_OP_UNMAP_RANGE) {
> +		pr_debug("set range drain_pagefaults true\n");
>   		svms->drain_pagefaults = true;
> +	} else {
> +		struct svm_range *pchild;
> +
> +		list_for_each_entry(pchild, &prange->child_list, child_list)
> +			if (pchild->work_item.op == SVM_OP_UNMAP_RANGE) {
> +				pr_debug("set child drain_pagefaults true\n");
> +				svms->drain_pagefaults = true;
> +			}
> +	}
> +
>   	/* if prange is on the deferred list */
>   	if (!list_empty(&prange->deferred_list)) {
>   		pr_debug("update exist prange 0x%p work op %d\n", prange, op);
