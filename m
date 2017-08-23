From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH][drm-next] drm/amdgpu: remove duplicate return statement
Date: Wed, 23 Aug 2017 14:24:49 -0400
Message-ID: <8045f72d-34d5-473d-ac9b-56495698dc8f@amd.com>
References: <20170823131740.20930-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170823131740.20930-1-colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Content-Language: en-CA
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
To: Colin King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

SSBtdXN0IGhhdmUgYWRkZWQgdGhhdCBhY2NpZGVudGFsbHkgd2hlbiBjaGVycnktcGlja2luZyBh
biBpbnRlcm5hbApwYXRjaCBmb3IgdXBzdHJlYW1pbmcuIFRoYW5rcyBmb3IgY2F0Y2hpbmcgaXQu
CgpSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+CgpS
ZWdhcmRzLAogIEZlbGl4CgoKT24gMjAxNy0wOC0yMyAwOToxNyBBTSwgQ29saW4gS2luZyB3cm90
ZToKPiBGcm9tOiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPgo+Cj4g
UmVtb3ZlIGEgcmVkdW5kYW50IGlkZW50aWNhbCByZXR1cm4gc3RhdGVtZW50LCBpdCBoYXMgbm8g
dXNlLgo+Cj4gRGV0ZWN0ZWQgYnkgQ292ZXJpdHlTY2FuLCBDSUQjMTQ1NDU4NiAoIlN0cnVjdHVy
YWxseSBkZWFkIGNvZGUiKQo+Cj4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGlu
LmtpbmdAY2Fub25pY2FsLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2FtZGtmZF9nZnhfdjguYyB8IDEgLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlv
bigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9h
bWRrZmRfZ2Z4X3Y4LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2Zk
X2dmeF92OC5jCj4gaW5kZXggZmI2ZTVkYmQ1YTAzLi4zMDlmMjQxOWM2ZDggMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjguYwo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y4LmMKPiBA
QCAtMTU1LDcgKzE1NSw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qga2ZkMmtnZF9jYWxscyBrZmQy
a2dkID0gewo+ICBzdHJ1Y3Qga2ZkMmtnZF9jYWxscyAqYW1kZ3B1X2FtZGtmZF9nZnhfOF8wX2dl
dF9mdW5jdGlvbnModm9pZCkKPiAgewo+ICAJcmV0dXJuIChzdHJ1Y3Qga2ZkMmtnZF9jYWxscyAq
KSZrZmQya2dkOwo+IC0JcmV0dXJuIChzdHJ1Y3Qga2ZkMmtnZF9jYWxscyAqKSZrZmQya2dkOwo+
ICB9Cj4gIAo+ICBzdGF0aWMgaW5saW5lIHN0cnVjdCBhbWRncHVfZGV2aWNlICpnZXRfYW1kZ3B1
X2RldmljZShzdHJ1Y3Qga2dkX2RldiAqa2dkKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
