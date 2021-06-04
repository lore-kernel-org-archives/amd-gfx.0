Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1538FC47082
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 02:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE87C61407
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 02:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE87C61407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 385C46F562;
	Fri,  4 Jun 2021 02:27:11 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 411706F562;
 Fri,  4 Jun 2021 02:27:09 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id h9so8345078oih.4;
 Thu, 03 Jun 2021 19:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pE5R9j4HEkPd8MdPqUgxVbiZqCWuyrT3IDLp/mbt3qY=;
 b=Np2g+MNLp25WhMdkzaTHezh5gMyacMltrtvwl7SZF6bT2q3BfvHaKJW1n2DSpPcRZk
 0aNsbWUHE0H2ETqjGD5wAQoxdHK9J1ulleTkRBNhLFmlP8r8JrDy4n+N9wx7CB7sfSBA
 BXjuGHNQQas3bptTIstPMc8pLCGXGWEXQTnnZpewxX4BEwviB8DJBtNL0j5OICj1OLwC
 UoZX7he46V4vT8dYRScKOvSYQ2iSZL1uko6Gd4qPPwKGMlNEBsIG8zXxaiIJ2z15IsEf
 EXHaDUL2OPV6NVnmUkypSBba3EdsPYH+1CLxeNjqpeuA9DL1m4ybo4kiMv/bgHY8I/lC
 MAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pE5R9j4HEkPd8MdPqUgxVbiZqCWuyrT3IDLp/mbt3qY=;
 b=K9sErgWC4yS6T9/61gNHppd4iepn+6ASMtw3TsDWPE8lv1apQeuG03Le2ov08S9M52
 j3s8TzaoLW5VbtBrJ7UcynOlPNJNLWvL4SVAyA/BjJjYZ+CsDqZES6uGQtDPYCcRXqma
 EV+YYTgYxE59t5A5+8ZcZWLa7FPYb4iA00xAY+/xjvlGUrNYbZkRtk4zCdR4QaUK5KK+
 JXnc2lVgSUkK3Lqq1/Xnm93KTPFj+5ly+7K+E8wCJ2rhFle6TbO0fTEu4J+x5bsFURhS
 f4lOLKZoqi16cbGJP57LU78ipGfivb1PCsL2MTofgxDYYLA20Xky0YeZByduZKT7Qa1o
 IQSA==
X-Gm-Message-State: AOAM532rXWgzgiWaEC/hhqq8J0HlmbaNRQfkGIhykbTClTGo8/B0sMZF
 ty7Iez4hSntM0gMDwv+goNDvsp8xC5aMl0sTfh0=
X-Google-Smtp-Source: ABdhPJyDcRuVRzgC8zDo9W6dLEycPTgTGFW2pEFgCL3sMqXZzx0a4PKbnKfzlUBri+5gjHGvn5BOUDiTctWAtio7YMo=
X-Received: by 2002:a05:6808:1592:: with SMTP id
 t18mr1466289oiw.123.1622773628625; 
 Thu, 03 Jun 2021 19:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210601201702.23316-1-andrey.grodzovsky@amd.com>
 <CADnq5_Nfs_j9XE1Siou2wGYuwd5cvTD1T7m9gFpS9z74D=AuAQ@mail.gmail.com>
 <SN6PR12MB46230F8575C786B53056FE79EA3C9@SN6PR12MB4623.namprd12.prod.outlook.com>
