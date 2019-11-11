Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDB3C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 17:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 282B820659
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 17:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 282B820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B71486E9B0;
	Mon, 11 Nov 2019 17:57:09 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 579096E9B0;
 Mon, 11 Nov 2019 17:57:08 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id p4so15629078wrm.8;
 Mon, 11 Nov 2019 09:57:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YkIxamEwi1mCqDf0NCP7Ms6GhCEoLZh/x9tjqm91F9A=;
 b=qwnbiWvqjoj4VBqa45hWlZlocZ6LAk/A6DFWpIb9E7gmmXBtKo+JtmIKhylSogo9lU
 B7J+Icz1Sk+Zr5GsLphDNwAA77J2pRQ1tiSo4XfTRpnlqGZNmv5fU+kdTautZdJ7E5rF
 63J5G94rwi3s9CgExJHGSg62qJj4wJ0nYBfKtgOyEB9wXJm4ssYWEOsg0R1ayI4grncp
 QZnbn2fv292TMwDy7ni+KXwkaykiX52SKLmT24x877IRpDmREQCdWgvCCJQeBq2fOVST
 9n6vin786kwLUYVYtj0HU+jr1gsu19ikg0CxkERr3FbU0zfvMgyVMouwUcT4gw4j3vEZ
 4q1w==
X-Gm-Message-State: APjAAAXgTSGhqxFeG1LqWZR//mpvBrweL4HeDAOQ4guuxYm8v1y2Ig/6
 W0cNe0obgffvKeRaqEL/gTFSjjNmkUOP+iyXmYw=
X-Google-Smtp-Source: APXvYqwlBJbBFn/XKZ5koALor0SXFIqRiMqFAsz3q5EQs8G255NefYQsq0JRAi68gVeM/ydCsOMjeaYV3WUNfyv9tR0=
X-Received: by 2002:a05:6000:18c:: with SMTP id
 p12mr21163175wrx.154.1573495026895; 
 Mon, 11 Nov 2019 09:57:06 -0800 (PST)
MIME-Version: 1.0
References: <1573445368-132319-1-git-send-email-zhengbin13@huawei.com>
In-Reply-To: <1573445368-132319-1-git-send-email-zhengbin13@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 Nov 2019 12:56:53 -0500
Message-ID:
 <CADnq5_OAt6NEoqeTsfDLB7OGrm--ywOFFtjuCtd+vcYRRq4DbA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: remove set but not used variable
 'threshold', 'state'
To: zhengbin <zhengbin13@huawei.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=YkIxamEwi1mCqDf0NCP7Ms6GhCEoLZh/x9tjqm91F9A=;
 b=ZCjjceODF3Y5dVWkaRH/sSPRWEeSnM+yZR0jVpiengUbSNR0zSIopKC1Kcv1amaNoh
 gIVBcWSs/PdSKOpxh/0uoeFnRx/5mi0EzWUVEx9HbuI4DQ+m10U8IlurZVVcS4gabn4L
 oepghyv/hif2Gj5mN54lszi2+hInVxQpZKHUe8rDqM/KLPxITcs+AUg0Cv5IcyRK+RZI
 dIPujIWfX3NJaKTDBxy788Ay3KLJdjcQ0fWe8OH5X0+3h3+vHmNXuYF+FE2vJzYTZTTb
 Jds2f8eoBSfKMUQZv240dGFYUXHQiz+GVnS8MNDI3xnJj5nnQtsYyEO74n8dNsazu3Fy
 4d/w==
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
Cc: Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Quan, Evan" <evan.quan@amd.com>,
 Rex Zhu <rex.zhu@amd.com>, Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111175653.i_14maN7DqTuqucXwpPY606tIM5Yep8HQ5FaxVL4hk8@z>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIE1vbiwgTm92IDExLCAyMDE5IGF0IDM6MDcgQU0g
