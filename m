Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FECD44C48
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jan 2026 13:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A71310E763;
	Thu, 15 Jan 2026 13:52:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="05ytksI3";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012064.outbound.protection.outlook.com [52.101.48.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD17010E763
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jan 2026 13:52:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GiEvAaYd7rvJ68qYYCBKMveEOSaQmUp6rT03GiY3qlzx5+TyK6YrdvHU/tqIjzb75uMKl1BpSluh3Di8o3ImmuaVKbC9w4CdoptiN0b+JaME+oa9g/LK+l8E5PvW2sd9EAvQFOocAgCLFb06CBdMwinOyMszoK4wBDQ1GmQ3k/4Hez3Ltep2Qfd0WaDTDiWxVgDTP/WAq69HyRgIeMmIuuS+LK0Fkq7PfFCofEBUjOgCP8MN9khuOtuG+vji1Uqc4Qz/SItTMkVFXYFnNdXjn74yW1YEKth+SxrNByUAvu96pB8PL85bHtFfLkms5ps2CX+pWojSz35+62fwzOjfnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auoyTyX+ekO2nyb9xS+XOWyL6jQ/7A3jgwDZtPYUSnE=;
 b=Fg9KGrlzN8I4qpC/8VYq2hNxCpv8y/XNKzuKzsbY9ikiSAWb0GIUEPxF7sJ4DZC5L3OSPUrl2LKueVwi9D/hlffidMiDIVSRzqEG0tk72i//RHmA7P8Z2KM+k9nlQgF0E8zv+xjpRplbNXqLkiSoFR1OHyyP8AzQZuvEVeNDQC9eEfFDgXBzMbY/lDlUJYHKN1ZVUSDQCduifLUNJzLOyzD3oZ8MhrnQqNGd0B22zq48v2ttp7JsDnSvngkR39RA5N912O4Ti7wC9tR0Ra2a9H4WAC8vwxyZNCC6LjFwB1jJKUbAji1cjvE0uinKMo7SKOzrVjQkUIr5E5kTDdhHXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auoyTyX+ekO2nyb9xS+XOWyL6jQ/7A3jgwDZtPYUSnE=;
 b=05ytksI3nK3E/bBbG+z084JVN0PdQeSZP1IQF1VP35/+Ur/DH3KaNyRZRIHetCp6nXy87gIsyZh2Z5xdPtTrTOfgBOFyNVb6JxrlYjVr/4lHhlQCC6kGGlCAyEqceteeHwjL5xrJBvQoBhIDw+KGUioOz1IRLcW9ZZ7VQxjDOIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 13:52:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 13:52:15 +0000
Message-ID: <a5a828cb-0e4a-41f0-94c3-df31e5ddad52@amd.com>
Date: Thu, 15 Jan 2026 14:52:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] drm/amdgpu: free hw_vm_fence when fail in
 amdgpu_job_alloc
