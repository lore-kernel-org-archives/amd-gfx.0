Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01E3C54FB3
	for <amd-gfx@archiver.kernel.org>; Mon, 26 May 2025 15:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C04DC10E39E;
	Mon, 26 May 2025 15:37:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PS1pa1r7";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0D0A10E398
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 May 2025 15:37:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbqDgPaIYGg9DMdDF3RHvOIAUeRaygkfW69mFHhs1tRYKs2/MZ0E2rKxh2XUkIQBChJf26Lh3eJ9wAvhDGjXxJWUAisFQfwvBj0L8VnDW/MPxY11IzjqqRzoOaCUiRO6R7xqALIx4+DBaYgSkeq1Tt6tZsZzeZlx3L5+fOXICb8Rn2zWoyyHKSHp3ncCtQKSdCabIkTD9vLM8ocN6cBne1df8W+Ig9zid4AiHduW6BG1d2D+xbfZxXw1idCEbE0Au5p5pGQp7KE0tydVMC2Uwms+uErm900T6adHMZbhByAMUlPQA6m8zj+03TAvnQigd8Z0tTsGBfTE7mWbbnwOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2m5G+KN25eFiM5J57cs5E7SZXSlp8oTSCLEhzG/7dA=;
 b=P8ceZPmttKjB1w2cmiE5M9OaXGX/fls8IgI8SGyJuaN3usuyQ3ppoFJ00xf2E6KajHjnPb7GcMipovG8cL/lvL6LSSBqE+v7J3SYEwD/7r43I0xRKb0N8pbZ5fL2AbMzxcRFUvdfdkWr4LcGgC3Q0jYnEw7xLM17ro5x5YQBzeNmGy/Cz7WLlKtZY8U+hv4lXwd7GeHdMr+bklli5c+YBncFZVVUI+WxiOJ+tdJ4+hdBjDSP/T+cZaR7/j1Yo505f1GcAHsNACDXAm4+W4evnGDFZExA3Xey1CBbX/Lu85L883UAJ7B3cMa4ptmwdUzN78dOlThhPvbGXtw+WFgVCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2m5G+KN25eFiM5J57cs5E7SZXSlp8oTSCLEhzG/7dA=;
 b=PS1pa1r7DQi7dpKzeVigNZYEyZfCVj9riBEUgL+tjjKEP/Khm2qE1yVkXOJNanLgtmlzxOEcdhReKFrf2hLJ6MVoE7ETlJoAnEWECo75y0fVByRwotP+VbhNJ32bPeGbgInPkCRK+ryb+H1KUKhiXACd/NeoLpEPy8NVP9v1fv0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Mon, 26 May
 2025 15:37:32 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%6]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 15:37:32 +0000
