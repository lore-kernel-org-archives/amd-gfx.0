Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039FCC43461
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 12:52:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC1521582
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 12:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxoSeMcP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC1521582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 163F26EC06;
	Thu, 17 Sep 2020 12:52:07 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0049A6EC06
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 12:52:05 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id y15so1937160wmi.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 05:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CaVLPdTsABMXd+V2/Rzna2LQi5YPUmBTxMYWtB28GWQ=;
 b=HxoSeMcPWU2Ym/hQ8cEwMmzFeL568ZNOG/FBC9Hz4YEUGY4JOG4J6oEvBHh3NQAnb6
 63HT13/OVcdg55TlSrbe8ASEWuczlIGfwoxAnuZOaDrasaLml+4WlU0FqA0dUZUT8kRO
 smhRqBtKTO8lOitv5XNCs6gDQ7r/C9tFeM+l9JbZKqMnsBmcF2cQOm6hBn2mXzYBwTon
 4XJGjYTZFwFKf4Oskfza0+g4ufWKod5IOBFfA+VuOdLNI1Z7YnG1anws8Slzh5jP2rMP
 iwTOs/5nJuQt0+/u0y5amnoPyqeDcfJEbX+B3GnI+ZHxWJ/Pd+9CQBuwVJPMc9t0YMv7
 4v/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CaVLPdTsABMXd+V2/Rzna2LQi5YPUmBTxMYWtB28GWQ=;
 b=U10matZNheMOG40sD4SE5Fo5U5bdkuz1piQNj8lEgoidoywcqjHkOVnhOg+QU7DXXR
 Yzysezc0vMiWQJxX/zqzkiIoix9Zekucj5tTmjq2JQSO6RLoR8g/Cs2oImq3OuOZpUSq
 bc/4yO+7QWYNjq6DdA7wH03KdVFakt8must5bX4oIV4ML0eByAXZHwDgeSNpZWDlaqze
 JMC4kFEs8YAXTFBbMHTM+DsHkcd3dFDRvFUELmsYzw6T1VehrP/LM2BWxUJPb71hp1Hz
 MUestkanGeTMgnamp7Ftsejkjl37kFQC2+hwSRFT9kfyTqWtXxS5k/5lXfs4dOhAL0nQ
 RwKQ==
X-Gm-Message-State: AOAM533eAnwm02jYKGC12BapDSJasD34Lx2aABThbd7ggQvkhdHaAb6J
 wMaNVcpLscEH8UeV7CDmAB83Ab+mNdhwpv8CN3omvq6m
X-Google-Smtp-Source: ABdhPJz03x0C+4SZCfX1yuyPmewYxqQlgvvOKZjJtFJTG3s/Hp6UwWBoEZtkMDSL7sSpq+UAwS5YLfKSIKnK/fbZnQE=
X-Received: by 2002:a7b:c090:: with SMTP id r16mr10017706wmh.56.1600347124598; 
 Thu, 17 Sep 2020 05:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200916193635.5169-1-qingqing.zhuo@amd.com>
 <20200916193635.5169-5-qingqing.zhuo@amd.com>
 <CADnq5_O+rFANJbv1sN8SzGfyQ_kbv7xpeaSvhOKvtOSG0ui+ZA@mail.gmail.com>
 <DM5PR12MB1884F92A66DDF75EE2C770B5FB210@DM5PR12MB1884.namprd12.prod.outlook.com>
 <CADnq5_NFc+wdWLeb+aQ3QNHW7BZOXYHjCh-jzMRYTvRWBidLxA@mail.gmail.com>
 <80b70e69-8489-5f5f-a5a9-3f91431cdcfc@gmail.com>
In-Reply-To: <80b70e69-8489-5f5f-a5a9-3f91431cdcfc@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 17 Sep 2020 08:51:53 -0400
Message-ID: <CADnq5_N+YOyFnvaeeh90hmEYTJE4b7OsJZC=dsGTYuj-QONSDg@mail.gmail.com>
Subject: Re: [PATCH 04/15] drm/amd/display: Replace msleep with udelay while
 read edid return defer.
