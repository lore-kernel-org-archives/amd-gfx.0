From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 20/37] drm/amd/display: fix number of dcn21 dpm clock levels
Date: Thu, 17 Oct 2019 15:13:12 -0400
Message-ID: <20191017191329.11857-21-sunpeng.li@amd.com>
References: <20191017191329.11857-1-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191017191329.11857-1-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, Dmytro Laktyushkin <Dmytro.Laktyushkin-5C7GfCeVMHo@public.gmane.org>, Chris Park <Chris.Park-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRG15dHJvIExha3R5dXNoa2luIDxEbXl0cm8uTGFrdHl1c2hraW5AYW1kLmNvbT4KClRo
ZXNlIGFyZSBzcGVjaWZpYyB0byBkY24yMSBhbmQgc2hvdWxkIG5vdCBiZSBpbmNyZWFzZWQgZm9y
CnJldXNlIG9uIG90aGVyIGFzaWNzLgoKU2lnbmVkLW9mZi1ieTogRG15dHJvIExha3R5dXNoa2lu
IDxEbXl0cm8uTGFrdHl1c2hraW5AYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IENocmlzIFBhcmsgPENo
cmlzLlBhcmtAYW1kLmNvbT4KQWNrZWQtYnk6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbV9wcF9zbXUuaCB8IDQgKystLQog
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1fcHBfc211LmggYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1fcHBfc211LmgKaW5kZXggYjAxZGI2MWI2MTgxLi5l
ZjdkZjllZjZkN2UgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9k
bV9wcF9zbXUuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1fcHBfc211
LmgKQEAgLTI1MSw4ICsyNTEsOCBAQCBzdHJ1Y3QgcHBfc211X2Z1bmNzX252IHsKIAogI2RlZmlu
ZSBQUF9TTVVfTlVNX1NPQ0NMS19EUE1fTEVWRUxTICA4CiAjZGVmaW5lIFBQX1NNVV9OVU1fRENG
Q0xLX0RQTV9MRVZFTFMgIDgKLSNkZWZpbmUgUFBfU01VX05VTV9GQ0xLX0RQTV9MRVZFTFMgICAg
OAotI2RlZmluZSBQUF9TTVVfTlVNX01FTUNMS19EUE1fTEVWRUxTICA4CisjZGVmaW5lIFBQX1NN
VV9OVU1fRkNMS19EUE1fTEVWRUxTICAgIDQKKyNkZWZpbmUgUFBfU01VX05VTV9NRU1DTEtfRFBN
X0xFVkVMUyAgNAogCiBzdHJ1Y3QgZHBtX2Nsb2NrIHsKICAgdWludDMyX3QgIEZyZXE7ICAgIC8v
IEluIE1IegotLSAKMi4yMy4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=
