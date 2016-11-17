From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: gnome-shell is frozen upon wakeup from DPMS (bisected)
Date: Thu, 17 Nov 2016 17:27:17 +0900
Message-ID: <9a09c38c-870f-dc5b-327b-3cc99da49600@daenzer.net>
References: <e0aa85a5-c26e-f5ea-556b-ee8e5f3bc37e@suse.de>
 <0c0ae77d-fb23-0cdb-161b-c57f41327ad1@daenzer.net>
 <1b69099b-ffb0-0f48-2ab1-34dd6632f000@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------F71D03CEACB4888BF4E581D7"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1b69099b-ffb0-0f48-2ab1-34dd6632f000-l3A5Bk7waGM@public.gmane.org>
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
To: Max Staudt <mstaudt-l3A5Bk7waGM@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--------------F71D03CEACB4888BF4E581D7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 14/11/16 11:12 PM, Max Staudt wrote:
> On 11/14/2016 02:46 AM, Michel Dänzer wrote:
>> On 11/11/16 02:21 AM, Max Staudt wrote:
>>> Hi,
>>>
>>> I have bisected a commit in v4.6 that fixes a freeze of the screen on
>>> DPMS sleep:
>>>
>>> 777e3cbc791f131806d9bf24b3325637c7fc228d drm/radeon: Switch to drm_vblank_on/off
>>>
>>>
>>> When running 'xset dpms force off' in a GNOME session (I tested this on
>>> openSUSE Leap 42.2), sometimes the screen will freeze, sometimes it will
>>> not. It may take several tries.
>>>
>>> When it does freeze, the mouse can still be used, but clicking anything
>>> will (seem to?) have no effect. Typing in an open terminal still works,
>>> albeit the screen will still be frozen. Run "xterm" and the screen will
>>> unfreeze. Running "xlogo" does not unfreeze it.
>>
>> Does this still happen with current xf86-video-ati Git master?
> 
> 
> Hmm, good idea!
> 
> 
> I bisected this, and the problem goes away in this xf86-video-ati commit:
> 
> 1181b9c582f10b6c523e4b2988e2ce87ecf3d367 Enable DRI3 by default when building for Xorg >= 1.18.3
> 
> 
> I tested this on Kabini.
> 
> 
> So... what about DRI2?

Does the attached kernel patch help with pre-4.6 kernels?


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------F71D03CEACB4888BF4E581D7
Content-Type: text/x-patch;
 name="radeon-post-modeset-reset-irq.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="radeon-post-modeset-reset-irq.diff"

diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/rad=
eon/atombios_crtc.c
index 801dd60..3d41415 100644
--- a/drivers/gpu/drm/radeon/atombios_crtc.c
+++ b/drivers/gpu/drm/radeon/atombios_crtc.c
@@ -276,6 +276,7 @@ void atombios_crtc_dpms(struct drm_crtc *crtc, int mo=
de)
 			atombios_enable_crtc_memreq(crtc, ATOM_ENABLE);
 		atombios_blank_crtc(crtc, ATOM_DISABLE);
 		drm_vblank_post_modeset(dev, radeon_crtc->crtc_id);
+		radeon_irq_set(rdev);
 		radeon_crtc_load_lut(crtc);
 		break;
 	case DRM_MODE_DPMS_STANDBY:
diff --git a/drivers/gpu/drm/radeon/radeon_legacy_crtc.c b/drivers/gpu/dr=
m/radeon/radeon_legacy_crtc.c
index 32b338f..911efe5 100644
--- a/drivers/gpu/drm/radeon/radeon_legacy_crtc.c
+++ b/drivers/gpu/drm/radeon/radeon_legacy_crtc.c
@@ -332,6 +332,7 @@ static void radeon_crtc_dpms(struct drm_crtc *crtc, i=
nt mode)
 			WREG32_P(RADEON_CRTC_EXT_CNTL, crtc_ext_cntl, ~(mask | crtc_ext_cntl)=
);
 		}
 		drm_vblank_post_modeset(dev, radeon_crtc->crtc_id);
+		radeon_irq_set(rdev);
 		radeon_crtc_load_lut(crtc);
 		break;
 	case DRM_MODE_DPMS_STANDBY:

--------------F71D03CEACB4888BF4E581D7
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------F71D03CEACB4888BF4E581D7--
