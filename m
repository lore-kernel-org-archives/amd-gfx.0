Return-Path: <SRS0=GnFq=3T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E90C33C9E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 12:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 173C3206D3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 12:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lj7G6XIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173C3206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30EB86F99A;
	Thu, 30 Jan 2020 12:49:47 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C44936F99A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 12:49:46 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id z3so3914218wru.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 04:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Bv7uxhdDwdgsaQ9kia4qPDCk1JsjMi4MINZ+gIO6XMU=;
 b=lj7G6XIMTcU9xHXWsKbTOxp3PDdmwGQ9dbptTrhSN5nGAmFr8FuORUziGcbM2IDVPl
 5ODVCgDWALA+RMNmDfb3p8D6rSeHhWmp85YHQRoEl4BJTgw1Y3BHY3CmqKJUKJPlFeLZ
 ixZ5ovycrG+SFpuB64WvwHDiVFz2zNxBw3xSAgGpcs4Q9pPYUfYJvq6wpCnkeqR1DnOI
 39S23Hk6bhtrUbOSgzYucL8WBocHNhHKD05RC1kiVJXtaA9yJBBClXo72bwqYKgKaDwy
 dXaQ5tly+6z5UfL1EJBJENMFZan236/DRPogvm3eppMQ4URFppGiPduTqHlEWVzmEcw3
 2tBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Bv7uxhdDwdgsaQ9kia4qPDCk1JsjMi4MINZ+gIO6XMU=;
 b=sbP6uh7tw47IHItETPojSo8fQ/Ym1/BG36uV7nSUGv3SpDXM0kDNPL9xLL5MkifkYH
 kLPPIHpFZU3NGNDs+JlNQNdXFBsOch5KBfxdP2TOFjbImeI2L/xwc8w3AbI6RvlzLPAo
 GMCY9RMjYi7x3yetZX6EIa/yYCFeYdW7/OelSnwHxFvdL9FgxmromIakGpZcstWlW3re
 xRGFF1IE4VOZB7SR4Dh88xpLuZQEiMoO/1UJqwH8RX7BL13f82p0sl+r8Qa0Q0ykLfcB
 rd9DsZfk2Dnt+mTSoZ8e31oaTN8Tq4/XgRLBG66VoYr74soWsc32lCjy54moxJXyYoMi
 RPpA==
X-Gm-Message-State: APjAAAXeGp4yNK7xdjONdxYJW366VT3H/tmIdQhP4PKUz6SiM8pJbs7x
 oAQwEsIpSIns3DahMEBNWfH3QTNj
X-Google-Smtp-Source: APXvYqyO0CLs9hvOe1jtlkcz4y1Y8T1WkvDJTnAEpBkYvmlA+r6UvNSmR7kBfryJvg4Jo5jC6vl4QA==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr5762421wrc.175.1580388585136; 
 Thu, 30 Jan 2020 04:49:45 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:dc0f:106a:b4b9:c241])
 by smtp.gmail.com with ESMTPSA id i2sm6496912wmb.28.2020.01.30.04.49.44
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 04:49:44 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/5] drm/amdgpu: allow higher level PD invalidations
Date: Thu, 30 Jan 2020 13:49:38 +0100
Message-Id: <20200130124940.30380-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200130124940.30380-1-christian.koenig@amd.com>
References: <20200130124940.30380-1-christian.koenig@amd.com>
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

