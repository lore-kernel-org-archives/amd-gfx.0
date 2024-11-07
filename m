Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1233AD5AE79
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2024 09:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9140510E279;
	Thu,  7 Nov 2024 09:52:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KMzqHz4S";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2138F10E279
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2024 09:52:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6rXfMYTH0elwwFI75KUlo3btnRTQ1bPPP/mE5EqSMBJMq5vlL3/zJj/f6SpE7xHlHtBUExdHuzmiPNgKFriJsrBs5ZsJVl49SJQm6oWt1Fv5f0VZ6318/joYbc+IMNaywG12iwXmWMkp82a1aKLpjKtA9Hz26rfxsxT/wAzDEkZZ25SU7LTy+VS0Fg/HB3iDGlz1f2Y8oo6RANRm+axPtaSzs5jNFYIuXQEAQq6gWFYd5UZ5CrIWRn+HRMYQoy9x5gqTIt/hqn2ru6155TqLMseLsjJQTMMK7piAD2yeMe8OPQ45tSLFWI3NF/07N1HyWtsV4iTudxh9b5BISlDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4dKKhYqB8tI7IZZ6k7k2Z6fDAw5LUNVHxG8eN/PK9M=;
 b=mszrBaZtlPjTg/2wNbMS2sj59WnB/zRla8opS+QCY4ZlgxMH+nquQ40QWNcCviUkcgGHSxJDdLEQ+ymFOiSx/SaxqgrZxEepJ1F49qt7J2xbEcl60KEUk8rDThvHcTEKB3uvVm9iE3LMza88CBmtQOX7wAfk89jDsiAxhQvDd4tFjUZyokLSvsQvJiKdIcpGJ+1wMR2/SdGTJO53otBj90IEVs+iTIqV++4i55LlnlfomHu306wKiLWOULvvaUV/dNrSJI4nP5nUjTEGdI0dzOYY138pnGO01A8w0/QCed4sQPxvqaR76u2/cJOVSpLeuop9KnSwv2UA56BRG91ydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4dKKhYqB8tI7IZZ6k7k2Z6fDAw5LUNVHxG8eN/PK9M=;
 b=KMzqHz4SoKf16UbNLtw5yNT91eoqO6HTyXMsqZq/oO6JDK7hEyzowrF0xP6DzpBFRLpkZSBl33DiLfZ3eJJ9NrNQYK+F3KL+EAIB6HDVmQM70oc9NRsREJkNvky6vgruAkf+QZzaWbSa2JNlNiB9i+ifEgK7M9c6wS2UuVS/vk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 09:52:24 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%4]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 09:52:24 +0000
Message-ID: <cacaaca9-15f7-4b49-a3cf-376f88ca5186@amd.com>
Date: Thu, 7 Nov 2024 17:52:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: Explicitly specify data type amdkfd_process_info
 in related functions
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241015035150.1477582-1-lingshan.zhu@amd.com>
 <db85737d-9489-453f-85c2-dbd740a98904@amd.com>
 <a938652f-b641-4afa-88a5-47308ffccecf@amd.com>
 <7521be7c-d597-4e23-9bb3-385c0b7dc458@amd.com>
 <17d259aa-9d44-47a4-8087-5cb9c3fb9a17@amd.com>
