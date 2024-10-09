Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913E1CEE359
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 22:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FB3610E821;
	Wed,  9 Oct 2024 22:16:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MwgKZbDo";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B0B210E821
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 22:16:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mmciop/EWuqXyA/nUgs2iPGyljeZV8LiffR9Mop113GUFSUWn26CMosUwxETcHcEfuEb7diFbR4Sh8uRuxJxZNDIdxrwTSuZwylXcNFAZD0DsYxozw5wNxudPnwqxsIjlCpKpPGN8s234W9qEPu8qifWb4gTeleojKnDzmIGPclIPF9N4b98jkGl/1zeB108hWs9ethXZxYk9oi6Z73/zFsiZ7jJwod7BnUHw6iKDRodQdaBQzMM3JAYrMNP4YDQRmnEyyYNEUoUliuT4ASNjxZAMcJMN2+htPR5kBQgtI29Uq13gyWALJPU7zjuhNvvRna2VAbOjkm5aY26ERxQNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEyTCZBGFBmnON+VWPaG5xOAma8OnTyFND+dpb9yopw=;
 b=YiE9n6mnQcwxvSZRX8CzMiPDmbMam5Fpq052l4buHvzOwwAZ9J/rWWfOq2ajKosRBNxJDLJ2ZnhdLH189+6XCXxcMHeipBAHIq4AlJTlSiPNRtessPQ+s/0yj2HxG/aCV9yIxnOsWMo26k8/RrQ8+tsSEnY09y7Qc8aBRmy17FaCbAnlrMPKVqdlJ94FC4oDebsfkvwe3BCkhkv23HbDVxFXU6djdo0h25J0WfjMEtsIvsdEccGKZMxkTFNfEIX7y+LMC50Wr32Fsu4z5Y3UBxvtWmNC5Bjv9ANR3orHDnakQyLMgmmPkB4VepZQQJJmyxLzCOBlllAhA7lwvSj3gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEyTCZBGFBmnON+VWPaG5xOAma8OnTyFND+dpb9yopw=;
 b=MwgKZbDoSXfy6F7PvP0qk52mJpbkXfhaTRqOIhSE31OvH9ZffwP0NjFN82d75uCJ33bIlJYtJ/t7+X/2j8QyX2miKo0AQLLQPCTMWQBxvok/g8nC8BXWIQEkURXc19QiY0SlIlmePQww4KRmhR0dVn+kAkaUXoY6tuGZGPfImmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 LV3PR12MB9215.namprd12.prod.outlook.com (2603:10b6:408:1a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 22:16:47 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 22:16:46 +0000
Message-ID: <92839ce8-4fe0-4099-8592-f461bd9d119b@amd.com>
Date: Wed, 9 Oct 2024 17:16:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: change kfd process kref count at creation
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20241009180855.14859-1-xiaogang.chen@amd.com>
 <56b95963-f617-4578-a660-37eb471edd68@amd.com>
 <98dfd8f4-3c24-466c-8ede-d3fcb341912b@amd.com>
 <3005a471-e835-4d0e-a0e1-e40c5d761cbd@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <3005a471-e835-4d0e-a0e1-e40c5d761cbd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:806:20::7) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|LV3PR12MB9215:EE_
