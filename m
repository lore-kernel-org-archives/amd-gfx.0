From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
Subject: [PATCH 2/3] drm/doc: Add initial amdgpu driver documentation
Date: Thu, 31 May 2018 18:17:07 +0200
Message-ID: <20180531161708.5894-2-michel@daenzer.net>
References: <20180531161708.5894-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180531161708.5894-1-michel@daenzer.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: amd-gfx@lists.freedesktop.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Jonathan Corbet <corbet@lwn.net>
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpTaWduZWQtb2Zm
LWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KLS0tCiBEb2N1bWVu
dGF0aW9uL2dwdS9hbWRncHUucnN0ICB8IDYgKysrKysrCiBEb2N1bWVudGF0aW9uL2dwdS9kcml2
ZXJzLnJzdCB8IDEgKwogMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKIGNyZWF0ZSBt
b2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2dwdS9hbWRncHUucnN0CgpkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9ncHUvYW1kZ3B1LnJzdCBiL0RvY3VtZW50YXRpb24vZ3B1L2FtZGdwdS5yc3QK
bmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAwLi40MWExNGU0YWE0YWMKLS0t
IC9kZXYvbnVsbAorKysgYi9Eb2N1bWVudGF0aW9uL2dwdS9hbWRncHUucnN0CkBAIC0wLDAgKzEs
NiBAQAorPT09PT09PT09PT09PT09PT09PT09PT09PQorIGRybS9hbWRncHUgQU1EZ3B1IGRyaXZl
cgorPT09PT09PT09PT09PT09PT09PT09PT09PQorCitUaGUgZHJtL2FtZGdwdSBkcml2ZXIgc3Vw
cG9ydHMgYWxsIEFNRCBSYWRlb24gR1BVcyBiYXNlZCBvbiB0aGUgR3JhcGhpY3MgQ29yZQorTmV4
dCAoR0NOKSBhcmNoaXRlY3R1cmUuCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2dwdS9kcml2
ZXJzLnJzdCBiL0RvY3VtZW50YXRpb24vZ3B1L2RyaXZlcnMucnN0CmluZGV4IGU4Yzg0NDE5YTJh
MS4uNjA0YjZkNjk3NWFmIDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL2dwdS9kcml2ZXJzLnJz
dAorKysgYi9Eb2N1bWVudGF0aW9uL2dwdS9kcml2ZXJzLnJzdApAQCAtNCw2ICs0LDcgQEAgR1BV
IERyaXZlciBEb2N1bWVudGF0aW9uCiAKIC4uIHRvY3RyZWU6OgogCisgICBhbWRncHUKICAgIGk5
MTUKICAgIG1lc29uCiAgICBwbDExMQotLSAKMi4xNy4wCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
