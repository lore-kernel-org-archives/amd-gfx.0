Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0500AC4724C
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 13:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D83EA20643
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 13:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83EA20643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21E166E984;
	Thu,  7 May 2020 13:35:21 +0000 (UTC)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF6A76E979;
 Thu,  7 May 2020 11:25:07 +0000 (UTC)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id B8738379BE6317962F8C;
 Thu,  7 May 2020 19:25:03 +0800 (CST)
Received: from huawei.com (10.67.174.156) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 7 May 2020
 19:24:57 +0800
From: ChenTao <chentao107@huawei.com>
To: <airlied@linux.ie>, <daniel@ffwll.ch>
Subject: [PATCH -next] drm/amd/dc: Remove a useless comparison
Date: Thu, 7 May 2020 19:24:12 +0800
Message-ID: <20200507112412.10829-1-chentao107@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-Originating-IP: [10.67.174.156]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 07 May 2020 13:35:20 +0000
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
Cc: Aric.Cyr@amd.com, sunpeng.li@amd.com, Anthony.Koo@amd.com,
 Rodrigo.Siqueira@amd.com, murton.liu@amd.com, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, chentao107@huawei.com,
 dri-devel@lists.freedesktop.org, harry.wentland@amd.com, sam@ravnborg.org,
 christian.koenig@amd.com, Su.Chung@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following warning:

'en' is uint32_t and can never be negative.

drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/hw_hpd.c:132:10: warning:
comparison of unsigned expression < 0 is always false [-Wtype-limits]
  if ((en < GPIO_DDC_LINE_MIN) || (en > GPIO_DDC_LINE_MAX)) {
drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/hw_generic.c:109:10: warning:
comparison of unsigned expression < 0 is always false [-Wtype-limits]
  if ((en < GPIO_DDC_LINE_MIN) || (en > GPIO_DDC_LINE_MAX)) {

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: ChenTao <chentao107@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c | 2 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c
index f9e847e6555d..6cd50232c432 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c
@@ -106,7 +106,7 @@ void dal_hw_generic_init(
 	enum gpio_id id,
 	uint32_t en)
 {
-	if ((en < GPIO_DDC_LINE_MIN) || (en > GPIO_DDC_LINE_MAX)) {
+	if (en > GPIO_DDC_LINE_MAX) {
 		ASSERT_CRITICAL(false);
 		*hw_generic = NULL;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c
index 692f29de7797..f91f426699c0 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c
@@ -129,7 +129,7 @@ void dal_hw_hpd_init(
 	enum gpio_id id,
 	uint32_t en)
 {
-	if ((en < GPIO_DDC_LINE_MIN) || (en > GPIO_DDC_LINE_MAX)) {
+	if (en > GPIO_DDC_LINE_MAX) {
 		ASSERT_CRITICAL(false);
 		*hw_hpd = NULL;
 	}
-- 
2.22.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
