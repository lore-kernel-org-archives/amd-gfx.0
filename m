Return-Path: <SRS0=xvO7=5P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62692C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 13:55:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34C93206CC
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 13:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHxR3+Cm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C93206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8535D6E394;
	Mon, 30 Mar 2020 13:55:42 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B31A6E394;
 Mon, 30 Mar 2020 13:55:41 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id z18so20059470wmk.2;
 Mon, 30 Mar 2020 06:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=BrBZ7BRIxlz8FrRAnyr/unjtGHr0zUbPTL3/EC4XXLw=;
 b=FHxR3+CmB08xFviRye1G+JE6uJS+aVUQ+HGmBoGEOxVSCBH1R7G/rVrH+3LzxpOh8X
 cNvv34kxVcoeYeuYX1Sjbmk6IniCJzuJG09GT4H1fy/YCV23WnhcuvPFgMBQeBHGuOT0
 zk4f82Ys62ZOEWqotuYDYUc034pNzw6iSNgO43UIwcQcckbDp706FK5h86+PUVk0mpAX
 KLYSexJP6X0q+xQk6K5QWAv21f3SBF2cStG82X/5abm2+tSkD2COOtjqdxMGQ0lCy4fk
 3P3IoMFeKzhzVZE2Q2AzyNAGxBHbbyzU2UAmVf+JYAaGdbmm3B8ev/xDQ+7PQZsS2GN3
 uUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BrBZ7BRIxlz8FrRAnyr/unjtGHr0zUbPTL3/EC4XXLw=;
 b=I7Xa+jOEWjTHe0qFSnGNYsmoMQxPCY3AZDTpU6ap+QUxkprpk23XqFn/C1yR5mNCkk
 lmfzQRmophzbBnbWIHmVrUzjSrzBxVHw0+GKE7EHeoDhxnzB0Q5sptkBXaXy3EpRyYKw
 yBYIAwg0mM9+CUAlABKg5ByWLvCBclL/i0dzFq1NKYeCACpbCkEoHuQLF5XKix3+1ipe
 n36ZaaOK9sn0XR/jCYUluHS74/RnXYhpYcK4cDGAZpXtQGKu4CmDCxLFSNf0fSwCQM09
 NldnpKOmGJ2RhjileGIkVEPC03HwoL4VatMU4B+JB6L/7j55Xz7NEiIsFUKf1XvpTwg0
 jOKQ==
X-Gm-Message-State: ANhLgQ09J/p1izP2GN2c4LTSrFT/BQDEAnQ/yr+Z1jhJAOH9/DrTrYyZ
 Cjr7dvJfAHdN3Z7hY3+uTKKn/SSX
X-Google-Smtp-Source: ADFU+vuruoydc/AyUasIYTsDVtsd4JpfCw26dFnNvIY4EMT7MMlQVcQZoO3j8Kjwch1dI8UTN10ocw==
X-Received: by 2002:a1c:5604:: with SMTP id k4mr12727395wmb.57.1585576539573; 
 Mon, 30 Mar 2020 06:55:39 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:f999:5819:bfe0:10e8])
 by smtp.gmail.com with ESMTPSA id z16sm22267660wrr.56.2020.03.30.06.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 06:55:39 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 daniel@ffwll.ch
Subject: [PATCH 4/6] drm/amdgpu: add checks if DMA-buf P2P is supported
Date: Mon, 30 Mar 2020 15:55:34 +0200
Message-Id: <20200330135536.2997-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200330135536.2997-1-christian.koenig@amd.com>
References: <20200330135536.2997-1-christian.koenig@amd.com>
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

Q2hlY2sgaWYgd2UgY2FuIGRvIHBlZXIycGVlciBvbiB0aGUgUENJZSBidXMuCgpTaWduZWQtb2Zm
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYuYyB8IDQgKysrKwogMSBmaWxl
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZG1hX2J1Zi5jCmluZGV4IGFlZjEyZWUyZjFlMy4uYmJmNjc4MDBjOGE2IDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZG1hX2J1Zi5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMKQEAgLTM4LDYgKzM4LDcg
QEAKICNpbmNsdWRlIDxkcm0vYW1kZ3B1X2RybS5oPgogI2luY2x1ZGUgPGxpbnV4L2RtYS1idWYu
aD4KICNpbmNsdWRlIDxsaW51eC9kbWEtZmVuY2UtYXJyYXkuaD4KKyNpbmNsdWRlIDxsaW51eC9w
Y2ktcDJwZG1hLmg+CiAKIC8qKgogICogYW1kZ3B1X2dlbV9wcmltZV92bWFwIC0gJmRtYV9idWZf
b3BzLnZtYXAgaW1wbGVtZW50YXRpb24KQEAgLTE3OSw2ICsxODAsOSBAQCBzdGF0aWMgaW50IGFt
ZGdwdV9kbWFfYnVmX2F0dGFjaChzdHJ1Y3QgZG1hX2J1ZiAqZG1hYnVmLAogCXN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2ID0gYW1kZ3B1X3R0bV9hZGV2KGJvLT50Ym8uYmRldik7CiAJaW50IHI7
CiAKKwlpZiAocGNpX3AycGRtYV9kaXN0YW5jZV9tYW55KGFkZXYtPnBkZXYsICZhdHRhY2gtPmRl
diwgMSwgdHJ1ZSkgPCAwKQorCQlhdHRhY2gtPnBlZXIycGVlciA9IGZhbHNlOworCiAJaWYgKGF0
dGFjaC0+ZGV2LT5kcml2ZXIgPT0gYWRldi0+ZGV2LT5kcml2ZXIpCiAJCXJldHVybiAwOwogCi0t
IAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
