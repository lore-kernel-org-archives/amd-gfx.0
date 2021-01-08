Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BC0C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A5CD23AC0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5CD23AC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 096C56E8DF;
	Fri,  8 Jan 2021 20:24:15 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD26A6E8C6
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 20:15:57 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id t16so10169437wra.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 12:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tI0M520Tgf6Y/taglfeuNx5F4TLLe4OwvIOR0TyXZnU=;
 b=xw+bWeaEAWYrLVo8JxLnuBuwmxbi1iNsGy74mXZlvGNQ6Azts3YZMI9w5upfCOF1Tv
 ueejiFcYOTXV6jCZekcU8peSlcaVLVQR40i6N5WOK9qCJDOKgh6i5k+Ga3zjF4FmDOh7
 YJT9ZbCtfyjv1dNcHC3TxSyqBmoN65o2gglwSmZAUODShuenX/YQTTDETct5ct6hQf2h
 5YqNt9G1X9GUf8AmiY5eYEEW2GiZcPuiwUDJFHVOS6tCpZoWjAOOOHanmL9q2j2LyUGD
 R/vhENw9F8tYjeE7VhfKmnFgFBaK1ft6esGzXdO3uvtaj2eBjk6SEYx4KZc3erYgr6nd
 c4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tI0M520Tgf6Y/taglfeuNx5F4TLLe4OwvIOR0TyXZnU=;
 b=ua/UyIhdr2Evz0y/CZlQv2/X1hBi59OBzHtNzNlu5i+Ip26fkmXu/tPdLyS2o71R6F
 8CDABUMLm87Cp6DjcdyRLv2RCNWo4dUHEJYyUL6PiYo0pxsflOhI56Z1XVYPCrQC3+EP
 7U1YYKoNq1sywpcQaAaCBF/SmesyPssGAWXT9IEWDHHxj+rD1NPp9q5GdqsMfxRwH2XB
 ehqTzHq1LtaSDkweIc9cg3k/GC+SFRjJD12uM6z7Acy1dhrIiSM9+XC2bCE9xUREWe9X
 FOVjnSjmUAPrNCkM3JODGKMyv1EYjMpizLlH0sXiLIVUNQm09O0nYJL1V/K52QoEh/VP
 IsQg==
X-Gm-Message-State: AOAM530sdl/EmAKNPAZiww6KEQRv9HqH5KGmG2oRenEm0r0Hg/CnnSDS
 T8aNq1Ll4reJPbTsxpD5T1hPww==
X-Google-Smtp-Source: ABdhPJxCcw9Go7KcofC8FWaXvzbEXL0ut2OABm6WXFyyinCLRrroiqPvn7NOS8nrmWo89ywhbppXag==
X-Received: by 2002:adf:e590:: with SMTP id l16mr5282481wrm.294.1610136956461; 
 Fri, 08 Jan 2021 12:15:56 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 12:15:55 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 36/40] drm/amd/display/dc/dce/dce_i2c_hw: Make functions
 called by reference static
Date: Fri,  8 Jan 2021 20:14:53 +0000
Message-Id: <20210108201457.3078600-37-lee.jones@linaro.org>
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
Cc: Lewis Huang <Lewis.Huang@amd.com>, Leo Li <sunpeng.li@amd.com>,
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UvZGNlX2kyY19ody5jOjQzODoz
NTogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhkY2VfaTJjX2h3X2VuZ2lu
ZV93YWl0X29uX29wZXJhdGlvbl9yZXN1bHTigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UvZGNlX2kyY19ody5jOjUw
NTo2OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmGRjZV9pMmNfaHdfZW5n
aW5lX3N1Ym1pdF9wYXlsb2Fk4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KCkNjOiBIYXJyeSBX
ZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KQ2M6IExlbyBMaSA8c3VucGVuZy5saUBh
bWQuY29tPgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzog
IkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBB
aXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwu
Y2g+CkNjOiBMZXdpcyBIdWFuZyA8TGV3aXMuSHVhbmdAYW1kLmNvbT4KQ2M6IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNp
Z25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfaTJjX2h3LmMgfCA0ICsrLS0KIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfaTJjX2h3LmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9pMmNfaHcuYwppbmRleCA3ZmJkOTJmYmM2
M2E5Li5hNTI0ZjQ3MWUwZDc1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZGNlL2RjZV9pMmNfaHcuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZGNlL2RjZV9pMmNfaHcuYwpAQCAtNDM1LDcgKzQzNSw3IEBAIHN0cnVjdCBkY2VfaTJjX2h3
ICphY3F1aXJlX2kyY19od19lbmdpbmUoCiAJcmV0dXJuIGRjZV9pMmNfaHc7CiB9CiAKLWVudW0g
aTJjX2NoYW5uZWxfb3BlcmF0aW9uX3Jlc3VsdCBkY2VfaTJjX2h3X2VuZ2luZV93YWl0X29uX29w
ZXJhdGlvbl9yZXN1bHQoCitzdGF0aWMgZW51bSBpMmNfY2hhbm5lbF9vcGVyYXRpb25fcmVzdWx0
IGRjZV9pMmNfaHdfZW5naW5lX3dhaXRfb25fb3BlcmF0aW9uX3Jlc3VsdCgKIAlzdHJ1Y3QgZGNl
X2kyY19odyAqZGNlX2kyY19odywKIAl1aW50MzJfdCB0aW1lb3V0LAogCWVudW0gaTJjX2NoYW5u
ZWxfb3BlcmF0aW9uX3Jlc3VsdCBleHBlY3RlZF9yZXN1bHQpCkBAIC01MDIsNyArNTAyLDcgQEAg
c3RhdGljIHVpbnQzMl90IGdldF90cmFuc2FjdGlvbl90aW1lb3V0X2h3KAogCXJldHVybiBwZXJp
b2RfdGltZW91dCAqIG51bV9vZl9jbG9ja19zdHJldGNoZXM7CiB9CiAKLWJvb2wgZGNlX2kyY19o
d19lbmdpbmVfc3VibWl0X3BheWxvYWQoCitzdGF0aWMgYm9vbCBkY2VfaTJjX2h3X2VuZ2luZV9z
dWJtaXRfcGF5bG9hZCgKIAlzdHJ1Y3QgZGNlX2kyY19odyAqZGNlX2kyY19odywKIAlzdHJ1Y3Qg
aTJjX3BheWxvYWQgKnBheWxvYWQsCiAJYm9vbCBtaWRkbGVfb2ZfdHJhbnNhY3Rpb24sCi0tIAoy
LjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
