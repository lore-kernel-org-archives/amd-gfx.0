Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9A6C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 17:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65C8010E3BB;
	Mon, 24 Jan 2022 17:06:59 +0000 (UTC)
X-Greylist: delayed 569 seconds by postgrey-1.36 at gabe;
 Mon, 24 Jan 2022 17:05:43 UTC
Received: from mta-p8.oit.umn.edu (mta-p8.oit.umn.edu [134.84.196.208])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5467A10E36D
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 17:05:43 +0000 (UTC)
Received: from localhost (unknown [127.0.0.1])
 by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4JjGMy3MZmz9vBsN
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 16:56:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
 by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AKIRLvpCaA2l for <amd-gfx@lists.freedesktop.org>;
 Mon, 24 Jan 2022 10:56:14 -0600 (CST)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4JjGMy1JXZz9vBsQ
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 10:56:13 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4JjGMy1JXZz9vBsQ
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4JjGMy1JXZz9vBsQ
Received: by mail-pl1-f199.google.com with SMTP id
 cp2-20020a170902e78200b0014a9f3e3c1fso3641477plb.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 08:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umn.edu; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5wazUphf657A8u85KxBx+8Rcz0Mc5JkcT16GzU8geFE=;
 b=mKuu8jAjF++IFpgduLN3RDEVefDAWyK1s4jcIwDrrK+XkSR3CLGnu6uzdybyWM/2C3
 n2Ka7vv2Kc4aFO7usHMBcS56BrfBYO+rChtPEsb85JbE7kFzCg+eZ97ccdjpG0AagJyl
 w2TOL8I+lRDJMovzuIUaKOjSCqvivDF5Sl34KOohYqPrdk97JIn8HtrZTRGtkoOgZQyS
 +BqNOR6gUwPP/qBFir0JaDtzbRBzxLMlEb+DKuppNoNmhV2dytprGUjKYlVanlscF3fL
 YnvpC74TvXg92Phex9UTG1VG/of07Q6Hc45DYRbggbr9jqtka4Z8CFLXtPXtW+vSjf7a
 gCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5wazUphf657A8u85KxBx+8Rcz0Mc5JkcT16GzU8geFE=;
 b=zVx01Np440a9VY8OUMF6rqHi2HBRmL4FyWhhQl4qWg+K5E16dxE9K1yK3G3+XwZjsM
 WwiJ0H8rw4hwjTdVnYIMtUIluJVOV8XyIYdIKway6RwAHjgdmtALRpJwLGvzjbMvGrNq
 AcZSs4TMJm/PeZ2W9qvjXpLw67Sz4gW3We4PKw3hgocCZuaOPkpP2nGpBwHZSJAsCrzF
 f6/mcIFf8NwM0Lpka6HD7heSrH/PS9yAVaxDKLT9RJfqG08hP9kQSBvvFbX2pNIeV42T
 dsPV/OS9J7tmI+CmwZPPkiGxPQ2ym6jYZYqVEAhjcoSUx7StidUO8/ntf87mFbXqeeJL
 35ww==
X-Gm-Message-State: AOAM532099fvXyhrEk+MP1OlQ+BgRIM0oIcOVjcTNy7fiediTl3b7lSV
 9MbvNeqIQimoNLCIPUGryfJcShsG4BGPfvTotzRitZhAa5b9DbHrQIIdhCZuIaT9N5TH4LTNVDk
 vybM0utV+FXpePnABbHv/FxI6vcxAXA==
X-Received: by 2002:a17:903:110d:b0:149:a833:af21 with SMTP id
 n13-20020a170903110d00b00149a833af21mr15513357plh.14.1643043373175; 
 Mon, 24 Jan 2022 08:56:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLuSK48OaRsgH3XF8ivq/y0OenHyrkB1/k/dcMZr1ADIQwnE4TW2Bda19qwmzB3Xd0i6sFJQ==
X-Received: by 2002:a17:903:110d:b0:149:a833:af21 with SMTP id
 n13-20020a170903110d00b00149a833af21mr15513334plh.14.1643043372944; 
 Mon, 24 Jan 2022 08:56:12 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.61.248])
 by smtp.gmail.com with ESMTPSA id p18sm18349600pfh.98.2022.01.24.08.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jan 2022 08:56:12 -0800 (PST)
From: Zhou Qingyang <zhou1615@umn.edu>
To: zhou1615@umn.edu
Subject: [PATCH] drm/amd/display/dc/calcs/dce_calcs: Fix a memleak in
 calculate_bandwidth()
Date: Tue, 25 Jan 2022 00:55:51 +0800
Message-Id: <20220124165552.56106-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Jan 2022 17:06:58 +0000
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
Cc: Mario Kleiner <mario.kleiner.de@gmail.com>, Leo Li <sunpeng.li@amd.com>,
 kjlu@umn.edu, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Lee Jones <lee.jones@linaro.org>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In calculate_bandwidth(), the tag free_sclk and free_yclk are reversed,
which could lead to a memory leak of yclk.

Fix this bug by changing the location of free_sclk and free_yclk.

This bug was found by a static analyzer.

Builds with 'make allyesconfig' show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 2be8989d0fc2 ("drm/amd/display/dc/calcs/dce_calcs: Move some large variables from the stack to the heap")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
The analysis employs differential checking to identify inconsistent 
security operations (e.g., checks or kfrees) between two code paths 
and confirms that the inconsistent operations are not recovered in the
current function or the callers, so they constitute bugs. 

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

 drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
index ff5bb152ef49..e6ef36de0825 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
@@ -2033,10 +2033,10 @@ static void calculate_bandwidth(
 	kfree(surface_type);
 free_tiling_mode:
 	kfree(tiling_mode);
-free_yclk:
-	kfree(yclk);
 free_sclk:
 	kfree(sclk);
+free_yclk:
+	kfree(yclk);
 }
 
 /*******************************************************************************
-- 
2.25.1

