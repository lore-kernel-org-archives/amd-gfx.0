Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B41E7716C
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 03:36:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3107210E44A;
	Wed,  4 Dec 2024 03:36:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tvY7Yjm4";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2F8D10E44A
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 03:36:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vn+qmZqNoHYPlm78JkKKNWMhLoO31sNRUszj4pLRJElIFOaHlP03psK+5MyjejvA41YXTaDuy0JM+Eaim2CJt77HMyQJR/W1bblwy5PA9a0z3+LRVlIhf4csMvNzRX/8wEusdiIASWBkoAkxg9oXn6z+MDM99jh6tMjOLnu6nQfsDB/dfBV/lYKzop4O0vGmuVZeVOj6CpZrpA4d8h8Ckk2ZkRSttLzE/9LRaKPT95AewruVQaVwaJ8Igo0UYDFhco0vMBU4PeoWb5oKnuyCEJMAc/C04wYPbqQQ/wkqiZqP2XF/BrQTC17ghi7uPOckEWjsISENR0hURzF+wBgXwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBJuKQUemvWyhfpGu8P3VPBV167siAnxoLrwOYlAfM4=;
 b=M0mKQjq2TwZSpw8/8mJy0t1YxoUH3kAR5eRyc6JkIgvgkBybMNh38ri4GW93lfJntZ5kS20uukzSLCMHQrBdpiPQfHpCwQsk23MclX327FwwU4B8YRacsVoSJ1+7pQaDJlAcm9u5hQapgp456fC+y85EEjJmzoUzvTzTIS+aJ75xECgSFaUieHuoejFdDt3vQWYqt4j+8iBl5sbS1wvJGo+hAKTjVYU0NEIOykQ6oW6Hh8ryUuBooG/GhwXzNXq0JjIeuyav/JyFecdGSeR8sSPsGzfxPRbOOf6uJ9+Kxd0HZhFogzx7A6IR1UcOUfoo1sUFBNwhylDCwchTdmUaBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBJuKQUemvWyhfpGu8P3VPBV167siAnxoLrwOYlAfM4=;
 b=tvY7Yjm43qxVYzFZA5gClMYYeDN0Coo+IgzYVvGiEYIdO7q49yfXjmMDhKt+gaBLRKxAtVtKvwv97pvpLg9pOGfDpmRiSOdFLdY4Q6kvascOMOV88nnSk+N4WL/RPJvqnitEFD4/Pz3LPMnzPVqiWlSkl62vlBk/Dt97qgrXj7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.18; Wed, 4 Dec 2024 03:36:06 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 03:36:06 +0000
