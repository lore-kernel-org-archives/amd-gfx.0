Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F678CCD199
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 23:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DCA310E021;
	Fri, 17 Oct 2025 23:17:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2DR8Z503";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010057.outbound.protection.outlook.com
 [52.101.193.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C2A410E317
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 23:17:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyYRM9QXxFHABVYBHTO726B/sb37pZw/AWB661HT8TgQy4kWpWRVMcSh+AFIzHd/xxlQV6QBItA8OsGsoXIBpNf1HiEQ7DWE9ZJrXHlYolseJPjqDKKnd/37P2bCgVoN8mZG93+tRU1J4DbukTTfQhmOdFX3ggMFIBVa7LVywfpvQRSZcdz4y6pW1AYAj0cVUhB7AKyxkJ38SyvOHMGqxaF6cGJ51/yjvwyRJBqQOGLYf/351NbHhKBrudGKyrw2/fSqpXz31hr/qLRmeFSdLz0kfWntFKSiwsyRKXcaIpr5Ka+S87GdaEV78Ub99EePT/OaBjWV8Rr0c6g2ACau3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIm1oZCmhYPTNlvL9QZP/FCfVQ0yy+IxXhJZXe9ENEc=;
 b=Bo6/J3N01hgO8KIsjMx4/jJZEd3mFDAtK+zcAklxMtazzKZTIr8Bl877SIUB8auqnaC4BlOiSURtDDyULzU9LIa3EX7gYy+f/g9SbM1nzV2JGLd75IZatpzqCe6ziZ7eITqLCucHIHh/Ll7TBEIevzR16x5MhcEznnYUJdfUixSfO217NeYexI3HK2XmHhakERk6GwblWap5Gnfu5UhZkec5s5u7ez3JbpOgNBJiooYylI90QgPV9c48JKf7VkzZYEKh0hDKiaiilBAtTq/bDr0xLO46c613cYq+kPNlRmTfcZsHfzmzVORQUvmHHeHdZeQgbA0mfQ6eXDXAoZE0qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIm1oZCmhYPTNlvL9QZP/FCfVQ0yy+IxXhJZXe9ENEc=;
 b=2DR8Z503YMv2R5/0vGMV/eWla0I99DLJODlMSW/pt96nms7GFIxTNBDWTF97pkjq7x/VERnUN9v5ta9+shkCSNnApo9wp3Uug1ROF793DgtlI2fABH4RloxusV4MO3ORvd2HoWzU68+Jx90V4JkfOszkOOp1c6npExuRyE5r8aI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB8714.namprd12.prod.outlook.com (2603:10b6:208:488::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 23:17:01 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9228.005; Fri, 17 Oct 2025
 23:17:01 +0000
Message-ID: <1a34e488-72b3-4974-8807-e10d8170b1de@amd.com>
Date: Fri, 17 Oct 2025 19:16:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 08/18] amdkfd: identify a secondary kfd process by its
 id
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20251017084222.54721-1-lingshan.zhu@amd.com>
 <20251017084222.54721-9-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20251017084222.54721-9-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB8714:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec833fe-08f3-4876-c687-08de0dd346a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWdDY0FyOHdJTkEwRW43cEdlVlhYYk83VU94MFdGdHAxTWdxMUFYWEJlTnRI?=
 =?utf-8?B?UDljZGpBUnZDZmg3by9xRGRyaldsTk9yZWd0Ni8yNW5QWGdubkxEUWJJMG9n?=
 =?utf-8?B?dnhoQWltN0F0RHpDT05lNEVUbEo2d1FiQTJkd2JmK1lweVVXMUZoQnRValNQ?=
 =?utf-8?B?TStpUXllMTFYbkJQbmlWc25RM2g0Y20xaXVIanpBeHZTZWV3am9sYzdRY1hu?=
 =?utf-8?B?K0MyelBVTnd1eVk0VEt6Wk1TY1NKdE5sUmVtbkt5L3QxTUlQeHJjZzZiajRT?=
 =?utf-8?B?d2RCYVllOUNUREZJdkowaWtJc2s5Z1ExWDVBdk4yZXBNSEIweUJkRkVoTDdP?=
 =?utf-8?B?K0ltT3hSQzZMdXJ0enhPTU03eCs2R0dNNmk3dGJsRVNCdnY1cFRmOThwN1pt?=
 =?utf-8?B?ajQydVgyUm1rSXdXbmZ2VDlGalVaMm9LV0x4a3M2TXRDN0hiSW5KQ2NRaFps?=
 =?utf-8?B?bWo3NHdzN1dYOTFKWjNBeENlczFyN29DZEE4OUhvdVFpZ2tCb3lnTjQvTVp0?=
 =?utf-8?B?bGNodVAvcnBrQUN6Y1VtVlVjaXRiSEV3UEt2SnZBYkMrOTN1Z29kdFlhQjZN?=
 =?utf-8?B?K2F4d3BVOTRUZDN2Ry84TEc1eXNwc1lvbHVEcEs0MWZ0dzBwM0h6aWZiMjlz?=
 =?utf-8?B?dzhzMFdHYkMrZnRaMVNCUUZoTmU4MzBsbExzdlVKdlZFMGlFSnhjb29ObkY5?=
 =?utf-8?B?WW1kTU5UWVdmcitkMStHdmpxSitSbzYyeHVpb0VIWFU1L3dPMHF0OUNveXdG?=
 =?utf-8?B?ZE10UHRta0FIeFFMT05MQmJZQWM1eXJtSXlIUFR1L3JWM3IwZC9DKzBIMWtv?=
 =?utf-8?B?Q01jOVhrTjZQcHFyNEdLU0RDdzN2MlVoQlhGa1RDK3pybnBKSmtEY1IzRXVy?=
 =?utf-8?B?bUQvUk4rNzRuMktoVEJnd0pTcWhiaVR5L3lCNjdURnFrTVZhc0NxbVppS1RK?=
 =?utf-8?B?T3JmdDNPNU1Nd1NZRitKM0pPUVBjN29Lb0xYTjY3WmVYbnZCUTFoL3hEK0Jw?=
 =?utf-8?B?YWdwSTN0L2xzdzRnQjJCY1JGL1RpQ3VVb2p2RzQwNjU2NDh2cHBJT2cwU0RF?=
 =?utf-8?B?RW05NFZmUnVub1d0YWpNTVhwOWlwQmxjYjA5VzZJUjZYT3ZmYjUzK2FERU5K?=
 =?utf-8?B?RGt6cHFVTXBtQzY1aWRPcGhMRzhYSy91WldKS21DR1l6RTM1TjhCRzJwcFE4?=
 =?utf-8?B?bW55NTRjbjVaZ240TlI5a205VHQvWGE5K1JRVUFxRWpaOVQxcVhrY25wajlB?=
 =?utf-8?B?UHRQQlJYNm9lN1RzaCs2c3licUFVKzJyNVRqUjBIRmNiQ2loV24xckovWThL?=
 =?utf-8?B?OGMxUEtIRlNYN0tWMVFPdXlnVyswMUlwSnI4S2JCa0tFK3hJanhZdFFVU1RT?=
 =?utf-8?B?VTlDcFQ4VTJxZmRhSUk4Mm9wNDJzSDY1YUYreTBPSzhNdXplbXdlZ2VVbXo2?=
 =?utf-8?B?aXZKZzVtbHhXaFhvMjdkemRsVWpSd0p2bFVxVjRWZGVJUnNrcm4xR0NGQUVU?=
 =?utf-8?B?Y1c0VmltR3NrdStKQkdBVTRZL21WdDE2a1p5NGZCUEhsdGRuRWpsTktqaWtW?=
 =?utf-8?B?eWdvWkt4SG5DZmdIaEpEeWpHV1RpVDBkVkR6cWlDR2tlQ0Z4ci9maktYbjln?=
 =?utf-8?B?RGtsYVlWQm5kWXNZQTh6aVhvNFk2S1pnM252YzBLOUFmVllWcVNkODBJQW1Q?=
 =?utf-8?B?cWRQbktTYmpQRUF5dXRuZERyOGlQSVBSSVhBYW9mK0VuaGYwNGszS0JVS0Fn?=
 =?utf-8?B?WWp2aWFpTU5TSTJLb2d2Z1ZNSStncTZ1d2NXT2l0WmZhc1ZnMjZaSi92cUVB?=
 =?utf-8?B?d0tKc2pzS2J6KzB1YTN6a2x0ODd2OGhTQlVuMWM3dmMwTG56TkxOWlpkczBI?=
 =?utf-8?B?Q0tlQzZKMGttaXRpR0hkVWJ3S3NudGRkbjlLRzNLV3ZwNk5yc0JHU1I0K1c1?=
 =?utf-8?Q?DUAxNrMiVlBZq9RjG+qIpZ9HyQ53C/mB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTNwMUt4QllraW5mTkpPQXA0N3BVKzRHaHM4bnNDTWg1aGNUZjFBbUJGaHVw?=
 =?utf-8?B?am80Y3hkaCs5ZW04dkx4ZUw4WUxGeXU1VmZFc1hVaU5WcXhXbU0zQ1cwcUJL?=
 =?utf-8?B?eGV2QzQ3dWxjTlR1MFhaSDJQS09HQVhUa01uZmFtUUx0b0hSTEFmWDhHZDN4?=
 =?utf-8?B?SzhSUkhJZ0lrbEpkU2ppV2NSalE5Y1NMaytHdGhycWpDZ3QzN0R5M3Z3clVl?=
 =?utf-8?B?Qyt3SGEwSlcrS2hhcU1KZDhUMGhNeWV0c2l1ODA2S2Zpc003bFNBMEt4clNM?=
 =?utf-8?B?dUV3VjVzUHduNVV2R0FaUCttRG9NWVp1clgzSzBRS3NVZml4bWlZWi9pLzVI?=
 =?utf-8?B?M1pBSGNPNVY2QkxMa25SYlkxSGF2eFIwWTAySHphQ0NFYnpVOU9qL25JNkRm?=
 =?utf-8?B?NUM4NUlFd2tWSWtKM1BRcnNKV0Q0S1RUYmZhcU4xaEhPZ1hBeGZnTG9RcHNV?=
 =?utf-8?B?R21qRkFrMTI5Ymg1QVFneG9IcHFIcjh1bndlU0Zwd2RHZGZETGhOZjhVVjhj?=
 =?utf-8?B?QVBWZDdYcnNhTUo2cVJ3R0pmNEZFTjlHRWxaRnZ4R2VMTFNSMHNGMlFDRGVB?=
 =?utf-8?B?dVhqc0tHVXhpOWxjWE9ueGlxRzVKZUtvSnBSTXROeVVweDF3THhESzE0clhy?=
 =?utf-8?B?ck1CbjczMGhaZzV0UjFobC9QRlk2ZVRBOEFzUHBKTHhYOXgwM3Byb3lJZGhY?=
 =?utf-8?B?S2RoSGVtMGRkV2pZZkpHMnFuSU1BNld2U09MSmZlU1g0dU9oMjgrT05CYkNl?=
 =?utf-8?B?V2p4b1lTeGpiYXk5bTZFdCtwdmFkV3JEU29aNGFyVE15WHp4bVV5SDJaVEVx?=
 =?utf-8?B?WkRkOC90aGIrTG9Td1pZNlFyQ2swbGJYa0UwN1FrakhyTkNTRUM3NmlHVEdJ?=
 =?utf-8?B?OFRnVXdwRmVpR1d6NkpQVTJXMnJ1QTYySnRTQy83cUhDdTVsZGhRa3Z1M2Vs?=
 =?utf-8?B?WXNkK1dOaFRoY3MwMXBNaHlvMWdxeFRiaDJ0NHlmVFNsMXMvQnJzUGFiemg5?=
 =?utf-8?B?cmtseXk4R1RGZlgvUnF2Q0JXWlFkUG95QVZxby9hTVZJRkZSTWh4NjdtSkU5?=
 =?utf-8?B?SDdzVjJyYTRwTVVqcGJqWkFoRHZsakwrK1A2eUVDLzZUV2pCMUJWaTF4b2NH?=
 =?utf-8?B?L3VaODJvOGxNUmNmWUxNc0NITUkzbTFhemUwellZMFViaytaZEpXUSs5OG55?=
 =?utf-8?B?OTNxUzJ4UlJLRmlHbTdDbXVHcXIxZTJOZWxBL1VJYWtsZWN5OXdUU1ZhbVR3?=
 =?utf-8?B?anF5Rk1uU0tqSGNtMUw1QWNqc0dkd0Q3THhiQWR3SWRRMWg1TEU1Q1cwMkJq?=
 =?utf-8?B?VzVIM3A5eFJCYTZZRno1Tit6QWVZR0hvZTdoVUxWWk9KZ1dwelNaZTFZeWZK?=
 =?utf-8?B?NlI4T0RHU2U1eDk5TXpHeDBBbGVDNHVnSzlicThKVzZVMGI5NUVVdWJKREc5?=
 =?utf-8?B?bktJQ0xDRXVuYTBtcEVRTldvOXA3Q1M0cUwza3lBMEtsM25IZklsVVQrSTVB?=
 =?utf-8?B?VDY4U3VKSnlhNEx4STlFMlI2UHBEZ05wSnFqOC9CWkx2WjlEZkJ1WFdFdnQz?=
 =?utf-8?B?M2VEbEV5M0h0OE9sS2tna0ZyMFRtUjJZd3V0ZDVwd2duZVhXcFI2YVlWYkJO?=
 =?utf-8?B?ZlNQajF6NG9IU3hSUmttWGtYVmludGFZeDhoR25IWnBrY21tTmVFdytzYXBS?=
 =?utf-8?B?NG1UYUlZb2VYVGZlU2VKQlBjK1V2SnZobHhlZDhkemltc2MvNkI3RFZ4Z3VH?=
 =?utf-8?B?eFhrWUFQNVVsdHozUGJZV1dRVXBrNktnNkpJcUZQOG50eG9LZnpsTkowNHFW?=
 =?utf-8?B?UFJuWDZxK2hHdVp4dlhsZURzckNSSU9WS0lkRTROdnovSDJlaGRZQXRlM1ZQ?=
 =?utf-8?B?dmtUTCtmTEdKZjJ3NmJ1T0lUeEsxVVNwaGJpZGtCbno2U0tZcjVaZnRTbi9r?=
 =?utf-8?B?Z2czSGt1cjlTU25yRWp3UmZiMnZxUnpTSGorY3FERitONW1zcUlXL0hwZW0z?=
 =?utf-8?B?NUF3dGlDOGlhU0RJWDVqU3czbVE0S01MelVZL1czSS9ML0ZFejRrSG5VNlc5?=
 =?utf-8?B?cWlZN0x2VUI0RFZlWUxyTVJPaDVINnN0R3FQQkJSTEpLbmtmNTZxaXZ0SEpX?=
 =?utf-8?Q?/VTs3hSuDto5rflpvI3WXsib7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec833fe-08f3-4876-c687-08de0dd346a6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 23:17:01.0647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACICtjEeuyjykTTr8ZwhLYjz6+kGAER6fqzW8YgEQd/hyxo9c4esPW77jW4bPv7UCIRKxZy8wwJmlNvYbcj50g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8714
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

On 2025-10-17 04:42, Zhu Lingshan wrote:
> This commit introduces a new id field for
> struct kfd process, which helps identify
> a kfd process among multiple contexts that
> all belong to a single user space program.
>
> The sysfs entry of a secondary kfd process
> is placed under the sysfs entry folder of
> its primary kfd process.
>
> The naming format of the sysfs entry of a secondary
> kfd process is "context_%u" where %u is the process id.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  6 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 78 +++++++++++++++++++++++-
>   2 files changed, 81 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 919510f18249..9de658119cd9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1021,10 +1021,16 @@ struct kfd_process {
>   
>   	/*kfd context id */
>   	u16 context_id;
> +
> +	/* The primary kfd_process allocating IDs for its secondary kfd_process, 0 for primary kfd_process */
> +	struct ida id_table;
> +
>   };
>   
>   #define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
>   #define KFD_CONTEXT_ID_PRIMARY	0xFFFF
> +#define KFD_CONTEXT_ID_MIN 0
> +#define KFD_CONTEXT_ID_WIDTH 16
>   
>   extern DECLARE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
>   extern struct srcu_struct kfd_processes_srcu;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 995d27be06e3..157145c94314 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -827,6 +827,7 @@ static void kfd_process_device_destroy_ib_mem(struct kfd_process_device *pdd)
>   
>   int kfd_create_process_sysfs(struct kfd_process *process)
>   {
> +	struct kfd_process *primary_process;
>   	int ret;
>   
>   	if (process->kobj) {
> @@ -839,9 +840,22 @@ int kfd_create_process_sysfs(struct kfd_process *process)
>   		pr_warn("Creating procfs kobject failed");
>   		return -ENOMEM;
>   	}
> -	ret = kobject_init_and_add(process->kobj, &procfs_type,
> -				   procfs.kobj, "%d",
> -				   (int)process->lead_thread->pid);
> +
> +	if (process->context_id == KFD_CONTEXT_ID_PRIMARY)
> +		ret = kobject_init_and_add(process->kobj, &procfs_type,
> +					   procfs.kobj, "%d",
> +					   (int)process->lead_thread->pid);
> +	else {
> +		primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
> +		if (!primary_process)
> +			return -ESRCH;
> +
> +		ret = kobject_init_and_add(process->kobj, &procfs_type,
> +					   primary_process->kobj, "context_%u",
> +					   process->context_id);
> +		kfd_unref_process(primary_process);
> +	}
> +
>   	if (ret) {
>   		pr_warn("Creating procfs pid directory failed");
>   		kobject_put(process->kobj);
> @@ -863,6 +877,50 @@ int kfd_create_process_sysfs(struct kfd_process *process)
>   	return 0;
>   }
>   
> +static int kfd_process_alloc_id(struct kfd_process *process)
> +{
> +	int ret;
> +	struct kfd_process *primary_process;
> +
> +	/* already assign 0xFFFF when create */
> +	if (process->context_id == KFD_CONTEXT_ID_PRIMARY)
> +		return 0;
> +
> +	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
> +	if (!primary_process)
> +		return -ESRCH;
> +
> +	/* id range: KFD_CONTEXT_ID_MIN to 0xFFFE */
> +	ret = ida_alloc_range(&primary_process->id_table, KFD_CONTEXT_ID_MIN,
> +	     (1 << KFD_CONTEXT_ID_WIDTH) - 2, GFP_KERNEL);

This would be safer and more obvious if you just set the upper limit as 
KFD_CONTEXT_ID_PRIMARY - 1. Then you don't need KFD_CONTEXT_ID_WIDTH at all.

Regards,
   Felix


> +	if (ret < 0)
> +		goto out;
> +
> +	process->context_id = ret;
> +	ret = 0;
> +
> +out:
> +	kfd_unref_process(primary_process);
> +
> +	return ret;
> +}
> +
> +static void kfd_process_free_id(struct kfd_process *process)
> +{
> +	struct kfd_process *primary_process;
> +
> +	if (process->context_id != KFD_CONTEXT_ID_PRIMARY)
> +		return;
> +
> +	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
> +	if (!primary_process)
> +		return;
> +
> +	ida_free(&primary_process->id_table, process->context_id);
> +
> +	kfd_unref_process(primary_process);
> +}
> +
>   struct kfd_process *kfd_create_process(struct task_struct *thread)
>   {
>   	struct kfd_process *process;
> @@ -1195,6 +1253,11 @@ static void kfd_process_wq_release(struct work_struct *work)
>   	if (ef)
>   		dma_fence_signal(ef);
>   
> +	if (p->context_id != KFD_CONTEXT_ID_PRIMARY)
> +		kfd_process_free_id(p);
> +	else
> +		ida_destroy(&p->id_table);
> +
>   	kfd_process_remove_sysfs(p);
>   	kfd_debugfs_remove_process(p);
>   
> @@ -1601,6 +1664,13 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
>   			goto err_register_notifier;
>   		}
>   		BUG_ON(mn != &process->mmu_notifier);
> +		ida_init(&process->id_table);
> +	}
> +
> +	err = kfd_process_alloc_id(process);
> +	if (err) {
> +		pr_err("Creating kfd process: failed to alloc an id\n");
> +		goto err_alloc_id;
>   	}
>   
>   	kfd_unref_process(process);
> @@ -1610,6 +1680,8 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
>   
>   	return process;
>   
> +err_alloc_id:
> +	kfd_process_free_id(process);
>   err_register_notifier:
>   	hash_del_rcu(&process->kfd_processes);
>   	svm_range_list_fini(process);
