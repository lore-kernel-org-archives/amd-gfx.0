From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH 1/2] drm/ttm: fix ttm_mem_evict_first once more
Date: Wed, 15 Nov 2017 13:31:50 +0100
Message-ID: <20171115123151.3038-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

VGhlIGNvZGUgcGF0aCBpc24ndCBoaXQgYXQgdGhlIG1vbWVudCwgYnV0IHdlIG5lZWQgdG8gdGFr
ZSB0aGUgbG9jayB0bwphZGQgdGhlIEJPIGJhY2sgdG8gdGhlIExSVS4KClNpZ25lZC1vZmYtYnk6
IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vdHRtL3R0bV9iby5jIHwgNyArKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90
dG0vdHRtX2JvLmMgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jCmluZGV4IDA3ZDljNmU1
YjZjYS4uN2MxZWFjNGY0YjRiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9i
by5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMKQEAgLTc5MywxMCArNzkzLDEz
IEBAIHN0YXRpYyBpbnQgdHRtX21lbV9ldmljdF9maXJzdChzdHJ1Y3QgdHRtX2JvX2RldmljZSAq
YmRldiwKIAlzcGluX3VubG9jaygmZ2xvYi0+bHJ1X2xvY2spOwogCiAJcmV0ID0gdHRtX2JvX2V2
aWN0KGJvLCBpbnRlcnJ1cHRpYmxlLCBub193YWl0X2dwdSk7Ci0JaWYgKGxvY2tlZCkKKwlpZiAo
bG9ja2VkKSB7CiAJCXR0bV9ib191bnJlc2VydmUoYm8pOwotCWVsc2UKKwl9IGVsc2UgeworCQlz
cGluX2xvY2soJmdsb2ItPmxydV9sb2NrKTsKIAkJdHRtX2JvX2FkZF90b19scnUoYm8pOworCQlz
cGluX3VubG9jaygmZ2xvYi0+bHJ1X2xvY2spOworCX0KIAogCWtyZWZfcHV0KCZiby0+bGlzdF9r
cmVmLCB0dG1fYm9fcmVsZWFzZV9saXN0KTsKIAlyZXR1cm4gcmV0OwotLSAKMi4xMS4wCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFp
bGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
