Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F84EC61DA4
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Feb 2023 07:09:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BEB510E010;
	Thu, 16 Feb 2023 07:09:25 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2147510E010
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Feb 2023 07:09:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXF8wachpvQmDk0SWB1UaMrX9WlX4tNMPfyiO9JAggFTQulQpniW4wq8jC/1J9BSx7w+tZs56mdxt7bpQnOyARaFQj19bBqdyIomchgzP/zq7S/G0LdpQLgKjLOJ1s07q6b9UshArcjjiCsoZdLxAev8zdnAFWtkGj1RTceziQIrSW5vFZJUks/b1+gUQqiL3Fhg/s+udyfgZrzhhe6L0L1OxHqvUZFXYRwhs6ZKWfjuUAvTa/AvbH/BUs+t/ebuSsQ0kZhyzQLLfFYfbFsz2b2Rkym3sNpDIyEXJws40YMaTFVkDdzfL23p/aR2aUEoDWhUqa6mBbvrW20H2AP0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNQJD5HB45PTt4kD6Hq9AK8lFse0ksjQTDcZPeWrSrU=;
 b=OOAJcIgoYWJPVOvj+GiWGyVvtGg51RhegF6IenSlIoc0+2PusgR3G5TiBvfxldlOLpiwfsinmqePsCmw8Znv8xncgOpFB0EoriAy0GmUz8VMi8RSSOvrogGwG+3+ZJu5r8u7MXC8KUKdsHw2tVPHJ2rfZcU+p/ce1LooPTJJxk3VXRUQC3Kh0SdLxFf3JvGVY7ru2EAw2H3ZgKP1A0YLpLgSxLXBCo862SQSg3zBm8P+ZvmRJnAiz0Dnl7YjDrWigq+6XHZyStShMizeg4f6Lngh4mrkLYTRFMHO+g8703vpNRL5GhCGzXfBQ2LjFWRofA/CvXUqFk/pbffvDOhOMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNQJD5HB45PTt4kD6Hq9AK8lFse0ksjQTDcZPeWrSrU=;
 b=MEmiJ59ScWt4FOhQ9d3GnRONT9GAqs/PSZwK9z2d1c2Y15l/J7XBX/Nb9bqIEJoY1sWFoYpRyO+AtxvQNYxR+60gNIPnt12pVT8TnpyQTBUiNVKQvst3iSkeX/RqLi1pFnx63GBJSRSoLc1WOyY3nQV2ns8+ynJmNpS5B3rUuVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 07:09:21 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 07:09:21 +0000
Message-ID: <ee42c89e-746b-a142-173f-c4d4ba847859@amd.com>
Date: Thu, 16 Feb 2023 08:09:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] drm/amdgpu: optimize VRAM allocation when using drm
 buddy
Content-Language: en-US
To: "Xiao, Shane" <shane.xiao@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
References: <20230214111851.2525197-1-shane.xiao@amd.com>
 <ca40db72-6c04-e3cd-38f9-3254f37c850a@amd.com>
 <DM4PR12MB526136D00F81419EEFCE47579DA29@DM4PR12MB5261.namprd12.prod.outlook.com>
 <0a5fd1ae-45b0-96bb-5160-a34b57fc6a2a@amd.com>
 <DM4PR12MB52616659C39CB1242A4AD8B89DA39@DM4PR12MB5261.namprd12.prod.outlook.com>
 <62ca76cc-a553-21c2-9538-03cefb7b02ac@gmail.com>
 <46fd3add-e02e-9a88-f672-3ef09da1aced@amd.com>
 <DM4PR12MB5261B9EFFEFB88A558B7E3C39DA09@DM4PR12MB5261.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB5261B9EFFEFB88A558B7E3C39DA09@DM4PR12MB5261.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BY5PR12MB4179:EE_
