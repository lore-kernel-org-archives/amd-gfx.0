From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 1/5] drm/amd/powerplay: Fix meaning of 0x1E PPSMC_MSG
Date: Wed, 14 Aug 2019 16:40:13 -0400
Message-ID: <1565815217-9533-2-git-send-email-andrey.grodzovsky@amd.com>
References: <1565815217-9533-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1565815217-9533-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, evan.quan-5C7GfCeVMHo@public.gmane.org, Shirish.S-5C7GfCeVMHo@public.gmane.org

QnkgY29tcGFyaW5nIHRvIHdpbmRvd3MgaXQgbWVhbnMgQVNJQyByZXNldC4KClNpZ25lZC1vZmYt
Ynk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPgpSZXZpZXdl
ZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvcnZfcHBzbWMuaCB8IDIgKy0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9ydl9wcHNtYy5oIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvaW5jL3J2X3Bwc21jLmgKaW5kZXggOTA4NzllNC4uZGY0Njc3ZCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL3J2X3Bwc21jLmgKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL3J2X3Bwc21jLmgKQEAgLTU5LDcg
KzU5LDcgQEAKICNkZWZpbmUgUFBTTUNfTVNHX1NldERyaXZlckRyYW1BZGRyTG93ICAgICAgICAg
IDB4MUIKICNkZWZpbmUgUFBTTUNfTVNHX1RyYW5zZmVyVGFibGVTbXUyRHJhbSAgICAgICAgIDB4
MUMKICNkZWZpbmUgUFBTTUNfTVNHX1RyYW5zZmVyVGFibGVEcmFtMlNtdSAgICAgICAgIDB4MUQK
LSNkZWZpbmUgUFBTTUNfTVNHX0NvbnRyb2xHZnhSTSAgICAgICAgICAgICAgICAgIDB4MUUKKyNk
ZWZpbmUgUFBTTUNfTVNHX0RldmljZURyaXZlclJlc2V0ICAgICAgICAgICAgIDB4MUUKICNkZWZp
bmUgUFBTTUNfTVNHX1NldEdmeGNsa092ZXJkcml2ZUJ5RnJlcVZpZCAgIDB4MUYKICNkZWZpbmUg
UFBTTUNfTVNHX1NldEhhcmRNaW5EY2VmY2xrQnlGcmVxICAgICAgIDB4MjAKICNkZWZpbmUgUFBT
TUNfTVNHX1NldEhhcmRNaW5Tb2NjbGtCeUZyZXEgICAgICAgIDB4MjEKLS0gCjIuNy40CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
