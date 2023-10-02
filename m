Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE491E784AF
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 09:43:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F59810E03A;
	Mon,  2 Oct 2023 09:43:11 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F17EC10E03A
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 09:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjTFrpkhSjAwjK229/rKI4+wDMmaeJyaGgGhno5kKr1G0D5q5flhrMNHzFq9idkkoWYv/4NoyjEI5YBHPb+z4Laqvm/X56zE/60E3lr4cg1oEWVu7liLSJzkGBNbfKIb8/zb8J2vW/1iJje1h9f/1AzroPO/yZXOLbwiUMSs2D3RfvCeB10puaoNp1nfiq7FGwJ0r73LIvSf9gUMTrYY+9zT1QbKZ49nIFKKd8vrrHT92zCuP7+mC5nbvB8Rs+fkDy/NrBaUHomCgVvCZLVNZyEWhBnb2MOKMprfviFpew+ih+zfV8bvML6ee6WjZG4xxCl5UhX9gwxtMS54g07T6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSiEtmu0btXC81cxdzC2IoEU6953hW4oiXNivZ9pDk0=;
 b=mkZhl4VOT8eCppZLYHd4GIk8awYZgqUzzaqUBVOPLwGsbP5oiXE5qImpHfdSGw5YTwnS9JsWruB1uO12RS7XVyJi+k45ywIVMqy9iFtYO4RYdXo9nPjr7TVpHFPP5LFUuUJMykJaWCeXLf4vwg0LRivtUxaiDvp5pao1WidKHFKVWztLXE7hW+G9eYFqJukgHNySNjEmQpW0PYF5rQoBYOT9hHwk5GufVlzcta32g2a3ndJCHYtHb+fJ/fU0zmMBblm1StsOnG9Z/u4KckUasio8NRwuy0wtbX2xbGhuMTp2Mi2PFo3Ii1/GuHLlwEXDpwmAeJMQhWFKM1FxIXty9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSiEtmu0btXC81cxdzC2IoEU6953hW4oiXNivZ9pDk0=;
 b=WaECQlEDUa5eWyU+8hsvV3BJAOmdNufYFbLCXAGWN+BTkCcQNPcdr79v2sELE2M/lc+J9h4AOxnq2o2FUzJoybUOqYTNOBcS2/KKSgNBeHN8NJE+/dnQxQEUb8bc3OHhU8oUpRftf9UqPrfvFriKulaVGjRF9ngZcDYre0t+4qk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH0PR12MB5265.namprd12.prod.outlook.com (2603:10b6:610:d0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 2 Oct
 2023 09:43:01 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a7fa:4411:67a3:131d]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a7fa:4411:67a3:131d%4]) with mapi id 15.20.6838.027; Mon, 2 Oct 2023
 09:43:00 +0000
Message-ID: <b085dc4d-0c6f-fa31-cf45-fb363fa3d2b7@amd.com>
Date: Mon, 2 Oct 2023 11:42:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 4/9] drm/amdgpu: create GFX-gen11 usermode queue
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20230908160446.2188-1-shashank.sharma@amd.com>
 <20230908160446.2188-5-shashank.sharma@amd.com>
 <6d579492-1555-4dba-68c6-130266c011a1@amd.com>
 <009e90dd-2cf2-9838-a8c3-f18cbbd29b3d@amd.com>
 <c097f8eb-9866-d4f8-6b18-383dd9b69400@amd.com>
 <CADnq5_Od2uEzpPMGvUx-R2uDtTeymwPvk67Fvm8VW1GV2VU3nA@mail.gmail.com>
 <9789fc70-969a-285c-65ae-f33cc613f674@amd.com>
 <CADnq5_NbrmBT1=82yBZYB31=e_3GOELOLZrfoevBvb2WCaV7sQ@mail.gmail.com>
 <eff6cc36-9f73-b64e-3127-a1d6e85b5037@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <eff6cc36-9f73-b64e-3127-a1d6e85b5037@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CH0PR12MB5265:EE_
