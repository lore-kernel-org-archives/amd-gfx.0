Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDB6C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 06:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 693C210E30F;
	Wed, 11 May 2022 06:15:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4187C10E30F
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 06:15:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHFd5c+5vgnGgDg2ocJvpH+xQbrJ5gNJNynkQY4v4ADY49buS+qZGNv40W1nILr0mcSoY4fN+y+mFN5ULa0ZOYpD1FhDC6WE/X+sGMVx7uBfxUax5bFI2AArmn5qdoUBQJljTQab0M2g1U3+WlzRzBuhlkDxJr01mrMg+kKjX0Hj/Mz0WxmtLJhkBFn4FIsJMt33fdn5HIHp6VH/ypTcOuvhauO4EZl/jBr6+y4taAutOveLAsKRwzC2ex7w1McT0X6flW4seWUS2Ql1Dz7h6PN3zks7iUcOPg76CEg3padLuSHaRg5R1ND+PGJqwK8s91eOR1L/twuBJbMw+Sy7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cu1lmB7EKDKRAE6/j5CiRSXlezYbfVbu4jgJGTu0MKU=;
 b=Chkud7MdC/xqaaLrCFIk88Gr6u6gYdfZNsLJWBPbbO+HkjVWgsTExMV9M/V+rCdlk/qx0n+293TGCemnA9AJtE4T1fakvSNGIgxjapzv8dnucEeIizIa2zr7HmhufPSmZgRfXo+kCUBRJYQvZkC4IKOFDpT8Omt9DTYRTHiwebC5loIT+waGvPfbKrAJ9V9D6DWxkxcUmgFK9tbgLzV/SR37Rt9smT+5q/8o3qy8jaPaoHKBUjFKxSUs+cUGo7bjucRtN8MXMiry9ofZhqsGfFsc07cq5YxqTA7UZvpLeyz2/+xVDSBWWzLbsls3VehNpAv//uQmWmiwAOz6F669kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cu1lmB7EKDKRAE6/j5CiRSXlezYbfVbu4jgJGTu0MKU=;
 b=XKR1Z09qRjofXNyAgQx/z4NMCI8BgzLtDZSA0yQpWEtos/FwTyhuaibyjSZGsnlMsByOezVL50T/mfgm2L/PkNdXI2fVzQGabafoUSLLSp7g9xIw1tg97H+fY0t22OMbuMvP6MVlBOQxSpQjIWVjMD8txcmHFZFAfrhx0RoGukE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CH2PR12MB4021.namprd12.prod.outlook.com (2603:10b6:610:2b::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 06:15:15 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f%5]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 06:15:15 +0000
Message-ID: <5941d83c-6d2b-6e3b-bd5c-b22779929d5e@amd.com>
Date: Wed, 11 May 2022 11:45:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/3] drm/amdgpu: add AMDGPU_VM_NOALLOC
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <20220506112312.347519-1-christian.koenig@amd.com>
 <20220506112312.347519-2-christian.koenig@amd.com>
 <CAAxE2A7+-MKrh1BoXhGNBY38_7PkvrmZvn-tg4-4CFNXBvdKqw@mail.gmail.com>
 <8695802e-6835-a717-c0ee-83b76d8a8875@gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <8695802e-6835-a717-c0ee-83b76d8a8875@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::13) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c888d11-e40b-4c9a-6dac-08da33159d05