To: Christian Koenig <christian.koenig@amd.com>
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
Cc: "Brol, Eryk" <Eryk.Brol@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Jinlong" <Jinlong.Zhang@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBTZXAgMTcsIDIwMjAgYXQgNDoyNiBBTSBDaHJpc3RpYW4gS8O2bmlnCjxja29lbmln
LmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBBbSAxNy4wOS4yMCB1bSAwMDox
OCBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiA+IE9uIFdlZCwgU2VwIDE2LCAyMDIwIGF0IDY6MTYg
UE0gWmh1bywgUWluZ3FpbmcgPFFpbmdxaW5nLlpodW9AYW1kLmNvbT4gd3JvdGU6Cj4gPj4gW0FN
RCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQo+ID4+Cj4g
Pj4gT24gV2VkLCBTZXAgMTYsIDIwMjAgYXQgMzo0MiBQTSBRaW5ncWluZyBaaHVvIDxxaW5ncWlu
Zy56aHVvQGFtZC5jb20+IHdyb3RlOgo+ID4+PiBGcm9tOiBqaW5sb25nIHpoYW5nIDxqaW5sb25n
LnpoYW5nQGFtZC5jb20+Cj4gPj4+Cj4gPj4+IFt3aHldCj4gPj4+IHdoaWxlIHJlYWQgZWRpZCBy
ZXR1cm4gZGVmZXIsIHRoZW4gaXQgZW50ZXIgdG8gbXNsZWVwLCBidXQgaXQgYWN0dWFsbHkKPiA+
Pj4gdG9vayBtb3JlIHRpbWUgZHVyaW5nIG1zbGVlcCwgdGhpcyB3aWxsIGNhdXNlIHJlbWFpbmlu
ZyBlZGlkIHJlYWQKPiA+Pj4gZmFpbC4KPiA+Pj4KPiA+Pj4gW2hvd10KPiA+Pj4gUmVwbGFjaW5n
IG1zbGVlcCB3aXRoIHVkZWxheSwgaXQgd2lsbCBub3QgdGFrZSBhbnkgZXh0cmEgdGltZSwgZWRp
ZCByZXR1cm4gcGFzcyBmaW5hbGx5Lgo+ID4+IEhvdyBsb25nIG9mIGEgZGVsYXkgYXJlIHdlIHRh
bGtpbmcgYWJvdXQgaGVyZT8gIFNvbWUgcGxhdGZvcm1zIGRvbid0IHN1cHBvcnQgbG9uZyB1ZGVs
YXlzIGFuZCBzb21lb25lIHdpbGwgc2VuZCBhIHBhdGNoIHRvIGNoYW5nZSB0aGlzIHRvIG1zbGVl
cC4KPiA+Pgo+ID4+IEFsZXgKPiA+Pgo+ID4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ID4+Cj4g
Pj4gSGkgQWxleCwKPiA+Pgo+ID4+IEl0J3MgYmV0d2VlbiAwLTVtcyBmb3IgZ2VuZXJpYyBjYXNl
cywgdGhvdWdoIHRoZXJlIGV4aXN0IHNvbWUgZG9uZ2xlIHdvcmthcm91bmQgY2FzZXMgd2hlcmUg
d2Ugd2lsbCBkbyA3MG1zLiBXb3VsZCB0aGlzIGJlIGEgY29uY2Vybj8KPiA+IEkgdGhpbmsgQVJN
IGhhcyBhIGxpbWl0IG9mIDJtcyBmb3IgdWRlbGF5Lgo+Cj4gWWVhaCwgdGhlcmUgaXMgZXZlbiBh
IGRlZmluZSBzb21ld2hlcmUgZm9yIHRoaXMuCj4KPiBJZiB5b3UgbmVlZCBhIGRlbGF5IHdoaWNo
IGlzIGxvbmdlciB0aGFuIHRoaXMgYnV0IHN0aWxsIG1vcmUgcHJlY2lzZQo+IHRoYW4gbXNsZWVw
KCkgdGhlbiB0aGVyZSBpcyB0aGUgaGlnaCBwcmVjaXNpb24gdGltZXIgc2xlZXAgYXMgYWx0ZXJu
YXRpdmUuCj4KPiBJJ3ZlIGZvcmdvdHRlbiB0aGUgZnVuY3Rpb24gbmFtZSB0byB1c2UgaGVyZSwg
YnV0IHRoZXJlIHdhcyBhIExXTgo+IGFydGljbGUgYWJvdXQgdGhpcyBhIGZldyB5ZWFycyBhZ28u
IFlvdSBqdXN0IG5lZWQgdG8gZ29vZ2xlIGEgYml0LgoKSSB0aGluayB1c2xlZXBfcmFuZ2UoKSBp
cyB3aGF0IHlvdSB3YW50LgoKQWxleAoKPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4gPgo+
ID4gQWxleAo+ID4KPiA+PiBUaGFuayB5b3UsCj4gPj4gTGlsbGlhbgo+ID4+Cj4gPj4KPiA+Pj4g
U2lnbmVkLW9mZi1ieTogamlubG9uZyB6aGFuZyA8amlubG9uZy56aGFuZ0BhbWQuY29tPgo+ID4+
PiBSZXZpZXdlZC1ieTogV2VuamluZyBMaXUgPFdlbmppbmcuTGl1QGFtZC5jb20+Cj4gPj4+IEFj
a2VkLWJ5OiBRaW5ncWluZyBaaHVvIDxxaW5ncWluZy56aHVvQGFtZC5jb20+Cj4gPj4+IC0tLQo+
ID4+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2F1eC5jIHwgMiAr
LQo+ID4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+
ID4+Pgo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
ZS9kY2VfYXV4LmMKPiA+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2Rj
ZV9hdXguYwo+ID4+PiBpbmRleCA3NDMwNDJkNTkwNWEuLmNkY2FkODI3NjVlMCAxMDA2NDQKPiA+
Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfYXV4LmMKPiA+
Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfYXV4LmMKPiA+
Pj4gQEAgLTY1Myw3ICs2NTMsNyBAQCBib29sIGRjZV9hdXhfdHJhbnNmZXJfd2l0aF9yZXRyaWVz
KHN0cnVjdCBkZGNfc2VydmljZSAqZGRjLAo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGlmICgoKnBheWxvYWQtPnJlcGx5ID09IEFVWF9UUkFOU0FDVElPTl9S
RVBMWV9BVVhfREVGRVIpIHx8Cj4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAoKnBheWxvYWQtPnJlcGx5ID09IEFVWF9UUkFOU0FDVElPTl9SRVBM
WV9JMkNfT1ZFUl9BVVhfREVGRVIpKSB7Cj4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpZiAocGF5bG9hZC0+ZGVmZXJfZGVsYXkgPiAwKQo+ID4+
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IG1zbGVlcChwYXlsb2FkLT5kZWZlcl9kZWxheSk7Cj4gPj4+ICsKPiA+Pj4gKyB1ZGVsYXkocGF5
bG9hZC0+ZGVmZXJfZGVsYXkgKiAxMDAwKTsKPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB9Cj4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IH0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gPj4+IC0t
Cj4gPj4+IDIuMTcuMQo+ID4+Pgo+ID4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwo+ID4+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+ID4+PiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ID4+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0Cj4gPj4+IHMuZnJlZWRl
c2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAx
JTdDcWkKPiA+Pj4gbmdxaW5nLnpodW8lNDBhbWQuY29tJTdDMzZjM2JlZTY4YzI4NDQ4NzY5ZmEw
OGQ4NWE4ODQ2MTklN0MzZGQ4OTYxZmU0OAo+ID4+PiA4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0Mw
JTdDMCU3QzYzNzM1ODg4ODYyNzQ5ODMwNyZhbXA7c2RhdGE9bXlucEhwaXVwCj4gPj4+IEolMkZV
Mm81Z1pOVyUyQmZ0JTJGZzJiZUZZODYlMkJ6TVJXb1RaQ2doUSUzRCZhbXA7cmVzZXJ2ZWQ9MAo+
ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiA+IGFt
ZC1nZnggbWFpbGluZyBsaXN0Cj4gPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ID4g
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cj4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
