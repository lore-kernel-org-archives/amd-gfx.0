Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BF8C4707F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 04:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0466B613BC
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 04:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0466B613BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3E0B6EE21;
	Thu, 27 May 2021 04:22:36 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F5D96EE1E;
 Thu, 27 May 2021 04:22:34 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id x15so3846010oic.13;
 Wed, 26 May 2021 21:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9DG+xjWGZv67nZFsC1Ee5TRyVRy4OYoOSwlGHHWJ58U=;
 b=l5L+bJvVQJRe0kOb+T6Yq6UuOZ5NfHBWYe+QjQ7AgzNd+wN4b3ZnT/+xjry1OUKU5N
 b7coSP0dZSCIsI8RQl16xUD53gX/HGThF6Grwe7Xg7Z8usXdJN6sZgHHUv26XnVfrU1o
 +ppKtu8BbRLChINfqvdf588PZrqLhmbZZ87cZzANzPyy1ETBrw4ACHMJkzsY0v8oEpkw
 fGTT44+uA014dkuBUxX5/v2Tqix4JRPNgfuvu1rEgcXKRE1U7D8cWCFm4N7lUn+vFitX
 G0q2S549q0TCFxy4SWASelCCEgXGhqrI6/zri1K9lvZGnYohCU+ZRWelJHA5FUwXtTYW
 6sfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9DG+xjWGZv67nZFsC1Ee5TRyVRy4OYoOSwlGHHWJ58U=;
 b=aQ10kWjhXCnPqHEBPgM1COpot9a+X1zi8quYo97BGhWE6PcA5sbDQK3voxX2h7tsJD
 5aAHfXqRbXOqJCI99ORpi0N0Q0rDt4sPmvudHo1eXPSCaMG0RixaS1HA4MJiSlvF/AjH
 M0DRUnh3ELe7AE6ZXAATvOSuSeOJ3in2WS38fJrPZnNq+X8vTJ6z26V6b//Tuii7NPKj
 p6zGtW4D+05tjSKIN1mpWVm+BO1s9CNhGZ2W8FvjKiKJ/5FdP9fk2ZqmIz+VxxaPAU3/
 sYvqrond4DFArVi45TESqdQMiKXFz3OCDEhRD890lqcLAQ2Nj3jJa7dyR3M8fITzFbCE
 wPzw==
X-Gm-Message-State: AOAM5332TfHshFpcOLJ0IRNlNZKUvR4aQIQ0zCfsPf9Dis4b2u/fJ+C+
 CDGmEgCTKFV6sEYOjKwTIlCHYiVMpt0u3kvXP+4=
X-Google-Smtp-Source: ABdhPJz0CbLS9N2IE55TBBnETmt0sI7XDgqlj2lorRpi5OkRDYWOIcqZMgSfJ+Zx6228a69CfujHU7uG5Czu0vDD8Ms=
X-Received: by 2002:a05:6808:206:: with SMTP id l6mr4057313oie.5.1622089353925; 
 Wed, 26 May 2021 21:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org>
 <20210526084726.552052-21-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-21-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 May 2021 00:22:22 -0400
Message-ID: <CADnq5_OHSFsckrZ4_Oy64fT+fDOf4QXudkhpGeaDqXvTc4JwXA@mail.gmail.com>
Subject: Re: [PATCH 20/34] drm/amd/display/amdgpu_dm/amdgpu_dm: Fix kernel-doc
 formatting issue
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
Cc: Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFdlZCwgTWF5IDI2LCAyMDIxIGF0IDQ6NDggQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYzo2MDg6IHdhcm5pbmc6IEZ1bmN0
aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2ludGVycnVwdF9wYXJhbXMnIG5vdCBkZXNjcmliZWQg
aW4gJ2RtX2Rjbl92ZXJ0aWNhbF9pbnRlcnJ1cHQwX2hpZ2hfaXJxJwo+Cj4gQ2M6IEhhcnJ5IFdl
bnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgo+IENjOiBMZW8gTGkgPHN1bnBlbmcubGlA
YW1kLmNvbT4KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+
IENjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzog
RGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5p
ZWxAZmZ3bGwuY2g+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRy
aS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMg
PGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+IGluZGV4IGFlMGE5NWM1ZjFkOGMuLjBiNDg0
MWYzNzdlNDEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtLmMKPiBAQCAtNjA1LDcgKzYwNSw3IEBAIHN0YXRpYyB2b2lkIGRtX2Ny
dGNfaGlnaF9pcnEodm9pZCAqaW50ZXJydXB0X3BhcmFtcykKPiAgLyoqCj4gICAqIGRtX2Rjbl92
ZXJ0aWNhbF9pbnRlcnJ1cHQwX2hpZ2hfaXJxKCkgLSBIYW5kbGVzIE9URyBWZXJ0aWNhbCBpbnRl
cnJ1cHQwIGZvcgo+ICAgKiBEQ04gZ2VuZXJhdGlvbiBBU0lDcwo+IC0gKiBAaW50ZXJydXB0IHBh
cmFtcyAtIGludGVycnVwdCBwYXJhbWV0ZXJzCj4gKyAqIEBpbnRlcnJ1cHRfcGFyYW1zOiBpbnRl
cnJ1cHQgcGFyYW1ldGVycwo+ICAgKgo+ICAgKiBVc2VkIHRvIHNldCBjcmMgd2luZG93L3JlYWQg
b3V0IGNyYyB2YWx1ZSBhdCB2ZXJ0aWNhbCBsaW5lIDAgcG9zaXRpb24KPiAgICovCj4gLS0KPiAy
LjMxLjEKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
