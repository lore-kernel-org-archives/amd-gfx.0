Return-Path: <SRS0=Wmcu=74=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66FEC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 19:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9254320739
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 19:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtkY9aUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9254320739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D15C6E4D2;
	Mon, 15 Jun 2020 19:08:56 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A89206E4D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 19:08:55 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id b82so635503wmb.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 12:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mVldRFc93ubfkOtcj9dQCiYHEPkvl9p1QAgk9POqzFI=;
 b=gtkY9aUM/9f9jBJvzqR+EyoteBjrmnUI8R2VQ4QHItEgehQi+X142UCi7QbLNhuosf
 ispEIEQQdDaHUYgGKYCf3XSrq3Po7SjokPgK4whnlBpnX7q0PqfFp0sH21WTniIpEi0r
 M46RMRjvu6nc09UyR/5bFB9TslEAMdgVOdiEBPIi1royOtUvajQwaOp1INeyGEdk/q6t
 gWdWTnavFW8IhuMSApA+Bi0zYerLOm4mJlcDvPm8MPi/1hnW8d37kLaVp3CAlXmZBgwu
 Dvu/K1izqMJ5EZCkV+UxayaKtn+uNIqp1gIsli3eVDsczeUNfG495y5qi2m8hWGFCChu
 Jxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mVldRFc93ubfkOtcj9dQCiYHEPkvl9p1QAgk9POqzFI=;
 b=V8JGmy4gkPljkevBJsm2n4MgN0gIfpDrwsZz48CX9wphZD32bY3GRwnN/JwrDZeyZ8
 kA5m8xL4iBbrbzHE7l6FdSCMLSWI3oU1BUxeB0eJKCNUtROMbO2cidkVWhfP/jvCNh67
 R7H7D8jdrVZiLD9Ty2Z79rz/7uruwn8aYoC3IEVwbR6CCk4ddV9YxPUyip2Ncmge+Rp+
 NiYnT0nLZGzGbtjQVrUNNN/OT9r0RSnpJVPUpY0HptD5Eov7TQXCxEMzSJFMXMN85ajN
 ZhDM6vbZnj3QhdddF+we2TV0RwDDpy0F3y+wpmvwMJGREjxfWmzYehVSDfic26gkUArM
 CBfQ==
X-Gm-Message-State: AOAM530q1+XkxjuHMg/Sq6VCtfSDau1m9Cw38VOsa0vo2GDtHNu3yw4U
 MFGrLL9RVWGphWIXa2iX7aYALCfi/D6qaloba88=
X-Google-Smtp-Source: ABdhPJzXqkdxF+5EElRGTbpp3TaTiOTfyRwZ1eCieDo7fY25iwZWagHxp0hj5e381Ak2V3XSv3E+spnPooHqZD1uZsY=
X-Received: by 2002:a1c:6006:: with SMTP id u6mr773381wmb.39.1592248134209;
 Mon, 15 Jun 2020 12:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAMpQs4L6=Fh8XEoz0K7t1rd34ZRXhW--NPp_CWa7fNoo+CKGUA@mail.gmail.com>
