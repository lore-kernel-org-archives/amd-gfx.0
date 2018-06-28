From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix the wrong type of gem object creation
Date: Thu, 28 Jun 2018 18:53:55 +0200
Message-ID: <1dcc176e-e8dc-bc8d-4430-3c38b08184b3@daenzer.net>
References: <1530179887-24410-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1530179887-24410-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wNi0yOCAxMTo1OCBBTSwgSHVhbmcgUnVpIHdyb3RlOgo+IFdlIHN0aWxsIHVzZSBs
ZWdhY3kgdHlwZSBvZiBnZW1fb2JqZWN0X2NyZWF0ZSwgaXQgc2hvdWxkIHVwZGF0ZSB0byB0dG1f
Ym9fdHlwZQo+IG5vdy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0Bh
bWQuY29tPgoKTmljZSBjYXRjaC4gKEZvciBhbnlvbmUgd29uZGVyaW5nOiBObyBuZWVkIGZvciBD
Yzogc3RhYmxlLCBzaW5jZSB0aGUKdmFsdWVzIHVzZWQgcHJldmlvdXNseSBtYXRjaGVkIHRoZSBl
bnVtIHZhbHVlcywgc28gdGhlcmUncyBubyBjaGFuZ2UgaW4KYmVoYXZpb3VyKQoKUmV2aWV3ZWQt
Ynk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgoKCi0tIApFYXJ0aGxp
bmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3
dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAg
ICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
