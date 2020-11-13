Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76F5C388F7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA8E20A8B
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olLX5w8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA8E20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 060186E575;
	Fri, 13 Nov 2020 17:17:06 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1769A6E575;
 Fri, 13 Nov 2020 17:17:05 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id p22so8820284wmg.3;
 Fri, 13 Nov 2020 09:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8MYRJgCahvIIjHbmvpXlCqJXMSfFVlQgoNN3oalTAH0=;
 b=olLX5w8U2inNBK9YcmPVqqiPvxYz7ys7/lfEEDPMOtQ6nKZe8N7o+WH6DkHI5+3wie
 YXhhh6fT0+LQWh4jnk2hFp5D+3PuFqWLkhlqBfHrl2P9f6tkAt0VM5rXPYkOGhM7xbjx
 vKzzmEBQNkCUlm4W+OKPngbo85QRXz+KxwMU69Hk22rgpNnETbLnWL6V3pZYOIMkTHDi
 BxS4UmU0rvMwSWfkHbhb8faKt8Hk20xufWm2IdYBKmXOW1Xy/Kg3lj6QmmddJPRS3N0a
 KBbo7qQMtOI/kDpjkxOg79wy+OD/HEKNParPaCn1FoGU+MPUsEW4oTbL/Cr81J3cNjkU
 aftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8MYRJgCahvIIjHbmvpXlCqJXMSfFVlQgoNN3oalTAH0=;
 b=tnF6lsskPsJtKfYMqmcNHM8cng1tALCucxU7C5pMGVgC1vELF0Vel4sijhsiLjBhpL
 voPj2tXmtn6jj1HOMgiqufyHLibGQTW+K2OhulRLLe3I8DnNuUTCT0tfadtUjvaQ/6qg
 PV2JlRjUwHJE6x3BN7YRGJrov72E7rhy/y9tS/VnG4/jVvRZr6U+NINgotfD5d9xHEP+
 LOYwqsAu+dB39cV1eIBZn5NgRjCeOH2IwUELuxUJWk43RlkwJtLBVrG++Bv7BjcAyDV0
 wTv95GJcxdzBAlLi3nPjKdJxYGpw0Xd2/fWCIjm4axmXAPShOmerY0XETrrGJq7wXjWY
 nCDw==
X-Gm-Message-State: AOAM530MG3tWv3k2+oU1O1q0peYA+4R0VfRFc5dnoLil50YJgrvrDIQN
 coNfgR0TA4hZZptxLFL9Jac976OQBsX4/nZGRcI=
X-Google-Smtp-Source: ABdhPJxDWvPyzSPU2aP0/uCsckO5leH1AQ/fcwWETiHKRMBBGJqXONQ6+CzQmXw8cqOl1kS5Ua3r6ioJNxVioBk2akw=
X-Received: by 2002:a7b:c157:: with SMTP id z23mr3494772wmi.70.1605287819058; 
 Fri, 13 Nov 2020 09:16:59 -0800 (PST)
MIME-Version: 1.0
References: <20201113134938.4004947-1-lee.jones@linaro.org>
 <20201113134938.4004947-9-lee.jones@linaro.org>
