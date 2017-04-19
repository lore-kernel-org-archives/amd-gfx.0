From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm: Harmonize CIK ASIC support in radeon and amdgpu (v2)
Date: Wed, 19 Apr 2017 14:59:16 -0400
Message-ID: <dedfed15-00b3-83ff-aca7-f4dffff8cc09@amd.com>
References: <1491866474-1016-1-git-send-email-Felix.Kuehling@amd.com>
 <ac35e641-6fd9-a5d1-c4d9-35e71fa9eb08@daenzer.net>
 <cbcc54ec-c86f-f0eb-715e-f66790b5f964@amd.com>
 <340a5310-e6d1-5e09-81aa-d7106bcdca02@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <340a5310-e6d1-5e09-81aa-d7106bcdca02-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMTctMDQtMTEgMTA6MjMgUE0sIE1pY2hlbCBEw6RuemVyIHdyb3RlOgo+IE9uZSBwb3NzaWJp
bGl0eSB3b3VsZCBiZSBtYWtpbmcgZWFjaCBkcml2ZXIgYWxzbyBwYXJzZSB0aGUgb3RoZXIKPiBk
cml2ZXIncyBtb2R1bGUgcGFyYW1ldGVyIG9uIHRoZSBrZXJuZWwgY29tbWFuZCBsaW5lLiBJLmUu
IHJhZGVvbiB3b3VsZAo+IHBhcnNlCj4KPiAgYW1kZ3B1LmVuYWJsZV9jaWs9MApJIGxvb2tlZCBm
b3IgYSB3YXkgdG8gZG8gdGhpcy4gSSB0aGluayBJIGZpZ3VyZWQgb3V0IHRoZSBwYXJzaW5nIHBh
cnQuCkJ1dCBJIGNhbid0IHNlZSB3aGVyZSB0byBnZXQgdGhlIGtlcm5lbCBjb21tYW5kIGxpbmUg
ZnJvbS4gVGhlIGNvbW1hbmQKbGluZSB0aGF0IGlzIHBhcnNlZCBieSBtb2R1bGVzIGluIGxvYWRf
bW9kdWxlIGNvbWVzIGZyb20gdXNlciBtb2RlLCBhbmQKSSB0aGluayBpdCdzIHByZS1wcm9jZXNz
ZWQgYnkgbW9kcHJvYmUgdG8gc3RyaXAgdGhlICI8bW9kdWxlPi4iIHByZWZpeAphbmQgb25seSBp
bmNsdWRlIHRoZSBtb2R1bGUtc3BlY2lmaWMgb3B0aW9ucy4KClRoZXJlIGlzIGEgZ2xvYmFsIHZh
cmlhYmxlIHNhdmVkX2NvbW1hbmRfbGluZSwgd2hpY2ggaXMgd2hhdCdzIHVzZWQgZm9yCi9wcm9j
L2NtZGxpbmUuIEJ1dCB0aGF0IHZhcmlhYmxlIGlzIG5vdCBleHBvcnRlZCB0byBtb2R1bGVzLgoK
UmVnYXJkcywKICBGZWxpeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
