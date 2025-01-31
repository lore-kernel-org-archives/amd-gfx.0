Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAB7C0218F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 17:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8529B10E1F0;
	Fri, 31 Jan 2025 17:40:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FnaYAU3s";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91CE510E1F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 17:40:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHwxbaTsJ10s27QI+IypRGW3fWnMsM9M3eLnoH9Hd+fwndPrfrWjJfH3SPsKz+HkwZxhcFBU7B5HiVk/tdZbe3tDdo0fbzM63ug3VVDevOpMuo/rN1NEc+yvkGoEGbhKB0FPRdOGdG+dPdDgNurB7iRoSN9v1QfAlskO7DS52OxgrfTjUdNOJMh2ZsJosRWM0n9qpDXAx04z8FbMnLUIUS+VfqdEoe19VIUwEc4/3w/K80rZXJ/f/sguZrvCn/Fre8JT3LwiReFZN+GNN/jwz4ei5LPRRspauLZH3mk0W0QhLyq5obfVl2CJy2MGy51GI4Vh5v5/AWPXTUJ9G6J9mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEAl89bPSJsNvLWHILlVjGXdXvMQIQggq7jRnQix9xk=;
 b=G0SB4IAqMmd+GD01KvIVy9MX/wURloKPVjgx9gwsH3/GVEJuszsrapuEI8ABh3wuuW14DZlHVy1bkH6TzfmmO+2Nm88rWN2N11OhsZOaQsiWA8MH+3l6yVP7SjNBEiHZZRPtNd2vqcEpnswYqPgkwJTQNOrz087xwjWDCc0nNh8EhgMn2pFbTsl0nOXoQG3Ua2yFptaLX4SwsouFBr8xDDvnLqgjikijBhWMa+T7Ve3l3KyZC70qmGzC/tyUdWW+Dny79i/vOcNEfx/HwYXLztcrfhAnGxO2rmV3/NG1QPouXV1bLKMRuRxLm6MgoSeqYw119n5CwI9svVHvDvIMlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEAl89bPSJsNvLWHILlVjGXdXvMQIQggq7jRnQix9xk=;
 b=FnaYAU3sJbKdCixg7ocbjJZYZHvKqxUVQtsp65oTmgz4DJZ3OmIXITI78cvRG4b7gDj1rkD/9NAAVz/o1GuVsJUKuues5TwnomN5NHOMqEa018d//xcjyBcZwOTqM8NCqrw9od0V6kmqe+lBRNxR+TKztwf3O+IXuv1gJi73rDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 17:40:41 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%6]) with mapi id 15.20.8398.020; Fri, 31 Jan 2025
 17:40:38 +0000
