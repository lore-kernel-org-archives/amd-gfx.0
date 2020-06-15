Return-Path: <SRS0=Wmcu=74=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC98C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 09:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6289E206B7
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 09:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbtJOqwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6289E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2FBD6E28B;
	Mon, 15 Jun 2020 09:30:06 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E464B6E28B
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 09:30:05 +0000 (UTC)
Received: by mail-lf1-x132.google.com with SMTP id a26so4654926lfj.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 02:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=5DtfNFyYh4CBYMeTXrIJ6OFwU41RsGs68mjxbLs6y8U=;
 b=AbtJOqwKZqyFO0w+Nn8SbcVRFUi82rznjayEkiJ2VhWihkoeC5IZ7njuQ5tRxfYy9o
 8rqzCRa6wg4Q6oMv4Glo+GufLUMnht3kGMT256cjvYnVG9lZ2RQca5xhooA9aMpiman0
 INjDo0vokmBorgIKIBIns+KaQA3x6ciMTDho6YpnO84/bpBFcvUKkL2hhf/rbQ9ohJ/d
 25X6t3vrJZNFQOKcqZI2T/7JOzka3mHTWI3AEIglCMOfj9r2lypYyHBHBdnAVOPkoQXP
 H7tPvhakVWu6qInRR/mVa4NEGVD7qCztKcuZG9CrNp6xZT0wriRxZd/apliQElxrWwPi
 +CFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=5DtfNFyYh4CBYMeTXrIJ6OFwU41RsGs68mjxbLs6y8U=;
 b=IBrcRh7fq4BAGsSTYwATTx4wvc2cDnYEzI590RTsjKLxUGUGv/aBu9WLFJA7WJ8hQy
 TR0jtEGO2pT67n3AWob7egBszCloU/+D1dD6LgBwifbmnfJq4hCCOqIU+/UKvI+/VF4O
 sbVxcCPEDvhopxknXR2I2FGjLn+b2j1QOA7D8ytCBNbjSyNkS36FhPwtEL5T88UUfnjO
 H5wsY87YwRLvs9hv2bI/ktPWOPmnbMDMJ2nMm4tHHOi+2LuM8tkJRK9jvYBYjiG2R+cM
 HMQoQ2Ix4IVWP7hz9VhBMFpiIOrStIqhFQBGwlKwNXx57uVYFLpwmvmGWCikbJUMQOtV
 E57A==
X-Gm-Message-State: AOAM531zca2bZMEVip/1PNW5x2fHM2kHiYGzEzgBBA545YukFlUnXQj7
 ZSR0fH4mpBDyCKSa1glOJmDpL7l7cqESLXohQGpy0DAt
X-Google-Smtp-Source: ABdhPJwKEsaI815skcFon5zHOSIKa3PmcHOBdfkWyG52wtbaaVieWs/xADs53la0yddKNunQFV3d24xGyH0+4V40uqY=
X-Received: by 2002:a19:6712:: with SMTP id b18mr1643521lfc.141.1592213404159; 
 Mon, 15 Jun 2020 02:30:04 -0700 (PDT)
