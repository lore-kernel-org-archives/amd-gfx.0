From: Chih-Wei Huang <cwhuang@android-x86.org>
Subject: [PATCH 2/2] android: amdgpu: fix build break
Date: Wed, 19 Jul 2017 18:18:03 +0800
Message-ID: <1500459483-5795-2-git-send-email-cwhuang@linux.org.tw>
References: <1500459483-5795-1-git-send-email-cwhuang@linux.org.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1500459483-5795-1-git-send-email-cwhuang@linux.org.tw>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: Chih-Wei Huang <cwhuang@linux.org.tw>
List-Id: amd-gfx.lists.freedesktop.org

RGVmaW5lIHR3byBtYWNyb3MgdG8gYXZvaWQgYnVpbGRpbmcgZXJyb3JzLgoKRml4ZXM6IDdlNmJm
ODhjYWMgKGFtZGdwdTogbW92ZSBhc2ljIGlkIHRhYmxlIHRvIGEgc2VwYXJhdGUgZmlsZSkKClNp
Z25lZC1vZmYtYnk6IENoaWgtV2VpIEh1YW5nIDxjd2h1YW5nQGxpbnV4Lm9yZy50dz4KLS0tCiBh
bWRncHUvQW5kcm9pZC5tayB8IDYgKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvYW1kZ3B1L0FuZHJvaWQubWsgYi9hbWRncHUvQW5kcm9pZC5tawpp
bmRleCBiZjA2MTFiLi45NTViZDUzIDEwMDY0NAotLS0gYS9hbWRncHUvQW5kcm9pZC5taworKysg
Yi9hbWRncHUvQW5kcm9pZC5tawpAQCAtMTAsNSArMTAsMTEgQEAgTE9DQUxfU0hBUkVEX0xJQlJB
UklFUyA6PSBsaWJkcm0KIAogTE9DQUxfU1JDX0ZJTEVTIDo9ICQoTElCRFJNX0FNREdQVV9GSUxF
UykKIAorTE9DQUxfQ0ZMQUdTIDo9IFwKKwktREFNREdQVV9BU0lDX0lEX1RBQkxFPVwiL2V0Yy9o
d2RhdGEvYW1kZ3B1Lmlkc1wiIFwKKwktREFNREdQVV9BU0lDX0lEX1RBQkxFX05VTV9FTlRSSUVT
PSQoc2hlbGwgZWdyZXAgLWNpICdeWzAtOWEtZl17NH0sLipbMC05YS1mXSssJyAkKExJQkRSTV9U
T1ApL2RhdGEvYW1kZ3B1LmlkcykKKworTE9DQUxfUkVRVUlSRURfTU9EVUxFUyA6PSBhbWRncHUu
aWRzCisKIGluY2x1ZGUgJChMSUJEUk1fQ09NTU9OX01LKQogaW5jbHVkZSAkKEJVSUxEX1NIQVJF
RF9MSUJSQVJZKQotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2RyaS1kZXZlbAo=
