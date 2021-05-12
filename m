Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9CAC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 10:18:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA03B6134F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 10:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA03B6134F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3463C6E03B;
	Wed, 12 May 2021 10:18:54 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE6C06E03B
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 10:18:52 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id n25so26409868edr.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 03:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=f79FuEnKgVdBmGSjdeaOnlVNb8+47zGJtU27glECBfo=;
 b=cX/qqIIfG/96QnmjkhMLaknJHd07kfCeZ2gapInMoWDxc3QXq5NMCHQgh3yesRWWCm
 z54QeEI6a6q9gFJ/PjUCQhXlPARoJZyvQzzXjqPpd3z/RyYFIgbsUu3VZeZBtRNq/F72
 27pNSCLX+iLXzXY1+PV7txGsyw3SkGNJZdoKG+zOVpiBPVwic8mcJh3AU0SgScK9MyDY
 1LV6VUZNhWRMvco+i9DvnQ/fgVZHvgyZpPcg2Ng4V+t+jj2gKQA9fLxZaMi9J6Kn7cWM
 UKXyA80Ddd84CIKtwpEnieOPRXIo/5Ol1WnK3rN5HSCD3AybbKXXsTPHVdaOQNQMLYpw
 fLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=f79FuEnKgVdBmGSjdeaOnlVNb8+47zGJtU27glECBfo=;
 b=Xslc9dHs0WcRF+oGOZSmbRrZoERN8L/2e6ADJ8EaKCFkY1Ks2IJXV9jzyxUivtZRUB
 h9Ey5zknlpjf1MxHolgg9EeaCWmZiPr+DDWC4GGgyVaBp7Ucgao29E4Yu6EJcjkkboAq
 9wX/cRH7AAHtPc+94/KVzLpxNcUaBh6NdPRBL5gHP0rZH1x21mLKcrBdqek2iNzMmeYa
 5KwBgoBgQQ/6WQhtBC1Vp5MIcHXM7TxGg93/LDfw2lLof1jLxcXkr5DAH9HEbg7KVSg+
 KqDpBJo5KfWu4nI9+Glxy0Esbomabf/+abZfc/m+ej/ujDcRF7PuxCryJs6Y+kvKBwSU
 lBtg==
X-Gm-Message-State: AOAM530+JF5Kb6Ve994bHJnCvfvN045laE+CUFMqQ85YZK5jkuDJPz9F
 5pMAqRmuQnADSLoIG0NF9+w0WAzVGpo=
X-Google-Smtp-Source: ABdhPJwuGYkmiuaCXbN2uASyepDERPd3iaAt9BGQLPo8GxnuAbGrTB0QQxKS+2vzbatNlTey55N+hg==
X-Received: by 2002:a05:6402:1d8e:: with SMTP id
 dk14mr37362268edb.385.1620814731538; 
 Wed, 12 May 2021 03:18:51 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:6e2:f138:f7ed:5a25])
 by smtp.gmail.com with ESMTPSA id b12sm17240575eds.23.2021.05.12.03.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 May 2021 03:18:51 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/radeon: use the dummy page for GART if needed
Date: Wed, 12 May 2021 12:18:50 +0200
Message-Id: <20210512101850.1466-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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
Cc: tiwai@suse.de, arvin.kebob@gmail.com, mail@dennisfoster.us
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SW1wb3J0ZWQgQk9zIGRvbid0IGhhdmUgYSBwYWdlbGlzdCBhbnkgbW9yZS4KClNpZ25lZC1vZmYt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KRml4ZXM6IDA1
NzVmZjNkMzNjZCAoImRybS9yYWRlb246IHN0b3AgdXNpbmcgcGFnZXMgd2l0aCBkcm1fcHJpbWVf
c2dfdG9fcGFnZV9hZGRyX2FycmF5cyB2MiIpCkNDOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMg
NS4xMgotLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2dhcnQuYyB8IDMgKystCiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZ2FydC5jIGIvZHJpdmVycy9ncHUvZHJt
L3JhZGVvbi9yYWRlb25fZ2FydC5jCmluZGV4IDM4MDhhNzUzMTI3Yi4uMDQxMDlhMmE2ZmQ3IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9nYXJ0LmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZ2FydC5jCkBAIC0zMDEsNyArMzAxLDggQEAgaW50
IHJhZGVvbl9nYXJ0X2JpbmQoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYsIHVuc2lnbmVkIG9m
ZnNldCwKIAlwID0gdCAvIChQQUdFX1NJWkUgLyBSQURFT05fR1BVX1BBR0VfU0laRSk7CiAKIAlm
b3IgKGkgPSAwOyBpIDwgcGFnZXM7IGkrKywgcCsrKSB7Ci0JCXJkZXYtPmdhcnQucGFnZXNbcF0g
PSBwYWdlbGlzdFtpXTsKKwkJcmRldi0+Z2FydC5wYWdlc1twXSA9IHBhZ2VsaXN0ID8gcGFnZWxp
c3RbaV0gOgorCQkJcmRldi0+ZHVtbXlfcGFnZS5wYWdlOwogCQlwYWdlX2Jhc2UgPSBkbWFfYWRk
cltpXTsKIAkJZm9yIChqID0gMDsgaiA8IChQQUdFX1NJWkUgLyBSQURFT05fR1BVX1BBR0VfU0la
RSk7IGorKywgdCsrKSB7CiAJCQlwYWdlX2VudHJ5ID0gcmFkZW9uX2dhcnRfZ2V0X3BhZ2VfZW50
cnkocGFnZV9iYXNlLCBmbGFncyk7Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
