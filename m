Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C7BC3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 07:40:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E52610E1D1;
	Wed, 28 May 2025 07:40:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="37XslDJe";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD3AF10E1D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 07:40:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIqRkoezvFoV7+IVYVvmePEOZWRy3WnNAEA6aRFdYv+OySzx0vaUVclfGaG8+i+pDZrBZXzOUrUYsD668ywPmGmhEWd92OMd3v+GoPtDZd8E/agHZtvhK0zCXGCQdLIdqV4M/rnkvi/m4IFMVowOTxlwZEcuwqdoRKsr07WHa3UsRSajjzgeUXNM3YVJONIDw48hUC+A0+SxlVJqYUpQFVCLs3+yxHh7httiMpoVnrt3AOjdHPIynIhsJ4p2ZG4Y1yN9rorsR8288RFC94P554n/91OkSR9TiyFKu2AVLI1hRXaHfRzU4K/45yu2VR9C1opcTKrcN4icevR8yvBIsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Al2bgVC661E3FmztSDeFkDXuRXWE9pEUHTuZkbjet+8=;
 b=zPkuM6O7uqu/wzlPSyPvHryS8Yaxu1lfHbpWjl+SE2fGp74SPxMnlOZklSBvEIjIUCmMPF4j1q1SJNbDXWzjW/QYRiv5JpKY7I5jb0wmSxBietFTXSRXALtlnn2B+EiCeI2AKDT0gvu4mBay4yIaR69na2pFL7QeI+awOEnExd45NsDudcmqJ90i4r2N2FSw0Osvb5l+3eGn1Wy0KUnOFN13klhQgdxqaIDRl61a3Y8vZrZfsQIMWy0/hbOnLucG0l6TJIxfHDHgGeRtoymBq0kcb/3Z8Pb45s32I58KLc4v4ujKAECIZqm09UluWEij4+uoVuybtUCmfKA1oQFjvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Al2bgVC661E3FmztSDeFkDXuRXWE9pEUHTuZkbjet+8=;
 b=37XslDJeP5DYc5xHjV/qjGTOkcwbcFdi7Dh6M+LzfKDz/uw6+EyiE2N/MQUaXoNJcWaRfXsVa8X74SyjF6tSB7sKJ/3bj3WFSShv4uyAMM5OQNbZYvdmaLIn2nwRua1zBwN0uvxaFqYJZK2F53wzDh8enWv4KYa7gLgTaH190kg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB8230.namprd12.prod.outlook.com (2603:10b6:8:ed::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.27; Wed, 28 May 2025 07:40:13 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8769.021; Wed, 28 May 2025
 07:40:13 +0000
Message-ID: <90d162b4-b334-408a-afd2-a167d8f9c23d@amd.com>
Date: Wed, 28 May 2025 13:10:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Export DMCUB version to sysfs
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250527155942.476354-1-mario.limonciello@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250527155942.476354-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::31) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: c7b8e103-44b3-4864-0f3b-08dd9dbae1ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWFxMzBXTWh5Zm5sN1R4OGxiZ3ZmK0J4blRlWkVtUjZZeDBDTE1HMUZ1SUta?=
 =?utf-8?B?R3ZreGhCUHM3ZHdSdmErRlMwZHRpUVdGeTQyOStGdUdSL3NnRUV6cGtEWThq?=
 =?utf-8?B?YjE3MU9VOURNdlNRZmhjOW9PaFpsS0ZlNGdhb0tjQUdNaVNUOHlZc044blJM?=
 =?utf-8?B?WU9id3E2dldGZzBENW9lOWpzdVR4YkZSTVYxcEd6bmtRci9RcmRQOW5sRUpn?=
 =?utf-8?B?Q1Y2Q1lTNHVTMFhSbFNUNXM2bXpuNHArTzliR0lBOXFNSFgrUjhqVjN3NDd4?=
 =?utf-8?B?aFVKMEt5bnlGalpKeEU2cUdwMXZCZkdRQUZpQm9CQzZyejU1aDVta2loNHRz?=
 =?utf-8?B?N0pSNUpKTzBRRFlMQTRpNlQwVFZ0Kzk0Zm1UZGVVUFdUWjV6WnQ0QkJ1THpL?=
 =?utf-8?B?eTFyVnpJZEgzSERraGhkMHFxRUJNb2pqdGtrdXloaE1ESlNSTG12NXJaVmgv?=
 =?utf-8?B?WU5BSEkvakRKSzdrZ1orQ0grYlBlMVdNcGpSTnpTdkZOcTJCZVNiMWVJZm1D?=
 =?utf-8?B?bVl0V3NJTVBGNlMzYTY1SlBUSjdoNVN0elVCbmwxNzV1aEhieVJxUzRweGZO?=
 =?utf-8?B?ZkduQm02K3JtWHhRSWFhc2dxYWtZTFZlZFh0T2pMM1prdTgrcUo3Nzlycy9I?=
 =?utf-8?B?N3I0b3ZKNnNhcSs4djdoRm9NMUN2QUZTMTFPbHpGM01DZ2RpRnFuTEZGNW50?=
 =?utf-8?B?MXpEV3QxMjBoVUV6Q1NUZytMcjEwUkF5dG05SzdqQnVIOHhET2JwSkdLRXJ2?=
 =?utf-8?B?eTM5RzN0dkFUdnZBSzdFNTJsOXlFUXlPYWFmZmdDZjlkRFk4dW1uUDh1TVNE?=
 =?utf-8?B?b3RCRTBISGg3d2M5dGVYYVBiNFYzREcrRTQ4U3pZaG5Vdk15dEwzYStMLzYz?=
 =?utf-8?B?Z1E1Q0x0MmFGdGN4SldHcDBYM0FFQWhVOHhJdjVhVDJSYlU2d3hiVUhkMW40?=
 =?utf-8?B?RTArajFXUkRweDNyeVVIYjl3Y2tyem5nUHBGTDg4c1hCZTRZdVlIbUlFMW45?=
 =?utf-8?B?dkxtUk1ubEcxa1J2RW5ZUjVJZWNKRGttcnRNSUdSZlZWdUJFV0pkdUNzTXJx?=
 =?utf-8?B?KzFuRmNGNHAweUpQeGdQZ3pzR2ViV0pmVHgxRnl2Y2h3RW1TSStlRjFQalNQ?=
 =?utf-8?B?Mjk2ZzBZbXFOTUJ2Z3ZoYXpXWFRyMkd5VUhvR0tvbUUvUnNPTTZzQlhpWmk4?=
 =?utf-8?B?T2h0R1NNMnBqUzczbTFNcm1XenhJanhnZ05sQTdGZHZZb0Flc0tETlRHY0lJ?=
 =?utf-8?B?QUFtNlFpQ3BXV05KemxHZ1kzamVnd08xLzExNzN4Y045OHZkaEkwa3QvYkU4?=
 =?utf-8?B?YTR4VitGeHJadFA5ZTJlNlZBU2xHMWhSZUN5b2orZXhVTCtUTmFIOTVsbGZp?=
 =?utf-8?B?eFljZjVvOVRVekhLQXNlazFhcW1WSDl3T0huVGJlMFlQakJsS2Yrc2tITEsr?=
 =?utf-8?B?SndLeUZHWXNOMTBLRE8vUkUyU3RyWTlQN2xyQmdMOFVEamZLdU1aZTNGNHNN?=
 =?utf-8?B?OTI5WWhVc2JtQ3Y2UkF1a1VGZ1E2ZU9jOWNYVTFEcDh2bVpReWNQbk5iSEE5?=
 =?utf-8?B?clc4QlhoZzR3NEtMcUltOU41MzMzak52OGQweEJoM2YzQkdBTmRKYVhCcTBN?=
 =?utf-8?B?cWlYR2hQRWt3bmk2amN0anBVZWltaUtRYWRnb3RpeTJqcE5VMDI1MHpvaE51?=
 =?utf-8?B?eHBKN2NNS3FRVmU1cjNicmo5dmVPNG5iMWxwNTZ0c1dKV0IwSVlIMzRzd212?=
 =?utf-8?B?K3QzcVlGNVBJMmtnVUtXaHFubDNLeHFnbEZveWJKVUVLN09PbXp4NWNoVGRn?=
 =?utf-8?B?UmhvcURXNmZkRURIZDNyNHRMTjFoYzJGaDJzSEJwanpDMUdLRkd5YzBLcE11?=
 =?utf-8?B?NEJ6ekU1V1ErWDJPeXhQbmFOWDlvRWtTVEZZd09RM1pZSU1mU2cxeGkvVWc3?=
 =?utf-8?Q?F1kpa28RD7U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEl3dERWczZqZjl3eUhLRFNxdmZoeGNpd0YxV0RsUWxLL294L05kSm9uSTdX?=
 =?utf-8?B?WGdWbDFuVC9XTTA5cGRRY3NFaVU5amFhKzNtRkR4UkJ5SDZGZGNIWkkrZkZZ?=
 =?utf-8?B?WHN3MXJrNXR4aWZpWkxXcktHUkNITEdncHBPdFg4UlpKK3NpbXlrNGZEMVNB?=
 =?utf-8?B?Ujc0a0lFTTYrWkxZRUx6MVRKRFRnRWVXK3BNelpJejJxRHU5N1BRUi9XTi9Q?=
 =?utf-8?B?V1AvcURQY3RoSmVUenJmWG1OZHgrQUNURFhIUVd6d3hDZ3F6TlpyZ0Z5R2Vw?=
 =?utf-8?B?eVVOMW1maDNsWS9FTklaTWNzZVN2WHVYekJMNVNYNVhsRnVZbWY5SzJCZE9S?=
 =?utf-8?B?K3RqUTZ4UUlDV3Nzdm81ejNsYWhVcHdSc0s2Q2JuQWEvdE81K2FVU3oyb01p?=
 =?utf-8?B?TmVtTkc1YnF6bXh3d0VGTXJSZUwvSkxLN2RnYmhsVjN4MXpnaDhVRHlZUFQx?=
 =?utf-8?B?SFpmcDNUbXhLeXQ2NU5NaUc3Z1grMU9RSGlCSGtPOVFxQmZFQSsvdmo4YzJK?=
 =?utf-8?B?STF4d1JldEUzbDhCaE83SCtLWnpPSkFRMFdMWm94b1l3ejVrWVRxaHZKUzlJ?=
 =?utf-8?B?RVZ1U3hjOFRyK2FiTHFzaTU1YktaNDhMV0tadlJOdlFWOTRsbmVSbnU0cE5K?=
 =?utf-8?B?bUJJcHRLMExoeWlESzhWOXFiREtHN29nSWZrN01jR1dYUlJEMlUxWUxVNnhq?=
 =?utf-8?B?ZGZBcHJKRStoQW9pcFFJckxKa2dZRGVpeUw0SG9hTXROalNlZ2hRdUhlWS9M?=
 =?utf-8?B?VS8yUUxJclZtMnowaGRZSjlZSk9xTWorSktmWHVTQXRmOUJDWWdOa2s4L1A1?=
 =?utf-8?B?V05TQUlNb3BFTXpzb0dsWWRkeTBtRUJ0bkdmdFJkbG90U1RLVWRsdG8rQklY?=
 =?utf-8?B?bzhGbGppUGdXbkpHMHBkSHhsQWpqT3lDK0xCdlZFN0xHckdwZFVpZ0xSL25s?=
 =?utf-8?B?OW15ajNyU3ViNVIzNWlkMkNNNFQ5R3JMN3pBcFFhbVBJK2RQZGNPN20vbVdh?=
 =?utf-8?B?ZExZM3J3RzFLTVQ0RGdVOUFIeFhySmNFYVBVOEdMLzl1ZktrdC91QTRjNHY0?=
 =?utf-8?B?c3c1MTZwVmFwazN6NWNzUTU2R093MWl4bkJsYUhhb2hBWDhJSytZNnhXQlZn?=
 =?utf-8?B?SkRlOTVsR1VWNmJtSUNzSUdONUR2eVlTa1g3dFZraW9KcjRhRWVVOVZWOWx4?=
 =?utf-8?B?SjQySVRJVy8rZzhoSjdEWEZFd01pUHFkQXpDckNiZzNmSkh5dWxIYW1rYk83?=
 =?utf-8?B?cG1EUzNWU0dVY3A0MXJwRGRoeEs4dkovQkhXT3A0Z0xNYlU5YjlaZ1ozRk1F?=
 =?utf-8?B?VVpaVGxPTmtST0lYb1ljT0oxY3RXMWp3dmtQRDQ3MjB2RWlPK1FmWGIwSytF?=
 =?utf-8?B?YXducjVCTkV4WDhPQ3dXVExpbmllaTVJK1BrV1pab0R1ai9sWU5xMjZHS2pZ?=
 =?utf-8?B?bnF2Si9MM2xOQUdtM3ZWWHZsZ24xTzMxVmV1M1J1ZEJMd0JnREVjcTRUdzZu?=
 =?utf-8?B?N2tCdHlRc3JLRUg5SDJ6SURaaUZ0TlpFckdhYXRGUHJvbVBnb0RXaDkrSklm?=
 =?utf-8?B?Z3k2QmZkaW9hQ2R0VUxldk9jZTY4Q09oM3lkU1dFRHFDRkpRQmVUOGJQZ3do?=
 =?utf-8?B?K0FER0RhTWY0MFFUZUdaZG94NUtZQk43VFp3ZzFsTE52UVRaZ1ZLMFM1R3Rm?=
 =?utf-8?B?dUZDSlF2Q2VxK1BESUV0Sk9OVUNYejl0Zzg4aXJmNXlmazZWTHFjVFgzeWdH?=
 =?utf-8?B?T3p5djdyWTl2UFpQRjk2RzZTVUFLNktWWERET3lYSUFaL2FHdmYxR3NadmMz?=
 =?utf-8?B?L0U3MFFvM0d6eTJnVmFUbFJ4L2g5UVpYenMraDVBS1ZiT0czZXpSRUV0YzAz?=
 =?utf-8?B?ckp1VENDZmJlNjlTajU5RDg0N2EvTzZqR3VENkgvVno5UjN4RkVIempnQjk3?=
 =?utf-8?B?eC9JamFUVitHWHF3MGJkNXlkdzlZUzRPNGNNam82NVZ6RE1SVExyc1FQam83?=
 =?utf-8?B?R1o1eEEyQTZ4RWpvaVVDSEdLS2JhQWFPYU5OMEZLamlWQlh4QXl3cXM2azZ3?=
 =?utf-8?B?WmhoNHExZnNtV1pVc0xvMnNKZDJXb2JMRnptQU9aSHpqQW9hcVo1WVRjTHdH?=
 =?utf-8?Q?MbFAwyWt0Zi0/n3kO5hlxNmpz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b8e103-44b3-4864-0f3b-08dd9dbae1ab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 07:40:13.6508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+nLeVUpRIa/mt9f1l/I10uSTA6eGjxt2GkPgGz6129K02wnfZzVtN0sXjRMKfOh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8230
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



