Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C88C54EBC
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 22:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3334D10E039;
	Tue, 10 Jan 2023 22:32:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77C4910E039
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 22:32:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xs9tLxOIDvBX7iCvou+6C5SpwqCghH3r68s4GoR5Fs3P7tipoTQePuWTG3vyIfrqnnR4XNk88O/nwcEnyqX+eeamdsTR7cRCYxvLECsABl4+xH4UaSeJpf62oKFYrEvzH8/bc8LhUi6D38Tp571GqhsoCP2+JTyHTD01KdIxA7vXEWTSRhOiqHoJEaHWoiWESlKjJsM1kBumH1BCHnLTubSgruk6XSggf1JRsHiqAcczhC+dlpFcMpW3qcARyViF66P+acb0abXmHy0A0IbesYRaMFi90kfxVaEDuXQVsaP6650tyD1/UrlETalvaQiKcBW0YTcia8MjrzPv0v6A+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGTrSi12OHh71NPibyCSm0IzqMylD4VixeRUj6yUoWc=;
 b=CcCeJArlyOg9TarjEoQeJchSjRF7f4k7QZOuTH6wruj4Nw51Y02+CgYaOgOhtHaEyYWKLWKQkEnfhb1qnYJXj/AbZ4Qh+yOhQoRrusgha24e+u2uFI2ny0bd6lVlkpoqKpSerqH43ujUcLT07MzPkNzi6R4oDchTasjhT3YYZijZloiwCzZGgVokESv7VGWEqtMybCj/fve0yPZhaJpmFop7GL4Yf/2Nfdb6Ldheu51bmefgDR9q+9mHgs98BIp/O1AptV3MGvmhWeRNYzowQWWtblXSeUCcjDV/V9r5iw/7ewNZNtezAN1dRZvjs7IX7HrKZXHj1aALRvx8d77/lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGTrSi12OHh71NPibyCSm0IzqMylD4VixeRUj6yUoWc=;
 b=IjdJakZJFWHWFkIfemKQ6mHek/6mfKGWv4cPNqu0B+iSITPMj/6JrEC+3lQCd90XqP7vZJ2j2uOOcCEAg3NzcOj+5NhlLHgFUZhEAvIgwUpIMtEIKNp8D08e//C7XfehXIhSREcr5U5I08o56mELFoSTS+HSgTmOA5O5Vkog4cw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SN7PR12MB8170.namprd12.prod.outlook.com (2603:10b6:806:32c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 22:32:15 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::82c4:6898:1cf7:12a1]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::82c4:6898:1cf7:12a1%9]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 22:32:15 +0000
