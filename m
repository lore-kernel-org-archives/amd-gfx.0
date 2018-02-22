From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/2] drm/amd: remove inclusion of non-existing scheduler
 directory
Date: Thu, 22 Feb 2018 08:21:48 +0000
Message-ID: <1519287709-28638-1-git-send-email-clabbe@baylibre.com>
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
To: David1.Zhou@amd.com, airlied@linux.ie, alexander.deucher@amd.com, christian.koenig@amd.com, david1.zhou@amd.com, Dieter@nuetzel-hh.de, l.stach@pengutronix.de
Cc: Corentin Labbe <clabbe@baylibre.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

VGhlIHNjaGVkdWxlciBkaXJlY3Rvcnkgd2FzIHJlbW92ZWQgdmlhIGNvbW1pdCAxYjFmNDJkOGZk
ZTQgKCJkcm06IG1vdmUgYW1kX2dwdV9zY2hlZHVsZXIgaW50byBjb21tb24gbG9jYXRpb24iKQpS
ZW1vdmUgaXQgZnJvbSBpbmNsdWRlIHBhdGguCgpTaWduZWQtb2ZmLWJ5OiBDb3JlbnRpbiBMYWJi
ZSA8Y2xhYmJlQGJheWxpYnJlLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9N
YWtlZmlsZSB8IDEgLQogMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9NYWtlZmlsZSBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L01ha2VmaWxlCmluZGV4IGQ2ZTViNzI3Mzg1My4uODQwOGFlZWFmNmMxIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9NYWtlZmlsZQorKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9NYWtlZmlsZQpAQCAtMzAsNyArMzAsNiBAQCBGVUxMX0FNRF9E
SVNQTEFZX1BBVEggPSAkKEZVTExfQU1EX1BBVEgpLyQoRElTUExBWV9GT0xERVJfTkFNRSkKIGNj
ZmxhZ3MteSA6PSAtSSQoRlVMTF9BTURfUEFUSCkvaW5jbHVkZS9hc2ljX3JlZyBcCiAJLUkkKEZV
TExfQU1EX1BBVEgpL2luY2x1ZGUgXAogCS1JJChGVUxMX0FNRF9QQVRIKS9hbWRncHUgXAotCS1J
JChGVUxMX0FNRF9QQVRIKS9zY2hlZHVsZXIgXAogCS1JJChGVUxMX0FNRF9QQVRIKS9wb3dlcnBs
YXkvaW5jIFwKIAktSSQoRlVMTF9BTURfUEFUSCkvYWNwL2luY2x1ZGUgXAogCS1JJChGVUxMX0FN
RF9ESVNQTEFZX1BBVEgpIFwKLS0gCjIuMTYuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vZHJpLWRldmVsCg==
