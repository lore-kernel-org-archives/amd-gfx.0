Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B549DC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 15:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FE1D10E740;
	Thu, 19 May 2022 15:14:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E39710E6A9
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 15:14:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJh5/IwaEZ2HZdjwG4CbndE5umehk1IlbzuOyv+LQrOuRv3biksWgUcgID0yNiUlS3kg9Xee+iDqnCgrIi/qvtLH1oZpYArxOFpdZd88TgIuWNrkGfBtGXoWtCjltsrkjKymMtJsWysZkgFWEHJpf2ni6/5366U2G3p8etH8wcaIPakfwGieSgQFm2ZZyadeY32Fdyki6MJH+/E3b3r9utQjsKqHyreyRvOFSRR1maIVPF9GKW/H1GW4G02F3W684utZuaB46r+UiFMZ6ggeSARBofe9Pwg6fYz7h8MeOyUwvLYPWmPrA8iM/Mhh/y4TOr6KKzwO9RJyEluRNLiFPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iP5KBFq1rWQW5EwF+RMO/gUCAZHq264G+k5y/zEdoSM=;
 b=JzVmoI0h9fXOUGvuEjGDYWPBwbN4PInvj/gom7t5PLHyzeyCfCCdPLehpbBgXmWv9+j+2pN6xTsaDBoO3inlduxF6ijghPaPaYcrtAtjUOX+QFUp7j9GVuGEdXz9avqJ9wZi05KCTWAqxFiXd74k4NClKCl9b2UGYg7PCFEjl7jS15FW2uO9g/e2lKcsXbQ4nqrUUQ1lxHwXLyu1mNdG/lnw476Ksyr9bEGLzV4oNJoFfikPa0jqO7juIEO1WEkEDlmNCTLjugLKNMvhj5fFGJvbEzjsuv+t4hGjPdMyQkb7gFySDtcpjJD7MsEBgPCpN2rfZr0lgDMDjn6R71c2sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iP5KBFq1rWQW5EwF+RMO/gUCAZHq264G+k5y/zEdoSM=;
 b=znXEN6/fLSZ6en5P2ATaldwsD64lbYDl5LBFIvXIYqJ1jGAG6pnCQ0RVhoGJxbYpFeaDg9dt3bzQW50PYThj8c9x3F5bnOL0K0Sq0bpeTBB6lmov1EB4T8iPZ3C+dbchoFJKSqSoMRTOCwK8pBCsvIjU2HBSlCyH4Grg89WB8FM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Thu, 19 May
 2022 15:14:02 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5273.017; Thu, 19 May 2022
 15:14:02 +0000
Message-ID: <f0f3a839-ddbe-c5c6-161b-4c23a68067b0@amd.com>
Date: Thu, 19 May 2022 11:14:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] drm/amdkfd: track unified memory reservation with
 xnack off
Content-Language: en-US
To: philip yang <yangp@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220517231108.14048-1-alex.sierra@amd.com>
 <20220517231108.14048-2-alex.sierra@amd.com>
 <e225fdde-d11a-2d83-c129-393f7284a6d2@amd.com>
 <55882ef2-9dc7-36cb-1d60-2c868ea1c14c@amd.com>
 <c0144b04-d97c-6624-3614-c749b6dda811@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <c0144b04-d97c-6624-3614-c749b6dda811@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87452d08-a400-4bdd-47a5-08da39aa350a
