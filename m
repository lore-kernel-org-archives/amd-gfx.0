From: Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>
Subject: Latest drm-next-4.9-wip is causing gfx kernel thread to be pegged
 100% running piglit
Date: Sun, 18 Sep 2016 20:06:51 -0400
Message-ID: <2930478.U0IfgREB3m@segfault>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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

TG9va3MgbGlrZSBzb21ldGhpbmcgYnJva2UgaW4gZHJtLW5leHQtNC45LXdpcCwgdW5zdXJlIHdo
aWNoIGNoYW5nZSBkaWQuCgpXaGVuIHJ1bm5pbmc6IHBpZ2xpdCB0ZXN0cy9ncHUgc3VtbWFyeS9h
bWRncHUgCgoKQWxzbyB0cmlnZ2VyczoKWyAxODQ4LjUwNTQ5OF0gW2RybTphbWRncHVfY3NfaW9j
dGwgW2FtZGdwdV1dICpFUlJPUiogdHRtX2V1X3Jlc2VydmVfYnVmZmVycyAKZmFpbGVkLgoKV2ls
bCB0ZXN0IDQuOC1yYzYgdmFuaWxsYSB0byBzZWUgaWYgc29tZXRoaW5nIGJyb2tlIHRoZXJlLgoK
VGhhbmtzLApTaGF3bgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
