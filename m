From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Bail out of BO node creation if not
 enough VRAM (v2)
Date: Wed, 12 Jun 2019 10:03:14 +0200
Message-ID: <80760492-7d0a-25a2-1410-3a72e2a64ce9@gmail.com>
References: <20190611165444.17841-1-tom.stdenis@amd.com>
 <fd4c5152-2670-8ac5-e6cc-fff6f260f3ed@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <fd4c5152-2670-8ac5-e6cc-fff6f260f3ed-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMTIuMDYuMTkgdW0gMDk6MjYgc2NocmllYiBNaWNoZWwgRMOkbnplcjoKPiBPbiAyMDE5LTA2
LTExIDY6NTQgcC5tLiwgU3REZW5pcywgVG9tIHdyb3RlOgo+PiAodjIpOiBSZXR1cm4gMCBhbmQg
c2V0IG1lbS0+bW1fbm9kZSB0byBOVUxMLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBUb20gU3QgRGVu
aXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92cmFtX21nci5jIHwgMTggKysrKysrKysrKysrKy0tLS0tCj4+ICAgMSBm
aWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4+Cj4+IFsuLi5d
Cj4+ICAgCj4+IEBAIC0yODQsNiArMjg0LDE0IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZyYW1fbWdy
X25ldyhzdHJ1Y3QgdHRtX21lbV90eXBlX21hbmFnZXIgKm1hbiwKPj4gICAJaWYgKCFscGZuKQo+
PiAgIAkJbHBmbiA9IG1hbi0+c2l6ZTsKPj4gICAKPj4gKwkvKiBiYWlsIG91dCBxdWlja2x5IGlm
IHRoZXJlJ3MgbGlrZWx5IG5vdCBlbm91Z2ggVlJBTSBmb3IgdGhpcyBCTyAqLwo+PiArCWF0b21p
YzY0X2FkZChtZW0tPm51bV9wYWdlcyA8PCBQQUdFX1NISUZULCAmbWdyLT51c2FnZSk7Cj4+ICsJ
aWYgKGF0b21pYzY0X3JlYWQoJm1nci0+dXNhZ2UpID4gYWRldi0+Z21jLm1jX3ZyYW1fc2l6ZSkg
ewo+IFNob3VsZCBwcm9iYWJseSB1c2UgYXRvbWljNjRfYWRkX3JldHVybiBpbnN0ZWFkIG9mIGF0
b21pYzY0X2FkZCArCj4gYXRvbWljNjRfcmVhZC4KPgo+IEFsc28sIEFGQUlDVCB0aGlzIGRvZXNu
J3QgYWxsb3cgYW55IFZSQU0gb3ZlcmNvbW1pdCwgd2hpY2ggc2VlbXMgYSBiaXQKPiBjb25zZXJ2
YXRpdmU/CgpUaGlzIGlzIHRoZSBsb3cgbGV2ZWwgVlJBTSBtYW5hZ2VyLiBIZXJlIHdlIGNhbid0
IG92ZXJjb21pdCBhbnl3YXkgYW5kIApuZWVkIHRvIHJldHVybiBlYXJseSBmb3IgVFRNIHRvIGV2
aWN0IHRoaW5ncy4KCkNocmlzdGlhbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
