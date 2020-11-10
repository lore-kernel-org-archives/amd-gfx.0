Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6DCC61DD8
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:35:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A0120665
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CZrD24nh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A0120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2550F89C56;
	Tue, 10 Nov 2020 19:35:46 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C719A89C18
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 19:31:48 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id d12so12501246wrr.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 11:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4Sm/diM1ysLxo1VzfvufUrkgqFPpDL8/DuxdgOjGpqk=;
 b=CZrD24nhvG2iKoj4noUsAlrwucBSgxTDbkGLYlEEUgSDr2Zy+HeJpNOHnLGyxd2YyB
 ZJQ6UXdgUfIMAhCAJ024R0H2Way6kwLlIHcQePC+l7iMTF0CV6X8kZDDmPGuaemhUSp8
 800pFOG3yycgu2nI36yUiLjHgtWG5tpiOGBqQpcARNijHSmCokrGz9nmDIu6zJ6tg/z5
 FCRP6rRBQCoRr3UUGixrgmzUVA8rkV0jAqYjmFjNigFQNMg0VIghzCyxk1PB5/rtlmmL
 wo5Jr7Q/LM8kPqSrNKHMXufrbqKBkDSEpL7HRj0P0JoHjIVks/WOc6vhahHnS895KRw/
 wI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4Sm/diM1ysLxo1VzfvufUrkgqFPpDL8/DuxdgOjGpqk=;
 b=kuKecqiGva7Q8Cfva1DP2jME6Shpl9ZByARMC0KqpmfpcIp2MazGo00fXTRuCJyWzr
 iYtbkoXt8cp9EXhvDkQtrOlYvt2Zv7ymZ/BW6ASKvoiLkKSSxI5doKDG5p+6sDvwYHmG
 iNuve5FSkLArX2fLqLgTZn+z9TDL35KVwe1iA2NrrSrSpa5LlHtZepk/vYtJIdgumkLw
 fOS8smhdxBvG1cJjgE96L9eplPTlDplrQNQ3w5eOuVDdwRfLY4wDBUVHvhp5AAAjVlS7
 BKPXlNa7kxdVvioZnPY+/PEsYBGFTEBZ8oRstDAZfOjOzIGLALi+O12ps0MCJ9Rx0LLR
 Hkjg==
X-Gm-Message-State: AOAM532aIDECQKVSwNpejV7kK6K+WKszGuwMD1Hb+T3hVqV6KyuC6Quc
 Lh46lVI+UfdNq89SLZ+LnZPLrQ==
X-Google-Smtp-Source: ABdhPJydisdr0J37dZbJ7k4ipfoX1H7RQuZ8b5877kgvFGHpkWN/RL5fEew9s8dnutPJ9wQPzCIbdQ==
X-Received: by 2002:a5d:46c6:: with SMTP id g6mr8139860wrs.170.1605036707394; 
 Tue, 10 Nov 2020 11:31:47 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 11:31:46 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 25/30] drm/radeon/sumo_dpm: Move 'sumo_get_pi()'s prototype
 into shared header
Date: Tue, 10 Nov 2020 19:31:07 +0000
Message-Id: <20201110193112.988999-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 10 Nov 2020 19:35:44 +0000
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9zdW1vX2RwbS5jOjgxOjI1OiB3YXJuaW5nOiBubyBwcmV2aW91cyBw
cm90b3R5cGUgZm9yIOKAmHN1bW9fZ2V0X3Bp4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KIDgx
IHwgc3RydWN0IHN1bW9fcG93ZXJfaW5mbyAqc3Vtb19nZXRfcGkoc3RydWN0IHJhZGVvbl9kZXZp
Y2UgKnJkZXYpCiB8IF5+fn5+fn5+fn5+CgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0
dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpD
YzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9u
ZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vc3Vt
b19kcG0uaCB8IDEgKwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zdW1vX3NtYy5jIHwgMiAtLQog
MiBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3N1bW9fZHBtLmggYi9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3N1bW9fZHBtLmgKaW5kZXggZjE2NTExMzVhNDdhYi4uZGIyOWQzN2FlMjcwMyAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zdW1vX2RwbS5oCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9yYWRlb24vc3Vtb19kcG0uaApAQCAtMjA3LDYgKzIwNyw3IEBAIHUzMiBzdW1vX2dl
dF9zbGVlcF9kaXZpZGVyX2Zyb21faWQodTMyIGlkKTsKIHUzMiBzdW1vX2dldF9zbGVlcF9kaXZp
ZGVyX2lkX2Zyb21fY2xvY2soc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYsCiAJCQkJCSB1MzIg
c2NsaywKIAkJCQkJIHUzMiBtaW5fc2Nsa19pbl9zcik7CitzdHJ1Y3Qgc3Vtb19wb3dlcl9pbmZv
ICpzdW1vX2dldF9waShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7CiAKIC8qIHN1bW9fc21j
LmMgKi8KIHZvaWQgc3Vtb19pbml0aWFsaXplX20zX2FyYihzdHJ1Y3QgcmFkZW9uX2RldmljZSAq
cmRldik7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3N1bW9fc21jLmMgYi9k
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3N1bW9fc21jLmMKaW5kZXggZDc4MTQwNzA1NzM2Ni4uNzhk
ODcxNjA2NzMxOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zdW1vX3NtYy5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vc3Vtb19zbWMuYwpAQCAtMzAsOCArMzAsNiBA
QAogI2RlZmluZSBTVU1PX1NNVV9TRVJWSUNFX1JPVVRJTkVfQUxUVkRETkJfTk9USUZZICAyNwog
I2RlZmluZSBTVU1PX1NNVV9TRVJWSUNFX1JPVVRJTkVfR0ZYX1NSVl9JRF8yMCAgMjAKIAotc3Ry
dWN0IHN1bW9fcG93ZXJfaW5mbyAqc3Vtb19nZXRfcGkoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJk
ZXYpOwotCiBzdGF0aWMgdm9pZCBzdW1vX3NlbmRfbXNnX3RvX3NtdShzdHJ1Y3QgcmFkZW9uX2Rl
dmljZSAqcmRldiwgdTMyIGlkKQogewogCXUzMiBnZnhfaW50X3JlcTsKLS0gCjIuMjUuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
