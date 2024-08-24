Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DF8C5472C
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Aug 2024 08:28:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3110810E099;
	Sat, 24 Aug 2024 08:28:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ljones.dev header.i=@ljones.dev header.b="cvWr6EAC";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="c3IwsTdE";
	dkim-atps=neutral
X-Greylist: delayed 517 seconds by postgrey-1.36 at gabe;
 Sat, 24 Aug 2024 02:31:26 UTC
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com
 [103.168.172.145])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC96110E18A
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Aug 2024 02:31:26 +0000 (UTC)
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal
 [10.202.2.43])
 by mailfout.nyi.internal (Postfix) with ESMTP id 939A1138CCB5;
 Fri, 23 Aug 2024 22:22:48 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
 by phl-compute-03.internal (MEProxy); Fri, 23 Aug 2024 22:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1724466168;
 x=1724552568; bh=JSo44rT3ToEjkoxNCHxzXk9Auyqfa7DnNHlvGrQLZpw=; b=
 cvWr6EACDcHZwezWVl+cmzy9K9kmYxFSuvhf5IzMFJHNI0XN7J3D4s2aOtyPSigz
 rZviJ0FrBZmnO6CVJ39MJd1jimxG8Jtu8X1uyg0p/Ce0c25EWAstR/9YAZRKaEE8
 IQt/wbQe3JN7OKQd3TwFb78BlLNi7xhcwwWuIcpbp/XU/CHOCqEEQ7YEp9ZWhBVt
 5DVnRjqEPhgfmaTwXoFKIEpS0LNoZgNEn2TQbx6DidgeDlCxj1GvaFciXcT5uuAG
 ENgdxiqRv66eIa+OAOnXSl5VuL7BPr5JXUFfRsQt6laUu8oMQMHGVRRJINEMmDlW
 d2CgDetc0+ypaASx+9vkBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724466168; x=
 1724552568; bh=JSo44rT3ToEjkoxNCHxzXk9Auyqfa7DnNHlvGrQLZpw=; b=c
 3IwsTdExMGM4VdkeXwGGqDqAuakNGmRH0NoH+zQQw0V/F6LtJMIG9/lwxgk3iB3p
 gkp0lRlUDoZpCqNXTsX1oi9M46ApRgfrc7v2u/gaz13DKmJU0BU4le2315TkIIYd
 dgSG4gx8xUJbv5LatlQwuw6v/was6HagAM1/hD0b+x9Xu8qFC+gBtRx6YCDaBsxW
 g1wcg9YOk8bkeuuSjpRdsxTmeNJ3Bck3qXkTWKU9IUCP7zKO4RGA1630VFh+o/lP
 LFSIXCwjFvEViL5j5twgzXsaHMF4hfC2JI5+P1SWpYEV3zhLqCfxWXuZe4BtuFcW
 nBTPN0Ncy8xM02VOV+jEQ==
X-ME-Sender: <xms:-EPJZk4qUxpmV8Q0rIBcZcZukeRYdpupqsS2poZBDksGZiYBpL1KJw>
 <xme:-EPJZl4zSdnLta5X6esvfeqapVYhJbCi47hUTC-jdK2KD_qNHX7Abdopq4L6fAuRb
 NV7Y-OoRx-uS80z_Pk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvfedgheejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
 necuhfhrohhmpedfnfhukhgvucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvg
 hvqeenucggtffrrghtthgvrhhnpeeihfefkefgtdefhfffheeuleeuieffgfevhedttdet
 jedtfeehfeeufeeftdeukeenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluh
 hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhho
 nhgvshdruggvvhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtg
 hpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtphht
 thhopegrlhgvgiguvghutghhvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhuph
 gvrhhmudeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghmugdqghhfgieslhhishht
 shdrfhhrvggvuggvshhkthhophdrohhrgh
X-ME-Proxy: <xmx:-EPJZjerWR4MQLb_jgFjI0ZRWGEl1YVRBaM-3wUfzgw3Kf6m_uhvNQ>
 <xmx:-EPJZpK8mEmDOftf8-IjW_ls66V1_o1t4lGKCUgz7ghq6T6f-LV5Zw>
 <xmx:-EPJZoI6Tz7aUauj6Qo0jN0RCTjOeF1h76OviT5uoj1q7lMKbTn3Gg>
 <xmx:-EPJZqxRC-OK9xAvi26soHgOCpO0YR1S60OjYA1x0inyfRH6IOVPZg>
 <xmx:-EPJZvVVIi3L40j5Vz9iIt90zwoMD7XMe_gf9NZI0G0SCqe6osj9AVMF>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 228DB3360073; Fri, 23 Aug 2024 22:22:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Sat, 24 Aug 2024 14:22:27 +1200
