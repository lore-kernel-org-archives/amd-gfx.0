Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8FBC3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 11:36:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D034A10E5ED;
	Wed, 28 May 2025 11:36:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CicG3j2q";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39A2710E5E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 11:36:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qq9aDTb4qATR2XAgIug5qLPQGARWNHxNnPZblL4GhBWTZiydL71OVrWAxX9vov5/nzUhDpy64nBVCnsPsgWvd6G44a41tBawxpKD02Rj32yq8Z5JwgqgqvK2+5TAFST5MGrkLpLxnH2qTPxV5G+LlMFHB9Wq6bAHqAE/0tDEdM99NBjmXUmLcpgcnV25GbbRy4OQbiNegU2p9cC4kjXKlkBkZkkvgI8NsJshZC9uGuf+i6jT+wjAJDLAizrbznyYOQGZVNOKV8aAoMhOTPEq0aY1leU6bdb7ntuh/MSPccC7bJ+EWSpHpWcDDWG7MKsSmsj0ECfg2pBMBeLngkkBww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CZTPoml8+O69buj8u+RybYQ/xDIbudD6iNGSmVKgHo=;
 b=QwOpjEwCZ0KHyCn/YAs0vJbcq+CWjm6aTYrBaW1L8IaNBVn7OVmYlT0viJj10LLBfKHMVuUDXr3QALbgIHUGqe1nS2zRLfqya/R+1r3eJxf9T1XtZ2HmnOBdqsKmdCg49w4wMqpemEM/hMDK//AxngFpo8TD6swJP29O8JFOzcnQp310zKDGLh3zwYd1Q9O9zik5zBS2ur9SmLhnUapYXMG7q60/z+s4r9qXe9+zQzdPIzsj5gBZFxMoBZIGZ7LhBkl0bllblphxaBAr863Olt+ko85khIln7sieiCfhEuKcMqGoSnkljsSxMPqGLlyD3rwvxU7q8Ds9UpQikO6cCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CZTPoml8+O69buj8u+RybYQ/xDIbudD6iNGSmVKgHo=;
 b=CicG3j2qAfi2GJlistDu8+7XSj3/ulyyXLm3+i3x7TqT6lmZhnigBFG+P4WpFciYpISqc4lb0zegjzhjqLWIv135sOMt2OH6Hq2Rl7L5CjpUNZUjZlPH/emBddxCAliKVZ47WKN8ainhuOiOnKfYm12e7AOOAYpwUtjVZiYFIdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY3PR12MB9704.namprd12.prod.outlook.com (2603:10b6:930:102::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 11:36:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Wed, 28 May 2025
 11:36:29 +0000
Message-ID: <7299c780-8d32-4840-91f8-0056d7acdf52@amd.com>
Date: Wed, 28 May 2025 13:36:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/19] drm/amdgpu: pad ring in amdgpu_ib_schedule
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250528041914.5844-1-alexander.deucher@amd.com>
 <20250528041914.5844-11-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250528041914.5844-11-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR01CA0004.prod.exchangelabs.com (2603:10b6:208:71::17)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY3PR12MB9704:EE_
