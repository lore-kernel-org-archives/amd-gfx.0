Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF96D3B7DD
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 08:38:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B713B10E3D4;
	Mon,  8 Dec 2025 08:38:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3ZMNTzL5";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010013.outbound.protection.outlook.com [52.101.85.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6712310E11A
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 08:38:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8Kak9Zb4FT9oDenYbB62WeucDbp05okdzSMC3pfrGzN2/WRlURIkPqWiWF4YB6WyHUfoIfXwopnRHKCNcYHiYS3bEpI9vdTwYFBUr8I9oz0+WxN5n1WJZcIzabXtxsArT2O0jthjiWwJ6FAfOgX7ZIonHBri53QVoYJQJ+2LPLix9rJupRzyrXS/P8ZTtJOlBQPOAZJi/BOqQk9Cu8kAlMUAEpcw1TlDfdh1AGpfyluBUIyo/TSgPFrgeCRcFhEIpWwJ6PwXKV2YXj3z6u5xvH6oK7E4Aj8do8aO87oDQ/YVoejvqsbBV317d9rvBE0ix1vSo9xchAcb1lXn+12Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5uiBfQz4zn9QyF5Rq42SKhpSXjhax15j5UWza/1bCc=;
 b=gr41GUQVgNGc1pPpcmtHTZHCnByhtmUAv+dvd58gZtscuobzxDn/ci2qCcod4YjI6iHni4DNTHH3w1GNEkTxjKj6lHOj81slg8VoUU8AzKJ5PBcM2SqXoZOL3WpJO7jxXdj+clQIbkAgR5UMokjeA1LA/xA+Atpu3qao5PHAWOedrpPmUQofVXgifQXjtSYo1+372zHvzv6g9Oe68JR+K7bnTBGgqDxSd7VpikoZcpFbPqVVl5jyIULl5cwxsEKwg1kBTvkgNjR2Xh8cV2BAQJ+fV+2383XSzq8rYqW3Mj5nS73WrW7kS/we4wPXlq3Tk96JErZoGBeQuztjd7fTug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5uiBfQz4zn9QyF5Rq42SKhpSXjhax15j5UWza/1bCc=;
 b=3ZMNTzL5smvfK3Wtqf5SNcQMuNjAYFXZfxfKocyq86Jg3nNnwXpVm7y/MAWkRw4qmOP4AGkSYDIkqgJnSHD4TmpBRMbsdWewBqW3YjqfuZdIC/nvRuP/XE/VAISE8HReT276DGAQ/CKRElxlx9YlU6vnFmZCrXU2wec4SLg5fbk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 08:38:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 08:38:24 +0000
