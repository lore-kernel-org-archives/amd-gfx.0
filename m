From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 1/3] drm/amd: fix race in page flip job
Date: Fri, 21 Dec 2018 09:56:52 +0100
Message-ID: <02562071-6010-7c49-fb82-aceaf24d877f@daenzer.net>
References: <20181221031053.240161-1-yuzhao@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181221031053.240161-1-yuzhao@google.com>
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
To: Yu Zhao <yuzhao@google.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: Daniel Stone <daniels@collabora.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Samuel Li <Samuel.Li@amd.com>, Junwei Zhang <Jerry.Zhang@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOC0xMi0yMSA0OjEwIGEubS4sIFl1IFpoYW8gd3JvdGU6Cj4gRml4IHJhY2UgYmV0d2Vl
biBwYWdlIGZsaXAgam9iIHN1Ym1pc3Npb24gYW5kIGNvbXBsZXRpb24uIFdlIGludm9rZQo+IHBh
Z2VfZmxpcCBjYWxsYmFjayB0byBzdWJtaXQgcGFnZSBmbGlwIGpvYiB0byBHUFUgZmlyc3QgYW5k
IHRoZW4gc2V0Cj4gcGZsaXBfc3RhdHVzLiBJZiBHUFUgZmlyZXMgcGFnZSBmbGlwIGRvbmUgaXJx
IGluIGJldHdlZW4sIGl0cyBoYW5kbGVyCj4gd29uJ3Qgc2VlIHRoZSBjb3JyZWN0IHBmbGlwX3N0
YXR1cyB0aHVzIHdpbGwgcmVmdXNlIHRvIG5vdGlmeSB0aGUgam9iCj4gY29tcGxldGlvbi4gVGhl
IGpvYiB3aWxsIGV2ZW50dWFsbHkgdGltZXMgb3V0Lgo+IAo+IFJldmVyc2UgdGhlIG9yZGVyIG9m
IGNhbGxpbmcgcGFnZV9mbGlwIGFuZCBzZXR0aW5nIHBmbGlwX3N0YXR1cyB0bwo+IGZpeCB0aGUg
cmFjZS4KClRoZXJlIGlzIG5vIHJhY2UsIGFtZGdwdV9jcnRjLT5wZmxpcF9zdGF0dXMgaXMgcHJv
dGVjdGVkIGJ5IGRldi0+ZXZlbnRfbG9jay4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVy
ICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBz
b2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBk
ZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
ZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
