Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13735C47089
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 04:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C020261090
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 04:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C020261090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8406D6EE25;
	Thu, 27 May 2021 04:27:44 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D35D16EE25;
 Thu, 27 May 2021 04:27:43 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id y76so3876283oia.6;
 Wed, 26 May 2021 21:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZT5FSoIiyDWBnTxiiZjSflnBrLIqWN4cLVY+j1uJuFw=;
 b=NOsebllSQH9aGPkH2RcdDiA7CI9wsl8Hpi5SHlA5oOE4W2iuhAZkqa++V9Z05Auxds
 Evs7CXqCEtsKa8kFQEMlNAlypHu3MKIpvzzB8zzHtONxAbTp7+TZxZoEkhUzh5EujZwL
 Xb/5SuddSczb7ofmJlilPuHYw7Er6PtLPs5TIlfhQh2d6SV8eFem/zKXUFMnrA6GNEOp
 sSQlUdqSNzrenxnQKigNs0GMnzAqtYufSvIx1SNi+LwJlEqpdhgxbb39hDTnYReSHCkv
 T/TQs+TOWg8PqWnswYT8UFT28gEEyELwT6sYyrmtpl0Wraqt47p8zxpHv4WpStPXxhJq
 hVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZT5FSoIiyDWBnTxiiZjSflnBrLIqWN4cLVY+j1uJuFw=;
 b=fBr2BZ2eIs8rxTgfaVZ+e9L8Pl/VlJWpFf1En01hmRBN+yddmjURRdzkJeKdmwX3Rd
 XIZFfgBhbqoxSWJW1coEzG0Qlf8WwuyRrvU7fSFOPS752Qvay0AMUepglODlP1MDO9dL
 A1+T3nqIVH/xwkQaRRthP6G6nNwZjSUxaeH6LMPZop973gmXgcV2RI03ThRoNNANnuBH
 PVc6u0dT0EiWtGeabtBcxmW8MLBJSXzUd2SdcCf4ghitwZjoy8Zj47Mtu4E6Vj/Y7BJt
 mLqZlSrTD6SUQEt7BeQ99AVTi23SNcplecF+o1jWwBi7EdLpQ00pYPlGwKz6xMHLP6Pg
 G7EQ==
X-Gm-Message-State: AOAM530hFUxCdHVJDwynoHFkjsT49SdqVccjejxVwOfUokZE9C5h8nUb
 ZV8em2t20LuoHsl+g5pNwrFrkDtHpNETf8fGr8/7HyaF
X-Google-Smtp-Source: ABdhPJyp2LVtbVpT+fbmhtkDrJadl7HkNYyBL7sr6DFQn3FF+hx4ahAXpE26gzypq/t10zhPHs4p3/fFzj6NAYcKNtY=
X-Received: by 2002:a05:6808:249:: with SMTP id
 m9mr1097793oie.120.1622089663253; 
 Wed, 26 May 2021 21:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org>
 <20210526084726.552052-24-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-24-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 May 2021 00:27:32 -0400
Message-ID: <CADnq5_OW=Zp9gA1V+avgSV-k7Kr38ZqSqVNMnT+URnvW3ptiBw@mail.gmail.com>
Subject: Re: [PATCH 23/34] drm/amd/display/dmub/src/dmub_srv_stat: Convert
 function header to kernel-doc
