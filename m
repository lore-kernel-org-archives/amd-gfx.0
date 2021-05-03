Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65B8C433B4
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 07:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4742A61221
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 07:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4742A61221
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89F096E87C;
	Mon,  3 May 2021 07:35:14 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F0536E86F
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 May 2021 05:06:13 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 j6-20020a17090adc86b02900cbfe6f2c96so2648169pjv.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 02 May 2021 22:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=E/FKJGJCQ2WFjnbO5YcetVVfi3vvMJqoARGeLl89eC8=;
 b=lh4za3xaTooJfbOeXMng1u3MjSxWc2HhVsNObUs5jj06JlvMqZu/IWYTVsv7WRr8Yq
 +RD6LF67WLbpj674PvIqT1c+mm/V/E9Y6qS42OeH3AGU8J9qCH45dPp4UrrKawDocPCT
 TLlIKznAvXBe2BdyTkRGmnyhLxR8OoTvpJe8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=E/FKJGJCQ2WFjnbO5YcetVVfi3vvMJqoARGeLl89eC8=;
 b=iXurfgTRui/6KSEeWdEyV2p1FWclvTd31fM3a1lOopckK+IR7YKGPfHCy1+sJN3kLm
 sh5Dakx6GE5Fkyr19iXwH11L0eU+ly18vn1Dm86a+CA+v7y8b06L1Vt/S+f0uK6jMB+b
 I7QCZKeOOtV4QShQmivWgT7DjNdZC6czFu6sTu62E/7uzTda23DW5omYNWJSPb0CMaD2
 QVuFvELawulyr8Fl+zvye/X0LzPG4RySAqF3z3Yd99//yqBG1lFamnnBY9aKxe1qPedK
 xBo/hgh/9mSLzBFhI1lPIKrafn68ZYN2AkyTvyy/iM16VqZOqqTvLXSt/GjilvjynE2f
 Mphw==
X-Gm-Message-State: AOAM530dTtADLE4GAbauoRuGGPFXBbHumIVaZhMJAi2VMJCb9iny40rV
 /35Dj97JNzhpWVmNpFg9vgvjrg==
X-Google-Smtp-Source: ABdhPJzK7f9E96uhGaYj9Z8XDC4clhUq0a6o0CReg/QOI2eaar9BmY6biZNhpeflByLUdzTTvNXTMg==
X-Received: by 2002:a17:902:a58b:b029:ee:d13a:2642 with SMTP id
 az11-20020a170902a58bb02900eed13a2642mr5016303plb.35.1620018373006; 
 Sun, 02 May 2021 22:06:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id q128sm7743860pfb.67.2021.05.02.22.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 May 2021 22:06:11 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/2] drm/radeon: Fix off-by-one power_state index heap
 overwrite
Date: Sun,  2 May 2021 22:06:06 -0700
Message-Id: <20210503050608.2158996-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 03 May 2021 07:35:12 +0000
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
Cc: "Erhard F." <erhard_f@mailbox.org>, Kees Cook <keescook@chromium.org>,
 David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

This is an attempt at fixing a bug[1] uncovered by the relocation of
the slab freelist pointer offset, as well as some related clean-ups.

I don't have hardware to do runtime testing, but it builds. ;)

-Kees

[1] https://bugzilla.kernel.org/show_bug.cgi?id=211537

Kees Cook (2):
  drm/radeon: Fix off-by-one power_state index heap overwrite
  drm/radeon: Avoid power table parsing memory leaks

 drivers/gpu/drm/radeon/radeon_atombios.c | 26 ++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
