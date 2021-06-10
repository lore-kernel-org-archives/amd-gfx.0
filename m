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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF67C47094
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 09:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF736613ED
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 09:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF736613ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A39B6EC8F;
	Thu, 10 Jun 2021 09:18:06 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EC746EC8E;
 Thu, 10 Jun 2021 09:18:04 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 l11-20020a05600c4f0bb029017a7cd488f5so5992348wmq.0; 
 Thu, 10 Jun 2021 02:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=JVobQsZTPFsYsVCxBp6A6usqvoqIwJaIiEhjza5mjko=;
 b=iIbQHZsNRhyJVD4JD990ADpAon+nSuconH3dO1YEEeoXxZokSWwvIweUuESfs/Y/oM
 oyZqMvx3APxfGrBIJXxO1SubxMif7cD5+KCb//jwfm+QF4fjltc5eXbZrLcyyA8xQpnh
 A8fPX143nPXj2ZM1kbwIM2Cbb+RjFA5pA2yBdshELIifPIbWDTE2ke9EdTuckmwcyVk4
 XLvHzOSLulqI9PoQtPc7lJOl5xgW1Rkj5PwAnfiyrfU5CJbyWaJ2I2WfXYU3ZGwjo3zl
 NbHtuZmhfHtNB2F6BoHyRxUeezXswbXUbIvXdy7cpgVD4nmUxnxMhgyvKYHCYAWfllrQ
 l9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JVobQsZTPFsYsVCxBp6A6usqvoqIwJaIiEhjza5mjko=;
 b=lq1GVgB6x4prvOeWUIG/1qL26IGmkWTOra1Bwq3wwMsxlJQEVTfSMwJokU1WqJKKxY
 aGhLM8Clo+LeCzfYv5k8VOKGDgioe2s7dNSjDj3/vobpcKzBoZNpJ2hl4GT1XShjAkry
 mKEv0UDTf8MPUIB2l7TjPFhr4+2OZyaWDN9QN/4yYX5CKWsK/iXNDk7s/vY5dFVSiom+
 D2xHGBBQpJ04jOZpdkoJhmJjJEoWspt8Sy+FzRx5IPe39HmtT0Ue0vZdFJB9nkdyTOh1
 BRvsj7bktAm3mnV+MoEScwAEmDDkviJfrj1odWsuWX5F4RMqQFZdMK47NtYtSSvElrKm
 g1vA==
X-Gm-Message-State: AOAM531kfKMnhqGf5Uih3uxNRSTzXUXJZo7nuwQPU87f641RNB2eSnYM
 XHuBS2dOcTDE+4x7MKfCKjM=
X-Google-Smtp-Source: ABdhPJx9jFS46PJDSTjDOqWw8hh0BtBxUPMkQyGe7MhQjhq16Cu0/T2V8QFq9A11V/U8H6ubWpYdZw==
X-Received: by 2002:a05:600c:3b13:: with SMTP id
 m19mr4000783wms.53.1623316683173; 
 Thu, 10 Jun 2021 02:18:03 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:561f:e43a:edf5:8f95])
 by smtp.gmail.com with ESMTPSA id v8sm3087445wrc.29.2021.06.10.02.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jun 2021 02:18:02 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/7] dma-buf: some dma_fence_chain improvements
Date: Thu, 10 Jun 2021 11:17:54 +0200
Message-Id: <20210610091800.1833-2-christian.koenig@amd.com>
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

