From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] amdkfd: always select MMU_NOTIFIER
Date: Wed, 28 Mar 2018 17:53:32 +0200
Message-ID: <20180328155340.2253343-1-arnd@arndb.de>
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
To: Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

QnVpbGRpbmcgYW1ka2ZkIHdpdGhvdXQgTU1VIG5vdGlmaWVycyBpcyBicm9rZW46CgpJbiBmaWxl
IGluY2x1ZGVkIGZyb20gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2Vy
X3ZpLmM6Mjg6CmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2Lmg6NTg0OjIyOiBl
cnJvcjogZmllbGQgJ21tdV9ub3RpZmllcicgaGFzIGluY29tcGxldGUgdHlwZQoKVGhpcyBhZGRz
IHRoZSBtaXNzaW5nICdzZWxlY3QgTU1VX05PVElGSUVSJyBsaW5lIHRvIG1ha2UgaXQgYnVpbGQK
Y2xlYW5seSBhbGwgdGhlIHRpbWUuCgpTaWduZWQtb2ZmLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5k
QGFybmRiLmRlPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL0tjb25maWcgfCAxICsK
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL0tjb25maWcgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9LY29u
ZmlnCmluZGV4IGVkMmYwNmM5ZjM0Ni4uNWEyNmFjYjkwZTE5IDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9LY29uZmlnCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL0tjb25maWcKQEAgLTQsNiArNCw3IEBACiAKIGNvbmZpZyBIU0FfQU1ECiAJdHJpc3RhdGUg
IkhTQSBrZXJuZWwgZHJpdmVyIGZvciBBTUQgR1BVIGRldmljZXMiCisJc2VsZWN0IE1NVV9OT1RJ
RklFUgogCWRlcGVuZHMgb24gRFJNX0FNREdQVSAmJiBYODZfNjQKIAlpbXBseSBBTURfSU9NTVVf
VjIKIAloZWxwCi0tIAoyLjkuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
ZHJpLWRldmVsCg==
