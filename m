Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4DCE77199
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 09:07:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E4CB10E28E;
	Wed,  8 Jan 2025 09:07:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YFWrW7XA";
	dkim-atps=neutral
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31E2110E7EA
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 02:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736303647; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=pVlTQIbFuRa2W/n67g0E65TmqpSMwXCyHsru7N04vV8=;
 b=YFWrW7XAwAh2bZKN8chh2JJKaCQ/zI7gJ9svt4Zgb+ReDf0ZUDiivu+R60oaTymgHIFkavwPyZf468PDo0Dl6YYhT0/L8d1+86gSDxmp0pQVPVGWnUx+W8WdR1PqeevvlwSezELEw9JARXprn2Pux3Myh/1eje0ar1ZSxebrkYk=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com
 fp:SMTPD_---0WNC83CF_1736303642 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 08 Jan 2025 10:34:06 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, xueshuai@linux.alibaba.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tianruidong@linux.alibaba.com
Subject: [RESEND PATCH] drm/amdgpu: add tracepoint while dump mca bank
Date: Wed,  8 Jan 2025 10:34:00 +0800
Message-Id: <20250108023400.35081-1-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Jan 2025 09:07:10 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RAS errors are typically exposed to user-space programs using tracepoints,
allowing tools like rasdaemon to decode and post-process them.
AMDGPU might also follow this, offering the following benefits:
1. It can proactively notify users of RAS events, eliminating the need
   to monitor /dev/kmsg.
2. It allows for further post-processing similar to AMD SMCA[1].

[1]: https://github.com/mchehab/rasdaemon/commit/932118

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c   |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 31 +++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 3ca03b5e0f91..9daa95365457 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -23,6 +23,7 @@
 #include "amdgpu_ras.h"
 #include "amdgpu.h"
 #include "amdgpu_mca.h"
+#include "amdgpu_trace.h"
 
 #include "umc/umc_6_7_0_offset.h"
 #include "umc/umc_6_7_0_sh_mask.h"
@@ -287,6 +288,8 @@ static void amdgpu_mca_smu_mca_bank_dump(struct amdgpu_device *adev, int idx, st
 		      idx, entry->regs[MCA_REG_IDX_IPID]);
 	RAS_EVENT_LOG(adev, event_id, HW_ERR "aca entry[%02d].SYND=0x%016llx\n",
 		      idx, entry->regs[MCA_REG_IDX_SYND]);
+
+	trace_amdgpu_mca_bank_dumps(event_id, idx, entry);
 }
 
 static int amdgpu_mca_smu_get_valid_mca_count(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, uint32_t *count)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 383fce40d4dd..a0ba79394099 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -554,6 +554,37 @@ TRACE_EVENT(amdgpu_reset_reg_dumps,
 		      __entry->value)
 );
 
+TRACE_EVENT(amdgpu_mca_bank_dumps,
+	   TP_PROTO(uint64_t event_id, int idx, struct mca_bank_entry *e),
+	   TP_ARGS(event_id, idx, e),
+	   TP_STRUCT__entry(
+			    __field(uint64_t, event_id)
+			    __field(int, idx)
+			    __field(uint64_t, status)
+			    __field(uint64_t, addr)
+			    __field(uint64_t, misc0)
+			    __field(uint64_t, ipid)
+			    __field(uint64_t, synd)
+			    ),
+	   TP_fast_assign(
+			  __entry->event_id = event_id;
+			  __entry->idx = idx;
+			  __entry->status = e->regs[MCA_REG_IDX_STATUS];
+			  __entry->addr = e->regs[MCA_REG_IDX_ADDR];
+			  __entry->misc0 = e->regs[MCA_REG_IDX_MISC0];
+			  __entry->ipid = e->regs[MCA_REG_IDX_IPID];
+			  __entry->synd = e->regs[MCA_REG_IDX_SYND];
+			  ),
+	   TP_printk("amdgpu mca bank dump: event_id: %lld, idx: %d, STATUS: %016llx, ADDR: %016llx, MISC0: %016llx, IPID: %016llx, SYND: %016llx",
+		     __entry->event_id,
+		     __entry->idx,
+		     __entry->status,
+		     __entry->addr,
+		     __entry->misc0,
+		     __entry->ipid,
+		     __entry->synd)
+);
+
 #undef AMDGPU_JOB_GET_TIMELINE_NAME
 #endif
 
-- 
2.33.1

