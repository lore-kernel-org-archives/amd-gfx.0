Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CACC3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 10:56:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD5610E387;
	Thu,  8 May 2025 10:56:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bk8nBfx4";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A1A10E387
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 10:56:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcD06lCjdQOXqhAO1hv5T7ynFCotJyCafKrq1WiQ3iYbcJ4EkABIedR3u+3clibGjDygRAcRD7r7nHHILSSrfoRN+9VUnCEg3hxzpdbPtUZxhuu/U7TfOFVf9A4L9dZzZfIUEjKFHFhOoSnniM7ip7UpP4dYbQiqzxbrjP3p0g0ARF0du/AyUF/q0BcV6OUMP9OuXmHuVUr3ChrFInR9GWR+hgxtUTKyjcw7i56uP/Bhi7zPFWk1j7Lr2FMZ8NjNdENd+5cYrTjYBZbBHjB4It4B0QEOIJBy1JDAQnm1XwkaT2VtkvzGMZz3Q4/7UEth80dEtTrVEaEbXky6lU/Nrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiYmM+yRD5pibwFwB05Kg9xx7EowVELuyHmVrM5hSjM=;
 b=Th8MhTdd0usZR2vs32IRDHa4ABLDX6FAFXl72MQspOCA52fX7WgEbdhHLSkQbMhWQL1fy+p7+yzh29al5sityehb2tvCOnTyITaKqCMBq0PXiJJfch1XouLBlHAX7NyYrqeWkj3OwSHFP/HSNkF3khM1SuyngMl/9Y96dgZY5cTDJ10lr2nPw8ZfqFsnJ/gaRxoaciGRsQsDX7ZJKBLyw6UqXI9yMxs0AcE8Kr2VbhcytBecMEfMhsUylNDlPHfStaRXFyePYaB+uuVwaqI26dDdryrMhrWucwbDTH+3AsfrZ7ut5U8vV8kdxLoG9SuYvw0ypjzGU7U05xh3P300CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiYmM+yRD5pibwFwB05Kg9xx7EowVELuyHmVrM5hSjM=;
 b=Bk8nBfx4eaE2R3mpVv0JT7RfdGPxLNfte0VlWFtmQ2dwXIRZD9FFr5f1DjbqCg1epobXg2jx8dP7tcEZqBlN9nAwl1dLVHMv1T5GjZKNXrph0rDHBG4i8PgawNehStlEBHZjnR3wn6pFYqufYoAipWzyE1fi3jXwNoMDPAI3S8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7786.namprd12.prod.outlook.com (2603:10b6:806:349::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 10:56:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Thu, 8 May 2025
 10:56:16 +0000
Message-ID: <fa7a29a3-7b02-4eb9-97d6-b1e1a07117fa@amd.com>
Date: Thu, 8 May 2025 12:56:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] drm/amdgpu: update XGMI info on resume
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Samuel Zhang <guoqing.zhang@amd.com>, 
 amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Alexander.Deucher@amd.com,
 Owen.Zhang2@amd.com, Qing.Ma@amd.com, Jiang Liu <gerry@linux.alibaba.com>
