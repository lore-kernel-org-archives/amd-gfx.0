Return-Path: <SRS0=VQNv=YW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CF4CA9EC4
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 14:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E6A20830
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 14:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E6A20830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C6B06E1EE;
	Tue, 29 Oct 2019 14:23:54 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F77A6E3F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2019 13:59:39 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id m125so8345338qkd.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2019 06:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8jOH6aTboFzH2FE5ebDVzGbVS8tkTfz/e6O//bI0tkY=;
 b=R7Mo4pWftJN0AOT0UJJyVX7wpsDym9+7O+mUjdcCLYNYUxeyH5vAtR5Q7yIb1kYOv5
 ulm2+hEII/asaDBvvUPuQxG/Cj/3Rgnc3S9xT7x9bbtEw70+vwOeLiP3iId1aAQNLPPT
 d9YsJoRn2ZAJF/Fh+iNXJ+CFGXyrdeiOcUg5y88/cd18bZ+13HvWkdUDo296lfncT+vw
 EVW1i2Q/p/t/oq0mT//hIECZECDWJsIiZHSICgkaGi+FgUta8rosA8grecjJ4B5UItEl
 ZOeghj2JyUmjcW5oCfH0uK2ecYM6zsLuK/SczV+AfvywFTt5nPMG57mWmtV5USCBCFuR
 MQCw==
X-Gm-Message-State: APjAAAVNrzFWRMNhKKH/UNcexTWpMEd2TfT6RMqZI3oSZR087LbPI9wT
 3Y4JWbtaeEzUAME/1o8lzMSiXg==
X-Google-Smtp-Source: APXvYqw2t3qlIvqK+Izwy8tw608BKfVw2jgQ/Y0rREEshgcaboVymXi/nbliXAwFtIZ8GNBEqxuwOw==
X-Received: by 2002:a05:620a:8cb:: with SMTP id
 z11mr15146993qkz.72.1572357577964; 
 Tue, 29 Oct 2019 06:59:37 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.180])
 by smtp.gmail.com with ESMTPSA id p188sm7446102qkb.33.2019.10.29.06.59.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Oct 2019 06:59:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1iPS24-0005x3-D2; Tue, 29 Oct 2019 10:59:36 -0300
Date: Tue, 29 Oct 2019 10:59:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH v2 13/15] drm/amdgpu: Use mmu_range_insert instead of
 hmm_mirror
Message-ID: <20191029135936.GD6128@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-14-jgg@ziepe.ca>
 <bc44f331-5448-ddc0-ecc3-d0ccb92e11a4@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bc44f331-5448-ddc0-ecc3-d0ccb92e11a4@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Tue, 29 Oct 2019 14:23:52 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8jOH6aTboFzH2FE5ebDVzGbVS8tkTfz/e6O//bI0tkY=;
 b=TOjiKaf4drtV5ldH8zR3DdZRftx4pfyMK7aX+WxF+hP7GAklHNLQJLB3u6THZAuUwq
 2J8U2Z8jfa4RHHqJi86VA8XDEEftIwINME4Xcqo7Lwf5TfQ/5CHndbgRjMZBi7ltmTD/
 9/OIdOP+IKZBXBOnw95rEg1RRCcplq0VveMXmbgEcrW0nIfOMVnpZGUZJC/dcmVtrcLp
 GnztoS4X7Cig0PpARFdiBQAFwuPsNE3oq28XslCe7YAiytEpFuhH3cYXFITze125lBn3
 w8SiavcWCCYZB5EGHirP4nTYv97GbqlF/YYAtwW9ZFYvfLIJ06XZktP4ccL77Rn8KbAv
 rdng==
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
Cc: Juergen Gross <jgross@suse.com>, "Zhou,
 David\(ChunMing\)" <David1.Zhou@amd.com>,
 Ralph Campbell <rcampbell@nvidia.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 John Hubbard <jhubbard@nvidia.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 Mike Marciniszyn <mike.marciniszyn@intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Christoph Hellwig <hch@infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Jerome Glisse <jglisse@redhat.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Petr Cvek <petrcvekcz@gmail.com>,
 Dennis Dalessandro <dennis.dalessandro@intel.com>,
 Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191029135936.G_rfpQu0gysV-Fct12z9UmpLYcVQldXOxOLFTzgGm_U@z>

