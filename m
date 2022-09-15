Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A211ECAAD3
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 08:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12AF710EAAF;
	Thu, 15 Sep 2022 08:00:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B42110EAAF
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 08:00:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azVk7SqKqjVt49qNdOcw1WCvFf02QJtZ242CCPuA91lsu4eU9IFlVJLL61ozLYjHE/K36sUtHQSUEZQjakU3lRWTFOhb5CmvJGZ7QuAck8v8Gj99eNvE/RS933c59Qeldzakprt/w/h4cphb+Q8nOr86HVvLeI90VLIS5qRbBEh4cUkInYgMkmiZ8J96rd2ZcBapThrzCvn5TPs11fPuGz5qp9yHCYVmHRcFBTaU+vWBSdeIwgpg3CXwt4py8oiMkYPbmnV9H6cnLZTQItYGU9VaIFQ1bewg9McCtO6nLHhSA6JAusI5fJ6ypwieMOb4j3HBf80TLJfrVp1bC3EGnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIV1Ztj5cWRKh5M9mi4s0ZF8nzZcJ2LZJh5p0ZBpjd4=;
 b=PV9hM1t3lDufj8a9HeCBbvM1OvccqTbvNUDI02vB7gdcHGA0NQZQe2vwyO9ZPImAchtYSnsFjW3lz+ahB3CHUfHS00CS3hpM/zzhZD44tcy2sIf99vYYD2l3kNBba0XHeI+uIIs3wFHBb6dHWvE6oWBPNRLOQOS2aL4VXel5xYXHUnFsAn2ByWVIbl5rVcH/4Cq8/hQtxof+nXqelTGp9S8Y1aZX6WN/B9TRFNnovT8+aS8P6OLgrUblbHli1xbA6RCtWLRb3zG3gkDgWuGZppOxy9SXuC0MoMeUgecLpPYqDfKd6/5n+lmN73mXniiYuEhQgO3jChAbIcA2OHjIHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIV1Ztj5cWRKh5M9mi4s0ZF8nzZcJ2LZJh5p0ZBpjd4=;
 b=CNPybNc9nSTo7ycagNsZftl39sGJ5SPlk3sLBJBKqOSxjVUqGYQczVAyTKUmtTGY2H8KTcNktRJPiUZVVCLg9//TmWN9aFm6evCSMaYvP70A2Jq+Mw5BEVQJWreVrAjH2BLhImd1QG2aw+T0BKXN3PEp/SZxGx3r4+4NyMCX414=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 07:59:58 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3054:3089:efbb:78c0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3054:3089:efbb:78c0%6]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 07:59:56 +0000
Message-ID: <2d7f38a6-c276-39d4-827e-d2390c281c39@amd.com>
Date: Thu, 15 Sep 2022 13:29:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] drm/amdgpu: move enable irq later to avoid race with
 ih resume
