From: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: "ring gfx timeout" with Vega 64 on mesa 19.0.0-rc2 and kernel
 5.0.0-rc6 (GPU reset still not works)
Date: Tue, 12 Feb 2019 15:23:36 +0000
Message-ID: <47477f0a-76dd-2f33-ff38-01f8216cffcc@amd.com>
References: <CABXGCsOakru4=RMrhpocLhN99LwKp4q1-UfFJrEUh7q4UeKJ_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CABXGCsOakru4=RMrhpocLhN99LwKp4q1-UfFJrEUh7q4UeKJ_g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <0BB4CA7F54F02144B2CDB3EF49928AFF-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Mikhail Gavrilov <mikhail.v.gavrilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

DQpPbiAyLzEyLzE5IDc6MzQgQU0sIE1pa2hhaWwgR2F2cmlsb3Ygd3JvdGU6DQo+IEhpIGZvbGtz
LiBTb3JyeSBmb3Igbm9pc2UuDQo+IEJ1dCBJIHJlYWxseSBkb24ndCBrbm93IElzIGl0IGVub3Vn
aCB0byBzZW5kIG15IGxvZ3Mgb3Igbm90Lg0KPiBBcyBJIGFtIHVuZGVyc3RhbmQgZGlmZmVyZW50
IHNlcXVlbmNlcyBtYXkgY2F1c2UgInJpbmcgZ2Z4IHRpbWVvdXQiLg0KPiBJIGFtIGFsc28gbm90
IGhlYXIgd2hpY2ggdmVyc2lvbiBJIG5lZWQgd2FpdCBvciB3aGljaCBwYXRjaCBJIG5lZWRzDQo+
IGFwcGx5IGJlZm9yZSB0ZXN0aW5nIGFnYWluLg0KPiBCdXQgdG9kYXkgSSBhZ2FpbiByZXByb2R1
Y2VkICJyaW5nIGdmeCB0aW1lb3V0IiBvbiBsYXRlc3Qga2VybmVsIGFuZCBtZXNhLg0KPiBLZXJu
ZWw6IDUuMC4wLTAucmM2DQo+IE1lc2E6IDE5LjAuMC1yYzINCj4gTExWTTogNy4wLjENCj4NCj4g
QWxzbyBJIHNhdyBpbiBrZXJuZWwgbG9nIHRoZSBsaW5lICJhbWRncHUgMDAwMDowYjowMC4wOiBH
UFUgcmVzZXQNCj4gYmVnaW4hIiBidXQgaXQgbm90IGhlbHBzIHByZXZlbnQgY29tcHV0ZXIgZnJv
bSBoYW5naW5nLg0KPg0KPiBJIHdhbnQgdG8gYXNrIGFib3V0IG15IGV4cGVjdGF0aW9ucy4gSXMg
cmlnaHQgdGhhdCBhZnRlciAiR1BVIHJlc2V0DQo+IGJlZ2luISIgR1BVIGZpbmFsbHkgcmVzdW1l
IHdvcms/IE9yIG15IGV4cGVjdGF0aW9ucyBhcmUgdmFpbmx5Pw0KDQoNCkl0IHNob3VsZCByZWNv
dmVyIHlvdSAtIHNvIHRoaXMgbG9va3MgbGlrZSBhIGJ1Zy4gSSBub3RpY2VkIGluIG9uZSBvZiAN
CnRoZSBjYWxsIHRyYWNlcyB0aGlzIC0gZHJtX2F0b21pY19oZWxwZXJfc3VzcGVuZCB3aGljaCBw
b2ludHMgdG8gc3lzdGVtIA0KZ29pbmcgaW50byBzbGVlcCBtb2RlLCBpcyBpdCB3aGF0IGhhcHBl
bmVkLCBkaWQgaXQgaGFuZyB3aGVuIHN5c3RlbSANCnRyaWVkIHRvIHNsZWVwID8NCg0KQW5kcmV5
DQoNCg0KPg0KPiAtLQ0KPiBCZXN0IFJlZ2FyZHMsDQo+IE1pa2UgR2F2cmlsb3YuDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
