From: Roger He <Hongbo.He@amd.com>
Subject: [PATCH 0/4] *** fix memory leak for HUGE PAGE  ***
Date: Tue, 21 Nov 2017 17:32:18 +0800
Message-ID: <1511256742-5601-1-git-send-email-Hongbo.He@amd.com>
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
Cc: Roger He <Hongbo.He@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

MS4gYWRkIHBhZ2Ugb3JkZXIgaW50byBwb29sIHRvIHN1cHBvcnQgZ3R0IGh1Z2UgcGFnZQoyLiBh
ZGQgcGFnZSBvcmRlciBzdXBwb3J0IHdoZW4gdHRtIHBhZ2VzIHB1dAozLiB1cGRhdGUgbWVtb3J5
IHNocmlua2VyIHdpdGggb3JkZXIgaGFuZGxpbmcKCgpSb2dlciBIZSAoNCk6CiAgZHJtL3R0bTog
YWRkIHBhZ2Ugb3JkZXIgaW4gcGFnZSBwb29sCiAgZHJtL3R0bTogdXNlIE5VTV9QQUdFU19UT19B
TExPQyBhbHdheXMKICBkcm0vdHRtOiBhZGQgcGFnZSBvcmRlciBzdXBwb3J0IGluIHR0bV9wYWdl
c19wdXQKICBkcm0vdHRtOiBmcmVlIG9uZSBpbiBodWdlIHBvb2wgZXZlbiBzaHJpbmsgcmVxdWVz
dCBsZXNzIHRoYW4gb25lCiAgICBlbGVtZW50CgogZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFn
ZV9hbGxvYy5jIHwgODAgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tCiAxIGZp
bGUgY2hhbmdlZCwgNTkgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pCgotLSAKMi43LjQK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZl
bCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
