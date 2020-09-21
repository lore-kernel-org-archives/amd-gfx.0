Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34B3C47095
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 21:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BFF82067D
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 21:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+2XnZ24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BFF82067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D41286E57A;
	Mon, 21 Sep 2020 21:20:41 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 172336E08C
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 21:20:39 +0000 (UTC)
Received: by mail-qk1-x72f.google.com with SMTP id w12so16829855qki.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 14:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n2gELhikrqOjNAck+5+9l8iqIzFvBNEZi1YbTxk35rQ=;
 b=r+2XnZ24Jh97t1CJKIH05gwa2bq+WMsziolOYWbXQX4X7ae84Z0UrKkoaRljxOmlC/
 dBH8MSG8C/Y49vJJiip48+0mDiT38KmglfYIXFfWKZJLy/oDlce5VVFkpEjiH7yIfzU8
 PX2Z2ozKW6FANxZ7KYG/mzrTrHsb2+F/JF7x+8wcd23LvymqdXp/qJCtplic+hJ2+d2n
 f/MPfP8rB4npLwW9et7gYToLwEsWAyG8hU5SRUvnujgM8CtMtj4vEBbLUb+W152TOk3p
 3ScEw1IJSrb/9lU+Ujw0Vnkm9WJVckoPwcD2ETpfbcX3r3am41SbUp7pY3/MqXzgyg8a
 EU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n2gELhikrqOjNAck+5+9l8iqIzFvBNEZi1YbTxk35rQ=;
 b=A5DkEj5XEGmgMLhKa5hb7WFnFZ3qK4P9dUHY0u6DvtBUvYz93uzCewekN7shPc91GQ
 MbLnOxblEgPI4FA27/O3lwAkWm9NQte8M7+hjLQjbhMon/K4KCjT1yfve3IclNbARt+f
 mhi0dL69Kd5CtPN/le/IqR9GmCrTmlWq8Yd+XkTB+BE6I8s8KOroC4dO/DO4LUnDk6UX
 DGOf/5oKDIFMKQO/ZCfK8xLoLUpVoe4qAczth24bfHSvIZ2tj05fnWQfnjsK7MVChXXF
 wS32F+EILFTe4Qsnu8Z+E+Lb194uefKvjlh4QqrhAbafDVbrnzVjwW9fsGrFZY0XftjB
 X0PQ==
X-Gm-Message-State: AOAM530f7PvLT9T7vZIY72sNO0KGvAcHq9VHPfTGucfEI2eOA/98g5ZT
 ZyKNhysqlfBfUMsfqaxERJtoadtvq6A=
X-Google-Smtp-Source: ABdhPJyn9yQgtisqkHo5OGzY9g78YPL3QNNJXsAdDcXrQZyLs27AnLKnSDF7GQApsNd32fNX32OX/Q==
X-Received: by 2002:ae9:ed86:: with SMTP id c128mr1652973qkg.277.1600723233968; 
 Mon, 21 Sep 2020 14:20:33 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id o35sm10790829qte.23.2020.09.21.14.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 14:20:33 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: fix wanting in print statement
