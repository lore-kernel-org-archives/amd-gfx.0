Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5CCC25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 18:38:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7563910EA10;
	Thu, 23 May 2024 18:38:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MQAF8ldT";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 482BF10EE05
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 18:37:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHWmVTQcY3xI19jPoFO85cbt/rlmGk/TVJZZI6YNGfENLxPoUgn+LdD5eGX05p148/Zm703w6dB64eukYdQLTLuT3XXcUS5G2FdRpRczlaK//ZhyylzbMytqelzRAdTSsN4xxdfSO64PPMIuexTw85DW4qsJEJkvAyjIBwgRZ0/6M9HglLN2xm+wBB5xf8D8/X1rhOOgck3F0EgUYf9b2CckiplWBHXi3VwrnYv7p9w69ihlJUcAzGxBIoBzVdS6FuBeA2AAwKw+QLJ1lhMLSFHrHApKsVXZrLnfCHBRNmOYgquZpn9m4v9GxdgnrdL+zG2A+MoM238QuBjh9exMfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+oqPk+3/fJ61NL5+Ua/vTjgepamWfEsDuQFAvsQxBU=;
 b=EbQjk7K280ERFfKDL0SU+F6nvGVDALAroW850N9GJsU9s4UAmHR5SUwJKKw6Oman1aepT051RjbfgVBeExzVg8OGRpMTo4BPPRYUZXanBh7ZdwZ6vksKNYFFhWgGguLPI2FIQfgSAN1X6xIFIZhU2EaEXQ7wvZyemOqd7mM6nx4ll//I1yRJi9VGgUWmjzuFJuvlwP4O6ANXfAA6YIZiu0RUXbOWyVDIT26XbRku2Sukc004pVBXdQBcgVU7XOscpLPfBE9HTME1+Hshziub5+wUcxqq/J07QyP7JdB+/6PySwlCTynspQtUCTHkEqLmIabrVJvJaNQYEBo4Oxw9Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+oqPk+3/fJ61NL5+Ua/vTjgepamWfEsDuQFAvsQxBU=;
 b=MQAF8ldTl16sH0H5abj1Yn+ZrQ8QMQSoHV11kGU/5cZa5QoV0aoWeZ4rpSxxPBL1w0a+yTCQig1cKpCplXTqlZTZivYrNSQSqb5ZT+F4Kt9kIwMcq25QmzDItAJP2kSRJdeD1yycvpd9oA/iQ3LizO67Gz+/X+xDuvgd3vW6Ed8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 by DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 18:37:48 +0000
Received: from CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::8c67:8cec:7c4a:ccaa]) by CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::8c67:8cec:7c4a:ccaa%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 18:37:48 +0000
Message-ID: <6572dc07-fa47-412c-9ad3-ace0c3914cc5@amd.com>
Date: Thu, 23 May 2024 19:37:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdkfd: gfx12 context save/restore trap handler
 fixes
To: Jay Cornwall <jay.cornwall@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240523140809.1135226-1-jay.cornwall@amd.com>
 <20240523140809.1135226-3-jay.cornwall@amd.com>
