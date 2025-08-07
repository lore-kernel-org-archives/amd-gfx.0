Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5D7C87FD2
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 07:33:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E134F10E7F1;
	Thu,  7 Aug 2025 07:33:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lUvAyv6B";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D2CE10E7F1
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 07:33:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEJBqq2ZYLIWAo8WE7QOp0b9azqdK5CiZxR65wlJjW/i4BflTxZBUZX0iWPYf6lSiPBXox7/V+OvI1jm6AkRf5SD6shPuXCTnGbT41ihzhlVd2boFQaUn0tXVdPMDzYq98Jnn8k/YCB0lZl+XVU7xRYfmp2C3x50zia96OBWfAJHEb1ayhqRtQTdMo99in5a6HJK6oVmUm+I1iykpqM17hKQ/SBf3k7UWXMo/XOephvwpNPHHE7hhkNEhEz8TTWFfLNRlWjN0E4yBYp2ID8f1tIGnRSpmyQJTc/uQSBKWju97b2hzNVEgt4cHIFLPFRgin5Ou5sIbgKP1NcV1sKaAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ti2iz03gff4eAzG9KX+TbCo+8t8Roleyjbh1mqh6hMM=;
 b=uM0aWOYuARxkAS67nM2W2uhyr8Gaxvv8wQj3Lp6KUaiEPKXE1DgbfR5jyIbd5SliXqHBfWEjC/EG1HxdFLyc4CXfLqV7g2ItuvVYtDr+jfDSNRY2aNWmcnQGQf3ggjPPzYLDusoUjQJ7l3S1uG6t8qtoDNnvwFKTBYjwcBEblKGaKK/+aUFCtPCJp9vqzGL0GvS/t/QnasQ98An+kngUfg94dETdSO2Ru0OWyx2gbg+xKJbzR6ejpnUHqf3NRRlPkvOjwybfjur7H0/0X12SRk/vVl6W7rg1fLJ1OnHQEOsTLkCEPM/3H5rpvAUu8fSkuRgc2PVwB17kSugWa+8TPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ti2iz03gff4eAzG9KX+TbCo+8t8Roleyjbh1mqh6hMM=;
 b=lUvAyv6BmbovyP1B3QFYWQXVTXl3FHbgTsGPabUk2hb653VfF2/Bp98MEtBBr4bMdT/uQzADYkozuZa12ytfsKjTybDrIBXOit0ROL09thcYP/N75gBqytHgOTePfz0Vmj7JwhGlCPop1QlPCxn54bvHBmuZJ46ijczsO0s5P9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 7 Aug
 2025 07:33:08 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%5]) with mapi id 15.20.8989.017; Thu, 7 Aug 2025
 07:33:08 +0000
