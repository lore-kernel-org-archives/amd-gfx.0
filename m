Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AF8C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Sep 2022 18:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A252E10E048;
	Thu, 29 Sep 2022 18:08:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B900E10EBC5
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Sep 2022 18:07:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XskvLpcq/x2wA5EHXt/4vBjWbLt4sgXG9FiMmYbBnkXZi9Q6o3NDnJ+e5Pam5SPtJfu1CApsSmBXKlX6SljuZhmgVq4yKlvw2B3h8IRoThhRfa0SI6mBJj562tYNOkvmhhdtFRwxk14xDYRACmDv7KBpuaBxeRdUuEAWomcvT3LmCNbCfMrLkRqydC0A3DQPPRz30zN7XfIrBRK5huukVDAFgv9QnYITPfkDqkhKFDTyZh6UyzhzdeabNiZTILtqEetTT3q4eWxj3DcYCp5PWXi9i+b+o3GEQXLxKbOb2Ek+gBpuqpjuQPQ5zHbzguCuF2uPLXZB9/Iyk/5AC4vSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdsGfeWV8G0qeeGeGL8kgig98fPPZax9PJ50NMcWUHw=;
 b=jALeTTUfbL7l+2CsreIm3Ip/b0aVNGXvvBpDjj1i7w5PplGFt1hZVyqZ2a9gTX3L2t34TB7cY1ah+4QSNhrQ5lUs9vv7NU1nEfonZd58FB5DluzVSIyl6W0Ka6EgLy0NAwsczOLW73vL143tgwJicVoQdQJg3EbeW6wmHhfkMTvbpxA/TNM2YrrLqKwJmvoGMzQ3b+v4tsgptLkm7Fix4mnpa0kAWPV4AJlwFwmWi6qk9SMVXeC3/d3sshIGhZaDMjiwrfTjrXQEvvGBEESiEfT36S/lnitEdCZInI3OWAlsJQea2CDz/hL1nRfrtHB0jeNcn5drQDfm5hH2ylXpDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdsGfeWV8G0qeeGeGL8kgig98fPPZax9PJ50NMcWUHw=;
 b=A1ZOyZbB8cot5Ys7D8EqJm2p/hXUgmdVn+4wB/s6EU936Dozc09U9j6njaqnyxdVsx2Mby1L6rQTfOXfqcXICERMWNMXdDj5LwQ6/k8pgrfNIFiRMC1VNmJolM3DCDoMx25BH7oKXyTpeJdEKZdPRPZPpNoT3PX/G5krQ7mAewE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 29 Sep
 2022 18:07:56 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 18:07:56 +0000
