From: Samuel Pitoiset <samuel.pitoiset-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/2] drm/ttm, amdgpu: fix use-after-free in recent
 deadlock fix
Date: Tue, 14 Feb 2017 12:11:18 +0100
Message-ID: <43fa34bf-a9ca-790f-ff7f-029bda69f5a0@gmail.com>
References: <20170214091845.1225-1-nhaehnle@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170214091845.1225-1-nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

CgpPbiAwMi8xNC8yMDE3IDEwOjE4IEFNLCBOaWNvbGFpIEjDpGhubGUgd3JvdGU6Cj4gSGkgYWxs
LAo+Cj4gYmFzZWQgb24gbXkgY3VycmVudCB0aGVvcnkgb24gaG93IGEgZGVhZGxvY2sgY291bGQg
aGFwcGVuIGluIHRoZQo+IGJ1ZmZlciBhbGxvY2F0aW9uIGNvZGUsIHRoZXNlIHR3byBwYXRjaGVz
IHNob3VsZCBmaXggdGhlIGRlYWRsb2NrCj4gd2l0aG91dCBoYXZpbmcgYSB1c2UtYWZ0ZXItZnJl
ZS4KPgo+IEknbSBzdGlsbCB3b3JraW5nIG9uIGEgd2F5IHRvIGNsZWFuIHVwIHRoZSB0dG1fYm9f
aW5pdCBzZXF1ZW5jZQo+IG92ZXJhbGwsIGJ1dCBJJ20gc2VwYXJhdGluZyB0aGVzZSB0d28gb3V0
IGZvciBhIGhvcGVmdWxseSBxdWljayBmaXgsCj4gc2luY2UgaW4gbXkgYm9vayB1c2UtYWZ0ZXIt
ZnJlZXMgYXJlIHdvcnNlIHRoYW4gZGVhZGxvY2tzLgo+Cj4gU2FtdWVsLCBJJ2QgdmVyeSBtdWNo
IGFwcHJlY2lhdGUgaWYgeW91IGNvdWxkIGNoZWNrIHRoYXQgdGhlCj4gZGVhZGxvY2tzIGluIEhp
dG1hbiByZW1haW4gZml4ZWQgd2l0aCB0aGVzZSB0d28gcGF0Y2hlcy4KCkxvb2tzIGdvb2QuIFRo
YW5rcyEKCj4KPiBUaGFua3MsCj4gTmljb2xhaQo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
