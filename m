From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 013/117] soc/amd/raven: Disabling TDM mode flag
Date: Wed, 10 May 2017 14:46:12 -0400
Message-ID: <1494442068-8202-14-git-send-email-alexander.deucher@amd.com>
References: <1494442068-8202-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1494442068-8202-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Vijendar Mukunda <Vijendar.Mukunda-5C7GfCeVMHo@public.gmane.org>

RnJvbTogVmlqZW5kYXIgTXVrdW5kYSA8VmlqZW5kYXIuTXVrdW5kYUBhbWQuY29tPgoKU2lnbmVk
LW9mZi1ieTogVmlqZW5kYXIgTXVrdW5kYSA8VmlqZW5kYXIuTXVrdW5kYUBhbWQuY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQog
c291bmQvc29jL2FtZC9yYXZlbi9hY3AzeC1kdW1teTUxMDIuYyB8IDIgKy0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3Nv
Yy9hbWQvcmF2ZW4vYWNwM3gtZHVtbXk1MTAyLmMgYi9zb3VuZC9zb2MvYW1kL3JhdmVuL2FjcDN4
LWR1bW15NTEwMi5jCmluZGV4IDNiMmY1MDkuLjAyODJjNTkgMTAwNjQ0Ci0tLSBhL3NvdW5kL3Nv
Yy9hbWQvcmF2ZW4vYWNwM3gtZHVtbXk1MTAyLmMKKysrIGIvc291bmQvc29jL2FtZC9yYXZlbi9h
Y3AzeC1kdW1teTUxMDIuYwpAQCAtNTIsNyArNTIsNyBAQCBzdGF0aWMgc3RydWN0IHNuZF9zb2Nf
ZGFpX2xpbmsgYWNwM3hfZGFpX3c1MTAyW10gPSB7CiAJCS5jcHVfZGFpX25hbWUgPSAiYWNwM3hf
cnZfaTJzLjAiLAogCQkuY29kZWNfZGFpX25hbWUgPSAiZHVtbXlfdzUxMDJfZGFpIiwKIAkJLmNv
ZGVjX25hbWUgPSAiZHVtbXlfdzUxMDIuMCIsCi0JCS5kYWlfZm10ID0gU05EX1NPQ19EQUlGTVRf
RFNQX0EgLypTTkRfU09DX0RBSUZNVF9JMlMqLyB8IFNORF9TT0NfREFJRk1UX05CX05GCisJCS5k
YWlfZm10ID0gICAgIFNORF9TT0NfREFJRk1UX0kyUyB8IFNORF9TT0NfREFJRk1UX05CX05GCiAJ
CQkJfCBTTkRfU09DX0RBSUZNVF9DQk1fQ0ZNLAogCQkub3BzID0gJmFjcDN4X3dtNTEwMl9vcHMs
CiAJCS5pbml0ID0gYWNwM3hfaW5pdCwKLS0gCjIuNS41CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
