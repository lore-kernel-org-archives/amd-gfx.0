Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB615CD98ED
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 19:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32DDC10EE5B;
	Thu, 18 Jun 2026 19:20:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l/8pYz8O";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FF8610EE5B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 19:20:50 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-1365eb2a773so86745c88.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 12:20:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781810449; cv=none;
 d=google.com; s=arc-20240605;
 b=MrAnfvvvqNfj50AEkkBRBXEGyZ4BLgCc7+2Xl9p0ggZgqz513XDUxa4sIWnJMmTIvV
 6pPQ9i+zG1jUxbJnrWz4GyIzsdcG5uRq3hbku0BVL0JygSUKsRMWSPMHqSbTgflwUYB5
 vnw2seisaSiJXScockWaLzR1RWiU7RvriytJdCTF2LJTxW4cc/ka/GWzX1nj43dk1xvA
 LCptLnXVmId9cfSzyrfZKDqF2OcHqIOC8Ag8GDfjgRAWCHdHgVralzif9zo9x+UtL5D2
 gr1ZtIY0Eb/SyL9jbDONFP1fn5Ms+nPZ5EPB8Hv4qwdCLl++uegl9lmYLZYdtpxLL0mW
 c4Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YC7hCaQEr2sHNRv45GzFykCX3E6WbTP1WYx9de5lAyY=;
 fh=i6fvHB8CLSl+cuOnkdm7KVfR9yZcrrJ1K4hlLs1eZjA=;
 b=j6F5WZBETt4y1KFydq7+bNgJD6IuVdHVrF1oRmuVU9jIKjIP+B3H+e4+zoAfUwLEbu
 th1QgrtEsIeNeMnj7YKm0W7QGESPZUmWcpZ/b8CtbRWCXzqBrF6cFbF1A/UlOyiKyxxe
 xrQ+ZDy5JzjXRCJUI+crz2uO0Mg/ZzAt0KEhUAOwWJm++C80DR1XfW+3jrraesctC1v/
 sgkYjRlQBRq9MWDqv0O3W5YvK3KcT98/cRuhyKd7w/EPMIE2ywbmnjDevqW22+cvwYF6
 3zl11Hs4vW6Z/cnWbFOaXJHeVwF/JzAty8gISCe9tpD3svmdM23W880jswUoqZgYB1mQ
 9dpw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781810449; x=1782415249; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YC7hCaQEr2sHNRv45GzFykCX3E6WbTP1WYx9de5lAyY=;
 b=l/8pYz8OXEkMxEIlb05XUL/4KDYqPxm8ZQ6HAPkHQj4s+q1apxRfs711zEaoKN+JA6
 Z6QmpvSqpJUomflON+uW9nmv8WNUlKNU1K5mk+0WBolbUsSj/caTuTz0iMlxR4x+kYo3
 kebdiQep6tUtUSUkJTGp1BtVtrAdRRInSm+7TVUSrFvLZTtjEcpgKHns9dK8IohQkW7M
 P96AcVG65nxBQ62+VDY/lFX+FnICYvdfCOVBAaQMHSD8UQd61oBDJensYdCJ6t4vesVK
 gRwu8YCo8tfUy5muRo7yYZdtdQJE2ADPWMA/jiWlsfpYXIwPNdfLc9JYeN6+x4L48hf6
 G8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781810449; x=1782415249;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YC7hCaQEr2sHNRv45GzFykCX3E6WbTP1WYx9de5lAyY=;
 b=IgUyEwv8QjOOeYsOe6/9D2GVkQSmT56rHwbR+6W6B4WJMKXB6cUY8V4K/1Ehr0Pgj+
 sxAWAZIdcfEzLiwEa9Fhb+It+OOOjZyddh0LDTxOK2vZloxO++6vOdIwOdCwadVEMjBE
 EnRfKwTfdOwqrOb6RIYMKN2arbK+F2HBF7wh8WiurGsueo50neJPJnyeFERVTXznqgl0
 pMzwmQIv6W2GF2OFUotZZ0kJyhzmAs060MZ+bFR9mUBPLtiUlPfKJzD5MRiR2NauY7LW
 I56rB+0ddM2ih5ZseZYnOTpMedYbQEmxhuJn5ZLC0EFd3q1WUQ1SVXiRChJX6VoBwtOo
 aRQg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VAddMFCy521m8vsvxoom2t9yvdBQID+wYraCwkIFzDUwIl8HGOmsLrrMoCOXyvn+O3c2BmEYx@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwP9z3RBQbjEl2B8I0+jqDSwwVz8ogBdMzRGmwkyRDnv3v8x/p5
 lhzoe+g0ooFDNZdTPBJBZMdjC8W0Udjt6A+zysr6q5S75jWP1G5bqzaidUaR+WLzwosB1JsSNBJ
 qYwD5veEz629M79TlFJfp6B5/AJRCCLE=
