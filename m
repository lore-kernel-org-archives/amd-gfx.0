Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B734C001B0
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 07:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B276F10E24F;
	Wed,  9 Aug 2023 07:14:53 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76F2F10E130;
 Wed,  9 Aug 2023 03:45:34 +0000 (UTC)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RLG8B1Qrsz9tDG;
 Wed,  9 Aug 2023 11:42:02 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 11:45:29 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <Xinhui.Pan@amd.com>, <airlied@gmail.com>,
 <daniel@ffwll.ch>, <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <inki.dae@samsung.com>,
 <sw0312.kim@samsung.com>, <kyungmin.park@samsung.com>,
 <krzysztof.kozlowski@linaro.org>, <alim.akhtar@samsung.com>,
 <robdclark@gmail.com>, <quic_abhinavk@quicinc.com>,
 <dmitry.baryshkov@linaro.org>, <sean@poorly.run>,
 <marijn.suijten@somainline.org>, <bskeggs@redhat.com>, <kherbst@redhat.com>,
 <lyude@redhat.com>, <kraxel@redhat.com>, <gurchetansingh@chromium.org>,
 <olvaffe@gmail.com>, <paulo.miguel.almeida.rodenas@gmail.com>,
 <wenjing.liu@amd.com>, <haoping.liu@amd.com>, <Charlene.Liu@amd.com>,
 <chiahsuan.chung@amd.com>, <george.shen@amd.com>, <sancchen@amd.com>,
 <tony.tascioglu@amd.com>, <jaehyun.chung@amd.com>,
 <tales.aparecida@gmail.com>, <drv@mailo.com>, <aurabindo.pillai@amd.com>,
 <quic_vpolimer@quicinc.com>, <jiasheng@iscas.ac.cn>, <noralf@tronnes.org>,
 <jose.exposito89@gmail.com>, <javierm@redhat.com>, <mairacanal@riseup.net>,
 <davidgow@google.com>, <arthurgrillo@riseup.net>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH -next 4/7] drm/radeon: Remove unnecessary NULL values
Date: Wed, 9 Aug 2023 11:44:42 +0800
Message-ID: <20230809034445.434902-5-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809034445.434902-1-ruanjinjie@huawei.com>
References: <20230809034445.434902-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Wed, 09 Aug 2023 07:14:50 +0000
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
Cc: ruanjinjie@huawei.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The NULL initialization of the pointers assigned by kzalloc() first is
not necessary, because if the kzalloc() failed, the pointers will be
assigned NULL, otherwise it works as usual. so remove it.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/gpu/drm/radeon/radeon_agp.c             | 2 +-
 drivers/gpu/drm/radeon/radeon_combios.c         | 6 +++---
 drivers/gpu/drm/radeon/radeon_legacy_encoders.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_agp.c b/drivers/gpu/drm/radeon/radeon_agp.c
index d124600b5f58..a3d749e350f9 100644
--- a/drivers/gpu/drm/radeon/radeon_agp.c
+++ b/drivers/gpu/drm/radeon/radeon_agp.c
@@ -130,7 +130,7 @@ static struct radeon_agpmode_quirk radeon_agpmode_quirk_list[] = {
 struct radeon_agp_head *radeon_agp_head_init(struct drm_device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	struct radeon_agp_head *head = NULL;
+	struct radeon_agp_head *head;
 
 	head = kzalloc(sizeof(*head), GFP_KERNEL);
 	if (!head)
diff --git a/drivers/gpu/drm/radeon/radeon_combios.c b/drivers/gpu/drm/radeon/radeon_combios.c
index 795c3667f6d6..2620efc7c675 100644
--- a/drivers/gpu/drm/radeon/radeon_combios.c
+++ b/drivers/gpu/drm/radeon/radeon_combios.c
@@ -863,7 +863,7 @@ struct radeon_encoder_primary_dac *radeon_combios_get_primary_dac_info(struct
 	struct radeon_device *rdev = dev->dev_private;
 	uint16_t dac_info;
 	uint8_t rev, bg, dac;
-	struct radeon_encoder_primary_dac *p_dac = NULL;
+	struct radeon_encoder_primary_dac *p_dac;
 	int found = 0;
 
 	p_dac = kzalloc(sizeof(struct radeon_encoder_primary_dac),
@@ -1014,7 +1014,7 @@ struct radeon_encoder_tv_dac *radeon_combios_get_tv_dac_info(struct
 	struct radeon_device *rdev = dev->dev_private;
 	uint16_t dac_info;
 	uint8_t rev, bg, dac;
-	struct radeon_encoder_tv_dac *tv_dac = NULL;
+	struct radeon_encoder_tv_dac *tv_dac;
 	int found = 0;
 
 	tv_dac = kzalloc(sizeof(struct radeon_encoder_tv_dac), GFP_KERNEL);
@@ -1100,7 +1100,7 @@ static struct radeon_encoder_lvds *radeon_legacy_get_lvds_info_from_regs(struct
 									 radeon_device
 									 *rdev)
 {
-	struct radeon_encoder_lvds *lvds = NULL;
+	struct radeon_encoder_lvds *lvds;
 	uint32_t fp_vert_stretch, fp_horz_stretch;
 	uint32_t ppll_div_sel, ppll_val;
 	uint32_t lvds_ss_gen_cntl = RREG32(RADEON_LVDS_SS_GEN_CNTL);
diff --git a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c b/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
index 601d35d34eab..c4350ac2b3d2 100644
--- a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
+++ b/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
@@ -1692,7 +1692,7 @@ static struct radeon_encoder_int_tmds *radeon_legacy_get_tmds_info(struct radeon
 {
 	struct drm_device *dev = encoder->base.dev;
 	struct radeon_device *rdev = dev->dev_private;
-	struct radeon_encoder_int_tmds *tmds = NULL;
+	struct radeon_encoder_int_tmds *tmds;
 	bool ret;
 
 	tmds = kzalloc(sizeof(struct radeon_encoder_int_tmds), GFP_KERNEL);
@@ -1715,7 +1715,7 @@ static struct radeon_encoder_ext_tmds *radeon_legacy_get_ext_tmds_info(struct ra
 {
 	struct drm_device *dev = encoder->base.dev;
 	struct radeon_device *rdev = dev->dev_private;
-	struct radeon_encoder_ext_tmds *tmds = NULL;
+	struct radeon_encoder_ext_tmds *tmds;
 	bool ret;
 
 	if (rdev->is_atom_bios)
-- 
2.34.1

