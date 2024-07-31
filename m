Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EAFC3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jul 2024 13:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8A6D10E0E8;
	Wed, 31 Jul 2024 13:34:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xwZ+RDO2";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 780E710E0E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jul 2024 13:34:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jss0RMVnbH4GEGEPZOg0RlAxEn+VILbwRMweY6FrD0wzLcwrKDGpHirMktWkIpO7b3s8HIgRsOTms0z1/juaw0MYLbkfeBHD2eFEAJ4/Ubqpp6Oln3bkAsMkwi3x+BVy7pC5WtroJHgEaOBTpvx/p1EPJxCGSQehnxdbwbotH0A/i98P3jbM++fhg811x1zHITJMmtZlg2nPQPlZ6JRPLXC18o6mcmLt5Phve+wjIrhEbV97lTRorAAyG1OqClIYM6u6TQMiFVZr+35KtSRfH4KCMzwdG8pOmmbG8jqHET62SW/XJxqyeN1OQZWYPlKooXiVPE1pdHo6MdZfCmGjwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmKP51VUcki79fJj3gGsb3nG2G6UN7h9u3QuVSL+k/0=;
 b=rmedw93qfUXAbDR5woEghzldZSLSDefZaI6f6CuJz/6EfJpfdwnoUxDjMExntUHZlocR86Ad70x2WuynxH94z66uIRrx9UU5YflV3PrhNya3OZMtZ9CIz05ckVg0APhdEKgMkaMozTpPajI6lqTQhjAa1ELcFoFYkNDdaGG2/3IhLipN7mUfaSzm/8wWWuHEaso79tJdB6Ea9QcRLM2obfIPF8xaWSHqb7W/Os+JpnmXcuF6XfwrulRZTgE72Ty+N98kmwcLswrI5AeZho96DyKQsEZ0DEJMLUgVs3pI9GcsCo6KeTyvsb7hKr4d0OuEodYWuFPfDR3WsDts+f2sug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmKP51VUcki79fJj3gGsb3nG2G6UN7h9u3QuVSL+k/0=;
 b=xwZ+RDO2oNKYV9K5+9bjH7tfqGbfZye8GSAa9gjaqztqaMFlkbgEbcBIZwA+/oPa52bVkknV8ZmRQVGFJ+k2h/462RoqNHlqJ7o0Ya0UMTcL12HZfF0sx4Dy2BeAb0EZG0ObgZngooM/ziH0XiH31B5Tu1RYRfCjrq536ncsNjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV3PR12MB9165.namprd12.prod.outlook.com (2603:10b6:408:19f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.32; Wed, 31 Jul
 2024 13:34:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 13:34:32 +0000
Message-ID: <ddd0fba4-905b-49b1-ac74-30e6c7d04adb@amd.com>
Date: Wed, 31 Jul 2024 15:34:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] optimize the padding of nops for gfx9 gfx12 and
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240731131252.354336-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240731131252.354336-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0306.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV3PR12MB9165:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b8e78b9-fd64-4abf-be37-08dcb1658272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGcwaGdUdmdJMGNlWHRoV2p6aXV3cE1nRm9KV0MvNWV6VnNIeVA0SlZUaXVy?=
 =?utf-8?B?b3RvWVVObURURkRHWkRKSGxuak56UFg4elB2Y0c5NEhDZDVEN3VXYitHQjZw?=
 =?utf-8?B?TWp0bXdZSnBKWWxhQ3cvMzlGbXJocHBtUXllRzdRdVlhRnUwRE53UllzSzBT?=
 =?utf-8?B?THJnK0k2cXE2OFdsYmQrV1l6NS9lS2FHOHRoN01nVTNrWjdUaGFjQlFtM2hm?=
 =?utf-8?B?WDVvQXhKSlM4VkczOUxLOWFHMHVBaDJGWXR0YktRS2dDZHlGMytwbERGTzRo?=
 =?utf-8?B?TTdLYmdLSm84UTEwdEJVWHl3eDFTdUJlNVM4RU9LWis5alJJSi94K3B3c1JD?=
 =?utf-8?B?SFNoSjRBUGFOOCtST2t1eGE0K0xHNW9VMmhmbUp6MDNhNlNRRzZzRTJtYXJo?=
 =?utf-8?B?RzE1S1lhMWJmZXBGaTJrNGlsbGl2dDVTQ1h3ZUlLVUZTZSs5aC9QRktNQXJi?=
 =?utf-8?B?N2I2SmhFK3l3bWhOU2daQ0h4R2psSlQ0VWtwUVplTEliZ2NiZkgrWlMwZjdz?=
 =?utf-8?B?cHJCcTRwcUp6R21hV2RFaVBsRDFIS2hQNWJ4M0dmNXFGRjlhN3U0UW4rNjk4?=
 =?utf-8?B?R0RVWWF6RXdXZzVJOTI3L0VOakJ5YVVHc1JCUHVIRVlqT3UwNC81c0IycjQ2?=
 =?utf-8?B?NjZ5WXRFR0VVdzMxd1c2YmdPQ2lNVnJLRzNGOXI5c1R2cWdLN0ZOY0Z3VWlK?=
 =?utf-8?B?UzM4dUhRN0JJNUdFckJGd2ZKWW52YmZDVHZGVnp1MENHWlpPdFJJVG9DM2FR?=
 =?utf-8?B?Z281bytLQ0pOa1dSMDJhVEhlc1ZRaTJFZHFUYkVhekpXU0UrOXBzdHQ0L2ZO?=
 =?utf-8?B?SkxMWkhncXpTeWw1SC8zUzRsdWovN0g3UVZLL09ON2FnNVdYdmVNVkE4Uk5a?=
 =?utf-8?B?Z0lMNkJIa0gyN2VENG5IMWdIU1FJNmc3amh4RVhRWTgvbUVzWkZPd0ZPVjU3?=
 =?utf-8?B?cWFVcTZPenROUjdYRDNCaXhSaU9rNkpabkN5NWJYRkxjK2JwODFrTm9Ocm9W?=
 =?utf-8?B?aDIzKzg2Q2JhNEVhTjhWcWZpam44d2t0cnR3eThVdDM0Y0J0Z2pXNTd6eXFN?=
 =?utf-8?B?eGMyQ3FNUTJUMHVxc1BnOFJYbkFBS3U2a25Nc1VzL1hkUjlvZEhKN0VYbDcv?=
 =?utf-8?B?MVVHeU41cWZFVWZQazlybklROHgrSHRldG9ZUzd4U3IzZTdkbGNRTHQzSGVI?=
 =?utf-8?B?aFlmcU5OZlhlbmdncmxWOXhPa09nOFZad1ZQaENER2NiSHVDNlo3Tk04WEtw?=
 =?utf-8?B?SWRaTUZaQmZYVzdtSXk0RkRodC90OHc4M2NLQlRsTHc5bmxzd0hUN05DNWRr?=
 =?utf-8?B?N3REd3pOOHE3VmlKZm5hYkFDR2R6dVZwK3ZlV3R1T2hKYjVWcksvWGtYc0pV?=
 =?utf-8?B?Y3o1dFQyZy9aaHVqMjJHQ2hXNnhub1N6eTZTa3YvNXB3SXN1WDJiSlJuYWNj?=
 =?utf-8?B?TFNpNUZrS3NVUGlaQVpDMW9CbXNDRTFlbjR4aDhPcGdUaXZmUnNWZ3puS1Vv?=
 =?utf-8?B?RkEyS3NRYXZpNXFEejRaK1dxSnlQajByTzF1MnFzY0l4WmJLdVdoY3p6SHdz?=
 =?utf-8?B?akI0T0NhSXJwUlBmQ2pMMW5hK0Y1akd2OWYyZ1RGRG9icVVsMHhqYi9UR3Qr?=
 =?utf-8?B?anlWV1IvcVpSdXg0ZHIrMjNCd2IxZXdEUWtreW5HUlhVVStJRWoySW1ENUda?=
 =?utf-8?B?SVVYQmJDZW1MeU1hVVJWWG9wTWVoU3ZOQStVUUhXMlloL1FzRVBwaDhNS2VZ?=
 =?utf-8?B?ZWdscFU4azRkOTBkZ2gwWGhxNXpPYXlNdUIrU2JZemI2NWp5ZFk2czdNODBz?=
 =?utf-8?B?c3ZxNXIxaHdhTGg1T3JYUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkMzeXpSR2JpOEdkcjNMTDc5VFZSaWJQYWY0L0dhYWt5NEhKOCtFblpCbG5O?=
 =?utf-8?B?NnFaQVRhTTJGam4vREd1b2hzRFBhT2RyRElLUGZxbUZzam9MelA2SHdzM0cz?=
 =?utf-8?B?RTZLK1FEanUwa2RFR2xLdjNZUDZHNHBiQUNmSlN2eXdzWFNGaEJNTFVJWHNZ?=
 =?utf-8?B?djRaNmVJeWM3U0lSM2tHbldoTUlJTlRjM2JFa0hJTkIvTXNjT0xHOTQvbEhy?=
 =?utf-8?B?VHYxQXdsMnJmUGRGRWlMREZ0cGdZcFdUSWdhdmdqakNBV1ZyckpwbjlUZkJy?=
 =?utf-8?B?VnpFWjFMTDZCeFMwV2drdmwzcmhwZmswRGFyaFk4OVFKTHBMM25SNkZuN1RP?=
 =?utf-8?B?dlZLUHhNMW8rMkVJcUlub1lGbC8xSi9tRDVJZGxNVDFoSkFpR3Y5RlEyQTVE?=
 =?utf-8?B?L3ZUaVFheUpuQng1SlpRdklMUGs1VEtIY24wcXR3NmZmMDZ3SCtsZ0xMVzFO?=
 =?utf-8?B?MEhWUmh5MTlvaEVpUTRVUmlGKytrcEF6ekFHV3N4bjVidEluaVZINVh5NndQ?=
 =?utf-8?B?akRiK2NIa3IvS3laNWZCaE14b1Q0ZmhVeGo2WFA1d1NHYmZkMjVzUndRQWRB?=
 =?utf-8?B?VE5WSTRpSlpwdE5TOWZuczk4OTZNYmFhLzVCRGlUQUpMR0dsdyt4T0hLd3dR?=
 =?utf-8?B?cnA3QTJxd0dBYTB6SnhVUUkxalFYMFRHSFMza25VMEtrd1FZUjJ6YnFlak8x?=
 =?utf-8?B?VDBybXVXR05LWG9CdHp0WmVpSXhtWUNHZWRLU1NreEVGZ3Bhc3JJcmdmb2FV?=
 =?utf-8?B?SXNYNDdMa0lZZGQ0MHFmZkx5T3dkMms5dTVEbXBpL3Y1TXVNWjlwdW9jY3By?=
 =?utf-8?B?MjZHZU1YWHN4MUdyZjJsWVNwdmdFanVxa3dUTnRQc0srZGJtaEM2RitpVWVK?=
 =?utf-8?B?YXJkMjNlN3BVR2lUQUlsWGxwVHhaR2ZCSkpXWU5USWZYRCtaeVdUNkZhRXk0?=
 =?utf-8?B?R0gzZmgySGNjbnFOSjRodGR0M2NDQ2FhVE9YOWhuMXhndkJLNytvSWJuSXZK?=
 =?utf-8?B?SG1zUWhFWnJSQWZxVlI0cjJUck1LT2dkNllVZ2xxd1NGMCt4Yno4eTlZTmxh?=
 =?utf-8?B?ZDFMdkdQN25zWlRXRGlBNVkvVFFuV0ZKTTVwdklMcFFlUUwvc0dHVCtQOEhl?=
 =?utf-8?B?bWhrQnVUWWY2N2JTREthNzRRb2dkcWpaRUNvSkxQaTJCWHI2elNmU0QzcEJw?=
 =?utf-8?B?enNHV1pBSTZheXNZcFNVVDFsV3JhRFI3V2JyVDg1U3ZpaFF0bmtjTmxsem95?=
 =?utf-8?B?SnRFalFOVG5qSEJGZXZiR001SSs3R1pjNVgxcTJwOHNPYWZBYnZpVFZ4eDVP?=
 =?utf-8?B?SDNnTDNDRm5LckVVaUg0TXRwcWpXMHl3aDh5WW9PcVRhOU1QUXpTcmZJLzRK?=
 =?utf-8?B?SnkwVVIvNEQ2NHFiZDY5bTFNN0krN0RxT1JoT2RvaUIxZTJ3WUcydXgzM2I5?=
 =?utf-8?B?VjhNS0hkSnBycjFqNWlOVE10eDVDL25ZZmJIY3dJYW96WmkwaTBsZHUreUlI?=
 =?utf-8?B?ajBvVEI5WTIzZ09GdjRaZi9VbmhsNUdsM2FzVlFRRkQ1dTVETWNuRmJFK2VT?=
 =?utf-8?B?TUtxK0NWNkVFSXBuWWNFQW5KbE5jNzhxR0UweENYQVNpdUlRV3kycmNTcVFL?=
 =?utf-8?B?Q2VRb3FacFl6Q1NMUGNwT2ZhY2ZPUWs2MjA3Q3Rwb1BZdDRCV3g1Q1kzaytQ?=
 =?utf-8?B?YVlNUWRSZWNIeFB2MHZXMEFDb1ZMYTJtVkY3Qjg0SEtiaVVxbEtFbWV3M2V5?=
 =?utf-8?B?djNJa21ZVmE3ZmR5cGxDRFExMmJGKzl2SiswbmRpa0VDaDk2YVp1SVpSU1hC?=
 =?utf-8?B?YnNrTDFCdmJIbWJENklUSGwwaEE2TW9OUDljMHJFNkhXWVZobXJXR2wrNWpO?=
 =?utf-8?B?QUt6U0F1ZHd2YXhCWTI2ZmFJWU1pOGZMRjJya2pOblUyZkwwaXlSTHdxZ1NH?=
 =?utf-8?B?MVd5MlR5U01MWVNNdkdWOTVrV1RPTXJWM0kxZVhpSEZPUGtvb2V3N20vN0FX?=
 =?utf-8?B?UE5sNE9RcnEwOG4vUFYvL05ScE5LMGRvZk9mdHZxbjVST0hmTXZUTXpFeTNK?=
 =?utf-8?B?cEhKa0phZnNiWklEOU96SzJLNmZ4VXNKRVNZYzluK0VCLzF6QnVTbXNnakZp?=
 =?utf-8?Q?P28k=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8e78b9-fd64-4abf-be37-08dcb1658272
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 13:34:32.1265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMnvU/sAlUyrbuItTIz50tMCScu/llDeP0maW8dc1iHN/NV8CIQOG8UH/Zvl9KUU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9165
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

Am 31.07.24 um 15:12 schrieb Sunil Khatri:
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
>
> *** BLURB HERE ***

Reviewed-by: Christian König <christian.koenig@amd.com> for the series.

>
> Sunil Khatri (3):
>    drm/amdgpu: optimize the padding for gfx12
>    drm/amdgpu: optimize the padding for gfx9
>    drm/amdgpu: optimize the padding for gfx_v9_4_3
>
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 22 ++++++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 24 +++++++++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 20 +++++++++++++++++++-
>   3 files changed, 60 insertions(+), 6 deletions(-)
>

