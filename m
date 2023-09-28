Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD6CE732D8
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 13:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDD5110E662;
	Thu, 28 Sep 2023 13:40:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D57310E65F
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 13:40:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJvXdaBUnhUlDfZ0dVx0BW0XzZzT/jJ62JbspWiHSE+LiIWYpFno+4CiX54o6CnZE/6Z9DgwPryUOZ664TaSm/Itbi2J7PGxWOgiHgCkGF6gPC/pHv+BStpYF2RkIW2NCghszPCmEsiC+HRJ60OPr/zsbrimAAqedyd4E6Lk0LsG6ROvzTE/CQTn2tzBShevnAWIgkXT8xulB9wSKO1SfT1PTGxruvISGNNOw9xrUXrvCo5DO3VYWXAwfQ3XNalekInGpEI9gU9Tn//ZllRxxlTdrL6ZKxHRi5Yp05BkPEI7yzCs8qi4TIGPYn1dXoWLKd/isuuiWlun4Rpq2Tzgeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQ0RKCnGS+JRaPVLVx5YTLdRFTzdCuoBgRLPDoXVKXM=;
 b=fOZO1Wvmddgl+h5fj8IZ3L0Tswh+mlKipfWavu1TnKf+rEG3LKEGrxIOIC+Psd79nWqMkLgPbz0mJ+4C5BcMw31v85jTJtItAr+7ZC9tBOz89gOevMpT25svgoOjzPTCyaRJR1IVN3c32NnX0lDTz23ebICTlO/eRmWTXEDeViHfgnlPZIDwLwk4Nw6T7PIPaE2yMAnHufuNTR8et+tlW/Xnrn2/2GzbbztIJTRB5X0W769aAGx5RZVfzR0C09j+oASnOHVKyJq1XrQbmMtn+hd8tF6U9dqQgYWXqa9B1aSkRXpNsmYU8oz+Yq7bQs2Lp2JUF9ByqkbLZ6WDKspn2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQ0RKCnGS+JRaPVLVx5YTLdRFTzdCuoBgRLPDoXVKXM=;
 b=3or39V8/pXl1vaj/bCUp2WvIorVijxJvIGQnYGLi1xVI8T0pHjNZXlVHe5j1Q0r8dXxaIEU/D56WDBtmPm35BSde+CUDAvyWo0omwFrMMMHA5a/ADNRpPKuLiLTif4WAB7ZtBX2QbSLVHqy7jmrYLVu/Z5zwjIUb+ZBDBzz+fl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SJ1PR12MB6097.namprd12.prod.outlook.com (2603:10b6:a03:488::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 28 Sep
 2023 13:40:45 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::dc06:ffb3:46ec:6b86]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::dc06:ffb3:46ec:6b86%3]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 13:40:45 +0000
