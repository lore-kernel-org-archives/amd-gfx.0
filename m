From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/1] drm/amd/amdgpu: get maximum and used UVD handles (v3)
Date: Mon, 2 Jan 2017 11:16:19 +0100
Message-ID: <49079b30-e513-0505-7703-b015b25f6ecb@amd.com>
References: <1481568592-3509-1-git-send-email-arindam.nath@amd.com>
 <CACvgo50-nTuLrQCHdPEV7StEphsR_s5YN+WRqPLgjnkLE=Bscw@mail.gmail.com>
 <CY4PR12MB1432DB75A9FD33E6C363DF979C9D0@CY4PR12MB1432.namprd12.prod.outlook.com>
 <CACvgo53wgfMfdcXFWy1FrRKUexJjm-_64gMFA5kkAwvWLJKb7w@mail.gmail.com>
 <CY4PR12MB143243FF0D2E5422635A52659C9D0@CY4PR12MB1432.namprd12.prod.outlook.com>
 <CANOLnOOG5xsMXy7V++LR5QOSpvjVjTyYEB=DDJ60xBMTagOcPg@mail.gmail.com>
 <CY4PR12MB143264E7BBC2F015F08D355D9C9D0@CY4PR12MB1432.namprd12.prod.outlook.com>
 <a72e3677-2482-6c6f-2978-ded71a482995@vodafone.de>
 <CANOLnOMr=gMWiU624dRkY8Nr7XdyzCNbknPhkuShLCrVQEjqUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CANOLnOMr=gMWiU624dRkY8Nr7XdyzCNbknPhkuShLCrVQEjqUg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ML dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Nath,
 Arindam" <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

QW0gMTUuMTIuMjAxNiB1bSAyMzo0MyBzY2hyaWViIEdyYXp2eWRhcyBJZ25vdGFzOgo+IE9uIFRo
dSwgRGVjIDE1LCAyMDE2IGF0IDQ6MTIgUE0sIENocmlzdGlhbiBLw7ZuaWcKPiA8ZGVhdGhzaW1w
bGVAdm9kYWZvbmUuZGU+IHdyb3RlOgo+PiBSZWdhcmRpbmcgd2hpY2ggZXJyb3IgY29kZSB0byBy
ZXR1cm4gSSB0aGluayB0aGF0IEVtaWwgaGFzIHRoZSByaWdodCBpZGVhCj4+IGhlcmUuCj4+Cj4+
IFJldHVybmluZyAtRUlOVkFMIHVzdWFsbHkgbWVhbnMgdGhhdCB1c2Vyc3BhY2UgcHJvdmlkZWQg
YW4gaW52YWxpZCB2YWx1ZSwKPj4gYnV0IGluIHRoaXMgY2FzZSBpdCBkb2Vzbid0IG1hdHRlciB3
aGljaCB2YWx1ZSB0aGUgVU1EIHByb3ZpZGUgYWxsIG9mIHRoZW0KPj4gd291bGQgYmUgaW52YWxp
ZCBiZWNhdXNlIHN0YXJ0aW5nIHdpdGggUG9sYXJpcyB0aGUgaGFyZHdhcmUvZmlybXdhcmUgc2lt
cGx5Cj4+IGRvZXNuJ3Qgd29yayB0aGlzIHdheSBhbnkgbW9yZS4KPj4KPj4gU28gdXNpbmcgLUVO
T0RFViBvciBtYXliZSAtRU5PREFUQSBpbmRlZWQgc291bmQgbGlrZSB0aGUgcmlnaHQgdGhpbmsg
dG8gZG8KPj4gaGVyZS4KPiBXaGF0IGFib3V0IEVSQU5HRSB0aGVuLCAiTWF0aCByZXN1bHQgbm90
IHJlcHJlc2VudGFibGUiIGFrYSBpbmZpbml0eT8KPiBUbyBtZSBFTk9ERVYgaXMgbW9yZSBsaWtl
ICJ0aGUgR1BVIHlvdSBhcmUgYXNraW5nIGFib3V0IGlzIG5vdCB0aGVyZSIKPiBhbmQgRU5PREFU
QSAiaW5mb3JtYXRpb24geW91IGFzayBmb3IgaXMgbm90IGtub3duIiwgYWx0aG91Z2ggdGhlIGxh
dGVyCj4gc3RpbGwgc29tZXdoYXQgbWFrZXMgc2Vuc2UuCgpTb3JyeSBmb3IgdGhlIGRlbGF5ZWQg
cmVwbHkuCgpJIHRoaW5rIEVEQVRBIHdvdWxkIHN0aWxsIG1ha2UgbW9yZSBzZW5zZSB0aGFuIEVS
QU5HRSwgYmVjYXVzZSB0aGUgCm51bWJlciBvZiBvcGVuIHNlc3Npb25zIGlzIHNpbXBseSBub3Qg
a25vd24gYW55IG1vcmUuCgpUaGF0IHRoZSBtYXhpbXVtIG51bWJlciBvZiBzZXNzaW9ucyBpcyBu
b3cgdW5saW1pdGVkIGlzIGp1c3QgYSBzaWRlIAplZmZlY3Qgb2YgdGhlIG5ldyBoYW5kbGluZyBp
ZiB5b3UgYXNrIG1lLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+IEdyYcW+dnlkYXMKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
