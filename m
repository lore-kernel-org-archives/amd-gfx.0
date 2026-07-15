Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0B7C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 14:52:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA36510E12C;
	Wed, 15 Jul 2026 14:52:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rbdIpuD3";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61C6F10E12C
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 14:52:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ev+jglFF45+TMcGaijdZ2F9BUg5vWipQ0fnzmgHmEFUXxiqz7s8wEafN1izp2hlUc3woIEQGuLbCZrgTC6CtB6uE1cMvdCNyrWfo3ma2XFm/urrhf7xXmL7B/G65ZSHxvTwFlM+jCAWX3xqBv9I1bYhGXfTKXkt1T7R/9e3wvhZ7V7d7CicnqHMWAQaZIhO2nuR3blottp3kylqlnfWbuaA12za3RsZhfD2Mk/Go/gYB29BjrI29a+cgSCTmvhKGBk3zFDKbJo7wUMp/Y8YB97b2YrzdsspAL96N5PS3pOWGAUzfnFLZQL0mdj4gINHwr55rrr9aR62TFFIQDJDYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbZok3dc7jAG9mc4RplEOU6YG+9SvOx2ARHR+McPxcs=;
 b=FEdxhN3PBdQre60Vbg26wJY8BYY+Y3gmMVMnB24KnNFe3Kg16N6EkNe/EQVumJ+RZ2edaBbugaUaKmGBVI2LkwZAoWu0pP7xvzPibOn8AsOO8Ajg1frUhkrNtS7AZ0i7lOQrn0EMISf7Ef08+oUUEyql3AioViSxVqzz1JJ2zBendzzeMCgzAOSJfczgigU0goRnCpNwQGEmy2Dp0gIehuCHz/65sKSayMiCBKBDo9XwnF4fvLwro6Gpaq9LLMl5u9ZOJCplrNnWDa1xDZjOjUx2PPBnVwIgXFkhc6MuOl9A2dRwLoPFP9384njc8fG77XOG5vo0PFCYzcgtC6jVbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbZok3dc7jAG9mc4RplEOU6YG+9SvOx2ARHR+McPxcs=;
 b=rbdIpuD3I1xTcQKqixzQ/Uqbcfw7hRl/yiICgk24HIry/QcK0D2dmAJdRkmZt4E2KXGbKJxL5PAbu5yMtdVFW6Hf8nWVhEE/iJul31nBHtIF6c8KQPw+zM2Abs1PK8OXLyOrhS+vQ9Mq5WymUSzaOKlzKuv1XXCvGL/Los0WPPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BN7PPFABD533732.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6df) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Wed, 15 Jul
 2026 14:52:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 14:52:16 +0000