X-MS-TrafficTypeDiagnostic: CH2PR12MB4085:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB408537D8413F44196E145B8892D09@CH2PR12MB4085.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yeyb0uPwvQo/VaTM7D0hdHyg9l/jBuHjnNxtSXvVe4oApukdasRNACugtoUBdVcIHFGnXVJ6LXc9xCsX9yfrmLoE5X7Oq2qGC9mkLY3FjCdyqnigH72NPKXs9iCDrA+d/+mUJxGsH74oCZ07jF9XZ+mxjbY246xz1lHDW+VKbkhoo339I4cDZS7RVwznPY5othvZhV26C9GlHbBtGcNzsBDcFexXLLnWAwumw80EqcSnWWO4NjY0eqCyclKpZvS2fLhGmYElyqdxh7hxKJzDcrNq//cr0OobaD/koypjHLkoXLLIAxj0ZS3VXEgumnW8NkCJ/pcYrbhexcWbS4odTJQBJ96x4pW7QdNPsF1n9TuiLiqz7YxsNmhebn5JUeZvYkZ1Z0W6vffmubFOtYA0sl3Tq26ReglNlXFe+wHjkpfNDLptjrChsmldiJEdomK2F5cpqwvKtBJACzET3aXV02XQjceaLXuR8awxgOnzJVJCIovMkNrn43HwRFGhVAAx/HICt9sWYqczLyu5OMU6ZkEGc8z+jFTNai4pFsbsEetfSKPAzlRjb/GQJxjUlcrnj/IvkMwmwkc31+ZaOPu0eB5mr2lpXiMWTp33uxpLtE9TMyNI9ssnKLNkRPfG4/30U3d+r6TR8gBOeYlV5KNOQ+lnWVONezXsFWoyU1UVWr1sfNTrUFCez11CZYlGqoHxi11RcpSbKcDtNzcAMKH7oihFNmxo9FzqifQJJ7Y17YWv8Lg6iui0H++ilu/S6tw3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(2906002)(316002)(508600001)(8676002)(31696002)(110136005)(86362001)(6506007)(2616005)(31686004)(44832011)(30864003)(83380400001)(66946007)(5660300002)(8936002)(66556008)(66476007)(36756003)(53546011)(186003)(38100700002)(6512007)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmJ5QnJCQnhtdUlubXFlZXVSVXlramI3dDdid1FiZ2VjTHNHcmwrcnYwNWdD?=
 =?utf-8?B?SjVWUXA3WFRqME95UjlvREFaM3NCYTdvNGFLRVQxTTk0bkZreHcxaXF3c2Y3?=
 =?utf-8?B?dHgvNUhDQmF2anc0cWxzSHRLMjJzRm9zZzNTVTdKeU03WFJNenh2N3pwZy9R?=
 =?utf-8?B?V0FZRUNGSDV0cFNQaDNYbk9KSCtaRzBNUUptc285T2NVS2NQbzZrQ01lcGUr?=
 =?utf-8?B?NmhDbjY4U2FhTmVwZmV5RFdSZ1VlVEhQdTljVDZad29GSHlRZjQ2OTlybVc4?=
 =?utf-8?B?THlvTm9EOXludDlPSjRTM0RUVzlsYlhzNzJHSEplNjU3dDVJbytIdVYvWUNo?=
 =?utf-8?B?eVdpeHFtWDhTbFc4d2V4K0M3Wm9zRlZIUm5jRmYwRHhLTzJObVd1Q1BNYTdI?=
 =?utf-8?B?ZVY2bCtqNGtjR0tyamROU1p3WVNzWG5mUTBQQWdyTFN4ZERYM2RId2NRZFBD?=
 =?utf-8?B?dlE4a0NyRHRHT1NtdG1CUFkyd3ZvMzUreFVpWDFNY0VtYVZ1SkN5SnB5SmhW?=
 =?utf-8?B?UVhUakI2N2VsMWRXTGhmM3dIcTBWTnE2NE42c2VMMnlvYlMwelFMQWt3NDVS?=
 =?utf-8?B?T21yWnRKN0F5YlU1ZjgwZkNtN0tIZXNnTTRDeG8xRWN2UHdqL00zVnJhZmE1?=
 =?utf-8?B?Njh0bDd3SkNUVVVLUVNldk9la1JOYVlsYTY1cjBwN05VbXZNNHJvK1ppeHg5?=
 =?utf-8?B?eExXY2RMZ1ZZaTZLUTNPOUx4d1ZGa0hCUjdhWXgzRDRpdThDS25wR1BiemYw?=
 =?utf-8?B?YzQ3cndHdC9kV3hMSFg4OHladGVqbzFtNmVsZmhGWFJMS0k1bkI1Nzc2cDN3?=
 =?utf-8?B?dEZMZzAwZUFid2NqQTVPK3gwbVhwRFpSUngyKzlGSW8vV08yUm9SUjh3eWJV?=
 =?utf-8?B?TmZBaEUzUThmNER3eXVub3ZDVkpwWStSYVczTis4UHBydEI1R1ZLUlZMVFk1?=
 =?utf-8?B?OG1ScDNydXBPM1djRmRJMWJOQVpMd1YyRnB6QWFFc0VzYndQOXlHdVRyUmx3?=
 =?utf-8?B?b0tUTjR2eTdweG9NWDlqUU1jWjhiNkJtMVBxbVFzbVpOSWhJVVpJY1RNRWtm?=
 =?utf-8?B?WUpTVTAxUWZSY012QWgveG1wVC90UGowM3RGUDBGMTVZdzJLQkdyVnJnNUFJ?=
 =?utf-8?B?aTgyN2g5WjJxMzY2VXdzRXRwbUNTUjV6dmRaYlRYMEREZG5Sc1d1R2IyME1i?=
 =?utf-8?B?dU1xSjlqdXhEU2R6eUlDYUxZNWMveGRXaGNhN0daa1BUejdxTmUvZDdPRzEz?=
 =?utf-8?B?YzBkbHlpRHg4amhwTy9oQXZJZW5oYTNHbVZ0aXJUYzg5aER3UGN1a1Byb2xR?=
 =?utf-8?B?QXdHZWhSTmpYTDM1S0lBb2lpeUFXSnhtMEJGVlFEdDAxbEZsUjBMTE9kNnFj?=
 =?utf-8?B?VHUzekNhTkc2L1JSQlhxWU5YN2RqTWZ3V2xVVEVMVWEvV0FDLzRWeVloK2xF?=
 =?utf-8?B?ZGlwM0N3V1Z6VGZReXZSSm1uUEJXZWp4YzV6bkRtdkl0bndGQmhraGlyNVh4?=
 =?utf-8?B?b0hwL2FDL2I2MFBjN04vSGo3WmtkbDlZK1I1USt5Q2tTbC9zd1VOdU40clVo?=
 =?utf-8?B?ZjlLNnVPMzErRlFjdkZWZWRHbEJGUjBneG9PMGJjZ1RBV3BrSjcvamlla1h3?=
 =?utf-8?B?Nm9Hbk1SUGZIT3pxQnVMeFd3am5CSDdRVUMzOTVaTU1JZDEvTnB2T0Fqcjh5?=
 =?utf-8?B?andwL0VmVllMbHFkVWZ1UGhMVVFBY3lnRlpKOXorbTlJOFFCak4rcFFzSDVQ?=
 =?utf-8?B?TmxyRHZrYUZtbmxmZkJJbGNpRDR4cWhTdm1nY0JucFJYUTRQMUlxa09NUjlM?=
 =?utf-8?B?Y29sRFNXaEo3bDNFRXA2eHBXK0xCRGoycjBPSmFRQmtBMmpFb2RrN1J1N0gw?=
 =?utf-8?B?cjNMZC9YT1BoRnZQZXM0dEZpTnlRRisxMmZCdnJlZFZvRk9nRlF3dko5TDBJ?=
 =?utf-8?B?K0ZQV3E2QkNOTFFoUTFRNVdXcHF5L1lKeHg0T0tqMVZ5R3QxVG4wbll3ellv?=
 =?utf-8?B?Q1doN0ozOHE0UkdEZ09mTmszcTd0VlprekpaMUdQVDZ6M2pOOWVIYTlFQzMz?=
 =?utf-8?B?ZFRhd0F1ak9Od3d4amJCZ080YXlKQTVIaFNZMG5aWGxpUFlkRnBTMHlvOE55?=
 =?utf-8?B?VllNcWpXUGU1QjRQQ3ZYZ0ZoMHNqalMxaVFWdzJLSjZ4YUVwM295Zm8zVlVQ?=
 =?utf-8?B?a2hxeWhNWG5iQUY0cjM3dVBKaGhQWDB2elVSTjRRWGorZ0RwN1VsSW1oZEp6?=
 =?utf-8?B?VlBib2k2ZWU1bU9WK25JSGIzcEdVWHJHUnZFRzNkMlVMTXhqenBVRE1rYmVW?=
 =?utf-8?B?bDZsOWlvaW1kRUI3NUR0dXlLT3dDc1VUTUFJY1UyR2MvYVdXOFYxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87452d08-a400-4bdd-47a5-08da39aa350a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 15:14:02.4373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQyt8LDohdzuxcBOfB/rgurT1NOctzmR+2aulNlxSO8xSduT9q7CjQGL3BQ1eTNB24YeDq2BeA3H29H92z2LMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
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


