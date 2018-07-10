From: kbuild test robot <fengguang.wu@intel.com>
Subject: [PATCH] drm/amd/pp: fix semicolon.cocci warnings
Date: Wed, 11 Jul 2018 01:11:08 +0800
Message-ID: <20180710171108.GA73972@lkp-hsx03>
References: <201807110104.iOYDaTfd%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <201807110104.iOYDaTfd%fengguang.wu@intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Rex Zhu <Rex.Zhu@amd.com>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org, Evan Quan <evan.quan@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

RnJvbToga2J1aWxkIHRlc3Qgcm9ib3QgPGZlbmdndWFuZy53dUBpbnRlbC5jb20+Cgpkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9wb3dlcnBsYXkvYW1kX3Bvd2VycGxheS5jOjEyMDk6MTct
MTg6IFVubmVlZGVkIHNlbWljb2xvbgoKCiBSZW1vdmUgdW5uZWVkZWQgc2VtaWNvbG9uLgoKR2Vu
ZXJhdGVkIGJ5OiBzY3JpcHRzL2NvY2NpbmVsbGUvbWlzYy9zZW1pY29sb24uY29jY2kKCkZpeGVz
OiBlYTg3MGU0NDQxNWEgKCJkcm0vYW1kL3BwOiBFeHBvcnQgbm90aWZ5X3NtdV9lbmFibGVfcHdl
IHRvIGRpc3BsYXkiKQpDQzogUmV4IFpodSA8UmV4LlpodUBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5
OiBrYnVpbGQgdGVzdCByb2JvdCA8ZmVuZ2d1YW5nLnd1QGludGVsLmNvbT4KLS0tCgogYW1kX3Bv
d2VycGxheS5jIHwgICAgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCgotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9wb3dlcnBsYXkv
YW1kX3Bvd2VycGxheS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3Bvd2Vy
cGxheS9hbWRfcG93ZXJwbGF5LmMKQEAgLTEyMDYsNyArMTIwNiw3IEBAIHN0YXRpYyBpbnQgcHBf
bm90aWZ5X3NtdV9lbmFibGVfcHdlKHZvaWQKIAlzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyID0gaGFu
ZGxlOwogCiAJaWYgKCFod21nciB8fCAhaHdtZ3ItPnBtX2VuKQotCQlyZXR1cm4gLUVJTlZBTDs7
CisJCXJldHVybiAtRUlOVkFMOwogCiAJaWYgKGh3bWdyLT5od21ncl9mdW5jLT5zbXVzX25vdGlm
eV9wd2UgPT0gTlVMTCkgewogCQlwcl9pbmZvKCIlcyB3YXMgbm90IGltcGxlbWVudGVkLlxuIiwg
X19mdW5jX18pOwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