Message-ID: <b9a1e29b-b84a-4e5c-a2ae-e642309479b2@amd.com>
Date: Mon, 8 Dec 2025 09:38:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] drm/amdkfd: Bind MQD in GART with mtype RW
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, david.yatsin@amd.com
References: <20251205214922.1095629-1-Philip.Yang@amd.com>
 <20251205214922.1095629-3-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251205214922.1095629-3-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0665.namprd03.prod.outlook.com
 (2603:10b6:408:10e::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: c3265ecc-c263-4acb-5702-08de36352681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yk9nOHBmRkRMaXZFYlhCNExlSkdxa2NPZ0ZiQkZsTVU0SGVvYzVQWVdOOWlM?=
 =?utf-8?B?M0h6bTZtWkRGNWtjdmFvRFB2Snd4UnE5Y0REY1ZlYzZyTkVTWUp4MmhFM3JB?=
 =?utf-8?B?ZHRCb2J1TW1tSmlMSjZ0b0FURHBQdndHaGNaZVFubnBmWHpPbEhJT055UHRa?=
 =?utf-8?B?amNZWjFrZTlRMktHV1N2b3VYRzUvUUI0K0NaQkVVemF1b1BaQXBsYWhkNnp1?=
 =?utf-8?B?WFlNVFYzNHhrZERqanpweUVvL0NWQmlDWXJvUVg4TENRbVNaVjZTOFNqT3Nn?=
 =?utf-8?B?c2oxSTZlZlhOWkh6cVM2QnFtdzZic3VNMUJ0eWhzSkNsbWlEMHdCNHQ0ekdm?=
 =?utf-8?B?ZHgvQk85N1FOT3ZUWEp0Qkg2MXNiVW9pWUd0REhMcjlwUG5tWTFvYlIyMmEz?=
 =?utf-8?B?d1FRYng0aFZFR2FJbmhnN0IvTy9qTHEwYWRxZ1FiRm1mRDBhNTY2Wm84aVlt?=
 =?utf-8?B?NWtoMDBrQUgvU0ZKVmJQYVRrNUgzL3hnenpYbm85MkNXN0IzWDZUQkZ5NkMz?=
 =?utf-8?B?Rjc2NDVULytXZ0VNM0FmQjc1aktNcmRqOVdneWRSdXZOVXM5MEpIQThPemN6?=
 =?utf-8?B?UTBEV3UySng5OW44TzJVWmtpZ1FkUzlTRW05MXF5UEIzQS9ZU1NxVVdwMmJV?=
 =?utf-8?B?WmpNanRDWWR0aXBCRUNyRFFiL3IzWVp1SGxmY3Fvd0tzYVo0RCtiZTNqOTN4?=
 =?utf-8?B?N3Y2QWl0YVFOMjErWDB0dTRQeFM2NGdFbTlvdlVyaDgwR0RrRS9FK2xmRTNo?=
 =?utf-8?B?Z3dUdWhKLzM0RVVnbWNEU0llc0JtWS9yWEw2Ri9DRUZiL2FlY3FoWnVwY2ND?=
 =?utf-8?B?elJHV3R2ZWRtSC91QVBjV1llajVRQnlVWE9QQTY4N2VjSWR4Y3pvZHlaekZ1?=
 =?utf-8?B?cSt4RXlKdFloNC9YTkFzOVJPYmllWmIwR2poWWR6TzFodjJubmFrUlBmY3oy?=
 =?utf-8?B?RlpMVDAyWC9SYzcxZUp3QThucERuYTlCR3Y5RU9XYzR2bGEyNHMwQ055TEVw?=
 =?utf-8?B?VGFmZ25jR0hsdVlBcis0aVJyakxWekxkTUhnSlBNUnRtZmdmSzZLRGNuMUpk?=
 =?utf-8?B?MzQxelJ5Tlk2YjlaZVZoazJMUWhHUGhydWIxK1dxT2taejJzc0FOQjVhZjRX?=
 =?utf-8?B?TlMwM3hBOVZXaTdlSHhYNG4zTW4zTkNPVXdiaTVsVzFwZE43UTdMbjBDL1dI?=
 =?utf-8?B?OWJ3OWgxQi9aTlNPKzRqbWR2ZFJCUW5XQkhVaWI3d05TUWNQamVUZGRwcGxj?=
 =?utf-8?B?UlYzN1cyWmphNDErNEVwSVM3YkwvTFFZWlo1YkJSUTB3N1lZZDRMSk1abEFy?=
 =?utf-8?B?K1N5T1FWano1R0M5ZUtnb1B2OHkra0lGSGhCN1RzRitXYVk1V1JlNGVWVHpw?=
 =?utf-8?B?TlhscnUrVVBlYng3eWgrM1RwdGJyc2RpK2ZPd0VucFpHTk5iYjIwMk1KYnlv?=
 =?utf-8?B?Ky84QVY3MUdPemt0a2ZVaGRFU29nLzhKUHRSSWl0MlVRZmtnc1VZa1dHZ3Q0?=
 =?utf-8?B?cFU4Z0dHcE5vZ2ovc2FoVmxNeUxscWcxZ1dTQ1daUTJOYkMyNzVnZzI3dnZp?=
 =?utf-8?B?eC82dTk2UWlyZEc0V0d0OTlmT0cwTUpyZUsxWjNvbk9NY1BkL0JpVDYrMzdP?=
 =?utf-8?B?Q0VwV2VqcjY2NXNvdytiT0JQTlMwMmNwUjZyd0JDNituUUdtT2VWaWN1NEd0?=
 =?utf-8?B?alJmV0poYXZVSnpwUmVBemZvY09IM0xvcnJoSTdvTG9QSDlLeklORHZzcGhk?=
 =?utf-8?B?Z2VpZnNES3Y1VkJObnlqNUlqMDI0RDVQQTFzRHg3M2o3MDBvWG5zeTNtRDhN?=
 =?utf-8?B?RkNCNVlWVUFMeThjVGVmeExvS0djLzF4S3I3dlRrTHRML0dMZktmUnFqaHZQ?=
 =?utf-8?B?NDh4RmFxT3ZkV3lUYkw3Yk5GMUpzWG5Xb2JLeCs5eEFaNnB2SjZzMHZ6SmZj?=
 =?utf-8?Q?UebX/MfRXr1zcTPYq+qqvsNeMsSOIeX0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlY5NEQ1RHNXVkZabmtSUUlVbEd5S3M5dSsyT1FpRm9rei8wM3JsQkJoL0x0?=
 =?utf-8?B?TndVRGt3VDA0a2hTWjBxc2RqcGMxR0d6dHJuWVNRT0FTWEdjenlqQ0w1eWhx?=
 =?utf-8?B?SDFuZlVnSzI1NGtDVkI1WGtxdG12c0FlTVVnNzFTMkdUdUUzQXBmeHBPYy9E?=
 =?utf-8?B?cStTSENlR3pkS21FMlQxUVl6V3lzWmE1U1M4MmROUStqVDRMZWNqek5kQXdE?=
 =?utf-8?B?OVg3c3kvN0V2RlNNN2xDRVRnZVZCa2U1ZUowSlV3MnFMdmFzL2tsUEJFa0p6?=
 =?utf-8?B?eXNTMWUrNUhtVFlxNnpwTXU5Z3UvWEtBMDB5eDdsUkdRbDNwV20xWjNFcDUy?=
 =?utf-8?B?ZmVENjdjdjZqeUw1M3JtcDdSWFlmWlM3QUJXcDFFblVlcERYMHNFblFQZGwx?=
 =?utf-8?B?dTFkY0JOMDQ1cmhtM01pUnpJV3dxaFk4bDEza1JqeXp0UzdxUEhxc3BqRXJM?=
 =?utf-8?B?ZW8rYkZXSFdWWUg5dFpuSzNxSndZVzFXNDcwUGhaZm9ZdGErOGgyVzExcWZL?=
 =?utf-8?B?am9lRXZ0SFBIaEdsUnlaRjBZenhMemg3RWhuZTlMRkFMdUd3V1lhR1lCdnF5?=
 =?utf-8?B?N28ycUUrejdQbEZwbTBJQlVpRWdsN1MrREI3Zk1MWkQrbk0xL3E0UTgveUFs?=
 =?utf-8?B?UDAvdjBEeHZXR3NncVFtRXp2aDB4N0UzTkt0M0xvS283RmZZSHpGZHZPVUNW?=
 =?utf-8?B?dEorMmZFeTRYQkR1Sys0RGJJR0ZRZ09FSjR4SkU4SE9zSy9QbFQ1elNrakZj?=
 =?utf-8?B?SDJ6VFo4R29WdXQ5TUJyaWg1OC9wVEp3TkcxTmJpZnVxdzhKUmxuQWQ5TytC?=
 =?utf-8?B?WGtaTHk2V29PdVNoZnV1Tm00YnpDc3B4TWVYVWlGeFBUMmsxdVdtR0kyZ0cw?=
 =?utf-8?B?dHEzZ1YwS3hPWEVvZTlmcStpU0p5S0gxdFg5Y1Rjcmc3a1RRcU5IVFNSSXp3?=
 =?utf-8?B?OWFpdjBweG5GcHpuYmxIRkJYQ05DcDBoYXRTdUR2anV0c0ZCUlVaUnExRDZu?=
 =?utf-8?B?NTJZRUtRNVAxbVVYQmRCWE1rTnJTUXBsOGZSbm9xMG8ydkcxVFhmMW1UblJj?=
 =?utf-8?B?QWh0cEl6OVVXSGx3UndmZjljTzNub3lVWVFBWEdzRHUvWmZpUFQ0aTdaLzUv?=
 =?utf-8?B?Wi9CaHoyejkxMGZSYjJqNlF0YnJyTkxtdGJWT3JsdElVTzFPaER6a1ROak5Z?=
 =?utf-8?B?ajcrMzJwS2tmWE1UdDMycngwUW8yblk4V3h0b1hUa0FueTlDaG1IRjZHYjhP?=
 =?utf-8?B?UzVnaklRSXNCVG55eDNXQ3ZJRU5nVEtReUhJM1JrYVBnZGhPdXExcmxHWmZl?=
 =?utf-8?B?am00cE9VengraGNzQTRsYmdBNUFnZ3hIQ21MK2tFaGliaW9aRldnUTBDRXNG?=
 =?utf-8?B?eCthd0lERUlSbnhWcUNyZE9SYjJvN05GL2pMbExUYVFINmh4RVNwcGpmbWV5?=
 =?utf-8?B?NWNJckV5TkszM2RnOGprakVyQ2dIYXBzYmdOb3dJK2NjL3JQOG5nMnExc0du?=
 =?utf-8?B?ckY1UmNoeTFFLyt4clBCcld6VzJmYjNYQ3o2RVprcjQwamdhd2IralcwRGRQ?=
 =?utf-8?B?VEhFVDlSMVJLbnFxcTMxbmR4M2ViZ1FhbGZPcVQ4MHhWelBIUVY2Wi9OekUx?=
 =?utf-8?B?Yk41T1FEZ3JuQTJpZ3E0bUNGWmo5b2VaUWkzWDdpUHkrSndtZzhPMnVacjZj?=
 =?utf-8?B?Z2hCQVdKVms4MGZHTFBVZUVpOWFZYzVpaDBVYzFVaUdTeXhNVVhjVVdYVTVH?=
 =?utf-8?B?Tm5MNSt2VGdKU0d4eitOdHFBYTB5VVROTDJ1dXJTeHd4aFcwVlZCTk01clE4?=
 =?utf-8?B?aWxKeDRBMGowaitpRkRTdkFzUWIvMld1bW5lUkVlV1Q1WVcxZHBKTGdDcjRI?=
 =?utf-8?B?QW84UXh3M2VTMzlMRU5TeW5Pa1A4SzU5UWFJOW9uQnFCSWhjbWo5cWtTVytt?=
 =?utf-8?B?ajdUVGxBRVVST3RuTzkwcnB0YXRpb2luNmgrMjhSV0NjRlRlcWFUNWt3QVc1?=
 =?utf-8?B?WC81TGlTNXkwN25BV0hpR3U5OWoyT1RKY0dWR0dEb1VOV1cwdHVSSDg2TUR1?=
 =?utf-8?B?M2F5SndRVlF5ZG41Z1dKK3d2WVUvc1B2cWZOTXZ2c0MzSTNYWUhQekk5c21K?=
 =?utf-8?Q?ZG4fcLwZdIdNS7FDs80TIdkKY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3265ecc-c263-4acb-5702-08de36352681
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 08:38:24.2222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STrHQYs/VJzjj63w76xJDNpPmVcLtjKUGSpHvcGfGinoDcutRi48bLCxoD/+Zp/j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059
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

On 12/5/25 22:49, Philip Yang wrote:
> For gfx version >= 9.4.3, bind MQD in GART with mtype RW to enable
> caching, to reduce queue switch latency.
> 
> Remove the redundant mtype definition in amdgpu_vm.h.
> 
> Call amdgpu_gmc_get_vm_pte with AMDGPU_VM_MTYPE_ to get ASIC specific
> mtype.
> 
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Looks reasonable to me, but I can't fully check the technical correctness without digging through tons of documents.

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 ++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 3 ---
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 0f83d140b6ae..4f8bc7f35cdc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -853,7 +853,12 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
>  	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
>  	uint64_t page_idx, pages_per_xcc;
>  	int i;
> -	uint64_t ctrl_flags = AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE_NC);
> +	uint64_t ctrl_flags = flags;
> +
> +	amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_NC, &ctrl_flags);
> +
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 3))
> +		amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_RW, &flags);
>  
>  	pages_per_xcc = total_pages;
>  	do_div(pages_per_xcc, num_xcc);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 139642eacdd0..e34c8f854b2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -100,9 +100,6 @@ struct amdgpu_bo_vm;
>  	(((uint64_t)(flags) & (~AMDGPU_PTE_MTYPE_VG10_MASK)) |	\
>  	  AMDGPU_PTE_MTYPE_VG10_SHIFT(mtype))
>  
> -#define AMDGPU_MTYPE_NC 0
> -#define AMDGPU_MTYPE_CC 2
> -
>  #define AMDGPU_PTE_DEFAULT_ATC  (AMDGPU_PTE_SYSTEM      \
>                                  | AMDGPU_PTE_SNOOPED    \
>                                  | AMDGPU_PTE_EXECUTABLE \

