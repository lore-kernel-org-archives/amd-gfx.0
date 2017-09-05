From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 5/6] drm/amdgpu: stop reserving the BO in the MMU callback
Date: Tue, 5 Sep 2017 17:26:38 -0400
Message-ID: <fbd6d201-a47d-557b-8112-aec466086fc2@amd.com>
References: <1504625871-1756-1-git-send-email-deathsimple@vodafone.de>
 <1504625871-1756-5-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1504625871-1756-5-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gMjAxNy0wOS0wNSAxMTozNyBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiArc3RydWN0
IGFtZGdwdV9tbiAqYW1kZ3B1X21uX2dldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikgeyBy
ZXR1cm4gTlVMTDsgfQo+ICBzdGF0aWMgaW5saW5lIGludCBhbWRncHVfbW5fcmVnaXN0ZXIoc3Ry
dWN0IGFtZGdwdV9ibyAqYm8sIHVuc2lnbmVkIGxvbmcgYWRkcikKPiAgewo+ICAJcmV0dXJuIC1F
Tk9ERVY7Cj4gIH0KPiAgc3RhdGljIGlubGluZSB2b2lkIGFtZGdwdV9tbl91bnJlZ2lzdGVyKHN0
cnVjdCBhbWRncHVfYm8gKmJvKSB7fQo+ICt2b2lkIGFtZGdwdV9tbl9sb2NrKHN0cnVjdCBhbWRn
cHVfbW4gKm1uKSB7fQo+ICt2b2lkIGFtZGdwdV9tbl91bmxvY2soc3RydWN0IGFtZGdwdV9tbiAq
bW4pIHt9ClRoZSBhZGRlZCBkdW1teSB1bmN0aW9ucyBoZXJlIHNob3VsZCBiZSBzdGF0aWMgaW5s
aW5lLgoKUmVnYXJkcywKICBGZWxpeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
