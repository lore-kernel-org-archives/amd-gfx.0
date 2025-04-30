Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9E7C369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 21:44:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E515E10E124;
	Wed, 30 Apr 2025 21:44:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LPWYoElM";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A3D010E124
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 21:44:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjiAdmlfHB0B0xAu1VQfM+3wUOgYZYsBT3xo/RVd1Jj704LeLwNGbzjjp/M9i7TynJ72+xfUEGaCquJ0x+/Jl7t/ovTkhIQcqaOtcHILm7qhYNAaCqo+DWnan1BE2jFY0bysfd7t9t0xs0XMJmpLV87U003H7bd0aiTnKSo2YI33wEDvI0PfNeHyYzzpqgTysjKHTCBae82yUGKP0RIZeuxJl5sBBwFsNw0F7c40Y2t9GM3Pm5iKFSH5zIyWfyQMJ01bcwDWCaF+ytriDjGv97MA7ArEDBYlQLaVuirqD6AhvJNL9b05Y6ae/y2qSiLsXmZwnhdYDIiX6HJQjmFnkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85hvn/A230rr5l/8+a5Si5SFWhAVgMcnDSbwulgnIs0=;
 b=rCUVYqLjYyrZZHB9IvM1O0RlYCITaTgnijpmYzTTTTIxVh3rL0D3iS/lZAKCfGN3c0iRyz0e6yFApW61NOb2NR3wVTw/IUAoDZwzFxlJP4zSKnkhD1z5MclFos6WYrKGSpgucIPuGMj3ktKhmDF9MKfsSM+0I5vLSYoxvznivTmwtA1a4Zyfnw7oMx/m3WYT2xDgcOHM18qQ3vBAc2O08lSsZieaHmwAe0yKr+YXnICGC2oCdK0oK9jxLTuACpZsF6Z/2U3QkVDz1D+zYys8U9nlnX1qpgFjqD4UAkPMpnQIYB+PdPl3iKXNH+/dab94Fwpl+9sCBDlCYlckx42NfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85hvn/A230rr5l/8+a5Si5SFWhAVgMcnDSbwulgnIs0=;
 b=LPWYoElMymtFjRBItcLvpuc/fWdykogY6xNqduL8VxR+ZaeVg082dkz6V4RWxNSa4djTKo1PiKK7MNiFsJovv/0Og5BtKCPjz2N5X3g36ohtbbbS+VGEu6BjOi5dPEXDLUaTg8xrofk5IiTXna1itpDRxB/O3Uo+cu0MyKs33GU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by CH1PPFC8B3B7859.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::622) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Wed, 30 Apr
 2025 21:44:46 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%5]) with mapi id 15.20.8678.033; Wed, 30 Apr 2025
 21:44:45 +0000
Message-ID: <2150d713-d9bf-400e-b51b-aee835431991@amd.com>
Date: Thu, 1 May 2025 03:14:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] drm/amdgpu: amdgpu_vram_mgr_new(): Clamp lpfn to
 total vram
