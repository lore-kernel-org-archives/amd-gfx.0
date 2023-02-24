Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209BAC61DA4
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Feb 2023 15:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A879510EC65;
	Fri, 24 Feb 2023 15:55:56 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9AEC10E878
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Feb 2023 10:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1677235898; i=spasswolf@web.de;
 bh=I9/UjtVDJ+caW+EvKiZDZdjpa32RRJ/wdw17FHfa+eo=;
 h=X-UI-Sender-Class:Subject:From:To:Date:In-Reply-To:References;
 b=CW+tGzLvOxKlZRF+4nx077pWf/9BL+hj3c7Or6JeLEQeyDXA97h2YlOFOYL6bb/r0
 y9vkJQdkW1qwTlDxmtbRJXGzCuaKJlPSihp5ncgGaQG0DQVl3N46TsL3PGbC4wMMo9
 ABsco5ce1Ba8aNBEfcz21rJczIf0Y542VRpl7Sq7ZUdHX7or3KkBlx6aO/bD8t3Qp5
 5mXYOyyofgKF7I2QKpkU6FlDuXMRuJ7eBlScZ11gNHVJvXhQfXWH3xXy/jB+Z/6Qns
 1tsCnL5DF0fzxG4340ufgL/UZq2VxqmWUf3svzzVNLnRjnyWCTNJ0vTIrz1u9w9JwW
 n9PmFM6PahHCg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([176.198.191.160]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1rP8-1pTJjq308m-002Q8S; Fri, 24
 Feb 2023 11:46:30 +0100
Message-ID: <787d2fde7506de27038f191f831ceeda712a97df.camel@web.de>
Subject: Re: [PATCH] drm/amd: use drm_kms_helper_poll_fini in
 amdgpu_device_suspend to avoid warning
From: Bert Karwatzki <spasswolf@web.de>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Date: Fri, 24 Feb 2023 11:46:29 +0100
In-Reply-To: <DM5PR12MB24697477DE905E5985169EECF1A89@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <002235887cbe5ee00240b568223fdb3bb3a25c53.camel@web.de>
 <DM5PR12MB24697477DE905E5985169EECF1A89@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-1 
MIME-Version: 1.0
X-Provags-ID: V03:K1:ozgkUnt/5xDBlRwARzw+CnhJcXDFGTJeLTu4MXDcQsKysXHXw8l
 IdkFXOOUmhxVYsI+Xc8xZYxXMOXLcQlzLmj/cBq/udRFI3xFbhZ4h9Rzof81ye/ZxaGaAQf
 6ytFSs6zwK4LAoMUdz2ZgIeNHjeSwUlavwBWEilSQcq2alD/ClOgtxF6gDbLpCVSwJ/wh0z
 lV5oLgR8W88YtnXyAsAAw==
UI-OutboundReport: notjunk:1;M01:P0:nbfjDlq0dGM=;DCoJLaD+1uT5FDocvxNmGbmv+22
 pDk43qhEa9inw23QXhWG4dIM9Jb11Bte+nNHoOoY2yYViaj7oEHRYvYtdocr0tDvsByvZKoO2
 1nNpJNP5hae1QOyZO+PFtsnq2PYFHAdRLiv3TpFYRM7CzWwevYN3s4oW8ps502X5Pziye7Qrp
 LutqevhcrLoIHIrEyisoq714v0Z0DS4Cvi4blVaLpKF4d6d9pMt+L6JRRhaR+MnVmlQVOdSOZ
 ydLkWShi7SIY+8B3xXfg6uHuWP+xM39YEvPlyJmy48TyXfWBOqtJ/jPFbCxjN9AJLFyPezGqC
 Z1UmG5uthIVal8nsA6KGHpgf+7FpeKzqpnqkE4g9flTLb/wqid2jCgqXp7Iloq9fZ8NoT3PCu
 DXkNoXAV9o8b+j9Sa/V/aPZHIQ2C1GcJUmG/6PVJiCVR1JCvfwnBSvCl8s/exGU3hvIEZCDh/
 0boldnUtZGqvB8E8Fz6VLx7aRpGfUT6QimlYuS8yEJg05AP+M0b8esOjOStDKQ2tVERVPgSre
 xHvmpu10Q7o5taxdeVNz/nbeW3yxN9ivBGCbkVv5UPCEPjG75Nq9ATOX3qcYQLieIVbHRYwYN
 N5b4qBR0K3AjvR28zWghc63g+nVYdNCubmd6/C3Qkp05h+UfpFYJyZct+sOKbrvp1PZ5R7Znq
 VwR7MO2yVqFbO9cqenPZhtPSA3U5YHXKwl+U+PkC7QecBY/fGrOXoVAK2WdpRj7nbG/eixsHq
 gdgjRj3oUA40HRCwz8GB5lxOtsNMcmLS7SJnH/ttY80yYHyfdV9K77Si5jg/V0jVxFRqPPaPr
 XhWCkgEduPOYH01vagQYRfuotxTNJWkhg+Z3aAUCIhe5dh460f7uODf9Zw3Xw43hiA4cRoh7k
 KT5cK/hfgA3a2/kiskDZG3eVxIs+Bi21IKmUUUEZ+Nh2lREtyNWBfvWpYsSG0lJIBK2E1o/eZ
 4k5mCmUg1m/+vlKexNKhrTsxlM8=
X-Mailman-Approved-At: Fri, 24 Feb 2023 15:55:54 +0000
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

Am Freitag, dem 24.02.2023 um 02:26 +0000 schrieb Chen, Guchun:
> > Hi Bert,
> >=20
> > Thanks for your patch. As we will can drm_kms_helper_poll_enable in
> > resume, so it may not make sense using drm_kms_helper_poll_fini in
> > suspend, from code pairing perspective.
> >=20
> > For your case, is it possible to fix the problem by limiting the
> > access of drm_kms_helper_poll_disable with checking
> > mode_config_initialized in adev structure? We can get rid of the
> > code
> > change in drm core in this way.
> >=20
> > Regards,
> > Guchun
> >=20
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Bert Karwatzki
> > Sent: Friday, February 24, 2023 4:52 AM
> > To: amd-gfx@lists.freedesktop.org
> > Subject: Re: [PATCH] drm/amd: use drm_kms_helper_poll_fini in
> > amdgpu_device_suspend to avoid warning
> >=20
> > When drm_kms_helper_poll_disable is used in amdgpu_device_suspend
> > without drm_kms_helper_poll_init having been called it causes a
> > warning in __flush_work:
> > https://gitlab.freedesktop.org/drm/amd/-/issues/2411
> > To avoid this one can use drm_kms_helper_poll_fini instead:
> > Send a second time because Evolution seems to have garbled the
> > first
> > patch.=20
> >=20
> > From 51cba3ae1e9f557cca8e37eb43b9b9310d0d504d Mon Sep 17 00:00:00
> > 2001
> > From: Bert Karwatzki <spasswolf@web.de>
> > Date: Thu, 16 Feb 2023 10:34:11 +0100
> > Subject: [PATCH] Use drm_kms_helper_poll_fini instead of
> > =C2=A0drm_kms_helper_poll_disable in amdgpu_device.c to avoid a warning
> > from
> > =C2=A0__flush_work.
> >=20
> > Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> > ---
> > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
> > =C2=A0drivers/gpu/drm/drm_probe_helper.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 7 ++++---
> > =C2=A02 files changed, 5 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index b325f7039e0e..dc9e9868a84b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -4145,7 +4145,7 @@ int amdgpu_device_suspend(struct drm_device
> > *dev, bool fbcon)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (amdgpu_acpi_smart_s=
hift_update(dev, AMDGPU_SS_DEV_D3))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0DRM_WARN("smart shift update failed\n");
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drm_kms_helper_poll_disable(=
dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drm_kms_helper_poll_fini(dev=
);
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (fbcon)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0drm_fb_helper_set_suspend_unlocked(adev_to_drm(a=
dev
> > )-
> > > > fb_helper, true);
> > diff --git a/drivers/gpu/drm/drm_probe_helper.c
> > b/drivers/gpu/drm/drm_probe_helper.c
> > index 8127be134c39..105d00d5ebf3 100644
> > --- a/drivers/gpu/drm/drm_probe_helper.c
> > +++ b/drivers/gpu/drm/drm_probe_helper.c
> > @@ -842,9 +842,10 @@ EXPORT_SYMBOL(drm_kms_helper_is_poll_worker);
> > =C2=A0 *
> > =C2=A0 * This function disables the output polling work.
> > =C2=A0 *
> > - * Drivers can call this helper from their device suspend
> > implementation. It is
> > - * not an error to call this even when output polling isn't
> > enabled
> > or already
> > - * disabled. Polling is re-enabled by calling
> > drm_kms_helper_poll_enable().
> > + * Drivers can call this helper from their device suspend
> > implementation. If it
> > + * is not known if drm_kms_helper_poll_init has been called before
> > the
> > driver
> > + * should use drm_kms_helper_poll_fini_instead.
> > + * Polling is re-enabled by calling drm_kms_helper_poll_enable().
> > =C2=A0 *
> > =C2=A0 * Note that calls to enable and disable polling must be strictly
> > ordered, which
> > =C2=A0 * is automatically the case when they're only call from
> > suspend/resume
> >=20
No, that does not work for me. I tried (in linux-next-20230224):

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c4a4e2fe6681..27fb42b1bde4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4145,7 +4145,13 @@ int amdgpu_device_suspend(struct drm_device
*dev, bool fbcon)
        if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D3))
                DRM_WARN("smart shift update failed\n");
