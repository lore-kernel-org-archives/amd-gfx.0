Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67E0C021A9
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 03:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D48910E346;
	Tue, 18 Feb 2025 03:36:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="htVRKjj8";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D48410E26B
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 03:36:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddFy2qPWyI+v65JMLQDAri5FLNskjYlWaYyFCYqwBVCbJeHCYZMeygxLWb+IpGvdzB2L5ZpoLGdCw9F4PCK90QA+vVyOnzIwpPPyt1jhoKSYU2EqHCPxno7yXT4EchsL6a+KFTM62v3HTbK54B5Y+qeBj1zaMmAC6RFjAkF66ENfQgZ5oSUKVd1b1JVtBAhaeTPyoYREQoXw5XSIym27w2mtwFktVX4E3o4mFT67LLZh0LRYdihNgqaiSEPb0drFvHtMwnQzUI0qknKLkt+xqPVSRV7d7Px47cpeuSiFZd1kjaO1O0T/YRZ3Wcwonhdif2YvxRA+VNv6qiiC6nlugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OVcIZzFUJS/s8gilU8xY5rDWr4ve2yPrEDWfT/nyeg=;
 b=XEiEctfNSJQDc8RyK6iB1qBUyfA6MgMxsGKmqbSULq5UrbTL848ciz3X2b3a+sAy5r9eb0pCOGvjrUYepYVpgnv5BquP3h9KUeJN1bMSpVkZu/rm2SjcVQvjmYBBy9+T0haqaStMbtqRVh9zb1sSCEdmOOYvJffalEdYR2yx3ScomU6UiCs/a5UHnjEG2kLI/ceRdRrFzrY0aeR2v/GFSLWvEY2xTCxSO76ynRH0t/pMYFXl9T4lbMY9JJdA/+LO4UOD6WwNLRl8B6OJ6YKsy+8mNWw1S7q8YjRFN+sVG7wWXqGP+pRgxVAsyxTlELMcnthE11YN6wcqoh03tAFROA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OVcIZzFUJS/s8gilU8xY5rDWr4ve2yPrEDWfT/nyeg=;
 b=htVRKjj8OHn6Qz/Mi0AkWd1XKLTaDb8iWDDql2EVM1cAejfa5g+t/wKR58vVxpSAA1k7MKB70doqDwrpRqxPUnaXa1QycLNCW1ft9QHAlkSFKcchElssKosSNo9cSkUKOD0u5x9Sr70q/4rUdz3m+2eT9Ee2XAU9Rwit1YTf9O8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Tue, 18 Feb 2025 03:36:25 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 03:36:25 +0000
Message-ID: <f61682b9-59cf-487f-9d83-a79d4555ffd8@amd.com>
Date: Tue, 18 Feb 2025 09:06:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 3/9] drm/amdgpu: Add common lock and reset caller
 parameter for SDMA reset synchronization
