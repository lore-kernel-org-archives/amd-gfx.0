Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68C7CA5FFC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 17:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55C7110E2C3;
	Tue,  6 Oct 2026 17:45:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n9P3EhnI";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC84A10E2C3
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 17:45:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fgGvW28m+pqLnKd6/V9KKjpP0mqwIutrQFfmsiQSvskWZ9ZGAN2iHAloUFFZmhZu6GABfd0TpWIXwHPQrgOTrKn5YCrPKGY6t+OVek8byBwqGLWoe9VCr7ZnSH6IXuchW8u/tp+7VY9azB8hQleUURcYmBddHI22psA+bh49dIKymzqm4PPWGHppZ4o6TopUApBhDhMRBtuyExh8/63+4bEFBf8XXkR4aipR1l9RkrCSnI0QjTSc3RqxgR4Se5C5jVzR4nMAqMIUtLrYp+xIjWl6YA0zSI7hRZ1rc0FvWOmU+odMMMOw/rY7EtOu58uLtb9XXld1prNfOiRZbwgSCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7G+eiWmi1846akpnql0w8zuQ7d7wbUZ2CBVykzHQfg=;
 b=JfeYPxcgZqMeGjJrq3r/TJVaVYOniBEzzJlL4MG0LAqtFrWx0OQGxA9GR5g1Kl3TuxaKs+iCGqcQ+EWkZ3H4MUGQacN0Ly761cwl8tdtRIBrQa5k5Bw6JULEEZ0jtzyWqmVaJKvcej/ChQLxKQ9mxWQ2ATDV8ArOwtNIpm+S6asGv/shg0AhEefXehVCqOXWny7DzL3CtqcskhkjpxT7cXz2JbQluGu9bwKvHp+ZXlsfRopEW4r36QDChOQQ3iENwB+Dh+kzXAHZBYYGRO34c9Xke4xYUPhEp39Q5/Flk4uOAB4F4YfEYlIvuNxJEYanNAzwVXjjjWyDsHBXsuJdqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7G+eiWmi1846akpnql0w8zuQ7d7wbUZ2CBVykzHQfg=;
 b=n9P3EhnIx9Cm6NnGRbTXCLkwvXgTgn4YP6Os/9NdcYCD6j3zII0rUCx47PZnMUdo5OaNdtqbmKGJnWB619sGr8RekFWQqVKXsYyAMuSY2JbEiAONpabiKoi2nF4PFD0C+V2+dnBJGcVxykQc15kMrYi2AEaviZ1en9kWXGu002o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DS2PR12MB9589.namprd12.prod.outlook.com
 (2603:10b6:8:279::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 17:45:36 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 17:45:35 +0000
Message-ID: <2cbbe829-91f6-4260-8427-380dcc052eb7@amd.com>
Date: Tue, 6 Oct 2026 13:45:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: Fix svm_bo use after free in
 svm_range_clone
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Harish.Kasiviswanathan@amd.com, Mukul.Joshi@amd.com
References: <20261006135641.312419-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261006135641.312419-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0090.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::23) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DS2PR12MB9589:EE_
X-MS-Office365-Filtering-Correlation-Id: 5acd2513-4b47-40e7-87c0-08df23d1a060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 3O/7W+NyIxyOJg/I8LG0AYJz59ucl0iZT4XPdflZPT8+4hDgZxScPzd2o8636aKl26/sBhsa4KoTwwm3+/7t/OW+UlShw+Loxh6ry3EEgSfaZFpr72o7+c4pB7oDlIg+7NK83SZsG8yL82j5pv3mV/BqspO8n9oWDO/0pSKd6AHZrqNJXkUCRcVqKehucqLg4DSwkTIFcqhjbwGkPpiNKUE9Iw6HYITiRfTjtvhwqf5MLjLTDcwc2GqO5jNhSXwVjcmbkFb2bplCAzzeeB/z+/8crSBPLfWCGRTZmEcx6965wmLSysbOAEd/6Gv+G2uxJ/Em+U6+L6v+GJ1RfFsSpXOxF/Pyraw3qTNZt13o7OFnKEqrAZxL/Lnvn875Xc9OVpvYCFW7EtjURr03EMx9q36ZG2DGAsYdzh9kUc68XDNuOdf9n9CC6lndkdtK+Sixypm3l80m3DsUYMIRx7do9fobfbf2mMUisMEYicJDW3siN217BCt5Cs3V66MrSnoo4AZdxk+4imkbhKiis/YjKgBXq5do4Lxr80rQ6yR9tsWFFcIr8oEkm8Egpjusbs0+HvwIGvLztCb4F8NMF34pkkg11PnZvMPQuaqYZP5EMnvIaK24CBwdjswAqHKkogJ405cplh8VtoYGa+XH8kZXLVF/ppbeVX2xLAbyV4IE8sE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V21KTExZa1NpQ0pUaG9WMDltTHVFUlEwdHN4Sk80cldwd0NHT2N4N1I5K25F?=
 =?utf-8?B?QytsMTZ5UGl4b3ZQUFJoNG50SFNSSFlqZUpXNC9hWVIxQ0lzL3Z1cnpqM1pn?=
 =?utf-8?B?OU5xZU0wVTZyRE5oZXlTUWZiTlFSSWVnTXAraFU3OWdFV2paZlVBUHNQZm1o?=
 =?utf-8?B?dUxTVC9HZjFFSTVqd0t1bnVxOE1tQ2RXUE93QTRvbFFGSnRWUE1EUGJ5a3hk?=
 =?utf-8?B?cGNtY0NGdkVCcDBGVFFzNStma0QyL2wxT0tOUUNGNVEvV3R1SGNBVFBaUE93?=
 =?utf-8?B?SEZpTjN6dE96MmVPVXhyRHhXNTBKL0J0QUtSaFluS2xIbXh0WW5WSHFuY3E1?=
 =?utf-8?B?eDA4Zld4NmNvQ015VGR3Z3BXcG9sYnF4U2Vya1pPVzI1QWpCM2ZlVSttelNl?=
 =?utf-8?B?c0FhNm1rKzlZRGYyQzVGTFIrT3RGaTI0bC9qL0d2UXVzT1F4Ny92TW80WjEx?=
 =?utf-8?B?cUs0b3pYSGYwQ3NMMXZYdCtHeEgzY3JKVWxYMVY2dmUwU01QTEJJMzA3M1ds?=
 =?utf-8?B?cDhlK3lvL3FTMU1mVzdYWDZiTlRQM3FPeUphN2h0bjNhRFhxT2VreTZaTHdP?=
 =?utf-8?B?S2tCaG42SWVUTTJVYmxzNi9WcmlTMmNOYWYxWUN0WkNhR3VxNk1STEowaVpY?=
 =?utf-8?B?d3kwY3RDSHBwNVZZSms1U0ZEK0JCQVVxU1drQ29sMCtuQkx5NHBSYk5idXI2?=
 =?utf-8?B?LzROYUd4QmFMa1FvSmNXZnhBVWdtRWtlaGV3L0p0MGUwVU92ZlZTMnpxRytD?=
 =?utf-8?B?Z25SdlNSZldKR0Y5bE84ZjdGcXJ0eUxoY2pJVDdZR25uNHVjZHkvcGI2TG1U?=
 =?utf-8?B?ZXB2bTB1eVh1NzU4TEhpWDh6cjFFOG5NaW1tUFVmZFRFWlNOVnpwaXN3VnlE?=
 =?utf-8?B?K2lpcnlFUklDS2xHSlp3UlFlZXVNazZscUFQT3pkZXNWVjRUWUVFNGRFTGU2?=
 =?utf-8?B?NysvSGZmbFIvdUQrTWZFZnoybE91eVJqVWU4amZ3S29waGJMVU0rMlkza2dY?=
 =?utf-8?B?SmVLNGNmM2tRQjZob2hsT1pqU2N0dE1HRWVpc21RNTVVcmZKeFAxOXhNZjYv?=
 =?utf-8?B?Wk1TWVBrVm5nbnRqdktobldldjVWV0g5NlhUcHJNckZoWkk5dmFadXhwR240?=
 =?utf-8?B?VFo1MjNNVHorWWVlOTJZQitSMVFZMnBvRXF4Rit5THA1ckhiZ1VsUk81L0lB?=
 =?utf-8?B?akdKdkZ4SUJIVEVJZHdQL3E2T1VCODJBWDdMZy9taUxsYmIxcUhRemtTVUJw?=
 =?utf-8?B?Y0R4M2RrcURmb3hEajE2Q2JSTm81aGo3Q0hOMk04S29vNytENWxVNDMzS1BJ?=
 =?utf-8?B?TGkyMFFJWnluM1ZMdnNrRmt1dlA1Ni80WWJINzg2WmxmM1lKbXp3Slo5aHdK?=
 =?utf-8?B?NWZnc2d5RjJ5SUdWY3JVY1ZtdW5BQWk5emxncTRWU1hIRnpoenBFc1hkQ1hv?=
 =?utf-8?B?dFBiMFNNRmd6Z25uejhkUWU5WFhUZzEzaFFBYk5wUHdHbUNzcVZzSXIwTUZy?=
 =?utf-8?B?Q2lUdUVEc0ZSWjVGRnJ5UCtaZ1llOHcxdGl3VC9YeEpScUN2bkl2MU9hVXpO?=
 =?utf-8?B?b0Y1T2dVT0kxSWpVUmN3eHczbWlwVnpTUTlkWkpWdWt6TWVnMlJCam9jRnNv?=
 =?utf-8?B?VnphRzk1RmhGMnYvYmJmbU14ak5DL2x5YzJOTlcwaXg1Y0xKdW9XRXFxWTBw?=
 =?utf-8?B?SmE1WTFIZWgzL29abWFvbXZyekwvb05SS2gxUDBzUStYbTRRRWF0bXNBUCsr?=
 =?utf-8?B?NnVWclY4Q2RJZnd0aHl0MFQxMUNFMzlpVWhaRm02d0ZPRFkxalM2T1RlYnJw?=
 =?utf-8?B?dDE4N1JhTkNqYWlxTkFPV1BLc3RtUFh6ZDZmV0tKemM3dXFoYVpBNEtxQXlJ?=
 =?utf-8?B?UWFzK3RFdnFHT0RrU0ovTUZoeFNVSG5KOGIvcFAyMENKcDBydXo3WmxEREFV?=
 =?utf-8?B?WUFaaVU2dmR3NjZZZWlBakpwZjdmU3RFZUprRVFGV21SMTVFZ1BkZ3RWTkdl?=
 =?utf-8?B?Qm9NR2ZpaE5KVDNQbWl0VnpJaUZZU05OOWtpcFJUczFHT1p1U3NkYlZwc3FY?=
 =?utf-8?B?ZmYrQ0NUenRZNXhqNjZyT0k3VUlDc2d2Yk5YVmJYTy85SXBodGFVVFpsWDhO?=
 =?utf-8?B?TnBwbEM5clFHemtlRWlXYVBreTN4M1BodFVhMk9GRkt4Zy9zaWQyY0ZJU3hZ?=
 =?utf-8?B?Y2hDUjRiSjRobEtKZWs0Qy8wZ1plMURMVmlzQUtTdFlhTzU5YlQvTmlDWUY0?=
 =?utf-8?B?eDc1R0tNcmtuVVRWM0NhRWRUeTdwdmZDZit2N2dJdGZmUkN2YzFnN1dNVS9T?=
 =?utf-8?B?dmtpaVhiWEhMeG1tREJyZFRVMHBrUjczbjh6dzJIbzM5SE5vTE51QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5acd2513-4b47-40e7-87c0-08df23d1a060
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 17:45:35.7282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNpg4HxHSnpA3+aLVLmBYqDTh/AEL81NfSwkI+Ccjg6EpLIKXXkkhDV7LfpAq1vD2Uup7ZSAyDbpqG1DxCkxOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9589
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

