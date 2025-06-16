Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE29EC71155
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 12:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 557EF10E385;
	Mon, 16 Jun 2025 12:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WrmMRpAz";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 142CB10E385
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 12:16:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scgaoPrdjDMiq/Kl3CUviMDjBU1f5SJsdoHmHVveM5scwmN2EsjA7cOWzNLARQmErgalVMKl2o1MBb5qXnQeAwyRVOCiSZDlM+RKR82BWeeEoaQXRpMKg7VAmBEOLk8Dl/eTD6B8whD8fBj2GBLEeZMu+VxCZ1dZZ8ChKip6uZtGrdu8LjAF1VWHCUc6jbWS918+kguYwwMXmhYyS0lkv8zIZrN2QJG0wmQyqJqbUm6GoiROq1Y8TA56N7VgJgfjMuNP4rqPPLxMMcJAB/xkaUzAgMEg4gkIYpfPSq7OrICgRO5u0q3CGBEbi0xEvwEEsjEs2w4nAILDEXyJ0ZQajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zkc37NAormTeAelmQQ4PBqKZ4oYJ9qNJv61wU39XiGk=;
 b=xFzSUCBBQTpskwKq38aecG7iKdZ9KKMMwHVvJH/MFSuRTo+7RK0YML10GsmrRKQ076sWzTmt/VqKGxWkVx4X5Br4Z0uYbozyoqa5X3kdvYs8BmgQyF3Ez9j3fsk2mCotWUg1tChKWFPe5RBk76mhfohpT/LVWRUVlMRjovKJ/GRJHr1ASwMowSf+ZsoHyVQtv68IVeGWOh6zm9OzgLYJCwBmlI4M8paQXbGRdn32Wl0zxFzctnHXhKrETEfRcy/GiyrR/8o4DnGI0z/Gfs/t8P4r6kEa93k0mkQpmwD6W2nhHT2PSIjYQe3WUJzBvz6fy2o3WWPMFn1kQAoL9QKHsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zkc37NAormTeAelmQQ4PBqKZ4oYJ9qNJv61wU39XiGk=;
 b=WrmMRpAzA+D3Urpt9EHJHj8qrWsdrJvIhUD5Be1d0qPmflitLaZ073yVwFxw0VVducJ36RTi5+GN1FfCvCg29q3okdXww6oUc/R+05gyTnvDax/h2d0aCvOvNK9DLc9ps9wG1bqF3oSdQBjeQ7B85c28Y1Evs5v4Nw8fv0OiaPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 12:16:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Mon, 16 Jun 2025
 12:16:09 +0000
