Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B0BC71136
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 12:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1717910E0F0;
	Tue, 17 Jun 2025 12:21:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VTLHK7qe";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B2D910E0F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 12:21:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqXw3a2qe2RTKanWAHkUT80+p/xW7cU+KvurNBDtJdyAKH6AFCiM0L18TEdjfs2byDlCSzyyFbKAB3j70tKdQRNuzwWrfsbkJuLDwz49VbAKHtQLAqvoYP0EyCgvdD/lMzgASfSf3HaZiu8R5j6pGYcPY00cqxi5fiFebipg63/1pldg1b4/1Ec62kGyjbOD3Yy8Xij2udNcZ8aw8GR0TWWl/UiaT6heVxS2U+nk/Euio3yOYnAtPpfyBzDBAtLz5i+F7AHqbmNfPb99lxtUGDN2Vs7Fj0wH7lGppQcQuMmhjUTldKwI311i3bYv/wcvh5eX1ytQ/orUA6SCTVS9Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLSbq+UlBT29HcCkUYBlL4tds5ssKLkGCM+iSzT1jAc=;
 b=Jz/2yDPqTCwWnZuM307DiLCyDzTZoxDuNYQeJmgYsp6lrl0nGEfxFXA04ecuEHi8F/hCXzUiIRZR2bROfx+rTau17nvrXrlWKcUkzD8V/I5MHM/BgciQi5yYhjqNtGbtU4bR5ibmOKVffaF2kGPUQpxnM4CK6TyL+tuh2aHgdLevBvoHUrcT0mNkjzHBg/TeuCsUD8N1fmdCLLN8jwSWEZhh1oC1FMUXyjX8MrsZ2t9xozeOfZo7QSAl8FK6UCyKGja8XmBWm8oVjUSjZFA1vBUbzYld/5mxuOkGlfIlBxROp2yVAlA6vdZ4pDPwuU+pYcrM24NSqJFyF1K0zJ5jwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLSbq+UlBT29HcCkUYBlL4tds5ssKLkGCM+iSzT1jAc=;
 b=VTLHK7qeSpkkzc9sx3igDvrCYINDsIk3TBmtqBAFHHgr+IC9mR5E9LZwP0IFfOG6s2tPOaY81eaUCwvx1T8EJPQIXX6roM59dwwk5P8UqM4liBkQD5jdbBiHdUGomq0c+dUgavT989yiaVAhwXA8xadWlOeuyYtWxvC6Y+nI3lg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY1PR12MB9649.namprd12.prod.outlook.com (2603:10b6:930:106::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 12:20:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 17 Jun 2025
 12:20:56 +0000
Message-ID: <86300a6b-b5bf-438c-88c0-2261d9b62e0f@amd.com>
Date: Tue, 17 Jun 2025 14:20:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/36] drm/amdgpu: update ring reset function signature
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 sasundar@amd.com
References: <20250617030815.5785-1-alexander.deucher@amd.com>
 <20250617030815.5785-9-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250617030815.5785-9-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR01CA0003.prod.exchangelabs.com (2603:10b6:208:71::16)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY1PR12MB9649:EE_
