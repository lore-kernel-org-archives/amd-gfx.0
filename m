Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF415C4742C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 14:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D1420715
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 14:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XwFxvGa9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D1420715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA8CA6E5A9;
	Fri, 13 Nov 2020 14:28:21 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D44BE6E51A
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 13:49:48 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id c9so8200764wml.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 05:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+yLMECfz4SQeh3+r6t6vIS8Tp4hfLiHYcv2v7xPbbH8=;
 b=XwFxvGa9Xc8VSIwGJA9BMdIQW9mUlNFmQAqTyunI02+OZcgeOhYLBswJPnWTzruwhx
 mo2BJ/8T2PrZu9oTvXUxAG0l3V9EYDdFyx7DsRMMIdRybw/crYokPbqPGjgsX1OrvKg4
 EuqJPpQkRnhM/0e2vZJTF4poIpcDRj4YipAu3SOfO88BrBy4UvVqd6Oj6r7hGQb0nBCl
 G7TVdOXrrDTrsVtibgzInH4IYVN7myIIjGIn1Azb4qlkyWs2s5seN8RWVtcVNwjVALRa
 WnWakzteQsdODnVicJ5uPCUXG2Htl3eFcSD+gBt//wKClhkOCRFtaX3Pdpj9eQAFs918
 VaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+yLMECfz4SQeh3+r6t6vIS8Tp4hfLiHYcv2v7xPbbH8=;
 b=L2i0AL8dsc3MqFk8fKeLhBmEe/ef+7sSthwr93rT5ilLnlFWX9yMmUayAFFywBsZd9
 xnPPc8swBTcsdCpjSD+Dx5VPo/dYJWDJG624ktdLXa7Wg7Ws5jc43YmsTKW9ukY7Jkuq
 Q5lUpqhd7WVqrkhwPf8kRz0OecvQ0luE69oHW1elSE71WXR4IC7jtVbqOStnXJs+gAp/
 Ix9UmFBa74uoswf4Im1Q6eQ1a1wLEMxASbGGaunyp9tENhU38Lt3pn9Oc8ggf7TZSxyf
 W8PzKbObL5Gz6tgtIm48+uWbbz/jL7poE9NnDQdTcHOtfsCiJNmlnZ4cfuKKEsK0gAO+
 OS7Q==
X-Gm-Message-State: AOAM533Io82eKpGX2RaJItwdJP+KuvFt/jS5cN9sCZi+KrAjPpUlG6fR
 wRG4iWVQ/3kKCMPu3r44DWuIhg==
X-Google-Smtp-Source: ABdhPJx+1sAzkV64JF8F64spUR6Uwp5TXog7Wm8TUi4ys94jGGva4WCiRiKmB8JtjjfXmRWCmxKYsA==
X-Received: by 2002:a1c:bac1:: with SMTP id k184mr2593413wmf.76.1605275387562; 
 Fri, 13 Nov 2020 05:49:47 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2020 05:49:46 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 04/40] drm/amd/amdgpu/amdgpu_drv: Move 'amdgpu_info_ioctl()'s
 prototype to shared header
