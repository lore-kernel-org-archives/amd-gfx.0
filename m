Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CA6C4708D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 737B960FD8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737B960FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B94926ECFE;
	Wed, 26 May 2021 12:57:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id DB1606EC7A
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 10:59:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E4A91516;
 Wed, 26 May 2021 03:59:49 -0700 (PDT)
Received: from [10.57.73.64] (unknown [10.57.73.64])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EA093F73B;
 Wed, 26 May 2021 03:59:48 -0700 (PDT)
Subject: Re: radeon ring 0 test failed on arm64
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>, Peter Geis <pgwipeout@gmail.com>
References: <CAMdYzYptw9L=5SECtVkNZruTT-x57+03vj0A+5efvq8cESzLyQ@mail.gmail.com>
 <CADnq5_NXmRr_Q7JuWZxJAjmavVkvJjNcWayQ1x8LhfcX5CS0uA@mail.gmail.com>
 <CAMdYzYoamh-igvBbKaLSJ6bSc3wA29=8mooJDLMJkj9YQ=wj0A@mail.gmail.com>
 <CADnq5_NXFZPA_z6413FDgr8WRObhCB+HdkHE5P=PAAMV4FiWiA@mail.gmail.com>
 <20dffd4d-fa54-5bc3-c13b-f8ffbf0fb593@arm.com>
 <599edb94-8294-c4c5-ff7f-84c7072af3dd@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <546bf682-565f-8384-ec80-201ce1c747f4@arm.com>
