Return-Path: <SRS0=SH5p=Z2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2664AC2D0B1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 20:35:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0341F2077B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 20:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0341F2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87F0D6E985;
	Wed,  4 Dec 2019 20:35:43 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57D686E985
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2019 20:35:42 +0000 (UTC)
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-42qLWQ9YPHKfDUoa0b3wUA-1; Wed, 04 Dec 2019 15:35:38 -0500
Received: by mail-qv1-f71.google.com with SMTP id q17so617724qvo.23
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Dec 2019 12:35:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=CcfXnqRDGLzjfAhhoPEcGcIjYRF7WAMJk0Ov035HOEQ=;
 b=Fsirqjil2Z4HLr+J9ZuOCWLVTn+UFuRTsxiU5Sfdxh5DU1WJXeAOlT0zuh+tazpXSN
 snjSmRVXS+TpAXiAAX/1tcTQPTu9L+gjWBBme/1NhN5XpZqll9jBN4BpTOcQNi8ZRK1E
 lt6aJvBwzab5NSGdonp5aj19mHlfYUD30iJyJTG65Tk9Ubn3zb7lbF2Ywyy8DhR7gqcI
 sK7tJfLwu3wTTbqlV65gmVCdG5travj3E7g6hKV5lw9LMe25awJqUwJ0g8GsD0UeTtqb
 20kHFiwekPFp072hsn8GmusUoezHldAQAaWPqc1GGWdzZ35RUB1tGaZMuVZNcfA80XQt
 FoOQ==
X-Gm-Message-State: APjAAAV13JjLb8rVZA1MXt8/mY0ES8cKt/EawqMHSlQua6YZ1fKPxlfk
 FRD9i7p4FPugo0CA4OuiTTUd3xyRhGxLluQngCZqdcXkcsDpsqXRXPeq1d/1PxE/0lyzBbtpnkD
 B4Cz1qvQLIutE8iWduBIiWcpKzA==
X-Received: by 2002:ac8:27ae:: with SMTP id w43mr4563628qtw.273.1575491737558; 
 Wed, 04 Dec 2019 12:35:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqytQgQkToEqaj5Q7Jblq+SLtUht+TP6KqrFu2cJHaSSxTOW0mOv4V7Bw5JGM6N69CV+8urzog==
X-Received: by 2002:ac8:27ae:: with SMTP id w43mr4563615qtw.273.1575491737370; 
 Wed, 04 Dec 2019 12:35:37 -0800 (PST)
Received: from dhcp-10-20-1-90.bss.redhat.com ([144.121.20.162])
 by smtp.gmail.com with ESMTPSA id t15sm4088792qkg.49.2019.12.04.12.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 12:35:36 -0800 (PST)
Message-ID: <7a2d903669055f9c717899b06225058df3a1775d.camel@redhat.com>
Subject: Re: [PATCH v2] drm/dp_mst: Correct the bug in
 drm_dp_update_payload_part1()
