From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 13/14] drm/amdgpu: Define one variable for virtual display.
Date: Fri, 5 Aug 2016 17:29:28 +0900
Message-ID: <65e78804-d550-f983-7d09-23f707c24bbc@daenzer.net>
References: <1470377398-2186-1-git-send-email-Emily.Deng@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1470377398-2186-1-git-send-email-Emily.Deng-5C7GfCeVMHo@public.gmane.org>
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
To: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDUuMDguMjAxNiAxNTowOSwgRW1pbHkgRGVuZyB3cm90ZToKPiBGb3IgdmlydHVhbCBkaXNw
bGF5IGZlYXR1cmUsIGRlZmluZSBvbiB2YXJpYWJsZSBpbiBhbWRncHUua28uIFdoZW4gd2FudCB0
bwo+IGVuYWJsZSB2aXJ0dWFsIGRpc3BsYXkgZmVhdHVyZSwgbmVlZCBzZXQgdGhlIG9wdGlvbiAi
YW1kZ3B1LnZpcnR1YWxfZGlzcGxheT0xIi4KPiBBbmQgdGhlbiBkaXNhYmxlIHZnYSByZW5kZXIg
YW5kIGNydGMgaWYgaGF2ZSBEQ0UgZW5naW5lLgoKV2hhdCBpZiB0aGVyZSBhcmUgbXVsdGlwbGUg
R1BVcyBzdXBwb3J0ZWQgYnkgYW1kZ3B1IGluIHRoZSBzeXN0ZW0sIGFuZAp0aGUgdXNlciB3YW50
cyB0byBlbmFibGUgdmlydHVhbCBvdXRwdXQgZm9yIHNvbWUsIGJ1dCBub3QgYWxsIG9mIHRoZW0/
CgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAg
ICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAg
ICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
