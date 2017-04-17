From: Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH 1/7] sync_file: get rid of internal reference count.
Date: Mon, 17 Apr 2017 20:44:12 +0530
Message-ID: <CAO_48GHYX7oDv3MtD5XhoQOSyYZOF_byP+niV0YC7f1ZhHvL1A@mail.gmail.com>
References: <20170413014144.637-1-airlied@gmail.com>
 <20170413014144.637-2-airlied@gmail.com>
 <20170417131311.GA15339@joana>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170417131311.GA15339@joana>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Gustavo Padovan <gustavo@padovan.org>, Dave Airlie <airlied@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, DRI mailing list <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gMTcgQXByaWwgMjAxNyBhdCAxODo0MywgR3VzdGF2byBQYWRvdmFuIDxndXN0YXZvQHBhZG92
YW4ub3JnPiB3cm90ZToKPiAyMDE3LTA0LTEzIERhdmUgQWlybGllIDxhaXJsaWVkQGdtYWlsLmNv
bT46Cj4KPj4gRnJvbTogRGF2ZSBBaXJsaWUgPGFpcmxpZWRAcmVkaGF0LmNvbT4KPj4KPj4gc3lu
Y19maWxlIHVzZXMgdGhlIHJlZmVyZW5jZSBjb3VudCBvZiB0aGUgZmlsZSwgdGhlIGludGVybmFs
Cj4+IGtyZWYgd2FzIG5ldmVyIGdldHRpbmcgbW92ZWQgcGFzdCAxLgo+Pgo+PiBXZSBjYW4gcmVp
bnRyb2R1Y2UgdGhpcyBpZiB3ZSBkZWNpZGUgd2UgbmVlZCBpdCBsYXRlci4KPj4KPj4gW2Fpcmxp
ZWQ6IGZpeCBidWlsZGJvdCB3YXJuaW5nc10KPj4KPj4gUmV2aWV3ZWQtYnk6IENocmlzIFdpbHNv
biA8Y2hyaXNAY2hyaXMtd2lsc29uLmNvLnVrPgo+PiBTaWduZWQtb2ZmLWJ5OiBEYXZlIEFpcmxp
ZSA8YWlybGllZEByZWRoYXQuY29tPgo+PiAtLS0KPj4gIGRyaXZlcnMvZG1hLWJ1Zi9zeW5jX2Zp
bGUuYyB8IDEzICsrLS0tLS0tLS0tLS0KPj4gIGluY2x1ZGUvbGludXgvc3luY19maWxlLmggICB8
ICAzIC0tLQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9u
cygtKQo+Cj4gUmV2aWV3ZWQtYnk6IEd1c3Rhdm8gUGFkb3ZhbiA8Z3VzdGF2by5wYWRvdmFuQGNv
bGxhYm9yYS5jb20+CkFja2VkLWJ5OiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8u
b3JnPgo+Cj4gT3Igc2hvdWxkIEkganVzdCBwdXNoIHRoaXMgb25lPwpPZiBjb3Vyc2UsIGdvIHJp
Z2h0IGFoZWFkLCBHdXN0YXZvIDopCj4KPiBHdXN0YXZvCj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KPiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4gZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2RyaS1kZXZlbAo=
