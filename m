Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F54B606A31D
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UHvxPNCI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDBDC10FCB8;
	Wed, 28 Oct 2026 14:00:55 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011043.outbound.protection.outlook.com
 [40.93.194.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA79A10FCC2
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 14:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3UNtT0K7Ub0RKMuL0j5/vvy5PnCsaqfXhjSgkBGd6ptj+EM8fWUWj2INlJazcqGjAiJCnWat1pmg6/cP3zGo0LMV4VgGhzE1SY8XEwT1STe8kh/Prky4S+1ozvRZTCK7oJ0Y1BPnTlaANOkWK3JymAJtzSYUnaO2dFupsYXz8buSgWcE8dZ4Z6hfoe99n+kDk8xMA6QBcDnfg3ZkHngWD6cop1vF/+98YMzMf01K5WqPn9wqmeYJz5b8BwX5Ce+ZOqaYc/s4PpzeGr7FTOB5GWNjEgmCSk5eylBXilGPZuQ3COKvV8NXkKN1qm7/h7avrnhVZv/Pb/affqEv9pSIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bw97btPl5r+kwTWsCTt/Eco9blIKxDHK0k//p1Vo1IQ=;
 b=JgdygHrEhz/4r2ZakPuOAuxVYd+1KsSbDWAeYJ3S3QPZh9GjZ2QUuKuwCtrxnJ1N0QD2k5XfM4L+wqhgDjOleEV2HGwDaO20/sabF5lgOU41ErjrobF26VaKvOE8ekGFkkPdsmy7vevbVirzhcBUcL7eokKaeZ20jvd2bX4j1jYJWXxUK7n9BtHUwNcq1Zq3bO2dnrKXDceR00156X9o7mwI+4vmAJOpg/wiwSjK4krPVm8LTOvHy6ou8YbGiZ77loIRADjPbMQgoax1vMdayqqDqZAZ+pA7T3MOW++ZQ834lv6URvsIzbtzXCC/acnlFhLUUVsVCIio4BslD7uECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bw97btPl5r+kwTWsCTt/Eco9blIKxDHK0k//p1Vo1IQ=;
 b=UHvxPNCIzmb1Me/Xh/XLvxjd8Gz8l8KMgb2IzyxU0ePDhVaiXMYU0bBJvo7unD3XxTxy3eU2tV0hcs3Z+i4IGqThT57vsXDZZT6sDkvj+hmjxgVDv8OBF+fApCwHHixHw3K3WNA/ISDt98cvwVYvRPqiYeKD1je2GlWontnX5yc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DSVPR12MB999194.namprd12.prod.outlook.com (2603:10b6:8:496::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 14:00:46 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 14:00:46 +0000
Message-ID: <18feb9ae-d755-4ad4-9dc5-7f80880a2991@amd.com>
Date: Wed, 28 Oct 2026 19:30:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 4/8] drm/amdgpu: Attribute UALink loopback messages to
 the correct sender
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261027195913.1794477-1-mukul.joshi@amd.com>
 <20261027195913.1794477-5-mukul.joshi@amd.com>
 <0b9b80f2-58ab-4113-b308-562697650afd@amd.com>
 <0b5f7c6c-86af-4966-b18d-fbcf1b3cdf76@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <0b5f7c6c-86af-4966-b18d-fbcf1b3cdf76@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0233.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DSVPR12MB999194:EE_
X-MS-Office365-Filtering-Correlation-Id: 834cf38d-5dcf-4774-3816-08df34fbdcc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|4143699003|11063799006|56012099006|261026121527099003|261009223027099003|261021121427099003|10067099003|261021123027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TCqtkFqIkRaNzV7FgvhrDSLQ7m2dNCX2UujhRp3B73qTTlSU2i8DVnoGWv8WfuPdMyrjvXGC051B5811zmq/Ff76CymqxAHDagZrBg6QF3MfRd2uKkdW/G1IlXKVGuwpZbCeiwaNLK18Va2I4+YxYbHG6hPvP10CsgaKHwCzqlvTdwD+h26YY8hOKO4uk1D5+gXQJgJJBF2WD84RfURzrIAU3VFDj4fzf9LS/cb+xXPS9Qt6sHumUTw6Fj+8AGMbiZqGEmtaLNomgwcv4UkoPJ62eV7EK201BFKHLeY2sorjikmLbjo/oKLKUZNgFacGKxMmyX3gCH2vatT3ZG07x0gXDXRDD2ah92vSTdZJKJgDKzg98UaemwMSzRTDCE4U1xbcjiIgWH9Ha2xmjt1hMJwLIDgzaw5yc67cAimjfwqh2pN1WIw7dG1ZDU/sLrWeSvPbBGKAQ9854ldLUeVnlL4dJKtZXfZDQ4O1meCRoa/N929Dm/G8Rlwn1v7ebg/t2fbCfwOP4ofGuSPzoZyXmtLqukW5Am8c4c5SotqQaFWEAQeNwtn7c35MyhXBPYtIezPR1dbv6/I6tCoJSLHBRttD/vs1vybyd8ln4lGj3SGYoVeuPFga1jkQ81l2RviL4Cjer2aq8bVDnPjZNqbntZM+ew6FlVmSNCRu3rHTwmU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(4143699003)(11063799006)(56012099006)(261026121527099003)(261009223027099003)(261021121427099003)(10067099003)(261021123027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDF0SXZEdU1keERCcjdNNHBJb2ppV3BHeFNiNnQ1T1Fqc2F2Q2RzNVhuQWV2?=
 =?utf-8?B?LzhwM0pBeFM2Q2VLK3F5NHd5UWp3VzU4K2Y3OTVzQzNvTTViV1I0VUUzb09y?=
 =?utf-8?B?QllQdnFwQlBkbU9DbEJyUmt0Tm9CS1hHNXJLSGR4Z2s0ZFRiMkJnVzBxa3JJ?=
 =?utf-8?B?d2RmVGlTVDBub1FkQXJ2QSthWUhZUFUrSmdZT1lSSDJOQVV6dEIwak5NWEhx?=
 =?utf-8?B?MkovQi8rSHVkdGpGeUxsbG5rY0V3RGhnMWE2T3ZYVG42alNFZXE2UDJDN3Ny?=
 =?utf-8?B?TWN6QUpJaDkrd29vOGJzUlRwQWEybHFIRW5QcTVVakFmbTJOSXJPRFZMMFZS?=
 =?utf-8?B?aUZUaUErc0o2aTZreEdoL01idVJGa3NrWUVJZ29TRnVuUk1HTmpKV2g0OUZC?=
 =?utf-8?B?RC9iZzZTSENndkpiQTNGUXAwVEZmTjFTWGZKdUEyUGxZWGRnbC84UWNlTis5?=
 =?utf-8?B?RHlWRk9zWENsbXRCUmV0a01qTkdOM0NWQjR1Q2VOeGZGSFRJRStadXpmaUZW?=
 =?utf-8?B?RktKOXlNRXBmdnBsT0RoZ0ZWWGlLa0ZiVjhWQ2dxMkVlQ3lJZWV5UVJ0allF?=
 =?utf-8?B?OEFUeEx5N2JYUzNqNEx5RzNZcWxPbnlrZnZYV21ReFk3NmZlZmU3amg3bnFM?=
 =?utf-8?B?SWp2MTJRbUlsQVlpWWIwZ3E4a0lSV2ROSEVVeTE1S29LZmxSQVNneHJpNks0?=
 =?utf-8?B?cFBsK1NSeTJiWGMxc1ZrTmY3bzFadVRyVnE1UXg1Zk5TK1JtbW9uVmdQZ1Mw?=
 =?utf-8?B?KzhML3pDTHFTb2I3bHJHRVVRTXV0cmxjTWF1RVVadkVaYnBydTByZXRIZ05n?=
 =?utf-8?B?STJJQU5aRDJhOStQUzk2eWhBR0FkVy93OEIzTmlZRElMT2tOOWY0Yk5rRi9O?=
 =?utf-8?B?ZTlmMWpvbm1XQVB2a0tSNjF0WUFuc3BlSmpzeFAxQXkzNlB4bHIzVWdvQ3lm?=
 =?utf-8?B?SzZlV28reDUwQU1rRk94STcrOUdRamd4T2NPTDhBakN1VGZTSEQvUmFmbDZ4?=
 =?utf-8?B?bkZlaEVtNlRZcTFtYWU4TFZBVUhtQngxVksyaXpmdWg0dmZ4RC8rQTRXRzJN?=
 =?utf-8?B?Y1BmbktqTk1tV1dORHBFNkREb0pPVG5DZk90MHRmTllCbjh0WlgrbGNqcFNT?=
 =?utf-8?B?clZTRk43TnFYby9nczJ2Mm9OWmVEd0lhamp0d1BvdzRhRS8zU0cxeDN0WXdu?=
 =?utf-8?B?TFl0T3B3cHVjTlB1OWNOSjlGdTlzbjBUQ0QyMHJGdGV3K2NIL3FWMHZ4U3ZY?=
 =?utf-8?B?RUU3Z3NQTWVvdzViaXFHQzIwcFBHK2d6RmRVVDN6RU9WaDhkcmVKeXd4TDF6?=
 =?utf-8?B?UGlBN2NnSnU4WEdRaGNNZ3dUQzc0VWRycXR0VE0zWGhadlRVSzJaUytma1By?=
 =?utf-8?B?Z3JROVpVeCtkQ3B6dGozTHdNWGcwL1dJaHVRNjBNUWkrMTRMV2hHbWZiSDM1?=
 =?utf-8?B?aDIyTmFsQnlaOThlR1drYzE5em9KT1R5dHkxeG9MUzJORXA1QVczaE1ndmpo?=
 =?utf-8?B?Q3J5Z3lGeEtZbitXNTY2ZVFvNmNrUXlWQ1grMllDSDhZbFgzWUx5WEJFWHhJ?=
 =?utf-8?B?K0JNdVBDSW5TdVdUUVBEdG9jc2psQjJ4YUFBdXdacGhCUXNSOTgrUkxnejZh?=
 =?utf-8?B?MVZFV1gyNkxsdWQ4NkQ5dU81bk1wUXhkbXhyWlk1bGVxK1QvNkRlNHIydnJN?=
 =?utf-8?B?aXgvZ0g3VlU2S2hRVy9KOS9pcjBtMmtSQzlXMHcreThaQWxTUFlqU1B6UEI3?=
 =?utf-8?B?Z2hGTjlmRFQ3T0QzTFlyRUxKUkJ6MHcxdDErZnZpVEJXc0FpVFRSbHZEZVBD?=
 =?utf-8?B?b3F2bS9XTUFNMDFMVzZCeWFrVlhXdXJ5SGhWb3ZIZjNmN1M2cGo2dE1CUXNr?=
 =?utf-8?B?SmViUUhUS3k2MUVhRmRVdGJqeUl4SERIRCtFb3NaZXI0RHJnV0JsVzdIaWhJ?=
 =?utf-8?B?bldVMmg1RlIrUGZpdmJQc0thd1o1WDhnc2ZNeTJjRllXVlRBaWI5bE1qaTY5?=
 =?utf-8?B?QllsMndrT2V6bllnVFo0U28xVmRoMnJPNEhwc21hdVNHbkZpcFJzbnZCOXR0?=
 =?utf-8?B?SEZhTHRQbElYT01VZ2dnZHlFdjV4ZlhLQjdBN2tPSlhhYUlpUDdBUDRIdGta?=
 =?utf-8?B?VFg4MVlkb0swNnhuT3RQT2pZQlhSdWZUbGR0YWxHd0FaRVBEaFMxVGFHL3Jl?=
 =?utf-8?B?VUNWa2RubmV5OGNMRGw0TEJaVGNiQTljZ2Z4TCtjNmkyOFNqYVRRbENXMmV5?=
 =?utf-8?B?eXRpTzdoeWxmOUVra2ZDRFhla0Y0Qkt4OEE3M2JVcENZTSttVUFPNlJKanBy?=
 =?utf-8?Q?EnDRSp6ObptSTIeued?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 834cf38d-5dcf-4774-3816-08df34fbdcc4
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 14:00:45.6533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEA0tT6jgjPYraAphzrpc2pUlwFTVeC4E3IlrhME34Blv/Pj34xai6kKjyXpTK57
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999194
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 28-Oct-26 7:23 PM, Mukul Joshi wrote:
> 
> On 10/28/2026 2:23 AM, Lazar, Lijo wrote:
>>
>>
>> On 28-Oct-26 1:24 AM, Mukul Joshi wrote:
>>> In UALink loopback mode a single GPU acts as both the exporter and the
>>> importer, so the sender accel ID of a message depends on its direction.
>>>
>>> - Send HELLO as the opposite role of the destination: a message to the
>>>     exporter is sent as the importer and vice versa. Outside loopback
>>>     this is still the GPU's own accel ID.
>>>
>>> - The MP nHT stamps the IH cookie of every HW-delivered message with
>>>     the GPU ID of the single physical station, the exporter. The only HW
>>>     path is importer -> exporter, so attribute these messages to the
>>>     importer. SW-emulated exporter -> importer messages carry no IH ring
>>>     and already name the exporter as the sender.
>>>
>>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>>> ---
>>> v1->v2:
>>> - Use ualink_exp_accel_id/ualink_imp_accel_id() wrappers in
>>>     amdgpu_ualink_process_irq(). (Lijo)
>>>
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 32 +++++++++++++++++++++-
>>>    1 file changed, 31 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>> index 6c70be7badec..96a6023f51c5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>> @@ -1090,6 +1090,23 @@ static inline u32 ualink_imp_accel_id(struct
>>> amdgpu_device *adev)
>>>        return adev->ualink.info->ppod.accel_id;
>>>    }
>>>    +/*
>>> + * amdgpu_ualink_local_sender_accel_id - sender accel_id for an
>>> outgoing message
>>> + *
>>> + * Normally a GPU sends messages as its own (single) accelerator. In
>>> loopback
>>> + * mode the same GPU plays both roles, so the sender identity
>>> depends on the
>>> + * destination: a message to the exporter is sent as the importer
>>> and vice
>>> + * versa. Outside loopback both roles collapse to the GPU's own
>>> accel_id.
>>> + */
>>> +static u32 amdgpu_ualink_local_sender_accel_id(struct amdgpu_device
>>> *adev,
>>> +                           u32 remote_acc_id)
>>> +{
>>> +    if (remote_acc_id == ualink_exp_accel_id(adev))
>>
>> +#define AMDGPU_UALINK_LOOPBACK_EXPORTER_ACCID        1
>>
>> 1 is a possible id in a regular vpod config also. I think a check of
>> loopback mode also is required here.
> 
> We check loopback mode inside the helper, ualink_exp_accel_id().
> 

Thanks for clarifying. Adding a check may be a bit easier to read.

if (!loopback_mode)
	return adev->ualink.info->ppod.accel_id;

Thanks,
Lijo

> Thanks,
> 
> Mukul
> 
>>
>> Thanks,
>> Lijo
>>
>>> +        return ualink_imp_accel_id(adev);
>>> +
>>> +    return ualink_exp_accel_id(adev);
>>> +}
>>> +
>>>    static bool amdgpu_ualink_is_local_accel(struct amdgpu_device *adev,
>>>                         u32 accel_id)
>>>    {
>>> @@ -2238,7 +2255,10 @@ static int amdgpu_ualink_send_hello_msg(struct
>>> amdgpu_device *adev,
>>>          dw0 = AMDGPU_UALINK_HELLO_MSG;
>>>        dw0 |= (remote_acc_id <<
>>> AMDGPU_UALINK_HELLO_MSG_RECV_ACCID_SHIFT);
>>> -    dw0 |= (adev->ualink.info->ppod.accel_id <<
>>> +    /* In loopback the sender is the opposite role of the
>>> destination, so
>>> +     * the exporter side tracks the connection under the importer
>>> accel_id.
>>> +     */
>>> +    dw0 |= (amdgpu_ualink_local_sender_accel_id(adev, remote_acc_id) <<
>>>            AMDGPU_UALINK_HELLO_MSG_SENDER_ACCID_SHIFT);
>>>          dev_dbg(adev->dev, "SEND HELLO: HELLO message to remote
>>> AccId:%u\n",
>>> @@ -6548,6 +6568,16 @@ static int amdgpu_ualink_process_irq(struct
>>> amdgpu_device *adev,
>>>            return handled;
>>>        }
>>>    +    /* UALink loopback: the MP nHT stamps every HW-delivered
>>> message with
>>> +     * the GPU ID of the single physical station, the exporter. The
>>> only
>>> +     * HW path is importer -> exporter, so the real sender is the
>>> importer.
>>> +     * SW-emulated exporter -> importer messages carry no IH ring and
>>> +     * already name the exporter as sender.
>>> +     */
>>> +    if (adev->ualink.loopback.enabled && entry->ih &&
>>> +        src_acc_id == ualink_exp_accel_id(adev))
>>> +        src_acc_id = ualink_imp_accel_id(adev);
>>> +
>>>        msg_type = dw0 & AMDGPU_UALINK_MESSAGE_HEADER_MASK;
>>>        local_acc_id = adev->ualink.info->ppod.accel_id;
>>>        dev_dbg(adev->dev, "Got MSG: remote acc_id %u msg_type %u\n",
>>

