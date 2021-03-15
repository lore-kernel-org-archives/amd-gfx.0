Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410C9C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 13:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB15864EB3
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 13:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB15864EB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 800B689807;
	Mon, 15 Mar 2021 13:05:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1900889807
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 13:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615813458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SfGku487SX3Ych9EefKjkZZfjXH2b15z69xTIvPbz1g=;
 b=alTtVPD9Emsg3yQQEPVdFTMnv9Z25tSL+iH/oDvO8oc8pXIPi6s86ZgIr450Jc+XW2bVJj
 YisN0r/uZBNfk90XOXNeAL2qzVVbEujB3IY2xcmueCJBuOkxscdZybydWyJjIzxmTfimwl
 nkADkfBJGY71t1ogg9wKZeTnu1w1fGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-q6uXcxu_O0y-PY3Q78CgKA-1; Mon, 15 Mar 2021 09:04:15 -0400
X-MC-Unique: q6uXcxu_O0y-PY3Q78CgKA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40D191084D95;
 Mon, 15 Mar 2021 13:04:13 +0000 (UTC)
Received: from [10.36.112.200] (ovpn-112-200.ams2.redhat.com [10.36.112.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A93219701;
 Mon, 15 Mar 2021 13:04:10 +0000 (UTC)
To: Mike Rapoport <rppt@linux.ibm.com>
References: <MW3PR12MB4537B49678884A1EB1F75AB5F36E9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <0AE49D98-171A-42B9-9CFC-9193A9BD3346@redhat.com>
 <YEzCm/Uwvw7kKpd7@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
Message-ID: <22437770-956e-f7b4-a8f6-3f1cc28c3ec2@redhat.com>
Date: Mon, 15 Mar 2021 14:04:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEzCm/Uwvw7kKpd7@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mailman-Approved-At: Mon, 15 Mar 2021 13:05:07 +0000
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
Cc: "Liang, Liang \(Leo\)" <Liang.Liang@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 George Kennedy <george.kennedy@oracle.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMTMuMDMuMjEgMTQ6NDgsIE1pa2UgUmFwb3BvcnQgd3JvdGU6Cj4gSGksCj4gCj4gT24gU2F0
LCBNYXIgMTMsIDIwMjEgYXQgMTA6MDU6MjNBTSArMDEwMCwgRGF2aWQgSGlsZGVuYnJhbmQgd3Jv
dGU6Cj4+PiBBbSAxMy4wMy4yMDIxIHVtIDA1OjA0IHNjaHJpZWIgTGlhbmcsIExpYW5nIChMZW8p
IDxMaWFuZy5MaWFuZ0BhbWQuY29tPjoKPj4+Cj4+PiBIaSBEYXZpZCwKPj4+Cj4+PiBXaGljaCBi
ZW5jaG1hcmsgdG9vbCB5b3UgcHJlZmVyPyBNZW10ZXN0ODYrIG9yIGVsc2U/Cj4+Cj4+IEhpIExl
bywKPj4KPj4gSSB0aGluayB5b3Ugd2FudCBzb21ldGhpbmcgdGhhdCBydW5zIHVuZGVyIExpbnV4
IG5hdGl2ZWx5Lgo+Pgo+PiBJ4oCYbSBwbGFubmluZyBvbiBjb2RpbmcgdXAgYSBrZXJuZWwgbW9k
dWxlIHRvIHdhbGsgYWxsIDRNQiBwYWdlcyBpbiB0aGUKPj4gZnJlZWxpc3RzIGFuZCBwZXJmb3Jt
IGEgc3RyZWFtIGJlbmNobWFyayBpbmRpdmlkdWFsbHkuIFRoZW4gd2UgbWlnaHQgYmUKPj4gYWJs
ZSB0byBpZGVudGlmeSB0aGUgcHJvYmxlbWF0aWMgcmFuZ2UgLSBpZiB0aGVyZSBpcyBhIHByb2Js
ZW1hdGljIHJhbmdlIDopCj4gCj4gTXkgd2lsZCBndWVzcyB3b3VsZCBiZSB0aGF0IHRoZSBwYWdl
cyB0aGF0IGFyZSBub3cgYXQgdGhlIGhlYWQgb2YgZnJlZQo+IGxpc3RzIGhhdmUgd3JvbmcgY2Fj
aGluZyBlbmFibGVkLiBNaWdodCBiZSB3b3J0aCBjaGVja2luZyBpbiB5b3VyIHRlc3QKPiBtb2R1
bGUuCgpJIGhhY2tlZCBzb21ldGhpbmcgdXAgcmVhbCBxdWljazoKCmh0dHBzOi8vZ2l0aHViLmNv
bS9kYXZpZGhpbGRlbmJyYW5kL2tzdHJlYW0KCk9ubHkgYnJpZWZseSB0ZXN0ZWQgaW5zaWRlIGEg
Vk0uIFRoZSBvdXRwdXQgbG9va3Mgc29tZXRoaW5nIGxpa2UKClsuLi5dClsgODM5Ni40MzIyMjVd
IFsweDAwMDAwMDAwNDU4MDAwMDAgLSAweDAwMDAwMDAwNDViZmZmZmZdIDI1MzIyIE1CL3MgLyAK
Mzg5NDggTUIvcwpbIDgzOTYuNDQ4NzQ5XSBbMHgwMDAwMDAwMDQ1YzAwMDAwIC0gMHgwMDAwMDAw
MDQ1ZmZmZmZmXSAyNDQ4MSBNQi9zIC8gCjM4OTQ2IE1CL3MKWyA4Mzk2LjQ2NTE5N10gWzB4MDAw
MDAwMDA0NjAwMDAwMCAtIDB4MDAwMDAwMDA0NjNmZmZmZl0gMjQ4OTIgTUIvcyAvIAozOTE3MCBN
Qi9zClsgODM5Ni40ODE1NTJdIFsweDAwMDAwMDAwNDY0MDAwMDAgLSAweDAwMDAwMDAwNDY3ZmZm
ZmZdIDI1MjIyIE1CL3MgLyAKMzkxNTYgTUIvcwpbIDgzOTYuNDk4MDEyXSBbMHgwMDAwMDAwMDQ2
ODAwMDAwIC0gMHgwMDAwMDAwMDQ2YmZmZmZmXSAyNDQxNiBNQi9zIC8gCjM5MTU5IE1CL3MKWyA4
Mzk2LjUxNDM5N10gWzB4MDAwMDAwMDA0NmMwMDAwMCAtIDB4MDAwMDAwMDA0NmZmZmZmZl0gMjU0
NjkgTUIvcyAvIAozODk0MCBNQi9zClsgODM5Ni41MzA4NDldIFsweDAwMDAwMDAwNDcwMDAwMDAg
LSAweDAwMDAwMDAwNDczZmZmZmZdIDI0ODg1IE1CL3MgLyAKMzg3MzQgTUIvcwpbIDgzOTYuNTQ3
MTk1XSBbMHgwMDAwMDAwMDQ3NDAwMDAwIC0gMHgwMDAwMDAwMDQ3N2ZmZmZmXSAyNTQ1OCBNQi9z
IC8gCjM4OTQxIE1CL3MKWy4uLl0KClRoZSBiZW5jaG1hcmsgYWxsb2NhdGVzIG9uZSA0IE1pQiBj
aHVuayBhdCBhIHRpbWUgYW5kIHJ1bnMgYSBzaW1wbGlmaWVkIApTVFJFQU0gYmVuY2htYXJrIGEp
IHdpdGhvdXQgZmx1c2hpbmcgY2FjaGVzIGIpIGZsdXNoaW5nIGNhY2hlcyBiZWZvcmUgCmV2ZXJ5
IG1lbW9yeSBhY2Nlc3MuCgpJdCB3b3VsZCBiZSBncmVhdCBpZiB5b3UgY291bGQgcnVuIHRoYXQg
d2l0aCB0aGUgKm9sZCBiZWhhdmlvcioga2VybmVsIAooSU9XLCB3aXRob3V0IDdmZWY0MzFiZTlj
OSksIHNvIHdlIG1pZ2h0IHN0aWxsIGJlIGx1Y2t5IHRvIGNhdGNoIHRoZSAKcHJvYmxlbWF0aWMg
YXJlYSBpbiB0aGUgZnJlZWxpc3QuCgpMZXQncyBzZWUgaWYgdGhhdCB3aWxsIGluZGljYXRlIGFu
eXRoaW5nLgoKLS0gClRoYW5rcywKCkRhdmlkIC8gZGhpbGRlbmIKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
