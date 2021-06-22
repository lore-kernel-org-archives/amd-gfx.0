Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8E7C48BE5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 13:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88CD26113E
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 13:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CD26113E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A9816E4F1;
	Tue, 22 Jun 2021 13:12:51 +0000 (UTC)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABFB66E0F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 12:01:44 +0000 (UTC)
Received: by mail-qk1-x729.google.com with SMTP id i68so38746598qke.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 05:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=uZXjrCktHYqiHY7Zuave3Zqe+nWlABu14O38dLKiRSc=;
 b=V1vGTztZADrEdhzlzySX29OAyznJd+LoMCj0Tl5HgSKC/gYfSvRa4RbGq1dowEhGfV
 daLDhPvM9+xafGLmtfuTCbex8YEiqsKJyrpDW4po9e16l0EgzUkVl44Hmyz39LGoO7xT
 TzLfvUBU/DW8f9Bi5bQpi35/7V2g6v30a9D8yfcA8rTZQB+vxYyM9vAI2U0vDLGGfIJy
 vutkFVFlx3zvB/LwkqKxO1Zhegmmb3Lh6V0Sj8MNmRXtTiRqKmKokko1doEKvfc01llt
 m1k5v66LhFEesVNI9Fs78siXiJEJKb+BhvYsnd/58x+uaR7+OOZwrnkeKi2AGgaPMM8m
 J+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=uZXjrCktHYqiHY7Zuave3Zqe+nWlABu14O38dLKiRSc=;
 b=TucmNucYDVMekkU2KgAERdWe5F3rA9SofUi7GzGNe2iMz4ozWz9ZGrIclH/yCTTXV5
 6rx1sJzh397rxZe26fdgB8K+gPPFYO67Fm+hclzzSzISeB67kCRyKhC4Mz3c8V8PINBQ
 mrSPhigjnXN63Jq9VMLur51JmfczmMSuECTTlvoi3XOhJZU/j46ZHZeCk3rjqKfdl7Fi
 dJX+Z4lFRR6yBvp0Zq/LlUsvsYq2jy5AmHTL3LQClSDRcIQo3CloWPdMwLoCBhUeEmHF
 IZC7FQGAUvD9jMAqPvovwNZifRVyXSXSuv4V96dNhlsMLn0SSarwDZlVxutdhkekkLuK
 1cYg==
X-Gm-Message-State: AOAM531i2VYm8jpKUrTBDyr4U6Q8QjV0neo2lleB4vfg8WfK8nUAVTqN
 r1S80MtQFKP4Ft5PUk9gWBEvdg==
X-Google-Smtp-Source: ABdhPJya7BBhAOKrUhmySN3jYp1EpbKfOqKBSj+U+j//RgFUf85U7EK52a+yYa92TMoPjVXQfaSu4g==
X-Received: by 2002:a37:496:: with SMTP id 144mr3716033qke.456.1624363303727; 
 Tue, 22 Jun 2021 05:01:43 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [47.55.113.94])
 by smtp.gmail.com with ESMTPSA id d23sm1485085qto.74.2021.06.22.05.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jun 2021 05:01:43 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lvf66-00A9JB-Im; Tue, 22 Jun 2021 09:01:42 -0300
Date: Tue, 22 Jun 2021 09:01:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Oded Gabbay <oded.gabbay@gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH v3 1/2] habanalabs: define uAPI to export
 FD for DMA-BUF
