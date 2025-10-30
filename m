Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEA9CCF9E3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 14:35:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA7C310E9BD;
	Thu, 30 Oct 2025 14:35:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tH8W0oY5";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 675FD10E9BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 14:35:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2gveo9ek0qexrt5BmXRnas7WAFd60txzMMX3CDwK2/RH4k+aqvornFue94H+rRoNYDxtzGuD9LM1tkUMV6b+R/SWRv5Eza59d3T1CZ//472WwXQg0CY9B4FROkF+xDxCqoTCAp0dTn3cLbWJ8dnAV8jpzRqtXXUv+Vu+gBzF5XcY11UbUzPdHXUOiKZXFo76A4vKjsSULMaKBD40Mu7RHtFK/J+fBzpSaavFWDqygOyP9rbg4GFfiVqXlXHzrTygU+j2rsnqvMcbUCtGqGF2NUw/SCmBD+c6kJ+UzzZrq1RtiJMVycKCI6U1Rxk3hIAVLJjAROvDdHph7L5Oo/ZYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fHe2eJQBN90YllXDZjLgZPoEFCDOAqsBrbmz8MreiA=;
 b=AfOzINNR+Ie5Y29A6SUq/1QTHncTMhYe9rUHE5nUnZMyM6gGKv4IvyMjNB3dt3vzEBwSyWw+q6grkws9+K+iH+Zu06a27wpByxZ0mP7CjqUl+N6avdSjXywI+VOMEQZXozywRMeLE27hmCFmKEwYz2v3aLH4rNW+3ZfgOW+49+yuk4Bw2YZjzMCPraM1LJ8JskLTfRhFsV8gIoW4Jw6CGTLyu3lN+/JgwRJyU6nIUj6kkQdNTCBjWJWhU2iwgtGAmTvE988NNsp5DYE4KvLqbt4EQmzmQ+JdYb52Ce1P4zhLAgdLvz2tYyanitSJci/vAUUq2ZATnaEuCJu5xah5Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fHe2eJQBN90YllXDZjLgZPoEFCDOAqsBrbmz8MreiA=;
 b=tH8W0oY52TRhMD6ZiIue+TqWMtIY2PnUl7ameeFXxtyKhKT9pHAtuyrS3ItKqMwkkRks0IaaAZJAxwbm2AWq9Vrj0KmKzBkg3y/vMHdfxyAh0fYWnC1q9GE5IZguOUEvX6AVgxw6mdHHabkwTeZgojguHgIDHgu3/esmzX/e+DM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 14:35:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9253.017; Thu, 30 Oct 2025
 14:35:38 +0000
