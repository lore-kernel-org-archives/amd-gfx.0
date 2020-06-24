Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4D3C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 670F82072E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="du8zv1SR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670F82072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24F6589A9A;
	Wed, 24 Jun 2020 14:23:08 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B01AD89A9A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 14:23:07 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id f139so2705487wmf.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 07:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Evd0XtBf5tPOCiDYfZ2QPrqfuoEtazoALhjNFBWLuI0=;
 b=du8zv1SRLx69MydHg6fvD2h8zzS1YNc1xr7275qegAj22Zgpl13XbcaOSc/dtEUHcR
 9lfJifHH2ZgqCLOl1tQ94tlfv1QSY/ez9e1QZfGJZv3slcZugdzuTfTjek8/L0BBHIGS
 Uc3JiWyISjLCTJxZeBAu1WJitxGg1qnPfrP++L2mjG3vJdMN4QKYKi/DjrkjXXqcLClc
 v83BuiUHdtN8f+R0tZJMB/BhzgNgNweYiBLkHXWQw3/F5i5owP3k4MqD8HTCmmfALB0A
 1mxvWSIs+nwt/XoKAkdSAV2FDh7qaPDLboONctp62AZSU9f9qdFq7cG+b6Qa83F6trR9
 ayvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=Evd0XtBf5tPOCiDYfZ2QPrqfuoEtazoALhjNFBWLuI0=;
 b=AWQOtFa8eHC7Rl3H5FfltsQmoDB1AV4AEd4Yl5z8LemzE6/aik7K+sbcjjKt6vdqgv
 Vd6HqqdYnVua+KhwpXaP2VRAN+vtHT58MJ2HFff4iB++EGeSkZYNWBXXoPrI1ab1Oegr
 u3o6RKq07qhdG37kZMzLnfOhElIJGjTEBI0t2MQlz62Cu41dG2L7OzCFh7YAF40/8Wdq
 hbAXdL2+XwTWmsVtPQCuzNO+Fl6BVOEVbXNysbYLkY2dHxvRQ/aR41k6ZQ3/t6uSmUTx
 Go1qaunM2U6lzRMegrYmdSif06yzZtSg6+aFUnxB8QS2OkZ3nTMgmK07o9tLBpIHxEBP
 CxVQ==
X-Gm-Message-State: AOAM532uYAjgkYc5rhVXIeHnKG+CrwDCx8+Fm0uhQ1P1Ldwos3ZrZSj3
 wqgg3NE75VwlsxolsQoT3Q8=
X-Google-Smtp-Source: ABdhPJx+I2tdw7O7/dpDPxc5m7izP2eRISGgXlG0qnujXd3SJYdzIosl/9iwqg0TLrxIHuE15S+iAQ==
X-Received: by 2002:a1c:c242:: with SMTP id s63mr24562371wmf.146.1593008586330; 
 Wed, 24 Jun 2020 07:23:06 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id r3sm7596374wrg.70.2020.06.24.07.23.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jun 2020 07:23:05 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu/uvd3.x: fix register definition warnings
To: Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20200622221219.1046290-1-alexander.deucher@amd.com>
 <CADnq5_McBUGrx9jrEJcfKX_FSRKMeq8o=0Y7jHkQzjm6VtY1qQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d71d4edd-f46a-ef3c-f5c9-a63e46272358@gmail.com>
