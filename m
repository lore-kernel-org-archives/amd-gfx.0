Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D02C2B9F4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 08:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B4A6134F
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 08:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B4A6134F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD1786E44C;
	Tue, 22 Jun 2021 08:42:55 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCC496E0F3;
 Tue, 22 Jun 2021 08:42:54 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 f3-20020a0568301c23b029044ce5da4794so13885326ote.11; 
 Tue, 22 Jun 2021 01:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Wk5uHooOe9m9o4Li9n5UAmr51NiBBmwNJ7AeW2XMF1s=;
 b=DpDeRnU/4unkLfeKoqfIKEFsfBMZFLBF8xKaZiqlTL9oc6P670t4XFLRq0TbDdE6nr
 Ztf3mV6Jahqo5RivMEWXCClTKbKDMDe6c7CL3y9QiJTZt8/r2DB9HhkBvxBCH8TrEfdm
 Rt/c8fK3pi38t+F5QDTk0+rxauu4yuqIqdSUlpvdAhK+1McLQSnLZ32JDHCpHLb58xJG
 9PLhewIvLG/dnvIOahxYSNKAxU8IZKlfkXFiSxdV5+C0PGXWM7yX0apmRtf4EIruhPsC
 ZdnMtoc3+SsuyvZ4RQOwY5D2Bxf48aWo0hzb8v20huhOrOF7qWZgFU7vlfk5rpemBNeB
 mw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Wk5uHooOe9m9o4Li9n5UAmr51NiBBmwNJ7AeW2XMF1s=;
 b=ZVWlAIyRGm4oYt/upbFWOaQGgLFlNel+x11nPNgGDztlL077q9tf3Wo1O5BpQ6Rjz3
 8vps0U/ofrnbJYvkZmO1lAkzhZzpaZ7OOa05AEulyFOFmNVL2zia2l4PWCzeFbg9IJvH
 4NtZoO0KRhn8m8A07gGbkywW9V4PabsCCRqCd6zhHedaVejQSvCtRgn1IWnqHOC4JNqa
 mB9o7GZ14AUdn1jTRdOzICLfDI+jXtVMjRArsQhbdBSMDcztYnKSA7MMvkGryws1jBhW
 S2JLP0CgzqgiaIIaaEHHRo6tGXv1OvwtZ5I4j09cbA0lj/k3Eg4mbirVfkFEAnNDl/+e
 yzEA==
X-Gm-Message-State: AOAM532Dr2dCxhw7lq+3b09hCtVbJnSlz1+PuXBlXgnR/RTQHwXC21cC
 WRpJpAb0g+IJEtBWR8qVQO7lJe6wU6hoZ/R6S74=
X-Google-Smtp-Source: ABdhPJzeINwyGxytAS9kO9kcC4dX49tJx+ip+znA7WLEk4h03GgImJS/DeJ5KNQOD5tnXfEngTt8fSVxTPnkQjTwAv4=
X-Received: by 2002:a9d:509:: with SMTP id 9mr2169190otw.339.1624351373978;
 Tue, 22 Jun 2021 01:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210618123615.11456-1-ogabbay@kernel.org>
 <CAKMK7uFOfoxbD2Z5mb-qHFnUe5rObGKQ6Ygh--HSH9M=9bziGg@mail.gmail.com>
 <YNCN0ulL6DQiRJaB@kroah.com> <20210621141217.GE1096940@ziepe.ca>
 <CAFCwf10KvCh0zfHEHqYR-Na6KJh4j+9i-6+==QaMdHHpLH1yEA@mail.gmail.com>
 <20210621175511.GI1096940@ziepe.ca>
 <CAKMK7uEO1_B59DtM7N2g7kkH7pYtLM_WAkn+0f3FU3ps=XEjZQ@mail.gmail.com>
 <CAFCwf11jOnewkbLuxUESswCJpyo7C0ovZj80UrnwUOZkPv2JYQ@mail.gmail.com>
 <20210621232912.GK1096940@ziepe.ca>
 <d358c740-fd3a-9ecd-7001-676e2cb44ec9@gmail.com>
In-Reply-To: <d358c740-fd3a-9ecd-7001-676e2cb44ec9@gmail.com>
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Tue, 22 Jun 2021 11:42:27 +0300
Message-ID: <CAFCwf11h_Nj_GEdCdeTzO5jgr-Y9em+W-v_pYUfz64i5Ac25yg@mail.gmail.com>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sleybo@amazon.com,
 Gal Pressman <galpress@amazon.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
 Tomer Tayar <ttayar@habana.ai>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Greg KH <gregkh@linuxfoundation.org>, Alex Deucher <alexander.deucher@amd.com>,
 Leon Romanovsky <leonro@nvidia.com>, Oded Gabbay <ogabbay@kernel.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBKdW4gMjIsIDIwMjEgYXQgOTozNyBBTSBDaHJpc3RpYW4gS8O2bmlnCjxja29lbmln
LmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBBbSAyMi4wNi4yMSB1bSAwMToy
OSBzY2hyaWViIEphc29uIEd1bnRob3JwZToKPiA+IE9uIE1vbiwgSnVuIDIxLCAyMDIxIGF0IDEw
OjI0OjE2UE0gKzAzMDAsIE9kZWQgR2FiYmF5IHdyb3RlOgo+ID4KPiA+PiBBbm90aGVyIHRoaW5n
IEkgd2FudCB0byBlbXBoYXNpemUgaXMgdGhhdCB3ZSBhcmUgZG9pbmcgcDJwIG9ubHkKPiA+PiB0
aHJvdWdoIHRoZSBleHBvcnQvaW1wb3J0IG9mIHRoZSBGRC4gV2UgZG8gKm5vdCogYWxsb3cgdGhl
IHVzZXIgdG8KPiA+PiBtbWFwIHRoZSBkbWEtYnVmIGFzIHdlIGRvIG5vdCBzdXBwb3J0IGRpcmVj
dCBJTy4gU28gdGhlcmUgaXMgbm8gYWNjZXNzCj4gPj4gdG8gdGhlc2UgcGFnZXMgdGhyb3VnaCB0
aGUgdXNlcnNwYWNlLgo+ID4gQXJndWFibHkgbW1hcGluZyB0aGUgbWVtb3J5IGlzIGEgYmV0dGVy
IGNob2ljZSwgYW5kIGlzIHRoZSBkaXJlY3Rpb24KPiA+IHRoYXQgTG9nYW4ncyBzZXJpZXMgZ29l
cyBpbi4gSGVyZSB0aGUgdXNlIG9mIERNQUJVRiB3YXMgc3BlY2lmaWNhbGx5Cj4gPiBkZXNpZ25l
ZCB0byBhbGxvdyBoaXRsZXNzIHJldm9rYXRpb24gb2YgdGhlIG1lbW9yeSwgd2hpY2ggdGhpcyBp
c24ndAo+ID4gZXZlbiB1c2luZy4KPgo+IFRoZSBtYWpvciBwcm9ibGVtIHdpdGggdGhpcyBhcHBy
b2FjaCBpcyB0aGF0IERNQS1idWYgaXMgYWxzbyB1c2VkIGZvcgo+IG1lbW9yeSB3aGljaCBpc24n
dCBDUFUgYWNjZXNzaWJsZS4KPgo+IFRoYXQgd2FzIG9uZSBvZiB0aGUgcmVhc29ucyB3ZSBkaWRu
J3QgZXZlbiBjb25zaWRlcmVkIHVzaW5nIHRoZSBtYXBwaW5nCj4gbWVtb3J5IGFwcHJvYWNoIGZv
ciBHUFVzLgo+Cj4gUmVnYXJkcywKPiBDaHJpc3RpYW4uCj4KPiA+Cj4gPiBTbyB5b3UgYXJlIHRh
a2luZyB0aGUgaGl0IG9mIHZlcnkgbGltaXRlZCBoYXJkd2FyZSBzdXBwb3J0IGFuZCByZWR1Y2Vk
Cj4gPiBwZXJmb3JtYW5jZSBqdXN0IHRvIHNxdWVlemUgaW50byBETUFCVUYuLgoKVGhhbmtzIEph
c29uIGZvciB0aGUgY2xhcmlmaWNhdGlvbiwgYnV0IEkgaG9uZXN0bHkgcHJlZmVyIHRvIHVzZQpE
TUEtQlVGIGF0IHRoZSBtb21lbnQuCkl0IGdpdmVzIHVzIGp1c3Qgd2hhdCB3ZSBuZWVkIChldmVu
IG1vcmUgdGhhbiB3aGF0IHdlIG5lZWQgYXMgeW91CnBvaW50ZWQgb3V0KSwgaXQgaXMgKmFscmVh
ZHkqIGludGVncmF0ZWQgYW5kIHRlc3RlZCBpbiB0aGUgUkRNQQpzdWJzeXN0ZW0sIGFuZCBJJ20g
ZmVlbGluZyBjb21mb3J0YWJsZSB1c2luZyBpdCBhcyBJJ20gc29tZXdoYXQKZmFtaWxpYXIgd2l0
aCBpdCBmcm9tIG15IEFNRCBkYXlzLgoKSSdsbCBnbyBhbmQgcmVhZCBMb2dhbidzIHBhdGNoLXNl
dCB0byBzZWUgaWYgdGhhdCB3aWxsIHdvcmsgZm9yIHVzIGluCnRoZSBmdXR1cmUuIFBsZWFzZSBy
ZW1lbWJlciwgYXMgRGFuaWVsIHNhaWQsIHdlIGRvbid0IGhhdmUgc3RydWN0IHBhZ2UKYmFja2lu
ZyBvdXIgZGV2aWNlIG1lbW9yeSwgc28gaWYgdGhhdCBpcyBhIHJlcXVpcmVtZW50IHRvIGNvbm5l
Y3QgdG8KTG9nYW4ncyB3b3JrLCB0aGVuIEkgZG9uJ3QgdGhpbmsgd2Ugd2lsbCB3YW50IHRvIGRv
IGl0IGF0IHRoaXMgcG9pbnQuCgpUaGFua3MsCk9kZWQKCj4gPgo+ID4gSmFzb24KPiA+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gPiBMaW5hcm8tbW0t
c2lnIG1haWxpbmcgbGlzdAo+ID4gTGluYXJvLW1tLXNpZ0BsaXN0cy5saW5hcm8ub3JnCj4gPiBo
dHRwczovL2xpc3RzLmxpbmFyby5vcmcvbWFpbG1hbi9saXN0aW5mby9saW5hcm8tbW0tc2lnCj4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
