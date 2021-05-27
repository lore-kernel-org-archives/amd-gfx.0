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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C754EC4707F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 03:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BBD6613C9
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 03:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBD6613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EA6F6EE08;
	Thu, 27 May 2021 03:55:56 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B786E6EE11;
 Thu, 27 May 2021 03:55:55 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id d21so3796318oic.11;
 Wed, 26 May 2021 20:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6I1MN4NFWb6xeVQSlutSgWAcmQk4ybiIdBPc7EssI9A=;
 b=AcnIsP/9H7cKkmwG+Xb4aLO5wf9oNSioM80yUY5janIGjdZ/jrOxGOjL+Q459ygwmE
 hYaaatUpYrIYD19ql0dLEwobOc1LyazLx6QHcWc2mTN9lBtAuw9fG+tY9cY9ja3/3hGm
 TZGmuYn9qiQyW6EhOzwJMyYLd0mmDmQdFxfXDDAGoOZHYIIjP0NSQfeBWRC3mx4ymoQq
 wcmUoXszHs7h5JSo5vEjJnUrKWbrn8pWKCcAq2+E5aDbFh++LiHNrpl0OY1NkWsgf8tW
 aCE8CrDpqfvxDOT1yBDCViP1aWs3UqpcyAE7A8jHdNVVkwn9D7alnNieXb963Gs6I2bg
 cw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6I1MN4NFWb6xeVQSlutSgWAcmQk4ybiIdBPc7EssI9A=;
 b=cUBTgIvYaWEwG4dTzOIYALrLL5zpgP1NaHrIbQpiZkU1zZFCXE0K0NRFUEyH/5DHf+
 9SyYDdMfqtO7vb92tOzjlgCa8CPbIbjltmaIVDmc/0bx5Qnmfk7u3+W5q6Y+VKet/nYL
 +9OOPK54Q1ikqecsEvWLFtIkl8ckwZt0ANKd5/wBKAbURHB+RloOBCDo3H3wz3PTD+yC
 xlspVdF2+zJ2FQAQaIXUJc2612GLTjbhyuizU4WLix0tQNFzIkkzITuu8gDOYw7Xmcjg
 BkWZNc3m5LjRdFpvESZRctjvKLnTaGOsw4x89m/5CJa7eqUn+nVP4kXX8BoHiXlodY2i
 vQCg==
X-Gm-Message-State: AOAM533ivCk1s/acA+PNGVvX1PLglJlDrxo46lCF6E0TGujjDNKJhp6M
 23a9dwUHrYNdY1efmwQMH6HzLgyvB6UGiROdnESa3D/Z
X-Google-Smtp-Source: ABdhPJyLCSQv/QKSuTRNjM9REWrV6LvELlWwO0q1KT5sPyqK1rH9VVCmNc0k3krS51ZcjSXmkdhBuwGUnFZY01qAZ2Q=
X-Received: by 2002:a05:6808:249:: with SMTP id
 m9mr1023562oie.120.1622087755096; 
 Wed, 26 May 2021 20:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org>
 <20210526084726.552052-9-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-9-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 May 2021 23:55:44 -0400
Message-ID: <CADnq5_PFBMaeD-sFQ-=5RzcZX42=4dwYZvnZhW+X3mQ62=182w@mail.gmail.com>
Subject: Re: [PATCH 08/34] drm/amd/display/dc/bios/command_table_helper: Fix
 function name for 'dal_cmd_table_helper_transmitter_bp_to_atom()'
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
ZGdwdS8uLi9kaXNwbGF5L2RjL2Jpb3MvY29tbWFuZF90YWJsZV9oZWxwZXIuYzoxMjc6IHdhcm5p
bmc6IGV4cGVjdGluZyBwcm90b3R5cGUgZm9yIHRyYW5zbGF0ZV90cmFuc21pdHRlcl9icF90b19h
dG9tKCkuIFByb3RvdHlwZSB3YXMgZm9yIGRhbF9jbWRfdGFibGVfaGVscGVyX3RyYW5zbWl0dGVy
X2JwX3RvX2F0b20oKSBpbnN0ZWFkCj4KPiBDYzogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRs
YW5kQGFtZC5jb20+Cj4gQ2M6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgo+IENjOiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2
bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxp
ZWRAbGludXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzog
TGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IFNpZ25l
ZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Cj4gLS0tCj4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9zL2NvbW1hbmRfdGFibGVfaGVscGVyLmMgfCAy
ICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9zL2NvbW1hbmRf
dGFibGVfaGVscGVyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlvcy9jb21t
YW5kX3RhYmxlX2hlbHBlci5jCj4gaW5kZXggNWI3NzI1MWUwNTkwOS4uZTMxN2EzNjE1MTQ3NyAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlvcy9jb21tYW5k
X3RhYmxlX2hlbHBlci5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jp
b3MvY29tbWFuZF90YWJsZV9oZWxwZXIuYwo+IEBAIC0xMTQsNyArMTE0LDcgQEAgYm9vbCBkYWxf
Y21kX3RhYmxlX2hlbHBlcl9jb250cm9sbGVyX2lkX3RvX2F0b20oCj4gIH0KPgo+ICAvKioKPiAt
ICogdHJhbnNsYXRlX3RyYW5zbWl0dGVyX2JwX3RvX2F0b20gLSBUcmFuc2xhdGUgdGhlIFRyYW5z
bWl0dGVyIHRvIHRoZQo+ICsgKiBkYWxfY21kX3RhYmxlX2hlbHBlcl90cmFuc21pdHRlcl9icF90
b19hdG9tIC0gVHJhbnNsYXRlIHRoZSBUcmFuc21pdHRlciB0byB0aGUKPiAgICogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjb3JyZXNwb25kaW5nIEFUT00gQklPUyB2YWx1ZQo+
ICAgKiBAdDogdHJhbnNtaXR0ZXIKPiAgICogcmV0dXJuczogb3V0cHV0IGRpZ2l0YWxUcmFuc21p
dHRlcgo+IC0tCj4gMi4zMS4xCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
