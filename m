Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD54C388F9
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 13:58:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA9ED22243
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 13:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QU62DjTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9ED22243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C62836ECB5;
	Tue,  3 Nov 2020 13:58:46 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1618A6ECB5
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 13:58:45 +0000 (UTC)
Received: by mail-ej1-x642.google.com with SMTP id gn41so6937063ejc.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2020 05:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=QoRi/aEnWFTR/RFO7JjpoYPXeUAKGjMHX/MTBwj/eHs=;
 b=QU62DjTvoNuCy8V5m1Acxc4le26XCQeyU6DRWPbsZoU5lNUVOoFJT7fNRc93xjbZKi
 OAXq2LBFoi2FWGxAaqfskbMbwGafJ4CfCSvu54ycunZwLhCpox3EinbzRYWjytx0PMua
 qMiCpcV+dcN6d8x3hf58F59sGgdXNem+lwXJM8F8juSWjvyM5CwtNInKRmClhB/v+bFz
 05p2shM6LqTKPbEpKxfTTY8PX0PEMQSBLL9oG9Sv3W10dkX+wavH8/GEFmtcE0Y1S8TP
 eKreGS5kh8EVjDdRcVr5ZIBOBws4dOE2MYLl/ZiM2YiT2KzKiSFiieROr8sn1BMx2iky
 INeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QoRi/aEnWFTR/RFO7JjpoYPXeUAKGjMHX/MTBwj/eHs=;
 b=QvSe154RKlUAwM3JxAMT3dngRFXcuFMq7FfWuumslvLPRvRqBfeTJuDUh1MCL51xzf
 DcKHW/KRo54e0Mj+tNwFadknRgQfw/e0ECVQQLWT2ljeMHpGL3hO6hXjj7MWbcBNsj+I
 0Wlb4OndCAExbqIeRtIK2IfIHXE3ai4xDwV6AzBALyqwHnHjvUXbOgjrzmZcXBUGuBan
 dKv0QMAPtblPPldxYWzbMjiECtSiY/uinJMsyAbEIE8K+VjZ5wvJitrM5w/O5zSaS2WU
 8ASgEhF99odcHVT0wPVTjA8JHxgR0r5benogNTwaxmYhzyyXDO1HpudqksbN1eTGvurI
 lDaA==
X-Gm-Message-State: AOAM532VsvhRFhE7cHDvyxRIeggkFbcFTEZxkVlHjA5TY44nqbswDzGQ
 +ypum4Q0/UvpSxXOuAn/ICPDu+O0Lqc=
X-Google-Smtp-Source: ABdhPJxq+ByZdfsgkDPjgGKvTdoiWNnc0Zihz43VYsysuqpVRgEwrlrd3kOkJUNrtZrxbeStTObsJA==
X-Received: by 2002:a17:906:a0cb:: with SMTP id
 bh11mr20931349ejb.314.1604411923543; 
 Tue, 03 Nov 2020 05:58:43 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:f3a2:b920:33f3:da11])
 by smtp.gmail.com with ESMTPSA id j6sm7903263edy.87.2020.11.03.05.58.42
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 05:58:43 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/8] drm/amdgpu: enabled software IH ring for Navi
Date: Tue,  3 Nov 2020 14:58:36 +0100
Message-Id: <20201103135837.39693-7-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103135837.39693-1-christian.koenig@amd.com>
References: <20201103135837.39693-1-christian.koenig@amd.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RmVsaXggcG9pbnRlZCBvdXQgdGhhdCB3ZSBuZWVkIHRoaXMgZm9yIE5hdmkgYXMgd2VsbC4KClNp
Z25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYXZpMTBfaWguYyB8IDcgKysrKysrKwog
MSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L25hdmkxMF9paC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
bmF2aTEwX2loLmMKaW5kZXggODM3NzY5ZmNiMzViLi5jZTBhMDJhNGI1ZDkgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25hdmkxMF9paC5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L25hdmkxMF9paC5jCkBAIC0xMzYsNiArMTM2LDkgQEAgc3RhdGljIHZv
aWQgbmF2aTEwX2loX2VuYWJsZV9pbnRlcnJ1cHRzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQogCQl9CiAJCWFkZXYtPmlycS5paDIuZW5hYmxlZCA9IHRydWU7CiAJfQorCisJaWYgKGFkZXYt
PmlycS5paF9zb2Z0LnJpbmdfc2l6ZSkKKwkJYWRldi0+aXJxLmloX3NvZnQuZW5hYmxlZCA9IHRy
dWU7CiB9CiAKIC8qKgpAQCAtNjk1LDYgKzY5OCwxMCBAQCBzdGF0aWMgaW50IG5hdmkxMF9paF9z
d19pbml0KHZvaWQgKmhhbmRsZSkKIAkJCQkJKGFkZXYtPmRvb3JiZWxsX2luZGV4LmloICsgMikg
PDwgMTsKIAl9CiAKKwlyID0gYW1kZ3B1X2loX3JpbmdfaW5pdChhZGV2LCAmYWRldi0+aXJxLmlo
X3NvZnQsIFBBR0VfU0laRSwgdHJ1ZSk7CisJaWYgKHIpCisJCXJldHVybiByOworCiAJciA9IGFt
ZGdwdV9pcnFfaW5pdChhZGV2KTsKIAogCXJldHVybiByOwotLSAKMi4yNS4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
