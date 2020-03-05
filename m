Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6D8C3F2D2
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 18:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80100208C3
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 18:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4ErbfGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80100208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0805D6E384;
	Thu,  5 Mar 2020 18:13:55 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90CF26E347
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 18:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583432032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HuMESBJWe38jYi16HvIP1cqqRhUUWga6fVgi2gwWClQ=;
 b=R4ErbfGCpHtQZGMwHGJ93MUSoHOSCVeAEq86Gq7/LkpBzSDk3TmUG7N4nJIKZO2YJrjnKR
 D7IwiQkW1I/F9+vCe1kU7nduB6HcSe8p7K9V+ejDvtLYymlgu69ZgvGSE19DpNNbfaWk5z
 /s1YZahvJ8dPjeWcpwBOrPXnNTFj6aU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-t26GIo7EPTKzxz7PUiKxCA-1; Thu, 05 Mar 2020 13:13:46 -0500
X-MC-Unique: t26GIo7EPTKzxz7PUiKxCA-1
Received: by mail-qk1-f197.google.com with SMTP id l27so4403019qkl.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Mar 2020 10:13:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=CISWnYCTgIHs8Q99tWvsNfg16hI8DJbFk1pD+36Cny4=;
 b=UV4taEH+pi239g29p/5+SnksTyZppjSf2FON74lSfQlzQoWeDNuzh8ud6jdTbYW+jz
 SSDq6WU0g6I0AmQep13JRMkLLesPn0i+CqT2rn3y59mSwb4vhM4rNKohEnfC8m3frIju
 4r4pirp9ZQHO/ZG+M2oU0X3tf5g9Vy3A7iD3Pd2B17CFGlIm7kZ5qGomwo4iXIeG44SU
 3iEP9xdwhr1Accx6RXBHQiCuO45c7rBOv4Zk2/Y+KtzoSZ/8fISaPFa2dKHARY4LMHEI
 1PafsOOxgShrRxLErLlz6PiJ5JpjyilOFa/shEaToNKXy5hapn1o009HMOQLIaOMyumv
 hacQ==
X-Gm-Message-State: ANhLgQ3kpETecOmbOXif5glofQyJ24RSBNWwMDoadvR52vV0xaQWtn3/
 KcVVgFlHew1kihL18fLDpFFXouFakEuQ1Xua9Uhb26EbTurRwLIe1MfJje6RL7dfy0/x6JDBllT
 4TU2UZqpVuIZZ5Z/B6lE8PcGXIA==
X-Received: by 2002:a37:e47:: with SMTP id 68mr8996563qko.17.1583432026349;
 Thu, 05 Mar 2020 10:13:46 -0800 (PST)
X-Google-Smtp-Source: ADFU+vu9Di0TJjle9QFCxhPtgKkfebQZ/w1X7INadpj/G0J6OCnioF3WigU5h2qVIMfKm/UJg8NJJg==
X-Received: by 2002:a37:e47:: with SMTP id 68mr8996532qko.17.1583432026089;
 Thu, 05 Mar 2020 10:13:46 -0800 (PST)
Received: from Ruby ([172.58.220.228])
 by smtp.gmail.com with ESMTPSA id z19sm2921705qts.86.2020.03.05.10.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 10:13:45 -0800 (PST)
Message-ID: <73f52c392431cd21a80a118dd2fd1986e2c535df.camel@redhat.com>
Subject: Re: [PATCH 2/3] drm/dp_mst: Don't show connectors as connected
 before probing available PBN
From: Lyude Paul <lyude@redhat.com>
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Date: Thu, 05 Mar 2020 13:13:36 -0500
In-Reply-To: <20200305131119.GJ13686@intel.com>
References: <20200304223614.312023-1-lyude@redhat.com>
 <20200304223614.312023-3-lyude@redhat.com>
 <20200305131119.GJ13686@intel.com>
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

