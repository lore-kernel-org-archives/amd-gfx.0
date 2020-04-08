Return-Path: <SRS0=b+Zp=5Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B9CC2D0EA
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 10:16:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CD220768
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 10:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+VY5MSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CD220768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBABF6EA0F;
	Wed,  8 Apr 2020 10:16:45 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2BEA6EA0F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2020 10:16:44 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id g3so7202217wrx.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Apr 2020 03:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1odKwxsTBI8HAAGJmQ3IR1QZsq/gska3qAOD42lIe5w=;
 b=h+VY5MSWycSlSE1bzDKCNAfDwkoTfH60D0UY7CuO6bn3uA56BvUbeLxn3ShLkafzbf
 u7qNJmz/Z3TpoWGqhHr1sUCn3gh0wgrlD1muN6Rwo3mXoQ3mNKSkZcSjaIl7lOqO51e9
 TRxqEHIqcAqfho3fmViKOl/LbGWj32bS9FGjK5nYSuxp/sF/RG8Aa94+ptU+uhA8U7Kl
 3oLhrLCiKIqyC/ndNg2DccRrHy6lHJlNspwcdy7mKhfKuZVkggq0ZonMSdXimdYEoJ/D
 N7BA1hgFs6N3tNLDnxXAVlrEvReIEfmEqQZp51T4wyQLPdvF5D92dU+JoszoYWfuKIO4
 JD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1odKwxsTBI8HAAGJmQ3IR1QZsq/gska3qAOD42lIe5w=;
 b=i74V1Qm9QO/eJCtETZ1sZzBya2r1PxXzJHgta8Mp5p2MOUn/qaYk/xAu4i0nJWCytj
 +sah4HxrnH8dI4LHhiGsXtOeymc5y9SOyomj7NM0lZWlmLzCTgjT7QhpBh7wkZ3ScmRZ
 sv5/+yRh2dXVWPdQuSLfo+sSyVIqOlEkmESWQ/G1TnPiDsROnS4qNCHJR0W+vaQrYt1T
 xYwd+nwp8rC1w06nyRGHrQ7xG4CS16/T8ss47ruC9I3Y2OO+fauy1k39GsicnmUiOabD
 jum1YePv1PZ6CPn+kFKNN5UBUXMW9oBw72wQqw6isFqBf3VucGKIvsgaAi5bemmvE5Es
 6Oew==
X-Gm-Message-State: AGi0PubNwERFtpNuBRVXBR1gnBH1PtGaihE8Uab/40yttFQ+EGUcGZMz
 RjD1X1g4SERe23IRRDd7PZ1DV9qZ
X-Google-Smtp-Source: APiQypI1A0zn1Fh9jdP+g2zPzEHtwrU1h6hX/+bm80Mb4kFZMxZPYxHpUFQGTMLBIkL0Rnp2MtNgIw==
X-Received: by 2002:adf:9022:: with SMTP id h31mr7464887wrh.223.1586341003402; 
 Wed, 08 Apr 2020 03:16:43 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:d1f8:fbcb:ad4:2be4])
 by smtp.gmail.com with ESMTPSA id o9sm30254960wru.29.2020.04.08.03.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2020 03:16:42 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: kent.russell@amd.com, john.clements@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix out of bounds memcpy
Date: Wed,  8 Apr 2020 12:16:42 +0200
Message-Id: <20200408101642.30788-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
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

VGhlIGJ1ZmZlciBuZWVkcyB0byBiZSB0d28gYnl0ZXMgbGFyZ2VyIHdoZW4gdGhlIG1heGltdW0g
aXMgMzIuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZydV9lZXBy
b20uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVw
cm9tLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5jCmlu
ZGV4IDlkMTc3NjE3MjFkZS4uYzdlNTVmZTE3MGJkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9tLmMKQEAgLTg1LDcgKzg1LDcgQEAgaW50IGFtZGdw
dV9mcnVfcmVhZF9lZXByb20oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IGFk
ZHJwdHIsCiAKIGludCBhbWRncHVfZnJ1X2dldF9wcm9kdWN0X2luZm8oc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpCiB7Ci0JdW5zaWduZWQgY2hhciBidWZmWzMyXTsKKwl1bnNpZ25lZCBjaGFy
IGJ1ZmZbMzRdOwogCWludCBhZGRycHRyID0gMCwgc2l6ZSA9IDA7CiAKIAlpZiAoIWlzX2ZydV9l
ZXByb21fc3VwcG9ydGVkKGFkZXYpKQotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
