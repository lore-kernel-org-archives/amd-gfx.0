Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9D6C54EE9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 13:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0627710E460;
	Fri, 16 Sep 2022 13:51:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B485410ED43
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 13:51:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXOgh0bY5EAqWd3ofL4XieOPhgGPGQfRzr/UuXWyNW8rKX4IQk/RoiQnlCJuSfVJ4+b3gP1XwpE7uk2TYaoSDIALuc6ZroFNYD2K6f1EMRy6D9YAAPNQk4sGfpAHv0SvhCeXLGPLjU7bcVRhgODoYaRa3nPZy4C/eGRZhnLIGR8QRKxyBqRXBCBqDFRmHwOIkS+99fqx47qrx8cOhgsvtO0Pr7HsUC5DLe0361os8cR8UaXulrfJCnxSY7af+PoWvqJF5it31yRvMz/CT0+o++RYeKY/4zjpZHZF9AneC78DMQufgUZ7o3LGjYsCfVYys1C2SifWzKBvLopxHsbKpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ataBRvaDlrp1HwV9szUOBc4UgrUtdVNXB69acEe+56k=;
 b=AehFc619aE30yjW55QDuJ+EUZOdTH6lL5tUsun6Cxnw6LmdsIx7VSD3J6qKuM/giMOPnbOCvh6NsNWwTChPTtsLd9eclkmfg6konqVMQbpBxlgDAorYRLOsk6NMrT67rqRp7wQkejtQ2u0QTPML3gwA2LL/5JcFX99Rwsk1b192btO3cLIga+hZeYdn2Vjv4ZRaDNrfmSsDzgM4vifo+YkXgMemvJwtdrdAuHzimsLB1/nLbl0st2sfdjz1eUGu+wzCYcHUUDowvkub5l6aHDLrqgJhPFY3QO8GjepswDMCbAcsyTDH0wIkFBOuyHMzIifyq6pIFzIQl5wvGksX3kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ataBRvaDlrp1HwV9szUOBc4UgrUtdVNXB69acEe+56k=;
 b=LQK5ijTE6xDIuJ6X15bGV0CALWwS/XHdICJeKFGd3RWF/3eePzBAX1dcJoT3mUIEyPaMyrErtTzlDR1jQn4t9bpyrKqRR4ijtKFrGGyWp+y5LAO8FxB74Ucii9CEWx50thI87u3mSOt6soG+8k3Lk5YcxasngAtNFyZDr24aZw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB7647.namprd12.prod.outlook.com (2603:10b6:8:105::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Fri, 16 Sep
 2022 13:51:37 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5632.015; Fri, 16 Sep 2022
 13:51:37 +0000
Message-ID: <82930727-de50-49dc-f1a5-a35f37b66330@amd.com>
Date: Fri, 16 Sep 2022 15:51:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 "Zhao, Victor" <Victor.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220914101025.366954-1-Victor.Zhao@amd.com>
 <DM6PR12MB4340D28D9D23472D571727D7FA499@DM6PR12MB4340.namprd12.prod.outlook.com>
 <1ea8528f-fb55-e8b1-73c8-bf8935f9870c@amd.com>
 <DM6PR12MB434047014434C43396BB2D31FA499@DM6PR12MB4340.namprd12.prod.outlook.com>
 <e7eadc0d-c9a6-8a12-bbd7-5dd3277a7754@amd.com>
 <fc7f7d5f-3d63-234f-1864-ab365d6e338d@amd.com>
 <378f971b-9ee6-5fb3-4143-f20b873d0b4b@amd.com>
 <3ee47f74-fca4-f78c-9235-972d4543d880@amd.com>
 <d4fff5a6-833a-161f-d86e-b17cb9d9382c@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <d4fff5a6-833a-161f-d86e-b17cb9d9382c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR04CA0113.eurprd04.prod.outlook.com
 (2603:10a6:20b:531::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM4PR12MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: df040c33-72c6-410e-36c9-08da97ea930e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0IapZKKOQqaWGTdbibsoM4jGkXm6TYP2IjzrQdFsMdIN3nomwcVOUC9ij7SQRyfvuaKFNIOaor9hiO0qu2C5uxSPlPFVcA4mep0n002azZECmxNUrRuMyII2Jvee03RIfHbf8AglyTKLEvbm+M8DpgDvPtBAnQ/v/JW+xnfPu0/WkovIbCazqH1Is3eDO0Ki+p0S8lL4G35wo6zrj2l+yPOg0Xx2zNfDrxlXjiObUhjygSlQ19n4j4fYfX9C99li8JScvvgoX+PtqKzgzBjaf73MOQ5BJf6zwNPwiYGc5Dcoy0AV64PRwnWBiUVlkWkpv38DrDur1RuWxlKCpEdpv7l7e7pXfelZiHOEymZQevOK2G6TK9YQFr98R3kUnh3PvZUHMm4n3Gooxhg71mRplTbGxqRO/wnld9to/bGiO5MrnDLZqLW/KUo4kMlj69liI8KMskfIVpi7yTAzMeJyveJJEym8gN87mWn+siM2snsGs3VXnc2QelPD4kSq7g5pWed8LNw4OJoLXU8toB5jvObwqhfFJ6ZWpzrAukvf4jsTKWf2SiNMvQacRK4pN2BARBHY231kw23Hn7MHFeMiuKYc9Hg0eBWdhd2wXVkS84rMHGzp7CngFYeS0JO8RinwvwJbl2Z3UGRxQrW09/cZJswSB787FpT5Uurpi7nfsAZiOVAFUfN/agglN8YfZF4jZu8yoxE7QbviUpimP13mwdmJ3+C4cLy62yG9wSrKUu2qK/uFm3qeGJ8UC7x5Jjf0EXxIoslwGrMFwFvCUmoEwZ8uEkE/xdIR234jF9Q3EZzA44fVjdpR5i6EC2J4T8GjM5NEFnYDjkSp/rEY7Hw8AA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199015)(83380400001)(31686004)(36756003)(38100700002)(86362001)(2906002)(31696002)(8676002)(478600001)(66946007)(186003)(4326008)(6486002)(66574015)(8936002)(30864003)(66476007)(66556008)(53546011)(2616005)(6666004)(5660300002)(41300700001)(6506007)(316002)(110136005)(6512007)(509564003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGJGZUNwZmFhenNUa0pXSE11WU5vVk43U3VyV2ZRdWFaNGhQZS8xSUsveWxI?=
 =?utf-8?B?SzB4UFJGcHNaSGJZakd5S2tpNmpEcEJBZkcra3k5alVDaGR5ejBhU3M0eTBi?=
 =?utf-8?B?YUlPVUF0dVdCcFVpYXIxODErSmY3RVdoc0t3dXRlaXA3K2R2QWlWMlNXOC9s?=
 =?utf-8?B?SGJHWVRhZVhpMTVNa0JRdkVrQVhpVE5jOEpkQlA3QkJJbU1ReEo4NzcrNHJL?=
 =?utf-8?B?eDVQN0NDcjFUaUxFTlp4SkMzcEVzY3Jyd3BsdSthcXdjcStad3hhay83cFlT?=
 =?utf-8?B?Vm43bnVDQ1F1elUvSHUvcENHc2pOSzdNS1ZXeksveWkzbmF5eUZXOEZJRktT?=
 =?utf-8?B?RUFuMWxBRXZlTDdzeWxOVzFGRlJua05IOWFiTEp3cnVEKzJjRkwySGFPWkM4?=
 =?utf-8?B?eGRlN1pScVJiekNKM2JFbVVySnF6eDBVVFpKVXJyMHR5alFGdEFMRlN4TzFu?=
 =?utf-8?B?RTdIaVJuTk1MMFczZ1Z6OFRscjRLL1B6dFc0dG9xMjY0c080Mm5TMW9MNkt0?=
 =?utf-8?B?ZjBUV2FKL0h4U0tZM3FmVU1namY4NnVsYmF6RVlrTzZoSHVLSVJjZlE0Mm1C?=
 =?utf-8?B?RnRENzh5a3A2NFlVcXZENlc3V1NVR0dsNjZySXcya2hWbjBJY0Vaamc5dXdi?=
 =?utf-8?B?dDl0ZjhyakcwbVdkZ1U1Q2NxeXNSd3ovWTNCc3VERFNPalBMeS9wTG42WE5r?=
 =?utf-8?B?UlQ3cmp4ZTlaaXhFdG1aN1JTZWdBNUM1YW55NExjYU1nTFZnZkdiTXVYU1Ni?=
 =?utf-8?B?bUdLWDJSNE5PSmc5U09qTmwrWmEybndnMHBoRWp4NFRBTUYzYXJFSzdXMmYv?=
 =?utf-8?B?WGl2cGpSc285Vm5LNXNOcVR3VldSd1JnZHZ1cGhlTmhRejdwd3JhSkpTc2hV?=
 =?utf-8?B?bGtxRHIvYkxkMEFUeC9Gc3dCSVBvVVgwOWJrK21yZEtSSkdUMlJHVHJZczZM?=
 =?utf-8?B?Mi82TU5taDlqZUhFeng4bGhiK21rNGNXM0ZoOFBRTkVSUDBabDlXUDJEd0g0?=
 =?utf-8?B?NkhrRHdkcVZabEttbkdZbDVGWDc3anpTb3JMd3RIRVJHOGVjeG5iZE9FTlFq?=
 =?utf-8?B?NEhUV0RtMEc1MHZmZGRURUxRNGRQQXhmaE1WU1krdUtBVG13RmIwb2J1akRv?=
 =?utf-8?B?aUlGdTlBY2VPbWRiTEFOSDVRN3FsZjBSMzc2c3JFR2xrOVBrR0ZQWjdUWlZC?=
 =?utf-8?B?bFF5bUIxRGFKK1RPTkV6RlJMbGU2ZWVKTGhFejhaam1qSDVVeFN1c2k4SWp0?=
 =?utf-8?B?U05zNCtGYXFkSXp1REJKU2llbmEyK2hCa1E4Y0Q0NmlTcFVxSGplYW54VUUy?=
 =?utf-8?B?UmZ0SGRVVXlGTyttMURFU0dXc0RKR2NSZ0pwQlphRTFJWVRVSUJvcHJYZDF5?=
 =?utf-8?B?KzhTWTdobDhTYmY3Z2dycEVtVUpsWk0wck9lbXpEa1J4OCtTbSsrSWg5SmJE?=
 =?utf-8?B?akRxWU95S2Rnak5oZzE3U3lRckZ5V1Vpb3B3RndsNzd2ZTVlYTdHVEtxV3ZE?=
 =?utf-8?B?M01PUlBKVFF5S090aStNd29UZjFFcnlzcFlPOTNocU1aaFpEZXFPc0YvTFE3?=
 =?utf-8?B?ajc3VUNxb3ZZUzdoeDcrb2pUSnM3bjJtb2RRU09iTmtqbmhJaGlqS2ZRVGto?=
 =?utf-8?B?eThYUGhaWmV2emRYRTUwMFdqRlRWQWs2SnVFUElXRkFCUHhJK1o1d3MvU1pS?=
 =?utf-8?B?aTEwRmQ0N0xwd1lNSFR2WVFicmRGVGF2TjdVaWxiOE12eXprR1NoNldHUEhO?=
 =?utf-8?B?SHpwRGVnZnBNMkpEdHhBQ2RIdWNrVUhHZnZINkpDWFMrZGluTGoyVnFhcVRP?=
 =?utf-8?B?WDBoUzJoY0xhdDVTaDVnWmJFeVNoZE4vTW9LUk5kY1BSeDkvVEl4ZGh6dmdz?=
 =?utf-8?B?cVpETFNHZlJTN1RTUHNTZVIrS1czY2pER1lacnA1WWZVeDZPbXN2WkVwMzFh?=
 =?utf-8?B?Wm9vSDRoUmJXNnJQeFhFaXRMRCtxQ1NsRktuRTlnNllBRTl0Wm5EZ05ORnN5?=
 =?utf-8?B?cGtxalBRTVlzMkl3Sjh1YW5XQXMyaXpxRmUzbXV6aGphc3lyeUY1TUdxY0xF?=
 =?utf-8?B?Um81cHBYZVMxWFFVV3QxZUptV3dheXREOTFHVlBXdFdJY1h6cWttU2lNc0ZX?=
 =?utf-8?B?Y0hGRnVnVXJwSTR4SGpUWlNnbjFuaWUrUG81TVA1cThzMG1xdWRlRS9oRG1l?=
 =?utf-8?Q?aXY5oSQ1d/RogAg2tFmwjMlzCE3rupdlpHQ9DkZPYI7G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df040c33-72c6-410e-36c9-08da97ea930e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 13:51:37.3857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPjLE1/cgb1n2Sc4J1EEn2qMidNrVKWPiLGBlQJBqUgK7InSPH2cWCebYXt4V6dG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7647
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 16.09.22 um 15:50 schrieb Andrey Grodzovsky:
>
> On 2022-09-16 01:18, Christian König wrote:
>> Am 15.09.22 um 22:37 schrieb Andrey Grodzovsky:
>>>
>>> On 2022-09-15 15:26, Christian König wrote:
>>>> Am 15.09.22 um 20:29 schrieb Andrey Grodzovsky:
>>>>>
>>>>> On 2022-09-15 06:09, Zhao, Victor wrote:
>>>>>> [AMD Official Use Only - General]
>>>>>>
>>>>>> Hi Christian,
>>>>>>
>>>>>> The test sequence is executing a compute engine hang while 
>>>>>> running a lot of containers submitting gfx jobs. We have advanced 
>>>>>> tdr mode and mode2 reset enabled on driver.
>>>>>> When a compute hang job timeout happens, the 2 jobs on the gfx 
>>>>>> pending list maybe signaled after drm_sched_stop. So they will 
>>>>>> not be removed from pending list but have the 
>>>>>> DMA_FENCE_FLAG_SIGNALED_BIT set.
>>>>>> At the amdgpu_device_recheck_guilty_jobs step, the first job will 
>>>>>> be rerun and removed from pending list.
>>>>>> At the resubmit setp, the second job (with signaled bit) will be 
>>>>>> resubmitted. Since it still has signaled bit, drm_sched_job_done 
>>>>>> will be called directly. This decrease the hw_rq_count which 
>>>>>> allows more jobs emitted but did not clean fence_drv rcu ptr.
>>>>>> This results in an overflow in the fence_drv. Since we will use 
>>>>>> num_fences_mask in amdgpu_fence_process, when overflow happens, 
>>>>>> the signal of some job will be skipped which result in an 
>>>>>> infinite wait for the fence_drv rcu ptr.
>>>>>>
>>>>>> So close irq before sched_stop could avoid signal jobs after 
>>>>>> drm_sched_stop. And signal job one by one in fence_process 
>>>>>> instead of using a mask will handle the overflow situation.
>>>>>>
>>>>>> Another fix could be skip submitting jobs which already signaled 
>>>>>> during resubmit stage, which may look cleaner.
>>>>>>
>>>>>> Please help give some advice.
>>>>>
>>>>>
>>>>> How about the code bellow  instead ? The real problem is that we 
>>>>> reuse a dma fence twice which is not according to fma fence 
>>>>> design, so maybe this can help ?
>>>>>
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>> index 8adeb7469f1e..033f0ae16784 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>> @@ -164,6 +164,10 @@ int amdgpu_fence_emit(struct amdgpu_ring 
>>>>> *ring, struct dma_fence **f, struct amd
>>>>>         if (job && job->job_run_counter) {
>>>>>                 /* reinit seq for resubmitted jobs */
>>>>>                 fence->seqno = seq;
>>>>> +
>>>>> +               /* For resubmitted job clear the singled bit */
>>>>> +               celar_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, 
>>>>> &fence->flags);
>>>>> +
>>>>
>>>> Upstream will pretty much kill you for that.
>>>>
>>>> Re-setting a fence from a signaled to an unsignaled state is a 
>>>> massive no-go.
>>>>
>>>> Christian.
>>>
>>>
>>> Is it worse then doing fence->seqno = seq; ? This is already a huge 
>>> hack , no ?
>>
>> No, it's as equally bad. I don't think we can do either.
>>
>> Christian.
>
>
> And all those ugly hack are there because we reuse a dma_fence 
> (hw_fence embedded into the job) and correct me if I am wrong
> but I don't think dma_fence is ever supposed to be reused.

Exactly that, yes.

Christian.

>
> So maybe like Victor suggested we should move close and flush irq 
> before sched_stop - this in my opinion should solve the issue, but 
> Victor - why then you still need the change in amdgpu_fence_process ? 
> You will not have the overflow situation because by moving irq_disable 
> before stop any job that signaled will be removed from the scheduler 
> pending list anyway. Also not that this change reverts 'drm/amdgpu: 
> sanitize fence numbers' and could reintroduce that bug.
>
> Andrey
>
>
>>
>>>
>>> Andrey
>>>
>>>
>>>>
>>>>>
>>>>>                 /* TO be inline with external fence creation and 
>>>>> other drivers */
>>>>>                 dma_fence_get(fence);
>>>>>         } else {
>>>>>
>>>>>
>>>>> Andrey
>>>>>
>>>>>
>>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Victor
>>>>>>
>>>>>>
>>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>>> Sent: Thursday, September 15, 2022 2:32 PM
>>>>>> To: Zhao, Victor <Victor.Zhao@amd.com>; 
>>>>>> amd-gfx@lists.freedesktop.org; Grodzovsky, Andrey 
>>>>>> <Andrey.Grodzovsky@amd.com>
>>>>>> Cc: Deng, Emily <Emily.Deng@amd.com>
>>>>>> Subject: Re: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
>>>>>>
>>>>>>
>>>>>>
>>>>>> Am 15.09.22 um 06:02 schrieb Zhao, Victor:
>>>>>>> [AMD Official Use Only - General]
>>>>>>>
>>>>>>> Ping.
>>>>>>>
>>>>>>> Hi @Koenig, Christian and @Grodzovsky, Andrey,
>>>>>>>
>>>>>>> We found some reset related issues during stress test on the 
>>>>>>> sequence. Please help give some comments.
>>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Victor
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Victor Zhao <Victor.Zhao@amd.com>
>>>>>>> Sent: Wednesday, September 14, 2022 6:10 PM
>>>>>>> To: amd-gfx@lists.freedesktop.org
>>>>>>> Cc: Deng, Emily <Emily.Deng@amd.com>; Grodzovsky, Andrey
>>>>>>> <Andrey.Grodzovsky@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>
>>>>>>> Subject: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
>>>>>>>
>>>>>>> [background]
>>>>>>> For a gpu recovery caused by a hang on one ring (e.g. compute), 
>>>>>>> jobs from another ring (e.g. gfx) may continue signaling during 
>>>>>>> drm_sched_stop stage. The signal bit will not be cleared.
>>>>>>>
>>>>>>> At the resubmit stage after recovery, the job with hw fence 
>>>>>>> signaled bit set will call job done directly instead go through 
>>>>>>> fence process.
>>>>>>> This makes the hw_rq_count decrease but rcu fence pointer not 
>>>>>>> cleared yet.
>>>>>>>
>>>>>>> Then overflow happens in the fence driver slots and some jobs 
>>>>>>> may be skipped and leave the rcu pointer not cleared which makes 
>>>>>>> an infinite wait for the slot on the next fence emitted.
>>>>>>>
>>>>>>> This infinite wait cause a job timeout on the emitting job. And 
>>>>>>> driver will stuck at the its sched stop step because 
>>>>>>> kthread_park cannot be done.
>>>>>>>
>>>>>>> [how]
>>>>>>> 1. move amdgpu_fence_driver_isr_toggle earlier to close interrupt
>>>>>>> before drm sched stop 2. handle all fences in fence process to 
>>>>>>> aviod
>>>>>>> skip when overflow happens
>>>>>>>
>>>>>>> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>>>>>>> ---
>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 
>>>>>>> +++++++++++++--- drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c |  6 
>>>>>>> +-----
>>>>>>>    2 files changed, 14 insertions(+), 8 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> index 943c9e750575..c0cfae52f12b 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> @@ -4610,8 +4610,6 @@ int amdgpu_device_pre_asic_reset(struct 
>>>>>>> amdgpu_device *adev,
>>>>>>>            amdgpu_virt_fini_data_exchange(adev);
>>>>>>>        }
>>>>>>>    -    amdgpu_fence_driver_isr_toggle(adev, true);
>>>>>>> -
>>>>>>>        /* block all schedulers and reset given job's ring */
>>>>>>>        for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>>>>>>            struct amdgpu_ring *ring = adev->rings[i]; @@ -5214,6 
>>>>>>> +5212,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device 
>>>>>>> *adev,
>>>>>>> amdgpu_device_ip_need_full_reset(tmp_adev))
>>>>>>>                amdgpu_ras_suspend(tmp_adev);
>>>>>>>    +        amdgpu_fence_driver_isr_toggle(tmp_adev, true);
>>>>>>> +
>>>>>>>            for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>>>>>>                struct amdgpu_ring *ring = tmp_adev->rings[i];
>>>>>>>    @@ -5228,8 +5228,12 @@ int amdgpu_device_gpu_recover(struct 
>>>>>>> amdgpu_device *adev,
>>>>>>> atomic_inc(&tmp_adev->gpu_reset_counter);
>>>>>>>        }
>>>>>>>    -    if (need_emergency_restart)
>>>>>>> +    if (need_emergency_restart) {
>>>>>>> +        list_for_each_entry (tmp_adev, device_list_handle, 
>>>>>>> reset_list) {
>>>>>>> +            amdgpu_fence_driver_isr_toggle(tmp_adev, false);
>>>>>>> +        }
>>>>>>>            goto skip_sched_resume;
>>>>>>> +    }
>>>>>>>           /*
>>>>>>>         * Must check guilty signal here since after this point 
>>>>>>> all old @@ -5240,6 +5244,9 @@ int 
>>>>>>> amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>>>>>>        if (job && dma_fence_is_signaled(&job->hw_fence)) {
>>>>>>>            job_signaled = true;
>>>>>>>            dev_info(adev->dev, "Guilty job already signaled, 
>>>>>>> skipping HW
>>>>>>> reset");
>>>>>>> +        list_for_each_entry (tmp_adev, device_list_handle, 
>>>>>>> reset_list) {
>>>>>>> +            amdgpu_fence_driver_isr_toggle(tmp_adev, false);
>>>>>>> +        }
>>>>>>>            goto skip_hw_reset;
>>>>>>>        }
>>>>>>>    @@ -5276,6 +5283,7 @@ int amdgpu_device_gpu_recover(struct 
>>>>>>> amdgpu_device *adev,
>>>>>>>            if (r && r == -EAGAIN) {
>>>>>>>                set_bit(AMDGPU_SKIP_MODE2_RESET, 
>>>>>>> &reset_context->flags);
>>>>>>>                adev->asic_reset_res = 0;
>>>>>>> +            amdgpu_fence_driver_isr_toggle(adev, true);
>>>>>>>                goto retry;
>>>>>>>            }
>>>>>>>        }
>>>>>>> @@ -5711,6 +5719,8 @@ pci_ers_result_t 
>>>>>>> amdgpu_pci_slot_reset(struct pci_dev *pdev)
>>>>>>>        set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
>>>>>>>        set_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
>>>>>>>    +    amdgpu_fence_driver_isr_toggle(adev, true);
>>>>>>> +
>>>>>>>        adev->no_hw_access = true;
>>>>>>>        r = amdgpu_device_pre_asic_reset(adev, &reset_context);
>>>>>>>        adev->no_hw_access = false;
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>> index 8adeb7469f1e..65a877e1a7fc 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>> @@ -287,15 +287,11 @@ bool amdgpu_fence_process(struct 
>>>>>>> amdgpu_ring *ring)
>>>>>>>        if (unlikely(seq == last_seq))
>>>>>>>            return false;
>>>>>>>    -    last_seq &= drv->num_fences_mask;
>>>>>>> -    seq &= drv->num_fences_mask;
>>>>>>> -
>>>>>>>        do {
>>>>>>>            struct dma_fence *fence, **ptr;
>>>>>>>               ++last_seq;
>>>>>>> -        last_seq &= drv->num_fences_mask;
>>>>>>> -        ptr = &drv->fences[last_seq];
>>>>>>> +        ptr = &drv->fences[last_seq & drv->num_fences_mask];
>>>>>>>               /* There is always exactly one thread signaling 
>>>>>>> this fence slot */
>>>>>>>            fence = rcu_dereference_protected(*ptr, 1);
>>>>>> Those changes here doesn't seem to make sense. Please explain 
>>>>>> further why that is necessary.
>>>>>>
>>>>>> Christian.
>>>>>>
>>>>>>> -- 
>>>>>>> 2.25.1
>>>>
>>

