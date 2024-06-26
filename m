Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BD5C27C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 06:24:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E81BB10E120;
	Wed, 26 Jun 2024 06:24:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HnGSdVGh";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27C0310E120
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 06:24:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1tRDr33ACcHnywrmFwdQET2iXhkG7ev464uVzeb2aDD586RxeFWyARoi0wpSCpwfBtUwoyWbofDmI3HUkRlX4vz3TefXWTr0NjZtY/o4SOFH/j/EAjCtKquJYB+kvozWhDQMlsgNwHox9n43TWBf6jvdHOLaEUjoGlolIerpfuYOl3/G26h4wDO5E9i//JnuXPQSXOmNlRKoAkbNrJ/zCCp6BtxFbz8IS43kJW+sI5w/Fe97vExA0N/BTD8HJRHR9md+RSHHjlu8TXjxLv1X50mE9fiMBMFM2M5ZY6VqjasMoGL+WKDvVYYd0BpqfH5NOU6+Nyk7H4BK4uIYvrqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRAiJ3ZG2Sul/maE3rZpXqC3CxpkCflkR7h0+yjngck=;
 b=mDWOKOLNhCGcuWWVP/EMGErRoWucXL9aiRX2AfYoGajcX35WqMMHMPkll2eS0H1SBv5g/YftkGb9W2/6bOag2dm93D9paCVgQAdM0A9Ypg47M5Ds32M5L7tFt1MigVtKZ9ijSSsyN5SmclksP9vwzk1bOoguUnKrQO3MtUvJRcqWRhW9d5zt46gBqiblDRc7VbxI/tg0YDvbQPO4ecTz0uchUbJcwPSMEPGM5t0gXfdmdqUzdNR0A4wigKiMzLl+vVmch8aqsu0WXDY4pVMV81ifZPmn3ocD50bmrbQuW9WzpFNTsTgKt54oJhwnT3YSQaMmvkPqARNA6bIPP/5lGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRAiJ3ZG2Sul/maE3rZpXqC3CxpkCflkR7h0+yjngck=;
 b=HnGSdVGhFFmgEnVI7TWXzMZNiNtMni0Nsmi7ZASBprhIORh68kI4NhQCy/8XsufHHUig7xM5Xt1qVfAdux+7sqKdELxo5Vx9baOV4cj0O5KTysceFYOdNADJzxrHC4G/JbugAnsNGG743Kg7RmF6WBSCR55OLNrufjC6wXisFk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.31; Wed, 26 Jun 2024 06:24:08 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 06:24:08 +0000
Message-ID: <87f73a1b-e869-4721-8430-1daa8ffbd5f3@amd.com>
Date: Wed, 26 Jun 2024 11:53:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: normalize registers as local xcc to
 read/write in gfx_v9_4_3