X-MS-Office365-Filtering-Correlation-Id: 100239c6-1e54-4373-6b5f-08dce8b01060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlJQVExUcVB0akJKZ1lZVVVlUngvQWgxcWVIcTBxVjYvbGZSUFNNUzdCaldP?=
 =?utf-8?B?SWk0a0lsTHJXZmVnVVJmLzFVMVJscy85QmxaK2ZGcllRY0ZFUzBoSXhlYTdN?=
 =?utf-8?B?b2FEVFBGL3RRR2RwWjNEdEdIM2F0U1ZCSUo0eDluRGFYQnJUL2Y2ZVZrLzBx?=
 =?utf-8?B?S1FXWVhNSWlhUnpCSFNMM2c1bll5WXRUQkhlQlh3OEpWbGU0UlNDTW8wYzUr?=
 =?utf-8?B?d1M3Z1J2ejUybGJwL3NpV2R3a2JuQ1I5Yk9FMnJhT09icHNMekdWekk0ZHpO?=
 =?utf-8?B?SUJnMHJRS0doSkZTQzlQbmxzY2VyVzVySGJDSm1iU1FRVkt4VVRqWW5icWJk?=
 =?utf-8?B?ckJaSzB4dFlqZ2srM3BtRlR2TDlWeTBXUkY2TkR6RnMvQ1ZLMkRXVEdlbjE4?=
 =?utf-8?B?cThBdk9XRzZlQVFJdFNZazY3RldHeU04K3dUVGJDZFNNMGNSWG9YQUczT3pi?=
 =?utf-8?B?SDJJc3ZETFlKTys0MzV6dVVZRngvZXZjc2Era3JTV3NxZWVFTWNOandKbGRG?=
 =?utf-8?B?d0JVZHJmOWZwRWljVnJUTmMyL2pqUWNRa2I4TG1qVHo0QllBUmFyUHVPK0Vy?=
 =?utf-8?B?dSs3eFdHakFqbEdpbVg2TnpCRGVrVzdYdWRseUhEelJ6QW5ZeFd3MUcyUlIz?=
 =?utf-8?B?VVI2M1ExMTVEdnhCbXlscjF2dnVRY0ZwSzZnNGhYdHhPQm5qMFl2S0tYMnJF?=
 =?utf-8?B?b3c3RU95RkRUOXRMbThyYytvbWJoYWUyNXJnbWtuY0h2OWJHK3hqR011dFJl?=
 =?utf-8?B?dW1VZ3REYllQVklwZDJReVY1eEM5QU1ISElCRE1MOVdKc25HUW1KTFdaRlBY?=
 =?utf-8?B?QkVGT0hUZTdJQ25RSXlmbGxYcjNjTmE3bXpZRElTaWpKVHR6WFhlTXk3QWRj?=
 =?utf-8?B?eEkwWkpFSXkzQzBQbkNsNjNrYWVGM0lDVzQ1emh4d3hhTXRMUkxKRXB5bVpC?=
 =?utf-8?B?OFJFNjlVajJxL3ZyQXRiZ1ZvMzY4b2ZKNEFuQ2hoNldUbS9PamUxK2dINnZz?=
 =?utf-8?B?SEZmMFl1ei9NOVhoeVM5NzNmNVNaWHhyWDV6QXVsU3czMWNnQ2JKVlVTbml6?=
 =?utf-8?B?QzRwVTlaZ2lHTlUxT2grVE1jMDlBcHlXUWF6MWhpVTJ4cFUzWkNUVFRwUUM0?=
 =?utf-8?B?MzB1djI2Y3VCSGNxMjRrNGNUUTlVaW1ndTNCYUtleHZaaWh3aVdZUzZHMjM1?=
 =?utf-8?B?UlUrQy9OTFdkZ3JXZ3FVQTU0QUZwZ3IyK0FwOUpVVHQ0NDVlZ3hyRzV4bmRU?=
 =?utf-8?B?WEtkdTRGejYya1BiYytneFJxanlGb1RkUi9FQWwzTVg1Z2Qrb3djNlAxaStu?=
 =?utf-8?B?b1BTNXhXaldxSnNySmh2bFVKZlVBTlVSaGpLanNoV2w4S3BWaTRSNGdUTFdP?=
 =?utf-8?B?ZmFuZlJ6ZFZmTFpqaWVsL1M3cVdQcGpUVWRaZTdEQis5U3VBYXl1akh5VWMr?=
 =?utf-8?B?T2RFangwb3lrWEFZcmhXSEpTTXdxWmdjaWNmVzhneE8rK05GblVYL3NieUtY?=
 =?utf-8?B?dEd6YTNNYWRpYnFER0FiMEpPUmgxVFFVTjRGRCtub2pRWFJaaUJncVZOdnNI?=
 =?utf-8?B?c1BjY0JQQngxaFFkS0xvV01ER3FBREFobDZxTW00a3lCcUpDZ0RpVWpFZzg5?=
 =?utf-8?B?QythVjZSTG82enJoN1FQTzNMeVVTdUFWSy9uOUp3dUE4ekV5YUZsUmtwNHIv?=
 =?utf-8?B?UGtvSlBtM2FBOGVBS3Q0eG1PdzljTmcvdzVxR1BMeUdMR0FucHVCb3FnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODhzdTlLRG5nMFVNc1F4WDZHalFjNGdtMFVHajh0blEzL0xaSmVFdFhQSEhR?=
 =?utf-8?B?ZEV1TW1nS0U1SEtrKzYzMDUvaDF2dGliMlpVNG9JZ1dXTUtPUGNCMzVvUFFq?=
 =?utf-8?B?RFFod0lkT0xLTjJDL3dnSG5qbkUwL2FBUHFsWEhoZEI4bHRURXNwUFcvaER5?=
 =?utf-8?B?MmE2ajc4dmg4NXlhVHEySnBIcW9DcS9XZkkxVlJxNEM4Wjk2eXZPVFdHVnht?=
 =?utf-8?B?WHlITXpDR0xHNk0yQmh0SXNqTjNSM21ZVkEvRlQ2ek51VXRIWHlLeWg1bk9h?=
 =?utf-8?B?Q0RRazB5VUFoRS9GalhINHlkR3BpL3lIWkNBWnhXTnVBcVhseHBsV2NBRjcr?=
 =?utf-8?B?M29zMVRuM2dXVzZobHJHRkVwemczVEwrT3VrRTZZTENUUnRCcmFHQmxGa1M2?=
 =?utf-8?B?NmNIQkRScEt3QjVRdUJnT25HUXF3K3k5MjBVczdqeXB1cHJRblp4QTlQakhZ?=
 =?utf-8?B?dldoMDFPVysycUpKbVZvaHdmMThCcUVRaXJQUkRwTCtFWDdYdlFoQ0RuTlhK?=
 =?utf-8?B?YXVBMmlmSXdEL3o1WHFIWTNCOHkzbkE4UXFRN0xlcXcwbHhYbndYTlAzQlNn?=
 =?utf-8?B?YUlSQko2c0NZRjBoTEhpMHc2QUtrc3VGVGhSRTR2WmtoblRFSjdFTWs3UXpO?=
 =?utf-8?B?QXc0dks5UnljeUJxUkE1b0pFZ0NCblpzM1MvZVFZcjNsVUJjSGdCbjdiSGZ4?=
 =?utf-8?B?WGt3N0t1VEtpYUY3bnNuQzZJRmJiN0Z4TGR1OVYzdkpTVzBXQy9nWWpYaUdP?=
 =?utf-8?B?bHoyOWgvR1haWjc5QWJIeVNTMVBpek1qOUJqalBmZTdJZGxqMHRnTzJEbXdl?=
 =?utf-8?B?NkRhZnVENWcyKzJWTGZsdmNQNDdCYnZDakNjMzB1NGhHUnVGL2FOZ1JFa2lZ?=
 =?utf-8?B?MDZoempIb0pOdUNKeUtJVnc3SDBiWTVoUXY3alZWRUxsOW9Fc1dzMkpVbnNF?=
 =?utf-8?B?dmpmbXhtOUlxVDJPT2dsNGk4eE4wL3ovTERkc2gwdms4VUIxVFQ5TGNQNkh4?=
 =?utf-8?B?ekRaSm5sd09SSmx2WHY3QWFndkhJVk13R0w0bVRlK2IyVDhPa2dJMy9GZ0s1?=
 =?utf-8?B?SUNYV254ZStINDNVOThxdEd4SWY1YTJtRjZ0cm4ycG1FWUYyb29yVHV3enh0?=
 =?utf-8?B?TytCMjl5eE5yK0NEWmJQbGZxelhneGRha2FUZllZMjFKOGhhQnFBWUIxa0w5?=
 =?utf-8?B?d1pVeGxiME4zMkY4SDlkQXdNZWxvQkRzdkNqTTRPUnh6enlTcjhCU0pwb2RF?=
 =?utf-8?B?bmQ4Ukxyck41ejZ3RXVBK1lDaCtwd0Q5REkyQ0VIRUNwUEJaYkZYQnBvVGt5?=
 =?utf-8?B?WkE0RENGMWg2blY1V28zN2tiMW01YnhRV3JqRjcvdUZySVpBdTVkNzRFN2U3?=
 =?utf-8?B?TjhXMmxoYUM3bVhzWDk1SFdnTGlweWtNYlJwZFpFT1Z0UythMVhEMUZlMFB3?=
 =?utf-8?B?YUwzZ1JKb09mSVFubW5MVkYxdEdzOWdSWTFwUmpCd0pNZW03Q3pKaDJvdE1x?=
 =?utf-8?B?dUQyQktEUkdqeDA2Mzh0WjhUVkpjc1RvTE4rbG83M3NIZWNSTHdvbm9pWU5v?=
 =?utf-8?B?cVhZaTZUMmg1Y21ndm9HNmFkUGxlZUVSZCthZFVJUXByc0dlY21xWmxnSnNY?=
 =?utf-8?B?d3MzSXFlUDVqeElNYWErdlhEcktQY0NpYnFRRFVCOUV6Kzcrcnd6S1pZeWg1?=
 =?utf-8?B?bzlDVEZ6cUxZWWZoc2VzNUdiRlR1WHFXYnNIeUtac2FIVGJOay8wcXR4aDNT?=
 =?utf-8?B?TFltM1kxY0x2c1kvdll2NDZRQjNnMUtSRUVNblF5UXNrL0d1cHh2QVhmQkhv?=
 =?utf-8?B?SW1DOVY3ZlA1bC95MU8veUhybENCdE9rWFc2citVRytvd1h1WTh3T3ZOUzZR?=
 =?utf-8?B?RDlIbjJFK0xYZEUvMmR6U3lZTTBGK3Ixdml6cmtGU0RJZllORG9KNFVLcVpG?=
 =?utf-8?B?RGJnS0Z5aGZpV3JQcXQ1cVpoWjkxcS9Vdzhac0g4bk5kOEp0cUxyQWR2NWFi?=
 =?utf-8?B?cVpQOHYrUEZwY2ozQUhCMS9aVWx6cGZESDdxV3Y0U2pmTjloVjZmN1cwQ0Q4?=
 =?utf-8?B?QlBHb1V0RGhDdnFwUTAzN3RvVHdvY2NSMmhBbSs2Y1FFZEE1SU5OUFozclNi?=
 =?utf-8?Q?Hmts=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100239c6-1e54-4373-6b5f-08dce8b01060
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 22:16:46.7861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUw/rHWYjijNAUp4wzJ7Wh7+MJZAwWZj4UKPj0TRh5obbyTd+b9xgEQDlyS9JdVx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9215
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


