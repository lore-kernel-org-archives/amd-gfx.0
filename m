Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED820C35FFF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 11:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DF4F10E7A3;
	Fri, 21 Mar 2025 11:02:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nvVDTEfs";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E09210E7A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 11:02:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=coYMjO0hbaA0UsGuJMMYL3nUssDzi+sHGypEH/oJ2vfu+Iy7nWHCckbCQAgbGZkecGqJLbJiL6y1s1OARct2D/6fmVK7Q9kdPMwsQVs64wVBmwlwp6F0gM78Wx8NtlYL9IkjgYyOADGuEsHRlfrk+pe3h+pmWOEkWciNqmip5KxITO7IVUqHhcSNgNuqIuHPpdrkdit+xhon7l5Tv/cMeSuKG56Ydh1ENDVE8mf1k8HIY/Ef9oXNSTWL8HVkzaIIRPYZ7W09Q6HFe2ugGulixguKr+CzLyPzH41Mfs5MuAb8bmtglC55gN0VfF8zuYqlDkDagRHNUP3mIhY1olK+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iU8FZ8PRG1baTPcQ8jTmwqToRqVsiHDRKNcyBNo+IK8=;
 b=m1M/0QoNooBQD6OTCC87Yc9YNixoYPslJSerA4iwz160yevNvxsQ5R27qgPkfpdX+G2E9KrJCa6cyh9z1Vd3XXHwtJ1h1k258KGzGn0DQKjGtQCebVrwymnpJ20dSL1gZwQBn8R/PKQlP1qjaFiEkriSwTje9qArfTiTRctquBw8LPtfHzPHvzTHFmcn0gqCvCHzKuwoLwGAKBeLxXzszHNHPx/LSFGCKMAj8XSlj7Dp49trmBAUPQgvyjUud4DrG2QrOT1FKvQrKj5nBTF5Nr5KecwXJ873XkwJYSqb/Hh26nsdbYOzNJ+SjV3GuM/binFFU/e06yuig0WMl4nCQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iU8FZ8PRG1baTPcQ8jTmwqToRqVsiHDRKNcyBNo+IK8=;
 b=nvVDTEfscmcq6u3vG49EFuG5I5V/j9xsjhX3EdtqCJhY72j5dJoe+UXmqi1MmRB8Pl9UpPBrxuJLLobqpzWofFwzAZeoWR03Vq/TIfkC+cuNX9FCXgeXeAj37tVW/Aw8kAc/YeUR5G/5BdzNVdeQa8QWrK3LVZ6hq822iPU4EoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB8602.namprd12.prod.outlook.com (2603:10b6:806:26d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 11:01:58 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 11:01:57 +0000
Message-ID: <fe157939-ffcc-492f-b8cc-fd7e751449ab@amd.com>
Date: Fri, 21 Mar 2025 16:31:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Update feature list for smu_v13_0_6
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, Yang Wang <kevinyang.wang@amd.com>
References: <20250321103346.1284734-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250321103346.1284734-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0199.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB8602:EE_
X-MS-Office365-Filtering-Correlation-Id: 8776a0b5-689e-4ece-daa2-08dd6867cc2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDdQb3JLOGJuOEd0VjRKTlg1cUtNR0tQbURPcWpwS2ljODJXV2MyZEE5dTJx?=
 =?utf-8?B?R0JLWFlhNmJEbUxGcWZwSXgyTFVRcERUaFNWbjJacFRTbDQxRVdoN0huQmw1?=
 =?utf-8?B?TnVwRDdWdHMxMkRCbGVFS1lIaVhyb3pCaFVDZFN1bE5pTml6VENHZkxNaXVX?=
 =?utf-8?B?U1V3c1F0VVNsNDJMOVNDL1AxZ3hIa09HUTl4dytPL1dVT2dHOGpSVVZFdmlw?=
 =?utf-8?B?T0cxZS9sK1lEeHd0dUFJbEl5MzZEbURKV2hpcWttS0NpancwUk5nWGh5TzRi?=
 =?utf-8?B?bWFCQXVMbHNyUHFTTE95a1lubURLWXpYWW83ZUV1WElvV20rTzJ3eTZYRjU1?=
 =?utf-8?B?RkVDR0RubEx4OFRPLzVIb25TdU9lalplRzg0Um5BVWVxWXhud21qc1U5VlhF?=
 =?utf-8?B?dEYxaXdvQWo0N0cyODFkclpuQVQ3ZGpuYjB2eS9WVXFnNHQrUFIwUFhDb25i?=
 =?utf-8?B?OXNyazkyTDdEVzROclMvekRua1hZUmtjbFEyWXZvTjFmZUlwTzZ2K1NjRVhY?=
 =?utf-8?B?d1lZUW9JT1RQOFMwaCt5bklvN1NrcUtxVlkyQlRvUkt6NW9veEdKQllNN2pp?=
 =?utf-8?B?S21JT2hmTWdOUm14ZUtwNkV1d09ENXVLQUlGbk5TU0x5YUhtcG10L3EzaEds?=
 =?utf-8?B?ZEQvSVlJRG9lVmJDeHFLVmFoMW1wR2pDZGl0TXBld0xXRHZJUHRIaXMvSHdD?=
 =?utf-8?B?eWRBWDZuTzlwQjBmUjdocWtGT3c3Ylh0TWg2OTVCOXJ1N0Mwa2N3a2tQM3Er?=
 =?utf-8?B?eWhqcmFaWXhOS0tTUHFMS3FBeDU2bDM2TmhFVkF5b3BlTTh1RHNpdGhrNGpT?=
 =?utf-8?B?UWw0ZVlyUUtOdWhZQ2UrcXRLL3kva1laVDVJYUl4TzhkT29yUWhYdnd6d0Vp?=
 =?utf-8?B?SkF1OUpOSFFqRTJKdzFDNUFMWEdsTG4xUWhyVXlnazZJTDVjVkd4bzkxYzFQ?=
 =?utf-8?B?Z1FPY2tMSGhZazFrLzZBKy9QU3JMRHlEVGtnYVc2WDVYOE03UjRWY25vVnpp?=
 =?utf-8?B?NVE5ZlRKbVBvcXlkTlRESXRrcVk2M1czSisveWp5WXJza1NIQ3dPWHhlV2dU?=
 =?utf-8?B?WEJ1YmhYeDZPSUxmRG9SNEtkdzdwVVZ0SEFQREFhck5yTCtkNEx4TTFYYnkv?=
 =?utf-8?B?cjduYzRqZVRFdGNHR2IwakV1OWp2Q3N6Mmp3dG92M3BDWVpHUXZ3QmM5RW01?=
 =?utf-8?B?NTdNc1J6eFZBUng0V0d6RU9qUEt3dC8rdk9Od1haYnR2S2x1RWV3VHgrdWxt?=
 =?utf-8?B?VDlzRWlrdS83REFIMyt2M2E4RmFOUFhTT3lVYk1HTUZWK1lZQVhwZnF3VUk5?=
 =?utf-8?B?Vk9jSGRkd285aEV4MTVJQko4M2pWcUZBZHZaMVJzaWN4eUhVUld6VUE3VFJI?=
 =?utf-8?B?cGVrbnZuTkQ0T3liVkZHdXNiNUoxMERmVVNwc3hBdDNmS2xKZzRKYm51dWlj?=
 =?utf-8?B?RUxoUHU0RzFIVEFiNWNJdk9Ga1dxM1l0NE9GQzBodWdHVXpvR1FHTjRUK3Iy?=
 =?utf-8?B?aGxicEtuQjQxNkt5S2ZIbzUwUFFMVDlSdm5pZnZRUE1Kd29wUHBEK3dIMENw?=
 =?utf-8?B?ckRRSjI2d2FKaE9DeVFWTjA4T0cwbVpzTlhwdHdFWW1KOHJGMFJ2RkVFVUd4?=
 =?utf-8?B?b3BncHhadU5aSTdXQmF6ancydWNLUzd3MTU3Ujg1ZG1PWlg3ZUYrV1VxR3Iv?=
 =?utf-8?B?NHk3M3BHdU1hMHVIZUtnTHRRSHkzQ1g0WVlsUDZ4TGMweC90Wnk1d2JBbTNQ?=
 =?utf-8?B?V1d0S3g4Tm1JUHY4Snk5NXdyS0dKOG54UUN5VXRxbFV0cFo1MXNleXk0TWpn?=
 =?utf-8?B?dGVxa0pINUhwbTJVNGFvKzBid2RKTTRERldhTXk0V0p4aUloMExuTk13OTlX?=
 =?utf-8?Q?xP+Kigt8cs/OI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVlWeXk0UFQ5VUNROUZCakdZMk1LcjU3QklmZ0lrcFdkL2Z3UFQrRjFsSEw4?=
 =?utf-8?B?YXl6aG9EWXlmNG5ZVVlNWHYzTDZ0ckZKcW9sbVc1RytPRTVlT3hJWG00MnJR?=
 =?utf-8?B?NkI2Sk0rbU5VUGJkKzgyb2FMS1ZTZ0Q4Nk5CalFUSm42OW5Xang0WXBIWjhr?=
 =?utf-8?B?cGpFeUNkSXozWWhmdHRyZW5DS2xoV2lSbS8yNnVLU3BRNFkyQ2UvanpTTEpF?=
 =?utf-8?B?MGo1TXF6b0tONyt1NGZmTDJXbk9aam1IcUNKeitvUTBZZ3QvQksxN21RUGxJ?=
 =?utf-8?B?Mnp4ZE9qTHFhb2dUUXJtd0xjZytkc05PL3ZkbkJGdld6ZkFhV01uZS9uVHVa?=
 =?utf-8?B?WkR1TWJNY1RWcVFlbDRiZ2NuMUx6dUdhTzQ4NDRUK0Y0eHVaRjB0Z0FkMUx6?=
 =?utf-8?B?UzRaVDFSd09JZGFJSXh4VWlTUFZ1RTBoY1dMbk00TG5WMWJySGg0QmkzM1hO?=
 =?utf-8?B?TnVRWTcvUmtacTYxeXQ5ZXRsTjdDWUR2ZExiUFBFOEwvTXhjOElwWmVKdVRQ?=
 =?utf-8?B?dDROeDJnNkNkUWFEZUxrMW9YUzdWSEJCak95MWdhd1JIM242SVp1RFIrYnZN?=
 =?utf-8?B?WjB1OGZOTW11VU1tVkFlb3RCUG13QWI5UmcrKzlqRFkyTWJmbWlOempINXRK?=
 =?utf-8?B?azQwbXZlbXVSSmg2dUNxYWtvQmhBMHcvVTJDbnJnQ0toMjg0ZzlXZ0JoKzM0?=
 =?utf-8?B?TlFpeXhUTXVGMmVJalJwMDROcERUY0RUN1RPa2lYUzRxQ05ZRmhpOU5Xb3Za?=
 =?utf-8?B?QzJ0RUQ5SGowOXhzd3FXWXVIaFllS1MrY2k3ZWJrL20vYTV1UC9GeERZejRw?=
 =?utf-8?B?UWNCUU1UOTJUTlhLL1B5SHpGK0pGdzQ4WVpWQ1Q4dTNGMjJjVHZ3SThWaW1O?=
 =?utf-8?B?TFVDaUJLQ1lOcEtxcVhLSTFvZzNDUDNrOEIyR0FVMFVhOHRFZWRvMlB5OXhv?=
 =?utf-8?B?bi9vMVVOV3NUVnBjQ3NRaVpaWCs0RWhYcTFWcEZQSHcxSzhZUVdQQ1J2Z3JT?=
 =?utf-8?B?anNPclg3Wjh0WWFZbnkrRUE2UTRKdlpmZEYzMWMxeUJZTXdNcFlRbVVDL1J2?=
 =?utf-8?B?NFMreEpHZ3NZd0Y2U01RNmFSMHBHUGVXaEtWbVNKeC90SkM3ZGJ2aGl0VTlC?=
 =?utf-8?B?M2F2WUZ1TGZiZjZiR1lUSVNSVTQ1QTgxV1JDRFN4TVJFQmEyUmRhTmRNNi9T?=
 =?utf-8?B?NkpsdWVPbmtqdXJxa25yTU5KUVdhSFArY3NLbXZqZTRNb3N3Wlo4ZjhIaWl3?=
 =?utf-8?B?WWc1ZTFVTDlQTWpzL0g0MFFaVEdtbUFkVHNyQ0V2ZXo2dnpvRDllZEw1MDNt?=
 =?utf-8?B?aGI4S2hhNWRyRlpmWnNMNlN0Y3JCTG9seEVsTVlNKzgrampsYWtablhhMjlU?=
 =?utf-8?B?VC9PVlFnTEdWNkFiaHA3Y2xjZDFHRk04dGpGNWVuS2Fnc0NmRnYyUW1wL0lZ?=
 =?utf-8?B?TjlMYlJ2aEVORVkxZFZpU0dib2x0Q2lFZmc1RGpNM2x4azAwMmh2NWJTaHIr?=
 =?utf-8?B?dVYxVXJHZ0xkdm9mQkZ5LzROYjBRNUdWZjRzeWxoYzgwT1Y5VldjL0VjMk9F?=
 =?utf-8?B?ek5iQ0NyVUdGWVY5bUtDaGdybWErU0crRUp5cHVqQThZS3FwcEdzS0lodjA0?=
 =?utf-8?B?K1dTRWdzZXFLSitCb1p4MmlpT1kvYm82bzlNOHBoa1hvREZyTkVJT0xVMDU2?=
 =?utf-8?B?VklQN2xUY0o2TXp0TW4vb0pHZzBqZGQ1eE1icTg2N1VERHFPOWZ5dnBTU21P?=
 =?utf-8?B?VUhLWVY0NXIrZHNPakFxWmtRaWhxcDhLdFZ2TUp3UGlzZWFyK0kwNVhhekV3?=
 =?utf-8?B?NHFLay9WU2FUS1JxbjhSODlyeVJOSGFkZDFEQnZzRXNzbFA5alg3L1ZoNXdq?=
 =?utf-8?B?QWN0UVFVQjZLYnNtWStmOFFvWGRCckxiMnZWRTBQT21GUDdFNWFnSzhaRG4x?=
 =?utf-8?B?a01VRGhqeDhWZUJjdGpNdGZyRFJlMXVkSnUyUFBMQXZ6aTdmakdBbmlXaXRv?=
 =?utf-8?B?N252cXZXb1FUelR3WUdVTngrUE9vdGVhS2kvTUc1SklRZVlINHAzU1J0dzZO?=
 =?utf-8?B?YVBhMkViaHkzVjFuU2RQOHdON1BxMEtaVmhQSzlmR2ZpcmFVcEttL1k0Nkpz?=
 =?utf-8?Q?NbnbrigGvlmPKY8eF2vAkC9k8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8776a0b5-689e-4ece-daa2-08dd6867cc2b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:01:57.6765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /43cR614diBEd+PV3kuuMORDU2ugQJZV4O7pgNPiqPPxmSbaCCmKDjrymYOaPqNj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8602
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



On 3/21/2025 4:03 PM, Asad Kamal wrote:
> Update feature list for smu_v13_0_6 to show vcn & smu deep
> sleep feature enable status
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index f2837dadd897..682646068000 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -231,7 +231,11 @@ static const struct cmn2asic_mapping smu_v13_0_6_feature_mask_map[SMU_FEATURE_CO
>  	SMU_13_0_6_FEA_MAP(SMU_FEATURE_FW_CTF_BIT, 			FEATURE_FW_CTF),
>  	SMU_13_0_6_FEA_MAP(SMU_FEATURE_THERMAL_BIT, 			FEATURE_THERMAL),
>  	SMU_13_0_6_FEA_MAP(SMU_FEATURE_XGMI_PER_LINK_PWR_DWN_BIT,	FEATURE_XGMI_PER_LINK_PWR_DOWN),
> -	SMU_13_0_6_FEA_MAP(SMU_FEATURE_DF_CSTATE_BIT, 			FEATURE_DF_CSTATE),
> +	SMU_13_0_6_FEA_MAP(SMU_FEATURE_DF_CSTATE_BIT,			FEATURE_DF_CSTATE),
> +	SMU_13_0_6_FEA_MAP(SMU_FEATURE_DS_VCN_BIT,			FEATURE_DS_VCN),
> +	SMU_13_0_6_FEA_MAP(SMU_FEATURE_DS_MP1CLK_BIT,			FEATURE_DS_MP1CLK),
> +	SMU_13_0_6_FEA_MAP(SMU_FEATURE_DS_MPIOCLK_BIT,			FEATURE_DS_MPIOCLK),
> +	SMU_13_0_6_FEA_MAP(SMU_FEATURE_DS_MP0CLK_BIT,			FEATURE_DS_MP0CLK),
>  };
>  
>  #define TABLE_PMSTATUSLOG             0