Content-Language: en-US
To: "Zhao, Victor" <Victor.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220914101025.366954-1-Victor.Zhao@amd.com>
 <20220914101025.366954-2-Victor.Zhao@amd.com>
 <6d96d72b-cde6-ad13-ec3a-ef26cd0f068f@amd.com>
 <DM6PR12MB4340C1B8A689A0AA8B5DB27DFA499@DM6PR12MB4340.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB4340C1B8A689A0AA8B5DB27DFA499@DM6PR12MB4340.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::21) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: 63fb48fb-2ef8-4c93-a90a-08da96f0470a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 07rSBIAcgrjFp6sdbw68uB1geAF0bS3HrWlyH6kSARVMnnpFUrJSVZ4nFe68dtMpDMqQavMLa1GnJ2q0lm89VnBhmy37BUFfdVIP6qyUYkEG2cr4ovSlObnoQHR8Y68MCspSd1D7Iu9B/rSPTmVPh7BostJ8ncomLO/ZrIwaFplFc5VdiE/IcnNdUuaefrLpkyePh+/6lsRzN75WuVuGDkn07mEOwS4fGGXrTFxqHGP98Po2P8jpb4Fjm4zxx4tp/oUaOzyfye1AW8n3jaxGqi3KXVYtNDHDMkf3S9LDZDN1PX41iK+Eug28QAWRw/ZuEro4OeyUg/qxItifkFxBdPTSHAwVYE4A1B2KI8QW0EGfHMqRtwf1z7lwTrQmyDpqcoNp3TtzcvkAV+E+UUXBe7FNX/Z6tV7jIuLj98rAEK+jOOLggvUL5XtGJGGpGrBMf3EzTvJb6mJIHqh7jVV9ui5bc6rmsN23j8UL/KM2mb8VjZs+pl5gRsMq7Wn/dmoqHhmrqJm/AfbZeMwbLU1Ijcq7l1LJx0WhDmXzgdaRuJyRQAiZAvIvok+RbFsHNwrNu2LCaPD0RXwDUJBq8c+mvy6NSqCBErfzv7yUKb+r/cyLUdWeWD0AhANx7O+5xiMIfTuxn0/FvUrVbZP+6rwL6eAFi9PXoKV7L0ssdsdeGO/EJQ/oWwfFxfjEu4TupgyjMjJsjjs4D9YHCxDoRtUIZeJ/E5WyQHXSp1HQwPYLUuAWVyFQ0k7sX3QQIkw4tQITruau+JEwpcd79dfd9/BCTGx0Q4lw1E8pOAbGMnf6qQU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199015)(26005)(110136005)(4326008)(316002)(6486002)(86362001)(54906003)(31686004)(5660300002)(66556008)(478600001)(6666004)(8676002)(6512007)(53546011)(38100700002)(6506007)(36756003)(2616005)(66476007)(186003)(8936002)(66946007)(83380400001)(41300700001)(31696002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmNEdGJqRlZ1Zk1mUVlTZWMyako0WWIwTGhBWnBDVFA5N3A2TmE1UlU4TTdP?=
 =?utf-8?B?ZDJJNnBMZFlMbjJYdjFjcDFaU3VRQlNJMlZKMjNySzlBb2cyZXB5UmpLYWtz?=
 =?utf-8?B?Q09ITGhZenYydlE1Z3VoVEpsQlJtSTc4SzVxdTJwa1hEdnc3clJaWXd6QUgx?=
 =?utf-8?B?TEsyLzQ2RVRhUzB2SWx6RG1IQ1lkZXJOZmQwaEY1enlIeHY2eFFobVRlZ0pO?=
 =?utf-8?B?ZFg2L25Ha2ZpZmd3QlJSOFJ3M3ljdjBYWGpRbTU1OS9QU1doYlpsV2tFMDNy?=
 =?utf-8?B?ZGRLeXc5NXRHRW8xK3dyYk45M3h6YzJwQTdETUZRV1BMMFdUdnlqL1RXdFJR?=
 =?utf-8?B?aHF3TkZ2WGRzdzBLSHRsKzArakp2K00yTEFTWVBtT1Q1SGMya1VKcWNzVk0y?=
 =?utf-8?B?Mk92b1NxcUJjUno0N1RDNDRGSDdubkg3V1NpSGt5OGJpVFpzUGt5eHQxZmlK?=
 =?utf-8?B?MzRoTzE5T1Z3VnBSZXhWTWhCSjJLRXRDTG82dEpPOHlENjBrNnAvSnowaWtF?=
 =?utf-8?B?K01qU3VTRDl6OTVMWmtiUFpWZW4vQ2NLb0NGdmI4NW1SemhRckdmRTllMjdF?=
 =?utf-8?B?dlZXUXNrenFUSXNRZGh5SDQ3cHZFTERyc2ttVVB3eEhURG56WFZmM2lydlFk?=
 =?utf-8?B?UGNGWDNlUjZmSTFERllZSis3OURuYTcyUWlOdlFRS1RwNURkVExSS0ZUNWxw?=
 =?utf-8?B?dGUvbnZTN1JXOFlPSGNobWZCK1kvcVhSZFljSkZXbE1sZzREZGdoRWtvTUNx?=
 =?utf-8?B?ZGFXVVBYRVZycWFIdjNYbjJ2ZjIrSnFFNUVRckJ1ZTZSK3l5TjJtK25TOWRx?=
 =?utf-8?B?bDE1RnM4bjdVUzRJRFFEZ1JhVEd1SUxybm1jeGpoVzJSRUtTQmJlSENud1NK?=
 =?utf-8?B?NklGRmFvbSt5d0o4MHJRT2w4UEI3Y1dlUVUwSmdYMkpic0s4bUxvNDErOHJm?=
 =?utf-8?B?YWJyYTUvMFk1azBJOGF5aHFma3NFcFhCTmxYY2ovR3NsM0o3bU0wa2JzaUY1?=
 =?utf-8?B?R043SWdqZ3E0eU95QUZPeU9nRXJCaWFsVnlMV09JY0xLMFNxNkxuNkRkSUxC?=
 =?utf-8?B?ZUVrcTFkVXk4RHNra1d0eG9QNUJ2QVExL0Y3eGFGOTRXQXhrYmpaNXM0WGtl?=
 =?utf-8?B?ZTZ2UE9QT3JsMVBGRXhwbkJzZmo1VnlmYTdZNExuVWlRSlo0WGNpZFZKcGY2?=
 =?utf-8?B?Q2RkcnVaQ0JITllwNTZTVFJHTlN2QzRnVnMrRnpuWkhKT0swaDB2dFhWekw0?=
 =?utf-8?B?b2U4bXdkSjNJZFk3SzFZOHczWTFiWHRGZUdKdk9NbVJCTnRQRWhjQXRLSXc4?=
 =?utf-8?B?eXBDSXA4bmhhRW05dms2Y1dwTXJzb2oyQVlCVThuMFIzKzBzRTh2RDZkNG9H?=
 =?utf-8?B?clZtcWZKUXM3VTdlSk5HT1ZLZk5EN1g3MkJPRjUwbFBNZ0NUZUM3WHI2aWs0?=
 =?utf-8?B?TEZyQVQ1QU9VdWdtaENZZ0hyVk04bExjU0c1NU5PS3NZSm1IYittTDhUeEJU?=
 =?utf-8?B?cHNYZThySW5TRjk2NkNSU1BTTUtnbUEzK3V2NStOZCt3dXdWU2ZHWW5tdmRX?=
 =?utf-8?B?RFBlUFRLK1FoUG5FNWx4NVoxSVcvWmxDb1FsNDU1MDR1c1BlQmlqMFJDaGJo?=
 =?utf-8?B?bXJmU0dhdjRXMzJ1enVkNmZ5ZkpXUXQ3RkY3TE82RDIvUkpTMzhpZGZEcUNr?=
 =?utf-8?B?NzNvTDYrZ2tjdForQlZ3bWVqLzNxd2xlSDVqMXlBN3JzQ2dON3h6R2IxaSsr?=
 =?utf-8?B?ejFDUk9HeC91bFRhbzgvTkNCaXJPV0pZS2MyRXJTdGhyMTRsWjd4WnFkR0l2?=
 =?utf-8?B?djN0SExGa2JMZWtWYVB5UTUvN2lNQnFoTEZnOEZhWkRXWjVGQ3NjbzZSMW1k?=
 =?utf-8?B?Z05XSUhlTlZSeXpjSkJ0SHBPdEZOejM0bElSemZUSGxjczI4bFpFdUJsQzBD?=
 =?utf-8?B?N0pVcEpBTkFrbDJ4OWFaRnNteFRhcTNHSHVNZjdDRzF3Uzh6ZVFsSXNsMWFo?=
 =?utf-8?B?WW43THlTbWtiNEkySU53aXNNVnVJWHpxQlpGTVlDdHQzR3F3cnpVQ1NJNGZR?=
 =?utf-8?B?WXhQV3JTZlhVRjYzNDc1VXFxZlc4Mkc3YzMzcnhaYzU5dHpFb0oyMDBzVFVW?=
 =?utf-8?Q?hyQObfEdzAnw1aOGCczvjjnsG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63fb48fb-2ef8-4c93-a90a-08da96f0470a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 07:59:55.9075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qh/A18SsOA4pDEVFENJgumS+0ggsWuNBsDq6E+gtcV1Z7JAkiJFCRMUWiwjFXzN9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Grodzovsky,
 Andrey" <Andrey.Grodzovsky@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/15/2022 12:08 PM, Zhao, Victor wrote:
> [AMD Official Use Only - General]
> 
> Hi Lijo,
> 
> IH resume was added to resolve an issue found during mode2 bring up on sienna cichlid:
> - close down mode2 reset and do a mode1 reset first
> - open mode2 reset and do a mode2 reset. Mode2 reset was found fail in this case.
> 
> Resume IH helps in this case
> 

Sorry, what do you mean by 'close down' mode2 /'open mode2 reset'? Do 
you mean if mode-1 reset is done first, a subsequent mode-2 reset 
doesn't work without IH resume?

Thanks,
Lijo

> 
> Thanks,
> Victor
> 
> 
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, September 15, 2022 1:58 PM
> To: Zhao, Victor <Victor.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deng, Emily <Emily.Deng@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Subject: Re: [PATCH 2/2] drm/amdgpu: move enable irq later to avoid race with ih resume
> 
> 
> 
> On 9/14/2022 3:40 PM, Victor Zhao wrote:
>> [background]
>> On current sienna cichlid mode2 reset, on the slow job hang cases,
>> since page table context was reverted to completely stop gpu, it will
>> generate page fault interrupt.
>>
>> Since the irq are open during recovery stage, during ih resume step,
>> if this interrupt was in processing, which increased ih ring rptr, and
>> ih resume meanwhile will set rptr and wptr to 0. This may cause
> 
> AFAIK, only GFX/SDMA are affected by mode-2. IH is not suspended before mode-2. Why do you resume IH after mode-2 when it is not suspended? Is it a special case for virtualization?
> 
> Thanks,
> Lijo
> 
>> rptr greater than wptr. Such case was not handled in ih process, and
>> it will cause rptr continue increasing util reaches the max.
>> Such case will make fence fallback situation happen.
>>
>> [how]
>> Move the enable of irq after ih resumed and before ib test.
>> Adjusting the position of enable irq on other reset paths accordingly.
>>
>> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 8 ++++----
>>    drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 1 +
>>    2 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index c0cfae52f12b..0b658225e9ef 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4625,8 +4625,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>    		amdgpu_fence_driver_force_completion(ring);
>>    	}
>>    
>> -	amdgpu_fence_driver_isr_toggle(adev, false);
>> -
>>    	if (job && job->vm)
>>    		drm_sched_increase_karma(&job->base);
>>    
>> @@ -4758,6 +4756,10 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>    		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
>>    	skip_hw_reset = test_bit(AMDGPU_SKIP_HW_RESET,
>> &reset_context->flags);
>>    
>> +	list_for_each_entry (tmp_adev, device_list_handle, reset_list) {
>> +		amdgpu_fence_driver_isr_toggle(tmp_adev, false);
>> +	}
>> +
>>    	/*
>>    	 * ASIC reset has to be done on all XGMI hive nodes ASAP
>>    	 * to allow proper links negotiation in FW (within 1 sec) @@
>> -5031,8 +5033,6 @@ static void amdgpu_device_recheck_guilty_jobs(
>>    			/* Clear this failed job from fence array */
>>    			amdgpu_fence_driver_clear_job_fences(ring);
>>    
>> -			amdgpu_fence_driver_isr_toggle(adev, false);
>> -
>>    			/* Since the job won't signal and we go for
>>    			 * another resubmit drop this parent pointer
>>    			 */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>> b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>> index 7aa570c1ce4a..953036482d1f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>> @@ -240,6 +240,7 @@ sienna_cichlid_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
>>    	* Add this ASIC as tracked as reset was already
>>    	* complete successfully.
>>    	*/
>> +	amdgpu_fence_driver_isr_toggle(tmp_adev, false);
>>    	amdgpu_register_gpu_instance(tmp_adev);
>>    
>>    	/* Resume RAS */
>>