VGhlIGNhbGxiYWNrIGFuZCB0aGUgaXJxIHdvcmsgYXJlIG5ldmVyIHVzZWQgYXQgdGhlIHNhbWUK
dGltZS4gUHV0dGluZyB0aGVtIGludG8gYW4gdW5pb24gc2F2ZXMgdXMgMjQgYnl0ZXMgYW5kCm1h
a2VzIHRoZSBzdHJ1Y3R1cmUgb25seSAxMjAgYnl0ZXMgaW4gc2l6ZS4KClNpZ25lZC1vZmYtYnk6
IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2RtYS1idWYvZG1hLWZlbmNlLWNoYWluLmMgfCAyICstCiBpbmNsdWRlL2xpbnV4L2RtYS1mZW5j
ZS1jaGFpbi5oICAgfCA4ICsrKysrLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS1idWYvZG1hLWZlbmNl
LWNoYWluLmMgYi9kcml2ZXJzL2RtYS1idWYvZG1hLWZlbmNlLWNoYWluLmMKaW5kZXggN2QxMjll
NjhhYzcwLi4xYjRjYjNlNWNlYzkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtZmVu
Y2UtY2hhaW4uYworKysgYi9kcml2ZXJzL2RtYS1idWYvZG1hLWZlbmNlLWNoYWluLmMKQEAgLTEz
Nyw2ICsxMzcsNyBAQCBzdGF0aWMgdm9pZCBkbWFfZmVuY2VfY2hhaW5fY2Ioc3RydWN0IGRtYV9m
ZW5jZSAqZiwgc3RydWN0IGRtYV9mZW5jZV9jYiAqY2IpCiAJc3RydWN0IGRtYV9mZW5jZV9jaGFp
biAqY2hhaW47CiAKIAljaGFpbiA9IGNvbnRhaW5lcl9vZihjYiwgdHlwZW9mKCpjaGFpbiksIGNi
KTsKKwlpbml0X2lycV93b3JrKCZjaGFpbi0+d29yaywgZG1hX2ZlbmNlX2NoYWluX2lycV93b3Jr
KTsKIAlpcnFfd29ya19xdWV1ZSgmY2hhaW4tPndvcmspOwogCWRtYV9mZW5jZV9wdXQoZik7CiB9
CkBAIC0yMzksNyArMjQwLDYgQEAgdm9pZCBkbWFfZmVuY2VfY2hhaW5faW5pdChzdHJ1Y3QgZG1h
X2ZlbmNlX2NoYWluICpjaGFpbiwKIAlyY3VfYXNzaWduX3BvaW50ZXIoY2hhaW4tPnByZXYsIHBy
ZXYpOwogCWNoYWluLT5mZW5jZSA9IGZlbmNlOwogCWNoYWluLT5wcmV2X3NlcW5vID0gMDsKLQlp
bml0X2lycV93b3JrKCZjaGFpbi0+d29yaywgZG1hX2ZlbmNlX2NoYWluX2lycV93b3JrKTsKIAog
CS8qIFRyeSB0byByZXVzZSB0aGUgY29udGV4dCBvZiB0aGUgcHJldmlvdXMgY2hhaW4gbm9kZS4g
Ki8KIAlpZiAocHJldl9jaGFpbiAmJiBfX2RtYV9mZW5jZV9pc19sYXRlcihzZXFubywgcHJldi0+
c2Vxbm8sIHByZXYtPm9wcykpIHsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZG1hLWZlbmNl
LWNoYWluLmggYi9pbmNsdWRlL2xpbnV4L2RtYS1mZW5jZS1jaGFpbi5oCmluZGV4IDEwNDYyYTAy
OWRhMi4uOWQ2YTA2MmJlNjQwIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2RtYS1mZW5jZS1j
aGFpbi5oCisrKyBiL2luY2x1ZGUvbGludXgvZG1hLWZlbmNlLWNoYWluLmgKQEAgLTI1LDEyICsy
NSwxNCBAQAogICovCiBzdHJ1Y3QgZG1hX2ZlbmNlX2NoYWluIHsKIAlzdHJ1Y3QgZG1hX2ZlbmNl
IGJhc2U7Ci0Jc3BpbmxvY2tfdCBsb2NrOwogCXN0cnVjdCBkbWFfZmVuY2UgX19yY3UgKnByZXY7
CiAJdTY0IHByZXZfc2Vxbm87CiAJc3RydWN0IGRtYV9mZW5jZSAqZmVuY2U7Ci0Jc3RydWN0IGRt
YV9mZW5jZV9jYiBjYjsKLQlzdHJ1Y3QgaXJxX3dvcmsgd29yazsKKwl1bmlvbiB7CisJCXN0cnVj
dCBkbWFfZmVuY2VfY2IgY2I7CisJCXN0cnVjdCBpcnFfd29yayB3b3JrOworCX07CisJc3Bpbmxv
Y2tfdCBsb2NrOwogfTsKIAogZXh0ZXJuIGNvbnN0IHN0cnVjdCBkbWFfZmVuY2Vfb3BzIGRtYV9m
ZW5jZV9jaGFpbl9vcHM7Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
