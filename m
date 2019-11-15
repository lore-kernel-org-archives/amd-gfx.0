From: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 12/12] tests/amdgpu: add test to submit a sdma command
 with secure context
Date: Fri, 15 Nov 2019 10:07:32 +0000
Message-ID: <MN2PR12MB33096C5AEA6FD6946663F8F4EC700@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
 <1573788895-3936-12-git-send-email-aaron.liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1573788895-3936-12-git-send-email-aaron.liu-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <907875A79CA2AB4E9BB2034FB8FC50DE-t0aD9ArCiwdO0n7uQEQMm4CZgX+1HZI1@public.gmane.org>
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

T24gRnJpLCBOb3YgMTUsIDIwMTkgYXQgMTE6MzQ6NTVBTSArMDgwMCwgTGl1LCBBYXJvbiB3cm90
ZToKPiBUaGlzIHBhdGNoIGFkZCB0ZXN0IHRvIHN1Ym1pdCBhIHNkbWEgY29tbWFuZCB3aXRoIHNl
Y3VyZSBjb250ZXh0Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFhcm9uIExpdSA8YWFyb24ubGl1QGFt
ZC5jb20+CgpSZXZpZXdlZC1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KCj4gLS0t
Cj4gIHRlc3RzL2FtZGdwdS9zZWN1cml0eV90ZXN0cy5jIHwgMTAgKysrKysrKysrKwo+ICAxIGZp
bGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS90ZXN0cy9hbWRn
cHUvc2VjdXJpdHlfdGVzdHMuYyBiL3Rlc3RzL2FtZGdwdS9zZWN1cml0eV90ZXN0cy5jCj4gaW5k
ZXggMGJiNGFkMi4uZWIyMzlmNCAxMDA2NDQKPiAtLS0gYS90ZXN0cy9hbWRncHUvc2VjdXJpdHlf
dGVzdHMuYwo+ICsrKyBiL3Rlc3RzL2FtZGdwdS9zZWN1cml0eV90ZXN0cy5jCj4gQEAgLTMzLDYg
KzMzLDggQEAgc3RhdGljIHVpbnQzMl90IG1pbm9yX3ZlcnNpb247Cj4gIAo+ICBzdGF0aWMgdm9p
ZCBhbWRncHVfc2VjdXJpdHlfYWxsb2NfYnVmX3Rlc3Qodm9pZCk7Cj4gIHN0YXRpYyB2b2lkIGFt
ZGdwdV9zZWN1cml0eV9nZnhfc3VibWlzc2lvbl90ZXN0KHZvaWQpOwo+ICtzdGF0aWMgdm9pZCBh
bWRncHVfc2VjdXJpdHlfc2RtYV9zdWJtaXNzaW9uX3Rlc3Qodm9pZCk7Cj4gKwo+ICAKPiAgQ1Vf
Qk9PTCBzdWl0ZV9zZWN1cml0eV90ZXN0c19lbmFibGUodm9pZCkKPiAgewo+IEBAIC03Nyw2ICs3
OSw3IEBAIGludCBzdWl0ZV9zZWN1cml0eV90ZXN0c19jbGVhbih2b2lkKQo+ICBDVV9UZXN0SW5m
byBzZWN1cml0eV90ZXN0c1tdID0gewo+ICAJeyAiYWxsb2NhdGUgc2VjdXJlIGJ1ZmZlciB0ZXN0
IiwgYW1kZ3B1X3NlY3VyaXR5X2FsbG9jX2J1Zl90ZXN0IH0sCj4gIAl7ICJncmFwaGljcyBzZWN1
cmUgY29tbWFuZCBzdWJtaXNzaW9uIiwgYW1kZ3B1X3NlY3VyaXR5X2dmeF9zdWJtaXNzaW9uX3Rl
c3QgfSwKPiArCXsgInNkbWEgc2VjdXJlIGNvbW1hbmQgc3VibWlzc2lvbiIsIGFtZGdwdV9zZWN1
cml0eV9zZG1hX3N1Ym1pc3Npb25fdGVzdCB9LAo+ICAJQ1VfVEVTVF9JTkZPX05VTEwsCj4gIH07
Cj4gIAo+IEBAIC0xMjIsMyArMTI1LDEwIEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9zZWN1cml0eV9n
Znhfc3VibWlzc2lvbl90ZXN0KHZvaWQpCj4gIAkJCQkJCQkJICBBTURHUFVfSFdfSVBfR0ZYLAo+
ICAJCQkJCQkJCSAgdHJ1ZSk7Cj4gIH0KPiArCj4gK3N0YXRpYyB2b2lkIGFtZGdwdV9zZWN1cml0
eV9zZG1hX3N1Ym1pc3Npb25fdGVzdCh2b2lkKQo+ICt7Cj4gKwlhbWRncHVfY29tbWFuZF9zdWJt
aXNzaW9uX3dyaXRlX2xpbmVhcl9oZWxwZXJfd2l0aF9zZWN1cmUoZGV2aWNlX2hhbmRsZSwKPiAr
CQkJCQkJCQkgIEFNREdQVV9IV19JUF9ETUEsCj4gKwkJCQkJCQkJICB0cnVlKTsKPiArfQo+IC0t
IAo+IDIuNy40Cj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
