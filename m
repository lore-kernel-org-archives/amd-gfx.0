Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4087CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 15:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF70110F0CF;
	Thu,  7 Jul 2022 15:23:44 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE13B10F0A4
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 15:23:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jm8G1u6nkk2B/1LMoj73JNg1nkITgBHlQRPU9FygpMjvyx165pjUE1u2jUcrzTf9RPQE3y57N34Bl9zNhuz/4Mtr8W2kRLBaFzMZH9+/vEW9O2zuEkxlKBMrtU6R+0NQV7lZSasHOoJYBpbrDJrt0PyBgt04yXThLQL68ZdWeH7+X0+JGqE9F/hktm2cc+B4jswyB56AbZdHe07Bet0lMLjhBlcYD4CNguN0A3DUJLJVQ2Y8jAN9/w+UAwAOVOQcqjc3STiBdODUfiumbIRd3I6owSTW0avYVXaD8pt1KuDHlNG6p77ayZZYxg9gcCdND+0axvu8Cl7Up/kmXtK5fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vvn1jh3HepyVyZCe04eCKjwoPG63VG+eD3xlmeamsXk=;
 b=Xafv+/mGK7xE+VrW6tIUKYj+GSx3dvJ/w8LtIrYwc6r6ZID/7101wTT17OxYDE36Sm7nEnheH52LzVJohVVUM/iTrqUSQJtOxPVDzcksYAH/crvgfRFQ1DrNVaB8a+EggWHSYWm3QqnM9IG5ijIr4pUeiiqVHwrD/Or6JvFUY0etCb5Lfgy7aMj1frY3sTZEBRaLLsdkg17df5swhcC6iiC91JpSaW/Fjv3mJ/t6nv7Gq0u+4mVsCDPyxjPw/oENNI6J1TIXhxMkcXA4CNyIu/xQKtWCQCcI9v6D1Wf4+0o+u2d/uzbwUpwI7h9kqEw+g8+5WQBwfpoqqDnGpiN0mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vvn1jh3HepyVyZCe04eCKjwoPG63VG+eD3xlmeamsXk=;
 b=TcoBhHnGYB1uH0e8F4xo7GEdxkA8HTcBq8Bg9r4/ogB44GAYJZ/8D1WzMAvx/+vj4KYJWaea6AQTwlDl/6vNAbeDELGPLu6tygkbCmS2XXRYlF+dwXIo4B6QZEvEQKWqp2kfKD0Z75CnL5MChrRTK4+hlZ0EblyNfQNciU1ps60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 15:23:41 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::d122:1dae:8445:2e43]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::d122:1dae:8445:2e43%7]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 15:23:41 +0000
