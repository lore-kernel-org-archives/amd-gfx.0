Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C150C47076
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4551F611AB
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4551F611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B41C86E15F;
	Fri, 21 May 2021 17:37:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEA1B6E15F
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 17:37:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoWx95K3xhOByB7X/tlcIJqNmPpxbi2hNLpZ7Sq1IZJ1sbpIRka6SEthAzzrz1RZwR/VMde9qFmf5LhYyO58tMNr7XlvDULrrKBaVJhGsRbl79hMblB7ronMPi0E+gEmuGvlGCz9HtHZNulHl8mTslXgR5HrFix7MpKXqqgvj0EovmsBOZaY4kbPlynzCQTa/lzxHuY8TvlwnDBNDv5OINjNHw1UQ65pPjdpLzi1LvAhNnuGBWHX9V0sDK2qmMJEQkHNcCSLvDskFItNhAnK9tlR1Xu6jPr+m/iVhbY0nxdbsvDuoBzyC1kEP0h7WCi1BkI4XCcJN6LhkFA3jZCUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er7p/mkFixya6kLXY6+jHN0B0mkErxDvZ6fOpXCZFAI=;
 b=HKR95c7V5YXGirLFTNB4M+OwoW5rigvQuu7aW1nwJS08MZPrXqcxWnMCF0HEWUqWnrIueHbfeLdkXft5gh2JSflD/2EC5qY1ElQ+LlBuaK2dh3+AMBnzbuPv5jptyx/4b3JpD/ph0ZBK1tLbQkGoGjFldJK7YIcQENJm0iULHefyIXEGMAp0ybY0tnRCTh8tjjKWKaHJpwThRmqN5lDsSRswJfx8M+Jv14cG9QDBHvNbzm31B/PLtPYXNcEc3vLDulnDr/vYtN/dh8Tjb5JGNVEkfn3tf8zaJbXNEdC9y2yVYJeKJXu3SDf8MXXGI/c480t7+WGvWPpcVKBx4pJZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er7p/mkFixya6kLXY6+jHN0B0mkErxDvZ6fOpXCZFAI=;
 b=irLxRQHfThEDnXqwAKfa5nagHIxMCe0UjqANOi5fTc37HdiU8BE/BtAJpnIWBU7NOZKg5YG0+yoYkxFw3mOIHywSx/K0P/JSlEI/5x+KAO3oUN+d8Lj7Doy62+p/K0s0EVr2Gg56FkxFm+DoQJ8fgPsLoSUPfxtSfVay5stevwI=
Received: from BN9PR03CA0498.namprd03.prod.outlook.com (2603:10b6:408:130::23)
 by BYAPR12MB4631.namprd12.prod.outlook.com (2603:10b6:a03:10d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 17:36:58 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::72) by BN9PR03CA0498.outlook.office365.com
 (2603:10b6:408:130::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26 via Frontend
 Transport; Fri, 21 May 2021 17:36:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 21 May 2021 17:36:58 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 21 May
 2021 12:36:57 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/15] drm/amd/display: Added support for individual control
 for multiple back-light instances.
