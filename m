Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C62CD4F26
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 07:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A1A910E991;
	Tue, 12 May 2026 07:08:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pWGHhIH4";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 627A710E989
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 07:08:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVbNlef/11ixW8ZPPVLaLVpdtaFasE7u7S7EPhbqxUTsUA4IpQsDI3pnluEUNn3CqFL0EVB72AcaoMJeXNcoFh6KqqzG/G9jQe2YwMjaP4wEedr5kU60z4bvnIFHOp9gDGcUzsaRo/iVEKgxHC3FaqeIZ6VPwa7YyNup2ieS0DRARZjSt3nHb1moC6TNy8jIuWSwVgVIvfNnFLLlc8wHYrf3sDiOu8V11xtKDnt1TcJ/I3haS4A6kWCpJ5N5q1Qlqq9EpmKX80BhqyiuZdFVtZyyBcpM3zlvpWqaH5O8bbwxOt11GZkK5y4N+SmJLGk3X3AsVuYcvO8FiLcqSinRPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQraaj5Tji75tG6DKp48TxYc86vqUbQhoHi/gl6wDM8=;
 b=UsuajIuvMQsmDB5WO9c6lAvVp5E19cHgIiv9d7sSZZ16APiLM3Qi8zKwGu3qoqZgf3oV8D53ecP5y65nr4kpxAu9HSA1UlSTVEog8Vwp4dQwjhNCXWZ2UyyDRyYygv7+oWnJg4zukJpDpQLALxSIL0QL9kFV9KA5dCEKylG/q8B0oc2rUdgu+r1bQX7hnuBrVuMVXO9rKdZmW9Zi28l6KPhkuQnfm5CzcgFax/Ny/PZgve+CsGmrWYBsj2TqSx10ac4SG8RN0AvKSrGHIHb8OL3luErffuiJS3n8PN9hX4B7AjweOVfg07IL0hygLbxy1N96t2WP20EsYE4TWsA/pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQraaj5Tji75tG6DKp48TxYc86vqUbQhoHi/gl6wDM8=;
 b=pWGHhIH4Io4MzjIG18b3xktovqGj//jJM1ZhHFHVXdiKTnRRbg9nXD4xxa3WJHYTk6rUjlqsbcqbYnZ+UD4JowFRmc5Tdh9ll826fo9qjUPyqd5Qh0kP3c7kZ17eK5MHoMKJ5Vti1Y4Js/6Fq6uWQLbN57GK6I1+A4X6D9q/+F0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 07:08:12 +0000
