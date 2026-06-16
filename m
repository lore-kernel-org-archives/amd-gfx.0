Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45F3CD98DA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 12:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4196C10EB95;
	Tue, 16 Jun 2026 12:52:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B9H60W2O";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010040.outbound.protection.outlook.com [52.101.46.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 735C110EB95
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 12:52:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SznsIM0UzGbwPv92SwhOgP0GuGl87URf1zbN93eJfdQCgopreySCpeETvghlXcRPn+8WZFXmuplGTlUKWIpE7q4NlzFxg/q6UhqQ5WmrIOH+qbyHn4zA9B8tjtMJwH3TnRqE+6adAbepLbw5/RQHk3NaJ7kgefQXEIpEWzp+ebalcu/bkBqe6U/ifCgMxzZhMfdBy1JYoEGj6hAhgiaYIADdyYMySXF42T1nOZZBJWBAd3O/3/K0WGybd5i6SA2HvpNMuyNd9YZftMH3S4GD3V0e0YrRBys+xgtUXzv5j6OEQkc4lmBwDKHz2VlnanqNYma2ZB2LEB+Ma6BVsmY/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZmVFYUxPf3TqRrPwvI/R8wCNbdEBEm7irmBtMvbICY=;
 b=dq++4S1w84L2fOf/zYI6tSfPXTJkcDOnnd4185EaQ9N4EPeqeC7s7ZO4WPk/BTBWctR300XtXq8MRmGlwN4+HF1HSoJbMUCNMRtRW1S3VZGh8doSOybbZbMS/g4YtTlsAr/9Kffzsoe2I3G8ycw6XwHi6GzrzH2PrhQMi5x+7iViPE8bzk59EKr91FVTcHqmqivX/YiAQbMrvdTJBqCOBsFTh6hb2er1CLCn8lKbDhW1m/lxWrXzazmTwSaks+YMT5pMMktAUVv6XgKOfBJXIJ9ABeJncQQsrph4r6WiwCnZXU5G6JpaqnSz0U9d3dcqg4FxaxhqBLjXnEz8rNBmnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZmVFYUxPf3TqRrPwvI/R8wCNbdEBEm7irmBtMvbICY=;
 b=B9H60W2O7lUlxNPAAkaJ4zUsTV4XD/c4oM4vp/ALsPIco9ADOfipn6p9VOEUrKR/KGdUDjLorVaUYUZaKVpyOyex3RKTRO5sQLxq3jmMeF6b9EDJvT4nXolxjmm9bjNf5e4ecOLE6wXoRUC3yLttukpHJVosy9tqzvfQsWIQr6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB9520.namprd12.prod.outlook.com (2603:10b6:610:280::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:52:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 16 Jun 2026
 12:52:36 +0000
Message-ID: <e7200156-6942-465f-aa9e-ea41921c5a51@amd.com>
Date: Tue, 16 Jun 2026 14:52:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] amdgpu/ih: Don't perturb HW registers when accessing
 soft IH ring
To: Tvrtko Ursulin <tursulin@ursulin.net>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 amir.shetaia@amd.com
References: <20260513170849.27061-1-timur.kristof@gmail.com>
 <20260513170849.27061-3-timur.kristof@gmail.com>
 <6f5c367e-b234-491b-81e2-d928cd54050d@ursulin.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <6f5c367e-b234-491b-81e2-d928cd54050d@ursulin.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB9520:EE_
