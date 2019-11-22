Return-Path: <SRS0=j4R+=ZO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E51C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 21:44:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F27162071B
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 21:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27162071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB4B6E12B;
	Fri, 22 Nov 2019 21:44:05 +0000 (UTC)
Received: from mail-yw1-xc42.google.com (mail-yw1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80E1F6E119
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2019 21:44:03 +0000 (UTC)
Received: by mail-yw1-xc42.google.com with SMTP id 4so2539428ywx.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2019 13:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UZRboScAMdXkhDOCeriWrHfA0G0p+X1/BFqys+kyJlU=;
 b=CI2krVbwDIyci4O/C8Bb+vcgkg2BmCdVxhRi9iqQaNO6hyhY7CZpt610isH/eTOh95
 E/wzI/0c2Bg5dJptCFhlYrrGXUwKtGIlVRpMmi4WFrxPAJQzt7W+piqVGYfBuA6JduDY
 O3zYjFR5iP8VkF4N6PmF2nXh3UHn418jItzdEa01gRM55JIpWTRqYRF2SS7NFft22uLm
 6pStBbY0Vg4C+VODJJA4mngyfUo9VFYq7AUYoIc6Ubv3p6NdAKxO5zH5OqCjICUrN2ah
 z2V4jHsBD9yhoQ1BAOh7ZpqtJlKFoNc6CFOvmH81lbWhni5C5yEQg+Pl651q2AuR/0/B
 uQIQ==
X-Gm-Message-State: APjAAAXWbfOWoVru4MJML8nNNqPY/ccV0vqSKp0oqjxtnI2laGRF1db9
 2xQFTQtfmQv+1VmtMrIJqSgNfgOd
X-Google-Smtp-Source: APXvYqzpCxqjhUm4FionawKDzm3lfMqwKucoMhLNTgXWLQtua41zahCcLox4aqQJwyxS19+SJ5OMXA==
X-Received: by 2002:a81:a985:: with SMTP id g127mr3202791ywh.470.1574459042397; 
 Fri, 22 Nov 2019 13:44:02 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id t15sm2111522ywh.70.2019.11.22.13.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 13:44:01 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de
Subject: [PATCH 1/4] ALSA: hda/hdmi - fix vgaswitcheroo detection for AMD
Date: Fri, 22 Nov 2019 16:43:50 -0500
Message-Id: <20191122214353.582899-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191122214353.582899-1-alexander.deucher@amd.com>
References: <20191122214353.582899-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UZRboScAMdXkhDOCeriWrHfA0G0p+X1/BFqys+kyJlU=;
 b=VTdEkhzC4UQ9S6hIdWvx8S31C6Mm0YAY4in/nMHUvmlXxVtvmPL0v/HcSrwsiUDn0S
 ge77QrX/9A5EgHx5w1HtyXhlOUsF6Bp8JHh54s9nAJiDdXSo4Q2p/tJx8CGAIn9lUNXl
 hhLXPtjmHmqYaZQ65LKVYV408a+0BZQYHFFB3Wj8AvGBgYrlL9xP77BBkMdR2Yk2+4+Z
 A4W+iwJXR8qUqCboRTYp9ZuPBWvEdiMR0nmyWdfhzLW1XFDgPEcQTnam17rG90PmqAS0
 3M/bOXT8MHH8Ni7KESIPOXbtMpBstPnoDElMSJNH8NHgEcP9WdujgxwfTWJ3vG+9Ei+8
 cekw==
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
Message-ID: <20191122214350.79tlvV9OSfzlcVSG56LMP4iF630bJNZKlFD98X6ONjQ@z>

T25seSBlbmFibGUgdGhlIHZnYV9zd2l0Y2hlcm9vIGxvZ2ljIG9uIHN5c3RlbXMgd2l0aCB0aGUK
QVRQWCBBQ1BJIG1ldGhvZC4gIFRoaXMgbG9naWMgaXMgbm90IG5lZWRlZCBmb3IgYXNpY3MKdGhh
dCBhcmUgbm90IHBhcnQgb2YgYSBQWCAoUG93ZXJYcHJlc3MpL0hHIChIeWJyaWQgR3JhcGhpY3Mp
CnBsYXRmb3JtLgoKUmV2aWV3ZWQtYnk6IFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5kZT4KQWNr
ZWQtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBzb3VuZC9wY2kvaGRhL2hk
YV9pbnRlbC5jIHwgNDUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAx
IGZpbGUgY2hhbmdlZCwgNDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9o
ZGEvaGRhX2ludGVsLmMgYi9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jCmluZGV4IDI0MGY0Y2E3
NjM5MS4uM2ViYzdiMmE4OTdmIDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5j
CisrKyBiL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMKQEAgLTM1LDYgKzM1LDcgQEAKICNpbmNs
dWRlIDxsaW51eC9jbG9ja3NvdXJjZS5oPgogI2luY2x1ZGUgPGxpbnV4L3RpbWUuaD4KICNpbmNs
dWRlIDxsaW51eC9jb21wbGV0aW9uLmg+CisjaW5jbHVkZSA8bGludXgvYWNwaS5oPgogCiAjaWZk
ZWYgQ09ORklHX1g4NgogLyogZm9yIHNub29wIGNvbnRyb2wgKi8KQEAgLTEzOTMsNiArMTM5NCwz
NCBAQCBzdGF0aWMgaW50IGF6eF9kZXZfZnJlZShzdHJ1Y3Qgc25kX2RldmljZSAqZGV2aWNlKQog
fQogCiAjaWZkZWYgU1VQUE9SVF9WR0FfU1dJVENIRVJPTworI2lmZGVmIENPTkZJR19BQ1BJCisv
KiBBVFBYIGlzIGluIHRoZSBpbnRlZ3JhdGVkIEdQVSdzIG5hbWVzcGFjZSAqLworc3RhdGljIGJv
b2wgYXRweF9wcmVzZW50KHZvaWQpCit7CisJc3RydWN0IHBjaV9kZXYgKnBkZXYgPSBOVUxMOwor
CWFjcGlfaGFuZGxlIGRoYW5kbGUsIGF0cHhfaGFuZGxlOworCWFjcGlfc3RhdHVzIHN0YXR1czsK
KworCXdoaWxlICgocGRldiA9IHBjaV9nZXRfY2xhc3MoUENJX0JBU0VfQ0xBU1NfRElTUExBWSA8
PCAxNiwgcGRldikpICE9IE5VTEwpIHsKKwkJZGhhbmRsZSA9IEFDUElfSEFORExFKCZwZGV2LT5k
ZXYpOworCQlpZiAoZGhhbmRsZSkgeworCQkJc3RhdHVzID0gYWNwaV9nZXRfaGFuZGxlKGRoYW5k
bGUsICJBVFBYIiwgJmF0cHhfaGFuZGxlKTsKKwkJCWlmICghQUNQSV9GQUlMVVJFKHN0YXR1cykp
IHsKKwkJCQlwY2lfZGV2X3B1dChwZGV2KTsKKwkJCQlyZXR1cm4gdHJ1ZTsKKwkJCX0KKwkJfQor
CQlwY2lfZGV2X3B1dChwZGV2KTsKKwl9CisJcmV0dXJuIGZhbHNlOworfQorI2Vsc2UKK3N0YXRp
YyBib29sIGF0cHhfcHJlc2VudCh2b2lkKQoreworCXJldHVybiBmYWxzZTsKK30KKyNlbmRpZgor
CiAvKgogICogQ2hlY2sgb2YgZGlzYWJsZWQgSERNSSBjb250cm9sbGVyIGJ5IHZnYV9zd2l0Y2hl
cm9vCiAgKi8KQEAgLTE0MDQsNiArMTQzMywyMiBAQCBzdGF0aWMgc3RydWN0IHBjaV9kZXYgKmdl
dF9ib3VuZF92Z2Eoc3RydWN0IHBjaV9kZXYgKnBjaSkKIAlzd2l0Y2ggKHBjaS0+dmVuZG9yKSB7
CiAJY2FzZSBQQ0lfVkVORE9SX0lEX0FUSToKIAljYXNlIFBDSV9WRU5ET1JfSURfQU1EOgorCQlp
ZiAocGNpLT5kZXZmbiA9PSAxKSB7CisJCQlwID0gcGNpX2dldF9kb21haW5fYnVzX2FuZF9zbG90
KHBjaV9kb21haW5fbnIocGNpLT5idXMpLAorCQkJCQkJCXBjaS0+YnVzLT5udW1iZXIsIDApOwor
CQkJaWYgKHApIHsKKwkJCQkvKiBBVFBYIGlzIGluIHRoZSBpbnRlZ3JhdGVkIEdQVSdzIEFDUEkg
bmFtZXNwYWNlCisJCQkJICogcmF0aGVyIHRoYW4gdGhlIGRHUFUncyBuYW1lc3BhY2UuIEhvd2V2
ZXIsCisJCQkJICogdGhlIGRHUFUgaXMgdGhlIG9uZSB3aG8gaXMgaW52b2x2ZWQgaW4KKwkJCQkg
KiB2Z2Fzd2l0Y2hlcm9vLgorCQkJCSAqLworCQkJCWlmICgoKHAtPmNsYXNzID4+IDE2KSA9PSBQ
Q0lfQkFTRV9DTEFTU19ESVNQTEFZKSAmJgorCQkJCSAgICBhdHB4X3ByZXNlbnQoKSkKKwkJCQkJ
cmV0dXJuIHA7CisJCQkJcGNpX2Rldl9wdXQocCk7CisJCQl9CisJCX0KKwkJYnJlYWs7CiAJY2Fz
ZSBQQ0lfVkVORE9SX0lEX05WSURJQToKIAkJaWYgKHBjaS0+ZGV2Zm4gPT0gMSkgewogCQkJcCA9
IHBjaV9nZXRfZG9tYWluX2J1c19hbmRfc2xvdChwY2lfZG9tYWluX25yKHBjaS0+YnVzKSwKLS0g
CjIuMjMuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
