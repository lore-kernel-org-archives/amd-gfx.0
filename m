From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v19 02/15] arm64: Introduce prctl() options to control the
 tagged user addresses ABI
Date: Thu, 1 Aug 2019 09:45:05 -0700
Message-ID: <88c59d1e-eda9-fcfe-5ee3-64a331f34313@intel.com>
References: <cover.1563904656.git.andreyknvl@google.com>
 <1c05651c53f90d07e98ee4973c2786ccf315db12.1563904656.git.andreyknvl@google.com>
 <7a34470c-73f0-26ac-e63d-161191d4b1e4@intel.com>
 <2b274c6f-6023-8eb8-5a86-507e6000e13d@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <2b274c6f-6023-8eb8-5a86-507e6000e13d@arm.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, linux-media@vger.kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kostya Serebryany <kcc@google.com>, Khalid Aziz <khalid.aziz@oracle.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Dave Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugenis@google.com>, Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Alex Williamson <alex.williamson@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yishai Hadas <yishaih@mellanox.com>, Je
List-Id: amd-gfx.lists.freedesktop.org

T24gOC8xLzE5IDU6MzggQU0sIEtldmluIEJyb2Rza3kgd3JvdGU6Cj4gVGhpcyBwYXRjaCBzZXJp
ZXMgb25seSBjaGFuZ2VzIHdoYXQgaXMgYWxsb3dlZCBvciBub3QgYXQgdGhlIHN5c2NhbGwKPiBp
bnRlcmZhY2UuIEl0IGRvZXMgbm90IGNoYW5nZSB0aGUgYWRkcmVzcyBzcGFjZSBzaXplLiBPbiBh
cm02NCwgVEJJIChUb3AKPiBCeXRlIElnbm9yZSkgaGFzIGFsd2F5cyBiZWVuIGVuYWJsZWQgZm9y
IHVzZXJzcGFjZSwgc28gaXQgaGFzIG5ldmVyIGJlZW4KPiBwb3NzaWJsZSB0byB1c2UgdGhlIHVw
cGVyIDggYml0cyBvZiB1c2VyIHBvaW50ZXJzIGZvciBhZGRyZXNzaW5nLgoKT2gsIHNvIGRvZXMg
dGhlIGFkZHJlc3Mgc3BhY2UgdGhhdCdzIGF2YWlsYWJsZSBhbHJlYWR5IGNob3AgdGhhdCBvdXQ/
Cgo+IElmIG90aGVyIGFyY2hpdGVjdHVyZXMgd2VyZSB0byBzdXBwb3J0IGEgc2ltaWxhciBmdW5j
dGlvbmFsaXR5LCB0aGVuIEkKPiBhZ3JlZSB0aGF0IGEgY29tbW9uIGFuZCBtb3JlIGdlbmVyaWMg
aW50ZXJmYWNlIChpZiBuZWVkZWQpIHdvdWxkIGJlCj4gaGVscGZ1bCwgYnV0IGFzIGl0IHN0YW5k
cyB0aGlzIGlzIGFuIGFybTY0LXNwZWNpZmljIHByY3RsLCBhbmQgb24gYXJtNjQKPiB0aGUgYWRk
cmVzcyB0YWcgaXMgZGVmaW5lZCBieSB0aGUgYXJjaGl0ZWN0dXJlIGFzIGJpdHMgWzYzOjU2XS4K
Ckl0IHNob3VsZCB0aGVuIGJlIGFuIGFyY2hfcHJjdGwoKSwgbm8/Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
