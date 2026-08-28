Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73C9C61DCB
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 15:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28AFA10E3EB;
	Fri, 28 Aug 2026 15:46:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hGwSRFRU";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011011.outbound.protection.outlook.com
 [40.93.194.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0088F10E3EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 15:46:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYFTcdInf5eMLXRjCJ5YcO7Il780pObNXJid+dGpFy7iNYi8wOkOxg7d4AY6VYuZpmkyC4Rb1D/MMInV9ffDRrZhnr8ZCrGZp2nWrQk0cM7OpPUisIDaPwc+ivEbEpG2jziE5vFgp5iV1IVDbdQDK5fzX7mRx3TXVA0uO9X7cNqa9pHoJ7RFnAm+10aXKgZ9J0oBIcbSNERvEaQ79wABpKpTVTv6Nkomy9lFnKZKUZ5UaHY1rmnE28oaM8jNuGt1y8TgVmOx8zBG0daOCHU/yIK9/efiychX5p2nSvoM0jhFjByys16xvAQBu4urmwQRjqzNZgR3TkKT4p29ZkRS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+l51dHGk0smVUlyz+a75syZA5EFmVoVLJ3Tzu2WclOs=;
 b=aGTXLhfkumlnn3Y+pz7IR5Nn9aJb8jpzU3E0sh0oq9fPv8TUM6H+AqONlt3jDcPayb5WIQ6NXNnMMGPNdWIqyCdixNUlqurJnyUSw1HLCygTh660B+zdra0EQLsYkmjHUxq3psZn01rJUMiRziU3y8VTHMcAAeAPC7juEhAuKhVm8gK2TGrhzcKLWGSh0h7u0y13XzFnbF+rn9keAr4Al+LiEB69gLEDnpFQhCMs5UWZLRtAEWjmLDHsqL4N5jjZlLlm0WlWEvNmCLFmbkFzKCflpuXNPQvrS2SUo0ioxQTQAyHz257T62+HU3iTkN2P1kMokp8Bok5v+QNobhWNQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+l51dHGk0smVUlyz+a75syZA5EFmVoVLJ3Tzu2WclOs=;
 b=hGwSRFRUvIq4X934qQmi6/EO2FskR+B0XCKDf7ICXLWqHtjsXe5ye8HswO2fEWkK+iOWPB9ah2wAIiNJCU0YmdcoWBTfoKmSfAqLRA6gz1xdLYo/pk7Rqz7legtA9UtPyPrivpPMX1ePJ+jAs0pCDo8SJtJYI6dAQJinyY9SYcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA0PR12MB4352.namprd12.prod.outlook.com (2603:10b6:806:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 15:46:48 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 15:46:47 +0000
Message-ID: <f23512ad-4fe1-48cf-988a-25076e20e1ae@amd.com>
Date: Fri, 28 Aug 2026 21:16:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/amdgpu/sdma: Use common SDMA legacy queue reset
 on SDMA v4.4.2
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>, Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260828120729.25908-1-timur.kristof@gmail.com>
 <20260828120729.25908-5-timur.kristof@gmail.com>
 <5158d162-f60c-4ef2-b2a2-cc544e1915f5@amd.com>
 <INK-tdebRIGg60kuZ_quww@gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <INK-tdebRIGg60kuZ_quww@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0146.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA0PR12MB4352:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e442738-eb3c-498c-6c75-08df051b91ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|56012099006|4143699003|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 0o9LH1+OyrAn2vl1wbm0qBTC2mDwDlMg0ywWOk9Z36wRokSxIoxEFuL3RgFJYgipPRbHwtRg2JDMWWvZuTkDVXlimvO6hXM/qmqEX55S3WL5pV2xItD7xMOADB9qe3KDB0+gOpCVfIM5LklBrhzOT71vUZ0lgHWXMHjlZHQIpStzf1wuquHyUe2SmsrGemmzqQImFs/uiaiUstsqWfov+xwcUEL9btAKFfBqkBltKl6QsYg065hoj1rAHOhbAPB7rFycFOjxt7wtZ65tj4jxLke3/lbrl6+M1xlqKrOhAhwFeu80iWijT91eSSUtfvS6xlGufqIF7oBzOfmbyiJNAHn9uF3aiSGoLXqA5S+Eb/cJt7C+AW0a0tzMJQcDU51qnQD/p+RwEK0yBq2GrlWDzZjFuIJrmldMKzYQiwGnjYcfrv7Fwq1Jd+LL36Ym5nT+/UYUxRLvHDm3Gep00l59VPnrH6BJXjqA3ItFDzvZr9qL0WoWJl2tJFeAAQtVaLzGG2zkk0GRvY0cv49+V6rXO4UagXdJGue7ZzbcT6yxS9azmrrO3/YzIP0mC8oxwBn3EeVy8eqfbKxkSOyg42j8vFuOX0gfM8pURhHKkWs8KtSNF+TqV0x6lwO6ua6Bn5ZEkYmvjK8GOmgto0ICn3J/4S4OVC2E6wANnBvblj4em1o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk55NnhiMUtQVVNVOStqbnZZdFdTQ09WM0ZVaUsvQkNtVjhiaTVkZjlQeDVF?=
 =?utf-8?B?WDVOVXQ3TVpTcnFmbGFtNmtJSHY4WS9YSGx5bmpDSkpKKzUwS0cvTnRibFBk?=
 =?utf-8?B?VjNLVEZGZlBxSk1jOUVQbEJUb0tIbENDYktFUlIxc1VydlF2cWpiZ0oyTTJV?=
 =?utf-8?B?ME5DSHpLYXhJZHMrN3NaUjl1eWZHbERXTm84eG5uWFBwMXFqem1NbG9Ba2xk?=
 =?utf-8?B?L29PQVc5djFZMFVrMmhrcnFPWEUxOWVCWmZaMVN0aWZqN1A3YUNpUUNuQ0d2?=
 =?utf-8?B?QVljdTBxMzc3QnZMeGJqdmc5bVkyNmEwc3JnNG9WQ25RclV6N3FkNmtMa1Zi?=
 =?utf-8?B?NitCN0JESmkrNzRRV1M4akxiamZ4RDJyUER6VXZNZkFGSVp2ZVNNQ1FjTnRJ?=
 =?utf-8?B?akRNQTUyVXRvNEp4VTVuOGtvU1lRVzNLNzNCMy9lVXNNQ3RSbUVxZUtnSDdo?=
 =?utf-8?B?WUZOS0NHSVc1TVFzYzNOZE5BYUMycjJsUWNkRGFnSk5OZXRjV3RMUWEzQUVu?=
 =?utf-8?B?UHZ3MWZRZFNQR2hpenUzc2grNDdCZlRmekl3ZDJuZGdlY3VoUGlZcHlpZ2RW?=
 =?utf-8?B?QkVPRER6NndyWTc5S0kzVVNJek9hZzJINlVvMzRlQmdqK1Z5SnFNYTJodnpR?=
 =?utf-8?B?Qm9RVE9KV3l1RUhtWXZVSENWVW5xU2FjN0hqY21HLzYyM1ZDNWFWdEd2ZjhC?=
 =?utf-8?B?aUN1a0hMUzQxZWYzQzB5dUhrMVd2MjJLak1CL25FY2RXMjJoWmtVNnRDT3p3?=
 =?utf-8?B?a3BoQTQrUWFiai95MGY3eE9DMStnWmkwVTBidmYzNGR4Q3ZjZThrSzF0SVp4?=
 =?utf-8?B?TkFTT3VIOUtLSlV4WlJKUExsVHJwdlpWYmN5WEZ6Tzc1TUcwc2gxaTNHcmpQ?=
 =?utf-8?B?ZHdhV2pLeUFWZkRGTUhsMjZoMUF2Vmg1Z1RqRXkzVURGVmRwUXdDbkx2NU5s?=
 =?utf-8?B?OTlZdWlSYW1hUzR2OUVBdFU1bEZjT1ZlRWE2S21STzJuSGJLNml0NlJLUTNv?=
 =?utf-8?B?RXdxNnlFUzkwWnBIWEx5Zm9BczFXTDhQcWZiZlF1UlpVV0hxVmRrZzFkU3Rw?=
 =?utf-8?B?a1ZBbkZPTjZnU0VuV1puaDRvWk5OeDJIL3VtL1Z1M01NcWdYS0NZSlJ3SGgv?=
 =?utf-8?B?RmNaVHlJeSttekdIYzdndlNkdTVuQ2xpMFZnVWthdys0MmwwWmdTMGd3UkM2?=
 =?utf-8?B?dVZ4MXNzVmhVRmVIYVF4RTF3VUtOSU95ZlRyaHk4Q05iME10dWJjLzdCSmZJ?=
 =?utf-8?B?bHFGbE5IL3N1NXVIY2duVWtCN25RY0xJbS83Ly8yS3IxaFJmSnF5bnBpSFI3?=
 =?utf-8?B?Nlo3R3JEb2UwTkZLY29QOGZIeUVhMm1FWGVDYlAvb3BEdnNyb3BkTkYvazJD?=
 =?utf-8?B?VnpNcHBwSk9tVjRRWkJ6MGdBZHdTeU5KR1VPVFFNb0ZBTjlDNEJkUEVud1k1?=
 =?utf-8?B?cldUUjhINlVFVXZBUHVqSUdKOVVjMkE4dEpnK0NYS1hMZzlaNDIxYVdYUXdO?=
 =?utf-8?B?QmQwVFFuSklkbXpDUzVMbk96UVFXTmhhYlJLOWJsK0M4cURabTIwVUhEc0dV?=
 =?utf-8?B?MWxXTTJYVzAxVHZiRi8yUTNCQVZBbVYzZG81TWhrSVJSNVo5aGQ4aExJMVlw?=
 =?utf-8?B?M0ViSXdrdU5DYkRLZHlCdEtxa2ZlRUlzZzlNaGRBSWhIa0pVN29VbjBEeDBT?=
 =?utf-8?B?WU14NDJDZDE0WXRUeHhNampVWTlBN3J5R0FxRTNmM1UvdWVEUDNIOWNmL0Rs?=
 =?utf-8?B?WklidkFFMFVpZitMc2NtcEk5ZGtzc212Y2V0V21MWFhQWHFJK3piMGFwc1dm?=
 =?utf-8?B?a1NpeHRyNnIzZU1ESHV6K2Z1ZWNoRWo5dXdYakhvZGg0VE0xVXpjM0FWZHNR?=
 =?utf-8?B?M2JVL1pLb2ZsN0Fscnpma1JQaVo5YTRWbUtPQWhRVEhiaE9qd0RsS0NmeklC?=
 =?utf-8?B?RHROMHFmOXBiY2Jvbzc0bUZaK0RkM1NSdGxGTnZRQWhpeFIwRkpSSzNHWmor?=
 =?utf-8?B?WG5LdlhtR3NjZHA2cS9wK29HVURhYmJ5VkVVMlpoczlPMm94UkdYeXlvRkh0?=
 =?utf-8?B?NUMyTitDaENRckpMcEFEa1BydFliSDMvVFBxRTRUajh3SHVMSnAyNTlFS1dm?=
 =?utf-8?B?ejA0amJpOG1DWlE5ZVRid3Yra3E0RFMrcDJFazFSaEFBbkZ1TFdWSzRHRDNU?=
 =?utf-8?B?ejZsMVZUZDhYaEdrOFE1SFFUd1lsWTMraDlqSUFzcFFpYnIxQll4dW5lWEZ2?=
 =?utf-8?B?V0p0UVRsK3RvVUFaMXFhQ3ViVXNyTTNTZjVtcjY1NWZEMVFmbkM2Z2lJNW9j?=
 =?utf-8?Q?tpw6tR74hw3OUrBjW5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e442738-eb3c-498c-6c75-08df051b91ad
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:46:47.8922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXLlASu6vYI5ez44SkSYVUWVjFw1Ms+SOZd8HkukuA1orwTV5UXd29IDSIlHzzXO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4352
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



On 28-Aug-26 9:06 PM, Timur Kristóf wrote:
> On Friday, August 28, 2026 4:16:15 PM Central European Summer Time Lazar, Lijo
> wrote:
>> On 28-Aug-26 5:37 PM, Timur Kristóf wrote:
>>> Besides sharing code, this additionally adds support for
>>> restoring queue contents after the reset.
>>>
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>
>>>    drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 18 ++----------------
>>>    1 file changed, 2 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c index
>>> 72ea9db939b4..023821848531 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> @@ -1655,20 +1655,6 @@ static bool sdma_v4_4_2_is_queue_selected(struct
>>> amdgpu_device *adev, uint32_t i>
>>>    	return (context_status & SDMA_GFX_CONTEXT_STATUS__SELECTED_MASK)
> != 0;
>>>    
>>>    }
>>>
>>> -static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
>>> -				   unsigned int vmid,
>>> -				   struct amdgpu_fence
> *timedout_fence)
>>> -{
>>> -	struct amdgpu_device *adev = ring->adev;
>>> -	u32 id = ring->me;
>>> -	int r;
>>> -
>>> -	amdgpu_amdkfd_suspend(adev, true);
>>> -	r = amdgpu_sdma_reset_engine(adev, id, false);
>>
>> The common one passes true, so this doesn't look right.
>>    	amdgpu_sdma_reset_engine(adev, ring->me, true);
>>
>>
>> Thanks,
>> Lijo
> 
> Can you please elaborate more on what you are suggesting here?
> The caller of the queue reset is amdgpu_job_timedout() and that function
> already handles kernel queues.
> 
> 

It passes a false here which takes care of both paging and gfx rings. 
The one in job timeout is a generic one which only looks at the hung ring.

Thanks,
Lijo

>>
>>> -	amdgpu_amdkfd_resume(adev, true);
>>> -	return r;
>>> -}
>>> -
>>>
>>>    static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
>>>    {
>>>    
>>>    	struct amdgpu_device *adev = ring->adev;
>>>
>>> @@ -2133,7 +2119,7 @@ static const struct amdgpu_ring_funcs
>>> sdma_v4_4_2_ring_funcs = {>
>>>    	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
>>>    	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
>>>    	.emit_reg_write_reg_wait =
> amdgpu_ring_emit_reg_write_reg_wait_helper,
>>>
>>> -	.reset = sdma_v4_4_2_reset_queue,
>>> +	.reset = amdgpu_sdma_reset_queue_legacy,
>>>
>>>    };
>>>    
>>>    static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
>>>
>>> @@ -2165,7 +2151,7 @@ static const struct amdgpu_ring_funcs
>>> sdma_v4_4_2_page_ring_funcs = {>
>>>    	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
>>>    	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
>>>    	.emit_reg_write_reg_wait =
> amdgpu_ring_emit_reg_write_reg_wait_helper,
>>>
>>> -	.reset = sdma_v4_4_2_reset_queue,
>>> +	.reset = amdgpu_sdma_reset_queue_legacy,
>>>
>>>    };
>>>    
>>>    static void sdma_v4_4_2_set_ring_funcs(struct amdgpu_device *adev)
> 
> 
> 
> 

