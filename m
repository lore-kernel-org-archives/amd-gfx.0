Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6F5C433EC
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 08:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B89E206C3
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 08:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Cw6DE8ip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B89E206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF4A989949;
	Thu,  4 Jun 2020 08:12:54 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EEC589298
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 08:12:52 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id x13so5043231wrv.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jun 2020 01:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mPAnyNEtS0uY+bUuM8GxOFOVsLMIhBxwz7ItIj7lR3A=;
 b=Cw6DE8iprZ3uQg5gII/9i5sihculizd8rViFXjzCXSdVxul9CqWdFgOfY71gVkGiuV
 juGxO+Tm75A9A2e/W5n2HP7py+rVnr9u2LxOwSRBXRkhwJHpkeuFJDFWdS3KfjcSOmQG
 RdZmXaDOTVBzfxFPq9ypg/Dpc5CyQyRF0HX2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mPAnyNEtS0uY+bUuM8GxOFOVsLMIhBxwz7ItIj7lR3A=;
 b=gxzprNBbFJdsjCDa9qozsixlpIjaX3TXpLpR2ZxHMlVNgPmW7Ig1TejJv19cShGBZR
 l2JxijJJbonntfKcgNbKyQ4Sbeu6/2rWMfV3T8NOubO2RnFolwdLkyzC4s1zPZQaJx+W
 L/OAS64Xjh6J55HNweI0HX/OZ6bxk+eLgATuwWQX0e1mmGA0j6vCFUntenY7iPTQNA3c
 sbiTcBbSgyvHxPzT3U/U1kmsAq4/OsMFxcJR+swF8I4kCLEYwt3KbzmEXMaGGvBda0OE
 hnbY1k0dOsqgPQXRG/GdF71g73FIfUDNcGDMw9NJCRk5vLSJP4I+7ROxwxdfW6EYXabO
 ur8Q==
X-Gm-Message-State: AOAM532OoIKocOPr915ybVsyw/g2E2r7ltylAbBspdbnYV2+rlV36pya
 VvdWJCFDBQYNU0kGOTbfq6JCHg==
X-Google-Smtp-Source: ABdhPJzqUtEw7Ja3sjtBGx+terae6/AGLT+5Iphc3r7rUYdY/P0UYh8UASXP+HWl66kBwvknWv+Dcg==
X-Received: by 2002:a5d:6391:: with SMTP id p17mr3458296wru.118.1591258371351; 
 Thu, 04 Jun 2020 01:12:51 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id f11sm6873305wrj.2.2020.06.04.01.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 01:12:50 -0700 (PDT)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: [PATCH 15/18] drm/amdgpu: use dma-fence annotations for gpu reset code