=20
-       drm_kms_helper_poll_disable(dev);
+       if (adev->mode_info.mode_config_initialized) {
+               printk(KERN_INFO "adev-
>mode_info.mode_config_initialized =3D %d\n",
+                               adev-
>mode_info.mode_config_initialized);
+               printk(KERN_INFO "dev->mode_config.poll_enabled =3D
%d\n",
+                               dev->mode_config.poll_enabled);
+               drm_kms_helper_poll_disable(dev);
+       }
=20
        if (fbcon)
                drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)-
>fb_helper, true);

and found that mode_config_initialized=3D1 but dev-
>mode_config.poll_enabled=3D0 with the usual warning:
[   23.287058] adev->mode_info.mode_config_initialized =3D 1
[   23.287061] dev->mode_config.poll_enabled =3D 0
[   23.287063] ------------[ cut here ]------------
[   23.287064] WARNING: CPU: 0 PID: 16 at kernel/workqueue.c:3167
__flush_work.isra.0+0x261/0x270

The flag that needs to be checked to avoid the warning is dev-
>mode_config.poll_enabled which gets set by drm_kms_helper_poll_init
and drm_kms_helper_poll_fini does just that. Changing the comment of
drms_kms_helper_poll_disable is technically not necessary though.
Bert Karwatzki

