From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: amdgpu: ratelimit on vm faults to avoid spaming console
Date: Mon, 7 Nov 2016 13:35:11 -0500
Message-ID: <CADnq5_NG7GcFJxA8mq0-fEE51Jw7TCjYPn68wSMA846tFB8fNQ@mail.gmail.com>
References: <1478493309-30328-1-git-send-email-funfunctor@folklore1984.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1478493309-30328-1-git-send-email-funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
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
To: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>, =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marek Olsak <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gU3VuLCBOb3YgNiwgMjAxNiBhdCAxMTozNSBQTSwgRWR3YXJkIE8nQ2FsbGFnaGFuCjxmdW5m
dW5jdG9yQGZvbGtsb3JlMTk4NC5uZXQ+IHdyb3RlOgo+IFRoZXNlIGFyZSByYXRoZXIgbWlub3Ig
aG93ZXZlciBzaG91bGQgaGVscCBzdG9wIHNvbWUgZm9sa3MKPiBtYWNoaW5lcyBncmluZGluZyB0
byBhIGhhbHQgd2hlbiBhIHVzZXJzcGFjZSBhcHBsaWNhdGlvbiBzb21laG93Cj4gZ2V0cyB0aGUg
R1BVIGludG8gc29tZSBob3JyaWJsZSBzdGF0ZSBjYXVzaW5nIHRoZSBjb25zb2xlIHRvIGZpbGwK
PiB2ZXJ5IHF1aWNrbHkuIEFwcGxpZXMgb24gdG9wIG9mIG1hc3Rlci4KCkknbSBnZW5lcmFsbHkg
b2sgd2l0aCB0aGUgaWRlYS4gIE15IG9ubHkgY29uY2VybiB3b3VsZCBiZSBpZiB0aGlzCndvdWxk
IGFkdmVyc2VseSBhZmZlY3QgdGhlIHJhZGVvbiBHUFVWTSBkZWJ1Z2dpbmcgb3B0aW9ucyBpbiBt
ZXNhIGFuZApwaWdsaXQuIE5pY29sYWk/IE1hcmVrPwoKQWxleApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
