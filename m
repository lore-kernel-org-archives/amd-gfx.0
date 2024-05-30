Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5546DC25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 14:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7332510E1D4;
	Thu, 30 May 2024 14:11:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ab4M+mtd";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2374E10E1D4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 14:11:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPvGG6jAPK8mzL4HOAZ16vknN0iqA6Mldi9TDvprSOVDkboeexk9LTI5JGrw77CZ0w5mX8d1G9J9Qtvhdz6u8iV/dvzwkxIRvg1INDwmNlihMMcZsoHpb4kl8CWKo+RJgPfAj/i0qgyJtDPaOheFyU0yiSw7S7jC9bsEjv56sSiWU9Yxjut6Me0Cq41Wv3048ate3x1eQP1LcYUU4mSnSGf1v8QyzqG9YfKM3hmggG421/CdUkaWfxujthTEhupQrpLnpbJ+Jrpis2PPVXE/tz1QOlgLHDgvZT7aSE6DEiJKcsCgY26wvA8NrM8IzwFopUZwnezDCP9CDeH0WK9w4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rZRMMsqhFoxwK1PvajkRFKe2q5CudgdYw0a3Be9dHk=;
 b=mWFdHNkVWBe/G/2oOUqIZW9s8NT0WtifLiD7XDCO1gpc/Wa+nf8p+boMHqqOrYh2oU7/35vXMazXvfwf1M2t6VBYLylpA/VudfoL3PI/KZDjIOSmwnydoqgY3fJa2tPx9MlV9fYYsWoryClpoCgEmTNMbPBigDUq2bbvPTF+lKWdh7k7rda/G/ljPC8vUzdntM3KN4h9An97FUK8+tvLC3W+qmNBuExqvTIJwYjxECncNMumTIVMsiIa2cVFB/1gZu1Fl2+3cJlzy4yvQQzQOJZIVQa4VpQDb98oxO4MliIrkcNjct3jaF5uaPfDV2DJubMMqoasituJ0+GPnjb76g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rZRMMsqhFoxwK1PvajkRFKe2q5CudgdYw0a3Be9dHk=;
 b=Ab4M+mtdDH59Sna/EG2sLsCfbc35hZysh4Ova3TMAN8Z/j81pcKD7buOjWc5QkXrFgRU5NvMdndcR9pTJChMKT75Y+8lcP7sAIXFcSn1aJJE3oqDVfurABfFOWLHp1tPwSeKzbdAKiJ5BtFVS1ZMzsvmC0PftV/4Nm7g9bvKVmc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5826.namprd12.prod.outlook.com (2603:10b6:208:395::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 30 May
 2024 14:11:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.017; Thu, 30 May 2024
 14:11:35 +0000
Message-ID: <df27390c-d55d-4f71-abf5-c744624cd91f@amd.com>
Date: Thu, 30 May 2024 16:11:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] amd/amdkfd:fix overflowed constant in the function
 svm_migrate_copy_to_ram
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Felix Kuehling <felix.kuehling@amd.com>,
 jonathan.kim@amd.com, Tim.Huang@amd.com
