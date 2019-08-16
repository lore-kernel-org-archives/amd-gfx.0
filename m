From: Guchun Chen <guchun.chen-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH libdrm] tests: bypass amdgpu test build without lib-jsonc
Date: Fri, 16 Aug 2019 18:46:16 +0800
Message-ID: <20190816104616.4719-1-guchun.chen@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Hawking.Zhang-5C7GfCeVMHo@public.gmane.org, Dennis.Li-5C7GfCeVMHo@public.gmane.org, flora.cui-5C7GfCeVMHo@public.gmane.org, Tao.Zhou1-5C7GfCeVMHo@public.gmane.org
Cc: Guchun Chen <guchun.chen-5C7GfCeVMHo@public.gmane.org>

V2l0aG91dCBsaWItanNvbmMsIG9uZSBidWlsZCBlcnJvciBoYXBwZW5zLiBTbyB0aGlzIHBhdGNo
CmlzIHRvIGZpeCB0aGlzLgoKcmFzX3Rlc3RzLmM6MzM6MTA6IGZhdGFsIGVycm9yOiBqc29uLmg6
IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKICNpbmNsdWRlICJqc29uLmgiCiAgICAgICAgICBe
fn5+fn5+fgpjb21waWxhdGlvbiB0ZXJtaW5hdGVkLgpNYWtlZmlsZTo2MzY6IHJlY2lwZSBmb3Ig
dGFyZ2V0ICdhbWRncHVfdGVzdC1yYXNfdGVzdHMubycgZmFpbGVkCgpDaGFuZ2UtSWQ6IEkyY2E1
ZjgxM2E2ZDNlMTE4YTU3OTNjZTgwNzc2ZWUyYjI3NDkwMjM5ClNpZ25lZC1vZmYtYnk6IEd1Y2h1
biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPgotLS0KIHRlc3RzL01ha2VmaWxlLmFtIHwgMiAr
KwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL01h
a2VmaWxlLmFtIGIvdGVzdHMvTWFrZWZpbGUuYW0KaW5kZXggZDI3NGEzZTkuLmFmY2ZkNDg5IDEw
MDY0NAotLS0gYS90ZXN0cy9NYWtlZmlsZS5hbQorKysgYi90ZXN0cy9NYWtlZmlsZS5hbQpAQCAt
MTAsOSArMTAsMTEgQEAgZW5kaWYKIAogaWYgSEFWRV9BTURHUFUKIGlmIEhBVkVfQ1VOSVQKK2lm
IEhBVkVfSlNPTkMKIFNVQkRJUlMgKz0gYW1kZ3B1CiBlbmRpZgogZW5kaWYKK2VuZGlmCiAKIGlm
IEhBVkVfRVhZTk9TCiBTVUJESVJTICs9IGV4eW5vcwotLSAKMi4xNy4xCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
