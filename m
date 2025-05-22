Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D67FC54E65
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 07:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF0F210F875;
	Thu, 22 May 2025 07:48:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QHMGUFnS";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00E2510F875
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 07:48:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvAiqckRi7N+Ev+qHrCdlGHX5AGGImKq+X6JOjAFHs0kfHymaRV+Tq1gE45hf0/vXw+c1tvJ3LtSvXd8jnQGTTTtZw00a2G27WXpSgN8tZ2gnjQZgIjOt4P8vGXbJVZixSs23MWPweVzfdxENDhNYY9ZMvMfUmJVCKpzFI5AbZCM7zxnlPyrSeCiIO0SFtitS9JTyWMUSZRS/L3zLZFdftW1LXL1UHil6ZsHf3e3QsGg/d9cWuX0H0hBb6vOqBp0Qlrc7BVjbfabMELTxfRZT1h25vAmyVJd2k0OtXzGIeCVg1JecDpUoMN4tqJgUs6Cw9V6zwOqN1PfDU7L2Zy69w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9icAG5dzg1O229pJZ5FOMTl1qahauv+k9SSUa06F01k=;
 b=BPjNAJ+VpuuUu7RLcuqRP65WL664w1SeFTWjC55Pw4G6E442VuXlSS6LWvp3uIGarlZWIZnnZQdmN/jDvpUUkdsYegRHyMNu6+OS4SdS47nR7ziaUrVbE+ZaIrIC9RgDRLADKGb+gNUWepEJ7F1ZuAu+gqBu5dgtBV440EsjEvg01XzzEwto/AOq42k7mVh5n8yzd6mLEOgNxj3vSS8WN8Cwaaa/5apF3IpSA2OTJ3fk0r32vpUVU0/nJ0319xMFgg1AfzTkpgfgtTntBG6wpcmanM3tk0KqB1DA092vL/Mon9UR+b6xmGzqhE6B/UYXCGOYZDaCVq1eS68C9QYMsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9icAG5dzg1O229pJZ5FOMTl1qahauv+k9SSUa06F01k=;
 b=QHMGUFnSnEX8NFNErM2AyxdlbbJ3YDsur3cjXYwWuEBu4yVfr7T4i364UUD7YnSlFFDIGSi6KeVUzDmt/7cw2frsayoARrlATRmA4yzt4P3QC2clzyS+EaXHFk/QgkcSZwVsQf42CyX469IHK+2K/HlzzrNrdZlJpTAtqWg4F00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS4PR12MB9609.namprd12.prod.outlook.com (2603:10b6:8:278::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Thu, 22 May 2025 07:48:10 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 07:48:10 +0000
Message-ID: <186baca6-0e8f-4c72-ab05-f0cb9e79d9d4@amd.com>
Date: Thu, 22 May 2025 13:18:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] drm/amdgpu: fix fence fallback timer expired error
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Christian.Koenig@amd.com,
 Alexander.Deucher@amd.com, Owen.Zhang2@amd.com, Qing.Ma@amd.com,
 Emily.Deng@amd.com