X-MS-Office365-Filtering-Correlation-Id: 06cef2b3-a34f-4ac8-abb8-08db0fecb9fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cDsVEFGh1ciiQfLYRlb8Nu1n36d/EDMfQXoXUWvF5KQT+IztDJsvTRlSRoz+BUi05jQYYSzvEL0aPvacAkWj9R4meFKYG6uuml9EO4hBGfwB7dT5W+KmdrtlryRBEilYrB5zgHz/U7fy6IEKbJO7SxBQ9UDddPczeu7h7qdyBBNbdMZ2gzL6FBmcYXLTROfZHLbDu6F8ycWYdWCvfZ0nQKm4+zzxlzREjYZZl8T7/jv++gPTEBPRec6aObtBj5JTb9ZdOwyC025KdPtJjsDAh5sJ+zcRhr0owa0s5NCVqmTqnG9ZpsBUp2S/Yhnz6fZrlxEvuGAOLNQam86ytJUhBAqHIY7BQzvlfk1rO2soP+pXcbwiODk9BDRpNG5JBQaTnyivOuuatbXanagxxe8GV0BChzv+ZhWsnPcGAEd3l0g1gh8t03q6oFmqAI8mweiaKA5znWsCjQqAiQEqwO8aav7+DaHDiNgLl2Omjg80tR0tyYshiHsu2Joh8bo/OxoCIzCUIO059T0gft21altUaVBJC/WN7RPI0PgyxqoAX8Mez45pseKJqCpKw22pRNRcT1/YvqScK3qBXPvgd+FNkaHtusaE8kY7P16EKNVC44kqVaIEed+jOBk2QMuMgJtGfZ2EFrrBYsYPINPpr9+6JkDflBYLxv1PRVK9uHB+ZI7kf3ct5WxdaguRBQWDo1TjM8AWD18AIrJOznl2nsdGHN1RTjegaD9Voi+ks1/guM0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199018)(31686004)(2616005)(66574015)(36756003)(31696002)(2906002)(86362001)(5660300002)(41300700001)(8936002)(38100700002)(66476007)(66946007)(66556008)(8676002)(6486002)(110136005)(478600001)(19627235002)(83380400001)(4326008)(316002)(6636002)(6666004)(6506007)(53546011)(186003)(6512007)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2YwU01VVTh6VE1xM1dJdnlCOHRwbkJnbEZhTjBNM21QMmplU0RhUWFKejlS?=
 =?utf-8?B?b2JoYmhZbWZ5czhKVCtJQ1IzVFFsQzM1ZERra3lKaE1JOWNmTlljY3lYaVpP?=
 =?utf-8?B?S3ZrZy9uTzVQMnVJQmEzMUo2MnpOU2hvbWcrMi9Sb2RSdHVEM3pYc2tZK2Nw?=
 =?utf-8?B?cElvU2VzT25TZ0lleStUU2E2ODFlMS84QVZVM09EeXptNVgrOTdaV3Y0dkNn?=
 =?utf-8?B?V2MwbktsRitUVnU5UlRpa3ljM1lJU2lnVmhVK1NkejVSMnlIb3lpZXdyMGF2?=
 =?utf-8?B?L2tkUy9yaEZKZk1GY1hUK2MrUHl2SkJXYlRFTVdEQUdhWUlYRDVRM2h0NTAz?=
 =?utf-8?B?RWVaNzIxWXhVNmhTUHNScVRENDFrcWNxeDI3Q0RTQUwrYTlFbjZZem9SYzhI?=
 =?utf-8?B?NTUvaXFGMVBFbFBQdnVyQXdKWUlIbGpJV3JLUTNtQVBBK3BDRVZ4bHJWcmdS?=
 =?utf-8?B?R0M0Qkp4Y1dXbWFqbUZ6ZFN4N1dud0VvNHV3d0UxZ0pGNS8ySkgvWUlXMXNL?=
 =?utf-8?B?ZTdpUDdHdThMNDd1NTVJTG9qTFlQVmdPNGRjMVhiZ0tMSDE0YnBCTGtkbXkr?=
 =?utf-8?B?WndEUXlnZFFyWGUrOGl0T0NVSW1aS1NPZUV4TzQ2VitscElhYkJLLzYydGsr?=
 =?utf-8?B?R29xaHQwNys3cW1WcU9UQkxTZzVGK3htMFRpOWJYRGNnQzBtbVE4NVBjbFp0?=
 =?utf-8?B?U29HdGZnQk5VaWJCYzFoQnJVVGhONkQ3RUZYdytGMkF1OWNCcWsyNFVIUGpH?=
 =?utf-8?B?NXA1ZnlwSlpRdHM2SFRJRXlhQ3RlVjRYbVBwc0Q5ZUlabmJZVFVXaHlnRmkz?=
 =?utf-8?B?QXpLdFM2bnNqQ2V4RlJwaXdtSmd4OHVMNFVLYUNWYTFXU2pSRXRlVTdpYkh2?=
 =?utf-8?B?MjNnRUp3ZktBTUpJZi8rN0pNTEc3YTZLSlBhb2ZZMnlVSUduUHhaYTFwZUE4?=
 =?utf-8?B?Uy9taVZCNllqWkJPMXRJcjYxUXVrVnc0MTcyMTd3YlQyRkFYZmRBSGljNWdl?=
 =?utf-8?B?NGtyTEFBZEZZMGRyVTRyamhhMXMvdWV5dFNxMTlGTkZxTzJidUlhcGpnWDhO?=
 =?utf-8?B?L3cvWnpJY2FlcTQ2N1krSEJLWXZadnlBQ29FTXd1WEs1K09OdVpEdmFCVEFR?=
 =?utf-8?B?U3B4U3VkZmxBU3dHdmk0dEEvVEVoUVZzaEZtREdsaVFqWVpsbXhNd3JaTGRS?=
 =?utf-8?B?a1ZhMUN4a1d0c25BU09qNTNES3dUVGg0NVhMblF4Q1lPd3cvaUkrMlpBMGNF?=
 =?utf-8?B?RmxtcnIxVWY0Q1l6Rk5WMjI5dmllaEFOVFMxOUNBUHBaMmw1N0c4bHVyS1J3?=
 =?utf-8?B?TEk2WXJDRWpiNVppM2pPNzZyb2gvYTNqZldyb1VJc1k5SWpwc1NwZGN6REJY?=
 =?utf-8?B?U21rV3NIZ2FQMldkQUVTTjdZeTlQMTZpV3NQZFF6clZkVWJhaFZpNFYvUXo1?=
 =?utf-8?B?T01LR1diRHp2Vlh4R2FOY3hTUFREV3NyMjdhakpQTldaNDM1dUJKNzVxWk11?=
 =?utf-8?B?T2lOWGgxVXBjZDdUdmIrcEJNNW1QUVlMNDcrNndOVWlLSlFKVWIvRWxsb3NV?=
 =?utf-8?B?eVpzU1RHdDlzaEQ3dTVGMVBRb3Bqd1hYTkR5U0JvbGZ3VWtPYlJlK3crODNn?=
 =?utf-8?B?NzhtTUxoN2xUSUllVm9VWTRzd1NuQzlHRVh1N004TjhMM2tMSjBmNWpJUWtT?=
 =?utf-8?B?aDQzazc0NkZUYjlpSk9zbHdZSXlWK0pNNHlsSVFSc2FnQTJhcmpteklEU1Av?=
 =?utf-8?B?ZEVpWnJMdGZDSnF4NEtTREx3VHNpd1hjVzB6azQ2bkhKRWZDWWNUempnQW9I?=
 =?utf-8?B?Qm92dmpDTjUyWWJpdDlndXo4cHBaUWp3Sm5QVFRndkRnNS9NWXJGcEUvUDk5?=
 =?utf-8?B?Wkx2Zk1IbktlWUo3YWJMZ0gwekxqMVV2MkdkNmNZd3R4bzUvM29uN0hPTEVM?=
 =?utf-8?B?cEIzZmNKK0t0d1FVMUtRelBMMFZsOEtBbjMrVldpUlVNcjJzOFdDaGNhNXNN?=
 =?utf-8?B?cWw0czhGWGU1Q1pBaGdTNnBFdHhFY0tvRXVOM09qRncvUVJ6NCs1N1pIWml2?=
 =?utf-8?B?UGc0dG5PMldEMTF2QlFvYzFIOFZwUXB0bm5rZG5rbXlnNjBMSEpUNm80c3hJ?=
 =?utf-8?Q?kBwc2mhsKwKDu/s9vDLYuUTJK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06cef2b3-a34f-4ac8-abb8-08db0fecb9fd
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 07:09:21.2665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHvvoa+dc1yoQAQn1f3S8m8yb3oHEaP3GWoMW1xRhB2o7fBAaSDc4yfk6gin9BO8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4179
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 16.02.23 um 07:48 schrieb Xiao, Shane:
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Thursday, February 16, 2023 6:19 AM
>> To: Christian König <ckoenig.leichtzumerken@gmail.com>; Xiao, Shane
>> <shane.xiao@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>;
>> Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 1/2] drm/amdgpu: optimize VRAM allocation when using
>> drm buddy
>>
>>
>> Am 2023-02-15 um 05:44 schrieb Christian König:
>>> Am 15.02.23 um 03:51 schrieb Xiao, Shane:
>>>> For public review
>>>>> -----Original Message-----
>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>> Sent: Wednesday, February 15, 2023 3:02 AM
>>>>> To: Xiao, Shane <shane.xiao@amd.com>; Paneer Selvam, Arunpravin
>>>>> <Arunpravin.PaneerSelvam@amd.com>
>>>>> Subject: Re: [PATCH 1/2] drm/amdgpu: optimize VRAM allocation when
>>>>> using drm buddy
>>>>>
>>>>> Am 14.02.23 um 15:53 schrieb Xiao, Shane:
>>>>>>> -----Original Message-----
>>>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>>>> Sent: Tuesday, February 14, 2023 8:41 PM
>>>>>>> To: Xiao, Shane <shane.xiao@amd.com>; brahma_sw_dev
>>>>>>> <brahma_sw_dev@amd.com>
>>>>>>> Cc: Paneer Selvam, Arunpravin
>> <Arunpravin.PaneerSelvam@amd.com>
>>>>>>> Subject: Re: [PATCH 1/2] drm/amdgpu: optimize VRAM allocation
>> when
>>>>>>> using drm buddy
>>>>>>>
>>>>>>> Am 14.02.23 um 12:18 schrieb Shane Xiao:
>>>>>>>> Since the VRAM manager changed from drm mm to drm buddy. It's
>> not
>>>>>>>> necessary to allocate 2MB aligned VRAM for more than 2MB
>>>>>>>> unaligned size, and then do trim. This method improves the
>>>>>>>> allocation efficiency and reduces memory fragmentation.
>>>>>>> Well that is a trade off.
>>>>>>>
>>>>>>> Allocating the BO as one contiguous chunk and then trimming is
>>>>>>> beneficial because if we then later need it contiguous we don't
>>>>>>> need to re-allocate and copy. This can be needed to display
>>>>>>> something for
>>>>> example.
>>>> Hi Christian,
>>>>
>>>> This case means that you allocate BO that is unnecessary to be
>>>> continuous at first time, and latter the BO should be continuous. I'm
>>>> not familiar with display. Could you give me a few more specific
>>>> examples ?
>>> On most generations DCE/DCN hardware needs the buffer contiguous to
>> be
>>> able to scanout from it.
>>>
>>> Only newer APUs can use S/G to scanout from system memory pages.
>>>
>>>>>> Yes, I agree that one contiguous chunk may get beneficial sometimes.
>>>>>> But as far as I know, you cannot guarantee that
>> amdgpu_vram_mgr_new
>>>>> can get one contiguous chunk  if you don't set
>>>>> TTM_PL_FLAG_CONTIGUOUS flags.
>>>>>> For example, if you want to allocate 4M+4K BO, it will allocate one
>>>>>> 4M block
>>>>> + one 2M block which is unnecessary to be continuous, then 2M block
>>>>> will be
>>>>> trimmed.
>>>>>
>>>>> Oh, that's indeed not something which should happen. Sounds more
>>>>> like a bug fix then.
>>>> Yes, I think this case should not be happened.
>>>> Actually, I'm not sure that why the allocated BO should be aligned
>>>> with pages_per_block, which is set to 2MB by default.
>>>> Does this help improve performance when allocating 2M or above BO?
>>>>   From my point of view, the TLB may be one of reason of this. But I'm
>>>> not sure about this.
>>> Yes, we try to use allocations which are as contiguous as much as
>>> possible for better TLB usage.
>>>
>>> Especially for some compute use cases this can make a >20% performance
>>> difference.
>> We actually found that >2MB virtual address alignment was hurting
>> performance due to cache line aliasing. So we can't take advantage of  >2MB
>> pages in our page tables.
>>
>> Regards,
>>     Felix
> Yes, if we want to take advantage of 2M TLB usage, we should keep virtual address aligned.
>
> As you have mentioned that cache line aliasing issue, I'm confused about this.
> If 2MB aligned VA get the right PA from TLB or page table and the cache line addressing mode is not changed,
> the cache line aliasing issue should not happen here.
> Is there something wrong with my understanding? Or maybe there are some backgrounds that I didn't know.