Date: Mon, 21 Sep 2020 17:20:26 -0400
Message-Id: <20200921212026.364094-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vYW1ka2ZkL2tmZF9jcmF0LmM6IEluIGZ1bmN0
aW9uIOKAmGtmZF9jcmVhdGVfY3JhdF9pbWFnZV92aXJ0dWFs4oCZOgpkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS8uLi9hbWRrZmQva2ZkX2NyYXQuYzoxMzkxOjEyOiB3YXJuaW5nOiBmb3JtYXQg
4oCYJWTigJkgZXhwZWN0cyBhcmd1bWVudCBvZiB0eXBlIOKAmGludOKAmSwgYnV0IGFyZ3VtZW50
IDMgaGFzIHR5cGUg4oCYc2l6ZV904oCZIHtha2Eg4oCYbG9uZyB1bnNpZ25lZCBpbnTigJl9IFst
V2Zvcm1hdD1dCiAxMzkxIHwgICBwcl9kZWJ1ZygiQ1JBVCBzaXplIGlzICVkIiwgZHluX3NpemUp
OwogICAgICB8ICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn4KLi9pbmNsdWRlL2xpbnV4L3By
aW50ay5oOjI5NzoyMTogbm90ZTogaW4gZGVmaW5pdGlvbiBvZiBtYWNybyDigJhwcl9mbXTigJkK
ICAyOTcgfCAjZGVmaW5lIHByX2ZtdChmbXQpIGZtdAogICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgXn5+Ci4vaW5jbHVkZS9saW51eC9keW5hbWljX2RlYnVnLmg6MTQzOjI6IG5vdGU6IGluIGV4
cGFuc2lvbiBvZiBtYWNybyDigJhfX2R5bmFtaWNfZnVuY19jYWxs4oCZCiAgMTQzIHwgIF9fZHlu
YW1pY19mdW5jX2NhbGwoX19VTklRVUVfSUQoZGRlYnVnKSwgZm10LCBmdW5jLCAjI19fVkFfQVJH
U19fKQogICAgICB8ICBefn5+fn5+fn5+fn5+fn5+fn5+Ci4vaW5jbHVkZS9saW51eC9keW5hbWlj
X2RlYnVnLmg6MTUzOjI6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhfZHluYW1pY19m
dW5jX2NhbGzigJkKICAxNTMgfCAgX2R5bmFtaWNfZnVuY19jYWxsKGZtdCwgX19keW5hbWljX3By
X2RlYnVnLCAgXAogICAgICB8ICBefn5+fn5+fn5+fn5+fn5+fn4KLi9pbmNsdWRlL2xpbnV4L3By
aW50ay5oOjQyMDoyOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYZHluYW1pY19wcl9k
ZWJ1Z+KAmQogIDQyMCB8ICBkeW5hbWljX3ByX2RlYnVnKGZtdCwgIyNfX1ZBX0FSR1NfXykKICAg
ICAgfCAgXn5+fn5+fn5+fn5+fn5+fgpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9hbWRr
ZmQva2ZkX2NyYXQuYzoxMzkxOjM6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhwcl9k
ZWJ1Z+KAmQogMTM5MSB8ICAgcHJfZGVidWcoIkNSQVQgc2l6ZSBpcyAlZCIsIGR5bl9zaXplKTsK
ICAgICAgfCAgIF5+fn5+fn5+CmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2FtZGtmZC9r
ZmRfY3JhdC5jOjEzOTE6Mjc6IG5vdGU6IGZvcm1hdCBzdHJpbmcgaXMgZGVmaW5lZCBoZXJlCiAx
MzkxIHwgICBwcl9kZWJ1ZygiQ1JBVCBzaXplIGlzICVkIiwgZHluX3NpemUpOwogICAgICB8ICAg
ICAgICAgICAgICAgICAgICAgICAgICB+XgogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfAogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50CiAgICAgIHwgICAgICAg
ICAgICAgICAgICAgICAgICAgICVsZAoKU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4
YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9jcmF0LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYwppbmRleCBjNTBlOWY2MzRk
NmMuLmQyOTgxNTI0ZGJhMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX2NyYXQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5jCkBA
IC0xMzg4LDcgKzEzODgsNyBAQCBpbnQga2ZkX2NyZWF0ZV9jcmF0X2ltYWdlX3ZpcnR1YWwodm9p
ZCAqKmNyYXRfaW1hZ2UsIHNpemVfdCAqc2l6ZSwKIAkJaWYgKCFwY3JhdF9pbWFnZSkKIAkJCXJl
dHVybiAtRU5PTUVNOwogCQkqc2l6ZSA9IGR5bl9zaXplOwotCQlwcl9kZWJ1ZygiQ1JBVCBzaXpl
IGlzICVkIiwgZHluX3NpemUpOworCQlwcl9kZWJ1ZygiQ1JBVCBzaXplIGlzICVsZCIsIGR5bl9z
aXplKTsKIAkJcmV0ID0ga2ZkX2NyZWF0ZV92Y3JhdF9pbWFnZV9jcHUocGNyYXRfaW1hZ2UsIHNp
emUpOwogCQlicmVhazsKIAljYXNlIENPTVBVVEVfVU5JVF9HUFU6Ci0tIAoyLjI1LjQKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
