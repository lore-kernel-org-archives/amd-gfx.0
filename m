From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] drm/amdgpu: Make amdgpu_vram_mgr_bo_invisible_size
 always accurate
Date: Mon, 18 Jun 2018 13:30:37 +0200
Message-ID: <91723ad0-f220-86b9-6fe6-0a11668dd250@gmail.com>
References: <20180615144230.18480-1-michel@daenzer.net>
 <20180615144230.18480-4-michel@daenzer.net>
 <093bbd7a-02cd-068f-a53a-2d4f1c5b3084@gmail.com>
 <098df480-3db3-485f-8e39-4ebf8201b3a0@daenzer.net>
 <b94d92e5-908d-534a-907a-ad97124b22ec@amd.com>
 <3140ef24-f8c9-5863-ff44-4c83192eabb1@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <3140ef24-f8c9-5863-ff44-4c83192eabb1-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTUuMDYuMjAxOCB1bSAxNzoxOSBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MDYtMTUgMDU6MTggUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDE1LjA2LjIwMTgg
dW0gMTc6MTQgc2NocmllYiBNaWNoZWwgRMOkbnplcjoKPj4+IE9uIDIwMTgtMDYtMTUgMDU6MTEg
UE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Pj4gQW0gMTUuMDYuMjAxOCB1bSAxNjo0MiBz
Y2hyaWViIE1pY2hlbCBEw6RuemVyOgo+Pj4+PiArCj4+Pj4+ICvCoMKgwqAgaWYgKG1lbS0+c3Rh
cnQgPj0gYWRldi0+Z21jLnZpc2libGVfdnJhbV9zaXplID4+IFBBR0VfU0hJRlQpCj4+Pj4+ICDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gYW1kZ3B1X2JvX3NpemUoYm8pOwo+Pj4+PiAgwqDC
oCAtwqDCoMKgIHJldHVybiAwOwo+Pj4+PiArwqDCoMKgIGlmICghbm9kZXMpCj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+Pj4gKwo+Pj4+PiArwqDCoMKgIHNwaW5fbG9jaygmbWdy
LT5sb2NrKTsKPj4+PiBJIGFjdHVhbGx5IGRvbid0IHNlZSBhbnkgbmVlZCB0byBncmFiIHRoZSBs
b2NrIGhlcmUuCj4+PiBBaCwgc28gYW1kZ3B1X3ZyYW1fbWdyX2RlbCBvbmx5IGdyYWJzIGl0IGZv
ciBkcm1fbW1fcmVtb3ZlX25vZGU/Cj4+IFllcywgZXhhY3RseS4KPiBXaWxsIGRyb3AgaXQgaW4g
djIsIHRoYW5rcyEKCkhhdmVuJ3Qgc2VlZW4gdjIgeWV0LCBidXQgd2l0aCB0aGF0IGxvY2sgcmVt
b3ZlZCB0aGUgd2hvbGUgc2VyaWVzIGlzIApSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPi4KClJlZ2FyZHMsCkNocmlzdGlhbi4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
