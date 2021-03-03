Return-Path: <SRS0=hRd6=IB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F50CC433E9
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 13:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 420D464EE9
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 13:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420D464EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1361A6E992;
	Wed,  3 Mar 2021 13:52:13 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4D486E8EA
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Mar 2021 13:43:41 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id 7so23755159wrz.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Mar 2021 05:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/QIOJ+jcry9nSq3nprw2igH3RHK7U5zFD/JMioUS840=;
 b=jLQUoxJt4yKOi/a2LytqC3f9MXcNn4Ges2MV13JFH21+ISQZPa1bJwuNQ2Ri6hUvPf
 MSCY27ncYgC6IN6vgmZzR1T6D4pKHZPwAFmVroWGy7jSbLeWj3I+8YIATC3TFK7Z6kyo
 vsWNJ9T5qyAgtOynq6rfhL+oGtnJfDzITSbdlRvMIPjJHTq0KCY9YZ2NqolFx35lLnuZ
 Fdf0r9DNAO000lpRErN5MfZq56OW1eVu9aqHf9dFahotdxPJV3nNJiSfioRK+IYOClkU
 5ZwV5WPy849dLVNUZVUPEVDWGrMSkK2uTWDPrsxdHMjmSy87hgYuzeOHLUfZzpc9NE0U
 6+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/QIOJ+jcry9nSq3nprw2igH3RHK7U5zFD/JMioUS840=;
 b=F7U3S1/LYUIb5U98GUJbLGQJOeaWCbjfe+I8Esd5S8oX+/u6y25KJPP/t5Zxsq+FAZ
 zs94CniEmx7QZxnGZ0QYhEeGTVSEzaGBncfkfC9+L9caF5W7DahhlVyKkrnwc8yDqAzI
 Y4RyqguhWP4m7ga8t7Er8mlsCpXn6gbdx9ThtDTvGRky+mwsOwhy1cTyYd19xfr4DF5U
 FFMXu00JX+dTTlRTdmBtalbha6lVjHLEUGMV4OskGsZgY7cEAf6Zd8xPX0ASI0XP5TJF
 8SZHeMyjG/EWngIWKwdbVLTPVgXUGgCMDMcXGkjzN8xRW7ficXY5ErQz0EZFB2dK2lPL
 FeQg==
X-Gm-Message-State: AOAM532UXqtMAFzDQzjnlvkA4/Bkhvm3WDt5Bzj1kFuHgyt+5ehFgjSM
 6Ef81HzIrj63XjFLT/Ove7FeDQ==
X-Google-Smtp-Source: ABdhPJz/Q3cgwDhOxnkaDEwTxnYCboU3jyFpnYi6sfOOtqaRWiDtP0XhJrm7UCJm7/PlZs/Z4/yTUg==
X-Received: by 2002:adf:fb49:: with SMTP id c9mr27869115wrs.72.1614779020649; 
 Wed, 03 Mar 2021 05:43:40 -0800 (PST)
Received: from dell.default ([91.110.221.155])
 by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Mar 2021 05:43:40 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 10/53] drm/amd/display/dc/dce/dce_aux: Remove duplicate line
 causing 'field overwritten' issue
