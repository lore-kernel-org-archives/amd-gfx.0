From: Frank.Min <Frank.Min-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/3] amd/amdkfd: add Arcturus vf DID support
Date: Fri, 16 Aug 2019 16:59:19 +0800
Message-ID: <1565945960-21236-2-git-send-email-Frank.Min@amd.com>
References: <1565945960-21236-1-git-send-email-Frank.Min@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1565945960-21236-1-git-send-email-Frank.Min-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Frank.Min" <Frank.Min-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJODQyY2MzMWFiMDQwYjE3ZGNjNTc2NWUyNzVlNTQwMmRmNzg1YjM0YQpTaWdu
ZWQtb2ZmLWJ5OiBGcmFuay5NaW4gPEZyYW5rLk1pbkBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2Rl
dmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jCmluZGV4IDNi
OWZlNjIuLjMyYjFjZmEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMK
QEAgLTQ3Miw2ICs0NzIsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGtmZF9kZXZpY2VpZCBzdXBw
b3J0ZWRfZGV2aWNlc1tdID0gewogCXsgMHg3MzhDLCAmYXJjdHVydXNfZGV2aWNlX2luZm8gfSwJ
LyogQXJjdHVydXMgKi8KIAl7IDB4NzM4OCwgJmFyY3R1cnVzX2RldmljZV9pbmZvIH0sCS8qIEFy
Y3R1cnVzICovCiAJeyAweDczOEUsICZhcmN0dXJ1c19kZXZpY2VfaW5mbyB9LAkvKiBBcmN0dXJ1
cyAqLworCXsgMHg3MzkwLCAmYXJjdHVydXNfZGV2aWNlX2luZm8gfSwJLyogQXJjdHVydXMgdmYg
Ki8KIAl7IDB4NzMxMCwgJm5hdmkxMF9kZXZpY2VfaW5mbyB9LAkvKiBOYXZpMTAgKi8KIAl7IDB4
NzMxMiwgJm5hdmkxMF9kZXZpY2VfaW5mbyB9LAkvKiBOYXZpMTAgKi8KIAl7IDB4NzMxOCwgJm5h
dmkxMF9kZXZpY2VfaW5mbyB9LAkvKiBOYXZpMTAgKi8KLS0gCjIuNy40CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
