Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7D9C4709D
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4AE361C49
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4AE361C49
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCDA66EDE9;
	Wed,  2 Jun 2021 16:51:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42B416EDE3
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:51:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgt5T9G3hek0ODe30k9yt2Zx4lIWjXqPeJec6Jld6hEsa4n+AKDTukiszJcefBOKfBx059TpNcAuTMDKyOMji0VfPSu8W/lxGbfwS1pFmViKiwLvoNhYLS71Afr1c3NLsLSp/2HlY0/J8TXh6X3IvCiqjA+a1XPb4ealHFSyG+6cEe0oztGxRhS9x49baWmzmCY/EZQwaJWkh/1615tTABnHrxM569atxh6Y94AQP5m5kdusFMRzQk6laYadGf4IwKsp+z0XnNy4K9oOAAHx93Eh6b1azJSuVSdYr7/XlijEtTopud6T+ue2oZTKCcRQMJK1sjotib5kooGEv6iDTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1bzHaol0cTiuhrl5IkT1UMrmo2vn+JUpUhNaa4cEiU=;
 b=AUvv/euxgpPzPTMvHltcuILdeYnCgjwpFmM2ZYlZjR+/uaytzx666cYV2TfCss+aWKxbjG12l/AEARKfcCeE4dOmNDLzxoMXRgq+JPLp6jDXy6FyG7cJt9PtsO/ajjm5Rgv8KjBrjXsvTBUPQCDuaphQ/toptnoqrOnf0+jUEvmj/HYvQPRKqZm+Ky+majPz/Rk2hLav3BswmddVtTeFT8Ou7Zy7c/97/cDTNp855x/NGal05bJLjeMBksjOZjJI4QP2+q8a6MP82KVKRNNM5yCAp69z14F/JNqPjbrjspMkjpUFLyhZcasQI3LdkuhcKpDYfqIwjXRhHn/I00Yvfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1bzHaol0cTiuhrl5IkT1UMrmo2vn+JUpUhNaa4cEiU=;
 b=rc1CES1z+/4b/9GIspTvLa8oF7F30tyrKFZGIirK6XiuBPuKaZsuOGSjEUaZu4W9Avu7luRYTncRTqy9XAtU7UcSOtRhNMjcBBR2HemGwPzbgCNv9FnPU69iDzTcDz0v3daO5e2hiNhTE4ZKwy204eyeWgEc7HfjBYH4+/bW3xc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:51:25 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:51:25 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 87/89] drm/amd/display: Add DCN3.1 Yellow Carp support to DM
