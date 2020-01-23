Return-Path: <SRS0=UzQs=3M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E2CC2D0DB
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2020 14:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14FF820663
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2020 14:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvhArfNX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FF820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0E7E6FD10;
	Thu, 23 Jan 2020 14:21:26 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC64F6FD09
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jan 2020 14:21:25 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id f129so2729526wmf.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jan 2020 06:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2FW+X0FSjRoOwMnWBNM4Xbfb+wlovndM1OopS3nHEjw=;
 b=lvhArfNXxpIfsCoAwPZoSM3FOqGr3DxIkeLY8Rp7nUawx190q3xw1rxJ/N4Im8CA+0
 wMvJ5EgaugC9oZkLR/EqURWX9Xvt7GxuH0GyIr0dL2DNtZAHV+y2+x/Axw18IXtdnjrd
 QplnH/4iTcdWjGQRu9aOxSeeDWLA4Rzg2jbhDszsu20MiDMeWtK1qof6lJFvYLC57spi
 gCWeBKqcsFlo4gTpTeWm/te4puL2bBEMSOAHVI+MmQP+eEYvPdwjJyapt6XHjx1pC9CJ
 2SaznUh9bLFNQ+KE22dsanZVtdPBN812az0Yg4jV9ZZKVmRl7sdCFkHserDRNsSg7GRA
 Zv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2FW+X0FSjRoOwMnWBNM4Xbfb+wlovndM1OopS3nHEjw=;
 b=KqgKukRnBbdD6zgLPmbFlz3QZq8CzZ+Au7bjcjQTW5AJ21XqNu3CN58QtiwnrFk+q2
 OIsri3jBsRxolvYqHEiUfS/5yknc+uCaNic4Fl1ZlYuid5rVy2nBjn+uVNJxPZE008zW
 6hGkPUEitXa1t+OCcxliGjn2mOMJZJuvXVc96/7d77jvCbDbTfS9e6C0ZDfR3jyTznEM
 8UXkkkAtqh1LaG6Rye9Jn7pgZ7TGY15U5e9uStX6ynpJYaBvJm6Me/3822Br+Db+o8cV
 F/zSWHzZzwcj+baPhTGb3atq/CmibGDsvZLaEScbMZ9GyUBrMnxf/zxH3TxjGcpC2Cyt
 ykqw==
X-Gm-Message-State: APjAAAWUjrEWG2bA2ysMQmvquZkUwpoHZFsPj5DvQHhiWF8OwdgHER9h
 4gb8CcrmJ9s5acSGWc1OYc4=
X-Google-Smtp-Source: APXvYqyxrjAr3aFxW2hyXZjkn/EYeOPoS1sclW6mz2hTN9hrOwmtgmo6EvxvB8ubZRnj0UI3A+rGQw==
X-Received: by 2002:a7b:c3cf:: with SMTP id t15mr4363875wmj.135.1579789284593; 
 Thu, 23 Jan 2020 06:21:24 -0800 (PST)
Received: from baker.fritz.box ([2a02:908:1252:fb60:4c9d:da69:4490:b03e])
 by smtp.gmail.com with ESMTPSA id w19sm2713286wmc.22.2020.01.23.06.21.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 06:21:24 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: tom.stdenis@amd.com, amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com
Subject: [PATCH 1/4] drm/amdgpu: return EINVAL instead of ENOENT in the VM code
Date: Thu, 23 Jan 2020 15:21:19 +0100
Message-Id: <20200123142122.4084-1-christian.koenig@amd.com>
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