Date: Fri, 21 May 2021 13:36:32 -0400
Message-ID: <20210521173646.1140586-2-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
References: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e3f9666-9006-47f4-a837-08d91c7f08ca
X-MS-TrafficTypeDiagnostic: BYAPR12MB4631:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4631D6EBE87EF3976A28A260FB299@BYAPR12MB4631.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zKNK0ZM8rS4QqPo8Zbbv2E1BZK91TTHL7OE0ZsaxZyT8laiYKmZB0ooGpRDnXcOVYaLsju7emuNOtphveoDG/XefSbJ+D61u/9IYv6on9ONCidap1XjkcuLfMp0EwNi/19QdP42CgvgLydFg2LAKEzN4txCEXIH1xWdY0KOpvaiNfiI1AveKnZbTe64L/ZzoP1ry1HuUkPa/imQAQdtdybUw8TDyhdDBWu4f+VtPuySHKJfdoHoL2UNo4YHu/GhKFDuFKsmxBlh35hZSFqAP1BzmilYD8gvCmN9Wsw2MwSyJy4afJ9OIOguqXGUSGmWAc2s4im/XtDHM1CiaZCd0r/u4bB7A35TRI2vYc3g1xOU96QRhh3EQAYysaAcgpVvb7z5+9vu2sw4LOukvi28H7cUe1XWTZwm/LWuBmoBWZMESoCVg19dElxw++yAUxFA/XBos+KfevP18rianw6ajTEH77VTCz4fImSX4B49GGaPlfJ8SIux/HVbRAEmfJYZPQDm0x3WeBjEB/79rRND6MG8gPhrk/rxERlWrtp384tPYIKPuQoz5Tk2OVvqCW99Jrcp2GOzJ39T1cM30Oiur05BNtzFOH4MEWLKy/mxmxKXm9zM6uJLfWYm6Q3iu0e+w1ZOI517PSBvlzygB65xcgyKPuy9h0EL2cONcmnJoyn/vAS2z9qfMOI2Q2SZVnvSW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(36840700001)(46966006)(336012)(2616005)(86362001)(316002)(16526019)(47076005)(4326008)(5660300002)(36756003)(44832011)(426003)(82310400003)(478600001)(36860700001)(70206006)(82740400003)(81166007)(6916009)(8936002)(2906002)(8676002)(1076003)(6666004)(70586007)(54906003)(356005)(186003)(83380400001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 17:36:58.3129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3f9666-9006-47f4-a837-08d91c7f08ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4631
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com,
 Jake Wang <haonan.wang2@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jake Wang <haonan.wang2@amd.com>

[Why & How]
Added support for individual control for multiple back-light instances.

Signed-off-by: Jake Wang <haonan.wang2@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 26 +++++++++++--------
 drivers/gpu/drm/amd/display/dc/dc_link.h      | 17 ++++++++++++
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c | 10 +++----
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |  3 ++-
 .../amd/display/modules/power/power_helpers.c | 15 ++++++-----
 .../amd/display/modules/power/power_helpers.h |  3 ++-
 6 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8cd270f12918..40d119354509 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1709,7 +1709,6 @@ static int dm_late_init(void *handle)
 	unsigned int linear_lut[16];
 	int i;
 	struct dmcu *dmcu = NULL;
-	bool ret = true;
 
 	dmcu = adev->dm.dc->res_pool->dmcu;
 
@@ -1726,18 +1725,23 @@ static int dm_late_init(void *handle)
 	 * 0xFFFF x 0.01 = 0x28F
 	 */
 	params.min_abm_backlight = 0x28F;
-
 	/* In the case where abm is implemented on dmcub,
-	 * dmcu object will be null.
-	 * ABM 2.4 and up are implemented on dmcub.
-	 */
-	if (dmcu)
-		ret = dmcu_load_iram(dmcu, params);
-	else if (adev->dm.dc->ctx->dmub_srv)
-		ret = dmub_init_abm_config(adev->dm.dc->res_pool, params);
+	* dmcu object will be null.
+	* ABM 2.4 and up are implemented on dmcub.
+	*/
+	if (dmcu) {
+		if (!dmcu_load_iram(dmcu, params))
+			return -EINVAL;
+	} else if (adev->dm.dc->ctx->dmub_srv) {
+		struct dc_link *edp_links[MAX_NUM_EDP];
+		int edp_num;
 
-	if (!ret)
-		return -EINVAL;
+		get_edp_links(adev->dm.dc, edp_links, &edp_num);
+		for (i = 0; i < edp_num; i++) {
+			if (!dmub_init_abm_config(adev->dm.dc->res_pool, params, i))
+				return -EINVAL;
+		}
+	}
 
 	return detect_mst_link_for_all_connectors(adev_to_drm(adev));
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index c871923e7db0..c617e9ae68a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -216,6 +216,23 @@ static inline void get_edp_links(const struct dc *dc,
 	}
 }
 
