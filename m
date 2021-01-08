Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4402C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 19:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7901B23A9B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 19:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7901B23A9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 231D36E8AF;
	Fri,  8 Jan 2021 19:30:18 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E82CC6E8AF;
 Fri,  8 Jan 2021 19:30:16 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id l200so12538561oig.9;
 Fri, 08 Jan 2021 11:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hN2mkgW+HJphhCKWgvIr/dGOdsF108ttuU4ip9XRMCc=;
 b=iqNOXjpcMMp9uJQmHyaNujkntxNSOUyuvx9xYyHtzaREYqpXYl2OrhSrjii/mZeucB
 XevzIO4jv7UQYNEwrnBqX+cV8uUGjo3TBxa81fCtog9I+fItgx0/lwI/XQSCoJ72shS0
 yXqfRkb07pwwWZcAGP0VTPlibRTVMEEd01S74mBd9jExxmevCvidMJtlH3Eb7JMeXp67
 lsz6ahcCaEq9qWS7I64Ctn/tYFIJbIGuO/80/xzaS4b82A8914LmmGaRSl4v4k3FHXbj
 Psa+NX4ooz7ZWX/FSudGC6C8zCgkyltZWqW6qyaoHW4sdaxZ5Aunju1yMYT9E9edf9RX
 z7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hN2mkgW+HJphhCKWgvIr/dGOdsF108ttuU4ip9XRMCc=;
 b=SsMKW8dBVovy8+IL84YLMLN3GseMRcUN31CKc+1yqs24RPksgPS/Sx9NeOfpvjxfP8
 oISWXmcFNnQNbyVPE5aXgoM77OCvMcz/Fm0Lkj1QIoLx0liAeZfjFyvRiSzSsZGGN2IL
 qg/+QLiig02/RYcNdeYIRePnH1vBcPf+Mv8FKYpm3t2KXvBPZ8OCWA+sUh1jtGSbuBxB
 XREmPkfdTw8nmrTj6cgZah8o/03+UBLQQP7DKHr8wPNRWPd9C3bsbJLM3DR40GmOx+/a
 DkaweBgrdr3scDrt/XXN0Ac2H8KcIyN74A0WK1DB0dnlRKN/uEG0uDA+gYm+bCg/2ntC
 2F4g==
X-Gm-Message-State: AOAM531UTCHnBUA+VG4nzinnClrKrTmU6aqVeCQmdea3EXdRBVyyZS1B
 NE5jSSnbVXttdfkMO23DIL9HtICeRiF4nRQTivBowcPR
X-Google-Smtp-Source: ABdhPJwbeH/EoTAZkuPYmubT5MG0J9FNPXPeTTnaNOPe+OSXJU1qVcTib8QpQTC7ftqpXQDMZkoEec0MW/rp6aNnY2U=
X-Received: by 2002:aca:4f97:: with SMTP id d145mr3278933oib.123.1610134216205; 
 Fri, 08 Jan 2021 11:30:16 -0800 (PST)
MIME-Version: 1.0
References: <20210105201548.1374211-1-alexander.deucher@amd.com>
In-Reply-To: <20210105201548.1374211-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Jan 2021 14:30:05 -0500
Message-ID: <CADnq5_OSJQEOOF3N5Z3uX1LY=p0xHJYAukPNj7kGn06teJG5Gw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update radeon/amdgpu/amdkfd git trees
To: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Dave Airlie <airlied@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBKYW4gNSwgMjAyMSBhdCAzOjE1IFBNIEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJA
Z21haWwuY29tPiB3cm90ZToKPgo+IEZETyBpcyBvdXQgb2Ygc3BhY2UsIHNvIG1vdmUgdG8gZ2l0
bGFiLgo+Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPgoKUGluZz8gIEFueSBvYmplY3Rpb25zPwoKQWxleAoKPiAtLS0KPiAgTUFJTlRBSU5F
UlMgfCA0ICsrLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTCj4gaW5kZXgg
ZWIxODQ1OWMxZDE2Li5lMjg3N2JlNmIxMGQgMTAwNjQ0Cj4gLS0tIGEvTUFJTlRBSU5FUlMKPiAr
KysgYi9NQUlOVEFJTkVSUwo+IEBAIC05MDcsNyArOTA3LDcgQEAgQU1EIEtGRAo+ICBNOiAgICAg
RmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+Cj4gIEw6ICAgICBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ICBTOiAgICAgU3VwcG9ydGVkCj4gLVQ6ICAgICBnaXQg
Z2l0Oi8vcGVvcGxlLmZyZWVkZXNrdG9wLm9yZy9+YWdkNWYvbGludXgKPiArVDogICAgIGdpdCBo
dHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvYWdkNWYvbGludXguZ2l0Cj4gIEY6ICAgICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkKi5bY2hdCj4gIEY6ICAgICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC8KPiAgRjogICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
aW5jbHVkZS9jaWtfc3RydWN0cy5oCj4gQEAgLTE0NTk2LDcgKzE0NTk2LDcgQEAgTTogICAgICBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gIE06ICAgICBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gIEw6ICAgICBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwo+ICBTOiAgICAgU3VwcG9ydGVkCj4gLVQ6ICAgICBnaXQgZ2l0
Oi8vcGVvcGxlLmZyZWVkZXNrdG9wLm9yZy9+YWdkNWYvbGludXgKPiArVDogICAgIGdpdCBodHRw
czovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvYWdkNWYvbGludXguZ2l0Cj4gIEY6ICAgICBkcml2
ZXJzL2dwdS9kcm0vYW1kLwo+ICBGOiAgICAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi8KPiAgRjog
ICAgIGluY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oCj4gLS0KPiAyLjI5LjIKPgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