X-MS-Office365-Filtering-Correlation-Id: 43099902-f464-4980-9500-08ddad99693a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDZQdGF2b214c2dGRGxCcWUxUWo2amlmV3B3ZThmZkZ4MkRXUys2YTBiZXFt?=
 =?utf-8?B?bmxaeUNTSmJKdWczNzJzcUJNaUJiQUpscXdCZzFLaUNFZHoxQ3lwd2VSRnM0?=
 =?utf-8?B?WG1uSjg2NDVLVDVZVlpoTk9UV0hqM2tGSE1vUlc3MWpQMjgzYldhbG9yc2U5?=
 =?utf-8?B?UnVEeENOdUdkejljOVh5M245ZGJtaFVTTlJQYmMwT1hSK2lySXlOSXE4SkNI?=
 =?utf-8?B?TG0relJxWmQ0MmhEMmQ4M1pXVi9qZVdhRVJQUmduVkJSeDgrclBhRXZORnJI?=
 =?utf-8?B?OE0zVG4wTDJHV0lSTnhuRm9VOHI0Sy9uWmNhMWZFeDhTSnRGZWZ3U1hIOHpu?=
 =?utf-8?B?V0U3aWpNbjBJdUMxenZhUmp0U0ZkMVlXczFWSnJibDFJWGZHUnpGc1hsUzdL?=
 =?utf-8?B?S2Y5TXpTeHh2VTVRZDRLNjNwQWl0WElPTUFjUlo4cmlZeG4ybDQ5aWNtbnNl?=
 =?utf-8?B?Wkt5NXlCcGRhbWtCK0tQbWNQSmorcHY4ZWVnZk9kU2lCbjY0MXZ1L2ZyL2dM?=
 =?utf-8?B?L2tQd21KUkswcWlaUFlTaXN5UjNpY3hlNlJXbWE0T01JSytmN1Yva25Xd1A0?=
 =?utf-8?B?c1MwQURZRGN6WW50aDg3VGxOYTdLb3M0OUZUZlphcDc3UkQ2cGNPYk1pUWFp?=
 =?utf-8?B?d3BrYm5jMWFjUWhSclQ1d2w0U2hmbjNib09KT2JkeWhEeXlwNVZiWFNnZnRv?=
 =?utf-8?B?VHExbVB2MWVCQTQ1OEx4WGE5K1VreVFvOTR6cndQY1JEV05yNVN1WXp6cmts?=
 =?utf-8?B?YnEyY1ZEYjIwOEQzSWxJSUFnb3h3dm51V056dElPRHZ1RDhVSkNDSndlZlZE?=
 =?utf-8?B?T3J0aG5VYUVMeVFMdUJ0akt0VUhZZWpCb0RKTXllK2g0SEZjVU15cERMN285?=
 =?utf-8?B?d0psS1FDdW9QWGlGcmo5WmR2RGtQbTdlcVBPbGVPUkpkaXlxSDhWOGQ3Nmc4?=
 =?utf-8?B?Ui9Sa3BCTEVNVVRCMmxSVkNlNmF2ODN5ZnZQV1VUNWR4UklUcTVoTFJ4bFRD?=
 =?utf-8?B?cUNHbmZmM3NhaE1rb2pqV3IwQXJMYXhwT05NUXZwZ20renZEaEZoa3I2endX?=
 =?utf-8?B?QnBHei9HeHQ1Yks5dFIrY2NmdWk3MWdpa0k3OHZESzB3UnlZOTNmUUF4VTZR?=
 =?utf-8?B?bmxYSDBQWUFrVGZRK2psalNYS1pqak1UbmxWN2dhT21CSmtzV01JOE9JU2sy?=
 =?utf-8?B?R2YzbkVmd1RYYUVFakROMFFmZG8xUGNPVWJJenUzMDZNcFYwdzNNYW9lUDZG?=
 =?utf-8?B?QWV6eUFTTmFPZ2lGc1Jlb0pxNGFoRHNESWt2S05PbEE3OGR1RmNGNU1Dcit1?=
 =?utf-8?B?WThZcWYyRk5JZzRCZ080dzZlNmtPN2ZZWXVJaVdUK2hRSHViajdOMW1vTHda?=
 =?utf-8?B?RHpCUkhaMkdrSm9CbWVhVXlzUFNaVUhFTE4wSktZbGg1R3hSWXY3d0RYNi83?=
 =?utf-8?B?cWZNekZvUkpqTjlxMXFaWXhzTS9FN0tCbi9kMUU4czM0dUNWbnp3anFSRmp1?=
 =?utf-8?B?eUhTNk9SY2FKcHlibmVDZTJqcVkwWlV5bFNRREc4alhBUCswN1BxUVFzdnpB?=
 =?utf-8?B?b25EZEF2Q0xRbWlTUWs1MjgxdnNFUllrdTJZUEIzWkJmRHRCTGIybFlRVTZ2?=
 =?utf-8?B?ajROUmhocGZib2Znblo4YnRDRTNLRXRHREpMZXJrTXlxTkRUWjlkdmtqRWF1?=
 =?utf-8?B?Qnl6bFZhT1NISGh4b24xT0xHNTNCZUFJMGR3bWxzVGl4aVRaczltVnBrckR0?=
 =?utf-8?B?Y09tSnVQRm9VWGFaWXhYUFFPK1I4ZjlKaWlxTUtaeXRjVk9aTTNEQ2REMFBx?=
 =?utf-8?B?bGFoVlZaRUx4YlAxTVJQUDBES2c3NGFJK1BzVHFRNVN0Y09qQVFPeWZkTzhy?=
 =?utf-8?B?UkFOUk8rQjhPRzc4cXhJRW9yNzY5NGlmRS9KY1hCdW5jbmc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTl6NTlWa0w5K1RTTVVnMkZsMjZXUXNVMjlWM2d4bVNxU3pFbzlkdHdJV3R3?=
 =?utf-8?B?M2NOc2Vtc01Hejd5SEpFVGRCaFNIWnJUNkwyN1pQWmVvc3kzeVhmMzRKeW5S?=
 =?utf-8?B?NW16TFE0UCtIbWtPUmRKZUoyT0xNL2xFdlFXUXpqcnlkajdRK2Q2UHppOUJ4?=
 =?utf-8?B?TVVYVTlnQzlaRzlxWnd6aWFWUWp1VTMwQURSQWxCeU4rVkJVL1hBVmxpZG43?=
 =?utf-8?B?QVFsTzlOODZYTWFEWjB3Qnl6d3kxUGdEbVdyVDI3d1dqNVZ3OGpKTUl6Z3Zi?=
 =?utf-8?B?WW1NZFNxdVVQZXBkbm1wd3o4L25LdmVEYXduUGtBVDd1c3d2cXpJbml1TVBP?=
 =?utf-8?B?VkNjUzF5aGtOQ04yY3RyZWYwUlJCTDdDR1dxOFB1dXN2WmdmRTJxK1VUaWpx?=
 =?utf-8?B?ejQ5Q2xFcGFsbHYvQm1KVldJVzBSS1E1WUthUWZGbkhPUDVjVHlob3l3OEpU?=
 =?utf-8?B?a1RiMzlmcmlha2t5SjRCYlAwUC9WQVpVMDRqN0ltTUMxT2FCNG52amVmeUgz?=
 =?utf-8?B?czlVcEoxWExpT2piYmxxWmJFZzlVWHMxZVo5MDdwME5aYi8zMVRRaWhweGxw?=
 =?utf-8?B?aFBzVlBYM1M5azlVa3BBN3lZUHptSk1UNS9WbXNyTTl5TTJGMFg4VWtUSEs2?=
 =?utf-8?B?WXdDWkIrZGN5MitiL1QxVUpOV2k3TTlUeUd2S2xhSHgzcDlPVUVPV0htWDdE?=
 =?utf-8?B?ZDdONTkwY1QrcWpIZEo0bU9EQ1poVFBjL3hmSjVBeGlnbE0veG80TU4rV1Rh?=
 =?utf-8?B?VU1UZUhsTml5MVVLWGtXck9rRkl4NWk1eHN6QmYvRzQvVmx0M0ZiRDMyVjlr?=
 =?utf-8?B?Y0h5K0xFbVN3OEdtZk5PZ3E2V09KSmpyZnJ2aHQ5VG4wOWU3SUVlZnhQTmlk?=
 =?utf-8?B?SVFKV3kxVWZXQzVmbFFvNUpTRno4aEs3TkQwL1lEU014S29wSUlMNE54anlq?=
 =?utf-8?B?Mm5HOXdBbnA4elV6WVhLSGlKSnA0NE9nVmlmQlZ2bWFDcGRrZjJaWTh5cytw?=
 =?utf-8?B?UUNOS1BRSjRubmtKSXNUY0U2S00vdHpDcjM5VytZM2JySThRc1p2TENvbGlu?=
 =?utf-8?B?UStFOEZKQjY4K0R3SHVqb1hZeHpYb2RrTkxHTUVQVGZSK25zTnA2dDkyU0Za?=
 =?utf-8?B?STBGQVFIY0p5ODZEaXpiYXIxRGVuellFaDlYUmROQ2FnVkthVHg0QmdQZGNk?=
 =?utf-8?B?YmFZbXFsZDZGQUNnNmFkT1grUENHQ0pneDI2NDlDTjNkTmozSHpLWDFtTjBl?=
 =?utf-8?B?SVVKU2lSZUZwY0VVS21PZVRENWFHeDU2d2ZzbXl5TE5PV2FneTBTa2NOYnBV?=
 =?utf-8?B?RnRaTUdQbGxaN2ZWTXloWXQ3UFVhOG5OaWVkUWdEcHVlOHJjRlhUNmRvUGQ1?=
 =?utf-8?B?RzF6c0pySUZyZTVjZ2ViaVJuN05ZeElwcENwckR4dC9qK3JPZm1ISm5ZVGN0?=
 =?utf-8?B?OEh5M1p2TVpvVXVmK0M0SzFLL1lPejlXOWdWb2xvUmU5ZldjbWFqVWxOYlJP?=
 =?utf-8?B?RVJWVzVFZXcxTE5qMkJ1eko4R0NsWHJoc1hvSWdVYlg2RjZGYmlUSEl5bGpr?=
 =?utf-8?B?K3BwWlVJUW5TY0Z4MVJKVEYzVFV0bjJWSERyRVl4THcrdWpVVTdJWi93MnZz?=
 =?utf-8?B?QnVmOFRnaXZnTmU0SGNyb0laTVNlcGhFYmV2Z0tVend5NTFySjhSZ3l1cHF1?=
 =?utf-8?B?YVFsTnNlRFd5Qm9BQTh4ZXVyb05iVE5zYXdaaDE2Y05jWmxJaS9LajBkTCtm?=
 =?utf-8?B?cC9nNlhPRE8wMUxpVWExTlpXU1A1SXZtR1FhU09QRGYzeWNmbEFBLzNVT2Fs?=
 =?utf-8?B?ekNveHFYdW5RMVVzR0VIU2xrY3Z5WmQ3YzRTak5kajRMKzUyOEJlMWtqUy9E?=
 =?utf-8?B?bmU2T05mem54TlM2Sm8rTXVob2JUMEpqK3VQdjdZdE1lZTg4Ri9Xd3VuVURQ?=
 =?utf-8?B?aDAwTXZUTmxUcFRTaXlZRkJGR1Y0OGdDOEk2UHRXdHJwLzdIbjd4UCt2U0Jr?=
 =?utf-8?B?dE12RlhwNFpXTUVGcThORXJZNktlc3cxRXBEQ1lCVjZNRlMzRjJ2MHNWMGhX?=
 =?utf-8?B?LzYwUDRBOEpUSm4wRVRET1o3OGZLckp0K1ZiTzIzNHBJaWRCWUtjK0d1Yzh0?=
 =?utf-8?Q?ukxkeLYtw7smsGe0ZyZY532io?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43099902-f464-4980-9500-08ddad99693a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 12:20:56.5540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P61kxS1bc9ngTQpyvSdBm73XHZv8FapXB042bT9xgPfOwePptUXh+vur0Wg0vD4s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9649
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

