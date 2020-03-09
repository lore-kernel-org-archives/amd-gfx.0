Return-Path: <SRS0=uBoY=42=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE675C18E5A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 12:55:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5D2A20675
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 12:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZB/gD1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D2A20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 843F589F07;
	Mon,  9 Mar 2020 12:55:57 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FCC089CDF
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2020 12:55:56 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id s5so7070672wrg.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Mar 2020 05:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iaKP81dlr2RwryChCephAZaMPcU1Gb/Vd+BWPQdyXDE=;
 b=tZB/gD1MLI8vE5V551t8ZjdvUwZ30cYt38o38cD/MQBhn5gh7DjqtisgCL/7di5Ejk
 +E+TR2TZpRq56RkgOV0e36tuKyVdhv0Km3XECfuvrVihU/OHJTy6eeYVJUn9UvIdIzAd
 42tMV/kIhVYo1CDDU1GrInfHmvgdr9Brz3hXUUxC6BBFgE0v0PB9e2uzML4KmY8VrCbk
 iYYxLLN3bjpZdkuDcTzSMLbE0COkzB8xGKDwA6PkFVoXIyLGtyV3dTy/MA95DaoD/dNs
 rAWVOb29Ua/uQXy7qDlTlOJOq0dYt8EC+rmukrjm6vE+pGQ1ZFaq+LZUxO4cwHK6u7jW
 T+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iaKP81dlr2RwryChCephAZaMPcU1Gb/Vd+BWPQdyXDE=;
 b=Opf6qD5RCRZL3xDv5poQVVgnSUncQIWZvz8bq7KyN49EAxQ309MyqDSHVxJqe5XNCJ
 yr4LOPdyFCQ3IqM31N9ejwNncLMSWdqd7VA/h8M+KIFdPDsgprbPPRlTu3uxgLO3Vkoh
 YJBwFPZ6cJuiZGp58lr5QfPx1DOt+m9XLzwYBTZ2Wv6wgJR3QXVC5eoi32OdIlFJ8Yh7
 hbG6fNvP1WO1/WP5eTfj7ooYpyX/ZU/bYF/uSmonGgRkwslybM6+xTxB4y1CzxFAQE35
 1lTrvzerJzwd2Th7Pq7XSVmDpsDUzOuCQwGDF6rBjqEek8wLAGKOyuBOy9rf2q6MrpA3
 8FdQ==
X-Gm-Message-State: ANhLgQ2lG9yyA9hNmSFblnPsuP7+0YcRxTX0ECntJMlyv2SM+hXztb3s
 8dJLPsCDCGV0iK/DgfQDCZ1Kkt5PCsw=
X-Google-Smtp-Source: ADFU+vuUawDdx7drkj+QHv5QOoYEZgr1xyzimhZh0GkpGhnVslPWSmLqp0r2PsRWYJCpBrgIkbpWfg==
X-Received: by 2002:a5d:674a:: with SMTP id l10mr9861856wrw.148.1583758554522; 
 Mon, 09 Mar 2020 05:55:54 -0700 (PDT)
Received: from brihaspati.fritz.box
 (p200300C58F2ACB00753B9E7FA9FFF13D.dip0.t-ipconnect.de.
 [2003:c5:8f2a:cb00:753b:9e7f:a9ff:f13d])
 by smtp.gmail.com with ESMTPSA id z19sm2950426wma.41.2020.03.09.05.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 05:55:54 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/scheduler: implement a function to modify sched list
