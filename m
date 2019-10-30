Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281CFCA9EC5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 14:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0468220656
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 14:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0468220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A98C76E9C2;
	Wed, 30 Oct 2019 14:22:52 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 623AE6E9C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 14:22:51 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id g50so3464747qtb.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 07:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=t3xleL6MuNAR6FSk5BbPwCp5LsFanpvNqe36LTV57EA=;
 b=rF3vALn0hINBR08PfwbiwKgTTittR1pR3qT0a48tCFZ/bNM+DJwOHXZMLgt8oPnH8w
 mUnXbC4N64xBv8FfJIso32Hg6yADH7b6ATE99H3kM4eZ38WgLvfkmdNrstUIQJxBgCjF
 YWP9sd2U+W6ujHEeSWzzDRPhNYllMx+dAAWhCRVhCw8615KJME2tnefBj0zbo8oKEvv5
 pf4r8Cd8J6XRN8oztDVNrlZguV/2c+986gx2S6fK5zkclQOIqQiCspGynyOpSNxn05LX
 Nzi8YaJR+f/2o3XwZeTzxs8qZokFwNo1ubZXGBDqGcG0/yyd9mXt0rS+zV5HBwVmbDoL
 hRiA==
X-Gm-Message-State: APjAAAWjeA0qaG7UF3wx+zz/z1XlLW+Gv1x4rir29zy8OtA/qF8A3Iu+
 DbRh4A8mlazcTslW7A00+tOW3Tu5
X-Google-Smtp-Source: APXvYqwemtdwlzYgKihQhFDuPDvp1JkVhvjx65ZzrqggYguuLcGvTNElDLKk+vo5drSwF4wfTidxZQ==
X-Received: by 2002:ac8:714c:: with SMTP id h12mr230216qtp.231.1572445369912; 
 Wed, 30 Oct 2019 07:22:49 -0700 (PDT)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id u11sm130812qtg.11.2019.10.30.07.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2019 07:22:49 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/radeon: fix si_enable_smc_cac() failed issue
Date: Wed, 30 Oct 2019 10:22:41 -0400
Message-Id: <20191030142241.1575786-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=t3xleL6MuNAR6FSk5BbPwCp5LsFanpvNqe36LTV57EA=;
 b=jnNHnDJ4zgc6kFqSNVOCLwuyfMq5qsbb7TUhsS6TQLMBamON5HsNq3mXq+i+yOujoH
 GX4YfkVjTt6YTpd2eFvMdUYu2P51596aZwF36CHPIJ8boI8wLhb1YBFSKswFOg1ef82T
 0POACPpbK9qaEGJG4xXwqXuStbisb7nmIRl8GVUSclJ93pU4ZLfh/yq8uBLp7/szFtD5
 bwEXz23OhdfeF/Dp7I4SyDTpaPaWY00HNXzCvPcyZyq0f2+AC4QopH5xODXm5AGHNtn2
 U9/bL5o7Ub6kR+u6s5ofIDT9hjpd6oIMcYuce5IPbrOBDSIfa7YY6mM6sY7+Obrv/wwW
 anbw==
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191030142241.i0Penk35aW6U8l4CG7FOauSOgT337E7ZIM92imbwb9A@z>

TmVlZCB0byBzZXQgdGhlIGR0ZSBmbGFnIG9uIHRoaXMgYXNpYy4KClBvcnQgdGhlIGZpeCBmcm9t
IGFtZGdwdToKNWNiODE4Yjg2MWJlMTE0MTQ4ZThkYmViNDI1OTY5ODE0ODAxOWRkMQoKU2lnbmVk
LW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9yYWRlb24vc2lfZHBtLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2lfZHBtLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpX2RwbS5jCmluZGV4IDQ2MGZkOThlNDBhNy4uYTBi
MzgyYTYzN2E2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpX2RwbS5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2lfZHBtLmMKQEAgLTE5NTgsNiArMTk1OCw3IEBA
IHN0YXRpYyB2b2lkIHNpX2luaXRpYWxpemVfcG93ZXJ0dW5lX2RlZmF1bHRzKHN0cnVjdCByYWRl
b25fZGV2aWNlICpyZGV2KQogCQljYXNlIDB4NjgyQzoKIAkJCXNpX3BpLT5jYWNfd2VpZ2h0cyA9
IGNhY193ZWlnaHRzX2NhcGVfdmVyZGVfcHJvOwogCQkJc2lfcGktPmR0ZV9kYXRhID0gZHRlX2Rh
dGFfc3VuX3h0OworCQkJdXBkYXRlX2R0ZV9mcm9tX3BsMiA9IHRydWU7CiAJCQlicmVhazsKIAkJ
Y2FzZSAweDY4MjU6CiAJCWNhc2UgMHg2ODI3OgotLSAKMi4yMy4wCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
