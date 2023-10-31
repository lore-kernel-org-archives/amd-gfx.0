Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F73C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 04:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD27110E3ED;
	Tue, 31 Oct 2023 04:07:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFAFD10E3ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 04:07:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmTcvtgcExUdzwYwy93fw1AvVdMnWlFV6kMdPZgV9VguMQV7SFBgD2nMvP4iIIwNNSb3hRLkIrCy+IxANY6tR2417H3Ov1x08MJfTMcOV5lPbpSkynXEMa21cGjmoz9W0fmHRbU0L3AUzYoj478Iu7qVPyaK84059j/BIjFquDBnlkdg8lBtmSOpmQrtoVPj/N3xd6xEgU5ahB5VPxEKisFazj8+Adkvsq126XMWMBZtEVQRblwugLtAJemKuI9+VSZK9NHfaz9fOpmaDZHoms1SLO08lLjxRYIR7G0Cfy+JoeYrAZIwxuXCmfGOVS6T0DQkKXchyUGl7P2P+n2xUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZckLO2kp3zQD3dcu9A24EnXr2jf/iHcJwnJ3RcCpaXE=;
 b=TDpNGFafEWEULBHcE6WAFXwgDdbtnW3mwpxMBiPbAelAOTqQ8fJwwNGMzDupqYAxT5AmAuGjrey11clGtkOdncvLWy2vTvmHjpPCKX5jr2AXtf5+m7ccZhRT/1T5VSCHJIfINf+3ReQrpOtBWXj3HRoR2wMMeWb0GVeWg9syYXPwYPiAcP6ZN9NMMN76b60Wr6hbF5evSjp4dvcGeCO+zNIOxAxvPagySV8kxE8fsSgbyqJvvvvTMUyq5JSgQocvSSi6sPh1eFA3UpO53auuHQl2tHe3IDJpWcSKt4++yIovokKPsVpJ3wEUN9/u2Noya4MoDQ8p5UXS0BykFfRuGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZckLO2kp3zQD3dcu9A24EnXr2jf/iHcJwnJ3RcCpaXE=;
 b=TO2R+mMY95OvCOo4G6Dm4aFW/ASw/p450Bt1YBdDymHL9FiaIODATWZlLJOtYR7DGVr7mn1WbnFoWFcEFIuurNCY6Yu1IbhA2YKL9lhszNhbZTvHzYtyilevBUoFaSr0gGhX91IBY3n1dm4oeSujwfGvf7htKndlAtUGg/6JsiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 04:07:03 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8b0b:3c38:b988:ca27]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8b0b:3c38:b988:ca27%3]) with mapi id 15.20.6933.024; Tue, 31 Oct 2023
 04:07:03 +0000
