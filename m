Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7CAC3ABAC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 08:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 452EC10E14A;
	Tue,  6 May 2025 08:23:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QTwLHtqB";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AC6610E14A
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 08:23:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qvcp4CvyMuwCvYEIZ+61FZ8+aFxKP3glR/ZJVQ5Nq0qvajrPc9Gm2mLu506vaa4mDMLL/u9Kg/MSo6/kABx3omj6J3AG6/ny5Ref/PkfPTuYUcYMjCGSwq4z5QR6FysPR856aXvCV/crYTNkZ679p5qi7RrcZnQwEUzkJPREQqZaDDO3kUOCCIgpue/bUtahh9ba4pgfunllGyKc1/AX2Kw6okfMTsC55xmVnY5eZb1gL0v6F700F1ul3LhHXQCgjFc/ffbroSmE3kexI3ZECHG1/+SSOf2RhEAnX87rHsM60yDMdRVRj3V0P8HkxMhiwVvx4tDXWBVERBHg9KcfAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ab2RX1oe7S9YByjEM1HTzC6bT4dlqRoKiYSGz1vv0sY=;
 b=no+6juItnTOBISPhHBRE5w1uYe+k1zZFQPZAKx2GGonRw9IJVE4ECQnIT+VqWYx6rzXoQQOf08/CywVfNcYM2GxltQCaucWM9WgMl49gpTX61Az43XjZfZx2qicchDdLnybGCAf6vV/3mZJIogN/Q4uzATDaJR4GrSHcrX0iZXCBwmcUQ5kLriK6HSkFNQA8VCs/ZZ0uyo1V/eRxsctlDzQFgiRJ+A2l4o8ffnGGPkl88SGwKLV3nmoPEtjYWoXMZYsRuHk1lvsVHbEdFuyul3WFhHQi2Tf43uYzELS8OgANFXdcCnL81wUodyPDj+O7CZTSujnUrDPtctvT8dy3dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ab2RX1oe7S9YByjEM1HTzC6bT4dlqRoKiYSGz1vv0sY=;
 b=QTwLHtqBjC4+Y7cnBUp75y/oPx6GutTCsHneDCKn3SAl2fiy6lcd0V53tx2CuZZuYcGwCe5sMjL3cB+htw5JKSzFI/mLgiPPxGUYFSO/wdS7Y9/xfpLZ8PIP179Ewj4Rl3Bt64RZQsVhS+wgyQ7oPMYMBMVGDdebQEjnVfSk0MM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB8037.namprd12.prod.outlook.com (2603:10b6:510:27d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 6 May
 2025 08:23:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Tue, 6 May 2025
 08:23:06 +0000
Message-ID: <6258d434-dca8-42e2-8e12-d14d0ef6abff@amd.com>
Date: Tue, 6 May 2025 10:23:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] drm/amdgpu: don't sync the user queue eviction
 fence
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250430024054.4093239-1-Prike.Liang@amd.com>
 <20250430024054.4093239-2-Prike.Liang@amd.com>
 <5f56c1c5-5bf9-42b9-b7c7-9e6508e803d0@amd.com>
 <DS7PR12MB6005F0A315798BE0F22E05EEFB892@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB6005F0A315798BE0F22E05EEFB892@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:208:160::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce20b44-eb22-4beb-27bb-08dd8c773a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0N2SlA4V1BFUlJyYVRyN2tPdXdWSmlzZnBKN3VpTnFwSm1oN1NjSDQrQTZR?=
 =?utf-8?B?aFVNWFdQaHZJMzl3ZjBqVFZpVGhVRlpmSWtmWFc3b2dLOWpSVWw5ZXdtOFZZ?=
 =?utf-8?B?YWJjUElpWGp5MkIyN0k4UmM4VmpwTEZJQ0QzZExRa3Znb2I4QzRtVTJob1lB?=
 =?utf-8?B?cmF6K0w1TmpJcTQyZ2pJVkMzUUFwM0E5Z0puc1BhN1U4R2VrMFVQRXRYTkhu?=
 =?utf-8?B?NklEV245cWt3QUE0NlZkWldBZzNDT2kvcFRWQWY5eEwySVJ6eW1INHM5NzJY?=
 =?utf-8?B?QWNQZDRoSFR4TEwyZzBSWDQ0SFJCK2N2eW1DRVNtbURsUDRLVmNVQ1lLT2FP?=
 =?utf-8?B?dE0vem9oT3VuU1loRXNOQzlnN21jOGtwVE93RHRaUHZiOVl1NXgrbmhPR21N?=
 =?utf-8?B?YkduSEtnZ05lNHJ4d1ZFU050R0FPKzEvSXhSTUhGeFVnajlIbUNqT2hobTFx?=
 =?utf-8?B?UkNuUGVYWVNkUGE5Rm1DWWljdWFJcEtmNEZKam9ZaUdZZitmclVaZlR1TUZ4?=
 =?utf-8?B?Uk9UeTQ2MnN3OExXbUZGNGs1UWVydXFud0l4SnozcVRJck5vZE5najVEZ2o2?=
 =?utf-8?B?N2NJeW45eGV4TmU3WC9NMnVpdlNiMDVIRW5YZ2haTDA2d0pqNENxU2s4NHFi?=
 =?utf-8?B?TFZmWW1GSUdSanNMenhpaW5VZTNnUkhKbk9VSVVWTkNubVN5YUhyaVlwVUpR?=
 =?utf-8?B?TnUvYTV5NDlKWlpncWxFdE0rUW5Fa3EyeEFFb2hMUHVjcnQxSW43STdFT3Js?=
 =?utf-8?B?cWUyaG5BUEFUZHozTnRmR2pJYVB3dW1iem9jTVpLNCt6dFZIRmR1YXp2WTAy?=
 =?utf-8?B?VXFvdUhmNTBPV3Z1amlZcCtqNzFienJMdjdraW0ramVwbFZFaUxFOVhkKzhY?=
 =?utf-8?B?eDVWSUlUWVFTNGhoMTBDbTQ4V2h6OHFMQUlFOVFjRjAvWHhMU1pWcW81RkFV?=
 =?utf-8?B?SXVVb3hhLzV4b0pOOVpVREx4aEZIQ050WmVQSVMwMXk4L2JuZkRCSjhQNkdi?=
 =?utf-8?B?UDJhL1BTa2pHaXY5K3hWS29xR2hjdFI2TkZ5V0RRcGswaENIbHl4MTNDU1ZF?=
 =?utf-8?B?UzlLUW5pbUlsTDZiWEJQU0cySHlOSldnSWtDSm15QjZrZHU5YUNEUFVVRW9k?=
 =?utf-8?B?eVFmUkhIZDZyNkdKNnJiYUpxRlZoN2xQN05rWDdBTU5DT0FINzMyZkFFU1Rh?=
 =?utf-8?B?andTMzdPVExsZ1l4azljTlZnbmxJVUhLbGhMaWEwU2c5MFhEdmE4Q3krclhx?=
 =?utf-8?B?M1IycU93Uks5MUdZcjI3dmNteXREYXJ6M3VUd0xJdEZvOUFzRVVCT1Iwd0dn?=
 =?utf-8?B?RHhhVE9iV2JQKyszR05YaVZvaXVUVnRxRk90dHFKWWVWQURQN3lUQityTUxY?=
 =?utf-8?B?RXJtM0JpZzJnYXRDQ2FXYlljTlJNUTVnN3RSTUcwVmZxbnBHbmtRYUpJT1l1?=
 =?utf-8?B?ZktjWTRWWXA4YXd3VEoxQk0yZmdlOXVpejViMnBzYkUyd2lleFJDbi9ZRWdo?=
 =?utf-8?B?ZDRMUlIrOVVHQldlQTgwTjBvK0k2SU9GNFZuQlU4V2tqZjFkQ0wzZ0JGRnJD?=
 =?utf-8?B?MlpUOVR3SHJFSFBNY1RFbTFDL3QrWTNiY0ZJM0plNlhhbEp3TU5kZm01UXZR?=
 =?utf-8?B?N29NMWdQRWR5VDR3NllhbmM0WTNsMmtMbHprK0ZHR2JxWVV5ZjRaU2NYWVZU?=
 =?utf-8?B?YWJ2bWhXWmFwSGFXenQySy91TG1NcCtHSW95ZGNVQkxBVTFRMS80WlJpdkdy?=
 =?utf-8?B?TFBZT3pUUUJoU3ZYdFBTcUQrYWcweWgwc2Eveko3cjJXOFpRVUQyTVByYlE3?=
 =?utf-8?B?b0M1VUI5MDJSNnl0ODNBRXhVd1VrRmVlQ3RBZlNrSVY0SExmQ0J1b3dXUzFR?=
 =?utf-8?B?Y3pNT3Q4dGhkNlBrb091VEREaktZZ0M3MFlVd2puSWRGcUNPTmhQRUNlWTJL?=
 =?utf-8?Q?N/JWGjREhfo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlBLemVKMkJnNFVveUNqNEtLWjZtZGNQcTJ3aEJBSHNzMTFFQnYvdmFZdXFs?=
 =?utf-8?B?aWFROStjS1pWY2FpYkdkNnpsdmYxOGtoTDZuMlpscTc5MHdWWXpJcWtZWDBG?=
 =?utf-8?B?SkZSNmJ0U2d3RURsV3ZVVk80bVFwOFNuVWdaRms1L2FqWUFaWlN3MURhMlQ3?=
 =?utf-8?B?dWlmMjkzdSs4TW1OYXYxa09HMEJmVmZRL3VZWTZXQ1VwMnROTjkyWWN0d0kz?=
 =?utf-8?B?UUw5RlJwYit1OU1oQ20vOG1RM2xYL0ZRcEVwZHIxQ0JUa2wwUzRQcnBHeVEx?=
 =?utf-8?B?QUNjclBPTk9kNUdkL3kwcDZ0cjBrSlZVRk5QVVdlQThvaWNGUWJ4bElFalll?=
 =?utf-8?B?T3FyTDQ3S09wRDF6UTRWYUwxN3lLZjc1K2FtNy9UeXR3Q1dlNWlQbG1OL3RD?=
 =?utf-8?B?K3gwemx4VVhtcE9aMmcza1lpS29FQjhSOERsZytsa1BaSDJuMXpqWXQ3TzJw?=
 =?utf-8?B?K0JPUDMxRTVWZjVuNlZoa0s1eC9WUnBxUzRyK29yRTA4ZVZCbXd5QWlQMExa?=
 =?utf-8?B?STR4V0t3c1N4eFpHS0FhMU5jMytaTlpPSklNenJSalNVK1NkZHpsck5ZMzNW?=
 =?utf-8?B?MTNEdnErcGlFU3c0U2R4aXZzUDV1WStaQ1JXT1ltWTlFYVpkWDQzSjlhMXM3?=
 =?utf-8?B?TVp6dVpyeUJSRkdidnFIRHBwZzhUQlhycWE5cWZoc0xwWE01WDdsRGVheVdP?=
 =?utf-8?B?bldPMDFHTng4MDRQUFlYN1FWZU9QOWNsaWlpZFFIQ2d5Mi9tK2h1MjFYU3Nr?=
 =?utf-8?B?blVPcDdGN3hvSWVhYWd1TXBQRE5Pb3pkZWJIakszRHo3QzFlZ3oxNDFxaGJN?=
 =?utf-8?B?VEZmVEpxbW84N2xpeGhkNXRiYXBBSkVpOVQ1WXdVeFpUck5lR3JyTlhVZHNn?=
 =?utf-8?B?WlpjdG01RjcyRytGZmpEcEZCem5WTWRlV0gyeUozRVF4Z0tQZWtsdko2ajRl?=
 =?utf-8?B?MmhjMmNqUkJkZnd2b09HR2grN0J2amY4UUsrbDRhS3hteWNXdEk0T3F4UHQ3?=
 =?utf-8?B?MkRkK01XYnBhOWFOY0ZxOUVFRGt4Z2swZnJ1dStCNzVveUJ2VHAyWVY3ZXY0?=
 =?utf-8?B?Tlkxd2JhcjJ2b0FuS1d4ZkFPRm1Dd0hPQzgxNXZEMENZUnJxNDk5cG4zSnpI?=
 =?utf-8?B?NlJmRWRlZmdLU1pYLzkzUTNuTHBVZElabFRuemk2NldHLzdPS1lqQ3NkRHpl?=
 =?utf-8?B?TlVsQ29zVkFqcHRUWkFzVXhLdlpmNGlTWi9Yem1qTHYzQ1NIRnU2UFQ4WnNJ?=
 =?utf-8?B?a3I4MEdNZFMzcHNPbUI3NHhZVTNXUFZqVzF1VjN0RmVPSkNiWGpCWTM5eWVF?=
 =?utf-8?B?R3gwZVRaNG1OaExhNHcrSnZWNkM1M3pTcmY4dDZCTUNIZjMrTHVGaXZDMFAr?=
 =?utf-8?B?MXdRUGZwMzlvdzdVSE1RVUtKNHlubTZ6a0NMMzdiRGRvNStoSGQva0xlMU1K?=
 =?utf-8?B?RFA1MXRZVHBoUmU1WjBiVFdKR1pXSUpYbDUrYmdhcDFiSUR6Zlc4UzAzV2pS?=
 =?utf-8?B?Sk9qTUJTNVFpWGI1MWUwRXBuN0I3aVhCd0x4Nzc2R3MxQy9COU1ERjl1Z1hv?=
 =?utf-8?B?QWZLY0RiQmg4NGFYUmNENzE3MDFHbWwyalpINnMwSFp1cmh1VWRyVnpMckw5?=
 =?utf-8?B?MjhNaEdqaURrZ1Y2ZXdXM0V6QWFOenROdFgwVUw5SEdBSEZrS29EVk5CRGN3?=
 =?utf-8?B?WHhwK1lFVktMSzJFaDNMczBTU011NFpXdUlzLzlNK0o0UThiaVdKbHMvMVJM?=
 =?utf-8?B?WFdYM1lWNEpTVDFwUU9SSTdpOXJHSnRBN0FnNHNTUWQweGhOcUVaMTdHLzg0?=
 =?utf-8?B?NjhnVFhZOTdXQUQ2MHVFTGtYVm16NTRGWlo2c1RPNkxxeUhPODhKMlFGRnVy?=
 =?utf-8?B?emhGckVIV3BKYWwrdkNZQ2VCOUY4R0lxVjdjcjh1WlpjT3pkai8wREJ0V0VD?=
 =?utf-8?B?U0dUTUpBV0dPUGtiUHdoYWp4TlA3TldOY0dhWDkvWHFPMmpqZkk3TVZLOElV?=
 =?utf-8?B?Vk5jZDZtcFdRNGFWbU8waUNjLy9MaWIrVEdQMW5QNFlkdW5hbTY5NGt4WXFJ?=
 =?utf-8?B?T0JuZGNhdHdCRmhzZTZRVTQzam9ERjl0eGxKaWlBdkpWSzJpTU9mV1drVjFz?=
 =?utf-8?Q?31CToG2tR1RBcfaxPtmJuA4zH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce20b44-eb22-4beb-27bb-08dd8c773a65
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 08:23:06.6913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4wcJsVYb3F1yP2stl4RgYtqi4jFPje44wwKDB5Jg+Vhf92t2O9k4hssmh9TaV2p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8037
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

