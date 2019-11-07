Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8602C5DF60
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 18:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89850214D8
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 18:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89850214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51FFF6F789;
	Thu,  7 Nov 2019 18:35:46 +0000 (UTC)
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D82A6F789
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 18:35:45 +0000 (UTC)
Received: by mail-io1-xd41.google.com with SMTP id r144so3400302iod.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Nov 2019 10:35:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p365fKq/ue8k/gZIYfTV9otkqQ7yUDhWCSHtl7V5W2M=;
 b=Jbj03n4e3UKdJqK4lWX4WPOzy4PEAZnwN2tsUdGjvvEjRkqc+a0vxrBxrYt3m4qwts
 0ZsqV1BlhB97WKrfD9+txiIC7n3ST97QDZxUQeBGlDWOGuYAuUeJqoIAtl7Hlb7kLrE0
 j2jGBlG683mibpdpvvc6mbPhlhNtuZQhftacDndA8ssLCUFhZ1spybqJxQaUwo4EtbFA
 3PD1lu7icwfjA7t9WMQLoKt7/pDkXueazKxa8U+0w+nRAyXiP6rJf58FuY+2V0IRBm3N
 HHB3pqSmsU3Gg7ECwvI36A3LGgObVfqh99cMK/nBlUE4Pb+rLMwbRjaBDF4Bx/J6aQ3z
 pYmQ==
X-Gm-Message-State: APjAAAWd1tBpW+GAXI90ACQdsCfJdv1XtrjeqBDIOT2Q+jB++wSFtuHA
 zgXt1k8pahRTAjmjFZ8U6L1mxeKbcWI=
X-Google-Smtp-Source: APXvYqz4nbAMyIiKExdYMhxuAeAYmrX2Niem9lG/1ERfjefrb4DlH9gZxWPxBp/e4SNEl4NE+LT1Sg==
X-Received: by 2002:a6b:6116:: with SMTP id v22mr5127845iob.171.1573151744491; 
 Thu, 07 Nov 2019 10:35:44 -0800 (PST)
Received: from localhost.localdomain ([2602:47:da84:5600:6d4:c4ff:fe4a:ea6b])
 by smtp.gmail.com with ESMTPSA id
 h14sm422344ilc.87.2019.11.07.10.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 10:35:43 -0800 (PST)
From: Matt Coffin <mcoffin13@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu/navi10: Implement od clk printing
Date: Thu,  7 Nov 2019 11:35:35 -0700
Message-Id:
 <e091c4085ecc669ea907fe5d8515f14586863f9b.1573151434.git.mcoffin13@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1573151434.git.mcoffin13@gmail.com>
References: <cover.1573151434.git.mcoffin13@gmail.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p365fKq/ue8k/gZIYfTV9otkqQ7yUDhWCSHtl7V5W2M=;
 b=powSnjGSzKlgKgg+20FV7K3qeNli8tgUeadr04E+/Y1uNjnzbk/9YZtH7Sbo9/IvDV
 aZc78U6ateUkeOyo5RyOUsjClDJX2NTr2SNmm6eO4MOnZ/Bt4x105fdcUbMc0bBTPMID
 3Vo9mlY1JuLYA55Dhd13yl2jyuhVOEaeTHcoX3XqC2Z6QFZPNO/KEx99EBfI5D96BQUe
 OjezywrNQirCOchS9PMw/S8ZdeLhvKxJ9cYKOTgpe80rEtO0tDmBCgmfXlIlCgIavuKc
 Wo8F05v1khBsqDiu55a8WBZixOz7MSdYTlIzIHisg1rPvvdmp4co9qEpY371RKOFKkOY
 JG8g==
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
Cc: Matt Coffin <mcoffin13@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107183535.8446obzdKms7ENXMGolDx-sM3FaUyeZ1iWSwc94Mjr4@z>

