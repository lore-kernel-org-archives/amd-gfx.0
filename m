From: <sunpeng.li@amd.com>
Subject: [PATCH 0/6] Use new DRM API where possible, and cleanups.
Date: Thu, 12 Oct 2017 17:15:05 -0400
Message-ID: <1507842911-16975-1-git-send-email-sunpeng.li@amd.com>
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
To: airlied@gmail.com, amd-gfx@lists.freedesktop.org
Cc: "Leo (Sunpeng) Li" <sunpeng.li@amd.com>, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogIkxlbyAoU3VucGVuZykgTGkiIDxzdW5wZW5nLmxpQGFtZC5jb20+CgpIaSBEYXZlLAoK
VGhpcyBzZXJpZXMgcmV3b3JrcyB0aGUgcHJldmlvdXMgcGF0Y2guIFBhdGNoIDEgaXMgYSB2MiBv
ZiB0aGUgcHJldmlvdXMsCmFuZCBhZGRpdGlvbmFsIHBhdGNoZXMgYXJlIGZyb20gdGhlIGZlZWRi
YWNrIHJlY2VpdmVkLiBUaGV5IGFwcGx5IG9uIHRvcApvZiB5b3VyIGRybS1uZXh0LWFtZC1kYy1z
dGFnaW5nIGJyYW5jaC4KClRoYW5rcywKTGVvCgpMZW8gKFN1bnBlbmcpIExpICg2KToKICBkcm0v
YW1kL2Rpc3BsYXk6IFVzZSBEUk0gbmV3LXN0eWxlIG9iamVjdCBpdGVyYXRvcnMuCiAgZHJtL2Ft
ZC9kaXNwbGF5OiBVc2UgbmV3IERSTSBBUEkgd2hlcmUgcG9zc2libGUKICBkcm0vYW1kL2Rpc3Bs
YXk6IFVuaWZ5IERSTSBzdGF0ZSB2YXJpYWJsZSBuYW1pbmdzLgogIGRybS9hbWQvZGlzcGxheTog
VW5pZnkgYW1kZ3B1X2RtIHN0YXRlIHZhcmlhYmxlIG5hbWluZ3MuCiAgZHJtL2FtZC9kaXNwbGF5
OiBGaXggdHlwbwogIGRybS9hbWQvZGlzcGxheTogUmVtb3ZlIHVzZWxlc3MgcGNydGMgcG9pbnRl
cgoKIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAz
MjAgKysrKysrKysrKystLS0tLS0tLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Ft
ZGdwdV9kbS9hbWRncHVfZG0uaCB8ICAgMyArLQogMiBmaWxlcyBjaGFuZ2VkLCAxNTYgaW5zZXJ0
aW9ucygrKSwgMTY3IGRlbGV0aW9ucygtKQoKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
