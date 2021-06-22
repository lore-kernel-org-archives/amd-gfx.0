Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FDAC48BDF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 13:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83E4B61352
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 13:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E4B61352
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AB9B6E4F9;
	Tue, 22 Jun 2021 13:12:55 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACFA76E4F9;
 Tue, 22 Jun 2021 13:12:53 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id s23so23684214oiw.9;
 Tue, 22 Jun 2021 06:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Zo8AMbVZ0Bpk+i0daFhjZFD9mbDtHeyM5fWaVTiW44c=;
 b=M05I4XSyQvJq3QrAd4YBgso50a64XymDeEWCojzzYqEGpvV4rh82mK2VGpP2ZpQw/K
 qKLMFRbXqv6tTtNOrZ0DfZ/7XN9zk8aAO7H29pjKNlXbwyFKm1mGbOqZSO36X7wT3m7P
 81j0l7w9IdikOL9pXOvSfc2I4ej0eigFsmLjVhpf6rAwucqQvM2hTGGC03uozjBCzjhM
 b0RYRSapW0yTEw7Ctcr7dBktk7sjweeCgQXLqe0Djkdv/UeVSGwRA1/91NCbYrZi3ufl
 11gmazwOPS8f0/v7rNXQbB349lJ4lS6Zf/6sYR4bj+imOJbN3S+rAay06cfD0bzrE63T
 LGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Zo8AMbVZ0Bpk+i0daFhjZFD9mbDtHeyM5fWaVTiW44c=;
 b=JZ5mEuEab/fNo2tJG/vVX+6LGReloVPp4hrc6qHJ1rlIgYRCTJObRVRHUZjaaxBsXp
 RL3ng3RP/GIcrzdDh5fMmgv2no/zY9Wi1BymC+yVm0MuUc+cB1pmPSAUbjxjK2/Ygs9y
 gDC8fJ29UCWCbo60ARasL9lTzigJP3+eWWpCmLEAILZtTVm4TkbaBprcKu1PXCa9zfxi
 yHWBBvA8gIExMvn2LuKaI9RBZsBS2Mu8wYfh238TI/JjaK2T1KlntNKLhTwPQI+YuJM9
 3rA/7iP5EPuOupUdfTtWjYGrLBDPfxKuz6zL2g9o4zhIt0+WJrl0wY/LhN7Azq91U/WC
 r+wQ==
X-Gm-Message-State: AOAM533ekYc9jPy2zmDb7dzkOhKLclU9cZDAqvHM8YqawgfhuujKgUFi
 gkVeBC2gb3+V0e48+3xPcBETa0KU5RCw0fOZ/4E=
X-Google-Smtp-Source: ABdhPJx0VEzjKsRYKDZvxAXPUrSx4rHDbmALWmjVLs/sT+gDzBTdktbxkHUJKd8+jHZcNZxQ6zZrih+vNRQS+TgBW6w=
X-Received: by 2002:aca:3bc3:: with SMTP id i186mr2878226oia.102.1624367572833; 
 Tue, 22 Jun 2021 06:12:52 -0700 (PDT)
MIME-Version: 1.0
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
 <20210622121546.GN1096940@ziepe.ca>
In-Reply-To: <20210622121546.GN1096940@ziepe.ca>
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Tue, 22 Jun 2021 16:12:26 +0300
Message-ID: <CAFCwf13BuS+U3Pko_62hFPuvZPG26HQXuu-cxPmcADNPO22g9g@mail.gmail.com>
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

