Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1FED7496B
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 09:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 218B510EEFF;
	Fri, 19 Dec 2025 09:27:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wFU87hEH";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010060.outbound.protection.outlook.com
 [40.93.198.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5C2310EEFF
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 09:27:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGgwsL4F6CXTElerHBk9vdzftJ1gIKdx5uVpHvV/Goy3HrjQPBjTCX6pjuv2XPorUqCbD0ycBjDpsx0nJa3OVglwsB9JM1OYjQ+kqrWprvUbTXGL2iA1mpC2sMF03CL2AfpQCe0rByMgiio0Kni53Th3Gd0uzuULtVRNbR1I3sNqmPjDx2WR89NhWF6UJWquMKdYQzqfh0MJQXUgtvER/YUi7sHcdKdi9/WJ2kIT4O/rpzzDVSsUQxhGT3rUY9C5a42QqYg5GHChKWsF55nGXyg6lATHwtTDk9Z40ji6kkXL1Gt0DUngqAK+Xi4K5wuGRulYcUH1bLp+z1cvrZHsaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpxj5luM/SbcP4s2CFkjyYXTysuULyggq18EQSO5v+k=;
 b=YWrYRzbPZ2afH1kpJ/Fjv1IDVPcPzL9MHOj+gkLZLKwujHTF+Dr9HojsiA/TNs/m3oLuVwovdC+k92HBMgHK5hM3567vZsZ/AlYeRYHz3YO3LTuBPgZNP4Yx7rpPzw4ey66T9Gxk7G50uh27+FSjone1RUTO51tY6q/UlOfPu99CsggiCFdM2+NDMR9fl3QXTkbXEtIiHzVeCrFN0Mgg7ciKIJ28ndh9jyJfcopyVfgUWeN2Qlt+Um+kEq0zK7jxbIDscnC1jrbRuIhuQcmZy4b1pyrtgTbWQyQ3+BE5z8EWlUfpeaiEbwvN9dnZ1Gr52QiUtaP5PQpg8j8qliMRtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpxj5luM/SbcP4s2CFkjyYXTysuULyggq18EQSO5v+k=;
 b=wFU87hEHGnlftj2EmII905NsMyq878sBE071A5E8+d+7MUfE0I+4UChpzFBIRp0v2XmB7RDVjOuov69FED9KIhlUBcinG3zR8n4j1BOm7idllU9eIHvAJQW1VesPtAjL6gb70+ayatDiHl0JdS/wVpNeNLjVisIyxWZJxPRYI40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Fri, 19 Dec
 2025 09:27:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 09:27:51 +0000
Message-ID: <59e9b5ba-3b4d-4273-937d-20bb2ff47f45@amd.com>
Date: Fri, 19 Dec 2025 10:27:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/5] drm/amdgpu: Replace idr with xarray in amdgpu_bo_list
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20251218150405.80502-1-tvrtko.ursulin@igalia.com>
 <20251218150405.80502-2-tvrtko.ursulin@igalia.com>
 <732a0f53-d4ff-4dd1-9b4e-bc20c1a79925@amd.com>
 <13114ac8-7c30-4c77-b8cd-d558aabefc07@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <13114ac8-7c30-4c77-b8cd-d558aabefc07@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0482.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: a2214dd1-c3f9-463c-47f5-08de3ee0e185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2c5SzNFRUIxRDlzdnVjRlNuRGZqeG5ITzBvRmRCblBLcWsvd1l3TUhIejZN?=
 =?utf-8?B?SGZST2J2N2RhSm1QeHFkWTdtamYyQVNocEZiNjV5eTI2UWltcitKeHN2TTJi?=
 =?utf-8?B?Wmt6U0phSndBZHhOS294N3lySmNwMHZNVk9ab0hEZHF1dDg5WFcwWUlvd3Er?=
 =?utf-8?B?K3JGNzBSZWNUODRyUnczd1AwK3hKcUcxNjU2QkUyMzNIRlMvLzFPYm5uZUI5?=
 =?utf-8?B?M2s4YngyL0xkRGNOTndOc2lGelBhNExtRmxTcSt2dWN1c3Z0VGlkRnlTOS9i?=
 =?utf-8?B?YjR0QTNXK3BlcTUwMld0WExzV3VZYUQwR1VML1I1b3VzVS9XSjVjSllIeFZk?=
 =?utf-8?B?NVZycDkyanYrcW1EMHN2d3BrOXZ6bVRMNVVNN2FhNTQ4eFZYSjc1dDRNRFRQ?=
 =?utf-8?B?QnhSS2NVMW1VYnRLQ3ArYUxHZnN1aVZiaStIcXZ1OXFRa0lIUDRtNzVjUkpa?=
 =?utf-8?B?ak40c0NjZk10Y2duam81K0o5OW1EZFpDQUhFN2sxWFVUWmUxKzVPOEdZRW9a?=
 =?utf-8?B?emRsLy8wTjczSmh5N2EyYzZRK0oyZDU3TmVrNStkSjhDSWIxcUhQL25yQzdk?=
 =?utf-8?B?Vzk4UXV6NVRTK3M0eXVKanJUQ1VvbnNIR1BjUmxjalZFd2EyeU9BVlRFMGNl?=
 =?utf-8?B?T3RpWlgxN0Y3NlV3VlNrd20rdFRCT0VLWHBzOHh4TzVGYkJ2d2RIQk5TeTZI?=
 =?utf-8?B?M2N3SHk1OGRIUHNoVlM3bEFtUThMbUc4cXAyVzRhVXk1QjA1WU5RTlpaOW51?=
 =?utf-8?B?d1N0UXpRajFQaVBNc2lFODVaNGJIckpvVHBqdHhDVWpLS2ZKTUpIVEFhSzNh?=
 =?utf-8?B?N0RJNDJkeFhNV21NSjArUzRaNkE3WjFSam5lREFaZDl6SmM1YlZXdDFEZVlq?=
 =?utf-8?B?L1grK1dsenl6S01YSWtpc1U0MTRRVzV1c3oxZGlpMWRiMEhrUVliTGtxWU4v?=
 =?utf-8?B?WGpsSXQvdmtaUFR6YWVSbDF3N01HYWppZzBQT1FhRHc1WGxQN2Z4VCtZbGRv?=
 =?utf-8?B?dnB6QVdpZi9od0ZxN24vRStiMnRCWHN4SkJkTnptSGNtTzhiaUtqbVlZcjNr?=
 =?utf-8?B?dFJ1VkhlbWxvdTlia20rME1tREM2dVRMMTRmZGJER2Y3bzdvbzl3S2NtV1Bi?=
 =?utf-8?B?MFJwUWczWDVvRk11Q2pXd2Rpd3N5bjhDUDBweWE0dFF4ZmRpTEhHbTZCUHk1?=
 =?utf-8?B?WXFjZVhLVGhmVDRCWlBqQmpmeVJxVUs2WkE3Um1EWjlkeG56TllHdm9DYjdU?=
 =?utf-8?B?RVVVbjg0amJEUFh0NEVTRFo2RjdKZG54RDJlVGpEN2JRS0xGSjhKM0RWcEdu?=
 =?utf-8?B?Zmk4U3ZEOThhZGRzVmhaWGszZ01oalpJT0tuQ2dSb2RFeTYzUUxTMVZhYTNJ?=
 =?utf-8?B?LzJMcGptb05BUE5ubW8rRXlTSEZDcGFaaEUwSTM3OERLaURzbk55TS84eE9W?=
 =?utf-8?B?NkVONDNRUllpeEZ5bkhFcndaZ2JRZHhjMFpXWlEzZG4zRWhqd0psVFlmMFcz?=
 =?utf-8?B?aEpaRk9pT1pQck96VG1LejF1Yks1dlJPcExpRGF2MXA0bXQvRXVZVW1iUEEv?=
 =?utf-8?B?UGoraEsrOGVFREtObEdzRFQvRUVmL3FKYm5mZlJ0elE4U3hjeDBTdjRLNk53?=
 =?utf-8?B?ZS8vZkI0WjU4RHZhR2d4VGY1bWR0ZFltNjhxUnRCNTZZYlRrSUdrTDlhaWdz?=
 =?utf-8?B?cUpPYWRVMm9aZHhKelFHTzZXOHJ6L2tqWGY5UUdWd2xoSFg1dW5weEVxcG0x?=
 =?utf-8?B?dkFVYjZLcGJpb0pGZGJtZy91RUQrd3BnblZocERlanBRR3RSSElNbXJoamFF?=
 =?utf-8?B?QTdvM0NlVnBOVE9LVXdYTGozbTdBWUJrQ3BaS2ZNU2NWTHBrenBzSFl6V2JO?=
 =?utf-8?B?WTBFWXVuN0VOL3FReGtETW5EQ0sxT1FmeStkUVZpTFNDUG9BNDNvQTVOYXZ2?=
 =?utf-8?Q?VWhrxMow+35quNZVN5MX/BPpH15j1Dpk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFUxVUN0cURqUXM4di9zMGZhWGt1SU4rNTF1YlZaWWpNRDFZTXpNcnp5ZzY3?=
 =?utf-8?B?M2tGVkZWSndnYUpXOTNLNFJoekp4OHlObm8xNndoL0VKY1FnT0oxZ1crNU9y?=
 =?utf-8?B?TzdEQjFsekhlQUxvazI4VjU0aks4amhUdjNNNWpiWjRxdkdjTkcyNEFuM1VU?=
 =?utf-8?B?bXVNeC8zbGI2c2ZvZnF6OHpYbEREVnprNFlaWTd3NTl1R2JtSktUQ3VFdWg3?=
 =?utf-8?B?VXZ1SXBBZWx5cHpDMnV4Ym1LZXBabk1CV1RwMTQ2R0UrNGR4U3BQNG5OTVYx?=
 =?utf-8?B?elBsT1NsNmlOMFlXeWhIdlNEaUZYWmtoTkV6dXRtRWhpQ2twWVdpQ1AyN3Fj?=
 =?utf-8?B?c2IvSlhoTERMdU8yTjA2d3BLSHlEb2tTdFprdW5wYm9zVlBXdGRYUEJ5dW1Y?=
 =?utf-8?B?a3V3TkJwaWk0aE1wbE1hSk51UlpvV2MxTXRqT1FFWFFxTTBxaGRNTmp1RW01?=
 =?utf-8?B?bUkrWFNuVWhHMkRRa3N6KzVGQ0wrZXdhVDc0cFF6QWpZOVRCcEEyMjlLRjRa?=
 =?utf-8?B?Z1B4U2RvVjhWVnY3b2hyaUM0S3BsTWZsTm55R1U0V2tmQVo4QmRQMTRVS1Vk?=
 =?utf-8?B?Mlc1Sk9WQkxRMnYxb3psd2trZGJPendaOHRsTEJzMkRJM1hHdkhISEJaNFgx?=
 =?utf-8?B?OGtvcmozODFhR2VrRWN0S1RTc3EwVm50TWdrMGZ0Y3BLUzluSmM3S1EvaWxT?=
 =?utf-8?B?dmczQjhDb3VwZkZQNFk1NUJPZ0Q2bG9RcGk4dG95MncvaDB3QXZIK2ExeUFn?=
 =?utf-8?B?ODJ2QTdNRXdadUlmaFhIV3hJZmJPVkVUak1lcUV3M0wyN1ZYTUZ1ZFNLOU1S?=
 =?utf-8?B?MDNHdG53K3JVWEhXRHQ5Y3hiWXJab21nbllqSFIyZkhDd3M2RUQ5cm9ObGQr?=
 =?utf-8?B?QkFXd1FwcjZkczFRdFpzY0RrbHp4eU1jU3B6RzJ5eFFTVmwxc2Y0emltd2No?=
 =?utf-8?B?SmZRbTVBWC9Rdzl3NUtDSHBwT3ZNUmxIdWw5K0Q5bEZaUEJhV2F1Z2NFK2hG?=
 =?utf-8?B?V0xtM050UGRRNm5ENEpJdFI2bjRpbnBlN2oxZG44THRuVXBkR05VV2ZxL3VI?=
 =?utf-8?B?VzlCeGFsZzQvblE2cm5SL3Y3UDNXWEFDY0lHQXI2OUVTZkgwS0xqNHdaT0o0?=
 =?utf-8?B?TEtIdDhXSWtBOEdiWEZZTk1Td251QVVReHlzRkJRMForWGkxRGdFT0tXdTFM?=
 =?utf-8?B?bGRjMUhrQkliejFPZmp6YXladFN5TWdlblUrSjh0TE1URFRuTWt6SnNxbHpi?=
 =?utf-8?B?RWhLTloxKytQTUpHRVNTS3dhYmt2eWpOTDdueERLclN2bXo0SzNHZFdaM09P?=
 =?utf-8?B?TmZ5ZzJ3N3pKQkh5MW1rc2xWZTlXS3JlTWZ4V3dyYWgyTEJaUVZ5dkZWMSs5?=
 =?utf-8?B?dTlCc2M5VnlaZU9DeUFVMWhyVk9VRHlVM1ptN2pxSkoxK3lPOEpjL3ZjanZy?=
 =?utf-8?B?L0JUbVQ5bUhLSVgrbHZ6TjhuOEpqOFkzMWlEeGd2U1Y3NElSNDhydXlsNXFM?=
 =?utf-8?B?NVJ2dTYxOU1sRDNER0dBWW45c2U1UlhPWUJNbFVZZjljQ3RZZGJNMHcvTVFW?=
 =?utf-8?B?c1RYcWtQWnpHdG8wTks0eG1SN1NjMFN4OS9ZelJGVkxjVGx2b3FweDV2SXZW?=
 =?utf-8?B?USthNUNFT25sYy9pTEVDQ29RaHN3bVMvc29OcGF0YnUzQ2RkK2FNUXJNNWdQ?=
 =?utf-8?B?UWFKN1l6VWVDeW1pNTRXY3ZCbWJ6VE42Mk90aDk4Q0ZFNHdJMXNIVndnRHZz?=
 =?utf-8?B?U25MYkJJZFdQbXhhajVBbTM4aHBWVXlNR29qMkE1ZERIK0NzbXhaSXdzNDl0?=
 =?utf-8?B?OEJ2QTd3Z1ZrSlBPSVhnakEzMzk0KzFOSzVzYUdTM1NNaXhOZVZ3UTB3bWIz?=
 =?utf-8?B?SEY2ZVIrNmtRWVM2R3ZmblJVQ1FKR1RRZmVSZm1UVmFwTkM1blJ3VERhRmVS?=
 =?utf-8?B?Z1B5Q3NzQWJ1V1dQZHJ2RnR1RDFXZ0c1aE5hR0xvRWwwRDE1VUg0eEFmUDM4?=
 =?utf-8?B?KzBrdDhGNGMxT2VYejlhVGtRdCtVdTJUKy9nNG9pSDFHQW43OTY4Y3hrTDNl?=
 =?utf-8?B?eVZiNzdTMkkrVGo2UEdCUThjK3BvK3pCT2NCVHRCNi9sWmlTU1JkL2lFWUhk?=
 =?utf-8?Q?fLu8GHXhYbn8GBtg5VFm5Xza3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2214dd1-c3f9-463c-47f5-08de3ee0e185
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 09:27:51.1826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BX9hEfOgm6PeAGVqUHBB7SAwJ0Ya+7RpjdTt7ceaBUGwr/cmTFuWsVFKC67sFcAT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397
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

