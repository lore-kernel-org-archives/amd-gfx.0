From: Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH 2/3] drm/amdgpu: add the interface of waiting multiple
 fences (v3)
Date: Fri, 4 Nov 2016 11:33:44 -0600
Message-ID: <CAO_48GGixGF_et3u5t_VJ6LYhY+MWFaMjO07zpSPt8dDhBYwag@mail.gmail.com>
References: <1478194871-29766-1-git-send-email-alexander.deucher@amd.com>
 <1478194871-29766-2-git-send-email-alexander.deucher@amd.com>
 <CAO_48GGkL2Jiwby6Wx3n1_vRNSpCBa9PSaAJxKGore9Rb7=6pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAO_48GGkL2Jiwby6Wx3n1_vRNSpCBa9PSaAJxKGore9Rb7=6pg@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Junwei Zhang <Jerry.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, DRI mailing list <dri-devel@lists.freedesktop.org>, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gNCBOb3ZlbWJlciAyMDE2IGF0IDExOjE0LCBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBs
aW5hcm8ub3JnPiB3cm90ZToKPiBIaSBBbGV4LAo+Cj4gVGhhbmtzIGZvciB0aGUgcGF0Y2ghCj4K
PiBPbiAzIE5vdmVtYmVyIDIwMTYgYXQgMTE6NDEsIEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJA
Z21haWwuY29tPiB3cm90ZToKPj4gRnJvbTogSnVud2VpIFpoYW5nIDxKZXJyeS5aaGFuZ0BhbWQu
Y29tPgo+Pgo+PiB2MjogYWdkOiByZWJhc2UgYW5kIHNxdWFzaCBpbiBhbGwgdGhlIHByZXZpb3Vz
IG9wdGltaXphdGlvbnMgYW5kCj4+IGNoYW5nZXMgc28gZXZlcnl0aGluZyBjb21waWxlcy4KPj4g
djM6IHNxdWFzaCBpbiBTbGF2YSdzIDMyYml0IGJ1aWxkIGZpeAo+Pgo+PiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaAo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHUuaAo+IDxzbmlwPgo+PiArCj4+ICsgICAgICAgciA9IGZlbmNlX3dhaXRf
YW55X3RpbWVvdXQoYXJyYXksIGZlbmNlX2NvdW50LCB0cnVlLCB0aW1lb3V0KTsKPgo+IFdpdGgg
dGhlIGNoYW5nZSBwcm9wb3NlZCBhYm91dCByZXR1cm5pbmcgaW5kZXggb2Ygc2lnbmFsbGVkIGZl
bmNlIGluCj4gcGF0Y2ggMS8zLCBJIGRvbid0IHRoaW5rIHRoaXMgd291bGQgYnVpbGQ/Cj4KTywg
anVzdCBub3RpY2VkIC0gcGVyaGFwcyBqdXN0IGEgcmVvcmRlcmluZyBvZiBwYXRjaGVzIHNvIHRo
YXQgdGhpcyBpcwoxLzMgKG9yIGV2ZW4gYSBzZXBhcmF0ZSBwYXRjaD8pIGFuZCBkbWEtYnVmIGNo
YW5nZSBmb3IgaW5kZXggKyBhbWRncHUKY2hhbmdlIGZvciB0aGUgaW5kZXggYXJlIDIvMyBhbmQg
My8zLCBzaG91bGQgc29sdmUgaXQuCgoKPiBCZXN0IHJlZ2FyZHMsCj4gU3VtaXQuCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5n
IGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
