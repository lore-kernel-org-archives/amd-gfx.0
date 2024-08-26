Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB2DC5321D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Aug 2024 19:06:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B989E10E287;
	Mon, 26 Aug 2024 19:06:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q4Z8Nb8j";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57A4110E287
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Aug 2024 19:06:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXDdUYmxXaNMobZwG+JO37toq3JQGv4kiApXsHeX53FOnJ0wAp5JWMEMIuaDxHhk1e1jD5oceOCjIEZeWaFsDPb5rxuuGgyJymF+kbljvvKELjlnLMwL6eN1EXdL/+RrMUgQHqNEaY7OTjkEKbkgVDycVf6Rkl8USt0SUbPdX30qslCZTAhzpSED1NHPHiKBzdZMV8z2ki1xcnlpMNisCPrZqD+hIPmIEs8qk6UIFEreCupuMtkNsx/BTwrBNNwWrsC5PaauzeEZpepvkgIGdML+SDCZCk0rYE1blqXLGrWTyKpxJ2F2R4uQSrw/a0OEQMHKlH4lax7Xv05gqTJSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYuSsext5T03NcUnTsr+4NB8cX4+4MJeiP+ahjFkglw=;
 b=ne+7uSDB4ZVADyvwQ4ovr9biExLHi5Q92Yu7S9xZgx+hO02hjarfF6IHu68VUsJ31nhtKHfsdc27AmUgITUQfol2Vj+fe9HFuu8prmzhuMO3Ps/u53cIcIdgaTrbYlFAgQnUW56+gFqSaOIrqd1kbTADrH1YvRRV/xKLVqcs40w9v7MKDY1HjlQHaJtyyvF/8FPuIXemnRocbBzz49u4Khs6Uqn0Pks4jw39TVlIzeFlhVMnj1nPmSUBW4tGdgkhjK+F24TWimAEzyfjFxNRZWtOeknfHR/swFOXlk+s68TbM5gNfRg2oVOyVNKvTR3CQtGTFxN8rEgbO+sbozdplw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYuSsext5T03NcUnTsr+4NB8cX4+4MJeiP+ahjFkglw=;
 b=Q4Z8Nb8jC+6VZ49uqCkU70xBzp4K6pzn7nu3Ob81QyH1F0JYQqMS9chPxeauYLft+ftSKlGYrydVRlfhP0SspDKiBHxkCj0nrFEfPrn9bZ6pQhjTn5EicWXU7old8ds6O5DlBw3BmhMlzSv++2Qr1UQ+F6ryHnlSSBl/ZkiPgnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 DS0PR12MB7946.namprd12.prod.outlook.com (2603:10b6:8:151::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.24; Mon, 26 Aug 2024 19:06:07 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::a846:49eb:e660:1b5b]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::a846:49eb:e660:1b5b%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 19:06:07 +0000
Message-ID: <b3bb7212-8839-4038-98aa-0e3b25827428@amd.com>
Date: Mon, 26 Aug 2024 15:06:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] drm/amd/display: 3.2.298
To: Zaeem Mohamed <zaeem.mohamed@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, roman.li@amd.com, wayne.lin@amd.com,
 agustin.gutierrez@amd.com, chiahsuan.chung@amd.com, jerry.zuo@amd.com,
 Aric Cyr <aric.cyr@amd.com>
