Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9990DD41C33
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 11:38:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50EBF10E0BF;
	Wed, 13 Nov 2024 11:38:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jUBLIIRK";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 286B910E0BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 11:38:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kb2vOeBPl6umG9qhf4qjbs+/Dg/OaRGOYAjjAlAYFF5CuuGsC4E2oZ6hnqc6ahFCzD/fmhRCkGo3CXO8MXS3jRSUJXoGciwShtUu3H4XLv+CH/7T5WqNWvNjuNaSBH/w7FBFjTm1YtT+nkFNM6nyAPcn5XgS1zGwAUFjppQ+NXAqoldWT+CzAI3XlFqbyNE6NEDS/9plBzoatimEHUxZJW5dz7ZsvlcETf7EtBwA2GBD52h/CtjFU/9eQxr7YNEoZ3w1xT/KoDABYAlrENePD78FNPRcIqAg9tFo2DQFBRKX13nhxFT8e8AUFsH4ZykVCvpRDuEIEu48vnpSN9PLwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSH5ocePN8/rdzdjGChAZ56GKA05TUwNnPKrAV0+a7c=;
 b=NTnz1X1n2GPh7F39Wd/9FkzYu3izGELkwvdYhlTPAFxBydwlLtN/cfGReU3dLh7WaQCkhqXj3SwyUBwrvTYrX1eTrhq7UYFSO5CSHWAL+wftKKlBuVKdQyLlWko8I6IQeQsYZZh9JiBmzF+sI+CnV5VqNOkyAMCzuds9n8slSSxJJQoBMD+RAikLMRNfNeCj7oT/MQ6KSXbW3MZO+nO0c8jZWXvd7l+ra893ogKNGb0tOGAeLgOrBk/GutF34hVvbVx/91t+wlXloMUpS1VBRNF3FvO/a+b+hU8hYLtwxUpVofWKSRnHrHsvc2OdLzVta9yLdV9WTnDhQws6nburvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSH5ocePN8/rdzdjGChAZ56GKA05TUwNnPKrAV0+a7c=;
 b=jUBLIIRKvwhGY7cO0aarlIHqteE1cvHSMzfgr+mZS+E1sCE6B4TiMeeQvJOQ1/PzIOO4ofaj4G36v92DhVoRiIXXdEBC2DHUSdXmYAkn++ZxvFNgJ8vnUIZBy4eBVsEIonn7QwjChEQP8CNKDKu1mG6Pnks/5gMqZ6YtmEEf1Ts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB9016.namprd12.prod.outlook.com (2603:10b6:930:c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 11:38:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 11:38:38 +0000
Message-ID: <eed6b35e-912a-4d7a-ac18-643d571f6e03@amd.com>
Date: Wed, 13 Nov 2024 12:38:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] drm/amdgpu: track bo memory stats at runtime
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20241110154152.592-1-Yunxiang.Li@amd.com>
 <20241110154152.592-5-Yunxiang.Li@amd.com>
 <5d1c88a5-9802-4bb7-b76a-5e501847ced1@gmail.com>
 <SA1PR12MB85998D24DDB5EB93AE88E5A1ED592@SA1PR12MB8599.namprd12.prod.outlook.com>
 <92be210e-b552-45ee-9322-1944a4bfd325@amd.com>
 <cc63f0ef-e152-49fc-90d9-ca695a8918f3@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <cc63f0ef-e152-49fc-90d9-ca695a8918f3@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f9a1e52-8844-4a9f-a5e2-08dd03d7b75a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2EyVk1tNzQ1VkNEdFdrK2l4Z0lDSXI4RWsxbTBkdFp4V0lKd0JjbXoxOHFa?=
 =?utf-8?B?Z1dteDgxS3J4OUFoTmhmTUZlSEVEdkpSTTRqVnh0aC9nUFVpSXhsWTBRbS9X?=
 =?utf-8?B?YnJOcGVqN29VT2ZtMzZrZDF1WkdibldiT2F6SUt0V2pEdXhvUThHNXdKbVBO?=
 =?utf-8?B?UGtzWVZBVUExNkRoNEtheERoTytGZFN5czAzcHkyRi85bjJyd0dyOTBOdXhv?=
 =?utf-8?B?Zjc1QU5YbTVveUZKZ0VkRERPbVlNZzZnRU5TZEtsYWxaWVNSTk95MHZCUjFX?=
 =?utf-8?B?cEJSSkQvN255TXhZYVlTSTIrdjdUWUNuWCsxMHpUc09IVllqLzN4VUVHd3BH?=
 =?utf-8?B?ekk1NnFHNXJtNlFEMC9OMHBFRTdJeVJpSUUveDNVNys0aW1zMHhPYU5OZjFJ?=
 =?utf-8?B?MFlQWnRYUnV3MlhLbHF0VGNpTVhQRFN5b0FIellXOElYeFRKWU5Zc0R3TGhL?=
 =?utf-8?B?d1daV1pQS29BWlVaOTVLYm9ucm9Fbko3MkFsdktIeUtKVXcrdU11QlVkOHVJ?=
 =?utf-8?B?N3JEQ2NqTlNzOVNkT2orN1o4akxEOWtITmYwejArems5WG4vQ3VHeTRvdkZG?=
 =?utf-8?B?Wm1GZjhwTzlMdGNRcWRMWmR5VitJUjdidkM0UHg1blkzYzVsN3FqOHpEcHk4?=
 =?utf-8?B?cDVoWlE0NUdEbllsMVFlN01nVGRyb0ZrZUpqQXFqUkFGaXl5MW1Ia0JBcHk5?=
 =?utf-8?B?WVRiWko3K3ZBdnU5TWF3ZWVodlpBSGtkVzJ2ZXhoU09MamlXYmJzQlNUR25M?=
 =?utf-8?B?Y3JDamVTOGdoMzh4bDFnRDlZVU01a3ZaMnd6YlU3Rnlxd3pzY1pZUzBOTFJT?=
 =?utf-8?B?bjdWcFlUYWlqTGlWaUh6cm5hUnVXWGZrcDFrOU5zZEI2ZG5MRWxRcGNSRjlw?=
 =?utf-8?B?N0JTL3JrUHY1cmJOU0ROT1NzRS9RZzVXU0xhdVVKNUw5OWdKWmZuMHY4VmFV?=
 =?utf-8?B?dzVlbUluK3lrWnEzYkNUT1ZCNmxsVTBLUHFrUWFacTd5d2ZYaDJoVCtERjBB?=
 =?utf-8?B?LzliZjQvK0taZjlVNStpNzVHdGF0SkYwT1lDbFloelhMeTNxTXBQNkcrWW9n?=
 =?utf-8?B?Mkw1aUZCSy9uWkNxVHlVNlBPV0JrWkpQR1Z6SDg4WkV5bTdJakl1dkFaZjJM?=
 =?utf-8?B?WmRaYjNTcXlObE9zaTZLcVQ4MkMyTHpGNFJsakMzZ0FCTVlZdDZDb1dzNlZ2?=
 =?utf-8?B?N01QUnR4YlFtUzVObDZYU2dXOTVQdy9DWkVNVzFnNDFCcUJXWWZ0WjF3SDV1?=
 =?utf-8?B?TGFqNVpRTjZ5Q1YwRnlVeVVTblcra3NMaEcyWFFkT1BZVjlRNHUzaEdjRm1R?=
 =?utf-8?B?ODZ6MGdIMHRQRWU3UFNHMUdRZjY1WjVoYnUzLzN5SXNIQzdZSW9JY0FlaWM2?=
 =?utf-8?B?cTIrNWxzQWFoWjFWS1RYOU1YeThzdThoNllTbjF1aWZEUTFWQUl5VlorUUlF?=
 =?utf-8?B?cmhKRGRKT01FaElockh3VEdpRUJ3WURHaENmOFgrSU8wSlJHVjRVNVNvaVZU?=
 =?utf-8?B?S2p5cHBIRlNYbDRabnE0d2FWRjFaUjZFTHpJNEUrK0NhOVRmZ0MwbkNUSi9K?=
 =?utf-8?B?QU5rdEhUOWlPeThCMUlPNHZYYjVlWDFrMG5ZUVlOSVl4NjRWVS9vbU1iT1N0?=
 =?utf-8?B?aVAzSkpWNldRdWNuM0hlMUVzQWxUQWJjVytCMW1oYlFsZHo3ei93cG41R2R5?=
 =?utf-8?B?Zm83TGN6S1dzUHlaY1NBMG4wcnNZTXExaTJ3NzJrWmhwZm14ZkJ2Sm9iUFRD?=
 =?utf-8?Q?RYO679wU7tbNrUr0bq0o19zKoMIE+2IEQ6z5e/A?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUxUMmR0WndwSyttVmRQdTJTYXc1SmlxbVp5eGppc1lteWhDV2NrVFN2ODZs?=
 =?utf-8?B?VHpTbng0SlVuZk5QU1c5b214SEgxWnJITS9IK3pQczduT0pwWUk2eUJSNmdt?=
 =?utf-8?B?cWI4cHlMblpreFo4dDh4L3ZCajRjOFVSRi9zZWVtZUp0ME9RMC9rSHVLUEoz?=
 =?utf-8?B?SWYxZ1QzaDE5LzR6U05sbjluMjBSc2Q3L2xuK2Z2U3NwN3lZNnFEK1p3cHdT?=
 =?utf-8?B?OW9kWm8yQ1Y2V090MWpHbTNHbFFjQzFmWjJFemxZc2UxTjk4cEdTcnFuY2N0?=
 =?utf-8?B?d3MzV3FSU28ydzlCd3J6dHpWVDk4Z2REU0FCc2cwemZkRS85K1pmOHNBMVlI?=
 =?utf-8?B?eU1KcHhveXh5WFNHazJhOXFWOEtLL2I0ZXozTm1HQzVueS93M3JHeWh4YzBY?=
 =?utf-8?B?RlRoWTNFV2RxcUJiU0g4N3E1VEZocDhybmZac2Q2aDMrbVFkaVNYQkZITy9C?=
 =?utf-8?B?SGtqQkpOcjlCM014c0ZvRE13WHJ0K0ZneVYyY3F1bk9rWXBmTDFsN253RElj?=
 =?utf-8?B?N2hKayszWVRmemdCTExtcXRlV3NLd1A3RHNnWGZyMXYrcEpYdjlPZXFMaHBp?=
 =?utf-8?B?YVZPMHRCSkNsSU9HUzBJTW53SXIwWXdKVWllQU5hRjBkMGg3UHJZTm9kNk5V?=
 =?utf-8?B?b0R5SXpnWmJKZkxhM3JBR3hiK29hUklwdk1FT2UvZlJKSDU5WWsrQ0JVSlFo?=
 =?utf-8?B?cHN4OE5HV1l1Nlk0NTR3enpPWVFoZkVsQjJuWDdjdmFaUFFKL1VvVWQ5MjRR?=
 =?utf-8?B?RE90NlJLTU83SFN3UUM0ZU1mVmdnTGVqLytmVFhtNXA5K2tNSW8rd0RLYTVO?=
 =?utf-8?B?WlZSRm9rYzZPYnh0cC9wT3RkTkZQNG50T0xRRVVJK3FWZUE5M2VRNkdhR3Ez?=
 =?utf-8?B?bkRPU09GUjFMMFJVdDY0U3k2T0JNdi9zRGFpd2k4QmwzY3BBN0hGQXFtOEhK?=
 =?utf-8?B?SGhGZmMzTXEwbi9GZnAwVGlVbTNwMFh2TFhWUzBhTk5RaUVSeVdyY2tENHFa?=
 =?utf-8?B?eXF0a0dMTW5UWWJTajQwdlJzeG1lK3lOMkZGTEVKb2QxTHZjNi9zcGVrbktl?=
 =?utf-8?B?SERKbWdOZDFpc0NhQXk4ZENCMXdPM1k3ckhkN3pYbmpBYmVvMjRuSGI2VW5t?=
 =?utf-8?B?RnJGcTA0NWx2YUlZc3REQ09kRVNnZTM5Y01XTGw2V2RHa1NtTGpTRGx1RHpm?=
 =?utf-8?B?UEZ6NE00b1g1T0d0b0hkTlhKaHFBakwzQVJPWmVuOVQ2aDFwQTlSQmVDbjhP?=
 =?utf-8?B?TVRkU0tiSWZ6UmFRY0dab0wvR1hIczVxVEdNK29ma1dsVnpyUFFnaFVVN2xO?=
 =?utf-8?B?WnVYVFYvV3B5VTJXaHJESVhPbmtPVnZJQXlJMXBpV1ZRMkZWU2dsa2tacTZj?=
 =?utf-8?B?S2FrL1llUVIrRHBqTG0rdW9ualZoTWFGWmVicEg3cUVINzd5bG5lRmJVZkdQ?=
 =?utf-8?B?TFFFQ0JqbWtqLy9UUXN2bzhIQjVjRm5RalQrQmI3TlZPaEs1TVN5ZHpaWURn?=
 =?utf-8?B?NGplajVDa2FROXpRbVF2Wk8xSzFYS2E0ZFZqbEFzTFduSTFCTlRHRVRZdk5K?=
 =?utf-8?B?cG9Hc0h2WnpFZjFSWE9ad3ZIUzhBVkxCajYzMGF5d0IycFhmWFZ5YTZPU0lz?=
 =?utf-8?B?c1U1ZC94b2ZuSmduWkFGQW1pMWZMVG1OQXJjU2pVdndXUlFsOWRDR2ozUUdr?=
 =?utf-8?B?QkI1SFFlTVRxeEpMbVpxUjRwSFNKZEVwR2JKQmR1U3hHSzVxNG5hWG51LzhO?=
 =?utf-8?B?QVhzd3VPQ3lXa0RXVWZ1SmZsZnU3RmxuK1Fvb3VHN04zekVIRnFPNUVncExT?=
 =?utf-8?B?R01STzNSNFBXRk0raDFmOEoycXhEV1BnbVpNdkhobUoxUU8wRXhzb1JuVXk2?=
 =?utf-8?B?Yy9hMXN1U0lVSjh0N1p4a1FMQXV6S0RXcDR5UWd4dk1ySHRaajNCWlNxcnlh?=
 =?utf-8?B?eEpNYWlXbXc4S3BPTWFrMnplcElGdURCN25YWUhGMGNhaHFCeWdEREhSWFZr?=
 =?utf-8?B?MWpKdVBRWnFjRnAzR3JIUnZCZDhya1FVM2ljMnBvdmRlY0ZLcFRyakZ4eXpn?=
 =?utf-8?B?L2RQRHI2eDd1SGk5eEZNT3puMk0rb0J3UCtWRTdHUGdlOGxMQmt4TjJ6SFBU?=
 =?utf-8?Q?dIz8RZlHOsoPwuyQ6ilWOKcuk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9a1e52-8844-4a9f-a5e2-08dd03d7b75a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 11:38:38.6848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjl87EeB+vOFVgGOh4/3ST8Wr9gq+RA8EtO1av0buwwF2ynskd93T+CW4qYfrYFu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9016
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

