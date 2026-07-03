Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DB3C43458
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2026 18:45:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9F7010E664;
	Fri,  3 Jul 2026 18:45:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hg34jWTa";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52A8210E664
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2026 18:45:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4xPBcED8MXaPA4X1uyb6ZfdoBD8BopC8Q6V6IkR2KH0eZXnKjk2kny2NMAnscVt0aisQw00wTwg3DErfdU2+2VTZAs/UDYIjZmZchhjOo8o3C5aeL3L0YHM/+s0btK8isZdoeNc/6B0U6c382xsQlDULKfEJrTa0Mgbv18smZ5y8k2RxIU8KT8ea5SpRJe76PvPR3PAzkt1XfgR8A1Gk91d+STUF3+kStW1c8MFy12gIH4oMNpF3//lfOu8AvShsG/zPwHJQaR6fo1O0tCngUjmCuc1NSyTjt8D3f+BITmhYblalUfAgbYmw2vQKi2LKawyp2It0dgRjZDDdcFFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtpEF8GBOyLwlZbadHNW6axN3zK4F61KapwQ8wPjf94=;
 b=OutwjIwW1lwDTw0ObqU5XXaRxkMTk3GMDE0EPAaNpxMYe1GbUScHdGnHthqbdT9pjWnTPe7q6g6DZeAzaTt9pwwWSLzwiU9yqS/Uy4zbPvx+zhvZaqjSumBZaj7PaDeYKwPu/YEscJBLyx8s4FXk/V3a3aBhP6cJy4wRZsLlW+5hwMOHWpFAkWlyx4j7kjwV3jRP4HlOE2ycjSvAbeyKNvvvoRR4NReueU4RMflvbQYEe/AQwwdLMBlO/cQ2nl8MPv8QzwZKOohlLYT0GlNHm3OGBTDGlP3qbjd4WB4DVM85RRizrcSoqzlKW6ksSUvHjV/a7WGzjIej3OXu+i9hiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtpEF8GBOyLwlZbadHNW6axN3zK4F61KapwQ8wPjf94=;
 b=Hg34jWTa2wkgMw4oJmDkPxrbVwprKBppdwb24N8ZPMyc+ldFFWk/AIQTmNxHHg2411iohWwbYlmCV5FKs9Wk9mda4bS02sJ4UyjW1mhu/jYMhzmJVqp/jC43bw0NWqaIdqTvAFoh4hsQ22Za0gD3oWgOChdiUJPVvdvVnytKSUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by SA1PR12MB6896.namprd12.prod.outlook.com
 (2603:10b6:806:24f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 18:45:36 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::3c75:97d4:f574:9dd8]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::3c75:97d4:f574:9dd8%5]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 18:45:36 +0000
