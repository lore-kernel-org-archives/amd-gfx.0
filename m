Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDFCC4708D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A45260FD8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A45260FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20EE26ECF7;
	Wed, 26 May 2021 12:57:29 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E05286EC36
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 08:47:50 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 z137-20020a1c7e8f0000b02901774f2a7dc4so2933734wmc.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 01:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VdhmaHY4/dmW91tEBMJX0Bu7PliwQQfsKUoeLcKD0IA=;
 b=OibzwUzjSDVCtV8ltB9PfH3nOFJ0quNuzsPiYyQdK4H9UVDDcpJZVJC08Jz7bgj/es
 xjxQgzQO7P7v6DS+p+5LFlLJoDjgFc/+eyif00nSU48DeP0v/b6mGDTXV3LD10O1ekPm
 is1c6rW4NUNkOK5jIybllp1DeajeLodSQhk4o19+F4bbzMFT2pzK9i8eNRxZ3dsVOFTI
 YSdUNpBG5X6dNrLI2fDSqwA0eZHzNntDIKe734r8dF8O/5AUmXYqDw5qvLPYmzw8EnbS
 ddEirlfh7i28ktzE+kYO3dkKLFf5EU19PwyOR5jC4iEUtQbqEb3H/JWVADHCdbXkf9cl
 BoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VdhmaHY4/dmW91tEBMJX0Bu7PliwQQfsKUoeLcKD0IA=;
 b=MIEFkhC/bWaIxmfzILgtlGbP7DPAGVmVL4M+Vq4Ax6BULW2Kw+O2tf7wjs2x+an8bj
 f9HGKhoGrH3ZjlrtOGesS4EZb7BK5uCqyTdg4yM8a5UXVEYxiGXqxmT25c7L7ZULGYAm
 An8JUeGjIXQFXt6AZR3D4M9g4Eiru7ZzfWhiHYhVWHGUnwk7lZuZhDyVzYpTUCaK8Jz8
 HFNrDWtI8uBzdL0Jm63ywmhikL38+2H6YNE8zJkwIFOBX794cWVL2t9naONdUuEOUxpP
 l7sNNRPCgETMQsqADnGY+pcFynM6275tlzcAcRLISAiR+G2Unw3PdBj4B1P/KHEub0Es
 WStg==
X-Gm-Message-State: AOAM532YgyrJXExcozwJ7tptTTerORm/rxFOpTYMT/CK3xV5pkuY/3g8
 7gDDXUIsjSrh2JlDnDuaCv4eMg==
