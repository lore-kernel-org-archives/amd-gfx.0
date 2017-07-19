From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] android: amdgpu: fix build break
Date: Wed, 19 Jul 2017 19:13:44 +0100
Message-ID: <CACvgo51MKs6BaBR8oOXf1RfqJprarfk43TOuN0p+OhdkURRVQw@mail.gmail.com>
References: <1500459483-5795-1-git-send-email-cwhuang@linux.org.tw>
 <1500459483-5795-2-git-send-email-cwhuang@linux.org.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1500459483-5795-2-git-send-email-cwhuang-Xh+NVF5n0LIoRNOVWjJ6hg@public.gmane.org>
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
To: Chih-Wei Huang <cwhuang-/Cx9OjMEmUl75Oa3hH2JBw@public.gmane.org>
Cc: Chih-Wei Huang <cwhuang-Xh+NVF5n0LIoRNOVWjJ6hg@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, ML dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMTkgSnVseSAyMDE3IGF0IDExOjE4LCBDaGloLVdlaSBIdWFuZyA8Y3dodWFuZ0BhbmRyb2lk
LXg4Ni5vcmc+IHdyb3RlOgo+IERlZmluZSB0d28gbWFjcm9zIHRvIGF2b2lkIGJ1aWxkaW5nIGVy
cm9ycy4KPgo+IEZpeGVzOiA3ZTZiZjg4Y2FjIChhbWRncHU6IG1vdmUgYXNpYyBpZCB0YWJsZSB0
byBhIHNlcGFyYXRlIGZpbGUpCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaGloLVdlaSBIdWFuZyA8Y3do
dWFuZ0BsaW51eC5vcmcudHc+Cj4gLS0tCj4gIGFtZGdwdS9BbmRyb2lkLm1rIHwgNiArKysrKysK
PiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2FtZGdw
dS9BbmRyb2lkLm1rIGIvYW1kZ3B1L0FuZHJvaWQubWsKPiBpbmRleCBiZjA2MTFiLi45NTViZDUz
IDEwMDY0NAo+IC0tLSBhL2FtZGdwdS9BbmRyb2lkLm1rCj4gKysrIGIvYW1kZ3B1L0FuZHJvaWQu
bWsKPiBAQCAtMTAsNSArMTAsMTEgQEAgTE9DQUxfU0hBUkVEX0xJQlJBUklFUyA6PSBsaWJkcm0K
Pgo+ICBMT0NBTF9TUkNfRklMRVMgOj0gJChMSUJEUk1fQU1ER1BVX0ZJTEVTKQo+Cj4gK0xPQ0FM
X0NGTEFHUyA6PSBcCj4gKyAgICAgICAtREFNREdQVV9BU0lDX0lEX1RBQkxFPVwiL2V0Yy9od2Rh
dGEvYW1kZ3B1Lmlkc1wiIFwKWW91IHdhbnQgdG8gdXNlIHRoZSBzYW1lIHBhdGggaW4gYm90aCBw
bGFjZXMgbGlrZSB3ZSBkbyBpbiBhdXRvbWFrZSAtCnNlZSBsaWJkcm1kYXRhZGlyLgpPbmUgc2lt
cGx5IGRvZXMgbm90IG5lZWQgdG8gYm90aGVyL3RyYWNrIGlmIFRBUkdFVF9PVVRfRVRDIGV4cGFu
ZHMgdG8KL2V0Yy8gb3IgYXMgbWVudGlvbmVkIGluIFsxXSAvc3lzdGVtL2V0Yy8KCi1FbWlsClsx
XSBodHRwczovL3NvdXJjZS5jb2RlYXVyb3JhLm9yZy9leHRlcm5hbC9naWdhYnl0ZS9hZy1nYi1k
c2RzLTcyMjcvcGxhaW4vZnJhbWV3b3Jrcy9iYXNlL2RhdGEvZXRjL0FuZHJvaWQubWsKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
