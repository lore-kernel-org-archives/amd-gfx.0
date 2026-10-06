Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C40CA5FED
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 23:15:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E95310E05F;
	Tue,  6 Oct 2026 23:15:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WWtgcYVR";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013051.outbound.protection.outlook.com
 [40.93.196.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E23C10E05F
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 23:15:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQMbCAytTU5oyKhNi1ViDC1mBShPjZAtev5vU77zkZOYKIG0O58erGWxPAPpFru3rofynIFNLqeZ3IOj7t6uSStzZ2IAwTZGG2ssXm//nOR2VXAbWlo54VsVhIazziMmhm4OrslnMk5Lx4n2q/VhZS2dQI6BGkD/4+t0oITwMVPHDz0aZbLCxYYcDxwFz8AwBvNXsU1/e1UILhHttz7Acd2qrBkF+ctoYfWTAJ7FOp2EsnhfVFirRbUGtZfivFIxDMhKu0wl6wZ5MyaweTuOZr0IDp1QBb9mhuImD1QmTDalVwmE6i6Ju7xzEKZkU+r3SIi4uPgEvAn84Akt3QfWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1NEBOHlOwe0ZnZM9ArBkG2k3OaltRnkMCvqluZVX0Y=;
 b=wlN2Vm9eKXtLQK5IlYONveku3fVvqAUvloeS8GGL/506JS1pRSRzYtDkKfFPBTneVUrdY9Rs5OTdO0RSYSCynrDo4wU9+YphL9gnWV437u9TM2fUZBMaMa32ff9MCeYrhI6UOq0gBEyvrLAukVLlCtXP7fJZu0yAYKPvlw0vpdemmDdAirsxTSxGZ3PA6oY2ayIfHL7YPzjm4tF6xnjSMBMpfWTc1EKn2DPh1DhjZYKDk+3siDgvWzpa1FnmVakNSbfcAkM3mrCss+xdTWApTqsw4KTWlX361l8CfsDzZnHq0b4fUUgHst8pcHkNzsWgQkhPKMvRup07vbls/ks/aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1NEBOHlOwe0ZnZM9ArBkG2k3OaltRnkMCvqluZVX0Y=;
 b=WWtgcYVR+zFQVdTmhXyr8eATGaEinHFbEo6qcldwR/CtjcCcjX1zTd3KTsioVEq3y/pykiuTg9xs4Fd5lBck+zQ20N7ymw4dplf2vB7iOijOr+tX1mrsrplZqPWBzK2V+DJgqoZqn9kzL3j3Sbk14rVyQWcr2kuANiBJqj8G97c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 23:15:08 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%4]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 23:15:08 +0000
Content-Type: multipart/alternative;
 boundary="------------YeVXQMR09cs3k5NZ98LHjxcO"
