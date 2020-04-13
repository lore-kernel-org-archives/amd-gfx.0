Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94910C2BA2B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 20:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F7520663
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 20:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4XmIB4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F7520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F210589017;
	Mon, 13 Apr 2020 20:32:58 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C544089017
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 20:32:57 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id g12so3565045wmh.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 13:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VHyZiYA676dJWadtk//Gbi2JxqtYLwKnni1xJSRLYtc=;
 b=Y4XmIB4Skh5rQCuoGrzPfIDpo8/lkDlsHJwV8/ea+oHgL55qWVnbJ2qCUzUaYRVlrP
 GE4ApqMzuVpLcl7Xv4qrVHtVopWEgV6SKujXO+B2g4NmVndv68/TfMzlwLQ/aORI+uQL
 rzrtzD7C5qLaeGExDjzmY2nivbFXS0HLNJASclnO+qoHC6rDJjT4wXHFsgDJt8wUECLR
 /ByCLJgK7Dxk8I1LzyHqxSvzKp5dJsrDC0rHePc8vb5qaRbc391pf6Y/PEpBoGpMlhh1
 zHPxPtVYGrB/oxHuAadymxQqghpDXdRiL4w7zsoXqqW0roxDikGFwNUQ2CSf+D4ccJ4F
 dAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VHyZiYA676dJWadtk//Gbi2JxqtYLwKnni1xJSRLYtc=;
 b=hnTQZTQWBfZ0CjoQiomZxLcS65TDXr8rJARMp7plxDxZr8p6Pw291gMUZhN16ARLAG
 JDZns/tAH5mpvCuzNyo7tHXoSVKZmlWqJAdvwviaYY6bSbmlqhAcklru88Ij1IZWbyIx
 njluewiXktRvgLyN4y6+FTYvImLEseGB73bgu8joS7viKMBYJnUcpQkxDS8gvX/xoQ2g
 bXDkUxdAuor2g7v6bkcPi7m+0/j4vJEQAqDilLN6er+pRpy9XSTg/s7Bzj328QfxMkQx
 vE71e2e80gtPvBPiOrEVWjG+EBqTrCjzr4Co4HxLxFS/aOjXjWkPOojiFDuY8EkHEzPx
 rgaQ==
X-Gm-Message-State: AGi0Pub+HzQn62w/1SEJDjr7qAnswfyBd+nqAv8OGmYrD1P2zrLn0Apx
 yQNI6e5yC8wNjkHwAqJcFlkQuP7lWK4618YdIjTyfP+T
X-Google-Smtp-Source: APiQypIqwPKAJmC47Kck5tH0aRh73SFRq16jrQyMMAYqqx9uo611xhXWsooP3EhcZLmi7PCh6VKehDvQeQD81n71o1g=
X-Received: by 2002:a1c:9d8c:: with SMTP id g134mr20887708wme.79.1586809976441; 
 Mon, 13 Apr 2020 13:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <1586790530-19464-1-git-send-email-Prike.Liang@amd.com>
 <CADnq5_Os9ePu+u0cmroyKRVyXroYD9Bggyy0Do1mWW18m5-Pbg@mail.gmail.com>
 <1dce548a-c6ea-183c-4c33-6b8f6bc3c6c8@molgen.mpg.de>
In-Reply-To: <1dce548a-c6ea-183c-4c33-6b8f6bc3c6c8@molgen.mpg.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Apr 2020 16:32:45 -0400
Message-ID: <CADnq5_PSiUFG1uYYhFPs_-ukydHG=ErkBdg3sf6LcMNimY-zQg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix the hw hang during perform system reboot
 and reset
To: Paul Menzel <pmenzel+amd-gfx@molgen.mpg.de>
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
Cc: Johannes Hirte <johannes.hirte@datenkhaos.de>,
 Xinhui Pan <Xinhui.Pan@amd.com>, Rahul Kumar <Rahul.Kumar1@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Prike Liang <Prike.Liang@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBBcHIgMTMsIDIwMjAgYXQgMjoxNyBQTSBQYXVsIE1lbnplbAo8cG1lbnplbCthbWQt
