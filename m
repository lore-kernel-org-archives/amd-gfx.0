From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix the memory corruption on S3
Date: Thu, 29 Jun 2017 16:15:09 +0800
Message-ID: <20170629081508.GA12625@hr-amur2>
References: <1498719798-8435-1-git-send-email-ray.huang@amd.com>
 <86b9418d-450e-9101-517d-8d1ae7c8b358@daenzer.net>
 <20170629075910.GA10514@hr-amur2>
 <d86cec19-7927-c29e-d2fb-fdaf589e3369@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d86cec19-7927-c29e-d2fb-fdaf589e3369-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "Huan, Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, "Qiao,
 Joe(Markham)" <Joe2.Qiao-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Jiang,
 Sonny" <Sonny.Jiang-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

T24gVGh1LCBKdW4gMjksIDIwMTcgYXQgMDQ6MDc6MzNQTSArMDgwMCwgTWljaGVsIETDpG56ZXIg
d3JvdGU6Cj4gT24gMjkvMDYvMTcgMDQ6NTkgUE0sIEh1YW5nIFJ1aSB3cm90ZToKPiA+IE9uIFRo
dSwgSnVuIDI5LCAyMDE3IGF0IDAzOjM0OjU3UE0gKzA4MDAsIE1pY2hlbCBEw6RuemVyIHdyb3Rl
Ogo+ID4+IE9uIDI5LzA2LzE3IDA0OjAzIFBNLCBIdWFuZyBSdWkgd3JvdGU6Cj4gPj4+IHBzcC0+
Y21kIHdpbGwgYmUgdXNlZCBvbiByZXN1bWUgcGhhc2UsIHNvIHdlIGNhbiBub3QgZnJlZSBpdCBv
biBod19pbml0Lgo+ID4+PiBPdGhlcndpc2UsIGEgbWVtb3J5IGNvcnJ1cHRpb24gd2lsbCBiZSB0
cmlnZ2VyZWQuCj4gPj4+Cj4gPj4+IFNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5n
QGFtZC5jb20+Cj4gPj4+IC0tLQo+ID4+Pgo+ID4+PiBBbGV4LCBDaHJpc3RpYW4sCj4gPj4+Cj4g
Pj4+IFRoaXMgaXMgdGhlIGZpbmFsIGZpeCBmb3IgdmVnYTEwIFMzLiBUaGUgcmFuZG9tIG1lbW9y
eSBjb3JydXB0aW9uIGlzc3VlIGlzCj4gPj4gcm9vdAo+ID4+PiBjYXVzZWQuCj4gPj4+Cj4gPj4+
IFRoYW5rcywKPiA+Pj4gUmF5Cj4gPj4+Cj4gPj4+IC0tLQo+ID4+PiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIHwgOCArKysrKystLQo+ID4+PiAgMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+Pj4KPiA+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvCj4gPj4gYW1kZ3B1L2FtZGdwdV9wc3AuYwo+ID4+PiBpbmRleCA1MDQxMDczLi5m
Y2RkNTQyIDEwMDY0NAo+ID4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcHNwLmMKPiA+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Bz
cC5jCj4gPj4+IEBAIC0zNzIsOCArMzcyLDYgQEAgc3RhdGljIGludCBwc3BfbG9hZF9mdyhzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiA+Pj4gICAgICAgIGlmIChyZXQpCj4gPj4+ICAgICAg
ICAgICAgICAgIGdvdG8gZmFpbGVkX21lbTsKPiA+Pj4KPiA+Pj4gLSAgICAga2ZyZWUoY21kKTsK
PiA+Pj4gLQo+ID4+PiAgICAgICAgcmV0dXJuIDA7Cj4gPj4KPiA+PiBUaGlzIGxvb2tzIGxpa2Ug
YSBnb29kIGNhdGNoLgo+ID4+Cj4gPj4KPiA+Pj4gQEAgLTM4NCw2ICszODIsNyBAQCBzdGF0aWMg
aW50IHBzcF9sb2FkX2Z3KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ID4+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICZwc3AtPmZ3X3ByaV9tY19hZGRyLCAmcHNwLT5md19wcmlf
YnVmKTsKPiA+Pj4gIGZhaWxlZDoKPiA+Pj4gICAgICAgIGtmcmVlKGNtZCk7Cj4gPj4+ICsgICAg
IGNtZCA9IE5VTEw7Cj4gPj4KPiA+PiBUaGlzIHNob3VsZCBwcm9iYWJseSBiZQo+ID4+Cj4gPj4g
ICAgICAgICBwc3AtPmNtZCA9IE5VTEw7Cj4gPj4KPiA+PiBpbnN0ZWFkPwo+ID4+Cj4gPgo+ID4g
QWN0dWFsbHksIHdlIHNldCBwc3AtPmNtZCA9IGNtZCBiZWZvcmUuCj4gPgo+ID4gQnV0IGFueXdh
eSwgd2UgbmVlZG4ndCAiY21kIiBtZW1iZXIgYW55IG1vcmUuCj4gCj4gWW91IHNob3VsZCBwcm9i
YWJseSBzdGlsbCBzZXQgcHNwLT5jbWQgPSBOVUxMIGhlcmUsIG90aGVyd2lzZSBwc3AtPmNtZAo+
IHN0aWxsIGNvbnRhaW5zIHRoZSBwb2ludGVyIHRvIHRoZSBtZW1vcnkgdGhhdCBpcyBmcmVlZCBo
ZXJlLCB3aGljaCBjb3VsZAo+IHJlc3VsdCBpbiB1c2UtYWZ0ZXItZnJlZSBzb21ld2hlcmUgZWxz
ZS4KPiAKClJpZ2h0LCBJIGFscmVhZHkgZm91bmQgaXQgYW5kIHVwZGF0ZSBpdCBpbiBWMiwgcGxl
YXNlIHRha2UgYSBsb29rLgoKVGhhbmtzLApSYXkKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
