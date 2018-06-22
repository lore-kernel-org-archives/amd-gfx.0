From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: GPU vs CPU page size fixes in
 amdgpu_vm_bo_split_mapping
Date: Fri, 22 Jun 2018 16:57:50 +0200
Message-ID: <e2fc70ce-b347-dc17-5de5-fa729da49aba@gmail.com>
References: <20180622091035.4119-1-michel@daenzer.net>
 <a2824504-f765-251c-5adb-dda69ecc9ca7@gmail.com>
 <a3a30887-bb0e-1d90-69ca-21fac8f35b62@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a3a30887-bb0e-1d90-69ca-21fac8f35b62-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjIuMDYuMjAxOCB1bSAxNjoxMiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MDYtMjIgMTI6MzQgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDIyLjA2LjIwMTgg
dW0gMTE6MTAgc2NocmllYiBNaWNoZWwgRMOkbnplcjoKPj4+IEZyb206IE1pY2hlbCBEw6RuemVy
IDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgo+Pj4KPj4+IHN0YXJ0IC8gbGFzdCAvIG1heF9lbnRy
aWVzIGFyZSBudW1iZXJzIG9mIEdQVSBwYWdlcywgcGZuIC8gY291bnQgYXJlCj4+PiBudW1iZXJz
IG9mIENQVSBwYWdlcy4gQ29udmVydCBiZXR3ZWVuIHRoZW0gYWNjb3JkaW5nbHkuCj4+Pgo+Pj4g
Rml4ZXMgYmFkbmVzcyBvbiBzeXN0ZW1zIHdpdGggPiA0SyBwYWdlIHNpemUuCj4+Pgo+Pj4gQ2M6
IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPj4+IEJ1Z3ppbGxhOiBodHRwczovL2J1Z3MuZnJlZWRl
c2t0b3Aub3JnL3Nob3dfYnVnLmNnaT9pZD0xMDYyNTgKPj4+IFJlcG9ydGVkLWJ5OiBNYXR0IENv
cmFsbG8gPGZyZWVkZXNrdG9wQGJsdWVtYXR0Lm1lPgo+Pj4gVGVzdGVkLWJ5OiBmb3hiYXRAcnVp
bi5uZXQKPj4+IFNpZ25lZC1vZmYtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBh
bWQuY29tPgo+PiBOaWNlIHdvcmshCj4gVGhhbmtzLgo+Cj4KPj4gSnVzdCBvbmUgY29tbWVudDog
Q2FuIHdlIHNvbWV3aGVyZSBhZGQgYSBkZWZpbmUgZm9yCj4+ICIoUEFHRV9TSVpFIC8gQU1ER1BV
X0dQVV9QQUdFX1NJWkUpIj8KPj4KPj4gSUlSQyB0aGF0IHRlcm0gd2FzIHVzZWQgaW4gdGhlIEdB
UlQgY29kZSBhcyB3ZWxsIGFuZCBqdXN0IGFkZGluZyBpdAo+PiBzb21ld2hlcmUgY291bGQgbWFr
ZXMgdGhpbmdzIGNsZWFuZXIgaWYgeW91IGFzayBtZS4KPiBTdXJlLCBidXQgdGhhdCBjYW4gYmUg
YSBmb2xsb3ctdXAgcGF0Y2gsIHJpZ2h0Pwo+Cj4gQ2FuIEkgZ2V0IHlvdXIgUi1iIGZvciB0aGlz
IG9uZT8KCkNlcnRhaW5seSwgcGF0Y2ggaXMgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4uCgpUaGFua3MsCkNocmlzdGlhbi4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
