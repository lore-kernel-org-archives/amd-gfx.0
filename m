Return-Path: <SRS0=ij9B=3O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DAAC2D0DB
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Jan 2020 15:50:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFA3920704
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Jan 2020 15:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA3920704
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sk2.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F1056E88E;
	Sat, 25 Jan 2020 15:50:04 +0000 (UTC)
X-Greylist: delayed 2274 seconds by postgrey-1.36 at gabe;
 Sat, 25 Jan 2020 12:30:36 UTC
Received: from 9.mo178.mail-out.ovh.net (9.mo178.mail-out.ovh.net
 [46.105.75.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 388EC6E81E
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Jan 2020 12:30:36 +0000 (UTC)
Received: from player734.ha.ovh.net (unknown [10.108.57.150])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id F3B268CF29
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Jan 2020 12:52:39 +0100 (CET)
Received: from RCM-web9.webmail.mail.ovh.net (unknown [147.229.117.36])
 (Authenticated sender: steve@sk2.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id 98DE3E7D3290;
 Sat, 25 Jan 2020 11:52:28 +0000 (UTC)
MIME-Version: 1.0
Date: Sat, 25 Jan 2020 12:52:23 +0100
From: Stephen Kitt <steve@sk2.org>
To: Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie
 <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Sumit Semwal
 <sumit.semwal@linaro.org>
Subject: Re: [PATCH] amdgpu: use dma-resv API instead of manual kmalloc
In-Reply-To: <20200125114624.2093235-1-steve@sk2.org>
References: <20200125114624.2093235-1-steve@sk2.org>
User-Agent: Roundcube Webmail/1.4.2
Message-ID: <a413396eed8390fc95fedabae9ae5afb@sk2.org>
X-Sender: steve@sk2.org
X-Originating-IP: 147.229.117.36
X-Webmail-UserID: steve@sk2.org
X-Ovh-Tracer-Id: 3172504463427325436
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrvdejgdefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggtgfgfffhvffujghffgfkgihisehtkehjtddtreejnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucfkpheptddrtddrtddrtddpudegjedrvddvledruddujedrfeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheprghmugdqghhfgieslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrgh
X-Mailman-Approved-At: Sat, 25 Jan 2020 15:50:02 +0000
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
Cc: linux-media@vger.kernel.org, steve@sk2.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW5kIG9mIGNvdXJzZSBJIGZvcmdvdCB0aGlzIGlzIGFuIGludGVybmFsIEFQSSwgc28gdGhpcyBk
b2Vzbid0IHdvcmsgCndpdGhvdXQgc29tZSBvZiBvdGhlciBzdHVmZiB3aGljaCBpc24ndCByZWFk
eS4KClBsZWFzZSBpZ25vcmUuLi4KClJlZ2FyZHMsCgpTdGVwaGVuCgoKTGUgMjUvMDEvMjAyMCAx
Mjo0NiwgU3RlcGhlbiBLaXR0IGEgw6ljcml0wqA6Cj4gSW5zdGVhZCBvZiBoYW5kLWNvZGluZyB0
aGUgZG1hX3Jlc3ZfbGlzdCBhbGxvY2F0aW9uLCB1c2UKPiBkbWFfcmVzdl9saXN0X2FsbG9jLCB3
aGljaCBtYXNrcyB0aGUgc2hhcmVkX21heCBoYW5kbGluZy4gV2hpbGUgd2UncmUKPiBhdCBpdCwg
c2luY2Ugd2Ugb25seSBuZWVkIHNoYXJlZF9jb3VudCBmZW5jZXMsIGFsbG9jYXRlIHNoYXJlZF9j
b3VudAo+IGZlbmNlcyByYXRoZXIgdGhhbiBzaGFyZWRfbWF4Lgo+IAo+IChUaGlzIGlzIHRoZSBv
bmx5IHBsYWNlIGluIHRoZSBrZXJuZWwsIG91dHNpZGUgb2YgZG1hLXJlc3YuYywgd2hpY2gKPiB0
b3VjaGVzIHNoYXJlZF9tYXguIFRoaXMgc3VnZ2VzdHMgd2UnZCBwcm9iYWJseSBiZSBiZXR0ZXIg
b2ZmIHdpdGhvdXQKPiBpdCEpCj4gCj4gU2lnbmVkLW9mZi1ieTogU3RlcGhlbiBLaXR0IDxzdGV2
ZUBzazIub3JnPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1k
a2ZkX2dwdXZtLmMgfCA2ICsrLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMKPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwo+IGluZGV4IDg4ODIwOWViOGNlYy4uYWVjNTk1NzUyMjAw
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRf
Z3B1dm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRf
Z3B1dm0uYwo+IEBAIC0yMzQsMTIgKzIzNCwxMSBAQCBzdGF0aWMgaW50Cj4gYW1kZ3B1X2FtZGtm
ZF9yZW1vdmVfZXZpY3Rpb25fZmVuY2Uoc3RydWN0IGFtZGdwdV9ibyAqYm8sCj4gIAlpZiAoIW9s
ZCkKPiAgCQlyZXR1cm4gMDsKPiAKPiAtCW5ldyA9IGttYWxsb2Mob2Zmc2V0b2YodHlwZW9mKCpu
ZXcpLCBzaGFyZWRbb2xkLT5zaGFyZWRfbWF4XSksCj4gLQkJICAgICAgR0ZQX0tFUk5FTCk7Cj4g
KwluZXcgPSBkbWFfcmVzdl9saXN0X2FsbG9jKG9sZC0+c2hhcmVkX2NvdW50KTsKPiAgCWlmICgh
bmV3KQo+ICAJCXJldHVybiAtRU5PTUVNOwo+IAo+IC0JLyogR28gdGhyb3VnaCBhbGwgdGhlIHNo
YXJlZCBmZW5jZXMgaW4gdGhlIHJlc2V2YXRpb24gb2JqZWN0IGFuZCBzb3J0Cj4gKwkvKiBHbyB0
aHJvdWdoIGFsbCB0aGUgc2hhcmVkIGZlbmNlcyBpbiB0aGUgcmVzZXJ2YXRpb24gb2JqZWN0IGFu
ZCAKPiBzb3J0Cj4gIAkgKiB0aGUgaW50ZXJlc3Rpbmcgb25lcyB0byB0aGUgZW5kIG9mIHRoZSBs
aXN0Lgo+ICAJICovCj4gIAlmb3IgKGkgPSAwLCBqID0gb2xkLT5zaGFyZWRfY291bnQsIGsgPSAw
OyBpIDwgb2xkLT5zaGFyZWRfY291bnQ7ICsraSkgCj4gewo+IEBAIC0yNTMsNyArMjUyLDYgQEAg
c3RhdGljIGludAo+IGFtZGdwdV9hbWRrZmRfcmVtb3ZlX2V2aWN0aW9uX2ZlbmNlKHN0cnVjdCBh
bWRncHVfYm8gKmJvLAo+ICAJCWVsc2UKPiAgCQkJUkNVX0lOSVRfUE9JTlRFUihuZXctPnNoYXJl
ZFtrKytdLCBmKTsKPiAgCX0KPiAtCW5ldy0+c2hhcmVkX21heCA9IG9sZC0+c2hhcmVkX21heDsK
PiAgCW5ldy0+c2hhcmVkX2NvdW50ID0gazsKPiAKPiAgCS8qIEluc3RhbGwgdGhlIG5ldyBmZW5j
ZSBsaXN0LCBzZXFjb3VudCBwcm92aWRlcyB0aGUgYmFycmllcnMgKi8KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
