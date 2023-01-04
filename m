Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611F8C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 09:24:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE34E10E436;
	Wed,  4 Jan 2023 09:24:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F35D210E436
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jan 2023 09:24:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8iQ8t+My8IpU3QjVv732MV7L2+ablzaU1ok817oBbP6mD3kve39ZWAGxDRQdF0Ix3wuJcJJnd7ASm1IMIw6BNNy+yf5kujCxKaIGlNKVvt4nYH8zZ7c071m4Q4pbf5uzLSBYjzDPyAmgB/Gm/gbURjwFzkf8voteaNjIf5QfHRQo+9LmeU0mRaDABu321kdaj01dU0v91X0i8HWlm4Q1wdXXB//4wzi0kReoivOKmQgOobmcOUPcLrgk3XMFnOf2BaCBq/y51IwtzDik1DjHRF3nZ+R3X+5hq2va7BdQWcy+4wylI8s8hcIASfGoP8bSn1GHQiPIdUVk6JdXHzWcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTF21P7JjLgkQjw7xmZxwrvNmCgBLcIl8AOvQdPpygM=;
 b=NfHr7waAQLFC/rfKAfmhxtVKHye1GUo3Mn8gY5+hNk7aj+Eud0wPRPBV5htfD7VYYLGDzf03qZhiiOaYT8NYMXwx3aSRBE+8QmrDPNNAgs5wU79NyaxJpC00v0rtlhg4NkogCZoBF2muHaH5WuKAHmc2ogAKoruLzqe04nhSyaldHI4eq+3KFTaS6HVLeHyzQHP0/6RqqthJ7v4PSdAD694e/2HOZfRXeC0uOq/dG70m5EvQ4zYlkCokXMOB0lwaTHVz7TwTUO/0RMDPWK1+bWnSnd+2wgduVkpk3S2wF8iO4jDGglz+nfrLdpYHqx8ufE5SL9jJoIxTE9CD2g3NzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTF21P7JjLgkQjw7xmZxwrvNmCgBLcIl8AOvQdPpygM=;
 b=XOWkN5TFzMAre2U/Od4EvfupuxJW/ThZWMF9viJziEzTryS6i4djq9AItE7CDaEp8DOEH0XThcnxcmRvOnzmLViuSL1f0zUuNatElc5ihPXHguHjwzE5lhkF8vWMVpmzEOunWo19E22ojep1kqB20LZ8u1IP2fDYXuSbZ8pxV8w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 09:24:02 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367%5]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 09:24:01 +0000
