Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7827CC48BC3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 18:47:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A76910E76E;
	Wed, 14 Feb 2024 18:47:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uJdTCDPA";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDC4310E76E
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 18:47:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3tSxhWGatYpCJ9/bAeuGyscBvco8KiWloANjeLu+kUTP+IIvn1cMI9o5p6LQ7CiGwgJkTkHsPcwdR+Dg8qIReYd7YREzf0mSCqXnkuHmywRUnNC6j4VKR8qFNQuMjfd1JNFbP7OnRwiyRvsL6kL6K7wokvqHLTJsc3alOKq+7ULy/nBNevIfID7n+u4uNHegRB2uReQuiHCPkBkiCzVqTdGyyJr8d/Ly9WrLr5G0njbcDS+twUGbpQpWCBaXX2/HU200Hl66Wa+E+VGULz4DO4f+30hw601M5cfoikgreKTU+/rePjCZZrBzCAePD4YEVyxdu0fsEBG/89aGATMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ti8sLd4RN2JIHC5mQ38iv4JqoBOE9+cUTHs6IKdhOM=;
 b=astoAOVATNfpM/mvuXnmAgwnRy5u1y9+FVo8p/18w8YzjXzNjZJg2rtc4Cqr5Wp+d5Rjfs/CI/vO1DN4Wfn1LFjwsrL0x1dhSEIK/tk5/TumqFjjnB1ZNd8aGDnRFUjyxnetgSkZMoWtQ+TQwZKNdQyrt2A7pM7ThK2DXyHjg8ULolT60v7G0deSGz0hNHqao01QA+8QSb9J+44RsfUHkS97DdxiV3A++/kEbLY7Uq8CwBTTiMKIUNPDBebdFNC7U60zipyaQ87w+oNVgOMcXFf9tcP6Y+UwCW9UVC7Lto+fWxOTTC+L/ih9/GR6+DET4DGTIWPD+KZdRcxzTkXSeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ti8sLd4RN2JIHC5mQ38iv4JqoBOE9+cUTHs6IKdhOM=;
 b=uJdTCDPATdG9KXngWe5pGLSg2iY3OZ82eCPaOELiZ4CDwQ8MdItlHc4ga7vfbO2FcxAgzqv4N3hBnFN+s36sdtfrXDF1kRVteUZpYvrzoYtpa6u6t78IG63PdqUOwdnkBIRLRpTvnuBTv+jgltiTxNOhUw9nAY8nlfgK1fSMpLg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 DM8PR12MB5461.namprd12.prod.outlook.com (2603:10b6:8:3a::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.26; Wed, 14 Feb 2024 18:47:48 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::3301:dfb9:528a:1fa5]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::3301:dfb9:528a:1fa5%7]) with mapi id 15.20.7316.012; Wed, 14 Feb 2024
 18:47:48 +0000
Message-ID: <d3dcc699-d7e2-4654-b844-ce691a0f3447@amd.com>
Date: Wed, 14 Feb 2024 13:47:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] drm/amd/display: Remove break after return
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Sunpeng.Li@amd.com, Aurabindo.Pillai@amd.com,
 roman.li@amd.com, wayne.lin@amd.com, agustin.gutierrez@amd.com,
 chiahsuan.chung@amd.com, hersenxs.wu@amd.com, jerry.zuo@amd.com
References: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
 <20240214184006.1356137-2-Rodrigo.Siqueira@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20240214184006.1356137-2-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::25) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|DM8PR12MB5461:EE_