Content-Language: en-US
From: Zhu Lingshan <lingshan.zhu@amd.com>
In-Reply-To: <17d259aa-9d44-47a4-8087-5cb9c3fb9a17@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0045.jpnprd01.prod.outlook.com
 (2603:1096:405:1::33) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 1908d057-a6d4-4300-f07f-08dcff11e1b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0RiRXVwWFR4NTQwWjIvRjJJUVNDTTIxdWU0VGFjR1hKZmd6UUVNSm1YdS9E?=
 =?utf-8?B?d3NUY05TTUZjdVk5ZHpTa0J1RFcyYnN1elI2VmJ3TXc0WWlkL3hoN3BCTFQ0?=
 =?utf-8?B?N1p2UExZRmF2RWxVOFpuaEFRendqU2pIc0tQUWNmd0lJdUxyZzM2MmpLUDFI?=
 =?utf-8?B?WkFrM2pRbWRiUjhleXAzaUo1M2NHaFJsUVp6V1p6WDdDUjNJRWh3d0FLZ1p3?=
 =?utf-8?B?UGRVZHRDWVNabEVEeWZjTE1oMG96c21sSHFXODVURjlDNzJ3cHBXM2V1MnFx?=
 =?utf-8?B?THhDMUUxTGNENTFqb1NiRGlEb1lYMFV1cHcwcFcwNjdlVGJvL2NwalJYcTR3?=
 =?utf-8?B?SHIwbjQ5K00vUFRqNXEvaEJpUkZtUjZLNU82VFhlYi9WcGtTSlhkYzMydVdP?=
 =?utf-8?B?UFhjSzh1K0kvSENQMDJhU3A1bDdhVENxdE03RkFqc01DMjBlU2lUek4zSFRq?=
 =?utf-8?B?ejI5ZmZDZHY1M0w5dVN3MVA2eVd3bVpLM1NVSnJoVjRsWDJMRFVHNHFDRHJ2?=
 =?utf-8?B?TTBiZmVDM0NnMmhOWnlkSmkyUGQ4Q1UxUWszUE9TZGZHYk93MEdFMUFiSWlm?=
 =?utf-8?B?VTF0cjF6R212L3BUMmZ5WlFQUmN1ZVBFb3ZwOTNQNzE3M29CS3dpTE5FNEhU?=
 =?utf-8?B?NDRVcHdHMXpYdS9wUG45ZHBXc2NVTmhLRHJUSFp0a1V1OStPTTZXV0MzZmVD?=
 =?utf-8?B?d05ZS3BMRHpIc2d2ZzZuL0VZLy9MaWlwbThIRVgxdTJ3L2RMMHNOY0NxaDVv?=
 =?utf-8?B?ZjBBd1ZpVFplN0Uxa2dING5VNEpBY2M4SURsZVJEWWJETUVIUEl5ZGNLbS94?=
 =?utf-8?B?TkxIenVXOTZ1RnhNdWhXNCtONlhqeXVVamp1T2doODJ5V2NOeDNFZVloZWtS?=
 =?utf-8?B?MWkzZlU3Wk44REwvZysrMi9hZFVjaE40VStWd0NoZ0M0VGNHMHg3YUxsWGN3?=
 =?utf-8?B?TzJiNGE2bU5PeG5MOGxBbTlJaDYzRTN6dG9mdEdWeVZxd2FFRHFKRDhBQWZE?=
 =?utf-8?B?ODR5dWNxbWVrT1oyRTVFNVVtU0ZLeW9EMnk3V0ZmRUs5QndxejNIc3RLQWlS?=
 =?utf-8?B?YURkNEZUUlBqTmh2SFpjSXlpRlp3OFBpbUMvd1laTVVNUGlRQVlBcnVUL1I4?=
 =?utf-8?B?bnlObjVvVE9IdkxMT1JPOUd6b1hqZWFyL0o5by9OMy93YVYrN3JWdWJsS0Fl?=
 =?utf-8?B?WnFTdFBtRUh5U1lWMWpYMFdQVjFLT0tUcG9VaWdwLzU1NXVpczBsTURWVjEz?=
 =?utf-8?B?R0xCR1hlL25Fd085QTZTRzJYRkhGZjVyRlI0NFY0S3djTW5rVHkwT3Q3blhE?=
 =?utf-8?B?NzdwRFIyaEZHQW41RDJlOUtZeXFKWHdvZjZOQ1l1dE9BcjRGK3FTc0w1RzBD?=
 =?utf-8?B?RkxsQWpBMFpielhua2MzWmZ2N05mNWhmbkxOZDh4bXFlcnhtZjdqRkVQU2ZE?=
 =?utf-8?B?cEpBUW4xeE5SZGNyMWFvMCtvSzIzUnFhMVdZQVZzbzlJSDdENGlSNU8zN0Rk?=
 =?utf-8?B?Z0xZT1ZxZGNqQ3R4d1B4Qk1FVFpKa0t3Qy9GSTVsenhXb3BheTRmcDg0Y000?=
 =?utf-8?B?NStmbmUwLzlWbHBIOThGZDIyZ245MXkySzhraFhJNWY4S2kzN2x4UmFGZVdy?=
 =?utf-8?B?Q3VxZ1NEZU1vL2xHT2ExNzBKUGlNVFlka3pJa3FTU0dNT3Yya1JDVkVlYXRr?=
 =?utf-8?B?Ynd3MkNMbDN4MGpsMUFRMzBIZnFGdW8xS2VkNDREajJqWTRuVjZ1OEc1OWln?=
 =?utf-8?Q?YSX1BBHtKalhtnPmGMD6x+U56/xXGg8QKMd3/SK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTVHN3pGMG5ZYXJaUGdzVFdNMmMxQWJuOG4wQjBaQUR2NnlURU9NdzhNcUQy?=
 =?utf-8?B?OFkrdktGaDArWjlFdlRJS2dIYjJ2T1dCNW8rVm16bnZTSWM1UlNGOHgrZnAv?=
 =?utf-8?B?V0JtQ1F0c090dnhPOWdkbVlXZ3lHR1M0cmxsNmNKL01BY1ZIYzVnblk3S3c5?=
 =?utf-8?B?aFgzTTQ3UEplVzI5T1oyS29uL3dNQlVRV2lUMlJ0dEZyeUJtOE1KYTFYVyt1?=
 =?utf-8?B?dlk3VHYyWXJoZVdKQmdNYUM4aVhsSTRQbUo4b2wzaVUzNjdKTHNYR1NDVzhs?=
 =?utf-8?B?STM1ckxwZCtFMTVHdnVwdEwrNzVyMWtZWW9IZm1ESXZ4WVkvT3VReksxVEpL?=
 =?utf-8?B?MW0vTG5IV3RKTGRZbjNjM2VIOFVyNmgweUhNR3NuRG9VZmkweHoxYkRGd292?=
 =?utf-8?B?VXBtUmdRbVFtLzlWU2VHaVJpZy9tdVVHV0tyVlU1MWhwOXJNbG51VjZQbWx1?=
 =?utf-8?B?NGFIVTg3NmxQQkxFdFUvTEFoYlk2NGdWZEdTeU1rY2RSc0RFSWFrcHI2TU0y?=
 =?utf-8?B?QWtNQVdRWUZMOWJtQUhGN0M5TTVxY05PaFFDaTFFSlF4NkxpSERQRFlqa0dL?=
 =?utf-8?B?cGN5ZzYxelg2ZXpENU5aNmJnN01wRE0ybFcrd1o4K05KQngyanQ0QUFINm1i?=
 =?utf-8?B?M1pqMHhuTWJuemxMNXZweTVLNStLek5WNDYrUTdCa2xyY2JoRmRpeitkOC9Q?=
 =?utf-8?B?R2J3MVRxUDFJV3Nna2JaUjJqOHM0cVR2TmZDenN4UzNnQXA0VS96WStkSENE?=
 =?utf-8?B?VDlpZDlaeDlTMG9yWVVuY2tDKytma0szOVJpbHVMNmVMRyt3M3RpUG1EQ1JV?=
 =?utf-8?B?NnNERWNDVE03bi9hZ25kNENUdE9OdjFhczZDVGtJbVZTZU5sQWE2UkNIdGxj?=
 =?utf-8?B?UitpMzdRcDVQQlh0cU5ucjd5RG9aNnROMGVYcFpHZjdFMnBhNHFQZHQyd2lq?=
 =?utf-8?B?aWlZVndac2xqS0IwMnZ0QkVETzRrSlY3WHN1QUdwZ0J4Q0c1V0R1TVZBeFZi?=
 =?utf-8?B?Q0hNNVFjZmQ5eXV0TUNpcDd4OXNZQmFuRTAxMFd2NW11dnlBVzhKdG8wdkt2?=
 =?utf-8?B?ZDVpcklyU2xQZ2JjdExCZElCYnpsOFd0ZlVJVmo0UXgycUZqOU9JTHZKWXRq?=
 =?utf-8?B?a2J1QSt2UXRFb0tVaGtGYmM1MTlwSGd6ekJzN1dDV1RCQ014ZkpQR2N6WXVj?=
 =?utf-8?B?UDJlbm92RE9ZaHZPME9Gdi8yVTdKUTZwZHY1L0FOQVlRL1ZJZWpHQTRkWk5i?=
 =?utf-8?B?ZnZDRllCTUpKSDgxcHdRU1JISDVyeFMxalpYWDRYWmZOeVRwaU9ZUEh5Nzh0?=
 =?utf-8?B?czZMUDlZT3MyYnRmYkNVS3FHRjllOHQvUFJwUDl3Yk9XWFZvWUJTZ2RVUXhU?=
 =?utf-8?B?T05KS3k1MXNWZXJxWkt2TFFmQi9hYW91MW13UEp2aDAyWFdkMFVDbFNDc296?=
 =?utf-8?B?Z0hCS1ppV1JmQlExQzV3Z1h1eTB5ZTZxa3Z3OWttU3l3QUJ2enhLQlNJRHhD?=
 =?utf-8?B?TUY2VnQ0VDRPdlNmQ05Jai9TYVlCS3oycDAxQzJkT2JQUC9iN2lyWXlRZ0Ry?=
 =?utf-8?B?amc5ZzJrMnZVcUQwY2N1aWRsdHBGVGEzSXJBTzRad2VxTE9NaGNxbzN6YXNL?=
 =?utf-8?B?SmRIdkdNQnV2ZDhsRElCYU5hYm5lY0h6eHFNT1VBRE9PN1VxYU8yNFFXbytG?=
 =?utf-8?B?b0NBbjE4bk8zMC9xbGFDbFdEUThNdVBBYkcrbHluZUhHWlltVXlFL045UWlL?=
 =?utf-8?B?cnkyZ3FjVEZoVFpleDJzclJBSmRacFVKeVZLbjd1YlRkbjlpUE02OHpsOXJh?=
 =?utf-8?B?K3YvbUE0UmlZTWNPeDh5VVdhbEFKTGhJUmZ0ZUVnTUM3S1R3SGNVZkVwOUVE?=
 =?utf-8?B?NVR5RlpUSGFSWVdWaUlGaWtnQnNzS1BMZFJMUW9wVnF4WW16N1RYSTRONTBW?=
 =?utf-8?B?djV6MEhzQXJiZ1hqM1FuWDlyT3NWMERYZFhPejRhSERUSm0zZWVNU1l6dlVJ?=
 =?utf-8?B?SHpaRDZPMnZjRndaTm94a0g4cjQ3RUtyUHdGUUUyUmt3WnhnNHBTVmlWalI4?=
 =?utf-8?B?RDNpMjR1dkZNWjVlaEtTQ1k3Y1c4VjJpbVZLMmg4YlIzMnlRNm5xVVNIUHBV?=
 =?utf-8?Q?QhG7+Hohd3Zr0EU7pg2HYvX0W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1908d057-a6d4-4300-f07f-08dcff11e1b0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 09:52:24.7807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqurvyGS+sWjJgikue8qOXMi2YE/bNzfsXn46BHV7MehonlELyscOyPw97iokpP58joUx6zvV1qwuQagM/6pmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147
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

