Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE783E732D0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 13:54:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B9D010E669;
	Thu, 28 Sep 2023 13:54:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4640E10E666
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 13:54:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ED1hUZ5KhPbzjdF4uC1NHl173mMhOWZLaw2tCIj4MLYkKfnwoSNWs0Ub3Q93R33kh82dHNiJ4sAmgyv7DYPdYtr8IIbqh3MGFb0jFuiZlgaJRdAqwyWrVK9cXgGeyR9WMjc/tUe6KL4JvetxXpMpy3KYyz1xOH4wi2j/H+3ukEuDYWrNZ3Sy75CA7ynOePRsIkOb63Iv2gI1wVIIo581nS6iXsiLyKC5hxqcK/aAHKQTpziBQ4ENS50PeRjBrVkIJD4aaqn78X/H1t+slAYSgnHEmps3b8DD7MxYtMKorxE5mRP4VCgVG/KBBXoMHk0UWI9vd0jOSkEGZTmV83u/jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gwo5uJQk3i5UHw1EEO4MqtXE6qJPKWAi+StrsSnC5bc=;
 b=ZDSWCI3RB/g7YGdg8+JD7JhsLuwLkksL31HN82yDD2BFaD1DfazTdS/kaP40Q6vT4KUoSpnnhrMU2LpMQXGENdp9JFKtcRWlP+Po71fpi12g1K5n/Bw1Oscwt8g6EFcrDjsdpuoNW5mLJVvt/NF0FwwN241U1fAiayD1ETP/oniVVrKkaCLiPPo5CESXzAoUX4jwGQ4wJ6skeZTHI+aplH/54WNDDpihwCnnaDtmWiWmYCjzol4Ezs5DJosQgbBBbFs0rCiwYvPsYpbJ9/LclMaNKorfdf2JIx+IWd4br1+WLkFZwDMVkIV9ecTRW5cfJ2Fc7K90xqKLmBeiGx+LxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gwo5uJQk3i5UHw1EEO4MqtXE6qJPKWAi+StrsSnC5bc=;
 b=lTL/zu8BC0xGeXMp3xFtgKgA8aKuXfXRotpIBLD4sDAheXekpQlxjm4qkBZVeXD/+NW2BOKKctE/c0H4AaLUC4DxnWSM0D026NM0UZGWbi9oFrWVhDoXynUO638izG9lvmXxH0iEq2Uk6pYlhnmldKv7T4XgovBz6gwqFohKE2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SJ1PR12MB6219.namprd12.prod.outlook.com (2603:10b6:a03:456::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 28 Sep
 2023 13:54:26 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::dc06:ffb3:46ec:6b86]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::dc06:ffb3:46ec:6b86%3]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 13:54:26 +0000
