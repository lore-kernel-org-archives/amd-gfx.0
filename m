Return-Path: <SRS0=kdbD=HM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E354EC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 02:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9B164DD8
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 02:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9B164DD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C70B96EC1E;
	Wed, 10 Feb 2021 02:06:05 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F28926E120;
 Tue,  9 Feb 2021 23:48:27 +0000 (UTC)
Received: by mail-lf1-x136.google.com with SMTP id p21so113189lfu.11;
 Tue, 09 Feb 2021 15:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yNEcY+k1I/sPxeT89v0RbvERaYcFC6w0nk6p7Ga+k7o=;
 b=H55GtJ+kFJow/fff1SlxkWECW/MsUAGzpc1ycWI29ms7aU5BsoRoN6PI5KmdemYb3e
 lsdW1od8WBmJt4SLC9o5lqjwSPxX5fs7DCAZpvaLduFlvDn0up50izcE3A9sh684r1Og
 AhVM1o29PNIjDIv62v++595uWT8LWfgYSbHvAmGTVt0NNlWp/zT9kPJy/3lc7X7qUdyh
 6NMylHkFQ3VWjNHgUOKUdvqqwyiD3KqKSvPNVer+dV9SfmSbV2ZsJ4mldWqSnD3KeayA
 +L+czvtUTNzU2kIljMobA1Gwxet4fjA7apw9SRYaj+eX9RlWpXij60MQw53QCFt3jD9o
 3KpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yNEcY+k1I/sPxeT89v0RbvERaYcFC6w0nk6p7Ga+k7o=;
 b=aWa+c4Bv2S9JWLdHKD80NvxG3gbCUu8SPXvhDYwUln5RoaRiaEtjEqf4Vhgo7olOWr
 SIj4M8raorAZMmZacil0N0W+4c7Tta8bTrbfJyOo0VoyZtMaijjmqffpfMFuFDHaoHl8
 W5RRRXzh7b7SV7YKTRvu9VYdL9cTs50XAte+JSKXYBvbRrc19z1fykooGNEPZ0rJWBdk
 3KJ8kqe2NQ+PW8vqAxZF1n/5Qtt5BhkOad5UT8RdP+z6Jn+QGtQtHUb4Y9K/mbA7dT7H
 H8JGrVz5Y8tYLlYF0OqaQ3pq9RNFaYSQGuO260qcvov/JMzEv21g0wcZwDfuel5fGfLo
 /Yig==
X-Gm-Message-State: AOAM5315RZ7mWjCo4BDz3Ps7KsT5sywT1FaUaUb++9anZy3jfBEYWBOS
 2YbpFCaAw1ZLFnRHLZq20Rc=
X-Google-Smtp-Source: ABdhPJwEgfMGoJUtU5l1trR++7LWKZ1G/cGIubNiHZdjGVjhcKjS3G5FyPiBakSx7jaYCAYohVN/Yw==
X-Received: by 2002:a05:6512:39ce:: with SMTP id
 k14mr195590lfu.169.1612914506449; 
 Tue, 09 Feb 2021 15:48:26 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-164.NA.cust.bahnhof.se.
 [158.174.22.164])
 by smtp.gmail.com with ESMTPSA id c25sm23779lja.131.2021.02.09.15.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Feb 2021 15:48:25 -0800 (PST)
From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
To: David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 3/3] drm/nouveau/ttm: constify static vm_operations_struct
Date: Wed, 10 Feb 2021 00:48:17 +0100
Message-Id: <20210209234817.55112-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209234817.55112-1-rikard.falkeborn@gmail.com>
References: <20210209234817.55112-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 10 Feb 2021 02:06:04 +0000
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
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Rikard Falkeborn <rikard.falkeborn@gmail.com>,
 Ben Skeggs <bskeggs@redhat.com>, Alex Deucher <alexander.deucher@amd.com>,
 Likun Gao <Likun.Gao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The only usage of nouveau_ttm_vm_ops is to assign its address to the
vm_ops field in the vm_area_struct struct. Make it const to allow the
compiler to put it in read-only memory

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_ttm.c b/drivers/gpu/drm/nouveau/nouveau_ttm.c
index 495288182c2d..b81ae90b8449 100644
--- a/drivers/gpu/drm/nouveau/nouveau_ttm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_ttm.c
@@ -154,7 +154,7 @@ static vm_fault_t nouveau_ttm_fault(struct vm_fault *vmf)
 	return ret;
 }
 
-static struct vm_operations_struct nouveau_ttm_vm_ops = {
+static const struct vm_operations_struct nouveau_ttm_vm_ops = {
 	.fault = nouveau_ttm_fault,
 	.open = ttm_bo_vm_open,
 	.close = ttm_bo_vm_close,
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
