From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add amdgpu_bo_handle_type_kms_noimport
Date: Tue, 17 Jul 2018 10:19:16 +0200
Message-ID: <a5be38fa-4da6-642f-b297-21261820a908@gmail.com>
References: <20180712004750.2024-1-maraeo@gmail.com>
 <9a8d8f7f-a468-fd5b-dec5-472ce9c88483@daenzer.net>
 <CAAxE2A6Vz08sWXiaB6B-F4_P7Fy6uDuJ7aF2gHLXZ4N3zj9sXw@mail.gmail.com>
 <a291b3b5-25bc-385a-5242-9bd75ec423e9@daenzer.net>
 <CAAxE2A7ffmO=Tv_DSWhPciF+y5q_wbaBYgcqHvxQVkeVfhBhdg@mail.gmail.com>
 <31980a46-1d16-8ead-cc2b-5a5b9eb4d530@daenzer.net>
 <5374dffa-45c9-1bd6-79b9-cc4450a96aeb@gmail.com>
 <126a68a9-43f4-c747-89d1-114dc29ea4e9@daenzer.net>
 <3cc456c1-929d-4aee-2e8b-7d4edb023382@amd.com>
 <0f28de35-1928-2af3-8b8d-13c61b25e285@daenzer.net>
 <45bab640-d574-b822-e5c8-69fe67626a9a@amd.com>
 <988daf71-51ef-65e7-48ed-9dc2f3acb3a1@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <988daf71-51ef-65e7-48ed-9dc2f3acb3a1-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMTcuMDcuMjAxOCB1bSAxMDowMyBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MDctMTcgMDk6NTkgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDE3LjA3LjIwMTgg
dW0gMDk6NDYgc2NocmllYiBNaWNoZWwgRMOkbnplcjoKPj4+IE9uIDIwMTgtMDctMTcgMDk6MzMg
QU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Pj4gQW0gMTcuMDcuMjAxOCB1bSAwOToyNiBz
Y2hyaWViIE1pY2hlbCBEw6RuemVyOgo+Pj4+IFtTTklQXQo+Pj4gQWxsIHRoYXQgc2hvdWxkIGJl
IG5lZWRlZCBpcyBvbmUgc3RydWN0IGxpc3RfaGVhZCBwZXIgQk8sIDE2IGJ5dGVzIG9uCj4+PiA2
NC1iaXQuCj4+ICttYWxsb2Mgb3ZlcmhlYWQgYW5kIHRoYXQgZm9yICpldmVyeSogQk8gdGhlIGFw
cGxpY2F0aW9uL2RyaXZlcgo+PiBhbGxvY2F0ZWQuCj4gVGhlIHN0cnVjdCBsaXN0X2hlYWQgY2Fu
IGJlIHN0b3JlZCBpbiBzdHJ1Y3QgYW1kZ3B1X2JvLCBubyBhZGRpdGlvbmFsCj4gbWFsbG9jIG5l
Y2Vzc2FyeS4KCldlbGwgdGhhdCBzb3VuZHMgd2UgYXJlIG5vdCB0YWxraW5nIGFib3V0IHRoZSBz
YW1lIGNvZGUsIGRvIHdlPwoKSUlSQyB0aGUgaGFzaHRhYmxlIGltcGxlbWVudGF0aW9uIGluIGxp
YmRybSBpcyB1c2luZyBhbiBldmVyIGdyb3dpbmcgCmFycmF5IGZvciB0aGUgQk9zIGFuZCAqTk9U
KiBhIGxpbmtlZCBsaXN0LgoKU28gd2UgaGF2ZSBhdCBsZWFzdCB0d28gbWFsbG9jcyBpbnZvbHZl
ZCBoZXJlLCB0aGUgb25lIGZvciB0aGUga2V5L3ZhbHVlIApwYWlyIGFuZCB0aGUgb25lIGZvciB0
aGUgbm9kZSBhcnJheS4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4KPgo+PiBUaGUgbGFzdCB0aW1l
IEkgbG9va2VkIHdlIGNvdWxkIGVhc2lseSBoYXZlIGEgZmV3IHRob3VzYW5kcyBvZiB0aGF0Cj4+
IChidXQgbm90IGluIHRoZSBzYW1lIENTKS4KPj4KPj4gU28gSSB3b3VsZCBndWVzcyB0aGF0IHRo
ZSB3YXN0ZWQgbWVtb3J5IGNhbiBlYXNpbHkgYmUgaW4gdGhlIGxvd2VyIGtiCj4+IHJhbmdlLCBj
b21wYXJlZCB0byBhZGRpbmcganVzdCBhIGZsYWcgdGhhdCB3ZSBuZXZlciBnb2luZyB0byBpbXBv
cnQgdGhlCj4+IGhhbmRsZSBhZ2Fpbi4KPiBJIHdvdWxkbid0IGNhbGwgdGhlIG1lbW9yeSAid2Fz
dGVkIiwgYXMgaXQgc2VydmVzIGEgY2xlYXIgcHVycG9zZS4KPgo+CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