References: <20250522034350.433219-1-guoqing.zhang@amd.com>
 <20250522034350.433219-5-guoqing.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250522034350.433219-5-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS4PR12MB9609:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a556fb0-faa2-41d0-e2d7-08dd9904ff78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmE2czlYUmJmTFp3YjBiVnZYR0JINzhuQkd1ckYzMFZ3K0tvbTl2TjRMZC9w?=
 =?utf-8?B?SGNjSUs5Q3FoVis2eVRaS3J5UU5mQUFzQUY1UytLNHZXaGRIV1QzQTFva1Zr?=
 =?utf-8?B?V0tDR1gxZE1vT1YzSG9hM0l2Y1hRQ3lxYnNEYlBhS2pvblk2QWhESWp2OTNE?=
 =?utf-8?B?T0hmUmdDMUsxSzNmKzMrZjQrQisxekdWakFVQUNVOWY0d3NCWEVDcm13eVFo?=
 =?utf-8?B?dnV6eXIyVlBqNjROckNKQnZRTlRCdGFZeVJhZDFpVkJxMzF1dG1mTUVwQ2Jw?=
 =?utf-8?B?c0cwZFdkZ0xwYUtSYStZYWxyVHF1aUN4SjRGb3A2b01ieVBMbHJEdTU4SGdy?=
 =?utf-8?B?WHBxRmhSa0Q1a0RGTXJ5bCt6MmNJYnZlQlNiRXZZeGRhKzlnTXhWQmc4K091?=
 =?utf-8?B?dEJEbDdyR0ZWYWZPUUg0SmRrY3JwbklEY1VmMTVxaGdGYnRHUWFGb2JMcGdo?=
 =?utf-8?B?cTMrQndnL0Z6SCtEUnRTZ3o1QnlnYVd4NThBa2loV0RZRU45VjJDT3VlUlBP?=
 =?utf-8?B?ZVJ1REtraktjZ0Jxa2FYQ2JNbVg3SUMzMHdtalo4aXkxWU9JWFVjUFVrellQ?=
 =?utf-8?B?K3Qranc2NkIrYitLeW16U0oycWgzRGdZMWJ6K0dkNFpPZTVnV3FaSDRTdklL?=
 =?utf-8?B?NVJKdUE5dGtkNUNlaURmUXR2MVFuRG1KTlJJK2NTT20rZkhVZ2Y1ZGRneERK?=
 =?utf-8?B?K203bVNwQzNWc1drYzJrK0NhSk4weXdHeFZsVjFLbDdhWWQzbFQxaWJKU0NH?=
 =?utf-8?B?aGUxMjA3VXdRblplZGxsam52UzJLd3FBbGhoZWExRDVFMkI5Y1lzYWtnZFVo?=
 =?utf-8?B?ckJkM1ZjZGY5KzVqVDdJZVpHRGlGSTUzSmFBTmcxVEF0N3NTeHNnaEpLcGVa?=
 =?utf-8?B?aTNQQk9KR0dyVHhuNmxlaGlJY0lBNHpQNU5pekRmVStJSktXN3NSaWZqeW0w?=
 =?utf-8?B?Zk1KanR5MzB0UC9QTmJYVG5xblZFbUJZdys1YnVobTMyWmczRWo2a2RvN2Fh?=
 =?utf-8?B?VDZPd2RXdVR6bEVod1RDRGJYajYyek9DZUI3SVpvTXJ4dkx4VjRmbm1QYlBN?=
 =?utf-8?B?UWovcFhsekpicXBEME9YRER5cktvQVdhbDlTUGxGak5vMy81Y3diNWRYM2tq?=
 =?utf-8?B?b1NuWnloZTliTXpDMnZ2eENTaXBsOGY1T3p4QmZUQ3dKT2dvU05vcGE4RTJT?=
 =?utf-8?B?alBLT1dKbER2YS9VNVNmaU1iZWs4ZXFCa2JPN3dpTFFIdGhKOFFaTFlsckxQ?=
 =?utf-8?B?QmZKaC93K21iUCt0ZVRWVm9rVkFhQTVRMGt5dGpRQTV3TXNpQlUxcDBneEo2?=
 =?utf-8?B?SlZiRUExcjdCUVJIWFoyaFhkNW1GVDFvMVFIRU5HcVMyaVd5bFREVjdOUUZD?=
 =?utf-8?B?Y2RCZXpVRXNDWU1Oak9SazcrN1JMcHhLeklmenJIOG9kSkR3SXlRUUcwYWli?=
 =?utf-8?B?ZHNsdk1MaURDUyt5dmpRWmZEMmttaEM4UjYvODNJUmdBYThXSm1MRzEwY01Y?=
 =?utf-8?B?OGtJTVdBalN2Y2lOTDBnMklERHNaT0dRbFZibHZqRzhJOHpYcnYrVm5hd2Iz?=
 =?utf-8?B?K2JZdmVQQklGWlFYeTZTSU5wWFhma3l4UXFxWEZlYWZQQXlVc3JSOVB0QlI1?=
 =?utf-8?B?b0xKN2ZMeWJZWklOUzIwd2hnc0kxV0RrS3p3dVlvU29SZ0hRdVJicy9LczRm?=
 =?utf-8?B?QzFIcnRERHk1UDY4SzdFWkQ3R2E4K3JnNzE1Z2lOWnh6c0J2SjJRTDlDVmdU?=
 =?utf-8?B?TW9EOXFDZkRSV1doL29NR0pRMmpOU2lrZCtIVEZsNHduMkIzL3hIcThpS3ow?=
 =?utf-8?B?MUpWV2RFK3drUEVkUGo5UXdLOTF1RklibkNQQ3VRc3NMbU9oS1BxYnoyMWxQ?=
 =?utf-8?B?dCtVQ1dHUUZVL0VQOTkyL3hCeWNMbDJ3dnREa2dDUC9vTEcxM3M5S21TVzhy?=
 =?utf-8?Q?hBDqQ1gk2ws=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnFkTyt3ZGVka3d6N2p2OWlTZGVzM2svOUpHWlRXOXBiaElWRndTY1VlLzNV?=
 =?utf-8?B?OGQ3YXorNVRxMWx5aUxkZTNJL1pQYmsyYTFia0dXZ2IraHVTaUt3SVNnWjBz?=
 =?utf-8?B?OVkvSkozR0pSQjdURnJYR2ZzK1R2cVB5N3lNZHJqaW84bm5zcGtOcjVuWHR5?=
 =?utf-8?B?RU1OYmkxc2FsL0JodW43Ty9LQ2hSTnVZZGd1amxHNmF2RDhGWG1vOHlRWEdN?=
 =?utf-8?B?WUdvTGgvZERMeVdGRGZleEYrSXkxQTdsd05HYUdSQUtZWU56NFQ1Sm82cVhT?=
 =?utf-8?B?V1dvdnNPalFiRDNMT2dIT0Zhc1pJOXRHbDVNRVducU9FTzBONE9WQ0k0U1BI?=
 =?utf-8?B?Zi8vTFdscXRHUVd4cDlPSElNSk51eDkveE5vd2lIVnZEMjUrL0ZOaFgwamdR?=
 =?utf-8?B?S3dsRFF4YUVpYU5CMGFSRFBCU3hsMjdEMGlVbDl6a0RpOFJDUVp3TGVoaHBP?=
 =?utf-8?B?RnExbm52REk2Ti9ON3djeGZ5anlXUlNOV2o0S01IN2c0cFlCTUYxN21SNXlR?=
 =?utf-8?B?NFNZeS8wR1d0QkNzNHl6RjFUVjB6ZEhydFd1MHZoYXZjdnZidzE0TS9UMlY0?=
 =?utf-8?B?RDFtS3lyNGtTS0g3VFh2Q0xXK3pEU2tlNUlZNTZjb2F6ZEtZQVorU2RVMjFz?=
 =?utf-8?B?YVV1VU5Cejg1Ri9jNkRaMnNCSnFFMHNKcHhZZFgrSzBETWRsVndnaER0T3c4?=
 =?utf-8?B?bEJkVnUxc0RuYzNOUnB1VnVENEg3VTlxbUNGZU9HWmZFVmdjMi9qdUdsUkFU?=
 =?utf-8?B?K1FtUnVNcW9ZSjlxTFE0V1B0Z3MxMkQwNW5FMmpaek0xaC9DSDhZaU5lTmpR?=
 =?utf-8?B?cjZ6ZlRhL0x0cTNsd2FCeUE1cldEanlEL0dwYnNBdWxJV0FUMHJiNUF1S2ts?=
 =?utf-8?B?UjRKYXF0T2laS2VvRXlPcEpKL1dTb2phQ0lZVkZ4anYzYmhCOFpTZGVGakcz?=
 =?utf-8?B?RmNPczR0cVVtbHBPaW1qNFZXcEIwaXpOVi8vekJsZ1RGVTNhTE45WEFNWTRi?=
 =?utf-8?B?enV6bVlSYzBBdTc5QVVxZzYwUWVxejJmUVZ3ai85Q3YrKzB3d3B4NkgxbUlo?=
 =?utf-8?B?S1k3bkY1bnZ6ZGxlYytUZGpQK3dYNVFkWVM0U0Q0Q1RpcDMwdi9jVVVpeG5D?=
 =?utf-8?B?ay9qSmxlNVlING5tbkFqUG5yWnNCMXZJQkliaVhQU1JWaW1leTh3ZEJBZjJu?=
 =?utf-8?B?bkNNL1NSbTRCa2RJb091ZnN5NVpxa2NnblR2S0ZGODFUeUpsTmNjVSsvMzFy?=
 =?utf-8?B?VWFHY3pvY25XejJaaFRSVUVWOGxuSWNrRTV6TjdsTlNSVXJnYjRIRm5VaHcr?=
 =?utf-8?B?eWVOQnUvSEFoV2EwNE1MTFJ2dU90V0ZMeU5QMnVCK3hFbU9Wa3k3c3JLVlNl?=
 =?utf-8?B?SGZpMUlCVFZOOEJpR3ZtaG9YR2l0Q3l3SHUvN2lNMmh0V3cwVTd5bU1nWlpi?=
 =?utf-8?B?WmZQVzBaU0Z6WTRiaU9oaE41SXpQS1YyK0NLeENHcmxTSkZzZ0FHQnN4Wkp2?=
 =?utf-8?B?NjJmUnQyOHY3a0Vyay9iTFAweDl5YTQrYlhkUzZ0dG9QdEhWTCt4R3M5RTNL?=
 =?utf-8?B?aHBHRzczek5LYkF6S1hGRmdRUDVDL1JKaWw5RS9CbE94L3VrMElwRTVMVzl3?=
 =?utf-8?B?emJJcVhPTzloYk84bzdBcWpqSE9UVE10aFF5bzJ3L0toMnl4OFZiZkxEMzJs?=
 =?utf-8?B?K3Q4YWU1dDhKUGFZYVFtMTU0SDdLRW4va1o5dzFSVFhlUkF2bm5QVy9ub1Z4?=
 =?utf-8?B?UVRtQ2gxdzY5TkFyTVFNb3BvMzJ4aEdTby8wNXFSUnpyWFZPcVpKM0IxKytu?=
 =?utf-8?B?NEc1UjNnMEVwQ29LRG45dUhBQk5oNnVOS0thUEI3WEQ2Y3pLaEEvZ3k1MU84?=
 =?utf-8?B?TlZnU0dGeDBnM0ZDY0JhMUpiQWN6QkZ2THhaY25TdzBhSDM2SVlNWEtINTFT?=
 =?utf-8?B?b2haTmp0RUc0NUFWVmZSQzFkcmVlL1BEdEtZT1hFbGZ2a0tUOURxTFRqeFI0?=
 =?utf-8?B?WWZlbTg5QVRiT1JvZURzMGlxWnBYOWY1MSt1dzJCOUt2MGtkWmFhaEpnOVIr?=
 =?utf-8?B?WHRRYS9iWU5mMmRxN3ZiRllhdnl0blR3amhzMVN6UVczdE5ZUlU3eTc1SzVY?=
 =?utf-8?Q?Xskidcpup0OScHQuwHldHjiFG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a556fb0-faa2-41d0-e2d7-08dd9904ff78
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 07:48:10.5052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHVfHekrtp3dT2aFbsKcyp0F1rljR9ERtSHW1pHnPjQD3uJgqlcGhAoqifT6OLEJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9609
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



