Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A874EFC6196
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 21:28:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87C8C2084D
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 21:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C8C2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EC916F961;
	Fri,  8 Nov 2019 21:28:56 +0000 (UTC)
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 948BF6E0D7
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2019 21:28:54 +0000 (UTC)
Received: by mail-io1-xd44.google.com with SMTP id p6so7890946iod.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Nov 2019 13:28:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4Y6qJxPDXSjRUJg0dET/UhQAmuiNTUDprJjgmqZs6QQ=;
 b=IfBiMZe68Zbsv2+wnXuFuNC2qDcvpRFhAaGkV2rbZLuwSHmgoDoPq6H3r+A4i2if3V
 +bZ5s2OS1f2ytDlhFnqBB0zwAwM2wD467edqoyzQjswmmV1RghjlmRYWtckDO79p8uae
 VkmuIjZfL4A+eXN7fv1tax9eLxPESd2+I5mfe6r+wFuKnSXHksjsfAtJSNuTny8oxwnU
 YZN6KjgH9RCQHOfSecGpUpLcNax4juLCUwXt4IC/96r1Xq0GJHs68/NMOIxM20Ot55KE
 9+uYpJBjhjCtlJnBOcydo6OZqTEqCR+8LN6SNx8XMtvArkR5FOFHLCwSErZpUOz+n2OZ
 1CXA==
X-Gm-Message-State: APjAAAVsVpd1km7tHb+DBiRAlHJljkEXH1dIXcGP9fNYWkj9FSRDkmev
 uBqqxTUB0ldb6pBrjbZN7GgXNaIRI6VJqg==
X-Google-Smtp-Source: APXvYqwwlaI7uUGpVlnTs5jFRsT1p16iJIUAdWgMaMWQNRhY9+5Rg8flil38lp8fIfp+VtSNFpd4+w==
X-Received: by 2002:a5e:9244:: with SMTP id z4mr11840269iop.61.1573248533836; 
 Fri, 08 Nov 2019 13:28:53 -0800 (PST)
Received: from localhost.localdomain ([2602:47:da84:5600:6d4:c4ff:fe4a:ea6b])
 by smtp.gmail.com with ESMTPSA id
 g11sm961732ilq.39.2019.11.08.13.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2019 13:28:53 -0800 (PST)
From: Matt Coffin <mcoffin13@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	Evan.Quan@amd.com
Subject: [PATCH v2 3/3] drm/amdgpu/navi10: Implement od clk printing
Date: Fri,  8 Nov 2019 14:28:08 -0700
Message-Id:
 <af3be6e5fade73abee292d3398cd563886c82c99.1573248368.git.mcoffin13@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1573248368.git.mcoffin13@gmail.com>
References: <cover.1573248368.git.mcoffin13@gmail.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4Y6qJxPDXSjRUJg0dET/UhQAmuiNTUDprJjgmqZs6QQ=;
 b=hvIlNi9mbQFzq8QR+UzUIl5+MfAllQdilxSj1vESR4jDEb/WdZXdD5T1p0dqSfBWlV
 P7kHAvuPTd/7lnN6PaVLt0xesd13TLFxl/+Udj1AVlACtERKcbMDyaGrGfoPMj3Mu28n
 Lo2Z/aoNJOmRkMPdFEWK8X28Ou1Fxp0VsMfhIriORJexGJwNTkPMbu2JpuEyfTLIMlet
 AnOOplJQ9h0VV+ojWrl5quBbuTazk2ZfBhXS1dKOVTTFsLRPaDJtnsJJOwe/0h9f1lFP
 w/nATRRgtujK0MezkwcepUimUECQwD2lCobZl1Ex8HK+/QSuc7Uk12CknE7EuVaatqxy
 uAgA==
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
Cc: Alexander.Deucher@amd.com, Matt Coffin <mcoffin13@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191108212808.oKaSCHge5nk19ode2BtDKLHY3nPcSzikL5ENTZdnq1I@z>

W1doeV0KQmVmb3JlIHRoaXMgcGF0Y2gsIG5hdmkxMCBvdmVyZHJpdmUgc2V0dGluZ3MgY291bGQg
bm90IGJlIHByaW50ZWQgdmlhCnBwX29kX2Nsa192b2x0YWdlCgpbSG93XQpJbXBsZW1lbnQgcHJp
bnRpbmcgZm9yIHRoZSBvdmVyZHJpdmUgc2V0dGluZ3MgZm9yIHRoZSBmb2xsb3dpbmcgY2xvY2tz
CmluIG5hdmkxMCdzIHBwdCBwcmludF9jbGtfbGV2ZWxzIGltcGxlbWVudGF0aW9uOgoKKiBTTVVf
T0RfU0NMSwoqIFNNVV9PRF9NQ0xLCiogU01VX09EX1ZERENfQ1VSVkUKLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0LmMgfCA1NiArKysrKysrKysrKysrKysrKysr
Ky0tCiAxIGZpbGUgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0LmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0LmMKaW5kZXggM2UyNmMwM2Q1
ZWVkLi40ZmJkZjBlNTA3ZjMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L25hdmkxMF9wcHQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9uYXZp
MTBfcHB0LmMKQEAgLTY5MSwxMyArNjkxLDI1IEBAIHN0YXRpYyBib29sIG5hdmkxMF9pc19zdXBw
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
CiAJc3dpdGNoIChjbGtfdHlwZSkgewogCWNhc2UgU01VX0dGWENMSzoKQEAgLTc0OCw2ICs3NjAs
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
KwkJfQorCQlicmVhazsKIAlkZWZhdWx0OgogCQlicmVhazsKIAl9CkBAIC0xNjYxLDExICsxNzEy
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