References: <20240530034801.2341277-1-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240530034801.2341277-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: bbc4360b-3a86-4b3a-26a9-08dc80b26a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFN6ZVRQZHAwd0VFUGZvT1d1VVptMGxGT1BDaDNBQ3RJWHRTNmVSNG5ieUtI?=
 =?utf-8?B?ZlUrUFlkRWp2SGptQXJRVW9Wd1Excy9VZWdBRFZMYTh6Y2paT01hVXVYbjRs?=
 =?utf-8?B?MzlqcCswZE94VUpubHpxTEppRFJoNVdRQVV0M1ZXM2x6Wk5uTThqQWcydldN?=
 =?utf-8?B?UjhneU0zUVJCSG5veUtqKzlER3J5MjNIczdRaVRTelZ6VFVSMFg1anRmYmo4?=
 =?utf-8?B?MG1zaWxNeEdvSEx3bXg5YjlUTWlLV3A2ZTFNckl1d05XTm96R2JDdUdiYm8w?=
 =?utf-8?B?WnZOK0daQURNbWZKcEF2eXdhVFlBMkUrZXFRdlVoVmpuK096L2NvRWtlN01Q?=
 =?utf-8?B?UG5vK0FJV2VxUVlrSkJRRjA4QlM1UnYwWlFabldRSzFBaldSaGZPWTBWZUlr?=
 =?utf-8?B?UDdBR3h1WnhZeXVJZWFsYzVGZVIySEp4VndLdkdLU0NVdGdRRGFtWVRSeUNq?=
 =?utf-8?B?Y3Jsc2I0Sjd5eEZiTGZoYW1LWFpORCtpUjl4RDNTTmp1d0RTNm9QNjY0N2Ja?=
 =?utf-8?B?anJnaURFcy8vbkUwNEllZWcxTG9OaXVBdllUUEc2R0pzcUc3dkFsdE1DRTdx?=
 =?utf-8?B?T1FPVmIvUmoyUE5WZ2VmRzdVNnNXcWVzemhHRXl0Z1JJdjRUWDc1cEhUYjJx?=
 =?utf-8?B?cDFEWnF0R1FFVHJVaTR6OWlzSTdSbFJDRFp1b2ZnM20xQVR2U1RBQ0c5MUtY?=
 =?utf-8?B?dnZlSHR0d2hFRFcvaHJtUEdObS9KdnNuNWJ6aHp0UGg4aHVMVHZrZ2lMaW5P?=
 =?utf-8?B?OS80RjNIdFJDOHh4S1llSDVSZGsxOTA2RlNtSHg1ZnFXL3FZb0dHczB0QWdi?=
 =?utf-8?B?bUZBOXJGY3FYZGtYSU0xTm9KMEZRTDl2YzUzWmJLUW5SZU4yL2tRL0h5bDBk?=
 =?utf-8?B?SWgrR0MvZkVJeGRKOUl0QStyWFpwSGE2bEdjeC9Yd1gxdm94MVVYUVA1Q3RF?=
 =?utf-8?B?RnhOc2JFcWo5c2RlMGV2aWpVUm93RzVxSzhzSlJ2QmpWUGNXNzlNZlhDa0RI?=
 =?utf-8?B?bUNnQk56WXlIQ1BCM2YyMEUvNUE1Rk9sVXEyaGU0dlJ6anMvUmFqZFZxQk03?=
 =?utf-8?B?TlVIVzkzZGJ2OVUxTjBKSTNyNHRvK3laMzhKNjIrSGloZXV3dXl0WE9RdGlM?=
 =?utf-8?B?ZkFpYkhKODk0Q0s5ZURvRUtrQ014Z2pLOU9HN20zeUk0Vm5YcnhvSVNCQ2t3?=
 =?utf-8?B?YWRKSnRtYTV5MlZjTXRIZTBVZS9HVVZ4cDVhdXNiUkgyQ3RDUXZRTWdyYnBj?=
 =?utf-8?B?MVhBbmpFK0FxMlBMT0pCZUVIbWgwN1hVcnRsODBvQXlTS0d5SlRhRlNrVzFV?=
 =?utf-8?B?dW94WTVkUlo2dXJheUJVMHp4MnpVTDZjWktnb3lIYkl0eDNMTjhRTWJpdlhz?=
 =?utf-8?B?MVBNUWlub0hRYzNPdzczNmt3T3VsTzZaZktYTm1TWTZkQWlHT1pDa3pzZGEw?=
 =?utf-8?B?cVRwVERmSVZzeWtPWWhZazRDK2p2T1MrT3JXcXJPdEJLWUwzYTJaSkNOcWpk?=
 =?utf-8?B?Z1c5V0tRaWtDUU5ud0tvU1gvaDRnOEdNbGU2K1orUUtub0RabUJYdmlacjlZ?=
 =?utf-8?B?RTEzN1VIakNhd09oMVZRUTUyVExwdTRiTWtJejV3aUxPb0VZRnd1ZXRlQ05r?=
 =?utf-8?B?YVNwbGRTbDh4NUJUTUZEb3Z0cGkzdW9DMlpId2xxNDNPMkdFamFzZnJxNTln?=
 =?utf-8?B?aklxUUphZXJhVy9MRURrNXdFYXlGY3dJU2pPYWE2WCtlcStWNVJmN2NnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2hldllpdDVvWUl0KzE3UnNuZW40bW45dW5BMHZkWGdDREZCczZtZVNPSVNH?=
 =?utf-8?B?YjlwbkQrMlZtOGYxcnJQTHVxZThUd0VabEhrQkNZSHFTWHpGVDVBck0vbkVL?=
 =?utf-8?B?NVZKRFFLVVlvUGN6d1RGbHNHd1kwVG5iRVVTSGtpODg0NGpHVHFicW0xRlZF?=
 =?utf-8?B?KzRic0JXK1U5UVpFMk1iNW5JZmtVVGRCckt4VHNvVThtdHM3VG9UeVJGOVly?=
 =?utf-8?B?YnMzYVhBeGJIcG9PNjIvTmExMEt6SHp3VmpjV2dzclBvRmtxZGRjcEkzLzdW?=
 =?utf-8?B?SVY1UkY5M3dGOXVCWFdvUVQvanU1U1NBQ2hTbS9yamhUVWxnL2Rad1FSRFA0?=
 =?utf-8?B?Zk5UMjJYZHMzSlVUQ05wZUdzY2lZM2N4MHRGWEljMk1uWXFSL2RyZ3RhalFk?=
 =?utf-8?B?bVgrUlB3aFBNcVU5eUNoR1U3WHZqOCtGOXA0YW1zdlhmL2ZkT2RNNTg5WmJs?=
 =?utf-8?B?cnluK3pFVDI0ZUtKK20yM1gwcFhjRlBXemp5WlVQYTJSZDBqL01lT0lUOUU4?=
 =?utf-8?B?ejdLVVpCRGY5TEVkZ2RrNTdCaEFnL0NEUnk0L1dQRmxBanc3dHE5RTRNWGVH?=
 =?utf-8?B?OXpVaWVrWDZ1YlpQTDRHaGMxQ2VpZFBxN3dCOS9id0FDaC84bXFFK1RDT253?=
 =?utf-8?B?bk1UOGZJSTZpZEZTU29SY3pRdXVLWGhZTWI4M0YyNFczWDFWNk9iU0p1WXpD?=
 =?utf-8?B?VTh6ZUttcEhsNVlJYktzTHdOeTZydU9DSmdIeXV4MDZSa2t5WWZsYkR3MkpO?=
 =?utf-8?B?UzY0dm1CTkVPRTlsVzNLcm5hSlNjdDdMQi9ENURyUnVEWEd2cFFFaGNRSEYz?=
 =?utf-8?B?TmVKZStZSHpFd3dTNE9rbVY5WWVRaEJ6UjVnNjRjdk9FZ2xwZjNvcmw2bnZv?=
 =?utf-8?B?WmhReW5HaW12MWtTcnZSUS9BUVNiVUoyVTgwdmszKzIyRzBvdlNoV29xd1lK?=
 =?utf-8?B?M3VmQjdteXBrcVA5ZVFCei93OEI0OU9FTW5aSVVoQkcxeXNPczBLSko3aW1E?=
 =?utf-8?B?ZGVlNE1Bb1NxWE9mc0VNT1g5eGdVd2ZLM28wOGVqRzdHbFpCNlN5RnRyd3pD?=
 =?utf-8?B?OW8vT2FRTjNaYXZyRjlxeFJUNWF4dWdLcU0vNGpXWitUTkRrMkhaZnhzR0M1?=
 =?utf-8?B?a0p1WUZyZEVXM1Fxc1dOOWZmQ2tEbXRWcW9JUUN3Q09yTmk3TGJMTkVVUHZs?=
 =?utf-8?B?SXhLZzZURENiSnJGeTZJcnd4eE1mT2E1OHhlMEx3UFdCWDZDdXdtRmU3Vlk4?=
 =?utf-8?B?TldXUnE2d1YxK0U1Mm9lWnpCS3pEZ1lSblNLYXNkRDk3cVRYSnluVUFYcURv?=
 =?utf-8?B?ZnpVZkNqOVFlOS94V3Z1KytOV0oyODhna3NYelBVZ3VoYnhNWGZnVm45NXZD?=
 =?utf-8?B?ZnpucHUvcTJxRzlxY3ROc2JTZ20xaE1ISjkwcmhmbHBuUDdaS1creGlMbXBU?=
 =?utf-8?B?TnFRSkRqSTA3eTJXSTI1aDlza0dPV0RtVlZLT1hTbFQ0b3pHUVRsZFRoNHh1?=
 =?utf-8?B?dVo1NlpxUnczTmFWQWIzbHB5ZStuSVg2VFhBRWVLMnliSFg3dlZId3NnWk5K?=
 =?utf-8?B?OC9yeU5hTWtpSjVjQ0diRitnbE83V1FMckxuTVp4ckI3TG50aUVXV3VhNzhI?=
 =?utf-8?B?NzVHbXo3NDY0TndzeWgzSzFHZW1IdXNSM3VSOGxSVkx2Wm9LWkxIcC8rOVA3?=
 =?utf-8?B?anhBYytOSExLK1dMcm9abWNHa2lTVkxoMVVzSXhGOXNPWUJ5UEpPQjY2SWQ4?=
 =?utf-8?B?UlN6UVpUTHI2Vks5QU5EYU5GMVB0Rk10bzltaWppWVdvMXdQR2E2akpWSUpv?=
 =?utf-8?B?QTY0L21pUWpFMkoxZVpzWTZ1eW53V2NWRVo1b2dSUzBFNFlJQi92RkVlTXZi?=
 =?utf-8?B?amMzSjJpMWhGQXVCZkhVbWJ0UG84VFBlck9MYkFnY2dncnNCRCtnUURzeTYx?=
 =?utf-8?B?K2F4bVI4T09HQzBBTDhxRG9MVitkZ3IzNTFyRE5sVFRvVm5LUjJ4Y2NjeU1h?=
 =?utf-8?B?cXR5ZW5FeGRDdGhDYUtKb0RqclhJdXBYSU53Nk9lT1JqNXhqc0Z1aGhrVTgx?=
 =?utf-8?B?enhEQzZpLzk4WE5nMVh6T05oRVYrVHg2QVpZTVV3UDA4dVlQUGJ5UVBOMkVO?=
 =?utf-8?Q?EGwrkdEzH72b8mllBPdC44WVb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc4360b-3a86-4b3a-26a9-08dc80b26a45
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 14:11:35.8533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwvZ5n+0HiyF1bfXSmXd3q0NG00ZKX1pIxqRTTdh9st9boNZo6icEP9yu32nw5lJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5826
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



Am 30.05.24 um 05:48 schrieb Jesse Zhang:
> If the svm migration copy memory gart fails or the dma mapping page fails for the first time.
> But the variable i is still 0, and executing i-- will overflow.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 8ee3d07ffbdf..3620eabf13c7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -650,9 +650,10 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   out_oom:
>   	if (r) {
>   		pr_debug("failed %d copy to ram\n", r);
> -		while (i--) {
> +		while (i) {
>   			svm_migrate_put_sys_page(dst[i]);
>   			migrate->dst[i] = 0;
> +			i--;

That looks incorrect to me.

"i" is usually the entry which failed and doesn't need to cleanup. So 
using "while (i---) ...." is a very common and correct way to clean 
things up.

With the code changed as above 0 for example would never be cleaned up.

Christian.

>   		}
>   	}
>   