Message-ID: <20ca1b73-f6c2-46d1-881d-b1163ebd2a75@amd.com>
Date: Fri, 31 Jan 2025 23:10:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] drm/amdgpu: Add ring reset callback for JPEG4_0_3
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>
References: <20250131162321.563314-1-sathishkumar.sundararaju@amd.com>
 <20250131162321.563314-3-sathishkumar.sundararaju@amd.com>
 <8371968e-e270-490e-9454-b521edceef37@amd.com>
 <8b9995da-269c-4a96-b374-09e40e0df605@amd.com>
 <8a8f4581-0185-4180-89e6-aa4d01260cae@amd.com>
 <d4bcf2db-bd16-4282-b086-27969225f27c@amd.com>
 <fb4969e5-90ab-425d-a43d-f78002dd805e@amd.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <fb4969e5-90ab-425d-a43d-f78002dd805e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0188.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::20) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4675fc-4f7d-4265-d996-08dd421e5fb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0tIckdWaWtjQUdEbG9oc0pGbkRIYjgrV0c0ZFZEalpBSWRhNkNTRmp3Y2RG?=
 =?utf-8?B?S3E3UmZ0NGQvcWdWUU1PVFUvNVp1Q1NhWGNYUFVNT0k3TVB6L1JJNitqME1s?=
 =?utf-8?B?NlFxVDZxMDZpWUpURGpKRmZ6SWxiZm14U3EvQzY0dm5pWnlaSk9VYUdlWHFC?=
 =?utf-8?B?VElwSjIxbzJpQkR3aWUxbmdzUUh2RUdqZ0RBZTFXYTJmTEsvTnhsbVUwZXRw?=
 =?utf-8?B?V1ZsbHpweCtQMVpKUC9mc01jOWJZc3RobU1DMjAvZVdHTGlzckFPVm5SdU9x?=
 =?utf-8?B?Y2tMRERxU0ZwR21XSGdONVBLYjJSRGExVmJlN2V2aU05SDBML1hjQU96RlI3?=
 =?utf-8?B?UnFjdjR2Z2svemovMzVsckFCTnh0WlcxTmhEeVVycVRXM0kwZ2hvcFAxU2R0?=
 =?utf-8?B?YitySDZuYzU3ZkhCdzBJZmplMWxMTGppQ2pSRHVZZTdwOFNla0NzcXMvdUxQ?=
 =?utf-8?B?bkN4TGFCMFh4eXVDQ1o0K1pDU2YwZ1VsLzZxcW5LZzNTcVYrdWx1SFAwd2xR?=
 =?utf-8?B?YnI4a0VlcHlzMlBrT2VoL0xGQTJIc0lLZ2t3TUY1THhuY0w3UEUxOS9DYmcy?=
 =?utf-8?B?ZG01NWVoaWMwaHZuT1Nvd20vV0dOdkQvMmRtZXl5ZFpWVUorZktBOW9PZ0gv?=
 =?utf-8?B?d01xTis0S0kwNUJ5RVRBQlJtbC8vUE5GN0FpeTZULzZYdW9hTHNQWElRcytU?=
 =?utf-8?B?amNOQTd5c2w0Uy94M3RrK0g1bDBpdjhJTk9VWUNZa3dTTWlxWXUvQkZrd0tw?=
 =?utf-8?B?SWh0UUEvWklUemFCY3F2cTJXbklybjRuMHRUajNMdFpzbVA1V21ONnhoRk55?=
 =?utf-8?B?Y3NDNnBEeGpNWnRLWXljTjJRUGw5MndGWnBwbURFVllZcDk0UGYrNVNaNEZM?=
 =?utf-8?B?NkZUWEpUWU5YRWlNYzBNU1FmdW9sMjJjVUU2UG52TWlnZlozMlUzWTJ5VWhD?=
 =?utf-8?B?VVQ4VEI0SVRaQXlMQjg5R0VtZVpGU3F4OEhoY3FnSmZPYkIwdEpBVnJtT2ZZ?=
 =?utf-8?B?Z3g0V3FVSWxjU2lwY3NyTkw3aTROTVRvRUJWVjlqUEo2MVJ2N0QyREtqRElu?=
 =?utf-8?B?Z1JqY09vMDlRcDJwR0RDQWNmTVhqbURPcW1zcmcxU0U2V015c1BQT2VnYnNv?=
 =?utf-8?B?VmhNMWVrTkU4U0pXUW1ZeVg5V1hxQnUzbkxMa20weHU0MFZTZHJTQkZRTk9E?=
 =?utf-8?B?SnZmd05XZDIyVDlCRUUzM1pDb2NzT0UzQmtLZzcwWUU1RE1ScnhqampnUWJN?=
 =?utf-8?B?RUlMM2ZDL0pPV1ZISVlVTVJ0ci80V2VRdHRPcklhUDVlaDFPRldBNDlKM3hS?=
 =?utf-8?B?NHVvL1lpREVOb3lReEJodmlZN3lNdHJzNkxIOHROWW9obDVZYWpUdnRZMlhv?=
 =?utf-8?B?dU5nZ09aZmo5alJzNlUrM3owZHFzQ3JzaEVrbmF6NDFUTTJ1QVhsQVZ1eWhq?=
 =?utf-8?B?U1pmaUIxYktDKy9FQWE2ek9mYldoK3UwbTFRbkJxeWJRbE4wWFhDTDFCaXNE?=
 =?utf-8?B?T3YxaWRGZjEvakpuL2grNHkrVW55M3NWaTkwVWh0NERhbFAvcE03L0VZamZa?=
 =?utf-8?B?MzM3dVJBMndDUmNRSUU3Qkp5eWpWR0hwRlorYWlCdEFzTnNKYkFjUThJbS9q?=
 =?utf-8?B?cHg1Zm4wTEdTR2Q5UllwOUpBaHJPVUJMd2NzVjhTSzdid2NlV29HbzlpOEZ3?=
 =?utf-8?B?dXRwdjRJMENoN3lENVNIZUIySDFVREJHWmhCcnFVZDJOU3pPRGFUcUVWWW9I?=
 =?utf-8?B?VHJWRGJjZzVZUVNYTWw5NEVMekJRUjMvaEpwem55RnJSUUU4Q3RrWm5NcDIz?=
 =?utf-8?B?TlVZUnh3aGdxUnBVblZOZ1A1WndGUUF1WEZWU0JLaGhRaktyME1MOGxmYzZR?=
 =?utf-8?Q?hBVF1CtOiWGrx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTRiUlh6OUR6Ylhud04zRE9Cd1JGbjkzU0hXZG1vTXBHdExlM3ZPYkx3eFFk?=
 =?utf-8?B?SlorZTZaaGIyUlBURFVuZkZQbldSVEVQcVc0NExJa1c5WUdGd0dDMUZoRVFQ?=
 =?utf-8?B?T3RLY0I2OGtkckRCZTNDQWJVZ0hPbnVmRVpiNmVHZU96dFdBUVMvTGQzbGR3?=
 =?utf-8?B?bTlvdXh4Q2l2cnF2MjNzVmMxTHFORWUrb0tyRGp0a1RhanhKODZJZGZpelNp?=
 =?utf-8?B?T2U4cE5PcFlNditpeUNJdXdqV1F5MC96SXdWekxnVWQwNmhEZUx0bDNuNUlB?=
 =?utf-8?B?V3J4NVJQSWkzNFlSaWlGYmhETU92V0VGSjFocDlxSTh5Tld4ekpvc2FMY1Yy?=
 =?utf-8?B?TFBFcWwxU3JKOTZFZkxoODkrMEhIRUFJdGxqWTdQVTVHaTRnV1l2THpFNGNG?=
 =?utf-8?B?M01uUFVLNTB4aFZGR3RlOGpCUXhYZVFhcW8wMFZPRlBKREl2N1dMeElDSXBB?=
 =?utf-8?B?Qy8weTBSVHh1TUlrMHJRMFJSdFRoWHJsaEUreUNaQWpwSFRLOCs2Vm1pVWJY?=
 =?utf-8?B?R2doaHQ4bHErNS9DMmNiYXVvMVJkdzdaem9lT0kwTU8ybVR2c3ZrMTNXNlZW?=
 =?utf-8?B?a0FTdVVwbEZWZEwwdVhCRWtyWGlSejJFZWt4TVhBWTE5VzJnQWRiNXlBYzVo?=
 =?utf-8?B?UjRGd3NFMTFHNGJNa0NIM0xWdDNaejhqK2NUNUhNa05iQUhzSjA0TjN2Rlll?=
 =?utf-8?B?VTZkb3lVWHQybWY5RE1nWFpXalBWL204Qno2MXlvUnhXUTgrQjRzSTVmZTR0?=
 =?utf-8?B?cEtJZXd3YnVTdFhqbXdPK25ja0xrYmM0V1BYeWphM2U5ZThrUUhNUjR5SElN?=
 =?utf-8?B?MW1DTk1CcXVHL2ltbjhqK2tSMGg5RmcrbnI5cEZjcEw3Z3AvdkdYcHlRTmFD?=
 =?utf-8?B?am9jVDR2bGJwOG5hQUJTVDNxdWNpb2hvbzNRcWdzdlBqN0NQeFgxb2RQbk1t?=
 =?utf-8?B?cUNvU24rU3p0RWNJcDdVWlJzZG1KaEZYZXZtd2J3dDgzS1BUQ0JMMWpXU0R1?=
 =?utf-8?B?aStac3JWc2dOMXhkc0x6d0Fsei84aTg3U0g4cEswdlZHNnB1eUZENFhFM0pU?=
 =?utf-8?B?M1ZodUQ0RjB1RmxuT1RjaUxTRTNvU2E0Q0FpKzBwM1FYUlhEaXRlRTd3OHRy?=
 =?utf-8?B?RTZRZ3RjWnRJMS9EclRiSXkwUVU4V3NZLzNPdW1rWEdSSFhMekhJRHByeEd1?=
 =?utf-8?B?eUhHTDVKdVRCKzdyUjZrbkhlRkpJN3l0ejJCYVBIVWROaFpIc2ZHN2Izck42?=
 =?utf-8?B?MnZTSU9kYlZyc0VoRDZnME1OSDIxQmZPNjhCZGxTTzJUcUE2UkNvQStPNGQ4?=
 =?utf-8?B?M2I5OEU0d2Y2anVQVTRObXVGV20wK0gzKzYxMW0rdjlCMzhUNnBvbE90bU5y?=
 =?utf-8?B?b1pvZGtBRkhGSzRxY0lDZFN3UXVCNGszUzFmNSszL0RWdGJvUjY2LzRXWWJt?=
 =?utf-8?B?dWpKVVVlcC9mSGpEZkpHamQyNURYdEFOVzhRdjc2T1pmN0ZPL2FkWnptUjVD?=
 =?utf-8?B?MHE4UU4rWi9HdU1LNVFHYk9PdFZ5S2l0dDdvRGl0djVJdWNZa09QWEpUTVFX?=
 =?utf-8?B?OWg2YVJvczBFL2x4cnVXRVpzTG1lVUx6TmhLYUpMcHc1Mjg5T2RsalRxSkk1?=
 =?utf-8?B?T2hTaWgxNFhmWEJrMUlSMFVVQ3ZZa1V5V1dKV1pqWTlrVm1ZTytGeGlteDlG?=
 =?utf-8?B?OG81czc4YzZ6cG5kVTl5bWhUUlQrNjJ6aGhCZ2xGRHJpYXZqNFNUbDNSU3gr?=
 =?utf-8?B?aCtzeWhGRFRpUXo1SzloYW41M29sVFRabHlTTm9QUUNlYm14NHhNL2VYSWYw?=
 =?utf-8?B?bjltNEI5eThONzNtOENZRU1RRnMxU3l4OVpCcXVjd2o4NXRHTnNFWkdBRFVa?=
 =?utf-8?B?aWNvNHQzTkZuR0twN3NZVm5xWnhwSWpQT3pTclErNXFYdFA0UXVsT2l4aHVt?=
 =?utf-8?B?RmpPWWZnQ0tvZE56cDgxMVFhcUxwZ2pwYnpoeWkvbnN5MkNDdUY5bzBSTnZS?=
 =?utf-8?B?dUxkTy9UOW9VcjlURWphRmozV2xVdWpEYTFUU01HZDBxK3QwNEZOUDNMdzhS?=
 =?utf-8?B?c1hOS0NyaUJITVNCWGNLaUlDZnhLd2xUNmh6RHlZeVdzaGpQOEtoelVGT3I5?=
 =?utf-8?Q?pYNA/JhN7j5y4WT1ikxEAYknf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4675fc-4f7d-4265-d996-08dd421e5fb4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 17:40:38.1988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jHEpW7M3X25Ahsqgc10q/3bSSH6I2DsByEU6KXlmdn1kOZR6ofRd3IFBxScNzLRJKTUZ9cKghnoWRh8+bYGVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625
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