On 5/22/2025 9:13 AM, Samuel Zhang wrote:
> IH is not working after switching a new gpu index for the first time.
> 
> The msix table in virtual machine is faked. The real msix table will be
> programmed by QEMU when guest enable/disable msix interrupt. But QEMU
> accessing VF msix table (register GFXMSIX_VECT0_ADDR_LO) is blocked
> by nBIF protection if the VF isn't in exclusive access at that time.
> 
> call amdgpu_restore_msix on resume to restore msix table.
> 
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h    | 1 +
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 97389168c90f..1f38ff1e42d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5051,6 +5051,9 @@ static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
>  	int r;
>  	unsigned int prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
>  
> +	if (amdgpu_sriov_vf(adev))

This check won't be required if amdgpu_virt_resume() is restricted only
for VFs.

Thanks,
Lijo

> +		amdgpu_restore_msix(adev);
> +
>  	if (!amdgpu_virt_xgmi_migrate_enabled(adev))
>  		return 0;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 0e890f2785b1..f080354efec8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -245,7 +245,7 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
>  	return true;
>  }
>  
> -static void amdgpu_restore_msix(struct amdgpu_device *adev)
> +void amdgpu_restore_msix(struct amdgpu_device *adev)
>  {
>  	u16 ctrl;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> index aef5c216b191..f52bd7e6d988 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> @@ -149,5 +149,6 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev);
>  int amdgpu_irq_add_domain(struct amdgpu_device *adev);
>  void amdgpu_irq_remove_domain(struct amdgpu_device *adev);
>  unsigned amdgpu_irq_create_mapping(struct amdgpu_device *adev, unsigned src_id);
> +void amdgpu_restore_msix(struct amdgpu_device *adev);
>  
>  #endif

