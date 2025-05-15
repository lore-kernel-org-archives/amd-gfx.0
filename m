Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F213DC2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 20:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DE8810E952;
	Thu, 15 May 2025 20:05:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gSa4i2jH";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D313210E952
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 20:05:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZKVwO1JmKmHa8gEt319cj5PKuDVEUcLORU42gMccBNyDFB4FGSEk/6By7Hh0RP7u7PXnnGMCdjkqSOZp9WZEC5ggi+r4p0mCbRTmr4G1+8AurLvVu+oTSCfQ93trhXePllGCb3J2m0PGdkLw6vOnhBr0eIpdeXl1SWVL/HSq9Q/vj/MFi33ZHBEaUHJtAHe92mbUYSdORs0AWMlZPygcQOWBHZAOqvS8Qzdqhs+O05dhbqeAr1vL+D0TmK7EpXeys70qw/bxnWHlqDBBfmWtg5TF+RlTMhUtZ0art7Qx5C7LYDoxQadlbdHkBx5ZkTSQBBVKRuUUHq0MoNMqgoajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhdyaHVhvhEvf8xsp2kCj3Q4gie1znv/kk50KBHRpfc=;
 b=kYgKjk1bTsVtoR7LQTNBkic+7pgqVwsl/notEvtCPRJ6Al7PwA24VTljS82jxY7SAYvomjcUQtgYGoR02YMRkjCZmRYXohJkpvodhv1rGg35scYUprH6yh4xg3w9l9fdLRg5VQvEPYVPoojUeGaxUi4SscWPLRPXynAWwBM8hNY+P8bLzQi5TqEfCcFilbO1EGiNb85/sq94rFtnQuXlXA6BhVR2U6keycSaflFt92G7ADqB+ilYqtHiI1aMHIk3ICiyWh3A5+ypeFFlNAynNiTvTk1mUHYFyRvrLb3yLS1eHokHhTrvUjTZ78m/2BfZJY8tZxOOM6dTu99Cc1Vx7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhdyaHVhvhEvf8xsp2kCj3Q4gie1znv/kk50KBHRpfc=;
 b=gSa4i2jHTdnXrvP0iYaR/qZCZqiBUouZEkZyf78E6KrGgsBN+JW0ExCk4iSHdj22AfsxIZx4rszTqjA0W2ZG9YWWeX/1cAnLIOwVGVAjSTX1YScepqgVCdeaLivDueAsMf5wxbKrgOo0DpCvgwg9MWCgxDdPBIGlZ0143UAsvzg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4203.namprd12.prod.outlook.com (2603:10b6:5:21f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Thu, 15 May
 2025 20:05:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 20:05:06 +0000
Message-ID: <293be6eb-6b48-4433-8137-576732f0bef3@amd.com>
Date: Thu, 15 May 2025 15:05:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amd/amdgpu: Add GPIO resources required for amdisp
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, christian.koenig@amd.com, mlimonci@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com
References: <20250515195504.1099467-1-pratap.nirujogi@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250515195504.1099467-1-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0186.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: 295f951a-e2c2-4913-7ce8-08dd93ebc950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0g0YnpNZzNvR3h2NlRNZzVoUTlSSEF6QitGNlVUY3dmQTFKWiszaWh3emli?=
 =?utf-8?B?TCtkWFpvZHJlQjdLb0xySUYrMGg2QnA2WHFWZFM5bWYybUNHODh2UDJreEcy?=
 =?utf-8?B?eEpkNW4vZ3NuQmttamk5QlhYOU91U3c3bjU5YmJzeDRUSVhadHBzaXRXbFVG?=
 =?utf-8?B?MzJCQXNTdVpodFplUTJvNlRqNndWWVJlWmhCczU0VERhcGx4VTFMTmFjWXFC?=
 =?utf-8?B?dHhMVkV5WEI5VitNMUxpMFBYcGtaTEVoM1dKb1pQdGJHeEt0WFUxTnl2dVZZ?=
 =?utf-8?B?VXluK0VSM1BoNjlyR0Y3UzJkMGVrMzNwcTJTNFVCemNpUVIxNUQwSW12VExr?=
 =?utf-8?B?MGR0N0Y5cGZSbDlkeDVDaUFjQXRxa01mWUd2bXZIQ0xtcnExSm1LTzN4MXB0?=
 =?utf-8?B?T3RyTDJBdjZRT1lic1B1NkphYzUzbHphOFdDdEoxYlB0UmtLSlBxczExME1o?=
 =?utf-8?B?OEliaTZqMUpzQkgxdW02K2IrNWhuNkc1NE1PbFlMN1E3ZjV6MzlHK0pzajFF?=
 =?utf-8?B?TERDSUlscHBXNEJXQ29GZm5sOG5PektNcWNYUGdDNmFmTzlYUjB1NFoyUHhC?=
 =?utf-8?B?OHFSL0ZzRDNMdGtyS0lVRzBlc1NDYjh2UjRoK3ZPUUlvWjlkU0hkNWdxM3JV?=
 =?utf-8?B?eHFILzVOZm9RaXY4UHVHNmRnck5TbFBOTitYQ0VFR1UwTmRpckNLeFJhaWhl?=
 =?utf-8?B?OWNMb1FyL3dob28vU3dMTjU2YzBWWXlxUVdwUGFUZERMeldaQWJrV2JjYXlE?=
 =?utf-8?B?ZmYwNXBnNWQ5REMrQ0IzSHRxTTN4ZEpZL3lVUHBzOXlsRXhKZXJzVnhLVjBG?=
 =?utf-8?B?ZFR2aGNJRjhzNUgxcUFtYTJ6WG5zTTlkSmRJRXcwczByczd5UEVyL1AyM1Rk?=
 =?utf-8?B?N0tuS0xJbUJrMTYyQ3Z3OXlUc1Nha0dMODVBNVpESkJFR29oTm5NWWQrbWNB?=
 =?utf-8?B?S3Q3MVZ5Nkd3azRnc3Z4VjRPaDlFL1hWaVhFRkVKUWo0WitxTkFUdFlVcVVT?=
 =?utf-8?B?dmJTZ2ZzUVlzWXNKVWRSajlYc2tLTE9UZXMyelNvalMwa3BhaEdNTzhIdHpu?=
 =?utf-8?B?YitqNmttQkJJb3ZrdnpRSVpPUmJCdjcxOG54WHRPOHBwemY4TUZDaElFOXp3?=
 =?utf-8?B?RldzdUdweTlIMzFqOW9SRjE5Q1VuSUlCVXZLUTNuSUJUYTJCVHBURmlxWHZl?=
 =?utf-8?B?QkxGUnJ1OGI5QnNuVDQxS0t2VFpzd1I2YnVxU2pmYVdPb0ZMYWpsYnQrZ1JF?=
 =?utf-8?B?NUFUSGZGYU1FN0ZMN1NDM0k4Z2YvUXJ2bHF2Z1R6d1RIdFNzTGsvcjJ3RS9w?=
 =?utf-8?B?ckVsZjFOaSsyWkxIY3BJR2Y2VHRrRUNRNytGZFFSM3V2Sk9hayt6ajc4eUFG?=
 =?utf-8?B?cjNHaHNORlg1bG9QdVlXd0I0V0VtSEF3SVVlV3o3NlZMS2NrZ0tYbCtrVEVj?=
 =?utf-8?B?UFJrRUNCbWZMb21IOTY1K1pOK0ZQUytNeVVmbHlLdENnNUNCWVhldkNjMVVH?=
 =?utf-8?B?VmQrd1lpUEZZQmZvSGplM21SVW9zS3I3UnpwdzR4SHEvdnBrOWdPMytGT1I1?=
 =?utf-8?B?cU1OQ2gwdWhuMWFERWRWSE1yY2pwWHkvcUEzME9KOEdZaEIzVllBNHlQUUtE?=
 =?utf-8?B?OWFFOHdFVEFUMS9wUWR6djNLNG1CczVacFZ6WVRqWWRRQkoxemV4SHBHeTFy?=
 =?utf-8?B?dnhCOVJTUXpWUHZzeFFsY0FWekpRMnh6cDJHekw4TUlGTkVmZ1dndEVOWUdD?=
 =?utf-8?B?ZDZSZkRQc05JRkluVFpHQ3hUWjVCWnk2OVBJZHF3VzVEbWNxeUlqeDd2TU12?=
 =?utf-8?B?djZUYXg0b0lGMzRjQUVnL2ZmeGQreEdMMVRFcUlwWi9BMzRXWEk0endFNlFD?=
 =?utf-8?B?QVlTeFVQUDNHY0E4cWEwYnFmR0NFVTJpWUduTFJUU3lIbTB3NitDeExTODF4?=
 =?utf-8?Q?/Fc+IKPF5sE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjBBaG43MTA5WHVXZSt6VkNrZzVsNEgyb2VrVkpYdy9VL09xM3FDejhsRnMy?=
 =?utf-8?B?U3NyS2RKaDRsd3ZPd012S3Nsb0tLTGpIOGVFSmpyNkZicFB2UlF5K2xXdVFJ?=
 =?utf-8?B?Q1hFd2FFcmp6eDlpNDNDK3plT2lveWFwbUZHa1pwNVM1RklUK0hTYUFTcFYv?=
 =?utf-8?B?M0o1N1VMT2NncWRNOXVrOUVJaGhSTGxLeUNQTVZ4cWloa2loeXBWYXNQbTUz?=
 =?utf-8?B?RkxwTXdsdThmaVVnOVRYUWEvTGtOVkZOdDFySzU5cUZTL1FKbnYvSm01SWhD?=
 =?utf-8?B?RUl2T1p4TmF5OFcrNHFIblNEQXBGSUVVNk5qMkp0R1lJbTRmMU9qNUFuL1pF?=
 =?utf-8?B?cFY4dk9LTHlhSDB0WE4zc3YyckV0UjJVMXRSbHJCVzVMTmJKYngvYmJhdER0?=
 =?utf-8?B?OE43QURtMGFpVFlwRjE3QzRncUltaWxNLzhGdllRWHdxbWl0R1g1UzFVRGNz?=
 =?utf-8?B?dHRiR29yV0k5K1ZxRm1pZGE0OVhGdzB6Y2xFV3I3UlVMTHpWNzBkdVdYWUNL?=
 =?utf-8?B?ektCem9jNmo1M1VDNXkrYW9jZTJyejdkeEdOeGVTVXRORFFnQndqOFZHUitk?=
 =?utf-8?B?OGw1bEVxNUpvd21salpLZkZqVTFLdjk1WVBKSkNpc2NTZlRsQVVST1BxUDdU?=
 =?utf-8?B?cXNOSHB1QURrWDJJWndSZVgwSFJrdlErRWZpV09xdVdKODZlTkgrbHFjZ0hy?=
 =?utf-8?B?N1NmNDZCSXBTam5KaEp5Vkx4UjZNVDZZRUxRRTZOWEZ4a0hTR2cyelVpaGcz?=
 =?utf-8?B?djF1cEcxbmdDQ0hUOUJBcjYwTGpSdEdSTStFRXIyd0tqczRvbmY5dTd4c09R?=
 =?utf-8?B?SWNWaE1kQ0Rwck4yWnBRVFRRZ0JSU2t2anRPbzBpRFZscDkxZXdJTUc5VlN0?=
 =?utf-8?B?djZiWU9wSHpsWnkvTnRUZnVBRStsQ1BNYUxid3BvY1pNTllZeG52KzdvU2tU?=
 =?utf-8?B?L3RlbzV2YkRhaXdCUng5cEkzRHNEc3FKMTVMbjl5bGo2aWlnYS9GRXU0RUhq?=
 =?utf-8?B?eVBNc0NDdzA4UWpZQVBETkZ5Yk9oSjVUY3U0bkk0NUJkMmYxbEZmUk5XdDVM?=
 =?utf-8?B?MHZSdHVvalB0eUN5WkkzK21mQkVuUEllM3NSb0ZaamxGa29hM0NlU3pHcTBZ?=
 =?utf-8?B?NEF4ZVcwd1Zick0xQ09pMHgxb0JVVGo0R2NrSEl3SVAyR1ZwbGJ4alhqQWkw?=
 =?utf-8?B?bUkxai9PVmg3OHZRdkhUN0ZZRnNrZ0tWUGlhQ0h6R2tGaHIrcFVHY29QbUxM?=
 =?utf-8?B?Vm4vM1pOVXh6Umw4SWF2SWdVcXlMOFE1ZVloMERyRFVmYUFSbzcvTW1kbDBo?=
 =?utf-8?B?dUN4S0Fyc2RTNXRWVjhGSHF3cWdmcUNDeWhrS29qOWFCWnNjUFMzNVdQdEpj?=
 =?utf-8?B?Yjg3TkhleG4xb29od0NTYXQxTDZsNjhsNmtaQTBUNHNRNlgybWF2OUxvdHhr?=
 =?utf-8?B?UVhrYmdSRndhYS9najgvb2UwdksvbHFicG82Rm44QzZ2Nmc1ZVZmdDVFaUxm?=
 =?utf-8?B?SEx3elljRVNEY3QwRWtTSkkxZDkwZFRlOUF6emdlbmdLYjNmc2tsZDNqL3hn?=
 =?utf-8?B?OVRvYlNFcGs1VS9DK3JrbGV2ZFMvak5Ib3NSTkR3aXRKbDlhY2MvTWlxV0I3?=
 =?utf-8?B?MEFUZmhxRmhkaXZEWkJRdWlMZGFLNVVaWnJsQmlzSkdjd0E2QS81SFVCYTVy?=
 =?utf-8?B?M0hwMkMzVVYzWllEQWNZZTFId1RxUFA0eUFaRUFYMmplKys4bzh6eG95aFNk?=
 =?utf-8?B?NjQ0RmxQUHYxekMzZEhodWxBWFZKWW51TVo4K29lN3ZkeXM2TGFWQTlCYUR3?=
 =?utf-8?B?WjVUOVUvcU9BNXpxSmpOQXY4VFo2eHdsSFY3dS9xVGt4enlqYUtPSVYwOXA5?=
 =?utf-8?B?VGRMTjk5TjhLZWppUUxreGlTRGJOMmRCVkFXQnNyMWVsNVBUd2JGRjJIYUFa?=
 =?utf-8?B?S0lrc21vS0JYWmUzQ3pWWlVtNURHeUgzMktUMkpWUWhmK1JuMjcvV2VQTUJX?=
 =?utf-8?B?ZFlFMFdDZjZRTWFSeW04c21WRTVCNE5hWkxkKyswZ1JDK3paQnhLYTMvTVpz?=
 =?utf-8?B?dGpLWEV0QWpieUEvbU9Gai9uR1E2eWdrdGw0Nk9XL2ZLczZ1bW9RQU9uRFQy?=
 =?utf-8?Q?jDv6g6AMKE9Ing8arubF1ES85?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 295f951a-e2c2-4913-7ce8-08dd93ebc950
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 20:05:06.2602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwJrwQqUiztNZ72iA4XF0p49B8OCEvEyCyQAxzstBiSglCNgObluHtF5YjclQLVqFedEKpPHWZq6Jstw9Ww9oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203
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

On 5/15/2025 2:54 PM, Pratap Nirujogi wrote:
> ISP is a child device to GFX, and its device specific information
> is not available in ACPI. Adding the 2 GPIO resources required for
> ISP_v4_1_1 in amdgpu_isp driver.
> 
> - GPIO 0 to allow sensor driver to enable and disable sensor module.
> - GPIO 85 to allow ISP driver to enable and disable ISP RGB streaming mode.
> 
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> ---
> Changes v0 -> v1:
> 
> * Add amdgpu_acpi_get_isp4_dev_hid() utility to retrieve isp4
> platform device hid.
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 29 ++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c  | 35 ++++++++++++++++++++++++
>   3 files changed, 66 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index cc26cf1bd843..b63ceead2499 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1657,10 +1657,12 @@ static inline void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_cap
>   bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
>   bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
>   void amdgpu_choose_low_power_state(struct amdgpu_device *adev);
> +int amdgpu_acpi_get_isp4_dev_hid(char **hid);
>   #else
>   static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
>   static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false; }
>   static inline void amdgpu_choose_low_power_state(struct amdgpu_device *adev) { }
> +static int amdgpu_acpi_get_isp4_dev_hid(char **hid) { }
>   #endif
>   
>   void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index b7f8f2ff143d..5e04f4b7d0ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1551,4 +1551,33 @@ void amdgpu_choose_low_power_state(struct amdgpu_device *adev)
>   		adev->in_s3 = true;
>   }
>   
> +static const struct acpi_device_id isp_sensor_ids[] = {
> +	{ "OMNI5C10" },
> +	{ }
> +};
> +
> +static int isp_match_acpi_device_ids(struct device *dev, const void *data)
> +{
> +	return acpi_match_device(data, dev) ? 1 : 0;
> +}
> +
> +int amdgpu_acpi_get_isp4_dev_hid(char **hid)