Date: Wed,  2 Jun 2021 12:49:06 -0400
Message-Id: <20210602164908.2848791-87-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:50:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bbcf714-f25c-465c-f4a9-08d925e6865c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB453488A8EEFA4FF6AB29B73FF73D9@MN2PR12MB4534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:374;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PkW4mGHTUriDXezB8DoT2zguJdb/gzD2CK8w/Zv5bbn/TGQHyB6I5uzrXl3MgfhMbvy1dBXIPwKV8APfAc+JE7yT2nJFRHVbzAajE8+p5AOfyK6qouG3RvFnBCqVJK1qLE8ZZy507G0DdV6KcMw17ERCaDkbo3QTTxAkVsc3iPGOvx7Jnn0um5Dro03LFqJwMTA/+gev7IOWqfP+eO/oSE2k/SnmkFW0Zzh62RkRLpFJ/GhRHcpNLfjjXjCPCcLFB0gRxDaf8gPA8FRhnsDKEu6czygWtZ7Q2wZF95vn0miFlyHkcKIO69qygZ/dztSwp9UzTOrSW8QFCzj4I85lsAfKNfHNZdO6J3tUeD3QMLYiunxPD5hoEngZCMB/v/dNQzXS4WjZzu2eN8mrq1Fo0SerIG5sbOFHIQK4RkCmMGmlTlTCu/Ow18Tz3ktWbhyjwSi3cFHFFcGwH9bqskDCS4vy443Xf2rUPOYNl6o0wlK/baeknmgdbDru7k6NjswiYqIddRtF/JMTF6Mkhtmo62M3YwnBZ3VDpevnrif5qU7b7lodtwlR643m/jUnHXzRKB2Qm8hA8wsOBbZdKJYdhn/5e3DAzZY6sMCzbvIbxfSrdC0tqFEwVMnmkqwCw5JyrgbyshuP5NEcWZqgRu/EbhA6qt65OQHkyhNFMNtGAn4hD5WMF+/do8+FHV+qgU7l
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(1076003)(8676002)(2906002)(8936002)(4326008)(2616005)(956004)(38350700002)(478600001)(38100700002)(83380400001)(66946007)(66476007)(66556008)(36756003)(54906003)(6486002)(52116002)(6916009)(316002)(6512007)(6506007)(16526019)(26005)(6666004)(5660300002)(186003)(86362001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?p/FQ5LMk/aFPPo15RDp+K8+kAKKA8KRkQrdJ3vporEFwQnsZesti42lDVL33?=
 =?us-ascii?Q?8/DZdwKwI4w6JADWelpe+pSyBIpZMDN6IcH/BjJuTllFkcLd8Q3B9kT78Wnx?=
 =?us-ascii?Q?jV23rKcqyBWV3zp/p8hD0hty9Q3hR6Na4WlxrSbBhG4CPw8aT3n+/IsRbRSC?=
 =?us-ascii?Q?V4wtmCY2Q4udzyq/9c0O+Zd731KOHb/AzGzCBy/A6DwaF8TP4H/g5Ky5OPeZ?=
 =?us-ascii?Q?cjxFoGj/d5ZrSVLudbFwJzsx5B7H7t9spSinnxR/rGQ0QGuCeN3rU18wpkFD?=
 =?us-ascii?Q?AGna9ZLREyxyskp0v+07w/o59AAoV0VR/XpRbF8g5iBUNAiCgaoPIqC1bxKx?=
 =?us-ascii?Q?KPkwZkVSw/u6uV4Km122ojtKQKiaFyxiRR4rMJeTOlQdX17xVAC5OXG/nR2k?=
 =?us-ascii?Q?pMbp/4OzkKkJ3f0CBiHeBlSCk9g+9sybLEdKyYK94bVttSvA0rDkndr+Ynh+?=
 =?us-ascii?Q?p7SVbEVS96npOa8ZvsBheEXL3zpmCK7EgOsCUEXw/3sajW24O2u0UMYWfiSL?=
 =?us-ascii?Q?24ZJEgSVsK2V4mmybmvpWBA6EFUhSwckM7aajeexpozjMtpzlmAQchToLcXj?=
 =?us-ascii?Q?dNWkZy9IgEuQ05MdGPUcIP0o2S9dSrr/1nJdbkI+YPTkfzSiGFoq2gLJlMPi?=
 =?us-ascii?Q?XBwlTRuceqLISn4ZTOqDkUOrXcl+WB0DWvjo06bfSFe9P8r5d7zVA84nz1QC?=
 =?us-ascii?Q?otsPDD0y1cJ84dkPwFZjp6XcMQCm+JEZFh1OdAvc3LPz2P4SsE13P2zgRAMf?=
 =?us-ascii?Q?CU1vS51p+MhCcr5Qz0j6Y5mcLKCis0bEelJcWbYG23zUUznJ1LKYiiDA/aVh?=
 =?us-ascii?Q?cNTKDFOufzPapU8LKUp9Z8Yt7+hpVMhSBXHrQJkY04dp2lICuDPMApnUI5FA?=
 =?us-ascii?Q?fYYrSklTFKf6d3ihmfbpjJsTyh+EUOpQgKQh5yZRlEasMPBVj9GbXOzuM6RT?=
 =?us-ascii?Q?NWGEMr+5KVt0ewiS5xGGp04Rq/oigbhTeAF/0UvdCgdEVzD76bdtiRRWtPiu?=
 =?us-ascii?Q?H67lrj1JA8tJkyTtGaXgy4PNz/+inIiCrL2zqbUi12r7YyK8Tr2M28hnhiBa?=
 =?us-ascii?Q?a8WakoeazI2ujDKi4p3LaLDA9pB39z1kugbn1ln6OqQ9rpyOBE822dvKBSGM?=
 =?us-ascii?Q?tP83hNGAkdwGI0va5EzAvLbHFQIQ5m18sgrbSSfg1clkRCLM27FQkN6UzrZB?=
 =?us-ascii?Q?Q1S3KjOQWM4RNnb55WJ+OJ6nHb2evnn8boKDaNpBC1Pw4CNEy1M3NvO0ZfnS?=
 =?us-ascii?Q?Iw8P98JzxbMZNuE5ivL+yl25fyX8kntD0CIZuzxnIhRPRRgMP8LkmSt1dxa/?=
 =?us-ascii?Q?XIW9ZDwheQe03hqNy2Zdk3Ys?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bbcf714-f25c-465c-f4a9-08d925e6865c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:27.8183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVkAKCu+6ssdz956L8xKj26xqfxiyk8ETVnJr8/wL7jx3qt9wYsnZyhEOjrIiXHS75OJedSMAoodAsxcdmyeEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

To detect DCN3.1 ASICs and to enable the appropriate number of CRTCs,
pick the right validation paths for display formats and to use the
right DC interfaces.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index eb6f2e108a40..54dfa245b656 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -109,6 +109,10 @@ MODULE_FIRMWARE(FIRMWARE_VANGOGH_DMUB);
 MODULE_FIRMWARE(FIRMWARE_DIMGREY_CAVEFISH_DMUB);
 #define FIRMWARE_BEIGE_GOBY_DMUB "amdgpu/beige_goby_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_BEIGE_GOBY_DMUB);
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+#define FIRMWARE_YELLOW_CARP_DMUB "amdgpu/yellow_carp_dmcub.bin"
+MODULE_FIRMWARE(FIRMWARE_YELLOW_CARP_DMUB);
+#endif
 
 #define FIRMWARE_RAVEN_DMCU		"amdgpu/raven_dmcu.bin"
 MODULE_FIRMWARE(FIRMWARE_RAVEN_DMCU);
@@ -1151,6 +1155,11 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	case CHIP_VANGOGH:
 		init_data.flags.gpu_vm_support = true;
 		break;
+#endif
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	case CHIP_YELLOW_CARP:
+		init_data.flags.gpu_vm_support = true;
+		break;
 #endif
 	default:
 		break;
@@ -1401,6 +1410,9 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
 	case CHIP_VANGOGH:
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	case CHIP_YELLOW_CARP:
+#endif
 		return 0;
 	case CHIP_NAVI12:
 		fw_name_dmcu = FIRMWARE_NAVI12_DMCU;
@@ -1519,6 +1531,12 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		dmub_asic = DMUB_ASIC_DCN303;
 		fw_name_dmub = FIRMWARE_BEIGE_GOBY_DMUB;
 		break;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	case CHIP_YELLOW_CARP:
+		dmub_asic = DMUB_ASIC_DCN31;
+		fw_name_dmub = FIRMWARE_YELLOW_CARP_DMUB;
+		break;
+#endif
 
 	default:
 		/* ASIC doesn't support DMUB. */
@@ -2213,6 +2231,15 @@ static int dm_resume(void *handle)
 					= 0xffffffff;
 			}
 		}
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+		/*
+		 * Resource allocation happens for link encoders for newer ASIC in
+		 * dc_validate_global_state, so we need to revalidate it.
+		 *
+		 * This shouldn't fail (it passed once before), so warn if it does.
+		 */
+		WARN_ON(dc_validate_global_state(dm->dc, dc_state, false) != DC_OK);
+#endif
 
 		WARN_ON(!dc_commit_state(dm->dc, dc_state));
 
