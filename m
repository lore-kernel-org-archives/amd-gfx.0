Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930F3CA9EC2
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DEE9217D6
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DEE9217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23C566EAB0;
	Mon, 28 Oct 2019 21:44:09 +0000 (UTC)
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com
 [IPv6:2607:f8b0:4864:20::b42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BFBB6EAB5
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 21:44:05 +0000 (UTC)
Received: by mail-yb1-xb42.google.com with SMTP id h202so4621675ybg.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 14:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AomRc+7JSXWolrt89ocEx2b52OuqFBoGAWXzR8KU8dE=;
 b=RMNRkefCmUXEtH8t+no/K+i2xdMz+xvsAs9ARyxUWF50iDsS5nuB/iQr86igZTkirs
 z3kwOkuor3NdbTNJoIIT43E0zjX7cGI2qpHbtD1r0jEKDHfbCklmNldoThasMnvczNoT
 F8D7hAdTEibwH3kZfuOTlJd2xe3H6hhoNkveEpTDjhPgXIC6ZzHsutSzsrAKBafCKWMB
 oy30bVzY9U4opWYiU5YjCYM91TTs0XUUXJ7av2QZ2X/IosK0fELkFh1Sqx8u5MNHo1u/
 znLfjOuNNodFieQVl2FpyNTte6noRIl5CeMzhTl4V9FnABbSyy2ze25f7xtsD2OvVVP/
 ZPeQ==
X-Gm-Message-State: APjAAAVN2OBTEeCTYXrLekitpoBezC3/vEzTPUTQLjxDb7hnzItVfW1Q
 f1nN9XAPpSZqy8vlEsNbYDQkJGvMlUw=
X-Google-Smtp-Source: APXvYqy5j/Au7c1Su9KNfE4N4upKHXPTa+nOArMcCcQXK+P8vJjH6Ou/56KIw0B1gAxESG+RG4p0lA==
X-Received: by 2002:a25:80c1:: with SMTP id c1mr16078356ybm.195.1572299043159; 
 Mon, 28 Oct 2019 14:44:03 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l68sm3421090ywf.95.2019.10.28.14.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 14:44:02 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 20/21] ALSA: hda/hdmi - enable runtime pm for newer AMD
 display audio
Date: Mon, 28 Oct 2019 17:42:15 -0400
Message-Id: <20191028214216.1508370-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028214216.1508370-1-alexander.deucher@amd.com>
References: <20191028214216.1508370-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AomRc+7JSXWolrt89ocEx2b52OuqFBoGAWXzR8KU8dE=;
 b=sI9/2fLjbbGXFIRnFJ46LXMuTkv5ltCHDD3AuL7y7o3djW3sp/kq3DPXx3ab9uXz+v
 b2tOTgPT98pK6JkZPLTKvfyahnHMnSSgqcsH3HK5rHrGbu0241RNvFXY9ocvELFjNuf+
 PjpbS6rn3b3eBejoB+QIHCAKZz0U8ZAvi/R5dCxcGcQjhRNR3nKV/v+dAhl5PIKq49y/
 dhGyar1QjdBUJS89QyQXrOLPT57/MOsN/8Oq+H/O457CDUU2nrvd+ryxke8lGuoFTNrt
 BdbltoCLXb7DCghvGor9oOrbqYgJweV41yVjIb71PQvVEGuJqCUks5FEciHNfF6KGW0d
 s4kQ==
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
Message-ID: <20191028214215.QA5X9apoN3vwHs6cBYA24V9g2QqNiDaxixGXN-glm54@z>

