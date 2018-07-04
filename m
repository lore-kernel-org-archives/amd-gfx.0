From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Reserve fence slots for command submission
Date: Wed, 4 Jul 2018 15:57:26 +0800
Message-ID: <5B3C7DE6.3020405@amd.com>
References: <1530673358-20219-1-git-send-email-Jerry.Zhang@amd.com>
 <e6385817-e437-e5de-0297-a6af16648a2c@gmail.com> <5B3C6F7B.80901@amd.com>
 <9fd5d981-3725-289b-94ff-73da521e3061@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <9fd5d981-3725-289b-94ff-73da521e3061-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDcvMDQvMjAxOCAwMzoyMSBQTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gT24gMjAxOC0w
Ny0wNCAwODo1NSBBTSwgWmhhbmcsIEplcnJ5IChKdW53ZWkpIHdyb3RlOgo+PiBPbiAwNy8wNC8y
MDE4IDAyOjM0IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4gQW0gMDQuMDcuMjAxOCB1
bSAwNTowMiBzY2hyaWViIEp1bndlaSBaaGFuZzoKPj4+PiBGcm9tOiBNaWNoZWwgRMOkbnplciA8
bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KPj4+Pgo+Pj4+IFdpdGhvdXQgdGhpcywgdGhlcmUgY291
bGQgbm90IGJlIGVub3VnaCBzbG90cywgd2hpY2ggY291bGQgdHJpZ2dlciB0aGUKPj4+PiBCVUdf
T04gaW4gcmVzZXJ2YXRpb25fb2JqZWN0X2FkZF9zaGFyZWRfZmVuY2UuCj4+Pj4KPj4+PiB2MjoK
Pj4+PiAqIEp1bXAgdG8gdGhlIGVycm9yIGxhYmVsIGluc3RlYWQgb2YgcmV0dXJuaW5nIGRpcmVj
dGx5IChKZXJyeSBaaGFuZykKPj4+PiB2MzoKPj4+PiAqIFJlc2VydmUgc2xvdHMgZm9yIGNvbW1h
bmQgc3VibWlzc2lvbiBhZnRlciBWTSB1cGRhdGVzIChDaHJpc3RpYW4KPj4+PiBLw7ZuaWcpCj4+
Pj4KPj4+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+Pj4+IEJ1Z3ppbGxhOiBodHRwczov
L2J1Z3MuZnJlZWRlc2t0b3Aub3JnLzEwNjQxOAo+Pj4+IFJlcG9ydGVkLWJ5OiBtaWtoYWlsLnYu
Z2F2cmlsb3ZAZ21haWwuY29tCj4+Pj4gU2lnbmVkLW9mZi1ieTogTWljaGVsIETDpG56ZXIgPG1p
Y2hlbC5kYWVuemVyQGFtZC5jb20+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogSnVud2VpIFpoYW5nIDxK
ZXJyeS5aaGFuZ0BhbWQuY29tPgo+Pj4KPj4+IEkgd291bGQgcHV0IHRoYXQgYXQgdGhlIGVuZCBv
ZiBhbWRncHVfYm9fdm1fdXBkYXRlX3B0ZSgpLCBidXQgdGhhdCBpcwo+Pj4gb25seSBhIG1pbm9y
IG5pdCBwaWNrLgo+Pgo+PiBBdCBmaXJzdCwgSSByZWFsbHkgcHV0IGl0IGF0IHRoZSBlbmQgb2Yg
YW1kZ3B1X2JvX3ZtX3VwZGF0ZV9wdGUoKS4KPj4gT24gdGhlIDJuZCB0aG91Z2h0LCB0aGF0IGZ1
bmMgbWF5IGJlIGNhbGxlZCBieSBvdGhlcnMoYWx0aG91Z2ggaXQncyBub3QKPj4gZm9yIG5vdyks
IHNvIEkgbW92ZSBpdCBvdXQgb2YgdGhlcmUgdG8gdGhlIGNhbGxlci4KPgo+IE1ha2VzIHNlbnNl
IHRvIG1lLCBGV0lXLiBUaGFua3MgSnVud2VpIGFuZCBDaHJpc3RpYW4hCgpQbGVhc2UgY29uZmly
bSBpZiB0aGF0IHdvcmtzIGluIHlvdXIgc2lkZS4KSWYgeWVzLCBJIHdvdWxkIHB1c2ggdGhhdCB0
byBkcm0tbmV4dCB0aGVuLgoKVGhhbmtzLgoKSmVycnkKCj4KPgo+IFAuUy4gQ2hyaXN0aWFuLCBh
bnkgZmVlZGJhY2sgb24KPiBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvcGF0Y2gv
MjMyMjA0LyA/Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
