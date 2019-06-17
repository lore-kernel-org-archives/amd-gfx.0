From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 422/459] drm/amd/display: add dsc_passthrough_support bit in
 dpcd struct
Date: Mon, 17 Jun 2019 14:49:11 -0500
Message-ID: <20190617194948.18667-23-alexander.deucher@amd.com>
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, Tony Cheng <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Wenjing Liu <Wenjing.Liu-5C7GfCeVMHo@public.gmane.org>, Nikola Cornij <Nikola.Cornij-5C7GfCeVMHo@public.gmane.org>

RnJvbTogV2VuamluZyBMaXUgPFdlbmppbmcuTGl1QGFtZC5jb20+CgpTaWduZWQtb2ZmLWJ5OiBX
ZW5qaW5nIExpdSA8V2VuamluZy5MaXVAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IE5pa29sYSBDb3Ju
aWogPE5pa29sYS5Db3JuaWpAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IFRvbnkgQ2hlbmcgPFRvbnku
Q2hlbmdAYW1kLmNvbT4KQWNrZWQtYnk6IEJoYXdhbnByZWV0IExha2hhIDxCaGF3YW5wcmVldC5M
YWtoYUBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2luY2x1ZGUvZHBj
ZF9zdHJ1Y3RzLmggfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
aW5jbHVkZS9kcGNkX3N0cnVjdHMuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9pbmNs
dWRlL2RwY2Rfc3RydWN0cy5oCmluZGV4IDZmNDE3ZTA0ODBlNi4uY2E5YzVlMGMwNjJmIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5jbHVkZS9kcGNkX3N0cnVjdHMu
aAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5jbHVkZS9kcGNkX3N0cnVjdHMu
aApAQCAtMzQsOSArMzQsOSBAQCBzdHJ1Y3QgZHBjZF9kc2NfYmFzaWNfY2FwYWJpbGl0aWVzIHsK
IAkJc3RydWN0IHsKIAkJCS8vIEJ5dGUgMAogCQkJc3RydWN0IHsKLQotCQkJCXVuc2lnbmVkIGNo
YXIgZHNjX3N1cHBvcnQJCQkJOjE7IC8vIEJpdDAKLQkJCQl1bnNpZ25lZCBjaGFyIHJlc2VydmVk
CQkJCQk6NzsKKwkJCQl1bnNpZ25lZCBjaGFyIGRzY19zdXBwb3J0CQk6MTsgLy8gQml0MAorCQkJ
CXVuc2lnbmVkIGNoYXIgZHNjX3Bhc3N0aHJvdWdoX3N1cHBvcnQJOjE7IC8vIEJpdDEKKwkJCQl1
bnNpZ25lZCBjaGFyIHJlc2VydmVkCQkJOjY7CiAJCQl9IGRzY19zdXBwb3J0OwogCiAJCQkvLyBC
eXRlIDEKLS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
