Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F515C64E69
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 08:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3095920721
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 08:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StCMHC/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3095920721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77C8789C97;
	Mon, 23 Nov 2020 08:25:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E6E489C0D
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Nov 2020 16:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606062804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eSFXaX0DZkpNbOwM/RCeF/BEd3n14fz/kurtk7pTmoY=;
 b=StCMHC/HyCDcHG808p/9thQCbNHLB97ek1T9oforhFojh55MW9LfrBZih5vkd7qgZ43dSF
 OZ3JOWRoVWjL7zUSFlP0LDpmoWD2sc3F8Zm34Dd/PaZ0RswUInINC4teeaarn0nRRR/QOI
 +dDEJjm8SJb3l7vs6UWTL1dZHykwyjY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-j8jtVOIhO4KNTpBjPezaow-1; Sun, 22 Nov 2020 11:33:22 -0500
X-MC-Unique: j8jtVOIhO4KNTpBjPezaow-1
Received: by mail-qt1-f199.google.com with SMTP id a22so2342178qtx.20
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Nov 2020 08:33:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=eSFXaX0DZkpNbOwM/RCeF/BEd3n14fz/kurtk7pTmoY=;
 b=aF5IberDkX2jVsXborUkGpvg4b4bF3QitUhtjb4R8EYKYBjfVuxudevEWQne7+cc0C
 RmX3dcbOu81SEUxdvrCspJCA7PvgjBWufoixIa11Z76SaKahQTJ3RhGaEXpDNnytsWzb
 EFNpLYcZIzcYvi1aneCSQ1tiFak0We6bhpnzDGxl4vkoq9yNBXaY8L1y3Thc1mS7OZCm
 IFOcfo6awHkJO26+ddXgbGPVrr/gffHJlli8s7u3Na0dnAvxRFX4agckaTWbpNzIYCxP
 KLgJSRTCPF+Si+ICZkf9bB/3pDQQznc1wXVx0tnSuJxyo5rRYmS1DDUb8lHQhJ1+pVd2
 6pUg==
X-Gm-Message-State: AOAM532/ORJARif4hdm/UqtGY0FtdKy7CtzjnaQxFexxkgz717lvEu2P
 SRwK76pCAl1uzIFqkjf+GRWKd689Ecyv5WlU82YndpCNeZpqCHQzW4dqvggRFNJZStRnJyxAlh3
 GzlMaSt/4MVdO7heb3FjlZZEhog==
X-Received: by 2002:a37:a783:: with SMTP id q125mr25815204qke.10.1606062801571; 
 Sun, 22 Nov 2020 08:33:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2n++9V878KrbbQS+4X3uFT/lj12S/EG8yAhFKA6vFd9PzTR06otQkDsZPYmv5N+Hbwviu/A==
X-Received: by 2002:a37:a783:: with SMTP id q125mr25815168qke.10.1606062801138; 
 Sun, 22 Nov 2020 08:33:21 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id 9sm7113466qke.6.2020.11.22.08.33.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Nov 2020 08:33:20 -0800 (PST)
Subject: Re: [RFC] MAINTAINERS tag for cleanup robot
To: Joe Perches <joe@perches.com>, clang-built-linux@googlegroups.com
References: <20201121165058.1644182-1-trix@redhat.com>
 <2105f0c05e9eae8bee8e17dcc5314474b3c0bc73.camel@perches.com>
From: Tom Rix <trix@redhat.com>
Message-ID: <6e8c1926-4209-8f10-d0f9-72c875a85a88@redhat.com>
Date: Sun, 22 Nov 2020 08:33:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2105f0c05e9eae8bee8e17dcc5314474b3c0bc73.camel@perches.com>
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
 linux-scsi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 cluster-devel@redhat.com, linux-acpi@vger.kernel.org,
 tboot-devel@lists.sourceforge.net, coreteam@netfilter.org,
 xen-devel@lists.xenproject.org, MPT-FusionLinux.pdl@broadcom.com,
 linux-media@vger.kernel.org, alsa-devel@alsa-project.org,
 intel-gfx@lists.freedesktop.org, ecryptfs@vger.kernel.org,
 linux-omap@vger.kernel.org, devel@acpica.org, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, netfilter-devel@vger.kernel.org,
 linux-crypto@vger.kernel.org, patches@opensource.cirrus.com,
 linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDExLzIxLzIwIDk6MTAgQU0sIEpvZSBQZXJjaGVzIHdyb3RlOgo+IE9uIFNhdCwgMjAyMC0x