Am 13.11.24 um 11:25 schrieb Tvrtko Ursulin:
> On 13/11/2024 08:49, Christian König wrote:
>> Am 12.11.24 um 19:16 schrieb Li, Yunxiang (Teddy):
>>> [SNIP]
>>>>> +   size = sign * amdgpu_bo_size(bo);
>>>>> +   res = bo->tbo.resource;
>>>>> +   type = res ? res->mem_type : 
>>>>> amdgpu_bo_get_preferred_placement(bo);
>>>> Again, it's a clear NAK from my side to do stuff like that.
>>>>
>>>> When there isn't any backing store the BO should *not* be accounted 
>>>> to anything.
>>> I don't have a preference either way, but I think it should be a 
>>> separate discussion to properly define what drm-total- means.
>
> Total must show the total size of all BOs which exist even if they 
> don't currently have a backing store. That's how drm-usage-stats.rst 
> defines the field and that is how all the other drivers work.

In that case we should only look at the preferred placement and not the 
backing store at all.

But that makes the total identical to the requested value, doesn't it?

>
>>>>> +   type = res ? res->mem_type : 
>>>>> amdgpu_bo_get_preferred_placement(bo);
>>>>> +   shared = 
>>>>> drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
>>>>> +
>>>>> +   if (type >= __AMDGPU_PL_LAST)
>>>>> +           return;
>>>>> +
>>>>> +   spin_lock(&vm->status_lock);
>>>>> +
>>>>> +   if (shared)
>>>>> +           vm->stats[type].drm.shared += size;
>>>>> +   else
>>>>> +           vm->stats[type].drm.private += size;
>>>>> +   if (res)
>>>>> +           vm->stats[type].drm.resident += size;
>>>>> +   if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
>>>>> +           vm->stats[type].drm.purgeable += size;
>>>>> +
>>>>> +   if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
>>>>> +           vm->stats[TTM_PL_VRAM].requested += size;
>>>>> +           if (type != TTM_PL_VRAM)
>>>>> +                   vm->stats[TTM_PL_VRAM].evicted += size;
>>>> Again that is incorrect. BOs can be created with VRAM|GTT as their 
>>>> placement.
>>>>
>>>> If such a BO is placed into GTT that doesn't mean it is evicted.
>>> In that case, do we count BO with VRAM|GTT in both VRAM and GTT's 
>>> .requested field? and if they are not in either, they go in both 
>>> .evicted field?
>>
>> Oh, good question depends on the definition of the requested field.
>>
>> Accounting it to VRAM.evicted while GTT placement is desirable as 
>> well is certainly not correct.
>>
>>  From my understanding they should go into the VRAM request, but not 
>> account to evicted. But Tvrtko might see that differently.
>
> Semantics of requested and evicted are kind of amdgpu 'legacy' thing. 
> So the question is whether or not they should keep matching. 
> Originally they were like this (I will edit out parts which deal with 
> CPU visible for ease of comparison, and which have since been removed 
> anyway):
>
>        if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
>                stats->requested_vram += size;
>                if (res->mem_type != TTM_PL_VRAM)
>                         stats->evicted_vram += size;
>         } else if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_GTT) {
>                stats->requested_gtt += size;
>         }
>
> So the part about accounting as evicted with dual preferred placement 
> was there from the start.
>
> Then after my changes:
>
>         if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
>                 stats[TTM_PL_VRAM].requested += size;
>                 if (type != TTM_PL_VRAM) {
>                         stats[TTM_PL_VRAM].evicted += size;
>                 }
>         } else if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_GTT) {
>                 stats[TTM_PL_TT].requested += size;
>         }
>
> I mostly kept the same semantics.
>
> Teddy's version keeps it the same:
>
>     if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
>         vm->stats[TTM_PL_VRAM].requested += size;
>         if (type != TTM_PL_VRAM)
>             vm->stats[TTM_PL_VRAM].evicted += size;
>     } else if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_GTT) {
>         vm->stats[TTM_PL_TT].requested += size;
>     }
>
> If no AMD tools depend on the legacy semantics for evicted/requested 
> we can change them. There is some overlap with the standard keys 
> anyway and the fact preferred mask is unordered made the original 
> behaviour a bit presumptuous to begin with. In summary I think it 
> depends on whether we need to keep the legacy semantics, or even the 
> keys themselves.

