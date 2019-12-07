Return-Path: <SRS0=HGq7=Z5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA64C43603
	for <amd-gfx@archiver.kernel.org>; Sat,  7 Dec 2019 00:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EA70217BA
	for <amd-gfx@archiver.kernel.org>; Sat,  7 Dec 2019 00:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA70217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEA326FAC4;
	Sat,  7 Dec 2019 00:53:00 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EE0B6FAC4
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 Dec 2019 00:52:59 +0000 (UTC)
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-CBljOCXDNxGEtTLg-DybKg-1; Fri, 06 Dec 2019 19:52:55 -0500
Received: by mail-qk1-f200.google.com with SMTP id m13so5656978qka.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Dec 2019 16:52:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=EpTMGXpiQetEcBu3AjsfsnTui8cGmEX6kXethwTiE2k=;
 b=dN3qWIpB8YIEM+FLnnS6lXs8qXKdCjE7cLjAMll9sTUfGnpK2gcuHgHyui0bWAYecu
 XMfZbJDiYYJw7NwYJpotNQojtDBsHmeAVD4EQLxOc6A9TiuvS2kG8FWJ5SXex2djrCrb
 VyIBmu66aGcBOoNVNRbrhHOjLqFp3ueCSBp9RgPYwRgnDp9YgYu1/bzWRnIRDJOye+iN
 hSn5QKZj7+9xO27ti6EuaI0m5JlZlI32t5gN5ifbasfKoXfR9LanZ7jM98nT/h3txvkV
 mMdxVnTs1Yi0aA3jPcBtl5HwP9gmdz/bIKCZC/JEjMHWhZ8kKMY32rd4eZwUBIK8q/9+
 8Kjw==
X-Gm-Message-State: APjAAAXFze926Q8HUYlOrhzDidGJu7yQ2FnwVzeOul9UY13Yf/NvD5ot
 V1W/QYiKYyFEuCd8fI+LbHHLF5Z+Kh5uQauUV87gVv8CRsVSbmrsq0jW/ztT/y8l4BixjJo/v2+
 xGSh8uz1bVjdboEdwhImD8ToO0w==
X-Received: by 2002:ac8:538d:: with SMTP id x13mr15859979qtp.375.1575679974632; 
 Fri, 06 Dec 2019 16:52:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqwaRbC9DcHCUKup/3elY5hvQscQ2mZyBWMXpRSLYUvlOMsjRmFQRnMMlBuUQ1HSh5znLRtr7Q==
X-Received: by 2002:ac8:538d:: with SMTP id x13mr15859967qtp.375.1575679974442; 
 Fri, 06 Dec 2019 16:52:54 -0800 (PST)
Received: from dhcp-10-20-1-90.bss.redhat.com ([144.121.20.162])
 by smtp.gmail.com with ESMTPSA id p188sm6504469qkb.94.2019.12.06.16.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2019 16:52:53 -0800 (PST)
Message-ID: <38c62a0d96c1368f22affd2d8a18eb6c78afee37.camel@redhat.com>
Subject: Re: [PATCH v8 15/17] drm/amd/display: Recalculate VCPI slots for
 new DSC connectors
From: Lyude Paul <lyude@redhat.com>
To: mikita.lipski@amd.com, amd-gfx@lists.freedesktop.org
Date: Fri, 06 Dec 2019 19:52:52 -0500
In-Reply-To: <20191203143530.27262-16-mikita.lipski@amd.com>
References: <20191203143530.27262-1-mikita.lipski@amd.com>
 <20191203143530.27262-16-mikita.lipski@amd.com>
