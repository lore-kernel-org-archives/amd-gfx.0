Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD69C04FDF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 12:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B33610E311;
	Mon, 24 Jul 2023 12:59:08 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BF0B10E1AE
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 07:49:14 +0000 (UTC)
Received: from mail.208.org (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTP id 4R8XNl4ZrDzBRDtD
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 15:49:11 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
 content-transfer-encoding:content-type:message-id:user-agent
 :references:in-reply-to:subject:to:from:date:mime-version; s=
 dkim; t=1690184951; x=1692776952; bh=vVJ3bb7oMBjSr1+hADUC18TYJ4B
 8OELU7j0ImBjB188=; b=AEIBg110l0BbLzgJd6nPytBbDM69Vbgy04pv8tHC2YP
 hNelaIt3d/efZCLpNVu/CzCqwfxjFQ/hjstWAXCGq5WAWGmYXkN1czq9OurgBVLd
 r70n0WF3bW6QJrrN/BJVzUWkm3QKyD27XXg4CbrGAUbkk+waLvNE6Fyj3xp6IQ3N
 MAprRne3s0xPaNi8JmM/K+WMZPG5113fYPo352pC1Edn0gK6q5xDdKRQR5Jg7C8/
 OMdS6QOsKdJWg5W8skBWHWnb67ZT1Uzl7kt13816WTP3STUdROg3loqRhhG0Uqp1
 5kQThPqSImZ/3HZT81FPVTn5GzWayXGJXiqGoZ71NWA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
 by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Xl0cCN5nNXJ5 for <amd-gfx@lists.freedesktop.org>;
 Mon, 24 Jul 2023 15:49:11 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTPSA id 4R8XNl31xyzBHBPw;
 Mon, 24 Jul 2023 15:49:11 +0800 (CST)
MIME-Version: 1.0
Date: Mon, 24 Jul 2023 15:49:11 +0800
From: sunran001@208suo.com
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amd/pm: Clean up errors in arcturus_ppt.c
In-Reply-To: <20230724074800.9099-1-xujianghui@cdjrlc.com>
References: <20230724074800.9099-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <d6c3b91864b9f3f90d8a2d3cd952bada@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 24 Jul 2023 12:58:34 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: "foo* bar" should be "foo *bar"
ERROR: spaces required around that '=' (ctx:VxW)
ERROR: space prohibited before that close parenthesis ')'

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c 
b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 3ecb900e6ecd..b26e9ac1ac30 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -691,7 +691,7 @@ int smu_cmn_feature_set_enabled(struct smu_context 
*smu,

  #undef __SMU_DUMMY_MAP
  #define __SMU_DUMMY_MAP(fea)	#fea
-static const char* __smu_feature_names[] = {
+static const char *__smu_feature_names[] = {
  	SMU_FEATURE_MASKS
  };

@@ -927,7 +927,7 @@ int smu_cmn_get_metrics_table(struct smu_context 
*smu,
  			      void *metrics_table,
  			      bool bypass_cache)
  {
-	struct smu_table_context *smu_table= &smu->smu_table;
+	struct smu_table_context *smu_table = &smu->smu_table;
  	uint32_t table_size =
  		smu_table->tables[SMU_TABLE_SMU_METRICS].size;
  	int ret = 0;
@@ -969,7 +969,7 @@ void smu_cmn_init_soft_gpu_metrics(void *table, 
uint8_t frev, uint8_t crev)
  	struct metrics_table_header *header = (struct metrics_table_header 
*)table;
  	uint16_t structure_size;

-#define METRICS_VERSION(a, b)	((a << 16) | b )
+#define METRICS_VERSION(a, b)	((a << 16) | b)

  	switch (METRICS_VERSION(frev, crev)) {
  	case METRICS_VERSION(1, 0):
