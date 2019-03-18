From: Shaobo He <shaobo-sDh8Nw2yj/+Vc3sceRu5cw@public.gmane.org>
Subject: Potential NULL pointer dereference in atombios_get_encoder_mode
Date: Mon, 18 Mar 2019 14:15:48 -0600
Message-ID: <385ae10b-b173-55ab-d34b-3c6b8afdee30@cs.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: alexander.deucher-5C7GfCeVMHo@public.gmane.org, hristian.koenig-5C7GfCeVMHo@public.gmane.org, David1.Zhou-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

SGVsbG8gZXZlcnlvbmUsCgpNeSBuYW1lIGlzIFNoYW9ibyBIZSBhbmQgSSBhbSBhIGdyYWR1YXRl
IHN0dWRlbnQgYXQgVW5pdmVyc2l0eSBvZiBVdGFoLiBJIGFtIAp1c2luZyBhIHN0YXRpYyBhbmFs
eXNpcyB0b29sIHRvIHNlYXJjaCBmb3IgbnVsbCBwb2ludGVyIGRlcmVmZXJlbmNlcyBhbmQgY2Ft
ZSAKYWNyb3NzIGEgcG90ZW50aWFsbHkgaW52YWxpZCBtZW1vcnkgYWNjZXNzZXMgaW4gdGhlIGZp
bGUgCmRyaXZlcnMvZ3B1L2RybS9yYWRlb24vYXRvbWJpb3NfZW5jb2RlcnMuYzogaW4gZnVuY3Rp
b24gCmBhdG9tYmlvc19nZXRfZW5jb2Rlcl9tb2RlYCwgZnVuY3Rpb24gYHJhZGVvbl9nZXRfY29u
bmVjdG9yX2Zvcl9lbmNvZGVyX2luaXRgIApjYW4gcmV0dXJuIGEgTlVMTCBwb2ludGVyLiBJdCBz
ZWVtcyB0aGUgb25seSBjaGFuY2UgdGhhdCBpdCBtYXkgaGFwcGVuIGlzIHRoYXQgCnRoZXJlIGlz
IG5vdCBhbnkgY29ubmVjdG9yIGF0dGFjaGVkIHRvIHRoZSBkZXZpY2Ugb2YgdGhlIGVuY29kZXIg
b3IgY29ubmVjdG9ycyAKYXJlIGFsbCBpbnZhbGlkLiBJIHdhcyB3b25kZXJpbmcgaWYgaXQgY2Fu
IGhhcHBlbiBpbiB0aGUgY2FsbCBjb250ZXh0LgoKUGxlYXNlIGxldCBtZSBrbm93IGlmIGl0IG1h
a2VzIHNlbnNlLiBJIGFtIGxvb2tpbmcgZm9yd2FyZCB0byB5b3VyIHJlcGx5LgoKQmVzdCwKU2hh
b2JvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