X-MS-Office365-Filtering-Correlation-Id: ce41290e-5c58-487d-1d33-08dd9ddbe383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L01JS1RsQ2hkdHBCbjAvdUpMQ1pNc0M1YmhnTVp4WlNKWmRRZ2pvaFVLajg1?=
 =?utf-8?B?SE5QSlN2SUdxN1VRdGNqc0NkdEpkQk1DL05xajYyK2tMd3ZSejlqN3NSdW45?=
 =?utf-8?B?M09ueDVNMXZkU1lPWEVQRmFTQk5XOFJYWFJaQUw2Mk1XT3RRNU82VmZkcVox?=
 =?utf-8?B?QWQ0a3VFYStsT2pHS0pUbjROeGE5NWVpdE5qMnA5K0RlK1ZTSVpMWVBicWdU?=
 =?utf-8?B?eHZhWkhMU2FFYWo5N2NRV3lXZDBMajBFNG1uMDVjOHp1UGpVWUdzVG5HMTFj?=
 =?utf-8?B?MFYxb042OVQ2U2lmNjZ6M0dJYjZneGtVZU0wYytUUnlNdFFDeGxGYWVqVTls?=
 =?utf-8?B?R0NFQ0l0N25rMUlWRnBtYVBEZTZoOFFkcDQwVWZ6WXR3ZUkra3VuVm13RnlK?=
 =?utf-8?B?RCtBN3pVc0wzeGJJWXR6RUY3M2tycmloU0g4eC9kcmNFYVl1UlBDYjJSTVBH?=
 =?utf-8?B?R3UybGVDRTJETEg0MGI2YWpZelBRdVpTMFBqcWRISmtiSVRUYjFNSklYeDVE?=
 =?utf-8?B?QzBLSjBvczUyMmVyRWRyM3BQSTVsMkxMemNYYzU0Q2k1WnUxYlpBZFc2Y2pN?=
 =?utf-8?B?aE5JOEIvWHk3YnpBbjJybm1JTGpDR0xRZnM5Z21NYkdSM2g5V3FEYS9XbExx?=
 =?utf-8?B?VWEyUU5QOVJreXM3R3lUeUczME5lZExHV1FTUGFEb0k0cFIvT0pyb00wekVr?=
 =?utf-8?B?VHFvclR5d05BUUxNQ25NaHRCWGFiaFVFOWsxUmJpakZMQU42SXo3ZjE1TFV5?=
 =?utf-8?B?ZGtPYU1tcStqdVp2dS80TVN1Wi9jdzN6ZHE4MHduVzYzbjdwNUlZdmNtN3cv?=
 =?utf-8?B?YVhBUFEvQmxCUDVVdElsOHMzMzNvV0I0dUpweVdMVWNMWm1uTk1xaW1idjk4?=
 =?utf-8?B?U09POGEwQ1RVVzc2bkNXRkxYK0VvM0tON2xURUJJenpNeGswb052SGlxdkVq?=
 =?utf-8?B?OVpYUDR0YXd5bXdIZ3hwSkhSTmRkOGxqTmdheFZ3bVpqdDBQeEV2U0pWYklU?=
 =?utf-8?B?ckU4c2ZoWk9sZ0RSeGh1SjhYNUN0U1pDempHbHZmamU2L3h2eG1sZjBoMmpi?=
 =?utf-8?B?TjZKOEI5bk04RmFROWFyZFpMa05qdFBwd1dLa2hOV3NoS1dtb0VpQnhzYXpE?=
 =?utf-8?B?dVhSbWhwWWJvWTdLd3ZpODhJeEQrN3NlTVZUdk5DZytaeHBPcnpvM1QzZW5o?=
 =?utf-8?B?c1RGNUJ1OHQzekZaQkZJN0ZkV1E0OUpiOEZLa24yYlUrV0NIaXNocThGdUtF?=
 =?utf-8?B?aEpBV2k1VzFocHZ3eENXUWw0Wit0UkNYWUVwaUVBT2hqRzBOL0xmZHFIUDEw?=
 =?utf-8?B?ajZaMHArUk1RZEcvaHdUQmtObXQySHNWKzFmaUEzeUhMOXNNL2RBbUE0cDZv?=
 =?utf-8?B?c0hmc010eU1qUFQrZldodHBmUTcvcmNTbUZaZk9ucEE3Q2xYSHl4SWRUcjFn?=
 =?utf-8?B?Rm9PVDlmdzdkUnMrTVZ4QTNGNjUyM3BKWGt2eTcyTjRaVGx6VG5VaCt2eVdX?=
 =?utf-8?B?Z0VHckVaRnJUakhqVFFSTVNyVytvUWM0aTBNY1NOQ1hyOCtKRHFQTXhEQkkz?=
 =?utf-8?B?VXFxMUh6RUg2VklONVhOeVpQVjFVRGMrY0laTE5NaTFMOWdTd3h2TXZRRDJJ?=
 =?utf-8?B?eEo1dllSLzRUYzA3VFk3SUIvbThoV2pYNERkVWkwNWxrYWZGeVNsRmxTVTdu?=
 =?utf-8?B?U2gxR0VDTWF0bFIraWFzK0d3OElyU2lDMndsZWhvNk9zNjNveXZnRG1aYXFv?=
 =?utf-8?B?bllhQi9IM0hFLzFzSnZxTmwxU3BZckpkQVBTMWZxQmEyc3N5K01FemJRRVhr?=
 =?utf-8?B?Y0ZMcHE5TGZtVVIySThYREYyZUZMSFcxZVdSaUZ0ZFVlS2ZrTDRSWUt5ZUdu?=
 =?utf-8?B?WUVTNDljelR3ZlY4R0QzNEJIRUlleHlSSVNENjRYUFRaS2tEaUVRcVl1cHZp?=
 =?utf-8?Q?zwyKWdX8XVs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkR0YUJHanBkc0ZkUDhIek1UNkw3SkZUcHVhT0hzVldFekVhWlcrSlJROURZ?=
 =?utf-8?B?NnFINUJ5cDJhNEJ5a3pxVTk1ajVFYW9LTHhXUDBOMXJSSC9HdnJIbmF4RlFI?=
 =?utf-8?B?YW5yc08zdW9uU3dob1lFUDA0Ny95djYvWEc5WjVjaWdwZDZvQWx0NmVJR2V6?=
 =?utf-8?B?bGtTMWo5VXEzV3IwSjNmejRFQW5nWDBiK3I3OHlTdmMvTm9wTWVLbDNvZDZw?=
 =?utf-8?B?ODBPQnk2bzJhdzRzYWJiYUFxRS9QY01KcWdUUEdvSnRVbzdqQ0JZeVVhb2VT?=
 =?utf-8?B?RzhPZDFTNkIyZkZPaXcyZlB5WTZUMFh0cXJzQzh4L2gxcDZQN2kzdXpzQ0VS?=
 =?utf-8?B?akI2ZW52SGpLVW9uMVNGQWVLOHlxTlhxNGRVMmtGbkhIUTk1aE9ZcVd5MTNP?=
 =?utf-8?B?amZKYy9pK2hHK2pJQWI5K2ZMVW1sR1RpeXZhbHFlcGNiM0M1OUFQVGtJelgw?=
 =?utf-8?B?T0FFWlJPbncvYUwyL3V4UlMxM2JaQTFUS3BDb3p6azBycWJkbWRQSGdtRnVI?=
 =?utf-8?B?U0tBS0ZYZGFyR3FVS1dlcEZ4SlQvVFh2UmQrOE9xbkxoWHFCbUsxVkdiZGMw?=
 =?utf-8?B?RXlRQ1VpZHYrMVE2blNjMm9oa2t2cFR5Nk1ablozWVA3d0poTWg0dlV2b1pw?=
 =?utf-8?B?RE1vcURQUHZzKzAzYjJZT05nTnB1WWgyZjdESWxaYUtaN3JZY2dPYzZYb3VN?=
 =?utf-8?B?c083UXhEWVhTR1g0R3I5b3doRnl1aldCaStnU2lVTFkxU1JTNzZxdnV6NjVi?=
 =?utf-8?B?a0dXaWZMZmFZQkFIcXBUTDBkUnRjcFNsRnYvM3p4bXpPU3BzWUZGRTB3SXNR?=
 =?utf-8?B?Nm9nNzUzUzMxdkF5blU3UHpLeWJpVm1YQWswQ0d0Z0w5K20rdkVqdW1iQXRX?=
 =?utf-8?B?U0NnbFJRc3kzRTF6MC8xMjZhbnRGWElBZTlRdUFtNWxoQjZuS0JldElaYXBU?=
 =?utf-8?B?MXRETkc0dU1CN0ttNE5oc1hzZnZJaGZ4OGl2eTZkUXRmM3MyOUJuUGVEb1U1?=
 =?utf-8?B?UEJWVHdpcXZOM21vQVVwK1ZyMGpBTnJMRzYxUUpkOWpDVTFKdWkzTE9sL0hQ?=
 =?utf-8?B?MUVINmgxUzNTL3hPMVR1ZEV0YWk3ZlgrcWRJem9ybUF2aHVyNFgwNng2NytB?=
 =?utf-8?B?eS83VERKajdMQkdXOGpuMnJjb3UyUEF3TVltdnNkQmpnNXp3cmV3b05KMFZO?=
 =?utf-8?B?TVM3UXVnYzdEUzA1SmYyNUxzMXBsRVBNRENZc0hUQTdNcUg4Wno2VllZdVpw?=
 =?utf-8?B?dldlQnArRUVYRHBXbTRtMTcvdUJUSDFPSGt1SXZVcGZhOXhqZmJkUHJKcEoy?=
 =?utf-8?B?ZlNaNDgxOVNvVi9ZdTVuWnBidmFCS0lSMVF5aUVIeTdna1hDMVNZRUkvbkR0?=
 =?utf-8?B?WU9lNmd0OHE2czNIZHQ5NlVlRGxtejdiQkdyZmJsSUo0QlR4eGJmdkxaMTVo?=
 =?utf-8?B?MERwcGtPMEhiYXZpU3FQaHp6bWZNck9TN2pBR3A5Ni9qc1NZMk9NOG9lZ2dB?=
 =?utf-8?B?T2FEcEJFby9TckR0UHpTT3BkbFlSYkdpMGl5ZlRyWTBTWmNLRXpKeU9ZSUhK?=
 =?utf-8?B?ZTNrQ1RCSFJXTDlxSjdZNHNreDFPWjNxMGpxTkRVdGhTblpSamVTRUpZazFw?=
 =?utf-8?B?QmxTa1UvM0dRdzFUWEtCdjdRanliQ0tXL0FUS3AwQXh3blRIWEhsRHl6SVlj?=
 =?utf-8?B?NXQxaE1jSzl3TFhzbUNST3JuU3Y1ZmxERnBLVE1Jb29yblplTjlBbmRzYjNh?=
 =?utf-8?B?WEtGMWhtVTE3bm1KT2xURkFzWUwyY1lSRHJ6N3MrbTJQYlZ1eEhWZG9rZE1t?=
 =?utf-8?B?VklkUU8yV1BvUUNuWW9CRGFFVlRZczB1VTdNcHNzR0wwSWN1L3E3KytLYXFU?=
 =?utf-8?B?TVBYMzkra3gydCtZTVNuQWtpcG1OaWd6RTRZaEFtdWYwWTFwR2x6RFVMSTU1?=
 =?utf-8?B?bW1mb1RPelE4UkduSlNyQ0FmV3lSbDVxclBvRlBmVFVERkJ2UkxJUGdjOHpi?=
 =?utf-8?B?REYrZlBCbWRlQXRkVzZETFg1MWVGQVJ3Z3hVVzBES2hJTXBvcE1XaTdPSCtm?=
 =?utf-8?B?eGZSSEpDVVZDS043S0VaY3RmcUlBNU5zbnpEM241eXdZN0doZmJlSDI2clZH?=
 =?utf-8?Q?gyhKDe8zjy7gx+ln6vvzJOti7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce41290e-5c58-487d-1d33-08dd9ddbe383
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 11:36:29.8732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNUkRZBLc5p9OaSo/S8YyZvYTs+TKc0KbTZnvjZ2sXEOlKslrR+HAmKltI4HhtjC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9704
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

On 5/28/25 06:19, Alex Deucher wrote:
> We'll want to include the padding in the wptr count
> for resets.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 802743efa3b39..3e05e8bfaca4a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -304,6 +304,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
>  		ring->funcs->emit_wave_limit(ring, false);
>  
> +	amdgpu_ring_pad_to_fetch_size(ring);
> +

Hui? Why that here? amdgpu_ring_commit will do that anyway.


>  	amdgpu_ring_ib_end(ring);
>  	amdgpu_ring_commit(ring);
>  	return 0;

