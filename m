Return-Path: <SRS0=lywG=HT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91105C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 19:00:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8826186A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 19:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8826186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD7856E1EE;
	Wed, 17 Feb 2021 19:00:34 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4AF96E1CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Feb 2021 19:00:33 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id c6so17931845ede.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Feb 2021 11:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=URl6/XMnAi8Jj7QVAr+Qduf76aY4SyXiVoyR0v8Ib3A=;
 b=B//XG7T7SrnCLMm47fG6/BxbApmazzsDLN7wYU0+gaVLS/z1bJjXmoeVCjV6ADj1D5
 ACSxT9fb+5xcj4y97qSCijLx3JV95uZyazY8gGKDHuIElV26zrpIiLfZptGBFsDEhLkJ
 WoF6P2MlsxYZwM1aCipwwJWxMKof2EfXIz6A7A4bVhaYlW1hZnfXsOuAK9/NJ8va8y4y
 1uQaNYrSNOWjtrV2tjtPszbx2+LB+wY3Xaj4v7ZHFYg6D/PRiiXx/1UOU8IZdCzcF48F
 Bor5DSgYhlBpwnnZWgyYCqAH6e6we1N2L9ktfX6VyRXA09U3HU3N2tlHmc6gms5osPuX
 l3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=URl6/XMnAi8Jj7QVAr+Qduf76aY4SyXiVoyR0v8Ib3A=;
 b=ohza5sTx+WR6y2UxxSp9Sxb9fo/3WuraMqz/gVGNy11Oyj8yVwvlqblcGPOp2E+6vU
 RvoUFfSuR92igFnOR9G5D2eFRr/9bHlVEpMJfXU0hkv9S+OyT0qla/O2EUG+Tf/MWnTp
 fN7pE+DVHxxxolYnOyHLx5Un17lViv9Gzbhq78UqIyJ7ggecWfSODK8i81Zk0skOA7D+
 y4qgQ64kBG9r9V/ptxviVxFXi7HPOqskP+dyKTKL4uzW4jjXauqEnbIjw77+JiUsw6Lg
 rL6BEFMgX7VqZg3I/r9kNEp9nnDWHpwq7Cjo31YeXoinLZqoy35SJHdTeC04MVSPzq/j
 QZ9g==
X-Gm-Message-State: AOAM530CoxgZd+9bvMxc0taiBNqoBQvHl5VmVFCuYAcoOj+ClB9/ssoJ
 e3YIv4l55prZF13fnYeGvIww/o5aNDDkTA==
X-Google-Smtp-Source: ABdhPJyPoyHDDe4EqQG8dMIpR3WcMnyRdfo1/GFrwv06RK03YUQS0/qV0Nr9nHAzBo0ciN4y04s4yg==
X-Received: by 2002:a50:eb8b:: with SMTP id y11mr286103edr.216.1613588432457; 
 Wed, 17 Feb 2021 11:00:32 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:b7c6:d2d7:631c:11b7])
 by smtp.gmail.com with ESMTPSA id r4sm1562710edv.27.2021.02.17.11.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Feb 2021 11:00:32 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Ramesh.Errabolu@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/8] drm/amdgpu: use new cursor in amdgpu_ttm_io_mem_pfn
Date: Wed, 17 Feb 2021 20:00:24 +0100
Message-Id: <20210217190028.16409-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210217190028.16409-1-christian.koenig@amd.com>
References: <20210217190028.16409-1-christian.koenig@amd.com>
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
Cc: Arunpravin.PaneerSelvam@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U2VwYXJhdGUgdGhlIGRybV9tbV9ub2RlIHdhbGtpbmcgZnJvbSB0aGUgYWN0dWFsIGhhbmRsaW5n
LgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyB8IDggKysr
LS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCmluZGV4IDU5YjQ5MTk5ODA0OS4u
ZDY2ODhhMmU1MjVhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdHRtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCkBA
IC03MjcsMTIgKzcyNywxMCBAQCBzdGF0aWMgaW50IGFtZGdwdV90dG1faW9fbWVtX3Jlc2VydmUo
c3RydWN0IHR0bV9ib19kZXZpY2UgKmJkZXYsIHN0cnVjdCB0dG1fcmVzbwogc3RhdGljIHVuc2ln
bmVkIGxvbmcgYW1kZ3B1X3R0bV9pb19tZW1fcGZuKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAq
Ym8sCiAJCQkJCSAgIHVuc2lnbmVkIGxvbmcgcGFnZV9vZmZzZXQpCiB7Ci0JdWludDY0X3Qgb2Zm
c2V0ID0gKHBhZ2Vfb2Zmc2V0IDw8IFBBR0VfU0hJRlQpOwotCXN0cnVjdCBkcm1fbW1fbm9kZSAq
bW07CisJc3RydWN0IGFtZGdwdV9yZXNfY3Vyc29yIGN1cnNvcjsKIAotCW1tID0gYW1kZ3B1X2Zp
bmRfbW1fbm9kZSgmYm8tPm1lbSwgJm9mZnNldCk7Ci0JcmV0dXJuIChiby0+bWVtLmJ1cy5iYXNl
ID4+IFBBR0VfU0hJRlQpICsgbW0tPnN0YXJ0ICsKLQkJKG9mZnNldCA+PiBQQUdFX1NISUZUKTsK
KwlhbWRncHVfcmVzX2ZpcnN0KCZiby0+bWVtLCAodTY0KXBhZ2Vfb2Zmc2V0IDw8IFBBR0VfU0hJ
RlQsIDAsICZjdXJzb3IpOworCXJldHVybiAoYm8tPm1lbS5idXMuYmFzZSArIGN1cnNvci5zdGFy
dCkgPj4gUEFHRV9TSElGVDsKIH0KIAogLyoqCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
