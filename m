From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: enable huge page handling in the VM v4
Date: Mon, 17 Jul 2017 23:31:52 +0200
Message-ID: <35d8abc4-78f8-017c-dbce-c70a151af9c1@vodafone.de>
References: <1500325342-26253-1-git-send-email-deathsimple@vodafone.de>
 <1500325342-26253-2-git-send-email-deathsimple@vodafone.de>
 <c2b1e857-67c1-fd51-adf4-c4f84ea37368@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c2b1e857-67c1-fd51-adf4-c4f84ea37368-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTcuMDcuMjAxNyB1bSAyMzozMCBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+IE9uIDE3LTA3
LTE3IDA1OjAyIFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiArCWlmIChwLT5hZGV2LT5h
c2ljX3R5cGUgPCBDSElQX1ZFR0ExMCB8fAo+PiArCSAgICBucHRlcyAhPSBBTURHUFVfVk1fUFRF
X0NPVU5UKHAtPmFkZXYpIHx8Cj4+ICsJICAgIHAtPmZ1bmMgIT0gYW1kZ3B1X3ZtX2RvX3NldF9w
dGVzIHx8Cj4+ICsJICAgICEoZmxhZ3MgJiBBTURHUFVfUFRFX1ZBTElEKSkgewo+IEJlY2F1c2Ug
b2YgdGhpcyBjb25kaXRpb24sIEkgdGhpbmsgdGhpcyBzdGlsbCB3b24ndCB3b3JrIGNvcnJlY3Rs
eSBmb3IKPiBjcHUgcGFnZSB0YWJsZSB1cGRhdGVzLiBwLT5mdW5jIHdpbGwgYmUgYW1kZ3B1X3Zt
X2NwdV9zZXRfcHRlcy4KCkdvb2QgcG9pbnQuCgpUaGlzIGlzIHRvdGFsbHkgdW50ZXN0ZWQgYW55
d2F5LCBiZWNhdXNlIG9mIGxhY2sgb2YgaGFyZHdhcmUgYWNjZXNzIGF0IAp0aGUgbW9tZW50LgoK
SnVzdCB3YW50ZWQgdG8gcG9pbnQgeW91IHRvIHRoZSBiaXRzIEkndmUgY2hhbmdlZCBmb3IgdGVz
dGluZyBpdC4KCkNocmlzdGlhbi4KCj4KPiBSZWdhcmRzLAo+ICAgIEZlbGl4Cj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcg
bGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
