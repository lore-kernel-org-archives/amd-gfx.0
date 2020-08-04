Return-Path: <SRS0=+8vs=BO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E069C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 20:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB44B22B42
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 20:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KD3U4/FA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB44B22B42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66A206E2E3;
	Tue,  4 Aug 2020 20:08:48 +0000 (UTC)
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com
 [IPv6:2a00:1450:4864:20::244])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FFF589E52;
 Tue,  4 Aug 2020 20:07:08 +0000 (UTC)
Received: by mail-lj1-x244.google.com with SMTP id w25so9585075ljo.12;
 Tue, 04 Aug 2020 13:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3azTrGP+LhHvSC09M4k8Vw28GxxV8PL/Fmjx/psKnVE=;
 b=KD3U4/FABUKWR1juhGbVRQ1Y/MC22u+FfGKWnvS2okLXEIMhyY8rJYmqIWpChTclgK
 odWpgxAEob6xjlmB8BrGY+z5JzGAt4USWspVBigQLML5OEhzjUpFl/uH8M3gZ1+xE9qE
 HTsT3dAeJMYYrq2dqC4Ucq0DxpwzlZZUhLzp+0L4fmP5RLUjGR+sYsMPwAXiNbFoNK7V
 1jBmby/vCggXOMFr5DilaagPTwqRsvRpQ0M/YhcxaMxRPaxU4qu705/FOo16JVV98CKv
 +Hncxu27XUQ5LRoaAy8NDMQ/73OgqbafNmuXJe8LKUG3QU4bB2p3IE1kqSlbITTpu1fG
 g/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3azTrGP+LhHvSC09M4k8Vw28GxxV8PL/Fmjx/psKnVE=;
 b=DgVuLvWJfjL5AaZKXHE+H0bGAVkSlMN87SMwHiqYj8YfxzwX9wFsIW1Js5HHbT8yFL
 dlfTl4WIaxgnP7+SuSnyqqTThpfoFRm10f91v2CbDIO6dT9DciUHEn/9F/LVQVkMehtW
 OuaiyTPAS8fesuXxhlU9pxMq9/Gv5eCHzpjwqcZV4dHQ6kzn7fop832fuPm9TA9yFy62
 BnoxRwpREWu60UCWAz3Ng7cyaM5gGEcj8DeU9T5X/nt9QIVVpWeG5NgJ9GQTpfDNsLEZ
 splZP2VVyDzwNWw9rzKTVkKvDte1nFdxVWzehz24fYi0jn4OgyA7lfmegRM+VAJ/C4aM
 qnag==
X-Gm-Message-State: AOAM530ZZNLE0WqtlYi7QCIYfddDgUic7eAPaInggmvirlEz3V5mtjLE
 AMIXQPDM/PcgsPwzY/HebvM=
X-Google-Smtp-Source: ABdhPJy3AsPNQaIKiToyk18pBgh3WPFP2MudjbtbKX6Ce/AOCPL8HID0YU1jQ5OnAZqwhLBdXlUuog==
X-Received: by 2002:a2e:8197:: with SMTP id e23mr11882263ljg.406.1596571625718; 
 Tue, 04 Aug 2020 13:07:05 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se.
 [82.196.111.59])
 by smtp.gmail.com with ESMTPSA id g21sm3080020ljh.103.2020.08.04.13.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 13:07:05 -0700 (PDT)
From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com
Subject: [PATCH 0/3] drm/amd/display: Constify static resource_funcs
Date: Tue,  4 Aug 2020 22:06:52 +0200
Message-Id: <20200804200655.30495-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 04 Aug 2020 20:08:47 +0000
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
Cc: amd-gfx@lists.freedesktop.org, airlied@linux.ie,
 linux-kernel@vger.kernel.org, Rikard Falkeborn <rikard.falkeborn@gmail.com>,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Constify a couple of instances of resource_funcs that are never
modified to allow the compiler to put it in read-only memory.

The other drivers in drivers/gpu/drm/amd/display/dc already have
these as const.

Rikard Falkeborn (3):
  drm/amd/display: Constify dcn20_res_pool_funcs
  drm/amd/display: Constify dcn21_res_pool_funcs
  drm/amd/display: Constify dcn30_res_pool_funcs

 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
