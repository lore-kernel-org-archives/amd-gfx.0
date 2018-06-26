From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH 0/4] Fix HPD detection in runtime suspend
Date: Mon, 25 Jun 2018 21:09:03 -0400
Message-ID: <20180626010916.20300-1-lyude@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, Felix Kuehling <felix.kuehling@amd.com>, Huang Rui <ray.huang@amd.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Junwei Zhang <jerry.zhang@amd.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Jean Delvare <jdelvare@suse.de>, Alex Deucher <alexander.deucher@amd.com>, Rex Zhu <rex.zhu@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk Liu <monk.liu@amd.com>, Shaoyun Liu <shaoyun.liu@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

RG9lcyB3aGF0IGl0IHNheXMgb24gdGhlIGxhYmVsLCBtb3JlIGluZm9ybWF0aW9uIGluIHRoZSBw
YXRjaGVzCgpMeXVkZSBQYXVsICg0KToKICBkcm0vYW1kZ3B1OiBNYWtlIHN0cnVjdCBhbWRncHVf
YXRpZiBwcml2YXRlIHRvIGFtZGdwdV9hY3BpLmMKICBkcm0vYW1kZ3B1OiBzL2Rpc3BfZGV0ZXRp
b25fcG9ydHMvZGlzcF9kZXRlY3Rpb25fcG9ydHMvCiAgZHJtL2FtZGdwdTogQWRkIGFtZGdwdV9h
dHB4X2dldF9kaGFuZGxlKCkKICBkcm0vYW1kZ3B1OiBEeW5hbWljYWxseSBwcm9iZSBmb3IgQVRJ
RiBoYW5kbGUKCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCAgICAgICAgICAg
fCAgNDYgKystLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwaS5jICAg
ICAgfCAxMzIgKysrKysrKysrKysrKysrLS0tCiAuLi4vZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hdHB4X2hhbmRsZXIuYyAgfCAgMTAgKy0KIDMgZmlsZXMgY2hhbmdlZCwgMTI1IGluc2VydGlv
bnMoKyksIDYzIGRlbGV0aW9ucygtKQoKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
