Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85D2ECAAD3
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 11:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5088C10EAE8;
	Thu, 15 Sep 2022 11:30:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B00010EAEA
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 11:30:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epz/zu6O1t863G98nJOEgtVhawVsJBVVG0up1Y5uUxK4QmDkL6akU36shDUIhXILuJWVNts6wU/75CGtSUS87zw3y/paeN6pXE/rJpfYP6Acfa7tE64Krx0SDbJqM1DCHNe1H3o4ByKaN+Vi1DM5YzOlbdlRDgbxBbPZ88ppkrZyXBzJLytzg9kuXORHK5wEFmc+irUcoOwwlHhbd7o9Q0z+AKdQ0Ctz2GQNk41WQiqc5hQZ6a0zggUMDurtC9YtekyaFtKIY/+OA5RLAlknvM+SUYvq/ury0Qh2fyr3rvJ3mBYz9bya3ZoCJ/8FXlEilqemaTTNz9TwA42p7CT59g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9foUy+zrl4wbgi/KJJfdibh6EE6pHI54mMyjLckr+I=;
 b=Nj6fBEdomMaXEt9cFwQ0spU6v245oI6jK0TVEEPT6V3IsIRzDJidYB4yoszYNryFWWKFrYNqZwWwKSADSvVJTG9pkX0e2A9pvVS2ajb1bPdJIwKYifgk82LSJI/hiQSRAJ/Dx8O8JiSWwbhLNmxXfbsdWPI2/dN/9gg9F/8FFrviab0LI7SKLuEecAy2bOaPXpGn8CmpcTCzxDRWbkK5Uf9AnIxgSw5BMEzX5357qQwQbjgTCmgr2V80tPyuV9JjUqYA/rPtk2UhMccE1SHe5fBKOQ9rYDaKrZWgWiyTQmUCFw2rYl1E/OW3Qi7KS9n6Fk1QOcYuB9axpboPRJ1klQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9foUy+zrl4wbgi/KJJfdibh6EE6pHI54mMyjLckr+I=;
 b=Z3lUJdE9R7yGxq0kPO9A27Q2tKiJOtuTPopyq5/EFE21jxnGG2NdGUg9Df2x9uDaboQP/FaNZ93m3b7Zsyz9AqY+bcIwrDm+D95A8blhyeh+ZhZpN6iv1MgTHd/XuvBblsYkMToSxFpI+yK5Og2g9Q5humUnaN8QetiAsJ4GbaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 11:30:04 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 11:30:02 +0000