Message-ID: <be0e9a44-a285-49b4-7b2f-afd68930e812@amd.com>
Date: Thu, 29 Sep 2022 14:07:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 5/5] drm/amdgpu: switch workload context to/from compute
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 "Sharma, Shashank" <shashank.sharma@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-6-shashank.sharma@amd.com>
 <6a0d7dea-8c5e-701d-9231-d6f76df76706@amd.com>
 <aa663a5a-3bc4-393e-ff4b-73e3247e79fa@amd.com>
 <6d8dd85d-5d6f-8364-b710-9483944a2090@amd.com>
 <d4037915-2281-b12b-e38b-2e947fb34c75@amd.com>
 <72aa5f24-8f66-2a8b-3338-a082541dd4aa@amd.com>
 <CADnq5_PavsH-=7hQjWn7aBSCVs30AYdNa_ixDUn7o-BRLh=78A@mail.gmail.com>
 <546cc67c-f17b-de76-afa1-2823f09120e8@amd.com>
 <CADnq5_Mg7GFW=s6W5xeGa5vG7_GmedsP6uQG_dpZKkzp1CDJqg@mail.gmail.com>
 <5bf6d05a-58e4-0057-1445-9369b20b1a67@amd.com>
 <369b2225-87a3-b976-bbd1-6f73f190b44a@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <369b2225-87a3-b976-bbd1-6f73f190b44a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0413.namprd03.prod.outlook.com
 (2603:10b6:610:11b::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: 579bf85d-3717-4c5f-8d7e-08daa24588d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XDWVeM3t5mLa1xGp680742eJzsk2Yi82bq1+WJuemozJmLPX8sxo/JD3x+GE2BvzzGvzsDcLczUzTQPvRxHH+N+0OR+QbcvZA6hyqKP2r5jr+LjKU9/Te2kzoqKdZy5vaQfFpIqudbCFSqekZasH4LuB/kSHUVoVpPtzysgmTZ7f7YQxKM3BG13AeniVyPx5vfVtZPTeffHtMPc43TzAepeRAqpDT0w0vePn942CnNV5yoWCXRZROLjH4UX7GJ6bZC1g7V538Jmqx9Y0s7WTg6gFwO4nqA5ab9s4J6R8aWKn/KjZb4TlgaGgkPEMNuBGKD71pGPLATOhyyiNshPuF/9P6Lx8rJ7W2vE0SC8xH+kcnGHxGhQFyfWeybICsPXTWod2CgYdEoBxyvtbP0aNZh7PElJECS/nXbyOfVVYcxhr/bbtezBoi45q85ExvHw1Plb8gIlJmB97tin3sRJ3WCHCUoOeLblqCko7oGZuapvB4X82+bX3RHLfEFefnOgfMtAYQcWPCTmK5LZOiny87bZcZC8A3EtjVP8yjiwVQsSrC8CBuJ1OqO/iySX8TPExGKphkKyt9uCg4aZUb9jh3Xs+H3FyU6YfxW8pEoMLoDl8ZFvSlG+Lnz6MrBrsygJ+XMKwlsQCt4OdZzC3XaNaiZC6qeGkos75ukZt2Xy10E4aAjGxM/EggMzn0Qnc+b3wXJYg5mn06lMRb4GwPb+6lhFLm8DqwESmGVRLW6xpJZAfDIKmbFZijyYOA6zq5FzlfuxyUm+QFb96+3SRVpwT+8i2Y2w+m8rCFTfLaplBKoXApQEkFrM9xkSgmN2qD6be1JsB7/hmKwc2x7lYwgdEJisvSzFtL7kh+p9g557keaGvi4t6f9R2CKF182Bf/Qtb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199015)(6506007)(31686004)(2616005)(26005)(53546011)(6512007)(316002)(38100700002)(6486002)(966005)(86362001)(31696002)(44832011)(36756003)(83380400001)(66574015)(36916002)(186003)(478600001)(5660300002)(8936002)(30864003)(110136005)(41300700001)(4326008)(66946007)(2906002)(8676002)(66556008)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjcvNWVmVDMyV3JJR2dOZVdweXhaWmRqMWF0LzBhMW4xeFpUekNxekQ3RHlJ?=
 =?utf-8?B?aHFiNmE0aE9YYmNxclI5LzJ0eHNZczBlY2lNbzg1akExcWFqeks2K1lCeU0r?=
 =?utf-8?B?eFJwMlVkdm8vb2VGOVRvYzB5Q1puRSswN3paU2c0K0lTK2tSTFg0bTl4ZzNP?=
 =?utf-8?B?UERwaWc2T0tlUGlTa1A5WmhaZFhEUzZ1a3NrTEpsR2piUnN2aXk5L1pNN2hW?=
 =?utf-8?B?a20zNUtnK3ZQVjBjQmM4UmJLTmtadGVvSHViVUx0Skk0NFFvYzV2VEU2aE5D?=
 =?utf-8?B?SWRZcVoydGMzUTF5N3IzWWZiQU1VQkRpVFhFaTJwZ2NYUnh1Y29ycXkzUndP?=
 =?utf-8?B?UGhxd1NTTlkvYk5OTlFPTmwrajNTYlArOGVNWVhOK3c1UldteG53VDJuM1Vz?=
 =?utf-8?B?UUI4bk9JSkxqWTlCUnl2ckZhcm1yTHJFZ1V3Z2pPYlRoZ3ROZkxNeGI2YnhL?=
 =?utf-8?B?SUdFMW0vck04Z0NtRTh4cHJsVmVpekFJR2VWSGtBSmxCRG9ORFJDSklzMGpI?=
 =?utf-8?B?VnBBM3paeXB3RGU0VWNQMitWVkNsY3Bhc0tITTZkR1RpWFUyZEJydWcvTmpL?=
 =?utf-8?B?U3hTc1AzaUdpSVk0TWFrc1FLZG5EQnlyd3pNTlc4c2xGRlJ4Skx3Y0xiMVEx?=
 =?utf-8?B?ZTVzdmE2bTZBZ3lxeGh5NnJQS1pYTFZEVyt1dHIrRElLUGlVQlVWWDZZL3FH?=
 =?utf-8?B?dUl0S3JyWFdmVnV5R1JqODhXZXQ2bGdMeWg0VFZnNVRKU1piQllEUGhlWlB4?=
 =?utf-8?B?bTlFU1RoTVloR1VBZjBVYy9yRytmcXQ0TW9rQTByUWVhUjFsY1Y4aTZIV25u?=
 =?utf-8?B?VXh6dVFBb2JCM2hKRmN6SGg0YmFMUjJIUjlSSU1WbENFcWppUWhlYW1CVGFV?=
 =?utf-8?B?TFJvaEZYL0M2SzlHK3lJczVXV2tOQ012L0p3ZW53NzVSSjhlVHUyanBYM25O?=
 =?utf-8?B?eENsMEVDa01jR3ZYWE5oWis1U3BDM0JUbFdHVzBqKzRuZXRXR25CdlEwK0N6?=
 =?utf-8?B?dHpLYy8xTW9OSEJaeEZJZDhKbUZOaU9iNk9xbmE5MmR2T2xuMmo2MmxVNlBt?=
 =?utf-8?B?NXh2MWNVUE4yMDVpMVhxUE1oVkRsemF5VUlEdnBPekQvcjZxdmlmYWJvVldm?=
 =?utf-8?B?YzZLNHg1NjlTRi9GZHZ3dGdUS1cwT3NMY2ZlUFAzS2ZFZ2NpdzVuQVBHNG9E?=
 =?utf-8?B?OW1iTUlveGVKZ0tjMHRJUHYvUmk1QnRhU0QwVHg0R244cnZJeWNoMUw0MVJR?=
 =?utf-8?B?TVVRK2NuUVlCQ05VWnFtVTA5eUlpYUdSNkIvUEkwSmR5ZHEwNmo2c0NhbXFv?=
 =?utf-8?B?Rk5TdTk1Q3NRZTZOQ3IrcWNDa2tPWm9lN2dEN2RURWQ4dThIZE5EbzZLcitu?=
 =?utf-8?B?WXpDdjNVZjlpQ0JnOGZyNFM5NlE5ODFzVnNHbVVDRGNtUGwrUEgxK1g4SEx6?=
 =?utf-8?B?RFFjRitOa3h1dERoY1A0OVBVend6UTVXaDhWYlZDdkZZYnlmUmd1R1Y3SVMy?=
 =?utf-8?B?UEY1Qzc2RUhzYjNGYmRBMjlPM2xhL3dkc3JQQW8vOVVEQldES210M3h2QlY5?=
 =?utf-8?B?bitGeS91Q0RTU1h1Ym5wa3FRUjVmVDFNMWNXV0xvVW1RbXlBc01lck5KNWZC?=
 =?utf-8?B?SGo2a01mL1NwUElQSkk2THoyY1l1bHByeEJGelFrdTAxWitWY2NyZmsvd0Zy?=
 =?utf-8?B?ZDNGRCtVUG0zQm1VUXRiWjF5QzlFaDEwckdyY0RYQmdYUmhqTE0vTWFXdTlx?=
 =?utf-8?B?UDloNEVLMWJ3ZlVmODdRMkJpV3JKbTBxSVhuMlhNRXFUNlRLOEVDZ0RVQnV0?=
 =?utf-8?B?OWQ3cjdURm16NlBrZzBYTytXSjNrOVMzeXRobVJYK1BhTDZZMm9UKzFqREVF?=
 =?utf-8?B?ckdmU0VxNTdTZ29UT2tncGs5Q2Flb2hka0kyYjVuckJ3RGg2clFKN21VeXNq?=
 =?utf-8?B?WFB1ckplaEpIOXpkUmlpK0RFN2Z0RFFOS1RPVEU1c2k5UFpmNkc2eWZQeHNO?=
 =?utf-8?B?NnBFVnZwQngycGhpK2tjOU0vMXdqNGE3OUNMM0VyRUJodGhmdkZ5dk1oRVRH?=
 =?utf-8?B?WmF0T0lKOEEwNk5CQVlnRTBhNnZlck1iUExDSit6cGdxSFRSZTBSbGxPR2dU?=
 =?utf-8?Q?B/BGEUXzd0JtaLZH7Pt6y8GVa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 579bf85d-3717-4c5f-8d7e-08daa24588d6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 18:07:56.0270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FT75pOmrEWDFf4P+FIsDFmecXDuW/Vmk5b+AjMkWLrjJRYxPuCgxoKxhmGBbip6B134LhgZpKmSRkgc86SdXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-09-29 07:10, Lazar, Lijo wrote:
