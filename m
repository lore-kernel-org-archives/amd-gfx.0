From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 09/19] drm/amdgpu: add additional boco checks to runtime
 suspend/resume
Date: Sat, 12 Oct 2019 13:55:31 +0200
Message-ID: <20191012115531.7bcdwqoltr2ajp3z@wunner.de>
References: <20191011014536.10869-1-alexander.deucher@amd.com>
 <20191011014536.10869-10-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20191011014536.10869-10-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: tiwai-l3A5Bk7waGM@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gVGh1LCBPY3QgMTAsIDIwMTkgYXQgMDg6NDU6MjZQTSAtMDUwMCwgQWxleCBEZXVjaGVyIHdy
b3RlOgo+ICsJaWYgKGFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfYm9jbyhkcm1fZGV2KSkKPiArCQlk
cm1fZGV2LT5zd2l0Y2hfcG93ZXJfc3RhdGUgPSBEUk1fU1dJVENIX1BPV0VSX0NIQU5HSU5HOwo+
ICAKPiArCWlmIChhbWRncHVfZGV2aWNlX3N1cHBvcnRzX2JvY28oZHJtX2RldikpIHsKPiArCQlp
ZiAoYW1kZ3B1X2lzX2F0cHhfaHlicmlkKCkgfHwKPiArCQkgICAgIWFtZGdwdV9oYXNfYXRweF9k
Z3B1X3Bvd2VyX2NudGwoKSkKPiArCQkJcGNpX3NldF9wb3dlcl9zdGF0ZShwZGV2LCBQQ0lfRDAp
Owo+ICsJCXBjaV9yZXN0b3JlX3N0YXRlKHBkZXYpOwo+ICsJCXJldCA9IHBjaV9lbmFibGVfZGV2
aWNlKHBkZXYpOwo+ICsJCWlmIChyZXQpCj4gKwkJCXJldHVybiByZXQ7Cj4gKwkJcGNpX3NldF9t
YXN0ZXIocGRldik7Cj4gKwl9CgpUd28gY29uc2VjdXRpdmUgaWYtY2xhdXNlcyB3aXRoIHNhbWUg
Y29uZGl0aW9uLCBjYW4gYmUgZm9sZGVkIGludG8gb25lLgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZng=
