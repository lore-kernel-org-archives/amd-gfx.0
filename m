From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay/smu7_hwmgr: replace blocking delay with
 non-blocking
Date: Fri, 5 Jul 2019 16:34:57 -0400
Message-ID: <CADnq5_Oh76ABprkBrnJBaamv4gi15szfkJi8hM_Ys=d_4xTr+g@mail.gmail.com>
References: <20190530000819.GA25416@obi-wan> <20190604202149.GA20116@obi-wan>
 <CADnq5_OqVSz7Vfo0zP88i=wJur=wtz6Jd99ZTiQSbFNBcc3j7w@mail.gmail.com>
 <20190616144309.GA8174@obi-wan> <20190704201535.GA21911@obi-wan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190704201535.GA21911@obi-wan>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Yrjan Skrimstad <yrjan@skrimstad.net>
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>, Rex Zhu <rex.zhu@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gVGh1LCBKdWwgNCwgMjAxOSBhdCA0OjE1IFBNIFlyamFuIFNrcmltc3RhZCA8eXJqYW5Ac2ty
aW1zdGFkLm5ldD4gd3JvdGU6Cj4KPiBPbiBTdW4sIEp1biAxNiwgMjAxOSBhdCAwNDo0MzoxMFBN
ICswMjAwLCBZcmphbiBTa3JpbXN0YWQgd3JvdGU6Cj4gPiBUaGF0IGlzIGFuIGludGVyZXN0aW5n
IG9ic2VydmF0aW9uIHRvIG1lLiBJIGFtIGFjdHVhbGx5IHJ1bm5pbmcKPiA+IGxtLXNlbnNvcnMs
IGFsdGhvdWdoIG9ubHkgZXZlcnkgMTUgc2Vjb25kcy4gSSBzdXBwb3NlIHRoYXQgdGhpcyBtaWdo
dAo+ID4gYmUgdGhlIHJlYXNvbiB0aGlzIGhhcHBlbnMgdG8gbWUuCj4KPiBUaG91Z2ggSSBkb24n
dCB0aGluayB0aGlzIHNob3VsZCByZWFzb25hYmx5IGNhdXNlIHByb2JsZW1zIHdpdGggdGhlCj4g
c3lzdGVtLCBldmVuIGlmIGl0IGRvZXMgaGVyZS4gSXMgdGhlcmUgYW4gdXBkYXRlIG9uIHRoZSBz
dGF0dXMgb2YgdGhpcwo+IHBhdGNoPwoKQXBwbGllZC4gIHNvcnJ5IGZvciB0aGUgZGVsYXkuCgpB
bGV4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1k
ZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
