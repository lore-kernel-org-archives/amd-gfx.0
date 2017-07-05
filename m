From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 07/11] drm/amdgpu: rename GART to SYSVM
Date: Wed, 5 Jul 2017 09:57:19 +0900
Message-ID: <06b47744-60a4-f79e-e120-60d7bcff8526@daenzer.net>
References: <1499075076-1851-1-git-send-email-deathsimple@vodafone.de>
 <1499075076-1851-7-git-send-email-deathsimple@vodafone.de>
 <61109920-9d05-cb27-67b3-51a1b46b15bc@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <61109920-9d05-cb27-67b3-51a1b46b15bc-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDUvMDcvMTcgMDY6MTEgQU0sIEZlbGl4IEt1ZWhsaW5nIHdyb3RlOgo+IEknbSBhZnJhaWQg
dGhpcyB3aWxsIGxlYWQgdG8gbW9yZSBjb25mdXNpb24gd2hlbiB0YWxraW5nIHRvIGRpZmZlcmVu
dAo+IHRlYW1zIGluIEFNRC4gQXQgbGVhc3QgdG8gbWUgIkdBUlQiIHdhcyBhbHdheXMgdW5kZXJz
dG9vZCB0byBiZSB0aGUKPiBzeXN0ZW0td2lkZSBhZGRyZXNzIHRyYW5zbGF0aW9uIHRhYmxlIChW
TUlELTApLiBUaGUgcmVtbmFudCBmcm9tIHRoZQo+IHByZS1HUFVWTSBkYXlzLiBZb3UncmUgbm93
IGNhbGxpbmcgdGhhdCBTWVNWTSwgd2hpbGUgYWxsIEdQVS1hY2Nlc3NpYmxlCj4gc3lzdGVtIG1l
bW9yeSBpcyBzdGlsbCBjYWxsZWQgR1RULgo+IAo+IEkgdGhpbmsgaXQgd291bGQgbWFrZSBtb3Jl
IHNlbnNlIHRvIGNhbGwgZ2VuZXJhbCBHUFUtbWFwcGVkIHN5c3RlbQo+IG1lbW9yeSAiU1lTVk0i
IG9yICJHUFVWTSIsIGFuZCBvbmx5IGNhbGwgdGhlIGdsb2JhbCBWTUlELTAgcGFnZSB0YWJsZQo+
ICJHQVJUIi4KPiAKPiBCdXQgb2YgY291cnNlIHRoYXQgd291bGQgcmVxdWlyZSBjaGFuZ2VzIGlu
IFRUTSBhbmQgYWxsIFRUTSBkcml2ZXJzLCBzbwo+IGl0J3Mgbm90IGEgcmVhbGlzdGljIG9wdGlv
bi4KCkZXSVcsIHRoZSBzdHJpbmcgIkdBUlQiIGRvZXNuJ3QgYXBwZWFyIGFueXdoZXJlIGluIFRU
TSwgc28gSSB0aGluayB5b3VyCmlkZWEgaXMgZmVhc2libGUuCgoKLS0gCkVhcnRobGluZyBNaWNo
ZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5j
b20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1l
c2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
