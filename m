From: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: fix no interrupt issue for renoir emu (v2)
Date: Fri, 30 Aug 2019 13:01:18 +0000
Message-ID: <MN2PR12MB33090DC74864105A24DD7932ECBD0@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <1567143195-22090-1-git-send-email-aaron.liu@amd.com>
 <1567143195-22090-2-git-send-email-aaron.liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1567143195-22090-2-git-send-email-aaron.liu-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Liu,
 Aaron" <Aaron.Liu-5C7GfCeVMHo@public.gmane.org>

UGF0Y2hlcyBhcmUgQWNrZWQtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+DQoNClBs
ZWFzZSB1c2UgImdpdCBzZW5kLWVtYWlsIiBvbiBhbWQtZ2Z4IHB1YmxpYyBjb2RlIHJldmlldy4N
Cg0KVGhhbmtzLA0KUmF5DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBYXJv
biBMaXUgPGFhcm9uLmxpdUBhbWQuY29tPiANClNlbnQ6IEZyaWRheSwgQXVndXN0IDMwLCAyMDE5
IDE6MzMgQU0NClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IERldWNoZXIs
IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEh1YW5nLCBSYXkgPFJheS5I
dWFuZ0BhbWQuY29tPjsgTGl1LCBBYXJvbiA8QWFyb24uTGl1QGFtZC5jb20+OyBEZXVjaGVyLCBB
bGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0ggMi8y
XSBkcm0vYW1kZ3B1OiBmaXggbm8gaW50ZXJydXB0IGlzc3VlIGZvciByZW5vaXIgZW11ICh2MikN
Cg0KDQpJbiByZW5vaXIncyB2ZWdhMTBfaWggbW9kZWwsIHRoZXJlJ3MgYSBzZWN1cml0eSBjaGFu
Z2UgaW4gbW1JSF9DSElDS0VOIHJlZ2lzdGVyLCB0aGF0IGxpbWl0cyBJSCB0byB1c2UgcGh5c2lj
YWwgYWRkcmVzcyAoRkJQQSwgR1BBKSBkaXJlY3RseS4NClRob3NlIGNoaWNrZW4gYml0cyBuZWVk
IHRvIGJlIHByb2dyYW1tZWQgZmlyc3QuDQoNClNpZ25lZC1vZmYtYnk6IEFhcm9uIExpdSA8YWFy
b24ubGl1QGFtZC5jb20+DQpSZXZpZXdlZC1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNv
bT4NClJldmlld2VkLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQpB
Y2tlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KU2lnbmVk
LW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KLS0tDQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMgfCAxOCArKysrKysrKysrLS0t
LS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkN
Cg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