@@ -3757,6 +3784,9 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	switch (adev->asic_type) {
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	case CHIP_YELLOW_CARP:
+#endif
 	case CHIP_RENOIR:
 		if (register_outbox_irq_handlers(dm->adev)) {
 			DRM_ERROR("DM: Failed to initialize IRQ\n");
@@ -3861,6 +3891,9 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
 	case CHIP_VANGOGH:
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	case CHIP_YELLOW_CARP:
+#endif
 		if (dcn10_register_irq_handlers(dm->adev)) {
 			DRM_ERROR("DM: Failed to initialize IRQ\n");
 			goto fail;
@@ -4106,6 +4139,13 @@ static int dm_early_init(void *handle)
 		adev->mode_info.num_hpd = 6;
 		adev->mode_info.num_dig = 6;
 		break;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	case CHIP_YELLOW_CARP:
+		adev->mode_info.num_crtc = 4;
+		adev->mode_info.num_hpd = 4;
+		adev->mode_info.num_dig = 4;
+		break;
+#endif
 	case CHIP_NAVI14:
 	case CHIP_DIMGREY_CAVEFISH:
 		adev->mode_info.num_crtc = 5;
@@ -4343,6 +4383,9 @@ fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
 	    adev->asic_type == CHIP_NAVY_FLOUNDER ||
 	    adev->asic_type == CHIP_DIMGREY_CAVEFISH ||
 	    adev->asic_type == CHIP_BEIGE_GOBY ||
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	    adev->asic_type == CHIP_YELLOW_CARP ||
+#endif
 	    adev->asic_type == CHIP_VANGOGH)
 		tiling_info->gfx9.num_pkrs = adev->gfx.config.gb_addr_config_fields.num_pkrs;
 }
@@ -4762,6 +4805,7 @@ get_plane_modifiers(const struct amdgpu_device *adev, unsigned int plane_type, u
 		break;
 	case AMDGPU_FAMILY_NV:
 	case AMDGPU_FAMILY_VGH:
+	case AMDGPU_FAMILY_YC:
 		if (adev->asic_type >= CHIP_SIENNA_CICHLID)
 			add_gfx10_3_modifiers(adev, mods, &size, &capacity);
 		else
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
