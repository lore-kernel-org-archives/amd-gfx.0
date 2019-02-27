From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: KASAN caught amdgpu / HMM use-after-free
Date: Wed, 27 Feb 2019 18:33:23 +0100
Message-ID: <c26fa310-38d1-acba-cf82-bc6dc2f782c0@daenzer.net>
References: <e8466985-a66b-468b-5fff-6e743180da67@daenzer.net>
 <83fde7eb-abab-e770-efd5-89bc9c39fdff@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <83fde7eb-abab-e770-efd5-89bc9c39fdff-5C7GfCeVMHo@public.gmane.org>
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
To: "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOS0wMi0yNyA2OjE0IHAubS4sIFlhbmcsIFBoaWxpcCB3cm90ZToKPiBIaSBNaWNoZWws
Cj4gCj4gWWVzLCBJIGZvdW5kIHRoZSBzYW1lIGlzc3VlIGFuZCB0aGUgYnVnIGhhcyBiZWVuIGZp
eGVkIGJ5IEplcm9tZToKPiAKPiA4NzZiNDYyMTIwYWEgbW0vaG1tOiB1c2UgcmVmZXJlbmNlIGNv
dW50aW5nIGZvciBITU0gc3RydWN0Cj4gCj4gVGhlIGZpeCBpcyBvbiBobW0tZm9yLTUuMSBicmFu
Y2gsIEkgY2hlcnJ5LXBpY2sgaXQgaW50byBteSBsb2NhbCBicmFuY2ggCj4gdG8gd29ya2Fyb3Vu
ZCB0aGUgaXNzdWUuCgpQbGVhc2UgcHVzaCBpdCB0byBhbWQtc3RhZ2luZy1kcm0tbmV4dCwgc28g
dGhhdCBvdGhlcnMgZG9uJ3QgcnVuIGludG8KdGhlIGlzc3VlIGFzIHdlbGwuCgoKLS0gCkVhcnRo
bGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgIGh0dHBzOi8v
d3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAg
ICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
