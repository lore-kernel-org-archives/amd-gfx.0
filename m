Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EA8C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 12:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3540561248
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 12:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3540561248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDB8089CD7;
	Tue, 24 Aug 2021 12:08:18 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EA4B89C9D;
 Tue, 24 Aug 2021 05:52:41 +0000 (UTC)
Received: by mail-qt1-x834.google.com with SMTP id r21so15834450qtw.11;
 Mon, 23 Aug 2021 22:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aKoGOwtJBCz+YXwcucsOTN0b2bJIHpImilJMkwC9Tbs=;
 b=gLenX77aB/Q5UkP2JB1FOsPKOnSyJci46eOvlG69RwyJUXdA4oDt2TV10t3e9DgZKo
 BZfSfunPQI3TdPoDdp/XwTahlPEweI3EhSaYxY/SrPj8FmHF7SaOkx0ZhPZUR4YF6XPS
 JckTo3V0cFVN+PJYZ5Rudf8rXm2mHv1Yr9ZrNcXP7mNhOr0s19FMkqN2oCn28770nTqL
 yhd3pE0619o6R/ss2u9F94a0pjwO5SSFJs7icsWDiOamsPAzb/MygWPe9apghN/5s1PR
 uD0iiBgrADIKvCcrwhDQGBdlM8SRKGP+gJeZWp7DpkDCb1HQqfZtczXUxOB0kFe4Lezn
 zIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aKoGOwtJBCz+YXwcucsOTN0b2bJIHpImilJMkwC9Tbs=;
 b=FBv2W2xRQ5ZVvrO+8StBTh7h55knHrJ5+QELj0vftytKpqn41M241AJ3F58jHN4Xl0
 QhgWfd1wCBzmspf0/tmqjLxlD6tGUlmoZkvo7CoPY/t4OizOt/zrZLHxCvePkMQ44FhK
 ocMlKiJIW9FZHKRK56wCn0I3PwFa7xZNG/NoJKQWM4asHzzIkJeInFCXlmfTkH3Vw1Nm
 Vul+4Z5IPAwZuQD9p6ZeCzBgeLXQI2qnlUn67vNcHZJ9Mgnpu0tjSHCx21LOGBFijsFN
 3EWZwHirX5LEKXouaVmlYwqNpup5xOBrlU2TLyadyOpsvXFlzox1cH2XIkChkaNBijTx
 2rHA==
X-Gm-Message-State: AOAM530S0VC9cPVPX16PPphfJYSjqE8x/YGcVaGh0+qFXnceGrbL0Jd7
 s5w+d8xpOV32gLCrNkkshsc=
X-Google-Smtp-Source: ABdhPJwz05f+97PVxCqzt36XAuiK21Zd/o+zJB6NYu+02s36L/9A3Kr2jilB6keyjKCm4ifHeeEOFQ==
X-Received: by 2002:ac8:46cd:: with SMTP id h13mr33116824qto.369.1629784360771; 
 Mon, 23 Aug 2021 22:52:40 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
 by smtp.gmail.com with ESMTPSA id u22sm10141603qkj.123.2021.08.23.22.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Aug 2021 22:52:40 -0700 (PDT)
From: CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <deng.changcheng@zte.com.cn>
To: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@linux.ie>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jing Yangyang <jing.yangyang@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm:dcn31: fix boolreturn.cocci warnings
Date: Mon, 23 Aug 2021 22:52:32 -0700
Message-Id: <20210824055232.58653-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Aug 2021 12:08:17 +0000
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

From: Jing Yangyang <jing.yangyang@zte.com.cn>

./drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c:112:9-10:WARNING:
return of 0/1 in function 'dcn31_is_panel_backlight_on'
with return type bool

./drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c:122:9-10:WARNING:
return of 0/1 in function 'dcn31_is_panel_powered_on'
with return type bool

Return statements in functions returning bool should use true/false
instead of 1/0.

Generated by: scripts/coccinelle/misc/boolreturn.cocci

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yangyang <jing.yangyang@zte.com.cn>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
index 7db268d..3b37213 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
@@ -109,7 +109,7 @@ bool dcn31_is_panel_backlight_on(struct panel_cntl *panel_cntl)
 	union dmub_rb_cmd cmd;
 
 	if (!dcn31_query_backlight_info(panel_cntl, &cmd))
-		return 0;
+		return false;
 
 	return cmd.panel_cntl.data.is_backlight_on;
 }
@@ -119,7 +119,7 @@ bool dcn31_is_panel_powered_on(struct panel_cntl *panel_cntl)
 	union dmub_rb_cmd cmd;
 
 	if (!dcn31_query_backlight_info(panel_cntl, &cmd))
-		return 0;
+		return false;
 
 	return cmd.panel_cntl.data.is_powered_on;
 }
-- 
1.8.3.1