Message-ID: <6d1060d3-386f-403b-9602-f2dff22ba85e@amd.com>
Date: Thu, 30 Oct 2025 09:35:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] drm/amd: Reset the GPU if pmops failed
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20251023165243.317153-1-mario.limonciello@amd.com>
 <20251023165243.317153-3-mario.limonciello@amd.com>
 <CADnq5_Nzx4aE0V8bNhcjVfqN3qFJYr14hZM7XvZ_SB_y8EG_JQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_Nzx4aE0V8bNhcjVfqN3qFJYr14hZM7XvZ_SB_y8EG_JQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0133.namprd13.prod.outlook.com
 (2603:10b6:806:27::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: db571ab7-6ebc-4908-cfff-08de17c197ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzY4VFJ6WFdrZTNQUkQ2VzZOOGowQ25QRG9IUmQ3TE0wWmdqcDA5Y2xZYnRM?=
 =?utf-8?B?a2x3dlRIUkFwbVNDcjA4ZHlzeU5obkFCZFh3MXZCaTJrMjUrcGdQRDRUYklt?=
 =?utf-8?B?b0x1d3gzaDc3c2tzUXNmUDdoY3huOGJ4SmxadldvRDAwQWZuc2JVV1VPT1Nm?=
 =?utf-8?B?ZnB6MDlWdkhCVngwRzYwYlZ5QzUwZUM0NGVoQ2M4WXB1MVVpL3dIYTJmMHRv?=
 =?utf-8?B?VUJKTVFlcVZGZ3VWRjhHTWJ2VS9NWG13WWJjZWZxUjNjV1FlMmtPZ0E3MStX?=
 =?utf-8?B?SmNFNmhhZDhiQWorNTRWQzFaU0dEaXBlMGs3amdsUW9kZW45amk4Y1FoZHQ0?=
 =?utf-8?B?VVBxNGMwTUJFUjhza2RPOU0xSEtNTlBEUHhlYXVjOTBEQS9lTGt6QUUyY21a?=
 =?utf-8?B?dUtod3JybW9tZE8veFdWQW5IczliUDBSNkRkMUFhZExsVWVsUDBSc2pwd3ds?=
 =?utf-8?B?ZExLdENQaEd2dHY1T2N1N2xpZzF6WGNkOHg4Q0F4bVRreDMrMmc5Zmd2WmR5?=
 =?utf-8?B?cG1WR3RYWDd2NlFjTDFCUi9sY0tWeW1PWTZFUGQwYVlDdDNtL2xJSmltRzZE?=
 =?utf-8?B?dVlqdWNEc3JDNWJPZWFCR3RLR0F4VFFuMWd4RXVMeFdNbHVWUldLQjdTT3VD?=
 =?utf-8?B?TEt6bkFHL1JSRHB0aE82cThrU0dUay9idytUazlyaUpQek1IK1QzQU5nK2Rq?=
 =?utf-8?B?UW9PVXpsSDk2VWRidFlDWXVQdFdiSHYxclhPQjVBQ1NoeG9lajFZNkIzSkVr?=
 =?utf-8?B?Z0RmRFNhZ1BFWk1vK0kxK0ZTTmZDRjI4bEZYWEZhQ3ZQeE9KVmR0bFYvcGtn?=
 =?utf-8?B?K1V1T2g4aVluVEM1STc4MVlnSmc4UHoyUnd0cTd4cUlsUis0M3BzK2d0dWxw?=
 =?utf-8?B?SzZtZnVZRE9HWC94VmpNV1RUelhrdElZczFWMnpINk9Od0RzTmcyZGNJbXJO?=
 =?utf-8?B?T1NZTEtGRytCbnZILzVkQTNJaVdsM3dLZjNDTUFIa0FJSjE1NFRwaGZ5ditZ?=
 =?utf-8?B?bXJiKzk4YVgySDV5bzZ6QUFsSmFwRGREamxScU9xY1FkemFNTDhEK29wbnk0?=
 =?utf-8?B?b0hINk5hdGs5M3BDb3JweWNBZVY4SkxQS2E2SGtqV2R1NllMeTdRaEY1Tm04?=
 =?utf-8?B?Q2JjSzFrT3Z4cm9wQUxKbG1Ocll1REh6Zk9vT2dnajhaaVBVMm5WczZWVGI5?=
 =?utf-8?B?VC9PL2N2UVlaeWxhOE9FMTQ0RVhrSlpKNjl1Q1dmVENyb21wcERnSXRUQ3Qx?=
 =?utf-8?B?cE90bktJS3Flc0NTYzQ4aWNXWEl0cllDQ2tSdjRpNEVGNTlqanBzN2RtcE9i?=
 =?utf-8?B?b2tYMVRYY2JHMlJGODhrSy9RcHZHMWNMRnd5MkRrZHRyQW84ZkFxTlRNeHNp?=
 =?utf-8?B?b2tMYVk5RVdDcUhZeHJISExJVCt2WmdqMit2WnRIQnQ0Vm5EeHd2UUxwc0dh?=
 =?utf-8?B?aVczQnNoMmp2OEZKbld4SEtySjVhaksrSThWSlBBTFgvaUE5eURCdUFVdzUz?=
 =?utf-8?B?MXFkbnIvQUFCNlFZRFJidTB4am5tNXM4L1UzOFN2UDUya3FVdEhJOGlsYXpm?=
 =?utf-8?B?YjYzS2wyOGpxcGxiWlZyOFlobGEzczJVckRGOXVOSENIL3FiYmNjcVNla0Zv?=
 =?utf-8?B?MUJHUFUrLzFoMjZ2cjJRNFI0LzFGYXJkL3lrVWlUVFZ0dDhmZDN3b2FHTElT?=
 =?utf-8?B?Z2xucXBNSmczdFNpVUU2c2h3RktIUU5PSEJxRi9VVG1KYlNHRE1NZ2ZhQ0JH?=
 =?utf-8?B?WFc3aGtGRVBUYmc2eXBlL0pIbGtqSkZMVCtid3kwd3l5SW94S1pVQi9XWmJD?=
 =?utf-8?B?cEthUWYvV3RsUzhqazNZV2RJSFYzYWZwbU14OFhleEx4STVKWWU2Ny9yWGtD?=
 =?utf-8?B?em5XK2JKeFlXdm1lODl4WDZYTHJaMmdqUmJaVElsVEVYSm5ZK1ZROGE3cndq?=
 =?utf-8?Q?tgVdXNrEuj1qhIhNQNhcAUc5YyiHZAbX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjlDNzB3Q2k5YkxKRWw5Yy94a203bVNXWTF5eFdBNUxyQndkNWVKdXp2eWdy?=
 =?utf-8?B?WVpsdFl3VEc0R2JMWkNoZFRXQVRLRHZqRGxIZXozZmxSUFlkbElGMlVxekVp?=
 =?utf-8?B?d3piSzBVOTE0UWZkb3gycHJwRmNSSWlVWkpBZGphckswbzNUVE5lTy9jRXAw?=
 =?utf-8?B?Qmp0QmowbEdta2R4bTY4MmhzY2JhellHR1N1ZHo0b3d1L0QzV0ozamtyTit6?=
 =?utf-8?B?Qkk4WE5UUmlFcG5yY0IyVXkwU1RXZXV0WnBDRTFXNThKWkRXUjVxSFVTQXo1?=
 =?utf-8?B?MldERSszZE1MaXNTOVRxSW9LMHBqSHZsajJoblA2WGc3MjgwMUJ3ZkdoMEVn?=
 =?utf-8?B?VXRDNm1aVUlmNldOTHR2WDFqTFNpS3MyeDJ5bEgvZUNtTUh4Wkt2QzJUeEMv?=
 =?utf-8?B?TWZkKzQvYWZ4c0pCMjhnYnc5aWdlalROSTZnZnE0Q3kzS2hsWmc5NnMvTDlu?=
 =?utf-8?B?bmdjMzhENXpYUDVCN0o2eGVXa2thbThuMjRYWTNGVDhTWHRLMGJVWGJNZmpZ?=
 =?utf-8?B?M1ZEeEpENFZ3VHpTWEJkQTFNZWN4cGY1STdsOEloZCtIa1pQT1J4dklOU3RM?=
 =?utf-8?B?dmk0MlVRU3dnWXpzSmpwaHFzZmVjWkJqWWpUeW5Mc2F1MWpBT3hEdnB1NC9w?=
 =?utf-8?B?TktFNVFGUGdzWGpZa2FLSWtwYURqM29GUStqdUIxSVY2MlRsS1YxN3RlaGEv?=
 =?utf-8?B?cnJOTS8xeUE0eDl0ZDU1K0NleUFJdGVybGp1dG8wNHpVbVRiL1ZjdVo2TkJp?=
 =?utf-8?B?NjFvOXdVMXFDQk5wbExTb3o4dERiZzVjNmNaUGxPdmh6anA5K1ppbXhrOGZv?=
 =?utf-8?B?a29jOVVGZkJvYzVpb2lCaG9ONHJXeWwycGZ6ZUJaazQ0ZkJwQURsOEJXQWU4?=
 =?utf-8?B?V05vaEQyM1VHRHIrekZTM2NpTkRycFhHd0w0QnMvc2RXcGxxbUZtUGc1R3Qw?=
 =?utf-8?B?aU9iTlFTSW1BQXRxK1lxN1hwRGUzU1ZPakJ0TmMwOEVibVcrNzYzNWc4am9J?=
 =?utf-8?B?NUI3SklRWXREeW9senV6NXQzYitLQ1R0WGlleVViWmJ5YW5FNU5UcGkvQlpL?=
 =?utf-8?B?UHhVMGJNT3JZdUxZL0hyQkFCd1czK2tmV0pZeU1ZU3RWaXVrS2VpellRWkR3?=
 =?utf-8?B?VTA3dStiL0V1MGFmMktZZVhjRngyc3hIblJ6d1NUTDQwbkF4NU0rL2U0RmFG?=
 =?utf-8?B?SllUT1p1UWlmRXcyOVhhSXB6R01VQUw3WEcyamppbHFjcFJmM05ZSmpac1Vu?=
 =?utf-8?B?dEFqN3FmYWV0Q05HMDBub0hCTW9DRUUrMkZQR1kzbXhMU0lqT3ZHVm10NHFj?=
 =?utf-8?B?Nkt0TUxqQW9qWmc3Qm5zekJoSmxRVkZZYi8rYWdyMkg2UENBa2hSelpsQmxo?=
 =?utf-8?B?eHJGZW9aMDhuMjd3V2lzMGN4V2hGcDdyMERQRm50Smd2K0Q2SldKMllqekRo?=
 =?utf-8?B?YnkvYWg5a2xvUVhYWmJWRTNiOTdwRURoMms2YWxNeUFQTm1rYlhxL0k2Z2J5?=
 =?utf-8?B?TERPVHdjZUVFbTFFUXpKZmRwSEwwbDN0WWRGQzhzWnFCS21LOTYwU3FhWjNO?=
 =?utf-8?B?MHNZY2I1d2Q0TnNaTm5ocjRKK0xlRWhCRWdhUm9RYkdkcmVoUHV5d0xoY25u?=
 =?utf-8?B?YnZjL29vWUl5RW83cTc1M0dydHBXRnI1bGtOUmdaYnAwM2JvVjdZK2U2OE1z?=
 =?utf-8?B?STcrRkFVMmxybUFFM3BMYmMwdHRYMDFCWG9OTEdwRkEyYWZINDVScnR6aGp6?=
 =?utf-8?B?WWlzV3hzVjdvSGxjZ05tMFZ4Z05uTlE4U0c1SHZSRmszNWxFenZISEJNM1pX?=
 =?utf-8?B?YWlsK01uTDZ1VzcyRWhOcHdMc2lwdVlBYys5ZlE5Z2RNUjZIY1lxOFNxODJo?=
 =?utf-8?B?U2RsTnd5em5RcU51NjF6elRzVnorWFFadkgvdXBkbUlrY09qdkUzcS9idWd1?=
 =?utf-8?B?ajAzekI3NTB3OUVEenliMk0xUGQwVVhGdkxhdlFpVmxvSGYvcE5iWmtuZzlO?=
 =?utf-8?B?TWNiVEJkWjF1R0s4cXFER0pXb2lJTUloaU9yNWZieU1nK3hvV3NrQ0NhM2pk?=
 =?utf-8?B?SGJ6a0ErRmlTMEZWL1d2MXkzTlVSQTBwd0dGVWVROXVKNEhNK1F2REJxa3d0?=
 =?utf-8?Q?OYm/dJgcotwTzFznKczhrio5U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db571ab7-6ebc-4908-cfff-08de17c197ff
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:35:38.0713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vghve1m8pCse1SSnlE2Gfea344wyRo18Z4rxqbl4i70kNJAq5NLzaNMF2//7zh9tzxMtQT2xghY5dflKaTE2Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955
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



On 10/29/2025 4:28 PM, Alex Deucher wrote:
> On Thu, Oct 23, 2025 at 1:01 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> If the GPU fails to suspend the return code is passed up to the caller
>> but it's left in an inconsistent state.  This could lead to hangs
>> if userspace tries to access it.
>>
>> The last stage of all pmpops calls (success or fail) is the complete()
>> callback.  If by the time the PM core reaches this state the GPU is still
>> in suspend something went really wrong, so reset it.
> 
> What happens at that stage?  Resetting would put the GPU back into a
> known state from a hardware perspective (amdgpu_asic_reset() just does
> the hardware reset), but software would still think things are
> suspended so the sw side would still be broken.  If you want to try
> and reset both the hw and sw state, you'd need to do the whole gpu
> recovery sequence via a worker thread.  E.g., see
> amdgpu_debugfs_reset_work() for reference.

I guess I go back and forth on this 5th patch.

It's hypothetical and mostly in case I missed something in the unwind; 
and I I'm leaning to drop instead of add the complexity.

> 
> Alex
> 
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index a36e15beafeb..e2d598dd462d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2590,6 +2590,17 @@ static int amdgpu_pmops_prepare(struct device *dev)
>>
>>   static void amdgpu_pmops_complete(struct device *dev)
>>   {
>> +       struct drm_device *drm_dev = dev_get_drvdata(dev);
>> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
>> +
>> +       /* sequence failed, use a big 🔨 try to cleanup */
>> +       if (adev->in_suspend) {
>> +               adev->in_suspend = adev->in_s0ix = adev->in_s3 = false;
>> +               dev_crit(adev->dev, "pmpops sequence failed, resetting\n");
>> +               amdgpu_asic_reset(adev);
>> +               return;
>> +       }
>> +
>>          amdgpu_device_complete(dev_get_drvdata(dev));
>>   }
>>
>> --
>> 2.51.1
>>

