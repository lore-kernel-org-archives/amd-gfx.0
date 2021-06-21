Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBF3C4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 13:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006F361156
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 13:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006F361156
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E7F389FE8;
	Mon, 21 Jun 2021 13:03:33 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49BC689FDB;
 Mon, 21 Jun 2021 13:03:32 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id gt18so28630442ejc.11;
 Mon, 21 Jun 2021 06:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=TiHXO7JP6QF/TlhNPUn6GBOddFEqJ09ltmC4zViGvew=;
 b=iWZJnpSYvoIc7VR5hoZ6pVw0UObiHwYug2ePRkJevmFtNx7p+1gE4bqfB745LFm7Do
 fWDV001MXBdNnRQOwAibk1RS+vtfRDbm3wovAaVpDQKRRDQI+N2Ks77ji4FCT+ArjzR+
 JFcEMen4CfeGNtoQaIZqOO4wixrPMT0K05m6rzDUfFdT2G26A7JFljxILQ8L9wDVuOA3
 KroFRINXu3WvNJUEwUcxTwUKCbruDhwaxP+YoiO2ZVwhFbbht+OEXlwfHreGadXljVdn
 Nolmeg9G7Aofz43IG4XkCAV+rkYsScUM9G2vTI0sYxZDLs1IcHH5pGpzaQJu2Uy4AEI1
 sMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TiHXO7JP6QF/TlhNPUn6GBOddFEqJ09ltmC4zViGvew=;
 b=LetwoqbMAwTchwQtzpkGvMp7LpkK4Gqxm+Q6ubjfGqpll/yAyrg9Nef1CG9S+wdGeD
 5WmmO+tEu5akYf5cEAnUPd/IZeH2VWyK1Ivqib4Sc6iQ/Px8J5mHh9Hz99aGORDxYWUw
 bjzWIAcvAPyiaZmTowzCkrOHXtf6N9oBt8k/e2XFlFEaptR3hun5oZFhBTUw1OiH5Dg2
 sINppb8CSdDGq9Rl25+ETRxXQcn+V74D490+6drwVpyA1Tzz4ZpRGfebv5WBx0tQWXZg
 eZKQ0nZSkCqrROiH6Y4C5T6wnjMIfY/lc73NYfMp2wOtN+yXyp5h+uviRpCAUk4Y/x5z
 WJFA==
X-Gm-Message-State: AOAM532YXW57NsCZ7b9dF/KZRRFNosWyiPDJo+D4Ji/leHnIcXHit99h
 BwfbZNCtdrJXAV2CMuAVktB0xihZg08=
X-Google-Smtp-Source: ABdhPJwJUO1G99EcRo8+JIZJJJ9Z6wwTZVLD0RMA36aaD0El+Rln+vOVjF7PNnM2L0oihYfvhRMGnA==
X-Received: by 2002:a17:906:ce29:: with SMTP id
 sd9mr4775332ejb.56.1624280611016; 
 Mon, 21 Jun 2021 06:03:31 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:bd92:da7:4d23:8910])
 by smtp.gmail.com with ESMTPSA id w10sm5322375edv.34.2021.06.21.06.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jun 2021 06:03:30 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
 nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: wait for moving fence after pinning
Date: Mon, 21 Jun 2021 15:03:28 +0200
Message-Id: <20210621130328.11070-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210621130328.11070-1-christian.koenig@amd.com>
References: <20210621130328.11070-1-christian.koenig@amd.com>
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

V2UgYWN0dWFsbHkgbmVlZCB0byB3YWl0IGZvciB0aGUgbW92aW5nIGZlbmNlIGFmdGVyIHBpbm5p
bmcKdGhlIEJPIHRvIG1ha2Ugc3VyZSB0aGF0IHRoZSBwaW4gaXMgY29tcGxldGVkLgoKU2lnbmVk
LW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDQzog
c3RhYmxlQGtlcm5lbC5vcmcKLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZG1hX2J1Zi5jIHwgMTQgKysrKysrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RtYV9idWYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kbWFfYnVmLmMKaW5kZXggYmFhOTgwYTQ3N2Q5Li4zN2VjNTkzNjUwODAgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYuYwpAQCAtMjE0LDkgKzIxNCwyMSBA
QCBzdGF0aWMgaW50IGFtZGdwdV9kbWFfYnVmX3BpbihzdHJ1Y3QgZG1hX2J1Zl9hdHRhY2htZW50
ICphdHRhY2gpCiB7CiAJc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmogPSBhdHRhY2gtPmRtYWJ1
Zi0+cHJpdjsKIAlzdHJ1Y3QgYW1kZ3B1X2JvICpibyA9IGdlbV90b19hbWRncHVfYm8ob2JqKTsK
KwlpbnQgcjsKIAogCS8qIHBpbiBidWZmZXIgaW50byBHVFQgKi8KLQlyZXR1cm4gYW1kZ3B1X2Jv
X3BpbihibywgQU1ER1BVX0dFTV9ET01BSU5fR1RUKTsKKwlyID0gYW1kZ3B1X2JvX3Bpbihibywg
QU1ER1BVX0dFTV9ET01BSU5fR1RUKTsKKwlpZiAocikKKwkJcmV0dXJuIHI7CisKKwlpZiAoYm8t
PnRiby5tb3ZpbmcpIHsKKwkJciA9IGRtYV9mZW5jZV93YWl0KGJvLT50Ym8ubW92aW5nLCB0cnVl
KTsKKwkJaWYgKHIpIHsKKwkJCWFtZGdwdV9ib191bnBpbihibyk7CisJCQlyZXR1cm4gcjsKKwkJ
fQorCX0KKwlyZXR1cm4gMDsKIH0KIAogLyoqCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
