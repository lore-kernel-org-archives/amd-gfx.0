From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: The issue with page allocation 5.3 rc1-rc2 (seems drm culprit
 here)
Date: Thu, 8 Aug 2019 10:12:59 +0200
Message-ID: <6d5110ab-6539-378d-f643-0a1d4cf0ff73@daenzer.net>
References: <20190806014830.7424-1-hdanton@sina.com>
 <CABXGCsMRGRpd9AoJdvZqdpqCP3QzVGzfDPiX=PzVys6QFBLAvA@mail.gmail.com>
 <CADnq5_O08v3_NUZ_zUZJFYwv_tUY7TFFz2GGudqgWEX6nh5LFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CADnq5_O08v3_NUZ_zUZJFYwv_tUY7TFFz2GGudqgWEX6nh5LFA@mail.gmail.com>
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
To: Alex Deucher <alexdeucher@gmail.com>, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Hillf Danton <hdanton@sina.com>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Linux Memory Management List <linux-mm@kvack.org>, dri-devel <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOS0wOC0wOCA3OjMxIGEubS4sIEFsZXggRGV1Y2hlciB3cm90ZToKPiBPbiBXZWQsIEF1
ZyA3LCAyMDE5IGF0IDExOjQ5IFBNIE1pa2hhaWwgR2F2cmlsb3YKPiA8bWlraGFpbC52LmdhdnJp
bG92QGdtYWlsLmNvbT4gd3JvdGU6Cj4+Cj4+IFVuZm9ydHVuYXRlbHkgZXJyb3IgImdub21lLXNo
ZWxsOiBwYWdlIGFsbG9jYXRpb24gZmFpbHVyZTogb3JkZXI6NCwKPj4gbW9kZToweDQwY2MwKEdG
UF9LRVJORUx8X19HRlBfQ09NUCksCj4+IG5vZGVtYXNrPShudWxsKSxjcHVzZXQ9LyxtZW1zX2Fs
bG93ZWQ9MCIgc3RpbGwgaGFwcGVucyBldmVuIHdpdGgKPj4gYXBwbHlpbmcgdGhpcyBwYXRjaC4K
PiAKPiBJIHRoaW5rIHdlIGNhbiBqdXN0IGRyb3AgdGhlIGttYWxsb2MgYWx0b2dldGhlci4gIEhv
dyBhYm91dCB0aGlzIHBhdGNoPwoKTWVtb3J5IGFsbG9jYXRlZCBieSBrdnovbWFsbG9jIG5lZWRz
IHRvIGJlIGZyZWVkIHdpdGgga3ZmcmVlLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIg
ICAgICAgICAgICAgICB8ICAgICAgICAgICAgICBodHRwczovL3d3dy5hbWQuY29tCkxpYnJlIHNv
ZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRl
dmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpk
cmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