To: Jiqian Chen <Jiqian.Chen@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Huang Rui <ray.huang@amd.com>
References: <20260115025548.621264-1-Jiqian.Chen@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260115025548.621264-1-Jiqian.Chen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf525e2-d5e7-4c52-27da-08de543d4a31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlVKZ3kwVFVtNmM1RkdPcDBDY2laVzJuTWpYK0hHbXVQZGQwWEZBR1duZzk0?=
 =?utf-8?B?TnhVK081QkNqR0piQWRRcXlLK2srUGQwL1NXZ3JDalp4WkhRQVpacW1Wa1lG?=
 =?utf-8?B?VEx4aHdQNWhvZEgvYVJEQlFUbGFKU0NXSXJLV3lWNEhUenRhN3NJcXk4QUtY?=
 =?utf-8?B?M1R1QmNHNkZ3bEFkYSs1djVrdU5rNExHWHcvSFpjSm5LUXFjaFAyZXZwaXg4?=
 =?utf-8?B?UDJBQXNlSWREYXUvdHpoMG54b24veVVoWWprWXlKdDRlVm5IZ0ZDTy9HZ2lu?=
 =?utf-8?B?NnpFNW5lS24rZ284Zzhzc3pFQnEzcVZnRzc5WkhaZW96bXRITXZGRUIwbzFP?=
 =?utf-8?B?Y0lqT0RudytZL0tXdnI0Q094cWlwTllsS05XOXdib1pRVS96OG5KT01Sa3Js?=
 =?utf-8?B?WkVPd0phSU9hODlVcndvejZFY0JSMDM1MTJuS0x2U3Q5OWJWdGVzTFVLWndj?=
 =?utf-8?B?OHhPWE5iMlBwUjF5T1Nod09abVhzSmsrR09IUmMrUjhzT3JnMjlBRDMxYytH?=
 =?utf-8?B?UmJFZnd5U0p3WmFDT3FRSXBuUFlZVlhmWXN1V2FUZmNUVnhrZ0hObW5NUVhn?=
 =?utf-8?B?clN1MDU2dGYvUDRaMnZNV0pwK0dTMFVJMDFyK0owMnRwQXdXdjQ4U3V0SzVm?=
 =?utf-8?B?OG4vbUJSOE1FbUh2TkZDMitsS1pLbGtRVUhZb3M4VGtHUUFjTmJjUzZhYXlJ?=
 =?utf-8?B?RGFlY1ZSUnV1WVgwaTkrWm9qc2g1UllBWFJVNzFmRGluYlFIa29BalhkUFNG?=
 =?utf-8?B?Y01vTFJ0SmFkbnFpZ3lNZkVPT0swS2RVR25ra2VMYlZ2NEh2VldEemFoN1Zx?=
 =?utf-8?B?SzJTNWsxa2pFQVBCaXIraDVPQVlhbzBOa2hWWGxzRTVENlIvbWVYVWhER0E2?=
 =?utf-8?B?RGI4Mm0zdUVVU0paaVNza1ZRS2hjOHo2TFZ2RmVUWWJjZWFkVUp3S2RXanpC?=
 =?utf-8?B?TDNSQTJvbjkwSlZhTlo1TEw2aEhnSlZrVXRENmMvZkQ3SmhXTFNHSXhQdjBo?=
 =?utf-8?B?K0xFcW51K0NnZkt6bjFZeGpQMTl1YmJOcklnV0FTekVINTJGSFpGb0M2dGpF?=
 =?utf-8?B?VUsxckJyTzgwdENoQmlQWlZzT0dJRXFYaDVlbVBUdFg4V3FOQWhsQ3FYRUwv?=
 =?utf-8?B?ZFZmd3lUSmc2NmhvZEhkL09uQk4zWG1PUHZMOGZPRWJCZEQ4bWxjVERoU0Rp?=
 =?utf-8?B?QzBsL2IvYjVETUxEV1EyYm42RG84NGkxcTBhd2R5QUtoQ2ZTRVpGQXFDT25h?=
 =?utf-8?B?bmJoWk1CU3pJVmFQOHhKVElLbWxBUW9DcjVRRjdQUVN6alBVU0RMT3d6RlAv?=
 =?utf-8?B?OE9uRktHMGIvTUJFbE9MbXVxbTRZb0pNS09aVWNPSHJKczYvQW5udGJFMmRH?=
 =?utf-8?B?WFkwYXJuaW5nN21MVE92em1XWXUySkpYZnZ1UWhreXFuTEhKTnRUalEzakdC?=
 =?utf-8?B?MWpaWHUvbS90UUFQYjZwakRMakxPSWFYaWJkNjdURGRuQjFpOUZqZGlNRVhq?=
 =?utf-8?B?TlpweVpTNENxanJsd1o2WmZvQTNyS2JqQi8wcDRmRmcyNzY2bnF1RldHL080?=
 =?utf-8?B?Q1RXREdJMExGMjdmTkQ2V3ViRFF0Vmt6a05HL0txM0tmVzFTbEI5d2pNVGM5?=
 =?utf-8?B?d2hRR0ZXOFpZaHE0dEp2U3dyeWRGN1dYZHlKK2pSSmJNRWY1ZllkWU14Q0RS?=
 =?utf-8?B?dUFkbEZLV2ZZc2V6TjRETjVvMEhYK3lhRUZjNjkva3JPYzJ2K1dLN0I3a2ZB?=
 =?utf-8?B?bWkySlVYRmx5Z2ZjZ0NoTzJUeHpzZnZCdFY3b2RoK0pha0hDZ1hKb2NGVGFD?=
 =?utf-8?B?Yzc2cXlCalE0YmhzK2w4ZzVveFBvOTRQWnJBV3FMYUNaMnJLakdzeld2bGJF?=
 =?utf-8?B?WTlydnRZSTJIN2Zjc0JOQTQvZ2FDQTNwT3Q5b3E1RnVneTVtMjN0UHVKWlJV?=
 =?utf-8?B?cktQVXA3SzIyeFFzcVpJYmpSVGdrOEJ1NFVINENFUVhLTG4rNFlKVHp5VHNN?=
 =?utf-8?B?b3JWNklvc051SkZra0o0b3NZU2Z4YXRyRWFDVXdJcTZDL0RicVJCZTYyTEQ3?=
 =?utf-8?B?dzRDOFRLaW1tNTIxaTZkODlEOVV1cTVpMDJtUU5QeGxoeDZUZ0RqM1J2UGxq?=
 =?utf-8?Q?4W0E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzA2M1k0S0tRZ096dFNObEVOajJwRThKbnViQVowbms4SXRvL2JxeWxCTXFX?=
 =?utf-8?B?TFBYUzczVXBzd3NXc2JyT011MXdnbDNWR1NTVHNZTkpFTldVUHE0RGVJUW13?=
 =?utf-8?B?bzJxejhxbGxKVk1Sc2tacFVPdm1SNjlKR21KanpZVFE0T1JxN2JaOWVKWFBW?=
 =?utf-8?B?WVdoRVJIQWRVd0VIMTZieFdyWFNVQUpiekhVTjBQbUhFM0t4b0FVT056M2wr?=
 =?utf-8?B?dGwvVy9Yd3MxOVNMcWd2akNqYVFnbVp2QXF0WVZkKzZJdWd2aUQxaWRwZTBQ?=
 =?utf-8?B?eU0ycElxeTk4bURrR2I1WkU2YnlFaXAxZHJUTCtEWFdOQzQvZGxRK25xcldD?=
 =?utf-8?B?dU9VVmx6d05kd3hXQ1ArczI5a2JxalNZdkx4S1RvNzlNVWlvQVNmQXZ1dlJD?=
 =?utf-8?B?SDF1cG1oOTlRcHp0NEtYVmlPR0t6ZWgraDUyUDR4SHpwNms4bCtpSnBvcUtB?=
 =?utf-8?B?Vm9sTU9rbDhvM0k2TEZqaThXTXB3d3Y2R29hRzluRlBQZ2xyZldBTGEwdkFE?=
 =?utf-8?B?V1dCNnJRaURzaGgwaThYN0hnL0lJN0p6RWRsRXM1SEpKbEVBRy9UcWZ5UWUr?=
 =?utf-8?B?Z29kRkFYdHdMUHBQNk85SGJwR0txOHR4eEhHZFpobnlmbmF5RVdIZFprbVpJ?=
 =?utf-8?B?RU9QU3JYTk1CYkM1Ny9OTVR0OHl2cGRSVHprTzcvL1c0dnNQZzRibWhIdlU5?=
 =?utf-8?B?Tjc5bC9xTENobjJ6ZzdEQi9TRjljdC9iRG8veGhtdmJ0NjlVdHd6UFpqTVRl?=
 =?utf-8?B?QUVyTEVQZ1piOGRpWEtpVlpid0dQbHFacFdWUWpnUWsweGF5WlNMNUNrMW02?=
 =?utf-8?B?QlM1SWdQRzJsNGRqZ1h2UlFIZlJhUGkrZ2dielZYWi9PcEt0MmxTc0dvVTFY?=
 =?utf-8?B?THJpRDF0eWFvZVFmOXpLaksydzZmditWNlM2U0VsQzNtT0dqdCtZZUc4d0Fu?=
 =?utf-8?B?ZEovRVQxaVZHNTc4amtUdnNMVzZ5UjdQeTlCbTB1YW00VzRBWFJiNzhnWSsy?=
 =?utf-8?B?Z0JIREJYellNMGFQNUl4c3JhRTVtZFRoaXp2c0FsS0dZMHg0UTgrNkV6R0g1?=
 =?utf-8?B?WlM3MkR2eUpuRG9vRk96QzMvUEVFcllyVkxmVHpVUmt2SEd6a2s1eGR0VjFZ?=
 =?utf-8?B?bi9yZ3J6RFVCZll6ZlkrU28wZFlyN0ZjazRDMkJzeXRyL0dKdzBHNXJBcVVL?=
 =?utf-8?B?c3VCTUlrM2ZlU281QmoyZ0hxMDQrbVowVDQySkg4c1gxTHlTMW4xeThFTG5W?=
 =?utf-8?B?Njh1bXhnbElva2tNbzMzQmFBdllRUWpNSG9BZnYwTmVLc3JQcHZUbTBQS2RT?=
 =?utf-8?B?TFJabHB5WDM0WEhLTG94RW5ybWxPOFJNb1FWeXlJZ2xpcFJnMHFxR0JVa3V6?=
 =?utf-8?B?ZHNEakFZMGJXOGVrcWl0bitWbWhORTQzL3JNdXVYRzlzcTAzbHlUUVVyNlpV?=
 =?utf-8?B?Wk44Q3NPN0tkeFd3SmJVN24vQWxFSlFFRXhaV1k0c21GNjhOQVVwK3NWOStq?=
 =?utf-8?B?ZHhtVDlEZFM5OXBQYjdpZEptRk5TdFBZTVRONkUzRnFpU2xuTlZabUV3QlFO?=
 =?utf-8?B?ZFdsYWlzQ3Z3eC9hRHI5RXBsMk02bHJwNnNsOXM1SXd3Tno2anpUeVJaVmtF?=
 =?utf-8?B?SGRBVzdDL3BuWXIzSFp0SUNFM0JYMmxiOGtOL1dGK0N5bVczMFZia1A5YW41?=
 =?utf-8?B?em4rMFNmbEZDMmtaVjRFOWhTWjNhcEx5WGpjK2NyNDMxUU9EMmZQZjdsemNS?=
 =?utf-8?B?V2VraHNDa1FMeDIwRXFSaUxoaGdoY0FzZmI0NGFvZ3VLTmorYzVxTlJ1UnVT?=
 =?utf-8?B?ZlZaZUhCTmY5OXNmdWRPTnZ0ZjhNZW54NnlnV0hDNWc3WXp3bzhISncwTWJN?=
 =?utf-8?B?WDVmblZFUUN0ZVgwT05hZXprRmNRMEF2Nm1YTmRLUmVqY3lDa291QU1wb3hj?=
 =?utf-8?B?TldWb1JEQzNZeHpHMHJXWVlZR2xOekIwMnFKM0NGN2h4eGtBQkxpNklLZ1Vv?=
 =?utf-8?B?T3djTzZRSksrZWtrVDFoUXFza1FoUDUvR1VnZlgvSWFFRmZ1WmNIZm85TEJQ?=
 =?utf-8?B?WUp0WC94WDB5a1JpaTNEeXBmZ1Nqb3ErRVdzNy9WNmUzRjBNbVNRbE54MnJ0?=
 =?utf-8?B?N29leWhqSlR1WDN5ajhnSHFWQUI1K3cvNE84RW1HN0VjYmQ1b1RlaDBZRkZI?=
 =?utf-8?B?VzhNclJJdUx5VUZYS3pFOVd4Tmpub0ducUFrRFZrY0FlRTdmZHp6c3FlSGVC?=
 =?utf-8?B?WVpzalFmTU5OQ3hyKzhhaVI4WUNqZ0Jvekc5RjlEL1h1VGZhS2x2Q1VHNWlQ?=
 =?utf-8?Q?RtupHz+YUSAuUV/aJj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf525e2-d5e7-4c52-27da-08de543d4a31
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 13:52:15.0679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QovqjUqDKd2xOFvPlcDeTBLkhmwjgDxiIqXOphbhINRQUBUZ+ImBSFYe0YVLYEjj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172
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

On 1/15/26 03:55, Jiqian Chen wrote:
> If drm_sched_job_init fails, hw_vm_fence is not freed currently,
> then cause memory leak.
> 
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> v1->v2 changes:
> * assign the return code of drm_sched_job_init and check that instead.

That's actually v3.

In general we keep the change log in the commit message for amdgpu changes, but doesn't really matter for such a trivial change.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 7f5d01164897..1daa9145b217 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -219,8 +219,11 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (!entity)
>  		return 0;
>  
> -	return drm_sched_job_init(&(*job)->base, entity, 1, owner,
> -				  drm_client_id);
> +	r = drm_sched_job_init(&(*job)->base, entity, 1, owner, drm_client_id);
> +	if (!r)
> +		return 0;
> +
> +	kfree((*job)->hw_vm_fence);
>  
>  err_fence:
>  	kfree((*job)->hw_fence);

