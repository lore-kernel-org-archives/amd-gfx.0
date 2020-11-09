Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153A0C56202
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF27206ED
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b5h89XM0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF27206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7353C8968D;
	Mon,  9 Nov 2020 21:21:43 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91D1A895B6
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 21:19:33 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id h62so911894wme.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2020 13:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e/mxdauGCfin4P1unK7sTKqBRJWd95ferwSgYprlXsM=;
 b=b5h89XM0bSAA01H9VI7YC0WubiXdlYohWOGdakYwfbQeM0MifG/HJ7RiJjyS8bNAqv
 Yq0xrDdJ/NdDCYnAvDV+Gz94LXJqrl3Y9rQ1xU5cQVElcN9MRBYPt7zShja/Bk9UKiY+
 WqQGtf5m5oHpwx0PpT6vx6sx0WU+595ypt6m//MfqLkRGLEVbmlBXKkjvjc4+0QCw5SY
 32zJqgbybJVw0CEE2G/rBftR+lVzzS50Z19Gnxv32vnSAyV0pO+I/ApDOOXfswqPnmLU
 rAqt+Z5FRuuTuszclEWd6FGcuvBK9Rvt+6Q2ubDA7I6UNZGYzp4HdqjtuyoOZzsm2oeB
 Q+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e/mxdauGCfin4P1unK7sTKqBRJWd95ferwSgYprlXsM=;
 b=Ko74tp3UvVzumLEk/NC9LD/ES80TniCbjmD0NHy2hTMtVhObo/vxWNLAPkDJEtaY75
 1mhK/ArgBulwqUvYSpQLgXUHE/XAvR3JZVyGkOFqDgb+PKtPe/cv2cQHFVDI7lgjaHHX
 lTQ7mXin9BXugMe/edDJUDDCKTUAYiCBNyTYizUkRpAn/orrPGXEAFp1iW7l9QlpK8K9
 4UeuKtYUjYUzCGodnLzVtrRNkwZjUTyQhunIcaatg5OrbRRH1EatGcsd3Kvc3Bx+kKsS
 rVqn0vKXT+Ui1iKPNh4wHrwXqpzI+3pOsnHkzgEgovqPhwKsJEo9Oi4pbLSwzU79qmUT
 CDyA==
X-Gm-Message-State: AOAM530G1+96XVrnj+uyWYpCTdaudT37p/zVE70RzeaD2cZsANaFG2D5
 68RV+tyZBv0xmTfUlWIvca8s3UPjXDAVBQCs
X-Google-Smtp-Source: ABdhPJxxFY7gIh1xOMJZO9bky0lc6wrxtmYioHA4roB/Bb4hQn3EO/H57QfVq/ydFUCTODr9S7X8CA==
X-Received: by 2002:a1c:6545:: with SMTP id z66mr1082675wmb.157.1604956772232; 
 Mon, 09 Nov 2020 13:19:32 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 71sm15170630wrm.20.2020.11.09.13.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 13:19:31 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 12/20] drm/radeon/radeon_cs: Fix a bunch of doc-rot issues
Date: Mon,  9 Nov 2020 21:18:47 +0000
Message-Id: <20201109211855.3340030-13-lee.jones@linaro.org>
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
 linaro-mm-sig@lists.linaro.org, Jerome Glisse <glisse@freedesktop.org>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fY3MuYzo0MTY6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFt
