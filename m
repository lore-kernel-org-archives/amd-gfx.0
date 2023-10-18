Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A0ECDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 16:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CE7010E1A0;
	Wed, 18 Oct 2023 16:57:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::612])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABAAD10E1A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 16:57:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdYfCYox8JOluu0e6RZytJ3BfWdCqwyE4pFr8PkJTa4JvZpL42Wph154ITZjYQWIlig0huj3WlEFU6JhSTGPL12//1iMUGKzJk+wvMdZQ4mgfo92EIfm9zfOxNhR9zVjUQNz36Mw3rJM/xfQAcVwarvXqJ1ykIBETbWGVnivSkiv3KEYQ5UWJotRx+jOU1/DrOV9u7zL7hegmdJHwt7PJ1dRj2dNaz03IGsWDXWwjpWeidb6y3JZ6lnKYnTHayBy9lus4z5zTti1vmQer2K9yWNFEMlzSLh/cR0cTlobwr049akJuS/Uj24dkaLUBTuvt3eXcihnmpc20YZFSxbWpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8pKnicyKoFy0hUAaOIbZXQCavSbrF3OUelZ1ym8Rsc=;
 b=GMcolX7CpnnDm1SRXVnWozLkxbDUW9HfBsAge94tCbmkYnt6LXu4TxYXRPQHde6BkExqs+uh9pN5Q8zvUI+2ljlZQ0NmSH1rbRegYIL7afO0vzQiPuo8qu+zb1RzDuE/W/RTNQ+lNhjjsupyYvS7uoCiFWzCaWvsReO0FEZcu/Tuwf39I70OCKrWqQpcSn3emX07f/nC6vaHNG8agYP4MJEcmzWntcuRzq3pXSRfJu0EryS2mfVRNNl+8Wp9RANTStZ9cvx98PxljBQFisAXvNcPfupeA+/sNRb3hLOHQVZpAKflIXYp8mP5xvfapwuBcblbRhzXIdNz0jIeSdzE+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8pKnicyKoFy0hUAaOIbZXQCavSbrF3OUelZ1ym8Rsc=;
 b=CNoRFmzeTdl1R4lYM1hA2cb7SnwTNCBX/fpu0vshI4NHBFfpw8DTFmQTMeBIs4Vey6+swoq2PlMEn+madl4vde+x4lplFVeQuoXiUp6XZbe4W65vG17BxNRTLxD7+5b5BjzLJ8NysD2m8JH19FSKtyo6UoqpAY+eHTuMEaCexPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Wed, 18 Oct
 2023 16:57:16 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::f381:62fe:194c:ad48]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::f381:62fe:194c:ad48%4]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 16:57:16 +0000
