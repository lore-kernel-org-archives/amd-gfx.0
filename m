From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH libdrm 2/2] amdgpu: Update amdgpu_bo_handle_type_kms_noimport
 documentation
Date: Mon, 24 Jun 2019 17:45:35 +0200
Message-ID: <20190624154535.8619-3-michel@daenzer.net>
References: <20190624154535.8619-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190624154535.8619-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpUbyByZWZsZWN0
IGN1cnJlbnQgcmVhbGl0eS4KClNpZ25lZC1vZmYtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwu
ZGFlbnplckBhbWQuY29tPgotLS0KIGFtZGdwdS9hbWRncHUuaCB8IDQgKystLQogMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hbWRn
cHUvYW1kZ3B1LmggYi9hbWRncHUvYW1kZ3B1LmgKaW5kZXggOWQ5YjA4MzIuLjY2ZTQ1ZjczIDEw
MDY0NAotLS0gYS9hbWRncHUvYW1kZ3B1LmgKKysrIGIvYW1kZ3B1L2FtZGdwdS5oCkBAIC04Nyw4
ICs4Nyw4IEBAIGVudW0gYW1kZ3B1X2JvX2hhbmRsZV90eXBlIHsKIAkvKiogRE1BLWJ1ZiBmZCBo
YW5kbGUgKi8KIAlhbWRncHVfYm9faGFuZGxlX3R5cGVfZG1hX2J1Zl9mZCA9IDIsCiAKLQkvKiog
S01TIGhhbmRsZSwgYnV0IHJlLWltcG9ydGluZyBhcyBhIERNQUJVRiBoYW5kbGUgdGhyb3VnaAot
CSAqICBkcm1QcmltZUhhbmRsZVRvRkQgaXMgZm9yYmlkZGVuLiAoR2xhbW9yIGRvZXMgdGhhdCkK
KwkvKiogRGVwcmVjYXRlZCBpbiBmYXZvdXIgb2YgYW5kIHNhbWUgYmVoYXZpb3VyIGFzCisJICog
YW1kZ3B1X2JvX2hhbmRsZV90eXBlX2ttcywgdXNlIHRoYXQgaW5zdGVhZCBvZiB0aGlzCiAJICov
CiAJYW1kZ3B1X2JvX2hhbmRsZV90eXBlX2ttc19ub2ltcG9ydCA9IDMsCiB9OwotLSAKMi4yMC4x
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
