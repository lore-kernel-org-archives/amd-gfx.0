Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E09C61DA4
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Feb 2023 21:12:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8FE910E29D;
	Thu, 23 Feb 2023 21:12:43 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ADEF10E214
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Feb 2023 20:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1677185495; i=spasswolf@web.de;
 bh=cP3d9Scl/DXJ8hbh7nQH+qR9GpIyxCJTHk9POEwONMU=;
 h=X-UI-Sender-Class:Subject:From:To:Date;
 b=T3iznCdJ7wVxZCjJaEVF62sqgTM/0d7ImF/F/XqPKIRWMh2LgaI8QXhZ5yq0+QuSj
 SzQnjsvLw0+pmxwLEKmDX8NUlmxxqa0ZbD/2+B2RQys6zxSH1ddI6c4hwaiccBN7sp
 fz4cWA5t6pDIYu+o+kMgC0gWbiclPKQWRc8HqJruj9BJ31spTeMVKhGzXXZ0u8Raup
 KoxVjQCCovCAofsYZriVPS33Qw8nfGdC2oxvBVZExWgf472oCwQU8nxoxVvkcZbU4r
 opkXv2GILqmkGJzrKq5PD+FJ6TZR6DMD2fgcK7qWRGIJFlkUT/TugsNXfMXakc7Hrm
 g5Vt1WgHL+pVw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([176.198.191.160]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MhWor-1oqioO081r-00eVuk for
 <amd-gfx@lists.freedesktop.org>; Thu, 23 Feb 2023 21:51:35 +0100
Message-ID: <002235887cbe5ee00240b568223fdb3bb3a25c53.camel@web.de>
Subject: Re: [PATCH] drm/amd: use drm_kms_helper_poll_fini in
 amdgpu_device_suspend to avoid warning
From: Bert Karwatzki <spasswolf@web.de>
To: amd-gfx@lists.freedesktop.org
Date: Thu, 23 Feb 2023 21:51:34 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-1 
MIME-Version: 1.0
X-Provags-ID: V03:K1:0O2pPpNSAXZH7/HW2kz2SvQYBMsW1fCUvf6zoQ9rp5ALpMVB4PL
 /eBMQFHjWUvS7aEkc4oQge3TMpwR7zkTXdm7h7byTXQAZmeh3YyZplQ1fU4ZZxUjthPSboV
 kUiohK5Z17sFCe7zZTV+H2UGp8Ds9DCzEA+7LoB6y0pzqs94OR5/vjM7G0XWOEeE+Bp9tKM
 +nAhl44F0kpGFp6FSBeOw==
UI-OutboundReport: notjunk:1;M01:P0:as8f1q2r4HU=;XD+BqMgw67qeDP9OlPNPjNUeip+
 V6gMyE4pmVBh23DTW9hCSm2T1Zmr5Q2NB80IYUehjzGU2iGtIw5WMCRCC6ORNBzxNAQpqvkiE
 yUZAS+3yD5o4uhxW8yEI3iCfT4zmbRmpGBETJIQ5D7KyNZQsclWfyGKplRb3kT22j0qeB6qdb
 GRA02y4iFOb7rxmdX80P8VD4uTNXpODsB890+50272gfJYBpe/38EmL+O1iUbG02Xts8R+yzh
 uPZyR52Y9pvueJEbTdZTBG4l3iIH1zI3fBG7rwtSo5XLXB79UyAPNTTn5ZadhPL0IimkdOd5K
 N9fM9HDCG+nm2l0ttc4SmiwC1d1mKm+pFTQwuPxP28eulZCCaS3Ja0bJVeIVg/OugEQduaB41
 wVq4p8GbGx7a537KDAFEVxt6lo4exTJoIWxwn/LGKk9yntUrSqlnrcY+o3Wg/E1X3oMunzjCV
 Tut7ix6hTy9Xpak4+Aag2OWb2sl9wGEQUoxYBVQczA/A82YlTYvP2mLyHLrGVCmRLv86fCwOn
 7kMvYYEBdrTtvkWRz/7NSeNbSb3uiB7KHDbBarw4jbRoaQ8+yfU4mV4yH4a04XNeW+k2GiaNi
 tspcLtnH77O+exgfgqdF+m1zz/suRHcWXjn2dqlu4PHyxUEiPoEJel8oQ6H1mhdqRtPv8pgr9
 iLouZ1PG0kgvFWN/KAPCvcNi4Z0DkBm4nCroibWA4yjzCVLyDY5CUnpkHHIYM/YZOL4EVct2w
 8JvbhtoMHOuJkaxi0Q4FzTHh5rTkqE5EY4JvS2qd68PWFOfioSowUQJzkFLWI4hJhsuz4iFzw
 fAtsVbvY7RVFl/iTetfNFoCPNpGC5AD1tgNLuFwIv/vd9qEL42dtOJ2gOARLMJXq2KCXY8AVs
 rR8VgcmdxMvCQh5o0LIrI8k6p13vgB1kH70YOjOKvIMPV+gl9Ocz6iDdmBokCNrj6/bO6NO8R
 wBXKO+tbEGE18a02+IMVE8oW11k=
X-Mailman-Approved-At: Thu, 23 Feb 2023 21:12:42 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When drm_kms_helper_poll_disable is used in amdgpu_device_suspend
without drm_kms_helper_poll_init having been called it causes a warning
in __flush_work:
https://gitlab.freedesktop.org/drm/amd/-/issues/2411
To avoid this one can use drm_kms_helper_poll_fini instead:
Send a second time because Evolution seems to have garbled the first
patch.=20

From 51cba3ae1e9f557cca8e37eb43b9b9310d0d504d Mon Sep 17 00:00:00 2001
From: Bert Karwatzki <spasswolf@web.de>
Date: Thu, 16 Feb 2023 10:34:11 +0100
Subject: [PATCH] Use drm_kms_helper_poll_fini instead of
=C2=A0drm_kms_helper_poll_disable in amdgpu_device.c to avoid a warning fro=
m
=C2=A0__flush_work.

Signed-off-by: Bert Karwatzki <spasswolf@web.de>
---
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
=C2=A0drivers/gpu/drm/drm_probe_helper.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 7 ++++---
=C2=A02 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b325f7039e0e..dc9e9868a84b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4145,7 +4145,7 @@ int amdgpu_device_suspend(struct drm_device *dev,
bool fbcon)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (amdgpu_acpi_smart_shift=
_update(dev, AMDGPU_SS_DEV_D3))
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0DRM_WARN("smart shift update failed\n");
=C2=A0
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drm_kms_helper_poll_disable(dev)=
;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drm_kms_helper_poll_fini(dev);
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (fbcon)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)-
> fb_helper, true);
diff --git a/drivers/gpu/drm/drm_probe_helper.c
b/drivers/gpu/drm/drm_probe_helper.c
index 8127be134c39..105d00d5ebf3 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -842,9 +842,10 @@ EXPORT_SYMBOL(drm_kms_helper_is_poll_worker);
=C2=A0 *
=C2=A0 * This function disables the output polling work.
=C2=A0 *
- * Drivers can call this helper from their device suspend
implementation. It is
- * not an error to call this even when output polling isn't enabled or
already
- * disabled. Polling is re-enabled by calling
drm_kms_helper_poll_enable().
+ * Drivers can call this helper from their device suspend
implementation. If it
+ * is not known if drm_kms_helper_poll_init has been called before the
driver
+ * should use drm_kms_helper_poll_fini_instead.
+ * Polling is re-enabled by calling drm_kms_helper_poll_enable().
=C2=A0 *
=C2=A0 * Note that calls to enable and disable polling must be strictly
ordered, which
=C2=A0 * is automatically the case when they're only call from
suspend/resume



