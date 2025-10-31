Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A33CCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 20:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC3EE10E30B;
	Fri, 31 Oct 2025 20:56:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NEAkgU8g";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012066.outbound.protection.outlook.com [52.101.48.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0ED910E32F
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 20:56:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qot2LsDx/drmbeZC7JJeDV07fp8BQpfoJdHHz3KnM7hcwjd8UbeG3wVGqykAIeGASZ2kU+T4/xIJKgYKCcm2XyComO32I8MRMruXJoq4CCH8ducbDdyuffMy17Z2SSFL9jH3z3vOjQyPtpbQ3rP7tdx17QoDqmTy7pteilHLdclin+jnIkGCI3maKCs6WCTIiIGsRkxP8a1+BYnNTa87e1t0Dajp4frWFYylBGi1SiWVay3AABHYejg6ojl8K3+vpwGQozTvOlITrcFWDc56WnvzjUqaFfX1YqFuhBbog72P5Zyly2MqYgBp4XkN2/F+sZ5LuH9pNsbslqLGoIp+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xk7j0D6RCMuBbkxd92pfQh6gersZid7qK+8mXGOENjo=;
 b=jxZ1hoehqJVS5X+NIFWvgPyEb9kmVTTfdAKEq5ZgdQDEcgUghQ6TAVV3AnjXb5zBxZ3XcUt/PKYIcmkzNK1LqGsTG0NDKwGIO9HlsEF4TRIHGgV//PYwr2Rx74eZGI3ctOSyn6JWxiu9zoTjeX6Nv9Y3EhgXU1ngXWackGgFQNieiNghYY+4QgaupT75YKScKAhLt/4jxs6RgaWQm9hFBmg8NSIicZ5cvbUjT0oI3wnVSKZLBdhJh9dSKH4K8bqfiE2jiZULXAK67liyKF8StNrU2OtPmMuNCInBhNZFnwgjMjpJ7sgP6oL7ZRVvm8GcYdSujtdvx0FWpM8J/gQKoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk7j0D6RCMuBbkxd92pfQh6gersZid7qK+8mXGOENjo=;
 b=NEAkgU8gQ/DD7vXOy+WUo9OIbs87Nj4BHkLk1jUsRTHEL0tPKhyUpWXmHaXMJmDWDrVF/SWzJ8+mgKkEZfVaw9Ozoyc/jr/9qMPxFwlRmJ4GxYNNJACwrK7bK5Qyv0ZDXP2TgiBehED6uDN2EaizUSGIfbYl7o0gdTTZbV/Vclc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 20:56:39 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 20:56:39 +0000
