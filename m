Return-Path: <SRS0=kYY7=ZN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=FAKE_REPLY_C,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DACC432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 13:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 362D720679
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 13:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362D720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C21326EF3A;
	Thu, 21 Nov 2019 13:55:19 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2AED6E0E2;
 Thu, 21 Nov 2019 13:55:17 +0000 (UTC)
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 47EC920679;
 Thu, 21 Nov 2019 13:55:17 +0000 (UTC)
Date: Thu, 21 Nov 2019 07:55:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH v2 1/1] drm: Prefer pcie_capability_read_word()
Message-ID: <20191121135505.GA37567@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_PJ+1bPQneqQpyoTGas3Je28SkmQdkMLnBADybMMuJxnQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=default; t=1574344517;
 bh=6E0YF8yMllj8qK0e/SPC6Lbz+lUTP0OyTKxxgQareDI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=tECdPZzF8HyX9TTmeeiSmLmAIGiDqt8CoZWvW9wj9PVeU71Sq3d/ytdFURHqVq75T
 N15fg7oPvR15OANOzCtplXs4LfnKht8DXDXpiVb/mlaQWVKyJgRZhlpOaVYfbM86mG
 fsIFutGcLyCjWv35or3z/6Uexha4fojCRpm/8wcI=
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Chunming Zhou <David1.Zhou@amd.com>, Frederick Lawler <fred@fredlawl.com>,
 Dave Airlie <airlied@linux.ie>, Linux PCI <linux-pci@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191121135505.NyP4piujgeyVJmxku1cYViiA7Jiw1hShkLj1byTBTeU@z>

T24gTW9uLCBOb3YgMTgsIDIwMTkgYXQgMTI6NDI6MjVQTSAtMDUwMCwgQWxleCBEZXVjaGVyIHdy
b3RlOgo+IE9uIE1vbiwgTm92IDE4LCAyMDE5IGF0IDM6MzcgQU0gRnJlZGVyaWNrIExhd2xlciA8
ZnJlZEBmcmVkbGF3bC5jb20+IHdyb3RlOgo+ID4KPiA+IENvbW1pdCA4YzBkM2EwMmMxMzAgKCJQ
Q0k6IEFkZCBhY2Nlc3NvcnMgZm9yIFBDSSBFeHByZXNzIENhcGFiaWxpdHkiKQo+ID4gYWRkZWQg
YWNjZXNzb3JzIGZvciB0aGUgUENJIEV4cHJlc3MgQ2FwYWJpbGl0eSBzbyB0aGF0IGRyaXZlcnMg
ZGlkbid0Cj4gPiBuZWVkIHRvIGJlIGF3YXJlIG9mIGRpZmZlcmVuY2VzIGJldHdlZW4gdjEgYW5k
IHYyIG9mIHRoZSBQQ0kKPiA+IEV4cHJlc3MgQ2FwYWJpbGl0eS4KPiA+Cj4gPiBSZXBsYWNlIHBj
aV9yZWFkX2NvbmZpZ193b3JkKCkgYW5kIHBjaV93cml0ZV9jb25maWdfd29yZCgpIGNhbGxzIHdp
dGgKPiA+IHBjaWVfY2FwYWJpbGl0eV9yZWFkX3dvcmQoKSBhbmQgcGNpZV9jYXBhYmlsaXR5X3dy
aXRlX3dvcmQoKS4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBGcmVkZXJpY2sgTGF3bGVyIDxmcmVk
QGZyZWRsYXdsLmNvbT4KPiA+Cj4gPiAtLS0KPiA+IFYyCj4gPiAtIFNxdWFzaCBib3RoIGRybSBj
b21taXRzIGludG8gb25lCj4gPiAtIFJlYmFzZSBvbnRvcCBvZiBkNDZlYWMxZTY1OGIKPiA+IC0t
LQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Npay5jIHwgNjMgKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2kuYyAgfCA3
MSArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tCj4gPiAgZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9jaWsuYyAgICAgfCA3MCArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0KPiA+ICBk
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpLmMgICAgICB8IDczICsrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tCj4gCj4gQ2FuIHlvdSBzcGxpdCB0aGlzIGludG8gdHdvIHBhdGNoZXM/ICBP
bmUgZm9yIGFtZGdwdSBhbmQgb25lIGZvciByYWRlb24/CgpJIHNwbGl0IHRoaXMsIGFuZCBJIGFs
c28gd2VudCBiYWNrIGFuZCBzcGxpdCB0aGUgcmVsYXRlZCBwYXRjaGVzIHRoYXQKcHJlY2VkZWQg
dGhpcyBvbmUuICBJJ2xsIHBvc3QgdGhlIHJlc3VsdGluZyBzZXJpZXMgZm9yIHJlZmVyZW5jZS4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