X-MS-Office365-Filtering-Correlation-Id: 020d7411-4dc8-4677-cd31-08dc2d8d70d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YFBSSWzMA7crJE/P2Ac8vqrnSYsM1MKLsdoK/MzcoVjfQhJJ5fQ0wjBkcQEJxJEBM5PEvBErXImLsc28UHz+APVyIWjvZC4W+b/nfRGTfYYu+kULLm1DLC3W+YwXD5ZVWiqw4iaFFRw9xUjRiZfKv2PLR/wsmRDCrY4KVW4E7GsWqWb8yXtQNj5vBAyo7Oq1l1XWB6z5Ev4wfLEItzA44yqrp6EafAFPpPKbpebTOcXOaDDAvRHryEgOEufx63Ye0cSQH5YPcZMQcPXkBqGvudQqlES7XD3djHQUMWJn1WoZd/6OkuZVvlZ/q0ogXirefL14dz4Lj/pl2VUhe+OOdCoE5JQSJdTuc3pIM39So8hRA7HXcddedGAtV1G7TYC+OUZm4OtQkSW8GTchK5J41duU1Akpd/w8964IBRDOPyHh2jECH3yVbrWcjelXUMHZ9AFA/U2mgOjgkxo8RC01DSVaOoVQhdT0RFuNnXqIjK45lNZIL3yZBNYsIhzBsWJQZ1KGWZ2+/KaA9RAH/PxcvGlEoCeFVfF6hZkkyKPbTO0TKhdR3xav6XqEx79OAKHj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(44832011)(8676002)(8936002)(4326008)(66556008)(66946007)(66476007)(4744005)(2906002)(83380400001)(26005)(38100700002)(36756003)(86362001)(31696002)(316002)(5660300002)(2616005)(41300700001)(53546011)(478600001)(6512007)(6506007)(6486002)(31686004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2xWcHRlOFVMK3p4S0xOL3JpWWRYMVZUZEFXWXI3Y2pTaHdVMEh1RVJ2Smxs?=
 =?utf-8?B?Smw5bWQwVTRwZXo0Z0dyTnhTeXFCNXRNazFxQlNVT2U4ZFRiOGNjYWVKTnN4?=
 =?utf-8?B?d3A5RUhBdVY0T2dURFZ2ekwvUmZ2OUk2V2VZclA2a0trcWcxK1pyQUZwcUdC?=
 =?utf-8?B?c0VPSnJMQ1RzaHE2NXRlbVUvdUpVR1VnTktvcXpGV0ZLOURtWlhRNHRWdHF3?=
 =?utf-8?B?TkcvR2NmcEdoT3lFaE5MbnYwaFpGd3RHYU95T0N2QjJ2NzhiMFROMm9RUzhD?=
 =?utf-8?B?WTBLSmpUdmo5YiszNkJwVDhCVzg1MGg2M1R1K0VkWjlvN2tGOS9jZk10c0Q2?=
 =?utf-8?B?ZEJEUURrdk9MaUFzdzF0dGhFdEZEVjZXNjFYTHJWT0tPa0FzQ0JxT1RCa2dk?=
 =?utf-8?B?NXA5SDM3T2l0VGp0eHcvNmJaaFN4RVhmWU9aY095TXBGQ2dGUUNJQkQ2bzVT?=
 =?utf-8?B?MEU1QXE5V2NnVURScU00c1ZWMGlTUWtqMUY3ZGpWUG9yTmFZRG1Yb0FpMzAz?=
 =?utf-8?B?Zmo2VEd1bUducmcrK2xISVNaek5vV2NwVW11QzMycGpTZ2k4MFd6T08yUzZD?=
 =?utf-8?B?Ym5IU0ZqV2ZtWTlvNzNkckFMZEFkbEhUWm9vWGNxTHlwV25hRm9HME9YUVRR?=
 =?utf-8?B?ODB2WnR3VW50YWd1Vms0aVFwUFhMdlIyWDdINUJoREtncHlpNUlkSUI5MXQ3?=
 =?utf-8?B?eVp3cnV2TWVlaW1HYWxRNVpXTzhVQ0dGdFhpTmNpdG0vUk1NMGpvTFF4OTZV?=
 =?utf-8?B?ODBPUzdLbkpRcTdlTEIrSnhNRUlzTWdhMmdrbXVXdDJaZ2FFTHhkMTltS3VC?=
 =?utf-8?B?MEZIck9YNi9CVUV5ZmRQSTJzTkMrbWJ0b1luR0kwSmhiNmUxdW9KM2pHNmdF?=
 =?utf-8?B?OUlJKzJKMG1xYVlTTXhibXdCYXRGS1ZpYlN4VkVYQ05hRWpxMS9uRzdIRU1W?=
 =?utf-8?B?RkdoWW5Tem9qbHA3cDExK2llOTNWdWV4bHFiaGQzNFhvWlNnbW9RcW1PU2kx?=
 =?utf-8?B?VHgzSmp6cUEycklQd01seHRTVktoeFg0NkthbE9hL1MvNTNSQ3NLNlFveU9D?=
 =?utf-8?B?QndYbW8zTFdTZFYzVlJXeEFxdWYwZWNRWmpEbmY5eGV5RVZ4anFpYXVZWlpQ?=
 =?utf-8?B?aUVBcDl4eVJhSEJqM1FpOGNVYndHUU9KSFBNQ1dGRnlsZC9ZUGJHTy9jNno3?=
 =?utf-8?B?U3lVMG9BQVJua0FvMkZEQm9icGM4ZDVhSjFOMU4vUEtVcXJkTHR0UzRZSGw3?=
 =?utf-8?B?bGJLUXVJRHBRR0tpZ2pzMWQ2aTExcGNxY05WR3oyYlhva2Ric1VhTngzQVQ3?=
 =?utf-8?B?UVBTOTlyN1dSU0Q3THQrbEp4ME1kcDBjL0ovaFV1eStaSHAxRXZxSEhkaDNi?=
 =?utf-8?B?c3RzeHJERjJLbllIMzJjaE11YzRPekpkSC83NUgxZEJQYjFUTGE5Z1BvRElI?=
 =?utf-8?B?K2dQMU0zTGtJTTBNVTVyRDBCOUwzenpNMFMrZWF4dnVVUVh6ZTFxSGZVOEFq?=
 =?utf-8?B?eHVhMnVoV0tyZjloeUNuM1FiZzBRMjFJOWRwbFppUnl3R1NvNUVIaFAwNDNH?=
 =?utf-8?B?TE9hNHh4YW9PTUFIQmlrbTRNMkErdzJ6UE0rcnN0azhESDM2QnBqVUVrTVI5?=
 =?utf-8?B?bUE0czNFMjZaNGxZUTBJL3NPTmpkc0xZSU1JblI3R01CTGFXaVcwVkRLTXlV?=
 =?utf-8?B?d3JZbGVQb3ZJRW9NTzNkM1pZTS9CMGhTalA5aGNkMUVMN0IzWHRPa1ZvcFhG?=
 =?utf-8?B?N1dOSHJ2L2hJLzE0RVZiaDNrQjZDNnZ4c1NkVmpMVytreSttalo2dk9vdDRt?=
 =?utf-8?B?L3JlQ05pUWFBTzJNSGJ5bGlkQXR5OTBuMElraEVwTTJQWjQzUDFMUmg5bGdW?=
 =?utf-8?B?U0c0cWh2YXVQYU94Sy9nQkpUY3VzbVhiTUxNWGpXc1lrQWcrWFc2Rm1mZldT?=
 =?utf-8?B?WVMyb0g2YklrOXMxOUtuRU1SV0hIWGpBMlo2NDkxNUZabHh5eWJFRHAxZkU4?=
 =?utf-8?B?a3U0L21XM2dEQXIyajlDTU0wYVhEenZJNiszQ3JuL3BuZDRMTFlQRVdYUzY5?=
 =?utf-8?B?QVVMc0I1UFJNS0VaWWUwUXllNFV4Y1BqZ0w3QXN5ekRIaDBXa2w5WHZHclFh?=
 =?utf-8?Q?qIUszzDc9Gwf9jX+/Zu8Ck8OA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020d7411-4dc8-4677-cd31-08dc2d8d70d6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:47:48.7752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCmcs1YK/rQwKnIXRCyDYLNXski67Z0KlSRGucxPFa79Nn2D7V5pJSb0be9IHojD6yRiFcPyPQmUBXHbnt2qtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5461
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

On 2/14/24 13:38, Rodrigo Siqueira wrote:
> Remove break after return since it will never be reached.
> 
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> ---
>   drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> index 28a2a837d2f0..86ee4fe4f5e3 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> @@ -340,7 +340,6 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
>   
>   	    dcn32_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
>   	    return &clk_mgr->base;
> -	    break;
>   	}
>   
>   	case AMDGPU_FAMILY_GC_11_0_1: {
-- 
Hamza

