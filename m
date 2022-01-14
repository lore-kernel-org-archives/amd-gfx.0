Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F79C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 14:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F91510EB3C;
	Fri, 14 Jan 2022 14:40:16 +0000 (UTC)
X-Greylist: delayed 903 seconds by postgrey-1.36 at gabe;
 Fri, 14 Jan 2022 12:39:43 UTC
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com
 [136.143.188.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A178E10E205
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 12:39:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1642163076; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eSV+x6aTZvIEVmiQdICjP8xwHx5ZcvEw7dDQwMKB9OL2YBBZhGxfzYVzzGB5++NOHYzbswueZC/6lu1x1+a926yoFE8FFLhIsS1coUKopT9+zOXSUpC1nglBUbPSfK9z/85M1/cHMqPK4A8RdQzG1MeTViVvQY1qjW+oMsx5eRE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1642163076;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=bVcv3AMbPXq1GB6rsRAc8R3cEkg+TkkgW5xVWu8/NuI=; 
 b=NJ1zVhv45O+sxyzBBhOA0Pm94/uOhTAWxsd16B1B9+L8ZVcug8RjWdXCrfh/4MFQoPrbi6xJPi3cFn91zRyEUCdletqgROUw8bdd9hBlwCaMavsQ+IFOrPduKXHKGgekVDCpKfavNvALlk3IniGE4aUkj7abZ2erqTZN28kUccI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=hixontech.com;
 spf=pass  smtp.mailfrom=linux-kernel-bugs@hixontech.com;
 dmarc=pass header.from=<linux-kernel-bugs@hixontech.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1642163076; 
 s=zoho; d=hixontech.com; i=linux-kernel-bugs@hixontech.com;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=bVcv3AMbPXq1GB6rsRAc8R3cEkg+TkkgW5xVWu8/NuI=;
 b=X8clYn947LcXprViBkQElXk3l9k+K5VmusKDoK9XNc6BlRjlzRC5OtI+xZaNlzjg
 39QlV8eshzSCbKLzs7UVSHvODyKzlOsncP9WYcTzDh7NqXsK4b7pEK3iCPMhx5XSa5Q
 Gp41rs59QNMRzuDVQBw0PVYExOm5fyX5h+DmFLWg=
Received: from droplet5.hixontech.com (droplet5.hixontech.com
 [164.90.159.118]) by mx.zohomail.com
 with SMTPS id 1642163073700685.5295435867972;
 Fri, 14 Jan 2022 04:24:33 -0800 (PST)
Message-ID: <991bfaea-2978-321d-deb8-cefa4572877e@hixontech.com>
Date: Fri, 14 Jan 2022 05:24:30 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v5] drm/amd/display: Revert W/A for hard hangs on
 DCN20/DCN21
Content-Language: en-US
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220107164959.12511-1-mario.limonciello@amd.com>
 <DM4PR12MB51821C74C0F9C8254A8CE048EC4D9@DM4PR12MB5182.namprd12.prod.outlook.com>
 <BL1PR12MB5157D5DC6BE941A1C1294DFDE24D9@BL1PR12MB5157.namprd12.prod.outlook.com>
From: Chris Hixon <linux-kernel-bugs@hixontech.com>
In-Reply-To: <BL1PR12MB5157D5DC6BE941A1C1294DFDE24D9@BL1PR12MB5157.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 14 Jan 2022 14:40:05 +0000
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
Cc: "Zhuo, Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>,
 Scott Bruce <smbruce@gmail.com>, "spasswolf@web.de" <spasswolf@web.de>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/7/22 11:51, Limonciello, Mario wrote:

> [AMD Official Use Only]
>
>
>> I think the revert is fine once we figure out where we're missing call=
s to:
>>
>>          .optimize_pwr_state =3D dcn21_optimize_pwr_state,
>>          .exit_optimized_pwr_state =3D dcn21_exit_optimized_pwr_state,
>>
>> These are already part of dc_link_detect, so I suspect there's another=
 interface
