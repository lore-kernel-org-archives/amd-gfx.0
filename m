Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7015BC36000
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 17:27:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C626910E7F9;
	Fri, 21 Mar 2025 17:27:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2b1h1Ek/";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BB2B10E19A
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 17:27:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMBbVrTF00bNu+zGycvJYjcVZ8Pjym1gBQ6ky3trrDHNwb5wQ5xHo9K848ulkczXuzOCLyxUb0wh4qtu6bl2VqNTQqaI8g9gbFGdebviUgddKGhL8o+BUaHsxZxWGK+aEfwwR4dQ5BgQmRu4osS2FdFvKfeG730hBCmC2Q3fOzgz3+31i1AXOmpeMSGK8/Vh9SnLUfmkN+qB8FEpKMwD680vPbOorougKUv4ki7aI2ARRPocpcPE14oq36MaGWShFA9Pr8ygnJrGYW5hMCzE2g4NcbYXbJ2wDqbZ43pL2J9h0AVH92JVzsyDZ1T7CKDHzhmceeqYf/mFRwsGP7gWmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnYuzxZaagIqXKMejc+uNYP0Bd7RRhJfzX5MplxoX0M=;
 b=yo+oeoY1qC7S9AAPTdg0pxLNR46cH++f/bgBw+bgP1w34C1iLHbEeqcktwUiqtcvMVpynmcEJLGVHgUqdToREU/N/KuKPxdfljD+W/b1Z7B1psd3yqXSSsy+a434ZXFCYoePTGo4tzkVaaCaF3t3DEtYJlmhalb/cbnPLQZIHnNM185KLRzr7VlQ8/fbrhdN+0ETGc3d1vrMDVoJhsQSFyzXFXFRzBAx5931Bz2yJYbcNCncpEwqrRFdZCeEmcK5QYJ5n3KQgIG0UDCaVZIEqj+z2a0cPPNUtT+SH/pTnIK5+irJt4gTAXa4IP9rJPgUbqjYM0HerdJFNiN67D1WRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnYuzxZaagIqXKMejc+uNYP0Bd7RRhJfzX5MplxoX0M=;
 b=2b1h1Ek/Gsh7E87jqHJfEl4rnvLGKAVBjkcX1qgNfpG6rrQhrQrdSrbPxBqfhCmEuKp2VaLpTQ97qt4Z5m+lrd/0LajFN8vxrl929d0G3DEdzNHbmiWAzIK4SveGPYoum48jbKt39gKYJ3RFMovW9ZtnxKqgu5A7tzCZ/AQyXJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Fri, 21 Mar
 2025 17:27:10 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%7]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 17:27:10 +0000
