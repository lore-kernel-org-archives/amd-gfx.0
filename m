From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 03/11] drm/amd/dal/dc: fix warning in dce_link_encoder.c
Date: Tue, 22 Nov 2016 18:01:19 +0100
Message-ID: <f1ba562e-e0c7-6b1b-e85b-7db38339716e@vodafone.de>
References: <1479833848-14275-1-git-send-email-alexander.deucher@amd.com>
 <1479833848-14275-3-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1479833848-14275-3-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

QW0gMjIuMTEuMjAxNiB1bSAxNzo1NyBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBSZXZpZXdlZC1i
eTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1i
eTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IC0tLQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9kYWwvZGMvZGNlL2RjZV9saW5rX2VuY29kZXIuYyB8IDEgLQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2RhbC9kYy9kY2UvZGNlX2xpbmtfZW5jb2Rlci5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kYWwvZGMvZGNlL2RjZV9saW5rX2VuY29kZXIuYwo+IGluZGV4IDk2OGQ0MTguLjE1YTQ1
MzEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kYWwvZGMvZGNlL2RjZV9saW5r
X2VuY29kZXIuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGFsL2RjL2RjZS9kY2VfbGlu
a19lbmNvZGVyLmMKPiBAQCAtOTY0LDcgKzk2NCw2IEBAIGJvb2wgZGNlMTEwX2xpbmtfZW5jb2Rl
cl9jb25zdHJ1Y3QoCj4gICAJY29uc3Qgc3RydWN0IGRjZTExMF9saW5rX2VuY19hdXhfcmVnaXN0
ZXJzICphdXhfcmVncywKPiAgIAljb25zdCBzdHJ1Y3QgZGNlMTEwX2xpbmtfZW5jX2hwZF9yZWdp
c3RlcnMgKmhwZF9yZWdzKQo+ICAgewo+IC0Jc3RydWN0IGdyYXBoaWNzX29iamVjdF9lbmNvZGVy
X2NhcF9pbmZvIGVuY19jYXBfaW5mbyA9IHswfTsKPiAgIAoKVGhpcyBuZXcgbGluZSBpcyBwcm9i
YWJseSBzdXBlcmZsdW91cyBub3cgYXMgd2VsbC4KCldpdGggdGhpcyBmaXhlZCB0aGUgc2V0IGlz
IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIAo8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
Pi4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4gICAJZW5jMTEwLT5iYXNlLmZ1bmNzID0gJmRjZTEx
MF9sbmtfZW5jX2Z1bmNzOwo+ICAgCWVuYzExMC0+YmFzZS5jdHggPSBpbml0X2RhdGEtPmN0eDsK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
