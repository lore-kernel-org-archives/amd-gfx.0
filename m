From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v3 2/3] drm/amdgpu: Create helper to clear
 AMDGPU_GEM_CREATE_CPU_GTT_USWC
Date: Wed, 24 Jul 2019 16:24:04 +0200
Message-ID: <e70a00d3-bcd3-c72e-8de8-eb6ae10abee6@daenzer.net>
References: <1563977442-4809-1-git-send-email-andrey.grodzovsky@amd.com>
 <1563977442-4809-3-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1563977442-4809-3-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, hersenxs.wu-5C7GfCeVMHo@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, shirish.s-5C7GfCeVMHo@public.gmane.org

T24gMjAxOS0wNy0yNCA0OjEwIHAubS4sIEFuZHJleSBHcm9kem92c2t5IHdyb3RlOgo+IE1vdmUg
dGhlIGxvZ2ljIHRvIGNsZWFyIEFNREdQVV9HRU1fQ1JFQVRFX0NQVV9HVFRfVVNXQyBpbgo+IGFt
ZGdwdV9ib19kb19jcmVhdGUgaW50byBzdGFuZGFsb25lIGhlbHBlciBzbyBpdCBjYW4gYmUgcmV1
c2VkCj4gaW4gb3RoZXIgZnVuY3Rpb25zLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBHcm9k
em92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPgo+IC0tLQo+ICBbLi4uXQo+IAo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKPiBpbmRleCA5ODliN2I1
Li42NGM0NWJjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9vYmplY3QuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmpl
Y3QuYwo+IEBAIC00MTMsNiArNDEzLDQxIEBAIHN0YXRpYyBib29sIGFtZGdwdV9ib192YWxpZGF0
ZV9zaXplKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAJcmV0dXJuIGZhbHNlOwo+ICB9
Cj4gIAo+ICt2b2lkIGFtZGdwdV9ib192YWxpZGF0ZV91c3djKHU2NCAqYm9fZmxhZ3MpCgpUaGlz
IEFQSSBpcyBhIGJpdCB3ZWlyZC4gOikgSSdkIHN1Z2dlc3Qgc29tZXRoaW5nIGxpa2UKCmJvb2wg
YW1kZ3B1X3Vzd2Nfc3VwcG9ydGVkKHZvaWQpCnsKCWlmIChbdmFyaW91cyBjb25kaXRpb25zXSkK
CQlyZXR1cm4gZmFsc2U7CgoJcmV0dXJuIHRydWU7Cn0KCj4gQEAgLTQ2NiwzMyArNTAxLDcgQEAg
c3RhdGljIGludCBhbWRncHVfYm9fZG9fY3JlYXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LAo+IFsuLi5dCj4gKwlhbWRncHVfYm9fdmFsaWRhdGVfdXN3YygmYm8tPmZsYWdzKTsKCkFuZCB0
aGVuCgoJaWYgKCFhbWRncHVfdXN3Y19zdXBwb3J0ZWQoKSkKCQliby0+ZmxhZ3MgJj0gfkFNREdQ
VV9HRU1fQ1JFQVRFX0NQVV9HVFRfVVNXQzsKCmhlcmUuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwg
RMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgIGh0dHBzOi8vd3d3LmFtZC5jb20K
TGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2Eg
YW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
