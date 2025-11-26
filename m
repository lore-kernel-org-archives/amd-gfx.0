Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C813CD10397
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 10:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AC7710E59F;
	Wed, 26 Nov 2025 10:07:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sZoNdK3g";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ACF910E59E
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 10:07:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sx7Mx6FTataI3lKlWwyGBG8CnT7xvnple5f0rzbHI8iYFRCZE652B9il5xL7GFdj3bJy807qJTfTvJ+umVtuwD0dsml4LCgo98MNXXGwOKxjvM8aDygLfn6xisBTtC/XCq8qosNWLtqmobzNJ/+r0vjasZo9riinBrBbNZqH062s3zDqoTzq8nDX83I3YI9JU9L9o1n3/TvifN89G/0sRacv0/ZIUJ5g73d0i64DNqnYSZ8ya2oVuMAk05eMGS5NCponV3cbNzlKUifWcjHWpxWjawnQboEpc9B0luNwxYHuFWh2bvKddRzaVmKGhj2i+gfgqGiKQRdZZq66Hivssw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfjHstGEIT4gAjrpEoS4CA0ONyqKHgJatqY97eNV7Fw=;
 b=X6I3D5D8jxgUDvayoZhOWutyJQV5L9F5oiaTqRhhst5MrKR5DLuiXFxb1k/G6UvG7p80umUl2B3yU6xxm0xnAFimueSM7Rnqzt28aXVHNRMbZ3pF8t79vr6YnrElpvQD3kju/WwInQwoXYDH3E5ICjXwAg5UJwGrBZaeuNgyuYroMisaSlCANpRifU1eAgnBaG/drD63tCEHnGqG36GmOVHygRvF/2rgkBfyoYtKkL+tO84A0sWEcSqfQBXsWBXiHnzhBQoRQiocbNySdpge9YxvIvibXtN8uIdgFF1GrvPwyFUWOSPSdwhwpxgmo86cffWISQjJ033/YUPOnOBpaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfjHstGEIT4gAjrpEoS4CA0ONyqKHgJatqY97eNV7Fw=;
 b=sZoNdK3gYcewwhRiVzKv5UTND8+dHX56kiNMK+aN3IvpSVmaDqZZRnqU/hgnR9fCCmDgEbWMTrc7nEy4HqO5+2nPIZ9cchz4PfnjujhRaOHU8i5nxGBipYg1DfI6dC/j6zfQ/Glx4UMVAWy7ifx9mDedqwzDznu6h++KEIlJ560=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB6679.namprd12.prod.outlook.com (2603:10b6:806:252::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 10:07:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 10:07:05 +0000
Message-ID: <e429f6a6-d2c3-4aff-b163-7a6a6ce66ed7@amd.com>
Date: Wed, 26 Nov 2025 11:07:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] drm/amdgpu: Discussing conversion from dev_info/warn/err to
 drm_* logging macros
