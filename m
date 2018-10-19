From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 15/18] drm: Remove DRM_GLOBAL_TTM_OBJECT
Date: Fri, 19 Oct 2018 10:54:20 +0200
Message-ID: <20181019085423.28159-16-tzimmermann@suse.de>
References: <20181019085423.28159-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181019085423.28159-1-tzimmermann-l3A5Bk7waGM@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, ray.huang-5C7GfCeVMHo@public.gmane.org, Jerry.Zhang-5C7GfCeVMHo@public.gmane.org, alexander.deucher-5C7GfCeVMHo@public.gmane.org, David1.Zhou-5C7GfCeVMHo@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, syeh-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org, z.liuxinliang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
Cc: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

VGhlIGNvbnN0YW50IERSTV9HTE9CQUxfVFRNX09CSkVDVCBpcyB1bnVzZWQgYW5kIG5vdCBvYnZp
b3VzbHkgdXNlZnVsLgoKU2lnbmVkLW9mZi1ieTogVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1tZXJt
YW5uQHN1c2UuZGU+Ci0tLQogaW5jbHVkZS9kcm0vZHJtX2dsb2JhbC5oIHwgMSAtCiAxIGZpbGUg
Y2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2RybV9nbG9i
YWwuaCBiL2luY2x1ZGUvZHJtL2RybV9nbG9iYWwuaAppbmRleCA0NDgyYTliYmQ2ZTkuLjYzZmZk
Y2VjNjY5MCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9kcm0vZHJtX2dsb2JhbC5oCisrKyBiL2luY2x1
ZGUvZHJtL2RybV9nbG9iYWwuaApAQCAtNDEsNyArNDEsNiBAQAogZW51bSBkcm1fZ2xvYmFsX3R5
cGVzIHsKIAlEUk1fR0xPQkFMX1RUTV9NRU0gPSAwLAogCURSTV9HTE9CQUxfVFRNX0JPLAotCURS
TV9HTE9CQUxfVFRNX09CSkVDVCwKIAlEUk1fR0xPQkFMX05VTQogfTsKIAotLSAKMi4xOS4xCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