Message-ID: <9789fc70-969a-285c-65ae-f33cc613f674@amd.com>
Date: Thu, 28 Sep 2023 15:40:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 4/9] drm/amdgpu: create GFX-gen11 usermode queue
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230908160446.2188-1-shashank.sharma@amd.com>
 <20230908160446.2188-5-shashank.sharma@amd.com>
 <6d579492-1555-4dba-68c6-130266c011a1@amd.com>
 <009e90dd-2cf2-9838-a8c3-f18cbbd29b3d@amd.com>
 <c097f8eb-9866-d4f8-6b18-383dd9b69400@amd.com>
 <CADnq5_Od2uEzpPMGvUx-R2uDtTeymwPvk67Fvm8VW1GV2VU3nA@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_Od2uEzpPMGvUx-R2uDtTeymwPvk67Fvm8VW1GV2VU3nA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::11) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SJ1PR12MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: bbdbd039-4dce-4e6a-d6b0-08dbc0288449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZQ17AnZcqbK9nQZFJSl4+f4ckHXKMxWMo4XiB1K6W0iMvhWTWhqW989RRAVh5bmCmkbnD7C4Cff2IPDW93LaqnIaUsxYF9YOruA0ZrWHU8sbyL/R3S59SZQYnh4ZnGvgs1C4lJoWTFYBpHH3pBvIFTs2PFpxZ129ll/ZXFT5E+CinF7+y43cenC9aTYaKd7Ho9kKdrl1MZjtShnfuLEN3BUjqZObKZROy3rbT0wlJiz/IPWbYHOOhld0nbWkSYeGe/XbOqSKa5w+uALU3Akj1g6lXlGCepB6pu/J+gvatrUBnrHMxPplybLxFOqGZbUukdCNX8JlaDM80C8nVYUTroahYEc5sHou5gds3zWxCmWgWhxRrP0CqY9CPc/ktVjoS3GaJMjfK+QnW4K33/r/aSXBezoQs8C/olL92KbgJnnb9Mb3Vg4NM6bUHGsIQOM5FwlTF8M6IgMr/1JtvJRZdioV0iPIMlacCQZFwQ4B59j1aXBbEyKacJULCW7Ar9R0idYjozRo7ClbVc7GExX45dfpUb4qCj0I3URMErThIFqiTVhjoLvTqJmwfsBO3JSIP0WeD2kJKn1Sk13tbKyhuUsqh83ezDFlAPCk6I06voXTLTehdstkodaBBHn/f/AndZyu7rg9KmyiyWvj3aAQVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(41300700001)(5660300002)(66946007)(66476007)(66556008)(6916009)(54906003)(316002)(66574015)(86362001)(36756003)(31696002)(38100700002)(83380400001)(31686004)(4326008)(44832011)(2906002)(8676002)(8936002)(2616005)(26005)(6486002)(6506007)(6512007)(6666004)(53546011)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djVsd3R3UDJOMTduZmV3QjBUV1lJVld3U2t3bUVVODZrSjRPak52eitWdDdy?=
 =?utf-8?B?RmpWWUZ4aVpLcXh0MTI0SHNDd0JTL2cvQ0N1S1VyRUdNb0hBK3pXZUN5SmUw?=
 =?utf-8?B?SGFXSkVkSmhTSGp1Ym85d2dqcnFOQm81cDVNWlpSWmNza1ZxYjh4YjRQOTZ3?=
 =?utf-8?B?ZE1LTVgyODFSdUhFK05WWG9ZSWJWRWh3M0lGRWR5WHVROStiMkNsM2x6cE1G?=
 =?utf-8?B?Zko5cnhwVUIwa09jRDl0RnJoRThNNEtUd1lvVVRFT2U3eEhSb0lGcVlWRUo0?=
 =?utf-8?B?WnplMkZUclNncGxPSitEUFhScVBCaXpvYXpOZjJBSXpsLzZEcWZzUEdxQW85?=
 =?utf-8?B?bXNZSENTenlXL1FrNFo4R0xKV0Vuc1dFWWpoNEozUUhPRFJ6VTdnRCtDK0Ri?=
 =?utf-8?B?NXlVV3I4dGhBVzdzS2pvUTh6YVB4RlJBTFZDUC9hbUxmTUgxM0l3UVJ2SDhm?=
 =?utf-8?B?blVxL0t6QkFDT3pwUTJsems3NXBkdElnVGN5MmVFekNOcEV1endXV3lNN1BM?=
 =?utf-8?B?eTVXNk9JOGpFSlNiSE0zYmkveU5zakZENzU3dGdTT25zdVh3UmwzM2czMm1x?=
 =?utf-8?B?djRERytaWk1OM1d0dXlzQktVV2V3clRWSFVJM2c2MHBXR0FSM0Q4L0t4V1JM?=
 =?utf-8?B?dlA4eGw1U1B1d3p6RmhhQkdxNDRnUXNiOW1tZ0JXbnlCRDJHZVNBanhMaGwz?=
 =?utf-8?B?c1JQODUyYnZwVHhJY0JHTnlDSjlZQjcrVDZkSFhqTWZ2dkZqSkc2Q2FYU0VZ?=
 =?utf-8?B?RXh2T0dETlBENGtNVzBPY2NVSitCMC9PYkpNbm1FYUxwcWxDcThqV2Y1L0RK?=
 =?utf-8?B?MExISnpGcGdIYkh2d1F4aXpKeTdIVFRTR3FqZDdzbHlqYnpXN0d1cHJsaGlP?=
 =?utf-8?B?M0ppcFc2L0V5VU0xYURHdFg3YVRxV0JxMU1oQmxwbExBMTlSaG5lS0JvZGJu?=
 =?utf-8?B?ZjJ4cHBoL0NyV2toOGxxdXQzalVoY3dORVlaZ2N3R1lZVWdoVy9lQVVRRlEv?=
 =?utf-8?B?dExUOWNTS29GSHQ5SjBaUGlsVE9zb1VadzliREViVU9LVTRneDZtRDM4YndH?=
 =?utf-8?B?bzZLMTZoYnJ0UVJFS0pXZEIzUWRyT3Y5N2tyMDg5ZUdLZ1VsQWlzd0tjUXIz?=
 =?utf-8?B?K3ZxWVlkZklDVG5CbzVUWEV5TGhpNVFxV0pqYi9Ec3A2YzNYU0d3VjZONzVl?=
 =?utf-8?B?YVYyOVFCQ0x2RFVUYi9iRzVJZ0ZDTC9YU3N2cWdSeUQ4NElTTGdTTDVIdGVu?=
 =?utf-8?B?bmZnYUZlQkI4WTgzTzNCcjFkblBCOW1BTmtIZ28vUXlwVUt6QW1GVTgwbEJO?=
 =?utf-8?B?MEtENFhSZmNWMnMxL3hPcmFKT2Qyc0g3VXF5cXdydGZnL0swcktiT1k1Z1hL?=
 =?utf-8?B?VWN6VDRDQ2NIY2NSUWlTbTJZaXV2ejQvdFN0MGx5djVpRG5yREUvOU1rV2ZH?=
 =?utf-8?B?Y3plSTlHZ01ZODZTQ2crVkhvQUVianJsZW9aaDgwbWFzZ2xQUkhIaVRnTHVx?=
 =?utf-8?B?UmdpVGJDbUxsUW13ODk2KytKMmhRNGtrRloyNXhKMXA4QkkyL2htT1ZOMCsx?=
 =?utf-8?B?NHMyT041QTlQNlR0M25pVklLZG1BWGdwRW9Yek9lZVl0K0E2ZjlOVFVBQXB1?=
 =?utf-8?B?OXRHV0VkdE5pajZQczBwN2d4WkdsclFXUVRXekMzVkdFaUZ1NTVsZEpIN1Ju?=
 =?utf-8?B?NVB1Vit2SHROaVpQUW5ZRW9EWndLeEV1dXdOWXVhNng4RU94WjV3eXVxU0Fa?=
 =?utf-8?B?NG1aRUUxRHJERW1wcXZIVUtsRFNxenRqVWZnZ1BiODJBTEFPQzVxZ2xzMDBZ?=
 =?utf-8?B?WmdjOWJSb0Q3cjBSaU1SbU9IblNISi9kUmU2cnJQOVFzaGFTV05KaWJqNTFj?=
 =?utf-8?B?TnA3WnQrOG8zejBQdGdKK2xCdWF4aWJDU2V4d3lKMW9kdkU2WXlYeG1IdzNq?=
 =?utf-8?B?ZGVlaFU0MVVqdUFSR2doNkZJOXpSTkZ0amVhcHU2UFBDcVRnTnBRK2N0bjVD?=
 =?utf-8?B?dFdjNmhHWEtwTFNKQUpwZWd1cHlieXVmUlNPZks2UGhEclZEWTF3ZG5PWDBm?=
 =?utf-8?B?TFZRc3VxRlJIbmRSM01SUDBoOUdHa054djdGQ3dNWC96c3pMS3gyY1RucGow?=
 =?utf-8?Q?VR7YYsbp4GeoAUCX7Dmpi5oxP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbdbd039-4dce-4e6a-d6b0-08dbc0288449
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 13:40:45.4586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUdcNRQoE8f0JIpNqWnKa9drBha5Nxo16XtQ/EF4BrRSkqdewmhO3bVqFXtUQd1weP22IlraPOPVHRpWnGO3Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6097
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
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 28/09/2023 15:27, Alex Deucher wrote:
> On Thu, Sep 28, 2023 at 9:22 AM Shashank Sharma <shashank.sharma@amd.com> wrote:
>>
>> On 14/09/2023 10:24, Shashank Sharma wrote:
>>> On 14/09/2023 09:45, Christian König wrote:
>>>> Am 08.09.23 um 18:04 schrieb Shashank Sharma:
>>>>> A Memory queue descriptor (MQD) of a userqueue defines it in
>>>>> the hw's context. As MQD format can vary between different
>>>>> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>>>>>
>>>>> This patch:
>>>>> - Introduces MQD handler functions for the usermode queues.
>>>>> - Adds new functions to create and destroy userqueue MQD for
>>>>>     GFX-GEN-11 IP
>>>>>
>>>>> V1: Worked on review comments from Alex:
>>>>>       - Make MQD functions GEN and IP specific
>>>>>
>>>>> V2: Worked on review comments from Alex:
>>>>>       - Reuse the existing adev->mqd[ip] for MQD creation
>>>>>       - Formatting and arrangement of code
>>>>>
>>>>> V3:
>>>>>       - Integration with doorbell manager
>>>>>
>>>>> V4: Review comments addressed:
>>>>>       - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
>>>>>       - Align name of structure members (Luben)
>>>>>       - Don't break up the Cc tag list and the Sob tag list in commit
>>>>>         message (Luben)
>>>>> V5:
>>>>>      - No need to reserve the bo for MQD (Christian).
>>>>>      - Some more changes to support IP specific MQD creation.
>>>>>
>>>>> V6:
>>>>>      - Add a comment reminding us to replace the
>>>>> amdgpu_bo_create_kernel()
>>>>>        calls while creating MQD object to amdgpu_bo_create() once
>>>>> eviction
>>>>>        fences are ready (Christian).
>>>>>
>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 16 ++++
>>>>>    drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 77
>>>>> +++++++++++++++++++
>>>>>    .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
>>>>>    3 files changed, 100 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>> index 44769423ba30..03fc8e89eafb 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>> @@ -140,12 +140,28 @@ int amdgpu_userq_ioctl(struct drm_device *dev,
>>>>> void *data,
>>>>>        return r;
>>>>>    }
>>>>>    +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
>>>>> +
>>>>> +static void
>>>>> +amdgpu_userqueue_setup_gfx(struct amdgpu_userq_mgr *uq_mgr)
>>>>> +{
>>>>> +    int maj;
>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
>>>>> +
>>>>> +    /* We support usermode queue only for GFX V11 as of now */
>>>>> +    maj = IP_VERSION_MAJ(version);
>>>>> +    if (maj == 11)
>>>>> +        uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
>>>>> +}
>>>> That belongs into gfx_v11.c and not here.
>>>
>>> Agree,
>> On a second thought, we can't move it to gfx_v11.c, as this is the place
>> where we are setting up the gfx_userqueue functions in fpriv->uq_mgr()
>> for the first time, and we do not have another option but to check the
>> IP and setup the functions here. The only other option to do this will
>> be to move  uq_mgr->userq_funcs to adev->gfx.userq_funcs and setup them
>> with the IP init (as Alex once suggested). Please let me know your
>> thoughts on this.
> That seems cleaner to me.  They should be global anyway and could be
> set as part of the individual IP init sequences.  Then the presence of
> a pointer could be used to determine whether or not a particular IP
> type supports user queues.
>
> Alex
>
So if I understand this correctly, this is how we are looking to arrange 
the userqueue IP functions:

