Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3671C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64FD823A68
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64FD823A68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11F236E811;
	Fri,  8 Jan 2021 20:39:17 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9BC96E8C5;
 Fri,  8 Jan 2021 20:39:15 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id 11so10921127oty.9;
 Fri, 08 Jan 2021 12:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LbL2Dr2OA34OBObvO2XG7FOhOz6bhRwrWXKAgmeY+cE=;
 b=Ca1Q2uAb3M+v2uxazpdjCzVwAlHGVsYO5KEobRYXWcEAfV/CePHFxHsC0FKcF8G8HU
 K9Y9G9bIlkXTCRM9aIoD0mChGxonTEHdnCFooV97r8NpCD3smcHyOUNA49g7snuFIbhg
 nYmoOOwUtTcWRKUfNfrTNmBkRog0/IRipNb6k0sPwN6NLDv4PuUSsq3rBl92OxiIXWGQ
 PP/EIYTT6kKfBPY4Ko5bmE8sHbXOSJhcHlIZJII2jbp91+DFFimZrwhtv3jZO05F1VLc
 ZaCKWHSGif7Rio0vll5EuENPe/OlduCkVbq5wnFgmqt+idTEtmo4H8hZb2SoPALzKFcm
 lnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LbL2Dr2OA34OBObvO2XG7FOhOz6bhRwrWXKAgmeY+cE=;
 b=lL3itj1KYwcwBkdWX4H/3Y1hCC1GoWL2/sy2PFuf/sUdfRYOmaX+tHFuX8l9RyjsCD
 ElsGoOnMzfAeatZqy5tzjnRcSpyp/7CneziMdj1OyryHFKTeRyxgMQREVW2+oTz7GEC5
 P5AvOOJcyQadsrvGBK76ygFKEibeq5ymp/qyE7JI+5rmTThIOSENQmf4QYXKzKEE4iDs
 dR5x2oztZkIZKu7w4heyPQ5Bf8TarvaZTOpDGnH8Qg+5ieuJUQ3yGmTgJVPJjqx6QP5h
 LXNtxtFhxEl3JTyAW3WQ82MQ+0gAt+Jl5Y3Sg4r/kZkWoEPm1S//nvAEhAf+tspxD0MK
 d2NQ==
X-Gm-Message-State: AOAM530TyZUgJ3bjqDhSgTkTtdp53Wz+Qc7wizu5frBxtt9cgXjIOp8N
 pSU4T8yjhvaxjdOh7bj2buO3de0SwaJ+cOlWJHc=
X-Google-Smtp-Source: ABdhPJwx+z0MTVNUE63OnTtCnT0bfez2GTMZcacp2FrfJBIxw/e9o7MEMkkLARXEG+wO/GmnhMcWsz/HHcP7PnKlZWg=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr3808067otl.311.1610138355123; 
 Fri, 08 Jan 2021 12:39:15 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org>
 <20210108201457.3078600-15-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-15-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Jan 2021 15:39:04 -0500
Message-ID: <CADnq5_Pyi7cbPBm4R3kNAqTi3CAb94gV+DMsMEJLru7iqdfypQ@mail.gmail.com>
Subject: Re: [PATCH 14/40] drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs: Demote
 non-kernel-doc comment blocks
To: Lee Jones <lee.jones@linaro.org>
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
Cc: Eryk Brol <eryk.brol@amd.com>, Leo Li <sunpeng.li@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBKYW4gOCwgMjAyMSBhdCAzOjE1IFBNIExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+IHdyb3RlOgo+Cj4gRml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdh
cm5pbmcocyk6Cj4KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtX2RlYnVnZnMuYzo2OTk6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRl
ciBvciBtZW1iZXIgJ20nIG5vdCBkZXNjcmliZWQgaW4gJ2RtdWJfdHJhY2VidWZmZXJfc2hvdycK
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1
X2RtX2RlYnVnZnMuYzo2OTk6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIg
J2RhdGEnIG5vdCBkZXNjcmliZWQgaW4gJ2RtdWJfdHJhY2VidWZmZXJfc2hvdycKPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2RlYnVn
ZnMuYzo3NDM6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ20nIG5vdCBk
ZXNjcmliZWQgaW4gJ2RtdWJfZndfc3RhdGVfc2hvdycKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvLi4vZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2RlYnVnZnMuYzo3NDM6IHdhcm5p
bmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2RhdGEnIG5vdCBkZXNjcmliZWQgaW4g
J2RtdWJfZndfc3RhdGVfc2hvdycKPgo+IENjOiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxh
bmRAYW1kLmNvbT4KPiBDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Cj4gQ2M6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzogIkNocmlzdGlhbiBLw7Zu
aWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGll
ZEBsaW51eC5pZT4KPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+IENjOiBN
aWtpdGEgTGlwc2tpIDxtaWtpdGEubGlwc2tpQGFtZC5jb20+Cj4gQ2M6IEVyeWsgQnJvbCA8ZXJ5
ay5icm9sQGFtZC5jb20+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6
IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9u
ZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgoKQXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCgo+IC0t
LQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9kZWJ1
Z2ZzLmMgfCA0ICsrLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1k
Z3B1X2RtL2FtZGdwdV9kbV9kZWJ1Z2ZzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
YW1kZ3B1X2RtL2FtZGdwdV9kbV9kZWJ1Z2ZzLmMKPiBpbmRleCAxMTQ1OWZiMDlhMzcyLi5kNjQ1
ZjNlNDYxMGViIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtX2RlYnVnZnMuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2RlYnVnZnMuYwo+IEBAIC02OTEsNyArNjkxLDcgQEAg
c3RhdGljIHNzaXplX3QgZHBfcGh5X3Rlc3RfcGF0dGVybl9kZWJ1Z2ZzX3dyaXRlKHN0cnVjdCBm
aWxlICpmLCBjb25zdCBjaGFyIF9fdXMKPiAgICAgICAgIHJldHVybiBzaXplOwo+ICB9Cj4KPiAt
LyoqCj4gKy8qCj4gICAqIFJldHVybnMgdGhlIERNQ1VCIHRyYWNlYnVmZmVyIGNvbnRlbnRzLgo+
ICAgKiBFeGFtcGxlIHVzYWdlOiBjYXQgL3N5cy9rZXJuZWwvZGVidWcvZHJpLzAvYW1kZ3B1X2Rt
X2RtdWJfdHJhY2VidWZmZXIKPiAgICovCj4gQEAgLTczNSw3ICs3MzUsNyBAQCBzdGF0aWMgaW50
IGRtdWJfdHJhY2VidWZmZXJfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKmRhdGEpCj4g
ICAgICAgICByZXR1cm4gMDsKPiAgfQo+Cj4gLS8qKgo+ICsvKgo+ICAgKiBSZXR1cm5zIHRoZSBE
TUNVQiBmaXJtd2FyZSBzdGF0ZSBjb250ZW50cy4KPiAgICogRXhhbXBsZSB1c2FnZTogY2F0IC9z
eXMva2VybmVsL2RlYnVnL2RyaS8wL2FtZGdwdV9kbV9kbXViX2Z3X3N0YXRlCj4gICAqLwo+IC0t
Cj4gMi4yNS4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9k
cmktZGV2ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
