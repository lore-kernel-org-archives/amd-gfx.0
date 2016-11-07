From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: amdgpu: ratelimit on vm faults to avoid spaming console
Date: Mon,  7 Nov 2016 14:47:48 +1100
Message-ID: <1478490470-27089-1-git-send-email-funfunctor@folklore1984.net>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

VGhlc2UgYXJlIHJhdGhlciBtaW5vciBob3dldmVyIHNob3VsZCBoZWxwIHN0b3Agc29tZSBmb2xr
cwptYWNoaW5lcyBncmluZGluZyB0byBhIGhhbHQgd2hlbiBhIHVzZXJzcGFjZSBhcHBsaWNhdGlv
biBzb21laG93CmdldHMgdGhlIEdQVSBpbnRvIHNvbWUgaG9ycmlibGUgc3RhdGUgY2F1c2luZyB0
aGUgY29uc29sZSB0byBmaWxsCnZlcnkgcXVpY2tseS4gQXBwbGllcyBvbiB0b3Agb2YgbWFzdGVy
LgoKUGxlYXNlIGtpbmRseSByZXZpZXcsCgpFZHdhcmQgTydDYWxsYWdoYW4gKDIpOgogW1BBVENI
IDEvMl0gYW1kZ3B1OiBVc2UgZGV2X2VycigpIG92ZXIgdmFuaWxsYSBwcmludGsoKSBpbgogW1BB
VENIIDIvMl0gYW1kZ3B1OiBVc2UgJ2Rldl9lcnJfcmF0ZWxpbWl0ZWQoKScgb3ZlciAnZGV2X2Vy
cigpJyBvbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
