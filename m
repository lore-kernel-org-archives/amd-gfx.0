Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FC5C04A6A
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 15:25:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 808E810E37C;
	Wed, 16 Aug 2023 15:25:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 860B910E37C
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 15:25:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5KgLflmWhQJSzq/z1XGVY/OUnacfG6Jhxa4AkdJ+Ay2NBrZ8fbri3Gz3EiPhQSUxpoXR06cnUCLWd5mryRuRl4/2FeDf9jc0W4F3GBAFx7hQDsHghv8E93camOuYcqQtCbY0gCzYA1pKG8ifefKmTszBABqW+SAf3sNEMBYwcuAH5BQJrpd+RlGJWQJyrFBZQ3n8IyWQSGoYUTFp91+TzE1qXT9ad1PZ0O4Ul9JhmKtuwWaZQa0MKnRV6/dHd4PQ5T9gUOcaVp2Vax00+BSQSiWmWa9eV+A2hMl1OiC8+om6/a6uedGthevjpUeoa/qpWwbHQ87I9wFYHJhnXhy6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ih99d68ZtpbRBmmOw4DAX6SVBgrpoTZHep1huV//dPU=;
 b=LO3iq/Q2QpjyMPFUync4jv9ARw4M44mXbD6KfvihoAIIgqLes1kuoCWWems0oEjYlQZKmVlRO7328aNh3uLaVvWM6q/bPJPghyQkilPuE6QNyY+LQP24dcVvkk3Ky3nnwD0v4fcBRKY7pIHDv2SEe7imwGtMAvbqn6GA7whwsUNwa2CGJ+UsEjBuxNUcYierg0Qxuj81C3XvpY4dVgcw+lwhG5WyBeTQKxoubKetJ+Qt0iTy5Jt5x4YiG+Q7zO8GAPC3SN0l470Hlg5OWgWFku8WF2pWsTeD0liRxZYfHree1O/zt+DlzfF5Ec6C9rQixIzpqU7IJc4tkqHYpwrIZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ih99d68ZtpbRBmmOw4DAX6SVBgrpoTZHep1huV//dPU=;
 b=01bT6X7C31MBC78r8tMUWzwz1UrjxsTbR/Wsqz2ZgKaIZqi+ULyLjn9k2ARqELQ1xzX3guNh4OZba+ksLLgGzwEql2eB1Ufck8ByxrkbfFHod+83sjEYYaLSVMQkA/fPnauImmi40GfKKRYpFGkQN2iioWxItD1eAjmOuvJlJU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CH3PR12MB8851.namprd12.prod.outlook.com (2603:10b6:610:180::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 15:25:38 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::236b:d4e2:6fbf:6c2b]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::236b:d4e2:6fbf:6c2b%5]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 15:25:37 +0000