Looking over this signature two comments:

1) To help avoid any risk of mistake in the future I think it's a good 
idea to pass in the size as a second argument and then use that in 
strscpy() below.

2) Does this really need to be a pointer to a pointer?  The way that 
you're using it I think you just want a single character pointer, 
especially if you use my suggestion below of on stack memory instead.

> +{
> +	struct acpi_device *acpi_pdev;
> +	struct device *pdev;
> +
> +	pdev = bus_find_device(&platform_bus_type, NULL, isp_sensor_ids,
> +			       isp_match_acpi_device_ids);
> +	if (!pdev)
> +		return -EINVAL;
> +
> +	acpi_pdev = ACPI_COMPANION(pdev);
> +	if (acpi_pdev)
> +		strscpy(*hid, acpi_device_hid(acpi_pdev), ACPI_ID_LEN);
> +
> +	put_device(pdev);
> +
> +	return 0;
> +}
> +
>   #endif /* CONFIG_SUSPEND */
> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> index 69dd92f6e86d..1bb927428847 100644
> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> @@ -25,6 +25,7 @@
>    *
>    */
>   
> +#include <linux/gpio/machine.h>
>   #include "amdgpu.h"
>   #include "isp_v4_1_1.h"
>   
> @@ -39,15 +40,49 @@ static const unsigned int isp_4_1_1_int_srcid[MAX_ISP411_INT_SRC] = {
>   	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT16
>   };
>   
> +static struct gpiod_lookup_table isp_gpio_table = {
> +	.dev_id = "amd_isp_capture",
> +	.table = {
> +		GPIO_LOOKUP("AMDI0030:00", 85, "enable_isp", GPIO_ACTIVE_HIGH),
> +		{ }
> +	},
> +};
> +
> +static struct gpiod_lookup_table isp_sensor_gpio_table = {
> +	.dev_id = "i2c-ov05c10",
> +	.table = {
> +		GPIO_LOOKUP("amdisp-pinctrl", 0, "enable", GPIO_ACTIVE_HIGH),
> +		{ }
> +	},
> +};
> +
>   static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>   {
>   	struct amdgpu_device *adev = isp->adev;
>   	int idx, int_idx, num_res, r;
> +	char *isp_dev_uid;
>   	u64 isp_base;
>   
>   	if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
>   		return -EINVAL;
>   
> +	isp_dev_uid = devm_kzalloc(adev->dev, ACPI_ID_LEN, GFP_KERNEL);

Normally I like device managed resources, but I'd say this is a case 
that device managed resources are overkill.  This is only needed for hw 
init, and any device missing this ACPI ID is going to have wasted memory 
from the device managed allocation.

ACPI_ID_LEN is 16 bytes right?  We don't care about the use of this 
after the function goes out of scope AFAICT.

Why not just put a 16 byte variable on the stack as part of hw_init() in 
this function and write and compare with that?

> +	if (!isp_dev_uid)
> +		return -ENOMEM;
> +
> +	r = amdgpu_acpi_get_isp4_dev_hid(&isp_dev_uid);
> +	if (r) {
> +		drm_dbg(&adev->ddev, "Invalid isp platform detected");

Since you have the error code in 'r' I'd say include it in the dynamic 
debug statement.

> +		/* allow GPU init to progress */
> +		return 0;
> +	}
> +
> +	/* add GPIO resources required for OMNI5C10 sensor */
> +	if (!strcmp("OMNI5C10", isp_dev_uid)) {
> +		gpiod_add_lookup_table(&isp_gpio_table);
> +		gpiod_add_lookup_table(&isp_sensor_gpio_table);
> +	}
> +
>   	isp_base = adev->rmmio_base;
>   
>   	isp->isp_cell = kcalloc(3, sizeof(struct mfd_cell), GFP_KERNEL);