Message-ID: <393ab51d-c4bc-07d4-7502-884d188a61d6@amd.com>
Date: Wed, 4 Jan 2023 10:23:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC 3/7] drm/amdgpu: Create MQD for userspace queue
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Yadav, Arvind" <arvyadav@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-4-shashank.sharma@amd.com>
 <CADnq5_NONiTu2oEEV1+epbuaH985QBbqMKuM9ZDYEn7Ar5a2pw@mail.gmail.com>
 <d19ada1d-86c1-7278-9bf2-a7571c2830e1@amd.com>
 <a71ce770-7e36-0589-2c47-b0381566541c@amd.com>
 <a75feb71-1121-63cd-5292-503588ee9c88@amd.com>
 <a168df59-8cd3-0262-473a-c4b5f63dc491@amd.com>
 <ced7bb3b-6de2-145c-ccfd-1143529f0990@amd.com>
 <8b00b4b7-640d-4a85-b98f-8fd2a277bea5@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <8b00b4b7-640d-4a85-b98f-8fd2a277bea5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::14) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d31e5a2-1bc0-412a-25f5-08daee356a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: knbqPGqIGQOs/7lCeVXqbbXcWfGpdp0XfzNmUHx2A9H/zU+sw845VPJC2qMPI5LLMKOQ93hVibwUrK0I7VngnMWsANOQgpZRe8IeBhdB48keWWaiHLjkNnRJwN2MQcW1OB1+s5PD8Yii4llyGM9XNG7VRkh25LaIm3HKX3pXTzjZTu9yzByiyQPtUYLgjCUj9vjK3apTeoc+Jy0Dru2Ms/+xDcUdzjirC8MyFGskq3qzvjtw5mY6NFAFvNZRjqjXjAEjuuhxI6w8uYRp+lT8Sv8nR9qbaiMPtJLa0HJq2dkRf8bg6LNKECRef0oSO4XBT56i9yYd36r3zOyDCgTTb9cHSoogS3QdqfKABNYa8+d8+mJ0h+Z9otKMvyFjmAn2t50KMVLMnEdx+uSf4BPVIOLUKg27oygD9etUj85qJKSdsVCm4qIYqkr+1klOamagEyjCdYC/x3b64BlXec4Dxjz9PzPkwq9Mx2HTFJtRLDK6Oqt2bVcKfKzD6t5xTciGUR05HKFjDECAks7dl6wpD5K+9hjEQhRuNnMoaGg/smEinQON1LkjlrC2yYgnrXOk5QSWSwJxoeMKvcZwUYMP4g1l9KQmaITbv+0E8wthYKc10C4Scdel2VnfhrDWk5+dAB49gK56PZ2ef73JYNNPH1+/GyOyS69m3GCyKgwRyj8Muv1V1UUPpQjvtEVePIGvG2B9N/+7yuCi70uJt1rZtihCIsapSSijGDJC9xPYV8I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199015)(5660300002)(2906002)(44832011)(8936002)(41300700001)(4326008)(478600001)(8676002)(316002)(66476007)(110136005)(66946007)(66556008)(6486002)(31686004)(6512007)(26005)(6506007)(6666004)(83380400001)(66574015)(186003)(38100700002)(53546011)(2616005)(31696002)(86362001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWxjSzNVcUVwbmlrbFBBVktsRVFxV0g4UWc3MjNMUTREajQ4S2V6bTZuUVAy?=
 =?utf-8?B?WGo0Q3EzVGx1ZEdNdjl3cmlEMjk3VzZINFprcGhXTTZYV29va25TSU10T3g5?=
 =?utf-8?B?UWUrMFAyb0JYWkRpTkNSOWpyYy85RExoUmJBbjhweCtwZjVFR3RMTlZiMHp1?=
 =?utf-8?B?VWMwSlpFVTAxdUNLZVBSSWdxY2tCTmpVVC81RVp1bXo3dDVnQXFUNVRZTGps?=
 =?utf-8?B?Q0taaDBtTGY2TW9FYnc1Ry8xeFFXWm9yS0hQeitJSjFkRzFVZDZkc01FRGw3?=
 =?utf-8?B?RlhOY2o3SWcvaDhMemtzS3lhN2src09LbDMxL1Z2eFU4cEEveHJIOVdjTUo2?=
 =?utf-8?B?U3VYNVRWeVBBcnhpVlMvVmFPR2pRVDVONmJKU3dscGxKNTV3Q3IwUnp4Szcr?=
 =?utf-8?B?eHA0SHhxUFV5bnhOT3hsRzZzVFBmVGhEMlU1ZGJWUEcyTkp1aHNQWDVFWHlO?=
 =?utf-8?B?OGhrczQ4SGZRZGkzdEFJS2NDRUtMQzIwY3FFSjZ6Y1lCaEN2eno2S3cxSzVI?=
 =?utf-8?B?SjRZVGRSbHVBQTRUQ1QwVmdoeHZCUktVNFZZeHo1anNpTXhQbUR0NWpZc1cv?=
 =?utf-8?B?MEtpTks1ckpnbmJXUVV0MUJiUUZnUTV6OGcxMC80bUNJMGNQM3M5ZWc0ZklO?=
 =?utf-8?B?bGNSdldkVjBmTVNVbGR0clRmSjZQSzJQdzFuZ0s0L0RJclA1QTBqRzZ1Qkdo?=
 =?utf-8?B?QnRWUG1TaktNWmdvYVkrdzdiN3h6V0lzenlLWVJqZG1kTDdqaERuc2paMjBU?=
 =?utf-8?B?RTZjeWtJYjBxTlpOOUdobnBoSy9HMm44Mi94TFptOTZ3TnpUNit1VTB3MFlZ?=
 =?utf-8?B?cXA1Z05Jekw2ZHlEQWhSRUcvb3hsRHcwdDg5Rmx0aW9tTWhOL0ZmVFphSXNn?=
 =?utf-8?B?M09VdlhPd2VBYklHUU5aN1RPYXlPbWRtTUsvOWtMTy96bEZBNUVuSStGN1pj?=
 =?utf-8?B?Y0dRd3YvMW95STFyc3pJRnAwNURtSitTeDlQSkRSQjY1Z1Fiakd0S0QydnhQ?=
 =?utf-8?B?ZGpaQjdRb3puNllHYzRTRDE5bWQ5VEFFNmcyS0dML0FlQlcxeE5UakdQL0xL?=
 =?utf-8?B?Ny9QNFp2d1lOczgxRHcxTTFBeXhVci9TRFhFQ1Awd3VjbVNFK1BJdmJIQWFW?=
 =?utf-8?B?YnNTb2ZzendoOGNUTkMxcDNzUWJnNEozVFhWQTFDYTE2c1REUFJyUEtOUGI1?=
 =?utf-8?B?RnRFL3h2WndFUDZCRWpuMEtkVEpWOWVnVmRHeitqMkV1YmwvS0I2RGtXeElV?=
 =?utf-8?B?a1FWZUVMcWhnZUlSZWNpb0xGeGtZM1ZQMEx5Vk1SSjNkQXZxZ05QZEg5N2Fn?=
 =?utf-8?B?SWZPVXRtVTlYcWdhZWZCSFl2Y29IRWt3NWo2aG9BSlcyNjJnZ0VRZXUxM3JX?=
 =?utf-8?B?TEUrNTJNemN5Zmp4NkJPNm9xZWZ0NHlmSEN3dk5pNEc1SUd3RnlnUnNXalpD?=
 =?utf-8?B?YTZVaDhOV2syUzBRby9LcGpTTW9aWFlaUjN6WVNUbWtLeERwNXNIdGlrYmo3?=
 =?utf-8?B?YnlaVWhadTBiVkdkNkR2QmNoUE1uRzlpQ3VKQmRRUzVpVmxqbFc0bUNhdVFv?=
 =?utf-8?B?c2JyUUlnQTBLcW9WYjBpSmJtYkY1RHc1L1N0NE1GZEx0YnFCamtQYVRRVW5N?=
 =?utf-8?B?dEM5S3dHci84Zi9oK2V4THJyL25Oa0tMWnUwK0prWDdyVFdhbnJDTXVCTlEy?=
 =?utf-8?B?SFFJSmdjdkpWdXBWMzlzWE0zTFRXd09CbExRQlRKd2JFTXVHcnNrZGYzbUlh?=
 =?utf-8?B?K2EyVXZlb215WEl4Y2YyRURFNjR2ZDBSczI3VG11TGpSazJDamg2Q21RWHpa?=
 =?utf-8?B?dVI0K1JVU3hXYjliRG5EUWtLWkxrWXR2ZW1hOXhGVTdiWWFRMEgrTjJ3Tlhw?=
 =?utf-8?B?N0s5dlpOMklOTDZhSDUwVVAyOGxvU1lrZGwwNkZRa2VQTHJzbllwNzkrWVFl?=
 =?utf-8?B?YlA3OXhvY2FBMGR1Rk9jVmswdVVId3U1RW9nbXpQSENidmNkTTVyeWt1OE91?=
 =?utf-8?B?QUNoNnhTQUQ5TjNNUE9MS09WSTVBWVpUb1oxUnRreWQ0d242Vk9lVHg3dTEx?=
 =?utf-8?B?eFBESlh5b1ZQdlZTNU9ya1ArK3A4bmlrMDJHRUowYUkxWnRTTFZGUjRhTUJ2?=
 =?utf-8?Q?xDLKjGiLw/63hy0oqjtGOmUlu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d31e5a2-1bc0-412a-25f5-08daee356a56
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 09:24:01.3711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kPUOHtWoYdtUPM6eEzSyKYqsiANyG+E+SkvQMomBH7BhK2RmeMKuOM/0ySFBgEg5Y0J7X7EMLcsx347MDSfxVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 arvind.yadav@amd.com, arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 04/01/2023 10:17, Christian König wrote:
> Am 04.01.23 um 10:13 schrieb Shashank Sharma:
>>
>> On 04/01/2023 10:10, Christian König wrote:
>>> Am 04.01.23 um 07:21 schrieb Yadav, Arvind:
>>>>
>>>> On 1/4/2023 12:07 AM, Felix Kuehling wrote:
>>>>> Am 2023-01-03 um 04:36 schrieb Shashank Sharma:
>>>>>>>> /*MQD struct for usermode Queue*/
>>>>>>>> +struct amdgpu_usermode_queue_mqd
>>>>>>> This is specific to GC 11.  Every IP and version will have its 
>>>>>>> own MQD
>>>>>>> format.  That should live in the IP specific code, not the generic
>>>>>>> code.  We already have the generic MQD parameters that we need from
>>>>>>> the userq IOCTL.
>>>>>>
>>>>>> Noted, we can separate out the generic parameters from gen 
>>>>>> specific parameter, and will try to wrap it around the generic 
>>>>>> structure.
>>>>>>
>>>>>> - Shashank
>>>>>
>>>>> Is there a reason why you can't use "struct v11_compute_mqd" from 
>>>>> v11_structs.h?
>>>>
>>>> Hi Felix,
>>>>
>>>> Yes,  V11_compute_mqd does not have these below member which is 
>>>> needed for usermode queue.
>>>>
>>>>     uint32_t shadow_base_lo; // offset: 0  (0x0)
>>>>     uint32_t shadow_base_hi; // offset: 1  (0x1)
>>>>     uint32_t gds_bkup_base_lo ; // offset: 2  (0x2)
>>>>     uint32_t gds_bkup_base_hi ; // offset: 3  (0x3)
>>>>     uint32_t fw_work_area_base_lo; // offset: 4  (0x4)
>>>>     uint32_t fw_work_area_base_hi; // offset: 5  (0x5)
>>>>     uint32_t shadow_initialized; // offset: 6  (0x6)
>>>>     uint32_t ib_vmid; // offset: 7  (0x7)
>>>>
>>>> So we had to add new MQD structs.
>>>
>>> Would it make more sense to update the existing MQD structures than 
>>> adding new ones?
>>>
>> Imo, It might be a bit complicated in the bring-up state, but we can 
>> take a note of converting this structure into a union of two, or may 
>> be renaming it into a superset structure.
>
> Union? Does that mean we have stuff which is individual for both 
> versions of the struct?
So far it seems like Gfx MQD structure is a superset of two, but we have 
not compared them neck-to-neck yet, hence I feel like we can defer this 
task for sometime (but add into to-do list).
>
> BTW: Could we drop the "// offset:" stuff? This could cause problems 
> with automated checkers.

Sure, we will do it.

- Shashank

>
> Christian.
>
>>
>> - Shashank
>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> thanks
>>>>
>>>> ~arvind
>>>>
>>>>>
>>>>> Regards,
>>>>>   Felix
>>>>>
>>>
>
