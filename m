Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DE0C531DC
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 12:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE11510E76D;
	Tue, 20 Aug 2024 12:43:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mwKfZIwr";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8512410E76D
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 12:42:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqZjXglwdhp/x2qCVSjqODriph8OJxK0h0kx5qt493N3iTcAfHYiR9t204JGNmdgg7RpGKid7Ia+QWdkcYHpcdyezUkQYPDjr0oRQPeQCMY6U0gRfOIBuqy+WYzEwjn9fC9Bs3BFzfWKNqYVWUBYfu9kK69SfBkqb4a6yb4mYDYVvn17i+goCAAYhAPZN5+OO59sP1/LnCtYxDEyNv0i+k/uMtFk9mvxwrmQDpxt2RENIWecSTaYDZXMoGmsj9lRvvhCtSEczps9+C9M2Fmp3wagrxrz5r+mFeidVkgWIWpD6Y9SLJ/+BmvrlmXGr31FPKbFONdCSXM4VxNzbSjl0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iXPuaoqwLGtKl3x1gEKY60p/hlpdFl72wpR484WTxA=;
 b=GjdJx4u9pL356IlGlM5RklY7wz+S1MfeuDTS+XLhEaCOH8L+gwyUdC1QnSIMwn2AS6uciTGlX49K4G/4kzlGaRlljGxpQHKALmbIYuFw0eIdnG+z/2ZHNwsNAAVu5eH/QGBSn38jIiM+WM+OKW3Fljj/L+jp1GLgiiadPSAyhUo7nSZeHC5DFwOO1CLmeJDJa4xz4LmHhQmPr+6vdFMe0xUsttGSyK28e/3yJ6s4T8goDMYDWgF+KnGr/djQDNZtQvj+spXNhfqy3mih9/GCK/Ck1IZnV9ZQAVjqnZWXlmjDxLvcGyAqRPfWE2ho9IPaP+RMQZPX/kG+6P5LXhdX4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iXPuaoqwLGtKl3x1gEKY60p/hlpdFl72wpR484WTxA=;
 b=mwKfZIwrCDkSJPgvTcTeL8BdVvMGHwKr4EXbV5qwBXnez02WNixTzuh3v6+XCJJfqzh0whklBaCDDTy4L1GLgr087O6KZifkuYGWDOi7xXvOgSpazYS1KIRz+RSavoU1CRThsBCdMHn3zM5qw6oeE42IFdjx+GazyrmANpNzPDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB7891.namprd12.prod.outlook.com (2603:10b6:510:27a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 12:42:55 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 12:42:55 +0000
Message-ID: <690d4517-a0c2-4951-ad7a-dbada7274f3a@amd.com>
Date: Tue, 20 Aug 2024 18:12:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu/gfx9.4.3: Implement compute pipe reset
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com
References: <20240820103144.2831848-1-Prike.Liang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240820103144.2831848-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: 944f5ca7-6e14-4c9a-b29c-08dcc1159cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzJJL3UwaFhCZ0J1dnIvOVlVMnlwZW1PWCtjWENCMU5NSTVsNTVDY2ZKY1V4?=
 =?utf-8?B?OVdjZU4xY0I3c1RibzdZME0yeExZUVI2RHUzZnJjK1ZWZGpRS1dBM21tbno2?=
 =?utf-8?B?SnE4L0Q1OFBwRzZkallIYWNBT2dDc1VIRWNVR2RBdlVTRVlxeTUvZDg0NVBk?=
 =?utf-8?B?aXRGZjdmVjI2TzRHandnZzlGNGl6ZzNQWFdUb1U4cEd5R0gxMUp6WEE3VjJj?=
 =?utf-8?B?bTlHNzIzU2hZU1ExN3VJUFYvbGZIRjBvZ3hPSkxuRlo5b1lUWnE1czFOU0dz?=
 =?utf-8?B?cE43V2tnQXZxQ3BjUERDZUNVbTNCTUsyc3I2NVNuV3ZJN0pHWVZFRjJOQmFF?=
 =?utf-8?B?VVdkSnd2RElZb3VlNnF4cnErZE1OV3BtRjNGb05lOERZbllnblVzSlNxanpQ?=
 =?utf-8?B?WWwxYUtnL2NvQ2UveTZLc25oMlF6R1FHZzgyaUhrT2NvZ09DS2s2YXNRTlpa?=
 =?utf-8?B?TXZKMVA3TU5WckFOTmNaUUdwYklrSFo4cDQybEtMMzIyMFhmQTlqZUVpbTVP?=
 =?utf-8?B?SXRVN2thSkw3a0RQYjNwQ3djSnpzMnBwSThNSzg4b282cWpITlduT092VlBw?=
 =?utf-8?B?WHQ3Y2pTSGZZZXlwdU55LytZbjMxNUQ4U1ZRdmJDUjJRaThiRjVQUmlvM202?=
 =?utf-8?B?KzVFTElJRTM3d0Fnb3VEREc4VnpyT3Z4bU9VL0J0dzMwRzR0YVRuRExPdVo3?=
 =?utf-8?B?S1hKZ2R1UHg1S2VhYy9VYnE4QjQ4c2dvSHR2TkVJVm9xY05ZQUVtWkRxY095?=
 =?utf-8?B?RU03eW5qY1BWK2NFRHM3NitoTEcvdURzQU1mNldBeUdXZERnRzdSZ3pqQktO?=
 =?utf-8?B?VUh1SklqNVpOWjQ5OVdGVWlEWFIyY1pjOXFzQ0pPakFKM3ppdEdFc2p1RnVz?=
 =?utf-8?B?aVI4S3JmaTEremRsTmNvaUdoM1dJamZVbDV5RU9zQURpUnNFRHh1UmxuVHJS?=
 =?utf-8?B?SUpaSktyWWdnZmI1ZEJjZWtZdVhkeklkRWZuMFlDUUgzVFAwZEhEVGMvR2x4?=
 =?utf-8?B?WFlXWlA3dmNsem15YlE1VkxLN1loSlBwakl3bjFrVStkLzBVd0JrRTVpVVVS?=
 =?utf-8?B?aEZvTFBEYVYxUDFweTVyM2dIaVptV3RKT0p5WGRkVFh4N0JacHA0dXBvMXZE?=
 =?utf-8?B?d1h0YVNON0NDQm1XVEtwZkFOUmZlQ2tyVWZmS1N4c241ZitVQjZXR1dYTXU1?=
 =?utf-8?B?VVhZZlIzNlV2blhoVGhHZVdudm5LWENQRGhveXhhVFhMem1lZG1kNDFUbDBS?=
 =?utf-8?B?bUtmdHRnYjhEQ3FKNWZyNjFiTHNSclJxaHdKZEVQZE1GR3dWYkl6dmRiYTZo?=
 =?utf-8?B?bi9ZUkl3a3kvaSszc3BPcThNQm5aMVloMU8yeXJXL1dubC9BM09OUGd4UStT?=
 =?utf-8?B?SzdzcGQzMlV5Ly9lKzdvWXZlRGFUbzI5MTNpZGpGRXFKa2w4WXAyYzlYWjZG?=
 =?utf-8?B?bkpEeDVGVHNQendvYUZqSHJrTUJDa3hIMmx2RTQxdmhOekI2ekZyaUhGSENk?=
 =?utf-8?B?WTViOEpQTjlrNXFCNWpZZ2YrUzcxdEluaU9YNDZRdUh4VlJYT3ZienY3b0hM?=
 =?utf-8?B?VU1nVWEzTnNkYmVwUjg3a1kvTjMzN2hjVXN4RTUzc1U5a1JTdE5rMDhIZEh3?=
 =?utf-8?B?RVA1a21MdTBjUXRXT29PQ3crUC9SVlBhWTFDYUFUc2QwaVpMNDdQVkNmRVg3?=
 =?utf-8?B?UzJ6U3A1WXg0c2FMRnA1MnJrZm11c3JFVE5NNUQ4Ny9yd2FPalo0ektkSi9w?=
 =?utf-8?B?MlF6S09zamJCTFhNV1o4b3FJMGt0TlZMZ2hhYXArQVNUOTZFVGZZOW5tcWpi?=
 =?utf-8?B?RXpFLzV2T25vVzQrNGtldz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enVQNzlHdEg4OW1qTDhSNldSdkNBRmY4UWJiQTQ5eHd3bi9CT2g0MDRyTEJ4?=
 =?utf-8?B?aGFKN2JaeVlZUUhFMFJoOHpSdE4zSDBwekxUamtBa1ZrNWlRYkRIY1JrZDZT?=
 =?utf-8?B?WSt2QlhqMlN0cm9nb3BQVXpzb2MyVmp3MFZvZUF5Z0RONXlJSGN5My9HanFB?=
 =?utf-8?B?d1RnYXFvZCs1WW52Qlllc1d2M2doZVEvQ3RsR0VYMVRQNHdIS1JXZ1gxMFRT?=
 =?utf-8?B?cmdFdnowWGRaZ1Nncm5udTZ2amJnTVYybXdlNEtBZHZsSGdTOVFXN1ZqMmg2?=
 =?utf-8?B?aXIrL3FYcDlKcW5ORC9UbWVpYWpHbytCc2xxTnIxc1NoYjdFU0s1OGNvdUtx?=
 =?utf-8?B?clNWSVFONk1YaVErV1dZUURsb0l2dTZKdnB3OWhJNWdkeXlySFo3K0pHNENh?=
 =?utf-8?B?MnBMQVlzVjhmVUtJM2F5RHdlQWMwQmh5aEd0OFQrSk9uTVdwZmJFY0tEUnoz?=
 =?utf-8?B?RTB6TDVYeXlqY2xVTXhETGxmZEZXNDRhNlhjOFJvYXFQeU5PTUtTZ2tyZU5V?=
 =?utf-8?B?YlFVcUwxQ3UyazZpZ2lPbndyZUhyUjhNUGhNS0cwTEFNOFd2OHJYMFNLN1lG?=
 =?utf-8?B?UFp3dDduTmVaYUJYMi90OGRxOVZPWDVYRElFcEhLT04vMEt1dFlnV2V6Zytm?=
 =?utf-8?B?Y2ZrNm9ndnNBQytOeEQxQ1hzU1NDTTJXSTFjS2szN255bzZjWnhlSVF2N1lE?=
 =?utf-8?B?clV0RnRRejlXdDRwblFVQ0hEbmN5aDI1MjdEOFBGbFF4NDVkdEkzZngvVGNl?=
 =?utf-8?B?M0JrK3ZzYW5rM2x4Ykc2VlAvc25nQU5jTDZhQmFuUUpuVm0wK3hnTEJuNVg0?=
 =?utf-8?B?ektLT2VsaTV2elNPajd1K3VWbFgvczZyeFp6cFF5V1Y4eldneFFBY2FCb21U?=
 =?utf-8?B?ZUQvYXA5VGtrUks1Z2J2ZEhrS085amx0R3h5RklwZGVRMUZMOWUzRzJFUmdV?=
 =?utf-8?B?Nkt4amwwRTNMWWVPem1uVFkvVFo0L1o5UkhzUE1VWTZGZUE1VUs2eVdrVUdW?=
 =?utf-8?B?VHVZRk45SVAweHhodDZSZk1SYTJxVlZXVE1PTGxOaDU5VG1xVlhNVkFKZ2dz?=
 =?utf-8?B?ek5LQ2NJTUptbmowZzMxakJKYnlMak5zTGh1cDdvcllZazE3Q3NxckpJNHJX?=
 =?utf-8?B?R1VGTVplTmFPMkpCUE45US84ZTJKRlhsYm9rTU1FWVU5LzhJUlVFQm9KYjVI?=
 =?utf-8?B?ZWNvRzMxZTdyTGMwdWUySktEU09saE1hMnNnemhzYzBuTTNKUU1TbFMvYjZu?=
 =?utf-8?B?alFmTWF5MFJGeEVIOVpuWjBVR0VYeDBMVlJDcytuMFp0VXJUMnRJK054UUhO?=
 =?utf-8?B?Q0JLZG44Tittc2dmcE5rNmVkMkEwOXljd0ZVWkNNWGZiekIzclArMUhqaTdP?=
 =?utf-8?B?dnI5M1dxMTNTQ0lybUNLbGswZHdxcVRTTXVFenF0c3A1NVN3MUg3L0RPQ1JV?=
 =?utf-8?B?V0F1NFNKMG1iNlNJbXBUZFpYUXZrTlE1V0dzQnhBZHQyVzFnM0JIZENQU1JR?=
 =?utf-8?B?Vi9Nd0xtdnlnQkl0WWxiemlaOStUVDh2eTJPbFZEM0lXamVRd3RJeDBtOURW?=
 =?utf-8?B?a1dxMTBJYWJVdGlDWFZLVXFRczUzdU4wR3IrS1ZJMVNrY2ZKUFkzRkVldzB2?=
 =?utf-8?B?WG9NMER6TzhMc1MrVXBZZUVwM0ZGRXlnc0trQUl2MG1Ed3pMOEdQc3hnNW9u?=
 =?utf-8?B?MEsweWYyenlaZEZxNjNnVStzOU14VzZmUDg3Z3ZSVnJxZUwyb1lUR1V5SG9J?=
 =?utf-8?B?WnVicG5mUk1xdVRtTE1yd3Z4WnF4WDc5QVJNZzRFeXFHbE5xSkFMQVlnS3FO?=
 =?utf-8?B?djlaU25EQ3NoakdqZGY4Q2QxcVczYkN2UVNadFBjcDlyalQwMFVUZnV0RDlU?=
 =?utf-8?B?emc1ZjlMazhSSmd1OWpKT2tFbGxkbjROWDZjUG5melVLQktxUWZLdS8vakR4?=
 =?utf-8?B?YmdpVWs4SVdMWDcvOENaUmR3VVpJMkZ2aHM5TmxDandsTzFaNVgza3U5a2xy?=
 =?utf-8?B?TGhGMjl4L0hmT0JWYXFtcURyYVpZUlVCY3N6QnRGNkRUSjZSSTVKY3pibEwz?=
 =?utf-8?B?WndhMjl5eklVN1NRL21qRWMvRDRCcXl4bW01aEhPS1QrSC9JK2xVUXdDQnkx?=
 =?utf-8?Q?m1xeqZVoyq9RdH51Ezmt+vxGS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 944f5ca7-6e14-4c9a-b29c-08dcc1159cf7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 12:42:55.4969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltTdD0MKFoYmKxZWjb4ABY0MdpGRlTFKCttDfbtou0oNAn4Z6syuZn/glIYPMGr6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7891
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



On 8/20/2024 4:01 PM, Prike Liang wrote:
> Implement the compute pipe reset and driver will
> fallback to pipe reset when queue reset failed.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
> v2: Convert the GC logic instance to physical instance in the
>     register accessing process and 

> use the dev_* print to specify the failed device.

This is not fully done, marked below.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   5 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 153 ++++++++++++++++++++----
>  2 files changed, 138 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index e28c1ebfa98f..d4d74ba2bc27 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -143,6 +143,11 @@ struct kiq_pm4_funcs {
>  				   uint32_t queue_type, uint32_t me_id,
>  				   uint32_t pipe_id, uint32_t queue_id,
>  				   uint32_t xcc_id, uint32_t vmid);
> +	int (*kiq_reset_hw_pipe)(struct amdgpu_ring *kiq_ring,
> +				   uint32_t queue_type, uint32_t me,
> +				   uint32_t pipe, uint32_t queue,
> +				   uint32_t xcc_id);
> +
>  	/* Packet sizes */
>  	int set_resources_size;
>  	int map_queues_size;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 2067f26d3a9d..ab9d5adbbfe8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -166,6 +166,10 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
>  				struct amdgpu_cu_info *cu_info);
>  static void gfx_v9_4_3_xcc_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
>  static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
> +static int gfx_v9_4_3_kiq_reset_hw_pipe(struct amdgpu_ring *kiq_ring,
> +					uint32_t queue_type, uint32_t me,
> +					uint32_t pipe, uint32_t queue,
> +					uint32_t xcc_id);
>  
>  static void gfx_v9_4_3_kiq_set_resources(struct amdgpu_ring *kiq_ring,
>  				uint64_t queue_mask)
> @@ -323,6 +327,7 @@ static const struct kiq_pm4_funcs gfx_v9_4_3_kiq_pm4_funcs = {
>  	.kiq_query_status = gfx_v9_4_3_kiq_query_status,
>  	.kiq_invalidate_tlbs = gfx_v9_4_3_kiq_invalidate_tlbs,
>  	.kiq_reset_hw_queue = gfx_v9_4_3_kiq_reset_hw_queue,
> +	.kiq_reset_hw_pipe = gfx_v9_4_3_kiq_reset_hw_pipe,
>  	.set_resources_size = 8,
>  	.map_queues_size = 7,
>  	.unmap_queues_size = 6,
> @@ -3466,6 +3471,115 @@ static void gfx_v9_4_3_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
>  	}
>  }
>  
> +static int gfx_v9_4_3_unmap_done(struct amdgpu_device *adev, uint32_t me,
> +				uint32_t pipe, uint32_t queue,
> +				uint32_t xcc_id)
> +{
> +	int i, r;
> +	/* make sure dequeue is complete*/
> +	gfx_v9_4_3_xcc_set_safe_mode(adev, xcc_id);
> +	mutex_lock(&adev->srbm_mutex);
> +	soc15_grbm_select(adev, me, pipe, queue, 0, GET_INST(GC, xcc_id));
> +	for (i = 0; i < adev->usec_timeout; i++) {
> +		if (!(RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE) & 1))
> +			break;
> +		udelay(1);
> +	}
> +	if (i >= adev->usec_timeout)
> +		r = -ETIMEDOUT;
> +	else
> +		r = 0;
> +	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
> +	mutex_unlock(&adev->srbm_mutex);
> +	gfx_v9_4_3_xcc_unset_safe_mode(adev, xcc_id);
> +
> +	return r;
> +
> +}
> +
> +static bool gfx_v9_4_3_pipe_reset_support(struct amdgpu_device *adev)
> +{
> +
> +	if (unlikely(adev->gfx.mec_fw_version < 0x0000009b)) {
> +		DRM_WARN_ONCE("MEC firmware version too old, please use FW no older than 155!\n");
> +		return false;
> +	}

This path will be taken GCv9.4.3 and GCv9.4.4. GCv9.4.4 has a different
FW version. If FW is not yet ready for 9.4.4, better check that and
return false for that.

> +
> +	return true;
> +}
> +
> +static int gfx_v9_4_3_kiq_reset_hw_pipe(struct amdgpu_ring *kiq_ring,
> +					uint32_t queue_type, uint32_t me,
> +					uint32_t pipe, uint32_t queue,
> +					uint32_t xcc_id)
> +{
> +	struct amdgpu_device *adev = kiq_ring->adev;
> +	uint32_t reset_pipe, clean_pipe;
> +	int r;
> +
> +	if (!gfx_v9_4_3_pipe_reset_support(adev))
> +		return -EINVAL;
> +
> +	gfx_v9_4_3_xcc_set_safe_mode(adev, xcc_id);
> +	mutex_lock(&adev->srbm_mutex);
> +	soc15_grbm_select(adev, me, pipe, queue, 0, GET_INST(GC, xcc_id));
> +
> +	reset_pipe = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL);
> +	clean_pipe = reset_pipe;
> +
> +	if (me == 1) {
> +		switch (pipe) {
> +		case 0:
> +			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
> +						   MEC_ME1_PIPE0_RESET, 1);
> +			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
> +						   MEC_ME1_PIPE0_RESET, 0);
> +			break;
> +		case 1:
> +			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
> +						   MEC_ME1_PIPE1_RESET, 1);
> +			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
> +						   MEC_ME1_PIPE1_RESET, 0);
> +			break;
> +		case 2:
> +			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
> +						   MEC_ME1_PIPE2_RESET, 1);
> +			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
> +						   MEC_ME1_PIPE2_RESET, 0);
> +			break;
> +		case 3:
> +			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
> +						   MEC_ME1_PIPE3_RESET, 1);
> +			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
> +						   MEC_ME1_PIPE3_RESET, 0);
> +			break;
> +		default:
> +			break;
> +		}
> +	} else {
> +		if (pipe) {
> +			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
> +						   MEC_ME2_PIPE1_RESET, 1);
> +			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
> +						   MEC_ME2_PIPE1_RESET, 0);
> +		} else {
> +			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
> +						   MEC_ME2_PIPE0_RESET, 1);
> +			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
> +						   MEC_ME2_PIPE0_RESET, 0);
> +		}
> +	}
> +
> +	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL, reset_pipe);
> +	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL, clean_pipe);
> +	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
> +	mutex_unlock(&adev->srbm_mutex);
> +	gfx_v9_4_3_xcc_unset_safe_mode(adev, xcc_id);
> +
> +	r = gfx_v9_4_3_unmap_done(adev, me, pipe, queue, xcc_id);
> +	return r;
> +}
> +
>  static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
>  				unsigned int vmid)
>  {
> @@ -3473,7 +3587,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
>  	struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
>  	struct amdgpu_ring *kiq_ring = &kiq->ring;
>  	unsigned long flags;
> -	int r, i;
> +	int r;
>  
>  	if (amdgpu_sriov_vf(adev))
>  		return -EINVAL;
> @@ -3495,26 +3609,25 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
>  	spin_unlock_irqrestore(&kiq->ring_lock, flags);
>  
>  	r = amdgpu_ring_test_ring(kiq_ring);
> -	if (r)
> -		return r;
> -
> -	/* make sure dequeue is complete*/
> -	amdgpu_gfx_rlc_enter_safe_mode(adev, ring->xcc_id);
> -	mutex_lock(&adev->srbm_mutex);
> -	soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, GET_INST(GC, ring->xcc_id));
> -	for (i = 0; i < adev->usec_timeout; i++) {
> -		if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
> -			break;
> -		udelay(1);
> -	}
> -	if (i >= adev->usec_timeout)
> -		r = -ETIMEDOUT;
> -	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, ring->xcc_id));
> -	mutex_unlock(&adev->srbm_mutex);
> -	amdgpu_gfx_rlc_exit_safe_mode(adev, ring->xcc_id);
>  	if (r) {
> -		dev_err(adev->dev, "fail to wait on hqd deactive\n");
> -		return r;
> +		DRM_ERROR("kiq ring test failed after ring: %s queue reset\n",
> +				ring->name);

dev_err here

> +		goto pipe_reset;
> +	}
> +
> +	r = gfx_v9_4_3_unmap_done(adev, ring->me, ring->pipe, ring->queue, ring->xcc_id);
> +	if (r)
> +		dev_err(adev->dev,"fail to wait on hqd deactive and will try pipe reset\n");
> +
> +pipe_reset:
> +	if(r) {
> +		r = gfx_v9_4_3_kiq_reset_hw_pipe(kiq_ring, ring->funcs->type,
> +						ring->me, ring->pipe,
> +						ring->queue, ring->xcc_id);

A side question about this - what's the expectation about the other
queue(s) on this pipe at this point? Are they expected to be also hung
at this point?

In short, checking if this should be done from a higher level code or
from here itself. Ex:

Queue reset -> Failed -> Try dequeue of all other active queues -> Do a
pipe reset

> +		DRM_INFO("ring: %s pipe reset :%s\n", ring->name,
> +				r ? "failed" : "successfully");
dev_info here

Thanks,
Lijo

> +		if (r)
> +			return r;
>  	}
>  
>  	r = amdgpu_bo_reserve(ring->mqd_obj, false);
