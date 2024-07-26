Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242C8C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 15:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8AD510E9C4;
	Fri, 26 Jul 2024 15:06:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wZNNzRyw";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8B2D10E9C4
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 15:06:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTsuiH53LdRBhBoVKM3jfzS8HUVB0NDvszff21HO67LehcMkOh9dGMZWcs7x0AjK30qodBimK//QSHvswDBdOqti2G+iXBUG/gKpCunIPSrXKVXsmK7QZpIiGiW2gA2ibP/jAMA+SZK9EY0pvfZzuTmfcClAI9onRJHkNKK1WU7W1bFwLG9HVQqJgPhYKSYwroJizugztBlWFl4L2fzf90KsfjXM/PSu9xrZtC1Apme0gE66Dl7NcynmFm/ugL9fBkOCBQXCEUP9KoXnByyWOqiLBOV5tTsJ3U3h1MiQFwrfR2s7bOaXYjJ2Jk0NWQDS6+xTtzAGFrEk7ZKW03MvOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zx7RKPsDINAQbY8szKH5xSjKffLWjGlO6ONWjfEt4b8=;
 b=ErzP/Cl1Q7qJYSFM4pt7It3i+3M8IW0B1Zk4kPzjuPm/vZImQWjJ7Y680R+P1Ysr2Vcb5TFcSXHiw36HN/Hn8JWaqhwehZI+LuNbYsCU70jQC7DGFPe086eJMXJCzL5Co7BNP1e+L5TOO7gos9SFBGOs/zWlZnf1J4sQNF0UDwY+jF4yHx5ZUApBZq8k25/Eyw2RS8XXwIISrcnqnc7VefLpG4xv2E9/7tfWtfI8G3j+VbX17lsfhrLxmbvkxA/5Ipbrh58DcVsrBeneOfsNVNCWH/E8C/ZlwH0+sk7fMcA6QyoIfls70DcAFv+kfcnoH5kTQIjoNhxzysC7M7Xo4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx7RKPsDINAQbY8szKH5xSjKffLWjGlO6ONWjfEt4b8=;
 b=wZNNzRywlx/SKX2NFNDfpWwnc5ttHg48/h1lW7V49OEwE6wWdJamUNxxeGHTRPwip+gQb96bqgBtZY0/lSMgjUOa+j4oY+22Ef5RreDvLmBS3OWMhgjwCKmYhqcl9Yia+pNMBf0+1pf5Z7uTfxg6q9zWjc3qua0mMikz4gY2yMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.29; Fri, 26 Jul 2024 15:06:54 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 15:06:54 +0000
