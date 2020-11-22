Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,TRACKER_ID,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4044C63777
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 08:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63D8B20719
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 08:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fevusGFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D8B20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C21E589B95;
	Mon, 23 Nov 2020 08:25:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 187AA89D30
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Nov 2020 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606061462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D4o3+oRulyAmQWJaTM5GlynW0/tmbkOzx3PzhPB5iTg=;
 b=fevusGFh8igN5VG8cLRxS95vJ0qfmrOfJPCBr4cAWWGRdkXW7IE3WanN+qrcQBdpREsowk
 X/SSgdP57h4tbsMEoW0rNzhJn8I67LuaYQ7FiBg9Nw30dH1lNdzK27iZcceQNbwFahSTRR
 rmz+4lx5u27SmB9T1mr2g69xNK+ooo4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-pG0rOpYZNoCKNLQH37SFUw-1; Sun, 22 Nov 2020 11:11:01 -0500
X-MC-Unique: pG0rOpYZNoCKNLQH37SFUw-1
Received: by mail-qt1-f200.google.com with SMTP id 100so11754270qtf.14
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Nov 2020 08:11:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=D4o3+oRulyAmQWJaTM5GlynW0/tmbkOzx3PzhPB5iTg=;
 b=ttIBZm0R7b5y3HVE2aBF1UdDwQYSfHK0b2kBp1ELnSRc73OJgui+tBZ1IZjRcFSnCg
 oBmRTOEM75FdF/AO1hfEpASFlJzNZmmOARHzL71iumAuv8zAEt4oE6gU7IJPo4QG1vih
 ETqrED9IFJEjjWwgYOjZdvOYUeNpUzx9jDOFAtQuMMQbTxi5csABsPx8fcZvJhIUFAld
 JA+4bZaGv/YhKbJ6uv6yo4/7sQ8LiX33EOku+vURl5cgfKQSFDeaO76NcIgtK9ebLHoq
 qLaRwMx3pC2VWO905kI1xf8qcSQ1KzOHInZNj8tkLApohs/0Gfau651Q6PazRi3pAc7s
 hhNA==
X-Gm-Message-State: AOAM53031QFD/74Jf71LmdMJsoK5qBjmbP49y45wDK+tcK9dNl8REr5Q
 FueVouEWoJc0VvXwj2lJw28VCsHKBHNHeoQK2/vZF3gQ7E3NcXEvTJH0FxRqjsEZHOIlqN49kki
 pv2PtjkK6shOHmPKCfvgRHOqkgA==
X-Received: by 2002:ac8:5a8c:: with SMTP id c12mr23364803qtc.97.1606061459263; 
 Sun, 22 Nov 2020 08:10:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6JfmMkGlJyoaKx6ihYsYbDuDsWkyDwIosiC/apv5eylMrcIvHPxlHVgnFDCnun9WXh4UZ3w==
X-Received: by 2002:ac8:5a8c:: with SMTP id c12mr23364770qtc.97.1606061458997; 
 Sun, 22 Nov 2020 08:10:58 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id l3sm2779806qth.13.2020.11.22.08.10.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Nov 2020 08:10:58 -0800 (PST)
Subject: Re: [RFC] MAINTAINERS tag for cleanup robot
To: Matthew Wilcox <willy@infradead.org>
References: <20201121165058.1644182-1-trix@redhat.com>
 <20201122032304.GE4327@casper.infradead.org>
 <ddb08a27-3ca1-fb2e-d51f-4b471f1a56a3@redhat.com>
 <20201122145635.GG4327@casper.infradead.org>
From: Tom Rix <trix@redhat.com>
Message-ID: <0819ce06-c462-d4df-d3d9-14931dc5aefc@redhat.com>
Date: Sun, 22 Nov 2020 08:10:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201122145635.GG4327@casper.infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Mailman-Approved-At: Mon, 23 Nov 2020 08:25:57 +0000
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
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
 keyrings@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-scsi@vger.kernel.org, clang-built-linux@googlegroups.com,
 amd-gfx@lists.freedesktop.org, cluster-devel@redhat.com,
 linux-acpi@vger.kernel.org, tboot-devel@lists.sourceforge.net,
 coreteam@netfilter.org, xen-devel@lists.xenproject.org,
 MPT-FusionLinux.pdl@broadcom.com, linux-media@vger.kernel.org,
 alsa-devel@alsa-project.org, intel-gfx@lists.freedesktop.org,
 ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-omap@vger.kernel.org, devel@acpica.org, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, netfilter-devel@vger.kernel.org,
 linux-crypto@vger.kernel.org, patches@opensource.cirrus.com, joe@perches.com,
 bpf@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDExLzIyLzIwIDY6NTYgQU0sIE1hdHRoZXcgV2lsY294IHdyb3RlOgo+IE9uIFN1biwgTm92
