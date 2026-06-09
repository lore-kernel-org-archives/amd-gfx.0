Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30367CD8CA4
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 10:09:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FE0E10E21E;
	Tue,  9 Jun 2026 10:09:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LUNPhh3X";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012018.outbound.protection.outlook.com
 [40.107.200.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D29110E21E
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 10:09:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbZwfkhj5mYcR0E0Fec29cDbna+HRUmpFMlwFobi8pBoYMPQAylK4rx4ei96O2ZJNl34jX79GZsi6uSj82kLquIjjkCC0kTGSKw8WVj1jhGrN6OxJ6qRPfpcOCY3EJbfDTSYyeNFd7GfJcV0TQAFp21c0dFumUuUFP76GLLOiM4KtqVrCywQdrYVzdlFTUWi7AkzTMC6URtL9DMlUuVg6jgyTQswYuSv+dkt9vyub4PcxetjQQX4dNmMoNBJDK45LmZLDuE8E8zlZWz+FoNyTWZT7PSgWdnAz4TfJxMmEm2TOTQVrr3277NrDc05NGhxUCKHxiXApS0Pd4lx4TD1fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYr6G56N/nEXdY6aEYqHyvH9RI0uCFt38qpvL8I8wOQ=;
 b=a/0IZ3yWxwW4AAVCrcvf+TcLAlsrWm7ktAqBGThC2cAVWJneiKbEbJGh+mMBs3WBPBLNuA8RqtHIDs1j44uYQnD1BIjVu84L50nt61yJQ+ZGx7ajNdsj8vFpWSiO3fK23JK7+WZQ6ncsBtauTVkjmHgHIT2GWs2DM85zf96VLDqDdVEH4xtccLGjKvKo60eKuxT9uHqYUux695KfTk6elrdBOHMBP+5PQDHbtUe4IcNKeYSIWjbjjNER5FGGA/IrYGFTdFUAWqfdUXjAWtWvRi/4tnM/tZpZO/Kh42pYI+j3VpzfXKioD5zGhggq1WCGsYLOB2yIfhx1Ji3pKnVLoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYr6G56N/nEXdY6aEYqHyvH9RI0uCFt38qpvL8I8wOQ=;
 b=LUNPhh3XbDK0jH0Mhc6EqUxg7010tYURvUnxpWYBQC4Hf8pUHPcZbJPUKdRXG5FGFPjrwT5xnXYewSb6JGGVCR10xGRgTb5D1avt9uIVuTa5Gxk9vMEThoTs2nLISZTgbFNz9gBnpqR+Y2I8CpA5/MaEGmEbO8XX/yZVsg1Tsu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6110.namprd12.prod.outlook.com (2603:10b6:8:ad::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.13; Tue, 9 Jun 2026 10:09:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 9 Jun 2026
 10:09:28 +0000
Message-ID: <b608f932-dcaa-4269-8c29-ca810dd8947c@amd.com>
Date: Tue, 9 Jun 2026 12:09:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/11] drm/amdgpu: Make EVENTFD subscriptions
 queue-aware
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260603163350.2678309-1-srinivasan.shanmugam@amd.com>
 <20260603163350.2678309-7-srinivasan.shanmugam@amd.com>
 <b3445b69-2f52-4b22-974a-7bfc2be2b9d5@amd.com>
 <IA0PR12MB8208B33EF21B6E299522E2B3901D2@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <IA0PR12MB8208B33EF21B6E299522E2B3901D2@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:408:fc::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: 86113b5e-ec7e-4507-f8ca-08dec60f3111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: d1QjAfZnFflovtUCwAeuSwPXMYDjZ2N13F5r4DYSI8Yp8Q7R+kqNmpK+JKPS4ux0WtFPzglrMT5TdfhEXhkeMJURsdSPLX49dHB4X/YP0iyUGfUoU2hBuicBZXB/bp0NyOUKpCZy74VhrGkREs31XlkVRBv4FmeRUJkfC1kDmNKkOveZnzkzy8IYHicSyvoELI7FkEIhHsU5+x6uP0i6pIMPetx2g4/EzAqwtT4x3MIjn50ReNuxM1ip/LpFhPNSbIEQTlDevQhSMNKEWNIpcyNuy7XuluuXmU7cwOlMQnGNnUkuy5DKja+oaolmx1EHeRxO5PlTbND7SuRHyS4ftgY1E2CsW5xG4vASSva0EvFsqDrBeVI7WCSfbh4Gm89iW3Ep+OuAOxTS428aDewTUMW9RWSVitIUIORytwpqkrjEtj3u7x1NysMdCCAosIfK4Z+ybULCRxfEydGgZIm5DR2DhNqhic7us6LTP+onID/gYWvKdJNU2b/tjsN6Ll7K+q4nNw6021SaXuegwHdyLraN49oCVOOOnV/J30yqbhh7Plg00TMuQKDa+XbYQ5XZeGIrYUWf9ht/t+I9bfXEPe841WQeSD7g2getOXG1zpkPIBc52fJ8WFqxUJDLediiPlpdTx4txg+HMH4pWaVcSzZawazdNRrsotdnLD0tWraa7YCJDsG2xdBjHk22z8ha
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEtCY05Hd3hoTHF6bytEZG9jQW90VmhyN2tzTjNFbDl3d2hzdzlvS0FoQW1T?=
 =?utf-8?B?MUgzdkwzbkZBcmRabmFWcTRVdkE0REoyVlpkZGVkSWc1cjVFR0dmbWVsUzFJ?=
 =?utf-8?B?WkprMXdINGhQYWxlc201YkVseHpkcVBia0xwWjRuZlB3NFhCUUVXMlVxWW5m?=
 =?utf-8?B?NWJPKytJVktOTTJWRTg0NmRBUEFlRDZWN0lTbDBOZnVYS1Jlc3NrVlYyOXQz?=
 =?utf-8?B?c1pxTkxnL1EwV2xraUIwY21qT20xRnk4Z1F0YWJEc0tndkpJN0ZlQ0tHTXdE?=
 =?utf-8?B?bEM1U1ltSGozcCthTFpKL1VVV2NieDUxdTRaL2VLM1pxMmIyc1dwbVBSRWtr?=
 =?utf-8?B?LzZ2N2ZCaEMwZE1pQk5tMXRKajd6VmNwTmNyMGs2RzQwMU1FWWhQN0ZUQkFV?=
 =?utf-8?B?ZDFHWmRWdVVSQzlIeFB6Q3Zla3IxRHB1TlpJQ3NCOS8rTUZWK09QNG5SYXFX?=
 =?utf-8?B?VmsrNm5Cb2h5UkJlZEl4WEo2T1V4dllSelozTEtBMTBIWXlFTHZ2Z0ROY0U1?=
 =?utf-8?B?NXI3eWpwWnVaeXV2dnFOSFY5ODNGY3lrYWlEcWRzeEdCbXZKaUk4dUNKcXkw?=
 =?utf-8?B?UWxnL01YWXIwR2JEZ1FoYmtXQ245ejVWa1ZZNzhwaE5CektIc0l1ZlRXTEFN?=
 =?utf-8?B?OFNVbWFWeHN4dEpiTy9pK1BlbHlNYlNhQnJzMWR0QW1sQUFGaDE4T0o4ZHRh?=
 =?utf-8?B?cU9rOFNvdEpwdk8zV05WNUpWTFlIcThTZXdLOXdGWFlRREl5Qkw5cjA0aHlB?=
 =?utf-8?B?U2dYZEpZRHVpRDkrcmlNeGtyRWFRTCs3YUhDcFBjYWs4Rk8yZE5HcnBnOGts?=
 =?utf-8?B?VWNGdkJ0Vzg0MGIwYVQ3QWVjaTVyeXlnbE5WQTVlQi9Mdmgzd09lNzVBT3JN?=
 =?utf-8?B?aWo4bWQ3WWwyanpUVmNycSs3ZzF4cG5JQWpwdG9hTXpKNnFxVzdGYnIzMGdN?=
 =?utf-8?B?NU94ZHhGTDlaMERwMTJaeHZCaSszY1BFTzQ2dXNFejJWRE9xNVZVVEdjZ09C?=
 =?utf-8?B?b2JZR05ONXNRb25TYkRVRWUwa2Ftdk5ScUIwcjhadjJtRkR2aVM1ZjZhQVd2?=
 =?utf-8?B?YU1RK1VlajhFVUFHWUNQYkEwK25IV1U1c0QzTGZoVmRLRTBOb0M2SUpLMXNE?=
 =?utf-8?B?akdFcVNkK1E5R0VwY1MzR1hGR3drWXBmYzNrVG9QSWFURkdocWUxdmsyMDNu?=
 =?utf-8?B?ak1EU1QyOXFoRVhqM2pjaDRYanFvM3ArRXZ2RXJVTWswK09ZWjF0M21nZW1q?=
 =?utf-8?B?UDNWMktpYUdyWkRKcTA5V0kwRHVFL3lmTS95UXMyaG5nTFJNNXpsRXY4aWZx?=
 =?utf-8?B?dWVRZTZQL2g4YmdzSXlHdlJMeHlPN1FpWVJSK2ovUnB3dnFIeEozMmd0ZzJL?=
 =?utf-8?B?UGZLS2VLdWRELzc0dDR5YlZPTDQvNzhGeS9Kc3luK1RPYUU2eDhMMU9JVFY1?=
 =?utf-8?B?djhFTUduTTl3NDZ6ak1ObU5tOVo4ajZ0b1dZd2VlZWlYYytGUTVOemsvbUZt?=
 =?utf-8?B?SmdWaUpDOVFnNHhwaGxUYzdWbHA5RFZIaE5scFEwRGRHNEVmaGN6STg3c1VR?=
 =?utf-8?B?QXVCaFMyaEZUZ0pqSlY3RUo0YXN2UHgwanpVUXlHWll3UHhzRHpJNDlvMFJX?=
 =?utf-8?B?bi8yMUpUdFozRm9GZmVqaG5PZGlGT05rSnFVQk82TjBJTjRpVnN1UVFNclRv?=
 =?utf-8?B?UEZBM1RmSDV0RlIzamU2RWJtRnFkRTdKQ1VkSDdQMThvREwrQzBmdDdjeXFx?=
 =?utf-8?B?cGpIQWllaWZqZUpQV1psZGREV3Y0ZmRpa3ZwT1kxeGZ5Q21WTTI5dnU5dWNV?=
 =?utf-8?B?YjlmaHorZGRCbmZqRUtGVE5hSkRpZGVDTHN3cERmcmhWVlo2TE13NHNWNGhi?=
 =?utf-8?B?WUdVTU92d1JRY1BOR2ZZQmJWckd1RE5ITHM2MGQ2VnFnYUc2cTJKU1JPMmRn?=
 =?utf-8?B?Nk9ORmJac3lhWEtDczJvN2o2SGJHRElGTnordkJoK2VvR1llaGp0RVlkak80?=
 =?utf-8?B?UXVDRysyZDJ5dXJxSFlFR3RtWG5YY3BIRUE5VEFUNVRPa0phdFhobWRiK09i?=
 =?utf-8?B?VHpIQUs4YUZyMmxFYTBkOEdUSEt2VUJpUFhTaUZhUEFiK3M2TjcrMkd0RXJC?=
 =?utf-8?B?V2tFNkZYZ2xzUFJ4QWJmdy9BTEZINkZoNXpGeDEzYVRKUC9oczZ4MTdrdUR0?=
 =?utf-8?B?MzNIVHRUMFFnSUE1VmlFd1ZIdWNWQXlyTmpBcUc5eVZzNVNocVQ2UnRFRngx?=
 =?utf-8?B?TVppOU02ZVpoSHRpUjY4T2xNekF6c2gxb0MwSCt3b3RIYmFwM1VvejdzeUI1?=
 =?utf-8?Q?nspGKx2LhS24COzurH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86113b5e-ec7e-4507-f8ca-08dec60f3111
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 10:09:28.5588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+ewEiDBGviONDt58fTqzd40xlNATWFpHAN/90AqjjHOX8cAuGZLjPITZz+tZo7Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6110
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

On 6/9/26 11:44, SHANMUGAM, SRINIVASAN wrote:
> Public
> 
> Hi Christian,
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Friday, June 5, 2026 6:56 PM
>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH v9 06/11] drm/amdgpu: Make EVENTFD subscriptions queue-
>> aware
>>
>> On 6/3/26 18:33, Srinivasan Shanmugam wrote:
>>> The current EVENTFD manager matches subscriptions only by event
>>> identifier.  That is enough for coarse notification, but it does not
>>> support the queue-scoped routing needed by queue completion style
>>> events.
>>>
>>> Extend the subscription key from a single event identifier to the pair
>>> (event_type, queue_id).
>>>
>>> For device/GPU-scoped events, queue_id is 0.  For queue-scoped events,
>>> queue_id selects the queue-specific subscription.
>>>
>>> EVENTFD remains notification-only.
>>>
>>> Also fix the queue-aware bind path to compute the packed subscription
>>> key before lookup/insert, and allow fd 0 by rejecting only negative
>>> file descriptors.
>>>
>>> This change keeps the existing manager design and binding model
>>> intact, while making queue_id meaningful for queue-scoped wakeups.
>>
>> Yeah that doesn't work like this.
>>
>> The queue_id is just an identifier for the UAPI and can be re-used.
>>
>> So you can't put that as key in the amdgpu_eventfd_id structure.
>>
>> I suggest to convert the queue_id into the global doorbell id or put the eventfd
>> manager on the queue itself instead of the fpriv.
> 
> I understand the issue now. Since queue_id is just a UAPI handle and can be reused after a queue is destroyed, I understand that we should use the refcounted queue object instead of storing queue_id in the EVENTFD subscription.
> 
> One clarification pls: would you prefer the EVENTFD subscription itself to hold the queue reference and release it during unbind/teardown, or should USERQ resolve queue_id to the queue object and keep EVENTFD as a generic notification layer?

As far as I can see the eventfd handling must hold a reference to the queue structure or otherwise we will run into problems.

Just make sure that when the queue id is released that we tell this the eventfd manager so that we can free those references as well.

Regards,
Christian.


> 
> I can implement either approach. I just wanted to confirm which direction you had in mind.
> 
> Best regards,
> Srini
> 
> 
>>
>> Regards,
>> Christian.