From: "Luke Jones" <luke@ljones.dev>
To: "Mario Limonciello" <mario.limonciello@amd.com>,
 "Alex Deucher" <alexdeucher@gmail.com>
Cc: "Mario Limonciello" <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Message-Id: <da2860c4-df08-49d8-b730-68691520f7ec@app.fastmail.com>
In-Reply-To: <9efbc3a1-c43b-4f8a-a334-6ff77e6de283@amd.com>
References: <20240820020435.472490-1-superm1@kernel.org>
 <CADnq5_O3uTj_Zu9+iY_k8i2MQhXH=Ac2+GhCe5DeW=CWY6jn4w@mail.gmail.com>
 <0e8d0a26-3dca-4669-96fc-d9f4bffbe5f6@amd.com>
 <CADnq5_OL=W_Uz9LCeoYAEZ=XX=1tu0=Hky=pjLmfz0x8vWUT-g@mail.gmail.com>
 <9efbc3a1-c43b-4f8a-a334-6ff77e6de283@amd.com>
Subject: Re: [PATCH] drm/amd: Don't wake dGPUs while reading sensors
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 24 Aug 2024 08:28:43 +0000
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

On Sat, 24 Aug 2024, at 2:39 AM, Mario Limonciello wrote:
> On 8/23/2024 09:31, Alex Deucher wrote:
> > On Fri, Aug 23, 2024 at 10:13=E2=80=AFAM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> On 8/23/2024 09:09, Alex Deucher wrote:
> >>> On Mon, Aug 19, 2024 at 10:30=E2=80=AFPM Mario Limonciello <superm=
1@kernel.org> wrote:
> >>>>
> >>>> From: Mario Limonciello <mario.limonciello@amd.com>
> >>>>
> >>>> If the dGPU is off, then reading the sysfs files with a sensor mo=
nitoring
> >>>> application will wake it. Change the behavior to return an error =
when the
> >>>> dGPU is in D3cold.
> >>>
> >>> I'm a little concerned that this will generate a flurry of bug rep=
orts
> >>> if this now reports an error.  One more comment below.
> >>>
> >>
> >> Do you have a particular app you're worried about, or just a general
> >> worry?  I've had a lot of people reach out to me complaining about
> >> battery life on A+A systems, and it comes down to the use of sensor
> >> monitoring software waking the dGPU which people don't seem to expe=
ct.
> >=20
> > Nothing in particular.  Just expecting reports of "I checked my GPU
> > temperature and it returned an error.  It was working with the last
> > kernel."
> >=20
> >>
> >> I did double check that software like 'sensors', 'mission center' a=
nd
> >> 'nvtop' don't freak out from this change.
> >=20
> > Do we know what other devices do? =20
>=20
> I'm not sure.  Let me CC Luke Jones, he might know.

These apps have been actively working around or finding good ways to avo=
id waking the dGPU. In some cases the dGPU monitoring widget is disabled=
 until the user requests it.

>=20
> > I wonder if it would make more
> > sense to have the userspace tools check the runpm state before trying
> > to access the device.  Of course there are a lot of them and fixing
> > them all is non-trivial...
>=20
> Yes that's another way to go about it.  But I've raised a bug with=20
> mission center folks 8 months ago [1] to tell them to stop querying=20
> dGPUs in runtime PM, and Luke Jones also raised it with them 4 months=20
> earlier [2] but it's still not sorted in their project.
>=20
> [1] https://gitlab.com/mission-center-devs/mission-center/-/issues/143
> [2] https://gitlab.com/mission-center-devs/mission-center/-/issues/30
>=20
> I suspect we'll hit similar road blocks with the dozens of other=20
> softwares that do this.  So that's why I was thinking cut off the=20
> snake's head.

It is a continuous issue. If I had a dollar for every message in my disc=
ord channel asking why the dGPU is not sleeping I'd have a few thousand =
in savings now.

If the only way to prevent this is to return error if in d3cold then I'm=
 110% in agreeance. If apps can't handle that possiblity then it will fo=
rce proper handling and prevent all future issues like this.

Cheers,
Luke.

