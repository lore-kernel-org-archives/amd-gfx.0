Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F58C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 14:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5288B10FD6F;
	Thu,  7 Jul 2022 14:04:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE9E11236A
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 14:04:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ek+rPQiAf/0lckPCUmzVgE6Hsvil4wEMXoNWvHhiNxmb0lHbi+dc0/329/+jOqKB06MSsx1NNQGjUS21bqD63FxoVi4trtaT3anGkENzMVqjx07KoHSyYSF6HBx4WkrIXKKvRITfTMpGruHvt4Hq0GQBmq5/JAiLNfwragfDBt3kYhKZee1C9c+DPgflkGEfN5+1jTMcInaKxFl/Er0u5+sy3bqDP46iPUAu7VCeUa2yydJ2XBn8xPIEZR8dKNX7SPZcjDmEk2Ixbpmvb9juw1KhMePyfn8sUqqnUqdubw0qmShPVQmIM6claquB6vv+b/wdieVKf15Fkp7ebjzx7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlDwUSJYsxPquBZTV2ZWCsOg7TqbW6SvdU9FW8pGg54=;
 b=CO9jVkmQwWVAyyE866Yd7r45RefItZHfrov8gWBYKHEQ6Ii3cUO9TzdBNLGTY9ZkOlDjqPsfeC4dnAlD3wOAEAUM4+9HCEhS+dLkJItneO+9eAOrRXEBltjOHnv2oG/vWVngjIQ1wMXlBMRRT/3OQfBc7ACrjomjhRzLGo8D8i38bpiUPF7qHDUnineCBOcExZLu+RPfp7valvUcNzsh0qgIJrB0fH1Ztct9LbXQsxitQN3aSK4lirIm5uRa2TgK273AQD6856L65Z5VRFaROvu/Q3g1mnCS9mHl+hspH+Kv5weOCkbXFCZiUqKhSsudAsB4P2AHuxWft4sEeW/Gtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlDwUSJYsxPquBZTV2ZWCsOg7TqbW6SvdU9FW8pGg54=;
 b=3/srFrzbuSlo4I72z0Hm7Fu/5MPteq8PwqrlBRXH0FxOHSqp51UhbZ4+DQiokaHYp6ZVqLchh87rQr/ZhLlusw8HByLJ9dqK+nlR9EDEuQm1Re1LWLiOnZ0GpmA/4kCWPDcpAis7ILXBpwfmLLiJQ/WfwK1WZSyXQ0bf3TxAX6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MN2PR12MB3792.namprd12.prod.outlook.com (2603:10b6:208:16e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 14:04:41 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6999:13c9:d124:418a]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6999:13c9:d124:418a%7]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 14:04:40 +0000
