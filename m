From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH libdrm 1/3] amdgpu: Free/uninit vamgr_32 in theoretically
 correct order
Date: Sat, 28 Jan 2017 21:49:30 +0200
Message-ID: <1485632972-4790-2-git-send-email-notasas@gmail.com>
References: <1485632972-4790-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1485632972-4790-1-git-send-email-notasas@gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, Alex Xie <AlexBin.Xie@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogQWxleCBYaWUgPEFsZXhCaW4uWGllQGFtZC5jb20+Cgp2YW1ncl8zMiBpcyBhIHJlZ2lv
biBpbnNpZGUgZ2VuZXJhbCBWQU0gcmFuZ2UuIEl0IGlzIGJldHRlciB0byBmcmVlIGFuZApkZWlu
aXRpYWxpemUgaXQgYmVmb3JlIGdlbmVyYWwgVkFNIHJhbmdlLgoKU2lnbmVkLW9mZi1ieTogQWxl
eCBYaWUgPEFsZXhCaW4uWGllQGFtZC5jb20+ClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8
IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYwppbmRleCBmNGVkZTAzLi5jYWQ3MTMzIDEwMDY0NAotLS0gYS9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jCisrKyBiL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTEzMSwxMCArMTMxLDEwIEBA
IHN0YXRpYyBpbnQgYW1kZ3B1X2dldF9hdXRoKGludCBmZCwgaW50ICphdXRoKQogCiBzdGF0aWMg
dm9pZCBhbWRncHVfZGV2aWNlX2ZyZWVfaW50ZXJuYWwoYW1kZ3B1X2RldmljZV9oYW5kbGUgZGV2
KQogewotCWFtZGdwdV92YW1ncl9kZWluaXQoZGV2LT52YW1ncik7Ci0JZnJlZShkZXYtPnZhbWdy
KTsKIAlhbWRncHVfdmFtZ3JfZGVpbml0KGRldi0+dmFtZ3JfMzIpOwogCWZyZWUoZGV2LT52YW1n
cl8zMik7CisJYW1kZ3B1X3ZhbWdyX2RlaW5pdChkZXYtPnZhbWdyKTsKKwlmcmVlKGRldi0+dmFt
Z3IpOwogCXV0aWxfaGFzaF90YWJsZV9kZXN0cm95KGRldi0+Ym9fZmxpbmtfbmFtZXMpOwogCXV0
aWxfaGFzaF90YWJsZV9kZXN0cm95KGRldi0+Ym9faGFuZGxlcyk7CiAJcHRocmVhZF9tdXRleF9k
ZXN0cm95KCZkZXYtPmJvX3RhYmxlX211dGV4KTsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRy
aS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
