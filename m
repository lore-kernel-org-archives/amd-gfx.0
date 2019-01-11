From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/ttm: stop always moving BOs on the LRU on page fault
Date: Fri, 11 Jan 2019 20:12:50 +0100
Message-ID: <810303e7-d1bd-1e04-4e73-33d8202b2a05@gmail.com>
References: <20190111131525.1269-1-christian.koenig@amd.com>
 <ed9615c4-99be-c690-6ea0-bbe3e107bab3@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ed9615c4-99be-c690-6ea0-bbe3e107bab3-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTEuMDEuMTkgdW0gMTU6MTcgc2NocmllYiBNaWNoZWwgRMOkbnplcjoKPiBPbiAyMDE5LTAx
LTExIDI6MTUgcC5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gTW92ZSB0aGUgQk8gb24g
dGhlIExSVSBvbmx5IHdoZW4gaXQgaXMgYWN0dWFsbHkgbW92ZWQgYnkgYSBETUEKPj4gb3BlcmF0
aW9uLgo+Pgo+PiBbLi4uXQo+Pgo+PiBAQCAtMTc3LDYgKzE3NSwxMyBAQCBzdGF0aWMgdm1fZmF1
bHRfdCB0dG1fYm9fdm1fZmF1bHQoc3RydWN0IHZtX2ZhdWx0ICp2bWYpCj4+ICAgCQkJcmV0ID0g
Vk1fRkFVTFRfU0lHQlVTOwo+PiAgIAkJCWdvdG8gb3V0X3VubG9jazsKPj4gICAJCX0KPj4gKwo+
PiArCQlpZiAoYm8tPm1vdmluZyAhPSBtb3ZpbmcpIHsKPiBIbW0sIGNvdWxkIGEgZHJpdmVyIGp1
c3QgdXBkYXRlIHRoZSBleGlzdGluZyBmZW5jZSBpbnN0ZWFkIG9mIGF0dGFjaGluZwo+IGEgbmV3
IG9uZT8KCk1obSwgbm90IGFzIGZhciBhcyBJIGtub3cuIFRoYXQgd291bGQgdmlvbGF0ZSBzaW1p
bGFyIGNoZWNrcyBlbHNld2hlcmUuCgpDaHJpc3RpYW4uCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