X-MS-TrafficTypeDiagnostic: CH2PR12MB4021:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4021AD3DDA67DE4A15AE336097C89@CH2PR12MB4021.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s0dW1BbHlJu0SLBkg0CUjuO7iDKQHatwZm4QJAHW2lWp7bJ9XrZqbnYGHIvIgeFnjp91K2ho4itSCYdEDgNIBSF2ZladYfG4MQsxI9pBQIBoGgPjkbMCGuvDR+KmLKs54vjgf0hv5kJvuk95DaEeywDmG8uyXOBWBskoOZhOwiV2U23tjAAI6D9lJAM3cu6hSdWhAORgZBif1BC7P6Ra6lsP0X+wmmptZeJYa4dG4cOIqtDRDgxb0AssyBlEBJH+g+u2mQNcfWixMrGDfy+FTKg3CWCuQ2MtCH73j4LQjYnUnnFJhJG352ebpn/IOp+G9nYR8oE8es/yqo/Un2OjzMCC65QdGbmPOpnR+kgZDS2s1AZ0mzHvEauxpIkFlhDpiUJQXsUp8ta549vfUkZ+y7ix2s+Zq/J/pBFphJExhTtuQyhygB0djUpOu7mO30CZRESXeQuW2a90ylsdgigWZFXvlLmYpcawniyuEUfjw61GnjyScX/C2i6dOrQDMF8RHy0gsU5BoxpGpGOdUhxMVFe/780pl01fyJtkEr4a4b68b/mv9aJg3vJw7w+8wKiPUpd/w74liEoACZLJlUWepXrtyYSGfXqHHpVgg8ldVI6cpUYIj/GwgDfBjjqB/y7ELYM8wnSySvN9xJpVO+XLxrrtmshVH4KVfh5wkJV2bh0DOpGJg08+sLX74dneuv8D3NqD8Q7phHM7RkuGR9quBY3pPd9QmH5CJvoPUoxeqMAdZgrnUjxg51al2yPTwUs6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(6506007)(86362001)(6666004)(53546011)(8936002)(36756003)(38100700002)(66946007)(66476007)(316002)(66556008)(110136005)(4326008)(8676002)(31686004)(508600001)(2906002)(6486002)(31696002)(5660300002)(6512007)(26005)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2lLU0J5Y2lNdFF2S1dsMk5sZVg4MFBiQ3hlZU5qeFYyQWRreHV6Qk9XeDQw?=
 =?utf-8?B?YnhoQWNkUUd3VHgrelM2N2N5Q2FiMUFWZmcxdzE0ZnhkWG9id3lxWmgyWGU4?=
 =?utf-8?B?Wk1aWERWT2lwYXI5NnprWTcrTmhKanI3VzU4MmtzeUxWVkZ2RUZ4VHhuam85?=
 =?utf-8?B?SUxQSWhmSkM0TzZYWUZNanNXeHJQcXBkK3FINTR3S0pCRDJlV0pCNHRESXE0?=
 =?utf-8?B?WTM0WmRNMHBkRE52Qy9NNlNkTW9qSmhmdmJYUWwyTytjR1Z4blgzWWJxVmlH?=
 =?utf-8?B?S3NSWFBBQnp2bVJnRnpiMmNwTnJyaDFWWFJSUTBCZDluV1ZySm55NTU5TEZZ?=
 =?utf-8?B?dDVMaklHTHUzOXp5UmYvSGxQWHo2Z3Uvb0RQQmJFdUg0a2JGM3R5dTZaUm5N?=
 =?utf-8?B?bzV0R3g4ZDRGTUkyN2Q0RURnUGNrRHpQQUlTbnVCUGdZOStXd3dHTFdnYk01?=
 =?utf-8?B?SUtrTC9tWjNOWnhqUWVVOWhkdEozWjhzZUI0aGVRaHNLcTdvbTFTbVRTSXpD?=
 =?utf-8?B?Y1d2eXo0K1dWK1ZDcjYzamtHSElMN0VhV2ZvYTNqdDBqQ2hrRGIwdnNXeGVu?=
 =?utf-8?B?VjU5VWkrTXR5RytGemxIWVd1TU5VM1NuOWsvUjFHYVo5cGs2VFFrUmU5Y3BB?=
 =?utf-8?B?Z1lINEEvMVhONXlSMExqSUsrb1Q1YmJINmg4c20za1AzeHdTODErWGx1Mmd6?=
 =?utf-8?B?SGo5bExhOWIrelczZDg3RWE0ZklvMkpsTTBTSkRDblpoYkU2Y2ZXaExOYnJ5?=
 =?utf-8?B?RThtWjZiTzcwaFY0NFc4bHlYS05SRkhuSFN1d2dyVjJwejlCUVQyMHFhNDlJ?=
 =?utf-8?B?cStjaUtkLzltdkgrcUVoOVdQZ2daYVJlL1htWE9KYU5BVEI4MVZxSTNpSVZr?=
 =?utf-8?B?SllxRHZCNkYyd01nYkMvcGV4OXZTUnFZazM1SXR6ZkQ2TlAvaWkzZDI4YVZP?=
 =?utf-8?B?NVA5RHFvdjZ1bXp1VmtWa2d6NXdXMVJaMTBJamtMZFFOMWhuQytINUk3WmEr?=
 =?utf-8?B?ZmNZMnpPbmVGZDg3SVVNeVBTSTlmU2hTUHVDSVlMdHpzd05qRnRNdEpiRlNS?=
 =?utf-8?B?NFBNOXFhRENNWmRlOUdVbXdDM0M4b2tsR1VFZGZ6YzZtOEZwWjU5YXVQamg2?=
 =?utf-8?B?WGFNcnBsMlBadHUrWVpGY0huMzRJQS94UlM4R2VBekRVVHYwTVFtMnZVQ2ds?=
 =?utf-8?B?S0FPNWJDSUVnVFlEUzJyYVpxdThnbktwMjcxemYyTzhrcDN3ZXhYQ2VJWkg3?=
 =?utf-8?B?ZkJPQnpkT0NnVC9tU1BqZEZKZWYyRzRpNWhFdmUyR3VUeit5bTF3L0Q3dHQ0?=
 =?utf-8?B?cWV1V0NpTTlReFc4Y2p2SW5xaXowU2dTVHQ3Y2lyS3dKb3V3YlFXaitHQ0h4?=
 =?utf-8?B?ZWtiTHVTRWZQT3pPTExkSXZpK01vQ2o2MUtEcHRHdlRjZTlJbzY1N1VZZ2NF?=
 =?utf-8?B?dnFGZDI4Qm1WQ1dsQmNYWTJOY2xlZEdvVkVZVzg4UGJyRnFDV3RjTm1kazA1?=
 =?utf-8?B?RVNWdlpDNmc1a2VXK3Q5QklKcUNGd0hDZXhzVjdXRWhLbmNWNWxwQzZhelRq?=
 =?utf-8?B?WFdqRSt6REVoVHZVcjdJUnRsVjI5RWg4SmtwdU41ekdDeHltUTRlTHNGZ3JC?=
 =?utf-8?B?d2FWdVExNWlNZ1FBRXBPeWZ3T0loc2F6S0RwQ2I5K2xDRVFPY2xKUWtoaU5W?=
 =?utf-8?B?SHhrRXVJN1JqY1ZtNG95SVhabWRQK3MzSkFWaTc4MkF5QW1aNW9KaDQ2KzIx?=
 =?utf-8?B?ejZ6UVQ0TzlIdHdzMnFSNnN4MGNvZGN3dlF6M3RNWW9QUWhPT0l4TXJpTFc5?=
 =?utf-8?B?UWlRTkFQNmltWU1HM3BCRk5lSERzamxaanQvK0JTcTlvQXdmRitSZkdnVDFL?=
 =?utf-8?B?eXFodzh0QTFVbUJvaWFjb3J4NFFhTUtMQnNHMWZwczNtbUIyQ0hLOWVCU3FM?=
 =?utf-8?B?N3V6TnFBeEVZcXV0dFg0YlJsZlBTNjAydHJXZzhOTGljWTVwSnUzaTkyZjRu?=
 =?utf-8?B?NCtTVW8rRmRtd3J5UEpDMHpad3hPWjlBbjR1dVBOcTB6elRKZHBsMTlKeXBk?=
 =?utf-8?B?S3hTU1pSOHdxZU9aVmxKditjUUZ3ZHV3UmtDTm9EUTBzL3Z3cFJuYWtQRERT?=
 =?utf-8?B?YWlwQTd0RSsybDl6UkRERmxDSmE1MFRQQkRoc1VHdlZuUlg5UnRLUERaZ3Qw?=
 =?utf-8?B?YUhDNzdjRUk4RnVvRDkxZ1ROb3M2bEQvQ0lOSjZrQ2U1M0FscGZsRTJEeFV5?=
 =?utf-8?B?b01oZXQ5dWJrUEwzN3ovQ0llMGhvVDFwVFQ1MzdHL0R6UTVHZW5uQlk1dERR?=
 =?utf-8?B?dFdSRHRmdFVkUFJKeDQxT3hWTko1Ri9EaDA1MmtjT3lNT2wwczJyQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c888d11-e40b-4c9a-6dac-08da33159d05
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 06:15:15.1960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJBMTIS21f32tj85l2P7U/S4cA3wOOzrIXKFGlDmrvXf/u4K9sNd9gDPUSx7uWKt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4021
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/11/2022 11:36 AM, Christian König wrote:
> Mhm, it doesn't really bypass MALL. It just doesn't allocate any MALL 
> entries on write.
> 
> How about AMDGPU_VM_PAGE_NO_MALL ?

