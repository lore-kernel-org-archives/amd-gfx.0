From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix the ib test hang when gfx is in "idle"
 state
Date: Mon, 23 Apr 2018 17:52:30 +0800
Message-ID: <20180423095228.GA23608@hr-amur2>
References: <1524217255-25968-1-git-send-email-ray.huang@amd.com>
 <aaaffd0c-96be-29b2-9bd4-df6fa6ea7e8a@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <aaaffd0c-96be-29b2-9bd4-df6fa6ea7e8a-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "S,
 Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>

T24gRnJpLCBBcHIgMjAsIDIwMTggYXQgMDU6NTk6MTZQTSArMDgwMCwgS29lbmlnLCBDaHJpc3Rp
YW4gd3JvdGU6Cj4gQW0gMjAuMDQuMjAxOCB1bSAxMTo0MCBzY2hyaWViIEh1YW5nIFJ1aToKPiA+
ICJhYWFiYWY0ICAgZHJtL2FtZGdwdTogZGVmZXIgdGVzdCBJQnMgb24gdGhlIHJpbmdzIGF0IGJv
b3QgKFYzKSIKPiA+IEFib3ZlIHBhdGNoIGRlZmVycyB0aGUgZXhlY3V0aW9uIG9mIGdmeC9jb21w
dXRlIGliIHRlc3RzLiBIb3dldmVyLCBhdCB0aGF0IHRpbWUsCj4gPiB0aGUgZ2Z4IG1heSBhbHJl
YWR5IGdvIGludG8gaWRsZSBzdGF0ZS4gSWYgImlkbGUiIGdmeCByZWNlaXZlcyBjb21tYW5kCj4g
PiBzdWJtaXNzaW9uLCBpdCB3aWxsIGdldCBoYW5nIGluIHRoZSBzeXN0ZW0uIFNvIHdlIG11c3Qg
YWRkIGlzX2dmeF9vbiBjaGVja2luZyBhdAo+ID4gc3RhcnQgb2YgaWIgdGVzdHMuCj4gCj4gRG8g
SSBzZWUgdGhhdCByaWdodCB0aGF0IHlvdSBqdXN0IHNraXAgdGhlIElCIHRlc3Qgd2hlbiB0aGUg
R0ZYIGJsb2NrIGlzIAo+IGFscmVhZHkgdHVybmVkIG9mPyBJbiB0aGlzIGNhc2UgdGhhdCB3b3Vs
ZCBiZSBhIGNsZWFyIE5BSy4KPiAKPiBCVFc6IEhvdyBkbyB5b3UgZGV0ZWN0IHRoYXQgd2UgbmVl
ZCB0byB0dXJuIEdGWCBvbiBhZ2Fpbj8KCkNocmlzdGlhbiwgSSBrbm93IHBvaW50LiBCdXQgdGhl
cmUgaXMgYSBoYW5nIGlzc3VlIGlmIHdlIHdvdWxkIGxpa2UgdHJ5IHRvCmRpc2FibGUvZW5hYmxl
IGdmeG9mZiB3aXRoIFNNQyBtZXNzYWdlIGF0IHJ1bnRpbWUuIEFjdHVhbGx5LCBJIGFtIHRyeWlu
ZyB0bwpmaW5kIGEgZ29vZCBzZXF1ZW5jZSB0byBmaXggaXQuIEFmdGVyIHRoYXQsIEkgY2FuIGV2
ZW4gZXhwb3NlIGFuIGRlYnVnZnMKaW50ZXJmYWNlIHRvIGNvbmZpZ3VyZSB0aGF0LiBTbyBJIGhh
dmUgdG8gc2tpcCB0aGUgdGVzdCBmb3IgdGhlIG1vbWVudCB3aGVuCmdmeCBpcyBpbiAiaWRsZSIu
CgpUaGFua3MsClJheQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
