Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D211C49EA5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 12:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2883961164
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 12:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2883961164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9EA16E112;
	Tue, 22 Jun 2021 12:04:59 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50E866E104;
 Tue, 22 Jun 2021 12:04:58 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id s17so653477oij.0;
 Tue, 22 Jun 2021 05:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UXu33zooM1Crc13Vebp8C5tdePhjb755cOhdTYx1RhI=;
 b=IBxYEyz8qFrpyXjdmOhua9qpGyNdwX02NaojZVpftJeAz4cyuDCEAd0+qADxitTYR9
 7LRSirAlbT/vLaBcd+EYJxNpTrceIy3pY9v4vL2s6kVGve2mWavF/S9gdoUEARKwK86J
 MRxtY7QJRKDwFpOVd1o8eFa7zoGV0XWD+kEyUY9F4Fya8NeamnK6jjoUDTk28fAgr6hp
 xtzu8p/laLWYbN9YzUjaZnlg2BzkAEBUrlpuilkihQrotRNoB1aKYIzadRsiBb/qRf5P
 5eigpS//hdZK/xPV9k2CHEAQdna490dEykBfiNm2Sx4X4XKQnb3AfoUMJXKOf+KtYuYs
 /9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UXu33zooM1Crc13Vebp8C5tdePhjb755cOhdTYx1RhI=;
 b=THpQIk1mCnxpKcsDANz9Vqn4PebibnggTp2D6qn1yorFJZeCyfTHOoARYGYZHxq9jb
 L925OVhEF8v3TSNrS6Fie/dh4D7Ex0gLV4nAxPyrUuhGaCwi0pgNyaLVfm9T9jKRW3u7
 ilU1wTdsvxEIDm3nKybeMJThi6Q4/+gEkVF7wdZi7UukWePykEn8GdYhO9sbNrVlTbsO
 Ivi9ec24UVrReqhhz5+iw/Rjo9JRLr890vQzUGuRzZw8TDk7F7EW+6cxjSfOTv6+THR9
 XkHAcfynVDS2EsAivdGHjNrjZEi/5AXYqzBO3oabElaJR02Mjtk0ERulIW8m/TX9nwyq
 vd6Q==
X-Gm-Message-State: AOAM531EFIEXKmSjRnlYP9WEKIArA/Os48H0QhtqrheSWlb10qz5jcpj
 v6wY9Nn0bM1LoQFim+3E1Zi0zHEGrAC0Mraf2x4=
X-Google-Smtp-Source: ABdhPJz9eTOAYS/A5LDYycSvFHQxs/rBQ2qipYP0MTUC17z8ZF/zeA2uqIWquOAnXIrUs1z3RzFaGSzZm9SwmWCsolo=
X-Received: by 2002:aca:ac02:: with SMTP id v2mr2855756oie.154.1624363497566; 
 Tue, 22 Jun 2021 05:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAKMK7uFOfoxbD2Z5mb-qHFnUe5rObGKQ6Ygh--HSH9M=9bziGg@mail.gmail.com>
 <YNCN0ulL6DQiRJaB@kroah.com> <20210621141217.GE1096940@ziepe.ca>
 <CAFCwf10KvCh0zfHEHqYR-Na6KJh4j+9i-6+==QaMdHHpLH1yEA@mail.gmail.com>
 <20210621175511.GI1096940@ziepe.ca>
 <CAKMK7uEO1_B59DtM7N2g7kkH7pYtLM_WAkn+0f3FU3ps=XEjZQ@mail.gmail.com>
 <CAFCwf11jOnewkbLuxUESswCJpyo7C0ovZj80UrnwUOZkPv2JYQ@mail.gmail.com>
 <20210621232912.GK1096940@ziepe.ca>
 <d358c740-fd3a-9ecd-7001-676e2cb44ec9@gmail.com>
 <CAFCwf11h_Nj_GEdCdeTzO5jgr-Y9em+W-v_pYUfz64i5Ac25yg@mail.gmail.com>
 <20210622120142.GL1096940@ziepe.ca>
In-Reply-To: <20210622120142.GL1096940@ziepe.ca>
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Tue, 22 Jun 2021 15:04:30 +0300
Message-ID: <CAFCwf10GmBjeJAFp0uJsMLiv-8HWAR==RqV9ZdMQz+iW9XWdTA@mail.gmail.com>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
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

