Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D3BC43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 18:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85CE6214E0
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 18:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CE6214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40EEE6E9BE;
	Mon, 11 Nov 2019 18:23:18 +0000 (UTC)
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4F4D6E9BE
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 18:23:17 +0000 (UTC)
Received: by mail-il1-x142.google.com with SMTP id m5so12993323ilq.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 10:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZftSfE/Uf5WXLZSL9S1S+VdBUFRjejfjS1NPnK7NdF0=;
 b=eNuRt3dIW0OQ6n3Vs6Gc6TCXWr7vXD9o2ujTwEVddV2c2zZZ0OVKa9WPNyuZ6rmKWh
 pLbir6CUzqOKlMqPChNe6/wAYpDfgXvFD1kQPwTgMDUCQPSW7CETaxASmcPYmEb128Fv
 zzRxjfq9p+Ksu/ImeXZiglZK+ZVtsrCU2lJTNBmVyztmozz9GRfbeLwvZ5fl8irQBsFa
 3IFdScdqGQM7RDHPH0XCKSE2KJYe/Si4jR6tWi6Di3qxCM5TcvALNXHVHpIyLnk0e64g
 FnTnGzz8wwaQ0Apj1oQyWXokt5orX/kJ7yoFXmMjFAB8CddnJ3XkQcz6Sk7WlufODwfV
 DtpQ==
X-Gm-Message-State: APjAAAV5WJO0cCvLoSUzVoVdSPJZnrf3AZOkZQ9T5Amfl/x3ynAnUb5H
 mSQnsmvGlCz6l49a8hCasnc=
X-Google-Smtp-Source: APXvYqy53NC8cgPToI0WHjCDt3bwAp66vzJvZET7nkXeiqvzVFZVH4UXNJ0e8z/Hb3I9E+qOk+Xoog==
X-Received: by 2002:a92:3c13:: with SMTP id j19mr30881948ila.245.1573496597217; 
 Mon, 11 Nov 2019 10:23:17 -0800 (PST)
Received: from localhost.localdomain ([2602:47:da84:5600:6d4:c4ff:fe4a:ea6b])
 by smtp.gmail.com with ESMTPSA id
 m7sm124980iop.56.2019.11.11.10.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 10:23:16 -0800 (PST)
From: Matt Coffin <mcoffin13@gmail.com>
To: Alexander.Deucher@amd.com
Subject: [PATCH v2 3/3] drm/amdgpu/navi10: Implement od clk printing
Date: Mon, 11 Nov 2019 11:22:37 -0700
Message-Id:
 <2afa88d3e2df1987e07dca80e36c0bd7ef584dd6.1573496261.git.mcoffin13@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <25bbc1b19042f74f1429da25e552ce71a68de92e.1573496261.git.mcoffin13@gmail.com>
References: <25bbc1b19042f74f1429da25e552ce71a68de92e.1573496261.git.mcoffin13@gmail.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZftSfE/Uf5WXLZSL9S1S+VdBUFRjejfjS1NPnK7NdF0=;
 b=rZ75bbLruSlqkKKsEGmmFJoQwKpKuvj1efjZykF+xcB4NVuHEwI+HLhX0MKNujN/x6
 VbxAnid3HY7FCN9itYvwbENWqS8R3ivea/r18NB2W9aajAoAhZ6JSxjOEaZDhnVN4yS2
 TMHL6UTQ9URanSWuUio+XyeKzc39JzLAxT1EtzNy9mcSn++HQ8fFYivkLGOmPAaKN347
 aEuJBtz7L/LY0rxLEonQrtPdnPEfYX2+qqJw+plA0YdvjWGcNLs7nHujAy6GUATANLXb
 ujv/THJv0avl/qGeIPVUy+biktszNhIZU76Uv8aSOxvjlHphsnWIpSa4/mesWMPFW8EX
 YgTw==
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
Cc: Matt Coffin <mcoffin13@gmail.com>, Evan.Quan@amd.com,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111182237.Nr2uj7gJCwUTfOrxTGn8INrBuAaSBNUfru2VQWGUR3s@z>

