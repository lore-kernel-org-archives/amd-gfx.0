Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40060C25B48
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 19:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEAF510E87F;
	Thu, 26 Oct 2023 19:47:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B1E010E87D
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 19:47:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdurWeVAyimyPblOsvFSvF1J2yWsTyJ0LN6BXIxR70XEl/uRWYg5tlfDXBlVVBek5XWYCJapnwUYZBOplcG33q6WUVkIXnUGOOKY6e93joyY+6r2+V6vh3f64EL5K0C2QSdImb6NUTkhbOM1RpX9Rs2D07H+8MoeCDrof8ZC2l1lqr20M9cVwi1krzhnYYDRcdImBxguRbCxGUbf2/h8DrV/U311anj8GSt0md+YhVN5oW0andNHZwsl8EBloxmTqk4QbC2LxvK0k/RmnEwPnMfJB1j6jkHwvrfydogD1NeDkTbDH0PBLPBFtzImF5MhJ+8NNMHLtbkrXvxPRJi8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKwE74TQOsWndPFmW3IQ8oKE+MwWPQbiQVul0NFcO1A=;
 b=VIcQ0ZjuDFxPVm2nqyCGigXV3mkPLW+z1vxowF155VjL5MtqdfTCxOOc/wcSu6wuMNpfakT4r+WQdgLKIPyk3IRBTWg2qUFrp5r5byyMykLlGEy2jMYuqDgV7xwYwTgL7wnR9c0K7+EQ4VzBKQiFKzkGfLSOTCY6TtBl09rpjIJ7xH3yeYkll2fXHcMj6POjD3D/mz5xt6cTWTsCvfsu3lCvjGeIRuzww6UqJEBFGu2lAgoXf3ySCG3tj4dir5PssURNRMaB7hw0Jzublt6C+kLu/Kgs5zzlDYibZhFI/hYrnDARsNKN5/EMdNhmtCrkMV94L6XyhAb5LAJ6JJyAnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKwE74TQOsWndPFmW3IQ8oKE+MwWPQbiQVul0NFcO1A=;
 b=VyGFkT0b7Shcf6FRnQAZ1qzLZxwbhLSxzSZwx1eMrmcOR/G/yEU5gQJROV4paP7zUXyqOJ7HLhNhO9INRJIX/k9KO6jch4IluhnJB/NxJMdN+EZJ4Vc5kQoFTLqdX5cumWyKGu1nGsyudl7DJWnpq1Bx8reRROSoPR7IEkP8WZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by IA1PR12MB6331.namprd12.prod.outlook.com (2603:10b6:208:3e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Thu, 26 Oct
 2023 19:47:29 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9aa0:6ae2:3699:74eb]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9aa0:6ae2:3699:74eb%7]) with mapi id 15.20.6933.022; Thu, 26 Oct 2023
 19:47:29 +0000
