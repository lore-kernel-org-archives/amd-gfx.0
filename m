Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A596CC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 10:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DE1061372
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 10:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5DE1061372
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 035EC6E247;
	Wed, 20 Oct 2021 10:15:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3A596E247
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 10:15:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpBpsXPy89LwUL90EW1okrzrAx0WJpruZn2NFrWvlZmF8qsBQXcnUjG+PQg9ZQ/x7k5MoB+31DtfXgWNB4zjzJF5xaUOUWbIEZ+3smz5lkZNKvzeorNWxSCRfZMjVoD22EEpIcUq5wBEeiXZW86OstgErGZNBy6dLss+APktovG903Jmp/P7Vbu8TkEaKiS5rnv1UjSjj/Z2ql2zq9TjKiwk3U0np8Fexn8rGbGyOjTDAs8yt0mBukAc44YBS/yc/KAOQysFAKc25XJkyz1frDAP4+OaKQ/J/0OGV8OxXGwPUst/t3zROTzw/ktQWs136kbd47q2dU/dxrq1WHAxMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDq1K75A6VYOq1iVlx7PfwlF2HZHZ4o3l4uBFvswK/M=;
 b=Q9RzZ+4zvRXgI2bByd+Q9+ZqKwVo+JgUHJK4HR4BHFeF3PIi31Y0Jh+48F366RQUHfj2tkRIqDgdTrkYztZ9QitigKB2sJGkAw7cO9yovLidQ63a3PO8uBRU1TtD1jGhDHpYR8TraC0BvdkOO741Splujh+hIp1/uKZ5pp/gVk8hVRR6z1RQIte99nxAOG7yUVkxP4kSL244RnGwAg2vyTmZOX3EMYd+96l1hjQtj4zPlggLmpQ720EaqJuC9SXZJdP3G97+j/e5WOmRe6LXysdG+mg5KbcRAoLm4AvOEZYdDQAAC9cBTdCVNKFq1u9s/UoxPBWuRExXX2CZwS2Iuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDq1K75A6VYOq1iVlx7PfwlF2HZHZ4o3l4uBFvswK/M=;
 b=H5axuW5wKyYc3inUq/eg9LvnbSziARJEOlrCiqoEq5g30vowV8BUout1hcTpBbhPVL8thQSt7T7Gj4VWOjJLzg767LmYnnoiVCGYB2KXNb3ZSnEaM1ukKR7y1zu35JwvJdKfe90C7uswaP6WxtN25XMt6PZBcJ2EGjm6+3yCQk8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4778.namprd12.prod.outlook.com (2603:10b6:5:167::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Wed, 20 Oct
 2021 10:15:47 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 10:15:47 +0000
Message-ID: <039e062b-19b5-bd36-55af-43dd437f60c0@amd.com>
Date: Wed, 20 Oct 2021 15:45:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 3/3] drm/amdgpu: recover gart table at resume
Content-Language: en-US
To: "Das, Nirmoy" <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, andrey.grodzovsky@amd.com
References: <20211019181449.12356-1-nirmoy.das@amd.com>
 <20211019181449.12356-3-nirmoy.das@amd.com>
 <10ad459a-01c3-1fa0-837d-42dfe33129d2@amd.com>
 <2715b2e9-4f7e-a356-fbdf-48006985a252@amd.com>
 <4897383c-b931-3bf5-e3c3-04ee9e3467ca@amd.com>
 <968c352a-29db-49c0-0f79-763596785be7@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <968c352a-29db-49c0-0f79-763596785be7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0077.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::17) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [172.31.158.229] (165.204.158.249) by
 BM1PR01CA0077.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 10:15:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7de7c04f-fee7-4d8e-8518-08d993b295af
