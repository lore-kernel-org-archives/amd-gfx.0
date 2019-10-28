Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C518FCA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AEDC217D6
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AEDC217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A69B6EAB3;
	Mon, 28 Oct 2019 21:44:00 +0000 (UTC)
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com
 [IPv6:2607:f8b0:4864:20::b41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87A456EAB3
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 21:43:58 +0000 (UTC)
Received: by mail-yb1-xb41.google.com with SMTP id h202so4621555ybg.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 14:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=86OaAIUStlP4vQMmLnRFdDIvmpFylru96i13DOreI6Y=;
 b=jyMbmvtcWTqawEPcfVua7CYijSId1+H+G/1QqW/AkDXMoIgjElfGC9YgsM6y8zDKY8
 DG6zjshtk591zK7hd47hEsMrg+L5cKgcR6DiiTVLYjhMUDnHi+KqJyYvprB07lQ5IRy/
 zIxqbQ8xkdix4RtxXTT4+h6MElorb2UjWboca82m9qZ6oMXGtfzATRnAmMDsKhNgrIhy
 MJghoulZ9X3jundnM4mrOARcUSOlXvKp/MNkf844NGjEtJ5gLwcCZKn2n6F/4iWTk2Gj
 umPYz/RzVEm50pkb5ypwYG0G+wexVeRAIm97Dmck4zdSoARENqtvUCZ0VGZM9EPVfOov
 tcBw==
X-Gm-Message-State: APjAAAVMQQTg2s/yZbhNcY+6Ricl+udnj4CTqptCESzl7avD1G3OZWYb
 CMrXy9R+jc4yUk67005wJDJZVhjVR3I=
X-Google-Smtp-Source: APXvYqyqHnG7vDeZSQmPcl0bg2lJXIgC8E0pMNNgdjsGmKZLlfxUN1nkdFa+ckY3QTcesYJjeyb6ng==
X-Received: by 2002:a25:7ac4:: with SMTP id v187mr6204298ybc.118.1572299037385; 
 Mon, 28 Oct 2019 14:43:57 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l68sm3421090ywf.95.2019.10.28.14.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 14:43:56 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 19/21] ALSA: hda/hdmi - Add new pci ids for AMD GPU display
 audio
Date: Mon, 28 Oct 2019 17:42:14 -0400
Message-Id: <20191028214216.1508370-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028214216.1508370-1-alexander.deucher@amd.com>
References: <20191028214216.1508370-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=86OaAIUStlP4vQMmLnRFdDIvmpFylru96i13DOreI6Y=;
 b=s1mGKr1AI6wvxdKJyGVtyJGiMli/X5NCPURqUjWQGuZ+WhskdWAwKGeHPeGHJUB9ZH
 hLjUdF6NQxohnYdjp1sLiZHFck1E+nAVK+7SCHrCtN0MQV19iH1GyrcwO1CH/y/tGnu2
 GXJehhorjTOe4Yk7eW+aqgMYA2Z8CBn0GpsIbSzOnRITJIQz6bD1kD6tApq1iAMazw9W
 U98G0+UyRL2r5K3oJk1bE0yIAaHDsDta+/34KE5LiwQWLZBUDXST3HOoPaPGIrLPS2Ud
 7VZ1OB25Ncoe8Dvma0/RckzY+7HdjWYIPwpf6NEygc1OCHzxgmn+df0kUSLQey2MvEK1
 /+cw==
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
Message-ID: <20191028214214.PA2nvJztndWPGd_1ACnzTZAAybhPYFadobWDUCk6U40@z>

