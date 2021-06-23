Return-Path: <SRS0=KKXi=LR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A50C4743C
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 08:57:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF8976120D
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 08:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8976120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 724446E402;
	Wed, 23 Jun 2021 08:57:39 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2E906E402;
 Wed, 23 Jun 2021 08:57:38 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id m18so1738602wrv.2;
 Wed, 23 Jun 2021 01:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=ZDxBkMAz03P8f+aMbelwxHltUcPmaJQiAy762htmSOw=;
 b=gKPDCYXud3/Ny6GugpuD8PxV3Af5S6G9njiquRSYdnYuIyUPc5d4pP41bLP8IncC+b
 q0G+HGYLvTHmPkI8X4/wi97s/dtCDFf49XbHlQi3Y8XHCnuItPph3HC8KyweTZ73ISLS
 6U70DcSwpJUikE7mrhXsZVWSIjwXeGdbOwnc7Gqoc2QWpTyRWMdjNrQM48WmgKKpatH8
 rBMNFlxNEU7ReMuigAM0E6MsLA5W/Uz06GOd1A8ft0Tyi8xffgc2Iz9N5ULy5mLXvBvT
 cN+ZLDZs6oxy0wovyiU+HR9yKzaIKdGhpmY80/A/dYDf/wFVdMrbAX+Lqv+PElUMYYoR
 h9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ZDxBkMAz03P8f+aMbelwxHltUcPmaJQiAy762htmSOw=;
 b=BgL0CD1kYEdCYmMh0BqzrkWqegoAKObQlOEwHtTG+0pa8YtSn2wokf6XJrGyi4+w06
 zh/qSZqnhQK7J2rN+Dv5VeEqzKP11TBhLO0ho542sw90pBnmVKgZi3Tl+O6D0PNYBY+Z
 hnzALBxEi9OFhD9PfNowbVB+2VzZYfs77tUUfBTW4fwbTblYjEehEoyolXFX/lW5Rciw
 RjdhXz0mHXn3dua0WvBG3ev7HFb1/6K1wXzztSlbcstN15X/sNUke5qU9bYd/WLytn/F
 PMZcWKWDTrgaJGSflkmZM2D8/sM3/WS54cxdRmCQvtfkWV3VHq1J2xPP8MfVDk5coi6A
 42xQ==
X-Gm-Message-State: AOAM533j0YQDo8EutUMtPsdODXIVX+02d493dkFbZd3z1SG7r4+U375B
 jru+QEyhf65J9xm+bnmFu8w=
X-Google-Smtp-Source: ABdhPJyO8408BeqPk1gg6ZvXlAibkwfvIR/i0k8QSdflfw+3uxptNWJCkjKtYAdDMMiuTI3v4KYHDw==
X-Received: by 2002:adf:8b4d:: with SMTP id v13mr9929193wra.223.1624438657460; 
 Wed, 23 Jun 2021 01:57:37 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:69e4:a619:aa86:4e9c?
 ([2a02:908:1252:fb60:69e4:a619:aa86:4e9c])
 by smtp.gmail.com with ESMTPSA id u12sm2195254wrr.40.2021.06.23.01.57.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jun 2021 01:57:36 -0700 (PDT)
Subject: Re: [Linaro-mm-sig] [PATCH v3 1/2] habanalabs: define uAPI to export
 FD for DMA-BUF
To: Jason Gunthorpe <jgg@ziepe.ca>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>
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
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d600a638-9e55-6249-b574-0986cd5cea1e@gmail.com>
Date: Wed, 23 Jun 2021 10:57:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210622160538.GT1096940@ziepe.ca>
Content-Language: en-US
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
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sleybo@amazon.com,
 Gal Pressman <galpress@amazon.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Doug Ledford <dledford@redhat.com>, Tomer Tayar <ttayar@habana.ai>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Greg KH <gregkh@linuxfoundation.org>, Alex Deucher <alexander.deucher@amd.com>,
 Leon Romanovsky <leonro@nvidia.com>, Oded Gabbay <ogabbay@kernel.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjIuMDYuMjEgdW0gMTg6MDUgc2NocmllYiBKYXNvbiBHdW50aG9ycGU6Cj4gT24gVHVlLCBK