Message-ID: <20210622120142.GL1096940@ziepe.ca>
References: <CAKMK7uFOfoxbD2Z5mb-qHFnUe5rObGKQ6Ygh--HSH9M=9bziGg@mail.gmail.com>
 <YNCN0ulL6DQiRJaB@kroah.com> <20210621141217.GE1096940@ziepe.ca>
 <CAFCwf10KvCh0zfHEHqYR-Na6KJh4j+9i-6+==QaMdHHpLH1yEA@mail.gmail.com>
 <20210621175511.GI1096940@ziepe.ca>
 <CAKMK7uEO1_B59DtM7N2g7kkH7pYtLM_WAkn+0f3FU3ps=XEjZQ@mail.gmail.com>
 <CAFCwf11jOnewkbLuxUESswCJpyo7C0ovZj80UrnwUOZkPv2JYQ@mail.gmail.com>
 <20210621232912.GK1096940@ziepe.ca>
 <d358c740-fd3a-9ecd-7001-676e2cb44ec9@gmail.com>
 <CAFCwf11h_Nj_GEdCdeTzO5jgr-Y9em+W-v_pYUfz64i5Ac25yg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFCwf11h_Nj_GEdCdeTzO5jgr-Y9em+W-v_pYUfz64i5Ac25yg@mail.gmail.com>
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

