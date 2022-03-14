Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A95BC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 16:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8940010E3A4;
	Mon, 14 Mar 2022 16:06:24 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9750610E370
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 16:06:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knv0qgetKHFcjteABY2zFcGKw4m+SXtV7I4vbdGfYeM/a3LpCjn8JEyQhwp9nqBLtVrJvwNH3eSK/MLqeIEad2DbbAQj6tDgquNnIGjw4Y4dQVCCC0fM/SP4LW81ZcRaVNQZ/s4UdG0e/bnvbLhKwwCT245G0PAIq7RIte92FFC8vqvzCuKjKMuYSjVHmzfsq2CVn5f8SM4+deTHtPaXpsGtkAeCAKbfvkGCfcgnO5bKW3KPYuG9u67W7va2WcEHFQ5YCWA8fadC26kt55mUxLisThDNa7gr+ngV6tOxWFRk/8M0QtlV+2Xnq7HevxrcuX1Pj1OjeXFRXVxxNobkjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEd5dWqvHnVeZ2mhiVJBnRcUwlKcehOz/d06nVDSpIg=;
 b=lqBzZMgUkXbMF0rilgddlEo9Ct1i3TAHusfwvLYuhBf7Y9cRKUrAB+GKMJwNCc/+5GB5zs0ZYtuYxqLODfi7sp0v5HMryfgcyfaRpf/NU1wVZdZutTNATaiks6skx2fH6dQFIJxPQsl7X0+cXT6l1XXwo6q2LzZgTotiLV0uKRCKhzUOXL4RJ7osV1W/wJblCQUh6nOlRe/VZSxupFBfeMwKzdNxRYpnuKIr857HAaieS2qioaXJjLTHU9lihD/fPbRIbas51EXrlYRunljqwrb5roTN2PxbDQFteHOfAm1T571Hvjn5YyDQWzvASYA6W0QUoEO4crqZwBuZfwRuRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEd5dWqvHnVeZ2mhiVJBnRcUwlKcehOz/d06nVDSpIg=;
 b=MoORsxqUoVjw1pM2vJTjhuEgApgDGKUYwITy+ofJw3aY2Uuzdmvgn3+QrksvdpNFC50OC8Ky7+r0z/35/68BAKesYdRteBSiSazJf72FSRta1zD7lgjd28vZlzDlCCT8RWfRYmFIOQvf392b/gDZ25mWk96i4URnPDpmeSeXFmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MN2PR12MB3533.namprd12.prod.outlook.com (2603:10b6:208:107::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.23; Mon, 14 Mar
 2022 16:06:16 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::48fa:fb41:64d0:50dd]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::48fa:fb41:64d0:50dd%5]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 16:06:16 +0000