The problem is with virtual address alignments > 2MiB (or whatever the 
big cache line size is).

Let's assume an example where you have a lot of buffer each 66MiB in 
size. When you align those to 2MiB in the virtual address space you end 
up with

64MiB..2MiB..62MiB..4MiB..60MiB... etc...

In your address space. In this configuration each 2MiB cache line is 
equally used.

But if you align the buffers to say the next power of two (128MiB) you 
end up like this:

64MiB..2MiB..62MiB hole..64MiB..2MiB..62MiB hole... etc....

In this case the first 2MiB cache line of each buffer is used twice as 
much as all the other cache lines. This can hurt performance very badly.

Regards,
Christian.

> Best Regards,
> Shane
>   
>>
>>> Regards,
>>> Christian.
>>>
>>>> Best Regards,
>>>> Shane
>>>>
>>>>>>> On the other hand I completely agree allocating big and then
>>>>>>> trimming creates more fragmentation than necessary.
>>>>>>>
>>>>>>> Do you have some test case which can show the difference?
>>>>>> I have use rocrtst to show the difference.
>>>>>> The attachment is shown that after applying this patch, the order <
>>>>>> 9 total
>>>>> vram size decrease from 99MB to 43MB.
>>>>>> And the latter has more higher order block memory.
>>>>> Arun can you take a look? That problem here sounds important.
>>>>>
>>>>> Thanks,
>>>>> Christian.
>>>>>
>>>>>>> BTW: No need to discuss that on the internal mailing list, please
>>>>>>> use the public one instead.
>>>>>>>
>>>>>> I will send it to public. Thank you for your remind.
>>>>>>
>>>>>> Best Regards,
>>>>>> Shane
>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
>>>>>>>> ---
>>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
>>>>>>>>      1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>>> index 75c80c557b6e..3fea58f9427c 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>>> @@ -453,7 +453,7 @@ static int amdgpu_vram_mgr_new(struct
>>>>>>> ttm_resource_manager *man,
>>>>>>>>              /* Limit maximum size to 2GiB due to SG table
>>>>>>>> limitations */
>>>>>>>>              size = min(remaining_size, 2ULL << 30);
>>>>>>>>
>>>>>>>> -        if (size >= (u64)pages_per_block << PAGE_SHIFT)
>>>>>>>> +        if (!(size % ((u64)pages_per_block << PAGE_SHIFT)))
>>>>>>>>                  min_block_size = (u64)pages_per_block <<
>>>>>>> PAGE_SHIFT;
>>>>>>>>              cur_size = size;

