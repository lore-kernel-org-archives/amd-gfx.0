From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 03/10] drm/amdgpu: handle runtime pm in fbcon
Date: Thu, 1 Sep 2016 10:04:21 +0900
Message-ID: <c2ff0619-5d11-c443-a1b4-b57530dc89f6@daenzer.net>
References: <1472681336-30106-1-git-send-email-alexander.deucher@amd.com>
 <1472681336-30106-3-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1472681336-30106-3-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDEvMDkvMTYgMDc6MDggQU0sIEFsZXggRGV1Y2hlciB3cm90ZToKPiBQb3J0ZWQgZnJvbSBu
b3V2ZWF1Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4KClsuLi5dCgo+ICtzdGF0aWMgaW50Cj4gK2FtZGdwdWZiX29wZW4oc3RydWN0
IGZiX2luZm8gKmluZm8sIGludCB1c2VyKQo+ICt7Cj4gKwlzdHJ1Y3QgYW1kZ3B1X2ZiZGV2ICpy
ZmJkZXYgPSBpbmZvLT5wYXI7Cj4gKwlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IHJmYmRl
di0+YWRldjsKPiArCWludCByZXQgPSBwbV9ydW50aW1lX2dldF9zeW5jKGFkZXYtPmRkZXYtPmRl
dik7Cj4gKwlpZiAocmV0IDwgMCAmJiByZXQgIT0gLUVBQ0NFUykKPiArCQlyZXR1cm4gcmV0Owo+
ICsJcmV0dXJuIDA7Cj4gK30KPiArCj4gK3N0YXRpYyBpbnQKPiArYW1kZ3B1ZmJfcmVsZWFzZShz
dHJ1Y3QgZmJfaW5mbyAqaW5mbywgaW50IHVzZXIpCj4gK3sKPiArCXN0cnVjdCBhbWRncHVfZmJk
ZXYgKnJmYmRldiA9IGluZm8tPnBhcjsKPiArCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0g
cmZiZGV2LT5hZGV2Owo+ICsKPiArCXBtX3J1bnRpbWVfbWFya19sYXN0X2J1c3koYWRldi0+ZGRl
di0+ZGV2KTsKPiArCXBtX3J1bnRpbWVfcHV0X2F1dG9zdXNwZW5kKGFkZXYtPmRkZXYtPmRldik7
Cj4gKwlyZXR1cm4gMDsKPiArfQoKSWYgcG1fcnVudGltZV9nZXRfc3luYyByZXR1cm5zIC1FQUND
RVMsIHdvbid0IHRoZXJlIGJlIGFuIGltYmFsYW5jZSB3aXRoCnRoZSBwbV9ydW50aW1lX3B1dF9h
dXRvc3VzcGVuZCBjYWxsLCB3aGljaCBtaWdodCByZXN1bHQgaW4gdGhlIEdQVQpwb3dlcmluZyBv
ZmYgZXZlbiB3aGVuIHRoZXJlJ3Mgc29tZXRoaW5nIGVsc2Ugd2hpY2ggaXMgc3VwcG9zZWQgdG8g
a2VlcAppdCBvbj8KClNhbWUgZm9yIHBhdGNoIDguCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOk
bnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGli
cmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5k
IFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
