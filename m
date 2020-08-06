Return-Path: <SRS0=X6dN=BQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724CEC433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 16:33:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFB15204FD
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 16:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YixJuAZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB15204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD75D6E8DB;
	Thu,  6 Aug 2020 16:33:11 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABCC36E8DB
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2020 16:33:10 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id r2so39522259wrs.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Aug 2020 09:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/G462RnHDlnkiWEaaQT/ylTQgjg7KcBtI8pio438844=;
 b=YixJuAZ+agHkZxj7qyda1kM/VbJnpMkeI0bNf25S1i9UDSmnSJkyjRLHCspvkeWBPs
 cngX1vtFVw3de0hrDcQ+4Hr3p0QTQimwyHCdijMCKnKkK1IGi19b28BRSBvSNmqXWHj/
 Qhud3mD/WaF0hw4ynXhk4UmhmCPG/wYtfshNXbqKYkkv9qd0IRWZJG6GqQBLSjfczvLK
 6r9fdHAaY9MDtS9xg5uIn+A2jdATSGn1r7p6mFyrlAh0aR3INP+qIigvb+K4rZwoJO8o
 I96yjcBMvSJWMaapHsTUQ1tW6me+JFIBhirEHAkfLlGBzvNe6Fkm1Y7cEeZnUtkZSJ/V
 cT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/G462RnHDlnkiWEaaQT/ylTQgjg7KcBtI8pio438844=;
 b=TWUjDGBezjAXZex3FGEh+4g2BQkgiBJs/F1hpN4mV5gJM06FldLiA7UGALaPlB0bqQ
 0HkL/rGD7XtiWwZCOayqt8uMeGlzVYLJH3sPvSmZi4GkCiNZeWfNyt8ZtxB1jqaDHNDA
 DhUxb+EdylOkajhXpG1T4jx6oX1Ia7idGtvmNeIV4QBAjAjJw+v165DSe+HovB6m0Qf2
 rr/oEvltOHnI6kZ1IPa1bSZ2Ks2aurA31Y++cq5zBBxN+y7319Xw6OiK+49PEPcDPWOf
 qqaeEEfNvSfStC8JnY/ACurjcjSDVwJB8aL8aN7ekrITgw/22/2VeJdxKbyorIiddutd
 37uQ==
X-Gm-Message-State: AOAM533KzdhIEPLNTezXYrRBsrKNyB105i5IKYsId+1qTOEwiGOmb1+G
 8VXazWn/TQyaSCBlLjc9487AVzmzwIQdgF6eWIg=
X-Google-Smtp-Source: ABdhPJz6mXUj3IvRrsXIZDPbeu4gdzZnWzgqrFCseYqoncOZnw7NfmeHnfpDE3v9GXXjp3uSppdrS3Q802AgorqkjWQ=
X-Received: by 2002:a5d:618e:: with SMTP id j14mr8504810wru.374.1596731589329; 
 Thu, 06 Aug 2020 09:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200806155953.76389-1-kevin1.wang@amd.com>
In-Reply-To: <20200806155953.76389-1-kevin1.wang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Aug 2020 12:32:58 -0400
Message-ID: <CADnq5_PW9Xcf9Y2d9eOv5Tj1tEtcRuZGOpCLYVrSqFDFVbgg6g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix uninit-value in
 arcturus_log_thermal_throttling_event()
To: Kevin Wang <kevin1.wang@amd.com>
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBBdWcgNiwgMjAyMCBhdCAxMTo1OSBBTSBLZXZpbiBXYW5nIDxrZXZpbjEud2FuZ0Bh
bWQuY29tPiB3cm90ZToKPgo+IHdoZW4gZnVuY3Rpb24gYXJjdHVydXNfZ2V0X3NtdV9tZXRyaWNz
X2RhdGEoKSBjYWxsIGZhaWxlZCwKPiBpdCB3aWxsIGNhdXNlIHRoZSB2YXJpYWJsZSAidGhyb3R0
bGVyX3N0YXR1cyIgaXNuJ3QgaW5pdGlhbGl6ZWQgYmVmb3JlIHVzZS4KPgo+IHdhcm5pbmc6Cj4g
cG93ZXJwbGF5L2FyY3R1cnVzX3BwdC5jOjIyNjg6MjQ6IHdhcm5pbmc6IOKAmHRocm90dGxlcl9z
dGF0dXPigJkgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFstV21h
eWJlLXVuaW5pdGlhbGl6ZWRdCj4gIDIyNjggfCAgIGlmICh0aHJvdHRsZXJfc3RhdHVzICYgbG9n
Z2luZ19sYWJlbFt0aHJvdHRsZXJfaWR4XS5mZWF0dXJlX21hc2spIHsKPgo+IFNpZ25lZC1vZmYt
Ynk6IEtldmluIFdhbmcgPGtldmluMS53YW5nQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKPiAtLS0KPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMgfCA5ICsrKysrKy0tLQo+ICAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FyY3R1cnVzX3BwdC5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMKPiBpbmRleCBlNThhZjg0NDMzYzcu
Ljk0NmRiYzBkYjFiMSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxh
eS9hcmN0dXJ1c19wcHQuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2Fy
Y3R1cnVzX3BwdC5jCj4gQEAgLTIyNTMsMTQgKzIyNTMsMTcgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCB0aHJvdHRsaW5nX2xvZ2dpbmdfbGFiZWwgewo+ICB9Owo+ICBzdGF0aWMgdm9pZCBhcmN0dXJ1
c19sb2dfdGhlcm1hbF90aHJvdHRsaW5nX2V2ZW50KHN0cnVjdCBzbXVfY29udGV4dCAqc211KQo+
ICB7Cj4gKyAgICAgICBpbnQgcmV0Owo+ICAgICAgICAgaW50IHRocm90dGxlcl9pZHgsIHRocm90
dGluZ19ldmVudHMgPSAwLCBidWZfaWR4ID0gMDsKPiAgICAgICAgIHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2ID0gc211LT5hZGV2Owo+ICAgICAgICAgdWludDMyX3QgdGhyb3R0bGVyX3N0YXR1
czsKPiAgICAgICAgIGNoYXIgbG9nX2J1ZlsyNTZdOwo+Cj4gLSAgICAgICBhcmN0dXJ1c19nZXRf
c211X21ldHJpY3NfZGF0YShzbXUsCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBNRVRSSUNTX1RIUk9UVExFUl9TVEFUVVMsCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAmdGhyb3R0bGVyX3N0YXR1cyk7Cj4gKyAgICAgICByZXQgPSBhcmN0dXJ1
c19nZXRfc211X21ldHJpY3NfZGF0YShzbXUsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBNRVRSSUNTX1RIUk9UVExFUl9TVEFUVVMsCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmdGhyb3R0bGVyX3N0YXR1cyk7Cj4gKyAg
ICAgICBpZiAocmV0KQo+ICsgICAgICAgICAgICAgICByZXR1cm47Cj4KPiAgICAgICAgIG1lbXNl
dChsb2dfYnVmLCAwLCBzaXplb2YobG9nX2J1ZikpOwo+ICAgICAgICAgZm9yICh0aHJvdHRsZXJf
aWR4ID0gMDsgdGhyb3R0bGVyX2lkeCA8IEFSUkFZX1NJWkUobG9nZ2luZ19sYWJlbCk7Cj4gLS0K
PiAyLjI3LjAKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