Message-ID: <2fb064fd-1709-5efc-39a2-03eff8e43c21@amd.com>
Date: Tue, 31 Oct 2023 09:36:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: correct amdgpu ip block rev info
Content-Language: en-US
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231031025021.2697459-1-kevinyang.wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231031025021.2697459-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::9) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|MW3PR12MB4458:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f2511ec-b694-4985-0a73-08dbd9c6d689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FLjfxAO5wun6yrRllXVzocuM8r6S8/B4poN/G+ziG941YRN7s7yJRVgiVTFAem4lvbLjmTpTZaTV7P09Pm6vaiI9M8y/M6xve254XBMrLXZFi66ceEXk2VsUHRwh5DUGRlUxC+zeDM61d9FmHQxV0gwB3im0Iv6mW616aJlIxE3IMFSPSqk8l4EwmcYV2NTV8At5siCElLj+Im1xRHY01dV3NfCm4VrLOREc2hSBrNOL/kKdTe4b6YvT6ktmKtFxC0aHRFQcZF6gNjDf3S4XeUF2VPk4DN0ekLch8ZMNtevBA6wuxA11GBiQXvfw2xAbqrjohsm0EBVa/K2MJvC6Qudu7xeHZJ2XSTHE1LqVnOr0xzqbTI5Ze2JcWdlWR9wgnAEW5cPC2dneu9RCAzob0/eODS8pIOfmTCpvhUREqj+pPcTe5wMC3mDRSc7mN8dFK2OmC1CUEf7d8TTcEyOKNv6zbSgOEfx/nDPgy+2ZCXzlfu6KlXm1Om5mQMiux6E+/wtRrDsNekHvBBv2V7oUbGlEUETX7sRUAjAv5GxPD67kls9u98mbL+nZS5pRq4jKxczEQVMClFxio8RqBvpUnxt9pa55NRqIp/bBAzfG3RHVtuT4khRIX4qC+0b3kt5SNTaC6gQzwvyuIZVULGj7GQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(366004)(39860400002)(396003)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(5660300002)(41300700001)(66946007)(66556008)(66476007)(316002)(31686004)(8676002)(8936002)(2906002)(478600001)(6486002)(6512007)(86362001)(83380400001)(36756003)(6506007)(53546011)(6666004)(26005)(2616005)(38100700002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDV4dE9tVTM5UXlkaDc1dmsyM0pQZTdWQThlYXlCQ3JxNmpyVmRyaW9hRFIv?=
 =?utf-8?B?UWtVRjByQnN1Wm1KaDlXNHpCVnMzS09GazB6c3dwcFB6RUR6dWZFQ3JtMVVY?=
 =?utf-8?B?dU9XSUY3YU45Wjhobnp2N2ttRW9VeG5qR0QyRGdGaUF2Nmk1enNERlVUem5h?=
 =?utf-8?B?Q1Byd0I3QlJqY243R2k1b21KYlUyS0ZzTmZGalppZFJ6TXBsQ21aODY2QTc1?=
 =?utf-8?B?a3JtWE5KcGxhN3lPbm1iSzMrUGVlVGJTSXJOcEtnU2Nvb09rWFFBMkkyN2tD?=
 =?utf-8?B?d0xGZnBNblJaUEU5SU0zd0RpaTRSdCs1eDlBb2lqYXZXYTFYTUxyNHVLeDBE?=
 =?utf-8?B?UXY1a3FMTnNRRVFRanROTUFOM2VsejNlS3N4aktnaW9SMUp0UUE2Wkx0TXBV?=
 =?utf-8?B?d1BRT3VDWUFpc2FCMXNUei84SWNiTVd4K3U3Zm04RkROR2todDBqdkNncTdl?=
 =?utf-8?B?cmR3Wk5ibU0yK09yd3JqcHEvNktaVW5wUkN0Q1VKZTFaK0JOOFRzbitrTCtp?=
 =?utf-8?B?eFNFUm1ibjk1VmVBOVo0N1o2QnY4R29mOWN0SXBhakZodjZRQ3MxTzJ1bjdZ?=
 =?utf-8?B?M1R3ZDJwd3NQb3FoYjNMNm44L2xZRG9pTnZXV25oVjZHazRlbU1RZXlycE5B?=
 =?utf-8?B?dk5hRDlCanB1V1BiOVZnWnRLQVRpa1FyNUJTczV1bE1IME5QTDNTRTFWRDRY?=
 =?utf-8?B?YVFGeTZuMGx5Z2cwTGF6ZXdnaEJ4YnAvMjhPZXpFbVJtSm1oMjNIQUdiZHdH?=
 =?utf-8?B?TDNiZDZGdW1OUEpaNDEvWlkydTVMdmdZK1hzckNBc0FFanFGMmlkaVp3dWkw?=
 =?utf-8?B?ZDZwR3pESmtBZmNPK3FWSk9XTmxMVzJPNTVXTVNUVFE4c203LzFWZFpXamcx?=
 =?utf-8?B?a0FWUVhHWmtzWnpYeHg0OWZxNnorUFZqRkhFTVFxSEZPQWQ0a0NwbDZvd0dQ?=
 =?utf-8?B?SXhEQ3gzaVBJWjZjakIvdlhjUGNDSGQwNXVyYnpFVXh1OFkycjJ1MDdiaWFk?=
 =?utf-8?B?SGl2SWtQeXN1V2c0SjVhV3BrNWJJNk9vMlMrdVZWMFp1bjFONnN0SUUvN29R?=
 =?utf-8?B?SlZBalB1Qm5SL05wQ0t4WVV1SURFNkpkaTNHMmh4Z2RuUldtZnJ3UC83T3Zx?=
 =?utf-8?B?b0lFSVBHME5yR25nOVlMRTlrcEh5OEhuQzdKNFZTbTZuZEhrZ3Q5eUxhUUxV?=
 =?utf-8?B?blREcmY5N3RxRUtsd0tGNGhCQ083Y0VQN01vbzc5d2FhdlYzaGN5dE13T3Qy?=
 =?utf-8?B?SmFwaHpzcWdkWHVFa2JwV3d1RzIvN1d4cTgvZks4NVY0MVBER1ZtU2k4S0xR?=
 =?utf-8?B?R2lQb3kwa2pCSlA2dnEybU9tVWJyOFdnWjdqNGRrbGNkVkFrai9kVWRrdDZB?=
 =?utf-8?B?ZkxVOUdOVndSRTlXekg2cm5KMkNIMTQ0NWdTQmJJaDM5cUx0aEV0NUovanor?=
 =?utf-8?B?TTlzeXhzbEczb2FjMjIrZ0JKL1dwTHBNTFRNT3FqUTlYT0FFTnFnS0sxanBX?=
 =?utf-8?B?MnpBSzMydStqVjk4WDdFZGpiRmNDa0xKU0pSMkF1ckRMZjJqYlVUUTA4QTZ4?=
 =?utf-8?B?b2YxTEQ3NVpLZlh0ZzVpbHhCQmd0Wll0Ym9TUzN6eEFnRk9ESlhkcmRONUNl?=
 =?utf-8?B?WTJXU3puMUdmeW93Uy9lL1h2UndRZkN6b2ZpOXRSRk1vaVprK2xUMFYrdXJF?=
 =?utf-8?B?bUw4SE8xa1IyVWlkNzIzZWcwVmUvK1gvQ2Mwd1R3cEl2RHd3Y0t1Y0E0NEY1?=
 =?utf-8?B?dWpJRWVpTTNXRUVHMEozTFU4RHFyL2lFYzhoUm1xRnpXNVMybG05QnNOSHFu?=
 =?utf-8?B?UGg2bkVDOEUwNjhFemsxa1U4blhHMVVTeXpVdHQvMGxaVTRGdVFrK0ZTMy9E?=
 =?utf-8?B?VE9Nem9YYkhtdHBuK2tJRWhKQnNpYjZqRGlWTE4vRGNhZXZFYzlsV0VhYWFF?=
 =?utf-8?B?dGIrZXlxT0FMaXEyeGR0eWRuUm45L0FRV0grQ1o2TGxsaXFra0xDN0pmYTVH?=
 =?utf-8?B?YjBGUXhBTG5iVG45SUI0Y2VQRHBNOHVNUW13L2Q5bU5UclhOUEpqdEpOY0Nu?=
 =?utf-8?B?dnVtTEN0c1gzQmE3TkpmdEgyajlaWDFHZG9HVHpmTlBheWpmeWR1NEV6b1R2?=
 =?utf-8?Q?q/+VhtQrRUaccBrcSHfTIeIPK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2511ec-b694-4985-0a73-08dbd9c6d689
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 04:07:03.2367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAU9/kVSwe0jeZthj/CEHSIROqq0XpsNPQYddMyePhfxZsriYJ9URDTsmH14o6EJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4458
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



On 10/31/2023 8:20 AM, Yang Wang wrote:
> correct following amdgpu ip block version information:
> - gfx_v9_4_3
> - sdma_v4_4_2
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 2 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index b3d4458e3889..1c46d205c0ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -4295,7 +4295,7 @@ const struct amdgpu_ip_block_version gfx_v9_4_3_ip_block = {
>   	.type = AMD_IP_BLOCK_TYPE_GFX,
>   	.major = 9,
>   	.minor = 4,
> -	.rev = 0,
> +	.rev = 3,
>   	.funcs = &gfx_v9_4_3_ip_funcs,
>   };
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index c46bc6aa4f48..c851413ba6b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -2048,7 +2048,7 @@ const struct amdgpu_ip_block_version sdma_v4_4_2_ip_block = {
>   	.type = AMD_IP_BLOCK_TYPE_SDMA,
>   	.major = 4,
>   	.minor = 4,
> -	.rev = 0,
> +	.rev = 2,
>   	.funcs = &sdma_v4_4_2_ip_funcs,
>   };
>   