Message-ID: <aafd6bcc-89db-a4de-562b-6aabf11fea04@amd.com>
Date: Tue, 10 Jan 2023 17:32:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdkfd: Page aligned memory reserve size
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230110000112.29730-1-Philip.Yang@amd.com>
 <20230110171122.10380-1-Philip.Yang@amd.com>
 <d5d4c442-e7d2-5319-56b5-6d41edb9f375@amd.com>
 <a554f4d2-3d0b-3c5d-c010-047f5048753c@amd.com>
 <f29c55f7-f472-7c1c-abec-b82407d3b304@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <f29c55f7-f472-7c1c-abec-b82407d3b304@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::16) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SN7PR12MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc61682-f8c4-4d20-958e-08daf35a8617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/Kph4cctZeuNzokjqjAjr0z8BUA5bcN7zQp+YvXT9MHBFKNm9hNc4qTymy7v+V0n9g8hU8C84qTu2mqViX9/tGn4nfSFWxWnl05ZNXgO53X5JIkiUo/ctcW08Kq9p37Kl0AJka1C343qC5e3tiHLzIenrC5+zSUPeqIBJPv0f1xCGAZ2NiGS2LNpH0JBA7xvt9qvYXrcOqQWO0gjjc5PXyfqTCxD+QIo9qycA8ZOMhXJNwf/4Ow0j4/IdqWE+njSscwYB3dQQ/sODAjyI5LJNnp0J8I2E+vJK0gZgZr7SeLLLT4nu5pBpA1W73S57buMgbcMy+K52ro1gbGQ8MnPbhZ+ZS9TN0KjQBzRgCy73vHRE9405hMaNMGchKCB3BlRduOZNGQ6en7F76xbH9x9GxDlSwuNQU1Ec1MxOGv0GNXphR/ZJxOEKDIzUbyaYbELIlIDK7BwxWTEyyeO71cy0+x+5mBdKMz5F3i50u9Qgxj7AU2Bm1I53bpxLqPddxf4bazx0TaJJxxALxcrHXIjFHa5/xAeV7dY2FO1kfSnMj75kBnOYzErZ5i5BMV436CJKB3Cr32pJ+ZrHh4G2iVgSNvh2KlgmGpKhoFaVvXiZk9iNUj9idXo4Gmxz3VJ0YARfQ1RI3HV4K7FFI9rtsgSUErgD/6KUiKFu/e8ykhtjiJKLL//SAcwS6dGxPg8PeAA8Mf7MOBUrUVLH9NF6aKUO1rkktvfQdFOYhFS4MEcSs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199015)(41300700001)(2616005)(110136005)(8676002)(66556008)(36756003)(316002)(66476007)(66946007)(83380400001)(31696002)(8936002)(38100700002)(5660300002)(2906002)(31686004)(6506007)(53546011)(6486002)(26005)(6666004)(186003)(6512007)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0N6RDI2ZEZ4Ync0ZXlhQ2tWbDhQbHB3V2JyZVZmandCU0lpQ0EzR0pBV01R?=
 =?utf-8?B?ejk1b3BYTjVNOFZrcWpiUGFUU0tmV3ZDOVZrR2x3Q3hHQzNob1VHbkp5dnM2?=
 =?utf-8?B?bmM1QVFUczlYclRtUFdCWldJVS92bXYwQjZkM2hxSmVnRkdjVG1mU3ZCam9h?=
 =?utf-8?B?R1Z1SmsyMHZabjBmbU5SQmlFaitqNVNnV01JRGk4SnkrS1BmUFBBclF4ZWJV?=
 =?utf-8?B?bG51YUdBU1R0TVMraERPTzhXemo3T3JqNmF2eDI2TEo5dFZGUE0wTVJoOHdL?=
 =?utf-8?B?NStUWXBwdHoyMWcyNTFJNTN1aGd3VGg3TGdvY0N0WnNibnlTbDNocGwyVFM4?=
 =?utf-8?B?TmRzUk96WXFsQmZwanFrczUvY29HMEE4NVZNSEF5aGZDaVJJSlRMWXZGR05z?=
 =?utf-8?B?U1ZKOUg3R3RnQk03RXNpdVNYZXh2MU8vNXkrN2ZTWm5SOTd3SDYwRG9NOUE4?=
 =?utf-8?B?clJ4UjN1bDdaWkpzcG9aQWN3UUw0QndOYXZ3SHdWcW9VNWNzOHZzMm44WERi?=
 =?utf-8?B?bHlqMFlVMWY1aDRNOFNqMWxnRWNYOEdSaFdzV0NBTEhyVngvWWFwMlZwWkpK?=
 =?utf-8?B?TlhMZm05RTcwc3RoTGN0VUQweDUwYTF5Z3JzcGV6N2I4SXkzQ0FyNU5MLzJM?=
 =?utf-8?B?ckwwVllOVUp6TXpuanhYUVBGQUpCVnl6NWtvQis1THZOc25OWVRHVFZ6eUVT?=
 =?utf-8?B?bWowTk1XS2cvZXVmNFdmWTNKMFJMYXAwUlhUN2JGMzFFZjF0ZzdNZ0FNSHJ2?=
 =?utf-8?B?S0FTbjZEUW4wNE9QOEhyVzdSRWtEeWtUdHhueGYwQXVicmdWdXpEYmlqbnNo?=
 =?utf-8?B?alk4eW9Lc28vbDkycGNoY3lsbWFrdTRjQkF6dVlaWVMyL1FOeTl5RXNOdSt6?=
 =?utf-8?B?M1F6cHAvcjYrZjVkb1hybGY4ZXJFeHp3NkgyNkNrUEVvcnhOZjluYXJBV3Fp?=
 =?utf-8?B?Tlc1ckxuZlRMdGFlS3RHMWlqcVZmVlVrcTgwOHZQblRxRkZNdEZwWkhiZWNZ?=
 =?utf-8?B?ZFRWRUhTTXFzY2RudmdGZ2l0YmtVR3lEd0pHTW56Q3hRK2M3MHRNSmpmZWty?=
 =?utf-8?B?Rzg1YzV5bU9ZTExLRDRWbk14TW9jY0ZFdUFQUzFYazFvN2dUc1FKVW1tSytp?=
 =?utf-8?B?YUx4K1dVWEQzckl2WlNIditGNTlVcHcxWlhjcDV6RlFBUkZVa1FmY2dVQzlM?=
 =?utf-8?B?RHQxbDIvUEowZkU0bUVJcnJmTWFqVkk1U01hb2Rwd2JITzZUWEZUdmhoVHVJ?=
 =?utf-8?B?amh4V3dXdjEzR3JYeXRPSUZCbVlkTjlIYjh0dHc0S0dlRXZIbEd4eUp0V1Na?=
 =?utf-8?B?Z3lnTk9mcms0emFHY1BJL25QNENNbkhuSmNVYWk4VllEUGplT0lYK0tFM3Z5?=
 =?utf-8?B?bUU3NDZXV1o1SjNkNG53dDlQVW9qTzVtNXZkaVJuby9ReXlwTTdjSkVTTjhV?=
 =?utf-8?B?TVkvcmpFTUlyaGJlUXhySk1vMEhROEFwRXBmazl4T1dqZWZtRkFwTGZQc2RR?=
 =?utf-8?B?Qm5ReFJJcy9Bdm41ZXhMWlF3V3p1b0E5Ykg4M3dETjhxVWRuQ3hXQ2N3eG1V?=
 =?utf-8?B?ZXUvaWpvUFllcStlcXRPUitSaVk5MXNaMGs5djd5a2ZpOGtCS1pNb21WZ3ZK?=
 =?utf-8?B?ZU5YRVdOcEloNGd0dUJRR3pwTHRtMnJuVWUxOTJkRTAvZEZwOW5Bd1Z5eThp?=
 =?utf-8?B?WTJ4c2Z5K0NEZnRxcVdqOWhRc0doYm9VL0sza05wcGVBK0hwUzcwZ0VONGVU?=
 =?utf-8?B?Wm9wa0Zjcms0Z3JPSjlzM1oxQXZZUmNTajZXVzJwOTU0MUxxR08yd0NOcG82?=
 =?utf-8?B?ZUJOd0J2b3pLc1VUb05tclZjQzFHWThtMEo2UlB1dHBITy9XN1NDamVXaXhp?=
 =?utf-8?B?b0FQSEczdDFOYXhCTjBWK0l0TjJ1cU45RnpCV0RnM0g0U2ZqQ1hPcyttVG9T?=
 =?utf-8?B?TEFlczlvWURSN01oaWJkY1Q5NFVOTkRNNFJnQVpZT21UdkFnVTNnV3ZPR0Jr?=
 =?utf-8?B?ZTZlTHlqNWR5WmNBMDlwQmdLOWJJc2lkZG5hdmpFd2ZSYm1RT3k4a2dtY2NM?=
 =?utf-8?B?eVVVYWFQTU5jTW9rWG05QVFNQUhZcmhDMFJlUWwxVXdJcUVPZDlQakM1S1U0?=
 =?utf-8?Q?1xJs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc61682-f8c4-4d20-958e-08daf35a8617
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 22:32:15.2238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PieSbq8y+WCjUef2GXApNLEK/DUaLhX8K8ewwJlJcO8UKlkDN1YI3J1C4JvAo5P0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8170
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