References: <20250508050926.228674-1-guoqing.zhang@amd.com>
 <20250508050926.228674-2-guoqing.zhang@amd.com>
 <1aca1130-082e-40df-83fd-eb00fa3ac206@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <1aca1130-082e-40df-83fd-eb00fa3ac206@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: 632bdea4-b3f6-45c9-1f7d-08dd8e1ef488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzhJNGNTTDVNcWZZZWh1c1lKQzVTU1RqWUxCcklTSTFUMnR6SkJZdC9hTWdu?=
 =?utf-8?B?UGZxZUxqdzhrS3VUeVhqT05PWWlyRGNhMWZ2ZE5JOHFGYUZqdEJQajZudmZI?=
 =?utf-8?B?TE53MGt4TzhRUVRyRnhwaFpKV09nWWdsZ1BjVnhZMkxzaDVudVpwdW83Qmd1?=
 =?utf-8?B?MzROZkJnbjBmcS85SjdtUXZBR0gxZnp3TGJYc01qOThXQlI2ZHB0K1l2QkRD?=
 =?utf-8?B?YVlUQXRtcGJyUnl1eTg1Y2xtR3haZnVsQ3NrQXdhdWxjNVkyMjU3cW1aZGM0?=
 =?utf-8?B?dlkyaVVzVVJ6TXdNSEIzVnZRKyt1OXZwUHVxaU5XQWZKVjVZSU9TT25xTG53?=
 =?utf-8?B?YVVQeFQxMWZDZW5HRGg1MHU0OFprNGhMZjFBMWV0bnh4NzcwSlpxc0o0Vkh1?=
 =?utf-8?B?Y2picFB6MWJMd2tJQzRJTFhML0hNSU1Zakl2MkxySTlmbURUYzg2cTYvTjJj?=
 =?utf-8?B?M01NVGFlZVhlS3htQXhIRmkxdkZueEpQTFNIbkxXUFNBeFdwS1pHc2lMcjdn?=
 =?utf-8?B?SjAvT2Z1VGVzY1paWUZHUlpZMW9ZUU5Cc1dKMmFmNmdNTUpMbzFYMlpBWjVm?=
 =?utf-8?B?THFrZ3dSYXY1TFRwV200Z2p4Y3p6NHZrR0NsM0V6Z3R5Z0pPaDQzcjZac3VT?=
 =?utf-8?B?WGRIUjF4K1IyNTg5dmYrbExpWVhsZVJPdUNjYUE5NnBnWXRmZ25mUXo1aEht?=
 =?utf-8?B?SzRYREN4ZzNrSzdHaW9VcHFwVDZGWWRTU0V0RjVKRjZzUnQ2bG5yUnZMOVV6?=
 =?utf-8?B?cHI2S1hFaXkxNm02ZzJCTzhTV25lNThHbFJ0d2s3TWpqL2UwNmNvV1BKRWp0?=
 =?utf-8?B?VGVmS0pqMU4rSVcyWjQ4MzdkaWFjSDEwbnFuS1JQKzBJQUM4blZyV2VTd2pw?=
 =?utf-8?B?WllQcUVVVWdMdTQxY0ZlM2hVMlcvM2MrUHBmTW4zY0c2NXh0NHpoQ004KzJU?=
 =?utf-8?B?cW1rY0ZDSGgyTmQrbUhqSFFvS2N6KzRGUlV0enY2WjQrOGw2dkg0Qm9rSGJ2?=
 =?utf-8?B?OVlCaXZGWG1HTkttUmRvejlrOVVGWW0yQnhrVDJjbWcwYi9lOGQzVjRGWFRj?=
 =?utf-8?B?aHozeTMrMTNJUjVPcGlTc3pONGhoYU9uaG1uYkp2bTdNRVU0UTNGc2Q3ODFS?=
 =?utf-8?B?clZNVFZzVlJud3Q3R2tHN0lwQkNEdjVHL3k0Z0xUZGR6Q0g1NkJuYWxtRUtQ?=
 =?utf-8?B?VUZuMHp5WEsvczArUm9kYjdUQmxNM0ZNdytYbmwzWDZEakU5QU1FWk5LT0FB?=
 =?utf-8?B?TGJESXlVYTZxYXRZdUNPSVFDcVZJb3RVOFA4VG5JYTZYL096MEJCYk1OUExv?=
 =?utf-8?B?ZGxMdWdXSkcxTFdXd0xiZGZ6MlRtTjJDSlNBcFY0ME5qTW5SbWNuSlM2S1Qy?=
 =?utf-8?B?VzUzR1QvQTZMTlFXbGdFcDNKQWJTeGhEbm9lM1NzZXp5SU5sd2hVSjhtZUpk?=
 =?utf-8?B?ZU5DVXFKTVlFVDdiaURUNGFPMG5qRUFKYmsvQk5kdVo0MUNpZlZOYUhGNXpN?=
 =?utf-8?B?dFQyQjIwTkZiS1RSMjdzeFd5WkZVV1BaT1kxcEJtVHEwWUVPWTZaL28wQXN6?=
 =?utf-8?B?U0hoMXFTOTNuWDZZY1FOa0JuUWdyNFViVlVPdWR1TU1WK3BiRTlLS3hCUU5Y?=
 =?utf-8?B?aTBRcVBSSWZuS3BZRVhRMjdvSElqTXBNL2VmYWJrT0JXNnNHSEJLRnBkV1M3?=
 =?utf-8?B?cmpWVGI0WlRNOW83R3ZxZ0dWMXRWMkRYWkVIZkhQNE1lVm9uMDZtV0U1RlBL?=
 =?utf-8?B?SGFWSDl4LzMrOGNrYWZXSnNFUlRvSUNoU2lCeG9MdzZOcFdhaGpHMGpZT09u?=
 =?utf-8?B?a0VWd29hY0hCVlF1TmJKSUlscm5iTzg4OFRrWWRYQkcvc3RkRE9UNWRWaEE2?=
 =?utf-8?B?TGdMQ2NwSmxMT2U2SGx4TStHQWthYlZ6cDR6Z1cxbG96dUw3V0lZbVhqazU3?=
 =?utf-8?Q?8AlYh0iXras=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEsyR0tveFdoWThLNk5qcC9qSWg1NEY5ekhFZDJkSWV6V2pYSHNYKzdCTjMr?=
 =?utf-8?B?MTVzOWtRTnM4a0FQd0E2bWRibjFsaXJNMlQ0VDh5Q0cvQUxVNk9kcndoSWEz?=
 =?utf-8?B?aW8xRGNnd2l2UkNGWjkrTmlFd3RDYTdPZEtQL0p1RmJxYWxObTdNaFBYakIy?=
 =?utf-8?B?K3Fnb05ESUVCMVVHRFVZQ09PSmlXZ3VsVTRabWNLK0VzYXh6SHFROTI1UDYw?=
 =?utf-8?B?Wm1nZzZkTVQ0T2pna0lrTGV2RCtqUmUyRXJiWEZYeUtKL0xjWEF3YkdHMFU5?=
 =?utf-8?B?R3hOcXUvNFhJUmM1T2hyZWtFU3I3d1JkSnJaQ0FXYno3QVkyNUtYK1FLaGZH?=
 =?utf-8?B?VmdOK2NQTzc5TGRvZ1krb2lmUmdVS3BDbU9wSCtFTm81MmNTSGEyVngyTGd2?=
 =?utf-8?B?bklBczJtS0pWZnRSUWtnUEdRVG9sN2ZqWlI1OFAvMVZLZjdta2UyZ0hWcEZB?=
 =?utf-8?B?VGtPM3lIb2czblYwWENXakt2NXlmSjM0R08rNHg2NU9UVFAzRENNS3JCVFFN?=
 =?utf-8?B?NlRCSU5HSEVOMXBQTWpSdW8xQ0NKZFpEVHRpU0xIdDZwaUtlTHRWMG4wdDZX?=
 =?utf-8?B?bEp0SFJ4dmg2R3FjWk1KQ1doVWxQVGRPK2NqRFJKdDBrejh1TzRWbXRSaFRq?=
 =?utf-8?B?akV0SDlFcjBKV0JFcWJES0oranZvN2J3N0dmRStueEV1Y3ZWYkhXQzZySlBH?=
 =?utf-8?B?MTNCTGo0eGtXRU1MYzNkbjlYeUVGVU1YODhmdnZlK2ZwS29SSG8rY2xNa0VV?=
 =?utf-8?B?YWdMbVMwWFo3QjJIMlVSZmNNaFJKaHVOTWlUQ2NhYVdhc0NrWVNSaFVQUlpK?=
 =?utf-8?B?Rjc4M2ZqaVV4RkxmWXhUZ3lTL1ZGbkhUVmladXNnbXNFYnl0QlYrdTJ4WnJM?=
 =?utf-8?B?aUJDZW84K3ZsOW5EZUJQY3UybmFDRkpCV2xDWWlMN2Vlak5VMTVHNFB2emQ0?=
 =?utf-8?B?OU9jQlBqenRPYTRIS3hsRXBTQ2RxYng4SENtK1hwU1JPS1JnM1VtOUlIL1hJ?=
 =?utf-8?B?dVhNLzdaT29DY0VRWXh1WmdUUmw5eVF0NUJ1OUZKRjdIWkd0N250VFBPbnNO?=
 =?utf-8?B?dk4yM01heFpraFRwOWY3WG1MbHJ5ay9na2EzM2ZHK0krOElWcDhKM1hQNWdp?=
 =?utf-8?B?T0oxWWlLMFQ2N0pLb0c5OVJNYXZWdThzb1FRWTFRT014czZlN2xCVDdHZGNX?=
 =?utf-8?B?TTdocHVmYWxvL3I3amkrRkxnSnVjSTdZZVBBSlNJUXVCOU5UdDN5QmlKamVs?=
 =?utf-8?B?UjJBclQzdHo1bW42a29vTDRDNENPWWVHQ21OdmlwbGU3SmxWQnUrT0ZiaUZm?=
 =?utf-8?B?T21jM2gyMHh3N3RIdWc0aHVXUTRlaE5HQ1I3VWY3b1E5NHZwVjVHZnZnNEdH?=
 =?utf-8?B?NkNsRlByaTlVMWNJU0k1YTZQU2tlWUJyaGlBVmJOczhWWGJIYnFLTWltVURk?=
 =?utf-8?B?aXlKT3VBSkp0THVvREtFcjJFbTAyTy9wWTQyb1dka1E3c1ROM21aMlVOa1k2?=
 =?utf-8?B?bU5KT3RzUmdWRmlWb21qL2tteUZCRkpMQk1pZlR2NVllYWNWaFprUlI0S2V0?=
 =?utf-8?B?by9mQjI2bzE3Tld6SEN1dW1xOVVqTUpUU3doZS9wK3lYZ1A5SDIvc1FEMG5L?=
 =?utf-8?B?ajBoK1Qrekh6NVRSZVdYdDhCTk5udERxbEhCd1E3NHowSG85K1pzOFVJOXV2?=
 =?utf-8?B?b1V2Vm5JQWJVSi9HdDJSWk1KTUk2QXFNcjJwUDNIMTREcE9LclVDQnVlc2RX?=
 =?utf-8?B?NVNGV3dEaXlQaVBrbndLZFYrYnl0ZDRld1pXUmF4V3VobitxRjVHNTRVd203?=
 =?utf-8?B?Qjg5YnhaMGd3WWlwVnYxaVg2dVpyVVpDMlJneFRVam1KbUw3aCtoeFlOcy9T?=
 =?utf-8?B?ZkltNzNna2dWdkIxNlhHMTlpR2Jtc2dSMVJXelRmZzJPOHhFTmJYR1JLbHUy?=
 =?utf-8?B?VjlLVm1UTnpvNlBiTmVTTjJkS2FxRHBnZ3NTMzA3MzhFcEUwZHlkVXdsN0FJ?=
 =?utf-8?B?VWpWNFFtRUgvM3Z6cThEMlI5Y3oyU0lBR1NwNllBWUx0Skc4U1lVcFFPZTdv?=
 =?utf-8?B?YVlhWk4yMTVRYkgyQ1pPbkJQM0R3blpkNWtZYjc0MUM1b1JJVFpLTGRjVWNa?=
 =?utf-8?Q?WQNokORpBH0gfv9Je04957WeO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 632bdea4-b3f6-45c9-1f7d-08dd8e1ef488
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 10:56:16.1783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVaEenFxQuujvmr2mQ+ULD/UxVACjLKhar8IVcljJzhm03XtSg9CNB+tG7u5UxH7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7786
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