T24gVHVlLCBPY3QgMjksIDIwMTkgYXQgMDc6NTE6MzBBTSArMDAwMCwgS29lbmlnLCBDaHJpc3Rp
YW4gd3JvdGU6Cj4gPiArc3RhdGljIGJvb2wgYW1kZ3B1X21uX2ludmFsaWRhdGVfZ2Z4KHN0cnVj
dCBtbXVfcmFuZ2Vfbm90aWZpZXIgKm1ybiwKPiA+ICsJCQkJICAgICBjb25zdCBzdHJ1Y3QgbW11
X25vdGlmaWVyX3JhbmdlICpyYW5nZSkKPiA+ICAgewo+ID4gLQlzdHJ1Y3QgYW1kZ3B1X2JvICpi
bzsKPiA+ICsJc3RydWN0IGFtZGdwdV9ibyAqYm8gPSBjb250YWluZXJfb2YobXJuLCBzdHJ1Y3Qg
YW1kZ3B1X2JvLCBub3RpZmllcik7Cj4gPiArCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0g
YW1kZ3B1X3R0bV9hZGV2KGJvLT50Ym8uYmRldik7Cj4gPiAgIAlsb25nIHI7Cj4gPiAgIAo+ID4g
LQlsaXN0X2Zvcl9lYWNoX2VudHJ5KGJvLCAmbm9kZS0+Ym9zLCBtbl9saXN0KSB7Cj4gPiAtCj4g
PiAtCQlpZiAoIWFtZGdwdV90dG1fdHRfYWZmZWN0X3VzZXJwdHIoYm8tPnRiby50dG0sIHN0YXJ0
LCBlbmQpKQo+ID4gLQkJCWNvbnRpbnVlOwo+ID4gLQo+ID4gLQkJciA9IGRtYV9yZXN2X3dhaXRf
dGltZW91dF9yY3UoYm8tPnRiby5iYXNlLnJlc3YsCj4gPiAtCQkJdHJ1ZSwgZmFsc2UsIE1BWF9T
Q0hFRFVMRV9USU1FT1VUKTsKPiA+IC0JCWlmIChyIDw9IDApCj4gPiAtCQkJRFJNX0VSUk9SKCIo
JWxkKSBmYWlsZWQgdG8gd2FpdCBmb3IgdXNlciBib1xuIiwgcik7Cj4gPiAtCX0KPiA+ICsJLyog
RklYTUU6IElzIHRoaXMgbmVjZXNzYXJ5PyAqLwo+IAo+IE1vc3QgbGlrZWx5IG5vdC4KPiAKPiBD
aHJpc3RpYW4uCj4gCj4gPiArCWlmICghYW1kZ3B1X3R0bV90dF9hZmZlY3RfdXNlcnB0cihiby0+
dGJvLnR0bSwgcmFuZ2UtPnN0YXJ0LAo+ID4gKwkJCQkJICByYW5nZS0+ZW5kKSkKPiA+ICsJCXJl
dHVybiB0cnVlOwoKU28gaXMgdGhlIGJvLT50Ym8ubWVtLm51bV9wYWdlcyA9PSBiby0+dGJvLnR0
bS5udW1fcGFnZXMgYWx3YXlzPwoKQW5kIHVzZXJwdHIgY2FuJ3QgYmUgemVybyBoZXJlLCBvciBh
dCBsZWFzdCBpdCBkb2Vzbid0IG1hdHRlciBpZiBpdCBpcz8KCj4gPiArc3RhdGljIGJvb2wgYW1k
Z3B1X21uX2ludmFsaWRhdGVfaHNhKHN0cnVjdCBtbXVfcmFuZ2Vfbm90aWZpZXIgKm1ybiwKPiA+
ICsJCQkJICAgICBjb25zdCBzdHJ1Y3QgbW11X25vdGlmaWVyX3JhbmdlICpyYW5nZSkKPiA+ICAg
ewo+ID4gLQlzdHJ1Y3QgYW1kZ3B1X21uICphbW4gPSBjb250YWluZXJfb2YobWlycm9yLCBzdHJ1
Y3QgYW1kZ3B1X21uLCBtaXJyb3IpOwo+ID4gLQl1bnNpZ25lZCBsb25nIHN0YXJ0ID0gdXBkYXRl
LT5zdGFydDsKPiA+IC0JdW5zaWduZWQgbG9uZyBlbmQgPSB1cGRhdGUtPmVuZDsKPiA+IC0JYm9v
bCBibG9ja2FibGUgPSBtbXVfbm90aWZpZXJfcmFuZ2VfYmxvY2thYmxlKHVwZGF0ZSk7Cj4gPiAt
CXN0cnVjdCBpbnRlcnZhbF90cmVlX25vZGUgKml0Owo+ID4gLQo+ID4gLQkvKiBub3RpZmljYXRp
b24gaXMgZXhjbHVzaXZlLCBidXQgaW50ZXJ2YWwgaXMgaW5jbHVzaXZlICovCj4gPiAtCWVuZCAt
PSAxOwo+ID4gLQo+ID4gLQkvKiBUT0RPIHdlIHNob3VsZCBiZSBhYmxlIHRvIHNwbGl0IGxvY2tp
bmcgZm9yIGludGVydmFsIHRyZWUgYW5kCj4gPiAtCSAqIGFtZGdwdV9tbl9pbnZhbGlkYXRlX25v
ZGUKPiA+IC0JICovCj4gPiAtCWlmIChhbWRncHVfbW5fcmVhZF9sb2NrKGFtbiwgYmxvY2thYmxl
KSkKPiA+IC0JCXJldHVybiAtRUFHQUlOOwo+ID4gLQo+ID4gLQlpdCA9IGludGVydmFsX3RyZWVf
aXRlcl9maXJzdCgmYW1uLT5vYmplY3RzLCBzdGFydCwgZW5kKTsKPiA+IC0Jd2hpbGUgKGl0KSB7
Cj4gPiAtCQlzdHJ1Y3QgYW1kZ3B1X21uX25vZGUgKm5vZGU7Cj4gPiAtCj4gPiAtCQlpZiAoIWJs
b2NrYWJsZSkgewo+ID4gLQkJCWFtZGdwdV9tbl9yZWFkX3VubG9jayhhbW4pOwo+ID4gLQkJCXJl
dHVybiAtRUFHQUlOOwo+ID4gLQkJfQo+ID4gKwlzdHJ1Y3QgYW1kZ3B1X2JvICpibyA9IGNvbnRh
aW5lcl9vZihtcm4sIHN0cnVjdCBhbWRncHVfYm8sIG5vdGlmaWVyKTsKPiA+ICsJc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYgPSBhbWRncHVfdHRtX2FkZXYoYm8tPnRiby5iZGV2KTsKPiA+ICAg
Cj4gPiAtCQlub2RlID0gY29udGFpbmVyX29mKGl0LCBzdHJ1Y3QgYW1kZ3B1X21uX25vZGUsIGl0
KTsKPiA+IC0JCWl0ID0gaW50ZXJ2YWxfdHJlZV9pdGVyX25leHQoaXQsIHN0YXJ0LCBlbmQpOwo+
ID4gKwkvKiBGSVhNRTogSXMgdGhpcyBuZWNlc3Nhcnk/ICovCj4gPiArCWlmICghYW1kZ3B1X3R0
bV90dF9hZmZlY3RfdXNlcnB0cihiby0+dGJvLnR0bSwgcmFuZ2UtPnN0YXJ0LAo+ID4gKwkJCQkJ
ICByYW5nZS0+ZW5kKSkKPiA+ICsJCXJldHVybiB0cnVlOwo+ID4gICAKPiA+IC0JCWFtZGdwdV9t
bl9pbnZhbGlkYXRlX25vZGUobm9kZSwgc3RhcnQsIGVuZCk7Cj4gPiAtCX0KClRoaXMgb25lIHRv
byByaWdodD8KCkphc29uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
