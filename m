Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619A5C3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 21:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E3421D56
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 21:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+GoSMa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E3421D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2FBE6E84A;
	Mon,  2 Mar 2020 21:37:30 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BD086E84A
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 21:37:30 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id z15so1761377wrl.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Mar 2020 13:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=880GhmmE4nYCColnBUl1j/IR1iBjryvaqrg39Aany0c=;
 b=O+GoSMa1uZcZ62CrsbgUqWnTWpOtciSdbnVmhiC8/+1AICCVKQi11QFbWhObY6Lrmk
 R/htR6kca5RmsUxZKtVlyhJ0SSgmM62Ipa0sgjjXnYYk+LD5Np2rd7aP22aPZpGhCcZh
 2UR0/1ZYnC+U/QjJLWPVkeGtjak42k1ZhFe3TLndlDjE5uKAKI4vluEH4CGAOjm7MzqF
 4fy4zvx3HfENgthyOIXAnDJwy9KDMhBcxz59HZV0VNTQ2D4zMPOm6cYMh0lEnMdPyhip
 WBZkVVWVn85Rmjq7nBBpiEt1j3ZUUJx+KNv11VqYkQ9LSIftXvsLf76sGEONpqiAkZIE
 SjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=880GhmmE4nYCColnBUl1j/IR1iBjryvaqrg39Aany0c=;
 b=qlYqJOes4vLk4uup7M4xM1d0sWQIYlTCCHuxOq2TUkAjibZeuX60yRSnlz0a/tvTWL
 5DW/hrOI7mM5uMnbcFh65GoAY+GuhmV/l/TsckJTy7QrIAwh2SEO+PcZdyTpcBHXJ6ec
 h2BMF6UypXaJu2RqRo86cs3bIYfk/jarx3X43hB2ts+WWiXF2sim8my/rldfR/YakJrK
 GOM9fBzWbMAPflWu9XDsyI7mXAQXGdKvORy5eNxsJbtG1lkmr+qiimn+ypYG/dYJwxdK
 sqjMY+QiilpgV75OQHMblQU8iO26/attsQWYH8yl0AgOsawjJHV4no5u+TTVYYEqTnlR
 kY4Q==
X-Gm-Message-State: ANhLgQ3m8byoifz8+0tx/jvnPjC/oZ56QcKFL7AKqPhELFXCwNkeW3hs
 i6Mjp+F41GhIe+lbBq+dabQR7+2gK2aNfollu7A=
X-Google-Smtp-Source: ADFU+vsBw/actLX4G46AfIdYvcBdA/tO6xlnLxsClVzQeLhGJonPMOLAjlqQNJ0IOvnr1JDwrqZY0qnba5L6zBJ+cIw=
X-Received: by 2002:a05:6000:4b:: with SMTP id
 k11mr1445086wrx.362.1583185048802; 
 Mon, 02 Mar 2020 13:37:28 -0800 (PST)
MIME-Version: 1.0
References: <20200302121759.13003-1-christian.koenig@amd.com>
 <20200302121759.13003-4-christian.koenig@amd.com>
In-Reply-To: <20200302121759.13003-4-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Mar 2020 16:37:17 -0500
Message-ID: <CADnq5_N-sxchdhrkBjEkgm7hzfsGvER90tnAsDWi18Tqtsj1Ng@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: stop evicting encrypted BOs to swap
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBNYXIgMiwgMjAyMCBhdCA3OjE4IEFNIENocmlzdGlhbiBLw7ZuaWcKPGNrb2VuaWcu
bGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiB3cm90ZToKPgo+IFN3YXBwaW5nIG91dCBlbmNyeXB0
ZWQgQk9zIGRvZXNuJ3Qgd29yayBiZWNhdXNlIHRoZXkgY2FuJ3QgY2hhbmdlCj4gdGhlaXIgcGh5
c2ljYWwgbG9jYXRpb24gd2l0aG91dCBnb2luZyB0aHJvdWdoIGEgYm91bmNlIGNvcHkuCj4KPiBB
cyBhIHdvcmthcm91bmQgZGlzYWJsZSBldmljdGluZyBlbmNyeXB0ZWQgQk9zIHRvIHRoZSBzeXN0
ZW0KPiBkb21haW4gZm9yIG5vdy4KPgo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KClNlcmllcyBpczoKUmV2aWV3ZWQtYnk6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KCj4gLS0tCj4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyB8IDMgKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMK
PiBpbmRleCAyNWQzYjkzZjQ0NmUuLjk2ZDk3NTIzZGE2NSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPiBAQCAtMTU1Miw2ICsxNTUyLDkgQEAgc3RhdGljIGJv
b2wgYW1kZ3B1X3R0bV9ib19ldmljdGlvbl92YWx1YWJsZShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmpl
Y3QgKmJvLAo+Cj4gICAgICAgICBzd2l0Y2ggKGJvLT5tZW0ubWVtX3R5cGUpIHsKPiAgICAgICAg
IGNhc2UgVFRNX1BMX1RUOgo+ICsgICAgICAgICAgICAgICBpZiAoYW1kZ3B1X2JvX2lzX2FtZGdw
dV9ibyhibykgJiYKPiArICAgICAgICAgICAgICAgICAgIGFtZGdwdV9ib19lbmNyeXB0ZWQodHRt
X3RvX2FtZGdwdV9ibyhibykpKQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBmYWxz
ZTsKPiAgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7Cj4KPiAgICAgICAgIGNhc2UgVFRNX1BM
X1ZSQU06Cj4gLS0KPiAyLjE3LjEKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