Message-ID: <60643733-9cf2-47d6-94da-25bc3d40f14f@amd.com>
Date: Fri, 3 Jul 2026 14:45:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] drm/amdgpu/ih6.0: Use MMIO ACK for retry CAM on IH
 6.0
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-12-timur.kristof@gmail.com>
 <4547ddd3-974a-4c9c-8fec-939dc132f7d0@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <4547ddd3-974a-4c9c-8fec-939dc132f7d0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::9) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|SA1PR12MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: 83108c85-b71f-4616-cb44-08ded9334537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|921020|18002099003|22082099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: lJ6+LpNjQ/DzvNMKfZeoGNzKYg77BnEWYPiyqomiF8bZGfFJq3Gmhcd2PMnVPoFki6UKPIL7OQ+Fq5aW47knbkyLMHScCPshsv5AwI8JGKSexmW7dXu0YvCHy2oOAOEDD+D4v+j3XEehgkc2wZCkewo1IparDnrtpqWGdHJ49txxEQSlb0URKBzB1kipj5aJVFRaMSwriuEQ3woYZm2uRhb5rTGqqReXPEUx46eZpE5oEJw4xWtf+HFP/iNVDMUDGnot7HRYZ2e+uZEiwxo6ke7buYrlhHbqsqBacV4ukLyR/s03pWi0zTlXPhxVNLZ62CmSJRXrTijPi//R113kT3clJ68MemVsUBCINCrjNS7Knt98hAH8tbjoXZY03P6qZ/V9yb83St+fLFr4y6EO2ZOWaen+NRlSR+i1Kp7epU5xCZkl1ZwfKnNuaWZQTK2uNehD3XsoH9V4OqUT9L0bXZPmul7rKhqxr5YR3GbMgQGQ0CeMmmvY4mEDPxPfv+ayQIipCAh0nRtgFGvd8dwLajn+q9+UYiVw+fmGSDZrhO42b9ZAUFFlj0OFjbClSfr0qO34YsOvMeLBRhYj4/L6uPw+xTk+rJhhB8npxLBhJvHuoVAL6SOTWLbvkuI1IvDtsWTeG8wmAn1c3Sm59jwXMNZgHmsFtKs/Gqpnv7myQwRacDdKxMqqJynybrXQaV24LmKJ1lXWCBrrrJ5PEq7wkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(921020)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTQvT2I2QjVWeC8ydDJFa2pkV1NyQWlUNmpLdzdmclJjamRWS3NQeUZZYlBN?=
 =?utf-8?B?L2U4NUVZdS9EcnlsajhMRWdNVHg3NVIyK3lVN1VyOGV0UmdWMGFLSWRvY0ov?=
 =?utf-8?B?dDRwUnVCR2c1aTBQVG9mK0VYTVJQNGd6dUFTTHBhU2t3ZER3U05KdkI5OTZs?=
 =?utf-8?B?SllIUVNzT1Uva3Y3eWc3a3duYXVabEVKVGdVQmxaODNiUXdTK082OWVhQ3ZP?=
 =?utf-8?B?ZXdtOU01dWVLN3N1Q05HVWc2amJRZVp2MVZ1MmMrdlY0UDYvZUJFbVQzT2ls?=
 =?utf-8?B?ZjRwUGlXOC9PZVNkTnR4YjIwT0ZMaGR5NmNoY1Q1Wmxpa0YxbXJuZm9nRVRM?=
 =?utf-8?B?V213dXVONzF2bDRqVlZUZFd4aWxSWHZ0WDFKU3VMTGZ6NjlkYm5VMlZXbEdW?=
 =?utf-8?B?VmVvTmp6TU9pS1JOdUFvcTR3L1JiQW5Pcm5zWmw0VjRNWTdJREJiRy9WZ282?=
 =?utf-8?B?L2RTQ2hnY0k1ck8vOFhoT3hHbEl0V2NoSlpha3RScXAxWnJqdDRNcjBBcTQx?=
 =?utf-8?B?R0JLczdEVUZOSzQrSDFtZ09STEM5M29IR0gremozVnRNMEllLzRldm13OFJj?=
 =?utf-8?B?Wng1MjhtS3M5Q05sNnJodGo5QzZHRlFUNURrcHdWRW9rMTY5UUNUVEtuOThP?=
 =?utf-8?B?M3BLVFRWK3hlOSswcnVVMGsxUTBiRTFsZ2Z4MjRiWXBieFdTRHpNKzJzNlhS?=
 =?utf-8?B?OHJvT01hWDE1cXI5VTVnOVRtYkVCQ0ZlR3dicVRjK1VsYzFLQmtDTThnTW1z?=
 =?utf-8?B?Snk3S1oxWFpYRU1Sd1d1OVlETUYyd0ZsMTJEUFJaT1pYRnNPbWRCbis3U3Z5?=
 =?utf-8?B?TXF0ckVJa0dJaXptNzhVWTY2OWZERGtvVGZVdld3T3pXOFNKVElxU3JlWEk1?=
 =?utf-8?B?S2tsNWZIbUxyUHlPV1NsdDFwTWtzZEVMelZ1Wm9KekM1T28yaU9RMkpvaTRO?=
 =?utf-8?B?UDhIS0pRUk92Q3ZPK0ZFSEJ0cnRvd0xpOVJudnQxQ3pRU0gxUEhyYWhWTWJt?=
 =?utf-8?B?NWxNYUhiUm8wTWVZMUJjbUhzNVdYSStFaFJSWmJVSEtoUkVEcG1ObElud3RZ?=
 =?utf-8?B?QUNCVzc5QVpzdGpHWENhRytKc0tvc1l2TVdtQURhTVNTZ2dxZS9Pekg4VnJr?=
 =?utf-8?B?WTJNeENTOHJpYkNPbUgyY3dVRTFmQm5YSTdDU0JtRXFSSjBiSzBobWF3dUlQ?=
 =?utf-8?B?NTk4c0dNc1h2aUhoTW1RVWszTGdiMFltWXVGNGVQOUUrQjNldmo2TmQ0T3dy?=
 =?utf-8?B?MVpVeVNSNGgyRlprTTlSb05OM3VqT1Fpb200aGlmczk4MlMvVTFvQVpuSjVq?=
 =?utf-8?B?ZTE0K2tHbmVab2FZam1GbS82U0lhTU1wdUFneHp4WE1DcTdXcWVyNkdqT2o5?=
 =?utf-8?B?UVFQcWU0VU1vTkpuaFQ3eThnUk80d09RaWlDUm1KbE1xdVluTmJuSjJXNDMr?=
 =?utf-8?B?UVRCUE5FcHZ0a3MvUDFNSGl5YTJBb2JPSkZiWXZPcVRvTXg3eXB4dk5ScXRy?=
 =?utf-8?B?Y1piSWJ0NVp4d1BKWVJrUTB3V3B6M2dhYk5RR012UVpmNlcwUTlqY3B6TkFh?=
 =?utf-8?B?N2RUbXFETFYyYi9iaXRCYVlFVzVJNkpLdjgyWnhldktFK2VibGdGb2dYeHgx?=
 =?utf-8?B?R3lnYlpsemN4dExrZnRwblJtb2RWV1F0UXNaSVNxQUlpN1BZTm1LdUFPdDdF?=
 =?utf-8?B?SmZzdURCYloyWmF3bVd2V2tUa3MyUUFRc003NVVVa0NRSno5N0tCaUVhdzZu?=
 =?utf-8?B?ekY0UHhBSXV1VzZEeUN6L1V1aG9ZR2JoSy9RWFV0ZWNuRWRDWW1jTXo2U3h4?=
 =?utf-8?B?cFNxR0VNMzBBRTBJWEpPZnIvLzMwUnZaazJGTWR6RWVzNTZsWk1iVXVubXRm?=
 =?utf-8?B?RGJLOEVOeVZJVFRVaU5lNXYweEoySHZ5QXpVdWJpeThsUFNkM0NuUDQ5cjVC?=
 =?utf-8?B?T0hXaVV1Qy9CQlBoVkFmZUJwY1E5NndpNUdONXluK2szSGNBYm5PL1FJc1lQ?=
 =?utf-8?B?Y2wvVGZYblgzTGhVK2pYVGNlYnV5ZktsdVp4YzIvZVk0SEcwSjloM2NGMGFU?=
 =?utf-8?B?M1lLY3pqUGtrT3QwSGZUYVJablF6VlQ4bHVjZlRndHZqenR1WjhjTUVwaDdh?=
 =?utf-8?B?UzFZL1k0SnpqdjFrR3BxNmpRVDhVQzFuODc4TEs1cnljZHlRR2JTR2xHM1ds?=
 =?utf-8?B?dHlxRHNITWovRkFwamt4ZVFWdnNtd0REZ1ZwUTJ5MjM0SEtzRHBBZHk5NXV0?=
 =?utf-8?B?TFBCdExadW9GZyt6b2x1MW9QcytHc0kra0E0aGk5ZEd0RkszMFdoODdjRkhq?=
 =?utf-8?B?Y04yNm9Td2VmWE9OaXJLNHdxNnpsODBFb1p0WUpmbTJLMDM2QzExUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83108c85-b71f-4616-cb44-08ded9334537
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 18:45:36.2761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYW7xtA0LZcZjDQTMkNYFi+4JAFR9WNBv4A06906StPCjgBvTgnJGAmVoal3zzTKuciv7/PvLIrAw3iFHHNTGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6896
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

