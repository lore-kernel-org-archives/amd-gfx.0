From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 0/2] drm/amd/display: Add HDR output metadata support for
 amdgpu
Date: Tue, 28 May 2019 15:08:34 -0400
Message-ID: <20190528190836.10738-1-nicholas.kazlauskas@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

VGhpcyBwYXRjaCBzZXJpZXMgZW5hYmxlcyBIRFIgb3V0cHV0IG1ldGFkYXRhIHN1cHBvcnQgaW4g
YW1kZ3B1IHVzaW5nIHRoZQpEUk0gSERSIGludGVyZmFjZSBtZXJnZWQgaW4gZHJtLW1pc2MtbmV4
dC4gRW5hYmxlZCBmb3IgRENFIGFuZCBEQ04gQVNJQ3MKb3ZlciBEUCBhbmQgSERNSS4KCkl0J3Mg
bGltaXRlZCB0byBzdGF0aWMgSERSIG1ldGFkYXRhIHN1cHBvcnQgZm9yIG5vdyBzaW5jZSB0aGF0
J3MgYWxsIHRoZQpEUk0gaW50ZXJmYWNlIHN1cHBvcnRzLiBJdCByZXF1aXJlcyBhIG1vZGVzZXQg
Zm9yIGVudGVyaW5nIGFuZCBleGl0aW5nIEhEUgpidXQgdGhlIG1ldGFkYXRhIGNhbiBiZSBjaGFu
Z2VkIHdpdGhvdXQgb25lLgoKQ2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQu
Y29tPgoKTmljaG9sYXMgS2F6bGF1c2thcyAoMik6CiAgZHJtL2FtZC9kaXNwbGF5OiBFeHBvc2Ug
SERSIG91dHB1dCBtZXRhZGF0YSBmb3Igc3VwcG9ydGVkIGNvbm5lY3RvcnMKICBkcm0vYW1kL2Rp
c3BsYXk6IE9ubHkgZm9yY2UgbW9kZXNldHMgd2hlbiB0b2dnbGluZyBIRFIKCiAuLi4vZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAxNTUgKysrKysrKysrKysrKysr
KystCiAxIGZpbGUgY2hhbmdlZCwgMTUxIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgot
LSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