Message-ID: <481e84c9-ebd9-4b81-90ea-a59c54d23dec@amd.com>
Date: Tue, 6 Oct 2026 18:15:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: Fix svm_bo use after free in
 svm_range_clone
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com, Mukul.Joshi@amd.com
References: <20261006135641.312419-1-Philip.Yang@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20261006135641.312419-1-Philip.Yang@amd.com>
X-ClientProxiedBy: CH0PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:610:32::14) To IA1PR12MB8517.namprd12.prod.outlook.com
 (2603:10b6:208:449::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8517:EE_|MN2PR12MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: cc9255aa-ed25-4110-ec79-08df23ffa983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|11063799006|8096899003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: P+gFSmVt4JyaPQu9JKUPrEzsFHWURmF5EhyKSg3yOwL4S+oZYb4S6Ut5mSsTXACFJWpwSSlfAOqjewon2nVgd4uHr4pQ9SguOoZkhadr/35iA1RFBc+eCawawMVGUWeAFUEdCZjKH3qNflkU573EaP9lBMDDfj+grf+d3NkbB9+NkM1dzLt7wDiwTDB6gmso0LCIePgcwsbI0+grCHLqJfhACfXr8V3y84u0NI5sCJZtJ0WzCY31sR7nWf7BMWoLeX1ZmZ5bFT+35O4wwQ52pNgWGmExEHvndExtnWNIW6ZcYwOo+nS2lGqW6AV1pd3jEh12IlryT143w96NzcNhuWFre+ddqAqlQW5ePlTlraShsylQ23O7Xi/u92rYrZyC+g7bpqeSVWXWovlSF2pDZCKO69axHqDb2fCMu1x9AvysCzYZxuqigSURIeyO8AoJTg5H55Jm9ukoYOlQUG6p5PI/PaDWS5r9RZWWikUk4CmgSOM9g1v2q3RdEu6N3Q2cDRerAyrs2Hcj7cr6vyvcdeaf0QsWJlfnhwwTLF2vRiPD77SE7XMMUV+rTcThlK9r1neiuKsbnPOMLhnnSMJ0I/jvjQGD6YLeo1rwX5ib7/ntAor9T+CYPYLaNBO1kjI6PNoYzNRyYN4KDTLqWIOPcKQHzi7ebIpW79BOK5GRM3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(8096899003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0t4TU10K0lScDJBNEJyZktPeFhTUFdKTDFWYXhkU0tTVGUvb1ZVazYyMWZO?=
 =?utf-8?B?WlhDQnVCU3ZqcGVUencwdU9USlAzdVpJZ2ozZmh2dUJML1c2V200K29PUS80?=
 =?utf-8?B?QVJWQ2pvS0p3cVBPeW1GMW9SbDNuT0N4QTN6M0hUTFZhNENuUlRNbjJKdUhI?=
 =?utf-8?B?eE5Yc1FKNXlVWmJpdENhR0Q0bVVIODl6U1FCVTBqL01GUkJ3Z2pXMHEvWWRK?=
 =?utf-8?B?b3ZuMDJaTTFkc2VrZDN3RmwwazMxOVdxOGc2bUdCZFd4cm4yUG9IeW5hbHpR?=
 =?utf-8?B?emxWV1NXT0ZxbjRaNVRpOVJOaVRrUENCamlqRnZuZW9qSWZwLzhvMW5abHFv?=
 =?utf-8?B?MGNNNC9iVng5NUJLTWhTV0UwNnExK25rR05WSUlVVzVhS2tEOUlUajNTd25F?=
 =?utf-8?B?Zi9jQWJ6dTFtbVhWNUpyZVg4eXk2QzN6d3BmaGp1dHpocWQ1ZkVUcjlURmZz?=
 =?utf-8?B?eFdpNjkrWWlyaDdTWTU4K2FlZHRzelVqR0labTNmd2txVTRKWUU0aVh1SkI5?=
 =?utf-8?B?UHNBdjdRT1FOL0lrWDZqSjVkaXdCajFtMEtuVzBuZGdNdHRyK2xkb0c5cDRa?=
 =?utf-8?B?OXAwOUZLdWtiQTdza2trZlJtNkVRYkt3S0RWWVd1NlM5WWUrVE44eDMzcVhE?=
 =?utf-8?B?ZEVybWZ1cHY2NDV2czB0dUxLWnB3U3VBN29HVXJNUGJ4QnZkd2U2ZkFMODVz?=
 =?utf-8?B?dmlmZFBWb3ladXF3S09UeHlUa1o2UFNGNTdDWlN6NTZ5YzcvcS9VckdKSlA0?=
 =?utf-8?B?eEVCWFJvcEFxbk01b1o4MmNqckpESHhWZjBGZ29GOGh0cWJOSWN4MkdpNWhx?=
 =?utf-8?B?NkFlOCtZYWFZTHQ1WldtRHVqVEFoWW9MOFl5d1ZiNUlIS3M3bVYwMHhQekps?=
 =?utf-8?B?akhBcUhDa0J6MUwxVnAreHR4WFhBZDVCWDBVWCtMWXhDNG9meUI0Y1BmZ1lw?=
 =?utf-8?B?U28xcVpWZTJYODhnRmsxNnFYci9DZ0txczdDTHFaK0szSmNjZ2c4NUFUa3dZ?=
 =?utf-8?B?Z3JmMHN3QU5nM1FvMHYyMFQySWxsUTJMV0lkZG5yMzdwL3Q5WDBIbzZ0bFV6?=
 =?utf-8?B?K0M5dERnWXVEbzlsOGN0ZWRBUFI3TDUwbWpDY0xsdlFtOU4wdE8rM0FQajZv?=
 =?utf-8?B?U0FaUGphY0FQNmh6bDR4MzBUdmc3YnBLMUpPcndEbEo1QVl1SDFoa0gyZHJa?=
 =?utf-8?B?WFBkbGNNWVdadFNlTEZieTBzMWVka2YySEhSWDNTSGowTjAwZjdwYTJLY01D?=
 =?utf-8?B?NWYrQk9CdUt2N3BOL3JDTG45Z1lhKzUyNU9KMmxValVTdlRZc25YZ1RHeG1O?=
 =?utf-8?B?bnExeENUcjE3MXlPdGxQcmE3S3NweHV4aDB4c1lkRUMxOStYSllCRzZoaGQz?=
 =?utf-8?B?UkRZUmQxYWF3TzV1dS9Fa2FmeTdGWGpRYVUyVlQzWmNTMHJ6Zk04R0xFZ1N3?=
 =?utf-8?B?dHVGYmdsUjNrUnZWYjFmejRkeXlOY2xUWm1oV1djdlhzYm55Yjc2cHcrWEUv?=
 =?utf-8?B?OUVlTitDOE5QVm1xdGlxUlFGa2lKWXRIaHJqYTdkeUxYTjVXUng4bkwwOGVN?=
 =?utf-8?B?amVYY0hGZmh6MTQ1N0NHU1VFY0FzQkswNVBCUGk4M0pDMmJyRDhUUm8yemxN?=
 =?utf-8?B?bzltTkRkOXlaUU91T3NwaW01S051TXRYSEhtUjAra2s5dTlZNm1uY0F0RjMv?=
 =?utf-8?B?NjFXL0MxQWFvaGp5RHdkOC9BdFVSNXdrNk5EelN3bXhmNlIydWxlekFCMWw2?=
 =?utf-8?B?YVJ1Q1FzaWszbG9VcGZLL2o4SzRLVWhGdHZFeDRQNzlUNjYyVDNFVXFleFJh?=
 =?utf-8?B?ZFlsaVVxaFVjMzk1djNKcVlVNUNEYzNTVDRuaXJiM1YwRnI1SjFRdUJkMWJw?=
 =?utf-8?B?UG4xaWJTRXJ1Qi9rZSt0RmFJQXFad3dBSEZ1Vnl0UTNpTUd6VytzSHVJRHBR?=
 =?utf-8?B?RDhZQ0ExODZwWDRtQ1NkeC9RZ2tRSlhxMURJZWVrMzR6V0JaZ28zODJTbWtm?=
 =?utf-8?B?a2tTZmdDVjZYaGwyTHpCMmN4dmROeTJ6QTdES0EzK0t0WjdFbmJVVEpZTzhN?=
 =?utf-8?B?NThtVEQzZlAxRUVDTndRZXhObmVmT3NCdHByQ3lSb3dnMmk3RDV0eXp3Tjdp?=
 =?utf-8?B?bittcnd3aXJ5amJFaUJPK2hrbkdhN2RqdHBoeXZZL0w3eTV3WG4yRCs5WDZT?=
 =?utf-8?B?MmRiQTRXMjBiRmYxN0ZHMkVKL2U5RHRJUnUwQ3I4Y0praGdFbzNxb3d0Skg0?=
 =?utf-8?B?ayswOVA4clFGeE0wRUR2b1hqeTl5UHFMaHY0L3J1MFJPKzNSSHhHRmNuV1FS?=
 =?utf-8?Q?cQUSfe1PSNF7CsiqXO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9255aa-ed25-4110-ec79-08df23ffa983
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 23:15:08.1120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8B+fW95enojBdSXNq28EFO+P3OT/QgdeN6PGpAfZSVHYVop5/Yk5HWfTaDVdoIOQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078
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

--------------YeVXQMR09cs3k5NZ98LHjxcO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/6/2026 8:56 AM, Philip Yang wrote:
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
> v2: use svm_bo_ref_unless_zero instead of checking old->ttm_res, to keep
>      sharing the svm_bo when the range dropped its own reference (Felix).
>
> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
> Signed-off-by: Mukul Joshi<mukul.joshi@amd.com>
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

The following checking if new->ttm_res is null, you drop ref of 
new->svm_bo that was just got.

If old->ttm_res is null old prange has no reference on svm_bo, so new 
prange(cloned from old). Can following checking is ok?

+	if (old->ttm_res && svm_bo_ref_unless_zero(old->svm_bo)) {

If old->ttm_res is null, new prange will not hold any vram buf metadata 
since new is cloned from old. Then do not need following checking to 
drop ref of svm_bo that was just got here since new->ttm_res is valid.

Regards

Xiaogang

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
> +
>   	new->flags = old->flags;
>   	new->preferred_loc = old->preferred_loc;
>   	new->prefetch_loc = old->prefetch_loc;
--------------YeVXQMR09cs3k5NZ98LHjxcO
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/6/2026 8:56 AM, Philip Yang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261006135641.312419-1-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">prange-&gt;svm_bo stays set after the range drops its reference in
svm_range_vram_node_free(), it is only cleared later by
svm_range_bo_release(). Taking a new reference based on old-&gt;svm_bo can
therefore hit a svm_bo with refcount 0 and svm_range_bo_release_async()
pending, leaving the clone with a freed svm_bo.

Use svm_bo_ref_unless_zero() under old-&gt;lock to only share the svm_bo if
it is still alive, same as svm_range_validate_svm_bo() does.

A range only holds a svm_bo reference while ttm_res is set, so drop the
reference again if old had already dropped its own. The clone keeps the
svm_bo pointer and stays on svm_bo-&gt;range_list, so svm_range_bo_release()
clears the pointer when the svm_bo goes away. The unref must be done
outside old-&gt;lock because svm_range_bo_release() takes the lock of every
range on the list, including old.

v3: drop the reference if ttm_res is not set, don't leak it.
v2: use svm_bo_ref_unless_zero instead of checking old-&gt;ttm_res, to keep
    sharing the svm_bo when the range dropped its own reference (Felix).

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
Signed-off-by: Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com">&lt;mukul.joshi@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index cfb428c72686..5dda163cf4ae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2158,14 +2158,23 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 		svm_range_free(new, false);
 		return NULL;
 	}
-	if (old-&gt;svm_bo) {
+
+	/* old-&gt;lock keeps old-&gt;svm_bo alive while taking the reference */
+	mutex_lock(&amp;old-&gt;lock);</pre>
    </blockquote>
    <blockquote type="cite" cite="mid:20261006135641.312419-1-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">
+	if (svm_bo_ref_unless_zero(old-&gt;svm_bo)) {</pre>
    </blockquote>
    <p>The following checking if new-&gt;ttm_res is null, you drop ref
      of&nbsp;<span style="white-space: pre-wrap">new-&gt;svm_bo that was just got.</span></p>
    <p><span style="white-space: pre-wrap">If </span><span style="white-space: pre-wrap">old-&gt;ttm_res is null old prange has no reference on svm_bo, so new prange(cloned from old). Can following checking is ok?</span></p>
    <pre wrap="" class="moz-quote-pre">+	if (old-&gt;ttm_res &amp;&amp; svm_bo_ref_unless_zero(old-&gt;svm_bo)) {</pre>
    <p>If old-&gt;ttm_res is null, new prange will not hold any vram buf
      metadata since new is cloned from old. Then do not need following
      checking to drop ref of svm_bo that was just got here since
      new-&gt;ttm_res is valid.</p>
    <p>Regards</p>
    <p>Xiaogang</p>
    <blockquote type="cite" cite="mid:20261006135641.312419-1-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">
 		new-&gt;ttm_res = old-&gt;ttm_res;
 		new-&gt;offset = old-&gt;offset;
-		new-&gt;svm_bo = svm_range_bo_ref(old-&gt;svm_bo);
+		new-&gt;svm_bo = old-&gt;svm_bo;
 		spin_lock(&amp;new-&gt;svm_bo-&gt;list_lock);
 		list_add(&amp;new-&gt;svm_bo_list, &amp;new-&gt;svm_bo-&gt;range_list);
 		spin_unlock(&amp;new-&gt;svm_bo-&gt;list_lock);
 	}
+	mutex_unlock(&amp;old-&gt;lock);
+
+	/* prange only holds an svm_bo reference while ttm_res is set */
+	if (new-&gt;svm_bo &amp;&amp; !new-&gt;ttm_res)
+		svm_range_bo_unref(new-&gt;svm_bo);
+
 	new-&gt;flags = old-&gt;flags;
 	new-&gt;preferred_loc = old-&gt;preferred_loc;
 	new-&gt;prefetch_loc = old-&gt;prefetch_loc;
</pre>
    </blockquote>
  </body>
</html>

--------------YeVXQMR09cs3k5NZ98LHjxcO--