In-Reply-To: <CAMpQs4L6=Fh8XEoz0K7t1rd34ZRXhW--NPp_CWa7fNoo+CKGUA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Jun 2020 15:08:42 -0400
Message-ID: <CADnq5_OCOmKSSid8nV8tPJTkY-CQXSkiYxGx5xoRkDj0G06QxQ@mail.gmail.com>
Subject: Re: The inherent defect of the AMDGPU driver about hotplug
To: Aaron Chou <zhoubb.aaron@gmail.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBKdW4gMTUsIDIwMjAgYXQgNTozMCBBTSBBYXJvbiBDaG91IDx6aG91YmIuYWFyb25A
Z21haWwuY29tPiB3cm90ZToKPgo+IEFib3V0IG9uZSBtb250aCBhZ28sIEkgaGF2ZSBhc2tlZCBh
IHF1ZXN0aW9uIGFib3V0IEhETUkgaG90cGx1ZywgdGhlIGxpbmsgaXM6Cj4KPiBodHRwczovL2dp
dGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy8xMTM1I25vdGVfNDkyNDYwCj4K
PiBBbmQgSSBoYXZlIHB1dCBvbmUgcGF0Y2ggdG8gZml4IHRoaXMsIGFzIGZvbGxvd3M6Cj4KPiAg
MzkgZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jb25uZWN0
b3JzLmMKPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jb25uZWN0b3JzLmMK
PiAgNDAgaW5kZXggZjM1NWQ5YTc1MmQyLi5lZTY1N2RiOWEyMjggMTAwNjQ0Cj4gIDQxIC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jb25uZWN0b3JzLmMKPiAgNDIgKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Nvbm5lY3RvcnMuYwo+ICA0MyBA
QCAtOTczLDcgKzk3Myw3IEBAIGFtZGdwdV9jb25uZWN0b3JfZHZpX2RldGVjdChzdHJ1Y3QKPiBk
cm1fY29ubmVjdG9yICpjb25uZWN0b3IsIGJvb2wgZm9yY2UpCj4gIDQ0ICAgICAgICAgY29uc3Qg
c3RydWN0IGRybV9lbmNvZGVyX2hlbHBlcl9mdW5jcyAqZW5jb2Rlcl9mdW5jczsKPiAgNDUgICAg
ICAgICBpbnQgcjsKPiAgNDYgICAgICAgICBlbnVtIGRybV9jb25uZWN0b3Jfc3RhdHVzIHJldCA9
Cj4gY29ubmVjdG9yX3N0YXR1c19kaXNjb25uZWN0ZWQ7Cj4gIDQ3IC0gICAgICAgYm9vbCBkcmV0
ID0gZmFsc2UsIGJyb2tlbl9lZGlkID0gZmFsc2U7Cj4gIDQ4ICsgICAgICAgYm9vbCBkcmV0ID0g
ZmFsc2UsIGJyb2tlbl9lZGlkID0gZmFsc2UsIHVuZGVmaW5lZF9mbGFnID0KPiBmYWxzZTsKPiAg
NDkKPiAgNTAgICAgICAgICBpZiAoIWRybV9rbXNfaGVscGVyX2lzX3BvbGxfd29ya2VyKCkpIHsK
PiAgNTEgICAgICAgICAgICAgICAgIHIgPSBwbV9ydW50aW1lX2dldF9zeW5jKGNvbm5lY3Rvci0+
ZGV2LT5kZXYpOwo+ICA1MiBAQCAtOTg4LDcgKzk4OCwxMiBAQCBhbWRncHVfY29ubmVjdG9yX2R2
aV9kZXRlY3Qoc3RydWN0Cj4gZHJtX2Nvbm5lY3RvciAqY29ubmVjdG9yLCBib29sIGZvcmNlKQo+
ICA1Mwo+ICA1NCAgICAgICAgIGlmIChhbWRncHVfY29ubmVjdG9yLT5kZGNfYnVzKQo+ICA1NSAg
ICAgICAgICAgICAgICAgZHJldCA9IGFtZGdwdV9kaXNwbGF5X2RkY19wcm9iZShhbWRncHVfY29u
bmVjdG9yLAo+IGZhbHNlKTsKPiAgNTYgLSAgICAgICBpZiAoZHJldCkgewo+ICA1NyArCj4gIDU4
ICsgICAgICAgLyogQ2hlY2sgdGhlIEhETUkgSFBEIHBpbiBzdGF0dXMgYWdhaW4gKi8KPiAgNTkg
KyAgICAgICBpZiAoIWFtZGdwdV9kaXNwbGF5X2hwZF9zZW5zZShhZGV2LAo+IGFtZGdwdV9jb25u
ZWN0b3ItPmhwZC5ocGQpKQo+ICA2MCArICAgICAgICAgICAgICAgdW5kZWZpbmVkX2ZsYWcgPSB0
cnVlOwo+ICA2MSArCj4gIDYyICsgICAgICAgaWYgKGRyZXQgJiYgIXVuZGVmaW5lZF9mbGFnKSB7
Cj4gIDYzICAgICAgICAgICAgICAgICBhbWRncHVfY29ubmVjdG9yLT5kZXRlY3RlZF9ieV9sb2Fk
ID0gZmFsc2U7Cj4gIDY0ICAgICAgICAgICAgICAgICBhbWRncHVfY29ubmVjdG9yX2ZyZWVfZWRp
ZChjb25uZWN0b3IpOwo+ICA2NSAgICAgICAgICAgICAgICAgYW1kZ3B1X2Nvbm5lY3Rvcl9nZXRf
ZWRpZChjb25uZWN0b3IpOwo+Cj4gTWF5YmUgdGhlIGZpeCBpcyBzbG9wcHksIHNvIEkgd3JpdGUg
dGhlIGFub3RoZXIgcGF0Y2g6Cj4KPiAgMTYgZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9jb25uZWN0b3JzLmMKPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9jb25uZWN0b3JzLmMKPiAgMTcgaW5kZXggYzc3MGQ3MzM1MmE3Li5iYjU5ZWJj
OWE2YzggMTAwNjQ0Cj4gIDE4IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9jb25uZWN0b3JzLmMKPiAgMTkgKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2Nvbm5lY3RvcnMuYwo+ICAyMCBAQCAtOTkxLDYgKzk5MSw3IEBAIGFtZGdwdV9jb25uZWN0
b3JfZHZpX2RldGVjdChzdHJ1Y3QKPiBkcm1fY29ubmVjdG9yICpjb25uZWN0b3IsIGJvb2wgZm9y
Y2UpCj4gIDIxICAgICAgICAgaWYgKGFtZGdwdV9jb25uZWN0b3ItPmRkY19idXMpCj4gIDIyICAg
ICAgICAgICAgICAgICBkcmV0ID0gYW1kZ3B1X2Rpc3BsYXlfZGRjX3Byb2JlKGFtZGdwdV9jb25u
ZWN0b3IsCj4gZmFsc2UpOwo+ICAyMyAgICAgICAgIGlmIChkcmV0KSB7Cj4gIDI0ICsgICAgICAg
ICAgICAgICBzY2hlZHVsZV93b3JrKCZhZGV2LT5ob3RwbHVnX3dvcmspOwo+ICAyNSAgICAgICAg
ICAgICAgICAgYW1kZ3B1X2Nvbm5lY3Rvci0+ZGV0ZWN0ZWRfYnlfbG9hZCA9IGZhbHNlOwo+ICAy
NiAgICAgICAgICAgICAgICAgYW1kZ3B1X2Nvbm5lY3Rvcl9mcmVlX2VkaWQoY29ubmVjdG9yKTsK
PiAgMjcgICAgICAgICAgICAgICAgIGFtZGdwdV9jb25uZWN0b3JfZ2V0X2VkaWQoY29ubmVjdG9y
KTsKPgo+IFdoaWNoIGlzIGJldHRlciwgb3IgbmVpdGhlcu+8nwoKQXMgcGVyIHRoZSBsYXN0IGRp
c2N1c3Npb246CgoiVGhpcyBpcyB0aGUgcGFydCBJIGRvbid0IHVuZGVyc3RhbmQuICBUaGUgbG9n
aWMgYWxyZWFkeSBjaGVja3MgdGhlIEhQRApzdGF0dXMgaW4gYW1kZ3B1X2Nvbm5lY3Rvcl9jaGVj
a19ocGRfc3RhdHVzX3VuY2hhbmdlZCgpLiAgRG9lcyBpdApzdGlsbCByZXBvcnQgY29ubmVjdGVk
IGF0IHRoYXQgcG9pbnQ/ICBBZnRlciB0aGF0IGl0IHRyaWVzIHRvIHJlYWQgdGhlCkVESUQgaW4g
YW1kZ3B1X2Rpc3BsYXlfZGRjX3Byb2JlKCkuICBJZiB0aGUgbW9uaXRvciBpcyBkaXNjb25uZWN0
ZWQsCnRoZXJlIHNob3VsZCBiZSBubyBFRElEIHNvIGRyZXQgc2hvdWxkIGJlIGZhbHNlLiAgV2Ug
c2hvdWxkIHRyeSBhbmQKZmlndXJlIG91dCB3aHkgdGhlIGZpcnN0IEhQRCBjaGVjayByZXBvcnRz
IGNvbm5lY3RlZCBhbmQgdGhlIEVESUQKcHJvYmUgcmV0dXJucyB0cnVlLiIKClRoZXJlIGlzIGFs
cmVhZHkgYW4gSFBEIHByb2JlIGluIHRoZSBjdXJyZW50IGxvZ2ljLiAgV2Ugc2hvdWxkIHRyeSBh
bmQKdW5kZXJzdGFuZCB3aHkgd2UgbmVlZCBhIHNlY29uZCBvbmUgcmF0aGVyIHRoYW4ganVzdCBh
ZGRpbmcgb25lLiAgRG9lcwphIGRlbGF5IGF0IHRoZSB0b3Agb2YgdGhhdCBmdW5jdGlvbiBoZWxw
PwoKQWxleAoKPgo+IC0tCj4gUmVnYXJkcywKPiBBYXJvbgo+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
