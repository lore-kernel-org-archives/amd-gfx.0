Return-Path: <SRS0=0Udm=MU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31334C4320A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 11:51:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B87060F93
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 11:51:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACF7E6E0D7;
	Wed, 28 Jul 2021 11:51:02 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15AB56E0D7;
 Wed, 28 Jul 2021 11:51:01 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id e2so2167689wrq.6;
 Wed, 28 Jul 2021 04:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=yp5cWmb4AkxFKBl8NuqRHF/Fj+1O+kz07eQ9B1cFrTM=;
 b=rjufznQpIgT9Y4X5wATRAu5BDsSd6HgqZ5d9ZbD1tV5XqwI37bp4dlZn7sEU3roUWH
 clGVPK5HZt0ibEg3n3rnQO/LLfCGXNB1z/OcJviBqX5BnDvPAT6ovSqtf2GG9z+b2bf5
 hNRMQ5K1GU2t5utAkiIOYPFplsyDtoOtGyLrHrE0gjJStx3UlTxodAu66P1SUyVqHuRo
 M6T6x8SRy36Ns7u7LeNWzv4QGHqMLlVM5YZOdZC2fd6M+9vcopSschELbxKP610fuQ0E
 cnkAxdbpF2osQv7uYuvrxQu8i8zU9T8kP5ggNwdog+ispko+yCugJr87oZyjOacGVREA
 620A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=yp5cWmb4AkxFKBl8NuqRHF/Fj+1O+kz07eQ9B1cFrTM=;
 b=KIiZ2rYMZ0aMJhs+UJYSq8zJ5KAi128p997ZbYAfWPkHa0HAUIZfz/3xUnQF/AFSqw
 X+QldXtT1Vacd/0/VZpugv4gJaA7JkwuxcDb+1RP+XCr8Lva6wIylWqPEVZQZt2cyfBK
 6XO7ZZ3OeYK0zfCuJRvkE/eBvAduLplsXwg+VgNnRKKJKMAQXLPK7AQSW3VlQAc8ry6P
 xAZJiCnxuYdH4mnaOZKS5MGf+KrA6645K2UewcjeDLAMQtM+BZLzHzDCx+p6idg7XhtS
 OBpGqoB96k/iYxLULSDYxYAeQa5aqPN6p3uAcCYfoIZSFZdWT5vY5HRiai+q4cl5yYaX
 NaOw==
X-Gm-Message-State: AOAM533GbkxJv2dbL33kkvHLXWnlzzxPrw9CW1HSmjZMAGXvxPjy9eBF
 eDfzNQJ1md9JmWAtjqDG4L4=
X-Google-Smtp-Source: ABdhPJxnFTfpGwAmyL+B5BY1p5oMjCoBMdD/Omxoq7nc4R8MHgQpLQLkqKXCOPeVLSKKDmRSYkfgVw==
X-Received: by 2002:adf:d1c7:: with SMTP id b7mr22336082wrd.108.1627473059546; 
 Wed, 28 Jul 2021 04:50:59 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:6a5d:b580:2891:cbac?
 ([2a02:908:1252:fb60:6a5d:b580:2891:cbac])
 by smtp.gmail.com with ESMTPSA id q72sm7758671wme.14.2021.07.28.04.50.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jul 2021 04:50:59 -0700 (PDT)
Subject: Re: [PATCH 00/11] Implement generic prot_guest_has() helper function
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
 linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <cover.1627424773.git.thomas.lendacky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <5cd35ae7-a7ff-eca4-5d2a-f0dad94e1d7a@gmail.com>