Received: from SA3PR12MB7782.namprd12.prod.outlook.com
 ([fe80::a9df:115c:2208:56f3]) by SA3PR12MB7782.namprd12.prod.outlook.com
 ([fe80::a9df:115c:2208:56f3%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 07:08:12 +0000
Message-ID: <33f4de2b-ade6-4d89-8f27-f263c77c8dbf@amd.com>
Date: Tue, 12 May 2026 12:38:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu: add userq create and destroy tracepoints
To: "Liang, Prike" <Prike.Liang@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20260511135435.3818345-1-Prike.Liang@amd.com>
 <c4c71c7d-01f0-4249-9f8b-c10662f16b64@amd.com>
 <DS7PR12MB6005F2FA31C19DB3E7B62C9BFB392@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <DS7PR12MB6005F2FA31C19DB3E7B62C9BFB392@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::15) To SA3PR12MB7782.namprd12.prod.outlook.com
 (2603:10b6:806:31c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7782:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 64da9cc5-ce73-4e3b-0f9a-08deaff53ab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TvbfVe+4ZQ14fcIsY5RIV1O8boIX2Nig0nbirrRsKwPREEXZBY8F9Cu0bFNBQsBuEdf6aGEA8Mm/ETGD1kCi/3hNZwu6Gniv8D+HRYiQlFju3tMbNtj3UJqV7UaNUbFR4/CHT2JP3RRB4qBNwwd2BqU7JHU6y2z7f4TvPRmK6T1FNOXGOMFTBWvo3othZeDDa/boiUA2cofzqh8qifqvDinOMX2bxnnMrhz0QEZDqyMTB6D1TwEisrS8iBlzuiXbBQd6xjRHkh8z7UMC2LlkHQ1dB7huJe2zhyG7wRyuMAxZOpdLpjimpDW//yGBlrbJXOu8ilGl8g2F+pZ49gnkIKyQAu/iMu9ymIfLoxS7wc61q4TrtLyKbLhceHy7+P+hkrWWgYvZBkeZ3TfJzLaBG0gNk+sHEN7ZqgeyIOdUCJ15fdigrq4VZ6pGk7WslMDx4U5oSGBhmBb8w1RfAnMk5YhrjoNbRQCUZQ+nqYtUXZCasUTqUGAoGtG/4s0vcKC0C0CbGd53ck8KlroLF5iDFzCpGwjNXkeym5T4TCmKf7eK4U6P/m06SOKS2f7xhgD7qrOG2vB/elm3IAhe7Wal7qN7+e3xrgi17u0QwV8X8wCVpimXcbMApYVUtFpuEjmIceom1bw/IVLzXfpX3qttobThncjtaF1Lc76uPUlSflg7kDJzVS4yh8x8TuZxqywh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB7782.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(11063799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bThpbzByK25XUnJxRFF5Z2dCdmdXMCtTVHZYVVV1cEMrUTlUbGFFdDRhVlB5?=
 =?utf-8?B?ZmxKV25BRmtKSDhyWHpjcVNyb2FweFA2a1FONEZuQzNqMXB1K1dKdk41TWE2?=
 =?utf-8?B?dDd3U0hzenZjdS8yWDJQY2xZWGp5eDdEU3RpUE5YSms4dVM4NkpBZWxFUnNn?=
 =?utf-8?B?RGNjNmdETE00SGZyd1NCaTdMZGJzOXJURVY2c1c4b3VGTWVLUE9mWkhDMVV6?=
 =?utf-8?B?ZkV1c2pwR2RzSUEvRUlQOFFIUTFVc0JLdlpia0hIc2lMRzNsNHcwd2F0WW1v?=
 =?utf-8?B?K2lnVGpacGRMbmFJWHFLbVRZZlB1QjNtSHhpbEI3Q3NiSndCaE5VZGZLKzc3?=
 =?utf-8?B?MlljRWVkZHkzKzltUVdwZ05xcGZkTzFFSXZKR2RJbWZnVjhaa2x3UGpGazB0?=
 =?utf-8?B?NEhTMXA3RDd0d3pBSSsvc0xsUytlTlEwZnhoajhTSWVPQUEvRUFDV3VGeHZp?=
 =?utf-8?B?QmRPUGkwNFRUTWpaaXMvWENpazIxeHdSb2ZObDRIT1pFTXkzNk5HWTVyQXZp?=
 =?utf-8?B?ZjZERFdoTE1Bd0NTanZLeTJJSVhkRDdUbnhkaHBGM0NGOEo1eERlWS9xdkJT?=
 =?utf-8?B?VWFvTkUvaERQdHh2U2ZWUTkyR3JiSEZISWVpSWlTR09EV0ZGV3ZkbGYrKzZm?=
 =?utf-8?B?WGJHVysyRmRQdlZ5dzVCWW4rcC94RlY5QXNyN2tkZUJqMWREQXhoNnc3RjFm?=
 =?utf-8?B?NUY5cTdWUG5HZ2hOS2JJd2tiUXMyOEpwdkcxZjRYczhLTW5rV0lIV0E1ZGRO?=
 =?utf-8?B?NE1zNzFnajVPcDM0UWRaMzhZa05yM1lDZk10a0xUb29Fbi9aOWFIZnBTajdY?=
 =?utf-8?B?bjFMRzFwdzRSREdLcVJDUVA5WC9WNjErODVSNWU5VzVrMjdQa1NYSDhGQitI?=
 =?utf-8?B?R2I1YVFGTUoyV0U5SnErWThsTVdvdVVhRFVjN3B0T2REWWE4NkQ5NXM0S3k4?=
 =?utf-8?B?THJOTTZDZmp4VzRwbUJoelRDRlgxQlQxY0ErQkVmYjcvc2FtUGd1VTNJN0dM?=
 =?utf-8?B?S3FlNnFSSTRGWjJYODdmUEpOK1RGTzVIbitzMDVjQkl1WlE5NmRrUGs4Ym5T?=
 =?utf-8?B?cmVxV016aTU4MjdLd0NCWnRkdDRJMkMwTkdrOGdQNnJNbGU3UjVnTmplZTNJ?=
 =?utf-8?B?V0ZISDZGb21aZzA5ZElKYWxFWVE2a29vUFZWd2N6ZlptRzVPdzBLNnBmMnFO?=
 =?utf-8?B?dFgyY216OHZVL0V1NVpkdXdaajFxbk90OFRnSUJLOTRLNmI2aUJ4Qmdvdmo4?=
 =?utf-8?B?dTRYVWJNeVh6ZmlSQks3VEpVSzd2WGZSTlcwSlBxN0J0K2EweFhLdzJhazJS?=
 =?utf-8?B?dGQvTE1GajRNWEYrU0txbVlhYi91L2dkS2FSa1V4ZXlVbisyZ29JN2QyMjFC?=
 =?utf-8?B?SldBQUhRN2Nhc2grVTN2amI3STNablM3bXlPS3hPM3QycEtWZDE3QzA2OTJl?=
 =?utf-8?B?R2VpUFprUW90ZzRJS25kODlFekRsbmRCU1E4YjZCYmxKNkFtU0lyVkZtcEVJ?=
 =?utf-8?B?aFVGR1NyQVVXeDVZQ24rN0tlcUtQQUxHQmtMc2ZYeTJMdm5saUxyZDBVNEM1?=
 =?utf-8?B?RlQ2U3dWMkdoZDA0WWIraTlMaEhSK1N1Tkk4TkJROHhqNGpNNjdZeFdLeUtC?=
 =?utf-8?B?KzRpek1uQlZaVFpMNTl0Z20rZElweEhYbFZ0NklreVovM2Nnd0lUSkxTQ09R?=
 =?utf-8?B?clk1VWV0cU5ZVWdmdmovVDlWWEFBRUprZUlaenZ0eDZyajlES2hDaDYvUHlo?=
 =?utf-8?B?OTIxMlpGell3bW4rWWNxNUo5L3VwZnAyRndiRXZwUmJNQmtvYUVRblVxbnJD?=
 =?utf-8?B?REh1eGEvbnI0WDZoZWQ2emI1b1NMVW5BM3hVdlBXS21zSk1Pc2hEcjdEVWxH?=
 =?utf-8?B?TC9rS3U1N0E3aDRTbVdLeStOQ29SMXptNmZiRmtaeVFSOXR6NkpPU3gvSEJL?=
 =?utf-8?B?ODNnYk50NkhKRUxUTHRLb2JML0V5K0hqRjYvRTdETzZXV0gwUHkvMDVtV1VE?=
 =?utf-8?B?VUdVSTF5SWRxM1RZTEo0YjRpWVAxSFIvdUVaaThWUlZPRVUwdjB5Nk43bFZx?=
 =?utf-8?B?UDNSQlJyYWF3TFBXQWJQRStQRnVueVVSRnlFVXdQOVhpdWlicklSem1TcGE1?=
 =?utf-8?B?T0FZU3hma0tmM0ozS0RpTGI4SlpYSDdGck10S0xkWEsrT2FyU0prMkNYMDUz?=
 =?utf-8?B?UDRiclEweEdyY21UN3E2QzRSL1lLRnEvOWFISjBQL3hQMWkzelROTnJSTWNY?=
 =?utf-8?B?Y1JPUTVxSVNWYXR0dUR0RThXMk9ZWFlEL2hDem94WXQ5K1drckY5OS83Ykhs?=
 =?utf-8?B?QlAvWG1sUEtZekhjTTJVdFlFWkdTQkdqQTZCbk1hd0hReldzcEJkUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64da9cc5-ce73-4e3b-0f9a-08deaff53ab4
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7782.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 07:08:12.3950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTZk/TKy08M1DNG5QyQgJX/sOJpkoZmVSNj0pwk6UT2P1GH0zoxvfptEItczgF6HESvP6E5ydeQcPhAaTub2zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340
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


On 12-05-2026 07:38 am, Liang, Prike wrote:
> AMD General
>
> As far as I can see, there's no such implementation on the drm-next branch yet. I came up with the idea of tracking the userq lifetime quite a while ago and also raised it in the dev discussion group. This would not only help profile userq latency but also troubleshoot userq sequencing issues. Hi @Pelloux-Prayer, Pierre-Eric, could you please share the status of your userq ftrace work, or is it supplementary to what you already have? Ideally, we should land such an implementation to properly track and profile the userq flow.

Yeah i am aware of it that you did propose it. Also true that till now 
even i dont see any traces added in code. Check once with Pierre and i 
guess then good to go ahead.

Regards
Sunil Khatri

>
> Regards,
>        Prike
>
>> -----Original Message-----
>> From: Khatri, Sunil <Sunil.Khatri@amd.com>
>> Sent: Monday, May 11, 2026 9:57 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-
>> prayer@amd.com>
>> Subject: Re: [PATCH 1/4] drm/amdgpu: add userq create and destroy tracepoints
>>
>> If i am not wrong Pierre eric did work on the traces for user queues. I have dropped
>> my patches for the same reason but not sure if the traces patches are merged. Could
>> you check with him once ?
>>
>> On 11-05-2026 07:24 pm, Prike Liang wrote:
>>> Add ftrace events around user queue creation and destruction to
>>> profile queue setup and teardown latency.
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 58
>> +++++++++++++++++++++++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 +++++
>>>    2 files changed, 69 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> index d13e64a69e25..5a01f63d1f32 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> @@ -578,6 +578,64 @@ TRACE_EVENT(amdgpu_reset_reg_dumps,
>>>                    __entry->value)
>>>    );
>>>
>>> +DECLARE_EVENT_CLASS(amdgpu_userq_queue,
>>> +       TP_PROTO(struct amdgpu_usermode_queue *queue),
>>> +       TP_ARGS(queue),
>>> +       TP_STRUCT__entry(
>>> +                        __field(struct amdgpu_usermode_queue *, queue)
>>> +                        __field(u64, doorbell_index)
>>> +                        __field(int, queue_type)
>>> +                        __field(int, state)
>>> +                        __field(u32, xcp_id)
>>> +                        ),
>>> +       TP_fast_assign(
>>> +                      __entry->queue = queue;
>>> +                      __entry->doorbell_index = queue ? queue->doorbell_index :
>> 0;
>>> +                      __entry->queue_type = queue ? queue->queue_type : -1;
>>> +                      __entry->state = queue ? queue->state : -1;
>>> +                      __entry->xcp_id = queue ? queue->xcp_id : 0;
>>> +                      ),
>>> +       TP_printk("queue=%p, doorbell=%llu, type=%d, state=%d, xcp_id=%u",
>>> +                 __entry->queue, __entry->doorbell_index,
>>> +                 __entry->queue_type, __entry->state, __entry->xcp_id) );
>>> +DEFINE_EVENT(amdgpu_userq_queue, amdgpu_userq_create_start,
>>> +        TP_PROTO(struct amdgpu_usermode_queue *queue),
>>> +        TP_ARGS(queue));
>>> +DEFINE_EVENT(amdgpu_userq_queue, amdgpu_userq_destroy_start,
>>> +        TP_PROTO(struct amdgpu_usermode_queue *queue),
>>> +        TP_ARGS(queue));
>>> +DECLARE_EVENT_CLASS(amdgpu_userq_queue_result,
>>> +       TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
>>> +       TP_ARGS(queue, result),
>>> +       TP_STRUCT__entry(
>>> +                        __field(struct amdgpu_usermode_queue *, queue)
>>> +                        __field(u64, doorbell_index)
>>> +                        __field(int, queue_type)
>>> +                        __field(int, state)
>>> +                        __field(u32, xcp_id)
>>> +                        __field(int, result)
>>> +                        ),
>>> +       TP_fast_assign(
>>> +                      __entry->queue = queue;
>>> +                      __entry->doorbell_index = queue ? queue->doorbell_index :
>> 0;
>>> +                      __entry->queue_type = queue ? queue->queue_type : -1;
>>> +                      __entry->state = queue ? queue->state : -1;
>>> +                      __entry->xcp_id = queue ? queue->xcp_id : 0;
>>> +                      __entry->result = result;
>>> +                      ),
>>> +       TP_printk("queue=%p, doorbell=%llu, type=%d, state=%d, xcp_id=%u,
>> result=%d",
>>> +                 __entry->queue, __entry->doorbell_index,
>>> +                 __entry->queue_type, __entry->state,
>>> +                 __entry->xcp_id, __entry->result) );
>>> +DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_create_end,
>>> +        TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
>>> +        TP_ARGS(queue, result));
>>> +DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_destroy_end,
>>> +        TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
>>> +        TP_ARGS(queue, result));
>>> +
>>>    #undef AMDGPU_JOB_GET_TIMELINE_NAME
>>>    #endif
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 3077ca4e27a0..50c46d31fbae 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -33,6 +33,7 @@
>>>    #include "amdgpu_userq.h"
>>>    #include "amdgpu_hmm.h"
>>>    #include "amdgpu_userq_fence.h"
>>> +#include "amdgpu_trace.h"
>>>
>>>    u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>>>    {
>>> @@ -617,6 +618,8 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr
>>> *uq_mgr, struct amdgpu_usermode_que
>>>
>>>      int r = 0;
>>>
>>> +   trace_amdgpu_userq_destroy_start(queue);
>>> +
>>>      cancel_delayed_work_sync(&uq_mgr->resume_work);
>>>
>>>      /* Cancel any pending hang detection work and cleanup */ @@ -625,6
>>> +628,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct
>> amdgpu_usermode_que
>>>      r = amdgpu_bo_reserve(vm->root.bo, false);
>>>      if (r) {
>>>              drm_file_err(uq_mgr->file, "Failed to reserve root bo during
>>> userqueue destroy\n");
>>> +           trace_amdgpu_userq_destroy_end(queue, r);
>>>              return r;
>>>      }
>>>      amdgpu_userq_buffer_vas_list_cleanup(adev, queue); @@ -650,6 +654,7
>>> @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct
>> amdgpu_usermode_que
>>>      amdgpu_bo_unpin(queue->wptr_obj.obj);
>>>      amdgpu_bo_unreserve(queue->wptr_obj.obj);
>>>      amdgpu_bo_unref(&queue->wptr_obj.obj);
>>> +   trace_amdgpu_userq_destroy_end(queue, r);
>>>      kfree(queue);
>>>
>>>      pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> @@ -754,6 +759,7 @@ amdgpu_userq_create(struct drm_file *filp, union
>>> drm_amdgpu_userq *args)
>>>
>>>      mutex_init(&queue->fence_drv_lock);
>>>      xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
>>> +   trace_amdgpu_userq_create_start(queue);
>>>      r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
>>>      if (r)
>>>              goto free_queue;
>>> @@ -809,6 +815,7 @@ amdgpu_userq_create(struct drm_file *filp, union
>> drm_amdgpu_userq *args)
>>>               * This drops the extra and last reference which should take
>>>               * care of all cleanup.
>>>               */
>>> +           trace_amdgpu_userq_create_end(queue, r);
>>>              amdgpu_userq_put(queue);
>>>              amdgpu_userq_put(queue);
>>>              return r;
>>> @@ -826,6 +833,7 @@ amdgpu_userq_create(struct drm_file *filp, union
>> drm_amdgpu_userq *args)
>>>              r = amdgpu_userq_map_helper(queue);
>>>              if (r) {
>>>                      drm_file_err(uq_mgr->file, "Failed to map Queue\n");
>>> +                   trace_amdgpu_userq_create_end(queue, r);
>>>                      mutex_unlock(&uq_mgr->userq_mutex);
>>>                      /* Prevent racing with close */
>>>                      if (xa_erase(&uq_mgr->userq_xa, qid) == queue) @@ -839,6
>> +847,7
>>> @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>      atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
>>>
>>>      amdgpu_debugfs_userq_init(filp, queue, qid);
>>> +   trace_amdgpu_userq_create_end(queue, 0);
>>>      amdgpu_userq_put(queue);
>>>      args->out.queue_id = qid;
>>>      return 0;
>>> @@ -853,6 +862,8 @@ amdgpu_userq_create(struct drm_file *filp, union
>> drm_amdgpu_userq *args)
>>>    free_fence_drv:
>>>      amdgpu_userq_fence_driver_free(queue);
>>>    free_queue:
>>> +   if (queue)
>>> +           trace_amdgpu_userq_create_end(queue, r);
>>>      kfree(queue);
>>>    err_pm_runtime:
>>>      pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