On 1/31/2025 10:35 PM, Christian König wrote:
> Am 31.01.25 um 17:55 schrieb Sundararaju, Sathishkumar:
>> On 1/31/2025 10:19 PM, Christian König wrote:
>>> Am 31.01.25 um 17:40 schrieb Sundararaju, Sathishkumar:
>>>> Hi Christian,
>>>>
>>>>
>>>> On 1/31/2025 9:56 PM, Christian König wrote:
>>>>> Am 31.01.25 um 17:23 schrieb Sathishkumar S:
>>>>>> Add ring reset function callback for JPEG4_0_3 to
>>>>>> recover from job timeouts without a full gpu reset.
>>>>>>
>>>>>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 60 
>>>>>> ++++++++++++++++++++++--
>>>>>>   1 file changed, 57 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>>>>> index be0b3b4c8690..62d8628dccc5 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>>>>> @@ -204,9 +204,7 @@ static int jpeg_v4_0_3_sw_init(struct 
>>>>>> amdgpu_ip_block *ip_block)
>>>>>>       if (r)
>>>>>>           return r;
>>>>>>   -    /* TODO: Add queue reset mask when FW fully supports it */
>>>>>> -    adev->jpeg.supported_reset =
>>>>>> - amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
>>>>>> +    adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_PIPE;
>>>>>>       r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>>>>>>       if (r)
>>>>>>           return r;
>>>>>> @@ -231,6 +229,7 @@ static int jpeg_v4_0_3_sw_fini(struct 
>>>>>> amdgpu_ip_block *ip_block)
>>>>>>           return r;
>>>>>>         amdgpu_jpeg_sysfs_reset_mask_fini(adev);
>>>>>> +
>>>>>>       r = amdgpu_jpeg_sw_fini(adev);
>>>>>>         return r;
>>>>>> @@ -1099,6 +1098,60 @@ static int 
>>>>>> jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
>>>>>>       return 0;
>>>>>>   }
>>>>>>   +static int jpeg_v4_0_3_wait_for_idle_on_inst(struct 
>>>>>> amdgpu_ring *ring)
>>>>>> +{
>>>>>> +    struct amdgpu_device *adev = ring->adev;
>>>>>> +    struct amdgpu_ring *r;
>>>>>> +    int ret, j;
>>>>>> +
>>>>>> +    for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>>>>>> +        r = &adev->jpeg.inst[ring->me].ring_dec[j];
>>>>>> +        r->sched.ready = false;
>>>>>> +    }
>>>>>> +    /* publish update */
>>>>>> +    smp_rmb();
>>>>>
>>>>> Using smp_rmb() to publish the update is 100% incorrect.
>>>>>
>>>>> What exactly are you trying to do?
>>>> On JPEG4_0_3, there are possibly multiple contexts submitting jobs 
>>>> to all cores on the affected instance,
>>>> so I am changing sched_ready to false and using smp_rmb() to 
>>>> publish to other cores which are trying to
>>>> submit on this instance , for them to read the updated change 
>>>> immediately and stop submission before
>>>> I wait for idle on this instance, which makes sure other good 
>>>> contexts of jpeg get a chance to be migrated
>>>> out to any available instance before reset starts, that way good 
>>>> jpeg contexts get a chance to continue
>>>> without issues while this instance is being reset and made ready to 
>>>> continue decoding after reset.
>>>
>>> Ok, completely NAK to this approach!
>>>
>>> First of all setting r->sched.ready to false is a completely no-go. 
>>> I can't remember how often I had to remove that nonsense.
>>>
>>> With the exception of the KIQ the back-ends should *never* touch 
>>> that stuff!
>>>
>>> Then the Linux kernel requires that ever use of smp_rmb() requires 
>>> to document the matching write memory barrier.
>>>
>>> Over all please completely remove that code all together. The wait 
>>> for idle function is *only* supposed to wait for the HW to become 
>>> idle and nothing else.
>>
>> Okay Christian, Thank you for explaining , I will remove this.
>
> Thanks! I just have one question: Why do you got the impression that 
> you need to do this?
It was to migrate the good jpeg contexts out to other instances 
unaffected while the reset happens on the current, probably because of 
amdgpu_fence_driver_force_completion()
all contexts on this instance are lost (there can be 7 other functional 
rings on any instance on JPEG4_0_3) , it was to protect the good 
vaapi_ctx workloads like training
data or even another ffmpeg mjpeg decode running in parallel to be 
unaffected and continue running on other available instances while reset 
is in progress, affecting only the bad job.
without this wait_for_idle on the instance can timeout eventually, that 
was the reason for me to go this way.
>
> The problem here is that the higher level takes care of stopping 
> submissions and when the backends starts to mess with that state 
> (sched.ready for example) it causes tons of problems at other places.
>
> So I had to remove code like this literally between twenty or thirty 
> times already and I really need to find a way to better document that 
> this is the wrong approach to stop people from coding that in the 
> first place.
Oh, my naive understanding around smp_rmb() usage! my apology for that, 
will avoid this and also clean up another instance of this usage that I 
know off, I used it in a debugfs entry, will clean it up as well.
Thank you again for explaining.

