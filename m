From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH libdrm 4/5] [libdrm]: wrap syncobj timeline query and wait
 for amdgpu
Date: Wed, 12 Sep 2018 11:57:09 +0200
Message-ID: <0c61b66f-196c-316b-f2a6-9f2e7f8ce732@daenzer.net>
References: <20180912095048.928-1-david1.zhou@amd.com>
 <20180912095048.928-4-david1.zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180912095048.928-4-david1.zhou@amd.com>
Content-Language: en-CA
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Chunming Zhou <david1.zhou@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOC0wOS0xMiAxMTo1MCBhLm0uLCBDaHVubWluZyBaaG91IHdyb3RlOgo+IFNpZ25lZC1v
ZmYtYnk6IENodW5taW5nIFpob3UgPGRhdmlkMS56aG91QGFtZC5jb20+Cj4gLS0tCj4gIGFtZGdw
dS9hbWRncHUtc3ltYm9sLWNoZWNrIHwgIDIgKysKPiAgYW1kZ3B1L2FtZGdwdS5oICAgICAgICAg
ICAgfCAzOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICBhbWRncHUv
YW1kZ3B1X2NzLmMgICAgICAgICB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrCj4gIDMgZmls
ZXMgY2hhbmdlZCwgNjUgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9hbWRncHUvYW1k
Z3B1LXN5bWJvbC1jaGVjayBiL2FtZGdwdS9hbWRncHUtc3ltYm9sLWNoZWNrCj4gaW5kZXggNTg2
NDZlODUuLjRmOTFiZTU0IDEwMDc1NQo+IC0tLSBhL2FtZGdwdS9hbWRncHUtc3ltYm9sLWNoZWNr
Cj4gKysrIGIvYW1kZ3B1L2FtZGdwdS1zeW1ib2wtY2hlY2sKPiBAQCAtNTAsNiArNTAsOCBAQCBh
bWRncHVfY3Nfc3luY29ial9pbXBvcnRfc3luY19maWxlCj4gIGFtZGdwdV9jc19zeW5jb2JqX3Jl
c2V0Cj4gIGFtZGdwdV9jc19zeW5jb2JqX3NpZ25hbAo+ICBhbWRncHVfY3Nfc3luY29ial93YWl0
Cj4gK2FtZGdwdV9jc19zeW5jb2JqX3RpbWVsaW5lX3dhaXQKPiArYW1kZ3B1X2NzX3N5bmNvYmpf
cXVlcnkKPiAgYW1kZ3B1X2NzX3dhaXRfZmVuY2VzCj4gIGFtZGdwdV9jc193YWl0X3NlbWFwaG9y
ZQo+ICBhbWRncHVfZGV2aWNlX2RlaW5pdGlhbGl6ZQoKVGhpcyBmaWxlIHNob3VsZCBiZSBzb3J0
ZWQgaW4gbGV4aWNhbCBvcmRlci4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAg
ICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2Fy
ZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9w
ZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRl
dmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