On 6/17/25 05:07, Alex Deucher wrote:
> Going forward, we'll need more than just the vmid.  Add the
> guilty amdgpu_fence.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Maybe not name it guilty_fence since that is not necessary the case for SDMA for example. Maybe just fence or timedout or something like that.

Apart from that feel free to add Reviewed-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 5 +++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 7 +++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 8 ++++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 8 ++++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  | 4 +++-
>  22 files changed, 70 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index ddb9d3269357c..a7ff1fa4c778e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -155,7 +155,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  		if (is_guilty)
>  			dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>  
> -		r = amdgpu_ring_reset(ring, job->vmid);
> +		r = amdgpu_ring_reset(ring, job->vmid, NULL);
>  		if (!r) {
>  			if (amdgpu_ring_sched_ready(ring))
>  				drm_sched_stop(&ring->sched, s_job);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 9ae522baad8e7..fc36b86c6dcf8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -268,7 +268,8 @@ struct amdgpu_ring_funcs {
>  	void (*patch_cntl)(struct amdgpu_ring *ring, unsigned offset);
>  	void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
>  	void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
> -	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
> +	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid,
> +		     struct amdgpu_fence *guilty_fence);
>  	void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
>  	bool (*is_guilty)(struct amdgpu_ring *ring);
>  };
> @@ -425,7 +426,7 @@ struct amdgpu_ring {
>  #define amdgpu_ring_patch_cntl(r, o) ((r)->funcs->patch_cntl((r), (o)))
>  #define amdgpu_ring_patch_ce(r, o) ((r)->funcs->patch_ce((r), (o)))
>  #define amdgpu_ring_patch_de(r, o) ((r)->funcs->patch_de((r), (o)))
> -#define amdgpu_ring_reset(r, v) (r)->funcs->reset((r), (v))
> +#define amdgpu_ring_reset(r, v, f) (r)->funcs->reset((r), (v), (f))
>  
>  unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);
>  int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 75ea071744eb5..444753b0ac885 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -9522,7 +9522,9 @@ static void gfx_v10_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
>  	amdgpu_ring_insert_nop(ring, num_nop - 1);
>  }
>  
> -static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
> +static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
> +			       unsigned int vmid,
> +			       struct amdgpu_fence *guilty_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> @@ -9579,7 +9581,8 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>  }
>  
>  static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
> -			       unsigned int vmid)
> +			       unsigned int vmid,
> +			       struct amdgpu_fence *guilty_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index ec9b84f92d467..4293f2a1b9bfb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6811,7 +6811,9 @@ static int gfx_v11_reset_gfx_pipe(struct amdgpu_ring *ring)
>  	return 0;
>  }
>  
> -static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
> +static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
> +			       unsigned int vmid,
> +			       struct amdgpu_fence *guilty_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	int r;
> @@ -6973,7 +6975,9 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
>  	return 0;
>  }
>  
> -static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
> +static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
> +			       unsigned int vmid,
> +			       struct amdgpu_fence *guilty_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	int r = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 1234c8d64e20d..aea21ef177d05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -5307,7 +5307,9 @@ static int gfx_v12_reset_gfx_pipe(struct amdgpu_ring *ring)
>  	return 0;
>  }
>  
> -static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
> +static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
> +			       unsigned int vmid,
> +			       struct amdgpu_fence *guilty_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	int r;
> @@ -5421,7 +5423,9 @@ static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
>  	return 0;
>  }
>  
> -static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
> +static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
> +			       unsigned int vmid,
> +			       struct amdgpu_fence *guilty_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	int r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index d50e125fd3e0d..c0ffe7afca9b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -7153,7 +7153,8 @@ static void gfx_v9_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
>  }
>  
>  static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
> -			      unsigned int vmid)
> +			      unsigned int vmid,
> +			      struct amdgpu_fence *guilty_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index c233edf605694..79d4ae0645ffc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -3552,7 +3552,8 @@ static int gfx_v9_4_3_reset_hw_pipe(struct amdgpu_ring *ring)
>  }
>  
>  static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
> -				unsigned int vmid)
> +				unsigned int vmid,
> +				struct amdgpu_fence *guilty_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index 4cde8a8bcc837..4c1ff6d0e14ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -764,7 +764,9 @@ static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> -static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
> +static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
> +				unsigned int vmid,
> +				struct amdgpu_fence *guilty_fence)
>  {
>  	jpeg_v2_0_stop(ring->adev);
>  	jpeg_v2_0_start(ring->adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index 8b39e114f3be1..5a18b8644de2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -643,7 +643,9 @@ static int jpeg_v2_5_process_interrupt(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> -static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
> +static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
> +				unsigned int vmid,
> +				struct amdgpu_fence *guilty_fence)
>  {
>  	jpeg_v2_5_stop_inst(ring->adev, ring->me);
>  	jpeg_v2_5_start_inst(ring->adev, ring->me);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index 2f8510c2986b9..4963feddefae5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -555,7 +555,9 @@ static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> -static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
> +static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
> +				unsigned int vmid,
> +				struct amdgpu_fence *guilty_fence)
>  {
>  	jpeg_v3_0_stop(ring->adev);
>  	jpeg_v3_0_start(ring->adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index f17ec5414fd69..327adb474b0d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -720,7 +720,9 @@ static int jpeg_v4_0_process_interrupt(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> -static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
> +static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
> +				unsigned int vmid,
> +				struct amdgpu_fence *guilty_fence)
>  {
>  	if (amdgpu_sriov_vf(ring->adev))
>  		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 79e342d5ab28d..c951b4b170c5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -1143,7 +1143,9 @@ static void jpeg_v4_0_3_core_stall_reset(struct amdgpu_ring *ring)
>  	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
>  }
>  
> -static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
> +static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
> +				  unsigned int vmid,
> +				  struct amdgpu_fence *guilty_fence)
>  {
>  	if (amdgpu_sriov_vf(ring->adev))
>  		return -EOPNOTSUPP;
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> index 3b6f65a256464..51ae62c24c49e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -834,7 +834,9 @@ static void jpeg_v5_0_1_core_stall_reset(struct amdgpu_ring *ring)
>  	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
>  }
>  
> -static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
> +static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
> +				  unsigned int vmid,
> +				  struct amdgpu_fence *guilty_fence)
>  {
>  	if (amdgpu_sriov_vf(ring->adev))
>  		return -EOPNOTSUPP;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 5b7009612190f..502d71f678922 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1674,7 +1674,9 @@ static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
>  	return sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
>  }
>  
> -static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
> +static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
> +				   unsigned int vmid,
> +				   struct amdgpu_fence *guilty_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	u32 id = ring->me;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 37f4b5b4a098f..6092e2a9e210b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1539,7 +1539,9 @@ static int sdma_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
>  	return 0;
>  }
>  
> -static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
> +static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
> +				 unsigned int vmid,
> +				 struct amdgpu_fence *guilty_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	u32 inst_id = ring->me;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 0b40411b92a0b..2cdcf28881c3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1452,7 +1452,9 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
>  	return -ETIMEDOUT;
>  }
>  
> -static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
> +static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
> +				 unsigned int vmid,
> +				 struct amdgpu_fence *guilty_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	u32 inst_id = ring->me;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 5a70ae17be04e..43bb4a7456b90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1537,7 +1537,9 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgpu_ring *ring)
>  	return r;
>  }
>  
> -static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
> +static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
> +				 unsigned int vmid,
> +				 struct amdgpu_fence *guilty_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	int i, r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index ad47d0bdf7775..b5c168cb1354d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -802,7 +802,9 @@ static bool sdma_v7_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
>  	return false;
>  }
>  
> -static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
> +static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
> +				 unsigned int vmid,
> +				 struct amdgpu_fence *guilty_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	int i, r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index b5071f77f78d2..083fde15e83a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1967,7 +1967,9 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>  	return 0;
>  }
>  
> -static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
> +static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
> +			       unsigned int vmid,
> +			       struct amdgpu_fence *guilty_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 5a33140f57235..57c59c4868a50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1594,7 +1594,9 @@ static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring)
>  	}
>  }
>  
> -static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
> +static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
> +				 unsigned int vmid,
> +				 struct amdgpu_fence *guilty_fence)
>  {
>  	int r = 0;
>  	int vcn_inst;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 16ade84facc78..4aad7d2e36379 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1465,7 +1465,9 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring)
>  	}
>  }
>  
> -static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
> +static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
> +				 unsigned int vmid,
> +				 struct amdgpu_fence *guilty_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index f8e3f0b882da5..b9c8a2b8c5e0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -1192,7 +1192,9 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring)
>  	}
>  }
>  
> -static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
> +static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
> +				 unsigned int vmid,
> +				 struct amdgpu_fence *guilty_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];

