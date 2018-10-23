From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Retire amdgpu_ring.ready flag v3
Date: Tue, 23 Oct 2018 11:23:49 +0200
Message-ID: <95114984-f71e-05e3-475b-49e9d73181c6@gmail.com>
References: <1540241214-21077-1-git-send-email-andrey.grodzovsky@amd.com>
 <1540241214-21077-2-git-send-email-andrey.grodzovsky@amd.com>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1540241214-21077-2-git-send-email-andrey.grodzovsky@amd.com>
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
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

QW0gMjIuMTAuMTggdW0gMjI6NDYgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPiBTdGFydCB1
c2luZyBkcm1fZ3B1X3NjaGVkdWxlci5yZWFkeSBpc250ZWFkLgo+Cj4gdjM6Cj4gQWRkIGhlbHBl
ciBmdW5jdGlvbiB0byBydW4gcmluZyB0ZXN0IGFuZCBzZXQKPiBzY2hlZC5yZWFkeSBmbGFnIHN0
YXR1cyBhY2NvcmRpbmdseSwgY2xlYW4gZXhwbGljaXQKPiBzY2hlZC5yZWFkeSBzZXRzIGZyb20g
dGhlIElQIHNwZWNpZmljIGZpbGVzLgo+Cj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6b3Zz
a3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+Cj4gLS0tCgo+IFtTTklQXQo+ICsKPiAraW50
IGFtZGdwdV9yaW5nX3Rlc3RfaGVscGVyKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKClRoaXMg
bmVlZHMgc29tZSBrZXJuZWwgZG9jLCB3aXRoIHRoYXQgZml4ZWQgdGhlIHBhdGNoIGlzIFJldmll
d2VkLWJ5OiAKQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKRGlk
IHlvdSBtaXNzZWQgbXkgY29tbWVudCBvbiB0aGUgZmlyc3QgcGF0Y2g/CgpUaGFua3MgZm9yIHRo
ZSBuaWNlIGNsZWFudXAsCkNocmlzdGlhbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vZHJpLWRldmVsCg==
