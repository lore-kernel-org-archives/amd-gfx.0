Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A03C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA6522B51
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA6522B51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A940F6E0D0;
	Mon, 11 Jan 2021 19:54:47 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91FAD8975F
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 19:20:00 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id a6so247372wmc.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 11:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lOMcvHupoNOe/LWOcIRzth9mgUcklXf22W184Qe4k/0=;
 b=jINxIN2J/6RKcOAL6kDcJF+Mgaxi1T5CpE5VbihyBJ33bI6YWqCr6mAuwzxGwkhsv5
 FVpFw3s+rEwrmOhwZRHxpQwCVJ6CKW4KhXS9inF7U76wq9C00wDaxmKMxpK5qIBgTkOR
 FAk3+eWlt4HKHYXNAUJOtRX0vXVfoGo8yZ9RjBe0UK1n5NYW1e7fJa1hkrwj1qb4TxaB
 WvJ7fmUEe7ofzUqDXvT+2Ldjcdkr2T2ythHyQPLeHDGT/1ngjh+zs01UCY/eu0y3FWOl
 XyWRj0QAOjh8kxv/klpi4IxXJQ0w3ChZ1znaBUXCwhPw4n1LidqzJ0GXUJR/zctFuNzc
 yIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lOMcvHupoNOe/LWOcIRzth9mgUcklXf22W184Qe4k/0=;
 b=M9gVZoOt6QjW84gKjk8iXzrH9IWhUY9DRsuqYId3SxbO5jWG8GGQvc/Zu+Cnt9dq0D
 qlkbotylIPQFgKKOSP30CqdxECO0+NFbpqw+U219L4e5n5IkP+YhE3/JnlSaSyirQr61
 8ywiOUG6cxYxj4AFwNj818orkCsPk0dIyidehZFoBwHF9Q/BXUHXDHETkuLeYDx2N615
 j5p9TArJfLtQ2j88cFfa1UWJo/ddhQoijusZVwAmJIBA3CGkrNWQqat2C5bxdArpc/gy
 AINlK+VTgj9VspT1Hx44yW/2dF2FOwahEhp0ztc0YC1wezTbjlk5KuyjwxSEuWVaZ7Ti
 DNLg==
X-Gm-Message-State: AOAM530W0Ltg4P0Mw584+xKmfxd/rNX2kBRjE3BihmCaTBBfuhAizlYo
 SeL6WkH1N5p7QIBc/g4L8POmAA==
X-Google-Smtp-Source: ABdhPJzC8kJim0Asdl/jHsMlAY9hTdXgq0nqdS4y/wlPdTiNiOUqq/xEWH3/kje9AOnGdPdj84Nb6Q==
X-Received: by 2002:a05:600c:4ed0:: with SMTP id
 g16mr280323wmq.176.1610392799259; 
 Mon, 11 Jan 2021 11:19:59 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 11:19:58 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 22/40] drm/amd/display/dc/dce110/dce110_hw_sequencer: Demote
 non-conformant kernel-doc header
Date: Mon, 11 Jan 2021 19:19:08 +0000
Message-Id: <20210111191926.3688443-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111191926.3688443-1-lee.jones@linaro.org>
References: <20210111191926.3688443-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 11 Jan 2021 19:54:43 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX2h3X3NlcXVl
bmNlci5jOjE2Mzk6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2RjJyBu
b3QgZGVzY3JpYmVkIGluICdkY2UxMTBfZW5hYmxlX2FjY2VsZXJhdGVkX21vZGUnCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZTExMC9kY2UxMTBfaHdfc2VxdWVu
Y2VyLmM6MTYzOTogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnY29udGV4
dCcgbm90IGRlc2NyaWJlZCBpbiAnZGNlMTEwX2VuYWJsZV9hY2NlbGVyYXRlZF9tb2RlJwoKQ2M6
IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpDYzogTGVvIExpIDxzdW5w
ZW5nLmxpQGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6
IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmll
bEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpv
bmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTEx
MC9kY2UxMTBfaHdfc2VxdWVuY2VyLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZGNlMTEwL2RjZTExMF9od19zZXF1ZW5jZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX2h3X3NlcXVlbmNlci5jCmluZGV4IDRjMjMwZjFk
ZTlhMzAuLmM1NzQwNWZhNGJlYmMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kY2UxMTAvZGNlMTEwX2h3X3NlcXVlbmNlci5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX2h3X3NlcXVlbmNlci5jCkBAIC0xNjI4LDcg
KzE2MjgsNyBAQCBzdGF0aWMgc3RydWN0IGRjX2xpbmsgKmdldF9lZHBfbGlua193aXRoX3Npbmso
CiAJcmV0dXJuIGxpbms7CiB9CiAKLS8qKgorLyoKICAqIFdoZW4gQVNJQyBnb2VzIGZyb20gVkJJ
T1MvVkdBIG1vZGUgdG8gZHJpdmVyL2FjY2VsZXJhdGVkIG1vZGUgd2UgbmVlZDoKICAqICAxLiBQ
b3dlciBkb3duIGFsbCBEQyBIVyBibG9ja3MKICAqICAyLiBEaXNhYmxlIFZHQSBlbmdpbmUgb24g
YWxsIGNvbnRyb2xsZXJzCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
