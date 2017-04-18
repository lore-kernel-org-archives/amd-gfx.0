From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 01/12] drm/amdgpu/gfx9: fix typo in mpd init
Date: Tue, 18 Apr 2017 13:00:55 -0400
Message-ID: <54495dbe-9c14-48fe-0f15-a4c0e0560119@gmail.com>
References: <1492466447-27614-1-git-send-email-alexander.deucher@amd.com>
 <1492466447-27614-2-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1492466447-27614-2-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

cy9tcGQvbXFkIGluIHN1YmplY3QKCk9uIDIwMTctMDQtMTcgMDY6MDAgUE0sIEFsZXggRGV1Y2hl
ciB3cm90ZToKPiBVc2luZyB0aGUgd3JvbmcgbWFjcm8gZm9yIHNvYzE1IHJlZ2lzdGVyIGFjY2Vz
cy4KPgo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1k
LmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyB8IDQg
KystLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCj4gaW5kZXggODc1OTZlNC4uNmI5
MTgwNSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5j
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwo+IEBAIC0xOTg5
LDEyICsxOTg5LDEyIEBAIHN0YXRpYyBpbnQgZ2Z4X3Y5XzBfbXFkX2luaXQoc3RydWN0IGFtZGdw
dV9yaW5nICpyaW5nKQo+Cj4gIAkvKiByZXNldCByZWFkIGFuZCB3cml0ZSBwb2ludGVycywgc2lt
aWxhciB0byBDUF9SQjBfV1BUUi9fUlBUUiAqLwo+ICAJcmluZy0+d3B0ciA9IDA7Cj4gLQltcWQt
PmNwX2hxZF9wcV9ycHRyID0gUlJFRzMyKG1tQ1BfSFFEX1BRX1JQVFIpOwo+ICsJbXFkLT5jcF9o
cWRfcHFfcnB0ciA9IFJSRUczMl9TT0MxNShHQywgMCwgbW1DUF9IUURfUFFfUlBUUik7Cj4KPiAg
CS8qIHNldCB0aGUgdm1pZCBmb3IgdGhlIHF1ZXVlICovCj4gIAltcWQtPmNwX2hxZF92bWlkID0g
MDsKPgo+IC0JdG1wID0gUlJFRzMyKG1tQ1BfSFFEX1BFUlNJU1RFTlRfU1RBVEUpOwo+ICsJdG1w
ID0gUlJFRzMyX1NPQzE1KEdDLCAwLCBtbUNQX0hRRF9QRVJTSVNURU5UX1NUQVRFKTsKPiAgCXRt
cCA9IFJFR19TRVRfRklFTEQodG1wLCBDUF9IUURfUEVSU0lTVEVOVF9TVEFURSwgUFJFTE9BRF9T
SVpFLCAweDUzKTsKPiAgCW1xZC0+Y3BfaHFkX3BlcnNpc3RlbnRfc3RhdGUgPSB0bXA7Cj4KPgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
