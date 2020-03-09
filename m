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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F029C10F27
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 13:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D612020727
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 13:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9LW4BBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D612020727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9028D6E462;
	Mon,  9 Mar 2020 13:30:06 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 792416E486
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2020 13:30:05 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id 6so11143084wre.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Mar 2020 06:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tZypYcZ111UJR55iIswDQRCu8CYExkt+/UK9HxWzq7Q=;
 b=g9LW4BBLrKILg0+qMVmlrelm9pQsawDzFQMZF2mDMLz6s8NuyqVEO2p34g8LawSYoS
 4z3pnOymttXBybIibbqTNSsD8ayBTHsvHDHuFdXQ6KBN0Un74y/c+ZLyp0gAWYe4/AON
 H5m1b0F1MjGHcF8qw+TC1pG5KGiLaRC5G0oCbXmi2UQZrs+DITyBSGY44G3q5GZgxTis
 6xcPLlsiVaMxDu4h+KJ7a0h22G5kG4wpCMfDBTGR2RS8R/nuxHCCXFuwSlON0qiy5iuE
 WkgKCtSDCBpf/iAXTRam1FpNmj10KUVYX1jUkVbjS7h8hnrtAqn/uKIhGyCGpuVVpSHd
 arqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tZypYcZ111UJR55iIswDQRCu8CYExkt+/UK9HxWzq7Q=;
 b=IokDyC/aOFsVqLgcf/5tQBwDzq3mLaNT82LcfjMDnXmK3Hv0PKKsZoubHP6nWKae47
 blD+vfR9sj9ynt9lemlHLv0J8/BZT/L4RHvVZWTaDJVYKA228IXJG4FoHOTzlJac7YgN
 XCWZ3MISfpPef2sA0Q7GmbXEvgYYljhzCgv/1IR/rj0vz6fQEpWCUTGCfv6J32DUBOiX
 XlkHTX3NRH8ZoKgOCDX8vFQsftxxX/KK4ASqbPrHfqCGo8alKr8S6nLHX5CfHNzyuwj+
 ClWY7lJz6oxl8I/sLPbIZlJvAWoP5ol8hj+D+oSi0GdjjekwyBpMxMwlxV/Cfh/fhenw
 P4FQ==
X-Gm-Message-State: ANhLgQ0+r+MjlHE34NiLbyQtLe4EaFXWQFyvxZ90tZgndQoZqa/okG0f
 z0IQBPT9iMzoKRDVGviMLsWAd6Wp/x8=
X-Google-Smtp-Source: ADFU+vtyJUcX7XvoyiYqIYBxlEDh5jXsOcq9m8uWnvRClt+/VgBT1Uo9zYq/9j07fdpivputlrRGxg==
X-Received: by 2002:a05:6000:108:: with SMTP id
 o8mr20874629wrx.312.1583760603746; 
 Mon, 09 Mar 2020 06:30:03 -0700 (PDT)
Received: from brihaspati.fritz.box
 (p200300C58F2ACB00753B9E7FA9FFF13D.dip0.t-ipconnect.de.
 [2003:c5:8f2a:cb00:753b:9e7f:a9ff:f13d])
 by smtp.gmail.com with ESMTPSA id i12sm47009640wrw.64.2020.03.09.06.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 06:30:03 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/scheduler: implement a function to modify sched list
