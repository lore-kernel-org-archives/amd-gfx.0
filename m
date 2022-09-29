Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE21C07E9D
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Sep 2022 08:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F39810EA05;
	Thu, 29 Sep 2022 08:48:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9077210E9E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Sep 2022 08:48:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfCr94SoWIfs8Ie8OwyNft8bv2JBTX6b1I9Tj7oSqoGQWso3F6M/l+5Sr435AeduFlsVgmhWDoEbFkDV14jT7sZ55GvSeiLpvWqz5LgcestRLPuhQXPKYPhE4y+MN89iUcwfW9Z4XG5gQpb/fcSquIotChkbe6K9QJU5q4Z1waj3WSByh/pG9w5FkbXohh//jbFn5K4ES53VStdHtFjs/XsCpzkaQfGQkCEU7A/es2NL07ComLNEhYbXZt/YzT60kPGuiyOb4VquME+OH5cELKhlDNSD47RDAp9VEn17iwysACkFTaIPJvSRIRMn7ySIY1kYgbZeJ0xFwgkfpjavmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5H2GCBvf0hPoPAAHBfsK8GgRPbM4QD91DeVegK8vPKI=;
 b=Xw8xtgbsW4ThF7e03QU3vk6SEzwcWFJSU9G9SCc0ev3jPumYsJRepwvgdQR0g/nVDKU01Fjb1Sb/dpdEVOadnI6modBALbI+W2SrClUXN5VDQZd1AS4hSyvlRstD/mKzcMP06A7GpqbeGA1GqUKvwJ1Eg402CLKodOuBTblQ8Fq/2VO3j7J56bYkJupD6yziIC/bAPV1azSns1k5C+JCrCupwKu9f1RKcKuyghggE7UPHW4/VFA6oj+IachykYXe+9UE+PSmCFOBHHCe9Ks+DlvITDt58rzFQRcWSm2Bvwjuzt/yH8VLZn9bRivhUP/beMr1KNbEct1052TJKD1uNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5H2GCBvf0hPoPAAHBfsK8GgRPbM4QD91DeVegK8vPKI=;
 b=s1w8VW15OkOxBkNvxid1e7i/avYOW1kyjlVBOC9i5Gy+m4zeTk2uVvjSIJ10+hYBdYId7/2YfiL9bknzViJ48zXHqR2UBBoNcdxMnW3dhH6mT2eltxFC8kBlenXxHaYM6ap+jSorQPBfhfybgkWISOE5UwMzRGYQcQId+LlbXP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17; Thu, 29 Sep 2022 08:48:25 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::fb8b:ad89:85c3:c961]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::fb8b:ad89:85c3:c961%5]) with mapi id 15.20.5676.017; Thu, 29 Sep 2022
 08:48:25 +0000
