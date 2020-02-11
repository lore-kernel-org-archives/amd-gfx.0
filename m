Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DAEC352A3
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 15:23:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B18F206DB
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 15:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmmqL5Nr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B18F206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12FFA6EA85;
	Tue, 11 Feb 2020 15:23:28 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D41536E530;
 Tue, 11 Feb 2020 15:23:26 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id a5so4038727wmb.0;
 Tue, 11 Feb 2020 07:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=KOwn/Ih7uUxCyCR2Dzx2pqzZgtUsJj8/0M+LsbQLNUg=;
 b=qmmqL5Nrd3dcSjwC8nawo38WqU4Kc9L6TdjHDT2iL8R+UcWCc1IQEg+569tgQEO+Kx
 Vsw8pV68gGmplYmPgl4Z313difbDNd+W7bNC7E51qa5lyUvB7sAa4SUhufUrYJS5NEzT
 OQNqXVMMED3bjvZhK4/C6lr86ayvixRJER9AQH+vFFeS4kbB+ZmDamngcx+d/r5Qvf8x
 H7ztkGNNAPaQNrQ7jHH3cXLW5KcnYcAxVyCWamx/oNrFHu2GCqEftYL1Xt94YJLTsZpw
 iVPrZPaOOlfqtsb3c32IYc6RnDaf+BiY+Fjw6BSbanHfRpTO9PFwfZNO0+1Ce2qT6iXH
 zDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=KOwn/Ih7uUxCyCR2Dzx2pqzZgtUsJj8/0M+LsbQLNUg=;
 b=fVXpEbDUXNZKdDIxSTLP2vvtnf4Iiaaldgzkg0EwLQ8r6en7mfTiKdX3vXo1BHzonp
 6czC0oCWRaQ3sxEoHQ+x5RSq0YqiA+fsj/6Uf6o6EpojlYpbMrU29UU2UukQnT4Mz81U
 bvgd74FljCeAy4wrZTbfoGSBllLX6K+JpRN/NtmLsqynf7k4OGtJ9qr13FG4iUiAfR83
 zD7+ePrbsoCRJ2spiG7YgEFdLAPWAIoLwXuStyYow8EYmsyvpuNc6lblJwmR5IHYeHgF
 Z3jayWRKvdbqmjTzQdOHfvIQ7yKf8SALh7COkpyBinrUJ8GGObPgwq3q/BtDGmtpKWDE
 Jd8w==
X-Gm-Message-State: APjAAAUJJbmuudp8artw9L3NzAmpFQ0udQYQbfnbEtIB9Avii4MGtk3/
 I/tVEHBDcuaPa6Tc2vx4gIoN2Xx/
X-Google-Smtp-Source: APXvYqzqC0yCep2G90uukikcHguvWLKbEaKUnvagcJVHL71PkbjEuXEbzzBxc+YtJC0DZVIh2ZiGXQ==
X-Received: by 2002:a1c:4c5:: with SMTP id 188mr6081596wme.82.1581434605229;
 Tue, 11 Feb 2020 07:23:25 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id v14sm5748896wrm.28.2020.02.11.07.23.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Feb 2020 07:23:24 -0800 (PST)
Subject: Re: [PATCH 5/6] drm/ttm: replace dma_resv object on deleted BOs v2
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20200210150907.20616-1-christian.koenig@amd.com>
 <20200210150907.20616-6-christian.koenig@amd.com>
 <20200211141402.GB2363188@phenom.ffwll.local>
 <11341C05-E5C8-47C6-A77D-F3B3380453AA@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <fef6b329-92f0-3b06-502b-22120caf1a98@gmail.com>
