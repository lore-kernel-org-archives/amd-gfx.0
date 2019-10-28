Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3F9CA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C12D6217D6
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12D6217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D3706E02B;
	Mon, 28 Oct 2019 21:42:51 +0000 (UTC)
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com
 [IPv6:2607:f8b0:4864:20::b42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 790F06E02B
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 21:42:50 +0000 (UTC)
Received: by mail-yb1-xb42.google.com with SMTP id d12so4628304ybn.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 14:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=43S0AHLbjp3r3KHR5D4q2J9CsjfnDW7/f1tdadtRYLE=;
 b=N28ULeS+kD9eKgNTprnXIxx7CHAaoyXsjXesVe3GjOu76yTZHNT6nrCE+o7V9Q5oVX
 Oc35ECvF3r0o2uO2lUPixI+2Niamvx08u7PRpHKRjP6JeIEX3dTUrwdRfTdxSN/RTRY/
 4IpwfbRniHCUuZ43DWpVk+dWTaFPyVD0QTSobrwmEAX1ic4th46hfAzPKAgJicbIdsTp
 h3ZtkVd66aqmCQtMFdG4oZc1yKX5iiR7D/BlRqDJRpq0BdrrGQGVTliMDkIWU04/xzqY
 ATCosxKA0SbYT1D3mUc3ZD9pxujCcXupKGjLsUg0kDQCN/guX83UKqjJtt7aFYlrii3t
 N74w==
X-Gm-Message-State: APjAAAV+hkFXJQc3MTIx/Q0UJry0/Gutpkb8+5QFhhUX2FAtGPzvlcc6
 Obvr0njJEucA/U2CZq8jiQh5p63A2UU=
X-Google-Smtp-Source: APXvYqxHBSnLwQCJnhfCjHrYCxmQIPN5+UmUDZrDVrb3PF1grU9vWOfib/cAvVVarFk3KhOiZwrmKg==
X-Received: by 2002:a25:1382:: with SMTP id 124mr14847431ybt.1.1572298968762; 
 Mon, 28 Oct 2019 14:42:48 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l68sm3421090ywf.95.2019.10.28.14.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 14:42:48 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 00/21] Enable BACO for power savings (v2)
Date: Mon, 28 Oct 2019 17:41:55 -0400
Message-Id: <20191028214216.1508370-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=43S0AHLbjp3r3KHR5D4q2J9CsjfnDW7/f1tdadtRYLE=;
 b=YWjlhZcOsYMd0+g7TQ47JILtsga707wM2EHuuGr4C9cn9jZy0L7yb2wOdQtsK8UV9d
 U0xZUb+Sm7gdrXaF0EtXJGi5jLGOw8Zna1tX4qWu8+RLpIjhIGr6UMbjpY4Vc4WI4F/w
 IT0r+GirV1Efx9yJWWcThrnFT0kJXcSAVIl0J3IlkhqeDxpl+1cdg9fLt5SLtT4Pxss3
 rn1S38mpizSYH1+orVrOqoAscc5aZ70NSgFEN/yTWiMDHfRfwS/Ze94FKtWDIw18Revs
 eLHsf5gG8RJtK2C0o63mSh1Mt4cxoFXpJ9alq+xSYOHtCU5zHbZjC0KqcfC/K16kvplR
 nYGg==
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028214155.nSjYepsEhCtMhc3Om6x2jKdz4RCb_cnYoJUPcc6xJgI@z>

