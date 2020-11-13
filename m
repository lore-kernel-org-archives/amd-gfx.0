Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2654AC388F7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 14:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B099620715
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 14:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="it1slg7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B099620715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 036996E595;
	Fri, 13 Nov 2020 14:28:21 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A57576E50D
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 13:49:46 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id d12so9946746wrr.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 05:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UkvWdURTsPkEdVDzyHJ8FYZlYEKq+y0hj/4CtFCIFp4=;
 b=it1slg7eKp4pW5KEZ7vtYMFSfeU183JFhubZH/qEBglZ8gc2voRRHBhujz3X936q5b
 +GVVysYWqybRxo9yD89WDkhMwxfHo+LuchKiHgoHcQ2gJXPV/7HRRVeubA2tSXQLAMfG
 mC6diUMtNPUA5UQGKuOoJO6KrBaduJmWWbiEgMT+hiqY2Kw+zDp5BYifY7RIm46ASjr0
 SWkmDqmf5q9w1Tto3DKwzzdWjTRTdYhNAqyfztmrvvWgN7II9jiaKHa4vOBjygqNu3PK
 EILFa43AKAy6VL+b1aQ7cXSAeiKoyOthV07rLPzm+JcX2NASAGhGdm8fWoR7AP6OFQk+
 rkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UkvWdURTsPkEdVDzyHJ8FYZlYEKq+y0hj/4CtFCIFp4=;
 b=f7ZRU+Gn5/+QHL5ncRNfiAFWyDKhILq9c0fqzZ1Tt1mkg8uU0wBfhqvKRljZfNuwNp
 aBTmeMTipxEiQYb95QTDkwNVX86TVNowBnHHK7qY7M0pfppvY0gSQXTkyBTu36xcYerR
 Z/OXno1sJKYdIOrOjNcNbc70gqrEwFW5DeKIFxI1o2Bwi+pc8FVVhOpz4CFmheHx9RZq
 Et8h6fqUJcrPko53yTvItNLg2RgcNb/89I5M61z8KZI/avCiGYU6YHG2yqLw7aGY5SrO
 4hZGT8xcXIpILcchO7Nz6GYrVowYGchhjsS39XhG+pfNNbWzh3NBKvA1+JXNhHqG9hTP
 5JgQ==
X-Gm-Message-State: AOAM530tENHtr/KGiqjmjHJYG43+yNZIE7vQyFXDhQZ4LEfW+nC4Lgnk
 tBDQeZqe3pNIFhlCupU5jda6pA==
X-Google-Smtp-Source: ABdhPJxnNPMHkiRv4CvlSdVHRyP+EPDWdkVMC26JII0l+dTlSjh9rvGeHvEsOFiDMueCPHdGDTu2Bg==
X-Received: by 2002:adf:f852:: with SMTP id d18mr3463400wrq.232.1605275385374; 
 Fri, 13 Nov 2020 05:49:45 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2020 05:49:44 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 02/40] drm/amd/display/dc/core/dc_link_dp: Move
 DP_VGA_LVDS_CONVERTER_ID_{2, 3} to where they're used
Date: Fri, 13 Nov 2020 13:49:00 +0000
Message-Id: <20201113134938.4004947-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 13 Nov 2020 14:28:19 +0000
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