Content-Language: en-US
From: Lancelot SIX <Lancelot.Six@amd.com>
In-Reply-To: <20240523140809.1135226-3-jay.cornwall@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::11) To CH3PR12MB9079.namprd12.prod.outlook.com
 (2603:10b6:610:1a1::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9079:EE_|DS0PR12MB9038:EE_
X-MS-Office365-Filtering-Correlation-Id: a93ec7af-b3cf-4d38-b777-08dc7b5771af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGpabDlEVTNjY3pZMUVHako5VnZlak92OUVNQlRha3RjR2RxbXZNak5ackpW?=
 =?utf-8?B?K1ptZlljeXF6NUFadlBtd2JqK3FTTWNmaVIrZUpRQ05DRVVra0N5Sm5MZ1F0?=
 =?utf-8?B?UUxUdGR4L3VTS0lPY2s5ODIzUC9RL2hETDQxbHVSTEc1NFZHN2FxdUZ0ZEp5?=
 =?utf-8?B?bTFiV3V6ZXIvLzl3V0pEa3ZjVDRteERXUEIyd0dlWHliN3p6TngvUkFPelNI?=
 =?utf-8?B?K096QjdkdXNEQmpsN1ZKRmdwNWNlaDU1MkIyMWRURmo3VmJxMTRGZ1dYK2sw?=
 =?utf-8?B?RkVub20yZmF6SjlhMGJBUmIzQ3J6Z0dMNDJycmxZMXhLVHpiZWhZWnhTcldn?=
 =?utf-8?B?WnZKNWZVSjFPaE1JMDdvUGZWZE9ISW1jRmZaNDhVNkRxN3I5NnRtQjdSN1Fx?=
 =?utf-8?B?VmJjSE9CQUhiUXlISnBTcTd3YURTdXphRnM2RkZXVHU3Y3lTejV4TU9ZWkZ4?=
 =?utf-8?B?eGhiWTczZVU5WHAzUUUyTDI0Q01TbnNDOVcyU2c1S3BENTJidWFxVW9FVDhj?=
 =?utf-8?B?U3NqV0JXUEJZaEtjaDhaTFFZZkErRnBrRjlvQ0lJeE1iZ2N4a3VZOW9mNFZ4?=
 =?utf-8?B?dm1uam4wUzhhZmQvTmQrTzFMOEppOGowSHdCNE54RlZTU2gxMEJXRDF0dGhj?=
 =?utf-8?B?Q08vaERMVjJNRkM0N3prTnB2a2R4K051Yk4xTG9MS3IyOW4zbHJJbkNIQXYv?=
 =?utf-8?B?enN5MmJ6YmxuZk5DMDNNZ2JkdEVNNUl0dDF5dXQ1K1NUa2V5OHR5eTV1VW81?=
 =?utf-8?B?eTNic21NOFR1NkY1cTRuaEhKVVZpMXFKZXFXRFZXTU5iYi9PeXJaV3JJWXo3?=
 =?utf-8?B?Q1dmeisyNHFadDc3WkwrUE9YRTFmRWtqTGVoS011eUdPMk9uSW12L2hCdzNq?=
 =?utf-8?B?b0UvU0NXTW1kRnhLSStmWlE1aytEYTF5aFFkOGRsUXdHUDE0YzlEalp5NzNL?=
 =?utf-8?B?b2t4VVdraFFnUHRoaG5kc25NbVp1bnhuZHlUdmQvbFBTYWpQVDRUcUYwUSs2?=
 =?utf-8?B?enNOUmliSkVpMW9BeDJrMnpMc1NvUkxvSmlpUS8ySWJwY0JrZ2h3UG9UdWtN?=
 =?utf-8?B?RmU3M2srQjU5VHNmd25QRTJFVjZXR3FUK09MbDNMcHd3VUhQbXZ4NmxrbGVu?=
 =?utf-8?B?T2QreWpyd2VWdDAzZmlzV2czSnE5a1JaR2xaRGNSZ3MrbmpDYndPeXhvWFVh?=
 =?utf-8?B?cC9oMGNUdkRqdU5QOWxVajhwaEdZRW9ySE1WbnZxc1YrN1FkOURlOXRSM01Y?=
 =?utf-8?B?NVdPYkZJa1Q3SjdxNFlPSzBrWDc1bVZMMlNBWng5SjlESXV5USt1L1dyREMw?=
 =?utf-8?B?R0FZL045bTE5ZndNcG54OVY3NDNDTmYrd2VwS2RGdlhqWWpMSXVuc1RZUHVK?=
 =?utf-8?B?bXZYWVdrQzZqdlVEZW8vTkM0c1NkeFFGUkxyL0xwNHRIYmJ3NWxnTkJWWmZE?=
 =?utf-8?B?WGlESUZKYTdaMWpVYmRBa0JzeDJQTUtuQ0hXdGlmbitoVjdCM05kMzd4WmYw?=
 =?utf-8?B?MGxKc2hzYmQvdGw2Nk9mMzlHbzhvUkdxUlJ5UFhoTDg0N2JWSS9udFBsRU51?=
 =?utf-8?B?ZEhYY0JTZ3R2K2tDb0RqeDJteHVuZHA5WVZETzE1WUNYNVpFWmEzYWhLdXZF?=
 =?utf-8?B?bCs2cFh3M2x4eHdxQmRxdWtFMmRGZnQwSUoyNmdJY2ZiQ2pjNFpPNy9vQ25J?=
 =?utf-8?B?bFNCRUxCWW9MZUptZVhJZlJweGZLUW04QVVMbmlUODZWQ2VMbEM5OU5nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9079.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnFYakJtTUgyczN0MXhJZy95SHo2YlJySjl3MTBZNVlVZkx0emVycTR5QnNM?=
 =?utf-8?B?TkxzNm9QTjVBVzkwYldzWHVJajY3dXVwL2Zad0U4RVZTQ20reXBiOTFrSUp6?=
 =?utf-8?B?T3N4R25TcTRoL3hFWGxFbzh1QUQ2SUtOcktRQWo5YUU0ejZDVWI4MFZYRjFM?=
 =?utf-8?B?R1p6U0xEN1BYcWxWRlVQMVA2NWZRb2g4VDR0MkI2UkdYUVhuVU5YdkpzODNk?=
 =?utf-8?B?WnhaSXZ5aEJsV3ZEOE5Sb3ZHVnh2cUkzWFozOHl3dFFyeFNDdTZJaTN1RUR1?=
 =?utf-8?B?LzV2RTI0TFJPbzFQMDZlK29QWlg4S3hDb2R0MExPQjdENUFvR3VPZTQ0ZjRa?=
 =?utf-8?B?bWpVZTVpY2NScVJlbFd5VDdQbmdqOFF0NlFvdk9hN3Z5Zmc1YzVBT1RaM2hG?=
 =?utf-8?B?WlJJZHhnWTFJUEF6WVZlalZzdmoxUGMwOStIaStYOUlhcTdmRTNtdUVXeXdj?=
 =?utf-8?B?NFd5b2ZHWlhEVjljUkIzV1lpU215U251RHpNTVlEZUh4QW9RdG85V01xK2J1?=
 =?utf-8?B?NEtYK0pUUDRmZ2xXTWluUGRvYWEyRXhEVHNzU0kxUFJLeEx6UUx5ZWY4akxK?=
 =?utf-8?B?VU5IRWpaenBrV01QczczVDZ1NmdFMjg2L09qbi8vQ2daWVRqNTgvbCs4djBU?=
 =?utf-8?B?ZkI3S0ZmYXJyL3RtNStacjd5aW9OTXU3SzdOalRGS2VKcXRlU25xeGx0V0Yz?=
 =?utf-8?B?VTYrdGludVNtd3FUT0pvRi9qNkorR0k5TnV5K2NDWXZBU1hkeThzZEpOMi9I?=
 =?utf-8?B?S3c4RmxlWTB2YlhQRHFaa0FYTng3Q2JlNmc2Ny9iWGJNRTcyWmw3UHdyOE50?=
 =?utf-8?B?SXg4ZzcvdDNwV0loR3F2V0wveHAxZWxEdjY3TzJVRWNLM0hSOFhjNSsyb2NV?=
 =?utf-8?B?L04rMGhla1lmOGw0K3JvRnFnWStXQXNsUTVXSS9DWllLY2dJNWpVd3VnM0R0?=
 =?utf-8?B?b2UvTHQ1dFR3R3lmSVJlb0VuTEFhSWFIVEpHM1hrWlVSazY3Q0srelA1aUhF?=
 =?utf-8?B?Y3h3a05MVDlOd3ZCU3Njck1GMC9JdmFRNThyV0RZMDM3Uzl2M1hpSC85U0p3?=
 =?utf-8?B?R0xLQ2VuOW9HRTdJeExXMlU0MHVJSmJITkR5cWZXbmg2OGhmK0ZwVEFuV3Zl?=
 =?utf-8?B?aVpWYm9qVFlCT2ltb29ETTdWc21pNVgyYTNFOTN6WHRJbU5RK09CY0ltcG9u?=
 =?utf-8?B?NXBSL0dQaGlxMXgwSGVuWXlsR0hLbDBVMnVUQWQ3WlJUU1BjNVIzblNMNWwr?=
 =?utf-8?B?cWZJeGR4UHhsd3ZQV0hDMVQ3WVZPTUx0KzBZN3hkVml0dGR6V2NWN0VkSklo?=
 =?utf-8?B?NVN5M1dWTVRhVEZKWGRNRDQwVFNLOXRKd0hoMHo5OUJEclJjQmh0Qm11UGlW?=
 =?utf-8?B?UGI0SDE0ZFRMTTY4S21YKy9TRGxLUXFnV2IrN0w2cGRnQWNpRlpGeS8rT2E2?=
 =?utf-8?B?M3Z5R1U0Ri90NFJRZmloTjltbUNheUl0cE5aOXhwbFhjNVVDTlp0amdSenBT?=
 =?utf-8?B?WkY5emF0QWtVQjlCTkRneVkvbHBDWURtSW5vbXdpWFFrODQ5aWdjWjFpMWFy?=
 =?utf-8?B?SFMxbHViQmVqdzlXL21ORHczdEdsQmJ3c1Z5RGJ2WHdyT1MrQU92a0g0TmNE?=
 =?utf-8?B?UlAwZ09senJkMjJ3ZHRBTU1WY3JueGVMTFNFRHVaak9vMWZ4Mk9La2Y2N01o?=
 =?utf-8?B?WGtYZjFrWjIwWlNTdUZaR1NBR01UbmNibzBvV2hhdmY0WDRQcFJEUERxbjRk?=
 =?utf-8?B?d3AzNmkrbnRXV1kybWZGUmJTNmxtdllVNWp3eXAvWXVIZTVmT2NrUlpYNjNV?=
 =?utf-8?B?c1NJd2hjQTlYZFJ2ZittU3JBRkFVUE9ZNVRlb1VjeCt5d1kvQThvUnJxU0xo?=
 =?utf-8?B?cm1WZjNrS3UraGdvU000cmdwK0xSS0h4cDFKbTh2cHpseUFrYllKaXQzRnVz?=
 =?utf-8?B?UXlodmVRR2lnbUJLa3lhZjB4WE9tYzA2WXBRN2JXaU1XbUNGbnZDc2VKeTNR?=
 =?utf-8?B?QldZdnFzSEM4VzdTdUFRTjJDYldEekJKZDhicnpKYVZmNFpMSEN4aGFWNHNJ?=
 =?utf-8?B?WXJmRS8zNG00SkhhY2JqRHJtaXJjTnVjZEY3NmNDM2VOQ24raHltb1BLYWNw?=
 =?utf-8?Q?P239iGGrSWyppVNTPpIim+P74?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93ec7af-b3cf-4d38-b777-08dc7b5771af
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9079.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 18:37:48.1574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPrVYTH3bhnvNNdqbVENQzQmeeMiXph31mWw1I1yaFaFbpgVsOe3a0ajNsF0ldZUeo11HuFY9FKNy/GFoUhJ8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9038
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

Hi Jay,

I have added a couple (minor) of comments below.

On 23/05/2024 15:08, Jay Cornwall wrote:
> Fix LDS size interpretation: 512 bytes (>= gfx12) vs 256 (< gfx12).
> 
> Ensure STATE_PRIV.BARRIER_COMPLETE cannot change after reading or
> before writing. Other waves in the threadgroup may cause this field
> to assert if they complete the barrier.
> 
> Do not overwrite EXCP_FLAG_PRIV.{SAVE_CONTEXT,HOST_TRAP} when
> restoring this register. Both of these fields can assert while the
> wavefront is running the trap handler.
> 
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>
> ---
>   .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 1191 +++++++++--------
>   .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    |   55 +-
>   2 files changed, 639 insertions(+), 607 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> index 77ae25b6753c..18e012e04493 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> @@ -75,17 +75,22 @@ var SQ_WAVE_STATUS_ECC_ERR_MASK			= 0x20000
>   var SQ_WAVE_STATUS_TRAP_EN_SHIFT		= 6
>   var SQ_WAVE_IB_STS2_WAVE64_SHIFT		= 11
>   var SQ_WAVE_IB_STS2_WAVE64_SIZE			= 1
> +var SQ_WAVE_LDS_ALLOC_GRANULARITY		= 8
>   var S_STATUS_HWREG				= HW_REG_STATUS
>   var S_STATUS_ALWAYS_CLEAR_MASK			= SQ_WAVE_STATUS_SPI_PRIO_MASK|SQ_WAVE_STATUS_ECC_ERR_MASK
>   var S_STATUS_HALT_MASK				= SQ_WAVE_STATUS_HALT_MASK
>   var S_SAVE_PC_HI_TRAP_ID_MASK			= 0x00FF0000
>   var S_SAVE_PC_HI_HT_MASK			= 0x01000000
>   #else
> +var SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK	= 0x4
> +var SQ_WAVE_STATE_PRIV_SCC_SHIFT		= 9
>   var SQ_WAVE_STATE_PRIV_SYS_PRIO_MASK		= 0xC00
>   var SQ_WAVE_STATE_PRIV_HALT_MASK		= 0x4000
>   var SQ_WAVE_STATE_PRIV_POISON_ERR_MASK		= 0x8000
> +var SQ_WAVE_STATE_PRIV_POISON_ERR_SHIFT		= 15
>   var SQ_WAVE_STATUS_WAVE64_SHIFT			= 29
>   var SQ_WAVE_STATUS_WAVE64_SIZE			= 1
> +var SQ_WAVE_LDS_ALLOC_GRANULARITY		= 9
>   var S_STATUS_HWREG				= HW_REG_WAVE_STATE_PRIV
>   var S_STATUS_ALWAYS_CLEAR_MASK			= SQ_WAVE_STATE_PRIV_SYS_PRIO_MASK|SQ_WAVE_STATE_PRIV_POISON_ERR_MASK
>   var S_STATUS_HALT_MASK				= SQ_WAVE_STATE_PRIV_HALT_MASK
> @@ -149,8 +154,10 @@ var SQ_WAVE_EXCP_FLAG_PRIV_MEM_VIOL_MASK	= 0x10
>   var SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT	= 5
>   var SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_MASK	= 0x20
>   var SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_MASK	= 0x40
> +var SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT	= 6
>   var SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK	= 0x80
>   var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_MASK	= 0x100
> +var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT	= 8
>   var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_END_MASK	= 0x200
>   var SQ_WAVE_EXCP_FLAG_PRIV_TRAP_AFTER_INST_MASK	= 0x800
>   var SQ_WAVE_TRAP_CTRL_ADDR_WATCH_MASK		= 0x80
> @@ -430,7 +437,16 @@ L_EXIT_TRAP:
>   	// Restore SQ_WAVE_STATUS.
>   	s_and_b64	exec, exec, exec					// Restore STATUS.EXECZ, not writable by s_setreg_b32
>   	s_and_b64	vcc, vcc, vcc						// Restore STATUS.VCCZ, not writable by s_setreg_b32
> +
> +#if ASIC_FAMILY < CHIP_GFX12
>   	s_setreg_b32	hwreg(S_STATUS_HWREG), s_save_status
> +#else
> +	// STATE_PRIV.BARRIER_COMPLETE may have changed since we read it.
> +	// Only restore fields which the trap handler changes.
> +	s_lshr_b32	s_save_status, s_save_status, SQ_WAVE_STATE_PRIV_SCC_SHIFT
> +	s_setreg_b32	hwreg(S_STATUS_HWREG, SQ_WAVE_STATE_PRIV_SCC_SHIFT, \
> +		SQ_WAVE_STATE_PRIV_POISON_ERR_SHIFT - SQ_WAVE_STATE_PRIV_SCC_SHIFT + 1), s_save_status
> +#endif
>   
>   	s_rfe_b64	[ttmp0, ttmp1]
>   
> @@ -622,8 +638,15 @@ L_SAVE_HWREG:
>   
>   #if ASIC_FAMILY >= CHIP_GFX12
>   	// Ensure no further changes to barrier or LDS state.
> +	// STATE_PRIV.BARRIER_COMPLETE may change up to this point.
>   	s_barrier_signal	-2
>   	s_barrier_wait	-2
> +
> +	// Re-read final state of BARRIER_COMPLETE field for save.
> +	s_getreg_b32	s_save_tmp, hwreg(S_STATUS_HWREG)
> +	s_and_b32	s_save_tmp, s_save_tmp, SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK
> +	s_andn2_b32	s_save_status, s_save_status, SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK

Even if BARRIER_COMPLETE can be asserted while we are in the trap 
hadler, I do not think it can be cleared.  That being said, it might be 
easier to just replace the bit, making it clearer.

> +	s_or_b32	s_save_status, s_save_status, s_save_tmp
>   #endif
>   
>   	write_hwreg_to_mem(s_save_m0, s_save_buf_rsrc0, s_save_mem_offset)
> @@ -764,8 +787,7 @@ L_SAVE_LDS_NORMAL:
>   
>   	// first wave do LDS save;
>   
> -	s_lshl_b32	s_save_alloc_size, s_save_alloc_size, 6			//LDS size in dwords = lds_size * 64dw
> -	s_lshl_b32	s_save_alloc_size, s_save_alloc_size, 2			//LDS size in bytes
> +	s_lshl_b32	s_save_alloc_size, s_save_alloc_size, SQ_WAVE_LDS_ALLOC_GRANULARITY
>   	s_mov_b32	s_save_buf_rsrc2, s_save_alloc_size			//NUM_RECORDS in bytes
>   
>   	// LDS at offset: size(VGPR)+size(SVGPR)+SIZE(SGPR)+SIZE(HWREG)
> @@ -1050,8 +1072,7 @@ L_RESTORE_LDS_NORMAL:
>   	s_getreg_b32	s_restore_alloc_size, hwreg(HW_REG_LDS_ALLOC,SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT,SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE)
>   	s_and_b32	s_restore_alloc_size, s_restore_alloc_size, 0xFFFFFFFF	//lds_size is zero?
>   	s_cbranch_scc0	L_RESTORE_VGPR						//no lds used? jump to L_RESTORE_VGPR
> -	s_lshl_b32	s_restore_alloc_size, s_restore_alloc_size, 6		//LDS size in dwords = lds_size * 64dw
> -	s_lshl_b32	s_restore_alloc_size, s_restore_alloc_size, 2		//LDS size in bytes
> +	s_lshl_b32	s_restore_alloc_size, s_restore_alloc_size, SQ_WAVE_LDS_ALLOC_GRANULARITY
>   	s_mov_b32	s_restore_buf_rsrc2, s_restore_alloc_size		//NUM_RECORDS in bytes
>   
>   	// LDS at offset: size(VGPR)+size(SVGPR)+SIZE(SGPR)+SIZE(HWREG)
> @@ -1338,9 +1359,6 @@ L_BARRIER_RESTORE_LOOP:
>   	s_branch	L_BARRIER_RESTORE_LOOP
>   
>   L_SKIP_BARRIER_RESTORE:
> -	// Make barrier and LDS state visible to all waves in the group.
> -	s_barrier_signal	-2
> -	s_barrier_wait	-2
>   #endif
>   
>   	s_mov_b32	m0, s_restore_m0
> @@ -1351,7 +1369,17 @@ L_SKIP_BARRIER_RESTORE:
>   	s_setreg_b32	hwreg(HW_REG_SHADER_XNACK_MASK), s_restore_xnack_mask
>   #endif
>   
> +#if ASIC_FAMILY < CHIP_GFX12
>   	s_setreg_b32	hwreg(S_TRAPSTS_HWREG), s_restore_trapsts

Wouldn't other gfx1x architectures have a similar issue when writing 
TRAPSTS here?  That is if TRAPSTS.SAVECTX is set while we are restoring, 
wouldn't we loose it?

And for gfx11, there is TRAPSTS.HOST_TRAP that could have the same issue 
to some degree (not sure if we would loose the host trap completly, or 
re-enter with trap ID + HT bit set in ttmp1).

That is not a regression, nor something this patch claims to address, so 
maybe it can be a seperate patch.

Best,
Lancelot.

> +#else
> +	// EXCP_FLAG_PRIV.SAVE_CONTEXT and HOST_TRAP may have changed.
> +	// Only restore the other fields to avoid clobbering them.
> +	s_setreg_b32	hwreg(S_TRAPSTS_HWREG, 0, SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT), s_restore_trapsts
> +	s_lshr_b32	s_restore_trapsts, s_restore_trapsts, SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
> +	s_setreg_b32	hwreg(S_TRAPSTS_HWREG, SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT, 1), s_restore_trapsts
> +	s_lshr_b32	s_restore_trapsts, s_restore_trapsts, SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT - SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
> +	s_setreg_b32	hwreg(S_TRAPSTS_HWREG, SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT, 32 - SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT), s_restore_trapsts
> +#endif
>   	s_setreg_b32	hwreg(HW_REG_MODE), s_restore_mode
>   
>   	// Restore trap temporaries 4-11, 13 initialized by SPI debug dispatch logic
> @@ -1389,6 +1417,14 @@ L_RETURN_WITHOUT_PRIV:
>   #endif
>   
>   	s_setreg_b32	hwreg(S_STATUS_HWREG), s_restore_status			// SCC is included, which is changed by previous salu
> +
> +#if ASIC_FAMILY >= CHIP_GFX12
> +	// Make barrier and LDS state visible to all waves in the group.
> +	// STATE_PRIV.BARRIER_COMPLETE may change after this point.
> +	s_barrier_signal	-2
> +	s_barrier_wait	-2
> +#endif
> +
>   	s_rfe_b64	s_restore_pc_lo						//Return to the main shader program and resume execution
>   
>   L_END_PGM:
> @@ -1501,11 +1537,6 @@ function write_vgprs_to_mem_with_sqc_w64(vgpr0, n_vgprs, s_rsrc, s_mem_offset)
>   end
>   #endif
>   
> -function get_lds_size_bytes(s_lds_size_byte)
> -	s_getreg_b32	s_lds_size_byte, hwreg(HW_REG_LDS_ALLOC, SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT, SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE)
> -	s_lshl_b32	s_lds_size_byte, s_lds_size_byte, 8			//LDS size in dwords = lds_size * 64 *4Bytes // granularity 64DW
> -end
> -
>   function get_vgpr_size_bytes(s_vgpr_size_byte, s_size)
>   	s_getreg_b32	s_vgpr_size_byte, hwreg(HW_REG_GPR_ALLOC,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE)
>   	s_add_u32	s_vgpr_size_byte, s_vgpr_size_byte, 1
