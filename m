Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A68DCA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:43:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D35217D6
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D35217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAD196EA9F;
	Mon, 28 Oct 2019 21:43:09 +0000 (UTC)
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com
 [IPv6:2607:f8b0:4864:20::b41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30A3E6EA9E
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 21:43:08 +0000 (UTC)
Received: by mail-yb1-xb41.google.com with SMTP id z125so4644568ybc.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 14:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GbGxDJNQTBvT+RJ5ap+7ma9iXB0z5sr7CNysFxEASlY=;
 b=da7fxGvGocUICMt5tAHCA/D38y2C5mZ4ChbYx+npL5YKbn1Yo09Euvqa6GurJpyWvj
 LaZt2wwHC2ydk36E/1OE+0qlGQCKXoKAZCPJJ90lU5g1y9+IG3IQ9zvKn2vkNKMuKdIA
 wF6V6tB8eXUZb4vLfAmL5AMfHZ35kuB42owopv+mldem+lAAg7IrugLkfdJ5mLeOlhHR
 yH0QEtvjRvr/cx5Me4cJmGY+slZYK9ZpSMf091AaPLILkQofrl6RAQ71WjeyeNC1OAoY
 HeaBvXAoQYmbY9qTSeoipgUXhehCC9fh9mvdw/15CQc3Mw7XBeSXWSiRmxrbRYlCcVj6
 2Vrg==
X-Gm-Message-State: APjAAAVrvwOUthp67ORssHDTEsXTtBFAyaGKK3n9J8kgVF3RDjSDuAFy
 jfmfdAF9BXa+SjFsttq/Okq7byHDSYI=
X-Google-Smtp-Source: APXvYqz6507CpDAq9VrcBCDCu6RBZOH3UH9hLdATMX1e/2buKhbsm+Sn710B4BqXriGOQsER7N5+EQ==
X-Received: by 2002:a25:d70f:: with SMTP id o15mr16995235ybg.43.1572298987058; 
 Mon, 28 Oct 2019 14:43:07 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l68sm3421090ywf.95.2019.10.28.14.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 14:43:06 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 05/21] drm/amdgpu: add supports_baco callback for CIK asics.
Date: Mon, 28 Oct 2019 17:42:00 -0400
Message-Id: <20191028214216.1508370-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028214216.1508370-1-alexander.deucher@amd.com>
References: <20191028214216.1508370-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GbGxDJNQTBvT+RJ5ap+7ma9iXB0z5sr7CNysFxEASlY=;
 b=rpdg0jwxSFgYTeSiIEzi1U9yRqGpvmv02WbdjQHfyATmHrj28HkQ7T9TqGKPA2uWmI
 heDWxxJ93T34sNmjuElMhQ32pW+8ZlfG3L34Z6B7oShqL1vacC5IISwG//bFFT1z66ml
 MTxicv9f3MbyoNHii+yLR9NxQXEAjwkgAKSD61V6W38uZZH0l7Ou5JV/+//ZaVKUZFCo
 LK8/ovi0IJt5tGw5B0paYCKuMTub/xUWdKe282mPLc8hiya+C7ulUwki7JTmM0nqlX4b
 NrxQsl74WRrUWN3MWh4guuIUftvYFZ+r0ERdmDV6ovS/mZwbIp/5IYjKH4aCbA6NdovB
 32gA==
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
Message-ID: <20191028214200.L06hH-CV6A085TEwF6pp_VU7VsWOQ5FJNu9_tWFgKE8@z>

QkFDTyAtIEJ1cyBBY3RpdmUsIENoaXAgT2ZmCgpDaGVjayB0aGUgQkFDTyBjYXBhYmlsaXRpZXMg
ZnJvbSB0aGUgcG93ZXJwbGF5IHRhYmxlLgoKUmV2aWV3ZWQtYnk6IEV2YW4gUXVhbiA8ZXZhbi5x
dWFuQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9jaWsuYyB8IDE4ICsr
KysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9jaWsuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2Npay5jCmluZGV4IDJkNjRkMjcwNzI1ZC4uOTY4YmM3MDZiOTRkIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9jaWsuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9jaWsuYwpAQCAtMTMxMCw2ICsxMzEwLDIzIEBAIHN0YXRpYyBpbnQg
Y2lrX2FzaWNfcGNpX2NvbmZpZ19yZXNldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAly
ZXR1cm4gcjsKIH0KIAorc3RhdGljIGJvb2wgY2lrX2FzaWNfc3VwcG9ydHNfYmFjbyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikKK3sKKwlib29sIGJhY29fc3VwcG9ydDsKKworCXN3aXRjaCAo
YWRldi0+YXNpY190eXBlKSB7CisJY2FzZSBDSElQX0JPTkFJUkU6CisJY2FzZSBDSElQX0hBV0FJ
SToKKwkJc211N19hc2ljX2dldF9iYWNvX2NhcGFiaWxpdHkoYWRldiwgJmJhY29fc3VwcG9ydCk7
CisJCWJyZWFrOworCWRlZmF1bHQ6CisJCWJhY29fc3VwcG9ydCA9IGZhbHNlOworCQlicmVhazsK
Kwl9CisKKwlyZXR1cm4gYmFjb19zdXBwb3J0OworfQorCiBzdGF0aWMgZW51bSBhbWRfcmVzZXRf
bWV0aG9kCiBjaWtfYXNpY19yZXNldF9tZXRob2Qoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
CiB7CkBAIC0xODk5LDYgKzE5MTYsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9hc2lj
X2Z1bmNzIGNpa19hc2ljX2Z1bmNzID0KIAkuZ2V0X3BjaWVfdXNhZ2UgPSAmY2lrX2dldF9wY2ll
X3VzYWdlLAogCS5uZWVkX3Jlc2V0X29uX2luaXQgPSAmY2lrX25lZWRfcmVzZXRfb25faW5pdCwK
IAkuZ2V0X3BjaWVfcmVwbGF5X2NvdW50ID0gJmNpa19nZXRfcGNpZV9yZXBsYXlfY291bnQsCisJ
LnN1cHBvcnRzX2JhY28gPSAmY2lrX2FzaWNfc3VwcG9ydHNfYmFjbywKIH07CiAKIHN0YXRpYyBp
bnQgY2lrX2NvbW1vbl9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkKLS0gCjIuMjMuMAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