+static inline bool dc_get_edp_link_panel_inst(const struct dc *dc,
+		const struct dc_link *link,
+		unsigned int *inst_out)
+{
+	struct dc_link *edp_links[MAX_NUM_EDP];
+	int edp_num;
+
+	if (link->connector_signal != SIGNAL_TYPE_EDP)
+		return false;
+	get_edp_links(dc, edp_links, &edp_num);
+	if ((edp_num > 1) && (link->link_index > edp_links[0]->link_index))
+		*inst_out = 1;
+	else
+		*inst_out = 0;
+	return true;
+}
+
 /* Set backlight level of an embedded panel (eDP, LVDS).
  * backlight_pwm_u16_16 is unsigned 32 bit with 16 bit integer
  * and 16 bit fractional, where 1.0 is max backlight value.
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index 6939ca2e8212..54a1408c8015 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -172,16 +172,12 @@ static bool dmub_abm_set_level(struct abm *abm, uint32_t level)
 
 static bool dmub_abm_init_config(struct abm *abm,
 	const char *src,
-	unsigned int bytes)
+	unsigned int bytes,
+	unsigned int inst)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = abm->ctx;
-	uint32_t edp_id_count = dc->dc_edp_id_count;
-	int i;
-	uint8_t panel_mask = 0;
-
-	for (i = 0; i < edp_id_count; i++)
-		panel_mask |= 0x01 << i;
+	uint8_t panel_mask = 0x01 << inst;
 
 	// TODO: Optimize by only reading back final 4 bytes
 	dmub_flush_buffer_mem(&dc->dmub_srv->dmub->scratch_mem_fb);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
index e8ce8c85adf1..142753644377 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
@@ -52,7 +52,8 @@ struct abm_funcs {
 	unsigned int (*get_target_backlight)(struct abm *abm);
 	bool (*init_abm_config)(struct abm *abm,
 			const char *src,
-			unsigned int bytes);
+			unsigned int bytes,
+			unsigned int inst);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 6270ecbd2438..5e7331be1c0d 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -660,7 +660,8 @@ static void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_table, struct dmcu_iram
 }
 
 bool dmub_init_abm_config(struct resource_pool *res_pool,
-	struct dmcu_iram_parameters params)
+	struct dmcu_iram_parameters params,
+	unsigned int inst)
 {
 	struct iram_table_v_2_2 ram_table;
 	struct abm_config_table config;
@@ -669,7 +670,7 @@ bool dmub_init_abm_config(struct resource_pool *res_pool,
 	uint32_t i, j = 0;
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-	if (res_pool->abm == NULL && res_pool->multiple_abms[0] == NULL)
+	if (res_pool->abm == NULL && res_pool->multiple_abms[inst] == NULL)
 		return false;
 #else
 	if (res_pool->abm == NULL)
@@ -728,13 +729,13 @@ bool dmub_init_abm_config(struct resource_pool *res_pool,
 	config.min_abm_backlight = ram_table.min_abm_backlight;
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-	if (res_pool->multiple_abms[0])
-		result = res_pool->multiple_abms[0]->funcs->init_abm_config(
-			res_pool->multiple_abms[0], (char *)(&config), sizeof(struct abm_config_table));
-	else
+	if (res_pool->multiple_abms[inst]) {
+		result = res_pool->multiple_abms[inst]->funcs->init_abm_config(
+			res_pool->multiple_abms[inst], (char *)(&config), sizeof(struct abm_config_table), inst);
+	} else
 #endif
 		result = res_pool->abm->funcs->init_abm_config(
-			res_pool->abm, (char *)(&config), sizeof(struct abm_config_table));
+			res_pool->abm, (char *)(&config), sizeof(struct abm_config_table), 0);
 
 	return result;
 }
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
index 6f2eecce6baa..2a9f8e2d8080 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
@@ -49,6 +49,7 @@ struct dmcu_iram_parameters {
 bool dmcu_load_iram(struct dmcu *dmcu,
 		struct dmcu_iram_parameters params);
 bool dmub_init_abm_config(struct resource_pool *res_pool,
-		struct dmcu_iram_parameters params);
+		struct dmcu_iram_parameters params,
+		unsigned int inst);
 
 #endif /* MODULES_POWER_POWER_HELPERS_H_ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
