Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF713C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 10:41:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C792065C
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 10:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyfveqWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C792065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F8EE6E9C4;
	Fri, 22 May 2020 10:41:48 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C01B6E9C3;
 Fri, 22 May 2020 10:41:46 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id h21so12465414ejq.5;
 Fri, 22 May 2020 03:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=ozVGr0ROx2plEUcxcKuRGlViE6dc9ydi5yqIkT3VuCg=;
 b=JyfveqWe2JzCNHuWdt5wYM7u+QeYK4SFO2HVcDv4Bj7dcqXVjz8NBdYuVghj7bJJiS
 YIxzjfi+D4R7uvqYb7O0xSxH0QFFVqlpo5/9gy1MNeD6kHSwhF7KQg3qwypnonZaFpgo
 +xggUE1+MTVjXfIOEjUBRrAas4bOajdmEt9lwQBEFY+rcyRhkwzFTUuUHtcSaxpxDiEF
 i8eh4+JhlR7Ji4dXpYwrushhOW+9oKi47xZTJ0vn0Gdp4mMSe5fhHsK//lUVlhOUR7ko
 dd4ZqakvLY17e7Z2UM8Qre8lgu9JFcTrGWcB+Baz5Q7QXr1nUNRok9X34G9dy+NI5KrT
 ymWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=ozVGr0ROx2plEUcxcKuRGlViE6dc9ydi5yqIkT3VuCg=;
 b=GKX01ie/ol5GRqcUcx7dU0uFinKKVfgJvdbO0grr5ciMGBMyJfhRXU9ccQoJqdG07D
 R32gpyTjf7seH3TtgTRnyAqN2uoWK+Ht4/j38RDBb1OmkHydellqplFcOuiF5qo8xmtU
 58RFbd/nmIFOIIjKVVM/Pi/quXACOP+w6lbz8O6qO/3rMSf40J1Op4ZCpd6/Ue3DZAdA
 XwXkEbGcg0sCMwa6UjtJMASvdODqSZ0M2y2UqJ4IIaPv5FxFg6Vf6sSJNQxzj8bDPk3n
 6T6zU7IkITxoFg3SreNMQ0EOBtpCmFlub4/SqaNLavtx49moAB34ePPx/JmjnOfHvC/r
 47WA==
X-Gm-Message-State: AOAM533KXN5Kq7bYVb6mGNKAtEKTg+MIIxXsZi+qogYb2+iSOOM3vqPl
 4MN2OBJuN2uKetjkMI741ChMuQel
X-Google-Smtp-Source: ABdhPJx6sE0Sfl0Qx5ddswUb1Y3EfEcAchD+cHcn8nzPu8UyHChOPRCl44S4xH7BhBzIGSvb8PQiUQ==
X-Received: by 2002:a17:906:703:: with SMTP id y3mr7658787ejb.61.1590144104786; 
 Fri, 22 May 2020 03:41:44 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id i4sm7401043eja.92.2020.05.22.03.41.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 May 2020 03:41:44 -0700 (PDT)
Subject: Re: [RFC] Deprecate AGP GART support for Radeon/Nouveau/TTM
To: Alex Deucher <alexdeucher@gmail.com>
References: <20200513110313.12979-1-christian.koenig@amd.com>
 <9d784383-905e-59af-b17c-923c92474ece@gmail.com>
 <CADnq5_PxUD546E852r918xEc=MddzArLDciBKtJRpuoiC4e-qQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9e87c7db-3129-42fb-e1b3-0b8dfe3bca8f@gmail.com>
Date: Fri, 22 May 2020 12:41:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_PxUD546E852r918xEc=MddzArLDciBKtJRpuoiC4e-qQ@mail.gmail.com>
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
Reply-To: christian.koenig@amd.com
Cc: Alex Deucher <alexander.deucher@amd.com>,
 nouveau <nouveau@lists.freedesktop.org>, debian-powerpc@lists.debian.org,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAuMDUuMjAgdW0gMTg6MTggc2NocmllYiBBbGV4IERldWNoZXI6Cj4gT24gV2VkLCBNYXkg
