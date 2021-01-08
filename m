Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95BAC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A542399C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A542399C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B836E8FC;
	Fri,  8 Jan 2021 20:24:22 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB3796E8D8
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 20:15:36 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id c5so10131255wrp.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 12:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/no+Onyy5XrK9PB3hyGhFGC7i5BsGoibiINOqxq12AQ=;
 b=ojEBT5RsN2ItOnq+5hnf27mTpPMgt5HIEpJPbKe+3Zbl9lekg8pVMBTuRv540cHs4Q
 Tb786eVXAWGOwbyelL9uKyuNmGa2SyOXXZFPpId6DC9pDz0zEMopFAyEsoGH9Ko0N6/b
 Ub3sMjADxRs1gr0OfoAQdrQrlnoMCYbktSRB6O+/21I/8I2BC9Veblt10uMGncXyY+No
 Utiitfn6+E8oKxjbI2NCxpWw2s3r7b48u/BQRDA47oZtG8HDS+NQlWzlrgr1yJQi3VA2
 PmwuWx0kJpmQT4Rrwft9zA9na/2WeMHyt4gmXpnyipPfAYTPgrVoNsLJRxgqx71P8V8a
 8isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/no+Onyy5XrK9PB3hyGhFGC7i5BsGoibiINOqxq12AQ=;
 b=AOOn6eUu+QUODTc7YGsxbDTx6WG2YnjbwUWSWfAxtaJozW6j9EUIWR9BaxGECHOVh8
 opRXraeaW3zjjPXwCctyqJTm8EKawInwNyBukL3kOqoMeQ/G7ik+4RYJdUARdWeaoK7b
 W853H0fHx/FjFlw9JkuL0Un1Rob2v2FlOmyue4Upo4yPTxoehmC1e/B+BPsS2+1kjOGM
 Fm/rRiApmUScW/PI4kktm2NrGG7DjmBWPEpI84hyeAGP76OX2DvIIE/ZdezbakwM8JGV
 LggQeAS6ujBxuYZmsr528TLJIEFFKWM9kIzW98lP3JpBi/4iAmElxEzksDYNhjEq7BBb
 iOWw==
X-Gm-Message-State: AOAM530vP4+zAnqieunoWuDDUCwHrrZUgDgHhBR0Mk5XPIB3GN41ayzL
 2OkhxGpQoINqjzYe4RizAQD/BA==
X-Google-Smtp-Source: ABdhPJxBa92KrsZVIK1LY24dJwGdRNWWQc0vmXVcqMyHxxA2+D+ZCFZLY5GuplgbRG10CXzdo5bl5g==
X-Received: by 2002:a5d:44c6:: with SMTP id z6mr5259451wrr.306.1610136935433; 
 Fri, 08 Jan 2021 12:15:35 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 12:15:34 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 21/40] drm/amd/display/dc/calcs/dce_calcs: Remove unused
 variables 'v_filter_init_mode' and 'sclk_lvl'
