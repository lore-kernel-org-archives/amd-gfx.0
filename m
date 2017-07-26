From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 15/81] drm/amd/display: Re-enable Vsync Interrupts for
 Gradual Refresh Ramp
Date: Wed, 26 Jul 2017 09:34:02 -0400
Message-ID: <5454135a-51b2-36c6-c4a7-1544a0249894@amd.com>
References: <1500990881-6100-1-git-send-email-sunpeng.li@amd.com>
 <1500990881-6100-16-git-send-email-sunpeng.li@amd.com>
 <f1763d72-5caf-671b-df61-5064920ad67d@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f1763d72-5caf-671b-df61-5064920ad67d-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, sunpeng.li-5C7GfCeVMHo@public.gmane.org, Amy Zhang <Amy.Zhang-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxNy0wNy0yNSAwOTozNCBQTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gT24gMjUvMDcv
MTcgMTA6NTMgUE0sIHN1bnBlbmcubGlAYW1kLmNvbSB3cm90ZToKPj4gRnJvbTogQW15IFpoYW5n
IDxBbXkuWmhhbmdAYW1kLmNvbT4KPj4KPj4gLSBNYWtlIHN1cmUgVnN5bmMgaW50ZXJydXB0cyBh
cmUgZGlzYWJsZWQgaW4gc3RhdGljIHNjcmVlbiBjYXNlCj4+ICAgYW5kIGVuYWJsZWQgd2hlbiBu
b3QgdG8gc2F2ZSBwb3dlcgo+IAo+IFdoYXQgZXhhY3RseSBkb2VzIHRoaXMgbWVhbj8gRldJVywg
dGhlIGludGVycnVwdCB3aG9zZSBoYW5kbGVyIGNhbGxzCj4gZHJtX2hhbmRsZV92YmxhbmsoKSBt
dXN0IGJlIGVuYWJsZWQgZnJvbSB3aGVuIHRoZQo+IGRybV9kcml2ZXI6OmVuYWJsZV92Ymxhbmsg
aG9vayBpcyBjYWxsZWQgdW50aWwgd2hlbiB0aGUKPiBkcm1fZHJpdmVyOjpkaXNhYmxlX3ZibGFu
ayBob29rIGlzIGNhbGxlZC4KPiAKPiAKClRoaXMgY29tbWVudCBpcyBtaXNsZWFkaW5nIGFuZCBz
aG91bGQndmUgYmVlbiB0cmltbWVkIHdoZW4gcHJlcGFyaW5nIHRoZQpwYXRjaGVzIGZvciB0aGUg
b3BlbiB0cmVlLiBUaGlzIGNoYW5nZSBzaG91bGQgbm90IGhhdmUgYW4gaW1wYWN0IG9uCnZibGFu
ayBpbnRlcnJ1cHRzIG9uIExpbnV4LiBTb3JyeSBmb3IgdGhlIGNvbmZ1c2lvbi4KCkhhcnJ5Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
