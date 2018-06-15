From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 3/4] drm/amdgpu: Make amdgpu_vram_mgr_bo_invisible_size
 always accurate
Date: Fri, 15 Jun 2018 17:19:17 +0200
Message-ID: <3140ef24-f8c9-5863-ff44-4c83192eabb1@daenzer.net>
References: <20180615144230.18480-1-michel@daenzer.net>
 <20180615144230.18480-4-michel@daenzer.net>
 <093bbd7a-02cd-068f-a53a-2d4f1c5b3084@gmail.com>
 <098df480-3db3-485f-8e39-4ebf8201b3a0@daenzer.net>
 <b94d92e5-908d-534a-907a-ad97124b22ec@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b94d92e5-908d-534a-907a-ad97124b22ec-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wNi0xNSAwNToxOCBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAxNS4w
Ni4yMDE4IHVtIDE3OjE0IHNjaHJpZWIgTWljaGVsIETDpG56ZXI6Cj4+IE9uIDIwMTgtMDYtMTUg
MDU6MTEgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBBbSAxNS4wNi4yMDE4IHVtIDE2
OjQyIHNjaHJpZWIgTWljaGVsIETDpG56ZXI6Cj4gCj4+Pj4gKwo+Pj4+ICvCoMKgwqAgaWYgKG1l
bS0+c3RhcnQgPj0gYWRldi0+Z21jLnZpc2libGVfdnJhbV9zaXplID4+IFBBR0VfU0hJRlQpCj4+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGFtZGdwdV9ib19zaXplKGJvKTsKPj4+PiDC
oMKgIC3CoMKgwqAgcmV0dXJuIDA7Cj4+Pj4gK8KgwqDCoCBpZiAoIW5vZGVzKQo+Pj4+ICvCoMKg
wqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+PiArCj4+Pj4gK8KgwqDCoCBzcGluX2xvY2soJm1nci0+
bG9jayk7Cj4+PiBJIGFjdHVhbGx5IGRvbid0IHNlZSBhbnkgbmVlZCB0byBncmFiIHRoZSBsb2Nr
IGhlcmUuCj4+IEFoLCBzbyBhbWRncHVfdnJhbV9tZ3JfZGVsIG9ubHkgZ3JhYnMgaXQgZm9yIGRy
bV9tbV9yZW1vdmVfbm9kZT8KPiAKPiBZZXMsIGV4YWN0bHkuCgpXaWxsIGRyb3AgaXQgaW4gdjIs
IHRoYW5rcyEKCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAg
ICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0
ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
