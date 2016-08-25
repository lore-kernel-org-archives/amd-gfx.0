From: Mads <mads-UV2J4TS9czE@public.gmane.org>
Subject: Re: SDMA out-of-bounds write access of tiled surface
Date: Thu, 25 Aug 2016 15:36:13 +0200
Message-ID: <d119eedf4d9c145cca3bdd9b3e7c8f41@ab3.no>
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
 <48b66a16e2e0f9201447967f504f6d5e@ab3.no>
 <CAAxE2A7ojOJj_8VxPgQBExCGp0iNNoYdxskRwp_Y-XGnMo7isA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A7ojOJj_8VxPgQBExCGp0iNNoYdxskRwp_Y-XGnMo7isA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?Q?Marek_Ol=C5=A1=C3=A1k?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

VGhhbmsgeW91IGZvciBub3RpZnlpbmcgOikKCkp1c3QgY3VyaW91cywgaXMgdGhlcmUgYSB3YXkg
dG8gZW5hYmxlIHRoZW0gaW4gdGhlIHNhbWUgd2F5IGFzIGRpc2FibGluZyAKdGhlbSBpcyBkb25l
IHdpdGggUjYwMF9ERUJVRz1ub2RtYT8gQmVjYXVzZSwgd2hpbGUgZGVza3RvcCBhcHBsaWNhdGlv
bnMgCmdldHMgYnVnZ3ksIGdhbWVzIGFuZCBzdWNoIGRvZXMgbm90IHRyaWdnZXIgYW55IGFydGlm
YWN0cywgc28gbm9ybWFsbHkgSSAKZGlzYWJsZSBSNjAwX0RFQlVHPW5vZG1hIHdoZW4gZ2FtaW5n
IChhcyBJJ3ZlIGFzc3VtZWQgZGlzYWJsaW5nIGRtYSBtdXN0IApsZWFkIHRvIGxlc3MgcGVyZm9y
bWFuY2UpLgoKLSBNYWRzCgpPbiAyMDE2LTA4LTI1IDE1OjAxLCBNYXJlayBPbMWhw6FrIHdyb3Rl
OgoKPiBGWUksIEkndmUgZGlzYWJsZWQgU0RNQSB0ZXh0dXJlIGNvcHlpbmcgZm9yIENhcnJpem8g
aW4gTWVzYS4gVGhlIFZNCj4gZmF1bHRzIHNob3VsZCBubyBsb25nZXIgb2NjdXIuCj4gCj4gTWFy
ZWsKPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