X-Gm-Gg: AfdE7ckndUs9+4bPk3szLLLb30efAn3RMFBQwlCb8LmtlCCcgyW6RO34K3FY/5AFmCg
 WKsTgzLRSIgD5r44SziKCommDbESb1zSNz6HGzDaprCVz3wypoEdLw1kQO01hQ0P9cSoCubV+wv
 RPhNRQkymacBemb+vIE7G8DDOD8Mo5aSpeLcK3J0Fur/29cUrghPw90e5PKIFOTBnFnVogmUHJc
 B4cMV1TWdlEqEdm61T8eiCuVunt1QG86LnEc/70XkpRH7lNDzDHniz73I7UAsZ7qG6vGjvh5idS
 OMzuouKra7/fBWmmk0xsVf6rX/IS1JtbDFwz2KBJrh2a+GCIP+/ETjWDUpWTCXbyPA0h+w==
X-Received: by 2002:a05:7022:41a2:b0:137:e391:1ae2 with SMTP id
 a92af1059eb24-139a2137351mr376806c88.6.1781810449332; Thu, 18 Jun 2026
 12:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260609065123.215816-1-kevinyang.wang@amd.com>
 <6cb5a3be-8cf1-4ce5-8ce9-a6fb363b12fa@amd.com>
 <DM6PR12MB29726384D65C1D1B41A04415821D2@DM6PR12MB2972.namprd12.prod.outlook.com>
 <e3c720a6-497d-43aa-bf7a-0835fc0d799a@amd.com>
 <DM6PR12MB2972ECD8FDD8874557E8EFE3821D2@DM6PR12MB2972.namprd12.prod.outlook.com>
 <09795f1b-43c9-4aac-a652-01bff8b98d81@amd.com>
 <CADnq5_OtH8En_WG3kdeiWYXGtUaL8+xwQMEFYY__xTGevLvR+g@mail.gmail.com>
 <DM6PR12MB29721F2B6EC88D593BB933AE82E32@DM6PR12MB2972.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB29721F2B6EC88D593BB933AE82E32@DM6PR12MB2972.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Jun 2026 15:20:37 -0400
X-Gm-Features: AVVi8CczyG81-6Yr6CxK1ndtZjjuC1_Hef8UWNPk3NXKYeuRKuH5Lm6lOB_IkwM
Message-ID: <CADnq5_PdpDcqqhXb381OEiyjqkSG1jfP6GJwNg5Bv-wRi8TCjQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: refactor DPM clock level reporting
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, 
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

On Thu, Jun 18, 2026 at 9:37=E2=80=AFAM Wang, Yang(Kevin)
<KevinYang.Wang@amd.com> wrote:
>
> AMD General
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Monday, June 15, 2026 11:26 PM
> > To: Lazar, Lijo <Lijo.Lazar@amd.com>
> > Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
> > gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Zhang, Hawking
> > <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>;
> > Liu, Shuzhou (Bill) <Shuzhou.Liu@amd.com>; Arif, Maisam
> > <Maisam.Arif@amd.com>
> > Subject: Re: [PATCH] drm/amd/pm: refactor DPM clock level reporting
> >
> > On Tue, Jun 9, 2026 at 8:20=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com>=
 wrote:
