Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284C7C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 08:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32ED23102
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 08:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32ED23102
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 013396E13C;
	Wed, 13 Jan 2021 08:24:30 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E64389FF6
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 08:08:11 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id y187so712247wmd.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 00:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=upsPNw/tEbA/WXl0QtiBmIh69kJTZiyD6g31r7koW20=;
 b=chUfkrycKg5MIRF9H9qdA6JCg9Bpnh3Nf3wLevITHavXTmsdYBUZOPs9bfiTizkdSk
 0OLxGVTT9FC7RBTXPBcpyYdqbU2HNc/VPT1v/JlNog0IH55G/nTtfwfUTsF5zar+QFZm
 npR0p2Nednhpi6YDfOU66d9OcWpL4dJ+bHT3UVW2U8gIKUsHTP/Qp7BzfbqTcVRiOewI
 b3gcVybTv6EjUSSvq7vzIg2249S0avETtwtS9oVo326vf5EgzXaqrTc0H0s8uT+JDzia
 MQK50s1UwwYe4CBFNuu7jHfjwtiihoKelCWVvTBy3NRrghJmvgZYgrPpbx5oPBJ+5lT0
 a0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=upsPNw/tEbA/WXl0QtiBmIh69kJTZiyD6g31r7koW20=;
 b=XmqoIrgHBqhZ0qgHUnUf2LVHFHXkrujZ3UtcuFEnQTqZHMi5OGGbIUQM3IvsplzEQg
 wyNCyClposKEJbOB0D9kqJENB+eDijt6I6nnHgmLkFt7dE0+P1l6YmCplJ7wYvLv3qBb
 S1qHMY4Ws7MI2B/hqq9Ria8u4/SlOEVrctaTaJTaieXknf52AwKk7+VZt2BfPCWYThM5
 rDzk8lD/Nu78bDybR3ivkHMXFyL4JnG1Byqr1HYuMpdqX41EvDs2CKkmhrWrpvt7Uvse
 FRohMlFHXaBWo5NqxWEW4On8AbIQGIXtGrV2oydCSBmu3wwniZzHQv7b9Yy9Z0bNYnwm
 cMIw==
X-Gm-Message-State: AOAM532/IrZPkGX+9B+om6C/GQJDnOtnmXd3oglpk8FDUvQ28bHp8vxX
 iFMvOuVYPlYNz9n+qCK3tXg0dA==
X-Google-Smtp-Source: ABdhPJzlIQ1bUxW4me+IU3JTzaO6MgEgBB9EKMUF6e/kVElBQj0xqPCpDrNdvq8TVktKdTqPghHJuw==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr932035wmi.20.1610525290060;
 Wed, 13 Jan 2021 00:08:10 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jan 2021 00:08:09 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 11/30] drm/amd/display/dc/dce100/Makefile: Ignore
 -Woverride-init warning
