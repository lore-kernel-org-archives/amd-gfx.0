Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868D8C282EC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 01:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A48510E882;
	Thu,  6 Mar 2025 01:06:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1/XOuON8";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 758E310E882
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 01:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKVy/g4Nq4hLNzUHOLDaYAPgJZs9/lDdRMgLuiApLRp/hV1z/SnUhlrbjGsYA/wkWZt+CyMmad9xqiekH9PaBatJ1q5uMc0eWBvJZuoomWzDDRZzJrq+8UXmhpTVOpT3MDwXVTDiXmZCpyHWXvsg+Sn7GhsNwd3mKVwJRHZ1I1xtOB9YzaPUny8Tppdxxqp6ad7e6D4Wr5K9QQaEnZ0mICVt9fh6NpUMZf8y+vdvG5RRDdq46IVviTxyg0vigsRy65Sh/7sLBLKHJPMKdg7+xoB49rm8FNl10G8GepgUSR+tK1Sn+bTtg552lsqb084MN0OWQFJ6FaXY7grnTir9PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibnuTiC39fgwQP0++OIuGGVX0mIlqxyxCYgkPfJfXRM=;
 b=tt/VahLwgBnsksI3NLZqkXHRgC7hjiBauBuF3YRdzB75wDs7CNF43rzE4axRNmv+hMJ3LNgK+NaPYwqk3KvYALq5rrCiL1Xy4CtFU6xesnxA1xDKelBNNXbnIdeKnCLxJ7pn0dciiEXb+ZMWh8aB4Ok258OD2LDbpadvOjHk6bhr4K80Y+zoDFFCWCj/ArnXE/0uYX/dCIeHcSyGvf1fLXyDjQDUL9wkz7DW8A5wvyvoCOLVNxUYHLv9tQD092+lSSv/hyndy6RpVq66B26xlYoFApXUMkXfwD/pT3VwBJXcEN5jmiezqIwhy7UsMg46kRxQr/uBTivvBL9k1Ka3Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibnuTiC39fgwQP0++OIuGGVX0mIlqxyxCYgkPfJfXRM=;
 b=1/XOuON80DjVBrbG+ujo/w0qls4zZ3nZeGiKzOhbQ56iSm79i57ZndODVK4dNqVCQ8M7zoyjPZ1wwnP9zblFnb72ildoEhPM9CTTMBh9rQffK5E/zZ/dgW4dG6slTsORC3JYRX/DpPqQtxaqL4uj28gSVFwFTZzwHFM8luqCRps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 01:06:05 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 01:06:05 +0000
