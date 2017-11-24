From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: don't try to move pinned BOs
Date: Fri, 24 Nov 2017 16:08:36 +0100
Message-ID: <bc923291-994a-30c9-a09b-e04da7fd9928@daenzer.net>
References: <20171124104610.20179-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171124104610.20179-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxNy0xMS0yNCAxMTo0NiBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBOZXZlciB0
cnkgdG8gbW92ZSBwaW5uZWQgQk9zIGR1cmluZyBDUy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jIHwgNCArKysrCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2NzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3Mu
Ywo+IGluZGV4IGRiYWU3NDExZTc1NC4uZDE1ODM2YjQ4MjZhIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKPiBAQCAtNDE0LDYgKzQxNCwxMCBAQCBzdGF0aWMgYm9v
bCBhbWRncHVfY3NfdHJ5X2V2aWN0KHN0cnVjdCBhbWRncHVfY3NfcGFyc2VyICpwLAo+ICAJCWlm
IChjYW5kaWRhdGUtPnJvYmogPT0gdmFsaWRhdGVkKQo+ICAJCQlicmVhazsKPiAgCj4gKwkJLyog
V2UgY2FuJ3QgbW92ZSBwaW5uZWQgQk9zIGhlcmUgKi8KPiArCQlpZiAoYm8tPnBpbl9jb3VudCkK
PiArCQkJY29udGludWU7Cj4gKwo+ICAJCW90aGVyID0gYW1kZ3B1X21lbV90eXBlX3RvX2RvbWFp
bihiby0+dGJvLm1lbS5tZW1fdHlwZSk7Cj4gIAo+ICAJCS8qIENoZWNrIGlmIHRoaXMgQk8gaXMg
aW4gb25lIG9mIHRoZSBkb21haW5zIHdlIG5lZWQgc3BhY2UgZm9yICovCj4gCgpSZXZpZXdlZC1i
eTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgoKLS0gCkVhcnRobGlu
ZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3
LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAg
ICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
