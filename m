From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/ttm: stop always moving BOs on the LRU on page fault
Date: Mon, 14 Jan 2019 17:27:42 +0100
Message-ID: <722f87ee-8967-692b-1e4c-5ef9dd24d0b9@daenzer.net>
References: <20190111131525.1269-1-christian.koenig@amd.com>
 <ed9615c4-99be-c690-6ea0-bbe3e107bab3@daenzer.net>
 <810303e7-d1bd-1e04-4e73-33d8202b2a05@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <810303e7-d1bd-1e04-4e73-33d8202b2a05-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOS0wMS0xMSA4OjEyIHAubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTEu
MDEuMTkgdW0gMTU6MTcgc2NocmllYiBNaWNoZWwgRMOkbnplcjoKPj4gT24gMjAxOS0wMS0xMSAy
OjE1IHAubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBNb3ZlIHRoZSBCTyBvbiB0aGUg
TFJVIG9ubHkgd2hlbiBpdCBpcyBhY3R1YWxseSBtb3ZlZCBieSBhIERNQQo+Pj4gb3BlcmF0aW9u
Lgo+Pj4KPj4+IFsuLi5dCj4+Pgo+Pj4gQEAgLTE3Nyw2ICsxNzUsMTMgQEAgc3RhdGljIHZtX2Zh
dWx0X3QgdHRtX2JvX3ZtX2ZhdWx0KHN0cnVjdAo+Pj4gdm1fZmF1bHQgKnZtZikKPj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IFZNX0ZBVUxUX1NJR0JVUzsKPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0X3VubG9jazsKPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCB9Cj4+PiArCj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKGJvLT5tb3ZpbmcgIT0gbW92aW5nKSB7
Cj4+IEhtbSwgY291bGQgYSBkcml2ZXIganVzdCB1cGRhdGUgdGhlIGV4aXN0aW5nIGZlbmNlIGlu
c3RlYWQgb2YgYXR0YWNoaW5nCj4+IGEgbmV3IG9uZT8KPiAKPiBNaG0sIG5vdCBhcyBmYXIgYXMg
SSBrbm93LiBUaGF0IHdvdWxkIHZpb2xhdGUgc2ltaWxhciBjaGVja3MgZWxzZXdoZXJlLgoKTWFr
ZXMgc2Vuc2UsIG15IFItYiBzdGFuZHMuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAg
ICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29m
dHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2
ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
