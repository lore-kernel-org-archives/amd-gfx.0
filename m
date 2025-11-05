Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF94CCFA04
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 06:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC99810E6BE;
	Wed,  5 Nov 2025 06:47:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lZ6UWc4w";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C8E910E6BA
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 06:47:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QbomPcxVegzxpLmcykt0eTNDwjfTgqPtxQK6UTnJ0Q5Yhk0NUMhU6f8hLEpw5KhwQc7zTqfr/xErq1bMiGAkzvhgHsTgQNz4BEtrcsiqRkKOCkLNEyrwiW6Rqd6Wprhtjbc5sRYBhB1HV20fwjq8h3EpI5QNYArecVukJ4Yhh0yCZpDWjDCIeFmBiwYgqMJL7KB8N3xCPS+EJSyHF/aQo+2pnGKQUYaahrfn4k4UusfnKYfqDZYeK7EyaE2rysZ3hOQdAFq77hz8C3LD1yDZiOKL/eReoVamuB0xvWemNJpVKi3kQ6UKRiXOm9jRSWPW9OpQuPPipLF3CquGJewZmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMdtuR/z/kUDAsRQnLHP/H1RrLte5pKLP2Hcsk9Ew3A=;
 b=PnsuTT0GNX5mX28hWPPoyS6V89ldh2vrIYtuusyfGeQWsKAgREO3NhqvPOS0a9dj28ygAQ8/fOsato3qyKRYMGOv1Qs7p1XMfZSjurxSzQoSwpFGTcETQFd57czntgB2jJI0E9AJ2zY0w3vDtO/XGXXtMN+0r//VYel6aBaCqvVgNGwakXCWeuPIm5EEdW8LD0ijkuGqrarsW45CJFuXBTFhfdZD0u7a9mGjS4vSe+quahyV2BBuMiJ3A6VAwBk3ASg9SBkQ3/JwHMPSNHIhVsk+gJYUenW15kwqKWW6ErpOk35JEKpgp3OMiaX88vaYysWvEcUcNlteA+54FX6R/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMdtuR/z/kUDAsRQnLHP/H1RrLte5pKLP2Hcsk9Ew3A=;
 b=lZ6UWc4wUqzaDsDr+mYjB+Lq/8lOJK2N6PfM7zDunYb79SgpPiSbc87eWeqL8FdYf4NyliqPZledyZextabFiqUyug+/m0ySmIUWQ0Pf4RDOsJkRvSYXpzEIFF4kF6KX6zqow+xZahq2Ulk0TuK5mnpzqWjE5nM/s3mrQLan7fU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA0PR12MB7628.namprd12.prod.outlook.com (2603:10b6:208:436::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Wed, 5 Nov 2025 06:47:13 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 06:47:13 +0000
Message-ID: <bba0794b-1c27-49f2-8391-c39530bb5afc@amd.com>
Date: Wed, 5 Nov 2025 12:17:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: fix gpu page fault after hibernation on PF
 passthrough
To: Samuel Zhang <guoqing.zhang@amd.com>
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Qing.Ma@amd.com,
 Owen.Zhang2@amd.com, amd-gfx@lists.freedesktop.org
References: <20251104073102.257287-1-guoqing.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251104073102.257287-1-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0120.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA0PR12MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 24cf4ad3-1f05-40ea-c4ed-08de1c372665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TEVMK3JZSnJIUXRFVk05dm5idTMwT20wMFNQOFhYQ294QWJNNUdtTFlnV2pX?=
 =?utf-8?B?K0t0R2NUZVBPa0JBdmhBRzM5K3hTbTlEV2sySGxkQ05PWDcyb3FaSkRUbWc1?=
 =?utf-8?B?WnkxZUlBTmxrY3lESmlsUUdZVmFvVGRkOFpaeXVWWnlyQVBRSXZxeGZzM1lS?=
 =?utf-8?B?bzA4eWVLTUVTN0NBOXRxOGtFQ0h6a1duNC9DM2VzTk9yRkhZSFFjeEh5Q21H?=
 =?utf-8?B?Y1duUEZYTUVuL1poVlpockRlZHNyQVFrekJUdjhuSGpMT1pEdVRmQktkekJX?=
 =?utf-8?B?TUhITk0zaXlVK0lxcEs1aDF4WXdmc0ZxampQMkVOSVo5N3BOc1MwMkwzZjAy?=
 =?utf-8?B?dk1TWFBzbGcwcmttbld0Y3YrM0NQcWtDcEg5K051SElwWVBoR2hwaHB5NWtr?=
 =?utf-8?B?OEJMd2ZYRGVUUXR1TmZGdW5aTGFuNC9RNXpLZndWRkRnMW0wWmREeW1JMjkv?=
 =?utf-8?B?OFM1L0RTMXVsb05oaW5jTzhQbThVU2hMZFlwTnFnQ0NDTHNqWWh2cWNpNUpn?=
 =?utf-8?B?SEp2Y1ErV2RQUUhKdyt2bmMvSERZYVZEL1Q0d1JYeWVFaXR2UlJuK0twMllv?=
 =?utf-8?B?dVFQTi9zOHRnRCtDcVlRUUZiR1B2alRuTUtqK1Qyc1VveE5lVDIvZ1RjYk1E?=
 =?utf-8?B?T0RUNitLVng3Smw5b0U3Qm5RUndSQ1ptbDFLM3B5MzB1cFE0RnhYcUJib2hB?=
 =?utf-8?B?RzFYdHhaZkJNcEdCemd0WWtKdGU1bGs0enB5WllOK25xTGpzNE9pVEI4RERJ?=
 =?utf-8?B?bk5waEorQXNoWlVKVXFzWEQwd21JVGZZWGh2Vy9ndDNVRkpEdVd1SXI5ZHIx?=
 =?utf-8?B?UUYwS1NraU9jMXZzZG8vNW9za2ZrVjBjT3QvK1IvWHNPNmtkM2FXOU5NVXNT?=
 =?utf-8?B?NjZSc01IdE1ndGlzN0JOcEF6TjYraHRiZ01RMk1neHhMcU5qQUNWZXNQbHFM?=
 =?utf-8?B?SUlZeVJWcTNSaXFMdHhZQkNvMjRkRmtUODFMckovb3J2d2EvcndBazMxc0dT?=
 =?utf-8?B?c1FlcmV1UDR5S3pZbVRtTVhkL3BUY3cwWi80VTBuOXZlWW5OVHdGT0xFSHo5?=
 =?utf-8?B?UVpzeE90U2U5STFsWlFGb1FPek9UeWczNHllUHY3VUc0b0tLaEZCVklvMlRt?=
 =?utf-8?B?VmhtMCtyUnRHck96M2xRbElqRTF6ZlRQM0pGTjNVS3VaelJkTWRzRG5wdWdB?=
 =?utf-8?B?VFQzRFYxVnBtTXpBa2NIZkQ2VG5FVjFMUGpad25hSHY3eEN4b2lXNDdXZFZG?=
 =?utf-8?B?eXJLaklqWnF6NW9UdnRoYTFQbk12enhWa2ErNGE3WnZ4VC9jbm4yYXVZZ3Br?=
 =?utf-8?B?R0wrUk53Qm5FQStzMGUyakVkcUwvc0hPMGJXaFZGbFR4Y2g2NFQyVm5QWFNG?=
 =?utf-8?B?dnhkSTVRUjd4emV6aHFHQmNUMDdEU1lxaVJTM0pYaURpb3lkRGxuMmlnazdv?=
 =?utf-8?B?LytHZTB4ZzI2MFB6cGUrR0JxZlFXOXZnK2lvT0FWQ1R6YjVFZU1oZjFibUc2?=
 =?utf-8?B?SGdKSkoxZmJscm5HUDBMaW5SclVJRlZ0bURIMlJjdGZTclFKSTdaanpuVXdF?=
 =?utf-8?B?Tmh6SnR6L2lOR3ZpK0VtYjRFN09nMGNNem1MaVllY0twd1VTWXRaN05FaGNW?=
 =?utf-8?B?SDA0eFFjWTRhZDJFdXZzUFEzcEJBTGhyZEdua3ltSmo4bXpVaTRsNXgvRDVR?=
 =?utf-8?B?ajFQMlpKUnNZS2hGZWZDZWdBeldQTWpKdlJWb29ESC8xVi9nVklOTWZRNHlH?=
 =?utf-8?B?WEV1bFd6U1VKWmZJVjByc0NCODRrWjVtcmRyTFZZVHNYTmJleERQWWRlYngz?=
 =?utf-8?B?dnBkeW1UenMycTlqMEVXalFoRlRWZmR4cmJYUytxRnRzRWNHVUhVUzRGQ2Ur?=
 =?utf-8?B?dDFUVFhZd2pNVzFGRWkyaGJNMmZuTjF5NnZJMTdiUXNENjA1a2wwNE9ua3dy?=
 =?utf-8?Q?l5f+QsetnEw7vXDIjl1sGHWhTSs6HGu5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlVJc25oV0d1MUxvK0NKOXhSUHZZK29UQTVFUUZJUVRTQVZ2a0RMUzB4d2hW?=
 =?utf-8?B?bXVmMFpHR01TMytsdHVUVmZPcTdUM080eVF6YnRRcnR5Tkh0eW5Jd2pVdUhz?=
 =?utf-8?B?SEFhNVhiNGN5OW9WcXM0eU5pZ2l4WTdRQXVXK25NVHc4YkQ4QkNjT3JKVUtU?=
 =?utf-8?B?SWE3c3pBbHJaMXFnMUhsdkJ4bThNamNRRFg4aHV6bi9nTzlmaDZlSXdyRTFQ?=
 =?utf-8?B?WmxkU3dvaTlBQ1VYUURtVjRQWWFkUFl5RG1HVEpHekZmanpibld4cGhGeXVh?=
 =?utf-8?B?SG0yNkJJNC9KMHYwRE02VkxaT0gzdUpKTno5RnZ4dXQ5bS96R0tmU0NkdmRy?=
 =?utf-8?B?NHYzbHAvUDZDZ0plZG9EbGtGbng0OGFNSEF4TmprY1lqMU1PWjRBbTlLWWpF?=
 =?utf-8?B?dzN1ZHRjVHkwVFVEbnZYeTFua1R5TEdpY3czNU45SWZIOEtRWEhFUERSNWxm?=
 =?utf-8?B?aHNHenJoSE10Z0gvYXVxdTd5Z3dIOFNHUVVIcFBpNTdBdGdHTW1pVUxabkJG?=
 =?utf-8?B?bmQ4QUtTc0tOZnZYT3U5NERheHV2K1NmSy9Ha3RsRHdzRWNQbU5qRzNld0ZH?=
 =?utf-8?B?WDUwUlVqSDA3amE5eTNmNkF1c2UvMXE2NHB0WjBlRW83SW16bUExVWI4dnNr?=
 =?utf-8?B?NTFKdTR0RVJoS2QvVGptR01OM1hxV2xweUJzRWVJVjNUbHRPQnpOVXpaaWZi?=
 =?utf-8?B?c2dvbEc4V0xGSG02YnFlS2g2bVdxUkc3Mi9DUXNvZkNteXl0bDA3N0ltYnlw?=
 =?utf-8?B?UnAyRGJmbXQ3VzlvMkxrZlk3OUkvTitqU0JBZjlvRG9hNjhqdVNwTlgrb3NO?=
 =?utf-8?B?dXZlbHBuMHNhR2YxajNxNW9za09yUjRBRlhFc1Q3SkFzK3FoSVV3c2NORS9u?=
 =?utf-8?B?WEJUejFpRGY2aVdOTFM0OFlESlBBYnRwczdUajgvTlZxWHhFdmdyZWRPM3dE?=
 =?utf-8?B?N01RTklpaDBoQ3FrNVAwUEFQck5lSFhITXg3b0xsUzBCU2ZzYjBKZytKem5T?=
 =?utf-8?B?SnUxRVNWcjNsVWJRQXdYS1NhYmNvYWNYSXNodUtOSG1uUW1pdE9DejJvaUk5?=
 =?utf-8?B?T0NjeUg3N1o0R0hlNFFxUnBWamhBQzV5K1dhelNEWlUzUXA1Rm9QRDI5NG52?=
 =?utf-8?B?bW15ZDRWTWM1MUhicnhSMmNuSktQYjJYNkJLRFhJdG40QlNMQ3pxMnY0V3hE?=
 =?utf-8?B?RzQwSlFuMjFoUUlDc3RDMWVUSW05clVTZzlObkt1TmduMG9NV3hwNTJWZFpV?=
 =?utf-8?B?am9YeVFycGY3MmU4VE1ndVNjOXJhWnZTR3NmV25xT0g0S3IwaVU4WjlLL05H?=
 =?utf-8?B?L2wwa3NyRStQWEI4RFgrRGpxaHhmKzgrSm94ejFqb1BBeHFPa3Zlb0J0OTZk?=
 =?utf-8?B?NUJkRTZudGdYakJZbm5qYlRpNTZoemJFYkFOaWpMdHk5K0pJV2R0WHN1MFl0?=
 =?utf-8?B?UURYS0tiS2NZVHc5Rk5jRUY5UERVUGd5R29VNU10TEJMV0tTMzMrL1F4a2JH?=
 =?utf-8?B?L2g4NjVEYzgzMXRFUGJwd3g1TUs4V3pRUys1M1pXcG5uTk9haStxY1Q3aHpL?=
 =?utf-8?B?RUNGbW5SMFdaRm4zb1NjNDhpRUtrSUlTb01jaWJyR3IvK1liU2pyNnNVcCtu?=
 =?utf-8?B?d3RXRmoxMDREWmFGQmhvWEYrTlZjaHpFbkJTM05lSWFHenRoZ0pqbjA4VTdw?=
 =?utf-8?B?VlptZVU0RlQwVjVEbzY1Qmg3T3g1UktWMC9BTU8rVVlxeThHZ1RZbTFwanFi?=
 =?utf-8?B?YnB2WE0xb0ovOHRvWFl4Z3l3ak4yYkdpcmpRbFZ6ZWlFOUZXeHI0NnQzNkNv?=
 =?utf-8?B?T2JkYUttYU9UVnlJRUdKajBJUkVhZ01oOFVjSHRzb25KVTF0ZVJLMzNEVmlN?=
 =?utf-8?B?b1Y0anRzSlJ6ZXZLWWtyQUVlRk5WcnltRUx6aWdicnRLVVQ5VTQ2OG84MDZ4?=
 =?utf-8?B?RVVjSEtXbzBkZkhlNkZpWXk1S2FNZ3NkZE0xaC94dW92NklUQUhqMm4rMXJ5?=
 =?utf-8?B?ZTdUNVVNWXJnRkwya2F3NnJOZkFpN0t6NFdFeUo0ZXNJSzRJdnVrV0dVWXdn?=
 =?utf-8?B?WXFjMnNsM1VmdnV5RlJwUGg4dE12WnZLZmZMUTIra2VZTlAvS1FnS1dseXJV?=
 =?utf-8?Q?0HYmTSgrcj1mi59CDGdwqEOeN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24cf4ad3-1f05-40ea-c4ed-08de1c372665
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 06:47:13.0210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1J3oTIx5mGCaAu86J4QRHnDc6FefWyAdgzMWwmEDwmfIXZ4yWLS7uJX7GYfwaRH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7628
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



On 11/4/2025 1:01 PM, Samuel Zhang wrote:
> On PF passthrough environment, after hibernate and then resume, coralgemm
> will cause gpu page fault.
> 
> Mode1 reset happens during hibernate, but partition mode is not restored
> on resume, register mmCP_HYP_XCP_CTL and mmCP_PSP_XCP_CTL is not right
> after resume. When CP access the MQD BO, wrong stride size is used,
> this will cause out of bound access on the MQD BO, resulting page fault.
> 
> The fix is to ensure gfx_v9_4_3_switch_compute_partition() is called
> when resume from a hibernation.
> KFD resume is called separately during a reset recovery or resume from
> suspend sequence. Hence it's not required to be called as part of
> partition switch.
> 
> v2: switch to use amdgpu_xcp_restore_partition_mode().
> v3: use in_suspend to replace in_s4.
> v4: refined commit message and remove comment
> 
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 3 ++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 4 +++-
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> index 811124ff88a8..f9e2edf5260b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> @@ -407,7 +407,8 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
>   		return -EINVAL;
>   	}
>   
> -	if (adev->kfd.init_complete && !amdgpu_in_reset(adev))
> +	if (adev->kfd.init_complete && !amdgpu_in_reset(adev) &&
> +		!adev->in_suspend)
>   		flags |= AMDGPU_XCP_OPS_KFD;
>   
>   	if (flags & AMDGPU_XCP_OPS_KFD) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index c4c551ef6b87..cbb74ffc4792 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2291,7 +2291,9 @@ static int gfx_v9_4_3_cp_resume(struct amdgpu_device *adev)
>   		r = amdgpu_xcp_init(adev->xcp_mgr, num_xcp, mode);
>   
>   	} else {
> -		if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
> +		if (adev->in_suspend)
> +			amdgpu_xcp_restore_partition_mode(adev->xcp_mgr);
> +		else if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
>   						    AMDGPU_XCP_FL_NONE) ==
>   		    AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE)
>   			r = amdgpu_xcp_switch_partition_mode(

