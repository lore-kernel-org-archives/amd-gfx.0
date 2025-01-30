Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F58AC0218A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 09:43:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1D4B10E90F;
	Thu, 30 Jan 2025 09:43:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HJGPJ/Nh";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3517210E90F
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 09:43:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNeX+QYWaQln/RiSODLonizzh2i87ZGIKUd3ERLjmOh7cqEXNLdDjZWoRvjMMJOF7/+DGhAsqwTryt/tATPyv01ujIi0mVJwkk+T1rbcBfyNwpzKwNgDCErA3X5nnb82StbVUKb6TOhD2L3mU41+7jQ0BAFXOXv58emgocCFI2VVldPhjd9i9RhvCY01mcxQ/i3AbjZ01ErhfEAR9LroTnAMvCSIZ43UHGQOAVZqpXGyiD2C9YuloDUKExnLO+rHG5e09SFuZabL7ofXeLZaE6T71XCzd7iVgzbzHBYLNubb2d8mNgwfz9vHJXE6nu8jykBHURmgU62uvHATjPp9kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHKKI4odQVKjJm48lcqCkkis9O/ZQ6JICoBMuUhoFno=;
 b=SAAP+LFe9jJy2cpL/hYaqZ5mXTASyBt1WiVY54fW2Dnmko3QkrFANYqOWFmktezWHjE2RMd/PQNOhj0xlwEpwjxNWROjm/DnkVnPqNGNnBeyHf66EvfehEwRj10Ug8SGFZfanAkT2bmxAMjGn7Q0A9fSlQD9KbaaR+hpfkt8+99pODgZG4pHvwGU8iC6ZIDjgXzisB/h18A5jCblt3g1t9kpq7rrmc76/qnkhIIJtR7irrXWJPGUJMWofL4o6iVULSYEFSdoNjxSWJkJyLpATDJ1vCMXhycJJdtjlVIs/Vefjygqqy5qpjBmz/RtgfF8uQrHp1KklNzFUFxX/WYnfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHKKI4odQVKjJm48lcqCkkis9O/ZQ6JICoBMuUhoFno=;
 b=HJGPJ/NhZhaBEiWOozC4LLfBEiZvO9vOdmXgc0kPG5VUKuyxXm+3S+ChJxtRMAHAXPuNwToxn6aI93DXDGAiBMl0zX4lPg8bX5KUtkuZdNd2/VaTl1qc//mcsPadjIxMHcdLyBohGWSxMgGjFaL7KqEmm1xLoMkBHz29iPKfkvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 09:43:14 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8377.027; Thu, 30 Jan 2025
 09:43:14 +0000
