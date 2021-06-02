Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A55C47092
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 02:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 423F4610CB
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 02:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423F4610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4F036EB50;
	Wed,  2 Jun 2021 02:07:51 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78DC66EB4F;
 Wed,  2 Jun 2021 02:07:50 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 x41-20020a05683040a9b02903b37841177eso1124977ott.9; 
 Tue, 01 Jun 2021 19:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pU1TRPFdg/mvMNMBTDRgncKjTs5cmC/VyWt+TILhNqg=;
 b=leBsDCLV2SQ+QW8NeJ78bjOGFhHQDUCW/Evqpq2ZLpXULUTD/gYVSWB0dKF+OZ2v8/
 C7XYgo/lznFWK0glQZ5BhIsDN4m+9THwBBrByZI1kPwsRbO+4oDbSI3miRWMTMXEL+TJ
 1bdst67rVthfP5BTO5o7lI3krd9Eb7oCk4+SErPCDN/Egx3dajMebOIS64mmZR9VKZAA
 OixVbaRn4O994jn/KWkrQaEWsVAZ7QoxOgZvu9FzCcPJf+N7wHU74hl8nazHzgKTthi+
 5Wtb2q8dVFp8ElfhO3dwBkVDj8xJxy5wa6AceM5RNEykul5QZjSehyXxn02IrOPIi55P
 FBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pU1TRPFdg/mvMNMBTDRgncKjTs5cmC/VyWt+TILhNqg=;
 b=Cfk1UFaniN9E+42PEpyVpRtJ42qJ/MyiPJTegb2Eo3Fl1iEkmc7+UyeqY/aP130JZj
 EbUECZHAmquJeZRykR6NdNEbvgXXEkBlZiBpw/w7PKzoO9G9S/ykt6z+jsN0RabxK+MF
 ZYGyZgtAsQFkiQGcpAsRKN5ZyWewz264CdrN/cY4pJVaJ3dBko2RLngOCOdihGkL6eqI
 ounJS3PJGENZdA/XXqgTIsVK0qrxCHxt/+4GN5PNuyBk4310KxUOFeM+mkceZM8fB4jk
 8+PyfMMmyvAkfYkZP0NbkjeqcDrVv8fUY8tM/p3+eS6TieMR6P6io8vHUUY/wk6ZtT8I
 1sEA==
X-Gm-Message-State: AOAM533NK1hMg1pnS/zyEscCGTk6iyK+Ltm4YQ+FlQzp/47x97Ab+hd1
 ljd5wDZA4/uomj0TH29wFCagGZqeyifaZey3Mgk=
X-Google-Smtp-Source: ABdhPJy++Oeg5/01VJ0eNw4v7bM57dKx0Um7cQXKi3LBbMT6j2vCn15UhSf89hqlJcqfgZt7Y2XlXZgo5CTv05pt1g0=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr24108150otl.311.1622599669886; 
 Tue, 01 Jun 2021 19:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210529092816.3133745-1-yukuai3@huawei.com>
In-Reply-To: <20210529092816.3133745-1-yukuai3@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Jun 2021 22:07:38 -0400
Message-ID: <CADnq5_Na=AdNCoQpDPVJ=5078s8C7SNMBo295H-Jp1fQZWkmCw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix gcc set but not used warning of
 variable 'old_plane_state'
To: Yu Kuai <yukuai3@huawei.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, yi.zhang@huawei.com,
 "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>, xinhui pan <Xinhui.Pan@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Dave Airlie <airlied@linux.ie>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFNhdCwgTWF5IDI5LCAyMDIxIGF0IDU6MTkgQU0g