T24gVHVlLCBKdW4gMjIsIDIwMjEgYXQgMzowMSBQTSBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVw
ZS5jYT4gd3JvdGU6Cj4KPiBPbiBUdWUsIEp1biAyMiwgMjAyMSBhdCAxMTo0MjoyN0FNICswMzAw
LCBPZGVkIEdhYmJheSB3cm90ZToKPiA+IE9uIFR1ZSwgSnVuIDIyLCAyMDIxIGF0IDk6MzcgQU0g
Q2hyaXN0aWFuIEvDtm5pZwo+ID4gPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiB3
cm90ZToKPiA+ID4KPiA+ID4gQW0gMjIuMDYuMjEgdW0gMDE6Mjkgc2NocmllYiBKYXNvbiBHdW50
aG9ycGU6Cj4gPiA+ID4gT24gTW9uLCBKdW4gMjEsIDIwMjEgYXQgMTA6MjQ6MTZQTSArMDMwMCwg
T2RlZCBHYWJiYXkgd3JvdGU6Cj4gPiA+ID4KPiA+ID4gPj4gQW5vdGhlciB0aGluZyBJIHdhbnQg
dG8gZW1waGFzaXplIGlzIHRoYXQgd2UgYXJlIGRvaW5nIHAycCBvbmx5Cj4gPiA+ID4+IHRocm91
Z2ggdGhlIGV4cG9ydC9pbXBvcnQgb2YgdGhlIEZELiBXZSBkbyAqbm90KiBhbGxvdyB0aGUgdXNl
ciB0bwo+ID4gPiA+PiBtbWFwIHRoZSBkbWEtYnVmIGFzIHdlIGRvIG5vdCBzdXBwb3J0IGRpcmVj
dCBJTy4gU28gdGhlcmUgaXMgbm8gYWNjZXNzCj4gPiA+ID4+IHRvIHRoZXNlIHBhZ2VzIHRocm91
Z2ggdGhlIHVzZXJzcGFjZS4KPiA+ID4gPiBBcmd1YWJseSBtbWFwaW5nIHRoZSBtZW1vcnkgaXMg
YSBiZXR0ZXIgY2hvaWNlLCBhbmQgaXMgdGhlIGRpcmVjdGlvbgo+ID4gPiA+IHRoYXQgTG9nYW4n
cyBzZXJpZXMgZ29lcyBpbi4gSGVyZSB0aGUgdXNlIG9mIERNQUJVRiB3YXMgc3BlY2lmaWNhbGx5
Cj4gPiA+ID4gZGVzaWduZWQgdG8gYWxsb3cgaGl0bGVzcyByZXZva2F0aW9uIG9mIHRoZSBtZW1v
cnksIHdoaWNoIHRoaXMgaXNuJ3QKPiA+ID4gPiBldmVuIHVzaW5nLgo+ID4gPgo+ID4gPiBUaGUg
bWFqb3IgcHJvYmxlbSB3aXRoIHRoaXMgYXBwcm9hY2ggaXMgdGhhdCBETUEtYnVmIGlzIGFsc28g
dXNlZCBmb3IKPiA+ID4gbWVtb3J5IHdoaWNoIGlzbid0IENQVSBhY2Nlc3NpYmxlLgo+Cj4gVGhh
dCBpc24ndCBhbiBpc3N1ZSBoZXJlIGJlY2F1c2UgdGhlIG1lbW9yeSBpcyBvbmx5IGludGVuZGVk
IHRvIGJlCj4gdXNlZCB3aXRoIFAyUCB0cmFuc2ZlcnMgc28gaXQgbXVzdCBiZSBDUFUgYWNjZXNz
aWJsZS4KPgo+ID4gPiBUaGF0IHdhcyBvbmUgb2YgdGhlIHJlYXNvbnMgd2UgZGlkbid0IGV2ZW4g
Y29uc2lkZXJlZCB1c2luZyB0aGUgbWFwcGluZwo+ID4gPiBtZW1vcnkgYXBwcm9hY2ggZm9yIEdQ
VXMuCj4KPiBXZWxsLCBub3cgd2UgaGF2ZSBERVZJQ0VfUFJJVkFURSBtZW1vcnkgdGhhdCBjYW4g
bWVldCB0aGlzIG5lZWQKPiB0b28uLiBKdXN0IG5vYm9keSBoYXMgd2lyZWQgaXQgdXAgdG8gaG1t
X3JhbmdlX2ZhdWx0KCkKPgo+ID4gPiA+IFNvIHlvdSBhcmUgdGFraW5nIHRoZSBoaXQgb2YgdmVy
eSBsaW1pdGVkIGhhcmR3YXJlIHN1cHBvcnQgYW5kIHJlZHVjZWQKPiA+ID4gPiBwZXJmb3JtYW5j
ZSBqdXN0IHRvIHNxdWVlemUgaW50byBETUFCVUYuLgo+ID4KPiA+IFRoYW5rcyBKYXNvbiBmb3Ig
dGhlIGNsYXJpZmljYXRpb24sIGJ1dCBJIGhvbmVzdGx5IHByZWZlciB0byB1c2UKPiA+IERNQS1C
VUYgYXQgdGhlIG1vbWVudC4KPiA+IEl0IGdpdmVzIHVzIGp1c3Qgd2hhdCB3ZSBuZWVkIChldmVu
IG1vcmUgdGhhbiB3aGF0IHdlIG5lZWQgYXMgeW91Cj4gPiBwb2ludGVkIG91dCksIGl0IGlzICph
bHJlYWR5KiBpbnRlZ3JhdGVkIGFuZCB0ZXN0ZWQgaW4gdGhlIFJETUEKPiA+IHN1YnN5c3RlbSwg
YW5kIEknbSBmZWVsaW5nIGNvbWZvcnRhYmxlIHVzaW5nIGl0IGFzIEknbSBzb21ld2hhdAo+ID4g
ZmFtaWxpYXIgd2l0aCBpdCBmcm9tIG15IEFNRCBkYXlzLgo+Cj4gWW91IHN0aWxsIGhhdmUgdGhl
IGlzc3VlIHRoYXQgdGhpcyBwYXRjaCBpcyBkb2luZyBhbGwgb2YgdGhpcyBQMlAKPiBzdHVmZiB3
cm9uZyAtIGZvbGxvd2luZyB0aGUgYWxyZWFkeSBOQUsnZCBBTUQgYXBwcm9hY2guCgpDb3VsZCB5
b3UgcGxlYXNlIHBvaW50IG1lIGV4YWN0bHkgdG8gdGhlIGxpbmVzIG9mIGNvZGUgdGhhdCBhcmUg
d3JvbmcKaW4geW91ciBvcGluaW9uID8KSSBmaW5kIGl0IGhhcmQgdG8gdW5kZXJzdGFuZCBmcm9t
IHlvdXIgc3RhdGVtZW50IHdoYXQgZXhhY3RseSB5b3UKdGhpbmsgdGhhdCB3ZSBhcmUgZG9pbmcg
d3JvbmcuClRoZSBpbXBsZW1lbnRhdGlvbiBpcyBmb3VuZCBpbiB0aGUgc2Vjb25kIHBhdGNoIGlu
IHRoaXMgcGF0Y2gtc2V0LgoKVGhhbmtzLApPZGVkCj4KPiA+IEknbGwgZ28gYW5kIHJlYWQgTG9n
YW4ncyBwYXRjaC1zZXQgdG8gc2VlIGlmIHRoYXQgd2lsbCB3b3JrIGZvciB1cyBpbgo+ID4gdGhl
IGZ1dHVyZS4gUGxlYXNlIHJlbWVtYmVyLCBhcyBEYW5pZWwgc2FpZCwgd2UgZG9uJ3QgaGF2ZSBz
dHJ1Y3QgcGFnZQo+ID4gYmFja2luZyBvdXIgZGV2aWNlIG1lbW9yeSwgc28gaWYgdGhhdCBpcyBh
IHJlcXVpcmVtZW50IHRvIGNvbm5lY3QgdG8KPiA+IExvZ2FuJ3Mgd29yaywgdGhlbiBJIGRvbid0
IHRoaW5rIHdlIHdpbGwgd2FudCB0byBkbyBpdCBhdCB0aGlzIHBvaW50Lgo+Cj4gSXQgaXMgdHJp
dmlhbCB0byBnZXQgdGhlIHN0cnVjdCBwYWdlIGZvciBhIFBDSSBCQVIuCj4KPiBKYXNvbgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