- Presence of adev->gfx.funcs.userqueue_funcs() will decide if this IP 
supports userqueue or not.

- sw_init function of the IP will setup these fptrs like:

   in gfx_v11_0_sw_init :

     if (GFX_MAJ == 11)

         adev->gfx.funcs.userqueue_funcs = gfx_v11_0_userqueue_funcs


In amdgpu_userqueue_ioctl:

     |

CASE: create:

     amdgpu_userqueue_create()

     if (adev->gfx.funcs.userqueue_funcs) {

         adev->gfx.funcs.userqueue_funcs.create_mqd();

     }


CASE: destroy:

     amdgpu_userqueue_destroy()

     if (adev->gfx.funcs.userqueue_funcs) {

         adev->gfx.funcs.userqueue_funcs.destroy_mqd();

     }

and so on ...

Am I getting this right ?

- Shashank

>> - Shashank
>>
>>>>> +
>>>>>    int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr,
>>>>> struct amdgpu_device *adev)
>>>>>    {
>>>>>        mutex_init(&userq_mgr->userq_mutex);
>>>>>        idr_init_base(&userq_mgr->userq_idr, 1);
>>>>>        userq_mgr->adev = adev;
>>>>>    +    amdgpu_userqueue_setup_gfx(userq_mgr);
>>>>>        return 0;
>>>>>    }
>>>>>    diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>> index 0451533ddde4..6760abda08df 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>> @@ -30,6 +30,7 @@
>>>>>    #include "amdgpu_psp.h"
>>>>>    #include "amdgpu_smu.h"
>>>>>    #include "amdgpu_atomfirmware.h"
>>>>> +#include "amdgpu_userqueue.h"
>>>>>    #include "imu_v11_0.h"
>>>>>    #include "soc21.h"
>>>>>    #include "nvd.h"
>>>>> @@ -6422,3 +6423,79 @@ const struct amdgpu_ip_block_version
>>>>> gfx_v11_0_ip_block =
>>>>>        .rev = 0,
>>>>>        .funcs = &gfx_v11_0_ip_funcs,
>>>>>    };
>>>>> +
>>>>> +static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>>>>> +                      struct drm_amdgpu_userq_in *args_in,
>>>>> +                      struct amdgpu_usermode_queue *queue)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>> +    struct amdgpu_mqd *mqd_gfx_generic =
>>>>> &adev->mqds[AMDGPU_HW_IP_GFX];
>>>>> +    struct drm_amdgpu_userq_mqd_gfx_v11_0 mqd_user;
>>>>> +    struct amdgpu_mqd_prop userq_props;
>>>>> +    int r;
>>>>> +
>>>>> +    /* Incoming MQD parameters from userspace to be saved here */
>>>>> +    memset(&mqd_user, 0, sizeof(mqd_user));
>>>>> +
>>>>> +    /* Structure to initialize MQD for userqueue using generic MQD
>>>>> init function */
>>>>> +    memset(&userq_props, 0, sizeof(userq_props));
>>>>> +
>>>>> +    if (args_in->mqd_size != sizeof(struct
>>>>> drm_amdgpu_userq_mqd_gfx_v11_0)) {
>>>>> +        DRM_ERROR("MQD size mismatch\n");
>>>>> +        return -EINVAL;
>>>>> +    }
>>>>> +
>>>>> +    if (copy_from_user(&mqd_user, u64_to_user_ptr(args_in->mqd),
>>>>> args_in->mqd_size)) {
>>>>> +        DRM_ERROR("Failed to get user MQD\n");
>>>>> +        return -EFAULT;
>>>>> +    }
>>>>> +
>>>>> +    /*
>>>>> +     * Create BO for actual Userqueue MQD now
>>>>> +     * Todo: replace the calls to bo_create_kernel() with
>>>>> bo_create() and use
>>>>> +     * implicit pinning for the MQD buffers.
>>>> Well not implicit pinning, but rather fencing of the BO.
>>>>
>>> Noted.
>>>
>>> - Shashank
>>>
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> +     */
>>>>> +    r = amdgpu_bo_create_kernel(adev, mqd_gfx_generic->mqd_size,
>>>>> PAGE_SIZE,
>>>>> +                    AMDGPU_GEM_DOMAIN_GTT,
>>>>> +                    &queue->mqd.obj,
>>>>> +                    &queue->mqd.gpu_addr,
>>>>> +                    &queue->mqd.cpu_ptr);
>>>>> +    if (r) {
>>>>> +        DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
>>>>> +        return -ENOMEM;
>>>>> +    }
>>>>> +    memset(queue->mqd.cpu_ptr, 0, mqd_gfx_generic->mqd_size);
>>>>> +
>>>>> +    /* Initialize the MQD BO with user given values */
>>>>> +    userq_props.wptr_gpu_addr = mqd_user.wptr_va;
>>>>> +    userq_props.rptr_gpu_addr = mqd_user.rptr_va;
>>>>> +    userq_props.queue_size = mqd_user.queue_size;
>>>>> +    userq_props.hqd_base_gpu_addr = mqd_user.queue_va;
>>>>> +    userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
>>>>> +    userq_props.use_doorbell = true;
>>>>> +
>>>>> +    r = mqd_gfx_generic->init_mqd(adev, (void *)queue->mqd.cpu_ptr,
>>>>> &userq_props);
>>>>> +    if (r) {
>>>>> +        DRM_ERROR("Failed to initialize MQD for userqueue\n");
>>>>> +        goto free_mqd;
>>>>> +    }
>>>>> +
>>>>> +    return 0;
>>>>> +
>>>>> +free_mqd:
>>>>> +    amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr,
>>>>> &queue->mqd.cpu_ptr);
>>>>> +    return r;
>>>>> +}
>>>>> +
>>>>> +static void
>>>>> +gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct
>>>>> amdgpu_usermode_queue *queue)
>>>>> +{
>>>>> +    struct amdgpu_userq_obj *mqd = &queue->mqd;
>>>>> +
>>>>> +    amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>>>>> +}
>>>>> +
>>>>> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
>>>>> +    .mqd_create = gfx_v11_0_userq_mqd_create,
>>>>> +    .mqd_destroy = gfx_v11_0_userq_mqd_destroy,
>>>>> +};
>>>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>> index 55ed6512a565..240f92796f00 100644
>>>>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>> @@ -29,6 +29,12 @@
>>>>>      struct amdgpu_mqd_prop;
>>>>>    +struct amdgpu_userq_obj {
>>>>> +    void         *cpu_ptr;
>>>>> +    uint64_t     gpu_addr;
>>>>> +    struct amdgpu_bo *obj;
>>>>> +};
>>>>> +
>>>>>    struct amdgpu_usermode_queue {
>>>>>        int            queue_type;
>>>>>        uint64_t        doorbell_handle;
>>>>> @@ -37,6 +43,7 @@ struct amdgpu_usermode_queue {
>>>>>        struct amdgpu_mqd_prop    *userq_prop;
>>>>>        struct amdgpu_userq_mgr *userq_mgr;
>>>>>        struct amdgpu_vm    *vm;
>>>>> +    struct amdgpu_userq_obj mqd;
>>>>>    };
>>>>>      struct amdgpu_userq_funcs {
