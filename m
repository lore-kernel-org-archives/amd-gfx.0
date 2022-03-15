Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F813C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 12:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F1A910E657;
	Tue, 15 Mar 2022 12:12:50 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2064.outbound.protection.outlook.com [40.107.212.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DB3210E657
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 12:12:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjyqWl2l/Fd5jS+lBgDIF6bssXnBJJ7/Z5bhGpDtj5rVsAi7QhufOESMQcfnhlXonS3gGlYPEEO4gMpOR+0oB6x+VWVzpWepXFq4En1+N7zl0MCzWFRyhdaDhmQwl4LONlZk/hnzieRZdLj2wVrJ46dxYLjdGXw+KyIVLadAYH7pKTzGa3FHFP/ovMJd7lUcWpdQJtKJ71eE9Cz/siIuZLQlNGjBhL5zd8kDz0b/r9PSOSnlT0xqq4OpX2FfDQMcQALiLkKGYRwcWzOE608BJRzDp31VY7F6N4w10iTBTbQE/bCOusZ70hcR1JP70NUhj1ZSsjiVOlpEy25ItBx67w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCrZXm8QDbKJDTaZP03Mb1JvrFvPX1LMcc20OMauAj4=;
 b=HQkhP4j0GRq42QF3IkIxO6oEuct8nDMYYcgwB0ttREyiIzZAbcVQEje5iG2ziaYtdusYGV/ww9pIjkmCzI5l3PbQH9+MI2JHj0wXn+HDOBrb4S2sq32tQsUwdXTgg0NKav4QUB/pQxoqFT15evN3Hva4InkqH0wyGRFrBuNvwvT5ZjcD3nxA7UaFoj8oYEAbGeFvABVYw+VhTynRTIkwhRFTzjJDMfTA9cUh5S3umiXy0G2bMD6HCFMP8t8uGMPulgofT+gbya+3JO+12Saesbyj0h5sNWv3F04icixjmNVNsYV0RlH1ycPY+lDT9/rJbC77b9t1MeIQ1WjkddH4dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCrZXm8QDbKJDTaZP03Mb1JvrFvPX1LMcc20OMauAj4=;
 b=OpPlNY5iOX9BNcIn3alCV6w6c3wj6D1WAjNKp0eaCyuR5+9m9j+GyrrMDUJDOxpO0fLDzNrqFdeG1Jb6I1CwbPk35a53qHGlfqHN84TW1bPAfuAAtyorXeJ66XU4fy0xuQfajsazUdkc4PuZZPsdmHaGHBPNtwjATzKnxyC3EGU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 MWHPR12MB1309.namprd12.prod.outlook.com (2603:10b6:300:10::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.14; Tue, 15 Mar 2022 12:12:45 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90%6]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 12:12:45 +0000
Date: Tue, 15 Mar 2022 20:12:25 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu/pm: fix the Stable pstate Test in amdgpu_test
Message-ID: <YjCCqSQk165EKvZC@amd.com>
References: <20220315102551.3581234-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315102551.3581234-1-yifan1.zhang@amd.com>
X-ClientProxiedBy: HK2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:202:16::19) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6f035fe-dc72-4b99-2af0-08da067d1d1e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1309:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB13092AF46353361C09AAB705EC109@MWHPR12MB1309.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 54pWAnr5CE4SS6wM9ZQewViGmxvpP2PfaNl9QxfvthJ8s356DnDJvcg7e3kxluezLIgSCwUnvHLdbhQkf2iPEu1IEEKZqalnojYKrmVWsBKftdz1Hw3vXTKZltAvv4ltg/cm0v0r0v4gzNTporL5fHQ0/Pm5DedndlVRJWTe5+HWCRSuIDpupicDiUUvvCKSOMgjy9DIEpKM+o5/5a2IbGWLBa8nOPWsiBE2Yw668B1f6/Y3o7per9vHeikMdsP5MoZT+5RG19LRvhxvMzQUfkgBzrc2pMgUawFqUc8hH4G0DUCPTBzikM7cog/bSWr+5NXmose3p9onRsOY5Foq18I844bSVRxqKAYp9eTPQnFwE3g/vVwULH6sVTcy35TT9XR84ursql5yHEnxBal8Bjd0s6ZyAp//dW3+4lzmi2SvSpo9aH+2pB4EftZvcBrIp1bMYwxrJyrfPV5Q3I+LKKMNTM8U0jpC0g0e0199EjlRzghcJ+7/GyuFqKibTdM4QobCwMLQHMs4PxqKgwCvBiSl3P6sCH9lNr/qa96vvv3J16Om/Q+vi2hIwySTK52f0ZvwpBclr+lFlcf8gR1j55yyfI9+kfsmmM5Uqu7DNAsOgKwyik3d5UejayvVLdWj7EalyGzzyhY57wgkPvEwwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(66476007)(6862004)(8676002)(4326008)(508600001)(66946007)(66556008)(316002)(26005)(186003)(8936002)(6512007)(6666004)(2906002)(86362001)(6506007)(5660300002)(2616005)(38100700002)(83380400001)(37006003)(54906003)(6636002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CFv1zf+JAL7TEqNz2b0Pn59AIaIda2lDYUuK6ESkBA7rjBESt57Tj2uZHK3g?=
 =?us-ascii?Q?i+bGf4nUOKU1jf9EU0C3/cJEFzoQkzOQT51Ntpe7gyMnhB99folkc25OEOAE?=
 =?us-ascii?Q?HbMsNrVxzNTVmnjeBqoMXEhCMfAXONNXQRSRyvZmGFL7fYhCWP/CFna4/jLW?=
 =?us-ascii?Q?qt67t0Jre5l85rpdkCzmQMAXeAV/huCj26jTSu6Wm+Zm3x/gvjBXm0r3IsMj?=
 =?us-ascii?Q?TBOWyjQ08QytBsl2ZajD5V07ek/i5HJ2MsiJkbj9ETWxbtCo7Ja8HhMe8eeW?=
 =?us-ascii?Q?+mdMdU70t7EucCk5MKHIbGaQ0Ucn2s5nIXUyC8KA6lGIppURUe6AeZ+q1p9m?=
 =?us-ascii?Q?a1keDqwhe3q52qGXUnpx4VmsyMBI/71lZi7KJnoeh+hmGdotLwz4SOkYh8XX?=
 =?us-ascii?Q?a/jn+wcROYek1dYlQuW6DQXPp4eHHhi5OaDM0GzXpEs7nj9eoQfMyFws35dv?=
 =?us-ascii?Q?iWuFvCwNj/GhSPsswbZigCgfBUIgo92eEys5vRSJJHtaqmCr79r/idMDRgtc?=
 =?us-ascii?Q?OJ12yFdsa5uPwoSLC/xbnPfr068O8HwZZhNJMcr+j50LM5h0LckZeEMsMfcw?=
 =?us-ascii?Q?ZVEsV6H3RxPNd1TRv6q8CSD3aSC1h/ye91yJPnrk0HStdN2bP5suiyBP/nux?=
 =?us-ascii?Q?uCOVY/siQxMBQfRZv1ZuP1cwxRBFTqrsCn2fQGQDkWQAmCFheE5NBqskJxPw?=
 =?us-ascii?Q?lWk2J5ln97eOER0YmFe/BjgwdYmSBjoJds3w+q1FACmHN9SAJ53dA9t9gZB0?=
 =?us-ascii?Q?om8Yh02paiQgEHdefIDQmn/CceEP7g3KhhIJZWyWTiaxoqwzNc4PkamyKGaT?=
 =?us-ascii?Q?ySS3LZVHe4+aJkvPnhuBcUYVKTBGt2UO51h/oJmbEvjaHLeLnXGB0CAk1hrS?=
 =?us-ascii?Q?lap0TdP05qbIm5gx0kUqQVX2QRjGJhD54/sXBRhLwYDjKUY3AGJI7aIC6lqa?=
 =?us-ascii?Q?Cr7n3Rr9i1UTWrmmodZAfOI41eTOuv3oKE9Daxr3J7MOMYz4buIxfWigUA8Y?=
 =?us-ascii?Q?YemkVa3FQc1V2vVGQ4Te2b7/hQJ4h4ODLhpcKPgnPUekrDnrqIChHuP7vEmc?=
 =?us-ascii?Q?KKvYnXTj6t+eMlkEJ5BjqNXHOBgCQEacO8qAgnF6Ui/LK7NbD9oTpglc0WGT?=
 =?us-ascii?Q?FsxWcmkT3N55kEhg+8lRuIbQl1NXv5FC/v5Wr+HExtzxwrFAyyA8Uv18ItNM?=
 =?us-ascii?Q?lJ2+QvN+87ky4op4WuTKKpi+Ns1wAThrM8YPkUZl4LvYWMuETb0ZUO4ChkL6?=
 =?us-ascii?Q?NwB19ohBLgXKoW0h9BE1iB0t+LGIMA7Rn4DpfeyZjKgvJET6SrzIoGxXVEMV?=
 =?us-ascii?Q?JFUWIa5nG7ASVb2kOEow/IWxc/7eXxCZkncCtwq9EyaWPI1fWxfAc2aGcQX9?=
 =?us-ascii?Q?rNIlEeIiCdDrP+Yj3u6biAHtFWOJt9VwpX8nD+Eh/KndzDINNUUswZAUzHZH?=
 =?us-ascii?Q?UkhyVtDEe235xJ/LdCJ+s7dzf1kk6S6P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f035fe-dc72-4b99-2af0-08da067d1d1e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 12:12:45.6947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1GtFMeFyI2LohViWt0AVaSauQIXW3RiYyyQ/Ergqfl9+y60PRj8+sZAJ2EHZeKgcyMNnqEc2NYQ2now9Iys/vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1309
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 15, 2022 at 06:25:51PM +0800, Zhang, Yifan wrote:
> If GFX DPM is disbaled, Stable pstate Test in amdgpu_test fails.
> Check GFX DPM statue before change clock level
> 
> Log:
> [   46.595274] [drm] Initialized amdgpu 3.46.0 20150101 for 0000:02:00.0 on minor 0
> [   46.599929] fbcon: amdgpudrmfb (fb0) is primary device
> [   46.785753] Console: switching to colour frame buffer device 240x67
> [   46.811765] amdgpu 0000:02:00.0: [drm] fb0: amdgpudrmfb frame buffer device
> [  131.398407] amdgpu 0000:02:00.0: amdgpu: Failed to set performance level!
> 
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> index 7bfac029e513..b81711c4ff33 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> @@ -991,7 +991,7 @@ static int smu_v13_0_5_set_performance_level(struct smu_context *smu,
>  		return -EINVAL;
>  	}
>  
> -	if (sclk_min && sclk_max) {
> +	if (sclk_min && sclk_max && smu_v13_0_5_clk_dpm_is_enabled(smu, SMU_SCLK)) {

SMU driver actually checked smu->pm_enabled and smu->adev->pm.dpm_enabled
in smu_force_performance_level. I am confused why these two flags are true
while the smu v13.0.5's dpm is disabled.

Thanks,
Ray
