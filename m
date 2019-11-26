From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm: radeon: replace 0 with NULL
Date: Tue, 26 Nov 2019 11:09:49 +0100
Message-ID: <9a585a20-b885-680f-d561-8713afe53fa1@amd.com>
References: <20191126003514.133692-1-jbi.octave@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191126003514.133692-1-jbi.octave@gmail.com>
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
To: Jules Irenge <jbi.octave@gmail.com>, alexander.deucher@amd.com
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

QW0gMjYuMTEuMTkgdW0gMDE6MzUgc2NocmllYiBKdWxlcyBJcmVuZ2U6Cj4gUmVwbGFjZSAwIHdp
dGggTlVMTCB0byBmaXggc3BhcnNlIHRvb2wgIHdhcm5pbmcKPiAgIHdhcm5pbmc6IFVzaW5nIHBs
YWluIGludGVnZXIgYXMgTlVMTCBwb2ludGVyCj4KPiBTaWduZWQtb2ZmLWJ5OiBKdWxlcyBJcmVu
Z2UgPGpiaS5vY3RhdmVAZ21haWwuY29tPgoKQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3JhZGVvbl9hdWRpby5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9y
YWRlb25fYXVkaW8uYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2F1ZGlvLmMKPiBp
bmRleCBiOWFlYTU3NzZkM2QuLjIyNjljZmNlZDc4OCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9hdWRpby5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9yYWRlb25fYXVkaW8uYwo+IEBAIC0yODgsNyArMjg4LDcgQEAgc3RhdGljIHZvaWQgcmFkZW9u
X2F1ZGlvX2ludGVyZmFjZV9pbml0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KQo+ICAgCX0g
ZWxzZSB7Cj4gICAJCXJkZXYtPmF1ZGlvLmZ1bmNzID0gJnI2MDBfZnVuY3M7Cj4gICAJCXJkZXYt
PmF1ZGlvLmhkbWlfZnVuY3MgPSAmcjYwMF9oZG1pX2Z1bmNzOwo+IC0JCXJkZXYtPmF1ZGlvLmRw
X2Z1bmNzID0gMDsKPiArCQlyZGV2LT5hdWRpby5kcF9mdW5jcyA9IE5VTEw7Cj4gICAJfQo+ICAg
fQo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpk
cmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