VGhlc2UgYXJlIG5lZWRlZCBzbyB3ZSBjYW4gZW5hYmxlIHJ1bnRpbWUgcG0gaW4gYSBzdWJzZXF1
ZW50CnBhdGNoLgoKU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPgotLS0KIHNvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMgfCAxNCArKysrKysrKysr
KysrKwogMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zb3Vu
ZC9wY2kvaGRhL2hkYV9pbnRlbC5jIGIvc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYwppbmRleCBh
YjZjNGU3YzQ2OGIuLmEwN2NjOGRjYTdkZSAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9oZGFf
aW50ZWwuYworKysgYi9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jCkBAIC0yNTc5LDYgKzI1Nzks
MjAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkIGF6eF9pZHNbXSA9IHsKIAkg
IC5kcml2ZXJfZGF0YSA9IEFaWF9EUklWRVJfQVRJSERNSV9OUyB8IEFaWF9EQ0FQU19QUkVTRVRf
QVRJX0hETUlfTlMgfSwKIAl7IFBDSV9ERVZJQ0UoMHgxMDAyLCAweGFhZjApLAogCSAgLmRyaXZl
cl9kYXRhID0gQVpYX0RSSVZFUl9BVElIRE1JX05TIHwgQVpYX0RDQVBTX1BSRVNFVF9BVElfSERN
SV9OUyB9LAorCXsgUENJX0RFVklDRSgweDEwMDIsIDB4YWFmOCksCisJICAuZHJpdmVyX2RhdGEg
PSBBWlhfRFJJVkVSX0FUSUhETUlfTlMgfCBBWlhfRENBUFNfUFJFU0VUX0FUSV9IRE1JX05TIH0s
CisJeyBQQ0lfREVWSUNFKDB4MTAwMiwgMHhhYjAwKSwKKwkgIC5kcml2ZXJfZGF0YSA9IEFaWF9E
UklWRVJfQVRJSERNSV9OUyB8IEFaWF9EQ0FQU19QUkVTRVRfQVRJX0hETUlfTlMgfSwKKwl7IFBD
SV9ERVZJQ0UoMHgxMDAyLCAweGFiMDgpLAorCSAgLmRyaXZlcl9kYXRhID0gQVpYX0RSSVZFUl9B
VElIRE1JX05TIHwgQVpYX0RDQVBTX1BSRVNFVF9BVElfSERNSV9OUyB9LAorCXsgUENJX0RFVklD
RSgweDEwMDIsIDB4YWIxMCksCisJICAuZHJpdmVyX2RhdGEgPSBBWlhfRFJJVkVSX0FUSUhETUlf
TlMgfCBBWlhfRENBUFNfUFJFU0VUX0FUSV9IRE1JX05TIH0sCisJeyBQQ0lfREVWSUNFKDB4MTAw
MiwgMHhhYjE4KSwKKwkgIC5kcml2ZXJfZGF0YSA9IEFaWF9EUklWRVJfQVRJSERNSV9OUyB8IEFa
WF9EQ0FQU19QUkVTRVRfQVRJX0hETUlfTlMgfSwKKwl7IFBDSV9ERVZJQ0UoMHgxMDAyLCAweGFi
MjApLAorCSAgLmRyaXZlcl9kYXRhID0gQVpYX0RSSVZFUl9BVElIRE1JX05TIHwgQVpYX0RDQVBT
X1BSRVNFVF9BVElfSERNSV9OUyB9LAorCXsgUENJX0RFVklDRSgweDEwMDIsIDB4YWIzOCksCisJ
ICAuZHJpdmVyX2RhdGEgPSBBWlhfRFJJVkVSX0FUSUhETUlfTlMgfCBBWlhfRENBUFNfUFJFU0VU
X0FUSV9IRE1JX05TIH0sCiAJLyogVklBIFZUODI1MS9WVDgyMzdBICovCiAJeyBQQ0lfREVWSUNF
KDB4MTEwNiwgMHgzMjg4KSwgLmRyaXZlcl9kYXRhID0gQVpYX0RSSVZFUl9WSUEgfSwKIAkvKiBW
SUEgR0ZYIFZUNzEyMi9WWDkwMCAqLwotLSAKMi4yMy4wCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZng=
