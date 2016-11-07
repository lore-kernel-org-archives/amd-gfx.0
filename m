From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/4] dma-buf/fence: revert "don't wait when specified timeout
 is zero" (v2)
Date: Mon,  7 Nov 2016 16:16:14 -0500
Message-ID: <1478553376-18575-2-git-send-email-alexander.deucher@amd.com>
References: <1478553376-18575-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1478553376-18575-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, sumit.semwal-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

VGhpcyByZXZlcnRzIGNvbW1pdCA4NDdiMTlhMzllNGM5YjVlNzRjNDBmMDg0MmM0OGI0MTY2NGNi
NDNjLgoKV2hlbiB3ZSBkb24ndCBjYWxsIHRoZSB3YWl0IGZ1bmN0aW9uIHNvZnR3YXJlIHNpZ25h
bGluZyBtaWdodCBuZXZlciBiZQphY3RpdmF0ZWQuIFRoaXMgY2FuIGNhdXNlIGluZmluaXRlIHBv
bGxpbmcgbG9vcHMgd2l0aCB1bnJlbGlhYmxlIGludGVycnVwdApkcml2ZW4gaGFyZHdhcmUuCgp2
MjogcmViYXNlIG9uIGRybS1uZXh0CgpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+ClJldmlld2VkLWJ5OiBDaHVubWluZyBaaG91IDxkYXZpZDEu
emhvdUBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9kbWEtYnVmL2RtYS1mZW5jZS5jIHwgMyAtLS0KIDEg
ZmlsZSBjaGFuZ2VkLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hLWJ1
Zi9kbWEtZmVuY2UuYyBiL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtZmVuY2UuYwppbmRleCA2YzNmNmI0
Li5kZDAwOTkwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2RtYS1idWYvZG1hLWZlbmNlLmMKKysrIGIv
ZHJpdmVycy9kbWEtYnVmL2RtYS1mZW5jZS5jCkBAIC0xNjEsOSArMTYxLDYgQEAgZG1hX2ZlbmNl
X3dhaXRfdGltZW91dChzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZSwgYm9vbCBpbnRyLCBzaWduZWQg
bG9uZyB0aW1lb3V0KQogCWlmIChXQVJOX09OKHRpbWVvdXQgPCAwKSkKIAkJcmV0dXJuIC1FSU5W
QUw7CiAKLQlpZiAodGltZW91dCA9PSAwKQotCQlyZXR1cm4gZG1hX2ZlbmNlX2lzX3NpZ25hbGVk
KGZlbmNlKTsKLQogCXRyYWNlX2RtYV9mZW5jZV93YWl0X3N0YXJ0KGZlbmNlKTsKIAlyZXQgPSBm
ZW5jZS0+b3BzLT53YWl0KGZlbmNlLCBpbnRyLCB0aW1lb3V0KTsKIAl0cmFjZV9kbWFfZmVuY2Vf
d2FpdF9lbmQoZmVuY2UpOwotLSAKMi41LjUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
