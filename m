Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9853C369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 12:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5768710E448;
	Mon, 28 Apr 2025 12:04:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BdIyWyYs";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44CF710E448
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 12:04:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feZhcXbbMZDb3Vbi0PHs3y04rfqMIlKEKxAwWVUCSBeNSS5caCL7UkoNZb3ijNtsMcYN/ARvd5G8ACfFyc9EPGGleFqwsFEmBHBSGNLEc34/npxEc4EfG+S7SrihguDIEjrbGAsfXIexqL9B0WiHLRizsUy5yEnP9c+ILz1t5hsOqV+6AWjA8Be/SBpJQzD/Ah3BUUrDDK8S9tNtzCXjqrRGa+Mv2dPJBdbx+cMpdTmma9VE8fjkm/IolZQT+090w3tgAO9gGX9U5Pif13MTWiWLGl2vVPVCWlR0loRojn1nAySXaQor6nBQisI+8ce9VZ7Qc2QS0U/NJmWa9V5Opw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tv/+udK28ASAj7TqleIOcsXkQESqL4kMy4Nk44NoQcI=;
 b=odY6UnMY4D9RANQY1qaHRZSaODyltPkWeXcbaSMAW327NaCWQhh1avbb+85Ed4mLCc1/dMjxDOE1FTjLvak0PAFAk9rt0cD6fxq+oVROaRzKQiHGN4FDpuEjK3OzYCyVwlLv6Qlzz5M7A88S8j++4idWn5oEjvvzfMo+QiDWWYYnpww3XG7VVukbhh+4Cqczwg0gX72ZKDoVHHIIkItOlmvux9HCNOOqAVlJ5cFVT5FVZ04UTMH//KgkopA+1TV5FuKpl/7ClfZadRTmmw1676nhXiFgY/No7n/2Xyq61qmsXiQc+NrvJBNU7oXDAkn3L72b26UeyjRYtSpllUePAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tv/+udK28ASAj7TqleIOcsXkQESqL4kMy4Nk44NoQcI=;
 b=BdIyWyYsCsnnIceDdGnm5d+8hwLcZqF3ZQHbirf8hk/aboEHzb5cLb2rZhXI4a6Io45iHWw4mvpqa+chqfgg9AZkaap+VnFlP/ZFcukukN968d8k4BKLo5I1ipnYZRG9OzFP80Yqavz/JWwL8pm8VEJEE1G7U9DSPJ27kxZoA7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 12:04:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 12:04:19 +0000