Date: Mon,  9 Mar 2020 13:59:18 +0100
Message-Id: <20200309125920.7437-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200309125920.7437-1-nirmoy.das@amd.com>
References: <20200309125920.7437-1-nirmoy.das@amd.com>
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SW1wbGVtZW50IGRybV9zY2hlZF9lbnRpdHlfbW9kaWZ5X3NjaGVkKCkgd2hpY2ggbW9kaWZpZXMg
ZXhpc3RpbmcKc2NoZWRfbGlzdCB3aXRoIGEgZGlmZmVyZW50IG9uZS4gVGhpcyBpcyBnb2luZyB0
byBiZSBoZWxwZnVsIHdoZW4KdXNlcnNwYWNlIGNoYW5nZXMgcHJpb3JpdHkgb2YgYSBjdHgvZW50
aXR5IHRoZW4gdGhlIGRyaXZlciBjYW4gc3dpdGNoCnRvIHRoZSBjb3JyZXNwb25kaW5nIEhXIHNj
aGVkdWxlciBsaXN0IGZvciB0aGF0IHByaW9yaXR5LgoKU2lnbmVkLW9mZi1ieTogTmlybW95IERh
cyA8bmlybW95LmRhc0BhbWQuY29tPgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2No
ZWRfZW50aXR5LmMgfCAxOCArKysrKysrKysrKysrKysrKysKIGluY2x1ZGUvZHJtL2dwdV9zY2hl
ZHVsZXIuaCAgICAgICAgICAgICAgfCAgNCArKysrCiAyIGZpbGVzIGNoYW5nZWQsIDIyIGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2Vu
dGl0eS5jIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwppbmRleCA2
M2JjY2QyMDFiOTcuLjY5ODRjZDRmMThkOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3Nj
aGVkdWxlci9zY2hlZF9lbnRpdHkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3Nj
aGVkX2VudGl0eS5jCkBAIC04Myw2ICs4MywyNCBAQCBpbnQgZHJtX3NjaGVkX2VudGl0eV9pbml0
KHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5ICplbnRpdHksCiB9CiBFWFBPUlRfU1lNQk9MKGRybV9z
Y2hlZF9lbnRpdHlfaW5pdCk7CgorLyoqCisgKiBkcm1fc2NoZWRfZW50aXR5X21vZGlmeV9zY2hl
ZCAtIE1vZGlmeSBzY2hlZCBvZiBhbiBlbnRpdHkKKyAqIEBlbnRpdHk6IHNjaGVkdWxlciBlbnRp
dHkgdG8gaW5pdAorICogQHNjaGVkX2xpc3Q6IHRoZSBsaXN0IG9mIG5ldyBkcm0gc2NoZWRzIHdo
aWNoIHdpbGwgcmVwbGFjZQorICoJCSBleGlzdGluZyBlbnRpdHktPnNjaGVkX2xpc3QKKyAqIEBu
dW1fc2NoZWRfbGlzdDogbnVtYmVyIG9mIGRybSBzY2hlZCBpbiBzY2hlZF9saXN0CisgKi8KK3Zv
aWQgZHJtX3NjaGVkX2VudGl0eV9tb2RpZnlfc2NoZWQoc3RydWN0IGRybV9zY2hlZF9lbnRpdHkg
KmVudGl0eSwKKwkJCQkgICAgc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICoqc2NoZWRfbGlzdCwK
KwkJCQkgICAgdW5zaWduZWQgaW50IG51bV9zY2hlZF9saXN0KQoreworCVdBUk5fT04oIW51bV9z
Y2hlZF9saXN0IHx8ICFzY2hlZF9saXN0KTsKKworCWVudGl0eS0+c2NoZWRfbGlzdCA9IHNjaGVk
X2xpc3Q7CisJZW50aXR5LT5udW1fc2NoZWRfbGlzdCA9IG51bV9zY2hlZF9saXN0OworfQorRVhQ
T1JUX1NZTUJPTChkcm1fc2NoZWRfZW50aXR5X21vZGlmeV9zY2hlZCk7CisKIC8qKgogICogZHJt
X3NjaGVkX2VudGl0eV9pc19pZGxlIC0gQ2hlY2sgaWYgZW50aXR5IGlzIGlkbGUKICAqCmRpZmYg
LS1naXQgYS9pbmNsdWRlL2RybS9ncHVfc2NoZWR1bGVyLmggYi9pbmNsdWRlL2RybS9ncHVfc2No
ZWR1bGVyLmgKaW5kZXggNTg5YmU4NTFmOGExLi5kODk3MjgzNmQyNDggMTAwNjQ0Ci0tLSBhL2lu
Y2x1ZGUvZHJtL2dwdV9zY2hlZHVsZXIuaAorKysgYi9pbmNsdWRlL2RybS9ncHVfc2NoZWR1bGVy
LmgKQEAgLTI5Nyw2ICsyOTcsMTAgQEAgdm9pZCBkcm1fc2NoZWRfZmluaShzdHJ1Y3QgZHJtX2dw
dV9zY2hlZHVsZXIgKnNjaGVkKTsKIGludCBkcm1fc2NoZWRfam9iX2luaXQoc3RydWN0IGRybV9z
Y2hlZF9qb2IgKmpvYiwKIAkJICAgICAgIHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5ICplbnRpdHks
CiAJCSAgICAgICB2b2lkICpvd25lcik7Cit2b2lkIGRybV9zY2hlZF9lbnRpdHlfbW9kaWZ5X3Nj
aGVkKHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5ICplbnRpdHksCisJCQkJICAgIHN0cnVjdCBkcm1f
Z3B1X3NjaGVkdWxlciAqKnNjaGVkX2xpc3QsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVuc2lnbmVkIGludCBudW1fc2NoZWRfbGlzdCk7CisKIHZvaWQgZHJtX3NjaGVkX2pv
Yl9jbGVhbnVwKHN0cnVjdCBkcm1fc2NoZWRfam9iICpqb2IpOwogdm9pZCBkcm1fc2NoZWRfd2Fr
ZXVwKHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqc2NoZWQpOwogdm9pZCBkcm1fc2NoZWRfc3Rv
cChzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkLCBzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAq
YmFkKTsKLS0KMi4yNS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
