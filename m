From: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: [V3 11/11] drm/amdgpu: do not reset gpu for virtualization
Date: Wed, 11 Jan 2017 21:18:18 +0800
Message-ID: <1484140698-10548-12-git-send-email-Xiangliang.Yu@amd.com>
References: <1484140698-10548-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1484140698-10548-1-git-send-email-Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>, Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

Q3VycmVudCBhbWRncHUgcmVzZXQgcHJvY2VzcyBvbmx5IHdvcmtzIG9uIGJhcmUtbWV0YWwgYW5k
IGZvcgpTUklPViBtYW55IGluc2lkZSBpdCBuZWVkIHJlLXdvcmsgdG8gYWRhcHQgdG8gdmYgZGV2
aWNlLgoKVGhpcyBpcyBhIHRlbXBvcmFyeSB3b3JrYXJvdW5kIHRvIHNraXAgZ3B1IHJlc2V0LgoK
U2lnbmVkLW9mZi1ieTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6
IFhpYW5nbGlhbmcgWXUgPFhpYW5nbGlhbmcuWXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
YwppbmRleCBhNmQ4MjhjLi41NzA1ZmJkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jCkBAIC0yMzI0LDYgKzIzMjQsOSBAQCBpbnQgYW1kZ3B1X2dwdV9yZXNl
dChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAlpbnQgcmVzY2hlZDsKIAlib29sIG5lZWRf
ZnVsbF9yZXNldDsKIAorCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpCisJCXJldHVybiAwOwor
CiAJaWYgKCFhbWRncHVfY2hlY2tfc29mdF9yZXNldChhZGV2KSkgewogCQlEUk1fSU5GTygiTm8g
aGFyZHdhcmUgaGFuZyBkZXRlY3RlZC4gRGlkIHNvbWUgYmxvY2tzIHN0YWxsP1xuIik7CiAJCXJl
dHVybiAwOwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