Message-ID: <5bf6d05a-58e4-0057-1445-9369b20b1a67@amd.com>
Date: Thu, 29 Sep 2022 10:48:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 5/5] drm/amdgpu: switch workload context to/from compute
Content-Language: en-US
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
 <CADnq5_Mg7GFW=s6W5xeGa5vG7_GmedsP6uQG_dpZKkzp1CDJqg@mail.gmail.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_Mg7GFW=s6W5xeGa5vG7_GmedsP6uQG_dpZKkzp1CDJqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0701CA0050.eurprd07.prod.outlook.com
 (2603:10a6:203:2::12) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb489f2-fa25-45d3-122b-08daa1f75f51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yBIgxkuozRVjNPmXP99fPeWNqjf0gLvWPYL+7/r01lA/HJikgNGXU/Qnw2dpya9cHh8fDiVcsTtqB69Yz77kXd04B2qe87jgYxtLrfN+dTGtl96Ao9U0sr4/WxxleI0kge8WU5hvMDrWJfIAeB5OFRWD/qHLOcUwB9W4dM3Khj5udjtmpncNG7xPz/kreOwqsWzhE4piOwld95lNzQuYkqoXGyMVT3r0vNSYQrOkBhZNofcM8y0UOf6G5mkmiTe4yrE7XWJxOpDtD8PwBgx3aVHm76Rw2Xrmqb1OqQ+XJzS4uHuw8mAJ0HpvyPGmoxYb76rMmSN+Yolymar50mrIqyptN/xwghzIHK809uYJHZnQN49KvZr14ZwpcR6BRVx/Umr09qdjeqionCXrRkNbiK4WTrD53ELkYdjSWnoFG7F97DltiW5/ZOyW0YKAzUAdGCewne9U2aRKhT5YqbYJQGFDNkzN9TC9ousS1nGhz1it/l9QebVmvuBzRZLEM1IeCENQokVs70s0NuQxZRvcHb+Myxmg3Dwj97coKSZO9pKzTGB8QEQ3UGn1ZvJxeaZ2knzfjL6Qh3zBv7bzrKoG6ilYhJ0+fS14WJZNs7Hq2+qkubqD4GN9E0MLIu2Ev2SLYkMzxkm9ynhSn53O1F7JbZSZCiJqBmaRaDmMkEZ7Hs1H4Nnc4XnyqA6dyFfDRgSbJiGDWoyZBKVzwvy6WoXQgqdLQli9O8puLeSaG/9fLe8XwLQq/DAr2XufK88VPntUgvwCMoK+fEDykxMxg6Y6jYZTY9Pp2E5H7Gr65HSplKU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(31686004)(66476007)(26005)(6512007)(66574015)(2616005)(186003)(38100700002)(36756003)(478600001)(6506007)(316002)(6486002)(53546011)(83380400001)(6666004)(2906002)(8936002)(54906003)(5660300002)(41300700001)(6916009)(66946007)(4326008)(8676002)(66556008)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGEweHRhYkVCVkJMZWZpRlhFMjRHMXNRTDBSL2E5R0RHdkJDUCs3a2ZxeEtE?=
 =?utf-8?B?RFZxME9sWEF1Z3dZeHR1eVhMK3orSnMyOUhhRnNKRkFFYUwzaS9Zek5jQy94?=
 =?utf-8?B?TVM4QVdPaEMrUHpQL0szMks3YWlNbWRuV3J1dWc1Nzl6SU9wYXB1YWFzY20w?=
 =?utf-8?B?YkphQk9FL2psaWlJcnpLeENYN2RWaGw1NjJEK2FWYXRxZGNlWmhyK3JUZFV2?=
 =?utf-8?B?dXBOTVVaSm1IZHNUMkNKWFZDNDN3THRNRXA0c1lGbW1LWThoQmFoTzdvUGoz?=
 =?utf-8?B?M3VTNTlhZGFPMjQxNUVRRlpndTN6VFpLSXJGU3hLQmFLd1hmWWcrVTg4dnBO?=
 =?utf-8?B?clR6SW9HOVIrTHRIM3ZZTHZvR25vd1J5cnlIekZFNW5tL0pqUmVPU2xrS0xX?=
 =?utf-8?B?QVNTYVljRHcxWVloQ0l2eVlLaDNCVEhqOTMweUhMTlJFOWNyY2RLS1lUNEwr?=
 =?utf-8?B?TjhNMis2VnVjbnNZNFFBK1pEREZSYlB5dU1OcnpvRkZVdjM1Qi82OGZMbFNL?=
 =?utf-8?B?NStHNGhKcTE1TDR3MEN5WmxTYmI3cXh3TUN5QWRuYkNuQi9Ba1N1cUltQUJD?=
 =?utf-8?B?dzFNQmMzREZIcndpekhMcGp3eUI2dVBrdzRrcjZtaE9KUStQYWtRRUZPOHZH?=
 =?utf-8?B?ODVpOEZkRkRPNlJORDM4WFBXNWZvaWxzUHRFUW1tVzFQYzZjTFVCSWZZVENH?=
 =?utf-8?B?MG9NMFpPUGNmNStUa3lIRHJnaXU1N3BrU3FKdTNuT1lkcmhLQzREb0ZPL0xp?=
 =?utf-8?B?Ulh3Um41aXc4NmJTZnhEU0MyMDVlOWZRTm1oWkZjYkJ5QmlLNHU3bHIzSUo4?=
 =?utf-8?B?Yk13a2JMaTI5akNUUHNRblY5K01UNSt1YTAzdmZLK0NZYTdYQ0YrTEZFUjYy?=
 =?utf-8?B?NW44M043Yi80WWdCU1JhdWh4OHhQeUdQQXdmeU0vUTJrSUROQ296dkNCdUla?=
 =?utf-8?B?M084NElzOEI4M3Z6T3dpdkEvTmtUdzZGcmNGejVvcmk2STUrYW1QVlN4OG1N?=
 =?utf-8?B?T0lqOHN4TlJ4cE5WdDRRbDhJYzE2eU5UTGJZYmcxOUdJbFMwUlRBdkZ5dm91?=
 =?utf-8?B?NUlRaDdrR211UmMrcEg2VGN4bi8xT2NDOGRiYzRMaDhOVCt3RTNFUmVQb1NS?=
 =?utf-8?B?cnNGeFg1UHRxM1dTcVZpWXNrQUNwVjdteE10VUJ3cGxpQ2Vjd3huVjJUZGFm?=
 =?utf-8?B?WU9YVEFMYi94TDJVY2ltVTJNYWRvMndmVjdWY1RMd3RraWFxdTZHRm9kbE0z?=
 =?utf-8?B?eGNJWkNYQXpQMkZxWlphZk1iZTIrYW1lWUZRT2JXR290ZTlaT3V1YVcyZUZn?=
 =?utf-8?B?bHR5YlRSbURkbDFGSmNXWDBKaXV6SHdPRmU2Y0hHbHlBSlZVdlBENnBCaSt6?=
 =?utf-8?B?MkxXL2l0Ymc0K2lnSVVFdTVXU3M3M0RRRlB2SkE0WGkzNUZ3c3VIc1QyQi9w?=
 =?utf-8?B?M0pVMVdZb3MxZEx2U3g5RkdweU5ITWhrUWtkR3RYMmVjbldsaVFkTnRzYmxw?=
 =?utf-8?B?Q2FRSjZZK21BTjBLUytYL3BDWDdpa3BGWmRDUExtdnVOekZIV1p3NlB6OEk5?=
 =?utf-8?B?YURXY0lqbVM1dlRQQWxkNG9mZVpyK2N3d29MMExSRHNmZXFTMld1REsxRHJN?=
 =?utf-8?B?STRpWE80cU1hQXMrMWkvNSs1SE1vRFU3SGowdDJ5NVV6WDk3ODF1TlYzN0FX?=
 =?utf-8?B?THFzVnpBQk5jSEk1cU5YdU54SEMvVVIwT3FxVVV6MDYrSjhZMVduT2w2UkIy?=
 =?utf-8?B?a3RvZVVwSzdVNFJ1QUtZOHZ4T3AxdXVpb3BKLzBPamtlMm5tMGdQZUs2UTlN?=
 =?utf-8?B?ZWhwOFdueGoxdGtueUd5RmdhK1lLU0JGNWY3eUVjUkpxbVlTTGtmOUJYV25T?=
 =?utf-8?B?aVF2cUhCdUZnN2g2SVFsQ2FXTTNmenNJK0h0VjdlczVmclUrVmxBTHlnT3Vn?=
 =?utf-8?B?TCtHSTRyL3RHbkQ1UXI3UCtxbkx0Mk51aWpvK2FYWXNjQ05uYmJWZWd0K2dy?=
 =?utf-8?B?blJmTmlScllkLzhUcit6T1ZHL25paE5ySi94Snk4ZXFUOTZyTUM5aTMydUpL?=
 =?utf-8?B?bEdJd3dkUml0Y0VCaEY0TyttdG1yL1JrMTMzd3k3MlRMTDBzKzlnUm5iWkdk?=
 =?utf-8?Q?+c9ujOrnXtok5U/xboIt4AAs/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb489f2-fa25-45d3-122b-08daa1f75f51
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 08:48:25.6051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6pyx3mxOkvfl849hcEUuGNAbBPlM5RU1GPTiQirO4aESUjFKaafqn08scd2PD40jTbki8G1lJHKe85UgeYCuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820
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



