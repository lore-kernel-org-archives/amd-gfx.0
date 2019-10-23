Return-Path: <SRS0=+G2B=YQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1307DCA9EB6
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2019 14:19:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E86A721872
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2019 14:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86A721872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AF5D6EAE0;
	Wed, 23 Oct 2019 14:19:52 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53A506EADD;
 Wed, 23 Oct 2019 14:19:51 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id v3so6445485wmh.1;
 Wed, 23 Oct 2019 07:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=BVPreT9QYJ5eQLGe7J+waVfERj1ZOhD2EAQwCTScRgI=;
 b=Wceu64ZLrgm9oenU1wFPBOR+Wq+QjQbkV8R8fPFmlEnTgzGg7oXfCEfU+DiY6pH+iR
 7XTFnJ354HJmRuxYSgNjTGsjXUwZDCK4yD8TtP03ns1rZnge0i1AcviIoGD8CDbkjdxM
 mX3+Ib7B9WRtvswBp0uQCSiY+xE3K135ECAx4XyDxom75Vqkjfu/GNUCtKabuONN3tIQ
 4Oua27ovSgyljI1dJ0OD8AktGeZzR94EvDuenKLruAp7KDaaEtr3apMlVqmH6JSDPj/Y
 KyvBtx0wq3kUwc7PqMIEwkm/SZntRncJW0Pc0h0YlzbGwWIXF82APMdMgiK+B0wYTTb5
 5GsQ==
X-Gm-Message-State: APjAAAXtKRs0x1gQJeSpM+Qqo9RIJZHIMcnoxdjNDxeY9H+W2jROAlIJ
 xsbiUWwG83NPlu/LQRVIauM=
X-Google-Smtp-Source: APXvYqxfjpzsmxskN4iv+8uliC71LZO+kAWz4dwfkd8OGJ2MNOIGW3WYSNHhkYHwAOXRhvKOoswK/A==
X-Received: by 2002:a1c:7917:: with SMTP id l23mr157405wme.60.1571840389908;
 Wed, 23 Oct 2019 07:19:49 -0700 (PDT)
Received: from [192.168.0.10] (ip-89-177-253-111.net.upcbroadband.cz.
 [89.177.253.111])
 by smtp.gmail.com with ESMTPSA id a17sm19350370wrx.84.2019.10.23.07.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 07:19:49 -0700 (PDT)
Message-ID: <eb513969cc86a42a9be95e4ff7f3473eb24d6d4a.camel@gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Add DC feature mask to disable
 fractional pwm
From: =?UTF-8?Q?Luk=C3=A1=C5=A1_Krej=C4=8D=C3=AD?= <lskrejci@gmail.com>
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Date: Wed, 23 Oct 2019 16:19:48 +0200
In-Reply-To: <20191021194414.24627-1-sunpeng.li@amd.com>
References: <20191021193743.24339-1-sunpeng.li@amd.com>
 <20191021194414.24627-1-sunpeng.li@amd.com>
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=BVPreT9QYJ5eQLGe7J+waVfERj1ZOhD2EAQwCTScRgI=;
 b=m4bpbe5Ycx6gHOwC92Iq0FkEn91NCdjjw5DmdCRhgNLmYhnWIeh/W7pdBIlni3ozDx
 4P7czGnoLH6MdWfxGxmSFQmuPOl1+YThNjT5J10nno7CPrFaoBIL2ag/d+DkVD19FbSF
 Plha7ivB0KKTMWAm3yQkyY3J50mBtxtO5bvmHJbXLBm5x3NfnKoAD/vmZY1xg6BjIFh0
 Y9COmuIJDP1oNWtSSJsDHKiMehUZKlIsO10z9kpKhJux1AlXtizrDcNvX8OhuzE/KKfj
 GnuMAQYfJ/f1mJGjfWY4cQLzt628njD82iLJDcn0+Zgoqtk4gtsoD9sBa+CFZ8qsB76Y
 iVnA==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: harry.wentland@amd.com, Anthony.Koo@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191023141948.KW2NkXA8kqDrgN7PWgZ8kV4j8YUWxd6MMaYWzibRer0@z>

T24gTW9uLCAyMDE5LTEwLTIxIGF0IDE1OjQ0IC0wNDAwLCBzdW5wZW5nLmxpQGFtZC5jb20gd3Jv
dGU6Cj4gRnJvbTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Cj4gCj4gW1doeV0KPiAKPiBT
b21lIExFRCBwYW5lbCBkcml2ZXJzIG1pZ2h0IG5vdCBsaWtlIGZyYWN0aW9uYWwgUFdNLiBJbiBz
dWNoIGNhc2VzLAo+IGJhY2tsaWdodCBmbGlja2VyaW5nIG1heSBiZSBvYnNlcnZlZC4KPiAKPiBb
SG93XQo+IAo+IEFkZCBhIERDIGZlYXR1cmUgbWFzayB0byBkaXNhYmxlIGZyYWN0aW9uYWwgUFdN
LCBhbmQgYXNzb2NpYXRlIGl0IHdpdGgKPiB0aGUgcHJlZXhpc3RpbmcgZGNfY29uZmlnIGZsYWcu
Cj4gCj4gVGhlIGZsYWcgaXMgb25seSBwbHVtYmVkIHRocm91Z2ggdGhlIGRtY3UgZmlybXdhcmUs
IHNvIHBsdW1iIGl0IHRocm91Z2gKPiB0aGUgZHJpdmVyIHBhdGggYXMgd2VsbC4KPiAKPiBUbyBk
aXNhYmxlLCBhZGQgdGhlIGZvbGxvd2luZyB0byB0aGUgbGludXggY21kbGluZToKPiBhbWRncHUu
ZGNmZWF0dXJlbWFzaz0weDQKPiAKPiBCdWd6aWxsYTogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwu
b3JnL3Nob3dfYnVnLmNnaT9pZD0yMDQ5NTcKPiBTaWduZWQtb2ZmLWJ5OiBMZW8gTGkgPHN1bnBl
bmcubGlAYW1kLmNvbT4KPiAtLS0KPiAKPiB2MjogQWRkIGJ1Z3ppbGxhIGxpbmsKPiAKPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDMgKysrCj4g
IGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2FibS5jICAgICAgfCA0ICsr
KysKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQuaCAgICAgICAgICB8
IDEgKwo+ICAzIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQoKVGVzdGVkIG9uIFVidW50
dSAxOS4wNCwgdmFuaWxsYSB2NS4zLjcga2VybmVsIHdpdGggdGhlIHBhdGNoIGFwcGxpZWQKYW5k
IGFtZGdwdS5kY2ZlYXR1cmVtYXNrPTB4NCBhZGRlZCB0byB0aGUga2VybmVsIGNvbW1hbmQgbGlu
ZSwgbm8KaXNzdWVzIGFmdGVyIDggcmVib290cy4gKFRoZSBpc3N1ZSBjb3VsZCBiZSByZXByb2R1
Y2VkIHdpdGhvdXQKYW1kZ3B1LmRjZmVhdHVyZW1hc2s9MHg0IG9uIGZpcnN0IGJvb3QuKQoKVGVz
dGVkLWJ5OiBMdWvDocWhIEtyZWrEjcOtIDxsc2tyZWpjaUBnbWFpbC5jb20+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
