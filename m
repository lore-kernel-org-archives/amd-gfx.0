Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A6AC2D0E4
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A929B20674
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jTnOPgnf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A929B20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF4226EBFD;
	Fri, 27 Nov 2020 10:14:49 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A0536E95A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 13:43:05 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id a3so2446573wmb.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 05:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rnrdHuM/rWXAPsRk8sa0DBTjM6BaG4gFKqaiWF+hjeo=;
 b=jTnOPgnfrpvpHF84PHFE7DnpVaSfxOChEK41IUniXvhcZ/Bb0XWmeAg5q91br7B7BB
 o/mPFf5RNvzDZPdgbCeCfjHkRicpqsHLnv+y5bffqrxZZUdyvGsBtuXCDUP/GEaPUXJu
 NB0dpr8kGWnxtqqWkkLLkCmlMYI+vvkICtDD0gttaL+ml1SalHU5RUNy94tqoBXGVVd5
 RZW+HpeXDAMcMX/2sJMADVt9kHDCsHDT1MRw5caLvQh8xyH6v4PoaM+N8MIBp1YZrVai
 MX/2DnCdkosdZBehROI0YzjK4zwU+GvTCjGRQUboCieyD8LBk/gg7kIGx4v0thQC11sJ
 +yIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rnrdHuM/rWXAPsRk8sa0DBTjM6BaG4gFKqaiWF+hjeo=;
 b=V1nT5LRapgra31ENmaQI1TI32EDPGu6I2beaGx8mkdm/GRfmyIH0rbgt/ABLHFXBPs
 7SKjRTnpoL7Vuyhx/rp+AEXUfpQEqE5g/TLOBlTcFbY/84AEYaPpDn/GJr+FMAPnJF+b
 0nQJv6roFP9pxs/tR9IftJi2CgE6SDrCNzFrxEzy4NlkbwJGV6Q4Zx+qgkO26FVLwDjw
 9x2WmLMEZloBDkui0zlc/IyV2YuVNTShpSOIHlYg94JhDsNqEaU2BnrAUr3x+PG7YlYx
 JPHAN6KNADwSd5gkDSB2Zng+yNSeHHWSCV6m8oIcgwnKeo+hwxDHt/pPNxiJQMridM+G
 uqrg==
X-Gm-Message-State: AOAM531hsy1j9JkSh9Q5YZ+wUTs8bFzgDUYL/BdohKkcavKLudCMjvHm
 8zPDt/Dgd3vO1UJuMItGtUYaXg==
X-Google-Smtp-Source: ABdhPJwvSU7aMP2JcJfhyESLr1X97Bf+6EtAKwtTOON35bElepnHYh3nEPpIDcbJPpNwnHssyTnMLA==
X-Received: by 2002:a1c:2001:: with SMTP id g1mr3487005wmg.179.1606398183970; 
 Thu, 26 Nov 2020 05:43:03 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 05:43:03 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 12/40] drm/amd/pm/powerplay/hwmgr/ppatomctrl: Remove unused
 variable 'fPowerDPMx'
Date: Thu, 26 Nov 2020 13:42:12 +0000
Message-Id: <20201126134240.3214176-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 27 Nov 2020 10:14:32 +0000
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
 Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogSW4gZmls
