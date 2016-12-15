From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] drm/amd/amdgpu: get maximum and used UVD handles (v3)
Date: Fri, 16 Dec 2016 00:43:09 +0200
Message-ID: <CANOLnOMr=gMWiU624dRkY8Nr7XdyzCNbknPhkuShLCrVQEjqUg@mail.gmail.com>
References: <1481568592-3509-1-git-send-email-arindam.nath@amd.com>
 <CACvgo50-nTuLrQCHdPEV7StEphsR_s5YN+WRqPLgjnkLE=Bscw@mail.gmail.com>
 <CY4PR12MB1432DB75A9FD33E6C363DF979C9D0@CY4PR12MB1432.namprd12.prod.outlook.com>
 <CACvgo53wgfMfdcXFWy1FrRKUexJjm-_64gMFA5kkAwvWLJKb7w@mail.gmail.com>
 <CY4PR12MB143243FF0D2E5422635A52659C9D0@CY4PR12MB1432.namprd12.prod.outlook.com>
 <CANOLnOOG5xsMXy7V++LR5QOSpvjVjTyYEB=DDJ60xBMTagOcPg@mail.gmail.com>
 <CY4PR12MB143264E7BBC2F015F08D355D9C9D0@CY4PR12MB1432.namprd12.prod.outlook.com>
 <a72e3677-2482-6c6f-2978-ded71a482995@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a72e3677-2482-6c6f-2978-ded71a482995-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ML dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Nath,
 Arindam" <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

T24gVGh1LCBEZWMgMTUsIDIwMTYgYXQgNDoxMiBQTSwgQ2hyaXN0aWFuIEvDtm5pZwo8ZGVhdGhz
aW1wbGVAdm9kYWZvbmUuZGU+IHdyb3RlOgo+Cj4gUmVnYXJkaW5nIHdoaWNoIGVycm9yIGNvZGUg
dG8gcmV0dXJuIEkgdGhpbmsgdGhhdCBFbWlsIGhhcyB0aGUgcmlnaHQgaWRlYQo+IGhlcmUuCj4K
PiBSZXR1cm5pbmcgLUVJTlZBTCB1c3VhbGx5IG1lYW5zIHRoYXQgdXNlcnNwYWNlIHByb3ZpZGVk
IGFuIGludmFsaWQgdmFsdWUsCj4gYnV0IGluIHRoaXMgY2FzZSBpdCBkb2Vzbid0IG1hdHRlciB3
aGljaCB2YWx1ZSB0aGUgVU1EIHByb3ZpZGUgYWxsIG9mIHRoZW0KPiB3b3VsZCBiZSBpbnZhbGlk
IGJlY2F1c2Ugc3RhcnRpbmcgd2l0aCBQb2xhcmlzIHRoZSBoYXJkd2FyZS9maXJtd2FyZSBzaW1w
bHkKPiBkb2Vzbid0IHdvcmsgdGhpcyB3YXkgYW55IG1vcmUuCj4KPiBTbyB1c2luZyAtRU5PREVW
IG9yIG1heWJlIC1FTk9EQVRBIGluZGVlZCBzb3VuZCBsaWtlIHRoZSByaWdodCB0aGluayB0byBk
bwo+IGhlcmUuCgpXaGF0IGFib3V0IEVSQU5HRSB0aGVuLCAiTWF0aCByZXN1bHQgbm90IHJlcHJl
c2VudGFibGUiIGFrYSBpbmZpbml0eT8KVG8gbWUgRU5PREVWIGlzIG1vcmUgbGlrZSAidGhlIEdQ
VSB5b3UgYXJlIGFza2luZyBhYm91dCBpcyBub3QgdGhlcmUiCmFuZCBFTk9EQVRBICJpbmZvcm1h
dGlvbiB5b3UgYXNrIGZvciBpcyBub3Qga25vd24iLCBhbHRob3VnaCB0aGUgbGF0ZXIKc3RpbGwg
c29tZXdoYXQgbWFrZXMgc2Vuc2UuCgpHcmHFvnZ5ZGFzCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
