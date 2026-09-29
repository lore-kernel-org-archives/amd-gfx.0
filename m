Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D82C9832A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D258E10ED76;
	Tue, 29 Sep 2026 08:23:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.b="VOdijnhC";
	dkim-atps=neutral
Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com
 [74.125.229.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F87110E8EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 03:09:41 +0000 (UTC)
Received: by mail-dy2-f42.google.com with SMTP id
 5a478bee46e88-3411e0ace58so5008491eec.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 20:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1790651380; x=1791256180;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ovbpo2QnHvH7arny/3o7azxV9+me2emF/sy5+OVOXY4=;
 b=VOdijnhCVDH0h0lmQYCmD+SN2njGXJUt5fU12ENfBS7Aq3Ric6EhbY2QGwZbbvqtoi
 Ofz6NmcnWTRifWGiyMWkTe2pK2bhl8zURabdjfZn0eE78/7S1bwZR4jf7uJH+Tp31gZf
 n5prL2hiAvk0X0XSBKL+GuP5LRAOVnsw1hz9jyoBXh2wVw+7NEGaPqxCp46C/OJeiiKQ
 QxbUX9NoPSbuZjx8hdinElYlnw8Ta9rEjj73xSAZt+nStCqUiUy7sA36+gmd4ElsswbR
 s76+neYuuiY9PHV6KOYv5aPZIt4eMzhcayBb0mZKNpuL2LC3jRE7hQRNiJccXAUOxPbC
 UPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790651380; x=1791256180;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ovbpo2QnHvH7arny/3o7azxV9+me2emF/sy5+OVOXY4=;
 b=wqGjKTqZMrGJQWiyQf+4N/tchWZZOjIyX2ITn17+BFfFwJLoD1imusSuBd9O7ICPoo
 YXAkINHJbZkD310OJidvyt45FW2GsnLYM0GSt3Ps1hOgUaWi7rzGVQGPuIwsAsrSnR6c
 qit0vIGzo7ye964x9BMC0wQyWLbY8apG6xDCPMdH6x/T5500mW2Db6gejfw59xaa+u6J
 U1U+VKtzQdjOmcvZv1fuGDlaaM1IKuVXe5t/gQzdtw6+0wxYNVc9fb7xvLTwmJf/1RLJ
 qW0pvFa+S1dmmy88b7za4xtmfVagE5saeOmbBqjXzt4bUVdx+RF6s1en1RA0Mqbw/wOc
 0LoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1lKAqJTaw2SgKxpzM6ZaC2VBefK3aWPG94IKagZ95jgrCeFiW9N/6O+awKbmIAlgBvJYJelAG@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKtwH4AKhLoqlVg0eKkIBiX0avp5ADuE9dhMgRA57AWPh0B/Xdy
 Ss6te0TOzfWSJXu2lLyllr2/FaC1wPZyEems6W6x9EA8FQQeJ/6ZsdwJuLW1owdpeJA=
X-Gm-Gg: AYBFou3ttB7VSU5JyA0RHxp5Qr90/6HsVHtsGLGzqSwG7M1uoHBipIRyCYbt3MQ5O12
 GlwNLJIMBpSxFFB/iul/6R8qgoJBe+g99lcdKz93V21Go5VN4MoGhZY+lNSEsowZ3TUAzy52kdG
 dme+FA4oarOc6D67wC18HYz3+sT2SAvCqM7Z4JsrwJCtSCKAH15/LkuJFzA/hg1B4/NqQEY2fjf
 kiO6mGEO0alLmoQGHuSEHDxHW33ewYMUV84RG8DSl0TSCtUCilL+/YESf3FvEuJu8eAlLPVMmlX
 PLJ4TTl2S3uokqP1TMxFD94lOezIGd8M+ECxPLi7WpHNnGR5lxN2lR2vFvZh9cSfGhnzcMcb5zY
 BfxRIEhJT/X1MsFRVyZiSTKFYivuICnt/HoGqYGMu1DTLHNE6G3+H/+8XJRalpOx6+dXX1chUj+
 tYwbg9EHjixqysgXxGWdqLS9rf9A6PL+42iXA8T5QEm9LeG3Zgz9Tp2QJPfLtBrE3nk42qxbA9C
 I4a/vd3mnPQmaih107YkfJEs+F0MnoVZbXWBNkqHZY9jPcrvNJ45HCksebDF8s2JTEB8lyCLxCR
 RWa5FQ==
X-Received: by 2002:a05:693c:8955:20b0:341:225b:d6f with SMTP id
 5a478bee46e88-34739c07f1emr6241228eec.19.1790651380153; 
 Mon, 28 Sep 2026 20:09:40 -0700 (PDT)
Received: from localhost.localdomain
 ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34b580fc50asm927881eec.14.2026.09.28.20.09.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 20:09:39 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Allen Pan <allen.pan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Charlene Liu <charlene.liu@amd.com>, Alex Hung <alex.hung@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <xinhui.pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 6.6.y] drm/amd/display: Add a dc_state NULL check in
 dc_state_release
Date: Mon, 28 Sep 2026 23:09:34 -0400
Message-ID: <20260929030936.86941-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 08:23:02 +0000
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

From: Allen Pan <allen.pan@amd.com>

[ Upstream commit 334b56cea5d9df5989be6cf1a5898114fa70ad98 ]

[How]
Check wheather state is NULL before releasing it.

[ Backport to 6.6.y: implemented the same guard in older
  dc_release_state() in dc.c rather than dc_state_release() in
  dc_state.c. ]

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Allen Pan <allen.pan@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and drm amd maintainers,

I am working through the small CVE backports still missing from 6.6.y.
This one addresses CVE-2024-26948. It adds upstream's NULL guard to the
older display-state release helper.

The helper is used by display-state cleanup paths and currently
dereferences its argument unconditionally. The patch makes the helper
NULL-safe.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.6.y?

CVE: CVE-2024-26948
Upstream: 334b56cea5d9df5989be6cf1a5898114fa70ad98

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index bea18f450ac9c7..6ba67a20eb4846 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2302,7 +2302,8 @@ static void dc_state_free(struct kref *kref)
 
 void dc_release_state(struct dc_state *context)
 {
-	kref_put(&context->refcount, dc_state_free);
+	if (context != NULL)
+		kref_put(&context->refcount, dc_state_free);
 }
 
 bool dc_set_generic_gpio_for_stereo(bool enable,
-- 
2.39.5
