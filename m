From: Mads <mads-UV2J4TS9czE@public.gmane.org>
Subject: Re: SDMA out-of-bounds write access of tiled surface
Date: Fri, 05 Aug 2016 15:22:00 +0200
Message-ID: <48b66a16e2e0f9201447967f504f6d5e@ab3.no>
References: <f07d06143d31d6e66ce8e8cf7de9084a@ab3.no>
 <b30cc5f5235fa5745b357d9053b7c9b3@ab3.no> <57681305.5070400@gmail.com>
 <1ba8273c322d606ca6d1904ed462edf1@ab3.no> <576835ED.4030601@gmail.com>
 <bc7f9aa3ec84f59a3aae71135a97cc20@ab3.no>
 <98752b6ecaa89eda9be5efe55baa5cec@ab3.no> <5768EF1E.2040105@gmail.com>
 <63f7121f8782563f2967f6bc36849b08@ab3.no>
 <df89a8f18199b2ef8b89fc8e83e50fea@ab3.no>
 <924e8ef77d0c0c816c01e24439e490d8@ab3.no> <57697A1E.6020902@gmail.com>
 <576A4332.1090409@gmail.com>
 <CAAxE2A60Rf3m764QyWmzwFiiuQAiGMdbmqyNE+pKxwBJJok5YA@mail.gmail.com>
 <CADnq5_M=MZUHCeLB4=Xtykzn-Lzfqw8gbdvi=-tMbwkpoBZmHw@mail.gmail.com>
 <CAAxE2A5=7NYLJWJtcqiY0=eWffhRfHwSvjjXFuJOR4fW=A3hHA@mail.gmail.com>
 <CADnq5_NDv+tMvD1m16WGzLTuvNFoKfXVPiFdapQi7wQyisK5BQ@mail.gmail.com>
 <bfb8e5be88e5a576be454b9996a06212@ab3.no>
 <99b7e94b2b0988c84a1e9e524e89bb0c@ab3.no>
 <CAAxE2A6_1PHyzjwhmCb5V=9yjG+c2BwRWvbM2Q7VnOoU2w3wWA@mail.gmail.com>
 <19f5de02d79aef802e8d1be498f8924d@ab3.no> <5784166D.5020701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5784166D.5020701-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, =?UTF-8?Q?Marek_Ol=C5=A1=C3=A1k?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

SnVzdCB0byB1cGRhdGUsIFI2MDBfREVCVUc9bm9kbWEgaXMgc3RpbGwgbmVlZGVkIHdoZW4gdXBk
YXRpbmcgdG8gCnhvcmctc2VydmVyIDEuMTguNCwgcGxhc21hIDUuNy4zIGFuZCBsaW51eCA0Ljcu
MCwgYW5kIGxpYmRybSwgbWVzYSBhbmQgCmxsdm0gYnVpbHQgZnJvbSBsaXZlIHNvdXJjZXMgZnJv
bSBzb21ldGltZSB0aGlzIHdlZWsuCgpTaG91bGQgdGhpcyBpbmZvIGJlIGluIHNvbWUgYnVnemls
bGEgc29tZXdoZXJlPwoKLSBNYWRzCgpPbiAyMDE2LTA3LTExIDIzOjU4LCBOaWNvbGFpIEjDpGhu
bGUgd3JvdGU6Cgo+IFRoZSBjdWxwcml0IFNETUEgYnVmZmVyIHdhcyBhY3R1YWxseSBzdWJtaXR0
ZWQgYnkgdGhlIFggc2VydmVyLCBJIAo+IGJlbGlldmUuCj4gCj4gTmljb2xhaQo+IAo+PiBPbiAx
MS4wNy4yMDE2IDIzOjUyLCBNYWRzIHdyb3RlOiBZZXMsIGFsc28gd2l0aCA1LjcgdGhlIGNvcnJ1
cHRpb24gCj4+IGFwcGVhcnMgaWYgSSBzdGFydCAvdXNyL2Jpbi9rb25zb2xlIG9yCj4+IC91c3Iv
YmluL2RvbHBoaW4gKGFuZCBJIGd1ZXNzIGl0IHdpbGwgYmUgYXBwYXJlbnQgd2l0aCBtb3JlCj4+
IGFwcGxpY2F0aW9ucywgaWYgeW91IHdhbnQgSSBjb3VsZCB0ZXN0IHNvbWUgbW9yZSkuIEFsdGhv
dWdoLCBJIGhhdmUgbm8KPj4gdHJvdWJsZSB1c2luZyBjaHJvbWl1bSBvciBzdGVhbSwgcGxheWlu
ZyBhbGwgc29ydHMgb2YgZ2FtZXMuIEFzIHlvdSAKPj4gY2FuCj4+IHNlZSBpZiB5b3UgbG9vayB0
aHJvdWdoIHRoZSB0aHJlYWQsIGl0IG1pZ2h0IGJlIHJlYXNvbiB0byBiZWxpZXZlIHRoYXQKPj4g
cGxhc21hc2hlbGwgaXRzZWxmIG1pZ2h0IGJlIHRoZSBjdWxwcml0IHNlbmRpbmcgdGhlIGRhdGEg
dGhhdCBjb3JydXB0cwo+PiB0aGUgc2NyZWVuLgo+PiAKPj4gLSBNYWRzCj4+IAo+Pj4gT24gMjAx
Ni0wNy0xMSAyMzo0MiwgTWFyZWsgT2zFocOhayB3cm90ZToKPj4+IAo+Pj4gQ2FuIHlvdSBzZWUg
YW55IGNvcnJ1cHRpb24gb3IgaXMgdGhlcmUganVzdCB0aGUgbWVzc2FnZSBpbiBkbWVzZz8gKEl0
Cj4+PiBtaWdodCBqdXN0IGJlIGEgcGFnZSBkaXJlY3RvcnkgZmV0Y2ggYW5kIG5vdCBhIG1lbW9y
eSBhY2Nlc3MpCj4+PiAKPj4+IE1hcmVrCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
