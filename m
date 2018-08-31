From: Thomas Hellstrom <thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH libdrm] libdrm: Allow dynamic drm majors on linux
Date: Fri, 31 Aug 2018 16:46:53 +0200
Message-ID: <e656d26a-be98-cc9c-7962-fd74ad226c60@vmware.com>
References: <20180831115419.4922-1-thellstrom@vmware.com>
 <CACvgo50fT1JAfmCLeZT1STRe_nnPo9PQjgk9+S5VRk-o5P088w@mail.gmail.com>
 <bbb94b6f-c9d5-27ab-9e6d-4b4c1d85db8e@vmware.com>
 <33fb1ba6-cc44-f747-545b-9f877917933e@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <33fb1ba6-cc44-f747-545b-9f877917933e-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
Cc: VMware Graphics <linux-graphics-maintainer-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, ML dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMDgvMzEvMjAxOCAwNDozOCBQTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gWyBBZGRpbmcg
dGhlIGFtZC1nZnggbGlzdCBdCj4KPiBPbiAyMDE4LTA4LTMxIDM6MDUgcC5tLiwgVGhvbWFzIEhl
bGxzdHJvbSB3cm90ZToKPj4gT24gMDgvMzEvMjAxOCAwMjozMCBQTSwgRW1pbCBWZWxpa292IHdy
b3RlOgo+Pj4gT24gMzEgQXVndXN0IDIwMTggYXQgMTI6NTQsIFRob21hcyBIZWxsc3Ryb20gPHRo
ZWxsc3Ryb21Adm13YXJlLmNvbT4KPj4+IHdyb3RlOgo+Pj4+IFRvIGRldGVybWluZSB3aGV0aGVy
IGEgZGV2aWNlIG5vZGUgaXMgYSBkcm0gZGV2aWNlIG5vZGUgb3Igbm90LCB0aGUgY29kZQo+Pj4+
IGN1cnJlbnRseSBjb21wYXJlcyB0aGUgbm9kZSdzIG1ham9yIG51bWJlciB0byB0aGUgc3RhdGlj
IGRybSBtYWpvcgo+Pj4+IGRldmljZQo+Pj4+IG51bWJlci4KPj4+Pgo+Pj4+IFRoaXMgYnJlYWtz
IHRoZSBzdGFuZGFsb25lIHZtd2dmeCBkcml2ZXIgb24gWFdheWxhbmQgZHJpIGNsaWVudHMsCj4+
Pj4KPj4+IEFueSBwYXJ0aWN1bGFyIHJlYXNvbiB3aHkgdGhlIGNvZGUgZG9lc24ndCB1c2UgYSBm
aXhlZCBub2RlIHRoZXJlPwo+Pj4gSXQgd2lsbCBtYWtlIHRoZSBkaWZmIHZzIHRoZSBpbi1rZXJu
ZWwgZHJpdmVyIGEgYml0IHNtYWxsZXIuCj4+IEJlY2F1c2UgdGhlbiBpdCB3b24ndCBiZSBhYmxl
IHRvIGludGVyb3BlcmF0ZSB3aXRoIG90aGVyIGluLXRyZWUKPj4gZHJpdmVycywgbGlrZSB2aXJ0
dWFsIGRybSBkcml2ZXJzIG9yIHBhc3N0aHJvdWdoIHVzYiBkcm0gZHJpdmVycy4KPj4gVGhlcmUg
aXMgbm8gY2xlYW4gd2F5IHRvIHNoYXJlIHRoZSBtaW5vciBudW1iZXIgYWxsb2NhdGlvbiB3aXRo
IGluLXRyZWUKPj4gZHJtLCBzbyBzdGFuZGFsb25lIHZtd2dmeCBpcyB1c2luZyBkeW5hbWljIG1h
am9yIGFsbG9jYXRpb24uCj4gSSB3b25kZXIgd2h5IEkgaGF2ZW4ndCBoZWFyZCBvZiBhbnkgb2Yg
dGhlc2UgaXNzdWVzIHdpdGggdGhlIHN0YW5kYWxvbmUKPiB2ZXJzaW9uIG9mIGFtZGdwdSBzaGlw
cGVkIGluIHBhY2thZ2VkIEFNRCByZWxlYXNlcy4gRG9lcyB0aGF0IGFsc28gdXNlIGEKPiBkaWZm
ZXJlbnQgbWFqb3IgbnVtYmVyPyBJZiB5ZXMsIG1heWJlIGl0J3MganVzdCB0aGF0IG5vYm9keSBo
YXMgdHJpZWQKPiBYd2F5bGFuZCBjbGllbnRzIHdpdGggdGhhdCBkcml2ZXIuIElmIG5vLCBob3cg
ZG9lcyBpdCBhdm9pZCB0aGUgb3RoZXIKPiBpc3N1ZXMgZGVzY3JpYmVkIGFib3ZlPwo+Cj4KSXMg
c3RhbmRhbG9uZSBBTUQgc3VwcG9zZWQgdG8gYmUgYWJsZSB0byBjb2V4aXN0IHdpdGggaW4tdHJl
ZSBkcm0gZHJpdmVycz8KCi9UaG9tYXMKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
