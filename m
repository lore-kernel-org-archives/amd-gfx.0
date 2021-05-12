Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D5FC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 13:08:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9DAE61289
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 13:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9DAE61289
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dennisfoster.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0A576EBA8;
	Wed, 12 May 2021 13:08:01 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com
 [209.85.167.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E0FA6EB8E;
 Wed, 12 May 2021 12:21:14 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id j10so33380763lfb.12;
 Wed, 12 May 2021 05:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=F9MtIG+vQzUFqPNBIIS1xh4HkQAMYOe9LgSrlh3uhXY=;
 b=WEFE914hJLyDJZKFq2RQ2klmzFO5eunw4Esxy/DJAW3Jajo3tAVXfqlTLEdku3t/2Y
 RNfyzhdv+qT9DkD0yN37uA+cxM5or0OppicUHye+7Y4soA+TgKRGN7tbygALRJ5HW3XL
 PH+mxQ1G2MT6tVwCpYZxVKQk81gOe496dZyhzXS15+mvFFqyN95+4yMSvRIgreOjQVWZ
 GuoAUh5+dDsRtFF/59IYUtT7S0yLSdWA6h7xPMJfZ00Udwcey1lulHPIemmFU08ZaDLv
 N8y7F8HOJPi14n78hxMham1KBkpjhJtrDT5bqcTJMVIJDnjRBSjcwAJKdQ20hd4dhabI
 Us+w==
X-Gm-Message-State: AOAM533uiTXkBpsE3ZOb4D/bo5B0W3C3Ucf3EQsTkeGMRXYwyJWlYVxX
 wdd42CPWgay1DzaJsQD72WdiZbp2aq9b0aBn
X-Google-Smtp-Source: ABdhPJzPpZN6lu61sQAu9SXeWLt/l9pgTk5Si3FkHA0T1s+QdQ+3NBNt8AdPujeMw0JSD5CrGMoYFg==
X-Received: by 2002:a05:6512:1188:: with SMTP id
 g8mr24885080lfr.410.1620822072474; 
 Wed, 12 May 2021 05:21:12 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com.
 [209.85.208.176])
 by smtp.gmail.com with ESMTPSA id i5sm4203278ljb.129.2021.05.12.05.21.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 May 2021 05:21:12 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id v6so29304743ljj.5;
 Wed, 12 May 2021 05:21:11 -0700 (PDT)
X-Received: by 2002:a2e:751d:: with SMTP id q29mr11543921ljc.118.1620822071149; 
 Wed, 12 May 2021 05:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <s5ho8dmh98p.wl-tiwai@suse.de>
 <aa54b1d7-1d3c-4c77-37db-d6c93b8c794c@gmail.com>
 <72fd6a34-89d6-f46c-36ba-5b006dd47019@amd.com>
