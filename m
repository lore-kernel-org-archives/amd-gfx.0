Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E450BC282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 12:16:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8976910E595;
	Tue, 11 Mar 2025 12:16:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y8tVrb/o";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47ECF10E588
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 12:16:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FwJPBg/kB5j3H6qRxO+LZvU5x8QfL6HwfVbuibVRmY7vjRezWhZPs2I2NBpgp/R9AsehAUgMIkCGWwnP3VqKRR6ou6+jJPXEYMxyZQ7WSaTSgXpLadFLR/iPYi7bX86lIhv9tIeP8ba39LOxlT1zF9FsmVkVoQw9c9bAsWVuSX/W/QEXKXRuUF0fuDrtvJHrDRXxCf6cNw1vcBK4GGsGFlJLY3cUI4p9WLXgwShyyBz2bT1kbEG+2CobK6avedxYkLz/W2DsmYxoJ+DrjiuTgQZkynIMsCpdNHscqDaHqXmaHxEsZBgKheXZAYm3OL/DDXXCyk/JTiXsf5vlkhzRrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQSchwh72MkoV4n9BeXUGlqXgl2LNGVvTnqepZegZFw=;
 b=E7L6gMULdLpO3hUzOSONeRKKfrPlryY7iz4Z+hdJDUcl77sgSip7AFV15FWzOpBHXLeDemw36UyFic13ZnzcPyhHz4VOVovJ9PGCyJDJRABzz2BUwZ5ZtWUlKy8Lawud2572by0JRUg/QzqbbJkWkO2nfCI72hqYcwnSdLDuvBRjR9FQf7TkDB113xZFs5Uc8lAbPIOypCxek52RqUJ5MNIHCtlwdXJCyBZrfm6Fkfe7grYMlOL2Gm92AU9iH4mtVplCzCe7pHdaQWbJmjQYANk63ARRwlVGy/EmtYiPQSEqtZ48yR1WMZLUEcLfCpWyOZ2BVGZtuNwbqj0VQxDEIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQSchwh72MkoV4n9BeXUGlqXgl2LNGVvTnqepZegZFw=;
 b=y8tVrb/o5icEHYP3S3eTyhWQkFSU2rcoBBGwV2W64vDNZGKHf66l4qfr3iIHgk1NZghfrXIlEOTFqSWvPxlHYUqTV0GWyw5XC7iTxjQBJ6iHtW/FPp3tsBekeKYdzqE9ilpYKbD2to3IzhCG3Gc4RL2X11lkXJ07txfbxLsnokE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 12:16:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 12:16:51 +0000
