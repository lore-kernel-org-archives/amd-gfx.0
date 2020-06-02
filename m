Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2C5C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 14:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20A3E205CB
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 14:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VffLUyqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A3E205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E47036E3F3;
	Tue,  2 Jun 2020 14:35:56 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 868B56E3F3
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 14:35:55 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id d128so3390525wmc.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jun 2020 07:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=m3AlOrhw7KigbajhAs4e2difp/dv7u4ZBDcbKHEYJ/Q=;
 b=VffLUyqADMeVAaGUij43GUUQLIrsh8oedA8aUiX0/1SzmX2nEOSgobFS6SqgvJBqik
 iTS4eid6aH9s3Tx2b7Lv3vhaw9MenQM4ln349vdCoXT80e71dFRNyx/yNL7y//D5V2C4
 jWuqXHCNxH8ReOhaOolLseTt1s67mPDYoHKHx5m8ldSehQVtzJytuWL4vHtL3lTt/h6M
 h9o/2EeVTEejRJLfFHHLHpvi7ENiTLnlkNyR47NjJAz3vts3utVb9uf2oUIqaRLDAkP4
 fFCPrj1xkzeOG93Em4koXaOBn6qVHbHctlqbr1RoaqZyMNSAn2P9KDRPEmeEmnpkTjcY
 /6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=m3AlOrhw7KigbajhAs4e2difp/dv7u4ZBDcbKHEYJ/Q=;
 b=tbmoXXWLe4yCgLbMA3WzDG5Pzb+puh6mZ74RI9npMAJUEO9QcS4JzgluWUZy6EbxfI
 AnXN1dkLzOFEqDuyOExXRHEACq8prpHD9dYviCH57kDPuXfsDSRxSSax+SwrVzDZK8MM
 o1PlkwcWAcr6Iwdo6u1gUfM1eREDm/kfOPwR8bEC/5zehUW8m50MWu7WOkcKpFhQI7ip
 kNsmJ4/cCuaRybhTnYydxe326kvZCF5RC8iln3yWHDiF3EIISlV8ws3KrhJiFEDISoFq
 0eIQkHkmJHl5jfuOP3iTDYH9wr+RlczR0/6H4Zq5f+fx3+TbwUY0laLrgJOLgONrl5G4
 TGLw==
X-Gm-Message-State: AOAM530E6f0F/wWHgcpU2VSlZEkUPwXZpx2B440MgqjDZp3frCHhdZWh
 a21UQ3UG5mcTdvE8o+bm+h96OpvVuedO6LEHrSY0Uh1F
X-Google-Smtp-Source: ABdhPJxfbnKQyQnbp2BRc1za57KX5McnTtGG4xTest4QDUzJxOUBsIAK0OFjPxs4H4lnEPJVukqQqLv4Z3tKgmXFgQo=
X-Received: by 2002:a1c:29c4:: with SMTP id p187mr4387063wmp.73.1591108554218; 
 Tue, 02 Jun 2020 07:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <1590722887-9333-1-git-send-email-Prike.Liang@amd.com>
 <BY5PR12MB430719B6351D4AD64215A7CBFB8B0@BY5PR12MB4307.namprd12.prod.outlook.com>
 <CADnq5_Nndacwux6UQMXBvBPOxLLGT-gnMHOjoHr1u-YGed696Q@mail.gmail.com>
 <BY5PR12MB43079E7A642EF6CAD9382393FB8B0@BY5PR12MB4307.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB43079E7A642EF6CAD9382393FB8B0@BY5PR12MB4307.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Jun 2020 10:35:43 -0400
Message-ID: <CADnq5_MGy2fOXs7q5Y8QEEPW4EPu_zwXeP6Wi1K0scvb3DmkVg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: enable renoir discovery for gc info retrieved
To: "Liang, Prike" <Prike.Liang@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 2, 2020 at 9:56 AM Liang, Prike <Prike.Liang@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Ah not aware the enable patch before. But the already enable patch seems can't fallback to legacy gpuinfo FW load method when not support discovery and also may miss destroy the discovery_bin object when driver shut down.
>

I think it's already handled.  See these patches:
https://cgit.freedesktop.org/~agd5f/linux/commit/?h=amd-staging-drm-next&id=4d09621cc55bcec9ec0aa038c8ffcffd2017837f
https://cgit.freedesktop.org/~agd5f/linux/commit/?h=amd-staging-drm-next&id=6206aa0f74e7d22ca43975bd8f2979cdfd128b40

Alex