emhlbmdiaW4gPHpoZW5nYmluMTNAaHVhd2VpLmNvbT4gd3JvdGU6Cj4KPiBGaXhlcyBnY2MgJy1X
dW51c2VkLWJ1dC1zZXQtdmFyaWFibGUnIHdhcm5pbmc6Cj4KPiBkcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9zbXVtZ3IvZmlqaV9zbXVtZ3IuYzogSW4gZnVuY3Rpb24gZmlqaV9wb3B1bGF0
ZV9zaW5nbGVfZ3JhcGhpY19sZXZlbDoKPiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9z
bXVtZ3IvZmlqaV9zbXVtZ3IuYzo5NDM6MTE6IHdhcm5pbmc6IHZhcmlhYmxlIHRocmVzaG9sZCBz
ZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQo+IGRyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9maWppX3NtdW1nci5jOiBJbiBmdW5jdGlvbiBmaWpp
X3BvcHVsYXRlX21lbW9yeV90aW1pbmdfcGFyYW1ldGVyczoKPiBkcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9zbXVtZ3IvZmlqaV9zbXVtZ3IuYzoxNTA0Ojg6IHdhcm5pbmc6IHZhcmlhYmxl
IHN0YXRlIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdCj4KPiBU
aGV5IGFyZSBpbnRyb2R1Y2VkIGJ5IGNvbW1pdCAyZTExMmI0YWUzYmEgKCJkcm0vYW1kL3BwOgo+
IHJlbW92ZSBmaWppX3NtYy9zbXVtZ3Igc3BsaXQuIiksIGJ1dCBuZXZlciB1c2VkLAo+IHNvIHJl
bW92ZSBpdC4KPgo+IFJlcG9ydGVkLWJ5OiBIdWxrIFJvYm90IDxodWxrY2lAaHVhd2VpLmNvbT4K
PiBTaWduZWQtb2ZmLWJ5OiB6aGVuZ2JpbiA8emhlbmdiaW4xM0BodWF3ZWkuY29tPgo+IC0tLQo+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVtZ3IvZmlqaV9zbXVtZ3IuYyB8IDcg
KystLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygt
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9m
aWppX3NtdW1nci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211bWdyL2Zpamlf
c211bWdyLmMKPiBpbmRleCBkYTAyNWIxLi4zMmViYjM4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9maWppX3NtdW1nci5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211bWdyL2Zpamlfc211bWdyLmMKPiBAQCAtOTQwLDcg
Kzk0MCw3IEBAIHN0YXRpYyBpbnQgZmlqaV9wb3B1bGF0ZV9zaW5nbGVfZ3JhcGhpY19sZXZlbChz
dHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLAo+ICB7Cj4gICAgICAgICBpbnQgcmVzdWx0Owo+ICAgICAg
ICAgLyogUFBfQ2xvY2tzIG1pbkNsb2NrczsgKi8KPiAtICAgICAgIHVpbnQzMl90IHRocmVzaG9s
ZCwgbXZkZDsKPiArICAgICAgIHVpbnQzMl90IG12ZGQ7Cj4gICAgICAgICBzdHJ1Y3Qgc211N19o
d21nciAqZGF0YSA9IChzdHJ1Y3Qgc211N19od21nciAqKShod21nci0+YmFja2VuZCk7Cj4gICAg
ICAgICBzdHJ1Y3QgcGhtX3BwdF92MV9pbmZvcm1hdGlvbiAqdGFibGVfaW5mbyA9Cj4gICAgICAg
ICAgICAgICAgICAgICAgICAgKHN0cnVjdCBwaG1fcHB0X3YxX2luZm9ybWF0aW9uICopKGh3bWdy
LT5wcHRhYmxlKTsKPiBAQCAtOTczLDggKzk3Myw2IEBAIHN0YXRpYyBpbnQgZmlqaV9wb3B1bGF0
ZV9zaW5nbGVfZ3JhcGhpY19sZXZlbChzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLAo+ICAgICAgICAg
bGV2ZWwtPlZvbHRhZ2VEb3duSHlzdCA9IDA7Cj4gICAgICAgICBsZXZlbC0+UG93ZXJUaHJvdHRs
ZSA9IDA7Cj4KPiAtICAgICAgIHRocmVzaG9sZCA9IGNsb2NrICogZGF0YS0+ZmFzdF93YXRlcm1h
cmtfdGhyZXNob2xkIC8gMTAwOwo+IC0KPiAgICAgICAgIGRhdGEtPmRpc3BsYXlfdGltaW5nLm1p
bl9jbG9ja19pbl9zciA9IGh3bWdyLT5kaXNwbGF5X2NvbmZpZy0+bWluX2NvcmVfc2V0X2Nsb2Nr
X2luX3NyOwo+Cj4gICAgICAgICBpZiAocGhtX2NhcF9lbmFibGVkKGh3bWdyLT5wbGF0Zm9ybV9k
ZXNjcmlwdG9yLnBsYXRmb3JtQ2FwcywgUEhNX1BsYXRmb3JtQ2Fwc19TY2xrRGVlcFNsZWVwKSkK
PiBAQCAtMTUwMSw3ICsxNDk5LDcgQEAgc3RhdGljIGludCBmaWppX3BvcHVsYXRlX21lbW9yeV90
aW1pbmdfcGFyYW1ldGVycyhzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLAo+ICAgICAgICAgdWludDMy
X3QgZHJhbV90aW1pbmc7Cj4gICAgICAgICB1aW50MzJfdCBkcmFtX3RpbWluZzI7Cj4gICAgICAg
ICB1aW50MzJfdCBidXJzdFRpbWU7Cj4gLSAgICAgICBVTE9ORyBzdGF0ZSwgdHJyZHMsIHRycmRs
Owo+ICsgICAgICAgVUxPTkcgdHJyZHMsIHRycmRsOwo+ICAgICAgICAgaW50IHJlc3VsdDsKPgo+
ICAgICAgICAgcmVzdWx0ID0gYXRvbWN0cmxfc2V0X2VuZ2luZV9kcmFtX3RpbWluZ3NfcnY3NzAo
aHdtZ3IsCj4gQEAgLTE1MTMsNyArMTUxMSw2IEBAIHN0YXRpYyBpbnQgZmlqaV9wb3B1bGF0ZV9t
ZW1vcnlfdGltaW5nX3BhcmFtZXRlcnMoc3RydWN0IHBwX2h3bWdyICpod21nciwKPiAgICAgICAg
IGRyYW1fdGltaW5nMiA9IGNnc19yZWFkX3JlZ2lzdGVyKGh3bWdyLT5kZXZpY2UsIG1tTUNfQVJC
X0RSQU1fVElNSU5HMik7Cj4gICAgICAgICBidXJzdFRpbWUgPSBjZ3NfcmVhZF9yZWdpc3Rlciho
d21nci0+ZGV2aWNlLCBtbU1DX0FSQl9CVVJTVF9USU1FKTsKPgo+IC0gICAgICAgc3RhdGUgPSBQ
SE1fR0VUX0ZJRUxEKGJ1cnN0VGltZSwgTUNfQVJCX0JVUlNUX1RJTUUsIFNUQVRFMCk7Cj4gICAg
ICAgICB0cnJkcyA9IFBITV9HRVRfRklFTEQoYnVyc3RUaW1lLCBNQ19BUkJfQlVSU1RfVElNRSwg
VFJSRFMwKTsKPiAgICAgICAgIHRycmRsID0gUEhNX0dFVF9GSUVMRChidXJzdFRpbWUsIE1DX0FS
Ql9CVVJTVF9USU1FLCBUUlJETDApOwo+Cj4gLS0KPiAyLjcuNAo+Cj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0
Cj4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