Message-ID: <0a623285-a793-456d-b306-ed584ffc8ed8@amd.com>
Date: Tue, 11 Mar 2025 13:16:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Add SDMA queue start/stop callbacks to
 amdgpu_ring_funcs
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, jonathan.kim@amd.com, jiadong.zhu@amd.com
References: <20250311083300.2897523-1-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250311083300.2897523-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e2eee0-7e3c-4cc0-ecf4-08dd60969aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmp2dDZRVXRZbDcxVGJrTXR2S00wYnd2MWVYMWJyNEhXUDRxOE1jWVg1eWR1?=
 =?utf-8?B?MVM3bG9IelBEMGNOd0w2S2N5R0xyK1lZdVRsd0drd0VydkQ3c1hPSTNvUG9k?=
 =?utf-8?B?NC94SkdDR2dJaG8ybFU3MVFOYTYvWGx1bjliZVBkOEpTZU5ZZFh6NlBvTCsz?=
 =?utf-8?B?NC9TUlRjdUdrNU9CTmUyTDY4ZHplUkFlNEhOK3B6OHNVelhPekQxY1lzdE1J?=
 =?utf-8?B?MEZnSm1CNnlpU0tHK2VDMllPMWdjVEZ2VlBkeHNiQmREa0dTQUFuSTB6SWpG?=
 =?utf-8?B?WGNtdEI3Tmx6SjN3ZUd3eVZGNVBYZVpVTGNTV0RCSDNzNkl6MWQ4dVpQUEho?=
 =?utf-8?B?MUdGNXNqS0tZU0t6ZU5uelVoYmNGWExTMDJPMzdYRE9MMzdwN0VnS0xPSWJF?=
 =?utf-8?B?czVQTWFNcDArL1NiUVZpNS9QcXhFYXVPVUxlNkx3Um9xcVNQalhmaE9VblUr?=
 =?utf-8?B?QmlEK0EyejRKaUNlbDJnaUMrWGdpenAweHZFQzk4R1NaWTNFdFlrUC85OVht?=
 =?utf-8?B?M01vT2xGSmZMbG1TWnNlN3A4T0szUEIvVmJRVTNCaGtUSGhkUDc5Z1RodTFl?=
 =?utf-8?B?aE9OVml5eUZINk9LZ29DcGk0NUQ0UXJQeTRla3pWQStiQk1KMlZwT01rN0tJ?=
 =?utf-8?B?dkI5NmNoUzhveGt5dVRYSUJUd0kvckE0bUtGREVFMjR4Y1lmN0JKQTFyemx0?=
 =?utf-8?B?WWhaU21kdGs0bXRXZDMrTS84bVJZK0FXUURHaUlMK3FBUkJyWUQ0YnMxNWpl?=
 =?utf-8?B?RjVQOHVGdHNxckRvL3oyUld4V1A4OW5WMHVrdnRHYkkxZ2psbjVKOXdBVkVT?=
 =?utf-8?B?MERRTG5tc2NKdTZTRzNEYnhQSFI4WDF3UXEyYnJ5YktpVDlrN3ErbUIrdE1a?=
 =?utf-8?B?MnVOMmVFWWxKR3lSb25oQTlnVnVBTVFGeWZZNUsyMC9QdkVZbmNiZjliczhO?=
 =?utf-8?B?WWlGZUd6VmdjbS96ZXNpS3lVcGNhMXdhZEs5NWtCWFVDUFZVVzBnczU4SVJ6?=
 =?utf-8?B?MVlZU0ZQYUNPUUJIVmpDV1VNZGFnK1Z5SDZQV1VTMnptUS9MYzBXSjRQV05P?=
 =?utf-8?B?L2V2aHkvdXlUVStud0RucGRrSmJYZzlva3lmUHBMS2xJMWRIMnFRYWRnOW5r?=
 =?utf-8?B?MHJ6aWJ3M1BBRFN6MXFKYXRJYVc3RG9hcnhaVlVtdUZ2Z21JcUNjL1NWMGtK?=
 =?utf-8?B?T0o5bU9LZHliMS9rcHozUk5wb0dSSkRMWDk4S1VRWVRRQlJIQnVmSElVVHRx?=
 =?utf-8?B?TXphYi85SGJMUlVRRHorOCtzWU5uSUM1RjBubFQ0YVBodU9nWDdqVDhuNDJ6?=
 =?utf-8?B?ZmlnVGVpak1RcFd5am1UTVNCczE1MzdmNU5tQ2RnVXoyN2w1RzJGcXJ5L2Qx?=
 =?utf-8?B?akZ6ZDc1LzZ4YUxQeW9mcWh4NThlNEJHemZSUnhRZVRNL1I1SXV2ckRFekZV?=
 =?utf-8?B?dTFmQVVHbzl3QmVUUFI2NnlDRXp3RWxMbFdVWUQ3TFpVZ1ZtdE5qdG9TRGs1?=
 =?utf-8?B?TnZIU3ZINUlEcmZxK0JhQ1p4Yi91dFdzd2lxbmgrNElmdGRReVpxWVRlM0Ez?=
 =?utf-8?B?a2hiZlVkdXdqbVBpSzBaajI5U2JuTXp5ejMrRHkxdHdBZm1EU3VBL0xVcWdP?=
 =?utf-8?B?R0NvaGFYRTl3NmRZeUkwNEQwN1ByQkJnU2RqaXdFNkdUeUQzVG12UnZoSTJM?=
 =?utf-8?B?WU5UdGxCR0xaVkdxSXhMWWdUZkhMVXh5YnBzLzd5WmpETkIxV3lQU0NGL0pN?=
 =?utf-8?B?SjdYdFpuczhYN2QvMUpSdmNNU2lsLzdVaCsrejE0dm5RaHJqSkhJaXFsNHBm?=
 =?utf-8?B?QTBQUnhUcmRuUGROajI0bDdCL2NQSFR1ZklZLzdvSmMrYjZ1VVhHT09kdTdi?=
 =?utf-8?Q?FYos/Jx4RSiWG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1g4T0ZtN0lVS0NlZTB6SndiVHFvL2xDTC9WTzBMdzBWcmFOOUovOWRVdHNt?=
 =?utf-8?B?dDFUNThETlhrVHYvbWYyakdHZkdVR2JEVHBXcVVXbXRVTlhBbjAxd1ZuUGpZ?=
 =?utf-8?B?WmNXMk1YSU1WTDhwY3g2cEhyTStwTnNCa3pwaS9yOEJ3ejQwQTRsdlRoWEsz?=
 =?utf-8?B?dVMvRXFCZXhXdEVBS0JFNmRuNUxiWEMyTFJseW9FNUVWMHBNTTNoYXh3VGtR?=
 =?utf-8?B?OEwvZ3BFVUNGTWFQOFd5eWNwVHc4YWwveVFhemJBWkt3d2FpVk45cUJxQ2dS?=
 =?utf-8?B?bXRaaFVrU3lDN0ViU1RzNUs0VFVvd3FDbEgxK3hNaWp0UzUwZ1lHMVR2cTRq?=
 =?utf-8?B?dkNRQlpONXdOUDdFWFpoUDY0cDM5dFU2clloSy8xZFZxWnBuZXFob2UxRVJM?=
 =?utf-8?B?MmozajRkekZKZHp3am5MMTB5VkRFNUQ2b2l5ZktSMklKb05Hb0JMZ0RGc0ZN?=
 =?utf-8?B?OVo0WVhQSXUxUmVGQzF4aGRYRVVjYzNOa1BORzNOSmRmckdrbnV6dXl3YnBX?=
 =?utf-8?B?KzZZSnJJb0llRjcvWEZaeHZZNXFDRjRWYk8wYWY4Zko2K3RsNndEUjBXRFJr?=
 =?utf-8?B?VStaSU4ydWtpMzBZWitKOHExdTZCcVd2MUkrMWRWTUU5SmpCRm1OOXNuY3E4?=
 =?utf-8?B?WUI3UnZFNXkwQW9mNUtlLzdMY1FyZ2VnY2ZiT0tNQWFUa3JRVGtLZitwaGw3?=
 =?utf-8?B?bEpXczJodWR0Q3VFUDVwcVhSVU5WK2RSd1ZlYW1RelIxZCtGemw1aTZOM2pO?=
 =?utf-8?B?MHU5b1ppVUJJUGRVWjBjOU9aaHd4ZE5XRlppRVE1OXQ5OXV2RFBMWUMrbU5w?=
 =?utf-8?B?UjVXYWx6d2RXR1hON01lVEFlUXBKcVA3b1ErQWxUTXZURjNtRjQ4bnpnRW94?=
 =?utf-8?B?U3NrekU2TEpyVjFCbWdQMVkvS2VjdUMycjZTMjRBc0tEQ1hQdXBEVXFjMzhT?=
 =?utf-8?B?Q3RiRUprcDdTZVVOWWFGM3FsaFBtZnUyaitzL1FCeUNNeFFlanNKTFFuV25W?=
 =?utf-8?B?VkxJZGRDSEFqZCtkb2RHRE8rZHBYWVRjNFhFcTMrVHVFWUZ5WTl2bDA5UW92?=
 =?utf-8?B?NmhtVE9LWWJHQ1dQR1IyeVlsd1A1d01GUiszMHUweXdTZGkrbisxTnRlUlRr?=
 =?utf-8?B?cXk3ZmlXcnZFbnNZSUN0WlVjT2hLdk1JVktya0RiMkJTdUVGeHI1aEkzbDY0?=
 =?utf-8?B?dy9hc2xBZjY5RFZPZ1A2TGtHUkhaNEdVVEYrKzBRS3hwSlFQcFdieGNqa003?=
 =?utf-8?B?a0s0dEt6cThMN1BXRVJCWEx3RDJHWlB1eEJQeDMzU1NZNE5FQWVLSFVHUzhj?=
 =?utf-8?B?ZjdtNEl0NFdMVjk5TXVIMTZCNTF2c3FWdlNYcjJRVXZGaEdKMG55K1JmbGwv?=
 =?utf-8?B?VWRrb29UQ1lRaFRFZGhLb3lYYWF3blhrUVJ1blk3TEN2d2gwRUcyQ2ZNcUZY?=
 =?utf-8?B?NGZoL2Vsc1hiS29CNVlRRlBsZUpGVGlTZVY0MFBLOUVLSHAvNVkxUldRcncw?=
 =?utf-8?B?dXBIUXYyRHFpcDd4MU51TXRIb1lFRFlaNFJyN1dpYzFYaDlIaGw4aXFYNE81?=
 =?utf-8?B?MkRWVkdXaGtjUFF4dWFJdEVTVmdpWkhQSytDR1hVcHVBVXJ2dTlTVVZyN3Zz?=
 =?utf-8?B?VW42cmpOWnoyM2JOVXJlcWN4MVBMdCtvdlhaczhsZXAySjBwZ2RVM3dRS2s1?=
 =?utf-8?B?dVZBWE9Fdis5bUU2b0N0bzVyWnZCb2xHdWxGN0tVY0Q3Q0txRWExejZjTjhw?=
 =?utf-8?B?VWN2N0IxT21sQ0Y0VklWRmlRUjlSRk9KOWs1VXptMzI2bEd5cEZ5YndzK2JC?=
 =?utf-8?B?aFVvOXlHaWlIRjRrb1I4SklWVTVWR1h1OFMxbzlXL25VM3lRTmlCVnV1eTQx?=
 =?utf-8?B?RmZsTUNBSFhzYzBtYzBvVGhUaFRKaE04Rk42T0NMT1dsanpkcHRIMy9hNFNN?=
 =?utf-8?B?ekhiQS9LWFpqQTZCSjhxYzJwczhpdlJkcjFEeVlyQmNCWlNHcW83WFZnVytv?=
 =?utf-8?B?YTlLakZ4QU96MTZzTWJYTW1jQ3JnUGJGVE9SV2xPY1orTVVZd2JzREx3dklZ?=
 =?utf-8?B?cGkzSDVyUkk4aC84SkJiN2w3Y2JDczU5YWVJTnE0M2lWcGg5dXNqVlpvbllY?=
 =?utf-8?Q?UaG4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e2eee0-7e3c-4cc0-ecf4-08dd60969aa4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 12:16:51.4202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xT9/me1qfd5irru5ce/VRBeAqPLPIXG1QsHldHu0x3fippI/mEqkkZfgMnk+j5I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997
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