From: Lyude Paul <lyude@redhat.com>
To: Wayne Lin <Wayne.Lin@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Date: Wed, 04 Dec 2019 15:35:35 -0500
In-Reply-To: <20191203042423.5961-1-Wayne.Lin@amd.com>
References: <20191203042423.5961-1-Wayne.Lin@amd.com>
Organization: Red Hat
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31)
MIME-Version: 1.0
X-MC-Unique: 42qLWQ9YPHKfDUoa0b3wUA-1
X-Mimecast-Spam-Score: 0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1575491741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CcfXnqRDGLzjfAhhoPEcGcIjYRF7WAMJk0Ov035HOEQ=;
 b=dPllBQWtpxZIj0/PYhILjPmw9E7wW4tIsJ214iZGcZuN9UnD0UUGus6QjVQsoeDQCkaRs0
 ie/aw5YCXjFH8lhs+Ti8dkphDa4ydGMux9JCDR27N1Z+xfyjh2Uy+OVYeVR/F5ejPZoO3a
 8XKCzSUUY/4L3fRGKbncEO/h+8NsUkI=
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
Cc: jerry.zuo@amd.com, harry.wentland@amd.com, Nicholas.Kazlauskas@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SnVzdCBwdXNoZWQgdG8gZHJtLW1pc2MtbmV4dC1maXhlcyBhcwplNWE2Y2EyN2ViNzJjNjc1MzNk
ZGZjMTFjMDZkZjg0YmVhYTE2N2ZhLCB0aGFua3MhCgpPbiBUdWUsIDIwMTktMTItMDMgYXQgMTI6
MjQgKzA4MDAsIFdheW5lIExpbiB3cm90ZToKPiBbV2h5XQo+IElmIHRoZSBwYXlsb2FkX3N0YXRl
IGlzIERQX1BBWUxPQURfREVMRVRFX0xPQ0FMIGluIHNlcmllcywgY3VycmVudAo+IGNvZGUgZG9l
c24ndCBkZWxldGUgdGhlIHBheWxvYWQgYXQgY3VycmVudCBpbmRleCBhbmQganVzdCBtb3ZlIHRo
ZQo+IGluZGV4IHRvIG5leHQgb25lIGFmdGVyIHNodWZmbGluZyBwYXlsb2Fkcy4KPiAKPiBbSG93
XQo+IERyb3AgdGhlIGkrKyBpbmNyZWFzaW5nIHBhcnQgaW4gZm9yIGxvb3AgaGVhZCBhbmQgZGVj
aWRlIHdoZXRoZXIKPiB0byBpbmNyZWFzZSB0aGUgaW5kZXggb3Igbm90IGFjY29yZGluZyB0byBw
YXlsb2FkX3N0YXRlIG9mIGN1cnJlbnQKPiBwYXlsb2FkLgo+IAo+IENoYW5nZXMgc2luY2UgdjE6
Cj4gKiBSZWZpbmUgdGhlIGNvZGUgdG8gaGF2ZSBpdCBlYXN5IHJlYWRpbmcKPiAqIEFtZW5kIHRo
ZSBjb21taXQgbWVzc2FnZSB0byBtZWV0IHRoZSB3YXkgY29kZSBpcyBtb2RpZmllZCBub3cuCj4g
Cj4gU2lnbmVkLW9mZi1ieTogV2F5bmUgTGluIDxXYXluZS5MaW5AYW1kLmNvbT4KPiBSZXZpZXdl
ZC1ieTogTHl1ZGUgUGF1bCA8bHl1ZGVAcmVkaGF0LmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUv
ZHJtL2RybV9kcF9tc3RfdG9wb2xvZ3kuYyB8IDYgKysrKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9kcm1fZHBfbXN0X3RvcG9sb2d5LmMKPiBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZHBf
bXN0X3RvcG9sb2d5LmMKPiBpbmRleCA4MWU5MmIyNjBkN2EuLjRlZjZkZWNjMDU1MSAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2RwX21zdF90b3BvbG9neS5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2RybV9kcF9tc3RfdG9wb2xvZ3kuYwo+IEBAIC0zMTc2LDkgKzMxNzYsMTEg
QEAgaW50IGRybV9kcF91cGRhdGVfcGF5bG9hZF9wYXJ0MShzdHJ1Y3QKPiBkcm1fZHBfbXN0X3Rv
cG9sb2d5X21nciAqbWdyKQo+ICAJCQlkcm1fZHBfbXN0X3RvcG9sb2d5X3B1dF9wb3J0KHBvcnQp
Owo+ICAJfQo+ICAKPiAtCWZvciAoaSA9IDA7IGkgPCBtZ3ItPm1heF9wYXlsb2FkczsgaSsrKSB7
Cj4gLQkJaWYgKG1nci0+cGF5bG9hZHNbaV0ucGF5bG9hZF9zdGF0ZSAhPSBEUF9QQVlMT0FEX0RF
TEVURV9MT0NBTCkKPiArCWZvciAoaSA9IDA7IGkgPCBtZ3ItPm1heF9wYXlsb2FkczsgLyogZG8g
bm90aGluZyAqLykgewo+ICsJCWlmIChtZ3ItPnBheWxvYWRzW2ldLnBheWxvYWRfc3RhdGUgIT0g
RFBfUEFZTE9BRF9ERUxFVEVfTE9DQUwpCj4gewo+ICsJCQlpKys7Cj4gIAkJCWNvbnRpbnVlOwo+
ICsJCX0KPiAgCj4gIAkJRFJNX0RFQlVHX0tNUygicmVtb3ZpbmcgcGF5bG9hZCAlZFxuIiwgaSk7
Cj4gIAkJZm9yIChqID0gaTsgaiA8IG1nci0+bWF4X3BheWxvYWRzIC0gMTsgaisrKSB7Ci0tIApD
aGVlcnMsCglMeXVkZSBQYXVsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=
