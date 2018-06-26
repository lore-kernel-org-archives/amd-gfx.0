From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: separate gpu address from bo pin
Date: Tue, 26 Jun 2018 16:39:00 +0800
Message-ID: <5B31FBA4.6010908@amd.com>
References: <1529992843-649-1-git-send-email-Jerry.Zhang@amd.com>
 <6c63256a-17d2-ee6e-8b3c-2e0a928aeb84@daenzer.net> <5B31F946.6020404@amd.com>
 <eac68f86-a5f9-110e-3970-ee8a8404934a@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <eac68f86-a5f9-110e-3970-ee8a8404934a-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: christian.koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDYvMjYvMjAxOCAwNDozNSBQTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gT24gMjAxOC0w
Ni0yNiAxMDoyOCBBTSwgWmhhbmcsIEplcnJ5IChKdW53ZWkpIHdyb3RlOgo+PiBPbiAwNi8yNi8y
MDE4IDAzOjQ2IFBNLCBNaWNoZWwgRMOkbnplciB3cm90ZToKPj4+IE9uIDIwMTgtMDYtMjYgMDg6
MDAgQU0sIEp1bndlaSBaaGFuZyB3cm90ZToKPj4+PiBJdCBjb3VsZCBiZSBnb3QgYnkgYW1kZ3B1
X2JvX2dwdV9vZmZzZXQoKSBpZiBuZWVkCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBKdW53ZWkg
WmhhbmcgPEplcnJ5LlpoYW5nQGFtZC5jb20+Cj4+Pj4KPj4+PiBbLi4uXQo+Pj4+Cj4+Pj4gQEAg
LTkzMSw3ICs5MjgsNiBAQCBpbnQgYW1kZ3B1X2JvX3Bpbl9yZXN0cmljdGVkKHN0cnVjdCBhbWRn
cHVfYm8KPj4+PiAqYm8sIHUzMiBkb21haW4sCj4+Pj4gICAgICogYW1kZ3B1X2JvX3BpbiAtIHBp
biBhbiAmYW1kZ3B1X2JvIGJ1ZmZlciBvYmplY3QKPj4+PiAgICAgKiBAYm86ICZhbWRncHVfYm8g
YnVmZmVyIG9iamVjdCB0byBiZSBwaW5uZWQKPj4+PiAgICAgKiBAZG9tYWluOiBkb21haW4gdG8g
YmUgcGlubmVkIHRvCj4+Pj4gLSAqIEBncHVfYWRkcjogR1BVIG9mZnNldCBvZiB0aGUgJmFtZGdw
dV9ibyBidWZmZXIgb2JqZWN0Cj4+Pj4gICAgICoKPj4+PiAgICAgKiBBIHNpbXBsZSB3cmFwcGVy
IHRvIGFtZGdwdV9ib19waW5fcmVzdHJpY3RlZCgpLgo+Pj4+ICAgICAqIFByb3ZpZGVzIGEgc2lt
cGxlciBBUEkgZm9yIGJ1ZmZlcnMgdGhhdCBkbyBub3QgaGF2ZSBhbnkgc3RyaWN0Cj4+Pj4gcmVz
dHJpY3Rpb25zCj4+Pgo+Pj4gVGhpcyBhbHNvIG5lZWRzIHRvIGJlIHJlbW92ZWQgaW4gdGhlIGNv
bW1lbnQgYmVmb3JlCj4+PiBhbWRncHVfYm9fcGluX3Jlc3RyaWN0ZWQuIFdpdGggdGhhdCBmaXhl
ZCwKPj4KPj4gRXhhY3RseSwgSSB3aWxsLgo+Cj4gVGhhbmtzLiBGV0lXLCBydW5uaW5nIGUuZy4K
Pgo+ICAgbWFrZSAtaiQobnByb2MpIGh0bWxkb2NzCgpUaGFua3MgZm9yIHlvdXIgc2hhcmluZyB1
c2VmdWwgY29tbWFuZCA6KQoKSmVycnkKCj4KPiBzaG91bGQgaGF2ZSBwcm9kdWNlZCB0aGUgZm9s
bG93aW5nIHdhcm5pbmc6Cj4KPiAuL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9v
YmplY3QuYzo4NDE6IHdhcm5pbmc6IEV4Y2Vzcwo+IGZ1bmN0aW9uIHBhcmFtZXRlciAnZ3B1X2Fk
ZHInIGRlc2NyaXB0aW9uIGluICdhbWRncHVfYm9fcGluX3Jlc3RyaWN0ZWQnCj4KPgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
