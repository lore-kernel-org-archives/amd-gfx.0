From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: libdrm/amdgpu - Fixup typedef not to hide pointer type
Date: Fri, 16 Sep 2016 18:46:07 +1000
Message-ID: <1474015570-30928-1-git-send-email-funfunctor@folklore1984.net>
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

T29wcywgdHVybnMgb3V0IEkgbWFpbGVkIHRvIGRyaS1kZXZlbCBieSBtaXN0YWtlIHNvIHJlc2Vu
ZGluZyBoZXJlLgoKVGhlIGZvbGxvd2luZyBzZXJpZXMgZml4ZXMgdXAgbGliZHJtL2FtZGdwdSBz
dWNoIHRoYXQgdG8gbm90IGhpZGUKYSBwb2ludGVyIHR5cGUgYmVoaW5kIGEgdHlwZWRlZi4KClBs
ZWFzZSBSZXZpZXcsCgpFZHdhcmQgTydDYWxsYWdoYW4gKDMpOgogW1BBVENIIDEvM10gYW1kZ3B1
OiBGaXggYW1kZ3B1X3ZhX2hhbmRsZSB0eXBlZGVmIG5vdCB0byBoaWRlIHBvaW50ZXIKIFtQQVRD
SCAyLzNdIGFtZGdwdTogRml4IGFtZGdwdV9zZW1hcGhvcmVfaGFuZGxlIHR5cGVkZWYgbm90IHRv
IGhpZGUKIFtQQVRDSCAzLzNdIGFtZGdwdTogRml4IGFtZGdwdV9ib19saXN0X2hhbmRsZSB0eXBl
ZGVmIG5vdCB0byBoaWRlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