On 11/5/2024 5:49 AM, Felix Kuehling wrote:
> On 2024-10-31 23:20, Zhu Lingshan wrote:
>> On 10/22/2024 4:01 PM, Zhu Lingshan wrote:
>>> On 10/22/2024 12:20 PM, Felix Kuehling wrote:
>>>> On 2024-10-14 23:51, Zhu Lingshan wrote:
>>>>> This commit specifies data type struct amdkfd_process_info
>>>>> rather than general void* in ralted functions.
>>>> Several interfaces in amdgpu_amdkfd.h use void * as opaque pointers, e.g. process_info, mem_obj, drm_priv. The reasons are partly historical because KFD used to be in its own kernel module. That said, there is nothing fundamentally wrong with opaque pointers when the upper layers doesn't need to see the contents in the objects returned by the lower layer.
>>> void * is workable but imperfect, IMHO it representing a compromise that could ideally be improve especially when we know exactly the data structure type.
>>> This change provides better readability, type safety, compiling checking, and avoid the castings
>> shall I make any improvements on this patch?
>>>> It makes me wonder, though, why you're singling out just process_info? Are you proposing to change more interfaces to eliminate opaque pointers?
>>> That is because I just happen to read process_info related code, I can surely improve others if any individuals of them also represents a certain data type.
>> do you want me to change all void * opaque pointer in a series or just this one for now?
> I'd prefer to keep it consistent. If we decide we don't want opqaue pointers in our API, we should clean up all the APIs in that header file. Or we decide, opqaue pointers are OK, and we leave things the way they are. I'm OK with either of those two options. I want to avoid a piece-meal solution that leaves things inconsistent.
I will try clean all opaque pointers that always point to consistent data types. I will send a series later.

