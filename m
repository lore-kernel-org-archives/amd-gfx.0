Return-Path: <SRS0=T/f1=KK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3DCC433B4
	for <amd-gfx@archiver.kernel.org>; Sat, 15 May 2021 06:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E5D961404
	for <amd-gfx@archiver.kernel.org>; Sat, 15 May 2021 06:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5D961404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC2486E17E;
	Sat, 15 May 2021 06:41:21 +0000 (UTC)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA9E16E17E
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 May 2021 06:41:20 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id t193so897706pgb.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 23:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bTrVVcizxfqYHCuPIFZHNiCTDqgHBDAHyiFcBbiiHiU=;
 b=YS49ZdkjJwD/iSetETCxgqCZuaJ5Ku9W9g1NDSLvvOXgyhlLV2kvBKsdjs5WClWEGh
 W08Zl+tz3VipCPRYPXvsg8pu6ShvJBmoxv+6dugNbkrYbbp0Tzr5XF4k9y7uh6AToC1q
 Dw7Oz5bg2PbulhNiUcneWL7DU8SMQfUC+y1MHETBAnMdho4KBm5swV5MwlWuZEV3LOgs
 NgGSIEepgRwiKmT+Ugw3RB1fj7n8BNP8wdvbqo7xj9n5AfWUwrj1siGYwZEz9v2WJqnI
 SojRZTWTPcZTnGEJCvvxriWGW7DqNv4/jP6LcEsvBnOvF5ikZGZnYpRWUzObB334V/lJ
 KRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bTrVVcizxfqYHCuPIFZHNiCTDqgHBDAHyiFcBbiiHiU=;
 b=a3duBd8Xb3acbxj7tX4IjrN16EHvIESrRqqP0AYya/Xlk7Jm1sgy9KSE3vsSF4WCIR
 jeHmmWk2qwmdE6CEPbA3ovW13q+7P5SWf2i4yrlodCFJzY7AKglVINHctdHBRZBW2PEa
 gm6dAgmT1qs5oi1NAVZrwhKgQXhUIk2ia6rxfU1yrUjGbfp19lUOFunNkzeWLNqHE0VY
 63PBrlS05a5Qj7uL9SkpmDFhyATALxOK5M/yYheIv0CoDlxGC+UE/VPfcET6rnJfArIs
 d1H3lFToQhxy9cG0rNd92YmOURiw150a9KHO19RPslKuV0x5mfDty1haqhcdDFWEiZKL
 bfrg==
X-Gm-Message-State: AOAM532TfkyLFKBYMyM4a/PerbEWjhvmGmmtMP356bU+Sn5aPLXQj9a6
 iRmmi92z0trEOm4KebtGEluOzjsFdhOepEMP3lA=
X-Google-Smtp-Source: ABdhPJyxSRnlyjazPBBanjg2kqFDS9Fpsc3KS3D9Xxluw+WVFUO9Ud58vFIxd0MwhMFamzKel42ybZRSDMJjAFFCRpc=
X-Received: by 2002:a63:4e4f:: with SMTP id o15mr10640141pgl.208.1621060880168; 
 Fri, 14 May 2021 23:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210508064740.7705-1-Jiawei.Gu@amd.com>
 <CADnq5_PEogZDyFV_NOzbsajJQ_0A1+Jui-Mx7N_xsyWR5wXb8Q@mail.gmail.com>
 <CH0PR12MB5156FA453692B69100C3ADE7F8549@CH0PR12MB5156.namprd12.prod.outlook.com>
 <D7E9BE46-8E25-4A62-BE91-947898903A04@amd.com>
 <CH0PR12MB5156AF69D9E04020FDA5354AF8549@CH0PR12MB5156.namprd12.prod.outlook.com>
 <BYAPR12MB2840BA4077C73311A671CCBEF4549@BYAPR12MB2840.namprd12.prod.outlook.com>
 <bbf8cdf1-00a7-3e2a-74b0-71e85f1c7697@gmail.com>
 <447046CE-6FB4-49D7-A74A-2188654F5D5C@amd.com>
 <88e868eb-347b-611b-8d88-ba8d9d61c23b@gmail.com>
 <CAAxE2A73V5PLVgrcd+_KYYbK=n+POZajdVYMcMdj8A38KvTerA@mail.gmail.com>
 <MN2PR12MB4488E0D428871797E08DEE2BF7539@MN2PR12MB4488.namprd12.prod.outlook.com>
 <454dbf38-3337-de8b-6a29-30f417475121@gmail.com>
 <BYAPR12MB2840E586673207558B7FC136F4539@BYAPR12MB2840.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB2840E586673207558B7FC136F4539@BYAPR12MB2840.namprd12.prod.outlook.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Sat, 15 May 2021 02:40:43 -0400
Message-ID: <CAAxE2A4ASdVxA3s+Z6T00oBP+m6DDRo5CNeRxujL7_PJ=x6XBQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios
To: "Nieto, David M" <David.Nieto@amd.com>
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
Cc: Kees Cook <keescook@chromium.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, "Gu,
 JiaWei \(Will\)" <JiaWei.Gu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Content-Type: multipart/mixed; boundary="===============1736335931=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1736335931==