> Thanks,
> Prike
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Tuesday, June 2, 2020 9:35 PM
> > To: Liang, Prike <Prike.Liang@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu: enable renoir discovery for gc info
> > retrieved
> >
> > On Mon, Jun 1, 2020 at 10:14 PM Liang, Prike <Prike.Liang@amd.com> wrote:
> > >
> > > [AMD Official Use Only - Internal Distribution Only]
> > >
> > > Ping...
> >
> > Already enabled:
> > https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.free
> > desktop.org%2F~agd5f%2Flinux%2Fcommit%2F%3Fh%3Damd-staging-drm-
> > next%26id%3De467ab869f5783cf93d4cf24c6ac647cc29d1fb5&amp;data=02%
> > 7C01%7CPrike.Liang%40amd.com%7C5bcc45116bb042163cec08d806f9bd58
> > %7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637267016987033
> > 430&amp;sdata=KJ0xmSPXwlZ4LEfhAYoFzAwaWyx3laoLAsQccMM0pcs%3D&
> > amp;reserved=0
> >
> > Alex
> >
> > >
> > > Thanks,
> > > > -----Original Message-----
> > > > From: Liang, Prike <Prike.Liang@amd.com>
> > > > Sent: Friday, May 29, 2020 11:28 AM
> > > > To: amd-gfx@lists.freedesktop.org
> > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
> > > > <Ray.Huang@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> > > > Subject: [PATCH] drm/amdgpu: enable renoir discovery for gc info
> > > > retrieved
> > > >
> > > > Use ip discovery GC table instead of gpu info firmware for exporting
> > > > gpu info to inquire interface.As Renoir discovery has same version
> > > > with Navi1x therefore just enable it same way as Navi1x.
> > > >
> > > > Signed-off-by: Prike.Liang <Prike.Liang@amd.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 23
> > > > ++++++++++++++++++++---
> > > >  1 file changed, 20 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > index 2f0e8da..bff740ccd 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > @@ -1528,7 +1528,7 @@ static int
> > > > amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)  {
> > > > const char *chip_name;  char fw_name[30]; -int err;
> > > > +int err, r;
> > > >  const struct gpu_info_firmware_header_v1_0 *hdr;
> > > >
> > > >  adev->firmware.gpu_info_fw = NULL;
> > > > @@ -1578,6 +1578,23 @@ static int
> > > > amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
> > > > chip_name = "arcturus";  break;  case CHIP_RENOIR:
> > > > +if (amdgpu_discovery) {
> > > > +/**
> > > > + * For RENOIR series seems needn't reinitialize the reg base
> > > > again as it already set during
> > > > + * early init,if any concern here will need export
> > > > amdgpu_discovery_init() for this case.
> > > > + */
> > > > +r = amdgpu_discovery_reg_base_init(adev);
> > > > +if (r) {
> > > > +DRM_WARN("failed to get ip discovery table,
> > > > "
> > > > +"fallback to get gpu info in legacy
> > > > method\n");
> > > > +goto legacy_gpuinfo;
> > > > +}
> > > > +
> > > > +amdgpu_discovery_get_gfx_info(adev);
> > > > +
> > > > +return 0;
> > > > +}
> > > > +legacy_gpuinfo:
> > > >  chip_name = "renoir";
> > > >  break;
> > > >  case CHIP_NAVI10:
> > > > @@ -1617,7 +1634,7 @@ static int
> > > > amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)  (const
> > > > struct gpu_info_firmware_v1_0 *)(adev-
> > > > >firmware.gpu_info_fw->data +
> > > >
> > > > le32_to_cpu(hdr->header.ucode_array_offset_bytes));
> > > >
> > > > -if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10) {
> > > > +if (amdgpu_discovery && adev->asic_type >= CHIP_RENOIR
> > > > && !r) {
> > > >  amdgpu_discovery_get_gfx_info(adev);
> > > >  goto parse_soc_bounding_box;
> > > >  }
> > > > @@ -3364,7 +3381,7 @@ void amdgpu_device_fini(struct
> > amdgpu_device
> > > > *adev)
> > > >  sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);  if
> > > > (IS_ENABLED(CONFIG_PERF_EVENTS))  amdgpu_pmu_fini(adev); -if
> > > > (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10)
> > > > +if (amdgpu_discovery && adev->asic_type >= CHIP_RENOIR)
> > > >  amdgpu_discovery_fini(adev);
> > > >  }
> > > >
> > > > --
> > > > 2.7.4
> > >
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> > gfx&amp;data=02%7C01%7CPr
> > >
> > ike.Liang%40amd.com%7C5bcc45116bb042163cec08d806f9bd58%7C3dd896
> > 1fe4884
> > >
> > e608e11a82d994e183d%7C0%7C0%7C637267016987033430&amp;sdata=R%
> > 2F%2BY%2B
> > >
> > z%2BKHh09WazkQqS%2FbwH%2BeBM97%2Fx5hvqWAjUYEtM%3D&amp;res
> > erved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