In-Reply-To: <20201113134938.4004947-9-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Nov 2020 12:16:47 -0500
Message-ID: <CADnq5_Mx-3E7GPHR11FAMAw=UNDEt1zBx6f6X04A0jrC84wDrg@mail.gmail.com>
Subject: Re: [PATCH 08/40] drm/amd/amdgpu/amdgpu_ib: Fix some
 incorrect/incomplete function documentation
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBOb3YgMTMsIDIwMjAgYXQgODo1MCBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jOjY2
OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdhZGV2JyBub3QgZGVzY3Jp
YmVkIGluICdhbWRncHVfaWJfZ2V0Jwo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfaWIuYzo2Njogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAndm0nIG5v
dCBkZXNjcmliZWQgaW4gJ2FtZGdwdV9pYl9nZXQnCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9pYi5jOjY2OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVy
ICdwb29sX3R5cGUnIG5vdCBkZXNjcmliZWQgaW4gJ2FtZGdwdV9pYl9nZXQnCj4gIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jOjY2OiB3YXJuaW5nOiBFeGNlc3MgZnVuY3Rp
b24gcGFyYW1ldGVyICdyaW5nJyBkZXNjcmlwdGlvbiBpbiAnYW1kZ3B1X2liX2dldCcKPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2liLmM6MTI1OiB3YXJuaW5nOiBGdW5jdGlv
biBwYXJhbWV0ZXIgb3IgbWVtYmVyICdyaW5nJyBub3QgZGVzY3JpYmVkIGluICdhbWRncHVfaWJf
c2NoZWR1bGUnCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jOjEyNTog
d2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnam9iJyBub3QgZGVzY3JpYmVk
IGluICdhbWRncHVfaWJfc2NoZWR1bGUnCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9pYi5jOjEyNTogd2FybmluZzogRXhjZXNzIGZ1bmN0aW9uIHBhcmFtZXRlciAnYWRldicg
ZGVzY3JpcHRpb24gaW4gJ2FtZGdwdV9pYl9zY2hlZHVsZScKPgo+IENjOiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXgu
aWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzogU3VtaXQgU2Vt
d2FsIDxzdW1pdC5zZW13YWxAbGluYXJvLm9yZz4KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBsaW51
eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmcKPiBDYzogbGluYXJvLW1tLXNpZ0BsaXN0cy5saW5hcm8u
b3JnCj4gU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KCkFw
cGxpZWQuIFRoYW5rcyEKCkFsZXgKCgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfaWIuYyB8IDYgKysrKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2liLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIu
Ywo+IGluZGV4IDJmNTNmYTBhZTlhNjIuLmM2OWFmOWI4NmNjNjAgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2liLmMKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYwo+IEBAIC01Miw4ICs1MiwxMCBAQAo+ICAvKioKPiAg
ICogYW1kZ3B1X2liX2dldCAtIHJlcXVlc3QgYW4gSUIgKEluZGlyZWN0IEJ1ZmZlcikKPiAgICoK
PiAtICogQHJpbmc6IHJpbmcgaW5kZXggdGhlIElCIGlzIGFzc29jaWF0ZWQgd2l0aAo+ICsgKiBA
YWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCj4gKyAqIEB2bTogYW1kZ3B1X3ZtIHBvaW50ZXIK
PiAgICogQHNpemU6IHJlcXVlc3RlZCBJQiBzaXplCj4gKyAqIEBwb29sX3R5cGU6IElCIHBvb2wg
dHlwZSAoZGVsYXllZCwgaW1tZWRpYXRlLCBkaXJlY3QpCj4gICAqIEBpYjogSUIgb2JqZWN0IHJl
dHVybmVkCj4gICAqCj4gICAqIFJlcXVlc3QgYW4gSUIgKGFsbCBhc2ljcykuICBJQnMgYXJlIGFs
bG9jYXRlZCB1c2luZyB0aGUKPiBAQCAtMTAxLDcgKzEwMyw3IEBAIHZvaWQgYW1kZ3B1X2liX2Zy
ZWUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfaWIgKmliLAo+ICAv
KioKPiAgICogYW1kZ3B1X2liX3NjaGVkdWxlIC0gc2NoZWR1bGUgYW4gSUIgKEluZGlyZWN0IEJ1
ZmZlcikgb24gdGhlIHJpbmcKPiAgICoKPiAtICogQGFkZXY6IGFtZGdwdV9kZXZpY2UgcG9pbnRl
cgo+ICsgKiBAcmluZzogcmluZyBpbmRleCB0aGUgSUIgaXMgYXNzb2NpYXRlZCB3aXRoCj4gICAq
IEBudW1faWJzOiBudW1iZXIgb2YgSUJzIHRvIHNjaGVkdWxlCj4gICAqIEBpYnM6IElCIG9iamVj
dHMgdG8gc2NoZWR1bGUKPiAgICogQGY6IGZlbmNlIGNyZWF0ZWQgZHVyaW5nIHRoaXMgc3VibWlz
c2lvbgo+IC0tCj4gMi4yNS4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
