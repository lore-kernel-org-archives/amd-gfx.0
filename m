From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/6] amdgpu build fixes
Date: Wed,  2 Oct 2019 14:01:21 +0200
Message-ID: <20191002120136.1777161-1-arnd@arndb.de>
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
To: Alex Deucher <alexander.deucher@amd.com>
Cc: clang-built-linux@googlegroups.com, dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

SGVyZSBhcmUgYSBjb3VwbGUgb2YgYnVpbGQgZml4ZXMgZnJvbSBteSBiYWNrbG9nIGluIHRoZSBy
YW5kY29uZmlnCnRyZWUuIEl0IHdvdWxkIGJlIGdvb2QgdG8gZ2V0IHRoZW0gYWxsIGludG8gbGlu
dXgtNS40LgoKICAgICBBcm5kCgpBcm5kIEJlcmdtYW5uICg2KToKICBkcm0vYW1kZ3B1OiBtYWtl
IHBtdSBzdXBwb3J0IG9wdGlvbmFsLCBhZ2FpbgogIGRybS9hbWRncHU6IGhpZGUgYW5vdGhlciAj
d2FybmluZwogIGRybS9hbWRncHU6IGRpc3BsYXlfbW9kZV92YmFfMjE6IHJlbW92ZSB1aW50IHR5
cGVkZWYKICBkcm0vYW1kL2Rpc3BsYXk6IGZpeCBkY24yMSBNYWtlZmlsZSBmb3IgY2xhbmcKICBb
UkVTRU5EXSBkcm0vYW1kL2Rpc3BsYXk6IGhpZGUgYW4gdW51c2VkIHZhcmlhYmxlCiAgW1JFU0VO
RF0gZHJtL2FtZGdwdTogd29yayBhcm91bmQgbGx2bSBidWcgIzQyNTc2CgogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvTWFrZWZpbGUgICAgICAgICAgICAgICAgIHwgIDIgKy0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jICAgICAgICAgICAgICB8ICAxICsKIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgICAgICAgICAgICAgICAgICB8ICAyIC0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jICAgfCAgMiAr
KwogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL01ha2VmaWxlICAgICAgIHwg
MTIgKysrKysrKysrKystCiAuLi4vYW1kL2Rpc3BsYXkvZGMvZG1sL2RjbjIxL2Rpc3BsYXlfbW9k
ZV92YmFfMjEuYyAgfCAxMyArKysrKy0tLS0tLS0tCiA2IGZpbGVzIGNoYW5nZWQsIDIwIGluc2Vy
dGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQoKLS0gCjIuMjAuMAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