In-Reply-To: <SN6PR12MB46230F8575C786B53056FE79EA3C9@SN6PR12MB4623.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 3 Jun 2021 22:26:57 -0400
Message-ID: <CADnq5_OHQ3Dtq3ZikvDPR=pSubSBq0pN_uRkXW8FaVcbr2pWAQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] libdrm tests for hot-unplug fe goature
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Q29kZSByZXZpZXcgaGFwcGVucyBvbiBnaXRsYWIgbm93IGZvciBsaWJkcm0uCgpBbGV4CgpPbiBU
aHUsIEp1biAzLCAyMDIxIGF0IDY6MDIgUE0gR3JvZHpvdnNreSwgQW5kcmV5CjxBbmRyZXkuR3Jv
ZHpvdnNreUBhbWQuY29tPiB3cm90ZToKPgo+IElzIGxpYmRybSBvbiBnaXRsYWIgPyBJIHdhc24n
dCBhd2FyZSBvZiB0aGlzLiBJIGFzc3VtZWQgY29kZSByZXZpZXdzIHN0aWxsIGdvIHRocm91Z2gg
ZHJpLWRldmVsLgo+Cj4gQW5kcmV5Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+IEZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPgo+IFNlbnQ6IDAz
IEp1bmUgMjAyMSAxNzoyMAo+IFRvOiBHcm9kem92c2t5LCBBbmRyZXkgPEFuZHJleS5Hcm9kem92
c2t5QGFtZC5jb20+Cj4gQ2M6IE1hbGluZyBsaXN0IC0gRFJJIGRldmVsb3BlcnMgPGRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+OyBhbWQtZ2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPjsgQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCAwLzddIGxpYmRybSB0ZXN0cyBmb3IgaG90LXVucGx1ZyBm
ZWF0dXJlCj4KPiBQbGVhc2Ugb3BlbiBhIGdpdGxhYiBNUiBmb3IgdGhlc2UuCj4KPiBBbGV4Cj4K
PiBPbiBUdWUsIEp1biAxLCAyMDIxIGF0IDQ6MTcgUE0gQW5kcmV5IEdyb2R6b3Zza3kKPiA8YW5k
cmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4gd3JvdGU6Cj4gPgo+ID4gQWRkaW5nIHNvbWUgdGVzdHMg
dG8gYWNvbXBhbnkgdGhlIHJlY2VudGx5IGFkZGVkIGhvdC11bnBsdWcKPiA+IGZlYXR1cmUuIEZv
ciBub3cgdGhlIHRlc3Qgc3VpdGUgaXMgZGlzYWJsZWQgdW50aWwgdGhlIGZlYXR1cmUKPiA+IHBy
b3BhZ2F0ZXMgZnJvbSBkcm0tbWlzYy1uZXh0IHRvIGRybS1uZXh0Lgo+ID4KPiA+IEFuZHJleSBH
cm9kem92c2t5ICg3KToKPiA+ICAgdGVzdHMvYW1kZ3B1OiBGaXggdmFsZ3JpbmQgd2FybmluZwo+
ID4gICB4Zjg2ZHJtOiBBZGQgZnVuY3Rpb24gdG8gcmV0cmlldmUgY2hhciBkZXZpY2UgcGF0aAo+
ID4gICB0ZXN0L2FtZGdwdTogQWRkIGhlbHBlciBmdW5jdGlvbnMgZm9yIGhvdCB1bnBsdWcKPiA+
ICAgdGVzdC9hbWRncHUvaG90dW5wbHVnOiBBZGQgdGVzdCBzdWl0ZSBmb3IgR1BVIHVucGx1Zwo+
ID4gICB0ZXN0L2FtZGdwdS9ob3R1bnBsdWc6IEFkZCBiYXNpYyB0ZXN0Cj4gPiAgIHRlc3RzL2Ft
ZGdwdS9ob3R1bnBsdWc6IEFkZCB1bnBsdWcgd2l0aCBjcyB0ZXN0Lgo+ID4gICB0ZXN0cy9hbWRn
cHUvaG90dW5wbHVnOiBBZGQgaG90dW5wbHVnIHdpdGggZXhwb3J0ZWQgYm8gdGVzdAo+ID4KPiA+
ICB0ZXN0cy9hbWRncHUvYW1kZ3B1X3Rlc3QuYyAgICAgfCAgNDIgKysrLQo+ID4gIHRlc3RzL2Ft
ZGdwdS9hbWRncHVfdGVzdC5oICAgICB8ICAyNiArKysKPiA+ICB0ZXN0cy9hbWRncHUvYmFzaWNf
dGVzdHMuYyAgICAgfCAgIDUgKy0KPiA+ICB0ZXN0cy9hbWRncHUvaG90dW5wbHVnX3Rlc3RzLmMg
fCAzNTcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiAgdGVzdHMvYW1kZ3B1
L21lc29uLmJ1aWxkICAgICAgIHwgICAxICsKPiA+ICB4Zjg2ZHJtLmMgICAgICAgICAgICAgICAg
ICAgICAgfCAgMjMgKysrCj4gPiAgeGY4NmRybS5oICAgICAgICAgICAgICAgICAgICAgIHwgICAx
ICsKPiA+ICA3IGZpbGVzIGNoYW5nZWQsIDQ1MCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygt
KQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9hbWRncHUvaG90dW5wbHVnX3Rlc3RzLmMK
PiA+Cj4gPiAtLQo+ID4gMi4yNS4xCj4gPgo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPiA+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gPiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ID4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVj
dGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
JTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wNCU3QzAxJTdDYW5kcmV5
Lmdyb2R6b3Zza3klNDBhbWQuY29tJTdDOGZiN2Y2MTQ3OThiNGQxOTU3MmUwOGQ5MjZkNTc1MzAl
N0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3NTgzNTIwNTA3
MjgyNTg4JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlq
b2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRh
PW96cWxOUUFDR3ZMSnVnUTJHTnZGbDhDS2dBSDB0aHFNUnBXakhwVVJseWMlM0QmYW1wO3Jlc2Vy
dmVkPTAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
