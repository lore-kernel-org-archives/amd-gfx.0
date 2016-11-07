From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH 4/4] reservation: revert "wait only with non-zero timeout
 specified (v3)" v2
Date: Mon,  7 Nov 2016 16:16:16 -0500
Message-ID: <1478553376-18575-4-git-send-email-alexander.deucher@amd.com>
References: <1478553376-18575-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1478553376-18575-1-git-send-email-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKVGhpcyBy
ZXZlcnRzIGNvbW1pdCBmYjhiN2QyYjlkODBlMWU3MWYzNzllNTczNTU5MzZiZDJiMDI0YmU5LgoK
T3RoZXJ3aXNlIHNpZ25hbGluZyBtaWdodCBuZXZlciBiZSBhY3RpdmF0ZWQgb24gdGhlIGZlbmNl
cy4gVGhpcyBjYW4KcmVzdWx0IGluIGluZmluaXRlIHdhaXRpbmcgd2l0aCBoYXJkd2FyZSB3aGlj
aCBoYXMgdW5yZWxpYWJsZSBpbnRlcnJ1cHRzLgoKdjI6IHN0aWxsIHJldHVybiBvbmUgd2hlbiB0
aGUgdGltZW91dCBpcyB6ZXJvIGFuZCB3ZSBkb24ndCBoYXZlIGFueSBmZW5jZXMuCgpSZXZpZXdl
ZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpTaWduZWQtb2Zm
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+ClJldmlld2Vk
LWJ5OiBDaHVubWluZyBaaG91IDxkYXZpZDEuemhvdUBhbWQuY29tPiAodjEpClNpZ25lZC1vZmYt
Ynk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2RtYS1idWYvcmVzZXJ2YXRpb24uYyB8IDUgKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS1idWYvcmVz
ZXJ2YXRpb24uYyBiL2RyaXZlcnMvZG1hLWJ1Zi9yZXNlcnZhdGlvbi5jCmluZGV4IDdlZDU2ZjMu
LjM5MzgxN2UgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZG1hLWJ1Zi9yZXNlcnZhdGlvbi5jCisrKyBi
L2RyaXZlcnMvZG1hLWJ1Zi9yZXNlcnZhdGlvbi5jCkBAIC0zNzAsMTAgKzM3MCw3IEBAIGxvbmcg
cmVzZXJ2YXRpb25fb2JqZWN0X3dhaXRfdGltZW91dF9yY3Uoc3RydWN0IHJlc2VydmF0aW9uX29i
amVjdCAqb2JqLAogewogCXN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlOwogCXVuc2lnbmVkIHNlcSwg
c2hhcmVkX2NvdW50LCBpID0gMDsKLQlsb25nIHJldCA9IHRpbWVvdXQ7Ci0KLQlpZiAoIXRpbWVv
dXQpCi0JCXJldHVybiByZXNlcnZhdGlvbl9vYmplY3RfdGVzdF9zaWduYWxlZF9yY3Uob2JqLCB3
YWl0X2FsbCk7CisJbG9uZyByZXQgPSB0aW1lb3V0ID8gdGltZW91dCA6IDE7CiAKIHJldHJ5Ogog
CWZlbmNlID0gTlVMTDsKLS0gCjIuNS41CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9kcmktZGV2ZWwK