>
>
> On 9/29/2022 2:18 PM, Sharma, Shashank wrote:
>>
>>
>> On 9/28/2022 11:51 PM, Alex Deucher wrote:
>>> On Wed, Sep 28, 2022 at 4:57 AM Sharma, Shashank
>>> <shashank.sharma@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 9/27/2022 10:40 PM, Alex Deucher wrote:
>>>>> On Tue, Sep 27, 2022 at 11:38 AM Sharma, Shashank
>>>>> <shashank.sharma@amd.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 9/27/2022 5:23 PM, Felix Kuehling wrote:
>>>>>>> Am 2022-09-27 um 10:58 schrieb Sharma, Shashank:
>>>>>>>> Hello Felix,
>>>>>>>>
>>>>>>>> Thank for the review comments.
>>>>>>>>
>>>>>>>> On 9/27/2022 4:48 PM, Felix Kuehling wrote:
>>>>>>>>> Am 2022-09-27 um 02:12 schrieb Christian König:
>>>>>>>>>> Am 26.09.22 um 23:40 schrieb Shashank Sharma:
>>>>>>>>>>> This patch switches the GPU workload mode to/from
>>>>>>>>>>> compute mode, while submitting compute workload.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>>>>>>
>>>>>>>>>> Feel free to add my acked-by, but Felix should probably take 
>>>>>>>>>> a look
>>>>>>>>>> as well.
>>>>>>>>>
>>>>>>>>> This look OK purely from a compute perspective. But I'm concerned
>>>>>>>>> about the interaction of compute with graphics or multiple 
>>>>>>>>> graphics
>>>>>>>>> contexts submitting work concurrently. They would constantly 
>>>>>>>>> override
>>>>>>>>> or disable each other's workload hints.
>>>>>>>>>
>>>>>>>>> For example, you have an amdgpu_ctx with
>>>>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE (maybe Vulkan compute) and a KFD
>>>>>>>>> process that also wants the compute profile. Those could be 
>>>>>>>>> different
>>>>>>>>> processes belonging to different users. Say, KFD enables the 
>>>>>>>>> compute
>>>>>>>>> profile first. Then the graphics context submits a job. At the 
>>>>>>>>> start
>>>>>>>>> of the job, the compute profile is enabled. That's a no-op 
>>>>>>>>> because
>>>>>>>>> KFD already enabled the compute profile. When the job 
>>>>>>>>> finishes, it
>>>>>>>>> disables the compute profile for everyone, including KFD. That's
>>>>>>>>> unexpected.
>>>>>>>>>
>>>>>>>>
>>>>>>>> In this case, it will not disable the compute profile, as the
>>>>>>>> reference counter will not be zero. The reset_profile() will 
>>>>>>>> only act
>>>>>>>> if the reference counter is 0.
>>>>>>>
>>>>>>> OK, I missed the reference counter.
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> But I would be happy to get any inputs about a policy which can be
>>>>>>>> more sustainable and gets better outputs, for example:
>>>>>>>> - should we not allow a profile change, if a PP mode is already
>>>>>>>> applied and keep it Early bird basis ?
>>>>>>>>
>>>>>>>> For example: Policy A
>>>>>>>> - Job A sets the profile to compute
>>>>>>>> - Job B tries to set profile to 3D, but we do not allow it as 
>>>>>>>> job A is
>>>>>>>> not finished it yet.
>>>>>>>>
>>>>>>>> Or Policy B: Current one
>>>>>>>> - Job A sets the profile to compute
>>>>>>>> - Job B tries to set profile to 3D, and we allow it. Job A also 
>>>>>>>> runs
>>>>>>>> in PP 3D
>>>>>>>> - Job B finishes, but does not reset PP as reference count is 
>>>>>>>> not zero
>>>>>>>> due to compute
>>>>>>>> - Job  A finishes, profile reset to NONE
>>>>>>>
>>>>>>> I think this won't work. As I understand it, the
>>>>>>> amdgpu_dpm_switch_power_profile enables and disables individual
>>>>>>> profiles. Disabling the 3D profile doesn't disable the compute 
>>>>>>> profile
>>>>>>> at the same time. I think you'll need one refcount per profile.
>>>>>>>
>>>>>>> Regards,
>>>>>>>      Felix
>>>>>>
>>>>>> Thanks, This is exactly what I was looking for, I think Alex's 
>>>>>> initial
>>>>>> idea was around it, but I was under the assumption that there is 
>>>>>> only
>>>>>> one HW profile in SMU which keeps on getting overwritten. This 
>>>>>> can solve
>>>>>> our problems, as I can create an array of reference counters, and 
>>>>>> will
>>>>>> disable only the profile whose reference counter goes 0.
>>>>>
>>>>> It's been a while since I paged any of this code into my head, but I
>>>>> believe the actual workload message in the SMU is a mask where you 
>>>>> can
>>>>> specify multiple workload types at the same time and the SMU will
>>>>> arbitrate between them internally.  E.g., the most aggressive one 
>>>>> will
>>>>> be selected out of the ones specified.  I think in the driver we just
>>>>> set one bit at a time using the current interface.  It might be 
>>>>> better
>>>>> to change the interface and just ref count the hint types and then
>>>>> when we call the set function look at the ref counts for each hint
>>>>> type and set the mask as appropriate.
>>>>>
>>>>> Alex
>>>>>
>>>>
>>>> Hey Alex,
>>>> Thanks for your comment, if that is the case, this current patch 
>>>> series
>>>> works straight forward, and no changes would be required. Please 
>>>> let me
>>>> know if my understanding is correct:
>>>>
>>>> Assumption: Order of aggression: 3D > Media > Compute
>>>>
>>>> - Job 1: Requests mode compute: PP changed to compute, ref count 1
>>>> - Job 2: Requests mode media: PP changed to media, ref count 2
>>>> - Job 3: requests mode 3D: PP changed to 3D, ref count 3
>>>> - Job 1 finishes, downs ref count to 2, doesn't reset the PP as ref 
>>>> > 0,
>>>> PP still 3D
>>>> - Job 3 finishes, downs ref count to 1, doesn't reset the PP as ref 
>>>> > 0,
>>>> PP still 3D
>>>> - Job 2 finishes, downs ref count to 0, PP changed to NONE,
>>>>
>>>> In this way, every job will be operating in the Power profile of 
>>>> desired
>>>> aggression or higher, and this API guarantees the execution 
>>>> at-least in
>>>> the desired power profile.
>>>
>>> I'm not entirely sure on the relative levels of aggression, but I
>>> believe the SMU priorities them by index.  E.g.
>>> #define WORKLOAD_PPLIB_DEFAULT_BIT        0
>>> #define WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT 1
>>> #define WORKLOAD_PPLIB_POWER_SAVING_BIT   2
>>> #define WORKLOAD_PPLIB_VIDEO_BIT          3
>>> #define WORKLOAD_PPLIB_VR_BIT             4
>>> #define WORKLOAD_PPLIB_COMPUTE_BIT        5
>>> #define WORKLOAD_PPLIB_CUSTOM_BIT         6
>>>
>>> 3D < video < VR < compute < custom
>>>
>>> VR and compute are the most aggressive.  Custom takes preference
>>> because it's user customizable.
>>>
>>> Alex
>>>
>>
>> Thanks, so this UAPI will guarantee the execution of the job in 
>> atleast the requested power profile, or a more aggressive one.
>>
>
> Hi Shashank,
>
> This is not how the API works in the driver PM subsystem. In the final 
> interface with PMFW, driver sets only one profile bit and doesn't set 
> any mask. So it doesn't work the way as Felix explained.

