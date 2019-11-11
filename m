Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C13C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 18:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81FD21655
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 18:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81FD21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A450B6E9BF;
	Mon, 11 Nov 2019 18:23:18 +0000 (UTC)
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 617E46E9BE
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 18:23:17 +0000 (UTC)
Received: by mail-io1-xd43.google.com with SMTP id 1so15651367iou.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 10:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wFpb0NUGDEpGnw+122tt54bh+48d6wW/mRC+SB/ELl8=;
 b=N3C7+FvdS+PgtsBWbII59ndLhjdR1TEgzL6EeW8LoJ2tlTICDoDyeEMShWLdM5qUIR
 Mpiz51pihaKlsD5ngl8y+ocuhIROEj0qegbMxSzF6A002wMPYjUcjQG9FZ7YfwafKDWw
 3ZIrrp//c0cIYWh+mUuRoEl4pJfKI1vwu3oQDNuSBT8g5etTCJWyWa1cjh7UTNAZv3z1
 XH/VEflkXZmF1x0D6rVZNlfQMdF+hBS3bZkqhP9Wm013Ms5vW2YYA1JZMxDAGZ5REAe1
 62eABXRVYQgj1OqecMlx5efgzWaJfwizwYdeBM2ZwGqA+GsMy5zaFgeqdCGf/P8z2MyV
 eSPg==
X-Gm-Message-State: APjAAAWhXEB27VHMXMa8Jm2BvD7YF//MVCEYm6xCrAWvrVHpAZiqJYdf
 vQ9zhhb8fsKS920pvNBNLx8=
X-Google-Smtp-Source: APXvYqzQulZbUicYt6i4PZISGK54pHUa+CAhZiWCnyYhxMWGoMl8DiMLdpbzRIHsMaPd4tAAPrL9iw==
X-Received: by 2002:a5d:80d5:: with SMTP id h21mr24593276ior.298.1573496596686; 
 Mon, 11 Nov 2019 10:23:16 -0800 (PST)
Received: from localhost.localdomain ([2602:47:da84:5600:6d4:c4ff:fe4a:ea6b])
 by smtp.gmail.com with ESMTPSA id
 m7sm124980iop.56.2019.11.11.10.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 10:23:16 -0800 (PST)
From: Matt Coffin <mcoffin13@gmail.com>
To: Alexander.Deucher@amd.com
Subject: [PATCH v2 2/3] drm/amdgpu/navi10: implement GFXCLK_CURVE overdrive
Date: Mon, 11 Nov 2019 11:22:36 -0700
Message-Id:
 <1f7e23d296857e12b6770f3a8af4e82662f15db2.1573496261.git.mcoffin13@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <25bbc1b19042f74f1429da25e552ce71a68de92e.1573496261.git.mcoffin13@gmail.com>
References: <25bbc1b19042f74f1429da25e552ce71a68de92e.1573496261.git.mcoffin13@gmail.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wFpb0NUGDEpGnw+122tt54bh+48d6wW/mRC+SB/ELl8=;
 b=LuUESQaBRrUgh0Y08E9eosaGwjaYJKXD9MRrpwBnaK6RdOSMl5JbMtzcwHKWn6S0yZ
 AVNqHB1wlg1XPPUGpsENFZTBlqJ0NNrQAtk+hgxZRyn5e24A6iTuEB5p6IAJ8MXF73hi
 1fu2+pH/C6s/NWSxy9gmCtJCuwJmfBfJy4FXWLh2nz3QrueYc6dpF66a9Bnu86oFdyCZ
 33HAWrlQpNQ9j0xOnFol1hKOSVLjIsZAwUnKjWnd1n7djZljWiHcbklGibeYs76em5HP
 J9LuYvA9yVlbEwX4vR/BlWsAON7hpnd/7ayWRiRXnuxAu7oL6DRcj3t3NympAIMpJNit
 dxug==
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
Message-ID: <20191111182236.ZFBrnwvtDSEUvt51cWzRV6oJUaQK3liUxrnzhAZfX58@z>