W1doeV0KQmVmb3JlIHRoaXMgcGF0Y2gsIG5hdmkxMCBvdmVyZHJpdmUgc2V0dGluZ3MgY291bGQg
bm90IGJlIHByaW50ZWQgdmlhCnBwX29kX2Nsa192b2x0YWdlCgpbSG93XQpJbXBsZW1lbnQgcHJp
bnRpbmcgZm9yIHRoZSBvdmVyZHJpdmUgc2V0dGluZ3MgZm9yIHRoZSBmb2xsb3dpbmcgY2xvY2tz
CmluIG5hdmkxMCdzIHBwdCBwcmludF9jbGtfbGV2ZWxzIGltcGxlbWVudGF0aW9uOgoKKiBTTVVf
T0RfU0NMSwoqIFNNVV9PRF9NQ0xLCiogU01VX09EX1ZERENfQ1VSVkUKClNpZ25lZC1vZmYtYnk6
IE1hdHQgQ29mZmluIDxtY29mZmluMTNAZ21haWwuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYyB8IDU2ICsrKysrKysrKysrKysrKysrKysrLS0KIDEg
ZmlsZSBjaGFuZ2VkLCA1MSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYwppbmRleCAzZTI2YzAzZDVlZWQuLjRm
YmRmMGU1MDdmMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvbmF2
aTEwX3BwdC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQu
YwpAQCAtNjkxLDEzICs2OTEsMjUgQEAgc3RhdGljIGJvb2wgbmF2aTEwX2lzX3N1cHBvcnRfZmlu
ZV9ncmFpbmVkX2RwbShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwgZW51bSBzbXUKIAlyZXR1cm4g
ZHBtX2Rlc2MtPlNuYXBUb0Rpc2NyZXRlID09IDAgPyB0cnVlIDogZmFsc2U7CiB9CiAKK3N0YXRp
YyBpbmxpbmUgYm9vbCBuYXZpMTBfb2RfZmVhdHVyZV9pc19zdXBwb3J0ZWQoc3RydWN0IHNtdV8x
MV8wX292ZXJkcml2ZV90YWJsZSAqb2RfdGFibGUsIGVudW0gU01VXzExXzBfT0RGRUFUVVJFX0lE
IGZlYXR1cmUpCit7CisJcmV0dXJuIG9kX3RhYmxlLT5jYXBbZmVhdHVyZV07Cit9CisKKwogc3Rh
dGljIGludCBuYXZpMTBfcHJpbnRfY2xrX2xldmVscyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwK
IAkJCWVudW0gc211X2Nsa190eXBlIGNsa190eXBlLCBjaGFyICpidWYpCiB7CisJT3ZlckRyaXZl
VGFibGVfdCAqb2RfdGFibGU7CisJc3RydWN0IHNtdV8xMV8wX292ZXJkcml2ZV90YWJsZSAqb2Rf
c2V0dGluZ3M7CisJdWludDE2X3QgKmN1cnZlX3NldHRpbmdzOwogCWludCBpLCBzaXplID0gMCwg
cmV0ID0gMDsKIAl1aW50MzJfdCBjdXJfdmFsdWUgPSAwLCB2YWx1ZSA9IDAsIGNvdW50ID0gMDsK
IAl1aW50MzJfdCBmcmVxX3ZhbHVlc1szXSA9IHswfTsKIAl1aW50MzJfdCBtYXJrX2luZGV4ID0g
MDsKKwlzdHJ1Y3Qgc211X3RhYmxlX2NvbnRleHQgKnRhYmxlX2NvbnRleHQgPSAmc211LT5zbXVf
dGFibGU7CisJb2RfdGFibGUgPSAoT3ZlckRyaXZlVGFibGVfdCAqKXRhYmxlX2NvbnRleHQtPm92
ZXJkcml2ZV90YWJsZTsKKwlvZF9zZXR0aW5ncyA9IHNtdS0+b2Rfc2V0dGluZ3M7CiAKIAlzd2l0
Y2ggKGNsa190eXBlKSB7CiAJY2FzZSBTTVVfR0ZYQ0xLOgpAQCAtNzQ4LDYgKzc2MCw0NSBAQCBz
dGF0aWMgaW50IG5hdmkxMF9wcmludF9jbGtfbGV2ZWxzKHN0cnVjdCBzbXVfY29udGV4dCAqc211
LAogCiAJCX0KIAkJYnJlYWs7CisJY2FzZSBTTVVfT0RfU0NMSzoKKwkJaWYgKCFzbXUtPm9kX2Vu
YWJsZWQgfHwgIW9kX3RhYmxlIHx8ICFvZF9zZXR0aW5ncykKKwkJCWJyZWFrOworCQlpZiAoIW5h
dmkxMF9vZF9mZWF0dXJlX2lzX3N1cHBvcnRlZChvZF9zZXR0aW5ncywgU01VXzExXzBfT0RGRUFU
VVJFX0dGWENMS19MSU1JVFMpKQorCQkJYnJlYWs7CisJCXNpemUgKz0gc3ByaW50ZihidWYgKyBz
aXplLCAiT0RfU0NMSzpcbiIpOworCQlzaXplICs9IHNwcmludGYoYnVmICsgc2l6ZSwgIjA6ICV1
TWh6XG4xOiAldU1oelxuIiwgb2RfdGFibGUtPkdmeGNsa0ZtaW4sIG9kX3RhYmxlLT5HZnhjbGtG
bWF4KTsKKwkJYnJlYWs7CisJY2FzZSBTTVVfT0RfTUNMSzoKKwkJaWYgKCFzbXUtPm9kX2VuYWJs
ZWQgfHwgIW9kX3RhYmxlIHx8ICFvZF9zZXR0aW5ncykKKwkJCWJyZWFrOworCQlpZiAoIW5hdmkx
MF9vZF9mZWF0dXJlX2lzX3N1cHBvcnRlZChvZF9zZXR0aW5ncywgU01VXzExXzBfT0RGRUFUVVJF
X1VDTEtfTUFYKSkKKwkJCWJyZWFrOworCQlzaXplICs9IHNwcmludGYoYnVmICsgc2l6ZSwgIk9E
X01DTEs6XG4iKTsKKwkJc2l6ZSArPSBzcHJpbnRmKGJ1ZiArIHNpemUsICIwOiAldU1IelxuIiwg
b2RfdGFibGUtPlVjbGtGbWF4KTsKKwkJYnJlYWs7CisJY2FzZSBTTVVfT0RfVkREQ19DVVJWRToK
KwkJaWYgKCFzbXUtPm9kX2VuYWJsZWQgfHwgIW9kX3RhYmxlIHx8ICFvZF9zZXR0aW5ncykKKwkJ
CWJyZWFrOworCQlpZiAoIW5hdmkxMF9vZF9mZWF0dXJlX2lzX3N1cHBvcnRlZChvZF9zZXR0aW5n
cywgU01VXzExXzBfT0RGRUFUVVJFX0dGWENMS19DVVJWRSkpCisJCQlicmVhazsKKwkJc2l6ZSAr
PSBzcHJpbnRmKGJ1ZiArIHNpemUsICJPRF9WRERDX0NVUlZFOlxuIik7CisJCWZvciAoaSA9IDA7
IGkgPCAzOyBpKyspIHsKKwkJCXN3aXRjaCAoaSkgeworCQkJY2FzZSAwOgorCQkJCWN1cnZlX3Nl
dHRpbmdzID0gJm9kX3RhYmxlLT5HZnhjbGtGcmVxMTsKKwkJCQlicmVhazsKKwkJCWNhc2UgMToK
KwkJCQljdXJ2ZV9zZXR0aW5ncyA9ICZvZF90YWJsZS0+R2Z4Y2xrRnJlcTI7CisJCQkJYnJlYWs7
CisJCQljYXNlIDI6CisJCQkJY3VydmVfc2V0dGluZ3MgPSAmb2RfdGFibGUtPkdmeGNsa0ZyZXEz
OworCQkJCWJyZWFrOworCQkJZGVmYXVsdDoKKwkJCQlicmVhazsKKwkJCX0KKwkJCXNpemUgKz0g
c3ByaW50ZihidWYgKyBzaXplLCAiJWQ6ICV1TUh6IEAgJXVtVlxuIiwgaSwgY3VydmVfc2V0dGlu
Z3NbMF0sIGN1cnZlX3NldHRpbmdzWzFdIC8gTkFWSTEwX1ZPTFRBR0VfU0NBTEUpOworCQl9CisJ
CWJyZWFrOwogCWRlZmF1bHQ6CiAJCWJyZWFrOwogCX0KQEAgLTE2NjEsMTEgKzE3MTIsNiBAQCBz
dGF0aWMgaW5saW5lIHZvaWQgbmF2aTEwX2R1bXBfb2RfdGFibGUoT3ZlckRyaXZlVGFibGVfdCAq
b2RfdGFibGUpIHsKIAlwcl9kZWJ1ZygiT0Q6IE92ZXJEcml2ZVBjdDogJWRcbiIsIG9kX3RhYmxl
LT5PdmVyRHJpdmVQY3QpOwogfQogCi1zdGF0aWMgaW5saW5lIGJvb2wgbmF2aTEwX29kX2ZlYXR1
cmVfaXNfc3VwcG9ydGVkKHN0cnVjdCBzbXVfMTFfMF9vdmVyZHJpdmVfdGFibGUgKm9kX3RhYmxl
LCBlbnVtIFNNVV8xMV8wX09ERkVBVFVSRV9JRCBmZWF0dXJlKQotewotCXJldHVybiBvZF90YWJs
ZS0+Y2FwW2ZlYXR1cmVdOwotfQotCiBzdGF0aWMgaW50IG5hdmkxMF9vZF9zZXR0aW5nX2NoZWNr
X3JhbmdlKHN0cnVjdCBzbXVfMTFfMF9vdmVyZHJpdmVfdGFibGUgKm9kX3RhYmxlLCBlbnVtIFNN
VV8xMV8wX09EU0VUVElOR19JRCBzZXR0aW5nLCB1aW50MzJfdCB2YWx1ZSkKIHsKIAlpZiAodmFs
dWUgPCBvZF90YWJsZS0+bWluW3NldHRpbmddKSB7Ci0tIAoyLjIzLjAKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
