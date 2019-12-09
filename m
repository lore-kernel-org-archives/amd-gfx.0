Return-Path: <SRS0=Fyns=Z7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E211CC43603
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 21:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B058920637
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 21:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B058920637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C19F6E546;
	Mon,  9 Dec 2019 21:58:32 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78A976E546
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2019 21:56:14 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id g206so997971wme.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Dec 2019 13:56:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bY1WC1Ap+RU1tAgITP3/KP7SqhN1U6Otqj4eWIMWLi4=;
 b=D0TkRY3Fe6EPtDK0KCmvFnZi336/T9BedmC6x0xsoiC1azRr50gT+cepkhEifWHwkr
 qwA/LaMhuecF4DJbHaiGPEu+5QuViLdb9f+ICthVkyumgI9fTbQV9RQccAGKHNlhon7j
 PBkdV5msqXXD9uJmdDic6vV4op/dKD/T2/bbGVUCsBtHiP/gbmnOmlDx7323sJLoHzt5
 tCryKlrXpUTX6bc8dR0aidkQOEovB1foN0AV5mMAb4VvIdgAQIsrR7NeDBZbwpI4bcZH
 Vko4I+EIQv0g5CRtqQ8ifw4krwQpVYWkjfnfdkQxMrBDmlFxhCv3qcWLoYY1JdQMm0IG
 0S2Q==
X-Gm-Message-State: APjAAAXyDARSmCMHbReCwHOGcioyQ+0mFcdZjlu6VGM5ImmTPEOnjrnh
 DwXqacFM6kISc6rjz2eV3Eo=
X-Google-Smtp-Source: APXvYqx94s7QRSGOpmJ2nMmOybsZmzlStIIPE1mQy8EpqYUWKyxDkY93EGThsy9Wz87icoxiXD3n3g==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr1192013wmi.166.1575928573020; 
 Mon, 09 Dec 2019 13:56:13 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F24F900E0D452C076B49924.dip0.t-ipconnect.de.
 [2003:c5:8f24:f900:e0d4:52c0:76b4:9924])
 by smtp.gmail.com with ESMTPSA id z11sm778062wrt.82.2019.12.09.13.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 13:56:12 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: alexander.deucher@amd.com,
	kenny.ho@amd.com,
	christian.koenig@amd.com
Subject: [PATCH 4/4] drm/scheduler: do not keep a copy of sched list
Date: Mon,  9 Dec 2019 22:53:49 +0100
Message-Id: <20191209215349.26994-4-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209215349.26994-1-nirmoy.das@amd.com>
References: <20191209215349.26994-1-nirmoy.das@amd.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 09 Dec 2019 21:58:32 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bY1WC1Ap+RU1tAgITP3/KP7SqhN1U6Otqj4eWIMWLi4=;
 b=BwP+fUTI8DmsFbDLGuYv7lkn522pwB1mC7GvSvfP3tNV1g+0zG/T0OEPZhHgvQFGTA
 UH7RkGlFPv2IsJadk1xplcOQ46LisNkxoFyk7nRFLaK2JtWCZI02x61+LbzECkZjixAY
 d9cs4fIYjzhtgeCF54wGLkcoQsxF+ino8Y/2dOcHY+LA6BH5B4Xts/t6ruF2fqfNtW7u
 n8ZgEhv56T3eElDVSBUkQ2aY3gmrR+rnhHLtVGGXe5KSduosutG5398/UAHUWvKhK6Q9
 N5aE70+04tVBU0n+Xm38jACUPzqVRRWrQFFmTB1k4M105Abi8GU5FJECCqe++t7E1q46
 FSIw==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
dHNlbGYuCgpTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYyB8IDEwICstLS0tLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgOSBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jIGIvZHJpdmVy
cy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwppbmRleCBmOWI2Y2UyOWM1OGYuLmE1
ZjcyOWY0MjFmOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9l
bnRpdHkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jCkBA
IC02NywxNyArNjcsMTAgQEAgaW50IGRybV9zY2hlZF9lbnRpdHlfaW5pdChzdHJ1Y3QgZHJtX3Nj
aGVkX2VudGl0eSAqZW50aXR5LAogCWVudGl0eS0+Z3VpbHR5ID0gZ3VpbHR5OwogCWVudGl0eS0+
bnVtX3NjaGVkX2xpc3QgPSBudW1fc2NoZWRfbGlzdDsKIAllbnRpdHktPnByaW9yaXR5ID0gcHJp
b3JpdHk7Ci0JZW50aXR5LT5zY2hlZF9saXN0ID0gIGtjYWxsb2MobnVtX3NjaGVkX2xpc3QsCi0J
CQkJICAgICAgc2l6ZW9mKHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqKSwgR0ZQX0tFUk5FTCk7
CisJZW50aXR5LT5zY2hlZF9saXN0ID0gIHNjaGVkX2xpc3Q7CiAKLQlpZighZW50aXR5LT5zY2hl
ZF9saXN0KQotCQlyZXR1cm4gLUVOT01FTTsKIAogCWluaXRfY29tcGxldGlvbigmZW50aXR5LT5l
bnRpdHlfaWRsZSk7Ci0KLQlmb3IgKGkgPSAwOyBpIDwgbnVtX3NjaGVkX2xpc3Q7IGkrKykKLQkJ
ZW50aXR5LT5zY2hlZF9saXN0W2ldID0gc2NoZWRfbGlzdFtpXTsKLQogCWlmIChudW1fc2NoZWRf
bGlzdCkKIAkJZW50aXR5LT5ycSA9ICZlbnRpdHktPnNjaGVkX2xpc3RbMF0tPnNjaGVkX3JxW2Vu
dGl0eS0+cHJpb3JpdHldOwogCkBAIC0zMTIsNyArMzA1LDYgQEAgdm9pZCBkcm1fc2NoZWRfZW50
aXR5X2Zpbmkoc3RydWN0IGRybV9zY2hlZF9lbnRpdHkgKmVudGl0eSkKIAogCWRtYV9mZW5jZV9w
dXQoZW50aXR5LT5sYXN0X3NjaGVkdWxlZCk7CiAJZW50aXR5LT5sYXN0X3NjaGVkdWxlZCA9IE5V
TEw7Ci0Ja2ZyZWUoZW50aXR5LT5zY2hlZF9saXN0KTsKIH0KIEVYUE9SVF9TWU1CT0woZHJtX3Nj
aGVkX2VudGl0eV9maW5pKTsKIAotLSAKMi4yNC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZng=
