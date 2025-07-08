Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF92C71130
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jul 2025 07:24:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0A7310E12C;
	Tue,  8 Jul 2025 07:24:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OrlKxQ1u";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BABC10E12C
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jul 2025 07:24:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NumNq7yfRZEdtcCwehux4lcUgyCKqErODc/Z3rBWpWwX8Mn85r/jtHzjbRulE5bCKOtdw2DJ7OvUnprqH2qt2tODS22Roc39vIe6KEHkQfliBv2gacugkTON2kEFiYrdpyOs4Ql9+NBxW2Q6t6Zz0UxdY8nl5kgs2kxdoJwTQWNiPAeB5WlNk/9rLDEoeUaO1KVdaniFmQPugnyEAMP1E5Z/kggS3ahMUQbMkG+KeZppbz83yrQfaJWif5/lLJ5VMPHck7yun6lvo8vgPbeteCCT1z9x1HoN/SouhInh8R7xhgCHcsaFPtMvX3kPz5ib/XALxhvmLNP7gC3LQEeQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+U7ceZOLcbn23Et9Dk0YN+rb2Ag13K7UI1jJajUSDW8=;
 b=plYa9inCfgdcFONMmBXsQGmHXnsEKrsaFBsBi8LenwJo2p5hx7o8Jci335wKWPBT03BfXR+wkAo8EkVlW4527Q+1mMntlaN2O/cVsEn3xKyoE/HtoZ4cTSTnNXQ7/ftAEl5yzdz7pi4BPh0//Hv+LDI+n+hpDO2yhU/qTqai0f3M3B8w9m7zuJp0p7mB2ogDeocUlyvmKoZGzbYOzaE5bnP6lodwfOJh8nSqk52SDVAWVx61yxoD+0hehSQriAYzUNcD2Toeh46mUBhCxfsOjA1GyxT0JXGl0BgXliEpQ3MGoQYpUe6YWKIEq2pIKW08f5fs879J3HuXhW+ARrzkhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+U7ceZOLcbn23Et9Dk0YN+rb2Ag13K7UI1jJajUSDW8=;
 b=OrlKxQ1uPm3ymGw579jt3Qup5KHsC53C9JeCvjVkZy+H9WNKj1gQpjDUJU1uFcz1pjaOFEUvPBNW3D8+2IbHVY4JFF0f3xcpjIMZkBBAhdkzrtrH2twGAlwK635hT2CvacPGf9NXKzTDMAzcKa4a1qOTj6dsuBp92Le3B9MAx/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by CH3PR12MB8753.namprd12.prod.outlook.com (2603:10b6:610:178::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Tue, 8 Jul
 2025 07:24:40 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 07:24:39 +0000
Message-ID: <6be280ac-04a3-4542-a57c-85279da85f14@amd.com>
Date: Tue, 8 Jul 2025 09:24:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] drm/amdgpu: rework the userq doorbell object
 destroy
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250704103308.1325059-1-Prike.Liang@amd.com>
 <20250704103308.1325059-3-Prike.Liang@amd.com>
 <4974d335-2b5a-46c8-a832-6ad1ce642e7e@amd.com>
 <DS7PR12MB60055EBFEF1E99030CD2C218FB4EA@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB60055EBFEF1E99030CD2C218FB4EA@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0300.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::11) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|CH3PR12MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: bbbf118c-8a0e-4aea-afae-08ddbdf08025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVR5NGZNNytkdVFMMWE3ZEk5RU4vUERYeVlsM2dPRTJXMkZaQ1Q2Wk9aZ1Fm?=
 =?utf-8?B?N2NSOWw2dm5ZTDNWbDlpNnM4OCtlWDR0UnM1S2JUdFZhQ2RNS2lHdHZoRWor?=
 =?utf-8?B?SVRPOWh3ems3bkJhK1MxTWdtRzVKemIzd1o3TDB1bWpFRXljQjZGNXQ1TG1P?=
 =?utf-8?B?aGFwUzJIaVFkLzZBMFhPNVVRZXRrQllzaFBYTXFtUFM1cmtaczlNRGEyVnN4?=
 =?utf-8?B?ak4rR1lJRDQxNWNIZVdLblpBVGhnWEE4TlhwenBucXNLU0tzSURnZXk2SSsr?=
 =?utf-8?B?SEtJZ0NQSndFS3M1Q0pUZyt4WFRoRm9nQUJLOVZKdFkrSXVGT0s2Y2UxdGZ5?=
 =?utf-8?B?bktTT1lCQ1VTaGlwSWVVRlJGVFR0N1VtSmliUFBaREUwUWd1eXdZUThLQUtk?=
 =?utf-8?B?YUcwQ3hOOWQ4aUc3Y2tJZzZJY0cweDNHd1U1WVVpRG1Da09MUEdCTncrREU4?=
 =?utf-8?B?Ykl3Z1FkV05uQzBPYUtlUW9rMXZOQUFDSlRQbEFQU2ZZSmJSdWxoMnllWWNR?=
 =?utf-8?B?OExMQWNZNS96NHBNMTkvNmVkRE80UkJEcEtTYmlsa3A3cHEwQ00vRnJXS2dG?=
 =?utf-8?B?OTdJR3ZEdGtiSUtUMkpTaXRJZGt6bHhOL2FPMFF3YldEMU9EYVdZMGU1MUJW?=
 =?utf-8?B?dS96QlYxTkJaYThueXh2WG5VK3owUWNEOGhMV0hwckNBdzhmU0hhTUFVdVBU?=
 =?utf-8?B?Mml1enZGVjJBNlpQRnp2RTNDblZ4WThlWVhybDB0T2w3K0NYSDFsTjAvd3Rw?=
 =?utf-8?B?b0lKV0I3MUVuYzIyb09Ob0g1R0JqK09ybWRvT0FBRGRLSU51L2RBS2FxUSth?=
 =?utf-8?B?M2ttTENEQ0hvTWV4dUNXS1lWdTV1SmQ2b1ZOcXk2UGZkMWpDRUI5Slc4NzFh?=
 =?utf-8?B?L1VYNHpvQVFvdVlzdmtncmpIaVlINzl2Z3dtTDJ5dDEwWFpTbUpYckFrR1pn?=
 =?utf-8?B?Y2lTQWVjU3NNekNoWUdWdDZjcHhsbVpHcXR1Ti85QXhQWTZxaFFpTnhMN0tC?=
 =?utf-8?B?WE5WeGIrVWxIaXZEd0xrZ2RlYndkamdTZUl0RXQ0cldGRHFBN2Vhc3ZwcHk1?=
 =?utf-8?B?OFM5bzMxOTlRUXRlVWRKeFhnYXByRlI2QTlaQ3dlZ3p5OEErL2I3WW9oUVAv?=
 =?utf-8?B?Y2hOMGtXdWlFR1N2T3I0Y1RmQjcvU09UaW9NSDFnREs2bW16THFUdzBEbit0?=
 =?utf-8?B?N2xGTUVZczlPYjRmcmRCZG9JdUViV1V0bWNheW9hVXRNKzNHRXNJdVVMQjFn?=
 =?utf-8?B?ZXg1VExVdmZZanc4MHVEbDYwczNYUWR3Sjd5cVBiZXRHSnlVVWUrYkxkVmtL?=
 =?utf-8?B?Y3hTbzlOUGFORXZPVFFxb3VtQ3JxNjBJUU1lemZsbU9kQ0JsbW93QlFGY08z?=
 =?utf-8?B?Y1A2QWtvTkJpazY3anQxZys4bE05dGdVZE1DTXoxSXR4T255TWRKc0oycndV?=
 =?utf-8?B?bzNUNWhPdUlENmJpWlNSd2JGVXdtd1cxaGJLMTlTZGMweWFydjJmd2x3MVBl?=
 =?utf-8?B?WTM0cnZjNUc3YUhYbGxLam0zdjFyQXJYM1dUa3c4RmlVSThEamFuY2U3cksy?=
 =?utf-8?B?TW5mNzl2dFNZRlFSeWpJY1N2VWRmc1BRaGxwK1pQZk9ldHZXU0U0TVVQS1ZJ?=
 =?utf-8?B?R2ZQSjNLQzNXVDFSekF3OG9SSXhyeUN5UUpBQXdQY2tQcUY1SnF4cTdoQTBH?=
 =?utf-8?B?Q3hIMitCaHduTk5jRkJvYU0xNGcvbkFsRzFHczhCZHVQeHIvYXhiTFNJUTFn?=
 =?utf-8?B?MGJoN2p6VEZMU0hBd0VjdVRwSm5SUVovRDlnZ29yaE91alJRY1ZUVm5rMGkv?=
 =?utf-8?B?MlVHdnArL0tnREdVZHdpZ293S29nbVdzK2FnWkxpVWtPVXV3bHUzb0VFWWZG?=
 =?utf-8?B?bWpJdjNYaXQ3dG5MQlNsK2RsU09ZWWZSdC85MUFWZ01NNDdVd1RrTlZpT04x?=
 =?utf-8?Q?p/rLwzrfGsw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWhZRGlMdENqMWE1QXF2V2ovbzl1dll3c25RM0s0U3QxOXFxL2hOTktBSWh2?=
 =?utf-8?B?NlQ1RC96YTNFRUtCWDVjSmNYUFlxSWNhbllXT2l6V0FiQmxVZjN6S0VRMEpt?=
 =?utf-8?B?NGQ2SWtQWDdrRjZOOU5SODFoSmF0dDVER2EvSTBXeFQ1VlRWRUppbnd6TGMw?=
 =?utf-8?B?QUdkZlFtdFE5Q2FWNkJwSnRFeVdsK1FqcXVLT01Xa2daaUUzNzl4RHRxMjNu?=
 =?utf-8?B?ZTJ2d09VM04rcCtvSWNQUW5EOGZnYzNaa0NFcGxuSUxEQzk1bmg3eWM0QnJZ?=
 =?utf-8?B?TElEdEovOTdIWHhMOG9qb3I0NTh0RXRMQ09wbitpUklFN1JaekUySWM5eVNW?=
 =?utf-8?B?SitJU3k4SVpBZGg0YzVHd2d1bnkwNGhoV3Q2cktjdkNPbk16YlhnQnBWR3A1?=
 =?utf-8?B?QmhZUnB1cDFRWTJPYWxYSzVteno0NWJKemVTNWQwd3VLTHg3ZWlWbnl6Y3VN?=
 =?utf-8?B?S1drZDA3UzhyV0QyeTQ3NWtPelg4S0lTL1VSSnVZK21Pelljejd1VUVFSzVY?=
 =?utf-8?B?WnVESUlxdlluN24zTGlQeUJ1bkc5ZWxQOXc4dHpMYWhheno3alpIWjdWaUNQ?=
 =?utf-8?B?VGZ2TUEvUGZrMjc3aXgveXJabDNwa0dwNVZ0RGEzYzk4UmsxV0ZPT00vTlNW?=
 =?utf-8?B?dHJuTzB2ZTZpeWlLd1dWSzVySmdXYmVNc1JLVVJidHNXcHdNU0pjZmk4M3RV?=
 =?utf-8?B?d215TU54Y0g3QlZoNnd3dllsRi8wanF1c0lDbXJPVmxGN296c1dHTmZiZURv?=
 =?utf-8?B?YkkwdE9pL25wUFMrRW1rNWpEUFV4WDlxS3IyR2JkTVZaK20yUXhmTmd2MmdG?=
 =?utf-8?B?TTZickMzTjhVb0JlMDF1MVkvOTFJWmg4ay9IdzdJVUdqTTE5cnFGUnRWOW5n?=
 =?utf-8?B?TGp1ODhURG13K2I2dStpU01YOEpOZnc2OXV3dFhDNUU3cFAvWVpscytUYU44?=
 =?utf-8?B?WTc0Rk54WEE0ZDczSEpCemdCOThlMG1sRm5kSy8xS3lCWkJXRnhmNm4zMUd2?=
 =?utf-8?B?RHBERWxMeGphL2hjU0YvWU5NLzhlcjA4YnRYWVVCUmFUUEw5WEFWc1ErV0xi?=
 =?utf-8?B?SHMwVVpTQmV4QU9FRTZqSWp3ZFBMemR0MW5oMlpHTktyV1VNMzlkSEVQNHVT?=
 =?utf-8?B?azFqNWQwN2JvdnNjdEdRa040TTRHck1IZVpUTjVhZDI4aGlZSytOby82NU01?=
 =?utf-8?B?MmRtNDJFd05vanFlZGZRNnNSNzdudy9NelhBY3NYSFlDQ2tBZ3B4dUVmR3hR?=
 =?utf-8?B?djJFQmpNTmZLVkNpUkhsNUo5L2V2MlhvWGpxTzNzL1V3L0daei9GcjhhNmRX?=
 =?utf-8?B?ODUwdjNPaGc5bVVxWVFtU3c4elJnMUFkL0JwQ1ZLRHhmUUNzVG1hUGNhTVlO?=
 =?utf-8?B?b28zM2h3OUVsR3psekV3NE9JSlZheG8zenJZWDV4RGIzSXlEU2RzV0FVNW9P?=
 =?utf-8?B?Wm5KS0pCVWswVUk1K2FGNmJSTGhYZkZ0MnZoU2FjTGovenZOZWpUZ0FMWWsv?=
 =?utf-8?B?UnpZdDB1SFZLbEVuRTVCV1RKNFhuQno5QXFZUlJNVWtUMGNQU1hYY2swSUlx?=
 =?utf-8?B?dHViaVk1dHFTZ1BGM3F0Rjd5VHljMnovd0NJajM4UVN6NXRsSzQvZmlHQzF6?=
 =?utf-8?B?dGtUU3NIVFg3aXVFVnMyUVN4bHB6cW04b2EzN0JNejlVQ3ZTZllMa09yU1Fw?=
 =?utf-8?B?RUdrWmJZS3JsREhKZXZuNkh2d1YyRUVleWJIelYwbWh4ZlM0aHNoMnVGd1dw?=
 =?utf-8?B?MUFNdWFVMHg1YkVONTFpc081bWFlcndRSkl0bDNuSm9tVWFoWlR1YnAwVGxp?=
 =?utf-8?B?R05JeHpjWDhyc213MlRIRkVZOWd0ZVU4aDlzdU5iWkhZbmxtK0g0dk11Z0lN?=
 =?utf-8?B?MGkyNDZ0aVUwM3VIRHZ2Y3hvQk5XeFdQb0YzMk9mcm1rTHMybVFweUIydTRM?=
 =?utf-8?B?TEVRaFF2UVAwR2ZaR29OTWN0TTZyOGthSFdRYy9SaklyUWRzY3pjVk9iK1pP?=
 =?utf-8?B?bFBhQnVoWkROdFMyNUM1R05SaGc0b3NCbE5QTW53dDNIcks4a3hhaXlHc2l1?=
 =?utf-8?B?U0xxTmYwcCtma1ZXdTlFUUxvYlBWV3EvNXVnUllOM1ZFM1JCNU1jSWVtQlQv?=
 =?utf-8?Q?blz+5FmOYtg9v+mNOCVMszyUT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbf118c-8a0e-4aea-afae-08ddbdf08025
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 07:24:39.8772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqVkc0Z6/aR0YwN50toquJ0x4a5LZE4dcpf6DRvqowa3m8RhYpasgtLYPNGAXj8S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8753
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