Message-ID: <e8ae8d63-44d5-4e77-818f-67cf69d0c8b7@amd.com>
Date: Wed, 4 Dec 2024 09:05:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Add the capability to mark certain firmware as
 "required"
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20241203181403.23515-1-mario.limonciello@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241203181403.23515-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0185.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::12) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: fb30db9b-ec37-48d3-269f-08dd1414c85e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWd3NUc0aVJlZE51cTUyR2YwWlI0Qi9MK0g4UGFkWlBEcExORDFxQktGaTFK?=
 =?utf-8?B?dnp1ZlhWaDJtbVcxSHNQZ282Zk9qZ21wU3VwSWxNb2tvVnlaMmV0QVZCdUlU?=
 =?utf-8?B?S0pDVGNxR3VIVWduSWhFenZQQ1Zja0Z5TFc1TnNsYVpVaFM4MTg0VXVSK2Zy?=
 =?utf-8?B?R3cvQjZLZGQ3ZWhLVTh0YW95VlowSUhmQVRUc1YzOU9SalMrNUJjcDBvT2d6?=
 =?utf-8?B?ZG5PTE5oRlB5TE9JNFdiNitja0JtMmdEUmJKRlhKd0FXaWE0L3pJU2FGem9t?=
 =?utf-8?B?dUMxT3RKamk1RVJNZDJTTGNjT0dlR0srcXNub0ZPWVIrM1hkZndhQVF4Y1ZL?=
 =?utf-8?B?SVZJL0JHbHNYZmhORlRLN2JROGtTWW9iVDU5R2FhcFE1NVh6T3FtYmE1Rytq?=
 =?utf-8?B?S2RWWEdjaE9DN0IycUlKQ3VjRkRVMEJZYm5IZ3k5QmJjN0Z6djNNQys1Szds?=
 =?utf-8?B?Zzc2TldoOGFyVk02MzJDY1dOWHpGZHhNbURxeTdkSEFjMzdUNnIrdFFXaDZq?=
 =?utf-8?B?NTlNMmNZRVJyVGZOa3pQeDY2aFYzd2ZJTkF0bzFNOE95MGw5M3ZudFJUZVQw?=
 =?utf-8?B?LzZhQ0x3OUlTZTFUSE1oRXJUSlcrSys4ZFloeHhWQnZWbzNzcEtUTktma0dM?=
 =?utf-8?B?K1Zjck9ZSzdJSlZMOVloOXM3TkxZNGtVNkFZTHNWWGpZMUt6SE9RWW9TM3lj?=
 =?utf-8?B?aCsyVFhsTWtRRVBKWDh1cG9nd3o1TklKLzFOZWZ6MmUwbURVVmdMT293K0lI?=
 =?utf-8?B?TUE3V3dSTmVyWE5qSm1mY21yMlg0NUlkQXhtMml0ODdtc21GdHRmYUUyMUJC?=
 =?utf-8?B?eEJ4Rkt5VGlRSXljSGd0Tis3N1FCemlNaHlZWlNXVnIvY1c3QlBTVFhzTTI2?=
 =?utf-8?B?OGIyaHZmczRiWFB0SWNYNk5aSHJFRWwwY09GNmhkRDdxcnF0RWU0ZDRiVlZR?=
 =?utf-8?B?NnJNZEdteWlaVE9kczN2UDQrLzlWaDQwOXpmdmpKWHh6aXdDY3pBU0RMNzJM?=
 =?utf-8?B?cjUyMCtEVnE5c2VaeFVpeWRSNTlrY1FCQWR0dXJYcTYxSFNzeGhKVDdtb0Zo?=
 =?utf-8?B?eXJQbjlKOCttTnpicVUwK084eWV3NkJZdm9uSUVudHhFVFJkSmdtcGxpb3RQ?=
 =?utf-8?B?eHZ6U2dtZFUrbXZmc1E2Z1FCbThxUUhUeWNhdzR1VTh6MDVER1p1ZjVLQk9W?=
 =?utf-8?B?cXN2eTFFQkRMbHN5dE9qS1M0Z0NiMTlUaXhpbFN6SmNOTHFBaUtuMkxKWUVD?=
 =?utf-8?B?YmZDaWxiZUVoRUhBRExaeDE0cE9xZ0ozcDQrTXJwaktTSGMrODllb2EyT2d1?=
 =?utf-8?B?U2p4U2k3WDBiaVVsU2RqY0poVnZ5QWhQS3N6ekk5OUY4QkxvcUoyektxcUJI?=
 =?utf-8?B?YysxSk5uRXpwSnNucHFCdWc2OTNBMGlkRG1NR3luU0Rjc2RXTnpIWWpiTzdT?=
 =?utf-8?B?MGwzQXJOdGNSNUJMWndOanJLRTFjVldiakNNejFyVG55TUxyR0xvcDZzMTRw?=
 =?utf-8?B?d2o4U1FUNXV0VE8vUWhzRENGcTFvbmI3dnRjMHVORjVERGZHcnVVYTBBZFhS?=
 =?utf-8?B?N0owczJadXRCNnZxMW5Sb1N6QWFDQ0JZb2VveEhzNVNTVFM4bnA0aTlxL2k5?=
 =?utf-8?B?b2hWbnRtZTNQbFNzNUdpcFEwUTFueWMxckZaUnRlVmhkN1RVWjRDQ0NkV3E2?=
 =?utf-8?B?K3J6UVZJV2hvbnFlU1BDZW54ZkNnMEU0YWhHVE5rYWRuc1NhN1YxcVlhQ2hp?=
 =?utf-8?B?VDI3aTlybktBbEIrZlZuNVNPVkxmNk0rTmo1cU8zVzhXRHo0K2pRODgvRTFL?=
 =?utf-8?B?OThwdFZBMmhld1cyN2padz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFZQdzVNSUpLSWhJdTFGTkp2L1ZXL2FWMjhjaWtOUzNjbU52SC84dU5jaGF6?=
 =?utf-8?B?YlNIVHRGSUxKa1dhUENUUUQ3SUZwemduU0R4R1BvNHRnY3c5ZjdHMlV5akFy?=
 =?utf-8?B?LzdhTmIyWmlIbWtqR3pGYURsak1QdDlielo3aC9WdFFraXRlSjRaK21CY1Yv?=
 =?utf-8?B?QXp5b1ZtTHhDNUxLbzlkeHRCVW9wbnUyZno1ZFhZNHgzYXJqMUZ5M2kyL2h0?=
 =?utf-8?B?K0JRQk9xWlN6NDBvUG03YTVoaWxHVWk3bnBTdmE2ekowby9OcGdOZ1NzZXZ3?=
 =?utf-8?B?RVp3TkNnT204RTJ4RlJRdGIxL0dlMytsN1VVL0xycExOQnJIczhIM3NmUWRP?=
 =?utf-8?B?cGRPYnVKci9Hd053ZXlVNDNaS0czMTJlcklZNi9GZzhnU2c4RTJXdmRKQlox?=
 =?utf-8?B?ZUtQYnFtNit6YjVicWYxd2ZmanpzK3MyZHlidWdiRVh3TlFBaURyM2xyUzZW?=
 =?utf-8?B?d3lSWUErVGlvbEttVHZkY2paUHVCZ2JVaUlGbXZvRUJYdUlBdlozYWlXbjB4?=
 =?utf-8?B?VWxiY2R1SzVQTDdhNDBPZjlKMHJmaC9WeVJaNmxXaGM3Qy9GbUR4TFVCVGoy?=
 =?utf-8?B?THZ2aXVHcEFYMzBaZUp4U0RlY3UwZFF2dnBENFdxc3plTFNIUHdsWjNHTVhS?=
 =?utf-8?B?aXpXOFNzY1piWmhqN1NtSHMvdzFxNWFxK2NUdHZoMnNGdStzQ3dUTWtnbFZI?=
 =?utf-8?B?Sy9wQUw5NjdPYS9ucE9jWUtKL0tYeDNwWkt3cFg4dU5oaERDMUZOdjgxMU9H?=
 =?utf-8?B?bDF4QWM2L3dtRy94TXZCNTFhMkJSdnBiMmJ5bG5ScVNBcnlnMWF3eHlIRjFP?=
 =?utf-8?B?aWx0dkc1a3E1VlVVVnp0NEVSendFcDd5d3hhc2FNaU92NDRUbVFBSUwyeW5L?=
 =?utf-8?B?akVSUzlEMm5lRjFtQXZWWUF5T2Y0NFYwbmtTd1N4Y0wvWFhzMUp0MDhJYU9o?=
 =?utf-8?B?RTF6Szk4MjdPZ3RIcDVnVWRxbXY5R2dYTjJiamVacjl4VjNrL1R5aExNc2pj?=
 =?utf-8?B?OVZCSnBjKzJyQ1lrV0lLeUI4ZnIrWlZZY1dINmJUUWRQU2NaSGVYYkRHalBu?=
 =?utf-8?B?V2hRZkgrd1kzelpoNDZOQlFPRW1jNFhuWDJ3Q3hJYVV5MVZSS2VKcUdKRkxF?=
 =?utf-8?B?bkFnb2k2Ui9UU0dnM0J6czdKazhSVzZaRnJkR2p0RkRTRlBralJIZTJrYzRT?=
 =?utf-8?B?THJJRldKMjFUSWRsZ0hweEx1QWRGMDg2UlY0akZJQ2d3Z0xEb2c0L0ZJWVBG?=
 =?utf-8?B?UDltbWlDdFdxVnRpNUFxU21NMFh4SHUzbGxBV3VCemM5MlJETnR3Y2RGZWFQ?=
 =?utf-8?B?RHFKTmhqZlB1RHNzaERvMWFZaCtTMzNPTW1EUXhMSkZFdXRGOUJBMWM0cEVK?=
 =?utf-8?B?NXlRWm5IdnBJUHhINGQ2TXZIY2hPZTZ3eEtLd3kyMVRkL1JiUzNIaHkxUS9L?=
 =?utf-8?B?MWhsaW1NR20zTTZ5QnVlT3pZV1dPTERhOXZLYUYxQzBSTHRRMU02cEZwbE1s?=
 =?utf-8?B?S0ppbERTSEVZNVhIVTdvdG40QTNzQXhFNTFHS1RYdDVwWVZjVGppNGNMTG40?=
 =?utf-8?B?VHJaRjdSMkhFa0t1c0FZRXZ2a3Q3bTltUEJXNHpLSjJ4Y005V1FYQ2FpeU10?=
 =?utf-8?B?ODBsTjFxWjNPcXk1MUtrWFU1Qlo5QTNtU25pSjdUbFRPTGhTZno5REpIeW9m?=
 =?utf-8?B?VThCUGlRQXJQdVM3RXFsVnVzSWo0aHZqM0dNR2VYUDRJb01tWlJTK2h1NzRU?=
 =?utf-8?B?WlVUaGZYYjE3OHR6NllZWElpdklZdzdUOTlqWGxiTmNGclQxSmErY0ljZExN?=
 =?utf-8?B?R2xNMHYwTVZFRi9obTVLOVR0Rk1tUkRVWkN3WG1rMTFOdXpMRHQ0bWxwZ3JK?=
 =?utf-8?B?M3pLeVhDdU16OERTQS8wL1NiWnRaTE5rd3d1b2NsazR3amREbFZQWWNWMk5D?=
 =?utf-8?B?NFRoSjR0TGF1RzNxaWl3ZEJQeXBwUSszcjZ4SEs1b1ltRFgwVlVJd2VhSE0r?=
 =?utf-8?B?ZEgwNlFidGZRUGh1TEZpSnJTMC9QQTZrKzBpY1VnOFhJZWlBeENRenhoSmVM?=
 =?utf-8?B?c3YrZkdpYlFlQWpvT28rcUlObEtnOTh4MFZqSFBPL1pZeXR1SjNpYkFFSnhL?=
 =?utf-8?Q?8zhZrm9qT3k8E4m+/EvODsTxI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb30db9b-ec37-48d3-269f-08dd1414c85e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 03:36:06.4190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d295NeYrXL/z8OMANXxzloYWg+iTAi1BtTTEe8GBlw5NxAlgji4UfFHlNl48zqXo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8599
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



