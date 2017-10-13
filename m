From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 5/5] drm/amd/sched: signal and free remaining fences in
 amd_sched_entity_fini
Date: Fri, 13 Oct 2017 17:20:17 +0200
Message-ID: <d40e2ab1-722a-0850-82e0-588aec8b558d@amd.com>
References: <20170928145530.12844-1-nhaehnle@gmail.com>
 <20170928145530.12844-5-nhaehnle@gmail.com>
 <7cb63e4c-9b65-b9b9-14dc-26368ca7126a@daenzer.net>
 <c67d1bd8-81a0-4133-c3df-dd2a1b1a8c11@gmail.com>
 <51ec8d88-32eb-ef4a-b34b-d2fd8e23281e@daenzer.net>
 <6b509b43-a6e9-175b-7d64-87e38c5ea4e2@daenzer.net>
 <fcb5f430-5912-0feb-a586-eaf710433d8d@amd.com>
 <8ab106b9-363b-4fb2-6f1a-727a5e0e7bc5@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <8ab106b9-363b-4fb2-6f1a-727a5e0e7bc5-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTMuMTAuMjAxNyB1bSAxNjozNCBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDEyLzEw
LzE3IDA3OjExIFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAxMi4xMC4yMDE3IHVt
IDE4OjQ5IHNjaHJpZWIgTWljaGVsIETDpG56ZXI6Cj4+PiBPbiAxMi8xMC8xNyAwMTowMCBQTSwg
TWljaGVsIETDpG56ZXIgd3JvdGU6Cj4+Pj4gWzBdIEkgYWxzbyBnb3QgdGhpcywgYnV0IEkgZG9u
J3Qga25vdyB5ZXQgaWYgaXQncyByZWxhdGVkOgo+Pj4gTm8sIHRoYXQgc2VlbXMgdG8gYmUgYSBz
ZXBhcmF0ZSBpc3N1ZTsgSSBjYW4gc3RpbGwgcmVwcm9kdWNlIGl0IHdpdGggdGhlCj4+PiBodWdl
IHBhZ2UgcmVsYXRlZCBjaGFuZ2VzIHJldmVydGVkLiBVbmZvcnR1bmF0ZWx5LCBpdCBkb2Vzbid0
IHNlZW0gdG8KPj4+IGhhcHBlbiByZWxpYWJseSBvbiBldmVyeSBwaWdsaXQgcnVuLgo+PiBDYW4g
eW91IGVuYWJsZSBLQVNBTiBpbiB5b3VyIGtlcm5lbCwKPiBLQVNBTiBjYXVnaHQgc29tZXRoaW5n
IGVsc2UgYXQgdGhlIGJlZ2lubmluZyBvZiBwaWdsaXQsIHNlZSB0aGUgYXR0YWNoZWQKPiBkbWVz
ZyBleGNlcnB0LiBOb3Qgc3VyZSBpdCdzIHJlbGF0ZWQgdGhvdWdoLgo+Cj4gYW1kZ3B1X2pvYl9m
cmVlX2NiKzB4MTNkLzB4MTYwIGRlY29kZXMgdG86Cj4KPiBhbWRfc2NoZWRfZ2V0X2pvYl9wcmlv
cml0eSBhdCAuLi4vZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vc2NoZWR1bGVyL2dwdV9z
Y2hlZHVsZXIuaDoxODIKPgo+IHN0YXRpYyBpbmxpbmUgZW51bSBhbWRfc2NoZWRfcHJpb3JpdHkK
PiBhbWRfc2NoZWRfZ2V0X2pvYl9wcmlvcml0eShzdHJ1Y3QgYW1kX3NjaGVkX2pvYiAqam9iKQo+
IHsKPiAJcmV0dXJuIChqb2ItPnNfZW50aXR5LT5ycSAtIGpvYi0+c2NoZWQtPnNjaGVkX3JxKTsg
PD09PQo+IH0KPgo+ICAgKGlubGluZWQgYnkpIGFtZGdwdV9qb2JfZnJlZV9jYiBhdCAuLi4vZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jOjEwNwo+Cj4gCWFtZGdwdV9yaW5n
X3ByaW9yaXR5X3B1dChqb2ItPnJpbmcsIGFtZF9zY2hlZF9nZXRfam9iX3ByaW9yaXR5KHNfam9i
KSk7CgpTb3VuZHMgYSBsb3QgbGlrZSB0aGUgY29kZSBBbmRyZXMgYWRkZWQgaXMgYnVnZ3kgc29t
ZWhvdy4gR29pbmcgdG8gdGFrZSAKYSBsb29rIGFzIHdlbGwuCgo+PiBhbmQgcGxlYXNlIGxvb2sg
dXAgYXQgd2hpY2ggbGluZSBudW1iZXIgYW1kZ3B1X3ZtX2JvX2ludmFsaWRhdGUrMHg4OAo+PiBp
cy4KPiBMb29rcyBsaWtlIGl0J3MgdGhpcyBsaW5lOgo+Cj4gCQlpZiAoZXZpY3RlZCAmJiBiby0+
dGJvLnJlc3YgPT0gdm0tPnJvb3QuYmFzZS5iby0+dGJvLnJlc3YpIHsKPgo+IE1heWJlIHZtIG9y
IHZtLT5yb290LmJhc2UuYm8gaXMgTlVMTD8KQWgsIG9mIGNvdXJzZSEKCldlIG5lZWQgdG8gcmVz
ZXJ2ZSB0aGUgcGFnZSBkaXJlY3Rvcnkgcm9vdCB3aGVuIHdlIHJlbGVhc2UgaXQgb3IgCm90aGVy
d2lzZSB3ZSBjYW4gcnVuIGludG8gYSByYWNlIHdpdGggc29tZWJvZHkgZWxzZSB0cnlpbmcgdG8g
ZXZpY3QgaXQuCgpHb2luZyB0byBzZW5kIGEgcGF0Y2ggaW4gYSBtaW51dGUsCkNocmlzdGlhbi4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
