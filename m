Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B73C27C53
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jun 2024 13:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CE3B10E7C3;
	Fri,  7 Jun 2024 13:09:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kVBIn+PI";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81DE810E7C3
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jun 2024 13:09:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlvXjlNXujGl3CYBsmA7rdmWSlXoN2Y4x5bkcjmrtmuDQJKV24fWAYYJpYEB4h1Gzrh4ei+mehNoW9mJuDFB4Dyi1ZBB3yqLSNcNPrC8icB/DM7BgHNv99EjU7xkUzbylNfOMonJBLr1Y1HPGpIoKIhHIzvAZAlzr/Vl7eAcCpF+1CZERLWCfqtyPefTg4vDMaW/XL97mCdW3XQkmPqY0VCLnTJmCLCYXSCke5ZbZ/B4YyilI0K0kLh9HKJNXa3z5xwjqo90dHsKJ9EcA1QITwrbgONBtNeSXO0CqggkbDwue9gFdNnmGzMWdR98uEi6JYgAWnFS0pHiwOSTyHmYdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8Bcal5OSlwMo5VLmo4HjEUdVGnvtMzWzmyLC+pfk1w=;
 b=IP5LzsAYxV9LcCTPmpQp4pJVd1UrgA6bWmWfyOGz17XXYfkqw9fG5UAo/2kMmSCWi7NcI1HlSVTClOoDxHRrddAnlmPhbJ5WSu+zEg6qXJut/L+pSLJseMuPYaMvsFjRAb7H0Xrrq33FmkuPoFBHvZWbode/E1VO/rX1IQLV2nfva6BgDrMA7oUF8Xytot8y7ETOBYIxSrinTqjzTUfhF6sVjUbcc03+uR1L4lVw1knCrZcvEznVf+bw+X++x8zY0jwUlH7uV6A/QXgDXJDu5ODY/lK+RIkEBaiSehz8X9YYJaHw1UoLsFkKuwszWVM8rJey0uKpLy+3iRLjousBcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8Bcal5OSlwMo5VLmo4HjEUdVGnvtMzWzmyLC+pfk1w=;
 b=kVBIn+PI0qIwt3g5yXA7U3FZioU9ObisvUno1vFD3rdA9irXId62+NXC8nKSd3Zpr4BLnAEq06bo22bwYHUTC+Ss+j/YaZl5Ki8ElH/32NtB/QSRCZ3waBqDDw2YGBCRGhAmFQe6nS08CpKOZMl2VaPi9a/hyXoZBHK8qjGS+kc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 by CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Fri, 7 Jun
 2024 13:09:01 +0000
