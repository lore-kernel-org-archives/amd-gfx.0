From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH v2 0/3] drm/edid: don't log errors on absent or old CEA SAD
 blocks
Date: Wed, 4 Sep 2019 11:11:52 +0200
Message-ID: <20190904111152.266d5176@endymion>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@linux.ie>, David@freedesktop.org, ChunMing <Zhou@freedesktop.org>, "  <David1.Zhou@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo  Li  <sunpeng.li@amd.com>, Maarten Lankhorst   <maarten.lankhorst@linux.intel.com>, Maxime Ripard   <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, Ville  =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,  Christian =?UTF-8?B?S8O2?= =?UTF-8?B?bmln?= <christian.koenig@amd.com>"@freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

SGkgYWxsLAoKVGhpcyBpcyBteSBhdHRlbXB0IHRvIGZpeCBidWcgZmRvIzEwNzgyNToKaHR0cHM6
Ly9idWdzLmZyZWVkZXNrdG9wLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTA3ODI1CgpbUEFUQ0ggMS8z
XSBkcm0vYW1kOiBiZSBxdWlldCB3aGVuIG5vIFNBRCBibG9jayBpcyBmb3VuZApbUEFUQ0ggMi8z
XSBkcm0vcmFkZW9uOiBiZSBxdWlldCB3aGVuIG5vIFNBRCBibG9jayBpcyBmb3VuZApbUEFUQ0gg
My8zXSBkcm0vZWRpZDogbm8gQ0VBIGV4dGVuc2lvbiBpcyBub3QgYW4gZXJyb3IKCkNoYW5nZXMg
c2luY2UgdjE6CiAqIEZpeGVkIHN1YmplY3Qgb2YgcGF0Y2ggMgogKiBUcmVhdCBDRUEgZXh0ZW5z
aW9uIHZlcnNpb24gPCAzIGFzIG5vbi1lcnJvciB0b28gKHN1Z2dlc3RlZCBieSBWaWxsZQogICBT
eXJqw6Rsw6QpCgotLSAKSmVhbiBEZWx2YXJlClNVU0UgTDMgU3VwcG9ydApfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0
CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