Am 2022-05-19 um 10:01 schrieb philip yang:
>
>
> On 2022-05-18 17:40, Felix Kuehling wrote:
>>
>> On 2022-05-18 14:36, philip yang wrote:
>>>
>>>
>>> On 2022-05-17 19:11, Alex Sierra wrote:
>>>> [WHY]
>>>> Unified memory with xnack off should be tracked, as userptr mappings
>>>> and legacy allocations do. To avoid oversuscribe system memory when
>>>> xnack off.
>>>> [How]
>>>> Exposing functions reserve_mem_limit and unreserve_mem_limit to SVM
>>>> API and call them on every prange creation and free.
>>>>
>>>> Signed-off-by: Alex Sierra<alex.sierra@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  4 +++
>>>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 24 +++++++------
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 34 
>>>> ++++++++++++++-----
>>>>   3 files changed, 43 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> index f8b9f27adcf5..f55f34af6480 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> @@ -301,6 +301,10 @@ bool amdgpu_amdkfd_bo_mapped_to_dev(struct 
>>>> amdgpu_device *adev, struct kgd_mem *
>>>>   void amdgpu_amdkfd_block_mmu_notifications(void *p);
>>>>   int amdgpu_amdkfd_criu_resume(void *p);
>>>>   bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct 
>>>> amdgpu_device *adev);
>>>> +int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>>> +        uint64_t size, u32 alloc_flag);
>>>> +void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>>>> +        uint64_t size, u32 alloc_flag);
>>>>     #if IS_ENABLED(CONFIG_HSA_AMD)
>>>>   void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> index e985cf9c7ec0..b2236159ff39 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> @@ -122,7 +122,7 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t 
>>>> size)
>>>>    *
>>>>    * Return: returns -ENOMEM in case of error, ZERO otherwise
>>>>    */
>>>> -static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device 
>>>> *adev,
>>>> +int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>>>           uint64_t size, u32 alloc_flag)
>>>>   {
>>>>       uint64_t reserved_for_pt =
>>>> @@ -157,8 +157,8 @@ static int 
>>>> amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>>>            kfd_mem_limit.max_system_mem_limit && 
>>>> !no_system_mem_limit) ||
>>>>           (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
>>>>            kfd_mem_limit.max_ttm_mem_limit) ||
>>>> -        (adev->kfd.vram_used + vram_needed >
>>>> -         adev->gmc.real_vram_size - reserved_for_pt)) {
>>>> +        (adev && (adev->kfd.vram_used + vram_needed >
>>>> +         adev->gmc.real_vram_size - reserved_for_pt))) {
>>>>           ret = -ENOMEM;
>>>>           goto release;
>>>>       }
>>>> @@ -166,7 +166,8 @@ static int 
>>>> amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>>>       /* Update memory accounting by decreasing available system
>>>>        * memory, TTM memory and GPU memory as computed above
>>>>        */
>>>> -    adev->kfd.vram_used += vram_needed;
>>>> +    if (adev)
>>>> +        adev->kfd.vram_used += vram_needed;
>>>>       kfd_mem_limit.system_mem_used += system_mem_needed;
>>>>       kfd_mem_limit.ttm_mem_used += ttm_mem_needed;
>>>>   @@ -175,7 +176,7 @@ static int 
>>>> amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>>>       return ret;
>>>>   }
>>>>   -static void unreserve_mem_limit(struct amdgpu_device *adev,
>>>> +void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>>>>           uint64_t size, u32 alloc_flag)
>>>>   {
>>>>       spin_lock(&kfd_mem_limit.mem_limit_lock);
>>>> @@ -184,7 +185,8 @@ static void unreserve_mem_limit(struct 
>>>> amdgpu_device *adev,
>>>>           kfd_mem_limit.system_mem_used -= size;
>>>>           kfd_mem_limit.ttm_mem_used -= size;
>>>>       } else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>>>> -        adev->kfd.vram_used -= size;
>>>> +        if (adev)
>>>> +            adev->kfd.vram_used -= size;
>>>>       } else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>>>>           kfd_mem_limit.system_mem_used -= size;
>>>>       } else if (!(alloc_flag &
>>>> @@ -193,9 +195,9 @@ static void unreserve_mem_limit(struct 
>>>> amdgpu_device *adev,
>>>>           pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
>>>>           goto release;
>>>>       }
>>>> -
>>>> -    WARN_ONCE(adev->kfd.vram_used < 0,
>>>> -          "KFD VRAM memory accounting unbalanced");
>>>> +    if (adev)
>>>> +        WARN_ONCE(adev->kfd.vram_used < 0,
>>>> +            "KFD VRAM memory accounting unbalanced");
>>>>       WARN_ONCE(kfd_mem_limit.ttm_mem_used < 0,
>>>>             "KFD TTM memory accounting unbalanced");
>>>>       WARN_ONCE(kfd_mem_limit.system_mem_used < 0,
>>>> @@ -211,7 +213,7 @@ void amdgpu_amdkfd_release_notify(struct 
>>>> amdgpu_bo *bo)
>>>>       u32 alloc_flags = bo->kfd_bo->alloc_flags;
>>>>       u64 size = amdgpu_bo_size(bo);
>>>>   -    unreserve_mem_limit(adev, size, alloc_flags);
>>>> +    amdgpu_amdkfd_unreserve_mem_limit(adev, size, alloc_flags);
>>>>         kfree(bo->kfd_bo);
>>>>   }
>>>> @@ -1601,7 +1603,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>>>>       /* Don't unreserve system mem limit twice */
>>>>       goto err_reserve_limit;
>>>>   err_bo_create:
>>>> -    unreserve_mem_limit(adev, size, flags);
>>>> +    amdgpu_amdkfd_unreserve_mem_limit(adev, size, flags);
>>>>   err_reserve_limit:
>>>>       mutex_destroy(&(*mem)->lock);
>>>>       if (gobj)
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> index 5ed8d9b549a4..e7e9b388fea4 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> @@ -261,11 +261,21 @@ void svm_range_free_dma_mappings(struct 
>>>> svm_range *prange)
>>>>     static void svm_range_free(struct svm_range *prange)
>>>>   {
>>>> +    uint64_t size = (prange->last - prange->start + 1) << PAGE_SHIFT;
>>>> +    struct kfd_process *p;
>>>> +
>>>>       pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx]\n", 
>>>> prange->svms, prange,
>>>>            prange->start, prange->last);
>>>>         svm_range_vram_node_free(prange);
>>>>       svm_range_free_dma_mappings(prange);
>>>> +
>>>> +    p = container_of(prange->svms, struct kfd_process, svms);
>>>> +    if (!p->xnack_enabled) {
>>>> +        pr_debug("unreserve mem limit: %lld\n", size);
>>>> +        amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
>>>> +                    KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
>>>> +    }
>>>>       mutex_destroy(&prange->lock);
>>>>       mutex_destroy(&prange->migrate_mutex);
>>>>       kfree(prange);
>>>> @@ -284,7 +294,7 @@ svm_range_set_default_attributes(int32_t 
>>>> *location, int32_t *prefetch_loc,
>>>>     static struct
>>>>   svm_range *svm_range_new(struct svm_range_list *svms, uint64_t 
>>>> start,
>>>> -             uint64_t last)
>>>> +             uint64_t last, bool is_new_alloc)
>>>>   {
>>>>       uint64_t size = last - start + 1;
>>>>       struct svm_range *prange;
>>>> @@ -293,6 +303,15 @@ svm_range *svm_range_new(struct svm_range_list 
>>>> *svms, uint64_t start,
>>>>       prange = kzalloc(sizeof(*prange), GFP_KERNEL);
>>>>       if (!prange)
>>>>           return NULL;
>>>> +
>>>> +    p = container_of(svms, struct kfd_process, svms);
>>>> +    if (!p->xnack_enabled && is_new_alloc &&
>>>> +        amdgpu_amdkfd_reserve_mem_limit(NULL, size << PAGE_SHIFT,
>>>> +                        KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)) {
>>> The range will create svm_bo to migrate to VRAM, so count acc_size 
>>> is correct.
>>
>> I'm not sure how to understand this comment. The thing is, the VRAM 
>> BO can be evicted without losing functionality. So I don't think we 
>> need to track potential VRAM usage of SVM ranges. We only need to 
>> account for system memory usage. That includes the system memory 
>> being mapped, and maybe the prange structures and dma_addr arrays 
>> used for the mapping. However, like I said, the old acc_size isn't 
>> really suitable for that because it doesn't account for mappings on 
>> multiple GPUs.
>>
>> The dma address arrays take 1/512 of the memory size, per GPU. Even 
>> on an 8GPU system, that's only 1/64 of the memory size. So I think 
>> the 15/16 system memory limit still leaves enough room for those data 
>> structures. If that gets too tight, we may just decide to use a lower 
>> system memory limit, or change the system memory limit based on the 
>> number of GPUs in the system. That would be easier than accurately 
>> tracking the data structure sizes for each allocation and potentially 
>> each mapping on a multi-GPU system.
>
> Yes, based on this calculation and acc_size is not accurate now for 
> mGPUs with IOMMU support and svm range, we can remove acc_size for 
> svm_bo, only count svm range as userptr system memory.
>
> Regards,
>
> Philip
>
>>
>> Regards,
>>   Felix
>>
>>
>>>> +        pr_err("Failed to allocate usrptr memory\n");

I just noticed this error message. It's misleading. The failure here is 
not an allocation failure. Also the term "userptr" is misleading because 
it points to the legacy userptr BO mechanism. I'm not sure we should 
print an error message here at all. Every time we print kernel error 
messages because of user mode problems it confuses people.

Anyway, if we have to have a message, it should be something like "SVM 
mapping failed, exceeds resident system memory limit". I would at least 
downgrade it to a warning or info.

Regards,
   Felix


>>>> +        kfree(prange);
>>>> +        return NULL;
>>>> +    }
>>>>       prange->npages = size;
>>>>       prange->svms = svms;
>>>>       prange->start = start;
>>>> @@ -307,7 +326,6 @@ svm_range *svm_range_new(struct svm_range_list 
>>>> *svms, uint64_t start,
>>>>       mutex_init(&prange->migrate_mutex);
>>>>       mutex_init(&prange->lock);
>>>>   -    p = container_of(svms, struct kfd_process, svms);
>>>>       if (p->xnack_enabled)
>>>>           bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
>>>>                   MAX_GPU_INSTANCE);
>>>> @@ -1000,9 +1018,9 @@ svm_range_split(struct svm_range *prange, 
>>>> uint64_t start, uint64_t last,
>>>>         svms = prange->svms;
>>>>       if (old_start == start)
>>>> -        *new = svm_range_new(svms, last + 1, old_last);
>>>> +        *new = svm_range_new(svms, last + 1, old_last, false);
>>>>       else
>>>> -        *new = svm_range_new(svms, old_start, start - 1);
>>>> +        *new = svm_range_new(svms, old_start, start - 1, false);
>>>>       if (!*new)
>>>>           return -ENOMEM;
>>>>   @@ -1825,7 +1843,7 @@ static struct svm_range 
>>>> *svm_range_clone(struct svm_range *old)
>>>>   {
>>>>       struct svm_range *new;
>>>>   -    new = svm_range_new(old->svms, old->start, old->last);
>>>> +    new = svm_range_new(old->svms, old->start, old->last, true);
>>>
>>> clone prange is not new memory allocation, use false.
>>>
>>> Regards,
>>>
>>> Philip
>>>
>>>>       if (!new)
>>>>           return NULL;
>>>>   @@ -1951,7 +1969,7 @@ svm_range_add(struct kfd_process *p, 
>>>> uint64_t start, uint64_t size,
>>>>             /* insert a new node if needed */
>>>>           if (node->start > start) {
>>>> -            prange = svm_range_new(svms, start, node->start - 1);
>>>> +            prange = svm_range_new(svms, start, node->start - 1, 
>>>> true);
>>>>               if (!prange) {
>>>>                   r = -ENOMEM;
>>>>                   goto out;
>>>> @@ -1967,7 +1985,7 @@ svm_range_add(struct kfd_process *p, uint64_t 
>>>> start, uint64_t size,
>>>>         /* add a final range at the end if needed */
>>>>       if (start <= last) {
>>>> -        prange = svm_range_new(svms, start, last);
>>>> +        prange = svm_range_new(svms, start, last, true);
>>>>           if (!prange) {
>>>>               r = -ENOMEM;
>>>>               goto out;
>>>> @@ -2585,7 +2603,7 @@ svm_range 
>>>> *svm_range_create_unregistered_range(struct amdgpu_device *adev,
>>>>           last = addr;
>>>>       }
>>>>   -    prange = svm_range_new(&p->svms, start, last);
>>>> +    prange = svm_range_new(&p->svms, start, last, true);
>>>>       if (!prange) {
>>>>           pr_debug("Failed to create prange in address [0x%llx]\n", 
>>>> addr);
>>>>           return NULL;