Message-ID: <eb414965-542c-4264-8524-087fe52bddef@amd.com>
Date: Wed, 5 Mar 2025 20:06:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] drm/amdgpu/gfx: add generic handling for disable_kq
To: amd-gfx@lists.freedesktop.org,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250305204721.1213836-1-alexander.deucher@amd.com>
 <20250305204721.1213836-4-alexander.deucher@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250305204721.1213836-4-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::28) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b31384-dd60-49e9-3883-08dd5c4b11fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cm43ejBXSUdsaEVSSUZJanQxL3BTRUJYOFFCU3NHMUI0RHM3dDJsdlZJQk14?=
 =?utf-8?B?L1JXTU5tc3dpUGlTY0hlbmtVUzdvbCt3OFJkNjRBK3pzaEFqQkJiOHRrelpt?=
 =?utf-8?B?OWZnbFNMa2FKbVVXM1RZMC9YZHAzVzczVm5Mbi8wN0pCOWV5bGNBM1h5R1gv?=
 =?utf-8?B?TXIwMG1uekg4eStuZFlwWUJFNWxOalAvYk5Kai9kVXcxMi83T3BEakxhd0pJ?=
 =?utf-8?B?bnhBdUxuNDNVSURsa0ZicUxvTzhjays1SCtrL3J1SGlkaGoxaGlmejVjY2d6?=
 =?utf-8?B?Z0ZwTHFtYnp5YzdOS1V4eTVka1pNNE5HcHlyNXUxSnZaVG5ubTBHOCtRcUNS?=
 =?utf-8?B?YUZWM0txeE5JYU5CNC8xVVR3Ykh6V0FxU2M1K3RHT0RNQk9NTVhEc2N6Y2Zx?=
 =?utf-8?B?ZTJHNDhnSWxEeWo1YmN0RDczQWxzUlVpRGQrSVdUYVpJYlA0MUhvWXduQzMz?=
 =?utf-8?B?NUh6bnpqQmw4VTNOMmszbWtmQllzYTJUcXlHb1YwSFphTDhPVS9POC9YdjJm?=
 =?utf-8?B?SUROU1pHeDNiMm1ReXJXRURuNHJUTE1wUFJvVW53WkF2MTdzK2JsVVdoTS9O?=
 =?utf-8?B?NElOcTN5aXI5eFBGQlpaajZTOXJYbksxYWJCekRqTlJSVUIzQkJVb1ZRUGZ0?=
 =?utf-8?B?dmZWbmVnQ2VNVC9yMWJpUThjcXU1SFpFY3Z6clJSNDBFN3MyZUF1a1ppdkxr?=
 =?utf-8?B?dXRRMG5zajk1YUtrNDZhUnJTYldWMEVWbVEwN1hzWDJOWkMyV2t1S255bXA3?=
 =?utf-8?B?R0hKZDJjT1pKTXJtbEhIT2tSS2Uzc0d3RUlZQmpTd0c0d05YRzhwN3dLa2th?=
 =?utf-8?B?YnV6dlUwcytQYnJmS2xlKzJiUVg1Q2xVNUMyL1NKci9QMy9mdFIyY3doMGZR?=
 =?utf-8?B?dGs0VWVjbkZRaWM3U2ZtM0dySEJScEdENWtHclZNWWZMZkZQQWhSUHAzczRH?=
 =?utf-8?B?eUFaK0JQN3dpMGpjb1p1ZlZVUDNsb3JKb1dRdVorenp3UmVYUFlHNTljR3Zw?=
 =?utf-8?B?RGlzUGFDTkFGZjJVdmE3QlptajdFMDhMVWc5THNmSXVZelpNRm04VW1pWVZP?=
 =?utf-8?B?TlZEbjZlM1kxWjM3VzJkdExTcHlHYXljY09rTzJYczlHZGlIVkhITDFVR21k?=
 =?utf-8?B?ZmlnTG0vQzVOU1FHODhZcWZuYmF6ZkYvQzhDczdFNmViZmZCbVJMMVN2cm5N?=
 =?utf-8?B?dXM5L3l1aVRRRzI5eTJlRjdyM0VmM04vQXFFZ1NpVVFuT05KM3ZuU0VOYUNY?=
 =?utf-8?B?a1UyUjNiaWUxVlU5dzYzQjZnWTcwL2U3NFBuTDhVT2NMWThjWnlLZ3p5Ujht?=
 =?utf-8?B?UW1qMG4yaU8ycWQyblB1bHgwekxsejZNcnIxM2FqWGp0OUVWRGpJaWcreFAz?=
 =?utf-8?B?V0szQ3JkS29lWXM2Y3ZmTmQ2TTdCUEZ4WVlMWlk4M1BrYUY0YzJGNDI4YWw0?=
 =?utf-8?B?R21nWHh5V3lBTkNPZG95UzZlYkVQMTlKb09BcStWaTBDSnkvYjQwejBZWXVo?=
 =?utf-8?B?aVNnYlphcEpLS09rSHl3NmhxSnJEeDI5V1FSTnJsRWtabU5DVGcvTGZVZ090?=
 =?utf-8?B?MHliMjZHdHNsTld4bzNkRWdQOW1FNFJsSXZwUW5xL0RYbGQ2Zmc5a05TcU9D?=
 =?utf-8?B?NjRVZnhDRlErME5SS3g0UTNYK3VKcmpGVmJvaDF1cm9LUzJWT2g4YkRRQlhY?=
 =?utf-8?B?OW5uTjgxdW41dVk5ekZJVE1DbXcwS0l0a1FKUVcvdjNycU4rdTNYR05odmlB?=
 =?utf-8?B?Njk3RlJZMFJMVWZESEJLMGtOcEtsMzk5NndOM0x1ZVQ5dGlVRmw4NmFzSWcx?=
 =?utf-8?B?UURvVzRoTU5VbDNXWkQ0bVlDbGlnaUwxaDVoVkhvNjhkaDZiS0NFMmw0NGdV?=
 =?utf-8?Q?1JV0E9stRf3BO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3FpNmY2a3JoNGNXT09vOHYwVUFqV2VPVjZENXRWWFgwaFI0QVJuOGJlaGxY?=
 =?utf-8?B?OUhTRjcxZXNqZkpydEdHK1ptTFlWT1RRNFJGenhlWmREM0U0eENRYUNqNE9F?=
 =?utf-8?B?R0tvQ05nNkRtN2hQN295R0pyd3NlQWx2WjIxQ0J4Snhid1VlaHpFYXJkaVBu?=
 =?utf-8?B?eDFaVWdnWU1iNUxXeFY5Z2o4YzZhVXVCTnBmMS9SdW8vR0loZWpVV3pFQklL?=
 =?utf-8?B?aXJ6UnJ6OVJJMmNIeUNkN0I4SHRIV2N5bURyQVFGRlM0ajhLem5xUS9YdS93?=
 =?utf-8?B?L3hLVTJhZ0l5K3hmQjl0bER5eWFRNWQwWnlVOW9pYittSHMzWmU1SExCSUw1?=
 =?utf-8?B?dC9lTXQ5c2tDR0JNM3FUbVU5TGMrYmpmc24xMHdHQ0tGSDVTa0N5dm1lOE52?=
 =?utf-8?B?eC81N3JIZEtmcm4wVFpkZy9BY3ZyMmE5bVVVdVIzU0dtRkR1Zms4dktGSVJy?=
 =?utf-8?B?Ym5VYjhSL29JVW1ZT2pBY05ha0h5WWtRRDRmQVN3Vmc2ek5JVWR3bnFiUi9F?=
 =?utf-8?B?SEtmaGFXTDVXc2xiVjNFZk9Gc0pUQndEZGNaYmhyVmViNWltTEJZcHZoQ25n?=
 =?utf-8?B?MzVDZlhna2Rnb012elkvT1dvRnJvRFp3a3NqdGpkUXJ4eWROcmRHNVFYUVp1?=
 =?utf-8?B?YTgvdlhVVy93eC9NM2tyd1JTUW0wZEZ0U1NLQXF1UTB2dzIvRE9JL0Y0UW9u?=
 =?utf-8?B?SGdaYlNlY0hCU1lyc1kyZXNudEJXTnBDTXRwMlF4c2lsQm9FV3c0b2NFQkpm?=
 =?utf-8?B?b0U3YVVEUExnQ2dOVFpnRzlLeFRabXlxZUZBalhqdWtnVkV5clNmdTFLOTVz?=
 =?utf-8?B?THJsVGxZbUl6NkpiTmFBcFVPaDlMUENiVGlIVmFCZ244VXpvdWVOTDdiODBT?=
 =?utf-8?B?MHUzRnVXdXprNmhrK1h2RUp5N1pGK0tSMENyYldDamVsenplZ3FnNFFxZ0xG?=
 =?utf-8?B?ek50NjQvYzVrdXg4Ny8vYWh0TVh5dDMrMnFoRXZiY05rR2dFTU90RGpjZ2Jm?=
 =?utf-8?B?OS95eWRsQU44WWtzYU9HQjJJVHRkRDZhQk43YUVZOGt3SVJMTmtKMDQyQkly?=
 =?utf-8?B?OGxzOVhIUU9pSllDbU9xV3ZtdHduZUhpT3FXU2lPMlBSKzgxQ2ZQMHdBaHpw?=
 =?utf-8?B?UGtjUG9hSEdPWVRMclMwTUxqVC8wMGs0U0lyem96bDlUcTNaQ0ZVd21zY2pL?=
 =?utf-8?B?VXFtNTF0WkJlbXlqcitnSnN0dUpzZWNVQTlXcU8xTjNmSFNEWnBJT0plYnpn?=
 =?utf-8?B?ZDN1L2kzWWFudGRRM3dBdEtDYTAwRXdwZDAvUjJ1VnpnSUZ1dUcvSWNaMlpH?=
 =?utf-8?B?WTRIdjZnWW9aTkNhQkQ5UnFsU05PS0JtRXdPalRYSnN0RjBaUzIzTC9iOUcv?=
 =?utf-8?B?VXlvWkZ0L2RrVEpaUEF0WElXdUZMV2NDRmdhczZZVDJ1cXV3QVlZczUyWkhr?=
 =?utf-8?B?eVBoOXRMcVlXVmliaXRsYUFWTCtOYjVIeWZJK1VCWkF0WUpBZCtzOS9KcW50?=
 =?utf-8?B?WXpocnV5dHZUR091UlI4V21uRHJhOUpDaHVWdHBEOXlVTktSREMwWlZSdmpt?=
 =?utf-8?B?VVJuZE5CQnBJOW5xSENMTmF1WHNmcjlyMzRiVUxqQ2YweDYybGZHMXdvTmRy?=
 =?utf-8?B?a0o5cC8yM2d2a2FxZWJsWlBTRjBndXBIMnJmc05ER0hYWVM5KzV6bVJwZ2pv?=
 =?utf-8?B?R2NoYW1ocGd1dkIxRGhjeEJHcEt0YndmM1YzMUpReUdTZVlMUUprMDRBTnlO?=
 =?utf-8?B?UFRBS0trdHpKK2NYaGhOV3NERlMvYTJ1VmVhb1cwOElVN3NaSUx6eWdkalBZ?=
 =?utf-8?B?UEh5Y0Fwdy96TG5CbXcxUFgxL1R4QWdaaTdpTFQvTnBITFZaYlI0NWhIUE5W?=
 =?utf-8?B?WXFQWlVjbVNnbEtiRUZpQVJ1MjZCQUZrQ2J4dWE4cTdhdDBEQjhwVHVKTCtE?=
 =?utf-8?B?cVFRSCtmSTBqSFdTTG1mK3ZkWWo5dktadi8yZGNIODNuRytnKzhpQ2RNSEtJ?=
 =?utf-8?B?eVlpaTFRT2d2Y250cVJKL3NkSTMxeXhBTzZTVTRlMk5nTVNMamEreUNWWWRI?=
 =?utf-8?B?ckJHT09hYmxCdVI3dVR5ZGppbC93TEpRMkJkOFN0RUxBYU4vd3diUUs1TG1V?=
 =?utf-8?Q?DNLikBt1KjO+KVE0nzZyhd0JQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b31384-dd60-49e9-3883-08dd5c4b11fc
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 01:06:05.2595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8lWi8iNuED4H6Ypc1LVvgc5V5hi66wjzIpLgm5goOxExSlcR0L4oaaL9DkQQXyYEnr5ZfwK4t2LnSuPVgrr0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756
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


