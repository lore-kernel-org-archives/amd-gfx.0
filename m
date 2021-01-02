Return-Path: <SRS0=sK2M=GF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85174C433DB
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Jan 2021 14:19:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A5022482
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Jan 2021 14:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A5022482
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABC8989739;
	Sat,  2 Jan 2021 14:19:54 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C574989739;
 Sat,  2 Jan 2021 14:19:53 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id q75so13674559wme.2;
 Sat, 02 Jan 2021 06:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EO/wWSEfiojNBhjbsuAnQ1uZN5JIWue6TqHVURU3Q2c=;
 b=ha7F76nygzZqzDrjrzOYhVuhPTAaBOTrwJs+Idcd/pTimNcER3wEa1PkIG0NLqFXjX
 5WoQ6jl7TM3clv04gWiGmIMfuPYmndudxTEF0DIYClja0KIKaLn3ngJwX3Uv4tXIs/26
 /vMGgO1F8RGd1NLNUiu4ifyt3wqCDpYc8wQ1mKT7ZIpe+Q3IG8ucwY6TMZLoZ9KB5Cwj
 0f6xXOekVx8zUlL+H0/jdj27vWyo5nqy/gaysdmnFOL2rIAF0ZzUPufbYiDAm12d7HAY
 oGkTGeCoDC/pQOR+eTCIwQoYVcml3xY1wcv3lFy0uwsbDE9fEgnvjzg1wwbwCJ9jDqpa
 mrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EO/wWSEfiojNBhjbsuAnQ1uZN5JIWue6TqHVURU3Q2c=;
 b=UnWt2OuYpyNeZp1QedZQKOhInvZhmjGUIU2+22eORnea08FzjYYCWJTO84wurXnCRk
 cm5529ugRIZKgeEODfbDAXnvHS8VopDplE2TsS1XWHd60AFFHOQAuFuYyYMz/kaYEWHs
 Tf4y9emv7GLU9wMsYnbly1Zz6u0rB7sT5gyJOT8KzBgW4s6KX9z1QmdsA4ylu8oMNuvq
 xGAjVyH0DUvT8g+pVP2sdTX3GLDBRAte4wqZeTa3BxxMel/teYcmqYhAMWcDE+f2yrQo
 Qmb9erhqNhOkasu3fGkKrTnE298kr7N3X64NCcteptAJxP8lbwkF7iWj+Ylr2dtANdyw
 7New==
X-Gm-Message-State: AOAM531FT8ra0AHhMsOFasL1GlCgdTIm5hiejDKq8ZC8IZsDE8Kn1uvQ
 XkET8skudHpfYtre92RwB/bnZ8E9Plc=
X-Google-Smtp-Source: ABdhPJzF4BKsvIY28nGnd08cOyMm1GYd/KGdE+WhSm0C6cZxbD24Nu+S0AYyQ2qGcB9UPnds+I38LA==
X-Received: by 2002:a7b:ce17:: with SMTP id m23mr19624541wmc.117.1609597192283; 
 Sat, 02 Jan 2021 06:19:52 -0800 (PST)
Received: from twisty.localdomain
 (dynamic-2a01-0c23-78d0-4200-6cbb-50d4-b91e-5b37.c23.pool.telefonica.de.
 [2a01:c23:78d0:4200:6cbb:50d4:b91e:5b37])
 by smtp.gmail.com with ESMTPSA id y130sm23983683wmc.22.2021.01.02.06.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Jan 2021 06:19:51 -0800 (PST)
From: Mario Kleiner <mario.kleiner.de@gmail.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm: Allow format change during legacy page-flip if driver is
 atomic.
Date: Sat,  2 Jan 2021 15:19:42 +0100
Message-Id: <20210102141942.29109-1-mario.kleiner.de@gmail.com>
X-Mailer: git-send-email 2.24.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@redhat.com>,
 mario.kleiner.de@gmail.com,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBpcyBhIHNsaWdodCBpbXByb3ZlbWVudCBmb3IgbGVnYWN5IGZsaXBwaW5nLCBidXQgYWxz
