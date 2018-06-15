From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Use kvmalloc_array for allocating VRAM
 manager nodes array
Date: Fri, 15 Jun 2018 17:17:03 +0200
Message-ID: <6013a7f5-0c5c-2786-dddf-c5028c17e5b5@amd.com>
References: <20180615142717.14475-1-michel@daenzer.net>
 <8be0b1bc-09aa-8ed1-7e2c-67a9f9802bdf@gmail.com>
 <317a26cc-93f7-0a7b-1004-a74f60d7ae57@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <317a26cc-93f7-0a7b-1004-a74f60d7ae57-otUistvHUpPR7s880joybQ@public.gmane.org>
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
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTUuMDYuMjAxOCB1bSAxNzoxMiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MDYtMTUgMDU6MDUgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDE1LjA2LjIwMTgg
dW0gMTY6Mjcgc2NocmllYiBNaWNoZWwgRMOkbnplcjoKPj4+IEZyb206IE1pY2hlbCBEw6RuemVy
IDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgo+Pj4KPj4+IEl0IGNhbiBiZSBxdWl0ZSBiaWcsIGFu
ZCB0aGVyZSdzIG5vIG5lZWQgZm9yIGl0IHRvIGJlIHBoeXNpY2FsbHkKPj4+IGNvbnRpZ3VvdXMu
IFRoaXMgaXMgbGVzcyBsaWtlbHkgdG8gZmFpbCB1bmRlciBtZW1vcnkgcHJlc3N1cmUgKGhhcwo+
Pj4gYWN0dWFsbHkgaGFwcGVuZWQgd2hpbGUgcnVubmluZyBwaWdsaXQpLgo+PiBNaG0sIHRoZSBs
YXN0IHRpbWUgSSBsb29rZWQgYSBkcm1fbW0gbm9kZSBoYWQgYXJvdW5kIDE2MCBieXRlcywgd2hp
Y2gKPj4gbWVhbnMgdGhhdCB5b3UgbmVlZCB0byBhbGxvY2F0ZSBtb3JlIHRoYW4gNTBNQiBvZiBW
UkFNIHRvIGZpbGwgdXAgYSA0Swo+PiBwYWdlLgo+IEknbSBhdHRhY2hpbmcgdGhlIGZhaWx1cmUg
dGhhdCBwcm9tcHRlZCBtZSB0byB3cml0ZSB0aGlzIHBhdGNoLiBJdCB3YXMKPiB0cnlpbmcgdG8g
YWxsb2NhdGUgb3JkZXIgNSwgaS5lLiBtb3JlIHRoYW4gMTYgcGFnZXMgLyA2NCBLQi4KCldvdywg
dGhhdCBtZWFucyBwaWdsaXQgaXMgYXQgc29tZSBwb2ludCBhbGxvY2F0aW5nIGEgdGV4dHVyZSBv
ZiBhdCBsZWFzdCAKODAwTUIuIFNvbWV0aGluZyB0byBrZWVwIGluIG1pbmQgd2hlbiBzaXppbmcg
c3R1ZmYgaW4gdGhlIE1NLgoKV2VsbCB0aGUgZXh0cmEgb3ZlcmhlYWQgaXMgbmVnbGlnaWJsZSBm
b3Igc21hbGwgYWxsb2NhdGlvbnMgYW5kIHRoZSB1c2UgCmNhc2Ugc291bmRzIHZhbGlkLgoKUGF0
Y2ggaXMgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4uCgpSZWdhcmRzLApDaHJpc3RpYW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
