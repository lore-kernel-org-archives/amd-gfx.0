Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36829C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 11:11:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA4F661241
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 11:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4F661241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AED06E087;
	Mon, 12 Apr 2021 11:11:10 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE2C96E087
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 11:11:09 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id g5so12892453ejx.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 04:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=5LtuTKsb92QbtbqBByEJdHLZe/zQ8e7otPh3ABYb7YU=;
 b=Rd1ufOIVqDDLtX0iBLbga1w1gkMUoU3SjOslxXXoFvC7kq2ePU8wkzOQHSQIReMyL4
 C7TMRCO4HCsDCcqOaUOvgP10SFcg4hMxw++TAaZze3SU+JFGQA5ebO5F/SLCfoAfZcxE
 pBMHZRlMtQW/V4P7pVSZO+P5w5cu3g10ZNj76idQ2fZTnSD6gv0JdeGhj/RbcFUVof1Y
 u369X4AX8K6meOSohhFVU4O1bQFQHGCS/GeCtQRgYth0fXb7xK2P2SnVCJMMx3oi5VjU
 WefFKelKoKNRo67xJNnLQfoSeZqnuG6U7/379y7ubJAac6mINHCDUp8YhOYyfEVGl7Fq
 KlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=5LtuTKsb92QbtbqBByEJdHLZe/zQ8e7otPh3ABYb7YU=;
 b=YEMV3yFNq+7gr1yruWE/yMhwHGqUTc1k1mPPxJD2PywRVXtvg8PqAi5p+uiMyPhi4D
 NLSTay3TvojCx1ehsCOtYsHSw1EW12g0lBd3E9kHPKnSAYKjWbTwwgBt2p2qKgqdSAF0
 the15Jw1Er0Gsh34bBbXOHZAZ8kr39tMMkwjZ8J7d+veWT1XwGp38+6XrGlg1IOc+Rki
 h4VaL7m33cxA2oS9ZC5Hk0qj2LyQ2Pwd50/WRTNs//HT0HaZEs7YnHkSZUZTyiPu7U1P
 rHo2O9DLW8qk2/RabEbhqt09Tc98zvV+My/CsmYKb/Np9tg2VypYQZowrs+We8WesyfG
 Rd/A==
X-Gm-Message-State: AOAM530GoBMNahvWrilcd6F++MABqr8L/T2vvOvGyoQ/mJ21qZGILBpq
 zENzTGYqGWa6nTLFQPZGDYE=
X-Google-Smtp-Source: ABdhPJyGzaUJxdWE7Cxnwp47xvfzILRQlAYxIR8LXURjbNIz0PXel2menqEgA9UTCoZw09oNssk/0g==
X-Received: by 2002:a17:907:689:: with SMTP id
 wn9mr26459839ejb.485.1618225868405; 
 Mon, 12 Apr 2021 04:11:08 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:4f4:3b4b:a0ea:d512?
 ([2a02:908:1252:fb60:4f4:3b4b:a0ea:d512])
 by smtp.gmail.com with ESMTPSA id bs10sm6282943edb.8.2021.04.12.04.11.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Apr 2021 04:11:07 -0700 (PDT)
Subject: Re: Unexpected multihop in swaput - likely driver bug.
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
References: <CABXGCsPAdv6wCWmzh6OQmDX1LOf_FEu_wH=4K9HDd_rToTdwrQ@mail.gmail.com>
 <7d30982e-a893-858c-2237-a09a183ff2d0@gmail.com>
 <CABXGCsN6GX4ksbFo9fhd6XGxNyED9qoBqYf0Ph1pwG3qArGtjg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b2d8efbd-3e2a-eff3-23e7-b620ea584082@gmail.com>