Message-ID: <eff6cc36-9f73-b64e-3127-a1d6e85b5037@amd.com>
Date: Thu, 28 Sep 2023 15:54:18 +0200
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
 <9789fc70-969a-285c-65ae-f33cc613f674@amd.com>
 <CADnq5_NbrmBT1=82yBZYB31=e_3GOELOLZrfoevBvb2WCaV7sQ@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_NbrmBT1=82yBZYB31=e_3GOELOLZrfoevBvb2WCaV7sQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0250.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::17) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SJ1PR12MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d7c9f4-4601-4df4-9d16-08dbc02a6da4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wz8qXBc+ScvZ9KvrKRyZvqMp3nj4gwme8nMD+j4YR5qYAu2vnJraCn+u7+v5lZ1cjIQWN0Slm2G0y6wnh80Ks51lkbi5lhJvYj3ZzRXtxmrBzYHKzXXhIaUWQ3h5kVHjcNlojhC1nGjOcqyALgU/ziVJogArW9p1teO8MVfUROy96yf60wzGlCPxUBI0793ARLbMvYbW350zLXHju7vxZHc2zdb4QzfoIrZTAXGu0fM/M6cI5k3W6hp2Wke+/SR4avmeIGeV4zuOMGT7gWC52kL4giG1PaVj3eWNSATm/gd+bpQeAm220P6kWnDsBsMBz8e4v/u0kQfDxR4ANDnaluCUp/CMRqYNyPlMtXz1ofKbCWg25vh+zaEBoJEUwdxvZ9zGh0WmCtRKvj1FheaPz8yOoWMQ2L/OBsCP908JNlzE+LbtRC8pm6kYqTAhfQ/f17M3qNHvqlBSVhV4QT8nqJd/85ZMHFnq4CYKF++l/swyC7zaR9FIMoWXulFdE2asy3VedY0X9sNMBCJEKNPwQRWtGsZXG72GefVVQrwUNDYEADt7ExAgaSGjwx8B724bvz/znrQTEyslOE3Im8pGek3vNEmy4hMV5ExjWCEEB4Yix07qt3iDM6O7BDLMN2vGHcHdtnok8OcwTrntx7OB2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6486002)(36756003)(6666004)(53546011)(6506007)(83380400001)(316002)(6512007)(44832011)(41300700001)(2616005)(8676002)(66574015)(2906002)(5660300002)(66556008)(66476007)(8936002)(66946007)(6916009)(4326008)(30864003)(26005)(86362001)(38100700002)(31696002)(54906003)(478600001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SElzS3lzTHNYd1VrSFhVVmtDbUd2TURSMXF6ZE5ibEIveGRQM1EyT2Q0d3Yv?=
 =?utf-8?B?a1F5T0tqMVdoMG9VNDNMUXE5VngwYXBIaWZscjJjTm1QTGZPYU1pVmFiSkY2?=
 =?utf-8?B?NzFETmk1cTRkUkRISE5jTWlRaGhDemYzTnFuVTZqdnZFa1ZnRzVPZE5JbzE4?=
 =?utf-8?B?OW14MW1EbUVIOGlPMStqNVJWL0xwSko5NWJ0MURkVndhRVl5aWRJRlNpT1ZL?=
 =?utf-8?B?andhVU05VG45d2EzWmo5Z2pTa1JibTlnVUZ6Yjk1UDFzSWsxSEdlMU81TnBV?=
 =?utf-8?B?c2V4VithbklhWTJBTGJObVpkdVQ5OVlFUjhaQytNVkpKcE5aK0ZMa0Q0dU1M?=
 =?utf-8?B?OTBDd01IMmR6dndhckNBN1plYSt4amdGMnJLNnJzaDJXK3NKdlQvNEppRlFt?=
 =?utf-8?B?MXNYUC9LZnFVcWpmbVk0U3VrOWlFcVVXYkdXWUNFNzA2d3IvU3A4dDhPMVFB?=
 =?utf-8?B?N1phVDlqOU1FZzRXcjY1dGdZQUdPK3lLYWYrc3NHcnk2WkdqZGRmRi9qckl0?=
 =?utf-8?B?Yk1XOUlmV0d4UEVsQkR4RXdVdWEvV1hMRzFhY3dYeFd2TWJBU2dLUXVtZVNk?=
 =?utf-8?B?ZFhPaThaWi9VU2ZQM3E4enhveSs1TVQyVmg0eGU4RjFZOVZaNVVpYmNGQnh2?=
 =?utf-8?B?Ukt0RXgzbkdnb0l4bWxpY1hpOUk0dmlBai9ad0YzQnVFZVpObnJZQzRTUVFu?=
 =?utf-8?B?YjlGNFV1eDlSMDl6S0pHV3RsVnNoYzFsR0kxNVp0RE94VERsQWdnYUNFYzRr?=
 =?utf-8?B?RXF0dC9CdnZHSEQ5dnBveUYxVllIU3pqT2VBcmRncGFwbzR6TVpQdFRDcG1Z?=
 =?utf-8?B?SERnSHlTbkY2aDk4TDhCU2lYVFFYdXJrclY0WVZpazVaMU5LSWJncFBWOWpi?=
 =?utf-8?B?eGxQa2tTSUIzWDcxbE9ybmZ0amZKMldSN0VXbWUwbXdXK0RiRlNBNUNhSlpS?=
 =?utf-8?B?MkZsU1hzcjRjcFNYWTJOc3d0TllhcG1hTDZVK3E0Y0VWdTBOc2JvZW1CNzVm?=
 =?utf-8?B?Nmh6TCs0S3FVZ2tabEtkQlc3T05MbnBnSVBIZ1dYL2lWMysxdythOXhEQW9k?=
 =?utf-8?B?YWs3Y0NPaC9DNmlRVkNMRGtVbTZlL1pBVlRFMmkyZXJHMENocVBwWjV3eDl2?=
 =?utf-8?B?cldERndKM2xoWjczak1FRld4WmU0L0FTWkU2ZWx6bklWWWFSai8zRUh6Q1Jh?=
 =?utf-8?B?eTV5bFMxSGwvYnZyTEJmNUFsbkhWWUUrbTJTN1dBWVR4UVNLYS92STdDeGVU?=
 =?utf-8?B?RXN5NVhocnVOV09BM2lnM3VJN01FN1Q1NEhub2JlNTdvV0doK0RWQ2RmME5D?=
 =?utf-8?B?SThqZ1gvdjUxZWMxeUswN3JqYlpzSnE3bEkwRG9GaTZFdTZWUTRXUGRMV3Vr?=
 =?utf-8?B?Z3RqY0VTMlBxQTFPZnN4ZkY2S1k4SVlyZVBHenpHdUlhNlZZM3ZadStSamRE?=
 =?utf-8?B?ZUQ2Y2tjbnZtWjgycHVGbjF4NlFWR3JCTk9WL2Q3RGdXd3FuSUJTMmp3UnJ1?=
 =?utf-8?B?NmdqZUhTbmZQc3lUWmFzVStLeVg0VlJ4U0RadEdOQ1Q5bWVLVEtzdThnQVBR?=
 =?utf-8?B?bS9QUHZKejBmMjlaN2ZHd0gwRkdIYTJtYnlDQmNSU1phODZUcnBWYnNMYncz?=
 =?utf-8?B?YkplYk5vTHZQZ3F0Ri9Ycms3M3JBaGdkcmIrZDJja2w1c3dRZlJQaVl2YzZB?=
 =?utf-8?B?eU5QM3lZbCs4NW85SE0yc1E0RlVlU2xUTG56VVBROWZ1RGJkaXNzQVlYNHh2?=
 =?utf-8?B?QUFlMUdHRW41c1Z3ZWJlL1FsbmFCdXpMZWdEUHduTit6bHRyV3lEZlZiekQw?=
 =?utf-8?B?UWJmTkoxb2cySGp0aldBRHZFNzNZMEo5dFBmS2ttSkx6N20xZ1ltTmNYb0lZ?=
 =?utf-8?B?MXVBTjdaME1zdWVodE4zc2JRWVRkeDh3WVR1NlVPdUNBNXdnb3Q2NUlFUkFu?=
 =?utf-8?B?QmxSMzB4SzR0MHhXa3FkSnlpTndoZStYcDhrR1ExZUNZOTBNdnYxdzJpZGtE?=
 =?utf-8?B?cDhUR0d4Uk80T1ZlOXlFOTBOcVhKeWFydUpTemhJSndFWlNBQTZ0eGdFcDk0?=
 =?utf-8?B?RVdxaTdCVzJWNTN4TWQ4VlR6NWlzVmZiMWdISk1UeGlIemRONXNHRWlna200?=
 =?utf-8?Q?QShzelims93CEm7ti3Jn0Cc8Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d7c9f4-4601-4df4-9d16-08dbc02a6da4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 13:54:26.6427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZ9lW9s78UA5EU16e6+pOmXJCoiWVu8Xx7cOL92nN6veokDk74DgFbkMHcb4BF2q4kOPC0bCzFt8O5r9TCHc0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6219
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


On 28/09/2023 15:52, Alex Deucher wrote:
> On Thu, Sep 28, 2023 at 9:40 AM Shashank Sharma <shashank.sharma@amd.com> wrote:
>>
>> On 28/09/2023 15:27, Alex Deucher wrote:
>>> On Thu, Sep 28, 2023 at 9:22 AM Shashank Sharma <shashank.sharma@amd.com> wrote:
>>>> On 14/09/2023 10:24, Shashank Sharma wrote:
>>>>> On 14/09/2023 09:45, Christian König wrote:
>>>>>> Am 08.09.23 um 18:04 schrieb Shashank Sharma:
>>>>>>> A Memory queue descriptor (MQD) of a userqueue defines it in
>>>>>>> the hw's context. As MQD format can vary between different
>>>>>>> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>>>>>>>
>>>>>>> This patch:
>>>>>>> - Introduces MQD handler functions for the usermode queues.
>>>>>>> - Adds new functions to create and destroy userqueue MQD for
>>>>>>>      GFX-GEN-11 IP
>>>>>>>
>>>>>>> V1: Worked on review comments from Alex:
>>>>>>>        - Make MQD functions GEN and IP specific
>>>>>>>
>>>>>>> V2: Worked on review comments from Alex:
>>>>>>>        - Reuse the existing adev->mqd[ip] for MQD creation
>>>>>>>        - Formatting and arrangement of code
>>>>>>>
>>>>>>> V3:
>>>>>>>        - Integration with doorbell manager
>>>>>>>
>>>>>>> V4: Review comments addressed:
>>>>>>>        - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
>>>>>>>        - Align name of structure members (Luben)
>>>>>>>        - Don't break up the Cc tag list and the Sob tag list in commit
>>>>>>>          message (Luben)
>>>>>>> V5:
>>>>>>>       - No need to reserve the bo for MQD (Christian).
>>>>>>>       - Some more changes to support IP specific MQD creation.
>>>>>>>
>>>>>>> V6:
>>>>>>>       - Add a comment reminding us to replace the
>>>>>>> amdgpu_bo_create_kernel()
>>>>>>>         calls while creating MQD object to amdgpu_bo_create() once
>>>>>>> eviction
>>>>>>>         fences are ready (Christian).
>>>>>>>
>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 16 ++++
>>>>>>>     drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 77
>>>>>>> +++++++++++++++++++
>>>>>>>     .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
>>>>>>>     3 files changed, 100 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>>> index 44769423ba30..03fc8e89eafb 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>>> @@ -140,12 +140,28 @@ int amdgpu_userq_ioctl(struct drm_device *dev,
>>>>>>> void *data,
>>>>>>>         return r;
>>>>>>>     }
>>>>>>>     +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
>>>>>>> +
>>>>>>> +static void
>>>>>>> +amdgpu_userqueue_setup_gfx(struct amdgpu_userq_mgr *uq_mgr)
>>>>>>> +{
>>>>>>> +    int maj;
>>>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>>>> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
>>>>>>> +
>>>>>>> +    /* We support usermode queue only for GFX V11 as of now */
>>>>>>> +    maj = IP_VERSION_MAJ(version);
>>>>>>> +    if (maj == 11)
>>>>>>> +        uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
>>>>>>> +}
>>>>>> That belongs into gfx_v11.c and not here.
>>>>> Agree,
>>>> On a second thought, we can't move it to gfx_v11.c, as this is the place
>>>> where we are setting up the gfx_userqueue functions in fpriv->uq_mgr()
>>>> for the first time, and we do not have another option but to check the
>>>> IP and setup the functions here. The only other option to do this will
>>>> be to move  uq_mgr->userq_funcs to adev->gfx.userq_funcs and setup them
>>>> with the IP init (as Alex once suggested). Please let me know your
>>>> thoughts on this.
>>> That seems cleaner to me.  They should be global anyway and could be
>>> set as part of the individual IP init sequences.  Then the presence of
>>> a pointer could be used to determine whether or not a particular IP
>>> type supports user queues.
>>>
>>> Alex
>>>
>> So if I understand this correctly, this is how we are looking to arrange
>> the userqueue IP functions:
>>
>> - Presence of adev->gfx.funcs.userqueue_funcs() will decide if this IP
>> supports userqueue or not.
>>
>> - sw_init function of the IP will setup these fptrs like:
>>
>>     in gfx_v11_0_sw_init :
>>
>>       if (GFX_MAJ == 11)
>>
>>           adev->gfx.funcs.userqueue_funcs = gfx_v11_0_userqueue_funcs
> I was thinking something more like:
>
> adev->userq_funcs[AMD_IP_BLOCK_TYPE_GFX] = gfx_v11_0_userqueue_funcs;
>
> That way there would be one place for all of the all of the fptrs and
> you could use the IP type to query the right one.
>
> And then in the IOCTLs, you could just check if the pointer is valid.  E.g.,
>
> if (!adev->userq_funcs[ip_block_type])
>     return -EINVAL;
>
> etc.
>
> You could store any metadata relevant to each userq in the per fd user
> queue manager and then just pass the state to the global userq
> functions for each IP.

Makes sense, we can do that, hope this works for Christian as well, 
@Christian ?

- Shashank

>
> Alex
>
>>
>> In amdgpu_userqueue_ioctl:
>>
>>       |
>>
>> CASE: create:
>>
>>       amdgpu_userqueue_create()
>>
>>       if (adev->gfx.funcs.userqueue_funcs) {
>>
>>           adev->gfx.funcs.userqueue_funcs.create_mqd();
>>
>>       }
>>
>>
>> CASE: destroy:
>>
>>       amdgpu_userqueue_destroy()
>>
>>       if (adev->gfx.funcs.userqueue_funcs) {
>>
>>           adev->gfx.funcs.userqueue_funcs.destroy_mqd();
>>
>>       }
>>
>> and so on ...
>>
>> Am I getting this right ?
>>
>> - Shashank
>>
>>>> - Shashank
>>>>
>>>>>>> +
>>>>>>>     int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr,
>>>>>>> struct amdgpu_device *adev)
>>>>>>>     {
>>>>>>>         mutex_init(&userq_mgr->userq_mutex);
>>>>>>>         idr_init_base(&userq_mgr->userq_idr, 1);
>>>>>>>         userq_mgr->adev = adev;
>>>>>>>     +    amdgpu_userqueue_setup_gfx(userq_mgr);
>>>>>>>         return 0;
>>>>>>>     }
>>>>>>>     diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>>>> index 0451533ddde4..6760abda08df 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>>>> @@ -30,6 +30,7 @@
>>>>>>>     #include "amdgpu_psp.h"
>>>>>>>     #include "amdgpu_smu.h"
>>>>>>>     #include "amdgpu_atomfirmware.h"
>>>>>>> +#include "amdgpu_userqueue.h"
>>>>>>>     #include "imu_v11_0.h"
>>>>>>>     #include "soc21.h"
>>>>>>>     #include "nvd.h"
>>>>>>> @@ -6422,3 +6423,79 @@ const struct amdgpu_ip_block_version
>>>>>>> gfx_v11_0_ip_block =
>>>>>>>         .rev = 0,
>>>>>>>         .funcs = &gfx_v11_0_ip_funcs,
>>>>>>>     };
>>>>>>> +
>>>>>>> +static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>>>>>>> +                      struct drm_amdgpu_userq_in *args_in,
>>>>>>> +                      struct amdgpu_usermode_queue *queue)
>>>>>>> +{
>>>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>>>> +    struct amdgpu_mqd *mqd_gfx_generic =
>>>>>>> &adev->mqds[AMDGPU_HW_IP_GFX];
>>>>>>> +    struct drm_amdgpu_userq_mqd_gfx_v11_0 mqd_user;
>>>>>>> +    struct amdgpu_mqd_prop userq_props;
>>>>>>> +    int r;
>>>>>>> +
>>>>>>> +    /* Incoming MQD parameters from userspace to be saved here */
>>>>>>> +    memset(&mqd_user, 0, sizeof(mqd_user));
>>>>>>> +
>>>>>>> +    /* Structure to initialize MQD for userqueue using generic MQD
>>>>>>> init function */
>>>>>>> +    memset(&userq_props, 0, sizeof(userq_props));
>>>>>>> +
>>>>>>> +    if (args_in->mqd_size != sizeof(struct
>>>>>>> drm_amdgpu_userq_mqd_gfx_v11_0)) {
>>>>>>> +        DRM_ERROR("MQD size mismatch\n");
>>>>>>> +        return -EINVAL;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    if (copy_from_user(&mqd_user, u64_to_user_ptr(args_in->mqd),
>>>>>>> args_in->mqd_size)) {
>>>>>>> +        DRM_ERROR("Failed to get user MQD\n");
>>>>>>> +        return -EFAULT;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    /*
>>>>>>> +     * Create BO for actual Userqueue MQD now
>>>>>>> +     * Todo: replace the calls to bo_create_kernel() with
>>>>>>> bo_create() and use
>>>>>>> +     * implicit pinning for the MQD buffers.
>>>>>> Well not implicit pinning, but rather fencing of the BO.
>>>>>>
>>>>> Noted.
>>>>>
>>>>> - Shashank
>>>>>
>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>> +     */
>>>>>>> +    r = amdgpu_bo_create_kernel(adev, mqd_gfx_generic->mqd_size,
>>>>>>> PAGE_SIZE,
>>>>>>> +                    AMDGPU_GEM_DOMAIN_GTT,
>>>>>>> +                    &queue->mqd.obj,
>>>>>>> +                    &queue->mqd.gpu_addr,
>>>>>>> +                    &queue->mqd.cpu_ptr);
>>>>>>> +    if (r) {
>>>>>>> +        DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
>>>>>>> +        return -ENOMEM;
>>>>>>> +    }
>>>>>>> +    memset(queue->mqd.cpu_ptr, 0, mqd_gfx_generic->mqd_size);
>>>>>>> +
>>>>>>> +    /* Initialize the MQD BO with user given values */
>>>>>>> +    userq_props.wptr_gpu_addr = mqd_user.wptr_va;
>>>>>>> +    userq_props.rptr_gpu_addr = mqd_user.rptr_va;
>>>>>>> +    userq_props.queue_size = mqd_user.queue_size;
>>>>>>> +    userq_props.hqd_base_gpu_addr = mqd_user.queue_va;
>>>>>>> +    userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
>>>>>>> +    userq_props.use_doorbell = true;
>>>>>>> +
>>>>>>> +    r = mqd_gfx_generic->init_mqd(adev, (void *)queue->mqd.cpu_ptr,
>>>>>>> &userq_props);
>>>>>>> +    if (r) {
>>>>>>> +        DRM_ERROR("Failed to initialize MQD for userqueue\n");
>>>>>>> +        goto free_mqd;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    return 0;
>>>>>>> +
>>>>>>> +free_mqd:
>>>>>>> +    amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr,
>>>>>>> &queue->mqd.cpu_ptr);
>>>>>>> +    return r;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static void
>>>>>>> +gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct
>>>>>>> amdgpu_usermode_queue *queue)
>>>>>>> +{
>>>>>>> +    struct amdgpu_userq_obj *mqd = &queue->mqd;
>>>>>>> +
>>>>>>> +    amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>>>>>>> +}
>>>>>>> +
>>>>>>> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
>>>>>>> +    .mqd_create = gfx_v11_0_userq_mqd_create,
>>>>>>> +    .mqd_destroy = gfx_v11_0_userq_mqd_destroy,
>>>>>>> +};
>>>>>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>>>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>>>> index 55ed6512a565..240f92796f00 100644
>>>>>>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>>>> @@ -29,6 +29,12 @@
>>>>>>>       struct amdgpu_mqd_prop;
>>>>>>>     +struct amdgpu_userq_obj {
>>>>>>> +    void         *cpu_ptr;
>>>>>>> +    uint64_t     gpu_addr;
>>>>>>> +    struct amdgpu_bo *obj;
>>>>>>> +};
>>>>>>> +
>>>>>>>     struct amdgpu_usermode_queue {
>>>>>>>         int            queue_type;
>>>>>>>         uint64_t        doorbell_handle;
>>>>>>> @@ -37,6 +43,7 @@ struct amdgpu_usermode_queue {
>>>>>>>         struct amdgpu_mqd_prop    *userq_prop;
>>>>>>>         struct amdgpu_userq_mgr *userq_mgr;
>>>>>>>         struct amdgpu_vm    *vm;
>>>>>>> +    struct amdgpu_userq_obj mqd;
>>>>>>>     };
>>>>>>>       struct amdgpu_userq_funcs {
