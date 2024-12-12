Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A19E7717F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 05:31:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1729610E086;
	Thu, 12 Dec 2024 05:31:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kMzD3JwB";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2C7510E086
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 05:30:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYUuZalo/FPMoAdIwXREKGy4nPspHh5XO6OdEL+dOgt7MEDp+p823JXB5IYSxHSjU2gHPnBgqJ8Bt4sMUtuBEQ21gmtfx6aoC5HHkRBzij6OxHNWLh1PfjHlEZA6umMhfVcCZ0YN5/ZdHFtdv50T1dpLS9X/dfEqIdL80mlqxfeodNpWdRHBogXJsPGHEKpDGDh4xx84SUQ7OLVtbLnSc/peKcugszBxZd+Y4hwj6vrzibltBsTaCfPfySRsR4C4GHpnKOJkcASrToRkPKx0pSfWxh6LkvZ3VZKnnik+u9gY4xxvXkMrZneaB5r7AHj27qP/Azfr2eNQjSoNq8cSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F26QVol22OjpbZtH+eA5XHxfu3SL4MsQ15yu8+fJxU8=;
 b=ENo9rxXe2wf6E8883qZV+A54hBabxTM+iGNOkFViBldBOhLo/O41MKe1jJLXcEFTphlS5dr29oF+ZRSSHKX04s4TWGjNfLMbw67ZQ2liyfK/begBu91irYw2cNfMZHLeGF0ulXBBT+RHwS7aRApgJiyOCp3JPBs7gIpPks1WMxY9jjU+vjgBbQYlOz0Af7s9ZGkqQsdN2lHVIQH20XGKcTW/I0At9vUuzcG9+OptQBiszr7plSinNHtlxv1afGFuZyxA8xRem9bH3McxP2OK5aogcnK0YM5yx+Er1roy5kfAm98+x1VHy3KLNDxDfHZ31mGMmb+pRr60Em+LOBGdLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F26QVol22OjpbZtH+eA5XHxfu3SL4MsQ15yu8+fJxU8=;
 b=kMzD3JwBM5jtIelFw3gaBRcSibJRhgVyvlcEioeVlTVZnE2is/0l0Ut4iSpCf37L6us58lLutpQXFFaWJbE89p44Cic38YW5jTaYZDnA6fEWJZ3mqYD7YEyhXuL0AgNsRpoJ/TYJc9OeenLqaiZ1qD1YPJj4iMFfTePqf+7mkEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by SN7PR12MB7108.namprd12.prod.outlook.com (2603:10b6:806:2a3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 05:30:53 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%5]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 05:30:53 +0000
Message-ID: <40a93b94-dbb4-4d30-9ba8-0b0185e1fc1b@amd.com>
Date: Thu, 12 Dec 2024 13:30:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: wq_release signals dma_fence only when available
To: Felix Kuehling <felix.kuehling@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241212030611.8513-1-lingshan.zhu@amd.com>
 <0a02fdfd-7771-4a8d-be15-1e8eaa6d631a@amd.com>