Message-ID: <b7de7aad-f213-4402-bf06-6022189c789d@amd.com>
Date: Thu, 30 Jan 2025 15:13:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: enable the attributes for vb flashing
To: Mangesh Gadre <Mangesh.Gadre@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com
Cc: Shiwu Zhang <shiwu.zhang@amd.com>
References: <20250130073759.2219240-1-Mangesh.Gadre@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250130073759.2219240-1-Mangesh.Gadre@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::25) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: 994a2593-7f12-4012-2767-08dd41128476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amQraUFMbjVCbjExQThic3d0SnlicUJQTE8yaklia0dCZFdyUFJuSlBneTBz?=
 =?utf-8?B?MnJSY2Uvdjl4dy9SaGd5REg5NTJwajBRaVdrdVExbjRGbWdRdzhEa1RuSjdO?=
 =?utf-8?B?aDMvUXIwbWt4Tk1sUFhDNEZ6d3BFelZGdFpwQjdJNVhhQ3ZGNE00SVpxU056?=
 =?utf-8?B?OUw4U0Y0WVZXYU1JNGVnZVBtUDBpNTl3SEVoY0tVYWRlMEVBOGdCMzl6N2Ux?=
 =?utf-8?B?d0ZXdlN0VnJNQmprZTdmZVVxTGxodk9EMkZHd2s2NU9VS3FORkFZc0xxTE4r?=
 =?utf-8?B?OVBwdGp6Q2VtOWY0eXZNOG1KcThZYzhjR01uTTljQVhFMTR5Vld3b1ZlZHZh?=
 =?utf-8?B?Mjhrdzgyek5qanExczBXQ3dVWUhmbnI0eFowRnhNUmVJZC9ycCtyNE5lODJK?=
 =?utf-8?B?a05XSDh4eHdpcHI3TlRqb3J1eGtYc3llU05xNktxWWg0RWdmc1dZS2ViZW96?=
 =?utf-8?B?SWFCMXd6OTJoWC9tU1VROC9DeWU1YUZXL1Ava3pNVVIxalZMSnBlek5YbGVp?=
 =?utf-8?B?Rng5SlZjNnhUeDVEZG5zdmlkWmd5d1czMXcxdENkcXBvbFNFOUF0WVRjTWcy?=
 =?utf-8?B?dDFqdVFBRlVaRUlVY1ZsN2Q3MUhDcHJBVCs5ZjNvVUY5clYzOVVSOUdQMFVl?=
 =?utf-8?B?Znh5eTNjUzdubC9SL3RMWjgvT2tneGs1bGNqUVRBUHdwZ1YwSzJBaEpQMGl2?=
 =?utf-8?B?bHZ6cERtdmJsY2NaZm1MOW5YUk5TMnhGVU5pRzk0ZjdPa3VrajVuR0huQ1pG?=
 =?utf-8?B?L29SS0lxWm9adzJVbFpTNjNUdHdyaERHQnNVYlk2M2JOa1NsNVNCMWFOL3JM?=
 =?utf-8?B?eDhXVERvNmk3dkhUb1JnTWsvTWxHVDhyT3R3MWx4Nkphb2dORU4ySkl2ZEFh?=
 =?utf-8?B?bzYwUm5pL0FzYVZjSVFxeS9ZU25IbzlRQ0UrTjdEMmxDYnh1blE2WmpORldY?=
 =?utf-8?B?RHhYZTd3RHFROHpGT2FlRkFwMTlZMEhPM0xQYkZpZWJhRFdsdUhveHhvQytX?=
 =?utf-8?B?ejZLVTdtYU1WZ0k5UHdmNHRhbTQyVkljWUtTWi9mMWRKZkNqdWY0RldQQU5Q?=
 =?utf-8?B?YTE1L05xYXc2aGxkMjNqREdGMG5pSk1HOWkrQmJqTXJpbkI3TFZVLytMbXJR?=
 =?utf-8?B?S0pORXBETXEwWkoxd2NOVWZ0eTh3MkQxR2p5bWF1Z0pEalFYcktMOGtMMXhR?=
 =?utf-8?B?QTR0S3dNSnVRaGc3S0JnREE1MlVQWHJPYWpTYW5UWHpESFRjN3pJQk5jVE5O?=
 =?utf-8?B?Y3dkUWtRbDRYa3FPbzIweHZuOWY4Yk9aZFBlVU9PbXMvUFVnSE9UVkFINTky?=
 =?utf-8?B?dndiR2Z4a3g3QURmd21ydm1lME9KcFBlUVRSNG9NTHlHcGFZYkUvdzV6VDhQ?=
 =?utf-8?B?M3YzTmIvTlhLTHZYRjBiRC92NEFOUmZnNU93bHp6TWVwWnBWSWVkWlk5QnRn?=
 =?utf-8?B?dDVuMXhMMElUYkc4MG1NeTdUQi84QTEyblZmNjFkTjRrcUI5ZTZFdUFMUmpq?=
 =?utf-8?B?TmhTSmJydERJMWNRZWdZZ1VHY3BvT3g2WTdQZ29UYWszL1k0d3RuQ2loVnNH?=
 =?utf-8?B?NlhzS2FYNmluY1dLUXRKbjZGSWNMdUdnR2V6WUlXa2JTbVo1OHhhTFUrM3RB?=
 =?utf-8?B?WlhuaFdXSGtZYmhSdWpQK084b1RZOE9ZNWRiMDVzSVVRaUJVWHVPS3hpWnZS?=
 =?utf-8?B?cTFDYThJeW43WmlMbGVuSlplWkNzRUw5dWpZWE1VYThvSE9nS2dTOUw0QkFa?=
 =?utf-8?B?Q2Y0cGxBUUlTNW5qSnRHTFRPOEU1eVJmc2hDVFVhemw4Z1cxNjBwR0pheWRi?=
 =?utf-8?B?Qm1sRTFqS2Q3Q2VEb0lCektOZitjRWt1YVFvalJCSkNUOCtGb0pveFlHbXU1?=
 =?utf-8?Q?AZw1Vv09W4bYl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z256ZGZhZFhVQmMxaG0rR0pNLzdyNGxmNmR0RWl3OStRbzM1U3lvSTBIVk1v?=
 =?utf-8?B?ZlFVcWJTRXBRa0wrRjhwMzIySjlCbFJvTnJvWUticXMySktSQTBtMVhnY0dj?=
 =?utf-8?B?Vmc2dHV4eStkblJveDhwZ2hkNlFETGFYNS9GRGxFVkE3VGJRenhaK29Qa1RM?=
 =?utf-8?B?QmZnZkh1b25COTk2eUY0M2pDK1duM01nVDg3b244aHhyMlFMcW56MmNYQjhw?=
 =?utf-8?B?Vk10Nkw3aUl3Rk11WXNPZHB3NVJBdGwvUmJtVkVmOGtVUWxjWFdSVWZENDZu?=
 =?utf-8?B?WlIvWStwR0RaYUNsRUMxNlZzcURoRFp2M3h6SGo2WkdkSlRMdjhBc3lDRy9Y?=
 =?utf-8?B?WXh2dWFROVdVQ3ByaElmbEdTK1Z1N0d5OFlnbmVON3JSVllBdGx0bFdTMysr?=
 =?utf-8?B?RXRtK1lwTExuVEpkNVJHNlZVVi9udHM1aXROWXpucXhVWEVnM1lIdisxMHh2?=
 =?utf-8?B?SEpNZWVrZlVDNTdxdzBPbVJXc1UxTG1rQUNDVVgvYktXVUlNbFNVQzZvN0FZ?=
 =?utf-8?B?MGR6ZnNiZWdlK1grdVFJUGI0dU5YUm1qVW1NUUtidmphQXBkQVViZ29aSkJL?=
 =?utf-8?B?bVZhaGd6ell6QU8xenN6anFxN1czdDhoMk5sa3U4VnZKeStxbVpSNGppbTM2?=
 =?utf-8?B?U1hDMXZycTlJMjFscysxN3FFUEpTb201T2xiNUFYYkFVSHBEaDI4ckw5Z3o2?=
 =?utf-8?B?N0laalUzTkcySTF0cWhvdlNTd202N2UxUnhGL1M0WTNVYTFOQTBHTTJPMmlz?=
 =?utf-8?B?dXZ2TEJhMHlkb2Q4ek5XT1IwL3Zpa1p0ZEg0YW1sYlQ4ZFBYMUtsdXgwYkUr?=
 =?utf-8?B?WHp6VU5Nd3ZET3BmSkpQQVNTVmVJOWRBR0RXTkxEV3hsVTRncTBhMkZZeitk?=
 =?utf-8?B?RkRNYmIrZzljQVVuUnJxMTVBRlp0bndWYmR4dDQwUlM2UW9YbllyeStETFlH?=
 =?utf-8?B?UElocTJyWFVRbzhuVDUwZTlmNFlWNEN6K2xCazZDQVhlUTJwS1ROWDhkN05H?=
 =?utf-8?B?eEUxQktFODQra25CcXM5enc1cmMrQzE3MVgwQ1dNTm90UEp4eEY3OGRrc3kw?=
 =?utf-8?B?cUFVemlzTXRHL1VPSUtIYXdUOEtRVmd4VkpCRXA1UGI4TEpXcWFvc3pZRXdR?=
 =?utf-8?B?cHJERXpQeGVzYWR4SlJUT1IvVk9NU1dPem5ZZXkwdUlKc3EzajkvenFsWGs2?=
 =?utf-8?B?MU1CTUNCTFM2dnBUaENET1JlMitBbndRMXFIY3M3UkVQWEN5WGs2dzErU0RK?=
 =?utf-8?B?NlJUWkhLTHFXbDdNTEhwWUM2MmEyMGQ1cFQ0R3RaL1JIczJndk8yQU82SlF0?=
 =?utf-8?B?elNPdjV5Q2RnYnBIOW5mTUNrL1lPNm9MaVNURlp1cTFiMGVzWXdmYXFOdXJz?=
 =?utf-8?B?MmVnUXAvV3BpMGM0c1B1ZnpUdHRHam95TFROcXdDcnJhdjczUDJwQ0tuOGw2?=
 =?utf-8?B?cnRqWXNFNDhadEh2OGs1Qm9jZkVOZHEycVNGeWNHYmNyVTRrcG52QUNlMXBt?=
 =?utf-8?B?cGxwb2xxeVZqNVlSRWpHSEFUcWpKQkZCRjBkY1lJUlc4ZndsZDc1enZiOHV1?=
 =?utf-8?B?VFFzczBYdng3VXFkZmRVQnhsaWYyTG5YUzBlQlRKZDgwY1BPY010UXZPWSto?=
 =?utf-8?B?S0pxVnpnQnE4aGZUcDZWbHpiNEQrelNKOXhqMzNtTnRUNDFMTS9uSWlIdk1y?=
 =?utf-8?B?dVBWd3BGNVJRZnllWlk0b1VKa2ZwaXZnU0hmYkk3aFd0bUNEcElTdElIc2pF?=
 =?utf-8?B?ODNKTGczV052bnFLOXhjbWVicUowc09mQng5K0s5bWg3SDJkZStZSVNhSjBw?=
 =?utf-8?B?Y2o1ZlJTT0oyMmJJbkNPWkl4MEdoTS9vaUtTMVBVcUpWYko2RFFXMkx4NEJI?=
 =?utf-8?B?QSsxdWp0aVV4dkdkZENkMUhBS1NqMHg5RlRvSE1Oa0t3VjlnQ1JXeFFCK2FI?=
 =?utf-8?B?TFgwSXgrRDdYOVByUmVzK3Q2QUdIVlZwdHdIRU0xNWZzL1VUZkp2WFNONmtE?=
 =?utf-8?B?eWpTTy9rOXJJTk5lN2dLWEYrd29pN1NDb0hGU2hXMTNhcmhIZVM1V24wVkUw?=
 =?utf-8?B?eFFoSDduOFFxeHRqYklLVUNLQklHQTBjd2piWWV3WFRuK3Z5RXgxZlR3TFBt?=
 =?utf-8?Q?x6jPeqVTHcs25H5pM5ZfdmBet?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 994a2593-7f12-4012-2767-08dd41128476
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 09:43:14.7530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/6fPaDgzenDAVvsZc858YySFECt/RyzxyRRYf32kk5qei2OIEdUuNIl9agFKalP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334
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



On 1/30/2025 1:07 PM, Mangesh Gadre wrote:
> From: Shiwu Zhang <shiwu.zhang@amd.com>
> 
> Make psp_vbflash_status and psp_vbflash available in sysfs
> 

Suggest to keep subject like

	Enable IFWI update support on PSPv13.0.12

With that,
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 4c794e8ca7bd..b531adfb4f57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -208,11 +208,15 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
>  		psp->boot_time_tmr = false;
>  		fallthrough;
>  	case IP_VERSION(13, 0, 6):
> -	case IP_VERSION(13, 0, 12):
>  	case IP_VERSION(13, 0, 14):
>  		psp_v13_0_set_psp_funcs(psp);
>  		psp->autoload_supported = false;
>  		break;
> +	case IP_VERSION(13, 0, 12):
> +		psp_v13_0_set_psp_funcs(psp);
> +		psp->autoload_supported = false;
> +		adev->psp.sup_ifwi_up = !amdgpu_sriov_vf(adev);
> +		break;
>  	case IP_VERSION(13, 0, 1):
>  	case IP_VERSION(13, 0, 3):
>  	case IP_VERSION(13, 0, 5):

