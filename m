Return-Path: <SRS0=KKXi=LR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F424C4743C
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 18:43:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B86B601FC
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 18:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B86B601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 283E36E978;
	Wed, 23 Jun 2021 18:43:33 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 701926E96F;
 Wed, 23 Jun 2021 18:43:31 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 k21-20020a4a2a150000b029024955603642so969642oof.8; 
 Wed, 23 Jun 2021 11:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cpkWeMAkWCf76CjUWKr9rUiGHMNQHXwmEhD8GnECJcY=;
 b=FAdddLGyvRhCK6AccX0MB+lVTROAnOJkBjUEiLvKrGbCjDXg8cMuBvzhCKCYG+2wp/
 7FJ3bFXrVJfND52cISdONm5rVb5W9wcg0gd6yEuwoMBJliQ+FKvkdyDQWzozxNSwBNbs
 JO7eZe4ZccJ/2bx2xYR8vGk+3FNkZO8h7JpLwuS4w5BJ2EAXBGSDJEkL0jivD5z+gFEw
 7BIJX+4ApeN6hyu2dSaya30ciWfKtm1usu/9aEHqyXKsn8HrRL8Oik9b/5kIdMgkmffs
 40h8uV5SomFi6A7tfXs9WuHwRD2nn3EpgHQL1ljq24NiTrr2WkcWAikxIxKIRjiJG6dp
 7Gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cpkWeMAkWCf76CjUWKr9rUiGHMNQHXwmEhD8GnECJcY=;
 b=e33hJSvVdYth5atEGOG+XYXjaKB52SYAoRJw/RKKHYz/D2QzDRKDWc9xyWPjvkZCh0
 mfKs3taDWakBrkFQs6EfbyC9gILCQNN9NxWIJkWpF1EbP323qgAElfoiQ0LKrIK3QImv
 pht/X0QJlAdgF7lS7yUMb+7c07biiXRmIrq/tDR/Q0W4QyioXccjq7CSPFnN2XuZ8pO6
 ho7jPnVFVbO8ME8dK44IWNqewvAgZ28iNV6+Uxgw/QD9PFlKRS5fD+M8WMpfI3Qtnv8H
 37TXgodK18shFzzTxwydL0z6c6l5jRoSv/XjXgHYnV9t9HK6q+PuMQYLLMc2gl5gMC58
 72jw==
X-Gm-Message-State: AOAM532i8+Aa/2z/TAlPSNaSQbD8UniUI0B+UwRiBDTpbID1fPw/RhXO
 Jey1NPbkNrFbvsEkLh2BygsLQ9j8oDC39DT2xJw=
X-Google-Smtp-Source: ABdhPJztTw3IUTHnVPOKEUa+mzrtiHw343QNu8CeH1GRn9gntl2RUBK4RDrGb/9f1ZBukujNJOVgfhuumtOwviJ5UvE=
X-Received: by 2002:a4a:1a84:: with SMTP id 126mr976948oof.77.1624473810500;
 Wed, 23 Jun 2021 11:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <d358c740-fd3a-9ecd-7001-676e2cb44ec9@gmail.com>
 <CAFCwf11h_Nj_GEdCdeTzO5jgr-Y9em+W-v_pYUfz64i5Ac25yg@mail.gmail.com>
 <20210622120142.GL1096940@ziepe.ca>
 <d497b0a2-897e-adff-295c-cf0f4ff93cb4@amd.com>
 <20210622152343.GO1096940@ziepe.ca>
 <3fabe8b7-7174-bf49-5ffe-26db30968a27@amd.com>
 <20210622154027.GS1096940@ziepe.ca>
 <09df4a03-d99c-3949-05b2-8b49c71a109e@amd.com>
 <20210622160538.GT1096940@ziepe.ca>
 <d600a638-9e55-6249-b574-0986cd5cea1e@gmail.com>
 <20210623182435.GX1096940@ziepe.ca>
In-Reply-To: <20210623182435.GX1096940@ziepe.ca>
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Wed, 23 Jun 2021 21:43:04 +0300
Message-ID: <CAFCwf111O0_YB_tixzEUmaKpGAHMNvMaOes2AfMD4x68Am4Yyg@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH v3 1/2] habanalabs: define uAPI to export
 FD for DMA-BUF
