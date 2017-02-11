From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [UMR] Add GPU_POWER (v3) + refactored cleanup
Date: Sat, 11 Feb 2017 14:05:02 -0500
Message-ID: <2b15805a-3e56-71b7-0242-98e3db103add@amd.com>
References: <20170211175223.2748-1-tom.stdenis@amd.com>
 <3627d968-1817-5ca3-024e-1d91291680b5@dev.carbon-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <3627d968-1817-5ca3-024e-1d91291680b5-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
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
To: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMDIvMTEvMjAxNyAwMTo1NyBQTSwgS2FpIFdhc3NlcmLDpGNoIHdyb3RlOgo+IEhleSBUb20s
Cj4gVG9tIFN0IERlbmlzIHdyb3RlIG9uIDExLjAyLjIwMTcgMTg6NTI6Cj4+IEkgc3BsaXQgb3V0
IHRoZSBkZWxldGlvbiBvZiB0aGUgdW51c2VkIGJpdHMgaW4gLS10b3AuCj4KPiB0aGFuayB5b3Ug
c28gbXVjaCBmb3IgYmVhcmluZyB3aXRoIG1lIChhbmQgRWR3YXJkLCB0aG91Z2ggSSBjYW4ndCBz
cGVhayBmb3IgaGltLAo+IG9idmlvdXNseSkhIFlvdSBjYW4gc3RpbGwgaGF2ZSBteSBSLWIuIDst
KQo+Cj4gQ2hlZXJzLAo+IEthaQo+CgpObyB3b3JyaWVzLiAgSXQncyBubyBzZWNyZXQgSSdtIG5v
IGZhbiBvZiBORkMgcmUtc3VibWl0cyBidXQgaGFyZCB0byBnZXQgCnVwc2V0IGluIHRoZSBmYWNl
IG9mIGdlbnVpbmVseSBnb29kIGZlZWRiYWNrLiAgQW5kIGl0IGlzIGEgY29tbXVuaXR5IApwcm9q
ZWN0IGluIHRoZSBsb25nIHJ1biBzbyBpdCdzIG5vdCBsaWtlIGNvbW11bml0eSBwdXNoYmFjay9m
ZWVkYmFjayBpcyAKbm90IHdlbGNvbWVkIChteSBydW1ibGluZ3Mgbm90d2l0aHN0YW5kaW5nKS4K
ClRoYW5rcyB0byB5b3UgYW5kIEVkd2FyZCBmb3IgdGhlIGZlZWRiYWNrLgoKSSd2ZSBwdXNoZWQg
dGhlbSBvdXQuICBZb3UnbGwgbmVlZCBhIHN0YWdpbmcga2VybmVsIHRvIHVzZSBHUFVfUE9XRVIg
Cih3aXRoIG15IGFuZCBFcmljJ3MgcGF0Y2hlcykgdG8gc2VlIGFueSBvZiB0aGlzIG9uIGEgVkkg
ZEdQVS4KCkl0J3Mga2luZGEgaW50ZXJlc3RpbmcgdG8gc2VlIHRoZSBwb3dlciB1c2FnZSBncmFw
aHMgKHVzaW5nIHVtcidzIC0tdG9wIAonbG9nZ2VyJyBtb2RlKSBjb21wYXJpbmcgUG9sYXJpczEw
IGFuZCBmaWppIHdoaWxlIHJ1bm5pbmcgc2F5IAp1bmlnaW5lLWhlYXZlbi4gIEkgdGhpbmsgdGhl
IHNlbnNvcnMgd2lsbCBoZWxwIGRlYnVnL29wdGltaXplIHBvd2VyIAp1c2FnZSBnb2luZyBmb3J3
YXJkLgoKQ2hlZXJzLApUb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