MjAsIDIwMjAgYXQgMTA6NDMgQU0gQ2hyaXN0aWFuIEvDtm5pZwo+IDxja29lbmlnLmxlaWNodHp1
bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4+IEFtIDEzLjA1LjIwIHVtIDEzOjAzIHNjaHJpZWIg
Q2hyaXN0aWFuIEvDtm5pZzoKPj4+IFVuZm9ydHVuYXRlbHkgQUdQIGlzIHN0aWxsIHRvIHdpZGVs
eSB1c2VkIGFzIHdlIGNvdWxkIGp1c3QgZHJvcCBzdXBwb3J0IGZvciB1c2luZyBpdHMgR0FSVC4K
Pj4+Cj4+PiBOb3QgdXNpbmcgdGhlIEFHUCBHQVJUIGFsc28gZG9lc24ndCBtZWFuIGEgbG9zcyBp
biBmdW5jdGlvbmFsaXR5IHNpbmNlIGRyaXZlcnMgd2lsbCBqdXN0IGZhbGxiYWNrIHRvIHRoZSBk
cml2ZXIgc3BlY2lmaWMgUENJIEdBUlQuCj4+Pgo+Pj4gRm9yIG5vdyBqdXN0IGRlcHJlY2F0ZSB0
aGUgY29kZSBhbmQgZG9uJ3QgZW5hYmxlIHRoZSBBR1AgR0FSVCBpbiBUVE0gZXZlbiB3aGVuIGdl
bmVyYWwgQUdQIHN1cHBvcnQgaXMgYXZhaWxhYmxlLgo+PiBTbyBJJ3ZlIHVzZWQgYW4gYW5jaWVu
dCBzeXN0ZW0gKDMyYml0KSB0byBzZXR1cCBhIHRlc3QgYm94IGZvciB0aGlzLgo+Pgo+Pgo+PiBU
aGUgZmlyc3QgR1BVIEkgY291bGQgdGVzdCBpcyBhbiBSVjI4MCAoUmFkZW9uIDkyMDAgUFJPKSB3
aGljaCBpcyBlYXNpbHkKPj4gMTUgeWVhcnMgb2xkLgo+Pgo+PiBXaGF0IGhhcHBlbnMgaW4gQUdQ
IG1vZGUgaXMgdGhhdCBnbHhnZWFycyBzaG93cyBhcnRpZmFjdHMgZHVyaW5nCj4+IHJlbmRlcmlu
ZyBvbiB0aGlzIHN5c3RlbS4KPj4KPj4gSW4gUENJIG1vZGUgdGhvc2UgcmVuZGVyaW5nIGFydGlm
YWN0cyBhcmUgZ29uZSBhbmQgZ2x4Z2VhcnMgc2VlbXMgdG8KPj4gZHJhdyBldmVyeXRoaW5nIGNv
cnJlY3RseSBub3cuCj4+Cj4+IFBlcmZvcm1hbmNlIGlzIG9idmlvdXNseSBub3QgY29tcGFyYWJs
ZSwgY2F1c2UgaW4gQUdQIHdlIGRvbid0IHJlbmRlcgo+PiBhbGwgdHJpYW5nbGVzIGNvcnJlY3Rs
eS4KPj4KPj4KPj4gVGhlIHNlY29uZCBHUFUgSSBjb3VsZCB0ZXN0IGlzIGFuIFJWNjMwIFBSTyAo
UmFkZW9uIEhEIDI2MDAgUFJPIEFHUCkKPj4gd2hpY2ggaXMgbW9yZSB0aGFuIDEwIHllYXJzIG9s
ZC4KPj4KPj4gQXMgZmFyIGFzIEkgY2FuIHRlbGwgdGhpcyBvbmUgd29ya3MgaW4gYm90aCBBR1Ag
YW5kIFBDSWUgbW9kZSBwZXJmZWN0bHkKPj4gZmluZS4KPj4KPj4gU2luY2UgdGhpcyBpcyBvbmx5
IGEgMzJiaXQgc3lzdGVtIEkgY291bGRuJ3QgcmVhbGx5IHRlc3QgYW55IE9wZW5HTCBnYW1lCj4+
IHRoYXQgd2VsbC4KPj4KPj4gQnV0IGZvciBnbHhnZWFycyBzd2l0Y2hpbmcgZnJvbSBBR1AgdG8g
UENJZSBtb2RlIHNlZW1zIHRvIHJlc3VsdCBpbiBhCj4+IHJvdWdobHkgNSUgcGVyZm9ybWFuY2Ug
ZHJvcC4KPj4KPj4gVGhlIHN1cnByaXNpbmcgcmVhc29uIGZvciB0aGlzIGlzIG5vdCB0aGUgYmV0
dGVyIFRMQiBwZXJmb3JtYW5jZSwgYnV0Cj4+IHRoZSBsYWNrIG9mIFVTV0Mgc3VwcG9ydCBmb3Ig
dGhlIFBDSWUgR0FSVCBpbiByYWRlb24uCj4+Cj4+Cj4+IFNvIGlmIGFueWJvZHkgd2FudHMgdG8g
Z2V0IGhpcyBoYW5kcyBkaXJ0eSBhbmQgc3F1ZWV6ZSBhIGJpdCBtb3JlCj4+IHBlcmZvcm1hbmNl
IG91dCBvZiB0aGUgb2xkIGhhcmR3YXJlLCBwb3J0aW5nIFVTV0MgZnJvbSBhbWRncHUgdG8gcmFk
ZW9uCj4+IHNob3VsZG4ndCBiZSB0byBtdWNoIG9mIGEgcHJvYmxlbS4KPiBXZSBkbyBzdXBwb3J0
IFVTV0Mgb24gcmFkZW9uLCBhbHRob3VnaCBJIHRoaW5rIHdlIGhhZCBzZXBhcmF0ZSBmbGFncwo+
IGZvciBjYWNoZWQgYW5kIFdDLiAgVGhhdCBzYWlkIHdlIGhhZCBhIGxvdCBvZiBwcm9ibGVtcyB3
aXRoIFdDIG9uIDMyCj4gYml0IChzZWUgcmFkZW9uX2JvX2NyZWF0ZSgpKS4gIFRoZSBvdGhlciBw
cm9ibGVtIGlzIHRoYXQsIGF0IGxlYXN0IG9uCj4gdGhlIHJlYWxseSBvbGQgcmFkZW9ucywgdGhl
IFBDSSBnYXJ0IGRpZG4ndCBzdXBwb3J0IHNub29wZWQgYW5kCj4gdW5zbm9vcGVkLiAgSXQgd2Fz
IGFsd2F5cyBzbm9vcGVkLiAgSXQgd2Fzbid0IHVudGlsIHBjaWUgdGhhdCB0aGUgZ2FydAo+IGh3
IGdvdCBzdXBwb3J0IGZvciBib3RoLiAgRm9yIEFHUCwgdGhlIGV4cGVjdGF0aW9uIHdhcyB0aGF0
IEFHUAo+IHByb3ZpZGVkIHRoZSB1bmNhY2hlZCBtZW1vcnkuCgpPaCwgaW5kZWVkLiBJIGRpZG4n
dCByZW1lbWJlcmVkIHRoYXQuCgpJbnRlcmVzdGluZyBpcyB0aGF0IGluIHRoaXMgY2FzZSBJIGhh
dmUgbm8gaWRlYSB3aGVyZSB0aGUgcGVyZm9ybWFuY2UgCmRpZmZlcmVuY2UgaXMgY29taW5nIGZy
b20uCgo+Cj4+Cj4+IFN1bW1pbmcgaXQgdXAgSSdtIHN0aWxsIGxlYW5pbmcgdG93YXJkcyBkaXNh
YmxpbmcgQUdQIGNvbXBsZXRlbHkgYnkKPj4gZGVmYXVsdCBmb3IgcmFkZW9uIGFuZCBkZXByZWNh
dGUgaXQgaW4gVFRNIGFzIHdlbGwuCj4+Cj4+IFRob3VnaHRzPyBFc3BlY2lhbGx5IEFsZXggd2hh
dCBkbyB5b3UgdGhpbmsuCj4gV29ya3MgZm9yIG1lLgoKSSB3aWxsIHRha2UgdGhhdCBhcyBhbiBy
YiBhbmQgY29tbWl0IGF0IGxlYXN0IHRoZSBmaXJzdCBwYXRjaC4KClRoYW5rcywKQ2hyaXN0aWFu
LgoKPgo+IEFsZXgKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
