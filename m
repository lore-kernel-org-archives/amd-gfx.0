From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm: Harmonize CIK ASIC support in radeon and amdgpu (v2)
Date: Fri, 19 May 2017 14:55:19 -0400
Message-ID: <eecf434d-54c0-6b6e-12db-4370249e5065@amd.com>
References: <1491866474-1016-1-git-send-email-Felix.Kuehling@amd.com>
 <ac35e641-6fd9-a5d1-c4d9-35e71fa9eb08@daenzer.net>
 <cbcc54ec-c86f-f0eb-715e-f66790b5f964@amd.com>
 <340a5310-e6d1-5e09-81aa-d7106bcdca02@daenzer.net>
 <dedfed15-00b3-83ff-aca7-f4dffff8cc09@amd.com>
 <4bd2c7cf-a555-6cee-a863-b56ee824f9ad@daenzer.net>
 <f2f87cd4-c6c5-7c62-3035-d2f1584d7f00@amd.com>
 <cebca833-9e3f-86c5-8100-feca6ea590e5@daenzer.net>
 <588f3a43-3f29-e733-1ffd-154878303f0f@amd.com>
 <04fb5e39-c951-d58f-97c7-eedb604624fd@daenzer.net>
 <f28b5760-4751-4f88-b62f-8c73a1df61f9@amd.com>
 <fe21a443-161f-631a-12dd-84faabfc2f88@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <fe21a443-161f-631a-12dd-84faabfc2f88-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

Ck9uIDE3LTA1LTE4IDA5OjE3IFBNLCBNaWNoZWwgRMOkbnplciB3cm90ZToKPiBPYnZpb3VzbHks
IG91dC1vZi10cmVlIG1vZHVsZSBidWlsZHMgd2lsbCBoYXZlIHRvIGNvbnRpbnVlIGRvaW5nIHdo
YXQKPiB0aGV5J3ZlIGJlZW4gZG9pbmcgc28gZmFyIHdpdGgga2VybmVscyB3aXRob3V0IHlvdXIg
cGF0Y2guIEknbSB0aGlua2luZwo+IGFib3V0IG1ha2luZyBpdCBlYXNpZXIgZm9yIHRoZW0gd2l0
aCBrZXJuZWxzIHdoaWNoIGRvIGhhdmUgeW91ciBwYXRjaC4KPiBBdCBzb21lIHBvaW50IGluIHRo
ZSBmdXR1cmUsIG1heWJlIHRoZSBzdXBwb3J0IGZvciBrZXJuZWxzIHdpdGhvdXQgeW91cgo+IHBh
dGNoIGNhbiBiZSBkcm9wcGVkIGVudGlyZWx5LgoKSSB0aGluayBvdXQtb2YtdHJlZSBidWlsZHMg
dXNpbmcgdGhlIENPTkZJR19BTURHUFVfQ0lLIG9wdGlvbiBvZiB0aGUKdGFyZ2V0IGtlcm5lbCBp
cyBub3Qgc2FmZS4gSHlicmlkIHNob3VsZCB1c2UgaXRzIG93biBvcHRpb24gdGhhdCBpcwpkZXRl
cm1pbmVkIGJ5IHdoYXQgdGhlIGh5YnJpZCBzdGFjayBzdXBwb3J0cyAoa2VybmVsIGFuZCB1c2Vy
IG1vZGUpLgoKPgo+Cj4+PiBUaGUgZGVmYXVsdCBhdCB0aGlzIHBvaW50IHNob3VsZCBwb3NzaWJs
eSBzdGlsbCBiZSBmb3IgQ0lLIEdQVXMgdG8gYmUKPj4+IGRyaXZlbiBieSByYWRlb24sIGV2ZW4g
aWYgQ09ORklHX0RSTV9BTURHUFVfQ0lLIGlzIGVuYWJsZWQ7Cj4+IEFsZXggYW5kIENocmlzdGlh
biBzZWVtIHRvIHRoaW5rIG90aGVyd2lzZS4KPiBGV0lXLCBvbiBteSBBTUQgbm90ZWJvb2sgKEhQ
IEVsaXRlQm9vayA3MjUgRzIsIEthdmVyaSksIHN1c3BlbmQvcmVzdW1lCj4gd2l0aCBhbWRncHUg
cmVzdWx0cyBpbiBhIGJsYWNrIHNjcmVlbiAoY2FuIHJlYm9vdCBibGluZGx5KTsgd29ya3MgZmlu
ZQo+IHdpdGggcmFkZW9uLgoKSGFzIHRoaXMgcHJvYmxlbSBiZWVuIHJlcG9ydGVkIGFueXdoZXJl
PyBJcyBhbnlvbmUgd29ya2luZyBvbiBmaXhpbmcgaXQ/CklmIGl0J3Mgbm90IHJlcG9ydGVkLCBp
dCB3aWxsIG5ldmVyIGJlIGZpeGVkLgoKUmVnYXJkcywKICBGZWxpeAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