On 2025-03-05 15:47, Alex Deucher wrote:
> Add proper checks for disable_kq functionality in
> gfx helper functions.  Add special logic for families
> that require the clear state setup.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 92 +++++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
>   2 files changed, 67 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index a194bf3347cbc..af3f8b62f6fd5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -371,6 +371,18 @@ int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +static bool amdgpu_gfx_disable_gfx_kq(struct amdgpu_device *adev)
> +{
> +	if (adev->gfx.disable_kq) {
> +		/* GFX11 needs the GFX ring for clear buffer */
> +		if (amdgpu_ip_version(adev, GC_HWIP, 0) <= IP_VERSION(12, 0, 0))

Should this be < instead of <=?

Regards,
   Felix

> +			return false;
> +		else
> +			return true;
> +	}
> +	return false;
> +}
> +
>   /* create MQD for each compute/gfx queue */
>   int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
>   			   unsigned int mqd_size, int xcc_id)
> @@ -379,6 +391,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
>   	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
>   	struct amdgpu_ring *ring = &kiq->ring;
>   	u32 domain = AMDGPU_GEM_DOMAIN_GTT;
> +	bool disable_kq_gfx = amdgpu_gfx_disable_gfx_kq(adev);
>   
>   #if !defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
>   	/* Only enable on gfx10 and 11 for now to avoid changing behavior on older chips */
> @@ -413,7 +426,8 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
>   		}
>   	}
>   
> -	if (adev->asic_type >= CHIP_NAVI10 && amdgpu_async_gfx_ring) {
> +	if (adev->asic_type >= CHIP_NAVI10 && amdgpu_async_gfx_ring &&
> +	    !disable_kq_gfx) {
>   		/* create MQD for each KGQ */
>   		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
>   			ring = &adev->gfx.gfx_ring[i];
> @@ -437,25 +451,28 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
>   		}
>   	}
>   
> -	/* create MQD for each KCQ */
> -	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -		j = i + xcc_id * adev->gfx.num_compute_rings;
> -		ring = &adev->gfx.compute_ring[j];
> -		if (!ring->mqd_obj) {
> -			r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
> -						    domain, &ring->mqd_obj,
> -						    &ring->mqd_gpu_addr, &ring->mqd_ptr);
> -			if (r) {
> -				dev_warn(adev->dev, "failed to create ring mqd bo (%d)", r);
> -				return r;
> -			}
> +	if (!adev->gfx.disable_kq) {

Maybe just set adev->gfx.num_compute_rings to 0 somewhere, then you 
don't need this condition.


> +		/* create MQD for each KCQ */
> +		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +			j = i + xcc_id * adev->gfx.num_compute_rings;
> +			ring = &adev->gfx.compute_ring[j];
> +			if (!ring->mqd_obj) {
> +				r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
> +							    domain, &ring->mqd_obj,
> +							    &ring->mqd_gpu_addr, &ring->mqd_ptr);
> +				if (r) {
> +					dev_warn(adev->dev, "failed to create ring mqd bo (%d)", r);
> +					return r;
> +				}
>   
> -			ring->mqd_size = mqd_size;
> -			/* prepare MQD backup */
> -			adev->gfx.mec.mqd_backup[j] = kzalloc(mqd_size, GFP_KERNEL);
> -			if (!adev->gfx.mec.mqd_backup[j]) {
> -				dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
> -				return -ENOMEM;
> +				ring->mqd_size = mqd_size;
> +				/* prepare MQD backup */
> +				adev->gfx.mec.mqd_backup[j] = kzalloc(mqd_size, GFP_KERNEL);
> +				if (!adev->gfx.mec.mqd_backup[j]) {
> +					dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n",
> +						 ring->name);
> +					return -ENOMEM;
> +				}
>   			}
>   		}
>   	}
> @@ -468,8 +485,10 @@ void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev, int xcc_id)
>   	struct amdgpu_ring *ring = NULL;
>   	int i, j;
>   	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
> +	bool disable_kq_gfx = amdgpu_gfx_disable_gfx_kq(adev);
>   
> -	if (adev->asic_type >= CHIP_NAVI10 && amdgpu_async_gfx_ring) {
> +	if (adev->asic_type >= CHIP_NAVI10 && amdgpu_async_gfx_ring &&
> +	    !disable_kq_gfx) {
>   		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
>   			ring = &adev->gfx.gfx_ring[i];
>   			kfree(adev->gfx.me.mqd_backup[i]);
> @@ -479,13 +498,15 @@ void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev, int xcc_id)
>   		}
>   	}
>   
> -	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -		j = i + xcc_id * adev->gfx.num_compute_rings;
> -		ring = &adev->gfx.compute_ring[j];
> -		kfree(adev->gfx.mec.mqd_backup[j]);
> -		amdgpu_bo_free_kernel(&ring->mqd_obj,
> -				      &ring->mqd_gpu_addr,
> -				      &ring->mqd_ptr);
> +	if (!adev->gfx.disable_kq) {

Same as above.


> +		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +			j = i + xcc_id * adev->gfx.num_compute_rings;
> +			ring = &adev->gfx.compute_ring[j];
> +			kfree(adev->gfx.mec.mqd_backup[j]);
> +			amdgpu_bo_free_kernel(&ring->mqd_obj,
> +					      &ring->mqd_gpu_addr,
> +					      &ring->mqd_ptr);
> +		}
>   	}
>   
>   	ring = &kiq->ring;
> @@ -502,6 +523,9 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
>   	int i, r = 0;
>   	int j;
>   
> +	if (adev->gfx.disable_kq)