Message-ID: <77bb2c37-d906-4c76-b87d-effbbe6064e4@amd.com>
Date: Fri, 26 Jul 2024 20:36:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: trigger ip dump before suspend of IP's
To: "Khatri, Sunil" <sukhatri@amd.com>, Alex Deucher <alexdeucher@gmail.com>, 
 Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Liu Leo <Leo.Liu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240726124751.3121312-1-sunil.khatri@amd.com>
 <20240726124751.3121312-2-sunil.khatri@amd.com>
 <CADnq5_NdYiwGGvyVvg3_0aUuH9YLL_kUgNUpjEad8z8E1xWfMQ@mail.gmail.com>
 <57660e1e-1aad-4ba6-be90-abda2b377e3f@amd.com>
 <f967ce91-dd88-4542-8340-1e61813eb780@amd.com>
 <d49c682a-57ea-4061-8b42-59764f603164@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <d49c682a-57ea-4061-8b42-59764f603164@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::34) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN0PR12MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a5baeb-968a-47c7-a506-08dcad8495ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q254anRwZzF0WkVEL296OEZzWHg2ZVZ3aGhyci9qU3c1bDJwUi9jR3FwQVg1?=
 =?utf-8?B?bUkwQW1ZclBCN1VSWkpzRVltaHZHa3FNT28zVFZlOXRidHF1S3ZPdVpRNmlE?=
 =?utf-8?B?clVrSUg2YmJuL1ppQkUrZ3VyelBaSm05d2lHNHh3bmhSbk1WbjVVdkdNbmJ3?=
 =?utf-8?B?Y2lhRERFeXZQT09QZjV0MGNtL2RTVWVwN0NtaGgxZHVtbG9EMmNZbzNjeGVK?=
 =?utf-8?B?VyswbnFzeTJyRFVNVFR0ZXNMZmpwUTlqUURrQ2UzVUZUT3B2M2RCWjFnazVk?=
 =?utf-8?B?OUtlMmVJTWdpKzJVay92V2FITHRyT0gxUkdUd1c0R2tvUk5KNDk0MHFEMWlR?=
 =?utf-8?B?bkYwWis2S2N1eWJoRGpPcWVTdDlGMDh3ZnVCL0t5NEY0dzI3QU5YaUhqVEIy?=
 =?utf-8?B?bTRmdTI1SHV3eG1WYWJlS2pXa1NSemVCV1pxb29WeDZ2NUllMGZoNGo5QnQr?=
 =?utf-8?B?OFFhMUd6TjRsSjYxc29wS1ZOMjVoOWVJd0JpdGlCc2lXZ1ZrNGVJcTFxcWZn?=
 =?utf-8?B?Z3J0NFpTZGd6OEN2U004ZktmK3hZTklVZlNGdUVjMXJZMFlrNHB5UmZWSkt3?=
 =?utf-8?B?eUNXc2lrZFYvVERJbEtjMld3ZmFkaHJLMXRIVjg5SVNvenVmZEtWMGpzTytv?=
 =?utf-8?B?Rkg0N0FQQ0lkOWp5UUpRbUkzelpKZTBqc08vOCtQR0lCZEJTWnIrZU93STBT?=
 =?utf-8?B?LzBlVDl5My9oSENiQ2xCeDB2ZWlUdDYvRUhaYmVzRk1NdlkzRE1pRmlmVU4w?=
 =?utf-8?B?U0kxSmd2MEZlTW5xQVNNaDNCc0JhVGhxd282OStSalkyOUd2bHJOOHg5U3FX?=
 =?utf-8?B?Uy9JYVVTN3BWZDJlem4wclFCcVZyajFjTkpUUlZrb1pOSDhBQlQweENabUpl?=
 =?utf-8?B?am9GeU1hU3RDMHBxZVQwOFVabkh5M0JEWlVCODdvaEk5NDFKNEZIc1ordUh5?=
 =?utf-8?B?aXI3dFZ1UVc5UnM5OWtoQWoxdmdXMUdJdmsxUFBNR1pkMmZCcytzQnN1VVRv?=
 =?utf-8?B?ckxUbW9pS2ZNQlRncGhWYVEzbHlxdUdnVFM5eXZJQ2N0Qjd2Y0cvNkFiY1Zo?=
 =?utf-8?B?SFhSS3ZpbmVUcmVXcjY1ZHZ4bndJREVhdWE1RmtlNHluVHdoZGJVZU52ajJl?=
 =?utf-8?B?am9IRzc0T3RBSWRtemxGY2VBTG5CeG9rTUNxMzFRRTN3Y2VJeGxJcGJjRkxl?=
 =?utf-8?B?OUEzVW1XT0NnZ2ZNZ2NqV0hBbWMzNVRMWVU3OUdnOHBaUzlPOVVsdzBzeXlE?=
 =?utf-8?B?VXdzekxnUVB0WUowT1ZmVlVCRDBxa29CUUNhaUhUU25NckNwSThQam1adnFs?=
 =?utf-8?B?K3QzM01nNEhaWVVZZzU0eUFoQWt6bXpzbkxjSVRVVDdUcDZXelBQNWJHUmJ2?=
 =?utf-8?B?cWtNeGh0MU1WQUFIZm82VHlDS0o3LzBpbDg0VzJvYklNZHRnV3lzWStZQzN3?=
 =?utf-8?B?Y3lGVmFmZUpjeVRuYTlNeWt4MUxVaUtOU2pURHBVbkRJYjBwdDhPWlhkb3pm?=
 =?utf-8?B?dzJyQWszSjhnYVlBMkRha3V3ZWtad2MxdytPeE1KNVNqbmtybEt5UTdmc2ZF?=
 =?utf-8?B?SkozOG9Nd21aWkg3cUVrRHc2aVFQODFIelFKUmtsWFc5VGlqaEtoT2ZHYnV2?=
 =?utf-8?B?QUppMExWekNmb3Y0WGYvaFJnUHBzdUdTZFdmaFpTaWk2Mjg2U0FEQ3BLTTIv?=
 =?utf-8?B?c2tSd1R3RTZUbU10UUVFemxKTXh2OXhtNDdFN21vQnRkLzZ2RmZ2cTg4UzBj?=
 =?utf-8?B?U2VOc2VWUVBiall1cWJjVFFBTEZ3YmxyOGxOQ0N2QWZNVHpTUUh6TEowQ1cz?=
 =?utf-8?B?UUl5Q2xnUkFiREljbjB3QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVBqcUJaUk9EcEs2WFZsanpzeFZIcWY5R1FNbGRsUlRueEpWN3dKMDVrQnNC?=
 =?utf-8?B?WUdCeEVOMVlqaktqeW90d3NDRUwxVHU4NHNjMXBYOXZQY25OeWU3U3lFNitk?=
 =?utf-8?B?TmtSTlNOS0psL3RVNGNsMmxQRTlPcWcvSzRuR1FpYnRMSWRSbWRnS1N1YjZ4?=
 =?utf-8?B?b2FmUFU4UlJSZWViSE93clZJWHo1WU1GQlFodmtINTMvZ3RqYkdhRE5PdHRB?=
 =?utf-8?B?NnRFWTJzVXpqcldXSzZhR2JGWG1DcU1zTXpOSno1VGlWYnBZZEJtR3J6bERu?=
 =?utf-8?B?RFN5bWl3dlR6MnAvK1V2RTVXV09qU0ZqTkVZOTlXRkxObm9zcm1HemZnMU5a?=
 =?utf-8?B?OGJ6Ti9zYlFvcHNSNklxK3lhYXczSklVWlFQYVg0aE04ZGEvYnU3NUIzWFNI?=
 =?utf-8?B?K0FuV0RWSEk3UE8wN1pZTUcxSG9TaGdaMEdPdUZuS1ZBWnhkaC82TUlocFJI?=
 =?utf-8?B?OS9qa1lDRVZKZWVCY0pGaitNRk8wTmM2dWZOc3RyaUcwTUdTTHZsMzZXaFVN?=
 =?utf-8?B?b2hGTnNFL3RKdmkwU2RXM1JaNE1ORG53ZmxmSXRPRXRjYVFqU1JhM0k0WFNz?=
 =?utf-8?B?YkR6MU00aVhJeGZSQTZyMHh3TlpCMXBUTnZ0Y21zelJCdUtHeDR3eThsbUw5?=
 =?utf-8?B?NXN2dm9kYXZKd29oejgrc0JCQW5CdFh6YzN5WXJNNmhQYWZSRkFVTkNSZDNv?=
 =?utf-8?B?Rkt0SStaeUh1TTBjQU54di9tT3JEZDViRzc0Szl2ZlJUTG1jdXdRdnJoY3pN?=
 =?utf-8?B?SE9TcjJ1K256U3BmVTFubDB0MjRjTHFsWHFuVDR6WGpqK0lUbDBYVnBJdTRM?=
 =?utf-8?B?cEJIYkoyWm81Y2JPc21GVGthVUZscmJNM0FQbGVaOEt5TzJja1J5aGt1a010?=
 =?utf-8?B?cVhmdUpBdE9PMUd1bXZhNlMxQloweFhzZGFZK2xHY2RjT1Y4dXQwVmpIWVpF?=
 =?utf-8?B?MWp3bzFmQTQ0MmdLN1k1Qjl0UUQxTDE4TGh1NnhPcThzdEVYNEFQZHdkdHlq?=
 =?utf-8?B?bjJNSUh5MlpNdUovVncyY2F1ck9kd1h1RHIyQW9QNkpOUXZ1eElKVXgwbnBq?=
 =?utf-8?B?T1FRK0xpZnBNc3FEMmFOZWJWVXRoTVR6MG90aDV2TGZIS1Zsa09Ca3g3NExG?=
 =?utf-8?B?WWpuSG12M2NTMjZyZlB5eEsvUyt5ZEp2NkNZYUJ4d3I3Wkc5NVIwQ0NJcWlB?=
 =?utf-8?B?d0RENHZXTnNHbzF0elYxQzdHMmVwUEd1MTFxdlhtRXdpT3hGNDhPUlIrR2Iy?=
 =?utf-8?B?TXhhVzRQSEQ0SzBVNXMvRC9vRm9xblpmbHorM2VueklZb2JRTEtHS1cvSGRh?=
 =?utf-8?B?b0puZ0puVEFPM1ZGZGR5QjBKdXJ2VDdQbUxBVzdPZEp0RHV6RktlRjV0V3Q1?=
 =?utf-8?B?Tzd2cSt0MFRHSnlhL3dyWFF3LzRJaVBTa000eGJScWVjc0JFM2xFM3pQSWc4?=
 =?utf-8?B?aXlXR2FmUWdYMi92QXZ3cDJLL1c0UjZpMitieERRMTBvWjdvVzlwM040Wk52?=
 =?utf-8?B?YU90R29wc292TkYzaEtqL3o5VGt6WWRaN2NVd0IxYTdkMGd5TktwbjY0ZzJx?=
 =?utf-8?B?KzdQYXZjNFBZWGFUSmtFdGNnYW9oS2hFTjlkV2RlMjdUaHc4UFhvQjg5QUd4?=
 =?utf-8?B?RTBxRm9PQ2tnRG9SYlNoM05GdnR1TndHb2FqdVg2ZmhzejB4WUN0ZHJrbTli?=
 =?utf-8?B?VTQ4QzlNbkVUTUFIQmc0ZmtyRjRBTUZlNFVSTUptRVBCOGJPMzZac2g5NTFO?=
 =?utf-8?B?Y2hXa1VYUk43d1lWZ29TWjMweDRscE1pTjZjLzhuTENZYVdlSVZ1SjhPR3VC?=
 =?utf-8?B?cENPWVpNZ1k5aTFHd2Rsd2s2T0RuQVliV1VWZlkyMG5CeDliM2s2WjVJcWFX?=
 =?utf-8?B?QTVja1M3bFFNUmlaSzY4TUpHdit5aGNBMWRNdjF3emwzRjIyaXduWHJYVzc5?=
 =?utf-8?B?YWNXaWx6ZTIxZC9IR1pscytyaTQrR0VVMkgzNmtkOGJNTkp6dHUyNVg5WFZH?=
 =?utf-8?B?TktnaUVzaE0xZGl0ZStUMUtZRzFWejZTMmFtV05ibnI4cVU5WXUybEZBWmRP?=
 =?utf-8?B?MStwbnMwTjZhTjBSeVJRcW9QTUEvZW1sUHB5RDJoZkpnOTlGcmlkaXhXanhQ?=
 =?utf-8?Q?YeEAG1RXRhElXJxj3MKt1QyDN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a5baeb-968a-47c7-a506-08dcad8495ba
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 15:06:54.0508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dckCd2+qru+Y14eynoGoDNdgYr9a+AMCq5Q8wM5eO55JOz42Wm87fBPduLsQZmV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246
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



