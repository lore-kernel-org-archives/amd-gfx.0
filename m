Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D83C2D0DB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 14:03:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD6B2465A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 14:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcaTPstI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD6B2465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE9116F52C;
	Wed, 22 Jan 2020 14:03:07 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 447966F52C
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 14:03:06 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id g17so7414669wro.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 06:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2FW+X0FSjRoOwMnWBNM4Xbfb+wlovndM1OopS3nHEjw=;
 b=WcaTPstIC0U+hYOcKG2/L0R+CBdYEVg2eqmkZkAwwqJjZJxyK06Q3cnlZPATtRlzYQ
 9efSnUrel2hanByCVRFHl9pfvOXEFXK+cARJjjVbNx0ie8r/nnlP8OjNCaCXahpWWhyN
 fk/ovwjQaqsH1oaqnavH7rUA8j2qIRWUCGSMkbd6f2CrhoKtbz4qKDhnD/vU6MFrtRdx
 +R4oR7USbOlgpqLUKy3TY5YnBiI9JzsbbsHl0kg+MzcV5CqZ6jpajHQHYDWxweI1E0L7
 PZxfjn136WVTB4hp6WUuJvs8ZMVRvCUvpBMsc2jYH2PDZfWMZWe36CdZi33kL6LlBA0j
 6QIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2FW+X0FSjRoOwMnWBNM4Xbfb+wlovndM1OopS3nHEjw=;
 b=FGkd5Uvs+JDAcWjPSl8+gLgEWGKRMjikHnGTm5PiPTPLV4N+ajmTYVDj2gkqrg1E/Q
 /S9J8pp6TxKEaZZveArsSNUSIOTWuhn4DDUoZTnDU6Rx/NJ3YzloG0ph/4BwftEKPu2A
 o6tnDi8UsOEysx1UXp06m/YLM+u+CCewiD13oHyR9A2l2Uri9S9LO0jFDxIioVvhAw+L
 dlcF0ibSXiKDg1a4eRYghkmE4Ssj1hw3D2lQZfUplCe/rhvALeBf9P4NfmvCNW3YiAu+
 a9zK+5lbD4Z5rVkUmeK/rS7/fthvmMJG6Tfor3RCUh/BHiYCabqxTUPsB/H3a/DugumV
 dUjA==
X-Gm-Message-State: APjAAAUBlowt3xX2G9+G7Yh5HmG3u5CS8WA1eZZAQF7WzC8rPtxCWHec
 QNmKdJHZ+clCP/Z5yy8a6eUEAFXK
X-Google-Smtp-Source: APXvYqxQR4L+FzsDrTNDwWiS0yFnRrrbUqyhgefV+msbbCfNgizGYNFFNINhOIqcLFs8519nXgfA0Q==
X-Received: by 2002:adf:f28c:: with SMTP id k12mr11796489wro.360.1579701784976; 
 Wed, 22 Jan 2020 06:03:04 -0800 (PST)
Received: from baker.fritz.box ([2a02:908:1252:fb60:5cf5:1960:5408:ec4f])
 by smtp.gmail.com with ESMTPSA id c195sm4701806wmd.45.2020.01.22.06.03.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 22 Jan 2020 06:03:04 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: tom.stdenis@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: return EINVAL instead of ENOENT in the VM code
Date: Wed, 22 Jan 2020 15:03:02 +0100
Message-Id: <20200122140303.14411-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.14.1
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

VGhhdCB3ZSBjYW4ndCBmaW5kIGEgUEQgYWJvdmUgdGhlIHJvb3QgaXMgZXhwZWN0ZWQgY2FuIG9u
bHkgaGFwcGVuIGlmCndlIHRyeSB0byB1cGRhdGUgYSBsYXJnZXIgcmFuZ2UgdGhhbiBhY3R1YWxs
eSBtYW5hZ2VkIGJ5IHRoZSBWTS4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdm0uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKaW5kZXggNWNiMTgy
MjMxZjVkLi44MTE5ZjMyY2E5NGQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jCkBAIC0xNDc1LDcgKzE0NzUsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV91cGRhdGVfcHRl
cyhzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnBhcmFtcywKIAkJCSAqIHNoaWZ0IHdl
IHNob3VsZCBnbyB1cCBvbmUgbGV2ZWwgYW5kIGNoZWNrIGl0IGFnYWluLgogCQkJICovCiAJCQlp
ZiAoIWFtZGdwdV92bV9wdF9hbmNlc3RvcigmY3Vyc29yKSkKLQkJCQlyZXR1cm4gLUVOT0VOVDsK
KwkJCQlyZXR1cm4gLUVJTlZBTDsKIAkJCWNvbnRpbnVlOwogCQl9CiAKLS0gCjIuMTQuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