In-Reply-To: <72fd6a34-89d6-f46c-36ba-5b006dd47019@amd.com>
From: Dennis Foster <mail@dennisfoster.us>
Date: Wed, 12 May 2021 08:21:00 -0400
X-Gmail-Original-Message-ID: <CAOt9N1Ev2UTOBydgEB35BAm5Pad-uy78E1xAyS6qWDPYLThcLQ@mail.gmail.com>
Message-ID: <CAOt9N1Ev2UTOBydgEB35BAm5Pad-uy78E1xAyS6qWDPYLThcLQ@mail.gmail.com>
Subject: Re: [5.12 regression] ttm->pages NULL dereference with radeon driver
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-Mailman-Approved-At: Wed, 12 May 2021 13:07:59 +0000
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
Cc: Dennis Foster <mail@dennisfoster.us>, Takashi Iwai <tiwai@suse.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 arvin.kebob@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQ2hyaXN0aWFuLAoKSSBjYW4gY29uZmlybSB0aGF0IHRoZSBwYXRjaCBwcm92aWRlZCBmaXhl
cyB0aGUgaXNzdWUgaW4ga2VybmVsIHZlcnNpb24gNS4xMi4yClRoYW5rIHlvdS4KCgpPbiBXZWQs
IE1heSAxMiwgMjAyMSBhdCA2OjIxIEFNIENocmlzdGlhbiBLw7ZuaWcKPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4gd3JvdGU6Cj4KPiBIaSBndXlzLAo+Cj4gYWRkaW5nIGEgZmV3IHBlb3BsZSB3
aG8gcmFuIGludG8gdGhlIHByb2JsZW0gYXMgd2VsbCBhbmQgb3BlbmVkIGEga2VybmVsCj4gYnVn
Lgo+Cj4gQW0gMDcuMDUuMjEgdW0gMTc6MTEgc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+ID4g
SGkgVGFrYXNoaSwKPiA+Cj4gPiBBbSAwNy4wNS4yMSB1bSAxNzowOCBzY2hyaWViIFRha2FzaGkg
SXdhaToKPiA+PiBIaSwKPiA+Pgo+ID4+IHdlJ3ZlIHJlY2VpdmVkIGEgcmVncmVzc2lvbiByZXBv
cnQgc2hvd2luZyBOVUxMIGRlcmVmZXJlbmNlIE9vcHMgd2l0aAo+ID4+IHJhZGVvbiBkcml2ZXIg
b24gNS4xMiBrZXJuZWw6Cj4gPj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5v
dXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGYnVnemlsbGEub3BlbnN1c2Uub3JnJTJGc2hv
d19idWcuY2dpJTNGaWQlM0QxMTg1NTE2JmFtcDtkYXRhPTA0JTdDMDElN0NjaHJpc3RpYW4ua29l
bmlnJTQwYW1kLmNvbSU3QzY0NDQ3ZTllOTc2MDRhYWYxMTcwMDhkOTExNmE3NDJhJTdDM2RkODk2
MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzU1OTk3MTE4MTE4NzE3OCU3
Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16
SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT0xTEpNTHh1
dU1qa2Znbkl0JTJCNVo1bjE5cmklMkJNVExNUXZFRUIlMkYlMkZkNlNWa2clM0QmYW1wO3Jlc2Vy
dmVkPTAKPiA+Pgo+ID4+IEl0IHR1cm5lZCBvdXQgdGhhdCB0aGUgcmVjZW50IFRUTSBjbGVhbnVw
IC8gcmVmYWN0b3JpbmcgdmlhIGNvbW1pdAo+ID4+IDA1NzVmZjNkMzNjZCAoImRybS9yYWRlb246
IHN0b3AgdXNpbmcgcGFnZXMgd2l0aAo+ID4+IGRybV9wcmltZV9zZ190b19wYWdlX2FkZHJfYXJy
YXlzIHYyIikgaXMgdGhlIGN1bHByaXQuICBPbiA1LjEyIGtlcm5lbCwKPiA+PiB0dG0tPnBhZ2Vz
IGlzIG5vIGxvbmdlciBhbGxvY2F0ZWQgLyBzZXQgdXAsIHdoaWxlIHRoZSByYWRlb24gZHJpdmVy
Cj4gPj4gc3RpbGwgaGFzIGEgZmV3IHBsYWNlcyBhc3N1bWluZyB0aGUgdmFsaWQgdHRtLT5wYWdl
cywgYW5kIGZvciB0aGUKPiA+PiByZXBvcnRlciAocnVubmluZyB0aGUgbW9kZXNldHRpZyBkcml2
ZXIpLCByYWRlb25fZ2FydF9iaW5kKCkgaGl0cyB0aGUKPiA+PiBwcm9ibGVtLgo+ID4+Cj4gPj4g
QSBoYWNraXNoIHBhdGNoIGJlbG93IHdhcyBjb25maXJtZWQgdG8gd29yaywgYXQgbGVhc3QsIGJ1
dCBvYnZpb3VzbHkKPiA+PiB3ZSBuZWVkIGEgcHJvcGVyIGZpeC4KPiA+Pgo+ID4+IENvdWxkIHlv
dSB0YWtlIGEgbG9vayBhdCBpdD8KPiA+Cj4gPiBJZiB0aGF0J3MgYWxsIHRoZW4gdGhhdCBsb29r
cyB0cml2aWFsIHRvIG1lLgo+ID4KPiA+IEdvaW5nIHRvIHByb3ZpZGUgYSBwYXRjaCBvbiBNb25k
YXkuCj4KPiBTb3JyeSwgd2FzIGEgYnVzeSBzdGFydCBpbnRvIHRoZSB3ZWVrLiBJJ3ZlIGp1c3Qg
c2VuZCBhIHBhdGNoIHdoaWNoCj4gc2hvdWxkIGFkZHJlc3MgdGhlIGlzc3VlIHRvIHlvdSBhbmQg
dGhlIG1haWxpbmcgbGlzdC4KPgo+IFBsZWFzZSB0ZXN0IHNpbmNlIEkgY2FuJ3QgcmVwcm9kdWNl
IHRoZSBwcm9ibGVtIGxvY2FsbHkuCj4KPiBUaGFua3MsCj4gQ2hyaXN0aWFuLgo+Cj4gPgo+ID4g
VGhhbmtzIGZvciB0aGUgbm90aWNlLAo+ID4gQ2hyaXN0aWFuLgo+ID4KPiA+Pgo+ID4+Cj4gPj4g
dGhhbmtzLAo+ID4+Cj4gPj4gVGFrYXNoaQo+ID4+Cj4gPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L3JhZGVvbi9yYWRlb25fZ2FydC5jCj4gPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9y
YWRlb25fZ2FydC5jCj4gPj4gQEAgLTI1Myw3ICsyNTMsNyBAQCB2b2lkIHJhZGVvbl9nYXJ0X3Vu
YmluZChzdHJ1Y3QgcmFkZW9uX2RlCj4gPj4gICAgICAgdCA9IG9mZnNldCAvIFJBREVPTl9HUFVf
UEFHRV9TSVpFOwo+ID4+ICAgICAgIHAgPSB0IC8gKFBBR0VfU0laRSAvIFJBREVPTl9HUFVfUEFH
RV9TSVpFKTsKPiA+PiAgICAgICBmb3IgKGkgPSAwOyBpIDwgcGFnZXM7IGkrKywgcCsrKSB7Cj4g
Pj4gLSAgICAgICAgaWYgKHJkZXYtPmdhcnQucGFnZXNbcF0pIHsKPiA+PiArICAgICAgICBpZiAo
MSAvKnJkZXYtPmdhcnQucGFnZXNbcF0qLykgewo+ID4+ICAgICAgICAgICAgICAgcmRldi0+Z2Fy
dC5wYWdlc1twXSA9IE5VTEw7Cj4gPj4gICAgICAgICAgICAgICBmb3IgKGogPSAwOyBqIDwgKFBB
R0VfU0laRSAvIFJBREVPTl9HUFVfUEFHRV9TSVpFKTsKPiA+PiBqKyssIHQrKykgewo+ID4+ICAg
ICAgICAgICAgICAgICAgIHJkZXYtPmdhcnQucGFnZXNfZW50cnlbdF0gPSByZGV2LT5kdW1teV9w
YWdlLmVudHJ5Owo+ID4+IEBAIC0zMDEsNyArMzAxLDcgQEAgaW50IHJhZGVvbl9nYXJ0X2JpbmQo
c3RydWN0IHJhZGVvbl9kZXZpYwo+ID4+ICAgICAgIHAgPSB0IC8gKFBBR0VfU0laRSAvIFJBREVP
Tl9HUFVfUEFHRV9TSVpFKTsKPiA+PiAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBwYWdlczsgaSsr
LCBwKyspIHsKPiA+PiAtICAgICAgICByZGV2LT5nYXJ0LnBhZ2VzW3BdID0gcGFnZWxpc3RbaV07
Cj4gPj4gKyAgICAgICAgLyogcmRldi0+Z2FydC5wYWdlc1twXSA9IHBhZ2VsaXN0W2ldOyAqLwo+
ID4+ICAgICAgICAgICBwYWdlX2Jhc2UgPSBkbWFfYWRkcltpXTsKPiA+PiAgICAgICAgICAgZm9y
IChqID0gMDsgaiA8IChQQUdFX1NJWkUgLyBSQURFT05fR1BVX1BBR0VfU0laRSk7IGorKywKPiA+
PiB0KyspIHsKPiA+PiAgICAgICAgICAgICAgIHBhZ2VfZW50cnkgPSByYWRlb25fZ2FydF9nZXRf
cGFnZV9lbnRyeShwYWdlX2Jhc2UsIGZsYWdzKTsKPiA+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3JhZGVvbl90dG0uYwo+ID4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFk
ZW9uX3R0bS5jCj4gPj4gQEAgLTM2MCw2ICszNjAsOCBAQCBzdGF0aWMgaW50IHJhZGVvbl90dG1f
dHRfcGluX3VzZXJwdHIoc3RyCj4gPj4gICAgICAgICBpZiAoY3VycmVudC0+bW0gIT0gZ3R0LT51
c2VybW0pCj4gPj4gICAgICAgICAgIHJldHVybiAtRVBFUk07Cj4gPj4gKyAgICBpZiAoIXR0bS0+
cGFnZXMpCj4gPj4gKyAgICAgICAgcmV0dXJuIC1FUEVSTTsKPiA+PiAgICAgICAgIGlmIChndHQt
PnVzZXJmbGFncyAmIFJBREVPTl9HRU1fVVNFUlBUUl9BTk9OT05MWSkgewo+ID4+ICAgICAgICAg
ICAvKiBjaGVjayB0aGF0IHdlIG9ubHkgcGluIGRvd24gYW5vbnltb3VzIG1lbW9yeQo+ID4+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gPj4gYW1kLWdm
eCBtYWlsaW5nIGxpc3QKPiA+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ID4+IGh0
dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUz
QSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1n
ZngmYW1wO2RhdGE9MDQlN0MwMSU3Q2NocmlzdGlhbi5rb2VuaWclNDBhbWQuY29tJTdDNjQ0NDdl
OWU5NzYwNGFhZjExNzAwOGQ5MTE2YTc0MmElN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRl
MTgzZCU3QzAlN0MwJTdDNjM3NTU5OTcxMTgxMTg3MTc4JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNk
OGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pY
VkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRhPVJkekdwMUZMeEJLRSUyQnlQY2xyVUJmUW9tUlUw
cFFUJTJGNzhFd2NqJTJGQlo3M2clM0QmYW1wO3Jlc2VydmVkPTAKPiA+Pgo+ID4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
