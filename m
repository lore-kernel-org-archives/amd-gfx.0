Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8018CCFD376
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 04:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16D5F10E51C;
	Tue,  2 Dec 2025 04:45:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C9cKeCci";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 609F810E51C
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 04:45:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kg/EqZV2fvX0izmfDvV2jwbApwWwx/sVgWLWhY7zS6HR4OULtfPnN9TngqAQduttVn16E/0cADfClw9f1QNm+AThFVBNgKVTMpOPdsK+f6Bo7U+Xo5r4FjQBujqcaSCHOnIWRAraYAbV2Thd6Sj3RANerEKH0V9m57RSZmT8pHrDxtXwvBInrW3Z7ledPJCHR2lDrpcDnTV7Iz7mfk1RZzfh9nh/0e+zrMMrCrCRGIc9E2AMIkGpG+8CAVJmULjMY4jHXYRt8hxPOP6Rpq86mBkIKO6RRpDYY4YaVlbRBnDMnVWGEbXRkbtBcX8EInFKXiSUOU30yddoV+IoHfOcFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxHVOykkMjO9/IQ7QT3lAbdiZEIA7iGirfEOz39ZmPI=;
 b=TthRSv4kPtrE2psWuw3i55On6NBDSAAn+FoDoBtj1/ewuomE+3THOCDRl2ZAWakwehSsHdiPlyESFz6S5EngYVfVgSDzvh66ynioxKeOpHq7QIQJ2I4gnEhpk0iIW5XM9yNug1GRa9gbE09s6uGJnYijunXbnP4U35BvPnpmUnnpvpVoCsh7BWpwRYunfsP2VhZEf0GTUj6oKnozyVc5ZsCYWxHSjcgyepRguToDqZJItev9bI7a4NCTDhyPriSkmqo7yR+mPBiQMa3QvqcxJlA6bKh1cMa+wwp6zuNbF/Uk7tVMwhuRvkJrIbjOjJq1IUrBLeNphfrCmQoWIdZElw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxHVOykkMjO9/IQ7QT3lAbdiZEIA7iGirfEOz39ZmPI=;
 b=C9cKeCciFGAZ5lrIVo/NcULSeSLENWB/qhS1v+OcjJU95Jg9kUkiKxfAUsqP0OC4IHb0Xhx+wsWgez5vhdOMVxy+ucT+76Iha3xQ5dQQi4/ZdKOOaXgyTiwwY+obDCu39MZgsWnyeUyrYe55OWr4OjtiFSFdabBwL0ijJ+v6O3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 04:45:10 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 04:45:10 +0000
