From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Reserve fence slots for command submission
Date: Wed, 4 Jul 2018 11:02:29 +0200
Message-ID: <6a8901c7-5aa8-2c84-5114-b0a8905c4fad@amd.com>
References: <1530673358-20219-1-git-send-email-Jerry.Zhang@amd.com>
 <e6385817-e437-e5de-0297-a6af16648a2c@gmail.com> <5B3C6F7B.80901@amd.com>
 <9fd5d981-3725-289b-94ff-73da521e3061@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <9fd5d981-3725-289b-94ff-73da521e3061-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMDQuMDcuMjAxOCB1bSAwOToyMSBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MDctMDQgMDg6NTUgQU0sIFpoYW5nLCBKZXJyeSAoSnVud2VpKSB3cm90ZToKPj4gT24gMDcvMDQv
MjAxOCAwMjozNCBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+IEFtIDA0LjA3LjIwMTgg
dW0gMDU6MDIgc2NocmllYiBKdW53ZWkgWmhhbmc6Cj4+Pj4gRnJvbTogTWljaGVsIETDpG56ZXIg
PG1pY2hlbC5kYWVuemVyQGFtZC5jb20+Cj4+Pj4KPj4+PiBXaXRob3V0IHRoaXMsIHRoZXJlIGNv
dWxkIG5vdCBiZSBlbm91Z2ggc2xvdHMsIHdoaWNoIGNvdWxkIHRyaWdnZXIgdGhlCj4+Pj4gQlVH
X09OIGluIHJlc2VydmF0aW9uX29iamVjdF9hZGRfc2hhcmVkX2ZlbmNlLgo+Pj4+Cj4+Pj4gdjI6
Cj4+Pj4gKiBKdW1wIHRvIHRoZSBlcnJvciBsYWJlbCBpbnN0ZWFkIG9mIHJldHVybmluZyBkaXJl
Y3RseSAoSmVycnkgWmhhbmcpCj4+Pj4gdjM6Cj4+Pj4gKiBSZXNlcnZlIHNsb3RzIGZvciBjb21t
YW5kIHN1Ym1pc3Npb24gYWZ0ZXIgVk0gdXBkYXRlcyAoQ2hyaXN0aWFuCj4+Pj4gS8O2bmlnKQo+
Pj4+Cj4+Pj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPj4+PiBCdWd6aWxsYTogaHR0cHM6
Ly9idWdzLmZyZWVkZXNrdG9wLm9yZy8xMDY0MTgKPj4+PiBSZXBvcnRlZC1ieTogbWlraGFpbC52
LmdhdnJpbG92QGdtYWlsLmNvbQo+Pj4+IFNpZ25lZC1vZmYtYnk6IE1pY2hlbCBEw6RuemVyIDxt
aWNoZWwuZGFlbnplckBhbWQuY29tPgo+Pj4+IFNpZ25lZC1vZmYtYnk6IEp1bndlaSBaaGFuZyA8
SmVycnkuWmhhbmdAYW1kLmNvbT4KPj4+IEkgd291bGQgcHV0IHRoYXQgYXQgdGhlIGVuZCBvZiBh
bWRncHVfYm9fdm1fdXBkYXRlX3B0ZSgpLCBidXQgdGhhdCBpcwo+Pj4gb25seSBhIG1pbm9yIG5p
dCBwaWNrLgo+PiBBdCBmaXJzdCwgSSByZWFsbHkgcHV0IGl0IGF0IHRoZSBlbmQgb2YgYW1kZ3B1
X2JvX3ZtX3VwZGF0ZV9wdGUoKS4KPj4gT24gdGhlIDJuZCB0aG91Z2h0LCB0aGF0IGZ1bmMgbWF5
IGJlIGNhbGxlZCBieSBvdGhlcnMoYWx0aG91Z2ggaXQncyBub3QKPj4gZm9yIG5vdyksIHNvIEkg
bW92ZSBpdCBvdXQgb2YgdGhlcmUgdG8gdGhlIGNhbGxlci4KPiBNYWtlcyBzZW5zZSB0byBtZSwg
RldJVy4gVGhhbmtzIEp1bndlaSBhbmQgQ2hyaXN0aWFuIQo+Cj4KPiBQLlMuIENocmlzdGlhbiwg
YW55IGZlZWRiYWNrIG9uCj4gaHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3BhdGNo
LzIzMjIwNC8gPwoKSnVzdCBkaWQsIHRoYW5rcyBmb3IgcG9pbnRpbmcgdGhhdCBvdXQgb25jZSBt
b3JlLgoKUmVhZCB0aGUgbWFpbCBkdXJpbmcgbXkgdmFjYXRpb24sIGJ1dCBmb3Jnb3QgdG8gYW5z
d2VyIGl0IG9uIE1vbmRheS4KCkNocmlzdGlhbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
