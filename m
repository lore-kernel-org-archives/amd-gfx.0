Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FBDC48BCD
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 09:18:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E783E613ED
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 09:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E783E613ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 613856EC93;
	Thu, 10 Jun 2021 09:18:08 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB40B6EC93;
 Thu, 10 Jun 2021 09:18:06 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 u5-20020a7bc0450000b02901480e40338bso4392171wmc.1; 
 Thu, 10 Jun 2021 02:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=tvv/a4GnE6e26XfGwf+jm2ojTcweECJjiaTCOzTo/lM=;
 b=NtPrBOPcWSrdMhHJwnwOZTRwh9kmDP+5JjjxL/qYUCX1CCd/dK2VzLzbowYEY1cJ5a
 Oziu3kHe7JXfs9M/00EvAbQlath5+N7C/9ckmGzukTq3+DFymFRw88fGK2IFd7kc1RcH
 Jco+JG3N/gDyQAdufF67Sh31KIW3hZCI7K1am5MPMoloVGWkw3LXa9ZJMtwaqkugqkid
 9YHlOCe8t+AuLmbT7k1rQPsq274Ew+cwyvdlaq4mveNxHMcQ1fqgJPW3lnzhSoih4aaw
 CJP2wh5GQQhigq5Sp0n40fXmwFYrM2NejxL7tM53nSaKSny+LWbId24MoffdXlf5TcEO
 KOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tvv/a4GnE6e26XfGwf+jm2ojTcweECJjiaTCOzTo/lM=;
 b=kOZj1ycxeOgVxUOAtyYnhN24xLxhc8cNtjkAbyw1mDDhzzKCKPEESJqAjKzOUe9Xfo
 5NgAvCO6L/rEMi+CouiY4GY0fdyWHaEl7O1NIUgyLdmGNFQ8uTsGgzF+SIqr3lN1GYap
 iNjAeqsNwherKpQyUapXbQP8X5QJyp0UX1jRpf/T1cdGiuEK19nua2waVIgHGMyxn4QI
 LPiogX0RMjg7JD531h2X1v354TdDhTnbY56nm8gKrxQcfzznE5T5p8Rf+hel9mND4s/p
 j8qM88kALbPGHy2F/bFESsgvSCTUM3VJe5H9f0FVZpZ9D+MEnaJmWs+lerPk+W9EPbhk
 8d+g==
X-Gm-Message-State: AOAM532hueKRJWsHFpTwSUV3C8QQl3afa3/1il10arDLkFqqre+/kya5
 UXr7E7Brsn5vkic4mk2HrtzDQ1l5PPc=
X-Google-Smtp-Source: ABdhPJzEL3NtHnpWqIAvKt6SXLvn9uMnJZGM2//K98BExFWSS1agitTdfZu8UPCqx/1oGqHSw64WbQ==
X-Received: by 2002:a1c:1f51:: with SMTP id f78mr4031900wmf.7.1623316685627;
 Thu, 10 Jun 2021 02:18:05 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:561f:e43a:edf5:8f95])
 by smtp.gmail.com with ESMTPSA id v8sm3087445wrc.29.2021.06.10.02.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jun 2021 02:18:05 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/7] drm/syncobj: drop the manual garbage collection
Date: Thu, 10 Jun 2021 11:17:58 +0200
Message-Id: <20210610091800.1833-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610091800.1833-1-christian.koenig@amd.com>
References: <20210610091800.1833-1-christian.koenig@amd.com>
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

Tm90IG5lZWRlZCBhbnkgbW9yZSBzaW5jZSBkbWFfZmVuY2VfY2hhaW4gb2JqZWN0cyB0YWtlIGNh
cmUgb2YgdGhpcyBub3cuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2RybV9zeW5jb2JqLmMgfCAz
IC0tLQogMSBmaWxlIGNoYW5nZWQsIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2RybV9zeW5jb2JqLmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX3N5bmNvYmouYwpp
bmRleCAxYzViOWVmNmRhMzcuLmU2ZDE0NDc3NWE4NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2RybV9zeW5jb2JqLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV9zeW5jb2JqLmMKQEAg
LTMwNCw5ICszMDQsNiBAQCB2b2lkIGRybV9zeW5jb2JqX2FkZF9wb2ludChzdHJ1Y3QgZHJtX3N5
bmNvYmogKnN5bmNvYmosCiAJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKGN1ciwgdG1wLCAmc3lu
Y29iai0+Y2JfbGlzdCwgbm9kZSkKIAkJc3luY29ial93YWl0X3N5bmNvYmpfZnVuYyhzeW5jb2Jq
LCBjdXIpOwogCXNwaW5fdW5sb2NrKCZzeW5jb2JqLT5sb2NrKTsKLQotCS8qIFdhbGsgdGhlIGNo
YWluIG9uY2UgdG8gdHJpZ2dlciBnYXJiYWdlIGNvbGxlY3Rpb24gKi8KLQlkbWFfZmVuY2VfY2hh
aW5fZm9yX2VhY2goZmVuY2UsIHByZXYpOwogCWRtYV9mZW5jZV9wdXQocHJldik7CiB9CiBFWFBP
UlRfU1lNQk9MKGRybV9zeW5jb2JqX2FkZF9wb2ludCk7Ci0tIAoyLjI1LjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
