Return-Path: <SRS0=xwQz=A3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A1EC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 361C720787
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FageieCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361C720787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8DB86EC76;
	Thu, 16 Jul 2020 21:23:09 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E488B6E069
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:08 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id z2so8667308wrp.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=N0TtJ4dwuNmMMy25kcvRl6z8tUWJFcPi5FQEZvtRpBc=;
 b=FageieCrzu/AJKurYg3l3XB88JedAka0jQRTmAGjRPd33PTgCeEFTGkYP9fP3hNVBK
 /FN1Z7eSpL/urkGSQML53efPhc73dOO/qpmc1eTRcu5kTsSfrRHjAkbrspvC45fKKsy8
 XYvPWjnCbeHmEbu94jU+emvWDSwKMmZUgcRx4iGURFd2ZnPcOWGru7mHnXxFJokuV7lO
 VBq4jo4eMFV9Nmb7DRlIMWFALUi/+xrd5xzMvhIaC/TUZHBF+avr2hMynQeo/rSnoaeR
 hs15xq1ryydL20iu5D1GMbYuPWk9uc8OgkSt3d2EQ6TCO9dNz1XNrdtYbSToHnrWrZdw
 bl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=N0TtJ4dwuNmMMy25kcvRl6z8tUWJFcPi5FQEZvtRpBc=;
 b=jncN1TCAs9jFs9d7i2zRBCnq7I+Fb/Kma6IkbhvUSou4oU0JwVg0M4hU2VBVxQouJ/
 mm2JJgpebVE43d/slws+32xfsTzzskNUNN08bAqAXzd0w8TedAhCE+6erAgen3T66MBg
 cX7D7B3A7RML3CYT3A44JLNCVZmQ+upRWYuQqC8y4uI+2SpM6/6ntYvSHkPxOLZleE0e
 /PiRDEwbj0xX3cGYlX9BAvXHH9VOwDnOEFx38z9/x2zrtPRp9kJhh/lRogzpezFHA//v
 5PsKG6fAoUdaTP31vC19CQPLNqR6qoYoLFsuGxfAj0/mGRAqIE0tb3kZ6fA7V0NyKRXO
 IDbg==
X-Gm-Message-State: AOAM532OyXeY2WF3G+z3sCaT2HF/ecPth1YFVeJf9poCpRMl7m92N8WG
 qFWYP8KF/Y2q+02DM4esEvCJ4sdBep0=
X-Google-Smtp-Source: ABdhPJyLzZoBqgPOZ+sO0GcDbPi6ZrfA1aAJ8MW7W1Fxhfal629zNlpmNcdp+jMvHrtbYGPzsLpTEw==
X-Received: by 2002:adf:ef4d:: with SMTP id c13mr6679536wrp.315.1594934586899; 
 Thu, 16 Jul 2020 14:23:06 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:04 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: 
Date: Thu, 16 Jul 2020 23:22:24 +0200
Message-Id: <20200716212251.1539094-1-issor.oruam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, Mauro Rossi <issor.oruam@gmail.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The series adds SI support to AMD DC

Changelog:

[RFC]
Preliminar Proof Of Concept, with DCE8 headers still used in dce60_resources.c

[PATCH v2]
Rebase on amd-staging-drm-next dated 17-Oct-2018

[PATCH v3]
Add support for DCE6 specific headers,
ad hoc DCE6 macros, funtions and fixes,
rebase on current amd-staging-drm-next


Commits [01/27]..[08/27] SI support added in various DC components

[PATCH v3 01/27] drm/amdgpu: add some required DCE6 registers (v6)
[PATCH v3 02/27] drm/amd/display: add asics info for SI parts
[PATCH v3 03/27] drm/amd/display: dc/dce: add initial DCE6 support (v9b)
[PATCH v3 04/27] drm/amd/display: dc/core: add SI/DCE6 support (v2)
[PATCH v3 05/27] drm/amd/display: dc/bios: add support for DCE6
[PATCH v3 06/27] drm/amd/display: dc/gpio: add support for DCE6 (v2)
[PATCH v3 07/27] drm/amd/display: dc/irq: add support for DCE6 (v4)
[PATCH v3 08/27] drm/amd/display: amdgpu_dm: add SI support (v4)

Commits [09/27]..[24/27] DCE6 specific code adaptions

[PATCH v3 09/27] drm/amd/display: dc/clk_mgr: add support for SI parts (v2)
[PATCH v3 10/27] drm/amd/display: dc/dce60: set max_cursor_size to 64
[PATCH v3 11/27] drm/amd/display: dce_audio: add DCE6 specific macros,functions
[PATCH v3 12/27] drm/amd/display: dce_dmcu: add DCE6 specific macros
[PATCH v3 13/27] drm/amd/display: dce_hwseq: add DCE6 specific macros,functions
[PATCH v3 14/27] drm/amd/display: dce_ipp: add DCE6 specific macros,functions
[PATCH v3 15/27] drm/amd/display: dce_link_encoder: add DCE6 specific macros,functions
[PATCH v3 16/27] drm/amd/display: dce_mem_input: add DCE6 specific macros,functions
[PATCH v3 17/27] drm/amd/display: dce_opp: add DCE6 specific macros,functions
[PATCH v3 18/27] drm/amd/display: dce_transform: add DCE6 specific macros,functions
[PATCH v3 19/27] drm/amdgpu: add some required DCE6 registers (v7)
[PATCH v3 20/27] drm/amd/display: dce_transform: DCE6 Scaling Horizontal Filter Init
[PATCH v3 21/27] drm/amd/display: dce60_hw_sequencer: add DCE6 macros,functions
[PATCH v3 22/27] drm/amd/display: dce60_hw_sequencer: add DCE6 specific .cursor_lock
[PATCH v3 23/27] drm/amd/display: dce60_timing_generator: add DCE6 specific functions
[PATCH v3 24/27] drm/amd/display: dc/dce60: use DCE6 headers (v6)


Commits [25/27]..[27/27] SI support final enablements

[PATCH v3 25/27] drm/amd/display: create plane rotation property for Bonarie and later
[PATCH v3 26/27] drm/amdgpu: enable DC support for SI parts (v2)
[PATCH v3 27/27] drm/amd/display: enable SI support in the Kconfig (v2)


Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
