From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 025/103] drm/amd/display: add hubp/dpp pg debug key
Date: Tue, 10 Oct 2017 18:39:54 -0400
Message-ID: <20171010224112.3023-26-harry.wentland@amd.com>
References: <20171010224112.3023-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171010224112.3023-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Charlene Liu <charlene.liu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQ2hhcmxlbmUgTGl1IDxjaGFybGVuZS5saXVAYW1kLmNvbT4KClNpZ25lZC1vZmYtYnk6
IENoYXJsZW5lIExpdSA8Y2hhcmxlbmUubGl1QGFtZC5jb20+ClJldmlld2VkLWJ5OiBBbnRob255
IEtvbyA8QW50aG9ueS5Lb29AYW1kLmNvbT4KQWNrZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxIYXJy
eS5XZW50bGFuZEBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9k
Yy5oIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5oIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RjLmgKaW5kZXggNTA0NDA3MzFmODNjLi4yZTc3ODg1ZmMxZWEgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5oCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5oCkBAIC0xOTEsNiArMTkxLDggQEAgc3RydWN0IGRj
X2RlYnVnIHsKIAlib29sIGRpc2FibGVfZG1jdTsKIAlib29sIGRpc2FibGVfcHNyOwogCWJvb2wg
Zm9yY2VfYWJtX2VuYWJsZTsKKwlib29sIGRpc2FibGVfaGJ1cF9wZzsKKwlib29sIGRpc2FibGVf
ZHBwX3BnOwogfTsKIHN0cnVjdCBkY19zdGF0ZTsKIHN0cnVjdCByZXNvdXJjZV9wb29sOwotLSAK
Mi4xNC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
