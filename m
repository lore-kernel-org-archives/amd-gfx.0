Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18B5C2B9F4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 15:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7168F6100A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 15:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7168F6100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 397A56E5A9;
	Tue, 22 Jun 2021 15:31:34 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E956D6E5A9;
 Tue, 22 Jun 2021 15:31:32 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id w1so10967508oie.13;
 Tue, 22 Jun 2021 08:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3ACobuG9GBL6iTgJMQGUeQ4NnxCVUdn2UEz4s51ScZk=;
 b=FbRKl08RV+5aNUCIy+bm9R79y0vvn1Fqntx11lMKc7uBstykFXlpjoeTaLfrm6HFII
 +HEgrFz1c8I98k1PfPI2oRB/vJPXDmZ7gYDvk98AWo4x8o7v0B2KGaLjrV+spIPFeNoQ
 +dZfs7yBimI8raW3JRyWsffkiQa2vHSo1DFmxWvweSeHp1PLh8ThPMpJQRWXeK66Evlo
 pDd+cX8OKOIU4tq3oOJn8fvNkOqv8BF2KExwwBZXTVAi9/BNVYgDv1Etlgr4Jnfm2zDG
 U15DMNfGUTB+tKLKilihttsdLp7AKs76NKs/jFR6oW+8c3b50Hh6Ou4jaazsw8Vz58YB
 FpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3ACobuG9GBL6iTgJMQGUeQ4NnxCVUdn2UEz4s51ScZk=;
 b=ilk+RccwPCeBv1HD23hxn25tKRoSxqcguOetRuVgF7tG0OoWl/ihy3ED5LJixV0MDl
 fCFybyu1H/Wv0Pwzf8rjf8vb8rb86VRBZhXQkXArQGnGcj198QsOwF+8W0qK58H6OF59
 IbX3VLgFtly7PDsyCwMsU0QtXK0A7cH4BMXzrubZNmxcdd8WLmU5rVYMRYEl23A1qAZ2
 1yIpOJ0fRbn6Tj7I5tYgzvVfN3GbQPIoTzZXdFMmgZVKtJZCGPNhqvPwR37X4tqW4X3z
 wQA0LUCGy1dB/y0xveZ0Ca3YAPCZImqqlvkNCTLvIBVUJWvUmMWtNwlQGgntT5yHvZ0P
 vlJg==
X-Gm-Message-State: AOAM532hpW+ciuFAFDkN2MY7LrPl9m6k8rz20LL6K8llrIJGa7CvXjwP
 0YLxbduasytZU082cXmbUxRU+PH1zqrvSikI6BE=
X-Google-Smtp-Source: ABdhPJxWKRZiOyy1GQQeMKz5oOkBqbf2aVaRbiEZ6YA+N5BKZTQCBdtNW4NVGB7tYtQeE5WiBYa8ZoPrLTug+PhQCMk=
X-Received: by 2002:aca:ac02:: with SMTP id v2mr3623956oie.154.1624375891987; 
 Tue, 22 Jun 2021 08:31:31 -0700 (PDT)
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
In-Reply-To: <20210622152827.GQ1096940@ziepe.ca>
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Tue, 22 Jun 2021 18:31:04 +0300
Message-ID: <CAFCwf132jue+0ZOEd+3U-NPQuVt+ry1hz6FB=oZ4g_8J4pAqpw@mail.gmail.com>
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

T24gVHVlLCBKdW4gMjIsIDIwMjEgYXQgNjoyOCBQTSBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVw
ZS5jYT4gd3JvdGU6Cj4KPiBPbiBUdWUsIEp1biAyMiwgMjAyMSBhdCAwNToyNDowOFBNICswMjAw
LCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Cj4gPiA+ID4gSSB3aWxsIHRha2UgdHdvIEdBVURJ
IGRldmljZXMgYW5kIHVzZSBvbmUgYXMgYW4gZXhwb3J0ZXIgYW5kIG9uZSBhcyBhbgo+ID4gPiA+
IGltcG9ydGVyLiBJIHdhbnQgdG8gc2VlIHRoYXQgdGhlIHNvbHV0aW9uIHdvcmtzIGVuZC10by1l
bmQsIHdpdGggcmVhbAo+ID4gPiA+IGRldmljZSBETUEgZnJvbSBpbXBvcnRlciB0byBleHBvcnRl
ci4KPiA+ID4gSSBjYW4gdGVsbCB5b3UgaXQgZG9lc24ndC4gU3R1ZmZpbmcgcGh5c2ljYWwgYWRk
cmVzc2VzIGRpcmVjdGx5IGludG8KPiA+ID4gdGhlIHNnIGxpc3QgZG9lc24ndCBpbnZvbHZlIGFu
eSBvZiB0aGUgSU9NTVUgY29kZSBzbyBhbnkgY29uZmlndXJhdGlvbgo+ID4gPiB0aGF0IHJlcXVp
cmVzIElPTU1VIHBhZ2UgdGFibGUgc2V0dXAgd2lsbCBub3Qgd29yay4KPiA+Cj4gPiBTdXJlIGl0
IGRvZXMuIFNlZSBhbWRncHVfdnJhbV9tZ3JfYWxsb2Nfc2d0Ogo+ID4KPiA+ICAgICAgICAgYW1k
Z3B1X3Jlc19maXJzdChyZXMsIG9mZnNldCwgbGVuZ3RoLCAmY3Vyc29yKTsKPiAgICAgICAgICBe
Xl5eXl5eXl5eCj4KPiBJJ20gbm90IHRhbGtpbmcgYWJvdXQgdGhlIEFNRCBkcml2ZXIsIEknbSB0
YWxraW5nIGFib3V0IHRoaXMgcGF0Y2guCj4KPiArICAgICAgICAgICAgICAgYmFyX2FkZHJlc3Mg
PSBoZGV2LT5kcmFtX3BjaV9iYXJfc3RhcnQgKwo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKHBhZ2VzW2N1cl9wYWdlXSAtIHByb3AtPmRyYW1fYmFzZV9hZGRyZXNzKTsKPiArICAg
ICAgICAgICAgICAgc2dfZG1hX2FkZHJlc3Moc2cpID0gYmFyX2FkZHJlc3M7Cj4KPiBKYXNvbgpZ
ZXMsIHlvdSBhcmUgY29ycmVjdCBvZiBjb3Vyc2UsIGJ1dCB3aGF0IHdpbGwgaGFwcGVuIEphc29u
LCBJZiBJIHdpbGwKYWRkIGEgY2FsbCB0byBkbWFfbWFwX3Jlc291cmNlKCkgbGlrZSBDaHJpc3Rp
YW4gc2FpZCA/Cldvbid0IHRoYXQgc29sdmUgdGhhdCBzcGVjaWZpYyBpc3N1ZSA/ClRoYXQncyB3
aHkgSSB3YW50IHRvIHRyeSBpdC4uLgoKT2RlZApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
