Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46126C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 06:35:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D50D310E157;
	Mon,  7 Feb 2022 06:35:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D0F810E157
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 06:35:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZw48TVe/iUgg5RwuCDon3L9BWN/j71AwpUDrx9cELYYg3YmTL40WPrY4bNCYwYvGMY9qwU2lkLpMFEJFiECSE/xNvkgMjH49yYeZG2gMj4c9h/1OR2t6cpuWcKyycdFkxlPnlYYhbbBWtNuaSUvekaMz/HjRVoHfllV2ZIQgRCBqgl79nyiOf/270QP9iwYvaoPQS5c+zghcwhQCp+obuRT9L030VDsCDemDuWwyy4wuSo41lpcJBzG2vGfgWcyfpa8MWvLQcnrRLcP0yNtm35M1tQuallQATDST7n5dmJZjSVEucQc7RRwHcEpbwtOe3P4n9/wgk/7jJnOwUhQUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrDHAZfOPmhVPWI3NHXOgNqPTn2ZdhLrTOcUiBnWfg8=;
 b=TJ96YDGuZTpZwXUretOenZCDNQ9gsv5BoXxhxaY/9Z6KFSQdYAdyR+Zy8wZnQe7aR3vx2oGp98bRwl7Q8vBHUXoKPSlE0sP4xTBgYkEYen36yJByPq7M922hKiVHyefje1cSl5De5pVNPyh0jcI66vcW+/A0QAFxvbYHn68KsM9WUbnZ+8E4QzhVGgVG9aaD6BWKflli2UVrHlETZZ0uFFR/sWwZ/0INLaKIeuyrV/TrMvxJe4HqGd1Yar4YpQC6UST0Bztoo6ceA4gnZRlHpYdCVobtO8jMjBtd5KVypab1ocRiAn7SIWuPR9/Qw/kCsgaUFdlC3Qrv92xNFgC30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrDHAZfOPmhVPWI3NHXOgNqPTn2ZdhLrTOcUiBnWfg8=;
 b=yi8p3MeqmGZ7rneKFcDePwEzLp/Z0XloruKbqvR96FbIeNOwJOv3eho3cGyuyq5Nr8OGPEzvC9d268xDNaEb2pl4dqEe1upZytk8ToHS5NmClIumcIO79/NKSEsqQCGC2CE3DQyzar/5HmxNsM2a17yLJ+EDF7VdHK0N/F3JrtE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SN6PR12MB2686.namprd12.prod.outlook.com (2603:10b6:805:72::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.18; Mon, 7 Feb 2022 06:35:00 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368%4]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 06:35:00 +0000
Date: Mon, 7 Feb 2022 14:34:38 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: add utcl2_harvest to gc 10.3.1
Message-ID: <YgC9fq0k5K7TlKaB@amd.com>
References: <20220207024155.414712-1-aaron.liu@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207024155.414712-1-aaron.liu@amd.com>
X-ClientProxiedBy: SG2P153CA0038.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::7)
 To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15bd3955-76d7-4d37-59ba-08d9ea03f751
X-MS-TrafficTypeDiagnostic: SN6PR12MB2686:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB26860CD743FCEAB17382D9EDEC2C9@SN6PR12MB2686.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:338;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZkKNRT5hnwtTT67q7YA+V0S84KBy3g7VMCe1ImPJPhEurtw2Qsv7rHIWRl7zL2x2Q/EyhKvS3gSe/rIO5vOk+ctP5xIylYw2X/5G/iaU5Rf9Xk0dcxVA+RAjlFHKUA6O4yoS9THTK/UrxigotDMhaG6QB3Ug6/41RwmPXW8QjMl1R+5ce5a1un0nvxjxnys5iwXZZ1h1enTlUj9uUM76nDnY9fFmerzR32Nwg9fOwFQvgfKZSz+9+zSM1frN7phkYe5HJjROvFAYR2vAoSpEcQOoTTSJjQJIG3WqilnKFgPA2rjjMKTeP6wTchERbBi3csEEv+Y6jQ4rZWlQvaFMlxtnHgo9DEaGuvFAmjVQxYMabeIEKlbBfdU2JnEVlE+PKNgnMMQqUn/K8OLQFt4QuTk9Uav86yLcvVtmZMxtQtx2y0DYCl5NxW2yk9gdiWgw/2e99dz0ZIK4EqfWyyPrE1qTw46SKlAcQYVWRQCAz5gMWZK0Prb1z+vEkxFr3LFts7vFGog+oksXgooeHLwsnx2fSRr46L3lkgv2/q/VwCRavoP1NIVU+PqoNvJhbNu6gMmTUX/VQmT4JCWxg7yJrTpZNSdSohgdEi+E9fQXKvYS7wKJcMbgEeE876UUvSM99AhARPUDH46tPcd1fUFJyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(66946007)(6636002)(8936002)(66476007)(66556008)(8676002)(6862004)(4326008)(38100700002)(37006003)(83380400001)(54906003)(5660300002)(2906002)(508600001)(6486002)(26005)(186003)(86362001)(316002)(6666004)(6506007)(6512007)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HFF37mPaaK0jbw6k/5eOC5plrlWRmxEMftOwA72s0a7/RM4AHHSDSCojow2k?=
 =?us-ascii?Q?/tQLXWQIR4o4SelW32n33mhCsDGx0h4wCJ+cn9O+DX2LphC6WWbuFfCdr3Cb?=
 =?us-ascii?Q?qnteRBaQc7sqWPGhBlhM5bs28wsLHz6SiJlMol1J0eWnZocDj5IfmsMSYcIk?=
 =?us-ascii?Q?JAKAqzVxaBea/wUUhxjjtTQN/8WG/EKYDoVBt8JIToKn/WTSiYEGq+ApzhtQ?=
 =?us-ascii?Q?+9H4RhJe78w8MZIBjnm5/aihALDj64Qlg+64iyOWugKXViz8dIjboPew3fSs?=
 =?us-ascii?Q?OSBluHqQ6vnIOxL8ogO4TOA7nhwBKn0afrrwPW9+9lEBHXXYv2+XNkNO2Iu0?=
 =?us-ascii?Q?NPOVNhwLpJyQHZelkjjDjo5FtGKREyIiYs+UhtYwYuO4FMsN9eagZoH6Bks6?=
 =?us-ascii?Q?YrBO7r5stXatpRWL31l4LLUzhG4Zli0gTxQizrQQUJDzYyAa1oRHKJJjwf2w?=
 =?us-ascii?Q?MtG6Jv9+MuddcTEqI7eIhaQO2qxbwlscLA7gOL0AhYDIU8iStVctKHegP8Vp?=
 =?us-ascii?Q?01KwP5MyhdVqT4KmyGdu2Jk+VM2zN+8Ouzfd+6Jl7eRCnNAujqde2k8Nvycm?=
 =?us-ascii?Q?1nDjDVNeEu3LkrmtjlOHELNnTGnTCYy1+/IJHFaHsCV+gZ9tuqdYn30+rjGr?=
 =?us-ascii?Q?0Tuzns28R7aXMGma2zyW+Y8UhbNsPWGIwj4Sn/7oZE7ZR3i6NMG6hnnDCNIM?=
 =?us-ascii?Q?oup1jousKKTOinN/hwN8lo4/biJ9n0mUMdaYAaITCa5QuJODPxUa7UTH1g3i?=
 =?us-ascii?Q?awWWaQapNDNiczP7FcjlnOX4ze/T/cFqcPyOWmu3DgRDS35AOYGA453IkCnV?=
 =?us-ascii?Q?RGU18+lmqgG1SW+rujLkz1OGFN5lqtuNyuRFIKZ6N2nrs/Q+iu7zeOq0zmcW?=
 =?us-ascii?Q?NvPCKsuxpZDNn1ZM3nmT5JIF9e7ddaBNCBvFzxrtc40xZi4HiyywsSkr/21G?=
 =?us-ascii?Q?6q+oOPRrpiIzQkBViLczhCJCAk1HvSk56xYLDoUxKS8Pkk1+sFVW8wFDtvlO?=
 =?us-ascii?Q?Xoh0J5mSnyosVBBtZ1JvmgrXJ/IKnRlqPJHYlvvfiEUYHYnZrS/s8CQj0eTy?=
 =?us-ascii?Q?xMMYizZ1MZ6SH2IkdUV+UsY7Jb7kDXdwhk/5H4cPQVuqXEhvGU5xtwnIO8Ss?=
 =?us-ascii?Q?sKtap2RwQGX7S7aKdGc+NwyueFj+IGAnaUccLPoBhiHhIYesI0VMsej27TIS?=
 =?us-ascii?Q?VtWq6PG9E1tjOePr8G/IBOXIuDHY4tCMmX7JiCvF3JjpuAiiU/TKH65fJ5Wb?=
 =?us-ascii?Q?XtpXHshCUFOYcs9U1ID1lt0Z/4ESPGBeQGKoaHg0kXdEzgakivHZiQO8jwPw?=
 =?us-ascii?Q?G5tBs5Ub0+Xzw+VtCtntfCWSsPzsaBhFb+u8FQk/+Un1nntpWrx24nr2BByr?=
 =?us-ascii?Q?YrZbUk1bwXf6RjXNN3abE5K4YBbugnOOj/bESgmNdNNWwx8AhtX03M7AZATN?=
 =?us-ascii?Q?nBTSp+JsGwZB3KM8jI3vQ8InwjqvmeL4Av4qW3Zz6SMnmmjRPh0tBEkL9kuC?=
 =?us-ascii?Q?rqm0JYAHZi1hL0Z8//oPMNRhMQBLJzH7N2gH+qBFJPzSTO7RZOyaSFSk1fwA?=
 =?us-ascii?Q?lGaSTir+ZKfAaBy408Y1OHcE+fdJjPrv9kIyV81IZG14M3/3vKHkST14xtvy?=
 =?us-ascii?Q?rYSNDubYpNkB3nQJBPc8Ybk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15bd3955-76d7-4d37-59ba-08d9ea03f751
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 06:35:00.5990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRCjmUlKfMBKaPutRLuiggp4FJVLZWOKde+z8jIVv0Nx5UYz7TVbGIzTptMuHGM2p88XKachTWiChU+aXc53rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2686
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 07, 2022 at 10:41:54AM +0800, Liu, Aaron wrote:
> Confirmed with hardware team, there is harvesting for gc 10.3.1.
> 
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> index b4eddf6e98a6..ff738e9725ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> @@ -543,7 +543,9 @@ static void gfxhub_v2_1_utcl2_harvest(struct amdgpu_device *adev)
>  		adev->gfx.config.max_sh_per_se *
>  		adev->gfx.config.max_shader_engines);
>  
> -	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 3)) {
> +	switch (adev->ip_versions[GC_HWIP][0]) {
> +	case IP_VERSION(10, 3, 1):
> +	case IP_VERSION(10, 3, 3):
>  		/* Get SA disabled bitmap from eFuse setting */
>  		efuse_setting = RREG32_SOC15(GC, 0, mmCC_GC_SA_UNIT_DISABLE);
>  		efuse_setting &= CC_GC_SA_UNIT_DISABLE__SA_DISABLE_MASK;
> @@ -566,6 +568,9 @@ static void gfxhub_v2_1_utcl2_harvest(struct amdgpu_device *adev)
>  		disabled_sa = tmp;
>  
>  		WREG32_SOC15(GC, 0, mmGCUTCL2_HARVEST_BYPASS_GROUPS_YELLOW_CARP, disabled_sa);
> +		break;
> +	default:
> +		break;
>  	}
>  }
>  
> -- 
> 2.25.1
> 