> > >
> > >
> > >
> > > On 09-Jun-26 5:35 PM, Wang, Yang(Kevin) wrote:
> > > > AMD General
> > > >
> > > >> -----Original Message-----
> > > >> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> > > >> Sent: Tuesday, June 9, 2026 7:12 PM
> > > >> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
> > > >> gfx@lists.freedesktop.org
> > > >> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang,
> > Hawking
> > > >> <Hawking.Zhang@amd.com>; Feng, Kenneth
> > <Kenneth.Feng@amd.com>; Liu,
> > > >> Shuzhou (Bill) <Shuzhou.Liu@amd.com>; Arif, Maisam
> > > >> <Maisam.Arif@amd.com>
> > > >> Subject: Re: [PATCH] drm/amd/pm: refactor DPM clock level reportin=
g
> > > >>
> > > >>
> > > >>
> > > >> On 09-Jun-26 3:49 PM, Wang, Yang(Kevin) wrote:
> > > >>> AMD General
> > > >>>
> > > >>>> -----Original Message-----
> > > >>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> > > >>>> Sent: Tuesday, June 9, 2026 4:11 PM
> > > >>>> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
> > > >>>> gfx@lists.freedesktop.org
> > > >>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang,
> > > >>>> Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth
> > > >>>> <Kenneth.Feng@amd.com>
> > > >>>> Subject: Re: [PATCH] drm/amd/pm: refactor DPM clock level
> > > >>>> reporting
> > > >>>>
> > > >>>>
> > > >>>>
> > > >>>> On 09-Jun-26 12:21 PM, Yang Wang wrote:
> > > >>>>> Refactor smu_cmn_print_dpm_clk_levels() to build clock entries
> > > >>>>> before emitting sysfs output.
> > > >>>>>
> > > >>>>> For discrete DPM tables, mark the level closest to the reported
> > > >>>>> current clock. This avoids losing the active '*' marker when th=
e
> > > >>>>> SMU-reported clock does not fall within the previous fixed tole=
rance.
> > > >>>>>
> > > >>>>> Keep fine-grained output explicit by reporting the current cloc=
k
> > > >>>>> on an 'F' line, and keep deep sleep represented by the 'S' line
> > > >>>>> without marking a discrete level.
> > > >>>>>
> > > >>>>> Active marker placement:
> > > >>>>>
> > > >>>>> | Mode         | '*' marker location       | Reason            =
        |
> > > >>>>> | ------------ | ------------------------- | ------------------=
------- |
> > > >>>>> | discrete     | closest/current DPM level | entries are real l=
evels   |
> > > >>>>> | fine-grained | 'F:' current clock line   | min/max are range =
bounds  |
> > > >>>>> | deep sleep   | 'S:' line                 | outside normal DPM=
 range  |
