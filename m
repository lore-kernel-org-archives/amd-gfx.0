Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575D2C43331
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0294B64ED6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0294B64ED6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 014166EB6C;
	Wed, 24 Feb 2021 22:21:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A69296EB5C
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NByfMOdzImJ9u2hjF7ETXJlMLf9C99gyrTrMBqJiOtcUbesPX+u0gfveD9JsjkLw18a/0I8m8JuACZHZ1dD82knx2PSnD/Zdv6BQ16hjk95lYdqw7jvbVrg4hv91URqCXIxHfdOOgEfdYE164MVN+Sp4CoobzWYp1y1hMvW1GemcOFk55/pxCh+juvFZfAjQ+/7P8mjj+0jszQ+BQ8QcDWqvYC2eMZx5qLV3RIHn77D40+7XaSoXCHMfUaQfZIaLzHhfX3bsQIJ/BhJTFjLUDuXajZij8Kgt/oyX7eBsj8XG/W7LsQRvlj+p8Uco7sCKUm2pI148Ha7VcD+AB/DV7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hu10Hyam7exryzJ5jy2U69WxHUNZyspqrBfGgkPYOpg=;
 b=gMmnvL6J51OwhCX6mk7YlvqYUJLjVAEUvXDzuSJy5yX74nW1h9R8zO1U0n6MddAcr7syRGUYSJu6RijMuXmrDzdEWVTuUrf05UcwCZK6CLbPS0dog0iYSXOQ/1udeV6Uxub51dymHopQZV1bf+9PzITXBb0LAHOV+ZYUg/Ad3Gj/v+OkWFd/mUpQ05N5wdeiSZLi4+5QZVCv98iLp73XjCCLX09gPZw7/PvcgeNQjvYhLdd3lDcjlGlNtE1DS7ytBEvHF9KjCr6HWYPkgLNVYlpQlous+AVajeoe5LrEkNsAYEgfw8yx44QvpmWwPsd9vUxXvETO1MQUuKia0guK0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hu10Hyam7exryzJ5jy2U69WxHUNZyspqrBfGgkPYOpg=;
 b=gcUTDNV4Jtb5KS9pJ8cVy28DIC7AXu1oq+tEL6qtzC22jtJD4fniINEhlhDtD1n1XGCCkdY2TzhWokR9dBrPMpZL952fIpNc7FZuReCLTuKmb8W3loDbgPXeKfHTH0Zuus7RPFNDgPPFxfMxG+0YQ8lN03DXEuYWwXOMHbvYIT0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4798.namprd12.prod.outlook.com (2603:10b6:208:3d::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Wed, 24 Feb
 2021 22:21:11 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:11 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 095/159] drm/amdgpu: query aldebaran gfx_config through
 atomfirmware i/f
