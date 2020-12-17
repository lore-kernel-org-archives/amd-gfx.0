Return-Path: <SRS0=AWwP=FV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0EAC4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 16:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B17D233A2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 16:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B17D233A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B439A89C59;
	Thu, 17 Dec 2020 16:55:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D25F89C59
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Dec 2020 16:55:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQ4hmnGMY3nwJqpiz8ytCLIenOnaDEm5pUgyfXs+LLUhT1COEIzAc93Zxc9oKh+cLg9E02OVYFrSmyXGKEFkQnnVN7Ndu5TrJjFi2xZzRwj7P/0uYFZoZyhRgq/L8nKxI2M53CnV0MJHbtaU+QBn5Vnsl2bOw8s/JFy8Kck+n3av9A+7f2U7+x6ImFzGBga4vh9Nz5pNTdjgEHhqvwLcVcZELVwuvPGjgnue89B3Dnf/tqRW5O0xFU1cIUBC/ammLNaWmWLPBtVwftxhpO2iNdrjmpZfa9lHAwdGHj5Bce9UaBOpDxsdalwwtW4Mkp9GM3ENNtM+MB/F+5Mz4yXYYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJIJwHvU4fl0RInUlvctGiQnX93Su1DOEildmFf8tRQ=;
 b=mIjSiiA57iS+lM8SL0+SIP0wZJIaW/AckrdKTlU7UaevZC5bLr/VN9O9ST8YwTiZm/c/EyZUhWJ9X8BriMywwSAjlBb1sSOWrIblEi7VYR55tPTfj0vluKVqoSViqVpI+5KRtr3p/rhyIeo7/ck8UemNhssh6sUgZIYcs5jcHWUUueXzkBVQGDMU/CRqL4q0yeTNwfimtDHLEKee2xRnxypYAh1Rqj52E+7hSOM3EulWHhHVYDVDT36iJ5dlABOYUzNXCqmtSBUdLs7e2ofD4glJwrZGh9z9zT8Pf/NjhIrAel96Gg0vhwwRqK8SOp8KqnuLgZUj3ighI0GHDMpLlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJIJwHvU4fl0RInUlvctGiQnX93Su1DOEildmFf8tRQ=;
 b=gYP/6SsBe4Y04Uvkvzp2knvY36PEaffNC7BBc1qAHtmbwH4sTzYYe5C3q5HsYaUl6qCW1TFXCRyFDQDsyQT3A4Ma8R40WlVNSzI8ypo9EX+HA5dsYiTZwr2eYLDD0j3U40RdKml5q+fwqDFBDJl2b7Jd9f5mTKVb2wrx9Jr66ps=