To: Lee Jones <lee.jones@linaro.org>
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 David Airlie <airlied@linux.ie>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFdlZCwgTWF5IDI2LCAyMDIxIGF0IDQ6NDggQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9kaXNwbGF5L2RtdWIvc3JjL2RtdWJfc3J2X3N0YXQuYzozODogd2FybmluZzogQ2Fu
bm90IHVuZGVyc3RhbmQgICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCj4KPiBDYzogSGFycnkgV2VudGxh
bmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Cj4gQ2M6IExlbyBMaSA8c3VucGVuZy5saUBhbWQu
Y29tPgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6
ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZp
ZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBm
ZndsbC5jaD4KPiBDYzogSnVuIExlaSA8SnVuLkxlaUBhbWQuY29tPgo+IENjOiBNZWVuYWtzaGlr
dW1hciBTb21hc3VuZGFyYW0gPG1lZW5ha3NoaWt1bWFyLnNvbWFzdW5kYXJhbUBhbWQuY29tPgo+
IENjOiBSb2RyaWdvIFNpcXVlaXJhIDxSb2RyaWdvLlNpcXVlaXJhQGFtZC5jb20+Cj4gQ2M6IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3Jn
Pgo+IC0tLQo+ICAuLi4vZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJfc3J2X3N0YXQuYyAg
fCAxOSArKysrKystLS0tLS0tLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KyksIDEzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kbXViL3NyYy9kbXViX3Nydl9zdGF0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZG11Yi9zcmMvZG11Yl9zcnZfc3RhdC5jCj4gaW5kZXggZTZmM2JmYWIzM2QzZS4uNzA3
NjZkNTM0YzljOCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11
Yi9zcmMvZG11Yl9zcnZfc3RhdC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RtdWIvc3JjL2RtdWJfc3J2X3N0YXQuYwo+IEBAIC0zNSwyMCArMzUsMTMgQEAKPiAgICovCj4K
PiAgLyoqCj4gLSAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgo+IC0gKiAgRnVuY3Rpb246IGRtdWJfc3J2
X3N0YXRfZ2V0X25vdGlmaWNhdGlvbgo+ICsgKiBkbXViX3Nydl9zdGF0X2dldF9ub3RpZmljYXRp
b24gLSBSZXRyaWV2ZXMgYSBkbXViIG91dGJveCBub3RpZmljYXRpb24sIHNldCB1cCBkbXViIG5v
dGlmaWNhdGlvbgo+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3R1
cmUgd2l0aCBtZXNzYWdlIGluZm9ybWF0aW9uLiBBbHNvIGEgcGVuZGluZyBiaXQgaWYgcXVldWUK
PiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaXMgaGF2aW5nIG1vcmUgbm90
aWZpY2F0aW9ucwo+ICsgKiAgQGRtdWI6IGRtdWIgc3J2IHN0cnVjdHVyZQo+ICsgKiAgQG5vdGlm
eTogZG11YiBub3RpZmljYXRpb24gc3RydWN0dXJlIHRvIGJlIGZpbGxlZCB1cAo+ICAgKgo+IC0g
KiAgQGJyaWVmCj4gLSAqICAgICAgICAgICAgIFJldHJpZXZlcyBhIGRtdWIgb3V0Ym94IG5vdGlm
aWNhdGlvbiwgc2V0IHVwIGRtdWIgbm90aWZpY2F0aW9uCj4gLSAqICAgICAgICAgICAgIHN0cnVj
dHVyZSB3aXRoIG1lc3NhZ2UgaW5mb3JtYXRpb24uIEFsc28gYSBwZW5kaW5nIGJpdCBpZiBxdWV1
ZQo+IC0gKiAgICAgICAgICAgICBpcyBoYXZpbmcgbW9yZSBub3RpZmljYXRpb25zCj4gLSAqCj4g
LSAqICBAcGFyYW0gW2luXSBkbXViOiBkbXViIHNydiBzdHJ1Y3R1cmUKPiAtICogIEBwYXJhbSBb
b3V0XSBwbm90aWZ5OiBkbXViIG5vdGlmaWNhdGlvbiBzdHJ1Y3R1cmUgdG8gYmUgZmlsbGVkIHVw
Cj4gLSAqCj4gLSAqICBAcmV0dXJuCj4gLSAqICAgICBkbXViX3N0YXR1cwo+IC0gKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioKPiArICogIFJldHVybnM6IGRtdWJfc3RhdHVzCj4gICAqLwo+ICBlbnVtIGRt
dWJfc3RhdHVzIGRtdWJfc3J2X3N0YXRfZ2V0X25vdGlmaWNhdGlvbihzdHJ1Y3QgZG11Yl9zcnYg
KmRtdWIsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c3RydWN0IGRtdWJfbm90aWZpY2F0aW9uICpub3RpZnkpCj4gLS0KPiAyLjMxLjEKPgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