On 7/26/2024 8:11 PM, Khatri, Sunil wrote:
> 
> On 7/26/2024 7:53 PM, Khatri, Sunil wrote:
>>
>> On 7/26/2024 7:18 PM, Lazar, Lijo wrote:
>>>
>>> On 7/26/2024 6:42 PM, Alex Deucher wrote:
>>>> On Fri, Jul 26, 2024 at 8:48 AM Sunil Khatri <sunil.khatri@amd.com>
>>>> wrote:
>>>>> Problem:
>>>>> IP dump right now is done post suspend of
>>>>> all IP's which for some IP's could change power
>>>>> state and software state too which we do not want
>>>>> to reflect in the dump as it might not be same at
>>>>> the time of hang.
>>>>>
>>>>> Solution:
>>>>> IP should be dumped as close to the HW state when
>>>>> the GPU was in hung state without trying to reinitialize
>>>>> any resource.
>>>>>
>>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>>>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60
>>>>> +++++++++++-----------
>>>>>   1 file changed, 30 insertions(+), 30 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index 730dae77570c..74f6f15e73b5 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -5277,11 +5277,29 @@ int amdgpu_device_mode1_reset(struct
>>>>> amdgpu_device *adev)
>>>>>          return ret;
>>>>>   }
>>>>>
>>>>> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>>>> +{
>>>>> +       int i;
>>>>> +
>>>>> +       lockdep_assert_held(&adev->reset_domain->sem);
>>>>> +
>>>>> +       for (i = 0; i < adev->reset_info.num_regs; i++) {
>>>>> +               adev->reset_info.reset_dump_reg_value[i] =
>>>>> +                      
>>>>> RREG32(adev->reset_info.reset_dump_reg_list[i]);
>>> A suspend also involves power/clock ungate. When reg dump is moved
>>> earlier, I'm not sure if this read works for all. If it's left to
>>> individual IP call backs, they could just do the same or better to move
>>> these up before a dump.
>> Suspend also put the status.hw = false and each IP in their respective
>> suspend state which i feel does change the state of the HW.
>> To get the correct snapshot of the GPU register we should not be
>> fiddling with the HW IP at least till we capture the dump and that is
>> the intention behind the change.
>>
>> Do you think there is a problem in this approach?
>>>
>>>          amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>>>          amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>> Adding this does sounds better to enable just before we dump the
>> registers but i am not very sure if ungating would be clean here or
>> not. i Could try quickly adding these two calls just before dump.
>>
>> All i am worried if it does change some register reflecting the
>> original state of registers at dump.
>>

I was thinking that if it includes some GFX regs and the hang happened
because of some SDMA/VCN jobs which somehow keeps GFXOFF state intact.

BTW, since there is already dump_ip state which could capture IP regs
separately and handle their power/clock gate situations, do you think
this generic one is still needed?

Thanks,
Lijo

>> What u suggest ?
>> Regards
>> Sunil
> I quickly validated on Navi22 by adding below call just before we dump
> registers
> if(!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
>                        
>     amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>     amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>                        
>     amdgpu_reset_reg_dumps(tmp_adev);
>     dev_info(tmp_adev->dev, "Dumping IP State\n");
>     /* Trigger ip dump before we reset the asic */
>     for(i=0; i<tmp_adev->num_ip_blocks; i++)
>         if(tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>             tmp_adev->ip_blocks[i].version->funcs->dump_ip_state(
>                                     (void*)tmp_adev);
>     dev_info(tmp_adev->dev, "Dumping IP State Completed\n");
> }
> If this sounds fine with you i am update that. Regards Sunil Khatri
>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>>> +
>>>>> +              
>>>>> trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_reg_list[i],
>>>>> +                                           
>>>>> adev->reset_info.reset_dump_reg_value[i]);
>>>>> +       }
>>>>> +
>>>>> +       return 0;
>>>>> +}
>>>>> +
>>>>>   int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>>>>                                   struct amdgpu_reset_context
>>>>> *reset_context)
>>>>>   {
>>>>>          int i, r = 0;
>>>>>          struct amdgpu_job *job = NULL;
>>>>> +       struct amdgpu_device *tmp_adev = reset_context->reset_req_dev;
>>>>>          bool need_full_reset =
>>>>>                  test_bit(AMDGPU_NEED_FULL_RESET,
>>>>> &reset_context->flags);
>>>>>
>>>>> @@ -5340,6 +5358,18 @@ int amdgpu_device_pre_asic_reset(struct
>>>>> amdgpu_device *adev,
>>>>>                          }
>>>>>                  }
>>>>>
>>>>> +               if (!test_bit(AMDGPU_SKIP_COREDUMP,
>>>>> &reset_context->flags)) {
>>>>> +                       amdgpu_reset_reg_dumps(tmp_adev);
>>>>> +
>>>>> +                       dev_info(tmp_adev->dev, "Dumping IP State\n");
>>>>> +                       /* Trigger ip dump before we reset the asic */
>>>>> +                       for (i = 0; i < tmp_adev->num_ip_blocks; i++)
>>>>> +                               if
>>>>> (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>>>>> +                                      
>>>>> tmp_adev->ip_blocks[i].version->funcs->dump_ip_state(
>>>>> +                                                       (void
>>>>> *)tmp_adev);
>>>>> +                       dev_info(tmp_adev->dev, "Dumping IP State
>>>>> Completed\n");
>>>>> +               }
>>>>> +
>>>>>                  if (need_full_reset)
>>>>>                          r = amdgpu_device_ip_suspend(adev);
>>>>>                  if (need_full_reset)
>>>>> @@ -5352,47 +5382,17 @@ int amdgpu_device_pre_asic_reset(struct
>>>>> amdgpu_device *adev,
>>>>>          return r;
>>>>>   }
>>>>>
>>>>> -static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>>>> -{
>>>>> -       int i;
>>>>> -
>>>>> -       lockdep_assert_held(&adev->reset_domain->sem);
>>>>> -
>>>>> -       for (i = 0; i < adev->reset_info.num_regs; i++) {
>>>>> -               adev->reset_info.reset_dump_reg_value[i] =
>>>>> -                      
>>>>> RREG32(adev->reset_info.reset_dump_reg_list[i]);
>>>>> -
>>>>> -              
>>>>> trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_reg_list[i],
>>>>> -                                           
>>>>> adev->reset_info.reset_dump_reg_value[i]);
>>>>> -       }
>>>>> -
>>>>> -       return 0;
>>>>> -}
>>>>> -
>>>>>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>>                           struct amdgpu_reset_context *reset_context)
>>>>>   {
>>>>>          struct amdgpu_device *tmp_adev = NULL;
>>>>>          bool need_full_reset, skip_hw_reset, vram_lost = false;
>>>>>          int r = 0;
>>>>> -       uint32_t i;
>>>>>
>>>>>          /* Try reset handler method first */
>>>>>          tmp_adev = list_first_entry(device_list_handle, struct
>>>>> amdgpu_device,
>>>>>                                      reset_list);
>>>>>
>>>>> -       if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
>>>>> -               amdgpu_reset_reg_dumps(tmp_adev);
>>>>> -
>>>>> -               dev_info(tmp_adev->dev, "Dumping IP State\n");
>>>>> -               /* Trigger ip dump before we reset the asic */
>>>>> -               for (i = 0; i < tmp_adev->num_ip_blocks; i++)
>>>>> -                       if
>>>>> (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>>>>> -                               tmp_adev->ip_blocks[i].version->funcs
>>>>> -                               ->dump_ip_state((void *)tmp_adev);
>>>>> -               dev_info(tmp_adev->dev, "Dumping IP State
>>>>> Completed\n");
>>>>> -       }
>>>>> -
>>>>>          reset_context->reset_device_list = device_list_handle;
>>>>>          r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
>>>>>          /* If reset handler not implemented, continue; otherwise
>>>>> return */
>>>>> -- 
>>>>> 2.34.1
>>>>>
