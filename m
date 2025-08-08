Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44030C87FD3
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 09:37:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC4A010E906;
	Fri,  8 Aug 2025 09:37:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JKo3Z134";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5DC310E906
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 09:37:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZAqA1BT6T1nOQRNhMK75Po0QZWYx9qiw1/jLy8DP7VWlIqM0Ea2lv38WBnjflJ1+C2YhbI+b4yLTVkIzjdnOl59D3SZWgzVrLUn92NNmCtVozDn6BNkSjL1Zd2rFUaGMlm0scGKFq+EE2jgTQG4dHeBtTXJRf3+70FN5db5XRLLMCsj06o0v7xSqJ2reLhmno8m+l/VW9MvQ6tz3miRhBbBB0rfODlgspUkTPV3Qev1jT8fWQNuxNSj1fM5BO2SkDbqZuMzb5uTMQPmPYGQ6fJMZE3ibL1JNnlrJ6a5esclHlHlx/w3rKs68r4SaDf3XduduC4kicJdBDj+kCNodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4g024FQD4UfqMiHtjaWkUbGwNPRbWssVer8xr6BV0Q=;
 b=Lhcim9IiPuP8yLuBwoDo0Fa1ACXs5e/zv17EyqIrBV5qrCPuKskVubeE3apBH8cEBV+92mzlqi+tgk3nJe8BNTm47ngDkkGMKz5GwzWoNEekQLo67VJv9iXxX6riwYml+UwTnW733PwOnLKHwReE0KxjlBHlETJbdUrlM3UaSI1YgWn6re1tnMe7q89/d1FWcr3xO3YpYema74/hO2+pHM0MlmqSzCZuQzHKGN6j8GQwqQhdWO0k8j8Uwsvd3v7CTlxMsJAAbcTaOZg0DjQle+jfG4eM6LOa4H0sI+6PmN85gzwd6DPjFk4p2CjAa0J+LFJqLk2ryuiYo2BoDrMnzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4g024FQD4UfqMiHtjaWkUbGwNPRbWssVer8xr6BV0Q=;
 b=JKo3Z134FR2urLZnBs+Z6FSVs7eDn1eLNt91TKr6Y3kNgYo0503PIsrld1NUVoL4L/IoMwb2iNtPSPonMVMNa7bn+5bEFP6CRQ7dOXzMSXonZ/EDwSggbh3f5Kaco6sxWROSLlRRhX9BWTMK7Ks9UGi7F9kNMVHVwcaWXawtyMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6881.namprd12.prod.outlook.com (2603:10b6:510:1b7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 09:37:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 09:37:32 +0000
Message-ID: <7a79f3c1-56ae-482a-8517-d946e7b70174@amd.com>
Date: Fri, 8 Aug 2025 11:37:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/3] drm/amdgpu: Add ioctl to get all gem handles for
 a process
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: tvrtko.ursulin@igalia.com, Felix.Kuehling@amd.com, David.YatSin@amd.com,
 Chris.Freehill@amd.com, dcostantino@meta.com, sruffell@meta.com,
 mripard@kernel.org, tzimmermann@suse.de, Alexander.Deucher@amd.com