Message-ID: <d705924e-7ec1-4690-9745-a7646caa1c05@amd.com>
Date: Fri, 21 Mar 2025 22:57:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: store userq_managers in a list in adev
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250320165249.1238463-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <20250320165249.1238463-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::19) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|PH7PR12MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: bd2aa4f6-f2c6-4d6c-313c-08dd689d9c90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVRGN1ZiT1czcG5FTm1EUGNqWXJnZG9GS3BLakluTm9zeTFMSlNSQnZXSjNI?=
 =?utf-8?B?WkhYT3N4NEFOeGtETHpkVmErN3IyREZrU0dKenE1S1djVDFaaUZiVUtSRytj?=
 =?utf-8?B?NnZPWXJ4bFh0NXpWZUpFNWk5Zkp6YmF3UkMxMXhWeVBTSS9YOEcrSnR6WmdB?=
 =?utf-8?B?RWF4T09sVTl1aGJkTzRxSkVlRFl0RXE5UVlDNEN2RCswNmpFNnpNd1ROSHFk?=
 =?utf-8?B?VThxT1E5WGtZOVhxZ2JTSXB6U0E4Mko4NTdrWW9FYTVLYWM2RmYvSnFvY2FN?=
 =?utf-8?B?OE1acjl2VmlOMmtnR3RFTFNGOGxjY1R1bkNYUVkyYnR3aHkzcDBpU0k2anll?=
 =?utf-8?B?OFcvaERFQXlhQmNZRENOTTVJaTl6WE9jQ3ppdHFJUWNuSXpyS1J2ZTJ4R09W?=
 =?utf-8?B?Nnk1cFlCOE0zR29rT3BlbEFkN25JYldiUDFYdmwyZktkaVMzUlpkYUJRcGE5?=
 =?utf-8?B?SjBPUE14LysyZkxRRTFMQlZHUkQ3czkwUW54VStpQjFEUzg3dk1iTGNoUml0?=
 =?utf-8?B?OGJxbS9aVlN0eDBSOEwrUjU3YVJySkM5c2RSRFFDaHNPS0gwVTJkZWtZbG9X?=
 =?utf-8?B?WjVnQ25JQjFQak9DbkVtVmZCY3lsV25obFZ3QlFMV2c1TkJCRi9vVGVKT2c3?=
 =?utf-8?B?SlkyZzVDOUlXTkxiNW95bG5zcDI3WSt3VlpvdlF5Z3BuSTJSdTlGRWhoUHhs?=
 =?utf-8?B?SG0zK1hhN1ZBTVNBZTJMeEdGMWtxVGJkbjJMemlzZmIxakVoOTVHZ0d0ODNm?=
 =?utf-8?B?SzJjQWNVTXdlNC9FRGJDbGFlRUFKOHdtZzdEbUwvbXh3MWMvblA1TG5PRXIx?=
 =?utf-8?B?MDg3OWFsU3pma1IvVEVOYVZwRXRjbTJKTFFqYUg4d1cwaEltaE81TGlXcWRk?=
 =?utf-8?B?NG1tWmwxUTdMYUF4L3RmU3pqeU8vSHFVVGlkTXJzV0pGUFFhU0paQnRzajlD?=
 =?utf-8?B?MmQ5clUzNUFENHNoL0ZDUXJlNlNGQTNhTFhuOTliYUR6M21SeTNVSzE4OVA1?=
 =?utf-8?B?VkZuenMzTEZVL3J1elU0QzExTkIrL0RMUlQyd1UwTmVCTTB6bFBtM2lQc3NW?=
 =?utf-8?B?VS9JNUhEYmhhTVYwNXJ2bjZ0aDg5eHFGQWFlUTI5NklaaTQ4bkRPdjZ2cWw1?=
 =?utf-8?B?N29aaS9hVVphaDV1Z0V0QzJ6bW9YUXFmZXZ2TjdTUlNsY045ZnJKMzVIMndW?=
 =?utf-8?B?S04vV0U2MlBKdTNVTmNTeUt2blNTeFRkdEFEenRLdFpsQ3BFQ0tIaXd1T3g1?=
 =?utf-8?B?V0J6a1A2ZUk1Nno4dEljaXMraUkybUlvekxVVG1MOUlNamJFLzdLY3FIRFlz?=
 =?utf-8?B?TzcrSDBxbG9DOHJod3VEQTBnaFkyVDI0MVZGU2dUV1VyZXJpSHNaQVM1d2dJ?=
 =?utf-8?B?aG1vR3pMcm1mbkZDUGpKUzBKT2t1TTY2cHBXdEtNY0RuVERyUjRRbklnQlJU?=
 =?utf-8?B?YzBBdVNCNjJrWHh1aHB5NWNBeHdsUTZwWlZNSkhEN2FFdTg0c1llVmhzT2hu?=
 =?utf-8?B?VWlEWDdtSHR2eDB2TXRLaVpIZU5GTG5SalpYdW9Ddi9xTjlDbTZRVWV3eFly?=
 =?utf-8?B?dmxYdGxTTDBHdmVwWU1iU3B6RVZpTG50RWF4TFg3TUxENUd1eVMrTVorMDZa?=
 =?utf-8?B?Z0ZxNkRnaWx2V2dXR0Q3OFIzNHVEdlB4SjRYM1BFeWZGcmltSUdrZGV2N0tv?=
 =?utf-8?B?ZWJSSUtjMWE5ZElkS1NydzlBNXREaUZKbXdhR0pHd1ZTcTVGd3J5MWlRVE1k?=
 =?utf-8?B?Q1FrcWJDSDBIRTJWaGU1TTlUUEE3VkRpV0wyZmhQaU5GT3A2bWdvMTNCbSto?=
 =?utf-8?B?MHdIajl2dTZHQUpxL0g2NG8wUG5wTVVpYVVFWUUxVGFJTzkrcG1Ka1BwZUJS?=
 =?utf-8?Q?WgYslKOaypCUy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkNTUHZEbzBqQ0pncTJRS0xvWU5MQ24zUWxCdEx1SzFBc214ekg1M3M5d2FB?=
 =?utf-8?B?blVWZTkxM1pDWXFKcG5lMTNEd2xRME5KdEZwV05raXFBUVVTSzFVc0ptMnkw?=
 =?utf-8?B?RGFPZG9UYXRSam55dzdpU280WDFna0hncG5FWUNxZ3IrOWw2SDl6VGtGMng1?=
 =?utf-8?B?Tjc2NEs4V2ZlaE9mcmcramlHL1Fkc2NaS3NnODJvMVg1RzBxTEErMTJFcjg5?=
 =?utf-8?B?c212cTNRNS9aeFV1Y0V2N0NRMUQ5anBrVVBpbXZsQjVXTnlIVTlGS2pEakZS?=
 =?utf-8?B?eWh6QjhWV2RsNWpsQUNweHVBWkVyMFJBR25jZnd5VmF2TFFDQythcVVpcXI3?=
 =?utf-8?B?UkRTajEyaEZ4VlJOY2dRcDBzMmdETTRFSEs3R3ZpaURRRndNK2VZZ2ZXU3o2?=
 =?utf-8?B?WVhOWjJsYXFPcjgxN2tZRFh5VFFkRkRiQXZGeTd4SUxPVnEwU09FSVJsRWo2?=
 =?utf-8?B?MzJXQVo5N01ZanlqQ3UvR3ZVbkJEVzh6M09kK1phb08weGNOZnhhVGdHY0lJ?=
 =?utf-8?B?RVFrZUlNaUxaYzVKSDZuTm5mUGhjS2t1MzBzMERkTnRnU0tJeG1DK0hhQkFh?=
 =?utf-8?B?bzcrWklERDBWTkQxS2cyelRxS0FWdFU4dHUyN09wSEQrKzVmc1pRaXAxRUlv?=
 =?utf-8?B?bk5lSXZnNkNrQUM3Zy9xUjF5ZmNoTUVXS3YrVXBpLzJhZDhnZVI5dkNNVm5v?=
 =?utf-8?B?NTcwUjFtR0NYczM2RXoyYjhrb0xYNHJOT21wdVRabGkyUjllMllBaDhVTHht?=
 =?utf-8?B?SXk5cmFKeU1VclNJYUROZmREeE1OcnVaMWRENlBiRWtiekIveE84bFNESVNw?=
 =?utf-8?B?alE2UGVmNXgxT2ZjRWlUY2NoaGllUUlGRzBldE4yT0pOdnVJWkJKZ3V6QStq?=
 =?utf-8?B?TlpZL1EzdFFMSE1oYks3TkJueUx4T2FUSVcwV3FWc1RxZmNraHpDbHlacGNY?=
 =?utf-8?B?cnUxOVYzeFJNRE4vUElPKzczajBFT0JMUzJKdW1BOEVXZ25xa0pySklMRXUy?=
 =?utf-8?B?Qk9rR0dDV1FHN3ZDUTlKdHRrVGxZaVNhbmRzUWlLSmppemdrMXVzMTA2Tjky?=
 =?utf-8?B?U0NDQXczNWxIeUFNM3ZjT0JFKzVleFkyamNpMHpJejI1aWtObEZNeXozZ2o0?=
 =?utf-8?B?TmFpZHF2Qm84bjhRWGRraEdLU09WRlFxRTJVSC9xRlZVZzJhZHJveGw2Y3M5?=
 =?utf-8?B?K25KeDE5VlNuNG9ES0NzanJhU0RGWVVUVHRhdHE1alViT2lDRnZWQTZFZ0Ju?=
 =?utf-8?B?R2wwbmpCNDlHdUo3MHFvUzZmNVdUbnRDcDJWS0FKeTJtcFRDVFR3SUl3OUJ3?=
 =?utf-8?B?TTMrbWEyUDFQZ1ZJS015Ry9sbGtWMW5XR29leHAwbEpEbWY3aDJhLzJKOVhx?=
 =?utf-8?B?MmNEYzZxZ3Y3V3haR0VUVW1nNkU5dUJndGFqelVOVFljaCtnU2tLRnBSSkt1?=
 =?utf-8?B?cTViV2FYaEp0RVFycTFwVkFRUys4cHZsV0IxNWNBaC9Hb1l6ZzdEZTBiQXVv?=
 =?utf-8?B?U0dHOVZMdU82TjhQczFaUE9mYkdrN2xIVTN3L0VONDRYb3pMYVpnOWF3anNm?=
 =?utf-8?B?amNhYVVxQVB6TERtUS82bzNIM0wvOUQ0MFJPQTYvdTcxelYvbXBxWDZwZW13?=
 =?utf-8?B?MFdobUZsQlozdHRSdlU5UUJPcWdhSDhPRHlTNzJmdXk5dHlwSzBXWWFRSnpo?=
 =?utf-8?B?WWVaTkNvVEV1ZTdQeWxscThSd0I0U2ExNWJuSExFditUWWt6c2tNajZqVU9F?=
 =?utf-8?B?VUFzNzAxOUFJMmJ6UUR6enFiTXRpenowSmgxYkNySDZwbGlxQWNKd2VEV21o?=
 =?utf-8?B?UnQ0NEVld1NlV043UjM2VExrUk5RTlJkOUc1eEc5UVhOdWJvWEZHdyt3Y1hH?=
 =?utf-8?B?dE82bUxpaEJlZUltbktTeDJPYzc0QjIvL2lBelkva0wyQjZyaGwrRjB5NThh?=
 =?utf-8?B?eUR2bG9xdm93c29mZmNvdlFUa3hmZGFoRVlBOXQra05Pd09pcmJOcnJRSDY4?=
 =?utf-8?B?Z2xsM29QVzJSa05FeW1aa2dUQ1pNWm1uNlMvTEdlQ01JTThRRytWT0tUU2M1?=
 =?utf-8?B?RnZON1hEb09NNUJqZktDcEMyNEpiVU0rYW53dU9KZHZtejBvNTlzZndhMVVC?=
 =?utf-8?Q?Krqs2q7y+aK5jb/TD+aQ4oHRm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2aa4f6-f2c6-4d6c-313c-08dd689d9c90
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 17:27:10.5333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8NXn96sSqbXOSumZ5UBs2V0N6jo9ZFqFqQvVURhtoqcfKe6vgCk7Fn9hwxy/CuNbltY/iTLFUmkOSklo+fTAkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6396
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