Received: from BN6PR14CA0036.namprd14.prod.outlook.com (2603:10b6:404:13f::22)
 by BY5PR12MB5014.namprd12.prod.outlook.com (2603:10b6:a03:1c4::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 17 Dec
 2020 16:55:53 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::97) by BN6PR14CA0036.outlook.office365.com
 (2603:10b6:404:13f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Thu, 17 Dec 2020 16:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Thu, 17 Dec 2020 16:55:52 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 17 Dec
 2020 10:55:51 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 17 Dec 2020 10:55:46 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <nicholas.kazlauskas@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amd/display: enable idle optimizations for linux
 (MALL stutter)
Date: Thu, 17 Dec 2020 11:54:59 -0500
Message-ID: <20201217165459.3570331-2-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217165459.3570331-1-Bhawanpreet.Lakha@amd.com>
References: <20201217165459.3570331-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 694599c2-5e09-4f4f-020d-08d8a2ac9ce3
X-MS-TrafficTypeDiagnostic: BY5PR12MB5014:
X-Microsoft-Antispam-PRVS: <BY5PR12MB501420AEAD4B4E4FDA37D40AF9C40@BY5PR12MB5014.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: elj5/t+OLpNczFqqLw/uBuhahauJoza16nbtR7iMzhfWiSPXlOBH9f5dDGV8lwOkBlIULCT2NVq6Dg5BwdzYj1AB7cPWM55zK1N9fG2YymCQl6cJgNFCWNx/wwku7puPUuVULBbKrGXgVVXigNdq8L0ApR4Gk45jAnNSZkN+0CU8Bm+8BlLj7nP6qHmy4KJfqTt6lLRQFAB/Lyj8TqqO+H17a3+h5NZ8bf/gMlyjhAj37hi82QcAoZEc4Q7R21HrUf1uVcIS8v7+clTkFFFI1gtX/iTnRSktE+6S9aQPwvd9i7LuUr1i19w1AwVl4aPOVdq14vzhd/ZQzU/wy3hucwnC+584NLgp6BxBoQqWEuKseSaFbdAuJhTsEK8fUQ5IZumWvkv2AZajk9Vr89yUxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(46966005)(4326008)(426003)(82310400003)(316002)(54906003)(82740400003)(356005)(2906002)(2616005)(26005)(81166007)(6666004)(6636002)(7696005)(47076004)(336012)(36756003)(8676002)(8936002)(70586007)(110136005)(478600001)(70206006)(1076003)(186003)(5660300002)(86362001)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 16:55:52.2672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 694599c2-5e09-4f4f-020d-08d8a2ac9ce3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5014
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Nick Kazlauskas <Nicholas.Kazlauskas@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
We can only use this feature when the display is idle. When active vblank
irq count is 0 we know all the displays are idle.

[How]
-Add a active vblank irq counter
-Update the counter when we enable/disable vblank irq
-if vblank irq count is 0 we can consider mall stutter

Change-Id: Ib1e14a84ee2e8c6e057072128693449665012584
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Nick Kazlauskas <Nicholas.Kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/Kconfig           |  6 +++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 +++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  9 ++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +++
 4 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 797b5d4b43e5..2444e664c7ee 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -23,6 +23,12 @@ config DRM_AMD_DC_HDCP
 	help
 	  Choose this option if you want to support HDCP authentication.
 
+config DRM_AMD_DC_MALL
+	bool "Enable MALL support"
+	depends on DRM_AMD_DC
+	help
+	  Choose this option if you want to support MALL
+
 config DRM_AMD_DC_SI
 	bool "AMD DC support for Southern Islands ASICs"
 	default n
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a78ec16418b3..080f2a52cfed 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5479,6 +5479,7 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
 	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
+	struct amdgpu_display_manager *dm = &adev->dm;
 	int rc = 0;
 
 	if (enable) {
@@ -5494,7 +5495,28 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 		return rc;
 
 	irq_source = IRQ_TYPE_VBLANK + acrtc->otg_inst;
+#if defined(CONFIG_DRM_AMD_DC_MALL)
+
+	if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
+		return -EBUSY;
+
+	mutex_lock(&dm->dc_lock);
+
+	if (enable)
+		dm->active_vblank_irq_count++;
+	else
+		dm->active_vblank_irq_count--;
+
+	dc_allow_idle_optimizations(
+		adev->dm.dc, dm->active_vblank_irq_count == 0 ? true : false);
+
+	DRM_DEBUG_DRIVER("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
+	mutex_unlock(&dm->dc_lock);
+
+	return 0;
+#else
 	return dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
+#endif
 }
 
 static int dm_enable_vblank(struct drm_crtc *crtc)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 251af783f6b1..cab44bbd2e35 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -336,6 +336,15 @@ struct amdgpu_display_manager {
 	 */
 	const struct gpu_info_soc_bounding_box_v1_0 *soc_bounding_box;
 
+#if defined(CONFIG_DRM_AMD_DC_MALL)
+	/**
+	 * @active_vblank_irq_count
+	 *
+	 * number of currently active vblank irqs
+	 */
+	uint32_t active_vblank_irq_count;
+#endif
+
 #ifdef CONFIG_DEBUG_FS
 	/* set the crc calculation window*/
 	struct drm_property *crc_win_x_start_property;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 33642566bcb2..9d245033eb3d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -504,6 +504,9 @@ struct dc_debug_options {
 	bool dmcub_emulation;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool disable_idle_power_optimizations;
+#endif
+#ifdef CONFIG_DRM_AMD_DC_MALL
+	unsigned int mall_size_override;
 #endif
 	bool dmub_command_table; /* for testing only */
 	struct dc_bw_validation_profile bw_val_profile;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
