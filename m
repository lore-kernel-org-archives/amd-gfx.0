Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366B8C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 08:18:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD1B8619B6
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 08:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1B8619B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thomaslambertz.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 583D86E862;
	Tue, 23 Mar 2021 08:18:31 +0000 (UTC)
X-Greylist: delayed 306 seconds by postgrey-1.36 at gabe;
 Mon, 22 Mar 2021 20:43:49 UTC
Received: from dal3relay234.mxroute.com (dal3relay234.mxroute.com
 [64.40.27.234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B4A26E029
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 20:43:49 +0000 (UTC)
Received: from filter004.mxroute.com ([149.28.56.236] filter004.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by dal3relay234.mxroute.com (ZoneMTA) with ESMTPSA id 1785ba93d5b000362f.003
 for <amd-gfx@lists.freedesktop.org>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Mon, 22 Mar 2021 20:38:41 +0000
X-Zone-Loop: 8cd44d3f25563b5a8e87947550dfb416a0e280a36c30
X-Originating-IP: [149.28.56.236]
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 amd-gfx@lists.freedesktop.org
From: Thomas Lambertz <mail@thomaslambertz.de>
Subject: [PATCH] drm/amdgpu/display: fix dmub invalid register read
Message-ID: <3eb98a62-12f4-d191-97b8-15e2f8ca06e3@thomaslambertz.de>
Date: Mon, 22 Mar 2021 21:38:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Language: en-US
X-AuthUser: mail@thomaslambertz.de
X-Mailman-Approved-At: Tue, 23 Mar 2021 08:18:23 +0000
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DMCUB_SCRATCH_0 sometimes contains 0xdeadbeef during initialization.
If this is detected, return 0 instead. This prevents wrong bit-flags
from being read.

The main impact of this bug is in the status check loop in
dmub_srv_wait_for_auto_load. As it is waiting for the device to become
ready, returning too early leads to a race condition. It is usually won
on first boot, but lost when laptop resumes from sleep, breaking screen
brightness control.

This issue was always present, but previously mitigated by the fact that
the full register was compared to the wanted value. Currently, only the
bottom two bits are tested, which are also set in 0xdeadbeef, thus
returning readiness to early.

Fixes: 5fe6b98ae00d ("drm/amd/display: Update dmub code")
Signed-off-by: Thomas Lambertz <mail@thomaslambertz.de>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c | 8 +++++++-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index 8e8e65fa83c0..d6fcae182f68 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -323,8 +323,14 @@ uint32_t dmub_dcn20_get_gpint_response(struct dmub_srv *dmub)
 union dmub_fw_boot_status dmub_dcn20_get_fw_boot_status(struct dmub_srv *dmub)
 {
 	union dmub_fw_boot_status status;
+	uint32_t value;
+
+	value = REG_READ(DMCUB_SCRATCH0);
+	if (value == DMCUB_SCRATCH0_INVALID)
+		status.all = 0;
+	else
+		status.all = value;

-	status.all = REG_READ(DMCUB_SCRATCH0);
 	return status;
 }

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
index a62be9c0652e..9557e76cf5d4 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
@@ -154,6 +154,8 @@ struct dmub_srv_common_regs {

 extern const struct dmub_srv_common_regs dmub_srv_dcn20_regs;

+#define DMCUB_SCRATCH0_INVALID 0xdeadbeef
+
 /* Hardware functions. */

 void dmub_dcn20_init(struct dmub_srv *dmub);
--
2.31.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
