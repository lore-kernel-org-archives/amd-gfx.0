Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077D7C5DF60
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 23:10:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F0C206DF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 23:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F0C206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A10C26EB82;
	Tue,  5 Nov 2019 23:10:51 +0000 (UTC)
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6B5D6E165
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 22:58:11 +0000 (UTC)
Received: by mail-io1-xd44.google.com with SMTP id q83so3467437iod.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Nov 2019 14:58:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wbzRqvc8FvWk5sR5KGdavxWwldxvQh4qHgl2mJoTxrs=;
 b=i3vHMQjz4/3vU4p0KAMZFp3x9KIjSQDKKKaQUpiVKqLTopS0KYOR0LnNAihKjxMila
 GNFYTQcQNqdf8a/dTKnnS7KlN1rO8W5JtlNaUDwhH5zaFXy6Gw9u6MjGuFSluYsXA+jN
 j+IU5IF+EGl6H/OySKfEHo8KS2x2xKOkfntfNMtZ1QKbPNHPmlPyAi4zda746bhffdgA
 nt25B2aKKK0GUi8gxn1FkcbTZkjeffv8DuPyKGFgIwtD2pvc0VcRtkyoflphRh6mSMub
 4TWmotaofwzPhm8U4R5JaDlBAt5v3oVAJ3Gtg0qfwFK/pkTtVQ8pejGEBtfpqOvF6hvA
 Lbfg==
X-Gm-Message-State: APjAAAXZ39Gqr6CD5T8nj4X1afoTTVSvBKsiJXjTLzTZck6YTtgwO33S
 K1w6K2NNAuRPqrD6G2x+DMjNJA==
X-Google-Smtp-Source: APXvYqx6XmtvqfERYm4mk+w5mZ3zxi4aVxOq3gZEKoAHqSgi4r3FR4hhxOQ8lCOIGxmzgBNdCQ7Gog==
X-Received: by 2002:a5e:9e49:: with SMTP id j9mr31748458ioq.170.1572994691162; 
 Tue, 05 Nov 2019 14:58:11 -0800 (PST)
Received: from localhost ([2620:15c:183:0:82e0:aef8:11bc:24c4])
 by smtp.gmail.com with ESMTPSA id w75sm3229673ill.78.2019.11.05.14.58.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2019 14:58:10 -0800 (PST)
From: Raul E Rangel <rrangel@chromium.org>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amd/powerplay: fix struct init in renoir_print_clk_levels
Date: Tue,  5 Nov 2019 15:58:02 -0700
Message-Id:
 <20191105155734.1.If8740b4a5095031f2c00746fbc3224be9849d76b@changeid>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 05 Nov 2019 23:10:49 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wbzRqvc8FvWk5sR5KGdavxWwldxvQh4qHgl2mJoTxrs=;
 b=d07BWnCDYPq9AbOnFZh2cQnq7+WxNalVgk1NTA6PdAf0WHN3tNd9j7t7pDoGQ+hGhu
 LaAnphcRnalev4XUEeyJhexhL9HhsSJ9+mrPtIw4cYe2l/QTd8wotEDPQpAXy4WC/C1E
 S57U277pgztnLd2YvzPT08RDIr+xTsZMDxepI=
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Raul E Rangel <rrangel@chromium.org>,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Evan Quan <evan.quan@amd.com>, Rex Zhu <rex.zhu@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105225802.dIT63XDVO5h4f-2zl4FhI5pdkxIThvXu-KeHqqgMH1s@z>

ZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvcmVub2lyX3BwdC5jOjE4NjoyOiBlcnJvcjog
bWlzc2luZyBicmFjZXMKYXJvdW5kIGluaXRpYWxpemVyIFstV2Vycm9yPW1pc3NpbmctYnJhY2Vz
XQogIFNtdU1ldHJpY3NfdCBtZXRyaWNzID0gezB9OwogICAgXgoKRml4ZXM6IDhiODAzMTcwM2Jk
NyAoImRybS9hbWQvcG93ZXJwbGF5OiBpbXBsZW1lbnQgc3lzZnMgZm9yIGdldHRpbmcgZHBtIGNs
b2NrIikKClNpZ25lZC1vZmYtYnk6IFJhdWwgRSBSYW5nZWwgPHJyYW5nZWxAY2hyb21pdW0ub3Jn
PgotLS0KCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9yZW5vaXJfcHB0LmMgfCA0ICsr
Ky0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9yZW5vaXJfcHB0LmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9yZW5vaXJfcHB0LmMKaW5kZXggZTYyYmZiYTUxNTYy
Li5lNTI4M2RhZmM0MTQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L3Jlbm9pcl9wcHQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9yZW5vaXJf
cHB0LmMKQEAgLTE4MywxMSArMTgzLDEzIEBAIHN0YXRpYyBpbnQgcmVub2lyX3ByaW50X2Nsa19s
ZXZlbHMoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsCiAJaW50IGksIHNpemUgPSAwLCByZXQgPSAw
OwogCXVpbnQzMl90IGN1cl92YWx1ZSA9IDAsIHZhbHVlID0gMCwgY291bnQgPSAwLCBtaW4gPSAw
LCBtYXggPSAwOwogCURwbUNsb2Nrc190ICpjbGtfdGFibGUgPSBzbXUtPnNtdV90YWJsZS5jbG9j
a3NfdGFibGU7Ci0JU211TWV0cmljc190IG1ldHJpY3MgPSB7MH07CisJU211TWV0cmljc190IG1l
dHJpY3M7CiAKIAlpZiAoIWNsa190YWJsZSB8fCBjbGtfdHlwZSA+PSBTTVVfQ0xLX0NPVU5UKQog
CQlyZXR1cm4gLUVJTlZBTDsKIAorCW1lbXNldCgmbWV0cmljcywgMCwgc2l6ZW9mKG1ldHJpY3Mp
KTsKKwogCXJldCA9IHNtdV91cGRhdGVfdGFibGUoc211LCBTTVVfVEFCTEVfU01VX01FVFJJQ1Ms
IDAsCiAJCQkgICAgICAgKHZvaWQgKikmbWV0cmljcywgZmFsc2UpOwogCWlmIChyZXQpCi0tIAoy
LjI0LjAucmMxLjM2My5nYjFiY2NkM2UzZC1nb29nCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZng=