I was not looking at the implementation but at the API:

int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
                                     enum PP_SMC_POWER_PROFILE type,
                                     bool en)

This API suggests, that we can enable and disable individual profiles. 
E.g. disabling PP_SMC_POWER_PROFILE_VIDEO should not change whether 
PP_SMC_POWER_PROFILE_COMPUTE is enabled. What we actually send to the HW 
when multiple profiles are enabled through this API is a different 
question. We have to choose one profile or the other. This can happen in 
the driver or the firmware. I don't care.

But if disabling PP_SMC_POWER_PROFILE_VIDEO makes us forget that we ever 
enabled PP_SMC_POWER_PROFILE_COMPUTE then this API is broken and useless 
as an abstraction.

Regards,
   Felix


> If there is more than one profile bit set, PMFW looks at the mask and 
> picks the one with the highest priority. Note that for each update of 
> workload mask, PMFW should get a message.
>
> Driver currently sets only bit as Alex explained earlier. For our 
> current driver implementation, you can check this as example -
>
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c#L1753 
>
>
> Also, PM layer already stores the current workload profile for a *get* 
> API (which also means a new pm workload variable is not needed). But, 
> that API works as long as driver sets only one profile bit, that way 
> driver is sure of the current profile mode -
>
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c#L1628 
>
>
> When there is more than one, driver is not sure of the internal 
> priority of PMFW though we can follow the bit order which Alex 
> suggested (but sometimes FW carry some workarounds inside which means 
> it doesn't necessarily follow the same order).
>
> There is an existing interface through sysfs through which allow to 
> change the profile mode and add custom settings. In summary, any 
> handling of change from single bit to mask needs to be done at the 
> lower layer.
>
> The problem is this behavior has been there throughout all legacy 
> ASICs. Not sure how much of effort it takes and what all needs to be 
> modified.
>
> Thanks,
> Lijo
>
>> I will do the one change required and send the updated one.
>>
>> - Shashank
>>
>>>
>>>
>>>
>>>>
>>>> - Shashank
>>>>
>>>>>
>>>>>>
>>>>>> - Shashank
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Or anything else ?
>>>>>>>>
>>>>>>>> REgards
>>>>>>>> Shashank
>>>>>>>>
>>>>>>>>
>>>>>>>>> Or you have multiple VCN contexts. When context1 finishes a 
>>>>>>>>> job, it
>>>>>>>>> disables the VIDEO profile. But context2 still has a job on 
>>>>>>>>> the other
>>>>>>>>> VCN engine and wants the VIDEO profile to still be enabled.
>>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>>      Felix
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Christian.
>>>>>>>>>>
>>>>>>>>>>> ---
>>>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 14 
>>>>>>>>>>> +++++++++++---
>>>>>>>>>>>     1 file changed, 11 insertions(+), 3 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>>>> index 5e53a5293935..1caed319a448 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>>>> @@ -34,6 +34,7 @@
>>>>>>>>>>>     #include "amdgpu_ras.h"
>>>>>>>>>>>     #include "amdgpu_umc.h"
>>>>>>>>>>>     #include "amdgpu_reset.h"
>>>>>>>>>>> +#include "amdgpu_ctx_workload.h"
>>>>>>>>>>>       /* Total memory size in system memory and all GPU 
>>>>>>>>>>> VRAM. Used to
>>>>>>>>>>>      * estimate worst case amount of memory to reserve for 
>>>>>>>>>>> page tables
>>>>>>>>>>> @@ -703,9 +704,16 @@ int amdgpu_amdkfd_submit_ib(struct
>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>       void amdgpu_amdkfd_set_compute_idle(struct 
>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>> bool idle)
>>>>>>>>>>>     {
>>>>>>>>>>> -    amdgpu_dpm_switch_power_profile(adev,
>>>>>>>>>>> - PP_SMC_POWER_PROFILE_COMPUTE,
>>>>>>>>>>> -                    !idle);
>>>>>>>>>>> +    int ret;
>>>>>>>>>>> +
>>>>>>>>>>> +    if (idle)
>>>>>>>>>>> +        ret = amdgpu_clear_workload_profile(adev,
>>>>>>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
>>>>>>>>>>> +    else
>>>>>>>>>>> +        ret = amdgpu_set_workload_profile(adev,
>>>>>>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
>>>>>>>>>>> +
>>>>>>>>>>> +    if (ret)
>>>>>>>>>>> +        drm_warn(&adev->ddev, "Failed to %s power profile to
>>>>>>>>>>> compute mode\n",
>>>>>>>>>>> +             idle ? "reset" : "set");
>>>>>>>>>>>     }
>>>>>>>>>>>       bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device 
>>>>>>>>>>> *adev, u32
>>>>>>>>>>> vmid)
>>>>>>>>>>