MS0yMSBhdCAwODo1MCAtMDgwMCwgdHJpeEByZWRoYXQuY29tIHdyb3RlOgo+PiBBIGRpZmZpY3Vs
dCBwYXJ0IG9mIGF1dG9tYXRpbmcgY29tbWl0cyBpcyBjb21wb3NpbmcgdGhlIHN1YnN5c3RlbQo+
PiBwcmVhbWJsZSBpbiB0aGUgY29tbWl0IGxvZy4gIEZvciB0aGUgb25nb2luZyBlZmZvcnQgb2Yg
YSBmaXhlciBwcm9kdWNpbmcKPj4gb25lIG9yIHR3byBmaXhlcyBhIHJlbGVhc2UgdGhlIHVzZSBv
ZiAndHJlZXdpZGU6JyBkb2VzIG5vdCBzZWVtIGFwcHJvcHJpYXRlLgo+Pgo+PiBJdCB3b3VsZCBi
ZSBiZXR0ZXIgaWYgdGhlIG5vcm1hbCBwcmVmaXggd2FzIHVzZWQuICBVbmZvcnR1bmF0ZWx5IG5v
cm1hbCBpcwo+PiBub3QgY29uc2lzdGVudCBhY3Jvc3MgdGhlIHRyZWUuCj4+Cj4+IFNvIEkgYW0g
bG9va2luZyBmb3IgY29tbWVudHMgZm9yIGFkZGluZyBhIG5ldyB0YWcgdG8gdGhlIE1BSU5UQUlO
RVJTIGZpbGUKPj4KPj4gCUQ6IENvbW1pdCBzdWJzeXN0ZW0gcHJlZml4Cj4+Cj4+IGV4LyBmb3Ig
RlBHQSBERkwgRFJJVkVSUwo+Pgo+PiAJRDogZnBnYTogZGZsOgo+IEknbSBhbGwgZm9yIGl0LiAg
R29vZCBsdWNrIHdpdGggdGhlIGVmZm9ydC4gIEl0J3Mgbm90IGNvbXBsZXRlbHkgdHJpdmlhbC4K
Pgo+IEZyb20gYSBkZWNhZGUgYWdvOgo+Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8x
Mjg5OTE5MDc3LjI4NzQxLjUwLmNhbWVsQEpvZS1MYXB0b3AvCj4KPiAoYW5kIHRoYXQgdGhyZWFk
IHN0YXJ0ZWQgd2l0aCBleHRyYSBzZW1pY29sb24gcGF0Y2hlcyB0b28pCgpSZWFkaW5nIHRoZSBo
aXN0b3J5LCBob3cgYWJvdXQgdGhpcy4KCmdldF9tYXRhaW50YWluZXIucGwgb3V0cHV0cyBhIHNp
bmdsZSBwcmVmaXgsIGlmIG11bHRpcGxlIGZpbGVzIGhhdmUgdGhlIHNhbWUgcHJlZml4IGl0IHdv
cmtzLCBpZiB0aGV5IGRvbid0IGl0cyBhbiBlcnJvci4KCkFub3RoZXIgc2NyaXB0ICdjb21taXRf
b25lX2ZpbGUuc2gnIGRvZXMgdGhlIGNhbGwgdG8gZ2V0X21haW5haW50ZXIucGwgdG8gZ2V0IHRo
ZSBwcmVmaXggYW5kIGJlIGNhbGxlZCBieSBydW4tY2xhbmctdG9vbHMucHkgdG8gZ2V0IHRoZSBm
aXhlciBzcGVjaWZpYyBtZXNzYWdlLgoKRGVmZXIgbWluaW1pemluZyB0aGUgY29tbWl0cyBieSBj
b21iaW5pbmcgc2ltaWxhciBzdWJzeXN0ZW1zIHRpbGwgbGF0ZXIuCgpJbiBhIHN0ZWFkeSBzdGF0
ZSBjYXNlLCB0aGlzIHNob3VsZCBiZSB1bmNvbW1vbi4KCgo+Cj4+IENvbnRpbnVpbmcgd2l0aCBj
bGVhbmluZyB1cCBjbGFuZydzIC1XZXh0cmEtc2VtaS1zdG10Cj4+IGRpZmYgLS1naXQgYS9NYWtl
ZmlsZSBiL01ha2VmaWxlCj4gW10KPj4gQEAgLTE1NjcsMjAgKzE1NjcsMjEgQEAgaGVscDoKPj4g
wqAJIGVjaG8gICcnCj4+IMKgCUBlY2hvICAnU3RhdGljIGFuYWx5c2VyczonCj4+IMKgCUBlY2hv
ICAnICBjaGVja3N0YWNrICAgICAgLSBHZW5lcmF0ZSBhIGxpc3Qgb2Ygc3RhY2sgaG9ncycKPj4g
wqAJQGVjaG8gICcgIHZlcnNpb25jaGVjayAgICAtIFNhbml0eSBjaGVjayBvbiB2ZXJzaW9uLmgg
dXNhZ2UnCj4+IMKgCUBlY2hvICAnICBpbmNsdWRlY2hlY2sgICAgLSBDaGVjayBmb3IgZHVwbGlj
YXRlIGluY2x1ZGVkIGhlYWRlciBmaWxlcycKPj4gwqAJQGVjaG8gICcgIGV4cG9ydF9yZXBvcnQg
ICAtIExpc3QgdGhlIHVzYWdlcyBvZiBhbGwgZXhwb3J0ZWQgc3ltYm9scycKPj4gwqAJQGVjaG8g
ICcgIGhlYWRlcmRlcCAgICAgICAtIERldGVjdCBpbmNsdXNpb24gY3ljbGVzIGluIGhlYWRlcnMn
Cj4+IMKgCUBlY2hvICAnICBjb2NjaWNoZWNrICAgICAgLSBDaGVjayB3aXRoIENvY2NpbmVsbGUn
Cj4+IMKgCUBlY2hvICAnICBjbGFuZy1hbmFseXplciAgLSBDaGVjayB3aXRoIGNsYW5nIHN0YXRp
YyBhbmFseXplcicKPj4gwqAJQGVjaG8gICcgIGNsYW5nLXRpZHkgICAgICAtIENoZWNrIHdpdGgg
Y2xhbmctdGlkeScKPj4gKwlAZWNobyAgJyAgY2xhbmctdGlkeS1maXggIC0gQ2hlY2sgYW5kIGZp
eCB3aXRoIGNsYW5nLXRpZHknCj4gQSBwaXR5IHRoZSBvcmRlcmluZyBvZiB0aGUgY29kZSBiZWxv
dyBpc24ndCB0aGUgc2FtZSBhcyB0aGUgYWJvdmUuCgpUYWtlbiBjYXJlIHRoYW5rcyEKClRvbQoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
