From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Shared semaphores for amdgpu
Date: Thu, 9 Mar 2017 08:38:44 +0100
Message-ID: <d5a5f1ba-4bcb-f374-f18e-b060cc40aa9e@amd.com>
References: <544E607D03B20249AA404517E498FC469A558B@exchange01.valvesoftware.com>
 <BN4PR12MB0787AE3A185BE4D6916CE42AEE600@BN4PR12MB0787.namprd12.prod.outlook.com>
 <a25fdfeb-be5d-2d23-d7b1-ef14891ba6d5@gmail.com>
 <CAPM=9txG2KEw7AH553uFtuvoGYFK1=kmkPRJEHuA=8fq_JcY=w@mail.gmail.com>
 <58B4D68E.5080606@amd.com>
 <CAPM=9tw3nbGe+gaOpoBZeXfmS5+C3R4eK=uT8AL3krL0PMR0LA@mail.gmail.com>
 <CAPM=9twMvVoKCCmQUVsB6uD18j1e9cNq9eNqviVFy6F8v7OdOg@mail.gmail.com>
 <58C0FD86.8040808@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <58C0FD86.8040808-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Mao, David" <David.Mao-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Andres Rodriguez <andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Cui,
 Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>, Pierre-Loup Griffais <pgriffais-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>

PiBJIGRvIHdvbmRlciBpZiB3ZSBuZWVkIHRoZSBzZXBhcmF0ZSBzZW0gc2lnbmFsL3dhaXQgaW50
ZXJmYWNlLCBJIHRoaW5rCj4gd2Ugc2hvdWxkIGp1c3QgYWRkCj4gc2VtYXBob3JlIGNodW5rcyB0
byB0aGUgQ1MgaW50ZXJmYWNlLgpZZWFoLCB0aGF0J3Mgd2hhdCBJJ3ZlIHNhaWQgYXMgd2VsbCBm
cm9tIHRoZSB2ZXJ5IGZpcnN0IGJlZ2lubmluZy4KCkFub3RoZXIgcXVlc3Rpb24gaXMgaWYgd2Ug
c2hvdWxkIHJlYWxseSBjcmVhdGUgYW5vdGhlciBpbXBsZW1lbnRhdGlvbiB0byAKc2hhcmUgc2Vt
YXBob3JlcyBiZXR3ZWVuIHByb2Nlc3Nlcy4KCkluIG90aGVyIHdvcmRzIHB1dHRpbmcgdGhlIGN1
cnJlbnQgZmVuY2VzIGluc2lkZSB0aGUgc2VtYXBob3JlIGludG8gYSAKc3luY19maWxlIHdpdGgg
dGhlIHNpZ25hbF9vbl9hbnkgYml0IHNldCB3b3VsZCBoYXZlIHByZXR0eSBtdWNoIHRoZSBzYW1l
IAplZmZlY3QsIGV4Y2VwdCB0aGF0IHRoZSByZXN1bHRpbmcgb2JqZWN0IHRoZW4gaGFkIHRoZSBz
eW5jX2ZpbGUgCnNlbWFudGljcyBmb3IgYWRkaW5nIG5ldyBmZW5jZXMgYW5kIGNhbiBiZSB1c2Vk
IGluIHRoZSBhdG9taWMgSU9DVExzIGFzIAp3ZWxsLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKQW0g
MDkuMDMuMjAxNyB1bSAwODowMCBzY2hyaWViIHpob3VjbTE6Cj4gSGkgRGF2ZSwKPgo+IFdlIGhh
dmUgYWxyZWFkeSBjb21wbGV0ZWQgaW1wbGVtZW50YXRpb24gYXMgdGhlIGF0dGFjaGVkIGZvciBi
b3RoIAo+IGtlcm5lbCBhbmQgbGliZHJtLiBXZSBkaXNjdXNzIGl0IG9uIHRvcCBvZiB0aGlzLgo+
Cj4KPiBUaGFua3MsCj4gRGF2aWQgWmhvdQo+Cj4gT24gMjAxN+W5tDAz5pyIMDnml6UgMTI6MjQs
IERhdmUgQWlybGllIHdyb3RlOgo+PiBJJ3ZlIGF0dGFjaGVkIHR3byBwYXRjaGVzIGZvciBSRkMg
YXQgdGhlIG1vbWVudCwgSSBoYXZlbid0IGZpbmlzaGVkCj4+IHRoZSB1c2Vyc3BhY2UgZm9yIHRo
ZXNlIHlldCwgYnV0IGp1c3Qgd2FudGVkIHRvIGdldCBzb21lCj4+IGlkZWFzL2ZlZWRiYWNrLgo+
Pgo+PiBEYXZlLgo+Pgo+PiBPbiA5IE1hcmNoIDIwMTcgYXQgMTM6NTIsIERhdmUgQWlybGllIDxh
aXJsaWVkQGdtYWlsLmNvbT4gd3JvdGU6Cj4+PiBPbiAyOCBGZWJydWFyeSAyMDE3IGF0IDExOjQ2
LCB6aG91Y20xIDxkYXZpZDEuemhvdUBhbWQuY29tPiB3cm90ZToKPj4+PiBIaSBEYXZlLAo+Pj4+
Cj4+Pj4gVGhlIGF0dGFjaGVkIGlzIG91ciBzZW1hcGhvcmUgaW1wbGVtZW50YXRpb24sIGFtZGdw
dV9jcy5jIGlzIGRybSAKPj4+PiBmaWxlLCB0aGUKPj4+PiBvdGhlcnMgYXJlIGtlcm5lbCBmaWxl
Lgo+Pj4+IEFueSBzdWdnZXN0aW9uPwo+Pj4gVGhhbmtzLAo+Pj4KPj4+IEkndmUgYnVpbHQgYSB0
cmVlIHdpdGggYWxsIHRoZXNlIGluIGl0LCBhbmQgc3RhcnRlZCBsb29raW5nIGludG8gdGhlIAo+
Pj4gaW50ZXJmYWNlLgo+Pj4KPj4+IEkgZG8gd29uZGVyIGlmIHdlIG5lZWQgdGhlIHNlcGFyYXRl
IHNlbSBzaWduYWwvd2FpdCBpbnRlcmZhY2UsIEkgdGhpbmsKPj4+IHdlIHNob3VsZCBqdXN0IGFk
ZAo+Pj4gc2VtYXBob3JlIGNodW5rcyB0byB0aGUgQ1MgaW50ZXJmYWNlLgo+Pj4KPj4+IEknbSBq
dXN0IHBsYXlpbmcgYXJvdW5kIHdpdGggdGhpcyBub3cuCj4+Pgo+Pj4gRGF2ZS4KPgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
