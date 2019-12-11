Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032C8C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 14:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10C220836
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 14:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRQPcC0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10C220836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BA256EB65;
	Wed, 11 Dec 2019 14:24:15 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D91FC6EB67
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 14:24:13 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id n9so7308410wmd.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 06:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uMd/Uy3uDPmMWE8oYLf+NvUl5yrN72ZYYafnnOZx+OI=;
 b=RRQPcC0HKqGr7KPbliYfYiEgH/1Eh0YeSQj1YtbFkTQlKjVyIF6aCpAYuGHIMsAbMd
 xOWhNBRotu0iz5ja1n5OmGhKALNfde8tCWKlDKk5uaRJE04+nD5JotODFV2iEhYyS++9
 NBxJxpiKTshUBe5MQlMRmbbtJk0huUyg+6SOLjF80KO6NmI5y2gz1l/96IzfU93sXlch
 aWKsdiHF0ELylgpgUi935NcSs4cZVON8/frWpl1BYyDTKBSuy5hCxsTZUtGr2sOkj2lw
 nmQQyiDMImNA+5LrWD1vWWrMOCwJqbrvEC0VFZIuThQ6f75TqTrDLzAgBFCOhiW2isEh
 dX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uMd/Uy3uDPmMWE8oYLf+NvUl5yrN72ZYYafnnOZx+OI=;
 b=XN51KLE+EHTex8cpEDNIBajL9xHN2iqktj2gE8Xe6onpc9W4LNguvXFXEkhDgcEnjB
 wFxHiuXHxXKiH11fMj0tkKiETcHZJ5ie0y4ZhxKPoXk90iuo5ZjuR6zfJ8GMaCUYWz2u
 YjlPu5O9QMKyYxucUMwK6OjUtDhLvb9exDYRJRS2oTYsf5kk4gf5nr1fQo0bIZ5jmhFU
 6T6u6aDncgCOn1dqwahewSwFj46TtJ7z9N08RHaNXy2HRK0wVzDLK9kIOGyF6JQE9pUL
 HH6Mp2QpayjsiuiiIfn0flzm88m9kFeMoIV+MOTaskR4/wqCtjgzGH+/zm2JMAzElGm0
 wS8g==
X-Gm-Message-State: APjAAAUsPyPS44Je2/ydn/0aKpVUEGpY6QQvkbdUqzhkg0TwaySdv+mh
 E3d2BL+i4LLzQDF2oUEVAFyhEz5UCm8NOw==
X-Google-Smtp-Source: APXvYqzOVobAcz8pD8GOkkJCGltcPlgcKaB21GuxL31X1zyCxinF2w4jf4+4nsWRJM8MVEL9wEgAJQ==
X-Received: by 2002:a1c:b7c4:: with SMTP id h187mr20033wmf.105.1576074252289; 
 Wed, 11 Dec 2019 06:24:12 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F28C000ABD17033B4D14136.dip0.t-ipconnect.de.
 [2003:c5:8f28:c000:abd1:7033:b4d1:4136])
 by smtp.gmail.com with ESMTPSA id 2sm2462559wrq.31.2019.12.11.06.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 06:24:11 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: alexander.deucher@amd.com,
	kenny.ho@amd.com,
	christian.koenig@amd.com
