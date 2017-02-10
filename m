From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add more cases to DCE11 possible crtc mask
 setup
Date: Fri, 10 Feb 2017 11:04:20 +0100
Message-ID: <3c286d12-2e24-686e-1a1d-eec18bbe4367@vodafone.de>
References: <1486702974-11645-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1486702974-11645-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

QW0gMTAuMDIuMjAxNyB1bSAwNjowMiBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBBZGQgY2FzZXMg
Zm9yIGFzaWNzIHdpdGggMyBhbmQgNSBjcnRjcy4gIEZpeGVzIGFuIGFydGlmaWNpYWwKPiBsaW1p
dGF0aW9uIG9uIGFzaWNzIHdpdGggMyBvciA1IGNydGNzLgo+Cj4gRml4ZXM6Cj4gaHR0cHM6Ly9i
dWdzLmZyZWVkZXNrdG9wLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9OTk3NDQKPgo+IFNpZ25lZC1vZmYt
Ynk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZwoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4uCgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
ZGNlX3YxMV8wLmMgfCA2ICsrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92MTFfMC5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3YxMV8wLmMKPiBpbmRleCAxY2YxZDlk
Li41YjI0ZTg5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92
MTFfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3YxMV8wLmMKPiBA
QCAtMzczNyw5ICszNzM3LDE1IEBAIHN0YXRpYyB2b2lkIGRjZV92MTFfMF9lbmNvZGVyX2FkZChz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAlkZWZhdWx0Ogo+ICAgCQllbmNvZGVyLT5w
b3NzaWJsZV9jcnRjcyA9IDB4MzsKPiAgIAkJYnJlYWs7Cj4gKwljYXNlIDM6Cj4gKwkJZW5jb2Rl
ci0+cG9zc2libGVfY3J0Y3MgPSAweDc7Cj4gKwkJYnJlYWs7Cj4gICAJY2FzZSA0Ogo+ICAgCQll
bmNvZGVyLT5wb3NzaWJsZV9jcnRjcyA9IDB4ZjsKPiAgIAkJYnJlYWs7Cj4gKwljYXNlIDU6Cj4g
KwkJZW5jb2Rlci0+cG9zc2libGVfY3J0Y3MgPSAweDFmOwo+ICsJCWJyZWFrOwo+ICAgCWNhc2Ug
NjoKPiAgIAkJZW5jb2Rlci0+cG9zc2libGVfY3J0Y3MgPSAweDNmOwo+ICAgCQlicmVhazsKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
