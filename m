From: Harry Wentland <hwentlan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Fix typo in some comments
Date: Mon, 7 Oct 2019 14:13:44 +0000
Message-ID: <04e006aa-a354-dfe3-3d13-d674c662c300@amd.com>
References: <20191005113205.14601-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191005113205.14601-1-christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
Content-Language: en-US
Content-ID: <CEAFFC5EF80DCA4887F9FA2FF3BF475B-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Christophe JAILLET <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>, "daniel-/w4YWyX8dFk@public.gmane.org" <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: "kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

T24gMjAxOS0xMC0wNSA3OjMyIGEubS4sIENocmlzdG9waGUgSkFJTExFVCB3cm90ZToNCj4gcCBh
bmQgZyBhcmUgc3dpdGNoZWQgaW4gJ2FtZHBndV9kbScNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENo
cmlzdG9waGUgSkFJTExFVCA8Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI+DQoNClJldmll
d2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4NCg0KSGFycnkN
Cg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1
X2RtLmMgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2FtZGdwdV9kbS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtLmMNCj4gaW5kZXggOTI5MzJkNTIxZDdmLi5iOWMyZTFhOTMwYWIgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1
X2RtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRn
cHVfZG0uYw0KPiBAQCAtMTA0Myw3ICsxMDQzLDcgQEAgc3RhdGljIHZvaWQgczNfaGFuZGxlX21z
dChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBib29sIHN1c3BlbmQpDQo+ICANCj4gIC8qKg0KPiAg
ICogZG1faHdfaW5pdCgpIC0gSW5pdGlhbGl6ZSBEQyBkZXZpY2UNCj4gLSAqIEBoYW5kbGU6IFRo
ZSBiYXNlIGRyaXZlciBkZXZpY2UgY29udGFpbmluZyB0aGUgYW1kcGd1X2RtIGRldmljZS4NCj4g
KyAqIEBoYW5kbGU6IFRoZSBiYXNlIGRyaXZlciBkZXZpY2UgY29udGFpbmluZyB0aGUgYW1kZ3B1
X2RtIGRldmljZS4NCj4gICAqDQo+ICAgKiBJbml0aWFsaXplIHRoZSAmc3RydWN0IGFtZGdwdV9k
aXNwbGF5X21hbmFnZXIgZGV2aWNlLiBUaGlzIGludm9sdmVzIGNhbGxpbmcNCj4gICAqIHRoZSBp
bml0aWFsaXplcnMgb2YgZWFjaCBETSBjb21wb25lbnQsIHRoZW4gcG9wdWxhdGluZyB0aGUgc3Ry
dWN0IHdpdGggdGhlbS4NCj4gQEAgLTEwNzMsNyArMTA3Myw3IEBAIHN0YXRpYyBpbnQgZG1faHdf
aW5pdCh2b2lkICpoYW5kbGUpDQo+ICANCj4gIC8qKg0KPiAgICogZG1faHdfZmluaSgpIC0gVGVh
cmRvd24gREMgZGV2aWNlDQo+IC0gKiBAaGFuZGxlOiBUaGUgYmFzZSBkcml2ZXIgZGV2aWNlIGNv
bnRhaW5pbmcgdGhlIGFtZHBndV9kbSBkZXZpY2UuDQo+ICsgKiBAaGFuZGxlOiBUaGUgYmFzZSBk
cml2ZXIgZGV2aWNlIGNvbnRhaW5pbmcgdGhlIGFtZGdwdV9kbSBkZXZpY2UuDQo+ICAgKg0KPiAg
ICogVGVhcmRvd24gY29tcG9uZW50cyB3aXRoaW4gJnN0cnVjdCBhbWRncHVfZGlzcGxheV9tYW5h
Z2VyIHRoYXQgcmVxdWlyZQ0KPiAgICogY2xlYW51cC4gVGhpcyBpbnZvbHZlcyBjbGVhbmluZyB1
cCB0aGUgRFJNIGRldmljZSwgREMsIGFuZCBhbnkgbW9kdWxlcyB0aGF0DQo+IA0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
