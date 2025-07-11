Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E8EC83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 12:18:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7F5D10EA26;
	Fri, 11 Jul 2025 12:18:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hao7hPy+";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D2EA10EA26
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 12:18:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tA1NEz8uBe9Rm58UWbBj2UGEt1D8Ph/AqyJgTEAPYNRDyt/le0P8viEWy39OdCWnPIiEVX/Vvb+dHRGcReVfbPSVx2ur8fUOdLq22pus52tO12t2XWqwcJpYv5u04/x7w/mVv4LbkuSAmaIHR1x/4XsQUpfo5tj1HbOgSIn8LCRqHFuCHU2eXDpv2ALKpKx71hvhA/Wc3ei0HYMdlE4LS1JAOaAx7ashTXtwe1YFiUBAAnkKOvNVQa4SkS17cP8LMjXZU2RzkS9x5S6TJTvp4W85ToQMlgtr6fM+W5oqbIhcBDMimzwmQ1PfRHvAjCL8eTSLvkeNYJ9WqhQlPPErRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13sSNfkCl/UkIWacGk8WpbhsjYAYrhlScHqgrgowWJI=;
 b=VQSdTbaSJ+5TwJdx1Wi3GNd5nU8greVySWsZwQPWViuLKMGvFHrhRgxyqFz6BEtZElE+ZLlXTzrJV6x1/B7HUY3pFaCLrUJKAkAYzwWv7XYWLpuKuo816OiE6rtHwL9/tWSPlDT0ufHZGHM4s8nDjZxfQNspMihhxnf5EOaOC+BsS/Pd7vIGxw/kclJYJGSntVfaPdkRQvbFDWzYDTOmlMPip6y59mQyHzDF9glhVaP7HjEwZH9hNE19qe5V7ItT6Z2JOMfT/GjckxumsAQybtk4kC4QETX/SYYywsg//izz/Rp/CXSEHLh8o3pHDk2hjAQOPA8W1uv8Yp56LlRqLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13sSNfkCl/UkIWacGk8WpbhsjYAYrhlScHqgrgowWJI=;
 b=Hao7hPy+VmRhEjELF7lfC2hFYhU0+QlNDAzSUZHy9Sd9Pkox3mPiHsBR5ntUzmm5ahCMuFgYwy3vnbSLSh8eRU7egCBhnb6e7KHC3Gee5Tf349cJvekSKdqSv+t7XbMUvRngDlF/WBBOxh/19vW3mi3Fif2nPJtjhjfWit2f784=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9617.namprd12.prod.outlook.com (2603:10b6:408:2a0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 12:18:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 12:18:26 +0000
Message-ID: <300117a4-6a50-48ee-a030-dd8113aaa2f3@amd.com>
Date: Fri, 11 Jul 2025 14:18:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/11] drm/amdgpu: validate the queue va for resuming
 the queue
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250711093930.1411470-1-Prike.Liang@amd.com>
 <20250711093930.1411470-10-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250711093930.1411470-10-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0111.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::26) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: 693c3c11-4f33-4033-8701-08ddc07509bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVZiN1huNkZ3Mmo1V0JPcjVJWHg1Q3VKdStYMG5kTUswV2dBR09Fb2hOb1o2?=
 =?utf-8?B?bkdnOVpSTVRKNVhWRUw2Nk96ZWREQVQ5enlueGZMdFBUYUU0VlAveFdsWDFU?=
 =?utf-8?B?OGhhTURScEJEMjJVK0NEdUtWV3k1TmRVYUlEaktzVy9vK1VGWEovTEZrUlBx?=
 =?utf-8?B?MERlWHEzL1piOWdjbGRzbjR6NGZrU2FZSldzZWZESExQdnVDZVhRditHdDFN?=
 =?utf-8?B?TWtKWVlGZVFPOWRJb1UzNDREeTZoM3VHQW83TjRZVGU5bTRjdVVpaGZTeWNY?=
 =?utf-8?B?MlJtYU5KSWl0Tk5uNlRLRnovRStwZTFVMkhQRVorTFJYOVBSU3R6MFlkQXA1?=
 =?utf-8?B?eUpubC9idTdBN3pmYldPY1RLU2dnWThqUHNlemtEVUdlWjB0K0xiYXovTVVh?=
 =?utf-8?B?ejhFK3g3c1ladzc4ZHNDYkp0bW9OUlhla09tODVmYTlWbDFjbHpzRW5EZjBR?=
 =?utf-8?B?akE1SzcyZ1ZiMmtWMjJEVHZGbHZjR3B3dk1JcHF5RnAvd1lNVXcxNmlwSGFY?=
 =?utf-8?B?a2NQWU5PMmdCTGF3QXFnOUxQbktjMEkxTW1CREN1dDEvSWU5dVU5Q2dTL1pq?=
 =?utf-8?B?aWpsMVorQzZjTVhHaDROVE1JSjJQUGMzeStjVnpCMk9WV2hkS2VyRGsyYVV2?=
 =?utf-8?B?aVMwNnlSV3lMS0t0RllzZmdqOVp1TlZ5UTlvQ2ltWEJpTFBqNCtUVG5TS1g0?=
 =?utf-8?B?bHJoM2t4VGNhdTNkdEVUc0VrZnNQVWZ3RyszSXh1STR5a0lGNzNGSjh0Rjd3?=
 =?utf-8?B?RGtqaEpTb3FjMnVDNFZ1dnMzcGUxSGFSd3JBMC9FNWdla1FLZDdpRkYzWkRx?=
 =?utf-8?B?bndPTG9FVWtabkdIZXQ2SEZ2VUlYWWJHNHlYeHpROERhVW1BVUF6bUZyZzVH?=
 =?utf-8?B?OFRGTjUwM1pHeG9wQVRLWm1mYWRjdlZrRGNBcTVvOHBneVRwQkxzOURaZlU3?=
 =?utf-8?B?VU5pZU1mR1I4T1JwVHJFN1V0MDlBWDM0VlJFaEU4Z2dzWDlyTGh4WlZETEJk?=
 =?utf-8?B?UzlDSjUzWXY4SU5GTjFSYk8vZ05xUFZYd0JHb0Uvbmx2Z3BraWh5RUxlS1JJ?=
 =?utf-8?B?YWFXcnRya01Bb1NTcm51MEdmVStYY1BkeUlzOUtyNE95YW4vbDMwdVplY2pV?=
 =?utf-8?B?Zmt6dWhOWVROdWFZcU0ybmhnZDJQVXZ0dlZONzQ4K2cxV2RZYzRKVXljSE1h?=
 =?utf-8?B?WTlod1c1aFpxVjNuMlc5NjFsQ3gxdXVQTUorSkJjcWVQb0lta3VldHZGMTRy?=
 =?utf-8?B?ZWFzSW84TEpScWV0NC9pMnBaaWNhU0REa1hBVE1uYWk3S3hpdlVwZjlnOHNj?=
 =?utf-8?B?L21XZFdhS1VZV1ZkN1RDMGxEaVRTYXptMzJQN29ybVRORFd4ZjF3RUxKZG9T?=
 =?utf-8?B?VVNDdDBscDNqUzhmc29YQ2JqNWRBMmpESEYyZk1RSEEzeEgxNVo4U1FCdjJi?=
 =?utf-8?B?eXhCMmptRTJMdmtZMXBZM0ZocTRnSXd5YUl1NmZFOUFrQjVrYVQyOW9GVU1n?=
 =?utf-8?B?L2J2MkJSYk1wM2IxRTBwcE56VUNrZlViYkw0YW1LN2U3NisxR052MDQvOXh2?=
 =?utf-8?B?QzdsVTFaWjN0VEtVWFk3NmppcW1sNzFJU2JFZVRqMWFJU2xQeWo5UzBGcnl4?=
 =?utf-8?B?c1EwLzdJUEIyd0duOCtidmJEZDBnQ0oraW5SY2FaNnpVdkJ4MjdQeitscmQv?=
 =?utf-8?B?cnozZkdxMENOdzBDc3oyV0ZhenBsRW40aHhFVWdDVDdiUDUwYjV0MHI2L3Zr?=
 =?utf-8?B?YUhoZk9zOUI0T1dXYVBNWW1nTTl0eWNacHNtUXRHVVBLVTdkR3VBcElFeFJs?=
 =?utf-8?B?M2tpSVdyMEp3Q044emZucUVTSU5leUJkT0t0a0crMUZNcitiNkIxRHJJTlpE?=
 =?utf-8?B?Y3haWGdmQm9KNFhTTWxrNkEvNkpnYW8wakpMYVZDa1ptbkxLam1nSXROdXV3?=
 =?utf-8?Q?oEBaOBnZiN0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFoyK3o2RTF5TUsrS2RjaVdLTEJBc0FzOGduTlBaVTZ1Tk1uQ3pKaWhjSXpr?=
 =?utf-8?B?MkprWHBqaThGcTlPd0VPcHA4cEtFZDBXVytINkpRbktMdFdnend0c3lSVU4w?=
 =?utf-8?B?VC9IOFZjbkdBSWI4dFdFdEFuTHg2VmpvYmRhR2NSM2JDUEx3dmxENDRlbUxD?=
 =?utf-8?B?TGZhQWhCbFRuNDZGNzJRektScVVxelB0ZXc3Z1hrL1phL0h0a2JwOWRTd0pN?=
 =?utf-8?B?aUJlMHhhK1J0NjA0NithTWpBOHpOQS91aWt5dEZCME1OQWVFckRWTTNyczQy?=
 =?utf-8?B?RXFlV2hEWUZuVTBFeENtSXlBTlhrZUp3a1owa1A1MlJHWllsZURFRXJrdDhy?=
 =?utf-8?B?dUExWHFNcHJteFFYcWZKZHFjVjJsZ3VJNTMxbEdvU053MEhQRFF3WVA3N2lq?=
 =?utf-8?B?WHZDVzdHWFByQ2hrM2VqTkVwTDJiSFJNZXp3bjJTVlNVVlpHNlFVSVhUalJY?=
 =?utf-8?B?ZEVsU2JhM0RCenFhVmFoL3pBRzNVL3VBdC8yVEN0bFRidENvWEl5VGVYSEFq?=
 =?utf-8?B?UEUvZ0laVjVCdk0veXNuNEI1aW5BZWFoR0F1VFF4NGN3L3hBOWpCWWRmTTl1?=
 =?utf-8?B?NGsrNzdrTjZVRmdXbEF1clh5T3dBeFI4WmtwWlhuTVNoK0JaaWdXVHdLejZN?=
 =?utf-8?B?cTg1MXdiQVV0ZC9HV3VOV29SMXZVMG9KcVpRZ1Rtb2xWTmRDVmV4VVRZa1BV?=
 =?utf-8?B?bmVLWS9qNFBVa0E5UEFuOFVxZ1NyYUdjU2hQajRUQVJla3BkOUl2M1lZVkg1?=
 =?utf-8?B?RjBtVGxaZlp2R2ljbEh1MDVscXpLczBHYjJON1lxRW94T090OGtLVmxtd2li?=
 =?utf-8?B?RWk5UFBZQ2ZhUUFlOFp1VytnOVdncS8wVWFNcW82U3oxditDUXJFYXpFOVFp?=
 =?utf-8?B?Sjc3TUxyTG8wWDFkS2RFVnBRK3MrWnpzZDVKand3SzdidktiMERtWnY4a0tp?=
 =?utf-8?B?bmJrVGxjVWFQZEV2MTdPL05LYXJYci9CbTdQRDJlWmpWMm5RS0NiTy9LL2Yx?=
 =?utf-8?B?dnRhby9SNHpOVnpYQ2FxOFVla005ZmFBaHBWVDR6N1BrUENkVXBFdnJQcnQ4?=
 =?utf-8?B?a3NydTArZmVWZU5YVHZzTmo5K3VFVldvQzBlM1l3NDNlekZqT3pQc3JJRkgr?=
 =?utf-8?B?YzZCcnNQOWxQaTc2VnJFYnd5S0F2L21ZcTR4Skx6R3RZRk0yVjVBQm85UTBv?=
 =?utf-8?B?ZC9zNkozMWF5NWJYZW15WGVFNGRmWmFMQ0NlWVdvOENVdkxIY0JUQ2lnT3Nq?=
 =?utf-8?B?TU5FaVNNVDJDUTNmWUdCRi9tTjBFODN4R2hvb0xUQjd2MnMzd0RIbDZqaFEz?=
 =?utf-8?B?SEc0RjdIV0htRUZSOU1KN1NtcWw2eDc5djhCUHJvRlZBQnRsTkNXOUZoNWsz?=
 =?utf-8?B?NnZkcVVzVHhMd3pCbVd2MTFCWGZYUmJPK0daVG9CV2xheGpCNUVaOHRuTUJF?=
 =?utf-8?B?UDU1RU5QcmRrZzBZOVlzMjBMck5qUEhndGVnWGFrZ1NZZ1VGV0VKZU1SSjdu?=
 =?utf-8?B?QVJVSTJTMUx0TGxlOHNpaDMwYUVpMm93MjRxWmlSVFhLUlNWM1JTSkttZ0pG?=
 =?utf-8?B?VVZHVmlnT1RLSGN3R05SSCtJckpzUkNRSDl3czFyWWxHbC80Vk8vc1lVMjBH?=
 =?utf-8?B?WWVQSFhueGpNTmlaNUdSOTNPNFQrcHozNklVU2JyMEI0cmZrNnJwVWVYUkFs?=
 =?utf-8?B?bWZxTnF1SEpaeHRWSUpyd0drVVNtTzJhMVhWUnJVMjBtdEJMM25ZM1VJeXR2?=
 =?utf-8?B?S3VITHI0YVNJTDZWTWxmaTd3amtnYUFld1gxVmxCd211M1JLcW5pbEkyb0Jx?=
 =?utf-8?B?Nm13MTRzL0lGN1ByV082NGcvRGM1QlVkNVRpd2FmaHR5OXNLS2x3U1Fyc2lG?=
 =?utf-8?B?Um9ubGRSU0JrUHZnelJSb0s2NGpUczIvVlFqalIyS0c2NUx4cEdwQ2hlSXU0?=
 =?utf-8?B?SUpmUzZkTERIMzloNWlob2RLNmxkcWdySTk2UUdGeVpyZUM3dXJYRlJzYk40?=
 =?utf-8?B?eVpyUjRKZHdRbE9WQUQ2MkxCRllzQThvNkZlbGRMcU9icit3empldE5tYlgz?=
 =?utf-8?B?VnJNSGFGRTVHVkg3YXNoODY5S0h0R1o0dTA4MUk4TjhVdE1jUno2bldFRHJy?=
 =?utf-8?Q?/TqW0qLsR5tmovVqDpWVVrzK3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 693c3c11-4f33-4033-8701-08ddc07509bd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 12:18:26.5534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/mwmI7dZ1j178H5FVLolsINOZ5ufTgRhI+ut64hLvfp2sk7JUasnaYXThE0bBfs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9617
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

On 11.07.25 11:39, Prike Liang wrote:
> It requires validating the userq VA whether is mapped before
> trying to resume the queue.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Yeah that looks sane to me. Patch is Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index bfe7b229011e..54f44fc834fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -777,11 +777,18 @@ static int
>  amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>  {
>  	struct amdgpu_usermode_queue *queue;
> +	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>  	int queue_id;
>  	int ret = 0, r;
>  
>  	/* Resume all the queues for this process */
>  	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> +
> +		if (!amdgpu_userq_buffer_vas_mapped(&fpriv->vm, queue)) {
> +			drm_file_err(uq_mgr->file, "trying restore queue without va mappping\n");
> +			continue;
> +		}
> +
>  		r = amdgpu_userq_map_helper(uq_mgr, queue);
>  		if (r)
>  			ret = r;

