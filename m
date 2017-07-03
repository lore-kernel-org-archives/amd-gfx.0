From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH RFC 2/2] drm/amdgpu: Set/clear CPU_ACCESS flag on page
 fault and move to VRAM
Date: Mon, 3 Jul 2017 13:47:23 +0200
Message-ID: <bf62998e-0174-f714-9503-d99295213d8f@vodafone.de>
References: <160855e9-2517-ae04-fd9d-c638507109cd@daenzer.net>
 <1498835932-5053-1-git-send-email-john@fastquake.com>
 <1498835932-5053-3-git-send-email-john@fastquake.com>
 <4236c636-8b80-7088-6b55-8b9dee1c2b3f@vodafone.de>
 <3a28996f-2a7c-918c-6c39-65a25d4ea976@daenzer.net>
 <894e892e-3076-9f52-5dba-71ac135b7d61@vodafone.de>
 <45ae166f-70f5-d05e-a5bb-99429b3de063@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <45ae166f-70f5-d05e-a5bb-99429b3de063-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, John Brooks <john-xq/Ko7C6e2Bl57MIdRCFDg@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

QW0gMDMuMDcuMjAxNyB1bSAxMTo0OSBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+PiBJbnN0ZWFk
IG9mIG1lc3Npbmcgd2l0aCBhbGwgdGhpcyBJIHN1Z2dlc3QgdGhhdCB3ZSBqdXN0IGFkZCBhIGpp
ZmZpZXMKPj4gYmFzZWQgdGltZW91dCB0byB0aGUgQk8gd2hlbiB3ZSBjYW4gY2xlYXIgdGhlIGZs
YWcuIEZvciBrZXJuZWwgQk9zIHRoaXMKPj4gdGltZW91dCBpcyBqdXN0IGluZmluaXR5Lgo+Pgo+
PiBUaGVuIHdlIGNoZWNrIGluIGFtZGdwdV9jc19ib192YWxpZGF0ZSgpIGJlZm9yZSBnZW5lcmF0
aW5nIHRoZQo+PiBwbGFjZW1lbnRzIGlmIHdlIGNvdWxkIGNsZWFyIHRoZSBmbGFnIGFuZCBkbyBz
byBiYXNlZCBvbiB0aGUgdGltZW91dC4KPiBUaGUgaWRlYSBmb3IgdGhpcyBwYXRjaCB3YXMgdG8g
c2F2ZSB0aGUgbWVtb3J5IGFuZCBDUFUgY3ljbGVzIG5lZWRlZCBmb3IKPiB0aGF0IGFwcHJvYWNo
LgpCdXQgd2hlbiB3ZSBjbGVhciB0aGUgZmxhZyBvbiB0aGUgZW5kIG9mIHRoZSBtb3ZlIHdlIGFs
cmVhZHkgbW92ZWQgdGhlIApCTyB0byB2aXNpYmxlIFZSQU0gYWdhaW4uCgpPbmx5IG9uIGFmdGVy
IHRoZSBuZXh0IHN3YXBvdXQvc3dhcGluIGN5Y2xlIHdlIHNlZSBhbiBlZmZlY3Qgb2YgdGhhdCBj
aGFuZ2UuCgpJcyB0aGF0IHRoZSBpbnRlbmRlZCBhcHByb2FjaD8KClJlZ2FyZHMsCkNocmlzdGlh
bi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