Message-ID: <22fcaf19-b0d1-45d6-a0bb-238ec817b242@amd.com>
Date: Tue, 2 Dec 2025 10:15:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] Remove print_clock_levels
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Jesse.Zhang@amd.com
References: <20251126132822.3266730-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20251126132822.3266730-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ1PR12MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: b820e7a5-1dec-4a2d-6d44-08de315d92e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q20wVWNZTUYwb0ltRVFDLzY5aUMrMXcvQzRmV3BPUEpzZUJNcUtFaGcxMDlP?=
 =?utf-8?B?MHc2MU10c0hiM1JzQm5nOVBnMi91Tjh6anhYQkl0L3FCTTBBOHFmejJnWWM1?=
 =?utf-8?B?OGtLekdLb2Z5dDA2TXE4SFpubDFBQWZleVlOV2h6Wm5RRDMva2dUYjViSGds?=
 =?utf-8?B?Q0RVSmxQWVgyTUNJcVg2S3ozTVFtakE3TldMT3pYSG1lemFYREl5d3ZkdmZx?=
 =?utf-8?B?RW5JNVFVb3NZZyt6ZFhuNWFTVkJvNHYxRkRxdytzQWNhME9hZzRzNFpBbTdz?=
 =?utf-8?B?L1BpK0tFMGs4UFhGeEdaVmd4ejhrbGticnVwMFZSUDN1UGxTRVdLRUd0QjVY?=
 =?utf-8?B?djE2WTAzT3IzYkV1clRsN1Jhc2ppV3VZemN3cGp4eUczU2U5TnlZamNGQWg3?=
 =?utf-8?B?MWRtZmxlcUkzMnlsYXJQTlFCRDB5TjVqdCsza1JkeGQrdU11UjhZYkpzekU0?=
 =?utf-8?B?aW1EWWV1OHUxVEQ3dXVCM1ZlSTAvNDZJZ3V2aXB3RUhML1FBanVtcitHM0pX?=
 =?utf-8?B?RTgwOS9zWHlLMW0xTWUyZUV3bFp3UzFrS1UrU1cyVHJCTGNhbjdhUzhaRnJo?=
 =?utf-8?B?S3hhWjNPeG8zYXpWc3NBUTMyU2FodDlvUVlkRzNCTDFNNTFxekZFeTNneWQx?=
 =?utf-8?B?S0l6RDE0WlJ0MTZ3MnpyTTNNYkFSSG1RL21MWWRSSWJPQ3k0QWtPTVdTM3JR?=
 =?utf-8?B?NWRYbEdPU2FTanB4Ymo0aGZrZlBaeGhnaURva2pBMFpSb3NzUnBqUHdOTFcw?=
 =?utf-8?B?VkhDdG56a0NxeUE3TmxPUWlWYWlKK0FqZ0xVZ2p1UVhRb1E2a2tBSW5hcE95?=
 =?utf-8?B?TVJQVG5vRVVmVEVyS2JWQjVreGlEcWdKUlI5UWxHMko1eVdmZm84VjIyNHJi?=
 =?utf-8?B?VGpHN0M1QlRGSnNnd0FuV3d6VU9Kb2h5MWVFQkpyTTNuQTdHem9uVXJLU1o2?=
 =?utf-8?B?YmpEMWR0MVcrNlZjSTFDYUZZa3E1alE5RW9OUnlXZVI1bXpkaFR4SER6bGpM?=
 =?utf-8?B?UDJDVVNrNW1vZlFDdGxvbUwrdG8xdHlja3A4cG5EMThsTUVrbmlUZkJWWHJP?=
 =?utf-8?B?TWNVeHFkOW1HS3lDTCs4U0J4NjlGbGhlK21iYkdkY2F1QldsZjB3bTIrd0tm?=
 =?utf-8?B?M1UrOWNkc1pXVU9TL3hWbFlpUnFRekJ0MzRwQUZIcmJtbWJlV3F3THdCZWtH?=
 =?utf-8?B?dnhnZHNCc0ltckRNMW93QVRtelNMb3I1RTRXSzBKY2cyN1c3WW1tckpVZk16?=
 =?utf-8?B?VHhBalNHWjN6YjgxMmJ1a0ZNZHFEZXJVaHNVOUhVSDZKd2cxamlrUHMvTEFN?=
 =?utf-8?B?YWc5QTdNRlZDbE8rcFFsNm9BZUdXSXBxaWlLKytwTEZSSFpUMTdCWDNvbVQ4?=
 =?utf-8?B?SFV1WFh0dFJIZlFheGFUeGkzQzQ5L0hhaVh0b2pJZFE4VHZ2bktDRStLRE5D?=
 =?utf-8?B?d0V1TEJWKy84bm0rQW5qc3ZvaHdTaWJQZ0Y2alhjdngxWjJPMjB2OFBrWWtD?=
 =?utf-8?B?MmFpTURZSDcrMnl3SDBwWmRyV05ta2Q2bUE4RUp4aDFwRENWQVlVR1R4K1Uy?=
 =?utf-8?B?SjBKYVdjTCtUcE1TTm5sSTRvcEg4SXBnK2VqVUdJTnlJaDY1WjE0VE9aWlkw?=
 =?utf-8?B?VGVIeHFtbG4wdHdIS3c4dWV1czYwTzhEdkxPVFdwWXg5bWFrcEJGOFRVcWd1?=
 =?utf-8?B?ZkZseWpYNDRWeFlWKzJ1SmlqWVZuZmlsWWlEMytpT2F4REhBSnBkREtSSzdH?=
 =?utf-8?Q?Po33FMSxaNKUU0l5djQb/0kzQRctnUw0saaL8gI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2pBd3NVSHpaQVhmVHhuYmhuSmlWSEttVlFRdnFoQUxnVjNUSnFlTlNLV2Iv?=
 =?utf-8?B?TEhaV2JOWklwZ1FnKzJnOXloK0ZuaDRMV1dEQnV3dzUvbDhzNW95MlI4OUFy?=
 =?utf-8?B?MjFGK0k0a3VGdEpGTS9kKzl2dFo2N2QrbThqcU4ydHBSU3RPUDFpcFlEZno3?=
 =?utf-8?B?c2NjY2w3L1B1OXJZbUF4UlhtWGJDVUZqRWFzUTVhc21wdkFBYjlXV2s2N29W?=
 =?utf-8?B?ajNsMHBLem82RUs3ZXNRUHIrdWwvUkZzTUdSdDFhMlFvekxzNGFOcUg1eXVH?=
 =?utf-8?B?MWEvVUN3YmtaMnhLYmF4cFFyOUplQ2wzM3VTMFBZOHgxZ3dENnNQQ0J4MkxV?=
 =?utf-8?B?Z045Q1g1YzVodmg4L3FSbmw4cnFaMkNLY2Z0RUY4ZVozU3JQWjVHTnhubFhM?=
 =?utf-8?B?Tm1QVEt4VEY2bjRkck5YUncwNXJFdWxjNWwwcVByaTFCeDVsOUdHU3FWRzda?=
 =?utf-8?B?d2hLTHpFVmE5WUo1cXY4cGQ5S0twVUF5Uy9PSkFWS0V3eUxFNUJjbHBPL1pZ?=
 =?utf-8?B?RnI5Ri9tY2V1dVhOVXg2TEp1UGVSV3dudFNQMDJxZngrT0d0dW92aVh3VEdk?=
 =?utf-8?B?UHFlSHZJUEl6aXhFWVNNeU9VVXhaczBJVVYvOXlpNFRzZ0tsYjYrdDBiZU5M?=
 =?utf-8?B?M01CR0JBbmZEL3hRN1h6VklsTkhKeEVzSEtTOTFUNEZCdnQvcG9hUlI1bHZh?=
 =?utf-8?B?WGZMWm5sZVRtbHhmTXVORms1MzJtMEo3ajFsUCswREMySklaUVJzYUoyUk5R?=
 =?utf-8?B?eG16OGk2QXg4UG50NitWQlI0YjNGSWdOSkd3anBHWXpDem9mY21zTXBmTjVz?=
 =?utf-8?B?RzA4d3p5R1lTSkNZSXdNRUZYU2FUbnhhZGpUOWpzaTU5Y0pTRDd4cExqU3My?=
 =?utf-8?B?MkNKVGJwQmFqV1RuYjdEekJ0L2loNmpPNnRoTUtsOW1WNXNjL2hzSTVXUnc2?=
 =?utf-8?B?SjlaK3dqclExRlJDM2NueU1MTjRjbWhwWVNTZ2x2b2FBdUhnUWlDOTFndG5u?=
 =?utf-8?B?VFI2RzlNOWNxL0tkYnRJdDlpM2d0QlhwOSs5SnJGQTh3UjFwZWhWWFVaeDAx?=
 =?utf-8?B?UWV0d1dQV2l4cW5VbWFvWFNQMW00ZzU0Zjh0Rnh3ZGhXWE1MaVJiVzdrZDdP?=
 =?utf-8?B?aHlRdmFlUGJnM0VPbjZpS2V3MmpEcFpoa2JJZzl1eHpFSWxOVFZIQ3lBL1ov?=
 =?utf-8?B?R0UxYUxLaU5zeVY2T1REZUJFL3hYb0I1RW5GR0VRcy92ZjNMVHFDZytTV0JQ?=
 =?utf-8?B?bU9BNTJTcVhhQjNvMjk1MEdFMnhlTENjQUVvbk1uUm9rU1haL1Z0S0dyeGpD?=
 =?utf-8?B?eVUzQ09jYmdpUjVwNlFMcHZCd21CMFFoclI5endBaUhJZDdoUytUdi90R2pz?=
 =?utf-8?B?bm1OaHpHdDBDMjczU3pOaitReW5OSGQ1M2xPd1ZLdTUwTWRDRXFIWVl6Q3lG?=
 =?utf-8?B?K2UzTEFUQjlEU0g5SWw5M2xCdkpEM00yN0hFUThBWUkycERKem1YQWZwYnZi?=
 =?utf-8?B?SEVKQkF2ZndzbllDQnlFRExybWwvamxoTjA4UjZqaUxSbFZiZTJwTkxLZm5T?=
 =?utf-8?B?WlNpb29MNG1XVjNoVFVFaHRHOGNCVDhQbEFJTjAxVjJMeWdEWTZkc2t5Rkhp?=
 =?utf-8?B?elphK3NjM1psdDZ6NkU1RG56bjduRHYvYVlEaGFVUXYvWUYxcXBUc1NhQzZM?=
 =?utf-8?B?NEJ6TUowRTRxQU1ZQ1NDWkVWOWNBd3BBcEh5VUtQeGxHcjlSVHhmMS82cnBM?=
 =?utf-8?B?eTFUQjh0aXNBcjVLSEJoZjNRL1V2c3BsREF5anRLbER1M1IyOWhtNVBWZjUz?=
 =?utf-8?B?VXZ2clpzMEpVVGtYR3JQZnJiNHg2L2I1a1V3L0lUMFk4VUZMVWpOZEhpKzhu?=
 =?utf-8?B?S21oSisxS1FCdzNZaXQ2cmYvOFRlUjBvZnZZUzVTMFIxYWN3ZnpUVDl6YlNZ?=
 =?utf-8?B?d3pFMUI2RVBFdHU1T3BqeHFOZzJhTzBBa1JWd1diem9XRUVmU09qNXBLOFYz?=
 =?utf-8?B?VThNZXRBaU5QbmhsU3hZYzBvSDJPVHZ4NFN6WHNSaFdEWStad3YybE5Yd05S?=
 =?utf-8?B?a1hQMG0vQkhBWnpLVVV4VEZ2YktFN3ozQ1BhUU9VTkEwMWN0Q2poeGJCRWF2?=
 =?utf-8?Q?rW8a8RlMGJGIfTdrlLpmtkHKy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b820e7a5-1dec-4a2d-6d44-08de315d92e2
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 04:45:10.2715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Rs7WT9PkVI4WYmaIQKaT6irRd584Q6aaGAXnBk5Po+AdU4jbKLnwaV/zUYfZj7I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075
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

