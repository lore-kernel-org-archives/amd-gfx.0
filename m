Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45195CCD183
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 08:17:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A27A110E3EF;
	Mon, 13 Oct 2025 08:17:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AW9wSPeQ";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013052.outbound.protection.outlook.com
 [40.107.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D96A10E3EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 08:17:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/m61m4jxsg+Xkq6CLihGuGR71p/Vn8e2piSnV3PZZk0X0UXE9XMZG1kLO6CTQ8fSNtlT3Av0Wy3TueQQIyJM6o0JR2qmfXX09rh1HVNXsbD6HcWQA07y5cYnDEAIjTM2hHvOZM7hBBgKIlC9LEY3KxTFxFxmEKA27TpMFwIBVs7Upxfs9YcnkZa943zEltg6uBJas+4BQIESSmj1tCabRD3nmew6XY0xtx+yDvWq6xjEMvmEkRBHwGGZs+hNVDlimjIjBxZ6xRMKlp1HR5HS6OSfwb5fWybcgsKtCM0uujUUrKZd7qykDH8vrHmSSYXO85N/S4jwBk/nq746OCEyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dmH/LovcAeEaLGLqUOGYpyIX+Jqus2WmUXnpc9mTv0=;
 b=kOPZ1cK4FjUPMKGKHEtc3jQUj+zEf1xDjz1Y8oQYemqDrG6bAbAUAj2Nku8aX417UAfw4tCE6nwYSZw6WX8oVmiKN4egF5Ewh92wwqEmUQ/gX5sbrBtGwTMwGeBLTSxR7+xV3c5nMh7zqIoG6xKz8Ak5tiwicbiJhd1qjfwMALOTZQGTSQBCAwhwsPYA1sD2TLDIwLXU4mo+AATtPc6PXC7k+CNQyn7GUrps8wMyU/gN8aoADWZu9iUjVfEQ3IoOiV4DfGuHRSHKB6mLSEPsTocAl6vKhrEPDMy39hQTZoZPIm/aZgls8sD4NeV8Bc3+TxqLy4ddt2BzdilSTce19w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dmH/LovcAeEaLGLqUOGYpyIX+Jqus2WmUXnpc9mTv0=;
 b=AW9wSPeQ9SbSyGAxxRWMg+juvcAeBKUhKwzuN/hi0YDCQ9NPPBu3ZuiwIu9lNZ8YMIvJulK19KqmFqEEBsTOOWo6fSLeN3/EI9pGW7hXSI2gCXLYSgeSmfP3t7cdpsHLFwdqXHX/5gCFcLkw/Dtc5SZSYChmF2twGyhWWkFX7ZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 13 Oct
 2025 08:17:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 08:17:01 +0000
Message-ID: <a1e2beb0-885e-4f50-a48c-f570f291b9ed@amd.com>
Date: Mon, 13 Oct 2025 10:16:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: Fix NULL pointer dereference in VRAM logic
 for APU devices
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20251013080212.1722494-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251013080212.1722494-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV3PR12MB9411:EE_
X-MS-Office365-Filtering-Correlation-Id: b3525a97-e2a6-434e-9790-08de0a30e304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3dqc1FmQVZmZkFMa3czWlpqcTJCcUdQQ2l0WkozNHZPWWpTUC80YktBRkRL?=
 =?utf-8?B?L3J0ZW9PU1JrU0QzWko3bVRORTZ6d0VTRGRhcmhuVGJUVE1pdlZUQW82Y3JS?=
 =?utf-8?B?MmhWQ2Q1UXNsUFEybWhWRDFlK2swNkpEY1Npd3JkQTdabnRKdnB2Q2wvTFcx?=
 =?utf-8?B?ZzZvNGJ5Y0Z3R09mY0dmSzVRUk5zZGJBS2tTSkpPeTU2MWVpWk8zVkI3WnN0?=
 =?utf-8?B?Sm9jakR1K2NmQlRkbW1EZFVGYjhlRnZOM3ZNdEhtaEJPU01XVVhIWVkwdmF2?=
 =?utf-8?B?VC9xdjlvMlRPak11UVMzN1JEcUYyK0RDNEYyT2hrMzRaeUdsaCs0MTRNUjZF?=
 =?utf-8?B?ZDRJV3VHcC9aRnQ2M2tQTjlyMGZKbUJzeElBN3VCT0E5RUtQejFyY2lZOEJS?=
 =?utf-8?B?Y0FzeUtuOENVRzVHZUsvQ2dQeXNMV1RUbVVmTXJMSjlWNlFOYmQrVURKQlFa?=
 =?utf-8?B?RXBrQitaS2w4YjYybTVzSFJWWlpoU01sWVNva2hSbUd1ZVVIZCswSWEvTUQ0?=
 =?utf-8?B?cXovdXdLZnBTanh1bjMvVXk3eC9TVWlTb3RuQUl5bys0cStoMU9WNDYzNzcz?=
 =?utf-8?B?WUtaWGJ0R3pIUVdmeEsvbU11aGhPeFhRaXN3R0I2OUk2enYrSUZDNncxK1RG?=
 =?utf-8?B?aFBIWUVlNExSRkgrMmZHTWUxVVc1czJqRnAxQ3g1M2RsSGFYMXgyZGFIamNN?=
 =?utf-8?B?Z3M2QXd4UjZ0QWVpRk4zZ21YSktJWlZ0MEFvMnpPTkNYeVVhM3orOCtFV3Nm?=
 =?utf-8?B?TnVoL0VvU0ErN0VqdTVJTmtnazhMdmgvRytOT0REendmWHdHSTFoM1VCZFpF?=
 =?utf-8?B?WU42TFB0ekdOUzNrRGZDOFlMN1hhZnlROHk0VkNNeFM2aEhZeGlhUnpEbmlN?=
 =?utf-8?B?bm85bkk0K1l0Uk5SZzlSWjZiRXVUTFp6Uk1zU1JSRFhib2VNQmJFSEF0VnJU?=
 =?utf-8?B?TWN5VEMzNS82enVQRERxSDA0cnBzZ2ZaQS9BUmFQem5rSk0yRjVRQVd0L0xU?=
 =?utf-8?B?Z1FYckRid3Y1M0k4NTBaV3VkNFk1M1J6OXJVa2dKT3RWaENYMTQyMUkvVWZM?=
 =?utf-8?B?dnRiRzRWUHlpVElhQ0JaSG5UL2gyc3dIcTVWL3NoMkkxNTdXMlM4ZkdzaVJV?=
 =?utf-8?B?TGdxMkc5dnA2NnpXbTVUdllrQmtsUStXa21JTldEQms5dXVXTTBUWm9WVWg2?=
 =?utf-8?B?MFRTVHZIRkF0RVVVRFhvVVdZY09zWUQ5T1Mrb1V3aW5VR09pZmFQRk42Tmxj?=
 =?utf-8?B?YnRSM2hUSmsrYnJjelcrRVlIVDVhVis4WXlwM0tFMHFsTnJpV0ZPSlVWTVRO?=
 =?utf-8?B?MUtjclpOVWJra2FWU216T3d3cDVsN0lWTk1PeEN0ajFJUmYyVk5vQVlZbG5Z?=
 =?utf-8?B?NXplbGljWjNzL1ZzVEtVRGQxeDhyU3NkZEhCR21CTXVla2JUNVRMenBUdCt4?=
 =?utf-8?B?ZURXdFliWERkeTBuelN4ay9TcGpsTU1CRm1YV1VieXh1dzZIOWMzcCszczhG?=
 =?utf-8?B?Tk56bE5yUk1oczFwaTZHanZDV3VhSHVualFtZStQZmJGQ1NOTGRjdldMSTlL?=
 =?utf-8?B?TlJFRFhSU1M5WU0zNmRvM2l6MlEvNVdpNityczVjWVpEb2dQMmNCaTZEQlRi?=
 =?utf-8?B?dVVsbTZWZmVDbWtQcU1GbDl4SUwydWxxSzFpRmtHa2Q3czBBWExsc2tGUnZX?=
 =?utf-8?B?aUcrRGdaZEw4N05qaHZIeTBrK1IxSDArUStodWM0c1R4a0dmTENNbnZvczNz?=
 =?utf-8?B?aENuNitRL1dLS0VxYmdNelVqRTRrQzNTSkM3MEM5M2U3eDBVcWtQaW5WbjIx?=
 =?utf-8?B?bFUvVmFxNzlKanlZTW9YU2JOV2xIUWhXcGVhdFdrS0VBTjM2QzFEaXZQNDQz?=
 =?utf-8?B?a1BwN1dnK0k0VUxyWHpVRWRyRG4wS25UN0M0NVkxT0dMa01ZUjFSQWRtSEp2?=
 =?utf-8?Q?xP7yTTItkmt2DeEsAI20tTs77SWChjL3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REZvMVFCS1poYmt5VnJwZ2VTNWpXcW9mR2NENThhekRWUXVDMUsyREo0TERx?=
 =?utf-8?B?RjdZU01kenlTSU42bW1QL24wYXFpclh3L2pFZW5OZzdLbHVZNEhVaGtTQ1dC?=
 =?utf-8?B?UVRpMjhXWmVkeVNjM3pJZ2FwMEliSzdqYUt5Y2plUjBHaWtjY25vb3hCRkNH?=
 =?utf-8?B?b0pRTHVQSUFQMHVwWmVHa3NIN0QwTjAyeEFGUkNUbllmb2ZzT01EcUFGNVhP?=
 =?utf-8?B?Rjk4dkxpY0FTM3NobnVRanhGbnlaVldaS0hta0IxSlJReVg0SDlYME9xYStx?=
 =?utf-8?B?bVlQT3F2bDNCd0ZodzNoSUlzM1JYakVvVTZUdTR5SGUwTWV5YnBrTE5FSkhy?=
 =?utf-8?B?Zk9uSm5YM040Y1pGS1JpVWtBVWFwb0RvQ2JZenlxeS9DWk5qOHlMR2cwdW8w?=
 =?utf-8?B?akd0STFzVkc5dXExWmdoV2JEQXBDS1B3ZnZ5VVhyUU5obWUyRU9JZXJyY1FY?=
 =?utf-8?B?ZGJ5QXpKa3pBS0Z0czJHRy8xOXpmeFBlM0lsWitzSEQ4d3NsWDJKOGhCOXFl?=
 =?utf-8?B?bGFxUm5SbXI1cFZIdm9TejdSeFB1TkszZ0h5YjA0SjdldVppeVIzRHVVd1ov?=
 =?utf-8?B?UlYvS0RvcXdjenlCMVVNSWJhbWNJRncxYnY1SU5QQjBFTkZwZ0xSaWwzUUhq?=
 =?utf-8?B?aEE0ajR4M0JHdmcvOFRobC9XM0RVZFo1aVVLS2J4TzFlV0o0T2lMWFhmZFMz?=
 =?utf-8?B?QmlDMnc3Q0VjSmRuQnBkZWRQZ2UyN3ZwamZ2ajczZXFHUWtLQlVKdjJ2Qk9W?=
 =?utf-8?B?aXNrcG1PT3ZXNWdGZWtTWW1UTm83L095TTB0L1d0dmFucnQ2Q2Framt4U0Vh?=
 =?utf-8?B?cUNFU2hKSTF6dnBWUWlXU0pkVzhIWkNwK2tnQTFwblJuNlpBQlF5bDM3d0FP?=
 =?utf-8?B?ZTFUQ2FuT3cyVUw2MlEyRUtTcS8wOWZLQTFmdVRoOGRldVh1cUNEZnBIMTR5?=
 =?utf-8?B?SklXKzEwSTJ1eE8xZlZBcGlEazhoT3ZmQ0FBQzBJVmhKWVJobUc3dSswUnZo?=
 =?utf-8?B?VWhNM0g4cFhtMWIyNjNpZjlQV0VuUU0ySi9YOFJFQmNCYlhVeDlUaDBTSDla?=
 =?utf-8?B?OVpHUTlTTnBWSUJTYTlVTDV3UjNGbUpXZ1h6NXR0VE5UMzBCNXhVUlZ6cXpT?=
 =?utf-8?B?WDc5eTRlamVZVXdjS2h2YkU5LzdUREhQdjUzNFY1V1dsbDE3VVBCMUxDemtM?=
 =?utf-8?B?VWN4dDNyN1ZlUTYwS3JXMVRkQWNvb2NocEhxS0cvdm9RejdBOFgvOFFQRm5u?=
 =?utf-8?B?WTFTYStFUTRISjJKYlZLWmsyQjlDa0E1MXorNHc4MTNYdUo4V2ViTmlJVXNz?=
 =?utf-8?B?b0djbzVwVHRoWVlWemVkeFBMSVdlbzBKd2xTWUZEL3pmbnM5WU50RnQzSDBG?=
 =?utf-8?B?bFR3eHN2K0xYbGtsaWJESGFsalkxQUdCbGV6UXZZalJ4cmw3Z3R0U2NhdWM2?=
 =?utf-8?B?b1ArRG9GbHdrb0lNZFBGS3k2eFVzWU1yeDFBajRvU3BndWsxWWMyei9xVzBG?=
 =?utf-8?B?T2VLV0grY0Y2TGp3THRGelpBdWs1Q1RsdDR4VEljcmRrYStmVFQzcWl3MjJX?=
 =?utf-8?B?ZzVDcFNhNmNRSW9ndE5JRlhhYkU0dHNzYkRCT0FtaVAwN3R0YmVCejdWcjRK?=
 =?utf-8?B?Qmd3MTJxMVA3VnIyeVBKUnBQcGVqaEZzYnlnNk9MUHBPSmRDYUhrMjllRVVw?=
 =?utf-8?B?dVJiU0dQM3hZa0h4aEc0YzE5Tk8xQnBxZ2Vpa2xBVE8wajBVSGdiV09FZE43?=
 =?utf-8?B?Y0lLeDFDZGcrN3N4MWpzQ1BzQWpSSXJHRzd3ei90SFJGSkNjbzNsSVVCdXlD?=
 =?utf-8?B?RTYyVnJ5d0JDanR3dzExUXBpTlI1Q01QOHNDSnZFbUVXZXZlWEpIb1VMTE8z?=
 =?utf-8?B?KzdwZjVuckF2bzFIaFRZNFRGb3QzWlJ3dEgvTjZWTUdodldCNGlhZ0F0U3FH?=
 =?utf-8?B?WWhxREhHTzdKYjUrMGJVNlpxMnVXdzd1azdBY0RpTHV0VFVuUkJmbC9RVEw1?=
 =?utf-8?B?b0Q1K1YxcVFPYmFCTFVTVnpxa2Q4YUpOUGdiMVdGZG1GVVNvaXhiQnVLejdp?=
 =?utf-8?B?ZDg1K3JFamkyWElVVWRvM2RHWXgzVXUyUjlHQjMzS1pqN3dZOTlyN3lRYnR4?=
 =?utf-8?Q?ugWB55L1ed55FZ67P/87TSRKh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3525a97-e2a6-434e-9790-08de0a30e304
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 08:17:01.9274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4DOMoyqPWnqDDVao1PUPH1/0tb/E7QKkyI8fpGVIIsNJiYhudh5oskPEwCgakyv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9411
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



On 13.10.25 10:00, Jesse.Zhang wrote:
> Previously, APU platforms (and other scenarios with uninitialized VRAM managers)
> triggered a NULL pointer dereference in `ttm_resource_manager_usage()`. The root
> cause is not that the `struct ttm_resource_manager *man` pointer itself is NULL,
> but that `man->bdev` (the backing device pointer within the manager) remains
> uninitialized (NULL) on APUs—since APUs lack dedicated VRAM and do not fully
> set up VRAM manager structures. When `ttm_resource_manager_usage()` attempts to
> acquire `man->bdev->lru_lock`, it dereferences the NULL `man->bdev`, leading to
> a kernel OOPS.
> 
> 1. **amdgpu_cs.c**: Extend the existing bandwidth control check in
>    `amdgpu_cs_get_threshold_for_moves()` to include a check for
>    `ttm_resource_manager_used()`. If the manager is not used (uninitialized
>    `bdev`), return 0 for migration thresholds immediately—skipping VRAM-specific
>    logic that would trigger the NULL dereference.
> 
> 2. **amdgpu_kms.c**: Update the `AMDGPU_INFO_VRAM_USAGE` ioctl and memory info
>    reporting to use a conditional: if the manager is used, return the real VRAM
>    usage; otherwise, return 0. This avoids accessing `man->bdev` when it is
>    NULL.
> 
> 3. **amdgpu_virt.c**: Modify the vf2pf (virtual function to physical function)
>    data write path. Use `ttm_resource_manager_used()` to check validity: if the
>    manager is usable, calculate `fb_usage` from VRAM usage; otherwise, set
>    `fb_usage` to 0 (APUs have no discrete framebuffer to report).
> 
> This approach is more robust than APU-specific checks because it:
> - Works for all scenarios where the VRAM manager is uninitialized (not just APUs),
> - Aligns with TTM's design by using its native helper function,
> - Preserves correct behavior for discrete GPUs (which have fully initialized
>   `man->bdev` and pass the `ttm_resource_manager_used()` check).
> 
> v4: use ttm_resource_manager_used(&adev->mman.vram_mgr.manager) instead of checking the adev->gmc.is_app_apu flag (Christian)
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  | 7 ++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 ++--
>  3 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 5f515fdcc775..2fa931a20530 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -709,7 +709,7 @@ static void amdgpu_cs_get_threshold_for_moves(struct amdgpu_device *adev,
>  	 */
>  	const s64 us_upper_bound = 200000;
>  
> -	if (!adev->mm_stats.log2_max_MBps) {
> +	if ((!adev->mm_stats.log2_max_MBps) || (!ttm_resource_manager_used(&adev->mman.vram_mgr.manager))) {

The extra () can be dropped, ! binds stronger than ||.

Please use checkpatch.pl to double check that the line is now not to long.

With that done Reviewed-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian.

>  		*max_bytes = 0;
>  		*max_vis_bytes = 0;
>  		return;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index a9327472c651..b3e6b3fcdf2c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -758,7 +758,8 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  		ui64 = atomic64_read(&adev->num_vram_cpu_page_faults);
>  		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>  	case AMDGPU_INFO_VRAM_USAGE:
> -		ui64 = ttm_resource_manager_usage(&adev->mman.vram_mgr.manager);
> +		ui64 = ttm_resource_manager_used(&adev->mman.vram_mgr.manager) ?
> +			ttm_resource_manager_usage(&adev->mman.vram_mgr.manager) : 0;
>  		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>  	case AMDGPU_INFO_VIS_VRAM_USAGE:
>  		ui64 = amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr);
> @@ -804,8 +805,8 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  		mem.vram.usable_heap_size = adev->gmc.real_vram_size -
>  			atomic64_read(&adev->vram_pin_size) -
>  			AMDGPU_VM_RESERVED_VRAM;
> -		mem.vram.heap_usage =
> -			ttm_resource_manager_usage(vram_man);
> +		mem.vram.heap_usage = ttm_resource_manager_used(&adev->mman.vram_mgr.manager) ?
> +				ttm_resource_manager_usage(vram_man) : 0;
>  		mem.vram.max_allocation = mem.vram.usable_heap_size * 3 / 4;
>  
>  		mem.cpu_accessible_vram.total_heap_size =
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 3328ab63376b..f96beb96c75c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -598,8 +598,8 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
>  	vf2pf_info->driver_cert = 0;
>  	vf2pf_info->os_info.all = 0;
>  
> -	vf2pf_info->fb_usage =
> -		ttm_resource_manager_usage(&adev->mman.vram_mgr.manager) >> 20;
> +	vf2pf_info->fb_usage = ttm_resource_manager_used(&adev->mman.vram_mgr.manager) ?
> +		 ttm_resource_manager_usage(&adev->mman.vram_mgr.manager) >> 20 : 0;
>  	vf2pf_info->fb_vis_usage =
>  		amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr) >> 20;
>  	vf2pf_info->fb_size = adev->gmc.real_vram_size >> 20;

