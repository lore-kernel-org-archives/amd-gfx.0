Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9BFC2BD09
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 18:00:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 218DE24670
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 18:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218DE24670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91C1C6FA77;
	Fri,  6 Dec 2019 18:00:40 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEABF6FA6F
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 17:33:18 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id g17so8693097wro.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Dec 2019 09:33:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=06OgLsnKkoDHAAuvpeUAYc13dkfxsG2vcAcYkjwJ47M=;
 b=SHlvB61BfQ/qbtSPIeh4y/LKHwnyDfQhCIyfZoYcbom+h9GPlgX2FAB6AXWx87XRN/
 DZvqgoLs8zBkEDEZMP8lZbI3lBGP9ycEPSW6nONaqQ7R3V9EhIORnuKrEGci7zGWhDEt
 nA61M8p/KLOIQuVoXY3BOcRpq2OfywGupYTuuXBK53L24eL1JjHFxHfSJJknY4d/FTG1
 1OcusLGHYhyQjwMwPwQIWbeffONnjNsCjBV+t9VA7USre2O+pvzZufr2FThS76cnYSr6
 +5sddzxPa3dx+ONmQ+3+nmyTbLJrHqd4+L1UDdjtiOKdnpF4ILAhLaMNcR4UeYkfA+gn
 evbg==
X-Gm-Message-State: APjAAAWa+IDmeagGcHaZLFvI1rq3dk3E0FYtcpE4XLnNExyyVsn+MZFj
 Xf0Fd3/e3NIxLy7DiJRy4B0=
X-Google-Smtp-Source: APXvYqztX1tNJ4fI/ijQs7jJDoumeWpHntHie6ty23zOgXOAJlPNJT8zgcCkmRuCAGHsCrY0AeSdFg==
X-Received: by 2002:a5d:6408:: with SMTP id z8mr17100089wru.122.1575653597499; 
 Fri, 06 Dec 2019 09:33:17 -0800 (PST)
Received: from linux-f4ir.fritz.box
 (p200300C58F4B11009E92A83957331E39.dip0.t-ipconnect.de.
 [2003:c5:8f4b:1100:9e92:a839:5733:1e39])
 by smtp.gmail.com with ESMTPSA id v14sm16906912wrm.28.2019.12.06.09.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2019 09:33:16 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: alexander.deucher@amd.com,
	kenny.ho@amd.com,
	christian.koenig@amd.com
Subject: [PATCH 4/4] drm/scheduler: do not keep a copy of sched list
Date: Fri,  6 Dec 2019 18:33:04 +0100
Message-Id: <20191206173304.3025-4-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191206173304.3025-1-nirmoy.das@amd.com>
References: <20191206173304.3025-1-nirmoy.das@amd.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 06 Dec 2019 18:00:39 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=06OgLsnKkoDHAAuvpeUAYc13dkfxsG2vcAcYkjwJ47M=;
 b=chW/4VexZML6nmg9yDpdd4qgSwrdROgDKO+tm50z19I95CBqHKCM9v0s2Efw3tO0Fg
 LT5IJIRaZrur5fGNAkfL+2MDkPXXDebM6owcvpBQU2W9ETMN7AjuwT/Q8AsdmrSPRndj
 7HNigryCh47h98lUoIqFoZlsGnkrgqw8Gad5uhgkUvSnEwpAW8fK9kMpJeijlB/WEY9+
 qCHXcUq2syNspPbvPO8I+Ewu5wfzALqqrGsPEBw7+5etKO/DFp05tQaewOzJcuM2lUVP
 OyIlGiRUdg+lqoeER+dpwW1CUvdw8gF8/4slz1zsLDIR33Tcm0+dK88lmmG5jLNCVtCH
 zWUQ==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ZW50aXR5IHNob3VsZCBub3Qga2VlcCBjb3B5IGFuZCBtYWludGFpbiBzY2hlZCBsaXN0IGZvcgpp
dHNlbGYuCgpTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jICB8IDExICsrKysrKysr
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmggIHwgIDEgKwogZHJp
dmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYyB8IDEyICstLS0tLS0tLS0tLQog
MyBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMKaW5kZXggYzc2NDNhZjg4MjdmLi4xOTM5
YjQxNGQyM2IgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9j
dHguYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMKQEAgLTcx
LDcgKzcxLDYgQEAgc3RhdGljIGludCBhbWRncHVfY3R4X3ByaW9yaXR5X3Blcm1pdChzdHJ1Y3Qg
ZHJtX2ZpbGUgKmZpbHAsCiBzdGF0aWMgaW50IGFtZGdwdV9jdHhfaW5pdF9lbnRpdHkoc3RydWN0
IGFtZGdwdV9jdHggKmN0eCwgdTMyIGh3X2lwKQogewogCXN0cnVjdCBhbWRncHVfcmluZyAqcmlu
Z3NbQU1ER1BVX01BWF9SSU5HU107Ci0Jc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZF9s
aXN0W0FNREdQVV9NQVhfUklOR1NdOwogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gY3R4
LT5hZGV2OwogCXVuc2lnbmVkIG51bV9yaW5ncyA9IDA7CiAJdW5zaWduZWQgbnVtX3NjaGVkcyA9
IDA7CkBAIC0xMjksMTYgKzEyOCwyMSBAQCBzdGF0aWMgaW50IGFtZGdwdV9jdHhfaW5pdF9lbnRp
dHkoc3RydWN0IGFtZGdwdV9jdHggKmN0eCwgdTMyIGh3X2lwKQogCQkJYnJlYWs7CiAJfQogCisJ
Y3R4LT5zY2hlZF9saXN0ID0ga2NhbGxvYyhudW1fcmluZ3MsCisJCQkJICBzaXplb2Yoc3RydWN0
IGRybV9ncHVfc2NoZWR1bGVyICopLCBHRlBfS0VSTkVMKTsKKwlpZiAoY3R4LT5zY2hlZF9saXN0
ID09IE5VTEwgKQorCQlyZXR1cm4gLUVOT01FTTsKKwogCWZvciAoaSA9IDA7IGkgPCBudW1fcmlu
Z3M7ICsraSkgewogCQlpZiAoIXJpbmdzW2ldLT5hZGV2KQogCQkJY29udGludWU7CiAKLQkJc2No
ZWRfbGlzdFtudW1fc2NoZWRzKytdID0gJnJpbmdzW2ldLT5zY2hlZDsKKwkJY3R4LT5zY2hlZF9s
aXN0W251bV9zY2hlZHMrK10gPSAmcmluZ3NbaV0tPnNjaGVkOwogCX0KIAogCWZvciAoaSA9IDA7
IGkgPCBhbWRncHVfY3R4X251bV9lbnRpdGllc1tod19pcF07ICsraSkKIAkJciA9IGRybV9zY2hl
ZF9lbnRpdHlfaW5pdCgmY3R4LT5lbnRpdGllc1tod19pcF1baV0uZW50aXR5LAotCQkJCWN0eC0+
aW5pdF9wcmlvcml0eSwgc2NoZWRfbGlzdCwgbnVtX3NjaGVkcywgJmN0eC0+Z3VpbHR5KTsKKwkJ
CQljdHgtPmluaXRfcHJpb3JpdHksIGN0eC0+c2NoZWRfbGlzdCwgbnVtX3NjaGVkcywgJmN0eC0+
Z3VpbHR5KTsKIAlpZiAocikKIAkJZ290byBlcnJvcl9jbGVhbnVwX2VudGl0aWVzOwogCkBAIC0y
MjgsNiArMjMyLDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2N0eF9maW5pKHN0cnVjdCBrcmVmICpy
ZWYpCiAJCWZvciAoaiA9IDA7IGogPCBhbWRncHVfc2NoZWRfam9iczsgKytqKQogCQkJZG1hX2Zl
bmNlX3B1dChjdHgtPmVudGl0aWVzWzBdW2ldLmZlbmNlc1tqXSk7CiAJa2ZyZWUoY3R4LT5mZW5j
ZXMpOworCWtmcmVlKGN0eC0+c2NoZWRfbGlzdCk7CiAJa2ZyZWUoY3R4LT5lbnRpdGllc1swXSk7
CiAKIAltdXRleF9kZXN0cm95KCZjdHgtPmxvY2spOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2N0eC5oCmluZGV4IGRhODA4NjMzNzMyYi4uOWZkMDJjYzQ3MzUyIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmgKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5oCkBAIC00NCw2ICs0NCw3IEBAIHN0cnVjdCBh
bWRncHVfY3R4IHsKIAlzcGlubG9ja190CQkJcmluZ19sb2NrOwogCXN0cnVjdCBkbWFfZmVuY2UJ
CSoqZmVuY2VzOwogCXN0cnVjdCBhbWRncHVfY3R4X2VudGl0eQkqZW50aXRpZXNbQU1ER1BVX0hX
X0lQX05VTV07CisJc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyCSoqc2NoZWRfbGlzdDsKIAlib29s
CQkJCXByZWFtYmxlX3ByZXNlbnRlZDsKIAllbnVtIGRybV9zY2hlZF9wcmlvcml0eQkJaW5pdF9w
cmlvcml0eTsKIAllbnVtIGRybV9zY2hlZF9wcmlvcml0eQkJb3ZlcnJpZGVfcHJpb3JpdHk7CmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jIGIvZHJp
dmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwppbmRleCBmOWI2Y2UyOWM1OGYu
LmM4NGE5YTY2ZjdmMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hl
ZF9lbnRpdHkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5j
CkBAIC01Niw4ICs1Niw2IEBAIGludCBkcm1fc2NoZWRfZW50aXR5X2luaXQoc3RydWN0IGRybV9z
Y2hlZF9lbnRpdHkgKmVudGl0eSwKIAkJCSAgdW5zaWduZWQgaW50IG51bV9zY2hlZF9saXN0LAog
CQkJICBhdG9taWNfdCAqZ3VpbHR5KQogewotCWludCBpOwotCiAJaWYgKCEoZW50aXR5ICYmIHNj
aGVkX2xpc3QgJiYgKG51bV9zY2hlZF9saXN0ID09IDAgfHwgc2NoZWRfbGlzdFswXSkpKQogCQly
ZXR1cm4gLUVJTlZBTDsKIApAQCAtNjcsMTcgKzY1LDEwIEBAIGludCBkcm1fc2NoZWRfZW50aXR5
X2luaXQoc3RydWN0IGRybV9zY2hlZF9lbnRpdHkgKmVudGl0eSwKIAllbnRpdHktPmd1aWx0eSA9
IGd1aWx0eTsKIAllbnRpdHktPm51bV9zY2hlZF9saXN0ID0gbnVtX3NjaGVkX2xpc3Q7CiAJZW50
aXR5LT5wcmlvcml0eSA9IHByaW9yaXR5OwotCWVudGl0eS0+c2NoZWRfbGlzdCA9ICBrY2FsbG9j
KG51bV9zY2hlZF9saXN0LAotCQkJCSAgICAgIHNpemVvZihzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVs
ZXIgKiksIEdGUF9LRVJORUwpOwotCi0JaWYoIWVudGl0eS0+c2NoZWRfbGlzdCkKLQkJcmV0dXJu
IC1FTk9NRU07CisJZW50aXR5LT5zY2hlZF9saXN0ID0gIHNjaGVkX2xpc3Q7CiAKIAlpbml0X2Nv
bXBsZXRpb24oJmVudGl0eS0+ZW50aXR5X2lkbGUpOwogCi0JZm9yIChpID0gMDsgaSA8IG51bV9z
Y2hlZF9saXN0OyBpKyspCi0JCWVudGl0eS0+c2NoZWRfbGlzdFtpXSA9IHNjaGVkX2xpc3RbaV07
Ci0KIAlpZiAobnVtX3NjaGVkX2xpc3QpCiAJCWVudGl0eS0+cnEgPSAmZW50aXR5LT5zY2hlZF9s
aXN0WzBdLT5zY2hlZF9ycVtlbnRpdHktPnByaW9yaXR5XTsKIApAQCAtMzEyLDcgKzMwMyw2IEBA
IHZvaWQgZHJtX3NjaGVkX2VudGl0eV9maW5pKHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5ICplbnRp
dHkpCiAKIAlkbWFfZmVuY2VfcHV0KGVudGl0eS0+bGFzdF9zY2hlZHVsZWQpOwogCWVudGl0eS0+
bGFzdF9zY2hlZHVsZWQgPSBOVUxMOwotCWtmcmVlKGVudGl0eS0+c2NoZWRfbGlzdCk7CiB9CiBF
WFBPUlRfU1lNQk9MKGRybV9zY2hlZF9lbnRpdHlfZmluaSk7CiAKLS0gCjIuMjQuMAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
