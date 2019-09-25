From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: Add modeset module option
Date: Wed, 25 Sep 2019 18:07:38 +1000
Message-ID: <CAPM=9txseCB_0msp2_WoOAoi0iCRCoLsFgcqppiTyw+tD1Qe8A@mail.gmail.com>
References: <20180330204512.16863-1-tiwai@suse.de>
 <20180330204512.16863-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180330204512.16863-2-tiwai-l3A5Bk7waGM@public.gmane.org>
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
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: David Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gU2F0LCAzMSBNYXIgMjAxOCBhdCAwNjo0NSwgVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRl
PiB3cm90ZToKPgo+IGFtZGdwdSBkcml2ZXIgbGFja3Mgb2YgbW9kZXNldCBtb2R1bGUgb3B0aW9u
IG90aGVyIGRybSBkcml2ZXJzIHByb3ZpZGUKPiBmb3IgZW5mb3JjaW5nIG9yIGRpc2FibGluZyB0
aGUgZHJpdmVyIGxvYWQuICBJbnRlcmVzdGluZ2x5LCB0aGUKPiBhbWRncHVfbW9kZSB2YXJpYWJs
ZSBkZWNsYXJhdGlvbiBpcyBhbHJlYWR5IGZvdW5kIGluIHRoZSBoZWFkZXIgZmlsZSwKPiBidXQg
dGhlIGFjdHVhbCBpbXBsZW1lbnRhdGlvbiBzZWVtcyB0byBoYXZlIGJlZW4gZm9yZ290dGVuLgo+
Cj4gVGhpcyBwYXRjaCBhZGRzIHRoZSBtaXNzaW5nIHBpZWNlLgoKSSdkIGxpa2UgdG8gbGFuZCB0
aGlzIHBhdGNoLCBJIHJlYWxpc2UgcGVvcGxlIGhhdmUgTkFLZWQgaXQgYnV0IGZvcgpjb25zaXN0
ZW5jeSBhY3Jvc3MgZHJpdmVycyBJJ20gZ29pbmcgdG8gYXNrIHdlIGxhbmQgaXQgb3Igc29tZXRo
aW5nCmxpa2UgaXQuCgpUaGUgbWFpbiB1c2UgY2FzZSBmb3IgdGhpcyBpcyBhY3R1YWxseSB3aGVy
ZSB5b3UgaGF2ZSBhbWRncHUgY3Jhc2hlcwpvbiBsb2FkLCBhbmQgeW91IHdhbnQgdG8gZGVidWcg
dGhlbSwgcGVvcGxlIGJvb3Qgd2l0aCBub21vZGVzZXQgYW5kCnRoZW4gbW9kcHJvYmUgYW1kZ3B1
IG1vZGVzZXQ9MSB0byBnZXQgdGhlIGNyYXNoIGluIGEgcnVubmluZyBzeXN0ZW0uClRoaXMgd29y
a3MgZm9yIG51bWVyb3VzIG90aGVyIGRyaXZlcnMsIEknbSBub3Qgc3VyZSB3aHkgYW1kZ3B1IG5l
ZWRzCnRvIGJlIHRoZSBvZGQgb25lIG91dC4KClJldmlld2VkLWJ5OiBEYXZlIEFpcmxpZSA8YWly
bGllZEByZWRoYXQuY29tPgoKRGF2ZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