Content-Type: multipart/alternative; boundary="000000000000ebfc0305c258a5b4"

--000000000000ebfc0305c258a5b4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

1) Mesa doesn't plan to use this VBIOS query.

2) The patch is changing uapi, which is forbidden.

Marek

On Tue, May 11, 2021 at 12:35 PM Nieto, David M <David.Nieto@amd.com> wrote=
:

> [AMD Public Use]
>
> The point of having the device ID in the structure is because we are
> reading it from the VBIOS header, not the asic registers. They should
> match, but an user may flash a VBIOS for a different devid and they may n=
ot
> match.
>
> Regarding sysfs vs ioctl I see value in providing it in both ways, Mesa
> uses IOCTL and other DRM based tools may benefit as well. I recently went
> through the trouble of having to add sysfs string parsing for some data n=
ot
> available in ioctl, and while not very complicated, it is a programming
> inconvenience.
>
> I understand that being uapi, changing it is not easy, but this is
> information extracted from a VBIOS header, something that has been kept
> stable for many years.
>
> David
> ------------------------------
> *From:* Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
> *Sent:* Tuesday, May 11, 2021 7:07 AM
> *To:* Deucher, Alexander <Alexander.Deucher@amd.com>; Marek Ol=C5=A1=C3=
=A1k <
> maraeo@gmail.com>
> *Cc:* Kees Cook <keescook@chromium.org>; Gu, JiaWei (Will) <
> JiaWei.Gu@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>; Deng,
> Emily <Emily.Deng@amd.com>; Alex Deucher <alexdeucher@gmail.com>; Nieto,
> David M <David.Nieto@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: Align serial size in
> drm_amdgpu_info_vbios
>
> Yeah, but umr is making strong use of sysfs as well.
>
> The only justification of this interface would be if we want to use it in
> Mesa.
>
> And I agree with Marek that looks redundant with the device structure to
> me as well.
>
> Christian.
>
> Am 11.05.21 um 16:04 schrieb Deucher, Alexander:
>
> [AMD Public Use]
>
> It's being used by umr and some other smi tools to provide vbios
> information for debugging.
>
> Alex
>
> ------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org>
> <amd-gfx-bounces@lists.freedesktop.org> on behalf of Marek Ol=C5=A1=C3=A1=
k
> <maraeo@gmail.com> <maraeo@gmail.com>
> *Sent:* Tuesday, May 11, 2021 4:18 AM
> *To:* Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
> <ckoenig.leichtzumerken@gmail.com>
> *Cc:* Kees Cook <keescook@chromium.org> <keescook@chromium.org>; Gu,
> JiaWei (Will) <JiaWei.Gu@amd.com> <JiaWei.Gu@amd.com>; amd-gfx list
> <amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org>; Deng,
> Emily <Emily.Deng@amd.com> <Emily.Deng@amd.com>; Alex Deucher
> <alexdeucher@gmail.com> <alexdeucher@gmail.com>; Nieto, David M
> <David.Nieto@amd.com> <David.Nieto@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: Align serial size in
> drm_amdgpu_info_vbios
>
> Mesa doesn't use sysfs.
>
> Note that this is a uapi, meaning that once it's in the kernel, it can't
> be changed like that.
>
> What's the use case for this new interface? Isn't it partially redundant
> with the current device info structure, which seems to have the equivalen=
t
> of dev_id and rev_id?
>
> Marek
>
> On Tue, May 11, 2021 at 3:51 AM Christian K=C3=B6nig <
> ckoenig.leichtzumerken@gmail.com> wrote:
>
> Marek and other userspace folks need to decide that.
>
> Basic question here is if Mesa is already accessing sysfs nodes for OpenG=
L
> or RADV. If that is the case then we should probably expose the informati=
on
> there as well.
>
> If that isn't the case (which I think it is) then we should implement it
> as IOCTL.
>
> Regards,
> Christian.
>
> Am 10.05.21 um 22:19 schrieb Nieto, David M:
>
> One of the primary usecases is to add this information to the renderer
> string, I am not sure if there are other cases of UMD drivers accessing
> sysfs nodes, but I think if we think permissions, if a client is
> authenticated and opens the render device then it can use the IOCTL, it i=
s
> unclear to me we can make a such an assumption for sysfs nodes=E2=80=A6
>
>
>
> I think there is value in having both tbh.
>
>
>
> Regards,
>
> David
>
>
>
> *From: *Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
> <ckoenig.leichtzumerken@gmail.com>
> *Date: *Monday, May 10, 2021 at 6:48 AM
> *To: *"Nieto, David M" <David.Nieto@amd.com> <David.Nieto@amd.com>, "Gu,
> JiaWei (Will)" <JiaWei.Gu@amd.com> <JiaWei.Gu@amd.com>
> *Cc: *Alex Deucher <alexdeucher@gmail.com> <alexdeucher@gmail.com>,
> "Deng, Emily" <Emily.Deng@amd.com> <Emily.Deng@amd.com>, Kees Cook
> <keescook@chromium.org> <keescook@chromium.org>, amd-gfx list
> <amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org>
> *Subject: *Re: [PATCH] drm/amdgpu: Align serial size in
> drm_amdgpu_info_vbios
>
>
>
> Well we could add both as sysfs file(s).
>
> Question here is rather what is the primary use case of this and if the
> application has the necessary access permissions to the sysfs files?
>
> Regards,
> Christian.
>
> Am 10.05.21 um 15:42 schrieb Nieto, David M:
>
> Then the application would need to issue the ioctl and then open a sysfs
> file to get all the information it needs. It makes little sense from a
> programming perspective to add an incomplete interface in my opinion
>
>
> ------------------------------
>
> *From:* Gu, JiaWei (Will) <JiaWei.Gu@amd.com> <JiaWei.Gu@amd.com>
> *Sent:* Monday, May 10, 2021 12:13:07 AM
> *To:* Nieto, David M <David.Nieto@amd.com> <David.Nieto@amd.com>
> *Cc:* Alex Deucher <alexdeucher@gmail.com> <alexdeucher@gmail.com>;
> amd-gfx list <amd-gfx@lists.freedesktop.org>
> <amd-gfx@lists.freedesktop.org>; Kees Cook <keescook@chromium.org>
> <keescook@chromium.org>; Deng, Emily <Emily.Deng@amd.com>
> <Emily.Deng@amd.com>
> *Subject:* RE: [PATCH] drm/amdgpu: Align serial size in
> drm_amdgpu_info_vbios
>
>
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi David,
>
> What I meant is to ONLY delete the serial[16] from drm_amdgpu_info_vbios,
> not the whole struct.
>
> struct drm_amdgpu_info_vbios {
>         __u8 name[64];
>         __u32 dbdf;
>         __u8 vbios_pn[64];
>         __u32 version;
>         __u8 date[32];
>         __u8 serial[16]; // jiawei: shall we delete this
>         __u32 dev_id;
>         __u32 rev_id;
>         __u32 sub_dev_id;
>         __u32 sub_ved_id;
> };
>
> serial[16] in drm_amdgpu_info_vbios  copied from adev->serial, but there'=
s
> already a sysfs named serial_number, which exposes it already.
>
> static ssize_t amdgpu_device_get_serial_number(struct device *dev,
>                 struct device_attribute *attr, char *buf)
> {
>         struct drm_device *ddev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D ddev->dev_private;
>
>         return snprintf(buf, PAGE_SIZE, "%s\n", adev->serial);
> }
>
> Thanks,
> Jiawei
>
>
> -----Original Message-----
> From: Nieto, David M <David.Nieto@amd.com> <David.Nieto@amd.com>
> Sent: Monday, May 10, 2021 2:53 PM
> To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com> <JiaWei.Gu@amd.com>
> Cc: Alex Deucher <alexdeucher@gmail.com> <alexdeucher@gmail.com>; amd-gfx
> list <amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org>;
> Kees Cook <keescook@chromium.org> <keescook@chromium.org>; Deng, Emily
> <Emily.Deng@amd.com> <Emily.Deng@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbi=
os
>
> No, this structure contains all the details of the vbios: date, serial
> number, name, etc.
>
> The sysfs node only contains the vbios name string
>
> > On May 9, 2021, at 23:33, Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
> <JiaWei.Gu@amd.com> wrote:
> >
> > [AMD Official Use Only - Internal Distribution Only]
> >
> > With a second thought,
> > __u8 serial[16] in drm_amdgpu_info_vbios is a bit redundant, sysfs
> serial_number already exposes it.
> >
> > Is it fine to abandon it from drm_amdgpu_info_vbios struct? @Alex
> > Deucher @Nieto, David M
> >
> > Best regards,
> > Jiawei
> >
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com> <alexdeucher@gmail.com>
> > Sent: Sunday, May 9, 2021 11:59 PM
> > To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com> <JiaWei.Gu@amd.com>
> > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> <amd-gfx@lists.freedesktop.org>; Kees Cook
> > <keescook@chromium.org> <keescook@chromium.org>
> > Subject: Re: [PATCH] drm/amdgpu: Align serial size in
> > drm_amdgpu_info_vbios
> >
> >> On Sat, May 8, 2021 at 2:48 AM Jiawei Gu <Jiawei.Gu@amd.com>
> <Jiawei.Gu@amd.com> wrote:
> >>
> >> 20 should be serial char size now instead of 16.
> >>
> >> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com> <Jiawei.Gu@amd.com>
> >
> > Please make sure this keeps proper 64 bit alignment in the structure.
> >
> > Alex
> >
> >
> >> ---
> >> include/uapi/drm/amdgpu_drm.h | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/include/uapi/drm/amdgpu_drm.h
> >> b/include/uapi/drm/amdgpu_drm.h index 2b487a8d2727..1c20721f90da
> >> 100644
> >> --- a/include/uapi/drm/amdgpu_drm.h
> >> +++ b/include/uapi/drm/amdgpu_drm.h
> >> @@ -957,7 +957,7 @@ struct drm_amdgpu_info_vbios {
> >>        __u8 vbios_pn[64];
> >>        __u32 version;
> >>        __u8 date[32];
> >> -       __u8 serial[16];
> >> +       __u8 serial[20];
> >>        __u32 dev_id;
> >>        __u32 rev_id;
> >>        __u32 sub_dev_id;
> >> --
> >> 2.17.1
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fli=
s
> >> t
> >> s.freedesktop.org
> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fs.fre=
edesktop.org%2F&data=3D04%7C01%7CDavid.Nieto%40amd.com%7Cf24b10fbdd964acea3=
2008d914862738%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637563388684906=
500%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1=
haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DgKeRCQ485gWespGfo1O01tZz8fDy1zPGHIDEvCqy=
p1I%3D&reserved=3D0>
> %2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CJ
> >> i
> >> awei.Gu%40amd.com
> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2F40amd=
.com%2F&data=3D04%7C01%7CDavid.Nieto%40amd.com%7Cf24b10fbdd964acea32008d914=
862738%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637563388684916541%7CUn=
known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ=
XVCI6Mn0%3D%7C1000&sdata=3D8pM7WTh9%2F23KCF6DuXOc4%2Fi7rDUSxmH647BdpujXgWo%=
3D&reserved=3D0>
> %7Ccea31833184c41e8574508d9130360cc%7C3dd8961fe4884e
> >> 6
> >> 08e11a82d994e183d%7C0%7C0%7C637561727523880356%7CUnknown%7CTWFpbGZsb3
> >> d
> >> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> >> C
> >> 1000&amp;sdata=3DkAJiC6WoJUTeExwk6ftrLfMoY2OTAwg9X7mGgJT3kLk%3D&amp;re=
s
> >> e
> >> rved=3D0
>
>
>
> _______________________________________________
>
> amd-gfx mailing list
>
> amd-gfx@lists.freedesktop.org
>
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx <https://nam11.saf=
elinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2F=
mailman%2Flistinfo%2Famd-gfx&data=3D04%7C01%7CDavid.Nieto%40amd.com%7Cf24b1=
0fbdd964acea32008d914862738%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63=
7563388684926488%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz=
IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DHdhx2ogsQt2C3OIKNC%2BaswtNk=
iIWbV6Ot8a%2B3YFqa7w%3D&reserved=3D0>
>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist=
s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=3D04%7C01%7CDavid.Nie=
to%40amd.com%7Cf24b10fbdd964acea32008d914862738%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637563388684926488%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj=
AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DHdhx2og=
sQt2C3OIKNC%2BaswtNkiIWbV6Ot8a%2B3YFqa7w%3D&reserved=3D0>
>
>
>

--000000000000ebfc0305c258a5b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>1) Mesa doesn&#39;t plan to use this VBIOS query.</di=
v><div><br></div><div>2) The patch is changing uapi, which is forbidden.<br=
></div><div><br></div><div>Marek<br></div></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 11, 2021 at 12:35 PM =
Nieto, David M &lt;<a href=3D"mailto:David.Nieto@amd.com">David.Nieto@amd.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">




