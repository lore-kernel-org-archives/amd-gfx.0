Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C58ECD98EE
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 09:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A063110EEE4;
	Wed, 17 Jun 2026 09:04:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YHNgnVhd";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010013.outbound.protection.outlook.com
 [40.93.198.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC6F810EEED
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 09:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogsBgSa6eOV5G+RQ2/LxARD+PGBTm2bTQXtwB18hf27dSU+a9LyVopztVmvqTRFgbgRtmU0R1R47LsUWYXKzI3H2f2eozfOUm8CVAkiAd4MmVnFul3nzQbCeX3KUKuTuD4GPEQdXTZgPgAJC0bKeD7l3VZL1uoWwBvz9dLSkarI6BCq2aB6/2YPq7aqCMZK1ZAI95IO27IdFt7rj5MRc6UliYhApOp2PZPWHn7MiF6HTtiMd3L69Dfzx2Cl3NqB9nFMGzb4cqoNLWRlvshWb3YpG3Xhli2/gRk8VwHX0Uc0IZBEy4Ft2VftS3vIHJ44pN7yJ8kPmoqIUraOD6ZPXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61C2Wul1BtIAwFU6ncr6qK4wxB/sbGIKeV7pFJXiv6I=;
 b=xCBGc1W2uUq9XE5qVKkRgg4PNoiz9Aena6xNDMYowPpQgMjHHl8NSH3zmPFYmdvfPMrYZgwO9kTWgfVPgShmqZf3B46/sk+lZUh02JsaBQsLOBSJjvVvAgQJqR2nRW3sccbUiVIy3oXqWVSbEP2r3HQInykuh08EGDrWeNf5xObf72dwEHCRNKIZIeWtq+IWvS0XdVn8tJ55fXYLgX58+YJbaD+9kzxnBdaKnAQfFPnUuaZlLPu3+xWweNhzBwbNDH/Ko/ETTj3R0PB5wucvWwUZmoqr99HU4f0pSSlJwN8oZPhKnawuqgPKgpQghl4wBW6ZCSFanyoxYQ+smbsPhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61C2Wul1BtIAwFU6ncr6qK4wxB/sbGIKeV7pFJXiv6I=;
 b=YHNgnVhdDrXhSgSoTUa70F7C/H8PdxYHewsL6eotyChyBiq9tZ+QXopfl06DUszCV6NWAZ2Tdm//9a0JigWFhP6iig4unDqTqtB5IxwDMIvh8ISEyOjz7L+/pBGEBCAYFLX7M3F6rZjrwebCzdj5nEIl5jJMZaFn8lPInCurPvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 09:04:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 09:04:37 +0000
Message-ID: <d99db6a1-335e-447f-b909-4df3e6e75a07@amd.com>
Date: Wed, 17 Jun 2026 11:04:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drm/amdgpu: Signal GPU_RESET EVENTFD notifications
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260612055226.2879270-1-srinivasan.shanmugam@amd.com>
 <20260612055226.2879270-6-srinivasan.shanmugam@amd.com>
 <4872460d-f5bc-4031-93e3-63650ec04479@amd.com>
 <IA0PR12MB8208AD2E2E8B8363030D514990E42@IA0PR12MB8208.namprd12.prod.outlook.com>
 <c2825801-31a3-4e92-8136-ed0e379f1471@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <c2825801-31a3-4e92-8136-ed0e379f1471@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0221.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a0f9398-396f-4a65-ff99-08decc4f74d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: cV7A1NJ62mmBt39juVov2fpDEHTmC0Ml/f8WOdOfg0OdLWyOkuQywKReUMZ8zNkTSnXQZZefT7BU3oDK8iACl7qxFYkmdUP44vKJs5rzyvA76fVtVH+DMv5iX1aKps6VxH4H0KOth1dhK9CTBA44Bhi3h9el4bEytU8ccOimstj10Y0MnMHIsNN9YwDfD3FI4ELCxSoBF0J0N+SPbFaLw38LDTLJ9CqLWG7hH9Zo4exMC2grjdy8aiXCVZzWNUbAD5YOSzqxxQW6tNIBo6FmXkhsoEyCK8oEqJTR0iclExlECt3Tw5FapUeOVJb0akeayInTYT5eP96efWf/rB/enf0dykts/JEQVsuGjhJ+zEbfLvjLN2nrV/X0AteviupMuS8BPO052zwn3GXWkzCETA9IHYKlSdfOWN1xxeiLnkqTvPMSkz/TmBlPoWQVn6gDZVHqyuPXoojweBnkQhThn6YxHyq0IMBYrUBGmweZXO6sYwqIUYe7+0hwzGvGbi+Nc6os/kDS84reqstGuYJ2IOHdOP/sP3mGdqssd3gfs5T5qsE6c680/P6JEiKYknRc5vV6EKt9CHkGeWmwVlo9K6x1S9qROu8qTJdmmlgOAyZg/YtfhDd5zDb1h9dWGq54Q+F/5pXU1r4zMUj2p+jzpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW9iTDEwRUl3QlVQMUhlN0dzN09mUUxJMmRXeTVSRkJxRXNjREw5Q3l3a1pw?=
 =?utf-8?B?VExuTDhlSGQyaWtyOHR4Wm9ZYTdmNitsNDlzbzNyekxzMytoQlhubk1QSzI0?=
 =?utf-8?B?MDNnZ1Uzc25LVTZ6bTd4Sk0zZ0p1Lzd3VWRIaHF0Y0Y0S0FaeFZVd2tvSWZP?=
 =?utf-8?B?VDRpS21jRGtKekw0YzJEMWhobGpJTm1uV1E1Z0toa3J3VnNqM05aSjFKNFM2?=
 =?utf-8?B?c0wrQ1habzF5dUk1TnJoeENkTzdaUy9tZ0E1b3FEa09TdWZKUzg5cnlqVlgy?=
 =?utf-8?B?YjR3aVdFUXNFZlFsckY3SDZ3RkI1SStwNnJZVjBIaTVEZzF4dGFNcjNKbHMx?=
 =?utf-8?B?S1g4WGt4MGZBWXdQZEtzcnNzTlllOVVXMnVWZjgxa0pCR2V2V3pISFNhajVH?=
 =?utf-8?B?SnRZT25aSkJFaE5ZQ2tkS0F3YmJ4R3IvRFM5K3JXdXhjVCtkZ2RFRFQ0c21w?=
 =?utf-8?B?bHZSTkZScUdDMXJNNkx5bWpSQStpbHY0OFpnVzRJZ3ZBYk9nZXhlL1JlZ3Q0?=
 =?utf-8?B?VS9EKzd1T0FZRTRUaHArQmY4dk1udUZNNExBQmdVWjQrTzZqWkF1dzk2Nmk1?=
 =?utf-8?B?UVFsd2psWE5OV3lTNVJieXlCWnJjYU9SMTFJdzdkOGkxN2NqbXN0bGFRN2Z2?=
 =?utf-8?B?ZXF1dU5LbmVzcjdHVE56VkdOMjFrRVpJMzg2SDg3LzVEZVVORFdhZjMwMnA5?=
 =?utf-8?B?LzlUdFRpQVlxeUxHUk1SbDlxcjlXbWltVTMrUENZdlJNNkxRZFdJdllRekl6?=
 =?utf-8?B?YUNtdjBRZGVCM2puODhOeCtlRmdLS3BoNC9RM2psaXFwSWZrdWovZDdnbElO?=
 =?utf-8?B?TU01THVvdEhudWRCUnFkbmN4cVFzWElnOGQ1aFgzOUR6M1BBVkUwV0lJaGhY?=
 =?utf-8?B?NjhrdHZQRi9mZkpzS21TY0pzWDBqSkZlVDEzTng0L0drVG5tR09ERTBPMUpl?=
 =?utf-8?B?Zk0wZG00ZGk4LzdZTnJKc0RWd0hZS2JlcGRXRHV3WDRFWk44bXVMQkdVNEdX?=
 =?utf-8?B?Q0JVYnlkQzRsbUdjdUM1b2pkL2Jhc1Y4a3QwVmxiQ1M5dmZ4a3RmZEdNaG5B?=
 =?utf-8?B?eXNSYjFGNEJ2SzFjSzI2K2Z2S3ZMeHo5alQzQmhwYTQrY1dmT0c0Y1pIU3VI?=
 =?utf-8?B?UmV1alVoWVpNNFJvT3pvVXdFSlovTmo3M0Z2OGwyeS9lNUp4Z1B6RDRQc1VM?=
 =?utf-8?B?eUdiVW85ODYyNEJUdXlrMjVKQkRuNUZHMy9ucDBzN0NvMElReUFZZ08zSFBC?=
 =?utf-8?B?UlB1NDBQeHVuVnJGek9tUEpSV0tiUEF2OExIdG1ibFpGTzhWYUdWbjBEM2VX?=
 =?utf-8?B?ZHNYMXkrelJrUGk3NnlmZlRoaUtjRDc0disrblR4cVIvOC9KcFhSRkxIL3p6?=
 =?utf-8?B?WVU3ZFM2bmdycFkxNEwwM05ZRjZDWVoweU9kNFlFM1Z3WmVpTnNlWTVpcThD?=
 =?utf-8?B?M0F1K2ZqYkFySTlBS3NtL1ROUUFCN1VZSWdLSVBlQUx5dWtYdWl6dHRyT1oz?=
 =?utf-8?B?Y1F1TlkvM1JHbVl6U2lWVTUrNWpRYWJEa2thMTFoa1hzUml1N0NTSjJpeEtZ?=
 =?utf-8?B?QmpWZTZ2cWVjM3ZyZ3VrcWZNemE0TEhqTXZZQjJBS0xFSDFqVVBuSnhWTVpL?=
 =?utf-8?B?RmhSR09WaFUxa2ZQRVB2bkpLa1RpL2NtNHU1eThXU2hBbTJ0bmFMYVpHSXpJ?=
 =?utf-8?B?QVlUREp3anRiTnJ3MFVvUkg2MVNzZFhUSi9xK2ZYZEw2eW5aQnN6UmFrQVFC?=
 =?utf-8?B?aU1zdFFLTUtHRDZUZzZQQzRuQTUxYW01bnh2OEhjR3pRcXhReG8xaTJ4UEdW?=
 =?utf-8?B?ZThhRXhGaHVJdUIyczBvVzNoVkZvcGUyL3F5eWJqbC9kcnFmYU5YNjFmaEN4?=
 =?utf-8?B?TWVodHBKcFpvQllOZUdDdVhIVEZUZzZxTDFGdVNseWUwbFJ3UDNLTkJpRklE?=
 =?utf-8?B?b2NHYm05Sm5zeHpsT3k2UDBxTmN5UlRhSkZHUVN4QkZWbzhjeTZCVzNINGtS?=
 =?utf-8?B?WHk2aUJDSVpYZTVGZldZdGhaaEZyOU53c1ZlMlcyTkZFdVZTeFZaTkE3Y0lG?=
 =?utf-8?B?T001Um8reC9XanVWcEdZM1B0V3hqNnBlZmxFbUNVUktmbGgrSkNXYVgwRG40?=
 =?utf-8?B?eVdJZ1c4TnF2c01zaXZvbzBUbFh5OGc3dFAvWldvVW15UzJoTDEzdGFER1Fm?=
 =?utf-8?B?cWExbHdvbGp0VWNYT0lQdFNyVmcvU0NwQ1dxcUtzRHllQUVYQjNIUjRYNEkx?=
 =?utf-8?B?T2drQThyN3NiSERLUExhS0pPdFJySk5pcFZIZ252SUZBY0VSTnZkY05QSmtM?=
 =?utf-8?Q?UQv0ypeXu2eTziC+Rs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0f9398-396f-4a65-ff99-08decc4f74d7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 09:04:37.1357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyE7A6UCRath5VMvoGx79w32bF2/pDhg2TPb4j+jhADT76FhXnBdCo0P50857kf+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191
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

On 6/17/26 08:22, Lazar, Lijo wrote:
> On 17-Jun-26 11:29 AM, SHANMUGAM, SRINIVASAN wrote:
>> AMD General
>>
>>> -----Original Message-----
>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>> Sent: Wednesday, June 17, 2026 10:38 AM
>>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>>> Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>
>>> Cc: amd-gfx@lists.freedesktop.org
>>> Subject: Re: [PATCH 5/5] drm/amdgpu: Signal GPU_RESET EVENTFD
>>> notifications
>>>
>>>
>>>
>>> On 12-Jun-26 11:22 AM, Srinivasan Shanmugam wrote:
>>>> Signal GPU_RESET EVENTFD subscriptions from the GPU recovery path.
>>>>
>>>> The GPU recovery flow already determines when a device reset has
>>>> completed successfully. Use that point to wake up matching EVENTFD
>>>> subscribers.
>>>>
>>>
>>> It seems beneficial to send an event before and after the reset, rather than only on
>>> successful completion of a reset.
>>>
>>>> GPU_RESET is a device-scoped event, so no queue object is used.  All
>>>> processes that subscribed to GPU_RESET on the device are notified.
>>>>
>>
>> My original intention was to notify userspace that GPU recovery had completed and the device was usable again, which is why I only signaled on successful completion.
>>
>> One thing I'm trying to understand is what userspace is expected to do with a reset-begin notification. For the other events in this series, EVENTFD is only used as a wakeup mechanism and WAIT_EVENT provides the associated details.
>>
>> Do you have a particular userspace use case in mind where observing both reset begin and reset end would be beneficial?
> 
> This is an existing one -
> 
> https://elixir.bootlin.com/linux/v7.1/source/include/uapi/linux/kfd_ioctl.h#L536
> 
> Presently, it serves as an SMI event. Other processes may choose to halt submissions from their side, and resume after a reset (though this is still asynchronous).

We have rejected exactly that approach in the past because it makes the whole handling quite unreliable. This has been proposed before and was then later removed as buggy.

As far as I can see notification before the reset doesn't have much value since you can't block the reset.

Regards,
Christian.

> 
> Thanks,
> Lijo
> 
>>
>> Hi @Koenig, Christian/@Deucher, Alexander: Any opinions onto this please?
>>
>> Thanks!,
>> Srini
> 