Message-ID: <29965831-bf4c-4a00-b619-9782b8c6afae@amd.com>
Date: Mon, 16 Jun 2025 14:16:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/27] drm/amdgpu: switch job hw_fence to amdgpu_fence
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 sasundar@amd.com
References: <20250613214748.5889-1-alexander.deucher@amd.com>
 <20250613214748.5889-2-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250613214748.5889-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0227.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d88bfee-ee8e-4017-156d-08ddaccf93f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlFncmlsMjNsVzRrR0h5c2FrY25ITnpoaWY5UG5PaVhKY1kxemFpc2dIRmMr?=
 =?utf-8?B?YklFNk0vSEtvMEY0cU5iQ2s4dFppczhoVGZ4UWtXZE02ckxvdUJXLzZNcE5J?=
 =?utf-8?B?dkg0MGJXUzZkRHZRTGZJRHhkT1FZWWdFQ283TEc4dlNTYXQxVXR4NG1PeWs1?=
 =?utf-8?B?ZDBTUk5lSjJSQjFic1l0a0E1YlRYaXFsSWJiQWRyU0FHMUMvV3drMkhHYWxn?=
 =?utf-8?B?Z21VK29QWlJBOFhJSWo1VXFiRCtJVTJndHpIZzhGRnRVNVBxUjBtRmsvYi9X?=
 =?utf-8?B?Wi8wZGRNWC8zL2tFd3hCb0FFNnZ1Yms3TjhxaEQ0L0NEaVJteUdFU09pQTc3?=
 =?utf-8?B?c3VCUUNpT052Z2VEZ3U0dmZ6Qy85b1dSNW5MbGlBS0o0VFNheTUrTVNJa2c0?=
 =?utf-8?B?T3JrdlV2NmVkVVdzMllpN3RQaC9oekQ4WXgrTVU5TDA0UCsyci9nMzh6WWUy?=
 =?utf-8?B?S1NsbHYwaUxVdDJzQy9RQS9ybmZKQkNPSUFmWHl2MmhXejVqbGNoWnJpb0dt?=
 =?utf-8?B?NnJNaThMd216RWd5QWNySDFKMEtMeVQwelhlMHZyV2ZQZi8rc1ozdjZSUVo2?=
 =?utf-8?B?dytCSjA3TmdTSUVkZ0ZtY05zY1Zwd0U0VzBLOHZmSTFPWWpWMnpucEZPU0xB?=
 =?utf-8?B?S0RUejJocXFVYVg2RmZZemR5N1REaTVadXo1dm9MSVphWWRrSk81SEZoNTJ3?=
 =?utf-8?B?UXZCSjZmOXI5VERWWU00aTlZWHluMGIxcUFpVHp1S1U2aFFNcldweWNnanRI?=
 =?utf-8?B?RXdzRjBzdUk1YjVseUltOVRzbllGS0tQYWkwT08vS1MzL1hrSkFhYkpHdFdH?=
 =?utf-8?B?L0s4SEJjZnNMN2h1NzZJYTEzNXJuSWgyN2U2MlIwZUJWS2xZeXkyWUk0MGU5?=
 =?utf-8?B?V3ZybUgwZGJWNmtFLzNZK2M1NURiUzlnODVzWTZVZTVyTWFCckhBRmRRVXJU?=
 =?utf-8?B?Syt1bXA5OFg5OW1HZkk4UERYMHFKT3ZWTGxMQkxPZVlsVUN3b3kwMVZSSHhx?=
 =?utf-8?B?VVROWHFLclNyY29Za0h6SFhxanpYYkRGeVl4ZWtncEtPZ2lHc0xHZnJSVm9V?=
 =?utf-8?B?Z0RLS09idGJNc3hhS2huOU5GUCtwZkNIMVROREhQbTVjeDBlUVU0OUhmdk1L?=
 =?utf-8?B?cjE3L0RwQURRZzhmSVl0WWVveXJGYzdJdEJ5L3cyWDcyYk9yY1ZZdEJxd0ZR?=
 =?utf-8?B?RWpBMUpWZU05V3J1QWF1enR3WkFYNU4wNFdVZ3puU0ZWdGxzNDFVa3N6dzlG?=
 =?utf-8?B?ajNtVmVhSXhmai9zaEh3RVZzYjdsR2xiSUtCNC9QYUdHQ3JQOVlXNVg4cCt1?=
 =?utf-8?B?S2dVaEpBOEZJdkh3dDhDMU5BU205RG02blAyNFJrVEh3ZjVmT1paMUFBaUdD?=
 =?utf-8?B?Nzd1OVJ4VU5icjJmOUh1MllCK0ZpbVpVS1lyZDVtQXlFci9tVkN1QXI3cWx5?=
 =?utf-8?B?UUhoTkZ3bXR4WFMreGsycjZsMGZ5MXlTTSt6U0l3clJ3c3dxTCtLWWhQeHBC?=
 =?utf-8?B?dlhGajZUM2dVRGRxeFZGOE15K1d0YkpGc2x3KzlQZzBZVUdWbnJtdXdXc1ZS?=
 =?utf-8?B?WjJsQkI3NGVnUVJFZjlLNW54WmZLZC9VL09lQkpXQWRzdU9KQkxQOFpKcnVH?=
 =?utf-8?B?TUU1SzVlRXU1SElJODdRRlZSbGVUUVJPUmh5QThBTVFhNDArMFU3TFNWbzlC?=
 =?utf-8?B?VU1yaytTN0xqd014a3FiTVNyRkV2ZGJ6ckhEUHFKSHJialZVd1ZHQUY4SEJO?=
 =?utf-8?B?NjFxNFh2OFRwWlJPV0dJZDhCYXBuWjJoc1dEWVVaUW5sV1pRMlhQZmV1YXc3?=
 =?utf-8?B?U2hiTWJZbXQzK0RZbDdVMWN6VzBXckNldFFXNFhOT2l4VjVvMDZ3L2xKelNy?=
 =?utf-8?B?U3NhTUJaUXA3aWYxb3JhQVJCRktPc3BRaTFKWENlM09SS1FoZ3VkcU9jSU5s?=
 =?utf-8?Q?E1MXzu3i9Zo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VC9pamovMVZBbVdvak15R0p5U2RiRTRaU2dTWVJCV1U0cm15anRZTzBNQnhS?=
 =?utf-8?B?WVB1ZUtpWEt0SXRQVGU2U1JBNGVhc01NK21Kd1NmcW1pRGpuOWk2UitQRHJO?=
 =?utf-8?B?MGNTdytVc1RIa1hwUXpXYTNlOGNDdjBtV2FBNXlPalRCWE5vZ1JodVkzOHY5?=
 =?utf-8?B?SDBGTXF5aE42T2xnUmxzQTJFOTZDZWxQa21SZ3lrY0poWnI1aGRhV2tuOGFo?=
 =?utf-8?B?SjFZeUhSSUtCbEttbzBmNkxvTUdYRStwaVY1bDdSYkg2VENLaXcwMis0cDFC?=
 =?utf-8?B?SGd4K3lSWmZyRmh2bExFV2JPWERxSEdxaTRhMjNRMWtJWnJDQzNpVjJpajNR?=
 =?utf-8?B?Qm1HTVJVdEZZRVR1SDNtUlM2YXhGV0pvdW9JUkRDVGtURlFHS0RXMGpHQVhY?=
 =?utf-8?B?NlV1bnJwUENKVXpXWEV1UlVRUzdzcGFyRi9vdlhISUV1cC9IYW5GUW1KeFRh?=
 =?utf-8?B?OVBIS2RjemovREZGREdUNWJVTGwzeWFINmdyL09HZzJKMyszSkxUdzF3NnQ0?=
 =?utf-8?B?UWtkWjJUazRJSmpIQW5oSkNYV2hNVXBzdTZ5RFBGekJLVmtMR0FyaVlNdFZG?=
 =?utf-8?B?aGxiem5MLzFHQWlveko0Mk9NNUYvejVYTlhycjBVckxDcURTL2JveStVR2Fa?=
 =?utf-8?B?aUFJWDVoQ2N4aXlEZ01RWit1ZlI1RzlGU0xJb3NLeGYvaVZGK0dVRUJOV3JF?=
 =?utf-8?B?Ny9yc29BWXhJMUFFWGJ1Y0VUbVFpaldHTk5wVjJHK05Jd1Q3NWtxeXpDbDNs?=
 =?utf-8?B?dkYxbXA2QXdvdWVEVWhSemU2a0FPb21ZTHlocFJGbm1PNlYwakpTSnI0U1hx?=
 =?utf-8?B?V0hDVzhQR0tTampvVDF3djRBeTFFNnA3MGFzM2tPM1ppem4xYTVzQ09YMjJr?=
 =?utf-8?B?V1R4SGdlUG9mOUlFOFR4VGpKdzZNYzlNMGlOSjM4SjVjTlhGcDZoaHpKbjhV?=
 =?utf-8?B?eWtnajRtZGIxN2hBbDhHYW9lUHd0akloOFJianRRYTEvRDQvYVlxZ3QrU29q?=
 =?utf-8?B?S2xkOENXb2daWldZeVNTWVRJRUxuNGRnbWVBN3duWVloQWtpZUhQNG1zSC9Q?=
 =?utf-8?B?QWZlUG9kbWFOSFlLejNOQ1RCVWFkSUJGVjRrOXE4ckgzcXErVG5lNEJYNGty?=
 =?utf-8?B?RzA2djNiQ0ZxYzdYUFcxNnBWVm9ya0VwYi9ZbmhIVldGS0pjalNkSktMcllp?=
 =?utf-8?B?bkY5MDUvYjFvQktGVVYvNkhlQms5VUdIRnlZUDJhRTYvNHBNNjZUUWJHcTRo?=
 =?utf-8?B?OUpiZWs1THBHU29NRitsbi9XUTlwMHdLcWpQWGFsdlZUK1RWVDhDM01SU3hi?=
 =?utf-8?B?WTgxeFlBNWtSMXg2ekdqN094WEFaRFJEZXFXZ2dnWlVxdVA5QXB0RDlrTStx?=
 =?utf-8?B?NVpkR2c2VGQ4dEFrKzJuTXVWQVBUM0tTRGl4OU9qT09WYys3dUY5aFpFWE0y?=
 =?utf-8?B?ODJnVjIrOTMxOVlqb25sK0c3MWJvYUVVSk1aR21tRnNOSWhIM1kyeGtvQisx?=
 =?utf-8?B?S1JZSWsxZlBhSW9CcWFVeDdSN0ZZWUw0L1V3SXF0UW1HaHN0NW5MNTBpUVNt?=
 =?utf-8?B?YzFabzRLMG1PR3hlSVgwa2lVSEYxTnFUdWZ4d3p4ZFBIOW8rWVIyM2lHeUNh?=
 =?utf-8?B?SlRZNWtGSFJVdmQ1NUxGcGVzYXVyNmRrOUI5Zit4YXlKUDJMdWxIOWNwdnBP?=
 =?utf-8?B?SXJnMEl0TzVabnVlWSt3R2dZZWxhdEhId2NzNjJXNDVzL1BCVnkxOVgzbjM2?=
 =?utf-8?B?MlFhQlowaVZ2MHViYk1VcDZyeTBDT0pBbjNhdzY4V1dBdzJudWFDMHJKd0M3?=
 =?utf-8?B?VDRCUmxEZkhLMUMwRmtxTG5DNHdnSGlYV1luVzBSQm12VjZJRXZ1MzFESHBs?=
 =?utf-8?B?MlBiZG5yZmF2NFpFV2ZlenY5NUhxVTRBM3NqL3hnM3JjekkzL1FJR3hFT2pK?=
 =?utf-8?B?VjMzR1U5NmpHbjFUWXVzN0JyanFMb3M0a2dKaTJ0TzRkSHZyYm9ibUc4dkt3?=
 =?utf-8?B?d0R6STNpMUFYbUJMMTRVWmtpWHNwYVFUOXV0TUluZlRXc0JicEw3WlZ6YmVw?=
 =?utf-8?B?aGdZQ290REFZWVpTeEdic2FHT0ZqYldKSVIvOTVHRGNQZ0VYR0dxa0tNLzBT?=
 =?utf-8?Q?j2wIHqshEWoTjgbB3B6cymKBS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d88bfee-ee8e-4017-156d-08ddaccf93f3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 12:16:09.8636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjztQr3bj+1SU7/8QZbtSrBY178af/dnaZrKVWAxU9iHXI2VD5PyC2nT1EKGnx+c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003
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