On 2023-01-10 15:49, Felix Kuehling wrote:
> Am 2023-01-10 um 15:44 schrieb Philip Yang:
>>
>> On 2023-01-10 13:33, Felix Kuehling wrote:
>>> Am 2023-01-10 um 12:11 schrieb Philip Yang:
>>>> Use page aligned size to reserve memory usage because page aligned TTM
>>>> BO size is used to unreserve memory usage, otherwise no page aligned
>>>> size causes memory usage accounting unbalanced.
>>>>
>>>> Change vram_used definition type to int64_t to be able to trigger
>>>> WARN_ONCE(adev && adev->kfd.vram_used < 0, "..."), to help debug the
>>>> accouting issue with warning and backtrace.
>>>>
>>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 +-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 ++++++---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 7 +++++--
>>>>   3 files changed, 12 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> index fb41869e357a..333780491867 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> @@ -97,7 +97,7 @@ struct amdgpu_amdkfd_fence {
>>>>     struct amdgpu_kfd_dev {
>>>>       struct kfd_dev *dev;
>>>> -    uint64_t vram_used;
>>>> +    int64_t vram_used;
>>>>       uint64_t vram_used_aligned;
>>>>       bool init_complete;
>>>>       struct work_struct reset_work;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> index 2a118669d0e3..7efee672bc41 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> @@ -1598,6 +1598,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>>>>       struct amdgpu_bo *bo;
>>>>       struct drm_gem_object *gobj = NULL;
>>>>       u32 domain, alloc_domain;
>>>> +    uint64_t aligned_size;
>>>>       u64 alloc_flags;
>>>>       int ret;
>>>>   @@ -1653,13 +1654,15 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>>>>        * the memory.
>>>>        */
>>>>       if ((*mem)->aql_queue)
>>>> -        size = size >> 1;
>>>> +        size >>= 1;
>>>> +
>>>> +    aligned_size = PAGE_ALIGN(size);
>>>
>>> Why do you need a new variable for this? Can't you just update size 
>>> to be page-aligned here? Is the unaligned size still needed anywhere?
>> amdgpu_gem_object_create ->...-> amdgpu_bo_create needs the original 
>> size for domain GWS etc, as the size is used as number of pages, not 
>> bytes.
>
> I don't think GWS is ever allocated through this code path. This type 
> of memory is not exposed in the KFD ioctl API. KFD allocates a GWS BO 
> using amdgpu_amdkfd_alloc_gws.

yes, as size is used in pr_debug, it is better to show the original size 
in debug log to match application, also notice the pr_debug size should 
base on aql_queue flag, will send v4 patch with the fix.

Regards,

Philip

>
> Regards,
>   Felix
>
>
>>>
>>>
>>>>         (*mem)->alloc_flags = flags;
>>>>         amdgpu_sync_create(&(*mem)->sync);
>>>>   -    ret = amdgpu_amdkfd_reserve_mem_limit(adev, size, flags);
>>>> +    ret = amdgpu_amdkfd_reserve_mem_limit(adev, aligned_size, flags);
>>>>       if (ret) {
>>>>           pr_debug("Insufficient memory\n");
>>>>           goto err_reserve_limit;
>>>> @@ -1725,7 +1728,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>>>>       /* Don't unreserve system mem limit twice */
>>>>       goto err_reserve_limit;
>>>>   err_bo_create:
>>>> -    amdgpu_amdkfd_unreserve_mem_limit(adev, size, flags);
>>>> +    amdgpu_amdkfd_unreserve_mem_limit(adev, aligned_size, flags);
>>>>   err_reserve_limit:
>>>>       mutex_destroy(&(*mem)->lock);
>>>>       if (gobj)
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>> index 6d291aa6386b..e11451100a20 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>> @@ -1127,8 +1127,11 @@ static int 
>>>> kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>>>>       }
>>>>         /* Update the VRAM usage count */
>>>> -    if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
>>>> -        WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + args->size);
>>>> +    if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>>>> +        if (flags & KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM)
>>>> +            args->size >>= 1;
>>>
>>> This will return the updated size to user mode. That's probably not 
>>> what you want. It may be harmless, but technically it breaks the 
>>> ABI. It would be better to use a local variable for the updated size.
>>
>> Submit v3 patch to fix this.
>>
>> Thanks,
>>
>> Philip
>>
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>> + WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + 
>>>> PAGE_ALIGN(args->size));
>>>> +    }
>>>>         mutex_unlock(&p->mutex);