Z2Z4QG1vbGdlbi5tcGcuZGU+IHdyb3RlOgo+Cj4gRGVhciBBbGV4LCBkZWFyIFByaWtlLAo+Cj4K
PiBBbSAxMy4wNC4yMCB1bSAxNzoxNCBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiA+IE9uIE1vbiwg
QXByIDEzLCAyMDIwIGF0IDExOjA5IEFNIFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29t
PiB3cm90ZToKPiA+Pgo+ID4+IFVuaWZ5IHNldCBkZXZpY2UgQ0dQRyB0byB1bmdhdGUgc3RhdGUg
YmVmb3JlIGVudGVyIHBvd2Vyb2ZmIG9yIHJlc2V0Lgo+ID4+Cj4gPj4gU2lnbmVkLW9mZi1ieTog
UHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+Cj4gPj4gVGVzdGVkLWJ5OiBNZW5nYmlu
ZyBXYW5nIDxNZW5nYmluZy5XYW5nQGFtZC5jb20+Cj4gPgo+ID4gQWNrZWQtYnk6IEFsZXggRGV1
Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPgo+IEZpcnN0Ogo+Cj4gVGVzdGVkLWJ5
OiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPiAoTVNJIEIzNTBNIE1PUlRBUgo+
IChNUy03QTM3KSB3aXRoIGFuIEFNRCBSeXplbiAzIDIyMDBHKQo+Cj4gU2Vjb25kLCBJIGFtIGhh
dmluZyB0cm91YmxlIHRvIHVuZGVyc3RhbmQsIGhvdyB5b3UgY2FuIGFkZCB5b3VyIEFja2VkLWJ5
Cj4gdGFnIHRvIGEgY29tbWl0IHdpdGggc3VjaCBhIGNvbW1pdCBtZXNzYWdlPwo+Cj4gVGhlIHBy
b2JsZW0gaXMgbm90IGRlc2NyaWJlZCAoYXBwYXJlbnRseSBpdCBvbmx5IGFmZmVjdGVkIGNlcnRh
aW4KPiBkZXZpY2VzKSwgaXQgaXMgbm90IG1lbnRpb25lZCB0aGF0IGl04oCZcyBhIHJlZ3Jlc3Np
b24gKEZpeGVzOiB0YWcvbGluZSBpcwo+IG1pc3NpbmcpLCBhbmQgSSBhbSBoYXZpbmcgYSBoYXJk
IHRpbWUgdG8gdW5kZXJzdGFuZCB0aGUgY29tbWl0IG1lc3NhZ2UKPiBhdCBhbGwgKGFuZCB0aGUg
b25lIGZyb20gdGhlIGNvbW1pdCBpbnRyb2R1Y2luZyB0aGUgcmVncmVzc2lvbikuIFdoeSBpcwo+
IGl0IG1vcmUgb3IgbGVzcyByZXZlcnRpbmcgcGFydCBvZiB0aGUgb3RoZXIgY29tbWl0LCB3aGls
ZSB0aGUgaXNzdWUgd2FzCj4gbm90IHJlcHJvZHVjaWJsZSBvbiBQcmlrZeKAmXMgc3lzdGVtPwoK
VGhlIG9yaWdpbmFsIGlzc3VlIHdhcyB0aGF0IHdlIHdlcmUgbm90IHByb3Blcmx5IHVuZ2F0aW5n
IHNvbWUgb2YgdGhlCmh3IGJsb2NrcyBpbiB0aGUgcmlnaHQgb3JkZXIgZm9yIFMzIHN1c3BlbmQg
b24gcmVub2lyLiAgU28gdGhlIGZpeCB3YXMKdG8gYWRkIHVuZ2F0ZSBjYWxscyB0byBhbWRncHVf
ZGV2aWNlX3N1c3BlbmQoKSB0byBoYW5kbGUgdGhhdCBjYXNlLgpIb3dldmVyLCB0aGUgb3JpZ2lu
YWwgZml4IHNob3VsZCBub3QgaGF2ZSByZW1vdmVkIHRoZSBjYWxscyBmcm9tCmFtZGdwdV9kZXZp
Y2VfaXBfc3VzcGVuZF9waGFzZTEoKSBzaW5jZSB0aGF0IGlzIGNhbGxlZCBzZXBhcmF0ZWx5IGZv
cgpzb21lIG90aGVyIHVzZSBjYXNlcyAoZS5nLiwgcGNpIHNodXRkb3duKS4gIEl0IGRpZG4ndCBt
YXR0ZXIgZm9yIHNvbWUKYXNpY3MgYXMgdGhleSBkb24ndCBoYXZlIGRpZmZlcmVudCBsZXZlbHMg
b2YgcG93ZXJnYXRpbmcKZnVuY3Rpb25hbGl0eS4gIEknbGwgYWRkIHRoZSBmaXhlcyB0YWcgYmVm
b3JlIHRoZSBwYXRjaCBnb2VzIHVwc3RyZWFtLgoKQWxleAoKPgo+ID4+IC0tLQo+ID4+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMiArKwo+ID4+ICAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+ID4+Cj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+ID4+IGluZGV4IDg3ZjdjMTIuLmJiZTA5MGEgMTAw
NjQ0Cj4gPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
Cj4gPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4g
Pj4gQEAgLTI0MTMsNiArMjQxMyw4IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RldmljZV9pcF9zdXNw
ZW5kX3BoYXNlMShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiA+PiAgIHsKPiA+PiAgICAg
ICAgICBpbnQgaSwgcjsKPiA+Pgo+ID4+ICsgICAgICAgYW1kZ3B1X2RldmljZV9zZXRfcGdfc3Rh
dGUoYWRldiwgQU1EX1BHX1NUQVRFX1VOR0FURSk7Cj4gPj4gKyAgICAgICBhbWRncHVfZGV2aWNl
X3NldF9jZ19zdGF0ZShhZGV2LCBBTURfQ0dfU1RBVEVfVU5HQVRFKTsKPiA+Pgo+ID4+ICAgICAg
ICAgIGZvciAoaSA9IGFkZXYtPm51bV9pcF9ibG9ja3MgLSAxOyBpID49IDA7IGktLSkgewo+ID4+
ICAgICAgICAgICAgICAgICAgaWYgKCFhZGV2LT5pcF9ibG9ja3NbaV0uc3RhdHVzLnZhbGlkKQo+
ID4+IC0tCj4gPj4gMi43LjQKPgo+IEtpbmQgcmVnYXJkcywKPgo+IFBhdWwKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
