Return-Path: <SRS0=j4R+=ZO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36FAC432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 21:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8469B2071B
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 21:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8469B2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35C896E119;
	Fri, 22 Nov 2019 21:44:04 +0000 (UTC)
Received: from mail-yw1-xc42.google.com (mail-yw1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BD506E119
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2019 21:44:02 +0000 (UTC)
Received: by mail-yw1-xc42.google.com with SMTP id g77so2932181ywb.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2019 13:44:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VU7dGd7/QMxnEjRz5vA1JHVUSYPPl6NYcTFynVeTePY=;
 b=ruJob9AL5i9eKRfGNjwlcUujIOAwSJ6wXQMsX/3BDZvNjs+GuOSfAjX0dKrS8sEnkZ
 Ow+xd/H4QL8KXcoiWUXnk+ThAPg5soLKo2hG8P0WLG3aymRZKju1tjwogRbdcurgHcLp
 WcrRsMO1z62FpO6UShJ1U3psazWVdloPQIFedOLsCdWhmQLO6GkJ0iFY7BYPzbJuTzbE
 Eph3vb7YpCbNCZRT7mZHOPCgoEQne+/Z8RXUvh3yLnuujPzAhY5nq6/PpiH7QoGWGWKc
 0uCtJkR/Hu9fRruMfRM6gCGocf7ZqeU4uC3eaogxBitrvFuy9FehdX8AtdIj4A62tGv7
 hlYQ==
X-Gm-Message-State: APjAAAXA0xhxh9d+VB/4kaKloaNhh5KCOp/QdL62kssyNpx2W90fkawL
 8Muuu4EwRalFp1FmsezBSnnaqfsr
X-Google-Smtp-Source: APXvYqyScrfOHi5mb4qNfZIQwA2GZ8ZpQp1lrjo3JlUQYFYfS8W6Nfy13tGTSUDQWpe/3/4lOP80rw==
X-Received: by 2002:a81:47c3:: with SMTP id u186mr11218034ywa.91.1574459041409; 
 Fri, 22 Nov 2019 13:44:01 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id t15sm2111522ywh.70.2019.11.22.13.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 13:44:00 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de
Subject: [PATCH 0/4] add runtime pm support for AMD display audio
Date: Fri, 22 Nov 2019 16:43:49 -0500
Message-Id: <20191122214353.582899-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VU7dGd7/QMxnEjRz5vA1JHVUSYPPl6NYcTFynVeTePY=;
 b=sGuw9zYeIheEF2FpKFUgO+dP994QbPwKNstDTZbc+rEpZl1y0iPHspQlAZdofZ+TxF
 Rl8gcH0d0WE9tLycMx29ImklUEPEec5MoRcasWLI2I9ugWX0NO/gmCBqVHcTWw+0XjJw
 GocFY2AhypepJyK5qxkTpomzZKVysXp0B04pce/w4v1VzM/XpjMF4UNAlEFz1BBdvuJ0
 g8xYBDlxSiKrw4woa8PTsnjAJ1aWgt/dlhgsCU5zfLrL46LKKV3H8SJuJUjYpJxQ7wwT
 h9ZLSiyjIRhz952UyqQieIwkcHiAxafI4eGkTBHnohNlWd3lSruY1o49mf5Dy6o+rdVE
 aH2g==
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
Message-ID: <20191122214349.oFu6AUZPQYrnNca_DRuZnPB7TAC56Ef3eehJ9O7RSN0@z>

VGhlc2UgcGF0Y2hlcyB3ZXJlIG9yaWdpbmFsbHkgcGFydCBvZiBhIGxhcmdlciBzZXQgb2YgcGF0
Y2hlcwp0byBlbmFibGVkIHJ1bnRpbWUgcG0gc3VwcG9ydCBvbiB0aGUgR1BVIHNpZGVbMV0uICBI
b3dldmVyLCB0aGUKcGF0Y2hlcyBhcmUgdXNlZnVsIG9uIHRoZWlyIG93biB0aGVyZSBhcmUgcmVh
bGx5IG5vIGRlcGVuZGVuY2llcywKb3RoZXIgdGhhbiB0aGUgZmFjdCB0aGF0IHlvdSBuZWVkIGJv
dGggZm9yIHJ1bnRpbWUgcG0gdG8ga2ljayBpbgpvbiB0aGUgR1BVIHNpZGUuICBUaGUgR1BVIHNp
ZGUgd2lsbCBiZSBsYW5kaW5nIGZvciA1LjY7IEknZCBsaWtlCnRvIGxhbmQgdGhlIGF1ZGlvIHNp
ZGUgYXMgd2VsbC4KClRoYW5rcywKCkFsZXgKClsxXTogaHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRl
c2t0b3Aub3JnL3Nlcmllcy82Nzg4NS8KCkFsZXggRGV1Y2hlciAoNCk6CiAgQUxTQTogaGRhL2hk
bWkgLSBmaXggdmdhc3dpdGNoZXJvbyBkZXRlY3Rpb24gZm9yIEFNRAogIEFMU0E6IGhkYS9oZG1p
IC0gQWRkIG5ldyBwY2kgaWRzIGZvciBBTUQgR1BVIGRpc3BsYXkgYXVkaW8KICBBTFNBOiBoZGEv
aGRtaSAtIGVuYWJsZSBydW50aW1lIHBtIGZvciBuZXdlciBBTUQgZGlzcGxheSBhdWRpbwogIEFM
U0E6IGhkYS9oZG1pIC0gZW5hYmxlIGF1dG9tYXRpYyBydW50aW1lIHBtIGZvciBBTUQgSERNSSBj
b2RlY3MgYnkKICAgIGRlZmF1bHQKCiBzb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jICB8IDgwICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tCiBzb3VuZC9wY2kvaGRhL3BhdGNo
X2hkbWkuYyB8ICAxICsKIDIgZmlsZXMgY2hhbmdlZCwgNzYgaW5zZXJ0aW9ucygrKSwgNSBkZWxl
dGlvbnMoLSkKCi0tIAoyLjIzLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
