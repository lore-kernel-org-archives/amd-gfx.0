From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: How to gracefully handle pci remove
Date: Mon, 27 Aug 2018 12:04:55 -0400
Message-ID: <3460a3cb-91b9-3f3c-22af-d61b72a53454@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: ML dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SGkgZXZlcnlib2R5ICwgSSBhbSB0cnlpbmcgdG8gcmVzb2x2ZSB2YXJpb3VzIHByb2JsZW1zIEkg
b2JzZXJ2ZSB3aGVuIApsb2dpY2FsbHkgcmVtb3ZpbmcgQU1ER1BVIGRldmljZSBmcm9tIHBjaSAt
IGVjaG8gMSA+IAovc3lzL2NsYXNzL2RybS9jYXJkMC9kZXZpY2UvcmVtb3ZlCgpPbmUgb2YgdGhl
IHByb2JsZW1zIEkgZW5jb3VudGVyZWQgd2FzIGhpdHRpbmcgV0FSTnPCoCBpbiAKYW1kZ3B1X2dl
bV9mb3JjZV9yZWxlYXNlLiBJdCBjb21wbGFpbnRzwqAgYWJvdXQgc3RpbGwgb3BlbiBjbGllbnQg
RkRzIGFuZCAKQk9zIGFsbG9jYXRpb25zIHdoaWNoIGlzIG9idmlvdXMgc2luY2UKCndlIGRpZG4n
dCBsZXQgdXNlciBzcGFjZSBjbGllbnRzIGtub3cgYWJvdXQgdGhlIGRldmljZSByZW1vdmFsIGFu
ZCBoZW5jZSAKdGhleSB3b24ndCByZWxlYXNlIGFsbG9jYXRpb25zIGFuZCB3b24ndCBjbG9zZSB0
aGVpciBGRHMuCgpRdWVzdGlvbiAtIGhvdyBvdGhlciBkcml2ZXJzIGhhbmRsZSB0aGlzIHVzZSBj
YXNlLCBlc3BlY2lhbGx5IGVHUFVzIApzaW5jZSB0aGV5IGluZGVlZCBtYXkgYmUgZXh0cmFjdGVk
IGluIGFueSBtb21lbnQsIGlzIHRoZXJlIGFueSB3YXkgdG8gCm5vdGlmeSBYb3JnIGFuZCBvdGhl
ciBjbGllbnRzIGFib3V0IHRoaXMgc28gdGhleSBtYXkKCmhhdmUgYSBjaGFuY2UgdG8gcmVsZWFz
ZSBhbGwgdGhlaXIgYWxsb2NhdGlvbnMgYW5kIHByb2JhYmx5IHRlcm1pbmF0ZSA/IApNYXliZSBz
b21lIGtpbmQgb2YgdWV2ZW50ID8KCkFuZHJleQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