Date: Wed,  3 Mar 2021 13:42:36 +0000
Message-Id: <20210303134319.3160762-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 03 Mar 2021 13:52:11 +0000
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

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogSW4gZmls
ZSBpbmNsdWRlZCBmcm9tIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMv
ZGNlMTEyL2RjZTExMl9yZXNvdXJjZS5jOjU5OgogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Li4vaW5jbHVkZS9hc2ljX3JlZy9kY2UvZGNlXzExXzJfc2hfbWFzay5oOjEwMDE0OjU4OiB3YXJu
aW5nOiBpbml0aWFsaXplZCBmaWVsZCBvdmVyd3JpdHRlbiBbLVdvdmVycmlkZS1pbml0XQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UvZGNlX2F1eC5oOjIxNDox
Njogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmEFVWF9TV19EQVRBX19BVVhfU1dfQVVU
T0lOQ1JFTUVOVF9ESVNBQkxFX19TSElGVOKAmQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Li4vZGlzcGxheS9kYy9kY2UvZGNlX2F1eC5oOjEyNzoyOiBub3RlOiBpbiBleHBhbnNpb24gb2Yg
bWFjcm8g4oCYQVVYX1NG4oCZCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5
L2RjL2RjZTExMi9kY2UxMTJfcmVzb3VyY2UuYzoxNzc6Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9m
IG1hY3JvIOKAmERDRV9BVVhfTUFTS19TSF9MSVNU4oCZCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9pbmNsdWRlL2FzaWNfcmVnL2RjZS9kY2VfMTFfMl9zaF9tYXNrLmg6MTAwMTQ6NTg6
IG5vdGU6IChuZWFyIGluaXRpYWxpemF0aW9uIGZvciDigJhhdXhfc2hpZnQuQVVYX1NXX0FVVE9J
TkNSRU1FTlRfRElTQUJMReKAmSkKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3Bs
YXkvZGMvZGNlL2RjZV9hdXguaDoyMTQ6MTY6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDi
gJhBVVhfU1dfREFUQV9fQVVYX1NXX0FVVE9JTkNSRU1FTlRfRElTQUJMRV9fU0hJRlTigJkKIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlL2RjZV9hdXguaDoxMjc6
Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmEFVWF9TRuKAmQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UxMTIvZGNlMTEyX3Jlc291cmNlLmM6MTc3
OjI6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhEQ0VfQVVYX01BU0tfU0hfTElTVOKA
mQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vaW5jbHVkZS9hc2ljX3JlZy9kY2UvZGNl
XzExXzJfc2hfbWFzay5oOjEwMDEzOjU2OiB3YXJuaW5nOiBpbml0aWFsaXplZCBmaWVsZCBvdmVy
d3JpdHRlbiBbLVdvdmVycmlkZS1pbml0XQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4v
ZGlzcGxheS9kYy9kY2UvZGNlX2F1eC5oOjIxNDoxNjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1h
Y3JvIOKAmEFVWF9TV19EQVRBX19BVVhfU1dfQVVUT0lOQ1JFTUVOVF9ESVNBQkxFX01BU0vigJkK
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlL2RjZV9hdXguaDox
Mjc6Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmEFVWF9TRuKAmQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UxMTIvZGNlMTEyX3Jlc291cmNlLmM6
MTgxOjI6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhEQ0VfQVVYX01BU0tfU0hfTElT
VOKAmQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vaW5jbHVkZS9hc2ljX3JlZy9kY2Uv
ZGNlXzExXzJfc2hfbWFzay5oOjEwMDEzOjU2OiBub3RlOiAobmVhciBpbml0aWFsaXphdGlvbiBm
b3Ig4oCYYXV4X21hc2suQVVYX1NXX0FVVE9JTkNSRU1FTlRfRElTQUJMReKAmSkKIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlL2RjZV9hdXguaDoyMTQ6MTY6IG5v
dGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhBVVhfU1dfREFUQV9fQVVYX1NXX0FVVE9JTkNS
RU1FTlRfRElTQUJMRV9NQVNL4oCZCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNw
bGF5L2RjL2RjZS9kY2VfYXV4Lmg6MTI3OjI6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDi
gJhBVVhfU0bigJkKCkNjOiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4K
Q2M6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5p
ZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBM
ZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY2UvZGNlX2F1eC5oIHwgMSAtCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlv
bigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNl
X2F1eC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfYXV4LmgKaW5k
ZXggNzc1ZTI0OTI2MzgwZS4uNTY2YjFiZGRkOGNjNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfYXV4LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RjZS9kY2VfYXV4LmgKQEAgLTEwMCw3ICsxMDAsNiBAQCBzdHJ1Y3QgZGNl
MTEwX2F1eF9yZWdpc3RlcnMgewogCUFVWF9TRihBVVhfU1dfQ09OVFJPTCwgQVVYX1NXX0dPLCBt
YXNrX3NoKSxcCiAJQVVYX1NGKEFVWF9TV19EQVRBLCBBVVhfU1dfQVVUT0lOQ1JFTUVOVF9ESVNB
QkxFLCBtYXNrX3NoKSxcCiAJQVVYX1NGKEFVWF9TV19EQVRBLCBBVVhfU1dfREFUQV9SVywgbWFz
a19zaCksXAotCUFVWF9TRihBVVhfU1dfREFUQSwgQVVYX1NXX0FVVE9JTkNSRU1FTlRfRElTQUJM
RSwgbWFza19zaCksXAogCUFVWF9TRihBVVhfU1dfREFUQSwgQVVYX1NXX0lOREVYLCBtYXNrX3No
KSxcCiAJQVVYX1NGKEFVWF9TV19EQVRBLCBBVVhfU1dfREFUQSwgbWFza19zaCksXAogCUFVWF9T
RihBVVhfU1dfU1RBVFVTLCBBVVhfU1dfUkVQTFlfQllURV9DT1VOVCwgbWFza19zaCksXAotLSAK
Mi4yNy4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
