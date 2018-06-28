From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH v2 0/4] Fix HPD detection in runtime suspend
Date: Thu, 28 Jun 2018 15:14:51 -0400
Message-ID: <20180628191505.10015-1-lyude@redhat.com>
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
To: amd-gfx@lists.freedesktop.org
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, David Airlie <airlied@linux.ie>, Felix Kuehling <felix.kuehling@amd.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Jim Qu <jim.qu@amd.com>, Huang Rui <ray.huang@amd.com>, Jean Delvare <jdelvare@suse.de>, Alex Deucher <alexander.deucher@amd.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Rex Zhu <rex.zhu@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk Liu <monk.liu@amd.com>, Shaoyun Liu <shaoyun.liu@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

TmV4dCB2ZXJzaW9uIG9mIGh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9zZXJpZXMv
NDUzNzEvCgpOb3RhYmxlIGNoYW5nZXM6CiAtIEFkZGVkIGV4cGxhbmF0aW9uIG9uIHdoeSBBVElG
IGhhbmRsZSBzb21ldGltZXMgbGl2ZXMgaW4gYSBkaWZmZXJlbnQKICAgbmFtZXNwYWNlICh0aGFu
a3MgQWxleCEpCgpMeXVkZSBQYXVsICg0KToKICBkcm0vYW1kZ3B1OiBNYWtlIHN0cnVjdCBhbWRn
cHVfYXRpZiBwcml2YXRlIHRvIGFtZGdwdV9hY3BpLmMKICBkcm0vYW1kZ3B1OiBzL2Rpc3BfZGV0
ZXRpb25fcG9ydHMvZGlzcF9kZXRlY3Rpb25fcG9ydHMvCiAgZHJtL2FtZGdwdTogQWRkIGFtZGdw
dV9hdHB4X2dldF9kaGFuZGxlKCkKICBkcm0vYW1kZ3B1OiBEeW5hbWljYWxseSBwcm9iZSBmb3Ig
QVRJRiBoYW5kbGUKCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCAgICAgICAg
ICAgfCAgNDYgKystLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwaS5j
ICAgICAgfCAxMzIgKysrKysrKysrKysrKysrLS0tCiAuLi4vZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9hdHB4X2hhbmRsZXIuYyAgfCAgMTAgKy0KIDMgZmlsZXMgY2hhbmdlZCwgMTI1IGluc2Vy
dGlvbnMoKyksIDYzIGRlbGV0aW9ucygtKQoKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