Date: Wed, 24 Feb 2021 17:17:55 -0500
Message-Id: <20210224221859.3068810-88-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4f61b7ed-762d-4bc8-f90d-08d8d9126379
X-MS-TrafficTypeDiagnostic: MN2PR12MB4798:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4798129D6C2A41C7060B4BFBF79F9@MN2PR12MB4798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mt+iysU6GBUYwXm4PGI87F+qfj9TlHFc1wWc10F2JuZPSe7LrNQHIqWCK/bNnCIox4R8ndDTzs17xLuFjF0T2o9wXdRHU3LlZ4w2T5Q3mryF3tSiDvjYmNMoAMuQC6Q1IYcnbvP7+VPy06f/48HJ8RsepRFqaAXh4PPwjcJe6WxVVikDzJBcXxP2LbeHnKIeGrYhMAM1l6MOwtvMd1UBkcrcxew8z5/6KCjrfTmRzMqxBRL3hS3uIeIGPGl74sn5t267B//mpI84thyo6NA1GxMqFVNxLfYehCMZg0pplIOxwkqx5OFsGTUyvFIUosrlSj+Y3OzujreLd2LmRj/HmO1J2ITBhx16aRrj3muU0cpuH8dxb/D/CLV98UOps9k//oj43wAuhWaDM+z8HtComCaNSx3XxKuZKI/X/lf/EUMcEXR/h/xtrTjqBSYNva7Gp5u4m6SOo0b9W0+YDMGQ28DOXHieeW5XJqN/xdSll8bMw0MTamowdxBDEwAGK+/4hsgv779EnGR+D2meIqWMLj4Ad3td1TWqFBaidTzApQBbqT5BIKTjDA72LkJQfS2Te5r40OdgVsUCqMDNz2Ni+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(1076003)(83380400001)(8676002)(8936002)(186003)(16526019)(6486002)(69590400012)(66476007)(66946007)(6506007)(2906002)(54906003)(86362001)(316002)(6916009)(66556008)(6512007)(26005)(2616005)(6666004)(956004)(4326008)(36756003)(52116002)(5660300002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QNePUH1SWU/O3W+pNWqxOSxQimFB4OhiA8i9vm2zh75D6lNO4K3YTxfSfV4L?=
 =?us-ascii?Q?vLERfxSiJhK/HWHTNl0TGKV6F8Jor9kCclWNIF3+XLgmyYrOdHmwHTftFO/0?=
 =?us-ascii?Q?rLTMZ7hjpUqmbu9CESh7/QqkUYvof3qVdELeeZ/smg1B5CceL3FVmoapLVlC?=
 =?us-ascii?Q?yqyAVXrS/0+dGbABUUuAbFU8wgVlFtqSepeji5SJFN7GdTaROopvVTErRn2U?=
 =?us-ascii?Q?DiD3e84aqiN/1HCmyc5YVRKByCnTNTLBEPexfLDSaVleXXoOYt2BnKxaiV8d?=
 =?us-ascii?Q?wW2p6ylvQA0Ie6AiblA3xLmgMFZFkvMZXz8rTwGFrauBfaY7NGUrSqgOWoVW?=
 =?us-ascii?Q?LBZqI3jr0V+wtBXwIcBeH8ki1dUegNFLuKSqfrs6oOy7GxM0KE/QL3VeuwIR?=
 =?us-ascii?Q?z2Scdn34Wj+Nvv7Kt9rrctu5vIOsQHQUsDptPMHMInhCmbH41mrHtdAHMzt3?=
 =?us-ascii?Q?pvKjZT+e9N+8djOaqsn7h94j6/bAWEVO+38AtUS//xMK1fIvQQHf4CyPDlYe?=
 =?us-ascii?Q?bTilhZ77MBW3D6esIZogTnyd00ve8iSrLHLS9jlWWQhQtxtxMMb++Mo8SoM/?=
 =?us-ascii?Q?myJuy0SbXYG3RqbbeDyjrVInGiKvphYpVmPmbHDIGY2Ei8iHCy9SnxedxBGR?=
 =?us-ascii?Q?MjiPAjxBqPBXMitqayjLh0IgvxOLYCB3rCzZDpdas8i5zKzjbU2KBCGQoEve?=
 =?us-ascii?Q?JLWCp32n/yLkJtV2MzCTJIw3wzhbQIhOUJ9EmT7Z593Lkhc6G5waQwNYKkX1?=
 =?us-ascii?Q?Hq+2zG+y6sl8BjsxQ8ExjH9gkZUrNVEuCKRaNCcp452F5/TJcJ4O/2aUfixM?=
 =?us-ascii?Q?LEinkb2QsQV2JFAJbb3ug2fbfMg+v3sfd1tE+tMqZDZly8pMtECY62qzQd8D?=
 =?us-ascii?Q?2n1vOBXdvqb4BZyesO6Lq29ge1KxmRsXhPbp5h6V1mICxzqvJuCQmJN1Md+1?=
 =?us-ascii?Q?dQeXlhVXiSuWbyJLTOqPNMI+sclK65IKW4CKeEeWlKCYagmnZGWb0wHiO4v0?=
 =?us-ascii?Q?5mDp9kCUGdvVz2z3G9T0kZ4QbNj135SyP5Z25AxiCisvlF0WutZnl4Ncw09w?=
 =?us-ascii?Q?Rhd1JGGDXZE7PSY4y5cZSfu8l2ZlDmEVYwubONIVeCqewwwrDBLW7eYPkLQt?=
 =?us-ascii?Q?MI5dkb9ReKqDmkCGRfCnjSJSjWwqTMP2d4u5Fy4z/mcWqYVdNv181/RPROXz?=
 =?us-ascii?Q?SeNQmPkj/Ahhjg7fIUjGvzKrj9jjegRPodCpqBGyBo3cgiLLBqyToFMn19Cg?=
 =?us-ascii?Q?RvQbaiZSvEUOJimFadSjZ3o5LlbPnWreVFopqFV8cJetV/adZzLiTWTSVubH?=
 =?us-ascii?Q?BdYTuejuPsxMZtdtRgdylNCQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f61b7ed-762d-4bc8-f90d-08d8d9126379
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:27.7488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fen+NFauDg+Jjzs5wrShti0mXBceUDxbiuNCRS2S59HCWdf1sQ4cSnVswOGlKyGP+6MIHckulzbRTRmCLKVvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4798
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

For ASICs that don't support ip discovery feature, query
gfx configuration through atomfirmware interface, rather
than gpu_info firmware.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 19 ++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  4 ++
 drivers/gpu/drm/amd/include/atomfirmware.h    | 41 +++++++++++++++++++
 3 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index d338f2db1f9c..74a871cf46b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -500,7 +500,8 @@ int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev)
 }
 
 union gfx_info {
-	struct  atom_gfx_info_v2_4 v24;
+	struct atom_gfx_info_v2_4 v24;
+	struct atom_gfx_info_v2_7 v27;
 };
 
 int amdgpu_atomfirmware_get_gfx_info(struct amdgpu_device *adev)
