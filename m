Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA5AC02183
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 05:46:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58BCD10EA53;
	Fri, 17 Jan 2025 05:46:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XphfiYqZ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01F7B10EA53
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 05:46:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eP2+a5RUmr9Tw1JI2ziTfMUfCM31aQsazBwXOPLwmGmvqSzyI1gapV0U1uvc5c6ZdrLNdCdMDNstR4MjslQFgY6T+VyomM4eW/C7TfVk266Mo8YBYKbRd7GMyT2ah6aq4bdbdbyyY8JREatIqATDCefTtZ/k5m+fcGJ/BLcfYwBA2ySwxX3JeOgiBYgz7zikuMV7lDhqnWkmRXYINO2FoOjeER1ozjjBxcvaA+nDHsP8OkYr//ict52Vxav0yY2n6qjlHaifDV5sn3kvFY7EnD1GfumrvuBzYfsKWnIqG8K3YfUMGsngvPRDYkzcpMsyh7Yp6kP0tCo0cmSBar1iWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgRYcZDkUdHZjqQx5WfkbhT0UeGOkHdT1tjztQWeAnE=;
 b=bWY6onTAVT5YLGK2qhYeKdv8dcCy7D5i7jRMd24/pC9iQCvm2jkMo/m0nK7PbTCzscJE9d+OoaK1eWGSk4pgq5JJ7vsFjOMivZaj23K2+/N5lWeyx1TKif3oc7geXxnSuRIrLPh+GhJfMq+AfEzBUk1Q0UpO3S1nE9Bt3sVnCjRcgjqZlpAgk9w/c0WkeGVX3HqCuj6v4p9QRhXZedcl9RxrMLsn3D5xhjp53yQxeocqI4blq7dAj3avcFEwlxU30QbO8f9QB4YCJREanUhD3LtIr4PG18TiN3weRBVJQ8Nbux9Onw7yA6qDpC/sD7+NITYYM8WCV4iHaU4Aey9alw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgRYcZDkUdHZjqQx5WfkbhT0UeGOkHdT1tjztQWeAnE=;
 b=XphfiYqZk+olvb4NhDqXfggtXNAWUXnsxOUVEM3eTwxputJ4ryRJmomxuTwi9LKl+6ZqU9P0zSfzzm5Jy0Ivy1zsfWEbIpo7xiAd/ibcbJWOfLn2ynFnYRW8nLyLvzh224AvA87kUXo+oAAn+ead9b8y7cMiN6JbYoG7TsAMvTg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.13; Fri, 17 Jan 2025 05:46:39 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 05:46:38 +0000
