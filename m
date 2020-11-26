Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A269C2D0E4
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:15:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B606420674
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p/G/xj32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B606420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D12336EC0D;
	Fri, 27 Nov 2020 10:15:07 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D35C6E957
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 13:43:05 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id x22so2180785wmc.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 05:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4AJIopnyfhF0y4BTkzIBWxHJHanpp5V1ikes9pxc/Xc=;
 b=p/G/xj32n4i/rb4oTibOM955Wb2c2JuAT8/JEPsK6Cet/M6nBAM0aqReY56K/J5Et7
 amy2F2/m374sjvAeSfHZ8NLJgd13zRPeaQUlDXgMF1RhJwaEI4iiddP5r//znBH0/s5c
 TiI6Okc/1wVVTlo3aEA7Hw5I/qlTKkG4SUsXYGRMPQSpCLbvg3c/N5Zp05LXoZUmogOx
 Q4vmRAs7ruIFA1BW/PIWhKhEpRtw0Sd1GVCt9I66oXJHblxbu+IPgisDe2ydduSg6sI2
 AG33/49mDz/9ILeFURIg75jJR2NGWpP06Mlv6OdF08VX9CNy61y0qHqdhlQcX05y+4yZ
 1gOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4AJIopnyfhF0y4BTkzIBWxHJHanpp5V1ikes9pxc/Xc=;
 b=YYajgwnCLeMG+xUwvyMuL7b0HRueK9u12LZuSBEno58BcNyqMtMGa603W1Gm4pJv2z
 uE6aCwtp6WhXKixREIv1tJ5FHYq2RpAK9r9jZLcxrHbazjP029wv4G7iMtZHPct5fotD
 5vehTpE+HRqfXWMhv8wASsndO0xuqjO2f/zIhj3uVKx1XmiTVX71ONUcjbl+Rtrs7TIl
 RWo0oT9diYPFxscyTkpRcYt307IPsD2p9GRLwYn0QUzB+es3pfd6jBBxUD5pXwzuX2Lg
 krittATuKwiVfcO+S233R2HEmcfDB9L1bvG7ryP+j51JHSRzyK3f8hEi0q4b1PUNI2oI
 Lr5Q==
X-Gm-Message-State: AOAM530HdcKQh9pZ8eTZ98h/eC53d8Ti8FnKjsNkX6kbVZR4GnyY+90P
 IdAGRAlxtc36S+5WlQUErRTJJQ==
X-Google-Smtp-Source: ABdhPJzsbr1E7lN9PNWNLgjwKyJigQPxpav65eXlV0+KrkMgaazvVNZF2wODZ0Otr3NRGQHQfQJMCw==
X-Received: by 2002:a7b:cf0a:: with SMTP id l10mr3530508wmg.103.1606398182874; 
 Thu, 26 Nov 2020 05:43:02 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 05:43:02 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 11/40] drm/amd/pm/powerplay/hwmgr/ppevvmath: Place variable
 declaration under same clause as its use
Date: Thu, 26 Nov 2020 13:42:11 +0000
Message-Id: <20201126134240.3214176-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 27 Nov 2020 10:14:32 +0000
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
 Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL3BwZXZ2bWF0aC5oOiBJ
biBmdW5jdGlvbiDigJhmTXVsdGlwbHnigJk6CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8u
Li9wbS9wb3dlcnBsYXkvaHdtZ3IvcHBldnZtYXRoLmg6MzM2OjIyOiB3YXJuaW5nOiB2YXJpYWJs
ZSDigJhZX0xlc3NUaGFuT25l4oCZIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQt
dmFyaWFibGVdCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9wbS9wb3dlcnBsYXkvaHdt
Z3IvcHBldnZtYXRoLmg6MzM2Ojc6IHdhcm5pbmc6IHZhcmlhYmxlIOKAmFhfTGVzc1RoYW5PbmXi
gJkgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KCkNjOiBFdmFu
IFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0
dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpD
YzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9u
ZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93
ZXJwbGF5L2h3bWdyL3BwZXZ2bWF0aC5oIHwgNiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvcHBldnZtYXRoLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL3Bvd2VycGxheS9od21nci9wcGV2dm1hdGguaAppbmRleCA4ZjUwYTAzODM5NmNlLi5kYWMy
OWZlNmNmYzZmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9o
d21nci9wcGV2dm1hdGguaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9o
d21nci9wcGV2dm1hdGguaApAQCAtMzMzLDE0ICszMzMsMTQgQEAgc3RhdGljIGZJbnQgZk11bHRp
cGx5IChmSW50IFgsIGZJbnQgWSkgLyogVXNlcyA2NC1iaXQgaW50ZWdlcnMgKGludDY0X3QpICov
CiB7CiAJZkludCBQcm9kdWN0OwogCWludDY0X3QgdGVtcFByb2R1Y3Q7CisKKwkvKlRoZSBmb2xs
b3dpbmcgaXMgZm9yIGEgdmVyeSBzcGVjaWZpYyBjb21tb24gY2FzZTogTm9uLXplcm8gbnVtYmVy
IHdpdGggT05MWSBmcmFjdGlvbmFsIHBvcnRpb24qLworCS8qIFRFTVBPUkFSSUxZIERJU0FCTEVE
IC0gQ0FOIEJFIFVTRUQgVE8gSU1QUk9WRSBQUkVDSVNJT04KIAlib29sIFhfTGVzc1RoYW5PbmUs
IFlfTGVzc1RoYW5PbmU7CiAKIAlYX0xlc3NUaGFuT25lID0gKFgucGFydGlhbC5yZWFsID09IDAg
JiYgWC5wYXJ0aWFsLmRlY2ltYWwgIT0gMCAmJiBYLmZ1bGwgPj0gMCk7CiAJWV9MZXNzVGhhbk9u
ZSA9IChZLnBhcnRpYWwucmVhbCA9PSAwICYmIFkucGFydGlhbC5kZWNpbWFsICE9IDAgJiYgWS5m
dWxsID49IDApOwogCi0JLypUaGUgZm9sbG93aW5nIGlzIGZvciBhIHZlcnkgc3BlY2lmaWMgY29t
bW9uIGNhc2U6IE5vbi16ZXJvIG51bWJlciB3aXRoIE9OTFkgZnJhY3Rpb25hbCBwb3J0aW9uKi8K
LQkvKiBURU1QT1JBUklMWSBESVNBQkxFRCAtIENBTiBCRSBVU0VEIFRPIElNUFJPVkUgUFJFQ0lT
SU9OCi0KIAlpZiAoWF9MZXNzVGhhbk9uZSAmJiBZX0xlc3NUaGFuT25lKSB7CiAJCVByb2R1Y3Qu
ZnVsbCA9IFguZnVsbCAqIFkuZnVsbDsKIAkJcmV0dXJuIFByb2R1Y3QKLS0gCjIuMjUuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