Thanks
Lingshan 
>
> Regards,
>   Felix
>
>> Thanks
>> Lingshan
>>> Thanks
>>> Lingshan
>>>> Regards,
>>>>   Felix
>>>>
>>>>> kfd_process->kgd_process_info is initialized
>>>>> in init_kfd_vm() by such code:
>>>>>
>>>>> static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>>>>>                        struct dma_fence **ef) {
>>>>>         struct amdkfd_process_info *info = NULL;
>>>>>
>>>>>         if (!*process_info) {
>>>>>                 info = kzalloc(sizeof(*info), GFP_KERNEL);
>>>>>
>>>>>         *process_info = info;
>>>>> }
>>>>>
>>>>> That means kfd_process->kgd_process_info is type
>>>>> struct amdkfd_process_info, therefore we should avoid using void*
>>>>>
>>>>> Using a specified data type other than void* can help improve
>>>>> readability. There are other benifits like: type safety,
>>>>> avoid casting and better compling chekings.
>>>>>
>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>> ---
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 10 +++---
>>>>>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 31 ++++++++-----------
>>>>>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
>>>>>  3 files changed, 19 insertions(+), 24 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>> index f9d119448442..c1346b8c9ab7 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>> @@ -239,8 +239,8 @@ void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj);
>>>>>  int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
>>>>>  				void **mem_obj);
>>>>>  void amdgpu_amdkfd_free_gws(struct amdgpu_device *adev, void *mem_obj);
>>>>> -int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem);
>>>>> -int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem);
>>>>> +int amdgpu_amdkfd_add_gws_to_process(struct amdkfd_process_info *pinfo, void *gws, struct kgd_mem **mem);
>>>>> +int amdgpu_amdkfd_remove_gws_from_process(struct amdkfd_process_info *pinfo, void *mem);
>>>>>  uint32_t amdgpu_amdkfd_get_fw_version(struct amdgpu_device *adev,
>>>>>  				      enum kgd_engine_type type);
>>>>>  void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
>>>>> @@ -299,7 +299,7 @@ int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
>>>>>  				     struct amdgpu_vm *avm, u32 pasid);
>>>>>  int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>>>>>  					struct amdgpu_vm *avm,
>>>>> -					void **process_info,
>>>>> +					struct amdkfd_process_info **process_info,
>>>>>  					struct dma_fence **ef);
>>>>>  void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *adev,
>>>>>  					void *drm_priv);
>>>>> @@ -348,8 +348,8 @@ void amdgpu_amdkfd_ras_pasid_poison_consumption_handler(struct amdgpu_device *ad
>>>>>  
>>>>>  bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev);
>>>>>  bool amdgpu_amdkfd_bo_mapped_to_dev(void *drm_priv, struct kgd_mem *mem);
>>>>> -void amdgpu_amdkfd_block_mmu_notifications(void *p);
>>>>> -int amdgpu_amdkfd_criu_resume(void *p);
>>>>> +void amdgpu_amdkfd_block_mmu_notifications(struct amdkfd_process_info *pinfo);
>>>>> +int amdgpu_amdkfd_criu_resume(struct amdkfd_process_info *pinfo);
>>>>>  int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>>>>  		uint64_t size, u32 alloc_flag, int8_t xcp_id);
>>>>>  void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> index ce5ca304dba9..2a1ee17e44a1 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> @@ -1376,7 +1376,7 @@ static int process_update_pds(struct amdkfd_process_info *process_info,
>>>>>  	return 0;
>>>>>  }
>>>>>  
>>>>> -static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>>>>> +static int init_kfd_vm(struct amdgpu_vm *vm, struct amdkfd_process_info **process_info,
>>>>>  		       struct dma_fence **ef)
>>>>>  {
>>>>>  	struct amdkfd_process_info *info = NULL;
>>>>> @@ -1552,7 +1552,7 @@ int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
>>>>>  
>>>>>  int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>>>>>  					   struct amdgpu_vm *avm,
>>>>> -					   void **process_info,
>>>>> +					   struct amdkfd_process_info **process_info,
>>>>>  					   struct dma_fence **ef)
>>>>>  {
>>>>>  	int ret;
>>>>> @@ -1639,19 +1639,16 @@ uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *drm_priv)
>>>>>  	return avm->pd_phys_addr;
>>>>>  }
>>>>>  
>>>>> -void amdgpu_amdkfd_block_mmu_notifications(void *p)
>>>>> +void amdgpu_amdkfd_block_mmu_notifications(struct amdkfd_process_info *pinfo)
>>>>>  {
>>>>> -	struct amdkfd_process_info *pinfo = (struct amdkfd_process_info *)p;
>>>>> -
>>>>>  	mutex_lock(&pinfo->lock);
>>>>>  	WRITE_ONCE(pinfo->block_mmu_notifications, true);
>>>>>  	mutex_unlock(&pinfo->lock);
>>>>>  }
>>>>>  
>>>>> -int amdgpu_amdkfd_criu_resume(void *p)
>>>>> +int amdgpu_amdkfd_criu_resume(struct amdkfd_process_info *pinfo)
>>>>>  {
>>>>>  	int ret = 0;
>>>>> -	struct amdkfd_process_info *pinfo = (struct amdkfd_process_info *)p;
>>>>>  
>>>>>  	mutex_lock(&pinfo->lock);
>>>>>  	pr_debug("scheduling work\n");
>>>>> @@ -3093,13 +3090,12 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>>>>>  	return ret;
>>>>>  }
>>>>>  
>>>>> -int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem)
>>>>> +int amdgpu_amdkfd_add_gws_to_process(struct amdkfd_process_info *pinfo, void *gws, struct kgd_mem **mem)
>>>>>  {
>>>>> -	struct amdkfd_process_info *process_info = (struct amdkfd_process_info *)info;
>>>>>  	struct amdgpu_bo *gws_bo = (struct amdgpu_bo *)gws;
>>>>>  	int ret;
>>>>>  
>>>>> -	if (!info || !gws)
>>>>> +	if (!pinfo || !gws)
>>>>>  		return -EINVAL;
>>>>>  
>>>>>  	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
>>>>> @@ -3110,8 +3106,8 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>>>>>  	INIT_LIST_HEAD(&(*mem)->attachments);
>>>>>  	(*mem)->bo = amdgpu_bo_ref(gws_bo);
>>>>>  	(*mem)->domain = AMDGPU_GEM_DOMAIN_GWS;
>>>>> -	(*mem)->process_info = process_info;
>>>>> -	add_kgd_mem_to_kfd_bo_list(*mem, process_info, false);
>>>>> +	(*mem)->process_info = pinfo;
>>>>> +	add_kgd_mem_to_kfd_bo_list(*mem, pinfo, false);
>>>>>  	amdgpu_sync_create(&(*mem)->sync);
>>>>>  
>>>>>  
>>>>> @@ -3136,7 +3132,7 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>>>>>  	if (ret)
>>>>>  		goto reserve_shared_fail;
>>>>>  	dma_resv_add_fence(gws_bo->tbo.base.resv,
>>>>> -			   &process_info->eviction_fence->base,
>>>>> +			   &pinfo->eviction_fence->base,
>>>>>  			   DMA_RESV_USAGE_BOOKKEEP);
>>>>>  	amdgpu_bo_unreserve(gws_bo);
>>>>>  	mutex_unlock(&(*mem)->process_info->lock);
>>>>> @@ -3149,7 +3145,7 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>>>>>  bo_reservation_failure:
>>>>>  	mutex_unlock(&(*mem)->process_info->lock);
>>>>>  	amdgpu_sync_free(&(*mem)->sync);
>>>>> -	remove_kgd_mem_from_kfd_bo_list(*mem, process_info);
>>>>> +	remove_kgd_mem_from_kfd_bo_list(*mem, pinfo);
>>>>>  	amdgpu_bo_unref(&gws_bo);
>>>>>  	mutex_destroy(&(*mem)->lock);
>>>>>  	kfree(*mem);
>>>>> @@ -3157,17 +3153,16 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>>>>>  	return ret;
>>>>>  }
>>>>>  
>>>>> -int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem)
>>>>> +int amdgpu_amdkfd_remove_gws_from_process(struct amdkfd_process_info *pinfo, void *mem)
>>>>>  {
>>>>>  	int ret;
>>>>> -	struct amdkfd_process_info *process_info = (struct amdkfd_process_info *)info;
>>>>>  	struct kgd_mem *kgd_mem = (struct kgd_mem *)mem;
>>>>>  	struct amdgpu_bo *gws_bo = kgd_mem->bo;
>>>>>  
>>>>>  	/* Remove BO from process's validate list so restore worker won't touch
>>>>>  	 * it anymore
>>>>>  	 */
>>>>> -	remove_kgd_mem_from_kfd_bo_list(kgd_mem, process_info);
>>>>> +	remove_kgd_mem_from_kfd_bo_list(kgd_mem, pinfo);
>>>>>  
>>>>>  	ret = amdgpu_bo_reserve(gws_bo, false);
>>>>>  	if (unlikely(ret)) {
>>>>> @@ -3176,7 +3171,7 @@ int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem)
>>>>>  		return ret;
>>>>>  	}
>>>>>  	amdgpu_amdkfd_remove_eviction_fence(gws_bo,
>>>>> -			process_info->eviction_fence);
>>>>> +			pinfo->eviction_fence);
>>>>>  	amdgpu_bo_unreserve(gws_bo);
>>>>>  	amdgpu_sync_free(&kgd_mem->sync);
>>>>>  	amdgpu_bo_unref(&gws_bo);
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> index d6530febabad..b0426a1235b8 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> @@ -934,7 +934,7 @@ struct kfd_process {
>>>>>  	bool signal_event_limit_reached;
>>>>>  
>>>>>  	/* Information used for memory eviction */
>>>>> -	void *kgd_process_info;
>>>>> +	struct amdkfd_process_info *kgd_process_info;>  	/* Eviction fence that is attached to all the BOs of this process. The
>>>>>  	 * fence will be triggered during eviction and new one will be created
>>>>>  	 * during restore

