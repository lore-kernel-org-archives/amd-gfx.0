Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B922C3ABD8
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 13:44:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F016E10E363;
	Mon, 19 May 2025 13:44:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LGDGijKn";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A8E10E3B4
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 13:44:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Va6p6iNr/0F1gshLiHeDJnLQVyT/BkbmO7zDi8uTPhpZo3U3f7jq98SY7NE7LbP/lQuk8jSIyDbPWkN39g8h7U/JXChNbQZ2IE2I1elMWaj/Vw4RAptxvABdLO+VmSoYr+TkFuotst1M+zNm/kBUdUayDLOObfa47amAmsKkePMxthoUfrwBSbH2k2eGHDZMfMQPP9V5Uo3w1E13nLsDc0sqPgKahzhiC5J3Km5mQM2+C7CD0d4yN/KTQTMy0Yt3GoXehVyOJ/4n/t3zoJoE8SpGPSBuYezEKnW2jDAUO/au6CgzMOnYtfXIwvkz/FcL6+4hbx2oXEXRkCbPXTVjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OwGlnz5MAUyw1VksOLOBqCEtnqFOV4uSE85MPGZyTI=;
 b=pDF7NcCB0KwQI+p/IPF+eiBzTjVD1vbUHCZNo9i7FGqXZTeJNzZ3rYWllGt39S+2Xh09x67gJoQQdlTTRT+SmpuhFuNaDLKI2SfmPtgMwDWcWeJNgsNgYxY7XlW+HTHw6FlMZMuyggZ0h7fkvg8fgPw7jGO1lITF9x+IRkevmyNKfjRSoszbZ74zBxFeo0Q5QzfTDLBHhwXXm3AriocnZrStHONuKwJD1B0sMQiGKWdFUIkf32zG4HejLRaIzuy2cBy3rhlHbQS79GQMMojyT7/Gg9WOxEo6fx0bpxuQBD6K3C+/CTbL3VUgq6j5LZa0gIqq7ddBJe4DIZ0rl5qYxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OwGlnz5MAUyw1VksOLOBqCEtnqFOV4uSE85MPGZyTI=;
 b=LGDGijKnL28yiG2FhbD3HjWK4Z6y/2PyaP2E8kJWO+ibYaZcuDBgO6Pa9hlyYRtg0Yslc0pz14l3bMzzaC73z/wa6TuhPSfE0U1tEmlSC7DcnAsAjizI9r/PnOblj/WAv7yxEEIycy8XvXfPpptvuFGjRF897ds6+ReVBV7oKLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB8031.namprd12.prod.outlook.com (2603:10b6:510:28e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 13:43:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Mon, 19 May 2025
 13:43:54 +0000
Message-ID: <e9e63a0f-7588-4013-b2dd-d016824c1d39@amd.com>
Date: Mon, 19 May 2025 15:43:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] drm/amdgpu: update GPU addresses for SMU and PSP
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Alexander.Deucher@amd.com,
 Owen.Zhang2@amd.com, Qing.Ma@amd.com, Lijo.Lazar@amd.com,
 Jiang Liu <gerry@linux.alibaba.com>
