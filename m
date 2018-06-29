From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Remove amdgpu_gem_map_attach target_dev
 documentation
Date: Fri, 29 Jun 2018 17:43:35 +0800
Message-ID: <5B35FF47.1010409@amd.com>
References: <20180629092950.15454-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180629092950.15454-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDYvMjkvMjAxOCAwNToyOSBQTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gRnJvbTogTWlj
aGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+ClJldmlld2VkLWJ5OiBKdW53ZWkg
WmhhbmcgPEplcnJ5LlpoYW5nQGFtZC5jb20+Cgo+Cj4gVGhlIHBhcmFtZXRlciB3YXMgcmVtb3Zl
ZC4KPgo+IEZpeGVzOiBhMTk3NDFlNWU1YTkgImRtYV9idWY6IHJlbW92ZSBkZXZpY2UgcGFyYW1l
dGVyIGZyb20gYXR0YWNoCj4gICAgICAgICAgICAgICAgICAgICAgIGNhbGxiYWNrIHYyIgo+Cj4g
U2lnbmVkLW9mZi1ieTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+Cj4g
LS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHJpbWUuYyB8IDEgLQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHJpbWUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9wcmltZS5jCj4gaW5kZXggYjIyODZiYzQxYWVjLi5kZjcyMjZhZDY0YjUg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ByaW1lLmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHJpbWUuYwo+IEBAIC0x
OTEsNyArMTkxLDYgQEAgYW1kZ3B1X2dlbV9wcmltZV9pbXBvcnRfc2dfdGFibGUoc3RydWN0IGRy
bV9kZXZpY2UgKmRldiwKPiAgIC8qKgo+ICAgICogYW1kZ3B1X2dlbV9tYXBfYXR0YWNoIC0gJmRt
YV9idWZfb3BzLmF0dGFjaCBpbXBsZW1lbnRhdGlvbgo+ICAgICogQGRtYV9idWY6IHNoYXJlZCBE
TUEgYnVmZmVyCj4gLSAqIEB0YXJnZXRfZGV2OiB0YXJnZXQgZGV2aWNlCj4gICAgKiBAYXR0YWNo
OiBETUEtYnVmIGF0dGFjaG1lbnQKPiAgICAqCj4gICAgKiBNYWtlcyBzdXJlIHRoYXQgdGhlIHNo
YXJlZCBETUEgYnVmZmVyIGNhbiBiZSBhY2Nlc3NlZCBieSB0aGUgdGFyZ2V0IGRldmljZS4KPgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
