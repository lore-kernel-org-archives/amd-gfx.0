From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: Fix multi-level page table bugs for large
 BOs
Date: Wed, 29 Mar 2017 23:46:27 +0900
Message-ID: <a2d6c20e-d35f-e135-342b-47f86683c3e3@daenzer.net>
References: <1490749231-16157-1-git-send-email-Felix.Kuehling@amd.com>
 <1490749231-16157-4-git-send-email-Felix.Kuehling@amd.com>
 <58DB21CB.4090800@amd.com>
 <DM5PR1201MB0235AB2363725D0D8320265292350@DM5PR1201MB0235.namprd12.prod.outlook.com>
 <58DB4D02.7020903@amd.com> <8acdbd65-f99d-3e0e-b61b-318cf27d7a3b@vodafone.de>
 <bdbacee3-2c61-ebcb-1421-5c0a77dc27e0@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <bdbacee3-2c61-ebcb-1421-5c0a77dc27e0-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Russell,
 Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjkvMDMvMTcgMTE6MzIgUE0sIEZlbGl4IEt1ZWhsaW5nIHdyb3RlOgo+IE9uIDE3LTAzLTI5
IDAyOjUyIEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pgo+PiBQbGVhc2UgY2xlYW4gdGhh
dCB1cCBhbmQgYWxzbyByZW1vdmUgYWxsIHRob3NlIFdBUk5fT04oKSwgd2UgZG9uJ3QKPj4gd2Fu
dCB0byBzcGFtIHRoZSBzeXN0ZW0gbG9nIHdpdGggYmFja3RyYWNlcyBsaWtlIHRoaXMuCj4gCj4g
SSBkaXNhZ3JlZS4gV2hlbiB5b3Ugc2VlIHRoZSBiYWNrdHJhY2VzIGZyb20gV0FSTl9PTnMgaW4K
PiBhbWRncHVfdm1fZ2V0X3B0LCBpdCBtZWFucyB0aGUgZHJpdmVyIGlzIHRyeWluZyB0byB1cGRh
dGUgYSBwYWdlIHRhYmxlCj4gdGhhdCBoYXNuJ3QgYmVlbiBhbGxvY2F0ZWQuIFdpdGhvdXQgdGhv
c2UgV0FSTl9PTnMgdGhlcmUgaXMgYWJzb2x1dGVseQo+IG5vIHdhcm5pbmcgb2YgYW55IGtpbmQg
LSBhbWRncHVfdm1fdXBkYXRlX3B0ZSBqdXN0IGZhaWxzIHNpbGVudGx5IChpdCdzCj4gYSB2b2lk
IGZ1bmN0aW9uKS4KPiAKPiBUaGVyZWZvcmUgSSB3b3VsZG4ndCBjYWxsIHRob3NlIHdhcm5pbmdz
IHNwYW0uIEdpdmVuIHRoYXQgdGhlIFZNIFBUCj4gYWxsb2NhdGlvbiBjb2RlIGZvciBtdWx0aS1s
ZXZlbHMgaXMgbm9uLXRyaXZpYWwsIEkgdGhpbmsgdGhhdCdzIGEgZ29vZAo+IHNhbml0eSBjaGVj
ayB0byBoYXZlIGFuZCByZWFsbHkgaGVscGZ1bCB0byBzZWUgaW4gYSBsb2cgd2hlbiB1c2VyIHJl
cG9ydAo+IHJhbmRvbSBWTSBmYXVsdHMuCgpXQVJOX09OX09OQ0UgbWlnaHQgYmUgYSBjb21wcm9t
aXNlLiBXZSdsbCBzdGlsbCBnZXQgYSBiYWNrdHJhY2UsIGJ1dCBpdAp3b24ndCBjYXVzZSBjcmF6
eSBsb2cgc3BhbSBpZiB0aGUgYmFkIGNvbmRpdGlvbiBpcyBjb25zaXN0ZW50bHkgaGl0LgoKCi0t
IApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAg
aHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAg
fCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
