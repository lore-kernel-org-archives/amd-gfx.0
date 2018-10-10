From: James Zhu <jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 17/18] drm/amdgpu/vcn:Set VCPU busy after gate power during
 vcn SPG start
Date: Wed, 10 Oct 2018 14:42:07 -0400
Message-ID: <1539196928-28890-18-git-send-email-James.Zhu@amd.com>
References: <1539196928-28890-1-git-send-email-James.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1539196928-28890-1-git-send-email-James.Zhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: james.zhu-5C7GfCeVMHo@public.gmane.org

U2V0IFZDUFUgYnVzeSBhZnRlciBnYXRlIHBvd2VyIGR1cmluZyB2Y24gU3RhdGljIFBvd2VyIEdh
dGUgc3RhcnQKClNpZ25lZC1vZmYtYnk6IEphbWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYyB8IDQgKysrKwogMSBmaWxl
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3Zjbl92MV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFf
MC5jCmluZGV4IDE1M2YyM2EuLmQ4ZmUxNGQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3Zjbl92MV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNu
X3YxXzAuYwpAQCAtNzc3LDYgKzc3NywxMCBAQCBzdGF0aWMgaW50IHZjbl92MV8wX3N0YXJ0X3Nw
Z19tb2RlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCWxtaV9zd2FwX2NudGwgPSAwOwog
CiAJdmNuXzFfMF9kaXNhYmxlX3N0YXRpY19wb3dlcl9nYXRpbmcoYWRldik7CisKKwl0bXAgPSBS
UkVHMzJfU09DMTUoVVZELCAwLCBtbVVWRF9TVEFUVVMpIHwgVVZEX1NUQVRVU19fVVZEX0JVU1k7
CisJV1JFRzMyX1NPQzE1KFVWRCwgMCwgbW1VVkRfU1RBVFVTLCB0bXApOworCiAJLyogZGlzYWJs
ZSBjbG9jayBnYXRpbmcgKi8KIAl2Y25fdjFfMF9kaXNhYmxlX2Nsb2NrX2dhdGluZyhhZGV2KTsK
IAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
