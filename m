Return-Path: <SRS0=8Fgq=FS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4248C4361B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 20:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B14F222BB
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 20:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B14F222BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A966589369;
	Mon, 14 Dec 2020 20:42:22 +0000 (UTC)
X-Greylist: delayed 312 seconds by postgrey-1.36 at gabe;
 Mon, 14 Dec 2020 20:32:05 UTC
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F9196E14D;
 Mon, 14 Dec 2020 20:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1607977923;
 bh=+mU9WjHrdi6eFO74MIWK3y42IifRVlOs63M0wiamOGE=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=brXl6mmbqb/c7uiWOFjYgFZT+0KjOdBmwRe0Ceo2kYa9oiepT5246Pq5EOVr/YMeb
 ihtskFi2WX8c9rSi/zIi9bGkKk1uCjRzwjLLxhEX+3xKGmxGeh8ejvAThdt+b3QbeN
 jouKD1Zfxp2Iuf0F7cePM3lIBC8/4D8oC69aX048=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.10.10] ([88.215.87.53]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lh6bn-1kI6V42mCV-00oW0T; Mon, 14
 Dec 2020 21:26:33 +0100
Subject: Re: [PATCH v3 6/7] drm: Validate encoder->possible_crtcs
To: Alex Deucher <alexdeucher@gmail.com>
References: <20200211162208.16224-1-ville.syrjala@linux.intel.com>
 <20200211162208.16224-7-ville.syrjala@linux.intel.com>
 <20200211170429.GM2363188@phenom.ffwll.local>
 <f61d40ca-4d09-5fbe-6bbf-ab59d060b085@web.de>
 <CAKMK7uEC+nTWui9U+0jDSUnJ3ih0b1S4TBeOo7-MoHHagOh+Cg@mail.gmail.com>
 <MN2PR12MB44880FE75B52D68700B73580F7270@MN2PR12MB4488.namprd12.prod.outlook.com>
 <14829fe8-b6be-8c57-300e-c16b5c0970e8@web.de>
 <CADnq5_PPPbVwRmDP8wLw2VomfD6HVENL7iGeapNdOjzedCLyAg@mail.gmail.com>
 <CADnq5_O7cgHO=tB+a2R2KP6STt8EOgAG7CU-BfMvxaO2o3RsxQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <c3a11877-4b41-d2d6-10d6-8225ed12af78@web.de>
Date: Mon, 14 Dec 2020 21:26:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_O7cgHO=tB+a2R2KP6STt8EOgAG7CU-BfMvxaO2o3RsxQ@mail.gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:H9cH+NC3zHVxDDRAp6t2emtwtrUw83thBQUWTWo11lo1WGa819S
 +bijvJNRktPqOcl0Ea5rKZ4kylWJ/ZZ36/Ou0FdmuzNRuFFYf+ZR++tMH/y8YJdxXODOmmV
 vJDzxSMReo/u7rX5fp/vRxgSJYf8gSeUe8MvHhjtZQAC84xIKYbG1JJgN3lDa6rn4KNAZxA
 pE48zaPuY9Y3B0770PVog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x5lzuv6FaUQ=:RxzbQfEphm17thg6rL5+s5
 S28GhEsNxNGDxhq4QDLfvM4j8efm3zz2QSDNJmhP7e5IQohWaPuRj5p+o4Q6A2eP5EabaUDZw
 5z88czG0jsQqGbrG2c/25f7d9BPMMfTDxssRGRmLOMN+G5tRyY08nhoTDRJoYnDddkA4I421E
 ilCWmbCzqs98aQCzAxAYQ470l+2yxfBzXF67HH8UCQqnjFam8MOcw8Ubjc0aCUmZbgHGx3lrQ
 lpLJpht0aGvYzzpjuwj2kgFP4sR3EKac5UqEFcKzSi/mlVNv2TPSasw2OZ3kM7u4mslnUJs5B
 aTAbGyttcwkWDk3API66QUd1byyIehOCioBnnFQZ9mr0GxgKn67vGDzqQSEThBfD2L0I69IDi
 a6kPM7UgcbpQhlJA7VNT0RKqnG6tytUic9GOujm0bPQglf88FfzZTYmpDOCE1GC2bv0+oPXCG
 Ofwnn/ayCFKhWh3hHcZO8kpXvdpcOUUZakjFXr2RM0LBxXg8eTvh92DyUu9WazgRHTNjhQRYp
 XliKVR6iI5l1oGmAG4ob53emFxuSUzMbVTDxkqJAPMqSxb+/eBx/vQM2lZgC3sBf/YBEJjUnt
 QF14xbaF3/NdvAS1M1bvzR5Go8Zm4JiGRuW5xjZ6du5vgKA4A6wHED46QV96lX0b/ZKCJMHGj
 6d3PTS0wg72iVFrLBtUvREycwo7LjFM2Zx9WZWUlwCxOX0c6kjtP/T98rt+9nkKoqmH4dzk3C
 gOHvr5WQVOw9ZbAuowjiy7Gix4dGmk/yGIIj9MjGQX2knDHoAUdKcH2YnGwsEIdm33YWYzIz0
 zBWv/8rFeUSRS5gvOOAb6n8mnO/ldIdbrgj50ZSAZeOHSLtUvA82NZyeGHyAwKYwHuCXy9IPq
 5F+qxSQv3H9EmU151F0Q==
X-Mailman-Approved-At: Mon, 14 Dec 2020 20:42:21 +0000
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
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>,
 Ville Syrjala <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMDMuMTIuMjAgMjI6MzAsIEFsZXggRGV1Y2hlciB3cm90ZToKPiBPbiBUdWUsIFNlcCAyOSwg
MjAyMCBhdCA0OjA0IFBNIEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPiB3cm90
ZToKPj4KPj4gT24gVHVlLCBTZXAgMjksIDIwMjAgYXQgODozMSBBTSBKYW4gS2lzemthIDxqYW4u
a2lzemthQHdlYi5kZT4gd3JvdGU6Cj4+Pgo+Pj4gT24gMTAuMDkuMjAgMjA6MTgsIERldWNoZXIs
IEFsZXhhbmRlciB3cm90ZToKPj4+PiBbQU1EIFB1YmxpYyBVc2VdCj4+Pj4KPj4+Pgo+Pj4+Cj4+
Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4+Pj4+IEZyb206IGFtZC1nZnggPGFtZC1n
ZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZgo+Pj4+PiBEYW5p
ZWwgVmV0dGVyCj4+Pj4+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDcsIDIwMjAgMzoxNSBBTQo+
Pj4+PiBUbzogSmFuIEtpc3prYSA8amFuLmtpc3prYUB3ZWIuZGU+OyBhbWQtZ2Z4IGxpc3QgPGFt
ZC0KPj4+Pj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz47IFdlbnRsYW5kLCBIYXJyeSA8SGFy
cnkuV2VudGxhbmRAYW1kLmNvbT47Cj4+Pj4+IEthemxhdXNrYXMsIE5pY2hvbGFzIDxOaWNob2xh
cy5LYXpsYXVza2FzQGFtZC5jb20+Cj4+Pj4+IENjOiBkcmktZGV2ZWwgPGRyaS1kZXZlbEBsaXN0
cy5mcmVlZGVza3RvcC5vcmc+OyBpbnRlbC1nZnggPGludGVsLQo+Pj4+PiBnZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnPjsgVGhvbWFzIFppbW1lcm1hbm4KPj4+Pj4gPHR6aW1tZXJtYW5uQHN1c2Uu
ZGU+OyBWaWxsZSBTeXJqYWxhIDx2aWxsZS5zeXJqYWxhQGxpbnV4LmludGVsLmNvbT4KPj4+Pj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MyA2LzddIGRybTogVmFsaWRhdGUgZW5jb2Rlci0+cG9zc2li
bGVfY3J0Y3MKPj4+Pj4KPj4+Pj4gT24gU3VuLCBTZXAgNiwgMjAyMCBhdCAxOjE5IFBNIEphbiBL
aXN6a2EgPGphbi5raXN6a2FAd2ViLmRlPiB3cm90ZToKPj4+Pj4+Cj4+Pj4+PiBPbiAxMS4wMi4y
MCAxODowNCwgRGFuaWVsIFZldHRlciB3cm90ZToKPj4+Pj4+PiBPbiBUdWUsIEZlYiAxMSwgMjAy
MCBhdCAwNjoyMjowN1BNICswMjAwLCBWaWxsZSBTeXJqYWxhIHdyb3RlOgo+Pj4+Pj4+PiBGcm9t
OiBWaWxsZSBTeXJqw6Rsw6QgPHZpbGxlLnN5cmphbGFAbGludXguaW50ZWwuY29tPgo+Pj4+Pj4+
Pgo+Pj4+Pj4+PiBXQVJOIGlmIHRoZSBlbmNvZGVyIHBvc3NpYmxlX2NydGNzIGlzIGVmZmVjdGl2
ZWx5IGVtcHR5IG9yIGNvbnRhaW5zCj4+Pj4+Pj4+IGJpdHMgZm9yIG5vbi1leGlzdGluZyBjcnRj
cy4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gdjI6IE1vdmUgdG8gZHJtX21vZGVfY29uZmlnX3ZhbGlkYXRl
KCkgKERhbmllbCkKPj4+Pj4+Pj4gICAgIE1ha2UgdGhlIGRvY3Mgc2F5IHdlIFdBUk4gd2hlbiB0
aGlzIGlzIHdyb25nIChEYW5pZWwpCj4+Pj4+Pj4+ICAgICBFeHRyYWN0IGZ1bGxfY3J0Y19tYXNr
KCkKPj4+Pj4+Pj4KPj4+Pj4+Pj4gQ2M6IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBz
dXNlLmRlPgo+Pj4+Pj4+PiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+Pj4+
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBWaWxsZSBTeXJqw6Rsw6QgPHZpbGxlLnN5cmphbGFAbGludXgu
aW50ZWwuY29tPgo+Pj4+Pj4+Cj4+Pj4+Pj4gV2hlbiBwdXNoaW5nIHRoZSBmaXh1cCBuZWVkcyB0
byBiZSBhcHBsaWVkIGJlZm9yZSB0aGUgdmFsaWRhdGlvbgo+Pj4+Pj4+IHBhdGNoIGhlcmUsIGJl
Y2F1c2Ugd2UgZG9uJ3Qgd2FudCB0byBhbmdlciB0aGUgYmlzZWN0IGdvZHMuCj4+Pj4+Pj4KPj4+
Pj4+PiBSZXZpZXdlZC1ieTogRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZldHRlckBmZndsbC5jaD4K
Pj4+Pj4+Pgo+Pj4+Pj4+IEkgdGhpbmsgd2l0aCB0aGUgZml4dXAgd2Ugc2hvdWxkIGJlIGdvb2Qg
ZW5vdWdoIHdpdGggdGhlIGV4aXN0aW5nCj4+Pj4+Pj4gbm9uc2Vuc2UgaW4gZHJpdmVycy4gRmlu
Z2VycyBjcm9zc2VkLgo+Pj4+Pj4+IC1EYW5pZWwKPj4+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Pj4+IC0t
LQo+Pj4+Pj4+PiAgZHJpdmVycy9ncHUvZHJtL2RybV9tb2RlX2NvbmZpZy5jIHwgMjcKPj4+Pj4g
KysrKysrKysrKysrKysrKysrKysrKysrKystCj4+Pj4+Pj4+ICBpbmNsdWRlL2RybS9kcm1fZW5j
b2Rlci5oICAgICAgICAgfCAgMiArLQo+Pj4+Pj4+PiAgMiBmaWxlcyBjaGFuZ2VkLCAyNyBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2RybV9tb2RlX2NvbmZpZy5jCj4+Pj4+Pj4+IGIvZHJpdmVycy9ncHUv
ZHJtL2RybV9tb2RlX2NvbmZpZy5jCj4+Pj4+Pj4+IGluZGV4IGFmYzkxNDQ3MjkzYS4uNGMxYjM1
MGRkYjk1IDEwMDY0NAo+Pj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX21vZGVfY29u
ZmlnLmMKPj4+Pj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV9tb2RlX2NvbmZpZy5jCj4+
Pj4+Pj4+IEBAIC01ODEsNiArNTgxLDI5IEBAIHN0YXRpYyB2b2lkCj4+Pj4+IHZhbGlkYXRlX2Vu
Y29kZXJfcG9zc2libGVfY2xvbmVzKHN0cnVjdCBkcm1fZW5jb2RlciAqZW5jb2RlcikKPj4+Pj4+
Pj4gICAgICAgICAgIGVuY29kZXItPnBvc3NpYmxlX2Nsb25lcywgZW5jb2Rlcl9tYXNrKTsgIH0K
Pj4+Pj4+Pj4KPj4+Pj4+Pj4gK3N0YXRpYyB1MzIgZnVsbF9jcnRjX21hc2soc3RydWN0IGRybV9k
ZXZpY2UgKmRldikgewo+Pj4+Pj4+PiArICAgIHN0cnVjdCBkcm1fY3J0YyAqY3J0YzsKPj4+Pj4+
Pj4gKyAgICB1MzIgY3J0Y19tYXNrID0gMDsKPj4+Pj4+Pj4gKwo+Pj4+Pj4+PiArICAgIGRybV9m
b3JfZWFjaF9jcnRjKGNydGMsIGRldikKPj4+Pj4+Pj4gKyAgICAgICAgICAgIGNydGNfbWFzayB8
PSBkcm1fY3J0Y19tYXNrKGNydGMpOwo+Pj4+Pj4+PiArCj4+Pj4+Pj4+ICsgICAgcmV0dXJuIGNy
dGNfbWFzazsKPj4+Pj4+Pj4gK30KPj4+Pj4+Pj4gKwo+Pj4+Pj4+PiArc3RhdGljIHZvaWQgdmFs
aWRhdGVfZW5jb2Rlcl9wb3NzaWJsZV9jcnRjcyhzdHJ1Y3QgZHJtX2VuY29kZXIKPj4+Pj4+Pj4g
KyplbmNvZGVyKSB7Cj4+Pj4+Pj4+ICsgICAgdTMyIGNydGNfbWFzayA9IGZ1bGxfY3J0Y19tYXNr
KGVuY29kZXItPmRldik7Cj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4gKyAgICBXQVJOKChlbmNvZGVyLT5w
b3NzaWJsZV9jcnRjcyAmIGNydGNfbWFzaykgPT0gMCB8fAo+Pj4+Pj4+PiArICAgICAgICAgKGVu
Y29kZXItPnBvc3NpYmxlX2NydGNzICYgfmNydGNfbWFzaykgIT0gMCwKPj4+Pj4+Pj4gKyAgICAg
ICAgICJCb2d1cyBwb3NzaWJsZV9jcnRjczogIgo+Pj4+Pj4+PiArICAgICAgICAgIltFTkNPREVS
OiVkOiVzXSBwb3NzaWJsZV9jcnRjcz0weCV4IChmdWxsIGNydGMgbWFzaz0weCV4KVxuIiwKPj4+
Pj4+Pj4gKyAgICAgICAgIGVuY29kZXItPmJhc2UuaWQsIGVuY29kZXItPm5hbWUsCj4+Pj4+Pj4+
ICsgICAgICAgICBlbmNvZGVyLT5wb3NzaWJsZV9jcnRjcywgY3J0Y19tYXNrKTsgfQo+Pj4+Pj4+
PiArCj4+Pj4+Pj4+ICB2b2lkIGRybV9tb2RlX2NvbmZpZ192YWxpZGF0ZShzdHJ1Y3QgZHJtX2Rl
dmljZSAqZGV2KSAgewo+Pj4+Pj4+PiAgICAgIHN0cnVjdCBkcm1fZW5jb2RlciAqZW5jb2RlcjsK
Pj4+Pj4+Pj4gQEAgLTU4OCw2ICs2MTEsOCBAQCB2b2lkIGRybV9tb2RlX2NvbmZpZ192YWxpZGF0
ZShzdHJ1Y3QKPj4+Pj4gZHJtX2RldmljZSAqZGV2KQo+Pj4+Pj4+PiAgICAgIGRybV9mb3JfZWFj
aF9lbmNvZGVyKGVuY29kZXIsIGRldikKPj4+Pj4+Pj4gICAgICAgICAgICAgIGZpeHVwX2VuY29k
ZXJfcG9zc2libGVfY2xvbmVzKGVuY29kZXIpOwo+Pj4+Pj4+Pgo+Pj4+Pj4+PiAtICAgIGRybV9m
b3JfZWFjaF9lbmNvZGVyKGVuY29kZXIsIGRldikKPj4+Pj4+Pj4gKyAgICBkcm1fZm9yX2VhY2hf
ZW5jb2RlcihlbmNvZGVyLCBkZXYpIHsKPj4+Pj4+Pj4gICAgICAgICAgICAgIHZhbGlkYXRlX2Vu
Y29kZXJfcG9zc2libGVfY2xvbmVzKGVuY29kZXIpOwo+Pj4+Pj4+PiArICAgICAgICAgICAgdmFs
aWRhdGVfZW5jb2Rlcl9wb3NzaWJsZV9jcnRjcyhlbmNvZGVyKTsKPj4+Pj4+Pj4gKyAgICB9Cj4+
Pj4+Pj4+ICB9Cj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9kcm1fZW5jb2Rlci5o
IGIvaW5jbHVkZS9kcm0vZHJtX2VuY29kZXIuaAo+Pj4+Pj4+PiBpbmRleCAzNzQxOTYzYjk1ODcu
LmIyMzYyNjlmNDFhYyAxMDA2NDQKPj4+Pj4+Pj4gLS0tIGEvaW5jbHVkZS9kcm0vZHJtX2VuY29k
ZXIuaAo+Pj4+Pj4+PiArKysgYi9pbmNsdWRlL2RybS9kcm1fZW5jb2Rlci5oCj4+Pj4+Pj4+IEBA
IC0xNDIsNyArMTQyLDcgQEAgc3RydWN0IGRybV9lbmNvZGVyIHsKPj4+Pj4+Pj4gICAgICAgKiB0
aGUgYml0cyBmb3IgYWxsICZkcm1fY3J0YyBvYmplY3RzIHRoaXMgZW5jb2RlciBjYW4gYmUgY29u
bmVjdGVkIHRvCj4+Pj4+Pj4+ICAgICAgICogYmVmb3JlIGNhbGxpbmcgZHJtX2Rldl9yZWdpc3Rl
cigpLgo+Pj4+Pj4+PiAgICAgICAqCj4+Pj4+Pj4+IC0gICAgICogSW4gcmVhbGl0eSBhbG1vc3Qg
ZXZlcnkgZHJpdmVyIGdldHMgdGhpcyB3cm9uZy4KPj4+Pj4+Pj4gKyAgICAgKiBZb3Ugd2lsbCBn
ZXQgYSBXQVJOIGlmIHlvdSBnZXQgdGhpcyB3cm9uZyBpbiB0aGUgZHJpdmVyLgo+Pj4+Pj4+PiAg
ICAgICAqCj4+Pj4+Pj4+ICAgICAgICogTm90ZSB0aGF0IHNpbmNlIENSVEMgb2JqZWN0cyBjYW4n
dCBiZSBob3RwbHVnZ2VkIHRoZSBhc3NpZ25lZAo+Pj4+PiBpbmRpY2VzCj4+Pj4+Pj4+ICAgICAg
ICogYXJlIHN0YWJsZSBhbmQgaGVuY2Uga25vd24gYmVmb3JlIHJlZ2lzdGVyaW5nIGFsbCBvYmpl
Y3RzLgo+Pj4+Pj4+PiAtLQo+Pj4+Pj4+PiAyLjI0LjEKPj4+Pj4+Pj4KPj4+Pj4+Pgo+Pj4+Pj4K
Pj4+Pj4+IFRyaWdnZXJzIG9uIGFuIEFkdmFudGVjaCBBSU1CLTIyOCAoUjE1MDVHLCAzIERQIG91
dHB1dHMpOgo+Pj4+Pgo+Pj4+PiBBZGRpbmcgYW1kZ3B1IGRpc3BsYXkgZm9sa3MuCj4+Pj4KPj4+
PiBJIHRvb2sgYSBxdWljayBsb29rIGF0IHRoaXMgYW5kIGl0IGxvb2tzIGxpa2Ugd2UgbGltaXQg
dGhlIG51bWJlciBvZiBjcnRjcyBsYXRlciBpbiB0aGUgbW9kZSBpbml0IHByb2Nlc3MgaWYgdGhl
IG51bWJlciBvZiBwaHlzaWNhbCBkaXNwbGF5cyBjYW4ndCBhY3R1YWxseSB1c2UgbW9yZSBjcnRj
cy4gIEUuZy4sIHRoZSBwaHlzaWNhbCBib2FyZCBjb25maWd1cmF0aW9uIHdvdWxkIG9ubHkgYWxs
b3cgZm9yIDMgYWN0aXZlIGRpc3BsYXlzIGV2ZW4gaWYgdGhlIGhhcmR3YXJlIHRlY2huaWNhbGx5
IHN1cHBvcnRzIDQgY3J0Y3MuICBJIHByZXN1bWUgdGhhdCB3YXkgd2UgY2FuIGp1c3QgbGVhdmUg
dGhlIGFkZGl0aW9uYWwgaGFyZHdhcmUgcG93ZXIgZ2F0ZWQgYWxsIHRoZSB0aW1lLgo+Pj4+Cj4+
Pgo+Pj4gU28sIHdpbGwgdGhpcyBiZSBmaXhlZCBhbnkgdGltZSBzb29uPyBJIGRvbid0IGZlZWwg
cXVhbGlmaWVkIHdyaXRpbmcKPj4+IHN1Y2ggYSBwYXRjaCBidXQgSSB3b3VsZCBvYnZpb3VzbHkg
YmUgaGFwcHkgdG8gdGVzdCBvbmUuCj4+Cj4+IEl0J3MgaGFybWxlc3MsIGJ1dCBJJ2xsIHNlbmQg
b3V0IGEgcGF0Y2ggc29vbi4KPgo+IEkgYmVsaWV2ZSB0aGUgYXR0YWNoZWQgcGF0Y2ggc2hvdWxk
IGZpeCB0aGlzLgo+CgpZZXAsIGp1c3QgYm9vdGVkIDUuMTAsIGFuZCB0aGUgd2FybmluZyBpcyBn
b25lLgoKVGhhbmtzLApKYW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