IDIyLCAyMDIwIGF0IDA2OjQ2OjQ2QU0gLTA4MDAsIFRvbSBSaXggd3JvdGU6Cj4+IE9uIDExLzIx
LzIwIDc6MjMgUE0sIE1hdHRoZXcgV2lsY294IHdyb3RlOgo+Pj4gT24gU2F0LCBOb3YgMjEsIDIw
MjAgYXQgMDg6NTA6NThBTSAtMDgwMCwgdHJpeEByZWRoYXQuY29tIHdyb3RlOgo+Pj4+IFRoZSBm
aXhlciByZXZpZXcgaXMKPj4+PiBodHRwczovL3Jldmlld3MubGx2bS5vcmcvRDkxNzg5Cj4+Pj4K
Pj4+PiBBIHJ1biBvdmVyIGFsbHllc2NvbmZpZyBmb3IgeDg2XzY0IGZpbmRzIDYyIGlzc3Vlcywg
NSBhcmUgZmFsc2UgcG9zaXRpdmVzLgo+Pj4+IFRoZSBmYWxzZSBwb3NpdGl2ZXMgYXJlIGNhdXNl
ZCBieSBtYWNyb3MgcGFzc2VkIHRvIG90aGVyIG1hY3JvcyBhbmQgYnkKPj4+PiBzb21lIG1hY3Jv
IGV4cGFuc2lvbnMgdGhhdCBkaWQgbm90IGhhdmUgYW4gZXh0cmEgc2VtaWNvbG9uLgo+Pj4+Cj4+
Pj4gVGhpcyBjbGVhbnMgdXAgYWJvdXQgMSwwMDAgb2YgdGhlIGN1cnJlbnQgMTAsMDAwIC1XZXh0
cmEtc2VtaS1zdG10Cj4+Pj4gd2FybmluZ3MgaW4gbGludXgtbmV4dC4KPj4+IEFyZSBhbnkgb2Yg
dGhlbSBub3QgZmFsc2UtcG9zaXRpdmVzPyAgSXQncyBhbGwgdmVyeSB3ZWxsIHRvIGVuYWJsZQo+
Pj4gc3RyaWN0ZXIgd2FybmluZ3MsIGJ1dCBpZiB0aGV5IGRvbid0IGZpeCBhbnkgYnVncywgdGhl
eSdyZSBqdXN0IGNodXJuLgo+Pj4KPj4gV2hpbGUgZW5hYmxpbmcgYWRkaXRpb25hbCB3YXJuaW5n
cyBtYXkgYmUgYSBzaWRlIGVmZmVjdCBvZiB0aGlzIGVmZm9ydAo+Pgo+PiB0aGUgcHJpbWFyeSBn
b2FsIGlzIHRvIHNldCB1cCBhIGNsZWFuaW5nIHJvYm90LiBBZnRlciB0aGF0IGEgcmVmYWN0b3Jp
bmcgcm9ib3QuCj4gV2h5IGRvIHdlIG5lZWQgc3VjaCBhIHRoaW5nPyAgQWdhaW4sIGl0IHNvdW5k
cyBsaWtlIG1vcmUgY2h1cm4uCj4gSXQncyByZWFsbHkgYW5ub3lpbmcgd2hlbiBJJ20gd29ya2lu
ZyBvbiBzb21ldGhpbmcgaW1wb3J0YW50IHRoYXQgZ2V0cwo+IGRlcmFpbGVkIGJ5IHBvaW50bGVz
cyBjaHVybi4gIENodXJuIGFsc28gbWFrZXMgaXQgaGFyZGVyIHRvIGJhY2twb3J0Cj4gcGF0Y2hl
cyB0byBlYXJsaWVyIGtlcm5lbHMuCj4KQSByZWZhY3RvcmluZyBleGFtcGxlIG9uIG1vdmluZyB0
byB0cmVld2lkZSwgY29uc2lzdGVudCB1c2Ugb2YgYSBuZXcgYXBpIG1heSBoZWxwLgoKQ29uc2lk
ZXIKCjJlZmM0NTlkMDZmMTYzMDAwMWUzOTg0ODU0ODQ4YTU2NDcwODYyMzIKCnN5c2ZzOiBBZGQg
c3lzZnNfZW1pdCBhbmQgc3lzZnNfZW1pdF9hdCB0byBmb3JtYXQgc3lzZnMgb3V0cHV0CgpBIG5l
dyBhcGkgZm9yIHByaW50aW5nIGluIHRoZSBzeXNmcy7CoCBIb3cgZG8gd2UgdXNlIGl0IHRyZWV3
aWRlID8KCkRvbmUgbWFudWFsbHksIGl0IHdvdWxkIGJlIGEgaGVyb2ljIGVmZm9ydCByZXF1aXJp
bmcgaGlnaCBsZXZlbCBtYWludGFpbmVycyBwdXNoaW5nIGFuZCBsaWtlbHkgb25seSBnZXQgcGFy
dGlhbGx5IGRvbmUuCgpJZiBhIHJlZmFjdG9yaW5nIHByb2dyYW1hdGljIGZpeGl0IGlzIGRvbmUg
YW5kIHZhbGlkYXRlZCBvbiBhIG9uZSBzdWJzeXN0ZW0sIGl0IGNhbiBydW4gb24gYWxsIHRoZSBz
dWJzeXN0ZW1zLgoKVGhlIGVmZm9ydCBpcyBhIGNvdXBsZSBvZiB3ZWVrcyB0byB3cml0ZSBhbmQg
dmFsaWRhdGUgdGhlIGZpeGVyLCBob3VycyB0byBydW4gb3ZlciB0aGUgdHJlZS4KCkl0IHdvbid0
IGJlIHBlcmZlY3QgYnV0IHdpbGwgYmUgYmV0dGVyIHRoYW4gZG9pbmcgaXQgbWFudWFsbHkuCgpU
b20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
