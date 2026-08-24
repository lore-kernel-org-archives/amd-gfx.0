Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2C7C5DF94
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 15:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD5E510E7E2;
	Mon, 24 Aug 2026 15:22:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sYkHw/l+";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33F0110E564
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 14:47:21 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c167aa9500dso538046366b.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 07:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787582839; x=1788187639; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=F17XSmnVOYujVgQ1/em80W3N+ouVH/hitDNgQftbfbY=;
 b=sYkHw/l+bl+hAw023hY3t3ubWmF0OfP2WuEmtqrlFDtdgWx0TM8PDVrfH62MWspll5
 /8EVRDX24x6/waa2T0meukzES3joJhdsCmvlPZpAMGOPa8ZlpBc8/78B5Af9OvH+XvEi
 vJUEKpdWy5MWqq4MAQsMgCjTON8RMycjwb7lZ6XpHJswjF6Pc/35oBqUCLpmeYimzm4A
 hlB8DdF2wSzrhl+6AgBUWB7TdmNrAj2iAZ+3wuyZilCyFBKHHWufGgCvaWacrRq70hZl
 4VnztRbsz9kv47rU6YykuSxk/Ujhb9aDQl2ZEmAOA9EVupCFTX0d4qwpNzcej5ajQb39
 1Fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787582839; x=1788187639;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F17XSmnVOYujVgQ1/em80W3N+ouVH/hitDNgQftbfbY=;
 b=AcZnBvza7UsJ2pCWXNBORbjZkvB4cuGoxryMKqW/5T8gW1jsGhgXuAwh3D41anXMfk
 psIWgLrD7vN9kEXb2QLA8Eerorx7E9O7UqTlvKiFeL9DiNZ5b/vGnfcw0tZR2Uh1wiR5
 DgwOJ3xUaL4Nn4P2ahHez/DyV2I4sWoO59IT92bTGaW4lMl5Lze2AVAxVcuoZAYFZXSE
 bbCnY8Qz317ItvaNnj5QPajW7YBSksWwOqU4X7mcLQDrQSOqO3TCi0yut1c7kKGB8Bra
 BDW3xAio0FgTRZzFl5fL4ZGwGl0hQ1pYsh3+IWGihD6UvOz7FoF7YlpiXTVvTR/8XV2N
 /xeA==
X-Gm-Message-State: AFuF++ltAJsIwhYzH5ZdZH2XZHa0mfhqtgRiTkowz7LwOzstXvt2IEDA
 nEts8yVQuJPYU87rxc4vmnVKLJaqIOJer5h3K3MU6yfAcKCRdPlRGsp8KYtsd/s9byXA
X-Gm-Gg: AR+sD114+zFNMg4zz2wZgV6gSWE+1KUQK+KZQ3U4iVIgxXQdlfGhdY1YqqjuoHsPlo9
 ekUGuBM2qOXok4SXxbsfIF5IJqR6fsYjYWnYlatbA+vfVuRAsCLNc7y+pwodfIA5oDdekrA+8JU
 Wg01+i5DtYxM8ENOH3m00cQhblKqIwiU8G4f9m3c1bEQZ577QYrFI0Gg/+aPS9f8W0Ff98/Qxy3
 yZu8AwV+rGaTXigRuw+EtVPSxxLKD2I+o2VZGgGmhxM9nezGtlVUyi240JOny1Qco31R9sabmjR
 v7q0xRGSGAHpThTHDrlvPWAOAyluVQjWLyLAkPBnD2vcm6yoxjoJ60I7WbQdSrfjZVqPUgJuIRi
 KmLx8w3MzitTPQGcxYTeHFZuYz4IEHjwtXuHu6LNQzs8MZO3nL2ehc5zzsmDNh0/SXTkiCdX0/g
 JqbRBUoltI5TdCzIV3P16Ei9NCzQ7uLQyrT+1UbJ1ZTZ+cAGv0Y7X4JEWQpv9a4iZ4Vkv2q65+m
 lPhz5RvFB8RREI0aEmzEPDJ1n9L
X-Received: by 2002:a17:906:f049:b0:c16:126b:98b4 with SMTP id
 a640c23a62f3a-c246a2ef584mr2919925466b.3.1787582839325; 
 Mon, 24 Aug 2026 07:47:19 -0700 (PDT)
Received: from Griffon.wikipedia.i2p (adsl-89-217-29-191.adslplus.ch.
 [89.217.29.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24967383e5sm1240049666b.45.2026.08.24.07.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 07:47:18 -0700 (PDT)
From: Petr Belyaev <upcfrost@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, timur.kristof@gmail.com,
 Petr Belyaev <upcfrost@gmail.com>
Subject: [PATCH] drm/amd/pm/smu7: Don't send VddC_Request on CI
Date: Mon, 24 Aug 2026 16:47:14 +0200
Message-ID: <20260824144714.182835-1-upcfrost@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 15:22:53 +0000
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

smu7_upload_dpm_level_enable_mask() calls
smu7_apply_minimum_dce_voltage_request() unconditionally, which sends
PPSMC_MSG_VddC_Request to the SMC. CI SMC firmware does not implement
that message: it is only defined in smu7_ppsmc.h, tonga_ppsmc.h and
fiji_ppsmc.h, and there is no CI equivalent. The SMC therefore never
writes SMC_RESP, PHM_WAIT_FIELD_UNEQUAL() spins until it gives up, and
every call burns the full ~1.9s response timeout.

Nothing downstream notices, because ci_send_msg_to_smc() returns 0
regardless of the outcome. The only effects are the delay and

  amdgpu: failed to send message 15f ret is 0

in dmesg. On a Radeon R7 260X (BONAIRE, 1002:6658) this is 40 messages
per boot: 32 during the boot-time modeset, which becomes ~59s of blank
screen, and 8 more on every DPMS wake, adding ~15s before the display
comes back.

Commit 0138610c1413 ("drm/amd/pm/smu7: Fix SMU7 voltage dependency on
display clock") extended this feature to CI, which the previous
implementation had deliberately excluded -- the old call site was
guarded by pp_table_version == PP_TABLE_V1 with an adjacent comment
reading "TO DO for v0 iceland and Ci". That commit was verified on a
Radeon R9 M380, which is VI, so the CI path went untested.

Restore the PP_TABLE_V1 condition. With it back the failed messages
disappear entirely and both the boot modeset and the monitor wake are
immediate.

Fixes: 0138610c1413 ("drm/amd/pm/smu7: Fix SMU7 voltage dependency on display clock")
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5678
Cc: stable@vger.kernel.org
Signed-off-by: Petr Belyaev <upcfrost@gmail.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 6529a91..aadf6d5 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -3189,7 +3189,11 @@ static int smu7_upload_dpm_level_enable_mask(struct pp_hwmgr *hwmgr)
 {
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 
-	smu7_apply_minimum_dce_voltage_request(hwmgr);
+	/* CI SMC firmware does not implement PPSMC_MSG_VddC_Request, and each
+	 * attempt costs a full SMC response timeout.
+	 */
+	if (hwmgr->pp_table_version == PP_TABLE_V1)
+		smu7_apply_minimum_dce_voltage_request(hwmgr);
 
 	if (!data->sclk_dpm_key_disabled) {
 		if (data->dpm_level_enable_mask.sclk_dpm_enable_mask)
-- 
2.54.0
:wqa
