Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAB1C63777
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8B6F20674
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XxZ37GB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B6F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF97C6EB7E;
	Fri, 27 Nov 2020 10:15:06 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BBF36E994
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 13:43:42 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id k14so2216271wrn.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 05:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VB1b8+HX0cMDaWmJBmE+LGhIQvSkQPR66e8ggHq+N+Q=;
 b=XxZ37GB0KpmVxrU9vwF7H6yWe5kLeflzs8gZYUkJvmzO75EMKFpjikfiFkRATr+PYk
 xVJsFJ8MlCX7JEFQF5EH+wxZjeAR6AAKMAUe6A4slFX4FgCiHh2yM5zwqB353KB4oqIw
 X+P/pOW+yAy8nskR5vatXd4YkKtooeYl/csb9hoaemLg2DfJWcDczneVuo4zN74yPihy
 YHY5rS7Y3S7UxJ3B0lUy5sQuezOiOmNeiqulnV8BrL0UbUNcXRnXgAOPNUM02JooqAMz
 /LCvBZB7hD1p2fkaY3JKLbaUoBbRbDEC124el020n/q/0Ochw15abcX9sdoU+nZTOqos
 6Czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VB1b8+HX0cMDaWmJBmE+LGhIQvSkQPR66e8ggHq+N+Q=;
 b=h5cp3rB0mbMe12EDiXvwmCr1mvXOj1fMq/kxy/G4/E0jSzwAX7h80NRRhtH81gRGQI
 yzImD+Q11uSM3phoa2/e5e+mKRAt8VMtLccQjOaEDurbODiCkOE0GLcM4rGv8j+jpY5F
 SRDn97FfMB5wvuuPVFKGVzwCNwoEsL8+BxqN4hatFU9W3Uuem+/5kn0RC7S93RQ7VIoa
 YcmRXmkKOdl/WxjgCoc3RlLC2UbxKIvPlcx8yWrHA8tW2/R5/ygflGV6hzaiBoMYZ9uh
 I1xesaOmG36uPlN7ESWGPovWWb3grjmxKN5ICGN+asWUZfZ3LFYAINxxKJLN8pU2ldZk
 s0VA==
X-Gm-Message-State: AOAM531y8bTQNsgUBUQMg6i2aCZd0aT9rC95GdSJrypXCS07As45I9KF
 RgF/jLn6Fzu9XPO5No2Hc1b2Wuo6lZkUg4YF
X-Google-Smtp-Source: ABdhPJwVfHcERYxVhmR4rmdwSIAsofDYdoAklfqWn1euwhxJfD6gxAJllgiYzUpJtVkfnBP6hYWcyQ==
X-Received: by 2002:a5d:4408:: with SMTP id z8mr4115578wrq.204.1606398220768; 
 Thu, 26 Nov 2020 05:43:40 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 05:43:40 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 38/40] drm/amd/display/dc/basics/conversion: Include header
 containing our prototypes
Date: Thu, 26 Nov 2020 13:42:38 +0000
Message-Id: <20201126134240.3214176-39-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 27 Nov 2020 10:14:32 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9iYXNpY3MvY29udmVyc2lvbi5jOjM0
OjEwOiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmGZpeGVkX3BvaW50X3Rv
X2ludF9mcmFj4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvYmFzaWNzL2NvbnZlcnNpb24uYzo4MTo2OiB3YXJuaW5nOiBu
byBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmGNvbnZlcnRfZmxvYXRfbWF0cml44oCZIFstV21p
c3NpbmctcHJvdG90eXBlc10KCkNjOiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1k
LmNvbT4KQ2M6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgpDYzogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNj
OiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2Zm
LWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9iYXNpY3MvY29udmVyc2lvbi5jIHwgMSArCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvYmFzaWNzL2NvbnZlcnNpb24uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9iYXNpY3MvY29udmVyc2lvbi5jCmluZGV4IDUwYjQ3ZjExODc1YzkuLjI0ZWQwM2Q4Y2RhNzQg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iYXNpY3MvY29udmVy
c2lvbi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iYXNpY3MvY29udmVy
c2lvbi5jCkBAIC0yNCw2ICsyNCw3IEBACiAgKi8KIAogI2luY2x1ZGUgImRtX3NlcnZpY2VzLmgi
CisjaW5jbHVkZSAiY29udmVyc2lvbi5oIgogCiAjZGVmaW5lIERJVklERVIgMTAwMDAKIAotLSAK
Mi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