Date: Mon, 12 Apr 2021 13:11:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CABXGCsN6GX4ksbFo9fhd6XGxNyED9qoBqYf0Ph1pwG3qArGtjg@mail.gmail.com>
Content-Language: en-US
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
Cc: Dave Airlie <airlied@gmail.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgTWlraGFpbCwKCnRoYW5rcyBhIGxvdCBmb3IgcG9pbnRpbmcgdGhpcyBvdXQuCgpUdXJuZWQg
b3V0IHRoYXQgdGhpcyBpcyBhIGtub3duIGlzc3VlLCBidXQgSSd2ZSBmb3Jnb3QgdG8gcHVzaCB0
aGUgZml4IAp0byBkcm0tbWlzYy1maXhlcyBhbmQganVzdCBxdWV1ZWQgaXQgdXAgZm9yIHRoZSBu
ZXh0IHJlbGVhc2UuCgpQbGVhc2UgcmUtdGVzdCBkcm0tbWlzYy1maXhlcyBhbmQgbGV0J3MgaG9w
ZSB0aGVyZSBpcyBhbm90aGVyIC1yYyBiZWZvcmUgCnRoZSBmaW5hbCA1LjEyIGtlcm5lbC4KClRo
YW5rcywKQ2hyaXN0aWFuLgoKQW0gMDcuMDQuMjEgdW0gMjA6MDYgc2NocmllYiBNaWtoYWlsIEdh
dnJpbG92Ogo+IE9uIFdlZCwgNyBBcHIgMjAyMSBhdCAxNTo0NiwgQ2hyaXN0aWFuIEvDtm5pZwo+
IDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4+IFdoYXQgaGFyZHdh
cmUgYXJlIHlvdSB1c2luZwo+ICQgaW54aSAtYk0KPiBTeXN0ZW06ICAgIEhvc3Q6IGZlZG9yYSBL
ZXJuZWw6IDUuMTIuMC0wLnJjNi4xODQuZmMzNS54ODZfNjQrZGVidWcKPiB4ODZfNjQgYml0czog
NjQgRGVza3RvcDogR05PTUUgNDAuMAo+ICAgICAgICAgICAgIERpc3RybzogRmVkb3JhIHJlbGVh
c2UgMzUgKFJhd2hpZGUpCj4gTWFjaGluZTogICBUeXBlOiBEZXNrdG9wIE1vYm86IEFTVVNUZUsg
bW9kZWw6IFJPRyBTVFJJWCBYNTcwLUkgR0FNSU5HCj4gdjogUmV2IFguMHggc2VyaWFsOiA8c3Vw
ZXJ1c2VyIHJlcXVpcmVkPgo+ICAgICAgICAgICAgIFVFRkk6IEFtZXJpY2FuIE1lZ2F0cmVuZHMg
djogMzYwMyBkYXRlOiAwMy8yMC8yMDIxCj4gQmF0dGVyeTogICBJRC0xOiBoaWRwcF9iYXR0ZXJ5
XzAgY2hhcmdlOiBOL0EgY29uZGl0aW9uOiBOL0EKPiBDUFU6ICAgICAgIEluZm86IDE2LUNvcmUg
KDItRGllKSBBTUQgUnl6ZW4gOSAzOTUwWCBbTVQgTUNQIE1DTV0gc3BlZWQ6Cj4gMjM2NSBNSHog
bWluL21heDogMjIwMC8zNTAwIE1Iego+IEdyYXBoaWNzOiAgRGV2aWNlLTE6IEFkdmFuY2VkIE1p
Y3JvIERldmljZXMgW0FNRC9BVEldIE5hdmkgMjEgW1JhZGVvbgo+IFJYIDY4MDAvNjgwMCBYVCAv
IDY5MDAgWFRdIGRyaXZlcjogYW1kZ3B1IHY6IGtlcm5lbAo+ICAgICAgICAgICAgIERldmljZS0y
OiBBVmVyTWVkaWEgTGl2ZSBTdHJlYW1lciBDQU0gNTEzIHR5cGU6IFVTQiBkcml2ZXI6Cj4gaGlk
LWdlbmVyaWMsdXNiaGlkLHV2Y3ZpZGVvCj4gICAgICAgICAgICAgRGV2aWNlLTM6IEFWZXJNZWRp
YSBMaXZlIEdhbWVyIFVsdHJhLVZpZGVvIHR5cGU6IFVTQgo+IGRyaXZlcjogaGlkLWdlbmVyaWMs
c25kLXVzYi1hdWRpbyx1c2JoaWQsdXZjdmlkZW8KPiAgICAgICAgICAgICBEaXNwbGF5OiB3YXls
YW5kIHNlcnZlcjogWC5PcmcgMS4yMS4xIGRyaXZlcjogbG9hZGVkOgo+IGFtZGdwdSxhdGkgdW5s
b2FkZWQ6IGZiZGV2LG1vZGVzZXR0aW5nLHJhZGVvbix2ZXNhCj4gICAgICAgICAgICAgcmVzb2x1
dGlvbjogMzg0MHgyMTYwfjYwSHoKPiAgICAgICAgICAgICBPcGVuR0w6IHJlbmRlcmVyOiBBTUQg
U0lFTk5BX0NJQ0hMSUQgKERSTSAzLjQwLjAKPiA1LjEyLjAtMC5yYzYuMTg0LmZjMzUueDg2XzY0
K2RlYnVnIExMVk0gMTIuMC4wKQo+ICAgICAgICAgICAgIHY6IDQuNiBNZXNhIDIxLjEuMC1kZXZl
bAo+IE5ldHdvcms6ICAgRGV2aWNlLTE6IEludGVsIFdpLUZpIDYgQVgyMDAgZHJpdmVyOiBpd2x3
aWZpCj4gICAgICAgICAgICAgRGV2aWNlLTI6IEludGVsIEkyMTEgR2lnYWJpdCBOZXR3b3JrIGRy
aXZlcjogaWdiCj4gRHJpdmVzOiAgICBMb2NhbCBTdG9yYWdlOiB0b3RhbDogMTEuMzUgVGlCIHVz
ZWQ6IDEwLjgyIFRpQiAoOTUuMyUpCj4gSW5mbzogICAgICBQcm9jZXNzZXM6IDgwNSBVcHRpbWU6
IDEyaCA1Nm0gTWVtb3J5OiAzMS4xOCBHaUIgdXNlZDoKPiAyMS44OCBHaUIgKDcwLjIlKSBTaGVs
bDogQmFzaCBpbnhpOiAzLjMuMDIKPgo+Cj4+IGFuZCBob3cgZG8geW91IGV4YWN0bHkgdHJpZ2dl
ciB0aGlzPwo+IEkgYW0gcnVubmluZyBoZWF2eSBnYW1lcyBsaWtlICJab21iaWUgQXJteSA0OiBE
ZWFkIFdhciIgYW5kIHN3aXRjaGluZwo+IHRvIEdub21lIEFjdGl2aXRpZXMgYW5kIG90aGVyIGFw
cGxpY2F0aW9ucyB3aGlsZSB0aGUgZ2FtZSBpcyBydW5uaW5nLgo+Cj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