On 12/3/2024 11:44 PM, Mario Limonciello wrote:
> Some of the firmware that is loaded by amdgpu is not actually required.
> For example the ISP firmware on some SoCs is optional, and if it's not
> present the ISP IP block just won't be initialized.
> 
> The firmware loader core however will show a warning when this happens
> like this:
> ```
> Direct firmware load for amdgpu/isp_4_1_0.bin failed with error -2
> ```
> 
> To avoid confusion for non-required firmware, adjust the amd-ucode helper
> to take an extra argument indicating if the firmware is required or not.
> 
> On non-required firmware use firmware_request_nowarn() instead of
> request_firmware() to avoid the warnings.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c        |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c        |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c        |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c        | 18 ++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c       |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c      |  8 ++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h      |  9 +++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c   |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c        |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c        |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c        |  8 ++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c        |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c          |  2 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c         |  5 +++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c         |  6 ++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c         |  5 +++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c          |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c          |  6 ++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c          | 16 ++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c          | 12 +++++++++++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c        |  7 +++++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c          |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c          |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c          |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/imu_v11_0.c         |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/imu_v12_0.c         |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c         |  2 ++
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c         |  2 ++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  6 ++++--
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c     |  3 ++-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c |  3 ++-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c |  3 ++-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |  3 ++-
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c |  3 ++-
>  35 files changed, 136 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
> index 16153d275d7a..68bce6a6d09d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
> @@ -414,7 +414,9 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
>  				return -EINVAL;
>  			}
>  
> -			err = amdgpu_ucode_request(adev, &adev->pm.fw, "%s", fw_name);
> +			err = amdgpu_ucode_request(adev, &adev->pm.fw,
> +						   AMDGPU_UCODE_REQUIRED,
> +						   "%s", fw_name);
>  			if (err) {
>  				DRM_ERROR("Failed to load firmware \"%s\"", fw_name);
>  				amdgpu_ucode_release(&adev->pm.fw);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 16b9b3c4190c..83f0de30317e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2483,6 +2483,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
>  	}
>  
>  	err = amdgpu_ucode_request(adev, &adev->firmware.gpu_info_fw,
> +				   AMDGPU_UCODE_NOT_REQUIRED,
>  				   "amdgpu/%s_gpu_info.bin", chip_name);
>  	if (err) {
>  		dev_err(adev->dev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> index d52f18393970..56cc179fca26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> @@ -77,7 +77,8 @@ static int isp_load_fw_by_psp(struct amdgpu_device *adev)
>  				       sizeof(ucode_prefix));
>  
>  	/* read isp fw */
> -	r = amdgpu_ucode_request(adev, &adev->isp.fw, "amdgpu/%s.bin", ucode_prefix);
> +	r = amdgpu_ucode_request(adev, &adev->isp.fw, AMDGPU_UCODE_NOT_REQUIRED,
> +				"amdgpu/%s.bin", ucode_prefix);
>  	if (r) {
>  		amdgpu_ucode_release(&adev->isp.fw);
>  		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index a67e6a52347f..bb946fa1e912 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1438,10 +1438,12 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
>  			 pipe == AMDGPU_MES_SCHED_PIPE ? "" : "1");
>  	}
>  
> -	r = amdgpu_ucode_request(adev, &adev->mes.fw[pipe], "%s", fw_name);
> +	r = amdgpu_ucode_request(adev, &adev->mes.fw[pipe], AMDGPU_UCODE_REQUIRED,
> +				 "%s", fw_name);
>  	if (r && need_retry && pipe == AMDGPU_MES_SCHED_PIPE) {
>  		dev_info(adev->dev, "try to fall back to %s_mes.bin\n", ucode_prefix);
>  		r = amdgpu_ucode_request(adev, &adev->mes.fw[pipe],
> +					 AMDGPU_UCODE_REQUIRED,
>  					 "amdgpu/%s_mes.bin", ucode_prefix);
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 12832fd834fb..3043ec5d3a31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -3290,7 +3290,8 @@ int psp_init_asd_microcode(struct psp_context *psp, const char *chip_name)
>  	const struct psp_firmware_header_v1_0 *asd_hdr;
>  	int err = 0;
>  
> -	err = amdgpu_ucode_request(adev, &adev->psp.asd_fw, "amdgpu/%s_asd.bin", chip_name);
> +	err = amdgpu_ucode_request(adev, &adev->psp.asd_fw, AMDGPU_UCODE_REQUIRED,
> +				   "amdgpu/%s_asd.bin", chip_name);
>  	if (err)
>  		goto out;
>  
> @@ -3312,7 +3313,8 @@ int psp_init_toc_microcode(struct psp_context *psp, const char *chip_name)
>  	const struct psp_firmware_header_v1_0 *toc_hdr;
>  	int err = 0;
>  
> -	err = amdgpu_ucode_request(adev, &adev->psp.toc_fw, "amdgpu/%s_toc.bin", chip_name);
> +	err = amdgpu_ucode_request(adev, &adev->psp.toc_fw, AMDGPU_UCODE_REQUIRED,
> +				   "amdgpu/%s_toc.bin", chip_name);
>  	if (err)
>  		goto out;
>  
> @@ -3475,7 +3477,8 @@ int psp_init_sos_microcode(struct psp_context *psp, const char *chip_name)
>  	uint8_t *ucode_array_start_addr;
>  	int err = 0;
>  
> -	err = amdgpu_ucode_request(adev, &adev->psp.sos_fw, "amdgpu/%s_sos.bin", chip_name);
> +	err = amdgpu_ucode_request(adev, &adev->psp.sos_fw, AMDGPU_UCODE_REQUIRED,
> +				   "amdgpu/%s_sos.bin", chip_name);
>  	if (err)
>  		goto out;
>  
> @@ -3751,7 +3754,8 @@ int psp_init_ta_microcode(struct psp_context *psp, const char *chip_name)
>  	struct amdgpu_device *adev = psp->adev;
>  	int err;
>  
> -	err = amdgpu_ucode_request(adev, &adev->psp.ta_fw, "amdgpu/%s_ta.bin", chip_name);
> +	err = amdgpu_ucode_request(adev, &adev->psp.ta_fw, AMDGPU_UCODE_REQUIRED,
> +				   "amdgpu/%s_ta.bin", chip_name);
>  	if (err)
>  		return err;
>  
> @@ -3786,7 +3790,8 @@ int psp_init_cap_microcode(struct psp_context *psp, const char *chip_name)
>  		return -EINVAL;
>  	}
>  
> -	err = amdgpu_ucode_request(adev, &adev->psp.cap_fw, "amdgpu/%s_cap.bin", chip_name);
> +	err = amdgpu_ucode_request(adev, &adev->psp.cap_fw, AMDGPU_UCODE_NOT_REQUIRED,
> +				   "amdgpu/%s_cap.bin", chip_name);
>  	if (err) {
>  		if (err == -ENODEV) {
>  			dev_warn(adev->dev, "cap microcode does not exist, skip\n");
> @@ -3909,7 +3914,8 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
>  	if (!drm_dev_enter(ddev, &idx))
>  		return -ENODEV;
>  
> -	ret = amdgpu_ucode_request(adev, &usbc_pd_fw, "amdgpu/%s", buf);
> +	ret = amdgpu_ucode_request(adev, &usbc_pd_fw, AMDGPU_UCODE_REQUIRED,
> +				   "amdgpu/%s", buf);
>  	if (ret)
>  		goto fail;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 113f0d242618..b3c032f249f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -219,9 +219,11 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
>  	amdgpu_ucode_ip_version_decode(adev, SDMA0_HWIP, ucode_prefix, sizeof(ucode_prefix));
>  	if (instance == 0)
>  		err = amdgpu_ucode_request(adev, &adev->sdma.instance[instance].fw,
> +					   AMDGPU_UCODE_REQUIRED,
>  					   "amdgpu/%s.bin", ucode_prefix);
>  	else
>  		err = amdgpu_ucode_request(adev, &adev->sdma.instance[instance].fw,
> +					   AMDGPU_UCODE_REQUIRED,
>  					   "amdgpu/%s%d.bin", ucode_prefix, instance);
>  	if (err)
>  		goto out;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index d3cd76c6dab3..ffbb3377e0f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1434,6 +1434,7 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
>   *
>   * @adev: amdgpu device
>   * @fw: pointer to load firmware to
> + * @required: whether the firmware is required
>   * @fmt: firmware name format string
>   * @...: variable arguments
>   *
> @@ -1442,7 +1443,7 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
>   * the error code to -ENODEV, so that early_init functions will fail to load.
>   */
>  int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
> -			 const char *fmt, ...)
> +			 enum amdgpu_ucode_required required, const char *fmt, ...)
>  {
>  	char fname[AMDGPU_UCODE_NAME_MAX];
>  	va_list ap;
> @@ -1456,7 +1457,10 @@ int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
>  		return -EOVERFLOW;
>  	}
>  
> -	r = request_firmware(fw, fname, adev->dev);
> +	if (required == AMDGPU_UCODE_REQUIRED)
> +		r = request_firmware(fw, fname, adev->dev);
> +	else
> +		r = firmware_request_nowarn(fw, fname, adev->dev);
>  	if (r)
>  		return -ENODEV;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> index 4150ec0aa10d..827d75185d83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> @@ -551,6 +551,11 @@ enum amdgpu_firmware_load_type {
>  	AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO,
>  };
>  
> +enum amdgpu_ucode_required {
> +	AMDGPU_UCODE_NOT_REQUIRED,
> +	AMDGPU_UCODE_REQUIRED,

Couldn't this be handled in another API instead of having to flag every
load? By default, every ucode is required and if optional may be skipped
with amdgpu_ucode_request_optional() API?

Thanks,
Lijo

> +};
> +
>  /* conform to smu_ucode_xfer_cz.h */
>  #define AMDGPU_SDMA0_UCODE_LOADED	0x00000001
>  #define AMDGPU_SDMA1_UCODE_LOADED	0x00000002
> @@ -604,9 +609,9 @@ void amdgpu_ucode_print_rlc_hdr(const struct common_firmware_header *hdr);
>  void amdgpu_ucode_print_sdma_hdr(const struct common_firmware_header *hdr);
>  void amdgpu_ucode_print_psp_hdr(const struct common_firmware_header *hdr);
>  void amdgpu_ucode_print_gpu_info_hdr(const struct common_firmware_header *hdr);
> -__printf(3, 4)
> +__printf(4, 5)
>  int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
> -			 const char *fmt, ...);
> +			 enum amdgpu_ucode_required required, const char *fmt, ...);
>  void amdgpu_ucode_release(const struct firmware **fw);
>  bool amdgpu_ucode_hdr_version(union amdgpu_firmware_header *hdr,
>  				uint16_t hdr_major, uint16_t hdr_minor);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
> index bd2d3863c3ed..dde15c6a96e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
> @@ -587,7 +587,8 @@ int amdgpu_umsch_mm_init_microcode(struct amdgpu_umsch_mm *umsch)
>  		break;
>  	}
>  
> -	r = amdgpu_ucode_request(adev, &adev->umsch_mm.fw, "%s", fw_name);
> +	r = amdgpu_ucode_request(adev, &adev->umsch_mm.fw, AMDGPU_UCODE_REQUIRED,
> +				 "%s", fw_name);
>  	if (r) {
>  		release_firmware(adev->umsch_mm.fw);
>  		adev->umsch_mm.fw = NULL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index 31fd30dcd593..30e9869a0584 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -260,7 +260,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>  		return -EINVAL;
>  	}
>  
> -	r = amdgpu_ucode_request(adev, &adev->uvd.fw, "%s", fw_name);
> +	r = amdgpu_ucode_request(adev, &adev->uvd.fw, AMDGPU_UCODE_REQUIRED, "%s", fw_name);
>  	if (r) {
>  		dev_err(adev->dev, "amdgpu_uvd: Can't validate firmware \"%s\"\n",
>  			fw_name);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index 599d3ca4e0ef..65387f6943b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -158,7 +158,7 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
>  		return -EINVAL;
>  	}
>  
> -	r = amdgpu_ucode_request(adev, &adev->vce.fw, "%s", fw_name);
> +	r = amdgpu_ucode_request(adev, &adev->vce.fw, AMDGPU_UCODE_REQUIRED, "%s", fw_name);
>  	if (r) {
>  		dev_err(adev->dev, "amdgpu_vce: Can't validate firmware \"%s\"\n",
>  			fw_name);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 05f01f50194b..2455cc126e59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -99,9 +99,13 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev)
>  	amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
>  	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>  		if (i == 1 && amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
> -			r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw, "amdgpu/%s_%d.bin", ucode_prefix, i);
> +			r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw,
> +						 AMDGPU_UCODE_REQUIRED,
> +						 "amdgpu/%s_%d.bin", ucode_prefix, i);
>  		else
> -			r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw, "amdgpu/%s.bin", ucode_prefix);
> +			r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw,
> +						 AMDGPU_UCODE_REQUIRED,
> +						 "amdgpu/%s.bin", ucode_prefix);
>  		if (r) {
>  			amdgpu_ucode_release(&adev->vcn.inst[i].fw);
>  			return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> index 83cb9f565fe5..2c12840ea444 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -236,7 +236,8 @@ int amdgpu_vpe_init_microcode(struct amdgpu_vpe *vpe)
>  	int ret;
>  
>  	amdgpu_ucode_ip_version_decode(adev, VPE_HWIP, fw_prefix, sizeof(fw_prefix));
> -	ret = amdgpu_ucode_request(adev, &adev->vpe.fw, "amdgpu/%s.bin", fw_prefix);
> +	ret = amdgpu_ucode_request(adev, &adev->vpe.fw, AMDGPU_UCODE_REQUIRED,
> +				   "amdgpu/%s.bin", fw_prefix);
>  	if (ret)
>  		goto out;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> index 1563e35da0fe..a5cd950c94be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> @@ -133,9 +133,11 @@ static int cik_sdma_init_microcode(struct amdgpu_device *adev)
>  	for (i = 0; i < adev->sdma.num_instances; i++) {
>  		if (i == 0)
>  			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
> +						   AMDGPU_UCODE_REQUIRED,
>  						   "amdgpu/%s_sdma.bin", chip_name);
>  		else
>  			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
> +						   AMDGPU_UCODE_REQUIRED,
>  						   "amdgpu/%s_sdma1.bin", chip_name);
>  		if (err)
>  			goto out;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index f1b35b4a73ff..c4e15418e187 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4138,18 +4138,21 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
>  	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
>  
>  	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_pfp%s.bin", ucode_prefix, wks);
>  	if (err)
>  		goto out;
>  	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_PFP);
>  
>  	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_me%s.bin", ucode_prefix, wks);
>  	if (err)
>  		goto out;
>  	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_ME);
>  
>  	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_ce%s.bin", ucode_prefix, wks);
>  	if (err)
>  		goto out;
> @@ -4173,6 +4176,7 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
>  	}
>  
>  	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_mec%s.bin", ucode_prefix, wks);
>  	if (err)
>  		goto out;
> @@ -4180,6 +4184,7 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
>  	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1_JT);
>  
>  	err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_mec2%s.bin", ucode_prefix, wks);
>  	if (!err) {
>  		amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index f63a06661f86..67cd42031571 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -641,6 +641,7 @@ static int gfx_v11_0_init_toc_microcode(struct amdgpu_device *adev, const char *
>  	int err = 0;
>  
>  	err = amdgpu_ucode_request(adev, &adev->psp.toc_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_toc.bin", ucode_prefix);
>  	if (err)
>  		goto out;
> @@ -690,6 +691,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
>  
>  	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
>  	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_pfp.bin", ucode_prefix);
>  	if (err)
>  		goto out;
> @@ -707,6 +709,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
>  	}
>  
>  	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_me.bin", ucode_prefix);
>  	if (err)
>  		goto out;
> @@ -722,9 +725,11 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
>  		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 0, 0) &&
>  		    adev->pdev->revision == 0xCE)
>  			err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
> +						   AMDGPU_UCODE_REQUIRED,
>  						   "amdgpu/gc_11_0_0_rlc_1.bin");
>  		else
>  			err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
> +						   AMDGPU_UCODE_REQUIRED,
>  						   "amdgpu/%s_rlc.bin", ucode_prefix);
>  		if (err)
>  			goto out;
> @@ -737,6 +742,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
>  	}
>  
>  	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_mec.bin", ucode_prefix);
>  	if (err)
>  		goto out;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index ebb09c363803..d0697b0869e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -539,6 +539,7 @@ static int gfx_v12_0_init_toc_microcode(struct amdgpu_device *adev, const char *
>  	int err = 0;
>  
>  	err = amdgpu_ucode_request(adev, &adev->psp.toc_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_toc.bin", ucode_prefix);
>  	if (err)
>  		goto out;
> @@ -568,6 +569,7 @@ static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)
>  	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
>  
>  	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_pfp.bin", ucode_prefix);
>  	if (err)
>  		goto out;
> @@ -575,6 +577,7 @@ static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)
>  	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_PFP_P0_STACK);
>  
>  	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_me.bin", ucode_prefix);
>  	if (err)
>  		goto out;
> @@ -583,6 +586,7 @@ static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)
>  
>  	if (!amdgpu_sriov_vf(adev)) {
>  		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
> +					   AMDGPU_UCODE_REQUIRED,
>  					   "amdgpu/%s_rlc.bin", ucode_prefix);
>  		if (err)
>  			goto out;
> @@ -595,6 +599,7 @@ static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)
>  	}
>  
>  	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_mec.bin", ucode_prefix);
>  	if (err)
>  		goto out;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> index 81c185a8b3a0..1b4c0dcee7e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -337,6 +337,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
>  	}
>  
>  	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_pfp.bin", chip_name);
>  	if (err)
>  		goto out;
> @@ -345,6 +346,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
>  	adev->gfx.pfp_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
>  
>  	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_me.bin", chip_name);
>  	if (err)
>  		goto out;
> @@ -353,6 +355,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
>  	adev->gfx.me_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
>  
>  	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_ce.bin", chip_name);
>  	if (err)
>  		goto out;
> @@ -361,6 +364,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
>  	adev->gfx.ce_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
>  
>  	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_rlc.bin", chip_name);
>  	if (err)
>  		goto out;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 60931396f76b..17a07e1adffa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -934,33 +934,39 @@ static int gfx_v7_0_init_microcode(struct amdgpu_device *adev)
>  	}
>  
>  	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_pfp.bin", chip_name);
>  	if (err)
>  		goto out;
>  
>  	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_me.bin", chip_name);
>  	if (err)
>  		goto out;
>  
>  	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_ce.bin", chip_name);
>  	if (err)
>  		goto out;
>  
>  	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_mec.bin", chip_name);
>  	if (err)
>  		goto out;
>  
>  	if (adev->asic_type == CHIP_KAVERI) {
>  		err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
> +					   AMDGPU_UCODE_REQUIRED,
>  					   "amdgpu/%s_mec2.bin", chip_name);
>  		if (err)
>  			goto out;
>  	}
>  
>  	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_rlc.bin", chip_name);
>  out:
>  	if (err) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index f15beb217b48..a2a45be68c24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -982,13 +982,16 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
>  
>  	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
>  		err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
> +					   AMDGPU_UCODE_NOT_REQUIRED,
>  					   "amdgpu/%s_pfp_2.bin", chip_name);
>  		if (err == -ENODEV) {
>  			err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
> +						   AMDGPU_UCODE_REQUIRED,
>  						   "amdgpu/%s_pfp.bin", chip_name);
>  		}
>  	} else {
>  		err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
> +					   AMDGPU_UCODE_REQUIRED,
>  					   "amdgpu/%s_pfp.bin", chip_name);
>  	}
>  	if (err)
> @@ -999,13 +1002,16 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
>  
>  	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
>  		err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
> +					   AMDGPU_UCODE_NOT_REQUIRED,
>  					   "amdgpu/%s_me_2.bin", chip_name);
>  		if (err == -ENODEV) {
>  			err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
> +						   AMDGPU_UCODE_REQUIRED,
>  						   "amdgpu/%s_me.bin", chip_name);
>  		}
>  	} else {
>  		err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
> +					   AMDGPU_UCODE_REQUIRED,
>  					   "amdgpu/%s_me.bin", chip_name);
>  	}
>  	if (err)
> @@ -1017,13 +1023,16 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
>  
>  	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
>  		err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
> +					   AMDGPU_UCODE_NOT_REQUIRED,
>  					   "amdgpu/%s_ce_2.bin", chip_name);
>  		if (err == -ENODEV) {
>  			err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
> +						   AMDGPU_UCODE_REQUIRED,
>  						   "amdgpu/%s_ce.bin", chip_name);
>  		}
>  	} else {
>  		err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
> +					   AMDGPU_UCODE_REQUIRED,
>  					   "amdgpu/%s_ce.bin", chip_name);
>  	}
>  	if (err)
> @@ -1044,6 +1053,7 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
>  		adev->virt.chained_ib_support = false;
>  
>  	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_rlc.bin", chip_name);
>  	if (err)
>  		goto out;
> @@ -1093,13 +1103,16 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
>  
>  	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
>  		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
> +					   AMDGPU_UCODE_NOT_REQUIRED,
>  					   "amdgpu/%s_mec_2.bin", chip_name);
>  		if (err == -ENODEV) {
>  			err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
> +						   AMDGPU_UCODE_REQUIRED,
>  						   "amdgpu/%s_mec.bin", chip_name);
>  		}
>  	} else {
>  		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
> +					   AMDGPU_UCODE_REQUIRED,
>  					   "amdgpu/%s_mec.bin", chip_name);
>  	}
>  	if (err)
> @@ -1112,13 +1125,16 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
>  	    (adev->asic_type != CHIP_TOPAZ)) {
>  		if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
>  			err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
> +						   AMDGPU_UCODE_NOT_REQUIRED,
>  						   "amdgpu/%s_mec2_2.bin", chip_name);
>  			if (err == -ENODEV) {
>  				err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
> +							   AMDGPU_UCODE_REQUIRED,
>  							   "amdgpu/%s_mec2.bin", chip_name);
>  			}
>  		} else {
>  			err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
> +						   AMDGPU_UCODE_REQUIRED,
>  						   "amdgpu/%s_mec2.bin", chip_name);
>  		}
>  		if (!err) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 4e27528b7e57..30d9b6dacb6e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1429,18 +1429,21 @@ static int gfx_v9_0_init_cp_gfx_microcode(struct amdgpu_device *adev,
>  	int err;
>  
>  	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_pfp.bin", chip_name);
>  	if (err)
>  		goto out;
>  	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_PFP);
>  
>  	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_me.bin", chip_name);
>  	if (err)
>  		goto out;
>  	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_ME);
>  
>  	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_ce.bin", chip_name);
>  	if (err)
>  		goto out;
> @@ -1476,6 +1479,7 @@ static int gfx_v9_0_init_rlc_microcode(struct amdgpu_device *adev,
>  		(((adev->pdev->revision >= 0xC8) && (adev->pdev->revision <= 0xCF)) ||
>  		((adev->pdev->revision >= 0xD8) && (adev->pdev->revision <= 0xDF))))
>  		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
> +					   AMDGPU_UCODE_REQUIRED,
>  					   "amdgpu/%s_rlc_am4.bin", chip_name);
>  	else if (!strcmp(chip_name, "raven") && (amdgpu_pm_load_smu_firmware(adev, &smu_version) == 0) &&
>  		(smu_version >= 0x41e2b))
> @@ -1483,9 +1487,11 @@ static int gfx_v9_0_init_rlc_microcode(struct amdgpu_device *adev,
>  		*SMC is loaded by SBIOS on APU and it's able to get the SMU version directly.
>  		*/
>  		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
> +					   AMDGPU_UCODE_REQUIRED,
>  					   "amdgpu/%s_kicker_rlc.bin", chip_name);
>  	else
>  		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
> +					   AMDGPU_UCODE_REQUIRED,
>  					   "amdgpu/%s_rlc.bin", chip_name);
>  	if (err)
>  		goto out;
> @@ -1518,9 +1524,11 @@ static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
>  
>  	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_ALDEBARAN))
>  		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
> -					   "amdgpu/%s_sjt_mec.bin", chip_name);
> +				   AMDGPU_UCODE_REQUIRED,
> +				   "amdgpu/%s_sjt_mec.bin", chip_name);
>  	else
>  		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
> +					   AMDGPU_UCODE_REQUIRED,
>  					   "amdgpu/%s_mec.bin", chip_name);
>  	if (err)
>  		goto out;
> @@ -1531,9 +1539,11 @@ static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
>  	if (gfx_v9_0_load_mec2_fw_bin_support(adev)) {
>  		if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_ALDEBARAN))
>  			err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
> +						   AMDGPU_UCODE_REQUIRED,
>  						   "amdgpu/%s_sjt_mec2.bin", chip_name);
>  		else
>  			err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
> +						   AMDGPU_UCODE_REQUIRED,
>  						   "amdgpu/%s_mec2.bin", chip_name);
>  		if (!err) {
>  			amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 8eccb080d56f..9c146e37c55e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -545,6 +545,7 @@ static int gfx_v9_4_3_init_rlc_microcode(struct amdgpu_device *adev,
>  
>  
>  	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
> +				   AMDGPU_UCODE_REQUIRED,
>  				   "amdgpu/%s_rlc.bin", chip_name);
>  	if (err)
>  		goto out;
> @@ -578,10 +579,12 @@ static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,
>  
>  	if (amdgpu_sriov_vf(adev))
>  		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
> -				"amdgpu/%s_sjt_mec.bin", chip_name);
> +					   AMDGPU_UCODE_REQUIRED,
> +					   "amdgpu/%s_sjt_mec.bin", chip_name);
>  	else
>  		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
> -				"amdgpu/%s_mec.bin", chip_name);
> +					   AMDGPU_UCODE_REQUIRED,
> +					   "amdgpu/%s_mec.bin", chip_name);
>  	if (err)
>  		goto out;
>  	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 8e878ab44e76..2245dda92021 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -131,7 +131,8 @@ static int gmc_v6_0_init_microcode(struct amdgpu_device *adev)
>  	if (((RREG32(mmMC_SEQ_MISC0) & 0xff000000) >> 24) == 0x58)
>  		chip_name = "si58";
>  
> -	err = amdgpu_ucode_request(adev, &adev->gmc.fw, "amdgpu/%s_mc.bin", chip_name);
> +	err = amdgpu_ucode_request(adev, &adev->gmc.fw, AMDGPU_UCODE_REQUIRED,
> +				   "amdgpu/%s_mc.bin", chip_name);
>  	if (err) {
>  		dev_err(adev->dev,
>  		       "si_mc: Failed to load firmware \"%s_mc.bin\"\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 347bccd92696..9aac4b1101e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -157,7 +157,8 @@ static int gmc_v7_0_init_microcode(struct amdgpu_device *adev)
>  		return -EINVAL;
>  	}
>  
> -	err = amdgpu_ucode_request(adev, &adev->gmc.fw, "amdgpu/%s_mc.bin", chip_name);
> +	err = amdgpu_ucode_request(adev, &adev->gmc.fw, AMDGPU_UCODE_REQUIRED,
> +				   "amdgpu/%s_mc.bin", chip_name);
>  	if (err) {
>  		pr_err("cik_mc: Failed to load firmware \"%s_mc.bin\"\n", chip_name);
>  		amdgpu_ucode_release(&adev->gmc.fw);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 29ce36038b3f..d06585207c33 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -259,7 +259,8 @@ static int gmc_v8_0_init_microcode(struct amdgpu_device *adev)
>  		return -EINVAL;
>  	}
>  
> -	err = amdgpu_ucode_request(adev, &adev->gmc.fw, "amdgpu/%s_mc.bin", chip_name);
> +	err = amdgpu_ucode_request(adev, &adev->gmc.fw, AMDGPU_UCODE_REQUIRED,
> +				   "amdgpu/%s_mc.bin", chip_name);
>  	if (err) {
>  		pr_err("mc: Failed to load firmware \"%s_mc.bin\"\n", chip_name);
>  		amdgpu_ucode_release(&adev->gmc.fw);
> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> index d4f72e47ae9e..aeca5c08ea2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> @@ -50,7 +50,8 @@ static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
>  	DRM_DEBUG("\n");
>  
>  	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
> -	err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, "amdgpu/%s_imu.bin", ucode_prefix);
> +	err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGPU_UCODE_REQUIRED,
> +				   "amdgpu/%s_imu.bin", ucode_prefix);
>  	if (err)
>  		goto out;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
> index 1341f0292031..df898dbb746e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
> @@ -47,7 +47,8 @@ static int imu_v12_0_init_microcode(struct amdgpu_device *adev)
>  	DRM_DEBUG("\n");
>  
>  	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
> -	err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, "amdgpu/%s_imu.bin", ucode_prefix);
> +	err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGPU_UCODE_REQUIRED,
> +				   "amdgpu/%s_imu.bin", ucode_prefix);
>  	if (err)
>  		goto out;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> index c6af318908e4..269bf1e3337b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -145,9 +145,11 @@ static int sdma_v2_4_init_microcode(struct amdgpu_device *adev)
>  	for (i = 0; i < adev->sdma.num_instances; i++) {
>  		if (i == 0)
>  			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
> +						   AMDGPU_UCODE_REQUIRED,
>  						   "amdgpu/%s_sdma.bin", chip_name);
>  		else
>  			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
> +						   AMDGPU_UCODE_REQUIRED,
>  						   "amdgpu/%s_sdma1.bin", chip_name);
>  		if (err)
>  			goto out;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> index d438f2f7a408..c9ad9ec48688 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -305,9 +305,11 @@ static int sdma_v3_0_init_microcode(struct amdgpu_device *adev)
>  	for (i = 0; i < adev->sdma.num_instances; i++) {
>  		if (i == 0)
>  			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
> +						   AMDGPU_UCODE_REQUIRED,
>  						   "amdgpu/%s_sdma.bin", chip_name);
>  		else
>  			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
> +						   AMDGPU_UCODE_REQUIRED,
>  						   "amdgpu/%s_sdma1.bin", chip_name);
>  		if (err)
>  			goto out;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 85f21db6ef24..fff5a1cdf474 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2338,7 +2338,8 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
>  		return 0;
>  	}
>  
> -	r = amdgpu_ucode_request(adev, &adev->dm.fw_dmcu, "%s", fw_name_dmcu);
> +	r = amdgpu_ucode_request(adev, &adev->dm.fw_dmcu, AMDGPU_UCODE_REQUIRED,
> +				 "%s", fw_name_dmcu);
>  	if (r == -ENODEV) {
>  		/* DMCU firmware is not necessary, so don't raise a fuss if it's missing */
>  		DRM_DEBUG_KMS("dm: DMCU firmware not found\n");
> @@ -5306,7 +5307,8 @@ static int dm_init_microcode(struct amdgpu_device *adev)
>  		/* ASIC doesn't support DMUB. */
>  		return 0;
>  	}
> -	r = amdgpu_ucode_request(adev, &adev->dm.dmub_fw, "%s", fw_name_dmub);
> +	r = amdgpu_ucode_request(adev, &adev->dm.dmub_fw, AMDGPU_UCODE_REQUIRED,
> +				 "%s", fw_name_dmub);
>  	return r;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index 2bed85ba835e..a87dcf0974bc 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -7709,7 +7709,8 @@ static int si_dpm_init_microcode(struct amdgpu_device *adev)
>  	default: BUG();
>  	}
>  
> -	err = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s_smc.bin", chip_name);
> +	err = amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCODE_REQUIRED,
> +				   "amdgpu/%s_smc.bin", chip_name);
>  	if (err) {
>  		DRM_ERROR("si_smc: Failed to load firmware. err = %d\"%s_smc.bin\"\n",
>  			  err, chip_name);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 480cf3cb204d..189c6a32b6bd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -105,7 +105,8 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
>  		return 0;
>  
>  	amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, sizeof(ucode_prefix));
> -	err = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s.bin", ucode_prefix);
> +	err = amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCODE_REQUIRED,
> +				   "amdgpu/%s.bin", ucode_prefix);
>  	if (err)
>  		goto out;
>  
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index bb506d15d787..7bb45ff6d5c8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -103,7 +103,8 @@ int smu_v13_0_init_microcode(struct smu_context *smu)
>  		return 0;
>  
>  	amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, sizeof(ucode_prefix));
> -	err = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s.bin", ucode_prefix);
> +	err = amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCODE_REQUIRED,
> +				   "amdgpu/%s.bin", ucode_prefix);
>  	if (err)
>  		goto out;
>  
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 8344f54e6674..5b86df0c8536 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -305,7 +305,8 @@ static int smu_v13_0_6_init_microcode(struct smu_context *smu)
>  
>  	amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix,
>  				       sizeof(ucode_prefix));
> -	ret  = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s.bin", ucode_prefix);
> +	ret  = amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCODE_REQUIRED,
> +				    "amdgpu/%s.bin", ucode_prefix);
>  	if (ret)
>  		goto out;
>  
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> index 4d083f7f772e..9b2f4fe1578b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> @@ -79,7 +79,8 @@ int smu_v14_0_init_microcode(struct smu_context *smu)
>  		return 0;
>  
>  	amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, sizeof(ucode_prefix));
> -	err = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s.bin", ucode_prefix);
> +	err = amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCODE_REQUIRED,
> +				   "amdgpu/%s.bin", ucode_prefix);
>  	if (err)
>  		goto out;
>  

