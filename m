From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: don't fail amdgpu_device_initialize if
 amdgpu.ids missing or unparseable
Date: Mon, 9 Oct 2017 12:16:02 +0200
Message-ID: <84b22712-f237-5944-bbe1-5e3c3c8e111a@daenzer.net>
References: <1507540262-31020-1-git-send-email-Xiaojie.Yuan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1507540262-31020-1-git-send-email-Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
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
To: Xiaojie Yuan <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDkvMTAvMTcgMTE6MTEgQU0sIFhpYW9qaWUgWXVhbiB3cm90ZToKPiBTaWduZWQtb2ZmLWJ5
OiBYaWFvamllIFl1YW4gPFhpYW9qaWUuWXVhbkBhbWQuY29tPgo+IC0tLQo+ICBhbWRncHUvYW1k
Z3B1X2RldmljZS5jIHwgNiArKy0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
YyBiL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBpbmRleCAyYjMxYzQ1Li43MmRjNmZhIDEwMDY0
NAo+IC0tLSBhL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiArKysgYi9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jCj4gQEAgLTI4NiwxMCArMjg2LDggQEAgaW50IGFtZGdwdV9kZXZpY2VfaW5pdGlhbGl6
ZShpbnQgZmQsCj4gIAlhbWRncHVfdmFtZ3JfaW5pdCgmZGV2LT52YW1ncl8zMiwgc3RhcnQsIG1h
eCwKPiAgCQkJICBkZXYtPmRldl9pbmZvLnZpcnR1YWxfYWRkcmVzc19hbGlnbm1lbnQpOwo+ICAK
PiAtCXIgPSBhbWRncHVfcGFyc2VfYXNpY19pZHMoJmRldi0+YXNpY19pZHMpOwo+IC0JaWYgKHIp
IHsKPiAtCQlmcHJpbnRmKHN0ZGVyciwgIiVzOiBDYW5ub3QgcGFyc2UgQVNJQyBJRHMsIDB4JXgu
IiwKPiAtCQkJX19mdW5jX18sIHIpOwo+ICsJaWYgKGFtZGdwdV9wYXJzZV9hc2ljX2lkcygmZGV2
LT5hc2ljX2lkcykgPCAwKSB7Cj4gKwkJZnByaW50ZihzdGRlcnIsICIlczogQ2Fubm90IHBhcnNl
IEFTSUMgSURzIiwgX19mdW5jX18pOwo+ICAJfQo+ICAKPiAgCSptYWpvcl92ZXJzaW9uID0gZGV2
LT5tYWpvcl92ZXJzaW9uOwo+IAoKUmV2aWV3ZWQtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwu
ZGFlbnplckBhbWQuY29tPgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAg
ICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVu
dGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3Blcgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
