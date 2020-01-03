Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A966BC00523
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 22:02:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F381222C3
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 22:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiebA5FW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F381222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33E1C6E351;
	Fri,  3 Jan 2020 22:02:10 +0000 (UTC)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D4056E351
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 22:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578088926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NKDiGChBX2Khe1oF0+NUrbE3DPEmSvpa4U6MQ3MUFTo=;
 b=PiebA5FWGBplLcZPewIsAEJ3jbdeYbltSK6WDQh3qKn8uOhvnmtHZwyUQaFQaGWfa24ZH4
 Sg6BGjfY1QY5Ge6C8v00ba4abXAU3Wu7jGBCYytJp2280FdrNJj6eNocbDtYf4urztHPmH
 QcSDu6FdDJwOocHKIJewW5UfUDWivYE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-AzrR2FHnN6ac5rEUPLvP3w-1; Fri, 03 Jan 2020 17:02:02 -0500
Received: by mail-qt1-f197.google.com with SMTP id b14so2895122qtt.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Jan 2020 14:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=NbgRWeKkmMRYJFDge4YC+wmlH5ur2rHgXJlYcu20mgI=;
 b=rOvicVLqOL+aLArCKU040gdhFUnRjvWwnYryUOoDRPJXPiBHObQTANO98ariz/vECO
 B34FGiRaeIlkhBIa5Zx4p1Do3m/nOMOcMdb1j0l3EUwOZlkrC+YyVrJI67LRYwnPLtlv
 W63g1Y5Zvx1rPMMHLh7Y6eog4v2CGg0AT7YvC0wsHJ5WKqZKtUDwmk9Ee4u93GmEHbMx
 63jmUFKsT0hGmtEZsqGrS+qFabqWIEA8rS2E+nxnizuUvLXW5r7QQUijdA/xdseJFdtN
 K3rxjwIaET41Ict/f1eM0xZqd4skeOhr7ylYzAv+mtG8tvW41cqytGopocTGWsy17/mB
 ZuYA==
X-Gm-Message-State: APjAAAUG2+xnev2o0UXfc/fIWVlZX8dnUwTHUeUzS+yoDh/mZOvZ23xL
 0TML1HfrxK941JJJbZUcx4amNYtPo9IANEyctJY8l37blW/TImRPnVwq31adcKjq5y5ATl9ZMES
 d90YChiysnJmugSJz0JyFHKg6zw==
X-Received: by 2002:a05:620a:149b:: with SMTP id
 w27mr75833055qkj.229.1578088921521; 
 Fri, 03 Jan 2020 14:02:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqwUfluq+PONcyFVBW01zMor1T71CL92M508ZrAS/HbYc2deWYqv4kGb1B3Nm/MuWgb9dmHJIw==
X-Received: by 2002:a05:620a:149b:: with SMTP id
 w27mr75833026qkj.229.1578088921277; 
 Fri, 03 Jan 2020 14:02:01 -0800 (PST)
Received: from dhcp-10-20-1-90.bss.redhat.com ([144.121.20.162])
 by smtp.gmail.com with ESMTPSA id n129sm17234952qkf.64.2020.01.03.14.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2020 14:02:00 -0800 (PST)
Message-ID: <246412a450f123e0bbc29c6feb68513cdce2c576.camel@redhat.com>
Subject: Re: [PATCH v2] drm/dp_mst: correct the shifting in DP_REMOTE_I2C_READ
From: Lyude Paul <lyude@redhat.com>
To: Wayne Lin <Wayne.Lin@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Date: Fri, 03 Jan 2020 17:01:59 -0500
In-Reply-To: <20200103055001.10287-1-Wayne.Lin@amd.com>
References: <20200103055001.10287-1-Wayne.Lin@amd.com>
Organization: Red Hat
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31)
MIME-Version: 1.0
X-MC-Unique: AzrR2FHnN6ac5rEUPLvP3w-1
X-Mimecast-Spam-Score: 0
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
Cc: jerry.zuo@amd.com, harry.wentland@amd.com, Nicholas.Kazlauskas@amd.com,
 stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T2ghIEp1c3QgYSBmcmllbmRseSB0aXAsIEkgZml4ZWQgdGhpcyBiZWZvcmUgcHVzaGluZyB5b3Vy