Hi Alex,

I requested the tester to reproduce the suspend/resume hang issue with 
this patch series.
I will update as soon as I get the results.

Thanks,
Arun.

On 3/20/2025 10:22 PM, Alex Deucher wrote:
> So we can iterate across them when we need to manage
> all user queues.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  3 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 15 ++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h |  1 +
>   4 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 4f770a362048a..28cfa600b798f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1228,6 +1228,9 @@ struct amdgpu_device {
>   	 * in KFD: VRAM or GTT.
>   	 */
>   	bool                            apu_prefer_gtt;
> +
> +	struct list_head		userq_mgr_list;
> +	struct mutex                    userq_mutex;
>   };
>   
>   static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 0396ac30c2a4f..526c5aa32825a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4299,6 +4299,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	mutex_init(&adev->gfx.kfd_sch_mutex);
>   	mutex_init(&adev->gfx.workload_profile_mutex);
>   	mutex_init(&adev->vcn.workload_profile_mutex);
> +	mutex_init(&adev->userq_mutex);
>   
>   	amdgpu_device_init_apu_flags(adev);
>   
> @@ -4326,6 +4327,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   
>   	INIT_LIST_HEAD(&adev->pm.od_kobj_list);
>   
> +	INIT_LIST_HEAD(&adev->userq_mgr_list);
> +
>   	INIT_DELAYED_WORK(&adev->delayed_init_work,
>   			  amdgpu_device_delayed_init_work_handler);
>   	INIT_DELAYED_WORK(&adev->gfx.gfx_off_delay_work,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index a02614cbda36e..b89bfad52abd5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -365,6 +365,9 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   		goto unlock;
>   	}
>   	args->out.queue_id = qid;
> +	mutex_lock(&adev->userq_mutex);
> +	list_add(&uq_mgr->list, &adev->userq_mgr_list);
> +	mutex_unlock(&adev->userq_mutex);
>   
>   unlock:
>   	mutex_unlock(&uq_mgr->userq_mutex);
> @@ -661,14 +664,24 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
>   
>   void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>   {
> -	uint32_t queue_id;
> +	struct amdgpu_device *adev = userq_mgr->adev;
>   	struct amdgpu_usermode_queue *queue;
> +	struct amdgpu_userq_mgr *uqm, *tmp;
> +	uint32_t queue_id;
>   
>   	cancel_delayed_work(&userq_mgr->resume_work);
>   
>   	mutex_lock(&userq_mgr->userq_mutex);
>   	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id)
>   		amdgpu_userqueue_cleanup(userq_mgr, queue, queue_id);
> +	mutex_lock(&adev->userq_mutex);
> +	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +		if (uqm == userq_mgr) {
> +			list_del(&uqm->list);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&adev->userq_mutex);
>   	idr_destroy(&userq_mgr->userq_idr);
>   	mutex_unlock(&userq_mgr->userq_mutex);
>   	mutex_destroy(&userq_mgr->userq_mutex);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> index 0f358f77f2d9b..ec1a4ca6f6321 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> @@ -76,6 +76,7 @@ struct amdgpu_userq_mgr {
>   	struct mutex			userq_mutex;
>   	struct amdgpu_device		*adev;
>   	struct delayed_work		resume_work;
> +	struct list_head		list;
>   };
>   
>   struct amdgpu_db_info {