Message-ID: <29d7ca82-62b2-43b9-a306-c65fb5fc3dd6@amd.com>
Date: Wed, 15 Jul 2026 16:52:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] drm/amdgpu: add an buffer funcs callback for TLB
 invalidation
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260713182732.630947-1-alexander.deucher@amd.com>
 <20260713182732.630947-5-alexander.deucher@amd.com>
 <e8926046-2e03-4224-98ba-8601de0421db@amd.com>
 <CADnq5_OGJBx5xkSDfU4cyt0bjZRot18F-PE29RJFSkC=YPz6oQ@mail.gmail.com>
 <1e4cead4-73b7-461f-b4d4-a66e293d0d96@amd.com>
 <CADnq5_OnTfvMf+Bx3V36p0W_M4ARksHZ+emGSNb07Us9xPr2uw@mail.gmail.com>
 <c9e1526e-c2b6-465c-9f82-24299d8a0e23@amd.com>
 <CADnq5_P8dPWAJCd_=u13KKDPmJQecC9MqHJ6K9g4+4iQxYvi_Q@mail.gmail.com>
 <70f3e844-002a-46b2-9341-47428abfd829@amd.com>
 <CADnq5_OzP69GXe4TgotojQd7U8DUbyY-QK_HP6JR-h8+0PoTPA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_OzP69GXe4TgotojQd7U8DUbyY-QK_HP6JR-h8+0PoTPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:208:335::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BN7PPFABD533732:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cf4bdbf-b72b-46b4-b930-08dee280a961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|4143699003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: GVFBIXQrkg5og/gD8dmljePUBxi4/He7LE2cihysMEbThci3C7lw12uTkojOtQ8UhHn6yk9AGZkkXw3yHrtkPAnFrqiKYY8gNsU9ZenBpiIs5tkP3eSiGeQXoipY8z/oxVTyS5z/j2nad+mdiWtNUW/5vOh4PNt3Vo2jafp3WakTYz27dYm5XuvIOS4EcuRrV2kOs6jJ5d5pXnsEqn7sQX2H5SVo6mLUbwW3IrmTqeIOvQ9EFpgbFpKjI7zxKBCCXFYcT2Vx4TRSWMisDkmho1wyfXULmVDaE/hqsv2S1K0RJ5/qlhrhwENrm21zLZctHME3RFi9ryaXSReXIUCbQyq4SbyBkJaUwfkACAFuKT+pLQelf835oAZ9EZOZFEepk4qAXRp/UcTL480Zyd8oD8vvADw9aGeqbOqHfcLRREVWSK764+vcdKpbKHCzPLPE8qo9F1L4mrbTtlhLQxIck7o2OnNk1qS0vCoE9h5/Vha4YcKLvWkylCDdF2oDexfCMEhvXDz58gdNr41pKx3ZG4T78gpMxifHfm29lnJK0Dcg9U6nTAcxAKAl5Ir+T81WRhbAq2HeAK1UDl5iJ1trDy6QPwBrJgMGD+yAmaFDUMYonSH4opObLLblaahmtY4RvfMLKNwkllPE4MsLh00zMLP4kjX1fRjNXg7s/ZpoErI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0gvU2UzcTdNdEREZUdiZG5oOFc3dGlYSXc2bm5hMGFZUUI5VXNDcWZQMHlH?=
 =?utf-8?B?UCtQQWRDaFIwT2l0aG5veXllVG0rZmw5RmJGTlhmWmlkSjlENkcwQkpvZzdm?=
 =?utf-8?B?bjFocnlSczk3MXJmblQyYkVZTXBhajN3L2IwOGZVNW5sT245Zy9NZEdReGVn?=
 =?utf-8?B?a0liUnlqQkFRa05la0ZiTEx3SHNqb0Vjam91b0F4WTcraVoxb0hic1dJT0l0?=
 =?utf-8?B?dDg1TndWNWhnNEJpZm0wSzJMNnNkcnhuaUwveHQxZnNGZy9kWXdwcXB3ZkpP?=
 =?utf-8?B?SDhyS2FJaEdBSFJpLzZ0UFB4WUwxcW8rQk0xWmxub0hpcUhvVVZBV0psZ0lW?=
 =?utf-8?B?eENQSlBDeG80QitpSmZ3S3NOcUhOQ29BQ3lHODB6UDNZTlR3dDQxUWcxR01M?=
 =?utf-8?B?RjZjNzd3Z01iNU9tTllsa3VDWFJidThpZzlwM1M5SFIxNjlBV0szbVQvemww?=
 =?utf-8?B?RTRkRmZqOTVWT3M0OGFLeTJWNFNWV2VXNFFpbTVrUG56Q0xCRndvQVVQWGhT?=
 =?utf-8?B?YUVSWUl4REQ2eG5hSDB6TENGSERHMzlTMHZyQlJLc3BYY0krN0E2b1duVTJD?=
 =?utf-8?B?VEpyZjZuSWgydzVJNXZIRmFKV2tMa0RsNTUwdmFBNTBWaDc4U0krSU5ndGN6?=
 =?utf-8?B?TndTaGMxTTBUNjlGK0R4YXhaWTFVekhqMGtwajBlbkFuZDJWKzVzOVFiWG16?=
 =?utf-8?B?Q2FGMFdvL2VienFjUkhPUm1iSlFRa1FNNi84NDl6M05sWmFmTG9TTS85a2Nr?=
 =?utf-8?B?L3R5U1l2K2YvM0lkenVTM01rZS8wWDRxbW5JQk5TUXY2dU5vTjA3NlpoRndz?=
 =?utf-8?B?MTZZVFdjU05FUlZlTlJRM2JIVXRXNmNYSGxUY0pOMEs2WnZXNFpRbTFCQUd5?=
 =?utf-8?B?RWJIM0M1TDJPemlEaDJqcldIa2hhV0d4eVVWNGNER28xZGhveExDZHRJWEYr?=
 =?utf-8?B?SDQ5N2pCZzAxYWg2cVhHNjZoQVVzVzA1MkVCdUlpWmxEb0I3NzZLOW9JRnlE?=
 =?utf-8?B?aC9pUVh4UEs2MmQ4QUV5SWQ0MmdtdUU3aUJTelEyL0g3dzJoeG1mQTF4OCtp?=
 =?utf-8?B?YkFaM1oxY1pGaGQyVnl5WHR5eU1pNHBqWjBKNk5LZFB1a09zbUJQK29PK1ZQ?=
 =?utf-8?B?dmtsbzk1Q2d2YjZCck5xcW5qZlVucnowVTlzVExnUDVSd0pSWmJ5VGpsaG9x?=
 =?utf-8?B?dnBveERFUzdCa0dQMzc2WFFKbEhnVzUwVFB3Y0tubWI4QW51TEZTTFlidzRP?=
 =?utf-8?B?cGM0a0N0bUNIR0lpUzgyWmJnRnd2Wml2NVdWT1oweld1c2traXB2SlF0cHpQ?=
 =?utf-8?B?OS9zcXhtRHFlZ3ozUVQvN2svcHhoWjhjOWxtckRXQVd3UGlSekY0UW85WmU4?=
 =?utf-8?B?cFBJRXhnWlk1MFJVcVREQm9SajZzaFVQS1Mxc1NvTjdXSWZRenhJODBzWHJr?=
 =?utf-8?B?R2sxd2E4YmZiZ1BQaWtCWHFOV09IZVdkcXlSV0dvVU5weUJaMXRiUGhYQXdL?=
 =?utf-8?B?ZHdnN2swZmw5cjk2VGoreEtJTS9YOVJXc0ViSkl5SGJqYjdRU2oxWHJlbUdo?=
 =?utf-8?B?TW5jMHRiNEFXYjV1S3B0VS8vMlN4aStSc09vVGZGNjJ5N3JQcENCRldHWGtV?=
 =?utf-8?B?V0dVV2JIUUlMbVZXYTNIbXJteHBrY0gyRXlCR2xBbnBJSmVPK3pJVGs0eUd3?=
 =?utf-8?B?TFBYblpuMzEzSE52b2xxQy9PNkNXY2hEUDZDWko4eS9kRzBnZ09LSm5NaEd5?=
 =?utf-8?B?VHJhZXAwb2M2d1VTWXdtdkFIdTlPeWZySFhSSHo2d0h4THNyNkRZMmFLM0k1?=
 =?utf-8?B?d21TSnM1RXZlYk9zS3RGZGJ2dUhQeEo1YmRlVWhKaWdDSzZtTXBWTDdDajk5?=
 =?utf-8?B?VEZZRVp6Y2ZUb1NEYlF3OUphU2dtbTAxamgwOWxQb1dqL2cxWEU3THA5bkJC?=
 =?utf-8?B?QndpSE54bExBM1dmZXFTUGg3NUZYUnhUMmdoWVJvMXcyTXpiY3RBZEVscFJ4?=
 =?utf-8?B?UFpyaHNOTXN0SEIzUDUvck5NZXF6NEF6SU9kRWN5OXVTVDhhQ0t5RmhFR1RN?=
 =?utf-8?B?a0FuNXo4NXRtdDBsdzV1UjNVT1ZqR1I4OUtVQzdYVk9ZakFEWGpDcld1RTNR?=
 =?utf-8?B?ZEhRaUJkYUZjZjl6UXR1cmhnNm9mUVo0bUd4Q01VVlZvS3BBQUpXWkVQUnFi?=
 =?utf-8?B?cUVMWklnVDJ6bmR5K2lEYmE2bDBHN1VaK2dQaFlkWWlYRW9KcHhkblNHc3dP?=
 =?utf-8?B?MjBWay9iOVRydGZoNnNoYWhJVUg5cUhaMVNvSndzaERPOWxIN0JEWitZd3Q2?=
 =?utf-8?Q?ZNYMQu9BMxaE28Mtl9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf4bdbf-b72b-46b4-b930-08dee280a961
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 14:52:16.0087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PtnZEF02fkR4H1Gs50qSBiakhLrSD8Vrwk5BejMppFWWeyM+UY/IhEwmLHzENmgt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFABD533732
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/15/26 15:44, Alex Deucher wrote:
> On Wed, Jul 15, 2026 at 5:00 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 7/14/26 17:19, Alex Deucher wrote:
>>>> Why are we using the MES for per VMID invalidation?
>>>
>>> gfxoff.  We can't access the registers directly unless we disallow gfxoff.
>>
>> Well there is a remark that VM_INVALIDATE_ENG*_ACK is always save to read, even when gfxoff is active.
>>
>> And we explicitly acquire the semaphore to avoid that GFXOFF kicks in.
> 
> I'm pretty sure the semaphore just keeps it active if it's already
> active, but the registers are in the gfx tile so they are gfxoff
> controlled.  I think the semaphore is just meant to be used as a lock
> to keep gfxoff from kicking in in the middle of an invalidation.

