Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423EEC43603
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 20:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA8221556
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 20:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA8221556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91ECC6E1C4;
	Thu, 12 Dec 2019 20:17:44 +0000 (UTC)
X-Greylist: delayed 960 seconds by postgrey-1.36 at gabe;
 Thu, 12 Dec 2019 18:33:06 UTC
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECA976E0C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 18:33:06 +0000 (UTC)
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1ifT1L-0005CM-2Q; Thu, 12 Dec 2019 18:17:03 +0000
From: Colin King <colin.king@canonical.com>
To: Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Kenneth Feng <kenneth.feng@amd.com>,
 Yintian Tao <yttao@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH][next] drm/amd/powerplay: fix various dereferences of a
 pointer before it is null checked
Date: Thu, 12 Dec 2019 18:16:57 +0000
Message-Id: <20191212181657.101381-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 12 Dec 2019 20:17:43 +0000
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Colin Ian King <colin.king@canonical.com>

There are several occurrances of the pointer hwmgr being dereferenced
before it is null checked.  Fix these by performing the dereference
of hwmgr after it has been null checked.

Addresses-Coverity: ("Dereference before null check")
Fixes: 8497d2bcdee1 ("drm/amd/powerplay: enable pp one vf mode for vega10")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c |  6 +++---
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c   | 15 +++------------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index 5087d6bdba60..322c2015d3a0 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -275,12 +275,12 @@ static int pp_dpm_load_fw(void *handle)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr->not_vf)
-		return 0;
-
 	if (!hwmgr || !hwmgr->smumgr_funcs || !hwmgr->smumgr_funcs->start_smu)
 		return -EINVAL;
 
+	if (!hwmgr->not_vf)
+		return 0;
+
 	if (hwmgr->smumgr_funcs->start_smu(hwmgr)) {
 		pr_err("fw load failed\n");
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
index e2b82c902948..f48fdc7f0382 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
@@ -282,10 +282,7 @@ int hwmgr_hw_init(struct pp_hwmgr *hwmgr)
 
 int hwmgr_hw_fini(struct pp_hwmgr *hwmgr)
 {
-	if (!hwmgr->not_vf)
-		return 0;
-
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !hwmgr->pm_en || !hwmgr->not_vf)
 		return 0;
 
 	phm_stop_thermal_controller(hwmgr);
@@ -305,10 +302,7 @@ int hwmgr_suspend(struct pp_hwmgr *hwmgr)
 {
 	int ret = 0;
 
-	if (!hwmgr->not_vf)
-		return 0;
-
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !hwmgr->pm_en || !hwmgr->not_vf)
 		return 0;
 
 	phm_disable_smc_firmware_ctf(hwmgr);
@@ -327,13 +321,10 @@ int hwmgr_resume(struct pp_hwmgr *hwmgr)
 {
 	int ret = 0;
 
-	if (!hwmgr->not_vf)
-		return 0;
-
 	if (!hwmgr)
 		return -EINVAL;
 
-	if (!hwmgr->pm_en)
+	if (!hwmgr->not_vf || !hwmgr->pm_en)
 		return 0;
 
 	ret = phm_setup_asic(hwmgr);
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