Date: Wed, 24 Jun 2020 16:23:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_McBUGrx9jrEJcfKX_FSRKMeq8o=0Y7jHkQzjm6VtY1qQ@mail.gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCkFt
IDI0LjA2LjIwIHVtIDE2OjE5IHNjaHJpZWIgQWxleCBEZXVjaGVyOgo+IFBpbmc/Cj4KPiBPbiBN
b24sIEp1biAyMiwgMjAyMCBhdCA2OjEyIFBNIEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21h
aWwuY29tPiB3cm90ZToKPj4gZHJvcCB0aGUgZHVwbGljYXRlIHJlZ2lzdGVyIG1hY3JvcyBmcm9t
IHNpZC5oIGFuZCB1c2UgdGhlCj4+IHN0YW5kYXJkIG9uZXMgaW4gdGhlIG9zcyByZWdpc3RlciBo
ZWFkZXJzLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpLmMg
ICAgfCAgMSArCj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfaWguYyB8ICAyICsr
Cj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lkLmggICB8IDE5IC0tLS0tLS0tLS0t
LS0tLS0tLS0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRp
b25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2kuYwo+PiBpbmRleCBjZGE5YWE1ZTRiOWUu
LjliMTIyODUxNzdlMyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
c2kuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaS5jCj4+IEBAIC00NSw2
ICs0NSw3IEBACj4+ICAgI2luY2x1ZGUgImRjZV92aXJ0dWFsLmgiCj4+ICAgI2luY2x1ZGUgImdj
YS9nZnhfNl8wX2QuaCIKPj4gICAjaW5jbHVkZSAib3NzL29zc18xXzBfZC5oIgo+PiArI2luY2x1
ZGUgIm9zcy9vc3NfMV8wX3NoX21hc2suaCIKPj4gICAjaW5jbHVkZSAiZ21jL2dtY182XzBfZC5o
Igo+PiAgICNpbmNsdWRlICJkY2UvZGNlXzZfMF9kLmgiCj4+ICAgI2luY2x1ZGUgInV2ZC91dmRf
NF8wX2QuaCIKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2lo
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9paC5jCj4+IGluZGV4IDg4YWUyN2E1
YTAzZC4uNjIxNzI3ZDdmZDE4IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9zaV9paC5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2loLmMK
Pj4gQEAgLTI3LDYgKzI3LDggQEAKPj4gICAjaW5jbHVkZSAiYW1kZ3B1X2loLmgiCj4+ICAgI2lu
Y2x1ZGUgInNpZC5oIgo+PiAgICNpbmNsdWRlICJzaV9paC5oIgo+PiArI2luY2x1ZGUgIm9zcy9v
c3NfMV8wX2QuaCIKPj4gKyNpbmNsdWRlICJvc3Mvb3NzXzFfMF9zaF9tYXNrLmgiCj4+Cj4+ICAg
c3RhdGljIHZvaWQgc2lfaWhfc2V0X2ludGVycnVwdF9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldik7Cj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9z
aWQuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpZC5oCj4+IGluZGV4IDc1YjVkNDQx
YjYyOC4uNWY2NjBmMGM4MTlmIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9zaWQuaAo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaWQuaAo+PiBA
QCAtMjM0MSwxMSArMjM0MSw2IEBACj4+ICAgIyAgICAgICBkZWZpbmUgTklfSU5QVVRfR0FNTUFf
WFZZQ0NfMjIyICAgICAgICAgICAgICAgIDMKPj4gICAjICAgICAgIGRlZmluZSBOSV9PVkxfSU5Q
VVRfR0FNTUFfTU9ERSh4KSAgICAgICAgICAgICAgKCgoeCkgJiAweDMpIDw8IDQpCj4+Cj4+IC0j
ZGVmaW5lIElIX1JCX1dQVFJfX1JCX09WRVJGTE9XX01BU0sgICAweDEKPj4gLSNkZWZpbmUgSUhf
UkJfQ05UTF9fV1BUUl9PVkVSRkxPV19DTEVBUl9NQVNLIDB4ODAwMDAwMDAKPj4gLSNkZWZpbmUg
U1JCTV9TVEFUVVNfX0lIX0JVU1lfTUFTSyAgICAgIDB4MjAwMDAKPj4gLSNkZWZpbmUgU1JCTV9T
T0ZUX1JFU0VUX19TT0ZUX1JFU0VUX0lIX01BU0sgICAgMHg0MDAKPj4gLQo+PiAgICNkZWZpbmUg
ICAgICAgIEJMQUNLT1VUX01PREVfTUFTSyAgICAgICAgICAgICAgICAgICAgICAweDAwMDAwMDA3
Cj4+ICAgI2RlZmluZSAgICAgICAgVkdBX1JFTkRFUl9DT05UUk9MICAgICAgICAgICAgICAgICAg
ICAgIDB4QzAKPj4gICAjZGVmaW5lIFJfMDAwMzAwX1ZHQV9SRU5ERVJfQ09OVFJPTCAgICAgICAg
ICAgICAweEMwCj4+IEBAIC0yNDMyLDE4ICsyNDI3LDYgQEAKPj4gICAjZGVmaW5lIE1DX1NFUV9N
SVNDMF9fTVRfX0hCTSAgICAweDYwMDAwMDAwCj4+ICAgI2RlZmluZSBNQ19TRVFfTUlTQzBfX01U
X19ERFIzICAgMHhCMDAwMDAwMAo+Pgo+PiAtI2RlZmluZSBTUkJNX1NUQVRVU19fTUNCX0JVU1lf
TUFTSyAweDIwMAo+PiAtI2RlZmluZSBTUkJNX1NUQVRVU19fTUNCX0JVU1lfX1NISUZUIDB4OQo+
PiAtI2RlZmluZSBTUkJNX1NUQVRVU19fTUNCX05PTl9ESVNQTEFZX0JVU1lfTUFTSyAweDQwMAo+
PiAtI2RlZmluZSBTUkJNX1NUQVRVU19fTUNCX05PTl9ESVNQTEFZX0JVU1lfX1NISUZUIDB4YQo+
PiAtI2RlZmluZSBTUkJNX1NUQVRVU19fTUNDX0JVU1lfTUFTSyAweDgwMAo+PiAtI2RlZmluZSBT
UkJNX1NUQVRVU19fTUNDX0JVU1lfX1NISUZUIDB4Ygo+PiAtI2RlZmluZSBTUkJNX1NUQVRVU19f
TUNEX0JVU1lfTUFTSyAweDEwMDAKPj4gLSNkZWZpbmUgU1JCTV9TVEFUVVNfX01DRF9CVVNZX19T
SElGVCAweGMKPj4gLSNkZWZpbmUgU1JCTV9TVEFUVVNfX1ZNQ19CVVNZX01BU0sgMHgxMDAKPj4g
LSNkZWZpbmUgU1JCTV9TVEFUVVNfX1ZNQ19CVVNZX19TSElGVCAweDgKPj4gLQo+PiAtCj4+ICAg
I2RlZmluZSBHUkJNX1NUQVRVU19fR1VJX0FDVElWRV9NQVNLIDB4ODAwMDAwMDAKPj4gICAjZGVm
aW5lIENQX0lOVF9DTlRMX1JJTkdfX1RJTUVfU1RBTVBfSU5UX0VOQUJMRV9NQVNLIDB4NDAwMDAw
MAo+PiAgICNkZWZpbmUgQ1BfSU5UX0NOVExfUklORzBfX1BSSVZfUkVHX0lOVF9FTkFCTEVfTUFT
SyAweDgwMDAwMAo+PiBAQCAtMjQ2OCw4ICsyNDUxLDYgQEAKPj4KPj4gICAjZGVmaW5lIFBDSUVf
QlVTX0NMSyAgICAxMDAwMAo+PiAgICNkZWZpbmUgVENMSyAgICAgICAgICAgIChQQ0lFX0JVU19D
TEsgLyAxMCkKPj4gLSNkZWZpbmUgQ0NfRFJNX0lEX1NUUkFQU19fQVRJX1JFVl9JRF9NQVNLICAg
ICAgICAgICAgICAweGYwMDAwMDAwCj4+IC0jZGVmaW5lIENDX0RSTV9JRF9TVFJBUFNfX0FUSV9S
RVZfSURfX1NISUZUIDB4MWMKPj4gICAjZGVmaW5lICAgICAgICBQQ0lFX1BPUlRfSU5ERVggICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAweGUKPj4gICAjZGVmaW5lICAgICAgICBQQ0lF
X1BPUlRfREFUQSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAweGYKPj4gICAjZGVm
aW5lIEVWRVJHUkVFTl9QSUZfUEhZMF9JTkRFWCAgICAgICAgICAgICAgICAgICAgICAgIDB4OAo+
PiAtLQo+PiAyLjI1LjQKPj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
