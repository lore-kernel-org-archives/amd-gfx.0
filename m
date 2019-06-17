From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 446/459] drm/amd/display: Alpha plane type
Date: Mon, 17 Jun 2019 14:49:35 -0500
Message-ID: <20190617194948.18667-47-alexander.deucher@amd.com>
References: <20190617194948.18667-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190617194948.18667-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, Dmytro Laktyushkin <Dmytro.Laktyushkin-5C7GfCeVMHo@public.gmane.org>, Eric Bernstein <eric.bernstein-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRXJpYyBCZXJuc3RlaW4gPGVyaWMuYmVybnN0ZWluQGFtZC5jb20+CgpBZGQgQWxwaGEg
c3VyZmFjZSB0eXBlIGZvciBmdXR1cmUgdXNlCgpTaWduZWQtb2ZmLWJ5OiBFcmljIEJlcm5zdGVp
biA8ZXJpYy5iZXJuc3RlaW5AYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IERteXRybyBMYWt0eXVzaGtp
biA8RG15dHJvLkxha3R5dXNoa2luQGFtZC5jb20+CkFja2VkLWJ5OiBCaGF3YW5wcmVldCBMYWto
YSA8Qmhhd2FucHJlZXQuTGFraGFAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kY24xMC9kY24xMF9odWJwLmggfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24x
MC9kY24xMF9odWJwLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMTAvZGNu
MTBfaHVicC5oCmluZGV4IGI4YTRiZmNkYmViMi4uOTFkYzQyZTU4MGVjIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfaHVicC5oCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9odWJwLmgKQEAgLTQ1OSw2
ICs0NTksNyBAQAogCXR5cGUgUk9UQVRJT05fQU5HTEU7XAogCXR5cGUgSF9NSVJST1JfRU47XAog
CXR5cGUgU1VSRkFDRV9QSVhFTF9GT1JNQVQ7XAorCXR5cGUgQUxQSEFfUExBTkVfRU47XAogCXR5
cGUgU1VSRkFDRV9GTElQX1RZUEU7XAogCXR5cGUgU1VSRkFDRV9GTElQX01PREVfRk9SX1NURVJF
T1NZTkM7XAogCXR5cGUgU1VSRkFDRV9GTElQX0lOX1NURVJFT1NZTkM7XAotLSAKMi4yMC4xCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
