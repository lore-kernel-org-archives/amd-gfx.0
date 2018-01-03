From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4.15 3/4] drm/amd/display: Both timing_sync and multisync need
 stream_count > 1
Date: Wed,  3 Jan 2018 17:11:07 +0000
Message-ID: <20180103171108.17391-4-carlo@caione.org>
References: <20180103171108.17391-1-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180103171108.17391-1-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
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
To: alexander.deucher-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Yuehin.Lau-5C7GfCeVMHo@public.gmane.org, mikita.lipski-5C7GfCeVMHo@public.gmane.org, Tony.Cheng-5C7GfCeVMHo@public.gmane.org, harry.wentland-5C7GfCeVMHo@public.gmane.org, linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org, drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org

RnJvbTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CgpQcmV2aW91cyBj
b2RlIHRocmV3IGEgd2FybmluZyBhYm91dCBtaXNsZWFkaW5nIGluZGVudGF0aW9uCgpTaWduZWQt
b2ZmLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KUmV2aWV3ZWQt
Ynk6IE1pa2l0YSBMaXBza2kgPE1pa2l0YS5MaXBza2lAYW1kLmNvbT4KQWNrZWQtYnk6IEhhcnJ5
IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2NvcmUvZGMuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2NvcmUvZGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3Jl
L2RjLmMKaW5kZXggMjZjMGRhZGU3OTgyLi41YjNjYTgwZDk0MDEgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYwpAQCAtOTEwLDkgKzkxMCwxMCBAQCBzdGF0aWMgZW51
bSBkY19zdGF0dXMgZGNfY29tbWl0X3N0YXRlX25vX2NoZWNrKHN0cnVjdCBkYyAqZGMsIHN0cnVj
dCBkY19zdGF0ZSAqYwogCX0KIAlyZXN1bHQgPSBkYy0+aHdzcy5hcHBseV9jdHhfdG9faHcoZGMs
IGNvbnRleHQpOwogCi0JaWYgKGNvbnRleHQtPnN0cmVhbV9jb3VudCA+IDEpCisJaWYgKGNvbnRl
eHQtPnN0cmVhbV9jb3VudCA+IDEpIHsKIAkJZW5hYmxlX3RpbWluZ19tdWx0aXN5bmMoZGMsIGNv
bnRleHQpOwogCQlwcm9ncmFtX3RpbWluZ19zeW5jKGRjLCBjb250ZXh0KTsKKwl9CiAKIAlkY19l
bmFibGVfc3RlcmVvKGRjLCBjb250ZXh0LCBkY19zdHJlYW1zLCBjb250ZXh0LT5zdHJlYW1fY291
bnQpOwogCi0tIAoyLjE0LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