Date: Wed, 13 Jan 2021 08:07:33 +0000
Message-Id: <20210113080752.1003793-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113080752.1003793-1-lee.jones@linaro.org>
References: <20210113080752.1003793-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 13 Jan 2021 08:24:28 +0000
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
ZGNlMTAwL2RjZTEwMF9yZXNvdXJjZS5jOjU0OgogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Li4vaW5jbHVkZS9hc2ljX3JlZy9kY2UvZGNlXzEwXzBfc2hfbWFzay5oOjUwODQ6NDU6IHdhcm5p
bmc6IGluaXRpYWxpemVkIGZpZWxkIG92ZXJ3cml0dGVuIFstV292ZXJyaWRlLWluaXRdCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZS9kY2VfbWVtX2lucHV0Lmg6
MTU1OjI4OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYR1JQSF9DT05UUk9MX19HUlBI
X05VTV9CQU5LU19fU0hJRlTigJkKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3Bs
YXkvZGMvZGNlL2RjZV9tZW1faW5wdXQuaDoxNzA6Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1h
Y3JvIOKAmFNGQuKAmQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9k
Y2UvZGNlX21lbV9pbnB1dC5oOjI5MToyOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCY
TUlfR0ZYOF9USUxFX01BU0tfU0hfTElTVOKAmQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Li4vZGlzcGxheS9kYy9kY2UxMDAvZGNlMTAwX3Jlc291cmNlLmM6NTM3OjM6IG5vdGU6IGluIGV4
cGFuc2lvbiBvZiBtYWNybyDigJhNSV9EQ0U4X01BU0tfU0hfTElTVOKAmQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvLi4vaW5jbHVkZS9hc2ljX3JlZy9kY2UvZGNlXzEwXzBfc2hfbWFzay5o
OjUwODQ6NDU6IG5vdGU6IChuZWFyIGluaXRpYWxpemF0aW9uIGZvciDigJhtaV9zaGlmdHMuR1JQ
SF9OVU1fQkFOS1PigJkpCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2Rj
L2RjZS9kY2VfbWVtX2lucHV0Lmg6MTU1OjI4OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g
4oCYR1JQSF9DT05UUk9MX19HUlBIX05VTV9CQU5LU19fU0hJRlTigJkKIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlL2RjZV9tZW1faW5wdXQuaDoxNzA6Mjogbm90
ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmFNGQuKAmQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvLi4vZGlzcGxheS9kYy9kY2UvZGNlX21lbV9pbnB1dC5oOjI5MToyOiBub3RlOiBpbiBl
eHBhbnNpb24gb2YgbWFjcm8g4oCYTUlfR0ZYOF9USUxFX01BU0tfU0hfTElTVOKAmQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UxMDAvZGNlMTAwX3Jlc291cmNl
LmM6NTM3OjM6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhNSV9EQ0U4X01BU0tfU0hf
TElTVOKAmQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vaW5jbHVkZS9hc2ljX3JlZy9k
Y2UvZGNlXzEwXzBfc2hfbWFzay5oOjUwODM6NDM6IHdhcm5pbmc6IGluaXRpYWxpemVkIGZpZWxk
IG92ZXJ3cml0dGVuIFstV292ZXJyaWRlLWluaXRdCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS8uLi9kaXNwbGF5L2RjL2RjZS9kY2VfbWVtX2lucHV0Lmg6MTU1OjI4OiBub3RlOiBpbiBleHBh
bnNpb24gb2YgbWFjcm8g4oCYR1JQSF9DT05UUk9MX19HUlBIX05VTV9CQU5LU19NQVNL4oCZCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZS9kY2VfbWVtX2lucHV0
Lmg6MTcwOjI6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhTRkLigJkKIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlL2RjZV9tZW1faW5wdXQuaDoyOTE6
Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmE1JX0dGWDhfVElMRV9NQVNLX1NIX0xJ
U1TigJkKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlMTAwL2Rj
ZTEwMF9yZXNvdXJjZS5jOjU0MjozOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYTUlf
RENFOF9NQVNLX1NIX0xJU1TigJkKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2luY2x1
ZGUvYXNpY19yZWcvZGNlL2RjZV8xMF8wX3NoX21hc2suaDo1MDgzOjQzOiBub3RlOiAobmVhciBp
bml0aWFsaXphdGlvbiBmb3Ig4oCYbWlfbWFza3MuR1JQSF9OVU1fQkFOS1PigJkpCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZS9kY2VfbWVtX2lucHV0Lmg6MTU1
OjI4OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYR1JQSF9DT05UUk9MX19HUlBIX05V
TV9CQU5LU19NQVNL4oCZCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2Rj
L2RjZS9kY2VfbWVtX2lucHV0Lmg6MTcwOjI6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDi
gJhTRkLigJkKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlL2Rj
ZV9tZW1faW5wdXQuaDoyOTE6Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmE1JX0dG
WDhfVElMRV9NQVNLX1NIX0xJU1TigJkKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rp
c3BsYXkvZGMvZGNlMTAwL2RjZTEwMF9yZXNvdXJjZS5jOjU0MjozOiBub3RlOiBpbiBleHBhbnNp
b24gb2YgbWFjcm8g4oCYTUlfRENFOF9NQVNLX1NIX0xJU1TigJkKCkNjOiBIYXJyeSBXZW50bGFu
ZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KQ2M6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29t
PgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlz
dGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUg
PGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNj
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3Jn
PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMDAvTWFrZWZpbGUgfCAy
ICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTEwMC9NYWtlZmlsZSBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kY2UxMDAvTWFrZWZpbGUKaW5kZXggYTgyMmQ0ZTJhMTY5My4uZmYy
MGM0N2Y1NTllMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
ZTEwMC9NYWtlZmlsZQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTAw
L01ha2VmaWxlCkBAIC0yMyw2ICsyMyw4IEBACiAjIE1ha2VmaWxlIGZvciB0aGUgJ2NvbnRyb2xs
ZXInIHN1Yi1jb21wb25lbnQgb2YgREFMLgogIyBJdCBwcm92aWRlcyB0aGUgY29udHJvbCBhbmQg
c3RhdHVzIG9mIEhXIENSVEMgYmxvY2suCiAKK0NGTEFHU18kKEFNRERBTFBBVEgpL2RjL2RjZTEw
MC9kY2UxMDBfcmVzb3VyY2UubyA9ICQoY2FsbCBjYy1kaXNhYmxlLXdhcm5pbmcsIG92ZXJyaWRl
LWluaXQpCisKIERDRTEwMCA9IGRjZTEwMF9yZXNvdXJjZS5vIGRjZTEwMF9od19zZXF1ZW5jZXIu
bwogCiBBTURfREFMX0RDRTEwMCA9ICQoYWRkcHJlZml4ICQoQU1EREFMUEFUSCkvZGMvZGNlMTAw
LywkKERDRTEwMCkpCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
