From: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 10/12] tests/amdgpu: add test to submit a gfx command with
 secure context
Date: Fri, 15 Nov 2019 10:06:49 +0000
Message-ID: <MN2PR12MB330923D11E08F0DC172F8F1DEC700@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
 <1573788895-3936-10-git-send-email-aaron.liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1573788895-3936-10-git-send-email-aaron.liu-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <EAD357C13432E94285A2909160FBAF65-t0aD9ArCiwdO0n7uQEQMm4CZgX+1HZI1@public.gmane.org>
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
To: "Liu, Aaron" <Aaron.Liu-5C7GfCeVMHo@public.gmane.org>
Cc: "Olsak, Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Tuikov,
 Luben" <Luben.Tuikov-5C7GfCeVMHo@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Liu, Leo" <Leo.Liu-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

T24gRnJpLCBOb3YgMTUsIDIwMTkgYXQgMTE6MzQ6NTNBTSArMDgwMCwgTGl1LCBBYXJvbiB3cm90
ZToKPiBUaGlzIHBhdGNoIGlzIHRvIHRlc3QgdGhlIGNvbW1hbmQgc3VibWlzc2lvbiB3aXRoIHNl
Y3VyZSBjb250ZXh0Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFhcm9uIExpdSA8YWFyb24ubGl1QGFt
ZC5jb20+CgpSZXZpZXdlZC1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KCj4gLS0t
Cj4gIHRlc3RzL2FtZGdwdS9zZWN1cml0eV90ZXN0cy5jIHwgOSArKysrKysrKysKPiAgMSBmaWxl
IGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS90ZXN0cy9hbWRncHUv
c2VjdXJpdHlfdGVzdHMuYyBiL3Rlc3RzL2FtZGdwdS9zZWN1cml0eV90ZXN0cy5jCj4gaW5kZXgg
YTM4MDdlZS4uMGJiNGFkMiAxMDA2NDQKPiAtLS0gYS90ZXN0cy9hbWRncHUvc2VjdXJpdHlfdGVz
dHMuYwo+ICsrKyBiL3Rlc3RzL2FtZGdwdS9zZWN1cml0eV90ZXN0cy5jCj4gQEAgLTMyLDYgKzMy
LDcgQEAgc3RhdGljIHVpbnQzMl90IG1ham9yX3ZlcnNpb247Cj4gIHN0YXRpYyB1aW50MzJfdCBt
aW5vcl92ZXJzaW9uOwo+ICAKPiAgc3RhdGljIHZvaWQgYW1kZ3B1X3NlY3VyaXR5X2FsbG9jX2J1
Zl90ZXN0KHZvaWQpOwo+ICtzdGF0aWMgdm9pZCBhbWRncHVfc2VjdXJpdHlfZ2Z4X3N1Ym1pc3Np
b25fdGVzdCh2b2lkKTsKPiAgCj4gIENVX0JPT0wgc3VpdGVfc2VjdXJpdHlfdGVzdHNfZW5hYmxl
KHZvaWQpCj4gIHsKPiBAQCAtNzUsNiArNzYsNyBAQCBpbnQgc3VpdGVfc2VjdXJpdHlfdGVzdHNf
Y2xlYW4odm9pZCkKPiAgCj4gIENVX1Rlc3RJbmZvIHNlY3VyaXR5X3Rlc3RzW10gPSB7Cj4gIAl7
ICJhbGxvY2F0ZSBzZWN1cmUgYnVmZmVyIHRlc3QiLCBhbWRncHVfc2VjdXJpdHlfYWxsb2NfYnVm
X3Rlc3QgfSwKPiArCXsgImdyYXBoaWNzIHNlY3VyZSBjb21tYW5kIHN1Ym1pc3Npb24iLCBhbWRn
cHVfc2VjdXJpdHlfZ2Z4X3N1Ym1pc3Npb25fdGVzdCB9LAo+ICAJQ1VfVEVTVF9JTkZPX05VTEws
Cj4gIH07Cj4gIAo+IEBAIC0xMTMsMyArMTE1LDEwIEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9zZWN1
cml0eV9hbGxvY19idWZfdGVzdCh2b2lkKQo+ICAJciA9IGdwdV9tZW1fZnJlZShibywgdmFfaGFu
ZGxlLCBib19tYywgNDA5Nik7Cj4gIAlDVV9BU1NFUlRfRVFVQUwociwgMCk7Cj4gIH0KPiArCj4g
K3N0YXRpYyB2b2lkIGFtZGdwdV9zZWN1cml0eV9nZnhfc3VibWlzc2lvbl90ZXN0KHZvaWQpCj4g
K3sKPiArCWFtZGdwdV9jb21tYW5kX3N1Ym1pc3Npb25fd3JpdGVfbGluZWFyX2hlbHBlcl93aXRo
X3NlY3VyZShkZXZpY2VfaGFuZGxlLAo+ICsJCQkJCQkJCSAgQU1ER1BVX0hXX0lQX0dGWCwKPiAr
CQkJCQkJCQkgIHRydWUpOwo+ICt9Cj4gLS0gCj4gMi43LjQKPiAKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