On 08.07.25 09:00, Liang, Prike wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Monday, July 7, 2025 5:28 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH v5 3/9] drm/amdgpu: rework the userq doorbell object destroy
>>
>>
>>
>> On 04.07.25 12:33, Prike Liang wrote:
>>> This patch aims to unify and destroy the userq doorbell objects at
>>> mes_userq_mqd_destroy(), and this change will also help with unpinning
>>> and destroying the userq doorbell objects for amdgpu_userq_mgr_fini()
>>> during releasing the drm files.
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 1 -
>>> drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 4 ++++
>>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 3d2a7f8946cf..f1c41b1114d0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -317,7 +317,6 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>>>             amdgpu_bo_unpin(queue->db_obj.obj);
>>>             amdgpu_bo_unreserve(queue->db_obj.obj);
>>>     }
>>> -   amdgpu_bo_unref(&queue->db_obj.obj);
>>>     r = amdgpu_userq_unmap_helper(uq_mgr, queue);
>>>     /*TODO: It requires a reset for userq hw unmap error*/
>>>     if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) { diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> index 1457fb49a794..dbacdfcb6f7b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> @@ -336,6 +336,10 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr
>> *uq_mgr,
>>>                   struct amdgpu_usermode_queue *queue)  {
>>>     amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
>>> +   /*Validate the doorbell obj whether has unpinned by
>> amdgpu_userq_destroy()*/
>>> +   if (queue->db_obj.obj->tbo.pin_count)
>>
>> Clear NAK to touching the pin_count here. That is clearly broken!
> Thank you. I will ensure the doorbell object is locked before unpinning the BOs and then consolidate and relocate the userq doorbell unpinning code to mes_userq_mqd_destroy().

Thanks! And yes, that sounds like it should work.

Regards,
Christian.

> 
>> Regards,
>> Christian.
>>
>>> +           amdgpu_bo_unpin(queue->db_obj.obj);
>>> +   amdgpu_userq_destroy_object(uq_mgr, &queue->db_obj);
>>>     kfree(queue->userq_prop);
>>>     amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);  }
> 

