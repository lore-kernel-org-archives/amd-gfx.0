From: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH libdrm 1/4] amdgpu: add bo from user memory to handle table
Date: Wed, 8 Aug 2018 12:08:37 +0800
Message-ID: <1533701320-23661-1-git-send-email-Jerry.Zhang@amd.com>
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
Cc: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org

V2hlbiBjcmVhdGUgYm8gZnJvbSB1c2VyIG1lbW9yeSwgYWRkIGl0IHRvIGhhbmRsZSB0YWJsZQpm
b3IgZnV0dXJlIHF1ZXJ5LgoKU2lnbmVkLW9mZi1ieTogSnVud2VpIFpoYW5nIDxKZXJyeS5aaGFu
Z0BhbWQuY29tPgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgotLS0KIGFtZGdwdS9hbWRncHVfYm8uYyB8IDExICsrKysrKysrKystCiAxIGZp
bGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L2FtZGdwdS9hbWRncHVfYm8uYyBiL2FtZGdwdS9hbWRncHVfYm8uYwppbmRleCA0MjJjN2M5Li5i
MjRlNjk4IDEwMDY0NAotLS0gYS9hbWRncHUvYW1kZ3B1X2JvLmMKKysrIGIvYW1kZ3B1L2FtZGdw
dV9iby5jCkBAIC01NTYsNyArNTU2LDE2IEBAIGludCBhbWRncHVfY3JlYXRlX2JvX2Zyb21fdXNl
cl9tZW0oYW1kZ3B1X2RldmljZV9oYW5kbGUgZGV2LAogCWJvLT5hbGxvY19zaXplID0gc2l6ZTsK
IAliby0+aGFuZGxlID0gYXJncy5oYW5kbGU7CiAKLQkqYnVmX2hhbmRsZSA9IGJvOworCXB0aHJl
YWRfbXV0ZXhfbG9jaygmYm8tPmRldi0+Ym9fdGFibGVfbXV0ZXgpOworCXIgPSBoYW5kbGVfdGFi
bGVfaW5zZXJ0KCZiby0+ZGV2LT5ib19oYW5kbGVzLCBiby0+aGFuZGxlLCBibyk7CisJcHRocmVh
ZF9tdXRleF91bmxvY2soJmJvLT5kZXYtPmJvX3RhYmxlX211dGV4KTsKKworCXB0aHJlYWRfbXV0
ZXhfaW5pdCgmYm8tPmNwdV9hY2Nlc3NfbXV0ZXgsIE5VTEwpOworCisJaWYgKHIpCisJCWFtZGdw
dV9ib19mcmVlKGJvKTsKKwllbHNlCisJCSpidWZfaGFuZGxlID0gYm87CiAKIAlyZXR1cm4gcjsK
IH0KLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