X-MS-Office365-Filtering-Correlation-Id: 59abc5a6-652e-4dcd-f0fe-08decba623ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 324dvKDluB7XHR4gppLxWl9tsv9BXD2oJBB6jodUeSe+okf3PLpBrKJrteD4eYYCWWNgZXkQVzR0rz397yMCZETCtaj0wLlBVnDhJhRpF7bY9CZ9OlSthSfWoNiJEJwyffLv65jOZtjGeT+WIhsfWgLAWvBcCtjFh2vKElJDjL3hMiwBX3qXfp0LvSTV5fD3shyBVAODHHPM2AkxS2bGtIApWVEvApvD1qpLjCPdl/jv+FCfKV6t1XonYxz8hgdUWOO3UMpzdhB5VrSpQH4d5EUYMlLVuywTZBokUHIIB2VAZy2A3sP8Pyne6eSSc/OFhW7FW1v2j8pkFUiI+mjvDK5YC9kACGjTxeRBtOB4skAexKgSI3GD6BSfbuBuv4PAbR0fw7S1olab5KLqaptxipw20VGICge9A6uwGEcnG27EeI69xvWNOKuzJzt9e3FLUJS466Co/EjZJgwqQwPuTO+r9rPlGanXjk9Hf1Z0/Wr2SmleggynL10jO8277A5G8HZefEF3FLNVMkaH86O7Uhq7IC22qM1Bvavr+EEswq+GaLIGsPoKO6j3rDdllR8vJRp9gFGFH6c/pTxKJuVjmMOdWqOe2Fhp36bi7sW5xHQRNZ7W3abtJl0he4q5g2UkbCjJwNEfoeqMI03pXx9EnkigqxlK3yNS1e6lxl1fMJ99fu0NNw2F4Gy8nEb8rsSB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnlYbGtzazhncTFodE1yZUxpM1p5NmIyRG81NEVvQ1NlaXZmZHowZ0pCRGRO?=
 =?utf-8?B?VDZPZmVNaWp3VWdQUWxKT2JHS2FtVlplQUVPdnlZRTVtdmJqb0xDejVaVkZD?=
 =?utf-8?B?WExKVVdKWjhicjlqL3BBZTBvblNYcitQNGIwclEvNjEyWS93clJ4eFRjdzlV?=
 =?utf-8?B?bE0wc3E2V0lnekRUb1FkRVR6MjBzM1RVbkE4OVcwL2h6QnJGZTR3aUNhRENo?=
 =?utf-8?B?TG55N2ZtVk15YjhpYk9ySnYxcEpnOEFub2k2RjNzSmpPRUtIYzRjdjNjL1Ax?=
 =?utf-8?B?dFFxKzl5bmdVSHhUcjlNTzlHUXh0OTJlN3ZoNlFGK0VqU0JyN3VWa3VwRUtQ?=
 =?utf-8?B?cmJ4Y2ZKbUNmZ3BQTnoreWt0cWlpck16c0g5bkUzRkVLT04zY1QwL2syUlp3?=
 =?utf-8?B?dkRQSTB6SzhGMmJ3cDFsRmVoWnY5REh5NWxmdnVUUExKclk0SmpSMWJUeGVk?=
 =?utf-8?B?cmladzFyWS96ZHRwU1dTbitLZDcxRG1lT2dlWkNJU0FYWUd3aW1mV2ZQNDhH?=
 =?utf-8?B?eGtETjY3VWxwU1d4OTkrVStGQ2RYOXpoQ0ozWXFYb1I4QVM3STZLUHJ2ejFv?=
 =?utf-8?B?OHV4N2IwMlN5UnJBOFJSUWhHYnpmbnB3TEx5WU9tOS8wb3VraVRvUUV6Ukx4?=
 =?utf-8?B?STNuZzJ6UWJRVEcveFRha3ExSjNnWnRnblJOem5OUW92ckFDbTFLTTgyNmVl?=
 =?utf-8?B?anp0WllVcURUUzFIbTdENXMwWFNEYjcxRmJteDRENTVJTkQ3YTMrNHFOQXM3?=
 =?utf-8?B?SEJrN21PVDRMZGxpb2JIVi9WZDgzTmdZZlVhTURLZE9XV0lHRHFxenlRMHVZ?=
 =?utf-8?B?VmNUbWdRWjMzcDhqM0FxeWtxcEtLcHFIRE9SckNqL1V1TnNjNW5jdiswbDha?=
 =?utf-8?B?T3pKZWpPdGNGdEtxN2dkZDQ4ZHExZlU4QVlnUTMwNzhmOVZvOGpKeWpKdnlO?=
 =?utf-8?B?anNQTG5XbGtFcHRRVHlnY2Q5NkJ5bUlrMWk0MS9NeHZEM0l4aXRJVnNjYmVO?=
 =?utf-8?B?K2VhNVRMSTh5VGNYSFF1b1ZBeGp0L1ZWRmV4TlVnTHNCQyswUGhGbHB3cWd1?=
 =?utf-8?B?dG1MNUVWM2FtcWVDYTJZUTBBOW90ZDI1cGtldElGQ0JTbW9wRHpoTlErdE1y?=
 =?utf-8?B?VjViQ3FRYXRWdGFLOGMvSEluV2U2RWtiM3FsaUFhMlZlZkUvZi9JWVpXU0NZ?=
 =?utf-8?B?NE53M3c4SWI2RTE3bHQ2S2pXMFhaQytoNHBEakxiV1ZvSEE2am1Ec0tlMFlV?=
 =?utf-8?B?MU5SZUlOV3phSW16bGFaV0pBZ1IxZCtyRVJLTlVvOGVhMnFROEtuQ0dZOXpP?=
 =?utf-8?B?VUdNUGdMTWlkS3ZjYk0wSFdhM2NBdjBWUytYamVxci9qbnJCbUhVeWpIZVlH?=
 =?utf-8?B?cmtlRm96a2dOUEIrUkk1SENyanppSG9pTU1JSGQ2c3lHbUNVVmc5SFh1OFp1?=
 =?utf-8?B?WFd2NytJaisvY2hlK0djbmlMT09aS1k5RXBsTjNrUkV4eGRzcEErcEZudG1h?=
 =?utf-8?B?VFBkRmg3VndPemdIcEtFUUFxV1l1R1lzN1FVRXNlRzNFbVBoeXRFeWRGenZv?=
 =?utf-8?B?cmtSZnBvLzVTWStpeGNSNDc5NjJHZUhzUXVVV2lBNjhlU1MraklmVXRPQW9H?=
 =?utf-8?B?SS9Rb2pCRTFibEhTN2c0RjFzTmlKekJqeU90QXlZS3puS0ErYWlHUmxyOTJG?=
 =?utf-8?B?QkxoSlJ3aGNPTGEzWEs0ZkFGUkpVa2V2Q3crL2hLREpVWjgvVyt1ZXRITmpz?=
 =?utf-8?B?WEhHcDhkMnNrdzIvY2RvZVJ4QTlicHZOeEhpd2xyVEttYTM2OUd0YjdaY2dq?=
 =?utf-8?B?amNpTHdnMkFOOFM5M3hFWU9EZVJUY0FORjg5dVpYaE0rMmx6N2NHSytmMFds?=
 =?utf-8?B?anBvSTdBQ2dmYWVFZ3ppeTUzYnB2UWNpTHUweU9QOERhY1lha0YrUjc5NEpC?=
 =?utf-8?B?QWZPMGNVVFZqRkdjZ3dsS1UxVFFrUXVMUEpoZG9HQkxUcXFlbmZVMWswMFph?=
 =?utf-8?B?ZHdhcEh0Z2VFM2x1d2JwSzhlZjRZVmpSWmFMZDBlRVhsS0lpMktQMTBtenpl?=
 =?utf-8?B?aFRwTDRBcUNyZS9OcVk5VEU5c1lEa1g2V3FmMXEzOG55b0FEUitXM1MrWUJQ?=
 =?utf-8?B?WDdTZkRNSXhlRE5uZFBiM1UzM3Vva09hNG80bkJIQ3VQWUE0LzZWV2FHOG1U?=
 =?utf-8?B?Y2tLcDVIZ0N2eEJCNC9JajN0S2Z4QkNDRC9zdVJwZWp1TWdPcldhclFkQkw0?=
 =?utf-8?B?UjY4L1JSVkM2TGM3Q2dsTUd6VjNML2RZMjNXU0NsVzd0Yk1MbytXWG1vU3Vp?=
 =?utf-8?Q?dRA08EVLGnv/XtXZ1A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59abc5a6-652e-4dcd-f0fe-08decba623ed
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:52:36.3003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4KqfRRE95/yLMLnSx0ECBlqdQr46iTIOdTJXhvDJH6/Tz0ygT14F3ZzEKCaUwmU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9520
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