On 10/9/2024 4:45 PM, Felix Kuehling wrote:
>
> On 2024-10-09 17:02, Chen, Xiaogang wrote:
>>
>> On 10/9/2024 3:38 PM, Felix Kuehling wrote:
>>> On 2024-10-09 14:08, Xiaogang.Chen wrote:
>>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>>
>>>> kfd process kref count(process->ref) is initialized to 1 by 
>>>> kref_init. After
>>>> it is created not need to increaes its kref. Instad add kfd process 
>>>> kref at kfd
>>>> process mmu notifier allocation since we decrease the ref at 
>>>> free_notifier of
>>>> mmu_notifier_ops, so pair them.
>>>
>>> That's not correct. kfd_create_process returns a struct kfd_process 
>>> * reference. That gets stored by the caller in filep->private_data. 
>>> That requires incrementing the reference count. You can have 
>>> multiple references to the same struct kfd_process if user mode 
>>> opens /dev/kfd multiple times. The reference is released in 
>>> kfd_release. Your change breaks that use case.
>>>
>> ok, if user mode open and close /dev/kfd multiple times(current Thunk 
>> only allows user process open the kfd node once)  the change will 
>> break this use case.
>>> The reference released in kfd_process_free_notifier is only one per 
>>> process and it's the reference created by kref_init.
>>
>> I think we can increase kref if find_process return true(the user 
>> process already created kfd process). If find_process return false do 
>> not increase kref since kref_init has been set to 1.
>>
>> Or change find_process(thread, false) to find_process(thread, true) 
>> that will increase kref if it finds kfd process has been created.
>>
>> The idea is to pair kref update between alloc_notifier and 
>> free_notifier of mmu_notifier_ops for same process(mm). That would 
>> seem natural.
>
> What's the problem you're trying to solve? Is it just a cosmetic 
> issue? The MMU notifier is registered in create_process (not 
> kfd_create_process). If you add a kref_get in 
> kfd_process_alloc_notifier you need to kfd_unref_process somewhere in 
> create_process. I don't think it's worth the trouble and only risks 
> introducing more reference counting bugs.