X-Google-Smtp-Source: ABdhPJwL1nDK4Uo0V6VHswsbzS764ElullDfNHxS322OpEzQ2x9bea+yfqjVJl6SY63hb6AWHflEjw==
X-Received: by 2002:a05:600c:3586:: with SMTP id
 p6mr2360600wmq.48.1622018869377; 
 Wed, 26 May 2021 01:47:49 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
 by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 01:47:48 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 18/34] drm/amd/display/dc/dce/dce_mem_input: Remove duplicate
 initialisation of GRPH_CONTROL__GRPH_NUM_BANKS_{SHIFT, MASK
Date: Wed, 26 May 2021 09:47:10 +0100
Message-Id: <20210526084726.552052-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 26 May 2021 12:57:23 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, Mauro Rossi <issor.oruam@gmail.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogSW4gZmls
ZSBpbmNsdWRlZCBmcm9tIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMv
ZGNlNjAvZGNlNjBfcmVzb3VyY2UuYzoyOToKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4u
L2luY2x1ZGUvYXNpY19yZWcvZGNlL2RjZV82XzBfc2hfbWFzay5oOjcyNzA6NDU6IHdhcm5pbmc6
IGluaXRpYWxpemVkIGZpZWxkIG92ZXJ3cml0dGVuIFstV292ZXJyaWRlLWluaXRdCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZS9kY2VfbWVtX2lucHV0Lmg6MTU1
OjI4OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYR1JQSF9DT05UUk9MX19HUlBIX05V
TV9CQU5LU19fU0hJRlTigJkKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkv
ZGMvZGNlL2RjZV9tZW1faW5wdXQuaDoxNTk6Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3Jv
IOKAmFNGQuKAmQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2Uv
ZGNlX21lbV9pbnB1dC5oOjI2NDoyOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYTUlf
R0ZYNl9USUxFX01BU0tfU0hfTElTVOKAmQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4v
ZGlzcGxheS9kYy9kY2U2MC9kY2U2MF9yZXNvdXJjZS5jOjY1NzozOiBub3RlOiBpbiBleHBhbnNp
b24gb2YgbWFjcm8g4oCYTUlfRENFNl9NQVNLX1NIX0xJU1TigJkKIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1Ly4uL2luY2x1ZGUvYXNpY19yZWcvZGNlL2RjZV82XzBfc2hfbWFzay5oOjcyNzA6
NDU6IG5vdGU6IChuZWFyIGluaXRpYWxpemF0aW9uIGZvciDigJhtaV9zaGlmdHMuR1JQSF9OVU1f
QkFOS1PigJkpCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZS9k
Y2VfbWVtX2lucHV0Lmg6MTU1OjI4OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYR1JQ
SF9DT05UUk9MX19HUlBIX05VTV9CQU5LU19fU0hJRlTigJkKIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlL2RjZV9tZW1faW5wdXQuaDoxNTk6Mjogbm90ZTogaW4g
ZXhwYW5zaW9uIG9mIG1hY3JvIOKAmFNGQuKAmQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Li4vZGlzcGxheS9kYy9kY2UvZGNlX21lbV9pbnB1dC5oOjI2NDoyOiBub3RlOiBpbiBleHBhbnNp
b24gb2YgbWFjcm8g4oCYTUlfR0ZYNl9USUxFX01BU0tfU0hfTElTVOKAmQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2U2MC9kY2U2MF9yZXNvdXJjZS5jOjY1Nzoz
OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYTUlfRENFNl9NQVNLX1NIX0xJU1TigJkK
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2luY2x1ZGUvYXNpY19yZWcvZGNlL2RjZV82
XzBfc2hfbWFzay5oOjcyNjk6NDM6IHdhcm5pbmc6IGluaXRpYWxpemVkIGZpZWxkIG92ZXJ3cml0
dGVuIFstV292ZXJyaWRlLWluaXRdCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNw
bGF5L2RjL2RjZS9kY2VfbWVtX2lucHV0Lmg6MTU1OjI4OiBub3RlOiBpbiBleHBhbnNpb24gb2Yg
bWFjcm8g4oCYR1JQSF9DT05UUk9MX19HUlBIX05VTV9CQU5LU19NQVNL4oCZCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZS9kY2VfbWVtX2lucHV0Lmg6MTU5OjI6
IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhTRkLigJkKIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlL2RjZV9tZW1faW5wdXQuaDoyNjQ6Mjogbm90ZTog
aW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmE1JX0dGWDZfVElMRV9NQVNLX1NIX0xJU1TigJkKIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlNjAvZGNlNjBfcmVzb3Vy
Y2UuYzo2NjI6Mzogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmE1JX0RDRTZfTUFTS19T
SF9MSVNU4oCZCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9pbmNsdWRlL2FzaWNfcmVn
L2RjZS9kY2VfNl8wX3NoX21hc2suaDo3MjY5OjQzOiBub3RlOiAobmVhciBpbml0aWFsaXphdGlv
biBmb3Ig4oCYbWlfbWFza3MuR1JQSF9OVU1fQkFOS1PigJkpCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZS9kY2VfbWVtX2lucHV0Lmg6MTU1OjI4OiBub3RlOiBp
biBleHBhbnNpb24gb2YgbWFjcm8g4oCYR1JQSF9DT05UUk9MX19HUlBIX05VTV9CQU5LU19NQVNL
4oCZCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZS9kY2VfbWVt
X2lucHV0Lmg6MTU5OjI6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhTRkLigJkKIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlL2RjZV9tZW1faW5wdXQu
aDoyNjQ6Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmE1JX0dGWDZfVElMRV9NQVNL
X1NIX0xJU1TigJkKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNl
NjAvZGNlNjBfcmVzb3VyY2UuYzo2NjI6Mzogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKA
mE1JX0RDRTZfTUFTS19TSF9MSVNU4oCZCgpDYzogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRs
YW5kQGFtZC5jb20+CkNjOiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KQ2M6IEFsZXggRGV1
Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4
LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogTWF1cm8gUm9zc2kg
PGlzc29yLm9ydWFtQGdtYWlsLmNvbT4KQ2M6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5v
cmc+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX21lbV9p
bnB1dC5oIHwgMSAtCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX21lbV9pbnB1dC5oIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfbWVtX2lucHV0LmgKaW5kZXggOWIx
YzRkNTYyNzVhNC4uMDhhNGM4ZDAyOWQ5ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RjZS9kY2VfbWVtX2lucHV0LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RjZS9kY2VfbWVtX2lucHV0LmgKQEAgLTIwNiw3ICsyMDYsNiBAQCBzdHJ1
Y3QgZGNlX21lbV9pbnB1dF9yZWdpc3RlcnMgewogCVNGQihibGssIEdSUEhfRU5BQkxFLCBHUlBI
X0VOQUJMRSwgbWFza19zaCksXAogCVNGQihibGssIEdSUEhfQ09OVFJPTCwgR1JQSF9ERVBUSCwg
bWFza19zaCksXAogCVNGQihibGssIEdSUEhfQ09OVFJPTCwgR1JQSF9GT1JNQVQsIG1hc2tfc2gp
LFwKLQlTRkIoYmxrLCBHUlBIX0NPTlRST0wsIEdSUEhfTlVNX0JBTktTLCBtYXNrX3NoKSxcCiAJ
U0ZCKGJsaywgR1JQSF9YX1NUQVJULCBHUlBIX1hfU1RBUlQsIG1hc2tfc2gpLFwKIAlTRkIoYmxr
LCBHUlBIX1lfU1RBUlQsIEdSUEhfWV9TVEFSVCwgbWFza19zaCksXAogCVNGQihibGssIEdSUEhf
WF9FTkQsIEdSUEhfWF9FTkQsIG1hc2tfc2gpLFwKLS0gCjIuMzEuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