To: jesse.zhang@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 Jonathan Kim <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>
References: <20250213054715.3121445-1-jesse.zhang@amd.com>
 <20250213054715.3121445-3-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250213054715.3121445-3-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::29) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN0PR12MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de73087-93d2-4618-00c4-08dd4fcd6bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MG1vTXRDdjJreityNy8rVll4R3Y3Ty93NU5Rc3ZwTm0xMEIrdnJHWUdYTGts?=
 =?utf-8?B?dzZYVDMxRTBUcWRZODZVTm5VK1NFK1ZHRmFvb0E5dVErRTZIOWcraXJ3SGRX?=
 =?utf-8?B?Ny9iek5yM2FQWXlSY2hQaVhydjJ0bjFKcUt1YU5WVDFDUHVQdmp4NHRMSVBQ?=
 =?utf-8?B?TTV0bjhyK083dDdzYjBrRGx1NW9GekpydFdaRTlQTnJhVmNEM2pJL0VOb0VU?=
 =?utf-8?B?djZEVHE2Q1BHNVVoblJIQlRiVW8yZzh6UUhHU0RrbXpXOTRHeUg5VG9vMGIv?=
 =?utf-8?B?S1R4UG5HL1ZnRmNiTE93V0ZPV3hFVGVnUm93Q0ZGU2VmK0ZiOXVoSWlJNUVW?=
 =?utf-8?B?MDVCOTY5YW5vU052VnN2ZnQ1K3pFcXRHcVNlcnVsSmY3c2FBS041eUJyUmE2?=
 =?utf-8?B?bHU1aWVRYVJvSFdvMWFZVkFmTC9mNkpMMGYxbDZ4KzQ3VWRCRWdCMjlaQkNK?=
 =?utf-8?B?cHpIVWtZVGhsUnJKbWFDQjV3UlVpbDgxdHJkUEF5VnNSalBsUmNRM1Y5MWIy?=
 =?utf-8?B?Ry92QzNPUmdSSDg4MVZiQ1ZSc0ZITzJhQVNWZE1ON2tDN0VVTUx2cXNvdzBF?=
 =?utf-8?B?ZitVM2RMU01sbnpjTEJxR2xPb0Y1Sngzemo0SjVtRldCVXBhOEEwb1AzSW42?=
 =?utf-8?B?cDUxSHlTeGhrdG0vUi8vQ1JWK3krUkFxUTBNYlBrMVcyMzZwL3BhNUJSbWxx?=
 =?utf-8?B?bG91TU1iak1KYW96VHllbnl6SnY5NjhjTzFZa0FjcFV5ZGJ5ZGhqVXlVd21Z?=
 =?utf-8?B?cG1BSGQ3RHBPRXdmdFlGV3FsUmdNNWE1d1NaVldXQ3JEL0FKMk5qNUY3Z2tD?=
 =?utf-8?B?WWxET0NacHQ5REVKQzkvbG5qdHFsclFMbUpSODVUVmEvaWM5cStpa2VoNlVY?=
 =?utf-8?B?cmRPMFBXaTJuM0VBSDNPSVJjSXhNODk2VU5CNThzRDBlVk02eWMwMkdjNmx6?=
 =?utf-8?B?TUUzWVFhN1liNnZsYVZXcUR4RTY5Y0tyRTBSQTJMSUkvM2diRDVRSVVKS1Rn?=
 =?utf-8?B?NVRZSTlNeitnblRhbWhJRGdVRDhrQWsyaWNabjJPeDYvQjVncXk1VzJjNzI5?=
 =?utf-8?B?enFuV1p0WHlTS2NKK0NwUmhMWUw0MGw5WFVwSkEvcnRCMW1OUlNKdFphT2Ju?=
 =?utf-8?B?OHNBdjV1YkVlVGNiVGxjYnBxTEVwRGd4K3ZsMHR0ckEzWXN6Q0k3OTRVKzM5?=
 =?utf-8?B?VmlKNnV6VnFTY0lwS0owWXZhTzlkRGhFd1ByVTUzWjJUOWxSNkJ6L0V5YndS?=
 =?utf-8?B?NjVkK1d5cGV0V2RIczByM1pYVitqeDJLNFd1Qy9IdGNoTENMWHVWYXhLdjRQ?=
 =?utf-8?B?RXBpa0wzeFNxVUxMMDdMUFEzNkh0Wmhia2kySExOMGMvMGRJdnM5eHRWWlVE?=
 =?utf-8?B?QjA4QWZwWGRvRTBQNFJnbjFvY0VRMFVIUWhtL1dCbVFQTUhzK3JlT2Z5U2hw?=
 =?utf-8?B?ZWF4Q2NlWktJUjUvRFgxUTR2TTFqcWpEWVIwTEpzMlBvNFpldm96VHN4NUNT?=
 =?utf-8?B?RlZWYjd5WktVcXh4SHNIV1MwV2dqTTB3RnZDd1NrcHFKZERhQUVudE1uVzhX?=
 =?utf-8?B?dFZ1L3V3bk9CZ1RaUGQ5dEE0MERwZ3ZrQXQ3b0ZSajkwb3RQNFJQeWpoWWtR?=
 =?utf-8?B?SFgwZXpnYlp1ellzUjBxNUJaSjIrVUNNdFVIT3RTZ25tRVhjWWVrOGg5MEhU?=
 =?utf-8?B?Qm1ueTR4Tmt4WkJFTjQ2Uld0cDJwSkwvcGd2bHhsZ25mQmFqUHJ3d3hlUGpn?=
 =?utf-8?B?aWoyRjRHVUQ0NGlTV3oxUUtmemx3VW9SYm1oQjlEd2tiUnJFU1dFYUlnSzFw?=
 =?utf-8?B?RDdlbnJQUkpadkpJaHhGdE13Skhsa1NTUEVBZEVsZkRqekZiYkhOdThsRXFs?=
 =?utf-8?Q?b2DgNPxcQzj24?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGY4VDJWdFZBekFrZ1JHS3cwKzNDemlDdTM0dE9VSTJmb1NKaUZNSGxwcVRM?=
 =?utf-8?B?TmRiZE84YmhnbGFlSVpqMERESFVHSmkzbWVnU2VQYUo3MktsVmtvMUVqdkdv?=
 =?utf-8?B?elEzaWJ3cjhydnl2cVNOUkEzbXJKUDkrVElnVm5ZWEJGZmdEVVg4NXJOYlM3?=
 =?utf-8?B?ejdNam81WVk4N1JQMEczVUZlZ1oyQzMrRW5nNEx2bXFvT3dVbjNLS05hb0gv?=
 =?utf-8?B?b0RNbmdkWUc1cTJWU3VkcWxlQjFac2R1bE1CODdCNHRUM2pOL3RRcVBnR09K?=
 =?utf-8?B?cE0xODJ2bGYvU081bGhtaTBKbFRGa1p3V3hYbHJkS096VWJUV2lNbGE1MDJK?=
 =?utf-8?B?aWJPd2ZRb3NVeDVhcy93dzBVY293bzArQVRuY1FpWEV0cENrK3RMR21yQlls?=
 =?utf-8?B?OGtqVnVIY0F6Wm9CYkVoMnJ1UU1WSmFKUGVtbHJKbUE5bXBNd1RYL05hV0J6?=
 =?utf-8?B?bHkwMHZqMmVxUkpKNEE4WGdMczd2endMZ1MxUTlTMFdmZERWRWY3NkFoZk9h?=
 =?utf-8?B?TXVwekp3azBGUlRaZWpqcVcrL2xiQnBQbFFjazNCNHU3bmNnZ1hhRDhCUDZm?=
 =?utf-8?B?RUVxRDU3WXVvY3ptQ0JBY3FzTFZNdWdDSlBsaWdxL2hNa3dMaUxZanZtS3Zs?=
 =?utf-8?B?dEM4NE55WjNEUmpUNXBoZW5mNlRQWGY2VFg3STJZcVZBTXo0a3Z1cTFVVUFL?=
 =?utf-8?B?TmtkQUZGcDlqbkZSKzZlTWVRRUcxL3dkTk1vM1lYNkxyenl5eDZlaWF0Vkwr?=
 =?utf-8?B?SmQrZnlTS3J4T0ZIdGROUXpuNjB5YjhnUGV0bnduYjdLdzI3aS9yeTdNMkdS?=
 =?utf-8?B?L1NiUUhzK1JoK255S1ppd0RFNURpRzZvWTN1SjJoR0JmWFlXeGpHMEZXUVFp?=
 =?utf-8?B?endnVzM2UklnbWZyZHlwcXhzeThGakVoU1JHelVCaUhxclFtaEJIUlVIUzhw?=
 =?utf-8?B?SFZVUHgwY29sdkJGYVhEN0pqYlVkeGErazZVaEZEU3BZMk1hcFdTT1g2Z1Nz?=
 =?utf-8?B?UGJ0ZitUUFhndXBwcVp2SE13M3JmVUhuYUVZTW5oeERyaWFyc0RMMkdYWFBN?=
 =?utf-8?B?SnVFc1BhVXNtZWF4ZFdnZVo1bVFLVFlEajZ1TGpwc2NscGZKcTRzWVBZUEJt?=
 =?utf-8?B?eHI1RUFXT2tWYktVNDM2d21jZGo0cUJLMjlvZVU2RzNsOGoxWDc4YU0xS2ZF?=
 =?utf-8?B?YXhUSXhJQ0ZEQk5XYjBKT0lhTm16a0pBREVHK0MrU3NneFFlMXE1Y05GQXlC?=
 =?utf-8?B?RE5hT0VaOWMyMzNNeTgyRWdmellDWVByMGZKcE9WQkMvbzdGcXozSGloQXBx?=
 =?utf-8?B?U0RFNmoyeFVueTRwT0VMaFVQeml5L3ZpOVNhemJSWktDaktuN0dIMVRULzM4?=
 =?utf-8?B?N3pwa2pSR1RBa0UzdVZnd05CeGxvWU1IWkl6TytvaWEwSklFZW1uaFJRM0tF?=
 =?utf-8?B?MEIzOVJuUnFrcndEbmhyaXF3cU1YYjJ3Q3BJaGJSNys0Z2VXTjdDVkdhM3Ex?=
 =?utf-8?B?V3RBNklMRTZMUUxVNmRxdXJtbzF3dkZYVlQ1YlNwZUdQLzZEcGp0Z2k2a0Zj?=
 =?utf-8?B?Sm5FaWt5L1VrNW93SE5ZTSt3QXJSZnlKRUpGWHpIRUpDazl5ZENDYmxWNG90?=
 =?utf-8?B?ZkxoRHlqWHFoNFlhNjZLaTdibUcraVEvK3Iyd0tJSFpQRkJ1Ry83NkQxaDZ0?=
 =?utf-8?B?TXRGMkt1Zk1UNGlBbWNJczEwWXJvOXlWbk0vMXJyeHdqWDJtV3ZJK0NQQ25i?=
 =?utf-8?B?TVllbzFuci9sY1JvSXBUYXlBcjdtUStMUmRHWUEvcGh3Und3RGZCY0tNcFpj?=
 =?utf-8?B?M1VQU0czV211UXpQaDRpU3E1aFkyUXRnQUs0VEorbVc0ZEtITjJqWHc4eUEv?=
 =?utf-8?B?NnVqMFREU0J4aTRrMU5vd2psbDNySWh2VG5SS2tFdURQRW5GV3I1d1o2NVBn?=
 =?utf-8?B?RXBCWGN1Y2t1ZlRrSzZuQzRlSlJRQjN3aTNSR2tjTkxweVRPejY3VHJucS9K?=
 =?utf-8?B?ZmZXZFYyTSt1NnkvRjFyUGF2ZTMxeEgxZ2w2Yy9DQzZDQlhsb1p6OUNYNjBS?=
 =?utf-8?B?NDUrNFBGR0p0SGVIVUlpZ1VTL3VuU08xdnQ3eWJjTVVKMUM3UWRERHZvM1Bh?=
 =?utf-8?Q?M4VG0AjFhzDm5rAvX/Sa567fm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de73087-93d2-4618-00c4-08dd4fcd6bd5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 03:36:25.6234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rovnb2maPh1REyecm4jwZKvAjjhNFJbDciLZ851rVGvzayLAfcZy94qWxSGTAKEQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835
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



