From: Xiaojie Yuan <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH libdrm] amdgpu: enlarge the maximum number of cards supported
Date: Thu, 19 Apr 2018 21:50:49 +0800
Message-ID: <20180419135049.31988-1-Xiaojie.Yuan@amd.com>
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
Cc: Xiaojie Yuan <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

MTI4IGlzIHRoZSBtYXhpbXVtIG51bWJlciBvZiBjYXJkcyB0aGF0IHRoZSBrZXJuZWwgY2FuIHN1
cHBvcnQKYXQgdGhlIG1vbWVudC4KCkNoYW5nZS1JZDogSTE1NWI3YjIxNjM1MzA2ZDhlY2M0NDBi
ODVmYjg5NTQ1MDFhYjU1OTkKU2lnbmVkLW9mZi1ieTogWGlhb2ppZSBZdWFuIDxYaWFvamllLll1
YW5AYW1kLmNvbT4KLS0tCiB0ZXN0cy9hbWRncHUvYW1kZ3B1X3Rlc3QuaCB8IDIgKy0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3Rl
c3RzL2FtZGdwdS9hbWRncHVfdGVzdC5oIGIvdGVzdHMvYW1kZ3B1L2FtZGdwdV90ZXN0LmgKaW5k
ZXggNjI4NzU3MzYuLmYyZWNlM2MzIDEwMDY0NAotLS0gYS90ZXN0cy9hbWRncHUvYW1kZ3B1X3Rl
c3QuaAorKysgYi90ZXN0cy9hbWRncHUvYW1kZ3B1X3Rlc3QuaApAQCAtMzAsNyArMzAsNyBAQAog
LyoqCiAgKiBEZWZpbmUgbWF4LiBudW1iZXIgb2YgY2FyZCBpbiBzeXN0ZW0gd2hpY2ggd2UgYXJl
IGFibGUgdG8gaGFuZGxlCiAgKi8KLSNkZWZpbmUgTUFYX0NBUkRTX1NVUFBPUlRFRCAgICAgNAor
I2RlZmluZSBNQVhfQ0FSRFNfU1VQUE9SVEVEICAgICAxMjgKIAogLyogRm9yd2FyZCByZWZlcmVu
Y2UgZm9yIGFycmF5IHRvIGtlZXAgImRybSIgaGFuZGxlcyAqLwogZXh0ZXJuIGludCBkcm1fYW1k
Z3B1W01BWF9DQVJEU19TVVBQT1JURURdOwotLSAKMi4xNy4wCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
