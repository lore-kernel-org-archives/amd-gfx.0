From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: possible use-after-free in amdgpu_dm
Date: Tue, 17 Oct 2017 10:10:26 -0400
Message-ID: <f6968925-fe34-901e-1d86-32680620bcb0@amd.com>
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
To: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

SW4gdGhpcyBibG9jayBvZiBjb2RlOgoKdm9pZCBhbWRncHVfZG1fY29ubmVjdG9yX2Z1bmNzX3Jl
c2V0KHN0cnVjdCBkcm1fY29ubmVjdG9yICpjb25uZWN0b3IpCnsKCXN0cnVjdCBkbV9jb25uZWN0
b3Jfc3RhdGUgKnN0YXRlID0KCQl0b19kbV9jb25uZWN0b3Jfc3RhdGUoY29ubmVjdG9yLT5zdGF0
ZSk7CgoJa2ZyZWUoc3RhdGUpOwoKCXN0YXRlID0ga3phbGxvYyhzaXplb2YoKnN0YXRlKSwgR0ZQ
X0tFUk5FTCk7CgoKVGhlIHZhbHVlIG9mIHN0YXRlIGlzIG5ldmVyIGNvbXBhcmVkIHdpdGggTlVM
TCBhbmQgbW9yZXNvIHRoZSB2YWx1ZSBvZiAKY29ubmVjdG9yLT5zdGF0ZSBpcyBuZXZlciB3cml0
dGVuIHRvIGlmIE5VTEwuICBXb3VsZG4ndCB0aGlzIG1lYW4gdGhlIApwb2ludGVyIHBvaW50cyB0
byBmcmVlZCBtZW1vcnk/CgpDaGVlcnMsClRvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
