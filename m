Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83425606A31E
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 19:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h4BL/ERo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A11710E146;
	Mon, 23 Nov 2026 19:21:21 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B021E10EC80
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 19:21:14 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-5c08539c827so2669617e87.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 11:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795461672; x=1796066472; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:subject:from:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DYqA0IGyxaq4ySkL/VS7/YgnBfqbiHcsijXQnkhPIIQ=;
 b=h4BL/ERopw19hWuWlherpMQ+5QUFOD/PoJtSNXSHfBF6Q8V1fzcbXRAD9bObIdbIM9
 tTAB0bSaJd9W5509RM0mw1m9fPwlwgXrh3rv8Y7sp+CWSR8F2SyIAHyibPMjfMFarxU1
 sQ20a7iAnPDo9+cWSy1WcH6crH2JCaWfDuYte5URi3E/N3aJdGhkwDvST2CJYWZzWHc9
 PciKxFtwi+5+YB/h0I+EOJ+Moi2pLeIFk04TcIECtBu2bOfwzw1aHxDplbGyU8o3aoRh
 iuV5n+vRnhvHlzvYxB33wMvHHPXqJ2CFSFK8qVQKYCKJiLo4hi06SWd3b61xtrY6dIFb
 vFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795461672; x=1796066472;
 h=content-transfer-encoding:content-type:subject:from:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DYqA0IGyxaq4ySkL/VS7/YgnBfqbiHcsijXQnkhPIIQ=;
 b=JJX+N88neegE8pbx9WtNN9ln76vJq1MTTC543E1Mf6CJ/m032r6NWkjKT96GT3eE+L
 7m3b5JbcB4hDHzbQccXK4ZtWNRCg+nKG6xof+wXq0yDr3JjSux4ZYsdCC/6lMRaAci8d
 j6Z/urm1GupOwhui6DXzhDv/UPMyjQ2J3kVzpE7l93RdgFX7tG+M3msTw7C4UO3jiz3Z
 UoBKuoyLh6BAsv0QVSIu927xx/MsjSp5ynoNWXmhcS2v3bYxeFmQcDwuYahEMs6qJiRt
 PWU2LEo0oaoJ16erS3kFTTQl7dLTHeYjYX1F91Xhm2Tfio8paM65dAnTCZ3vbcpDaNMY
 AMAw==
X-Gm-Message-State: APuU4Z8Hy1+wVdNQddA6ppVWP/xterKTCDHN1SswOEVNaj6tnXG7gziQ
 zBOpe2Xw8X8s3PPsbmACLyNVJDiNQJKnfoRQru8gd38/soQi7WtEoDQDOqjkVg==
X-Gm-Gg: AZFdTZdtF9psr3oVCpZ8Xxpr5yFggXkAyTM0Ldp5R404jObAVYAA44QQGSKJgbl1YES
 47wCgIYFS27Unaz7lPHyZxfos1HWgg1I3hVDtxNSEDeF0jIFHl/NV188iEWwO8GeN8b/Ugly/nJ
 yJx1CY80jMWSyWdxM2RGdnKG5nd2WIq+06/JDaEJnrIy3k0WTerDUstD8Ms2LSiLvDLLOsoPd4y
 SjqE+Yu0dO/6M+mgCSe8a5bwK9gxLgsq8xWErIckUKb6r/yC6/liL1xYYHdfz+f0fSRjHocVcuq
 aN+Tu18pCAFzrlMzMdR/p+nTR/yq1yxzEkoD4iQslGB8Yi2tFiWnqZ/ISSn5efR+yLMYxz2RK2C
 1sWqDHNDUfNA2LaPhRMU6VzUwqDl2bAeB14WkranS26Tcd15ld/bn+mEwDKhvcITWKsVxlMPvWF
 w5rHi6ly41bTec79dA3WCYvQfnZQSQOQ9wxV7AMIv5Qc98Kvv+nYobJzPvRKGw6X55dVJCvS62b
 rOZHUjhQD6UgisBmHGxHCpQA5X9Nkj4CgOS1M84/WRYt8/X1ACRZ6nKscq92U+E+TMK1J2p81H1
 n/8B6UF48wpAklTpnl0g5n1c4lEOyvtyDzbKTsLFdApQ47ox9+3GhQ46nX96xdH98rS9bUs6xg=
 =
X-Received: by 2002:a05:6512:61aa:b0:5c1:57cd:5c3d with SMTP id
 2adb3069b0e04-5c1bc806a59mr3681994e87.23.1795461672288; 
 Mon, 23 Nov 2026 11:21:12 -0800 (PST)
Received: from [192.168.1.2] (85-253-172-224.ip.elisa.ee. [85.253.172.224])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c1bcf333b1sm3307753e87.5.2026.11.23.11.21.10
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 11:21:10 -0800 (PST)
Message-ID: <27f45723-ea21-4696-9aae-2ecdc47aa37e@gmail.com>
Date: Mon, 23 Nov 2026 21:21:09 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
From: Oleksandr Mikriukov <mikriukov.oleksandr@gmail.com>
Subject: [PATCH] drm/amd/display: Add DP power-up delay quirk for LG
 SMARTGAME+ (32G810SA)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

(Resend: the first attempt was held for moderation because the sender
was not subscribed to the list at that time.)

The LG 32G810SA-WB only starts answering AUX about 2 seconds after
leaving D3.  With the default four 8b/10b link-training attempts
(4 x 50 ms, ~1 s total) the driver gives up while the sink is still
waking, logs "enabling link 1 failed: 15" and the compositor drops the
output; the display then stays black after a DPMS wake until it is
power-cycled on its own panel.

A second stream enable a moment later trains fine, so this is a timing
race against the sink's wake-up latency.  The EDID quirk table already
carries a multi-second delay for another panel, so reuse
dc_panel_patch.dppowerup_delay for this sink.

Reported and diagnosed in:
https://gitlab.freedesktop.org/drm/amd/-/work_items/6193

Signed-off-by: Oleksandr Mikriukov <mikriukov.oleksandr@gmail.com>
---
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -112,2 +112,13 @@
 		break;
+	/* LG SMARTGAME+ (32G810SA-WB): the DP receiver answers AUX only
+	 * ~2 s after leaving D3; with four 8b/10b retries (~1 s) link
+	 * training gives up while the sink is still waking, the
+	 * connector is reported disconnected and the output stays black.
+	 */
+	case drm_edid_encode_panel_id('G', 'S', 'M', 0x77dd):
+		drm_dbg_driver(dev,
+			       "Add 2s DP power-up delay for panel id %X\n",
+			       panel_id);
+		edid_caps->panel_patch.dppowerup_delay = 2000;
+		break;
 	/* Workaround for some monitors which does not work well with FAMS */
