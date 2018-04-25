From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
Date: Wed, 25 Apr 2018 10:21:45 -0400
Message-ID: <f45c7017-c75a-7f0c-b6d5-4d79600cdd33@amd.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <87muxsbmkp.fsf@xmission.com> <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com>
 <877eowa5qh.fsf@xmission.com> <20180425135552.GD7592@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180425135552.GD7592-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Oleg Nesterov <oleg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>
Cc: David.Panariti-5C7GfCeVMHo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org

CgpPbiAwNC8yNS8yMDE4IDA5OjU1IEFNLCBPbGVnIE5lc3Rlcm92IHdyb3RlOgo+IE9uIDA0LzI0
LCBFcmljIFcuIEJpZWRlcm1hbiB3cm90ZToKPj4gTGV0IG1lIHJlc3BlY3RmdWxseSBzdWdnZXN0
IHRoYXQgdGhlIHdhaXRfZXZlbnRfa2lsbGFibGUgb24gdGhhdCBjb2RlCj4+IHBhdGggaXMgd3Jv
bmcuCj4gSSB0ZW5kIHRvIGFncmVlIGV2ZW4gaWYgSSBkb24ndCBrbm93IHRoaXMgY29kZS4KPgo+
IEJ1dCBpZiBpdCBjYW4gYmUgY2FsbGVkIGZyb20gZl9vcC0+cmVsZWFzZSgpIHRoZW4gYW55IHVz
YWdlIG9mICJjdXJyZW50IiBvcgo+IHNpZ25hbHMgbG9va3Mgc3VzcGljaW91cy4gU2ltcGx5IGJl
Y2F1c2UgImN1cnJlbnQiIGNhbiBiZSBjb21wbGV0ZWx5IGlycmVsZXZhbnQKPiB0YXNrIHdoaWNo
IGRvZXMgdGhlIGxhc3QgZnB1dCgpLCBzYXksIGNhdCAvcHJvYy9waWQvZmRpbmZvLy4uLiBvciBl
dmVuIGEga2VybmVsCj4gdGhyZWFkLgo+Cj4gT2xlZy4KClNvIHdoYXQgeW91IHNheSBpcyB0aGF0
IHN3aXRjaGluZyB0byBjdXJyZW50LT5QRl9FWElUSU5HIGFzIGluZGljYXRpb24gCm9mIGEgcmVh
c29uIHdoeSBJIGFtCmhlcmUgKGRybV9zY2hlZF9lbnRpdHlfZmluaSkgaXMgYWxzbyBhIGJhZCBp
ZGVhLCBidXQgd2Ugc3RpbGwgd2FudCB0byBiZSAKYWJsZSB0byBleGl0IGltbWVkaWF0ZWx5CmFu
ZCBub3Qgd2FpdCBmb3IgR1BVIGpvYnMgY29tcGxldGlvbiB3aGVuIHRoZSByZWFzb24gZm9yIHJl
YWNoaW5nIHRoaXMgCmNvZGUgaXMgYmVjYXVzZSBvZiBLSUxMCnNpZ25hbCB0byB0aGUgdXNlciBw
cm9jZXNzIHdobyBvcGVuZWQgdGhlIGRldmljZSBmaWxlLiBXaXRoIHRlcm1pbmF0aW9uIApmcm9t
IGZwdXQgwqAgaXQgc2VlbXMgaW1wb3NzaWJsZS4uLgpCdXQgdGhpbmtpbmcgbW9yZSBhYm91dCBp
dCwgYW55IHRhc2sgc3RpbGwgcmVmZXJlbmNpbmcgdGhpcyBmaWxlIGFuZCAKcHV0dGluZyBkb3du
IHRoZSByZWZlcmVuY2UgYW5kIGlzIG5vdApleGl0aW5nIGR1ZSB0byBTSUdLSUxMIHdpbGwganVz
dCBoYXZlIHRvIGdvIHRocm91Z2ggdGhlwqAgc2xvdyBwYXRoIC0gCndhaXQgZm9yIGpvYnMgY29t
cGxldGlvbiBvbiBHUFUgKHdpdGggc29tZSBUTykuCgpBbmRyZXkKCj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
