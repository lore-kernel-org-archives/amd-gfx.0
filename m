Return-Path: <SRS0=j4R+=ZO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C31C432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 21:44:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACF5A2071B
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 21:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF5A2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BEBE6E129;
	Fri, 22 Nov 2019 21:44:06 +0000 (UTC)
Received: from mail-yw1-xc44.google.com (mail-yw1-xc44.google.com
 [IPv6:2607:f8b0:4864:20::c44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B12D6E129
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2019 21:44:04 +0000 (UTC)
Received: by mail-yw1-xc44.google.com with SMTP id 4so2539443ywx.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2019 13:44:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bFYsp63lkmiNIGxUbzfEOILdAxDIS+R8OA5WHO2VkgA=;
 b=YpoTgmxnL/Hsosm4wgM8EhGDJDC7/K1B0PNN/1Wk9iQsEVMKkguV8VVJM5JP10Y7zq
 HZxu071lJIhBvwfthObGGf40VFPFWRA7aAhHV/VYUlHCQReHXQD92o+syUqsiylLD1Po
 ZZOP2ZZgrH70DaReKcZI5BMtF06RoPQxI6CuNexkRtmpBwqSrY+yww2UVc2rTCp70K2K
 yA1xWauNVK7o2e9WD4Adl6vhenXydYCAEkQlPrb8r5rgRso4Xj0NTGbCyg9DOgXBgf7q
 3JtJpMGpMyCKI82Ll24X47Ob41V8jGGbulJ3FxKBQNeO3Q51doZS7W5V44TCpGiY8KP0
 L+/w==
X-Gm-Message-State: APjAAAVfyOfHdVVcVUmbDYRYf58NIr/7LDZaPVA9E4rdfYhtgdf7t6Va
 NQkx5ILmYPJvwo1BU5CYCq+7W98e
X-Google-Smtp-Source: APXvYqxQVI62Nh6WMju1/criCuPOgdm/c8IZD1mh9ib8Xftf731oiPDe/s7oraOJTKJoRlqzSND8oQ==
X-Received: by 2002:a81:a153:: with SMTP id y80mr11030740ywg.268.1574459043408; 
 Fri, 22 Nov 2019 13:44:03 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id t15sm2111522ywh.70.2019.11.22.13.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 13:44:02 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de
Subject: [PATCH 2/4] ALSA: hda/hdmi - Add new pci ids for AMD GPU display audio
Date: Fri, 22 Nov 2019 16:43:51 -0500
Message-Id: <20191122214353.582899-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191122214353.582899-1-alexander.deucher@amd.com>
References: <20191122214353.582899-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bFYsp63lkmiNIGxUbzfEOILdAxDIS+R8OA5WHO2VkgA=;
 b=CdPvpN2TtkuzThokr8FkOIPM9sIktdP1vsg3eeUzjlHmbBORU+5zaRXh9Ls9tmM49g
 wD7bGtt4nVql4X30sc+4Y78TE44IHbpfqEFZBupdJxTIcSpU1sZJmToSIbV/Carc6G7w
 j7s2aAwPFVx9PpWM7WLMuwC/4FTP13zU2vFzvqwHLSqJWSlo4wx28OXWbVU2887dL4Hj
 bNvescc7S/R+3mlCnlVd05D/8nTN8bUEdklVeAqgZH1pcciu3LEdP9LtQcSU0iKfZ7vH
 t6kRipGDqnmzriLPvlu8nQHvceayKwmFZEiCMakD58oO2Gc/Aprc7BxgXix04emiKfKZ
 Aexw==
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
Message-ID: <20191122214351.1vEjZDEzhmJIWGQZyq1pXm2QmNOwVUJ7xMhhYJNqcpI@z>

VGhlc2UgYXJlIG5lZWRlZCBzbyB3ZSBjYW4gZW5hYmxlIHJ1bnRpbWUgcG0gaW4gYSBzdWJzZXF1
ZW50CnBhdGNoLgoKUmV2aWV3ZWQtYnk6IFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5kZT4KU2ln
bmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0K
IHNvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMgfCAxNCArKysrKysrKysrKysrKwogMSBmaWxlIGNo
YW5nZWQsIDE0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRhL2hkYV9p
bnRlbC5jIGIvc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYwppbmRleCAzZWJjN2IyYTg5N2YuLjc5
Y2E5N2Q2YzgxMSAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYworKysgYi9z
b3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jCkBAIC0yNjA2LDYgKzI2MDYsMjAgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkIGF6eF9pZHNbXSA9IHsKIAkgIC5kcml2ZXJfZGF0YSA9
IEFaWF9EUklWRVJfQVRJSERNSV9OUyB8IEFaWF9EQ0FQU19QUkVTRVRfQVRJX0hETUlfTlMgfSwK
IAl7IFBDSV9ERVZJQ0UoMHgxMDAyLCAweGFhZjApLAogCSAgLmRyaXZlcl9kYXRhID0gQVpYX0RS
SVZFUl9BVElIRE1JX05TIHwgQVpYX0RDQVBTX1BSRVNFVF9BVElfSERNSV9OUyB9LAorCXsgUENJ
X0RFVklDRSgweDEwMDIsIDB4YWFmOCksCisJICAuZHJpdmVyX2RhdGEgPSBBWlhfRFJJVkVSX0FU
SUhETUlfTlMgfCBBWlhfRENBUFNfUFJFU0VUX0FUSV9IRE1JX05TIH0sCisJeyBQQ0lfREVWSUNF
KDB4MTAwMiwgMHhhYjAwKSwKKwkgIC5kcml2ZXJfZGF0YSA9IEFaWF9EUklWRVJfQVRJSERNSV9O
UyB8IEFaWF9EQ0FQU19QUkVTRVRfQVRJX0hETUlfTlMgfSwKKwl7IFBDSV9ERVZJQ0UoMHgxMDAy
LCAweGFiMDgpLAorCSAgLmRyaXZlcl9kYXRhID0gQVpYX0RSSVZFUl9BVElIRE1JX05TIHwgQVpY
X0RDQVBTX1BSRVNFVF9BVElfSERNSV9OUyB9LAorCXsgUENJX0RFVklDRSgweDEwMDIsIDB4YWIx
MCksCisJICAuZHJpdmVyX2RhdGEgPSBBWlhfRFJJVkVSX0FUSUhETUlfTlMgfCBBWlhfRENBUFNf
UFJFU0VUX0FUSV9IRE1JX05TIH0sCisJeyBQQ0lfREVWSUNFKDB4MTAwMiwgMHhhYjE4KSwKKwkg
IC5kcml2ZXJfZGF0YSA9IEFaWF9EUklWRVJfQVRJSERNSV9OUyB8IEFaWF9EQ0FQU19QUkVTRVRf
QVRJX0hETUlfTlMgfSwKKwl7IFBDSV9ERVZJQ0UoMHgxMDAyLCAweGFiMjApLAorCSAgLmRyaXZl
cl9kYXRhID0gQVpYX0RSSVZFUl9BVElIRE1JX05TIHwgQVpYX0RDQVBTX1BSRVNFVF9BVElfSERN
SV9OUyB9LAorCXsgUENJX0RFVklDRSgweDEwMDIsIDB4YWIzOCksCisJICAuZHJpdmVyX2RhdGEg
PSBBWlhfRFJJVkVSX0FUSUhETUlfTlMgfCBBWlhfRENBUFNfUFJFU0VUX0FUSV9IRE1JX05TIH0s
CiAJLyogVklBIFZUODI1MS9WVDgyMzdBICovCiAJeyBQQ0lfREVWSUNFKDB4MTEwNiwgMHgzMjg4
KSwgLmRyaXZlcl9kYXRhID0gQVpYX0RSSVZFUl9WSUEgfSwKIAkvKiBWSUEgR0ZYIFZUNzEyMi9W
WDkwMCAqLwotLSAKMi4yMy4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=