Received: from CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::8c67:8cec:7c4a:ccaa]) by CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::8c67:8cec:7c4a:ccaa%4]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 13:09:01 +0000
Message-ID: <e5c69305-84fb-463f-a799-f60f9c7ada30@amd.com>
Date: Fri, 7 Jun 2024 14:08:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Extend gfx12 trap handler fix to gfx10/11
To: Jay Cornwall <jay.cornwall@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240605231654.6374-1-jay.cornwall@amd.com>
Content-Language: en-US
From: Lancelot SIX <Lancelot.Six@amd.com>
In-Reply-To: <20240605231654.6374-1-jay.cornwall@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::14) To CH3PR12MB9079.namprd12.prod.outlook.com
 (2603:10b6:610:1a1::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9079:EE_|CY5PR12MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: 462e9172-65b5-4298-2691-08dc86f2ff74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnM4L3lXd3BLTTVyUWlPMVZKaHBzOEdLV0gyRVJRNHhkTnNpcEZQY0VJNUE4?=
 =?utf-8?B?MDlOazIwUFRtQ1VTN0wraEFVQmEvSHJ3bWpSWFk4UHFrN0ZzMzJPTHc5NmhT?=
 =?utf-8?B?TGhFYXN4TGsvU0FBS0xIY2ozU0d0bytMWE5MZGhvbW4yYUE1ZjhVenRoYVdE?=
 =?utf-8?B?VnBWMUdYTW5nWVluRzRHSEpmNlZBTVA5bGtBS3BZWkhua1RDK0VZZG9ZV3FP?=
 =?utf-8?B?Nnh5TklkbXNtaVhtalJremNnbW1qbGVxRWsydnlPNUJmOXdzL1NVT05wM3dB?=
 =?utf-8?B?aUlOUFVqQkZMZmFiWjNXLzJPVzR4THhWalpLckRIb3hObXNMc0xzM1ZiK2Fk?=
 =?utf-8?B?K2VTV04vcGdpRkhscVBTbVdXL2pRTjU2d1cySHJjSTBZd2VKOTdXb2FjL3N5?=
 =?utf-8?B?emFhaGRUVjRXeWFiMjhMQytndndFeGtJZ2tVQ0ZSR0hkRkFvOUh3L25xek11?=
 =?utf-8?B?aWpMdWJxcUl5NUVQQlVXc0g0d2JUZWhtUm5PdHVhQytqS2k0OGc3NWI3clQ5?=
 =?utf-8?B?cDg5d2NoL2JXZG5CbCtNekhBdmNrY2F6RXljL0lQNk41TzBNSHpGQlNhTmoz?=
 =?utf-8?B?cXBhQjZWTitoVjVuRzZUdVZmN2dPVENkcldicVB3WFNNRXJwakJNdSt2NVZv?=
 =?utf-8?B?Z3FHRVdVc0lSRzFNaDlZWjZxMzdIMHpJVHc2eFNuRHNwSlJtaHZneUxwcVhj?=
 =?utf-8?B?UDJtSU5EbWZQQXFnYmtQQTY0YWI3dzRyT0pNMU4yMkhrRnBHWmdOZExTeXJv?=
 =?utf-8?B?dG9jRSsxOEVDN3c0ajFPSzZiaTRuYlVvVzFmd2twN3JZY2YrVmR1Z0R6MGgx?=
 =?utf-8?B?dTg3NGltZmt4cTNjN21qZmxmcTlSRHJhODR5bXo5MUhFQlVsT3Qvc2RiZWl2?=
 =?utf-8?B?NDFDRGtKdmpwM3ZyV2ZLR3krRnBxZCsydzFSaUhCWUcxU1AzUCs2ZE1ZK3dH?=
 =?utf-8?B?OGs2czVlRWJ4Sm5HKzN2VFBuNjhuVzF0R1M5YVhJNlZMd2xpcUJlNWFxTkhi?=
 =?utf-8?B?OXM4K25FZ3hUZDRrRC84dWRYMEZBMzErTE1mVTNvbzRuWXgrSjB6NzI3SjVm?=
 =?utf-8?B?S3JqbXRRak8vM2l3WFJIaG1aNGJLQnJ3cFMrSFg1T2NTS2FKRjR2SDNtRWl2?=
 =?utf-8?B?UmFXK1lPODRoVk1kb3dyczJIY2dkNm11RUtqaXZjZFRId29mUUE2MXhxS3hV?=
 =?utf-8?B?Rm9CNEJxS3d2UkJpT0tBaWFmNVhvKytIc2lwci9mSFd3cUxHTGJaZ1AzOTZp?=
 =?utf-8?B?bElRdlN1ZW1leVpmcjFFcExKTkUvNksvRllZQVl2UjA2Mis1cUExWldaeEVt?=
 =?utf-8?B?OFdCMnhaQkpTdGZkOTA1Yy95MGJDelllTkF2Rm5NMGJUS2drREl4UmJ2YlRR?=
 =?utf-8?B?WUdYeUFZRFFqb2x2QktVS1Bsd056RXo3cWQ0cXlvYUVnR09TMnRCU0JUM3Nr?=
 =?utf-8?B?UllZQ3JRWkJiU09QcVR3RmF3ejQxdEV3cXJKMWgwbXBSWU8yS25GbFE2WWVm?=
 =?utf-8?B?eCtQM21BM0x5RkFSSjBZRGduUGw1R1lDRFZWY3NwcU9zbVozdjd3ajc1QVVa?=
 =?utf-8?B?dS9ONGlvU2VYVDhwNHBQdEc2Q0E0dmdoVSt4YzBpZ2NTLzZaNDVlMXJHeWRN?=
 =?utf-8?B?QVIvSzlZemNxMEc5NnV0RWw0MmMxWUJJUWdoMERTYnZqTnR5QmN3ME9xTVgw?=
 =?utf-8?B?QUo1OHdHWUZtNU1JanVtRnF5Q3VsV09PS2NVZjU4YmFtU0dtRHVmOUZlRVhU?=
 =?utf-8?Q?VyTMGydo/CYR4J3+zd3twDoThYbo75DyZWJ1lcf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9079.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amRRdHdSc3dnM3N5WENPTFR4YXZ3WEpCQ1FhMzd3S1NXZS8zRFdiYXpLZS81?=
 =?utf-8?B?bjJTTlFpZWp4UUpRTEdYVGVEOXk2bUVMNHZoQWhPZFpVeVVDSGRDeTlUUUFL?=
 =?utf-8?B?enJ0UmxGNFZuNnZTRWJUTUtUVE9iNFo4RVk4TStwOG5DQzVqNUZWd0hTbkx0?=
 =?utf-8?B?UkZXKzVORWlnTkYyU2lEY0xjUlcwM0U4M3hZZUR4OWhpMVR0cGlXZjkzcFNy?=
 =?utf-8?B?WmZUdnp4WVdPaWZwdXdnK1NSRHZIM1ZYY05DR053VkVwUFdQSTVpNEJIUWND?=
 =?utf-8?B?UXY4bHJQUkhXL21tSEY1TUtSQWhlYmVVTjYvR3F5UDErWFc3TjJlU1dEUDlu?=
 =?utf-8?B?NzJOc3FnL0xkR0xBUFBtNVVQQ1BxeUxEV1BoK0pzaHJhSjM2VEFTdEJLQzlr?=
 =?utf-8?B?eElOTDFGTFpTNjNzNllWSnFPOEFob1luT2NZSVREUnRFQ2RJcmRPenEyaVEz?=
 =?utf-8?B?NnFqYXo5dkE2Y1luWjZjM1BOL0duWkkvRU1wRG1ucE80cVNZc2Fhem1JYXlo?=
 =?utf-8?B?N003bWpHbHQ4OVI2Vk9YQ0RCTFJ4Wk0rLzdjRW9UMzlIdGNDYU8vWE9kVWg3?=
 =?utf-8?B?WkdGdEkwMUNXWWRDL2ZwbFExNzhMVHkxcUZ2b0xLZmhaSG9tdXhzN2o1dGVw?=
 =?utf-8?B?bDZZRjRFVEJKMFlwZTB0MXVtR0dXbDJ3NFRJeE1xeW40c2dpQUdmdTd2cmVY?=
 =?utf-8?B?dUtpd3lHY1h4bXE2T3d4K1FQc3d1NWJ1NzN4SDhUWU5nVmJ4ZmMyM2hLUmpa?=
 =?utf-8?B?TUlTVmpsTFExa2tyOFRVVXIwdFZTd1U1U3BWdkZiT1pBZzNmSDB4WU80ZXRM?=
 =?utf-8?B?RzRJaDB6aHN0WDA3c2hlL1VKWERpYmVSV0tiVzgyenk1WW9USHc4aU91bWNJ?=
 =?utf-8?B?U0Z5Ynp3VDdmS1pUSkRJbE5nMW5Xb2pNVDZUM3lrbTgzU2hlRTFRK0RmaldN?=
 =?utf-8?B?NjloanZpR3dyS01YS28xd2pVR2JycDdoOE9pUUd3eUNYMjRxeGNpY0x4aEh4?=
 =?utf-8?B?UlVwRjJHR1UvUDRUYXh5cFpaVWIvc1BIbGpXWGpZSHhhS0Q3UjVEYzkxVkhI?=
 =?utf-8?B?Tzg2VUhkNGwrVkdUeEQ0YzIzRUl5bjQrdFNqemw2d2s2Ryt6aU9zR0xobFFr?=
 =?utf-8?B?YlNvOGZQR2I2YjZRaEhTL0FMdk1DWldsMG5vbFJ3ZWtmS01uNkhQN3lua0tT?=
 =?utf-8?B?VkxOQmw2SDdlTEZkU2ZjQytrdmxTcGxUR1BsWUF0VTM4aTcvY1grSUZhbFBX?=
 =?utf-8?B?M0xRYk96N25jS0M0SVJUN1NGZlh4c0RjM29ZeUN5Y1pEa0NScThFRzVXbVNh?=
 =?utf-8?B?V1lVZEhxVlFVYmR6dmlXbUJOZW9raTJQTDhlSEpnTUM1YlZOM2kvSCttYmZ3?=
 =?utf-8?B?ZW5QOFZGY2ZFdHI3MHk4MEUvVGlMMlJqbHJJTFYySnhKL29KY05oOFZIVEJE?=
 =?utf-8?B?Zkt4cUNFdmZibFNHMit0cG5GRFFuYThveWl4MWVadDlHR1ZDTWhnYUx3Y3Nh?=
 =?utf-8?B?VEc3RHc4RXd0czBwTWlOdjhqeWJRcFFWZU52L2NWWnptWEt4Ryt6eVNVUmU4?=
 =?utf-8?B?cC8wM1dJNzdWc3VVdFUxbTJKOVlab2lQU2ZkU09mZzUxQVI3aUwzTmQwTTRF?=
 =?utf-8?B?SVB1Sk12V1VUai9aVUVpUVZId0F6S1B0UC9RaGorWGxFVFlHdmVydDM1T0N3?=
 =?utf-8?B?R3JhY055b2l3ZGtYRXYvUnY5aXhteGV6NzZtRjNSVXJHanBrUVd3VDJaRjJn?=
 =?utf-8?B?aEZybnJhU2w3OXBBbHNrcGFrazFvdVo0WWxjNDJsOUJyaXdPemxOMkx1OEVU?=
 =?utf-8?B?RGFWaE51YVpra2VmaWcyZUVxd0JiNmlCWmZSNGdYb1NwTVVsU2tXa3JoZGhB?=
 =?utf-8?B?Q1FMVnJlc0xsK0dZRWNjM0pGZnErL0tMSjVVT3pMeEdSWkJPbjE5SjdXVmxJ?=
 =?utf-8?B?TVU3anNhY1g3Rzg3Z2Vzb0hxbk5NSEZHeDBVUG1VNVp5Q0pWY2Z4UGE3RmZi?=
 =?utf-8?B?ajNZdzlVSVcxRzJvUktXSi80QTVZZGo5TXkzekM3TWFKd0NTcjhOM1ZTZFpX?=
 =?utf-8?B?RUlVR25yV2xTdFBXV3lYbjl6SmhzZHFmR3VvQitVNWJrV1JiRmZIMHZFRGdt?=
 =?utf-8?Q?ZbLJ0r5K5DVzgO7a8nlCgQNMb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 462e9172-65b5-4298-2691-08dc86f2ff74
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9079.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 13:09:00.8814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZNTz6s6X0l9Q/gIdWezNnV+fZQC2U1uK+Bl/s3AYa6/HV69NgJLlQCF8Od2j2vdN6TBKjdpTiWzbNsi1FI1AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6526
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



On 06/06/2024 00:16, Jay Cornwall wrote:
> In commit 6d1878882d2d
> ("drm/amdkfd: gfx12 context save/restore trap handler fixes") the
> following fix was introduced but incorrectly restricted to gfx12.
> The same issue and a corresponding fix apply to gfx10 and gfx11.
> 
> Do not overwrite TRAPSTS.{SAVECTX,HOST_TRAP} when restoring this
> register. Both of these fields can assert while the wavefront is
> running the trap handler.
> 
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>

Hi Jay,

Thanks, that looks good to me (tested on gfx10.3, 11 and 12).  For 
gfx11+ there might be a risk of overriding perf_snapshot, but that seems 
fine as this is not used, and such sample from cwsr restore would mostly 
be meaningless anyway.

Reviewed-by: Lancelot Six <lancelot.six@amd.com>

Best,
Lancelot.

> ---
>   .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 16 +++++---
>   .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    | 38 ++++++++++++++-----
>   2 files changed, 38 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> index 665122d1bbbd..02f7ba8c93cd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> @@ -1136,7 +1136,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
>   	0x705d0000, 0x807c817c,
>   	0x8070ff70, 0x00000080,
>   	0xbf0a7b7c, 0xbf85fff8,
> -	0xbf82013d, 0xbef4037e,
> +	0xbf82013f, 0xbef4037e,
>   	0x8775ff7f, 0x0000ffff,
>   	0x8875ff75, 0x00040000,
>   	0xbef60380, 0xbef703ff,
> @@ -1275,7 +1275,8 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
>   	0x80788478, 0xbf8c0000,
>   	0xb9eef815, 0xbefc036f,
>   	0xbefe0370, 0xbeff0371,
> -	0xb9f9f816, 0xb9fbf803,
> +	0xb9f9f816, 0xb9fb4803,
> +	0x907b8b7b, 0xb9fba2c3,
>   	0xb9f3f801, 0xb96e3a05,
>   	0x806e816e, 0xbf0d9972,
>   	0xbf850002, 0x8f6e896e,
> @@ -2544,7 +2545,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
>   	0xe0704000, 0x705d0000,
>   	0x807c817c, 0x8070ff70,
>   	0x00000080, 0xbf0a7b7c,
> -	0xbf85fff8, 0xbf820134,
> +	0xbf85fff8, 0xbf820136,
>   	0xbef4037e, 0x8775ff7f,
>   	0x0000ffff, 0x8875ff75,
>   	0x00040000, 0xbef60380,
> @@ -2683,7 +2684,8 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
>   	0xf0000000, 0x80788478,
>   	0xbf8c0000, 0xb9eef815,
>   	0xbefc036f, 0xbefe0370,
> -	0xbeff0371, 0xb9fbf803,
> +	0xbeff0371, 0xb9fb4803,
> +	0x907b8b7b, 0xb9fba2c3,
>   	0xb9f3f801, 0xb96e3a05,
>   	0x806e816e, 0xbf0d9972,
>   	0xbf850002, 0x8f6e896e,
> @@ -2981,7 +2983,7 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
>   	0x701d0000, 0x807d817d,
>   	0x8070ff70, 0x00000080,
>   	0xbf0a7b7d, 0xbfa2fff8,
> -	0xbfa0013f, 0xbef4007e,
> +	0xbfa00143, 0xbef4007e,
>   	0x8b75ff7f, 0x0000ffff,
>   	0x8c75ff75, 0x00040000,
>   	0xbef60080, 0xbef700ff,
> @@ -3123,7 +3125,9 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
>   	0x80788478, 0xbf890000,
>   	0xb96ef815, 0xbefd006f,
>   	0xbefe0070, 0xbeff0071,
> -	0xb97bf803, 0xb973f801,
> +	0xb97b4803, 0x857b8b7b,
> +	0xb97b22c3, 0x857b867b,
> +	0xb97b7443, 0xb973f801,
>   	0xb8ee3b05, 0x806e816e,
>   	0xbf0d9972, 0xbfa20002,
>   	0x846e896e, 0xbfa00001,
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> index ac3702b8e3c4..44772eec9ef4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> @@ -119,9 +119,12 @@ var SQ_WAVE_TRAPSTS_ADDR_WATCH_SHIFT		= 7
>   var SQ_WAVE_TRAPSTS_MEM_VIOL_MASK		= 0x100
>   var SQ_WAVE_TRAPSTS_MEM_VIOL_SHIFT		= 8
>   var SQ_WAVE_TRAPSTS_ILLEGAL_INST_MASK		= 0x800
> +var SQ_WAVE_TRAPSTS_ILLEGAL_INST_SHIFT		= 11
>   var SQ_WAVE_TRAPSTS_EXCP_HI_MASK		= 0x7000
>   #if ASIC_FAMILY >= CHIP_PLUM_BONITO
> +var SQ_WAVE_TRAPSTS_HOST_TRAP_SHIFT		= 16
>   var SQ_WAVE_TRAPSTS_WAVE_START_MASK		= 0x20000
> +var SQ_WAVE_TRAPSTS_WAVE_START_SHIFT		= 17
>   var SQ_WAVE_TRAPSTS_WAVE_END_MASK		= 0x40000
>   var SQ_WAVE_TRAPSTS_TRAP_AFTER_INST_MASK	= 0x100000
>   #endif
> @@ -137,14 +140,23 @@ var SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK	= 0x003F8000
>   
>   var SQ_WAVE_MODE_DEBUG_EN_MASK			= 0x800
>   
> +var S_TRAPSTS_RESTORE_PART_1_SIZE		= SQ_WAVE_TRAPSTS_SAVECTX_SHIFT
> +var S_TRAPSTS_RESTORE_PART_2_SHIFT		= SQ_WAVE_TRAPSTS_ILLEGAL_INST_SHIFT
> +
>   #if ASIC_FAMILY < CHIP_PLUM_BONITO
>   var S_TRAPSTS_NON_MASKABLE_EXCP_MASK		= SQ_WAVE_TRAPSTS_MEM_VIOL_MASK|SQ_WAVE_TRAPSTS_ILLEGAL_INST_MASK
> +var S_TRAPSTS_RESTORE_PART_2_SIZE		= 32 - S_TRAPSTS_RESTORE_PART_2_SHIFT
> +var S_TRAPSTS_RESTORE_PART_3_SHIFT		= 0
> +var S_TRAPSTS_RESTORE_PART_3_SIZE		= 0
>   #else
>   var S_TRAPSTS_NON_MASKABLE_EXCP_MASK		= SQ_WAVE_TRAPSTS_MEM_VIOL_MASK		|\
>   						  SQ_WAVE_TRAPSTS_ILLEGAL_INST_MASK	|\
>   						  SQ_WAVE_TRAPSTS_WAVE_START_MASK	|\
>   						  SQ_WAVE_TRAPSTS_WAVE_END_MASK		|\
>   						  SQ_WAVE_TRAPSTS_TRAP_AFTER_INST_MASK
> +var S_TRAPSTS_RESTORE_PART_2_SIZE		= SQ_WAVE_TRAPSTS_HOST_TRAP_SHIFT - SQ_WAVE_TRAPSTS_ILLEGAL_INST_SHIFT
> +var S_TRAPSTS_RESTORE_PART_3_SHIFT		= SQ_WAVE_TRAPSTS_WAVE_START_SHIFT
> +var S_TRAPSTS_RESTORE_PART_3_SIZE		= 32 - S_TRAPSTS_RESTORE_PART_3_SHIFT
>   #endif
>   var S_TRAPSTS_HWREG				= HW_REG_TRAPSTS
>   var S_TRAPSTS_SAVE_CONTEXT_MASK			= SQ_WAVE_TRAPSTS_SAVECTX_MASK
> @@ -157,6 +169,7 @@ var SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_MASK	= 0x20
>   var SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_MASK	= 0x40
>   var SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT	= 6
>   var SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK	= 0x80
> +var SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_SHIFT	= 7
>   var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_MASK	= 0x100
>   var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT	= 8
>   var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_END_MASK	= 0x200
> @@ -173,6 +186,11 @@ var S_TRAPSTS_NON_MASKABLE_EXCP_MASK		= SQ_WAVE_EXCP_FLAG_PRIV_MEM_VIOL_MASK		|\
>   						  SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_MASK	|\
>   						  SQ_WAVE_EXCP_FLAG_PRIV_WAVE_END_MASK		|\
>   						  SQ_WAVE_EXCP_FLAG_PRIV_TRAP_AFTER_INST_MASK
> +var S_TRAPSTS_RESTORE_PART_1_SIZE		= SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT
> +var S_TRAPSTS_RESTORE_PART_2_SHIFT		= SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
> +var S_TRAPSTS_RESTORE_PART_2_SIZE		= SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_SHIFT - SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
> +var S_TRAPSTS_RESTORE_PART_3_SHIFT		= SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT
> +var S_TRAPSTS_RESTORE_PART_3_SIZE		= 32 - S_TRAPSTS_RESTORE_PART_3_SHIFT
>   var BARRIER_STATE_SIGNAL_OFFSET			= 16
>   var BARRIER_STATE_VALID_OFFSET			= 0
>   #endif
> @@ -1386,17 +1404,17 @@ L_SKIP_BARRIER_RESTORE:
>   	s_setreg_b32	hwreg(HW_REG_SHADER_XNACK_MASK), s_restore_xnack_mask
>   #endif
>   
> -#if ASIC_FAMILY < CHIP_GFX12
> -	s_setreg_b32	hwreg(S_TRAPSTS_HWREG), s_restore_trapsts
> -#else
> -	// EXCP_FLAG_PRIV.SAVE_CONTEXT and HOST_TRAP may have changed.
> +	// {TRAPSTS/EXCP_FLAG_PRIV}.SAVE_CONTEXT and HOST_TRAP may have changed.
>   	// Only restore the other fields to avoid clobbering them.
> -	s_setreg_b32	hwreg(S_TRAPSTS_HWREG, 0, SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT), s_restore_trapsts
> -	s_lshr_b32	s_restore_trapsts, s_restore_trapsts, SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
> -	s_setreg_b32	hwreg(S_TRAPSTS_HWREG, SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT, 1), s_restore_trapsts
> -	s_lshr_b32	s_restore_trapsts, s_restore_trapsts, SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT - SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
> -	s_setreg_b32	hwreg(S_TRAPSTS_HWREG, SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT, 32 - SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT), s_restore_trapsts
> -#endif
> +	s_setreg_b32	hwreg(S_TRAPSTS_HWREG, 0, S_TRAPSTS_RESTORE_PART_1_SIZE), s_restore_trapsts
> +	s_lshr_b32	s_restore_trapsts, s_restore_trapsts, S_TRAPSTS_RESTORE_PART_2_SHIFT
> +	s_setreg_b32	hwreg(S_TRAPSTS_HWREG, S_TRAPSTS_RESTORE_PART_2_SHIFT, S_TRAPSTS_RESTORE_PART_2_SIZE), s_restore_trapsts
> +
> +if S_TRAPSTS_RESTORE_PART_3_SIZE > 0
> +	s_lshr_b32	s_restore_trapsts, s_restore_trapsts, S_TRAPSTS_RESTORE_PART_3_SHIFT - S_TRAPSTS_RESTORE_PART_2_SHIFT
> +	s_setreg_b32	hwreg(S_TRAPSTS_HWREG, S_TRAPSTS_RESTORE_PART_3_SHIFT, S_TRAPSTS_RESTORE_PART_3_SIZE), s_restore_trapsts
> +end
> +
>   	s_setreg_b32	hwreg(HW_REG_MODE), s_restore_mode
>   
>   	// Restore trap temporaries 4-11, 13 initialized by SPI debug dispatch logic