Message-ID: <83be04f6-33c6-4fdd-a52b-898f6c8364d7@amd.com>
Date: Thu, 7 Aug 2025 13:03:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Save and restore switch state
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Ce.Sun@amd.com
References: <20250801124027.1709925-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20250801124027.1709925-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0229.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::11) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 511cb93c-8a41-4537-78e6-08ddd584a751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlN4OCs2bVgwdTNLK09MaWRsNExXYnpvRlB5SlliMGdxekpaWnczaVcxamd2?=
 =?utf-8?B?NkdnSnl4Vit4VE1YNzJyNXpGNHhoS3NNbzByQm5ZQlFxYTVRSC9XaFVYOU5Z?=
 =?utf-8?B?NmtHZ0hGRFN4TnA4bk9RK0lldm1qSk5teWJ6dkJwYjNNWmluT2hxQ2x1c0E1?=
 =?utf-8?B?MFljUTFCdUhwSHIwYThnUFpYZVpBU0EvWExxelJSaHlWMm4rVHA1ZVhTSDNu?=
 =?utf-8?B?ZExiYnlhTTRCRHYzQ3dkSmhQT2twNStkbkswUVR1TVVDbmRqMWpFVVdxaks0?=
 =?utf-8?B?TmhEaCszaDJ4WnRJeWFDQTVNMUxGMzRBZHpVUldOYkp3Zk5jSUxweDlmaytF?=
 =?utf-8?B?bmVKenkrTi8yYW1PTmJkd25tOXJEcGJOVUVWbGxJaXZHa2RUVUlJSmFjd210?=
 =?utf-8?B?aUp2TW8rQTFSenZ6N3orR2ZrY0VzMGVOWXBEeEt0bTR6d3VHUW9zTmxPQWdX?=
 =?utf-8?B?M3ErOHhOd2dYUys0MmZ0N0daUTlXdSt6TnM3T1MycHZHVnAzeWZqbGpreENL?=
 =?utf-8?B?MkpxNzgyNlMzdUpiREo4TXlZNHB3MFJKeW5XdXN6eE9nZjJyTW9MT2lqODgy?=
 =?utf-8?B?bzloS2JlTXIyS21GRGREbHE4OFE4MXdYa1Z3MTRoSlF1NEs1K2ZRU3ZvRzdM?=
 =?utf-8?B?MHA1cGJWdHFvSHRXZHU4ZzlIekN0amZoZHNJOGhsVTNKT0cydU5hOXdWQktC?=
 =?utf-8?B?WjhERXQvdEZwZk92Nm1XMU1ZNTBMeUw4bTdZd1cwZi9saW1oSzFkNDBGUmFa?=
 =?utf-8?B?dzdlN20vWk43MitQNDF6WVp6K3BRM3VDL3dFVG8xeHVxMmtvbzNoblUwS2NB?=
 =?utf-8?B?bHFIR01ldWw3TmZDN3gvdkN6cXQwWGUrTnJMcW1wcUM4bUpaTjYyK3dOKzVx?=
 =?utf-8?B?R05ETmkzbHdZbmtHVFhqaUs5YXdMNE0rMFlaMHllN01NWFl5WWFvc1g1OThL?=
 =?utf-8?B?VVFaNlN2MTVtZ3NrVXJaZ0RjR2haUkFPSzQ3QWY5SW1EMCt0ZC9lNHN6SnJ4?=
 =?utf-8?B?cnB1TjcrZmVscWh1OFllMkJtYzRCa1I3Q2x5azVRS0hXSVpRZVdrdFlPWEww?=
 =?utf-8?B?UElvUTJqemtwdTBhV1VQbGRYeEVjajFwNktTMWg4cWJNdU1uemtvR1I1MVYy?=
 =?utf-8?B?c1JrRENxMDJBOFBZV3lwdCtUVFhIeHFMY0ZPODRqZFBnUzBqYnN4dUhHNTB6?=
 =?utf-8?B?MUpIZnJjRDgrTmtxR083dWRGQVZWQmxBQ3Rjd25aZVdSZjlFOGNjbXVnWTBH?=
 =?utf-8?B?UVhSK0gzaVN0UGhRZkZlc0pqek9zbVl1YURLSHIxWVptMmhzVXZZcm50ZzFN?=
 =?utf-8?B?bnVFbmg4OU85bUZDQkZWRFZkb2hiZG5mMmYwcFpmU2pwdEE1a3IyckhoZ055?=
 =?utf-8?B?bE5Zd1kyUVBIaWpKeWI3ZDZlSDBkQmppeXJxaE5xNGtoNWhENHYrVWFoUHVO?=
 =?utf-8?B?bTVhVG1VYlJaSlF3MkhzNWY1VHB0WGhWOUwrRGp5Y09XZ29jRUlIZWxlZGx0?=
 =?utf-8?B?d202U2Z3MkJmRTA5VUVIekV2dnd1c0Q0azBwVzBTTGRndXRLN2NGNWZ4SGJs?=
 =?utf-8?B?T3liSUFpWHE4WnVyY05PQ1paN1QwNWlJTmhSUTlldnMwVkRFRG04bk1hM2di?=
 =?utf-8?B?c0lOVUlSNm9xclR0MDRGSGRhbHhlQ2ZROENmY293U09EeW9nWlR3QzNSaWhT?=
 =?utf-8?B?eURlT01UWnY0MW1ELzVZWm5ZWUVpVTdkdDVGM21kN0NJRGVnN0Q2alJHdnlC?=
 =?utf-8?B?ekEyMXAvQ1NXVkhXNUVxTmdSSHgyV2ZtcG5qa3BiU0pFcU1ONlZJaU93bmNM?=
 =?utf-8?B?dnBudmRsWndzckt2NDBVZDJCMTEwbk5EL0pVZWxQeXcwYlB1ay9la2k1UGg3?=
 =?utf-8?B?UTBVOHl0cDF5UFNjbE1QNnlzbjVNYUV2RzhiYlU5TFVHTnkzRkU4TmkrUFZa?=
 =?utf-8?Q?qZV0rklUiHI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGhCUVUwL0NqbGlWRWEvUlRPYnVXQm1qTjJWa3Q0NnVTZFh1UUh6STBodyt5?=
 =?utf-8?B?V0FYZ3p0blRtZHJqSjRZNEE5elI4VzIxdUtBanZ6NkFqcnlMZVRmclM0Z1RG?=
 =?utf-8?B?by94bGw5THVtVTF0MFRmRkVtV09ITXE2Q1VtSXVScjdiRnpITjNzN28waGRj?=
 =?utf-8?B?RUF2RzJaUnZ5bmVFblY3UkNkUldvUkFpKzRmVDdNUGJMSm5HS0xIYVBFaTlD?=
 =?utf-8?B?SysxVnhUUlo3aHNMTzlIdUUwM3FMWldaT3cvTnNVQ1FVajhjQysreWtFdTVN?=
 =?utf-8?B?bUI3Z2l3WU5oYVpDWVlIM1NqMXhUUzQ0eVBHRW9WV1REOUhnKzgxRWhxZ3Zs?=
 =?utf-8?B?cnJCSG0rUENHczd2SUVCY0svVVM5RXNwYzdyeDhmWUllRGxsbUZGUzNjUlpj?=
 =?utf-8?B?NVZGeno1L2pZYlFnY01kdVo1SzlUb3BrRk5WK2F4Yjl4UUw1VmNDWWdVM2Fr?=
 =?utf-8?B?YVpXUUdNbWFENTNZMVBraUp2L3czbFhPcXhZWGtrQXRDaDF2Y2dJVWkyWWd6?=
 =?utf-8?B?MmRHVHdIZ3djN1BaZFBVTXhjVURtT0QySDRwdi9SVWZENVQ4dUFYUGNlSjlt?=
 =?utf-8?B?SlYzb2lWZDUyTTI3aGpaaFBjS3F6U1NmUnZXcjI0Zmg5dGFNZWNJajZQRWVj?=
 =?utf-8?B?d01sMXVCaFFLeTFQVStuNFZXMEdsTU9YQmFnZlFCbitoRXMrWlIrR3pYUGV4?=
 =?utf-8?B?UFVnQWNRc2NQRXc2bXpyemtvR1pFcENhT3F2MjVMMnJLMnkxWXRFbEtvOUJh?=
 =?utf-8?B?ZGdLakJLUkp0aU15bjc2ZXFwdlQ1Q1kzQ1dXa1djQTJleVlZWWxqOHFZUWt6?=
 =?utf-8?B?bkxDa04rS2h0dGVEaWt3NmF4SVNVMjJtNks0cnNtQ2FldHRPcVE0MWc5bndL?=
 =?utf-8?B?TnRjN044SnhyR01FbGtVK3ZDYUJVcHVqT2hkT2FYbHpvWHB4UFZIQmtDOXZN?=
 =?utf-8?B?d2RFaVphWk5rKzFzWDZkQ2ZZU1QvU1dxNk5GekREZmp6d2JNUjcxU0NxQTJX?=
 =?utf-8?B?RnV5eVVUNHdsbndvcFJRTHp2dVRFak1GOW1vNU91ckhBRWZTcGE5blAzSG1m?=
 =?utf-8?B?enJaSHVMNXQ2WVFVU1p0ZG9aVU5zbTJZb3oyRjFabjhKTDlRNGYyb24zSW9h?=
 =?utf-8?B?ZnBaV0xMRlZ4SHNKa0Y1WG5xQlFGUEg1Q0s5RE5MdlhYaG1MVVdxbVgvRENL?=
 =?utf-8?B?aHFhSXJrMEVYVUdiUXdnbzJwdk53VXB3d2hONmZUNWtINlZQSHRxUjB4TVQw?=
 =?utf-8?B?UzB4OGZBQzIwOUREWTQxSjlsc0pObllzSnFTUHRvTVRUR3BtZUQ1aENkM2M4?=
 =?utf-8?B?eElmSldQaG9ON0FtcTNHMnZIeU9DQWIrYVMrQVpGU3NRTU9VaTdwU1piYUN6?=
 =?utf-8?B?ejFrMmVTNlRaOVA0V0dsZ1FLTmlZa21MVXBzZGZZcVlKVWI2bXpweUxlemdY?=
 =?utf-8?B?a0MrMk5IeTUvQkNuVUxTakhXVit1T2VPa2YxN2NBa3crUEVCditLekVYbjNw?=
 =?utf-8?B?NzBjZmZNb3o3MjBiN2s2dGFSOWxJbXRMUUYrRk5McVNZNTB3eHZ1UnBJQTNs?=
 =?utf-8?B?aS9pM3JOb2dCYWVUb3lTSXcwUytSRlViaW9vb0RYQ3AwUmU0SEhKTm5teFRU?=
 =?utf-8?B?TnRtT2hYQ25VRmVoR216TGhiSHBRblcxSm1pdEluRUtwWXR1NDQxQXJlNExs?=
 =?utf-8?B?QW1UYm5mQXZjZXZkRjM5akk1cUxsRDBtOW9hOW90elJPY3ZZeUxwUUVDWWdC?=
 =?utf-8?B?S3l5Wm9Ga08xZ3hadTJhMkk4NlBzeWprNGN3eUtwcFNKSUgvVHFWUjFQdnps?=
 =?utf-8?B?QmEvSGlERzNiOW9KU250bW1rVnl4NDhYd25YOUJ1clhWVllEUisyMTBJOElU?=
 =?utf-8?B?K0c0NFNPTEduSzF0U1dSYXZEOTRwWkNBRzVRYXQvczh2dDZJenJaaFU3Z1Zi?=
 =?utf-8?B?L2l4OGtaMUo5QVQwcGh3cHROWnd2N2xmbk1aQlFCeDAwQzJWNGVRN3JXVmZY?=
 =?utf-8?B?aUpBbEVzY2doVk01d1FGR1BMYUhJRHN0YjhGV3gwc1pxKzBsM2tENWlYV1lG?=
 =?utf-8?B?d1huaHl0cVhLRGxCL3djSk1SdU83OFkwQjU0aER2d1JYcVRwcFJLSFd3azFm?=
 =?utf-8?Q?7GxfKUaZoMwZhMptCAlH0ltRs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 511cb93c-8a41-4537-78e6-08ddd584a751
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 07:33:08.0378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6I9cu5aVRwaAw4CHoKiVTJZ8ooPDjFI5pklTTphlX4TL9UHLRNVj1X8TTfyySTos
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092
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

