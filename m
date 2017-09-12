From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 0/8] Retry page fault handling for Vega10
Date: Tue, 12 Sep 2017 16:26:24 -0400
Message-ID: <98666a00-977c-ec23-1099-2c20a69a3987@amd.com>
References: <1504045524-23853-1-git-send-email-Felix.Kuehling@amd.com>
 <0816a963-54cc-0041-4b09-4bf41ee46fbf@amd.com>
 <BN6PR12MB1652DBBD8E350972D2BC6C3AF7680@BN6PR12MB1652.namprd12.prod.outlook.com>
 <CAFCwf11o=4iizAbRVNE2w3FoacU3yutKsbMvFGfLNTscv1Ym+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFCwf11o=4iizAbRVNE2w3FoacU3yutKsbMvFGfLNTscv1Ym+A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, John Bridgman <John.Bridgman-5C7GfCeVMHo@public.gmane.org>
Cc: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxNy0wOS0xMiAwMTo0OCBBTSwgT2RlZCBHYWJiYXkgd3JvdGU6Cj4gK0pvaG4sCj4KPiBJ
ZiBBbGV4IGlzIGZpbmUgd2l0aCBpdCB0aGVuIEknbSBmaW5lIHdpdGggaXQgYXMgd2VsbCwgYXMg
bG9uZyBhcyB0aGlzCj4gaXMgYSB0ZW1wb3Jhcnkgc29sdXRpb24gdW50aWwgc29tZSBwb2ludCB3
aGVyZSB5b3UgaGF2ZSBzb21lCj4gY29udmVyZ2VuY2UgYmV0d2VlbiB5b3VyIGludGVybmFsIGNv
ZGUgYW5kIHRoZSB1cHN0cmVhbSBvbmUuCgpBZ3JlZWQuIEkgd2FudCB0byBjb252ZXJnZSB0aG9z
ZSBicmFuY2hlcyBhcyBzb29uIGFzIHBvc3NpYmxlLgoKPiBBbmQgb2YgY291cnNlIGlmIHlvdSBo
YXZlIGFtZGtmZCBvbmx5IGNoYW5nZXMgdGhlbiB0aGF0IGNhbiBiZQo+IHVwc3RyZWFtZWQgdGhy
b3VnaCBtZSBkaXJlY3RseS4KClllcy4KCj4KPiBIYXZpbmcgc2FpZCB0aGF0LCBpZiB5b3UvSm9o
bi9BbGV4IHRoaW5rIHRoYXQgdGhpcyBpcyBhIG1vcmUgcGVybWFuZW50Cj4gc29sdXRpb24sIHRo
ZW4gbWF5YmUgYSBiZXR0ZXIgcGxhbiBpcyB0byBmaXJzdCB1bmlmeSB0aGUgZHJpdmVycyAoYXMK
PiB3YXMgZGlzY3Vzc2VkIG1hbnkgdGltZXMpIGJlZm9yZSBzdGFydGluZyB0byB1cHN0cmVhbSBj
aGFuZ2VzLiBJZiB0aGUKPiA5MCUgb2YgdGhlIGNoYW5nZXMgYXJlIGluIGJvdGggZHJpdmVycywg
dGhlbiB0aGVyZSBpcyByZWFsbHkgbm8gcG9pbnQKPiBvZiBrZWVwaW5nIGFtZGtmZCBhcyBhIHNl
cGFyYXRlIGRyaXZlci4KCklmIHdlIHVuaWZ5IHRoZSBkcml2ZXJzIGZpcnN0LCBpdCB3b3VsZCBm
dXJ0aGVyIGRpdmVyZ2UgdGhlIGJyYW5jaGVzLgpUaGF0IHdvdWxkIGJlIGNvdW50ZXItcHJvZHVj
dGl2ZSBpbiBteSBvcGluaW9uLiBJJ2QgcmF0aGVyIGdldCB0aGUKYnJhbmNoZXMgdG8gY29udmVy
Z2UgZmlyc3QgYW5kIHRoZW4gdW5pZnkgdGhlIGRyaXZlcnMgc28gd2UgZG9uJ3QgaGF2ZQp0byBk
byBpdCB0d2ljZS4KClJlZ2FyZHMsCiAgRmVsaXgKCj4KPiBPZGVkCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