X-MS-TrafficTypeDiagnostic: DM6PR12MB4778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4778BF625B93372D4DED5C8597BE9@DM6PR12MB4778.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fo4nKAEAJkBC1LMT+CI14gJ8GNvGed8sRsCoq0iQ7o/mB8sdxq2BqullbcDRy2nQ3uvIrDOdLPpS9PoXGyjB2Pl2ilozFtAn1kDsQ+QeTPss1b4dqBYwPq1HbO32/7BPVX9U6pDsUaAf1Zrj4vVBTJ4ytCosYFAQTJ4qL1z//3sw88YkX7lHSOYahGx5Lw9YwuYKN2wNx8a5RXcUL4A1EZnh6unx1bYEjCG1iqapJG/Wg4+TgExUO94R54C68WgTMrzMJkxlfA1GhuN7gvZe1uiC2+XJjt7cLPm8LsHfIteiZKJw1TcXKz4ttHePZkZHxw+ANOm2SK3BTNB3CbC30Ndduhdd8NJjdqNoCz85yJxVT4eXspaqKFKfU2n0L+ENFsJ0bmSgA6SE543Z75503RT+S0Kk2E2k2F6SItlnEpUgHdXxgbAUmqRA4ozbKoWLcz0DH+ZKGg3nN6MscNtqBZe+yqrQjq41p65qSvVwoSRfldqQM74WHDe60wFK90MjgmbcK/jpZPYdMiXPqcZ+7ncYoe6nKNsQ7W5esSSXi257w/jhj2FyuVuB8xLZlfqpCJyRODBaFCpSH7wj/SEGaQUBghUeU+0cT9a1lnWJgdmx1596paY6nbw5Vx++GFG7dLVWofb7skVjL5B9rvSlNNqEnJIMB6V3vONxzucRfnzbWEIjq77D2Nc74Z1OqOnecgIksG6X42QYfUO2kQywA0M4Ii5WdCD8Qq9vyz2NmS3i1gjkArjuuHD25yx+/9b+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(16576012)(8936002)(316002)(31696002)(2906002)(6666004)(5660300002)(38100700002)(86362001)(2616005)(956004)(31686004)(4326008)(6486002)(83380400001)(36756003)(66556008)(66476007)(66946007)(8676002)(53546011)(508600001)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDU0a3IxbXcrWWp5RXRyK3ZlTU0yOGYvQjF2NkxSMFBKWklqSGMyT3BQeGtV?=
 =?utf-8?B?b3lwMWhsVS93MUo4RWUzOWg0THdUUlZBOVA1ckdMeXVhWldyTW03dnhnSzhi?=
 =?utf-8?B?SjhsOWtLeW92TXVpa2pQY0xYRTlKM09KMlk1WW5QRkM0aGhEVjNlRzhEeDQ3?=
 =?utf-8?B?NUFPN3AyVGFibEV1azRrODRTcFZ4Smg4WWtuQlVWNFduMGR0WWQvVWQycEhB?=
 =?utf-8?B?OFN6NHlVbWlCcVhuK1c4cUlmZW5aY3VLNm1uQ1VWeUFhN1hGRzRDVTBFSzhQ?=
 =?utf-8?B?amYyVlZzellOb0piTmdVbW9WYVpReFNJOThWL041ZEZtMG9uUXRNYzZUS2U1?=
 =?utf-8?B?cE1zWDFvVU54NzVObDZNSWhrcWVKV05oUGsrYjRsSTZhMEwrb1NyeDhlWFFV?=
 =?utf-8?B?YzZSYkwzcWMvSyszb1MrVzgrdEdCQjRCam15T1RsTUVWMUthVUgxNjhPa29q?=
 =?utf-8?B?d3ZGdWZNUWFxejNDb1JabUppaWVhS3J0RXljYkI1Yy9HL1c0dVRsQjFneGJQ?=
 =?utf-8?B?bDRnVlRmb3hSQ0ZxTzlVbThoR3JWSDVjUEVmbWtTeDdMVGg1MXBmUE1FOWsx?=
 =?utf-8?B?UXg3YnVuWUZsemEyclk4OUJUMFRFZXNpaFl2dmhBWENpcUFlcUpuclorcjVt?=
 =?utf-8?B?OGlnVTJOeEFpSTFRNHgxeGd3R0JWYys3VEFEeDRqZHhBKytuVDJEN3ZCV09m?=
 =?utf-8?B?cFVhWlh2a1crMWxhY21ZSE1xQ2xQb3AwcDVxOUJsa2tPa2dJM3ovazUxWFo0?=
 =?utf-8?B?b1BlUVBJQ0lzQ0xxLzIzUEJIVjZLWUphSzNCSUVxUXZsR2FGeFNGV1ZyUjlH?=
 =?utf-8?B?aTRMdkoxYTd1ZHJmekFBdXZVWWE2NWpnZDJUeldRNk9QejhYVTJmLzdmVHMr?=
 =?utf-8?B?U2NYSXFXM0c3aDl4SW4rdHg3c2hPYVU4cGdKVWFoUHRRZ3lBaWxRVGNJRXFj?=
 =?utf-8?B?Y0Njc29nSCt4RFBSRTF1emZYc3c2R1NpYVc5emhyVTdkUWw4VThQbjY4Sis2?=
 =?utf-8?B?NkYrSE8wbW5DdHUyRmtlZG5UZEhWZHpQeHBuS2ZMNWszQXR4UjJINU1UL0RH?=
 =?utf-8?B?Y3lOc284d25PVzltL0lETkg3ZlUxUmpKanNMV2gxL1EwRnI1cWVKVkRpWGlQ?=
 =?utf-8?B?MXdmMm0vSElhUDlNZ0l0QnpycU5zSGx0eDhJN1dFc0krMUJQeGF4NFRKaHZl?=
 =?utf-8?B?bXBvVklyYStqQ2xvSTk4RHVROS9kK1JFV3ltanBUeUNYQ0dQeEYvRFFTbFcv?=
 =?utf-8?B?SS9ib1E3N0tDaDAySjdzZXVtT2RoSUxXT3IxTTRwcWpaamFsekMxMVZwaTM3?=
 =?utf-8?B?eDdlTWo0NXdiV2tJL09vY1gyWlg2elpvVTZielZleUdBYXpsSENQeGd4blpn?=
 =?utf-8?B?NTQycXkrNEs5WGkyWVJuR3N1dUkraGxFbDNsN3lVNk1sV2gyQ0FLVDR0Vm5u?=
 =?utf-8?B?L2NERXBCbnZjMjhTV2xYOWY2ZGhoN2MvR0NhMDd1dE5BM04xaXIxdU1UMjho?=
 =?utf-8?B?THAzdUxLMmd5SGpwejZickFUeEFLS0NlVXhEeFM3ejVYaURoY3JWZldSMDFX?=
 =?utf-8?B?RVh4RlhiMnBTUUFKZ1puZXNHazJMU2x0VGxkTXNJQWdvbk8vWmgwWkY5eUdG?=
 =?utf-8?B?Q05HbXQwanl1Q0NGNDNzeVFLVFRXZFpEeVBxbXcwSkV4NlJlT0djRFJIY3E5?=
 =?utf-8?B?elNUb0xWeEJLYmEwUUQyLzl2Z1NjMDBrY1dhU3NRUXpzUkdFaWdJQ0ZXVVlt?=
 =?utf-8?Q?aVj5swhJ10t6+QJbzbm4htrQ8eiLcDikFwRHZ97?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de7c04f-fee7-4d8e-8518-08d993b295af
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 10:15:47.8013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llazar@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4778
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