Message-ID: <1bd427de-edbd-d121-d8d8-8d6bea3fe901@amd.com>
Date: Wed, 18 Oct 2023 11:57:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdkfd: Fix shift out-of-bounds issue
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231018074931.139904-1-jesse.zhang@amd.com>
 <CY5PR12MB6369F24E1CC12D5682BAB3E3C1D5A@CY5PR12MB6369.namprd12.prod.outlook.com>
 <ae14eee8-1cbc-8100-8390-1a9616a95a67@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <ae14eee8-1cbc-8100-8390-1a9616a95a67@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0205.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::30) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|BY5PR12MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c9755e-2d16-4db0-1fcd-08dbcffb486a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmZTQh1wMPaSCIC2f9of56qyeqCPGfVKCjcUDZP3vpkaMKSkMCVBSh0025wcg3HpAyFumfhQhycW70K3G+pufwhQSljD5KYAInlWdDs/g9zrIntiJpRnpMGINByfTpfdbcYXHD7koYgTt3zvdTB7lMTDwB1j/ESOiVJO2ZFiBcFk89h3WgT3kTl2/KVFtOQcfBsDPfCVTyFSjmggyj9dZcA1tDJbm0oy+MEusTgnf1tGcN61+SdH/2o+Zovud37Va/ddETl5ZBA8AA10Cdd2/Cajh1RVDkOxHCXPWzmT0bJuXKVMqxf5T/hmEMIsyGXSyHC9dmnmP2lBkPDIwv7qG90wlGFgQfE8N6clfV06lYWISUw/WUpRsc5PAtLqEEKxGsix+SEmflGdD4dnXPRcwg2oYL8WXBmqh1TL5XkL/jOH0Rg0WWXOH3ctkq17nGoGCJB9NsWZpjVzTUE1J/veXOsfVCqruH/0p1l+Lb5BFd0UaAaX7fMwcnCZwwLzn/iDuPmFq5L2j7xJK6p7G0D3YpY/1tZMKnSpzhzHCzM8pUMgq3qQmGLdvyDH/bJIkuZJmVzPaDa2R0ixF1bnyQ+Bs4b2W3WN6+wfOIEcLwQ9sF06dgpeu9U1XqhimDduTg6JQZGwt3TEGVTVPbZngBeD4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6512007)(2616005)(53546011)(6506007)(2906002)(66946007)(66556008)(31696002)(54906003)(66476007)(6486002)(26005)(5660300002)(83380400001)(4326008)(8936002)(316002)(478600001)(38100700002)(110136005)(86362001)(36756003)(6666004)(41300700001)(4001150100001)(8676002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0hnU0NISWJDUkYxeDhxSEVVOVBlSzNmVTNjdlpEb3FLeGR6eGY3UG90SDNP?=
 =?utf-8?B?anBxSVpMdkhlZlZNYVp6OXNwMmVoQUg3SGRUeEM1bDkyQUtxZWJBSWl4U2Na?=
 =?utf-8?B?NlQ0ZEtPa2tpQXM1aGk2L3o2eWY4aHI0OHVoTG5hNDVBbHVkcHY1VXJrUklC?=
 =?utf-8?B?dE9SVnBwV3p5MnFIMWJrQ1dhZ0lsdlU1a3cvb0FwS3hCZGo5NVJvUmNCVHF0?=
 =?utf-8?B?QjRKbUlQWlBWQ0dvS1YvQmVQNndUSndRWlRwZDZXQWRPQU5yTExlR0RreVBV?=
 =?utf-8?B?Vko1czNId1dSMG9GUjZ0aTZWTkpMdm41TG1FMEFFdkozNGdsR2hMTFB6UEF1?=
 =?utf-8?B?bnNHMVpwUXVRNU52cmNTdnN5QmNKMzdkcG51Z3VhNEVRKzMrZyt5UXRLQVJ3?=
 =?utf-8?B?azVQWGFQaUZMaG92VTQ0ajdIeVZyQjR6c2JLbERIbmlJYVhpaDNlL1FQYVlO?=
 =?utf-8?B?T2tiSU1SWHdFR3B6UHMrUDRsRVp6MzFKajRxSS94eXBCaE5US3ZyNGNnampq?=
 =?utf-8?B?OWMvNkJ2TmxLSjJjY2NXcmpmdHRpeExkNm5vRG1MdkJTQXJpdDJpVjB3ajhF?=
 =?utf-8?B?Wjc1L08rZjdwaDlhRURwOXFWOG1XZ0w5ZVpvUm9ZeGhNaVd2OE9NcXVvSzZF?=
 =?utf-8?B?WWp1YnNWTG93WlIxQ3ZkeFNCQXp2M2FWdlp1S0dOMTBZcXFEbmk2ZTFSMWNK?=
 =?utf-8?B?NHR3dHMvNTlzc3hWejBxSjV3S3pnS0h5QUJsWEFLQmxhbXJ1d0NjWjhpWmFP?=
 =?utf-8?B?Vi9XKzhHbXNtSjRoOHBraU5QbWpubmJyQ25GMUtkMzBEekxqajNlalArMEc4?=
 =?utf-8?B?Qi9sTnJSYlpFKzZmL1YvdTViTXgxOFU0TUF3UXRiUHdwb0o2WmZKVTkrbEVi?=
 =?utf-8?B?UFV4cDNpdGN0eVhGSVlDSkV1S0dGK2VRZWlKNk9qVHdCRUpZODdwbXlnUFNW?=
 =?utf-8?B?cWlIRGZ2dGlQODZ6MlhyQUppOU9PLzdCdG9YQjU1Z2trT29wNXl5RUJjR0pr?=
 =?utf-8?B?SEh2ZXlZU3FtLzBQSlk0UTFHR3FEY2M3dzhmYWpHQ0srSHFHMDJtV0twb3Vq?=
 =?utf-8?B?cS9zOXZ6elZWWHNQSmhYSVhiMTdXRzcrTi8vcVhzRDI5aDR6dGgxais1SVJX?=
 =?utf-8?B?WHkybmg0MTVqVms5dnhKR1Vha3JEL0JKMjdnM2FPYmZuekRtWE1NYUc4dDE5?=
 =?utf-8?B?WG5kNk0vQjgzOXBINXB6N1RwYks0ZXZYUHNNY0dDT2xXejUyclpNZFExTzlC?=
 =?utf-8?B?bnpIUGdjNi9uM1JpUnQ4cG5IZ1FBMDVubmRHMUl4ZUNBeDk2ZHloK01BZGFk?=
 =?utf-8?B?WHlMUURIMVVVQWZJQlpzdHdSbUhEbDdkOWxJSXBSVTZjb0xSdEdhTElhSFhM?=
 =?utf-8?B?TCtyTEVrQU1HOTN1Sk1pMVhjZTJKcDlwR3NoN3RqREU2cTRrMXFyWjlGNHdS?=
 =?utf-8?B?U2VTZkFvamxrTVdBUWZETGpQZWlLN3RqWUNPazBEdWxYWFR3RVdOYy9icTZq?=
 =?utf-8?B?ZjF4dUtwQWZnSEh5ZDNXKzI4ZVhTTjVVODlCWGIwRkdIc2YyVWtlZUNwOWg1?=
 =?utf-8?B?MUdENzR0Z0xYOUNkTlAwa1A3dldGbFl4TXYzSlV6Sy9wWTVodER0YWFiRGFz?=
 =?utf-8?B?QkJOMjh1QlQ2eUZLcmF6b1ExMFdLY2VYNGgxMnlNTlJqVy8zQ2RmWk5jdHZ3?=
 =?utf-8?B?eldzUmpMWWVXL1pEU2ZlNXNqU3krUmVlYVlPMm9kcWFBVlUwOEhiaTFUY1E4?=
 =?utf-8?B?MjFCVlRpczRTdVNnQnFRODZWU0dDN2VlWW9SU1lEcGJuSDNQeXg5QnVSeVhu?=
 =?utf-8?B?ZVJjaFNqZUgrL09TdkNPblFEMkdhNWNkVUNzS3JsSzFrRFFITkZuUmE2dUgw?=
 =?utf-8?B?N0ZUN3VHRWVoWWlnaUxzUE5DTTNIelplYzl5N0tzN054dE0yVU1hTmtaeGY1?=
 =?utf-8?B?cGxCemxzK2pXUkhLT1piWkdKK3lXM0tzUGQ0ZnRJaTUwSjRJYVQ5aDJSdFJ4?=
 =?utf-8?B?TnREZXgxVWcvZWVlMGtudG80Um1idWx6REl5em96Q05Nbzc1T054WXBxNWZW?=
 =?utf-8?B?VjRTVS9QWXJEQXlMWTk1UFNNQ3AwTERTTE9sdEUya3NvNVAvNG5pQkFjcm5Z?=
 =?utf-8?Q?W0Uw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c9755e-2d16-4db0-1fcd-08dbcffb486a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 16:57:16.4156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDh3ePAlvb112dnx7BSqb559dAQvBFqHtyCD+uraT6zZSCntobd7ZnzJBTVCnIvv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yang,
 Philip" <Philip.Yang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 10/18/2023 9:53 AM, Philip Yang wrote:
>
> 	
> Caution: This message originated from an External Source. Use proper 
> caution when opening attachments, clicking links, or responding.
>
>
> The 255 granularity is from recent Thunk change to increase CWSR area 
> granularity.
>
I think we also need to do same restriction at correspondent parts in 
Thunk when set range granularity. Setting 255 granularity is far big as 
granularity here is log value of page number.

Regards

Xiaogang

> Thanks for catching this with kernel debug option 
> CC_HAS_UBSAN_ARRAY_BOUNDS enabled. Because 1<<prange->granularity is 
> used in many places, I think the proper fix should be in function 
> svm_range_apply_attrs
>
>         case KFD_IOCTL_SVM_ATTR_GRANULARITY:
> -            prange->granlarity = attrs[i].value;
>
> +            prange->granlarity = attrs[i].value & 0x3F;
>
> BTW, function svm_range_split_by_granularity() is not used anymore, 
> forgot the remove it, maybe you are testing on older source code?
>
> Regards,
>
> Philip
>
> On 2023-10-18 09:36, Zhang, Yifan wrote:
>> [AMD Official Use Only - General]
>>
>> Hi Jesse,
>>
>> This patch is only a WA for the error log. How is this issue reproduced ? 255 looks like an invalid value for a prange->granularity, it is better to root cause who set it in the first place.
>>
>> BRs,
>> Yifan
>>
>> -----Original Message-----
>> From: Jesse Zhang<jesse.zhang@amd.com>
>> Sent: Wednesday, October 18, 2023 3:50 PM
>> To:amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander<Alexander.Deucher@amd.com>; Kuehling, Felix<Felix.Kuehling@amd.com>; Yang, Philip<Philip.Yang@amd.com>; Zhang, Yifan<Yifan1.Zhang@amd.com>; Zhang, Jesse(Jie)<Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)<Jesse.Zhang@amd.com>
>> Subject: [PATCH] drm/amdkfd: Fix shift out-of-bounds issue
>>
>> [  567.613292] shift exponent 255 is too large for 64-bit type 'long unsigned int'
>> [  567.614498] CPU: 5 PID: 238 Comm: kworker/5:1 Tainted: G           OE      6.2.0-34-generic #34~22.04.1-Ubuntu
>> [  567.614502] Hardware name: AMD Splinter/Splinter-RPL, BIOS WS43927N_871 09/25/2023 [  567.614504] Workqueue: events send_exception_work_handler [amdgpu] [  567.614748] Call Trace:
>> [  567.614750]  <TASK>
>> [  567.614753]  dump_stack_lvl+0x48/0x70 [  567.614761]  dump_stack+0x10/0x20 [  567.614763]  __ubsan_handle_shift_out_of_bounds+0x156/0x310
>> [  567.614769]  ? srso_alias_return_thunk+0x5/0x7f [  567.614773]  ? update_sd_lb_stats.constprop.0+0xf2/0x3c0
>> [  567.614780]  svm_range_split_by_granularity.cold+0x2b/0x34 [amdgpu] [  567.615047]  ? srso_alias_return_thunk+0x5/0x7f [  567.615052]  svm_migrate_to_ram+0x185/0x4d0 [amdgpu] [  567.615286]  do_swap_page+0x7b6/0xa30 [  567.615291]  ? srso_alias_return_thunk+0x5/0x7f [  567.615294]  ? __free_pages+0x119/0x130 [  567.615299]  handle_pte_fault+0x227/0x280 [  567.615303]  __handle_mm_fault+0x3c0/0x720 [  567.615311]  handle_mm_fault+0x119/0x330 [  567.615314]  ? lock_mm_and_find_vma+0x44/0x250 [  567.615318]  do_user_addr_fault+0x1a9/0x640 [  567.615323]  exc_page_fault+0x81/0x1b0 [  567.615328]  asm_exc_page_fault+0x27/0x30 [  567.615332] RIP: 0010:__get_user_8+0x1c/0x30
>>
>> Signed-off-by: Jesse Zhang<Jesse.Zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 7b81233bc9ae..f5e0bccc6d71 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1169,7 +1169,7 @@ svm_range_split_by_granularity(struct kfd_process *p, struct mm_struct *mm,
>>           * PTE will be used for whole range, this reduces the number of PTE
>>           * updated and the L1 TLB space used for translation.
>>           */
>> -       size = 1UL << prange->granularity;
>> +       size = 1UL << (prange->granularity & 0x3f);
>>          start = ALIGN_DOWN(addr, size);
>>          last = ALIGN(addr + 1, size) - 1;
>>
>> --
>> 2.25.1
>>
