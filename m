From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/7] drm/ttm:max_cpages is in unit of native page
Date: Tue, 12 Dec 2017 17:46:40 +0800
Message-ID: <1513072005-3477-2-git-send-email-Monk.Liu@amd.com>
References: <1513072005-3477-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1513072005-3477-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJNzA5Mzc5MTkzOWZjMWNjY2YyYTEzZDhjYzdlZjdhNmNjYTk1MzUxZApTaWdu
ZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0
bV9wYWdlX2FsbG9jLmMgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMKaW5k
ZXggNzE5NDVjYy4uYjViYTY0NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1f
cGFnZV9hbGxvYy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxsb2MuYwpA
QCAtNTQ0LDcgKzU0NCw3IEBAIHN0YXRpYyBpbnQgdHRtX2FsbG9jX25ld19wYWdlcyhzdHJ1Y3Qg
bGlzdF9oZWFkICpwYWdlcywgZ2ZwX3QgZ2ZwX2ZsYWdzLAogCWludCByID0gMDsKIAl1bnNpZ25l
ZCBpLCBqLCBjcGFnZXM7CiAJdW5zaWduZWQgbnBhZ2VzID0gMSA8PCBvcmRlcjsKLQl1bnNpZ25l
ZCBtYXhfY3BhZ2VzID0gbWluKGNvdW50LCAodW5zaWduZWQpTlVNX1BBR0VTX1RPX0FMTE9DKTsK
Kwl1bnNpZ25lZCBtYXhfY3BhZ2VzID0gbWluKGNvdW50IDw8IG9yZGVyLCAodW5zaWduZWQpTlVN
X1BBR0VTX1RPX0FMTE9DKTsKIAogCS8qIGFsbG9jYXRlIGFycmF5IGZvciBwYWdlIGNhY2hpbmcg
Y2hhbmdlICovCiAJY2FjaGluZ19hcnJheSA9IGttYWxsb2MobWF4X2NwYWdlcypzaXplb2Yoc3Ry
dWN0IHBhZ2UgKiksIEdGUF9LRVJORUwpOwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
