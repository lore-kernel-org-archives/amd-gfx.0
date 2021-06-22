Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227FAC49EA2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 15:41:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E730E61370
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 15:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E730E61370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AAE56E5B2;
	Tue, 22 Jun 2021 15:41:12 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37F8B6E5B2;
 Tue, 22 Jun 2021 15:41:12 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id t40so24218497oiw.8;
 Tue, 22 Jun 2021 08:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Jgaz579QWdtxXB8nWqcH6rzqF6qFCj5oOGxmdOSH2CQ=;
 b=u0XMgd5ruUtJjM/nF+7PWab6GDpci7JslYc9OxFlQ6lxKqsy1oudi2TK6jNH47GZ+v
 Y57oVO6hv69UI1JFsgHef/tnt00AwLlYx+SHKFv/NWmkXVgR3t8VrITuUBLNXdnr8pqY
 dKePYkYzljnzqMLmdSCKAbrYJTyR1oHoNFWMnKDZD+es0mXMJSBf5vBmOxIc3R5RAXNJ
 T9wcJR+xYc/bd+zOFm8jt7ferXgVC+QUbdCOHFG5g7g6fdi6f5J5tz218/RJh2chgPju
 JbUy+m0qcvyjjqyqR9YEn+9lDdMnS3VoV4MTA8dRQxzeqQwH3baFPX4/pPQTiQ/e9abq
 BTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Jgaz579QWdtxXB8nWqcH6rzqF6qFCj5oOGxmdOSH2CQ=;
 b=M9N/YO2/9RvuW+guHtUddIpf8FOzTC6poagANul2tGoX0w1gk4ULzsEJu1mOB7YYd9
 8KRJnG/qJWvm7dXF88wQOFujgqaC2XV45yG+hEJg42ioPlDKOxUbuiXBixoSKOskbecb
 XQcQ7LGXq3JtVEujc4fdc1OqETLLu/CUNYpOLklaNLlPAVoNBX8Tzhpj/roDHY2McmdF
 ZD9eOG4eTzSwwXgRpmxK+r++dLCFZBgEpCH/btxEqe1ySE4vhHoymnWktLUu4+ZtitQb
 RfDLPCTxW87Uzd8yGtLVYayNs883fC1BzOPIVPIO5m4Kf6nx4mhDWZl5QpCoCxc3ri+J
 b5RA==
X-Gm-Message-State: AOAM533ZMvX2Tz0svkwJ0SXPWEl9W8FewoCgsv9qW/NKLCjWBmE/MO5R
 u4elui0Yt8XotuuCr/jSyqDGvDQ0opeooWT1qxE=
X-Google-Smtp-Source: ABdhPJz+KuMjB+Vj8SljFh6w9ERIpM1RHLusPzFhPRwCq/V4Ax+B3UFH6tJ7zE3LnkZjvcQbS/i0fDTXzllWy0LhI4Y=
X-Received: by 2002:aca:3bc3:: with SMTP id i186mr3399388oia.102.1624376471543; 
 Tue, 22 Jun 2021 08:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf11jOnewkbLuxUESswCJpyo7C0ovZj80UrnwUOZkPv2JYQ@mail.gmail.com>
 <20210621232912.GK1096940@ziepe.ca>
 <d358c740-fd3a-9ecd-7001-676e2cb44ec9@gmail.com>
 <CAFCwf11h_Nj_GEdCdeTzO5jgr-Y9em+W-v_pYUfz64i5Ac25yg@mail.gmail.com>
 <20210622120142.GL1096940@ziepe.ca>
 <CAFCwf10GmBjeJAFp0uJsMLiv-8HWAR==RqV9ZdMQz+iW9XWdTA@mail.gmail.com>
 <20210622121546.GN1096940@ziepe.ca>
 <CAFCwf13BuS+U3Pko_62hFPuvZPG26HQXuu-cxPmcADNPO22g9g@mail.gmail.com>
 <20210622151142.GA2431880@ziepe.ca>
 <4a37216d-7c4c-081e-3325-82466f30b6eb@amd.com>
 <20210622152827.GQ1096940@ziepe.ca>
 <9ff1a7ef-a5a4-dd80-6f19-304b668d82a1@amd.com>
