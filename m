Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BD0C3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 08:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD99310E451;
	Wed,  7 Aug 2024 08:03:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vJO7hRjJ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E69FE10E451
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 08:03:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYeqMiq1nRqM9pWg3QXiM+nfXFmFXB5abxSpkyUbZadBuLJdO3le+gIIl+exmb8Z0LZWH6G+9TMUJB7yEyoVrt8PrZ/XIpPwMB76soLQSgWqg6AJ9+lC9U7JJhXIdmMKyr97LSfqY3QwdrfzZpPIt9coCm20bw9gQWQswZz77e7kcZFjpMciACUAPXla+QS2KQNMD2MyjX94/GQG8oNXUZ6aDCLaH1zfYcRf/4DZVtzklI9570918GFnaUQ5mahXTbdu+5HF3Ij24UNSszQ1s5Q99k3XBzrT845y2Se6XM1cpF3c4tqtg2RXhYdmCNGWYeq3dWFzH8omrLIqtYY28w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzHA3IkSRyaowLhKkYiy4uIS6FRy/BzwIhQHksg3jUA=;
 b=wUEnuFN4rwPg2LGB700hSUBwiOoRfDAa+cTal492k9QZurv4qa8Hke61yO5kx1zOU1Gi+9o+K8qSMLz3Fa2n41x4uWtW1C75el34KxJwqVLib7heIzwdHaPLvPFKhc/8GaFN0AA0IZSzdkjKzPdbRWP0+DBktEawAhT0C6h5eJqvPht/ODVwVFD/AEHtKRzeZergYf+8t2nNP9E4xb6JfqMw7rJ5ttc02weDnFqeVUCeECwLVlZIWdgBiVf9qh7gviV19Cc73T4XSVynBvQMEkecbDQAkq6nse7WyGFzDgPvjuCpRc33S1SEL2AsnVcMaBla0F+Br5ZmUbvrACEbew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzHA3IkSRyaowLhKkYiy4uIS6FRy/BzwIhQHksg3jUA=;
 b=vJO7hRjJPuHsB6NoNa4Cc65TOpKKeCAiY3TWrzRu5DdHEr2RQTTfkGE08ewZABNxApg9TQsiNZ4s9xTFvhLwATBed4kA4wWw27jHdu8lKmSwX1HdRMku6KJsv9kGD/W3I0bwx7tTQs+KVP5MNEt0CfUY8aODF+bNAnmDIt0GZE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by IA0PR12MB8716.namprd12.prod.outlook.com (2603:10b6:208:485::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Wed, 7 Aug
 2024 08:03:41 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 08:03:41 +0000
Message-ID: <69ae6eff-861e-494b-9061-88b41a4eb3d5@amd.com>
Date: Wed, 7 Aug 2024 16:03:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amd/display: Add null check for 'afb' in
 amdgpu_dm_plane_handle_cursor_update (v2)
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>
References: <20240807012057.1192380-1-srinivasan.shanmugam@amd.com>
 <20240807012057.1192380-2-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240807012057.1192380-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0067.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::31) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|IA0PR12MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b597ae-0749-4c9f-5a39-08dcb6b77392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U25tMml5RVlzTUtyZVVNWktGdU51ZmJuL3pBWFpsSHZ1M2FySGMxMlFjMHNs?=
 =?utf-8?B?T1I2TWpqMTUwWXhmWVV5bW1GQ2MxUzJOQXVyK1lXYmJ1Q3lzYXQ3bWdMaU1X?=
 =?utf-8?B?eThMcFhiblhrUVJGeHMzcnFoZnE1VHlhYTlPK1FqZlBOeDFQeW5vQmthUmVh?=
 =?utf-8?B?cXFDYkFzMHdlZ3hFaUZsTlYxeHNIQm9XbXlDcEtBYlRLNWl0ZFBpZEZVVnRY?=
 =?utf-8?B?aDZWdGYxS01tM3F1eUNRN25xOGNIZ2pGd0lrTlZ0SDQ3NzYzZEZBNStGWlRB?=
 =?utf-8?B?V1B0TmovUHltakM1ejExNXRDazBmVlg4Sy9HZk1oZDdzZmNaVlVMVXhxcTA1?=
 =?utf-8?B?Z0VhSXlwWm9BY2RRdENPRTByZ3Qwc0l4OXBvdG41QVVOOGVndnorcGZwek1O?=
 =?utf-8?B?YVgvRkhVeVA3Q2ZCRHlFWWlPWmtlKzhlZTk1b1BLaHhLTC80Rk5PYUNZSU1z?=
 =?utf-8?B?QmF1aENqUjBsMTRDekx6U0g4aGE0M0NIT0NCZHpQQ1ZpNVdyR2dwVjhmMmtl?=
 =?utf-8?B?Vi9uNmIyQTh4MUNYTU5RRjIweUc2K2xUbGo5bzRqNE14K1JDVmxacmpLTElj?=
 =?utf-8?B?dWJrRGxRVUgzdmdXZWs3MC9DbUY1SEdLaEl4V0dYUHVicXcwQU5QSmFGb25E?=
 =?utf-8?B?SVFvRGc2REM5dXJqNGFOMDY2YWE3b1JCOVR3bFJDY1NrclpUeG40c2g5RHJW?=
 =?utf-8?B?ancva2RSYkx4eFlkRjlmVm5CNllVUjVLWEVGTGpkWnRhSlNDMkh1WG0zQ0ZM?=
 =?utf-8?B?Y1M3LzVwK3lkbWdjUmllRlRvQzA2TXg2WjVTL2xlbThXSmVXSE9DTXh2Q050?=
 =?utf-8?B?aHdmQ3cyb3pMTmNnVGVmU1Q4aXZTR0NsczBySXh0UjU0VUg4dC9RdXJKcTEx?=
 =?utf-8?B?NFAxR2F3WThzbEg0eC9PblBSMkl2cnpTaDdKaGJucHlXOE1QQjZpOXpCeGxN?=
 =?utf-8?B?VjNFbDJBaG5jTFdUWlloNXU1aHVaRDRJMGtwdURYKzVRMkpETTk4QWxRc1hQ?=
 =?utf-8?B?Z0JrdjZ4N0VIaUlnaGQ4UHphbS8yLzhDdVloeGdxK3kzdzlPMDdaWGpIZEI3?=
 =?utf-8?B?UjJhWmxqT3pyTjd2b0VJNHZ3ZU5hY2hrWjBVMlpPU3BJT1Q2M3E2THFsdUV6?=
 =?utf-8?B?b2hyd1J6RUE0eWMvYnc5cmMrdUFhUHIzU0xhNFNyaUlteGJlMmMrMnZZSisx?=
 =?utf-8?B?K2gxaWU3NVBFaGUySE93Vks3UEhROXA3OGhHOXVoN00xMzFmZVpYUC9Db2ht?=
 =?utf-8?B?SWZmdWtod2JSci9kakhFa0p6cnF1bHY2NVh1SlpJajNzeU05ZkhrZDlwQUY5?=
 =?utf-8?B?ckowOUt3SG9wUm1zNXFZMEUzYS9xUnduNmRoWk93Ly9LaHdJT1VPVUVQNWFk?=
 =?utf-8?B?b3hBOCtXM3p0aDN5VVB6YTdtVWJqNzRUaitacThGQnhpSTFoSTBvSDl1Kzcz?=
 =?utf-8?B?bHVXNXdNSmszdElhTUIyRnVldGpCZXpGdkt0OFVIMFozR2JUbVlueUlyNkQ3?=
 =?utf-8?B?OGNYZW1mWnJCSUF0bzdHMGhPWlp3SlpBNGpBaG5tbkFWVy9odnhHRmZEVkhP?=
 =?utf-8?B?Wm9pdzZ3anVHVW0zZG96L0lrMGlZSFVKNS90dXVSWTJvUzZJSWxqWjdLWWZ5?=
 =?utf-8?B?bmg4NnlLWDBoNjhkUnJZVDVCTnNrcnowV2dQeFVkbUtXSWhPV2s4SG83RzJu?=
 =?utf-8?B?NFJUcXNUNE9pM0ZYbFQyeTFvcnhBNU8wRFpJZm5Kd0NhM1kxVFJ6R3E0eG90?=
 =?utf-8?B?SENHNWtVa2xQVDVuVnBZNnJ6b0FFR1hGTmg5SUFzQlp1bWtxV1BCeEFqWG9B?=
 =?utf-8?B?NUpaOUl6MElNOHBMQnlDdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3paSkkxREhBU21WMEdhdjFPVkV5NUo4N3RKRmROSm1lOGVJeUxqQTY0MmJZ?=
 =?utf-8?B?TWp5bzZDcE5WaDRZVUZtamMvamJJTUo4dDFrcHpRRFR2TTd3RHVCNGlKeGlW?=
 =?utf-8?B?WDQzK25hYmZMT2xIK2hwNFdjRmVKTFpWNkVPTFB4OVl3NDkvdXVadWxvbFVY?=
 =?utf-8?B?c0k4b3VvekNNQW43S1FkT0VqcG5jWHg4dHFXRnBLOHkySXE3NjNaR09tRGZF?=
 =?utf-8?B?TEdJcWhlR2VOK0ZGbnM2UnU5ZGdrUjNYbHF6TkQ5MmtHT1BtNW9JUTNKdDFM?=
 =?utf-8?B?RmlBUzcrdkNqM2dSdWxuVWNVdW50UHpiQVZPU1FlSG9qMGxHaWhhT3JNUzJn?=
 =?utf-8?B?TDJhUjJuVmF4d1pYK3Z5dzZGY1RWckJEOVpCV0xraVZOWkYraW1NSUhkY3Yz?=
 =?utf-8?B?SUpBendiR04wRGlVbjJRUnQ4aVh0TWh1YU5scUR2ZU85czExNi82Y1VJamdh?=
 =?utf-8?B?SW5IcWJJUUZxZGtIQ0hhRllQQ2Y4cVZzVm40K1FJbFBkaXZybHBCc2lQTDZ3?=
 =?utf-8?B?R2kvd253M3VOeU5zU1AyalA1T1FVVzVHS0I5UytrdHBqOTJvY2hXMytzKzRN?=
 =?utf-8?B?SWZUVHRVaTltNDYvOE9QRHlWaERtck1ucWtCV0Jwa3NydDl3N2M0M3Y1NUov?=
 =?utf-8?B?M2RDeXA1bnMwSkpLdGYvRW92ejV6MGtEKzBzdy8yZVlJRGxrMFFtS1Z3eFI3?=
 =?utf-8?B?RXlhU3V2S1ZZcWlLYlRWcHBXdDlTbm80aHVyMnF5QzU2QUhkdE9BNjB4WVhO?=
 =?utf-8?B?ZStZMFU4aEJhODB3bWhUMjNLdEdCR3Fyb1NheHlUTzhZWDdTREZLWWduUjNy?=
 =?utf-8?B?RG1TQW52VTg2UlZSNnVIWE9KZWszVUlHTzVLemRXVUYrdW5tTjExTCtZdzR0?=
 =?utf-8?B?QVN3TXREK0xKYXVIbHg5eHNzU2tSRldhR0l0cUEvUjRjNG5lMDczOUEyZFYv?=
 =?utf-8?B?S3BKRDJzTzMwMVQvaDA0QnpoOXR2SkQ5UE5QbU4xcUR5SHZvaWttN3FXd3lG?=
 =?utf-8?B?enI0bUhqOFVmRG90L21nRFhIdnVOMmdzYVFURUdoT1F5UFZDSkpScldURHR6?=
 =?utf-8?B?cjMxQXJvSEtPcldLWWhNam01UFJ3VUo1WmQyOGJtYzBoTWNheUpQWlAvVUF6?=
 =?utf-8?B?dlJwVm5xV21xNDU0WUUxUDR4ZnI1Z2FnbmVNRzMxQTFVVVpaMm1GaVJJd3JJ?=
 =?utf-8?B?dk1PZVNMSmdGWWZLQVNIbjJxVUVsaVV5MXJQRDRwSDYybGlKcUtTcVNQM1E1?=
 =?utf-8?B?VUE1UUlVek53UUJia0dxKzhmUVI4TEhkakVCeENiYlhsTDF6eEdSWXAxbCsv?=
 =?utf-8?B?eHVTWWt3bmphWFE2Q3lld3FtSzNZbUZoR2NuWm0vaGJJZ2h0OFpuKyt6SzJz?=
 =?utf-8?B?OGs1THIvRTV2VGgrMnZNOGtyRVpwRGxqVkV6cTFHNUd1UUcySU15cEVSRjF4?=
 =?utf-8?B?bzZWb2FHaUwyOHRnSU9jaENDWkwvVWlTb0NWUXBwcm5paUF6MXBTT2lTRjlU?=
 =?utf-8?B?TUI0Szd1TzNIdlQ1NURNYkFUQUpCSFdsVFA4TCtGOHFYMldOWkFJNGt4MGRB?=
 =?utf-8?B?dE9vb1BRcmRFU3BPL3d3OXAyQktyb3ZuY1I0ZVhYVlQ2Q3c1L0pOWmxCWHlV?=
 =?utf-8?B?ZEVSbVZub1M0QVQvd2NmSHVJWStoSk9vVU8ycnowb0RScS9IN0V6UUgrSGY1?=
 =?utf-8?B?NTdWVjNZcktBNWh5cThrdm1LS2s5aUtsOS9QNTBPc1ErRVZDZTJUZ2JkZ002?=
 =?utf-8?B?MVBKYlJJR0ZIQkd0N2dmMVYwNU1FbldKRjRnSWxpaUN3clZYQmIzSnlSSmx1?=
 =?utf-8?B?MytETjl4SHZvRjBZV2hZUnZIaVBaWk9ZaDdVZWZqcEt4MGRhaXpFdGVKbys5?=
 =?utf-8?B?Njd4RlBqSlN1NWsrQmd6Vm4vTzN0WTQvU1cvajVqeTVrNXZ1cVRId09lbjlV?=
 =?utf-8?B?YWtpb2I4WU5rdmtnU2pLUUw5dlNCaGppbmFUbkZsM2VoaVNGOEZPa2V5d1Z3?=
 =?utf-8?B?K1diWXRFdzQyOWtaSitlQ2xMK0ZhaTExdUtubUdIMFJnNmlubGdyMzRBRS9K?=
 =?utf-8?B?dmx1UWJvbFAzaU5iV2lqcE5IRXJqb2ZLdG5RMFRqeUNwR1NCTTc3Qm1rOWFZ?=
 =?utf-8?Q?Vz+G5oQiNgoQOstuId+5yYp6v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b597ae-0749-4c9f-5a39-08dcb6b77392
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 08:03:41.6286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ulZEAO0jXzOOuk6ucf0NxZp+kJ0TdsNn3AjAhNZNMCcjAsIMzrPflE2wTdrOpm9E3ehUapH16wT6kBHUKrs3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8716
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

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

On 8/7/2024 9:20 AM, Srinivasan Shanmugam wrote:
> This commit adds a null check for the 'afb' variable in the
> amdgpu_dm_plane_handle_cursor_update function. Previously, 'afb' was
> assumed to be null, but was used later in the code without a null check.
> This could potentially lead to a null pointer dereference.
>
> Changes since v1:
> - Moved the null check for 'afb' to the line where 'afb' is used. (Alex)
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c:1298 amdgpu_dm_plane_handle_cursor_update() error: we previously assumed 'afb' could be null (see line 1252)
>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Co-developed-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index a83bd0331c3b..f8ad8114053e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1372,7 +1372,8 @@ void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
>   	    adev->dm.dc->caps.color.dpp.gamma_corr)
>   		attributes.attribute_flags.bits.ENABLE_CURSOR_DEGAMMA = 1;
>   
> -	attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
> +	if (afb)
> +		attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
>   
>   	if (crtc_state->stream) {
>   		mutex_lock(&adev->dm.dc_lock);
