Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF049C5DF60
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 22:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A544B2067B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 22:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A544B2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 666DD6F7EB;
	Thu,  7 Nov 2019 22:30:14 +0000 (UTC)
Received: from mail-vs1-f68.google.com (mail-vs1-f68.google.com
 [209.85.217.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D7526F7EB;
 Thu,  7 Nov 2019 22:30:13 +0000 (UTC)
Received: by mail-vs1-f68.google.com with SMTP id y23so2467571vso.1;
 Thu, 07 Nov 2019 14:30:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bQ0SrO3dITmGH2wZR3g08xc5evdpWQ6iyAkniXzubyc=;
 b=YvtyuA9dMtorxW83AUSO/8HbZwCyhoB15TYVOW6aVZs3gC/MB2iWoaFsdjkL5BCfY6
 1OPtVaR1YsbVqdNf/xZryXI8cFHdQFaG6xfJO8d9ZLQ//sRzwwVt/XkLzEAVBJcHiIuV
 EVHgvaCf1Zwo39GIECovBqFPh4wUUQytzAJHqjWkxur8vB4l2R1qDYaPWu3i58pcKIjF
 ROdeTxG4cp9a8K0nvA1vipjq78dJkPt+xRkC8vz3D7iu7T1r2ZRquoX2X+Yl6kwKufQ2
 UoScB/M+7JC7epI/Aol3MXrJML6yINkTlgY5oJdcsWlvYSUdlREmUe3/g6JVpSgiR7wQ
 eFKg==
X-Gm-Message-State: APjAAAUjmyiQyUalY/mhUDTYtPqD/ajHxLTSsi5BhoYv92gCrHxizlO6
 z/AJClFCDdpJixtNYBzh3T3ranV2elq4xxLkhHs=
X-Google-Smtp-Source: APXvYqx+0YYj1qicJQzcMmSuWAbQhYtQOfKUaHzL7hihlQo4nKnVfbKr51BSFP9Wu+thLR0rcwMoi5j6PGWSsYVAAVY=
X-Received: by 2002:a67:2e90:: with SMTP id u138mr5178874vsu.207.1573165811657; 
 Thu, 07 Nov 2019 14:30:11 -0800 (PST)
MIME-Version: 1.0
References: <20191107222047.125496-1-helgaas@kernel.org>
 <20191107222047.125496-2-helgaas@kernel.org>
In-Reply-To: <20191107222047.125496-2-helgaas@kernel.org>
From: Ilia Mirkin <imirkin@alum.mit.edu>
Date: Thu, 7 Nov 2019 17:30:00 -0500
Message-ID:
 <CAKb7Uvjj+18cAFW+yBEHWkJLXVTHVMW=zJ-V+uqpzdbcEKsHrQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: replace Compliance/Margin magic numbers with
 PCI_EXP_LNKCTL2 definitions
To: Bjorn Helgaas <helgaas@kernel.org>
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
Cc: David Zhou <David1.Zhou@amd.com>, Frederick Lawler <fred@fredlawl.com>,
 David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107223000.ckyy7zmpPf1gtBPr5TZDfonD1T9dyvOuARf-OqMeFo0@z>

T24gVGh1LCBOb3YgNywgMjAxOSBhdCA1OjIxIFBNIEJqb3JuIEhlbGdhYXMgPGhlbGdhYXNAa2Vy
bmVsLm9yZz4gd3JvdGU6Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9wY2lfcmVn
cy5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3BjaV9yZWdzLmgKPiBpbmRleCAyOWQ2ZTkzZmQxNWUu
LjAzNDQ2YmU4YTdiZSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvcGNpX3JlZ3Mu
aAo+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9wY2lfcmVncy5oCj4gQEAgLTY3Myw2ICs2NzMs
OCBAQAo+ICAjZGVmaW5lICBQQ0lfRVhQX0xOS0NUTDJfVExTXzhfMEdUICAgICAweDAwMDMgLyog
U3VwcG9ydGVkIFNwZWVkIDhHVC9zICovCj4gICNkZWZpbmUgIFBDSV9FWFBfTE5LQ1RMMl9UTFNf
MTZfMEdUICAgIDB4MDAwNCAvKiBTdXBwb3J0ZWQgU3BlZWQgMTZHVC9zICovCj4gICNkZWZpbmUg
IFBDSV9FWFBfTE5LQ1RMMl9UTFNfMzJfMEdUICAgIDB4MDAwNSAvKiBTdXBwb3J0ZWQgU3BlZWQg
MzJHVC9zICovCj4gKyNkZWZpbmUgIFBDSV9FWFBfTE5LQ1RMMl9FTlRFUl9DT01QICAgIDB4MDAx
MCAvKiBFbnRlciBDb21wbGlhbmNlICovCj4gKyNkZWZpbmUgIFBDSV9FWFBfTE5LQ1RMMl9UWF9N
QVJHSU4gICAgIDB4MDM4MCAvKiBFbnRlciBDb21wbGlhbmNlICovCgpXaXRob3V0IGNvbW1lbnRp
bmcgb24gdGhlIG1lYXQgb2YgdGhlIHBhdGNoLCB0aGlzIGNvbW1lbnQgc2hvdWxkCnByb2JhYmx5
IHJlYWQgIlRyYW5zbWl0IE1hcmdpbiIgb3Igc29tZXRoaW5nIGFsb25nIHRob3NlIGxpbmVzPwoK
ICAtaWxpYQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