Date: Wed, 28 Jul 2021 13:50:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1627424773.git.thomas.lendacky@amd.com>
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
Cc: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Brijesh Singh <brijesh.singh@amd.com>, David Airlie <airlied@linux.ie>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Paul Mackerras <paulus@samba.org>,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Andi Kleen <ak@linux.intel.com>, Baoquan He <bhe@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Joerg Roedel <joro@8bytes.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Dave Young <dyoung@redhat.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 Daniel Vetter <daniel@ffwll.ch>, Vasily Gorbik <gor@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Zimmermann <tzimmermann@suse.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjguMDcuMjEgdW0gMDA6MjYgc2NocmllYiBUb20gTGVuZGFja3k6Cj4gVGhpcyBwYXRjaCBz
ZXJpZXMgcHJvdmlkZXMgYSBnZW5lcmljIGhlbHBlciBmdW5jdGlvbiwgcHJvdF9ndWVzdF9oYXMo
KSwKPiB0byByZXBsYWNlIHRoZSBzbWVfYWN0aXZlKCksIHNldl9hY3RpdmUoKSwgc2V2X2VzX2Fj
dGl2ZSgpIGFuZAo+IG1lbV9lbmNyeXB0X2FjdGl2ZSgpIGZ1bmN0aW9ucy4KPgo+IEl0IGlzIGV4
cGVjdGVkIHRoYXQgYXMgbmV3IHByb3RlY3RlZCB2aXJ0dWFsaXphdGlvbiB0ZWNobm9sb2dpZXMg
YXJlCj4gYWRkZWQgdG8gdGhlIGtlcm5lbCwgdGhleSBjYW4gYWxsIGJlIGNvdmVyZWQgYnkgYSBz
aW5nbGUgZnVuY3Rpb24gY2FsbAo+IGluc3RlYWQgb2YgYSBjb2xsZWN0aW9uIG9mIHNwZWNpZmlj
IGZ1bmN0aW9uIGNhbGxzIGFsbCBjYWxsZWQgZnJvbSB0aGUKPiBzYW1lIGxvY2F0aW9ucy4KPgo+
IFRoZSBwb3dlcnBjIGFuZCBzMzkwIHBhdGNoZXMgaGF2ZSBiZWVuIGNvbXBpbGUgdGVzdGVkIG9u
bHkuIENhbiB0aGUKPiBmb2xrcyBjb3BpZWQgb24gdGhpcyBzZXJpZXMgdmVyaWZ5IHRoYXQgbm90
aGluZyBicmVha3MgZm9yIHRoZW0uCgpBcyBHUFUgZHJpdmVyIGRldiBJJ20gb25seSBvbmUgZW5k
IHVzZXIgb2YgdGhpcywgYnV0IGF0IGxlYXN0IGZyb20gdGhlIApoaWdoIGxldmVsIHBvaW50IG9m
IHZpZXcgdGhhdCBtYWtlcyB0b3RhbGx5IHNlbnNlIHRvIG1lLgoKRmVlbCBmcmVlIHRvIGFkZCBh
biBBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPi4K
CldlIGNvdWxkIHJ1biB0aGF0IHRocm91Z2ggdGhlIEFNRCBHUFUgdW5pdCB0ZXN0cywgYnV0IEkg
ZmVhciB3ZSBhY3R1YWxseSAKZG9uJ3QgdGVzdCBvbiBhIHN5c3RlbSB3aXRoIFNFVi9TTUUgYWN0
aXZlLgoKR29pbmcgdG8gcmFpc2UgdGhhdCBvbiBvdXIgdGVhbSBjYWxsIHRvZGF5LgoKUmVnYXJk
cywKQ2hyaXN0aWFuLgoKPgo+IENjOiBBbmRpIEtsZWVuIDxha0BsaW51eC5pbnRlbC5jb20+Cj4g
Q2M6IEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJuZWwub3JnPgo+IENjOiBBcmQgQmllc2hldXZl
bCA8YXJkYkBrZXJuZWwub3JnPgo+IENjOiBCYW9xdWFuIEhlIDxiaGVAcmVkaGF0LmNvbT4KPiBD
YzogQmVuamFtaW4gSGVycmVuc2NobWlkdCA8YmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnPgo+IENj
OiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4KPiBDYzogQ2hyaXN0aWFuIEJvcm50cmFl
Z2VyIDxib3JudHJhZWdlckBkZS5pYm0uY29tPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxA
ZmZ3bGwuY2g+Cj4gQ2M6IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+
Cj4gQ2M6IERhdmUgWW91bmcgPGR5b3VuZ0ByZWRoYXQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUg
PGFpcmxpZWRAbGludXguaWU+Cj4gQ2M6IEhlaWtvIENhcnN0ZW5zIDxoY2FAbGludXguaWJtLmNv
bT4KPiBDYzogSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+Cj4gQ2M6IEpvZXJnIFJvZWRl
bCA8am9yb0A4Ynl0ZXMub3JnPgo+IENjOiBNYWFydGVuIExhbmtob3JzdCA8bWFhcnRlbi5sYW5r
aG9yc3RAbGludXguaW50ZWwuY29tPgo+IENjOiBNYXhpbWUgUmlwYXJkIDxtcmlwYXJkQGtlcm5l
bC5vcmc+Cj4gQ2M6IE1pY2hhZWwgRWxsZXJtYW4gPG1wZUBlbGxlcm1hbi5pZC5hdT4KPiBDYzog
UGF1bCBNYWNrZXJyYXMgPHBhdWx1c0BzYW1iYS5vcmc+Cj4gQ2M6IFBldGVyIFppamxzdHJhIDxw
ZXRlcnpAaW5mcmFkZWFkLm9yZz4KPiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9u
aXguZGU+Cj4gQ2M6IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPgo+IENj
OiBWYXNpbHkgR29yYmlrIDxnb3JAbGludXguaWJtLmNvbT4KPiBDYzogVk13YXJlIEdyYXBoaWNz
IDxsaW51eC1ncmFwaGljcy1tYWludGFpbmVyQHZtd2FyZS5jb20+Cj4gQ2M6IFdpbGwgRGVhY29u
IDx3aWxsQGtlcm5lbC5vcmc+Cj4KPiAtLS0KPgo+IFBhdGNoZXMgYmFzZWQgb246Cj4gICAgaHR0
cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGlwL3RpcC5naXQg
bWFzdGVyCj4gICAgY29tbWl0IDc5ZTkyMDA2MGZhNyAoIk1lcmdlIGJyYW5jaCAnV0lQL2ZpeGVz
JyIpCj4KPiBUb20gTGVuZGFja3kgKDExKToKPiAgICBtbTogSW50cm9kdWNlIGEgZnVuY3Rpb24g
dG8gY2hlY2sgZm9yIHZpcnR1YWxpemF0aW9uIHByb3RlY3Rpb24KPiAgICAgIGZlYXR1cmVzCj4g
ICAgeDg2L3NldjogQWRkIGFuIHg4NiB2ZXJzaW9uIG9mIHByb3RfZ3Vlc3RfaGFzKCkKPiAgICBw
b3dlcnBjL3BzZXJpZXMvc3ZtOiBBZGQgYSBwb3dlcnBjIHZlcnNpb24gb2YgcHJvdF9ndWVzdF9o
YXMoKQo+ICAgIHg4Ni9zbWU6IFJlcGxhY2Ugb2NjdXJyZW5jZXMgb2Ygc21lX2FjdGl2ZSgpIHdp
dGggcHJvdF9ndWVzdF9oYXMoKQo+ICAgIHg4Ni9zZXY6IFJlcGxhY2Ugb2NjdXJyZW5jZXMgb2Yg
c2V2X2FjdGl2ZSgpIHdpdGggcHJvdF9ndWVzdF9oYXMoKQo+ICAgIHg4Ni9zZXY6IFJlcGxhY2Ug
b2NjdXJyZW5jZXMgb2Ygc2V2X2VzX2FjdGl2ZSgpIHdpdGggcHJvdF9ndWVzdF9oYXMoKQo+ICAg
IHRyZWV3aWRlOiBSZXBsYWNlIHRoZSB1c2Ugb2YgbWVtX2VuY3J5cHRfYWN0aXZlKCkgd2l0aAo+
ICAgICAgcHJvdF9ndWVzdF9oYXMoKQo+ICAgIG1tOiBSZW1vdmUgdGhlIG5vdyB1bnVzZWQgbWVt
X2VuY3J5cHRfYWN0aXZlKCkgZnVuY3Rpb24KPiAgICB4ODYvc2V2OiBSZW1vdmUgdGhlIG5vdyB1
bnVzZWQgbWVtX2VuY3J5cHRfYWN0aXZlKCkgZnVuY3Rpb24KPiAgICBwb3dlcnBjL3BzZXJpZXMv
c3ZtOiBSZW1vdmUgdGhlIG5vdyB1bnVzZWQgbWVtX2VuY3J5cHRfYWN0aXZlKCkKPiAgICAgIGZ1
bmN0aW9uCj4gICAgczM5MC9tbTogUmVtb3ZlIHRoZSBub3cgdW51c2VkIG1lbV9lbmNyeXB0X2Fj
dGl2ZSgpIGZ1bmN0aW9uCj4KPiAgIGFyY2gvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAzICsrCj4gICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vbWVtX2VuY3J5cHQu
aCAgICAgfCAgNSAtLQo+ICAgYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3Byb3RlY3RlZF9ndWVz
dC5oIHwgMzAgKysrKysrKysrKysKPiAgIGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9L
Y29uZmlnICAgICB8ICAxICsKPiAgIGFyY2gvczM5MC9pbmNsdWRlL2FzbS9tZW1fZW5jcnlwdC5o
ICAgICAgICB8ICAyIC0KPiAgIGFyY2gveDg2L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAxICsKPiAgIGFyY2gveDg2L2luY2x1ZGUvYXNtL2tleGVjLmggICAgICAgICAgICAg
ICB8ICAyICstCj4gICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tZW1fZW5jcnlwdC5oICAgICAgICAg
fCAxMyArLS0tLQo+ICAgYXJjaC94ODYvaW5jbHVkZS9hc20vcHJvdGVjdGVkX2d1ZXN0LmggICAg
IHwgMjcgKysrKysrKysrKwo+ICAgYXJjaC94ODYva2VybmVsL2NyYXNoX2R1bXBfNjQuYyAgICAg
ICAgICAgIHwgIDQgKy0KPiAgIGFyY2gveDg2L2tlcm5lbC9oZWFkNjQuYyAgICAgICAgICAgICAg
ICAgICB8ICA0ICstCj4gICBhcmNoL3g4Ni9rZXJuZWwva3ZtLmMgICAgICAgICAgICAgICAgICAg
ICAgfCAgMyArLQo+ICAgYXJjaC94ODYva2VybmVsL2t2bWNsb2NrLmMgICAgICAgICAgICAgICAg
IHwgIDQgKy0KPiAgIGFyY2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0LmMgICAgICAgICB8
IDE5ICsrKy0tLS0KPiAgIGFyY2gveDg2L2tlcm5lbC9wY2ktc3dpb3RsYi5jICAgICAgICAgICAg
ICB8ICA5ICsrLS0KPiAgIGFyY2gveDg2L2tlcm5lbC9yZWxvY2F0ZV9rZXJuZWxfNjQuUyAgICAg
ICB8ICAyICstCj4gICBhcmNoL3g4Ni9rZXJuZWwvc2V2LmMgICAgICAgICAgICAgICAgICAgICAg
fCAgNiArLS0KPiAgIGFyY2gveDg2L2t2bS9zdm0vc3ZtLmMgICAgICAgICAgICAgICAgICAgICB8
ICAzICstCj4gICBhcmNoL3g4Ni9tbS9pb3JlbWFwLmMgICAgICAgICAgICAgICAgICAgICAgfCAx
NiArKystLS0KPiAgIGFyY2gveDg2L21tL21lbV9lbmNyeXB0LmMgICAgICAgICAgICAgICAgICB8
IDYwICsrKysrKysrKysrKysrKy0tLS0tLS0KPiAgIGFyY2gveDg2L21tL21lbV9lbmNyeXB0X2lk
ZW50aXR5LmMgICAgICAgICB8ICAzICstCj4gICBhcmNoL3g4Ni9tbS9wYXQvc2V0X21lbW9yeS5j
ICAgICAgICAgICAgICAgfCAgMyArLQo+ICAgYXJjaC94ODYvcGxhdGZvcm0vZWZpL2VmaV82NC5j
ICAgICAgICAgICAgIHwgIDkgKystLQo+ICAgYXJjaC94ODYvcmVhbG1vZGUvaW5pdC5jICAgICAg
ICAgICAgICAgICAgIHwgIDggKy0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZHJ2LmMgICAgfCAgNCArLQo+ICAgZHJpdmVycy9ncHUvZHJtL2RybV9jYWNoZS5jICAgICAg
ICAgICAgICAgIHwgIDQgKy0KPiAgIGRyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X2Rydi5j
ICAgICAgICB8ICA0ICstCj4gICBkcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9tc2cuYyAg
ICAgICAgfCAgNiArLS0KPiAgIGRyaXZlcnMvaW9tbXUvYW1kL2luaXQuYyAgICAgICAgICAgICAg
ICAgICB8ICA3ICstLQo+ICAgZHJpdmVycy9pb21tdS9hbWQvaW9tbXUuYyAgICAgICAgICAgICAg
ICAgIHwgIDMgKy0KPiAgIGRyaXZlcnMvaW9tbXUvYW1kL2lvbW11X3YyLmMgICAgICAgICAgICAg
ICB8ICAzICstCj4gICBkcml2ZXJzL2lvbW11L2lvbW11LmMgICAgICAgICAgICAgICAgICAgICAg
fCAgMyArLQo+ICAgZnMvcHJvYy92bWNvcmUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDYgKy0tCj4gICBpbmNsdWRlL2xpbnV4L21lbV9lbmNyeXB0LmggICAgICAgICAgICAgICAgfCAg
NCAtLQo+ICAgaW5jbHVkZS9saW51eC9wcm90ZWN0ZWRfZ3Vlc3QuaCAgICAgICAgICAgIHwgMzcg
KysrKysrKysrKysrKwo+ICAga2VybmVsL2RtYS9zd2lvdGxiLmMgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDQgKy0KPiAgIDM2IGZpbGVzIGNoYW5nZWQsIDIxOCBpbnNlcnRpb25zKCspLCAxMDQg
ZGVsZXRpb25zKC0pCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9wb3dlcnBjL2luY2x1ZGUv
YXNtL3Byb3RlY3RlZF9ndWVzdC5oCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC94ODYvaW5j
bHVkZS9hc20vcHJvdGVjdGVkX2d1ZXN0LmgKPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRl
L2xpbnV4L3Byb3RlY3RlZF9ndWVzdC5oCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