ZSBpbmNsdWRlZCBmcm9tIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3BtL3Bvd2VycGxh
eS9od21nci9wcGF0b21jdHJsLmM6MzE6CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9w
bS9wb3dlcnBsYXkvaHdtZ3IvcHBhdG9tY3RybC5jOiBJbiBmdW5jdGlvbiDigJhhdG9tY3RybF9j
YWxjdWxhdGVfdm9sdGFnZV9ldnZfb25fc2Nsa+KAmToKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1Ly4uL3BtL3Bvd2VycGxheS9od21nci9wcGF0b21jdHJsLmM6NzAyOjIyOiB3YXJuaW5nOiB2
YXJpYWJsZSDigJhmUG93ZXJEUE144oCZIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1z
ZXQtdmFyaWFibGVdCgpDYzogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KQ2M6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmln
IiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxp
bnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
U2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9wcGF0b21jdHJsLmMgfCAxMCArLS0t
LS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDkgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvcHBhdG9t
Y3RybC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvcHBhdG9tY3Ry
bC5jCmluZGV4IGMyZmVlNjc5NmJkOTMuLjJjYjkxM2FiNzdmMjYgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3BwYXRvbWN0cmwuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9wcGF0b21jdHJsLmMKQEAgLTY5OSw3
ICs2OTksNyBAQCBpbnQgYXRvbWN0cmxfY2FsY3VsYXRlX3ZvbHRhZ2VfZXZ2X29uX3NjbGsoCiAJ
ZkludCBmTWFyZ2luX1JPX2EsIGZNYXJnaW5fUk9fYiwgZk1hcmdpbl9ST19jLCBmTWFyZ2luX2Zp
eGVkLCBmTWFyZ2luX0ZNQVhfbWVhbiwgZk1hcmdpbl9QbGF0X21lYW4sIGZNYXJnaW5fRk1BWF9z
aWdtYSwgZk1hcmdpbl9QbGF0X3NpZ21hLCBmTWFyZ2luX0RDX3NpZ21hOwogCWZJbnQgZkxrZ19G
VCwgcmVwZWF0OwogCWZJbnQgZk1pY3JvX0ZNQVgsIGZNaWNyb19DUiwgZlNpZ21hX0ZNQVgsIGZT
aWdtYV9DUiwgZlNpZ21hX0RDLCBmRENfU0NMSywgZlNxdWFyZWRfU2lnbWFfREMsIGZTcXVhcmVk
X1NpZ21hX0NSLCBmU3F1YXJlZF9TaWdtYV9GTUFYOwotCWZJbnQgZlJMTF9Mb2FkTGluZSwgZlBv
d2VyRFBNeCwgZkRlcmF0ZVREUCwgZlZERENfYmFzZSwgZkFfVGVybSwgZkNfVGVybSwgZkJfVGVy
bSwgZlJPX0RDX21hcmdpbjsKKwlmSW50IGZSTExfTG9hZExpbmUsIGZEZXJhdGVURFAsIGZWRERD
X2Jhc2UsIGZBX1Rlcm0sIGZDX1Rlcm0sIGZCX1Rlcm0sIGZST19EQ19tYXJnaW47CiAJZkludCBm
Uk9fZnVzZWQsIGZDQUNtX2Z1c2VkLCBmQ0FDYl9mdXNlZCwgZkt2X21fZnVzZWQsIGZLdl9iX2Z1
c2VkLCBmS3RfQmV0YV9mdXNlZCwgZkZUX0xrZ19WME5PUk07CiAJZkludCBmU2Nsa19tYXJnaW4s
IGZTY2xrLCBmRVZWX1Y7CiAJZkludCBmVl9taW4sIGZWX21heCwgZlRfcHJvZCwgZkxLR19GYWN0
b3IsIGZUX0ZULCBmVl9GVCwgZlZfeCwgZlREUF9Qb3dlciwgZlREUF9Qb3dlcl9yaWdodCwgZlRE
UF9Qb3dlcl9sZWZ0LCBmVERQX0N1cnJlbnQsIGZWX05MOwpAQCAtNzMxLDM2ICs3MzEsMjggQEAg
aW50IGF0b21jdHJsX2NhbGN1bGF0ZV92b2x0YWdlX2V2dl9vbl9zY2xrKAogCiAJc3dpdGNoIChk
cG1fbGV2ZWwpIHsKIAljYXNlIDE6Ci0JCWZQb3dlckRQTXggPSBDb252ZXJ0X1VMT05HX1RvRnJh
Y3Rpb24obGUxNl90b19jcHUoZ2V0QVNJQ1Byb2ZpbGluZ0luZm8tPnVzUG93ZXJEcG0xKSk7CiAJ
CWZEZXJhdGVURFAgPSBHZXRTY2FsZWRGcmFjdGlvbihsZTMyX3RvX2NwdShnZXRBU0lDUHJvZmls
aW5nSW5mby0+dWxUZHBEZXJhdGVEUE0xKSwgMTAwMCk7CiAJCWJyZWFrOwogCWNhc2UgMjoKLQkJ
ZlBvd2VyRFBNeCA9IENvbnZlcnRfVUxPTkdfVG9GcmFjdGlvbihsZTE2X3RvX2NwdShnZXRBU0lD
UHJvZmlsaW5nSW5mby0+dXNQb3dlckRwbTIpKTsKIAkJZkRlcmF0ZVREUCA9IEdldFNjYWxlZEZy
YWN0aW9uKGxlMzJfdG9fY3B1KGdldEFTSUNQcm9maWxpbmdJbmZvLT51bFRkcERlcmF0ZURQTTIp
LCAxMDAwKTsKIAkJYnJlYWs7CiAJY2FzZSAzOgotCQlmUG93ZXJEUE14ID0gQ29udmVydF9VTE9O
R19Ub0ZyYWN0aW9uKGxlMTZfdG9fY3B1KGdldEFTSUNQcm9maWxpbmdJbmZvLT51c1Bvd2VyRHBt
MykpOwogCQlmRGVyYXRlVERQID0gR2V0U2NhbGVkRnJhY3Rpb24obGUzMl90b19jcHUoZ2V0QVNJ
Q1Byb2ZpbGluZ0luZm8tPnVsVGRwRGVyYXRlRFBNMyksIDEwMDApOwogCQlicmVhazsKIAljYXNl
IDQ6Ci0JCWZQb3dlckRQTXggPSBDb252ZXJ0X1VMT05HX1RvRnJhY3Rpb24obGUxNl90b19jcHUo
Z2V0QVNJQ1Byb2ZpbGluZ0luZm8tPnVzUG93ZXJEcG00KSk7CiAJCWZEZXJhdGVURFAgPSBHZXRT
Y2FsZWRGcmFjdGlvbihsZTMyX3RvX2NwdShnZXRBU0lDUHJvZmlsaW5nSW5mby0+dWxUZHBEZXJh
dGVEUE00KSwgMTAwMCk7CiAJCWJyZWFrOwogCWNhc2UgNToKLQkJZlBvd2VyRFBNeCA9IENvbnZl
cnRfVUxPTkdfVG9GcmFjdGlvbihsZTE2X3RvX2NwdShnZXRBU0lDUHJvZmlsaW5nSW5mby0+dXNQ
b3dlckRwbTUpKTsKIAkJZkRlcmF0ZVREUCA9IEdldFNjYWxlZEZyYWN0aW9uKGxlMzJfdG9fY3B1
KGdldEFTSUNQcm9maWxpbmdJbmZvLT51bFRkcERlcmF0ZURQTTUpLCAxMDAwKTsKIAkJYnJlYWs7
CiAJY2FzZSA2OgotCQlmUG93ZXJEUE14ID0gQ29udmVydF9VTE9OR19Ub0ZyYWN0aW9uKGxlMTZf
dG9fY3B1KGdldEFTSUNQcm9maWxpbmdJbmZvLT51c1Bvd2VyRHBtNikpOwogCQlmRGVyYXRlVERQ
ID0gR2V0U2NhbGVkRnJhY3Rpb24obGUzMl90b19jcHUoZ2V0QVNJQ1Byb2ZpbGluZ0luZm8tPnVs
VGRwRGVyYXRlRFBNNiksIDEwMDApOwogCQlicmVhazsKIAljYXNlIDc6Ci0JCWZQb3dlckRQTXgg
PSBDb252ZXJ0X1VMT05HX1RvRnJhY3Rpb24obGUxNl90b19jcHUoZ2V0QVNJQ1Byb2ZpbGluZ0lu
Zm8tPnVzUG93ZXJEcG03KSk7CiAJCWZEZXJhdGVURFAgPSBHZXRTY2FsZWRGcmFjdGlvbihsZTMy
X3RvX2NwdShnZXRBU0lDUHJvZmlsaW5nSW5mby0+dWxUZHBEZXJhdGVEUE03KSwgMTAwMCk7CiAJ
CWJyZWFrOwogCWRlZmF1bHQ6CiAJCXByX2VycigiRFBNIExldmVsIG5vdCBzdXBwb3J0ZWRcbiIp
OwotCQlmUG93ZXJEUE14ID0gQ29udmVydF9VTE9OR19Ub0ZyYWN0aW9uKDEpOwogCQlmRGVyYXRl
VERQID0gR2V0U2NhbGVkRnJhY3Rpb24obGUzMl90b19jcHUoZ2V0QVNJQ1Byb2ZpbGluZ0luZm8t
PnVsVGRwRGVyYXRlRFBNMCksIDEwMDApOwogCX0KIAotLSAKMi4yNS4xCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
