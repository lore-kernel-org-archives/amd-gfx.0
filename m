Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C14C2B9F4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 13:12:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54F5260FE9
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 13:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F5260FE9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 127F66E14D;
	Tue, 22 Jun 2021 13:12:51 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4EF56E4C1
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 12:15:48 +0000 (UTC)
Received: by mail-qv1-xf31.google.com with SMTP id c2so5933531qvs.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 05:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=KjofJoQyUwiIAacJkE1UxWn3Mo9VplV7FtMGlU0RWLM=;
 b=h97BE10eQvAs7iuAp3KSz/AKkEBSJK+RWgPE2bKUnLoQdvOUv3nQXFBCT3PEWlx2Sl
 E/e2cYiumFAEGqj4jTurYIMnn2zsv1UeEuBl9zhKLEnlbb/EkISQicJQPDbtplfY7NkM
 co8/vN6NEYxfoOaungf0V4XWEA/Cmf7QBmCZBDNRHWHAx6heTvyghfkmTuWnPgQqEDpW
 mESlAUjUeEAGF0vwR/v1AwASBsRjSyjZOYhs7r1/kwL3GwXPKGLxfpNXjMb/amd4m48L
 RTR9a5HRMe1vZ+UVKk7QU3T0ut/x3x7ci4FJwEzm6Jq6XV4LXljZKU5h4jBZaF4LdabI
 BUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=KjofJoQyUwiIAacJkE1UxWn3Mo9VplV7FtMGlU0RWLM=;
 b=J61vuHVLJWlo7xdz5vBGa0nKGeWavaMZCimvmgUZYExlLRKYpRLptjvlKTZORRjcf2
 crKpexkVpOvo2m1yFcbKmCoJN2cATnAydYAuYo8sT1m1W7Iqz+XYKv81shOB159oUJto
 MHoDzSXVLzenzihJm18ad7u9XtZ/AUyWd0buZDnCgc+GCHPNmtH8PNlUCUa3DLfxh9pG
 wV1SQSjIHsXN1uqYTgMG+/3o0zUlVDGRjPHWnsb+2RFTs4a89h1JfGkKQVUd4jjIYeeB
 KZ9DfjLWoj1C4CJgUOql1wFJ/KXoCNb6YHOzANCE+qnWWe+1WBsbZQPRdwDRluN4qTnf
 5L7A==
X-Gm-Message-State: AOAM532QrsIcMKIyvYHebx3bZi8SfmOsEDacrq3npC4/+b3Hn3p95LSM
 j5hKhxCNiuLaL5hPRMHUwkpuKw==
X-Google-Smtp-Source: ABdhPJy23RwHWwohPH/Gr7a/6x+XnMYskE5GrjrV3VrRGHji6PDv+ikMUtwLNa4CYmg0qZGAziatcw==
X-Received: by 2002:a0c:aacd:: with SMTP id g13mr1227641qvb.22.1624364148049; 
 Tue, 22 Jun 2021 05:15:48 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [47.55.113.94])
 by smtp.gmail.com with ESMTPSA id l123sm5662330qke.10.2021.06.22.05.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jun 2021 05:15:47 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lvfJj-00A9d2-05; Tue, 22 Jun 2021 09:15:47 -0300
Date: Tue, 22 Jun 2021 09:15:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Oded Gabbay <oded.gabbay@gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH v3 1/2] habanalabs: define uAPI to export
 FD for DMA-BUF
Message-ID: <20210622121546.GN1096940@ziepe.ca>
References: <20210621141217.GE1096940@ziepe.ca>
 <CAFCwf10KvCh0zfHEHqYR-Na6KJh4j+9i-6+==QaMdHHpLH1yEA@mail.gmail.com>
 <20210621175511.GI1096940@ziepe.ca>
 <CAKMK7uEO1_B59DtM7N2g7kkH7pYtLM_WAkn+0f3FU3ps=XEjZQ@mail.gmail.com>
 <CAFCwf11jOnewkbLuxUESswCJpyo7C0ovZj80UrnwUOZkPv2JYQ@mail.gmail.com>
 <20210621232912.GK1096940@ziepe.ca>
 <d358c740-fd3a-9ecd-7001-676e2cb44ec9@gmail.com>
 <CAFCwf11h_Nj_GEdCdeTzO5jgr-Y9em+W-v_pYUfz64i5Ac25yg@mail.gmail.com>
 <20210622120142.GL1096940@ziepe.ca>
 <CAFCwf10GmBjeJAFp0uJsMLiv-8HWAR==RqV9ZdMQz+iW9XWdTA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFCwf10GmBjeJAFp0uJsMLiv-8HWAR==RqV9ZdMQz+iW9XWdTA@mail.gmail.com>
