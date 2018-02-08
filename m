From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] drm/amd/powerplay/hwmgr: Adjustments for eight function
 implementations
Date: Thu, 8 Feb 2018 21:42:06 +0100
Message-ID: <1e5850db-c07f-add1-919a-be29be9c553d@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Colin Ian King <colin.king@canonical.com>, David Airlie <airlied@linux.ie>, Eric Huang <JinHuiEric.Huang@amd.com>, Evan Quan <evan.quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Himanshu Jha <himanshujha199640@gmail.com>, Junwei Zhang <Jerry.Zhang@amd.com>, Rex Zhu <Rex.Zhu@amd.com>, Tom St Denis <tom.stdenis@amd.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogTWFya3VzIEVsZnJpbmcgPGVsZnJpbmdAdXNlcnMuc291cmNlZm9yZ2UubmV0PgpEYXRl
OiBUaHUsIDggRmViIDIwMTggMjE6Mzc6NDIgKzAxMDAKClRocmVlIHVwZGF0ZSBzdWdnZXN0aW9u
cyB3ZXJlIHRha2VuIGludG8gYWNjb3VudApmcm9tIHN0YXRpYyBzb3VyY2UgY29kZSBhbmFseXNp
cy4KCk1hcmt1cyBFbGZyaW5nICgzKToKICBEZWxldGUgYW4gZXJyb3IgbWVzc2FnZSBmb3IgYSBm
YWlsZWQgbWVtb3J5IGFsbG9jYXRpb24gaW4gdGhyZWUgZnVuY3Rpb25zCiAgQWRqdXN0IGxheW91
dCBmb3Igc291cmNlIGNvZGUgZnJvbSBmaXZlIGlmIHN0YXRlbWVudHMKICBEZWxldGUgYW4gdW5u
ZWNlc3NhcnkgcmV0dXJuIHN0YXRlbWVudCBpbiB0aHJlZSBmdW5jdGlvbnMKCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9jel9od21nci5jICAgICB8IDM3ICsrKysrKysrKyst
LS0tLS0tLS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL2h3bWdyLmMg
ICAgICAgIHwgMzUgKysrKysrKysrLS0tLS0tLS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2h3bWdyL3BwYXRvbWN0cmwuYyAgIHwgIDUgKy0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9od21nci9ydl9od21nci5jICAgICB8ICA0ICstLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX2h3bWdyLmMgfCAgMSAtCiA1IGZpbGVzIGNoYW5n
ZWQsIDM1IGluc2VydGlvbnMoKyksIDQ3IGRlbGV0aW9ucygtKQoKLS0gCjIuMTYuMQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxp
bmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