Date: Thu,  4 Jun 2020 10:12:21 +0200
Message-Id: <20200604081224.863494-16-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
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
Cc: linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 Chris Wilson <chris@chris-wilson.co.uk>, linaro-mm-sig@lists.linaro.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VG8gaW1wcm92ZSBjb3ZlcmFnZSBhbHNvIGFubm90YXRlIHRoZSBncHUgcmVzZXQgY29kZSBpdHNl
bGYsIHNpbmNlCnRoYXQncyBjYWxsZWQgZnJvbSBvdGhlciBwbGFjZXMgdGhhbiBkcm0vc2NoZWR1
bGVyICh3aGljaCBpcyBhbHJlYWR5CmFubm90YXRlZCkuIEFubm90YXRpb25zIG5lc3RzLCBzbyB0
aGlzIGRvZXNuJ3QgYnJlYWsgYW55dGhpbmcsIGFuZAphbGxvd3MgZWFzaWVyIHRlc3RpbmcuCgpD
YzogbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnCkNjOiBsaW5hcm8tbW0tc2lnQGxpc3RzLmxp
bmFyby5vcmcKQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnCkNjOiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpDYzogaW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzog
Q2hyaXMgV2lsc29uIDxjaHJpc0BjaHJpcy13aWxzb24uY28udWs+CkNjOiBNYWFydGVuIExhbmto
b3JzdCA8bWFhcnRlbi5sYW5raG9yc3RAbGludXguaW50ZWwuY29tPgpDYzogQ2hyaXN0aWFuIEvD
tm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgVmV0
dGVyIDxkYW5pZWwudmV0dGVyQGZmd2xsLmNoPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYyB8IDEwICsrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA5IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMKaW5kZXggYTAyN2E4ZjdiMjgxLi5hYzAyODZhNWYyZmMgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTQyMTUsNiArNDIxNSw5
IEBAIGludCBhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LAogCQkoYW1kZ3B1X2FzaWNfcmVzZXRfbWV0aG9kKGFkZXYpID09IEFNRF9SRVNFVF9NRVRI
T0RfQkFDTykgPwogCQl0cnVlIDogZmFsc2U7CiAJYm9vbCBhdWRpb19zdXNwZW5kZWQgPSBmYWxz
ZTsKKwlib29sIGZlbmNlX2Nvb2tpZTsKKworCWZlbmNlX2Nvb2tpZSA9IGRtYV9mZW5jZV9iZWdp
bl9zaWduYWxsaW5nKCk7CiAKIAkvKgogCSAqIEZsdXNoIFJBTSB0byBkaXNrIHNvIHRoYXQgYWZ0
ZXIgcmVib290CkBAIC00MjQzLDYgKzQyNDYsNyBAQCBpbnQgYW1kZ3B1X2RldmljZV9ncHVfcmVj
b3ZlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJRFJNX0lORk8oIkJhaWxpbmcgb24g
VERSIGZvciBzX2pvYjolbGx4LCBoaXZlOiAlbGx4IGFzIGFub3RoZXIgYWxyZWFkeSBpbiBwcm9n
cmVzcyIsCiAJCQkgIGpvYiA/IGpvYi0+YmFzZS5pZCA6IC0xLCBoaXZlLT5oaXZlX2lkKTsKIAkJ
bXV0ZXhfdW5sb2NrKCZoaXZlLT5oaXZlX2xvY2spOworCQlkbWFfZmVuY2VfZW5kX3NpZ25hbGxp
bmcoZmVuY2VfY29va2llKTsKIAkJcmV0dXJuIDA7CiAJfQogCkBAIC00MjUzLDggKzQyNTcsMTAg
QEAgaW50IGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsCiAJICovCiAJSU5JVF9MSVNUX0hFQUQoJmRldmljZV9saXN0KTsKIAlpZiAoYWRldi0+Z21j
LnhnbWkubnVtX3BoeXNpY2FsX25vZGVzID4gMSkgewotCQlpZiAoIWhpdmUpCisJCWlmICghaGl2
ZSkgeworCQkJZG1hX2ZlbmNlX2VuZF9zaWduYWxsaW5nKGZlbmNlX2Nvb2tpZSk7CiAJCQlyZXR1
cm4gLUVOT0RFVjsKKwkJfQogCQlpZiAoIWxpc3RfaXNfZmlyc3QoJmFkZXYtPmdtYy54Z21pLmhl
YWQsICZoaXZlLT5kZXZpY2VfbGlzdCkpCiAJCQlsaXN0X3JvdGF0ZV90b19mcm9udCgmYWRldi0+
Z21jLnhnbWkuaGVhZCwgJmhpdmUtPmRldmljZV9saXN0KTsKIAkJZGV2aWNlX2xpc3RfaGFuZGxl
ID0gJmhpdmUtPmRldmljZV9saXN0OwpAQCAtNDI2OSw2ICs0Mjc1LDcgQEAgaW50IGFtZGdwdV9k
ZXZpY2VfZ3B1X3JlY292ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQlEUk1fSU5G
TygiQmFpbGluZyBvbiBURFIgZm9yIHNfam9iOiVsbHgsIGFzIGFub3RoZXIgYWxyZWFkeSBpbiBw
cm9ncmVzcyIsCiAJCQkJICBqb2IgPyBqb2ItPmJhc2UuaWQgOiAtMSk7CiAJCQltdXRleF91bmxv
Y2soJmhpdmUtPmhpdmVfbG9jayk7CisJCQlkbWFfZmVuY2VfZW5kX3NpZ25hbGxpbmcoZmVuY2Vf
Y29va2llKTsKIAkJCXJldHVybiAwOwogCQl9CiAKQEAgLTQ0MDksNiArNDQxNiw3IEBAIGludCBh
bWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCiAJ
aWYgKHIpCiAJCWRldl9pbmZvKGFkZXYtPmRldiwgIkdQVSByZXNldCBlbmQgd2l0aCByZXQgPSAl
ZFxuIiwgcik7CisJZG1hX2ZlbmNlX2VuZF9zaWduYWxsaW5nKGZlbmNlX2Nvb2tpZSk7CiAJcmV0
dXJuIHI7CiB9CiAKLS0gCjIuMjYuMgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
