From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 1/5] drm/amdgpu/sdma4: drop unused register header
Date: Fri, 28 Jul 2017 10:56:51 +0200
Message-ID: <b218e240-4c94-6372-f3cc-c92664f04ecf@vodafone.de>
References: <1501184765-26699-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1501184765-26699-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Frank Min <Frank.Min-5C7GfCeVMHo@public.gmane.org>

QW0gMjcuMDcuMjAxNyB1bSAyMTo0NiBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBuYmlvIHJlZ2lz
dGVycyBhcmUgbm90IHVzZWQgaW4gdGhpcyBmaWxlLgo+Cj4gQ2M6IEZyYW5rIE1pbiA8RnJhbmsu
TWluQGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPgoKUGF0Y2hlcyAjMSBhbmQgIzMtIzUgYXJlIFJldmlld2VkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIAo8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPi4KCkkgYWdyZWUgd2l0aCBG
ZWxpeCB0aGF0ICMyIGxvb2tzIGEgYml0IHVnbHksIGJ1dCB1c2luZyB3cml0ZXEgZG9lc24ndCAK
c291bmRzIGxpa2UgdGhlIGNvcnJlY3QgYW5zd2VyIGVpdGhlci4KCklmIFdSSVRFX09OQ0UoKSBk
b2VzIHRoZSBqb2IgdGhlbiBJIHdvdWxkIHVzZSB0aGF0IG9uZS4KCkNocmlzdGlhbi4KCj4gLS0t
Cj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYyB8IDEgLQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Nk
bWFfdjRfMC5jCj4gaW5kZXggNWMyNDcwOC4uN2NiNTMyMCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NkbWFfdjRfMC5jCj4gQEAgLTM1LDcgKzM1LDYgQEAKPiAgICNpbmNsdWRlICJ2
ZWdhMTAvTU1IVUIvbW1odWJfMV8wX29mZnNldC5oIgo+ICAgI2luY2x1ZGUgInZlZ2ExMC9NTUhV
Qi9tbWh1Yl8xXzBfc2hfbWFzay5oIgo+ICAgI2luY2x1ZGUgInZlZ2ExMC9IRFAvaGRwXzRfMF9v
ZmZzZXQuaCIKPiAtI2luY2x1ZGUgInZlZ2ExMC9OQklPL25iaW9fNl8xX29mZnNldC5oIgo+ICAg
I2luY2x1ZGUgInJhdmVuMS9TRE1BMC9zZG1hMF80XzFfZGVmYXVsdC5oIgo+ICAgCj4gICAjaW5j
bHVkZSAic29jMTVfY29tbW9uLmgiCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