<div dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:rgb(49,113,0);margin:15p=
t" align=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0);background-color:rgb(255,255,255)">
The point of having the device ID in the structure is because we are readin=
g it from the VBIOS header, not the asic registers. They should match, but =
an user may flash a VBIOS for a different devid and they may not match.</di=
v>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0);background-color:rgb(255,255,255)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0);background-color:rgb(255,255,255)">
Regarding sysfs vs ioctl I see value in providing it in both ways, Mesa use=
s IOCTL and other DRM based tools may benefit as well. I recently went thro=
ugh the trouble of having to add sysfs string parsing for some data not ava=
ilable in ioctl, and while not very
 complicated, it is a programming inconvenience.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0);background-color:rgb(255,255,255)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0);background-color:rgb(255,255,255)">
I understand that being uapi, changing it is not easy, but this is informat=
ion extracted from a VBIOS header, something that has been kept stable for =
many=C2=A0years.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0);background-color:rgb(255,255,255)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0);background-color:rgb(255,255,255)">
David</div>
<div id=3D"gmail-m_8490547758640332650appendonsend"></div>
<hr style=3D"display:inline-block;width:98%">
<div id=3D"gmail-m_8490547758640332650divRplyFwdMsg" dir=3D"ltr"><font styl=
e=3D"font-size:11pt" face=3D"Calibri, sans-serif" color=3D"#000000"><b>From=
:</b> Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gma=
il.com" target=3D"_blank">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
<b>Sent:</b> Tuesday, May 11, 2021 7:07 AM<br>
<b>To:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om" target=3D"_blank">Alexander.Deucher@amd.com</a>&gt;; Marek Ol=C5=A1=C3=
=A1k &lt;<a href=3D"mailto:maraeo@gmail.com" target=3D"_blank">maraeo@gmail=
.com</a>&gt;<br>
<b>Cc:</b> Kees Cook &lt;<a href=3D"mailto:keescook@chromium.org" target=3D=
"_blank">keescook@chromium.org</a>&gt;; Gu, JiaWei (Will) &lt;<a href=3D"ma=
ilto:JiaWei.Gu@amd.com" target=3D"_blank">JiaWei.Gu@amd.com</a>&gt;; amd-gf=
x list &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blan=
k">amd-gfx@lists.freedesktop.org</a>&gt;; Deng, Emily &lt;<a href=3D"mailto=
:Emily.Deng@amd.com" target=3D"_blank">Emily.Deng@amd.com</a>&gt;; Alex Deu=
cher &lt;<a href=3D"mailto:alexdeucher@gmail.com" target=3D"_blank">alexdeu=
cher@gmail.com</a>&gt;; Nieto, David M &lt;<a href=3D"mailto:David.Nieto@am=
d.com" target=3D"_blank">David.Nieto@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_inf=
o_vbios</font>
<div>=C2=A0</div>
</div>
<div>Yeah, but umr is making strong use of sysfs as well.<br>
<br>
The only justification of this interface would be if we want to use it in M=
esa.<br>
<br>
And I agree with Marek that looks redundant with the device structure to me=
 as well.<br>
