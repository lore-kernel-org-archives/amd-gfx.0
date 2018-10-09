From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 4/5] drm/amdgpu: Fix unnecessary warning in dmesg
Date: Tue, 9 Oct 2018 15:18:31 +0200
Message-ID: <15af5a1b-ea73-c779-5f30-e6da0192d504@daenzer.net>
References: <1539089023-2360-1-git-send-email-Rex.Zhu@amd.com>
 <1539089023-2360-4-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1539089023-2360-4-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0xMC0wOSAyOjQzIHAubS4sIFJleCBaaHUgd3JvdGU6Cj4gRml4IHRoZSB3YXJuaW5n
IG1lc3NhZ2U6Cj4gIi0xIGlzIG5vdCBzdXBwb3J0ZWQgb24gVkkiCj4gdGhlIC0xIGlzIHRoZSBk
ZWZhdWx0IGZ3IGxvYWQgdHlwZSwgbWVhbiBhdXRvLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFJleCBa
aHUgPFJleC5aaHVAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Vjb2RlLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdWNvZGUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91Y29k
ZS5jCj4gaW5kZXggZjI2MDRhYy4uZTViMTNiMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdWNvZGUuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV91Y29kZS5jCj4gQEAgLTI5Nyw3ICsyOTcsNyBAQCBlbnVtIGFtZGdwdV9m
aXJtd2FyZV9sb2FkX3R5cGUKPiAgCWNhc2UgQ0hJUF9QT0xBUklTMTE6Cj4gIAljYXNlIENISVBf
UE9MQVJJUzEyOgo+ICAJY2FzZSBDSElQX1ZFR0FNOgo+IC0JCWlmIChsb2FkX3R5cGUgIT0gQU1E
R1BVX0ZXX0xPQURfU01VKQo+ICsJCWlmIChsb2FkX3R5cGUgIT0gQU1ER1BVX0ZXX0xPQURfRElS
RUNUIHx8IGxvYWRfdHlwZSA9PSBBTURHUFVfRldfTE9BRF9QU1ApCgpBTURHUFVfRldfTE9BRF9Q
U1AgPT0gMiAhPSBBTURHUFVfRldfTE9BRF9ESVJFQ1QgPT0gMAoKSSBzdXNwZWN0IHlvdSBtZWFu
dCBzb21ldGhpbmcgZWxzZSBoZXJlLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAg
ICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3
YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVs
b3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
