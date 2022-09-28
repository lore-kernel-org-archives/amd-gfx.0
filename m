Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFECC32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 09:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9210210E360;
	Wed, 28 Sep 2022 09:01:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ACFE10E360
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 09:01:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6/79JkdBSPTN3dsq5c+Y6+btK1bkRqBI2byvg0X7ZovDvRCLGyXdafnh5ZW69XT7hW848lSusqSIeseDXkypfgEbn5AoetOXFGoL+nLhEyswCfHsmo001RydIkjGOn2/HK4/bDFT6bK7ea3yem/uhHl/9sUJY38PzcIM9SxG+IanEKLlfd1qqSWSJj1zktIi++e8yd3jV4gBMdGdKZJ941w2sUuE7aKAdnhgMXbSqcnd2AIB6+bJlJ83RbObZhDnPpxbz7BGvrcKCD8IMOxx8h/hp3YGkozejxNvHzRzfNgVWRyz65rrsgwTFSue+sJsOSa2AM6161HA+q60py4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+uoAGVFMIJCYyZDYZn2o3KAVhIZs5RRzifOe2AUP3g=;
 b=U/F6FvIpeWo6MG934C4csbUvG7y3Zb6OABA++PZ6FaMuJU5eezRBXoY9TTXYP5QcEqaqrhdwgVSqN1UeyB4m3yQ4+pX40DghdzlVGIPLhdTcbtCQqR1123jotSCY6uteTKbFnC4+zIrbxPipbJCA+DVQtkpXNOahgLCk8kMrjMIpx6xj5lIqnNhiSkioBbmMx0377wh4LSSbq0QDldS6EdszbX91llU/GktEFIilT6au5CInGF26ltgigpUiBvp68lhIS5bFvk+bHZGVVfakbEOn9lz5I+Q3jwq9Po64xldO5Eo5mKBo9Y/+eNg5EqwS3btbARugYsMZ1DdttJCGkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+uoAGVFMIJCYyZDYZn2o3KAVhIZs5RRzifOe2AUP3g=;
 b=4RZX2GL5ixkGOF88ciuSeR9Ous3TFzcdNC4cILIgazrrjrhqVvl0wMvqgulCB/kvJWZ9g4q0KTXdHoPcy3WleMfky7VAvusdVITY2qHBCM2GynRIzImpr0COmyN8ruc2aPnB5XsATEA8etnikKIg9nCIq4K8Pl0qlhd6yild9lc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 09:00:57 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::fb8b:ad89:85c3:c961]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::fb8b:ad89:85c3:c961%5]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 09:00:57 +0000
Message-ID: <89f8db09-b345-a196-a99a-a73eb1a699f2@amd.com>
Date: Wed, 28 Sep 2022 11:00:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 5/5] drm/amdgpu: switch workload context to/from compute
Content-Language: en-US
From: "Sharma, Shashank" <shashank.sharma@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-6-shashank.sharma@amd.com>
 <6a0d7dea-8c5e-701d-9231-d6f76df76706@amd.com>
 <aa663a5a-3bc4-393e-ff4b-73e3247e79fa@amd.com>
 <6d8dd85d-5d6f-8364-b710-9483944a2090@amd.com>
 <d4037915-2281-b12b-e38b-2e947fb34c75@amd.com>
 <72aa5f24-8f66-2a8b-3338-a082541dd4aa@amd.com>
 <CADnq5_PavsH-=7hQjWn7aBSCVs30AYdNa_ixDUn7o-BRLh=78A@mail.gmail.com>
 <546cc67c-f17b-de76-afa1-2823f09120e8@amd.com>
