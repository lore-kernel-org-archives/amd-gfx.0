From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: replace iova debugfs file with iomem (v2)
Date: Fri, 9 Feb 2018 13:19:43 -0500
Message-ID: <761fbdc6-bf8d-b8f4-350f-515418921b30@amd.com>
References: <20180209172750.15675-1-tom.stdenis@amd.com>
 <4708aad9-9ff0-d09f-9bb6-453c01c848a4@amd.com>
 <50edcafc-23dd-3c44-021f-cf5989d06dc2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <50edcafc-23dd-3c44-021f-cf5989d06dc2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDkvMDIvMTggMDE6MTcgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMDkuMDIu
MjAxOCB1bSAxODoyOCBzY2hyaWViIFRvbSBTdCBEZW5pczoKPj4gT24gMDkvMDIvMTggMTI6Mjcg
UE0sIFRvbSBTdCBEZW5pcyB3cm90ZToKPj4+IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2Vu
aWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPgo+Pgo+PiBPb3BzLCBJJ2xsIHJlbW92ZSB0aGlz
IGZyb20gdGhlIGNvbW1pdCBtZXNzYWdlIGJlZm9yZSBwdXNoaW5nIDotKQo+Pgo+PiBJIGRpZCBn
aXZlIHlvdSBjcmVkaXQgYmVsb3cgdGhvdWdoLgo+IAo+IFRoZSBwYXRjaCBiZWZvcmUgdGhpcyBv
bmUgaXNuJ3QgbWVyZ2VkIHlldCBiZWNhdXNlIEknbSBzdGlsbCBub3Qgc3VyZSBpZiAKPiB0aGF0
IHdvcmtzIHVuZGVyIGFsbCBjaXJjdW1zdGFuY2VzIG9yIG5vdC4KPiAKPiBDb3VsZCB5b3UgZ2l2
ZSBpdCBzb21lIGV4dGVuZGVkIHRlc3Rpbmc/IEVzcGVjaWFsbHkgaWYgaXQgd29yayB3aXRoIAo+
IGV2aWN0aW9uLgoKSSBzdXBwb3NlZCB0aGVyZSBpcyBhIHJhY2Ugb24gdGhlIGttYXAnZWQgbWVt
b3J5IHdoaWNoIGlzIHdoeSBJIGFkZGVkIGEgCnB0ciBjaGVjay4gIE5vdCBwZXJmZWN0IGJ1dCBz
aW5jZSBpdCdzIGEgZGVidWdmcyBlbnRyeSBwcm9iYWJseSBiZXR0ZXIgCnRoYW4gaXQgbmVlZHMg
dG8gYmUuCgpJJ2xsIGdpdmUgaXQgYSB0cnkgb24gc29tZSBsaXZlIHRyYWZmaWMgbmV4dC4KCkNo
ZWVycywKVG9tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
