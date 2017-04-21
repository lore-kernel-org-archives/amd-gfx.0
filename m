From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] dmr/amdgpu: Fix wrongly unref of BO
Date: Fri, 21 Apr 2017 13:53:17 -0400
Message-ID: <981a3a7c-f998-f6bf-66f8-8bae9d9b101a@amd.com>
References: <1492119298-8526-1-git-send-email-AlexBin.Xie@amd.com>
 <58F57C14.20403@amd.com>
 <MWHPR1201MB00452889FF2C7FDC55630B4BF2190@MWHPR1201MB0045.namprd12.prod.outlook.com>
 <7807726d-7318-b72f-1a14-2b37a73988bf@vodafone.de>
 <MWHPR1201MB00451DFD2A06BBA3CD6F928EF2190@MWHPR1201MB0045.namprd12.prod.outlook.com>
 <MWHPR1201MB004553768BCAC951D28A347AF2190@MWHPR1201MB0045.namprd12.prod.outlook.com>
 <4509f79a-ffd5-eb40-117c-84ea02cbf5cd@vodafone.de>
 <MWHPR1201MB0045EC51F6CE7C6C4283888CF2180@MWHPR1201MB0045.namprd12.prod.outlook.com>
 <2b43e2a9-0c79-f945-c835-0cfc486304c8@vodafone.de>
 <MWHPR1201MB0045B04F77E1F1C6D37D24FBF2180@MWHPR1201MB0045.namprd12.prod.outlook.com>
 <96809715-3c78-3784-fbeb-57a00359e3f3@vodafone.de>
 <MWHPR1201MB004568A33CBF287710759301F21B0@MWHPR1201MB0045.namprd12.prod.outlook.com>
 <af065740-e219-fccb-4dac-d46f3472f4aa@vodafone.de>
 <003d5e5f-ea99-4517-fd4a-de4df3ce1b89@amd.com>
 <a8715aca-05ff-1262-e2f5-31279052e606@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a8715aca-05ff-1262-e2f5-31279052e606-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

Ck9uIDE3LTA0LTIxIDAxOjAxIFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDIxLjA0
LjIwMTcgdW0gMTc6NDMgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPj4gT24gMTctMDQtMjEgMDM6
MTEgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBIaSBBbGV4LAo+Pj4KPj4+PiBOby4g
Rm9yIHRoZSBjdXJyZW50IHNvdXJjZSBjb2RlLCBJIHRoaW5rIHRoZSBwcmVtYXAgYW5kIG5vLW9w
IGlzIG5vdAo+Pj4+IHdvcmtpbmcuCj4+Pj4KPj4+IEluZGVlZCwgd2UgZG9uJ3Qgc2V0IGJvLT5t
ZW0uYnVzLmFkZHIgaW4gYW1kZ3B1X3R0bV9pb19tZW1fcmVzZXJ2ZSgpCj4+PiBhbnkgbW9yZS4g
RmVsaXggd2lsbCBwcm9iYWJseSB3YW50IHRvIGZpeCB0aGF0IGZvciB0aGUgS0ZEIGJyYW5jaC4K
Pj4gSSB2YWd1ZWx5IHJlbWVtYmVyIGRpc2N1c3NpbmcgdGhpcyBpbiB0aGUgcGFzdDogdXNpbmcg
bWVtLT5idXMuYWRkciB0bwo+PiBrZWVwIG1lbW9yeSBwZXJtYW5lbnRseSBDUFUtbWFwcGVkIGFu
ZCBhdm9pZCByZWR1bmRhbnQgaW9yZW1hcCBjYWxscy4gQXMKPj4gSSByZW1lbWJlciBpdCwgd2Ug
d2VyZW4ndCBhY3R1YWxseSB1c2luZyB0aGlzLiBJdCdzIG9ubHkgc29tZXRoaW5nIHdlCj4+IGNv
bnNpZGVyZWQgYXQgb25lIHBvaW50Lgo+Cj4gV2VsbCB0aGF0IGV4cGxhaW5zIHdoeSBteSBtZW1v
cnkgZm9vbGVkIG1lLgo+Cj4gTXkgbGFzdCBzdGF0dXMgd2FzIHRoYXQgd2UgaW1wbGVtZW50ZWQg
dGhpcyB0b2dldGhlciB3aXRoIENQVSBiYXNlZAo+IHBhZ2UgdGFibGUgdXBkYXRlcy4KPgo+IE90
aGVyd2lzZSBtYXBwaW5nIHRoZW0gZm9yIENQVSBhY2Nlc3MgaXMgcmF0aGVyIGhlYXZ5IGlmIHdl
IGluZGVlZAo+IHVwZGF0ZSB0aGUgcGFnZSB0YWJsZXMgZXZlcnkgdGltZS4KCldlIGFsc28gZG9u
J3QgY3VycmVudGx5IGhhdmUgQ1BVIHBhZ2UgdGFibGUgdXBkYXRlcyBmb3IgS0ZELiBXaGVuIHdl
CnJlYmFzZWQgb24gNC45LCB0aGUgVk0gY29kZSB3YXMgcmVzdHJ1Y3R1cmVkIHNvIG11Y2ggdGhh
dCB3ZSBlc3NlbnRpYWxseQpoYWQgdG8gZ28gYmFjayBhbmQgcmVpbXBsZW1lbnQgaXQuIEhhcmlz
aCBpcyB3b3JraW5nIG9uIHRoaXMgcmlnaHQgbm93LgoKUmVnYXJkcywKICBGZWxpeAoKPgo+IENo
cmlzdGlhbi4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