Same as above.


> +		return 0;
> +
>   	if (adev->enable_mes) {
>   		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
>   			j = i + xcc_id * adev->gfx.num_compute_rings;
> @@ -547,11 +571,15 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
>   
>   int amdgpu_gfx_disable_kgq(struct amdgpu_device *adev, int xcc_id)
>   {
> +	bool disable_kq_gfx = amdgpu_gfx_disable_gfx_kq(adev);
>   	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
>   	struct amdgpu_ring *kiq_ring = &kiq->ring;
>   	int i, r = 0;
>   	int j;
>   
> +	if (disable_kq_gfx)
> +		return 0;
Maybe just set adev->gfx.num_gfx_rings to 0 somewhere, then you don't 
need this condition.

Regards,
   Felix


> +
>   	if (adev->enable_mes) {
>   		if (amdgpu_gfx_is_master_xcc(adev, xcc_id)) {
>   			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> @@ -657,6 +685,9 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
>   	uint64_t queue_mask = 0;
>   	int r, i, j;
>   
> +	if (adev->gfx.disable_kq)
> +		return 0;
> +
>   	if (adev->mes.enable_legacy_queue_map)
>   		return amdgpu_gfx_mes_enable_kcq(adev, xcc_id);
>   
> @@ -716,10 +747,14 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
>   
>   int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
>   {
> +	bool disable_kq_gfx = amdgpu_gfx_disable_gfx_kq(adev);
>   	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
>   	struct amdgpu_ring *kiq_ring = &kiq->ring;
>   	int r, i, j;
>   
> +	if (disable_kq_gfx)
> +		return 0;
> +
>   	if (!kiq->pmf || !kiq->pmf->kiq_map_queues)
>   		return -EINVAL;
>   
> @@ -1544,6 +1579,9 @@ static ssize_t amdgpu_gfx_set_run_cleaner_shader(struct device *dev,
>   	if (adev->in_suspend && !adev->in_runpm)
>   		return -EPERM;
>   
> +	if (adev->gfx.disable_kq)
> +		return -ENOTSUPP;
> +
>   	ret = kstrtol(buf, 0, &value);
>   
>   	if (ret)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index ddf4533614bac..8fa68a4ac34f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -483,6 +483,8 @@ struct amdgpu_gfx {
>   
>   	atomic_t			total_submission_cnt;
>   	struct delayed_work		idle_work;
> +
> +	bool				disable_kq;
>   };
>   
>   struct amdgpu_gfx_ras_reg_entry {
