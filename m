From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: extend AMDGPU_CTX_PRIORITY_NORMAL comment
Date: Mon, 15 Jul 2019 14:10:12 +0200
Message-ID: <61429d92-640b-b092-08b2-378e28aa10e8@gmail.com>
References: <20190614173335.30907-1-emil.l.velikov@gmail.com>
 <b3b4b6d8-1b64-7860-88e5-ec91b9d2f711@amd.com>
 <CACvgo51LkcF6LydoH8BCaKwK4trfrm0EQkjMricQ3b0RXcrhrA@mail.gmail.com>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CACvgo51LkcF6LydoH8BCaKwK4trfrm0EQkjMricQ3b0RXcrhrA@mail.gmail.com>
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
To: Emil Velikov <emil.l.velikov@gmail.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

QW0gMDIuMDcuMTkgdW0gMTk6MTUgc2NocmllYiBFbWlsIFZlbGlrb3Y6Cj4gT24gRnJpLCAxNCBK
dW4gMjAxOSBhdCAxOTowMiwgS29lbmlnLCBDaHJpc3RpYW4KPiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPiB3cm90ZToKPj4gQW0gMTQuMDYuMTkgdW0gMTk6MzMgc2NocmllYiBFbWlsIFZlbGlr
b3Y6Cj4+PiBGcm9tOiBFbWlsIFZlbGlrb3YgPGVtaWwudmVsaWtvdkBjb2xsYWJvcmEuY29tPgo+
Pj4KPj4+IEN1cnJlbnRseSB0aGUgQU1ER1BVX0NUWF9QUklPUklUWV8qIGRlZmluZXMgYXJlIHVz
ZWQgaW4gYm90aAo+Pj4gZHJtX2FtZGdwdV9jdHhfaW46OnByaW9yaXR5IGFuZCBkcm1fYW1kZ3B1
X3NjaGVkX2luOjpwcmlvcml0eS4KPj4+Cj4+PiBFeHRlbmQgdGhlIGNvbW1lbnQgdG8gbWVudGlv
biB0aGUgQ0FQX1NZU19OSUNFIG9yIERSTV9NQVNURVIgcmVxdWlyZW1lbnQKPj4+IGlzIG9ubHkg
YXBwbGljYWJsZSB3aXRoIHRoZSBmb3JtZXIuCj4+Pgo+Pj4gQ2M6IEJhcyBOaWV1d2VuaHVpemVu
IDxiYXNAYmFzbmlldXdlbmh1aXplbi5ubD4KPj4+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+PiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPgo+Pj4gU2lnbmVkLW9mZi1ieTogRW1pbCBWZWxpa292IDxlbWlsLnZlbGlr
b3ZAY29sbGFib3JhLmNvbT4KPj4+IC0tLQo+Pj4gTWlsZGx5IGN1cmlvdXM6IHdoeSBkaWRuJ3Qg
b25lIGV4dGVuZCBjdHhfYW1kZ3B1X2N0eCBpbnN0ZWFkIG9mIGFkZGluZwo+Pj4gZHJtX2FtZGdw
dV9zY2hlZD8gTmV3IGZsYWcgKyBfdTMyIGZkIGF0IHRoZSBlbmQgKGZvciB0aGUgZm9ybWVyKSB3
b3VsZAo+Pj4gaGF2ZSBiZWVuIGVub3VnaCAoYW5kIHR3ZWFraW5nIHRoZSBpb2N0bCBwZXJtaXNz
aW9uIHRoaW5neSkuCj4+IFRoZSBkcm1fYW1kZ3B1X3NjaGVkIGlzIG9ubHkgYWxsb3dlZCBmb3Ig
RFJNX01BU1RFUi4KPj4KPiBGYWlyIGVub3VnaC4KPgo+IElzIHRoZSBwYXRjaCB3cm9uZyBvciBk
aWQgaXQgc2xpcCB0aHJvdWdoIHRoZSBjcmFja3M/IEkgY2Fubm90IHNlZSBpdAo+IGluIEFsZXgn
cyB0cmVlLgoKTG9va3MgbGlrZSBBbGV4IGp1c3QgbWlzc2VkIHRoaXMgb25lIGFuZCBJIHdhcyBv
biB2YWNhdGlvbi9vdXQgb2Ygb2ZmaWNlIApmb3IgYSB3aGlsZS4KCkkndmUgZ29uZSBhaGVhZCBh
ZGRlZCBteSByYiBhbmQganVzdCBwdXNoZWQgaXQuCgpUaGFua3MsCkNocmlzdGlhbi4KCj4KPiAt
RW1pbAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4g
YW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1h
aWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
