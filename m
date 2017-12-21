From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Simplify amdgpu_lockup_timeout usage.
Date: Thu, 21 Dec 2017 18:09:25 +0100
Message-ID: <e66e22c8-bdaa-7ce6-7d03-c93107387bcb@daenzer.net>
References: <1513194292-8416-1-git-send-email-andrey.grodzovsky@amd.com>
 <966ada12-9d57-b6bd-37a2-494f6dfa67cd@daenzer.net>
 <f5351f8f-ad38-5517-ae87-e5d8efab1839@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f5351f8f-ad38-5517-ae87-e5d8efab1839-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxNy0xMi0xOSAwNjo0NyBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBZZWFoLCB0
aGF0IGlzIGEga25vd24gaXNzdWUgd2hpY2ggY2FtZSB0byBmcm9udCBhZ2FpbiBiZWNhdXNlIEFu
ZHJleSdzCj4gcGF0Y2ggaXMgc2xpZ2h0bHkgYnVnZ3kuCj4gCj4gUGxlYXNlIHRlc3QgYW5kIHJl
dmlldyB0aGUgYXR0YWNoZWQgKG9ubHkgY29tcGlsZSB0ZXN0ZWQpIGZpeCBmb3IKPiBBbmRyZXkn
cyBwYXRjaC4KPiAKPiBTdGlsbCB3b3JraW5nIG9uIGZpbmRpbmcgdGhlIHJvb3QgY2F1c2UsIGJ1
dCBzbyBmYXIgZGlkbid0IGhhZCB0aW1lIGZvcgo+IHRoYXQuCgpVbmZvcnR1bmF0ZWx5LCBJIGhh
dmVuJ3QgYmVlbiBhYmxlIHRvIG5hcnJvdyBpdCBkb3duIHRvIGFueSBwYXJ0aWN1bGFyCnBpZ2xp
dCB0ZXN0cy4gV2hhdCBJIGNhbiBzYXkgdGhvdWdoIGlzIHRoYXQgaXQncyB0cmlnZ2VyZWQgbXVj
aCBtb3JlCnF1aWNrbHkgd2hlbiBydW5uaW5nIHBpZ2xpdCB3aXRoIC0tcHJvY2Vzcy1pc29sYXRp
b24gZmFsc2UuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFz
dCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