In-Reply-To: <546cc67c-f17b-de76-afa1-2823f09120e8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR1001CA0021.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:2::34) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|PH8PR12MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d286ae-6e2d-4c2e-650b-08daa12ff50a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EBdKMnEFH77HwmJssbvXqHH3GqbffQ81sBAbsaN4FhJQXj+ChpK+512BTeQ48PmtOqDfBGiRC6E0Pgh623G759LTP6bT07JkIM/R80OVZIUruvDiw4D7GAQfbXHqg2sGC2Endyt7NcnM6PkMYZmSbTiUyNkqNP6A+/aIn/Mue0EhX5li475U6tUl0d1+b4NzBLSPqSdOfobVvOnK4C7/bhmtZKodu355YCOJvSPmQeGvYT7pkTrc0sSKrq8MuP7KnBB4HO7IHMEy26wtvC0AmUUXNPNAeoH8KZ50m2eUpvtoMS9OjC7HFsDZ1crH4zIuFRJ86BaCcUC+RfalX1DZ+ipYRA9ySW9PjfzrEvbgahO5aQGJVmqFjQV3CUsGW+gvcfJgQSStbcu7DV86Zs1v3KifGBiQL3v30DFjncM6emA4aasfLVtIPnxgWH6Imv6qkWTf1IaiULiZLC4j/DeveJQ06NHhwmUMVZvkDteF+bPzXWoB1Gf3oCcNcJo+fHeMaAXFSjArRyIiLM9XbvwalXPwSvkjLcUG4levuXhoRIjZZDltCAkMo/Vt98YU89kjuDZqjl2m1R6h+047vjuPZv5MCCYKuEYRa6DUDKDJXxxh89mduOwAfT74WGYaMya7fJup+3iZ/+pzONt9/yhyK2HR6A/Gwt/e+SljvE6j/2c9ztxlwOwEIvKwJ+Ylm9wEhdA7NB9sKoVNMv0rti9mcqjc+b6U/Oc9Ha2x+rhGRgdxHe1NerU626LhvDzcMkqkIEF4zWA+GaoPXWh/T0RdZaUAU9DaRPXQtFS9+4NmJfI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199015)(316002)(31686004)(6916009)(8676002)(54906003)(478600001)(6486002)(66556008)(66946007)(4326008)(66476007)(6666004)(38100700002)(53546011)(6512007)(36756003)(2906002)(26005)(6506007)(41300700001)(2616005)(8936002)(186003)(5660300002)(83380400001)(31696002)(66574015)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWZZcGltRVJLZzR2ME5DM0RoQytnOFRXUGNqY2hHQ21CY0FSekJCMVJNUW9x?=
 =?utf-8?B?RWJTV0FjNTBROHlVb2xZaGxNQXZqNCtXZTdlY25jY1AwbXp5cTdDQmhXN3RI?=
 =?utf-8?B?TkNUZ2dJTXZnQTZubnZ5bDJIaDRGVTBKVFZOMVBCaEluWnZIaHVQMFV0NWNK?=
 =?utf-8?B?cFYwSmF2WU5FcTZJQnFjWC9YSEJ2cWU4NTY5bDJKdm9vVXdpZlNEdER6WFg1?=
 =?utf-8?B?Zkh5RkVzQjdlbzl1UG5raldMUzRtVTlweUg3RTg1WWc3N1gxUEJYK1pseXF5?=
 =?utf-8?B?Q0pXNklqb1NVVVFLdEh4c255RU03aER1TWJ1K0RacnZHa05WM3YrbEErbUlB?=
 =?utf-8?B?eDFEdFdvRDB2TVdHWnV5RHNIUUsveXJCN2EzUWpYN2xITDNhMGlmamFzbTlp?=
 =?utf-8?B?M0hmMWlGSnhoL0p2SkVTcG1LK1JWZ2ZtaGtzOWRGcU04blZHRWdoNlNmdmtP?=
 =?utf-8?B?RGlyV0lwZzZDUXJ4WjhaaUg0Z0ZkYlgweklyN1I5dzdiK095OWJVZnZYb1Nh?=
 =?utf-8?B?YW1kU0l3L1pVSUFaeDB0YThDL1dEaWJzVWJ0SWk1WXQ0emRBZUF5WFVkK2NT?=
 =?utf-8?B?SkxHNml6Q2NYUTZlRmFSOVk5UFAzK3g3WWxEbzI4TkQzWk9RSFdhcjRCQk5j?=
 =?utf-8?B?RkFwZnZGQjJHYXdob05hcEpIWlk3dlBLdktjcjl1K3JkY0Z1UnhxUzZsTlB4?=
 =?utf-8?B?YXUwTW52ZS9ocDQ0VjdHVkNlbXIxeDhXN3JxVGpJMnp5QUZhcnFCS3NteU1R?=
 =?utf-8?B?ZG1zQXYzY0FydTQ4TThWcE9JT3daUno1WlgzM0FvOXlLSVZoOTREbWJEeG1N?=
 =?utf-8?B?SEhiUVNNRmlMaG9yZ3VNV3VDblpoczdwaTUxN0JaRUhscnYwNUU3R3pLWHo0?=
 =?utf-8?B?a3BRVjIvankrK2RIS0VseUNCWEx4TDBmem81MWJHcHpvVVM5NFExTnU3S1Z4?=
 =?utf-8?B?cWxBaGI4b1E1V2NhVnlXa24zZWI5WWx3eTl6L3pJR1lQUHdSb0JMb3UzNjlR?=
 =?utf-8?B?YXJnc0JmYUJUQm5SRm9mWEpZMU5JUkZMUlhDeEd2Z3R0Q1NRcVRYYU81LzB2?=
 =?utf-8?B?czBnWXBSUzZGTGhXOTNwd0JtYWFabHF1Z0ZiZFo5VTRCZkg3YUdFY3RrVW8v?=
 =?utf-8?B?dXFvbnEzNWI2NEg0U3BCUy9JaGo3Q3h5OFprWVovNGIxMDhNbkp5dlZiRm5V?=
 =?utf-8?B?ZWpNVEQ5K09mamYwVHkzTDJJb2FUWlJuelVGYVV1WHhNdjkyU21DVVVSYmla?=
 =?utf-8?B?VGxORFhaMWNZVzg5dzBFYnc2VTJqTitRcTNBUGRlL0x6eWU5UmVTekp6Q1BG?=
 =?utf-8?B?c2dzNHVYd0NCOUo2L2VFUnViYWZnbnlrVnFPN0Q2MnJpR1VjaXJSNVFWTnpq?=
 =?utf-8?B?ZlJkSllTUnA4MnA4NnZES01Dd3BSN3kyb2NySGVPbWJrQXFhWXNxeXc4NUxY?=
 =?utf-8?B?YlZvZWNSSUdZZjF3cDJMQWZqWUF0d25yZG16N3NOb3hCWUhGUGNDQlFUcTZ1?=
 =?utf-8?B?RkxzSExXci9uV0Z1VUVhSDZXLzEvUkFhM0JOY2xKbFo1NlBSbXFTeUx1NC9V?=
 =?utf-8?B?WCtLYmZaeTV4NkNXNW0vMWwxQnNDb2Q2S0x1cVJLSzk2bVlyWVd3K1BINVA5?=
 =?utf-8?B?Ri9rdXQvUnZWWFE3cE9ZT0F5ZWZab3Jwd1VNWWZER3F3dGd2bUs4a3V3S0cv?=
 =?utf-8?B?TlQyTE5FQjZBQjhwb2RwTmEyWmVnTGFXSjBFZnIvbHU1cmFKcXEwSGl6eXRv?=
 =?utf-8?B?WWovdnNhRXVLNTVtMHZCcFQyeldmTEJqZVNrRUYweFcxQVBwYWloaXM4V2JT?=
 =?utf-8?B?VHBhTHU1SjAyT2VPSCtFWURqNUdVNEpiVE5XeFdOS2J5SVJBcjhwTmZKRmxx?=
 =?utf-8?B?VE5PbVZncDhwNGthMW44cGJEd3hYTVBuMVprRThjQUk4alBueWI2Y2l1ZVlt?=
 =?utf-8?B?YkFSVkxPdXFxOWJFcS9EOUYwc0pEMEl0azdiTkpoQWxkd2RuSDNJdjVJV3lr?=
 =?utf-8?B?ckNUUHVwc2RJclBoQVhQcHNpVU42dE54b1dPaG1lTE9nMHZPSlZQd2FyTWk3?=
 =?utf-8?B?MnJkYTNaRTI5VUYyMDhaMjZCZTNqeWZlSU9maGhmMmRIU3UyVUp2NXhEUGdz?=
 =?utf-8?Q?4O4NCD0QIKlRjwsVjgT5Cz7wJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d286ae-6e2d-4c2e-650b-08daa12ff50a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 09:00:57.4074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /oK6IMJGV+Wwi6PBWgi660jHjmbMPEL9KxsEZrwmTUOKBmJyjPKzEFKkmzrMvro921rohS1c1sNW5ZyMb+nSLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445
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
Cc: alexander.deucher@amd.com, Felix Kuehling <felix.kuehling@amd.com>,
 amaranath.somalapuram@amd.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Small correction,