W1doeV0KQmVmb3JlIHRoaXMgcGF0Y2gsIG5hdmkxMCBvdmVyZHJpdmUgc2V0dGluZ3MgY291bGQg
bm90IGJlIHByaW50ZWQgdmlhCnBwX29kX2Nsa192b2x0YWdlCgpbSG93XQpJbXBsZW1lbnQgcHJp
bnRpbmcgZm9yIHRoZSBvdmVyZHJpdmUgc2V0dGluZ3MgZm9yIHRoZSBmb2xsb3dpbmcgY2xvY2tz
CmluIG5hdmkxMCdzIHBwdCBwcmludF9jbGtfbGV2ZWxzIGltcGxlbWVudGF0aW9uOgoKKiBTTVVf
T0RfU0NMSwoqIFNNVV9PRF9NQ0xLCiogU01VX09EX1ZERENfQ1VSVkUKLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0LmMgfCA1NiArKysrKysrKysrKysrKysrKysr
Ky0tCiAxIGZpbGUgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0LmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0LmMKaW5kZXggZTcxNzMyOGY5
M2NlLi41MDZhZjU5ZmY0NWYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L25hdmkxMF9wcHQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9uYXZp
MTBfcHB0LmMKQEAgLTY3NywxMyArNjc3LDI1IEBAIHN0YXRpYyBib29sIG5hdmkxMF9pc19zdXBw
b3J0X2ZpbmVfZ3JhaW5lZF9kcG0oc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsIGVudW0gc211CiAJ
cmV0dXJuIGRwbV9kZXNjLT5TbmFwVG9EaXNjcmV0ZSA9PSAwID8gdHJ1ZSA6IGZhbHNlOwogfQog
CitzdGF0aWMgaW5saW5lIGJvb2wgbmF2aTEwX29kX2ZlYXR1cmVfaXNfc3VwcG9ydGVkKHN0cnVj
dCBzbXVfMTFfMF9vdmVyZHJpdmVfdGFibGUgKm9kX3RhYmxlLCBlbnVtIFNNVV8xMV8wX09ERkVB
VFVSRV9JRCBmZWF0dXJlKQoreworCXJldHVybiBvZF90YWJsZS0+Y2FwW2ZlYXR1cmVdOworfQor
CisKIHN0YXRpYyBpbnQgbmF2aTEwX3ByaW50X2Nsa19sZXZlbHMoc3RydWN0IHNtdV9jb250ZXh0
ICpzbXUsCiAJCQllbnVtIHNtdV9jbGtfdHlwZSBjbGtfdHlwZSwgY2hhciAqYnVmKQogeworCU92
ZXJEcml2ZVRhYmxlX3QgKm9kX3RhYmxlOworCXN0cnVjdCBzbXVfMTFfMF9vdmVyZHJpdmVfdGFi
bGUgKm9kX3NldHRpbmdzOworCXVpbnQxNl90ICpjdXJ2ZV9zZXR0aW5nczsKIAlpbnQgaSwgc2l6
ZSA9IDAsIHJldCA9IDA7CiAJdWludDMyX3QgY3VyX3ZhbHVlID0gMCwgdmFsdWUgPSAwLCBjb3Vu
dCA9IDA7CiAJdWludDMyX3QgZnJlcV92YWx1ZXNbM10gPSB7MH07CiAJdWludDMyX3QgbWFya19p
bmRleCA9IDA7CisJc3RydWN0IHNtdV90YWJsZV9jb250ZXh0ICp0YWJsZV9jb250ZXh0ID0gJnNt
dS0+c211X3RhYmxlOworCW9kX3RhYmxlID0gKE92ZXJEcml2ZVRhYmxlX3QgKil0YWJsZV9jb250
ZXh0LT5vdmVyZHJpdmVfdGFibGU7CisJb2Rfc2V0dGluZ3MgPSBzbXUtPm9kX3NldHRpbmdzOwog
CiAJc3dpdGNoIChjbGtfdHlwZSkgewogCWNhc2UgU01VX0dGWENMSzoKQEAgLTczNCw2ICs3NDYs
NDUgQEAgc3RhdGljIGludCBuYXZpMTBfcHJpbnRfY2xrX2xldmVscyhzdHJ1Y3Qgc211X2NvbnRl
eHQgKnNtdSwKIAogCQl9CiAJCWJyZWFrOworCWNhc2UgU01VX09EX1NDTEs6CisJCWlmICghc211
LT5vZF9lbmFibGVkIHx8ICFvZF90YWJsZSB8fCAhb2Rfc2V0dGluZ3MpCisJCQlicmVhazsKKwkJ
aWYgKCFuYXZpMTBfb2RfZmVhdHVyZV9pc19zdXBwb3J0ZWQob2Rfc2V0dGluZ3MsIFNNVV8xMV8w
X09ERkVBVFVSRV9HRlhDTEtfTElNSVRTKSkKKwkJCWJyZWFrOworCQlzaXplICs9IHNwcmludGYo
YnVmICsgc2l6ZSwgIk9EX1NDTEs6XG4iKTsKKwkJc2l6ZSArPSBzcHJpbnRmKGJ1ZiArIHNpemUs
ICIwOiAldU1oelxuMTogJXVNaHpcbiIsIG9kX3RhYmxlLT5HZnhjbGtGbWluLCBvZF90YWJsZS0+
R2Z4Y2xrRm1heCk7CisJCWJyZWFrOworCWNhc2UgU01VX09EX01DTEs6CisJCWlmICghc211LT5v
ZF9lbmFibGVkIHx8ICFvZF90YWJsZSB8fCAhb2Rfc2V0dGluZ3MpCisJCQlicmVhazsKKwkJaWYg
KCFuYXZpMTBfb2RfZmVhdHVyZV9pc19zdXBwb3J0ZWQob2Rfc2V0dGluZ3MsIFNNVV8xMV8wX09E
RkVBVFVSRV9VQ0xLX01BWCkpCisJCQlicmVhazsKKwkJc2l6ZSArPSBzcHJpbnRmKGJ1ZiArIHNp
emUsICJPRF9NQ0xLOlxuIik7CisJCXNpemUgKz0gc3ByaW50ZihidWYgKyBzaXplLCAiMDogJXVN
SHpcbiIsIG9kX3RhYmxlLT5VY2xrRm1heCk7CisJCWJyZWFrOworCWNhc2UgU01VX09EX1ZERENf
Q1VSVkU6CisJCWlmICghc211LT5vZF9lbmFibGVkIHx8ICFvZF90YWJsZSB8fCAhb2Rfc2V0dGlu
Z3MpCisJCQlicmVhazsKKwkJaWYgKCFuYXZpMTBfb2RfZmVhdHVyZV9pc19zdXBwb3J0ZWQob2Rf
c2V0dGluZ3MsIFNNVV8xMV8wX09ERkVBVFVSRV9HRlhDTEtfQ1VSVkUpKQorCQkJYnJlYWs7CisJ
CXNpemUgKz0gc3ByaW50ZihidWYgKyBzaXplLCAiT0RfVkREQ19DVVJWRTpcbiIpOworCQlmb3Ig
KGkgPSAwOyBpIDwgMzsgaSsrKSB7CisJCQlzd2l0Y2ggKGkpIHsKKwkJCWNhc2UgMDoKKwkJCQlj
dXJ2ZV9zZXR0aW5ncyA9ICZvZF90YWJsZS0+R2Z4Y2xrRnJlcTE7CisJCQkJYnJlYWs7CisJCQlj
YXNlIDE6CisJCQkJY3VydmVfc2V0dGluZ3MgPSAmb2RfdGFibGUtPkdmeGNsa0ZyZXEyOworCQkJ
CWJyZWFrOworCQkJY2FzZSAyOgorCQkJCWN1cnZlX3NldHRpbmdzID0gJm9kX3RhYmxlLT5HZnhj
bGtGcmVxMzsKKwkJCQlicmVhazsKKwkJCWRlZmF1bHQ6CisJCQkJYnJlYWs7CisJCQl9CisJCQlz
aXplICs9IHNwcmludGYoYnVmICsgc2l6ZSwgIiVkOiAldU1IeiBAICV1bVZcbiIsIGksIGN1cnZl
X3NldHRpbmdzWzBdLCBjdXJ2ZV9zZXR0aW5nc1sxXSAvIE5BVkkxMF9WT0xUQUdFX1NDQUxFKTsK
KwkJfQorCQlicmVhazsKIAlkZWZhdWx0OgogCQlicmVhazsKIAl9CkBAIC0xNjAwLDExICsxNjUx
LDYgQEAgc3RhdGljIGlubGluZSB2b2lkIG5hdmkxMF9kdW1wX29kX3RhYmxlKE92ZXJEcml2ZVRh
YmxlX3QgKm9kX3RhYmxlKSB7CiAJcHJfZGVidWcoIk9EOiBPdmVyRHJpdmVQY3Q6ICVkXG4iLCBv
ZF90YWJsZS0+T3ZlckRyaXZlUGN0KTsKIH0KIAotc3RhdGljIGlubGluZSBib29sIG5hdmkxMF9v
ZF9mZWF0dXJlX2lzX3N1cHBvcnRlZChzdHJ1Y3Qgc211XzExXzBfb3ZlcmRyaXZlX3RhYmxlICpv
ZF90YWJsZSwgZW51bSBTTVVfMTFfMF9PREZFQVRVUkVfSUQgZmVhdHVyZSkKLXsKLQlyZXR1cm4g
b2RfdGFibGUtPmNhcFtmZWF0dXJlXTsKLX0KLQogc3RhdGljIGludCBuYXZpMTBfb2Rfc2V0dGlu
Z19jaGVja19yYW5nZShzdHJ1Y3Qgc211XzExXzBfb3ZlcmRyaXZlX3RhYmxlICpvZF90YWJsZSwg
ZW51bSBTTVVfMTFfMF9PRFNFVFRJTkdfSUQgc2V0dGluZywgdWludDMyX3QgdmFsdWUpCiB7CiAJ
aWYgKHZhbHVlIDwgb2RfdGFibGUtPm1pbltzZXR0aW5nXSkgewotLSAKMi4yMy4wCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
