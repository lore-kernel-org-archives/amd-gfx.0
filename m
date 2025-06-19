Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DDBC71159
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jun 2025 04:21:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB3DD10E03F;
	Thu, 19 Jun 2025 04:21:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f6zN9swN";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B7A910E03F
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jun 2025 04:21:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITC2IXWKxYtauFTHE1wvHUK66j7e/mVJy8ySjtT8CsRQVNYKBVZ3UGHWnH4wrGlqtB8dPPpAFnWM2SJxL78UOZzfpz88xWZ3XdrAjotMeDQtKqW903raADU+6oSeyYXPtISFvGJ6hoXS6t3pE3gEnfBKsY3EaK9Us5ryJvFen2CKOVeP4tv2KZJaM2bSskR8ZlQ2ThMzcAB/wWmcFDQcOzvTPIBgJqiRhQdJJxupuhQSd56sXZsk0O0JQ/pcOPmisOAbzmQmcgNkhXd+WqTqqtaEyPA7kVmsQgpM2vLMxF/ysXtjwHyjPY3hdjYUivGxXx/XqG5eXhZyO6XTwjwvHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoU0QnpZM8HfhTBLjGinyFGDQyt7z1CfwOo6v1967BE=;
 b=fd8+oMH2cGahs78S8gGyoRzU8v43WJvv2aBAanuwzj8pxXHyZudS+FQx3a8GTC8Bm7BUzymBCXnCEGL4IPfc6FSReVNIDPrGEgDT9p76/UfpVp2ZiTz5IND+1d+sJvLPk3vfQ31+dzcC3oZFSCM14aW10StcyZv2ieeT0nk/UyApVvDJreN69JNbEy7WTMRGCdvvhwIJQJXjpJ0uftFmHKeJ33kRRaCTGxXa21yc+g19bORKTgSw2PqNqRNtsjyUYAjDN7bw5tV8vRQFYlnhOYYc2Ono4HKxqe6P865v3BAlbuS72fpRPp8VT4OiEM0PbxFyHNHHSRDAyBMxnYEscw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoU0QnpZM8HfhTBLjGinyFGDQyt7z1CfwOo6v1967BE=;
 b=f6zN9swNWg4qXm/I0CrAWB2fNq9nWoIsCM71Hda750KF5z/h0q8/6rXRbVS2xsf3+mtTrEc46NcGWhGbBTTbA7jlWrrboI7enrU1n6l5m5/lTgOZbcDIx5RPobT94R4hwKIEhoK8WrQSW296wqugBYFWYyrbk8rp14wl/CP6BoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 04:21:38 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8835.023; Thu, 19 Jun 2025
 04:21:38 +0000
Message-ID: <1556ef49-20ee-4df4-8dd8-7e3761fa030f@amd.com>
Date: Thu, 19 Jun 2025 09:51:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amd/pm: Add support to set ISP Power
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org, 
 mlimonci@amd.com, xiaojian.du@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com, Phil.Jawich@amd.com