Organization: Red Hat
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31)
MIME-Version: 1.0
X-MC-Unique: CBljOCXDNxGEtTLg-DybKg-1
X-Mimecast-Spam-Score: 0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1575679978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EpTMGXpiQetEcBu3AjsfsnTui8cGmEX6kXethwTiE2k=;
 b=eelOdPnJTbKsraIlWJ5MfHsFnq9AGHPTF1Mw3dt7yvLWSXRMVCtz2FWnduRtzP9MY6wM7T
 C/z7RgwaQOd2gosmbSl7PHsYq/KVMnYfs3PO+ys51VrhcxJH/e+TJB+KO7VUjVbYgtZY4+
 yPAO8WxHK9t3LMMWVouezlbga8JPBho=
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
Cc: Manasi Navare <manasi.d.navare@intel.com>, Jerry Zuo <Jerry.Zuo@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IEx5dWRlIFBhdWwgPGx5dWRlQHJlZGhhdC5jb20+CgpPbiBUdWUsIDIwMTkt
MTItMDMgYXQgMDk6MzUgLTA1MDAsIG1pa2l0YS5saXBza2lAYW1kLmNvbSB3cm90ZToKPiBGcm9t
OiBNaWtpdGEgTGlwc2tpIDxtaWtpdGEubGlwc2tpQGFtZC5jb20+Cj4gCj4gW3doeV0KPiBTaW5j
ZSBmb3IgRFNDIE1TVCBjb25uZWN0b3IncyBQQk4gaXMgY2xhY3VsYXRlZCBkaWZmZXJlbnRseQo+
IGR1ZSB0byBjb21wcmVzc2lvbiwgd2UgaGF2ZSB0byByZWNhbGN1bGF0ZSBib3RoIFBCTiBhbmQK
PiBWQ1BJIHNsb3RzIGZvciB0aGF0IGNvbm5lY3Rvci4KPiAKPiBbaG93XQo+IFRoZSBmdW5jdGlv
biBpdGVyYXRlcyB0aHJvdWdoIGFsbCB0aGUgYWN0aXZlIHN0cmVhbXMgdG8KPiBmaW5kLCB3aGlj
aCBoYXZlIERTQyBlbmFibGVkLCB0aGVuIHJlY2FsY3VsYXRlcyBQQk4gZm9yCj4gaXQgYW5kIGNh
bGxzIGRybV9kcF9oZWxwZXJfdXBkYXRlX3ZjcGlfc2xvdHNfZm9yX2RzYyB0bwo+IHVwZGF0ZSBj
b25uZWN0b3IncyBWQ1BJIHNsb3RzLgo+IAo+IHYyOiAtIHVzZSBkcm1fZHBfbXN0X2F0b21pY19l
bmFibGVfZHNjIHBlciBwb3J0IHRvCj4gZW5hYmxlL2Rpc2FibGUgRFNDCj4gCj4gdjM6IC0gSXRl
cmF0ZSB0aHJvdWdoIGNvbm5lY3RvciBzdGF0ZXMgZnJvbSB0aGUgc3RhdGUgcGFzc2VkCj4gICAg
IC0gT24gZWFjaCBjb25uZWN0b3Igc3RhdGUgZ2V0IHN0cmVhbSBmcm9tIGRjX3N0YXRlLAo+IGlu
c3RlYWQgQ1JUQyBzdGF0ZQo+IAo+IENjOiBKZXJyeSBadW8gPEplcnJ5Llp1b0BhbWQuY29tPgo+
IENjOiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KPiBDYzogTHl1ZGUg
UGF1bCA8bHl1ZGVAcmVkaGF0LmNvbT4KPiBDYzogTWFuYXNpIE5hdmFyZSA8bWFuYXNpLmQubmF2
YXJlQGludGVsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBNaWtpdGEgTGlwc2tpIDxtaWtpdGEubGlw
c2tpQGFtZC5jb20+Cj4gLS0tCj4gIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9h
bWRncHVfZG0uYyB8IDc2ICsrKysrKysrKysrKysrKysrLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDcx
IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiBpbmRleCA5M2EyMzBkOTU2
ZWUuLjJhYzNhMmYwYjQ1MiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+IEBAIC00OTg2LDYgKzQ5ODYsNjkgQEAgY29uc3Qg
c3RydWN0IGRybV9lbmNvZGVyX2hlbHBlcl9mdW5jcwo+IGFtZGdwdV9kbV9lbmNvZGVyX2hlbHBl
cl9mdW5jcyA9IHsKPiAgCS5hdG9taWNfY2hlY2sgPSBkbV9lbmNvZGVyX2hlbHBlcl9hdG9taWNf
Y2hlY2sKPiAgfTsKPiAgCj4gK3N0YXRpYyBpbnQgZG1fdXBkYXRlX21zdF92Y3BpX3Nsb3RzX2Zv
cl9kc2Moc3RydWN0IGRybV9hdG9taWNfc3RhdGUgKnN0YXRlLAo+ICsJCQkJCSAgICBzdHJ1Y3Qg
ZGNfc3RhdGUgKmRjX3N0YXRlKQo+ICt7Cj4gKwlzdHJ1Y3QgZGNfc3RyZWFtX3N0YXRlICpzdHJl
YW0gPSBOVUxMOwo+ICsJc3RydWN0IGRybV9jb25uZWN0b3IgKmNvbm5lY3RvcjsKPiArCXN0cnVj
dCBkcm1fY29ubmVjdG9yX3N0YXRlICpuZXdfY29uX3N0YXRlLCAqb2xkX2Nvbl9zdGF0ZTsKPiAr
CXN0cnVjdCBhbWRncHVfZG1fY29ubmVjdG9yICphY29ubmVjdG9yOwo+ICsJc3RydWN0IGRtX2Nv
bm5lY3Rvcl9zdGF0ZSAqZG1fY29ubl9zdGF0ZTsKPiArCWludCBpLCBqLCBjbG9jaywgYnBwOwo+
ICsJaW50IHZjcGksIHBibl9kaXYsIHBibiA9IDA7Cj4gKwo+ICsJZm9yX2VhY2hfb2xkbmV3X2Nv
bm5lY3Rvcl9pbl9zdGF0ZShzdGF0ZSwgY29ubmVjdG9yLCBvbGRfY29uX3N0YXRlLAo+IG5ld19j
b25fc3RhdGUsIGkpIHsKPiArCj4gKwkJYWNvbm5lY3RvciA9IHRvX2FtZGdwdV9kbV9jb25uZWN0
b3IoY29ubmVjdG9yKTsKPiArCj4gKwkJaWYgKCFhY29ubmVjdG9yLT5wb3J0KQo+ICsJCQljb250
aW51ZTsKPiArCj4gKwkJaWYgKCFuZXdfY29uX3N0YXRlIHx8ICFuZXdfY29uX3N0YXRlLT5jcnRj
KQo+ICsJCQljb250aW51ZTsKPiArCj4gKwkJZG1fY29ubl9zdGF0ZSA9IHRvX2RtX2Nvbm5lY3Rv
cl9zdGF0ZShuZXdfY29uX3N0YXRlKTsKPiArCj4gKwkJZm9yIChqID0gMDsgaiA8IGRjX3N0YXRl
LT5zdHJlYW1fY291bnQ7IGorKykgewo+ICsJCQlzdHJlYW0gPSBkY19zdGF0ZS0+c3RyZWFtc1tq
XTsKPiArCQkJaWYgKCFzdHJlYW0pCj4gKwkJCQljb250aW51ZTsKPiArCj4gKwkJCWlmICgoc3Ry
dWN0IGFtZGdwdV9kbV9jb25uZWN0b3IqKXN0cmVhbS0KPiA+ZG1fc3RyZWFtX2NvbnRleHQgPT0g
YWNvbm5lY3RvcikKPiArCQkJCWJyZWFrOwo+ICsKPiArCQkJc3RyZWFtID0gTlVMTDsKPiArCQl9
Cj4gKwo+ICsJCWlmICghc3RyZWFtKQo+ICsJCQljb250aW51ZTsKPiArCj4gKwkJaWYgKHN0cmVh
bS0+dGltaW5nLmZsYWdzLkRTQyAhPSAxKSB7Cj4gKwkJCWRybV9kcF9tc3RfYXRvbWljX2VuYWJs
ZV9kc2Moc3RhdGUsCj4gKwkJCQkJCSAgICAgYWNvbm5lY3Rvci0+cG9ydCwKPiArCQkJCQkJICAg
ICBkbV9jb25uX3N0YXRlLT5wYm4sCj4gKwkJCQkJCSAgICAgMCwKPiArCQkJCQkJICAgICBmYWxz
ZSk7Cj4gKwkJCWNvbnRpbnVlOwo+ICsJCX0KPiArCj4gKwkJcGJuX2RpdiA9IGRtX21zdF9nZXRf
cGJuX2RpdmlkZXIoc3RyZWFtLT5saW5rKTsKPiArCQlicHAgPSBzdHJlYW0tPnRpbWluZy5kc2Nf
Y2ZnLmJpdHNfcGVyX3BpeGVsOwo+ICsJCWNsb2NrID0gc3RyZWFtLT50aW1pbmcucGl4X2Nsa18x
MDBoeiAvIDEwOwo+ICsJCXBibiA9IGRybV9kcF9jYWxjX3Bibl9tb2RlKGNsb2NrLCBicHAsIHRy
dWUpOwo+ICsJCXZjcGkgPSBkcm1fZHBfbXN0X2F0b21pY19lbmFibGVfZHNjKHN0YXRlLAo+ICsJ
CQkJCQkgICAgYWNvbm5lY3Rvci0+cG9ydCwKPiArCQkJCQkJICAgIHBibiwgcGJuX2RpdiwKPiAr
CQkJCQkJICAgIHRydWUpOwo+ICsJCWlmICh2Y3BpIDwgMCkKPiArCQkJcmV0dXJuIHZjcGk7Cj4g
Kwo+ICsJCWRtX2Nvbm5fc3RhdGUtPnBibiA9IHBibjsKPiArCQlkbV9jb25uX3N0YXRlLT52Y3Bp
X3Nsb3RzID0gdmNwaTsKPiArCX0KPiArCXJldHVybiAwOwo+ICt9Cj4gKwo+ICBzdGF0aWMgdm9p
ZCBkbV9kcm1fcGxhbmVfcmVzZXQoc3RydWN0IGRybV9wbGFuZSAqcGxhbmUpCj4gIHsKPiAgCXN0
cnVjdCBkbV9wbGFuZV9zdGF0ZSAqYW1kZ3B1X3N0YXRlID0gTlVMTDsKPiBAQCAtODAyMiwxMSAr
ODA4NSw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RtX2F0b21pY19jaGVjayhzdHJ1Y3QgZHJtX2Rl
dmljZQo+ICpkZXYsCj4gIAlpZiAocmV0KQo+ICAJCWdvdG8gZmFpbDsKPiAgCj4gLQkvKiBQZXJm
b3JtIHZhbGlkYXRpb24gb2YgTVNUIHRvcG9sb2d5IGluIHRoZSBzdGF0ZSovCj4gLQlyZXQgPSBk
cm1fZHBfbXN0X2F0b21pY19jaGVjayhzdGF0ZSk7Cj4gLQlpZiAocmV0KQo+IC0JCWdvdG8gZmFp
bDsKPiAtCj4gIAlpZiAoc3RhdGUtPmxlZ2FjeV9jdXJzb3JfdXBkYXRlKSB7Cj4gIAkJLyoKPiAg
CQkgKiBUaGlzIGlzIGEgZmFzdCBjdXJzb3IgdXBkYXRlIGNvbWluZyBmcm9tIHRoZSBwbGFuZSB1
cGRhdGUKPiBAQCAtODA5OCw2ICs4MTU2LDEwIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RtX2F0b21p
Y19jaGVjayhzdHJ1Y3QgZHJtX2RldmljZQo+ICpkZXYsCj4gIAkJaWYgKCFjb21wdXRlX21zdF9k
c2NfY29uZmlnc19mb3Jfc3RhdGUoc3RhdGUsIGRtX3N0YXRlLQo+ID5jb250ZXh0KSkKPiAgCQkJ
Z290byBmYWlsOwo+ICAKPiArCQlyZXQgPSBkbV91cGRhdGVfbXN0X3ZjcGlfc2xvdHNfZm9yX2Rz
YyhzdGF0ZSwgZG1fc3RhdGUtCj4gPmNvbnRleHQpOwo+ICsJCWlmIChyZXQpCj4gKwkJCWdvdG8g
ZmFpbDsKPiArCj4gIAkJaWYgKGRjX3ZhbGlkYXRlX2dsb2JhbF9zdGF0ZShkYywgZG1fc3RhdGUt
PmNvbnRleHQsIGZhbHNlKSAhPQo+IERDX09LKSB7Cj4gIAkJCXJldCA9IC1FSU5WQUw7Cj4gIAkJ
CWdvdG8gZmFpbDsKPiBAQCAtODEyNiw2ICs4MTg4LDEwIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2Rt
X2F0b21pY19jaGVjayhzdHJ1Y3QgZHJtX2RldmljZQo+ICpkZXYsCj4gIAkJCQlkY19yZXRhaW5f
c3RhdGUob2xkX2RtX3N0YXRlLT5jb250ZXh0KTsKPiAgCQl9Cj4gIAl9Cj4gKwkvKiBQZXJmb3Jt
IHZhbGlkYXRpb24gb2YgTVNUIHRvcG9sb2d5IGluIHRoZSBzdGF0ZSovCj4gKwlyZXQgPSBkcm1f
ZHBfbXN0X2F0b21pY19jaGVjayhzdGF0ZSk7Cj4gKwlpZiAocmV0KQo+ICsJCWdvdG8gZmFpbDsK
PiAgCj4gIAkvKiBTdG9yZSB0aGUgb3ZlcmFsbCB1cGRhdGUgdHlwZSBmb3IgdXNlIGxhdGVyIGlu
IGF0b21pYyBjaGVjay4gKi8KPiAgCWZvcl9lYWNoX25ld19jcnRjX2luX3N0YXRlIChzdGF0ZSwg
Y3J0YywgbmV3X2NydGNfc3RhdGUsIGkpIHsKLS0gCkNoZWVycywKCUx5dWRlIFBhdWwKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
