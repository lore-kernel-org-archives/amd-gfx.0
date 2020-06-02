Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967BFC433E1
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 13:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E7632074B
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 13:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmnR1WvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7632074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7C566E3B8;
	Tue,  2 Jun 2020 13:15:32 +0000 (UTC)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 924366E190;
 Tue,  2 Jun 2020 10:00:00 +0000 (UTC)
Received: by mail-pf1-x442.google.com with SMTP id a4so4825863pfo.4;
 Tue, 02 Jun 2020 03:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Zp5PU9Twd2i2tzFPrLrjXtcDPzTLivpIOOvbhmocsuo=;
 b=dmnR1WvZuRPZ/6Vpb+2SuZ+t+QRjmdnWP4ZzKF3uTHDv6g1pEoMDEDg0XZp1RQS4Rc
 PcdwQZ29rNPnq3l2fjwqhuF7j/2HX+rBmez4tAy8HbfuXFzxbKgiqrjW/bkv/yD58r1Q
 RIPnaU6YMZn5W47hiL5Cwf7GTc+8XvqW2lhYOl2l6y2WsJw0EDbx5auoVaKZRGYT/MrW
 65P2sOwN8DsDt4Wk/Hj4ZI7jftv3djCsQ51f81pX/h2RYakYDO5iyWeC2mruTm4m/oAt
 spMKkoM1c0u9+ks+AAa++E4S2fyAHS2aD1Hvrb5vDAG2sKTV79mdr4NuETxL7Y2knUFA
 aapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Zp5PU9Twd2i2tzFPrLrjXtcDPzTLivpIOOvbhmocsuo=;
 b=VQmVG5s9JvPFVRtg74qBjmx4SgX1uyY5MyjyDlbR0QqaAmXS2hxFXfkl+1XQDNlyzc
 Zqerbio7qweR18PgTcVQJQM9/ubvCl8j/WZ437pceUkQPp6WWTiRkZgQ/2FXD11+0iFD
 DWzR4CtrmjactiykCtCZa7f+o2T03J0n6fszNXRh0mzugLXmu9yC+tCR4U8gtZEyOo0t
 zc+sApHTpUPw6JyhiaBUVXGAVQpk0cT8Whyt2uf8ZUAozyuDB6DLq/RBEzVZGxlFItv6
 9z9Wrr6B8mrPd6Ii12OuBYcZeFvtyUdEMcp8qZUsyCtulkPj/2AB/Yr61bWTvHNCtmon
 MKXw==
X-Gm-Message-State: AOAM532qUbDf64XKpf6c5v1ADuymIzhUQg0jFI0eWeI0D9+U6ipP/Izj
 o4gj+fQji6bT4UwXccv/T410o5r/BCwwQuoG2HOeh3gYt04=
X-Google-Smtp-Source: ABdhPJyDp8msT2DNgjzkwwVUe+Cx8nDbX/Gkz2pS3jjzG2aw72oIk/YYF9TBdmXcCF3WA4qheLl5NIP1f08J9GZZI+k=
X-Received: by 2002:a63:545a:: with SMTP id e26mr22863595pgm.4.1591092000175; 
 Tue, 02 Jun 2020 03:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200602092030.31966-1-piotr.stankiewicz@intel.com>
 <CAHp75Ve9tdNB7s+gybsg-OUjA3HiZBgzxeOzw=qkx8t1Ybbmsg@mail.gmail.com>
 <CY4PR11MB1528E8F05A738675B0DC1A59F98B0@CY4PR11MB1528.namprd11.prod.outlook.com>
