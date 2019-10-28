Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCE8CA9EBC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 06:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD0120873
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 06:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD0120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C4686E0F6;
	Mon, 28 Oct 2019 06:25:25 +0000 (UTC)
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D3136E0F6;
 Mon, 28 Oct 2019 06:25:23 +0000 (UTC)
Received: by mail-lf1-x143.google.com with SMTP id f5so6901217lfp.1;
 Sun, 27 Oct 2019 23:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=U5RAXoFel6JiFEul8P59gVQ3AePT+MtgQnCRwa3TQX4=;
 b=Kmfnl5OkJOJv7U+giGA6OklN76gRYC61QYsKLOvHW0I5fYCg1SnqueCDOerwNvXDvY
 vXPvk6TxC+gQ8SMjXrQ+nD3e7O39NR4hbDjyZ1Ps7KKQeGh1fThCnUbAAd1DRyr+peYQ
 UTsRDZsEfJXZuNAF4O8w5fO3rIrGezW6x/xsOdLUAOSXPazzzqtbllDDjNl/sG135mnF
 oW3gdiO/ksPQXndKqQrQmEfr4cYgLaXaSiCmXNKvR3wmsB4kyIf8XDQ3Gw3dZQgp7Rp8
 iPXO64yaogxBwGFABxLEOQ5HFlkFP7k/DVJ/uM44aWG70ct2mX3ZFBwJr9JjNMma8pe2
 JHtg==
X-Gm-Message-State: APjAAAWF5LhPuPlGR4Da/1N/PzFi1O8nYYn7aKc2rnXkiY47DkdmVHk+
 xBsiKGPdVQkmP5U+C7FXE6c=
X-Google-Smtp-Source: APXvYqw0j0UrHTIHan0AsvKi6C9ZtF4b4usbEQKMeS5HlaSqNkgZbkrJaFwaQtl9Hf/UEroMopycIQ==
X-Received: by 2002:a19:f107:: with SMTP id p7mr9997330lfh.91.1572243921372;
 Sun, 27 Oct 2019 23:25:21 -0700 (PDT)
