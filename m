From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: mm: fix cache mode tracking in vm_insert_mixed() breaks AMDGPU
 [was: Re: Latest testing with drm-next-4.9-wip and latest LLVM/mesa stack -
 Regression in PowerPlay/DPM on CIK?]
Date: Tue, 18 Oct 2016 06:53:30 -0700
Message-ID: <CAPcyv4h6Bz8vOUuBPy=tRJLv3-QPMY800QpACbKp7GPDcF_AoQ@mail.gmail.com>
References: <11271056.dD6Mas21fI@segfault> <5955047.4M9YlcR7bW@segfault>
 <8025413.75ZrRe18t5@segfault> <3888118.bNeqOmVUhz@segfault>
 <10a1e298-df32-52a5-7694-b205794ca009@daenzer.net>
 <CAAxE2A6T9wX9tbsYhLA+zPGSQBXfCTAntKw5uTgfWu__7btHiA@mail.gmail.com>
 <CAPM=9twLoEY-huyv6kaupqu6XodgqGsEmgHqx4vasJ1aj_1HdA@mail.gmail.com>
 <CAPcyv4hbgnmETbne6qXizaBkUTJm291xRa4BuouFb_6uJAZj3w@mail.gmail.com>
 <CAPM=9tx5ayYzTk8hm-c8JaWReNEQ3yem-r4ac5r8bFuQXzOwiA@mail.gmail.com>
 <CAPM=9tyrP7yB8GYtFg2=S60DOngMULj5HB7eg7+ts1jK+S97oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAPM=9tyrP7yB8GYtFg2=S60DOngMULj5HB7eg7+ts1jK+S97oA@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Dave Airlie <airlied@gmail.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, Shawn Starr <shawn.starr@rogers.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCBPY3QgMTcsIDIwMTYgYXQgODo0OCBQTSwgRGF2ZSBBaXJsaWUgPGFpcmxpZWRAZ21h
aWwuY29tPiB3cm90ZToKWy4uXQo+Pj4gQXJlbid0IHRoZXJlIG9ubHkgMiBwb3NzaWJpbGl0aWVz
IGZvciB0aGlzIHJlZ3Jlc3Npb24/Cj4+Pgo+Pj4gMS8gYSBtZW10eXBlIGVudHJ5IHdhcyBuZXZl
ciBtYWRlIHNvIHRyYWNrX3Bmbl9pbnNlcnQoKSByZXR1cm5zIGFuCj4+PiB1bmNhY2hlZCBtYXBw
aW5nCj4+Pgo+Pj4gMi8gYSBjb25mbGljdGluZyBtZW10eXBlIGVudHJ5IGV4aXN0cyBhbmQgdW5k
ZWZpbmVkIGJlaGF2aW9yIGR1ZSB0bwo+Pj4gbWl4ZWQgbWFwcGluZyB0eXBlcyBpcyBhdm9pZGVk
IHdpdGggdGhlIGNoYW5nZS4KPj4KPj4gMy8gVGhlIENQVSB1c2FnZSB0aHJvdWdoIHRoaXMgcGF0
aCBnb2VzIHVwLCBhbmQgc2xvd3MgdGhpbmdzIGRvd24sCj4+IHRob3VnaCBJIHN1c3BlY3QgeW91
IGl0J3MgbW9yZSBhbiB1bmNhY2hlZCBtYXBwaW5nIHNob3dpbmcgdXAKPj4gd2hlbiB3ZSBkb24n
dCBleHBlY3QgaXQuCj4KPiBJdCdzIGxvb2tpbmcgbGluZSBudW1iZXIgMSwgdGhlcmUgaXMgbm8g
bWFwcGluZywgbm93IHdlIGdldCB1bmNhY2hlZAo+IHdoZXJlIHdlIHVzZWQgdG8gZ2V0IHdyaXRl
IHRocm91Z2guCj4KPiBkaWZmZXJlbmNlIGluIHBhZ2UgcHJvdCA3ZjdiYmMwZTAwMDAsIHBmbiAy
MDAwMDAwMDAwMGU3MWU0LAo+IDgwMDAwMDAwMDAwMDAwMzcsIDgwMDAwMDAwMDAwMDAwMmYKPgo+
IDB4MmYgaXMgdGhlIHZtYSBwZyBwcm90IHdoaWNoIGhhcyBQV1Qgc2V0IGluIGl0LCAweDM3IGlz
IHRoZSByZXR1cm5lZAo+IHBncHJvdCB3aGljaCBsYWNrcyB0aGF0IGJpdC4KPgo+IG5vdCBzdXJl
IHdoZXJlIHRvIGdvIGZyb20gaGVyZSwgc3VnZ2VzdGlvbnM/CgpJZiB0aGUgZHJpdmVyIGVzdGFi
bGlzaGVkIGFuIGlvcmVtYXBfd3QoKSBhY3Jvc3MgdGhlIHJhbmdlLCBvciBqdXN0CmNhbGxlZCBy
ZXNlcnZlX21lbXR5cGUoKSBkaXJlY3RseSB0aGF0IHNob3VsZCByZXN0b3JlIFdUIG1hcHBpbmdz
LgoKQWx0aG91Z2ggRGFuaWVsJ3Mgc3VnZ2VzdGlvbiB0byB1c2UgdGhlIGk5MTUgbWFwcGluZyBo
ZWxwZXJzIHNvdW5kcwpsaWtlIGl0IGF2b2lkcyBwcm9ibGVtIDMvIGFzIHdlbGwuCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5n
IGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