On 9/28/2022 11:51 PM, Alex Deucher wrote:
> On Wed, Sep 28, 2022 at 4:57 AM Sharma, Shashank
> <shashank.sharma@amd.com> wrote:
>>
>>
>>
>> On 9/27/2022 10:40 PM, Alex Deucher wrote:
>>> On Tue, Sep 27, 2022 at 11:38 AM Sharma, Shashank
>>> <shashank.sharma@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 9/27/2022 5:23 PM, Felix Kuehling wrote:
>>>>> Am 2022-09-27 um 10:58 schrieb Sharma, Shashank:
>>>>>> Hello Felix,
>>>>>>
>>>>>> Thank for the review comments.
>>>>>>
>>>>>> On 9/27/2022 4:48 PM, Felix Kuehling wrote:
>>>>>>> Am 2022-09-27 um 02:12 schrieb Christian König:
>>>>>>>> Am 26.09.22 um 23:40 schrieb Shashank Sharma:
>>>>>>>>> This patch switches the GPU workload mode to/from
>>>>>>>>> compute mode, while submitting compute workload.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>>>>
>>>>>>>> Feel free to add my acked-by, but Felix should probably take a look
>>>>>>>> as well.
>>>>>>>
>>>>>>> This look OK purely from a compute perspective. But I'm concerned
>>>>>>> about the interaction of compute with graphics or multiple graphics
>>>>>>> contexts submitting work concurrently. They would constantly override
>>>>>>> or disable each other's workload hints.
>>>>>>>
>>>>>>> For example, you have an amdgpu_ctx with
>>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE (maybe Vulkan compute) and a KFD
>>>>>>> process that also wants the compute profile. Those could be different
>>>>>>> processes belonging to different users. Say, KFD enables the compute
>>>>>>> profile first. Then the graphics context submits a job. At the start
>>>>>>> of the job, the compute profile is enabled. That's a no-op because
>>>>>>> KFD already enabled the compute profile. When the job finishes, it
>>>>>>> disables the compute profile for everyone, including KFD. That's
>>>>>>> unexpected.
>>>>>>>
>>>>>>
>>>>>> In this case, it will not disable the compute profile, as the
>>>>>> reference counter will not be zero. The reset_profile() will only act
>>>>>> if the reference counter is 0.
>>>>>
>>>>> OK, I missed the reference counter.
>>>>>
>>>>>
>>>>>>
>>>>>> But I would be happy to get any inputs about a policy which can be
>>>>>> more sustainable and gets better outputs, for example:
>>>>>> - should we not allow a profile change, if a PP mode is already
>>>>>> applied and keep it Early bird basis ?
>>>>>>
>>>>>> For example: Policy A
>>>>>> - Job A sets the profile to compute
>>>>>> - Job B tries to set profile to 3D, but we do not allow it as job A is
>>>>>> not finished it yet.
>>>>>>
>>>>>> Or Policy B: Current one
>>>>>> - Job A sets the profile to compute
>>>>>> - Job B tries to set profile to 3D, and we allow it. Job A also runs
>>>>>> in PP 3D
>>>>>> - Job B finishes, but does not reset PP as reference count is not zero
>>>>>> due to compute
>>>>>> - Job  A finishes, profile reset to NONE
>>>>>
>>>>> I think this won't work. As I understand it, the
>>>>> amdgpu_dpm_switch_power_profile enables and disables individual
>>>>> profiles. Disabling the 3D profile doesn't disable the compute profile
>>>>> at the same time. I think you'll need one refcount per profile.
>>>>>
>>>>> Regards,
>>>>>      Felix
>>>>
>>>> Thanks, This is exactly what I was looking for, I think Alex's initial
>>>> idea was around it, but I was under the assumption that there is only
>>>> one HW profile in SMU which keeps on getting overwritten. This can solve
>>>> our problems, as I can create an array of reference counters, and will
>>>> disable only the profile whose reference counter goes 0.
>>>
>>> It's been a while since I paged any of this code into my head, but I
>>> believe the actual workload message in the SMU is a mask where you can
>>> specify multiple workload types at the same time and the SMU will
>>> arbitrate between them internally.  E.g., the most aggressive one will
>>> be selected out of the ones specified.  I think in the driver we just
>>> set one bit at a time using the current interface.  It might be better
>>> to change the interface and just ref count the hint types and then
>>> when we call the set function look at the ref counts for each hint
>>> type and set the mask as appropriate.
>>>
>>> Alex
>>>
>>
>> Hey Alex,
>> Thanks for your comment, if that is the case, this current patch series
>> works straight forward, and no changes would be required. Please let me
>> know if my understanding is correct:
>>
>> Assumption: Order of aggression: 3D > Media > Compute
>>
>> - Job 1: Requests mode compute: PP changed to compute, ref count 1
>> - Job 2: Requests mode media: PP changed to media, ref count 2
>> - Job 3: requests mode 3D: PP changed to 3D, ref count 3
>> - Job 1 finishes, downs ref count to 2, doesn't reset the PP as ref > 0,
>> PP still 3D
>> - Job 3 finishes, downs ref count to 1, doesn't reset the PP as ref > 0,
>> PP still 3D
>> - Job 2 finishes, downs ref count to 0, PP changed to NONE,
>>
>> In this way, every job will be operating in the Power profile of desired
>> aggression or higher, and this API guarantees the execution at-least in
>> the desired power profile.
> 
> I'm not entirely sure on the relative levels of aggression, but I
> believe the SMU priorities them by index.  E.g.
> #define WORKLOAD_PPLIB_DEFAULT_BIT        0
> #define WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT 1
> #define WORKLOAD_PPLIB_POWER_SAVING_BIT   2
> #define WORKLOAD_PPLIB_VIDEO_BIT          3
> #define WORKLOAD_PPLIB_VR_BIT             4
> #define WORKLOAD_PPLIB_COMPUTE_BIT        5
> #define WORKLOAD_PPLIB_CUSTOM_BIT         6
> 
> 3D < video < VR < compute < custom
> 
> VR and compute are the most aggressive.  Custom takes preference
> because it's user customizable.
> 
> Alex
> 

