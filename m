Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4A0D3F2BF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 22:30:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7250810E08E;
	Fri, 18 Oct 2024 22:30:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="raEXYvie";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2270B10E08E
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 22:30:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3DzkRE4/Nck3mdjhdJdT2/gCT60lvwFJ4X3OFiw11t0za3ZC7ij7xIUZpDik0QwNO0JY273G22t7GRFPfCHmCJnl8Ir/H/MtPgwBriVpz2Dm79S1dM+CvDXRczu/hbOiNrwsyTdV8f0W7v6lrbliHG1I4g8FnwbE+6JaphstGA3LELLNwPPj7KW5zwboy0uVsRp4YwtvvsaqQQ1BAAM7srHHkamwPiY1HD892aM5SsouO4xCK5CoUCZHlp3NP4h14Q+QYE/1GGbsU0WB6rcpybht09gjWlZXi60D+cCuyBD1xBNKvncyIY5YQcg7ZD8zEL/63aiwbxZ7ns5ha2Teg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M30asFl9IxU8KdjxZUJkh6n0FDBYiqdHMQyJW3UTz6U=;
 b=gfLdnpc9vo3qSDPbTLdNk/KpoI9+0BrrRfW8Ze+Zpz/Um8oM6+F8jckCmv2qismjvVD/q7D4rtIHXMsWvzSBk2TO0ZANiPToxrmhTZNpyUBqD/Jttg2WIDmyIa6zl3QyaoyTgnudmngxUb1gHkOufw98j/Ep72PgY/kVJschwWYIEYn7FiazUdoir051kZYD6SqcAOI1bgZyagEiyUxPQHmp5+y1VJ7bnw9LwYuqwR98J51iGlFeRsGbZUV4YusI5H59HwjuW9RmugA0Y3SJ/uZxfNkK3MrtX0LR4hpFxxcHf9pFeCUSRPwf3XT9z5mI58d/pU+mJJrDCW2pbHcdZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M30asFl9IxU8KdjxZUJkh6n0FDBYiqdHMQyJW3UTz6U=;
 b=raEXYvievuewmivxRzg2kFVeAMVG1TD2zB2NLHKpVSarbeM7PfsDdfIDA/6awFuQBbZMUIoGGHYJz/B0ota3BsAJ5Nkt4Z5tUnoLnv6sUA4dAPj0QNh8eDlm/G2udFvPnk7zHQRHNabrlV2ywzmFIZ/oXpGDOk9/FJX0z38TtSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 CH3PR12MB9217.namprd12.prod.outlook.com (2603:10b6:610:195::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 22:30:04 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 22:30:04 +0000
Message-ID: <9f820154-6c5b-4a30-b9e4-1092d1e5df4f@amd.com>
Date: Fri, 18 Oct 2024 17:30:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Add kfd driver function to support hot
 plug/unplug amdgpu devices
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com, christian.koenig@amd.com
References: <20241015212139.63500-1-xiaogang.chen@amd.com>
 <003ddddb-9a6b-4e62-9980-da923f7b889f@amd.com>
 <32f7690e-f379-4f28-b747-2d0f59a5156c@amd.com>
 <35f6c795-66a6-4c9c-ba8c-df47242a783e@amd.com>
 <acea0adb-b21b-4e90-848a-2309293b4183@amd.com>
 <f85de278-e7a7-4740-9d74-599aec77bec7@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <f85de278-e7a7-4740-9d74-599aec77bec7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0191.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::16) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|CH3PR12MB9217:EE_