dW4gMjIsIDIwMjEgYXQgMDU6NDg6MTBQTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToK
Pj4gQW0gMjIuMDYuMjEgdW0gMTc6NDAgc2NocmllYiBKYXNvbiBHdW50aG9ycGU6Cj4+PiBPbiBU
dWUsIEp1biAyMiwgMjAyMSBhdCAwNToyOTowMVBNICswMjAwLCBDaHJpc3RpYW4gS8O2bmlnIHdy
b3RlOgo+Pj4+IFtTTklQXQo+Pj4+IE5vIGFic29sdXRlbHkgbm90LiBOVmlkaWEgR1BVcyB3b3Jr
IGV4YWN0bHkgdGhlIHNhbWUgd2F5Lgo+Pj4+Cj4+Pj4gQW5kIHlvdSBoYXZlIHRvbnMgb2Ygc2lt
aWxhciBjYXNlcyBpbiBlbWJlZGRlZCBhbmQgU29DIHN5c3RlbXMgd2hlcmUKPj4+PiBpbnRlcm1l
ZGlhdGUgbWVtb3J5IGJldHdlZW4gZGV2aWNlcyBpc24ndCBkaXJlY3RseSBhZGRyZXNzYWJsZSB3
aXRoIHRoZSBDUFUuCj4+PiBOb25lIG9mIHRoYXQgaXMgUENJIFAyUC4KPj4+Cj4+PiBJdCBpcyBh
bGwgc29tZSBzcGVjaWFsdHkgZGlyZWN0IHRyYW5zZmVyLgo+Pj4KPj4+IFlvdSBjYW4ndCByZWFz
b25hYmx5IGNhbGwgZG1hX21hcF9yZXNvdXJjZSgpIG9uIG5vbiBDUFUgbWFwcGVkIG1lbW9yeQo+
Pj4gZm9yIGluc3RhbmNlLCB3aGF0IGFkZHJlc3Mgd291bGQgeW91IHBhc3M/Cj4+Pgo+Pj4gRG8g
bm90IGNvbmZ1c2UgIkkgYW0gZG9pbmcgdHJhbnNmZXJzIGJldHdlZW4gdHdvIEhXIGJsb2NrcyIg
d2l0aCBQQ0kKPj4+IFBlZXIgdG8gUGVlciBETUEgdHJhbnNmZXJzIC0gdGhlIGxhdHRlciBpcyBh
IHZlcnkgbmFycm93IHN1YmNhc2UuCj4+Pgo+Pj4+IE5vLCBqdXN0IHVzaW5nIHRoZSBkbWFfbWFw
X3Jlc291cmNlKCkgaW50ZXJmYWNlLgo+Pj4gSWssIGJ1dCB5ZXMgdGhhdCBkb2VzICJ3b3JrIi4g
TG9nYW4ncyBzZXJpZXMgaXMgYmV0dGVyLgo+PiBObyBpdCBpc24ndC4gSXQgbWFrZXMgZGV2aWNl
cyBkZXBlbmQgb24gYWxsb2NhdGluZyBzdHJ1Y3QgcGFnZXMgZm9yIHRoZWlyCj4+IEJBUnMgd2hp
Y2ggaXMgbm90IG5lY2Vzc2FyeSBub3IgZGVzaXJlZC4KPiBXaGljaCBkcmFtYXRpY2FsbHkgcmVk
dWNlcyB0aGUgY29zdCBvZiBlc3RhYmxpc2hpbmcgRE1BIG1hcHBpbmdzLCBhCj4gbG9vcCBvZiBk
bWFfbWFwX3Jlc291cmNlKCkgaXMgdmVyeSBleHBlbnNpdmUuCgpZZWFoLCBidXQgdGhhdCBpcyBw
ZXJmZWN0bHkgb2suIE91ciBCQVIgYWxsb2NhdGlvbnMgYXJlIGVpdGhlciBpbiBjaHVua3MgCm9m
IGF0IGxlYXN0IDJNaUIgb3Igb25seSBhIHNpbmdsZSA0S2lCIHBhZ2UuCgpPZGVkIG1pZ2h0IHJ1
biBpbnRvIG1vcmUgcGVyZm9ybWFuY2UgcHJvYmxlbXMsIGJ1dCB0aG9zZSBETUEtYnVmIAptYXBw
aW5ncyBhcmUgdXN1YWxseSBzZXQgdXAgb25seSBvbmNlLgoKPj4gSG93IGRvIHlvdSBwcmV2ZW50
IGRpcmVjdCBJL08gb24gdGhvc2UgcGFnZXMgZm9yIGV4YW1wbGU/Cj4gR1VQIGZhaWxzLgoKQXQg
bGVhc3QgdGhhdCBpcyBjYWxtaW5nLgoKPj4gQWxsb2NhdGluZyBhIHN0cnVjdCBwYWdlcyBoYXMg
dGhlaXIgdXNlIGNhc2UsIGZvciBleGFtcGxlIGZvciBleHBvc2luZyBWUkFNCj4+IGFzIG1lbW9y
eSBmb3IgSE1NLiBCdXQgdGhhdCBpcyBzb21ldGhpbmcgdmVyeSBzcGVjaWZpYyBhbmQgc2hvdWxk
IG5vdCBsaW1pdAo+PiBQQ0llIFAyUCBETUEgaW4gZ2VuZXJhbC4KPiBTdXJlLCBidXQgdGhhdCBp
cyBhbiBpZGVhbCB3ZSBhcmUgZmFyIGZyb20gb2J0YWluaW5nLCBhbmQgbm9ib2R5IHdhbnRzCj4g
dG8gd29yayBvbiBpdCBwcmVmZXJpbmcgdG8gZG8gaGFja3kgaGFja3kgbGlrZSB0aGlzLgo+Cj4g
SWYgeW91IGJlbGlldmUgaW4gdGhpcyB0aGVuIHJlbW92ZSB0aGUgc2NhdHRlciBsaXN0IGZyb20g
ZG1hYnVmLCBhZGQgYQo+IG5ldyBzZXQgb2YgZG1hX21hcCogQVBJcyB0byB3b3JrIG9uIHBoeXNp
Y2FsIGFkZHJlc3NlcyBhbmQgYWxsIHRoZQo+IG90aGVyIHN0dWZmIG5lZWRlZC4KClllYWgsIHRo
YXQncyB3aGF0IEkgdG90YWxseSBhZ3JlZSBvbi4gQW5kIEkgYWN0dWFsbHkgaG9wZWQgdGhhdCB0
aGUgbmV3IApQMlAgd29yayBmb3IgUENJZSB3b3VsZCBnbyBpbnRvIHRoYXQgZGlyZWN0aW9uLCBi
dXQgdGhhdCBkaWRuJ3QgCm1hdGVyaWFsaXplZC4KCkJ1dCBhbGxvY2F0aW5nIHN0cnVjdCBwYWdl
cyBmb3IgUENJZSBCQVJzIHdoaWNoIGFyZSBlc3NlbnRpYWxseSAKcmVnaXN0ZXJzIGFuZCBub3Qg
bWVtb3J5IGlzIG11Y2ggbW9yZSBoYWNreSB0aGFuIHRoZSBkbWFfcmVzb3VyY2VfbWFwKCkgCmFw
cHJvYWNoLgoKVG8gcmUtaXRlcmF0ZSB3aHkgSSB0aGluayB0aGF0IGhhdmluZyBzdHJ1Y3QgcGFn
ZXMgZm9yIHRob3NlIEJBUnMgaXMgYSAKYmFkIGlkZWE6IE91ciBkb29yYmVsbHMgb24gQU1EIEdQ
VXMgYXJlIHdyaXRlIGFuZCByZWFkIHBvaW50ZXJzIGZvciByaW5nIApidWZmZXJzLgoKV2hlbiB5
b3Ugd3JpdGUgdG8gdGhlIEJBUiB5b3UgZXNzZW50aWFsbHkgdGVsbCB0aGUgZmlybXdhcmUgdGhh
dCB5b3UgCmhhdmUgZWl0aGVyIGZpbGxlZCB0aGUgcmluZyBidWZmZXIgb3IgcmVhZCBhIGJ1bmNo
IG9mIGl0LiBUaGlzIGluIHR1cm4gCnRoZW4gdHJpZ2dlcnMgYW4gaW50ZXJydXB0IGluIHRoZSBo
YXJkd2FyZS9maXJtd2FyZSB3aGljaCB3YXMgZXZlbnR1YWxseSAKYXNsZWVwLgoKQnkgdXNpbmcg
UENJZSBQMlAgd2Ugd2FudCB0byBhdm9pZCB0aGUgcm91bmQgdHJpcCB0byB0aGUgQ1BVIHdoZW4g
b25lIApkZXZpY2UgaGFzIGZpbGxlZCB0aGUgcmluZyBidWZmZXIgYW5kIGFub3RoZXIgZGV2aWNl
IG11c3QgYmUgd29rZW4gdXAgdG8gCnByb2Nlc3MgaXQuCgpUaGluayBvZiBpdCBhcyBNU0ktWCBp
biByZXZlcnNlIGFuZCBhbGxvY2F0aW5nIHN0cnVjdCBwYWdlcyBmb3IgdGhvc2UgCkJBUnMganVz
dCB0byB3b3JrIGFyb3VuZCB0aGUgc2hvcnRjb21pbmdzIG9mIHRoZSBETUEgQVBJIG1ha2VzIG5v
IHNlbnNlIAphdCBhbGwgdG8gbWUuCgoKV2UgYWxzbyBkbyBoYXZlIHRoZSBWUkFNIEJBUiwgYW5k
IGZvciBITU0gd2UgZG8gYWxsb2NhdGUgc3RydWN0IHBhZ2VzIApmb3IgdGhlIGFkZHJlc3MgcmFu
Z2UgZXhwb3NlZCB0aGVyZS4gQnV0IHRoaXMgaXMgYSBkaWZmZXJlbnQgdXNlIGNhc2UuCgpSZWdh
cmRzLApDaHJpc3RpYW4uCgo+Cj4gT3RoZXJ3aXNlLCB3ZSBoYXZlIHdoYXQgd2UgaGF2ZSBhbmQg
ZHJpdmVycyBkb24ndCBnZXQgdG8gb3B0IG91dC4gVGhpcwo+IGlzIHdoeSB0aGUgc3R1ZmYgaW4g
QU1ER1BVIHdhcyBOQUsnZC4KPgo+IEphc29uCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
