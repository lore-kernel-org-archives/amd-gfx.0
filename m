From: David Binderman <dcb314-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: drivers/gpu/drm/radeon/r100.c:3303]: (style) Redundant condition
Date: Mon, 27 Mar 2017 10:07:44 +0000
Message-ID: <HE1PR0801MB1865D31CD715BAE301A5143C9C330@HE1PR0801MB1865.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-GB
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
To: "alexander.deucher-5C7GfCeVMHo@public.gmane.org" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

CkhlbGxvIHRoZXJlLAoKbGludXgtNC4xMS1yYzQvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yMTAw
LmM6MzMwM106IChzdHlsZSkgUmVkdW5kYW50IGNvbmRpdGlvbjogSWYgJ0VYUFIgPT0gMTEnLCB0
aGUgY29tcGFyaXNvbiAnRVhQUiA8PSAxMicgaXMgYWx3YXlzIHRydWUuCgpTb3VyY2UgY29kZSBp
cwoKICAgIH0gZWxzZSBpZiAocmRldi0+ZmFtaWx5ID09IENISVBfUlYzNTAgfHwKICAgICAgICAg
ICByZGV2LT5mYW1pbHkgPD0gQ0hJUF9SVjM4MCkgewoKQWxzbyBpbiB0aGUgc2FtZSBmaWxlOgoK
W2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjEwMC5jOjI1NTBdOiAoc3R5bGUpIFZhcmlhYmxlICd0
bXAnIGlzIGFzc2lnbmVkIGEgdmFsdWUKIHRoYXQgaXMgbmV2ZXIgdXNlZC4KW2RyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcjEwMC5jOjI4NzVdOiAoc3R5bGUpIFZhcmlhYmxlICd0bXAnIGlzIGFzc2ln
bmVkIGEgdmFsdWUKIHRoYXQgaXMgbmV2ZXIgdXNlZC4KClJlZ2FyZHMKCkRhdmlkIEJpbmRlcm1h
bgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
