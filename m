From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 12/12] drm/amdgpu/gfx9: Switch baremetal to use KIQ for
 compute ring management. (v3)
Date: Tue, 18 Apr 2017 13:05:31 -0400
Message-ID: <490e0865-d384-4122-efc1-bf0805168feb@amd.com>
References: <1492466447-27614-1-git-send-email-alexander.deucher@amd.com>
 <1492466447-27614-13-git-send-email-alexander.deucher@amd.com>
 <03bf2c7b-c622-3200-4562-3b5740ea8538@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <03bf2c7b-c622-3200-4562-3b5740ea8538-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMTgvMDQvMTcgMDE6MDAgUE0sIEFuZHJlcyBSb2RyaWd1ZXogd3JvdGU6Cgo+PiArc3RhdGlj
IGludCBnZnhfdjlfMF9raXFfa2NxX2Rpc2FibGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
Cj4+ICt7Cj4+ICsgICAgc3RydWN0IGFtZGdwdV9yaW5nICpraXFfcmluZyA9ICZhZGV2LT5nZngu
a2lxLnJpbmc7Cj4+ICsgICAgdWludDMyX3Qgc2NyYXRjaCwgdG1wID0gMDsKPj4gKyAgICBpbnQg
ciwgaTsKPj4gKwo+PiArICAgIHIgPSBhbWRncHVfZ2Z4X3NjcmF0Y2hfZ2V0KGFkZXYsICZzY3Jh
dGNoKTsKPj4gKyAgICBpZiAocikgewo+PiArICAgICAgICBEUk1fRVJST1IoIkZhaWxlZCB0byBn
ZXQgc2NyYXRjaCByZWcgKCVkKS5cbiIsIHIpOwo+PiArICAgICAgICByZXR1cm4gcjsKPj4gKyAg
ICB9Cj4+ICsgICAgV1JFRzMyKHNjcmF0Y2gsIDB4Q0FGRURFQUQpOwo+IAo+IFdSRUczMl9TT0Mx
NSBuZWVkZWQgaGVyZSBJIHRoaW5rCgpJbiB0aGUgZnVuY3Rpb24gZ2Z4X3Y5XzBfc2NyYXRjaF9p
bml0KCkgdGhlIG9mZnNldCBpcyBpbml0aWFsaXplZCB3aXRoIApHQy8wIHVzaW5nIGEgU09DMTUg
bWFjcm8uICBBZnRlciB0aGF0IHlvdSBjYW4gdXNlIG5vcm1hbCBXUkVHMzIvUlJFRzMyIApvbiBp
dC4KClRvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
