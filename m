Return-Path: <SRS0=1gsM=4X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD303C10F25
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2020 20:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C0FA20709
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2020 20:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+39a52B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0FA20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 619D96ED5C;
	Fri,  6 Mar 2020 20:03:16 +0000 (UTC)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67A356ED59
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2020 20:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583524994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PNoxr8x2InIon4UabqH204xzJISgqUT+W7Pye6JntJo=;
 b=e+39a52Bdf1U5SXWB9EaOKL6MEmtNTuVcmkJ+yQ05pmPtANzI9ccgmxiby2ynbIALlIusT
 OYTVIRx+Oj6XTPQyH9x/17m6InuQJ5VRtDQM8EBfJ5BsN23U5DXhSyi9iOO+2+cj3vynPa
 kXHtUIjq6Cg/utdOQe6YY/ZPeYnvnfg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-YpkGdKi3M3GF0yqMkYbAXQ-1; Fri, 06 Mar 2020 15:03:07 -0500
X-MC-Unique: YpkGdKi3M3GF0yqMkYbAXQ-1
Received: by mail-qt1-f198.google.com with SMTP id n4so2130423qtv.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Mar 2020 12:03:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=dLV0eZu1glWbZE8lg3VCIfQvG/kVlmRarC+U2c4kgyM=;
 b=TwT6FqYpdG/7MFs817/zyRzTPTjMZqdIKH9rSSekyhRxjQBoHiotwE39ecXKbLeoBX
 +CBlvtSMNAocMgMWdO5sIwRMUI2mOZrlQiFp+YHlETUR4pZU4rcOKq2aIGK/kGMElBoE
 nI0SvjS3RY7kg0XAlqF4Jj6QWdSBzImeOpzSecq5/4pc0+Rt+IlLe6QakjH4CLGhxSVg
 VvcHijkDxGcbogVefvsVl6am0C2pGYXWsm3Sc9og6145FCr81wZNInuBV4ILOsymJhaX
 iLdBd5p5C3a5wqPXhZqmmzmTg/a8UlSB/HwGtlwZUVGj3pJdCDVny/ec/l90d0P6+vR+
 rdUw==
X-Gm-Message-State: ANhLgQ1JLuMMmWzeFo7/KzvfFOjO60YXP9/kngN+P+ht+vMGOnri4obN
 wBjfeVsILl3MT23QzxTIdggoOMKR3mF8yCSIlUzDF3iwH4Ckl8h5FGis9fNpeQ+QlhhkrBrW6bl
 WEQ1V/tra2kup94Wf5CB62b3dXQ==
X-Received: by 2002:ac8:4250:: with SMTP id r16mr4651924qtm.23.1583524986569; 
 Fri, 06 Mar 2020 12:03:06 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvvRFrhDPsM/Fa4LgFvlGizYhTEkcl9h5HIbw8fjc0rIMYtKufRSA8znZWWlcc0OuSwuzgJjw==
X-Received: by 2002:ac8:4250:: with SMTP id r16mr4651879qtm.23.1583524986115; 
 Fri, 06 Mar 2020 12:03:06 -0800 (PST)
Received: from dhcp-10-20-1-196.bss.redhat.com ([144.121.20.162])
 by smtp.gmail.com with ESMTPSA id f93sm3373069qtd.26.2020.03.06.12.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 12:03:05 -0800 (PST)
Message-ID: <082a7ac697ade8145afe45001fdf9541d5304748.camel@redhat.com>
Subject: Re: [PATCH 2/3] drm/dp_mst: Don't show connectors as connected
 before probing available PBN
From: Lyude Paul <lyude@redhat.com>
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Date: Fri, 06 Mar 2020 15:03:04 -0500
In-Reply-To: <20200305182942.GP13686@intel.com>
References: <20200304223614.312023-1-lyude@redhat.com>
 <20200304223614.312023-3-lyude@redhat.com>
 <20200305131119.GJ13686@intel.com>
 <73f52c392431cd21a80a118dd2fd1986e2c535df.camel@redhat.com>
 <20200305182942.GP13686@intel.com>