Subject: [PATCH 4/4] drm/scheduler: do not keep a copy of sched list
Date: Wed, 11 Dec 2019 15:24:07 +0100
Message-Id: <20191211142407.5407-4-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211142407.5407-1-nirmoy.das@amd.com>
References: <20191211142407.5407-1-nirmoy.das@amd.com>
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
Cc: nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ZW50aXR5IHNob3VsZCBub3Qga2VlcCBjb3B5IGFuZCBtYWludGFpbiBzY2hlZCBsaXN0IGZvcgpp
dHNlbGYuCgpTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+ClJl
dmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYyB8IDE5ICsrKystLS0t
LS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5
LmMgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jCmluZGV4IGY5YjZj
ZTI5YzU4Zi4uMmUzYTA1OGZjMjM5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1
bGVyL3NjaGVkX2VudGl0eS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRf
ZW50aXR5LmMKQEAgLTU2LDggKzU2LDYgQEAgaW50IGRybV9zY2hlZF9lbnRpdHlfaW5pdChzdHJ1
Y3QgZHJtX3NjaGVkX2VudGl0eSAqZW50aXR5LAogCQkJICB1bnNpZ25lZCBpbnQgbnVtX3NjaGVk
X2xpc3QsCiAJCQkgIGF0b21pY190ICpndWlsdHkpCiB7Ci0JaW50IGk7Ci0KIAlpZiAoIShlbnRp
dHkgJiYgc2NoZWRfbGlzdCAmJiAobnVtX3NjaGVkX2xpc3QgPT0gMCB8fCBzY2hlZF9saXN0WzBd
KSkpCiAJCXJldHVybiAtRUlOVkFMOwogCkBAIC02NywyMiArNjUsMTQgQEAgaW50IGRybV9zY2hl
ZF9lbnRpdHlfaW5pdChzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSAqZW50aXR5LAogCWVudGl0eS0+
Z3VpbHR5ID0gZ3VpbHR5OwogCWVudGl0eS0+bnVtX3NjaGVkX2xpc3QgPSBudW1fc2NoZWRfbGlz
dDsKIAllbnRpdHktPnByaW9yaXR5ID0gcHJpb3JpdHk7Ci0JZW50aXR5LT5zY2hlZF9saXN0ID0g
IGtjYWxsb2MobnVtX3NjaGVkX2xpc3QsCi0JCQkJICAgICAgc2l6ZW9mKHN0cnVjdCBkcm1fZ3B1
X3NjaGVkdWxlciAqKSwgR0ZQX0tFUk5FTCk7CisJZW50aXR5LT5zY2hlZF9saXN0ID0gbnVtX3Nj
aGVkX2xpc3QgPiAxID8gc2NoZWRfbGlzdCA6IE5VTEw7CisJZW50aXR5LT5sYXN0X3NjaGVkdWxl
ZCA9IE5VTEw7CiAKLQlpZighZW50aXR5LT5zY2hlZF9saXN0KQotCQlyZXR1cm4gLUVOT01FTTsK
KwlpZihudW1fc2NoZWRfbGlzdCkKKwkJZW50aXR5LT5ycSA9ICZzY2hlZF9saXN0WzBdLT5zY2hl
ZF9ycVtlbnRpdHktPnByaW9yaXR5XTsKIAogCWluaXRfY29tcGxldGlvbigmZW50aXR5LT5lbnRp
dHlfaWRsZSk7CiAKLQlmb3IgKGkgPSAwOyBpIDwgbnVtX3NjaGVkX2xpc3Q7IGkrKykKLQkJZW50
aXR5LT5zY2hlZF9saXN0W2ldID0gc2NoZWRfbGlzdFtpXTsKLQotCWlmIChudW1fc2NoZWRfbGlz
dCkKLQkJZW50aXR5LT5ycSA9ICZlbnRpdHktPnNjaGVkX2xpc3RbMF0tPnNjaGVkX3JxW2VudGl0
eS0+cHJpb3JpdHldOwotCi0JZW50aXR5LT5sYXN0X3NjaGVkdWxlZCA9IE5VTEw7Ci0KIAlzcGlu
X2xvY2tfaW5pdCgmZW50aXR5LT5ycV9sb2NrKTsKIAlzcHNjX3F1ZXVlX2luaXQoJmVudGl0eS0+
am9iX3F1ZXVlKTsKIApAQCAtMzEyLDcgKzMwMiw2IEBAIHZvaWQgZHJtX3NjaGVkX2VudGl0eV9m
aW5pKHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5ICplbnRpdHkpCiAKIAlkbWFfZmVuY2VfcHV0KGVu
dGl0eS0+bGFzdF9zY2hlZHVsZWQpOwogCWVudGl0eS0+bGFzdF9zY2hlZHVsZWQgPSBOVUxMOwot
CWtmcmVlKGVudGl0eS0+c2NoZWRfbGlzdCk7CiB9CiBFWFBPUlRfU1lNQk9MKGRybV9zY2hlZF9l
bnRpdHlfZmluaSk7CiAKLS0gCjIuMjQuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
