From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 15/21] drm/amdkfd: Fix kernel queue rollback_packet
Date: Tue, 10 Apr 2018 17:33:12 -0400
Message-ID: <1523395998-31314-16-git-send-email-Felix.Kuehling@amd.com>
References: <1523395998-31314-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1523395998-31314-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>

a3EtPnF1ZXVlLT5wcm9wZXJ0aWVzLndyaXRlX3B0ciBpcyBhIEdQVSBhZGRyZXNzIHdoaWNoIGNh
bidkIGJlCmRlcmVmZW5jZWQgaW4gdGhlIGtlcm5lbC4gVXNlIGtxLT53cHRyX2tlcm5lbCBpbnN0
ZWFkLCB3aGljaCBpcyB0aGUKa2VybmVsIENQVSBhZGRyZXNzIG9mIHRoZSBzYW1lIGJ1ZmZlci4K
ClNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJuZWxfcXVldWUuYyB8IDIgKy0K
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJuZWxfcXVldWUuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJuZWxfcXVldWUuYwppbmRleCAyM2U1ODZiLi45
ZjM4MTYxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfa2VybmVs
X3F1ZXVlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2tlcm5lbF9xdWV1
ZS5jCkBAIC0yNzksNyArMjc5LDcgQEAgc3RhdGljIHZvaWQgc3VibWl0X3BhY2tldChzdHJ1Y3Qg
a2VybmVsX3F1ZXVlICprcSkKIAogc3RhdGljIHZvaWQgcm9sbGJhY2tfcGFja2V0KHN0cnVjdCBr
ZXJuZWxfcXVldWUgKmtxKQogewotCWtxLT5wZW5kaW5nX3dwdHIgPSAqa3EtPnF1ZXVlLT5wcm9w
ZXJ0aWVzLndyaXRlX3B0cjsKKwlrcS0+cGVuZGluZ193cHRyID0gKmtxLT53cHRyX2tlcm5lbDsK
IH0KIAogc3RydWN0IGtlcm5lbF9xdWV1ZSAqa2VybmVsX3F1ZXVlX2luaXQoc3RydWN0IGtmZF9k
ZXYgKmRldiwKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