W1doeV0KQmVmb3JlIHRoaXMgcGF0Y2gsIHRoZXJlIHdhcyBubyB3YXkgdG8gc2V0IHRoZSBnZnhj
bGsgdm9sdGFnZSBjdXJ2ZSBpbgp0aGUgb3ZlcmRyaXZlIHNldHRpbmdzIGZvciBuYXZpMTAgdGhy
b3VnaCBwcF9vZF9jbGtfdm9sdGFnZQoKW0hvd10KQWRkIHRoZSByZXF1aXJlZCBpbXBsZW1lbnRh
dGlvbiB0byBuYXZpMTAncyBwcHQgZHBtIHRhYmxlIGVkaXRpbmcKaW1wbGVtZW50YXRpb24sIHNp
bWlsYXIgdG8gdGhlIHZlZ2EyMCBpbXBsZW1lbnRhdGlvbiBhbmQgaW50ZXJmYWNlLgoKU2lnbmVk
LW9mZi1ieTogTWF0dCBDb2ZmaW4gPG1jb2ZmaW4xM0BnbWFpbC5jb20+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvbmF2aTEwX3BwdC5jIHwgNjAgKysrKysrKysrKysrKysrKysr
KysrLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvbmF2aTEwX3BwdC5oIHwgIDIgKwog
MiBmaWxlcyBjaGFuZ2VkLCA2MCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYwppbmRleCAzNTRmNjMxMDMzMDgu
LjNlMjZjMDNkNWVlZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
bmF2aTEwX3BwdC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9w
cHQuYwpAQCAtMTcyOCw2ICsxNzI4LDggQEAgc3RhdGljIGludCBuYXZpMTBfb2RfZWRpdF9kcG1f
dGFibGUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsIGVudW0gUFBfT0RfRFBNX1RBQkwKIAlzdHJ1
Y3Qgc211X3RhYmxlX2NvbnRleHQgKnRhYmxlX2NvbnRleHQgPSAmc211LT5zbXVfdGFibGU7CiAJ
T3ZlckRyaXZlVGFibGVfdCAqb2RfdGFibGU7CiAJc3RydWN0IHNtdV8xMV8wX292ZXJkcml2ZV90
YWJsZSAqb2Rfc2V0dGluZ3M7CisJZW51bSBTTVVfMTFfMF9PRFNFVFRJTkdfSUQgZnJlcV9zZXR0
aW5nLCB2b2x0YWdlX3NldHRpbmc7CisJdWludDE2X3QgKmZyZXFfcHRyLCAqdm9sdGFnZV9wdHI7
CiAJb2RfdGFibGUgPSAoT3ZlckRyaXZlVGFibGVfdCAqKXRhYmxlX2NvbnRleHQtPm92ZXJkcml2
ZV90YWJsZTsKIAogCWlmICghc211LT5vZF9lbmFibGVkKSB7CkBAIC0xODI0LDggKzE4MjYsNjIg
QEAgc3RhdGljIGludCBuYXZpMTBfb2RfZWRpdF9kcG1fdGFibGUoc3RydWN0IHNtdV9jb250ZXh0
ICpzbXUsIGVudW0gUFBfT0RfRFBNX1RBQkwKIAkJfQogCQlicmVhazsKIAljYXNlIFBQX09EX0VE
SVRfVkREQ19DVVJWRToKLQkJLy8gVE9ETzogaW1wbGVtZW50Ci0JCXJldHVybiAtRU5PU1lTOwor
CQlpZiAoIW5hdmkxMF9vZF9mZWF0dXJlX2lzX3N1cHBvcnRlZChvZF9zZXR0aW5ncywgU01VXzEx
XzBfT0RGRUFUVVJFX0dGWENMS19DVVJWRSkpIHsKKwkJCXByX3dhcm4oIkdGWENMS19DVVJWRSBu
b3Qgc3VwcG9ydGVkIVxuIik7CisJCQlyZXR1cm4gLUVOT1RTVVBQOworCQl9CisJCWlmIChzaXpl
IDwgMykgeworCQkJcHJfaW5mbygiaW52YWxpZCBudW1iZXIgb2YgcGFyYW1ldGVyczogJWRcbiIs
IHNpemUpOworCQkJcmV0dXJuIC1FSU5WQUw7CisJCX0KKwkJaWYgKCFvZF90YWJsZSkgeworCQkJ
cHJfaW5mbygiT3ZlcmRyaXZlIGlzIG5vdCBpbml0aWFsaXplZFxuIik7CisJCQlyZXR1cm4gLUVJ
TlZBTDsKKwkJfQorCisJCXN3aXRjaCAoaW5wdXRbMF0pIHsKKwkJY2FzZSAwOgorCQkJZnJlcV9z
ZXR0aW5nID0gU01VXzExXzBfT0RTRVRUSU5HX1ZEREdGWENVUlZFRlJFUV9QMTsKKwkJCXZvbHRh
Z2Vfc2V0dGluZyA9IFNNVV8xMV8wX09EU0VUVElOR19WRERHRlhDVVJWRVZPTFRBR0VfUDE7CisJ
CQlmcmVxX3B0ciA9ICZvZF90YWJsZS0+R2Z4Y2xrRnJlcTE7CisJCQl2b2x0YWdlX3B0ciA9ICZv
ZF90YWJsZS0+R2Z4Y2xrVm9sdDE7CisJCQlicmVhazsKKwkJY2FzZSAxOgorCQkJZnJlcV9zZXR0
aW5nID0gU01VXzExXzBfT0RTRVRUSU5HX1ZEREdGWENVUlZFRlJFUV9QMjsKKwkJCXZvbHRhZ2Vf
c2V0dGluZyA9IFNNVV8xMV8wX09EU0VUVElOR19WRERHRlhDVVJWRVZPTFRBR0VfUDI7CisJCQlm
cmVxX3B0ciA9ICZvZF90YWJsZS0+R2Z4Y2xrRnJlcTI7CisJCQl2b2x0YWdlX3B0ciA9ICZvZF90
YWJsZS0+R2Z4Y2xrVm9sdDI7CisJCQlicmVhazsKKwkJY2FzZSAyOgorCQkJZnJlcV9zZXR0aW5n
ID0gU01VXzExXzBfT0RTRVRUSU5HX1ZEREdGWENVUlZFRlJFUV9QMzsKKwkJCXZvbHRhZ2Vfc2V0
dGluZyA9IFNNVV8xMV8wX09EU0VUVElOR19WRERHRlhDVVJWRVZPTFRBR0VfUDM7CisJCQlmcmVx
X3B0ciA9ICZvZF90YWJsZS0+R2Z4Y2xrRnJlcTM7CisJCQl2b2x0YWdlX3B0ciA9ICZvZF90YWJs
ZS0+R2Z4Y2xrVm9sdDM7CisJCQlicmVhazsKKwkJZGVmYXVsdDoKKwkJCXByX2luZm8oIkludmFs
aWQgVkREQ19DVVJWRSBpbmRleDogJWxkXG4iLCBpbnB1dFswXSk7CisJCQlwcl9pbmZvKCJTdXBw
b3J0ZWQgaW5kaWNlczogWzAsIDEsIDJdXG4iKTsKKwkJCXJldHVybiAtRUlOVkFMOworCQl9CisJ
CXJldCA9IG5hdmkxMF9vZF9zZXR0aW5nX2NoZWNrX3JhbmdlKG9kX3NldHRpbmdzLCBmcmVxX3Nl
dHRpbmcsIGlucHV0WzFdKTsKKwkJaWYgKHJldCkKKwkJCXJldHVybiByZXQ7CisJCS8vIEFsbG93
IHNldHRpbmcgemVybyB0byBkaXNhYmxlIHRoZSBPdmVyRHJpdmUgVkREQyBjdXJ2ZQorCQlpZiAo
aW5wdXRbMl0gIT0gMCkgeworCQkJcmV0ID0gbmF2aTEwX29kX3NldHRpbmdfY2hlY2tfcmFuZ2Uo
b2Rfc2V0dGluZ3MsIHZvbHRhZ2Vfc2V0dGluZywgaW5wdXRbMl0pOworCQkJaWYgKHJldCkKKwkJ
CQlyZXR1cm4gcmV0OworCQkJKmZyZXFfcHRyID0gaW5wdXRbMV07CisJCQkqdm9sdGFnZV9wdHIg
PSAoKHVpbnQxNl90KWlucHV0WzJdKSAqIE5BVkkxMF9WT0xUQUdFX1NDQUxFOworCQkJcHJfZGVi
dWcoIk9EOiBzZXQgY3VydmUgJWxkOiAoJWQsICVkKVxuIiwgaW5wdXRbMF0sICpmcmVxX3B0ciwg
KnZvbHRhZ2VfcHRyKTsKKwkJfSBlbHNlIHsKKwkJCS8vIElmIHNldHRpbmcgMCwgZGlzYWJsZSBh
bGwgdm9sdGFnZSBjdXJ2ZSBzZXR0aW5ncworCQkJb2RfdGFibGUtPkdmeGNsa1ZvbHQxID0gMDsK
KwkJCW9kX3RhYmxlLT5HZnhjbGtWb2x0MiA9IDA7CisJCQlvZF90YWJsZS0+R2Z4Y2xrVm9sdDMg
PSAwOworCQl9CisJCW5hdmkxMF9kdW1wX29kX3RhYmxlKG9kX3RhYmxlKTsKKwkJYnJlYWs7CiAJ
ZGVmYXVsdDoKIAkJcmV0dXJuIC1FTk9TWVM7CiAJfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wb3dlcnBsYXkvbmF2aTEwX3BwdC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvbmF2aTEwX3BwdC5oCmluZGV4IGEzN2UzN2M1ZjEwNS4uZmQ2ZGRhMWE2N2ExIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0LmgKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvbmF2aTEwX3BwdC5oCkBAIC0zMyw2ICszMyw4
IEBACiAjZGVmaW5lIE5BVkkxNF9VTURfUFNUQVRFX1BFQUtfWFRYX0dGWENMSyAgICAgKDE3MTcp
CiAjZGVmaW5lIE5BVkkxNF9VTURfUFNUQVRFX1BFQUtfWExfR0ZYQ0xLICAgICAgKDE0NDgpCiAK
KyNkZWZpbmUgTkFWSTEwX1ZPTFRBR0VfU0NBTEUgKDQpCisKIGV4dGVybiB2b2lkIG5hdmkxMF9z
ZXRfcHB0X2Z1bmNzKHN0cnVjdCBzbXVfY29udGV4dCAqc211KTsKIAogI2VuZGlmCi0tIAoyLjIz
LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
