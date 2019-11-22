Return-Path: <SRS0=j4R+=ZO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23692C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 21:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFDB32071B
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 21:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDB32071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 996666E152;
	Fri, 22 Nov 2019 21:44:10 +0000 (UTC)
Received: from mail-yw1-xc41.google.com (mail-yw1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F43D6E129
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2019 21:44:05 +0000 (UTC)
Received: by mail-yw1-xc41.google.com with SMTP id 4so2539469ywx.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2019 13:44:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tLz/VLKnB1IPKE8d1KUr8XukeZ9FBVXcYJIk8ITPAWE=;
 b=JpWeLot/dGqOuXMv0PGJ5kv24r/iMZDA8kPc4i/n/OBo11gf4Ysa6FsorACsVpG12a
 7Zd+Mdxo56F0BGknyp7e+1u9eAtdxitLt+/tcGCZitw8dz/bdNUpoYRu/+Kgt+mVtRNN
 T3rn4JyTKjC2BOFmFo5g+1+Rfv2oIs0rIxHHA5BrpOpVuDW7VKi/Ohrqr6D4/V5eJQW6
 RMfKr8A3MTkBXM/Uw5mjH8ErtDJERtTvAw8EW15522MuyXkWkujamxsVByc4uhMAYrea
 ZzOctKkSstwUV1EzzooJRYKtUZHAgkEuiUYUAH6oxqS8HoTylaG1mS6h+mWxwpz4epPC
 VrBg==
X-Gm-Message-State: APjAAAUnh47AJPyipBjMyGWB0jtSopKKhPnEuHPaUel7wNW1BT5IOt0d
 DCmOS8C7kj6KpibCsBJ2/QRzJ6P2
X-Google-Smtp-Source: APXvYqyatKNHh/9+R3obw+MqEsRSJJgO8YWqCuf9fc+9XCQTIbCvwPw4FtbEG/nqVLSLi27hUGk2mw==
X-Received: by 2002:a0d:cc47:: with SMTP id o68mr10984795ywd.50.1574459044454; 
 Fri, 22 Nov 2019 13:44:04 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id t15sm2111522ywh.70.2019.11.22.13.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 13:44:04 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de
Subject: [PATCH 3/4] ALSA: hda/hdmi - enable runtime pm for newer AMD display
 audio
Date: Fri, 22 Nov 2019 16:43:52 -0500
Message-Id: <20191122214353.582899-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191122214353.582899-1-alexander.deucher@amd.com>
References: <20191122214353.582899-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tLz/VLKnB1IPKE8d1KUr8XukeZ9FBVXcYJIk8ITPAWE=;
 b=KIYg3/6XBSZO6t0fUpCrLv+5G5KYy6rBZRfkrr1JSxhQ6Q77nqrjTVNeE0w7F5e7in
 0asTE5h+w9Gh7tT70onmdLImPap5p4ZyRnQBlw+AdpEhKz3qMtqYUHNm+6KgRnoCU+L0
 ndJKykhlrmntmzeuTyZKmvt9D3RaFHu3s7HtgE8zYHa4YR/Ih9ZVGniUGvhJ7oEruanW
 Akr5SUolImHipw72p0tbhUMbuC3thbvOJWe71/lxYllvoYpJZBzGtefJSiVMeSp3xR+Y
 TBMA3lAcmAn3kcWO2oX2A9vKgh2BEChFarZB5g4XTvf/O/LWrMvhkf994Npo/2vMRC0N
 tgYA==
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191122214352.FygLyVR4bkeNX1Snz-etjddx2sFb3KlEh6TgLH3bQPY@z>

V2UgYXJlIGFibGUgdG8gcG93ZXIgZG93biB0aGUgR1BVIGFuZCBhdWRpbyB2aWEgdGhlIEdQVSBk
cml2ZXIKc28gZmxhZyB0aGVzZSBhc2ljcyBhcyBzdXBwb3J0aW5nIHJ1bnRpbWUgcG0uCgpSZXZp
ZXdlZC1ieTogVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPgpBY2tlZC1ieTogRXZhbiBRdWFu
IDxldmFuLnF1YW5AYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIHNvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMgfCAzNSAr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDIzIGlu
c2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEv
aGRhX2ludGVsLmMgYi9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jCmluZGV4IDc5Y2E5N2Q2Yzgx
MS4uMTExYjlhODY5MTYyIDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jCisr
KyBiL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMKQEAgLTI1OTksMjcgKzI1OTksMzggQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkIGF6eF9pZHNbXSA9IHsKIAl7IFBDSV9ERVZJ
Q0UoMHgxMDAyLCAweGFhYzgpLAogCSAgLmRyaXZlcl9kYXRhID0gQVpYX0RSSVZFUl9BVElIRE1J
X05TIHwgQVpYX0RDQVBTX1BSRVNFVF9BVElfSERNSV9OUyB9LAogCXsgUENJX0RFVklDRSgweDEw
MDIsIDB4YWFkOCksCi0JICAuZHJpdmVyX2RhdGEgPSBBWlhfRFJJVkVSX0FUSUhETUlfTlMgfCBB
WlhfRENBUFNfUFJFU0VUX0FUSV9IRE1JX05TIH0sCi0JeyBQQ0lfREVWSUNFKDB4MTAwMiwgMHhh
YWU4KSwKLQkgIC5kcml2ZXJfZGF0YSA9IEFaWF9EUklWRVJfQVRJSERNSV9OUyB8IEFaWF9EQ0FQ
U19QUkVTRVRfQVRJX0hETUlfTlMgfSwKKwkgIC5kcml2ZXJfZGF0YSA9IEFaWF9EUklWRVJfQVRJ
SERNSV9OUyB8IEFaWF9EQ0FQU19QUkVTRVRfQVRJX0hETUlfTlMgfAorCSAgQVpYX0RDQVBTX1BN
X1JVTlRJTUUgfSwKIAl7IFBDSV9ERVZJQ0UoMHgxMDAyLCAweGFhZTApLAotCSAgLmRyaXZlcl9k
YXRhID0gQVpYX0RSSVZFUl9BVElIRE1JX05TIHwgQVpYX0RDQVBTX1BSRVNFVF9BVElfSERNSV9O
UyB9LAorCSAgLmRyaXZlcl9kYXRhID0gQVpYX0RSSVZFUl9BVElIRE1JX05TIHwgQVpYX0RDQVBT
X1BSRVNFVF9BVElfSERNSV9OUyB8CisJICBBWlhfRENBUFNfUE1fUlVOVElNRSB9LAorCXsgUENJ
X0RFVklDRSgweDEwMDIsIDB4YWFlOCksCisJICAuZHJpdmVyX2RhdGEgPSBBWlhfRFJJVkVSX0FU
SUhETUlfTlMgfCBBWlhfRENBUFNfUFJFU0VUX0FUSV9IRE1JX05TIHwKKwkgIEFaWF9EQ0FQU19Q
TV9SVU5USU1FIH0sCiAJeyBQQ0lfREVWSUNFKDB4MTAwMiwgMHhhYWYwKSwKLQkgIC5kcml2ZXJf
ZGF0YSA9IEFaWF9EUklWRVJfQVRJSERNSV9OUyB8IEFaWF9EQ0FQU19QUkVTRVRfQVRJX0hETUlf
TlMgfSwKKwkgIC5kcml2ZXJfZGF0YSA9IEFaWF9EUklWRVJfQVRJSERNSV9OUyB8IEFaWF9EQ0FQ
U19QUkVTRVRfQVRJX0hETUlfTlMgfAorCSAgQVpYX0RDQVBTX1BNX1JVTlRJTUUgfSwKIAl7IFBD
SV9ERVZJQ0UoMHgxMDAyLCAweGFhZjgpLAotCSAgLmRyaXZlcl9kYXRhID0gQVpYX0RSSVZFUl9B
VElIRE1JX05TIHwgQVpYX0RDQVBTX1BSRVNFVF9BVElfSERNSV9OUyB9LAorCSAgLmRyaXZlcl9k
YXRhID0gQVpYX0RSSVZFUl9BVElIRE1JX05TIHwgQVpYX0RDQVBTX1BSRVNFVF9BVElfSERNSV9O
UyB8CisJICBBWlhfRENBUFNfUE1fUlVOVElNRSB9LAogCXsgUENJX0RFVklDRSgweDEwMDIsIDB4
YWIwMCksCi0JICAuZHJpdmVyX2RhdGEgPSBBWlhfRFJJVkVSX0FUSUhETUlfTlMgfCBBWlhfRENB
UFNfUFJFU0VUX0FUSV9IRE1JX05TIH0sCisJICAuZHJpdmVyX2RhdGEgPSBBWlhfRFJJVkVSX0FU
SUhETUlfTlMgfCBBWlhfRENBUFNfUFJFU0VUX0FUSV9IRE1JX05TIHwKKwkgIEFaWF9EQ0FQU19Q
TV9SVU5USU1FIH0sCiAJeyBQQ0lfREVWSUNFKDB4MTAwMiwgMHhhYjA4KSwKLQkgIC5kcml2ZXJf
ZGF0YSA9IEFaWF9EUklWRVJfQVRJSERNSV9OUyB8IEFaWF9EQ0FQU19QUkVTRVRfQVRJX0hETUlf
TlMgfSwKKwkgIC5kcml2ZXJfZGF0YSA9IEFaWF9EUklWRVJfQVRJSERNSV9OUyB8IEFaWF9EQ0FQ
U19QUkVTRVRfQVRJX0hETUlfTlMgfAorCSAgQVpYX0RDQVBTX1BNX1JVTlRJTUUgfSwKIAl7IFBD
SV9ERVZJQ0UoMHgxMDAyLCAweGFiMTApLAotCSAgLmRyaXZlcl9kYXRhID0gQVpYX0RSSVZFUl9B
VElIRE1JX05TIHwgQVpYX0RDQVBTX1BSRVNFVF9BVElfSERNSV9OUyB9LAorCSAgLmRyaXZlcl9k
YXRhID0gQVpYX0RSSVZFUl9BVElIRE1JX05TIHwgQVpYX0RDQVBTX1BSRVNFVF9BVElfSERNSV9O
UyB8CisJICBBWlhfRENBUFNfUE1fUlVOVElNRSB9LAogCXsgUENJX0RFVklDRSgweDEwMDIsIDB4
YWIxOCksCi0JICAuZHJpdmVyX2RhdGEgPSBBWlhfRFJJVkVSX0FUSUhETUlfTlMgfCBBWlhfRENB
UFNfUFJFU0VUX0FUSV9IRE1JX05TIH0sCisJICAuZHJpdmVyX2RhdGEgPSBBWlhfRFJJVkVSX0FU
SUhETUlfTlMgfCBBWlhfRENBUFNfUFJFU0VUX0FUSV9IRE1JX05TIHwKKwkgIEFaWF9EQ0FQU19Q
TV9SVU5USU1FIH0sCiAJeyBQQ0lfREVWSUNFKDB4MTAwMiwgMHhhYjIwKSwKLQkgIC5kcml2ZXJf
ZGF0YSA9IEFaWF9EUklWRVJfQVRJSERNSV9OUyB8IEFaWF9EQ0FQU19QUkVTRVRfQVRJX0hETUlf
TlMgfSwKKwkgIC5kcml2ZXJfZGF0YSA9IEFaWF9EUklWRVJfQVRJSERNSV9OUyB8IEFaWF9EQ0FQ
U19QUkVTRVRfQVRJX0hETUlfTlMgfAorCSAgQVpYX0RDQVBTX1BNX1JVTlRJTUUgfSwKIAl7IFBD
SV9ERVZJQ0UoMHgxMDAyLCAweGFiMzgpLAotCSAgLmRyaXZlcl9kYXRhID0gQVpYX0RSSVZFUl9B
VElIRE1JX05TIHwgQVpYX0RDQVBTX1BSRVNFVF9BVElfSERNSV9OUyB9LAorCSAgLmRyaXZlcl9k
YXRhID0gQVpYX0RSSVZFUl9BVElIRE1JX05TIHwgQVpYX0RDQVBTX1BSRVNFVF9BVElfSERNSV9O
UyB8CisJICBBWlhfRENBUFNfUE1fUlVOVElNRSB9LAogCS8qIFZJQSBWVDgyNTEvVlQ4MjM3QSAq
LwogCXsgUENJX0RFVklDRSgweDExMDYsIDB4MzI4OCksIC5kcml2ZXJfZGF0YSA9IEFaWF9EUklW
RVJfVklBIH0sCiAJLyogVklBIEdGWCBWVDcxMjIvVlg5MDAgKi8KLS0gCjIuMjMuMAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