QWxsb3cgcGFydGlhbCBpbnZhbGlkYXRpb24gb24gdW5hbGxvY2F0ZWQgUERzLiBUaGlzIGlzIHVz
ZWZ1bCB3aGVuIHdlCm5lZWQgdG8gc2lsZW5jZSBmYXVsdHMgdG8gc3RvcCBpbnRlcnJ1cHQgZmxv
b2RzIG9uIFZlZ2EuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+ClRlc3RlZC1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQu
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMjMgKysr
KysrKysrKysrKysrKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA1
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKaW5kZXgg
OTcwNWM5NjE0MDViLi42MDM4YjNjODk2MzMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jCkBAIC0xNDY3LDkgKzE0NjcsOCBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV91cGRh
dGVfcHRlcyhzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnBhcmFtcywKIAkJCSAqIHNt
YWxsZXIgdGhhbiB0aGUgYWRkcmVzcyBzaGlmdC4gR28gdG8gdGhlIG5leHQKIAkJCSAqIGNoaWxk
IGVudHJ5IGFuZCB0cnkgYWdhaW4uCiAJCQkgKi8KLQkJCWlmICghYW1kZ3B1X3ZtX3B0X2Rlc2Nl
bmRhbnQoYWRldiwgJmN1cnNvcikpCi0JCQkJcmV0dXJuIC1FTk9FTlQ7Ci0JCQljb250aW51ZTsK
KwkJCWlmIChhbWRncHVfdm1fcHRfZGVzY2VuZGFudChhZGV2LCAmY3Vyc29yKSkKKwkJCQljb250
aW51ZTsKIAkJfSBlbHNlIGlmIChmcmFnID49IHBhcmVudF9zaGlmdCkgewogCQkJLyogSWYgdGhl
IGZyYWdtZW50IHNpemUgaXMgZXZlbiBsYXJnZXIgdGhhbiB0aGUgcGFyZW50CiAJCQkgKiBzaGlm
dCB3ZSBzaG91bGQgZ28gdXAgb25lIGxldmVsIGFuZCBjaGVjayBpdCBhZ2Fpbi4KQEAgLTE0ODAs
OCArMTQ3OSwxOSBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV91cGRhdGVfcHRlcyhzdHJ1Y3QgYW1k
Z3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnBhcmFtcywKIAkJfQogCiAJCXB0ID0gY3Vyc29yLmVudHJ5
LT5iYXNlLmJvOwotCQlpZiAoIXB0KQotCQkJcmV0dXJuIC1FTk9FTlQ7CisJCWlmICghcHQpIHsK
KwkJCS8qIFdlIG5lZWQgYWxsIFBEcyBhbmQgUFRzIGZvciBtYXBwaW5nIHNvbWV0aGluZywgKi8K
KwkJCWlmIChmbGFncyAmIEFNREdQVV9QVEVfVkFMSUQpCisJCQkJcmV0dXJuIC1FTk9FTlQ7CisK
KwkJCS8qIGJ1dCB1bm1hcHBpbmcgc29tZXRoaW5nIGNhbiBoYXBwZW4gYXQgYSBoaWdoZXIKKwkJ
CSAqIGxldmVsLiAqLworCQkJaWYgKCFhbWRncHVfdm1fcHRfYW5jZXN0b3IoJmN1cnNvcikpCisJ
CQkJcmV0dXJuIC1FSU5WQUw7CisKKwkJCXB0ID0gY3Vyc29yLmVudHJ5LT5iYXNlLmJvOworCQkJ
c2hpZnQgPSBwYXJlbnRfc2hpZnQ7CisJCX0KIAogCQkvKiBMb29rcyBnb29kIHNvIGZhciwgY2Fs
Y3VsYXRlIHBhcmFtZXRlcnMgZm9yIHRoZSB1cGRhdGUgKi8KIAkJaW5jciA9ICh1aW50NjRfdClB
TURHUFVfR1BVX1BBR0VfU0laRSA8PCBzaGlmdDsKQEAgLTE0OTUsNiArMTUwNSw5IEBAIHN0YXRp
YyBpbnQgYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFt
cyAqcGFyYW1zLAogCQkJdWludDY0X3QgdXBkX2VuZCA9IG1pbihlbnRyeV9lbmQsIGZyYWdfZW5k
KTsKIAkJCXVuc2lnbmVkIG5wdGVzID0gKHVwZF9lbmQgLSBmcmFnX3N0YXJ0KSA+PiBzaGlmdDsK
IAorCQkJLyogVGhpcyBjYW4gaGFwcGVuIHdoZW4gd2Ugc2V0IGhpZ2hlciBsZXZlbCBQRHMgdG8K
KwkJCSAqIHNpbGVudCB0byBzdG9wIGZhdWx0IGZsb29kcy4gKi8KKwkJCW5wdGVzID0gbWF4KG5w
dGVzLCAxdSk7CiAJCQlhbWRncHVfdm1fdXBkYXRlX2ZsYWdzKHBhcmFtcywgcHQsIGN1cnNvci5s
ZXZlbCwKIAkJCQkJICAgICAgIHBlX3N0YXJ0LCBkc3QsIG5wdGVzLCBpbmNyLAogCQkJCQkgICAg
ICAgZmxhZ3MgfCBBTURHUFVfUFRFX0ZSQUcoZnJhZykpOwotLSAKMi4xNy4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
