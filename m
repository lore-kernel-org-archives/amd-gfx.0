Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE4ECA9EC1
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:44:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC62E217D6
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC62E217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 909836EAB5;
	Mon, 28 Oct 2019 21:44:09 +0000 (UTC)
Received: from mail-yw1-xc44.google.com (mail-yw1-xc44.google.com
 [IPv6:2607:f8b0:4864:20::c44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 255776EAB0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 21:44:08 +0000 (UTC)
Received: by mail-yw1-xc44.google.com with SMTP id i2so2603332ywg.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 14:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/i/0HlGKA9pW8fyicPfA2pdugAJIJiOP9Q1QrtgaENE=;
 b=MtNhFJ5aYjLEcmaEN66xP4mxZ8Ye7IBXLDgc19A5a8j7INvEz2v8USziNcksKSNfUk
 mt8q4UYUpXpqR8N1kwyVLVkRwj9bdvh2a1qxo2hGR/9+vXnxwsnN6S1RvgwutDi75U90
 etRNKPb/TRoNlDET0TYZDm5w6tflSpfJg+JOmp5R/GulhttTRoo4q7WFwohXyXaITx0h
 leDxzY+NnuZvJ6us/XlpYYRTVcUIrJbVqxuKaUzdJ+Z+8alpdv8epOQqnvNLTiFQApN6
 Y6NoiY3yxnvnInUBSqi90Nid6OLFmGFxOOeCpWxfCMq2FReYGZnuNyLMSFHcsiP49D7z
 MGwA==
X-Gm-Message-State: APjAAAVHPzHJ10VneAaa4AjRvirzshL6Sc5POfsSfJOx3M6PDInG68HU
 71rLNt2ihzYVAeJmii2J0hNSIzLPWz8=
X-Google-Smtp-Source: APXvYqxAoGwunIMqA+SPqNDdF3oLZEdsPsqNY7nnbibhFUwRdkaEG9KikiHvIkySGq9ly2xzHIU3Hg==
X-Received: by 2002:a81:8282:: with SMTP id
 s124mr14629255ywf.498.1572299047051; 
 Mon, 28 Oct 2019 14:44:07 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l68sm3421090ywf.95.2019.10.28.14.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 14:44:06 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 21/21] ALSA: hda/hdmi - enable automatic runtime pm for AMD
 HDMI codecs by default
Date: Mon, 28 Oct 2019 17:42:16 -0400
Message-Id: <20191028214216.1508370-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028214216.1508370-1-alexander.deucher@amd.com>
References: <20191028214216.1508370-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/i/0HlGKA9pW8fyicPfA2pdugAJIJiOP9Q1QrtgaENE=;
 b=nbdVwfZDFPHykkNFSt2WZ5wQLGbZ6iM+RG/vCRRBVkRbAn5BuBSA2/sSJvYm+YWzZS
 hfzQYZMGWAkwVf19lmJITXiFh0wJeaOyXMMNPVikkb94JZWzNhbN3Mu5QKGqkVj20Um9
 iEx5xLfbOIwVeBpVs+k1nOP3uiGKZmmpX8wUv8bNBk1NWnlbGboYjQqW7s8Fys6yxnwV
 Qsl7TEqDJlLdnzn2rOTZFx+E+ZeFLe7JYhJTy4vcbHa8XL6699qcagV36cJCj4Qmblfq
 fHEZ8gOqvnC5mhrg4XYctZ5zpB9Psibi/mWZ6Il58pHRuLFS5gjlQO6rGkQOP0PCWAw5
 8JUw==
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028214216.ZkHp_46kDyP8JvL-Np7gUa4_wqnv4_C_6BUngwIX3zM@z>

U28gdGhhdCB3ZSBjYW4gcG93ZXIgZG93biB0aGUgR1BVIGFuZCBhdWRpbyB0byBzYXZlIHBvd2Vy
LgoKQWNrZWQtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBzb3VuZC9wY2kv
aGRhL3BhdGNoX2hkbWkuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpk
aWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9wYXRjaF9oZG1pLmMgYi9zb3VuZC9wY2kvaGRhL3Bh
dGNoX2hkbWkuYwppbmRleCBiZWE3YjA5NjEwODAuLjI2NjEzNzMzZjEwOSAxMDA2NDQKLS0tIGEv
c291bmQvcGNpL2hkYS9wYXRjaF9oZG1pLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9oZG1p
LmMKQEAgLTM3NzksNiArMzc3OSw3IEBAIHN0YXRpYyBpbnQgYXRpaGRtaV9pbml0KHN0cnVjdCBo
ZGFfY29kZWMgKmNvZGVjKQogCQkJCQkgICAgQVRJX1ZFUkJfU0VUX01VTFRJQ0hBTk5FTF9NT0RF
LAogCQkJCQkgICAgQVRJX01VTFRJQ0hBTk5FTF9NT0RFX1NJTkdMRSk7CiAJfQorCWNvZGVjLT5h
dXRvX3J1bnRpbWVfcG0gPSAxOwogCiAJcmV0dXJuIDA7CiB9Ci0tIAoyLjIzLjAKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
