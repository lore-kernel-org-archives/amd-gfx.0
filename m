Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A42C3DA61
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 01:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D08FA10E089;
	Tue, 30 Jul 2024 01:58:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="118B0pKJ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B26F10E089
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 01:58:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fr3ybRHFbVU9ZG19FXNfOBk3sIckdQzyFRiadGkp70ZYOVBtiSqUpRQpfmMkrR2Ccbwwcmqt8PZZKeZQED5Gq/wldTD2QnZ1JkOZ/VsVHA0qZN70ZT/phV1UfJSp+nAtAgM6QpKUbrkOAcOng2n2lPT/eYHyvOBSpY2KnZmdYXppA7o1daPn4fGnF6w86l9EpFBk32iltHYWxLknrrwjSec4/tuTrfRi6lwmyuUqDtJuCfLKq8d21GSDvAY6twgKN4FEgEYtxLYQqWeJd7dohUnMIyv5bnVs7TI/jcEK2guP9x+ZNHoNdp/3Gaecd4Nl6BPfKmmXUBfR4NDJE659mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wKZ9DBhW7RZ7NWJEVvxR1D4TBwWvKC20n88d0mCphE=;
 b=f+0cGK15p4XXeJuV9mgG5C48HF+TERowKEeCr9l4SyYOPYrwW1rk+NxXUJJnQHHq+sEVJtDDe6kudJbV7seQUXazI1Faky2LYBIOQ6mF9ngYbo2Pc4cp+01ommLueXPznj6bY5au12lJYII3JMdVk5+gsZuteagUcS5f8K63Drf1DvnVwafGSo0KSC1FGvnGpyKWNoFUXttvnHAIjlKfWL0/u+bSKtIbapmzdpinP18Ru8USpDSuZyL2ziFpfF8QpGEt+g1TKxoT5tRoTfxwToWZNvcb4E5PzaRzAE6nt0i/pAsBsW+KljkpNkReFQhnrVMXjC2xg+iQpQqmFfz+vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wKZ9DBhW7RZ7NWJEVvxR1D4TBwWvKC20n88d0mCphE=;
 b=118B0pKJ/aNNyryObEeGxyLpJvEaNeGzeUp8EKwkiyBa4/TXIPE9lUnkOru6l4CydCzm/xn8K0lTEC6s7KEz3vdA2HDWSiKCT3ol/8g00d9o6ltqbHuz7PZYXKObDKZuL3ENBjaRF/xQ6CKJDkiaHsSSKCb+0QTXJ7Cix0tcfMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by PH0PR12MB8152.namprd12.prod.outlook.com (2603:10b6:510:292::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 01:58:30 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 01:58:30 +0000
Message-ID: <89ad2a53-6f2c-4db0-ab89-ad7291cfa52b@amd.com>
Date: Tue, 30 Jul 2024 09:58:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Handle null 'stream_status' in
 'planes_changed_for_existing_stream'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240726140309.2409761-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240726140309.2409761-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:405:2::15) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|PH0PR12MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb4b8fb-7b27-426b-3fff-08dcb03b1bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXRka2RXZUZmeFZMM0tYdXNBWWJUUjBzdjFNNCtGUmI5WFltTEZIL1AyakFy?=
 =?utf-8?B?K3pZUkovS1FlVjB1bnQzc0dBUkI5blFzSWcyUi9SWjNZMDlyS3BoRzI0cVNJ?=
 =?utf-8?B?NmsraWRsSzMxRjE2bEd4blpPaGExL1FFT2VTbFdnVUh4c1huejdlSWNTVmpY?=
 =?utf-8?B?aDBoTXJNclF0bHpsVjBrYzBOM1Q2RGNTTVIzUXVvSG11THdCV1l2a0dZU0dH?=
 =?utf-8?B?SlgxSlR6ZTB4cVMrNXNKN3dTTE9vYlRrcU0vdmR1U3ZYY1VEc0prZmg2TzBU?=
 =?utf-8?B?dUN1N2ZRTU1WNEd3b1hqSFRPc3VJSGViRHJBdFBWTms5ZkkyMjU0MXJpNGE3?=
 =?utf-8?B?RGs0bjdJV09MWjEvMzd6MExzL3FoKzBoSEhsbVJNMVliUzhWc3lUNTZVWnhk?=
 =?utf-8?B?VjFRaUx5aUxvVUZQdmIxVmE5TTNFNm5FRFdRTlJlNFBSVXBQMnAwbkNwanRS?=
 =?utf-8?B?OFBIbWswOE1lVzFad1JPOUY4SDYyNjcwZE81SnVDZEZrejVhREtmN1BJTWNY?=
 =?utf-8?B?dzRQUTJDQjNSeVZrYWlhSS8xZWFEK1psUGtiT053bktJaXFweEdNTUU4ZFVv?=
 =?utf-8?B?MFNFbEhpV0Y5OVYyUFBrQUhoYkFpNThGRDVWeGNtcnZkeXBIQ3RvRHMxbUlJ?=
 =?utf-8?B?Nis1VWY4MlBmYzNUM3VFdGZTaFVzeFd1akd0VzZmQjcyeHV2RUhEemNsbUMz?=
 =?utf-8?B?NEduWGUrSUJEV1ZSUzZBSkF0ZzRRYTBFS1hqbGVtc1Y4eGptbmlPbU1xMGFO?=
 =?utf-8?B?WHlWVGNud1lIVHVLcGM2VnoxYnhWQzdTcnpxVVZmWlBNOEFkZS9LQlBuOFF2?=
 =?utf-8?B?bzlVc2l5UjdKODZLQllkKzFRaVdtdUhsQ2VucmlTQ3o4ZnNySFBJcGJkYUEx?=
 =?utf-8?B?OGNkbyt4azJhMXVqT1VGaHlRME42ZXdRdVBsRkxzTzh6U1dVRXR6Z1l4RUZD?=
 =?utf-8?B?YnFWS3JRT0JhZGJrY2ZZNHc1d211UjZPSHFZNStZL3p5Z3dVQmthMjJjK0Jj?=
 =?utf-8?B?OFZhSkhGbEtVaUpmVEQwelF5VXdzOG5MUHRtM2lOMk05UTNoWW1tUnl4RThY?=
 =?utf-8?B?YjZ0KzdHTVRRbVdvR21TMXlYN1JObi9Qcy9rT2ZTQ3NkYzl3dUxUSWUyblFn?=
 =?utf-8?B?Y1lRek9EeC96OFZZVTllMWpEUWx3ZkMxR2lrdVI2a0FGandOSGlubjFhT0lP?=
 =?utf-8?B?cGpWT3YwWmhvckJsQlp3L2hleWdMUUkyUG9wTXU0N21vS045dEgvNlZnZjBZ?=
 =?utf-8?B?c3VjdWlIWFpXaSt3S2lQWjZuY2NjcmMzcFJwRUFQbDM2MTZNWVhOS09ZTmY2?=
 =?utf-8?B?VDArK2trNTZKQ3B2alBsOXVsbnpXZzh4WFFWbGJFa2tKbCsza3h0V2R2bHhL?=
 =?utf-8?B?Q3EzL21qcUYyTWN0WWhxRUw1QzQvZnRzWW1PTGMxbUUrcW1lczRSKzFmOTF4?=
 =?utf-8?B?L0ZJa1ZpcXhXQ3pCa1Q4dWUwRExxS2VIV3JrTkwrSDlxZGFIR3FLRHdNTHYv?=
 =?utf-8?B?YjJBVnlKdS9YV0Mrd2o4eGxRb0QyN21IemkyWGhCc1Z2WlpIMTRDNFYzY25Q?=
 =?utf-8?B?QmdUZ0hKOHEvM3FiaXVGSjRRT0g4NmFqQjZMd21HYmpPZFBXeHd6c1dTc2ds?=
 =?utf-8?B?NU04MDJIVllQWWU5R25yNXg5NEZMbG5oOFZsUmZVNkpzenJDQmVrOFZZbjNV?=
 =?utf-8?B?bHBMaFY2UGVHMDNrZFBUZXVxQXovaE9uL1FwQXB4RUFnVVdPWWN2S0UvRlZD?=
 =?utf-8?B?cjh4ZTBjbW9XbENxdHZONklOcGxBK2VSVnI0eXVwSFkrWEdEM1kyb2lSUGJU?=
 =?utf-8?B?ZXE5NjhNSThEVm1FSlJVdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVNHdUVsR0NGSURhVWlnUzd6WXF6aDFyRk5HWWhCWG1tUG9mbjZpZEhSNTlC?=
 =?utf-8?B?NVlxZExUK3VFQXlCbDdrZEFJUSt0ZGRrUXdOYTZnTy8wbElUaEw1cVRUdFBW?=
 =?utf-8?B?eUdpWWtGcGpiTEpBUWo1VmZXYjFrYWViOE4zTzdoMlF4dEprNEMvYlBKOFZY?=
 =?utf-8?B?R3d4dVVrTUprSFlhSDJKK09aTlZDQUhFM3Fxc29hUWRRZFNjWHExdkhnV2gz?=
 =?utf-8?B?VEV4MzZnZDlHNG9kZFpyUVpUS1JYTDlRSklrMnlVbDBoVGhvU21yZkdxQnRS?=
 =?utf-8?B?bFQ0bU45dUxKRHVvUHV3MmNITmpBVlZETjBsR0lrRHJRZ1BYNHNWeU1PMjJW?=
 =?utf-8?B?djhhZnlhT1JYK3VybktOaVB1TFNMRExjZjhEaUdHUnhXWFhtWjZneHY1Y1p3?=
 =?utf-8?B?cklxTGU3RnJLSWc5RWloZ1UrTmE3Q2lVdlRtRU1MdlJZd2YzOEhIK2ZJenV2?=
 =?utf-8?B?bTRYL3pmOW9JR3NKQUpoVHBIQ3pZMVZKRDB6c1RJNEtGZ1Bjb1p5cHFvVEpK?=
 =?utf-8?B?NXp3dHRvRGludmFhWjVjdmVXdFpWakVFem1UcHJVMVdkcE45bWxCZ0hIaXRV?=
 =?utf-8?B?NFNENExLUWNaaHJReWNJaXFKNXpET2JVVFI4YkpXQm5YZUUwK0ZvK041TGtk?=
 =?utf-8?B?WDVpaGIrQ2Z4YVpNa0txbzZacXZ4UVFOMGhMMlQ2SndhOEdXN0dsSHN0Tlg4?=
 =?utf-8?B?ZVJxTmMxZW5VSHZMd1FNUFhxK1FpRnBtMm9oaXI0dlhQeXNiWlBucVZWSlNn?=
 =?utf-8?B?dkdXZGlKT1MwOWpOa3lpczZxeVlkMEYwZ0dzQWpPdU4veEkvZkVOZjlFTXh2?=
 =?utf-8?B?aTU5NXA1OVI3Nmc5YmozbjVjeEdNYjFaNWRCSVozbXVtZmxrWVdwOU9HZVlx?=
 =?utf-8?B?WlVnYjhOQzZMQXpyMjN4bmJ5YlBkNkRyblFvZzVrSDJpV1d0bHd3OTIyM2tU?=
 =?utf-8?B?bEx1UDZEbDh0K1ltWWNtOVZoZ2xtTFhoSzV5YmpBQmJiK3dxWTlGZE1WeTBt?=
 =?utf-8?B?UEI3U0NsdWNvTTFDN3d3K0p0bHROVzUzcCtISDNFejllcFl4cWc0c0ZmWkFw?=
 =?utf-8?B?UDVTZ09vU3BWVjJXM3crRFlFVWJsNGhuNDY0OGJOQjVsU2xCUmxQVG9NZWY4?=
 =?utf-8?B?TERFKzRzRUpQZklpd2I4anl2RGJzMkpaMXhYcThrUWdEZ0JzbXYybmtyeWF3?=
 =?utf-8?B?Yit0aE1JRnV3N0JjZWxPRHh6Q2tLOGxJamUwMFdOOE9OcEoxOHlwcmNRZ2tx?=
 =?utf-8?B?RG41TlhlaVhHbktQRFRLZXkwZ0hpejMydm9qZzZYQkpmci9YWEEwRG1YeEtz?=
 =?utf-8?B?R1F1ZEQ3M1I0bEZ1M2FoUE9DQzEzNkNYSkNjZFBIYmJmZFR2b0hhS1pWWDJZ?=
 =?utf-8?B?bUoreWRZMXQ4ZDVIZStmR2o5N0tObWltYVRsek9ZTG8wT0ROcVlsKzh2bTlU?=
 =?utf-8?B?THluQ2lhTnN5MHdsZm9XZG5kdDk1U29EakJENTN5R2FpVjYybmZMVGZscVli?=
 =?utf-8?B?YitQSkU1cWFNd0RDQm53RTRGUkUxTnpUcGFoRmdEQjZ5MW81UXVMeDQyL2FO?=
 =?utf-8?B?b1M5R0t2NUZlczRaTjh2TldUQWNiY0FHcUR5WXhEWXo1Ni9NMmdhTElkVnI1?=
 =?utf-8?B?UTQvRERZTjJ3SDFlU0Z3SmxnbXBLdk8vSmRQdEdJYUFnK0E2YmdTTjJIUDdS?=
 =?utf-8?B?eGhNTVova2NkV25mcUFHMlVEakJma0JFOEFGK2ZYS2h3UUc4V2tncFRHRlFG?=
 =?utf-8?B?NnByTzhKMFREemFQbFJVOVhPbldvNXNOWHZ1NHUyajlqUWwyZnR0UFRlVzFo?=
 =?utf-8?B?OXJJT3lsRGhtbEdmNjh0cVRBdFp2LzA0REtSQkdwOHhEZmg4QmsxK2g2Y2Fa?=
 =?utf-8?B?SjA3c1dPdUhjYlZuRExpNTNGdTJXY0lwVlJvcTdla0NrNGQvYXhYTDdEVzUw?=
 =?utf-8?B?UkpZcHJuYWxzcVdvZFZoRTNqckllcnVjNTVlNEozVXl5Q0Y2bzFqQWZ6RVpG?=
 =?utf-8?B?bnlUengrOHNqNGppQ0pFSFdJR0pEMThPaVlwMHpOSEVHYUtCRHN6WFhqNXdj?=
 =?utf-8?B?VzhKMXZiWkRGNHFMekg0dVo0VDVuTHR2dkt0MHFnK2ZwdkFQRFBCYTA3T09v?=
 =?utf-8?Q?kwGsliGqZ7Wem8z+ZtIUot1Ml?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb4b8fb-7b27-426b-3fff-08dcb03b1bde
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 01:58:29.8846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2UX/QXOW1GsnRyx3juf0WkXNvA0s+2Iko8w+LXU3AsfmtWLGcfWUc5i2I/y1bLkqJoL4i+4ijgiao/djNtlUOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8152
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

On 7/26/2024 10:03 PM, Srinivasan Shanmugam wrote:
> This commit adds a null check for 'stream_status' in the function
> 'planes_changed_for_existing_stream'. Previously, the code assumed
> 'stream_status' could be null, but did not handle the case where it was
> actually null. This could lead to a null pointer dereference.
>
> Reported by smatch:
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:3784 planes_changed_for_existing_stream() error: we previously assumed 'stream_status' could be null (see line 3774)
>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index 5c9091f2a8b2..60d34c696b18 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -3771,8 +3771,10 @@ static bool planes_changed_for_existing_stream(struct dc_state *context,
>   		}
>   	}
>   
> -	if (!stream_status)
> +	if (!stream_status) {
>   		ASSERT(0);
> +		return false;
> +	}
>   
>   	for (i = 0; i < set_count; i++)
>   		if (set[i].stream == stream)