Message-ID: <1ff59bfc-3945-667e-efb0-51291a44e499@amd.com>
Date: Thu, 7 Jul 2022 11:23:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] drm/amd/display: Add visualconfirm module parameter
Content-Language: en-US
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
References: <20220707145656.565627-1-sunpeng.li@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220707145656.565627-1-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:208:c0::45) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f15f678-0c8d-49d6-7f7c-08da602cac14
X-MS-TrafficTypeDiagnostic: MN2PR12MB4160:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kkQLTkh5TrOiNkLIqgYtwL5xnl2d6eApKhYlvDpNZ2cIN++R1erS2Pi9nF0vYpOP4cZ2xBa6Cu+/IBypHk/qP85co/uQz+A/LjX8jDIkMrge+UfCcudIlgB+/4Cypu+sz7i0E83Y9f7J338ucaeKbScdWMAPhFMZYnfS+bSpYWxpQ72b0/mYNslfisi3z6HdnmnOWrHP+C7fQVoUiUlkhmkKFpUiwihGvyVklOPIUvMjGfs2ZbQxtLaVVpGdJlaw2nohm5bDBQ6KvSqpzhV7xmBWHcSezPypCDrv1g6mR/clu1iHsZUUTv3xLXYyOFU1bI4jf/6RwhP13RLD8fW15pLBu9iDQ7NRQsBnnKEQBMywyfVzN24SA3DBZYro081lWCPwNVChEiaCoJPbPgxr6POtcHm7CRA8ve8Dj3O5BYMxIwg/DNCiv7yIe4nKg1jWXDpZdrrLprnPocCs9lcLfS/YM9Ow83ye5z3Sm5aOTRsr0r0KMPvDx0K2Yyra0Vywzjwqn+FT1FPu7RdNIwEkwjDJoRvSQGLktjfOQZ2Ts7nlDsIMlsUMCQsezC7OnRDV7drJWWUMZrJ0yVcS9EA9e+7tORAvqjnpO/AI9cNvODGNrz01sF2TdS19cYy4BzVx0umPBrcEaUwaY6WYqfQd0zLIVhVEZoJ2N7PYHoSbcGfZzU+Bp4SnbxRyvQf93brpyqZVDG+8mVVa1es4IWBlcK3sKVPfGDKcaRJEzAnq8zLgYr0KmwmbpjZZ/q3hpGBadA5Jw/8/w5zeQqwgj0cEtcjJxNONRt6AnONbVfhqNQ+0Ce29P3fzVHJisDF7BWYYDK5a67m/fmOjcpWM+Tbplg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(2906002)(6486002)(8936002)(5660300002)(38100700002)(31686004)(36756003)(66946007)(31696002)(8676002)(4326008)(66476007)(66556008)(86362001)(478600001)(186003)(41300700001)(316002)(83380400001)(53546011)(2616005)(6506007)(26005)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFVtZEgyOXcwczV6WGFCWTJhZUdsdzEzT013dU1MZEh5OWo4aTlISHd0d2dz?=
 =?utf-8?B?MFVOcHJwQ3JQQWVKbHRmekV6Yk5malQ2YmpLL0VId3ozcm1ndm5CZEpEMGZ6?=
 =?utf-8?B?Qk50bUtxQjhPNFp2Nm5SODU2NUQxV1luNDVNN241RlFrYk0rZFNCQjFITEEx?=
 =?utf-8?B?MGk2OFhUMGF6OW9XdDVFeUdYQ1VJRXNrMWlTWXA3cTBGTVVWV3d3Q3NPc3NE?=
 =?utf-8?B?b0RQVmFTcmcyNXJDZVVTemZQdmxiY3hmYkY5anBDYkVXWVpmc1E2bDc3ZHE3?=
 =?utf-8?B?dHJ3T3pWVlA4WVJMKzJ1TmpDN1dJalFWeDM4UC9sb0hBaERDVlo4d1VIYWxk?=
 =?utf-8?B?S1RpdWlsKzAvVWlQZ1ZnUmVsK25VZUg3QnBWcVhOWGJnZnkyckNkNWVoYktK?=
 =?utf-8?B?c2NWSXRVUFVQMlB0QTk0UDdaVTZCdmgwZll2eHFDNXZSbGNxQnNFbUp6ZXRV?=
 =?utf-8?B?K2h0bWxhZVVROGlrejZucjlTUjErV21SUVNpSDVzTGVXanRKdmo0cDZxUVpr?=
 =?utf-8?B?VFllZVA5Wmd1NVJERWtwNWdSUlVaQUhWampEb3JTT3FXdzFWd2ZlbUZPcmVL?=
 =?utf-8?B?QW1oYVUzeTRFTW1oKzE5R0NockVDQU95QzdTaG9ISWJGSDl4Z3Fuc29Wazg5?=
 =?utf-8?B?cUdGcDNpTFg4YmUxQmFzTXBUKzM4N2pEMHFnVFozSjJPZUd2UXczS1J1WGdW?=
 =?utf-8?B?WWdIZ3drNldzektOTUtnaVJrYkdKT0JYL2NPSkxZK2h4MTNrUWRITG1QVG5D?=
 =?utf-8?B?a2sxYUNJK2l2V3IwWVJzYnBhaWNNaE1IRVdUcHZSbGtIOWhVYXpjdW4yQjR3?=
 =?utf-8?B?TTBQejlkWG5xcm93ZnY5cUp6VGRuNGVxZjRwdS9VT3FxVm53QitEZnQzaHlk?=
 =?utf-8?B?cUdZMnBKa082RGZjaWxtcnIvdVV0VWU4a0FVVWJydDdEbG1mZjh5VTBLYUFu?=
 =?utf-8?B?Y2dmWUNmWW8raHNIQlV5S1lnRVVPWG16UHFGMGJ6dHkxUmxGVFh0OUhIUm5l?=
 =?utf-8?B?ZjduYkk1TlJpa0doY0YvUk1jSERBRzVGNklTZ3ZwdGRlYkNjc3R5WVJkTkVq?=
 =?utf-8?B?Z1o0S203QUhZRmtOaytNZkppMmtyb0hrdDY4TllvWXp5U2ZkYzFtT2tTcHZZ?=
 =?utf-8?B?YjZwVko5dW5taVpaN3JlSExOWVowOHUvUi9adllEVVlHSnBtVTFmOW4yN0FR?=
 =?utf-8?B?V0Z2cXZmSnVMcGh5SkRUVWNqNDNkRzRuZVZsN2FqZkZiTWZsWmhFVGtkY1Rs?=
 =?utf-8?B?TzNNSG16TUFFek1OKzZoZWhxcUN1U0pnMFIvWXV5cDcrMTE3OEVZL1RCMkQv?=
 =?utf-8?B?UHRLSXpMbWFWU1l0a3JaMFNoOGJudW5rV3pCMHZ3NjR3Nzg5U3VDTENFYnJp?=
 =?utf-8?B?Mi9ENTBOYXF1UGJBS3djWFMxbXdYeWJvUitsMzNkRTNFUTU4eldOckNBOEll?=
 =?utf-8?B?dFZ3Y3gyN0UydkVlOWNSN0s5UGRSWERIbEVmeFkyQ3J3UVVEbkpEemEvNHJi?=
 =?utf-8?B?dVAzOHNiTGtqS2cwODlVRVYwcEJPMVNzWXpJd29rVWpjSk52eFpEYVowQ0FQ?=
 =?utf-8?B?TFBOMzFWaTFkNEdhdUR2S2l4Yi9DUE53S1ZwOVY0ekNXUm1tNkE2VUoxTVBn?=
 =?utf-8?B?ZjcwVmNGWHVMUHJhMXFCUWhPaHM3eWlNaHR1VStuTk1jVEc3WXphTnBhT1hV?=
 =?utf-8?B?RVBwakdJN3A4L3c3eGNJNllrNm5YZ2tWUlIvNEdRdXNYM2ZEZ2lWcnQ4aVZt?=
 =?utf-8?B?b2EybUJrQ01udVNPNC9DT2RWdFVVMkpudzhrbzlFWGNGMDlhUkxlbUJNNlc5?=
 =?utf-8?B?N0gzSmE4RDRQRldYY3ZSQ3Z1N1JkRURMVXBjbCt2R1NJRUgvVE10MFJXK0x4?=
 =?utf-8?B?L29CMmM4cEFYeGlxYTdzRWhHM3JjQTBUeUtJTXE5ZENETzlyQWxIUk51ZU9S?=
 =?utf-8?B?L1ZYOGZWQmU2VTFYTmtHb2VDbDFPZEFkSk9wOWJwM2c0enpaWFBKMmJaZThz?=
 =?utf-8?B?UVk4cmpTY29jVUlPNFA5T1BHMVVQcWdSVXhqQWhrUEFyRUd3dHFuT2I5K0Fl?=
 =?utf-8?B?Ujg3Qk5LcE5JY0FPdVZrYytVaTB6bWtza0xsSTI1eFNlYXpINjZYbVNUUFhh?=
 =?utf-8?Q?QL1zKIJvhHzsN9wt36qe2Wrj2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f15f678-0c8d-49d6-7f7c-08da602cac14
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 15:23:41.0073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZYHm/oRJouDN82/CsbmI/llK/qjgryDC5rj0g/HZTi4XxZBMgv+8cLZYSbInn2SdThhnXoUFEApcxyTdcs+4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160
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
Cc: Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com, Aurabindo.Pillai@amd.com,
 harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 07/07/2022 10:56, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> [Why]
