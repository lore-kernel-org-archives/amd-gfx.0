From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 15/81] drm/amd/display: Re-enable Vsync Interrupts for
 Gradual Refresh Ramp
Date: Wed, 26 Jul 2017 10:34:06 +0900
Message-ID: <f1763d72-5caf-671b-df61-5064920ad67d@daenzer.net>
References: <1500990881-6100-1-git-send-email-sunpeng.li@amd.com>
 <1500990881-6100-16-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1500990881-6100-16-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
To: sunpeng.li-5C7GfCeVMHo@public.gmane.org, Amy Zhang <Amy.Zhang-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjUvMDcvMTcgMTA6NTMgUE0sIHN1bnBlbmcubGlAYW1kLmNvbSB3cm90ZToKPiBGcm9tOiBB
bXkgWmhhbmcgPEFteS5aaGFuZ0BhbWQuY29tPgo+IAo+IC0gTWFrZSBzdXJlIFZzeW5jIGludGVy
cnVwdHMgYXJlIGRpc2FibGVkIGluIHN0YXRpYyBzY3JlZW4gY2FzZQo+ICAgYW5kIGVuYWJsZWQg
d2hlbiBub3QgdG8gc2F2ZSBwb3dlcgoKV2hhdCBleGFjdGx5IGRvZXMgdGhpcyBtZWFuPyBGV0lX
LCB0aGUgaW50ZXJydXB0IHdob3NlIGhhbmRsZXIgY2FsbHMKZHJtX2hhbmRsZV92YmxhbmsoKSBt
dXN0IGJlIGVuYWJsZWQgZnJvbSB3aGVuIHRoZQpkcm1fZHJpdmVyOjplbmFibGVfdmJsYW5rIGhv
b2sgaXMgY2FsbGVkIHVudGlsIHdoZW4gdGhlCmRybV9kcml2ZXI6OmRpc2FibGVfdmJsYW5rIGhv
b2sgaXMgY2FsbGVkLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAg
ICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1
c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