Date: Mon,  9 Mar 2020 14:33:23 +0100
Message-Id: <20200309133325.66024-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200309133325.66024-1-nirmoy.das@amd.com>
References: <20200309133325.66024-1-nirmoy.das@amd.com>
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
M2JjY2QyMDFiOTcuLjkwZmQ5YzMwYWU1YSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3Nj
aGVkdWxlci9zY2hlZF9lbnRpdHkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3Nj
aGVkX2VudGl0eS5jCkBAIC04Myw2ICs4MywyNCBAQCBpbnQgZHJtX3NjaGVkX2VudGl0eV9pbml0
KHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5ICplbnRpdHksCiB9CiBFWFBPUlRfU1lNQk9MKGRybV9z
Y2hlZF9lbnRpdHlfaW5pdCk7CiAKKy8qKgorICogZHJtX3NjaGVkX2VudGl0eV9tb2RpZnlfc2No
ZWQgLSBNb2RpZnkgc2NoZWQgb2YgYW4gZW50aXR5CisgKiBAZW50aXR5OiBzY2hlZHVsZXIgZW50
aXR5IHRvIGluaXQKKyAqIEBzY2hlZF9saXN0OiB0aGUgbGlzdCBvZiBuZXcgZHJtIHNjaGVkcyB3
aGljaCB3aWxsIHJlcGxhY2UKKyAqCQkgZXhpc3RpbmcgZW50aXR5LT5zY2hlZF9saXN0CisgKiBA
bnVtX3NjaGVkX2xpc3Q6IG51bWJlciBvZiBkcm0gc2NoZWQgaW4gc2NoZWRfbGlzdAorICovCit2
b2lkIGRybV9zY2hlZF9lbnRpdHlfbW9kaWZ5X3NjaGVkKHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5
ICplbnRpdHksCisJCQkJICAgIHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqKnNjaGVkX2xpc3Qs
CisJCQkJICAgIHVuc2lnbmVkIGludCBudW1fc2NoZWRfbGlzdCkKK3sKKwlXQVJOX09OKCFudW1f
c2NoZWRfbGlzdCB8fCAhc2NoZWRfbGlzdCk7CisKKwllbnRpdHktPnNjaGVkX2xpc3QgPSBzY2hl
ZF9saXN0OworCWVudGl0eS0+bnVtX3NjaGVkX2xpc3QgPSBudW1fc2NoZWRfbGlzdDsKK30KK0VY
UE9SVF9TWU1CT0woZHJtX3NjaGVkX2VudGl0eV9tb2RpZnlfc2NoZWQpOworCiAvKioKICAqIGRy
bV9zY2hlZF9lbnRpdHlfaXNfaWRsZSAtIENoZWNrIGlmIGVudGl0eSBpcyBpZGxlCiAgKgpkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9kcm0vZ3B1X3NjaGVkdWxlci5oIGIvaW5jbHVkZS9kcm0vZ3B1X3Nj
aGVkdWxlci5oCmluZGV4IDU4OWJlODUxZjhhMS4uZDg5NzI4MzZkMjQ4IDEwMDY0NAotLS0gYS9p
bmNsdWRlL2RybS9ncHVfc2NoZWR1bGVyLmgKKysrIGIvaW5jbHVkZS9kcm0vZ3B1X3NjaGVkdWxl
ci5oCkBAIC0yOTcsNiArMjk3LDEwIEBAIHZvaWQgZHJtX3NjaGVkX2Zpbmkoc3RydWN0IGRybV9n
cHVfc2NoZWR1bGVyICpzY2hlZCk7CiBpbnQgZHJtX3NjaGVkX2pvYl9pbml0KHN0cnVjdCBkcm1f
c2NoZWRfam9iICpqb2IsCiAJCSAgICAgICBzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSAqZW50aXR5
LAogCQkgICAgICAgdm9pZCAqb3duZXIpOwordm9pZCBkcm1fc2NoZWRfZW50aXR5X21vZGlmeV9z
Y2hlZChzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSAqZW50aXR5LAorCQkJCSAgICBzdHJ1Y3QgZHJt
X2dwdV9zY2hlZHVsZXIgKipzY2hlZF9saXN0LAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1bnNpZ25lZCBpbnQgbnVtX3NjaGVkX2xpc3QpOworCiB2b2lkIGRybV9zY2hlZF9q
b2JfY2xlYW51cChzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAqam9iKTsKIHZvaWQgZHJtX3NjaGVkX3dh
a2V1cChzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkKTsKIHZvaWQgZHJtX3NjaGVkX3N0
b3Aoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCwgc3RydWN0IGRybV9zY2hlZF9qb2Ig
KmJhZCk7Ci0tIAoyLjI1LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