To: Jane Jian <Jane.Jian@amd.com>, christian.koenig@amd.com,
 Haijun.Chang@amd.com, Victor.Zhao@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20240626060151.2554500-1-Jane.Jian@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240626060151.2554500-1-Jane.Jian@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0170.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::12) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM6PR12MB4436:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ae9d742-1b1a-4efb-0c6c-08dc95a895da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGRGemVKN2N0R3pWSS9VUUVNMXRCTzQxM0ZIZlIwdEFBT01ycGxaTU9PWTF0?=
 =?utf-8?B?WUp5N1VhRVF0Z0ZFZWFUZ2p0amxqUFg5U2l1VDFxdkVjTmRGdWx0YnBwUVRn?=
 =?utf-8?B?cW5PRForVmpZckc3UjZJRDNQQkZ2N2Q3TVFiaTBMWGhDaks5SkFHbWlYY3U0?=
 =?utf-8?B?aTBXeEM4WmRldVVsTW4zOXNablZCV05wUnYxdlBpckFXR1pZdU1lLzRxWGFs?=
 =?utf-8?B?Tmw3RzhyNllMdkFaQmNkMVFudENhUTNLblBldnczbXpDa1NyL2dBcmdDNUV1?=
 =?utf-8?B?Q1B3KzFTaXpCTXpMZFNhQWg2U3ZsRG1DZmJmUzNQUnc0MWg1NnlvaWxQUkR6?=
 =?utf-8?B?YVoyakx6bEhiZFh3bGdoU0djTFNCUVFhcUhSRk13aFVlUFRuS213MTNWc3Vk?=
 =?utf-8?B?S2pSZzJiVHhwWlY0dXRpRXc0ZHA4QkZkQURQNHFSeGJRSjlzWTYyKzRyWVpr?=
 =?utf-8?B?UUhJcW93emcxZjhqMDJnN1M4ZTBuN0dTV1piekdjU2psejhXN0wxZ2NpaVp5?=
 =?utf-8?B?NVZFQW9vSzNFYUI4MFdtK3dEMXVKWGRPRzRuQVcxT0ZwVWpqWTJYKzhYbjdm?=
 =?utf-8?B?SzUyeE1qdWl5R1JJU2NYdWhIZWc3bXBzQmR1SDhWRWtCOWMyV3p5aWMwRlh5?=
 =?utf-8?B?RGt5WTVXdEVtUlJzOERDVDNlQlNCK1dtWXBndU5FR1ZyOUFqQ3NIRW9OMzFI?=
 =?utf-8?B?ZkJocHVEN1NudXBSb2Erd0xUcEE0TTFpaWQxN3RkOUhHQkovMXdTSTYxT1R2?=
 =?utf-8?B?dC9qWHE5T3IxbEFQSVozVmxpNnlNMFJNSFZ4dnNqeHI5VXkycWM4ekZEUmZx?=
 =?utf-8?B?UXVKTDdnUDBvZDRqUkJGaG1Pemh3eXJ2bHRrQlMrYW13ZCtQR01KVGNZbWZi?=
 =?utf-8?B?aXRUVFFFaHZxd09xUW1jZFFxcnJ5cFZUY0taVWJyZzE0OVRnOTRYQW1sUCtK?=
 =?utf-8?B?RElLTWoyT0VKRmJRcVlNTmxweHNWd0Y5TjRPbGlqNTFJbnpXendrelZ4N0ND?=
 =?utf-8?B?ZHNKeThFS0xzdmhCOGY3L3p0WEhkTVFrNlBjVkhtbzBUL0t2UVloOUdDd0Rp?=
 =?utf-8?B?NTA2NGJjeVJJQ0h2NldxMlA2NjNsVC9hSFhwT09RdzJHMzhOTjhsOGpFT2pS?=
 =?utf-8?B?WUhMZ1h5WGhBUWpXWURITWdFdW43QUlQS0M1MUdDdXJxUit1VFVRb0tENCtF?=
 =?utf-8?B?ZndqQnptL0RSOUdFcStHV044MkxWSVdRTFFQZS9ZS1BOK3F1aXJRb0dnN2M5?=
 =?utf-8?B?ODJEaTJwalJXMGFvL1ZYa2ZtdlBzVlVsSEd4MlhQTUV1TC8xMXE1YmUwZXI3?=
 =?utf-8?B?K1dKRW1KRTNIdmtNWFFyTmI2L2E0a09JcXlCbXROR2pQVGVoOGxKVGlhR0tq?=
 =?utf-8?B?S2R3cUFka3BJbE1SMkNrQWI4b3pMeWVzYTJsR096b1p2aHFTemhFSFlnTy9h?=
 =?utf-8?B?cHB5MWRTa1hYWGowMk1PRTJkVGV2eHgrRHlWTmVzdHdSNUlUS2RJNGxjVDFW?=
 =?utf-8?B?TmRsQ0YrUDFabnh5dElOdWQvMHNqUGtHNDg3NjhZbkxRN2oxYzVnNy9pdXNG?=
 =?utf-8?B?YmdJYStJMmRicVhWaXUrcmpKTngwemRoUnluNUNnVUF5K2k0RmhUU2NSdkVX?=
 =?utf-8?B?RE9LeUwwVm9oYjhzQmF5R25YQXJHa1RScFZocEFxN1lMempjeUowYWViQmFK?=
 =?utf-8?B?Y3picXBGY2pPN0tUVkRLc3BLKzhvT01uRXJiRyt6b1NjZlVMZHdERyt5SmhP?=
 =?utf-8?Q?OeSzvEY0Zxy/WK7+Zw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230038)(366014)(376012)(1800799022); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGd4UWdOR1E0RytPSk0ySXRmMWh5N3pPMDZXYXBxL1FXaFlVVlQ2Y1ZobVBH?=
 =?utf-8?B?L2JtS0Y5TVFIdjZHc0xMV3JoOVgvd2FMMDhISkJOeXo1dStvTEJvTkxIU3ND?=
 =?utf-8?B?NDFKUEsrblBFT0xtdUpYVndIQllQS1dld1JHdzJPMFF1MTZRc3N2U1ZhekF5?=
 =?utf-8?B?MVcyaG5aSVVTZjB0dlVLd0RvaDByd3o2T1lVa1NYTGU3YTAxNFRlazg0SVJw?=
 =?utf-8?B?Q1FhaVJrbDA5UXg0bDREY3BJeGlDbHQ0bGZzZzhKUUkzSVBqcmhSNHFxRndW?=
 =?utf-8?B?bXNLQjcwMjd0emo4N09DUlJzK2xnM2g1bDhsZnJYNGFRd01tUERXV3VRd01Y?=
 =?utf-8?B?c3ZTblgrMnFlRFMzb1UzNkYyNUdJL1B0RlhCODRaNEJzNzRxais3ZnhtUlI5?=
 =?utf-8?B?cVZiMlZXKy91TSs3SDVreTZ1TkhlS2dNdDZUdlRTM1RDM1cwK2kvSnVVUkIw?=
 =?utf-8?B?U0NXdWVuRHVNL3l3dkowcGtwaGpMLzc1UHZtMTJtdkZ1alMrUFoyZmswQm8v?=
 =?utf-8?B?MFF0Q0UyRTRCRFFNdUhNSUEwbDJmTDFqbmN5NkNZYTQyUXRteFB0USt2SzNV?=
 =?utf-8?B?bis4Q0VnejZSVDhQeGxUU3NlbzIzTHFIYWdrSnVNMnlwVlZzRWltRHNvQXo2?=
 =?utf-8?B?WGgxRVRaeGI4R1ZkSDZkL2JuMzFCOXBsbGJNNmhHTGtMWmJmRWwwY3dSMkl6?=
 =?utf-8?B?MlUrbHYyVnMyQlJxeGtmS3FhNHZHL0tSTk92Z0MySm44cFJyaTlMb2N0bEpK?=
 =?utf-8?B?RU8rZ0U2TTB0Zkw4WGIvWlFqajlJZnRva2QyU2FoaVlOVUZqZ2tDc1hZbi9h?=
 =?utf-8?B?RFlqdmJQV2tTU3Bmb2tBUkxmRnlPMDd2ZXpXR2RtMmg1d01yVG9iS0JZOU5m?=
 =?utf-8?B?V0I1RVRibVZ2S3RsVW9nK2REd0lvbjMyYTZLUTVqZDNMMFkzejZpWUIweFhw?=
 =?utf-8?B?Y096RTQzZzZZTzh5cFRwU3JuSGlHUGVNTVBld1E1QUphUHJsRTgrNUR1Mmtq?=
 =?utf-8?B?LzFrU0NCZy9FVXJ2VE1OV0dJY0ZDUmFxZkNCL2NNZzNaTUQxRkZlTVMzRHp3?=
 =?utf-8?B?MENpWFEzYnZuRXFtUkxFWDBMQVptMGI3MEZ2azViY211RjFVWmJ0Lzkyclls?=
 =?utf-8?B?MHczOFp4NUN4bkl0VWdvd1I0WTFEN3JUT3JuWWd4NkRNQW1FcTV2NURwOGpt?=
 =?utf-8?B?U3hzVWZFSmZSdW9vSjU5TDRmL0FncnBFbitoN3JDZHVKUUlaaXdHQWd5L29o?=
 =?utf-8?B?VzFkejRWenV3Nm5TRWdyeUQxcEhMWEh2U0tJd2ozRCtWbXgxQ25Jdm5LaGZk?=
 =?utf-8?B?aHQ4TFdmSkE1QmV0OTRKZzl3UEs1NVlWeE9pTHFIWUhoMXV5ZGlzZWhIZUJQ?=
 =?utf-8?B?M3VrMDJVUTcza3FuR3ZuYjRySFExU2xwY2hkdjZLVmdaTS9uMWovLzRaNXI0?=
 =?utf-8?B?MUkzSUlreEh0WVVaWU41TjZUdU1md3MxME9lQjJGVVUvamxnaS84ekdrY2hy?=
 =?utf-8?B?ZFNybHVUSmg0MFl4eXdpeU5wc0N5M3ZxendzM0V3UXJMZ3dLUXBaV210dFQ2?=
 =?utf-8?B?Z0p4SDc0dVFiZWlBVVdBUWptY0c0MjdiczlnYjIzKzJZVXRRT0MvME43dUtV?=
 =?utf-8?B?bnB5YTFLeDBWc3FiMkhwUVhuVmV2alJhWThTTDNpeUNxei8wZlRmUzd5VGEr?=
 =?utf-8?B?aHhxVUFWek95alJqT0xjVUExK3hrbDArdjlJZ1hzYVZoQS92U1o5eHUxd2h6?=
 =?utf-8?B?N3k3M2o1d2hGdGFndDJiMzRFamhPZXJSRTNzRjZ6TzV6NHMzL3V5UWFlSXNt?=
 =?utf-8?B?RGdDV1VHUGpXV2NDaG1tOXNZRkRRMFM4RjQ5cDVWYXkrZ2o2UmdlYXFFVTVH?=
 =?utf-8?B?UkhmaHVSSHFKMmI4WURPOXBEQTN4TC9FTHJsTGZmTEpVcUFVSlBXeTMwYS9k?=
 =?utf-8?B?ZUE5VTZsczk0UHZ1WDF0eUJ2c1dCbmtNUG5XY1dDU0oxWWRkZjBYY05KU0Fo?=
 =?utf-8?B?QTdieDhBcHJkeDZIUzY0c3hWLy9NempxVWJSOEZNU05qMTFLVXFzTktuTUVZ?=
 =?utf-8?B?amt3UjVlaUNjU3dldkFRN2JkMjd3NEdvcjgxQ1BvVHhSV0IwZSt2VTBLQXpN?=
 =?utf-8?Q?ne/FclDHm1hQOs9UUvWi0wV0b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae9d742-1b1a-4efb-0c6c-08dc95a895da
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 06:24:08.4590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYhIvz97GcwfyTXgr3ZutkZeJ6SLXkxLhGxLbu/xu9eL/qU5NBdpyNv+/bUrhTrj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
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



