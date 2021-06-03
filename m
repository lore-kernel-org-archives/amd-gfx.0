Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A81C47082
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 06:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 770D0613D8
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 06:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770D0613D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F18AC6F3F9;
	Thu,  3 Jun 2021 06:57:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D42A6F3F7
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 06:57:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7pVbEF3KD5SUUBUHa0G2TKcvavzAZnkvBWCzk637YR8T62NHDYLVz2NPwiUX6aPg6wnxES28nl2Va7um4IiMq7b3kbYXWWvFyF1dVS1WJrYCymcqZkiCO8oHaUkICEcKgsAUgOH/yFlSJ0mUL/yL0H1fivd8rmeNd/rkOuT3Dc9MvUssvsiN0PYPhWOyUbs8aYY504VBkma4egZyCeS/XeUDGLh8fx6Qxw5TY0BqnbZGyNezDMQKLErTuFR8aiYw0GhWVerIEGq+7bSvOmgdli5FABuio1TzvSfVTQr03msDzA5h4Mu1lmASYCxkXfiKIs2qz5cZnvrqD3GLhjk9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2gPkFhNoEfaKAag284TP7VnKw4klZXTXWJAiQhrPEg=;
 b=mr6jbnov4o3cyGSHec3eBTzYZZGkME/7rXJgGRXVIDjCTyU7SnIzHT2o1l8u2ij544KK5jAF2/XcF0MF8z4TxhfvVZj3D4NGzT+6koJFqg9geUk9jU9+y/+KIdj2q4fcgEV6REOmV4GnJoCQdUnhHXNFNtqOiCMa1VLI11tIcE0vk1CvDd+9LbFwuzr76PJiP2tZKuVGyYoKOmk5LuubUI/Cr+iVgTC74xHG8IbUqaMnvdaXQ/SYwITDu9n4b/daoZQI0yISjHRqHtkxzPsIPRbYoutMgeCHikB3levNNWdpz7ugUdXeRzpC41F1acGRg7rLJuOyx3rEOjJCk+NURg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2gPkFhNoEfaKAag284TP7VnKw4klZXTXWJAiQhrPEg=;
 b=jY5XIKuO/eM0iIBEbFUCPkhjEJSYrw65rsdczhqiMjsCJ0Ookp0dC9nFYnWfYsv4WtqXXxoIhzDYnHUqbtrbjUPdDmHS/HIXgAitDFKROjoh5y+mlt4qiCDVoVwqDorGNCfeGaXy42/VE0eTDkZ2506EVjKjwvnRqmXdZnNQBoE=
Received: from DM5PR16CA0029.namprd16.prod.outlook.com (2603:10b6:4:15::15) by
 SN6PR12MB4735.namprd12.prod.outlook.com (2603:10b6:805:e5::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.27; Thu, 3 Jun 2021 06:57:05 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::22) by DM5PR16CA0029.outlook.office365.com
 (2603:10b6:4:15::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend
 Transport; Thu, 3 Jun 2021 06:57:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 06:57:04 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 3 Jun 2021
 01:57:02 -0500
Date: Thu, 3 Jun 2021 14:56:59 +0800
From: Huang Rui <ray.huang@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 00/89] Add initial support for Yellow Carp
Message-ID: <20210603065659.GA4014052@hr-amd>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f44ec80-2641-4cb4-93b1-08d9265ccba5
X-MS-TrafficTypeDiagnostic: SN6PR12MB4735:
X-Microsoft-Antispam-PRVS: <SN6PR12MB4735D609A83CDFE3BA62B0F5EC3C9@SN6PR12MB4735.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KroW7suc4aWu8rRI4TWejMsmgNMK+DzRUKw5ylRZN+1zlsBDbwqg2B2sDUPPUOgbdV/9iETq3lza+2xuBv28P5zUdgKMp0grVbMouDqPE7m3ovpDCL8RzKn0JwO4clBxVTjXlEHjSF8nfcmaXK9A3YLJktcr96EcAe9GJo+cSMEt8z5JKKynMy9wllja3H8y/jewJkM50zCzF63+2sOZOB9NbNRvcHH6aD/BeRxSgA8m1hBlpyUnvphc86zegzrzhThDNTboMmT+m8rNEKxchmESXO4nN+BfvA3vsEdGvAJZojKKQ7dEx2Pwp5CRAYbEiCJMNBnolgM9BjtnY+Hewk1sooIREQVErJvnREJ7S8I79XwhPRDdvUfreqhHKw7SJPtHc2eoMIYk9UMGvlE5Tri+W7RAfUWPWw61EojkxLnV8SGuQjeXaXTydgLLZ+qZpCza6AxTt8HN9Cf7+SzmBiee8H1nvclOSMXWK3J6x/c0nhRJ1hhspzJRx53zG+G/zaoNbJUmpmIUWeOTXExE38sv/MAjx/Tk3vcdTFsyuI463moe2eVvFqp8LkMB2LZijMWzfGULZgtTwqHI9PIm2l6we+Zj/dM44HaflbixpkXImvQ4FyLK4xfr96XGrtuFVFreZmrPVzwGTNhi8PWYleiVr+MWAwxpvhJazLtbZR7AvSd7kNRiTeQPGJMLT0BwFFBmkNJ52fLyDMnJYvCFwjGxI1MdIx2+bpb/MsYYkE4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(36840700001)(46966006)(83380400001)(478600001)(30864003)(47076005)(2906002)(19627235002)(966005)(336012)(81166007)(82740400003)(186003)(16526019)(1076003)(33716001)(86362001)(356005)(426003)(36860700001)(8936002)(6636002)(6666004)(26005)(316002)(4326008)(5660300002)(45080400002)(9686003)(82310400003)(6862004)(8676002)(70206006)(70586007)(33656002)(55016002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 06:57:04.4129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f44ec80-2641-4cb4-93b1-08d9265ccba5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4735
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 02, 2021 at 12:47:40PM -0400, Alex Deucher wrote:
> This patch set adds initial support for Yellow Carp, a new
> GPU from AMD.

Always happy to see the new GPU support. :-)

