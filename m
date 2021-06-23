Return-Path: <SRS0=KKXi=LR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A570C4743C
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 09:15:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26940611CE
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 09:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26940611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 817DB6E892;
	Wed, 23 Jun 2021 09:15:29 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CEA96E507;
 Wed, 23 Jun 2021 09:15:28 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id a133so383254oib.13;
 Wed, 23 Jun 2021 02:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=quouQNx98OeM2JWkzBIUm3+vF8x4xm+zxWV/raoo3aQ=;
 b=Fmu2kU2I9U/tO77+2EI8nnRLVsm1KZns9poRXkmFydncMdpd17HRS7jmpP6eSA7e9H
 BPhqm28O6C2qLsEb6KXrV189fkUkVFRIdy10NA3Zi3UnajXBIYCYWRgiAEw+pfjA+jIR
 Gd+28Lw0bfeU/z2KQNu9rTF9lSNYnw+7oQjwznJh9yhwQHK7meHufl25CdQfhM7NkSrV
 x1wKS5LkejWdl4ftXDvaM7DGGXNZ15lP1fphbHDmeeUCuMuhLeLzYsDj20mIjg9ujadC
 +W1Of5Blo0JBXkv/cliU89T7B/mKdUdRC+M3luCI7hIv9SUyco0iL10gFoVPIYistGGv
 pC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=quouQNx98OeM2JWkzBIUm3+vF8x4xm+zxWV/raoo3aQ=;
 b=N+juTztVkdUYIfIYjSBpCvG6+LrqWFrzJ+sOPWFHPfeV5asSiu96yZjCDxWp2casa3
 uxySx5P0p6H7+PTfpV2H+GCPf7OKD5n7FTASEdBtqFILcDTaoKAEWZqNn6RZERhHtbr0
 iVMMTn9vSeHdnzhf9HPhBbwyh3j7Hjn1UYFXuV3x+77nGhG8N7GNZXYJ9QqYw0c/iW7G
 riB6k9rBX7KR9jqLHScoWi0NGs12vQYCzbqsxPaJkIKaCo0OcW/CVFXti22F5NjFas3T
 R1xVuPSdwIsmfEzUNLN2lCs9Tlej8C6SImgagixHDEdkJ26f4NJBgKze6cbo6fXJEVb3
 Nmcg==
X-Gm-Message-State: AOAM530ffjKzcpULBfAApDC/ZzcS1uQwGL9RVeCoEMpKcDJ+5/QzwGmi
 CFgIFXKJe+h26EAJUfblH4BUsqRwL0mzT95de4k=
X-Google-Smtp-Source: ABdhPJxlh6DW0WITP5HCozbR6iBRVIh8Cgnl5UHJUnk65FQPQ/9TS+t8xXDV2Gmdxn5HNi4XWlqIrc32l0TnSWanVgI=
X-Received: by 2002:aca:3bc3:: with SMTP id i186mr2375999oia.102.1624439727422; 
 Wed, 23 Jun 2021 02:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf11jOnewkbLuxUESswCJpyo7C0ovZj80UrnwUOZkPv2JYQ@mail.gmail.com>
 <20210621232912.GK1096940@ziepe.ca>
 <d358c740-fd3a-9ecd-7001-676e2cb44ec9@gmail.com>
 <CAFCwf11h_Nj_GEdCdeTzO5jgr-Y9em+W-v_pYUfz64i5Ac25yg@mail.gmail.com>
 <20210622120142.GL1096940@ziepe.ca>
 <d497b0a2-897e-adff-295c-cf0f4ff93cb4@amd.com>
 <20210622152343.GO1096940@ziepe.ca>
 <3fabe8b7-7174-bf49-5ffe-26db30968a27@amd.com>
 <20210622154027.GS1096940@ziepe.ca>
 <09df4a03-d99c-3949-05b2-8b49c71a109e@amd.com>
 <20210622160538.GT1096940@ziepe.ca>
 <d600a638-9e55-6249-b574-0986cd5cea1e@gmail.com>