To: Gabriel Almeida <gabrielsousa230@gmail.com>
Cc: amd-gfx@lists.freedesktop.org,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <CALsHKmVcdNJ2jNQ8Y8xuVOCPHo-Bekpam=69SbZqCK9-Dw+_Dg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CALsHKmVcdNJ2jNQ8Y8xuVOCPHo-Bekpam=69SbZqCK9-Dw+_Dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: be561b8c-4874-4dbc-022c-08de2cd38d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a05FcUVHaDhjdVlPNkpKRUQ2SEh2TWFuYVZqY3NoS0pnUytyVDVGaUltVTVp?=
 =?utf-8?B?blM3My83cmxVczRKandwbmdZcE15YWtsd2puSWJDclh5OXNyUnFudVlXcmZk?=
 =?utf-8?B?UWdOQ1VneHI4bVBadVdFbG56ZU50N05iSjVFTGRpaURyVGpCU0JhSjRZR2dM?=
 =?utf-8?B?RHBOTzM1VzNWVmY5ZWI0SlhGMCtsVm04T1grYVM4YjNuTEloOEhGN0tuTjho?=
 =?utf-8?B?c3ArcGpRVU5iVTExTG04MGJWZzhaMXVjR25NVFcwMUE0Njg0RWZjTmFoR1Q2?=
 =?utf-8?B?OHc2djNPeDlHWDF6RnZReGNaOU9odlo4MnhOaTdOaFd5VzNCYlhtWU8weDBO?=
 =?utf-8?B?WFdOSTRrRG14L09sVlZrclBCUTdpcW01NlFqNzZySllqdmZJZlIwZUFlUUov?=
 =?utf-8?B?dTFySERGQzMvRWdFRUVnRThLUFJHTDVoSE8xNjNObDFmdjg4OFVLTHMzUDh4?=
 =?utf-8?B?c3k1WVVyNExzMjNkSE51K1BBMkE5ZkNRdlBFOTFsVVZ2TzRudkpJODBmcG9V?=
 =?utf-8?B?d1pBNnNJWFV0T0ZUdXZkdlFGaWE1alI4TEhuNWd4aTlNNFp0Tk43QzEvMkE0?=
 =?utf-8?B?QVprM0hieFNlZFNneTgxdXNRQ0V3S2QwUlNoSkQ1YkVRM01CbDBSRzYzaHBB?=
 =?utf-8?B?eTh4TWtVK0YwdGRnaXpuNHlxbjhVTExtVVZCVVJKMWF0UGVDUG9PR3pDYS95?=
 =?utf-8?B?eTlVdGdQS2V3TXhFbzJKTzI5REZQb09OR3VVWmZMUW9aS29PL3lqbCtVUnVa?=
 =?utf-8?B?U3RYdzdIVVUyRkVxVWw5T0xnTkZnQ2JWUVJvY2FpRU9NRnE5QUIrR21BWkpW?=
 =?utf-8?B?K21QT05QMFFralZDOGRyeEZ6ZnJPZ0t2RWsrVzFvbWdwU1FNMWEyMy9zMUNo?=
 =?utf-8?B?eWtQODRiaGwxYjZEcVBXc0NMT2dITmhIemw1VEN1UDVaS1kwWEMxRUpCUytN?=
 =?utf-8?B?WjhSTEFlVERjUjNKN0liSkNhMDFWa0hkeWlxbFI2aXNLeUZId0ZsdXQ2MFFW?=
 =?utf-8?B?ZlArcWF0SFZvSHFtSXJWUzJLNk9GSlByQlpzRWg3b1VBa05IQVVodGROYjAr?=
 =?utf-8?B?bnovOHQwb3B4ZHF5TlB4YmJXbEVoTUJQZXRlVTEwYWZBRm1acHA0VHF5Qmhs?=
 =?utf-8?B?YVB1dmFua1NlMHZNMnlET3VQQ1ZqREVVWTI2dWR3Tkkwa3dVMlhyUm1Wd1FS?=
 =?utf-8?B?RXV4enFrT0tRZldyazNrMEpRU0w1bFJRbm1HSHcxRkFpVVdCV1p4QWVXOUxV?=
 =?utf-8?B?b0tnVlowc0ErbWlBeUF5akgwMTIxNmZaY3BIQmNIRGtBazZJY0RSclgzdndn?=
 =?utf-8?B?WThIVnhocDRvNTFZVm9IeElndldWWExaY1M1SmY3a2xJaUpObjNXMGtHMlMw?=
 =?utf-8?B?d0xYakJLRDVmb3FpTXhWK1htY0JpWW9taE5JWHkvVE1HbzQ3SXM1MUxndlFw?=
 =?utf-8?B?WWsvallVYjBHMjRBRmdZTXlqL3VUWnV0b3RsYTB3RE51ZHJrbk9HSGNFejVO?=
 =?utf-8?B?b3c4Tm1nWEtqR3hkQnQ3RzRNT2RwRHFiaGl2VzV6YzE3WXhHWllwYkhIMkxI?=
 =?utf-8?B?Nk9yaWJMSWhJRGhYemY1QzBCU1B2NUZ3Z1k2MmJCbXB1UDlZQXVRTGlsdWJN?=
 =?utf-8?B?UnVKdUpUZHEyYXp3MExBeUwxenFFejB0Tm1OQkYreURaeTc3Umxmd1VpeXQ2?=
 =?utf-8?B?UjFvZXFvNmRFcW41K3hqSld0ZENLSXJsY2NmenRtMHhadGc0MGFRbzZJNzB2?=
 =?utf-8?B?eGgxa0FYbHBiNmUyQndyWGJIUWx0VmM1b3FTRTBiRXVtNSsyRmxoMHMwY0xa?=
 =?utf-8?B?d0tFUEdkS0UxVXpxOG5RbkdGQlJsaGJQRWZnR01CSHBTU2wyRTZaS2tReGVP?=
 =?utf-8?B?ditDSTU3UGw2bmFiU3RWcHcyeUFjWDBoQ3BPV1hIbXk0amc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2ZOWkJPbkRla1pFVWlTWDBpYmRrL25ueUY5UG1jakpjaCtlZHBBanJIL0JX?=
 =?utf-8?B?YU5LbnVDaDlrQndmRHZrOXJGbU9NeEJ0TGxvVjlDa0JrTlBXakFPVTgyd1k1?=
 =?utf-8?B?clBGYzFzOW9JS3Y4Vk9EQjBnZEprYTE2U1lUcGJlNDc1V2x6NnFMdmw4L3ov?=
 =?utf-8?B?S3F4am42d1hHcE82akYzRVE0K0F3SUgyRHNSQmlvejVLT1g0V3JYa29pS1ln?=
 =?utf-8?B?NnNueHBYOVRzeWIyQ3NybmRxdWpVY3RCbzRFQnJzVkFtRXY3WkVkR2VnVmNS?=
 =?utf-8?B?YUxiYVdDblI3ZXViMEZjNFF2NHRtMWFHY2NKMDVtcEtIS25GYzZ4YkpaL3Z4?=
 =?utf-8?B?dHE5LzFjeldQNnRvcWllVnpBSk9hMWc1Zmpvc0FuMDhGVlNDN3BycUZWSEtx?=
 =?utf-8?B?K2pyd2dCWmNmUWlmYnd5VVJ5WUt6MGpPOE55K2dPR3QxUmNkemVMZWFUcVpE?=
 =?utf-8?B?VytjSTRvVUNFTFBWN2o3WTVVMytpQVRPUmxyeXhWREdScGtRUVlpU2wwQ0Fo?=
 =?utf-8?B?WUlxUHp3Um05TCt0QWZjR0JGdklMZ1E2V05pZFdBbHZLVGllRGp0K21ic2RP?=
 =?utf-8?B?TGdWYXNVQVpPK2N2WjhISlcveTgwcHJSY0lZRHF3V1R5dk1CU01CNEk5ZmJk?=
 =?utf-8?B?VHhESFBXbkZmd3BuWWkzQzNMaTBTbFhxM29IYlFvamF3WWhTaXFKMDBrNk1l?=
 =?utf-8?B?QVRUTmdiMkxBMHZIY1dESUFSNjdLcFhTTE5vay9MTWlLOTlSM2lVMlkrTTZ6?=
 =?utf-8?B?bzI0NVF2SHd2SHpCRGxMQS96M0RPV2x5NkJpN3p6WkJ1Yzl3WGw3R1lzdGZ2?=
 =?utf-8?B?OVZ0alBlUXphUHhLV3BoelRKcFJieDRqTGpUUlc5QzQyeHBBRm9wTFIrKzMy?=
 =?utf-8?B?YmRJd2RtbE1xbVBNUytPWXJ5UlZCeHRsSEZuZWZPWXY2bkR2WENGanM1cU5m?=
 =?utf-8?B?d29UVFkraUFUV2tBVFZnMVlYSk12V3pEZlcwam1iaW42YmFOcE5mUkZINzFZ?=
 =?utf-8?B?U0p1azZzdlpXRUQvWHNFK2NjaTBZWXJDUUloRVdHQ3JNdEk0aEZYV3BQNnVj?=
 =?utf-8?B?ZzZxRnpRTUdZcWRJSmFjRDdvbHV0TURXdk9qNDBDZi9WSkJrVjB5SmJ0Ym9v?=
 =?utf-8?B?YUlYZ0EzR1piNitaZDBYOWJmMTYwSy84dmRFaDVXdUFRK0dIQldnWGRDM2Vk?=
 =?utf-8?B?WUZLQzJPQUFaRlN6NDgrVTRQRnliN3IyODZGeHJuOUFvZ2NsallEVVk2T0Nu?=
 =?utf-8?B?akhjWThCTGZkbVQySHNsRkZYRERGNVdyWDNPcVNoZzk1QU4vbE4zcUwxNDlR?=
 =?utf-8?B?VkxxMkN6dDIzQVREb3VMV09TQ05zNkNQU2JxY2V0dlBFbUdPMjBWTDVocWNS?=
 =?utf-8?B?TGc4eG5IMkNNYm1hcDlrOHpnTXl0V2RJVE5EOWFnVERwdlNXYzh5OTNMUUpL?=
 =?utf-8?B?SHovcDR3SVFVZGNoNldMTHZpU202RDlJa3VSQXBpTG5RbmVUYU5Qc0xVYjNT?=
 =?utf-8?B?ZUtOMlNRZ0MxOXVxRUlvZWV5MVdOU2FydUFXQmdBc2FScnUrSVpZVGZCbEpN?=
 =?utf-8?B?T29HMStvTGN6U3RlM1NscEIwSVprdFdhR2pJdXN6NzI5SmVEUnhWRkRUVVpw?=
 =?utf-8?B?aW1RbW5uU3h3ekJiQ0ppa2Z4cnJIQU5MQmxqR3RsVENrRWUyTkQ0bDk2S3VN?=
 =?utf-8?B?ZnZkQURiZ3F2TFRtWWlVK1RZUHJnU3VzSzUvWmtCYjQwR1NZajVyRE1NVUFI?=
 =?utf-8?B?UmVnVDBTRzNhR0o4WVNhL2kwbjQ2U3Y4V05jUVpVeWxoTDIxczUrT0J2NmtL?=
 =?utf-8?B?VzQrSzRma01wUHl3RlEyN2NrVzRQQW4wODB4eVJ4UkFSMTQzWEN1KzduZ2M2?=
 =?utf-8?B?Y21PWjgxSytCMlA1NmdzZDJia1RSZDRaTXY3TjZzUmhtUjc5dWoxQ3NXSWp3?=
 =?utf-8?B?N1JCanFpU3ZrL0k5OXRzNmVwSTNuc2Z4RS9vQzVRR0tSYzk1bjFmV1FlSmNM?=
 =?utf-8?B?bzh0YzM2OVN3cGlrdXB1aXZ5T1hFY2RiY0VNZ3BYWUJQRjRRVlNFVXZ0U281?=
 =?utf-8?B?TmdDS21UR1F0Vm9oV3g2T2pJc3NEdTlaWGR3NVdSZ3EyTGhTZWZTL1JqSDZH?=
 =?utf-8?Q?S6lN+IaCaIjdFscZv/LUcQ+Uw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be561b8c-4874-4dbc-022c-08de2cd38d0c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 10:07:05.0433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10XdlbnKmlpbFyEWBiq2TB7tLoTbwIwhm8Z2qzw86o3jUBs+jdfuICi2cIW8sBL/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6679
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