On 6/26/2024 11:31 AM, Jane Jian wrote:
> [WHY]
> sriov has the higher bit violation when flushing tlb
> 
> [HOW]
> normalize the registers to keep lower 16-bit(dword aligned) to aviod higher bit violation
> RLCG will mask xcd out and always assume it's accessing its own xcd
> 
> v2
> add check in wait mem that only do the normalization on regspace
> 
> Signed-off-by: Jane Jian <Jane.Jian@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 33 +++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 8d8763ebe027..1149595a02d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -55,6 +55,14 @@ MODULE_FIRMWARE("amdgpu/gc_9_4_4_rlc.bin");
>  #define mmSMNAID_XCD1_MCA_SMU 0x38430400	/* SMN AID XCD1 */
>  #define mmSMNXCD_XCD0_MCA_SMU 0x40430400	/* SMN XCD XCD0 */
>  
> +#define XCC_REG_RANGE_0_LOW  0x2000     /* XCC gfxdec0 lower Bound */
> +#define XCC_REG_RANGE_0_HIGH 0x3400     /* XCC gfxdec0 upper Bound */
> +#define XCC_REG_RANGE_1_LOW  0xA000     /* XCC gfxdec1 lower Bound */
> +#define XCC_REG_RANGE_1_HIGH 0x10000    /* XCC gfxdec1 upper Bound */
> +
> +#define NORMALIZE_XCC_REG_OFFSET(offset) \
> +	(offset & 0xFFFF)
> +
>  struct amdgpu_gfx_ras gfx_v9_4_3_ras;
>  
>  static void gfx_v9_4_3_set_ring_funcs(struct amdgpu_device *adev);
> @@ -217,9 +225,24 @@ static void gfx_v9_4_3_init_golden_registers(struct amdgpu_device *adev)
>  	}
>  }
>  
> +static uint32_t gfx_v9_4_3_normalize_xcc_reg_offset(uint32_t reg)
> +{
> +	uint32_t normalized_reg = NORMALIZE_XCC_REG_OFFSET(reg);
> +
> +	/* If it is an XCC reg, normalize the reg to keep
> +	   lower 16 bits in local xcc */
> +
> +	if (((normalized_reg >= XCC_REG_RANGE_0_LOW) && (normalized_reg < XCC_REG_RANGE_0_HIGH)) ||
> +		((normalized_reg >= XCC_REG_RANGE_1_LOW) && (normalized_reg < XCC_REG_RANGE_1_HIGH)))
> +		return normalized_reg;
> +	else
> +		return reg;
> +}
> +
>  static void gfx_v9_4_3_write_data_to_reg(struct amdgpu_ring *ring, int eng_sel,
>  				       bool wc, uint32_t reg, uint32_t val)
>  {
> +	reg = gfx_v9_4_3_normalize_xcc_reg_offset(reg);
>  	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
>  	amdgpu_ring_write(ring, WRITE_DATA_ENGINE_SEL(eng_sel) |
>  				WRITE_DATA_DST_SEL(0) |
> @@ -234,6 +257,12 @@ static void gfx_v9_4_3_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
>  				  uint32_t addr1, uint32_t ref, uint32_t mask,
>  				  uint32_t inv)
>  {
> +	/* Only do the normalization on regspace */
> +	if (mem_space == 0) {
> +		addr0 = gfx_v9_4_3_normalize_xcc_reg_offset(addr0);
> +		addr1 = gfx_v9_4_3_normalize_xcc_reg_offset(addr1);
> +	}
> +
>  	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
>  	amdgpu_ring_write(ring,
>  				 /* memory (1) or register (0) */
> @@ -2725,6 +2754,8 @@ static void gfx_v9_4_3_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  
> +	reg = gfx_v9_4_3_normalize_xcc_reg_offset(reg);
> +
>  	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
>  	amdgpu_ring_write(ring, 0 |	/* src: register*/
>  				(5 << 8) |	/* dst: memory */
> @@ -2742,6 +2773,8 @@ static void gfx_v9_4_3_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
>  {
>  	uint32_t cmd = 0;
>  
> +	reg = gfx_v9_4_3_normalize_xcc_reg_offset(reg);
> +
>  	switch (ring->funcs->type) {
>  	case AMDGPU_RING_TYPE_GFX:
>  		cmd = WRITE_DATA_ENGINE_SEL(1) | WR_CONFIRM;
