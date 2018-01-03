From: Carlo Caione <carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 4.15 0/4] Backport DC commits to fix display corruption
Date: Wed, 3 Jan 2018 17:36:22 +0000
Message-ID: <CAL9uMOEu65qr+RFOUnKK+7aFaw_3=-t3p5w9siHibGdAVGw2gQ@mail.gmail.com>
References: <20180103171108.17391-1-carlo@caione.org>
 <e9f61bee-e168-d863-1ca7-c83e57e6c806@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e9f61bee-e168-d863-1ca7-c83e57e6c806-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Cc: Yuehin.Lau-5C7GfCeVMHo@public.gmane.org, Linux Upstreaming Team <linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, "Deucher, Alexander" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, mikita.lipski-5C7GfCeVMHo@public.gmane.org, Tony.Cheng-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org

T24gV2VkLCBKYW4gMywgMjAxOCBhdCA1OjMyIFBNLCBIYXJyeSBXZW50bGFuZCA8aGFycnkud2Vu
dGxhbmRAYW1kLmNvbT4gd3JvdGU6Cj4gT24gMjAxOC0wMS0wMyAxMjoxMSBQTSwgQ2FybG8gQ2Fp
b25lIHdyb3RlOgo+PiBGcm9tOiBDYXJsbyBDYWlvbmUgPGNhcmxvQGVuZGxlc3NtLmNvbT4KPj4K
Pj4gSGksCj4+IG9uIHNldmVyYWwgbGFwdG9wcyBbMF0gd2UgYXJlIHNlZWluZyBkaXNwbGF5IGNv
cnJ1cHRpb24gd2hlbiB1c2luZyBtdWx0aXBsZSAvCj4+IGV4dGVybmFsIGRpc3BsYXlzLiBXZSBh
bHJlYWR5IG9wZW5lZCBhbiBpc3N1ZSB1cHN0cmVhbSBbMV0uCj4+IFRoZSBmb2xsb3dpbmcgNCBw
YXRjaGVzIGFyZSB0YWtlbiBmcm9tIGFnZDVmL2FtZC1zdGFnaW5nLWRybS1uZXh0IGFuZCB0aGV5
IHNlZW0KPj4gYWJsZSB0byBzb2x2ZSB0aGUgaXNzdWUuCj4+IENhbiB0aG9zZSBiZSBpbmNsdWRl
ZCBpbiA0LjE1Pwo+Pgo+PiBUaGFuayB5b3UsCj4+Cj4+IFswXSBBY2VyIEFzcGlyZSBFNS01NTNH
IChBTUQgRlgtOTgwMFAgUkFERU9OIFI3KQo+PiAgICAgQWNlciBBc3BpcmUgRTUtNTIzRyAoQU1E
IEUyLTkwMTAgUkFERU9OIFIyKQo+PiAgICAgQWNlciBBc3BpcmUgQTMxNS0yMSAoQU1EIEE0LTkx
MjAgUkFERU9OIFIzKQo+PiAgICAgQWNlciBBc3BpcmUgQTUxNS00MUcgKEFNRCBBMTAtOTYyMCBS
QURFT04gUjUpCj4+Cj4+IFsxXSBodHRwczovL2J1Z3MuZnJlZWRlc2t0b3Aub3JnL3Nob3dfYnVn
LmNnaT9pZD0xMDQzMTkKPj4KPj4gSGFycnkgV2VudGxhbmQgKDEpOgo+PiAgIGRybS9hbWQvZGlz
cGxheTogQm90aCB0aW1pbmdfc3luYyBhbmQgbXVsdGlzeW5jIG5lZWQgc3RyZWFtX2NvdW50ID4g
MQo+Pgo+PiBMZW8gKFN1bnBlbmcpIExpICgxKToKPj4gICBkcm0vYW1kL2Rpc3BsYXk6IENoYW5n
ZSBmcm9udGVuZC9iYWNrZW5kIHByb2dyYW1taW5nIHNlcXVlbmNlCj4+Cj4+IE1pa2l0YSBMaXBz
a2kgKDIpOgo+PiAgIGRybS9hbWQvZGlzcGxheTogQWRkaW5nIERDTjEgcmVnaXN0ZXJzCj4+ICAg
ZHJtL2FtZC9kaXNwbGF5OiBNdWx0aSBkaXNwbGF5IHN5bmNocm9uaXphdGlvbiBsb2dpYwo+Pgo+
Cj4gSSdtIHN1cnByaXNlZCBNaWtpdGEgYW5kIG15IHBhdGNoZXMgYXJlIHJlcXVpcmVkIGhlcmUu
IEFyZSB5b3Ugc3VyZSB0aGV5IG1ha2UgYSBkaWZmZXJlbmNlIGZvciBkaXNwbGF5IGNvcnJ1cHRp
b24gb3IgZGlkIHlvdSBzaW1wbHkgYWRkIHRoZW0gdG8gbWFrZSBwdWxsIExlbydzIHBhdGNoIG1v
cmUgY2xlYW5seT8KClllcywgdGhlIG9ubHkgc3RyaWN0bHkgcmVxdWlyZWQgcGF0Y2ggaXMgdGhl
IHBhdGNoIGJ5IExlby4gVGhlIG90aGVycwphcmUganVzdCBwdWxsZWQgaW4gdG8gbWFrZSB0aGF0
IGFwcGx5IGNsZWFubHkuCgpUaGFua3MsCgotLSAKQ2FybG8gQ2Fpb25lICB8ICArNDQuNzM4NC42
OS4xNi4wNCAgfCAgRW5kbGVzcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