On 12/19/25 10:08, Tvrtko Ursulin wrote:
> 
> On 19/12/2025 07:57, Christian König wrote:
>> On 12/18/25 16:04, Tvrtko Ursulin wrote:
>>> IDR is deprecated so let's replace it with xarray.
>>>
>>> Conversion is mostly 1:1 apart from AMDGPU_BO_LIST_OP_UPDATE which was
>>> implemented with idr_replace, and has now been replaced with a sequence of
>>> xa_load and xa_cmpxchg. Should userspace attempt multi-threaded update
>>> operations on the same handle it could theoretically hit a new -ENOENT
>>> path. But I believe this is purely theoretical and still safe.
>>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 72 ++++++++++-----------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     | 11 ++--
>>>   4 files changed, 41 insertions(+), 48 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 9f9774f58ce1..0a5b802bd3c3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -50,6 +50,7 @@
>>>   #include <linux/hashtable.h>
>>>   #include <linux/dma-fence.h>
>>>   #include <linux/pci.h>
>>> +#include <linux/xarray.h>
>>>     #include <drm/ttm/ttm_bo.h>
>>>   #include <drm/ttm/ttm_placement.h>
>>> @@ -500,8 +501,7 @@ struct amdgpu_fpriv {
>>>       struct amdgpu_bo_va    *prt_va;
>>>       struct amdgpu_bo_va    *csa_va;
>>>       struct amdgpu_bo_va    *seq64_va;
>>> -    struct mutex        bo_list_lock;
>>> -    struct idr        bo_list_handles;
>>> +    struct xarray        bo_list_handles;
>>>       struct amdgpu_ctx_mgr    ctx_mgr;
>>>       struct amdgpu_userq_mgr    userq_mgr;
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>>> index 66fb37b64388..628d32fd2fae 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>>> @@ -149,31 +149,20 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
>>>     }
>>>   -static void amdgpu_bo_list_destroy(struct amdgpu_fpriv *fpriv, int id)
>>> -{
>>> -    struct amdgpu_bo_list *list;
>>> -
>>> -    mutex_lock(&fpriv->bo_list_lock);
>>> -    list = idr_remove(&fpriv->bo_list_handles, id);
>>> -    mutex_unlock(&fpriv->bo_list_lock);
>>> -    if (list)
>>> -        kref_put(&list->refcount, amdgpu_bo_list_free);
>>> -}
>>> -
>>> -int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, int id,
>>> +int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id,
>>>                  struct amdgpu_bo_list **result)
>>>   {
>>> -    rcu_read_lock();
>>> -    *result = idr_find(&fpriv->bo_list_handles, id);
>>> +    struct amdgpu_bo_list *list;
>>>   -    if (*result && kref_get_unless_zero(&(*result)->refcount)) {
>>> -        rcu_read_unlock();
>>> -        return 0;
>>> -    }
>>> +    xa_lock(&fpriv->bo_list_handles);
>>> +    list = xa_load(&fpriv->bo_list_handles, id);
>>> +    if (list && !kref_get_unless_zero(&list->refcount))
>>> +        list = NULL;
>>
>> Since you have this protected by xa_lock() now you don't need the kref_get_unless_zero() any more and can also drop the RCU handling in amdgpu_bo_list_free().
>>
>> Alternatively stop using xa_lock() and use the RCU read side lock instead, but I clearly prefer this approach here.
> 
> True, ok.
> 
>>
>> Apart from that looks good to me.
> 
> Btw what about the bo_list_mutex? CS parsing looks to be read only with respect to the bo_list so what it is protecting?

Oh, yeah good point. That one is superflous now as well.

Previously the entries in the BO list where ttm execution manager entries linked in a double linked list.

But that was replaced with drm_exec(), so everything should be read only now.

Regards,
Christian.

> 
> Regards,
> 
> Tvrtko
> 
>>> +    xa_unlock(&fpriv->bo_list_handles);
>>>   -    rcu_read_unlock();
>>> -    *result = NULL;
>>> -    return -ENOENT;
>>> +    *result = list;
>>> +
>>> +    return list ? 0 : -ENOENT;
>>>   }
>>>     void amdgpu_bo_list_put(struct amdgpu_bo_list *list)
>>> @@ -219,12 +208,12 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
>>>   int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>>>                   struct drm_file *filp)
>>>   {
>>> -    struct amdgpu_device *adev = drm_to_adev(dev);
>>>       struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>> -    union drm_amdgpu_bo_list *args = data;
>>> -    uint32_t handle = args->in.list_handle;
>>> +    struct amdgpu_device *adev = drm_to_adev(dev);
>>>       struct drm_amdgpu_bo_list_entry *info = NULL;
>>> -    struct amdgpu_bo_list *list, *old;
>>> +    struct amdgpu_bo_list *list, *prev, *curr;
>>> +    uint32_t handle = args->in.list_handle;
>>> +    union drm_amdgpu_bo_list *args = data;
>>>       int r;
>>>         r = amdgpu_bo_create_list_entry_array(&args->in, &info);
>>> @@ -238,19 +227,19 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>>>           if (r)
>>>               goto error_free;
>>>   -        mutex_lock(&fpriv->bo_list_lock);
>>> -        r = idr_alloc(&fpriv->bo_list_handles, list, 1, 0, GFP_KERNEL);
>>> -        mutex_unlock(&fpriv->bo_list_lock);
>>> -        if (r < 0) {
>>> +        r = xa_alloc(&fpriv->bo_list_handles, &handle, list,
>>> +                 xa_limit_32b, GFP_KERNEL);
>>> +        if (r)
>>>               goto error_put_list;
>>> -        }
>>>   -        handle = r;
>>>           break;
>>>         case AMDGPU_BO_LIST_OP_DESTROY:
>>> -        amdgpu_bo_list_destroy(fpriv, handle);
>>> +        list = xa_erase(&fpriv->bo_list_handles, handle);
>>> +        if (list)
>>> +            amdgpu_bo_list_put(list);
>>>           handle = 0;
>>> +
>>>           break;
>>>         case AMDGPU_BO_LIST_OP_UPDATE:
>>> @@ -259,16 +248,23 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>>>           if (r)
>>>               goto error_free;
>>>   -        mutex_lock(&fpriv->bo_list_lock);
>>> -        old = idr_replace(&fpriv->bo_list_handles, list, handle);
>>> -        mutex_unlock(&fpriv->bo_list_lock);
>>> +        curr = xa_load(&fpriv->bo_list_handles, handle);
>>> +        if (!curr) {
>>> +            r = -ENOENT;
>>> +            goto error_put_list;
>>> +        }
>>>   -        if (IS_ERR(old)) {
>>> -            r = PTR_ERR(old);
>>> +        prev = xa_cmpxchg(&fpriv->bo_list_handles, handle, curr, list,
>>> +                  GFP_KERNEL);
>>> +        if (xa_is_err(prev)) {
>>> +            r = xa_err(prev);
>>> +            goto error_put_list;
>>> +        } else if (prev != curr) {
>>> +            r = -ENOENT;
>>>               goto error_put_list;
>>>           }
>>>   -        amdgpu_bo_list_put(old);
>>> +        amdgpu_bo_list_put(curr);
>>>           break;
>>>         default:
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
>>> index 2b5e7c46a39d..0989f1090c63 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
>>> @@ -58,7 +58,7 @@ struct amdgpu_bo_list {
>>>       struct amdgpu_bo_list_entry entries[] __counted_by(num_entries);
>>>   };
>>>   -int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, int id,
>>> +int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id,
>>>                  struct amdgpu_bo_list **result);
>>>   void amdgpu_bo_list_put(struct amdgpu_bo_list *list);
>>>   int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> index 6ee77f431d56..88f104041157 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> @@ -1445,8 +1445,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>>>       if (r)
>>>           goto error_vm;
>>>   -    mutex_init(&fpriv->bo_list_lock);
>>> -    idr_init_base(&fpriv->bo_list_handles, 1);
>>> +    xa_init_flags(&fpriv->bo_list_handles, XA_FLAGS_ALLOC1);
>>>         r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, file_priv, adev);
>>>       if (r)
>>> @@ -1492,8 +1491,8 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>>>       struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
>>>       struct amdgpu_bo_list *list;
>>>       struct amdgpu_bo *pd;
>>> +    unsigned long handle;
>>>       u32 pasid;
>>> -    int handle;
>>>         if (!fpriv)
>>>           return;
>>> @@ -1529,11 +1528,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>>>           amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
>>>       amdgpu_bo_unref(&pd);
>>>   -    idr_for_each_entry(&fpriv->bo_list_handles, list, handle)
>>> +    xa_for_each(&fpriv->bo_list_handles, handle, list)
>>>           amdgpu_bo_list_put(list);
>>> -
>>> -    idr_destroy(&fpriv->bo_list_handles);
>>> -    mutex_destroy(&fpriv->bo_list_lock);
>>> +    xa_destroy(&fpriv->bo_list_handles);
>>>         kfree(fpriv);
>>>       file_priv->driver_priv = NULL;
>>
> 