On 9/28/2022 10:56 AM, Sharma, Shashank wrote:
> 
> 
> On 9/27/2022 10:40 PM, Alex Deucher wrote:
>> On Tue, Sep 27, 2022 at 11:38 AM Sharma, Shashank
>> <shashank.sharma@amd.com> wrote:
>>>
>>>
>>>
>>> On 9/27/2022 5:23 PM, Felix Kuehling wrote:
>>>> Am 2022-09-27 um 10:58 schrieb Sharma, Shashank:
>>>>> Hello Felix,
>>>>>
>>>>> Thank for the review comments.
>>>>>
>>>>> On 9/27/2022 4:48 PM, Felix Kuehling wrote:
>>>>>> Am 2022-09-27 um 02:12 schrieb Christian König:
>>>>>>> Am 26.09.22 um 23:40 schrieb Shashank Sharma:
>>>>>>>> This patch switches the GPU workload mode to/from
>>>>>>>> compute mode, while submitting compute workload.
>>>>>>>>
>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>>>
>>>>>>> Feel free to add my acked-by, but Felix should probably take a look
>>>>>>> as well.
>>>>>>
>>>>>> This look OK purely from a compute perspective. But I'm concerned
>>>>>> about the interaction of compute with graphics or multiple graphics
>>>>>> contexts submitting work concurrently. They would constantly override
>>>>>> or disable each other's workload hints.
>>>>>>
>>>>>> For example, you have an amdgpu_ctx with
>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE (maybe Vulkan compute) and a KFD
>>>>>> process that also wants the compute profile. Those could be different
>>>>>> processes belonging to different users. Say, KFD enables the compute
>>>>>> profile first. Then the graphics context submits a job. At the start
>>>>>> of the job, the compute profile is enabled. That's a no-op because
>>>>>> KFD already enabled the compute profile. When the job finishes, it
>>>>>> disables the compute profile for everyone, including KFD. That's
>>>>>> unexpected.
>>>>>>
>>>>>
>>>>> In this case, it will not disable the compute profile, as the
>>>>> reference counter will not be zero. The reset_profile() will only act
>>>>> if the reference counter is 0.
>>>>
>>>> OK, I missed the reference counter.
>>>>
>>>>
>>>>>
>>>>> But I would be happy to get any inputs about a policy which can be
>>>>> more sustainable and gets better outputs, for example:
>>>>> - should we not allow a profile change, if a PP mode is already
>>>>> applied and keep it Early bird basis ?
>>>>>
>>>>> For example: Policy A
>>>>> - Job A sets the profile to compute
>>>>> - Job B tries to set profile to 3D, but we do not allow it as job A is
>>>>> not finished it yet.
>>>>>
>>>>> Or Policy B: Current one
>>>>> - Job A sets the profile to compute
>>>>> - Job B tries to set profile to 3D, and we allow it. Job A also runs
>>>>> in PP 3D
>>>>> - Job B finishes, but does not reset PP as reference count is not zero
>>>>> due to compute
>>>>> - Job  A finishes, profile reset to NONE
>>>>
>>>> I think this won't work. As I understand it, the
>>>> amdgpu_dpm_switch_power_profile enables and disables individual
>>>> profiles. Disabling the 3D profile doesn't disable the compute profile
>>>> at the same time. I think you'll need one refcount per profile.
>>>>
>>>> Regards,
>>>>     Felix
>>>
>>> Thanks, This is exactly what I was looking for, I think Alex's initial
>>> idea was around it, but I was under the assumption that there is only
>>> one HW profile in SMU which keeps on getting overwritten. This can solve
>>> our problems, as I can create an array of reference counters, and will
>>> disable only the profile whose reference counter goes 0.
>>
>> It's been a while since I paged any of this code into my head, but I
>> believe the actual workload message in the SMU is a mask where you can
>> specify multiple workload types at the same time and the SMU will
>> arbitrate between them internally.  E.g., the most aggressive one will
>> be selected out of the ones specified.  I think in the driver we just
>> set one bit at a time using the current interface.  It might be better
>> to change the interface and just ref count the hint types and then
>> when we call the set function look at the ref counts for each hint
>> type and set the mask as appropriate.
>>
>> Alex
>>
> 
> Hey Alex,
> Thanks for your comment, if that is the case, this current patch series 
> works straight forward, and no changes would be required. 

