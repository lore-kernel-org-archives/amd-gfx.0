From: zhoucm1 <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: allocate shared fence slot in VA IOCTL
Date: Tue, 12 Jun 2018 10:25:14 +0800
Message-ID: <98b185a3-21a6-6c19-c6fc-3e31c2544179@amd.com>
References: <20180611132353.37947-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180611132353.37947-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

CgpPbiAyMDE45bm0MDbmnIgxMeaXpSAyMToyMywgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBQ
ZXIgVk0gQk9zIHNoYXJlIHRoZSByZXNlcnZhdGlvbiBvYmplY3Qgd2l0aCB0aGUgUEQgYW5kIHNv
IG5lZWQgdG8KPiByZXNlcnZlIGEgc2hhcmVkIGZlbmNlIHNsb3QgZm9yIHRoZSB1cGRhdGUuCj4K
PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+ClJldmlld2VkLWJ5OiBDaHVubWluZyBaaG91IDxkYXZpZDEuemhvdUBhbWQuY29tPgoKPiAt
LS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyB8IDIgKy0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+IGluZGV4IDVmYjE1NmEwMTc3NC4uN2Yy
N2NkYjdhZmUyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9nZW0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+
IEBAIC02MTIsNyArNjEyLDcgQEAgaW50IGFtZGdwdV9nZW1fdmFfaW9jdGwoc3RydWN0IGRybV9k
ZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwKPiAgIAkJCXJldHVybiAtRU5PRU5UOwo+ICAgCQlhYm8g
PSBnZW1fdG9fYW1kZ3B1X2JvKGdvYmopOwo+ICAgCQl0di5ibyA9ICZhYm8tPnRibzsKPiAtCQl0
di5zaGFyZWQgPSBmYWxzZTsKPiArCQl0di5zaGFyZWQgPSAhIShhYm8tPmZsYWdzICYgQU1ER1BV
X0dFTV9DUkVBVEVfVk1fQUxXQVlTX1ZBTElEKTsKPiAgIAkJbGlzdF9hZGQoJnR2LmhlYWQsICZs
aXN0KTsKPiAgIAl9IGVsc2Ugewo+ICAgCQlnb2JqID0gTlVMTDsKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
