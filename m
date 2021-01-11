Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7FCC43381
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2546F22B51
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2546F22B51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E88A6E113;
	Mon, 11 Jan 2021 19:54:49 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5660B89E05
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 19:19:43 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id w5so892768wrm.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 11:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UcsXd93K7BxPfLMZix7N1m2GKT2azGUOXW7pu1fAJ6Q=;
 b=ZgN070xj9zEPxR6Eju8xm/BGEJNz26qAu8AK4hz5kXNIOjqsQxjUOJqZ4iQ7ohXe6P
 bmOVqJpchg0VBixwo6iK1krjte9+L1Afe75VVKj8jbMEDib/VMRKbvNvdmJxJkH2g8/6
 iwod8WTWIKRUyQbScNhoFkgfi7OPMNWCymJ+arxVjLaP8grMv96/ZLuyiflsT+b20Q30
 NTKQsNA0WpV1M6zAsBxspLjTpqdatanlXZJYFC2nQWTNPOjPHBf6+Fm9NCw8cIocOCHe
 kJBjojkgFDNH2+DGSSjAgMTKyWIborbM1NB5Srr8x6osaizYXvHLlU7A1ucFe1eiWRWb
 ykJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UcsXd93K7BxPfLMZix7N1m2GKT2azGUOXW7pu1fAJ6Q=;
 b=KR1W9ounQIaTdyjdNHP67P4owndrV2qT3sVsYD0Aj1F0Gcu63ypK6SLn3RkJBp7NN7
 k/zJrSIbNuti5KYwtWjzTN/dc0gvAJ2djOnC3yPp6JvwRcETq2MBci1pxkvSk2PYsQgX
 EB3CqvPfbem0hTfgnj8PyPKcwI4lwda6os4uEW/HsOkpFd3BSYxwQETet3lbCeumSXgh
 Hm+xkEor1xmePV7mB3+DjB87bqQrtEZ6Y9YY7iXvrdhHq/SqoZB2ynyYWxMg6n8YJ2vs
 U/YSB0GDYrWJTy77fpACcJW6x3ex+gzBogM+WdD5SOLa84fd5BcHOZFxd78OCBGNSVjx
 bc7g==
X-Gm-Message-State: AOAM533T/GPfbcOs/YghHfyPnh6GhVtov7yt1BJ493FaLrGB4sx1MK04
 S25clG66uRBRRNGd7NG3SA26aw==
X-Google-Smtp-Source: ABdhPJy5wbRWhf0qduM/ZnCT/0hOR9xgNX/ehbryzeIZj8Uyts1DMTt3SiRFvp6CxAUQd1iERwcZYQ==
X-Received: by 2002:adf:f344:: with SMTP id e4mr593240wrp.25.1610392782031;
 Mon, 11 Jan 2021 11:19:42 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 11:19:41 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 09/40] drm/amd/display/dc/gpio/diagnostics/hw_factory_diag:
 Include our own header containing prototypes
Date: Mon, 11 Jan 2021 19:18:55 +0000
Message-Id: <20210111191926.3688443-10-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9ncGlvL2RpYWdub3N0aWNzL2h3X2Zh
Y3RvcnlfZGlhZy5jOjUwOjY6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCY
ZGFsX2h3X2ZhY3RvcnlfZGlhZ19mcGdhX2luaXTigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQoK
Q2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpDYzogTGVvIExpIDxz
dW5wZW5nLmxpQGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
Q2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRh
bmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVl
LmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZ3Bpby9k
aWFnbm9zdGljcy9od19mYWN0b3J5X2RpYWcuYyAgICB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2dwaW8vZGlhZ25vc3RpY3MvaHdfZmFjdG9yeV9kaWFnLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZ3Bpby9kaWFnbm9zdGljcy9od19mYWN0b3J5X2RpYWcuYwppbmRleCBkZjY4
NDMwYWViMGMyLi5jNmUyOGY2YmYxYTI3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZ3Bpby9kaWFnbm9zdGljcy9od19mYWN0b3J5X2RpYWcuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZ3Bpby9kaWFnbm9zdGljcy9od19mYWN0b3J5X2Rp
YWcuYwpAQCAtMjgsNiArMjgsNyBAQAogICovCiAKICNpbmNsdWRlICJkbV9zZXJ2aWNlcy5oIgor
I2luY2x1ZGUgImh3X2ZhY3RvcnlfZGlhZy5oIgogI2luY2x1ZGUgImluY2x1ZGUvZ3Bpb190eXBl
cy5oIgogI2luY2x1ZGUgIi4uL2h3X2ZhY3RvcnkuaCIKIAotLSAKMi4yNS4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