IHBhdGNoOgoK4p6cICBkcm0tbWFpbnQgZ2l0Oihkcm0tbWlzYy1maXhlcykgZGltIHB1c2gKZGlt
OiAwYjFkNTRjZWRiYjQgKCJkcm0vZHBfbXN0OiBjb3JyZWN0IHRoZSBzaGlmdGluZyBpbiBEUF9S
RU1PVEVfSTJDX1JFQUQiKTogRml4ZXM6IFNIQTEgbmVlZHMgYXQgbGVhc3QgMTIgZGlnaXRzOgpk
aW06ICAgICBhZDdmOGExZjljZSAoZHJtL2hlbHBlcjogYWRkIERpc3BsYXlwb3J0IG11bHRpLXN0
cmVhbSBoZWxwZXIgKHYwLjYpKQpkaW06IEVSUk9SOiBpc3N1ZXMgaW4gY29tbWl0cyBkZXRlY3Rl
ZCwgYWJvcnRpbmcKCkZvciB0aGUgZnV0dXJlLCB3ZSBoYXZlIGEgc2V0IG9mIERSTSBtYWludGFp
bmVyIHRvb2xzICh0aGV5J3JlIHF1aXRlIHVzZWZ1bApmb3IgcGVvcGxlIHdobyBhcmVuJ3QgbWFp
bnRhaW5lcnMgdGhvdWdoISkgdGhhdCB5b3UgY2FuIHVzZSB0byBtYWtlIHN1cmUgeW91cgpwYXRj
aCBpcyBmb3JtYXR0ZWQgY29ycmVjdGx5IGFoZWFkIG9mIHRpbWU6CgpodHRwczovL2RybS5wYWdl
cy5mcmVlZGVza3RvcC5vcmcvbWFpbnRhaW5lci10b29scy9kaW0uaHRtbAoKUGFydGljdWxhcmx5
IHVzZWZ1bCBjb21tYW5kczoKICogZGltIHNwYXJzZSAjIENoZWNrcyBmb3IgdHJpdmlhbCBjb2Rl
IGlzc3VlcywgbGlrZSBzZXQgYnV0IHVudXNlZCB2YXJpYWJsZXMKICogZGltIGNoZWNrcGF0Y2gg
IyBDaGVja3MgZm9yIGNvZGUgc3R5bGUgaXNzdWVzCiAqIGRpbSBmaXhlcyAkQ09NTUlUX0lEICMg
QWRkcyBhbiBhcHByb3ByaWF0ZWx5IGZvcm1hdHRlZCBGaXhlczogdGFnCiAqIGRpbSBjaXRlICRD
T01NSVRfSUQgIyBBZGRzIGFuIGFwcHJvcHJpYXRlbHkgZm9ybWF0dGVkIFJlZmVyZW5jZTogdGFn
CgpPbiBGcmksIDIwMjAtMDEtMDMgYXQgMTM6NTAgKzA4MDAsIFdheW5lIExpbiB3cm90ZToKPiBb
V2h5XQo+IEFjY29yZGluZyB0byBEUCBzcGVjLCBpdCBzaG91bGQgc2hpZnQgbGVmdCA0IGRpZ2l0
cyBmb3IgTk9fU1RPUF9CSVQKPiBpbiBSRU1PVEVfSTJDX1JFQUQgbWVzc2FnZS4gTm90IDUgZGln
aXRzLgo+IAo+IEluIGN1cnJlbnQgY29kZSwgTk9fU1RPUF9CSVQgaXMgYWx3YXlzIHNldCB0byB6
ZXJvIHdoaWNoIG1lYW5zIEkyQwo+IG1hc3RlciBpcyBhbHdheXMgZ2VuZXJhdGluZyBhIEkyQyBz
dG9wIGF0IHRoZSBlbmQgb2YgZWFjaCBJMkMgd3JpdGUKPiB0cmFuc2FjdGlvbiB3aGlsZSBoYW5k
bGluZyBSRU1PVEVfSTJDX1JFQUQgc2lkZWJhbmQgbWVzc2FnZS4gVGhpcyBpc3N1ZQo+IG1pZ2h0
IGhhdmUgdGhlIGdlbmVyYXRlZCBJMkMgc2lnbmFsIG5vdCBtZWV0aW5nIHRoZSByZXF1aXJlbWVu
dC4gVGFrZQo+IHJhbmRvbSByZWFkIGluIEkyQyBmb3IgaW5zdGFuY2UsIEkyQyBtYXN0ZXIgc2hv
dWxkIGdlbmVyYXRlIGEgcmVwZWF0Cj4gc3RhcnQgdG8gc3RhcnQgdG8gcmVhZCBkYXRhIGFmdGVy
IHdyaXRpbmcgdGhlIHJlYWQgYWRkcmVzcy4gVGhpcyBpc3N1ZQo+IHdpbGwgY2F1c2UgdGhlIEky
QyBtYXN0ZXIgdG8gZ2VuZXJhdGUgYSBzdG9wLXN0YXJ0IHJhdGhlciB0aGFuIGEKPiByZS1zdGFy
dCB3aGljaCBpcyBub3QgZXhwZWN0ZWQgaW4gSTJDIHJhbmRvbSByZWFkLgo+IAo+IFtIb3ddCj4g
Q29ycmVjdCB0aGUgc2hpZnRpbmcgdmFsdWUgb2YgTk9fU1RPUF9CSVQgZm9yIERQX1JFTU9URV9J
MkNfUkVBRCBjYXNlIGluCj4gZHJtX2RwX2VuY29kZV9zaWRlYmFuZF9yZXEoKS4KPiAKPiBDaGFu
Z2VzIHNpbmNlIHYxOihodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExMzEyNjY3
LykKPiAqIEFkZCBtb3JlIGRlc2NyaXB0aW9ucyBpbiBjb21taXQgYW5kIGNjIHRvIHN0YWJsZQo+
IAo+IEZpeGVzOiBhZDdmOGExZjljZSAoZHJtL2hlbHBlcjogYWRkIERpc3BsYXlwb3J0IG11bHRp
LXN0cmVhbSBoZWxwZXIgKHYwLjYpKQo+IFJldmlld2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFy
cnkud2VudGxhbmRAYW1kLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBXYXluZSBMaW4gPFdheW5lLkxp
bkBhbWQuY29tPgo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCj4gLS0tCj4gIGRyaXZlcnMv
Z3B1L2RybS9kcm1fZHBfbXN0X3RvcG9sb2d5LmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vZHJtX2RwX21zdF90b3BvbG9neS5jCj4gYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2RwX21z
dF90b3BvbG9neS5jCj4gaW5kZXggMWNmNWY4YjhiYmI4Li45ZDI0Yzk4YmVjZTEgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV9kcF9tc3RfdG9wb2xvZ3kuYwo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9kcm1fZHBfbXN0X3RvcG9sb2d5LmMKPiBAQCAtMzkzLDcgKzM5Myw3IEBAIGRy
bV9kcF9lbmNvZGVfc2lkZWJhbmRfcmVxKGNvbnN0IHN0cnVjdAo+IGRybV9kcF9zaWRlYmFuZF9t
c2dfcmVxX2JvZHkgKnJlcSwKPiAgCQkJbWVtY3B5KCZidWZbaWR4XSwgcmVxLQo+ID51LmkyY19y
ZWFkLnRyYW5zYWN0aW9uc1tpXS5ieXRlcywgcmVxLQo+ID51LmkyY19yZWFkLnRyYW5zYWN0aW9u
c1tpXS5udW1fYnl0ZXMpOwo+ICAJCQlpZHggKz0gcmVxLT51LmkyY19yZWFkLnRyYW5zYWN0aW9u
c1tpXS5udW1fYnl0ZXM7Cj4gIAo+IC0JCQlidWZbaWR4XSA9IChyZXEtCj4gPnUuaTJjX3JlYWQu
dHJhbnNhY3Rpb25zW2ldLm5vX3N0b3BfYml0ICYgMHgxKSA8PCA1Owo+ICsJCQlidWZbaWR4XSA9
IChyZXEtCj4gPnUuaTJjX3JlYWQudHJhbnNhY3Rpb25zW2ldLm5vX3N0b3BfYml0ICYgMHgxKSA8
PCA0Owo+ICAJCQlidWZbaWR4XSB8PSAocmVxLQo+ID51LmkyY19yZWFkLnRyYW5zYWN0aW9uc1tp
XS5pMmNfdHJhbnNhY3Rpb25fZGVsYXkgJiAweGYpOwo+ICAJCQlpZHgrKzsKPiAgCQl9Ci0tIApD
aGVlcnMsCglMeXVkZSBQYXVsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