What exactly is the failure you are seeing?

What could potentially happen is that GFXOFF suspended the block and we are not able to acquire the semaphore, but in that care we could also simply ignore the invalidation request.

>>
>> I also don't see how we use the MES here?
>>
>> What we do is to use the KIQ on gfx9, but that is actually only as a workaround for some SRIOV problems.
>>
> 
> We do it for everything gfx9 and newer.  For example gmc_v11_0_flush_gpu_tlb():
> 
>         /* This is necessary for SRIOV as well as for GFXOFF to
> function
>          * properly under bare metal
>          */
>         if ((adev->gfx.kiq[0].ring.sched.ready ||
> adev->mes.ring[0].sched.ready) &&
>             (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
>         amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
>                                                  1 << vmid, GET_INST(GC, 0));
>                 return;
>         }
> 
> The only time we use the MMIO path is if KIQ or MES is not ready yet.
> The goal of this patch set was to switch to using SDMA rather than MES
> and to clean up the gmc code since most of the logic is the same for
> gfx9 and above.

We should probably stop doing this. As far as I can see that should be completely unnecessary.

If we really want to move this to the SDMA we should do it a level higher in amdgpu_gmc_flush_gpu_tlb().

Regards,
Christian.

> 
> Alex
> 
> 
>> Christian.
>>
>>>
>>> Alex

