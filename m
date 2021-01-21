Return-Path: <SRS0=VJnr=GY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59B2C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 14:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D9C239A4
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 14:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D9C239A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B60176E8F1;
	Thu, 21 Jan 2021 14:02:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 42B8A6E8FA;
 Thu, 21 Jan 2021 14:02:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D145E11D4;
 Thu, 21 Jan 2021 06:02:13 -0800 (PST)
Received: from [192.168.1.179] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA3373F68F;
 Thu, 21 Jan 2021 06:02:11 -0800 (PST)
Subject: Re: [PATCH 1/1] drm/scheduler: Job timeout handler returns status (v3)
To: Luben Tuikov <luben.tuikov@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
References: <20210120200959.163533-1-luben.tuikov@amd.com>
 <20210120200959.163533-2-luben.tuikov@amd.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <6d9e3d9d-e513-b2f0-9447-243c40e218cb@arm.com>
Date: Thu, 21 Jan 2021 14:02:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210120200959.163533-2-luben.tuikov@amd.com>
Content-Language: en-GB
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 kernel test robot <lkp@intel.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Rob Herring <robh@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Eric Anholt <eric@anholt.net>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 Qiang Yu <yuq825@gmail.com>, Russell King <linux+etnaviv@armlinux.org.uk>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAvMDEvMjAyMSAyMDowOSwgTHViZW4gVHVpa292IHdyb3RlOgo+IFRoaXMgcGF0Y2ggZG9l
cyBub3QgY2hhbmdlIGN1cnJlbnQgYmVoYXZpb3VyLgo+IAo+IFRoZSBkcml2ZXIncyBqb2IgdGlt
ZW91dCBoYW5kbGVyIG5vdyByZXR1cm5zCj4gc3RhdHVzIGluZGljYXRpbmcgYmFjayB0byB0aGUg
RFJNIGxheWVyIHdoZXRoZXIKPiB0aGUgZGV2aWNlIChHUFUpIGlzIG5vIGxvbmdlciBhdmFpbGFi
bGUsIHN1Y2ggYXMKPiBhZnRlciBpdCdzIGJlZW4gdW5wbHVnZ2VkLCBvciB3aGV0aGVyIGFsbCBp
cwo+IG5vcm1hbCwgaS5lLiBjdXJyZW50IGJlaGF2aW91ci4KPiAKPiBBbGwgZHJpdmVycyB3aGlj
aCBtYWtlIHVzZSBvZiB0aGUKPiBkcm1fc2NoZWRfYmFja2VuZF9vcHMnIC50aW1lZG91dF9qb2Io
KSBjYWxsYmFjawo+IGhhdmUgYmVlbiBhY2NvcmRpbmdseSByZW5hbWVkIGFuZCByZXR1cm4gdGhl
Cj4gd291bGQndmUtYmVlbiBkZWZhdWx0IHZhbHVlIG9mCj4gRFJNX0dQVV9TQ0hFRF9TVEFUX05P
TUlOQUwgdG8gcmVzdGFydCB0aGUgdGFzaydzCj4gdGltZW91dCB0aW1lci0tdGhpcyBpcyB0aGUg
b2xkIGJlaGF2aW91ciwgYW5kIGlzCj4gcHJlc2VydmVkIGJ5IHRoaXMgcGF0Y2guCj4gCj4gdjI6
IFVzZSBlbnVtIGFzIHRoZSBzdGF0dXMgb2YgYSBkcml2ZXIncyBqb2IKPiAgICAgIHRpbWVvdXQg
Y2FsbGJhY2sgbWV0aG9kLgo+IAo+IHYzOiBSZXR1cm4gc2NoZWR1bGVyL2RldmljZSBpbmZvcm1h
dGlvbiwgcmF0aGVyCj4gICAgICB0aGFuIHRhc2sgaW5mb3JtYXRpb24uCj4gCj4gQ2M6IEFsZXhh
bmRlciBEZXVjaGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPgo+IENjOiBBbmRyZXkgR3Jv
ZHpvdnNreSA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT4KPiBDYzogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWwu
dmV0dGVyQGZmd2xsLmNoPgo+IENjOiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5k
ZT4KPiBDYzogUnVzc2VsbCBLaW5nIDxsaW51eCtldG5hdml2QGFybWxpbnV4Lm9yZy51az4KPiBD
YzogQ2hyaXN0aWFuIEdtZWluZXIgPGNocmlzdGlhbi5nbWVpbmVyQGdtYWlsLmNvbT4KPiBDYzog
UWlhbmcgWXUgPHl1cTgyNUBnbWFpbC5jb20+Cj4gQ2M6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5l
bC5vcmc+Cj4gQ2M6IFRvbWV1IFZpem9zbyA8dG9tZXUudml6b3NvQGNvbGxhYm9yYS5jb20+Cj4g
Q2M6IFN0ZXZlbiBQcmljZSA8c3RldmVuLnByaWNlQGFybS5jb20+Cj4gQ2M6IEFseXNzYSBSb3Nl
bnp3ZWlnIDxhbHlzc2Eucm9zZW56d2VpZ0Bjb2xsYWJvcmEuY29tPgo+IENjOiBFcmljIEFuaG9s
dCA8ZXJpY0BhbmhvbHQubmV0Pgo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtw
QGludGVsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBMdWJlbiBUdWlrb3YgPGx1YmVuLnR1aWtvdkBh
bWQuY29tPgoKQWNrZWQtYnk6IFN0ZXZlbiBQcmljZSA8c3RldmVuLnByaWNlQGFybS5jb20+Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
