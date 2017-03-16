From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: linux-4.11-rc1/drivers/gpu/drm/amd/amdgpu/vi.c: 3 bugs
Date: Wed, 15 Mar 2017 22:07:37 -0400
Message-ID: <CADnq5_PBOkkMB_c4eR-wg6a3bGHzSfeM1sr1UMpz_jsVoHtyog@mail.gmail.com>
References: <DB5PR08MB096711F1A243B7E14ADFB1349C2C0@DB5PR08MB0967.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <DB5PR08MB096711F1A243B7E14ADFB1349C2C0@DB5PR08MB0967.eurprd08.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: David Binderman <dcb314@hotmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "alexander.deucher@amd.com" <alexander.deucher@amd.com>, "christian.koenig@amd.com" <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCBNYXIgNiwgMjAxNyBhdCA0OjQwIEFNLCBEYXZpZCBCaW5kZXJtYW4gPGRjYjMxNEBo
b3RtYWlsLmNvbT4gd3JvdGU6Cj4KPiBIZWxsbyB0aGVyZSwKPiAxCj4KPiBbbGludXgtNC4xMS1y
YzEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmkuYzoxMDQxXSAtPiBbbGludXgtNC4xMS1y
YzEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmkuYzoxMDM3XTogKHN0eWxlKSBTYW1lIGV4
cHJlc3Npb24gb24gYm90aCBzaWRlcyBvZiAnfCcuCj4KPiBNYXliZSB0aGUgbWFjcm8gQU1EX0NH
X1NVUFBPUlRfR0ZYX01HTFMgaXMgdXNlZCB0d2ljZSA/Cj4KPiAyLgo+Cj4gW2xpbnV4LTQuMTEt
cmMxL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmM6MTA3MF0gLT4gW2xpbnV4LTQuMTEt
cmMxL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmM6MTA2Nl06IChzdHlsZSkgU2FtZSBl
eHByZXNzaW9uIG9uIGJvdGggc2lkZXMgb2YgJ3wnLgo+Cj4gRHVwbGljYXRlLgo+Cj4gSW4gdGhl
IHNhbWUgZmlsZToKPgo+IGxpbnV4LTQuMTEtcmMxL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3ZpLmM6NzkyXTogKHN0eWxlKSBWYXJpYWJsZSAncicgaXMgYXNzaWduZWQgYSB2YWx1ZSB0aGF0
IGlzIG5ldmVyIHVzZWQuCj4KPiBTb3VyY2UgY29kZSBpcwo+Cj4gICAgIHIgPSB2aV9zZXRfdXZk
X2Nsb2NrKGFkZXYsIGRjbGssIGl4Q0dfRENMS19DTlRMLCBpeENHX0RDTEtfU1RBVFVTKTsKPgo+
ICAgICByZXR1cm4gMDsKClRoYW5rcywgcGF0Y2hlcyBzZW50LgoKQWxleAoKPgo+IFJlZ2FyZHMK
Pgo+IERhdmlkIEJpbmRlcm1hbgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