T24gVHVlLCBKdW4gMjIsIDIwMjEgYXQgMzoxNSBQTSBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVw
ZS5jYT4gd3JvdGU6Cj4KPiBPbiBUdWUsIEp1biAyMiwgMjAyMSBhdCAwMzowNDozMFBNICswMzAw
LCBPZGVkIEdhYmJheSB3cm90ZToKPiA+IE9uIFR1ZSwgSnVuIDIyLCAyMDIxIGF0IDM6MDEgUE0g
SmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBUdWUs
IEp1biAyMiwgMjAyMSBhdCAxMTo0MjoyN0FNICswMzAwLCBPZGVkIEdhYmJheSB3cm90ZToKPiA+
ID4gPiBPbiBUdWUsIEp1biAyMiwgMjAyMSBhdCA5OjM3IEFNIENocmlzdGlhbiBLw7ZuaWcKPiA+
ID4gPiA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+ID4gPiA+ID4K
PiA+ID4gPiA+IEFtIDIyLjA2LjIxIHVtIDAxOjI5IHNjaHJpZWIgSmFzb24gR3VudGhvcnBlOgo+
ID4gPiA+ID4gPiBPbiBNb24sIEp1biAyMSwgMjAyMSBhdCAxMDoyNDoxNlBNICswMzAwLCBPZGVk
IEdhYmJheSB3cm90ZToKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4+IEFub3RoZXIgdGhpbmcgSSB3
YW50IHRvIGVtcGhhc2l6ZSBpcyB0aGF0IHdlIGFyZSBkb2luZyBwMnAgb25seQo+ID4gPiA+ID4g
Pj4gdGhyb3VnaCB0aGUgZXhwb3J0L2ltcG9ydCBvZiB0aGUgRkQuIFdlIGRvICpub3QqIGFsbG93
IHRoZSB1c2VyIHRvCj4gPiA+ID4gPiA+PiBtbWFwIHRoZSBkbWEtYnVmIGFzIHdlIGRvIG5vdCBz
dXBwb3J0IGRpcmVjdCBJTy4gU28gdGhlcmUgaXMgbm8gYWNjZXNzCj4gPiA+ID4gPiA+PiB0byB0
aGVzZSBwYWdlcyB0aHJvdWdoIHRoZSB1c2Vyc3BhY2UuCj4gPiA+ID4gPiA+IEFyZ3VhYmx5IG1t
YXBpbmcgdGhlIG1lbW9yeSBpcyBhIGJldHRlciBjaG9pY2UsIGFuZCBpcyB0aGUgZGlyZWN0aW9u
Cj4gPiA+ID4gPiA+IHRoYXQgTG9nYW4ncyBzZXJpZXMgZ29lcyBpbi4gSGVyZSB0aGUgdXNlIG9m
IERNQUJVRiB3YXMgc3BlY2lmaWNhbGx5Cj4gPiA+ID4gPiA+IGRlc2lnbmVkIHRvIGFsbG93IGhp
dGxlc3MgcmV2b2thdGlvbiBvZiB0aGUgbWVtb3J5LCB3aGljaCB0aGlzIGlzbid0Cj4gPiA+ID4g
PiA+IGV2ZW4gdXNpbmcuCj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhlIG1ham9yIHByb2JsZW0gd2l0
aCB0aGlzIGFwcHJvYWNoIGlzIHRoYXQgRE1BLWJ1ZiBpcyBhbHNvIHVzZWQgZm9yCj4gPiA+ID4g
PiBtZW1vcnkgd2hpY2ggaXNuJ3QgQ1BVIGFjY2Vzc2libGUuCj4gPiA+Cj4gPiA+IFRoYXQgaXNu
J3QgYW4gaXNzdWUgaGVyZSBiZWNhdXNlIHRoZSBtZW1vcnkgaXMgb25seSBpbnRlbmRlZCB0byBi
ZQo+ID4gPiB1c2VkIHdpdGggUDJQIHRyYW5zZmVycyBzbyBpdCBtdXN0IGJlIENQVSBhY2Nlc3Np
YmxlLgo+ID4gPgo+ID4gPiA+ID4gVGhhdCB3YXMgb25lIG9mIHRoZSByZWFzb25zIHdlIGRpZG4n
dCBldmVuIGNvbnNpZGVyZWQgdXNpbmcgdGhlIG1hcHBpbmcKPiA+ID4gPiA+IG1lbW9yeSBhcHBy
b2FjaCBmb3IgR1BVcy4KPiA+ID4KPiA+ID4gV2VsbCwgbm93IHdlIGhhdmUgREVWSUNFX1BSSVZB
VEUgbWVtb3J5IHRoYXQgY2FuIG1lZXQgdGhpcyBuZWVkCj4gPiA+IHRvby4uIEp1c3Qgbm9ib2R5
IGhhcyB3aXJlZCBpdCB1cCB0byBobW1fcmFuZ2VfZmF1bHQoKQo+ID4gPgo+ID4gPiA+ID4gPiBT
byB5b3UgYXJlIHRha2luZyB0aGUgaGl0IG9mIHZlcnkgbGltaXRlZCBoYXJkd2FyZSBzdXBwb3J0
IGFuZCByZWR1Y2VkCj4gPiA+ID4gPiA+IHBlcmZvcm1hbmNlIGp1c3QgdG8gc3F1ZWV6ZSBpbnRv
IERNQUJVRi4uCj4gPiA+ID4KPiA+ID4gPiBUaGFua3MgSmFzb24gZm9yIHRoZSBjbGFyaWZpY2F0
aW9uLCBidXQgSSBob25lc3RseSBwcmVmZXIgdG8gdXNlCj4gPiA+ID4gRE1BLUJVRiBhdCB0aGUg
bW9tZW50Lgo+ID4gPiA+IEl0IGdpdmVzIHVzIGp1c3Qgd2hhdCB3ZSBuZWVkIChldmVuIG1vcmUg
dGhhbiB3aGF0IHdlIG5lZWQgYXMgeW91Cj4gPiA+ID4gcG9pbnRlZCBvdXQpLCBpdCBpcyAqYWxy
ZWFkeSogaW50ZWdyYXRlZCBhbmQgdGVzdGVkIGluIHRoZSBSRE1BCj4gPiA+ID4gc3Vic3lzdGVt
LCBhbmQgSSdtIGZlZWxpbmcgY29tZm9ydGFibGUgdXNpbmcgaXQgYXMgSSdtIHNvbWV3aGF0Cj4g
PiA+ID4gZmFtaWxpYXIgd2l0aCBpdCBmcm9tIG15IEFNRCBkYXlzLgo+ID4gPgo+ID4gPiBZb3Ug
c3RpbGwgaGF2ZSB0aGUgaXNzdWUgdGhhdCB0aGlzIHBhdGNoIGlzIGRvaW5nIGFsbCBvZiB0aGlz
IFAyUAo+ID4gPiBzdHVmZiB3cm9uZyAtIGZvbGxvd2luZyB0aGUgYWxyZWFkeSBOQUsnZCBBTUQg
YXBwcm9hY2guCj4gPgo+ID4gQ291bGQgeW91IHBsZWFzZSBwb2ludCBtZSBleGFjdGx5IHRvIHRo
ZSBsaW5lcyBvZiBjb2RlIHRoYXQgYXJlIHdyb25nCj4gPiBpbiB5b3VyIG9waW5pb24gPwo+Cj4g
MSkgU2V0dGluZyBzZ19wYWdlIHRvIE5VTEwKPiAyKSAnbWFwcGluZycgcGFnZXMgZm9yIFAyUCBE
TUEgd2l0aG91dCBnb2luZyB0aHJvdWdoIHRoZSBpb21tdQo+IDMpIEFsbG93aW5nIFAyUCBETUEg
d2l0aG91dCB1c2luZyB0aGUgcDJwIGRtYSBBUEkgdG8gdmFsaWRhdGUgdGhhdCBpdAo+ICAgIGNh
biB3b3JrIGF0IGFsbCBpbiB0aGUgZmlyc3QgcGxhY2UuCj4KPiBBbGwgb2YgdGhlc2UgcmVzdWx0
IGluIGZ1bmN0aW9uYWwgYnVncyBpbiBjZXJ0YWluIHN5c3RlbQo+IGNvbmZpZ3VyYXRpb25zLgo+
Cj4gSmFzb24KCkhpIEphc29uLApUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4KUmVnYXJkaW5nIHBv
aW50IDEsIHdoeSBpcyB0aGF0IGEgcHJvYmxlbSBpZiB3ZSBkaXNhYmxlIHRoZSBvcHRpb24gdG8K
bW1hcCB0aGUgZG1hLWJ1ZiBmcm9tIHVzZXItc3BhY2UgPyBXZSBkb24ndCB3YW50IHRvIHN1cHBv
cnQgQ1BVCmZhbGxiYWNrL0RpcmVjdCBJTy4KSW4gYWRkaXRpb24sIEkgZGlkbid0IHNlZSBhbnkg
cHJvYmxlbSB3aXRoIHNnX3BhZ2UgYmVpbmcgTlVMTCBpbiB0aGUKUkRNQSBwMnAgZG1hLWJ1ZiBj
b2RlLiBEaWQgSSBtaXNzIHNvbWV0aGluZyBoZXJlID8KClJlZ2FyZGluZyBwb2ludHMgMiAmIDMs
IEkgd2FudCB0byBleGFtaW5lIHRoZW0gbW9yZSBjbG9zZWx5IGluIGEgS1ZNCnZpcnR1YWwgbWFj
aGluZSBlbnZpcm9ubWVudCB3aXRoIElPTU1VIGVuYWJsZWQuCkkgd2lsbCB0YWtlIHR3byBHQVVE
SSBkZXZpY2VzIGFuZCB1c2Ugb25lIGFzIGFuIGV4cG9ydGVyIGFuZCBvbmUgYXMgYW4KaW1wb3J0
ZXIuIEkgd2FudCB0byBzZWUgdGhhdCB0aGUgc29sdXRpb24gd29ya3MgZW5kLXRvLWVuZCwgd2l0
aCByZWFsCmRldmljZSBETUEgZnJvbSBpbXBvcnRlciB0byBleHBvcnRlci4KSSBmZWFyIHRoYXQg
dGhlIGR1bW15IGltcG9ydGVyIEkgd3JvdGUgaXMgYnlwYXNzaW5nIHRoZXNlIHR3byBpc3N1ZXMK
eW91IGJyb3VnaHQgdXAuCgpTbyB0aGFua3MgYWdhaW4gYW5kIEknbGwgZ2V0IGJhY2sgYW5kIHVw
ZGF0ZSBvbmNlIEkndmUgZmluaXNoZWQgdGVzdGluZyBpdC4KCk9kZWQKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
