Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C19C43616
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E1F61001
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E1F61001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A47C46F464;
	Thu, 20 May 2021 12:49:16 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB8FB89FEA
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 12:03:22 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id n2so17468942wrm.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 05:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oOCS+hcR746GCJgf+MTN84dmS4mfJygmI/El7Wrt4P4=;
 b=ZUD65uqjYlggL85gY9v2dGP0qaEAtUv9/6yMYvyc6T+yU5TXOVtoJYkrk15QeUqmTC
 cE3LQxHt/DtOkRgOgMIfh0MRQGRTTmnYhR4AgZwQQLc3SCNbDeioVcipg6covQsn4ynm
 +GCS3mvEDYAgBL4Hn/l6Ci0RwqwCRXM8oWyhnBZ5L+dwOj4c0mg9nNp9ETdiFOkR46P0
 IsDLYhphvMJegX3q3vjLGm6YIWJ0u3V0ktJfDTBfWhBv/yDqJIq2Yhd0k+sBC64x5JMb
 Ni05pKPh4xHIe1OK0JoD10mCgbve8icQ/yi0vvUP5sCREjDv861COjn5th/TxAaeEvYr
 /2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oOCS+hcR746GCJgf+MTN84dmS4mfJygmI/El7Wrt4P4=;
 b=BnWqnGv2bdnAmXbLfusmNdfihud5n5lemNc5yiXerdbUU4jv3fz489xs8rVEuWYs22
 n5JgIKryhuXcZRacuBA3y3xz4qypdS8Tphhexeho2i9+AXD+jeS2JekeZQggqAyW/yPh
 rWVwMKUSDyMgJRBeSJCjoIOoj3othAXVd7fAjwJksdsnNMgcYaNGhXikb88hgKhHtL3k
 13xqkAVUus8OjBw+gaUCX8dITDXkV9ziwiq71psUZb0XjwarrZ4vvY00bUzClKjii69j
 5JkB+sQJF4iIATyzqBPBCMnZ0KRHyFcZjt5bk5h8AsKudRWk0y5JmeHaGn65iWtcpi5X
 lvbw==
X-Gm-Message-State: AOAM530VsNrgsYNfmMxVH/iUPL1bYtxb/37Ux6ko9MWNEuSvRNw2x9zl
 ucqjyQR8A07kA7dxe9QCM3JPdA==
X-Google-Smtp-Source: ABdhPJyAItR0gb4XPRxdBIWogM59UBoe9P9QuJ8hc0mi4kUzQUx9yTK3mbjp5Cx9hjsoU+iBasFpHQ==
X-Received: by 2002:a05:6000:10d1:: with SMTP id
 b17mr3885211wrx.281.1621512201663; 
 Thu, 20 May 2021 05:03:21 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 05:03:21 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 29/38] drm/radeon/r100: Realign doc header with function
 'r100_cs_packet_parse_vline()'
Date: Thu, 20 May 2021 13:02:39 +0100
Message-Id: <20210520120248.3464013-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120248.3464013-1-lee.jones@linaro.org>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 20 May 2021 12:49:10 +0000
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yMTAwLmM6MTQyMzogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlw
ZSBmb3IgcjEwMF9jc19wYWNrZXRfbmV4dF92bGluZSgpLiBQcm90b3R5cGUgd2FzIGZvciByMTAw
X2NzX3BhY2tldF9wYXJzZV92bGluZSgpIGluc3RlYWQKCkNjOiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERh
bmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IFN1bWl0IFNlbXdhbCA8c3VtaXQuc2Vt
d2FsQGxpbmFyby5vcmc+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogbGludXgtbWVkaWFAdmdlci5rZXJuZWwu
b3JnCkNjOiBsaW5hcm8tbW0tc2lnQGxpc3RzLmxpbmFyby5vcmcKU2lnbmVkLW9mZi1ieTogTGVl
IEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3IxMDAuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjEwMC5jIGIvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yMTAwLmMKaW5kZXggZmNmY2FlYzI1YTllZi4uM2M0ZTdjMTVmZDE1
OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yMTAwLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yMTAwLmMKQEAgLTE0MDYsNyArMTQwNiw3IEBAIGludCByMTAwX2Nz
X3BhcnNlX3BhY2tldDAoc3RydWN0IHJhZGVvbl9jc19wYXJzZXIgKnAsCiB9CiAKIC8qKgotICog
cjEwMF9jc19wYWNrZXRfbmV4dF92bGluZSgpIC0gcGFyc2UgdXNlcnNwYWNlIFZMSU5FIHBhY2tl
dAorICogcjEwMF9jc19wYWNrZXRfcGFyc2VfdmxpbmUoKSAtIHBhcnNlIHVzZXJzcGFjZSBWTElO
RSBwYWNrZXQKICAqIEBwOgkJcGFyc2VyIHN0cnVjdHVyZSBob2xkaW5nIHBhcnNpbmcgY29udGV4
dC4KICAqCiAgKiBVc2Vyc3BhY2Ugc2VuZHMgYSBzcGVjaWFsIHNlcXVlbmNlIGZvciBWTElORSB3
YWl0cy4KLS0gCjIuMzEuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