References: <20250618221923.3944751-1-pratap.nirujogi@amd.com>
 <20250618221923.3944751-2-pratap.nirujogi@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250618221923.3944751-2-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH8PR12MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 1914e3dd-1182-4af9-90a5-08ddaee8c8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnM4T3MxRDFTdE1BMld6THBJM0lZSDNacEJVTks2VThTMlBwaEQxSlJ0ay9L?=
 =?utf-8?B?eUFLSU5jeDd3RjlzamwrWHFWMUViVmtCaEplSjZ1Q0c2Y3V5d1VKOXU2RWI0?=
 =?utf-8?B?aFpzOXdsaFpKbUxUZ0JoaFEzQkF0blFCQWxTTEx4K3Y1YXFvT2NBbGs2dHlJ?=
 =?utf-8?B?Z0hYM0xjK21odWpncFlhdStLQm5OWDNnRHU0bHcrYWV1V3N1alFPNlhMY1My?=
 =?utf-8?B?b0RHV2NWR0VxZTdyRkVQZmtDM3IwQ2RZN05NLytqOVBtTkxIditndy9BR240?=
 =?utf-8?B?RHNIRWp3dlFtZzR6SDNVd0NhcjRCck9JUjhtNmJaWm5pL1Zzc3NVUmRYeG1G?=
 =?utf-8?B?ZlFFL1ZjWFVtOHdUMkhPQ0EwRUF4dW9qVHNSeXBXU1VqeUR3YnFqSzlheE1O?=
 =?utf-8?B?ci8wcGpvRU9XRjIxMC9GWmxpcThtV2lObUFSNU1meFdEaHBHNEVwaDd6Mnl6?=
 =?utf-8?B?TUhLZDZmaEhMSGgySDg2a0d3dHhEMjFucjVwZmNmR0hWeC9RalhBbVdvQVE2?=
 =?utf-8?B?bWEwV05HN0hnM0dGdHJBSTJiOXF3cUNZSXh6QW1nOU5lNXdRa1ZwZUowYzJB?=
 =?utf-8?B?Wi9xUFhOTFJGS0ZUSEFIUHdKV1ZBb2JhNlRGR0VybTN6UjYrKzBuT0Z4Wldq?=
 =?utf-8?B?S0kyaWJ1anY5RFVGU0tmTGsrenRBdGFKYm9uWDk1T0JTZEMrSU0wVkJBVXp2?=
 =?utf-8?B?ZlVLTjQweFZESVQralRNa3pqZGJyUk5Fdkw5aENwUzJ6bEVNcXliTWpRN1J0?=
 =?utf-8?B?TVBKVUNmbWZUOXhESFBZZU9uT3kwbkNOdFVraThOdlErdjFpU25jZ0M0Y05E?=
 =?utf-8?B?b3FldFdKaEc2dnpUbEtZdWtjLzVmenplaUJHQ3BwZ0xsTVd0SWNOYnZGdXYy?=
 =?utf-8?B?czlCV24wdEhpSDZXWGJ5YnU1MCtNamxNQkJWb2wzUzBFYmFJRkhDWjl0aW9p?=
 =?utf-8?B?QkhHR09mRlBiUG9KUGlQL21TVkY3N2d5eTY5cFAzakxIMGhDRm5yaWxPd2Fn?=
 =?utf-8?B?aEd0TEU4bE16dkI5YzgwU3BWSHRYYnhXN0g2VHpYakdUcVRvdHc2c3Q1QUlF?=
 =?utf-8?B?WXdxNVR5NnlpZWVEY2VIdDdON3d4NWdWM1BIVzl2Vnk2aSs0blk5UGZTeWhm?=
 =?utf-8?B?RzRIOGZuN1p0Tll0YnV0TW9KMDQ2RjQyMVFpQTNDSDN0VC9OdFpXVFVxTkpn?=
 =?utf-8?B?Z0ZpSXN6ejFDNm45S3dqWnl0K0w1UlZJSzh0QXZwL1pBSFoyVzhFejRHc1lZ?=
 =?utf-8?B?MnFGcmc0ZFF4d0haTVZIRnpLejRGTXZXVHNGdTZua0RCdVorRUdvbWdyNHYr?=
 =?utf-8?B?R2N6VFMvUjN3emZJQWY0dE51RTUzVkRwZWlBeWVadkx1Sm5KV1RVQW5xNzAw?=
 =?utf-8?B?ZUVRQm9QWnB0K2VXWmdHc0JHQjQxdEFYR1FXMkF0VUVzUUhLaTh6VVdoLzdy?=
 =?utf-8?B?NUQyYzdhS0FkZFpDZGRmcVp5N1ZBRmMvZVJ5d0lGa2VkMUNwZDd4azJqWVpz?=
 =?utf-8?B?MldzRFFtWjlFMnhpVXFLSWZHeHJ5cnY3QlZ1ZE1yOGUvVjFieG5NTlRlK0M3?=
 =?utf-8?B?U0JDUzlvTHd6RGVPOWNFYjdudXBMa3Y3RGsvL0FhVXQwOENtMnNFTGd3Z3Rl?=
 =?utf-8?B?K3JNOFRkSklaaFVNalRQaXByTXI0d2MrRlBsNkdIRS9CN0tGMFZUM3hFQW5C?=
 =?utf-8?B?YkMwUTRKYUo3NUZVMFo1VDlZSVVsKzRWWE5BQUo4VWFTbmpjcERlUWw2ZXNw?=
 =?utf-8?B?T3NCYVhzQ1NOKy9OSHBNbGY2WkMvZFUrbk1GY3RxQVFvMWU1RkxiblJqclAz?=
 =?utf-8?B?ZkNRQ2Q3bkRjT0tzQ2xqUm5BR2hhb0VmaE5ybVloTnZWaG1OMjZQRmwvNlBu?=
 =?utf-8?B?M2Zxc3RqcDlIMHgzN1o4V0J6RmRSZ1VlREhiN2U5VVdiRVBCcTdwcjJJRXJh?=
 =?utf-8?Q?ABXt7FzxZ4w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDZQcjhHeU8vZHpod2IrMEFtMGlWMzNZdDFFdFpyUXRJNVF6Y2Y2azEwVEhu?=
 =?utf-8?B?Vm5QUHdsdEZVci9kVG1TT1EyVy9WSmpzZ0REUUlNZ2JzRURPbVVKVzdaU1g1?=
 =?utf-8?B?QUsxS0QyVUxOK1ZVOVltTm9rMmtyS2NKeXFZZkgvVDhlc3F5UG5HNGs4TEdv?=
 =?utf-8?B?SWw2SHZxQTZhNFV1RnpPWHU3NkVWU2ZaaUFjZVVPd3RhT0VkZU9LZWdUTjZB?=
 =?utf-8?B?dmdPV3lTaVBLWXZDYlByL0xtZllpcW5sWXg1eUVRV2oxQzE0R3pUL1hpazZO?=
 =?utf-8?B?eHhJUXNqTXZxZ3NTOWRmSEZTSXdMUDhMOFBjNG4wcFlabUFyR3BrTVFKbVpJ?=
 =?utf-8?B?b2JRSkg0cjFIcEVJeS9EMHFxczYwYkI5TUlMU1Z4NEJIOHFXVTlETWNod1cy?=
 =?utf-8?B?OGk2eGlVOHk2NWJCaXF5SmZheVR5UUhncFozV3RlN2czbHc5MWpSUzFNU3ZB?=
 =?utf-8?B?TkYyOWRpMXA3dSt4OGhOdVh5SEVyclRaZ0NFTXd3OFYydFdabGt1MHFzVHV0?=
 =?utf-8?B?Ykx1K2lHK2JOVjkxcFJENk1KemMyRXVRaHMvVmw3UWY0cHNTS3NwWXF3aFpz?=
 =?utf-8?B?alJjQnFvNDFUNyt3andaK1oxTmY5L1J4cnQzd2VVZEM1RmlHMVRRNzVwVFRl?=
 =?utf-8?B?MHc4UUphbE1MNzF0c3p4TFJRK3R0WFJ2ZlN0T0xpRlQ2U3Z3ZTJ0UjRRVmVy?=
 =?utf-8?B?enNlQ1JGTndOUWdpZll5SVFxUGNpN1E5M2JxR212bjhJTFJ6OEFRTTN2Y29Q?=
 =?utf-8?B?OUVvb0RsZTM4Q20yQlduSlFpZkZEUm9Ma0l3bDBZd3hodW5ZZGpLN2U0VFNJ?=
 =?utf-8?B?c0hzYTZnODF2blg1UnJ1ZnlNTmRrd1JFTTMrNTBLNHRjS1V1ekh3c2taQ1VF?=
 =?utf-8?B?VHJReDJDbTRPcEN4T0M0eGxkWUQwbmJXWGVQdG1OTGtsV0Z6UnUrQ0dyWmlB?=
 =?utf-8?B?ZTlHRUFFYlFFR3VvSjhlYTN1R090OHYxNlQ4YVBNaFAySitTVWYrT05xcllI?=
 =?utf-8?B?SEY1U3dxcm9BR2dGZ1Y2bTk1dHpKc0d3RHlydks0NmhjK3FOcXBVMjEraU9X?=
 =?utf-8?B?ZGJDT2tWZUpEV1VqUE9YRE12bG4xbFRRME5aMmVMYktHSFJ2ajFlSFRRNnF2?=
 =?utf-8?B?RFRWT252RTZVYzVGK2xPMVJ3SlNjblViNFhGQ3U5MVZ6ZXRTaWdybmxlbjFE?=
 =?utf-8?B?Yi9ZR3R6aVlxRkZlMlVaTmk2OU5OcWRHbThwMU9UNTk3R2dya1I4WGF0dkl3?=
 =?utf-8?B?Q1lma1hxendZTDloYW9MUEFMMndpbmwrUHVXanptSGt2alc5eVE1aFVGVVBG?=
 =?utf-8?B?WkRCTnd3MEVLNlNvSFpLUlZHZG51ZXdleVU1RzgvWWZvZUpick5SRXZXMFB3?=
 =?utf-8?B?MHRhbVErY1BvUjFHbU9RRS9kWHF4dDJxVWR5VkNyRGFjWjNwcHpTSEpyQ0ZD?=
 =?utf-8?B?M2IzZDA0cFVxOEZUWGp3WDhrZTI4Y01rUnd3bkJZRm9ZMjhzODBoYU1mVTVa?=
 =?utf-8?B?MWFSd1lHUkptckM1bWZYUkV0eWM2VnlIZHllT0dmc3YvNlZYZk5CT2ppMk1O?=
 =?utf-8?B?U1AwQ3pEeWRaQzNYbmVMVkkwTTJMbWo2bDZoK2NqQ0YyTUVpYURMdWUwQ0RS?=
 =?utf-8?B?VUVMbXcySXB1WXBkeTZVZ1Z3R1lVK3JvSmJ2blluZDJRaGdPQXpSQjZpZEJm?=
 =?utf-8?B?VCtkSEhnbmNlTkZyR1BrNVJwVVluVStUdWlRMlRwcEFnN0VFOFhURTltL2F1?=
 =?utf-8?B?L1lDUjF2WFpPTzFLcjlJM1pJNnhQQ29TUGh3eTBXOUpqMFJOUzZ0SnZaTEFp?=
 =?utf-8?B?YTdFTlFySFhVKzBHVnk3dkUwMkFFSCt0bUZnLzl5SGl2eHJLcmNWVnBpN1d2?=
 =?utf-8?B?VmxvMCsxQ3pjTi9wWng2ZmZyVzJYcXdXSVpTR0FUWWhmTlF3ZG1oQW84dnho?=
 =?utf-8?B?VG5ZK0RLTjQ5OUhWd0c0S0VCQ3lkSnhzQysrZGs5RjhDSE04cFVReFB3aFNS?=
 =?utf-8?B?NWJKSVZEMS8ySG9FejZ0STFpRThHNzJuSmo1NldTZ3ZaUkZSYStqOGN6eUs4?=
 =?utf-8?B?aEhzc2RpOHYyem05RGJKNGxmZHFYS25KRHJ6SFplaEdzVGlIaXBQaGpkZTRw?=
 =?utf-8?Q?J2qthlhVNNq1nYfSVQ/br5vCj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1914e3dd-1182-4af9-90a5-08ddaee8c8c7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 04:21:38.3700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8YQe/KElcZAjUCbtVqdQxwIH36ucIv5uCihwsH10Hh+yIWI7dhDu6FTVqvTWEPhD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445
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



