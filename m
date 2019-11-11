Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A157C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 17:52:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4450E20818
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 17:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4450E20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF1556E9A6;
	Mon, 11 Nov 2019 17:52:19 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 520A86E9A6;
 Mon, 11 Nov 2019 17:52:18 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id s5so4532305wrw.2;
 Mon, 11 Nov 2019 09:52:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BJ9e9ly91nRhZjwW0TVLzAK+FXnMh6Th9fLasAfqWj8=;
 b=a8e5D6XyZW/NnqJGwQRsyt8pV2nQvpNIphyZKeRvAOiMC84rf4aD2ONryTPVRliFc3
 IkwVf4rw3rQJw7X55eAg5l94VvCSCVALEqQghvSp6roYGbO265Ezwp+0nxNyFerdnlN8
 EezXVyLGy6uWq/AfaWIJeGG6kqqMB4kh+2Bb4Xr0wYHC376kESt08F7l4w3GFw2peKnD
 M2XpNNz0oclNWSONuNpIdhKD23XIILks4lEOXAz83n3BSFpwajxdQS/vlFdw6oTu8KdU
 sjDPKVi6ZlR8gA/1cPABEp176nFP9dhiAiHFgVYpU1wBpvFiIYfs4SsLWTQVXa5Bx/wl
 WMEQ==
X-Gm-Message-State: APjAAAX8125QyNDA4zUyXbEURsy7ID1nQP4uSat3qFRnNFna9+e24gjt
 yC/3Sph5ByPhz70OdOuEGRWWlafs1duk2dw9SuU=
X-Google-Smtp-Source: APXvYqyKXIZM3kkAjgJ//6wJoe76MUqSTPK7e4h/ozx4tc+Qc/6YfCHZA0i3hVBa/gDTUNL8QrxwkEmyNawVQUUoc2w=
X-Received: by 2002:adf:9d87:: with SMTP id p7mr21416996wre.11.1573494736886; 
 Mon, 11 Nov 2019 09:52:16 -0800 (PST)
MIME-Version: 1.0
References: <1573443956-76489-1-git-send-email-zhengbin13@huawei.com>
 <MN2PR12MB3344DA10AF60C2C0E8D9FD0EE4740@MN2PR12MB3344.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3344DA10AF60C2C0E8D9FD0EE4740@MN2PR12MB3344.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 Nov 2019 12:52:03 -0500
Message-ID:
 <CADnq5_Nq2SBJRCrrfy-OQBk=kSokq+KY+YdaTZ3WM5BuiM3Gxw@mail.gmail.com>
Subject: Re: [PATCH 0/2] remove some set but not used variables in hwmgr
To: "Quan, Evan" <Evan.Quan@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=BJ9e9ly91nRhZjwW0TVLzAK+FXnMh6Th9fLasAfqWj8=;
 b=opqV3fiAXC6ueiXyXERXjvdiQcb8D5x7gI3MdKPy72cyjzmdwOp6FSiHo5Vpn3PMUl
 SvN4nIJgdK75Ptw6A+9T3sbYwwpyJICbJeKvqaFebvwbH83erIROsTrpEj9TjWuoczET
 Hs3P+g+ZVawe9QiaeAMB3x3Qwj7PsS4lnO9LcoMkfP1V8QVpTdSsPJBOE3W27NDU59bs
 mNxbk5H+bMkLghOPa4P2P3ivZhw0wgvl59FMeJSnj63ra3HvFDWcO/iAYbZ4AGfcbVVu
 TSWGbTUBRUspx6ERBT4Dq1+/dBXZc3S7rGJ42tkLJvbGgfKcTfTJBNiMzJ59oq/hRT6s
 hK+A==
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
Cc: "Zhou, David\(ChunMing\)" <David1.Zhou@amd.com>,
 "airlied@linux.ie" <airlied@linux.ie>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 zhengbin <zhengbin13@huawei.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "rex.zhu@amd.com" <rex.zhu@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111175203.BMtmzJxLenv3B5llSTPnhF-FVduThWCgh86igU0GkhY@z>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFN1biwgTm92IDEwLCAyMDE5IGF0IDExOjA0IFBN
IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPiB3cm90ZToKPgo+IFNlcmllcyBpcyByZXZp
ZXdlZC1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KPgo+ID4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0KPiA+IEZyb206IHpoZW5nYmluIDx6aGVuZ2JpbjEzQGh1YXdlaS5jb20+
Cj4gPiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDExLCAyMDE5IDExOjQ2IEFNCj4gPiBUbzogcmV4
LnpodUBhbWQuY29tOyBRdWFuLCBFdmFuIDxFdmFuLlF1YW5AYW1kLmNvbT47IERldWNoZXIsCj4g
PiBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlh
bgo+ID4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IFpob3UsIERhdmlkKENodW5NaW5nKQo+
ID4gPERhdmlkMS5aaG91QGFtZC5jb20+OyBhaXJsaWVkQGxpbnV4LmllOyBkYW5pZWxAZmZ3bGwu
Y2g7IGFtZC0KPiA+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKPiA+IENjOiB6aGVuZ2JpbjEzQGh1YXdlaS5jb20KPiA+IFN1YmplY3Q6
IFtQQVRDSCAwLzJdIHJlbW92ZSBzb21lIHNldCBidXQgbm90IHVzZWQgdmFyaWFibGVzIGluIGh3
bWdyCj4gPgo+ID4gemhlbmdiaW4gKDIpOgo+ID4gICBkcm0vYW1kL3Bvd2VycGxheTogcmVtb3Zl
IHNldCBidXQgbm90IHVzZWQgdmFyaWFibGUKPiA+ICAgICAndmJpb3NfdmVyc2lvbicsJ2RhdGEn
Cj4gPiAgIGRybS9hbWQvcG93ZXJwbGF5OiByZW1vdmUgc2V0IGJ1dCBub3QgdXNlZCB2YXJpYWJs
ZSAnZGF0YScKPiA+Cj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211
N19od21nci5jICAgfCA0IC0tLS0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9o
d21nci92ZWdhMTBfaHdtZ3IuYyB8IDIgLS0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDYgZGVsZXRp
b25zKC0pCj4gPgo+ID4gLS0KPiA+IDIuNy40Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4