To: Jason Gunthorpe <jgg@ziepe.ca>
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
Cc: linux-rdma <linux-rdma@vger.kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 sleybo@amazon.com, Leon Romanovsky <leonro@nvidia.com>,
 Gal Pressman <galpress@amazon.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Doug Ledford <dledford@redhat.com>, Tomer Tayar <ttayar@habana.ai>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Greg KH <gregkh@linuxfoundation.org>, Alex Deucher <alexander.deucher@amd.com>,
 Christoph Hellwig <hch@lst.de>, Oded Gabbay <ogabbay@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBKdW4gMjMsIDIwMjEgYXQgOToyNCBQTSBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVw
ZS5jYT4gd3JvdGU6Cj4KPiBPbiBXZWQsIEp1biAyMywgMjAyMSBhdCAxMDo1NzozNUFNICswMjAw
LCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Cj4gPiA+ID4gTm8gaXQgaXNuJ3QuIEl0IG1ha2Vz
IGRldmljZXMgZGVwZW5kIG9uIGFsbG9jYXRpbmcgc3RydWN0IHBhZ2VzIGZvciB0aGVpcgo+ID4g
PiA+IEJBUnMgd2hpY2ggaXMgbm90IG5lY2Vzc2FyeSBub3IgZGVzaXJlZC4KPiA+ID4gV2hpY2gg
ZHJhbWF0aWNhbGx5IHJlZHVjZXMgdGhlIGNvc3Qgb2YgZXN0YWJsaXNoaW5nIERNQSBtYXBwaW5n
cywgYQo+ID4gPiBsb29wIG9mIGRtYV9tYXBfcmVzb3VyY2UoKSBpcyB2ZXJ5IGV4cGVuc2l2ZS4K
PiA+Cj4gPiBZZWFoLCBidXQgdGhhdCBpcyBwZXJmZWN0bHkgb2suIE91ciBCQVIgYWxsb2NhdGlv
bnMgYXJlIGVpdGhlciBpbiBjaHVua3Mgb2YKPiA+IGF0IGxlYXN0IDJNaUIgb3Igb25seSBhIHNp
bmdsZSA0S2lCIHBhZ2UuCj4KPiBBbmQgdmVyeSBzbWFsbCBhcHBhcmVudGx5Cj4KPiA+ID4gPiBB
bGxvY2F0aW5nIGEgc3RydWN0IHBhZ2VzIGhhcyB0aGVpciB1c2UgY2FzZSwgZm9yIGV4YW1wbGUg
Zm9yIGV4cG9zaW5nIFZSQU0KPiA+ID4gPiBhcyBtZW1vcnkgZm9yIEhNTS4gQnV0IHRoYXQgaXMg
c29tZXRoaW5nIHZlcnkgc3BlY2lmaWMgYW5kIHNob3VsZCBub3QgbGltaXQKPiA+ID4gPiBQQ0ll
IFAyUCBETUEgaW4gZ2VuZXJhbC4KPiA+ID4gU3VyZSwgYnV0IHRoYXQgaXMgYW4gaWRlYWwgd2Ug
YXJlIGZhciBmcm9tIG9idGFpbmluZywgYW5kIG5vYm9keSB3YW50cwo+ID4gPiB0byB3b3JrIG9u
IGl0IHByZWZlcmluZyB0byBkbyBoYWNreSBoYWNreSBsaWtlIHRoaXMuCj4gPiA+Cj4gPiA+IElm
IHlvdSBiZWxpZXZlIGluIHRoaXMgdGhlbiByZW1vdmUgdGhlIHNjYXR0ZXIgbGlzdCBmcm9tIGRt
YWJ1ZiwgYWRkIGEKPiA+ID4gbmV3IHNldCBvZiBkbWFfbWFwKiBBUElzIHRvIHdvcmsgb24gcGh5
c2ljYWwgYWRkcmVzc2VzIGFuZCBhbGwgdGhlCj4gPiA+IG90aGVyIHN0dWZmIG5lZWRlZC4KPiA+
Cj4gPiBZZWFoLCB0aGF0J3Mgd2hhdCBJIHRvdGFsbHkgYWdyZWUgb24uIEFuZCBJIGFjdHVhbGx5
IGhvcGVkIHRoYXQgdGhlIG5ldyBQMlAKPiA+IHdvcmsgZm9yIFBDSWUgd291bGQgZ28gaW50byB0
aGF0IGRpcmVjdGlvbiwgYnV0IHRoYXQgZGlkbid0IG1hdGVyaWFsaXplZC4KPgo+IEl0IGlzIGEg
bG90IG9mIHdvcmsgYW5kIHRoZSBvbmx5IGdhaW4gaXMgdG8gc2F2ZSBhIGJpdCBvZiBtZW1vcnkg
Zm9yCj4gc3RydWN0IHBhZ2VzLiBOb3QgYSB2ZXJ5IGJpZyBwYXkgb2ZmLgo+Cj4gPiBCdXQgYWxs
b2NhdGluZyBzdHJ1Y3QgcGFnZXMgZm9yIFBDSWUgQkFScyB3aGljaCBhcmUgZXNzZW50aWFsbHkg
cmVnaXN0ZXJzCj4gPiBhbmQgbm90IG1lbW9yeSBpcyBtdWNoIG1vcmUgaGFja3kgdGhhbiB0aGUg
ZG1hX3Jlc291cmNlX21hcCgpIGFwcHJvYWNoLgo+Cj4gSXQgZG9lc24ndCByZWFsbHkgbWF0dGVy
LiBUaGUgcGFnZXMgYXJlIGluIGEgc3BlY2lhbCB6b25lIGFuZCBhcmUgb25seQo+IGJlaW5nIHVz
ZWQgYXMgaGFuZGxlcyBmb3IgdGhlIEJBUiBtZW1vcnkuCj4KPiA+IEJ5IHVzaW5nIFBDSWUgUDJQ
IHdlIHdhbnQgdG8gYXZvaWQgdGhlIHJvdW5kIHRyaXAgdG8gdGhlIENQVSB3aGVuIG9uZSBkZXZp
Y2UKPiA+IGhhcyBmaWxsZWQgdGhlIHJpbmcgYnVmZmVyIGFuZCBhbm90aGVyIGRldmljZSBtdXN0
IGJlIHdva2VuIHVwIHRvIHByb2Nlc3MKPiA+IGl0Lgo+Cj4gU3VyZSwgd2UgYWxsIGhhdmUgdGhl
c2Ugc2NlbmFyaW9zLCB3aGF0IGlzIGluc2lkZSB0aGUgbWVtb3J5IGRvZXNuJ3QKPiByZWFseSBt
YXR0ZXIuIFRoZSBtZWNoYW5pc20gaXMgZ2VuZXJpYyBhbmQgdGhlIHN0cnVjdCBwYWdlcyBkb24n
dCBjYXJlCj4gbXVjaCBpZiB0aGV5IHBvaW50IGF0IHNvbWV0aGluZyBtZW1vcnktbGlrZSBvciBh
dCBzb21ldGhpbmcKPiByZWdpc3Rlci1saWtlLgo+Cj4gVGhleSBhcmUgYWxyZWFkeSBpbiBiaWcg
dHJvdWJsZSBiZWNhdXNlIHlvdSBjYW4ndCBwb3J0YWJseSB1c2UgQ1BVCj4gaW5zdHJ1Y3Rpb25z
IHRvIGFjY2VzcyB0aGVtIGFueWhvdy4KPgo+IEphc29uCgpKYXNvbiwKQ2FuIHlvdSBwbGVhc2Ug
ZXhwbGFpbiB3aHkgaXQgaXMgc28gaW1wb3J0YW50IHRvIChhbGxvdykgYWNjZXNzIHRoZW0KdGhy
b3VnaCB0aGUgQ1BVID8KSW4gcmVnYXJkIHRvIHAycCwgd2hlcmUgaXMgdGhlIHVzZS1jYXNlIGZv
ciB0aGF0ID8KVGhlIHdob2xlIHB1cnBvc2UgaXMgdGhhdCB0aGUgb3RoZXIgZGV2aWNlIGFjY2Vz
c2VzIG15IGRldmljZSwKYnlwYXNzaW5nIHRoZSBDUFUuCgpUaGFua3MsCk9kZWQKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
