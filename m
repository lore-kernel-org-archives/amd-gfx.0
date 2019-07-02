From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 52/53] drm/amdgpu: disable concurrent flushes on Navi14
Date: Tue,  2 Jul 2019 15:28:43 -0500
Message-ID: <20190702202844.17001-53-alexander.deucher@amd.com>
References: <20190702202844.17001-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190702202844.17001-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

U2FtZSB0aGluZyBhcHBsaWVzIHRvIG5hdmkxNCBhcyBuYXZpMTAuCgpTaWduZWQtb2ZmLWJ5OiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lkcy5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfaWRzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfaWRzLmMKaW5kZXggNTg5OWQyMTQxODdiLi5jZDE1NTQwYzU2MjIgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfaWRzLmMKQEAgLTM2OCw3ICszNjgsOCBAQCBzdGF0aWMgaW50
IGFtZGdwdV92bWlkX2dyYWJfdXNlZChzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwKIAkJICogYXJlIGJy
b2tlbiBvbiBOYXZpMTAgYW5kIE5hdmkxNC4KIAkJICovCiAJCWlmIChuZWVkc19mbHVzaCAmJiAo
YWRldi0+YXNpY190eXBlIDwgQ0hJUF9WRUdBMTAgfHwKLQkJCQkgICAgYWRldi0+YXNpY190eXBl
ID09IENISVBfTkFWSTEwKSkKKwkJCQkgICAgYWRldi0+YXNpY190eXBlID09IENISVBfTkFWSTEw
IHx8CisJCQkJICAgIGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX05BVkkxNCkpCiAJCQljb250aW51
ZTsKIAogCQkvKiBHb29kLCB3ZSBjYW4gdXNlIHRoaXMgVk1JRC4gUmVtZW1iZXIgdGhpcyBzdWJt
aXNzaW9uIGFzCi0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