Message-ID: <7f6b8e74-549b-4d8b-98f1-71e8f6cd0578@amd.com>
Date: Fri, 17 Jan 2025 11:16:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 04/15] drm/amdgpu: introduce a flag to track refcount
 held for features
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736732062.git.gerry@linux.alibaba.com>
 <d8db52c680a7c549865dff8143320ebb2df28d64.1736732062.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <d8db52c680a7c549865dff8143320ebb2df28d64.1736732062.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::27) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: b4bc722d-2276-48f0-cf19-08dd36ba4fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NStGZ1BHT0xmZTRWSlp1UkxKWjJ6WEoxMXF2aVNSTktzbHlUaVVCY29mcXpr?=
 =?utf-8?B?TjdhYXM5V0h6ZjZONXNOdE1NTjVkeXpYRUlBamUrY3BPV3M5VGtHcjBYaEpu?=
 =?utf-8?B?bE9KRXdXOXR4UjVqR0gxa3R3TzBDdnJiekVuS09NcmNHWXZzaUJyWHQ0dmZU?=
 =?utf-8?B?aVNyZ0RjODZma1pwZUVNNXVSL1R1ekJHL1A4dmZUd01JYVpTSWpuNkU2R2VF?=
 =?utf-8?B?aWhQR2VkQUQrZmMvOENRd2hxVDRpUkZMOFlhMko4Smh2YlI2WFJYUWt0T01H?=
 =?utf-8?B?Z0xGelpTdXovM3hyK0ZXODNKNndqeGcvOVdHVXZMc1hyTG43V2ZONUZTY0lY?=
 =?utf-8?B?WTUwenNob1R3RnJRUURDVXpKVnhwUVRXc1psMm1mM2FNYjIyZTd4Znl3VzU5?=
 =?utf-8?B?Z3JURXF4cWlPcnVVOS9hNjJ4c2k0eWxzcnZvdEkzK0VXRkVvOUhrcWc1SHlJ?=
 =?utf-8?B?ZXRGdURpMnVOYmtMNC9aSW10cGJIdTRXZW9iWktKWHV5dDJySFF4WlQ1bDhI?=
 =?utf-8?B?LzlxTVBPb3lEOE5BUmFMMzRwaUVTc1FkK0s3SEs2b29qVWhqb0tsTHUveXJt?=
 =?utf-8?B?OUhjNVRtemFaYk5vK3VZRXpuR1B1azFsZ1dQeTBOY0FlM3cvT2IwLzlxVXJp?=
 =?utf-8?B?NDYvUndCT21lTEM3QWRrakZxS2RZK0RvaWx4RnVLS2FZYVlJNHBERitWTDkz?=
 =?utf-8?B?dC9qU3c0Qzk0eTg5R1JpU0xqekpWb1ZFRHFTWlpwK2JRSzdZY2o5SklKRnpW?=
 =?utf-8?B?WkZaakhmVTR3R2pxaGNvZ29GUUtpQTZncGgrd2VsNmY3MTZMSHdaVEZ4Qnhp?=
 =?utf-8?B?RDgvL0szTjFFUFBpempiQ2FpVUpkME03L0J0eVpIM3BLbUNmRlZaRDhtR2FX?=
 =?utf-8?B?ZmU0TFpveEJIRzB1Z1prQUFoUWlzYWJDQUlyZFJwL1Z5SkRJc3FhOXdzL2FB?=
 =?utf-8?B?aE9MMGFOckRrUFZkcjFiYU5tNWMzUDM2ZVFsTFoyYktGSzdzNkZydlpzWVY0?=
 =?utf-8?B?Y3FhL0R0QlNGK1RlZXNCa2Nab3MzaHdIZnE0d3VjQlJaQmhIN0JmVk9TMGFN?=
 =?utf-8?B?MTJpaUl4UVRUdHhpelQ3M1Q5WDNXTk5acDFkUzhZRG9BUGE1Zld2dE13QVVT?=
 =?utf-8?B?M1d1SjBGS0ovWHcycVNmS1lJTHdlYnFERG1xaGlnQ3dKWXViR0N6WEhGbEl2?=
 =?utf-8?B?YkJ0TTFZdEIzVG5HMXFwc1JCaXFFNTl6S3NZR0c2YU9mZmdIRm9OVHBQYmxS?=
 =?utf-8?B?UzRvTGFqZGh5K1ZycFFPMVZ2MCs1NzBkSjd6TzBjcTVCd1R3S2pWUHJ6YlZh?=
 =?utf-8?B?MnptWjdEL243Z2lPZVdVbWRrMnFDN0FsTmhEQkp2MzRHdzFRNkVpTmdHVSt3?=
 =?utf-8?B?Y1RncUJjSUtmWWc4THJCMUk2R2xtTVpvV3d1L3hKRE03TTlZMFR0MnM5OWE2?=
 =?utf-8?B?RUovaGxrK2FXSU9xL2QxRnV0a2xuaWRXaHowTEdxY2c5TXhTL2JocUJxNFdO?=
 =?utf-8?B?b3ZaeU9vbDBzZ2F3V0c5enRodzdkSGsxbk5EOXBEQ2I5cERFSDdtQ21RUkNX?=
 =?utf-8?B?ZXNxV3FKcmV2amtjdjFvNWFWU0h0Q1dXdlhTMjQ1dzBZNGhidFRlY1g1OXI4?=
 =?utf-8?B?NVFzK2RYZTc3Y2JiQzNCa0g5QktXQ2ZQczdkRURzd0J6eHBNZU93WmlYYk04?=
 =?utf-8?B?YlAxVlNmRFlCMnlkSzBsdVJNTW95c0I4ek9aWDdJNld0cFlrZnFnRkhlQ2xP?=
 =?utf-8?B?SDdrbENnREYxZDZNRW1iWVdhWVpYUmlNMThHR2wyQkNUVHBQa2FNZzQrS2Iw?=
 =?utf-8?B?NWxyK0tVUWJ3bHZ2Wm5WRk5YdFEweDRLYk9XUGtPd0pjdHpEa0lPOVpjRVVE?=
 =?utf-8?B?azdMVHNKS0IzVDZSNEVYSXlGRlBNUkt2K3hYZEFZZFRuTEdFcFdMbnYvK3N3?=
 =?utf-8?Q?lIoxrfP7FT4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWtKaEg5TERnZ2dzUDEwRHZORzlHZXVrQU5QZ1A5Mmpta3plVlFKSEhXakRt?=
 =?utf-8?B?amgwTUYxUnd4RFR4Wm9OM3JTcm8wUmRSOHl4RllHd25GZzJIWHJXdnV5bEpu?=
 =?utf-8?B?VmpnODNnUmx6bllCOEZmU3E5aWQrcFYvbzBLcXhKaGVaWHdSeHBCY21qQzRR?=
 =?utf-8?B?WFkwRnh0c1hlZWJJNnJoOEZEajFFdy9ac0hpd2RmOThrWlN0ckVhWEcrNytC?=
 =?utf-8?B?YVFWOGplNGdXSWFJZXBqZyt3eE9nZzF6NHhhL29FelZOenAxdzJkMXlmY29O?=
 =?utf-8?B?c21mei9wM2VaZW1iRlkxWFM1WkE4ZTA2QjdlL0FCNndBWE00QXBleEJwS1A0?=
 =?utf-8?B?OE0xWUMxQUFja0R2WGRYMXZIWCtuaWdBUHBVKy9kUE8yVElwb0pQZnExYWJP?=
 =?utf-8?B?OVp4ZWF4T2xFRFZ5eUxLUjFDYjh5eVFTaHpLajZLckIwcEJoT3FKcG5VR01I?=
 =?utf-8?B?ekdjbW5vSUZYRUdyVEFsWWhqWHprS1NwVjVBbngxUHFjMGFVQmx2T0F4K2FK?=
 =?utf-8?B?M015djRpVUc5ajRzTXFwQy9jSHlYUDdheWpCVUtDYkEyWlRPdUhSaEFDYy9i?=
 =?utf-8?B?MlZ0dVIrVjdmdXpscCtmc3hzSitrM0dOV2FaMDNnUnRQWjBUeHIyMVNielpR?=
 =?utf-8?B?bjQvRjlHZElLQWZLMWRPYituNzhiellKUmtqK1hqU0hTZ1Z1UGNhdEhlYTkx?=
 =?utf-8?B?S2R3TFN1bzk5ZG81OWxOazdLOVRjNkNNYWRTNS9oMG1HT3NzRUc5T01NMzZk?=
 =?utf-8?B?cW1MRVdOclU5Y1kvaTU1enBiUnlRSVk4SzlwRFhaeExvSTBReEsramFqdUIv?=
 =?utf-8?B?dnRuazA4NlliSVdDWkVnV2c3NDgxYnNkTWlYRjNsZUNVaUtBcVZHakxlWk9w?=
 =?utf-8?B?ZUlYOURLKzdRV3A4QnFuSXkxYjRtaTVOUWlibWJIcEZ6T1h5RDdGK3NRZjVL?=
 =?utf-8?B?SXpXQmM2bk9ZTlhWS01LYXpYVkl2Vm9nLzRQZm45cEJUQmUxUjhRbEE3Z24z?=
 =?utf-8?B?TjIycXIzSHUyWDdOcitLcWQzRWYwVkMzaXhTOVRPUFZnbXZ3TnYzNHd0bGVO?=
 =?utf-8?B?OElHQ3B2bXpKSkVsK29XbjYvWS85MWtBanpIaFM2UDU3MGNTcEdQSDBldzZC?=
 =?utf-8?B?Unpsa003K0x1N0RQVHNDZmk5NEZxcTNiZjRpRE1nNjFyeXpyTXlnVnIyeHk5?=
 =?utf-8?B?aVpaVE9PNHlLMWczZ016QW1MTnovQ2thdFRzSkhuWDZlOU44eUFVbllrQkZy?=
 =?utf-8?B?K09CekNsc0l4NUFBUVBvRWJNTVUzWk4rMjJ3WXZ0WWJjVmNPWGtBbkZ4N3d5?=
 =?utf-8?B?YU9BaWhjZFozYjAzMXlRREx0YjBNWEplWXlLU1RPak5ERVRrYmVLdzJNdEVs?=
 =?utf-8?B?VG0xTnVWUmxxNHhVS0ZpKytxY2xXc2p4NUhubHRNK1JTUnluRUU1ZFIzeGJS?=
 =?utf-8?B?bU5uVEY1Wm91dG1qSUluV2J0UjdUcTdJTDNRYVY5eks1NUNkOUliSk96Vlpl?=
 =?utf-8?B?aVRlOFlhYndUUi9kbzZkaVZ6ckNOZXVjL3B5ZitmSXNHcFhkOWVQOGRJa2cz?=
 =?utf-8?B?RkFaTHk3dEVxR2VJb2Ria1ZsZGpCZDVhNkIxQStuRmFwQjB1SGhZckJqYjlU?=
 =?utf-8?B?ckhRM21FUFE3eEdOMUNKVlFjNTVwY1RBL3JBVSsxWWh2VlZ5clg2YjkyMHBt?=
 =?utf-8?B?RFR1dmZDWHk3c04rQy9lVm1RRVVhV0gxeW5nc1VWTEc2dUxtVlljZ3NOVjJO?=
 =?utf-8?B?ZTZrZVBwRzNVa0J6L2V5R0o5VmJWaGdTZmZvZEpXdEtiZG1OUjRSWm9WU245?=
 =?utf-8?B?SDRHeENKTFdPeDdaWG9lL29WWk1JWHdiaU5uUTJjZTdNQVZic2ZQSFAxNDJU?=
 =?utf-8?B?VHgybGxnY2tYcFAxL3M0QUVuTHl6dk55eTV0T1pZYWliOWZMNWNwc1ZGcHJS?=
 =?utf-8?B?eHhVcVIvVDUvN1o5d1IrcUd1dytJRkNFUStNblFGN1Z0M0lSOUNDdW5lNnlS?=
 =?utf-8?B?bGRZanVsenNsMGxFNmw0SnBTTGZtMEd6MFlnOWxGWnFCRVZCT3RyMWdPOThD?=
 =?utf-8?B?bDNIS0U5dG1qa1VBcEg4c2lKUDAraDJoVy9BL1A0eG9mbFRhQ0FTbENveElx?=
 =?utf-8?Q?UsXIsZSp7XybP/mmoblsPRkqI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bc722d-2276-48f0-cf19-08dd36ba4fa3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 05:46:38.7561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vdpd5iIZxXoikAvdyJcH6VSUBYbj24X5i1+574V4ewbAHimL5X+NI+CpxCnSxci
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7290
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



