Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D929CD98CF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 15:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 452F910E4FC;
	Mon, 15 Jun 2026 15:25:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F51EFtw/";
	dkim-atps=neutral
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com
 [209.85.221.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C1B410E4FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 15:25:56 +0000 (UTC)
Received: by mail-vk1-f169.google.com with SMTP id
 71dfb90a1353d-59ebd0d4e32so159164e0c.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 08:25:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781537155; cv=none;
 d=google.com; s=arc-20240605;
 b=lNStLsCeVdIoGr+QvCKJQnK9VpZ67+kqCB84ADo4vEEk7WW0z/aVffSDy8EAdVZLyb
 3IkeFgxanzlrxDCke0faebsz3Yn/AGkyZHbLfJMGyms1F+jH0/zeYDkkDAj6L287a0kh
 s4+2TghHSxddRR2DdJZ8+jYFWERvILR2JOrLjaL6UfI9oBvw1bJM02z7Sd9HFnPqC+3w
 S70goffp7foUZe/wjHrWIAy5k/yJrALUpnR/UQb3nx620Kmne+qjzUSbhAPjIXFHOBUp
 RIxeGwGWHMvg+XsJbv9LXLG8KxEPiE5sUEYwuDX4TYg1ADPiaRQTTUCcS0rOT6/5Sclp
 +WIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hBmSsoZHNwu5BvNqqVEX1XMqYJMuw9mZvKy5fZDQCBw=;
 fh=ILWOVQpc3QRsP5ZutY92RlgjpQ0JvFEsZXxZzBVfG7A=;
 b=VuAQ2MIfSC9bMD6H7c3qJdahe2JVt17zQqs070c0VPindyOx2tfTIuxY9v7vMmbhnW
 vuEX8O+XwLP+/mQrr7HBKv2G4U7J2kUSjIoNWfbdecufggqdzeQpjevz6P5snquCTm2O
 zfaoKxG7uHmW0nan0p81J/pkT6B4NWSX10gSvls1UMuyoCpr/3YahHzbVfrOm/rjdfQk
 W0lcHSQK/6/Q5pSR8MSHeehWp43rksXsFKjg2bpSZbiadIVJL8CzNhIb1/o6tzM5DK0n
 HlOd1Y7JwsG3B/NgR1ofKwbBN0ScSuP2FDvZ1JHjLTO1pX9pDt93SQMUNUPPUrbXMtyn
 lEdw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781537155; x=1782141955; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hBmSsoZHNwu5BvNqqVEX1XMqYJMuw9mZvKy5fZDQCBw=;
 b=F51EFtw/kd9bfHxrLk4tJ/ntSV2eIrVbf8cycAD2etXGiYl7KnCpj6E0Ope4n6vsbg
 adn61i3sph7RQ8XyxFBwsJisrtqTMlmYacdibAPfsHFJvgfXtVXhGQIi8MM+7NenAW80
 9HCvKy3k5YydZskDNuExXENUbfGUnsjNpZxvMRF1NJnE5OUTAWcvvIBKvknZ/8Qv9zvV
 4VtKUZn8xg8/bcxuSdzzBUyJQ+q0cymbkqjkGfUPZp23ZP2E3R7iAsNYVaQa9buxg8ow
 LPVYA2uFLsHDjBeCbeSTUfjjS2twmARctR74uTWYxTHE2dXz/2pOLV+KYUfaPMEhRzeI
 YV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781537155; x=1782141955;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hBmSsoZHNwu5BvNqqVEX1XMqYJMuw9mZvKy5fZDQCBw=;
 b=YUV2+OmLoG5qyqRpOIQsedSranoAADj0ue3EQhCyjTkpWQXtSiAGSV6WavHzVV15oc
 ETWp67PIWhN8ZP8YXT4sJdq3/xRmf/sUiEv2fd9ssXaLyftmGcDTzz15/feOxx3hc/2e
 cyL+dU4UMolARHmGMZi4XXj/VolFXTFAP0mJZAbzZGVYbr0MLzjW417/GHij8sfi8rfS
 4ZPmIO9+YGWvU76+JPNT0RmHnf+gKlzy6fHkaej5lcdQ4hPnRv/LqA/x3f92cOSo9ikH
 KD7RoSDJwI8Ab5ySkB2E+6QK8nWs6eJ9gIt4lL8Xg5s52+26xam9e3k5SXZ3jKKScP7h
 M/OQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ91Q9FcJcQDgTNBjHbpDJVpHss+d7rXREENOkBdnq8pYqhmAsA2r0cSCa1ogxAIIk8CPtpJi3CH@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxqbcIng7p9VdXRnf9SYgCoWh4oqQ1AoaRlYCGhkCL4ZxNUtUl9
 l5pU2WoqesWHi5dESdFMErwZR4dDF3Jhk8I9PYsEeScdTY/iOE4k8PGRK8kFUoybsCefoLnbRuF
 eS0OBsae77z5sEPuZ44lnqjs6Ql231mg=
X-Gm-Gg: Acq92OFiI1N+bp7Urd3jybryqnj7Md7VNaikQK0Hs50EUlEcRbYHXPlFnTekXovwz4P
 oQJGLvTrO6vb+FWIRB5hSwC3G0ysNaSNq4kJu51/ZvRx4MphOb+FLmihMCg+misjtGGiHvrDTdy
 r3f8u1c+v3ZO1es/GObnI2UB+aM14swhl3cIWHsYY35eJe0h8wx4Ty0+0xecU5vKNb/Aeh9J+fd
 qhoOz98Zk+crdGaVGZuciJxXFXty22AQ+KK8QyP1zW0+yal0/8lyy9d65FauqArMnvkoud8C63E
 eJcNZXMJzo/1HdH++CnEux6aN3dFInP52auy8FIPKHURecZhGU1UZmpnbXTeYl6fKgVf1g==
X-Received: by 2002:a05:6122:130f:b0:598:841f:f2f8 with SMTP id
 71dfb90a1353d-5bb6c180c66mr2472173e0c.3.1781537155071; Mon, 15 Jun 2026
 08:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260609065123.215816-1-kevinyang.wang@amd.com>
 <6cb5a3be-8cf1-4ce5-8ce9-a6fb363b12fa@amd.com>
 <DM6PR12MB29726384D65C1D1B41A04415821D2@DM6PR12MB2972.namprd12.prod.outlook.com>
 <e3c720a6-497d-43aa-bf7a-0835fc0d799a@amd.com>
 <DM6PR12MB2972ECD8FDD8874557E8EFE3821D2@DM6PR12MB2972.namprd12.prod.outlook.com>
 <09795f1b-43c9-4aac-a652-01bff8b98d81@amd.com>
In-Reply-To: <09795f1b-43c9-4aac-a652-01bff8b98d81@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Jun 2026 11:25:42 -0400
X-Gm-Features: AVVi8CeQN3qKJ7nxKguCkaoRuBKRvjgJ8FTNiZQHASDrxmxeLOVrSgyFpRCE-Rc
Message-ID: <CADnq5_OtH8En_WG3kdeiWYXGtUaL8+xwQMEFYY__xTGevLvR+g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: refactor DPM clock level reporting
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, 
 "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Liu,
 Shuzhou (Bill)" <Shuzhou.Liu@amd.com>, 
 "Arif, Maisam" <Maisam.Arif@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jun 9, 2026 at 8:20=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wro=
te:
>
>
>
> On 09-Jun-26 5:35 PM, Wang, Yang(Kevin) wrote:
> > AMD General
> >
> >> -----Original Message-----
> >> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> >> Sent: Tuesday, June 9, 2026 7:12 PM
> >> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
> >> gfx@lists.freedesktop.org
> >> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
> >> <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>;
> >> Liu, Shuzhou (Bill) <Shuzhou.Liu@amd.com>; Arif, Maisam
> >> <Maisam.Arif@amd.com>
> >> Subject: Re: [PATCH] drm/amd/pm: refactor DPM clock level reporting
> >>
> >>
> >>
> >> On 09-Jun-26 3:49 PM, Wang, Yang(Kevin) wrote:
> >>> AMD General
> >>>
> >>>> -----Original Message-----
> >>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> >>>> Sent: Tuesday, June 9, 2026 4:11 PM
> >>>> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
> >>>> gfx@lists.freedesktop.org
> >>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
> >>>> <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
> >>>> Subject: Re: [PATCH] drm/amd/pm: refactor DPM clock level reporting
> >>>>
> >>>>
> >>>>
> >>>> On 09-Jun-26 12:21 PM, Yang Wang wrote:
> >>>>> Refactor smu_cmn_print_dpm_clk_levels() to build clock entries
> >>>>> before emitting sysfs output.
> >>>>>
> >>>>> For discrete DPM tables, mark the level closest to the reported
> >>>>> current clock. This avoids losing the active '*' marker when the
> >>>>> SMU-reported clock does not fall within the previous fixed toleranc=
e.
> >>>>>
> >>>>> Keep fine-grained output explicit by reporting the current clock on
> >>>>> an 'F' line, and keep deep sleep represented by the 'S' line withou=
t
> >>>>> marking a discrete level.
> >>>>>
> >>>>> Active marker placement:
> >>>>>
> >>>>> | Mode         | '*' marker location       | Reason                =
    |
> >>>>> | ------------ | ------------------------- | ----------------------=
--- |
> >>>>> | discrete     | closest/current DPM level | entries are real level=
s   |
> >>>>> | fine-grained | 'F:' current clock line   | min/max are range boun=
ds  |
> >>>>> | deep sleep   | 'S:' line                 | outside normal DPM ran=
ge  |
> >>>>>
> >>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5295
> >>>>> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> >>>>> ---
> >>>>>     drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 148
> >> +++++++++++++++++--
> >>>> ------
> >>>>>     1 file changed, 101 insertions(+), 47 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> >>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> >>>>> index d365f06ac1ac..872c0328f290 100644
> >>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> >>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> >>>>> @@ -1376,77 +1376,131 @@ void smu_cmn_reset_custom_level(struct
> >>>> smu_context *smu)
> >>>>>       pstate_table->uclk_pstate.custom.max =3D 0;
> >>>>>     }
> >>>>>
> >>>>> -static inline bool smu_cmn_freqs_match(uint32_t freq1, uint32_t
> >>>>> freq2)
> >>>>> +struct smu_clk_print_entry {
> >>>>> +   uint32_t freq;
> >>>>> +   bool selected;
> >>>>> +};
> >>>>> +
> >>>>> +static inline uint32_t smu_cmn_freq_distance(uint32_t freq1,
> >>>>> +uint32_t
> >>>>> +freq2) {
> >>>>> +   return freq1 > freq2 ? freq1 - freq2 : freq2 - freq1; }
> >>>>> +
> >>>>> +static inline uint32_t smu_cmn_get_dpm_level_count(struct
> >>>>> +smu_dpm_table *dpm_table) {
> >>>>> +   return min_t(uint32_t, dpm_table->count,
> >>>> SMU_MAX_DPM_LEVELS); }
> >>>>> +
> >>>>> +static uint32_t smu_cmn_get_closest_clk_level(struct smu_dpm_table
> >>>>> +*dpm_table, uint32_t cur_clk) {
> >>>>> +   uint32_t min_distance, distance;
> >>>>> +   uint32_t closest_level =3D 0;
> >>>>> +   uint32_t count;
> >>>>> +   uint32_t i;
> >>>>> +
> >>>>> +   count =3D smu_cmn_get_dpm_level_count(dpm_table);
> >>>>> +   if (!count)
> >>>>> +           return SMU_MAX_DPM_LEVELS;
> >>>>> +
> >>>>> +   min_distance =3D smu_cmn_freq_distance(cur_clk, dpm_table-
> >>>>> dpm_levels[0].value);
> >>>>> +   for (i =3D 1; i < count; i++) {
> >>>>> +           distance =3D smu_cmn_freq_distance(cur_clk, dpm_table-
> >>>>> dpm_levels[i].value);
> >>>>> +           if (distance < min_distance) {
> >>>>> +                   min_distance =3D distance;
> >>>>> +                   closest_level =3D i;
> >>>>> +           }
> >>>>> +   }
> >>>>> +
> >>>>> +   return closest_level;
> >>>>> +}
> >>>>> +
> >>>>> +static inline int smu_cmn_emit_clk_line(char *buf, int size,
> >>>>> +                                   int level_index, uint32_t freq,
> >>>>> +bool
> >>>> selected) {
> >>>>> +   return sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> >>>>> +                        level_index, freq, selected ? "*" : ""); }
> >>>>> +
> >>>>> +static void smu_cmn_build_fine_grained_levels(uint32_t min_clk,
> >>>>> +uint32_t
> >>>> max_clk,
> >>>>> +                                         struct smu_clk_print_entr=
y
> >>>> *entries,
> >>>>> +                                         uint32_t *entry_count) {
> >>>>> +   *entry_count =3D 2;
> >>>>> +   entries[0].freq =3D min_clk;
> >>>>> +   entries[0].selected =3D false;
> >>>>> +   entries[1].freq =3D max_clk;
> >>>>> +   entries[1].selected =3D false;
> >>>>> +}
> >>>>> +
> >>>>> +static void smu_cmn_build_discrete_levels(struct smu_dpm_table
> >>>> *dpm_table,
> >>>>> +                                     uint32_t selected_level,
> >>>>> +                                     struct smu_clk_print_entry *e=
ntries,
> >>>>> +                                     uint32_t *entry_count) {
> >>>>> +   uint32_t i;
> >>>>> +
> >>>>> +   *entry_count =3D smu_cmn_get_dpm_level_count(dpm_table);
> >>>>> +
> >>>>> +   for (i =3D 0; i < *entry_count; i++) {
> >>>>> +           entries[i].freq =3D dpm_table->dpm_levels[i].value;
> >>>>> +           entries[i].selected =3D (i =3D=3D selected_level);
> >>>>> +   }
> >>>>> +}
> >>>>> +
> >>>>> +static int smu_cmn_emit_clk_prefix(char *buf, int size,
> >>>>> +                              bool is_fine_grained, bool is_deep_s=
leep,
> >>>>> +                              uint32_t cur_clk)
> >>>>>     {
> >>>>> -   /* Frequencies within 25 MHz are considered equal */
> >>>>> -   return (abs((int)freq1 - (int)freq2) <=3D 25);
> >>>>> +   if (is_deep_sleep)
> >>>>> +           size +=3D sysfs_emit_at(buf, size, "S: %uMhz *\n", cur_=
clk);
> >>>>> +   else if (is_fine_grained)
> >>>>> +           size +=3D sysfs_emit_at(buf, size, "F: %uMhz *\n",
> >>>>> + cur_clk);
> >>>>
> >>>> What about keeping the else part as C: <cur_clk> in all cases -
> >>>> instead of just fine grained? * indicates the closest level matched
> >>>> and cur_clk will give the exact frequency.
> >>>>
> >>>> Thanks,
> >>>> Lijo
> >>>
> >>> This is a good idea. However, for now I'd like to retain the existing=
 logic to
> >> stay compatible with current parsing tools and prevent potential regre=
ssions.
> >>> Also, note that "F" and "S" are optional labels, which are only shown=
 for
> >> unmatched DPM LEVEL entries.
> >>>
> >>
> >> +Bill/Maisam
> >>
> >> What about the case when current clock matches min/max in fine grained
> >> scenario? In the new logic, F is the label for current clock always fo=
r fine
> >> grained clocks which is a deviation from the old logic. Is that to alw=
ays show 3
> >> levels in fine grained?
> >>
> >> Thanks,
> >> Lijo
> >
> >>> Is that to always show 3 levels in fine grained?
> > yes, this part indeed works differently from the prior logic.
> >
> > The major problem with the current fine-grained implementation is that =
when the current clock does not hit min/max, the current clock is shown cur=
rent clock at position "1" (total 3 lines output)
> > This tends to confuse users, who may wonder whether to use position 1 o=
r 2 to set the maximum value, but 1 is expected value by driver.
> > Therefore, this is one of the issues addressed by this patch.
> >
> > Back to your question: Either adopting a fixed 3-level display or retai=
ning the old logic is reasonable ( which one is your prefer ?)
> > The label "F" stands for both fine-grained and frequency.
> >
>
> I prefer the new approach to separate out current clock from the levels.
>
> For ex: user space sees F label, uses the value as current clock. Rest
> of them used for level information. If it doesn't see F, try to parse
> the legacy way.
>
> Alex, do you have any comments?

I was never crazy about having the value in the middle be outside of
the min/max, but IIRC, it was done that way for compatibility.
Whatever is the least disruptive for existing tools.

Alex

>
> As a minimal representation of user space -
>         Bill/Arif, is it possible to have this changed in amd-smi?
>
> Thanks,
> Lijo
>
> > Best Regards,
> > Kevin
> >>
> >>> Best Regards,
> >>> Kevin
> >>>>
> >>>>> +
> >>>>> +   return size;
> >>>>>     }
> >>>>>
> >>>>>     int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
> >>>>>                                struct smu_dpm_table *dpm_table,
> >>>>>                                uint32_t cur_clk, char *buf, int *of=
fset)
> >>>>>     {
> >>>>> -   uint32_t min_clk, max_clk, level_index, count;
> >>>>> -   uint32_t freq_values[3];
> >>>>> -   int size, lvl, i;
> >>>>> +   struct smu_clk_print_entry entries[SMU_MAX_DPM_LEVELS];
> >>>>> +   uint32_t min_clk, max_clk, count, entry_count =3D 0;
> >>>>> +   uint32_t selected_level =3D SMU_MAX_DPM_LEVELS;
> >>>>> +   int size, i;
> >>>>>       bool is_fine_grained;
> >>>>>       bool is_deep_sleep;
> >>>>> -   bool freq_match;
> >>>>>
> >>>>>       if (!dpm_table || !buf)
> >>>>>               return -EINVAL;
> >>>>>
> >>>>> -   level_index =3D 0;
> >>>>>       size =3D *offset;
> >>>>> -   count =3D dpm_table->count;
> >>>>>       is_fine_grained =3D dpm_table->flags &
> >>>> SMU_DPM_TABLE_FINE_GRAINED;
> >>>>> -   min_clk =3D SMU_DPM_TABLE_MIN(dpm_table);
> >>>>> -   max_clk =3D SMU_DPM_TABLE_MAX(dpm_table);
> >>>>> +   count =3D smu_cmn_get_dpm_level_count(dpm_table);
> >>>>> +   min_clk =3D count ? dpm_table->dpm_levels[0].value : 0;
> >>>>> +   max_clk =3D count ? dpm_table->dpm_levels[count - 1].value : 0;
> >>>>>
> >>>>>       /* Deep sleep - current clock < min_clock/2, TBD: cur_clk =3D=
 0
> >>>>> as
> >>>> GFXOFF */
> >>>>>       is_deep_sleep =3D cur_clk < min_clk / 2;
> >>>>> -   if (is_deep_sleep) {
> >>>>> -           size +=3D sysfs_emit_at(buf, size, "S: %uMhz *\n", cur_=
clk);
> >>>>> -           level_index =3D 1;
> >>>>> -   }
> >>>>>
> >>>>>       if (!is_fine_grained || count =3D=3D 1) {
> >>>>> -           for (i =3D 0; i < count; i++) {
> >>>>> -                   freq_match =3D !is_deep_sleep &&
> >>>>> -                                smu_cmn_freqs_match(
> >>>>> -                                        cur_clk,
> >>>>> -                                        dpm_table->dpm_levels[i].v=
alue);
> >>>>> -                   size +=3D sysfs_emit_at(buf, size, "%d: %uMhz %=
s\n",
> >>>>> -                                         level_index + i,
> >>>>> -                                         dpm_table->dpm_levels[i].=
value,
> >>>>> -                                         freq_match ? "*" : "");
> >>>>> +           if (!is_deep_sleep) {
> >>>>> +                   selected_level =3D
> >>>>> +                           smu_cmn_get_closest_clk_level(dpm_table=
,
> >>>> cur_clk);
> >>>>>               }
> >>>>> +           smu_cmn_build_discrete_levels(dpm_table, selected_level=
,
> >>>>> +                                                 entries,
> >>>>> + &entry_count);
> >>>>>       } else {
> >>>>> -           count =3D 2;
> >>>>> -           freq_values[0] =3D min_clk;
> >>>>> -           freq_values[1] =3D max_clk;
> >>>>> +           smu_cmn_build_fine_grained_levels(min_clk, max_clk,
> >>>>> +                                             entries, &entry_count=
);
> >>>>> +   }
> >>>>>
> >>>>> -           if (!is_deep_sleep) {
> >>>>> -                   if (smu_cmn_freqs_match(cur_clk, min_clk)) {
> >>>>> -                           lvl =3D 0;
> >>>>> -                   } else if (smu_cmn_freqs_match(cur_clk, max_clk=
)) {
> >>>>> -                           lvl =3D 1;
> >>>>> -                   } else {
> >>>>> -                           /* NOTE: use index '1' to show current =
clock
> >>>> value */
> >>>>> -                           lvl =3D 1;
> >>>>> -                           count =3D 3;
> >>>>> -                           freq_values[1] =3D cur_clk;
> >>>>> -                           freq_values[2] =3D max_clk;
> >>>>> -                   }
> >>>>> -           }
> >>>>> +   size =3D smu_cmn_emit_clk_prefix(buf, size, is_fine_grained,
> >>>>> +                                  is_deep_sleep, cur_clk);
> >>>>>
> >>>>> -           for (i =3D 0; i < count; i++) {
> >>>>> -                   size +=3D sysfs_emit_at(
> >>>>> -                           buf, size, "%d: %uMhz %s\n", level_inde=
x + i,
> >>>>> -                           freq_values[i],
> >>>>> -                           (!is_deep_sleep && i =3D=3D lvl) ? "*" =
: "");
> >>>>> -           }
> >>>>> -   }
> >>>>> +   for (i =3D 0; i < entry_count; i++)
> >>>>> +           size +=3D smu_cmn_emit_clk_line(buf, size, i,
> >>>>> +                                        entries[i].freq,
> >>>>> +                                        entries[i].selected);
> >>>>>
> >>>>>       *offset =3D size;
> >>>>>
> >>>
> >
>