It is for making code cleaner or natural to read. mmu_notifier_get is 
the last call at create_process. If mmu_notifier_get fail the process is 
freed: kfree(process).  If create_process success kfd_create_process 
return that process anyway(after create_process kfd_create_process 
creates sys entries that not affect return created kfd process). The 
finally result is same that kref is 2: one for kfd process creation, one 
for mmu notifier allocation.

Regards

Xiaogang

> Regards,
>   Felix
>
>
>>
>> Regards
>>
>> Xiaogang
>>
>>
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>>
>>>> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 8 +++++---
>>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> index d07acf1b2f93..7c5471d7d743 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> @@ -899,8 +899,6 @@ struct kfd_process *kfd_create_process(struct 
>>>> task_struct *thread)
>>>> init_waitqueue_head(&process->wait_irq_drain);
>>>>       }
>>>>   out:
>>>> -    if (!IS_ERR(process))
>>>> -        kref_get(&process->ref);
>>>>       mutex_unlock(&kfd_processes_mutex);
>>>>       mmput(thread->mm);
>>>>   @@ -1191,7 +1189,11 @@ static struct mmu_notifier 
>>>> *kfd_process_alloc_notifier(struct mm_struct *mm)
>>>>         srcu_read_unlock(&kfd_processes_srcu, idx);
>>>>   -    return p ? &p->mmu_notifier : ERR_PTR(-ESRCH);
>>>> +    if (p) {
>>>> +        kref_get(&p->ref);
>>>> +        return &p->mmu_notifier;
>>>> +    }
>>>> +    return ERR_PTR(-ESRCH);
>>>>   }
>>>>     static void kfd_process_free_notifier(struct mmu_notifier *mn)