<ping>

On 11/26/2025 6:53 PM, Lijo Lazar wrote:
> To print the clock dpm tables to sysfs, presently there are two interfaces which provide identical
> functionalities - emit_clock_levels and print_clock_levels. emit_clock_levels is more flexible since
> it provides the offset along with buffer which matches closely with sysfs_emit_at interface. It is
> not required to keep both, hence drop print_clock_levels.
> 
> Lijo Lazar (20):
>    drm/amd/pm: Remove print_clk_levels from navi10
>    drm/amd/pm: Use emit_clk_levels in sienna_cichild
>    drm/amd/pm: Use emit_clk_levels in cyan skillfish
>    drm/amd/pm: Use emit_clk_levels in vangogh
>    drm/amd/pm: Use emit_clk_levels in renoir
>    drm/amd/pm: Use emit_clk_levels in SMUv13.0.0
>    drm/amd/pm: Use emit_clk_levels in SMUv13.0.4
>    drm/amd/pm: Use emit_clk_levels in SMUv13.0.5
>    drm/amd/pm: Use emit_clk_levels in SMUv13.0.6
>    drm/amd/pm: Use emit_clk_levels in SMUv13.0.7
>    drm/amd/pm: Use emit_clk_levels in yellow carp
>    drm/amd/pm: Use emit_clk_levels in SMUv14.0.0
>    drm/amd/pm: Use emit_clk_levels in SMUv14.0.2
>    drm/amd/pm: Use emit_clock_levels in SMUv7.0
>    drm/amd/pm: Use emit_clock_levels in SMUv8.0
>    drm/amd/pm: Use emit_clock_levels in SMUv10.0
>    drm/amd/pm: Use emit_clock_levels in vega10
>    drm/amd/pm: Use emit_clock_levels in vega12
>    drm/amd/pm: Use emit_clock_levels in vega20
>    drm/amd/pm: Deprecate print_clock_levels interface
> 
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  19 --
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  16 +-
>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  16 --
>   .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  |  65 +++---
>   .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   |  87 +++++---
>   .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |  29 ++-
>   .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 141 ------------
>   .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c |  52 +++--
>   .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 211 +++++++++++-------
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  28 ---
>   .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  17 +-
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 193 ----------------
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  27 ++-
>   .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  39 ++--
>   .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  52 ++---
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  21 +-
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  |  24 +-
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |  25 +--
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  30 +--
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  21 +-
>   .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  25 +--
>   .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  24 +-
>   .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  21 +-
>   23 files changed, 443 insertions(+), 740 deletions(-)
> 

