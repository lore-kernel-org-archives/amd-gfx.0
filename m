From: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 5/5] drm/amdgpu/display/dce11: only enable FBC when
 selected
Date: Tue, 6 Nov 2018 20:52:27 +0000
Message-ID: <3a06f40c-6313-f190-8c47-41d5898e9125@amd.com>
References: <20181106202910.1117-1-alexander.deucher@amd.com>
 <20181106202910.1117-5-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181106202910.1117-5-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <6B1647C90C870A4BB27D8A085BCFE026-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOC0xMS0wNiAzOjI5IHAubS4sIEFsZXggRGV1Y2hlciB3cm90ZToNCj4gQ2F1c2VzIGEg
YmxhY2sgc2NyZWVuIG9uIGEgU3RvbmV5IGxhcHRvcC4NCj4gDQo+IGJ1ZzogaHR0cHM6Ly9idWdz
LmZyZWVkZXNrdG9wLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTA4NTc3DQo+IFNpZ25lZC1vZmYtYnk6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCg0KVGhhbmtzLg0KDQpT
ZXJpZXMgaXMNClJldmlld2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1k
LmNvbT4NCg0KSGFycnkNCg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kY2UxMTAvZGNlMTEwX3Jlc291cmNlLmMgfCAzICsrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX3Jlc291cmNlLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9yZXNvdXJjZS5jDQo+IGluZGV4
IDFhOTBlMWEzODA1NS4uZTMzZDExNzg1YjFmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9yZXNvdXJjZS5jDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX3Jlc291cmNlLmMNCj4gQEAg
LTEzNTQsNyArMTM1NCw4IEBAIHN0YXRpYyBib29sIGNvbnN0cnVjdCgNCj4gIAkJcG9vbC0+YmFz
ZS5zd19pMmNzW2ldID0gTlVMTDsNCj4gIAl9DQo+ICANCj4gLQlkYy0+ZmJjX2NvbXByZXNzb3Ig
PSBkY2UxMTBfY29tcHJlc3Nvcl9jcmVhdGUoY3R4KTsNCj4gKwlpZiAoZGMtPmNvbmZpZy5mYmNf
c3VwcG9ydCkNCj4gKwkJZGMtPmZiY19jb21wcmVzc29yID0gZGNlMTEwX2NvbXByZXNzb3JfY3Jl
YXRlKGN0eCk7DQo+ICANCj4gIAlpZiAoIXVuZGVybGF5X2NyZWF0ZShjdHgsICZwb29sLT5iYXNl
KSkNCj4gIAkJZ290byByZXNfY3JlYXRlX2ZhaWw7DQo+IA0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