References: <20250807202245.2970262-1-David.Francis@amd.com>
 <20250807202245.2970262-2-David.Francis@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250807202245.2970262-2-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: fb07278b-f3c6-4d30-be9b-08ddd65f32d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVdMRzIzdG1NUFdiZjlNTHcwZU42bWV6NHVwRjcvam1WNUMzRHJPUDRDR2hK?=
 =?utf-8?B?ZHVKUHhjVHVqZU5zdU9xS3F6ZnlGZ2w3aUdqcXlpdE9wamcvdzhLK1ZaZDRE?=
 =?utf-8?B?aU5rM3I5VFlWMUpaMGVIYUp1S0FXanJRZlp3YUNSZXo4WDhBRUFpK3B6R1BK?=
 =?utf-8?B?cithK0R0blpsRmVtSjVQRmVwM1hWWkdXdXBPcjI3ZW1UTDlWWGgrRGdWUWFq?=
 =?utf-8?B?aGg1dm1IMVFkM2VjRjBjL0lzWGdxUS91VndEQit2VVZJckVOVWROUXlUbU9L?=
 =?utf-8?B?V0NYekVNc3NDWWlKNE83YzhLS1BjUnQ1R3NVTkRHeGdNODNXUGgrc09qNFdB?=
 =?utf-8?B?bC9DK2tNSWREaTFSWDdBMDE2NVJTdjdFZXczbmYrbHB1WkZrRDFOVk0yMURI?=
 =?utf-8?B?ak1seHJZQzNFenNZVUdPaitudXA0Y0Noa3ljMzZTaERaWlZTVXdGOVdOUDVD?=
 =?utf-8?B?S0l4TkpwM0docjVrM05iSUd3cTZxTGY0L3kxblBkNXlIMUpBUDlLT1dTNVdx?=
 =?utf-8?B?SHFGTDRvd3gwQ0ppbTVmcTNEamkwamVLMnBZNmM4a1RqemNVNnlXWnlTby85?=
 =?utf-8?B?TjJZZkE4UHZRSEFkVjl1N05pVjd6bjRobDhyQkNwVm1pZS9xdWczNzZHYTJ2?=
 =?utf-8?B?OTc5OU0zRXNxd2tVYXZKVnVNZjFkelhCYnR4aTVPSXVLVUxYMzlvaXVsQTFT?=
 =?utf-8?B?L00wczhQUG9OTHl4SFpyQXErUnRHRjJHZGx0QjM5TjViVUxHUGpGTWhrSkRI?=
 =?utf-8?B?V2hQYVNROGtKMDF3OWE2dUVUdUFyb1FQYzFmVEFpbnp0UEJRS0FHK2RmbXVr?=
 =?utf-8?B?YkY2a0w4cmV0TmFIZXRoU1ZvMWIvbStHa3RpOXlEVHp1MzdNYnRPdFpWOVlz?=
 =?utf-8?B?NUpHQWRBeFRUYzh2VFA5M1o5Skc0NjYzeVl0MXRKYVBKd0EzSWhRdmJaVG9w?=
 =?utf-8?B?NUlQd2g3eEpOZzF5VldtZEZLckxKNmJqbjM1dHU3N0tmQVNRcVVlWENvTUFN?=
 =?utf-8?B?RWlKWDEvTkZncXV6VlROTHpLajBOTjRFV0ZEVUs5TG15dDVNdU5iVmFXQkRN?=
 =?utf-8?B?OSt5cGtudnIydzRqQnJNY1ljRFc5eXZUTW00Q2VqU3l0ZVVWTWUvVUU0K0dR?=
 =?utf-8?B?Vy8rU3FSWUpIaDRUalFpemkyS3hWR1RscG9FSXlILzFQcUh4WmVPcnJUNHpT?=
 =?utf-8?B?QkxRNHdqcnRQS3hpRXU3OWJSc2tPbzVkQ3BnOHU2Z3JGV2wxZisraG1XZmNI?=
 =?utf-8?B?UHV6ZVhSMkpDYUVBN2lwYWk4OWlDTElIZkZrQmlySGN5NjN6K0gvUDBGKzND?=
 =?utf-8?B?ZUpETmJubmd0R0ZBVUtkRENhTE1NT0NvQm9ISFlLYjFPUmN3STQyT0JJU01F?=
 =?utf-8?B?VGl5REhQN2hRdUV2U0RsdWtWbEcrMzZwdEtNVGVhTFVYSlJlYzhjb2xFc0l2?=
 =?utf-8?B?VUV6VUx0TUNpbml3RjltZ2VoUWgzdkVTc1g2STZmUncza2lqMXJhbGtYL2lO?=
 =?utf-8?B?RlFENmFMRnFLb3k5V1VyUVFOcWpUb3FTOEVlT1ByNlN4dmJFbFBiZ2NDaUJs?=
 =?utf-8?B?Wm9DcXVwR2tIbGE0YzVUbDA0cW5uenBGUlBPa1IwZjdwUmJ4SzZidXlwV2Z4?=
 =?utf-8?B?bk84L0NEYUhCQytaYmR4U1hHWGhOd2Z5bjJEWE9qOHVXZFNnY0VjRjBJUEVx?=
 =?utf-8?B?dEdpOFovTFNYRklYblZHdm82MTdaM3cwUDlOdjNTemRMWEcySTZPd240R0lC?=
 =?utf-8?B?ZUxUd3M3YkpueGFMM3hSd2hWNHNheE9hRUM5QWJ0UHE4VVR6d1J0OW1XRE9I?=
 =?utf-8?B?cW03elVheWNKb0dHa2JRdG9RTXhXTHhjZDVZaDhXRWNLdXcvQ2k1bmR2czlU?=
 =?utf-8?B?Y0tib3lYMlVtcFJWQkJHN0w4RkJaYkl2dW1YTWkxdk8zdjZEalRhc2pvclQ3?=
 =?utf-8?Q?Kzmhm0ts5OM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGNNWU1iQkVCelcvc2JaeXZqeThEbjdCSlFsZ2lQVnpuNWxFMlJNTkxTRnc0?=
 =?utf-8?B?NnFTQjN6dTNkWVRLdTZtY05ObFJiSk1ucXowWVpPOHIyQVNxMklFVCtxL0lQ?=
 =?utf-8?B?NzF6MFcyZnN2aGc3MUhJZCtGVGUrSWpzU08xRm9VVHVhVEdMNmhYM3JJcDNE?=
 =?utf-8?B?ZWE4eVlWRVY2Nld2c0NMRDdPT2t6bUtvVkdxN1RoOEVoTUZjY3pianlyS0NB?=
 =?utf-8?B?bWp5Mks3N25hN0xGYjRaMjB2K3dSd0k1Q1hiSXFzZHRhZVhQWCtMS1RhdEY4?=
 =?utf-8?B?RDFoOEwvYzgzYkpDTmlkbXpTZnVCblFQbkhONlZCOTA3OXNkZ1FVYTBuYWNF?=
 =?utf-8?B?VGtsK3IyZWNtdHF2QnkrUXNYVVdob1JTWDNJSE14ajYyMDJvenRTMnJZZFdu?=
 =?utf-8?B?eEQvOXRnK3pqMlhiZWlLKzNGdjZ6KzZsTkl3eEVTeFdpMzQycjdwdWU2S2d2?=
 =?utf-8?B?Wm15L0hON1Y2cVl6RVB1anpwNXhIbGs0QU9xYnJIZitUelAvU3hRSms5TkN2?=
 =?utf-8?B?WnRUSjNwTVptcHdmbU1oN05zRzM5amhkWGord20wZTl0NGVOYzJpdlVqZllq?=
 =?utf-8?B?aXljZi8xRGdySEV3SHZZbzBGNEFGdnZFa2VTSHN3UThDU0RsMUE0dytCSTFK?=
 =?utf-8?B?UGdIZDhyUlJEa3FmdHFYbXcxUGtFdWFkR0tCd2JoMGprMVk5Q1NBd0ZEV2V2?=
 =?utf-8?B?ODdJQUxycFl0cEJBbkhta09SbHExY1dkSWR2RWwydkdiRUlCYXdkc0pXVVdI?=
 =?utf-8?B?c1piVk0rMFJWck5KTkg5Uk1EWWZVTTB6YlByLzJkd3pxQ1ZYY0YrVUR0RjN2?=
 =?utf-8?B?QThpYmFIRENWalhGNFZleUFodEh4cFNxNWVIb1Y4Y1VqWFhoL1lKOGQ2VGRu?=
 =?utf-8?B?R2lLR1FYS2FLQk9vVkhkTkVzZFk1aEJFZmNVdHVFNXVyZjc3VW5YRm5NOWoz?=
 =?utf-8?B?SDlOajd2NXpJS014d0pHQWtZaVJYQTdhSUdxK3RHeFhTR1NadjJHVmh4N1pj?=
 =?utf-8?B?SFdYRU95U2RkMDJNUlFUYlYyQndCTkxQb0lVSWN1eERteXlycjA5U1dsUmhk?=
 =?utf-8?B?OFNNTGpHcVMyOTBHRVYraEVxMHlmN0JsUTZ0UUd2RE4xMXNIMmlLU3RjT20x?=
 =?utf-8?B?RFJ1KzdGdVdZMjZtMlVuclA1SEVpVlY5TDBsc2lncDlySEkvSjNqbnVyVXJC?=
 =?utf-8?B?MlJXR1JjS0xOek9MOWJZMUdjOEJNRy84bjdRbFFUMTVYRG1qWXhhZFdtUThK?=
 =?utf-8?B?ZFM2TnliUVowR0NDZG0vLzZvMkpzTkl3WS9meUhGQk9iTlFINmJJWWwxM09X?=
 =?utf-8?B?ZHE3ajlCd0VQTjVEQjNyaGUxZlEvMm0zQzZkUEIvM2djVVdrVG9KUzJjM1lS?=
 =?utf-8?B?eXZ2TmpkL0V2cEZocmtkT3k4eVgyVndPQ2h2ekt3NWF4cW1FcWVQTXVwcFkw?=
 =?utf-8?B?ZERlY2FIeXg1OFcrd3phVE9COEVOZi9NT1hZTXAvaWVEUmIzU3hXQzk0ZUcw?=
 =?utf-8?B?aUNyU2tDM1R0emRsdmxiYTZmZm5vZVE4bHNpNGphUE95MitHZVhXWW9jcnA0?=
 =?utf-8?B?Sks2ekZIYzdkZDZMbUxiTk9kaTNONmVzMXI4RnUyK3NBT3g2SkdiSWlPRUdR?=
 =?utf-8?B?MDBmVXRFYmhVU1FqcGZicUlVMi9CeFJwdGVMRCt1eXJZcFpZbUxwZk1MclFX?=
 =?utf-8?B?ZGhlZC8zZzBHVTJmTDkzQmlGekQ4OHNlRXBMUmIwQzd4V0NIOW5lV1B6RzdK?=
 =?utf-8?B?NUVJbmhOQWZMTHhXczdRMEJ1am1HWmdQa3ZyNmgvY3BmT2FUNkMrNnNvVEhC?=
 =?utf-8?B?bi9JZm1XQkZzc3ZRUGp3b1RyTndwQXVXdmVSbmNHaTZyTWN5VllDdHF2bVNh?=
 =?utf-8?B?bTZxdGprbHh2TUZ5OGlQSnEwMkhDK2FGM2MxK0p1WThZa0ZtVnlhRzVmKy9o?=
 =?utf-8?B?SEo0cFc4V0kzNk1UN243aHU4dk5OTWNNSGdGelNLUW55S2lKQlZ3VmxwcVJU?=
 =?utf-8?B?YWlBeHZNUVNvak5wbVRWbDFYZ3NVQXF3WENyNENTTGJUVnZGZzZ1d2pxL0lX?=
 =?utf-8?B?ZzNOWG1ZS3lEQXFIbVRrSDFDRHhEbVhZZEtFY1ZCRmNMMnl5dzZrUm5DRmVx?=
 =?utf-8?Q?oO0a0sZmtVL+dm+CXu43BxOEi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb07278b-f3c6-4d30-be9b-08ddd65f32d6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 09:37:32.2948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfFy1pYVKbLty2/LIWZuoBMl00tB5S/kQMKPCnxJkND/pGKqyQwjVY2Mq+OaiK1l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6881
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