On 5/27/2025 9:29 PM, Mario Limonciello wrote:
> For supported ASICs DMCU version is exported, but ASICs that support
> DMCUB there is no information exported to sysfs.
> 
> Add an attribute for DMCUB.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index 4a72c2bbd49e..2505c46a9c3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -765,6 +765,7 @@ FW_VERSION_ATTR(sdma_fw_version, 0444, sdma.instance[0].fw_version);
>  FW_VERSION_ATTR(sdma2_fw_version, 0444, sdma.instance[1].fw_version);
>  FW_VERSION_ATTR(vcn_fw_version, 0444, vcn.fw_version);
>  FW_VERSION_ATTR(dmcu_fw_version, 0444, dm.dmcu_fw_version);
> +FW_VERSION_ATTR(dmcub_fw_version, 0444, dm.dmcub_fw_version);
>  FW_VERSION_ATTR(mes_fw_version, 0444, mes.sched_version & AMDGPU_MES_VERSION_MASK);
>  FW_VERSION_ATTR(mes_kiq_fw_version, 0444, mes.kiq_version & AMDGPU_MES_VERSION_MASK);
>  FW_VERSION_ATTR(pldm_fw_version, 0444, firmware.pldm_version);
> @@ -780,9 +781,10 @@ static struct attribute *fw_attrs[] = {
>  	&dev_attr_ta_ras_fw_version.attr, &dev_attr_ta_xgmi_fw_version.attr,
>  	&dev_attr_smc_fw_version.attr, &dev_attr_sdma_fw_version.attr,
>  	&dev_attr_sdma2_fw_version.attr, &dev_attr_vcn_fw_version.attr,
> -	&dev_attr_dmcu_fw_version.attr, &dev_attr_imu_fw_version.attr,
> -	&dev_attr_mes_fw_version.attr, &dev_attr_mes_kiq_fw_version.attr,
> -	&dev_attr_pldm_fw_version.attr, NULL
> +	&dev_attr_dmcu_fw_version.attr, &dev_attr_dmcub_fw_version.attr,
> +	&dev_attr_imu_fw_version.attr, &dev_attr_mes_fw_version.attr,
> +	&dev_attr_mes_kiq_fw_version.attr, &dev_attr_pldm_fw_version.attr,
> +	NULL
>  };
>  
>  #define to_dev_attr(x) container_of(x, struct device_attribute, attr)

