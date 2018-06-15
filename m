From: "Gustavo A. R. Silva" <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>
Subject: [PATCH] drm/amd/display: fix type of variable
Date: Fri, 15 Jun 2018 08:32:28 -0500
Message-ID: <20180615133228.GA28677@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
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
To: Signed-off-by-CC+yJ3UmIYqDUpFQwHEjaQ@public.gmane.org, Roman Li <Roman.Li-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>
Cc: "Gustavo A. R. Silva" <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Q3VycmVudGx5LCB0aGUgbWF4aW11bSB2YWx1ZSB0aGF0ICpjb3VudGVyKiBjYW4gcmVhY2ggaXMg
MjU1LCBhbmQKY29kZSBhdCBsaW5lIDE1MDogd2hpbGUgKGNvdW50ZXIgPCAxMDAwKSB7IGltcGxp
ZXMgYSBiaWdnZXIgdmFsdWUKY291bGQgYmUgZXhwZWN0ZWQuCgpGaXggdGhpcyBieSBjaGFuZ2lu
ZyB0aGUgdHlwZSBvZiB2YXJpYWJsZSAqY291bnRlciogZnJvbSB1aW50OF90CnRvIHVpbnQxNl90
LgoKQWRkcmVzc2VzLUNvdmVyaXR5LUlEOiAxNDcwMDMwICgiT3BlcmFuZHMgZG9uJ3QgYWZmZWN0
IHJlc3VsdCIpCkZpeGVzOiAyYjYxOTlhMWQxYjcgKCJkcm0vYW1kL2Rpc3BsYXk6IHJlcGxhY2Ug
bXNsZWVwIHdpdGggdWRlbGF5IGluIGZiYyBwYXRoIikKU2lnbmVkLW9mZi1ieTogR3VzdGF2byBB
LiBSLiBTaWx2YSA8Z3VzdGF2b0BlbWJlZGRlZG9yLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9jb21wcmVzc29yLmMgfCAyICstCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9jb21wcmVzc29yLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9jb21wcmVzc29yLmMK
aW5kZXggZTI5OTRkMy4uMTExYzQ5MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2RjZTExMC9kY2UxMTBfY29tcHJlc3Nvci5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX2NvbXByZXNzb3IuYwpAQCAtMTQzLDcgKzE0
Myw3IEBAIHN0YXRpYyB2b2lkIHdhaXRfZm9yX2ZiY19zdGF0ZV9jaGFuZ2VkKAogCXN0cnVjdCBk
Y2UxMTBfY29tcHJlc3NvciAqY3AxMTAsCiAJYm9vbCBlbmFibGVkKQogewotCXVpbnQ4X3QgY291
bnRlciA9IDA7CisJdWludDE2X3QgY291bnRlciA9IDA7CiAJdWludDMyX3QgYWRkciA9IG1tRkJD
X1NUQVRVUzsKIAl1aW50MzJfdCB2YWx1ZTsKIAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
