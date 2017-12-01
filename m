From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH libdrm 0/3] amdgpu: amdgpu_get_marketing_name cleanups
Date: Fri,  1 Dec 2017 17:56:15 +0100
Message-ID: <20171201165618.19629-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpUaGUgZmlyc3Qg
dHdvIHBhdGNoZXMgYXJlIHByZXBhcmF0b3J5IGZvciBwYXRjaCAzLCB3aGljaCBpcyB0aGUgbWVh
dCBvZgp0aGUgc2VyaWVzLgoKTWljaGVsIETDpG56ZXIgKDMpOgogIGFtZGdwdTogQ2xlYW4gdXAg
YW1kZ3B1X3BhcnNlX2FzaWNfaWRzIGVycm9yIGhhbmRsaW5nCiAgYW1kZ3B1OiBTaW1wbGlmeSBl
cnJvciBoYW5kbGluZyBpbiBwYXJzZV9vbmVfbGluZQogIGFtZGdwdTogT25seSByZW1lbWJlciB0
aGUgZGV2aWNlJ3MgbWFya2V0aW5nIG5hbWUKCiBhbWRncHUvQW5kcm9pZC5tayAgICAgICAgfCAg
IDMgKy0KIGFtZGdwdS9NYWtlZmlsZS5hbSAgICAgICB8ICAgNSArLQogYW1kZ3B1L2FtZGdwdV9h
c2ljX2lkLmMgIHwgMTM5ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCiBhbWRncHUvYW1kZ3B1X2RldmljZS5jICAgfCAgMjcgKy0tLS0tLS0tCiBhbWRncHUv
YW1kZ3B1X2ludGVybmFsLmggfCAgMTEgKy0tLQogNSBmaWxlcyBjaGFuZ2VkLCA0OSBpbnNlcnRp
b25zKCspLCAxMzYgZGVsZXRpb25zKC0pCgotLSAKMi4xNS4wCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
