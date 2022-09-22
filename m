Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23934C6FA8B
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 09:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71F9F10E2D2;
	Thu, 22 Sep 2022 09:09:37 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0DDA10E2AA
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 09:09:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkkfNNcmtb7tODJIHtvIvLhOP6FDWmDYreEZiSRfceHEkHGEkFJQyFybqkg1kb1zwMMg4TIdnjbEsDRJfSi0xg7LedaHixl9eVnj1VxomzxZ3h2FaIdnxiLOqtGhz8tNeNKp45DlAaEwSlCjjWYCqR3UOvH8qpUCxxaoebSMp4hAqJQPpoEM3+OoWYjXaFfjfAUVQBXAecMzw6jStXI/hpoD/8EExq1Zg4OGNRrD3tl0Q1P8rI/NTiIJuSI1NlnGs63VA4BBShCGSvn/ColCbE4u314mthWLg8BZYi8ExGbP+dI6PHooY6wFIeD5m7LaBWskaLZkwA17MOLx64GYDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FBbQnRAO2DBmtAhdHSpdZOLZp1JxUySS96gORGDzI4=;
 b=TSeUgJqyIIZqmGyveWJVEScC2FLEZ+aKopyGHlSb2odP90rcXVWLTtce/SXaHma4R4DVQssv0qRRMY1uAKzwKzq7mfprxzHBQ69Brp73oYibQH/uKJjILB/B8wQN3nqyBUuk9SBumdE5oQnRpRogrYu9fkdMmfvnFMocozN34ZVhW3weIIitLkg+M46UUIxF9oDpB1LZBnjP2gemL0+Yk6LZhzg7OaBlDPaCiHhCAtt4h4hJqYPnKb/aUnEmqNPtfrL/c40DBO1xqGECeMB3xiDx0GUCuGCN8lYsH5At4nDRp+2EZgqHK+qC6TzK+DPuckwYuAlU6zHLAcszVWf1tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FBbQnRAO2DBmtAhdHSpdZOLZp1JxUySS96gORGDzI4=;
 b=m+nZxhUb7O5nPqyJ1olwFNvMgCn8EqKc1jAomiV3CXRGcJeaVZUeO5bSTagZzHdskVJEQHUVvKGhEBJ0eTfeusKnAK0shkaB8c8tlBR5JP8iBdTu153rL2f/40gl3oxvfcXZEfhFvb+8znOHPxYcmzjQ4lRPC2v4LavcVwpIMcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS7PR12MB5936.namprd12.prod.outlook.com (2603:10b6:8:7f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.17; Thu, 22 Sep 2022 09:09:31 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5654.016; Thu, 22 Sep 2022
 09:09:31 +0000
Message-ID: <2f5be04e-3b0e-57bf-463d-f24e853ef028@amd.com>
Date: Thu, 22 Sep 2022 11:09:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amd/amdgpu: solve the issue of allocate continuous
 pages under xen dom0
Content-Language: en-US
To: "Xiao, Shane" <shane.xiao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220922071133.927436-1-shane.xiao@amd.com>
 <22bacb5d-6bd1-8c26-71fe-567952f09b11@amd.com>
 <DM4PR12MB52619A246EA77D8F92A20D759D4E9@DM4PR12MB5261.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB52619A246EA77D8F92A20D759D4E9@DM4PR12MB5261.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS7PR12MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: 46cb3989-0581-4998-15e9-08da9c7a291b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8x2+KTC260qDBvalGs2DSAK4URHenDTEmiivVQD8sh+RP9P1gcoVW8pUBU3I619CdwjIcxGeWWFvCYTaFmnsY9cEadIRyaXmX6HKBYvTBv4c/gOq1SKuSPmfz4CbAVFdtO3zqWrHx/1j76p05VsK02xDhb8ZS33U0Bk4kmMGKWhIIy4bFrYdFmJZm+0G1sPCg50BLwqwY3KmgR6grUDj3hpMnhKuKST0+VINNIHQhSge35E8uNqqjBSyededc64u9/2aq0QhTRMbehRRG1PhWq+5BN2nfCi68rVVhpLw0JBLCIIqgTcsgf8IVopdHeU8ZJzqQZLAz3Xc4zoGD7Z/wA9qXWkTRJ73DXewoPx2fTVWNkWYYrh1q5MV3+bI/UoyVs0iL/gewYsRGopPHE55z5yBxrPSAAbe+daK2QBaTpORwDAoS2IqYVmtLEce6zsnRb3XpEMQkX3mqVLnlulQDJSoxAK5ZSd5ix0hwh0wuSjN822Aho6ZC+7aYptEj1eq3ymJYWnlgULOzP/CIz30uz0DMRUIeIco1aFqHjjcELPs3n9VUBMpjzaPxx6O2X0Ush4q0pVzRU+pr0R1MmBIXOZeTqMdQDl/Sd1hHAGJDRRkDpNeO/P9h97qVB+l8FV9rR1Dhy/RHsd0vHIO3bmRjWCyUWgfKcBUHtKR37FNhd9L3gRTqH7r/afpE0rvKfy3RB9v5PwwmMpYA2djPAJBD0lU9+6zyt9nU2qr0udj71E/+EiFi16cSwqao9DpiX7zCrQsm2vW/vQXRmYAFDz6WpAkOf2iut1hK8sveg0oHIs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199015)(36756003)(66476007)(83380400001)(2906002)(38100700002)(31696002)(6666004)(110136005)(478600001)(86362001)(8676002)(66946007)(66556008)(6486002)(8936002)(53546011)(186003)(2616005)(26005)(5660300002)(6506007)(6512007)(41300700001)(31686004)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDhKYXFFajl5M3c1TitlMEJKb3dRV2R1bkFxbGtLc3U3OVByUnZYbjFtL0Vs?=
 =?utf-8?B?c2lOaFZJSUxWbnlveEZrRTgxcW9BS0JrUnJpa0Z3enBWbnpjRGszWnExNWdh?=
 =?utf-8?B?TmF6V0xvTGpEUkU4bVJ2bldyRk5RczNFeDQxejdWTVlzZ1l0R3A2Ky9IVHBt?=
 =?utf-8?B?TWRzTWZSRlhaNXFvUkVFdUhSTGZ4N2ZKMGMxR2xmMlNNTVFBY0M4VmsxV3Jk?=
 =?utf-8?B?MDY1WVk0Tk1iUXpiMjFyL3I3eS9nR0VyekNiRDY2aElFU2dsaW1laS94eEsy?=
 =?utf-8?B?ck4wVDRLd1RVVUI2RmpoUHB4SkdXN1JJS2VBK2k5ejRZNXhtM0VTS2psUWI0?=
 =?utf-8?B?aS9HNzliL1pQbXJSamlJUHBJckhvNDJ4K3diYjBCUG1BelRTOXViTGlHdHBX?=
 =?utf-8?B?UG9IUGZ2YTBlMzVYMWpienczaFpPbTdmaDIvTWtveU1zaUFCdEZSRkRVcmpW?=
 =?utf-8?B?OFhQL3MvckVDRW1BN0FlYkhKNU5iTHNRaGVEWEo1T0JOYTVYKzF1TXZCc0RY?=
 =?utf-8?B?NlVrdnhGQnI3OUxyamgrY1V2V2t1dlZoZmFNT0k1azliNFp3dE1GMHVBN2ZC?=
 =?utf-8?B?VWFLWmQ3bm5XQk43Q0ZnVzUyNVRLYWxhcThJYlNIOG1EanpnQXFTenhjN3pl?=
 =?utf-8?B?VlM1c2ZRNXA1azNIRlFmaXhXZzhMRDhieGtIaVZ1ZCtZd0pyQmRUTnQ4TStL?=
 =?utf-8?B?WFRlNmNTYVE4SlltWWFycW0xM0MybkdGamFDVDV6L3RUTCsxcm5CUHVLdG5n?=
 =?utf-8?B?blhvU3pnMTkvMW1OVjFrSlNKbmx3bVhZMFlpSTdMTmttblZ2emNHUk81SGxY?=
 =?utf-8?B?UG5jWVFIOHJuYWNtUUYxNEhWK1hJSkRMYUp4NDZKOXNXZ0FQaWkvT3VzVXFz?=
 =?utf-8?B?S2ErRWNSWTBDc3FRbDRGVVBjUTB3QkpvVjRqTkZsbkxTTWxyM01vai9zWlZU?=
 =?utf-8?B?T3UxaVE4WkpoWDdiTG93MC9WRnNLTG5JOVJpcjNLMUVSNEFzRmpjTWx0T0Zy?=
 =?utf-8?B?Y1ZsRU5BVTdvMjEvWThkLzFGb005UDR5ZXZ6QXNwMWFsRDFCNTlRL2oza2pt?=
 =?utf-8?B?VC82TjM2R1gzbTB2bEpzSHRwL29sWHJqRDZnSGRreXEyYUZpYWh5TUlXTTRY?=
 =?utf-8?B?bDVrYW5FYzRCWnhoN09LbVZTVWlIMWdaODJxT0U3RGRhbncyRTkrdFFTNFk4?=
 =?utf-8?B?YUlJRGRJOWRISDUzc3B3QUdxQklBamU4UGpPSlVGbzFZQ1U4UW9ncGpFY1Nr?=
 =?utf-8?B?TzhvUFZYZ2VwRlhWUVpZdm1ZR1VoL0tFSkV6dUNiVUIzQSthdFRDcWxwNVRr?=
 =?utf-8?B?eGwrZkN3ZDlFMkE4aFViNVo0YlZuQlFjb05KVVlqM2lwWS9YM1F4bW9nc05N?=
 =?utf-8?B?Z1U2NnpoTitMVDNoSzF1dTZNMURON2pIMkgrdllsLzNZMncwVmM0K0lXOTlM?=
 =?utf-8?B?WmNYUU0xMzlNRGRuOHBGYllBVDBiR01EMnh4cGVkRXRvRXd5UjhNOHVDVTBN?=
 =?utf-8?B?VnpRVmxOc1REYlR0clhLUkFaL1lJaVE0aEpiUTZkRnp3WTcvbFpCbWUySTlD?=
 =?utf-8?B?SldGWlFnTFkvay8wR1JicnE1SnhtWkxQWTJPQzN3MHMwdjVySUJta1FsWERn?=
 =?utf-8?B?aFJGZWxsQ2N6N05mb0x5RTZIRU1ZRXVORVhSaEVhb3hXUmdMK01HK1M4WCsr?=
 =?utf-8?B?TVZvbDNFZ3lNK1JOWWYzVGhaODhNQTgvRnY0RVppUWRkY1NXWVNRU1FBZjJv?=
 =?utf-8?B?L2VRankvMmdPSjdNaDlyUUhtdTBqNEdrckx1WGlBOUM0bEdjVW5GOFlTRmlC?=
 =?utf-8?B?U0NtM3hFbWNJUXdTa3FaZHdqMXd4TEFtUHRubytjdWozQ2tFV1RrTHVJMjQ4?=
 =?utf-8?B?cmM1UkI1NVgwVkJJNmhZNEQ0Qk9oc0tnNEZMeGhsU28xMUpiZkxmT3JvNGZz?=
 =?utf-8?B?bVk5TExrc05kcVpXcWFBMU03OTRoeHlpbXp4UGtyMGlHM3FkZUZPcjd6OGRt?=
 =?utf-8?B?bitrdzlLR2UxSllNUFZWR2VRWlg2YjJEaHp5VDVVUitaWmxjSUZrZjJBTWJ1?=
 =?utf-8?B?ZGRjL3dDNEIxSVpaTEZGWGVlRTNyRGRjUElZaFhmRzNHeForTXhyTG1pam1L?=
 =?utf-8?Q?R0DtN7Jk11W97yiDixSH1eFS1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46cb3989-0581-4998-15e9-08da9c7a291b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 09:09:31.7649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7WxirAdliM24VLVgBFoM8VtEkuUUYEk6qAj25eip6GOzB0BAH8L8SLQE+TmR9dJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5936
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