References: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
 <20240821220156.1498549-16-zaeem.mohamed@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20240821220156.1498549-16-zaeem.mohamed@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0281.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::7) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|DS0PR12MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 186ed48d-03dc-44d1-4c8d-08dcc60223ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1E3R0VtTER3YVpnanZnamVyOXZsbTJTQzBlN285cEZxZEZpQjlDVU5mRzR3?=
 =?utf-8?B?SDdIelk4YU1JVE80aktQUTBTSy9yVHJGd0RVVlZzNzJ1VzFpNHhOc2JLcmFD?=
 =?utf-8?B?RTVtNmllUTlqQmx3VDRqSVhiVWR6ak5aUEtoWGhpZkFHd0tTRnJ6VE5SRjZw?=
 =?utf-8?B?ZnpPNlF4UjB5cm9Kc3lvTUZ5ejJtbS9NOXM3Ri9DeXQ4ZEI4SjBqb2NBOTNm?=
 =?utf-8?B?eGYzVXVXclkyK1BIL0IxUWFTSEpTM2RhK2xTZ0x6cVVaRkJrRStRVk81d0tO?=
 =?utf-8?B?YWI2TTk1cFFPbmV2bDVzdXc3VytyMTBWcFpYNWMxUytZQlhzSlJ6NDR0YmJq?=
 =?utf-8?B?R1lpdmpKUVF6N1pTdEhOMzZ4ckZ1QVBLaytpWWNlM0RHeXdOSVA3KzhneDNa?=
 =?utf-8?B?YTJrZmFaa2ZjL1Z5Q0tYcU1zQi80UmVydFFBdk53MDlvNVVzd1l2dzBQeXVm?=
 =?utf-8?B?S2M1UUsrUTVPckhJbXNqSEN5OU9hVnh4NHVFS3YyYUp5NFBlWmF0eFdGVzYz?=
 =?utf-8?B?RVloYlhqaFQ4Tm5sMy9qRDlsbnAvM3R5ZkovVVllNlJrekloRVh5MTNhVG41?=
 =?utf-8?B?aXJCRFRPYms2NW1XU3l3blFGL1dYNEwxREdwMWpWSnZCMzFaaWVTZGdDNXJx?=
 =?utf-8?B?RWxFUUZqLzdTT3VNV3ZHL3czdkwzRjFSMk5hNVNXUVhHTGU1aEFaSmxRL1Fy?=
 =?utf-8?B?RTlUN1dHd0h2ZlFkWS9zTjllT0lLVHlPclRkSHNlVFlLelYvbnQwS3J6Qlh5?=
 =?utf-8?B?Y2xIMktKYTlBNUxqcEJzRlc4cy9oZVRXZ3RLQkY2KzhBMFU0dDB1MHZvU2Zh?=
 =?utf-8?B?cFByTkVBT2R4OThQdll1Y0pZendQQ0NTYXRWSk0wSUhpS2w2eHU5dUFjRUps?=
 =?utf-8?B?aDVMV05OTkJWUlNHanE2U2QzZ243aVBUb0l6SW5NMDNGQXZUc3NIcGFYWUhn?=
 =?utf-8?B?UlVTb3VLQzV3Sk1pekZPZ1AyZFQ4OTFkRVh3YUhwbTdGQ0Zmb0lZdHZhUWt1?=
 =?utf-8?B?dEc0bkRHSlBySTBnd1dUUUlzMkVteC9NSnpuUEp6d1dVWUFXajkxRi85LzNC?=
 =?utf-8?B?RVpaV3FjdTNtY2dtYm96cEcxZHkva2hLUFpPeXJsVHpuSWEyVFJhajAzck9x?=
 =?utf-8?B?VHlETUhVaC9rSUNkWHFtQ01nSGpjTy90WUEwRk9tOUN4VkRtSXM4N0hNY2t4?=
 =?utf-8?B?VHZkY3NHMXFLbExRV2hyNngrYVB4aEtYRU5JY3BzR0JZeUJIaHR2emxYTnNF?=
 =?utf-8?B?bitDVFBQTHJ5Y3BoZkY3REQ3cVZSVldwdk9jN3czYW5kMk1GOStaejNkYnl1?=
 =?utf-8?B?THFaVGVrTEhjNERpTDV4eS92cnhLakdPSVdQczNFQ3BKRHFsck9YU29jbW1m?=
 =?utf-8?B?dUNaSEc5dGF1S0FGaWNuV29BblF5REZLZ3ExQm1PNGJqMlM5MnNnWU9LbVhl?=
 =?utf-8?B?eW1BRkdnNHVIVys2M3YvR0RSY0xnU0VkOUhhS0szK1Vjam5TZ0RRMXR1VEw3?=
 =?utf-8?B?RThuUDcyNGFJcW1mQnFxdittM0VzVzMwQTFEN0tIRVVxTklyYmFLMUZDVkZq?=
 =?utf-8?B?OVlla2pHbWxaUW8zMFZ6MTE1NkIrR3ZEaFFuMGFCQjdIV3YyaVdhMVBYdk13?=
 =?utf-8?B?K0xGdTBNMWpmR3dJQU5yY0o0NENzWUVEREdVZFErWDBzZmo5aGl2cTVTWDhE?=
 =?utf-8?B?MmtDdmR6cUtoNTBTYmJpb04vWGt2WlFrZUJVWmVNUHhMS1ZzZTVRT1RQYWVI?=
 =?utf-8?B?U1ZCWjExTjdqMlpSQ0ZBUzVRd1BMQ1V0UHBZbTgxdUtLUnV6cnorMW9LRloz?=
 =?utf-8?B?emcycDlmTGkvcUtoR2JLUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTh6M1RBeTR6bEIrR2RQNDNRUTZXVmRyemRqdjhOU2Q0Tzd5UmdaWHlzZjht?=
 =?utf-8?B?SVA4R1dzNnhTY1RKZ0dRSHQvZFh5RjFDZzIwZEVUanJRWnBJVFo1WkhWRFNn?=
 =?utf-8?B?Ri9GdlNHcEE1SjNmRU5mNGlDbk9PWGM0WitURDRFcWxSdWthaUI3NTJQRU5W?=
 =?utf-8?B?NmpTQ0ZPQmhOZVpzdGNwRDcyZGNNOVN1QTBQSHpGbkhySWlVVllDV29PcmhL?=
 =?utf-8?B?MzEyVk9RMUF5Ky91ZlRJT21PZ0FRMmZYU2tYZVZOdHJ6YjVTK0dSVmFoVkhL?=
 =?utf-8?B?ZHE5bTY2VE1mVVZvdHFWVVBzaVp4Ny9ZS21hLzdaRjBBYkpKWEswbkZ4cUtK?=
 =?utf-8?B?QnJMSWpCWGU5eHhWWWgwQkllYWR1MFg1ckNvYldGMkhueTkzSzZuWUN4MnJi?=
 =?utf-8?B?b2JSOVFKRDhDR3BQU2txRjYwZUYvdzNNS293bnN5dmRGb2dqajFxZHNncW0x?=
 =?utf-8?B?Z2FweVoxbW5KeWsyNHVnWldhM3lKSHhMeVJqR0dOeDRKRkNSWjltd3FmL1JG?=
 =?utf-8?B?OXllYWptMlowdU90akpQcEJnM3FGWktEZERiZHFCVzNzNDZ4OUZXVEZpeVVt?=
 =?utf-8?B?ZU5yZWRScHI0VUZmQkNSdk9CYzM0ZXMrU2lnbGVhN2NEYlhkWS8rME5pSlZz?=
 =?utf-8?B?amlkN0t3eVpwTlAvajUwTG1TaklTOXZ4REZ5T2JXVExnTFZNc3pkdXo0ZWFj?=
 =?utf-8?B?K1hEd3l2QTRsYXgrZGNkZWtLaXJOSUFhMSt4TGVzMWRxeXRWcE1FTENIaVl2?=
 =?utf-8?B?NGZ1T0pwQSttRUFTUldKWkFpTUZlMnhmSWtQeHhOWlkxVkFYTVFEeGY5Y29m?=
 =?utf-8?B?VDFMd29NOUJPSCs5ekRZLytXUW1acUxrSWNaVmh6SGNVZ2luTlpDUk9VNTRk?=
 =?utf-8?B?ZzBSazVPRVhiMmhQRHdMZldrS1dHemxtMFd5bFN6S0U0NTUyWGdUTnpBUHE3?=
 =?utf-8?B?V1FETW9ucmtWNDFDUlJ6ZjJINkhiMVlReFpwM0lWSS9jbVRGUy9pL3NjTE56?=
 =?utf-8?B?VVVBQ0ViWVZzcTRGSGF2WU9DU1NEaXpYZjNmOC9rZmJNL01hVnU2RTlEd1E4?=
 =?utf-8?B?ZlRqamFYS1VUYXVYVCtQRXZESlArVkF0dWlVNnR2aUNacHdGYVJkTEQ2cUUy?=
 =?utf-8?B?bFhuMklmU2UyczVIZjE2LzdRS3VGNnQwSXRDcXB1YlVLaFZ3cXJUUzMxVzI2?=
 =?utf-8?B?TUduQS93MUZyMGlKRmVhbU1NWGFnL3RwNjY4eFJIZkk5S1pCOW9Jd0Y5Sm5U?=
 =?utf-8?B?blZVblJTa1hGWlFuc1gwRXB5NHQyUkZOK1d6ZG1yeWc2U1E1OUtQTlV5eUhq?=
 =?utf-8?B?NmdrbVZXOEpPWWI3WlZVMVJjYlhSZFo4TlNReEZ3eFkvbEwwVEEyY2VhRHF6?=
 =?utf-8?B?UlF1K3JjYXI0dUtPKzVJT243N2tndlRKakRNL0ViaWNrdmlHeXlJWkhnb2tt?=
 =?utf-8?B?TENBYXRmU3BKUGswSFROOU9XWGJkOGJ6bkxBWDZ5eFdpUWZIdGkxNHMzWHZC?=
 =?utf-8?B?RFVVUG1PNnd4TDNBNUg3SWRnRVFzTGVZQ3kvVlp5N1NGVWFTOG5aN1hDQnVE?=
 =?utf-8?B?N2VCanNxS0lIb3NzeHI2c09rUzl4OTljWEtHYlJUOWhXTE5PbkFVNFNOQkhW?=
 =?utf-8?B?MnBLSFNIRnRhOXVUN2lOblAxKzQwc21vNENDRFVHWEcxTXVWUnNBSlJnODRI?=
 =?utf-8?B?TDh0Y0drOWJIQUJYWURPbzNPVFZremI4VU9EeUxzT0NnRGdrVktqYXk4WGZP?=
 =?utf-8?B?amhkNUl3bC9WcG0vZUpVNlhQYk9JdGdha2RSTW1aNlVBenp5M3FpdmlBdzlI?=
 =?utf-8?B?Z2RDSEpQV2d4dlBEdkJWRitvY1lPYUR1blJ0cm95eitnNlJFSStyZmE4dTd3?=
 =?utf-8?B?R3ZkSXRyMnZZU1BUQjREeTlzTi9tLzhFVE5DKzc3cFJJeG92aHJxSGxzbmpC?=
 =?utf-8?B?UG8zU1BtODhUQTh2VThLU1l6QVB2a1ZQWTlxcGhPZUdaSDhyV3RKRjZzNVdE?=
 =?utf-8?B?NnVIbkJiSnV5MWNHYnowam83TFU4eGhIWnIvdlNoYTBzb3BNeGVvTU5JTFE1?=
 =?utf-8?B?SmxEOWVFVDh0NS9FeXY5Uk9iMmErOWhqOER0cnRuWlZPVnZzVUxZSlNpY2p1?=
 =?utf-8?Q?5SEdPy/0pIz5kiGlNiuIwx9IX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186ed48d-03dc-44d1-4c8d-08dcc60223ec
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 19:06:07.6644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jtFjYGDYUdRB75Cb4sFtxwc4/ohTXwh45lk9pR0gWCCPissTHt2/L0JINp2P39C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7946
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



On 2024-08-21 18:01, Zaeem Mohamed wrote:
> From: Aric Cyr <aric.cyr@amd.com>
> 
> This version brings along the following fixes:
> - Fix MS/MP mismatches in dml21 for dcn401
> - Resolved Coverity issues
> - Add back quality EASF and ISHARP and dc dependency changes
> - Add sharpness support for windowed YUV420 video
> - Add improvements for text display and HDR DWM and MPO
> - Fix Synaptics Cascaded Panamera DSC Determination
> - Allocate DCN35 clock table transfer buffers in GART
> - Add Replay Low Refresh Rate parameters in dc type
> 
> Signed-off-by: Aric Cyr <aric.cyr@amd.com>
> Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>

> ---
>   drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index 5bbc7d2daca6..663aa565fc8a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -55,7 +55,7 @@ struct aux_payload;
>   struct set_config_cmd_payload;
>   struct dmub_notification;
>   
> -#define DC_VER "3.2.297"
> +#define DC_VER "3.2.298"
>   
>   #define MAX_SURFACES 3
>   #define MAX_PLANES 6
