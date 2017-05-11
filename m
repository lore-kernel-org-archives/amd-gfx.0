From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: export test ring debugfs interface
Date: Wed, 10 May 2017 23:00:51 -0400
Message-ID: <CADnq5_PWxPw4GMa86c_Gb75Urwb-dzjMhvPXPHD3eETujfqYPw@mail.gmail.com>
References: <1494469757-25784-1-git-send-email-ray.huang@amd.com>
 <1494469757-25784-2-git-send-email-ray.huang@amd.com>
 <BN6PR12MB16521EA7A33D9718734FD83EF7ED0@BN6PR12MB1652.namprd12.prod.outlook.com>
 <BN6PR12MB1652A074AABF32DDD7F559F7F7ED0@BN6PR12MB1652.namprd12.prod.outlook.com>
 <20170511025642.GA17636@hr-amur2>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170511025642.GA17636@hr-amur2>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Huan,
 Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

T24gV2VkLCBNYXkgMTAsIDIwMTcgYXQgMTA6NTYgUE0sIEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFt
ZC5jb20+IHdyb3RlOgo+IE9uIFRodSwgTWF5IDExLCAyMDE3IGF0IDEwOjQxOjQyQU0gKzA4MDAs
IERldWNoZXIsIEFsZXhhbmRlciB3cm90ZToKPj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQo+PiA+IEZyb206IERldWNoZXIsIEFsZXhhbmRlcgo+PiA+IFNlbnQ6IFdlZG5lc2RheSwgTWF5
IDEwLCAyMDE3IDEwOjM4IFBNCj4+ID4gVG86IEh1YW5nLCBSYXk7IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnOyBLb2VuaWcsIENocmlzdGlhbgo+PiA+IENjOiBaaG91LCBEYXZpZChDaHVu
TWluZyk7IFdhbmcsIEtlbjsgSHVhbiwgQWx2aW47IEh1YW5nLCBSYXkKPj4gPiBTdWJqZWN0OiBS
RTogW1BBVENIIDIvMl0gZHJtL2FtZGdwdTogZXhwb3J0IHRlc3QgcmluZyBkZWJ1Z2ZzIGludGVy
ZmFjZQo+PiA+Cj4+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+PiA+ID4gRnJvbTog
SHVhbmcgUnVpIFttYWlsdG86cmF5Lmh1YW5nQGFtZC5jb21dCj4+ID4gPiBTZW50OiBXZWRuZXNk
YXksIE1heSAxMCwgMjAxNyAxMDoyOSBQTQo+PiA+ID4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXI7IEtvZW5pZywgQ2hyaXN0aWFuCj4+ID4gPiBD
YzogWmhvdSwgRGF2aWQoQ2h1bk1pbmcpOyBXYW5nLCBLZW47IEh1YW4sIEFsdmluOyBIdWFuZywg
UmF5Cj4+ID4gPiBTdWJqZWN0OiBbUEFUQ0ggMi8yXSBkcm0vYW1kZ3B1OiBleHBvcnQgdGVzdCBy
aW5nIGRlYnVnZnMgaW50ZXJmYWNlCj4+ID4gPgo+PiA+ID4gU2lnbmVkLW9mZi1ieTogSHVhbmcg
UnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KPj4gPgo+PiA+IFJldmlld2VkLWJ5OiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4+Cj4+IE5vdCBzdXJlIGlmIGl0J3MgaW1w
b3J0YW50IGZvciB0aGlzIHNpbmNlIGl0J3MgZGVidWdmcywgYnV0IHdlIGRvbid0IGhhdmUgYW55
Cj4+IHNvcnQgb2YgcmluZyBsb2NrcyBhbnltb3JlIChzaW5jZSBldmVyeXRoaW5nIHNob3VsZCBn
byB0aHJvdWdoIHRoZSBzY2hlZHVsZXIKPj4gb25jZSBpdCdzIHN0YXJ0ZWQpIHNvIHdlIGNvdWxk
IHRoZW9yZXRpY2FsbHkgZ2V0IGNvbGxpc2lvbnMgaWYgdGhlcmUgYXJlIGFjdGl2ZQo+PiBhcHBz
IHVzaW5nIHRoZSBHUFUgYW5kIHlvdSBydW4gdGhlc2UgdGVzdHMuCj4+Cj4KPiBSaWdodC4gQW55
IGlkZWEgdG8gaG9sZCBvbiBzY2hlZHVsZXIgd2hlbiBJIHRyeSB0byBydW4gdGhpcyB0ZXN0PwoK
UGFyayB0aGUgc2NoZWR1bGVyIHRocmVhZCBmb3IgZWFjaCByaW5nIGxpa2Ugd2UgZG8gZm9yIEdQ
VSByZXNldD8KVGhhdCBzYWlkLCBJIHRoaW5rIHRoZSBleHBlY3RhdGlvbiBpcyB0aGF0IHlvdSBz
aG91bGQgb25seSBydW4gdGhlc2UKdGVzdHMgd2hlbiB0aGUgR1BVIGlzIGlkbGUuCgpBbGV4Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
