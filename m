From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH ARM] selftests, arm64: fix uninitialized symbol in
 tags_test.c
Date: Mon, 19 Aug 2019 16:38:57 +0100
Message-ID: <20190819153856.odtneqxfxva2wjgu@willie-the-truck>
References: <00eb8ba84205c59cac01b1b47615116a461c302c.1566220355.git.andreyknvl@google.com>
 <20190819150342.sxk3zzxvrxhkpp6j@willie-the-truck>
 <CAAeHK+xP6HnLJt_RKW67x8nbJLJp5A=av57BfwiFrA88eFn60w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CAAeHK+xP6HnLJt_RKW67x8nbJLJp5A=av57BfwiFrA88eFn60w@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org, Christian Koenig <Christian.Koenig@amd.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org, Kostya Serebryany <kcc@google.com>, Khalid Aziz <khalid.aziz@oracle.com>, Lee Smith <Lee.Smith@arm.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Dmitry Vyukov <dvyukov@google.com>, Dave Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugenis@google.com>, linux-media@vger.kernel.org, Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayr>
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCBBdWcgMTksIDIwMTkgYXQgMDU6MTY6MzdQTSArMDIwMCwgQW5kcmV5IEtvbm92YWxv
diB3cm90ZToKPiBPbiBNb24sIEF1ZyAxOSwgMjAxOSBhdCA1OjAzIFBNIFdpbGwgRGVhY29uIDx3
aWxsQGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4KPiA+IE9uIE1vbiwgQXVnIDE5LCAyMDE5IGF0IDAz
OjE0OjQyUE0gKzAyMDAsIEFuZHJleSBLb25vdmFsb3Ygd3JvdGU6Cj4gPiA+IEZpeCB0YWdnZWRf
cHRyIG5vdCBiZWluZyBpbml0aWFsaXplZCB3aGVuIFRCSSBpcyBub3QgZW5hYmxlZC4KPiA+ID4K
PiA+ID4gRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPgo+ID4KPiA+IEd1
ZXNzaW5nIHRoaXMgd2FzIFJlcG9ydGVkLWJ5LCBvciBoYXMgRGFuIGludHJvZHVjZWQgaGlzIG93
biB0YWcgbm93PyA7KQo+IAo+IE9vcHMsIHllcywgUmVwb3J0ZWQtYnkgOikKPiAKPiA+Cj4gPiBH
b3QgYSBsaW5rIHRvIHRoZSByZXBvcnQ/Cj4gCj4gaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlz
dHMvbGludXgta3NlbGZ0ZXN0L21zZzA5NDQ2Lmh0bWwKClRoYW5rcywgSSdsbCBmaXggdXAgdGhl
IGNvbW1pdCBtZXNzYWdlIGFuZCBwdXNoIHRoaXMgb3V0IGxhdGVyIG9uLiBJZiB5b3UKZ2V0IGEg
Y2hhbmNlLCB3b3VsZCB5b3UgYmUgYWJsZSB0byBsb29rIGF0IHRoZSBwZW5kaW5nIGNoYW5nZXMg
ZnJvbQpDYXRhbGluWzFdLCBwbGVhc2U/CgpXaWxsCgpbMV0gaHR0cHM6Ly9sa21sLmtlcm5lbC5v
cmcvci8yMDE5MDgxNTE1NDQwMy4xNjQ3My0xLWNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWls
aW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