Content-Language: en-US
From: Zhu Lingshan <lingshan.zhu@amd.com>
In-Reply-To: <0a02fdfd-7771-4a8d-be15-1e8eaa6d631a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0122.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::11) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|SN7PR12MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: 1edf7f3d-68d1-4054-bae0-08dd1a6e2579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0hLZFZWTmRmbmVPNFBTVDRERjBmd0tOZEZ2YjFFVHpyditNMFVqdnVLT0cx?=
 =?utf-8?B?ZFlVcko3NXFkZFBtMUxYdTdTOStmcUV1YmVqRlhZVHpGbVBZRnB0dEJrT3E5?=
 =?utf-8?B?RWZyWmp3andZYVkrZlRUdGJOb1VMcnpLR0JvQU1vM2lBM3ZpTHkyMjJzR2U1?=
 =?utf-8?B?YmpMVEFIcUVmcjRDWU9VTDBWTXhmU3g0Y1pnSGFzRG9DQ0xxY0ZtaUcvb1Ix?=
 =?utf-8?B?QmxJVlQvRzBOSGlOZ3Vvd2JieGNlUVNWaFk3T01FZWxPSFJ4TlJrN0hja3Rw?=
 =?utf-8?B?R01sSWpKd0dMWFhiTSs5OXNBYnZYR2NISkZJUCtUZ2Zyc2xxaHZjdkdFd0lE?=
 =?utf-8?B?Y3VTWnJMR3lTR3RQWE5wdUp5YUxieFFTRExuWnpPcnNpYUcvTDB0WVF5RWh1?=
 =?utf-8?B?cGJ0UytVdGxRc0ZmWDU2ZG9YOFFZWk9pVTRrU0UvdnBIREZMY3piSlVITEln?=
 =?utf-8?B?Qzk2RlE4Q3FZK0hKQW1vRmtIb2hPb25qQTV6VDVtajQxalNPNmRoeUpRbVJT?=
 =?utf-8?B?eTN3Y0tVODB3QzV1SDVTem1peDljKy9DZzR2Um1OV0lyaTBhWGh4UXFiZDhN?=
 =?utf-8?B?Yi9CblRab3h0MWw3RnlTdkZZNUJNcmQ0UlZJSjI5SjUyMW12TDFOYnB4QmdG?=
 =?utf-8?B?RW1xbUhURzR4SzNJeHVLOWZCQ2ZKZ2VLTDNTV3BIdUc4Y1hzWFRZbFE1Z3A4?=
 =?utf-8?B?MHdNR2l1cTQvdkRud2RMVzFQYmVYdmJrWGYvbHo4RTY2Q0FLYnlubW5vUkcz?=
 =?utf-8?B?WnVYRHJ0UzZ0OVdwenFnOThDQVJEUUFFYUJONDhCTi8rUkd5NEM5Q3pmQjdR?=
 =?utf-8?B?eEhIQ3IyV1p4clQvUGh2YkJIOFV5V0FZZWRYdHRGZDkyc0dnazNyZVU2Sk5O?=
 =?utf-8?B?UVBWaUZaL3llUm5CQzVPdjF1RkpxdGtCMVZiNnRFV2dIV1V0aytsVW9qdkNo?=
 =?utf-8?B?TzRYekJkY0owU2JhbWJBcEFSYjhPbkJjekprblZmb0ZGT01tNGE3aHB3dTJs?=
 =?utf-8?B?ME1weHV1UVBjalJqRk5JdUJuRzBYcGFSZ3o2R3lOWmdNdEtGZWpneHhHRTho?=
 =?utf-8?B?ZWZscllnaXBITVFYalRFcUVTMHdRYXJKWGpWQXVBclUzTXlBdUVqUTAwYTNx?=
 =?utf-8?B?RGQ4Zjd4Q1FEckFsLzAvSnNmUEdobll2cDNvZmU0aFdySzNSTlZSVFFwYjQ3?=
 =?utf-8?B?M0RwUlU2MERURjMwZ09HMkYwNWpaU0N0ZnhBNGx6UjFPb0NTS2V0T2NXUnJV?=
 =?utf-8?B?enFsZDFrdUhVWUNhbjRWMU9EMzhGOExKcHhmVWN5bEJGM29za0poRVZrUjlz?=
 =?utf-8?B?SGNpR0tEWkRqWVZiRFRCbnZoQ29IRVl6QzdGL0hrRDY0aHFBdEl0SFR1cU90?=
 =?utf-8?B?TllSeXhhNm16Sm5XTUxFa3M0MGtac2NjQUZaa041UlMwYjZYcjhXWmZvZGl0?=
 =?utf-8?B?RGdicWs4NTNVT3BYS1QxMG1Ra0h1dmw4ZVBQU2lzTU9ETlBScWxwejZQOUJU?=
 =?utf-8?B?b0szY090Wnh4SUlNRm95MGRuZVhxV0JpWHhmQ20rbVpCWDBYM0hsKzc5cTh2?=
 =?utf-8?B?Q2ttM0ErQTJCTzQ1WTZCbWJiZmIremJvcVZKaGp6NzR5UFRWdWlqUkVmK3R1?=
 =?utf-8?B?YzdiWWNoaktkZHpZSy9DMjNZcStkQWVsTGRJYTg2Y2NpaTBtcE9ORkhWUFlY?=
 =?utf-8?B?Z2NQVjFhZURmQ2JaLzd1RGVBYUxtRFhEaW5ZQXZGTzRHcHRwWGgySzFJdXk3?=
 =?utf-8?Q?LSam1sTh4XKIzuBPv0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHdFckhWRm93SkRsWGNKSzZockdCQjZ1OHNBQlU1V296SVQ4YWpLamVLaWgw?=
 =?utf-8?B?VEgyakU5MEhsa2QrSEVpWkNCTTlnN2JLZkNuT2R0VkYyVVpvSzREY1V6VGZ4?=
 =?utf-8?B?Z3Y0a0lMd3VSMTc1QmhYdkdQenc2SWxzemUwN1NKaUx5Q2JiaWtFOFQybHF4?=
 =?utf-8?B?aE9EMUV4N2xPU094ZEliOVJtWkZwYXUwZjBBNXcrQTJDRmZEUnl6WXRXVHZ6?=
 =?utf-8?B?dlFmaUpobzBEa0Jsczc3b2F2WWxLaVQ4aWNuTHB1YmpYUFVtcWZ0aXl5Z0xr?=
 =?utf-8?B?bHpzMk1SemlaWm5YdzZGdTVyalEycGlvTWp4MnprUkdoNDlqSmwvWjdONGFo?=
 =?utf-8?B?Rk5qamtpUFJGbGtUVUpKNUdROFNqUmlzaWpxZVg0dnpyK3l1NUpCczF6VXlX?=
 =?utf-8?B?VXdWNU0zQVhaNkRJMk1RMUoreXk5UklHdEthV0NUWEhYV25FRlNJczVyTGg3?=
 =?utf-8?B?SVo2cmxrVDRMd25kRGdSNC9EWEMzejVmT3ZYZGFrZ2l1VGVJR0dPcWVmZVJy?=
 =?utf-8?B?dHVWSDU3Z1IyTHJTbmZneVFPWk8wdW5YUVZBT2hYMHFzWkNqaE5xUW1CYnpW?=
 =?utf-8?B?L2lOTjR1cW94RjFmSndWOERoKzdoMGc0azMvUk5tYnE5SDIzbGNNRjgrWlRZ?=
 =?utf-8?B?VU9BV094ZmR4UEtKeXU2ZnhSczNsV0hORVh6RXhVLytsaGVXOVdjTFRVYVhQ?=
 =?utf-8?B?Yml6ekd1NEwwSktYVTBoZmNHWTNjRytPQjZlTHYzZ01wSEhmaDZzQklEWnBm?=
 =?utf-8?B?d1ZGODRWWTN0a2RuVnFjZERaL0Yxd0JJdWpVWkw2Qm5LRkxLYU5aS1U2MnZo?=
 =?utf-8?B?VEI2WFN6OWR0bVREb1NTSmp5QlFZaWdWSmRUWjI4cGRVdENMZTE5NkZlV3dL?=
 =?utf-8?B?U2VVUWUydUorMGE2eEVKQzhZQmtKckhvcWxoYnNubmhIMWVVdnpGOEEzT3lr?=
 =?utf-8?B?MUpEcEJ3L1EwQWs5dTRKNGU5RXM0ckhLMG5PUnlQeXQrcEVnV3lvY0kzS0dJ?=
 =?utf-8?B?RGhZdnk3V2dPc2xoSnZEdEtwTlJVN1JDUjI0NWRGRW9MWnVOVDVoZ3R1QUd1?=
 =?utf-8?B?TVB3UmY0U01sdE80VWs1YkRydnRuM2dzQ3lrR25ldU5KalJhMnhzOXB2bVpR?=
 =?utf-8?B?bjdVREpua2ZYQTgxZnRlSjFrdjZLYUJHV1N0SEw1Zk1SVENBVEt2V0MvN3JI?=
 =?utf-8?B?ZDZwdGtNUWpPRFJlOGszUHk4RTdnOWFQUGRkMitkQlNOOVl5YkNlMzc4OHJR?=
 =?utf-8?B?WlJNMHRHbDBEdWZ2NGt5eGdhTzJjV0FTQmdkak1SZFF2dkh0L0JMbEtiVk00?=
 =?utf-8?B?SHpuZGkxTmQ3eThCSVg1NGR5NWlvRDE5U2g0Qk0xdlQ1b3UrVjNYeWlmZi9k?=
 =?utf-8?B?T2xFRHBDWE5lckU2L0lsdk54UDI2WXlGcVQ5UFFRQmN3d2pROGtIREw5emFi?=
 =?utf-8?B?UzRoeWFnMy9wamgrM0EzbHVNTGc1dFBEdkVxOEF6ZUlBWkVkSDgwcTM0aGdZ?=
 =?utf-8?B?VW9Va1IvRTZhelUwRU81RWNOdWt1ank3dlk1SWdUbkw5YXJrcnlCNFgzN2x0?=
 =?utf-8?B?eUxFYkRRcEc5bjMxYmhDbEpjZGlnVjgzQXFhOFMyNDZETTA0dytRNXdlSzNI?=
 =?utf-8?B?OHBYMEg4ODc2WGVhRUNPSzExSWRhLzc2UWlZQ3NTTlR0bWdDTjJNbHNSTzJV?=
 =?utf-8?B?N0tSekZ4cW9mVTYrRityWGdaTjN1bStYTjdtRVBpZEhBYkpQb1ovOUFNeXN2?=
 =?utf-8?B?dHU2bzMzV0FaUkVkTExIcXIvak9oaDlmcUlMa2ZOWGc5WVR0a2diVzR4TGsx?=
 =?utf-8?B?bXVFTGdHLzVMZjJpc0ZuektzQTBUMG82RFdKbWdUMklHTTliZzFKTXl4M0JO?=
 =?utf-8?B?NmlkNFpIaTVmd3puUGpYYXhScHNiTWdRN0NFOFVnRDJJZnlBUi9VOW9vRi9Y?=
 =?utf-8?B?eDlBZzRjWVVRVnNqd0R3QThGN2d2anpyR0RDQVlpdU5WTUQ2c1dYMnRkRFNx?=
 =?utf-8?B?emNKeWpWWjFJZ081ZFpzaldKelQ5RWJjV292QncxWlR3d05wcFA3ZVdmTjBZ?=
 =?utf-8?B?VjA4UmFIL3g3YUJsQ1ByTCtnNVRJY0NtTnB3SytoZ1Fpak9XMXZSM3RBSWRI?=
 =?utf-8?Q?+x/sNsv3T+obX7cIv1jJtK7qZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1edf7f3d-68d1-4054-bae0-08dd1a6e2579
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 05:30:53.6413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7VaVyQkSK6lAT3m7W8YrBNKDBp4/OqXT0makv/vtAze2P7eQsJo5E3yWNChVqJTXXWhePLLUCDvM+ndE4gq6BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7108
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

