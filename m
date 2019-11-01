Return-Path: <SRS0=roBy=Y2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC73CA9EC7
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Nov 2019 15:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DBE720663
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Nov 2019 15:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBE720663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C91006E4CB;
	Sat,  2 Nov 2019 15:44:04 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2B4D6E2DA
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2019 19:20:01 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id a194so11686357qkg.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Nov 2019 12:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=GwL3BzOKq0ds1hKB7ElDSudCiv4GvOB/hy58iKY5/B8=;
 b=HDxA62XfZKrT8DhnrdCIEdr6388ur8rHCm9nRiICC8xHbqHKZjkUYHuCmqtJ2UP2tz
 BcIInk3O6cGh+OnqJ/0lZOba6v0CyNwJBEOF3EJ093aHhSKdkYVagFUccB2mry2uJGUT
 npv7oEsTVqLBIuaC5MTEc0l+o9M0b9PJ+b7WUBKh15ULftMfk7rrAokW1dohJD3UW9GM
 Ki85ZA9HIhDGkTHYdPJi6o3V+XpQGrkH/NhACQ9f4Sa/NdhjJBAPHulDEgWv28nAEloC
 TDD9wy2EQTdFaL40DuDoe3kyScTVrNrNsVmMCW+fEzo2kWLFvD6peujDXGb894TE4LWd
 z1lw==
X-Gm-Message-State: APjAAAWsrX3gU+e6xBbP9VusIRcn3GYduhOeFJbxuWA4YYcLLyxV14lY
 ES9Zq/Lrt5b94LBNhUOYBRETnw==
X-Google-Smtp-Source: APXvYqzEDkQfD72DvPVzNHUDGv0HzF9IhjVJJOU3fqLQvuuBBx1c6gvz8fC1Pmu9FXNbHzO5K/kLfA==
X-Received: by 2002:a37:a5d3:: with SMTP id
 o202mr11070822qke.283.1572636000661; 
 Fri, 01 Nov 2019 12:20:00 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.180])
 by smtp.gmail.com with ESMTPSA id n20sm4777802qkn.118.2019.11.01.12.19.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Nov 2019 12:19:59 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1iQcSl-0001WJ-Af; Fri, 01 Nov 2019 16:19:59 -0300
Date: Fri, 1 Nov 2019 16:19:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Yang, Philip" <Philip.Yang@amd.com>
Subject: Re: [PATCH v2 14/15] drm/amdgpu: Use mmu_range_notifier instead of
 hmm_mirror
Message-ID: <20191101191959.GC30938@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-15-jgg@ziepe.ca>
 <a456ebd0-28cf-997b-31ff-72d9077a9b8e@amd.com>
 <20191029192544.GU22766@mellanox.com>
 <30b2f569-bf7a-5166-c98d-4a4a13d1351f@amd.com>
 <20191101151222.GN22766@mellanox.com>
 <8280fb65-a897-3d71-79f9-9f80d9e474e9@amd.com>
 <20191101174221.GO22766@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191101174221.GO22766@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Sat, 02 Nov 2019 15:44:01 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=GwL3BzOKq0ds1hKB7ElDSudCiv4GvOB/hy58iKY5/B8=;
 b=kA4XkYghuc1JhsLIKqtgHvYOYkbQmmO6SYAQeEOYSvqnxdZ9jZjDhUnlYr3SdULzs/
 VoX2uPnnM2cxYanlj78zNtQ8A185ZcJgnYIuK+wcaBJKUjnadFHxwWHFnNobP8aT09Cn
 HnhVwCqE58/HmHF5+ja6RFYUyhDE8o8qki7WdccEAWeGPWKB8fIH17+S7MdnxhZ3jZwr
 y9zYt4pe9WYFRB7vGaJ1TV38vnomkwp60DMN7hZ5n6Ba4axjFUG3uuRMMSdF/nELroE0
 XD1ENSPS4tRu1keLPM7zbG3a+3hiST+P1cHzfwyt+Rx8K72rUFTYxupuLkm6utoV1HB1
 nhHA==
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
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191101191959.KzlNVCcr1y91URvza3gNht-ebs8rTu-Utj0hNjIVF6s@z>

T24gRnJpLCBOb3YgMDEsIDIwMTkgYXQgMDI6NDI6MjFQTSAtMDMwMCwgSmFzb24gR3VudGhvcnBl
IHdyb3RlOgo+IE9uIEZyaSwgTm92IDAxLCAyMDE5IGF0IDAzOjU5OjI2UE0gKzAwMDAsIFlhbmcs
IFBoaWxpcCB3cm90ZToKPiA+ID4gVGhpcyB0ZXN0IGZvciByYW5nZV9ibG9ja2FibGUgc2hvdWxk
IGJlIGJlZm9yZSBtdXRleF9sb2NrLCBJIGNhbiBtb3ZlCj4gPiA+IGl0IHVwCj4gPiA+IAo+ID4g
eWVzLCB0aGFua3MuCj4gCj4gT2theSwgSSB3cm90ZSBpdCBsaWtlIHRoaXM6Cj4gCj4gCWlmICht
bXVfbm90aWZpZXJfcmFuZ2VfYmxvY2thYmxlKHJhbmdlKSkKPiAJCW11dGV4X2xvY2soJmFkZXYt
Pm5vdGlmaWVyX2xvY2spOwo+IAllbHNlIGlmICghbXV0ZXhfdHJ5bG9jaygmYWRldi0+bm90aWZp
ZXJfbG9jaykpCj4gCQlyZXR1cm4gZmFsc2U7CgpOZXZlciBtaW5kLCB0aGlzIHJvdXRpbmUgc2xl
ZXBzIGZvciBvdGhlciByZWFzb25zIGl0IHNob3VsZCBqdXN0IGJlIGFzCml0IHdhczoKCglpZiAo
IW1tdV9ub3RpZmllcl9yYW5nZV9ibG9ja2FibGUocmFuZ2UpKQoJCXJldHVybiBmYWxzZTsKCglt
dXRleF9sb2NrKCZhZGV2LT5ub3RpZmllcl9sb2NrKTsKCkphc29uCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