Message-ID: <a64ee635-4a28-cd2a-8055-4fedc4473943@amd.com>
Date: Thu, 15 Sep 2022 13:29:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
Content-Language: en-US
To: "Zhao, Victor" <Victor.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
References: <20220914101025.366954-1-Victor.Zhao@amd.com>
 <DM6PR12MB4340D28D9D23472D571727D7FA499@DM6PR12MB4340.namprd12.prod.outlook.com>
 <1ea8528f-fb55-e8b1-73c8-bf8935f9870c@amd.com>
 <DM6PR12MB434047014434C43396BB2D31FA499@DM6PR12MB4340.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM6PR12MB434047014434C43396BB2D31FA499@DM6PR12MB4340.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::12) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CY5PR12MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: a872a01c-d88f-4ff4-80e8-08da970da146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: roOVPlMtE6uOmyZgXckF7gzMBaMgsfDA6WS38fmLgktAqCr4k168PoJ838RrTaTDCrD+SbLcFPdmyyTZTdngwzzG6lrS7KoA0Zgh253vdsgDRPpS46Tgb8IWWw8/vm1AgvnY72thUkvrLbHLGie5qDRRYS0Xd2juszgi7oGopdqg7SKlzpADRlgnPT4oVwCwLFS7yLDTr5AdPAw1nPd7CmSAlS3zDwEnocjnaWBoj4hrL5joACDwK45re7VBQ7aSEQlZuYAX2mGL9UIjsQxaP2GzQZe4pGM79N5US6pVnATWrHcFr+0P9L+0GYyqtS0h/hWSbtIeVxFBvr8EUN+a3zZBqDx6/YiuDxw4sKPOg0ohl1gbbsoeq/VAFCNpeF4GESLzqOM4HmhLyam2CXyuO2snQrxRRy6KN2rZNio75ak8MoFf2Gv+hEBu+/G8zVvcHlRYoMAIeM1BU2wglSjHRzqH+gLkfmCMUQy+aEogsSa8Kb9m8yVvKyF3sxo8ntacK9rTWTUmi806mWphGErZUeggnERmE7zlkjvd4+4bYVdH53/sXrdqSLpuV3B+Ff7743uHB1oCHoz/GPe9pFszYDyzVKCsMzmh4PAaHNBeFH9oPIzhXd6S7dgZM+M3toJR0g+TdRteDHEYOYe0OeeOgtfOCBGwwvgLJCu1V0vivOlafKNc3ctg3h1PoTtcFo0+IiDtUnRtf73kJAYqoqvFtxjitNPyGprtQvRSlFfywebebzxpQP31D15ZaRT4WYxWvniIp1pe03LYHISFCIpwdK/8ubD1khdocZsMA440Rm4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(38100700002)(6666004)(186003)(83380400001)(31686004)(2616005)(31696002)(4326008)(36756003)(86362001)(8676002)(66556008)(41300700001)(110136005)(66946007)(5660300002)(66476007)(53546011)(478600001)(6506007)(6636002)(6512007)(6486002)(8936002)(26005)(316002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXo0Y1hpbnFLUmZoWi9xb0FnL0YyR0Y2bTQrNDl1dHcrdmJmMitOVDA3M3Nj?=
 =?utf-8?B?QkRzd3JLdVdLcVA1Q0dPS1ltWEpHbzc3VkJqTW51Mi9TOXBTaEhQYU85YVVH?=
 =?utf-8?B?TFRleXNnelVFTFloK3YwZUV0UTVpWU84bWNTbEt5d1ZWMWtqWE1YUW1NZ2Zm?=
 =?utf-8?B?NGJrZEM4MkEwa2dBajIzVmlKMldyQ25jeEZJS0pzeHI3ODVlN3IzUzhvbkJ1?=
 =?utf-8?B?TnFEdm9sOG0va2FFQ1lYK3p1RWo4YjZOcGxyNFhWZCt2M0l3aWNiMy9xSlJp?=
 =?utf-8?B?REdnWDlKQktPY1lrc3FrZlZ2WTVzTjNoTTJQRkZnS21kcXZ6amYzWHdTVzBa?=
 =?utf-8?B?dkhGZ0Myc3IrSXFOb0xGb01vTlBQdjkyYmFRaVkrbFRLQkNvUWFibnRqRFNI?=
 =?utf-8?B?ak9aekFTYkpvQ25TVGF3eDlGTTFSQVJ4MEJPeDlaTk4wYlhaaWxBOFk1a3ph?=
 =?utf-8?B?QkJoUFEraUR2RzNzMGpqRjN2TUxkSkhhOFpkN2VQQWp2MmZGOXA0TUxVZERq?=
 =?utf-8?B?YW9FU09WYkZMSER2UThJWUpKbGY0U2VWQ1NIY05ra0NPb3BmSWx4dGdsUXMy?=
 =?utf-8?B?WGNFZGplRmcvSE1QcVdpKzBlOUR2Y3RhZTNkamNJMTZyaExrQTBKelIvY2JP?=
 =?utf-8?B?dHEvQWJWb1paSU9LOG0yWTJidE9vczErQzdYalpNaXJjZ3ViblgrTHJRWWhz?=
 =?utf-8?B?VTBkc3I1VW5QUWxHb1hEcW5ZSE5XT1o4TGFUamFjKzNYSzJuSUlGRXpmYVhs?=
 =?utf-8?B?SWRYMjh0N3Q3WFVOZzdlMUd6WnFxeTBNQ0QyeTFtRHVJdmdZUXQ5UkdpcUxH?=
 =?utf-8?B?SmhjY1V1N0Q3a2RrWDVrUkdlaGhqQnJjenRKNlp5WHNBZ1Roem5DOGNnSnAr?=
 =?utf-8?B?emV0TEw0WXdXQ25QTVFMNm44Z3lZZ2hmZi9sMkNWTVB4RFFLamRBVG03cjNG?=
 =?utf-8?B?dG42UGttMlc0S2JuVGlFMk5QWUJaMS9OOVEzYjZ0R1IvMGl4QTJ4L2ZZaXk0?=
 =?utf-8?B?ZkF3VnpsUXFQSGc1N0dpbyt2QnE4K0VtMUFucFFsZFFxSmhaRmtVSU8ycXZU?=
 =?utf-8?B?Y0NBamZiVGxvLzdqQlEvakEyNk5uYTc1bUhOa0pNNXh0Q3gwbkhTUzd2S21J?=
 =?utf-8?B?SHI1UE9xdmZkM2dlRXBaTWhnWFBrd1ZuNkMxRzZ2MS9yWkw3YzJic2ZMUlBD?=
 =?utf-8?B?YWFBTEFYem9iTVRmWXZZQWdIMjFON3NraHJndDh4N3AwUjhlTjZ4SmduT3Jl?=
 =?utf-8?B?bXZpVFFSNktxZWg2Yk5rV0pBbE9tbDY5TUkrTVBVMEg1YXJya0RXbU4wSUNV?=
 =?utf-8?B?MitCaTh3MmNEbWJuWFZQRXp0RjdDa3lFNGMyRzFoSWhEQXpDd0orVGlIaDlT?=
 =?utf-8?B?WDJXdWJyWlN6VDQrSlZFK0RlKzdOcGozV2FrNy9MTVRZWHFNTVd2eG1wNGZx?=
 =?utf-8?B?NSt0T1ArQ1ZUUW1YOFJqNmtaZTliZk5KcXZ5VW9tWGF6b2RLNXM1UGo4eDV4?=
 =?utf-8?B?YVcwWHdNSEJaRXM2THlwUy91am1vYnpqVjU3OCs2TWNxM0M2OElpaVZhUWUw?=
 =?utf-8?B?VWFwaXdPa1d1NlUrTkZDa2FXeWNMSUVlNFpiamkwSStFRy9XS3loTGlQMktu?=
 =?utf-8?B?N2M3MkJ5dUl6YVhEUzhVVG82QmxpQVpsVkxJMGozTXlTUk1OdFlNY29BTDF1?=
 =?utf-8?B?cFBCZy9vUGI4T21pQ2Yyenc5OWxhd0RNYzVVZ0FoUzhQOTIwUEFTS1RTcjl1?=
 =?utf-8?B?d1Z4NzJDaC9jMWJCa3BkVXE3eDJNOU1Rc3RiSHk5L2hYd256bHM1MWdOUXFz?=
 =?utf-8?B?cUNhZklwTTQvTGs2ZjZPM2lBS0FIZHY2c3FTMlpydFk1dHczZ010UkhDenlN?=
 =?utf-8?B?MURIYVNRUU5DaHh3aEdDbEVybnhXeEY0RXpSdVgzMGg0b2xMdW96eXhPdHQ4?=
 =?utf-8?B?VXA0U0tlZmlNWmNYOGU1T1FETXlGeTl0cUthV3QwSUswSEhXU3ZMZmx2MzlP?=
 =?utf-8?B?THFSSmc3dXY2dk1ZSGpVZ1c1L2NpUjZCSG5LWTd4Z3NqdW1Zbm9ncGQrQUFw?=
 =?utf-8?B?ajZPM3dETjlzc2ZnMFgzOXRoZzdNejFycGdocGRKdWorVTFKaTBsZWg3VUZP?=
 =?utf-8?Q?FUmL0TszHSHppEp2P/GzJa7Yq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a872a01c-d88f-4ff4-80e8-08da970da146
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 11:30:02.4498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4Lsuicxs+np/UiqEOjm1GU9hsszcMGcnBj+mNuug8uTjvy7oceSFOm049i7zEfw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407
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

Hi Victor,

the advanced tdr mode is not a feature we want to enable in production 
and keep for much longer.

So would that issue happen without this as well? If not it is rather 
questionable if we should look into fixing this in the first place.

Regards,
Christian.

Am 15.09.22 um 12:09 schrieb Zhao, Victor:
> [AMD Official Use Only - General]
>
> Hi Christian,
>
> The test sequence is executing a compute engine hang while running a lot of containers submitting gfx jobs. We have advanced tdr mode and mode2 reset enabled on driver.
> When a compute hang job timeout happens, the 2 jobs on the gfx pending list maybe signaled after drm_sched_stop. So they will not be removed from pending list but have the DMA_FENCE_FLAG_SIGNALED_BIT set.
> At the amdgpu_device_recheck_guilty_jobs step, the first job will be rerun and removed from pending list.
> At the resubmit setp, the second job (with signaled bit) will be resubmitted. Since it still has signaled bit, drm_sched_job_done will be called directly. This decrease the hw_rq_count which allows more jobs emitted but did not clean fence_drv rcu ptr.
> This results in an overflow in the fence_drv. Since we will use num_fences_mask in amdgpu_fence_process, when overflow happens, the signal of some job will be skipped which result in an infinite wait for the fence_drv rcu ptr.
>
> So close irq before sched_stop could avoid signal jobs after drm_sched_stop. And signal job one by one in fence_process instead of using a mask will handle the overflow situation.
>
> Another fix could be skip submitting jobs which already signaled during resubmit stage, which may look cleaner.
>
> Please help give some advice.
>
>
> Thanks,
> Victor
>
>
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Thursday, September 15, 2022 2:32 PM
> To: Zhao, Victor <Victor.Zhao@amd.com>; amd-gfx@lists.freedesktop.org; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Cc: Deng, Emily <Emily.Deng@amd.com>
> Subject: Re: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
>
>
>
> Am 15.09.22 um 06:02 schrieb Zhao, Victor:
>> [AMD Official Use Only - General]
>>
>> Ping.
>>
>> Hi @Koenig, Christian and @Grodzovsky, Andrey,
>>
>> We found some reset related issues during stress test on the sequence. Please help give some comments.
>>
>>
>> Thanks,
>> Victor
>>
>>
>>
>> -----Original Message-----
>> From: Victor Zhao <Victor.Zhao@amd.com>
>> Sent: Wednesday, September 14, 2022 6:10 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deng, Emily <Emily.Deng@amd.com>; Grodzovsky, Andrey
>> <Andrey.Grodzovsky@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>
>> Subject: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
>>
>> [background]
>> For a gpu recovery caused by a hang on one ring (e.g. compute), jobs from another ring (e.g. gfx) may continue signaling during drm_sched_stop stage. The signal bit will not be cleared.
>>
>> At the resubmit stage after recovery, the job with hw fence signaled bit set will call job done directly instead go through fence process.
>> This makes the hw_rq_count decrease but rcu fence pointer not cleared yet.
>>
>> Then overflow happens in the fence driver slots and some jobs may be skipped and leave the rcu pointer not cleared which makes an infinite wait for the slot on the next fence emitted.
>>
>> This infinite wait cause a job timeout on the emitting job. And driver will stuck at the its sched stop step because kthread_park cannot be done.
>>
>> [how]
>> 1. move amdgpu_fence_driver_isr_toggle earlier to close interrupt
>> before drm sched stop 2. handle all fences in fence process to aviod
>> skip when overflow happens
>>
>> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 +++++++++++++---  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  |  6 +-----
>>    2 files changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 943c9e750575..c0cfae52f12b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4610,8 +4610,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>    		amdgpu_virt_fini_data_exchange(adev);
>>    	}
>>    
>> -	amdgpu_fence_driver_isr_toggle(adev, true);
>> -
>>    	/* block all schedulers and reset given job's ring */
>>    	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>    		struct amdgpu_ring *ring = adev->rings[i]; @@ -5214,6 +5212,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>    		      amdgpu_device_ip_need_full_reset(tmp_adev))
>>    			amdgpu_ras_suspend(tmp_adev);
>>    
>> +		amdgpu_fence_driver_isr_toggle(tmp_adev, true);
>> +
>>    		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>    			struct amdgpu_ring *ring = tmp_adev->rings[i];
>>    
>> @@ -5228,8 +5228,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>    		atomic_inc(&tmp_adev->gpu_reset_counter);
>>    	}
>>    
>> -	if (need_emergency_restart)
>> +	if (need_emergency_restart) {
>> +		list_for_each_entry (tmp_adev, device_list_handle, reset_list) {
>> +			amdgpu_fence_driver_isr_toggle(tmp_adev, false);
>> +		}
>>    		goto skip_sched_resume;
>> +	}
>>    
>>    	/*
>>    	 * Must check guilty signal here since after this point all old @@ -5240,6 +5244,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>    	if (job && dma_fence_is_signaled(&job->hw_fence)) {
>>    		job_signaled = true;
>>    		dev_info(adev->dev, "Guilty job already signaled, skipping HW
>> reset");
>> +		list_for_each_entry (tmp_adev, device_list_handle, reset_list) {
>> +			amdgpu_fence_driver_isr_toggle(tmp_adev, false);
>> +		}
>>    		goto skip_hw_reset;
>>    	}
>>    
>> @@ -5276,6 +5283,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>    		if (r && r == -EAGAIN) {
>>    			set_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags);
>>    			adev->asic_reset_res = 0;
>> +			amdgpu_fence_driver_isr_toggle(adev, true);
>>    			goto retry;
>>    		}
>>    	}
>> @@ -5711,6 +5719,8 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>>    	set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
>>    	set_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
>>    
>> +	amdgpu_fence_driver_isr_toggle(adev, true);
>> +
>>    	adev->no_hw_access = true;
>>    	r = amdgpu_device_pre_asic_reset(adev, &reset_context);
>>    	adev->no_hw_access = false;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index 8adeb7469f1e..65a877e1a7fc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -287,15 +287,11 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
>>    	if (unlikely(seq == last_seq))
>>    		return false;
>>    
>> -	last_seq &= drv->num_fences_mask;
>> -	seq &= drv->num_fences_mask;
>> -
>>    	do {
>>    		struct dma_fence *fence, **ptr;
>>    
>>    		++last_seq;
>> -		last_seq &= drv->num_fences_mask;
>> -		ptr = &drv->fences[last_seq];
>> +		ptr = &drv->fences[last_seq & drv->num_fences_mask];
>>    
>>    		/* There is always exactly one thread signaling this fence slot */
>>    		fence = rcu_dereference_protected(*ptr, 1);
> Those changes here doesn't seem to make sense. Please explain further why that is necessary.
>
> Christian.
>
>> --
>> 2.25.1