On 2/13/2025 11:17 AM, jesse.zhang@amd.com wrote:
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
> 
> This commit introduces a caller parameter to the amdgpu_sdma_reset_instance function to differentiate
> between reset requests originating from the KGD and KFD.
> This change ensures proper synchronization between KGD and KFD during SDMA resets.
> 
> If the caller is KFD, the function now acquires and releases the scheduler lock (ring->sched.job_list_lock)
> to protect the SDMA queue during the reset.
> 
> These changes prevent race conditions and ensure safe SDMA reset operations
> when initiated by KFD, improving system stability and reliability.
> 
> V2: replace the ring_lock with the existed the scheduler
>     locks for the queues (ring->sched) on the sdma engine.(Alex)
> 
> v3: call drm_sched_wqueue_stop() rather than job_list_lock.
>     If a GPU ring reset was already initiated for one ring at amdgpu_job_timedout,
>     skip resetting that ring and call drm_sched_wqueue_stop()
>     for the other rings (Alex)
> 
>    replace  the common lock (sdma_reset_lock) with DQM lock to
>    to resolve reset races between the two driver sections during KFD eviction.(Jon)
> 
>    Rename the caller to Reset_src and
>    Change AMDGPU_RESET_SRC_SDMA_KGD/KFD to AMDGPU_RESET_SRC_SDMA_HWS/RING (Jon)
> v4: restart the wqueue if the reset was successful,
>     or fall back to a full adapter reset. (Alex)
> 
>    move definition of reset source to enumeration AMDGPU_RESET_SRCS, and
>    check reset src in amdgpu_sdma_reset_instance (Jon)
> 
> v5: Call amdgpu_amdkfd_suspend/resume at the start/end of reset function respectively under !SRC_HWS
>     conditions only (Jon)
> 
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> Suggested-by: Jonathan Kim <Jonathan.Kim@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c  | 65 ++++++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h  |  6 +--
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c  |  8 +--
>  4 files changed, 67 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index 4d9b9701139b..5b86e12ff9fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -43,6 +43,8 @@ enum AMDGPU_RESET_SRCS {
>  	AMDGPU_RESET_SRC_MES,
>  	AMDGPU_RESET_SRC_HWS,
>  	AMDGPU_RESET_SRC_USER,
> +	AMDGPU_RESET_SRC_SDMA_RING,
> +	AMDGPU_RESET_SRC_SDMA_HWS,
>  };
>  
>  struct amdgpu_reset_context {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index fe39198307ec..808c7112ef10 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -25,6 +25,7 @@
>  #include "amdgpu.h"
>  #include "amdgpu_sdma.h"
>  #include "amdgpu_ras.h"
> +#include "amdgpu_reset.h"
>  
>  #define AMDGPU_CSA_SDMA_SIZE 64
>  /* SDMA CSA reside in the 3rd page of CSA */
> @@ -485,6 +486,7 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
>   * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
>   * @adev: Pointer to the AMDGPU device
>   * @instance_id: ID of the SDMA engine instance to reset
> + * @src: The source of reset function (KGD or KFD)
>   *
>   * This function performs the following steps:
>   * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU to save their state.
> @@ -493,20 +495,49 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
>   *
>   * Returns: 0 on success, or a negative error code on failure.
>   */
> -int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
> +int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, int src)
>  {
>  	struct sdma_on_reset_funcs *funcs;
> -	int ret;
> +	int ret = 0;
> +	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];;
> +	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
> +	struct amdgpu_ring *page_ring = &sdma_instance->page;
> +	bool gfx_sched_stopped = false, page_sched_stopped = false;
> +
> +	/* Check if the reset source is valid for SDMA ring reset */
> +	if (src != AMDGPU_RESET_SRC_SDMA_RING && src != AMDGPU_RESET_SRC_HWS)
> +		return -EINVAL;
> +
> +	/* Suspend KFD if the reset source is not SDMA_HWS.
> +	 * prevent the destruction of in-flight healthy user queue packets and
> +	 * avoid race conditions between KFD and KGD during the reset process.
> +	 */
> +	if (src != AMDGPU_RESET_SRC_SDMA_HWS)
> +		amdgpu_amdkfd_suspend(adev, false);