>> in DC that should be using these.
>>
>> I think the best way to debug this is to revert the patch locally and =
add a stack
>> dump when DMCUB hangs our times out.
> OK so I did this on top of amd-staging-drm-next with my v5 patch (this =
revert in place)
>
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/=
gpu/drm/amd/display/dmub/src/dmub_srv.c
> index 9280f2abd973..0bd32f82f3db 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> @@ -789,8 +789,10 @@ enum dmub_status dmub_srv_cmd_with_reply_data(stru=
ct dmub_srv *dmub,
>          // Execute command
>          status =3D dmub_srv_cmd_execute(dmub);
>
> -       if (status !=3D DMUB_STATUS_OK)
> +       if (status !=3D DMUB_STATUS_OK) {
> +               ASSERT(0);
>                  return status;
> +       }
>
>          // Wait for DMUB to process command
>          status =3D dmub_srv_wait_for_idle(dmub, 100000);
>
>> That way you can know where the PHY was trying to be accessed without =
the
>> refclk being on.
>>
>> We had a similar issue in DCN31 which didn't require a W/A like DCN21.
>>
>> I'd like to hold off on merging this until that hang is verified as go=
ne.
>>
> Then I took a RN laptop running DMUB 0x01010019 and disabled eDP, and c=
onfirmed
> no CRTC was configured but plugged in an HDMI cable:
>
> connector[78]: eDP-1
>          crtc=3D(null)
>          self_refresh_aware=3D0
> connector[85]: HDMI-A-1
>          crtc=3Dcrtc-1
>          self_refresh_aware=3D0
>
> I triggered 100 hotplugs like this:
>
> #!/bin/bash
> for i in {0..100..1}
> do
>      echo 1 | tee /sys/kernel/debug/dri/0/HDMI-A-1/trigger_hotplug
>      sleep 3
> done
>
> Unfortunately, no hang or traceback to be seen (and HDMI continues to w=
ork).
> I also manually pulled the plug a handful of times I don't know the spe=
cifics that Lillian had the
> failure though, so this might not be a good enough check.
>
> I'll try to upgrade DMUB to 0x101001c (the latest version) and double c=
heck that as well.

I applied patch v5 and the above ASSERT patch, on top of both Linux=20
5.16-rc8 and 5.16.

Result: no problems with suspend/resume, 16+ cycles.

As far as the hang goes:

I plugged in an HDMI cable connected to my TV, and configured Gnome to=20
use the external display only.

connectors from /sys/kernel/debug/dri/0/state:

connector[78]: eDP-1
 =C2=A0=C2=A0 =C2=A0crtc=3D(null)
 =C2=A0=C2=A0 =C2=A0self_refresh_aware=3D0
connector[85]: HDMI-A-1
 =C2=A0=C2=A0 =C2=A0crtc=3Dcrtc-1
 =C2=A0=C2=A0 =C2=A0self_refresh_aware=3D0
connector[89]: DP-1
 =C2=A0=C2=A0 =C2=A0crtc=3D(null)
 =C2=A0=C2=A0 =C2=A0self_refresh_aware=3D0

I manually unplugged/plugged the HDMI cable 16+ times, and also ran:

$ sudo sh -c 'for ((i=3D0;i<100;i++)); do echo 1 | tee=20
/sys/kernel/debug/dri/0/HDMI-A-1/trigger_hotplug; sleep 3; done'

The system did not hang, and I saw no kernel log output from the ASSERT.

I also tried a USB-C dock with an HDMI port, with the same results,=20
though there are other issues with this (perhaps worthy of other bug=20
reports).

Is there some reason to use amd-staging-drm-next for this test?

I don't use the HDMI connection much and I have never experienced a hang=20
with HDMI in the first place. Can someone send a link to an=20
issue/discussion where this hang is being discussed?

HW: HP ENVY x360 Convertible 15-ds1xxx, AMD Ryzen 7 4700U with Radeon=20
Graphics
OS/Desktop: Arch Linux, Gnome 41.3 (Wayland)
FW: linux-firmware-git 20211229.57d6b95-1, DMUB version=3D0x0101001C