In-Reply-To: <CY4PR11MB1528E8F05A738675B0DC1A59F98B0@CY4PR11MB1528.namprd11.prod.outlook.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 2 Jun 2020 12:59:48 +0300
Message-ID: <CAHp75VdmaGchzGCQ1ch4-9nj=5EKFAndUCKRZKhhiSRrbTwnnA@mail.gmail.com>
Subject: Re: [PATCH 07/15] drm/amdgpu: use PCI_IRQ_MSI_TYPES where appropriate
To: "Stankiewicz, Piotr" <piotr.stankiewicz@intel.com>
X-Mailman-Approved-At: Tue, 02 Jun 2020 13:15:31 +0000
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
Cc: David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBKdW4gMiwgMjAyMCBhdCAxMjo1OCBQTSBTdGFua2lld2ljeiwgUGlvdHIKPHBpb3Ry
LnN0YW5raWV3aWN6QGludGVsLmNvbT4gd3JvdGU6Cj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQo+ID4gRnJvbTogQW5keSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29t
Pgo+ID4gU2VudDogVHVlc2RheSwgSnVuZSAyLCAyMDIwIDExOjQ5IEFNCj4gPiBUbzogU3Rhbmtp
ZXdpY3osIFBpb3RyIDxwaW90ci5zdGFua2lld2ljekBpbnRlbC5jb20+Cj4gPiBDYzogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPjsgQ2hyaXN0aWFuIEvDtm5pZwo+ID4g
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT47IERhdmlkIFpob3UgPERhdmlkMS5aaG91QGFtZC5j
b20+OyBEYXZpZAo+ID4gQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPjsgRGFuaWVsIFZldHRlciA8
ZGFuaWVsQGZmd2xsLmNoPjsgYW1kLQo+ID4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgZHJp
LWRldmVsIDxkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPjsgTGludXgKPiA+IEtlcm5l
bCBNYWlsaW5nIExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+Cj4gPiBTdWJqZWN0
OiBSZTogW1BBVENIIDA3LzE1XSBkcm0vYW1kZ3B1OiB1c2UgUENJX0lSUV9NU0lfVFlQRVMgd2hl
cmUKPiA+IGFwcHJvcHJpYXRlCj4gPiBPbiBUdWUsIEp1biAyLCAyMDIwIGF0IDEyOjI0IFBNIFBp
b3RyIFN0YW5raWV3aWN6Cj4gPiA8cGlvdHIuc3RhbmtpZXdpY3pAaW50ZWwuY29tPiB3cm90ZToK
Ci4uLgoKPiA+ID4gICAgICAgICAgICAgICAgIGludCBudmVjID0gcGNpX21zaXhfdmVjX2NvdW50
KGFkZXYtPnBkZXYpOwo+ID4gPiAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGZsYWdzOwo+
ID4gPgo+ID4gPiAtICAgICAgICAgICAgICAgaWYgKG52ZWMgPD0gMCkgewo+ID4gPiArICAgICAg
ICAgICAgICAgaWYgKG52ZWMgPiAwKQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBmbGFn
cyA9IFBDSV9JUlFfTVNJX1RZUEVTOwo+ID4gPiArICAgICAgICAgICAgICAgZWxzZQo+ID4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICBmbGFncyA9IFBDSV9JUlFfTVNJOwo+ID4gPiAtICAgICAg
ICAgICAgICAgfSBlbHNlIHsKPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgZmxhZ3MgPSBQ
Q0lfSVJRX01TSSB8IFBDSV9JUlFfTVNJWDsKPiA+ID4gLSAgICAgICAgICAgICAgIH0KPiA+ID4g
Kwo+ID4gPiAgICAgICAgICAgICAgICAgLyogd2Ugb25seSBuZWVkIG9uZSB2ZWN0b3IgKi8KPiA+
ID4gICAgICAgICAgICAgICAgIG52ZWMgPSBwY2lfYWxsb2NfaXJxX3ZlY3RvcnMoYWRldi0+cGRl
diwgMSwgMSwgZmxhZ3MpOwo+ID4KPiA+IEknbSBub3Qgc3VyZSBpZiB5b3UgaGF2ZSBzZWVuIG15
IGxhc3QgY29tbWVudCBpbnRlcm5hbGx5IGFib3V0IHRoaXMgcGF0Y2guCj4gPgo+ID4gSSBkb24n
dCB1bmRlcnN0YW5kIHdoeSB3ZSBuZWVkIHRoZXNlIHBjaV9tc2l4X3ZlY19jb3VudCgpIGZvbGxv
d2VkIGJ5Cj4gPiBjb25kaXRpb25hbCBhdCBhbGwuCj4gPiBQZXJoYXBzIHdlIG1heSBzaW1wbGUg
ZHJvcCBhbGwgdGhlc2UgYW5kIHN1cHBseSBmbGFnIGRpcmVjdGx5Pwo+ID4KPiA+IEJ1dCBPVE9I
LCBJIGRvbid0IGtub3cgdGhlIGluaXRpYWwgbW90aXZhdGlvbiwgc28sIHRoZSBhYm92ZSBwYXRj
aCBpcwo+ID4gbm9uLWludHJ1c2l2ZSBhbmQga2VlcHMgb3JpZ2luYWwgbG9naWMuCj4gPgo+Cj4g
U29ycnksIEkgbXVzdCBoYXZlIG1pc3VuZGVyc3Rvb2Qgb3IgbWlzc2VkIHRoYXQgY29tbWVudC4g
SSBhbSBoYXBweQo+IHRvIGRvIGEgVjIgaWYgZHJvcHBpbmcgdGhlIGNvbmRpdGlvbmFsIGlzIHBy
ZWZlcmFibGUuCgpMZXQncyB3YWl0IGZvciBBTUQgcGVvcGxlIHRvIGNvbmZpcm0gZWl0aGVyLgoK
LS0gCldpdGggQmVzdCBSZWdhcmRzLApBbmR5IFNoZXZjaGVua28KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