Series are Acked-by: Huang Rui <ray.huang@amd.com>

> 
> I did not send out patch 1 due to its size (new register headers),
> but you can view the entire patch set here:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux%2F-%2Fcommits%2Fyellow_carp&amp;data=04%7C01%7Cray.huang%40amd.com%7C1937eee84d9c4cb003d008d925e66f99%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637582493915660523%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=7JQvLB%2FCIkDRV5jpSn27hq9hxtdHnmDyDmGJr3bzuis%3D&amp;reserved=0
> 
> 
> 
> Aaron Liu (42):
>   drm/amdgpu: add yellow carp asic header files (v3)
>   drm/amdgpu: add yellow carp asic_type enum
>   drm/amdgpu: add uapi to define yellow carp series
>   drm/amdgpu: add yellow carp support for gpu_info and ip block setting
>   drm/amdgpu: add nv common ip block support for yellow carp
>   drm/amdgpu: add yellow carp support for ih block
>   drm/amdgpu: add gmc v10 supports for yellow carp
>   drm/amdgpu: support fw load type for yellow carp
>   drm/amdgpu: add gfx support for yellow carp
>   drm/amdgpu: add sdma support for yellow carp
>   drm/amdgpu: set ip blocks for yellow carp
>   drm/amdkfd: add yellow carp KFD support
>   drm/amdgpu: support nbio_7_2_1 for yellow carp
>   drm/admgpu/pm: add smu v13 driver interface header for yellow carp
>     (v3)
>   drm/amdgpu/pm: add smu v13.0.1 firmware header for yellow carp (V4)
>   drm/amdgpu/pm: add smu v13.0.1 smc header for yellow carp (v2)
>   drm/amd/pm: add smu13 ip support for moment(V3)
>   drm/amd/pm: add yellow_carp_ppt implementation(V3)
>   drm/amd/pm: partially enable swsmu for yellow carp(V2)
>   drm/amdgpu: add smu ip block for yellow carp(V3)
>   drm/amdgpu: add gfx golden settings for yellow carp (v3)
>   drm/amdgpu: reserved buffer is not needed with ip discovery enabled
>   drm/amdgpu: add psp_v13 support for yellow carp
>   drm/amdgpu: enable psp_v13 for yellow carp
>   drm/amdgpu/pm: set_pp_feature is unsupport for yellow carp
>   drm/amdgpu/pm: add set_driver_table_location implementation for yellow
>     carp
>   drm/amdgpu: add GFX Clock Gating support for yellow carp
>   drm/amdgpu: add MMHUB Clock Gating support for yellow carp
>   drm/amdgpu: add GFX Power Gating support for yellow carp
>   drm/amdgpu/pm: enable smu_hw_init for yellow carp
>   drm/amdgpu/pm: add gfx_off_control for yellow carp
>   drm/amdgpu/pm: enable gfx_off in yellow carp smu post init
>   drm/amdgpu: add SDMA Clock Gating support for yellow carp
>   drm/amdgpu: add HDP Clock Gating support for yellow carp
>   drm/amdgpu: add ATHUB Clock Gating support for yellow carp
>   drm/amdgpu: add IH Clock Gating support for yellow carp
>   drm/amdgpu: enable VCN PG and CG for yellow carp
>   drm/amdgpu/pm: support smu_post_init for yellow carp
>   drm/amdgpu: add RLC_PG_DELAY_3 for yellow carp
>   drm/amdgpu: add timestamp counter query support for yellow carp
>   drm/amd/pm: add PrepareMp1ForUnload support for yellow carp
>   drm/amdgpu: add mode2 reset support for yellow carp
> 
> Alex Deucher (2):
>   drm/amdgpu: add yellow_carp_reg_base_init function for yellow carp
>     (v2)
>   drm/amdgpu: add mmhub client support for yellow carp
> 
> Huang Rui (2):
>   drm/amdgpu: introduce a stolen reserved buffer to protect specific
>     buffer region (v2)
>   drm/amd/pm: add vcn/jepg enable functions for yellow carp
> 
> James Zhu (5):
>   drm/amdgpu/jpeg: Remove harvest checking on CHIP_YELLOW_CARP
>   drm/amdgpu/vcn: add vcn support for yellow carp
>   drm/amdgpu: enable vcn/jpeg on yellow carp
>   drm/amdgpu: enable vcn dpg mode on yellow carp
>   drm/amdgpu: add video_codecs query support for yellow carp
> 
> Nicholas Kazlauskas (22):
>   drm/amdgpu: Load TA firmware for yellow carp
>   drm/amdgpu: Update atomfirmware for DCN3.1 phy tuning and eDP caps
>   drm/amd/display: Add DCN3.1 yellow carp asic family IDs
>   drm/amd/display: Add DCN3.1 clock manager support
>   drm/amd/display: Add DCN3.1 DCCG
>   drm/amd/display: Add DCN3.1 DIO
>   drm/amd/display: Add DCN3.1 OPTC
>   drm/amd/display: Add DCN3.1 DCHHUB
>   drm/amd/display: Add DCN3.1 DML calculation support
>   drm/amd/display: Add DCN3.1 IRQ manager
>   drm/amd/display: Add DCN3.1 GPIO support
>   drm/amd/display: Add DCN3.1 DMCUB
>   drm/amd/display: Add DCN3.1 PANEL
>   drm/amd/display: Add DCN3.1 HDCP support
>   drm/amd/display: Add DCN3.1 BIOS parser support
>   drm/amd/display: Add DCN3.1 HWSEQ
>   drm/amd/display: Add z10 restore checks for DC interfaces
>   drm/amd/display: Add DCN3.1 Resource
>   drm/amd/display: Add DCN3.1 blocks to the DC Makefile
>   drm/amd/display: Add DCN3.1 Yellow Carp support to DM
>   drm/amd/display: Add DC DCN3.1 support to Kconfig
>   drm/amdgpu: Add DC support and display block for Yellow Carp
> 
> Xiaomeng Hou (16):
>   drm/amd/pm: add read_sensor function for yellow carp
>   drm/amd/pm: add set_watermarks_table function for yellow carp
>   drm/amd/pm: add the fine grain tuning function for yellow carp
>   drm/amd/pm: add support to get dpm clock value for yellow carp
>   drm/amd/pm: add feature map for yellow carp
>   drm/amd/pm: implement is_dpm_running() callback for yellow carp
>   drm/amd/pm: initialize feature_enabled/feature_support bitmap for
>     yellow carp
>   drm/amd/pm: add callback force_clk_levels for yellow carp
>   drm/amd/pm: add callback to get bootup values for yellow carp
>   drm/amd/pm: add callback get_dpm_ultimate_freq for yellow carp
>   drm/amd/pm: add callbacks to read/write sysfs file
>     pp_power_profile_mode
>   drm/amd/pm: add the interface to dump smu metrics table for yellow
>     carp
>   drm/amdgpu: add gpu harvest support for yellow carp (v2)
>   drm/amdgpu: correct the cu and rb info for yellow carp
>   drm/amd/pm: add set_performance_level function for yellow carp
>   drm/amd/pm: disable manually setting MCLK power level on yellow carp
> 
>  drivers/gpu/drm/amd/amdgpu/Makefile           |      2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |      9 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h    |      1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |     19 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |      1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |      4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |     10 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |      4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     |      1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |      8 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |     83 +-
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c      |     40 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |     17 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |      9 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c       |      1 +
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |      1 +
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c        |    142 +-
>  drivers/gpu/drm/amd/amdgpu/nv.c               |     51 +
>  drivers/gpu/drm/amd/amdgpu/nv.h               |      2 +
>  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c        |     37 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |      7 +
>  .../gpu/drm/amd/amdgpu/yellow_carp_reg_init.c |     51 +
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |     52 +
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c       |     19 +
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c |      1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |      1 +
>  .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |      1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |      1 +
>  drivers/gpu/drm/amd/display/Kconfig           |      7 +
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |     44 +
>  .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |     13 +
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |      6 +
>  drivers/gpu/drm/amd/display/dc/Makefile       |      3 +
>  .../drm/amd/display/dc/bios/bios_parser2.c    |    113 +
>  .../display/dc/bios/command_table_helper2.c   |      5 +
>  .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |     11 +
>  .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |     30 +
>  .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |      4 +
>  .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |    673 +
>  .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.h  |    103 +
>  .../amd/display/dc/clk_mgr/dcn31/dcn31_smu.c  |    333 +
>  .../amd/display/dc/clk_mgr/dcn31/dcn31_smu.h  |    271 +
>  drivers/gpu/drm/amd/display/dc/core/dc.c      |     17 +
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c |     18 +
>  .../gpu/drm/amd/display/dc/core/dc_resource.c |     26 +
>  .../gpu/drm/amd/display/dc/core/dc_stream.c   |      6 +
>  drivers/gpu/drm/amd/display/dc/dc.h           |     28 +
>  drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |     23 +
>  drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |      3 +
>  .../gpu/drm/amd/display/dc/dce/dce_hwseq.h    |     21 +-
>  .../display/dc/dce110/dce110_hw_sequencer.c   |     23 +
>  .../drm/amd/display/dc/dcn10/dcn10_hubbub.h   |     48 +
>  .../amd/display/dc/dcn10/dcn10_link_encoder.h |     20 +
>  .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |     11 +
>  .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |      2 +
>  .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |     54 +
>  .../drm/amd/display/dc/dcn20/dcn20_hubbub.h   |      9 +
>  .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h |     16 +
>  .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |     37 +
>  .../drm/amd/display/dc/dcn20/dcn20_resource.c |     39 +
>  .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |      5 +
>  drivers/gpu/drm/amd/display/dc/dcn31/Makefile |     35 +
>  .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c |    279 +
>  .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |    147 +
>  .../display/dc/dcn31/dcn31_dio_link_encoder.c |    412 +
>  .../display/dc/dcn31/dcn31_dio_link_encoder.h |    246 +
>  .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   |    956 +
>  .../drm/amd/display/dc/dcn31/dcn31_hubbub.h   |    122 +
>  .../gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c |    103 +
>  .../gpu/drm/amd/display/dc/dcn31/dcn31_hubp.h |    246 +
>  .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |    598 +
>  .../drm/amd/display/dc/dcn31/dcn31_hwseq.h    |     56 +
>  .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |    151 +
>  .../gpu/drm/amd/display/dc/dcn31/dcn31_init.h |     33 +
>  .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c |    287 +
>  .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.h |    259 +
>  .../amd/display/dc/dcn31/dcn31_panel_cntl.c   |    157 +
>  .../amd/display/dc/dcn31/dcn31_panel_cntl.h   |     40 +
>  .../drm/amd/display/dc/dcn31/dcn31_resource.c |   2180 +
>  .../drm/amd/display/dc/dcn31/dcn31_resource.h |     42 +
>  drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |      5 +
>  drivers/gpu/drm/amd/display/dc/dm_helpers.h   |      6 +
>  drivers/gpu/drm/amd/display/dc/dml/Makefile   |     11 +
>  .../dc/dml/dcn31/display_mode_vba_31.c        |   7506 ++
>  .../dc/dml/dcn31/display_mode_vba_31.h        |     43 +
>  .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |   1727 +
>  .../dc/dml/dcn31/display_rq_dlg_calc_31.h     |     69 +
>  .../drm/amd/display/dc/dml/display_mode_lib.c |     18 +
>  .../drm/amd/display/dc/dml/display_mode_lib.h |      4 +
>  .../amd/display/dc/dml/display_mode_structs.h |     12 +
>  .../drm/amd/display/dc/dml/display_mode_vba.c |     42 +
>  .../drm/amd/display/dc/dml/display_mode_vba.h |     52 +
>  .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |      3 +
>  .../drm/amd/display/dc/gpio/hw_translate.c    |      3 +
>  .../gpu/drm/amd/display/dc/inc/core_types.h   |     10 +
>  .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |      3 +
>  drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |     56 +
>  .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |      5 +
>  .../drm/amd/display/dc/inc/hw/link_encoder.h  |     14 +
>  .../gpu/drm/amd/display/dc/inc/hw/mem_input.h |      4 +
>  .../amd/display/dc/inc/hw/timing_generator.h  |      4 +
>  .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |      4 +
>  drivers/gpu/drm/amd/display/dc/irq/Makefile   |     11 +
>  .../display/dc/irq/dcn31/irq_service_dcn31.c  |    432 +
>  .../display/dc/irq/dcn31/irq_service_dcn31.h  |     37 +
>  drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |     12 +
>  .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |    118 +
>  drivers/gpu/drm/amd/display/dmub/src/Makefile |      3 +
>  .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |    354 +
>  .../gpu/drm/amd/display/dmub/src/dmub_dcn31.h |    230 +
>  .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |     37 +
>  .../gpu/drm/amd/display/include/dal_asic_id.h |     13 +
>  .../gpu/drm/amd/display/include/dal_types.h   |      3 +
>  .../drm/amd/display/modules/hdcp/hdcp_log.c   |      4 +
>  .../drm/amd/display/modules/hdcp/hdcp_psp.c   |    135 +-
>  .../drm/amd/display/modules/hdcp/hdcp_psp.h   |     38 +
>  .../drm/amd/display/modules/inc/mod_hdcp.h    |     23 +-
>  .../include/asic_reg/dcn/dcn_3_1_2_offset.h   |  15083 +++
>  .../include/asic_reg/dcn/dcn_3_1_2_sh_mask.h  |  60747 +++++++++
>  .../include/asic_reg/dpcs/dpcs_4_2_0_offset.h |  11936 ++
>  .../asic_reg/dpcs/dpcs_4_2_0_sh_mask.h        | 103385 +++++++++++++++
>  .../include/asic_reg/mp/mp_13_0_1_offset.h    |    355 +
>  .../include/asic_reg/mp/mp_13_0_1_sh_mask.h   |    531 +
>  drivers/gpu/drm/amd/include/atomfirmware.h    |     56 +-
>  .../gpu/drm/amd/include/yellow_carp_offset.h  |   1366 +
>  .../amd/pm/inc/smu13_driver_if_yellow_carp.h  |    222 +
>  drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h      |     57 +
>  drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h |    139 +
>  .../gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h    |     97 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |      7 +
>  drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile   |      2 +-
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c  |    311 +
>  .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |   1210 +
>  .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h  |     28 +
>  include/drm/amd_asic_type.h                   |      1 +
>  include/uapi/drm/amdgpu_drm.h                 |      1 +
>  136 files changed, 215465 insertions(+), 66 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/yellow_carp_reg_init.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/Makefile
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.h
>  create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
>  create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
>  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_offset.h
>  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_sh_mask.h
>  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_2_0_offset.h
>  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_2_0_sh_mask.h
>  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_1_offset.h
>  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_1_sh_mask.h
>  create mode 100644 drivers/gpu/drm/amd/include/yellow_carp_offset.h
>  create mode 100644 drivers/gpu/drm/amd/pm/inc/smu13_driver_if_yellow_carp.h
>  create mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
>  create mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h
>  create mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
>  create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c
>  create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>  create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
> 
> -- 
> 2.31.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cray.huang%40amd.com%7C1937eee84d9c4cb003d008d925e66f99%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637582493915660523%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Qmgz7X9ZWslau62%2B2oNUhPVJDIvvm9BQTsLLwlI18rI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