WXUgS3VhaSA8eXVrdWFpM0BodWF3ZWkuY29tPiB3cm90ZToKPgo+IGRlZmluZSBhIG5ldyBtYWNy
byBmb3JfZWFjaF9uZXdfcGxhbmVfaW5fc3RhdGVfcmV2ZXJzZSB0byByZXBsYWNlCj4gZm9yX2Vh
Y2hfb2xkbmV3X3BsYW5lX2luX3N0YXRlX3JldmVyc2UsIHNvIHRoYXQgdGhlIHVudXNlZCB2YXJp
YWJsZQo+ICdvbGRfcGxhbmVfc3RhdGUnIGNhbiBiZSByZW1vdmVkLgo+Cj4gRml4IGdjYyB3YXJu
aW5nOgo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvYW1kZ3B1X2RtL2Ft
ZGdwdV9kbS5jOjEwMDY2OjI2OiB3YXJuaW5nOgo+ICB2YXJpYWJsZSDigJhvbGRfcGxhbmVfc3Rh
dGXigJkgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KPgo+IFNp
Z25lZC1vZmYtYnk6IFl1IEt1YWkgPHl1a3VhaTNAaHVhd2VpLmNvbT4KPiAtLS0KPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8ICA0ICsrLS0KPiAg
aW5jbHVkZS9kcm0vZHJtX2F0b21pYy5oICAgICAgICAgICAgICAgICAgICAgICAgICB8IDEyICsr
KysrKysrKysrKwo+ICAyIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0v
YW1kZ3B1X2RtLmMKPiBpbmRleCBmN2E1ZTViNDhlYTYuLjlmNGIzMzRiYzA3MSAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+
IEBAIC0xMDA2MywxMSArMTAwNjMsMTEgQEAgc3RhdGljIGludCB2YWxpZGF0ZV9vdmVybGF5KHN0
cnVjdCBkcm1fYXRvbWljX3N0YXRlICpzdGF0ZSkKPiAgewo+ICAgICAgICAgaW50IGk7Cj4gICAg
ICAgICBzdHJ1Y3QgZHJtX3BsYW5lICpwbGFuZTsKPiAtICAgICAgIHN0cnVjdCBkcm1fcGxhbmVf
c3RhdGUgKm9sZF9wbGFuZV9zdGF0ZSwgKm5ld19wbGFuZV9zdGF0ZTsKPiArICAgICAgIHN0cnVj
dCBkcm1fcGxhbmVfc3RhdGUgKm5ld19wbGFuZV9zdGF0ZTsKPiAgICAgICAgIHN0cnVjdCBkcm1f
cGxhbmVfc3RhdGUgKnByaW1hcnlfc3RhdGUsICpjdXJzb3Jfc3RhdGUsICpvdmVybGF5X3N0YXRl
ID0gTlVMTDsKPgo+ICAgICAgICAgLyogQ2hlY2sgaWYgcHJpbWFyeSBwbGFuZSBpcyBjb250YWlu
ZWQgaW5zaWRlIG92ZXJsYXkgKi8KPiAtICAgICAgIGZvcl9lYWNoX29sZG5ld19wbGFuZV9pbl9z
dGF0ZV9yZXZlcnNlKHN0YXRlLCBwbGFuZSwgb2xkX3BsYW5lX3N0YXRlLCBuZXdfcGxhbmVfc3Rh
dGUsIGkpIHsKPiArICAgICAgIGZvcl9lYWNoX25ld19wbGFuZV9pbl9zdGF0ZV9yZXZlcnNlKHN0
YXRlLCBwbGFuZSwgbmV3X3BsYW5lX3N0YXRlLCBpKSB7Cj4gICAgICAgICAgICAgICAgIGlmIChw
bGFuZS0+dHlwZSA9PSBEUk1fUExBTkVfVFlQRV9PVkVSTEFZKSB7Cj4gICAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKGRybV9hdG9taWNfcGxhbmVfZGlzYWJsaW5nKHBsYW5lLT5zdGF0ZSwgbmV3
X3BsYW5lX3N0YXRlKSkKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAw
Owo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9kcm1fYXRvbWljLmggYi9pbmNsdWRlL2RybS9k
cm1fYXRvbWljLmgKPiBpbmRleCBhYzVhMjhlZmYyYzguLjhmMTM1MGU1OTllYiAxMDA2NDQKPiAt
LS0gYS9pbmNsdWRlL2RybS9kcm1fYXRvbWljLmgKPiArKysgYi9pbmNsdWRlL2RybS9kcm1fYXRv
bWljLmgKPiBAQCAtODk1LDYgKzg5NSwxOCBAQCB2b2lkIGRybV9zdGF0ZV9kdW1wKHN0cnVjdCBk
cm1fZGV2aWNlICpkZXYsIHN0cnVjdCBkcm1fcHJpbnRlciAqcCk7Cj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgKG9sZF9wbGFuZV9zdGF0ZSkgPSAoX19zdGF0ZSktPnBsYW5lc1tfX2ld
Lm9sZF9zdGF0ZSxcCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKG5ld19wbGFuZV9z
dGF0ZSkgPSAoX19zdGF0ZSktPnBsYW5lc1tfX2ldLm5ld19zdGF0ZSwgMSkpCj4KPiArLyoqCj4g
KyAqIGZvcl9lYWNoX25ld19wbGFuZV9pbl9zdGF0ZV9yZXZlcnNlIC0gb3RoZXIgdGhhbiBvbmx5
IHRyYWNraW5nIG5ldyBzdGF0ZSwKPiArICogaXQncyB0aGUgc2FtZSBhcyBmb3JfZWFjaF9vbGRu
ZXdfcGxhbmVfaW5fc3RhdGVfcmV2ZXJzZQo+ICsgKi8KPiArI2RlZmluZSBmb3JfZWFjaF9uZXdf
cGxhbmVfaW5fc3RhdGVfcmV2ZXJzZShfX3N0YXRlLCBwbGFuZSwgbmV3X3BsYW5lX3N0YXRlLCBf
X2kpIFwKPiArICAgICAgIGZvciAoKF9faSkgPSAoKF9fc3RhdGUpLT5kZXYtPm1vZGVfY29uZmln
Lm51bV90b3RhbF9wbGFuZSAtIDEpOyBcCj4gKyAgICAgICAgICAgIChfX2kpID49IDA7ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAo+ICsgICAgICAgICAg
ICAoX19pKS0tKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFwKPiArICAgICAgICAgICAgICAgZm9yX2VhY2hfaWYgKChfX3N0YXRlKS0+cGxhbmVzW19f
aV0ucHRyICYmICAgICAgICAgICAgICBcCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAo
KHBsYW5lKSA9IChfX3N0YXRlKS0+cGxhbmVzW19faV0ucHRyLCAgICAgXAo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIChuZXdfcGxhbmVfc3RhdGUpID0gKF9fc3RhdGUpLT5wbGFuZXNb
X19pXS5uZXdfc3RhdGUsIDEpKQo+ICsKPiAgLyoqCj4gICAqIGZvcl9lYWNoX29sZF9wbGFuZV9p
bl9zdGF0ZSAtIGl0ZXJhdGUgb3ZlciBhbGwgcGxhbmVzIGluIGFuIGF0b21pYyB1cGRhdGUKPiAg
ICogQF9fc3RhdGU6ICZzdHJ1Y3QgZHJtX2F0b21pY19zdGF0ZSBwb2ludGVyCj4gLS0KPiAyLjI1
LjQKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