On 6/16/26 13:39, Tvrtko Ursulin wrote:
> 
> On 13/05/2026 18:08, Timur Kristóf wrote:
>> The soft IH ring is implemented entirely in software.
>> We shouldn't read (or write) and HW registers when accessing it.
>>
>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c   | 7 +++++++
>>   drivers/gpu/drm/amd/amdgpu/ih_v6_1.c   | 7 +++++++
>>   drivers/gpu/drm/amd/amdgpu/ih_v7_0.c   | 7 +++++++
>>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 4 ++++
>>   4 files changed, 25 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>> index 333e9c30c091..65e5d21753f9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>> @@ -439,6 +439,10 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device *adev,
>>       struct amdgpu_ih_regs *ih_regs;
>>         wptr = le32_to_cpu(*ih->wptr_cpu);
>> +
>> +    if (ih == &adev->irq.ih_soft)
>> +        goto out;
>> +
> 
> Would it be feasible to move amdgpu_ih_funcs from device global into the IH rings themselves? Then we could have soft IH ops and it would be very clean.

I've thought about that multiple times as well but never had the time to actually do it.

So feel free to implement the idea.

Thanks,
Christian.

> 
> Possibly also cleanup all the protoptyes to operate only on ih and not the adev + ih pair.
> 
> Regards,
> 
> Tvrtko
> 
>>       ih_regs = &ih->ih_regs;
>>         if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
>> @@ -514,6 +518,9 @@ static void ih_v6_0_set_rptr(struct amdgpu_device *adev,
>>   {
>>       struct amdgpu_ih_regs *ih_regs;
>>   +    if (ih == &adev->irq.ih_soft)
>> +        return;
>> +
>>       if (ih->use_doorbell) {
>>           /* XXX check if swapping is necessary on BE */
>>           *ih->rptr_cpu = ih->rptr;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>> index 699c274d357e..9dbc20131410 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>> @@ -410,6 +410,10 @@ static u32 ih_v6_1_get_wptr(struct amdgpu_device *adev,
>>       struct amdgpu_ih_regs *ih_regs;
>>         wptr = le32_to_cpu(*ih->wptr_cpu);
>> +
>> +    if (ih == &adev->irq.ih_soft)
>> +        goto out;
>> +
>>       ih_regs = &ih->ih_regs;
>>         if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
>> @@ -481,6 +485,9 @@ static void ih_v6_1_irq_rearm(struct amdgpu_device *adev,
>>   static void ih_v6_1_set_rptr(struct amdgpu_device *adev,
>>                      struct amdgpu_ih_ring *ih)
>>   {
>> +    if (ih == &adev->irq.ih_soft)
>> +        return;
>> +
>>       struct amdgpu_ih_regs *ih_regs;
>>         if (ih->use_doorbell) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
>> index 6de9e87e04e1..bd332e8cc5bf 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
>> @@ -457,6 +457,10 @@ static u32 ih_v7_0_get_wptr(struct amdgpu_device *adev,
>>       struct amdgpu_ih_regs *ih_regs;
>>         wptr = le32_to_cpu(*ih->wptr_cpu);
>> +
>> +    if (ih == &adev->irq.ih_soft)
>> +        goto out;
>> +
>>       ih_regs = &ih->ih_regs;
>>         if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
>> @@ -527,6 +531,9 @@ static void ih_v7_0_set_rptr(struct amdgpu_device *adev,
>>   {
>>       struct amdgpu_ih_regs *ih_regs;
>>   +    if (ih == &adev->irq.ih_soft)
>> +        return;
>> +
>>       if (ih->use_doorbell) {
>>           /* XXX check if swapping is necessary on BE */
>>           *ih->rptr_cpu = ih->rptr;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> index 4cd325149b63..e7ed37bb48e0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> @@ -417,6 +417,10 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device *adev,
>>            */
>>           wptr = le32_to_cpu(*ih->wptr_cpu);
>>   +        if (ih == &adev->irq.ih_soft)
>> +            goto out;
>> +
>> +
>>           if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
>>               goto out;
>>       }
> 