On 5/8/25 10:12, Lazar, Lijo wrote:
> 
> 
> On 5/8/2025 10:39 AM, Samuel Zhang wrote:
>> For virtual machine with vGPUs in SRIOV single device mode and XGMI
>> is enabled, XGMI physical node ids may change when waking up from
>> hiberation with different vGPU devices. So update XGMI info on resume.
>>
>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  4 ++++
>>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  6 ++++++
>>  3 files changed, 34 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index d477a901af84..843a3b0a9a07 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4478,6 +4478,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>  		r = adev->gfxhub.funcs->get_xgmi_info(adev);
>>  		if (r)
>>  			return r;
>> +		adev->gmc.xgmi.prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
>>  	}
>>  
>>  	/* enable PCIE atomic ops */
>> @@ -5040,6 +5041,26 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>>  	return 0;
>>  }
>>  
>> +static int amdgpu_device_update_xgmi_info(struct amdgpu_device *adev)
>> +{
>> +	int r;
>> +
>> +	/* Get xgmi info again for sriov to detect device changes */
>> +	if (amdgpu_sriov_vf(adev) &&
>> +	    !(adev->flags & AMD_IS_APU) &&
>> +	    adev->gmc.xgmi.supported &&
>> +	    !adev->gmc.xgmi.connected_to_cpu) {
>> +		adev->gmc.xgmi.prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
>> +		r = adev->gfxhub.funcs->get_xgmi_info(adev);
>> +		if (r)
>> +			return r;
>> +
>> +		dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
>> +			adev->gmc.xgmi.prev_physical_node_id, adev->gmc.xgmi.physical_node_id);
>> +	}
>> +	return 0;
>> +}
>> +
>>  /**
>>   * amdgpu_device_resume - initiate device resume
>>   *
>> @@ -5059,6 +5080,9 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
>>  		r = amdgpu_virt_request_full_gpu(adev, true);
>>  		if (r)
>>  			return r;
>> +		r = amdgpu_device_update_xgmi_info(adev);
>> +		if (r)
>> +			return r;
>>  	}
>>  
>>  	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>> index 32dabba4062f..1387901576f1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>> @@ -89,6 +89,7 @@ struct amdgpu_xgmi {
>>  	u64 node_segment_size;
>>  	/* physical node (0-3) */
>>  	unsigned physical_node_id;
>> +	unsigned prev_physical_node_id;
>>  	/* number of nodes (0-4) */
>>  	unsigned num_physical_nodes;
>>  	/* gpu list in the same hive */
>> @@ -101,6 +102,9 @@ struct amdgpu_xgmi {
>>  	uint8_t max_width;
>>  };
>>  
>> +#define amdgpu_xmgi_is_node_changed(adev) \
> 
> Typo - xgmi
> 
>> +	(adev->gmc.xgmi.prev_physical_node_id != adev->gmc.xgmi.physical_node_id)
> 
> Since prev_physical_node_id is updated only for VF, the check should be
> there here as well.
> 
> Otherwise, you may have something like below in
> amdgpu_device_update_xgmi_info()
> 
> amdgpu_xgmi.node_changed = false;
> if (check_condition) {
> 	prev_node = adev->gmc.xgmi.physical_node_id;
> 	adev->gfxhub.funcs->get_xgmi_info(adev)
> 	amdgpu_xgmi.node_changed = (prev_node != adev->gmc.xgmi.physical_node_id);
> }
> 
> To make it clearer -
> 
> Would still prefer to wrap under amdgpu_virt_migration_xyz() to make it
> clear that this is done for node migration.


