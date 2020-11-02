Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22851C00A89
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 16:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCBDA208B6
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 16:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+N1RJvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCBDA208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D8A06E56D;
	Mon,  2 Nov 2020 16:23:56 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C44276E566
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2020 16:23:54 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id n18so15304103wrs.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2020 08:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Cs6h72gjwQhllqehT7Kk2Er3gb+3FeajM70Asl4Dsvs=;
 b=j+N1RJvGlbU/fEMvc11r7YTAnjqcUkamPNkQF7OFxOKqzpZd30akhzPsVA0LZcUNAP
 51IRtz2U/+Alabi0TWOo5pVDsx2CYCfYSG9/w9LZN3G383i1pAGy0QmyTmhDYX+UGqnh
 3jGdqN2oQgQSKOWmIR4O9y2VBkl4EQh+FxnD8fCZMl/tfLVzkCDgdlwK58krnrTVXAno
 1Ur3wH+3l2anyOW/wNdxxBWTdOpn2UkOcUxDjJ7fZvEKaPS77jdcaVR3TTD8CRF7v0ES
 1i0zKkecth088tI6vXQXzPOd7ArttbiqICny5RbSS1ZoE+CAUG4PbZS1J4bT6+xl4zjM
 XLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Cs6h72gjwQhllqehT7Kk2Er3gb+3FeajM70Asl4Dsvs=;
 b=gNRtPMXGRQ2r3gcGvH+Y3zifmjBcnjfWfT8IUfOCazwQKgiwXysjmTlxvKAoYGh+NM
 xpldaXGLjJPErj5zWHSleEBb04hNRzGtv4Edo1hv1SSmpfuX3RtLM3cLCvruDFZbolsR
 T/pcYUGWMROpyu3vUaCFZVVJvvYeBiv2s0Jv0LwpUMnfQPsKmq5PtUKbvYmEQUB6ePc7
 kxQPTPiCO6qha3+C3Pq1GxK7gt33kkij9zyuGYHTW8/s0qJG55LXJ8lHtakkS5n7rZpR
 lO09VzxQBzyW4YR/EURcuE0PnRh3a8V5Jb8CiL8bAU/J/h9HDU4JOULJix92HR8PzfS+
 Yz+g==
X-Gm-Message-State: AOAM530j5P6V0P3bTST19kmrOYcnrOWKbyfSxyQiPohPhnEm0PoLawoi
 7EvK6HSb1l9x1Ov1LAfJn9NRtSpr6zY=
X-Google-Smtp-Source: ABdhPJw6/yFYq+A/4w+lnvP4s++MWTm+UtxUYtje8kiq7LrGL8OgSHRqGsDEyeR1tElp5YgXfHbZfQ==
X-Received: by 2002:a5d:4b51:: with SMTP id w17mr21582470wrs.156.1604334233356; 
 Mon, 02 Nov 2020 08:23:53 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:29a1:b11f:99c9:4261])
 by smtp.gmail.com with ESMTPSA id z11sm23297210wrr.66.2020.11.02.08.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 08:23:52 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix off by one in amdgpu_vm_handle_fault
Date: Mon,  2 Nov 2020 17:23:51 +0100
Message-Id: <20201102162351.1493-1-christian.koenig@amd.com>
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
Cc: felix.kuehling@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhlIHZhbHVlIGlzIGluY2x1c2l2ZSwgbm90IGV4Y2x1c2l2ZS4KClNpZ25lZC1vZmYtYnk6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLmMKaW5kZXggZGMwYmM1NTBlNDJiLi5mZGJlN2Q0ZThiOGIgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5jCkBAIC0zMzUxLDcgKzMzNTEsNyBAQCBib29sIGFtZGdwdV92
bV9oYW5kbGVfZmF1bHQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVuc2lnbmVkIGludCBw
YXNpZCwKIAl9CiAKIAlyID0gYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nKGFkZXYsIGFkZXYs
IHZtLCB0cnVlLCBmYWxzZSwgTlVMTCwgYWRkciwKLQkJCQkJYWRkciArIDEsIGZsYWdzLCB2YWx1
ZSwgTlVMTCwgTlVMTCwKKwkJCQkJYWRkciwgZmxhZ3MsIHZhbHVlLCBOVUxMLCBOVUxMLAogCQkJ
CQlOVUxMKTsKIAlpZiAocikKIAkJZ290byBlcnJvcl91bmxvY2s7Ci0tIAoyLjI1LjEKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