X-MS-Office365-Filtering-Correlation-Id: a0111628-3529-4663-d1c3-08dbc32bf780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hdfrJtDC/Zll7JTf/0OUL9aYJTFyU5viCNmnPt8a+jxqL/aNjsTONqvcjmZrbcSPVHJfrJCpqBmIefHsnwNloNWPdM+9PjtB8TeoSFdye/WFmwCA7vUTa5DDx57u6wziwU+KNRPi886VWsdtqWBO9YgUMBseUycLJTVFCHFTOa2l39CPJCEkO44gcG2KIbDGTn+rDrnv9l/FuoLIMnGSk0fKPWdFJZxI6INYh1b0olpu3xWtpdXrGxW4rNoHzR0VBsMXKi/0FNMQ8qTk5OdyX1AvNB4FF76hi0QAFZ3f2DxyD4TOeFKPuQ8uxqSeklJmu2Ltgwr/3DDerl8JKqgDqksrwQEICjN6Rx9bwt4d3RbDyh6M94gV0z7qTlPOfgCHNJI5Jh2iJrfm2ggciiSfOxxcq7I1pKyXJNrqo8N/ilJDWL7GHSrrEwjZBgj9Y26JJi8CPpLyGGJLRg72ogNhluqQBwVDBQKYM4kVlKwfOjzR7q6LDKjTnyvQlQFmsY64CflxvxrPr0VVqDnisbE+cvwfp4rx/yrmjHTaMjls5C4rCnbktiuZJ/uMftsYMU9xanQt0bl3DwPKJzFPntKYjAvMYM8B9whpGe2HvCh8dD0LZhsksj7T9JmlcdItEoryBvemlsPwiqqPIexobrZkBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(376002)(346002)(366004)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(66574015)(31686004)(6506007)(6666004)(53546011)(478600001)(6486002)(38100700002)(86362001)(31696002)(30864003)(2906002)(41300700001)(83380400001)(6512007)(26005)(2616005)(36756003)(66476007)(5660300002)(316002)(66556008)(110136005)(66946007)(8676002)(4326008)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TURYSVVuQTBCYTZEVGJ5Nlk5RXlUQjFOTXFOTnlKbkNCQnphcU8yNm1LdTZ1?=
 =?utf-8?B?ZzNrRFFXUUlETkJDV294bVpUSSs0eEJEdjU3QjNmU3FHTC9WWHUrNTQybHM4?=
 =?utf-8?B?WXM3cVNkZE9sdklWdHllMkQ3ZGZyRG1NNTlBRGxpTS9Eb0ovaDkwK281SjFM?=
 =?utf-8?B?eXRvSmNQbFgwaHg0U2FaMmljYXFDZHBxR2xZbWQxNTdqVDhHS2VKYmdXbmRo?=
 =?utf-8?B?bXlUMDFhNDQwdENiTVR3TWVZUEloNm5HTHZjWCtaWnJieXFNWXBVSFNwQ3Zq?=
 =?utf-8?B?Y3UwKzJVQThMejVCQmJUMjVDNUhHZ0FDWGtmQXczekg2NW4zS3lUV1lkb2tv?=
 =?utf-8?B?UTU4YkZqSnNETXQrQkNpQmlWQjhrUWJaQXV0Q1RqN1dmQlU5VXNlbWVzZG1v?=
 =?utf-8?B?bURqcnNnN0gySmtHRFdCSmFVUXVOZGlsZExNQWlUWEJWRXBHSE14VGJNNmky?=
 =?utf-8?B?YnZJN3E5YWw4T0k3aEkzcEFNZXJIRWdXSlVRejA2RHZjS01rNmVzN1JEdXpI?=
 =?utf-8?B?bHNxQ2Ivc2loQlM1bWpOODU4ZjVXRkxpb1h3SjgzNXovMmk0bEs4NXFnUUh5?=
 =?utf-8?B?RHJzZWFUOEdIckxrcHNmUGRvTnE0cnp6akpxL1JjM3FMOWRKSmF0clNhdEti?=
 =?utf-8?B?M1JYbGl3VWhHRjdPT0pSRGRXR0RES2J2RnNuRW1SYWhZemlaNDRKUXRlUzhi?=
 =?utf-8?B?RWRVR0RRaU9iZEYwTjFPOTk2Z21vMEFVQzFIcnNjdXBTZHFxRFg2QVk3bU5h?=
 =?utf-8?B?aFBiTWRMNVV2QXVvZEpjNGlvZGRxVFpkMXdPTzY1c0JqMnBKY0UwOHRsOW4v?=
 =?utf-8?B?WjFCbWZxUWU3VS9vQXZxNkVCQ1cvYTV2VFRmZVJtSFd2SHUyb0h5ZTJIOTMz?=
 =?utf-8?B?dzRBbEt5S3hTNjJ3eG8zbE4wMlpJMCs2UVE1UFB2NGM1S0hBY09OenVyU0hY?=
 =?utf-8?B?MEhKWlpsYURXcXZGNnhIamppWEdzc1lpRSttanZONWgyWm9zQlExM1p3aHJn?=
 =?utf-8?B?SHU2c3MvK0twaDVUVUV2ZlVycTZzUVMvRFRxWGVldUlsUjYxTWVKVVFLZU03?=
 =?utf-8?B?ekdZOXUwWmlRM1RGTmhEblc4aUp2NUZhVTJtc25majBnMnduNVcxM3d1WDV0?=
 =?utf-8?B?R1l4WmVYUGpCYXoxMS8zS3FFTHhEWE1vSmZ1bFp3ZTZnUzdZZ3ZrVmU1VWN0?=
 =?utf-8?B?NmdSY2hVVFBhd3BZZS9SaTNOQUdUeFhXUE9XTWpWUWZMdmV5RTEwbDducU80?=
 =?utf-8?B?WDVLT0g4ZU9UV2FqSXpmTDhtNlFsd2FiWGZRRGNzeFBaenliaFo5RXN4NmFO?=
 =?utf-8?B?dk40MmF4MEt5SisvRGtMQzZ4Q3l5VmlrL0psVFFjdDJKUTF0SW1XczliL3FK?=
 =?utf-8?B?c3dsaFpMMEVWRkxGKzYvRlVpcUhBNnYrTEFIUWh3WmxlWkViVWs5d3RnQVB4?=
 =?utf-8?B?dUwwblAxMjJFMVVTVlJVazIrZDkrWEhUeSswWW5SNzBLSVdDclp6WDJlcXBH?=
 =?utf-8?B?M2dFTHlpVG53c1I0aThueWZIdW5XNXFVVTlLamF4K0FtVk4vSEQvUEF6VW9G?=
 =?utf-8?B?Y3lrVUhlSU9oS3h4ZklTdk9NQnJGRkprZi9jV3k4SGd2V0RNNTJsMzhlRHRi?=
 =?utf-8?B?ZkkyMjg5MVRWd3oxTVhibElaNHREMkVLKzVlWTJMZndOUDV2dnJkbEI2a3JV?=
 =?utf-8?B?WGtZa3piVi83aVpTUjhaWEM1VlBVeENQVDJrWHo5Y2xhc0k4eVRyNDJQVXZx?=
 =?utf-8?B?S294blR3aTlLQnh6WDBLSEcxTWxveFJzV3pLa2lqMVBTOXJxUHJ3bXBCcjFL?=
 =?utf-8?B?WGgxVkc4Y2h6eVRwamVBdStkckZWODVGUGt5eUZRV2RwbGswZHd1Z3J3dmhp?=
 =?utf-8?B?NDhuNkxWNUkvTjVOdGhsRVRoTFJrZmZyUXgvSmRsZUNEQXJ4L2FwWEVoYWhZ?=
 =?utf-8?B?RlhMbHd2YlREVGpZT2ZDMEw0dXdRRTZzRmhTK2wxYVFocm4ya2pvcVpVWDhp?=
 =?utf-8?B?elM1YTJodFI1NXRlbWIzcTBGZXZxRzlDN2dvNkpCcmpqdjkyelU5U3daM3ZX?=
 =?utf-8?B?QldZSTRNVnVTMmJoYStab2ppSUg0ODc0cFZPNWV3alhjaUQxR2pvRDJuSUlq?=
 =?utf-8?Q?KrcCzSlfU9KS706lOU4tOQ9B+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0111628-3529-4663-d1c3-08dbc32bf780
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 09:43:00.7654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDlQBHrhLy+//M9/GFmDklMWgmyjvfLycXxMn6ZW51P+++r0ZFTxt2glbK/aRJY8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5265
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 28.09.23 um 15:54 schrieb Shashank Sharma:
>
> On 28/09/2023 15:52, Alex Deucher wrote:
>> On Thu, Sep 28, 2023 at 9:40 AM Shashank Sharma 
>> <shashank.sharma@amd.com> wrote:
>>>
>>> On 28/09/2023 15:27, Alex Deucher wrote:
>>>> On Thu, Sep 28, 2023 at 9:22 AM Shashank Sharma 
>>>> <shashank.sharma@amd.com> wrote:
>>>>> On 14/09/2023 10:24, Shashank Sharma wrote:
>>>>>> On 14/09/2023 09:45, Christian König wrote:
>>>>>>> Am 08.09.23 um 18:04 schrieb Shashank Sharma:
>>>>>>>> A Memory queue descriptor (MQD) of a userqueue defines it in
>>>>>>>> the hw's context. As MQD format can vary between different
>>>>>>>> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>>>>>>>>
>>>>>>>> This patch:
>>>>>>>> - Introduces MQD handler functions for the usermode queues.
>>>>>>>> - Adds new functions to create and destroy userqueue MQD for
>>>>>>>>      GFX-GEN-11 IP
>>>>>>>>
>>>>>>>> V1: Worked on review comments from Alex:
>>>>>>>>        - Make MQD functions GEN and IP specific
>>>>>>>>
>>>>>>>> V2: Worked on review comments from Alex:
>>>>>>>>        - Reuse the existing adev->mqd[ip] for MQD creation
>>>>>>>>        - Formatting and arrangement of code
>>>>>>>>
>>>>>>>> V3:
>>>>>>>>        - Integration with doorbell manager
>>>>>>>>
>>>>>>>> V4: Review comments addressed:
>>>>>>>>        - Do not create a new file for userq, reuse gfx_v11_0.c 
>>>>>>>> (Alex)
>>>>>>>>        - Align name of structure members (Luben)
>>>>>>>>        - Don't break up the Cc tag list and the Sob tag list in 
>>>>>>>> commit
>>>>>>>>          message (Luben)
>>>>>>>> V5:
>>>>>>>>       - No need to reserve the bo for MQD (Christian).
>>>>>>>>       - Some more changes to support IP specific MQD creation.
>>>>>>>>
>>>>>>>> V6:
>>>>>>>>       - Add a comment reminding us to replace the
>>>>>>>> amdgpu_bo_create_kernel()
>>>>>>>>         calls while creating MQD object to amdgpu_bo_create() once
>>>>>>>> eviction
>>>>>>>>         fences are ready (Christian).
>>>>>>>>
>>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>>>>>>> ---
>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 16 ++++
>>>>>>>>     drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 77
>>>>>>>> +++++++++++++++++++
>>>>>>>>     .../gpu/drm/amd/include/amdgpu_userqueue.h    | 7 ++
>>>>>>>>     3 files changed, 100 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>>>> index 44769423ba30..03fc8e89eafb 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>>>> @@ -140,12 +140,28 @@ int amdgpu_userq_ioctl(struct drm_device 
>>>>>>>> *dev,
>>>>>>>> void *data,
>>>>>>>>         return r;
>>>>>>>>     }
>>>>>>>>     +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
>>>>>>>> +
>>>>>>>> +static void
>>>>>>>> +amdgpu_userqueue_setup_gfx(struct amdgpu_userq_mgr *uq_mgr)
>>>>>>>> +{
>>>>>>>> +    int maj;
>>>>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>>>>> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
>>>>>>>> +
>>>>>>>> +    /* We support usermode queue only for GFX V11 as of now */
>>>>>>>> +    maj = IP_VERSION_MAJ(version);
>>>>>>>> +    if (maj == 11)
>>>>>>>> +        uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = 
>>>>>>>> &userq_gfx_v11_funcs;
>>>>>>>> +}
>>>>>>> That belongs into gfx_v11.c and not here.
>>>>>> Agree,
>>>>> On a second thought, we can't move it to gfx_v11.c, as this is the 
>>>>> place
>>>>> where we are setting up the gfx_userqueue functions in 
>>>>> fpriv->uq_mgr()
>>>>> for the first time, and we do not have another option but to check 
>>>>> the
>>>>> IP and setup the functions here. The only other option to do this 
>>>>> will
>>>>> be to move  uq_mgr->userq_funcs to adev->gfx.userq_funcs and setup 
>>>>> them
>>>>> with the IP init (as Alex once suggested). Please let me know your
>>>>> thoughts on this.
>>>> That seems cleaner to me.  They should be global anyway and could be
>>>> set as part of the individual IP init sequences.  Then the presence of
>>>> a pointer could be used to determine whether or not a particular IP
>>>> type supports user queues.
>>>>
>>>> Alex
>>>>
>>> So if I understand this correctly, this is how we are looking to 
>>> arrange
>>> the userqueue IP functions:
>>>
>>> - Presence of adev->gfx.funcs.userqueue_funcs() will decide if this IP
>>> supports userqueue or not.
>>>
>>> - sw_init function of the IP will setup these fptrs like:
>>>
>>>     in gfx_v11_0_sw_init :
>>>
>>>       if (GFX_MAJ == 11)
>>>
>>>           adev->gfx.funcs.userqueue_funcs = gfx_v11_0_userqueue_funcs
>> I was thinking something more like:
>>
>> adev->userq_funcs[AMD_IP_BLOCK_TYPE_GFX] = gfx_v11_0_userqueue_funcs;
>>
>> That way there would be one place for all of the all of the fptrs and
>> you could use the IP type to query the right one.
>>
>> And then in the IOCTLs, you could just check if the pointer is 
>> valid.  E.g.,
>>
>> if (!adev->userq_funcs[ip_block_type])
>>     return -EINVAL;
>>
>> etc.
>>
>> You could store any metadata relevant to each userq in the per fd user
>> queue manager and then just pass the state to the global userq
>> functions for each IP.
>
> Makes sense, we can do that, hope this works for Christian as well, 
> @Christian ?