MIME-Version: 1.0
From: Aaron Chou <zhoubb.aaron@gmail.com>
Date: Mon, 15 Jun 2020 17:29:52 +0800
Message-ID: <CAMpQs4L6=Fh8XEoz0K7t1rd34ZRXhW--NPp_CWa7fNoo+CKGUA@mail.gmail.com>
Subject: The inherent defect of the AMDGPU driver about hotplug
To: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWJvdXQgb25lIG1vbnRoIGFnbywgSSBoYXZlIGFza2VkIGEgcXVlc3Rpb24gYWJvdXQgSERNSSBo
b3RwbHVnLCB0aGUgbGluayBpczoKCmh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0v
YW1kLy0vaXNzdWVzLzExMzUjbm90ZV80OTI0NjAKCkFuZCBJIGhhdmUgcHV0IG9uZSBwYXRjaCB0
byBmaXggdGhpcywgYXMgZm9sbG93czoKCiAzOSBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2Nvbm5lY3RvcnMuYwpiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9jb25uZWN0b3JzLmMKIDQwIGluZGV4IGYzNTVkOWE3NTJkMi4uZWU2NTdkYjlh
MjI4IDEwMDY0NAogNDEgLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Nv
bm5lY3RvcnMuYwogNDIgKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Nv
bm5lY3RvcnMuYwogNDMgQEAgLTk3Myw3ICs5NzMsNyBAQCBhbWRncHVfY29ubmVjdG9yX2R2aV9k
ZXRlY3Qoc3RydWN0CmRybV9jb25uZWN0b3IgKmNvbm5lY3RvciwgYm9vbCBmb3JjZSkKIDQ0ICAg
ICAgICAgY29uc3Qgc3RydWN0IGRybV9lbmNvZGVyX2hlbHBlcl9mdW5jcyAqZW5jb2Rlcl9mdW5j
czsKIDQ1ICAgICAgICAgaW50IHI7CiA0NiAgICAgICAgIGVudW0gZHJtX2Nvbm5lY3Rvcl9zdGF0
dXMgcmV0ID0KY29ubmVjdG9yX3N0YXR1c19kaXNjb25uZWN0ZWQ7CiA0NyAtICAgICAgIGJvb2wg
ZHJldCA9IGZhbHNlLCBicm9rZW5fZWRpZCA9IGZhbHNlOwogNDggKyAgICAgICBib29sIGRyZXQg
PSBmYWxzZSwgYnJva2VuX2VkaWQgPSBmYWxzZSwgdW5kZWZpbmVkX2ZsYWcgPQpmYWxzZTsKIDQ5
CiA1MCAgICAgICAgIGlmICghZHJtX2ttc19oZWxwZXJfaXNfcG9sbF93b3JrZXIoKSkgewogNTEg
ICAgICAgICAgICAgICAgIHIgPSBwbV9ydW50aW1lX2dldF9zeW5jKGNvbm5lY3Rvci0+ZGV2LT5k
ZXYpOwogNTIgQEAgLTk4OCw3ICs5ODgsMTIgQEAgYW1kZ3B1X2Nvbm5lY3Rvcl9kdmlfZGV0ZWN0
KHN0cnVjdApkcm1fY29ubmVjdG9yICpjb25uZWN0b3IsIGJvb2wgZm9yY2UpCiA1MwogNTQgICAg
ICAgICBpZiAoYW1kZ3B1X2Nvbm5lY3Rvci0+ZGRjX2J1cykKIDU1ICAgICAgICAgICAgICAgICBk
cmV0ID0gYW1kZ3B1X2Rpc3BsYXlfZGRjX3Byb2JlKGFtZGdwdV9jb25uZWN0b3IsCmZhbHNlKTsK
IDU2IC0gICAgICAgaWYgKGRyZXQpIHsKIDU3ICsKIDU4ICsgICAgICAgLyogQ2hlY2sgdGhlIEhE
TUkgSFBEIHBpbiBzdGF0dXMgYWdhaW4gKi8KIDU5ICsgICAgICAgaWYgKCFhbWRncHVfZGlzcGxh
eV9ocGRfc2Vuc2UoYWRldiwKYW1kZ3B1X2Nvbm5lY3Rvci0+aHBkLmhwZCkpCiA2MCArICAgICAg
ICAgICAgICAgdW5kZWZpbmVkX2ZsYWcgPSB0cnVlOwogNjEgKwogNjIgKyAgICAgICBpZiAoZHJl
dCAmJiAhdW5kZWZpbmVkX2ZsYWcpIHsKIDYzICAgICAgICAgICAgICAgICBhbWRncHVfY29ubmVj
dG9yLT5kZXRlY3RlZF9ieV9sb2FkID0gZmFsc2U7CiA2NCAgICAgICAgICAgICAgICAgYW1kZ3B1
X2Nvbm5lY3Rvcl9mcmVlX2VkaWQoY29ubmVjdG9yKTsKIDY1ICAgICAgICAgICAgICAgICBhbWRn
cHVfY29ubmVjdG9yX2dldF9lZGlkKGNvbm5lY3Rvcik7CgpNYXliZSB0aGUgZml4IGlzIHNsb3Bw
eSwgc28gSSB3cml0ZSB0aGUgYW5vdGhlciBwYXRjaDoKCiAxNiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Nvbm5lY3RvcnMuYwpiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9jb25uZWN0b3JzLmMKIDE3IGluZGV4IGM3NzBkNzMzNTJhNy4u
YmI1OWViYzlhNmM4IDEwMDY0NAogMTggLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2Nvbm5lY3RvcnMuYwogMTkgKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2Nvbm5lY3RvcnMuYwogMjAgQEAgLTk5MSw2ICs5OTEsNyBAQCBhbWRncHVfY29ubmVj
dG9yX2R2aV9kZXRlY3Qoc3RydWN0CmRybV9jb25uZWN0b3IgKmNvbm5lY3RvciwgYm9vbCBmb3Jj
ZSkKIDIxICAgICAgICAgaWYgKGFtZGdwdV9jb25uZWN0b3ItPmRkY19idXMpCiAyMiAgICAgICAg
ICAgICAgICAgZHJldCA9IGFtZGdwdV9kaXNwbGF5X2RkY19wcm9iZShhbWRncHVfY29ubmVjdG9y
LApmYWxzZSk7CiAyMyAgICAgICAgIGlmIChkcmV0KSB7CiAyNCArICAgICAgICAgICAgICAgc2No
ZWR1bGVfd29yaygmYWRldi0+aG90cGx1Z193b3JrKTsKIDI1ICAgICAgICAgICAgICAgICBhbWRn
cHVfY29ubmVjdG9yLT5kZXRlY3RlZF9ieV9sb2FkID0gZmFsc2U7CiAyNiAgICAgICAgICAgICAg
ICAgYW1kZ3B1X2Nvbm5lY3Rvcl9mcmVlX2VkaWQoY29ubmVjdG9yKTsKIDI3ICAgICAgICAgICAg
ICAgICBhbWRncHVfY29ubmVjdG9yX2dldF9lZGlkKGNvbm5lY3Rvcik7CgpXaGljaCBpcyBiZXR0
ZXIsIG9yIG5laXRoZXLvvJ8KCi0tClJlZ2FyZHMsCkFhcm9uCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