<br>
Christian.<br>
<br>
<div>Am 11.05.21 um 16:04 schrieb Deucher, Alexander:<br>
</div>
<blockquote type=3D"cite">
<p style=3D"font-family:Arial;font-size:10pt;color:rgb(49,113,0);margin:15p=
t" align=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
It&#39;s being used by umr and some other smi tools to provide vbios inform=
ation for debugging.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
Alex</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<hr style=3D"display:inline-block;width:98%">
<div id=3D"gmail-m_8490547758640332650x_divRplyFwdMsg" dir=3D"ltr"><font st=
yle=3D"font-size:11pt" face=3D"Calibri, sans-serif" color=3D"#000000"><b>Fr=
om:</b> amd-gfx
<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org" target=3D"_blank">
&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on behalf of Marek Ol=C5=
=A1=C3=A1k <a href=3D"mailto:maraeo@gmail.com" target=3D"_blank">
&lt;maraeo@gmail.com&gt;</a><br>
<b>Sent:</b> Tuesday, May 11, 2021 4:18 AM<br>
<b>To:</b> Christian K=C3=B6nig <a href=3D"mailto:ckoenig.leichtzumerken@gm=
ail.com" target=3D"_blank">
&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
<b>Cc:</b> Kees Cook <a href=3D"mailto:keescook@chromium.org" target=3D"_bl=
ank">
&lt;keescook@chromium.org&gt;</a>; Gu, JiaWei (Will) <a href=3D"mailto:JiaW=
ei.Gu@amd.com" target=3D"_blank">
&lt;JiaWei.Gu@amd.com&gt;</a>; amd-gfx list <a href=3D"mailto:amd-gfx@lists=
.freedesktop.org" target=3D"_blank">
&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Deng, Emily <a href=3D"mailto:Em=
ily.Deng@amd.com" target=3D"_blank">
&lt;Emily.Deng@amd.com&gt;</a>; Alex Deucher <a href=3D"mailto:alexdeucher@=
gmail.com" target=3D"_blank">
&lt;alexdeucher@gmail.com&gt;</a>; Nieto, David M <a href=3D"mailto:David.N=
ieto@amd.com" target=3D"_blank">
&lt;David.Nieto@amd.com&gt;</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_inf=
o_vbios</font>
<div>=C2=A0</div>
</div>
<div>
<div dir=3D"ltr">
<div>Mesa doesn&#39;t use sysfs.</div>
<div><br>
</div>
<div>Note that this is a uapi, meaning that once it&#39;s in the kernel, it=
 can&#39;t be changed like that.<br>