On 1/13/2025 7:12 AM, Jiang Liu wrote:
> Currently we track the refcount on ras block object for features by
> checking `if (obj && amdgpu_ras_is_feature_enabled(adev, head))`,
> which is a little unreliable. So introduce a dedicated flag to track
> the reference count.
> 

Please clarify more on this. I see  con->features available to track the
status.

Thanks,
Lijo

> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 +++++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 09b63a622728..24ef39b706e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -380,6 +380,7 @@ int amdgpu_ip_block_resume(struct amdgpu_ip_block *ip_block);
>  enum amdgpu_marker {
>  	// Markers for ras blocks.
>  	AMDGPU_MARKER_RAS_DEBUGFS,
> +	AMDGPU_MARKER_RAS_FEATURE,
>  	// Markers for IRQs, used for both ip blocks and ras blocks.
>  	AMDGPU_MARKER_IRQ0 = 32,
>  	AMDGPU_MARKER_IRQ1,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 6b508a9b1abe..f0cd14ff78a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -775,15 +775,20 @@ static int __amdgpu_ras_feature_enable(struct amdgpu_device *adev,
>  			obj = amdgpu_ras_create_obj(adev, head);
>  			if (!obj)
>  				return -EINVAL;
> -		} else {
> +			amdgpu_ras_set_marker(adev, head, AMDGPU_MARKER_RAS_FEATURE);
> +		} else if (!amdgpu_ras_test_marker(adev, head,
> +						   AMDGPU_MARKER_RAS_FEATURE)) {
>  			/* In case we create obj somewhere else */
>  			get_obj(obj);
> +			amdgpu_ras_set_marker(adev, head, AMDGPU_MARKER_RAS_FEATURE);
>  		}
>  		con->features |= BIT(head->block);
>  	} else {
>  		if (obj && amdgpu_ras_is_feature_enabled(adev, head)) {
>  			con->features &= ~BIT(head->block);
> -			put_obj(obj);
> +			if (amdgpu_ras_test_and_clear_marker(adev, head,
> +							     AMDGPU_MARKER_RAS_FEATURE))
> +				put_obj(obj);
>  		}
>  	}
>  

