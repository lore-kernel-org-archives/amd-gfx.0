Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CBDC3B186
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 15:36:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BAE2051A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 15:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PZrTbH4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BAE2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90D136EE8E;
	Tue, 11 Feb 2020 15:36:45 +0000 (UTC)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2AC46EE8E
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 15:36:44 +0000 (UTC)
Received: by mail-oi1-x244.google.com with SMTP id d62so13125410oia.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 07:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ipEWWYr9/eLlFb7q0DH1x9u4DERV5h2Ut2vjlsb97T4=;
 b=PZrTbH4ZRemzANrNVekBqrzonjwge4/k/DY0vQ9IgVXIcdNVuMcvbQeGmoS0Ad6MTj
 XC/aHF0aINm0nsaoWU5AW87fKZ4m3OZftvnk/FXqP6RUJRPyR4qCYdIuYe/jLIBNiHDn
 PDUEQNqsrR7pPxRvgWPA6Jg5cKDtVTD7ln/NM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ipEWWYr9/eLlFb7q0DH1x9u4DERV5h2Ut2vjlsb97T4=;
 b=M3gL2vImLvuTuoaqEXN8VMT7Hu0CAiGlHJBMHsFzGgtBltE7/tRSQjgb1aH+i8XudV
 zEXdebqWAf9giSyzksosin4Ll+bq9KJzGLsAXpr/ZkPbWwIxtTh/37M+TRm3KfN2z1hs
 U3aAgDJsuwMhIIF6QgxC1WughooyJd6f5KPrGzVvmozQCfJ0Fi8UduMrL89OuoFuG6Rn
 PrOoyQitYwjxmlrdLyGbg+Dy3UrA9AxlNCT9MFdhAD1AR/zM+1x7fZuQtmO20pkUeAb4
 /oFJGximd9/KKQKcz4v8CU2DBxlZcV+npFXoVtpr8O+KlCEaoan3TykpdyGuv8iVaKS8
 r0dg==
X-Gm-Message-State: APjAAAU/fi+myl5JKzfhyL6XWzzIpbQtpKOX9kpYhKnfoMDfiotXdH4d
 mSWsFbOLbjynLqb8YpGSXdVKfs9nN0pnUR1x7hX58g==
X-Google-Smtp-Source: APXvYqzWm30sMcn2QVFRjnVtsqgXRf07wCd6EmjjmFtpmdXPHZgZmTWjAD16+M5EC4GHXUOl3eLuU1h8R5OHvYcu6Fo=
X-Received: by 2002:a05:6808:319:: with SMTP id
 i25mr3262592oie.128.1581435403921; 
 Tue, 11 Feb 2020 07:36:43 -0800 (PST)
MIME-Version: 1.0
References: <20200210150907.20616-1-christian.koenig@amd.com>
 <20200210150907.20616-6-christian.koenig@amd.com>
 <20200211141402.GB2363188@phenom.ffwll.local>
 <11341C05-E5C8-47C6-A77D-F3B3380453AA@amd.com>
 <fef6b329-92f0-3b06-502b-22120caf1a98@gmail.com>