VGhpcyBwYXRjaCBmaXhlcyA+MjAwIHdhcm5pbmdzLgoKRml4ZXMgdGhlIGZvbGxvd2luZyBXPTEg
a2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4v
ZGlzcGxheS9pbmNsdWRlL2RkY19zZXJ2aWNlX3R5cGVzLmg6MTIzOjIyOiB3YXJuaW5nOiDigJhE
UF9WR0FfTFZEU19DT05WRVJURVJfSURfM+KAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVz
ZWQtY29uc3QtdmFyaWFibGU9XQogMTIzIHwgc3RhdGljIGNvbnN0IHVpbnQ4X3QgRFBfVkdBX0xW
RFNfQ09OVkVSVEVSX0lEXzNbXSA9ICJkbm9tbEEiOwogfCBefn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fgogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9pbmNsdWRlL2RkY19z
ZXJ2aWNlX3R5cGVzLmg6MTIxOjIyOiB3YXJuaW5nOiDigJhEUF9WR0FfTFZEU19DT05WRVJURVJf
SURfMuKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQog
MTIxIHwgc3RhdGljIGNvbnN0IHVpbnQ4X3QgRFBfVkdBX0xWRFNfQ09OVkVSVEVSX0lEXzJbXSA9
ICJzaXZhclQiOwoKTkI6IFJlcGVhdGVkIH4xMDAgdGltZXMgLSBzbmlwcGVkIGZvciBicmV2aXR5
CgpDYzogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CkNjOiBMZW8gTGkg
PHN1bnBlbmcubGlAYW1kLmNvbT4KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
PgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8
ZGFuaWVsQGZmd2xsLmNoPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRy
aS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxs
ZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
Y29yZS9kY19saW5rX2RwLmMgICAgICAgIHwgNSArKysrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2luY2x1ZGUvZGRjX3NlcnZpY2VfdHlwZXMuaCB8IDQgLS0tLQogMiBmaWxlcyBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jCmluZGV4IDZjNjBjMWZkZWJkYzEu
LmYyMDIzZDJiNTMyMzQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9jb3JlL2RjX2xpbmtfZHAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
Y29yZS9kY19saW5rX2RwLmMKQEAgLTE1LDYgKzE1LDExIEBACiAjaW5jbHVkZSAiZGNfZG11Yl9z
cnYuaCIKICNpbmNsdWRlICJkY2UvZG11Yl9od19sb2NrX21nci5oIgogCisvKlRyYXZpcyovCitz
dGF0aWMgY29uc3QgdWludDhfdCBEUF9WR0FfTFZEU19DT05WRVJURVJfSURfMltdID0gInNpdmFy
VCI7CisvKk51dG1lZyovCitzdGF0aWMgY29uc3QgdWludDhfdCBEUF9WR0FfTFZEU19DT05WRVJU
RVJfSURfM1tdID0gImRub21sQSI7CisKICNkZWZpbmUgRENfTE9HR0VSIFwKIAlsaW5rLT5jdHgt
PmxvZ2dlcgogI2RlZmluZSBEQ19UUkFDRV9MRVZFTF9NRVNTQUdFKC4uLikgLyogZG8gbm90aGlu
ZyAqLwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2luY2x1ZGUvZGRj
X3NlcnZpY2VfdHlwZXMuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9pbmNsdWRlL2Rk
Y19zZXJ2aWNlX3R5cGVzLmgKaW5kZXggYzliZTg5OWNkMjVjZC4uYjQ1M2NlNWE5YmZkYiAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2luY2x1ZGUvZGRjX3NlcnZpY2Vf
dHlwZXMuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5jbHVkZS9kZGNfc2Vy
dmljZV90eXBlcy5oCkBAIC0xMTcsMTAgKzExNyw2IEBAIHN0cnVjdCBhdl9zeW5jX2RhdGEgewog
CXVpbnQ4X3QgYXVkX2RlbF9pbnMzOy8qIERQQ0QgMDAwMkRoICovCiB9OwogCi0vKlRyYXZpcyov
Ci1zdGF0aWMgY29uc3QgdWludDhfdCBEUF9WR0FfTFZEU19DT05WRVJURVJfSURfMltdID0gInNp
dmFyVCI7Ci0vKk51dG1lZyovCi1zdGF0aWMgY29uc3QgdWludDhfdCBEUF9WR0FfTFZEU19DT05W
RVJURVJfSURfM1tdID0gImRub21sQSI7CiAvKkRQIHRvIER1YWwgbGluayBEVkkgY29udmVydGVy
Ki8KIHN0YXRpYyBjb25zdCB1aW50OF90IERQX0RWSV9DT05WRVJURVJfSURfNFtdID0gIm0yRFZJ
YSI7CiBzdGF0aWMgY29uc3QgdWludDhfdCBEUF9EVklfQ09OVkVSVEVSX0lEXzVbXSA9ICIzMzkz
TjIiOwotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