One more - AMDGPU_VM_PAGE_LLC_* [ LLC = last level cache, * = some sort 
of attribute which decides LLC behaviour]

Thanks,
Lijo

> 
> Christian.
> 
> Am 10.05.22 um 23:21 schrieb Marek Olšák:
>> A better name would be:
>> AMDGPU_VM_PAGE_BYPASS_MALL
>>
>> Marek
>>
>> On Fri, May 6, 2022 at 7:23 AM Christian König 
>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>
>>     Add the AMDGPU_VM_NOALLOC flag to let userspace control MALL
>>     allocation.
>>
>>     Only compile tested!
>>
>>     Signed-off-by: Christian König <christian.koenig@amd.com>
>>     ---
>>      drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 ++
>>      drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 3 +++
>>      drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 3 +++
>>      include/uapi/drm/amdgpu_drm.h           | 2 ++
>>      4 files changed, 10 insertions(+)
>>
>>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>     index bf97d8f07f57..d8129626581f 100644
>>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>     @@ -650,6 +650,8 @@ uint64_t amdgpu_gem_va_map_flags(struct
>>     amdgpu_device *adev, uint32_t flags)
>>                     pte_flag |= AMDGPU_PTE_WRITEABLE;
>>             if (flags & AMDGPU_VM_PAGE_PRT)
>>                     pte_flag |= AMDGPU_PTE_PRT;
>>     +       if (flags & AMDGPU_VM_PAGE_NOALLOC)
>>     +               pte_flag |= AMDGPU_PTE_NOALLOC;
>>
>>             if (adev->gmc.gmc_funcs->map_mtype)
>>                     pte_flag |= amdgpu_gmc_map_mtype(adev,
>>     diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>     b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>     index b8c79789e1e4..9077dfccaf3c 100644
>>     --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>     +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>     @@ -613,6 +613,9 @@ static void gmc_v10_0_get_vm_pte(struct
>>     amdgpu_device *adev,
>>             *flags &= ~AMDGPU_PTE_MTYPE_NV10_MASK;
>>             *flags |= (mapping->flags & AMDGPU_PTE_MTYPE_NV10_MASK);
>>
>>     +       *flags &= ~AMDGPU_PTE_NOALLOC;
>>     +       *flags |= (mapping->flags & AMDGPU_PTE_NOALLOC);
>>     +
>>             if (mapping->flags & AMDGPU_PTE_PRT) {
>>                     *flags |= AMDGPU_PTE_PRT;
>>                     *flags |= AMDGPU_PTE_SNOOPED;
>>     diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>     b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>     index 8d733eeac556..32ee56adb602 100644
>>     --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>     +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>     @@ -508,6 +508,9 @@ static void gmc_v11_0_get_vm_pte(struct
>>     amdgpu_device *adev,
>>             *flags &= ~AMDGPU_PTE_MTYPE_NV10_MASK;
>>             *flags |= (mapping->flags & AMDGPU_PTE_MTYPE_NV10_MASK);
>>
>>     +       *flags &= ~AMDGPU_PTE_NOALLOC;
>>     +       *flags |= (mapping->flags & AMDGPU_PTE_NOALLOC);
>>     +
>>             if (mapping->flags & AMDGPU_PTE_PRT) {
>>                     *flags |= AMDGPU_PTE_PRT;
>>                     *flags |= AMDGPU_PTE_SNOOPED;
>>     diff --git a/include/uapi/drm/amdgpu_drm.h
>>     b/include/uapi/drm/amdgpu_drm.h
>>     index 57b9d8f0133a..9d71d6330687 100644
>>     --- a/include/uapi/drm/amdgpu_drm.h
>>     +++ b/include/uapi/drm/amdgpu_drm.h
>>     @@ -533,6 +533,8 @@ struct drm_amdgpu_gem_op {
>>      #define AMDGPU_VM_MTYPE_UC             (4 << 5)
>>      /* Use Read Write MTYPE instead of default MTYPE */
>>      #define AMDGPU_VM_MTYPE_RW             (5 << 5)
>>     +/* don't allocate MALL */
>>     +#define AMDGPU_VM_PAGE_NOALLOC         (1 << 9)
>>
>>      struct drm_amdgpu_gem_va {
>>             /** GEM object handle */
>>     -- 
>>     2.25.1
>>
> 