Message-ID: <aced0a87-8344-0f80-b1bc-7f3097e8ed45@amd.com>
Date: Mon, 26 May 2025 11:37:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] amd/amdkfd: fix a kfd_process ref leak
Content-Language: en-US
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Philip.Yang@amd.com
References: <20250521101254.831862-1-yifan1.zhang@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250521101254.831862-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::17) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CY5PR12MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: 62bcade7-3843-4c8b-d6a8-08dd9c6b3b25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VndTbnBCL3VJMHVlYUR5ZXE4YUoxNVdhVHZWbDdEcU1Cc21YSENadzM3VXEz?=
 =?utf-8?B?ZVZFR2tmYUtZYkt0WnVvRURFZ29LUkpnOUJ2WFU3VzNrZWE3dE9rVmFRSHZN?=
 =?utf-8?B?Uk1PVHRXU2ExQmdhUHJ2V1JGckxlTnBGbjU4RnMwaFlJbklkTWdXeDZpajVp?=
 =?utf-8?B?cjRoWjZhRjJRVEpkTTc3dWZaVmVwTU16eDdCaXpOdTE3eVNtWWdOOW5neStt?=
 =?utf-8?B?blpDNGllMGFPREpCQ2EyZXQ4NUdnOVRRUjZmQ2NiME9RUEFPYWdUNXMycm82?=
 =?utf-8?B?cUYvV3l2MjhkekZrbUpaNFFwdmJLb1BwL2ZzVDgyelBodk9rbW9WL2J6Vktx?=
 =?utf-8?B?R05QTGVzSll3N0ZYb2pwTFlTRC9IU3JMelo1WXA1cmlOVjl3dGRRMmlhRHpn?=
 =?utf-8?B?bzJUOUdpZjRncURKZVRlM2pWTGQ5Q2U2R0FGQ0dQbWdMNWNyVG10V2FwVWJz?=
 =?utf-8?B?ejVYQ3RJK3RrSEZFMmVaakg2bWlrT01Kd1dFVlFzcTUwYTR5V1Y3cTRtYmhN?=
 =?utf-8?B?TDU4dUQzbm83a0ErV2JTNWtNbitjbEg0RFhyeC9KQVRaUUc2TFZQT1hwbEtK?=
 =?utf-8?B?cWJOcjJEbnVaSWU0TENUM3hiei95c3dsYUNWdkFkRjZhaEJYbDBRKzVqaHg2?=
 =?utf-8?B?SnNvdEhGN2diaGhtYnlEWTZKc00rMWE5UnJvSG15elNTODBsVDNZdm54a3Q2?=
 =?utf-8?B?RS9OY1FjeTdQb1M2WXFjWjNhaVhTdDNoMTNGbjJzNzB5MnhrN1dWbHA1VE95?=
 =?utf-8?B?M0FyU2JyV29yVjZkY3pRcFk3OWxGNlNkc3V0d3lrZ2VHazZ1NlR0SXFMWWhk?=
 =?utf-8?B?eGFGc1IrU3E0b2FpYjVEc2ZxM1FjYzNmbDhFeEFmeFBQcnRTM2tRN0Npd3lP?=
 =?utf-8?B?ditZS2E0b0xvU08weDR4a0JTNEJBK1dXdXRVbFUvOFdQczFLb0FBQmJrcnNG?=
 =?utf-8?B?ZGROSzFSUkF3Sk5MY3VqSHpuTktHdGtqQnBaQU5KNVFhSjBLWlVvSTR1RnpL?=
 =?utf-8?B?ejhrTkNWRFJuNllSYVBJVFhWTDRYNnAwcDdhOFhabXlGU3NzWFo2WEhuc0xh?=
 =?utf-8?B?NTJQWER1VnhCR3MyTnlpR0YvcXFSR3ZkTlNoSWc1bGJOZzhFOXBEWklOaXRW?=
 =?utf-8?B?YTJCTHozcVY2OUhnUVB1VXNuR0wyMnFnL0pLYlZ1Tm8zWi9KVEJYRGh0L213?=
 =?utf-8?B?M0tiVzJRdFRYYmpUQnUyRUp6S05ZckxOTXRhMW5GNE9ZKzA2TWZJYUM4dC9v?=
 =?utf-8?B?MkdNU3lTSFJGcnQxRXdGQjEyMTVQL01IcjNzanhBaStKZ0Z0OEkyS2FlSGdw?=
 =?utf-8?B?WXgrQzBXUkxkdWxHM1hCQmFIMS8rUXk5L1VWY3k5RUozQk5zV3ZTc0hNV2FB?=
 =?utf-8?B?cmNDVENwbGk1TGMrUE90NDAyQXo3WXUvYjd0RElqdStEQk0zMUNwNWI2VlNJ?=
 =?utf-8?B?eDdGZ0hmOUxsc1lGWE5zd0l0Q214Yk9Mak9LWlR2STFyYW8rYjFrRDhyL2RR?=
 =?utf-8?B?R0JSL0phN2EzTm5Ga09PUy9zcE5CcVZIVzRCek9GS0lMSGZIb3dPL1dtaDhp?=
 =?utf-8?B?UVVhQ3BpUXBVUXF0ZjR2dE8yMjFuVW5RZDVkeWxPdDFCdzNCTmRIZ2RuMU5i?=
 =?utf-8?B?ZlV6azZjT0EzNE5iQStqbFh5aFJkMnFWN0hsVXFFTURrNUhXT2ZuckcycGxQ?=
 =?utf-8?B?d2tuZkRTb29kVzhTTmYycHZTcGV6cGVEVXJFVC9TMnBMOEVoekRFQkU1SUlj?=
 =?utf-8?B?Z2d5b3lUSU5IVFN5MTJZRjVBeCtIOER6Uzh4OWkzOFpYUWRwN1dhbnk4VVUw?=
 =?utf-8?B?MDJtWFZ3M0tWVU9kRUpZQkhmVlcvSUxLN2Y0UHRzbzNIa2d4N2FpT1pmR2dr?=
 =?utf-8?B?SERtZ1pXUzNGSHNkOTdEVkNkakdqWVZtb29UbnBITlVWcWhIM0xMdnRKYUpL?=
 =?utf-8?Q?y2k4Q54zNJU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K09IaVB1V3VUYlhMazRFQVVncEptMUtWMCt0VUZsbmQxbzF5K25YRkZXNmdi?=
 =?utf-8?B?a2I0a245LzVBM29ma2ZJVEVraDZ1Mm5UTTIyLzZxQlBzcDJ0ZkF2aVdDaW1j?=
 =?utf-8?B?NTR5U2E1aUZaSlIvNFczQi8zU3duSVJ4U25jUG9UYmRiQVdLSGlGYjRjZHoz?=
 =?utf-8?B?cm5PVDJvU3E0QUNZdHFGa21ZL0s2YTJOVVhZaUZwVGhQUUNWZE1NNWVRaHR0?=
 =?utf-8?B?RUNldTZTblp0dVFwblNscTE5aFcyWFcxeVhEdTM1SGxIUElxTTZYaVljOUVa?=
 =?utf-8?B?bGZiUXJ1d0d5Y29NeHhDaUpSTDB4U2t3UjRJcHcyNnNmeW9tNkZVV3QxUUVL?=
 =?utf-8?B?SGdHRUhJZmhMeTI3RHNjZHdIdldBRFU1N3ZiNVNEY1ppd2VvRkdRa3VldU9m?=
 =?utf-8?B?UFFLZ1hCYXRmUWlyYk1TUFpXME0xQWRHdEhNdEo1VUFqTE1mQVo3RkJpSkl2?=
 =?utf-8?B?VHY5TDViT1Vuc3JPdTNHejFmZ0tlOUdoWWN4d0FDOTE0RmVhTnB3V3dhNzV2?=
 =?utf-8?B?VVRzQmQ1aG9rSnBSeU9uSjNwakdVTGZhTFFjVUtxVVkzREJzZlpNWnFWd25i?=
 =?utf-8?B?OTkySXk0MW5sazIyYkoyR2xoSkdqVHo4WlBzdmhxTlJTRFhWYkc0Ry9lZFps?=
 =?utf-8?B?amRpR3hsOHgwT0szZWtrM2RNT0YwenFUMy9uZmxkVkdQT2IxV0ZtbGVEaEVx?=
 =?utf-8?B?YVhuVFRJNlQvcDNsRm5GZzN1WnJzcklHV1NmQ3FKNnZScFg2MjZ6SGllT3VN?=
 =?utf-8?B?c1poT1BzWnJzWmFDbXp2ZEs3NHRmdmRsbzl4aUtDMDJnK3ZsM0xMb0FXbGxB?=
 =?utf-8?B?czh2SjMrTk9TZWFqNUJRRDF4WnZ6VnRJY1V0WWltZmptbEpEdVdSa3A2NW01?=
 =?utf-8?B?Y01RbWpCUU5vc2lCUUtCMjFaZnNNZzQwUlZKR0gybWpVZFZUNC8vb05qc2JL?=
 =?utf-8?B?QlJHZDhuWVYzMXpYNkFFaW90Wm5jMDJ0WkExdEdOMlBsUzduNXV4WFc1YmFI?=
 =?utf-8?B?bDJXTVExTG5MdXhzQ0dGYVJJVnFzd2U3UTMxdWFRYXNrTjVlR0lxUU9wbjFC?=
 =?utf-8?B?V1RrTCs2NGhsNTlKODA3TU9HNWJDc0VuVFVwN2FsbS9PQzRzRTAreU9rMEhi?=
 =?utf-8?B?bEVVRml3YXRzYzBwTURxTWFiNThSVG9HSC9Na1JnSGFhQVlrczNweGhXV3hy?=
 =?utf-8?B?ODNRMktwcGtyU05INTUrVUJNY3o1d3Y0MXlVYkp6MDVIZm5ubjNlUjhiVk5Q?=
 =?utf-8?B?NlQ2MW15dDdVVUY4bWg0am02NW0rc3RHZ1owMzdncDJRSm1nbmtMVHZYdjV6?=
 =?utf-8?B?OHRCaW1tMFlJTzhHRjlielZteGtiSjBWL0d3TVJEUmlVSTFjMVc2NXMxbU5n?=
 =?utf-8?B?YkJ5bmF6T1pEc1QraEVIWE1tL1Z0QnlaYUxxTHNTWVdnanFYWCtnNnltVXpJ?=
 =?utf-8?B?STBKVkZWelpnYVA5UXVaZUduRTF3RHNzakdZbXgvVGl2eDB0MGlWR1QzWUkw?=
 =?utf-8?B?SDhCbVl2eGpWWmVFeGV5R3R2VG42NzBxQ3FpNGtMZEt6aHZ2MitjbGhlQzk2?=
 =?utf-8?B?MXJXZ3VJKzlKOWdzN1IvOWdZdENQMVhENlpHMlRQUkViOEtweDU4MmFPWGhN?=
 =?utf-8?B?MzBsYS9xVk1DR3lzSXNJeEdPcGJZM3JxTE9lYWFueUVzTEF3RXBTSTNXM2ha?=
 =?utf-8?B?QjZtZW51MlQ3bGd3dXdiTnFQNFRoaG8zUVB3OHVKMXBWamQ2TEs1T3VBRzFN?=
 =?utf-8?B?NDA2Wk5ESEdOQitmcjlZZzg1eWVjUEt4bmMzeVVoZGtGL24yOXZ5ajUrbXhi?=
 =?utf-8?B?cm9EenVGSEdyNVJ0UnByY0NyVkRzdHUzSVlYSlZ5UWhOekg1bHJGVCtVR3dw?=
 =?utf-8?B?b1dPWGtNZUpldEMvYTR2Y2hnU1FSTWttNVFmVklQZVJCRnhuYTZKaDhHbXZC?=
 =?utf-8?B?cm11Tzl5Q01keHZwTkFYTG1qU2V2K21nWnRxMjNzbkhyd2M3MFBHa2gwbGpy?=
 =?utf-8?B?MEw5T0tsbnM3RlcvWjFIbTZQdlFueW9saGhwVFlabnJiamRmNTJkNit3c2J5?=
 =?utf-8?B?a0ExK095aG5wZ3RFS25JTHZmNldlWFdiWW1DZmVmand0dEdtaG5lUkFGSlA4?=
 =?utf-8?Q?23tw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bcade7-3843-4c8b-d6a8-08dd9c6b3b25
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 15:37:32.7222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVt1VY+Fs0HoTHt82lf2Pj1Rnbyu5fpHxbwa4GhTXB4Zcro3aLaIoh/ZzbDJkt2c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6322
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


On 2025-05-21 06:12, Yifan Zhang wrote:
> This patch is to fix a kfd_prcess ref leak.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index e54e708ed82d..2b294ada3ec0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -1350,6 +1350,7 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
>   	user_gpu_id = kfd_process_get_user_gpu_id(p, dev->id);
>   	if (unlikely(user_gpu_id == -EINVAL)) {
>   		WARN_ONCE(1, "Could not get user_gpu_id from dev->id:%x\n", dev->id);
> +		kfd_unref_process(p);
>   		return;
>   	}
>   