Message-ID: <6a2e1ad3-a3d3-4aea-9474-3cd15eaf831d@amd.com>
Date: Thu, 26 Oct 2023 15:47:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix S/G display enablement
Content-Language: en-US
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231026172914.31796-1-hamza.mahfooz@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20231026172914.31796-1-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0187.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::27) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|IA1PR12MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef890df-d54b-4723-c6e3-08dbd65c62ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D7WCx7sLspycqze28AnaA/1jq6I7bPq8IFMFUurtwrYVXXrPVZZ0bVXBfhUEEngHKsYdFV8WzCm08NrTKwnaOTgWISyR2QX0xtFxGLryCMcjXo/FQESUo3n25R711KpknuYKqVasuc913z2qFM6prVPhur6uPFsaOeI3SsxuSSLvPvW6KZygvkzOIgUuAIlO5FQv73Pc0D7UQIURCEuq79aVn5AW7PkCTAwa12/A87374z8/oLUPwWr9TyTI1s6Br5+C1wIgnCCU1jxX9f11zdM5U9pUjsJva+keLWi64smFbnTXqW/sRkZT/GrDIqSLK9/7S9uZSTKSNKxdhgtpqHlthbICAdjhV1Y9MMhvJiXFdPeraZOwZXeQKcTetRXBSjjLxHBDcHqojkRhHZQXKewsxTQtsicMs7+u6QDCofGN0Nv9K3ql8vs83ZCEF0/KYJVwoBoGgGPrHkFdypn2hTfalgA0L3DEmqrb+vO7Ibu6I8yd6DtkeFKLmzy6dwtzIHPkzO3/yg8jWtchHZdqFACTeC1CMyj1Lj0sEfaGHMozhydmdXQB4bRq0x2qb6nBstC5UY3AF+f9P4GHi2eaDFoZF6L78oFOflF8OoDUQIVu0oUZfxftMN2N040zv1F4deATj4oO55zvV4hwrVq+rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2616005)(6512007)(44832011)(41300700001)(5660300002)(26005)(6486002)(8936002)(8676002)(4326008)(478600001)(66556008)(66476007)(54906003)(66946007)(36756003)(316002)(6506007)(53546011)(6666004)(86362001)(31686004)(38100700002)(2906002)(31696002)(4001150100001)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z21HbEQ1NEtSREJ2UExCejdsWHNaQmdiNnRxZm0rRis4eUt4RTJCVWpFR3lP?=
 =?utf-8?B?Uk82eGY3N1FSZFZ3UEdCMHFIbjJtaEgvY3VtbmtzckI3NjVxSVgyOGRmdzAz?=
 =?utf-8?B?VU9kMW9xQTJYd1o0Y1U3eUpXbnZyaytwWGpGVzVnb1VBdFJOMnkzMlBsTHZk?=
 =?utf-8?B?OHYzYll3b0pDWGxpY3luMjZqUzhBQnJqNWt6L2NiQkxiNkRYQWkzSlNnSERB?=
 =?utf-8?B?WXZkcEhiS3dPUGViSkVWYXBHQmVPbjhzcXNEbzdReWVzeDVPK2t0RnZQSXp3?=
 =?utf-8?B?Qm0rTEhzNGxJM2xMTzR3aEVzOG1OcjlwaXg1cGpZM3ZZTkhpRFRzdnBNa2tW?=
 =?utf-8?B?Wm91anhhOFpkVDlpbm1KbmpjNUF4ZXlESnk4RHdDTmZibENpdXU4d3F1c092?=
 =?utf-8?B?TGhzcWdQL1gxTzlLOEtnNlVadVl2Q0hYbExrSWpFWEhmaStpOE5kRTdRZW8x?=
 =?utf-8?B?SzlhNnFFS2V6VDdFV0ZIV0ViV2xEWU4yMDRZVFpNeE8vdkpRT0sybHhvd2p1?=
 =?utf-8?B?KzZWZkN2azBMa1NkazAranJWSHI0bG9LZTVGd1FoQmxZNXBEZ0xRV1YxaVhs?=
 =?utf-8?B?REt5MVRscXpUQ2piWSt4Y0RmcGNvS1J4c04xdUkzOGxFcG42eUpnNWxLWVlw?=
 =?utf-8?B?SU9vWWFEcWViTnhzbGFTWFMvUVM5bHpQQTBKeU56YytKYUpNbXhhTG9KOG4v?=
 =?utf-8?B?elZhdHp2TUIyc04xQmpydHBudFlzTlFrOGZVQnhjazlUWTF5ekhBSTQzTEV2?=
 =?utf-8?B?OGR3VUJXUitoNnhPZ2NnODJsc1dHUGp3blBnVTZxclUzZWVGOTBWcjNESWxY?=
 =?utf-8?B?QTFaWGFhWnZjYzhScFFzU285SHIvZWtwNytwRTFKL0RmZlZPYXhYY3p4T3dF?=
 =?utf-8?B?TUJ0TU5TendQZjIwK2doOWFYczJsckJQMVdsYTFWZWJxakphKzdoUy85RVJM?=
 =?utf-8?B?YkNQU0x0OHgybUdOWUhqQU9DKzkvYlB6Y09YNWUwRC9PalQzOFR3OUU5OWpZ?=
 =?utf-8?B?T2JyOGUyV055ZTNyT3EzL2JhVjBxY1VjSXpyUTRzZnZqQ1VWTkw1Q1NrcDJ2?=
 =?utf-8?B?UWwxNUg4TU0vazN0SUJIV2EvdU9SS3VpbFdzcWdYZEoxdXZoLzFSN24vME9L?=
 =?utf-8?B?bWZIWjVrU0VMWTlieVpCZ2p6YUljT1FFR3pmZEp1bXhncHdHRE1adVo1ZStT?=
 =?utf-8?B?cHp5aXpzdmVsUUxJeXk3a3BxUzkwbXBldXdaSXhEMWFFRzdYb3Jhd0ZDaVNI?=
 =?utf-8?B?ajJ5aU54ZGthRFRJMlRVampZcmU3UyttOUFhS2NMT2tjTzcrQ09VV3VWbGoy?=
 =?utf-8?B?YjQ3WU1sRlgrdWJBWVlQT3FCVVdvaGYreWpyNmlCWksyTFp5VGY1OWhnYlhE?=
 =?utf-8?B?WDRxNjZ2NSs0Q3BBSVcyQVh6MWpJMW5POEpTZkVWOXdnMGlRTnQ1N1FqRjJ3?=
 =?utf-8?B?TTF4K0ZvTUZGZWZCWGZmMEFVSURIUHViTlh0blpLUmo5NHFZMU9TU0o5Nmw2?=
 =?utf-8?B?MlordEg3eWZ0KzcvVWlLQnRLMHJLMkwrS2FZWExnWjFIRkxBYW1WckFhSTB4?=
 =?utf-8?B?N1JENHZPeG9zdUVSUnZseU1xTXE1N3c5TmJVQ2JBR0YwNFQzQTZyZ1JEdW1Z?=
 =?utf-8?B?UXMzRnlFVUlhNDNFOFRNdEdaM3FaeG12UHNud1hoTExlVjhQdnJpeHJLK0ZX?=
 =?utf-8?B?V2x1QUhFOFRpSGk2WFE2WHkwdzhZTWRWVlZGWVMyRkM1aXoxcWRST1dqZnFa?=
 =?utf-8?B?a0l3SUpmbU9BRno0Z0NudStlaGtPSy9lR092Q3dqVDJtZzRaV0ZDYTVGaW1q?=
 =?utf-8?B?RlpqRnVhNmRNTFJLRjJyL3VNL0haUk1Icm5HVllkcGkzZmtKQXZySHlYcUVF?=
 =?utf-8?B?SlJoYXdpSGFVenZDL1FBa2o1TkZjN0hjZHM2c0xKWDR3NHBtOG9qTEZsL0Vk?=
 =?utf-8?B?R2F0RDRKYkovZk9zZ0dIVSsyTU9HVnRXd2JjYitkT2lkRFpRZVBudC9ubkg5?=
 =?utf-8?B?bjhSOWc5UTRER2tEYm5GOU9YYzBRcVV6U2xTTm96UEpFY3RDZDlRVGljVUxP?=
 =?utf-8?B?dG4xbnozRFptVWM3emNUV0o3V2NkYXdPdnBldG12ZVJNRHpjSUlCWFZERmdK?=
 =?utf-8?Q?sA++1mB+vC0eAxYvk1rlDQs6T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef890df-d54b-4723-c6e3-08dbd65c62ec
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 19:47:29.0224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jlgSjyrXnfdsxcFHReYYhFgkhuWTxkPq8tMEc4EiHKmrbIHcMZlPc4iMrbip1rmtB033qY5fPOUyLwlLpvaMIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6331
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>,
 Mark Broadworth <mark.broadworth@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-10-26 13:29, Hamza Mahfooz wrote:
> An assignment statement was reversed during a refactor which effectively
> disabled S/G display outright. Since, we use
> adev->mode_info.gpu_vm_support to indicate to the rest of the driver
> that S/G display should be enabled and currently it is always set to
> false. So, to fix this set adev->mode_info.gpu_vm_support's value to
> that of init_data.flags.gpu_vm_support.
> 
> Fixes: d059c2ec6a23 ("drm/amd/display: enable S/G display for for recent APUs by default")
> Reported-by: Mark Broadworth <mark.broadworth@amd.com>
> Tested-by: Mark Broadworth <mark.broadworth@amd.com>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 781d04eda3d4..adbeb2c897b5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1641,7 +1641,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  		init_data.flags.gpu_vm_support = (amdgpu_sg_display != 0) && (adev->flags & AMD_IS_APU);
>  	}
>  
> -	init_data.flags.gpu_vm_support = adev->mode_info.gpu_vm_support;
> +	adev->mode_info.gpu_vm_support = init_data.flags.gpu_vm_support;
>  
>  	if (amdgpu_dc_feature_mask & DC_FBC_MASK)
>  		init_data.flags.fbc_support = true;