T24gVHVlLCBKdW4gMjIsIDIwMjEgYXQgMTE6NDI6MjdBTSArMDMwMCwgT2RlZCBHYWJiYXkgd3Jv
dGU6Cj4gT24gVHVlLCBKdW4gMjIsIDIwMjEgYXQgOTozNyBBTSBDaHJpc3RpYW4gS8O2bmlnCj4g
PGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiB3cm90ZToKPiA+Cj4gPiBBbSAyMi4w
Ni4yMSB1bSAwMToyOSBzY2hyaWViIEphc29uIEd1bnRob3JwZToKPiA+ID4gT24gTW9uLCBKdW4g
MjEsIDIwMjEgYXQgMTA6MjQ6MTZQTSArMDMwMCwgT2RlZCBHYWJiYXkgd3JvdGU6Cj4gPiA+Cj4g
PiA+PiBBbm90aGVyIHRoaW5nIEkgd2FudCB0byBlbXBoYXNpemUgaXMgdGhhdCB3ZSBhcmUgZG9p
bmcgcDJwIG9ubHkKPiA+ID4+IHRocm91Z2ggdGhlIGV4cG9ydC9pbXBvcnQgb2YgdGhlIEZELiBX
ZSBkbyAqbm90KiBhbGxvdyB0aGUgdXNlciB0bwo+ID4gPj4gbW1hcCB0aGUgZG1hLWJ1ZiBhcyB3
ZSBkbyBub3Qgc3VwcG9ydCBkaXJlY3QgSU8uIFNvIHRoZXJlIGlzIG5vIGFjY2Vzcwo+ID4gPj4g
dG8gdGhlc2UgcGFnZXMgdGhyb3VnaCB0aGUgdXNlcnNwYWNlLgo+ID4gPiBBcmd1YWJseSBtbWFw
aW5nIHRoZSBtZW1vcnkgaXMgYSBiZXR0ZXIgY2hvaWNlLCBhbmQgaXMgdGhlIGRpcmVjdGlvbgo+
ID4gPiB0aGF0IExvZ2FuJ3Mgc2VyaWVzIGdvZXMgaW4uIEhlcmUgdGhlIHVzZSBvZiBETUFCVUYg
d2FzIHNwZWNpZmljYWxseQo+ID4gPiBkZXNpZ25lZCB0byBhbGxvdyBoaXRsZXNzIHJldm9rYXRp
b24gb2YgdGhlIG1lbW9yeSwgd2hpY2ggdGhpcyBpc24ndAo+ID4gPiBldmVuIHVzaW5nLgo+ID4K
PiA+IFRoZSBtYWpvciBwcm9ibGVtIHdpdGggdGhpcyBhcHByb2FjaCBpcyB0aGF0IERNQS1idWYg
aXMgYWxzbyB1c2VkIGZvcgo+ID4gbWVtb3J5IHdoaWNoIGlzbid0IENQVSBhY2Nlc3NpYmxlLgoK
VGhhdCBpc24ndCBhbiBpc3N1ZSBoZXJlIGJlY2F1c2UgdGhlIG1lbW9yeSBpcyBvbmx5IGludGVu
ZGVkIHRvIGJlCnVzZWQgd2l0aCBQMlAgdHJhbnNmZXJzIHNvIGl0IG11c3QgYmUgQ1BVIGFjY2Vz
c2libGUuCgo+ID4gVGhhdCB3YXMgb25lIG9mIHRoZSByZWFzb25zIHdlIGRpZG4ndCBldmVuIGNv
bnNpZGVyZWQgdXNpbmcgdGhlIG1hcHBpbmcKPiA+IG1lbW9yeSBhcHByb2FjaCBmb3IgR1BVcy4K
CldlbGwsIG5vdyB3ZSBoYXZlIERFVklDRV9QUklWQVRFIG1lbW9yeSB0aGF0IGNhbiBtZWV0IHRo
aXMgbmVlZAp0b28uLiBKdXN0IG5vYm9keSBoYXMgd2lyZWQgaXQgdXAgdG8gaG1tX3JhbmdlX2Zh
dWx0KCkKCj4gPiA+IFNvIHlvdSBhcmUgdGFraW5nIHRoZSBoaXQgb2YgdmVyeSBsaW1pdGVkIGhh
cmR3YXJlIHN1cHBvcnQgYW5kIHJlZHVjZWQKPiA+ID4gcGVyZm9ybWFuY2UganVzdCB0byBzcXVl
ZXplIGludG8gRE1BQlVGLi4KPiAKPiBUaGFua3MgSmFzb24gZm9yIHRoZSBjbGFyaWZpY2F0aW9u
LCBidXQgSSBob25lc3RseSBwcmVmZXIgdG8gdXNlCj4gRE1BLUJVRiBhdCB0aGUgbW9tZW50Lgo+
IEl0IGdpdmVzIHVzIGp1c3Qgd2hhdCB3ZSBuZWVkIChldmVuIG1vcmUgdGhhbiB3aGF0IHdlIG5l
ZWQgYXMgeW91Cj4gcG9pbnRlZCBvdXQpLCBpdCBpcyAqYWxyZWFkeSogaW50ZWdyYXRlZCBhbmQg
dGVzdGVkIGluIHRoZSBSRE1BCj4gc3Vic3lzdGVtLCBhbmQgSSdtIGZlZWxpbmcgY29tZm9ydGFi
bGUgdXNpbmcgaXQgYXMgSSdtIHNvbWV3aGF0Cj4gZmFtaWxpYXIgd2l0aCBpdCBmcm9tIG15IEFN
RCBkYXlzLgoKWW91IHN0aWxsIGhhdmUgdGhlIGlzc3VlIHRoYXQgdGhpcyBwYXRjaCBpcyBkb2lu
ZyBhbGwgb2YgdGhpcyBQMlAKc3R1ZmYgd3JvbmcgLSBmb2xsb3dpbmcgdGhlIGFscmVhZHkgTkFL
J2QgQU1EIGFwcHJvYWNoLgoKPiBJJ2xsIGdvIGFuZCByZWFkIExvZ2FuJ3MgcGF0Y2gtc2V0IHRv
IHNlZSBpZiB0aGF0IHdpbGwgd29yayBmb3IgdXMgaW4KPiB0aGUgZnV0dXJlLiBQbGVhc2UgcmVt
ZW1iZXIsIGFzIERhbmllbCBzYWlkLCB3ZSBkb24ndCBoYXZlIHN0cnVjdCBwYWdlCj4gYmFja2lu
ZyBvdXIgZGV2aWNlIG1lbW9yeSwgc28gaWYgdGhhdCBpcyBhIHJlcXVpcmVtZW50IHRvIGNvbm5l
Y3QgdG8KPiBMb2dhbidzIHdvcmssIHRoZW4gSSBkb24ndCB0aGluayB3ZSB3aWxsIHdhbnQgdG8g
ZG8gaXQgYXQgdGhpcyBwb2ludC4KCkl0IGlzIHRyaXZpYWwgdG8gZ2V0IHRoZSBzdHJ1Y3QgcGFn
ZSBmb3IgYSBQQ0kgQkFSLgoKSmFzb24KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