Am 11.03.25 um 09:32 schrieb Jesse.zhang@amd.com:
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> This patch introduces two new callbacks, `stop_queue` and `start_queue`, to the
> `amdgpu_ring_funcs` structure. These callbacks are designed to handle the stopping
> and starting of SDMA queues during engine reset operations. The changes include:
>
> 1. **Addition of Callbacks**:
>    - Added `stop_queue` and `start_queue` function pointers to `amdgpu_ring_funcs`.
>    - These callbacks allow for modular and flexible management of SDMA queues during
>      reset operations.

Why does that needs to be per ring callbacks?

Flexibility is usually something bad when not needed.

Regards,
Christian.

>
> 2. **Integration with SDMA v4.4.2**:
>    - Implemented `sdma_v4_4_2_stop_queue` and `sdma_v4_4_2_restore_queue` as the
>      respective callback functions for SDMA v4.4.2.
>    - These functions handle the stopping and starting of SDMA queues, ensuring that
>      the scheduler's work queue is properly managed during resets.
>
> 3. **Purpose**:
>    - The new callbacks provide a standardized way to stop and start SDMA queues,
>      which is essential for handling engine resets gracefully.
>    - This change simplifies the reset logic and improves maintainability by
>      centralizing queue management in the `amdgpu_ring_funcs` structure.
>
> 4. **Impact**:
>    - The addition of these callbacks ensures that SDMA queues are properly stopped
>      and started during reset operations, reducing the risk of race conditions and
>      improving the reliability of the reset process.
>    - This change is a prerequisite for future improvements to the SDMA reset logic,
>      including better coordination between the KGD and KFD during resets.
>
> Suggested-by:Jonathan Kim <jonathan.kim@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 ++
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index b4fd1e17205e..1c52ff92ea26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -237,6 +237,8 @@ struct amdgpu_ring_funcs {
>  	void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
>  	void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
>  	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
> +	int (*stop_queue)(struct amdgpu_device *adev, uint32_t instance_id);
> +	int (*start_queue)(struct amdgpu_device *adev, uint32_t instance_id);
>  	void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
>  	bool (*is_guilty)(struct amdgpu_ring *ring);
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index fd34dc138081..c1f7ccff9c4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -2132,6 +2132,8 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
>  	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
>  	.reset = sdma_v4_4_2_reset_queue,
> +	.stop_queue = sdma_v4_4_2_stop_queue,
> +	.start_queue = sdma_v4_4_2_restore_queue,
>  	.is_guilty = sdma_v4_4_2_ring_is_guilty,
>  };
>  

