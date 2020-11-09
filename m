Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5347C6379D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D851206ED
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCa++B8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D851206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD9988972D;
	Mon,  9 Nov 2020 21:21:47 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 942AA895C4
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 21:19:36 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id h2so961979wmm.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2020 13:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f19bG5OlKZrzXa9sIoz5zZmJ+HLtlGgA3VlLSxdphFA=;
 b=aCa++B8skb7N4286tYGRf0uVCE5RA7rp82ko+LOn4nj7tYdW1Try+em3OvGh7LqyHJ
 MRu9QWNM2UQmP4ba30mnVaQj4DEhUYiDtJAvbyg6Z4WqzCMSMMBCywL5BuHEKRLTQ3Nt
 2X145Ci6pyLdMT7zFdh2R7fTC99dcrsXD0EYw9LuP3OsGdalYW3SAGUiCeNOmz/E9yEK
 mchlHxBojyQih21VMFDS9OpCNNLApP66gmN4r2PoS0bM6GwOpg6mRa2jMWrpl7BtEGXH
 FFXqxiP6DlTTZZGtyKGVzWqpe9Tq3bxgTloLVFtq3gA13n/n1cc5NsUa3HUiCib0YktV
 cJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=f19bG5OlKZrzXa9sIoz5zZmJ+HLtlGgA3VlLSxdphFA=;
 b=SgnmegzpjfRb7nEVz97/GkWgoVKsl6TtyIMNlScuJz1pmwB+ykiQ6XLMvosYR/ZC3a
 3T9LRC9dvUygvx2RyfSUNfLCyrNiUxaG5ddS9m85oIcKYaQWB8AjtcJDj3AswAHWwg0L
 OyDPiO8VQ4RPNrV8OSSI4C7EIcH/673DFANaAkL+2d8KneRoTb57sL8ff4Uh2+h17Dmx
 ZSm290rmkbYNErd2RjCfHw/6KmhJ137sXI6+ah1e/1MiJDVFkb9a8Q8H1SM3GkW03eB9
 RJ/YKnG0TkBW8wS3VW+TLztGi0GZ25O1I7WpsKqY1S0FGY2feGa0iCJcnjLP63m8Hp8p
 g65w==
X-Gm-Message-State: AOAM531WFbIcI10pd+RCtE1zfEWrwuCRla7EmqpTqfkHmisPQE/5zF3k
 jenKdxpqrx90DrnThxmmIOLSLw==
X-Google-Smtp-Source: ABdhPJwQU+oNyhuK8854ZDn2P3n7yVLK4Po3zrKf1ArE64AewxBRgP1hJdqCM5548erM822qPbeZIw==
X-Received: by 2002:a1c:2905:: with SMTP id p5mr1138832wmp.187.1604956775281; 
 Mon, 09 Nov 2020 13:19:35 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 71sm15170630wrm.20.2020.11.09.13.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 13:19:34 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 14/20] drm/radeon: Move 'radeon_pm_acpi_event_handler'
 prototype into shared header
Date: Mon,  9 Nov 2020 21:18:49 +0000
Message-Id: <20201109211855.3340030-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109211855.3340030-1-lee.jones@linaro.org>
References: <20201109211855.3340030-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 09 Nov 2020 21:21:41 +0000
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
cy9ncHUvZHJtL3JhZGVvbi9ydjc3MC5jOjExMzg6Njogd2FybmluZzogbm8gcHJldmlvdXMgcHJv
dG90eXBlIGZvciDigJhydjc3MF9zZXRfY2xrX2J5cGFzc19tb2Rl4oCZIFstV21pc3NpbmctcHJv
dG90eXBlc10KIDExMzggfCB2b2lkIHJ2NzcwX3NldF9jbGtfYnlwYXNzX21vZGUoc3RydWN0IHJh
ZGVvbl9kZXZpY2UgKnJkZXYpCiB8IF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KCkNjOiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5p
ZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBs
aW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IFN1bWl0IFNl
bXdhbCA8c3VtaXQuc2Vtd2FsQGxpbmFyby5vcmc+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogbGludXgtbWVk
aWFAdmdlci5rZXJuZWwub3JnCkNjOiBsaW5hcm8tbW0tc2lnQGxpc3RzLmxpbmFyby5vcmcKU2ln
bmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3JhZGVvbi5oICAgICAgfCAxICsKIGRyaXZlcnMvZ3B1L2RybS9yYWRl
b24vcmFkZW9uX2FjcGkuYyB8IDIgLS0KIDIgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRl
b24uaCBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uLmgKaW5kZXggMzJhMmM4OTRlZTNm
Zi4uMWNiYmFmZjdjZWRlMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRl
b24uaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbi5oCkBAIC0yOTEsNiArMjkx
LDcgQEAgdm9pZCByYWRlb25fcG1fZmluaShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7CiB2
b2lkIHJhZGVvbl9wbV9jb21wdXRlX2Nsb2NrcyhzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7
CiB2b2lkIHJhZGVvbl9wbV9zdXNwZW5kKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKIHZv
aWQgcmFkZW9uX3BtX3Jlc3VtZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7Cit2b2lkIHJh
ZGVvbl9wbV9hY3BpX2V2ZW50X2hhbmRsZXIoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwog
dm9pZCByYWRlb25fY29tYmlvc19nZXRfcG93ZXJfbW9kZXMoc3RydWN0IHJhZGVvbl9kZXZpY2Ug
KnJkZXYpOwogdm9pZCByYWRlb25fYXRvbWJpb3NfZ2V0X3Bvd2VyX21vZGVzKHN0cnVjdCByYWRl
b25fZGV2aWNlICpyZGV2KTsKIGludCByYWRlb25fYXRvbV9nZXRfY2xvY2tfZGl2aWRlcnMoc3Ry
dWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYsCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3JhZGVvbl9hY3BpLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9hY3BpLmMK
aW5kZXggNmNmMTY0NWU3YTFhOC4uMGViNTk0YjU2YWY4YyAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9yYWRlb25fYWNwaS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24v
cmFkZW9uX2FjcGkuYwpAQCAtNDUsOCArNDUsNiBAQCBzdGF0aWMgaW5saW5lIGJvb2wgcmFkZW9u
X2F0cHhfZGdwdV9yZXFfcG93ZXJfZm9yX2Rpc3BsYXlzKHZvaWQpIHsgcmV0dXJuIGZhbHNlOwog
CiAjZGVmaW5lIEFDUElfQUNfQ0xBU1MgICAgICAgICAgICJhY19hZGFwdGVyIgogCi1leHRlcm4g
dm9pZCByYWRlb25fcG1fYWNwaV9ldmVudF9oYW5kbGVyKHN0cnVjdCByYWRlb25fZGV2aWNlICpy
ZGV2KTsKLQogc3RydWN0IGF0aWZfdmVyaWZ5X2ludGVyZmFjZSB7CiAJdTE2IHNpemU7CQkvKiBz
dHJ1Y3R1cmUgc2l6ZSBpbiBieXRlcyAoaW5jbHVkZXMgc2l6ZSBmaWVsZCkgKi8KIAl1MTYgdmVy
c2lvbjsJCS8qIHZlcnNpb24gKi8KLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