On 12/12/2024 12:19 PM, Felix Kuehling wrote:
>
> On 2024-12-11 22:06, Zhu Lingshan wrote:
>> kfd_process_wq_release() signals eviction fence by
>> dma_fence_signal() which wanrs if dma_fence
>> is NULL.
> That's news to me. Looking at the dma_fence_signal implementation on amd-staging-drm-next, it just silently returns -EINVAL if the fence pointer is NULL. I see the same in Linux 6.12.4: https://elixir.bootlin.com/linux/v6.12.4/source/drivers/dma-buf/dma-fence.c#L467
>
> Which branch are you on?
Linus tree, latest master branch, tag v6.13-rc2
https://github.com/torvalds/linux/blob/master/drivers/dma-buf/dma-fence.c#L467

which is introduced by
https://github.com/torvalds/linux/commit/967d226eaae8e40636d257bf8ae55d2c5a912f58

Thanks
Lingshan

>
> Regards,
>   Felix
>
>> kfd_process->ef is initialized by kfd_process_device_init_vm()
>> through ioctl. That means the fence is NULL for a new
>> created kfd_process, and close a kfd_process right
>> after open it will trigger the warning.
>>
>> This commit conditionally signals the eviction fence
>> in kfd_process_wq_release() only when it is available.
>>
>> [  503.660882] WARNING: CPU: 0 PID: 9 at drivers/dma-buf/dma-fence.c:467 dma_fence_signal+0x74/0xa0
>> [  503.782940] Workqueue: kfd_process_wq kfd_process_wq_release [amdgpu]
>> [  503.789640] RIP: 0010:dma_fence_signal+0x74/0xa0
>> [  503.877620] Call Trace:
>> [  503.880066]  <TASK>
>> [  503.882168]  ? __warn+0xcd/0x260
>> [  503.885407]  ? dma_fence_signal+0x74/0xa0
>> [  503.889416]  ? report_bug+0x288/0x2d0
>> [  503.893089]  ? handle_bug+0x53/0xa0
>> [  503.896587]  ? exc_invalid_op+0x14/0x50
>> [  503.900424]  ? asm_exc_invalid_op+0x16/0x20
>> [  503.904616]  ? dma_fence_signal+0x74/0xa0
>> [  503.908626]  kfd_process_wq_release+0x6b/0x370 [amdgpu]
>> [  503.914081]  process_one_work+0x654/0x10a0
>> [  503.918186]  worker_thread+0x6c3/0xe70
>> [  503.921943]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [  503.926735]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [  503.931527]  ? __kthread_parkme+0x82/0x140
>> [  503.935631]  ? __pfx_worker_thread+0x10/0x10
>> [  503.939904]  kthread+0x2a8/0x380
>> [  503.943132]  ? __pfx_kthread+0x10/0x10
>> [  503.946882]  ret_from_fork+0x2d/0x70
>> [  503.950458]  ? __pfx_kthread+0x10/0x10
>> [  503.954210]  ret_from_fork_asm+0x1a/0x30
>> [  503.958142]  </TASK>
>> [  503.960328] ---[ end trace 0000000000000000 ]---
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index 87cd52cf4ee9..47d36f43ee8c 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -1159,7 +1159,8 @@ static void kfd_process_wq_release(struct work_struct *work)
>>  	 */
>>  	synchronize_rcu();
>>  	ef = rcu_access_pointer(p->ef);
>> -	dma_fence_signal(ef);
>> +	if (ef)
>> +		dma_fence_signal(ef);
>>  
>>  	kfd_process_remove_sysfs(p);
>>  

