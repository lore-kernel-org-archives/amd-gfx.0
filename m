From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [drm:generic_reg_wait [amdgpu]] *ERROR* REG_WAIT timeout 1us * 10
 tries - optc1_lock line:628
Date: Tue, 1 Jan 2019 14:48:41 -0500
Message-ID: <CADnq5_OryEByan7G7kiMboiB8gxv=fkfftKXPWH=jYfSZdn5pQ@mail.gmail.com>
References: <63aa12e8-2dee-11c6-88c1-784b5d03da26@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <63aa12e8-2dee-11c6-88c1-784b5d03da26-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org>
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
To: Paul Menzel <pmenzel+amd-gfx-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVHVlLCBKYW4gMSwgMjAxOSBhdCA5OjM4IEFNIFBhdWwgTWVuemVsCjxwbWVuemVsK2FtZC1n
ZnhAbW9sZ2VuLm1wZy5kZT4gd3JvdGU6Cj4KPiBEZWFyIExpbnV4IGZvbGtzLAo+Cj4KPiBMaW51
eCA0LjE5LjEzIHN0aWxsIGlzc3VlcyBhIHdhcm5pbmcgb24gYSBSeXplbiBzeXN0ZW0uIE90aGVy
IGhhdmUgdGhlCj4gc2FtZSBwcm9ibGVtIFsxXS4KPgo+IERvIHlvdSBoYXZlIGEgc3lzdGVtLCB3
aGVyZSB5b3UgY2FuIHlvdSByZXByb2R1Y2UgdGhlIGlzc3VlPwo+Cj4gRG8geW91IGhhdmUgYW4g
aWRlYSwgd2hhdCBpcyBnb2luZyBvbiB0aGVyZSwgYW5kIGhvdyB0aGF0IGNhbiBiZSBmaXhlZD8K
CkRlcGVuZGluZyBvbiB5b3VyIGNvbmZpZ3VyYXRpb24sIHRoaXMgcGF0Y2ggbWF5IGhlbHA6Cmh0
dHBzOi8vY2dpdC5mcmVlZGVza3RvcC5vcmcvZHJtL2RybS9jb21taXQvP2lkPThjOWQ5MGVlYmQy
M2I2ZDQwZGRmNGNlNWRmNWNhMmI5MzIzMzZhMDYKCkFsZXgKCj4KPgo+IEtpbmQgcmVnYXJkcywK
Pgo+IFBhdWwKPgo+Cj4gWzFdOiBodHRwczovL2J1Z3MuZnJlZWRlc2t0b3Aub3JnL3Nob3dfYnVn
LmNnaT9pZD0xMDcyNjEKPiAgICAgICAiQnVnIDEwNzI2MSAtIFtkcm06Z2VuZXJpY19yZWdfd2Fp
dCBbYW1kZ3B1XV0gKkVSUk9SKiBSRUdfV0FJVAo+IHRpbWVvdXQgMXVzICogMTAgdHJpZXMgLSBv
cHRjMV9sb2NrIGxpbmU6NjI4Igo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