@@ -535,6 +536,22 @@ int amdgpu_atomfirmware_get_gfx_info(struct amdgpu_device *adev)
 			adev->gfx.cu_info.max_scratch_slots_per_cu = gfx_info->v24.gc_max_scratch_slots_per_cu;
 			adev->gfx.cu_info.lds_size = le16_to_cpu(gfx_info->v24.gc_lds_size);
 			return 0;
+		case 7:
+			adev->gfx.config.max_shader_engines = gfx_info->v27.max_shader_engines;
+			adev->gfx.config.max_cu_per_sh = gfx_info->v27.max_cu_per_sh;
+			adev->gfx.config.max_sh_per_se = gfx_info->v27.max_sh_per_se;
+			adev->gfx.config.max_backends_per_se = gfx_info->v27.max_backends_per_se;
+			adev->gfx.config.max_texture_channel_caches = gfx_info->v27.max_texture_channel_caches;
+			adev->gfx.config.max_gprs = le16_to_cpu(gfx_info->v27.gc_num_gprs);
+			adev->gfx.config.max_gs_threads = gfx_info->v27.gc_num_max_gs_thds;
+			adev->gfx.config.gs_vgt_table_depth = gfx_info->v27.gc_gs_table_depth;
+			adev->gfx.config.gs_prim_buffer_depth = le16_to_cpu(gfx_info->v27.gc_gsprim_buff_depth);
+			adev->gfx.config.double_offchip_lds_buf = gfx_info->v27.gc_double_offchip_lds_buffer;
+			adev->gfx.cu_info.wave_front_size = le16_to_cpu(gfx_info->v27.gc_wave_size);
+			adev->gfx.cu_info.max_waves_per_simd = le16_to_cpu(gfx_info->v27.gc_max_waves_per_simd);
+			adev->gfx.cu_info.max_scratch_slots_per_cu = gfx_info->v27.gc_max_scratch_slots_per_cu;
+			adev->gfx.cu_info.lds_size = le16_to_cpu(gfx_info->v27.gc_lds_size);
+			return 0;
 		default:
 			return -EINVAL;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 95cb1221c2b7..f886e9f22398 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2185,6 +2185,10 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 		gb_addr_config = RREG32_SOC15(GC, 0, mmGB_ADDR_CONFIG);
 		gb_addr_config &= ~0xf3e777ff;
 		gb_addr_config |= 0x22014042;
+		/* check vbios table if gpu info is not available */
+		err = amdgpu_atomfirmware_get_gfx_info(adev);
+		if (err)
+			return err;
 		break;
 	default:
 		BUG();
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index dd34f16b17fd..dc3ccd76be4a 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -1531,6 +1531,47 @@ struct  atom_gfx_info_v2_4
   uint32_t sram_custom_rm_fuses_val;
 };
 
+struct atom_gfx_info_v2_7 {
+	struct atom_common_table_header table_header;
+	uint8_t gfxip_min_ver;
+	uint8_t gfxip_max_ver;
+	uint8_t max_shader_engines;
+	uint8_t reserved;
+	uint8_t max_cu_per_sh;
+	uint8_t max_sh_per_se;
+	uint8_t max_backends_per_se;
+	uint8_t max_texture_channel_caches;
+	uint32_t regaddr_cp_dma_src_addr;
+	uint32_t regaddr_cp_dma_src_addr_hi;
+	uint32_t regaddr_cp_dma_dst_addr;
+	uint32_t regaddr_cp_dma_dst_addr_hi;
+	uint32_t regaddr_cp_dma_command;
+	uint32_t regaddr_cp_status;
+	uint32_t regaddr_rlc_gpu_clock_32;
+	uint32_t rlc_gpu_timer_refclk;
+	uint8_t active_cu_per_sh;
+	uint8_t active_rb_per_se;
+	uint16_t gcgoldenoffset;
+	uint16_t gc_num_gprs;
+	uint16_t gc_gsprim_buff_depth;
+	uint16_t gc_parameter_cache_depth;
+	uint16_t gc_wave_size;
+	uint16_t gc_max_waves_per_simd;
+	uint16_t gc_lds_size;
+	uint8_t gc_num_max_gs_thds;
+	uint8_t gc_gs_table_depth;
+	uint8_t gc_double_offchip_lds_buffer;
+	uint8_t gc_max_scratch_slots_per_cu;
+	uint32_t sram_rm_fuses_val;
+	uint32_t sram_custom_rm_fuses_val;
+	uint8_t cut_cu;
+	uint8_t active_cu_total;
+	uint8_t cu_reserved[2];
+	uint32_t gc_config;
+	uint8_t inactive_cu_per_se[8];
+	uint32_t reserved2[6];
+};
+
 /* 
   ***************************************************************************
     Data Table smu_info  structure
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