X-Mailman-Approved-At: Tue, 22 Jun 2021 13:12:50 +0000
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
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
 sleybo@amazon.com, Gal Pressman <galpress@amazon.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Doug Ledford <dledford@redhat.com>, Tomer Tayar <ttayar@habana.ai>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Greg KH <gregkh@linuxfoundation.org>, Alex Deucher <alexander.deucher@amd.com>,
 Leon Romanovsky <leonro@nvidia.com>, Oded Gabbay <ogabbay@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBKdW4gMjIsIDIwMjEgYXQgMDM6MDQ6MzBQTSArMDMwMCwgT2RlZCBHYWJiYXkgd3Jv
dGU6Cj4gT24gVHVlLCBKdW4gMjIsIDIwMjEgYXQgMzowMSBQTSBKYXNvbiBHdW50aG9ycGUgPGpn
Z0B6aWVwZS5jYT4gd3JvdGU6Cj4gPgo+ID4gT24gVHVlLCBKdW4gMjIsIDIwMjEgYXQgMTE6NDI6
MjdBTSArMDMwMCwgT2RlZCBHYWJiYXkgd3JvdGU6Cj4gPiA+IE9uIFR1ZSwgSnVuIDIyLCAyMDIx
IGF0IDk6MzcgQU0gQ2hyaXN0aWFuIEvDtm5pZwo+ID4gPiA8Y2tvZW5pZy5sZWljaHR6dW1lcmtl
bkBnbWFpbC5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4gQW0gMjIuMDYuMjEgdW0gMDE6Mjkg
c2NocmllYiBKYXNvbiBHdW50aG9ycGU6Cj4gPiA+ID4gPiBPbiBNb24sIEp1biAyMSwgMjAyMSBh
dCAxMDoyNDoxNlBNICswMzAwLCBPZGVkIEdhYmJheSB3cm90ZToKPiA+ID4gPiA+Cj4gPiA+ID4g
Pj4gQW5vdGhlciB0aGluZyBJIHdhbnQgdG8gZW1waGFzaXplIGlzIHRoYXQgd2UgYXJlIGRvaW5n
IHAycCBvbmx5Cj4gPiA+ID4gPj4gdGhyb3VnaCB0aGUgZXhwb3J0L2ltcG9ydCBvZiB0aGUgRkQu
IFdlIGRvICpub3QqIGFsbG93IHRoZSB1c2VyIHRvCj4gPiA+ID4gPj4gbW1hcCB0aGUgZG1hLWJ1
ZiBhcyB3ZSBkbyBub3Qgc3VwcG9ydCBkaXJlY3QgSU8uIFNvIHRoZXJlIGlzIG5vIGFjY2Vzcwo+
ID4gPiA+ID4+IHRvIHRoZXNlIHBhZ2VzIHRocm91Z2ggdGhlIHVzZXJzcGFjZS4KPiA+ID4gPiA+
IEFyZ3VhYmx5IG1tYXBpbmcgdGhlIG1lbW9yeSBpcyBhIGJldHRlciBjaG9pY2UsIGFuZCBpcyB0
aGUgZGlyZWN0aW9uCj4gPiA+ID4gPiB0aGF0IExvZ2FuJ3Mgc2VyaWVzIGdvZXMgaW4uIEhlcmUg
dGhlIHVzZSBvZiBETUFCVUYgd2FzIHNwZWNpZmljYWxseQo+ID4gPiA+ID4gZGVzaWduZWQgdG8g
YWxsb3cgaGl0bGVzcyByZXZva2F0aW9uIG9mIHRoZSBtZW1vcnksIHdoaWNoIHRoaXMgaXNuJ3QK
PiA+ID4gPiA+IGV2ZW4gdXNpbmcuCj4gPiA+ID4KPiA+ID4gPiBUaGUgbWFqb3IgcHJvYmxlbSB3
aXRoIHRoaXMgYXBwcm9hY2ggaXMgdGhhdCBETUEtYnVmIGlzIGFsc28gdXNlZCBmb3IKPiA+ID4g
PiBtZW1vcnkgd2hpY2ggaXNuJ3QgQ1BVIGFjY2Vzc2libGUuCj4gPgo+ID4gVGhhdCBpc24ndCBh
biBpc3N1ZSBoZXJlIGJlY2F1c2UgdGhlIG1lbW9yeSBpcyBvbmx5IGludGVuZGVkIHRvIGJlCj4g
PiB1c2VkIHdpdGggUDJQIHRyYW5zZmVycyBzbyBpdCBtdXN0IGJlIENQVSBhY2Nlc3NpYmxlLgo+
ID4KPiA+ID4gPiBUaGF0IHdhcyBvbmUgb2YgdGhlIHJlYXNvbnMgd2UgZGlkbid0IGV2ZW4gY29u
c2lkZXJlZCB1c2luZyB0aGUgbWFwcGluZwo+ID4gPiA+IG1lbW9yeSBhcHByb2FjaCBmb3IgR1BV
cy4KPiA+Cj4gPiBXZWxsLCBub3cgd2UgaGF2ZSBERVZJQ0VfUFJJVkFURSBtZW1vcnkgdGhhdCBj
YW4gbWVldCB0aGlzIG5lZWQKPiA+IHRvby4uIEp1c3Qgbm9ib2R5IGhhcyB3aXJlZCBpdCB1cCB0
byBobW1fcmFuZ2VfZmF1bHQoKQo+ID4KPiA+ID4gPiA+IFNvIHlvdSBhcmUgdGFraW5nIHRoZSBo
aXQgb2YgdmVyeSBsaW1pdGVkIGhhcmR3YXJlIHN1cHBvcnQgYW5kIHJlZHVjZWQKPiA+ID4gPiA+
IHBlcmZvcm1hbmNlIGp1c3QgdG8gc3F1ZWV6ZSBpbnRvIERNQUJVRi4uCj4gPiA+Cj4gPiA+IFRo
YW5rcyBKYXNvbiBmb3IgdGhlIGNsYXJpZmljYXRpb24sIGJ1dCBJIGhvbmVzdGx5IHByZWZlciB0
byB1c2UKPiA+ID4gRE1BLUJVRiBhdCB0aGUgbW9tZW50Lgo+ID4gPiBJdCBnaXZlcyB1cyBqdXN0
IHdoYXQgd2UgbmVlZCAoZXZlbiBtb3JlIHRoYW4gd2hhdCB3ZSBuZWVkIGFzIHlvdQo+ID4gPiBw
b2ludGVkIG91dCksIGl0IGlzICphbHJlYWR5KiBpbnRlZ3JhdGVkIGFuZCB0ZXN0ZWQgaW4gdGhl
IFJETUEKPiA+ID4gc3Vic3lzdGVtLCBhbmQgSSdtIGZlZWxpbmcgY29tZm9ydGFibGUgdXNpbmcg
aXQgYXMgSSdtIHNvbWV3aGF0Cj4gPiA+IGZhbWlsaWFyIHdpdGggaXQgZnJvbSBteSBBTUQgZGF5
cy4KPiA+Cj4gPiBZb3Ugc3RpbGwgaGF2ZSB0aGUgaXNzdWUgdGhhdCB0aGlzIHBhdGNoIGlzIGRv
aW5nIGFsbCBvZiB0aGlzIFAyUAo+ID4gc3R1ZmYgd3JvbmcgLSBmb2xsb3dpbmcgdGhlIGFscmVh
ZHkgTkFLJ2QgQU1EIGFwcHJvYWNoLgo+IAo+IENvdWxkIHlvdSBwbGVhc2UgcG9pbnQgbWUgZXhh
Y3RseSB0byB0aGUgbGluZXMgb2YgY29kZSB0aGF0IGFyZSB3cm9uZwo+IGluIHlvdXIgb3Bpbmlv
biA/CgoxKSBTZXR0aW5nIHNnX3BhZ2UgdG8gTlVMTAoyKSAnbWFwcGluZycgcGFnZXMgZm9yIFAy
UCBETUEgd2l0aG91dCBnb2luZyB0aHJvdWdoIHRoZSBpb21tdQozKSBBbGxvd2luZyBQMlAgRE1B
IHdpdGhvdXQgdXNpbmcgdGhlIHAycCBkbWEgQVBJIHRvIHZhbGlkYXRlIHRoYXQgaXQKICAgY2Fu
IHdvcmsgYXQgYWxsIGluIHRoZSBmaXJzdCBwbGFjZS4KCkFsbCBvZiB0aGVzZSByZXN1bHQgaW4g
ZnVuY3Rpb25hbCBidWdzIGluIGNlcnRhaW4gc3lzdGVtCmNvbmZpZ3VyYXRpb25zLgoKSmFzb24K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
