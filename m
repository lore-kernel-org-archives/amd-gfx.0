From: "Liu, Aaron" <Aaron.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amd/display: update renoir_ip_offset.h
Date: Wed, 4 Sep 2019 06:06:48 +0000
Message-ID: <1567577166-18064-2-git-send-email-aaron.liu@amd.com>
References: <1567577166-18064-1-git-send-email-aaron.liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1567577166-18064-1-git-send-email-aaron.liu-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Huang,
 Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Li, Roman" <Roman.Li-5C7GfCeVMHo@public.gmane.org>, "Liu,
 Aaron" <Aaron.Liu-5C7GfCeVMHo@public.gmane.org>

VGhpcyBwYXRjaCB1cGRhdGVzIE1QMV9CQVNFIGluIHJlbm9pcl9pcF9vZmZzZXQuaAoKU2lnbmVk
LW9mZi1ieTogQWFyb24gTGl1IDxhYXJvbi5saXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2luY2x1ZGUvcmVub2lyX2lwX29mZnNldC5oIHwgMiArLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9pbmNsdWRlL3Jlbm9pcl9pcF9vZmZzZXQuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
aW5jbHVkZS9yZW5vaXJfaXBfb2Zmc2V0LmgKaW5kZXggNTU0NzE0Yy4uMDk0NjQ4YyAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL3Jlbm9pcl9pcF9vZmZzZXQuaAorKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvcmVub2lyX2lwX29mZnNldC5oCkBAIC0xNTUs
NyArMTU1LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBJUF9CQVNFIE1QMF9CQVNFID17IHsgeyB7
IDB4MDAwMTYwMDAsIDB4MDI0M0ZDMDAsIDB4MDBEQzAwMDAKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB7IHsgMCwgMCwgMCwgMCwgMCB9IH0sCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgeyB7IDAsIDAsIDAsIDAsIDAgfSB9LAogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHsgeyAwLCAwLCAwLCAwLCAwIH0gfSB9
IH07Ci1zdGF0aWMgY29uc3Qgc3RydWN0IElQX0JBU0UgTVAxX0JBU0UgPXsgeyB7IHsgMHgwMDAx
NjIwMCwgMHgwMjQwMDQwMCwgMHgwMEU4MDAwMCwgMHgwMEVDMDAwMCwgMHgwMEYwMDAwMCB9IH0s
CitzdGF0aWMgY29uc3Qgc3RydWN0IElQX0JBU0UgTVAxX0JBU0UgPXsgeyB7IHsgMHgwMDAxNjAw
MCwgMHgwMjQwMDQwMCwgMHgwMEU4MDAwMCwgMHgwMEVDMDAwMCwgMHgwMEYwMDAwMCB9IH0sCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgeyB7IDAsIDAsIDAsIDAsIDAg
fSB9LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHsgeyAwLCAwLCAw
LCAwLCAwIH0gfSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB7IHsg
MCwgMCwgMCwgMCwgMCB9IH0sCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4
