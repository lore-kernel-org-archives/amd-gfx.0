From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Deadlocks with multiple applications on AMD RX 460 and RX 550 -
 Update 2
Date: Wed, 31 Jan 2018 21:30:53 -0500
Message-ID: <CADnq5_NPWa5s+dJwinBFLTzcGfycuuuin_YFp7CJnt_8A2p9eA@mail.gmail.com>
References: <CAEzXK1o+FewfiG84pCj8c_1Xz5KVsOOU7EX13LWaFVxK7s66fg@mail.gmail.com>
 <1ca083a5-f33c-7be0-a3c8-c2996a087f70@amd.com>
 <CAEzXK1odkDX-D3MOGHLFJuKNHh0RjSfsFL8PtB=6YQRDf1+Tkw@mail.gmail.com>
 <d755cd12-1a1e-ce98-2b0d-ea4b5eafc483@amd.com>
 <CAEzXK1qCfnHUvnuuViTP5fZQx2StjecV6o_QfJ2uJk603_9nhA@mail.gmail.com>
 <CAEzXK1oUyHsSGHeXS9qzWBSDL-FfRq2h-EiQMCfa=5BroO50gg@mail.gmail.com>
 <8bcdc933-050b-12ca-46e6-54bb66b6824d@gmail.com>
 <CAEzXK1pPzRM=EpL8fKQ5SdDvEePR+_KPhrtPMPiArt==BsJspA@mail.gmail.com>
 <99a9e27e-f166-f969-416f-f128b0673388@daenzer.net>
 <CAEzXK1rb6ngg=3MHo6yT+ed-a_1xr3ASwLPtsK4CpSMBk3xKgw@mail.gmail.com>
 <CAEzXK1qFh-Y6zCoVpRVRcLEe_hLFueqntrjaAwgfKyLGd2u27A@mail.gmail.com>
 <CAEzXK1rixP9spSTBY4V5GWxyUWJdf23Nbis2gbKgfxz4A6w2rQ@mail.gmail.com>
 <BN6PR12MB1652E01048ABD6A307E80B8DF7E40@BN6PR12MB1652.namprd12.prod.outlook.com>
 <CAEzXK1rbmaNifg00RY+GPdUgLtysLsF1mciPekbotWfT0gagJA@mail.gmail.com>
 <CAEzXK1ok5BsSMY2t4+D0575QSAqEkzKPC7cnWEVmg0OhCFcgcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAEzXK1ok5BsSMY2t4+D0575QSAqEkzKPC7cnWEVmg0OhCFcgcA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhou,
 David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gV2VkLCBKYW4gMzEsIDIwMTggYXQgNjo1NyBQTSwgTHXDrXMgTWVuZGVzIDxsdWlzLnAubWVu
ZGVzQGdtYWlsLmNvbT4gd3JvdGU6Cj4gSGkgZXZlcnlvbmUsCj4KPiBJIGFtIGdldHRpbmcgYSBu
ZXcgaXNzdWUgd2l0aCBhbWRncHUgd2l0aCBSWDQ2MCwgdGhhdCBpcywgbm93IEkgY2FuCj4gcGxh
eSBhbnkgdmlkZW9zIHdpdGggS29kaSBvciBwbGF5IHdlYiB2aWRlb3Mgd2l0aCBmaXJlZm94IGFu
ZCBydW4KPiBPcGVuR0wgYXBwbGljYXRpb25zIHdpdGhvdXQgcnVubmluZyBpbnRvIGFueSBpc3N1
ZXMsIGhvd2V2ZXIgYWZ0ZXIKPiBzb21lIHVwdGltZSB3aXRoIFhPcmcgZXZlbiB3aGVuIGFsbW9z
dCBpbmFjdGl2ZSBJIGdldCBhIGttYWxsb2MKPiBhbGxvY2F0aW9uIGZhaWx1cmUsIG5vcm1hbGx5
IGZvbGxvd2VkIGJ5IGEgR1BVIGhhbmcgYSB3aGlsZSBhZnRlciB0aGUKPiB0aGUgYWxsb2NhdGlv
biBmYWlsdXJlLgo+IEkgaGFkIGEgdGVybWluYWwgd2luZG93IHVuZGVyIFVidW50dSBNYXRlIDE3
LjEwIGFuZCBJIHdhcyBjb21waWxpbmcKPiBjb2RlIHdoZW4gSSBnb3QgdGhlIGtlcm5lbCBtZXNz
YWdlcyB0aGF0IGNhbiBiZSBmb3VuZCBpbiBhdHRhY2htZW50Lgo+Cj4gSSBhbSB1c2luZyB0aGUg
a2VybmVsIGFzIGlkZW50aWZpZWQgb24gbXkgcHJldmlvdXMgZW1haWwsIHdoaWNoIGNhbiBiZQo+
IGZvdW5kIGJlbG93LgoKZG9lcyB0aGlzIHBhdGNoIGhlbHA/Cmh0dHBzOi8vcGF0Y2h3b3JrLmZy
ZWVkZXNrdG9wLm9yZy9wYXRjaC8xOTgyNTgvCgpBbGV4Cgo+Cj4gUmVnYXJkcywKPiBMdcOtcyBN
ZW5kZXMKPgo+IE9uIFdlZCwgSmFuIDMxLCAyMDE4IGF0IDEyOjQ3IFBNLCBMdcOtcyBNZW5kZXMg
PGx1aXMucC5tZW5kZXNAZ21haWwuY29tPiB3cm90ZToKPj4gSGkgQWxleGFuZGVyLAo+Pgo+PiBJ
J3ZlIGNoZXJyeSBwaWNrZWQgdGhlIHBhdGNoIHlvdSBwb2ludGVkIG91dCBpbnRvIGtlcm5lbCBm
cm9tCj4+IGFtZC1kcm0tbmV4dC00LjE3LXdpcCBhdCBjb21taXQKPj4gOWFiMjg5NDEyMjI3NWE2
ZDYzNmJiMjY1NGExNTdlODhhMGY3YjllMiAoIGRybS9hbWRncHU6IHNldAo+PiBEUklWRVJfQVRP
TUlDIGZsYWcgZWFybHkpIGFuZCB0ZXN0ZWQgaXQgb24gQVJNdjdsIGFuZCB0aGUgcHJvYmxlbSBo
YXMKPj4gZ29uZSBpbmRlZWQuCj4+Cj4+Cj4+V29ya2luZyBncmVhdCBvbiBBUk12N2wgd2l0aCBB
TUQgUlg0NjAuCj4+Cj4+VGhhbmtzLAo+Pkx1w61zIE1lbmRlcwo+Pgo+Pgo+Pk9uIFR1ZSwgSmFu
IDMwLCAyMDE4IGF0IDY6NDQgUE0sIERldWNoZXIsIEFsZXhhbmRlcgo+PjxBbGV4YW5kZXIuRGV1
Y2hlckBhbWQuY29tPiB3cm90ZToKPj4+IEZpeGVkIHdpdGggdGhpcyBwYXRjaDoKPj4+Cj4+PiBo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9hcmNoaXZlcy9hbWQtZ2Z4LzIwMTgtSmFudWFy
eS8wMTg0NzIuaHRtbAo+Pj4KPj4+Cj4+PiBBbGV4Cj4gPD4KPj4+IF9fX19fX19fX19fX19fX19f
Xwo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBh
bWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cj4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