V2UgYXJlIGFibGUgdG8gcG93ZXIgZG93biB0aGUgR1BVIGFuZCBhdWRpbyB2aWEgdGhlIEdQVSBk
cml2ZXIKc28gZmxhZyB0aGVzZSBhc2ljcyBhcyBzdXBwb3J0aW5nIHJ1bnRpbWUgcG0uCgpBY2tl
ZC1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KCnYyOgotIHNwbGl0IG91dCBh
ZGRpbmcgdGhlIG5ldyBwY2kgaWRzCgogc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYyB8IDM1ICsr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjMgaW5z
ZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9o
ZGFfaW50ZWwuYyBiL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMKaW5kZXggYTA3Y2M4ZGNhN2Rl
Li4xMzRjN2UyODVkN2MgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMKKysr
IGIvc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYwpAQCAtMjU3MiwyNyArMjU3MiwzOCBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgYXp4X2lkc1tdID0gewogCXsgUENJX0RFVklD
RSgweDEwMDIsIDB4YWFjOCksCiAJICAuZHJpdmVyX2RhdGEgPSBBWlhfRFJJVkVSX0FUSUhETUlf
TlMgfCBBWlhfRENBUFNfUFJFU0VUX0FUSV9IRE1JX05TIH0sCiAJeyBQQ0lfREVWSUNFKDB4MTAw
MiwgMHhhYWQ4KSwKLQkgIC5kcml2ZXJfZGF0YSA9IEFaWF9EUklWRVJfQVRJSERNSV9OUyB8IEFa
WF9EQ0FQU19QUkVTRVRfQVRJX0hETUlfTlMgfSwKLQl7IFBDSV9ERVZJQ0UoMHgxMDAyLCAweGFh
ZTgpLAotCSAgLmRyaXZlcl9kYXRhID0gQVpYX0RSSVZFUl9BVElIRE1JX05TIHwgQVpYX0RDQVBT
X1BSRVNFVF9BVElfSERNSV9OUyB9LAorCSAgLmRyaXZlcl9kYXRhID0gQVpYX0RSSVZFUl9BVElI
RE1JX05TIHwgQVpYX0RDQVBTX1BSRVNFVF9BVElfSERNSV9OUyB8CisJICBBWlhfRENBUFNfUE1f
UlVOVElNRSB9LAogCXsgUENJX0RFVklDRSgweDEwMDIsIDB4YWFlMCksCi0JICAuZHJpdmVyX2Rh
dGEgPSBBWlhfRFJJVkVSX0FUSUhETUlfTlMgfCBBWlhfRENBUFNfUFJFU0VUX0FUSV9IRE1JX05T
IH0sCisJICAuZHJpdmVyX2RhdGEgPSBBWlhfRFJJVkVSX0FUSUhETUlfTlMgfCBBWlhfRENBUFNf
UFJFU0VUX0FUSV9IRE1JX05TIHwKKwkgIEFaWF9EQ0FQU19QTV9SVU5USU1FIH0sCisJeyBQQ0lf
REVWSUNFKDB4MTAwMiwgMHhhYWU4KSwKKwkgIC5kcml2ZXJfZGF0YSA9IEFaWF9EUklWRVJfQVRJ
SERNSV9OUyB8IEFaWF9EQ0FQU19QUkVTRVRfQVRJX0hETUlfTlMgfAorCSAgQVpYX0RDQVBTX1BN
X1JVTlRJTUUgfSwKIAl7IFBDSV9ERVZJQ0UoMHgxMDAyLCAweGFhZjApLAotCSAgLmRyaXZlcl9k
YXRhID0gQVpYX0RSSVZFUl9BVElIRE1JX05TIHwgQVpYX0RDQVBTX1BSRVNFVF9BVElfSERNSV9O
UyB9LAorCSAgLmRyaXZlcl9kYXRhID0gQVpYX0RSSVZFUl9BVElIRE1JX05TIHwgQVpYX0RDQVBT
X1BSRVNFVF9BVElfSERNSV9OUyB8CisJICBBWlhfRENBUFNfUE1fUlVOVElNRSB9LAogCXsgUENJ
X0RFVklDRSgweDEwMDIsIDB4YWFmOCksCi0JICAuZHJpdmVyX2RhdGEgPSBBWlhfRFJJVkVSX0FU
SUhETUlfTlMgfCBBWlhfRENBUFNfUFJFU0VUX0FUSV9IRE1JX05TIH0sCisJICAuZHJpdmVyX2Rh
dGEgPSBBWlhfRFJJVkVSX0FUSUhETUlfTlMgfCBBWlhfRENBUFNfUFJFU0VUX0FUSV9IRE1JX05T
IHwKKwkgIEFaWF9EQ0FQU19QTV9SVU5USU1FIH0sCiAJeyBQQ0lfREVWSUNFKDB4MTAwMiwgMHhh
YjAwKSwKLQkgIC5kcml2ZXJfZGF0YSA9IEFaWF9EUklWRVJfQVRJSERNSV9OUyB8IEFaWF9EQ0FQ
U19QUkVTRVRfQVRJX0hETUlfTlMgfSwKKwkgIC5kcml2ZXJfZGF0YSA9IEFaWF9EUklWRVJfQVRJ
SERNSV9OUyB8IEFaWF9EQ0FQU19QUkVTRVRfQVRJX0hETUlfTlMgfAorCSAgQVpYX0RDQVBTX1BN
X1JVTlRJTUUgfSwKIAl7IFBDSV9ERVZJQ0UoMHgxMDAyLCAweGFiMDgpLAotCSAgLmRyaXZlcl9k
YXRhID0gQVpYX0RSSVZFUl9BVElIRE1JX05TIHwgQVpYX0RDQVBTX1BSRVNFVF9BVElfSERNSV9O
UyB9LAorCSAgLmRyaXZlcl9kYXRhID0gQVpYX0RSSVZFUl9BVElIRE1JX05TIHwgQVpYX0RDQVBT
X1BSRVNFVF9BVElfSERNSV9OUyB8CisJICBBWlhfRENBUFNfUE1fUlVOVElNRSB9LAogCXsgUENJ
X0RFVklDRSgweDEwMDIsIDB4YWIxMCksCi0JICAuZHJpdmVyX2RhdGEgPSBBWlhfRFJJVkVSX0FU
SUhETUlfTlMgfCBBWlhfRENBUFNfUFJFU0VUX0FUSV9IRE1JX05TIH0sCisJICAuZHJpdmVyX2Rh
dGEgPSBBWlhfRFJJVkVSX0FUSUhETUlfTlMgfCBBWlhfRENBUFNfUFJFU0VUX0FUSV9IRE1JX05T
IHwKKwkgIEFaWF9EQ0FQU19QTV9SVU5USU1FIH0sCiAJeyBQQ0lfREVWSUNFKDB4MTAwMiwgMHhh
YjE4KSwKLQkgIC5kcml2ZXJfZGF0YSA9IEFaWF9EUklWRVJfQVRJSERNSV9OUyB8IEFaWF9EQ0FQ
U19QUkVTRVRfQVRJX0hETUlfTlMgfSwKKwkgIC5kcml2ZXJfZGF0YSA9IEFaWF9EUklWRVJfQVRJ
SERNSV9OUyB8IEFaWF9EQ0FQU19QUkVTRVRfQVRJX0hETUlfTlMgfAorCSAgQVpYX0RDQVBTX1BN
X1JVTlRJTUUgfSwKIAl7IFBDSV9ERVZJQ0UoMHgxMDAyLCAweGFiMjApLAotCSAgLmRyaXZlcl9k
YXRhID0gQVpYX0RSSVZFUl9BVElIRE1JX05TIHwgQVpYX0RDQVBTX1BSRVNFVF9BVElfSERNSV9O
UyB9LAorCSAgLmRyaXZlcl9kYXRhID0gQVpYX0RSSVZFUl9BVElIRE1JX05TIHwgQVpYX0RDQVBT
X1BSRVNFVF9BVElfSERNSV9OUyB8CisJICBBWlhfRENBUFNfUE1fUlVOVElNRSB9LAogCXsgUENJ
X0RFVklDRSgweDEwMDIsIDB4YWIzOCksCi0JICAuZHJpdmVyX2RhdGEgPSBBWlhfRFJJVkVSX0FU
SUhETUlfTlMgfCBBWlhfRENBUFNfUFJFU0VUX0FUSV9IRE1JX05TIH0sCisJICAuZHJpdmVyX2Rh
dGEgPSBBWlhfRFJJVkVSX0FUSUhETUlfTlMgfCBBWlhfRENBUFNfUFJFU0VUX0FUSV9IRE1JX05T
IHwKKwkgIEFaWF9EQ0FQU19QTV9SVU5USU1FIH0sCiAJLyogVklBIFZUODI1MS9WVDgyMzdBICov
CiAJeyBQQ0lfREVWSUNFKDB4MTEwNiwgMHgzMjg4KSwgLmRyaXZlcl9kYXRhID0gQVpYX0RSSVZF
Ul9WSUEgfSwKIAkvKiBWSUEgR0ZYIFZUNzEyMi9WWDkwMCAqLwotLSAKMi4yMy4wCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
