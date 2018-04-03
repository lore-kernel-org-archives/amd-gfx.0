From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: Add modeset module option
Date: Tue, 3 Apr 2018 13:30:08 +0200
Message-ID: <b5467593-429e-4e15-5d99-1a057a241d28@amd.com>
References: <20180330204512.16863-1-tiwai@suse.de>
 <20180330204512.16863-2-tiwai@suse.de>
 <c95f9e61-c921-42de-9e03-851d785ab5fc@amd.com>
 <CAKb7Uvh_CxE=Zg_F0tentwXK64_baxs0TCQ-K9Mh_Mjf+NV_DA@mail.gmail.com>
 <706f4d0d-4583-2c8a-447d-f6cdd3429ad5@amd.com> <s5ho9j24wk9.wl-tiwai@suse.de>
 <0ecce204-6af8-2395-ac40-391e3b655bed@amd.com>
 <20180403092948.GQ3881@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180403092948.GQ3881-dv86pmgwkMBes7Z6vYuT8azUEOm+Xw19@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMDMuMDQuMjAxOCB1bSAxMToyOSBzY2hyaWViIERhbmllbCBWZXR0ZXI6Cj4gT24gU3VuLCBB
cHIgMDEsIDIwMTggYXQgMTA6MTI6MTBQTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToK
Pj4gQW0gMDEuMDQuMjAxOCB1bSAyMDoyMSBzY2hyaWViIFRha2FzaGkgSXdhaToKPj4gW1NOSVBd
Cj4+IFdlbGwgZXhhY3RseSB0aGF0J3MgdGhlIHBvaW50LCBub3RoaW5nLgo+Pgo+PiBUaGUgcHJv
YmxlbSBpcyB0aGF0IHRoZSBvcHRpb24gbmFtZSBpcyBjb25mdXNpbmcgdG8gdGhlIGVuZCB1c2Vy
IGJlY2F1c2UgdGhlCj4+IGV4cGVjdGF0aW9uIGlzIHRoYXQgIm5vbW9kZXNldCIganVzdCBtZWFu
cyB0aGF0IHRoZXkgb25seSBjYW4ndCBjaGFuZ2UgdGhlCj4+IGRpc3BsYXkgbW9kZS4KPj4KPj4g
U29tZSAodW5mb3J0dW5hdGVseSBxdWl0ZSBhIGxvdCkgcGVvcGxlIGRvbid0IHJlYWxpemUgdGhh
dCBmb3IgS01TIGRyaXZlcnMKPj4gdGhpcyBtZWFucyB0aGF0IHRoZSBkcml2ZXIgaXNuJ3QgZXZl
biBsb2FkZWQgYW5kIHRoZXkgYWxzbyBkb24ndCBnZXQgYW55Cj4+IGFjY2VsZXJhdGlvbi4KPj4K
Pj4gV2UgaGFkIHRvIGV4cGxhaW4gdGhhdCBudW1lcm91cyB0aW1lcyBub3cuIEkgdGhpbmsgaXQg
d291bGQgYmUgYmVzdCB0byBnaXZlCj4+IHRoZSBvcHRpb24gYSBtb3JlIG1lYW5pbmdmdWwgbmFt
ZS4KPiBZZWFoLCBhZ3JlZWQgd2l0aCBDaHJpc3RpYW4uIElmIHdlIHdhbnQgYSBnZW5lcmljICJw
bHMgZGlzYWJsZSBhbGwgZ2Z4Cj4gYWNjZWwiIGtub2IgdGhlbiBwcm9iYWJseSBiZXN0IHRvIHB1
dCB0aGF0IGludG8gdGhlIGRybSBjb3JlLiBBbmQganVzdAo+IG91dHJpZ2h0IGZhaWwgbG9hZGlu
ZyB0aGUgZHJtIGNvcmUgaWYgdGhhdCBoYXBwZW5zLCB3aGljaCB3aWxsIHByZXZlbnQgYWxsCj4g
Z2Z4IGRyaXZlcnMgZnJvbSBsb2FkaW5nLgo+Cj4gVGhhdCBsaWtlbHkgbWVhbnMgYSBob2xlIGJ1
bmNoIG9mIHN0dWZmIHdvbid0IHdvcmsgKHVzdWFsbHkgc291bmQga2VlbHMKPiBvdmVyIHRvbyks
IGJ1dCB0aGF0J3Mgd2hhdCB5b3UgZ2V0IGZvciB0aGlzLiBPbmx5IGRpc2FibGluZyBtb2Rlc2V0
dGluZwo+IHdpdGhvdXQgZGlzYWJsaW5nIHRoZSBlbnRpcmUgZHJpdmVyIGRvZXNuJ3Qgd29yayAo
bmV2ZXIgaGFzLCBleGNlcHQgZm9yCj4gdGhpcyBVTVMrR0VNIGNvbWJvIG9ubHkgaTkxNSBzdXBw
b3J0LCBhbmQgbm90IGZvciBsb25nKS4KPgo+IEFuZCBvbmNlIHdlIGhhdmUgdGhhdCBrbm9iLCBw
cm9iYWJseSBiZXN0IHRvIHBoYXNlIG91dCBhbGwgdGhlIHBlci1kcml2ZXIKPiBvcHRpb25zLgoK
KyBzb21lIGNvbXBhYmlsaXR5IGNvZGUgdG8ga2VlcCAibm9tb2Rlc2V0IiB3b3JraW5nIGZvciBh
IHdoaWxlIGxvbmdlciAKYW5kIHByaW50aW5nIGEgd2FybmluZyB0aGF0IHRoZSBvcHRpb24gaXMg
ZGVwcmVjYXRlZC4KCklmIHdlIGFwcHJvYWNoIGl0IGxpa2UgdGhhdCB0aGUgd2hvbGUgaWRlYSBz
b3VuZHMgcmF0aGVyIHJlYXNvbmFibGUgdG8gbWUuCgpDaHJpc3RpYW4uCgo+IC1EYW5pZWwKPgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
