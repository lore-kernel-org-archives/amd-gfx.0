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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29144C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 10:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE7D2205ED
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 10:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kE6uRyh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7D2205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA0D96E11D;
	Mon, 30 Mar 2020 10:50:39 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4DCD6E11D
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2020 10:50:38 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id u10so20999365wro.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2020 03:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=EybpGQhcwTEzZW/sLd148FJ1boM3MavSaWmk2rf0G/c=;
 b=kE6uRyh8ubZy3z+Q2wncEfSDaQE2lT2Qjn2hMi7JuBG9YuU63boC0K8SGunaMftP9f
 P2/XK6GvpTm/qerIA30pd9pvIPeYQGE1hyHvOmxtJ6uMbKPZW/smE9XVNTwIEsTJE/mx
 csNClr8JkSrSERI+X1kLRInQ3gs7h5oeS3uOibrdJjMag9Lfcii6W+lIAsNW4gbgOsP3
 r9EqZQDzkjWmAelb56YmQCNb0Jzp2mCPYrtIdkiK0dqiYHQ2pIOUQMghyOADF870cxDN
 NbZfjXW6ZFPJdguAIDa1P1/PmpVHJ9axNf8e7ydtL5fpyUFiUp4rQZube4tEDr8CY5ZN
 zv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EybpGQhcwTEzZW/sLd148FJ1boM3MavSaWmk2rf0G/c=;
 b=i3ipMOQWZYkV/fQgPa9uxzOLt8KOd1r/RSgdv2NmrV5ESYUr7q8IM/kk5ybZGytyBM
 sRP+4FJMvmP9hUkQhXCIcpZxMfw8jzhSZjAy0fqwfEeAScOjCzKel6uamFZJKMzGOV1j
 pcleXI086u6ATLhNbiU4plMnlp65GtLlyiLQUH5+fSd1GPi1Oh/HqZkO4saJXpNCDez3
 4G0zF93qbc9o3ZyWfDD57YrrqRe0yuJd9Y7WaijVMP/MfuXlXWzruL0G5jsa/BF+iNFn
 mvjENHMftxkeSwS/gRWS2iFYWqjzmSayC7z5bMJQaXM4rvGx3+n+1XsSOSPGc/n/Zvbt
 fPRA==
X-Gm-Message-State: ANhLgQ2FtZPIb8q1T2+HFydBIIKHPrnP5SrihnQYCZ8dEzA5KsGwFkcu
 9mhw48IL0lXjKertNtBxTnmkXAiu
X-Google-Smtp-Source: ADFU+vs8DCaB0D9zeG+3Y2mjFDkzZnva6kN2BghPNmxQbfR6/X3NRkFhxHQqNwY7HkdZPoKEtqRfYg==
X-Received: by 2002:a5d:518b:: with SMTP id k11mr13955663wrv.256.1585565437476; 
 Mon, 30 Mar 2020 03:50:37 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:cdad:b6f9:8132:4b7c])
 by smtp.gmail.com with ESMTPSA id g186sm21665028wmg.36.2020.03.30.03.50.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 03:50:37 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Xinhui.Pan@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: partial revert VM sync changes
Date: Mon, 30 Mar 2020 12:50:35 +0200
Message-Id: <20200330105035.105045-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200330105035.105045-1-christian.koenig@amd.com>
References: <20200330105035.105045-1-christian.koenig@amd.com>
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

V2Ugc3RpbGwgbmVlZCB0byBhZGQgdGhlIFZNIHVwZGF0ZSBmZW5jZXMgdG8gdGhlIHJvb3QgUEQu
CgpTbyBtYWtlIHN1cmUgdG8gbmV2ZXIgc3luYyB0byB0aG9zZSBpbXBsaWNpdGVseS4KClNpZ25l
ZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5jIHwgNSArKysrKwogMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfc3luYy5jCmluZGV4IGI4NjM5MjI1MzY5Ni4uYjg3Y2ExNzE5ODZhIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMKQEAgLTI0OSw2ICsyNDksMTEgQEAgaW50
IGFtZGdwdV9zeW5jX3Jlc3Yoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRn
cHVfc3luYyAqc3luYywKIAkJICAgIG93bmVyICE9IEFNREdQVV9GRU5DRV9PV05FUl9VTkRFRklO
RUQpCiAJCQljb250aW51ZTsKIAorCQkvKiBOZXZlciBzeW5jIHRvIFZNIHVwZGF0ZXMgZWl0aGVy
LiAqLworCQlpZiAoZmVuY2Vfb3duZXIgPT0gQU1ER1BVX0ZFTkNFX09XTkVSX1ZNICYmCisJCSAg
ICBvd25lciAhPSBBTURHUFVfRkVOQ0VfT1dORVJfVU5ERUZJTkVEKQorCQkJY29udGludWU7CisK
IAkJLyogSWdub3JlIGZlbmNlcyBkZXBlbmRpbmcgb24gdGhlIHN5bmMgbW9kZSAqLwogCQlzd2l0
Y2ggKG1vZGUpIHsKIAkJY2FzZSBBTURHUFVfU1lOQ19BTFdBWVM6Ci0tIAoyLjE3LjEKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