> > > >>>>>
> > > >>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/529=
5
> > > >>>>> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> > > >>>>> ---
> > > >>>>>     drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 148
> > > >> +++++++++++++++++--
> > > >>>> ------
> > > >>>>>     1 file changed, 101 insertions(+), 47 deletions(-)
> > > >>>>>
> > > >>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > > >>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > > >>>>> index d365f06ac1ac..872c0328f290 100644
> > > >>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > > >>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > > >>>>> @@ -1376,77 +1376,131 @@ void
> > smu_cmn_reset_custom_level(struct
> > > >>>> smu_context *smu)
> > > >>>>>       pstate_table->uclk_pstate.custom.max =3D 0;
> > > >>>>>     }
> > > >>>>>
> > > >>>>> -static inline bool smu_cmn_freqs_match(uint32_t freq1, uint32_=
t
> > > >>>>> freq2)
> > > >>>>> +struct smu_clk_print_entry {
> > > >>>>> +   uint32_t freq;
> > > >>>>> +   bool selected;
> > > >>>>> +};
> > > >>>>> +
> > > >>>>> +static inline uint32_t smu_cmn_freq_distance(uint32_t freq1,
> > > >>>>> +uint32_t
> > > >>>>> +freq2) {
> > > >>>>> +   return freq1 > freq2 ? freq1 - freq2 : freq2 - freq1; }
> > > >>>>> +
> > > >>>>> +static inline uint32_t smu_cmn_get_dpm_level_count(struct
> > > >>>>> +smu_dpm_table *dpm_table) {
> > > >>>>> +   return min_t(uint32_t, dpm_table->count,
> > > >>>> SMU_MAX_DPM_LEVELS); }
> > > >>>>> +
> > > >>>>> +static uint32_t smu_cmn_get_closest_clk_level(struct
> > > >>>>> +smu_dpm_table *dpm_table, uint32_t cur_clk) {
> > > >>>>> +   uint32_t min_distance, distance;
> > > >>>>> +   uint32_t closest_level =3D 0;
> > > >>>>> +   uint32_t count;
> > > >>>>> +   uint32_t i;
> > > >>>>> +
> > > >>>>> +   count =3D smu_cmn_get_dpm_level_count(dpm_table);
> > > >>>>> +   if (!count)
> > > >>>>> +           return SMU_MAX_DPM_LEVELS;
> > > >>>>> +
> > > >>>>> +   min_distance =3D smu_cmn_freq_distance(cur_clk, dpm_table-
> > > >>>>> dpm_levels[0].value);
> > > >>>>> +   for (i =3D 1; i < count; i++) {
> > > >>>>> +           distance =3D smu_cmn_freq_distance(cur_clk, dpm_tab=
le-
> > > >>>>> dpm_levels[i].value);
> > > >>>>> +           if (distance < min_distance) {
> > > >>>>> +                   min_distance =3D distance;
> > > >>>>> +                   closest_level =3D i;
> > > >>>>> +           }
> > > >>>>> +   }
> > > >>>>> +
> > > >>>>> +   return closest_level;
> > > >>>>> +}
> > > >>>>> +
> > > >>>>> +static inline int smu_cmn_emit_clk_line(char *buf, int size,
> > > >>>>> +                                   int level_index, uint32_t
> > > >>>>> +freq, bool
> > > >>>> selected) {
> > > >>>>> +   return sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> > > >>>>> +                        level_index, freq, selected ? "*" :
> > > >>>>> + ""); }
> > > >>>>> +
> > > >>>>> +static void smu_cmn_build_fine_grained_levels(uint32_t min_clk=
,
> > > >>>>> +uint32_t
> > > >>>> max_clk,
> > > >>>>> +                                         struct
> > > >>>>> + smu_clk_print_entry
> > > >>>> *entries,
> > > >>>>> +                                         uint32_t *entry_count=
) {
> > > >>>>> +   *entry_count =3D 2;
> > > >>>>> +   entries[0].freq =3D min_clk;
> > > >>>>> +   entries[0].selected =3D false;
> > > >>>>> +   entries[1].freq =3D max_clk;
> > > >>>>> +   entries[1].selected =3D false; }
> > > >>>>> +
> > > >>>>> +static void smu_cmn_build_discrete_levels(struct smu_dpm_table
> > > >>>> *dpm_table,
> > > >>>>> +                                     uint32_t selected_level,
> > > >>>>> +                                     struct smu_clk_print_entr=
y *entries,
> > > >>>>> +                                     uint32_t *entry_count) {
> > > >>>>> +   uint32_t i;
> > > >>>>> +
> > > >>>>> +   *entry_count =3D smu_cmn_get_dpm_level_count(dpm_table);
> > > >>>>> +
> > > >>>>> +   for (i =3D 0; i < *entry_count; i++) {
> > > >>>>> +           entries[i].freq =3D dpm_table->dpm_levels[i].value;
> > > >>>>> +           entries[i].selected =3D (i =3D=3D selected_level);
> > > >>>>> +   }
> > > >>>>> +}
> > > >>>>> +
> > > >>>>> +static int smu_cmn_emit_clk_prefix(char *buf, int size,
> > > >>>>> +                              bool is_fine_grained, bool is_de=
ep_sleep,
> > > >>>>> +                              uint32_t cur_clk)
> > > >>>>>     {
> > > >>>>> -   /* Frequencies within 25 MHz are considered equal */
> > > >>>>> -   return (abs((int)freq1 - (int)freq2) <=3D 25);
> > > >>>>> +   if (is_deep_sleep)
> > > >>>>> +           size +=3D sysfs_emit_at(buf, size, "S: %uMhz *\n", =
cur_clk);
> > > >>>>> +   else if (is_fine_grained)
> > > >>>>> +           size +=3D sysfs_emit_at(buf, size, "F: %uMhz *\n",
> > > >>>>> + cur_clk);
> > > >>>>
> > > >>>> What about keeping the else part as C: <cur_clk> in all cases -
> > > >>>> instead of just fine grained? * indicates the closest level
> > > >>>> matched and cur_clk will give the exact frequency.
> > > >>>>
> > > >>>> Thanks,
> > > >>>> Lijo
> > > >>>
> > > >>> This is a good idea. However, for now I'd like to retain the
> > > >>> existing logic to
> > > >> stay compatible with current parsing tools and prevent potential
> > regressions.
> > > >>> Also, note that "F" and "S" are optional labels, which are only
> > > >>> shown for
> > > >> unmatched DPM LEVEL entries.
> > > >>>
> > > >>
> > > >> +Bill/Maisam
> > > >>
> > > >> What about the case when current clock matches min/max in fine
> > > >> grained scenario? In the new logic, F is the label for current
> > > >> clock always for fine grained clocks which is a deviation from the
> > > >> old logic. Is that to always show 3 levels in fine grained?
> > > >>
> > > >> Thanks,
> > > >> Lijo
> > > >
> > > >>> Is that to always show 3 levels in fine grained?
> > > > yes, this part indeed works differently from the prior logic.
> > > >
> > > > The major problem with the current fine-grained implementation is
> > > > that when the current clock does not hit min/max, the current clock=
 is
> > shown current clock at position "1" (total 3 lines output) This tends t=
o confuse
> > users, who may wonder whether to use position 1 or 2 to set the maximum
> > value, but 1 is expected value by driver.
> > > > Therefore, this is one of the issues addressed by this patch.
> > > >
> > > > Back to your question: Either adopting a fixed 3-level display or
> > > > retaining the old logic is reasonable ( which one is your prefer ?)=
 The label
> > "F" stands for both fine-grained and frequency.
> > > >
> > >
> > > I prefer the new approach to separate out current clock from the leve=
ls.
> > >
> > > For ex: user space sees F label, uses the value as current clock. Res=
t
> > > of them used for level information. If it doesn't see F, try to parse
> > > the legacy way.
> > >
> > > Alex, do you have any comments?
> >
> > I was never crazy about having the value in the middle be outside of th=
e
> > min/max, but IIRC, it was done that way for compatibility.
> > Whatever is the least disruptive for existing tools.
> >
> > Alex
>
> Hi Alex,
>
> What do you think of this approach? We add a new label 'F' to display the=
 current frequency value when fine-grain mode is enabled.
> This patch fixes the below issue related to the new DPM level selection l=
ogic. (always print '*' to avoid this kind of issue)
>
> https://gitlab.freedesktop.org/drm/amd/-/work_items/5295
> https://gitlab.freedesktop.org/drm/amd/-/work_items/5371

Seems reasonable to me.

Thanks!

Alex

>
> Best Regards,
> Kevin
> >
> > >
> > > As a minimal representation of user space -
> > >         Bill/Arif, is it possible to have this changed in amd-smi?
> > >
> > > Thanks,
> > > Lijo
> > >
> > > > Best Regards,
> > > > Kevin
> > > >>
> > > >>> Best Regards,
> > > >>> Kevin
> > > >>>>
> > > >>>>> +
> > > >>>>> +   return size;
> > > >>>>>     }
> > > >>>>>
> > > >>>>>     int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
> > > >>>>>                                struct smu_dpm_table *dpm_table,
> > > >>>>>                                uint32_t cur_clk, char *buf, int=
 *offset)
