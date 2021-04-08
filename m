Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69684C433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 15:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 152F6610F9
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 15:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152F6610F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1FAD6EB27;
	Thu,  8 Apr 2021 15:04:39 +0000 (UTC)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62FE46EB1E
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 15:02:17 +0000 (UTC)
Received: by mail-qk1-x732.google.com with SMTP id x14so2451837qki.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Apr 2021 08:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=wtgr+b1moxhgAFBso0N+AErY75QLY5SUOMKvKhZbTnk=;
 b=BAWM/d2lBFvMp8pNgQCMQcvJKt1x+ESGFKj/2owcjxeC3qRT+Kd/HY2eXdU+ds0av4
 y7CwBiSOCstYyU+CA3w26fjac+vlbIHRvGQRxrwWRO40uS9nljC2j4NzxflO0ZiyP4c2
 AQXADjp68//IoFapTdjfE8FZH4LmBwkm8Yaty4UeBUDuS1cQQEpK7meyPjmkNtiWMGGb
 xx2kufrwsUs4WncwXvEBPxiXclpQD6kdYmz0qeoeZoqpnXedew/cF85LTLfZakSk6Wnf
 NnGGqej01GOMuHeB8LXUkQ216pi21EfCG7ayZV9OvBSgVRc6QiidK8X0aLtEGmgbz16D
 Qzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=wtgr+b1moxhgAFBso0N+AErY75QLY5SUOMKvKhZbTnk=;
 b=i8DyKY12Nho3IvI5V1TWhdo7Lhc7pbqEq2PkTAZBs9nomZl8tGKVf3kEcqodXgoiFz
 0LzlE5pltmylosBo6joh3DIdqetge6+ec058V9DMT+0mFHB9hoV5+09vzKUMttY2nbhj
 lX/6umN5NCXs8Gy6+q2NTziH8+73EhmxtA4aBecDytukxsBnOntj/T+5AJ4X1YJEHu8C
 5dFt0VSG7Ck7Z1Jj4A3HDw8F1MXRO2jRx0EGQafYW59Gv4haPGctg/GaJ4axM1GEDykL
 noHPdRz5jwmUMvS/copCu/+LmKLs6d60Hcz+o2Xq1RM3JkUNG0xApZBMedSSMHt6dBcJ
 5N8w==
X-Gm-Message-State: AOAM530jEHno9J59QljiAgfTalSzzmnpyoHcPac+fCKOImvJrwyaev38
 QnlCDw+pYwy8EDcroBb/5VshLg==
X-Google-Smtp-Source: ABdhPJwhBcRwtu0iiGpW40Lle+dqS2hM9CVOxnY+rZe7yu7WuciF7PF6ymzQMZUzBR9LwFWlDQQvMA==
X-Received: by 2002:a37:ae04:: with SMTP id x4mr8917048qke.245.1617894133851; 
 Thu, 08 Apr 2021 08:02:13 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.115.133])
 by smtp.gmail.com with ESMTPSA id m25sm18978459qtq.59.2021.04.08.08.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Apr 2021 08:02:12 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lUWAe-002lLr-49; Thu, 08 Apr 2021 12:02:12 -0300