On 2026-07-02 06:23, Christian König wrote:
> On 7/1/26 18:17, Timur Kristóf wrote:
>> The doorbell is not working on Navi 31.
>> Use the IH_RETRY_CAM_ACK register.
>>
>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> Acked-by: Christian König <christian.koenig@amd.com>
>
> I still haven't found any explanation why we use a doorbell for the CAM in the first place? Lijo, Alex, Felix does anybody know that?

Why are we using doorbells to update WPTRs instead of writing to the 
registers directly? I was assuming that using doorbells for the IH CAM 
had similar reasons. I think register writes can be problematic with 
certain power saving modes and virtualization. I'm not sure if there is 
a difference in terms of CPU overhead between writing a doorbell or 
writing an MMIO register.

If doorbells aren't working, it's probably some configuration issue. I'd 
rather fix those issues than throw away use of doorbells altogether.

Regards,
   Felix


>
> Thanks,
> Christian.
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>> index 65e5d21753f9..a97c85b0cb99 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>> @@ -307,6 +307,11 @@ static int ih_v6_0_enable_ring(struct amdgpu_device *adev,
>>   	return 0;
>>   }
>>   
>> +static void ih_v6_0_retry_cam_ack(struct amdgpu_device *adev, u32 cam_index)
>> +{
>> +	WREG32_SOC15(OSSSYS, 0, regIH_RETRY_CAM_ACK, cam_index);
>> +}
>> +
>>   /**
>>    * ih_v6_0_irq_init - init and enable the interrupt ring
>>    *
>> @@ -807,7 +812,8 @@ static const struct amdgpu_ih_funcs ih_v6_0_funcs = {
>>   	.get_wptr = ih_v6_0_get_wptr,
>>   	.decode_iv = amdgpu_ih_decode_iv_helper,
>>   	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
>> -	.set_rptr = ih_v6_0_set_rptr
>> +	.set_rptr = ih_v6_0_set_rptr,
>> +	.retry_cam_ack = ih_v6_0_retry_cam_ack,
>>   };
>>   
>>   static void ih_v6_0_set_interrupt_funcs(struct amdgpu_device *adev)
