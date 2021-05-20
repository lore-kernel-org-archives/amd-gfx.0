Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A727DC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 694A6611AD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694A6611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01F326F4E8;
	Thu, 20 May 2021 19:11:00 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BB2D6F4E7;
 Thu, 20 May 2021 19:10:58 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 i8-20020a4aa1080000b0290201edd785e7so4027913ool.1; 
 Thu, 20 May 2021 12:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7aUG2dXh+6klmDA6WXd8OSdzl7pjQCCb87TCo0Exy6E=;
 b=mfIXPPC10SzTZqxuepC3SiwJi6etRAelD5Y7D4Mj+i2F+ZX9euxkSxgtSlreNy8Wq+
 0DzQ5Fd/Bw3uP+VaNdRXPkP2PdIWaZ71qzYVFPKDoW52A062H8ShnqfUFuuFM4LzZtWl
 e8x0dG0ZRmSreIPjrRnRP7NnexrVLaFbZdIxfa1jpRB1WST3Yvsd68yNsfJOAS3fC47c
 4kNHVUPhVOzqcafK3dXXLyJlbQaaNdlVcwZw5AfC31+Kfmb2wBS2ZwpUnpyzKqDx6WUa
 g2hqC+xjp6E1Mrt6so4bseLcZtNeIKTR7YHBcjOsOzgyYq4d8ccxnVvpnl1o+a+akq27
 /6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7aUG2dXh+6klmDA6WXd8OSdzl7pjQCCb87TCo0Exy6E=;
 b=F4aYYf4ombMxygoO6N6/ieuCrqNiv7EgQpwKMVdVlb5qxAN6zInu+JKDns4MuPHiKb
 pdD1fktUFwLDraDaVL12UU/SYrQM3ftLHJ10E/i5HmH4k0EVGyDKGlyUdT/UkmeYygck
 VOSd8M19VxGeSDMULhELL2aETWfzkwE0VPrz6Lp2JGX4BrFIrTBHVv0H/IWsmvx1V7kS
 EQ41KS01wksuxSqBojpEUi+QMcMVMjYCA47lpJSzYiG9sajsUo3OjqnOuJNpf2SyTUU0
 ZGfs1rrQI0Z1RgKbx6Pd/juB77Xx3W5q5RHcVQwpTWXfn0XJyudCy5uoNNSBLmgnwgS5
 yT1Q==
X-Gm-Message-State: AOAM532OUcUQ985atz7N1rfJNenSQDXrk/dwElBVbBk47IQUwgTgcecV
 hJWlSCBBdt921eRh6tQrTUz2QWdz8A+EA7PDeuY=
X-Google-Smtp-Source: ABdhPJyxmJJMnSHgvijXuC3+a1N5VY1r34o/FRKeOu5rQXlWBh5wzcOKYm9e4IMiB8c2W8XXE3R4pH7R9VEoycNN7Uo=
X-Received: by 2002:a4a:d085:: with SMTP id i5mr4948998oor.61.1621537857547;
 Thu, 20 May 2021 12:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org>
 <20210520120248.3464013-13-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-13-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 May 2021 15:10:46 -0400
Message-ID: <CADnq5_PCSixr_j3+zxhS4Z3WG83L_vYQuboo9NOOML0n_r9j0Q@mail.gmail.com>
Subject: Re: [PATCH 12/38] drm/amd/amdgpu/amdgpu_gmc: Fix a little naming
 related doc-rot
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFRodSwgTWF5IDIwLCAyMDIxIGF0IDg6MDMgQU0g
TGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9s
bG93aW5nIFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZ21jLmM6NDg3OiB3YXJuaW5nOiBleHBlY3RpbmcgcHJvdG90eXBl
IGZvciBhbWRncHVfdG16X3NldCgpLiBQcm90b3R5cGUgd2FzIGZvciBhbWRncHVfZ21jX3Rtel9z
ZXQoKSBpbnN0ZWFkCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYzo1
MzM6IHdhcm5pbmc6IGV4cGVjdGluZyBwcm90b3R5cGUgZm9yIGFtZGdwdV9ub3JldHJ5X3NldCgp
LiBQcm90b3R5cGUgd2FzIGZvciBhbWRncHVfZ21jX25vcmV0cnlfc2V0KCkgaW5zdGVhZAo+Cj4g
Q2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzogIkNocmlz
dGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6IERhdmlkIEFpcmxp
ZSA8YWlybGllZEBsaW51eC5pZT4KPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNo
Pgo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCj4gU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNA
bGluYXJvLm9yZz4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dt
Yy5jIHwgNCArKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2dtYy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jCj4gaW5kZXgg
YTEyOWVjYzczODY5My4uNThmZWIwYTQyMmMzNCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZ21jLmMKPiBAQCAtNTI4LDcgKzUyOCw3IEBAIGludCBhbWRncHVfZ21jX2Fs
bG9jYXRlX3ZtX2ludl9lbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gIH0KPgo+ICAv
KioKPiAtICogYW1kZ3B1X3Rtel9zZXQgLS0gY2hlY2sgYW5kIHNldCBpZiBhIGRldmljZSBzdXBw
b3J0cyBUTVoKPiArICogYW1kZ3B1X2dtY190bXpfc2V0IC0tIGNoZWNrIGFuZCBzZXQgaWYgYSBk
ZXZpY2Ugc3VwcG9ydHMgVE1aCj4gICAqIEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKPiAg
ICoKPiAgICogQ2hlY2sgYW5kIHNldCBpZiBhbiB0aGUgZGV2aWNlIEBhZGV2IHN1cHBvcnRzIFRy
dXN0ZWQgTWVtb3J5Cj4gQEAgLTU3NCw3ICs1NzQsNyBAQCB2b2lkIGFtZGdwdV9nbWNfdG16X3Nl
dChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgfQo+Cj4gIC8qKgo+IC0gKiBhbWRncHVf
bm9yZXRyeV9zZXQgLS0gc2V0IHBlciBhc2ljIG5vcmV0cnkgZGVmYXVsdHMKPiArICogYW1kZ3B1
X2dtY19ub3JldHJ5X3NldCAtLSBzZXQgcGVyIGFzaWMgbm9yZXRyeSBkZWZhdWx0cwo+ICAgKiBA
YWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCj4gICAqCj4gICAqIFNldCBhIHBlciBhc2ljIGRl
ZmF1bHQgZm9yIHRoZSBuby1yZXRyeSBwYXJhbWV0ZXIuCj4gLS0KPiAyLjMxLjEKPgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
