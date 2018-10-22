From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Reverse the sequence of ctx_mgr_fini and
 vm_fini in amdgpu_driver_postclose_kms
Date: Mon, 22 Oct 2018 12:10:03 +0200
Message-ID: <e62ef78d-b042-5cae-ef92-85ac57b53d10@gmail.com>
References: <1540201634-4291-1-git-send-email-Rex.Zhu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1540201634-4291-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Emily.Deng-5C7GfCeVMHo@public.gmane.org

QW0gMjIuMTAuMTggdW0gMTE6NDcgc2NocmllYiBSZXggWmh1Ogo+IGNzYSBidWZmZXIgd2lsbCBi
ZSBjcmVhdGVkIHBlciBjdHgsIHdoZW4gY3R4IGZpbmksCj4gdGhlIGNzYSBidWZmZXIgYW5kIHZh
IHdpbGwgYmUgcmVsZWFzZWQuIHNvIG5lZWQgdG8KPiBkbyBjdHhfbWdyIGZpbiBiZWZvcmUgdm0g
ZmluaS4KPgo+IFNpZ25lZC1vZmYtYnk6IFJleCBaaHUgPFJleC5aaHVAYW1kLmNvbT4KClJldmll
d2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CgoKPiAt
LS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyB8IDIgKy0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYwo+IGluZGV4IDI3ZGU4NDguLmYyZWY5YTEg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jCj4gQEAgLTEwNTQs
OCArMTA1NCw4IEBAIHZvaWQgYW1kZ3B1X2RyaXZlcl9wb3N0Y2xvc2Vfa21zKHN0cnVjdCBkcm1f
ZGV2aWNlICpkZXYsCj4gICAJcGFzaWQgPSBmcHJpdi0+dm0ucGFzaWQ7Cj4gICAJcGQgPSBhbWRn
cHVfYm9fcmVmKGZwcml2LT52bS5yb290LmJhc2UuYm8pOwo+ICAgCj4gLQlhbWRncHVfdm1fZmlu
aShhZGV2LCAmZnByaXYtPnZtKTsKPiAgIAlhbWRncHVfY3R4X21ncl9maW5pKCZmcHJpdi0+Y3R4
X21ncik7Cj4gKwlhbWRncHVfdm1fZmluaShhZGV2LCAmZnByaXYtPnZtKTsKPiAgIAo+ICAgCWlm
IChwYXNpZCkKPiAgIAkJYW1kZ3B1X3Bhc2lkX2ZyZWVfZGVsYXllZChwZC0+dGJvLnJlc3YsIHBh
c2lkKTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
