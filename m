Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470C1CC6B34
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 15:04:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9D9810E7F9;
	Thu, 15 Oct 2026 15:04:02 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63BED10E188
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 15:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptFWGlvnlk2nXPw4sM+T5r85K4p06D43lgwGVCZpCQb0wNj95s0dQDIukSCY/2o98y2yKXV+g26+48SQw3lurdWPVJm61VyRIrIMxHq+Q/+sTdw6GM0ePdYl52JsA+0XmYekAbCNtiN24jiEnm8h9Un36v7lpF0Bj9PgvsmUH/V0LsobZbq+C7XMqFeTg1eyid9WZUNd9ehqQ1pLtAHwo0zkjhKqY1N1mUjDEYPBNGv2Qk+wMFMjVXjKHN4DB3NFGFjqvlRDihwscIl+oR2Qr6jZmdLZpCRmY0by0b8H3fCf0Ttm1oHnH7s0INCo/W7EFElVZOvNWAaBamMRfBkljA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3kOzvKP6F9X6lCw9Fh9ZRkaunp/0Vk5N63f1xx8cfw=;
 b=uHW0ocZDN0Ky0Srpco02pByCW/+2liBAOCgKHMkdJHxt0KGFdf0jxr6XNgW23PZytMRBYhldnRSPeY6lXjre9rpfxCBeCRbdZRGgNUonGj0O2LsI45dQ/OinF8WxmnuaNuyTqM6LZ7VfvrAY6j3xhZ6MOOom3aqnLdEd8ND0nYgkfEN4s4wC2ftsK+8KwG6nAd0ADgWfrp3VOIuUkzD0lQdGp7ubpq21BYlMSTlKHZzDE1Ke3mVDlo92jfWAsjGX1eRPdr6mG+q9IuJKWXABS9Er/8Dnog0hwfHU5hqx/W/XtSz98g37JNyOKrXH2qxqEhXC+hX1vgdJqYEanHgDPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3kOzvKP6F9X6lCw9Fh9ZRkaunp/0Vk5N63f1xx8cfw=;
 b=KmThGRlNwDsgoU0YEhrEy/WfO/x55gCykvMjJNrz60G6iqqks0Tc0Ze2HcAggHCVgm3I7UXz4JD9m6Fv6gEFkFpi9f/ZhmtTSzROjZu8uLmB3n5FvMOibXAK++kMefwiPQn+L0J+CLriw8EFpewt0SZ7awQ2uLCnuLthzgB1MjU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by IA3PR12MB373595.namprd12.prod.outlook.com
 (2603:10b6:208:711::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 15:03:53 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 15:03:53 +0000
Message-ID: <80da275f-3212-4e76-8637-e77b357439e5@amd.com>
Date: Thu, 15 Oct 2026 11:03:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: reject ANONONLY userptrs that span
 multiple VMAs
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>
References: <20261015083744.3448696-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261015083744.3448696-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0001.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::14) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|IA3PR12MB373595:EE_
X-MS-Office365-Filtering-Correlation-Id: db6b81a2-8669-45bc-ddb1-08df2acd86ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|22082099003|10067099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: fNrL+zH0SG+kHMxqrtRd4OUs8m7lzNRGoadR/yJPutwJLOMro8wsBsrqvbfxag2lEmz1LNnVsOumzwK+u92h6P1KSoFe233DYOYpKUxHIiFnoP9sWUgeccYKX5cpCcrLpxwX8JFxqigIqYIyKnQViRgu9b0SsfULwpLee4I4OecFeRcwH6FI0aqezLEBZkTLQdTEv4fNu/UI9jL4AjPJUb/TCn99Mgtc2TsGjx6BCKbYGUQBsmEosjKvn7bV3hVQxhuVXwfVdgmPNqJBwuU1SHd5L72cnbAhcymrO5E9eO7ulCVPzMysm4qNzLEe/XxAdGzlHEoe8xGo0Z+GB9HI+LU5LSkV0dWQUQz9XbijkxlH/ppSnpe31k+ZBZqTWXPDaQjTb1YXHJWrFVPL4mujr+oTHdhWaJP58Znpgay720yQqJkNhadHuri4nkFmQQLioBnlI6WV5MROiQfLbaH7Ns+QSAw6QdWhPv+QWyfdZo913gA029AbZmtP1W0ELpoKPwcM5r9v3PldS+lUq/QLl3VcgXiVeBrQWQG1qWBWDqnWjXWTyKHhimWucjHWOfL5ieHBEkTMqA+DUlcEmQFxoCPDQ9GOp0irexSiYOnzCEC5y8Egnwjr5tU6NgfS7L+x9aqetYkuX6iLzzP5uSHSoK0w93ffaZ4THQ5xGnxR1Ik=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(10067099003)(18002099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDE1akNEL2pFeVVZeGFYRk1KMUticVBvdHJrdi9vdjYvaXE3eCt4d0gxdGFG?=
 =?utf-8?B?YitsdURNSldUYmRJSG1vanB2ZVg2UU9TK1grSERJYTUvQXlMZUR5ZVRkWDJI?=
 =?utf-8?B?ZkFFRFFtc3MrRmJPN0twWU9GMU83ZURsdUdPU3F3cmpWdFlNQXArWjdmQ2Q1?=
 =?utf-8?B?TG11U082Zk1sdTJ2b1FiVGZsTE1BWWVyZXNmOGdBRk9HV1VsV2ZhdHRndVEz?=
 =?utf-8?B?TFJ4dGRJR2NRdlVwNzdTVk11S2QxdGhxemJVZ29xQWZnWDRqSkM3UU0zN1Fm?=
 =?utf-8?B?czRma2g1d3dxMjByNElNTEplY1hnNDRDRk8yUFpMbVBielZPYTdmNUlSTVVU?=
 =?utf-8?B?dDFpYXNLUVRtTHRVajF1ekxwV0VtMk04bU9sK25Hc1NPMDdnZ0hOOWVFczNs?=
 =?utf-8?B?bEgxUFptL1RSZTRiUEV1elVzWi8yM2RjcC9DUXplMVVuRjBTNGhUaGpMRmZs?=
 =?utf-8?B?UVRENHRGWXlrVC9NVnFJSFRrY3JiWlNzbkRmck44cktCNTNWVC9LRUJ4QjJE?=
 =?utf-8?B?YStVWHR2ZkdZczQ5L1M3bW1aenZPWk1PbExCL3FUZnlzSUVLM1BFUUJoeXBp?=
 =?utf-8?B?R0d4WU5OaWdhYUVqeDFOdHZlcmVEaitnZ2dndHJTVndUcHZTZjRDTVduUWsz?=
 =?utf-8?B?eTlUMGg3N1R5aHVweWpub3p4RXVLWUdLWG5qRzN0YWY3RUp2RFlOcGRUdjlG?=
 =?utf-8?B?a3RtZE9aSXRRYXpFVDJmTkg3V3hhQUJpRGRIdjR5a0oreUVVQ2JIOEtWVGRz?=
 =?utf-8?B?WXNURU5Na0cxa2hZaGtrbXZ0WWlVcFE4RCtPNVlxdENER25xNG1oUnVuWENM?=
 =?utf-8?B?R08xaUF3RS9ERzJrYUk3emI3TkJpMlZ3SUNyTmlOL3ZTUzdoenJEZ0NOcmNt?=
 =?utf-8?B?d3ZTSU55RFlEZGVhYW1JczVTL2pGdVQyY0ovRmZZSnB5SXBxRHBHbEQ2cHc1?=
 =?utf-8?B?MTgvQWVKM3lEZWZSNStsZ05oSmJOdGt6MkdWTGlmTkM1cDRmNDFxNHZMMFFJ?=
 =?utf-8?B?elpjTVI3ays1UmY0bEZtK3dLV3VQMEhEUGFtTkgzS3E2MjMvQXZ4VHpnVGox?=
 =?utf-8?B?UkFTUHVhNWM2REdtYWdvcTJJeTFzQ3EydHR5MTl6c0x6a0duODRjNkpZNVhC?=
 =?utf-8?B?bFRTR3ZScHF6ZGg2RnRRQzRuMTRFNlBBY0ZKV0NOc2ZVM2FwSnFyUm1ZZ3BV?=
 =?utf-8?B?MW81WVZYMFlXNUV6WWNQREpuM2s5L2NDZ1g4Q2xlMCtVWUtYRjBWcjlTQm9o?=
 =?utf-8?B?WlRpUUw5dm5YTUplYVlSNmIvMVp1RWprRk9GN2p1WEFlUm95anJ0YlhNVFJq?=
 =?utf-8?B?a25EMEpOcWZTQjZURnAzQWtOdkhhTGFGb3BWYkI3WEdRb1VKWkFsdFE1YTNq?=
 =?utf-8?B?VVlMazNWZURaMEFtTXlvaUlMaHQ1d2lLQzBScDNFaWJ2NjY3OHdVT2hDLy9S?=
 =?utf-8?B?a1AvZVEwTlV5VWtUc2Z2L3B5NWZyaHZCWEp5aFdqNm0yZXBQZHRkdVowWDh1?=
 =?utf-8?B?eEo2bGk3b2lwTjd4SUZYODFUZUxDME1yWWtucXI1ZWg5dW0xblBwa0pRNkcw?=
 =?utf-8?B?VGRkOWI5emJlR2VOYWozeDFWcUM4V2NSdzduMkIyR1VDU0pBOEc2dGphTnFS?=
 =?utf-8?B?V2NobWE0MUQxSzVFWld0ZlhSOVRCdjRrLy9NbVBOcm1FZFNwZjlYejMyNjIy?=
 =?utf-8?B?UHNTMWYvM2l4ZFZWcWtuZ083OE9FTC9Tdlh0aTRmSGxmcmg0VXhCNzhFcmVo?=
 =?utf-8?B?SWpQUTVDTnBzWkNhNkdEUVNKS1dBcE1OY2NGVlJoaHVWaTVJemJvaWZORWgr?=
 =?utf-8?B?T3VhWUdlSHc3K2dERHBwRStFZlorWTQycGhhUVpvR2JHU25QaXR0STJHR291?=
 =?utf-8?B?Z3RxbHNVZFBnSkpiMFF3VzZ0NkFmOVJtOEF4NjlZUTBEb1RLTWE1ZDdJZ1pN?=
 =?utf-8?B?K05hWHp2dzFmQWlNN0ZmejdyOWVBM1cxenA3WmlPa2ljaFc2bEN5UmkwVUYr?=
 =?utf-8?B?ZVRVMHM1WGI1dTdYdVVMNnV0VU0wRlhndDVUc3p1RWsyT091L2VJanJINGF6?=
 =?utf-8?B?aGNEZ1B0VUQwelRDSDQzYVVCc2Y5eThxSnBib3MzR1JRcUJWNnk3Z1dla2VR?=
 =?utf-8?B?RzBSOEdOclV5SDdSczJDRTBqRDJsUkhxWmZXdXVORHMxa243Nlo0YWd3WWpC?=
 =?utf-8?B?aHNhNDhtaXlmQ1pOTlhtVm9pUGN2eEluNWxwU3F5VDNjRk5oVDJDRnp3dkx0?=
 =?utf-8?B?U3BZTDJGRXIzbEIwUDVDaEhDZHEzWklLRG1OTnpyaFNPUUFWaDJ1N0VNZXJH?=
 =?utf-8?Q?XHgxgaP1XAJC40xc0m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db6b81a2-8669-45bc-ddb1-08df2acd86ca
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 15:03:53.0412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuvyivYp/+9S9JacLjIE3IjWC7ZwTBGOZ0ceZ1k+KxxZBmq74Dl2ERthkUGfiWwiBRstKezVZ3GT3iX9R0wpJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB373595
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


On 2026-10-15 04:37, Jesse Zhang wrote:
> For AMDGPU_GEM_USERPTR_ANONONLY, amdgpu_ttm_tt_get_user_pages() only
> checks the VMA at the start of the range for a backing file, and
> amdgpu_hmm_range_get_pages() then faults in the whole range, across any
> other VMAs. The check used to reject ranges ending beyond the first VMA
> (vma->vm_end < end), which got lost when the code moved to HMM.
>
> An ANONONLY userptr over one page of file-backed memory is rejected
> with -EPERM, but one over an anonymous page followed by the same
> file-backed page is accepted.
>
> Restore the check and reject ANONONLY userptrs that cross more than one
> VMA. The second userptr is now rejected too.
>
> v2: reject ranges spanning multiple VMAs instead of walking every VMA
>      (Christian)
> v3: cast num_pages to u64 to avoid an overflow (Christian)
>
> Fixes: 6826cb3b92a3 ("drm/amdgpu: support userptr cross VMAs case with HMM")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Philip Yang <Philip.Yang@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Acked-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 2103f8d6165d..9c3efc27b363 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -784,7 +784,8 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>   		goto out_unlock;
>   	}
>   	if (unlikely((gtt->userflags & AMDGPU_GEM_USERPTR_ANONONLY) &&
> -		vma->vm_file)) {
> +		     (vma->vm_file ||
> +		      vma->vm_end < start + (u64)ttm->num_pages * PAGE_SIZE))) {
>   		r = -EPERM;
>   		goto out_unlock;
>   	}
