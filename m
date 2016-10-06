From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: initialize the context reset_counter in
 amdgpu_ctx_init
Date: Thu, 6 Oct 2016 16:43:19 +0200
Message-ID: <CAAxE2A6FHmQhfzxAiq9-pMi+LkyJ6PAqvZi_-MV-xX1sZ_vv-A@mail.gmail.com>
References: <1475567106-5818-1-git-send-email-nhaehnle@gmail.com>
 <2d749b1b-5d1b-f0bc-502b-358acf09e04a@vodafone.de>
 <CAAxE2A55JNWJ3hP5MtbHA=Jz_5bKQDnfvvTrwvW-g2LiDf8TrA@mail.gmail.com>
 <CADnq5_O8-D7hS5riU-7izo-jxh7fLTMYfpevcbBJqJHbKmKXjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_O8-D7hS5riU-7izo-jxh7fLTMYfpevcbBJqJHbKmKXjQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>

T24gVGh1LCBPY3QgNiwgMjAxNiBhdCA0OjI0IFBNLCBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVy
QGdtYWlsLmNvbT4gd3JvdGU6Cj4gT24gVGh1LCBPY3QgNiwgMjAxNiBhdCA2OjI4IEFNLCBNYXJl
ayBPbMWhw6FrIDxtYXJhZW9AZ21haWwuY29tPiB3cm90ZToKPj4gRG8gd2UgbmVlZCB0byBidW1w
IHRoZSBEUk0gdmVyc2lvbiBmb3IgdGhpcyBidWcgZml4Pwo+Pgo+Cj4gQWx0ZXJuYXRpdmVseSwg
d2UgY291bGQganVzdCBjYyBzdGFibGUuICBCZWluZyB0aGF0IHRoZSB3aG9sZSByZXNldAo+IGhh
bmRsaW5nIGlzIG1lc2EgaXMgdGlsbCBraW5kIG9mIHVwIGluIHRoZSBhaXIsIEknbSBub3Qgc3Vy
ZSBob3cKPiBjcml0aWNhbCBpdCBpcy4KClRoZSBNZXNhIHBhcnQgaXMgYWN0dWFsbHkgY29tcGxl
dGUuIFRoZSBwcm9ibGVtIGlzIHRoYXQgaWYgYW4KYXBwbGljYXRpb24gcmVxdWVzdHMgdGhlIEdM
X0xPU0VfQ09OVEVYVF9PTl9SRVNFVCBzdHJhdGVneSwgYW4KaW5jb3JyZWN0IHJlc2V0IGNvdW50
ZXIgcmV0dXJuZWQgYnkgdGhlIGtlcm5lbCB3aWxsIGF1dG9tYXRpY2FsbHkga2lsbAp0aGUgT3Bl
bkdMIGNvbnRleHQgKGJ5IHNldHRpbmcgdGhlIG5vLW9wIGRpc3BhdGNoKSwgc28gaXQncyBhIHBy
ZXR0eQpzZXJpb3VzIGlzc3VlIGFuZCB0aGUga2VybmVsIHNob3VsZCByZXR1cm4gY29ycmVjdCB2
YWx1ZXMgcmVnYXJkbGVzcwpvZiB0aGUgc3RhdGUgb2YgR1BVIHJlc2V0IHRoZXJlLiBJZiB0aGUg
a2VybmVsIHJldHVybnMgYW4gaW5jb3JyZWN0CnJlc2V0IGNvdW50ZXIsIHdlIG5lZWQgYSB2ZXJz
aW9uIGJ1bXAgZm9yIHRoZSBmaXguCgpNYXJlawpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
