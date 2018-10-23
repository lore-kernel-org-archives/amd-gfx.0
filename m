From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 5/8] drm/amdgpu: fix using shared fence for exported BOs v2
Date: Tue, 23 Oct 2018 15:40:34 +0200
Message-ID: <2e7b6d39-24d9-3c30-dd1a-c1f40255bc81@daenzer.net>
References: <20181004131250.2373-1-christian.koenig@amd.com>
 <20181004131250.2373-5-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181004131250.2373-5-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0xMC0wNCAzOjEyIHAubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gSXQgaXMg
cGVyZmVjdGx5IHBvc3NpYmxlIHRoYXQgdGhlIEJPIGxpc3QgaXMgY3JlYXRlZCBiZWZvcmUgdGhl
IEJPIGlzCj4gZXhwb3J0ZWQuIFdoaWxlIGF0IGl0IGNsZWFudXAgc2V0dGluZyBzaGFyZWQgdG8g
b25lIGluc3RlYWQgb2YgdHJ1ZS4KCiJjbGVhbiB1cCIKCgo+IHYyOiBhZGQgY29tbWVudCBhbmQg
c2ltcGxpZnkgbG9naWMKPiAKPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+CgpBcyB0aGlzIGlzIGEgYnVnIGZpeCwgc2hvdWxkIGl0IGJl
IGJlZm9yZSBwYXRjaCA1IGFuZCBoYXZlIENjOiBzdGFibGU/CkVpdGhlciB3YXksIHdpdGggdGhl
IGFib3ZlIGZpeGVkLAoKUmV2aWV3ZWQtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnpl
ckBhbWQuY29tPgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8
ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lh
c3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