Message-ID: <6089f8e9-8c5f-4d0e-805a-b5bcd69f9275@amd.com>
Date: Wed, 16 Aug 2023 11:25:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "Revert "drm/amdgpu/display: change pipe policy
 for DCN 2.0""
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230815212948.1841247-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20230815212948.1841247-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0151.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::9) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CH3PR12MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c8998ab-d38d-4c68-e23e-08db9e6d0ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XLJtGMv85C5d+6pZixIP3HNQ3875/fZb/hh+ZH1f7HXcGA4mKag6phg0qFHlUXgEydFSU3Vn9k7Z3L7rlqjBcmNRPF2ZVVca2McgwNWF28fzWBt5lbicBU6FufbwLQpD7IIZiw+u1OnV2Cn0nmRaSvrJDEdLhQvKG44accMObwQAGx+nD6UWq1u6MRuOKBhmf55l39+XcXQw6acvELZmf0hqofZgT0MyygI0Pd2paV5wIWsXM4TD7Xq9B3h4mwQOjpBxo6HB369L9Rl3wteD/rNVgcGFIQSwgfyZr29gaaZggx2RRG8SeP9sXb/Bss3MMcftWm/b3bC9Em1Qps1NbovIOqBkYVy1xQCYsghBOye3RsmKZNDze329YPqez9CLaOsAV4DSCrnKr1zmZ3xlf6qgFj+969/HD5LWpb/EjoQJoYoMcsM1R1a53wxKdRGi4WpxryVnmdaMP+CNUb+yGVoP41NOtIsV8kpntpk4cVamWBqOA8NELubNUKqRmYZPC6A+qhcX2OagKvDR8yWotDeH+ZnnSEHS5VVg2TlKe1mGoUsgrCcq9uf0Ce7kUkc3TiuuM6S5RnL9BB0mh0iuzdlHAEzr/gK9B2sxBQIR/ZuWGJr+BMtx/KRjeKweEI5S
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(66946007)(66476007)(66556008)(966005)(41300700001)(5660300002)(44832011)(38100700002)(31686004)(8676002)(4326008)(8936002)(2906002)(83380400001)(26005)(478600001)(86362001)(31696002)(6512007)(53546011)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUQ5VDcwc01GUitMNlBPSTJyajdmc0NLUzN5aVlObnlQSVlheHhOYmptcC9H?=
 =?utf-8?B?Vm9ZcTZNc0JTLzJUZUpYRDNwR1B5ZkNHbWNITVNZSWZrcWw2LzJKd015ek5l?=
 =?utf-8?B?blk1RjNodWJta00zUHNoTXdXYWF6dExzMFppRzZyRkloSTdpYkpJcWhrZmhl?=
 =?utf-8?B?eEZpT2loN0tPZ0RxS0R5a3owNThYeHBxdUtMZHRpSzN2eUZhUU1USmoxbkRr?=
 =?utf-8?B?WTFwV0h1NWhaMUkxenRlamlpUzVXM3J0ZlVOUmpsVlJtUVo0YUlIUmt4SHR2?=
 =?utf-8?B?SGhFY25LQ1kyU0dNWGpEM0xjSEVPU3VDL2g2UUNpcjJuOTJ0TGVpelZja21s?=
 =?utf-8?B?NHdISDdjTXRPcGNzN3pUdFkyTURXSWFKSkFWYXNLTGhhZFM2OFhJczhzUytZ?=
 =?utf-8?B?VUJGcVJtZTR2cmNlT2x3K1FjenFzWGJ5dEd3VmdaL3dCbk50RXd5NzYraWxL?=
 =?utf-8?B?dlRnU1FrNzdrVTN4eHA0MzAxRW9lbXZJMFpMWGw3bnpMcGdKWGd6T2t3dmF4?=
 =?utf-8?B?WGZNb0Z1M24rTmdnb0hzc0phbHBUTDFXQ3Z0SDBnc2JFSnVjNFM5OE0vUHpV?=
 =?utf-8?B?MldkTnpUVkpzVTRRVXZ4SytXbGFIZUwxMGtxSUlhbDBKOEtVVGdhUlo3cHFo?=
 =?utf-8?B?RkxZQ3NoZ0pETWx6bXBHakJCSXl5MTJHYXhubGxRUG5GTmJraDRLZVc3MXVC?=
 =?utf-8?B?cmt0NzRyYzNuUDRxZFpIeFNTNFJVQUNTSlpTNzAyem9UWFJvbWtpVitDcjJW?=
 =?utf-8?B?UkJkb1A3bG1MSXpibW5NS0lnZmRXc1UwYnNQTjRzTDFTQlpzY2VsZzBCZm1P?=
 =?utf-8?B?QXNlbUFuTmpJemZkbUxjNzg2dXo3M1o0T256TnZHWlBOSVN0K01EYmVTeERX?=
 =?utf-8?B?ZVNWdnM3U20zQm1kOUtHR1A0Wk4yeVRFaU52bllzR1RTdExNWVlpemEzRHdr?=
 =?utf-8?B?YVVzQ0I3RDVORHE2RlZYN0VSam94cUZKV2tYZVE1UEtHSlY4Yzg3MEszTlN4?=
 =?utf-8?B?dkRMZmtwTUJ2aGVZaklhL0NKQzl5UDVubjZReHZaODZCeUNzNGw5ZVdFYkM5?=
 =?utf-8?B?QTdpeWRmNVBDeHlxVS94eCtCVG9wVXVDelJ2Q0doMEdISVJDT213NlgyWWxu?=
 =?utf-8?B?MkxCYy9EeS9Rb0UrUVlQUkt3enpQeGorWENxbUlRQzhsY3FTVXNlV3ZVVzc2?=
 =?utf-8?B?cUVYV0hZYmJ6cU5YbUZmUFl2UFJsUUNpREM2ZDk0Q25QT2I4M0RGV3d6SUdh?=
 =?utf-8?B?c2NBNE5PZjFsMUN3SGVkREtrUDk5czJNa09qZGlYWXVKdVlSQTNURkhRQk0r?=
 =?utf-8?B?bzBJR3p5dGhSTGQrcTZrbEhUS0Nqd1JybTl2WVZvYS9pY0NhQTNkLzNHVFNu?=
 =?utf-8?B?WE1FMGVBL1lBMmdRMHd1ZDVVS0t5RnlBMGFpZ2x3eGZIRU9BTG9ucmlnK3Rj?=
 =?utf-8?B?TDFGV0VrK29KbkdOVzQyakxNYzV2MGgyY0pndmZCU3FYQ04veDJ6MUpoVU9G?=
 =?utf-8?B?dXYwZ3NONmU0U0FHV01WQmRuQmxNLzZSN0Vsa3dnRzZLUjRTK2xjaVdRbGd0?=
 =?utf-8?B?RWtqMFdFR0grRjNRL1o2QXIwYy9XclM2RStpMWV4MnU2ZmxSQlk4VVl3bnRI?=
 =?utf-8?B?SUwzVTFHUzJoOHhtNllOOWlBcU9qU0xxa1NGVEtxS1RvSUVEOVMvcEFVVm5B?=
 =?utf-8?B?SnUvVC85OWhFdWRmSG5CWWY2MmpqSlViWksyNmNGUjQya2gydjNUeUlvU200?=
 =?utf-8?B?eUo5bnM2RVMxRjlpeE9yVHFiMkMzVlF5aE9FaDUyS255cHFhSU9NT1E0MEFK?=
 =?utf-8?B?R09BUEwvbGEvWlBvdHZwdW1kRzArTExVenJaN2pML0VwWEFub2NMeUk5ZFJo?=
 =?utf-8?B?TXROTFFrYnNXZzArUFNqNXoxSHA0azE2bENEQm43a0pzeDlZUFpTcHBPTVQz?=
 =?utf-8?B?THJwdVBoREgxM3lrbnJ4SDNtaHNjam5yZ3hIZXBCejliZWVNaFNpK2VRYUQ1?=
 =?utf-8?B?ZlNzMzQ3OXpxajFiUWNVdWdpcUsrS2UzWnFxdlNTbTNWMXhDUTBFMi9zbngz?=
 =?utf-8?B?VDEvZTkva05USmQ2bzI4cE9WZEIzOXRMVHVtQktZdVR3Wmd6VXRDWDFSWjFS?=
 =?utf-8?Q?T1tqWqIHJF26voD2ON+Pv3ftJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8998ab-d38d-4c68-e23e-08db9e6d0ada
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 15:25:37.6573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4v+qMUNfQt182zzhqQSZfTuCXY/yWTgjwGKuYxZPk/N1lGFFSvWDTCdHDZZ1ADrW+oLtmRnIZWDIf2a9OUyT5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8851
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
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-08-15 17:29, Alex Deucher wrote:
> This reverts commit 27dd79c00aeab36cd7542c7a4481a32549038659.
> 
> It appears MPC_SPLIT_DYNAMIC still causes problems with multiple
> displays on DCN2.0 hardware.  Switch back to MPC_SPLIT_AVOID_MULT_DISP.
> This increases power usage with multiple displays, but avoids hangs.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2475
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> index dfecb9602f49..000fe96203c4 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> @@ -712,7 +712,7 @@ static const struct dc_debug_options debug_defaults_drv = {
>  		.timing_trace = false,
>  		.clock_trace = true,
>  		.disable_pplib_clock_request = true,
> -		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
> +		.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
>  		.force_single_disp_pipe_split = false,
>  		.disable_dcc = DCC_ENABLE,
>  		.vsr_support = true,