Date: Wed, 26 May 2021 11:59:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <599edb94-8294-c4c5-ff7f-84c7072af3dd@gmail.com>
Content-Language: en-GB
X-Mailman-Approved-At: Wed, 26 May 2021 12:57:23 +0000
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wNS0yNiAxMDo0MiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBIaSBSb2JpbiwK
PiAKPiBBbSAyNS4wNS4yMSB1bSAyMjowOSBzY2hyaWViIFJvYmluIE11cnBoeToKPj4gT24gMjAy
MS0wNS0yNSAxNDowNSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+Pj4gT24gVHVlLCBNYXkgMjUsIDIw
MjEgYXQgODo1NiBBTSBQZXRlciBHZWlzIDxwZ3dpcGVvdXRAZ21haWwuY29tPiB3cm90ZToKPj4+
Pgo+Pj4+IE9uIFR1ZSwgTWF5IDI1LCAyMDIxIGF0IDg6NDcgQU0gQWxleCBEZXVjaGVyIDxhbGV4
ZGV1Y2hlckBnbWFpbC5jb20+IAo+Pj4+IHdyb3RlOgo+Pj4+Pgo+Pj4+PiBPbiBUdWUsIE1heSAy
NSwgMjAyMSBhdCA4OjQyIEFNIFBldGVyIEdlaXMgPHBnd2lwZW91dEBnbWFpbC5jb20+IAo+Pj4+
PiB3cm90ZToKPj4+Pj4+Cj4+Pj4+PiBHb29kIEV2ZW5pbmcsCj4+Pj4+Pgo+Pj4+Pj4gSSBhbSBz
dHJlc3MgdGVzdGluZyB0aGUgcGNpZSBjb250cm9sbGVyIG9uIHRoZSByazM1NjYtcXVhcnR6NjQg
Cj4+Pj4+PiBwcm90b3R5cGUgU0JDLgo+Pj4+Pj4gVGhpcyBkZXZpY2UgaGFzIDFHQiBhdmFpbGFi
bGUgYXQgPDB4MyAweDAwMDAwMDAwPiBmb3IgdGhlIFBDSWUKPj4+Pj4+IGNvbnRyb2xsZXIsIHdo
aWNoIG1ha2VzIGEgZEdQVSB0aGVvcmV0aWNhbGx5IHBvc3NpYmxlLgo+Pj4+Pj4gV2hpbGUgYXR0
ZW1wdGluZyB0byBsaWdodCBvZmYgYSBIRDc1NzAgY2FyZCBJIG1hbmFnZSB0byBnZXQgYSBtb2Rl
c2V0Cj4+Pj4+PiBjb25zb2xlLCBidXQgcmluZzAgdGVzdCBmYWlscyBhbmQgZGlzYWJsZXMgYWNj
ZWxlcmF0aW9uLgo+Pj4+Pj4KPj4+Pj4+IE5vdGUsIHdlIGRvIG5vdCBoYXZlIFVFRkksIHNvIGFs
bCBQQ0llIHNldHVwIGlzIGZyb20gdGhlIExpbnV4IAo+Pj4+Pj4ga2VybmVsLgo+Pj4+Pj4gQW55
IGluc2lnaHQgeW91IGNhbiBwcm92aWRlIHdvdWxkIGJlIG11Y2ggYXBwcmVjaWF0ZWQuCj4+Pj4+
Cj4+Pj4+IERvZXMgeW91ciBwbGF0Zm9ybSBzdXBwb3J0IFBDSWUgY2FjaGUgY29oZXJlbmN5IHdp
dGggdGhlIENQVT/CoCBJLmUuLAo+Pj4+PiBkb2VzIHRoZSBDUFUgYWxsb3cgY2FjaGUgc25vb3Bz
IGZyb20gUENJZSBkZXZpY2VzP8KgIFRoYXQgaXMgcmVxdWlyZWQKPj4+Pj4gZm9yIHRoZSBkcml2
ZXIgdG8gb3BlcmF0ZS4KPj4+Pgo+Pj4+IEFoLCBtb3N0IGxpa2VseSBub3QuCj4+Pj4gVGhpcyBp
c3N1ZSBoYXMgY29tZSB1cCBhbHJlYWR5IGFzIHRoZSBHSUMgaXNuJ3QgcGVybWl0dGVkIHRvIHNu
b29wIG9uCj4+Pj4gdGhlIENQVXMsIHNvIEkgZG91YnQgdGhlIFBDSWUgY29udHJvbGxlciBjYW4g
ZWl0aGVyLgo+Pj4+Cj4+Pj4gSXMgdGhlcmUgbm8gd2F5IHRvIHdvcmsgYXJvdW5kIHRoaXMgb3Ig
aXMgaXQgZGVhZCBpbiB0aGUgd2F0ZXI/Cj4+Pgo+Pj4gSXQncyByZXF1aXJlZCBieSB0aGUgcGNp
ZSBzcGVjLsKgIFlvdSBjb3VsZCBwb3RlbnRpYWxseSB3b3JrIGFyb3VuZCBpdAo+Pj4gaWYgeW91
IGNhbiBhbGxvY2F0ZSB1bmNhY2hlZCBtZW1vcnkgZm9yIERNQSwgYnV0IEkgZG9uJ3QgdGhpbmsg
dGhhdCBpcwo+Pj4gcG9zc2libGUgY3VycmVudGx5LsKgIElkZWFsbHkgd2UnZCBmaWd1cmUgb3V0
IHNvbWUgd2F5IHRvIGRldGVjdCBpZiBhCj4+PiBwYXJ0aWN1bGFyIHBsYXRmb3JtIHN1cHBvcnRz
IGNhY2hlIHNub29waW5nIG9yIG5vdCBhcyB3ZWxsLgo+Pgo+PiBUaGVyZSdzIGRldmljZV9nZXRf
ZG1hX2F0dHIoKSwgYWx0aG91Z2ggSSBkb24ndCB0aGluayBpdCB3aWxsIHdvcmsgCj4+IGN1cnJl
bnRseSBmb3IgUENJIGRldmljZXMgd2l0aG91dCBhbiBPRiBvciBBQ1BJIG5vZGUgLSB3ZSBjb3Vs
ZCAKPj4gcGVyaGFwcyBkbyB3aXRoIGEgUENJLXNwZWNpZmljIHdyYXBwZXIgd2hpY2ggY2FuIHdh
bGsgdXAgYW5kIGRlZmVyIHRvIAo+PiB0aGUgaG9zdCBicmlkZ2UncyBmaXJtd2FyZSBkZXNjcmlw
dGlvbiBhcyBuZWNlc3NhcnkuCj4+Cj4+IFRoZSBjb21tb24gRE1BIG9wcyAqZG8qIGNvcnJlY3Rs
eSBrZWVwIHRyYWNrIG9mIHBlci1kZXZpY2UgY29oZXJlbmN5IAo+PiBpbnRlcm5hbGx5LCBidXQg
ZHJpdmVycyBhcmVuJ3Qgc3VwcG9zZWQgdG8gYmUgcG9raW5nIGF0IHRoYXQgCj4+IGluZm9ybWF0
aW9uIGRpcmVjdGx5Lgo+IAo+IFRoYXQgc291bmRzIGxpa2UgeW91IHVuZGVyZXN0aW1hdGUgdGhl
IHByb2JsZW0uIEFSTSBoYXMgdW5mb3J0dW5hdGVseSAKPiBtYWRlIHRoZSBjb2hlcmVuY3kgZm9y
IFBDSSBhbiBvcHRpb25hbCBJUC4KClNvcnJ5IHRvIGJlIHRoYXQgZ3V5LCBidXQgSSdtIGludm9s
dmVkIGEgbG90IGludGVybmFsbHkgd2l0aCBvdXIgc3lzdGVtIApJUCBhbmQgaW50ZXJjb25uZWN0
LCBhbmQgSSBwcm9iYWJseSB1bmRlcnN0YW5kIHRoZSBzaXR1YXRpb24gYmV0dGVyIHRoYW4gCjk5
JSBvZiB0aGUgY29tbXVuaXR5IDspCgpGb3IgdGhlIHJlY29yZCwgdGhlIFNCU0Egc3BlY2lmaWNh
dGlvbiAodGhlIGNsb3NldCB0aGluZyB3ZSBoYXZlIHRvIGEgCiJzeXN0ZW0gYXJjaGl0ZWN0dXJl
IikgZG9lcyByZXF1aXJlIHRoYXQgUENJZSBpcyBpbnRlZ3JhdGVkIGluIGFuIApJL08tY29oZXJl
bnQgbWFubmVyLCBidXQgd2UgZG9uJ3QgaGF2ZSBhbnkgY29udHJvbCBvdmVyIHdoYXQgcGVvcGxl
IGRvIAppbiBlbWJlZGRlZCBhcHBsaWNhdGlvbnMgKG5vdGUgdGhhdCB3ZSBkb24ndCBtYWtlIFBD
SWUgSVAgYXQgYWxsLCBhbmQgCnRoZXJlIGlzIHBsZW50eSBvZiAzcmQtcGFydHkgaW50ZXJjb25u
ZWN0IElQKS4KCj4gU28gd2UgYXJlIHRhbGtpbmcgYWJvdXQgYSBoYXJkd2FyZSBsaW1pdGF0aW9u
IHdoaWNoIHBvdGVudGlhbGx5IGNhbid0IGJlIAo+IGZpeGVkIHdpdGhvdXQgcmVwbGFjaW5nIHRo
ZSBoYXJkd2FyZS4KCllvdSBleHByZXNzZWQgaW50ZXJlc3QgaW4gInNvbWUgd2F5IHRvIGRldGVj
dCBpZiBhIHBhcnRpY3VsYXIgcGxhdGZvcm0gCnN1cHBvcnRzIGNhY2hlIHNub29waW5nIG9yIG5v
dCIsIGJ5IHdoaWNoIEkgYXNzdW1lZCB5b3UgbWVhbnQgYSBzb2Z0d2FyZSAKbWV0aG9kIGZvciB0
aGUgYW1kZ3B1L3JhZGVvbiBkcml2ZXJzIHRvIGNhbGwsIHJhdGhlciB0aGFuLCBzYXksIGEgCndl
YnNpdGUgdGhhdCBkcml2ZXIgbWFpbnRhaW5lcnMgY2FuIGxvb2sgdXAgU29DIG5hbWVzIG9uLiBJ
J20gc2F5aW5nIAp0aGF0IHRoYXQgQVBJIGFscmVhZHkgZXhpc3RzIChqdXN0IG1heSBuZWVkIGEg
Yml0IG1vcmUgd29yaykuIE5vdGUgdGhhdCAKaXQgaXMgZW1waGF0aWNhbGx5IG5vdCBhIHBsYXRm
b3JtLWxldmVsIHRoaW5nIHNpbmNlIGNvaGVyZW5jeSBjYW4gYW5kIApkb2VzIHZhcnkgcGVyIGRl
dmljZSB3aXRoaW4gYSBzeXN0ZW0uCgpJIHdhc24ndCBzdWdnZXN0aW5nIHRoYXQgTGludXggY291
bGQgc29tZWhvdyBtYWtlIGNvaGVyZW5jeSBtYWdpY2FsbHkgCndvcmsgd2hlbiB0aGUgc2lnbmFs
cyBkb24ndCBwaHlzaWNhbGx5IGV4aXN0IGluIHRoZSBpbnRlcmNvbm5lY3QgLSBJIHdhcyAKYXNz
dW1pbmcgeW91J2QgbWVyZWx5IHdhbnQgdG8gZG8gc29tZXRoaW5nIGxpa2UgdGhyb3cgYSBiaWcg
d2FybmluZyBhbmQgCnRhaW50IHRoZSBrZXJuZWwgdG8gaGVscCB0cmlhZ2UgYnVnIHJlcG9ydHMu
IFNvbWUgZHJpdmVycyBsaWtlIAphaGNpX3FvcmlxIGFuZCBwYW5mcm9zdCBzaW1wbHkgbmVlZCB0
byBrbm93IHNvIHRoZXkgY2FuIHByb2dyYW0gdGhlaXIgCmRldmljZSB0byBlbWl0IHRoZSBhcHBy
b3ByaWF0ZSBtZW1vcnkgYXR0cmlidXRlcyBlaXRoZXIgd2F5LCBhbmQgcmVseSBvbiAKdGhlIERN
QSBBUEkgdG8gaGlkZSB0aGUgcmVzdCBvZiB0aGUgZGlmZmVyZW5jZSwgYnV0IGlmIHlvdSB3YW50
IHRvIHRyZWF0IApub24tY29oZXJlbnQgdXNlIGFzIHVuc3VwcG9ydGVkIGJlY2F1c2UgaXQgd291
bGQgcmVxdWlyZSB0b28gaW52YXNpdmUgCmNoYW5nZXMgdGhhdCdzIGZpbmUgYnkgbWUuCgpSb2Jp
bi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