On 6/19/2025 3:47 AM, Pratap Nirujogi wrote:
> Add support to set ISP power for SMU v14.0.0. ISP driver
> uses amdgpu_dpm_set_powergating_by_smu() API to
> enable / disable power via SMU interface than communicating
> with PMFW directly.
> 
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  1 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 27 +++++++++++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 +++++
>  .../inc/pmfw_if/smu14_driver_if_v14_0_0.h     |  1 +
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  9 +++++++
>  5 files changed, 45 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 5c1cbdc122d2..95f1fff442cb 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -98,6 +98,7 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
>  	case AMD_IP_BLOCK_TYPE_GMC:
>  	case AMD_IP_BLOCK_TYPE_ACP:
>  	case AMD_IP_BLOCK_TYPE_VPE:
> +	case AMD_IP_BLOCK_TYPE_ISP:
>  		if (pp_funcs && pp_funcs->set_powergating_by_smu)
>  			ret = (pp_funcs->set_powergating_by_smu(
>  				(adev)->powerplay.pp_handle, block_type, gate, 0));
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 0c9232009da9..97572fe26ddf 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -307,6 +307,26 @@ static int smu_dpm_set_vpe_enable(struct smu_context *smu,
>  	return ret;
>  }
>  
> +static int smu_dpm_set_isp_enable(struct smu_context *smu,
> +				  bool enable)
> +{
> +	struct smu_power_context *smu_power = &smu->smu_power;
> +	struct smu_power_gate *power_gate = &smu_power->power_gate;
> +	int ret;
> +
> +	if (!smu->ppt_funcs->dpm_set_isp_enable)
> +		return 0;
> +
> +	if (atomic_read(&power_gate->isp_gated) ^ enable)
> +		return 0;
> +
> +	ret = smu->ppt_funcs->dpm_set_isp_enable(smu, enable);
> +	if (!ret)
> +		atomic_set(&power_gate->isp_gated, !enable);
> +
> +	return ret;
> +}
> +
>  static int smu_dpm_set_umsch_mm_enable(struct smu_context *smu,
>  				   bool enable)
>  {
> @@ -408,6 +428,12 @@ static int smu_dpm_set_power_gate(void *handle,
>  			dev_err(smu->adev->dev, "Failed to power %s VPE!\n",
>  				gate ? "gate" : "ungate");
>  		break;
> +	case AMD_IP_BLOCK_TYPE_ISP:
> +		ret = smu_dpm_set_isp_enable(smu, !gate);
> +		if (ret)
> +			dev_err(smu->adev->dev, "Failed to power %s ISP!\n",
> +				gate ? "gate" : "ungate");
> +		break;
>  	default:
>  		dev_err(smu->adev->dev, "Unsupported block type!\n");
>  		return -EINVAL;
> @@ -1300,6 +1326,7 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>  		atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
>  	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
>  	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
> +	atomic_set(&smu->smu_power.power_gate.isp_gated, 1);
>  	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
>  
>  	smu_init_power_profile(smu);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 9aacc7bc1c69..41d4a7f93660 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -402,6 +402,7 @@ struct smu_power_gate {
>  	atomic_t vcn_gated[AMDGPU_MAX_VCN_INSTANCES];
>  	atomic_t jpeg_gated;
>  	atomic_t vpe_gated;
> +	atomic_t isp_gated;
>  	atomic_t umsch_mm_gated;
>  };
>  
> @@ -1435,6 +1436,12 @@ struct pptable_funcs {
>  	 */
>  	int (*dpm_set_vpe_enable)(struct smu_context *smu, bool enable);
>  
> +	/**
> +	 * @dpm_set_isp_enable: Enable/disable ISP engine dynamic power
> +	 *                       management.
> +	 */
> +	int (*dpm_set_isp_enable)(struct smu_context *smu, bool enable);
> +
>  	/**
>  	 * @dpm_set_umsch_mm_enable: Enable/disable UMSCH engine dynamic power
>  	 *                       management.
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
> index 1bc30db22f9c..cd44f4254134 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
> @@ -106,6 +106,7 @@ typedef struct {
>  #define NUM_FCLK_DPM_LEVELS       8
>  #define NUM_MEM_PSTATE_LEVELS     4
>  
> +#define  ISP_ALL_TILES_MASK       0x7FF
>  
>  typedef struct {
>    uint32_t UClk;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index 84f9b007b59f..fe4735d5ebd4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -1533,6 +1533,14 @@ static int smu_v14_0_0_set_vpe_enable(struct smu_context *smu,
>  					       0, NULL);
>  }
>  
> +static int smu_v14_0_0_set_isp_enable(struct smu_context *smu,
> +				      bool enable)
> +{
> +	return smu_cmn_send_smc_msg_with_param(smu, enable ?
> +				      SMU_MSG_PowerUpIspByTile : SMU_MSG_PowerDownIspByTile,
> +				      ISP_ALL_TILES_MASK, NULL);
> +}
> +
>  static int smu_v14_0_0_set_umsch_mm_enable(struct smu_context *smu,
>  			      bool enable)
>  {
> @@ -1669,6 +1677,7 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
>  	.set_fine_grain_gfx_freq_parameters = smu_v14_0_common_set_fine_grain_gfx_freq_parameters,
>  	.set_gfx_power_up_by_imu = smu_v14_0_set_gfx_power_up_by_imu,
>  	.dpm_set_vpe_enable = smu_v14_0_0_set_vpe_enable,
> +	.dpm_set_isp_enable = smu_v14_0_0_set_isp_enable,
>  	.dpm_set_umsch_mm_enable = smu_v14_0_0_set_umsch_mm_enable,
>  	.get_dpm_clock_table = smu_v14_0_common_get_dpm_table,
>  	.set_mall_enable = smu_v14_0_common_set_mall_enable,