On 5/6/25 04:09, Liang, Prike wrote:
> [Public]
> 
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, April 30, 2025 7:57 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH v3 2/5] drm/amdgpu: don't sync the user queue eviction
>> fence
>>
>> On 4/30/25 04:40, Prike Liang wrote:
>>> Don't return and sync the user queue eviction fence; otherwise, the
>>> eviction fence will be returned as a dependent fence during VM update
>>> and refer to the fence result in leakage.
>>
>> Please drop that patch, it shouldn't be needed any more after the changes in
>> patch #1.
> 
> Yes, may I get patch#1( drm/amdgpu: promote the implicit sync to the dependent read fences) reviewed?

Sorry, I thought I've already done that.

Feel free to add Reviewed-by: Christian König <christian.koenig@amd.com> to that patch.

Regards,
Christian.


> 
> 
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 11 +++++++++++
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h |  1 +
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c           |  4 ++++
>>>  3 files changed, 16 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> index d86e611a9ff4..6c9b2b43a929 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> @@ -224,6 +224,17 @@ void amdgpu_eviction_fence_detach(struct
>> amdgpu_eviction_fence_mgr *evf_mgr,
>>>     dma_fence_put(stub);
>>>  }
>>>
>>> +bool amdgpu_eviction_fence_valid(struct dma_fence *f) {
>>> +
>>> +   if(!f)
>>> +           return false;
>>> +   if (f->ops == &amdgpu_eviction_fence_ops)
>>> +           return true;
>>> +
>>> +   return false;
>>> +}
>>> +
>>>  int amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr
>>> *evf_mgr)  {
>>>     /* This needs to be done one time per open */ diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>>> index fcd867b7147d..d4e1975cac71 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>>> @@ -42,6 +42,7 @@ struct amdgpu_eviction_fence_mgr {  };
>>>
>>>  /* Eviction fence helper functions */
>>> +bool amdgpu_eviction_fence_valid(struct dma_fence *f);
>>>  struct amdgpu_eviction_fence *
>>>  amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr
>>> *evf_mgr);
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>> index d6ae9974c952..8ac685eb1be1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>> @@ -185,6 +185,10 @@ static bool amdgpu_sync_test_fence(struct
>>> amdgpu_device *adev,  {
>>>     void *fence_owner = amdgpu_sync_get_owner(f);
>>>
>>> +   /* don't sync the kgd userq eviction fence*/
>>> +   if(amdgpu_eviction_fence_valid(f))
>>> +           return false;
>>> +
>>>     /* Always sync to moves, no matter what */
>>>     if (fence_owner == AMDGPU_FENCE_OWNER_UNDEFINED)
>>>             return true;
> 