Date: Fri,  8 Jan 2021 20:14:38 +0000
Message-Id: <20210108201457.3078600-22-lee.jones@linaro.org>
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

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jYWxjcy9kY2VfY2FsY3MuYzogSW4g
ZnVuY3Rpb24g4oCYY2FsY3VsYXRlX2JhbmR3aWR0aOKAmToKIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvY2FsY3MvZGNlX2NhbGNzLmM6MTA5OjE4OiB3YXJuaW5nOiB2
YXJpYWJsZSDigJh2X2ZpbHRlcl9pbml0X21vZGXigJkgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVz
ZWQtYnV0LXNldC12YXJpYWJsZV0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3Bs
YXkvZGMvY2FsY3MvZGNlX2NhbGNzLmM6IEluIGZ1bmN0aW9uIOKAmGJ3X2NhbGNz4oCZOgogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jYWxjcy9kY2VfY2FsY3MuYzoz
MDMxOjIxOiB3YXJuaW5nOiB2YXJpYWJsZSDigJhzY2xrX2x2bOKAmSBzZXQgYnV0IG5vdCB1c2Vk
IFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQoKQ2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53
ZW50bGFuZEBhbWQuY29tPgpDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+CkNjOiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5p
ZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBs
aW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
ClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NhbGNzL2RjZV9jYWxjcy5jIHwgOCArLS0tLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jYWxjcy9kY2VfY2FsY3MuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jYWxjcy9kY2VfY2FsY3MuYwppbmRleCBl
ZjQxYjI4N2NiZTIzLi4xNThkOTI3YzAzZTU1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvY2FsY3MvZGNlX2NhbGNzLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2NhbGNzL2RjZV9jYWxjcy5jCkBAIC0xMDYsNyArMTA2LDYgQEAgc3RhdGlj
IHZvaWQgY2FsY3VsYXRlX2JhbmR3aWR0aCgKIAlib29sIGxwdF9lbmFibGVkOwogCWVudW0gYndf
ZGVmaW5lcyBzY2xrX21lc3NhZ2U7CiAJZW51bSBid19kZWZpbmVzIHljbGtfbWVzc2FnZTsKLQll
bnVtIGJ3X2RlZmluZXMgdl9maWx0ZXJfaW5pdF9tb2RlW21heGltdW1fbnVtYmVyX29mX3N1cmZh
Y2VzXTsKIAllbnVtIGJ3X2RlZmluZXMgdGlsaW5nX21vZGVbbWF4aW11bV9udW1iZXJfb2Zfc3Vy
ZmFjZXNdOwogCWVudW0gYndfZGVmaW5lcyBzdXJmYWNlX3R5cGVbbWF4aW11bV9udW1iZXJfb2Zf
c3VyZmFjZXNdOwogCWVudW0gYndfZGVmaW5lcyB2b2x0YWdlOwpAQCAtNzkyLDEyICs3OTEsOCBA
QCBzdGF0aWMgdm9pZCBjYWxjdWxhdGVfYmFuZHdpZHRoKAogCQkJCWRhdGEtPnZfZmlsdGVyX2lu
aXRbaV0gPSBid19hZGQoZGF0YS0+dl9maWx0ZXJfaW5pdFtpXSwgYndfaW50X3RvX2ZpeGVkKDEp
KTsKIAkJCX0KIAkJCWlmIChkYXRhLT5zdGVyZW9fbW9kZVtpXSA9PSBid19kZWZfdG9wX2JvdHRv
bSkgewotCQkJCXZfZmlsdGVyX2luaXRfbW9kZVtpXSA9IGJ3X2RlZl9tYW51YWw7CiAJCQkJZGF0
YS0+dl9maWx0ZXJfaW5pdFtpXSA9IGJ3X21pbjIoZGF0YS0+dl9maWx0ZXJfaW5pdFtpXSwgYndf
aW50X3RvX2ZpeGVkKDQpKTsKIAkJCX0KLQkJCWVsc2UgewotCQkJCXZfZmlsdGVyX2luaXRfbW9k
ZVtpXSA9IGJ3X2RlZl9hdXRvOwotCQkJfQogCQkJaWYgKGRhdGEtPnN0ZXJlb19tb2RlW2ldID09
IGJ3X2RlZl90b3BfYm90dG9tKSB7CiAJCQkJZGF0YS0+bnVtX2xpbmVzX2F0X2ZyYW1lX3N0YXJ0
ID0gYndfaW50X3RvX2ZpeGVkKDEpOwogCQkJfQpAQCAtMzAyOCw3ICszMDIzLDcgQEAgYm9vbCBi
d19jYWxjcyhzdHJ1Y3QgZGNfY29udGV4dCAqY3R4LAogCQljYWxjc19vdXRwdXQtPmFsbF9kaXNw
bGF5c19pbl9zeW5jID0gZmFsc2U7CiAKIAlpZiAoZGF0YS0+bnVtYmVyX29mX2Rpc3BsYXlzICE9
IDApIHsKLQkJdWludDhfdCB5Y2xrX2x2bCwgc2Nsa19sdmw7CisJCXVpbnQ4X3QgeWNsa19sdmw7
CiAJCXN0cnVjdCBid19maXhlZCBoaWdoX3NjbGsgPSB2Ymlvcy0+aGlnaF9zY2xrOwogCQlzdHJ1
Y3QgYndfZml4ZWQgbWlkMV9zY2xrID0gdmJpb3MtPm1pZDFfc2NsazsKIAkJc3RydWN0IGJ3X2Zp
eGVkIG1pZDJfc2NsayA9IHZiaW9zLT5taWQyX3NjbGs7CkBAIC0zMDQ5LDcgKzMwNDQsNiBAQCBi
b29sIGJ3X2NhbGNzKHN0cnVjdCBkY19jb250ZXh0ICpjdHgsCiAJCWNhbGN1bGF0ZV9iYW5kd2lk
dGgoZGNlaXAsIHZiaW9zLCBkYXRhKTsKIAogCQl5Y2xrX2x2bCA9IGRhdGEtPnlfY2xrX2xldmVs
OwotCQlzY2xrX2x2bCA9IGRhdGEtPnNjbGtfbGV2ZWw7CiAKIAkJY2FsY3Nfb3V0cHV0LT5uYnBf
c3RhdGVfY2hhbmdlX2VuYWJsZSA9CiAJCQlkYXRhLT5uYnBfc3RhdGVfY2hhbmdlX2VuYWJsZTsK
LS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
