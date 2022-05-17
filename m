Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94C1C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 13:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11B5110F03E;
	Tue, 17 May 2022 13:13:10 +0000 (UTC)
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
 by gabe.freedesktop.org (Postfix) with ESMTP id 17FA010E55C
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 10:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=RGaHmVYObVzH+m7sYp
 QCxzcT7fn0h4cxILJiyo027rw=; b=H311eSeFVeS7yQZ7Yxaem9vUXiKucTs9MU
 lufXYklFJVA4BoUEUfTt/9Tgj/Hw/QBdh4SinvpRG6UqDPTsXxwhoAf6kdmiGy6X
 YDcwYazkr0iBNtsVExdU5Rc4T8kKBnWvwwqZqjz5WAZ0PXqktQVmq8rCsEB8dxMF
 Zv+GX4lnY=
Received: from localhost.localdomain (unknown [202.112.113.212])
 by smtp7 (Coremail) with SMTP id C8CowAAXIJObcYNi42D3Cw--.59736S4;
 Tue, 17 May 2022 17:57:57 +0800 (CST)
From: Yuanjun Gong <ruc_gongyuanjun@163.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>, Evan Quan <evan.quan@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] drm/amd/pm: fix a potential gpu_metrics_table memory leak
Date: Tue, 17 May 2022 17:57:46 +0800
Message-Id: <20220517095746.7537-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: C8CowAAXIJObcYNi42D3Cw--.59736S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFW7tFW7KFWxZw1DZF4xWFg_yoWftrc_Gr
 y8Xwn3Z3sxCF1vyrWrZFs8ZFyYkF15CF4kJFnYg390vr17XFy3Za9FqF1kua18CF1UZFWD
 XF1kXF98CrZrJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNJ5rUUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/xtbB6BUE5WBHIt94LQAAsT
X-Mailman-Approved-At: Tue, 17 May 2022 13:13:09 +0000
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
Cc: stable@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Gong Yuanjun <ruc_gongyuanjun@163.com>

gpu_metrics_table is allocated in yellow_carp_init_smc_tables() but
not freed in yellow_carp_fini_smc_tables().

Signed-off-by: Gong Yuanjun <ruc_gongyuanjun@163.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index e2d099409123..c66c39ccf19c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -190,6 +190,9 @@ static int yellow_carp_fini_smc_tables(struct smu_context *smu)
 	kfree(smu_table->watermarks_table);
 	smu_table->watermarks_table = NULL;
 
+	kfree(smu_table->gpu_metrics_table);
+	smu_table->gpu_metrics_table = NULL;
+
 	return 0;
 }
 
-- 
2.17.1

