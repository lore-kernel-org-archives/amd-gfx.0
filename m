From: Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: KASAN caught amdgpu / HMM use-after-free
Date: Wed, 27 Feb 2019 12:24:50 -0500
Message-ID: <20190227172450.GB3296@redhat.com>
References: <e8466985-a66b-468b-5fff-6e743180da67@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e8466985-a66b-468b-5fff-6e743180da67-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: Philip Yang <Philip.Yang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org

T24gV2VkLCBGZWIgMjcsIDIwMTkgYXQgMDY6MDI6NDlQTSArMDEwMCwgTWljaGVsIETDpG56ZXIg
d3JvdGU6Cj4gCj4gU2VlIHRoZSBhdHRhY2hlZCBkbWVzZyBleGNlcnB0LiBJJ3ZlIGhpdCB0aGlz
IGEgZmV3IHRpbWVzIHJ1bm5pbmcgcGlnbGl0Cj4gd2l0aCBhbWQtc3RhZ2luZy1kcm0tbmV4dCwg
Zmlyc3Qgb24gRmVicnVhcnkgMjJuZC4KPiAKPiBUaGUgbWVtb3J5IHdhcyBmcmVlZCBhZnRlciBj
YWxsaW5nIGhtbV9taXJyb3JfdW5yZWdpc3RlciBpbgo+IGFtZGdwdV9tbl9kZXN0cm95LgoKU28g
dGhhdCBicmFuY2ggaXMgbm90IHVzaW5nIHRoZSBITU0gY2hhbmdlcyBxdWV1ZSB1cCBmb3IgNS4x
IGFuZCB0aHVzCndoYXQgeW91IGFyZSBkb2luZyBpcyBzb21ld2hhdCBpbGxlZ2FsLiBJbiA1LjEg
Y2hhbmdlcyBhbGwgaXMgcmVmY291bnRlZAphbmQgdGhpcyBidWcgc2hvdWxkIG5vdCBiZSBhYmxl
IHRvIGhhcHBlbi4gU28gaWYgeW91IHJlYmFzZSB5b3VyIHdvcmsKb24gdG9wIG9mIAoKaHR0cHM6
Ly9jZ2l0LmZyZWVkZXNrdG9wLm9yZy9+Z2xpc3NlL2xpbnV4L2xvZy8/aD1obW0tZm9yLTUuMQoK
T3IgbGludXgtbmV4dCAoaSBiZWxpZXZlIGkgc2F3IHRob3NlIGJpdHMgaW4gbGludXgtbmV4dCkg
dGhlbiB0aGlzCmVycm9yIHdpbGwgdmFuaXNoLiBTb3JyeSBpZiB0aGVyZSB3YXMgY29uZnVzaW9u
IGJldHdlZW4gd2hhdCBpcyBsZWdhbApub3cgYW5kIHdoYXQgaXMgbGVnYWwgdG9tbW9ycm93IDop
CgpDaGVlcnMsCkrDqXLDtG1lCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA==