Regards,
Sathish
>
> Thanks,
> Christian.
>
>>
>> Regards,
>> Sathish
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Regards,
>>>> Sathish
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>
>>>>>> +    for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>>>>>> +        r = &adev->jpeg.inst[ring->me].ring_dec[j];
>>>>>> +        if (r->pipe == j)
>>>>>> +            continue;
>>>>>> +        ret = SOC15_WAIT_ON_RREG_OFFSET(JPEG, GET_INST(JPEG, 
>>>>>> ring->me),
>>>>>> +                        regUVD_JRBC0_UVD_JRBC_STATUS,
>>>>>> +                        jpeg_v4_0_3_core_reg_offset(j),
>>>>>> + UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
>>>>>> + UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
>>>>>> +        if (ret)
>>>>>> +            return ret;
>>>>>> +    }
>>>>>> +
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, 
>>>>>> unsigned int vmid)
>>>>>> +{
>>>>>> +    struct amdgpu_device *adev = ring->adev;
>>>>>> +    struct amdgpu_ring *r;
>>>>>> +    int ret, j;
>>>>>> +
>>>>>> +    if (amdgpu_sriov_vf(adev))
>>>>>> +        return -EINVAL;
>>>>>> +
>>>>>> +    jpeg_v4_0_3_wait_for_idle_on_inst(ring);
>>>>>> +    jpeg_v4_0_3_stop_inst(ring->adev, ring->me);
>>>>>> +    jpeg_v4_0_3_start_inst(ring->adev, ring->me);
>>>>>> +    for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>>>>>> +        r = &adev->jpeg.inst[ring->me].ring_dec[j];
>>>>>> +        jpeg_v4_0_3_start_jrbc(r);
>>>>>> +        ret = amdgpu_ring_test_helper(r);
>>>>>> +        if (ret)
>>>>>> +            return ret;
>>>>>> +        r->sched.ready = true;
>>>>>> +    }
>>>>>> +    /* publish update */
>>>>>> +    smp_rmb();
>>>>>> +    dev_info(adev->dev, "Reset on %s succeeded\n", 
>>>>>> ring->sched.name);
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>>   static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
>>>>>>       .name = "jpeg_v4_0_3",
>>>>>>       .early_init = jpeg_v4_0_3_early_init,
>>>>>> @@ -1145,6 +1198,7 @@ static const struct amdgpu_ring_funcs 
>>>>>> jpeg_v4_0_3_dec_ring_vm_funcs = {
>>>>>>       .emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
>>>>>>       .emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
>>>>>>       .emit_reg_write_reg_wait = 
>>>>>> amdgpu_ring_emit_reg_write_reg_wait_helper,
>>>>>> +    .reset = jpeg_v4_0_3_ring_reset,
>>>>>>   };
>>>>>>     static void jpeg_v4_0_3_set_dec_ring_funcs(struct 
>>>>>> amdgpu_device *adev)
>>>>>
>>>>
>>>
>>
>

