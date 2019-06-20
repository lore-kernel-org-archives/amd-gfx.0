From: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: update df_v3_6 for xgmi perfmons
Date: Thu, 20 Jun 2019 15:23:59 +0000
Message-ID: <594a3303-a5bd-72b7-8e03-fe1b2b08a723@amd.com>
References: <20190620005313.56371-1-jonathan.kim@amd.com>
 <CADnq5_O81Mmf=4N+EL8P6ARrbhAo8wXRVKZB78N5Dj7e6+upLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_O81Mmf=4N+EL8P6ARrbhAo8wXRVKZB78N5Dj7e6+upLw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <8C087165EC789943ACB69EFD53A9AF7F-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Kim, Jonathan" <Jonathan.Kim-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOS0wNi0yMCA5OjQ5LCBBbGV4IERldWNoZXIgd3JvdGU6DQo+IFlvdSBuZXZlciBhZGRy
ZXNzZWQgbXkgY29tbWVudHMgYWJvdXQgZGYgaW5pdCBmcm9tIGJlZm9yZS4gIGRmX2luaXQNCj4g
Z2V0cyBjYWxsZWQgZnJvbSBod19pbml0LCBzbyB5b3Ugc2hvdWxkbid0IGNyZWF0ZSBmaWxlcy4g
IE1vdmUgZGYgaW5pdA0KPiB0byBiZWluZyBjYWxsZWQgZnJvbSBzb2MxNSBzd19pbml0L2Zpbmkg
YW5kIHByb2JhYmx5IHJlbmFtZSB0aGUgZGYNCj4gY2FsbGJhY2tzIHRvIHN3X2luaXQgYW5kIHN3
X2Zpbmkgc28gd2Uga25vdyBub3QgdG8gYWRkIGh3IHN0YXRlIHRvDQo+IHRob3NlIGZ1bmN0aW9u
cy4gIEFzIGlzIG5vdywgd2UnbGwgZW5kIHVwIG5lZWRsZXNzbHkgY3JlYXRpbmcgYW5kDQo+IGRl
c3RvcnlpbmcgZmlsZXMgb24gc3VzcGVuZC9yZXN1bWUuDQoNClNvcnJ5IEkgYWxzbyBtaXNzZWQg
dGhhdCBjb21tZW50IGFuZCB0aGUgaW1wbGljYXRpb25zLCBvciBJIHdvdWxkIGhhdmUgDQpwb2lu
dGVkIGl0IG91dCBpbiBteSBjb2RlIHJldmlldy4NCg0KSm9uJ3MgbGFzdCBwYXRjaCBsb29rcyBt
b3N0bHkgZ29vZCB0byBtZSBhbmQgSSB0aGluayBpdCBhZGRyZXNzZXMgdGhpcyANCndpdGggbWlu
aW1hbCBmdXNzLg0KDQpSZWdhcmRzLA0KIMKgIEZlbGl4DQoNCj4NCj4gQWxleA0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
