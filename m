From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [Xen-devel] [PATCH v9 4/5] x86/PCI: Enable a 64bit BAR on AMD
 Family 15h (Models 30h-3fh) Processors v5
Date: Tue, 28 Nov 2017 11:17:33 +0100
Message-ID: <af7e8d49-4c3c-f9dc-4ddc-26ce7a1721d0@amd.com>
References: <20171018135821.3248-1-deathsimple@vodafone.de>
 <20171018135821.3248-5-deathsimple@vodafone.de>
 <c5ca14bc-3812-ff15-7dd0-e862ce85a348@oracle.com>
 <d81d50e6-c267-fe43-214f-278e57903448@gmail.com>
 <26df0a78-8028-e42c-ce50-4cefe612a7e1@oracle.com>
 <3443aad0-8c3b-b97e-685a-96b0866827be@amd.com>
 <b937778c-556e-5587-c557-abba8cefe100@oracle.com>
 <bee2c953-0ab6-a086-9150-ae51e099655c@amd.com>
 <c2d52d00-8c3c-9944-29b3-3cab2f7c35f7@oracle.com>
 <7936fdd3-1615-ac1f-7b75-330ccb6a1a3f@amd.com>
 <0bb468d9-bc1d-e3c5-e313-1cf9408380f0@oracle.com>
 <275e859a-0ddd-ea7f-a681-67e42a5233fe@amd.com>
 <38bc76d9-2ed5-61f3-24b3-085031825181@oracle.com>
 <65885386-3dde-de23-7e95-7d96dfdf6033@oracle.com>
 <0ab28334-3ccc-2a93-9991-396ee01a3662@amd.com>
 <5A1D3E9D0200007800192A44@prv-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5A1D3E9D0200007800192A44-rw/UEucdPrvD8XXLLHKrIiOjQekVJEpY@public.gmane.org>
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
To: Jan Beulich <JBeulich-IBi9RG/b67k@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, xen-devel <xen-devel-GuqFBffKawuEi8DpZVb4nw@public.gmane.org>, helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Boris Ostrovsky <boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

QW0gMjguMTEuMjAxNyB1bSAxMDo0NiBzY2hyaWViIEphbiBCZXVsaWNoOgo+Pj4+IE9uIDI4LjEx
LjE3IGF0IDEwOjEyLCA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiB3cm90ZToKPj4gSW4gdGhl
b3J5IHRoZSBCSU9TIHdvdWxkIHNlYXJjaCBmb3IgYWRkcmVzcyBzcGFjZSBhbmQgd29uJ3QgZmlu
ZAo+PiBhbnl0aGluZywgc28gdGhlIGhvdHBsdWcgb3BlcmF0aW9uIHNob3VsZCBmYWlsIGV2ZW4g
YmVmb3JlIGl0IHJlYWNoZXMKPj4gdGhlIGtlcm5lbCBpbiB0aGUgZmlyc3QgcGxhY2UuCj4gSG93
IHdvdWxkIHRoZSBCSU9TIGtub3cgd2hhdCB0aGUgT1MgZG9lcyBvciBwbGFucyB0byBkbz8KCkFz
IGZhciBhcyBJIGtub3cgdGhlIEFDUEkgQklPUyBzaG91bGQgd29yayBkaXJlY3RseSB3aXRoIHRo
ZSByZWdpc3RlciAKY29udGVudC4KClNvIHdoZW4gd2UgdXBkYXRlIHRoZSByZWdpc3RlciBjb250
ZW50IHRvIGVuYWJsZSB0aGUgTU1JTyBkZWNvZGluZyB0aGUgCkJJT1Mgc2hvdWxkIGtub3cgdGhh
dCBhcyB3ZWxsLgoKPiBJIHRoaW5rCj4gaXQncyB0aGUgb3RoZXIgd2F5IGFyb3VuZCAtIHRoZSBP
UyBuZWVkcyB0byBhdm9pZCB1c2luZyBhbnkgcmVnaW9ucwo+IGZvciBNTUlPIHdoaWNoIGFyZSBt
YXJrZWQgYXMgaG90cGx1Z2dhYmxlIGluIFNSQVQuCgpJIHdhcyB1bmRlciB0aGUgaW1wcmVzc2lv
biB0aGF0IHRoaXMgaXMgZXhhY3RseSB3aGF0IAphY3BpX251bWFfbWVtb3J5X2FmZmluaXR5X2lu
aXQoKSBkb2VzLgoKPiBTaW5jZSB0aGVyZSBpcwo+IG5vIHZOVU1BIHlldCBmb3IgWGVuIERvbTAs
IHRoYXQgd291bGQgbmVlZCBzcGVjaWFsIGhhbmRsaW5nLgoKSSB0aGluayB0aGF0IHRoZSBwcm9i
bGVtIGlzIHJhdGhlciB0aGF0IFNSQVQgaXMgTlVNQSBzcGVjaWZpYyBhbmQgaWYgSSdtIApub3Qg
dG90YWxseSBtaXN0YWtlbiB0aGUgY29udGVudCBpcyBpZ25vcmVkIHdoZW4gTlVNQSBzdXBwb3J0
IGlzbid0IApjb21waWxlZCBpbnRvIHRoZSBrZXJuZWwuCgpXaGVuIFhlbiBzdGVhbHMgc29tZSBt
ZW1vcnkgZnJvbSBEb20wIGJ5IGhvY2tpbmcgdXAgaXRzZWxmIGludG8gdGhlIGU4MjAgCmNhbGwg
dGhlbiBJIHdvdWxkIHNheSB0aGUgY2xlYW5lc3Qgd2F5IGlzIHRvIHJlcG9ydCB0aGlzIG1lbW9y
eSBpbiBlODIwIAphcyByZXNlcnZlZCBhcyB3ZWxsLiBCdXQgdGFrZSB0aGF0IHdpdGggYSBncmFp
biBvZiBzYWx0LCBJJ20gc2VyaW91c2x5IApub3QgYSBYZW4gZXhwZXJ0LgoKUmVnYXJkcywKQ2hy
aXN0aWFuLgoKPgo+IEphbgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