</div>
<div><br>
</div>
<div>What&#39;s the use case for this new interface? Isn&#39;t it partially=
 redundant with the current device info structure, which seems to have the =
equivalent of dev_id and rev_id?<br>
</div>
<div><br>
</div>
<div>Marek<br>
</div>
</div>
<br>
<div>
<div dir=3D"ltr">On Tue, May 11, 2021 at 3:51 AM Christian K=C3=B6nig &lt;<=
a href=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=3D"_blank">ckoeni=
g.leichtzumerken@gmail.com</a>&gt; wrote:<br>
</div>
<blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
<div>Marek and other userspace folks need to decide that.<br>
<br>
Basic question here is if Mesa is already accessing sysfs nodes for OpenGL =
or RADV. If that is the case then we should probably expose the information=
 there as well.<br>
<br>
If that isn&#39;t the case (which I think it is) then we should implement i=
t as IOCTL.<br>
<br>
Regards,<br>
Christian.<br>
<br>
<div>Am 10.05.21 um 22:19 schrieb Nieto, David M:<br>
</div>
<blockquote type=3D"cite">
<div>
<p>One of the primary usecases is to add this information to the renderer s=
tring, I am not sure if there are other cases of UMD drivers accessing sysf=
s nodes, but I think if we think permissions, if a client is authenticated =
and opens
 the render device then it can use the IOCTL, it is unclear to me we can ma=