On 07.08.25 22:22, David Francis wrote:
> Add new ioctl DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES.
> 
> This ioctl returns a list of bos with their handles, sizes,
> and flags and domains.
> 
> This ioctl is meant to be used during CRIU checkpoint and
> provide information needed to reconstruct the bos
> in CRIU restore.
> 
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 82 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |  2 +
>  include/uapi/drm/amdgpu_drm.h           | 33 ++++++++++
>  4 files changed, 118 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4ff3a2eaaf55..f19795dddf9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3031,6 +3031,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  };
>  
>  static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index e3f65977eeee..7f55e3b7d8a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1032,6 +1032,88 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  	return r;
>  }
>  
> +/**
> + * drm_amdgpu_gem_list_handles_ioctl - get information about a process' buffer objects
> + *
> + * @dev: drm device pointer
> + * @data: drm_amdgpu_gem_list_handles
> + * @filp: drm file pointer
> + *
> + * num_bos is set as an input to the size of the bo_buckets array.
> + * num_bos is sent back as output as the number of bos in the process.
> + * If that number is larger than the size of the array, the ioctl must
> + * be retried.
> + *
> + * Returns:
> + * 0 for success, -errno for errors.
> + */
> +int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp)
> +{
> +	struct drm_amdgpu_gem_list_handles *args = data;
> +	struct drm_amdgpu_gem_list_handles_entry *bo_entries;
> +	struct drm_gem_object *gobj;
> +	int id, ret = 0;
> +	int bo_index = 0;
> +	int num_bos = 0;
> +
> +	spin_lock(&filp->table_lock);
> +	idr_for_each_entry(&filp->object_idr, gobj, id)
> +		num_bos += 1;
> +	spin_unlock(&filp->table_lock);
> +
> +	if (args->num_entries < num_bos) {
> +		args->num_entries = num_bos;
> +		return 0;
> +	}
> +	args->num_entries = num_bos;
> +	if (num_bos == 0)
> +		return 0;
> +
> +	bo_entries = kvcalloc(num_bos, sizeof(*bo_entries), GFP_KERNEL);
> +	if (!bo_entries) {
> +		ret = -ENOMEM;
> +		goto exit_free;
> +	}
> +
> +	spin_lock(&filp->table_lock);
> +	idr_for_each_entry(&filp->object_idr, gobj, id) {
> +		struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
> +		struct drm_amdgpu_gem_list_handles_entry *bo_entry;
> +
> +		if (bo_index >= num_bos) {
> +			ret = -EINVAL;
> +			break;

spin_unlock() + goto exit_free.

Apart from that looks good to me. Feel free to add my rb, but I think Felix and others might want to take a look as well.

Regards,
Christian.

> +		}
> +
> +		bo_entry = &bo_entries[bo_index];
> +
> +		bo_entry->size = amdgpu_bo_size(bo);
> +		bo_entry->alloc_flags = bo->flags & (~AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE);
> +		bo_entry->preferred_domains = bo->preferred_domains;
> +		bo_entry->gem_handle = id;
> +
> +		if (bo->tbo.base.import_attach)
> +			bo_entry->flags |= AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT;
> +
> +		bo_index += 1;
> +	}
> +	spin_unlock(&filp->table_lock);
> +
> +	if (!ret) {
> +		ret = copy_to_user((void __user *)args->entries, bo_entries, num_bos * sizeof(*bo_entries));
> +		if (ret) {
> +			pr_debug("Failed to copy BO information to user\n");
> +			ret = -EFAULT;
> +		}
> +	}
> +exit_free:
> +	kvfree(bo_entries);
> +
> +	return ret;
> +}
> +
> +
>  static int amdgpu_gem_align_pitch(struct amdgpu_device *adev,
>  				  int width,
>  				  int cpp,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> index b51e8f95ee86..7cdb6237bb92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> @@ -67,6 +67,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  			  struct drm_file *filp);
>  int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  			struct drm_file *filp);
> +int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp);
>  
>  int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>  				struct drm_file *filp);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index bdedbaccf776..218a179818d4 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -57,6 +57,7 @@ extern "C" {
>  #define DRM_AMDGPU_USERQ		0x16
>  #define DRM_AMDGPU_USERQ_SIGNAL		0x17
>  #define DRM_AMDGPU_USERQ_WAIT		0x18
> +#define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
>  
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -77,6 +78,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_USERQ		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>  #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>  #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
> +#define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>  
>  /**
>   * DOC: memory domains
> @@ -811,6 +813,37 @@ struct drm_amdgpu_gem_op {
>  	__u64	value;
>  };
>  
> +#define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT	(1 << 0)
> +
> +struct drm_amdgpu_gem_list_handles {
> +	/* User pointer to array of drm_amdgpu_gem_bo_info_entry */
> +	__u64   entries;
> +
> +	/* IN: Size of entries buffer. OUT: Number of handles in process (if larger than size of buffer, must retry) */
> +	__u32   num_entries;
> +
> +	__u32 padding;
> +};
> +
> +struct drm_amdgpu_gem_list_handles_entry {
> +	/* gem handle of buffer object */
> +	__u32 gem_handle;
> +
> +	/* Pending how to handle this; provides information needed to remake the buffer on restore */
> +	__u32 preferred_domains;
> +
> +	/* Size of bo */
> +	__u64 size;
> +
> +	/* GEM_CREATE flags for re-creation of buffer */
> +	__u64 alloc_flags;
> +
> +	/* Currently just one flag: IS_IMPORT */
> +	__u32 flags;
> +
> +	__u32 padding;
> +};
> +
>  #define AMDGPU_VA_OP_MAP			1
>  #define AMDGPU_VA_OP_UNMAP			2
>  #define AMDGPU_VA_OP_CLEAR			3

