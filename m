From: Jay Cornwall <jay-gJmSnxjMpeIFV7jr3Ov9Ew@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/gfx7: move eop programming per queue
Date: Wed, 23 Nov 2016 17:00:59 -0600
Message-ID: <1479942059.4125077.797525393.1034ADD9@webmail.messagingengine.com>
References: <1479932826-3362-1-git-send-email-alexander.deucher@amd.com>
 <1479932826-3362-2-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1479932826-3362-2-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

T24gV2VkLCBOb3YgMjMsIDIwMTYsIGF0IDE0OjI3LCBBbGV4IERldWNoZXIgd3JvdGU6Cj4gSXQn
cyBwZXIgcXVldWUgbm90IHBlciBwaXBlLgoKQXJlIHlvdSBzdXJlPyBJIHdhcyB1bmRlciB0aGUg
aW1wcmVzc2lvbiB0aGF0IEVPUCBxdWVldXMgd2VyZSBwZXItcGlwZQpvbiBHZng3IGFuZCBwZXIt
cXVldWUgb24gR2Z4OCBvbndhcmRzICh0byBzdXBwb3J0IGNvbnRleHQgc2F2ZS9yZXN0b3JlKS4K
SXQncyBhbHNvIGhpbnRlZCBhdCBieSB0aGUgcmVnaXN0ZXIgbmFtZSAoSFBEID09IEhhcmR3YXJl
IFBpcGUKRGVzY3JpcHRvciwgSFFEID09IEhhcmR3YXJlIFF1ZXVlIERlc2NyaXB0b3IpLgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
