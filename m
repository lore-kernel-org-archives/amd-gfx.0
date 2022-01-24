Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6411AC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 17:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0456610E39C;
	Mon, 24 Jan 2022 17:06:59 +0000 (UTC)
Received: from mta-p7.oit.umn.edu (mta-p7.oit.umn.edu [134.84.196.207])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EF4610E382
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 17:05:49 +0000 (UTC)
Received: from localhost (unknown [127.0.0.1])
 by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4JjGPz1fc7z9w2yK
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 16:57:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
 by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 71gGmIPrxpad for <amd-gfx@lists.freedesktop.org>;
 Mon, 24 Jan 2022 10:57:58 -0600 (CST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4JjGPk2VB1z9vYdy
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 10:57:46 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4JjGPk2VB1z9vYdy
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4JjGPk2VB1z9vYdy
Received: by mail-pj1-f69.google.com with SMTP id
 l1-20020a17090aec0100b001b508cd63f6so9682222pjy.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 08:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umn.edu; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PMFfnAra5OAPA2izCo6QzwQ1sU01OGFtg5xgGw3BVmI=;
 b=S5ZZStViBVCiSgrJgAPXiRKX3V4djwyrlnB6OeTG4NG6+lxAOXy+29Wuihu+/e9t5U
 sH5hNg7qOIvGf3Q1MMfagwm7osjrG9TKG8hddH3EbNMYSRBbaewNw9B5vpX1UZnmzFME
 BsU07O7fqLmJgYObCqfe/WIyIEux3XoN91Rn3QuGbaXd0oS/+bDEYKEFTMg1JEkvBF1d
 /ky91uNUGtQcUsznxztF+HkLCjOzeBBo+ChsTcLqdE9A5ViJkSchONnPUCrOn8XjYR8r
 c3/aMOq1VHBdqJV22eq7L5gC2vdW5HXd9kMNLdKTXDW0fdJEcHqeobKu+nukzGp8ojhj
 YvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PMFfnAra5OAPA2izCo6QzwQ1sU01OGFtg5xgGw3BVmI=;
 b=eIPM6+WLnYEQHgeRljIQt1po1PeXH9IR88sW2i+kPMycDi+8UCXwW6xlUFxv7Td5IQ
 OVGwgEMYR0hoCZI0Wb7+cNXUSGvUzhB8riSJ6fWcJrGsz2BTYSlZh+ctSHCFd4YrYHAq
 Xk8UmKYYdwF6MOxoAHUzXTM3yJZSJvi12wYLdD1gzZXNUiwSn/LoqgO9zhdSRZMEc6vl
 Rj8RGpF5vxqWw290NatfqEahXZ7vOZyFQitLYDHH+HY+t9z2ACZL2UyqwoLmwuaNCrv0
 02SS6roBAeYAaJRd+B+HZLj2cosojcG6gP1dYoKr9ycbr/ksBR2okh3zaXjPzkIPG7EQ
 2yng==
X-Gm-Message-State: AOAM533eXJWrng0exQa8g1MkdscacgRyq3Rx+RP7S7BtK7hPVQQcg1al
 C6gMPtuBHgLZWJUpGI9BGPNRREODTsf7hn0I/+skdoVJhv1rnY65yfcE7xe5mPAC/uPE2JkWf/i
 CZuKYNMAUzHa6Qc3OxRJWqEA9IEf5nA==
X-Received: by 2002:a65:610b:: with SMTP id z11mr12719317pgu.205.1643043465340; 
 Mon, 24 Jan 2022 08:57:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQnFXtF5Ph8R6eAihtOj2AR0vQXbTXIbQRkEBMw+neKa1NwTrsboSIeKwGF8tXd48OBGjhBA==
X-Received: by 2002:a65:610b:: with SMTP id z11mr12719303pgu.205.1643043465076; 
 Mon, 24 Jan 2022 08:57:45 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.61.248])
 by smtp.gmail.com with ESMTPSA id a15sm17826365pfv.212.2022.01.24.08.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jan 2022 08:57:44 -0800 (PST)
From: Zhou Qingyang <zhou1615@umn.edu>
To: zhou1615@umn.edu
Subject: [PATCH] drm/amd/display: Fix a NULL pointer dereference in
 amdgpu_dm_connector_add_common_modes()
Date: Tue, 25 Jan 2022 00:57:29 +0800
Message-Id: <20220124165732.56587-1-zhou1615@umn.edu>
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
Cc: Wayne Lin <Wayne.Lin@amd.com>, Leo Li <sunpeng.li@amd.com>, kjlu@umn.edu,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <Roman.Li@amd.com>,
 amd-gfx@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 David Airlie <airlied@linux.ie>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Tony Cheng <Tony.Cheng@amd.com>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Jude Shih <shenshih@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Nikola Cornij <nikola.cornij@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In amdgpu_dm_connector_add_common_modes(), amdgpu_dm_create_common_mode()
is assigned to mode and is passed to drm_mode_probed_add() directly after
that. drm_mode_probed_add() passes &mode->head to list_add_tail(), and
there is a dereference of it in list_add_tail() without recoveries, which
could lead to NULL pointer dereference on failure of
amdgpu_dm_create_common_mode().

Fix this by adding a NULL check of mode.

This bug was found by a static analyzer.

Builds with 'make allyesconfig' show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: e7b07ceef2a6 ("drm/amd/display: Merge amdgpu_dm_types and amdgpu_dm")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
The analysis employs differential checking to identify inconsistent 
security operations (e.g., checks or kfrees) between two code paths 
and confirms that the inconsistent operations are not recovered in the
current function or the callers, so they constitute bugs. 

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7f9773f8dab6..9ad94186b146 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8143,6 +8143,9 @@ static void amdgpu_dm_connector_add_common_modes(struct drm_encoder *encoder,
 		mode = amdgpu_dm_create_common_mode(encoder,
 				common_modes[i].name, common_modes[i].w,
 				common_modes[i].h);
+		if (!mode)
+			continue;
+
 		drm_mode_probed_add(connector, mode);
 		amdgpu_dm_connector->num_modes++;
 	}
-- 
2.25.1

