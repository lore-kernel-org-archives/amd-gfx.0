From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: replace iova debugfs file with iomem (v2)
Date: Mon, 12 Feb 2018 18:16:22 +0100
Message-ID: <8c42ceb6-4c95-d82f-d347-37ee793855a6@amd.com>
References: <20180209172750.15675-1-tom.stdenis@amd.com>
 <4708aad9-9ff0-d09f-9bb6-453c01c848a4@amd.com>
 <50edcafc-23dd-3c44-021f-cf5989d06dc2@gmail.com>
 <761fbdc6-bf8d-b8f4-350f-515418921b30@amd.com>
 <50cdbb8f-3b64-bed3-322c-bcce05b39370@gmail.com>
 <f218e0b7-2150-0114-4164-5cb090491454@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <f218e0b7-2150-0114-4164-5cb090491454@amd.com>
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
To: Tom St Denis <tom.stdenis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

QW0gMTIuMDIuMjAxOCB1bSAxNzo0MCBzY2hyaWViIFRvbSBTdCBEZW5pczoKPiBPbiAwOS8wMi8x
OCAwMTo0NCBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMDkuMDIuMjAxOCB1bSAx
OToxOSBzY2hyaWViIFRvbSBTdCBEZW5pczoKPj4+IE9uIDA5LzAyLzE4IDAxOjE3IFBNLCBDaHJp
c3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4+IEFtIDA5LjAyLjIwMTggdW0gMTg6Mjggc2NocmllYiBU
b20gU3QgRGVuaXM6Cj4+Pj4+IE9uIDA5LzAyLzE4IDEyOjI3IFBNLCBUb20gU3QgRGVuaXMgd3Jv
dGU6Cj4+Pj4+PiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2Vu
QGdtYWlsLmNvbT4KPj4+Pj4KPj4+Pj4gT29wcywgSSdsbCByZW1vdmUgdGhpcyBmcm9tIHRoZSBj
b21taXQgbWVzc2FnZSBiZWZvcmUgcHVzaGluZyA6LSkKPj4+Pj4KPj4+Pj4gSSBkaWQgZ2l2ZSB5
b3UgY3JlZGl0IGJlbG93IHRob3VnaC4KPj4+Pgo+Pj4+IFRoZSBwYXRjaCBiZWZvcmUgdGhpcyBv
bmUgaXNuJ3QgbWVyZ2VkIHlldCBiZWNhdXNlIEknbSBzdGlsbCBub3QgCj4+Pj4gc3VyZSBpZiB0
aGF0IHdvcmtzIHVuZGVyIGFsbCBjaXJjdW1zdGFuY2VzIG9yIG5vdC4KPj4+Pgo+Pj4+IENvdWxk
IHlvdSBnaXZlIGl0IHNvbWUgZXh0ZW5kZWQgdGVzdGluZz8gRXNwZWNpYWxseSBpZiBpdCB3b3Jr
IHdpdGggCj4+Pj4gZXZpY3Rpb24uCj4+Pgo+Pj4gSSBzdXBwb3NlZCB0aGVyZSBpcyBhIHJhY2Ug
b24gdGhlIGttYXAnZWQgbWVtb3J5IHdoaWNoIGlzIHdoeSBJIAo+Pj4gYWRkZWQgYSBwdHIgY2hl
Y2suwqAgTm90IHBlcmZlY3QgYnV0IHNpbmNlIGl0J3MgYSBkZWJ1Z2ZzIGVudHJ5IAo+Pj4gcHJv
YmFibHkgYmV0dGVyIHRoYW4gaXQgbmVlZHMgdG8gYmUuCj4+Cj4+IEkgdGhpbmsgeW91IGNhbiBk
cm9wIHRoYXQsIGttYXAgY2FuIG9ubHkgcmV0dXJuIE5VTEwgb24gMzJiaXQgc3lzdGVtcyAKPj4g
d2hlbiB3ZSByYW4gb3V0IG9mIHZtYXAgYXJlYSBhbmQgdGhlbiB5b3UgY2FuIGJhc2ljYWxseSBj
YWxsIHBhbmljKCkgCj4+IGFzIHdlbGwuCj4+Cj4+IFRoZSBxdWVzdGlvbiBpcyBpZiBzZXR0aW5n
IHBhZ2UtPm1hcHBpbmcgZHVyaW5nIGFsbG9jYXRpb24gaGFzIHNvbWUgCj4+IHVuZGVzaXJlZCBz
aWRlIGVmZmVjdC4KPgo+Cj4gSGF2ZW4ndCBub3RpY2VkIGFueXRoaW5nIHdpdGggcGlnbGl0IG9y
IG90aGVyIEZPU1MgR0wgZ2FtZXMuCj4KPiBJcyB0aGVyZSBhIHNwZWNpZmljIHRlc3QgeW91J2Qg
bGlrZSBtZSB0byBjb25zaWRlcj8KClRyeSB0byByZXN0cmljdCBWUkFNL0dUVC9tZW1vcnkgaW4g
Z2VuZXJhbCBhbmQgcnVuIHNvbWV0aGluZyB3aGljaCBuZWVkcyAKYSBsb3Qgb2YgQ1BVIGFjY2Vz
cyB0byBCT3MuIFdoZW4gaXQgYWZmZWN0cyBhbnl0aGluZyB0aGVuIHRoZSBDUFUgcGFnZSAKdGFi
bGUgdW5tYXAgb2YgQk9zIGR1cmluZyBldmljdGlvbi4KCkNocmlzdGlhbi4KCj4KPiBUb20KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBt
YWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