Message-ID: <e54bbfa5-bcbf-8b84-8c94-c181c774c64c@amd.com>
Date: Mon, 14 Mar 2022 12:06:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH] drm/amd/pm: fix indenting in __smu_cmn_reg_print_error()
To: Dan Carpenter <dan.carpenter@oracle.com>, Evan Quan <evan.quan@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Huang Rui <ray.huang@amd.com>
References: <20220314140405.GC30883@kili>
Content-Language: en-CA
In-Reply-To: <20220314140405.GC30883@kili>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::8) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf65e9db-2f9b-4a66-71a1-08da05d49189
X-MS-TrafficTypeDiagnostic: MN2PR12MB3533:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3533ABD6F609430CE136FAF3990F9@MN2PR12MB3533.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWs0waT3ZJv85KcmZcQXBPEWk3VEikJ4pxoSQpKEG9JqGBmfPkEO44XfFapLMPWmdv4gz6Uh/MZxa/LpZ7hAv6T7rXFh9sGvjRN9xOwno0JsTe3RL16QhWWdTR7A0dzmefP8jTSIGWpjGDaf5H3oKDIdPeS5nV6WMOmFngbKBjW54QljJpBVotULaMW3+T16QhvINPdhoH9ul4QNgK5Pyrmk/F9jmUi0HwfZi8PAwd/YuqoB/I3I2hWDyGchkb61HU3YsjOvBsGiA5pnsZuH0eZxsSPHZHZW8jCqEyTouQhAxDI1paLdNKZXGGl9ZJmUbN20Iix0PZ+BaNCun35P/OxkjgXemCxxg8hWEloaCO5e3HCsXyMab3v4HzkufINimI3y3zzCNpwYCXVHYNxIGKq6D2KKfUbtY3x+BYZx95Atpw8f7rdbmU9l7IXRhpePY1l8EDk9Iaor0tfbOibqTHl2m0CQu9rEt0efPfpqOIaqR/mYxmPyE31i42/BL5bLoi7Mr4rpbA+qkcQFg7eU/9dAuRtVqk7FjuX648nogo0yUJwquZPO5+zF+cEZbM35Y3nOoIP+Y7DBb2f0HqvLX/aTwOeNfRNa8Y3DhNErCfzLMR0+z9jF9bvU78EafXpAcPC6UwCFJM+6cBYiH4rfSa/ls8tu9BjGayTs1Me+91hTbXopZ4yHrL/dhrJgjrucXPvpq75SASrNv2Vfoo2MZg9tdWJuZ+/8JVzi4qTjSWM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(8676002)(36756003)(2906002)(31686004)(4326008)(6636002)(110136005)(54906003)(66556008)(66476007)(66946007)(53546011)(6666004)(6486002)(6512007)(6506007)(5660300002)(8936002)(508600001)(44832011)(26005)(83380400001)(86362001)(2616005)(186003)(31696002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVRmSE93Uit0L1ByRHNYWnFHeHVQZXByNGI3eTVGYVFRZGJLTi9GTU1HNUta?=
 =?utf-8?B?NE9DTDVyK1pOZU5RWW5kVkRrUW44Mzc3cFZwb2piemt1N2dSYzEyRXRjemZk?=
 =?utf-8?B?QmUyNXo0a3djaU9oUnhFTWlQRmMyYWxxVDYvK2pDdWRIYXlFSFNkZ095Z3FE?=
 =?utf-8?B?dGdVanJTUnNGNW51bTI3a0M0Z3lITms5UVpWbmgwcDlmMStBd21Sck9MaVJR?=
 =?utf-8?B?bWNvOFk2aUdJZ0hjRG5UZ3BmZVNZSGh3VzduUWJSRGI3UGVLZ3VBandmcnVz?=
 =?utf-8?B?TTBCZ3BUYlROS0pMUGpjc2pqYlpJSmdiTFhjRFFwTi9lUU9kajh1N2xaUmpI?=
 =?utf-8?B?VjFxd3g2YzB5L3NzQTkzMEFLWDFYV3p0Si93Y0JxZSsrbnZ3eEcwcjJUSisr?=
 =?utf-8?B?RzczNDNVYW1BYjRGVDRwWUQ2a0JjVjdyNjFBUkRjbnNOMXZoZzk0UmhpWDFv?=
 =?utf-8?B?N3p4M2xPL1cvODBuVlNzTE4xc3BuQ3MyeTNCL01GS051NldKVnVEZXQzZUFD?=
 =?utf-8?B?a0paVXNJNllXVFZtYUp0OERYT1I5eGFDcnRxZWdvdFVMUDg0N2h2VS9mYkVD?=
 =?utf-8?B?NFppeEFiNU5EMFN5MWRhLzJiVTdBZUZyMnpWSzJJd3dJdjhaZVdDNndVaUtQ?=
 =?utf-8?B?T1dOaWZ3NnFGQWp5RkdXcEhiMUM0aEV3cHlMMmg1SVJPZ3JJM29GSUFPUm1S?=
 =?utf-8?B?WFJxcHl2NUxLbzhacDVYeENYWDJEQzBaeC9nOUdmTFpGSmgxRGx4bzU2a2JP?=
 =?utf-8?B?bUw0VXdTdmZGQTlOallMaVRkTjg3TTV1bzhYb2JjVlYxejRFSHpPQndwTisv?=
 =?utf-8?B?RGI1eGd2WUhYWDRDY1NlbENCb2dkazByZlNQZDBXTFFqMkd3WTNvZzB3VzY4?=
 =?utf-8?B?MmlLTGF1RU0rN0RFNzF6azhrQWFKSzFFbkdUdXNqN2U0SVZKdlkySWc4d3B6?=
 =?utf-8?B?RGNqU0dTUC9obHM4TVN6OVYwRnlvZ3p4dXpQd2RldnltRC9NQTh1Sk9nM1Q3?=
 =?utf-8?B?dkZjUTcvVkprVmRoYUZRTDBuTkJjNndkdGJDVmFiQldUNktIcGpjWVdrWTJ0?=
 =?utf-8?B?aGpKL1FWRTlMMWRobk1vM2M0WFdBY0Q0bWw2aXhZN3hXMU1CSmF5MGNxUUYy?=
 =?utf-8?B?WUcxSFcvb2N4UDZZVHlMUCtTdDM0MklWM0Rka1cwYjFCUFhDYlRDeXFuM3My?=
 =?utf-8?B?dDRhbjkvQUpSUnl6SnBSZmhMeXJQak1kc2JtQ1hlUVFaemhocUx3L2FOQVRD?=
 =?utf-8?B?LzBUOWhCN3A1VlpkbCtUTWtsV3M4MzQrQVhScW15ZE9FQVhFQXNJRXo1NlRY?=
 =?utf-8?B?YjdEZXFveUMrbGN2aDRRd2JZb2Jlc2ZGVzY3RFB1TkdzaEtUaTVmTDdlZzNr?=
 =?utf-8?B?NmtDZ01uSnI0V0FLM0duMjd6UW94MXZIYzRyaVJPWXkrVTFxcWtTVVNWeWtG?=
 =?utf-8?B?dUFxcnhPVm5INkFwSWJJZ1cyYlNzc0ViNlpZWU1sNzhsOVhzeXdvNDlkc0pZ?=
 =?utf-8?B?MFpFazdvcFNIdWtNMy90MkZhMGhBRVRkOHMxenVTU0F5bHVlelVJVDdDRjFS?=
 =?utf-8?B?Njg3SDRGbTZmMG16RTZhMmt4LzJwWExxTmI4a1I3ajFTT0hQcFp4MURpNUYx?=
 =?utf-8?B?N05YdEVQYURmRFBCMmIvMFFybW5jb29sZ2d3TjhoRkpXYWtwMmZNQ1gvSHda?=
 =?utf-8?B?OUswSjdROE5GRHdKdVp0eERUQll6NGRWUEJTdmt6MXNoeVZsYmRKb3pyRzNK?=
 =?utf-8?B?aVcyaCtvY2RYM3NtUnBRY3o3eHBia09ybGJaWjlXRHhrd2dMbHQ2WmEvd2ZX?=
 =?utf-8?B?aXJNeGVXdXhlcmxiUnhCTUgrZUFtMm9FWC85MTRpWjJHUDVnbmZ5QlB0ODFY?=
 =?utf-8?B?N2dUWFVwMERldEJtUENsb2hDdEZFckRsT3dlK2dKTmsyN25OSC9Gd2hvWkNE?=
 =?utf-8?Q?5vItpHfwqzaNFL+Z7q1ywnMCQBdVJXjW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf65e9db-2f9b-4a66-71a1-08da05d49189
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 16:06:16.1130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zMvLDYXV8jEKCr/UWn8fbS1d589Rv5QP48nt9FhwnU8ACr2UxhDsTzHQMH7jZxH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3533
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Prike Liang <Prike.Liang@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Darren Powell <darren.powell@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks!

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2022-03-14 10:04, Dan Carpenter wrote:
> Smatch complains that the dev_err_ratelimited() is indented one tab more
> than the surrounding lines.
> 
> 	drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:174
> 	__smu_cmn_reg_print_error() warn: inconsistent indenting
> 
> It looks like it's not a bug, just that the indenting needs to be cleaned
> up.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index ae64d1980f10..b8d0c70ff668 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -164,17 +164,17 @@ static void __smu_cmn_reg_print_error(struct smu_context *smu,
>  
>  	switch (reg_c2pmsg_90) {
>  	case SMU_RESP_NONE: {
> -	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5)) {
> -		msg_idx = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_2);
> -		prm     = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_34);
> -	} else {
> -		msg_idx = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66);
> -		prm     = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
> -	}
> +		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5)) {
> +			msg_idx = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_2);
> +			prm     = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_34);
> +		} else {
> +			msg_idx = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66);
> +			prm     = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
> +		}
>  		dev_err_ratelimited(adev->dev,
>  				    "SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x%08X SMN_C2PMSG_82:0x%08X",
>  				    msg_idx, prm);
> -	}
> +		}
>  		break;
>  	case SMU_RESP_OK:
>  		/* The SMU executed the command. It completed with a

Regards,
-- 
Luben