Message-ID: <c227267c-9daa-4587-834e-b44747d1331f@amd.com>
Date: Fri, 31 Oct 2025 16:56:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: remove pasid under kfd sysfs folders
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20251031033228.2230-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20251031033228.2230-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0124.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 28269843-f27b-45d0-d930-08de18bffc78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnFkTVNTbFdWN3FoSGU2RTVNOGtnT2MzdDErUzlMSG5XMWsvbEJoTTVxdG5R?=
 =?utf-8?B?WVdqbzB1SXRTUEViSk9EN3B2d0hXRmtNamVFOG1pUC85aks0SlRyNFk1WWhP?=
 =?utf-8?B?MW1UeEo0dENRSmtPS3pkdVhMbTFrWmVlWHBpc2lVSmtmVlFJOFl3d2hzTnQ2?=
 =?utf-8?B?MFpxc01ORnNOWEpaUGpaaE1TSit6U1VEdmZTLzMyNDhFMnlCOVdnL1FtYytO?=
 =?utf-8?B?VFF1emRubWR5Wkg3TGlhenRFaUt0NnNvanI0T3VWK1puVUJDWmRaU1I0WlZj?=
 =?utf-8?B?Zk1XTHZ6MDdpZFZrT3llOXc0MHlaZmdqY0oyczdBWXg1d3VQNk0wVzJRVHMv?=
 =?utf-8?B?VFZYKzA3T3pTZHM4L3Yzb1RIZW9LSzEvWTR0aE1wYXduOWY4UVhBRkt3OE9P?=
 =?utf-8?B?aTJkektwMTdVVHcrK1R5dGV6NnR1RENqQU5aZ3VZRU5SSTBuS1ZRblM2dGIw?=
 =?utf-8?B?d3BFYnp0ZklWLzVtVXVMaUpGdTNsMDYzNlB2MEJ6YmxOUEgxeHd5VWNBNE1v?=
 =?utf-8?B?cXdJcGFOZVYvZHNMaHNtYkhGL0VEVTRWbHR3SEptZjNYdDZxcU9hdzdRUGxx?=
 =?utf-8?B?RGZOcERzWUgrMHZOV0F5dVgwa3MrUjRkRjdmU2RUK2JnelEyNDRPamlIdjRK?=
 =?utf-8?B?VGJNNTNoR0dQcFEvUk9BejVjWU9CSjRPK2ovTEhmS0tqVFZ2emRRZFBrejZj?=
 =?utf-8?B?ZEtUd2NZTzdUZllINENCR2ZYR1U2akk5NmJqV3E2ZE1hcUpYRHNpU0pZTkhn?=
 =?utf-8?B?V3RlUEdEODRoV0F3SlB0eFgrWkhRa0xlZmJyTUNHVmpHVjYvblFnbXdaMzVN?=
 =?utf-8?B?VEpZVTR1b252MStzZEhMNUlLV1JNQlJWRXEvR0pRWWl4L0ZWUG9hS3lRRGV4?=
 =?utf-8?B?RXhXazdQY0RPMTN1MTNCU2FrSFNSRnIwcEhNQXZ0WEs1NGQ4OTU2dC9qMity?=
 =?utf-8?B?ZndOZnhqdktNNDN1Y3dFU3lGallpLytwbWFTcThETlZjSzhTVGg5b2UrOG1Y?=
 =?utf-8?B?Y3hBaTFXY0l0blMwNFp0Q0dTZzB0K3hQZ2NlbkVSVkREd0ZFUmltbGNrUFQv?=
 =?utf-8?B?bTNsaUJXUmJyR28welhUTlBTVTR4SzlYOEQ1T1ZBSE9EZkxOcFluSkhZdDZl?=
 =?utf-8?B?MTkzdHd1UFJuK1FGSUIwaUFibGtzUHR3eXYzSmNHNjJ3ZUFSZ2FuY2VveWJZ?=
 =?utf-8?B?S2xWbHFPL1FWZWlNWkJTM2N0TTlGT1NGTHNXNmJ2SGVQVVRzZEU1SnZ3VENw?=
 =?utf-8?B?czIyNTQ3cFFvSm54TndmbGF4L0U2Z2h3QnRHV01lWkY5bzRJMTlXZFZXTEVo?=
 =?utf-8?B?VTNxYy9TT1NVZ1Fhc2hiZWMrYUYxVW5YMjVUMVFuQlcvdGU5ZDliZnJsQTNk?=
 =?utf-8?B?aWxuVmtKM1lZR0M0Q0lyY0k2bXI4MzBXOXliYnExaGxQTTZDcUFwc0tnTWQ4?=
 =?utf-8?B?MUtiSGxNc25OMU45TldUN1ZzMHRsY2JCUlpJL0hPQlU2YXJVZjJuOUFMK2VL?=
 =?utf-8?B?VDFEbE4xYitZUjNkemw5SnRzTjl4akZUQzg0TGhRbEpKTlRwam15eUhwMnl3?=
 =?utf-8?B?ekpTMlc5MFVBTXJNZmNDbSt5dk5DS25VZUdFS3ovSjR6WlpxM2ZiZ0NqQ3hp?=
 =?utf-8?B?MWx3WE5ZNVNaS21YUFpNNVpubDlwb1NzL0FPTmZhQ3MzaXh6NzBmOTJvRncy?=
 =?utf-8?B?M29UeUlvb3Y3NFIrbG44cys1THFiSlZ0U0IyUlJGRTdURlcwcG5mUW9lZURT?=
 =?utf-8?B?dEdiK3UzbU5OQ3RzcHFvTVlNNHpEZnIydU5ZZmRkUlBidnFLbTM3UjB4OHBx?=
 =?utf-8?B?cUZEVEdNZUUvanQwYi9MTkZObSs1bDU1eFFqc2ZZQ21QZWhXNEpwS2hHSDJq?=
 =?utf-8?B?S1IwTFdQRGltYm55cHdCY29CRFNrYXVySkhvM1dIWVVoa042c0VyeEgzbm4y?=
 =?utf-8?Q?mEH7RakdaV6faDg//ZBPaZijyjKygVP/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkZGblFzVEVTZnBCYVJhVDlSUFh2UzBzVEx3MnFJT0NXbDd4OE9tQVl3UUp1?=
 =?utf-8?B?NVJxRlpoNTBMME8wd0lDblk4ODJmUEJLMDViOGM2dEV1TDdpMVBqckgrSnh1?=
 =?utf-8?B?ck5adDVFS0hwcEVjM0tSVEJuNndjeVJKVEI2dFJMd3RVS0F0VzRrbnBrWUEy?=
 =?utf-8?B?eCt5RDA3VnhBTkZpYXBTUU9rOFAxdm9mZHdINll6MVlmNlJSaWxocTB4bGg5?=
 =?utf-8?B?UHRnWmpEbjdXV2tQTXFrRWVRZDRhbzJocmwvQkdla24ybnJINFB1TWlmUG9T?=
 =?utf-8?B?OE5zckR3ckc4NkNDS0pxWUhZWGt4QysydWlaYmh2SkYyOVl4VXhsRm1Rdmgr?=
 =?utf-8?B?SkU2TXV4VkdEaXArUDV6QTkxcUtmMUNBd1l2V0J5THh4NU9jR2U1TlZYbWJy?=
 =?utf-8?B?ZUZ4ZHJ1RlNOR1Z4Z3p4aW96ZWxxUS9PVFovWWs4ampCQUUweFkwUVI1OTd1?=
 =?utf-8?B?bGtTa1JxaC9kaG5pc0JOaG5TREI5K3FIbjRiL3FnQmV1SWdBSXk0dnlZYU9L?=
 =?utf-8?B?MGc0NHdlVnN0S2NQajBZdlF0K3BsZEF0c1Nlbm9lellINjdMdHVkYTBib2tU?=
 =?utf-8?B?ckxCSXFCUE1wUGt6ZjBYVHNnbjVZaG4zMzI4OVVBamNIeXVTR2dWRTh0bkpp?=
 =?utf-8?B?K3dPZHNwVDBPa1BPWUE1SERteGRzV3Era2pYK0UzNnptaCszdFhyNTZmSnR5?=
 =?utf-8?B?dHd4MXlFd0Jkbk0vVGgzeUx3eXc2WGs1TXhGalBDeVk1MUk2SWxUQkFET2NB?=
 =?utf-8?B?bFVNRE9namI0WXN1YWt1M2Yrci9QWEFLeEluT2tUaytDYlBEUTBkaXpMaFFs?=
 =?utf-8?B?WGRuVTViUVhVQjUzc2tVNFE0dGxEMDUxcWVubXRRbFVaUzhxMm9qV2JPSmlP?=
 =?utf-8?B?cVdGcTNVUmw0djFIZm9UYjFwU3BXTTl3dENZZFNMRTZvdkFZRG52V1J1bEtC?=
 =?utf-8?B?ek9KSDlyenB0S3N4Ky9QRTVaZjNsZ0F4NVVOckpLWXJJZFpsRTJnVnJKbmZE?=
 =?utf-8?B?RldGRDVqaWVIYy9Ud2REMzU3Y1lCK25MNElLOFY1RTJuaUFzYmJzRDU2NDlP?=
 =?utf-8?B?REpBaG1vbW9XZC9sUkpSd2hkTDJWbkpTak1iUHRtTWwxN3EwNFNCcHJwK2E0?=
 =?utf-8?B?R1p3aTV4dFlpUlZnbDNIaVkvUGN2T0Yvci9XaW8vVGM3UmFXREtQM0pNdTNC?=
 =?utf-8?B?KzRISHhuU0p6NUZIM0I3ZktrQ0IzYXdPSUZ4S2k3TTlZeGlOME5FWFRzbHRG?=
 =?utf-8?B?dURYdEMvdkZucUJBVjRxaW83WDE0NmZjd2hwT0VwdmhDS0ZRblFyNy94Wmxz?=
 =?utf-8?B?ZkxkZy9oWkpENmhkanZmM0Nac0J6MVdqVHRJWWdQdi84QUNWNWN5Y0pMNUMv?=
 =?utf-8?B?T3RzL2ZneThwalR3Um1nVnA4SEFFd2dTdDB4NTBsWVBKNFJ0V3NSVW8zK2Jz?=
 =?utf-8?B?UWJ3YkNHV0dkN1V2cnV0dktCa1VQamgyMktta2JxbXkrRmRJWVQxd2xpQXhV?=
 =?utf-8?B?K25rQUYzOFUyaENIQnM3MXpFV1VHSS9aMW5PUlI0NCtWdmFXeTFleForZUQw?=
 =?utf-8?B?NUFnYkNDemVYNGxGQW4vTDBQZGtmZ3lnL2oyTzZScENzNEV3Mmw3d2NZbVRX?=
 =?utf-8?B?dUxKcGF6RnF5MWtNcFplU2FhWHJLam5pMUtsV0NQU0F2NTdRUUd6YXc1ZGV4?=
 =?utf-8?B?VERxeGh3V3U0cldtUC9tUmNHMjBmaXp0WUx0ZVNkcXA4YVBFZ2JyU1hBbHlV?=
 =?utf-8?B?UmdteFQ4N205UkI5dEliNUNCVk5RbGJheEJSMUN5T0g0Ym5SUXp4S201dkhZ?=
 =?utf-8?B?SEJJeXBxcUppczJwRlZQajJHQUlqSDMwcDNzSmU5RGpnaXZiUWkvLzIwYmZz?=
 =?utf-8?B?akhvdUtYVzlXMno2WGFjQ1dqVC9QUVBDRThYRnMrUi9BZXJuZG5WVDh6Vnhh?=
 =?utf-8?B?U0NpR1RjQzRCWVV1MUpWRHFrdzJxZzZENzNGNjdvZzRvNmI0SkROWWVxclJC?=
 =?utf-8?B?VlNRUE92T0FNOFJqbldNY211RVFpUzhhQURsSEo1QU0rWHNxZXYxSUJsblJM?=
 =?utf-8?B?Y0ZDQ1VPL0tUdkFxR0ZBV1FWdXpmVFFCNVJJRGxLR0pUb0pLeEpucGxlTEF6?=
 =?utf-8?Q?7J+BzXcPxwhVYsV6ebZaJY30C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28269843-f27b-45d0-d930-08de18bffc78
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 20:56:38.9494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FuT4RF6iQ4FektKDBNLOJi5rLkUxQPX1Tke0FT48Jva5/aHKxiBH2y1BGV+o+PgpJnXLkgLTw4lY/BdE+gd/mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346
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

