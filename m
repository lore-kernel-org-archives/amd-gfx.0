Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03676C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 17:04:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17CE2311E
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 17:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17CE2311E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=froggi.es
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B458892BF;
	Wed,  6 Jan 2021 17:04:10 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1063892BF
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 17:04:08 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id i9so3087989wrc.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Jan 2021 09:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=froggi.es; s=google;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4IBknLtszUI9SVlA3svMWG/CtH/+OaUaWo9ON4a4QS4=;
 b=VPFip7+4Y0ZQUq6B3imTWxF51yZwnP97S9dIq11i5xgD8bt+poIaDEXNtdR2En/2k1
 sHKbVto7OqrNMI1tiX2qtS2BAZvkuzsrTz79rtRe5C6ZG+timS0RtTLsk+4/JaNlH+cB
 dcMuVUhgbJVbHLBb43H1+LF0WKEkNo5lMYr/SAXd4+I/fOL9wS/apGQxXeuyGW6bOR3Y
 0T9t1QvUABcnXmsQSh31JzlzuiYBH3+CrjhW1Q3g8NRKuJ9hOoh6r8i/WzK8MZSYX1Mg
 DjOxJDvkzb+D+XGaIbQMB44S9jmMljERgJM+CmhwjcrLHo/CSU0ldVvOF45XjcxErE5I
 KijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4IBknLtszUI9SVlA3svMWG/CtH/+OaUaWo9ON4a4QS4=;
 b=mdztKvugYVItfwfIfBlmUpTUzJ8sA1NQoNkCU+VJI+nKZRqMyVvUuD6UVU2rwX8uu6
 wloCDJBjG96Q3AoY38IHJlyOoe8ia8QT4b9wSqZcYsTgEWl6y3shKrAyVIOWvM7HMLt6
 AB0VaxXGDobJnWN2mcB3gxb4ZPYiAR0Y8UdXoLBPrmyXTImw9VAtI+5tIArObRt58cXq
 3sesYIliBY1nDz8WAJQV8/4gEP6V8ZcTkNS5Iu0R5pysZo2eWmQuMBYAel/y7Ol0xCBE
 ny/oVTVqM6463abBALzfLmp+nDsKazbZxJfh5V0ZUl//LljkNlZiwXqskKypuHvm/tzm
 kY9w==
X-Gm-Message-State: AOAM53122BLX4gnXquFoUI4vKpDav3UM7EGA7FGHHM3Ism6KLr8LMPEu
 uElNUxXRvoKko8nqZQ9SAudhzESdRJ+HbA==
X-Google-Smtp-Source: ABdhPJwFdqGZ8izAEkWLDs/P2YT54ZSNB8LBHLVxjitrvdzaxTHE1l8X0M7zlS/n9IzptDLRLLocKw==
X-Received: by 2002:a5d:43ce:: with SMTP id v14mr5168166wrr.342.1609952647195; 
 Wed, 06 Jan 2021 09:04:07 -0800 (PST)
Received: from [192.168.0.61]
 (cpc89720-darl9-2-0-cust754.11-2.cable.virginm.net. [86.2.110.243])
 by smtp.gmail.com with ESMTPSA id m14sm3814673wrh.94.2021.01.06.09.04.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Jan 2021 09:04:06 -0800 (PST)
From: Joshua Ashton <joshua@froggi.es>
Subject: Re: [PATCH] drm/amdgpu: don't limit gtt size on apus
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
References: <20210105220359.1392555-1-joshua@froggi.es>
 <CADnq5_NcKG9H-dK0Kh2ksF8et+fnFkMdsejkg_RWrNeJ1JS4ng@mail.gmail.com>
 <6d6b0ae7-f732-167b-2bc1-6e517f6c8e99@froggi.es>
 <9902861e-77bd-d6dc-7284-0ad9bcf117b6@amd.com>
 <a8f72dc6-8504-269e-56e8-699b20135a07@froggi.es>
 <4a3fe8b7-4248-e5c2-d6c0-5075596ca852@amd.com>
 <CAP+8YyE2wBHAcn8H-Sr=+kKmE45kUhA=KBJL08ciZJESS4XSmA@mail.gmail.com>
 <66dc40b3-caed-6b3d-899d-32d1d0f74239@gmail.com>
 <f2009e7d-6fe5-0a55-0c37-8b0b2ca2c45c@froggi.es>
 <77444d7b-e8c4-16e3-6348-e322af9db103@amd.com>
 <f831126b-c31e-96cd-b056-0902d6d0d5cc@froggi.es>
 <02c779e3-4e17-3afa-6b3f-9b5284254f55@amd.com>