T24gVGh1LCAyMDIwLTAzLTA1IGF0IDE1OjExICswMjAwLCBWaWxsZSBTeXJqw6Rsw6Qgd3JvdGU6
Cj4gT24gV2VkLCBNYXIgMDQsIDIwMjAgYXQgMDU6MzY6MTJQTSAtMDUwMCwgTHl1ZGUgUGF1bCB3
cm90ZToKPiA+IEl0J3MgbmV4dCB0byBpbXBvc3NpYmxlIGZvciB1cyB0byBkbyBjb25uZWN0b3Ig
cHJvYmluZyBvbiB0b3BvbG9naWVzCj4gPiB3aXRob3V0IG9jY2FzaW9uYWxseSByYWNpbmcgd2l0
aCB1c2Vyc3BhY2UsIHNpbmNlIGNyZWF0aW5nIGEgY29ubmVjdG9yCj4gPiBpdHNlbGYgY2F1c2Vz
IGEgaG90cGx1ZyBldmVudCB3aGljaCB3ZSBoYXZlIHRvIHNlbmQgYmVmb3JlIHByb2JpbmcgdGhl
Cj4gPiBhdmFpbGFibGUgUEJOIG9mIGEgY29ubmVjdG9yLiBFdmVuIGlmIHdlIGRpZG4ndCBoYXZl
IHRoaXMgaG90cGx1ZyBldmVudAo+ID4gc2VudCwgdGhlcmUncyBzdGlsbCBhbHdheXMgYSBjaGFu
Y2UgdGhhdCB1c2Vyc3BhY2Ugc3RhcnRlZCBwcm9iaW5nCj4gPiBjb25uZWN0b3JzIGJlZm9yZSB3
ZSBmaW5pc2hlZCBwcm9iaW5nIHRoZSB0b3BvbG9neS4KPiA+IAo+ID4gVGhpcyBjYW4gYmUgYSBw
cm9ibGVtIHdoZW4gdmFsaWRhdGluZyBhIG5ldyBNU1Qgc3RhdGUgc2luY2UgdGhlCj4gPiBjb25u
ZWN0b3Igd2lsbCBiZSBzaG93biBhcyBjb25uZWN0ZWQgYnJpZWZseSwgYnV0IHdpdGhvdXQgYW55
IGF2YWlsYWJsZQo+ID4gUEJOIC0gY2F1c2luZyBhbnkgYXRvbWljIHN0YXRlIHdoaWNoIHdvdWxk
IGVuYWJsZSBzYWlkIGNvbm5lY3RvciB0byBmYWlsCj4gPiB3aXRoIC1FTk9TUEMuIFNvLCBsZXQn
cyBzaW1wbHkgd29ya2Fyb3VuZCB0aGlzIGJ5IHRlbGxpbmcgdXNlcnNwYWNlIG5ldwo+ID4gTVNU
IGNvbm5lY3RvcnMgYXJlIGRpc2Nvbm5lY3RlZCB1bnRpbCB3ZSd2ZSBmaW5pc2hlZCBwcm9iaW5n
IHRoZWlyIFBCTi4KPiA+IFNpbmNlIHdlIGFsd2F5cyBzZW5kIGEgaG90cGx1ZyBldmVudCBhdCB0
aGUgZW5kIG9mIHRoZSBsaW5rIGFkZHJlc3MKPiA+IHByb2JpbmcgcHJvY2VzcywgdXNlcnNwYWNl
IHdpbGwgc3RpbGwga25vdyB0byByZXByb2JlIHRoZSBjb25uZWN0b3Igd2hlbgo+ID4gd2UncmUg
cmVhZHkuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IEx5dWRlIFBhdWwgPGx5dWRlQHJlZGhhdC5j
b20+Cj4gPiBGaXhlczogY2Q4MmQ4MmNiYzA0ICgiZHJtL2RwX21zdDogQWRkIGJyYW5jaCBiYW5k
d2lkdGggdmFsaWRhdGlvbiB0byBNU1QKPiA+IGF0b21pYyBjaGVjayIpCj4gPiBDYzogTWlraXRh
IExpcHNraSA8bWlraXRhLmxpcHNraUBhbWQuY29tPgo+ID4gQ2M6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiA+IENjOiBTZWFuIFBhdWwgPHNlYW5wYXVsQGdvb2ds
ZS5jb20+Cj4gPiBDYzogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4KPiA+IC0t
LQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9kcm1fZHBfbXN0X3RvcG9sb2d5LmMgfCAxMyArKysrKysr
KysrKysrCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykKPiA+IAo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZHBfbXN0X3RvcG9sb2d5LmMKPiA+IGIvZHJp
dmVycy9ncHUvZHJtL2RybV9kcF9tc3RfdG9wb2xvZ3kuYwo+ID4gaW5kZXggMjA3ZWVmMDhkMTJj
Li43YjBmZjBjZmY5NTQgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2RwX21z
dF90b3BvbG9neS5jCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2RwX21zdF90b3BvbG9n
eS5jCj4gPiBAQCAtNDAzMyw2ICs0MDMzLDE5IEBAIGRybV9kcF9tc3RfZGV0ZWN0X3BvcnQoc3Ry
dWN0IGRybV9jb25uZWN0b3IKPiA+ICpjb25uZWN0b3IsCj4gPiAgCQkJcmV0ID0gY29ubmVjdG9y
X3N0YXR1c19jb25uZWN0ZWQ7Cj4gPiAgCQlicmVhazsKPiA+ICAJfQo+ID4gKwo+ID4gKwkvKiBX
ZSBkb24ndCB3YW50IHRvIHRlbGwgdXNlcnNwYWNlIHRoZSBwb3J0IGlzIGFjdHVhbGx5IHBsdWdn
ZWQgaW50bwo+ID4gKwkgKiBhbnl0aGluZyB1bnRpbCB3ZSd2ZSBmaW5pc2hlZCBwcm9iaW5nIGl0
J3MgYXZhaWxhYmxlX3Bibiwgb3RoZXJ3aXNlCj4gCj4gIml0cyIKPiAKPiBXaHkgaXMgdGhlIGNv
bm5lY3RvciBldmVuIHJlZ2lzdGVyZWQgYmVmb3JlIHdlJ3ZlIGZpbmlzaGVkIHRoZSBwcm9iZT8K
PiAKT29wcywgSSdtIG5vdCBzdXJlIGhvdyBJIGRpZCB0aGlzIGJ5IGFjY2lkZW50IGJ1dCB0aGUg
ZXhwbGFuYXRpb24gSSBnYXZlIGluCnRoZSBjb21taXQgbWVzc2FnZSB3YXMgdWgsIGNvbXBsZXRl
bHkgd3JvbmcuIEkgbXVzdCBoYXZlIGZvcmdvdHRlbiB0aGF0IEkgbWFkZQpzdXJlIHdlIGRpZG4n
dCBleHBvc2UgY29ubmVjdG9ycyBiZWZvcmUgcHJvYmluZyB0aGVpciBQQk4gYmFjayB3aGVuIEkg
c3RhcnRlZApteSBNU1QgY2xlYW51cC4uLi4KClNvOiBkZXNwaXRlIHdoYXQgSSBzYWlkIGJlZm9y
ZSBpdCdzIG5vdCBhY3R1YWxseSB3aGVuIG5ldyBjb25uZWN0b3JzIGFyZQpjcmVhdGVkLCBpdCdz
IHdoZW4gZG93bnN0cmVhbSBob3RwbHVncyBoYXBwZW4gd2hpY2ggbWVhbnMgdGhhdCB0aGUgY29u
ZW5jdG9yJ3MKYWx3YXlzIGdvaW5nIHRvIGJlIHRoZXJlIGJlZm9yZSB3ZSBwcm9iZSB0aGUgYXZh
aWxhYmxlX3Bibi4gSSBkaWQganVzdCBub3RpY2UKdGhvdWdoIHRoYXQgd2Ugc2VuZCBhIGhvdHBs
dWcgb24gY29ubmVjdGlvbiBzdGF0dXMgbm90aWZpY2F0aW9ucyBldmVuIGJlZm9yZQp3ZSd2ZSBm
aW5pc2hlZCB0aGUgUEJOIHByb2JlLCBzbyBJIG1pZ2h0IGJlIGFibGUgdG8gaW1wcm92ZSBvbiB0
aGF0IGFzIHdlbGwuCldlIHN0aWxsIGRlZmluaXRlbHkgd2FudCB0byByZXBvcnQgdGhlIGNvbm5l
Y3RvciBhcyBkaXNjb25uZWN0ZWQgYmVmb3JlIHdlCmhhdmUgdGhlIGF2YWlsYWJsZSBQQk4gdGhv
dWdoLCBpbiBjYXNlIGFub3RoZXIgcHJvYmUgd2FzIGFscmVhZHkgZ29pbmcgYmVmb3JlCndlIGdv
dCB0aGUgY29ubmVjdGlvbiBzdGF0dXMgbm90aWZpY2F0aW9uLgoKSSdsbCBtYWtlIHN1cmUgdG8g
Zml4dXAgdGhlIGV4cGxhbmF0aW9uIGluIHRoZSBjb21taXQgbWVzc2FnZSBvbiB0aGUgbmV4dApy
ZXNwaW4KCj4gPiArCSAqIHVzZXJzcGFjZSB3aWxsIHNlZSByYWN5IGF0b21pYyBjaGVjayBmYWls
dXJlcwo+ID4gKwkgKgo+ID4gKwkgKiBTaW5jZSB3ZSBhbHdheXMgc2VuZCBhIGhvdHBsdWcgYXQg
dGhlIGVuZCBvZiBwcm9iaW5nIHRvcG9sb2d5Cj4gPiArCSAqIHN0YXRlLCB3ZSBjYW4ganVzdCBs
ZXQgdXNlcnNwYWNlIHJlcHJvYmUgdGhpcyBjb25uZWN0b3IgbGF0ZXIuCj4gPiArCSAqLwo+ID4g
KwlpZiAocmV0ID09IGNvbm5lY3Rvcl9zdGF0dXNfY29ubmVjdGVkICYmICFwb3J0LT5hdmFpbGFi
bGVfcGJuKSB7Cj4gPiArCQlEUk1fREVCVUdfS01TKCJbQ09OTkVDVE9SOiVkOiVzXSBub3QgcmVh
ZHkgeWV0IChQQk4gbm90Cj4gPiBwcm9iZWQpXG4iLAo+ID4gKwkJCSAgICAgIGNvbm5lY3Rvci0+
YmFzZS5pZCwgY29ubmVjdG9yLT5uYW1lKTsKPiA+ICsJCXJldCA9IGNvbm5lY3Rvcl9zdGF0dXNf
ZGlzY29ubmVjdGVkOwo+ID4gKwl9Cj4gPiAgb3V0Ogo+ID4gIAlkcm1fZHBfbXN0X3RvcG9sb2d5
X3B1dF9wb3J0KHBvcnQpOwo+ID4gIAlyZXR1cm4gcmV0Owo+ID4gLS0gCj4gPiAyLjI0LjEKPiA+
IAo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiA+
IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiA+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKPiA+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJp
LWRldmVsCi0tIApDaGVlcnMsCglMeXVkZSBQYXVsIChzaGUvaGVyKQoJQXNzb2NpYXRlIFNvZnR3
YXJlIEVuZ2luZWVyIGF0IFJlZCBIYXQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
