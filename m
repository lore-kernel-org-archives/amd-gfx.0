From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix re-program vm invalidate eng address
 range for gfxhub on resume
Date: Wed, 17 May 2017 16:33:42 +0800
Message-ID: <20170517083341.GB31947@hr-amur2>
References: <1495006729-17310-1-git-send-email-ray.huang@amd.com>
 <591BFF33.2010303@amd.com> <20170517075557.GA31947@hr-amur2>
 <73fa42d9-1994-83ed-db9f-7c601f8a4598@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <73fa42d9-1994-83ed-db9f-7c601f8a4598-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhou,
 David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Huan,
 Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>

T24gV2VkLCBNYXkgMTcsIDIwMTcgYXQgMDQ6MTY6MzFQTSArMDgwMCwgS29lbmlnLCBDaHJpc3Rp
YW4gd3JvdGU6Cj4gQW0gMTcuMDUuMjAxNyB1bSAwOTo1NSBzY2hyaWViIEh1YW5nIFJ1aToKPiA+
IE9uIFdlZCwgTWF5IDE3LCAyMDE3IGF0IDAzOjQzOjQ3UE0gKzA4MDAsIFpob3UsIERhdmlkKENo
dW5NaW5nKSB3cm90ZToKPiA+PiBCeSB0aGlzIGNoYW5nZSwgSSBzdWdnZXN0IHRvIHJlbW92ZSBt
bWh1Yi9nZnhodWJfdjFfMF9pcF9mdW5jcyBhbmQgdGhlaXIKPiA+PiBJUCBibG9jaywgdW5pZnkg
dGhlbSB0byBnbWMgaXAgYmxvY2ssIHRoaXMgd2F5IHdlIGNhbm5vdCBsb3N0IHNldHRpbmcKPiA+
PiB3aGVuIHJlc3VtZSBiYWNrLgo+ID4+Cj4gPiAgRnJvbSBodyBzaWRlLCB3byB3b24ndCBoYXZl
IHJlYWwgZ21jIHNpbmNlIHRoaXMgY2hpcCwgbW1odWIgYW5kIGdmeGh1YihnYykKPiA+IGluc3Rl
YWQgb2YgaXQuIE1heWJlIHdlIHdvdWxkIGJldHRlciB0byBhbGlnbiB3aXRoIGh3IGRlc2dpbi4K
PiAKPiBZZWFoLCBJIGhhZCBwYXRjaGVzIGZvciBkb2luZyBleGFjdGx5IHRoaXMgYnV0IHRoZW4g
ZGVjaWRlZCBkcm9wcGluZyBpdC4KPiAKPiBXaGF0IHdlIHNob3VsZCBkbyBpcyB0byBoYXZlIGFu
eSBvbmUgaW1wbGVtZW50YXRpb24gb2YgdGhlIGNvZGUgaGFuZGxpbmcKPiBib3RoIGh1YnMgYW5k
IHRoZW4gaGF2ZSBib3RoIGFzIHNlcGFyYXRlIElQIGJsb2NrIGluIHRoZSBsaXN0Lgo+IAo+IEFu
eXdheSBmb3Igbm93IGJvdGggcGF0Y2hlcyBhcmUgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7Zu
aWcKPiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPi4KPiAKPiBJIGFzc3VtZSB0aGF0IGZpbmFs
bHkgZml4ZXMgUzMgb24gVmVnYTEwPwo+IAoKTm8sIGJ1dCB0aGVzZSBmaXhlcyBoYXZlIGltcHJv
dmVtZW50IGZvciB0aGUgcmVzdWx0LgpXZSBjYW4gcGFzcyBhIHJvdW5kIG9mIGdmeC9jcC9zZG1h
IHRlc3QuCgpCdXQgaWYgd2UgdHJ5IHRvIHRlc3QgYSByb3VuZCBhZ2FpbiwgaXQgd2lsbCBlbmNv
dW50ZXIgVk0gZmF1bHQuCldpbGwgdGVsbCB5b3UgdGhlIGRldGFpbGVkIGluIGFub3RoZXIgdGhy
ZWFkLgoKVGhhbmtzLApSdWkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
