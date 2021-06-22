Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE069C2B9F4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 17:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B7660C41
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 17:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B7660C41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A9B06E802;
	Tue, 22 Jun 2021 17:14:00 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFB0E6E0DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 15:28:29 +0000 (UTC)
Received: by mail-qt1-x82d.google.com with SMTP id g12so16318083qtb.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 08:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=gSIT2aB7rHsSORmJBVTerFLvPUzJvuTh9nq+ipo1OW4=;
 b=jMJSjWzPfPzqnKB8B3d0txI+f1QCXRwofrHYktBL6Dp/RhK8mDhbKSZcIAeOroGN79
 9QKZyuK/IHnSXDzJVZS3X6lKP7w6E8KyRCjjniSQVc0jCI0AkxFDLwDCLmcInmPgiCnf
 jgWG0hhVMC1nVN8HteDjeVRfh514OJrhlEcH2R925fh0DHPJTQOuXuBlI4DUwVhGyPRl
 DthIYUE4NB1fnKp7n1suCV8ABft4OFetd4l8JY9SJSPUN6ozC3ygwCBUw+HE0mNeNlWt
 b8N9Y1O7r/s/b3RUVZtkPQ9u0U0mfuUS0aqx+/yNM9XPrMJnox3nrIaQn6+gPefKB6rN
 j1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=gSIT2aB7rHsSORmJBVTerFLvPUzJvuTh9nq+ipo1OW4=;
 b=hpbLm6Qu/xLNdyPMKmo7qPVDKxDZR++YpjaQRYOw0LCKA5p8ydV7NxL4SOGLwDRXE/
 Yb8huf4FaYPcbLso4PQYXMXfExZ3Xya5dl+j+JQJexJzWvsQG3zJrUu8NQFWW5T7r0gE
 k7jA8sJZ+mblq4+Y6ed0cc8VlLvLlZyLzVQs44RaaMj92PTaosQOE28zxjZN1TdeipJz
 jizWkDIp8OOuIL9x+ufAv4lC1pTBuPcnp7Z2XzknHQs6d5+DZ1sThPl1GO5ZYKY0rq87
 RqNRLVZu4PVgc0aHr24f+Hz2nvDiR8dplhkMgiIIkUhBUim0YxgLsFxy3o4BTN8Zq7KX
 En1A==
X-Gm-Message-State: AOAM532fn9BAGgvYM1WYFevG5EsrwRV+ZiDkQUZSdtcVBhFbScT0qhAB
 QHne03UUFhtrSGMrpKih5WUmUQ==
X-Google-Smtp-Source: ABdhPJwvGxEjOXxCirTSFPJmIHH9j6VoDmK24La5Ry2f+RuAq8/L4z8p3qLfsHgu2FnFM9CaTb3hKA==
X-Received: by 2002:ac8:5ad5:: with SMTP id d21mr3797369qtd.166.1624375708968; 
 Tue, 22 Jun 2021 08:28:28 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [47.55.113.94])
 by smtp.gmail.com with ESMTPSA id f19sm13636743qkg.70.2021.06.22.08.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jun 2021 08:28:28 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lviKC-00ADKO-08; Tue, 22 Jun 2021 12:28:28 -0300
Date: Tue, 22 Jun 2021 12:28:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [Linaro-mm-sig] [PATCH v3 1/2] habanalabs: define uAPI to export
 FD for DMA-BUF
Message-ID: <20210622152827.GQ1096940@ziepe.ca>
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
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4a37216d-7c4c-081e-3325-82466f30b6eb@amd.com>
X-Mailman-Approved-At: Tue, 22 Jun 2021 17:13:59 +0000
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
Cc: Oded Gabbay <oded.gabbay@gmail.com>,
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

T24gVHVlLCBKdW4gMjIsIDIwMjEgYXQgMDU6MjQ6MDhQTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKCj4gPiA+IEkgd2lsbCB0YWtlIHR3byBHQVVESSBkZXZpY2VzIGFuZCB1c2Ugb25l
IGFzIGFuIGV4cG9ydGVyIGFuZCBvbmUgYXMgYW4KPiA+ID4gaW1wb3J0ZXIuIEkgd2FudCB0byBz
ZWUgdGhhdCB0aGUgc29sdXRpb24gd29ya3MgZW5kLXRvLWVuZCwgd2l0aCByZWFsCj4gPiA+IGRl
dmljZSBETUEgZnJvbSBpbXBvcnRlciB0byBleHBvcnRlci4KPiA+IEkgY2FuIHRlbGwgeW91IGl0
IGRvZXNuJ3QuIFN0dWZmaW5nIHBoeXNpY2FsIGFkZHJlc3NlcyBkaXJlY3RseSBpbnRvCj4gPiB0
aGUgc2cgbGlzdCBkb2Vzbid0IGludm9sdmUgYW55IG9mIHRoZSBJT01NVSBjb2RlIHNvIGFueSBj
b25maWd1cmF0aW9uCj4gPiB0aGF0IHJlcXVpcmVzIElPTU1VIHBhZ2UgdGFibGUgc2V0dXAgd2ls
bCBub3Qgd29yay4KPiAKPiBTdXJlIGl0IGRvZXMuIFNlZSBhbWRncHVfdnJhbV9tZ3JfYWxsb2Nf
c2d0Ogo+IAo+ICAgICAgICAgYW1kZ3B1X3Jlc19maXJzdChyZXMsIG9mZnNldCwgbGVuZ3RoLCAm
Y3Vyc29yKTsKICAgICAgICAgXl5eXl5eXl5eXgoKSSdtIG5vdCB0YWxraW5nIGFib3V0IHRoZSBB
TUQgZHJpdmVyLCBJJ20gdGFsa2luZyBhYm91dCB0aGlzIHBhdGNoLgoKKwkJYmFyX2FkZHJlc3Mg
PSBoZGV2LT5kcmFtX3BjaV9iYXJfc3RhcnQgKworCQkJCShwYWdlc1tjdXJfcGFnZV0gLSBwcm9w
LT5kcmFtX2Jhc2VfYWRkcmVzcyk7CisJCXNnX2RtYV9hZGRyZXNzKHNnKSA9IGJhcl9hZGRyZXNz
OwoKSmFzb24KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
