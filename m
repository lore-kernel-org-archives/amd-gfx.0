Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D11C35FF3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 08:40:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E3D010E3B5;
	Fri, 21 Mar 2025 08:40:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r7ZnBT0k";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8929B10E3B5
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 08:40:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjkm0XvQXYJYutgXc1NGG3rSmoRCEXWH93sEeuPKDeLj9XR6IOR4rDaCUFa1byBbnw+cgNAv4irAHg157yq8WknOz/m+HhucovkGeQHjC1WtqdTkNq/ZYMrkq828odIrgRuE4Eq7bRSleMKEyjPL7u+ybYpMRchksm8yXzOztwYFoAXGywo4uYu3ssxTLwiKt+I5XtB1DILt6S41DoO0kyIsB3lufbBw493opbEdR8aN4Ng3xZBa45BOTXkzbRaWYEpPPViS+ZQ0oa/sJcT+xLroqijgUUbpebjEN/VC+sYK+8Xnd9dpfodYwRU/tG2ALL21Gw4s1aa2wNU8+ryz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+QdbMlR9hrUuifVGgPMIJyvbF9Fjs2xpoOgMZAs2fA=;
 b=HyNqVjaSb9gWJ2M+5x/V6IVgnc5SbfJbbbEqKj7nHeRoJMy8ObzMnG7Xq208QYgA451cw/xb6dXHjN/xKOSFRGlHm8OmIyea9jOils6bZOk6n50X1TTvFiqiZaRjKz5VA4MukKqKwIRY6Fdbk/FEKbedMsWchyJUZtJSWxzHgadJZvLO3uAJf098c1s/kHJa6fp4Iy5zX1JyOLFSd65Kv2LcWPd1ZXQC6ZLDeb5j7etxqyMQ7xED6DqOi5XhChCGEsYfHb3YJbuGTt1bpXER+qlbi6xkbbjKRwcWK8u7HYX9OkRXRsyGrJSwyLiOg/16rSfQgpmP26xWlYsW9fe0pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+QdbMlR9hrUuifVGgPMIJyvbF9Fjs2xpoOgMZAs2fA=;
 b=r7ZnBT0kZMNGXHKQqcZ+pcssfVCoa0AwT7IVkSHuKL+nHK130dWLkwbN7FxQn4fmyhNa27PfAt9xL7ZHkMaRKKQvLMvJKnGePyg3Us9SxliJuriAtfz1maw4DBLzXXiBTeyCE2+YA0wftIPKrLfnWtfBlPnlNzOldX+fhuAZxXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB7861.namprd12.prod.outlook.com (2603:10b6:510:26e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 08:40:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8511.026; Fri, 21 Mar 2025
 08:40:21 +0000
Message-ID: <b8068470-2c1b-4468-a29b-43bf7bedfe6d@amd.com>
Date: Fri, 21 Mar 2025 09:40:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add parameter documentation for
 amdgpu_sync_fence
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250321012548.2397824-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250321012548.2397824-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0382.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB7861:EE_
X-MS-Office365-Filtering-Correlation-Id: 43119bef-7842-41b6-89e9-08dd685403f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVNLTWRkNFhTOWJEWEVBakkxQjRwQnZDQ1NxV1VVUUsrUnQwWlBmTTlsQ3Rs?=
 =?utf-8?B?THIrRkZSZkRFTFlZUXpCTHdiYmx1RStGdzdqcUJ3Z1RDd1l1VWVhdGpNcjVD?=
 =?utf-8?B?clpMQUFFelF5Sm5id3JFSEVYcTA5R1h4RWFBRmJ4RzdhTWY3ZTlrSGlQNG40?=
 =?utf-8?B?YXRrRE4vTlRDM1Z2dnNoTkZPTUlpL25lVG9wY2pkb2dWMXQ3UlBuVEJXMXE5?=
 =?utf-8?B?R0xDbHlZQkhkemJQRWt4cDg3T3Y2ZFlOUzU1QzNsc0tKMWc2TUtHY0o5WnFQ?=
 =?utf-8?B?WU9oUGpkUVZUN01lRGk2SVU4d0p3SHp5VkVNd0VhcVRibDVDTVVBaEhTREdr?=
 =?utf-8?B?R0twdWF5SzhvQWxLc09VOXNRWjdFOGdNaXJBM2xYeWVHM0ZQNmtLZFBlUHpn?=
 =?utf-8?B?UE1HNHJIUjhaZTQrcEFxY1UzMnZUdWdUQTk3SlFzTkUyNTRsTmlYSzR5d3pY?=
 =?utf-8?B?NHNXK21rN0RnNFNVRlUrK1BJQXA0WDNObmxiRm41bk1kb2M3dDV3VnNtWG1E?=
 =?utf-8?B?dkppK1FpRWNkakYzM3dtSXNWd3dEUEJXY2oxS3B2MWJrUFNOS2diYUhRUFpv?=
 =?utf-8?B?aG1EMm9jZS9FMVEzQlFlbnM5QWQ5NnFQYVlwQ0NjRlRmRXVHWXBVMkZkejBD?=
 =?utf-8?B?OWJ2UXEveFhFdTZJOUwxam1sNnVjK0d3MGZCZ044MUEyRTdYb3hQRmJhaFBL?=
 =?utf-8?B?Ynl2Zmp2eWVWekxzT3JIRURISkErTU9jRWRlR2h6TThLL2xYZXZnYkJVUE45?=
 =?utf-8?B?MUVpSkY0b3I5ZStSQnd2NUYvbFZvWnJpVm1RZnZJZ203WDI2UmRQbDJuMURE?=
 =?utf-8?B?RXU2UXE3VnNUeUxBcWNrTWM4WUppVlhxd2EzYUlIbTJlV3JCOXI4ZWF3aUlG?=
 =?utf-8?B?QjllSlNpcmRmUGZHd0RBMEtYbjBlRVI2ODBBbW55ZG1oa0Vzc0tpTU91bzd2?=
 =?utf-8?B?Ulg2TDFRcFZlTG1ZUVhEMzkxV0FvbGFqRVkxbkxCQ0dydmhDY2RkTlFwZHBH?=
 =?utf-8?B?bGVzUnRqbnhDa3A0L2xHZVBXQ29zQUk2N1dpZHl5Zzd5aGxydUkwWExVeGR1?=
 =?utf-8?B?SHRBM2dQTVFRTTdjZG4xSnVHZVdCSGNtMS9ORGhrbXVLS1kyVTNTNVQxTVdB?=
 =?utf-8?B?SXA5RGtsaW1kcUdaWFU5VXp2TStVWHpSeWNOaUQxalBTT1l5RXNkZFljLzF1?=
 =?utf-8?B?VktNYjBNN2hWMng2TElla0xLVVBidVh4UlByWDZsamhLQ1RKUzR0c2xkaVBt?=
 =?utf-8?B?dThnYXFMRzVvM210VWJwR0h6N2QvK2F0UElGOThTaWNGMFU1bG9JVld4M3Ex?=
 =?utf-8?B?THo3U3g2MGxnUVExemRBMzYxYTgxckJUU3MzaTVZaFVxbkV4ZkpPQmlMaGFO?=
 =?utf-8?B?UTdwMjdCMStPelI3SjNvYlM5Zy9zZThYUnFoKy8ydTZReVVSTEtEZTZBOXJP?=
 =?utf-8?B?RlhDVkpMbHRjd2NZM3Q2Z01pd2dxTFpVeS9FTjdhbWVJakM2VHR5d3FiT3Vq?=
 =?utf-8?B?T2kyQ1NaZkZUWkw3YzhudnN0dGo3T1ZhYlIzdndDaE91T0pacnJBbkhyUnBs?=
 =?utf-8?B?K014bTFCSElDbjdMZXdWTHdEU0dKUFpJZEo3QWkxbzZ2VGZMckkxRjZYZXJQ?=
 =?utf-8?B?aDl0NDJVNTl4ZUlEZ3krZ0lRSUg4TXV5OFNsOVhsMnJEeE5xRlV1NnBxUTJX?=
 =?utf-8?B?c29xYkVUTUd5cTQ1a1Z6Z3N6SlBxRkUxREY4STVGeGF5Y1dVZGc2Ym8wdDE0?=
 =?utf-8?B?b0ZlRXVkVnUwT2Y5ak90TW5VN3JBY1FBcmlyUi9JT0JNZEVERG5zaDVadFV1?=
 =?utf-8?B?TE1iV1I2bEVNSjE5bDkvVVBVNklkVTJNRHB0S0k5NWtxMlNrN0NmaEdUNDlj?=
 =?utf-8?Q?MoGz95obdIUGO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak0wbU16R25uVEpPUmg5TkV5REZqRUxPTGowWnpEZDBqSytkeTNBTEUwYzRk?=
 =?utf-8?B?UGkrNFRKaFpFRHlUdXFxKzFZK2ZMdmcyelhsNUNlbitpc1RGb0N6RkpBcG9C?=
 =?utf-8?B?RlYwUEZGU21vSnQ2dmQxRHoyM0dRM2d6SlRWcHY0TXExK1ltSGh1bElYcnNL?=
 =?utf-8?B?K0t4VENMWU44ZndlelBPYkFkVmkyeWNsOFcwemYvYm00cDIxQXZZL0pYbUFR?=
 =?utf-8?B?Y2tVM3VZZ3duall4aG90dXJYNHd5R2JCcFBXVmx2by84M0F4RTZtV2lXR1ZK?=
 =?utf-8?B?NGx2QS9CY0tQWTlianZUUmF4cGsvOEN5WUZ4YTFOdHYrbGRQTHlJVzl2cE9O?=
 =?utf-8?B?MUp6akpBVUh5bkJvbFQ5SWNHbllYQjRLRmZLRitPS056R3EyU2czQ2p1WW1X?=
 =?utf-8?B?Zm9VNUsyUSt0d1l2Qmg3RjZjc1Nqb2Z5QWxzTHVoOHRxcUhKV2duMm1FUG9E?=
 =?utf-8?B?b2NMUitEUzVzcTVETFRNUk1GMHFOSGpoVUVHQjkvclFIakk5czNjRkJNVGdy?=
 =?utf-8?B?V1dXUXpEQ2IrRDFFakNDVEJXb2xobFFHTUVwejdkSW1VNCtjN1hCdlRnS2I0?=
 =?utf-8?B?SXNOTVNDVVova2lYNU52RFIzeTR1ek5mdW0rUTI5R2M5SHJIWXFpNnBxc2dv?=
 =?utf-8?B?Y3pUNnJOZXFNYXJUR3lGZG04N0sxTjNFYTAzWFBhRG85UGxPTzBVUnNuRDIv?=
 =?utf-8?B?c2k3ZEkrYXVpVVRxOVZERmNPaHI3UFJkQnl1eGpmSDc3RTlHdGR6eUt1cjlV?=
 =?utf-8?B?THVZQkc0WXYySTRwOFd0N2wzbnU3emRrUGtnRXhJRXMrbEJ4QU9qM1dLRDQ3?=
 =?utf-8?B?NnQ3SnRNQmxwZHgyaVBjbnVSRVRpYjJrVzlHeit3RFVWSUVNaWlNL055czYr?=
 =?utf-8?B?dGpqS0loQ0dZS1JmZ1VZOGh4ZjZ1WUNoN2FCZEoxNXl2b1I0UkdZdGpoWVIz?=
 =?utf-8?B?QUxqSFBoWlExVGJmdEpyU0VHcVkyOUV4cHlBVzFWcDg5dUNhS2xwZGlJWGRV?=
 =?utf-8?B?MFhiL0E2VmxDcjZFUEJpVWRTVEw0b1NkYkY0bkxkWHNVRUVDc2R4UStjSnBi?=
 =?utf-8?B?WklGS1BaMDNtK1N0TVFsSGc1YlNOYUtnTFJocjIvRHBKNjZGcGZtTFJoVk9i?=
 =?utf-8?B?aTBacStMR2tPU0xUSzFZN204eVdOeDBWT0lDSGZTWnd0NE1PbTA0eWQxK2Jl?=
 =?utf-8?B?eDgvUVBOZVNMdVpkcUNLSFN5ZWs0TThGN2Npbk1XU3dHeGpLakpvMjRWa0ht?=
 =?utf-8?B?b05iQ3RQd3NiQkI4cFkzS3F2ZFVOdUVSdUtPMW5QbnE4RFgva0tyNWMxdUFS?=
 =?utf-8?B?Zjh0Z2ZuTjR3aDBrVThNcHJBYnFHeDlqcG9aTEdKUzdIWTNHOVc5T0o1Nk9a?=
 =?utf-8?B?RGU0ald1U2tJaVpOUmtmY0lnRE43bDdibjBDOVZ4b2FlTmsxVlEvbTgrYjU0?=
 =?utf-8?B?dmQyQW16dWNielJNVlZidVk3ekd0N2ttSTYyNHFlZEh4QmZLcGswaVQyYklr?=
 =?utf-8?B?azA3RmlsWkhLeHFxOEZ3UFVhU0Nhc1U5MUpCb1NWRWJiL3g2eWdhQWhpWGUy?=
 =?utf-8?B?TEFvdDhjTUs1aFNTc1pORlFUejU5K2hUZUtxcnBWUnk4MXlhc2pZckR0a2RP?=
 =?utf-8?B?S2hUZTVzZm1kVTFEWXpFSjZtTVJuQlIzZHR1MWU2dXZqemYxV1RXeGgzY0FO?=
 =?utf-8?B?dWxJeEoxUjN4MnlXUDJQMDl2K2dDYXFtZXIyVUxHU29MeTVnZmVaMWVKelE2?=
 =?utf-8?B?MVNvUnh4VjBvN3RxY05GNUV3Q2Z3bHNCcmtuV2xpNG9zQTJNOFFuZzdXSU8x?=
 =?utf-8?B?VnRZS1Bid3JOUi81NzJ4MXp0REp0K1VzdXFRckc1L3gzTVNlWktuMjVFck9L?=
 =?utf-8?B?L25xOENBNnBYd082Mi9tTnRnNkNOR09QNmxCNnVqVzdUYnM4MzdWVFBKZHRv?=
 =?utf-8?B?MXhvWnpaeEFKZC93VEFHVVdSZ01YZ2t2VDZRVVFvUVNwZFpGcGlNclF2YlE1?=
 =?utf-8?B?NFoxN2tHUzRPNHRCQ1Q4WkdXK0dCaEtGN3ExNWNRS3pOWVlGMVBHVHJzQlJX?=
 =?utf-8?B?cFduZUo4c0RlL2VwUndMWFlDamtKUlp5aDlFaEJ3clY3aGlqemU4UWRnVUpp?=
 =?utf-8?Q?UTRs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43119bef-7842-41b6-89e9-08dd685403f3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 08:40:21.2284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rm6hNlL4PUD5hNUtqVEMf6A9whi8ciMsfWWDpMuzUP8ndhqjhaMH5RQMlbLkFQw4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7861
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

Am 21.03.25 um 02:25 schrieb Srinivasan Shanmugam:
> The 'flags' parameter, which specifies memory allocation behavior while
> creating a sync entry,
>
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c:162: warning: Function parameter or struct member 'flags' not described in 'amdgpu_sync_fence'
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> index c5f9db6b32a4..5576ed0b508f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> @@ -154,6 +154,7 @@ static bool amdgpu_sync_add_later(struct amdgpu_sync *sync, struct dma_fence *f)
>   *
>   * @sync: sync object to add fence to
>   * @f: fence to sync to
> + * @flags: memory allocation flags to use when allocating sync entry
>   *
>   * Add the fence to the sync object.
>   */