Organization: Red Hat
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Sean Paul <seanpaul@google.com>, David Airlie <airlied@linux.ie>,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Hans de Goede <hdegoede@redhat.com>,
 dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCAyMDIwLTAzLTA1IGF0IDIwOjI5ICswMjAwLCBWaWxsZSBTeXJqw6Rsw6Qgd3JvdGU6
Cj4gT24gVGh1LCBNYXIgMDUsIDIwMjAgYXQgMDE6MTM6MzZQTSAtMDUwMCwgTHl1ZGUgUGF1bCB3
cm90ZToKPiA+IE9uIFRodSwgMjAyMC0wMy0wNSBhdCAxNToxMSArMDIwMCwgVmlsbGUgU3lyasOk
bMOkIHdyb3RlOgo+ID4gPiBPbiBXZWQsIE1hciAwNCwgMjAyMCBhdCAwNTozNjoxMlBNIC0wNTAw
LCBMeXVkZSBQYXVsIHdyb3RlOgo+ID4gPiA+IEl0J3MgbmV4dCB0byBpbXBvc3NpYmxlIGZvciB1
cyB0byBkbyBjb25uZWN0b3IgcHJvYmluZyBvbiB0b3BvbG9naWVzCj4gPiA+ID4gd2l0aG91dCBv
Y2Nhc2lvbmFsbHkgcmFjaW5nIHdpdGggdXNlcnNwYWNlLCBzaW5jZSBjcmVhdGluZyBhIGNvbm5l
Y3Rvcgo+ID4gPiA+IGl0c2VsZiBjYXVzZXMgYSBob3RwbHVnIGV2ZW50IHdoaWNoIHdlIGhhdmUg
dG8gc2VuZCBiZWZvcmUgcHJvYmluZyB0aGUKPiA+ID4gPiBhdmFpbGFibGUgUEJOIG9mIGEgY29u
bmVjdG9yLiBFdmVuIGlmIHdlIGRpZG4ndCBoYXZlIHRoaXMgaG90cGx1Zwo+ID4gPiA+IGV2ZW50
Cj4gPiA+ID4gc2VudCwgdGhlcmUncyBzdGlsbCBhbHdheXMgYSBjaGFuY2UgdGhhdCB1c2Vyc3Bh
Y2Ugc3RhcnRlZCBwcm9iaW5nCj4gPiA+ID4gY29ubmVjdG9ycyBiZWZvcmUgd2UgZmluaXNoZWQg
cHJvYmluZyB0aGUgdG9wb2xvZ3kuCj4gPiA+ID4gCj4gPiA+ID4gVGhpcyBjYW4gYmUgYSBwcm9i
bGVtIHdoZW4gdmFsaWRhdGluZyBhIG5ldyBNU1Qgc3RhdGUgc2luY2UgdGhlCj4gPiA+ID4gY29u
bmVjdG9yIHdpbGwgYmUgc2hvd24gYXMgY29ubmVjdGVkIGJyaWVmbHksIGJ1dCB3aXRob3V0IGFu
eQo+ID4gPiA+IGF2YWlsYWJsZQo+ID4gPiA+IFBCTiAtIGNhdXNpbmcgYW55IGF0b21pYyBzdGF0
ZSB3aGljaCB3b3VsZCBlbmFibGUgc2FpZCBjb25uZWN0b3IgdG8KPiA+ID4gPiBmYWlsCj4gPiA+
ID4gd2l0aCAtRU5PU1BDLiBTbywgbGV0J3Mgc2ltcGx5IHdvcmthcm91bmQgdGhpcyBieSB0ZWxs
aW5nIHVzZXJzcGFjZQo+ID4gPiA+IG5ldwo+ID4gPiA+IE1TVCBjb25uZWN0b3JzIGFyZSBkaXNj
b25uZWN0ZWQgdW50aWwgd2UndmUgZmluaXNoZWQgcHJvYmluZyB0aGVpcgo+ID4gPiA+IFBCTi4K
PiA+ID4gPiBTaW5jZSB3ZSBhbHdheXMgc2VuZCBhIGhvdHBsdWcgZXZlbnQgYXQgdGhlIGVuZCBv
ZiB0aGUgbGluayBhZGRyZXNzCj4gPiA+ID4gcHJvYmluZyBwcm9jZXNzLCB1c2Vyc3BhY2Ugd2ls
bCBzdGlsbCBrbm93IHRvIHJlcHJvYmUgdGhlIGNvbm5lY3Rvcgo+ID4gPiA+IHdoZW4KPiA+ID4g
PiB3ZSdyZSByZWFkeS4KPiA+ID4gPiAKPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMeXVkZSBQYXVs
IDxseXVkZUByZWRoYXQuY29tPgo+ID4gPiA+IEZpeGVzOiBjZDgyZDgyY2JjMDQgKCJkcm0vZHBf
bXN0OiBBZGQgYnJhbmNoIGJhbmR3aWR0aCB2YWxpZGF0aW9uIHRvCj4gPiA+ID4gTVNUCj4gPiA+
ID4gYXRvbWljIGNoZWNrIikKPiA+ID4gPiBDYzogTWlraXRhIExpcHNraSA8bWlraXRhLmxpcHNr
aUBhbWQuY29tPgo+ID4gPiA+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+Cj4gPiA+ID4gQ2M6IFNlYW4gUGF1bCA8c2VhbnBhdWxAZ29vZ2xlLmNvbT4KPiA+ID4g
PiBDYzogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4KPiA+ID4gPiAtLS0KPiA+
ID4gPiAgZHJpdmVycy9ncHUvZHJtL2RybV9kcF9tc3RfdG9wb2xvZ3kuYyB8IDEzICsrKysrKysr
KysrKysKPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykKPiA+ID4gPiAK
PiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV9kcF9tc3RfdG9wb2xvZ3ku
Ywo+ID4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL2RybV9kcF9tc3RfdG9wb2xvZ3kuYwo+ID4gPiA+
IGluZGV4IDIwN2VlZjA4ZDEyYy4uN2IwZmYwY2ZmOTU0IDEwMDY0NAo+ID4gPiA+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9kcm1fZHBfbXN0X3RvcG9sb2d5LmMKPiA+ID4gPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vZHJtX2RwX21zdF90b3BvbG9neS5jCj4gPiA+ID4gQEAgLTQwMzMsNiArNDAzMywx
OSBAQCBkcm1fZHBfbXN0X2RldGVjdF9wb3J0KHN0cnVjdCBkcm1fY29ubmVjdG9yCj4gPiA+ID4g
KmNvbm5lY3RvciwKPiA+ID4gPiAgCQkJcmV0ID0gY29ubmVjdG9yX3N0YXR1c19jb25uZWN0ZWQ7
Cj4gPiA+ID4gIAkJYnJlYWs7Cj4gPiA+ID4gIAl9Cj4gPiA+ID4gKwo+ID4gPiA+ICsJLyogV2Ug
ZG9uJ3Qgd2FudCB0byB0ZWxsIHVzZXJzcGFjZSB0aGUgcG9ydCBpcyBhY3R1YWxseQo+ID4gPiA+
IHBsdWdnZWQgaW50bwo+ID4gPiA+ICsJICogYW55dGhpbmcgdW50aWwgd2UndmUgZmluaXNoZWQg
cHJvYmluZyBpdCdzIGF2YWlsYWJsZV9wYm4sCj4gPiA+ID4gb3RoZXJ3aXNlCj4gPiA+IAo+ID4g
PiAiaXRzIgo+ID4gPiAKPiA+ID4gV2h5IGlzIHRoZSBjb25uZWN0b3IgZXZlbiByZWdpc3RlcmVk
IGJlZm9yZSB3ZSd2ZSBmaW5pc2hlZCB0aGUgcHJvYmU/Cj4gPiA+IAo+ID4gT29wcywgSSdtIG5v
dCBzdXJlIGhvdyBJIGRpZCB0aGlzIGJ5IGFjY2lkZW50IGJ1dCB0aGUgZXhwbGFuYXRpb24gSSBn
YXZlCj4gPiBpbgo+ID4gdGhlIGNvbW1pdCBtZXNzYWdlIHdhcyB1aCwgY29tcGxldGVseSB3cm9u
Zy4gSSBtdXN0IGhhdmUgZm9yZ290dGVuIHRoYXQgSQo+ID4gbWFkZQo+ID4gc3VyZSB3ZSBkaWRu
J3QgZXhwb3NlIGNvbm5lY3RvcnMgYmVmb3JlIHByb2JpbmcgdGhlaXIgUEJOIGJhY2sgd2hlbiBJ
Cj4gPiBzdGFydGVkCj4gPiBteSBNU1QgY2xlYW51cC4uLi4KPiA+IAo+ID4gU286IGRlc3BpdGUg
d2hhdCBJIHNhaWQgYmVmb3JlIGl0J3Mgbm90IGFjdHVhbGx5IHdoZW4gbmV3IGNvbm5lY3RvcnMg
YXJlCj4gPiBjcmVhdGVkLCBpdCdzIHdoZW4gZG93bnN0cmVhbSBob3RwbHVncyBoYXBwZW4gd2hp
Y2ggbWVhbnMgdGhhdCB0aGUKPiA+IGNvbmVuY3RvcidzCj4gPiBhbHdheXMgZ29pbmcgdG8gYmUg
dGhlcmUgYmVmb3JlIHdlIHByb2JlIHRoZSBhdmFpbGFibGVfcGJuLgo+IAo+IE5vdCBzdXJlIEkg
dW5kZXJzdGFuZC4gWW91J3JlIHNheWluZyB0aGlzIGlzIGdvaW5nIHRvIGNoYW5nZSBmb3IgYWxy
ZWFkeQo+IGV4aXN0aW5nIGNvbm5lY3RvcnMgd2hlbiBzb21ldGhpbmcgZWxzZSBnZXRzIHBsdWdn
ZWQgaW4sIGFuZCBlaXRoZXIgd2UKPiB6ZXJvIGl0IG91dCBkdXJpbmcgdGhlIHByb2JlIG9yIGl0
IGFsd2F5cyB3YXMgemVybyB0byBiZWdpbiB3aXRoIGZvcgo+IHdoYXRldmVyIHJlYXNvbj8KCm9r
LW1lIGFuZCBTZWFuIFBhdWwgZGlkIHNvbWUgcGxheWluZyBhcm91bmQgd2l0aCBhdmFpbGFibGVf
cGJuIGFuZCBmdWxsX3BibgooSSdsbCBnZXQgaW50byB0aGlzIG9uZSBpbiBhIG1vbWVudCksIGFu
ZCBJIGFsc28gcGxheWVkIGFyb3VuZCB3aXRoIGEgY291cGxlCm9mIGRpZmZlcmVudCBodWJzIGFu
ZCBoYXZlIGEgbXVjaCBiZXR0ZXIgdW5kZXJzdGFuZGluZyBvZiBob3cgdGhpcyBzaG91bGQgd29y
awpub3cuCgpTbzogZmlyc3Qgb2ZmIHRsO2RyIGF2YWlsYWJsZV9wYm4gaXMgYWJzb2x1dGVseSBu
b3Qgd2hhdCB3ZSB3YW50IGluIGJhc2ljYWxseQphbnkgc2NlbmFyaW8sIHdlIGFjdHVhbGx5IHdh
bnQgdG8gdXNlIHRoZSBmdWxsX3BibiBmaWVsZCB0aGF0IHdlIGdldCB3aGVuCnNlbmRpbmcgRU5V
TV9QQVRIX1JFU09VUkNFUy4gU2Vjb25kLCBmdWxsX3BibiByZXByZXNlbnRzIHRoZSBfc21hbGxl
c3RfIGJhbmR3aWR0aCBsaW1pdGF0aW9uIGVuY291bnRlcmVkIGluIHRoZSBwYXRoIGJldHdlZW4g
dGhlIHJvb3QgTVNUQiBhbmQgZWFjaCBjb25uZWN0ZWQgc2luay4gUmVtZW1iZXIgdGhhdCB0aGVy
ZSdzIHRlY2huaWNhbGx5IGEgRGlzcGxheVBvcnQgbGluayB0cmFpbmVkIGJldHdlZW4gZWFjaCBi
cmFuY2ggZGV2aWNlIGdvaW5nIGRvd24gdGhlIHRvcG9sb2d5LCBzbyB0aGF0IGJhbmR3aWR0aCBs
aW1pdGF0aW9uIGJhc2ljYWxseSBlcXVhdGVzIHRvICJ3aGF0IGlzIHRoZSBsb3dlc3QgdHJhaW5l
ZCBsaW5rIHJhdGUgdGhhdCBleGlzdHMgZG93biB0aGUgcGF0aCB0byB0aGlzIHBvcnQ/Ii4gVGhp
cyBhbHNvIG1lYW5zIHRoYXQgZnVsbF9wYm4gd2lsbCBwb3RlbnRpYWxseSBjaGFuZ2UgZXZlcnkg
dGltZSBhIG5ldyBjb25uZWN0b3IgaXMgcGx1Z2dlZCBpbiwgYXMgc29tZSBodWJzIHdpbGwgYmUg
Y2xldmVyIGFuZCBvcHRpbWl6ZSB0aGUgbGluayByYXRlIHRoZXkgZGVjaWRlIHRvIHVzZS4gTGlr
ZXdpc2UsIHNpbmNlIHRoZXJlJ3Mgbm90IGdvaW5nIHRvIGJlIGFueXRoaW5nIHRyYWluZWQgb24g
YSBkaXNjb25uZWN0ZWQgcG9ydCAoZS5nLiBkZHBzPTApIHRoZXJlJ3Mgbm8gcG9pbnQgaW4ga2Vl
cGluZyBmdWxsX3BibiBhcm91bmQgZm9yIGRpc2Nvbm5lY3RlZCBwb3J0cywgc2luY2Ugb3RoZXJ3
aXNlIHdlIG1pZ2h0IGxldCB1c2Vyc3BhY2Ugc2VlIGEgY29ubmVjdGVkIHBvcnQgd2l0aCBhIHN0
YWxlIGZ1bGxfcGJuIHZhbHVlLgoKU28tSU1ITyB0aGUgYmVoYXZpb3Igb2Ygbm90IGxldHRpbmcg
Y29ubmVjdG9ycyBzaG93IGFzIGNvbm5lY3RlZCB1bnRpbCB3ZSBhbHNvCmhhdmUgdGhlaXIgZnVs
bF9wYm4gcHJvYmVkIHNob3VsZCBkZWZpbml0ZWx5IGJlIHRoZSByaWdodCBzb2x1dGlvbiBoZXJl
LgpFc3BlY2lhbGx5IGlmIHdlIHdhbnQgdG8gZXZlbnR1YWxseSBzdGFydCBwcnVuaW5nIG1vZGVz
IGJhc2VkIG9uIGZ1bGxfcGJuIGF0CnNvbWUgcG9pbnQgaW4gdGhlIGZ1dHVyZS4KCj4gCj4gPiBJ
IGRpZCBqdXN0IG5vdGljZQo+ID4gdGhvdWdoIHRoYXQgd2Ugc2VuZCBhIGhvdHBsdWcgb24gY29u
bmVjdGlvbiBzdGF0dXMgbm90aWZpY2F0aW9ucyBldmVuCj4gPiBiZWZvcmUKPiA+IHdlJ3ZlIGZp
bmlzaGVkIHRoZSBQQk4gcHJvYmUsIHNvIEkgbWlnaHQgYmUgYWJsZSB0byBpbXByb3ZlIG9uIHRo
YXQgYXMKPiA+IHdlbGwuCj4gPiBXZSBzdGlsbCBkZWZpbml0ZWx5IHdhbnQgdG8gcmVwb3J0IHRo
ZSBjb25uZWN0b3IgYXMgZGlzY29ubmVjdGVkIGJlZm9yZSB3ZQo+ID4gaGF2ZSB0aGUgYXZhaWxh
YmxlIFBCTiB0aG91Z2gsIGluIGNhc2UgYW5vdGhlciBwcm9iZSB3YXMgYWxyZWFkeSBnb2luZwo+
ID4gYmVmb3JlCj4gPiB3ZSBnb3QgdGhlIGNvbm5lY3Rpb24gc3RhdHVzIG5vdGlmaWNhdGlvbi4K
PiA+IAo+ID4gSSdsbCBtYWtlIHN1cmUgdG8gZml4dXAgdGhlIGV4cGxhbmF0aW9uIGluIHRoZSBj
b21taXQgbWVzc2FnZSBvbiB0aGUgbmV4dAo+ID4gcmVzcGluCj4gPiAKPiA+ID4gPiArCSAqIHVz
ZXJzcGFjZSB3aWxsIHNlZSByYWN5IGF0b21pYyBjaGVjayBmYWlsdXJlcwo+ID4gPiA+ICsJICoK
PiA+ID4gPiArCSAqIFNpbmNlIHdlIGFsd2F5cyBzZW5kIGEgaG90cGx1ZyBhdCB0aGUgZW5kIG9m
IHByb2JpbmcKPiA+ID4gPiB0b3BvbG9neQo+ID4gPiA+ICsJICogc3RhdGUsIHdlIGNhbiBqdXN0
IGxldCB1c2Vyc3BhY2UgcmVwcm9iZSB0aGlzIGNvbm5lY3Rvcgo+ID4gPiA+IGxhdGVyLgo+ID4g
PiA+ICsJICovCj4gPiA+ID4gKwlpZiAocmV0ID09IGNvbm5lY3Rvcl9zdGF0dXNfY29ubmVjdGVk
ICYmICFwb3J0LT5hdmFpbGFibGVfcGJuKSAKPiA+ID4gPiB7Cj4gPiA+ID4gKwkJRFJNX0RFQlVH
X0tNUygiW0NPTk5FQ1RPUjolZDolc10gbm90IHJlYWR5IHlldCAoUEJOCj4gPiA+ID4gbm90Cj4g
PiA+ID4gcHJvYmVkKVxuIiwKPiA+ID4gPiArCQkJICAgICAgY29ubmVjdG9yLT5iYXNlLmlkLCBj
b25uZWN0b3ItPm5hbWUpOwo+ID4gPiA+ICsJCXJldCA9IGNvbm5lY3Rvcl9zdGF0dXNfZGlzY29u
bmVjdGVkOwo+ID4gPiA+ICsJfQo+ID4gPiA+ICBvdXQ6Cj4gPiA+ID4gIAlkcm1fZHBfbXN0X3Rv
cG9sb2d5X3B1dF9wb3J0KHBvcnQpOwo+ID4gPiA+ICAJcmV0dXJuIHJldDsKPiA+ID4gPiAtLSAK
PiA+ID4gPiAyLjI0LjEKPiA+ID4gPiAKPiA+ID4gPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+ID4gPiA+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiA+
ID4gPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gPiA+ID4gaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKPiA+IC0tIAo+ID4g
Q2hlZXJzLAo+ID4gCUx5dWRlIFBhdWwgKHNoZS9oZXIpCj4gPiAJQXNzb2NpYXRlIFNvZnR3YXJl
IEVuZ2luZWVyIGF0IFJlZCBIYXQKLS0gCkNoZWVycywKCUx5dWRlIFBhdWwgKHNoZS9oZXIpCglB
c3NvY2lhdGUgU29mdHdhcmUgRW5naW5lZXIgYXQgUmVkIEhhdAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