Received: from [10.17.182.20] (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
 by smtp.gmail.com with ESMTPSA id
 u11sm1583705ljo.17.2019.10.27.23.25.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 27 Oct 2019 23:25:20 -0700 (PDT)
Subject: Re: [Xen-devel] [PATCH hmm 08/15] xen/gntdev: Use select for
 DMA_SHARED_BUFFER
To: Jason Gunthorpe <jgg@mellanox.com>,
 Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
 =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191015181242.8343-9-jgg@ziepe.ca>
 <6f60f558-20db-1749-044d-a46697258c39@suse.com>
 <91329d7d-9db5-057e-59d2-887254083da0@epam.com>
 <20191021191219.GJ6285@mellanox.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <3a53baa5-bc1d-e901-2792-8d51753391ff@gmail.com>
Date: Mon, 28 Oct 2019 08:25:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021191219.GJ6285@mellanox.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=U5RAXoFel6JiFEul8P59gVQ3AePT+MtgQnCRwa3TQX4=;
 b=Z1HmAxnfzdn9FoQZf+DyMDvMHJwLLsWJJUbPsWqENApbZymOmVxPjl1lOC4ePEDbeB
 U/S7eBT811AEPMeNkzgnKZ7Nlyr9+Thkld05BkFnmTBLG5VMJ+lMdrPfv96tMSDun4zD
 gduvO7L+Cozwk5XGL69xPZUzEZrkTh22aOqqX7gweGuFhisM9k/4NDzSIQf0Qxhj1QBz
 ibZfwCVSnyC5pAf/VxQ19qnGlIkLcjiBWCpW/usyvrtjaUFK2qCWpM2u3B76N8ABYRDC
 kiBhgF+AeBONyDxDgTxRYZfIUiHOEvvl0mq4LArLAT23Vp2jDCzAD49x09Z9fGC3pCkc
 J2VQ==
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
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Ralph Campbell <rcampbell@nvidia.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 John Hubbard <jhubbard@nvidia.com>,
 "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Jerome Glisse <jglisse@redhat.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Ben Skeggs <bskeggs@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028062519.A7rVkyjGR1_9Kr8F4xQHglsgwx-nS3QjE459xK99hfo@z>

T24gMTAvMjEvMTkgMTA6MTIgUE0sIEphc29uIEd1bnRob3JwZSB3cm90ZToKPiBPbiBXZWQsIE9j
dCAxNiwgMjAxOSBhdCAwNjozNToxNUFNICswMDAwLCBPbGVrc2FuZHIgQW5kcnVzaGNoZW5rbyB3
cm90ZToKPj4gT24gMTAvMTYvMTkgODoxMSBBTSwgSsO8cmdlbiBHcm/DnyB3cm90ZToKPj4+IE9u
IDE1LjEwLjE5IDIwOjEyLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6Cj4+Pj4gRnJvbTogSmFzb24g
R3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPgo+Pj4+Cj4+Pj4gRE1BX1NIQVJFRF9CVUZGRVIg
Y2FuIG5vdCBiZSBlbmFibGVkIGJ5IHRoZSB1c2VyIChpdCByZXByZXNlbnRzIGEKPj4+PiBsaWJy
YXJ5Cj4+Pj4gc2V0IGluIHRoZSBrZXJuZWwpLiBUaGUga2NvbmZpZyBjb252ZW50aW9uIGlzIHRv
IHVzZSBzZWxlY3QgZm9yIHN1Y2gKPj4+PiBzeW1ib2xzIHNvIHRoZXkgYXJlIHR1cm5lZCBvbiBp
bXBsaWNpdGx5IHdoZW4gdGhlIHVzZXIgZW5hYmxlcyBhIGtjb25maWcKPj4+PiB0aGF0IG5lZWRz
IHRoZW0uCj4+Pj4KPj4+PiBPdGhlcndpc2UgdGhlIFhFTl9HTlRERVZfRE1BQlVGIGtjb25maWcg
aXMgb3Zlcmx5IGRpZmZpY3VsdCB0byBlbmFibGUuCj4+Pj4KPj4+PiBGaXhlczogOTMyZDY1NjIx
NzllICgieGVuL2dudGRldjogQWRkIGluaXRpYWwgc3VwcG9ydCBmb3IgZG1hLWJ1ZiBVQVBJIikK
Pj4+PiBDYzogT2xla3NhbmRyIEFuZHJ1c2hjaGVua28gPG9sZWtzYW5kcl9hbmRydXNoY2hlbmtv
QGVwYW0uY29tPgo+Pj4+IENjOiBCb3JpcyBPc3Ryb3Zza3kgPGJvcmlzLm9zdHJvdnNreUBvcmFj
bGUuY29tPgo+Pj4+IENjOiB4ZW4tZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmcKPj4+PiBDYzog
SnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPgo+Pj4+IENjOiBTdGVmYW5vIFN0YWJlbGxp
bmkgPHNzdGFiZWxsaW5pQGtlcm5lbC5vcmc+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogSmFzb24gR3Vu
dGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPgo+Pj4gUmV2aWV3ZWQtYnk6IEp1ZXJnZW4gR3Jvc3Mg
PGpncm9zc0BzdXNlLmNvbT4KPj4+Cj4+IFJldmlld2VkLWJ5OiBPbGVrc2FuZHIgQW5kcnVzaGNo
ZW5rbyA8b2xla3NhbmRyX2FuZHJ1c2hjaGVua29AZXBhbS5jb20+Cj4gVGhhbmtzIE9sZWtzYW5k
ciBhbmQgSnVlcmdlbiwgY2FuIHlvdSBhbHNvIGdpdmUgbWUgc29tZSBhZHZpY2Ugb24gaG93Cj4g
dG8gcHJvZ3Jlc3MgdGhlIG1vcmUgY29tcGxleCBwYXRjaDoKPgo+IGh0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvcGF0Y2gvMTExOTEzNjkvCj4KPiBJcyB0aGlzIGdudGRldiBzdHVmZiBzdGls
bCBpbi11c2U/IEkgc3RydWdnbGVkIGEgYml0IHRvIHVuZGVyc3RhbmQKPiB3aGF0IGl0IGlzIGRv
aW5nLCBidXQgSSB0aGluayBJIG1hZGUgYSByZWFzb25hYmxlIGd1ZXNzPwpJIHRoaW5rIEp1cmdl
biBhbmQgQm9yaXMgY291bGQgaGVscCBoZXJlCj4gSmFzb24KPiBfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IFhlbi1kZXZlbCBtYWlsaW5nIGxpc3QKPiBY
ZW4tZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmcKPiBodHRwczovL2xpc3RzLnhlbnByb2plY3Qu
b3JnL21haWxtYW4vbGlzdGluZm8veGVuLWRldmVsCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZng=
