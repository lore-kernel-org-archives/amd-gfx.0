From: "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH v2] amdgpu: export gfx double offchip LDS buffers by dev
 info
Date: Tue, 21 Feb 2017 09:24:11 +0000
Message-ID: <DM5PR12MB18185A14AC957522FB543A1DFF510@DM5PR12MB1818.namprd12.prod.outlook.com>
References: <1487643563-3897-1-git-send-email-Jerry.Zhang@amd.com>
 <b0bf2992-178a-7c13-95e0-492ed04cf066@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b0bf2992-178a-7c13-95e0-492ed04cf066-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Content-Language: en-US
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IENocmlzdGlhbiBLw7ZuaWcgW21h
aWx0bzpkZWF0aHNpbXBsZUB2b2RhZm9uZS5kZV0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAy
MSwgMjAxNyAxNzoyMwo+IFRvOiBaaGFuZywgSmVycnk7IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gYW1kZ3B1OiBleHBvcnQgZ2Z4IGRvdWJs
ZSBvZmZjaGlwIExEUyBidWZmZXJzIGJ5IGRldgo+IGluZm8KPiAKPiBBbSAyMS4wMi4yMDE3IHVt
IDAzOjE5IHNjaHJpZWIgSnVud2VpIFpoYW5nOgo+ID4gU2lnbmVkLW9mZi1ieTogSnVud2VpIFpo
YW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29tPgo+IAo+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Lgo+IAo+IEJ1dCB3YWl0IGJlZm9yZSBwdXNo
aW5nIGl0IHVwc3RyZWFtIGZvciB0aGUga2VybmVsIGNoYW5nZSB0byBsYW5kIHVwc3RyZWFtIGFz
Cj4gd2VsbC4KClN1cmUsIHRoYW5rcy4KCj4gCj4gUmVnYXJkcywKPiBDaHJpc3RpYW4uCj4gCj4g
PiAtLS0KPiA+ICAgaW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oIHwgMiArKwo+ID4gICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJt
L2FtZGdwdV9kcm0uaCBiL2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaCBpbmRleAo+ID4gOWMzYmQx
OC4uODViYjcwMSAxMDA2NDQKPiA+IC0tLSBhL2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaAo+ID4g
KysrIGIvaW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oCj4gPiBAQCAtNzY3LDYgKzc2Nyw4IEBAIHN0
cnVjdCBkcm1fYW1kZ3B1X2luZm9fZGV2aWNlIHsKPiA+ICAgCXVpbnQzMl90IHZyYW1fYml0X3dp
ZHRoOwo+ID4gICAJLyogdmNlIGhhcnZlc3RpbmcgaW5zdGFuY2UgKi8KPiA+ICAgCXVpbnQzMl90
IHZjZV9oYXJ2ZXN0X2NvbmZpZzsKPiA+ICsJLyogZ2Z4IGRvdWJsZSBvZmZjaGlwIExEUyBidWZm
ZXJzICovCj4gPiArCXVpbnQzMl90IGdjX2RvdWJsZV9vZmZjaGlwX2xkc19idWY7Cj4gPiAgIH07
Cj4gPgo+ID4gICBzdHJ1Y3QgZHJtX2FtZGdwdV9pbmZvX2h3X2lwIHsKPiAKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
