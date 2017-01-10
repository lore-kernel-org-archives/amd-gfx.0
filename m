From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [V2 11/11] drm/amdgpu: do not reset gpu for virtualization
Date: Tue, 10 Jan 2017 14:18:34 +0100
Message-ID: <7106150a-e0e1-f904-6b00-33ee8fe5bd01@vodafone.de>
References: <1484042450-22987-1-git-send-email-Xiangliang.Yu@amd.com>
 <1484042450-22987-12-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1484042450-22987-12-git-send-email-Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
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
To: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

QW0gMTAuMDEuMjAxNyB1bSAxMTowMCBzY2hyaWViIFhpYW5nbGlhbmcgWXU6Cj4gQ3VycmVudCBq
b2IgdGltZW91dCBzZXR0aW5nIGlzIG5vdCBmaXQgZm9yIHZpcnR1YWxpemF0aW9uLCBzbyBpdAo+
IHdpbGwgY2F1c2Ugam9iIHRpbWVvdXQgc29tZXRpbWVzLiBBZGQgd29ya2Fyb3VuZCBmb3IgdGhp
cyB3aGVuCj4gdGltZW91dCBoYXBwZW4uCj4KPiBTaWduZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9u
ay5MaXVAYW1kLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBYaWFuZ2xpYW5nIFl1IDxYaWFuZ2xpYW5n
Lll1QGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGV2aWNlLmMgfCAzICsrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+IGluZGV4IGE2ZDgy
OGMuLjU3MDVmYmQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jCj4gQEAgLTIzMjQsNiArMjMyNCw5IEBAIGludCBhbWRncHVfZ3B1X3Jlc2V0KHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgCWludCByZXNjaGVkOwo+ICAgCWJvb2wgbmVlZF9m
dWxsX3Jlc2V0Owo+ICAgCj4gKwlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQoKQXQgYmFyZSBt
aW5pbXVtIHdlIHNob3VsZCBwcmludCBhIHdhcm5pbmcgaGVyZSBhbmQgaW5jcmVhc2Ugb3IgCmNv
bXBsZXRlbHkgZGlzYWJsZSB0aGUgam9iIHRpbWVvdXQgd2hlbiB2aXJ0dWFsaXphdGlvbiBpcyBl
bmFibGVkLgoKQ2hyaXN0aWFuLgoKPiArCQlyZXR1cm4gMDsKPiArCj4gICAJaWYgKCFhbWRncHVf
Y2hlY2tfc29mdF9yZXNldChhZGV2KSkgewo+ICAgCQlEUk1fSU5GTygiTm8gaGFyZHdhcmUgaGFu
ZyBkZXRlY3RlZC4gRGlkIHNvbWUgYmxvY2tzIHN0YWxsP1xuIik7Cj4gICAJCXJldHVybiAwOwoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