To: Alex Deucher <alexdeucher@gmail.com>,
 John Olender <john.olender@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250429112429.5646-1-john.olender@gmail.com>
 <20250429112429.5646-2-john.olender@gmail.com>
 <CADnq5_OMd-oHqPV9cC-GQGjf4OnN7EdvL3T9gopC-rEPMWs0vA@mail.gmail.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <CADnq5_OMd-oHqPV9cC-GQGjf4OnN7EdvL3T9gopC-rEPMWs0vA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::31) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|CH1PPFC8B3B7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 769bf272-1019-4289-1532-08dd883038ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUZKNk43RU91QVFkdmZpOXdaRDNIYTFDS2NWaXhMVlptWC9VMmdSVmN5WCtx?=
 =?utf-8?B?SUFUajBlUVdSdm9HQnkvVXo5ck8wd0pMZHE1NE84YlN6OWpMWmhNS0tERFdM?=
 =?utf-8?B?R0tWUU1OTU9xTGlmcnV2MWUxS09PbU5YeFBUc3pKZWo5SWl0UGJaNmhGOWVX?=
 =?utf-8?B?NnRiekZSalNkWHp1NTZOc2sxdjBhOTJhTU5YN0gyQlFaOGpiUlQvU1dVcTlJ?=
 =?utf-8?B?RDQzZHNYOUZtR1RvRHJPcWQ4WUxQQzRsdUNsUFM5YVdkTlp2VVJuNXY0VURR?=
 =?utf-8?B?WnJEY0g1aGZlcWt4WWJVQ1VlT1ErSU9nVnorLzNaKzN0a0oyZWtBTmppK0xo?=
 =?utf-8?B?dU0rMzVmOW9EOGdTSlppSHBSMDBvaWJ2RXZnOExxV0JMUHdVS09yZW9rdkpY?=
 =?utf-8?B?N2M0L3RuK3YrOFduRklCS0JJdEczbDh0ZGxyRjFJMlNkelpEajRQenNNaDBM?=
 =?utf-8?B?b0tkc2h1OEl4eURXQ1UvMEN4aTJuUXZVMmhmVmZZWmJ6dHJEV1BLWmhwVDVR?=
 =?utf-8?B?OFlSYnpwc21PQjlobUlKN3VSMnlkTzVNRndOTHIrK0xsLzdoVWZtZTk2WjAw?=
 =?utf-8?B?V1c1QVhFRFpoelRMSEhuSjhKZ3gwRnk3SWFZazdHOFFPbGsvRjVFc2hFem9N?=
 =?utf-8?B?bXNhK0s2Yks5VVBrRXlTUm5Ia0plVGoxTEo0NHphWktCQzN4bE5KWS9tQkhw?=
 =?utf-8?B?eFBDc3hiRE56c2FRL084bDNaUFA3N0hxMzFnS3ZJWmRUL21nbFFGTUdYdlNP?=
 =?utf-8?B?UFZCVFpsbWRTb29GVXZ3SnE0RktORmw1UmtXL2x4VFVPMTN3NlJhc0Jmd2tj?=
 =?utf-8?B?aWVlNFNjbGVjUDZyY0t6NVlyUHNBOVdJblFzVTFrNHdudzhyaXpvYTZFenl3?=
 =?utf-8?B?NGtKcUVNdXVEVWt2MnNwTVExSGpqWURHY2hsMnkrMFZTOEs2L01KNVptenU1?=
 =?utf-8?B?blhjeEMrZnY2MWVVRkVtZENYbG5xaGpmQjBYZUUycy9lZitkTmlXZnozUXVI?=
 =?utf-8?B?OCtRTEZZUmtMK1U2MkJhYVRnV2RYZWEvd09MSFY1eFRndlF4aUdseGV0MGtv?=
 =?utf-8?B?TlpQQTJlZklLQUdVbFY3a0VVUkk3UTZ6c3hxZTAvRWJEdEovTVJVOGpRRlV4?=
 =?utf-8?B?c0s5Sy9sNXBsQkZqMmdyRjhpMnU0Rkh0NkQ1ZjI3WDBNQnlHUjFtTG00QVRJ?=
 =?utf-8?B?S2NtanhCZjBkb00vbkNsNzljY1JVNnRMa1NudVgvc3crSTRjNTVpN2FJc0ZC?=
 =?utf-8?B?NWZqMi9Kb1kzb0dYdDdVZXNSWXMxakZrQlpOdFQ0UWlROFROazl0bnh4dVlk?=
 =?utf-8?B?aHVkWHgxOEt1cFBRZkF2NkhUTUFZRFh0RVJ6NHZEYUEyc0Q2cEFZNjlNU0xp?=
 =?utf-8?B?RVRCVXFTTUhDQ3BQck1qUWJudExrMXRaQThEVlB4Zk1KcENUdXMzYldqazJK?=
 =?utf-8?B?SThseVJMV1VJWXNOeFFyVjFRNjdycnl4QXBUY1NyR0pMZTFLN1JMR2txTEF0?=
 =?utf-8?B?a1IxeHZZeEkyZlFyYlNXQjEwemtZZEt5OWt0d2grK2RMSDZQaHR3ZDBhOWVQ?=
 =?utf-8?B?K3BsQUhGYk1ENExRZVBEL0l6UzQ5UUxzcDNTUUQyUUlPalozeCt0RGNveHFX?=
 =?utf-8?B?RTRmNHpZbmVBNjdNc0JXZkhjbFZvRHRyLzdFZjI4WllmOU1jd3hTUmwrNmN6?=
 =?utf-8?B?YU4vZWRxUjBnaXBiTUVReVNOQUhvWjdnT1YwcFovcWc0L25iSyszWVdrdXE0?=
 =?utf-8?B?b3E4TzhVYVZaK09HQjMyNlBub2JoVGxRWmlWanpzSzRQVlQwajk3cmt3Yldr?=
 =?utf-8?Q?RaWv/bL/Q//ZR1DY7CGYWSRUgtsVrhv9Va/N8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aERTZkdwcDBzaWZYSXo2aUpYVTUrK2tSZGZDanRTOXAyUnNCWktWVmxVdWFU?=
 =?utf-8?B?Nm9JM0RzTDhSVDZqQVRSSUwrWURCai9LcmFBNURBM3IrN3RhZFpWTW9vRTRn?=
 =?utf-8?B?cVpWV09RNVZBTklkbDY3bi9BYThUQXAvZHpoWkZ3VERzeVJySHV2cnlHVnhE?=
 =?utf-8?B?QlBaeFpyaXpIc3N1TjV0dGY5enpjK1JRUUNqQ3FlUzZ0cmFST2xUMTA4WFNs?=
 =?utf-8?B?dmdneVFEaFByK0NxOWtYVTFzRkxPYXZQMlVaU1NUYVduMlYzRm4vR0ZsSW1C?=
 =?utf-8?B?a0JxT2p3RnErcHY3ZEFkMFQ1ejQwMmNSdGhnWUM1WTJTdlJXS0RuVkpOYmhO?=
 =?utf-8?B?aHpmd2pJN2VpdVU5K3hYVjlzdWZvWDVpS2U3aXRaUGZaRTlpNGdpRlo5TUJ6?=
 =?utf-8?B?aDEyNW51M0U0ZnNWZDhJcHFRQzdvUkVDVUNyK1ZnSTIzQjcvWFNiR1hINFFu?=
 =?utf-8?B?bHZaUjQwalVHNjlCczVTenlROGVLcGplcUx5UWtreVJCN3FxMTZxMnNVNzMx?=
 =?utf-8?B?YWVNZUxFUnVYMnlEZ29GNVpKTU1KSHFFd3pDVndZMStXQmNYSkdvTkNPSm1W?=
 =?utf-8?B?TkE1eEJ6ZlZRcHp2QVh4MVBoempVV2k3Q0NncFA3UVdkU2ZxSlNYZFB4RWVW?=
 =?utf-8?B?SnpXVnlHK0F2UkJUTGtZNGluTUplUUlVRUdmWXM2Qm1kNGJYT2hzVWdNcFoy?=
 =?utf-8?B?Ni9sam5EaDZxbjZGL20ySGJkV0ZsRkt4SUpPWS96YkRNYXhVdTNsTUJadnlH?=
 =?utf-8?B?aDJIVXdvWXo1Y0M4SVJzVVRDRDR0ZmRqbmU2S2gybVllRG5xTzc1VWduUjBU?=
 =?utf-8?B?bmVMdGVGZUZmZk1lWDZWV3drZVU3QVpISzlxM24wVXVHMWFwamNiTU5GWVJ5?=
 =?utf-8?B?Q0xkdVhTdWlDMkpuUzk1U3BHdkpXVTU1akdRSGFjV1ZaZ1ExbmNkaEdmSWxE?=
 =?utf-8?B?NVhiWFlGNVBOM01qMXh3cVIvcmk1SDMyQ0hUNkdtTWxZcVgyWUM1T1JTSU5k?=
 =?utf-8?B?bnFNTzV0RWJLelEwYUw1SXJFUTVENUFWMHkyZXZxSlFWZk92TlBCejcycjM4?=
 =?utf-8?B?Tmk2Q1puWXhDSXZKblkrYmdOdHJqcStXM2oybUR2VjNKZnd5M2Vua2FEdTRq?=
 =?utf-8?B?Q1ZjbUFHNVA4cFJqZWpMY1A2aFFyWWZ6V1dJRldhdEdkaTRFOHhaS1VEcndn?=
 =?utf-8?B?ZG9Ea205RUYvMmxpWGVzZ3B5SEVXU3psRDc4T3ZuRTlsUjgzWkdTNXlvTDR3?=
 =?utf-8?B?dzFvbVhrMXVLbVBJZytrQVZIWWkwVDRMYXBSL0hlZlN0aWRaMFJIeHBBTWFO?=
 =?utf-8?B?QnMwT1VoMWEyZU1ieTZTTGVHUzFoc0FKTGo3S1gxQzJBL09ScFQyenF4SUJF?=
 =?utf-8?B?WjN5REJ1emJRakY3eGtlaHZCQnJsazJlYjRWUXVza2FiZ0NLK1B5bVJvR3I4?=
 =?utf-8?B?OXNFeFBCVmlQRkZWL1ZIbFFnK2h5ZEkyVVBZRG81RkRlMHdadk1MYlNRR1Vo?=
 =?utf-8?B?N09ONjFsTU80c1hzRFpNbUV5S2tQYjVIcW5GOHMxeTJXWUlSdUdRQmoyNXhC?=
 =?utf-8?B?TkViVkpSemtYODAyc0IyaEZ4STZaNFIyS3pBWk5LUytFQmFDNVp6U2ZCV3lI?=
 =?utf-8?B?dkxXQjhtOTRtOUFoL09aNG51MFVxKzE3VWNGNndUSlBPUkpEYkFIMmQ0eHpT?=
 =?utf-8?B?blE0KzdUWWgrSThOUWNhODNtT2Q2TFJ6UTNaaXpXVWo0aW5IdTRENXNRMVZX?=
 =?utf-8?B?a21JVW81aFV5endKelArSUlaKytwbnlxbzVLZW8vNW9oTHJwN1NvNU83b01Y?=
 =?utf-8?B?UnVjb0N5R2hhNjVLOG5qSTNHSUQ1TnFVT2FxRVIxQXk3ejdicjF1V2NyMTND?=
 =?utf-8?B?dVhpWWxYTmZicjl5V3c3ZkVmMGwrUWdBMms5RHoyaFhPcXFuakI5dUZyTXYz?=
 =?utf-8?B?czBqcjNuekdKTk9yTzlxa0FwU050RDRPaXlkZEFSUU4yRDhUVDk4R0NkRTZh?=
 =?utf-8?B?RmhMVENqOEt2VWt6S1lqV1R0U0Q3bjgyc2V0OHErMURlcTBTNzJmYmpwU21w?=
 =?utf-8?B?WHJOZC96b0tFL2dwZlIxUm9POUJzZ2dFRDdHR0xxeStyOHlULzVGMG9Ea1dn?=
 =?utf-8?Q?8EEeHHVsiTpELzTQ6YgRPsFZ9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 769bf272-1019-4289-1532-08dd883038ef
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 21:44:45.5513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jMVXWpxg9CGFh6tYphySpXN+epYDVhbm6IeZhWR6LBVr2URIAn/igN3l1TNObmGGF4YtJ8iTay/WH8ZzOyHgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC8B3B7859
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



On 5/1/2025 2:50 AM, Alex Deucher wrote:
> + Christian
>
> On Tue, Apr 29, 2025 at 7:24 AM John Olender <john.olender@gmail.com> wrote:
>> The drm_mm allocator tolerated being passed end > mm->size, but the
>> drm_buddy allocator does not.
>>
>> Restore the pre-buddy-allocator behavior of allowing such placements.
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3448
>> Signed-off-by: John Olender <john.olender@gmail.com>
> This looks correct to me.
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
I was thinking that we should return an error when lpfn > man->size.

Regards,
Arun.
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> index 2d7f82e98df9..abdc52b0895a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> @@ -463,7 +463,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>>          int r;
>>
>>          lpfn = (u64)place->lpfn << PAGE_SHIFT;
>> -       if (!lpfn)
>> +       if (!lpfn || lpfn > man->size)
>>                  lpfn = man->size;
>>
>>          fpfn = (u64)place->fpfn << PAGE_SHIFT;
>> --
>> 2.47.2
>>