Date: Fri, 13 Nov 2020 13:49:02 +0000
Message-Id: <20201113134938.4004947-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 13 Nov 2020 14:28:19 +0000
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
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jOjQ4Njo1OiB3YXJuaW5nOiBubyBwcmV2
aW91cyBwcm90b3R5cGUgZm9yIOKAmGFtZGdwdV9pbmZvX2lvY3Rs4oCZIFstV21pc3NpbmctcHJv
dG90eXBlc10KIDQ4NiB8IGludCBhbWRncHVfaW5mb19pb2N0bChzdHJ1Y3QgZHJtX2RldmljZSAq
ZGV2LCB2b2lkICpkYXRhLCBzdHJ1Y3QgZHJtX2ZpbGUgKmZpbHApCiB8IF5+fn5+fn5+fn5+fn5+
fn5+CgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNo
cmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJs
aWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+
CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8u
b3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyB8ICA0ICst
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyB8ICAxICsKIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuaCB8IDMxICsrKysrKysrKysrKysrKysr
KysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
a21zLmgKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKaW5kZXggMWRmZWEx
NWJiZWMzNi4uYWZkMzU3ZGYwZjg4NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2Rydi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kcnYuYwpAQCAtNDMsNyArNDMsNyBAQAogI2luY2x1ZGUgImFtZGdwdV9zY2hlZC5oIgogCiAj
aW5jbHVkZSAiYW1kZ3B1X2FtZGtmZC5oIgotCisjaW5jbHVkZSAiYW1kZ3B1X2ttcy5oIgogI2lu
Y2x1ZGUgImFtZGdwdV9yYXMuaCIKIAogLyoKQEAgLTE1MjEsOCArMTUyMSw2IEBAIGludCBhbWRn
cHVfZmlsZV90b19mcHJpdihzdHJ1Y3QgZmlsZSAqZmlscCwgc3RydWN0IGFtZGdwdV9mcHJpdiAq
KmZwcml2KQogCXJldHVybiAwOwogfQogCi1pbnQgYW1kZ3B1X2luZm9faW9jdGwoc3RydWN0IGRy
bV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwgc3RydWN0IGRybV9maWxlICpmaWxwKTsKLQogY29u
c3Qgc3RydWN0IGRybV9pb2N0bF9kZXNjIGFtZGdwdV9pb2N0bHNfa21zW10gPSB7CiAJRFJNX0lP
Q1RMX0RFRl9EUlYoQU1ER1BVX0dFTV9DUkVBVEUsIGFtZGdwdV9nZW1fY3JlYXRlX2lvY3RsLCBE
Uk1fQVVUSHxEUk1fUkVOREVSX0FMTE9XKSwKIAlEUk1fSU9DVExfREVGX0RSVihBTURHUFVfQ1RY
LCBhbWRncHVfY3R4X2lvY3RsLCBEUk1fQVVUSHxEUk1fUkVOREVSX0FMTE9XKSwKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYwppbmRleCA5ODcyMWFlOTMxODQxLi41NGM0ZWU2
ZDIzMGQ4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21z
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jCkBAIC00MSw2
ICs0MSw3IEBACiAjaW5jbHVkZSAiYW1kZ3B1X2FtZGtmZC5oIgogI2luY2x1ZGUgImFtZGdwdV9n
ZW0uaCIKICNpbmNsdWRlICJhbWRncHVfZGlzcGxheS5oIgorI2luY2x1ZGUgImFtZGdwdV9rbXMu
aCIKICNpbmNsdWRlICJhbWRncHVfcmFzLmgiCiAKIHZvaWQgYW1kZ3B1X3VucmVnaXN0ZXJfZ3B1
X2luc3RhbmNlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2ttcy5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAw
MDAuLmYzMTExYWVmNzZjYWUKLS0tIC9kZXYvbnVsbAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfa21zLmgKQEAgLTAsMCArMSwzMSBAQAorLyogYW1kZ3B1X2ttcy5oIC0t
IFByaXZhdGUgaGVhZGVyIGZvciByYWRlb24gZHJpdmVyIC0qLSBsaW51eC1jIC0qLQorICoKKyAq
IENvcHlyaWdodCAyMDA4IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4KKyAqIENvcHlyaWdo
dCAyMDA4IFJlZCBIYXQgSW5jLgorICogQ29weXJpZ2h0IDIwMDkgSmVyb21lIEdsaXNzZS4KKyAq
CisgKiBQZXJtaXNzaW9uIGlzIGhlcmVieSBncmFudGVkLCBmcmVlIG9mIGNoYXJnZSwgdG8gYW55
IHBlcnNvbiBvYnRhaW5pbmcgYQorICogY29weSBvZiB0aGlzIHNvZnR3YXJlIGFuZCBhc3NvY2lh
dGVkIGRvY3VtZW50YXRpb24gZmlsZXMgKHRoZSAiU29mdHdhcmUiKSwKKyAqIHRvIGRlYWwgaW4g
dGhlIFNvZnR3YXJlIHdpdGhvdXQgcmVzdHJpY3Rpb24sIGluY2x1ZGluZyB3aXRob3V0IGxpbWl0
YXRpb24KKyAqIHRoZSByaWdodHMgdG8gdXNlLCBjb3B5LCBtb2RpZnksIG1lcmdlLCBwdWJsaXNo
LCBkaXN0cmlidXRlLCBzdWJsaWNlbnNlLAorICogYW5kL29yIHNlbGwgY29waWVzIG9mIHRoZSBT
b2Z0d2FyZSwgYW5kIHRvIHBlcm1pdCBwZXJzb25zIHRvIHdob20gdGhlCisgKiBTb2Z0d2FyZSBp
cyBmdXJuaXNoZWQgdG8gZG8gc28sIHN1YmplY3QgdG8gdGhlIGZvbGxvd2luZyBjb25kaXRpb25z
OgorICoKKyAqIFRoZSBhYm92ZSBjb3B5cmlnaHQgbm90aWNlIGFuZCB0aGlzIHBlcm1pc3Npb24g
bm90aWNlIHNoYWxsIGJlIGluY2x1ZGVkIGluCisgKiBhbGwgY29waWVzIG9yIHN1YnN0YW50aWFs
IHBvcnRpb25zIG9mIHRoZSBTb2Z0d2FyZS4KKyAqCisgKiBUSEUgU09GVFdBUkUgSVMgUFJPVklE
RUQgIkFTIElTIiwgV0lUSE9VVCBXQVJSQU5UWSBPRiBBTlkgS0lORCwgRVhQUkVTUyBPUgorICog
SU1QTElFRCwgSU5DTFVESU5HIEJVVCBOT1QgTElNSVRFRCBUTyBUSEUgV0FSUkFOVElFUyBPRiBN
RVJDSEFOVEFCSUxJVFksCisgKiBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRSBBTkQg
Tk9OSU5GUklOR0VNRU5ULiAgSU4gTk8gRVZFTlQgU0hBTEwKKyAqIFRIRSBDT1BZUklHSFQgSE9M
REVSKFMpIE9SIEFVVEhPUihTKSBCRSBMSUFCTEUgRk9SIEFOWSBDTEFJTSwgREFNQUdFUyBPUgor
ICogT1RIRVIgTElBQklMSVRZLCBXSEVUSEVSIElOIEFOIEFDVElPTiBPRiBDT05UUkFDVCwgVE9S
VCBPUiBPVEhFUldJU0UsCisgKiBBUklTSU5HIEZST00sIE9VVCBPRiBPUiBJTiBDT05ORUNUSU9O
IFdJVEggVEhFIFNPRlRXQVJFIE9SIFRIRSBVU0UgT1IKKyAqIE9USEVSIERFQUxJTkdTIElOIFRI
RSBTT0ZUV0FSRS4KKyAqLworCisjaWZuZGVmIF9fQU1ER1BVX0tNU19IX18KKyNkZWZpbmUgX19B
TURHUFVfS01TX0hfXworCitpbnQgYW1kZ3B1X2luZm9faW9jdGwoc3RydWN0IGRybV9kZXZpY2Ug
KmRldiwgdm9pZCAqZGF0YSwgc3RydWN0IGRybV9maWxlICpmaWxwKTsKKworI2VuZGlmICAgICAg
ICAgICAgICAgICAgICAgICAgIC8qIF9fQU1ER1BVX0tNU19IX18gKi8KLS0gCjIuMjUuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
