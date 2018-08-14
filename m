From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] [v3] drm: amd: dc: don't use FP math when Kcov is enabled
Date: Tue, 14 Aug 2018 11:17:23 +0200
Message-ID: <4bc1c021-e976-03f7-c442-f7ca9804516a@amd.com>
References: <20180811155554.3382650-1-arnd@arndb.de>
 <593dd8e1-fa23-3216-3550-274401d88bcb@gmail.com>
 <CADnq5_PCyKb72-BjFG3B4p_+bctNKoswAibw8C687_fpystSJA@mail.gmail.com>
 <CAK8P3a1AGC4fFYSSDQn2snkvf5htZVffCwRLV1NBm5YeZgw+CA@mail.gmail.com>
 <632dceb6-27e5-869b-46a9-6b11944204fc@daenzer.net>
 <CAK8P3a3fDOeNWsmtXRHOF5cAMit7AMt7fS_54m7NXN0AjZYbPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAK8P3a3fDOeNWsmtXRHOF5cAMit7AMt7fS_54m7NXN0AjZYbPw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, michel-otUistvHUpPR7s880joybQ@public.gmane.org
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Shirish S <shirish.s-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Jerry.Zuo-5C7GfCeVMHo@public.gmane.org, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Harry Wentland <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

QW0gMTQuMDguMjAxOCB1bSAxMToxNSBzY2hyaWViIEFybmQgQmVyZ21hbm46Cj4gT24gVHVlLCBB
dWcgMTQsIDIwMTggYXQgMTA6NTQgQU0gTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVuemVyLm5l
dD4gd3JvdGU6Cj4+IE9uIDIwMTgtMDgtMTMgMDU6MjMgUE0sIEFybmQgQmVyZ21hbm4gd3JvdGU6
Cj4+PiBPbiBNb24sIEF1ZyAxMywgMjAxOCBhdCA0OjQ5IFBNIEFsZXggRGV1Y2hlciA8YWxleGRl
dWNoZXJAZ21haWwuY29tPiB3cm90ZToKPj4+PiBPbiBTdW4sIEF1ZyAxMiwgMjAxOCBhdCAzOjU1
IEFNIENocmlzdGlhbiBLw7ZuaWcKPj4+PiA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5j
b20+IHdyb3RlOgo+Pj4+PiBBZGRpbmcgSGFycnkgYXMgd2VsbC4KPj4+Pj4gQW0gMTEuMDguMjAx
OCB1bSAxNzo1NCBzY2hyaWViIEFybmQgQmVyZ21hbm46Cj4+Pj4+PiBGaXhlczogYmYyZTJlMmUw
ZWE5ICgiZHJtL2FtZC9kaXNwbGF5OiBMaW1pdCBEQ04gdG8geDg2IGFyY2giKQo+Pj4+Pj4gRml4
ZXM6IDQ4NDEyMDMxMDJhMyAoImRybS9hbWRncHUvZGlzcGxheTogUmVwbGFjZSBDT05GSUdfRFJN
X0FNRF9EQ19EQ04xXzAgd2l0aCBDT05GSUdfWDg2IikKPj4+PiBNYXliZSBpdCB3b3VsZCBiZSBi
ZXR0ZXIgdG8gcmV2ZXJ0IDQ4NDEyMDMxMDJhMyBzbyB3ZSBjYW4gbGltaXQgdGhlCj4+Pj4gc2Nv
cGUgb2YgdGhpcyB0byBEQ04gc3VwcG9ydC4KPj4+IFRoYXQgd291bGQgaGVscCwgYnV0IHdlIHdv
dWxkIHN0aWxsIHJlcXVpcmUgdGhlIHBhdGNoIGF0Cj4+PiBodHRwczovL3BhdGNod29yay5rZXJu
ZWwub3JnL3BhdGNoLzEwMDkwMjI3LyBvciBzb21ldGhpbmcgZWxzZSB0byBhdm9pZAo+Pj4gYnJv
a2VuIHJhbmRjb25maWcgYnVpbGRzLgo+PiBGV0lXLCBwbGVhc2UgZG9uJ3QgcmV2ZXJ0IDQ4NDEy
MDMxMDJhMyBpbiBhIHdheSB3aGljaCBhbGxvd3MKPj4gQ09ORklHX0RSTV9BTURfRENfRENOMV8w
IHRvIGJlIGFjY2lkZW50YWxseSBkaXNhYmxlZCBvbiBYODYgYWdhaW4uIElmIGl0Cj4+IGlzIHJl
aW5zdGF0ZWQsIGl0IHNob3VsZCBiZSBzdHJpY3RseSBkZXJpdmVkIGZyb20gb3RoZXIgb3B0aW9u
cywgbm90Cj4+IGNoYW5nZWFibGUgYnkgdGhlIHVzZXIuCj4gSG93IGFib3V0IG1ha2luZyBhbGwg
b2YgQU1ER1BVIGRlcGVuZCBvbgo+ICIgIShLQ09WX0lOU1RSVU1FTlRfQUxMICYmIEtDT1ZfRU5B
QkxFX0NPTVBBUklTT05TKSB8fCBCUk9LRU4iCj4gdGhlbj8KCldlbGwsIGNlcnRhaW5seSBub3Qg
YSBnb29kIGlkZWEuCgpXZSBkb24ndCB3YW50IHRvIGRpc2FibGUgdGhlIHdob2xlIGRyaXZlciBq
dXN0IGJlY2F1c2Ugb25lIGJyb2tlbiBjb21wb25lbnQuCgpDaHJpc3RpYW4uCgo+Cj4gICAgICAg
QXJuZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