As far as I know we don't have any dependency on the amdgpu specific keys.

But I need to double check what drm-usage-stats.rst actually defines. 
Maybe that doesn't really match what we have in amdgpu and other TTM 
drivers as information.

Thanks,
Christian.



>
>
> Regards,
>
> Tvrtko
>
>>>>> @@ -2612,7 +2707,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev,
>>>>> struct amdgpu_vm *vm)
>>>>>
>>>>>      root = amdgpu_bo_ref(vm->root.bo);
>>>>>      amdgpu_bo_reserve(root, true);
>>>>> -   amdgpu_vm_put_task_info(vm->task_info);
>>>>>      amdgpu_vm_set_pasid(adev, vm, 0);
>>>>>      dma_fence_wait(vm->last_unlocked, false);
>>>>>      dma_fence_put(vm->last_unlocked);
>>>>> @@ -2660,6 +2754,15 @@ void amdgpu_vm_fini(struct amdgpu_device 
>>>>> *adev,
>>>> struct amdgpu_vm *vm)
>>>>>              }
>>>>>      }
>>>>>
>>>>> +   if (!amdgpu_vm_stats_is_zero(vm)) {
>>>>> +           struct amdgpu_task_info *ti = vm->task_info;
>>>>> +
>>>>> +           dev_warn(adev->dev,
>>>>> +                    "VM memory stats for proc %s(%d) task %s(%d) 
>>>>> is non-zero
>>>> when fini\n",
>>>>> + ti->process_name, ti->pid, ti->task_name, ti->tgid);
>>>>> +   }
>>>>> +
>>>>> +   amdgpu_vm_put_task_info(vm->task_info);
>>>> Please don't move the call to amdgpu_vm_put_task_info().
>>> Is keeping the task_info alive a hazard here? I could copy out the 
>>> info, it just seemed a bit wasteful.
>>
>> Ah, now I see why you have moved that.
>>
>> IIRC we need to free up the task info before releasing the PASID, but 
>> that info might be outdated. Need to check the code.
>>
>> Does it work if you move the message further up or does the root PD 
>> then break your neck because it isn't released yet?
>>
>> Thanks,
>> Christian.
>>
>>>
>>> Regards,
>>> Teddy
>>