In-Reply-To: <d600a638-9e55-6249-b574-0986cd5cea1e@gmail.com>
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Wed, 23 Jun 2021 12:14:59 +0300
Message-ID: <CAFCwf12JXQ6XnQEPM6wa2ut8dV8VBLTJE_popZT2GTVVra5CLQ@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH v3 1/2] habanalabs: define uAPI to export
 FD for DMA-BUF
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sleybo@amazon.com,
 Gal Pressman <galpress@amazon.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
 Tomer Tayar <ttayar@habana.ai>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Greg KH <gregkh@linuxfoundation.org>, Alex Deucher <alexander.deucher@amd.com>,
 Christoph Hellwig <hch@lst.de>, Oded Gabbay <ogabbay@kernel.org>,
 Leon Romanovsky <leonro@nvidia.com>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBKdW4gMjMsIDIwMjEgYXQgMTE6NTcgQU0gQ2hyaXN0aWFuIEvDtm5pZwo8Y2tvZW5p
Zy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gQW0gMjIuMDYuMjEgdW0gMTg6
MDUgc2NocmllYiBKYXNvbiBHdW50aG9ycGU6Cj4gPiBPbiBUdWUsIEp1biAyMiwgMjAyMSBhdCAw
NTo0ODoxMFBNICswMjAwLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+ID4+IEFtIDIyLjA2LjIx
IHVtIDE3OjQwIHNjaHJpZWIgSmFzb24gR3VudGhvcnBlOgo+ID4+PiBPbiBUdWUsIEp1biAyMiwg
MjAyMSBhdCAwNToyOTowMVBNICswMjAwLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+ID4+Pj4g
W1NOSVBdCj4gPj4+PiBObyBhYnNvbHV0ZWx5IG5vdC4gTlZpZGlhIEdQVXMgd29yayBleGFjdGx5
IHRoZSBzYW1lIHdheS4KPiA+Pj4+Cj4gPj4+PiBBbmQgeW91IGhhdmUgdG9ucyBvZiBzaW1pbGFy
IGNhc2VzIGluIGVtYmVkZGVkIGFuZCBTb0Mgc3lzdGVtcyB3aGVyZQo+ID4+Pj4gaW50ZXJtZWRp
YXRlIG1lbW9yeSBiZXR3ZWVuIGRldmljZXMgaXNuJ3QgZGlyZWN0bHkgYWRkcmVzc2FibGUgd2l0
aCB0aGUgQ1BVLgo+ID4+PiBOb25lIG9mIHRoYXQgaXMgUENJIFAyUC4KPiA+Pj4KPiA+Pj4gSXQg
aXMgYWxsIHNvbWUgc3BlY2lhbHR5IGRpcmVjdCB0cmFuc2Zlci4KPiA+Pj4KPiA+Pj4gWW91IGNh
bid0IHJlYXNvbmFibHkgY2FsbCBkbWFfbWFwX3Jlc291cmNlKCkgb24gbm9uIENQVSBtYXBwZWQg
bWVtb3J5Cj4gPj4+IGZvciBpbnN0YW5jZSwgd2hhdCBhZGRyZXNzIHdvdWxkIHlvdSBwYXNzPwo+
ID4+Pgo+ID4+PiBEbyBub3QgY29uZnVzZSAiSSBhbSBkb2luZyB0cmFuc2ZlcnMgYmV0d2VlbiB0
d28gSFcgYmxvY2tzIiB3aXRoIFBDSQo+ID4+PiBQZWVyIHRvIFBlZXIgRE1BIHRyYW5zZmVycyAt
IHRoZSBsYXR0ZXIgaXMgYSB2ZXJ5IG5hcnJvdyBzdWJjYXNlLgo+ID4+Pgo+ID4+Pj4gTm8sIGp1
c3QgdXNpbmcgdGhlIGRtYV9tYXBfcmVzb3VyY2UoKSBpbnRlcmZhY2UuCj4gPj4+IElrLCBidXQg
eWVzIHRoYXQgZG9lcyAid29yayIuIExvZ2FuJ3Mgc2VyaWVzIGlzIGJldHRlci4KPiA+PiBObyBp
dCBpc24ndC4gSXQgbWFrZXMgZGV2aWNlcyBkZXBlbmQgb24gYWxsb2NhdGluZyBzdHJ1Y3QgcGFn
ZXMgZm9yIHRoZWlyCj4gPj4gQkFScyB3aGljaCBpcyBub3QgbmVjZXNzYXJ5IG5vciBkZXNpcmVk
Lgo+ID4gV2hpY2ggZHJhbWF0aWNhbGx5IHJlZHVjZXMgdGhlIGNvc3Qgb2YgZXN0YWJsaXNoaW5n
IERNQSBtYXBwaW5ncywgYQo+ID4gbG9vcCBvZiBkbWFfbWFwX3Jlc291cmNlKCkgaXMgdmVyeSBl
eHBlbnNpdmUuCj4KPiBZZWFoLCBidXQgdGhhdCBpcyBwZXJmZWN0bHkgb2suIE91ciBCQVIgYWxs
b2NhdGlvbnMgYXJlIGVpdGhlciBpbiBjaHVua3MKPiBvZiBhdCBsZWFzdCAyTWlCIG9yIG9ubHkg
YSBzaW5nbGUgNEtpQiBwYWdlLgo+Cj4gT2RlZCBtaWdodCBydW4gaW50byBtb3JlIHBlcmZvcm1h
bmNlIHByb2JsZW1zLCBidXQgdGhvc2UgRE1BLWJ1Zgo+IG1hcHBpbmdzIGFyZSB1c3VhbGx5IHNl
dCB1cCBvbmx5IG9uY2UuCj4KPiA+PiBIb3cgZG8geW91IHByZXZlbnQgZGlyZWN0IEkvTyBvbiB0
aG9zZSBwYWdlcyBmb3IgZXhhbXBsZT8KPiA+IEdVUCBmYWlscy4KPgo+IEF0IGxlYXN0IHRoYXQg
aXMgY2FsbWluZy4KPgo+ID4+IEFsbG9jYXRpbmcgYSBzdHJ1Y3QgcGFnZXMgaGFzIHRoZWlyIHVz
ZSBjYXNlLCBmb3IgZXhhbXBsZSBmb3IgZXhwb3NpbmcgVlJBTQo+ID4+IGFzIG1lbW9yeSBmb3Ig
SE1NLiBCdXQgdGhhdCBpcyBzb21ldGhpbmcgdmVyeSBzcGVjaWZpYyBhbmQgc2hvdWxkIG5vdCBs
aW1pdAo+ID4+IFBDSWUgUDJQIERNQSBpbiBnZW5lcmFsLgo+ID4gU3VyZSwgYnV0IHRoYXQgaXMg
YW4gaWRlYWwgd2UgYXJlIGZhciBmcm9tIG9idGFpbmluZywgYW5kIG5vYm9keSB3YW50cwo+ID4g
dG8gd29yayBvbiBpdCBwcmVmZXJpbmcgdG8gZG8gaGFja3kgaGFja3kgbGlrZSB0aGlzLgo+ID4K
PiA+IElmIHlvdSBiZWxpZXZlIGluIHRoaXMgdGhlbiByZW1vdmUgdGhlIHNjYXR0ZXIgbGlzdCBm
cm9tIGRtYWJ1ZiwgYWRkIGEKPiA+IG5ldyBzZXQgb2YgZG1hX21hcCogQVBJcyB0byB3b3JrIG9u
IHBoeXNpY2FsIGFkZHJlc3NlcyBhbmQgYWxsIHRoZQo+ID4gb3RoZXIgc3R1ZmYgbmVlZGVkLgo+
Cj4gWWVhaCwgdGhhdCdzIHdoYXQgSSB0b3RhbGx5IGFncmVlIG9uLiBBbmQgSSBhY3R1YWxseSBo
b3BlZCB0aGF0IHRoZSBuZXcKPiBQMlAgd29yayBmb3IgUENJZSB3b3VsZCBnbyBpbnRvIHRoYXQg
ZGlyZWN0aW9uLCBidXQgdGhhdCBkaWRuJ3QKPiBtYXRlcmlhbGl6ZWQuCj4KPiBCdXQgYWxsb2Nh
dGluZyBzdHJ1Y3QgcGFnZXMgZm9yIFBDSWUgQkFScyB3aGljaCBhcmUgZXNzZW50aWFsbHkKPiBy
ZWdpc3RlcnMgYW5kIG5vdCBtZW1vcnkgaXMgbXVjaCBtb3JlIGhhY2t5IHRoYW4gdGhlIGRtYV9y
ZXNvdXJjZV9tYXAoKQo+IGFwcHJvYWNoLgo+Cj4gVG8gcmUtaXRlcmF0ZSB3aHkgSSB0aGluayB0
aGF0IGhhdmluZyBzdHJ1Y3QgcGFnZXMgZm9yIHRob3NlIEJBUnMgaXMgYQo+IGJhZCBpZGVhOiBP
dXIgZG9vcmJlbGxzIG9uIEFNRCBHUFVzIGFyZSB3cml0ZSBhbmQgcmVhZCBwb2ludGVycyBmb3Ig
cmluZwo+IGJ1ZmZlcnMuCj4KPiBXaGVuIHlvdSB3cml0ZSB0byB0aGUgQkFSIHlvdSBlc3NlbnRp
YWxseSB0ZWxsIHRoZSBmaXJtd2FyZSB0aGF0IHlvdQo+IGhhdmUgZWl0aGVyIGZpbGxlZCB0aGUg
cmluZyBidWZmZXIgb3IgcmVhZCBhIGJ1bmNoIG9mIGl0LiBUaGlzIGluIHR1cm4KPiB0aGVuIHRy
aWdnZXJzIGFuIGludGVycnVwdCBpbiB0aGUgaGFyZHdhcmUvZmlybXdhcmUgd2hpY2ggd2FzIGV2
ZW50dWFsbHkKPiBhc2xlZXAuCj4KPiBCeSB1c2luZyBQQ0llIFAyUCB3ZSB3YW50IHRvIGF2b2lk
IHRoZSByb3VuZCB0cmlwIHRvIHRoZSBDUFUgd2hlbiBvbmUKPiBkZXZpY2UgaGFzIGZpbGxlZCB0
aGUgcmluZyBidWZmZXIgYW5kIGFub3RoZXIgZGV2aWNlIG11c3QgYmUgd29rZW4gdXAgdG8KPiBw
cm9jZXNzIGl0Lgo+Cj4gVGhpbmsgb2YgaXQgYXMgTVNJLVggaW4gcmV2ZXJzZSBhbmQgYWxsb2Nh
dGluZyBzdHJ1Y3QgcGFnZXMgZm9yIHRob3NlCj4gQkFScyBqdXN0IHRvIHdvcmsgYXJvdW5kIHRo
ZSBzaG9ydGNvbWluZ3Mgb2YgdGhlIERNQSBBUEkgbWFrZXMgbm8gc2Vuc2UKPiBhdCBhbGwgdG8g
bWUuCldlIHdvdWxkIGFsc28gbGlrZSB0byBkbyB0aGF0ICppbiB0aGUgZnV0dXJlKi4KSW4gR2F1
ZGkgaXQgd2lsbCBuZXZlciBiZSBzdXBwb3J0ZWQgKGR1ZSB0byBzZWN1cml0eSBsaW1pdGF0aW9u
cykgYnV0CkkgZGVmaW5pdGVseSBzZWUgaXQgaGFwcGVuaW5nIGluIGZ1dHVyZSBBU0lDcy4KCk9k
ZWQKCj4KPgo+IFdlIGFsc28gZG8gaGF2ZSB0aGUgVlJBTSBCQVIsIGFuZCBmb3IgSE1NIHdlIGRv
IGFsbG9jYXRlIHN0cnVjdCBwYWdlcwo+IGZvciB0aGUgYWRkcmVzcyByYW5nZSBleHBvc2VkIHRo
ZXJlLiBCdXQgdGhpcyBpcyBhIGRpZmZlcmVudCB1c2UgY2FzZS4KPgo+IFJlZ2FyZHMsCj4gQ2hy
aXN0aWFuLgo+Cj4gPgo+ID4gT3RoZXJ3aXNlLCB3ZSBoYXZlIHdoYXQgd2UgaGF2ZSBhbmQgZHJp
dmVycyBkb24ndCBnZXQgdG8gb3B0IG91dC4gVGhpcwo+ID4gaXMgd2h5IHRoZSBzdHVmZiBpbiBB
TURHUFUgd2FzIE5BSydkLgo+ID4KPiA+IEphc29uCj4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