<Ping>

On 8/1/2025 6:10 PM, Lijo Lazar wrote:
> During a DPC error kernel waits for the link to be active before
> notifying downstream devices. On certain platforms with Broadcom switch
> in synthetiic mode, switch responds with values even though the link is
> not fully ready. The config space restoration done by pcie port driver
> for SWUS/DS of dGPU is thus not effective as the switch is still doing
> internal enumeration.
> 
> As a workaround, save state of SWUS/DS device in driver. Add additional
> check to see if link is active and restore the values during DPC error
> callbacks.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
> v2: Use usleep_range as sleep is short. Remove dev_info logs.
> v3: remove redundant increment of 'i' in loop (Ce Sun).
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 72 +++++++++++++++++++++-
>  2 files changed, 73 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3550c2fac184..96d772aadb04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -904,6 +904,9 @@ struct amdgpu_pcie_reset_ctx {
>  	bool in_link_reset;
>  	bool occurs_dpc;
>  	bool audio_suspended;
> +	struct pci_dev *swus;
> +	struct pci_saved_state *swus_pcistate;
> +	struct pci_saved_state *swds_pcistate;
>  };
>  
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index cfd72faec16e..e58f42531974 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -178,6 +178,8 @@ struct amdgpu_init_level amdgpu_init_minimal_xgmi = {
>  		BIT(AMD_IP_BLOCK_TYPE_PSP)
>  };
>  
> +static void amdgpu_device_load_switch_state(struct amdgpu_device *adev);
> +
>  static inline bool amdgpu_ip_member_of_hwini(struct amdgpu_device *adev,
>  					     enum amd_ip_block_type block)
>  {
> @@ -5006,7 +5008,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>  	adev->reset_domain = NULL;
>  
>  	kfree(adev->pci_state);
> -
> +	kfree(adev->pcie_reset_ctx.swds_pcistate);
> +	kfree(adev->pcie_reset_ctx.swus_pcistate);
>  }
>  
>  /**
> @@ -6963,16 +6966,27 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>  	struct amdgpu_device *tmp_adev;
>  	struct amdgpu_hive_info *hive;
>  	struct list_head device_list;
> +	struct pci_dev *link_dev;
>  	int r = 0, i;
>  	u32 memsize;
> +	u16 status;
>  
>  	dev_info(adev->dev, "PCI error: slot reset callback!!\n");
>  
>  	memset(&reset_context, 0, sizeof(reset_context));
>  
> +	if (adev->pcie_reset_ctx.swus)
> +		link_dev = adev->pcie_reset_ctx.swus;
> +	else
> +		link_dev = adev->pdev;
>  	/* wait for asic to come out of reset */
> -	msleep(700);
> +	do {
> +		usleep_range(10000, 10500);
> +		r = pci_read_config_word(link_dev, PCI_VENDOR_ID, &status);
> +	} while ((status != PCI_VENDOR_ID_ATI) &&
> +		 (status != PCI_VENDOR_ID_AMD));
>  
> +	amdgpu_device_load_switch_state(adev);
>  	/* Restore PCI confspace */
>  	amdgpu_device_load_pci_state(pdev);
>  
> @@ -7074,6 +7088,58 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
>  	}
>  }
>  
> +static void amdgpu_device_cache_switch_state(struct amdgpu_device *adev)
> +{
> +	struct pci_dev *parent = pci_upstream_bridge(adev->pdev);
> +	int r;
> +
> +	if (parent->vendor != PCI_VENDOR_ID_ATI)
> +		return;
> +
> +	/* If already saved, return */
> +	if (adev->pcie_reset_ctx.swus)
> +		return;
> +	/* Upstream bridge is ATI, assume it's SWUS/DS architecture */
> +	r = pci_save_state(parent);
> +	if (r)
> +		return;
> +	adev->pcie_reset_ctx.swds_pcistate = pci_store_saved_state(parent);
> +
> +	parent = pci_upstream_bridge(parent);
> +	r = pci_save_state(parent);
> +	if (r)
> +		return;
> +	adev->pcie_reset_ctx.swus_pcistate = pci_store_saved_state(parent);
> +
> +	adev->pcie_reset_ctx.swus = parent;
> +}
> +
> +static void amdgpu_device_load_switch_state(struct amdgpu_device *adev)
> +{
> +	struct pci_dev *pdev;
> +	int r;
> +
> +	if (!adev->pcie_reset_ctx.swds_pcistate ||
> +	    !adev->pcie_reset_ctx.swus_pcistate)
> +		return;
> +
> +	pdev = adev->pcie_reset_ctx.swus;
> +	r = pci_load_saved_state(pdev, adev->pcie_reset_ctx.swus_pcistate);
> +	if (!r) {
> +		pci_restore_state(pdev);
> +	} else {
> +		dev_warn(adev->dev, "Failed to load SWUS state, err:%d\n", r);
> +		return;
> +	}
> +
> +	pdev = pci_upstream_bridge(adev->pdev);
> +	r = pci_load_saved_state(pdev, adev->pcie_reset_ctx.swds_pcistate);
> +	if (!r)
> +		pci_restore_state(pdev);
> +	else
> +		dev_warn(adev->dev, "Failed to load SWDS state, err:%d\n", r);
> +}
> +
>  bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
>  {
>  	struct drm_device *dev = pci_get_drvdata(pdev);
> @@ -7098,6 +7164,8 @@ bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
>  		return false;
>  	}
>  
> +	amdgpu_device_cache_switch_state(adev);
> +
>  	return true;
>  }
>  

