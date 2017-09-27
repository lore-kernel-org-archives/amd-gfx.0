From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu/vega10: static constify channel_number
Date: Thu, 28 Sep 2017 08:48:32 +1000
Message-ID: <20170927224832.18088-2-airlied@gmail.com>
References: <20170927224832.18088-1-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170927224832.18088-1-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

RnJvbTogRGF2ZSBBaXJsaWUgPGFpcmxpZWRAcmVkaGF0LmNvbT4KClNpZ25lZC1vZmYtYnk6IERh
dmUgQWlybGllIDxhaXJsaWVkQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvaHdtZ3IvdmVnYTEwX2h3bWdyLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9od21nci92ZWdhMTBfaHdtZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21nci5jCmluZGV4IGE1OWQyODIuLjgwZTQxYmUgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21n
ci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21n
ci5jCkBAIC01Niw3ICs1Niw3IEBACiAKICNkZWZpbmUgSEJNX01FTU9SWV9DSEFOTkVMX1dJRFRI
ICAgIDEyOAogCi11aW50MzJfdCBjaGFubmVsX251bWJlcltdID0gezEsIDIsIDAsIDQsIDAsIDgs
IDAsIDE2LCAyfTsKK3N0YXRpYyBjb25zdCB1aW50MzJfdCBjaGFubmVsX251bWJlcltdID0gezEs
IDIsIDAsIDQsIDAsIDgsIDAsIDE2LCAyfTsKIAogI2RlZmluZSBNRU1fRlJFUV9MT1dfTEFURU5D
WSAgICAgICAgMjUwMDAKICNkZWZpbmUgTUVNX0ZSRVFfSElHSF9MQVRFTkNZICAgICAgIDgwMDAw
Ci0tIAoyLjkuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