References: <20250519082038.21459-1-guoqing.zhang@amd.com>
 <20250519082038.21459-3-guoqing.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250519082038.21459-3-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0292.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 150b288f-9fc6-476b-a0c1-08dd96db3282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajhaaitUT1FyaWpURlVQVnVxYmN2dkF5VGJtNmNsQUFhcHVQd1pRVDE4K0pK?=
 =?utf-8?B?d3dzYm5vaEM3WEtORjNWbVBPZFByMmVSeEFEMzRnak4vcE1VVUIvSHArUkdu?=
 =?utf-8?B?R2VWbjMvbUJnZTZrQ2FpM05sUk9reEY3QlFZUm5pbkszTHVOU29ZZ1Y1L3du?=
 =?utf-8?B?V3hheVZhcEI5ZnRtOCtxdTMyeGh1VEFJRGpNcWJyczJ6enNIZEwvNnhhekRv?=
 =?utf-8?B?ZExkYUJ2Rjl6L3R3bVZTa0srUmxLVFY3dHVpTHJyN2NaS05odlhkWUk4NGVa?=
 =?utf-8?B?d216aW1tVFAxckJNMWJrTGI1dFE0K1ZRUk1ENE5vMTVTbEdIRmhRbkNocnZt?=
 =?utf-8?B?ZjVlZGRDK0w2YUczMHlOUHdXWjdHUHNUNzlveExVbFFCTWpLWDN2SHpXQWRi?=
 =?utf-8?B?WTNjS3REV3ZDbjZiL3RXK2pjL3FoSlk2OWF1WXp0UEprVXFZMGhMd0NHNUNw?=
 =?utf-8?B?bmRpYjEvbk5nT013alVsK0Irb0dxSzVhNENZUEgzMVRrZjhYSWY4T2R4bmpW?=
 =?utf-8?B?dTRRNnhHaFMrMFRKamVUREpXQlI1ZE9pYXl6a2w4Uzh4cVZtRVJiVytPYjBZ?=
 =?utf-8?B?WHdyWkZJV1dqZDV0V1I3ZnlIbFp4NE54WjhlK1RGeVI5NGVmZW5sYXV4YnVy?=
 =?utf-8?B?VVlid2lHMVVOV0p3NjJoZnZzNkx5a2FVYmlmSkxZSzNRYlJPNEpFaU1XSUZh?=
 =?utf-8?B?ZTVteTY5SSt6MzZJcUhHSTRxZStwckhrN1lCMEljSUQwRG9BZGs5YnN2SnFV?=
 =?utf-8?B?WTQ1TXNtRjFsa3ZkUzk1OWNQczBINEk4S2hjZUMvejh3aGlMbWc1TVVXMVR5?=
 =?utf-8?B?VzZaM3dTYnZUNlJGeEN2SUpTS0RXZisxaUdWV2pkYkJzazh2M1JZMytma253?=
 =?utf-8?B?c2tlMTFuQmI2cDZCcUxOdENEa1pFL1BCRjdzT0NENENEV0NvVDBuSTI5UGJO?=
 =?utf-8?B?ejRPYkpmS2lleEl3enBpNkRyVkFJcFc4ZUl2TjNRd0Qwd0JKWWt5WWxLV2Vl?=
 =?utf-8?B?aEpxTzNaVDVubDg3QnVvcXJIb3k0S1NGaDgzdnN4TEU5Vm40ZGlrOUtkSUVq?=
 =?utf-8?B?RVpiaXNKQUFwL0JUK0kraEFic3FXeHNJR3dGRkVjL29sVjhEWUNyWWxVZWNU?=
 =?utf-8?B?eGV0enNVRkZTM05HVjBaVW9yVm90QzJMcmtYL3VTSUZqWXJRMGtJY0d2WDRP?=
 =?utf-8?B?M0F3TDNmeXZmeDZWYjlib3BydjdXT0xhQ3B3MitGdGpOdXhINzh1SU9OdS96?=
 =?utf-8?B?WkNWbEJSa0h2Y1I1WVJJRWRJNW93em5KK2NwOU15eUo4NWlEZEFsaS9ybkVa?=
 =?utf-8?B?ZGxodzMwODBlS3VJSi9hdndXNHZrbHJEQm9qdnl3ZGxaaHl4cnN3UVRuOExy?=
 =?utf-8?B?TlY4Wnk4VFpQeGJpeEhBNTVQNTNKRWRTbFVUc201RkphNzJucERTWCs5YWE1?=
 =?utf-8?B?dmRQdndQbnM2R01ScmloYzRFdVlTNGRpeS9jTStKYTY1dWZkdi9SWDJrRndK?=
 =?utf-8?B?aGoyK2loUklrVUN5TFNEbjJzREQxMFFVaU1EbE15TzhSS0tPV0RvQVlwaUVT?=
 =?utf-8?B?ZVBXRGxhZHdBVEFmZUNuT0Fma1MwNGYxMHNHK09KTTNuYnlyWjFLcUpTdHVL?=
 =?utf-8?B?VEFzcEhmS1FjQTAreEhMVkR2QUVBSDBXbUY5SDI1Ym5HdzFaL1NyM3J1SzBk?=
 =?utf-8?B?SWlLTFZjUVlxdzdoeXBsNmF0ajJLWjN0MG1ZNDgxWnI2TEdGdmdOZFJSV1A1?=
 =?utf-8?B?a3NERGlNRzRST0FwMzhFcXZpYWJrSThYQ0gxQXNWbE53VlRob3VyQlNhSGta?=
 =?utf-8?B?UndJQjc3YzRCcW51OEc3NTN2Rm5OdXo2K3lVTzVDZi8rZ2lLcEpQRG85MHl4?=
 =?utf-8?B?eE1PUi9Ccm80SzlaRS8rRi81L1g5NnFHQjY3eUZuZGtHRS96NVdTcHVIQzVE?=
 =?utf-8?Q?9EdQv9B64NQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akNxZDhhSTFKR012SUZFdzBwY2Mxb2tudjY1UDZiYzdMWG1rbHNEKzZ5bldI?=
 =?utf-8?B?Z1owcUlwMWFaWG1JTkdSVmVEYm1ha0YyMG9hMW9HZEJKMHhVdjZ1Nlk2bHRD?=
 =?utf-8?B?YkpZV2N5NFVuS3Z2MlZrVEpLTm96dmlQRkJkMlpFajVhNlAvSVJLQ0Q3RTY5?=
 =?utf-8?B?Snc1bjdpdDk5TmhUNVFHcHJZSTM0b2hvL0Y3Q3N1dStZYWkzYUVwZzlNb0wv?=
 =?utf-8?B?NmMvQ0R3YU1USm1pb2t4TEZNeml6TEpDL2pKdm5TU3JQalhndHhkenkzQktv?=
 =?utf-8?B?VjJ5dm5XdGZHMzVOQVl3UFdoR29jTEhtMXB1RGlCRFE0OXltMERJazNBZys2?=
 =?utf-8?B?RXQrMjM3cG8zQ1FNUk5WVzMxcU15STlLS3k3QlRUVGx4U2VGMzJNdjBkT0Y5?=
 =?utf-8?B?U3pwYVBsKzJzRzljdEQrU21GUUp4QTAxVzlNVzNqbnZ2ampuWU5GekdzSnFw?=
 =?utf-8?B?TWdRSmNBc1VPODhuR2dvRDhsQmN5MXRHemU3Qkc1akQva01EcFN4azNIZDBR?=
 =?utf-8?B?TUlEeGtPTlErR211TkN2bks5QTluUkR5SHR1U3pVMHpmNEpCRTZ3UncwK2gv?=
 =?utf-8?B?ajdOWWJVQUExc0w5MkhuazRSakVGblYvQnMzRTJPa3hwdEtxMW1nMklEVVgv?=
 =?utf-8?B?bmZmREFCVVZNSlh6UjBxVEI2eDBtSXovSmpkYmM2TkRqaVB2cng0NUk1Q0Yw?=
 =?utf-8?B?c3UrbjdyRGtCUVVLVW41VVg0cWJEbElUVWZDbXhLUjhTR01qTmNkZmJvU2Rq?=
 =?utf-8?B?amNhZXBzTWZuK0krVDdjN2l1a1dSZXBoUVNnMzlhWnZ6U0p0WjNlMHB6cUhJ?=
 =?utf-8?B?U1Nna3N2VHJBVVRpdkxaVnY5ajFUaUkwOVRMaVZJakZIcTdRRkpGbk9Fb0k0?=
 =?utf-8?B?bkpjeEpBeUxtS3M1QjNlakttSjdjUkV4UkdveHlvc0E1WG1KR2g2b3dsUkpU?=
 =?utf-8?B?SXE4OHV4NFViZCt1TE14dHRabXM1dXI0SDIvdjdXSnN6SUc2NUZ0dm9FSmlH?=
 =?utf-8?B?UFZtSzVYMHVlUlF6TnVpT2FKc1Zjc3VuNTZ4VThwM1kvWDlnQy93U1pTSVh6?=
 =?utf-8?B?d2dGdkFVWWZNeEZDdFhjaTBsUXhCa09Ybk1CdUpBaGI0MXBOZnJLclUxYitZ?=
 =?utf-8?B?RmlVbDJUV1lRaXYzdHhQTGFUVlp0Zlk4blZsWUVlLzZ3TVoweDZvV0lmMit3?=
 =?utf-8?B?MkdhZFloNWwzb2tOTFB2Y2JROS9MRWJFbXgyY01NUXlKZ2diWUIzbUUyTzZ4?=
 =?utf-8?B?aHREZ0U4R1ViVmtVYlBRMVpHQThNeUZhaVlacGQ1ZnV5SStBeGtSQWRrd0dL?=
 =?utf-8?B?eUd5YVBzOFU4Vk03MERlZStaSTlML1BaTmVBY1QrVGNuWjZEOEJyaUxWQzNm?=
 =?utf-8?B?dndkSVRwa1NKaWJoMVFXTGNnU0RDam82S0F6K2N6djBUYzFBYWxrdVBJQ2JH?=
 =?utf-8?B?UGhCWDczZE83djJ6WUVNTFEzSlBYQTdLTHdkQ3BVR3NnZjlEdVJyWGtyTkdL?=
 =?utf-8?B?NGNrZ2RZcmNTbWRnSXJPSFVhYWJHcVozWW0rT2ZhNENDT0tVTU5Hb0ZWMEhk?=
 =?utf-8?B?eXhMN0MrYVdzc21lRjlCRHZ5L04rcUhlMFNMdklpZVVqenVVSlVBbDNzdlVo?=
 =?utf-8?B?dkplUTB1ck9hdUR2VDVCWXpFeW94b3UrelJock1HL01Nd3Y4M2JSZXBxdGZx?=
 =?utf-8?B?WnVxcGhYVGRGRXpnZlIwRXNhNHQrei9OR2piS0thQ3ZBRGxtK25nMHNhRHJi?=
 =?utf-8?B?ZzB4VHRJOTBVT0RXUGpYSUdJYzd5NGxSMmZPVVpacE1aeUZuWVZTeVdialJy?=
 =?utf-8?B?Uyt1QkgvVHlLYkdzTytYU3Jxa1h6cUtpWFlpWkdXdmRyeFMxMEtHSW5HZmpU?=
 =?utf-8?B?WWYydzNFY2NGMEN6WGhOeEx4MjMvRDVTWEZIMjBseG8vYlU2b1NPSTNwZlhq?=
 =?utf-8?B?NWpEV3I0N1YveFEvVXIxb2lnanVpS1hwV0liVUx5K1UyMTNWODZUQm80V2ha?=
 =?utf-8?B?eHFDT0JUUjIzZHdldjdoTS9sL2phUVM5b25ZNlYzSm5heVJ1RjdkdExyNzgx?=
 =?utf-8?B?dEFQdFlHV3Z2K1dMWTg4djZocVp0WGdDNGtXbmVaemYyQzhNV0pWdkduVjJN?=
 =?utf-8?Q?pEdE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150b288f-9fc6-476b-a0c1-08dd96db3282
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 13:43:54.8996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8x7oKncJ0wLeOPgMyKmRgtR2j0anDgFe3G1erP4XHMvxASoUENx6K7ZWWByFwV5Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8031
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