>=20
> >=20
> > Alex
> >=20
> >>
> >> Here is what 'sensors' shows on my local workstation with this chan=
ge.
> >>
> >> amdgpu-pci-6100
> >> Adapter: PCI adapter
> >> vddgfx:           N/A
> >> ERROR: Can't get value of subfeature fan1_min: Can't read
> >> ERROR: Can't get value of subfeature fan1_max: Can't read
> >> fan1:             N/A  (min =3D    0 RPM, max =3D    0 RPM)
> >> edge:             N/A  (crit =3D +97.0=C2=B0C, hyst =3D -273.1=C2=B0=
C)
> >> ERROR: Can't get value of subfeature power1_cap: Can't read
> >> PPT:              N/A  (cap =3D   0.00 W)
> >>
> >>>>
> >>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>>> ---
> >>>>    drivers/gpu/drm/amd/pm/amdgpu_pm.c | 90 +++++++++++++++-------=
--------
> >>>>    1 file changed, 45 insertions(+), 45 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm=
/amd/pm/amdgpu_pm.c
> >>>> index c11952a4389bc..d6e38466fbb82 100644
> >>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> >>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> >>>> @@ -142,7 +142,7 @@ static ssize_t amdgpu_get_power_dpm_state(str=
uct device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           ret =3D pm_runtime_get_sync(ddev->dev);
> >>>> @@ -173,7 +173,7 @@ static ssize_t amdgpu_set_power_dpm_state(str=
uct device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           if (strncmp("battery", buf, strlen("battery")) =3D=3D 0)
> >>>> @@ -270,7 +270,7 @@ static ssize_t amdgpu_get_power_dpm_force_per=
formance_level(struct device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           ret =3D pm_runtime_get_sync(ddev->dev);
> >>>> @@ -309,7 +309,7 @@ static ssize_t amdgpu_set_power_dpm_force_per=
formance_level(struct device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           if (strncmp("low", buf, strlen("low")) =3D=3D 0) {
> >>>> @@ -371,7 +371,7 @@ static ssize_t amdgpu_get_pp_num_states(struc=
t device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           ret =3D pm_runtime_get_sync(ddev->dev);
> >>>> @@ -409,7 +409,7 @@ static ssize_t amdgpu_get_pp_cur_state(struct=
 device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           ret =3D pm_runtime_get_sync(ddev->dev);
> >>>> @@ -448,7 +448,7 @@ static ssize_t amdgpu_get_pp_force_state(stru=
ct device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           if (adev->pm.pp_force_state_enabled)
> >>>> @@ -471,7 +471,7 @@ static ssize_t amdgpu_set_pp_force_state(stru=
ct device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           adev->pm.pp_force_state_enabled =3D false;
> >>>> @@ -541,7 +541,7 @@ static ssize_t amdgpu_get_pp_table(struct dev=
ice *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           ret =3D pm_runtime_get_sync(ddev->dev);
> >>>> @@ -577,7 +577,7 @@ static ssize_t amdgpu_set_pp_table(struct dev=
ice *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           ret =3D pm_runtime_get_sync(ddev->dev);
> >>>> @@ -760,7 +760,7 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(s=
truct device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           if (count > 127 || count =3D=3D 0)
> >>>> @@ -862,7 +862,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(s=
truct device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           ret =3D pm_runtime_get_sync(ddev->dev);
> >>>> @@ -922,7 +922,7 @@ static ssize_t amdgpu_set_pp_features(struct =
device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           ret =3D kstrtou64(buf, 0, &featuremask);
> >>>> @@ -957,7 +957,7 @@ static ssize_t amdgpu_get_pp_features(struct =
device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           ret =3D pm_runtime_get_sync(ddev->dev);
> >>>> @@ -1026,7 +1026,7 @@ static ssize_t amdgpu_get_pp_dpm_clock(stru=
ct device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           ret =3D pm_runtime_get_sync(ddev->dev);
> >>>> @@ -1095,7 +1095,7 @@ static ssize_t amdgpu_set_pp_dpm_clock(stru=
ct device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           ret =3D amdgpu_read_mask(buf, count, &mask);
> >>>> @@ -1280,7 +1280,7 @@ static ssize_t amdgpu_get_pp_sclk_od(struct=
 device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           ret =3D pm_runtime_get_sync(ddev->dev);
> >>>> @@ -1309,7 +1309,7 @@ static ssize_t amdgpu_set_pp_sclk_od(struct=
 device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           ret =3D kstrtol(buf, 0, &value);
> >>>> @@ -1342,7 +1342,7 @@ static ssize_t amdgpu_get_pp_mclk_od(struct=
 device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           ret =3D pm_runtime_get_sync(ddev->dev);
> >>>> @@ -1371,7 +1371,7 @@ static ssize_t amdgpu_set_pp_mclk_od(struct=
 device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           ret =3D kstrtol(buf, 0, &value);
> >>>> @@ -1424,7 +1424,7 @@ static ssize_t amdgpu_get_pp_power_profile_=
mode(struct device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           ret =3D pm_runtime_get_sync(ddev->dev);
> >>>> @@ -1463,7 +1463,7 @@ static ssize_t amdgpu_set_pp_power_profile_=
mode(struct device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           tmp[0] =3D *(buf);
> >>>> @@ -1517,7 +1517,7 @@ static int amdgpu_hwmon_get_sensor_generic(=
struct amdgpu_device *adev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> >>>> @@ -1630,7 +1630,7 @@ static ssize_t amdgpu_get_pcie_bw(struct de=
vice *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           if (adev->flags & AMD_IS_APU)
> >>>> @@ -1673,7 +1673,7 @@ static ssize_t amdgpu_get_unique_id(struct =
device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           if (adev->unique_id)
> >>>> @@ -1846,7 +1846,7 @@ static ssize_t amdgpu_get_pm_metrics(struct=
 device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           ret =3D pm_runtime_get_sync(ddev->dev);
> >>>> @@ -1887,7 +1887,7 @@ static ssize_t amdgpu_get_gpu_metrics(struc=
t device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           ret =3D pm_runtime_get_sync(ddev->dev);
> >>>> @@ -2005,7 +2005,7 @@ static ssize_t amdgpu_set_smartshift_bias(s=
truct device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           r =3D pm_runtime_get_sync(ddev->dev);
> >>>> @@ -2227,7 +2227,7 @@ static ssize_t amdgpu_get_xgmi_plpd_policy(=
struct device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           mode =3D amdgpu_dpm_get_xgmi_plpd_mode(adev, &mode_desc=
);
> >>>> @@ -2250,7 +2250,7 @@ static ssize_t amdgpu_set_xgmi_plpd_policy(=
struct device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           ret =3D kstrtos32(buf, 0, &mode);
> >>>> @@ -2652,7 +2652,7 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable=
(struct device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           ret =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> >>>> @@ -2684,7 +2684,7 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable=
(struct device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           err =3D kstrtoint(buf, 10, &value);
> >>>> @@ -2742,7 +2742,7 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct=
 device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           err =3D kstrtou32(buf, 10, &value);
> >>>> @@ -2787,7 +2787,7 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct=
 device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           err =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> >>>> @@ -2817,7 +2817,7 @@ static ssize_t amdgpu_hwmon_get_fan1_input(=
struct device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           err =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> >>>> @@ -2881,7 +2881,7 @@ static ssize_t amdgpu_hwmon_get_fan1_target=
(struct device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           err =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> >>>> @@ -2912,7 +2912,7 @@ static ssize_t amdgpu_hwmon_set_fan1_target=
(struct device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           err =3D kstrtou32(buf, 10, &value);
> >>>> @@ -2956,7 +2956,7 @@ static ssize_t amdgpu_hwmon_get_fan1_enable=
(struct device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           ret =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> >>>> @@ -2988,7 +2988,7 @@ static ssize_t amdgpu_hwmon_set_fan1_enable=
(struct device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           err =3D kstrtoint(buf, 10, &value);
> >>>> @@ -3128,7 +3128,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_=
generic(struct device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> >>>> @@ -3209,7 +3209,7 @@ static ssize_t amdgpu_hwmon_set_power_cap(s=
truct device *dev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           if (amdgpu_sriov_vf(adev))
> >>>> @@ -3663,7 +3663,7 @@ static int amdgpu_retrieve_od_settings(stru=
ct amdgpu_device *adev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           ret =3D pm_runtime_get_sync(adev->dev);
> >>>> @@ -3747,7 +3747,7 @@ amdgpu_distribute_custom_od_settings(struct=
 amdgpu_device *adev,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           ret =3D parse_input_od_command_lines(in_buf,
> >>>> @@ -4626,7 +4626,7 @@ static int amdgpu_debugfs_pm_info_show(stru=
ct seq_file *m, void *unused)
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>
> >>> I'd prefer to keep the current behavior for debugfs.
> >>
> >> OK.  I'll exclude it for debugfs in the next spin.
> >>
> >>>
> >>> Alex
> >>>
> >>>>
> >>>>           r =3D pm_runtime_get_sync(dev->dev);
> >>>> @@ -4671,7 +4671,7 @@ static ssize_t amdgpu_pm_prv_buffer_read(st=
ruct file *f, char __user *buf,
> >>>>
> >>>>           if (amdgpu_in_reset(adev))
> >>>>                   return -EPERM;
> >>>> -       if (adev->in_suspend && !adev->in_runpm)
> >>>> +       if (adev->in_suspend || adev->in_runpm)
> >>>>                   return -EPERM;
> >>>>
> >>>>           ret =3D amdgpu_dpm_get_smu_prv_buf_details(adev, &smu_p=
rv_buf, &smu_prv_buf_size);
> >>>> --
> >>>> 2.43.0
> >>>>
> >>
>=20
>=20