Message-ID: <cefaf62a-ca4b-2582-4394-c8bf8593a9b1@amd.com>
Date: Thu, 7 Jul 2022 10:04:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amd/display: fix non-x86/PPC64 compilation
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220706214203.555342-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220706214203.555342-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::21) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48a26e3f-23c5-41b2-a38e-08da6021a292
X-MS-TrafficTypeDiagnostic: MN2PR12MB3792:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kw+SpUMSkx+9fe8MVwnUq+bpFmz0ULgVgiC1X3S/Yh6SHvhSpvIJxDMl5AfLLe+UCdLwlPN9CqnTAKQRY7xB+ecIJoh6YE/bCj7xgVXvCpDT9DMyVeB4NzqZIOUMPxYwFlcdAax5do3PEJ0vXK8z4SPyGcX4HqFxZs9UjziacK4iU7yczYqoI0rQsMuI6WXxkvugy52UtZrpi1j8dgdqmfW9ArbBgJZubaxDGF60od8HxDdq4zHokBm3qBZIYPf7mny50BtPlW75LFp2uzr5Fj0WCh0SjhzlHXoj8SXgcG7dx96Ql3EJj+xHAAnMB6xgcBgDOtwykFWDXn6eBJEf2y8VSZdgWynN92mkmtvdMCJZANfXbsvT1sFQ0HiSAjEiIcySJ91ZxK+Zp+VTkNWFyvV8yTWPxrsiaqWo7Gx0jl2OvsNR4el7Mnhqa1lPOZ4Mq5uQ6ye4HhANeiLF3H/HvZEv9ZYWSRlMgTjBDCMRRrZ8vczm05s+jOAgB2HZ9vE5xvj+jTxA8Az556gsS0Dn6wgF34kxiSv1+XVeIB6QTqH69DDVVW6QR3rH9npXB3L1VYFkDqTId7Z71WZbPsMYnivMBk+BaRwfcmwqpT6AkBe8z9eQc8lsnndnr1xpYjGXScX6oLnF27jCdS+s7cPdQNPt9PYChZlnFenG74m9h/rk0ANl34w5tMWEa2hzfGcAhlcWXLTxqGdu9PA+NwLV02TGApCEqSDDFFqMHT6iVK7K07R/kNBqQUa3wny7TrtwZ4CjQvGGy8Naz5m3yk2wTO25sEfCXM3VbqqOFvgeslh37Fn2tYTwLcmr9HXXfhCtvQDL9PWLzd2Dg7OVWLl4B+VE1o1mTC3MOK4aJC5LLQo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(83380400001)(2616005)(38100700002)(186003)(2906002)(4326008)(86362001)(31696002)(66946007)(66476007)(41300700001)(478600001)(6486002)(8676002)(6512007)(36756003)(316002)(26005)(31686004)(44832011)(5660300002)(53546011)(6506007)(8936002)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXhIVTdLVFovcHlJbWFmTFFqb0wxc0VudmloZHdKL1piRzFVNnlqVUUrV3ZV?=
 =?utf-8?B?MjRVbFpXUitSWmU4OGVtdUJrVHJadkNkWHhOMEtZZU1JTzM1YzQrWTJhcXRw?=
 =?utf-8?B?YXdoSS8vYWNOZzZ5RHJOTUtRZXk0NVg2NDNXcnZUbzBpVXJ0YkJ0d1F4WmNs?=
 =?utf-8?B?b1ZINHEvT2dJSjVHMTlmQWZldFZlVkVWZVp6ejlaN0J3NlQ1dkhDODRTTWdE?=
 =?utf-8?B?cm1CU21Zek9FeXFaNi9ZUUJWaEdYUmJ3TG5ONmN4bGp1czlrSnc3MGx6NUd2?=
 =?utf-8?B?VnBybC91cENFSmhFenk5WEtndEV5dzRGbHI1dHlmTEMwNWh1eFZaYVlMUTdG?=
 =?utf-8?B?akxCczJDTTVBcVRzMk84djBsQm1idzFBOU1MU25pY3JTWmJJL2NRSDB3c2xH?=
 =?utf-8?B?WWNhZVlnWWNFb2lKM3loYmhNSUhBc3RqUmVNdVJIVGVHUitEREZEbm1VcHBT?=
 =?utf-8?B?a2FRU1N2TE9maEh0L3pmMWVDSFZMMDNMZnd1c1JUWGk2MkxNdUhadjk0bGtT?=
 =?utf-8?B?VFVrLzFMUnl2V1VLQmNad24wbzRkdUVENTg3NDRuSWFEZzhMQ3hSdmJuelFq?=
 =?utf-8?B?L3g0a09nNzdoREZmNkVGaW1acVFySnVza1pFeWZnT3MxT2NlSG0vbFFtRHdv?=
 =?utf-8?B?dWhzaWJET2Zwc2RQbVR4ajlDVHBrYnppSWIyY1hxbitzY1d6QnBXQ3E4VDVl?=
 =?utf-8?B?ejZMcHNsM2J6SHZ2UHBua3dhd3NXbDlvbjF3RHpqYmVTR2M0NFBYZlBhUzRs?=
 =?utf-8?B?Z2M0R2V4VE1MazR6K29pRjBjWGJmcFovamhORzVicmlKMEhTci9aWklEeEdm?=
 =?utf-8?B?NmQvbUthcWZ0bFR6TEJzcWpGclNZdDR0NHpGSkpGcnY4aXlSS1NKb243YTdu?=
 =?utf-8?B?dlZ2MnV1VmpEQWRja1RncGdKMWhSSStOcUdKYXNld2NvWGN3NUtYenl1bWhC?=
 =?utf-8?B?aFNMNTBRMzBVMnJadnBKQjNrL1pLVmd3bzNJUmF5RU9NRmR0QXY2QXcwcnVI?=
 =?utf-8?B?aEw2bVU1N1NJWmUrSER6YVNyaUtwbkFxVEdRRVc0UEY0YThuajJxWkxPQjlO?=
 =?utf-8?B?M2ZROHNjTHFYSE0xemU3OGN3VTIxZlpYWmpVbXZPMk8ybWJwYkVQNnJVSC9Z?=
 =?utf-8?B?elFwdzRkWEVxMVlNWjdlcVRTUUw4MWUzQks4Qk1YRFVka1ZJODBIbmUzR1hq?=
 =?utf-8?B?eklQbEpXZEdjVlptQVo2bm1Pc0JjamVmemlZQkd5Wklnc21iTDg3VU90OFZ6?=
 =?utf-8?B?VG5UQ1lQTjdYRUFzb1FiU1pjMFpvQjE0WGczY3NYQk03MGNmdko5eHNCb3Fh?=
 =?utf-8?B?aXE4WEFRZ2tsTlJmNm1rY3p5cW9zSGhBQml3cklNOThLVG9KWnZCUFVOUDc3?=
 =?utf-8?B?NTIwVjA0aDNoR2JveUlyNHJoQldGTjZnNXhyRE56ZlhROEx1UEpOQUZuRUxB?=
 =?utf-8?B?NU9GL1BFbFhva3FRTXNNWDBNOUQwVkYxMnVRdit5Rjh0YjVoc29ocmdoSitm?=
 =?utf-8?B?WjY5WkNwOWhZUE1QeTl1YmpXbUYyczR6cjlVUEpwS1RuanAwUi9SM2tPQlRo?=
 =?utf-8?B?VEJYb3V4OWdMb3FxNU4rK1pwbjhIWUlpMVVJRUhaZFlBa0lXNDB2QkRJdEJ5?=
 =?utf-8?B?OFRFclY1bUJ6cENYeUZwcFI5NzJ4NUVKRHp5a1Y2dkZEeEM5QzRZM1FsYkdX?=
 =?utf-8?B?KytxZ2NuNy8vcXFZM3NtZXVmQWhqOEZNR1pqRzNaTS9mcnIwbnpjWnc1U1FV?=
 =?utf-8?B?VWp4MTZJNzYxQ3l0R3oxSXFhTGdkV2ovMlloVDZaSWZlemZqdXltd3JGRlRU?=
 =?utf-8?B?VVplQmN1WUlwejJxU1ZqT3ZpN3NIOWlsT0RmR3dZYmVxeVVtTnl3bVkyZjMr?=
 =?utf-8?B?bnVoQVlPOU9tQkdtaGF3VVVUQitlM09IalZKRWRubEFOMStMMXRPTzBHQjlp?=
 =?utf-8?B?Z2c2RkwzNytPbkQrVkMzMC9vZ2M3M2NacHUxTjF0TTNUT1B2TDN5UHFaV016?=
 =?utf-8?B?Unk0MkM5ZENiQnFKQi9oOHROSWtrUStQM1pUak96K045Y1E3UFZLd0ZlM2NP?=
 =?utf-8?B?SGwyZ1QzUkJYOEcyeTVmQnlZRW0ySTRnMmdRZy9rRXpqMmhkNVFKSFZ1QTdj?=
 =?utf-8?Q?tpprhucPs2Ur1kDkHFB4JnRTT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a26e3f-23c5-41b2-a38e-08da6021a292
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 14:04:40.6396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3QOpRgbafKlwYZLgHNQt34QEsUQ3OC7Jp+9bchkBcls7J3YgWrqD0ooRH49p818WpLPWlJg/qd8p+bjY9Pdf1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3792
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
Cc: Nathan Chancellor <nathan@kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-07-06 17:42, Alex Deucher wrote:
> Need to protect FP DMCUB code with CONFIG_DRM_AMD_DC_DCN.
> Fixes build failures like the following on arm64:
> ERROR: modpost: "__floatunsidf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "__divdf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "fma" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "__adddf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "__fixdfsi" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "__muldf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "__floatsidf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "__fixunsdfsi" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> 
> Fixes: 85f4bc0c333c ("drm/amd/display: Add SubVP required code")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 2 ++
>  drivers/gpu/drm/amd/display/dc/dcn32/Makefile | 1 -
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> index 6a25d64dd15c..6b446ae9e91f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> @@ -370,6 +370,7 @@ void dc_dmub_srv_query_caps_cmd(struct dmub_srv *dmub)
>  	}
>  }
>  
> +#ifdef CONFIG_DRM_AMD_DC_DCN
>  /**
>   * ***********************************************************************************************
>   * populate_subvp_cmd_drr_info: Helper to populate DRR pipe info for the DMCUB subvp command
> @@ -698,6 +699,7 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
>  	dc_dmub_srv_cmd_execute(dc->ctx->dmub_srv);
>  	dc_dmub_srv_wait_idle(dc->ctx->dmub_srv);
>  }
> +#endif
>  
>  bool dc_dmub_srv_get_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv, struct dmub_diagnostic_data *diag_data)
>  {
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
> index fe29725b4c06..932d85fa4262 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
> @@ -27,7 +27,6 @@ ifdef CONFIG_CC_IS_GCC
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> -dcn32_ccflags += -mhard-float
>  endif
>  
>  ifdef CONFIG_X86

