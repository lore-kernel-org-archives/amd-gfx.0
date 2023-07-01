Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D80CEB64DA
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Jul 2023 02:10:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C24210E526;
	Sat,  1 Jul 2023 02:09:51 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2AD710E519;
 Sat,  1 Jul 2023 02:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aypGJ9zKriwl5rC/G/jg2t+UqZhEdGjhBXoWEgZUCvg=; b=pRlncQxZeXRzBd8d9pNtQjHbw2
 OLM2JC1G2JQw2KDsTdhL/GLf61rRrwZKZLPt1eoBrhgaWy0buejKE5scLhE+J5rDDdrCTXr/m1Tip
 C15kxHnHoG2WDisBaaxszxaFbhZKKddOhZ04VPevK1TxHJdoDWfvqbLaqib+QElLSris1ivEWygF8
 bwcMpjoxkfkqbyj1EbP2BLw13IUxTJF5GTvIl8NlIbv61oJwvV0XQaL69UQ9Y+jhYsqr1oc5JDWGU
 hADgZkZ28NFCHyF0/7OsOGnXmDUQp+Jsd1d6NfZCqu2MZOHu+dO4SMMc7VhOuzKU7TwLfZ7PFY5yR
 nbC0vvUg==;
Received: from [187.74.70.209] (helo=steammachine.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1qFQ3V-006abr-U9; Sat, 01 Jul 2023 04:09:46 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, wayland-devel@lists.freedesktop.org
Subject: [PATCH v4 4/6] amd/display: indicate support for atomic async
 page-flips on DC
Date: Fri, 30 Jun 2023 23:09:15 -0300
Message-ID: <20230701020917.143394-5-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230701020917.143394-1-andrealmeid@igalia.com>
References: <20230701020917.143394-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: pierre-eric.pelloux-prayer@amd.com,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Simon Ser <contact@emersion.fr>, Italo Nicola <italonicola@collabora.com>,
 Randy Dunlap <rdunlap@infradead.org>, Pekka Paalanen <ppaalanen@gmail.com>,
 Daniel Stone <daniel@fooishbar.org>, hwentlan@amd.com,
 Rob Clark <robdclark@gmail.com>, ville.syrjala@linux.intel.com,
 kernel-dev@igalia.com, alexander.deucher@amd.com,
 Dave Airlie <airlied@gmail.com>, christian.koenig@amd.com, joshua@froggi.es
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Simon Ser <contact@emersion.fr>

amdgpu_dm_commit_planes() already sets the flip_immediate flag for
async page-flips. This flag is used to set the UNP_FLIP_CONTROL
register. Thus, no additional change is required to handle async
page-flips with the atomic uAPI.

Signed-off-by: Simon Ser <contact@emersion.fr>
Reviewed-by: André Almeida <andrealmeid@igalia.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
v4: no changes
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 258461826140..7acd73e5004f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3970,7 +3970,6 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 		adev_to_drm(adev)->mode_config.prefer_shadow = 1;
 	/* indicates support for immediate flip */
 	adev_to_drm(adev)->mode_config.async_page_flip = true;
-	adev_to_drm(adev)->mode_config.atomic_async_page_flip_not_supported = true;
 
 	state = kzalloc(sizeof(*state), GFP_KERNEL);
 	if (!state)
-- 
2.41.0

