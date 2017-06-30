From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: Deprecation of AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED
Date: Fri, 30 Jun 2017 16:14:16 +0900
Message-ID: <160855e9-2517-ae04-fd9d-c638507109cd@daenzer.net>
References: <CAAxE2A4x8tkA9DL78EouJqxZ9b2b_PyzN3hg8JJn7AHOpk5b0w@mail.gmail.com>
 <8f866ee1-78c0-6707-3f92-b71a2f661457@vodafone.de>
 <CAAxE2A49_j6hO_G0XoWwquFzPsoHVELNhakt5NdmVb8=F0YdSA@mail.gmail.com>
 <50b66561-3843-8b70-913e-5692db657640@daenzer.net>
 <b7717c04-604f-24c8-2fc7-a94e520845c8@vodafone.de>
 <a1c1f000-16b4-220f-70c5-01b2682a632e@daenzer.net>
 <8f60b400-1343-9f7f-d202-f3497fb346ae@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <8f60b400-1343-9f7f-d202-f3497fb346ae-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, John Brooks <john-xq/Ko7C6e2Bl57MIdRCFDg@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMzAvMDYvMTcgMDM6NTkgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMzAuMDYu
MjAxNyB1bSAwODo1MSBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+PiBXZSBjYW4gZGVhbCB3aXRo
IHRoYXQgaW50ZXJuYWxseSBpbiB0aGUga2VybmVsLCB3aGlsZSBmaXhpbmcgdGhlCj4+IGV4aXN0
aW5nIGZsYWcgZm9yIHVzZXJzcGFjZS4KPiAKPiBBbmQgYXMgSSBzYWlkLCBOQUsgdG8gdGhhdCBh
cHByb2FjaC4gSSdtIG5vdCBnb2luZyB0byBhZGQgYQo+IENQVV9BQ0NFU1NfUkVBTExZX1JFUVVJ
UkVEIGZsYWcgaW4gdGhlIGtlcm5lbCBqdXN0IGJlY2F1c2UgbWVzYSBoYXMKPiBtZXNzZWQgdXAg
aXQncyB1c2UgY2FzZS4KPiAKPiBXZSBjb3VsZCBhZ3JlZSBvbiBmaWx0ZXJpbmcgdGhhdCBmbGFn
IGZyb20gdXNlcnNwYWNlIHdoZW4gQk9zIGFyZQo+IGNyZWF0ZWQgYW5kL29yIG1hcCBpdCB0byBh
IENSRUFURV9DUFVfQUNDRVNTX0hJTlQgZmxhZy4KClRoZW4gSSBwcm9wb3NlIHRoZSBmb2xsb3dp
bmc6CgpPbmUgcGF0Y2g6CgpDb252ZXJ0IEFNREdQVV9HRU1fQ1JFQVRFX0NQVV9BQ0NFU1NfUkVR
VUlSRUQgdG8gYSBrZXJuZWwgaW50ZXJuYWwgZmxhZwpBTURHUFVfR0VNX0NQVV9BQ0NFU1NfSElO
VCBpbiBhbWRncHVfZ2VtX2NyZWF0ZV9pb2N0bCwgd2hpY2ggaXMKaW5pdGlhbGx5IHRyZWF0ZWQg
dGhlIHNhbWUgd2F5IGFzIEFNREdQVV9HRU1fQ1JFQVRFX0NQVV9BQ0NFU1NfUkVRVUlSRUQuCgpB
bm90aGVyIHBhdGNoOgoKQ2hhbmdlIHRoZSB0cmVhdG1lbnQgb2YgQU1ER1BVX0dFTV9DUFVfQUND
RVNTX0hJTlQgYWNjb3JkaW5nIHRvIEpvaG4ncwpwYXRjaCA0IGluIHRoZSBsYXRlc3Qgc2VyaWVz
LCBvciBhIHZhcmlhdGlvbiBvZiB0aGF0IGFzIGRpc2N1c3NlZCBvbiBJUkMuCgoKSWYgYW55IHJl
Z3Jlc3Npb25zIGFyZSByZXBvcnRlZCwgd2Ugd2lsbCBiZSBhYmxlIHRvIGRpZmZlcmVudGlhdGUK
d2hldGhlciB0aGV5IGFyZSBkdWUgdG8gdGhlIGFkZGl0aW9uIG9mIHRoZSBuZXcgZmxhZyBpdHNl
bGYgb3IgZHVlIHRvCnRoZSBjaGFuZ2UgaW4gaXRzIGhhbmRsaW5nLgoKCi0tIApFYXJ0aGxpbmcg
TWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5h
bWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAg
ICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
