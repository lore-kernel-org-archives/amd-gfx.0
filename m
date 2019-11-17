Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E0BC432C3
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 08:37:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B629206A4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 08:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B629206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAADE6E07B;
	Mon, 18 Nov 2019 08:37:07 +0000 (UTC)
X-Greylist: delayed 459 seconds by postgrey-1.36 at gabe;
 Sun, 17 Nov 2019 17:30:36 UTC
Received: from mta-p6.oit.umn.edu (mta-p6.oit.umn.edu [134.84.196.206])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CB9C89C54
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 Nov 2019 17:30:36 +0000 (UTC)
Received: from localhost (unknown [127.0.0.1])
 by mta-p6.oit.umn.edu (Postfix) with ESMTP id 634CFB61
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 Nov 2019 17:22:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
 by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zrNk0VZKmbjZ for <amd-gfx@lists.freedesktop.org>;
 Sun, 17 Nov 2019 11:22:56 -0600 (CST)
Received: from mail-yw1-f70.google.com (mail-yw1-f70.google.com
 [209.85.161.70])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 356C3837
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 Nov 2019 11:22:56 -0600 (CST)
Received: by mail-yw1-f70.google.com with SMTP id s128so11058412ywf.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 Nov 2019 09:22:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=RIby2qRx5cEwNIrcIoDIHdDJ6ejQhdeyp3owCLM8obk=;
 b=er2rVKfDhk2nUhCvEADF9Ub2gAh4tQfh2qiFHnh0egBIZuvmUlp2BR3Tks/E7OewmS
 gUWxgmOJEvzUYH+D6hXXhzbxYj2kYnAd8ycOySgLf2flr7zTvMQi/fc+7+go6CQgcB/D
 pUAM+36FnWWdjQ88KtFvnx0pf8X6j2RvYa8Mbb5xp4z9v1Yw0EjVKG89/ngcxTMcwnji
 FFf6BMdgEpRqBVaaZV3OuvgkEnhq7f9C751ILqe2I/y53hyO9LHal86FfEWKxnKG7tF7
 e0lWHWZxn7k9zM7ZOfm4L9NXo3j0lxOLoPk1oME345L+k5uoNGDJqh85dbW+sNeO9E3k
 pWaQ==
X-Gm-Message-State: APjAAAV+bXxEpMTcCnfMfpix878I/k+6MCejfRmpjPdK70Br3Om8y+zW
 3LdTqAn9clAkssCYuSVv5WNT6fFpeCYWk4FQG18qgatCJBOdwc8wPGV0jaWEHyWia112Vn9fGiy
 KN300Mjt7pfifbxvUZ9t+cM6cl5hRDg==
X-Received: by 2002:a81:71c4:: with SMTP id
 m187mr16741537ywc.327.1574011375500; 
 Sun, 17 Nov 2019 09:22:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqwRSZyGvEeTEQTqYLBwcl2GMjbN83a4HUDRBI+2xrk9iViMa5K8z+axNVTrtuWEQ1cR/lc6Mw==
X-Received: by 2002:a81:71c4:: with SMTP id
 m187mr16741510ywc.327.1574011375242; 
 Sun, 17 Nov 2019 09:22:55 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu.
 [128.101.106.66])
 by smtp.gmail.com with ESMTPSA id 124sm6654970ywo.98.2019.11.17.09.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2019 09:22:54 -0800 (PST)
From: Aditya Pakki <pakki001@umn.edu>
To: pakki001@umn.edu
Subject: [PATCH] drm/amd/display: Fix error returned by program_hpd_filter
Date: Sun, 17 Nov 2019 11:22:34 -0600
Message-Id: <20191117172236.2140-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Mon, 18 Nov 2019 08:37:06 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=umn.edu; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=RIby2qRx5cEwNIrcIoDIHdDJ6ejQhdeyp3owCLM8obk=;
 b=IRanUKstwT1MnUfDW4znsizornJMbx0pRICZZKzplIGIiA3OJ+MupXA0DK7QXt6M9c
 hLWZAgq6YTjDz4dClo6XI8qh6O0AEshigJzSARu8dQPCU/R2YI+MPH1d8HMEVvptX2LP
 2CqovGn7TmSCS387hLEScYeCaCvqJ7vdrnljOcqfc19SjC6HnDNMpXbGuCNHzOtb4iDh
 bzFKDt1m+gnvDulkJgW4pgrRQ6i895IiisubEZ7hz9iMljjm1AQWK17ZTWMch9u/EvYT
 NccpkOgcjITRXlYagZbOT2+7he8di4ZPpkTv9UfOdlWEinhxUTaz056LWuOkx75Bq4gO
 mg0A==
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
Cc: dri-devel@lists.freedesktop.org,
 "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Chris Park <Chris.Park@amd.com>, Eric Yang <Eric.Yang2@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 David Francis <David.Francis@amd.com>, kjlu@umn.edu,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Nikola Cornij <nikola.cornij@amd.com>, David Airlie <airlied@linux.ie>,
 Eric Bernstein <eric.bernstein@amd.com>, David Galiffi <david.galiffi@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Wenjing Liu <Wenjing.Liu@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191117172234.J05_sSjQbysIwU-cG2-LSAJn_zv3MthNZo8tNY1oSp8@z>

cHJvZ3JhbV9ocGRfZmlsdGVyKCkgY3VycmVudGx5IGZhaWxzIHRvIGNoZWNrIGZvciB0aGUgZXJy
b3JzCnJldHVybmVkIGluIGNvbnN0cnVjdCgpLiBUaGlzIHBhdGNoIHJldHVybnMgZXJyb3IgaW4K
Y2FzZSBvZiBmYWlsdXJlLgoKU2lnbmVkLW9mZi1ieTogQWRpdHlhIFBha2tpIDxwYWtraTAwMUB1
bW4uZWR1PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsu
YyB8IDMgKy0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlu
ay5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jCmluZGV4
IGNhMjBiMTUwYWZjYy4uYmJiNjQ4YTUwYzQxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2NvcmUvZGNfbGluay5jCkBAIC0xMzc5LDkgKzEzNzksOCBAQCBzdGF0aWMgYm9v
bCBjb25zdHJ1Y3QoCiAJICogSWYgR1BJTyBpc24ndCBwcm9ncmFtbWVkIGNvcnJlY3RseSBIUEQg
bWlnaHQgbm90IHJpc2Ugb3IgZHJhaW4KIAkgKiBmYXN0IGVub3VnaCwgbGVhZGluZyB0byBib3Vu
Y2VzLgogCSAqLwotCXByb2dyYW1faHBkX2ZpbHRlcihsaW5rKTsKKwlyZXR1cm4gcHJvZ3JhbV9o
cGRfZmlsdGVyKGxpbmspOwogCi0JcmV0dXJuIHRydWU7CiBkZXZpY2VfdGFnX2ZhaWw6CiAJbGlu
ay0+bGlua19lbmMtPmZ1bmNzLT5kZXN0cm95KCZsaW5rLT5saW5rX2VuYyk7CiBsaW5rX2VuY19j
cmVhdGVfZmFpbDoKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
