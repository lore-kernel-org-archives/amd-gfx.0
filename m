Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB082CCD187
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Oct 2025 20:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EDED10E644;
	Mon,  6 Oct 2025 20:58:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PBm8akT4";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F96B10E644
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Oct 2025 20:58:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hx52tR+k8ZGW+3XJP4XkixpKigQNK1aPi4sc1R/ULL25+70wWWkpX7EF4kpJUxuxAQhrbH82I0GjxWHY0XeIUhb1IAQNMnQnosvpbP3DBaYhcFv7CYWDFKQP/KQvMBf47C/2lt1YgUB++BDQPMRBNphx//NilxAd6zkn8Wghk9K+hJ7MdEeRE0+r2ubXeiQ2wo97mshV+lIGqupy5PPq+O2iO+3B/xVNg3dKDkPR9BDC+elEgefYyQbFFHnASunb/kpyNgytMm9ipv1zzijMpKPS2mNl1KoF9cvc++ZoEj6xvUDz7gTMMZFAfoeg4lP3/vAswUAuUlZOEf0cK7hmGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDRxx+SFzpyZkUJUCneMwSbn9tjpc2CasHDNxFu//iU=;
 b=SPbC7DwaeFI003g6lCjiBlaHple8rJLBga8WhSIQXljIVqre1urBcKNqvD+/yLWApFBGG9aahfaPiv89ovVwuGtf6n2ePDJoQ8+mGugBHVd50ZWKP9CsxULfvNNrOeO92BcAnCTyxqsuFQCVeMsWDDGdQwvvdaAaG/4uITHD3q2kolp+nBhCyq9EQa0NgLh2k+y6VoPk0urtZqeSLyBd5Qldklx/NAWMLwmImsbasIZt4FFibASwYU2Pwm5fQSKqbosDBumk/HnjBbJEnf06zWCI2qEiBOoJpAmY9srUncuEn2PPJXF6oH+Vqu0tWyetth0+XM+oIrlZ7EmPy31s2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDRxx+SFzpyZkUJUCneMwSbn9tjpc2CasHDNxFu//iU=;
 b=PBm8akT4o8FhRVKmpOif190wD8qFKy58d0PXtwLVI6niCQLmZqoNFcUS16DFfXzHBYCgyCQikxauvUcewQ4VnJnkgnGfjK3zLvp6kCvP40sEb75DB1eG3FR4L6XLXA8sYVI8anZyM5vfokJ0OLVzaI/iICISCCryljtKSTMRwYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB8267.namprd12.prod.outlook.com (2603:10b6:930:7c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 20:58:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 20:58:05 +0000
Message-ID: <08acf9ad-2f6a-4b5f-a677-d09664680750@amd.com>
Date: Mon, 6 Oct 2025 15:58:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: RE: [PATCH] drm/amd: Drop superfluous call to set_power_limit()
To: amd-gfx@lists.freedesktop.org
References: <20251001171340.561444-1-mario.limonciello@amd.com>
 <DS0PR12MB7804768DA193EA233BA32C7F97E4A@DS0PR12MB7804.namprd12.prod.outlook.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <DS0PR12MB7804768DA193EA233BA32C7F97E4A@DS0PR12MB7804.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0075.namprd11.prod.outlook.com
 (2603:10b6:806:d2::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB8267:EE_
X-MS-Office365-Filtering-Correlation-Id: 74bb3fdf-6de6-4397-4ab7-08de051b0b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0VURHZEaGJvcWF4d25GeGJocmpYVGF4dEtoNEtscWsyWERBUE5sQW55NjFN?=
 =?utf-8?B?WWdvRG8yNm1rWmpKSHFINXZjNXJVaE5zVEl1MmhzajJJK3J1MDBoWnorSnBw?=
 =?utf-8?B?bHZxZXVrU3FiWHFZVDRYSEpxbktJN3gzZ1dFS0IzSHI0czdwc0QyYktITStE?=
 =?utf-8?B?eFE0K2pXREMrTjlyNTduRFNOTXNhcTJMZnhWeTh6ZTZTUnM5UFZxZzhFNXZ1?=
 =?utf-8?B?Z21oV0VUWWlXWEV0aEQrU1pIOHNkSXRwN3oweDdsT296TzZYeUxnT1pBTDJC?=
 =?utf-8?B?S0YwNk1vTVVSSk1sVVc1a3ZDZ0U1ejJKTU1oblpyOTRUb0t5UTh0eHFNMGVh?=
 =?utf-8?B?ZEJlK1lYeGhEUEMrTjdGaEl2b296THhMME43SThSZk1lMDFKK2FaRFhwa1Z5?=
 =?utf-8?B?K0t0YWpxL01Ka2ZlV25iekFlOFdjemdPaGhEdW5XS05XNElZcjFvMTVmTHJD?=
 =?utf-8?B?bmhsVm8reEJYTHV0YXN5SmdmVUppWEZaQWxoT2JOY3NUS2pRRUN3SHNXVjk4?=
 =?utf-8?B?MG5uaW9wMWRNS1hGRGlRbmQ3YmJDY0tqSUFoZE5PNDVkQ0JhYjBPKzFGaWNq?=
 =?utf-8?B?VDF5ZFdIWW5KNzFEdElRTWhsVjJiR0pmZnM1a0hQUE1hejcyZTNscG0wK2w1?=
 =?utf-8?B?OENkcFRnTzdNa0Fka3NQRlF1WTlBcHpHaHQ1Q0h2MUduNE5BRkFyb3ZZbHRW?=
 =?utf-8?B?NGhEYkRINVhMU0c4RXg5RW0yMS8rdnBDU3JyTWs1Z1JycGdrcHFEVFJKU3k3?=
 =?utf-8?B?V2ZuaFZnQWJuWG8rNVBJRjVPN05uOW9NQ3ppSzNWSjIxZTkvTndlUlJSaTNF?=
 =?utf-8?B?cVQwSHpFOTYzNDlqNlR2TjRIZW8rRTdRQjUzQ2pTcmFFVnZmV0ZnQlJITGlD?=
 =?utf-8?B?NVpSMmNYWXU3Q0pBbVRlVTRLTkIySEs0M2RJTllXelB5YjJUQzZLQWJpemFT?=
 =?utf-8?B?OGVCd09wT1hTdjZENWZlV2RuZUNNcFVNOTNaSTN2MDh3WFAxRjNVbTNGZkJD?=
 =?utf-8?B?aGJob3dqV0hscys5Y1loME01LzM1eVZQOTF1OEpMRGQ0MWRtZDRIWVh3SVpX?=
 =?utf-8?B?dzM3QjZNTlZ2YzJNTDQvYzIwbTVCUVpEZFBkbFdQMGZYemRSUzVtaC9UL3FL?=
 =?utf-8?B?eEVYK3p2V0JpUjlydWdVdWRQTVVyZE90RXlWUG0rT251VCtGSVdFZU1mdE9N?=
 =?utf-8?B?c1hZK3dEaURVSThwYjhuWFJhYWs2T0s4SmtaSk5Ocm1CUVl1T2dZaTh6M3U0?=
 =?utf-8?B?UVg1UTEzNmFPK0FZMjhXMWVTSW1iZE1LYXdadjdGWUNzdjBEWm1LSm1jZVhF?=
 =?utf-8?B?TEFhd1BrMXNlamRNRlZ4WVQrcFphc1RTRDVUMExpc08vV3FwRHhhLzdEendW?=
 =?utf-8?B?UE13bTlVVFRGeS9ON1pKREZTT0dFbkt2bE1qdWY2elJrQXBaMER1dUNzeFZV?=
 =?utf-8?B?MFlSdTNMMFZrL0szNVhJM3dFMHFoM1BkbWM4NmxqTXdWRVhmOEdueWsvMGdF?=
 =?utf-8?B?WkZ4V3lEdTIybHdtdWcrRWoyS0lweW16TVBRZk9IM1RGaGZQbVRQUWlKaG1p?=
 =?utf-8?B?c08yM0ZGby9Rc3YvYjNLdHhCOGZqZUI0Z1piSkE4aVM2cWwwd2dRSDMzYml4?=
 =?utf-8?B?ZGUzVUFMNkpWRnhTeVZ0b0w0WjVRNitPWnUzWG9GYmlDS0xPSDZMbVQyTFM4?=
 =?utf-8?B?WExwTytHOW5XT0szRyt4ZlVUOGV4a3pqOUJPdC9oOU9BWkJlT2NCTy9WWHI1?=
 =?utf-8?B?QVhFYXlLNE5SRlFtSVEwa2Jac2NQUVN5blIvU0Q1ZzhaREhuTWxTcXMrc3pM?=
 =?utf-8?B?NllIeVVMR2JoZ2FDMHcyMXVIMDdzbVVJSlA4amFoNzZ5c0p4ejlXUjloWEZM?=
 =?utf-8?B?TGhEMXVrK1NuRlZ5ZHhnWWxXMlFGYThOR21MT2F3Um9SWEZHZm1Fd3dya2pQ?=
 =?utf-8?Q?IIMbPNvmwbX12AMv3+VnafTnkGxaOg63?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGlVdk1UbXJOdjljaDBlTG0vR1NDUFYwa1MwNkJPQkhUS3lJS1dadndDZXJ0?=
 =?utf-8?B?cGZSQWR3UGttcHFFdjZEd0dZSUJObEdGQXozbC9Vdnh3c2dubkxEWGVYbXlR?=
 =?utf-8?B?T3pBbVA0ODU5TlRtYkdFOEg5a0tSOXM1QUtmN0RCL25pYzlKTzdKdnpCdDc4?=
 =?utf-8?B?U08xMGVLOUVJWHpMOU5IdExaZXZsUjdEdk5QSGEzak9tbGNmbTQwTnFrOVB1?=
 =?utf-8?B?OHdLZm1INGdqOThlc3BhQUhNdStwTCs2VG9iYWZFd28rVnhHbElzd1RjN3FN?=
 =?utf-8?B?TFBGQW11SExSWU1rejNoUkErUmduZHpDdTUwc05UWlZ3Q28zaHVPb3YwMnU5?=
 =?utf-8?B?d2NEOXR5QUNscjdPWmpHelAxTWdBL1hPTUkvVkFTMTlET09IVzByYnFydGlQ?=
 =?utf-8?B?aEpLKzl0elB6dlZIQ0hWVkk1VVVNMXdQTE5vM3BvYkpjeTBmUjh0eUhleHFT?=
 =?utf-8?B?RDNYOE45aDU3NEE2Qlk3TmxDV0E0SUJMM2dRUHByY0NzUzU2ZXFjaWt3dXpN?=
 =?utf-8?B?TDZuRUc4VGlNTytsbnlvOWdSOVhGOXNyVlZ0dFdaVUN1RXl4bVgyMkd2OVFT?=
 =?utf-8?B?OFkvMUp4eGFwM0ZBdHNxWEJTYUcyMlZHenZsbXNKZDFqYmZPUisxK3JKZS9T?=
 =?utf-8?B?cVVONnhJVWt4ZkR5RDJmUFdoY2x4cEhaNXNybUZmaW5rT29VcFdTN3JpQjJp?=
 =?utf-8?B?ODFVSjNOd1NFUnJnMXMrYWdHejQwQ0I5ZUR1WUM2K0F2bC81TUhmbGJNaisv?=
 =?utf-8?B?QUpTRm9JaTE0aGptRmhDcXp2RzNWNjdVcU0zbFlENE5HcWJsNDgvY3FEUUhQ?=
 =?utf-8?B?WmRDc1JwVEEwei9vbEZsWlVEMGdqeUlqWS9JSUJEWWtRb0dZNE9ZVDFuWGF3?=
 =?utf-8?B?dVZyNW56WjVwTW8xd1VNU0pzSWh1ODhJUG5YRk42NDEvYmRUc21CcGFxWFJX?=
 =?utf-8?B?T0ZrTFQrdDh2SHQ3LzVJVFA2VEJqU1lvLzUvb21uMHVxWnlqRkQvTThid3Nn?=
 =?utf-8?B?a2NXL0hoV2NpUmFGVjdYVDdYNGFyc1FiVTVuU29Va0tlTEV4L2E2aFNqZUp2?=
 =?utf-8?B?NnB1YVFteHlBQVRXNGl5NE5URFVsaG9BRkhHM3cwS3pMU3ZYYjhTeHk1VFUv?=
 =?utf-8?B?cDFiNTRyR3pBd3BoTitOU3R6dUJSMk9JYXkweUYzc2lJMW9zSUo4emdsMHhy?=
 =?utf-8?B?cmZBVjhjb2tZQnRiSFIxVHNQaXBHUUtob0NWU2hRZ1Awb3lSZ2dNeURPTmNx?=
 =?utf-8?B?R00vS2taRHlZZ3MxbHJEbDdXVkNWUXBGUHRoVERuNUp2MDB6ZGtLTWo0RXVv?=
 =?utf-8?B?MGFYQXZsN2lYT3hVRCtpSTN3VW0wbGdkUkp2V3Z0WVAvbjNUVDZFQk9kYzNy?=
 =?utf-8?B?dlVicyt4UHNNeWk2bDFaU0hvK3FVbFlyVm1qdFRwZmM0dkQzN0FPZTNKVjBN?=
 =?utf-8?B?VmFKdEx4VXRPVHlpdkpyU3VUc2JmQU9LZ0cxdi9GV0VuaXZrT2xBVHhRVGRI?=
 =?utf-8?B?eWNDSDVWNTIrRXpydUtrMTkvd1dmS283N0VXaHJ4UDdzc2FSWGVwaEJGRzFX?=
 =?utf-8?B?SnVkWWRqMVdHZ3ErSEwrSFFWM2VZZlMycVRzZGdnZ29VNVN0bFhMOVFGckVC?=
 =?utf-8?B?VGd2VCs4VU15eENVSFJVM1hITkZSbHprVlJDQTM0bXc1V0IvN1Y0KzBPUGtJ?=
 =?utf-8?B?Umx0WWo4eEhxc2xjTjN4cmROT3QvRG9zQmVPaTNrOW1paDUxa2ZvazNPS2dX?=
 =?utf-8?B?NWJ2d1dWQkdVdmdlT0RTOEt2V2xUY2tmWUpKcHpiTjdib09LMUFGbG9TTm1p?=
 =?utf-8?B?eENQbW9hR05Gdk5PeTBTcU1Hd0s0MnUvZmZnWTVjOUFqenFQOVVDbHd3dTdz?=
 =?utf-8?B?SUl4YmRHZEdwb0J4TUtTdWFwU2RsRkJ6MldpY0lFc3p6YWxBMUFla2VES2ts?=
 =?utf-8?B?TjZSWHNVQ2psYjRhOWd0QUQ1SEFBdjltOW4ybVRLSnMvdWtRdndaNER6aTA4?=
 =?utf-8?B?Z1lRQ3MvN1JHWUxRa3h6SWxRb25XdmRHVGZzRG5HaUhQSkZ3cHRMSmNSYlpX?=
 =?utf-8?B?cTV6ZHpmZDFyT00yWDF6b01UZjFXUEJqSDdVYzRQb3VwSldNa2JCN3h3M2dR?=
 =?utf-8?Q?R5TqhqZczU6jb4PbKtepXRya7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74bb3fdf-6de6-4397-4ab7-08de051b0b63
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 20:58:04.9397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htjgyCHdnTgu/YDkZCV9RlxquKtB6H3HXdRbA6plVjWoKJHkhQRHOr/scXcVbv6C+VBZ6Fi6PFNfwTJCyu1d1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8267
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

Got it thanks.  Will disregard this one.

On 10/3/2025 3:36 AM, Lazar, Lijo wrote:
> [Public]
> 
> This is because currently only Vangogh has Fast PPT limit. The limit for that is not the same as default one. It will be higher than the max_power_limit. Since this is Vangogh-only, it's left to the implementation to handle that check.
> 
> Thanks,
> Lijo
> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Wednesday, October 1, 2025 10:44 PM
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>
> Subject: [PATCH] drm/amd: Drop superfluous call to set_power_limit()
> 
> smu_set_power_limit() will call set_power_limit() if the limit type isn't default ppt, but after a bound check will call set_power_limit() regardless.
> 
> The first callpath is not necessary, remove it and do the bounds check for all calls.
> 
> Cc: Lijo Lazar <Lijo.Lazar@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index ac99bb7e2e7b..431333060b72 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2939,10 +2939,6 @@ static int smu_set_power_limit(void *handle, uint32_t limit)
>                  return -EOPNOTSUPP;
> 
>          limit &= (1<<24)-1;
> -       if (limit_type != SMU_DEFAULT_PPT_LIMIT)
> -               if (smu->ppt_funcs->set_power_limit)
> -                       return smu->ppt_funcs->set_power_limit(smu, limit_type, limit);
> -
>          if ((limit > smu->max_power_limit) || (limit < smu->min_power_limit)) {
>                  dev_err(smu->adev->dev,
>                          "New power limit (%d) is out of range [%d,%d]\n",
> --
> 2.51.0
> 
> 