Perfectly fine with me.

Regards,
Christian.

>
> - Shashank
>
>>
>> Alex
>>
>>>
>>> In amdgpu_userqueue_ioctl:
>>>
>>>       |
>>>
>>> CASE: create:
>>>
>>>       amdgpu_userqueue_create()
>>>
>>>       if (adev->gfx.funcs.userqueue_funcs) {
>>>
>>>           adev->gfx.funcs.userqueue_funcs.create_mqd();
>>>
>>>       }
>>>
>>>
>>> CASE: destroy:
>>>
>>>       amdgpu_userqueue_destroy()
>>>
>>>       if (adev->gfx.funcs.userqueue_funcs) {
>>>
>>>           adev->gfx.funcs.userqueue_funcs.destroy_mqd();
>>>
>>>       }
>>>
>>> and so on ...
>>>
>>> Am I getting this right ?
>>>
>>> - Shashank
>>>
>>>>> - Shashank
>>>>>
>>>>>>>> +
>>>>>>>>     int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr,
>>>>>>>> struct amdgpu_device *adev)
>>>>>>>>     {
>>>>>>>>         mutex_init(&userq_mgr->userq_mutex);
>>>>>>>>         idr_init_base(&userq_mgr->userq_idr, 1);
>>>>>>>>         userq_mgr->adev = adev;
>>>>>>>>     +    amdgpu_userqueue_setup_gfx(userq_mgr);
>>>>>>>>         return 0;
>>>>>>>>     }
>>>>>>>>     diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>>>>> index 0451533ddde4..6760abda08df 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>>>>> @@ -30,6 +30,7 @@
>>>>>>>>     #include "amdgpu_psp.h"
>>>>>>>>     #include "amdgpu_smu.h"
>>>>>>>>     #include "amdgpu_atomfirmware.h"
>>>>>>>> +#include "amdgpu_userqueue.h"
>>>>>>>>     #include "imu_v11_0.h"
>>>>>>>>     #include "soc21.h"
>>>>>>>>     #include "nvd.h"
>>>>>>>> @@ -6422,3 +6423,79 @@ const struct amdgpu_ip_block_version
>>>>>>>> gfx_v11_0_ip_block =
>>>>>>>>         .rev = 0,
>>>>>>>>         .funcs = &gfx_v11_0_ip_funcs,
>>>>>>>>     };
>>>>>>>> +
>>>>>>>> +static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr 
>>>>>>>> *uq_mgr,
>>>>>>>> +                      struct drm_amdgpu_userq_in *args_in,
>>>>>>>> +                      struct amdgpu_usermode_queue *queue)
>>>>>>>> +{
>>>>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>>>>> +    struct amdgpu_mqd *mqd_gfx_generic =
>>>>>>>> &adev->mqds[AMDGPU_HW_IP_GFX];
>>>>>>>> +    struct drm_amdgpu_userq_mqd_gfx_v11_0 mqd_user;
>>>>>>>> +    struct amdgpu_mqd_prop userq_props;
>>>>>>>> +    int r;
>>>>>>>> +
>>>>>>>> +    /* Incoming MQD parameters from userspace to be saved here */
>>>>>>>> +    memset(&mqd_user, 0, sizeof(mqd_user));
>>>>>>>> +
>>>>>>>> +    /* Structure to initialize MQD for userqueue using generic 
>>>>>>>> MQD
>>>>>>>> init function */
>>>>>>>> +    memset(&userq_props, 0, sizeof(userq_props));
>>>>>>>> +
>>>>>>>> +    if (args_in->mqd_size != sizeof(struct
>>>>>>>> drm_amdgpu_userq_mqd_gfx_v11_0)) {
>>>>>>>> +        DRM_ERROR("MQD size mismatch\n");
>>>>>>>> +        return -EINVAL;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    if (copy_from_user(&mqd_user, u64_to_user_ptr(args_in->mqd),
>>>>>>>> args_in->mqd_size)) {
>>>>>>>> +        DRM_ERROR("Failed to get user MQD\n");
>>>>>>>> +        return -EFAULT;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    /*
>>>>>>>> +     * Create BO for actual Userqueue MQD now
>>>>>>>> +     * Todo: replace the calls to bo_create_kernel() with
>>>>>>>> bo_create() and use
>>>>>>>> +     * implicit pinning for the MQD buffers.
>>>>>>> Well not implicit pinning, but rather fencing of the BO.
>>>>>>>
>>>>>> Noted.
>>>>>>
>>>>>> - Shashank
>>>>>>
>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>> +     */
>>>>>>>> +    r = amdgpu_bo_create_kernel(adev, mqd_gfx_generic->mqd_size,
>>>>>>>> PAGE_SIZE,
>>>>>>>> +                    AMDGPU_GEM_DOMAIN_GTT,
>>>>>>>> +                    &queue->mqd.obj,
>>>>>>>> +                    &queue->mqd.gpu_addr,
>>>>>>>> +                    &queue->mqd.cpu_ptr);
>>>>>>>> +    if (r) {
>>>>>>>> +        DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
>>>>>>>> +        return -ENOMEM;
>>>>>>>> +    }
>>>>>>>> +    memset(queue->mqd.cpu_ptr, 0, mqd_gfx_generic->mqd_size);
>>>>>>>> +
>>>>>>>> +    /* Initialize the MQD BO with user given values */
>>>>>>>> +    userq_props.wptr_gpu_addr = mqd_user.wptr_va;
>>>>>>>> +    userq_props.rptr_gpu_addr = mqd_user.rptr_va;
>>>>>>>> +    userq_props.queue_size = mqd_user.queue_size;
>>>>>>>> +    userq_props.hqd_base_gpu_addr = mqd_user.queue_va;
>>>>>>>> +    userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
>>>>>>>> +    userq_props.use_doorbell = true;
>>>>>>>> +
>>>>>>>> +    r = mqd_gfx_generic->init_mqd(adev, (void 
>>>>>>>> *)queue->mqd.cpu_ptr,
>>>>>>>> &userq_props);
>>>>>>>> +    if (r) {
>>>>>>>> +        DRM_ERROR("Failed to initialize MQD for userqueue\n");
>>>>>>>> +        goto free_mqd;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    return 0;
>>>>>>>> +
>>>>>>>> +free_mqd:
>>>>>>>> +    amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr,
>>>>>>>> &queue->mqd.cpu_ptr);
>>>>>>>> +    return r;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void
>>>>>>>> +gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, 
>>>>>>>> struct
>>>>>>>> amdgpu_usermode_queue *queue)
>>>>>>>> +{
>>>>>>>> +    struct amdgpu_userq_obj *mqd = &queue->mqd;
>>>>>>>> +
>>>>>>>> +    amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, 
>>>>>>>> &mqd->cpu_ptr);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
>>>>>>>> +    .mqd_create = gfx_v11_0_userq_mqd_create,
>>>>>>>> +    .mqd_destroy = gfx_v11_0_userq_mqd_destroy,
>>>>>>>> +};
>>>>>>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>>>>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>>>>> index 55ed6512a565..240f92796f00 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>>>>> @@ -29,6 +29,12 @@
>>>>>>>>       struct amdgpu_mqd_prop;
>>>>>>>>     +struct amdgpu_userq_obj {
>>>>>>>> +    void         *cpu_ptr;
>>>>>>>> +    uint64_t     gpu_addr;
>>>>>>>> +    struct amdgpu_bo *obj;
>>>>>>>> +};
>>>>>>>> +
>>>>>>>>     struct amdgpu_usermode_queue {
>>>>>>>>         int            queue_type;
>>>>>>>>         uint64_t        doorbell_handle;
>>>>>>>> @@ -37,6 +43,7 @@ struct amdgpu_usermode_queue {
>>>>>>>>         struct amdgpu_mqd_prop    *userq_prop;
>>>>>>>>         struct amdgpu_userq_mgr *userq_mgr;
>>>>>>>>         struct amdgpu_vm    *vm;
>>>>>>>> +    struct amdgpu_userq_obj mqd;
>>>>>>>>     };
>>>>>>>>       struct amdgpu_userq_funcs {