Only one change required would be to append the new power profile 
request in the existing power profile mask, instead of overwriting it. 
This is where the current state machine pm.workload_mode would be useful.

- Shashank

Please let me
> know if my understanding is correct:
> 
> Assumption: Order of aggression: 3D > Media > Compute
> 
> - Job 1: Requests mode compute: PP changed to compute, ref count 1
> - Job 2: Requests mode media: PP changed to media, ref count 2
> - Job 3: requests mode 3D: PP changed to 3D, ref count 3
> - Job 1 finishes, downs ref count to 2, doesn't reset the PP as ref > 0, 
> PP still 3D
> - Job 3 finishes, downs ref count to 1, doesn't reset the PP as ref > 0,
> PP still 3D
> - Job 2 finishes, downs ref count to 0, PP changed to NONE,
> 
> In this way, every job will be operating in the Power profile of desired 
> aggression or higher, and this API guarantees the execution at-least in 
> the desired power profile.
> 
> - Shashank
> 
>>
>>>
>>> - Shashank
>>>
>>>>
>>>>
>>>>>
>>>>>
>>>>> Or anything else ?
>>>>>
>>>>> REgards
>>>>> Shashank
>>>>>
>>>>>
>>>>>> Or you have multiple VCN contexts. When context1 finishes a job, it
>>>>>> disables the VIDEO profile. But context2 still has a job on the other
>>>>>> VCN engine and wants the VIDEO profile to still be enabled.
>>>>>>
>>>>>> Regards,
>>>>>>     Felix
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> Christian.
>>>>>>>
>>>>>>>> ---
>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 14 +++++++++++---
>>>>>>>>    1 file changed, 11 insertions(+), 3 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>> index 5e53a5293935..1caed319a448 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>> @@ -34,6 +34,7 @@
>>>>>>>>    #include "amdgpu_ras.h"
>>>>>>>>    #include "amdgpu_umc.h"
>>>>>>>>    #include "amdgpu_reset.h"
>>>>>>>> +#include "amdgpu_ctx_workload.h"
>>>>>>>>      /* Total memory size in system memory and all GPU VRAM. 
>>>>>>>> Used to
>>>>>>>>     * estimate worst case amount of memory to reserve for page 
>>>>>>>> tables
>>>>>>>> @@ -703,9 +704,16 @@ int amdgpu_amdkfd_submit_ib(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>      void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device 
>>>>>>>> *adev,
>>>>>>>> bool idle)
>>>>>>>>    {
>>>>>>>> -    amdgpu_dpm_switch_power_profile(adev,
>>>>>>>> -                    PP_SMC_POWER_PROFILE_COMPUTE,
>>>>>>>> -                    !idle);
>>>>>>>> +    int ret;
>>>>>>>> +
>>>>>>>> +    if (idle)
>>>>>>>> +        ret = amdgpu_clear_workload_profile(adev,
>>>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
>>>>>>>> +    else
>>>>>>>> +        ret = amdgpu_set_workload_profile(adev,
>>>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
>>>>>>>> +
>>>>>>>> +    if (ret)
>>>>>>>> +        drm_warn(&adev->ddev, "Failed to %s power profile to
>>>>>>>> compute mode\n",
>>>>>>>> +             idle ? "reset" : "set");
>>>>>>>>    }
>>>>>>>>      bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32
>>>>>>>> vmid)
>>>>>>>
