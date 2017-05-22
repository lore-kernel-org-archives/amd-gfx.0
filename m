From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm: Harmonize CIK ASIC support in radeon and amdgpu (v2)
Date: Mon, 22 May 2017 16:56:50 +0900
Message-ID: <a57c1ef8-f47f-6ca5-68f5-1ee76ad4e7ab@daenzer.net>
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
 <eecf434d-54c0-6b6e-12db-4370249e5065@amd.com>
 <64dbb041-e331-6f0b-7373-b845bc239341@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <64dbb041-e331-6f0b-7373-b845bc239341-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjIvMDUvMTcgMTA6NTQgQU0sIE1pY2hlbCBEw6RuemVyIHdyb3RlOgo+IE9uIDIwLzA1LzE3
IDAzOjU1IEFNLCBGZWxpeCBLdWVobGluZyB3cm90ZToKPj4gT24gMTctMDUtMTggMDk6MTcgUE0s
IE1pY2hlbCBEw6RuemVyIHdyb3RlOgo+IAo+Pj4+PiBUaGUgZGVmYXVsdCBhdCB0aGlzIHBvaW50
IHNob3VsZCBwb3NzaWJseSBzdGlsbCBiZSBmb3IgQ0lLIEdQVXMgdG8gYmUKPj4+Pj4gZHJpdmVu
IGJ5IHJhZGVvbiwgZXZlbiBpZiBDT05GSUdfRFJNX0FNREdQVV9DSUsgaXMgZW5hYmxlZDsKPj4+
PiBBbGV4IGFuZCBDaHJpc3RpYW4gc2VlbSB0byB0aGluayBvdGhlcndpc2UuCj4+PiBGV0lXLCBv
biBteSBBTUQgbm90ZWJvb2sgKEhQIEVsaXRlQm9vayA3MjUgRzIsIEthdmVyaSksIHN1c3BlbmQv
cmVzdW1lCj4+PiB3aXRoIGFtZGdwdSByZXN1bHRzIGluIGEgYmxhY2sgc2NyZWVuIChjYW4gcmVi
b290IGJsaW5kbHkpOyB3b3JrcyBmaW5lCj4+PiB3aXRoIHJhZGVvbi4KPj4KPj4gSGFzIHRoaXMg
cHJvYmxlbSBiZWVuIHJlcG9ydGVkIGFueXdoZXJlPyBJcyBhbnlvbmUgd29ya2luZyBvbiBmaXhp
bmcgaXQ/Cj4+IElmIGl0J3Mgbm90IHJlcG9ydGVkLCBpdCB3aWxsIG5ldmVyIGJlIGZpeGVkLgo+
IAo+IFlvdSdyZSByaWdodCwgSSdsbCBmaWxlIGEgYnVnIHJlcG9ydC4KCkkgZ2V0IHRoZSBzYW1l
IGVycm9yIGxpbmVzIGFzIGRlc2NyaWJlZCBpbgpodHRwczovL2J1Z3MuZnJlZWRlc2t0b3Aub3Jn
LzEwMDk0OSwgSSdtIHRyeWluZyB0byBnZXQgY2xhcmlmaWNhdGlvbiBpZgppdCdzIHRoZSBzYW1l
IGJ1Zy4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAg
ICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAg
ICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