Message-ID: <4dc273e3-5d37-4fd9-96a0-a78897bbb8d6@amd.com>
Date: Mon, 28 Apr 2025 14:04:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Add debug bit for userptr usage
To: Shane Xiao <shane.xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>
References: <20250424055426.1471075-1-shane.xiao@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250424055426.1471075-1-shane.xiao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 4578eeb7-8450-4343-164c-08dd864cce37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUwwTGU2eTNtSEkyTnQrRGM4UlJEbmZYbU1hY0Y4alRFaG1KRFRHMGt4M21a?=
 =?utf-8?B?YWZHOEx6QjJlWkl5T1BYeTNFNTRBWUwrVXVHNFRBendWMHFYWkJuWUFML1Jv?=
 =?utf-8?B?TFU4MVlCaGduK2p4TmxENTM5TGVkeUp5d0FkMFZpZkM1TnYwMWRWWUVaK2cv?=
 =?utf-8?B?QzNTNmhYRU84Z2hlVk5OeUZWKzV1YVA4YnpZV1dUdGVxelhGbEwvMTZxcUw4?=
 =?utf-8?B?Nkx5dGdmUHNmd1RDTEcxSEsyaCsyckpSNmZPQWJsQURyaXZvOU1td2hseXNL?=
 =?utf-8?B?ZmF0ZDJJN21KRllkcnA3dDJ5NnpjQ1ErQll3SUVXdTJnQkhCejJqTDk4Qkx5?=
 =?utf-8?B?S0pTOFJKUXIrNE9oeDRMV00xSHpPRUdYY3NIQkxvTml0M2tqZkZOQWYvS0p2?=
 =?utf-8?B?aG44NCtmakVRMVU4bUwrQmF5Uk94ZTR1WEozQWZDWmNvdFFpbTFCOEVxVnE2?=
 =?utf-8?B?bWNhbk1wb1lPUHlKSUlMOFV4RU1vd1NYZ3BoQyt2MGx6bC9xTWlXRUhqWXFx?=
 =?utf-8?B?R2VkSml1RmZIVXo4NDRIVnAzTFdXT25hY05PU1dCUHZKaXRhUE5aSDEyeVNG?=
 =?utf-8?B?K3VDdDlCdzB0OTdtMThRNXFkclBSZ0RCOGJseHFJRXJpZDd0M1dHU0U4djho?=
 =?utf-8?B?MmRrckZwdExpeHVmSFdjMU5mMFJIelJmNk5NSFU1OWFNbkdFcVNYc3J2QXds?=
 =?utf-8?B?NEF6bG1wYVpvYUpEOVJtQ3NzZERGYWp4UG9PYUxMbll2Q3V4MjkwODNGc2JU?=
 =?utf-8?B?WnJITENEN2NJdTlJS2dtUXlSS0FscFQzY3FzYndmNWRlWFdDMWJWdkp3cnVM?=
 =?utf-8?B?bGJ6TndCdnUvK2ZkMnNsN05vbW4wcEdkOUdKRyt5QXIxdHFMRmxZektiS3Rv?=
 =?utf-8?B?NC91b09qUFgzcENVb04rZ0dMWVNtUkF0cHpTS2VuUDJFdXpXUHlhK2ZCZGph?=
 =?utf-8?B?TkF0U3B3RDZFTE1BZzRhYndkMWZmOUE2OHdqazd3S0xYdXZXRXQrM3Y1eDRv?=
 =?utf-8?B?Y2hISU1MMGJhMXl4K1lxRXl5V0ZpY2swbTNQamVEQzNGdFdzU1RBQUU4a3F1?=
 =?utf-8?B?WFIvM05UTlVWVjROaFBxRDZBMXhjNUUyTTR0N2haUVVjbUVadmRPSjFsdjlw?=
 =?utf-8?B?eHpsTS9KZkc5OFJxQU9RWVJVbHdiQjd0TWZBQ2VMd0NZMFpLTm83ZGVKaW1H?=
 =?utf-8?B?UTFBdzRFYkVTZytrVjk5VERzOTR6bERkRHA2dmN0WmRUcCtkVTRaVmttbjRD?=
 =?utf-8?B?enFCaHhBUnZxcUp4bWRoWFk2WGh0YlBIOTFYYkRtb0hyMWx3cXVzWmRzK1RL?=
 =?utf-8?B?MWdnMjVLWmpJb0ExVXlNdnVScU9nTC9tVnArUW8vTzdrSUhsK21YV3F2SEQx?=
 =?utf-8?B?SUZNbUNYSUs3SGxXb0ljRzdrRWpNWjBVbjFTTWpxdEtUbGo4M1lMN0thdXZL?=
 =?utf-8?B?anVzenVEcGZDa1JIL25MRFVRV0w0ZnhDQlhPS2NvWWJqbGZidDk2Q3lMZFds?=
 =?utf-8?B?RmsyREFNeDJFQXJQOVZVQzVnV2FQeHlqenJ3NTE2NkF4SDQrOERxZlY4SEUw?=
 =?utf-8?B?eGVjNVdCY1R1dmJIWVdVSU11eklyeHMzUjV6ZHBwcjRqZ1Z6N3BhVzg1ekhB?=
 =?utf-8?B?bTN5QW5sWjJySXVyWjVTM2RDVUQyR3psUjhTMnMzMy9OVzJTRkNtcWtUcGlu?=
 =?utf-8?B?VjNWcjBLZEY1NE5DM3owc2ZNbG1La0ZiWDlMTGFmOXh5WGRnSzAxL2FCaTlq?=
 =?utf-8?B?QlpndUJRVWgvSGFUbFFqRE5WS1pzMldKYWs2azZzclE5ZVNQSFF5RXZ6WXFL?=
 =?utf-8?B?N3hjYnk2OUVVa242Q3liS2VDd0tnN1FrbDBhRzQ3dm0xOWtzVi9qOFFNUHMw?=
 =?utf-8?B?T011dEpobjNMM1dlb3pXY3NsR1d3UERiZGowaTBPQWtQZkI1ZitybzExM3hI?=
 =?utf-8?Q?r5GJ499lp7E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnpZYWU1dVpyTi9kbEMzNHRkeDBSVTVnbnJUYzRlWXJ4bWVMdHpwZ1ZFNysy?=
 =?utf-8?B?OFVFUnF3QThUSlZpZzErenlOcXN6aGxrZ3VJNVU5YnQ3ZEZLTWM4WDhJV2JW?=
 =?utf-8?B?WG9xdTZGN0Z6clN0ZlIvdWhGYUVKYms4OFZHNFNBcUN0eTRnTm1ueXRVakVJ?=
 =?utf-8?B?eldUeCtLNm1MTmk3Y3Z2azkzM0NaV2Z0Rk1qV0xxNWhZQmtSdWl3cCt5MitQ?=
 =?utf-8?B?dWx2VExmK1lIbG9BcitwQThDR1h4VVlJbCtEOVNvYkhVdUpGNFgxSmoyV0sz?=
 =?utf-8?B?MmRMOVRGdnVzR0l1Wi8zVmhKWjlnRXMzbE90cHUxSm1RdkE5VTRCWnNrK3ZI?=
 =?utf-8?B?OHlFbXNuMWlkUjVGRWRmQTVtMEE3WXVvaDA0eXlJbFhjUHNCRmowTzZnQzZu?=
 =?utf-8?B?TnhhMzY5Uk5xbGQ0NU10NE1Sb0FkWS9BOHRRRno0NTlmZnJGZmdnc0pRUk9E?=
 =?utf-8?B?YkZJMTNMYlNUNHlReWNwdTl6U2ZuRVhqTjlmcWEybm1Bb0x3b2F1OEt2NUJ3?=
 =?utf-8?B?YUc3K28rR1N0WmRqY1N2cW9nZEZQZTlZMlhpU2dkbU1QcTJwMnAwMGd3REhh?=
 =?utf-8?B?SEdkQS94TktjZXRmOU8wSi9wbzNDamV4QVFqUEc5dmI4THhQQ2FXdytRMTRz?=
 =?utf-8?B?aWdpVzdBa3RjODZyK1N4bnRVS3JKaVJxa2Yza2o1WmZicExrTVM4bnQ2cEZt?=
 =?utf-8?B?T01HZjdjYTE0bTJ4Z2dQVVdzbTArdjhZV1pLbUo3c3hKc3FzdEszc0xPbnZa?=
 =?utf-8?B?YnBtRmovZXNmVU9mTi9aT0I4ZzA1VnpMMzVGeU5MT2pEbFFXVXNmcVpXVEZU?=
 =?utf-8?B?Y05YOWtyY3BQQTBWSU5SdWRHRU1WTEZvdmVDc0RPUWt5a2Z3NWNRNmZJUDJH?=
 =?utf-8?B?bS9wYkxhcjJFam0yMGdSc2tiWXRMWHdaNHdwNUpucjBTYWF3MzJvVFZia29Q?=
 =?utf-8?B?Rm9vREV3dkpOMml2ZmZ3QjRXVW9uekgyUmJDQlZ0TlJhSHFoSWpqbHg5N1c4?=
 =?utf-8?B?NnNFUDIzeUlDRitLc2RUc2U5OHBRM05sNkloVU5aYzdpcUgvaTdYUkJtRWky?=
 =?utf-8?B?Tzluc2V0VFVTYThNRWhRSSthU0t3ZFgvdCs4WWNBMUY1VFprNTdtRlBidUFw?=
 =?utf-8?B?WWt0cVV4R2xERXdGT09YNXFLVXFNKzNsTlRaMHlQVEtmSWtXcHFiZjhYMUVj?=
 =?utf-8?B?L2dTSmZzR2t0cUZWeXI0MmRSMXJJT1dtZFVSZ2lYTmFNa1pBRngvUmwydGlC?=
 =?utf-8?B?a3ZpTkZVOVBETlVRN1VlTGZseUk5WkNIVEtTaG9KZThrOVVLZGNzVWhWK0M3?=
 =?utf-8?B?akV2ZzF6Qm5SQTE0K3FBM0lqOU0xVlpmM0VLUm5ocWE3ejg1QVhuWDVrUk8w?=
 =?utf-8?B?anpITXRZZ3JUQ3g0WThPRndZU1lMUWJ6aXJpam5BTlI5b0pFdWp0UlRyRFBV?=
 =?utf-8?B?S2hkOWpmcEdYU0xjQWxYMkVURG5id3dCa1lNeExKRGNQZW1oK0dHVVROME5a?=
 =?utf-8?B?RXp1VmpJa3M4Y3VQWGNMVFk3bldCays2bkFJMXhja2hwY2JJcHdNNERtdnEv?=
 =?utf-8?B?bmw5RlQwVkdTUStqWXVVdEZEMjdjRlpHOFdyQ1VSUE1oSllxZXhmN1FJWk4x?=
 =?utf-8?B?WXhMRlo0em1aTlEyQUpJYTh5TjMwbnJHdm9RWEU4bzVnVDdOVVhHczNyYnVv?=
 =?utf-8?B?Q2dCL3ZyU21Td096UlFvZHhaSFdCdzFHTnM3SlNQYjEwd01SVjlOS2hMVVVh?=
 =?utf-8?B?TVRrSmIrL0RZVVhvWTVSanRPSS9mQm92NlA0UXMwNnBKR3habFNLZFVWNHcy?=
 =?utf-8?B?YWV3TmNaQW5uOGlzd0V5ODlVaXAwYlJDaG1QY1dWZGRPKzY3eGNXejIzd3Mx?=
 =?utf-8?B?MzFLTE1QOURjUzdJdWRKbkhzdTdScVV3cXhBSVdRcmo2UDhtc3k3U0NVQ3Yz?=
 =?utf-8?B?cVhza0JtL2JNa1VYRlRIWlBlbi9kTDQ3SWtIZ3ozQnBRT29CWitvM3NSR0Vq?=
 =?utf-8?B?aFA0L0NyZlM0Z21sTXlVd2JZQnRyNHFjNm1xa1pTYkpkVVFrTFArNjdNYk1E?=
 =?utf-8?B?ZXpmZEJZLzBvRy9xcDMrdlMralRmY00zVStvRlNLMXA2VTdSb3QwNVkxQ25p?=
 =?utf-8?Q?VRm7WPP7E9Y0plZqeNOHnloCk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4578eeb7-8450-4343-164c-08dd864cce37
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 12:04:19.7429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5oeGdHDGvoBC82mwwsWKv5LY/CFZe6Xwz6rRObWEJqtRAO1gVq76ud8xhsvfIi/4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7343
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

