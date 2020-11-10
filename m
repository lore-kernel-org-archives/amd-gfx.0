Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FC9C55ABD
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 20:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD1420731
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 20:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AT7A+sdz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD1420731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 013ED89C5E;
	Tue, 10 Nov 2020 20:08:54 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7C1389C55;
 Tue, 10 Nov 2020 20:08:52 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id 33so14098667wrl.7;
 Tue, 10 Nov 2020 12:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=s+aRaf/umltBKE+6wKwCltWBTDsHe6mFK5nuqJMfHRM=;
 b=AT7A+sdzPTebSa8CRPKagqX5MZY14t7gK6NGGqSdR7qAhUjMzNXYlJBQ6hjpk7v1wM
 BAYpLc4Bm2ztIC+0pH9PK/lzqxNzvtrboUOiQR4nTPh8tmEVWqyVESEqLWvlfWxuvmhn
 57yB0LUlyGh/qrr54mGQzHNMO5a2KDm4j5Y5RtNftz/Dm64LT3ISGsgeJOBYgkG6eBwa
 9JVIRcKLc7VM1yq/XOyY5D60scIF1p+iLGHYzs0DzruASiViVMz1DExZonwRXNJNXChk
 SyMaxz7KbD2K6lJ32lQJViaCbmvLljOzB2/SfL7O2Zu+Y8+p+5Y3uIExfmkwdvfH5trI
 BLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=s+aRaf/umltBKE+6wKwCltWBTDsHe6mFK5nuqJMfHRM=;
 b=Wl5DPeyrY7hx+yqXPZwjMKFzAZGpus6y7DBs6q0DJ2fwZD25TSND8yjdoHPHabBpgO
 Amrj4OMTS2vnF/XrrNEIXpHaW3MlLLXNVJW1WLEqWNhQ/hAASoSW1smZvyqoPdkjfHNG
 NF6WIjdNC0LGnz1MyKhUcxm3FBxJdvrJUMRNgAGjEtmytZLZELwxlVvT0eK44xZCQYyE
 /bQsGPLmGob+JG8uIs3UCkVEpYea43fH5WdCUpGZTSTG5mtJRYm7RXpgjhAM/fsIH/21
 x4bZMUj5J4BpFZr+DXQkCybudXV6bZfXpx+gwSl/SYuFzz6hjRW/zwq/Yz1DU3294p0n
 lX0Q==
X-Gm-Message-State: AOAM533kPzuNjVP55kO5rvnZZwMYpS+jraNFBXkK+gmb5c5WntpRKrMA
 nvf2Q3wo0GikowVpwl1mwAVPezKHDJt703av5hA=
X-Google-Smtp-Source: ABdhPJwrSX9xukmOEZt2t2UgYrm/3CRwEzEeuKzkuwExrEkQQhfxYFbx4SD1FE77XopCiFFi8l8EdIAeX1AKCRVCXXg=
X-Received: by 2002:adf:e551:: with SMTP id z17mr26546390wrm.374.1605038931452; 
 Tue, 10 Nov 2020 12:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20201109211855.3340030-1-lee.jones@linaro.org>
 <20201109211855.3340030-16-lee.jones@linaro.org>
 <CADnq5_NvitEQWH3Z+5EgOH3zJn=P5YTqwHQo4LLQLi0Hj0Dpww@mail.gmail.com>
 <20201110072242.GF2063125@dell> <20201110090247.GB2027451@ravnborg.org>
 <20201110094111.GG2063125@dell>
