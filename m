From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Remove dead static variable
Date: Tue, 20 Nov 2018 11:47:04 +0000
Message-ID: <e95068f8-c87b-b380-132e-64a508b2b289@amd.com>
References: <1542625660-29454-1-git-send-email-Rex.Zhu@amd.com>
 <30a11ff7-0cc1-970c-6f48-4a955a2883aa@gmail.com>
 <CACvgo51knZSiwkHoaJK=jcHTz8A34fR0E3UJMduX+_xk20RHNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CACvgo51knZSiwkHoaJK=jcHTz8A34fR0E3UJMduX+_xk20RHNA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <1EC1BCA9FBBA14498E6489303CF24E82-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMjAuMTEuMTggdW0gMTE6NDggc2NocmllYiBFbWlsIFZlbGlrb3Y6DQo+IE9uIE1vbiwgMTkg
Tm92IDIwMTggYXQgMTE6MTksIENocmlzdGlhbiBLw7ZuaWcNCj4gPGNrb2VuaWcubGVpY2h0enVt
ZXJrZW5AZ21haWwuY29tPiB3cm90ZToNCj4+IEFtIDE5LjExLjE4IHVtIDEyOjA3IHNjaHJpZWIg
UmV4IFpodToNCj4+PiBUaGUgc3RhdGljIHN0cnVjdCBkcm1fZHJpdmVyICpkcml2ZXIgd2FzDQo+
Pj4gbm90IHVzZWQgYmVjYXVzZSBkcm1fcGNpX2luaXQgd2FzIGRlcHJlY2F0ZWQNCj4+Pg0KPj4+
IFNpZ25lZC1vZmYtYnk6IFJleCBaaHUgPFJleC5aaHVAYW1kLmNvbT4NCj4+IFJldmlld2VkLWJ5
OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+Pg0KPj4gQ2Fu
IHlvdSBvZiBoYW5kIHNlZSB3aGF0ICJwZHJpdmVyIiBpcyB1c2VkIGZvcj8gVGhhdCBsb29rcyBz
dXNwaWNpb3VzDQo+PiBsaWtlIHNvbWV0aGluZyBkZXByZWNhdGVkIGFzIHdlbGwuDQo+Pg0KPiBT
ZWVtaW5nIGNvcHkvcGFzdGUgZnJvbSB0aGUgcmFkZW9uIGRyaXZlci4gVGhlIGxhdHRlciB1c2Vk
IHRvIHN1cHBvcnQNCj4gVU1TIGFuZCBLTVMgYXQgc29tZSBwb2ludCBpbiB0aGUgcGFzdC4NCg0K
WWVhaCwgdGhvdWdodCBzby4gUmV4IGNhbSB1cCB3aXRoIGEgVjIgd2hlcmUgYm90aCB2YXJpYWJs
ZXMgYXJlIHJlbW92ZWQuDQoNClRoYW5rcywNCkNocmlzdGlhbi4NCg0KPg0KPiBIVEgNCj4gLUVt
aWwNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
