Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD98CDB483
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 08:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74E8110E4A0;
	Thu, 19 Oct 2023 08:36:39 +0000 (UTC)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B8F610E462;
 Thu, 19 Oct 2023 01:03:41 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=yang.lee@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0VuS1dn5_1697677416; 
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com
 fp:SMTPD_---0VuS1dn5_1697677416) by smtp.aliyun-inc.com;
 Thu, 19 Oct 2023 09:03:36 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: alexander.deucher@amd.com, harry.wentland@amd.com, airlied@gmail.com,
 daniel@ffwll.ch
Subject: [PATCH -next 2/2] drm/amd/display: clean up one inconsistent indenting
Date: Thu, 19 Oct 2023 09:03:32 +0800
Message-Id: <20231019010332.25878-2-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20231019010332.25878-1-yang.lee@linux.alibaba.com>
References: <20231019010332.25878-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Oct 2023 08:36:37 +0000
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
Cc: Abaci Robot <abaci@linux.alibaba.com>, Yang Li <yang.lee@linux.alibaba.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_policy.c:206 dml2_policy_build_synthetic_soc_states() warn: inconsistent indenting

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6933
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
index f8e9aa32ceab..0b3ab7aaea87 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
@@ -203,7 +203,7 @@ int dml2_policy_build_synthetic_soc_states(struct dml2_policy_build_synthetic_so
 			s->entry.fabricclk_mhz = p->in_states->state_array[i].fabricclk_mhz;
 			s->entry.dram_speed_mts = 0;
 
-		insert_entry_into_table_sorted(p->in_bbox, p->out_states, &s->entry);
+			insert_entry_into_table_sorted(p->in_bbox, p->out_states, &s->entry);
 		}
 	}
 	// Add max FCLK
-- 
2.20.1.7.g153144c