In-Reply-To: <20201110094111.GG2063125@dell>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Nov 2020 15:08:40 -0500
Message-ID: <CADnq5_PYERS0xHJGQrpokDD7q3GgidSYqSrOoskza7gST4bbmQ@mail.gmail.com>
Subject: Re: [PATCH 15/20] drm/radeon/r600d: Move 'rc600_*' prototypes into
 shared header
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Sam Ravnborg <sam@ravnborg.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBOb3YgMTAsIDIwMjAgYXQgNDo0MSBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IE9uIFR1ZSwgMTAgTm92IDIwMjAsIFNhbSBSYXZuYm9yZyB3cm90
ZToKPgo+ID4gSGkgTGVlLAo+ID4KPiA+ID4gPiB0aGUgKmQuaCBoZWFkZXJzIGFyZSBzdXBwb3Nl
ZCB0byBqdXN0IGJlIGhhcmR3YXJlIGRlZmluaXRpb25zLiAgSSdkCj4gPiA+ID4gcHJlZmVyIHRv
IGtlZXAgZHJpdmVyIHN0dWZmIG91dCBvZiB0aGVtLgo+ID4gPgo+ID4gPiBUaGF0J3MgZmluZSAo
SSBkaWQgd29uZGVyIGlmIHRoYXQgd2VyZSB0aGUgY2FzZSkuCj4gPiA+Cj4gPiA+IEkgbmVlZCBh
biBhbnN3ZXIgZnJvbSB5b3UgYW5kIFNhbSB3aGV0aGVyIEkgY2FuIGNyZWF0ZSBuZXcgaGVhZGVy
cy4KPiA+ID4KPiA+ID4gRm9yIG1lLCBpdCBpcyB0aGUgcmlnaHQgdGhpbmcgdG8gZG8uCj4gPgo+
ID4gUGxlYXNlIGZvbGxvdyB0aGUgYWR2aWNlIG9mIEFsZXggZm9yIHRoZSByYWRlb24gZHJpdmVy
Lgo+Cj4gR3JlYXQuICBUaGFua3MgZm9yIHJlc29sdmluZyB0aGlzIFNhbS4KPgo+IFdpbGwgZml4
IGFsbCBvY2N1cnJlbmNlcy4KCkknbSBub3QgcmVhbGx5IGZvbGxvd2luZyB0aGVzZSBwYXRjaCBz
ZXRzIHlvdSBhcmUgc2VuZGluZyBvdXQuICBUaGV5CmFsbCBzZWVtIGNvbXBsZXRlbHkgaW5kZXBl
bmRlbnQuICBJIHdhcyBleHBlY3RpbmcgdXBkYXRlZCB2ZXJzaW9ucwp3aXRoIGZlZWRiYWNrIGlu
dGVncmF0ZWQsIGJ1dCB0aGV5IHNlZW0gdG8gYmUganVzdCBkaWZmZXJlbnQgZml4ZXMuCkFyZSB5
b3UgcGxhbm5pbmcgdG8gc2VuZCBvdXQgdXBkYXRlZCB2ZXJzaW9ucyBiYXNlZCBvbiBmZWVkYmFj
ayBmcm9tCnRoZXNlIHNlcmllcz8gIEFsc28sIHNvbWUgb2YgdGhlIHBhdGNoZXMgaGF2ZSBzdWJ0
bGUgZXJyb3JzIGluIHRoZW0KKGUuZy4sIHdyb25nIGRlc2NyaXB0aW9ucyBvZiB2YXJpYWJsZXMs
IHdyb25nIGNvcHlyaWdodCBoZWFkZXJzIG9uIG5ldwpmaWxlcywgZXRjLiksIGRvIHlvdSBtaW5k
IGlmIEkgZml4IHRoZW0gdXAgbG9jYWxseSB3aGVuIGFwcGx5aW5nIG9yCndvdWxkIHlvdSByYXRo
ZXIgSSBwb2ludCBvdXQgdGhlIGNoYW5nZXMgYW5kIHlvdSBjYW4gaW50ZWdyYXRlIHRoZW0KYW5k
IHJlc2VuZD8KClRoYW5rcywKCkFsZXgKCj4KPiAtLQo+IExlZSBKb25lcyBb5p2O55C85pavXQo+
IFNlbmlvciBUZWNobmljYWwgTGVhZCAtIERldmVsb3BlciBTZXJ2aWNlcwo+IExpbmFyby5vcmcg
4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBcm0gU29Dcwo+IEZvbGxvdyBMaW5hcm86IEZh
Y2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