ZXRlciBvciBtZW1iZXIgJ2JhY2tvZmYnIG5vdCBkZXNjcmliZWQgaW4gJ3JhZGVvbl9jc19wYXJz
ZXJfZmluaScKIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2NzLmM6NzM1OiB3YXJuaW5n
OiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdwJyBub3QgZGVzY3JpYmVkIGluICdyYWRl
b25fY3NfcGFja2V0X3BhcnNlJwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fY3MuYzo3
MzU6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2lkeCcgbm90IGRlc2Ny
aWJlZCBpbiAncmFkZW9uX2NzX3BhY2tldF9wYXJzZScKIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24v
cmFkZW9uX2NzLmM6NzM1OiB3YXJuaW5nOiBFeGNlc3MgZnVuY3Rpb24gcGFyYW1ldGVyICdwYXJz
ZXInIGRlc2NyaXB0aW9uIGluICdyYWRlb25fY3NfcGFja2V0X3BhcnNlJwogZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9yYWRlb25fY3MuYzo4NDQ6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBv
ciBtZW1iZXIgJ3AnIG5vdCBkZXNjcmliZWQgaW4gJ3JhZGVvbl9jc19wYWNrZXRfbmV4dF9yZWxv
YycKIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2NzLmM6ODQ0OiB3YXJuaW5nOiBGdW5j
dGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdjc19yZWxvYycgbm90IGRlc2NyaWJlZCBpbiAncmFk
ZW9uX2NzX3BhY2tldF9uZXh0X3JlbG9jJwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25f
Y3MuYzo4NDQ6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ25vbW0nIG5v
dCBkZXNjcmliZWQgaW4gJ3JhZGVvbl9jc19wYWNrZXRfbmV4dF9yZWxvYycKIGRyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcmFkZW9uX2NzLmM6ODQ0OiB3YXJuaW5nOiBFeGNlc3MgZnVuY3Rpb24gcGFy
YW1ldGVyICdwYXJzZXInIGRlc2NyaXB0aW9uIGluICdyYWRlb25fY3NfcGFja2V0X25leHRfcmVs
b2MnCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9jcy5jOjg0NDogd2FybmluZzogRXhj
ZXNzIGZ1bmN0aW9uIHBhcmFtZXRlciAnZGF0YScgZGVzY3JpcHRpb24gaW4gJ3JhZGVvbl9jc19w
YWNrZXRfbmV4dF9yZWxvYycKIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2NzLmM6ODQ0
OiB3YXJuaW5nOiBFeGNlc3MgZnVuY3Rpb24gcGFyYW1ldGVyICdvZmZzZXRfc3RhcnQnIGRlc2Ny
aXB0aW9uIGluICdyYWRlb25fY3NfcGFja2V0X25leHRfcmVsb2MnCiBkcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3JhZGVvbl9jcy5jOjg0NDogd2FybmluZzogRXhjZXNzIGZ1bmN0aW9uIHBhcmFtZXRl
ciAnb2Zmc2V0X21hc2snIGRlc2NyaXB0aW9uIGluICdyYWRlb25fY3NfcGFja2V0X25leHRfcmVs
b2MnCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9jcy5jOjg0NDogd2FybmluZzogRXhj
ZXNzIGZ1bmN0aW9uIHBhcmFtZXRlciAncmVsb2MnIGRlc2NyaXB0aW9uIGluICdyYWRlb25fY3Nf
cGFja2V0X25leHRfcmVsb2MnCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxk
YW5pZWxAZmZ3bGwuY2g+CkNjOiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8ub3Jn
PgpDYzogSmVyb21lIEdsaXNzZSA8Z2xpc3NlQGZyZWVkZXNrdG9wLm9yZz4KQ2M6IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
CkNjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmcKQ2M6IGxpbmFyby1tbS1zaWdAbGlzdHMu
bGluYXJvLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3Jn
PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2NzLmMgfCAxMiArKysrKystLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fY3MuYyBiL2RyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcmFkZW9uX2NzLmMKaW5kZXggMjFjZTJmOTUwMmMwOS4uNzI5OTM5ZGYyOWNj
NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fY3MuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9jcy5jCkBAIC00MDgsNiArNDA4LDcgQEAgc3Rh
dGljIGludCBjbXBfc2l6ZV9zbWFsbGVyX2ZpcnN0KHZvaWQgKnByaXYsIHN0cnVjdCBsaXN0X2hl
YWQgKmEsCiAgKiBjc19wYXJzZXJfZmluaSgpIC0gY2xlYW4gcGFyc2VyIHN0YXRlcwogICogQHBh
cnNlcjoJcGFyc2VyIHN0cnVjdHVyZSBob2xkaW5nIHBhcnNpbmcgY29udGV4dC4KICAqIEBlcnJv
cjoJZXJyb3IgbnVtYmVyCisgKiBAYmFja29mZjoJaW5kaWNhdG9yIHRvIGJhY2tvZmYgdGhlIHJl
c2VydmF0aW9uCiAgKgogICogSWYgZXJyb3IgaXMgc2V0IHRoYW4gdW52YWxpZGF0ZSBidWZmZXIs
IG90aGVyd2lzZSBqdXN0IGZyZWUgbWVtb3J5CiAgKiB1c2VkIGJ5IHBhcnNpbmcgY29udGV4dC4K
QEAgLTcyMyw4ICs3MjQsOSBAQCBpbnQgcmFkZW9uX2NzX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNl
ICpkZXYsIHZvaWQgKmRhdGEsIHN0cnVjdCBkcm1fZmlsZSAqZmlscCkKIAogLyoqCiAgKiByYWRl
b25fY3NfcGFja2V0X3BhcnNlKCkgLSBwYXJzZSBjcCBwYWNrZXQgYW5kIHBvaW50IGliIGluZGV4
IHRvIG5leHQgcGFja2V0Ci0gKiBAcGFyc2VyOglwYXJzZXIgc3RydWN0dXJlIGhvbGRpbmcgcGFy
c2luZyBjb250ZXh0LgorICogQHA6CQlwYXJzZXIgc3RydWN0dXJlIGhvbGRpbmcgcGFyc2luZyBj
b250ZXh0LgogICogQHBrdDoJd2hlcmUgdG8gc3RvcmUgcGFja2V0IGluZm9ybWF0aW9uCisgKiBA
aWR4OglwYWNrZXQgaW5kZXgKICAqCiAgKiBBc3N1bWUgdGhhdCBjaHVua19pYl9pbmRleCBpcyBw
cm9wZXJseSBzZXQuIFdpbGwgcmV0dXJuIC1FSU5WQUwKICAqIGlmIHBhY2tldCBpcyBiaWdnZXIg
dGhhbiByZW1haW5pbmcgaWIgc2l6ZS4gb3IgaWYgcGFja2V0cyBpcyB1bmtub3duLgpAQCAtODI5
LDExICs4MzEsOSBAQCB2b2lkIHJhZGVvbl9jc19kdW1wX3BhY2tldChzdHJ1Y3QgcmFkZW9uX2Nz
X3BhcnNlciAqcCwKIAogLyoqCiAgKiByYWRlb25fY3NfcGFja2V0X25leHRfcmVsb2MoKSAtIHBh
cnNlIG5leHQgKHNob3VsZCBiZSByZWxvYykgcGFja2V0Ci0gKiBAcGFyc2VyOgkJcGFyc2VyIHN0
cnVjdHVyZSBob2xkaW5nIHBhcnNpbmcgY29udGV4dC4KLSAqIEBkYXRhOgkJcG9pbnRlciB0byBy
ZWxvY2F0aW9uIGRhdGEKLSAqIEBvZmZzZXRfc3RhcnQ6CXN0YXJ0aW5nIG9mZnNldAotICogQG9m
ZnNldF9tYXNrOglvZmZzZXQgbWFzayAodG8gYWxpZ24gc3RhcnQgb2Zmc2V0IG9uKQotICogQHJl
bG9jOgkJcmVsb2MgaW5mb3JtYXRpb25zCisgKiBAcDoJCQlwYXJzZXIgc3RydWN0dXJlIGhvbGRp
bmcgcGFyc2luZyBjb250ZXh0LgorICogQGNzX3JlbG9jOgkJcmVsb2MgaW5mb3JtYXRpb25zCisg
KiBAbm9tbToJCW5ldmVyIGFjdHVhbGx5IHVzZWQKICAqCiAgKiBDaGVjayBpZiBuZXh0IHBhY2tl
dCBpcyByZWxvY2F0aW9uIHBhY2tldDMsIGRvIGJvIHZhbGlkYXRpb24gYW5kIGNvbXB1dGUKICAq
IEdQVSBvZmZzZXQgdXNpbmcgdGhlIHByb3ZpZGVkIHN0YXJ0LgotLSAKMi4yNS4xCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