Message-ID: <4ff7da1d-2f30-7364-cd1a-4267240bc4bf@froggi.es>
Date: Wed, 6 Jan 2021 17:04:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <02c779e3-4e17-3afa-6b3f-9b5284254f55@amd.com>
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpPbiAxLzYvMjEgMjo1OSBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAwNi4wMS4y
MSB1bSAxNToxOCBzY2hyaWViIEpvc2h1YSBBc2h0b246Cj4+IFtTTklQXQo+Pj4+Pj4gRm9yIFZ1
bGthbiB3ZSAoYm90aCBSQURWIGFuZCBBTURWTEspIHVzZSBHVFQgYXMgdGhlIHRvdGFsIHNpemUu
IAo+Pj4+Pj4gVXNhZ2UgaW4gbW9kZXJuIGdhbWVzIGlzIGVzc2VudGlhbGx5ICJiaW5kbGVzcyIg
c28gdGhlcmUgaXMgbm8gd2F5IAo+Pj4+Pj4gdG8gdHJhY2sgYXQgYSBwZXItc3VibWlzc2lvbiBs
ZXZlbCB3aGF0IG1lbW9yeSBuZWVkcyB0byBiZSAKPj4+Pj4+IHJlc2lkZW50LiAoYW5kIGV2ZW4g
d2l0aCB0cmFja2luZyBhcHBsaWNhdGlvbnMgYXJlIGFsbG93ZWQgdG8gdXNlIAo+Pj4+Pj4gYWxs
IHRoZSBtZW1vcnkgaW4gYSBzaW5nbGUgZHJhdyBjYWxsLCB3aGljaCB3b3VsZCBiZSB1bnNwbGl0
dGFibGUgCj4+Pj4+PiBhbnl3YXkgLi4uKQo+Pj4+Pgo+Pj4+PiBZZWFoLCB0aGF0IGlzIGEgcmVh
bGx5IGdvb2QgcG9pbnQuCj4+Pj4+Cj4+Pj4+IFRoZSBpc3N1ZSBpcyB0aGF0IHdlIG5lZWQgc29t
ZSBsaW1pdGF0aW9uIHNpbmNlIDMvNCBvZiBzeXN0ZW0gCj4+Pj4+IG1lbW9yeSBpcyB3YXkgdG8g
bXVjaCBhbmQgdGhlIG1heCB0ZXh0dXJlIHNpemUgdGVzdCBpbiBwaWdsaXQgY2FuIAo+Pj4+PiBj
YXVzZSBhIHN5c3RlbSBjcmFzaC4KPj4+Pj4KPj4+Pj4gVGhlIGFsdGVybmF0aXZlIGlzIGEgYmV0
dGVyIE9PTSBoYW5kbGluZywgc28gdGhhdCBhbiBhcHBsaWNhdGlvbiAKPj4+Pj4gd2hpY2ggdXNl
cyB0byBtdWNoIHN5c3RlbSBtZW1vcnkgdGhyb3VnaCB0aGUgZHJpdmVyIHN0YWNrIGhhcyBhIAo+
Pj4+PiBtb3JlIGxpa2VseSBjaGFuY2UgdG8gZ2V0IGtpbGxlZC4gQ2F1c2UgY3VycmVudGx5IHRo
YXQgaXMgZWl0aGVyIFggCj4+Pj4+IG9yIFdheWxhbmQgOigKPj4+Pj4KPj4+Pj4gQ2hyaXN0aWFu
Lgo+Pj4+Cj4+Pj4gQXMgSSB1bmRlcnN0YW5kIGl0LCB3aGF0IGlzIGJlaW5nIGV4cG9zZWQgcmln
aHQgbm93IGlzIGVzc2VudGlhbGx5IAo+Pj4+IG1heCh2cmFtIHNpemUsIDNHaUIpIGxpbWl0ZWQg
YnkgMy80dGhzIG9mIHRoZSBtZW1vcnkuIFByZXZpb3VzbHksIAo+Pj4+IGJlZm9yZSB0aGUgcmV2
ZXJ0IHdoYXQgd2FzIGJlaW5nIHRha2VuIHdhcyBqdXN0IG1heCgzR2lCLCAzLzR0aHMpLgo+Pj4+
Cj4+Pj4gSWYgeW91IGhhZCA8IDNHaUIgb2Ygc3lzdGVtIG1lbW9yeSB0aGF0IHNlZW1zIGxpa2Ug
YSBiaXQgb2YgYW4gaXNzdWUgCj4+Pj4gdGhhdCBjb3VsZCBlYXNpbHkgbGVhdCB0byBPT00gdG8g
bWU/Cj4+Pgo+Pj4gTm90IHJlYWxseSwgYXMgSSBzYWlkIEdUVCBpcyBvbmx5IHRoZSBtZW1vcnkg
dGhlIEdQVSBjYW4gbG9jayBhdCB0aGUgCj4+PiBzYW1lIHRpbWUuIEl0IGlzIHBlcmZlY3RseSBw
b3NzaWJsZSB0byBoYXZlIHRoYXQgbGFyZ2VyIHRoYW4gdGhlIAo+Pj4gYXZhaWxhYmxlIHN5c3Rl
bSBtZW1vcnkuCj4+Pgo+Pj4gSW4gb3RoZXIgd29yZHMgdGhpcyBpcyAqbm90KiB0byBwcmV2ZW50
IHVzaW5nIHRvIG11Y2ggc3lzdGVtIG1lbW9yeSwgCj4+PiBmb3IgdGhpcyB3ZSBoYXZlIGFuIGFk
ZGl0aW9uYWwgbGltaXQgaW5zaWRlIFRUTS4gQnV0IGluc3RlYWQgdG8gaGF2ZSAKPj4+IGEgcmVh
c29uYWJsZSBsaW1pdCBmb3IgYXBwbGljYXRpb25zIHRvIG5vdCB1c2UgdG8gbXVjaCBtZW1vcnkg
YXQgdGhlIAo+Pj4gc2FtZSB0aW1lLgo+Pj4KPj4KPj4gV29ydGggbm90aW5nIHRoYXQgdGhpcyBH
VFQgc2l6ZSBoZXJlIGFsc28gYWZmZWN0cyB0aGUgbWVtb3J5IHJlcG9ydGluZyAKPj4gYW5kIGJ1
ZGdldGluZyBmb3IgYXBwbGljYXRpb25zLiBJZiB0aGUgdXNlciBoYXMgMUdpQiBvZiB0b3RhbCBz
eXN0ZW0gCj4+IG1lbW9yeSBhbmQgM0dpQiBzZXQgaGVyZSwgdGhlbiAzR2lCIHdpbGwgYmUgdGhl
IGJ1ZGdldCBhbmQgc2l6ZSAKPj4gZXhwb3NlZCB0byBhcHBsaWNhdGlvbnMgdG9vLi4uCj4gCj4g
WWVhaCwgdGhhdCdzIGluZGVlZCBwcm9ibGVtYXRpYy4KPiAKPj4KPj4gKE9uIEFQVXMsKSB3ZSBy
ZWFsbHkgZG9uJ3Qgd2FudCB0byBleHBvc2UgbW9yZSBHVFQgdGhhbiBzeXN0ZW0gbWVtb3J5LiAK
Pj4gQXBwcyB3aWxsIGVhdCBpbnRvIGl0IGFuZCBlbmQgdXAgc3dhcHBpbmcgb3IgcnVubmluZyBp
bnRvIE9PTSBvciAKPj4gc3dhcHBpbmcgKnZlcnkqIHF1aWNrbHkuIChJIGltYWdpbmUgdGhpcyBp
cyBsaWtlbHkgd2hhdCB3YXMgYmVpbmcgcnVuIAo+PiBpbnRvIGJlZm9yZSB0aGUgcmV2ZXJ0LikK
PiAKPiBObywgdGhlIGlzc3VlIGlzIHRoYXQgc29tZSBhcHBsaWNhdGlvbnMgdHJ5IHRvIGFsbG9j
YXRlIHRleHR1cmVzIHdheSAKPiBhYm92ZSBzb21lIHJlYXNvbmFibGUgbGltaXQuCj4gCj4+IEFs
dGVybmF0aXZlbHksIGluIFJBRFYgYW5kIG90aGVyIHVzZXIgc3BhY2UgZHJpdmVycyBsaWtlIEFN
RFZMSywgd2UgCj4+IGNvdWxkIGxpbWl0IHRoaXMgdG8gdGhlIHN5c3RlbSBtZW1vcnkgc2l6ZSBv
ciAzLzR0aHMgb3Vyc2VsdmVzLiAKPj4gQWx0aG91Z2ggdGhhdCdzIGtpbmRhIGdyb3NzIGFuZCBJ
IGRvbid0IHRoaW5rIHRoYXQncyB0aGUgY29ycmVjdCBwYXRoLi4uCj4gCj4gT2ssIGxldCBtZSBl
eHBsYWluIGZyb20gdGhlIG90aGVyIHNpZGU6IFdlIGhhdmUgdGhpcyBsaW1pdGF0aW9uIGJlY2F1
c2UgCj4gb3RoZXJ3aXNlIHNvbWUgdGVzdHMgbGlrZSB0aGUgbWF4aW11bSB0ZXh0dXJlIHNpemUg
dGVzdCBmb3IgT3BlbkdMIAo+IGNyYXNoZXMgdGhlIHN5c3RlbS4gQW5kIHRoaXMgaXMgaW5kZXBl
bmRlbnQgb2YgeW91ciBzeXN0ZW0gY29uZmlndXJhdGlvbi4KPiAKPiBXZSBjb3VsZCBvZiBjb3Vy
c2UgYWRkIGFub3RoZXIgbGltaXQgZm9yIHRoZSB0ZXh0dXJlIHNpemUgaW4gCj4gT3BlbkdML1JB
RFYvQU1EVkxLLCBidXQgSSBhZ3JlZSB0aGF0IHRoaXMgaXMgcmF0aGVyIGF3a3dhcmQuCj4gCj4+
Pj4KPj4+PiBBcmUgeW91IGhpdHRpbmcgb24gc29tZXRoaW5nIHNtYWxsZXIgdGhhbiAzLzR0aHMg
cmlnaHQgbm93PyBJIAo+Pj4+IHJlbWVtYmVyIHRoZSBzb3VyY2UgY29tbWl0IG1lbnRpb25lZCB0
aGV5IG9ubHkgaGFkIDFHaUIgb2Ygc3lzdGVtIAo+Pj4+IG1lbW9yeSBhdmFpbGFibGUsIHNvIHRo
YXQgY291bGQgYmUgcG9zc2libGUgaWYgeW91IGhhZCBhIGNhcnZlb3V0IG9mIAo+Pj4+IDwgNzg2
TWlCLi4uCj4+Pgo+Pj4gV2hhdCBkbyB5b3UgbWVhbiB3aXRoIHRoYXQ/IEkgZG9uJ3QgaGF2ZSBh
IHRlc3Qgc3lzdGVtIGF0IGhhbmQgZm9yIAo+Pj4gdGhpcyBpZiB0aGF0J3Mgd2hhdCB5b3UgYXJl
IGFza2luZyBmb3IuCj4+Cj4+IFRoaXMgd2FzIG1haW5seSBhIHF1ZXN0aW9uIHRvIHdob2V2ZXIg
ZGlkIHRoZSByZXZlcnQuIFRoZSBxdWVzdGlvbiB0byAKPj4gZmluZCBvdXQgc29tZSBleHRyYSBp
bmZvIGFib3V0IHdoYXQgdGhleSBhcmUgdXNpbmcgYXQgdGhlIHRpbWUuCj4gCj4gWW91IGRvbid0
IG5lZWQgYSBzcGVjaWZpYyBzeXN0ZW0gY29uZmlndXJhdGlvbiBmb3IgdGhpcywganVzdCB0cnkg
dG8gcnVuIAo+IHRoZSBtYXggdGV4dHVyZSBzaXplIHRlc3QgaW4gcGlnbGl0Lgo+IAo+IFJlZ2Fy
ZHMsCj4gQ2hyaXN0aWFuLgoKSSBzZWUuLi4gSSBoYXZlIG5vdCBtYW5hZ2VkIHRvIHJlcHJvZHVj
ZSBhIGhhbmcgYXMgZGVzY3JpYmVkIGluIHRoZSAKcmV2ZXJ0IGNvbW1pdCwgYnV0IEkgaGF2ZSBo
YWQgYSBzb2Z0IGNyYXNoIGFuZCBkZWxheSB3aXRoIHRoZSBPT00ga2lsbGVyIAplbmRpbmcgWC5v
cmcgYWZ0ZXIgYSBsaXR0bGUgYml0IHdoZW4gR1RUID4gc3lzdGVtIG1lbW9yeS4KCkkgdGVzdGVk
IHdpdGggbWF4LXRleHR1cmUtc2l6ZSBvbiBib3RoIFJlbm9pciBhbmQgUGljYXNzbyB0aGUgZm9s
bG93aW5nIApjb25kaXRpb25zOgoxNkdpQiBSQU0gKyAxMiBHaUIgR1RUIC0+IHRlc3Qgd29ya3Mg
ZmluZQoxNkdpQiBSQU0gKyA2NCBHaUIgR1RUIC0+IE9PTSBraWxsZXIga2lsbHMgWC5vcmcgYWZ0
ZXIgYSBsaXR0bGUgYml0IG9mIAp3YWl0aW5nIChwaWdsaXQgZGllZCB3aXRoIGl0KQoyIEdpQiBS
QU0gKyAxLjVHaUIgR1RUIC0+IHRlc3Qgd29ya3MgZmluZQoKSSBhbHNvIHRlc3RlZCBvbiBteSBS
YWRlb24gVklJIGFuZCBpdCB3b3JrZWQgZmluZSByZWdhcmRsZXNzIG9mIHRoZSBHVFQgCnNpemUg
dGhlcmUsIGFsdGhvdWdoIHRoYXQgY2FyZCBoYXMgbW9yZSB0aGFuIGVub3VnaCB2aWRlbyBtZW1v
cnkgYW55IHdheSAKZm9yIG5vdGhpbmcgdG8gYmUgYW4gaXNzdWUgdGhlcmUg8J+QuC4KTGltaXRp
bmcgbXkgc3lzdGVtIG1lbW9yeSB0byAyR2lCLCB0aGUgY2FyZCdzIG1lbW9yeSBhbmQgdmlzaWJs
ZSBtZW1vcnkgCnRvIDFHaUIgYW5kIHRoZSBHVFQgdG8gMS43NUdpQiwgdGhlIHRlc3Qgd29ya3Mg
ZmluZS4KClRoZSBvbmx5IHRpbWUgSSBldmVyIGhhZCBwcm9ibGVtcyB3aXRoIGEgY3Jhc2ggb3Ig
cGVzdWRvLWhhbmcgKHdhaXRpbmcgCmZvciBPT00ga2lsbGVyIGJ1dCB0aGUgc3lzdGVtIHdhcyBs
b2NrZWQgdXApIHdhcyB3aGVuZXZlciBHVFQgd2FzID4gCnN5c3RlbSBtZW1vcnkgKGllLiBpbiB0
aGUgcmV2ZXJ0ZWQgY29tbWl0KQoKSWYgSSBlZGl0ZWQgbXkgY29tbWl0IHRvIHVuaXZlcnNhbGx5
IHVzZSAzLzR0aHMgb2YgdGhlIHN5c3RlbSBtZW1vcnkgZm9yIApHVFQgZm9yIGFsbCBoYXJkd2Fy
ZSwgd291bGQgdGhhdCBiZSBjb25zaWRlcmVkIHRvIGJlIG1lcmdlZD8KClRoYW5rcyEKLSBKb3No
aWUg8J+QuOKcqAoKPiAKPj4KPj4gLSBKb3NoaWUg8J+QuOKcqAo+IApfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
