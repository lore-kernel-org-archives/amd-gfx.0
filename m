Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2EDC433E6
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C0A72399C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C0A72399C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 223756E8F5;
	Fri,  8 Jan 2021 20:24:18 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F03C96E8E2
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 20:15:47 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id g25so7364511wmh.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 12:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YEfovM2NKT8ag9TvqZ5TvTpEztKPhuBS/BnjHfStf3g=;
 b=qrFDHa6UMrCuOW/PtBirv0Ncr1vLCDJC57MzIwvydzI8tYtfDhmCZvdRcq+JEaYKFj
 j7lHElH8pycb5tVBNhvAACygNyfntQryXRiD4cAGiUtrML6OGIBkIDaIUyn/bH1pT3Nk
 mbEUKAeUZDcLk7U/O4lCYCQ20NPOfui8QBFwVFHzmaRu0QeeN2Og9A741HgBzdhG8grL
 0Fa4ls1CABD03p++A9w9y1DX1LB3k/YCpqruWCGpbWMhT8gYBlG0FkPBdY7CY2TJ6Rv7
 zdjgfbCO6oeuAuaxBG8OZL7CZTm5vMaWRgC+QgxY4dNb3Qyr3OJHAc71TYnJp9bl2noX
 xv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YEfovM2NKT8ag9TvqZ5TvTpEztKPhuBS/BnjHfStf3g=;
 b=hjECKhin3kMjZHqxUSBkiwFiv2NFGj6tiiDcEHz4pyR78Pj0mFbcnn576gt7u4Nyt/
 meR78FzUmNkam0SdmA++ns9lw8ymqkCsM7NIlYvdvfZVxoMZ+NteshME+hQQ3AT07HVh
 V9gjwf40Nf2W9nZBkLAq+cTzLnjJedIMEIJH2TubZvqxdFbE+WeF5BMXi9uRwBR/DHld
 enO9wQ2WrR8Y5QT8aqEwwgEhU5PsuFjz63oSDaySnPxf07YYMDZUV4Tr2SVMSwpXeL2n
 1vfAmFOYvNaYL2q6qqPpGLr6uuIu9JoGrladCbfvEjGaxuEUcCq89MpV7G3prrb/2EZC
 PLcg==
X-Gm-Message-State: AOAM531asGoZ8HFWJ9Q1AsY2tpF9JU3OCEBRTy6ZgTrp0PunO9J0nofK
 Mr0oDkNIjsUsbjhTN3dKrfGfSw==
X-Google-Smtp-Source: ABdhPJyWNXAZMb17ssH50iSdT8H27rJjcQnuXfCL2ZQMggBqNfo6pnT2c08Z3ljkQNjZ2fHs49c11w==
X-Received: by 2002:a1c:87:: with SMTP id 129mr4460111wma.183.1610136946590;
 Fri, 08 Jan 2021 12:15:46 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 12:15:45 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 29/40] drm/amd/display/dc/dce/dce_dmcu: Staticify local
 function call 'dce_dmcu_load_iram'
Date: Fri,  8 Jan 2021 20:14:46 +0000
Message-Id: <20210108201457.3078600-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 08 Jan 2021 20:24:14 +0000
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
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>, Leo Li <sunpeng.li@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UvZGNlX2RtY3UuYzo3NDo2OiB3
YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmGRjZV9kbWN1X2xvYWRfaXJhbeKA
mSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UvZGNlX2RtY3UuYzozMToKCkNjOiBI
YXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KQ2M6IExlbyBMaSA8c3VucGVu
Zy5saUBhbWQuY29tPgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29t
PgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBE
YXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxA
ZmZ3bGwuY2g+CkNjOiBLcnVub3NsYXYgS292YWMgPEtydW5vc2xhdi5Lb3ZhY0BhbWQuY29tPgpD
YzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9y
Zz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9kbWN1LmMgfCAy
ICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9kbWN1LmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9kbWN1LmMKaW5kZXggZjNlZDhi
NjE5Y2FmZC4uZmEyYjQ3ZDQxZWUyZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2RjZS9kY2VfZG1jdS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kY2UvZGNlX2RtY3UuYwpAQCAtNzEsNyArNzEsNyBAQCBzdGF0aWMgYm9vbCBkY2VfZG1j
dV9pbml0KHN0cnVjdCBkbWN1ICpkbWN1KQogCXJldHVybiB0cnVlOwogfQogCi1ib29sIGRjZV9k
bWN1X2xvYWRfaXJhbShzdHJ1Y3QgZG1jdSAqZG1jdSwKK3N0YXRpYyBib29sIGRjZV9kbWN1X2xv
YWRfaXJhbShzdHJ1Y3QgZG1jdSAqZG1jdSwKIAkJdW5zaWduZWQgaW50IHN0YXJ0X29mZnNldCwK
IAkJY29uc3QgY2hhciAqc3JjLAogCQl1bnNpZ25lZCBpbnQgYnl0ZXMpCi0tIAoyLjI1LjEKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
