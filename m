Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0BCC8300B
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAE89208CA
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A1J4BPee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE89208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 186706E877;
	Wed, 25 Nov 2020 08:23:01 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B18986E54C
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 19:44:35 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id 23so23519986wrc.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 11:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eR2VWY/uBkZ8OQEHImWEeJT/rcGPCff8wPihf7Jld5M=;
 b=A1J4BPeeNT7yrkRrjaash/ObA12oqLXqva2RiCKNwn8pXH4B82hyrnDC1qOlAUehpo
 AdeJQMEynjujsKrEwnks4sBT37dmB/XAEt+e122O9CLyu93pqUl+AvuCanZAbhKsTBXr
 GudbMVWesoscbiJKMq7jlO/gjtgYXb1D5MaWGt6u0q8TMlv0poGqlRZ9+8wJ01IGRJib
 SiG4ihHTtFziZ72Q9xrA7c7d6XZWZVhthZ5Br7zuNU61Byxk38+icuwZHTLSenPdTwKp
 5GUPemDK4FAEPJMbT2fmdAgMTqijobz7+niz+E3Kcg6QW5AdLpye2o+AbBhjtl1sg+x5
 pl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eR2VWY/uBkZ8OQEHImWEeJT/rcGPCff8wPihf7Jld5M=;
 b=qfhpG2Rm+8zCazqeMGsfEwL4TiJKmf3llBHslCSVpm7MYMQetb5/L9L/n7XnUwt3IL
 c0NlQqgyl/QayXR8pGaUTXTpGHmRQQSaNrXRohwXEg/50wv75YKzkks6k4hLWbRQvGKZ
 qOfEH/YftoEPqC79VYUqgfrHehVfFU/6h3t7m9NwNdpD/O9Z+OgtX/m53/C5OcRjO12X
 seABmq/i+59jixxAuIjgM2akUYWfRbiYEEFYn4a6ehfpXHkNjqA641Ae3J55uNbzakRv
 SWpqYaOlPeUOTw8HZ/IGbRySLYKydYmE0mK4Yg7D0WDPeSZvjzEmz+AM4AkS4X6WC3Ph
 Fy1w==
X-Gm-Message-State: AOAM533S+IOTcPDtZF227Yt2aCFaCXtaeN32qH0tcX1DVWU5B1bNpc3L
 I2BqlaCxG5xFuYvci7NU4L4jGA==
X-Google-Smtp-Source: ABdhPJxlONImqsImoSyKBlbOvdessgEk2uRK+pugMfFusdmCcYTUJjt30D2TUP0G+2Gd5slDF0M9HQ==
X-Received: by 2002:adf:e84e:: with SMTP id d14mr100154wrn.190.1606247074433; 
 Tue, 24 Nov 2020 11:44:34 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 11:44:33 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 28/40] drm/amd/amdgpu/gfx_v10_0: Make local function
 'gfx_v10_0_rlc_stop()' static
Date: Tue, 24 Nov 2020 19:38:12 +0000
Message-Id: <20201124193824.1118741-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124193824.1118741-1-lee.jones@linaro.org>
References: <20201124193824.1118741-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 25 Nov 2020 08:22:58 +0000
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
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmM6NTAwODo2OiB3YXJuaW5nOiBubyBwcmV2
aW91cyBwcm90b3R5cGUgZm9yIOKAmGdmeF92MTBfMF9ybGNfc3RvcOKAmSBbLVdtaXNzaW5nLXBy
b3RvdHlwZXNdCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpD
YzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZp
ZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3
bGwuY2g+CkNjOiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPgpDYzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKQ2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZwpDYzogbGluYXJvLW1tLXNpZ0Bs
aXN0cy5saW5hcm8ub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgfCAyICst
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCmluZGV4IGQ0NzYwZjRlMjY5YTEuLjllYjg4NmFl
NWEzNWUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCkBAIC01MDA1LDcg
KzUwMDUsNyBAQCBzdGF0aWMgaW50IGdmeF92MTBfMF9pbml0X2NzYihzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikKIAlyZXR1cm4gMDsKIH0KIAotdm9pZCBnZnhfdjEwXzBfcmxjX3N0b3Aoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCitzdGF0aWMgdm9pZCBnZnhfdjEwXzBfcmxjX3N0b3Ao
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB7CiAJdTMyIHRtcCA9IFJSRUczMl9TT0MxNShH
QywgMCwgbW1STENfQ05UTCk7CiAKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
