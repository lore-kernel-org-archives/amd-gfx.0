From: Timothy Pearson <tpearson-z0qzliK6Om0mgXJStvpl+vpXobYPEAuW@public.gmane.org>
Subject: [PATCH 1/1] amdgpu: Enable KFD on POWER systems
Date: Sun, 24 Nov 2019 13:09:11 -0600 (CST)
Message-ID: <1868602885.1922458.1574622551082.JavaMail.zimbra@raptorengineeringinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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

S0ZEIGhhcyBiZWVuIHZlcmlmaWVkIHRvIGZ1bmN0aW9uIG9uIFBPV0VSIHN5c3RlbXMgKFRhbG9z
IElJIC8gVmVnYSA2NCkuCkl0IHNob3VsZCBiZSBhdmFpbGFibGUgYXMgYSBrZXJuZWwgY29uZmln
dXJhdGlvbiBvcHRpb24gb24gdGhlc2Ugc3lzdGVtcy4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9LY29uZmlnIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQvS2Nv
bmZpZyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL0tjb25maWcKaW5kZXggYTFhMzVkNGQ1
OTRiLi5iYTBlNjgwNTdhODkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L0tjb25maWcKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQvS2NvbmZpZwpAQCAtNSw3
ICs1LDcgQEAKIAogY29uZmlnIEhTQV9BTUQKIAlib29sICJIU0Ega2VybmVsIGRyaXZlciBmb3Ig
QU1EIEdQVSBkZXZpY2VzIgotCWRlcGVuZHMgb24gRFJNX0FNREdQVSAmJiAoWDg2XzY0IHx8IEFS
TTY0KQorCWRlcGVuZHMgb24gRFJNX0FNREdQVSAmJiAoWDg2XzY0IHx8IEFSTTY0IHx8IFBQQzY0
KQogCWltcGx5IEFNRF9JT01NVV9WMiBpZiBYODZfNjQKIAlzZWxlY3QgTU1VX05PVElGSUVSCiAJ
aGVscAotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
