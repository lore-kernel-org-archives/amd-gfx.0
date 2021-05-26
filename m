Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06975C47082
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A6760FD8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A6760FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 186BA6ECE8;
	Wed, 26 May 2021 12:57:28 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D8F16E4C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 08:47:49 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 u4-20020a05600c00c4b02901774b80945cso15026307wmm.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 01:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FkeiHBD/X56XoAULZC4Zm0KTS26etafLmMiiBA6RZwA=;
 b=E5sBb6eSXnSEoXMYdy1ht4w3v1vwsj+A6bNuBnhDM9u6F2HlqgNLzq2dNKCejMjijh
 LoGSybTP9qaeLJVLUFU8f19dMAa62x7cRdIlkcvWmTjRkW50v8sBlqUbczah4tZn4Wy2
 wW5UyWPN0MtIZPmUCCwhYYIPUMfvzsWNnV1zpYqjG7NA6SoBJc8/Zl75bVYEVDVPkFXp
 0gfV6UsRV3lvhomh9Fuc4xvbZDxgSiFFE2et/mhDJH1jTdp0F52Yd0J8fr0RWxYxxTLZ
 qOlYq09WJa9Mns74A3DYacw6KA2lZsT+deEZkdryeyolLkn+ZrR/asYaBAahuJF3hDgz
 E28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FkeiHBD/X56XoAULZC4Zm0KTS26etafLmMiiBA6RZwA=;
 b=DsdLe7bNIAkugqzt3Ncfboe8jukbYBIYvbA5DvmZnIl2CdwxQfKEfh+ULuxxyrzLx8
 qD3Ol6qGDkhl52IlEO2cTywLt/FfkLMA+gVpEqV5bwPEn+nfzUGeJZtYNuXjk2vPFE1P
 xmDzXduPA6QmKrCS8CJd2nrHU4uB6UtbkflpVMjFwth7BlHGZ7PjzVZyRH5MhMA0F5Cn
 2osGtGt5qujFxDGCA3IeV4pKOCFl29pQApY7Kqt7hD0HpkKCjim76L0gC25TPUiy4hwp
 ynt60tB0A3H/w4khGpNg9aBlLt5x0Uz6XsixteEk+a2hiCyBrYbEgIMwTV8Z5o41796Q
 tjIQ==
X-Gm-Message-State: AOAM5303jzx7nI/W/2padS2U+SiboLnwo2fqFkaiTyW1qbfYTcY3CMmq
 YTBkFo6U6VsmRoFGStJTUUKpnw==
X-Google-Smtp-Source: ABdhPJwRVFjsZJ8Yn28HNsWaQ3Eep+6zlv63t509qvwQfx+QHNdSX3OCtpjtefRI3FqPdr8dyt03gw==
X-Received: by 2002:a7b:c346:: with SMTP id l6mr27552263wmj.109.1622018868241; 
 Wed, 26 May 2021 01:47:48 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
 by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 01:47:47 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 17/34] drm/amd/display/dc/dce/dce_mem_input: Remove duplicate
 initialisation of GRPH_CONTROL__GRPH_NUM_BANKS_{SHIFT, MASK}
Date: Wed, 26 May 2021 09:47:09 +0100
Message-Id: <20210526084726.552052-18-lee.jones@linaro.org>
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
ZGNlX21lbV9pbnB1dC5oOjI2NToyOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYTUlf
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
Li4vZGlzcGxheS9kYy9kY2UvZGNlX21lbV9pbnB1dC5oOjI2NToyOiBub3RlOiBpbiBleHBhbnNp
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
bWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlL2RjZV9tZW1faW5wdXQuaDoyNjU6Mjogbm90ZTog
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
aDoyNjU6Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmE1JX0dGWDZfVElMRV9NQVNL
X1NIX0xJU1TigJkKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNl
NjAvZGNlNjBfcmVzb3VyY2UuYzo2NjI6Mzogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKA
mE1JX0RDRTZfTUFTS19TSF9MSVNU4oCZCgpDYzogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRs
YW5kQGFtZC5jb20+CkNjOiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KQ2M6IEFsZXggRGV1
Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4
LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogTWF1cm8gUm9zc2kg
PGlzc29yLm9ydWFtQGdtYWlsLmNvbT4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
CkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBK
b25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RjZS9kY2VfbWVtX2lucHV0LmggfCAxIC0KIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9k
Y2VfbWVtX2lucHV0LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9t
ZW1faW5wdXQuaAppbmRleCAyM2RiNWM3MmYwN2VkLi45YjFjNGQ1NjI3NWE0IDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9tZW1faW5wdXQuaAorKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9tZW1faW5wdXQuaApAQCAt
MTgxLDcgKzE4MSw2IEBAIHN0cnVjdCBkY2VfbWVtX2lucHV0X3JlZ2lzdGVycyB7CiAJU0ZCKGJs
aywgR1JQSF9FTkFCTEUsIEdSUEhfRU5BQkxFLCBtYXNrX3NoKSxcCiAJU0ZCKGJsaywgR1JQSF9D
T05UUk9MLCBHUlBIX0RFUFRILCBtYXNrX3NoKSxcCiAJU0ZCKGJsaywgR1JQSF9DT05UUk9MLCBH
UlBIX0ZPUk1BVCwgbWFza19zaCksXAotCVNGQihibGssIEdSUEhfQ09OVFJPTCwgR1JQSF9OVU1f
QkFOS1MsIG1hc2tfc2gpLFwKIAlTRkIoYmxrLCBHUlBIX1hfU1RBUlQsIEdSUEhfWF9TVEFSVCwg
bWFza19zaCksXAogCVNGQihibGssIEdSUEhfWV9TVEFSVCwgR1JQSF9ZX1NUQVJULCBtYXNrX3No
KSxcCiAJU0ZCKGJsaywgR1JQSF9YX0VORCwgR1JQSF9YX0VORCwgbWFza19zaCksXAotLSAKMi4z
MS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
