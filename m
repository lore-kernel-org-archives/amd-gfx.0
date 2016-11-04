From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm] xf86drm: Parse the separate files to retrieve the
 vendor/device info
Date: Fri, 4 Nov 2016 18:14:51 +0000
Message-ID: <CACvgo52D+zVZMs_RM5_2sWX4=DnWi15bKSXBh-jYBfDQRm9_cw@mail.gmail.com>
References: <20161101181334.8225-1-emil.l.velikov@gmail.com>
 <071ab37d-9897-760f-5a63-5f5ede867bd3@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <071ab37d-9897-760f-5a63-5f5ede867bd3-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SEkgYWxsLAoKT24gMiBOb3ZlbWJlciAyMDE2IGF0IDAzOjA3LCBNaWNoZWwgRMOkbnplciA8bWlj
aGVsQGRhZW56ZXIubmV0PiB3cm90ZToKPgo+IFRoZSBmaXJzdCBhdHRhY2hlZCBwYXRjaCB3aWxs
IHJlc3VsdCBpbiBkcm1QYXJzZVBjaURldmljZUluZm8gYWx3YXlzCj4gcmVwb3J0aW5nIHJldmlz
aW9uIDAgb24ga2VybmVscyB3aXRob3V0IHRoZSBzZWNvbmQgYXR0YWNoZWQgcGF0Y2guIFdpbGwK
PiB0aGF0IGJlIGFuIGlzc3VlIGZvciB0aGUgYW1kZ3B1LXBybyBzdGFjaz8KPgo+IFBsZWFzZSBm
b2xsb3cgdXAgZGlyZWN0bHkgdG8gdGhlIHBhdGNoIGUtbWFpbHMgd2l0aCBhbnkgY29tbWVudHMg
b24gdGhlCj4gcGF0Y2hlcy4KPgpGbGVzaGluZyBvdXQgdGhlIHF1ZXN0aW9uIGZyb20gdGhlIGFj
dHVhbCBwYXRjaGVzOgoKRG8gdGhlIEFNREdQVS1QUk8gb3IgdGhlIEFNRCBzdGFjayBbYXMgYSB3
aG9sZV0gZGVwZW5kIG9uIHRoZSByZXZpc2lvbgpmaWVsZCBhcyByZXR1cm5lZCBieSB0aGUgZHJt
RGV2aWNlIEFQSSA/CgpTaW5jZSB3ZSBoYXZlIGEgbG92ZWx5IGJ1ZyBpbiBsaWJkcm0gYW5kIG1p
Z2h0IHJvbGwgb3V0IGEgcmVsZWFzZQpzb29uaXNoIGl0J2xsIGJlIGdyZWF0IHRvIGhhdmUgdGhp
cyBzcXVhc2hlZC9tZXJnZWQgYXMgd2VsbC4KClRoYW5rcwpFbWlsCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
