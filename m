From: "Cui, Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] dri2: reply to client for WaitMSC request in any case
Date: Wed, 29 May 2019 06:36:39 +0000
Message-ID: <1559111780-32513-1-git-send-email-flora.cui@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "Daenzer, Michel" <Michel.Daenzer-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Cui, Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>

b3RoZXJ3aXNlIGNsaWVudCB3b3VsZCB3YWl0IGZvciByZXBseSBmb3JldmVyIGFuZCBkZXNrdG9w
IGFwcGVhcnMgaGFuZy4NCg0KU2lnbmVkLW9mZi1ieTogRmxvcmEgQ3VpIDxmbG9yYS5jdWlAYW1k
LmNvbT4NCi0tLQ0KIHNyYy9hbWRncHVfZHJpMi5jIHwgMyArKysNCiAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9zcmMvYW1kZ3B1X2RyaTIuYyBiL3NyYy9h
bWRncHVfZHJpMi5jDQppbmRleCA0NDMxNmFjLi4zNDM1M2E3IDEwMDY0NA0KLS0tIGEvc3JjL2Ft
ZGdwdV9kcmkyLmMNCisrKyBiL3NyYy9hbWRncHVfZHJpMi5jDQpAQCAtMTA2Miw2ICsxMDYyLDkg
QEAgc3RhdGljIGludCBhbWRncHVfZHJpMl9zY2hlZHVsZV93YWl0X21zYyhDbGllbnRQdHIgY2xp
ZW50LCBEcmF3YWJsZVB0ciBkcmF3LA0KIG91dF9jb21wbGV0ZToNCiAJaWYgKHdhaXRfaW5mbykN
CiAJCWFtZGdwdV9kcmkyX2RlZmVycmVkX2V2ZW50KE5VTEwsIDAsIHdhaXRfaW5mbyk7DQorDQor
CURSSTJXYWl0TVNDQ29tcGxldGUoY2xpZW50LCBkcmF3LCB0YXJnZXRfbXNjLCAwLCAwKTsNCisN
CiAJcmV0dXJuIFRSVUU7DQogfQ0KIA0KLS0gDQoyLjcuNA0KDQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZng=