> 
> Being able to configure visual confirm at boot or in cmdline is helpful
> when debugging.
> 
> [How]
> 
> Add a module parameter to configure DC visual confirm, which works the
> same way as the equivalent debugfs entry.
> 
> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h               | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           | 4 ++++
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
>   3 files changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 845d6054992a..4629bef6c44e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -197,6 +197,7 @@ extern uint amdgpu_smu_memory_pool_size;
>   extern int amdgpu_smu_pptable_id;
>   extern uint amdgpu_dc_feature_mask;
>   extern uint amdgpu_dc_debug_mask;
> +extern uint amdgpu_dc_visual_confirm;
>   extern uint amdgpu_dm_abm_level;
>   extern int amdgpu_backlight;
>   extern struct amdgpu_mgpu_info mgpu_info;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 1cc9260e75de..e1e8cf70e719 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -167,6 +167,7 @@ int amdgpu_smu_pptable_id = -1;
>    */
>   uint amdgpu_dc_feature_mask = 2;
>   uint amdgpu_dc_debug_mask;
> +uint amdgpu_dc_visual_confirm;
>   int amdgpu_async_gfx_ring = 1;
>   int amdgpu_mcbp;
>   int amdgpu_discovery = -1;
> @@ -827,6 +828,9 @@ module_param_named(dcfeaturemask, amdgpu_dc_feature_mask, uint, 0444);
>   MODULE_PARM_DESC(dcdebugmask, "all debug options disabled (default))");
>   module_param_named(dcdebugmask, amdgpu_dc_debug_mask, uint, 0444);
>   
> +MODULE_PARM_DESC(visualconfirm, "Visual confirm (0 = off (default), 1 = MPO, 5 = PSR)");
> +module_param_named(visualconfirm, amdgpu_dc_visual_confirm, uint, 0444);
> +
>   /**
>    * DOC: abmlevel (uint)
>    * Override the default ABM (Adaptive Backlight Management) level used for DC
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index eb5efb4aa2ba..d7208c0b76b1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1562,6 +1562,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   	if (amdgpu_dc_debug_mask & DC_FORCE_SUBVP_MCLK_SWITCH)
>   		adev->dm.dc->debug.force_subvp_mclk_switch = true;
>   
> +	adev->dm.dc->debug.visual_confirm = amdgpu_dc_visual_confirm;
> +
>   	r = dm_dmub_hw_init(adev);
>   	if (r) {
>   		DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);

Series LGTM,

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