> > > >>>>>     {
> > > >>>>> -   uint32_t min_clk, max_clk, level_index, count;
> > > >>>>> -   uint32_t freq_values[3];
> > > >>>>> -   int size, lvl, i;
> > > >>>>> +   struct smu_clk_print_entry entries[SMU_MAX_DPM_LEVELS];
> > > >>>>> +   uint32_t min_clk, max_clk, count, entry_count =3D 0;
> > > >>>>> +   uint32_t selected_level =3D SMU_MAX_DPM_LEVELS;
> > > >>>>> +   int size, i;
> > > >>>>>       bool is_fine_grained;
> > > >>>>>       bool is_deep_sleep;
> > > >>>>> -   bool freq_match;
> > > >>>>>
> > > >>>>>       if (!dpm_table || !buf)
> > > >>>>>               return -EINVAL;
> > > >>>>>
> > > >>>>> -   level_index =3D 0;
> > > >>>>>       size =3D *offset;
> > > >>>>> -   count =3D dpm_table->count;
> > > >>>>>       is_fine_grained =3D dpm_table->flags &
> > > >>>> SMU_DPM_TABLE_FINE_GRAINED;
> > > >>>>> -   min_clk =3D SMU_DPM_TABLE_MIN(dpm_table);
> > > >>>>> -   max_clk =3D SMU_DPM_TABLE_MAX(dpm_table);
> > > >>>>> +   count =3D smu_cmn_get_dpm_level_count(dpm_table);
> > > >>>>> +   min_clk =3D count ? dpm_table->dpm_levels[0].value : 0;
> > > >>>>> +   max_clk =3D count ? dpm_table->dpm_levels[count - 1].value =
:
> > > >>>>> + 0;
> > > >>>>>
> > > >>>>>       /* Deep sleep - current clock < min_clock/2, TBD: cur_clk
> > > >>>>> =3D 0 as
> > > >>>> GFXOFF */
> > > >>>>>       is_deep_sleep =3D cur_clk < min_clk / 2;
> > > >>>>> -   if (is_deep_sleep) {
> > > >>>>> -           size +=3D sysfs_emit_at(buf, size, "S: %uMhz *\n", =
cur_clk);
> > > >>>>> -           level_index =3D 1;
> > > >>>>> -   }
> > > >>>>>
> > > >>>>>       if (!is_fine_grained || count =3D=3D 1) {
> > > >>>>> -           for (i =3D 0; i < count; i++) {
> > > >>>>> -                   freq_match =3D !is_deep_sleep &&
> > > >>>>> -                                smu_cmn_freqs_match(
> > > >>>>> -                                        cur_clk,
> > > >>>>> -                                        dpm_table->dpm_levels[=
i].value);
> > > >>>>> -                   size +=3D sysfs_emit_at(buf, size, "%d: %uM=
hz %s\n",
> > > >>>>> -                                         level_index + i,
> > > >>>>> -                                         dpm_table->dpm_levels=
[i].value,
> > > >>>>> -                                         freq_match ? "*" : ""=
);
> > > >>>>> +           if (!is_deep_sleep) {
> > > >>>>> +                   selected_level =3D
> > > >>>>> +
> > > >>>>> + smu_cmn_get_closest_clk_level(dpm_table,
> > > >>>> cur_clk);
> > > >>>>>               }
> > > >>>>> +           smu_cmn_build_discrete_levels(dpm_table, selected_l=
evel,
> > > >>>>> +                                                 entries,
> > > >>>>> + &entry_count);
> > > >>>>>       } else {
> > > >>>>> -           count =3D 2;
> > > >>>>> -           freq_values[0] =3D min_clk;
> > > >>>>> -           freq_values[1] =3D max_clk;
> > > >>>>> +           smu_cmn_build_fine_grained_levels(min_clk, max_clk,
> > > >>>>> +                                             entries, &entry_c=
ount);
> > > >>>>> +   }
> > > >>>>>
> > > >>>>> -           if (!is_deep_sleep) {
> > > >>>>> -                   if (smu_cmn_freqs_match(cur_clk, min_clk)) =
{
> > > >>>>> -                           lvl =3D 0;
> > > >>>>> -                   } else if (smu_cmn_freqs_match(cur_clk, max=
_clk)) {
> > > >>>>> -                           lvl =3D 1;
> > > >>>>> -                   } else {
> > > >>>>> -                           /* NOTE: use index '1' to show curr=
ent clock
> > > >>>> value */
> > > >>>>> -                           lvl =3D 1;
> > > >>>>> -                           count =3D 3;
> > > >>>>> -                           freq_values[1] =3D cur_clk;
> > > >>>>> -                           freq_values[2] =3D max_clk;
> > > >>>>> -                   }
> > > >>>>> -           }
> > > >>>>> +   size =3D smu_cmn_emit_clk_prefix(buf, size, is_fine_grained=
,
> > > >>>>> +                                  is_deep_sleep, cur_clk);
> > > >>>>>
> > > >>>>> -           for (i =3D 0; i < count; i++) {
> > > >>>>> -                   size +=3D sysfs_emit_at(
> > > >>>>> -                           buf, size, "%d: %uMhz %s\n", level_=
index + i,
> > > >>>>> -                           freq_values[i],
> > > >>>>> -                           (!is_deep_sleep && i =3D=3D lvl) ? =
"*" : "");
> > > >>>>> -           }
> > > >>>>> -   }
> > > >>>>> +   for (i =3D 0; i < entry_count; i++)
> > > >>>>> +           size +=3D smu_cmn_emit_clk_line(buf, size, i,
> > > >>>>> +                                        entries[i].freq,
> > > >>>>> +                                        entries[i].selected);
> > > >>>>>
> > > >>>>>       *offset =3D size;
> > > >>>>>
> > > >>>
> > > >
> > >