It this has to be done here, what's the idea behind registering a
separate pre/post callback for KFD initiated resets?

Thanks,
Lijo

> +
> +	/* Stop the scheduler's work queue for the GFX and page rings if they are running.
> +	* This ensures that no new tasks are submitted to the queues while
> +	* the reset is in progress.
> +	*/
> +	if (!amdgpu_ring_sched_ready(gfx_ring)) {
> +		drm_sched_wqueue_stop(&gfx_ring->sched);
> +		gfx_sched_stopped = true;;
> +	}
> +
> +	if (adev->sdma.has_page_queue && !amdgpu_ring_sched_ready(page_ring)) {
> +		drm_sched_wqueue_stop(&page_ring->sched);
> +		page_sched_stopped = true;
> +	}
>  
>  	/* Invoke all registered pre_reset callbacks */
>  	list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
>  		if (funcs->pre_reset) {
> -			ret = funcs->pre_reset(adev, instance_id);
> +			ret = funcs->pre_reset(adev, instance_id, src);
>  			if (ret) {
>  				dev_err(adev->dev,
>  				"beforeReset callback failed for instance %u: %d\n",
>  					instance_id, ret);
> -				return ret;
> +				goto exit;
>  			}
>  		}
>  	}
> @@ -515,21 +546,39 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
>  	ret = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
>  	if (ret) {
>  		dev_err(adev->dev, "Failed to reset SDMA instance %u\n", instance_id);
> -		return ret;
> +		goto exit;
>  	}
>  
>  	/* Invoke all registered post_reset callbacks */
>  	list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
>  		if (funcs->post_reset) {
> -			ret = funcs->post_reset(adev, instance_id);
> +			ret = funcs->post_reset(adev, instance_id, src);
>  			if (ret) {
>  				dev_err(adev->dev,
>  				"afterReset callback failed for instance %u: %d\n",
>  					instance_id, ret);
> -				return ret;
> +				goto exit;
>  			}
>  		}
>  	}
>  
> -	return 0;
> +exit:
> +	/* Restart the scheduler's work queue for the GFX and page rings
> +	 * if they were stopped by this function. This allows new tasks
> +	 * to be submitted to the queues after the reset is complete.
> +	 */
> +	if (ret) {
> +		if (gfx_sched_stopped && amdgpu_ring_sched_ready(gfx_ring)) {
> +			drm_sched_wqueue_start(&gfx_ring->sched);
> +		}
> +		if (page_sched_stopped && amdgpu_ring_sched_ready(page_ring)) {
> +			drm_sched_wqueue_start(&page_ring->sched);
> +		}
> +	}
> +
> +	/* Resume KFD if the reset source is not SDMA_HWS */
> +	if (src != AMDGPU_RESET_SRC_SDMA_HWS)
> +		amdgpu_amdkfd_resume(adev, false);
> +
> +       return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index f91d75848557..2ef2da772254 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -99,8 +99,8 @@ struct amdgpu_sdma_ras {
>  };
>  
>  struct sdma_on_reset_funcs {
> -	int (*pre_reset)(struct amdgpu_device *adev, uint32_t instance_id);
> -	int (*post_reset)(struct amdgpu_device *adev, uint32_t instance_id);
> +	int (*pre_reset)(struct amdgpu_device *adev, uint32_t instance_id, int src);
> +	int (*post_reset)(struct amdgpu_device *adev, uint32_t instance_id, int src);
>  	/* Linked list node to store this structure in a list; */
>  	struct list_head list;
>  };
> @@ -166,7 +166,7 @@ struct amdgpu_buffer_funcs {
>  };
>  
>  void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct sdma_on_reset_funcs *funcs);
> -int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id);
> +int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, int src);
>  
>  #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
>  #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 29a123be90b7..50a086264792 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -30,6 +30,7 @@
>  #include "amdgpu_xcp.h"
>  #include "amdgpu_ucode.h"
>  #include "amdgpu_trace.h"
> +#include "amdgpu_reset.h"
>  
>  #include "sdma/sdma_4_4_2_offset.h"
>  #include "sdma/sdma_4_4_2_sh_mask.h"
> @@ -1480,6 +1481,7 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  	INIT_LIST_HEAD(&adev->sdma.reset_callback_list);
> +
>  	return r;
>  }
>  
> @@ -1608,10 +1610,10 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	u32 id = GET_INST(SDMA0, ring->me);
> -	return amdgpu_sdma_reset_engine(adev, id);
> +	return amdgpu_sdma_reset_engine(adev, id, AMDGPU_RESET_SRC_SDMA_RING);
>  }
>  
> -static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_id)
> +static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_id, int src)
>  {
>  	u32 inst_mask;
>  	struct amdgpu_ring *ring = &adev->sdma.instance[instance_id].ring;
> @@ -1628,7 +1630,7 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_
>  	return 0;
>  }
>  
> -static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_t instance_id)
> +static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_t instance_id, int src)
>  {
>  	int i;
>  	u32 inst_mask;