X-MS-Office365-Filtering-Correlation-Id: 00888a54-a56c-4602-88d5-08dcefc4695e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFhHY093ZlliWDBocDVZdFJQSzRzRElISWZUc0FJRnpxOWZOcnMzMFRza2t4?=
 =?utf-8?B?N0VXRUFXR2ptR0Zwd1FOb3gzcXZ0ZEs2UEVCSTZoclhzZ3phWlNDWjNiRHha?=
 =?utf-8?B?WnZPeWdJS3c4c3JCZkJNc2VRWXZPanBpTTVWaG1CNlVRQzdJT0ZlRGpWWURU?=
 =?utf-8?B?SnErWVZDZlphRWlGN3lFdDBnUEUxRUxzL29JVmYwR3FHc0s1VTJNS1VRL1Q2?=
 =?utf-8?B?K1MwZlpjZ1hZM2RvOHlUVTNlbDZDamF2L2RJbjE5UVgxSWlqQ2lobXlmRERm?=
 =?utf-8?B?Ky9DSUhTVloramJnaFdFaVI3U2xrOUFndnlWL09TemExdEt6RHJ6R24zOXNQ?=
 =?utf-8?B?OXNIYjl1bVU4UVpYSWxSa1k3bmFjUmFoVWo2M0o1Tzl2RlNUYlZ0SzRZY2RK?=
 =?utf-8?B?U1RxZGFNMFlSR0NwYVhLdE5qSlR5VjJ1TVludjlmZklxOXhEc1FQK0l4U25J?=
 =?utf-8?B?MVcrUGM3aWM3VDJWSWNNV3ZnNy9JbWtyVmdEL09RR0FhRGRxSXVieEpDZEhi?=
 =?utf-8?B?cVNDZHlZL2tqRnBzV0tGck5JR0xqUXNkQzNDc0FjUE1Ha3J2MnZ4UzIrakV5?=
 =?utf-8?B?OVIyam5mSC9IMDMveHJZMzV0STMxam5Hby9UcG1HTVlwVWNVMFdvSDFmRHI1?=
 =?utf-8?B?elVORDd3OFVOK1BXeE1ac21CVXFjREMyM2pWM09NQnhjdHNQdlZIdWpQRlFC?=
 =?utf-8?B?NlR6LzlzUzBSWFl3YUtEb1MwbnIzMHBSVDNJMThyaWs3NGxuaXN2TUtDK3li?=
 =?utf-8?B?MFBEdDR6YTZUMG51Z2g4SnB3VkVNNmFjVUNRNVM3TWRzMmJWbytZcEhveCtG?=
 =?utf-8?B?UDNldUYzUFdocFVwOTRUaXJYZGpjWTdZdHNJZ1BFSGYxREEvWWdvRXA0ZGZX?=
 =?utf-8?B?eFVpd2dRQ3NSQ21aVHNRdGpIWVZxYVZ2dW1odzg2cTVjbzZyM1lyZEt3VWs5?=
 =?utf-8?B?bGpObDJpSXpLcXhDcFI2S2RXMFVWdnBKTzlwc01NOFRXVVk3bHpFVnNudFF0?=
 =?utf-8?B?VkFkOHpzSjhyd3Z6eWdNam9YQVdRRW1xTWV6OUlTemF3STNaRkpHQllwejBN?=
 =?utf-8?B?SDJCZnpiQi9Fc0xzME1jejFtOXF0YkFjWjRSdTFWT2lWT3dZQmNoNHM0czcr?=
 =?utf-8?B?eTFPRkh2ZENmVm1RaXRHT0pNdzZPNDFFQWxDYmd6N1lEdjNKY2xkbVo5UEJp?=
 =?utf-8?B?TnRBWjVNdnRHU1gxRFJ3bFNmOUhKSi8wcnlXZ2J0eHJ2YWJMVDJqMUZxNzky?=
 =?utf-8?B?b2x1czJyK0REUk5HQjQ5ckIvTi92UTZxd2tlYkgvcVdwUGRvelh2R2t6emw1?=
 =?utf-8?B?WE4vSEVMY3FzUmVuTU54MENKQmNmbmdPSEFQblNRcCtZbmx5eFpyOWNDL0Vm?=
 =?utf-8?B?Z1RIQVZBTzhkenlNSEQwRnhxcHJNMCtaSEkxaXN2dEozWHVkdE1yMGxYamI5?=
 =?utf-8?B?Tk1FUzc1YitHOStIbzArNVdJbGhxWE9LQ202YUUyS2tlZ2xyd0hDNlQ0UmhN?=
 =?utf-8?B?TEZKMDRWTXdSTGpMRW5aVitRUmRXSzd1akpxWlVFVkhDcWxmRHk2ZW9obkoz?=
 =?utf-8?B?MWFIMis0b2FFdkFHdUtWaDBKMXA3QkFNSnZOVlQ5KzBrWE1CcHg5L1Y2ejdX?=
 =?utf-8?B?Mm5nMnNSODhJQzhjM3hQMkJiMGJBT3hXS1cwRFFlNC9KOTJ6VXZRNllXVEhW?=
 =?utf-8?B?YlpacC8vOHlMRGQvTHVwaVZVTnRleWxaWHg0aWpoU1NrdDI5TmVESVh4K01s?=
 =?utf-8?Q?ZxyptMQ5X4wzGa0uqcxFMTTx71BWOvJTuBiDU2e?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0I3T3dLcnBxVTZibGJORk5Uc0xvZW13REtscW4vR3FmQ0xGZGc0RS9Icm9o?=
 =?utf-8?B?SitVQ1g3RUh5VTVWNEJWdTVnb1pKNXpWOWJOTlU4L1ZXQWwzcnJxeWN6STRX?=
 =?utf-8?B?WFROR1g1OVlLU09zTnhnSTgzaXRLZ2tGbENXUkdCUEErTDg3ak9WdU51M1JI?=
 =?utf-8?B?WjIwUUFJZDZOajJpQlYzallibDZ0akJrUzRSOWo3VDU3ZkdyWndiUTRjSGRu?=
 =?utf-8?B?cTJZKzRxZUFhUEhZRmFudUJQckg4a0kvSmtXTFhsZVA5YlNvUEkva0FQeTB2?=
 =?utf-8?B?NXBXSEFkNERuTkg4cGFuZC9Cby9qSGlCaFY0cWdEeTMwaDlUL3AyNzJFdkM2?=
 =?utf-8?B?UEFLbGdPbkVlNmZWTkQ5R253NXpvRjVUb3RZQ2Y5bmdCV3hmUEd4QkFsdEhO?=
 =?utf-8?B?ckFQSndMbnZiWitrYkF6aXVyWmRtVnp3NWw5VjZUU1AvWlY5NUliYllxa0tN?=
 =?utf-8?B?OHhRa2RiaXZoQlFnWUdrWEhrWWc1MkFORU1FVkR3ZTc5M3JkN0w2bjFwM250?=
 =?utf-8?B?NVMxbUxPMmE4dDhIMEtjcC9IZlVEK3I2RHNSUlBzWEwzaW5wQVd0VFl3RHJv?=
 =?utf-8?B?Rjc5ajNhVEFWSW11MXpxWDdrV3Z4Rkx4Q1pSdmJFZGVMVFVaaDQwRTFTblRD?=
 =?utf-8?B?bWNVYkNleDZLaGJVYUFvaHA3UlF6TmxsQU5OUWZWRG1vaTBwWlpJdEVzdWxp?=
 =?utf-8?B?ekR1ak5zSHZJb1JmR1hkRDFvVU9ZL3UySXRHTTkxUlVxSDB1ZWZ2N29ReHYr?=
 =?utf-8?B?MW9KVFZ0TVdTNDN3c25yTUdoUy9WV2RGZkIrc0cySFkrS3VJTVRhUEhqVnFL?=
 =?utf-8?B?QlRIamQ1SUtBeG8yNEdFd1poUm1ybGFXU1VaOWVESCs3NW1RNTZIL0xMWWNC?=
 =?utf-8?B?dU9lVFJKSmpWREZEM3NrWVpXSjdFQlA4RnFDb1dPSXhUWHpRUnViTE9lOVNx?=
 =?utf-8?B?eFVubWlPZldWT0FIRmRkbFgxaHhndXNLNXVaeUtzdnM2bDJxV0NWWGR0R1dF?=
 =?utf-8?B?NGF2N0MzSjNsaDdqcHpFRjFMZk5mMFg0TWVqQVB4ejIzUjhyWFowMzQ0Nytl?=
 =?utf-8?B?bWNNTGZLU3FaTG9LZGUwWEZsMzNqM3VqMjl4QkJEK3VRNkJxWjZjRm81OW5j?=
 =?utf-8?B?bGhIcC9hSXBDcG0xSEV4RzNpNlV6L0NrNjJUdzZZNUwyUUFmL3dIN04wbk1G?=
 =?utf-8?B?SDNCVU16ZTgwN0FabCtMODZhZThYWmFYdlRzS3NxZGY5bi9NSDlnT3N0V3RZ?=
 =?utf-8?B?VUdYcmR2Y0tpaVR6SFl0REJOT1V6elFpalNEK0RTbVNWcm1wNlF6Qmc2Q080?=
 =?utf-8?B?cy8xQkd1ZFRWK3pNUHV5M0ZoVlIvMEl6V1JaTklpbTBLZFRtYWtCRXc1SElv?=
 =?utf-8?B?TWlTQWNhVlJITjA5MnFwZmV2dU9sMWpPQWJFL0hTQWRKdCs3SnlhYmhiQ3VR?=
 =?utf-8?B?TXloWldQL095aVdMYkFKdlpZRXVheFZDWUppVE15ekhRc05QSm0wMUFsNk55?=
 =?utf-8?B?Rkt2elJXK3k2QXhwSlhnZ3RGMkFYcWpHUkVQZXJ4VGlMbEp0MlBCSjFSZm1w?=
 =?utf-8?B?Q3dicnpzTnIrYjk1ZEJPdGJ3NWRsUXFiZUF3YmVkMVA2Sk5OZWdQM0g5YWs4?=
 =?utf-8?B?VkhJL1VhU1N3VW5BRE4zaTJFUVRtZDQ5TkRRdU93cFhuUUdXejIyandsRngw?=
 =?utf-8?B?YUZmWGNBeVlYRnpOWjRoZ0x2QnNFTzRVTEtoSGk2QTZPWHRNUTdrZDZtTXI3?=
 =?utf-8?B?ek9iNVRJRGlXQzJJUWsrc0sxcmI2b2Q1UXNWQU42Tm56SUFUNjZvTW9wL1hS?=
 =?utf-8?B?SDVMUmhzZm43TEY5V2lsTEhuSHVzVk53SDA5U2VsSldwUmhrSS9XcmJxWEpv?=
 =?utf-8?B?WENMY2lwV2N5UnVaMUVadExTNFFMbmc0OFdIZ29IRzNJajNpdUdqdWVpakt1?=
 =?utf-8?B?dWJZQnNjTDdUQVR2RUR1dnA1SUFhRzNscmdBbmtkdVQ3NzQrVWRvbXRJUzJL?=
 =?utf-8?B?Q3kyd0RNQ2FBNm5wQWpDcFR1NVNDWWFWd2dUNTd2dERkSnU0dXAvS1FYLzQy?=
 =?utf-8?B?eXhsQTB0bjVkd3dyMEtQbDF0czNzT3ZpbHNTcFdoMHh3Zytya25LTXUzdjV1?=
 =?utf-8?Q?vAUI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00888a54-a56c-4602-88d5-08dcefc4695e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 22:30:04.2448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsEhF1OePCKgl3o+3f0oXpgPMyT8X0BhCNx/YuxmMzsM1TbxXChQ5DFsUJUBvzvj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9217
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