Hi Gabriel,

On 11/25/25 20:24, Gabriel Almeida wrote:
> Hi,
> 
> I’m currently looking into the task of converting the logging in the AMDGPU
> driver from dev_info/dev_warn/dev_err to the drm_*() logging helpers that
> include the drm_device parameter. Describe in https://dri.freedesktop.org/docs/drm/gpu/todo.html#convert-logging-to-drm-functions-with-drm-device-parameter <https://dri.freedesktop.org/docs/drm/gpu/todo.html#convert-logging-to-drm-functions-with-drm-device-parameter>
> 
> Before starting any series of patches, I would like to confirm whether this
> conversion is actually desired for the AMDGPU driver and if there are any
> specific constraints or concerns regarding this transition.

We really need to update the TODO list cause the task description is not specific enough and you are like the third person asking the same question about it :)

The drm_*() functions should be used in drivers for everything which is DRM specific, e.g. KMS, GEM, DRM common DMA-buf code etc...

Everything which interacts with core Linux functionality can or maybe even should use the dev_*() functions instead, e.g. PCI subsystem, I2C, power management etc...

In the past some of the older DRM_*() macros usages has been converted to using dev_*() functions because the older DRM_*() macros didn't printed the device and so we didn't knew for which driver instance the logging message was.

Those conversions should be taken back by using the newer drm_*() functions for logging, but everything else can stay as it is.

> If the maintainers agree that this migration is wanted, I can begin by sending
> a small set of patches.

At least for amdgpu I think we are pretty good already.

If you still find something then you can certainly send out patches, but just not try to bluntly convert dev_*() calls into drm_*() calls.

Regards,
Christian.

> 
> Please let me know your thoughts.
> 
> Thanks,
> Gabriel Almeida

