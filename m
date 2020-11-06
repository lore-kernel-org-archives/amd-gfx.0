Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86AEC55ABD
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 21:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7E62087E
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 21:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fg03f1ie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7E62087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFFBE6EB3B;
	Fri,  6 Nov 2020 21:52:21 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4BF06EB25
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 21:50:09 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id x7so2792392wrl.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Nov 2020 13:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sSLs3el2OyWbVsEn+pD70NcssOBrvqEsumretpeL3Ds=;
 b=Fg03f1ie4ITmoYfqfIpjifTAA8wKVblmO4KjzkpCm6gE2NytBaRSUY0L+Sq4e5GQBG
 bFs4s7QvgryHFMdcA8em7y6YUQG39npIUgTlI0EQowc5rrw9+Odku+gMoW8GldBSQC9E
 E6QQiE93cA7d+XE4vK/HHNAFJMLZnMfWTRTCQ/4GcPWro5oThTV0vDGY+GjugtfprdZA
 UObpFO64SEriemyPjtFfNmQHZSF6jBoXuv1PRiSquaJUayoglzNLxW6RN8ip1FxtwfRz
 +wnrud83OxAq4nw4ooTpKeGh/5O/MyU2psfVdwHs59GyAWuR3cVY1FMKf4vD64Fdrc0i
 HZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sSLs3el2OyWbVsEn+pD70NcssOBrvqEsumretpeL3Ds=;
 b=sBGeHSGyzghaKaoIcHj2lKg3PmVvpXNt2Q5ib77ZlIrVT1VjJkWt4t2ayou3eTBdcf
 2Q7q60TGcXDnWtXs12sOryLb5SV3hgn7tGIRAPhJMcedV2cDvp959yV90AtwB/lQsJ52
 YKnEMN8/C1JhJjnBIHXZ44c4ONdB5WJJjYMBMbuh9KkZN1o8NRQaaIoztYLMDVEP0Ho3
 oB/fzI4/il3qhqXsF3zHpC3Cw1tOsvZpJL1G84iYHRYeZ3LGwhCPNC4hS6JOCHf9XYnx
 RkXL6tm/Bu/AN8dfP1+Gyl5Yx4i14MnQLQMiqM5gIt74A+YMAYHQdht1ELwhqBWeO1B6
 7dEw==
X-Gm-Message-State: AOAM532e5ej1DTOD3HwtUnuUfmNnjTqmX+R7OJgPiZ0PD2qnXU+JVooU
 8Is5L7TGejP261wwf6sIia2nZw==
X-Google-Smtp-Source: ABdhPJzf2xI6CL5550HyBIRa+NGoE6q+KpGaJ+iPNinF9nAS2FLtnIDT4CYD4RyhkJ/F4l+Sgz8yFg==
X-Received: by 2002:a5d:6744:: with SMTP id l4mr4577899wrw.378.1604699408431; 
 Fri, 06 Nov 2020 13:50:08 -0800 (PST)
Received: from dell.default ([91.110.221.236])
 by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 13:50:07 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 12/19] drm/amd/display/dc/basics/fixpt31_32: Move variables to
 where they're used
Date: Fri,  6 Nov 2020 21:49:42 +0000
Message-Id: <20201106214949.2042120-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106214949.2042120-1-lee.jones@linaro.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 06 Nov 2020 21:52:20 +0000
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