In-Reply-To: <9ff1a7ef-a5a4-dd80-6f19-304b668d82a1@amd.com>
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Tue, 22 Jun 2021 18:40:44 +0300
Message-ID: <CAFCwf13w74qFDchEsdCAtpOvnYkzvcsU0RAdBLNGJq-e5srfHA@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH v3 1/2] habanalabs: define uAPI to export
 FD for DMA-BUF
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
 sleybo@amazon.com, Gal Pressman <galpress@amazon.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
 Tomer Tayar <ttayar@habana.ai>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Greg KH <gregkh@linuxfoundation.org>, Alex Deucher <alexander.deucher@amd.com>,
 Leon Romanovsky <leonro@nvidia.com>, Oded Gabbay <ogabbay@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBKdW4gMjIsIDIwMjEgYXQgNjozMSBQTSBDaHJpc3RpYW4gS8O2bmlnCjxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+IHdyb3RlOgo+Cj4KPgo+IEFtIDIyLjA2LjIxIHVtIDE3OjI4IHNj
aHJpZWIgSmFzb24gR3VudGhvcnBlOgo+ID4gT24gVHVlLCBKdW4gMjIsIDIwMjEgYXQgMDU6MjQ6
MDhQTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiA+Cj4gPj4+PiBJIHdpbGwgdGFr
ZSB0d28gR0FVREkgZGV2aWNlcyBhbmQgdXNlIG9uZSBhcyBhbiBleHBvcnRlciBhbmQgb25lIGFz
IGFuCj4gPj4+PiBpbXBvcnRlci4gSSB3YW50IHRvIHNlZSB0aGF0IHRoZSBzb2x1dGlvbiB3b3Jr
cyBlbmQtdG8tZW5kLCB3aXRoIHJlYWwKPiA+Pj4+IGRldmljZSBETUEgZnJvbSBpbXBvcnRlciB0
byBleHBvcnRlci4KPiA+Pj4gSSBjYW4gdGVsbCB5b3UgaXQgZG9lc24ndC4gU3R1ZmZpbmcgcGh5
c2ljYWwgYWRkcmVzc2VzIGRpcmVjdGx5IGludG8KPiA+Pj4gdGhlIHNnIGxpc3QgZG9lc24ndCBp
bnZvbHZlIGFueSBvZiB0aGUgSU9NTVUgY29kZSBzbyBhbnkgY29uZmlndXJhdGlvbgo+ID4+PiB0
aGF0IHJlcXVpcmVzIElPTU1VIHBhZ2UgdGFibGUgc2V0dXAgd2lsbCBub3Qgd29yay4KPiA+PiBT
dXJlIGl0IGRvZXMuIFNlZSBhbWRncHVfdnJhbV9tZ3JfYWxsb2Nfc2d0Ogo+ID4+Cj4gPj4gICAg
ICAgICAgYW1kZ3B1X3Jlc19maXJzdChyZXMsIG9mZnNldCwgbGVuZ3RoLCAmY3Vyc29yKTsKPiA+
ICAgICAgICAgICBeXl5eXl5eXl5eCj4gPgo+ID4gSSdtIG5vdCB0YWxraW5nIGFib3V0IHRoZSBB
TUQgZHJpdmVyLCBJJ20gdGFsa2luZyBhYm91dCB0aGlzIHBhdGNoLgo+ID4KPiA+ICsgICAgICAg
ICAgICAgYmFyX2FkZHJlc3MgPSBoZGV2LT5kcmFtX3BjaV9iYXJfc3RhcnQgKwo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKHBhZ2VzW2N1cl9wYWdlXSAtIHByb3AtPmRyYW1fYmFz
ZV9hZGRyZXNzKTsKPiA+ICsgICAgICAgICAgICAgc2dfZG1hX2FkZHJlc3Moc2cpID0gYmFyX2Fk
ZHJlc3M7Cj4KPiBZZWFoLCB0aGF0IGlzIGluZGVlZCBub3Qgd29ya2luZy4KPgo+IE9kZWQgeW91
IG5lZWQgdG8gdXNlIGRtYV9tYXBfcmVzb3VyY2UoKSBmb3IgdGhpcy4KPgo+IENocmlzdGlhbi4K
WWVzLCBvZiBjb3Vyc2UuCkJ1dCB3aWxsIGl0IGJlIGVub3VnaCA/Ckphc29uIHNhaWQgdGhhdCBz
dXBwb3J0aW5nIElPTU1VIGlzbid0IG5pY2Ugd2hlbiB3ZSBkb24ndCBoYXZlIHN0cnVjdCBwYWdl
cy4KSSBmYWlsIHRvIHVuZGVyc3RhbmQgdGhlIGNvbm5lY3Rpb24sIEkgbmVlZCB0byBkaWcgaW50
byB0aGlzLgoKT2RlZAoKPgo+Cj4KPiA+Cj4gPiBKYXNvbgo+Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