Well this patch is a pretty clear NAK.

Using xen_swiotlb with userptr in the first place sounds illegal to me 
since we need coherent buffers which are incompatible with swiotlb.

In other words using userptrs in our driver stack are fundamentally 
incompatible with swiotlb, so it doesn't make sense to try o get this 
working using those workarounds.

So the real question is why are you trying to use userptr with XEN dom0? 
That won't work correctly at all.

Regards,
Christian.

Am 22.09.22 um 11:00 schrieb Xiao, Shane:
> [AMD Official Use Only - General]
>
> Hi Christian,
>
> Why should the resulting sg table be too large?
> [Shane]
> sg_alloc_table_from_pages will set max_segment field as default value UINT_MAX  to sg_alloc_table_from_pages_segment. The filed max_segment works as follows:
> “Contiguous ranges of the pages are squashed into a single scatterlist node up to the maximum size specified in @max_segment.”
> If we don't set the max_segment field, the sg_alloc_table_from_pages may allocate 2M or more continuous ranges of pages.
>
>
> For what too large?
> [Shane]
> However, these pages are called pseudo-physical pages on xen dom0, which means that the actual machine pages are not necessarily continuous.
> When this happens, the xen_swiotlb will use bounce buffer to do dma operation by swiotlb_tbl_map_single.
> But, the xen_swiotlb only allows IO_TLB_SEGSIZE*IO_TLB_SHIFT (256K) continuous pages, and the allocate 2M or more continuous ranges of pages will cause such error "swiotlb buffer is full".
>
> BTW: intel uses the same method to allocate page tables in i915_gem_userptr_get_pages.
>
> Best Regards,
> Shane
>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Thursday, September 22, 2022 3:19 PM
>> To: Xiao, Shane <shane.xiao@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amd/amdgpu: solve the issue of allocate
>> continuous pages under xen dom0
>>
>> Am 22.09.22 um 09:11 schrieb Shane Xiao:
>>> [Why]
>>> sg_alloc_table_from_pages alloc too large continuous PFN pages under
>> xen dom0.
>>
>> Well that sentence doesn't make much sense. Why should the resulting sg
>> table be to large? For what to large?
>>
>> Regards,
>> Christian.
>>
>>> However, xen should check continuous MFN pages in
>> range_straddles_page_boundary.
>>> When range_straddles_page_boundary return false, some cases fall back
>>> into swiotlb process and the continuous allocable page is not enough.
>>>
>>> [How]
>>> In fact, xen swiotlb set max_segment default value as UINT_MAX and
>>> xen_swiotlb_init_early already change the value to PAGE_SIZE under xen
>> dom0.
>>> However amdgpu driver doesn't use the value, which may cause issue
>>> such as swiotlb buffer full. Add amd_sg_segment_size according to
>>> iommu setting, the details are as follows:
>>> 	iommu setting		|	amd_sg_segment_size
>>> -------------------------------------------------------------------------------
>>> 	iommu=on		|	UINT_MAX
>>>       iommu=off && swiotlb on	|	IO_TLB_DEFAULT_SIZE(64M)
>>> 	xen_swiotlb on		|	PAGE_SIZE(4K)
>>> ----------------------------------------------------------------------
>>> ---------
>>>
>>> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 22
>> ++++++++++++++++++++--
>>>    1 file changed, 20 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 134575a3893c..d081fcd22d6b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -80,6 +80,23 @@ static int amdgpu_ttm_init_on_chip(struct
>> amdgpu_device *adev,
>>>    				  false, size_in_page);
>>>    }
>>>
>>> +static inline unsigned int amdgpu_sg_segment_size(void) {
>>> +	unsigned int size = swiotlb_max_segment();
>>> +
>>> +	/* size=0 when amd iommu enabled */
>>> +	if (size == 0)
>>> +		size = UINT_MAX;
>>> +
>>> +	size = rounddown(size, PAGE_SIZE);
>>> +	/* swiotlb_max_segment_size can return 1 byte when it means one
>> page. */
>>> +	if (size < PAGE_SIZE)
>>> +		size = PAGE_SIZE;
>>> +
>>> +	return size;
>>> +}
>>> +
>>> +
>>>    /**
>>>     * amdgpu_evict_flags - Compute placement flags
>>>     *
>>> @@ -760,9 +777,10 @@ static int amdgpu_ttm_tt_pin_userptr(struct
>> ttm_device *bdev,
>>>    	int r;
>>>
>>>    	/* Allocate an SG array and squash pages into it */
>>> -	r = sg_alloc_table_from_pages(ttm->sg, ttm->pages, ttm-
>>> num_pages, 0,
>>> -				      (u64)ttm->num_pages << PAGE_SHIFT,
>>> +	r = sg_alloc_table_from_pages_segment(ttm->sg, ttm->pages, ttm-
>>> num_pages, 0,
>>> +				      (u64)ttm->num_pages << PAGE_SHIFT,
>>> +amdgpu_sg_segment_size(),
>>>    				      GFP_KERNEL);
>>> +
>>>    	if (r)
>>>    		goto release_sg;
>>>

