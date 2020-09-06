Return-Path: <SRS0=0ArA=CP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C8DC43461
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Sep 2020 23:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A32C20760
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Sep 2020 23:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPHC7IkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A32C20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D57B6E037;
	Sun,  6 Sep 2020 23:47:43 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 121496E037
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Sep 2020 23:47:42 +0000 (UTC)
Received: by mail-ej1-x642.google.com with SMTP id gr14so14689232ejb.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 06 Sep 2020 16:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BErlCeb6kZWkR6notF6QfhWvhNkxg+Rn4sUwcHHliBw=;
 b=lPHC7IkM8AYw1v1L5kPQ5828n/FA5VMtSLwZsTaffItL+iw2YyDM1WPjQsiWuuXICb
 capmOP9YiXpYr6vmXbQb/ikz2GkxAMuc5NJsL5gcH/5/R/M/h0C5t53CzpcnmCZreKaW
 i/bWYYyEq00ZJgTfa/fLQxsBKAqb5gk4gMuAY2XMGssazjheCvU93nSfPZuXqkCaqCgN
 M9J2Y4DNBf0B0l/LHdGH6RgkWwZHb1DaKkyElPhaP1wSz9bgRkfE1bKcxuZ7aYK5ovOq
 mWvNmc51dXAMtWGA+rBsUgEg8SfTMMx9Jdx4THjEId2eVzNje+kD5hNiYYqG4Bnfp8az
 DKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BErlCeb6kZWkR6notF6QfhWvhNkxg+Rn4sUwcHHliBw=;
 b=c/Bs5iaAYBuNkMp7CQzx99Rf62aA9O8ojCaVolz4ODYy+yvet8dBv2G3IiG8748gZv
 CpZpdARxIDbiSsM3Qm0beAvhxL4v5bdZYX/JhEtg9NSpd8yLpw9KXEJ0bWsVcVX2OHib
 kNWykwDVCpMSiThhUMpw96rid2ar5FwkNjodBMeSSgnvPNWDN/BTylen0Azgm4B3dZEz
 L+ZFIFRHxTkZsh7R3ALlGKkWngDo+sKwUvwzEAhPBDNEwHF1jUPa2Xo7dm4mafMdU9CH
 JNcskDcc0ie8j+o9KTyFIIQ4UAYghyWFHRuras4P3Oza2GGhBFXmJTL64zPL6yPPF6Je
 DkRg==
X-Gm-Message-State: AOAM533sSbCgc5oLxfjer/d4exdCPmjtpjDMi8IxwMo56GASJrsFdZVi
 oZpgAGvvE5u3yjTFQpxPfecPJgln1a+SD+xjTIg=
X-Google-Smtp-Source: ABdhPJwavXjJsB0YtGCN0kXmtiUcvAPcFUvdpOTKRf2+4g2Tdrq4LGo8TZM9fTsw3kqQFa2wQ+7nwXjz0AXSUfFHs9s=
X-Received: by 2002:a17:906:1c4f:: with SMTP id
 l15mr18224233ejg.419.1599436060545; 
 Sun, 06 Sep 2020 16:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190803000908.5310-1-andi@firstfloor.org>
 <47558836-612d-75e3-c4a8-7b8baf53036d@gmail.com>
In-Reply-To: <47558836-612d-75e3-c4a8-7b8baf53036d@gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 7 Sep 2020 09:47:28 +1000
Message-ID: <CAPM=9tw4Md4j95+Zk6LbCZkyj6AFPZSuXacpY3MEabgu20S6Lw@mail.gmail.com>
Subject: Re: [PATCH] radeon: Use only a single work queue thread for crt
To: "Koenig, Christian" <christian.koenig@amd.com>
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
 Andi Kleen <ak@linux.intel.com>, Andi Kleen <andi@firstfloor.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gU3VuLCA2IFNlcCAyMDIwIGF0IDE4OjU0LCBDaHJpc3RpYW4gS8O2bmlnCjxja29lbmlnLmxl
aWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBBbSAwMy4wOC4xOSB1bSAwMjowOSBz
Y2hyaWViIEFuZGkgS2xlZW46Cj4gPiBGcm9tOiBBbmRpIEtsZWVuIDxha0BsaW51eC5pbnRlbC5j
b20+Cj4gPgo+ID4gSSBnb3QgdGlyZWQgb2Ygc2VlaW5nIGEgbG90IG9mIHJhZGVvbi1jcnQga2Vy
bmVsIHRocmVhZHMgaW4gcHMgb24gbXkKPiA+IHdvcmtzdGF0aW9uLCBvbmUgZm9yIGVhY2ggQ1BV
IGFuZCBvbmUgZm9yIGVhY2ggZGlzcGxheSwgd2hpY2ggbmV2ZXIgdXNlIGFueSBDUFUgdGltZS4K
PiA+IFN1cmVseSBhIHNpbmdsZSBrZXJuZWwgdGhyZWFkIGlzIGVub3VnaCB0byBoYW5kbGUgdGhl
IGRpc3BsYXkuCj4KPiBOQUssIHJhZGVvbiBibG9ja3MgaW5zaWRlIHRoZSBrZXJuZWwgdGhyZWFk
IGFuZCB0aG9zZSBuZWVkIHRvIHJ1biBpbgo+IHBhcmFsbGVsIG9yIG90aGVyd2lzZSB0aGUgaGFy
ZHdhcmUgY2FuIGhhbmcuCgpEbyB3ZSBuZWVkIG9uZSBwZXIgY3B1PyBvciBpcyBvbmUgcGVyIGNy
dGMgZW5vdWdoPwoKRGF2ZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
