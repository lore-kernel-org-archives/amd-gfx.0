Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF544D767C3
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 10:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6209A10EF1D;
	Fri, 19 Dec 2025 10:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SR+5Wg9z";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013064.outbound.protection.outlook.com
 [40.107.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F28210EF1C
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 10:45:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBLAPG64M9Z3+M5ap04TwlLTlM06ewdwCpbXXau4ethZdlhEkHIK12/pDtcFLWDG/IghLQjE3DZxkN5QCqsHAljF6CD/09+ky4wbHqIByKm7lKJwF9HhmgV7MC9NmFkg0gUE2UkCAIRamv3lk5qALItYkBuzH/jMV/dj/hRwAIEgSTTlbEIibgabVoCyO6O6G6N9ISCLMyxzKJy7s+wG26cQRoRG7eBD45qOQnZDObkDttPHcR4Ub7dXW/67KzhvaGFc0zMMrhBF+lucaeyI0101iAZiqq/0MxoXrFXAz6bz7RUrKNzRE3zpSicg0xQNnhf6TIGFYUQg7ysu5ypKJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idAmToc1y2SEBwhopnkoW/EMmVoJrAjipNkpFJimsxk=;
 b=fIbLNzlT7HQJ/veQijgaemwoOlQgp4nbc5UgDlzvEAzo0NJRoKb7HcJoMnClEi6YKc7XgFo3zn4H7hUjxBGoAmahN7/h7KiX6ZGHDRm7kGBMGy80ssvZXiiTQF5W3S2AttZVRlAe8alK3PTJU8nxfDd43+JcgkLmZQHKQzW/hsIi98aME20Kz+Qw2gfZRQKw9B7+htR5UlLLGb2gXKDg4NQW/3U/ym8Q8I6Mew222pmKvAlbXlXFvPUVpzDwYITI/Ym6vlTtzlEqWl5VQXcsTsV3ZWRZ+ESbOseYuUjY8yhROw7hGBraDlbWU1FVMejx2oipAsT+iQvSMsAJ13xTkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idAmToc1y2SEBwhopnkoW/EMmVoJrAjipNkpFJimsxk=;
 b=SR+5Wg9zoPaDfk93Vhm4tjsogSNrVJF+GdBAMrAFzYMEpdY+jreV7zDoAN2naKHOp3YX7wrQCP+yxM1VTmu2StEWV2Px4td+CRCxMG4HDBRsVz/hiCFfHNXH7HHszQSWyZLwokdQFM3PpjEpjuwWotFJWFpOtbDV+zjiNr7P0KA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB6248.namprd12.prod.outlook.com (2603:10b6:208:3c0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 10:45:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 10:45:06 +0000
Message-ID: <3b6eed1e-9a07-4cd6-998c-59672b87f5c2@amd.com>
Date: Fri, 19 Dec 2025 11:45:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/5] drm/amdgpu: Convert context manager to xarray
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20251218150405.80502-1-tvrtko.ursulin@igalia.com>
 <20251218150405.80502-5-tvrtko.ursulin@igalia.com>
 <831aea45-f75c-4432-9045-cf44d8f7fc17@amd.com>
 <77760000-32c3-4df4-8b92-ce51022165dd@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <77760000-32c3-4df4-8b92-ce51022165dd@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0493.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b3b6e88-d201-4541-82f9-08de3eebac50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0lGYXBGRkFvVWU0STFuT0ZNYVpBYm9NNjI0dHllS0NpL2crMFVXNzhPYUZj?=
 =?utf-8?B?ZE0vU1I0MDl4WHo0MHZIdEVac2ZrQnYyeUZUWk1lWUpGdlVtbnN5ZDAvNVE2?=
 =?utf-8?B?dXlNSDkvbS9vVDBHeDErMDJMSHhvU0haSEE3UVhKYzY0OHFoaDk0RWxlUVRh?=
 =?utf-8?B?Y2RSTFJMdHR3Z2Jlbk9OVFFnMVpXRjNMTUhpSVZ6eEY4MUIwN3J5T3MrM2Zk?=
 =?utf-8?B?VWdmNDIvRHhJMVpIbnQzTGZmQXJuRDhSUngxYWJoRU15REZUMkZpTHhpbXdo?=
 =?utf-8?B?UFQ0Q3dkdVNwRUdIRkdMd1NPR0JTTmpHOWtiWmdSZ29vVURmMnF0WHZKWWFZ?=
 =?utf-8?B?YVgvZnEyZ0I4aEtDeGtjbENLdzU2WHIwR0dUQnlGcnU3aEo4QTF6Tm9kNERS?=
 =?utf-8?B?OHd1NG1oQWhnRGxoeko2WGlTQ1lQbjQ4SHZ6ZzFZcjNlelFoL1BXcnN4aWdE?=
 =?utf-8?B?WFVzcmFrTkJUdlp3akJZMzNRZkhUY2gwTm9GV0hkVlc4NkdrTUJSVE12NUZL?=
 =?utf-8?B?Z2owNDJsbkNia3dpdVFNWGxlNmkreWFzY05JdmFYVXN2bDlCaGxRNkNlTHcr?=
 =?utf-8?B?MjhMdFkyMVJUTTR4N2p4SXJ5MXhKMW9ndlh6SDIvcDAzTE14ellNLzFDUnNG?=
 =?utf-8?B?Vkx6aFJxVmxEcldrWnRabmZyRXNnT1BxMDJINUxzOHp1c2twdUNSblVETkJV?=
 =?utf-8?B?ZEFybTNEbWY0NjZwbVdUdUg0KytYNmpxSU8xWWxjeFZDWTl3d1JNeXZqNWNW?=
 =?utf-8?B?YkF0YWtqZHZhZ1Z6ZVN5QitVbFlhbVljWkc5bE1xREhHRWxDdHlVOTE1Yk4y?=
 =?utf-8?B?NzMraGgwMURxSERYZzNZQUcxTk5KSFp2T09UZmlSUTllVGw0enJRTm82SXJx?=
 =?utf-8?B?a09vWEptWlJsTjRRaGZJYkZaVUFiZ0lzb0NHZDY5VG9lb1dBTThRY3czMzVw?=
 =?utf-8?B?Y3dudDRUbTc2czZpVVNFQ2t0VnUrVndRd2RGVTIwVysvNFNxaGVzMFRja0Q5?=
 =?utf-8?B?KzZLcmdTZUVYT2NpZkllK3VjVVFESGkzaTdDVnA5STZ4TWNnblZFQUxuRGJ6?=
 =?utf-8?B?MW9sWnE4TWw1YVJUREF2bGxPYVEvcXVManZ1bFBubHp3MEhJZE1hcEtIYWR2?=
 =?utf-8?B?bUdVYXB1bWJmZ2VnUmRuUkpuK3Y2MmY5YWllOVVMbUlzNVY1eUZwdDQxYnpQ?=
 =?utf-8?B?dzNsY0NMRTRlMEFESkRqL3kvaFU4ejBEbmloQ0N5Qm92NEcrZS83R2djVGtp?=
 =?utf-8?B?cGgvZUZSbXQwVkE3M2pXcEZjaWVvNmYxa040d1RRK3BMSUJ1YThYb1ZEOE1Q?=
 =?utf-8?B?NllLOUU4L3RNNFZCd1Fia2ZWdFRTODR6b3RSM0oyVkhleEtQNzhtZ0xBaUdK?=
 =?utf-8?B?dkhxUllYdExjZXB6bFplc2NZaGZ4T29ZUW5JcXhnYTRSb2FnTXdhWE42VklT?=
 =?utf-8?B?WVJiRlVmSWt3MW5sUUhJWU9wenZjOEo4WEo3VE9ZYmt6RXh0L1UwTEVRMTlq?=
 =?utf-8?B?V0kxa3ZiVmpYU0FkczNhN1U3TmJhclFPSWpyTElwOXNaRTB5V25XTFRqTXdF?=
 =?utf-8?B?WkUza0FuSHd3MVE0aUJjVytXRHM2RW9EbkFRR3k5S1FVTUlqclpqVS9DSGRZ?=
 =?utf-8?B?QytUMDE0U3ZmWEliSU11VVU1Q2YyY2dmaDJjL3Q4YzFHL3M2TDFFRUZ2dTdn?=
 =?utf-8?B?VENPVU95UHdEdVRXN2NMYnliNVM2Z0VCWVZVR1dGVHB4TzJVSkNMZTAxa2ds?=
 =?utf-8?B?eXdzYVJjQnV5Q2lVODlnRUR5dUNUVWZYNnloZkVzdkFCZGhGMXVYeW5qekZ1?=
 =?utf-8?B?dUpzYkM2OUJuYkp3STZXSXNLMmExT2dqZFk5b1FGQTkzWWNPRVZHZ3dLWXRD?=
 =?utf-8?B?ZlNjeWN0UmYyTWt3UUVicEZHd2x4bjhQUEJOLzFYZ0JxRXVteDVkazZXWXdV?=
 =?utf-8?Q?vLm1NCjNeZ3hvoOTnHmeQi09EKG/3TRZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWs4Y292a0R3RTZZSmZ6WG5BcU9FbWxhU2FOZXgrM0ZDRkYxK2w1WEVXMnZz?=
 =?utf-8?B?M0JtN0lDKzZ6T1JsRE9HcTlGR3Q4YjBDcmMyZjhQclFqcThsQWdTUmxHVFhZ?=
 =?utf-8?B?cCtYTEF4cGgvbExFRXpHeW5kRDBqbjZ6b1ZPc1NqZUhxaVNvOU5vSU1CNzJV?=
 =?utf-8?B?eXBVS2JsWmI1bnFsWmdTbnBnU0VOQlpYa2c4emNIeVgzdC83Z01NaFdpRCty?=
 =?utf-8?B?WGkxajduam9IeEMzbmJzWVhsQjhuU2cyN1JaNDdKZnpadFl4YVNJVTFGNzRX?=
 =?utf-8?B?QVQ2L3lEZ2dXNllSenpiUTI1MWdPN2RMWHpqOVErd1JPWHEzTnNqL3VhWlg4?=
 =?utf-8?B?aXhmdVZuWERpRGdDM290Z0NRTGlQdDN1enF3dnJpcVlIcGptcXZuWVFhZG5l?=
 =?utf-8?B?UDhTa1F6RFdXd3JIL3A3NmJXelQvVEhnTEdXTjNRTjI2MEpNRTI2ei9ObCtH?=
 =?utf-8?B?SWJqRVBvem1EQ1c0Y0huZWRYTmh1QlJ2eE9YdE5MNTRLeTV5dzZxMmxXRmI4?=
 =?utf-8?B?RmFYRTUwVUpNSDhKNzh0aEJTalAxWXYzNjlDdDhQdEFtYk9QdGdmK0tadUx0?=
 =?utf-8?B?dmMzdlVralBQbW1uemZSd1J0Q3k3Y3E2RGhLbnpCMzBOYzRwWkNpeHErbmhX?=
 =?utf-8?B?RnpWNDFOZTBGRkpTTmR3dXMwa1YyTmErM3YvbW1DZ2hnbXRDV3VZbXU5YjFY?=
 =?utf-8?B?QnFqcWx3TTI4LzVYR201ejFiQ3JPZ3JBM2V3NW5hMEJxV2d1VFZEQ0Q5blFF?=
 =?utf-8?B?bDdxUHFaUlBubXdVeUxKbnRLN1BmSU1tdGQxUHhtbWJKMUZtTXFCYUlZbDM1?=
 =?utf-8?B?eXJ0dy9zYmQzVUhNaTdqNk82YVBhK0UvUFJZLzFmR254Q3FmT2FPVzR0WkQ1?=
 =?utf-8?B?UXp0UVZVNlBYVU0rQUtMOHFtNi95VGRSbElRQmh1SGJ6MjhCN3dEZVA3OEJ4?=
 =?utf-8?B?SnQ0Q1d1SUdzTWFveDVFcHRHQWhlNnNWN0lUT0d6UjhxRXZLSVYzLzFMNGNj?=
 =?utf-8?B?dGhQdTJWRHZpWGpUTzMrMTBKalBNWkh3TVlQMzRhMTZ2UVk0K3dYK3JXS2I0?=
 =?utf-8?B?VjMzU2JuSnl3dnNjNU1vcmpWeGd1bXFnV1RUbExHM241RElnKzl6MnFBay9L?=
 =?utf-8?B?SmQwVFZHZzZBVzkvVE9NMnlOT3pRQ0lqOG9Cc2hOeHhxY3NiQ3A0S2ZmUnlp?=
 =?utf-8?B?dGkyYkRhNXFtVXJ4c3JEUnN4b0ZrQjVXZ3Y5SllyTDdsZFNXcTNYbXNJUUxK?=
 =?utf-8?B?aDZhbElwenlCUlFhcnA5dmV4aXA2bDNGbmg3QWxWcFYzZVhicHg2U2VLSCtl?=
 =?utf-8?B?ZHNRaVp4N2pydXhDaCt6d2d5VVVYR0p5RmFzU1FQUDZyVXBjM3FzT1lFR3RY?=
 =?utf-8?B?Z0tTaUkxSURNYmxhcy9wcTlNNDNvdldDd2x1NHlya2N3YXhnMEhYMmJXK0xJ?=
 =?utf-8?B?OGpha29waVFmdGQ5RmdpZ0l5Q2JuNkg0b08yN2JBRi9WeFJlWWdTTkNTRGNO?=
 =?utf-8?B?Z3pKd3JRVVREK3F4cEJpRmwrblZuOXRlZUk5TlZtRHVQTmhFR3V4RzRtczZk?=
 =?utf-8?B?M2NPR0kySjR1Q1pZd1lCa1lJOEs5OWVHQU95Y2dGQlVTb01TdFp3YS9jak5D?=
 =?utf-8?B?ajRNYnJaTG9uZWpINjB1KzNVQXNnZ29oQ3hCSms0RUNSVEFuN1lWd1RIcWI2?=
 =?utf-8?B?N083U1hGejZ1YWVlcW0rZ0Y4SGI2bG9GMGwrOW9IWjFXOTZqVzVQMGZhUHlZ?=
 =?utf-8?B?NGkvOHBRZ1ljOEdHMGE4YVdUWkQ2THFOWCtoamxrWnhFVVRpb1hQZ2hDaUhk?=
 =?utf-8?B?ZXh5Y2lNNCtJMDVpcmRFVnBVdURaT0VqTU45SExKS29aam9WTWVMWDB5c0FU?=
 =?utf-8?B?YUk2YmVROHFBUk8rNXFaaHlkOEhFYUV4UWlIbEJhNjBOUHUrbnBTTGM1QjNR?=
 =?utf-8?B?NmM3UmZjYlVQS2hJMHNOQ0Z6dlNIalNEYW9RbHNzeVJYNzY1RGZVOVVaMDIy?=
 =?utf-8?B?Z29OV0RMd1Ntb0xaT0R2MHFQOW1LZG9GU1M1VTlhT0dMV1ZuN1hGbWhFOVdx?=
 =?utf-8?B?aDh2VzBPWEUwaEN1ckhIVzhYQzU3T0JyZjdWQkJBbXZkTzB6dFdKTXZFbGZN?=
 =?utf-8?Q?H4Ubfv7TyYx6tI/RYS67umyT/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3b6e88-d201-4541-82f9-08de3eebac50
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 10:45:06.3601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9NveP3fzdxt3GL11Y5FwHRxjP07YAdzF3HQEu3CDE38KnBFvAeXwYAh6aYCKPXwZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6248
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

On 12/19/25 09:49, Tvrtko Ursulin wrote:
> On 19/12/2025 08:28, Christian König wrote:
>> On 12/18/25 16:04, Tvrtko Ursulin wrote:
>>> IDR is deprecated so let's convert the context manager to xarray.
>>>
>>> In doing so we remove the context manager mutex and switch call sites
>>> which required the guarantee context cannot go away while they walk the
>>> list of context, or otherwise operate on them, to use reference counting.
>>>
>>> This allows us to use the built in xarray spinlock for all operations and
>>> just temporarily drop it when we need to call sleeping functions.
>>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   | 117 ++++++++--------------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h   |   5 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c |   8 +-
>>>   3 files changed, 49 insertions(+), 81 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> index afedea02188d..ee1464f8751a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> @@ -484,22 +484,17 @@ static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
>>>       if (!ctx)
>>>           return -ENOMEM;
>>>   -    mutex_lock(&mgr->lock);
>>> -    r = idr_alloc(&mgr->ctx_handles, ctx, 1, AMDGPU_VM_MAX_NUM_CTX, GFP_KERNEL);
>>> -    if (r < 0) {
>>> -        mutex_unlock(&mgr->lock);
>>> -        kfree(ctx);
>>> -        return r;
>>> -    }
>>> -
>>> -    *id = (uint32_t)r;
>>>       r = amdgpu_ctx_init(mgr, priority, filp, ctx);
>>>       if (r) {
>>> -        idr_remove(&mgr->ctx_handles, *id);
>>> -        *id = 0;
>>>           kfree(ctx);
>>> +        return r;
>>>       }
>>> -    mutex_unlock(&mgr->lock);
>>> +
>>> +    r = xa_alloc(&mgr->ctx_handles, id, ctx,
>>> +             XA_LIMIT(1, AMDGPU_VM_MAX_NUM_CTX - 1), GFP_KERNEL);
>>
>> Please drop the AMDGPU_VM_MAX_NUM_CTX define as well. That is just a totally pointless limitation.
> 
> So xa_limit_32b ?

I think so yes. At least I don't see a good reason to have an artificial limitation.

> 
>>
>>> +    if (r)
>>> +        kref_put(&ctx->refcount, amdgpu_ctx_fini);
>>> +
>>
>> While at it you should probably clean up the unecessary differenciation between amdgpu_ctx_fini and amdgpu_ctx__do_release as well.
> 
> Right, those are very confusing indeed, so I happily will give that a go.
> 
>>
>>>       return r;
>>>   }
>>>   @@ -523,14 +518,11 @@ static void amdgpu_ctx_do_release(struct kref *ref)
>>>     static int amdgpu_ctx_free(struct amdgpu_fpriv *fpriv, uint32_t id)
>>>   {
>>> -    struct amdgpu_ctx_mgr *mgr = &fpriv->ctx_mgr;
>>>       struct amdgpu_ctx *ctx;
>>>   -    mutex_lock(&mgr->lock);
>>> -    ctx = idr_remove(&mgr->ctx_handles, id);
>>> -    if (ctx)
>>> -        kref_put(&ctx->refcount, amdgpu_ctx_do_release);
>>> -    mutex_unlock(&mgr->lock);
>>> +    ctx = xa_erase(&fpriv->ctx_mgr.ctx_handles, id);
>>> +    amdgpu_ctx_put(ctx);
>>> +
>>>       return ctx ? 0 : -EINVAL;
>>>   }
>>>   @@ -539,20 +531,12 @@ static int amdgpu_ctx_query(struct amdgpu_device *adev,
>>>                   union drm_amdgpu_ctx_out *out)
>>>   {
>>>       struct amdgpu_ctx *ctx;
>>> -    struct amdgpu_ctx_mgr *mgr;
>>>       unsigned reset_counter;
>>>   -    if (!fpriv)
>>> +    ctx = amdgpu_ctx_get(fpriv, id);
>>> +    if (!ctx)
>>>           return -EINVAL;
>>>   -    mgr = &fpriv->ctx_mgr;
>>> -    mutex_lock(&mgr->lock);
>>> -    ctx = idr_find(&mgr->ctx_handles, id);
>>> -    if (!ctx) {
>>> -        mutex_unlock(&mgr->lock);
>>> -        return -EINVAL;
>>> -    }
>>> -
>>>       /* TODO: these two are always zero */
>>>       out->state.flags = 0x0;
>>>       out->state.hangs = 0x0;
>>> @@ -566,7 +550,8 @@ static int amdgpu_ctx_query(struct amdgpu_device *adev,
>>>           out->state.reset_status = AMDGPU_CTX_UNKNOWN_RESET;
>>>       ctx->reset_counter_query = reset_counter;
>>>   -    mutex_unlock(&mgr->lock);
>>> +    amdgpu_ctx_put(ctx);
>>> +
>>>       return 0;
>>>   }
>>>   @@ -578,19 +563,11 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
>>>   {
>>>       struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>>>       struct amdgpu_ctx *ctx;
>>> -    struct amdgpu_ctx_mgr *mgr;
>>>   -    if (!fpriv)
>>> +    ctx = amdgpu_ctx_get(fpriv, id);
>>> +    if (!ctx)
>>>           return -EINVAL;
>>>   -    mgr = &fpriv->ctx_mgr;
>>> -    mutex_lock(&mgr->lock);
>>> -    ctx = idr_find(&mgr->ctx_handles, id);
>>> -    if (!ctx) {
>>> -        mutex_unlock(&mgr->lock);
>>> -        return -EINVAL;
>>> -    }
>>> -
>>>       out->state.flags = 0x0;
>>>       out->state.hangs = 0x0;
>>>   @@ -630,7 +607,8 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
>>>                         msecs_to_jiffies(AMDGPU_RAS_COUNTE_DELAY_MS));
>>>       }
>>>   -    mutex_unlock(&mgr->lock);
>>> +    amdgpu_ctx_put(ctx);
>>> +
>>>       return 0;
>>>   }
>>>   @@ -639,26 +617,18 @@ static int amdgpu_ctx_stable_pstate(struct amdgpu_device *adev,
>>>                       bool set, u32 *stable_pstate)
>>>   {
>>>       struct amdgpu_ctx *ctx;
>>> -    struct amdgpu_ctx_mgr *mgr;
>>>       int r;
>>>   -    if (!fpriv)
>>> +    ctx = amdgpu_ctx_get(fpriv, id);
>>> +    if (!ctx)
>>>           return -EINVAL;
>>>   -    mgr = &fpriv->ctx_mgr;
>>> -    mutex_lock(&mgr->lock);
>>> -    ctx = idr_find(&mgr->ctx_handles, id);
>>> -    if (!ctx) {
>>> -        mutex_unlock(&mgr->lock);
>>> -        return -EINVAL;
>>> -    }
>>> -
>>>       if (set)
>>>           r = amdgpu_ctx_set_stable_pstate(ctx, *stable_pstate);
>>>       else
>>>           r = amdgpu_ctx_get_stable_pstate(ctx, stable_pstate);
>>>   -    mutex_unlock(&mgr->lock);
>>> +    amdgpu_ctx_put(ctx);
>>>       return r;
>>>   }
>>>   @@ -737,11 +707,11 @@ struct amdgpu_ctx *amdgpu_ctx_get(struct amdgpu_fpriv *fpriv, uint32_t id)
>>>         mgr = &fpriv->ctx_mgr;
>>>   -    mutex_lock(&mgr->lock);
>>> -    ctx = idr_find(&mgr->ctx_handles, id);
>>> +    xa_lock(&mgr->ctx_handles);
>>> +    ctx = xa_load(&mgr->ctx_handles, id);
>>>       if (ctx)
>>>           kref_get(&ctx->refcount);
>>> -    mutex_unlock(&mgr->lock);
>>> +    xa_unlock(&mgr->ctx_handles);
>>>       return ctx;
>>>   }
>>>   @@ -886,8 +856,7 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr,
>>>       unsigned int i;
>>>         mgr->adev = adev;
>>> -    mutex_init(&mgr->lock);
>>> -    idr_init_base(&mgr->ctx_handles, 1);
>>> +    xa_init_flags(&mgr->ctx_handles, XA_FLAGS_ALLOC1);
>>>         for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
>>>           atomic64_set(&mgr->time_spend[i], 0);
>>> @@ -896,13 +865,14 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr,
>>>   long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
>>>   {
>>>       struct amdgpu_ctx *ctx;
>>> -    struct idr *idp;
>>> -    uint32_t id, i, j;
>>> +    unsigned long id;
>>> +    uint32_t i, j;
>>>   -    idp = &mgr->ctx_handles;
>>> -
>>> -    mutex_lock(&mgr->lock);
>>> -    idr_for_each_entry(idp, ctx, id) {
>>> +    xa_lock(&mgr->ctx_handles);
>>> +    xa_for_each(&mgr->ctx_handles, id, ctx) {
>>> +        if (!kref_get_unless_zero(&ctx->refcount))
>>
>> This should be pointless, why not use kfre_get instead?
> 
> True, don't know what I was thinking.
> 
>>
>>> +            continue;
>>> +        xa_unlock(&mgr->ctx_handles);
>>>           for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
>>>               for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
>>>                   struct drm_sched_entity *entity;
>>> @@ -914,20 +884,20 @@ long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
>>>                   timeout = drm_sched_entity_flush(entity, timeout);
>>>               }
>>>           }
>>> +        amdgpu_ctx_put(ctx);
>>> +        xa_lock(&mgr->ctx_handles);
>>>       }
>>> -    mutex_unlock(&mgr->lock);
>>> +    xa_unlock(&mgr->ctx_handles);
>>>       return timeout;
>>>   }
>>>     static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>>>   {
>>>       struct amdgpu_ctx *ctx;
>>> -    struct idr *idp;
>>> -    uint32_t id, i, j;
>>> +    unsigned long id;
>>> +    uint32_t i, j;
>>>   -    idp = &mgr->ctx_handles;
>>> -
>>> -    idr_for_each_entry(idp, ctx, id) {
>>> +    xa_for_each(&mgr->ctx_handles, id, ctx) {
>>
>>>           if (kref_read(&ctx->refcount) != 1) {
>>>               DRM_ERROR("ctx %p is still alive\n", ctx);
>>>               continue;
>>
>> Please drop that check as well. It just leads to memory leaks and errors should anything go wrong and so only make things worse.
>>
>> We can have something like WARN_ON_ONCE(kref_read(&ctx->refcount) != 1) here, but I think that is superflous as well.
> 
> Hm, you mean leaving the entity around while the rest of the file gets closed causes other problems ie. this is not enough to turn crashes into memory leaks?

Yes, exactly that. This is basically just another pointless try to work around problems elsewhere.

Regards,
Christian.

> 
> Regards,
> 
> Tvrtko
> 
>>
>> Regards,
>> Christian.
>>
>>> @@ -951,8 +921,7 @@ static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>>>   void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
>>>   {
>>>       amdgpu_ctx_mgr_entity_fini(mgr);
>>> -    idr_destroy(&mgr->ctx_handles);
>>> -    mutex_destroy(&mgr->lock);
>>> +    xa_destroy(&mgr->ctx_handles);
>>>   }
>>>     void amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr,
>>> @@ -960,21 +929,21 @@ void amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr,
>>>   {
>>>       struct amdgpu_ctx *ctx;
>>>       unsigned int hw_ip, i;
>>> -    uint32_t id;
>>> +    unsigned long id;
>>>         /*
>>>        * This is a little bit racy because it can be that a ctx or a fence are
>>>        * destroyed just in the moment we try to account them. But that is ok
>>>        * since exactly that case is explicitely allowed by the interface.
>>>        */
>>> -    mutex_lock(&mgr->lock);
>>>       for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
>>>           uint64_t ns = atomic64_read(&mgr->time_spend[hw_ip]);
>>>             usage[hw_ip] = ns_to_ktime(ns);
>>>       }
>>>   -    idr_for_each_entry(&mgr->ctx_handles, ctx, id) {
>>> +    xa_lock(&mgr->ctx_handles);
>>> +    xa_for_each(&mgr->ctx_handles, id, ctx) {
>>>           for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
>>>               for (i = 0; i < amdgpu_ctx_num_entities[hw_ip]; ++i) {
>>>                   struct amdgpu_ctx_entity *centity;
>>> @@ -988,5 +957,5 @@ void amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr,
>>>               }
>>>           }
>>>       }
>>> -    mutex_unlock(&mgr->lock);
>>> +    xa_unlock(&mgr->ctx_handles);
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>> index 090dfe86f75b..d073cffa455d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>> @@ -25,6 +25,7 @@
>>>     #include <linux/ktime.h>
>>>   #include <linux/types.h>
>>> +#include <linux/xarray.h>
>>>     #include "amdgpu_ring.h"
>>>   @@ -62,9 +63,7 @@ struct amdgpu_ctx {
>>>     struct amdgpu_ctx_mgr {
>>>       struct amdgpu_device    *adev;
>>> -    struct mutex        lock;
>>> -    /* protected by lock */
>>> -    struct idr        ctx_handles;
>>> +    struct xarray        ctx_handles;
>>>       atomic64_t        time_spend[AMDGPU_HW_IP_NUM];
>>>   };
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>>> index 341beec59537..471d27b2db01 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>>> @@ -39,7 +39,7 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
>>>       struct amdgpu_fpriv *fpriv;
>>>       struct amdgpu_ctx_mgr *mgr;
>>>       struct amdgpu_ctx *ctx;
>>> -    uint32_t id;
>>> +    unsigned long id;
>>>       int r;
>>>         if (fd_empty(f))
>>> @@ -50,10 +50,10 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
>>>           return r;
>>>         mgr = &fpriv->ctx_mgr;
>>> -    mutex_lock(&mgr->lock);
>>> -    idr_for_each_entry(&mgr->ctx_handles, ctx, id)
>>> +    xa_lock(&mgr->ctx_handles);
>>> +    xa_for_each(&mgr->ctx_handles, id, ctx)
>>>           amdgpu_ctx_priority_override(ctx, priority);
>>> -    mutex_unlock(&mgr->lock);
>>> +    xa_unlock(&mgr->ctx_handles);
>>>         return 0;
>>>   }
>>
> 