Date: Thu, 8 Apr 2021 12:02:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Felix Kuehling <Felix.Kuehling@amd.com>
Subject: Re: [PATCH 00/34] Add HMM-based SVM memory manager to KFD v4
Message-ID: <20210408150212.GC227011@ziepe.ca>
References: <20210406014629.25141-1-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210406014629.25141-1-Felix.Kuehling@amd.com>
X-Mailman-Approved-At: Thu, 08 Apr 2021 15:04:38 +0000
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
Cc: =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBBcHIgMDUsIDIwMjEgYXQgMDk6NDU6NTVQTSAtMDQwMCwgRmVsaXggS3VlaGxpbmcg
d3JvdGU6Cj4gUmViYXNlZCBvbiB1cHN0cmVhbS4gRHJvcHBlZCBhbHJlYWR5IHVwc3RyZWFtIHBh
dGNoCj4gImRybS9hbWRncHU6IHJlc2VydmUgZmVuY2Ugc2xvdCB0byB1cGRhdGUgcGFnZSB0YWJs
ZSIuCj4gCj4gQWRkZWQgbW9yZSBmaXhlczoKPiAtIEZpeGVkIGtlcm5lbCB0ZXN0IHJvYm90IHdh
cm5pbmdzIGFib3V0IHN0YXRpYyBmdW5jdGlvbnMKPiAtIEZpeGVkIGEga2VybmVsIHRlc3Qgcm9i
b3Qgd2FybmluZyBhYm91dCBhbiB1bnVzZWQgdmFyaWFibGUKPiAtIEZpeGVkIGEga2VybmVsIHRl
c3Qgcm9ib3Qgd2FybmluZyBhYm91dCBzZWxlY3QgREVWSUNFX1BSSVZBVEUuCj4gICBVc2luZyAi
ZGVwZW5kcyBvbiIgbm93LiAoc2VlIHBhdGNoIDM0KQo+IC0gUHJvcG9ydGlvbmFsbHkgbG9uZ2Vy
IHRpbWVvdXQgZm9yIGhtbV9yYW5nZV9mYXVsdCBvbiBsYXJnZSBhZGRyZXNzIHJhbmdlcwo+ICAg
KHNlZSBwYXRjaCA2KQo+IC0gRml4ZWQgUFRFIGZsYWdzIGZvciBYR01JIG1hcHBpbmdzIG9uIEFy
Y3R1cnVzIGFuZCBBbGRlYmFyYW4gKHNlZSBwYXRjaCAxNykKPiAtIEZpeGVkIHJhbmdlLWxpc3Qg
Y2xlYW51cCBvbiBwcm9jZXNzIHRlcm1pbmF0aW9uIHRvIGF2b2lkIEJVR3MgZnJvbSBkYW5nbGlu
Zwo+ICAgaW50ZXJ2YWwgbm90aWZpZXJzIChzZWUgcGF0Y2ggMTYpCj4gLSBGaXhlZCBTVk0gcmFu
Z2UgbG9ja2luZyBhbmQgaW50ZXJ2YWwgbm90aWZpZXIgc2VxdWVuY2UgdXBkYXRlCj4gICAoc2Vl
IHBhdGNoIDggYW5kIHJlbGF0ZWQgdHdlYWtzIGluIHBhdGNoZXMgMTAsIDExLCAyMSkKPiAKPiBB
ZGRlZCBteSBSZXZpZXdlZC1ieSB0byBhbGwgcGF0Y2hlcyBwcmltYXJpbHkgYXV0aG9yZWQgYnkg
UGhpbGlwIGFuZCBBbGV4Lgo+IEkgYmVsaWV2ZSB0aGlzIHBhdGNoIHNlcmllcyBpcyBuZWFybHkg
cmVhZHkgdG8gZ28uCj4gCj4gVGhpcyBzZXJpZXMgYW5kIHRoZSBjb3JyZXNwb25kaW5nIFJPQ20g
VGh1bmsgYW5kIEtGRFRlc3QgY2hhbmdlcyBhcmUgYWxzbwo+IGF2YWlsYWJsZSBvbiBnaXR1YiBh
bmQgcGF0Y2h3b3JrLgo+IAo+IExpbms6IGh0dHBzOi8vZ2l0aHViLmNvbS9SYWRlb25PcGVuQ29t
cHV0ZS9ST0NLLUtlcm5lbC1Ecml2ZXIvdHJlZS9meGthbWQvaG1tLXdpcAo+IExpbms6IGh0dHBz
Oi8vZ2l0aHViLmNvbS9SYWRlb25PcGVuQ29tcHV0ZS9ST0NULVRodW5rLUludGVyZmFjZS90cmVl
L2Z4a2FtZC9obW0td2lwCj4gTGluazogaHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3Jn
L3Nlcmllcy84NTU2My8KPiBDQzogSsOpcsO0bWUgR2xpc3NlIDxqZ2xpc3NlQHJlZGhhdC5jb20+
Cj4gQ0M6IEphc29uIEd1bnRob3JwZSA8amdnQHppZXBlLmNhPgoKVGhpcyBzZXJpZXMgaXMgaHVn
ZSwgYnV0IGl0IGxvb2tzIGxpa2UgaXQgc3RpbGwgZG9lc24ndCBmaXggdGhlCkZJWE1FJ3MgYXJv
dW5kIHRoZSBBTUQgZHJpdmVyIHVzZSBvZiBobW0uCgpDYW4geW91IGZpeCB0aGVtIGJlZm9yZSBw
aWxpbmcgb24gbW9yZSBzdHVmZj8KCkphYXNvbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