byBhbiBhdHRlbXB0ZWQKZml4IGZvciBhIGJ1Zy9yZWdyZXNzaW9uIGludHJvZHVjZWQgaW50byBM
aW51eCA0LjExLXJjLgoKQ29tbWl0IDgxNjg1M2Y5ZGM0MDU3YjZjN2VlM2M0NWNhOWJkNTkwNSAo
ImRybS9hbWQvZGlzcGxheTogU2V0IG5ldwpmb3JtYXQgaW5mbyBmb3IgY29udmVydGVkIG1ldGFk
YXRhLiIpIGZpeGVzIHRoZSBnZXRmYjIgaW9jdGwsIGJ1dAppbiBleGNoYW5nZSBpdCBjb21wbGV0
ZWx5IGJyZWFrcyBhbGwgcGFnZWZsaXBwaW5nIGZvciBjbGFzc2ljIHVzZXIKc3BhY2UsIGUuZy4s
IFhPcmcsIGFzIHRlc3RlZCB3aXRoIGJvdGggYW1kZ3B1LWRkeCBhbmQgbW9kZXNldHRpbmctZGR4
LgpUaGlzIGxlYWRzIHRvIG1hc3NpdmUgdGVhcmluZywgYnJva2VuIHZpc3VhbCB0aW1pbmcvdGlt
ZXN0YW1waW5nLCBhbmQKYSB4b3JnIGxvZyBmbG9vZGVkIHdpdGggZXJyb3IgbWVzc2FnZXMsIGFz
IHRlc3RlZCBvbiBVYnVudHUgMjAuMDQuMS1MVFMKd2l0aCBYLVNlcnZlciAxLjIwLjgsIE1lc2Eg
MjAuMC44LCBhbWRncHUtZGR4IDE5LjEuMCBhbmQgYWxzbyB3aXRoIHRoZQptb2Rlc2V0dGluZy1k
ZHggd2l0aC93aXRob3V0IGF0b21pYyBvbiBhIEFNRCBSYXZlbiBSaWRnZSBncHUuIENoYW5nZXMK
dG8gZnV0dXJlIE1lc2EgVnVsa2FuIGRyaXZlcnMgYmV5b25kIDIwLjAuOCBtYXkgYnJlYWsgKG9y
IGFscmVhZHkgaGF2ZQpicm9rZW4/KSBwYWdlIGZsaXBwaW5nIG9uIHRob3NlIGFzIHdlbGwuCgpU
aGUgcmVhc29uIGlzIHRoYXQgdGhlIGNsYXNzaWMgcGFnZWZsaXAgaW9jdGwgZG9lc24ndCBhbGxv
dyBhIGZiIGZvcm1hdApjaGFuZ2UgZHVyaW5nIGZsaXAsIGFuZCBhdCBsZWFzdCBYIHVzZXMgY2xh
c3NpYyBwYWdlZmxpcCBpb2N0bCBhbmQgbm8KYXRvbWljIG1vZGVzZXR0aW5nIGFwaSBmb3IgZmxp
cHBpbmcsIGFzIGRvIGFsbCBpbnNwZWN0ZWQgVnVsa2FuCmRyaXZlcnMsIGUuZy4sIGFudiwgcmFk
diwgYW1kdmxrLiBBYm92ZSBjb21taXQgYXNzaWducyBuZXcgZmItPmZvcm1hdApmb3IgdXNlIG9m
IChyZXRpbGluZykgRENDIG9uIEFNRCBncHUncyBmb3Igc29tZSB0aWxpbmcgZmxhZ3MsIHdoaWNo
CmlzIGRldGVjdGVkIChhbmQgcmVqZWN0ZWQpIGJ5IHRoZSBwYWdlZmxpcCBpb2N0bCBhcyBhIGZv
cm1hdCBjaGFuZ2UuCgpIb3dldmVyLCBjdXJyZW50IGF0b21pYyBrbXMgZHJpdmVycyBob29rIHVw
IHRoZSAtPnBhZ2VfZmxpcCgpIGRyaXZlcgpmdW5jdGlvbiB0byB0aGUgYXRvbWljIGhlbHBlciBm
dW5jdGlvbiBkcm1fYXRvbWljX2hlbHBlcl9wYWdlX2ZsaXAoKSwKd2hpY2ggaW1wbGVtZW50cyB0
aGUgbGVnYWN5IGZsaXAgYXMgYW4gYXRvbWljIGNvbW1pdC4gTXkgdW5kZXJzdGFuZGluZwppcyB0
aGF0IGEgZm9ybWF0IGNoYW5nZSBkdXJpbmcgZmxpcCB2aWEgc3VjaCBhbiBhdG9taWMgY29tbWl0
IGlzIHNhZmUuCgpUaGVyZWZvcmUgb25seSByZWplY3QgdGhlIGxlZ2FjeSBwYWdlZmxpcCBpb2N0
bCBpZiBhIGZiIGZvcm1hdCBjaGFuZ2UKaXMgcmVxdWVzdGVkIG9uIGEga21zIGRyaXZlciB3aGlj
aCBpc24ndCBEUklWRVJfQVRPTUlDLgoKVGhpcyBtYWtlcyAibGVnYWN5IiBmbGlwcGluZyB3b3Jr
IGFnYWluIG9uIExpbnV4IDQuMTEgd2l0aCBhbWRncHUta21zCmFuZCBEaXNwbGF5Q29yZSBlbmFi
bGVkLgoKRml4ZXM6IDgxNjg1M2Y5ZGM0MCAoImRybS9hbWQvZGlzcGxheTogU2V0IG5ldyBmb3Jt
YXQgaW5mbyBmb3IgY29udmVydGVkIG1ldGFkYXRhLiIpCkNjOiBCYXMgTmlldXdlbmh1aXplbiA8
YmFzQGJhc25pZXV3ZW5odWl6ZW4ubmw+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAcmVkaGF0LmNvbT4KQ2M6IFZp
bGxlIFN5cmrDpGzDpCA8dmlsbGUuc3lyamFsYUBsaW51eC5pbnRlbC5jb20+ClNpZ25lZC1vZmYt
Ynk6IE1hcmlvIEtsZWluZXIgPG1hcmlvLmtsZWluZXIuZGVAZ21haWwuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9kcm1fcGxhbmUuYyB8IDYgKysrKystCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ry
bV9wbGFuZS5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV9wbGFuZS5jCmluZGV4IGU2MjMxOTQ3Zjk4
Ny4uNDY4ODM2MGEwNzhkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX3BsYW5lLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV9wbGFuZS5jCkBAIC0xMTYzLDcgKzExNjMsMTEgQEAg
aW50IGRybV9tb2RlX3BhZ2VfZmxpcF9pb2N0bChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LAogCWlm
IChyZXQpCiAJCWdvdG8gb3V0OwogCi0JaWYgKG9sZF9mYi0+Zm9ybWF0ICE9IGZiLT5mb3JtYXQp
IHsKKwkvKgorCSAqIEZvcm1hdCBjaGFuZ2UgZHVyaW5nIGxlZ2FjeSBwYWdlZmxpcCBvbmx5IHdv
cmtzIGlmIHBhZ2UgZmxpcCBpcyBkb25lCisJICogdmlhIGFuIGF0b21pYyBjb21taXQsIGUuZy4s
IHZpYSBkcm1fYXRvbWljX2hlbHBlcl9wYWdlX2ZsaXAoKSBoZWxwZXIuCisJICovCisJaWYgKChv
bGRfZmItPmZvcm1hdCAhPSBmYi0+Zm9ybWF0KSAmJiAhZHJtX2Rydl91c2VzX2F0b21pY19tb2Rl
c2V0KGRldikpIHsKIAkJRFJNX0RFQlVHX0tNUygiUGFnZSBmbGlwIGlzIG5vdCBhbGxvd2VkIHRv
IGNoYW5nZSBmcmFtZSBidWZmZXIgZm9ybWF0LlxuIik7CiAJCXJldCA9IC1FSU5WQUw7CiAJCWdv
dG8gb3V0OwotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