VGhpcyBwYXRjaCBzZXQgZW5hYmxlcyBCQUNPIChCdXMgQWN0aXZlIENoaXAgT2ZmKSBmb3IKcG93
ZXIgc2F2aW5ncyBvbiBWSSsgYXNpY3MuICBTaW1pbGFyIHRvIFBvd2VyWHByZXNzCmFuZCBIeWJy
aWQgR3JhcGhpY3MgKFBYL0hHKSBsYXB0b3BzLCB3ZSBjYW4gZGlzYWJsZSBHUFVzCmF0IHJ1bnRp
bWUgd2hlbiB0aGV5IGFyZSBub3QgaW4gdXNlIGlzIHRoZXkgc3VwcG9ydApCQUNPLiAgVGhlIHJ1
bnRpbWUgcG0gY29kZSBpbiBhbWRncHUgd2FzIG9yaWdpbmFsbHkKZGV2ZWxvcGVkIGZvciBQWC9I
RyBsYXB0b3BzLCBzbyBpdCB3YXMgcHJldHR5IGVudGFuZ2xlZAp3aXRoIHRoZSB2Z2Ffc3dpdGNo
ZXJvbyBhbmQgQUNQSSBjb2RlLiAgU2luY2UgdGhlIEdQVQpjb250YWlucyBhbiBhdWRpbyBjb2Rl
YyBmb3IgSERNSS9EUCwgdGhlcmUgaXMgc29tZQppbnRlcmFjdGlvbiB3aXRoIHRoZSBoZGEgZHJp
dmVyLiAgSSBhbSBieSBubyBtZWFucyBhbgpleHBlcnQgb24gYWxzYSwgc28gYW55IGFkdmljZSBv
biB0aG9zZSBwYXRjaGVzIGlzIG11Y2gKYXBwcmVjaWF0ZWQuICBJIGhhZCB0byBlbmFibGUgcnVu
dGltZSBwbSBvbiB0aGUgaGRhCmRldmljZSB0byBhbGxvdyB0aGUgR1BVIHRvIGVudGVyIHJ1bnRp
bWUgcG0gYmVjYXVzZQp0aGV5IGFyZSBsaW5rZWQuCgpUaGVzZSBwYXRjaGVzIGRlcGVuZCBvbiB0
aGUgY2xlYW4gcGF0Y2hlcyBhbmQgQ0kvVkkKQkFDTyBwYXRjaGVzIEkgc2VudCBvdXQgZWFybGll
ciB0b2RheS4KClRoZSBmdWxsIHRyZWUgY2FuIGJlIGZvdW5kIGhlcmU6Cmh0dHBzOi8vY2dpdC5m
cmVlZGVza3RvcC5vcmcvfmFnZDVmL2xpbnV4L2xvZy8/aD1iYWNvCgpUT0RPOgotIFR1cm4gb2Zm
IHJ1bnRpbWUgcG0gd2hlbiBLRkQgaXMgYWN0aXZlCi0gTWFrZSBzdXJlIGF1ZGlvIHN0aWxsIHdv
cmtzCi0gTWFrZSBzdXJlIFBYL0hHIHN0aWxsIHdvcmtzCgp2MjoKLSBTcGxpdCB3aGl0ZXNwYWNl
IGNoYW5nZXMgZnJvbSBiYWNvIGNhbGxiYWNrIGFkZGl0aW9uCi0gRml4IHBjaSByZWYgY291bnRp
bmcgaW4gcHgvaGcgaGFuZGxpbmcgaW4gaGRhIGRyaXZlcgotIEhhbmRsZSBDT05GSUdfQUNQSSBw
cm9wZXJseQotIFNwbGl0IGFkZGluZyBuZXcgaGRhIHBjaSBpZHMgZnJvbSBhZGRpbmcgcnVucG0g
ZmxhZwoKQWxleCBEZXVjaGVyICgyMSk6CiAgZHJtL2FtZGdwdTogYWRkIGFzaWMgY2FsbGJhY2sg
Zm9yIEJBQ08gc3VwcG9ydAogIGRybS9hbWRncHUvc29jMTU6IG1vdmUgc3RydWN0IGRlZmluaXRp
b24gYXJvdW5kIHRvIGFsaWduIHdpdGggb3RoZXIKICAgIHNvYzE1IGFzaWNzCiAgZHJtL2FtZGdw
dTogYWRkIHN1cHBvcnRzX2JhY28gY2FsbGJhY2sgZm9yIHNvYzE1IGFzaWNzLiAodjIpCiAgZHJt
L2FtZGdwdTogYWRkIHN1cHBvcnRzX2JhY28gY2FsbGJhY2sgZm9yIFNJIGFzaWNzLgogIGRybS9h
bWRncHU6IGFkZCBzdXBwb3J0c19iYWNvIGNhbGxiYWNrIGZvciBDSUsgYXNpY3MuCiAgZHJtL2Ft
ZGdwdTogYWRkIHN1cHBvcnRzX2JhY28gY2FsbGJhY2sgZm9yIFZJIGFzaWNzLgogIGRybS9hbWRn
cHU6IGFkZCBzdXBwb3J0c19iYWNvIGNhbGxiYWNrIGZvciBOViBhc2ljcy4KICBkcm0vYW1kZ3B1
OiBhZGQgYSBhbWRncHVfZGV2aWNlX3N1cHBvcnRzX2JhY28gaGVscGVyCiAgZHJtL2FtZGdwdTog
cmVuYW1lIGFtZGdwdV9kZXZpY2VfaXNfcHggdG8gYW1kZ3B1X2RldmljZV9zdXBwb3J0c19ib2Nv
CiAgICAodjIpCiAgZHJtL2FtZGdwdTogYWRkIGFkZGl0aW9uYWwgYm9jbyBjaGVja3MgdG8gcnVu
dGltZSBzdXNwZW5kL3Jlc3VtZSAodjIpCiAgZHJtL2FtZGdwdTogc3BsaXQgc3dTTVUgYmFjb19y
ZXNldCBpbnRvIGVudGVyIGFuZCBleGl0CiAgZHJtL2FtZGdwdTogYWRkIGhlbHBlcnMgZm9yIGJh
Y28gZW50cnkgYW5kIGV4aXQKICBkcm0vYW1kZ3B1OiBhZGQgYmFjbyBzdXBwb3J0IHRvIHJ1bnRp
bWUgc3VzcGVuZC9yZXN1bWUKICBkcm0vYW1kZ3B1OiBzdGFydCB0byBkaXNlbnRhbmdsZSBib2Nv
IGZyb20gcnVudGltZSBwbQogIGRybS9hbWRncHU6IGRpc2VudGFuZ2xlIHJ1bnRpbWUgcG0gYW5k
IHZnYV9zd2l0Y2hlcm9vCiAgZHJtL2FtZGdwdTogZW5hYmxlIHJ1bnRpbWUgcG0gb24gQkFDTyBj
YXBhYmxlIGJvYXJkcyBpZiBydW5wbT0xCiAgZHJtL2FtZGdwdS9ydW5wbTogZW5hYmxlIHJ1bnBt
IG9uIGJhY28gY2FwYWJsZSBWSSsgYXNpY3MKICBBTFNBOiBoZGEvaGRtaSAtIGZpeCB2Z2Fzd2l0
Y2hlcm9vIGRldGVjdGlvbiBmb3IgQU1ECiAgQUxTQTogaGRhL2hkbWkgLSBBZGQgbmV3IHBjaSBp
ZHMgZm9yIEFNRCBHUFUgZGlzcGxheSBhdWRpbwogIEFMU0E6IGhkYS9oZG1pIC0gZW5hYmxlIHJ1
bnRpbWUgcG0gZm9yIG5ld2VyIEFNRCBkaXNwbGF5IGF1ZGlvCiAgQUxTQTogaGRhL2hkbWkgLSBl
bmFibGUgYXV0b21hdGljIHJ1bnRpbWUgcG0gZm9yIEFNRCBIRE1JIGNvZGVjcyBieQogICAgZGVm
YXVsdAoKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oICAgICAgICAgICB8ICAx
MiArLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jICAgIHwgMTA2
ICsrKysrKysrKysrKysrKystLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ry
di5jICAgICAgIHwgIDYzICsrKysrKy0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfa21zLmMgICAgICAgfCAgMjAgKysrLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Y2lrLmMgICAgICAgICAgICAgIHwgIDE4ICsrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
bnYuYyAgICAgICAgICAgICAgIHwgIDE4ICsrLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
c2kuYyAgICAgICAgICAgICAgIHwgICA2ICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Nv
YzE1LmMgICAgICAgICAgICB8ICAzNiArKysrKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3ZpLmMgICAgICAgICAgICAgICB8ICAyMiArKysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9hbWRncHVfc211LmMgICAgfCAgMjAgKysrLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvYXJjdHVydXNfcHB0LmMgIHwgICAzICstCiAuLi4vZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L2luYy9hbWRncHVfc211LmggICAgfCAgIDYgKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L2luYy9zbXVfdjExXzAuaCB8ICAgMyArLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBs
YXkvbmF2aTEwX3BwdC5jICAgIHwgICAzICstCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxh
eS9zbXVfdjExXzAuYyAgICAgfCAgIDkgKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L3ZlZ2EyMF9wcHQuYyAgICB8ICAgMyArLQogc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYyAgICAg
ICAgICAgICAgICAgICAgIHwgIDg0ICsrKysrKysrKysrKystCiBzb3VuZC9wY2kvaGRhL3BhdGNo
X2hkbWkuYyAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwogMTggZmlsZXMgY2hhbmdlZCwgMzcx
IGluc2VydGlvbnMoKyksIDYyIGRlbGV0aW9ucygtKQoKLS0gCjIuMjMuMAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
