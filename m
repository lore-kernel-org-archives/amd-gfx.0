Return-Path: <SRS0=uap9=5Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFE1C2D0F0
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 21:22:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D3E2080C
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 21:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PO2BvTIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D3E2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20F626E358;
	Tue, 31 Mar 2020 21:22:49 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40B286E358
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 21:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585689766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eex3SHts6rbpYBfbz4mSibBnrbBxISm/iRw73/lBaoQ=;
 b=PO2BvTIK5s7A8TaQY180gQ1wfuOkDQKIb0xvWVYGKQiXIuPIMF7dYos9s5b2/rpIXMCTTH
 kSKRff9+emxVckA0nyf6Xqhsa63/qheVGsFFlKPQCa1hB6PNF01/zYw0A8A9uSC2hv82i9
 cCELIqPumnPhlatN5aKoYVdZmykeQ/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-J37X7zepM-qZ1gBslB-yRg-1; Tue, 31 Mar 2020 17:22:42 -0400
X-MC-Unique: J37X7zepM-qZ1gBslB-yRg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CB4A18B5F6A;
 Tue, 31 Mar 2020 21:22:40 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-113-88.rdu2.redhat.com [10.10.113.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0ABA5C1BB;
 Tue, 31 Mar 2020 21:22:36 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/amdgpu_dm/mst: Remove useless sideband tracing
Date: Tue, 31 Mar 2020 17:22:23 -0400
Message-Id: <20200331212228.139219-2-lyude@redhat.com>
In-Reply-To: <20200331212228.139219-1-lyude@redhat.com>
References: <20200331212228.139219-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Leo Li <sunpeng.li@amd.com>,
 Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
 David Francis <David.Francis@amd.com>, Wenjing Liu <Wenjing.Liu@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We already trace DPCD reads/writes on both MST and SST, there's no
reason to have this code here (plus, toggling these things with a
define at the top of the file isn't how we do things in the kernel).

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 43 -------------------
 1 file changed, 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index e8208df420d9..7f2293016446 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -41,53 +41,10 @@
 #include "amdgpu_dm_debugfs.h"
 #endif
 
-
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 #include "dc/dcn20/dcn20_resource.h"
 #endif
 
-/* #define TRACE_DPCD */
-
-#ifdef TRACE_DPCD
-#define SIDE_BAND_MSG(address) (address >= DP_SIDEBAND_MSG_DOWN_REQ_BASE && address < DP_SINK_COUNT_ESI)
-
-static inline char *side_band_msg_type_to_str(uint32_t address)
-{
-	static char str[10] = {0};
-
-	if (address < DP_SIDEBAND_MSG_UP_REP_BASE)
-		strcpy(str, "DOWN_REQ");
-	else if (address < DP_SIDEBAND_MSG_DOWN_REP_BASE)
-		strcpy(str, "UP_REP");
-	else if (address < DP_SIDEBAND_MSG_UP_REQ_BASE)
-		strcpy(str, "DOWN_REP");
-	else
-		strcpy(str, "UP_REQ");
-
-	return str;
-}
-
-static void log_dpcd(uint8_t type,
-		     uint32_t address,
-		     uint8_t *data,
-		     uint32_t size,
-		     bool res)
-{
-	DRM_DEBUG_KMS("Op: %s, addr: %04x, SideBand Msg: %s, Op res: %s\n",
-			(type == DP_AUX_NATIVE_READ) ||
-			(type == DP_AUX_I2C_READ) ?
-					"Read" : "Write",
-			address,
-			SIDE_BAND_MSG(address) ?
-					side_band_msg_type_to_str(address) : "Nop",
-			res ? "OK" : "Fail");
-
-	if (res) {
-		print_hex_dump(KERN_INFO, "Body: ", DUMP_PREFIX_NONE, 16, 1, data, size, false);
-	}
-}
-#endif
-
 static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 				  struct drm_dp_aux_msg *msg)
 {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