On 10/18/2024 5:09 PM, Felix Kuehling wrote:
>
> On 2024-10-18 17:31, Chen, Xiaogang wrote:
>>
>> On 10/18/2024 12:57 PM, Felix Kuehling wrote:
>>>
>>> On 2024-10-18 10:09, Chen, Xiaogang wrote:
>>>>
>>>> On 10/17/2024 4:04 PM, Felix Kuehling wrote:
>>>>>
>>>>> On 2024-10-15 17:21, Xiaogang.Chen wrote:
>>>>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>>>>
>>>>>> The purpose of this patch is having kfd driver function as 
>>>>>> expected during AMD
>>>>>> gpu device plug/unplug.
>>>>>>
>>>>>> When an AMD gpu device got unplug kfd driver stops all queues 
>>>>>> from this device.
>>>>>> If there are user processes still ref the render node this device 
>>>>>> is marked as
>>>>>> invalid. kfd driver will return error to following requests to 
>>>>>> the device from
>>>>>> all existing user processes. Existing user processes can still 
>>>>>> use remaining
>>>>>> gpu devices during/after unplug event.
>>>>>>
>>>>>> After all refs to the device have been closed from user space kfd 
>>>>>> driver
>>>>>> topology got updated by removing correspodent kfd nodes.
>>>>>>
>>>>>> User space can use remaining gpu devices that are valid at same 
>>>>>> time. When all
>>>>>> AMD gpu devices got removed kfd driver will not allow open 
>>>>>> /dev/kfd request.
>>>>>>
>>>>>> Unplugged AMD gpu devices can be re-plugged. kfd driver will use 
>>>>>> added devices
>>>>>> and function as usual.
>>>>>>
>>>>>> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  5 ++
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  7 ++
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  3 +-
>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 78 
>>>>>> +++++++++++++++++++
>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 43 ++++++++++
>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  6 ++
>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  7 ++
>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 13 +++-
>>>>>>   .../amd/amdkfd/kfd_process_queue_manager.c    | 24 ++++++
>>>>>>   9 files changed, 183 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>> index b545940e512b..651ae0775f80 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>> @@ -248,6 +248,11 @@ void amdgpu_amdkfd_interrupt(struct 
>>>>>> amdgpu_device *adev,
>>>>>>           kgd2kfd_interrupt(adev->kfd.dev, ih_ring_entry);
>>>>>>   }
>>>>>>   +void amdgpu_amdkfd_teardown_kfd_device(struct kfd_dev *kfd)
>>>>>> +{
>>>>>> +       kgd2kfd_teardown_kfd_device(kfd);
>>>>>> +}
>>>>>> +
>>>>>>   void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool 
>>>>>> run_pm)
>>>>>>   {
>>>>>>       if (adev->kfd.dev)
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>> index 7e0a22072536..bd241f569b79 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>> @@ -152,6 +152,7 @@ struct amdkfd_process_info {
>>>>>>     int amdgpu_amdkfd_init(void);
>>>>>>   void amdgpu_amdkfd_fini(void);
>>>>>> +void amdgpu_amdkfd_teardown_kfd_device(struct kfd_dev *kfd);
>>>>>>     void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool 
>>>>>> run_pm);
>>>>>>   int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
>>>>>> @@ -431,6 +432,7 @@ int kgd2kfd_check_and_lock_kfd(void);
>>>>>>   void kgd2kfd_unlock_kfd(void);
>>>>>>   int kgd2kfd_start_sched(struct kfd_dev *kfd, uint32_t node_id);
>>>>>>   int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id);
>>>>>> +void kgd2kfd_teardown_kfd_device(struct kfd_dev *kfd);
>>>>>>   #else
>>>>>>   static inline int kgd2kfd_init(void)
>>>>>>   {
>>>>>> @@ -511,5 +513,10 @@ static inline int kgd2kfd_stop_sched(struct 
>>>>>> kfd_dev *kfd, uint32_t node_id)
>>>>>>   {
>>>>>>       return 0;
>>>>>>   }
>>>>>> +
>>>>>> +void kgd2kfd_teardown_processes(void)
>>>>>> +{
>>>>>> +}
>>>>>> +
>>>>>>   #endif
>>>>>>   #endif /* AMDGPU_AMDKFD_H_INCLUDED */
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> index 1e47655e02c6..4529d7a88b98 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> @@ -3315,7 +3315,8 @@ static int 
>>>>>> amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
>>>>>>       amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>>>>>>       amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>>>>>>   -    amdgpu_amdkfd_suspend(adev, false);
>>>>>> +    if (adev->kfd.dev)
>>>>>> + amdgpu_amdkfd_teardown_kfd_device(adev->kfd.dev);
>>>>>>         /* Workaroud for ASICs need to disable SMC first */
>>>>>>       amdgpu_device_smu_fini_early(adev);
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>>> index a1f191a5984b..d246f72ae0e9 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>>> @@ -327,6 +327,13 @@ static int kfd_ioctl_create_queue(struct 
>>>>>> file *filep, struct kfd_process *p,
>>>>>>           err = -EINVAL;
>>>>>>           goto err_pdd;
>>>>>>       }
>>>>>> +
>>>>>> +    if (!is_kfd_process_device_valid(pdd)) {
>>>>>> +        pr_debug("gpu 0x%x is not available\n", args->gpu_id);
>>>>>> +        err = -EINVAL;
>>>>>> +        goto err_pdd;
>>>>>> +    }
>>>>>> +
>>>>>
>>>>> Instead of duplicating this in all the ioctl functions, could this 
>>>>> check be done in kfd_process_device_data_by_id?
>>>>
>>>> Yes, that makes code simpler. Also, need add same check on 
>>>> kfd_get_process_device_data.
>>>
>>> Maybe not. kfd_get_process_device_data gets a kfd_node as parameter, 
>>> that callers typically get from get from a call to kfd_device_by_id. 
>>> Maybe the check should be in kfd_get_device_by_id so it doesn't 
>>> return invalid devices.
>>
>> kfd_get_process_device_data is used by queue operations. They use 
>> "dev = pqn->q->device" to locate kfd node from queue structure, not 
>> kfd_device_by_id. Then locate pdd.
>>
>> and yes,  at kfd_device_by_id we also need check returned 
>> dev->kfd->valid.
>>
>> dev->kfd->valid means this kfd device cannot be used now(or being 
>> removed). Its resources(kfd_dev, kfd_node) are not released yet until 
>> user apps release all refs to the adev.
>>
>>>
>>>
>>>>
>>>>>
>>>>>
>>>>>>       dev = pdd->dev;
>>>>>>         pdd = kfd_bind_process_to_device(dev, p);
>>>>>> @@ -578,6 +585,12 @@ static int 
>>>>>> kfd_ioctl_set_memory_policy(struct file *filep,
>>>>>>           goto err_pdd;
>>>>>>       }
>>>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>>>> +        pr_debug("gpu 0x%x is not available\n", args->gpu_id);
>>>>>> +        err = -EINVAL;
>>>>>> +        goto err_pdd;
>>>>>> +    }
>>>>>> +
>>>>>>       pdd = kfd_bind_process_to_device(pdd->dev, p);
>>>>>>       if (IS_ERR(pdd)) {
>>>>>>           err = -ESRCH;
>>>>>> @@ -621,6 +634,11 @@ static int kfd_ioctl_set_trap_handler(struct 
>>>>>> file *filep,
>>>>>>           goto err_pdd;
>>>>>>       }
>>>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>>>> +        err = -EINVAL;
>>>>>> +        goto err_pdd;
>>>>>> +    }
>>>>>> +
>>>>>>       pdd = kfd_bind_process_to_device(pdd->dev, p);
>>>>>>       if (IS_ERR(pdd)) {
>>>>>>           err = -ESRCH;
>>>>>> @@ -704,6 +722,9 @@ static int 
>>>>>> kfd_ioctl_get_process_apertures(struct file *filp,
>>>>>>       for (i = 0; i < p->n_pdds; i++) {
>>>>>>           struct kfd_process_device *pdd = p->pdds[i];
>>>>>>   +        if (!is_kfd_process_device_valid(pdd))
>>>>>> +            continue;
>>>>>> +
>>>>>>           pAperture =
>>>>>> &args->process_apertures[args->num_of_nodes];
>>>>>>           pAperture->gpu_id = pdd->dev->id;
>>>>>> @@ -779,6 +800,9 @@ static int 
>>>>>> kfd_ioctl_get_process_apertures_new(struct file *filp,
>>>>>>       for (i = 0; i < min(p->n_pdds, args->num_of_nodes); i++) {
>>>>>>           struct kfd_process_device *pdd = p->pdds[i];
>>>>>>   +        if (!is_kfd_process_device_valid(pdd))
>>>>>> +            continue;
>>>>>> +
>>>>>>           pa[i].gpu_id = pdd->dev->id;
>>>>>>           pa[i].lds_base = pdd->lds_base;
>>>>>>           pa[i].lds_limit = pdd->lds_limit;
>>>>>> @@ -901,6 +925,11 @@ static int 
>>>>>> kfd_ioctl_set_scratch_backing_va(struct file *filep,
>>>>>>           goto bind_process_to_device_fail;
>>>>>>       }
>>>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>>>> +        err = PTR_ERR(pdd);
>>>>>> +        goto bind_process_to_device_fail;
>>>>>> +    }
>>>>>> +
>>>>>>       pdd->qpd.sh_hidden_private_base = args->va_addr;
>>>>>>         mutex_unlock(&p->mutex);
>>>>>> @@ -981,6 +1010,11 @@ static int kfd_ioctl_acquire_vm(struct file 
>>>>>> *filep, struct kfd_process *p,
>>>>>>           goto err_pdd;
>>>>>>       }
>>>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>>>> +        ret = -EINVAL;
>>>>>> +        goto err_pdd;
>>>>>> +    }
>>>>>> +
>>>>>>       if (pdd->drm_file) {
>>>>>>           ret = pdd->drm_file == drm_file ? 0 : -EBUSY;
>>>>>>           goto err_drm_file;
>>>>>> @@ -1031,6 +1065,10 @@ static int 
>>>>>> kfd_ioctl_get_available_memory(struct file *filep,
>>>>>>         if (!pdd)
>>>>>>           return -EINVAL;
>>>>>> +
>>>>>> +    if (!is_kfd_process_device_valid(pdd))
>>>>>> +        return -EINVAL;
>>>>>> +
>>>>>>       args->available = 
>>>>>> amdgpu_amdkfd_get_available_memory(pdd->dev->adev,
>>>>>>                               pdd->dev->node_id);
>>>>>>       kfd_unlock_pdd(pdd);
>>>>>> @@ -1090,6 +1128,11 @@ static int 
>>>>>> kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>>>>>>           goto err_pdd;
>>>>>>       }
>>>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>>>> +        err = -EINVAL;
>>>>>> +        goto err_pdd;
>>>>>> +    }
>>>>>> +
>>>>>>       dev = pdd->dev;
>>>>>>         if ((flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) &&
>>>>>> @@ -1202,6 +1245,12 @@ static int 
>>>>>> kfd_ioctl_free_memory_of_gpu(struct file *filep,
>>>>>>           goto err_pdd;
>>>>>>       }
>>>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>>>> +        pr_err("Process device is not valid\n");
>>>>>> +        ret = -EINVAL;
>>>>>> +        goto err_pdd;
>>>>>> +    }
>>>>>> +
>>>>>>       mem = kfd_process_device_translate_handle(
>>>>>>           pdd, GET_IDR_HANDLE(args->handle));
>>>>>>       if (!mem) {
>>>>>> @@ -1266,6 +1315,12 @@ static int 
>>>>>> kfd_ioctl_map_memory_to_gpu(struct file *filep,
>>>>>>           err = -EINVAL;
>>>>>>           goto get_process_device_data_failed;
>>>>>>       }
>>>>>> +
>>>>>> +    if (!is_kfd_process_device_valid(pdd)) {
>>>>>> +        err = -EINVAL;
>>>>>> +        goto get_process_device_data_failed;
>>>>>> +    }
>>>>>> +
>>>>>>       dev = pdd->dev;
>>>>>>         pdd = kfd_bind_process_to_device(dev, p);
>>>>>> @@ -1384,6 +1439,11 @@ static int 
>>>>>> kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>>>>>>           goto bind_process_to_device_failed;
>>>>>>       }
>>>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>>>> +        err = -EINVAL;
>>>>>> +        goto bind_process_to_device_failed;
>>>>>> +    }
>>>>>> +
>>>>>>       mem = kfd_process_device_translate_handle(pdd,
>>>>>> GET_IDR_HANDLE(args->handle));
>>>>>>       if (!mem) {
>>>>>> @@ -1567,6 +1627,11 @@ static int kfd_ioctl_import_dmabuf(struct 
>>>>>> file *filep,
>>>>>>           goto err_unlock;
>>>>>>       }
>>>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>>>> +        r = PTR_ERR(pdd);
>>>>>> +        goto err_unlock;
>>>>>> +    }
>>>>>> +
>>>>>>       r = amdgpu_amdkfd_gpuvm_import_dmabuf_fd(pdd->dev->adev, 
>>>>>> args->dmabuf_fd,
>>>>>>                            args->va_addr, pdd->drm_priv,
>>>>>>                            (struct kgd_mem **)&mem, &size,
>>>>>> @@ -1616,6 +1681,11 @@ static int kfd_ioctl_export_dmabuf(struct 
>>>>>> file *filep,
>>>>>>           goto err_unlock;
>>>>>>       }
>>>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>>>> +        ret = -EINVAL;
>>>>>> +        goto err_unlock;
>>>>>> +    }
>>>>>> +
>>>>>>       mem = kfd_process_device_translate_handle(pdd,
>>>>>> GET_IDR_HANDLE(args->handle));
>>>>>>       if (!mem) {
>>>>>> @@ -1660,6 +1730,9 @@ static int kfd_ioctl_smi_events(struct file 
>>>>>> *filep,
>>>>>>       if (!pdd)
>>>>>>           return -EINVAL;
>>>>>>   +    if (!is_kfd_process_device_valid(pdd))
>>>>>> +        return -EINVAL;
>>>>>> +
>>>>>>       return kfd_smi_event_open(pdd->dev, &args->anon_fd);
>>>>>>   }
>>>>>>   @@ -2990,6 +3063,11 @@ static int 
>>>>>> kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process 
>>>>>> *p, v
>>>>>>               r = -ENODEV;
>>>>>>               goto unlock_out;
>>>>>>           }
>>>>>> +
>>>>>> +        if (!is_kfd_process_device_valid(pdd)) {
>>>>>> +            r = -ENODEV;
>>>>>> +            goto unlock_out;
>>>>>> +        }
>>>>>>       }
>>>>>>         switch (args->op) {
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>> index fad1c8f2bc83..019567249110 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>> @@ -893,6 +893,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>>>>>       svm_range_set_max_pages(kfd->adev);
>>>>>>         kfd->init_complete = true;
>>>>>> +    kfd->valid = true;
>>>>>>       dev_info(kfd_device, "added device %x:%x\n", 
>>>>>> kfd->adev->pdev->vendor,
>>>>>>            kfd->adev->pdev->device);
>>>>>>   @@ -919,6 +920,10 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>>>>>     void kgd2kfd_device_exit(struct kfd_dev *kfd)
>>>>>>   {
>>>>>> +    struct kfd_process *p;
>>>>>> +    unsigned int i, j;
>>>>>> +    unsigned int temp;
>>>>>> +
>>>>>>       if (kfd->init_complete) {
>>>>>>           /* Cleanup KFD nodes */
>>>>>>           kfd_cleanup_nodes(kfd, kfd->num_nodes);
>>>>>> @@ -929,6 +934,20 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>>>>>>           amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
>>>>>>       }
>>>>>>   +    /* now this kfd_dev has been completely removed from kfd 
>>>>>> driver
>>>>>> +     * before kfree kfd iterate all existing kfd processes, if 
>>>>>> kfd process
>>>>>> +     * uses any kfd node from this kfd set its ref to NULL
>>>>>> +     */
>>>>>> +    hash_for_each_rcu(kfd_processes_table, temp, p, 
>>>>>> kfd_processes) {
>>>>>> +        for (i = 0; i < kfd->num_nodes; i++)
>>>>>> +            for (j = 0; j < p->n_pdds; j++) {
>>>>>> +                if (kfd->nodes[i] == p->pdds[j]->dev) {
>>>>>> +                    p->pdds[j]->dev = NULL;
>>>>>
>>>>> Could this be done in teardown_kfd_device? Then you may not need a 
>>>>> separate "valid" for is_kfd_process_device_valid. And any 
>>>>> accidental access to a device associated with an invalid pdd would 
>>>>> automatically trigger a kernel error message with a backtrace.
>>>>
>>>> At teardown_kfd_device the adev has not been removed, ex: there are 
>>>> user apps still refer the render node. kfd dev(kfd nodes) is 
>>>> released at kfd_cleanup_nodes of kgd2kfd_device_exit when all ref 
>>>> to adev got released(user apps close render node). During that time 
>>>> kfd nodes(pdd->dev) are valid. We still can access kfd nodes data 
>>>> structure though their queues got stopped and kfd_node->kfd has 
>>>> been markded as invalid.
>>>
>>> I'm not sure why that matters. The fact that the there are still 
>>> other pointers to the dev doesn't mean the pointer in the pdd must 
>>> remain valid.
>>>
>> Ex: when kfd process is released we call 
>> kfd_process_dequeue_from_all_devices to terminate all queues(the 
>> queues have been stopped after unplug the adev), we use pdd->dev to 
>> locate kfd node for following "Clears all process queues belongs to 
>> that device"
>>
>> At teardown_kfd_device the kfd dev(its kfd nodes) has not been 
>> released. keeping pdd->dev is convenient when need locate the kfd dev 
>> from pdd. Otherwise we need use other ways to locate kfd node.
>>
>>> On the other hand, there should be code in 
>>> kgd2kfd_teardown_kfd_device or kgd2kfd_device_exit to clean up _all_ 
>>> the other pointers to the invalid kfd_dev and kfd_nodes. AFAICT the 
>>> kfd_dev and kfd_nodes are not reference counted, and there is no 
>>> guarantee that these structures still exist by the time the 
>>> processes terminate and run their cleanup code. You can't rely on 
>>> kfd_dev->valid after the kfd_dev itself has been freed with kfree in 
>>> kgd2kfd_device_exit. By that time all pointers to the kfd_dev and 
>>> its nodes must have been cleaned up.
>>>
>>> A quick survey of the header files shows
>>>
>>>  * kfd_dev pointers in kfd_node, kfd_device_queue_manager
>>>  * kfd_node pointers in kfd_dev, kfd_bo, queue, kernel_queue,
>>>    kfd_process_device, kfd_*_properties referenced in lists in
>>>    kfd_topology_device, svm_range_bo, mqd_manager
>> I had same thought when did it. Here all queues on this kfd dev are 
>> stopped at first, and all kfd nodes from kfd dev got marked as 
>> invalid, so not serve any new request on these kfd nodes at api 
>> level. Any existing operations that use kfd node check if it is valid.
>>>
>>>
>>>>
>>>>>
>>>>>
>>>>>> +                    break;
>>>>>> +                }
>>>>>> +            }
>>>>>> +    }
>>>>>> +
>>>>>>       kfree(kfd);
>>>>>>   }
>>>>>>   @@ -1485,6 +1504,30 @@ int kgd2kfd_stop_sched(struct kfd_dev 
>>>>>> *kfd, uint32_t node_id)
>>>>>>       return node->dqm->ops.halt(node->dqm);
>>>>>>   }
>>>>>>   +/* tear down this kfd deve */
>>>>>> +void kgd2kfd_teardown_kfd_device(struct kfd_dev *kfd)
>>>>>> +{
>>>>>> +    struct kfd_process *p;
>>>>>> +    struct kfd_node *dev;
>>>>>> +    unsigned int i;
>>>>>> +    unsigned int temp;
>>>>>> +
>>>>>> +    kfd->valid = false;
>>>>>> +    /* stop queues from kfd nodes in this kfd dev */
>>>>>> +    for (i = 0; i < kfd->num_nodes; i++) {
>>>>>> +        dev = kfd->nodes[i];
>>>>>> +        dev->dqm->ops.stop(dev->dqm);
>>>>>> +    }
>>>>>
>>>>> If the GPU was unplugged already, what's the point of this? Won't 
>>>>> this trigger a timeout?
>>>>>
>>>> pci base driver will find that the device has been unplugged, will 
>>>> not call amdgpu driver's callback for pci device that has been 
>>>> removed. So that would not happen.
>>>
>>> This has nothing to do with PCIe callbacks. dev->dqm->ops.stop tries 
>>> to talk to the HWS firmware to remove queues. That will hand or time 
>>> out if the GPU has been unplugged.
>>
>> Not sure understand that. Inside kgd2kfd_teardown_kfd_device the adev 
>> has not been released(adev got released from pci system after 
>> kgd2kfd_teardown_kfd_device return), so can do dev->dqm->ops.stop. If 
>> user tries unplug same device again pci base driver will not find it, 
>> then not call amdgpu driver. Misunderstanding?
>
> As I understand it, hot unplug means that someone physically yanked 
> the GPU out of the system. So any HW access after that point will fail.

I use /sys/bus/pci/drivers/amdgpu/unbind(bind) interfaces to test unplug 
and re-plug. If not stop queues we just let queues on removed adev keep 
running or do not need to care?

Xiaogang

>
> Regards,
>   Felix
>
>
>>
>> Thanks
>>
>> Xiaogang
>>
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>>>
>>>>>> +
>>>>>> +    /* signal a gpu device is being teared down to user spalce 
>>>>>> processes by
>>>>>> +     * KFD_EVENT_TYPE_HW_EXCEPTION event
>>>>>> +     */
>>>>>> +    hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes)
>>>>>> +        kfd_signal_hw_exception_event(p->pasid);
>>>>>
>>>>> This sends exceptions to all processes. It should only do this for 
>>>>> processes that use the unplugged device (i.e. have a pdd that uses 
>>>>> the device). This excludes processes that don't have the device in 
>>>>> their cgroup.
>>>> ok, will iterate all existing kfd processes. If any kfd node from 
>>>> this kfd dev got used by a kfd process send the event to 
>>>> correspondent user process.
>>>>>
>>>>>
>>>>>> +
>>>>>> +    return;
>>>>>> +}
>>>>>> +
>>>>>>   #if defined(CONFIG_DEBUG_FS)
>>>>>>     /* This function will send a package to HIQ to hang the HWS
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c 
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>>>>>> index dbcb60eb54b2..b8dd80ee17be 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>>>>>> @@ -378,6 +378,12 @@ int kfd_init_apertures(struct kfd_process 
>>>>>> *process)
>>>>>>               continue;
>>>>>>           }
>>>>>>   +        /* kfd device that this kfd node belogns is not valid */
>>>>>> +        if (!dev->kfd->valid) {
>>>>>> +            id++;
>>>>>> +            continue;
>>>>>> +        }
>>>>>> +
>>>>>>           pdd = kfd_create_process_device_data(dev, process);
>>>>>>           if (!pdd) {
>>>>>>               dev_err(dev->adev->dev,
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>>> index 6a5bf88cc232..97e7692ce569 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>>> @@ -371,6 +371,9 @@ struct kfd_dev {
>>>>>>         /* bitmap for dynamic doorbell allocation from doorbell 
>>>>>> object */
>>>>>>       unsigned long *doorbell_bitmap;
>>>>>> +
>>>>>> +    /* this kfd_dev valid or not */
>>>>>> +    bool valid;
>>>>>>   };
>>>>>>     enum kfd_mempool {
>>>>>> @@ -1055,6 +1058,10 @@ int kfd_process_restore_queues(struct 
>>>>>> kfd_process *p);
>>>>>>   void kfd_suspend_all_processes(void);
>>>>>>   int kfd_resume_all_processes(void);
>>>>>>   +static inline bool is_kfd_process_device_valid(struct 
>>>>>> kfd_process_device *pdd) {
>>>>>> +    return (pdd && pdd->dev && pdd->dev->kfd && 
>>>>>> pdd->dev->kfd->valid);
>>>>>> +}
>>>>>> +
>>>>>>   struct kfd_process_device *kfd_process_device_data_by_id(struct 
>>>>>> kfd_process *process,
>>>>>>                                uint32_t gpu_id);
>>>>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>> index d07acf1b2f93..c06eb9d8008e 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>> @@ -1157,8 +1157,6 @@ static void kfd_process_wq_release(struct 
>>>>>> work_struct *work)
>>>>>>       ef = rcu_access_pointer(p->ef);
>>>>>>       dma_fence_signal(ef);
>>>>>>   -    kfd_process_remove_sysfs(p);
>>>>>> -
>>>>>>       kfd_process_kunmap_signal_bo(p);
>>>>>>       kfd_process_free_outstanding_kfd_bos(p);
>>>>>>       svm_range_list_fini(p);
>>>>>> @@ -1173,6 +1171,11 @@ static void kfd_process_wq_release(struct 
>>>>>> work_struct *work)
>>>>>>         put_task_struct(p->lead_thread);
>>>>>>   +    /* the last step is removing process entries under /sys
>>>>>> +     * to indicate the process has been terminated.
>>>>>> +     */
>>>>>
>>>>> This comment doesn't provide any useful information. What would be 
>>>>> useful is, why this needs to be the last step? Without that, I see 
>>>>> no good reason for this change.
>>>> ok, this change is not related to the patch. I thought it is better 
>>>> to update kfd topology at last step after all kfd process resources 
>>>> got released. I will remove this change.
>>>>>
>>>>>
>>>>>> +    kfd_process_remove_sysfs(p);
>>>>>> +
>>>>>>       kfree(p);
>>>>>>   }
>>>>>>   @@ -1536,6 +1539,12 @@ static struct kfd_process 
>>>>>> *create_process(const struct task_struct *thread)
>>>>>>       if (err != 0)
>>>>>>           goto err_init_apertures;
>>>>>>   +    /* no any kfd_process_device can be created */
>>>>>> +    if (!process->n_pdds) {
>>>>>> +        err = -ENODEV;
>>>>>> +        goto err_init_apertures;
>>>>>> +    }
>>>>>> +
>>>>>>       /* Check XNACK support after PDDs are created in 
>>>>>> kfd_init_apertures */
>>>>>>       process->xnack_enabled = kfd_process_xnack_mode(process, 
>>>>>> false);
>>>>>>   diff --git 
>>>>>> a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c 
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>>>>> index c76db22a1000..eaf4ba65466c 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>>>>> @@ -124,6 +124,11 @@ int pqm_set_gws(struct process_queue_manager 
>>>>>> *pqm, unsigned int qid,
>>>>>>           return -EINVAL;
>>>>>>       }
>>>>>>   +    if (!is_kfd_process_device_valid(pdd)) {
>>>>>> +        pr_debug("device 0x%x is not available\n",dev->node_id);
>>>>>> +        return -EINVAL;
>>>>>> +    }
>>>>>> +
>>>>>>       /* Only allow one queue per process can have GWS assigned */
>>>>>>       if (gws && pdd->qpd.num_gws)
>>>>>>           return -EBUSY;
>>>>>> @@ -498,6 +503,11 @@ int pqm_destroy_queue(struct 
>>>>>> process_queue_manager *pqm, unsigned int qid)
>>>>>>       if (WARN_ON(!dev))
>>>>>>           return -ENODEV;
>>>>>>   +    if (!dev->kfd || !dev->kfd->valid) {
>>>>>> +        pr_err("Process device is not valid\n");
>>>>>
>>>>> Would you expect to see this message during process termination 
>>>>> after a hot-unplug? Should this really be an error message, or 
>>>>> would an info or debug message be more appropriate?
>>>> I will change kfd_get_process_device_data that will include this 
>>>> check, then this message will be merged at !pdd case.
>>>>>
>>>>>
>>>>>> +        return -1;
>>>>>
>>>>> This should be a proper error code. -1 is -EPERM.
>>>>>
>>>> Same as above.
>>>>>
>>>>>> +    }
>>>>>> +
>>>>>>       pdd = kfd_get_process_device_data(dev, pqm->process);
>>>>>>       if (!pdd) {
>>>>>>           pr_err("Process device data doesn't exist\n");
>>>>>> @@ -567,6 +577,10 @@ int pqm_update_queue_properties(struct 
>>>>>> process_queue_manager *pqm,
>>>>>>           pdd = kfd_get_process_device_data(q->device, q->process);
>>>>>>           if (!pdd)
>>>>>>               return -ENODEV;
>>>>>> +
>>>>>> +        if (!is_kfd_process_device_valid(pdd))
>>>>>> +            return -ENODEV;
>>>>>> +         vm = drm_priv_to_vm(pdd->drm_priv);
>>>>>>           err = amdgpu_bo_reserve(vm->root.bo, false);
>>>>>>           if (err)
>>>>>> @@ -612,6 +626,11 @@ int pqm_update_mqd(struct 
>>>>>> process_queue_manager *pqm,
>>>>>>           return -EFAULT;
>>>>>>       }
>>>>>>   +    if (!pqn->q->device->kfd->valid) {
>>>>>> +        pr_debug("device where queue %d exists is not valid\n", 
>>>>>> qid);
>>>>>> +        return -EFAULT;
>>>>>> +    }
>>>>>> +
>>>>>>       /* CUs are masked for debugger requirements so deny user 
>>>>>> mask  */
>>>>>>       if (pqn->q->properties.is_dbg_wa && minfo && 
>>>>>> minfo->cu_mask.ptr)
>>>>>>           return -EBUSY;
>>>>>> @@ -679,6 +698,11 @@ int pqm_get_wave_state(struct 
>>>>>> process_queue_manager *pqm,
>>>>>>           return -EFAULT;
>>>>>>       }
>>>>>>   +    if (!pqn->q->device->kfd->valid) {
>>>>>> +        pr_debug("device where queue %d exists is not valid\n", 
>>>>>> qid);
>>>>>> +        return -EFAULT;
>>>>>
>>>>> EFAULT means "bad address". Probably not the right error code here.
>>>>
>>>> Will use -EINVAL.
>>>>
>>>> Thanks
>>>>
>>>> Xiaogang
>>>>
>>>>>
>>>>> Regards,
>>>>>   Felix
>>>>>
>>>>>
>>>>>> +    }
>>>>>> +
>>>>>>       return 
>>>>>> pqn->q->device->dqm->ops.get_wave_state(pqn->q->device->dqm,
>>>>>>                                  pqn->q,
>>>>>>                                  ctl_stack,