Thanks, so this UAPI will guarantee the execution of the job in atleast 
the requested power profile, or a more aggressive one.

I will do the one change required and send the updated one.

- Shashank

> 
> 
> 
>>
>> - Shashank
>>
>>>
>>>>
>>>> - Shashank
>>>>
>>>>>
>>>>>
>>>>>>
>>>>>>
>>>>>> Or anything else ?
>>>>>>
>>>>>> REgards
>>>>>> Shashank
>>>>>>
>>>>>>
>>>>>>> Or you have multiple VCN contexts. When context1 finishes a job, it
>>>>>>> disables the VIDEO profile. But context2 still has a job on the other
>>>>>>> VCN engine and wants the VIDEO profile to still be enabled.
>>>>>>>
>>>>>>> Regards,
>>>>>>>      Felix
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>> ---
>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 14 +++++++++++---
>>>>>>>>>     1 file changed, 11 insertions(+), 3 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>> index 5e53a5293935..1caed319a448 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>> @@ -34,6 +34,7 @@
>>>>>>>>>     #include "amdgpu_ras.h"
>>>>>>>>>     #include "amdgpu_umc.h"
>>>>>>>>>     #include "amdgpu_reset.h"
>>>>>>>>> +#include "amdgpu_ctx_workload.h"
>>>>>>>>>       /* Total memory size in system memory and all GPU VRAM. Used to
>>>>>>>>>      * estimate worst case amount of memory to reserve for page tables
>>>>>>>>> @@ -703,9 +704,16 @@ int amdgpu_amdkfd_submit_ib(struct
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>       void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev,
>>>>>>>>> bool idle)
>>>>>>>>>     {
>>>>>>>>> -    amdgpu_dpm_switch_power_profile(adev,
>>>>>>>>> -                    PP_SMC_POWER_PROFILE_COMPUTE,
>>>>>>>>> -                    !idle);
>>>>>>>>> +    int ret;
>>>>>>>>> +
>>>>>>>>> +    if (idle)
>>>>>>>>> +        ret = amdgpu_clear_workload_profile(adev,
>>>>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
>>>>>>>>> +    else
>>>>>>>>> +        ret = amdgpu_set_workload_profile(adev,
>>>>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
>>>>>>>>> +
>>>>>>>>> +    if (ret)
>>>>>>>>> +        drm_warn(&adev->ddev, "Failed to %s power profile to
>>>>>>>>> compute mode\n",
>>>>>>>>> +             idle ? "reset" : "set");
>>>>>>>>>     }
>>>>>>>>>       bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32
>>>>>>>>> vmid)
>>>>>>>>