On 2026-10-06 09:56, Philip Yang wrote:
> prange->svm_bo stays set after the range drops its reference in
> svm_range_vram_node_free(), it is only cleared later by
> svm_range_bo_release(). Taking a new reference based on old->svm_bo can
> therefore hit a svm_bo with refcount 0 and svm_range_bo_release_async()
> pending, leaving the clone with a freed svm_bo.
>
> Use svm_bo_ref_unless_zero() under old->lock to only share the svm_bo if
> it is still alive, same as svm_range_validate_svm_bo() does.
>
> A range only holds a svm_bo reference while ttm_res is set, so drop the
> reference again if old had already dropped its own. The clone keeps the
> svm_bo pointer and stays on svm_bo->range_list, so svm_range_bo_release()
> clears the pointer when the svm_bo goes away. The unref must be done
> outside old->lock because svm_range_bo_release() takes the lock of every
> range on the list, including old.
>
> v3: drop the reference if ttm_res is not set, don't leak it.

Good catch. See one nit-pick inline.


> v2: use svm_bo_ref_unless_zero instead of checking old->ttm_res, to keep
>      sharing the svm_bo when the range dropped its own reference (Felix).
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index cfb428c72686..5dda163cf4ae 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2158,14 +2158,23 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
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
> +	/* prange only holds an svm_bo reference while ttm_res is set */
> +	if (new->svm_bo && !new->ttm_res)
> +		svm_range_bo_unref(new->svm_bo);

I guess you're doing this after mutex_unlock to prevent recursive 
locking in case svm_range_bo_release gets called. Maybe mention that in 
the comment. With that, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> +
>   	new->flags = old->flags;
>   	new->preferred_loc = old->preferred_loc;
>   	new->prefetch_loc = old->prefetch_loc;