On 10/20/2021 3:42 PM, Das, Nirmoy wrote:
> 
> On 10/20/2021 12:03 PM, Lazar, Lijo wrote:
>>
>>
>> On 10/20/2021 3:23 PM, Das, Nirmoy wrote:
>>>
>>> On 10/20/2021 11:11 AM, Lazar, Lijo wrote:
>>>>
>>>>
>>>> On 10/19/2021 11:44 PM, Nirmoy Das wrote:
>>>>> Get rid off pin/unpin of gart BO at resume/suspend and
>>>>> instead pin only once and try to recover gart content
>>>>> at resume time. This is much more stable in case there
>>>>> is OOM situation at 2nd call to amdgpu_device_evict_resources()
>>>>> while evicting GART table.
>>>>>
>>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   | 42 
>>>>> ++++++++++++----------
>>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  9 ++---
>>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 10 +++---
>>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 10 +++---
>>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  9 ++---
>>>>>   6 files changed, 45 insertions(+), 39 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index 5807df52031c..f69e613805db 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -3941,10 +3941,6 @@ int amdgpu_device_suspend(struct drm_device 
>>>>> *dev, bool fbcon)
>>>>>       amdgpu_fence_driver_hw_fini(adev);
>>>>>
>>>>>       amdgpu_device_ip_suspend_phase2(adev);
>>>>> -    /* This second call to evict device resources is to evict
>>>>> -     * the gart page table using the CPU.
>>>>> -     */
>>>>> -    amdgpu_device_evict_resources(adev);
>>>>>
>>>>>       return 0;
>>>>>   }
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>>> index d3e4203f6217..97a9f61fa106 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>>> @@ -107,33 +107,37 @@ void amdgpu_gart_dummy_page_fini(struct 
>>>>> amdgpu_device *adev)
>>>>>    *
>>>>>    * @adev: amdgpu_device pointer
>>>>>    *
>>>>> - * Allocate video memory for GART page table
>>>>> + * Allocate and pin video memory for GART page table
>>>>>    * (pcie r4xx, r5xx+).  These asics require the
>>>>>    * gart table to be in video memory.
>>>>>    * Returns 0 for success, error for failure.
>>>>>    */
>>>>>   int amdgpu_gart_table_vram_alloc(struct amdgpu_device *adev)
>>>>>   {
>>>>> +    struct amdgpu_bo_param bp;
>>>>>       int r;
>>>>>
>>>>> -    if (adev->gart.bo == NULL) {
>>>>> -        struct amdgpu_bo_param bp;
>>>>> -
>>>>> -        memset(&bp, 0, sizeof(bp));
>>>>> -        bp.size = adev->gart.table_size;
>>>>> -        bp.byte_align = PAGE_SIZE;
>>>>> -        bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>>>>> -        bp.flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
>>>>> -            AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>>>>> -        bp.type = ttm_bo_type_kernel;
>>>>> -        bp.resv = NULL;
>>>>> -        bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>>>>> -
>>>>> -        r = amdgpu_bo_create(adev, &bp, &adev->gart.bo);
>>>>> -        if (r) {
>>>>> -            return r;
>>>>> -        }
>>>>> -    }
>>>>> +    if (adev->gart.bo != NULL)
>>>>> +        return 0;
>>>>> +
>>>>> +    memset(&bp, 0, sizeof(bp));
>>>>> +    bp.size = adev->gart.table_size;
>>>>> +    bp.byte_align = PAGE_SIZE;
>>>>> +    bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>>>>> +    bp.flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
>>>>> +        AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>>>>> +    bp.type = ttm_bo_type_kernel;
>>>>> +    bp.resv = NULL;
>>>>> +    bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>>>>> +
>>>>> +    r = amdgpu_bo_create(adev, &bp, &adev->gart.bo);
>>>>> +    if (r)
>>>>> +        return r;
>>>>> +
>>>>> +    r = amdgpu_gart_table_vram_pin(adev);
>>>>> +    if (r)
>>>>> +        return r;
>>>>> +
>>>>>       return 0;
>>>>>   }
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>> index 3ec5ff5a6dbe..75d584e1b0e9 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>> @@ -992,9 +992,11 @@ static int gmc_v10_0_gart_enable(struct 
>>>>> amdgpu_device *adev)
>>>>>           return -EINVAL;
>>>>>       }
>>>>>
>>>>> -    r = amdgpu_gart_table_vram_pin(adev);
>>>>> -    if (r)
>>>>> -        return r;
>>>>> +    if (adev->in_suspend) {
>>>>> +        r = amdgpu_gtt_mgr_recover(adev);
>>>>
>>>> When the existing usage of this function is checked, this is called 
>>>> during reset recovery after ip resume phase1. Can't the same thing 
>>>> be done in ip_resume() to place this after phase1 resume instead of 
>>>> repeating in every IP version?
>>>
>>>
>>> Placing amdgpu_gtt_mgr_recover() after phase1 generally works but 
>>> gmc_v10_0_gart_enable() seems to be correct  place  to do this
>>>
>>> gart specific work.
>>>
>>
>> I see. In that case probably the patch needs to change other call 
>> places also as this step is already taken care in gart enable.
> 
> 
> Do you mean amdgpu_do_asic_reset() ?
> 

Yes, and saw it called in one more place related to sriov reset (didn't 
track the sriov reset path though).

Thanks,
Lijo

> 
> Nirmoy
> 
> 
>>
>> Thanks,
>> Lijo
>>
>>>
>>> Regards,
>>>
>>> Nirmoy
>>>
>>>
>>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> +        if (r)
>>>>> +            return r;
>>>>> +    }
>>>>>
>>>>>       r = adev->gfxhub.funcs->gart_enable(adev);
>>>>>       if (r)
>>>>> @@ -1062,7 +1064,6 @@ static void gmc_v10_0_gart_disable(struct 
>>>>> amdgpu_device *adev)
>>>>>   {
>>>>>       adev->gfxhub.funcs->gart_disable(adev);
>>>>>       adev->mmhub.funcs->gart_disable(adev);
>>>>> -    amdgpu_gart_table_vram_unpin(adev);
>>>>>   }
>>>>>
>>>>>   static int gmc_v10_0_hw_fini(void *handle)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>> index 0a50fdaced7e..02e90d9443c1 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>> @@ -620,9 +620,12 @@ static int gmc_v7_0_gart_enable(struct 
>>>>> amdgpu_device *adev)
>>>>>           dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>>>>           return -EINVAL;
>>>>>       }
>>>>> -    r = amdgpu_gart_table_vram_pin(adev);
>>>>> -    if (r)
>>>>> -        return r;
>>>>> +
>>>>> +    if (adev->in_suspend) {
>>>>> +        r = amdgpu_gtt_mgr_recover(adev);
>>>>> +        if (r)
>>>>> +            return r;
>>>>> +    }
>>>>>
>>>>>       table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>>>>
>>>>> @@ -758,7 +761,6 @@ static void gmc_v7_0_gart_disable(struct 
>>>>> amdgpu_device *adev)
>>>>>       tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>>>>>       WREG32(mmVM_L2_CNTL, tmp);
>>>>>       WREG32(mmVM_L2_CNTL2, 0);
>>>>> -    amdgpu_gart_table_vram_unpin(adev);
>>>>>   }
>>>>>
>>>>>   /**
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>> index 492ebed2915b..dc2577e37688 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>> @@ -837,9 +837,12 @@ static int gmc_v8_0_gart_enable(struct 
>>>>> amdgpu_device *adev)
>>>>>           dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>>>>           return -EINVAL;
>>>>>       }
>>>>> -    r = amdgpu_gart_table_vram_pin(adev);
>>>>> -    if (r)
>>>>> -        return r;
>>>>> +
>>>>> +    if (adev->in_suspend) {
>>>>> +        r = amdgpu_gtt_mgr_recover(adev);
>>>>> +        if (r)
>>>>> +            return r;
>>>>> +    }
>>>>>
>>>>>       table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>>>>
>>>>> @@ -992,7 +995,6 @@ static void gmc_v8_0_gart_disable(struct 
>>>>> amdgpu_device *adev)
>>>>>       tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>>>>>       WREG32(mmVM_L2_CNTL, tmp);
>>>>>       WREG32(mmVM_L2_CNTL2, 0);
>>>>> -    amdgpu_gart_table_vram_unpin(adev);
>>>>>   }
>>>>>
>>>>>   /**
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>> index cb82404df534..732d91dbf449 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>> @@ -1714,9 +1714,11 @@ static int gmc_v9_0_gart_enable(struct 
>>>>> amdgpu_device *adev)
>>>>>           return -EINVAL;
>>>>>       }
>>>>>
>>>>> -    r = amdgpu_gart_table_vram_pin(adev);
>>>>> -    if (r)
>>>>> -        return r;
>>>>> +    if (adev->in_suspend) {
>>>>> +        r = amdgpu_gtt_mgr_recover(adev);
>>>>> +        if (r)
>>>>> +            return r;
>>>>> +    }
>>>>>
>>>>>       r = adev->gfxhub.funcs->gart_enable(adev);
>>>>>       if (r)
>>>>> @@ -1793,7 +1795,6 @@ static void gmc_v9_0_gart_disable(struct 
>>>>> amdgpu_device *adev)
>>>>>   {
>>>>>       adev->gfxhub.funcs->gart_disable(adev);
>>>>>       adev->mmhub.funcs->gart_disable(adev);
>>>>> -    amdgpu_gart_table_vram_unpin(adev);
>>>>>   }
>>>>>
>>>>>   static int gmc_v9_0_hw_fini(void *handle)
>>>>> -- 
>>>>> 2.32.0
>>>>>
