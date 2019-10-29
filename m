Return-Path: <SRS0=VQNv=YW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7B2CA9EAE
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 12:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6B69208E3
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 12:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B69208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 920C1892AD;
	Tue, 29 Oct 2019 12:53:55 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CE7889819
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2019 12:51:33 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id z17so13333268qts.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2019 05:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZF5YLLdkMxOeBnT3AEdovjyBEmTM+OTs+LDLPN0GMI8=;
 b=dmjC82n7wJNRBvsWzt4mg8zznOnrW97g26X6ksHpVZ4ZiraIppB39WRjRQWQ+hQELK
 LDSqv7biuaUnpHJM/DmYaChQ0yRNy/9CHV8dTOO8OoxXf1RN7hw/yYvttM8+KfhW9Ot1
 gTMG/+vjp7tsGMoHLOATwCnow7hyl9F3sdKw/H+2AHx/M0mNbFSHjCRbbroD1tjEChOH
 est53MWvdz+MjtVrMwr2PhOy1wDTpBp32HsUwKVAT9W3EeSzscMRxVMpbXxydIVjda50
 eL/8fremh/PJbxsYs9/uIdAyL6pkjEx/cTdSOJzOlsIeaJCy6fmthM3W0IQH3W89Mkui
 weUw==
X-Gm-Message-State: APjAAAVE1LuDUHdf+TTIyRJSF1+5rRKTC6q0rzhdVBSvVIo4Ta61X1lk
 4K86geQ5MBlb1cUgc33o/CZ9Xg==
X-Google-Smtp-Source: APXvYqxq0ay2DLP144wUqH2TJqeYs+CM1CzDDTCAEHT8qLG70HSD8wcaxvvKBHRgPHlzCMTknReLGQ==
X-Received: by 2002:ac8:219d:: with SMTP id 29mr4121236qty.280.1572353492189; 
 Tue, 29 Oct 2019 05:51:32 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.180])
 by smtp.gmail.com with ESMTPSA id w69sm4027395qkb.26.2019.10.29.05.51.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Oct 2019 05:51:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1iPQyB-000522-4r; Tue, 29 Oct 2019 09:51:31 -0300
Date: Tue, 29 Oct 2019 09:51:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH v2 06/15] RDMA/hfi1: Use mmu_range_notifier_inset for
 user_exp_rcv
Message-ID: <20191029125131.GC6128@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-7-jgg@ziepe.ca>
 <a8644875-9133-9667-c04b-b40c296d68eb@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a8644875-9133-9667-c04b-b40c296d68eb@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Tue, 29 Oct 2019 12:53:55 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ZF5YLLdkMxOeBnT3AEdovjyBEmTM+OTs+LDLPN0GMI8=;
 b=IHV+AJapDR5k8D6Zafc6ml2K0fa/jgF1PZBiuBMaOa/r+MK0PJ0xNtRtLiwXM8hfUM
 oyGHNxRN/O07FITOaIm5BnO1Box0mj0QkuPEB2wMXMWKVbmYTzXQRMncmXuCTctBu7gC
 91FIwEspUa/0nc1TUQ+oissChI6D4nJBO8DA40LneE6r/MnEh4dPTkicbi1e9mKDMq4W
 wpip0eIgYwCfGlBN5ll9Ug3VTlK7wx3iCECoDUwBIIk+qI/2gjDdaegrEPvi6otVA07c
 HtuIQ3uKH0+5jfdbr9pByZT3cPdoijw2I2FMN1xWV5tXm87jeYeH8MJjI7uCkOjTfH2C
 whzQ==
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
Cc: Juergen Gross <jgross@suse.com>, David Zhou <David1.Zhou@amd.com>,
 Ralph Campbell <rcampbell@nvidia.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 linux-rdma@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
 Felix.Kuehling@amd.com, Mike Marciniszyn <mike.marciniszyn@intel.com>,
 dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>,
 linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>,
 amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, xen-devel@lists.xenproject.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Petr Cvek <petrcvekcz@gmail.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191029125131.Vv76FswdSQSaFXXOiudFhhq48fj604Qwdtt2ZtLM-bA@z>

T24gVHVlLCBPY3QgMjksIDIwMTkgYXQgMDg6MTk6MjBBTSAtMDQwMCwgRGVubmlzIERhbGVzc2Fu
ZHJvIHdyb3RlOgo+IE9uIDEwLzI4LzIwMTkgNDoxMCBQTSwgSmFzb24gR3VudGhvcnBlIHdyb3Rl
Ogo+ID4gRnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPgo+ID4gCj4gPiBU
aGlzIGNvbnZlcnRzIG9uZSBvZiB0aGUgdHdvIHVzZXJzIG9mIG1tdV9ub3RpZmllcnMgdG8gdXNl
IHRoZSBuZXcgQVBJLgo+ID4gVGhlIGNvbnZlcnNpb24gaXMgZmFpcmx5IHN0cmFpZ2h0Zm9yd2Fy
ZCwgaG93ZXZlciB0aGUgZXhpc3RpbmcgdXNlIG9mCj4gPiBub3RpZmllcnMgaGVyZSBzZWVtcyB0
byBiZSByYWNleS4KPiA+IAo+ID4gQ2M6IE1pa2UgTWFyY2luaXN6eW4gPG1pa2UubWFyY2luaXN6
eW5AaW50ZWwuY29tPgo+ID4gQ2M6IERlbm5pcyBEYWxlc3NhbmRybyA8ZGVubmlzLmRhbGVzc2Fu
ZHJvQGludGVsLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uIEd1bnRob3JwZSA8amdnQG1l
bGxhbm94LmNvbT4KPiAKPiBJIHRlc3RlZCB2MSwgYW5kIHJlcGxpZWQgdG8gaXQgWzFdLiBJIGNh
biByZS10ZXN0IHdpdGggdGhpcyB2ZXJzaW9uIGlmIHlvdQo+IGxpa2UgYXMgd2VsbC4KPiAKPiBb
MV0gaHR0cHM6Ly9tYXJjLmluZm8vP2w9bGludXgtcmRtYSZtPTE1NzIzNTEzMDYwNjQxMiZ3PTIK
CkkgdGhpbmsgaXQgaXMgZmluZSwgbm90aGluZyByZWFsbHkgY2hhbmdlZCBpbiB2MiwgdGhhbmtz
CgpKYXNvbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