QWxzbyByaWQgc29tZSB1bnVzZWQgb25lcy4KClRoaXMgcGF0Y2ggc29sdmVzIDIwMDAgd2Fybmlu
Z3MhCgpGaXhlcyB0aGUgZm9sbG93aW5nIFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKCiBJ
biBmaWxlIGluY2x1ZGVkIGZyb20gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxh
eS9kYy9kY190eXBlcy5oOjMzLAogZnJvbSBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9k
aXNwbGF5L2RjL2RtX3NlcnZpY2VzX3R5cGVzLmg6MzAsCiBmcm9tIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZG1fc2VydmljZXMuaDozNSwKIGZyb20gZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2hlbHBlcnMu
YzozNToKIEF0IHRvcCBsZXZlbDoKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3Bs
YXkvaW5jbHVkZS9maXhlZDMxXzMyLmg6NzY6MzI6IHdhcm5pbmc6IOKAmGRjX2ZpeHB0X2xuMl9k
aXZfMuKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQog
NzYgfCBzdGF0aWMgY29uc3Qgc3RydWN0IGZpeGVkMzFfMzIgZGNfZml4cHRfbG4yX2Rpdl8yID0g
eyAxNDg4NTIyMjM2TEwgfTsKIHwgXn5+fn5+fn5+fn5+fn5+fn5+CiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS8uLi9kaXNwbGF5L2luY2x1ZGUvZml4ZWQzMV8zMi5oOjc1OjMyOiB3YXJuaW5n
OiDigJhkY19maXhwdF9sbjLigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0
LXZhcmlhYmxlPV0KIDc1IHwgc3RhdGljIGNvbnN0IHN0cnVjdCBmaXhlZDMxXzMyIGRjX2ZpeHB0
X2xuMiA9IHsgMjk3NzA0NDQ3MUxMIH07CiB8IF5+fn5+fn5+fn5+fgogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvLi4vZGlzcGxheS9pbmNsdWRlL2ZpeGVkMzFfMzIuaDo3NDozMjogd2Fybmlu
Zzog4oCYZGNfZml4cHRfZeKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtY29uc3Qt
dmFyaWFibGU9XQogNzQgfCBzdGF0aWMgY29uc3Qgc3RydWN0IGZpeGVkMzFfMzIgZGNfZml4cHRf
ZSA9IHsgMTE2NzQ5MzE1NTVMTCB9OwogfCBefn5+fn5+fn5+CiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS8uLi9kaXNwbGF5L2luY2x1ZGUvZml4ZWQzMV8zMi5oOjczOjMyOiB3YXJuaW5nOiDi
gJhkY19maXhwdF90d29fcGnigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0
LXZhcmlhYmxlPV0KIDczIHwgc3RhdGljIGNvbnN0IHN0cnVjdCBmaXhlZDMxXzMyIGRjX2ZpeHB0
X3R3b19waSA9IHsgMjY5ODYwNzU0MDlMTCB9OwogfCBefn5+fn5+fn5+fn5+fn4KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvaW5jbHVkZS9maXhlZDMxXzMyLmg6NzI6MzI6
IHdhcm5pbmc6IOKAmGRjX2ZpeHB0X3Bp4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNl
ZC1jb25zdC12YXJpYWJsZT1dCiA3MiB8IHN0YXRpYyBjb25zdCBzdHJ1Y3QgZml4ZWQzMV8zMiBk
Y19maXhwdF9waSA9IHsgMTM0OTMwMzc3MDVMTCB9OwogfCBefn5+fn5+fn5+fgoKQ2M6IEhhcnJ5
IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpDYzogTGVvIExpIDxzdW5wZW5nLmxp
QGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNj
OiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlk
IEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZnds
bC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxp
bmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jhc2ljcy9maXhw
dDMxXzMyLmMgfCA1ICsrKysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5jbHVkZS9m
aXhlZDMxXzMyLmggICB8IDYgLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvYmFzaWNzL2ZpeHB0MzFfMzIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9iYXNpY3MvZml4cHQzMV8zMi5jCmluZGV4IDFlOWEyZDM1MjA2ODQuLjU5ZjM3NTYzNzA0YWQg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iYXNpY3MvZml4cHQz
MV8zMi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iYXNpY3MvZml4cHQz
MV8zMi5jCkBAIC0yNiw2ICsyNiwxMSBAQAogI2luY2x1ZGUgImRtX3NlcnZpY2VzLmgiCiAjaW5j
bHVkZSAiaW5jbHVkZS9maXhlZDMxXzMyLmgiCiAKK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZml4ZWQz
MV8zMiBkY19maXhwdF9waSA9IHsgMTM0OTMwMzc3MDVMTCB9Oworc3RhdGljIGNvbnN0IHN0cnVj
dCBmaXhlZDMxXzMyIGRjX2ZpeHB0X3R3b19waSA9IHsgMjY5ODYwNzU0MDlMTCB9Oworc3RhdGlj
IGNvbnN0IHN0cnVjdCBmaXhlZDMxXzMyIGRjX2ZpeHB0X2xuMiA9IHsgMjk3NzA0NDQ3MUxMIH07
CitzdGF0aWMgY29uc3Qgc3RydWN0IGZpeGVkMzFfMzIgZGNfZml4cHRfbG4yX2Rpdl8yID0geyAx
NDg4NTIyMjM2TEwgfTsKKwogc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIGxvbmcgYWJzX2k2
NCgKIAlsb25nIGxvbmcgYXJnKQogewpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2luY2x1ZGUvZml4ZWQzMV8zMi5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2luY2x1ZGUvZml4ZWQzMV8zMi5oCmluZGV4IDE2ZGYyYTQ4NWRkMGQuLjIyMDUzZDdlYTZjZWQg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9pbmNsdWRlL2ZpeGVkMzFf
MzIuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5jbHVkZS9maXhlZDMxXzMy
LmgKQEAgLTY5LDEyICs2OSw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZml4ZWQzMV8zMiBkY19m
aXhwdF9lcHNpbG9uID0geyAxTEwgfTsKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZml4ZWQzMV8zMiBk
Y19maXhwdF9oYWxmID0geyAweDgwMDAwMDAwTEwgfTsKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZml4
ZWQzMV8zMiBkY19maXhwdF9vbmUgPSB7IDB4MTAwMDAwMDAwTEwgfTsKIAotc3RhdGljIGNvbnN0
IHN0cnVjdCBmaXhlZDMxXzMyIGRjX2ZpeHB0X3BpID0geyAxMzQ5MzAzNzcwNUxMIH07Ci1zdGF0
aWMgY29uc3Qgc3RydWN0IGZpeGVkMzFfMzIgZGNfZml4cHRfdHdvX3BpID0geyAyNjk4NjA3NTQw
OUxMIH07Ci1zdGF0aWMgY29uc3Qgc3RydWN0IGZpeGVkMzFfMzIgZGNfZml4cHRfZSA9IHsgMTE2
NzQ5MzE1NTVMTCB9Owotc3RhdGljIGNvbnN0IHN0cnVjdCBmaXhlZDMxXzMyIGRjX2ZpeHB0X2xu
MiA9IHsgMjk3NzA0NDQ3MUxMIH07Ci1zdGF0aWMgY29uc3Qgc3RydWN0IGZpeGVkMzFfMzIgZGNf
Zml4cHRfbG4yX2Rpdl8yID0geyAxNDg4NTIyMjM2TEwgfTsKLQogLyoKICAqIEBicmllZgogICog
SW5pdGlhbGl6YXRpb24gcm91dGluZXMKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