On 6/13/25 23:47, Alex Deucher wrote:
> Use the amdgpu fence container so we can store additional
> data in the fence.  This also fixes the start_time handling
> for MCBP since we were casting the fence to an amdgpu_fence
> and it wasn't.
> 
> Fixes: 3f4c175d62d8 ("drm/amdgpu: MCBP based on DRM scheduler (v9)")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 30 +++++----------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 12 ++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    | 16 +++++++++++
>  6 files changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 8e626f50b362e..f81608330a3d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1902,7 +1902,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
>  			continue;
>  		}
>  		job = to_amdgpu_job(s_job);
> -		if (preempted && (&job->hw_fence) == fence)
> +		if (preempted && (&job->hw_fence.base) == fence)
>  			/* mark the job as preempted */
>  			job->preemption_status |= AMDGPU_IB_PREEMPTED;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 00174437b01ec..4893f834f4fd4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6397,7 +6397,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  	 *
>  	 * job->base holds a reference to parent fence
>  	 */
> -	if (job && dma_fence_is_signaled(&job->hw_fence)) {
> +	if (job && dma_fence_is_signaled(&job->hw_fence.base)) {
>  		job_signaled = true;
>  		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
>  		goto skip_hw_reset;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 2f24a6aa13bf6..569e0e5373927 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -41,22 +41,6 @@
>  #include "amdgpu_trace.h"
>  #include "amdgpu_reset.h"
>  
> -/*
> - * Fences mark an event in the GPUs pipeline and are used
> - * for GPU/CPU synchronization.  When the fence is written,
> - * it is expected that all buffers associated with that fence
> - * are no longer in use by the associated ring on the GPU and
> - * that the relevant GPU caches have been flushed.
> - */
> -
> -struct amdgpu_fence {
> -	struct dma_fence base;
> -
> -	/* RB, DMA, etc. */
> -	struct amdgpu_ring		*ring;
> -	ktime_t				start_timestamp;
> -};
> -
>  static struct kmem_cache *amdgpu_fence_slab;
>  
>  int amdgpu_fence_slab_init(void)
> @@ -151,12 +135,12 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
>  		am_fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOMIC);
>  		if (am_fence == NULL)
>  			return -ENOMEM;
> -		fence = &am_fence->base;
> -		am_fence->ring = ring;
>  	} else {
>  		/* take use of job-embedded fence */
> -		fence = &job->hw_fence;
> +		am_fence = &job->hw_fence;
>  	}
> +	fence = &am_fence->base;
> +	am_fence->ring = ring;