On 4/24/25 07:54, Shane Xiao wrote:
> In VM debug mode, it is desirable to notify the application
> to correct the freeing sequence by unmapping the memory before
> destroying the userptr in the old userptr path. Add a bitmask
> to decide whether to send gpu vm fault to the applition.
> 
> Signed-off-by: Shane Xiao <shane.xiao@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for this one and feel free to add my acked-by to the second.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index cc26cf1bd843..6a4c75124ad3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1230,6 +1230,7 @@ struct amdgpu_device {
>  	bool                            debug_enable_ras_aca;
>  	bool                            debug_exp_resets;
>  	bool                            debug_disable_gpu_ring_reset;
> +	bool                            debug_vm_userptr;
>  
>  	/* Protection for the following isolation structure */
>  	struct mutex                    enforce_isolation_mutex;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b9a1ef343c79..0ea3693a94de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -143,6 +143,7 @@ enum AMDGPU_DEBUG_MASK {
>  	AMDGPU_DEBUG_ENABLE_EXP_RESETS = BIT(5),
>  	AMDGPU_DEBUG_DISABLE_GPU_RING_RESET = BIT(6),
>  	AMDGPU_DEBUG_SMU_POOL = BIT(7),
> +	AMDGPU_DEBUG_VM_USERPTR = BIT(8),
>  };
>  
>  unsigned int amdgpu_vram_limit = UINT_MAX;
> @@ -2272,6 +2273,10 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
>  		pr_info("debug: use vram for smu pool\n");
>  		adev->pm.smu_debug_mask |= SMU_DEBUG_POOL_USE_VRAM;
>  	}
> +	if (amdgpu_debug_mask & AMDGPU_DEBUG_VM_USERPTR) {
> +		pr_info("debug: VM mode debug for userptr is enabled\n");
> +		adev->debug_vm_userptr = true;
> +	}
>  }
>  
>  static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned long flags)