Yeah, that is a rather good idea as well.

And we should *always* execute that and not just when the physical node id changes.

Otherwise we won't always test the code path and potentially break it at some point.

Regards,
Christian.

> 
> Ex:
> 
> bool amdgpu_virt_migration_detected()
> {
> 	return amdgpu_xgmi.node_changed; // And any other combination checks
> which could up in future.
> }
> 
> The check needs to be done for any further changes down the series like
> 
> if (amdgpu_virt_migration_detected())
> 	psp_update_gpu_addresses();
> 
> Thanks,
> Lijo
> 
>> +
>>  struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev);
>>  void amdgpu_put_xgmi_hive(struct amdgpu_hive_info *hive);
>>  int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_device *adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 59385da80185..7c0ca2721eb3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -2533,6 +2533,12 @@ static int gmc_v9_0_resume(struct amdgpu_ip_block *ip_block)
>>  	struct amdgpu_device *adev = ip_block->adev;
>>  	int r;
>>  
>> +	if (amdgpu_xmgi_is_node_changed(adev)) {
>> +		adev->vm_manager.vram_base_offset = adev->gfxhub.funcs->get_mc_fb_offset(adev);
>> +		adev->vm_manager.vram_base_offset +=
>> +			adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
>> +	}
>> +
>>  	/* If a reset is done for NPS mode switch, read the memory range
>>  	 * information again.
>>  	 */
> 

