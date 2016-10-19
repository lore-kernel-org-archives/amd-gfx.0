From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Subject: Re: mm: fix cache mode tracking in vm_insert_mixed() breaks AMDGPU
 [was: Re: Latest testing with drm-next-4.9-wip and latest LLVM/mesa stack -
 Regression in PowerPlay/DPM on CIK?]
Date: Wed, 19 Oct 2016 12:33:52 +0200
Message-ID: <CAAxE2A7803depmY6ibmGWD5GBEiDj3yYWFdwgPDfpds1oVBssQ@mail.gmail.com>
References: <11271056.dD6Mas21fI@segfault> <5955047.4M9YlcR7bW@segfault>
 <8025413.75ZrRe18t5@segfault> <3888118.bNeqOmVUhz@segfault>
 <10a1e298-df32-52a5-7694-b205794ca009@daenzer.net>
 <CAAxE2A6T9wX9tbsYhLA+zPGSQBXfCTAntKw5uTgfWu__7btHiA@mail.gmail.com>
 <CAPM=9twLoEY-huyv6kaupqu6XodgqGsEmgHqx4vasJ1aj_1HdA@mail.gmail.com>
 <CAPcyv4hbgnmETbne6qXizaBkUTJm291xRa4BuouFb_6uJAZj3w@mail.gmail.com>
 <CAPM=9tx5ayYzTk8hm-c8JaWReNEQ3yem-r4ac5r8bFuQXzOwiA@mail.gmail.com>
 <CAPM=9tyrP7yB8GYtFg2=S60DOngMULj5HB7eg7+ts1jK+S97oA@mail.gmail.com>
 <CAPcyv4h6Bz8vOUuBPy=tRJLv3-QPMY800QpACbKp7GPDcF_AoQ@mail.gmail.com>
 <CAPM=9txdaRwEMk6ZZaCYWRbo5Q4iGO=hydg0oU_FxEdctf2ang@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAPM=9txdaRwEMk6ZZaCYWRbo5Q4iGO=hydg0oU_FxEdctf2ang@mail.gmail.com>
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
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Dan Williams <dan.j.williams@intel.com>, Shawn Starr <shawn.starr@rogers.com>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gV2VkLCBPY3QgMTksIDIwMTYgYXQgODo0MiBBTSwgRGF2ZSBBaXJsaWUgPGFpcmxpZWRAZ21h
aWwuY29tPiB3cm90ZToKPiBPbiAxOCBPY3RvYmVyIDIwMTYgYXQgMjM6NTMsIERhbiBXaWxsaWFt
cyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPiB3cm90ZToKPj4gT24gTW9uLCBPY3QgMTcsIDIw
MTYgYXQgODo0OCBQTSwgRGF2ZSBBaXJsaWUgPGFpcmxpZWRAZ21haWwuY29tPiB3cm90ZToKPj4g
Wy4uXQo+Pj4+PiBBcmVuJ3QgdGhlcmUgb25seSAyIHBvc3NpYmlsaXRpZXMgZm9yIHRoaXMgcmVn
cmVzc2lvbj8KPj4+Pj4KPj4+Pj4gMS8gYSBtZW10eXBlIGVudHJ5IHdhcyBuZXZlciBtYWRlIHNv
IHRyYWNrX3Bmbl9pbnNlcnQoKSByZXR1cm5zIGFuCj4+Pj4+IHVuY2FjaGVkIG1hcHBpbmcKPj4+
Pj4KPj4+Pj4gMi8gYSBjb25mbGljdGluZyBtZW10eXBlIGVudHJ5IGV4aXN0cyBhbmQgdW5kZWZp
bmVkIGJlaGF2aW9yIGR1ZSB0bwo+Pj4+PiBtaXhlZCBtYXBwaW5nIHR5cGVzIGlzIGF2b2lkZWQg
d2l0aCB0aGUgY2hhbmdlLgo+Pj4+Cj4+Pj4gMy8gVGhlIENQVSB1c2FnZSB0aHJvdWdoIHRoaXMg
cGF0aCBnb2VzIHVwLCBhbmQgc2xvd3MgdGhpbmdzIGRvd24sCj4+Pj4gdGhvdWdoIEkgc3VzcGVj
dCB5b3UgaXQncyBtb3JlIGFuIHVuY2FjaGVkIG1hcHBpbmcgc2hvd2luZyB1cAo+Pj4+IHdoZW4g
d2UgZG9uJ3QgZXhwZWN0IGl0Lgo+Pj4KPj4+IEl0J3MgbG9va2luZyBsaW5lIG51bWJlciAxLCB0
aGVyZSBpcyBubyBtYXBwaW5nLCBub3cgd2UgZ2V0IHVuY2FjaGVkCj4+PiB3aGVyZSB3ZSB1c2Vk
IHRvIGdldCB3cml0ZSB0aHJvdWdoLgo+Pj4KPj4+IGRpZmZlcmVuY2UgaW4gcGFnZSBwcm90IDdm
N2JiYzBlMDAwMCwgcGZuIDIwMDAwMDAwMDAwZTcxZTQsCj4+PiA4MDAwMDAwMDAwMDAwMDM3LCA4
MDAwMDAwMDAwMDAwMDJmCj4+Pgo+Pj4gMHgyZiBpcyB0aGUgdm1hIHBnIHByb3Qgd2hpY2ggaGFz
IFBXVCBzZXQgaW4gaXQsIDB4MzcgaXMgdGhlIHJldHVybmVkCj4+PiBwZ3Byb3Qgd2hpY2ggbGFj
a3MgdGhhdCBiaXQuCj4+Pgo+Pj4gbm90IHN1cmUgd2hlcmUgdG8gZ28gZnJvbSBoZXJlLCBzdWdn
ZXN0aW9ucz8KPj4KPj4gSWYgdGhlIGRyaXZlciBlc3RhYmxpc2hlZCBhbiBpb3JlbWFwX3d0KCkg
YWNyb3NzIHRoZSByYW5nZSwgb3IganVzdAo+PiBjYWxsZWQgcmVzZXJ2ZV9tZW10eXBlKCkgZGly
ZWN0bHkgdGhhdCBzaG91bGQgcmVzdG9yZSBXVCBtYXBwaW5ncy4KPj4KPj4gQWx0aG91Z2ggRGFu
aWVsJ3Mgc3VnZ2VzdGlvbiB0byB1c2UgdGhlIGk5MTUgbWFwcGluZyBoZWxwZXJzIHNvdW5kcwo+
PiBsaWtlIGl0IGF2b2lkcyBwcm9ibGVtIDMvIGFzIHdlbGwuCj4KPiBXZWxsIHdlIHNob3VsZG4n
dCBiZSBkb2luZyB0aGF0IG1hbnkgVlJBTSBtYXBwaW5ncyBvbiB0aGUgQ1BVIHNvCj4gSSBkb3Vi
dCB3ZSdsbCBoaXQgdGhlIG92ZXJoZWFkcyBoZXJlIHRoYXQgb2Z0ZW4uCj4KPiBJZGVhbGx5IHdl
J2QgYWx3YXlzIHVzZSBETUEgdG8gbW92ZSBzdHVmZiBpbi9vdXQgb2YgVlJBTSwgYnV0IHRoZXJl
Cj4gYXJlIHNvbWUgcGxhY2VzIHdoZXJlIHdlIHN0aWxsIGRvIFdDIFZSQU0gd3JpdGVzIGZvciB1
cGxvYWRzLgoKV0MgVlJBTSBmb3IgdXBsb2FkcyBpcyBiZXR0ZXIgdGhhbiBXQyBHQVJUIElNTy4K
Ck1hcmVrCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRy
aS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
