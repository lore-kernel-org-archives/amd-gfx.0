Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D42C88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 07:32:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4297710FA46;
	Tue, 15 Sep 2026 07:32:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aMvznSet";
	dkim-atps=neutral
Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com
 [74.125.230.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3183B10E22E
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 02:27:51 +0000 (UTC)
Received: by mail-lr2-f12.google.com with SMTP id
 38308e7fff4ca-3a2ff16c0e6so21977101fa.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 19:27:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789439269; cv=none;
 d=google.com; s=arc-20260327;
 b=LHgIX37B+LMdS65As8D0OJ7Hs8q0+EmNJgLngXn/CogZJgu9IjouF8LSKTgOQkcqMo
 aCACQ4v2nMZxpo2LM7gCPFcqoZwEFLKZGs7WtySPZpAKUp+QsPiibBrcBBvgZ6LpG3ZT
 q30CUmyGalExqQ+qRT2ZnSinHMQK4fyKFv1MTf/pcwkNrsgOSxxNVLBqKYS1RDksOvXZ
 5EznGb0F1qWXRRG3WJxl8V+FSXxqpeqHV5qm+eOBqJn1UqnZMY1daIanEkaGGFJi8C7W
 7lQZIfETOBR9UqB0Ksl2qF8BuKYKM/HVWbxZUaS0I7mO5BoT8JlQfYu9cVzmXmWG5Ekr
 xMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=J15/iUq4hwNLgoAFGv+hkuhgPnyH2Vrei6Sk5/otKgo=;
 fh=dbdF1tduEkK+FHg6WKGlZsI+kQWlCSP3K2c/GVbHDAA=;
 b=L4xwrwq8hmTAT0zCwgIE+c23ARg/bhJk02IIuw5Y7CUlXHuU5v7js1+IOCRahNJYji
 eCBvj7PmZrRBQnsCUBX6sqKo5u51IC3tXc8z/k66IvpW62lPtMe1LlZdGsna6BXWBojI
 p+itnFYLYiWkRggUJvhZwLVbEQ/dC5WT4txwxvrg33Bg5BVnkQ7kZo9+CSo1vDcfo/he
 f+x7+eoImAmXKce433FIF3cfjol9QPLvJegu1sCbQ6ar3aixkwaKrSn8LomPfXxA8RP7
 QiWsFLV2Fe6SFh68m3IwlnPT6vkQQwr6urrZfVXdP2+YAOdxHrTI8uwSNtlN6UWIqtDd
 S8iw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789439269; x=1790044069; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=J15/iUq4hwNLgoAFGv+hkuhgPnyH2Vrei6Sk5/otKgo=;
 b=aMvznSetAlW9NyP7S2D+/Y6LPFX3l+8XSjqJoIgJQukFVEIj4VQBk2ouoWv/HtVX7j
 EDYm2P9I3MtLFsCNAFJhxwyvC5qYL5u5fGOi2739M/3SWnZoFgByabk17uOKB9goWH3r
 Q41gH9M8wyfyY73P0jj1/XWB7Nxe1lftixuNsjwBs0Jq/4+N17FGzIohousgr/fkNmjs
 TubaqRrPUTh/iFEe4cu2wdM7yax+48FIp477hvV35X22WGl/EXMHPzasV7Xidg4jfDj0
 yjbPe84sHWdgbF4sC4sZBC6+fjiPO7Po2pwCjwDwG7Hh1sSKDHF9u0yEdxKW7PgAPqho
 RQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789439269; x=1790044069;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=J15/iUq4hwNLgoAFGv+hkuhgPnyH2Vrei6Sk5/otKgo=;
 b=d8tiRJdO228XX9IwFLG8D2tMKKbvz6zg5ZUMyXTptnePAZEl5LpS9jONgnTYc9uM+W
 jy+LDhm0FFaLvHsaoq5+dYE8dlSFU5P0zIabt0wex2arULtb4R/eKXmaHrrYE9eOAZc7
 kNZfOgY1H2GIgHa+oT2QsFbMjiOzGpCBweeEOqLEt7HBjdIp/tKLCebOopwWtaeKlUk8
 XMYLOYLTYbHpIj++T1HbiAWMCb2LRiV2/y0/bmNixQa2y7kEOiVzhaZ0TwCQ1rcb71xL
 ELhNfNXPmSc7qFpS7b4WQtEYZdaQ+XYGRm73s+pbSqEeDP3epRHbAUAhGG1zbUN2k2n5
 2bPg==
X-Gm-Message-State: AFuF++mPuyJQKYMEFiij4q0XHiznomXoRkdf2ejB+Drk4sn7m7/HcE7G
 vvPn7tyJWR+pr1YXgwD/MUp2+S3BYQj7VhqXIVRtzv62wLJ9FTc4rHdzjD/ASd6IeYmGK7FCymw
 oDSlMcQe6Wphteqod0MnvS28ZJdwEu84=
X-Gm-Gg: AYBFou2vMvkGBoK7TXvKSsSiGTZHRn5CnVvWpJ733lmRgVvcbFr5uWAAg3SK3XXVKq+
 Bm973Rc58nH0ophy+EOOc7YjYdoHR4Hyyp5NhqqkHO2RL2G60s8l2f2eru7f/gyuvnpTiOX6CUb
 wwh0O4J/RnAcXkVs2E7jXI4nJPnr9wQPRa5/ThFbb5J2aD9mlZ/6k+KsLB9bUaB7132HJ1GqVdu
 5kxsYjeBLJCS3nU677dajGRGysvhGxT+Aczf4eysB8OJWhm6djREk+gRx7AZNDm+P/Q1RU/jyrK
 y05YHV11nThb6oRxX9bpKokNmo4bGsP+O89so+3AXpjsbda06PlLW9W8rRu2lSoceBF875otVA7
 17oI0kBshiKymh47I65Y7ZQ==
X-Received: by 2002:a05:651c:552:b0:3a3:74b7:fc0e with SMTP id
 38308e7fff4ca-3a5c899c408mr7848431fa.26.1789439268807; Mon, 14 Sep 2026
 19:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAJxfpZ+AzJnBCw-jP5_E8FH_+cpCE68FCtf_tsi9pt7q=P2Dsw@mail.gmail.com>
 <20195022-cf18-45cd-829e-b2866e7a3080@amd.com>
In-Reply-To: <20195022-cf18-45cd-829e-b2866e7a3080@amd.com>
From: Dan Himebauch <danielhimebauch@gmail.com>
Date: Mon, 14 Sep 2026 22:27:35 -0400
X-Gm-Features: AcwNN1Ugx9kcCV2VjGKc2mgeTlJvZfaWap9VfMR_r6vEKfUTuZChjFWCy53hf9g
Message-ID: <CAJxfpZJDvFuz40a-euL0jRkPBR82M8Y5NxBrpABeP+EZScFxGw@mail.gmail.com>
Subject: [PATCH v2] drm/amd/display: invalidate DP CEC state on s3 suspend
To: Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com, sunpeng.li@amd.com, 
 siqueira@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com, 
 airlied@gmail.com, simona@ffwll.ch, bhawanpreet.lakha@amd.com, 
 wayne.lin@amd.com, george.zhang@amd.com, jerry.zuo@amd.com, 
 chen-yu.chen@amd.com, ivan.lipski@amd.com, evg28bur@yandex.ru, 
 Kun.Liu2@amd.com, mario.limonciello@amd.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 15 Sep 2026 07:32:47 +0000
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

Amended and added issue link, thanks!

From 2916fc883b80cf106ba2b06d8dadbdae45eff7db Mon Sep 17 00:00:00 2001
From: Daniel Kurt Himebauch <danielhimebauch@gmail.com>
Date: Fri, 11 Sep 2026 21:11:10 -0400
Subject: [PATCH v2] drm/amd/display: invalidate DP CEC state on s3 suspend

Some Linux HTPCs with discrete GPUs use active DisplayPort-to-HDMI
adapters to carry CEC over DP AUX. This provides a CEC path on systems
where the GPU does not expose native HDMI CEC.

During S3 suspend, amdgpu invalidates native HDMI CEC state but leaves
the DP AUX CEC physical address valid. The adapter can retain stale CEC
state across suspend, causing transmissions during resume to fail before
the adapter is reconfigured.

For AUX-mode connectors, invalidate the DP AUX CEC physical address
during suspend. Normal connector detection on resume then reattaches the
adapter using the EDID-derived physical address.

Tested on a Radeon RX 9070 XT HTPC running SteamOS with a UGREEN
DP-to-HDMI adapter on amd-staging-drm-next at commit d8ab7636160e
("drm/amd/amdgpu: remove duplicated code in gfx_v11 and gfx_v12").
The unmodified tree reproduced resume NACKs. With this change, multiple
cycles showed Image View On and Active Source transmissions.

Link: https://gitlab.steamos.cloud/holo/linux-cec/-/issues/5
Assisted-by: Codex:GPT-5.6-Luna
Signed-off-by: Daniel Kurt Himebauch <danielhimebauch@gmail.com>

---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 0b446133edd8..919394778a25 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -372,10 +372,13 @@ void amdgpu_dm_s3_handle_hdmi_cec(struct
drm_device *ddev, bool suspend)
  continue;

  aconnector = to_amdgpu_dm_connector(connector);
- if (suspend)
+ if (suspend) {
  hdmi_cec_unset_edid(aconnector);
- else
+ if (aconnector->dc_link && aconnector->dc_link->aux_mode)
+ drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
+ } else {
  amdgpu_dm_hdmi_cec_set_edid(aconnector);
+ }
  }
  drm_connector_list_iter_end(&conn_iter);
 }
-- 
2.50.1 (Apple Git-155)
