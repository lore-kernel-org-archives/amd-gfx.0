Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A98E77197
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 17:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8C9B10EE65;
	Thu,  9 Jan 2025 17:10:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c6vYwbVw";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F20DF10EE65
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 17:10:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmV0bIAzpNbgsUJGkn83naotwnKy2Eu9OKpHAhU14tfsEboP+UP2kCTyNLdzaC3BrYMAqz8LdPJd+7ihy4gBH51cVfZ9t3k4WV2X0DRzRGE8paw4yic+T/qWr5ZK2OLmB/rAofTV9nEsBSpHZwiTSEYEVR8LOXg5QjiMzm+uzU5Upe8VFMI38lAOOCU3NptziDM4A8Lxx/FJkH6AxBnfSdvOsHhliiU8kZ+A2tHV1pipDiTB9hlKokzsiscILAn5oANS7wp8VwrSLEsBU1HhcYcqigEurLZB3UmhT3O1m0e1OdYIEkXVrN1LLvhQMYaIfUQLj6DOFUsLqA6pE5fpbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/Fq/BqInA8xSP4kd71PYFiiFGvlF21iLo4UEB/gPZ4=;
 b=fTHu8skHnIY4ZP92QsJgmIZ6xKcmEAG+w/mEK2NPbxf7kr/R2AUrFMCkIlsjWircX/iusvifSBBNN2GMWWdlvWU/i+88nijZswR3bcAM3+XJx6nVT+s8dsEsCLhJZzdgVBAj6Xbye1J96ezM/k68lBUSEEbDcA6AeK1oBdJY+wxurXgkG0lMbqHs6V+JAM8CZg2DBsRCfHQIKb9XgZuBbz8uFgaKdHzP2uBcZcybuJ/M/e9Lm1HywDITXdsns4U+01kH7+VLUD//qnBVRRWGvlOMsLq5XBLeZQ3yX1ZCeMI6EHJqRZpDUrPSf69sijiIEvAaIxqQabQbLu9nh9AhCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/Fq/BqInA8xSP4kd71PYFiiFGvlF21iLo4UEB/gPZ4=;
 b=c6vYwbVwyJPcOhOT6n7FGlZsw4N9/8G+W1hOzHZMmpAZOnHsZVkRv/m+qdw3jFsdVKKkQM7AzjUtdtZsgme9NcN17iTO9BBlY4VkRCL55GtBoYg8bTOM5noc5mkO+/CoIumyJb99NduAVwVslSJB4Y5GcigkW1q5hiFYJRNPy4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV8PR12MB9408.namprd12.prod.outlook.com (2603:10b6:408:208::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Thu, 9 Jan
 2025 17:10:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.012; Thu, 9 Jan 2025
 17:10:42 +0000
Message-ID: <512c6943-57a7-4cc5-98cc-5400a5113b58@amd.com>
Date: Thu, 9 Jan 2025 11:10:48 -0600
User-Agent: Mozilla Thunderbird
Subject: Re:
To: Gerry Liu <gerry@linux.alibaba.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 "Lazar, Lijo" <lijo.lazar@amd.com>, Hawking.Zhang@amd.com,
 "Chen, Xiaogang" <xiaogang.chen@amd.com>, Kent.Russell@amd.com,
 Shuo Liu <shuox.liu@linux.alibaba.com>, amd-gfx@lists.freedesktop.org
References: <cover.1736344725.git.gerry@linux.alibaba.com>
 <37c31a32-c5fb-4a5b-8aad-448997f94cda@amd.com>
 <A6A619E6-08E4-4A60-951B-26F2BF4F93E4@linux.alibaba.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <A6A619E6-08E4-4A60-951B-26F2BF4F93E4@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0192.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV8PR12MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa70493-7999-45d1-a615-08dd30d08c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0tRNU1TdmoydVBtdkJabldXN01kUnF4ZFBJT2ttN1FWZ00rb2JQVEZvOGNC?=
 =?utf-8?B?WVVNaUo2cXFkdUlBRnRCYVg0RktTNUtwM3pWUjJ4SXhJZmdpTXNGOHVZMzBC?=
 =?utf-8?B?dmhhQUlwQnRwR09FTDdTQlczN0hxSDV6SzI4VGpZcitFb2VkcVhPKzVoZE5R?=
 =?utf-8?B?VU5yOEw2NGJoZWRHN2xxblRiK2h3UVlvVHhWQjl5SjdjbDJFRmpaSk92eGlp?=
 =?utf-8?B?dlAxWGdRTjhPaVhTOU9DaEk5Y0JHVitUQmtxNEt1T1puNVJ5L21DN0Y5UDlN?=
 =?utf-8?B?bzhIK1MxWXNxaWxoVHRFZW8yRVlSKzByTWdaMUVyYmk5VlI2UFlmT0tGdzBE?=
 =?utf-8?B?ODgvQkptaytmNURYRUQyTzAvUjFJdmhxVzQxdHNrV1pUb3I5VHFrajExLzU2?=
 =?utf-8?B?blhzQUk4T1U0aTJuWk5RVXlEdUtoYnNzT0pkd1ZoQm5oKzUzRXY1aHZZQ2JU?=
 =?utf-8?B?Sm9rRUc2azduZkpnV3VTQmZocm4wdVJWTkxuUHk4eDZkQWFtZTZvY1JzaUlq?=
 =?utf-8?B?WlprR2hKSUlYRHIzR1BLeFpWRkNIcEJCVDFXMjZKMitFc09zaWltMTI2Ujc2?=
 =?utf-8?B?WFlob1RwNUlzNmtINDRIb2RtZ1NpYmJib3ltemdCbHpjZEFKdkw1OXp5SzdG?=
 =?utf-8?B?MXcrSzY4UmwrRHNWcTh6RFU0MHZWY3RNMFA3VFMrQ2RtUkV0Y1ZHNE94YVFZ?=
 =?utf-8?B?L0RmdkRXOEVHK1Y2RmUvWHdtdktJeGMxUnl3RHo5YU5qRTJ3WGhVTXNkMGxP?=
 =?utf-8?B?aU9QWW44MHdSa2phN214MTZkblRqK0l0K3FRcFRtM0VsWFJXaG9ITTQzUWsz?=
 =?utf-8?B?MjhKNmZWcDdzYmlaVGNLU2xEbVprdE5QeUw4ZXVrUkYrL3BXZmtLVUF2VlpQ?=
 =?utf-8?B?Q0RmcU1Rc2tLNGgwTVRFb0hHNVFpTnRJU2JLVnNBK1VER1Uyc2FmSXVWbW5n?=
 =?utf-8?B?bEI3SUVyck9wRm9kajhOV3ZmZTZMVkk0bkdBOTh2Z0I1WmVYTWp3dmtWR0lq?=
 =?utf-8?B?bU9wOVo1emxaZU52SDIzdmZOaUtGYk53blZoa3Y3Z3puTmxvQ2owNDI0TDVy?=
 =?utf-8?B?Ykl0dVdXTjZXOHFsYjNyUkNEazdUK05yakpjSEFuRDFSZENEYWY1NksxRkVq?=
 =?utf-8?B?NGs1OXBaV3RhdDhCbE1VTFNHWDdibUdheTF2MzN4MHRKbFlUYzBWUERmWVl5?=
 =?utf-8?B?RUk0NkVpNFNCeE00U0EvaGNpTkZvcGxyMll6SWI2L0JsTWhYUnlBakdibDly?=
 =?utf-8?B?ZmtyaElGOGlBaUxTNnQycWFUNFQrUkxBS0U3aEd1TWwwZXN4YytPdXJpQnhk?=
 =?utf-8?B?VG83Q1pGVXE1Z0NZQVF6L1RFY1lzeGJtNVYrQ0cyeXI3U20wa1NaSWdpZWwv?=
 =?utf-8?B?eTlYbFVVa2dPQ0NFc1hSRkVlUzY5YlVpS1ZOdHk2N1NPVmpaOU5OMUl5RG9I?=
 =?utf-8?B?VnRZblhUUHBhMnlURzBkSmhzcHdWMTREd2tYSmJteFRlNDExcWdBRnUwQys1?=
 =?utf-8?B?c2EwYitzcVVXbmM3em11c0x1Z3BtVGdJR2I2ZkRXWWdvUm1pVWV3NjFaQUw0?=
 =?utf-8?B?bDJxRzdhS3NFUjl1czFaQnBaOXAyc3VFbFpVVjFVTFh4MmlCNENtTS9RcUNq?=
 =?utf-8?B?clAvQ21ZWkxLZHVsOEdQcWI2eTVwblplOEUzNko4OTI0RkdkTFhiTzY3R1Nz?=
 =?utf-8?B?eVcxZU05MVNkTzZORm0vbk13SlZWbUZBdkpQVnhFT0tzNkk2QjVra2RwenF1?=
 =?utf-8?B?TE56U2lsVGlndXdwd0tLVkR5MGFSS2Rqc041WHdzbUVRYmVvb3Y2Sm1PYVVn?=
 =?utf-8?B?V3U0V0llbm02SHB4byttdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alZGdHlab3AxR00xcXRZc1pyZmhzbjNEaGpzZURZOFhHdGtrK3lSMjdtVWNv?=
 =?utf-8?B?bnVrME9KR05FU1ExWlY0VzJMRzh2VWtOUDVzVVMrcXEwNmRrTnppNlp5NlN5?=
 =?utf-8?B?dFoyYzRZS2dYSmFGUG9sSGJJVGNGRkM2M3RnRzN3alVxaklhczZCU1FhbVhx?=
 =?utf-8?B?Qkp1bjZlMWFqQ1JPRkZ1N0l2cXV1RFN5d2NjYWlqNUk3dDIxVzlOMTVPSXU3?=
 =?utf-8?B?RHk3eWszL3NXODMvNXJZUzB4Yk8wUFlVQWJqNkdkWVp6OTNPRXFnN0FmYzdq?=
 =?utf-8?B?dFBFN3o3Vm1WY3JGUmZFV1Q2bkUxTk1HRnQyR2FxTFNRWTV4UzBYcXFVejlW?=
 =?utf-8?B?N0NzclVQTnBBeW1KZ2szOXZ6S0NTVUl5cE52cEJPVzZuOTF5eUVVR05VaGd6?=
 =?utf-8?B?a0pDUDgrSmlzaG1xS1pBeXp4b2pmRmJlbkNkV2tBMzRKTnBCVXorNVJLbzB5?=
 =?utf-8?B?WWNoeGQzK2cxaURPZFY2UzcvRUtidnlvWmZZWnl0OWc2ZkprMXZsN3pDK0NL?=
 =?utf-8?B?Nk1McW9xTFI3NGZteXU0YS9pMmVZdFZ5UUg3UTliQVg3Lzl5TG1KTVpBRWUr?=
 =?utf-8?B?UDVWRE8vS0gvK0lzTzVmaVdDeW9uMFZGQUxZVFFDc2J4ZGxyNEJlQmV5bmhR?=
 =?utf-8?B?R2hSY2d4ckFTOFYwMFcxZFA2ZU02R2dCMGMyMGlDalhWM3pvajE0OVlLc3NE?=
 =?utf-8?B?YWNkbGlPc3hDSFR6U3RSM0lqYzhWc3BCOHovQ2NSaXlYMmNOZGY0bmRRSThQ?=
 =?utf-8?B?QjNRMW4wVG92TExnckw2czFzbXRFc0gyK1pleEhqSHlSRXVSbjNpc0JCaDQv?=
 =?utf-8?B?Q2UzQm8yeVhyV2tnd1QzSzFDNm1RNVNUVjdGVFBpTTJDMHNqanNaeVRNOS9m?=
 =?utf-8?B?SlBOeTVEUkpLc1dESHRXR0hjM2l5bU16dEsyUHpsOXpGQklGVzMwTGQ0RlR1?=
 =?utf-8?B?bHg4NFZoNjFKdjFmVU9YME42ek4xWFlHdCs5bmc0eDRxQ0JDRFUwdmV3Y0Jx?=
 =?utf-8?B?OTY0NTM4VjlMNmEvbFpiVENPOUFWMFREekEwV1FKNTNJMFFpV2EvK0U4dnk3?=
 =?utf-8?B?L0dEbVhPZGtrVmRhZWJDQmRvSDkwMjBvaStBY2JhWHQ1RUdvT2ZVaDduZFVC?=
 =?utf-8?B?V1FzcFNNdDJCMHlqWmFZYkZtWXl2d3dPSWJYdmJHUHBXeFZHQnQvMWVDWmdZ?=
 =?utf-8?B?ektWMTUrRmIvUFpIQkNrbHR4RSs1SkdKM0trNjR3VnM5OXY5UTlXV3djVjZk?=
 =?utf-8?B?ZUticHNDQVJmbld2RVFETnFYaW83QWZHcmw2UCtmdnBRYlZ1ekV0bmJwM0R6?=
 =?utf-8?B?eW1aSjlwY2FnZHhCTDFoWFpmNGl6YnVlWWJDazU5N1dudmhNWm0rejRQVHRM?=
 =?utf-8?B?ZnpuNXhkR2U5NmJxS0pQaDUzaGFiMUtwS3JYV3VSak0xV3pGMS9pUDJ5TTRw?=
 =?utf-8?B?MCt4eUoxMTdNVE00K3BiUTZ2N0VHdUg5akRJZWRIWkM2a29lWkc0ZnhEeHpH?=
 =?utf-8?B?cFlQVWtjQ20wQ21sK2dxeC9MbHFFbEJkaEFlNjl6NHBlampoQ3MvOHM4a01k?=
 =?utf-8?B?SkE3S0RmcStuVFNxS0hxQk9GSitDWmhnZHZtMktBVVJVcEM0VHRHblpNdGZp?=
 =?utf-8?B?clBrQWVTMjY2aU5jV2p5amlYUmNpaUUxVFFFQVlMOFVhUlJPTGE1NFNOSk91?=
 =?utf-8?B?YTN1UHRralhqV0hqUUpyWTF2RTgvdkh3eFlXSVVJdkZpOG1UK2wwMlFVN3Na?=
 =?utf-8?B?aVJwQy9yaDFuL1JEYW9YR0FDc0VlQzRvMWVFYTR5ZUg2emxZeXMySFYyRnpM?=
 =?utf-8?B?UFlpeDBubnNWMXVHRVN0bzdzY0FLK0c3QW95dUpYVTVseDcyZi9WYUVNRmFU?=
 =?utf-8?B?VU9CdnlPL2FtTDJsY0FzVjFLYkZFdTJSemtrWnNGei91UGhoY2hWczZpTXNa?=
 =?utf-8?B?WnByQ01CY0orS3lZRytEd2NEcUFzSVJxZTBSeXB0YTRiS2dZbHNMcXJMNVA1?=
 =?utf-8?B?c29yUWMzeXBwOTJsYTZGSHpvaFUxekpkWFRQSnFqMUp5RTh1dE9yaGh4TEVF?=
 =?utf-8?B?Y3dyelM5VFZJTDYxMFU3aUlPZU9BV1NVdXVDQXpUdWxkMTdpUFVsOFIydisy?=
 =?utf-8?Q?3Z1ddqOBpduMtftMY7QegZxy7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa70493-7999-45d1-a615-08dd30d08c27
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 17:10:42.0515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odp9yIrgAJpWyvehyfzOQ53l/L4ss6kiCKwvJ9fQ9YwVSMu015ktF9s/MJN8Qsn4g0M9QODA0PY7nbmLWTqpvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9408
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

General note - don't use HTML for mailing list communication.

I'm not sure if Apple Mail lets you switch this around.

If not, you might try using Thunderbird instead.  You can pick to reply 
in plain text or HTML by holding shift when you hit "reply all"

For my reply I'll convert my reply to plain text, please see inline below.

On 1/8/2025 23:34, Gerry Liu wrote:
> 
> 
>> 2025年1月9日 00:33，Mario Limonciello <mario.limonciello@amd.com 
>> <mailto:mario.limonciello@amd.com>> 写道：
>>
>> On 1/8/2025 07:59, Jiang Liu wrote:
>>> Subject: [RFC PATCH 00/13] Enhance device state machine to better 
>>> support suspend/resume
>>
>> I'm not sure how this happened, but your subject didn't end up in the 
>> subject of the thread on patch 0 so the thread just looks like an 
>> unsubjected thread.
> Maybe it’s caused by one extra blank line at the header.

Yeah that might be it.  Hopefully it doesn't happen on v2.

> 
>>
>>> Recently we were testing suspend/resume functionality with AMD GPUs,
>>> we have encountered several resource tracking related bugs, such as
>>> double buffer free, use after free and unbalanced irq reference count.
>>
>> Can you share more aobut how you were hitting these issues?  Are they 
>> specific to S3 or to s2idle flows?  dGPU or APU?
>> Are they only with SRIOV?
>>
>> Is there anything to do with the host influencing the failures to 
>> happen, or are you contriving the failures to find the bugs?
>>
>> I know we've had some reports about resource tracking warnings on the 
>> reset flows, but I haven't heard much about suspend/resume.
> We are investigating to develop some advanced product features based on 
> amdgpu suspend/resume.
> So we started by tested the suspend/resume functionality of AMD 308x 
> GPUs with the following simple script:
> ```
> echoplatform >/sys/power/pm_test
> i=0
> while true; do
> echomem >/sys/power/state
> leti=i+1
> echo$i
> sleep1
> done
> ```
> 
> It succeeds with the first and second iteration but always fails on 
> following iterations on a bare metal servers with eight MI308X GPUs.

Can you share more about this server?  Does it support suspend to ram or 
a hardware backed suspend to idle?  If you don't know, you can check 
like this:

❯ cat /sys/power/mem_sleep
s2idle [deep]

If it's suspend to idle, what does the FACP indicate?  You can do this 
check to find out if you don't know.

❯ sudo cp /sys/firmware/acpi/tables/FACP /tmp
❯ sudo iasl -d /tmp/FACP
❯ grep "idle" -i /tmp/FACP.dsl
                       Low Power S0 Idle (V5) : 0


> With some investigation we found that the gpu asic should be reset 
> during the test, 

Yeah; but this comes back to my above questions.  Typically there is an 
assumption that the power rails are going to be cut in system suspend.

If that doesn't hold true, then you're doing a pure software suspend and 
have found a series of issues in the driver with how that's handled.

> so we submitted a patch to fix the failure (https:// 
> github.com/ROCm/ROCK-Kernel-Driver/pull/181 <https://github.com/ROCm/ 
> ROCK-Kernel-Driver/pull/181>)

Typically kernel patches don't go through that repo, they're discussed 
on the mailing lists. Can you bring this patch for discussion on amd-gfx?

> 
> During analyze and root-cause the failure, we have encountered several 
> crashes, resource leakages and false alarms.

Yeah; I think you found some real issues.

> So I have worked out patch sets to solve issues we encountered. The 
> other patch set is https://lists.freedesktop.org/archives/amd-gfx/2025- 
> January/118484.html <https://lists.freedesktop.org/archives/amd- 
> gfx/2025-January/118484.html>

Thanks!

> 
> With sriov in single VF mode, resume always fails. Seems some contexts/ 
> vram buffers get lost during suspend and haven’t be restored on resume, 
> so cause failure.
> We haven’t tested sriov in multiple VFs mode yet. We need more help from 
> AMD side to make SR work for SRIOV:)
> 
>>
>>> We have tried to solve these issues case by case, but found that may
>>> not be the right way. Especially about the unbalanced irq reference
>>> count, there will be new issues appear once we fixed the current known
>>> issues. After analyzing related source code, we found that there may be
>>> some fundamental implementaion flaws behind these resource tracking
>>
>> implementation
>>
>>> issues.
>>> The amdgpu driver has two major state machines to driver the device
>>> management flow, one is for ip blocks, the other is for ras blocks.
>>> The hook points defined in struct amd_ip_funcs for device setup/teardown
>>> are symmetric, but the implementation is asymmetric, sometime even
>>> ambiguous. The most obvious two issues we noticed are:
>>> 1) amdgpu_irq_get() are called from .late_init() but amdgpu_irq_put()
>>>    are called from .hw_fini() instead of .early_fini().
>>> 2) the way to reset ip_bloc.status.valid/sw/hw/late_initialized doesn't
>>>    match the way to set those flags.
>>> When taking device suspend/resume into account, in addition to device
>>> probe/remove, things get much more complex. Some issues arise because
>>> many suspend/resume implementations directly reuse .hw_init/.hw_fini/
>>> .late_init hook points.
>>>
>>> So we try to fix those issues by two enhancements/refinements to current
>>> device management state machines.
>>> The first change is to make the ip block state machine and associated
>>> status flags work in stack-like way as below:
>>> Callback        Status Flags
>>> early_init:     valid = true
>>> sw_init:        sw = true
>>> hw_init:        hw = true
>>> late_init:      late_initialized = true
>>> early_fini:     late_initialized = false
>>> hw_fini:        hw = false
>>> sw_fini:        sw = false
>>> late_fini:      valid = false
>>
>> At a high level this makes sense to me, but I'd just call 'late' or 
>> 'late_init'.
>>
>> Another idea if you make it stack like is to do it as a true enum for 
>> the state machine and store it all in one variable.
> I will add a patch to convert those bool flags into an enum.

Thanks!

