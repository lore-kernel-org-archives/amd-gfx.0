Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C59DC6FA8E
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Feb 2023 17:12:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 529AE10E222;
	Fri, 24 Feb 2023 17:12:53 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 420CE10EC93
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Feb 2023 15:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1677254262; i=spasswolf@web.de;
 bh=Pl8yOM28j7Z5vdCpifzycsvL5RveC52RmCR2XDPFgmM=;
 h=X-UI-Sender-Class:Subject:From:To:Date:In-Reply-To:References;
 b=EgwgouRMuduQPvoFgk3ZC2KkBQ6zebV2Cb+ZaIbXNYWzRmbABrx+koEBg99Ki5tRT
 niL0LKWH4V84BVVw2O7LKR5zCkz/xfVQ+aSAXakAjZ426ppxat3OeRWRyNvVRS87ef
 caiEbVrV7Xr1FlqE7OzS7c77lNzQgSLJUbQqy/pLMmtbW8nn9kU+gDcXe9UzXLka6u
 iUzLNQNBoTuWmrc2zWp0R7ZG1BLrhoty8jspCyvvSqeGeV+nbcCzfMwXUh0Btngfv8
 k6RH2tJ8aVOFXUJ00Spv4xIS49EIzq7a5NHFajYNy3cTG2dOcIo4gKM1ZyZRz81GZ7
 W2RUNkD8sFlzQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([176.198.191.160]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgRMB-1orXw129hX-00hhzi; Fri, 24
 Feb 2023 16:57:42 +0100
Message-ID: <7da40d61b8d08c8eba5c1bb016cf615fd005ad79.camel@web.de>
Subject: Re: [PATCH] drm/amd: use drm_kms_helper_poll_fini in
 amdgpu_device_suspend to avoid warning
From: Bert Karwatzki <spasswolf@web.de>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, amd-gfx@lists.freedesktop.org
Date: Fri, 24 Feb 2023 16:57:42 +0100
In-Reply-To: <DM5PR12MB24697477DE905E5985169EECF1A89@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <002235887cbe5ee00240b568223fdb3bb3a25c53.camel@web.de>
 <DM5PR12MB24697477DE905E5985169EECF1A89@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-1 
MIME-Version: 1.0
X-Provags-ID: V03:K1:XqV7MB4cXvmFY5DbhUJ9nCgu9ABn4Q51CqtcEWr7U8jjrQPbrsC
 6sIiUZ22oH2jPeyE7AmZLAvOmM3sf1JaMQJbQJFD7IYQaBpLDyHRC/6ZKaA7ybxuvt+f41o
 IfRIEH287FQsFG36ywgDLT/1vHjcGhPRjaOZP0po3LhjVFqnlbLgH1+KnD/wd8elB6MrjLr
 7QuR4sq16enmWF/BhhsMA==
UI-OutboundReport: notjunk:1;M01:P0:KXSXEXki7eo=;aepTTC11+1SLrOne/qW18v+SFU7
 WtD0oF2r2BMgHFCXQHcfUaX9OzbTnxwaL02FjWwp6cW9yayPYzQzw+4a8YDjKb+jUvfvAv2LT
 StT5FPmmiTtKzWm/kOHO82EmWjiVqrVLsYEcUsASOUlNEPe8O3siSAiTp/Pfn7oROJ0YH8oKu
 sfBu3udNtWiVA9fpFBlCn1THXxKYu7migjutaveqn5tKEKhAn+iiddPY+OZ/4F52My92pNvgk
 +3L0ck6ArUgb4cC15V63yeN/SMZDbPdNJHe+/SjiRIU5OsuStIi/aD+utwGIBD7424hkwSM+g
 v83iyNzad4lOS8KrsWvaVKJCJq6LoymjcUuf1ZHykAlPdlHlIK9b4qo11ZskLSQqgA5efa2pY
 uBhVhRXp5GDUHMlqEjdbMNyM2UEsgDw3KY1vMUqygwS3bY38IOTX1PJ9vphPvuznINoXy/sOy
 NqE6VC4W63R5zNLxzKd2dOsfmaLG6DBqJzEM0eo/2X2v/O1bEDZqQ5uBTiY4r2kktHlwIyC8M
 1bXQhVpae0VptkI6FA4SBt4wny+4eff9FdYJSOkDy46tTEp3zhv13qTTPvM/JIuEBtwe+W/0J
 8sYOrMXBaINzFT6bJ1xdEu8Fk/d3t41eNAlOCvi/Sagx507KK+2Z092896aeVvbEtyoy5z+p0
 VdvZ2lim7fWTcNyj/aGJzh/EM7HmpFfzltx/C5pXWOW4QlOVuIrxicSYdUksZ6lqk/jj/04NY
 zLaRcwCVbD1Z70Et/DeFT4lW8zmAJdVLnxOp+BwNhg8hlscNvHfKxigICLwFNn65Ec+o/7HWk
 OkhBmQaCF6XhslYqjT04AM3R+lKPNzQ9AOkSx5mwz6SokekD2XrnbK0hX0vDf9agskDglZsi2
 p5sv9DcDMyTw28V47LFINirCz1oPQiu+DqdaukuzvefDn1WztdsoaR27Ldhg9quH0enhA3kKK
 XyqUCmWe+DyF5cFcdBR35Fco83Y=
X-Mailman-Approved-At: Fri, 24 Feb 2023 17:12:51 +0000
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
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (amdgpu_acpi_smart_shift_upda=
te(dev, AMDGPU_SS_DEV_D3))
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 DRM_WARN("smart shift update failed\n");
=C2=A0
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_kms_helper_poll_disable(dev);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (adev->mode_info.mode_config_initi=
alized) {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 printk(KERN_INFO "adev-
> mode_info.mode_config_initialized =3D %d\n",
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev-
> mode_info.mode_config_initialized);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 printk(KERN_INFO "dev->mode_config.poll_enabled =3D
%d\n",
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev->mode_config.poll_enabled);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 drm_kms_helper_poll_disable(dev);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (fbcon)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)-
> fb_helper, true);

and found that mode_config_initialized=3D1 but dev-
> mode_config.poll_enabled=3D0 with the usual warning:
[=C2=A0=C2=A0 23.287058] adev->mode_info.mode_config_initialized =3D 1
[=C2=A0=C2=A0 23.287061] dev->mode_config.poll_enabled =3D 0
[=C2=A0=C2=A0 23.287063] ------------[ cut here ]------------
[=C2=A0=C2=A0 23.287064] WARNING: CPU: 0 PID: 16 at kernel/workqueue.c:3167
__flush_work.isra.0+0x261/0x270

The flag that needs to be checked to avoid the warning is dev-
> mode_config.poll_enabled which gets set by drm_kms_helper_poll_init
and drm_kms_helper_poll_fini does just that. Changing the comment of
drms_kms_helper_poll_disable is technically not necessary though.
(resent because this mail didn't appear in the archive of amd-gfx
so I thought it might have been lost)
Bert Karwatzki