ke a such an assumption for sysfs nodes=E2=80=A6</p>
<p>=C2=A0</p>
<p>I think there is value in having both tbh.</p>
<p>=C2=A0</p>
<p>Regards,</p>
<p>David</p>
<p>=C2=A0</p>
<div style=3D"border-color:rgb(181,196,223) currentcolor currentcolor;borde=
r-style:solid none none;border-width:1pt medium medium;padding:3pt 0in 0in"=
>
<p><b><span style=3D"font-size:12pt;color:black">From: </span>
</b><span style=3D"font-size:12pt;color:black">Christian K=C3=B6nig <a href=
=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=3D"_blank">
&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
<b>Date: </b>Monday, May 10, 2021 at 6:48 AM<br>
<b>To: </b>&quot;Nieto, David M&quot; <a href=3D"mailto:David.Nieto@amd.com=
" target=3D"_blank">
&lt;David.Nieto@amd.com&gt;</a>, &quot;Gu, JiaWei (Will)&quot; <a href=3D"m=
ailto:JiaWei.Gu@amd.com" target=3D"_blank">
&lt;JiaWei.Gu@amd.com&gt;</a><br>
<b>Cc: </b>Alex Deucher <a href=3D"mailto:alexdeucher@gmail.com" target=3D"=
_blank">&lt;alexdeucher@gmail.com&gt;</a>, &quot;Deng, Emily&quot;
<a href=3D"mailto:Emily.Deng@amd.com" target=3D"_blank">&lt;Emily.Deng@amd.=
com&gt;</a>, Kees Cook
<a href=3D"mailto:keescook@chromium.org" target=3D"_blank">&lt;keescook@chr=
omium.org&gt;</a>, amd-gfx list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">&lt;amd-=
gfx@lists.freedesktop.org&gt;</a><br>
<b>Subject: </b>Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_inf=
o_vbios</span></p>
</div>
<div>
<p>=C2=A0</p>
</div>
<p style=3D"margin-bottom:12pt">Well we could add both as sysfs file(s).<br=
>
<br>
Question here is rather what is the primary use case of this and if the app=
lication has the necessary access permissions to the sysfs files?<br>
<br>
Regards,<br>
Christian.</p>
<div>
<p>Am 10.05.21 um 15:42 schrieb Nieto, David M:</p>
</div>
<blockquote style=3D"margin-top:5pt;margin-bottom:5pt">
<div>
<div>
<div>
<p style=3D"background:white none repeat scroll 0% 0%">
<span style=3D"color:black">Then the application would need to issue the io=
ctl and then open a sysfs file to get all the information it needs. It make=
s little sense from a programming perspective to add an incomplete interfac=
e in my opinion=C2=A0</span></p>
</div>
</div>
<div>
<p>=C2=A0</p>
</div>
</div>
<div style=3D"text-align:center" align=3D"center">
<hr width=3D"100%" size=3D"0" align=3D"center">
</div>
<div id=3D"gmail-m_8490547758640332650x_x_gmail-m_782079725653541167gmail-m=
_3184748164637597930gmail-m_-3452308432024396062divRplyFwdMsg">
<p><b><span style=3D"color:black">From:</span></b><span style=3D"color:blac=
k"> Gu, JiaWei (Will)
<a href=3D"mailto:JiaWei.Gu@amd.com" target=3D"_blank">&lt;JiaWei.Gu@amd.co=
m&gt;</a><br>
<b>Sent:</b> Monday, May 10, 2021 12:13:07 AM<br>
<b>To:</b> Nieto, David M <a href=3D"mailto:David.Nieto@amd.com" target=3D"=
_blank">&lt;David.Nieto@amd.com&gt;</a><br>
<b>Cc:</b> Alex Deucher <a href=3D"mailto:alexdeucher@gmail.com" target=3D"=
_blank">&lt;alexdeucher@gmail.com&gt;</a>; amd-gfx list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">&lt;amd-=
gfx@lists.freedesktop.org&gt;</a>; Kees Cook
<a href=3D"mailto:keescook@chromium.org" target=3D"_blank">&lt;keescook@chr=
omium.org&gt;</a>; Deng, Emily
<a href=3D"mailto:Emily.Deng@amd.com" target=3D"_blank">&lt;Emily.Deng@amd.=
com&gt;</a><br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_inf=
o_vbios</span>
</p>
<div>
<p>=C2=A0</p>
</div>
</div>
<div>
<div>
<p>[AMD Official Use Only - Internal Distribution Only]<br>
<br>
Hi David,<br>
<br>
What I meant is to ONLY delete the serial[16] from drm_amdgpu_info_vbios, n=
ot the whole struct.<br>
<br>
struct drm_amdgpu_info_vbios {<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8 name[64];<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 dbdf;<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8 vbios_pn[64];<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 version;<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8 date[32];<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8 serial[16]; // jiawei: shal=
l we delete this<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 dev_id;<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 rev_id;<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 sub_dev_id;<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 sub_ved_id;<br>
};<br>
<br>
serial[16] in drm_amdgpu_info_vbios=C2=A0 copied from adev-&gt;serial, but =
there&#39;s already a sysfs named serial_number, which exposes it already.<=
br>
<br>
static ssize_t amdgpu_device_get_serial_number(struct device *dev,<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct device_attribute *attr, char *buf)<br>
{<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_device *ddev =3D dev_=
get_drvdata(dev);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_device *adev =3D d=
dev-&gt;dev_private;<br>
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return snprintf(buf, PAGE_SIZE, =
&quot;%s\n&quot;, adev-&gt;serial);<br>
}<br>
<br>
Thanks,<br>
Jiawei<br>
<br>
<br>
-----Original Message-----<br>
From: Nieto, David M <a href=3D"mailto:David.Nieto@amd.com" target=3D"_blan=
k">&lt;David.Nieto@amd.com&gt;</a>
<br>
Sent: Monday, May 10, 2021 2:53 PM<br>
To: Gu, JiaWei (Will) <a href=3D"mailto:JiaWei.Gu@amd.com" target=3D"_blank=
">&lt;JiaWei.Gu@amd.com&gt;</a><br>
Cc: Alex Deucher <a href=3D"mailto:alexdeucher@gmail.com" target=3D"_blank"=
>&lt;alexdeucher@gmail.com&gt;</a>; amd-gfx list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">&lt;amd-=
gfx@lists.freedesktop.org&gt;</a>; Kees Cook
<a href=3D"mailto:keescook@chromium.org" target=3D"_blank">&lt;keescook@chr=
omium.org&gt;</a>; Deng, Emily
<a href=3D"mailto:Emily.Deng@amd.com" target=3D"_blank">&lt;Emily.Deng@amd.=
com&gt;</a><br>
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios=
<br>
<br>
No, this structure contains all the details of the vbios: date, serial numb=
er, name, etc.<br>
<br>
The sysfs node only contains the vbios name string<br>
<br>
&gt; On May 9, 2021, at 23:33, Gu, JiaWei (Will) <a href=3D"mailto:JiaWei.G=
u@amd.com" target=3D"_blank">
&lt;JiaWei.Gu@amd.com&gt;</a> wrote:<br>
&gt; <br>
&gt; [AMD Official Use Only - Internal Distribution Only]<br>
&gt; <br>
&gt; With a second thought,<br>
&gt; __u8 serial[16] in drm_amdgpu_info_vbios is a bit redundant, sysfs ser=
ial_number already exposes it.<br>
&gt; <br>
&gt; Is it fine to abandon it from drm_amdgpu_info_vbios struct? @Alex <br>
&gt; Deucher @Nieto, David M<br>
&gt; <br>
&gt; Best regards,<br>
&gt; Jiawei<br>
&gt; <br>
&gt; -----Original Message-----<br>
&gt; From: Alex Deucher <a href=3D"mailto:alexdeucher@gmail.com" target=3D"=
_blank">&lt;alexdeucher@gmail.com&gt;</a><br>
&gt; Sent: Sunday, May 9, 2021 11:59 PM<br>
&gt; To: Gu, JiaWei (Will) <a href=3D"mailto:JiaWei.Gu@amd.com" target=3D"_=
blank">&lt;JiaWei.Gu@amd.com&gt;</a><br>
&gt; Cc: amd-gfx list <a href=3D"mailto:amd-gfx@lists.freedesktop.org" targ=
et=3D"_blank">
&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Kees Cook <br>
&gt; <a href=3D"mailto:keescook@chromium.org" target=3D"_blank">&lt;keescoo=
k@chromium.org&gt;</a><br>
&gt; Subject: Re: [PATCH] drm/amdgpu: Align serial size in <br>
&gt; drm_amdgpu_info_vbios<br>
&gt; <br>
&gt;&gt; On Sat, May 8, 2021 at 2:48 AM Jiawei Gu <a href=3D"mailto:Jiawei.=
Gu@amd.com" target=3D"_blank">
&lt;Jiawei.Gu@amd.com&gt;</a> wrote:<br>
&gt;&gt; <br>
&gt;&gt; 20 should be serial char size now instead of 16.<br>
&gt;&gt; <br>
&gt;&gt; Signed-off-by: Jiawei Gu <a href=3D"mailto:Jiawei.Gu@amd.com" targ=
et=3D"_blank">&lt;Jiawei.Gu@amd.com&gt;</a><br>
&gt; <br>
&gt; Please make sure this keeps proper 64 bit alignment in the structure.<=
br>
&gt; <br>
&gt; Alex<br>
&gt; <br>
&gt; <br>
&gt;&gt; ---<br>
&gt;&gt; include/uapi/drm/amdgpu_drm.h | 2 +-<br>
&gt;&gt; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;&gt; <br>
&gt;&gt; diff --git a/include/uapi/drm/amdgpu_drm.h <br>
&gt;&gt; b/include/uapi/drm/amdgpu_drm.h index 2b487a8d2727..1c20721f90da<b=
r>
&gt;&gt; 100644<br>
&gt;&gt; --- a/include/uapi/drm/amdgpu_drm.h<br>
&gt;&gt; +++ b/include/uapi/drm/amdgpu_drm.h<br>
&gt;&gt; @@ -957,7 +957,7 @@ struct drm_amdgpu_info_vbios {<br>
&gt;&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8 vbios_pn[64];<br>
&gt;&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 version;<br>
&gt;&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8 date[32];<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8 serial[16];<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8 serial[20];<br>
&gt;&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 dev_id;<br>
&gt;&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 rev_id;<br>
&gt;&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 sub_dev_id;<br>
&gt;&gt; --<br>
&gt;&gt; 2.17.1<br>
&gt;&gt; <br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank"=
>amd-gfx@lists.freedesktop.org</a><br>
&gt;&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dh=
ttps%3A%2F%2Flis" target=3D"_blank">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis</a>=
<br>
&gt;&gt; t <br>
&gt;&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dh=
ttp%3A%2F%2Fs.freedesktop.org%2F&amp;data=3D04%7C01%7CDavid.Nieto%40amd.com=
%7Cf24b10fbdd964acea32008d914862738%7C3dd8961fe4884e608e11a82d994e183d%7C0%=
7C0%7C637563388684906500%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj=
oiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DgKeRCQ485gWespG=
fo1O01tZz8fDy1zPGHIDEvCqyp1I%3D&amp;reserved=3D0" target=3D"_blank">
s.freedesktop.org</a>%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C01=
%7CJ<br>
&gt;&gt; i<br>
&gt;&gt; awei.Gu%<a href=3D"https://nam11.safelinks.protection.outlook.com/=
?url=3Dhttp%3A%2F%2F40amd.com%2F&amp;data=3D04%7C01%7CDavid.Nieto%40amd.com=
%7Cf24b10fbdd964acea32008d914862738%7C3dd8961fe4884e608e11a82d994e183d%7C0%=
7C0%7C637563388684916541%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj=
oiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D8pM7WTh9%2F23KC=
F6DuXOc4%2Fi7rDUSxmH647BdpujXgWo%3D&amp;reserved=3D0" target=3D"_blank">40a=
md.com</a>%7Ccea31833184c41e8574508d9130360cc%7C3dd8961fe4884e<br>
&gt;&gt; 6 <br>
&gt;&gt; 08e11a82d994e183d%7C0%7C0%7C637561727523880356%7CUnknown%7CTWFpbGZ=
sb3<br>
&gt;&gt; d <br>
&gt;&gt; 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3=
D%7<br>
&gt;&gt; C <br>
&gt;&gt; 1000&amp;amp;sdata=3DkAJiC6WoJUTeExwk6ftrLfMoY2OTAwg9X7mGgJT3kLk%3=
D&amp;amp;res<br>
&gt;&gt; e<br>
&gt;&gt; rved=3D0</p>
</div>
</div>
<p><br>
<br>
</p>
<pre>_______________________________________________</pre>
<pre>amd-gfx mailing list</pre>
<pre><a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd=
-gfx@lists.freedesktop.org</a></pre>
<pre><a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04=
%7C01%7CDavid.Nieto%40amd.com%7Cf24b10fbdd964acea32008d914862738%7C3dd8961f=
e4884e608e11a82d994e183d%7C0%7C0%7C637563388684926488%7CUnknown%7CTWFpbGZsb=
3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C100=
0&amp;sdata=3DHdhx2ogsQt2C3OIKNC%2BaswtNkiIWbV6Ot8a%2B3YFqa7w%3D&amp;reserv=
ed=3D0" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo/am=
d-gfx</a></pre>
</blockquote>
<p><br>
<br>
</p>
</div>
</blockquote>
<br>
</div>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01=
%7CDavid.Nieto%40amd.com%7Cf24b10fbdd964acea32008d914862738%7C3dd8961fe4884=
e608e11a82d994e183d%7C0%7C0%7C637563388684926488%7CUnknown%7CTWFpbGZsb3d8ey=
JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp=
;sdata=3DHdhx2ogsQt2C3OIKNC%2BaswtNkiIWbV6Ot8a%2B3YFqa7w%3D&amp;reserved=3D=
0" rel=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailm=
an/listinfo/amd-gfx</a><br>
</blockquote>
</div>
</div>
</div>
</blockquote>
<br>
</div>
</div>
</div>

</blockquote></div>

--000000000000ebfc0305c258a5b4--

--===============1736335931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1736335931==--
