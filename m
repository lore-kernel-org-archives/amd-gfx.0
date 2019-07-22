From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v18 07/15] fs/namespace: untag user pointers in
 copy_mount_options
Date: Mon, 22 Jul 2019 09:46:06 -0700
Message-ID: <201907220944.5821C92518@keescook>
References: <cover.1561386715.git.andreyknvl@google.com>
 <41e0a911e4e4d533486a1468114e6878e21f9f84.1561386715.git.andreyknvl@google.com>
 <20190624175009.GM29120@arrakis.emea.arm.com>
 <CAAeHK+x2TL057Fr0K7FZBTYgeEPVU3cC6scEeiSYk-Jkb3xgfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CAAeHK+x2TL057Fr0K7FZBTYgeEPVU3cC6scEeiSYk-Jkb3xgfg@mail.gmail.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org, Linux Memory Management List <linux-mm@kvack.org>, Khalid Aziz <khalid.aziz@oracle.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Dmitry Vyukov <dvyukov@google.com>, Dave Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugenis@google.com>, linux-media@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Ramana Radhakrishnan <Ramana.Radhakri>
List-Id: amd-gfx.lists.freedesktop.org

K0VyaWMgQmllZGVybWFuIHRvbywgd2hvIG1pZ2h0IGJlIGFibGUgdG8gQWNrIHRoaXMuLi4KCk9u
IE1vbiwgSnVsIDE1LCAyMDE5IGF0IDA2OjAwOjA0UE0gKzAyMDAsIEFuZHJleSBLb25vdmFsb3Yg
d3JvdGU6Cj4gT24gTW9uLCBKdW4gMjQsIDIwMTkgYXQgNzo1MCBQTSBDYXRhbGluIE1hcmluYXMg
PGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBNb24sIEp1biAyNCwg
MjAxOSBhdCAwNDozMjo1MlBNICswMjAwLCBBbmRyZXkgS29ub3ZhbG92IHdyb3RlOgo+ID4gPiBU
aGlzIHBhdGNoIGlzIGEgcGFydCBvZiBhIHNlcmllcyB0aGF0IGV4dGVuZHMga2VybmVsIEFCSSB0
byBhbGxvdyB0byBwYXNzCj4gPiA+IHRhZ2dlZCB1c2VyIHBvaW50ZXJzICh3aXRoIHRoZSB0b3Ag
Ynl0ZSBzZXQgdG8gc29tZXRoaW5nIGVsc2Ugb3RoZXIgdGhhbgo+ID4gPiAweDAwKSBhcyBzeXNj
YWxsIGFyZ3VtZW50cy4KPiA+ID4KPiA+ID4gSW4gY29weV9tb3VudF9vcHRpb25zIGEgdXNlciBh
ZGRyZXNzIGlzIGJlaW5nIHN1YnRyYWN0ZWQgZnJvbSBUQVNLX1NJWkUuCj4gPiA+IElmIHRoZSBh
ZGRyZXNzIGlzIGxvd2VyIHRoYW4gVEFTS19TSVpFLCB0aGUgc2l6ZSBpcyBjYWxjdWxhdGVkIHRv
IG5vdAo+ID4gPiBhbGxvdyB0aGUgZXhhY3RfY29weV9mcm9tX3VzZXIoKSBjYWxsIHRvIGNyb3Nz
IFRBU0tfU0laRSBib3VuZGFyeS4KPiA+ID4gSG93ZXZlciBpZiB0aGUgYWRkcmVzcyBpcyB0YWdn
ZWQsIHRoZW4gdGhlIHNpemUgd2lsbCBiZSBjYWxjdWxhdGVkCj4gPiA+IGluY29ycmVjdGx5Lgo+
ID4gPgo+ID4gPiBVbnRhZyB0aGUgYWRkcmVzcyBiZWZvcmUgc3VidHJhY3RpbmcuCj4gPiA+Cj4g
PiA+IFJldmlld2VkLWJ5OiBLaGFsaWQgQXppeiA8a2hhbGlkLmF6aXpAb3JhY2xlLmNvbT4KPiA+
ID4gUmV2aWV3ZWQtYnk6IFZpbmNlbnpvIEZyYXNjaW5vIDx2aW5jZW56by5mcmFzY2lub0Bhcm0u
Y29tPgo+ID4gPiBSZXZpZXdlZC1ieTogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+
Cj4gPiA+IFJldmlld2VkLWJ5OiBDYXRhbGluIE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0u
Y29tPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgS29ub3ZhbG92IDxhbmRyZXlrbnZsQGdv
b2dsZS5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgZnMvbmFtZXNwYWNlLmMgfCAyICstCj4gPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiA+ID4KPiA+ID4g
ZGlmZiAtLWdpdCBhL2ZzL25hbWVzcGFjZS5jIGIvZnMvbmFtZXNwYWNlLmMKPiA+ID4gaW5kZXgg
NzY2MGMyNzQ5Yzk2Li5lYzc4ZjcyMjM5MTcgMTAwNjQ0Cj4gPiA+IC0tLSBhL2ZzL25hbWVzcGFj
ZS5jCj4gPiA+ICsrKyBiL2ZzL25hbWVzcGFjZS5jCj4gPiA+IEBAIC0yOTk0LDcgKzI5OTQsNyBA
QCB2b2lkICpjb3B5X21vdW50X29wdGlvbnMoY29uc3Qgdm9pZCBfX3VzZXIgKiBkYXRhKQo+ID4g
PiAgICAgICAgKiB0aGUgcmVtYWluZGVyIG9mIHRoZSBwYWdlLgo+ID4gPiAgICAgICAgKi8KPiA+
ID4gICAgICAgLyogY29weV9mcm9tX3VzZXIgY2Fubm90IGNyb3NzIFRBU0tfU0laRSAhICovCj4g
PiA+IC0gICAgIHNpemUgPSBUQVNLX1NJWkUgLSAodW5zaWduZWQgbG9uZylkYXRhOwo+ID4gPiAr
ICAgICBzaXplID0gVEFTS19TSVpFIC0gKHVuc2lnbmVkIGxvbmcpdW50YWdnZWRfYWRkcihkYXRh
KTsKPiA+ID4gICAgICAgaWYgKHNpemUgPiBQQUdFX1NJWkUpCj4gPiA+ICAgICAgICAgICAgICAg
c2l6ZSA9IFBBR0VfU0laRTsKPiA+Cj4gPiBJIHRoaW5rIHRoaXMgcGF0Y2ggbmVlZHMgYW4gYWNr
IGZyb20gQWwgVmlybyAoY2MnZWQpLgo+ID4KPiA+IC0tCj4gPiBDYXRhbGluCj4gCj4gSGkgQWws
Cj4gCj4gQ291bGQgeW91IHRha2UgYSBsb29rIGFuZCBnaXZlIHlvdXIgYWNrZWQtYnk/Cj4gCj4g
VGhhbmtzIQoKLS0gCktlZXMgQ29vawpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9kcmktZGV2ZWw=
