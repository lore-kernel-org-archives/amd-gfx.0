Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97FDC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9EAB20723
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9EAB20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74A786E9B0;
	Fri, 15 Nov 2019 16:51:12 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE46C6E996
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 16:51:04 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id y39so11525566qty.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 08:51:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UZRboScAMdXkhDOCeriWrHfA0G0p+X1/BFqys+kyJlU=;
 b=iZodEzL7upqgvlzdij8n/Sp4cGQoFI52vjARBMLhtugVklyE/mbXLafZ1dgFmNqgcB
 4MaGTbgtiHmHS7wXnY9VhEFRluh14PPVaYOT/N2KGnQwEQJW3kmqVf3Yi9aC866UO/FY
 ec5inSWLPZ+zR80I0rR9pPXywA1zxF7//arlSNjfy9uNWPazVQw6MusLyvLusjhAvXUa
 Zd5KW0Q7ADVXf8I8yWx9DvVzxlH+topmm7r0JySvdsSluvq6Jj+LF3USKOPZrQb4V3N9
 cffsIMv1HR+OGdJcsCfb7fMhQ4K1CFoPmjh+JsB7abLULopPih8h8p4qAGMtR8T46rDY
 XrSg==
X-Gm-Message-State: APjAAAXN4/tMLo8AXolHGUePoFdzhGAWwUBgzU2DHFu6nFqLBoPXJVqj
 7OYVJp0RToGaOOUs5gfheQ7OVL8I
X-Google-Smtp-Source: APXvYqwWSYYr05JU+xC2YPj/RaDKhglO5F3lQsGl1PoPw9I7E1AWIVqkVibxrB74OWxVSJNhpw9jdg==
X-Received: by 2002:ac8:7282:: with SMTP id v2mr13958901qto.75.1573836663793; 
 Fri, 15 Nov 2019 08:51:03 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id r29sm5610331qtb.63.2019.11.15.08.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 08:51:03 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 17/20] ALSA: hda/hdmi - fix vgaswitcheroo detection for AMD
Date: Fri, 15 Nov 2019 11:50:35 -0500
Message-Id: <20191115165038.56646-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115165038.56646-1-alexander.deucher@amd.com>
References: <20191115165038.56646-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UZRboScAMdXkhDOCeriWrHfA0G0p+X1/BFqys+kyJlU=;
 b=k7CeB3tDxWwB9+2zwjzZUeKQPtfdgVpegslfXUiTpLDeQrGOH0k/0s3xHFBLkpsHNX
 hHm9OBC/uKv6vqUFt88zusy+d9JRhfk4ozvKg/no2M4nqoP9b36u+5iarmaTX7IBgozL
 NK9d+fl5U0/y3hWXuJGyEu2bQCMudoQmjGHQCN+JORMHGnTTf3mygWZnb0XO+JJ/gmo1
 BAK6SEzKHRC22TlazN2+WSI7od/5v1vpskzm2MHeeT4BmKdb160okGI9CN6Y0GCKIK0w
 +eFeJN4sxAQNogTWpuKGEU/GiY7ijpUZK7XZ+iX0QXgxp96VU2j7C15WlKRI85g0mdU0
 bL8Q==
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
Message-ID: <20191115165035.53ZB6iIYI9ll17MIYYn96rBck09s5xYrnqs_S5fPlu8@z>

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
