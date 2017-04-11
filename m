From: Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>
Subject: Re: [PATCH 8/8] amdgpu: use sync file for shared semaphores (v2.1)
Date: Tue, 11 Apr 2017 13:42:17 +0100
Message-ID: <20170411124217.GC7895@nuc-i3427.alporthouse.com>
References: <20170411032220.21101-1-airlied@gmail.com>
 <20170411032220.21101-9-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170411032220.21101-9-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jason Ekstrand <jason.ekstrand-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gVHVlLCBBcHIgMTEsIDIwMTcgYXQgMDE6MjI6MjBQTSArMTAwMCwgRGF2ZSBBaXJsaWUgd3Jv
dGU6Cj4gK3N0YXRpYyBpbnQgYW1kZ3B1X3NlbV9sb29rdXBfYW5kX3N5bmMoc3RydWN0IGFtZGdw
dV9jc19wYXJzZXIgKnAsCj4gKwkJCQkgICAgICB1aW50MzJfdCBoYW5kbGUpCj4gK3sKPiArCWlu
dCByOwo+ICsJc3RydWN0IGRtYV9mZW5jZSAqb2xkX2ZlbmNlOwo+ICsKPiArCXIgPSBkcm1fc3lu
Y29ial9zd2FwX2ZlbmNlcyhwLT5maWxwLCBoYW5kbGUsIE5VTEwsICZvbGRfZmVuY2UpOwo+ICsJ
aWYgKHIpCj4gKwkJcmV0dXJuIHI7CgpJJ20gYSBiaXQgcHV6emxlZCBvdmVyIHRoaXMgaW50ZXJm
YWNlIGFzIHRoaXMgbWVhbnMgdGhhdCBhbGwKaW4tc2VtYXBob3JlcyBhcmUgbm90IHJldXNhYmxl
LiBUaGF0IHNlZW1zIGEgYml0IG9kZCBhcyBpdCBtZWFucwp1c2Vyc3BhY2UgY2FuJ3QgdXNlIHRo
ZSByZXN1bHRzIGZyb20gb25lIGVuZ2luZSBvbiB0d28rIHBhcmFsbGVsCmVuZ2luZXMuIFNlYXJj
aGluZyBrcm9ub3MgZm9yIFZrU2VtYXBob3JlCmh0dHBzOi8vd3d3Lmtocm9ub3Mub3JnL3JlZ2lz
dHJ5L3Z1bGthbi9zcGVjcy8xLjAvbWFuL2h0bWwvVmtTZW1hcGhvcmUuaHRtbAppc24ndCBlbmxp
Z2h0ZW5pbmcuLi4KLUNocmlzCgotLSAKQ2hyaXMgV2lsc29uLCBJbnRlbCBPcGVuIFNvdXJjZSBU
ZWNobm9sb2d5IENlbnRyZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
