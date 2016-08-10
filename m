From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: S3 resume fail
Date: Wed, 10 Aug 2016 12:28:39 +0900
Message-ID: <5873b905-5835-0b33-7814-43d9cb377a29@daenzer.net>
References: <1470798241-30117-1-git-send-email-Jim.Qu@amd.com>
 <efcd0456-211f-25cf-e173-a7a71ff8d2a6@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <efcd0456-211f-25cf-e173-a7a71ff8d2a6-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: jimqu <Jim.Qu-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMTAvMDgvMTYgMTI6MjQgUE0sIE1pY2hlbCBEw6RuemVyIHdyb3RlOgo+IE9uIDEwLzA4LzE2
IDEyOjA0IFBNLCBqaW1xdSB3cm90ZToKPj4gRG9pbmcgUzMgc3RyZXNzIHRlc3QsIHNvbWV0aW1l
cywgZHJpdmVyIGNhbiBub3QgZ2V0IGNvbnNvbGUgbG9jay4gU28gdXNlCj4+IGNvbnNvbGVfdHJ5
bG9jaygpIHRvIGluc3RlYWQgaXQuCj4gCj4gVGhpcyByYWlzZXMgc29tZSBxdWVzdGlvbnM6Cj4g
Cj4gCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPj4gaW5k
ZXggMDg3ZTUyMC4uYmQ1Mzg3ZCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYwo+PiBAQCAtMTg4OSw5ICsxODg5LDYgQEAgaW50IGFtZGdwdV9yZXN1
bWVfa21zKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIGJvb2wgcmVzdW1lLCBib29sIGZiY29uKQo+
PiAgCWlmIChkZXYtPnN3aXRjaF9wb3dlcl9zdGF0ZSA9PSBEUk1fU1dJVENIX1BPV0VSX09GRikK
Pj4gIAkJcmV0dXJuIDA7Cj4+ICAKPj4gLQlpZiAoZmJjb24pIHsKPj4gLQkJY29uc29sZV9sb2Nr
KCk7Cj4+IC0JfQo+IAo+IFdoYXQgZWxzZSBpcyBob2xkaW5nIGNvbnNvbGVfbG9jayBhdCB0aGlz
IHRpbWU/CgpNYXliZSBzb21ldGhpbmcgY2FsbHMgY29uc29sZV9sb2NrIGJ1dCBub3QgY29uc29s
ZV91bmxvY2s/IEUuZy4gSSBzZWUKc29tZSBlcnJvciBjYXNlcyBpbiBhbWRncHVfcmVzdW1lX2tt
cyB3ZXJlIHRoaXMgY291bGQgaGFwcGVuLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIg
ICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNv
ZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRl
dmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