Date: Tue, 11 Feb 2020 16:23:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <11341C05-E5C8-47C6-A77D-F3B3380453AA@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTEuMDIuMjAgdW0gMTY6MDIgc2NocmllYiBQYW4sIFhpbmh1aToKPgo+PiAyMDIw5bm0Muac
iDEx5pelIDIyOjE077yMRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPiDlhpnpgZPvvJoK
Pj4KPj4gT24gTW9uLCBGZWIgMTAsIDIwMjAgYXQgMDQ6MDk6MDZQTSArMDEwMCwgQ2hyaXN0aWFu
IEvDtm5pZyB3cm90ZToKPj4+IFdoZW4gbm9uLWltcG9ydGVkIEJPcyBhcmUgcmVzdXJyZWN0ZWQg
Zm9yIGRlbGF5ZWQgZGVsZXRlIHdlIHJlcGxhY2UKPj4+IHRoZSBkbWFfcmVzdiBvYmplY3QgdG8g
YWxsb3cgZm9yIGVhc3kgcmVjbGFpbWluZyBvZiB0aGUgcmVzb3VyY2VzLgo+Pj4KPj4+IHYyOiBt
b3ZlIHRoYXQgdG8gdHRtX2JvX2luZGl2aWR1YWxpemVfcmVzdgo+Pj4KPj4+IFNpZ25lZC1vZmYt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4+IC0tLQo+
Pj4gZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYyB8IDEwICsrKysrKysrKy0KPj4+IDEgZmls
ZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4+Cj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYyBiL2RyaXZlcnMvZ3B1L2RybS90dG0v
dHRtX2JvLmMKPj4+IGluZGV4IGQwNjI0Njg1ZjVkMi4uNGQxNjEwMzhkZTk4IDEwMDY0NAo+Pj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL3R0bS90dG1fYm8uYwo+Pj4gQEAgLTM5Myw2ICszOTMsMTQgQEAgc3RhdGljIGludCB0dG1f
Ym9faW5kaXZpZHVhbGl6ZV9yZXN2KHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8pCj4+Pgo+
Pj4gCXIgPSBkbWFfcmVzdl9jb3B5X2ZlbmNlcygmYm8tPmJhc2UuX3Jlc3YsIGJvLT5iYXNlLnJl
c3YpOwo+Pj4gCWRtYV9yZXN2X3VubG9jaygmYm8tPmJhc2UuX3Jlc3YpOwo+Pj4gKwlpZiAocikK
Pj4+ICsJCXJldHVybiByOwo+Pj4gKwo+Pj4gKwlpZiAoYm8tPnR5cGUgIT0gdHRtX2JvX3R5cGVf
c2cpIHsKPj4+ICsJCXNwaW5fbG9jaygmdHRtX2JvX2dsb2IubHJ1X2xvY2spOwo+Pj4gKwkJYm8t
PmJhc2UucmVzdiA9ICZiby0+YmFzZS5fcmVzdjsKPj4gSGF2aW5nIHRoZSBkbWFfcmVzdiBwb2lu
dGVyIGJlIHByb3RlY3RlZCBieSB0aGUgbHJ1X2xvY2sgZm9yIHR0bSBpbnRlcm5hbAo+PiBzdHVm
ZiwgYnV0IGludmFyaWFudCBldmVyeXdoZXJlIGVsc2UgaXMgcmVhbGx5IGNvbmZ1c2luZy4gTm90
IHN1cmUgdGhhdCdzCj4gSSB0aGluayB0aGlzIGlzIHJlYWRlciBWUyB3cml0ZXIuCj4gVG8gYXZv
aWQgYW55IGludGVybmFsIGZ1bmN0aW9ucyB1c2luZyB0aGUgb2xkIHJlc3YsICB1c2luZyBhbiBl
eGlzdGluZyBzcGluIGxvY2sgaXMgYWNjZXB0YWJsZS4KPiBNYXliZSBSQ1UgaXMgYmV0dGVyPyBU
aGF0IHdpbGwgbmVlZCBhIGxvdCBvZiBlZmZvcnQuCj4gQW55d2F5LCB0dG0gc3Vja3MuIFdlIEhB
UyBkb25lIGEgbG90IG9mIHdvcmsgb24gaXQgdG8gbWFrZSBpdCBiZXR0ZXIgcnVubmluZyBvbiBt
b2Rlcm4gc3lzdGVtLgoKWWVhaCB0aGF0IHN1bW1hcml6ZSBteSByZWNlbnQgcHJlc2VudGF0aW9u
IGFib3V0IFRUTSBwcmV0dHkgbXVjaCA6KQoKRG91YmxlIGNoZWNrZWQgdGhhdCBhbmQgdGhlIG9u
bHkgcmVhc29uIHdlIGhhdmUgdGhlIGxvY2sgaXMgdGhhdCBpbiAKdHRtX21lbV9ldmljdF9maXJz
dCgpIHdlIHRyeWxvY2sgZmlyc3QgYW5kIHRoZW4gZ3JhYiBhIHJlZmVyZW5jZS4KClNvIHdlIHNo
b3VsZCBwcm9iYWJseSByZXdvcmsgdGhhdCBjb2RlIGFzIHdlbGwgYW5kIHRoZW4gd2UgY2FuIGFs
c28gZHJvcCAKdGhhdCBsb2NrIGhlcmUsIGJ1dCB0aGF0IHNob3VsZCBjb21lIGxhdGVyLgoKQ2hy
aXN0aWFuLgoKPgo+Cj4+IGEgZ3JlYXQgaWRlYSwgSSd2ZSBqdXN0IGNoYXNlZCBzb21lIHR0bSBj
b2RlIGFyb3VuZCBmcmVha2luZyBvdXQgYWJvdXQKPj4gdGhhdC4KPj4gLURhbmllbAo+Pgo+Pj4g
KwkJc3Bpbl91bmxvY2soJnR0bV9ib19nbG9iLmxydV9sb2NrKTsKPj4+ICsJfQo+Pj4KPj4+IAly
ZXR1cm4gcjsKPj4+IH0KPj4+IEBAIC03MjAsNyArNzI4LDcgQEAgc3RhdGljIGJvb2wgdHRtX2Jv
X2V2aWN0X3N3YXBvdXRfYWxsb3dhYmxlKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8sCj4+
Pgo+Pj4gCWlmIChiby0+YmFzZS5yZXN2ID09IGN0eC0+cmVzdikgewo+Pj4gCQlkbWFfcmVzdl9h
c3NlcnRfaGVsZChiby0+YmFzZS5yZXN2KTsKPj4+IC0JCWlmIChjdHgtPmZsYWdzICYgVFRNX09Q
VF9GTEFHX0FMTE9XX1JFU19FVklDVCB8fCBiby0+ZGVsZXRlZCkKPj4+ICsJCWlmIChjdHgtPmZs
YWdzICYgVFRNX09QVF9GTEFHX0FMTE9XX1JFU19FVklDVCkKPj4+IAkJCXJldCA9IHRydWU7Cj4+
PiAJCSpsb2NrZWQgPSBmYWxzZTsKPj4+IAkJaWYgKGJ1c3kpCj4+PiAtLSAKPj4+IDIuMTcuMQo+
Pj4KPj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+
PiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4+PiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCj4+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91
cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGlu
Zm8lMkZkcmktZGV2ZWwmYW1wO2RhdGE9MDIlN0MwMSU3Q1hpbmh1aS5QYW4lNDBhbWQuY29tJTdD
ZWU2NzMxMGUyNmI2NGNhOWU3OTAwOGQ3YWVmY2E3YjQlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4
MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTcwMjcyNDgxNzY1OTA0JmFtcDtzZGF0YT1acG5QOU1O
QlAxY3NRQ0tQUjI3NWVqSXZzWjNiOHhMODB0bVNscGY3TVBBJTNEJmFtcDtyZXNlcnZlZD0wCj4+
IC0tIAo+PiBEYW5pZWwgVmV0dGVyCj4+IFNvZnR3YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jwb3Jh
dGlvbgo+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91
cmw9aHR0cCUzQSUyRiUyRmJsb2cuZmZ3bGwuY2gmYW1wO2RhdGE9MDIlN0MwMSU3Q1hpbmh1aS5Q
YW4lNDBhbWQuY29tJTdDZWU2NzMxMGUyNmI2NGNhOWU3OTAwOGQ3YWVmY2E3YjQlN0MzZGQ4OTYx
ZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTcwMjcyNDgxNzY1OTA0JmFt
cDtzZGF0YT1mazI4anRIaEFuRTMxMkNGTWdWWGFadGFTMllOcUpqbXlKMzE3RldqQW9NJTNEJmFt
cDtyZXNlcnZlZD0wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
