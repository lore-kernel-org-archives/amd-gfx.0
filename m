From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
Date: Wed, 25 Apr 2018 14:40:54 -0400
Message-ID: <c39cb438-1e8a-4f2c-50f6-c6e2a144487b@amd.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <87muxsbmkp.fsf@xmission.com> <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com>
 <877eowa5qh.fsf@xmission.com> <20180425135552.GD7592@redhat.com>
 <f45c7017-c75a-7f0c-b6d5-4d79600cdd33@amd.com>
 <20180425171757.GA10441@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180425171757.GA10441-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Oleg Nesterov <oleg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: David.Panariti-5C7GfCeVMHo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>, Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org

CgpPbiAwNC8yNS8yMDE4IDAxOjE3IFBNLCBPbGVnIE5lc3Rlcm92IHdyb3RlOgo+IE9uIDA0LzI1
LCBBbmRyZXkgR3JvZHpvdnNreSB3cm90ZToKPj4gaGVyZSAoZHJtX3NjaGVkX2VudGl0eV9maW5p
KSBpcyBhbHNvIGEgYmFkIGlkZWEsIGJ1dCB3ZSBzdGlsbCB3YW50IHRvIGJlCj4+IGFibGUgdG8g
ZXhpdCBpbW1lZGlhdGVseQo+PiBhbmQgbm90IHdhaXQgZm9yIEdQVSBqb2JzIGNvbXBsZXRpb24g
d2hlbiB0aGUgcmVhc29uIGZvciByZWFjaGluZyB0aGlzIGNvZGUKPj4gaXMgYmVjYXVzZSBvZiBL
SUxMCj4+IHNpZ25hbCB0byB0aGUgdXNlciBwcm9jZXNzIHdobyBvcGVuZWQgdGhlIGRldmljZSBm
aWxlLgo+IENhbiB5b3UgaG9vayBmX29wLT5mbHVzaCBtZXRob2Q/CgpCdXQgdGhpcyBvbmUgaXMg
Y2FsbGVkIGZvciBlYWNoIHRhc2sgcmVsZWFzaW5nIGEgcmVmZXJlbmNlIHRvIHRoZSB0aGUgCmZp
bGUsIHNvIG5vdCBzdXJlIEkgc2VlIGhvdyB0aGlzIHNvbHZlcyB0aGUgcHJvYmxlbS4KCkFuZHJl
eQoKPgo+IE9sZWcuCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
