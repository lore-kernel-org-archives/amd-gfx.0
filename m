From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 05/22] drm/amdgpu: cond_exec only for schedule with a job
Date: Mon, 26 Feb 2018 10:53:10 +0100
Message-ID: <e4c0937e-2b97-3a9f-0e11-18cf7be9bd82@gmail.com>
References: <1519622300-8990-1-git-send-email-Monk.Liu@amd.com>
 <1519622300-8990-6-git-send-email-Monk.Liu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1519622300-8990-6-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjYuMDIuMjAxOCB1bSAwNjoxOCBzY2hyaWViIE1vbmsgTGl1Ogo+IGlzc3VlOgo+IHVuZGVy
IFNSLUlPViBzb21ldGltZXMgdGhlIGlCIHRlc3Qgd2lsbCBmYWlsIG9uCj4gZ2Z4IHJpbmcKPgo+
IGZpeDoKPiB3aXRoIGNvbmRfZXhlYyBpbnNlcnRlZCBpbiBSQiB0aGUgZ2Z4IGVuZ2luZSB3b3Vs
ZAo+IHNraXAgcGFydCBwYWNrZXRzIGlmIFJMQ1YgaXNzdWUgUFJFRU1QVCBvbiBnZnggZW5naW5l
Cj4gaWYgZ2Z4IGVuZ2luZSBpcyBwcmlvciB0byBDT05EX0VYRUMgcGFja2V0LCB0aGlzIGlzCj4g
b2theSBmb3IgcmVndWxhciBjb21tYW5kIGZyb20gVU1ELCBidXQgZm9yIHRoZSBpYiB0ZXN0Cj4g
c2luY2UgdGhlIHdob2xlIGRtYSBmb3JtYXQgZG9lc24ndCBzdXBwb3J0IFBSRUVNUFQKPiBzbyBt
dXN0IHJlbW92ZSB0aGUgQ09ORF9FWEVDIGZyb20gaXQuCj4KPiBDaGFuZ2UtSWQ6IEk3M2JkMDQ3
OWJmMTMwNzEzOWZmMzcyNmEwMGMzMTI1MjYwNTRhYTZkCj4gU2lnbmVkLW9mZi1ieTogTW9uayBM
aXUgPE1vbmsuTGl1QGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9pYi5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2liLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYwo+
IGluZGV4IDhlYTM0MmQuLjdmMmMzMTQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2liLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfaWIuYwo+IEBAIC0xODEsNyArMTgxLDcgQEAgaW50IGFtZGdwdV9pYl9zY2hlZHVsZShz
dHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsIHVuc2lnbmVkIG51bV9pYnMsCj4gICAJCX0KPiAgIAl9
Cj4gICAKPiAtCWlmIChyaW5nLT5mdW5jcy0+aW5pdF9jb25kX2V4ZWMpCj4gKwlpZiAoam9iICYm
IHJpbmctPmZ1bmNzLT5pbml0X2NvbmRfZXhlYykKPiAgIAkJcGF0Y2hfb2Zmc2V0ID0gYW1kZ3B1
X3JpbmdfaW5pdF9jb25kX2V4ZWMocmluZyk7Cj4gICAKPiAgICNpZmRlZiBDT05GSUdfWDg2XzY0
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