On 2025-10-30 23:32, Zhu Lingshan wrote:
> This commit removes pasid under kfd sysfs folders
> because pasid should only be used in kernel internally,
> should not be exposed to user space, and current
> pasid under kfd sysfs is buggy hard-coded 0.

NAK. We left this file with a dummy value deliberately, to prevent 
breaking existing ROCm SMI versions. We can never remove this as long as 
such versions of ROCm SMI may be in circulation.

Regards,
   Felix


>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 7 -------
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 8 +-------
>   2 files changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 70ef051511bb..d69079cab1e6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -983,7 +983,6 @@ struct kfd_process {
>   	/* Kobj for our procfs */
>   	struct kobject *kobj;
>   	struct kobject *kobj_queues;
> -	struct attribute attr_pasid;
>   
>   	/* Keep track cwsr init */
>   	bool has_cwsr;
> @@ -1100,12 +1099,6 @@ void kfd_process_device_remove_obj_handle(struct kfd_process_device *pdd,
>   					int handle);
>   struct kfd_process *kfd_lookup_process_by_pid(struct pid *pid);
>   
> -/* PASIDs */
> -int kfd_pasid_init(void);
> -void kfd_pasid_exit(void);
> -u32 kfd_pasid_alloc(void);
> -void kfd_pasid_free(u32 pasid);
> -
>   /* Doorbells */
>   size_t kfd_doorbell_process_slice(struct kfd_dev *kfd);
>   int kfd_doorbell_init(struct kfd_dev *kfd);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index ddfe30c13e9d..f45780502f06 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -328,9 +328,7 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
>   static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
>   			       char *buffer)
>   {
> -	if (strcmp(attr->name, "pasid") == 0)
> -		return snprintf(buffer, PAGE_SIZE, "%d\n", 0);
> -	else if (strncmp(attr->name, "vram_", 5) == 0) {
> +	if (strncmp(attr->name, "vram_", 5) == 0) {
>   		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
>   							      attr_vram);
>   		return snprintf(buffer, PAGE_SIZE, "%llu\n", atomic64_read(&pdd->vram_usage));
> @@ -888,9 +886,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>   			goto out;
>   		}
>   
> -		kfd_sysfs_create_file(process->kobj, &process->attr_pasid,
> -				      "pasid");
> -
>   		process->kobj_queues = kobject_create_and_add("queues",
>   							process->kobj);
>   		if (!process->kobj_queues)
> @@ -1104,7 +1099,6 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
>   	if (!p->kobj)
>   		return;
>   
> -	sysfs_remove_file(p->kobj, &p->attr_pasid);
>   	kobject_del(p->kobj_queues);
>   	kobject_put(p->kobj_queues);
>   	p->kobj_queues = NULL;