I would rather completely drop the job from the parameters and the general fence allocation here.

Instead we should just provide afence as input parameter and submit that one.

This should make sure that we don't run into such issues again.

Apart from that looks good to me,
Christian.

>  
>  	seq = ++ring->fence_drv.sync_seq;
>  	if (job && job->job_run_counter) {
> @@ -718,7 +702,7 @@ void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
>  			 * it right here or we won't be able to track them in fence_drv
>  			 * and they will remain unsignaled during sa_bo free.
>  			 */
> -			job = container_of(old, struct amdgpu_job, hw_fence);
> +			job = container_of(old, struct amdgpu_job, hw_fence.base);
>  			if (!job->base.s_fence && !dma_fence_is_signaled(old))
>  				dma_fence_signal(old);
>  			RCU_INIT_POINTER(*ptr, NULL);
> @@ -780,7 +764,7 @@ static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
>  
>  static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
>  {
> -	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
> +	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
>  
>  	return (const char *)to_amdgpu_ring(job->base.sched)->name;
>  }
> @@ -810,7 +794,7 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
>   */
>  static bool amdgpu_job_fence_enable_signaling(struct dma_fence *f)
>  {
> -	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
> +	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
>  
>  	if (!timer_pending(&to_amdgpu_ring(job->base.sched)->fence_drv.fallback_timer))
>  		amdgpu_fence_schedule_fallback(to_amdgpu_ring(job->base.sched));
> @@ -845,7 +829,7 @@ static void amdgpu_job_fence_free(struct rcu_head *rcu)
>  	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
>  
>  	/* free job if fence has a parent job */
> -	kfree(container_of(f, struct amdgpu_job, hw_fence));
> +	kfree(container_of(f, struct amdgpu_job, hw_fence.base));
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index acb21fc8b3ce5..ddb9d3269357c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -272,8 +272,8 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>  	/* Check if any fences where initialized */
>  	if (job->base.s_fence && job->base.s_fence->finished.ops)
>  		f = &job->base.s_fence->finished;
> -	else if (job->hw_fence.ops)
> -		f = &job->hw_fence;
> +	else if (job->hw_fence.base.ops)
> +		f = &job->hw_fence.base;
>  	else
>  		f = NULL;
>  
> @@ -290,10 +290,10 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>  	amdgpu_sync_free(&job->explicit_sync);
>  
>  	/* only put the hw fence if has embedded fence */
> -	if (!job->hw_fence.ops)
> +	if (!job->hw_fence.base.ops)
>  		kfree(job);
>  	else
> -		dma_fence_put(&job->hw_fence);
> +		dma_fence_put(&job->hw_fence.base);
>  }
>  
>  void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
> @@ -322,10 +322,10 @@ void amdgpu_job_free(struct amdgpu_job *job)
>  	if (job->gang_submit != &job->base.s_fence->scheduled)
>  		dma_fence_put(job->gang_submit);
>  
> -	if (!job->hw_fence.ops)
> +	if (!job->hw_fence.base.ops)
>  		kfree(job);
>  	else
> -		dma_fence_put(&job->hw_fence);
> +		dma_fence_put(&job->hw_fence.base);
>  }
>  
>  struct dma_fence *amdgpu_job_submit(struct amdgpu_job *job)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index f2c049129661f..931fed8892cc1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -48,7 +48,7 @@ struct amdgpu_job {
>  	struct drm_sched_job    base;
>  	struct amdgpu_vm	*vm;
>  	struct amdgpu_sync	explicit_sync;
> -	struct dma_fence	hw_fence;
> +	struct amdgpu_fence	hw_fence;
>  	struct dma_fence	*gang_submit;
>  	uint32_t		preamble_status;
>  	uint32_t                preemption_status;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index b95b471107692..e1f25218943a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -127,6 +127,22 @@ struct amdgpu_fence_driver {
>  	struct dma_fence		**fences;
>  };
>  
> +/*
> + * Fences mark an event in the GPUs pipeline and are used
> + * for GPU/CPU synchronization.  When the fence is written,
> + * it is expected that all buffers associated with that fence
> + * are no longer in use by the associated ring on the GPU and
> + * that the relevant GPU caches have been flushed.
> + */
> +
> +struct amdgpu_fence {
> +	struct dma_fence base;
> +
> +	/* RB, DMA, etc. */
> +	struct amdgpu_ring		*ring;
> +	ktime_t				start_timestamp;
> +};
> +
>  extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>  
>  void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);

