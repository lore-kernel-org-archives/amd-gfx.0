From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: cleanup useless extern functions
Date: Mon, 19 Dec 2016 17:41:52 +0000
Message-ID: <BN6PR12MB16523202E8D3E3A4B11C9F89F7910@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1482141310-9933-1-git-send-email-ray.huang@amd.com>
 <1482141310-9933-2-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1482141310-9933-2-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>

U2VyaWVzIGlzOgpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IEh1YW5nIFJ1aSBb
bWFpbHRvOnJheS5odWFuZ0BhbWQuY29tXQo+IFNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgMTksIDIw
MTYgNDo1NSBBTQo+IFRvOiBEZXVjaGVyLCBBbGV4YW5kZXI7IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCj4gQ2M6IEh1YW5nLCBSYXkKPiBTdWJqZWN0OiBbUEFUQ0ggMi8yXSBkcm0vYW1k
Z3B1OiBjbGVhbnVwIHVzZWxlc3MgZXh0ZXJuIGZ1bmN0aW9ucwo+IAo+IFNpZ25lZC1vZmYtYnk6
IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3ZpX2RwbS5oIHwgNCAtLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGRlbGV0aW9u
cygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aV9kcG0u
aAo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmlfZHBtLmgKPiBpbmRleCBmYzEyMGJh
Li5jNDNlMDNmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpX2Rw
bS5oCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmlfZHBtLmgKPiBAQCAtMjks
OCArMjksNCBAQCBpbnQgY3pfc211X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwo+
ICBpbnQgY3pfc211X3N0YXJ0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKPiAgaW50IGN6
X3NtdV9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKPiAKPiAtZXh0ZXJuIGNvbnN0
IHN0cnVjdCBhbWRfaXBfZnVuY3MgdG9uZ2FfZHBtX2lwX2Z1bmNzOwo+IC1leHRlcm4gY29uc3Qg
c3RydWN0IGFtZF9pcF9mdW5jcyBmaWppX2RwbV9pcF9mdW5jczsKPiAtZXh0ZXJuIGNvbnN0IHN0
cnVjdCBhbWRfaXBfZnVuY3MgaWNlbGFuZF9kcG1faXBfZnVuY3M7Cj4gLQo+ICAjZW5kaWYKPiAt
LQo+IDIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
