From: Dave Airlie <airlied@gmail.com>
Subject: Re: mm: fix cache mode tracking in vm_insert_mixed() breaks AMDGPU
 [was: Re: Latest testing with drm-next-4.9-wip and latest LLVM/mesa stack -
 Regression in PowerPlay/DPM on CIK?]
Date: Wed, 19 Oct 2016 16:42:08 +1000
Message-ID: <CAPM=9txdaRwEMk6ZZaCYWRbo5Q4iGO=hydg0oU_FxEdctf2ang@mail.gmail.com>
References: <11271056.dD6Mas21fI@segfault> <5955047.4M9YlcR7bW@segfault>
 <8025413.75ZrRe18t5@segfault> <3888118.bNeqOmVUhz@segfault>
 <10a1e298-df32-52a5-7694-b205794ca009@daenzer.net>
 <CAAxE2A6T9wX9tbsYhLA+zPGSQBXfCTAntKw5uTgfWu__7btHiA@mail.gmail.com>
 <CAPM=9twLoEY-huyv6kaupqu6XodgqGsEmgHqx4vasJ1aj_1HdA@mail.gmail.com>
 <CAPcyv4hbgnmETbne6qXizaBkUTJm291xRa4BuouFb_6uJAZj3w@mail.gmail.com>
 <CAPM=9tx5ayYzTk8hm-c8JaWReNEQ3yem-r4ac5r8bFuQXzOwiA@mail.gmail.com>
 <CAPM=9tyrP7yB8GYtFg2=S60DOngMULj5HB7eg7+ts1jK+S97oA@mail.gmail.com>
 <CAPcyv4h6Bz8vOUuBPy=tRJLv3-QPMY800QpACbKp7GPDcF_AoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAPcyv4h6Bz8vOUuBPy=tRJLv3-QPMY800QpACbKp7GPDcF_AoQ@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, Shawn Starr <shawn.starr@rogers.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gMTggT2N0b2JlciAyMDE2IGF0IDIzOjUzLCBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1z
QGludGVsLmNvbT4gd3JvdGU6Cj4gT24gTW9uLCBPY3QgMTcsIDIwMTYgYXQgODo0OCBQTSwgRGF2
ZSBBaXJsaWUgPGFpcmxpZWRAZ21haWwuY29tPiB3cm90ZToKPiBbLi5dCj4+Pj4gQXJlbid0IHRo
ZXJlIG9ubHkgMiBwb3NzaWJpbGl0aWVzIGZvciB0aGlzIHJlZ3Jlc3Npb24/Cj4+Pj4KPj4+PiAx
LyBhIG1lbXR5cGUgZW50cnkgd2FzIG5ldmVyIG1hZGUgc28gdHJhY2tfcGZuX2luc2VydCgpIHJl
dHVybnMgYW4KPj4+PiB1bmNhY2hlZCBtYXBwaW5nCj4+Pj4KPj4+PiAyLyBhIGNvbmZsaWN0aW5n
IG1lbXR5cGUgZW50cnkgZXhpc3RzIGFuZCB1bmRlZmluZWQgYmVoYXZpb3IgZHVlIHRvCj4+Pj4g
bWl4ZWQgbWFwcGluZyB0eXBlcyBpcyBhdm9pZGVkIHdpdGggdGhlIGNoYW5nZS4KPj4+Cj4+PiAz
LyBUaGUgQ1BVIHVzYWdlIHRocm91Z2ggdGhpcyBwYXRoIGdvZXMgdXAsIGFuZCBzbG93cyB0aGlu
Z3MgZG93biwKPj4+IHRob3VnaCBJIHN1c3BlY3QgeW91IGl0J3MgbW9yZSBhbiB1bmNhY2hlZCBt
YXBwaW5nIHNob3dpbmcgdXAKPj4+IHdoZW4gd2UgZG9uJ3QgZXhwZWN0IGl0Lgo+Pgo+PiBJdCdz
IGxvb2tpbmcgbGluZSBudW1iZXIgMSwgdGhlcmUgaXMgbm8gbWFwcGluZywgbm93IHdlIGdldCB1
bmNhY2hlZAo+PiB3aGVyZSB3ZSB1c2VkIHRvIGdldCB3cml0ZSB0aHJvdWdoLgo+Pgo+PiBkaWZm
ZXJlbmNlIGluIHBhZ2UgcHJvdCA3ZjdiYmMwZTAwMDAsIHBmbiAyMDAwMDAwMDAwMGU3MWU0LAo+
PiA4MDAwMDAwMDAwMDAwMDM3LCA4MDAwMDAwMDAwMDAwMDJmCj4+Cj4+IDB4MmYgaXMgdGhlIHZt
YSBwZyBwcm90IHdoaWNoIGhhcyBQV1Qgc2V0IGluIGl0LCAweDM3IGlzIHRoZSByZXR1cm5lZAo+
PiBwZ3Byb3Qgd2hpY2ggbGFja3MgdGhhdCBiaXQuCj4+Cj4+IG5vdCBzdXJlIHdoZXJlIHRvIGdv
IGZyb20gaGVyZSwgc3VnZ2VzdGlvbnM/Cj4KPiBJZiB0aGUgZHJpdmVyIGVzdGFibGlzaGVkIGFu
IGlvcmVtYXBfd3QoKSBhY3Jvc3MgdGhlIHJhbmdlLCBvciBqdXN0Cj4gY2FsbGVkIHJlc2VydmVf
bWVtdHlwZSgpIGRpcmVjdGx5IHRoYXQgc2hvdWxkIHJlc3RvcmUgV1QgbWFwcGluZ3MuCj4KPiBB
bHRob3VnaCBEYW5pZWwncyBzdWdnZXN0aW9uIHRvIHVzZSB0aGUgaTkxNSBtYXBwaW5nIGhlbHBl
cnMgc291bmRzCj4gbGlrZSBpdCBhdm9pZHMgcHJvYmxlbSAzLyBhcyB3ZWxsLgoKV2VsbCB3ZSBz
aG91bGRuJ3QgYmUgZG9pbmcgdGhhdCBtYW55IFZSQU0gbWFwcGluZ3Mgb24gdGhlIENQVSBzbwpJ
IGRvdWJ0IHdlJ2xsIGhpdCB0aGUgb3ZlcmhlYWRzIGhlcmUgdGhhdCBvZnRlbi4KCklkZWFsbHkg
d2UnZCBhbHdheXMgdXNlIERNQSB0byBtb3ZlIHN0dWZmIGluL291dCBvZiBWUkFNLCBidXQgdGhl
cmUKYXJlIHNvbWUgcGxhY2VzIHdoZXJlIHdlIHN0aWxsIGRvIFdDIFZSQU0gd3JpdGVzIGZvciB1
cGxvYWRzLgoKU28gSSd2ZSBzZW50IHRoZSBwYXRjaGVzLCBhbnkgbWFqb3Igb3BpbmlvbnMgb24g
dGhlbSwgd2UgY2FuJ3QganVzdAppb3JlbWFwX3djIHRoZSB3aG9sZSBCQVIsIGFzIG9uIDMyLWJp
dCB0aGF0IGp1c3QgbWVzc2VzIHRoaW5ncyB1cAphbmQgaXQncyB1bm5lY2Vzc2FyeSBhbnl3YXlz
LgoKRGF2ZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
ZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