In-Reply-To: <fef6b329-92f0-3b06-502b-22120caf1a98@gmail.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 11 Feb 2020 16:36:32 +0100
Message-ID: <CAKMK7uFb_0=jUZbXRZB9nd+z0FmOqtaaAttS_Uts=5Zose3sQg@mail.gmail.com>
Subject: Re: [PATCH 5/6] drm/ttm: replace dma_resv object on deleted BOs v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBGZWIgMTEsIDIwMjAgYXQgNDoyMyBQTSBDaHJpc3RpYW4gS8O2bmlnCjxja29lbmln
LmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBBbSAxMS4wMi4yMCB1bSAxNjow
MiBzY2hyaWViIFBhbiwgWGluaHVpOgo+ID4KPiA+PiAyMDIw5bm0MuaciDEx5pelIDIyOjE077yM
RGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPiDlhpnpgZPvvJoKPiA+Pgo+ID4+IE9uIE1v
biwgRmViIDEwLCAyMDIwIGF0IDA0OjA5OjA2UE0gKzAxMDAsIENocmlzdGlhbiBLw7ZuaWcgd3Jv
dGU6Cj4gPj4+IFdoZW4gbm9uLWltcG9ydGVkIEJPcyBhcmUgcmVzdXJyZWN0ZWQgZm9yIGRlbGF5
ZWQgZGVsZXRlIHdlIHJlcGxhY2UKPiA+Pj4gdGhlIGRtYV9yZXN2IG9iamVjdCB0byBhbGxvdyBm
b3IgZWFzeSByZWNsYWltaW5nIG9mIHRoZSByZXNvdXJjZXMuCj4gPj4+Cj4gPj4+IHYyOiBtb3Zl
IHRoYXQgdG8gdHRtX2JvX2luZGl2aWR1YWxpemVfcmVzdgo+ID4+Pgo+ID4+PiBTaWduZWQtb2Zm
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gPj4+IC0t
LQo+ID4+PiBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jIHwgMTAgKysrKysrKysrLQo+ID4+
PiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPj4+Cj4g
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jIGIvZHJpdmVycy9n
cHUvZHJtL3R0bS90dG1fYm8uYwo+ID4+PiBpbmRleCBkMDYyNDY4NWY1ZDIuLjRkMTYxMDM4ZGU5
OCAxMDA2NDQKPiA+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYwo+ID4+PiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jCj4gPj4+IEBAIC0zOTMsNiArMzkzLDE0
IEBAIHN0YXRpYyBpbnQgdHRtX2JvX2luZGl2aWR1YWxpemVfcmVzdihzdHJ1Y3QgdHRtX2J1ZmZl
cl9vYmplY3QgKmJvKQo+ID4+Pgo+ID4+PiAgICAgciA9IGRtYV9yZXN2X2NvcHlfZmVuY2VzKCZi
by0+YmFzZS5fcmVzdiwgYm8tPmJhc2UucmVzdik7Cj4gPj4+ICAgICBkbWFfcmVzdl91bmxvY2so
JmJvLT5iYXNlLl9yZXN2KTsKPiA+Pj4gKyAgIGlmIChyKQo+ID4+PiArICAgICAgICAgICByZXR1
cm4gcjsKPiA+Pj4gKwo+ID4+PiArICAgaWYgKGJvLT50eXBlICE9IHR0bV9ib190eXBlX3NnKSB7
Cj4gPj4+ICsgICAgICAgICAgIHNwaW5fbG9jaygmdHRtX2JvX2dsb2IubHJ1X2xvY2spOwo+ID4+
PiArICAgICAgICAgICBiby0+YmFzZS5yZXN2ID0gJmJvLT5iYXNlLl9yZXN2Owo+ID4+IEhhdmlu
ZyB0aGUgZG1hX3Jlc3YgcG9pbnRlciBiZSBwcm90ZWN0ZWQgYnkgdGhlIGxydV9sb2NrIGZvciB0
dG0gaW50ZXJuYWwKPiA+PiBzdHVmZiwgYnV0IGludmFyaWFudCBldmVyeXdoZXJlIGVsc2UgaXMg
cmVhbGx5IGNvbmZ1c2luZy4gTm90IHN1cmUgdGhhdCdzCj4gPiBJIHRoaW5rIHRoaXMgaXMgcmVh
ZGVyIFZTIHdyaXRlci4KPiA+IFRvIGF2b2lkIGFueSBpbnRlcm5hbCBmdW5jdGlvbnMgdXNpbmcg
dGhlIG9sZCByZXN2LCAgdXNpbmcgYW4gZXhpc3Rpbmcgc3BpbiBsb2NrIGlzIGFjY2VwdGFibGUu
Cj4gPiBNYXliZSBSQ1UgaXMgYmV0dGVyPyBUaGF0IHdpbGwgbmVlZCBhIGxvdCBvZiBlZmZvcnQu
Cj4gPiBBbnl3YXksIHR0bSBzdWNrcy4gV2UgSEFTIGRvbmUgYSBsb3Qgb2Ygd29yayBvbiBpdCB0
byBtYWtlIGl0IGJldHRlciBydW5uaW5nIG9uIG1vZGVybiBzeXN0ZW0uCj4KPiBZZWFoIHRoYXQg
c3VtbWFyaXplIG15IHJlY2VudCBwcmVzZW50YXRpb24gYWJvdXQgVFRNIHByZXR0eSBtdWNoIDop
Cj4KPiBEb3VibGUgY2hlY2tlZCB0aGF0IGFuZCB0aGUgb25seSByZWFzb24gd2UgaGF2ZSB0aGUg
bG9jayBpcyB0aGF0IGluCj4gdHRtX21lbV9ldmljdF9maXJzdCgpIHdlIHRyeWxvY2sgZmlyc3Qg
YW5kIHRoZW4gZ3JhYiBhIHJlZmVyZW5jZS4KCldlbGwgZXZlbiB3aXRoIHRoZSByZWZjb3VudCBz
dHVmZiBnb2luZyBvbiBJIHRoaW5rIHlvdSdyZSBtaXNzaW5nIGEKcGlsZSBvZiBiYXJyaWVycyBp
ZiB5b3UgZHJvcCB0aGUgc3BpbmxvY2suIFJlZmNvdW50cyBhcmUgb3RoZXJ3aXNlCnVub3JkZXJl
ZCBhdG9taWNzIChhbmQgdGhlIGtyZWZfZ2V0X3VubGVzc196ZXJvIHRyaWNrIGFsd2F5cyBuZWVk
cwpzb21ldGhpbmcgZWxzZSB0aGF0IGd1YXJhbnRlZXMgdGhhdCB0aGVyZSdzIGF0IGxlYXN0IGEg
d2VhayByZWZlcmVuY2UsCmkuZS4gc29tZXRoaW5nIHdoaWNoIGNhdXNlIGEgZnVsbCBzeW5jaHJv
bml6YXRpb24gc29tZWhvdyB3aXRoIHRoZQpyZWxlYXNlL2ZyZWUgY29kZSBmb3IgdGhhdCB0aGlu
ZykuIFNvIHdvdWxkIG1pbmltYWxseSBuZWVkcyByY3UsIG9yCmxpa2UgeW91IGRvIGhlcmUgdGhl
IGxydSBsaXN0IHNwaW5sb2NrLgoKPiBTbyB3ZSBzaG91bGQgcHJvYmFibHkgcmV3b3JrIHRoYXQg
Y29kZSBhcyB3ZWxsIGFuZCB0aGVuIHdlIGNhbiBhbHNvIGRyb3AKPiB0aGF0IGxvY2sgaGVyZSwg
YnV0IHRoYXQgc2hvdWxkIGNvbWUgbGF0ZXIuCgpfSWZfIHRoZSB0cnlsb2NrIGluIGV2aWN0IGlz
IHRoZSBvbmx5IG9uZSB0aGVuIEkgYWdyZWUgdGhpcyBzaG91bGQgYmUKc2FmZS4gQnV0IGRlZmlu
aXRlbHkgbmVlZHMgYSBjb21tZW50IGV4cGxhaW5pbmcgd2hhdCBleGFjdGx5IGlzIGdvaW5nCm9u
LiBJbW8gYXQgbGVhc3QgOi0pCgpDaGVlcnMsIERhbmllbAo+Cj4gQ2hyaXN0aWFuLgo+Cj4gPgo+
ID4KPiA+PiBhIGdyZWF0IGlkZWEsIEkndmUganVzdCBjaGFzZWQgc29tZSB0dG0gY29kZSBhcm91
bmQgZnJlYWtpbmcgb3V0IGFib3V0Cj4gPj4gdGhhdC4KPiA+PiAtRGFuaWVsCj4gPj4KPiA+Pj4g
KyAgICAgICAgICAgc3Bpbl91bmxvY2soJnR0bV9ib19nbG9iLmxydV9sb2NrKTsKPiA+Pj4gKyAg
IH0KPiA+Pj4KPiA+Pj4gICAgIHJldHVybiByOwo+ID4+PiB9Cj4gPj4+IEBAIC03MjAsNyArNzI4
LDcgQEAgc3RhdGljIGJvb2wgdHRtX2JvX2V2aWN0X3N3YXBvdXRfYWxsb3dhYmxlKHN0cnVjdCB0
dG1fYnVmZmVyX29iamVjdCAqYm8sCj4gPj4+Cj4gPj4+ICAgICBpZiAoYm8tPmJhc2UucmVzdiA9
PSBjdHgtPnJlc3YpIHsKPiA+Pj4gICAgICAgICAgICAgZG1hX3Jlc3ZfYXNzZXJ0X2hlbGQoYm8t
PmJhc2UucmVzdik7Cj4gPj4+IC0gICAgICAgICAgIGlmIChjdHgtPmZsYWdzICYgVFRNX09QVF9G
TEFHX0FMTE9XX1JFU19FVklDVCB8fCBiby0+ZGVsZXRlZCkKPiA+Pj4gKyAgICAgICAgICAgaWYg
KGN0eC0+ZmxhZ3MgJiBUVE1fT1BUX0ZMQUdfQUxMT1dfUkVTX0VWSUNUKQo+ID4+PiAgICAgICAg
ICAgICAgICAgICAgIHJldCA9IHRydWU7Cj4gPj4+ICAgICAgICAgICAgICpsb2NrZWQgPSBmYWxz
ZTsKPiA+Pj4gICAgICAgICAgICAgaWYgKGJ1c3kpCj4gPj4+IC0tCj4gPj4+IDIuMTcuMQo+ID4+
Pgo+ID4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
ID4+PiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4gPj4+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKPiA+Pj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29r
LmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUy
Rmxpc3RpbmZvJTJGZHJpLWRldmVsJmFtcDtkYXRhPTAyJTdDMDElN0NYaW5odWkuUGFuJTQwYW1k
LmNvbSU3Q2VlNjczMTBlMjZiNjRjYTllNzkwMDhkN2FlZmNhN2I0JTdDM2RkODk2MWZlNDg4NGU2
MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzE3MDI3MjQ4MTc2NTkwNCZhbXA7c2RhdGE9
WnBuUDlNTkJQMWNzUUNLUFIyNzVlakl2c1ozYjh4TDgwdG1TbHBmN01QQSUzRCZhbXA7cmVzZXJ2
ZWQ9MAo+ID4+IC0tCj4gPj4gRGFuaWVsIFZldHRlcgo+ID4+IFNvZnR3YXJlIEVuZ2luZWVyLCBJ
bnRlbCBDb3Jwb3JhdGlvbgo+ID4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24u
b3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGYmxvZy5mZndsbC5jaCZhbXA7ZGF0YT0wMiU3
QzAxJTdDWGluaHVpLlBhbiU0MGFtZC5jb20lN0NlZTY3MzEwZTI2YjY0Y2E5ZTc5MDA4ZDdhZWZj
YTdiNCU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcxNzAy
NzI0ODE3NjU5MDQmYW1wO3NkYXRhPWZrMjhqdEhoQW5FMzEyQ0ZNZ1ZYYVp0YVMyWU5xSmpteUoz
MTdGV2pBb00lM0QmYW1wO3Jlc2VydmVkPTAKPgoKCi0tIApEYW5pZWwgVmV0dGVyClNvZnR3YXJl
IEVuZ2luZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbgorNDEgKDApIDc5IDM2NSA1NyA0OCAtIGh0dHA6
Ly9ibG9nLmZmd2xsLmNoCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