On 5/19/25 10:20, Samuel Zhang wrote:
> add amdgpu_bo_fb_aper_addr() and update the cached GPU addresses to use
> the FB aperture address for SMU and PSP.
> 
> 2 reasons for this change:
> 1. when pdb0 is enabled, gpu addr from amdgpu_bo_create_kernel() is GART
> aperture address, it is not compatible with SMU and PSP, it need to be
> updated to use FB aperture address.
> 2. Since FB aperture address will change after switching to new GPU
> index after hibernation, it need to be updated on resume.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

I don't know the PSP code well enough to give an rb, but the amdgpu_bo_fb_aper_addr() function looks good to me now.

Lijo would be good if you take a look as well.

Thanks,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 23 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c  |  3 +++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 18 +++++++++++++++++
>  5 files changed, 65 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 4e794d546b61..3dde57cd5b81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1513,6 +1513,26 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
>  	return amdgpu_bo_gpu_offset_no_check(bo);
>  }
>  
> +/**
> + * amdgpu_bo_fb_aper_addr - return FB aperture GPU offset of the VRAM bo
> + * @bo:	amdgpu VRAM buffer object for which we query the offset
> + *
> + * Returns:
> + * current FB aperture GPU offset of the object.
> + */
> +u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo)
> +{
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> +	uint64_t offset, fb_base;
> +
> +	WARN_ON_ONCE(bo->tbo.resource->mem_type != TTM_PL_VRAM);
> +
> +	fb_base = adev->mmhub.funcs->get_fb_location(adev);
> +	fb_base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> +	offset = (bo->tbo.resource->start << PAGE_SHIFT) + fb_base;
> +	return amdgpu_gmc_sign_extend(offset);
> +}
> +
>  /**
>   * amdgpu_bo_gpu_offset_no_check - return GPU offset of bo
>   * @bo:	amdgpu object for which we query the offset
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index dcce362bfad3..c8a63e38f5d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -320,6 +320,7 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
>  			     bool intr);
>  int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
>  u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
> +u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo);
>  u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
>  uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo);
>  uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index e1e658a97b36..3fc4b8e6fc59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -871,6 +871,8 @@ static int psp_tmr_init(struct psp_context *psp)
>  					      &psp->tmr_bo, &psp->tmr_mc_addr,
>  					      pptr);
>  	}
> +	if (amdgpu_virt_xgmi_migrate_enabled(psp->adev) && psp->tmr_bo)
> +		psp->tmr_mc_addr = amdgpu_bo_fb_aper_addr(psp->tmr_bo);
>  
>  	return ret;
>  }
> @@ -1270,6 +1272,11 @@ int psp_ta_load(struct psp_context *psp, struct ta_context *context)
>  	psp_copy_fw(psp, context->bin_desc.start_addr,
>  		    context->bin_desc.size_bytes);
>  
> +	if (amdgpu_virt_xgmi_migrate_enabled(psp->adev) &&
> +		context->mem_context.shared_bo)
> +		context->mem_context.shared_mc_addr =
> +			amdgpu_bo_fb_aper_addr(context->mem_context.shared_bo);
> +
>  	psp_prep_ta_load_cmd_buf(cmd, psp->fw_pri_mc_addr, context);
>  
>  	ret = psp_cmd_submit_buf(psp, NULL, cmd,
> @@ -2336,11 +2343,27 @@ bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev)
>  	return false;
>  }
>  
> +static void psp_update_gpu_addresses(struct amdgpu_device *adev)
> +{
> +	struct psp_context *psp = &adev->psp;
> +
> +	if (psp->cmd_buf_bo && psp->cmd_buf_mem) {
> +		psp->fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(psp->fw_pri_bo);
> +		psp->fence_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->fence_buf_bo);
> +		psp->cmd_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->cmd_buf_bo);
> +	}
> +	if (adev->firmware.rbuf && psp->km_ring.ring_mem)
> +		psp->km_ring.ring_mem_mc_addr = amdgpu_bo_fb_aper_addr(adev->firmware.rbuf);
> +}
> +
>  static int psp_hw_start(struct psp_context *psp)
>  {
>  	struct amdgpu_device *adev = psp->adev;
>  	int ret;
>  
> +	if (amdgpu_virt_xgmi_migrate_enabled(adev))
> +		psp_update_gpu_addresses(adev);
> +
>  	if (!amdgpu_sriov_vf(adev)) {
>  		if ((is_psp_fw_valid(psp->kdb)) &&
>  		    (psp->funcs->bootloader_load_kdb != NULL)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index 3d9e9fdc10b4..bf9013f8d12e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1152,6 +1152,9 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
>  		adev->firmware.max_ucodes = AMDGPU_UCODE_ID_MAXIMUM;
>  	}
>  
> +	if (amdgpu_virt_xgmi_migrate_enabled(adev) && adev->firmware.fw_buf)
> +		adev->firmware.fw_buf_mc = amdgpu_bo_fb_aper_addr(adev->firmware.fw_buf);
> +
>  	for (i = 0; i < adev->firmware.max_ucodes; i++) {
>  		ucode = &adev->firmware.ucode[i];
>  		if (ucode->fw) {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 315b0856bf02..f9f49f37dfcd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1000,6 +1000,21 @@ static int smu_fini_fb_allocations(struct smu_context *smu)
>  	return 0;
>  }
>  
> +static void smu_update_gpu_addresses(struct smu_context *smu)
> +{
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	struct smu_table *pm_status_table = smu_table->tables + SMU_TABLE_PMSTATUSLOG;
> +	struct smu_table *driver_table = &(smu_table->driver_table);
> +	struct smu_table *dummy_read_1_table = &smu_table->dummy_read_1_table;
> +
> +	if (pm_status_table->bo)
> +		pm_status_table->mc_address = amdgpu_bo_fb_aper_addr(pm_status_table->bo);
> +	if (driver_table->bo)
> +		driver_table->mc_address = amdgpu_bo_fb_aper_addr(driver_table->bo);
> +	if (dummy_read_1_table->bo)
> +		dummy_read_1_table->mc_address = amdgpu_bo_fb_aper_addr(dummy_read_1_table->bo);
> +}
> +
>  /**
>   * smu_alloc_memory_pool - allocate memory pool in the system memory
>   *
> @@ -1789,6 +1804,9 @@ static int smu_start_smc_engine(struct smu_context *smu)
>  	struct amdgpu_device *adev = smu->adev;
>  	int ret = 0;
>  
> +	if (amdgpu_virt_xgmi_migrate_enabled(adev))
> +		smu_update_gpu_addresses(smu);
> +
>  	smu->smc_fw_state = SMU_FW_INIT;
>  
>  	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {

