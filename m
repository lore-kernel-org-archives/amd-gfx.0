Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A3EC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 00:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A8D310E187;
	Thu,  6 Jan 2022 00:40:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30A0510E187
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 00:40:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWrvWY4i9s9ACXy5mSF+cWCb5rUmB/vdv/wcTofFPi76Rufi8esMAETny32SH53glwMC6aj5dI1JXEt3k4ZBdhA3vdjCNPtBN1RLcUNLW3fZaMeHi/ihKd0f/teQ+BLahHFhDqOl2p9R5MBLjwpqX322KnCmjy4By8/HXxdGyGAuxOhXJH096XzUR7soBzhQPONqQNLc2RPRuJNvPm4rRpdv7HyGi+2BawLeoD3VdIygv/uB5VGp2s1VTIoiP9Ln+3uZ4/njO+nt1Rc1f2kRCrQXzhBWAnWE5ONCG7Wkgrk1Tkzk72O20KdJsa7fyaJNFSbf+8yhDzFnPA5fkyiHaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uv7y7fWYBokFQjcGUbjVrnGnQeaQeQQj264pdD8HO2w=;
 b=I0YmwEbntAOMH6DtuhgaHhowsJnDsFs5wssg/GOTqEmIFXBLqecS8EczzDlvZSFnxDM4XuC0VXc4g3f99Mrt4ExnKqybf5MCI9r8S/QPXoDZXA90N8SsnVY8cVWmh1jAWrgwFuPeMZJSQYVDLAEiHNejLM3MgCpHfU1ld4Q/JkSlDLsBa31eVMLMeUnbhboFZz/EUlycunRUdWlLPvKyQZRil6NbUpHRDuojsdhyPnbJo0MJ4uxImsyAGP2Ewy+xgjTnvvjtAzW7TXRklLXZoAWnBtKjVu7R4o9TwFg5KZyjdX8AsOZ97IgGDRgxC2DJJ2v0dTtwhaYcaFEpooy+Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uv7y7fWYBokFQjcGUbjVrnGnQeaQeQQj264pdD8HO2w=;
 b=IYkdVMlLlVSp1k2C16JpEoZDcSfvNjZde6l5BTTV1tGROwYNVIwkAQpv7sazcp+rAeI9v6pZsqGFpo6lYaW3UdhM0IgQJt8vJNwwyo9ssoyX9/hNBgxvvbWFkzpVEu3Nnrzl+fVO0I9ncsPiNNa1V0ClAte+AUkw8mUWsvyZUm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.15; Thu, 6 Jan 2022 00:39:56 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368%4]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 00:39:56 +0000
Date: Thu, 6 Jan 2022 08:39:35 +0800
From: Huang Rui <ray.huang@amd.com>
To: Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Use correct VIEWPORT_DIMENSION for DCN2
Message-ID: <YdY6R1r0HQSM5IvQ@amd.com>
References: <20220105203901.52175-1-harry.wentland@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105203901.52175-1-harry.wentland@amd.com>
X-ClientProxiedBy: HK0PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:203:b0::36) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee706f90-8ca2-4297-140c-08d9d0ad0fc9
X-MS-TrafficTypeDiagnostic: DM6PR12MB2619:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2619BF30B14A4D3C6B863384EC4C9@DM6PR12MB2619.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eHxPN3XmV5mNlZa81emogaM8/TsaMKb0E12Rgzy6X5SAt5K5ybRd8VxVTCAUPpcDq2tTS4Lu9iROll/kHDBfXo21sJq77iPW+TNr0X1XEwhsh+mrqFS1lujX2odFhmoHOPW/JFTFKtBCP3NVxfVC2J05IO/zXL5Fxw3Bto/E0AB3ATnTxNUVPr+cCuYVfuzMEjd37aRvNjoazHK2PNOYOaWeEU9Z3kZJp4QnzlrPX6uEqqGDzqtCKK5DBhthHaUVm8+PrqX3IFhgPd7ndHsiYF9r/sgnfGAPQOu277U8Z70/LgU0oyf/u5BKk/v6/w9r/rBiSMbei45Dk9hVZUp/5k8V5GOBjQ+EycRxzVc8it/NP0HTYHg5NVYhT0iE7DzoiDxSM36dRvwm5MehwWlpoHWq3srEswsklbiqAkFxzXNrHjQyh0bZsZ0BILLo1XKpvGqOLOGY0E3Hs48AXAReTmYHh5fqOIq3mPSC0SgT8cc+v0Y/LVn72Y98NXHp6iIDulzxXoMjF9436IAeSlTVHe7gkZkBKvGkYT8Y7hlswOznONceLiWWlIbzCY6Tzfo/wmGfCkEn7NcFku3mKIG3/MR2H+iDRmE3jmUWAUwPfF5Alj7QNuzm9PdFUTdRWbqX4sLb6UqvBsEH8OkRXGX2CA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6636002)(66556008)(6862004)(83380400001)(2906002)(26005)(37006003)(38100700002)(66946007)(186003)(4326008)(66476007)(508600001)(6486002)(5660300002)(8936002)(8676002)(2616005)(6666004)(36756003)(6506007)(86362001)(6512007)(316002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5b81+9INTkZSn2ve8w7twJWrRZO0XnJunyiFhP9kFukdTQbj2g2q8ZmXHBCM?=
 =?us-ascii?Q?Zq52cwrDlTF4cWiLv2rUdhRao/B6f1CTGkg0jh81SwwgydpTDb6ykVblGufc?=
 =?us-ascii?Q?G8cPlrWESWkIzVaMtvuM7HRGRc+x+FCtCMGZRxcTL9LcHsUYX+7n06WPnOM7?=
 =?us-ascii?Q?GcJBE83UMBwFFMH1wcPixeFwebVuQKZoqZZUQ6+oiERDDAZ7J4Efh13vYykh?=
 =?us-ascii?Q?Rk/zKut1S4f42V+POcpFWMMi0HljnQPkGzqNvXyRPT7uWBj6vy4amhKK+rC7?=
 =?us-ascii?Q?IzUS5PwRQjj55zyKFWXYsKKB1ayvMtQcN+4zXihMDig+XqegnV4/AhCi6pqt?=
 =?us-ascii?Q?gZ5+16uDuk9N4CFqv6qrM3ltZt3dsGmzr7jsJ4m7RQqlvRNF7nm65JFJmTOI?=
 =?us-ascii?Q?MLNwK8/ul4tcCu0gaRxbh5EOwx2eGMDAilFG7P0MMKw35li/a/xugaTkTMWK?=
 =?us-ascii?Q?6YpEk1hY5YbDuUcGcPVyP5+fGYRyEttYf2FMFyXn8/qY7AVcA7EHiEtcAt05?=
 =?us-ascii?Q?ynDK7feYHqN5MS6AkWLYFOfkRZug/S/K6CgcuGF+CLvsMn0BzUrIFAuuewn0?=
 =?us-ascii?Q?la7cvufLwWDHuifUmy+2pfuUW1LNA/34FJ2lkCYSOpFhP9334y8H7N7W6ZYD?=
 =?us-ascii?Q?vJ7AmmKMtwKxVzt6M/yidNWWITcTGHEL0ksecHo/eWhcaPcvJc6C1SG4asya?=
 =?us-ascii?Q?kJawbkRcvnQDxBwy7zWvw+A5slFfdQH7NOqWsjMMQ3s49vNGO/nNixskGAZW?=
 =?us-ascii?Q?tTdA+Zw6cJRvPOxJ1YgKx5+uOwzVY31RKgbcoFuHQnHaa2fRU+V+cvsnod0o?=
 =?us-ascii?Q?K+BXVbRZVtzUgI10Emgv90htpTFQtd6ZjBtRDcMDxmmFv1c+BhJNL4RjiwNt?=
 =?us-ascii?Q?dJI0gU5Aloy3Kh/M/miVMGa6RiQnkn6bRufkbLdEUsNn5g9RTpTJ84x3tCry?=
 =?us-ascii?Q?WAiZIZ5QN3g+I5uUL6mXXoZf7DfaxoKHNdt2zgz4OnhGvqngQgIuEkeRoLI+?=
 =?us-ascii?Q?nFigbFK99oyuSvFMyWg3BvhedrPpAnHJl0RU6yFoLvbHF0vbjmvMez5nao6t?=
 =?us-ascii?Q?4NSrdIPEjRflYjKnyctpwiWTu16cBpwRvvRZyk4OkYVBuSIRibeU9fSPsipj?=
 =?us-ascii?Q?jaIEf2l4qASiWMYUKBInsWzOcNBquL5m8149yxhDmBgj2r6HfK5TOrIL0iUG?=
 =?us-ascii?Q?yyq2qarAflf3uYm9nYNwwuwOFGK/wH/0uc7KxkRULB/hJlgHWOIDlOyDks3V?=
 =?us-ascii?Q?BsyyFTliS6wO4R8PugfDVmi3YrkHrToX6MFwUw5vc7vTbnolp6J4mAoRi5AS?=
 =?us-ascii?Q?4s+MNbT0tIs4UmXjSul4yQAwrLAv6zN/SWg8H1LgwZcY2649cg/+Kacu5kJc?=
 =?us-ascii?Q?S8Qp9YjozB9AdpuI9sLYcS/DS8RIUTsJPv6UnysVogCp0hMVzSCnrSAfYFEb?=
 =?us-ascii?Q?uGpwnF/AjLwgpW8Sh1Sc62pcTJVgfZ/M08Ut7L5JAMB6UAnwioY15Z5x1LlF?=
 =?us-ascii?Q?iAvw5L4DKQVETBM9DDQPa0PiA9jiVasRMMkFQnKrW9l+sCtiQLACEHkzX84n?=
 =?us-ascii?Q?BzC588HvoceeegvgPFmVIWDSm4PeE+MfK5mv01HbtYT26UlhhVowK7GSOGPF?=
 =?us-ascii?Q?XOwycsuAkwLwZ3Ihr2YWX7w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee706f90-8ca2-4297-140c-08d9d0ad0fc9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 00:39:56.5360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDJCL3rxsX4VQhnDjrb3LL3OcOqS2IXwby/2V/FsdiZ5RYfkj+sqxbnp+W9VcGWokj9BNTY1W7HE5+CfyZtnXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2619
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
Cc: "Huang, Rex" <Rex.Huang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lee,
 Becle" <Becle.Lee@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 06, 2022 at 04:39:01AM +0800, Harry Wentland wrote:
> For some reason this file isn't using the appropriate register
> headers for DCN headers, which means that on DCN2 we're getting
> the VIEWPORT_DIMENSION offset wrong.
> 
> This means that we're not correctly carving out the framebuffer
> memory correctly for a framebuffer allocated by EFI and
> therefore see corruption when loading amdgpu before the display
> driver takes over control of the framebuffer scanout.
> 
> Fix this by checking the DCE_HWIP and picking the correct offset
> accordingly.
> 
> Long-term we should expose this info from DC as GMC shouldn't
> need to know about DCN registers.
> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>

Look good for me, this patch needs to backport it to stable kernel (CC
stable mailing list).

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 57f2729a7bd0..8367ecf61af1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -72,6 +72,9 @@
>  #define mmDCHUBBUB_SDPIF_MMIO_CNTRL_0                                                                  0x049d
>  #define mmDCHUBBUB_SDPIF_MMIO_CNTRL_0_BASE_IDX                                                         2
>  
> +#define DCN2_mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION                                                          0x05ea
> +#define DCN2_mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION_BASE_IDX                                                 2
> +
>  
>  static const char *gfxhub_client_ids[] = {
>  	"CB",
> @@ -1142,7 +1145,6 @@ static unsigned gmc_v9_0_get_vbios_fb_size(struct amdgpu_device *adev)
>  		switch (adev->ip_versions[DCE_HWIP][0]) {
>  		case IP_VERSION(1, 0, 0):
>  		case IP_VERSION(1, 0, 1):
> -		case IP_VERSION(2, 1, 0):
>  			viewport = RREG32_SOC15(DCE, 0, mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION);
>  			size = (REG_GET_FIELD(viewport,
>  					      HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_HEIGHT) *
> @@ -1150,6 +1152,14 @@ static unsigned gmc_v9_0_get_vbios_fb_size(struct amdgpu_device *adev)
>  					      HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_WIDTH) *
>  				4);
>  			break;
> +		case IP_VERSION(2, 1, 0):
> +			viewport = RREG32_SOC15(DCE, 0, DCN2_mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION);
> +			size = (REG_GET_FIELD(viewport,
> +					      HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_HEIGHT) *
> +				REG_GET_FIELD(viewport,
> +					      HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_WIDTH) *
> +				4);
> +			break;
>  		default:
>  			viewport = RREG32_SOC15(DCE, 0, mmSCL0_VIEWPORT_SIZE);
>  			size = (REG_GET_FIELD(viewport, SCL0_VIEWPORT_SIZE, VIEWPORT_HEIGHT) *
> -- 
> 2.34.1
> 
